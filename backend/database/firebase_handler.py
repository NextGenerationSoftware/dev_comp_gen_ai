import firebase_admin
from firebase_admin import firestore, credentials, db
from database.models import DatasetModel, DATAREQUIREDModel


class Database:

    def __init__(self) -> None:
        cred = credentials.Certificate('database/firebase.json')
        firebase_admin.initialize_app(cred)
        self.db = firestore.client()

    def get_datasets(self):
        doc_ref = self.db.collection('datasets')
        doc = doc_ref.get()
        datasets = [DatasetModel(**dataset.to_dict()) for dataset in doc]
        return datasets

    def get_data_required(self):
        doc_ref = self.db.collection('DATAREQUIRED')
        doc = doc_ref.get()
        data_required = [DATAREQUIREDModel(**data.to_dict()) for data in doc]
        return data_required

    def get_points_categories(self):
        doc_ref = self.db.collection('GLOBAL')
        doc = doc_ref.get()[0].to_dict()
        pointscat = doc
        return pointscat
    

if __name__ == "__main__":
    db = Database()
    print(db.get_datasets())
    
