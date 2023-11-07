from fastapi import FastAPI
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

# Create a Flask app
app = FastAPI()

# Define the endpoint for the API
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