import firebase_admin
from firebase_admin import firestore, credentials, db
from models import DatasetModel


class Database:

    def __init__(self) -> None:
        cred = credentials.Certificate('firebase.json')
        firebase_admin.initialize_app(cred)
        self.db = firestore.client()

    def get_datasets(self):
        doc_ref = self.db.collection('datasets')
        doc = doc_ref.get()
        datasets = [DatasetModel(**dataset.to_dict()) for dataset in doc]
        return datasets
    

if __name__ == "__main__":
    db = Database()
    print(db.get_datasets())
    
