from pydantic import BaseModel


class DatasetModel(BaseModel):
    name: str

class DATAREQUIREDModel(BaseModel):
    customerid: str
    description: str
    id: str
    pointcat: int