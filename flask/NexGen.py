from flask import Flask, render_template, request
from flask_sqlalchemy import SQLAlchemy

app = Flask(__name__)
# app.config["SQLALCHEMY_DATABASE_URI"] = (
#     "mysql://NexGen_Admin:admin@18.210.14.47/NexGen_contact_form"
# )

app.config["SQLALCHEMY_DATABASE_URI"] = "mysql://admin:admin@localhost/nexgen"

db = SQLAlchemy(app)


class Contact(db.Model):
    """
    Represents a contact in the application.

    Attributes:
        id (int): The unique identifier for the contact.
        name (str): The name of the contact.
        email (str): The email address of the contact.
        message (str): The message sent by the contact.
    """

    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100), nullable=False)
    email = db.Column(db.String(120), nullable=False)
    message = db.Column(db.String(1000), nullable=False)

    def __init__(self, name, email, message):
        self.name = name
        self.email = email
        self.message = message

    def __repr__(self):
        return "<Contact %r>" % self.name


with app.app_context():
    db.create_all()


@app.route("/home")
@app.route("/")
def index():
    return render_template("index.html")


@app.route("/about")
def about():
    return render_template("about.html")


@app.route("/contact")
def contact():
    return render_template("contact.html")


@app.route("/services")
def services():
    return render_template("services.html")


@app.route("/submit_contact", methods=["POST"])
def submit_contact():
    """
    Process the submitted contact form data.
    Retrieves the name, email, and message from the submitted form data.
    """
    name = request.form.get("name")
    email = request.form.get("email")
    message = request.form.get("message")

    new_contact = Contact(name=name, email=email, message=message)

    db.session.add(new_contact)
    db.session.commit()

    first_name = name.split(" ")[0]
    if (
        first_name.lower() == "mariam"
        and email.lower() == "mariamhussein192003@gmail.com"
    ):
        return render_template("thank_you.html")
    else:
        return f"Thank you {first_name} , Form submitted successfully! "


if __name__ == "__main__":
    app.run(debug=True, port=5000)
