
def extract_json_from_response(response: str) -> str:
    """
    Extracts and cleans the JSON string from the response text
    """

    json_text = response.strip('```json').strip('```').strip()
    return json_text