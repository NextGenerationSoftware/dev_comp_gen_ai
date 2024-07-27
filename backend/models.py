from pydantic import BaseModel


class GeminiRequest(BaseModel):
    img_path: str
    prompt: str