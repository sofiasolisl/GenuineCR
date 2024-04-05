# __init__.py
from flask import Flask
from flask_cors import CORS
app = Flask(__name__)
CORS(app) ###########To avoid issues with blocked by CORS policy

app.secret_key = "my secret key" 