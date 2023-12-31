import flask
from flask_cors import CORS

APP = flask.Flask(__name__)
cors = CORS(APP)

@APP.get("/")
def index(): return flask.render_template("index.html")

if __name__ == "__main__": APP.run(port=3000, host="0.0.0.0")