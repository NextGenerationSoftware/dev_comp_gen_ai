from fastapi import FastAPI
from fastapi.exceptions import HTTPException
import json
import urllib.parse

from models import GeminiRequest
from llm.google_gemini import GeminiAPI
from database.firebase_handler import Database
from utils import extract_json_from_response



app = FastAPI()
db = Database()
g = GeminiAPI()

@app.get("/")
async def root():
    return {"message": "Hello World"}

@app.post("/evaluate_picture")
async def evaluate_picture(request: GeminiRequest):
    try:
        img_decoded = urllib.parse.unquote(request.img_path)
        img = request.img_path

        # Step 1: Object Detection
        detection_prompt = "List all unique objects you can see in this image. Be specific and thorough, but do not list the same type of object multiple times."
        detected_objects = g.gemini_flash(image_path=img, prompt=detection_prompt)

        # Fetch the necessary data from the database
        data_required = db.get_data_required()
        description_point_mapping = [{"title": data.title, "description": data.description, "points": data.pointcat, "id": data.id} for data in data_required]

        # Step 2: Matching and Filtering
        matching_prompt = f"""
        You detected the following objects in the image: {detected_objects}
        
        We are interested in specific items as described in the following mapping: {description_point_mapping}
        
        Please identify which detected objects match our items of interest. Each detected object should only be matched once to the most relevant item in our mapping. Return the results as a JSON list of matched items with their corresponding IDs from our mapping.
        
        Example format:
        {{
            "matched_items": [
                {{"detected_object": "plastic bottle", "matched_id": "recycling_123"}},
                {{"detected_object": "reusable bag", "matched_id": "sustainable_456"}}
            ]
        }}
        """
        matching_response = g.generate_content(prompt=matching_prompt)
        
        json_str = extract_json_from_response(matching_response)
        json_str = json_str.strip()
        if not json_str.startswith('{'):
            json_str = '{' + json_str
        if not json_str.endswith('}'):
            json_str = json_str + '}'
        
        matched_items = json.loads(json_str)

        if 'matched_items' not in matched_items:
            raise ValueError("Expected 'matched_items' key not found in JSON response")

        # Step 3 & 4: Point Assignment and Content Generation
        findings = []
        processed_objects = set()  
        for item in matched_items["matched_items"]:
            if item["detected_object"] not in processed_objects:
                processed_objects.add(item["detected_object"])
                item_details = next((x for x in description_point_mapping if x["id"] == item["matched_id"]), None)
                if item_details:
                    content_prompt = f"""
                    Generate unique content for the detected item: {item["detected_object"]}
                    Item description: {item_details["description"]}
                    
                    1. Create a Headline: Generate a headline that encourages the user to take a photo if the item matches what we are looking for. Focus on environmental or social impact. No icons or smilies.
                    2. Provide a Description: Write a creative, engaging one-sentence description emphasizing how this picture would impact our society or environment positively by contributing to open-source data.
                    
                    Return the results in this format:
                    {{
                        "finding_headline": "Your headline here",
                        "finding_text": "Your description here"
                    }}
                    """
                    content_response = g.generate_content(prompt=content_prompt)
                    content_json = extract_json_from_response(content_response)
                    content = json.loads(content_json)
                    
                    findings.append({
                        "finding_headline": content["finding_headline"],
                        "finding_text": content["finding_text"],
                        "points": item_details["points"],
                        "datarequired_id": item["matched_id"]
                    })

        return {
            "detected_objects": detected_objects,
            "matched_items": matched_items,
            "findings": findings
        }

    except json.JSONDecodeError as e:
        raise HTTPException(status_code=500, detail=f"Error decoding JSON: {str(e)}")
    except ValueError as e:
        raise HTTPException(status_code=500, detail=str(e))
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"An unexpected error occurred: {str(e)}")


@app.post("/get_label_and_points")
async def get_label_and_points(request: GeminiRequest):
    img_decoded =  urllib.parse.unquote(request.img_path)
    img = request.img_path
    res = g.gemini_flash(image_path=img, prompt=request.prompt)

    # Fetch the necessary data from the database
    data_required = db.get_data_required()
    description_point_mapping = [{"title": data.title, "description": data.description, "points": data.pointcat} for data in data_required]
    points_cat = db.get_points_categories()

    prompt = """
    You found the following objects in the picture: {res}. We are interested in specific items as described in the following point mapping: {description_point_mapping}. For each matching item, please do the following:
    This is out points-category mapping: {points_cat}
    1. Assign Points: Use the point categories in the mapping to determine the appropriate points for each item found.
    2. Create a Label: For each matching item, generate a label matching the mapping we provided.


    Please return the results in JSON format with the following structure:
    
        ```json
        {{
            "findings": [
                {{
                    "label": "Your label here",
                    "points": Your points here,
                }},
                ...
            ]
        }}
    
    If multiple items are found, return a list of objects, each containing the headline, description, and points for each item.
    """.format(res=res, points_cat=points_cat, description_point_mapping=description_point_mapping)

    response = g.generate_content(prompt=prompt)

    # Extract the JSON string from the response
    json_text = extract_json_from_response(response)

    # Parse the JSON string into a dictionary
    try:
        findings_data = json.loads(json_text)
    except json.JSONDecodeError as e:
        print(f"Error decoding JSON: {e}")
        findings_data = {}


    return {"response": res, "image_path": request.img_path, "findings": findings_data}




@app.get("/datasets")
async def datasets():
    pass

@app.post("/datasets")
async def datasets(request: GeminiRequest):
    res = GeminiAPI().get_datasets()

    return {"response": res, "prompt": request.prompt, "image_path": request.img_path, "text": res.text}