from flask import Flask, render_template

app = Flask(__name__)


@app.route("/home")
@app.route("/")
def index():
    return render_template("base.html")


def about():
    return render_template("about.html")


def contact():
    return render_template("contact.html")


def services():
    return render_template("services.html")


if __name__ == "__main__":
    app.run(debug=True)
