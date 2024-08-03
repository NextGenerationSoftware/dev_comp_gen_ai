
import re

def extract_json_from_response(response):
    # Find JSON-like structure in the response
    match = re.search(r'\{[\s\S]*\}', response)
    if match:
        return match.group(0)
    else:
        raise ValueError("No JSON-like structure found in the response")