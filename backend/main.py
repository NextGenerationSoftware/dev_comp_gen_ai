from fastapi import FastAPI
from models import GeminiRequest
from llm.google_gemini import GeminiAPI


app = FastAPI()

@app.get("/")
async def root():
    return {"message": "Hello World"}


@app.post("/gemini")
async def gemini(request: GeminiRequest):
    res = GeminiAPI().gemini_flash(image_path=request.img_path, prompt=request.prompt)

    return {"response": res, "prompt": request.prompt, "image_path": request.img_path, "text": res.text}  

# Run the FastAPI server
