import google.generativeai as genai
import PIL.Image
from io import BytesIO
import requests
import os
import json

# https://stackoverflow.com/questions/74522824/pil-unidentifiedimageerror-cannot-identify-image-on-this-specific-image
from PIL import ImageFile
ImageFile.LOAD_TRUNCATED_IMAGES=True

class GeminiAPI:

    def __init__(self, api_key: str = None) -> None:
        self.api_key = api_key if api_key else os.getenv('GOOGLE_GEMINI_API_KEY')
        genai.configure(api_key=self.api_key)
    
    @staticmethod
    def load_image_from_url(image_path: str) -> PIL.Image:
        response = requests.get(image_path)
        img_data = BytesIO(response.content)
        return PIL.Image.open(img_data)

    def gemini_flash(self, image_path: str, prompt: str = "What is in this photo? Only return the keywords of your findings. Don't repeat yourself.") -> str:
        img_bytes = GeminiAPI.load_image_from_url(image_path)
        model = genai.GenerativeModel(model_name="gemini-1.5-flash")
        response = model.generate_content([f"{prompt}", img_bytes])
        print(response)
        print(response.text)
        return response.text

    def generate_content(self, prompt: str) -> str:
        model = genai.GenerativeModel('gemini-1.5-flash')

        response = model.generate_content([prompt])

        return response.text


    @staticmethod
    def extract_json_from_text(text: str) -> dict:
        # Remove the triple backticks and the json formatting if present
        json_str = text.strip('```json').strip('```').strip()
        try:
            # Convert the cleaned string to a Python dictionary
            return json.loads(json_str)
        except json.JSONDecodeError as e:
            print(f"Error decoding JSON: {e}")
            return None
