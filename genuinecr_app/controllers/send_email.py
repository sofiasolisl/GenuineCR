from email.message import EmailMessage
import ssl
import smtplib
from .  import account_password
from email.utils import formataddr
from email.header import Header

 
def send_confirmation_email(reciever, details):
    email_sender='info@genuinecr.com' 
    email_password=account_password.password
    email_reciever=f"{reciever[0]}, {reciever[1]}"
    subject = f"Shuttle reservation request has been received - Confirmation Pending"
    body=f"""Dear {details['fname']},

Your shuttle reservation request has been received. We will get back at you as soon as possible. Below are the details of your reservation request:

    From: {details['from']}
    To: {details['to']}
    Date: {details['date']}
    Passengers: {details['passengers']}
    Suitcases: {details['suitcases']}
    Pick-up Hour: {details['hour']}


Thank you for choosing us as your transportation service. We're committed to providing you with a safe and comfortable journey to your destination. Should you have any questions or need to make any changes to your reservation, please don't hesitate to contact us at info@genuinecr.com.

We look forward to serving you and ensuring you have a smooth and enjoyable travel experience.

Safe travels!

Best regards,

Genuine Costa Rica
+506 85714708
www.genuinecr.com
"""
    em=EmailMessage()
    em['From']=formataddr((str(Header('Genuine Costa Rica', 'utf-8')),'info@genuinecr.com')) 
    em['To']=email_reciever
    em['Subject']=subject
    em.set_content(body)

    context=ssl.create_default_context()

    with smtplib.SMTP_SSL('mail.genuinecr.com', 465,context=context) as smtp: 
        smtp.login(email_sender,email_password)
        smtp.send_message(em)
    return "Email Sent!"

def send_message(reciever, details):
    email_sender='info@genuinecr.com'
    email_password=account_password.password
    email_reciever=reciever
    subject = f"New message from {details['fname']}"
    body=f""" 
    From: {details['fname']} {details['lname']}
    Email: {details['email']}
    Message: {details['message']}
"""
    em=EmailMessage()
    em['From']=email_sender
    em['To']=email_reciever
    em['Subject']=subject
    em.set_content(body)

    context=ssl.create_default_context()

    with smtplib.SMTP_SSL('mail.genuinecr.com', 465,context=context) as smtp: 
        smtp.login(email_sender,email_password)
        smtp.send_message(em)
    return 

def send_tour_confirmation_email(reciever, details):
    email_sender='info@genuinecr.com'
    email_password=account_password.password
    email_reciever=f"{reciever[0]}, {reciever[1]}"
    subject = f"Tour reservation request has been received - Confirmation Pending"
    body=f"""Dear {details['fname']},

Thank you for choosing Genuine Costa Rica for your upcoming tour experience. We have received your reservation request and will be reviewing it shortly. Please find the details of your reservation request below:

Tour: {details['name']}
Date: {details['tour_date']}
Participants: {details['people_qty']}
Price per person: {details['price']}

We appreciate your interest in our services. Our team is dedicated to ensuring a seamless and enjoyable experience for our valued customers. We will promptly confirm your reservation and provide you with the necessary details.

If you have any specific requirements, questions, or need to make changes to your reservation, feel free to reach out to us at info@genuinecr.com.

We look forward to the opportunity to serve you and provide you with an exceptional travel experience.


Best regards,

Genuine Costa Rica
+506 85714708
www.genuinecr.com
"""
    em=EmailMessage()
    em['From']=email_sender
    em['To']=email_reciever
    em['Subject']=subject
    em.set_content(body)

    context=ssl.create_default_context()

    with smtplib.SMTP_SSL('mail.genuinecr.com', 465,context=context) as smtp: 
        smtp.login(email_sender,email_password)
        smtp.send_message(em)
    return 