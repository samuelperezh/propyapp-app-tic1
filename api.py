from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
import pickle
import pandas as pd

# Cargar el modelo serializado
filename = 'data/modelo-PropyApp.pkl'
modelTree, variables = pickle.load(open(filename, 'rb'))

class Propiedad(BaseModel):
    area: int
    rooms: int
    garages: int
    stratum: str
    property_type: str
    baths: int
    neighbourhood: str
    city: str

# Crear la API con FastAPI
app = FastAPI()

# Añadir el CORS middleware
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Permitir todos los orígenes
    allow_credentials=True,
    allow_methods=["*"],  # Permitir todos los métodos
    allow_headers=["*"],  # Permitir todos los headers
)

# Definir el endpoint para la predicción de la API
@app.post('/predecir')
async def predecir(item:Propiedad):
    # Obtener los valores de las variables
    data = pd.DataFrame ([item.dict().values()], columns=item.dict().keys())
    data = pd.get_dummies(data, columns=['stratum','property_type','neighbourhood','city'], drop_first=False, dtype='int64')
    data = data.reindex(columns=variables, fill_value=0)
    
    # Hacer una predicción usando el modelo
    prediccion = modelTree.predict(data)

    # Devolver la predicción como un JSON
    return {"prediccion": int(prediccion)}