from fastapi import FastAPI
from models import GeminiRequest
from llm.google_gemini import GeminiAPI
from database.firebase_handler import Database
from utils import extract_json_from_response
import json
import urllib.parse


app = FastAPI()
db = Database()
g = GeminiAPI()

@app.get("/")
async def root():
    return {"message": "Hello World"}


@app.post("/evaluate_picture")
async def gemini(request: GeminiRequest):
    img_decoded =  urllib.parse.unquote(request.img_path)
    res = g.gemini_flash(image_path=img_decoded, prompt=request.prompt)
    
    # Fetch the necessary data from the database
    data_required = db.get_data_required()
    description_point_mapping = [{"description": data.description, "points": data.pointcat} for data in data_required]
    points_cat = db.get_points_categories()
    print(data_required)
    print(points_cat)


    prompt = """
    You found the following objects in the picture: {res}. We are interested in specific items as described in the following point mapping: {description_point_mapping}. For each matching item, please do the following:

    1. Assign Points: Use the point categories in the mapping to determine the appropriate points for each item found.
    2. Create a Headline: For each matching item, generate a headline that encourages the user to take a photo if the item matches what we are looking for.
    3. Provide a Description: Write a creative, engaging one-sentence description for each matching item.

    Please return the results in JSON format with the following structure:

    ```json
    {{
        "findings": [
            {{
                "finding_headline": "Your headline here",
                "finding_text": "Your description here",
                "points": Your points here
            }},
            ...
        ]
    }}
    ```

    If multiple items are found, return a list of objects, each containing the headline, description, and points for each item.
    """.format(res=res, description_point_mapping=description_point_mapping)

    response = g.generate_content(prompt=prompt)

    # Extract the JSON string from the response
    json_text = extract_json_from_response(response)

    # Parse the JSON string into a dictionary
    try:
        findings_data = json.loads(json_text)
    except json.JSONDecodeError as e:
        print(f"Error decoding JSON: {e}")
        findings_data = {}


    return {"response": res, "prompt": request.prompt, "image_path": request.img_path, "text": findings_data} 


@app.post("/get_label_and_points")
async def get_label_and_points(request: GeminiRequest):
    img_decoded =  urllib.parse.unquote(request.img_path)
    res = g.gemini_flash(image_path=img_decoded, prompt=request.prompt)

    # Fetch the necessary data from the database
    data_required = db.get_data_required()
    description_point_mapping = [{"description": data.description, "points": data.pointcat} for data in data_required]
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
                    "points": Your points here
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