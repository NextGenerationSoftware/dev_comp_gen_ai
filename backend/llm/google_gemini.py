import google.generativeai as genai
import PIL.Image
from io import BytesIO
import requests
import os

class GeminiAPI:

    def __init__(self, api_key: str = None) -> None:
        self.api_key = api_key if api_key else os.getenv('GOOGLE_GEMINI_API_KEY')
        genai.configure(api_key=self.api_key)
    
    @staticmethod
    def load_image_from_url(image_path: str) -> PIL.Image:
        response = requests.get(image_path)
        img_data = BytesIO(response.content)
        return PIL.Image.open(img_data)

    def gemini_flash(self, image_path: str, prompt: str = "What is in this photo?") -> str:
        img_bytes = GeminiAPI.load_image_from_url(image_path)
        model = genai.GenerativeModel(model_name="gemini-1.5-flash")
        response = model.generate_content([f"{prompt}", img_bytes])
        print(response)
        print(response.text)
        return response.text