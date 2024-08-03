import { clsx } from "clsx";
import { twMerge } from "tailwind-merge";
import { getFirestore, doc, getDoc, getDocs, collection } from "firebase/firestore";
import { initializeApp, getApps } from "firebase/app";

export const cn = (...inputs) => twMerge(clsx(inputs));

let firebase_app;
let db;

const firebaseConfig = {
  apiKey: process.env.NEXT_PUBLIC_FIREBASE_API_KEY,
  authDomain: process.env.NEXT_PUBLIC_FIREBASE_AUTH_DOMAIN,
  projectId: process.env.NEXT_PUBLIC_FIREBASE_PROJECT_ID,
  storageBucket: process.env.NEXT_PUBLIC_FIREBASE_STORAGE_BUCKET,
  messagingSenderId: process.env.NEXT_PUBLIC_FIREBASE_MESSAGING_SENDER_ID,
  appId: process.env.NEXT_PUBLIC_FIREBASE_APP_ID,
};

export const firebaseInit = () => {
  if (firebase_app) return db;

  firebase_app = getApps().length === 0 ? initializeApp(firebaseConfig) : getApps()[0];
  db = getFirestore(firebase_app);
  return db;
};

export const getDocData = async (collectionName, docId) => {
  const database = firebaseInit();
  const docRef = doc(database, collectionName, docId);
  const docSnap = await getDoc(docRef);

  if (docSnap.exists()) {
    return docSnap.data();
  } else {
    console.log("No such document!");
    return null;
  }
};

export const getCollectionData = async (collectionName) => {
  try {
    const database = firebaseInit();
    if (!database) {
      throw new Error("Firebase database not initialized");
    }

    const collectionRef = collection(database, collectionName);
    const querySnapshot = await getDocs(collectionRef);

    if (querySnapshot.empty) {
      console.log(`No documents found in collection ${collectionName}`);
      return [];
    }

    const data = querySnapshot.docs.map(doc => ({ id: doc.id, ...doc.data() }));
    console.log(`Retrieved ${data.length} documents from ${collectionName}:`, data);
    return data;
  } catch (error) {
    console.error(`Error fetching collection ${collectionName}:`, error);
    throw error;
  }
};