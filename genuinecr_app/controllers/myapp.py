from genuinecr_app import app
from genuinecr_app.models.location import Location
from genuinecr_app.models.route import Route
from genuinecr_app.models.price import Price
from genuinecr_app.models.customer import Customer
from genuinecr_app.models.order import Order
from genuinecr_app.models.tour import Tour
from genuinecr_app.models.tour_order import Tour_Order
from flask import render_template, redirect, request, session, jsonify
import requests
from requests.auth import HTTPBasicAuth
from . import send_email
from flask import flash
from datetime import time
from flask_cors import cross_origin

@app.route("/", methods = ['GET'])
def index():
        locations=Location.getAll()
        return render_template("index.html",locations=locations)

@app.route('/shuttle', methods=['GET', 'POST'])
def shuttle():
    if request.method == "POST":
        if session.get('shuttle')==None:
            form=dict(request.form)
        else:
            form=session.get('shuttle')
        if Route.validations(request.form):
            data={
                "from_location_id":request.form.get('from'),
                "to_location_id":request.form.get('to'),
            }
            
            route=Route.getByLocationsId(data)
            
            shuttle=Price.getLastPriceForRouteById(route.id)
            shuttle['passengers']=form.get('passengers')
            
            shuttle['date']=form.get('date')
            
            session['shuttle']=shuttle
            return redirect("/shuttle")
        else:
            return redirect ('/')
    else:
        locations=Location.getAll()
        shuttle=session['shuttle']
        
        return render_template('shuttle.html',locations=locations, shuttle=shuttle)

@app.route("/checkout", methods = ['GET','POST'])
def checkout():
    if request.method == "POST":
        form=dict(request.form)
        if Customer.validations(request.form) and Order.validations(request.form):
            session['shuttle']=request.form
            data={
                "from_location_id":form.get('from'),
                "to_location_id":form.get('to'),
            }
            route=Route.getByLocationsId(data).id
            session['prices_routes_id']=route
            price=Price.getLastPriceForRouteById(route)
            session['prices_idprices']=price['id']
            if Customer.getEmail(form['email']) == None:
                if Customer.getAll() == None:
                    form ['id']=1
                else:
                    form ['id']=len(Customer.getAll()) + 1
                Customer.save(form)
            else:
                customer=Customer.getEmail(form['email']) 
                form['id']=customer.id
                Customer.updateByID(form)
            session['customers_id']=form ['id']
            return redirect ('/checkout')
        else:
            locations=Location.getAll()
            data={
                "from_location_id":session.get('from'),
                "to_location_id":session.get('to')
            }
            route=Route.getByLocationsId(data)
            shuttle=Price.getLastPriceForRouteById(route.id)
            shuttle['passengers']=form.get('passengers')
            shuttle['date']=form.get('date')
            session['shuttle']=shuttle
            return redirect("/shuttle",locations=locations, shuttle=shuttle)
    else:
        shuttle=session['shuttle']
        data={
                "from_location_id":shuttle.get('from'),
                "to_location_id":shuttle.get('to'),
            }
        
        route=Route.getByLocationsId(data)
        price=Price.getLastPriceForRouteById(route.id)
        
        return redirect("/confirmation" )

@app.route('/confirmation', methods=["GET"])
def confirmation():
    
    data={}
    if Order.getAll() == None:
        data ['id']=1
    else:
        data ['id']=len(Order.getAll()) + 1
    data['passengers']=session['shuttle']['passengers']
    data['suitcases']=session['shuttle']['suitcases']
    data['hour']=session['shuttle']['hour']
    data['date']=session['shuttle']['date']
    data['prices_routes_id']=session['prices_routes_id']
    data['customers_id']=session['customers_id']
    data['prices_idprices']=session['prices_idprices']
    data['from']=Location.getId(session['shuttle']['from']).location
    data['to']=Location.getId(session['shuttle']['to']).location
    data['fname']=session['shuttle']['fname']
    Order.save(data)
    recievers=[f"{Customer.getId(data['customers_id']).email}",'info@genuinecr.com']
    send_email.send_confirmation_email(recievers, data)
    return render_template('confirmation.html', customer=session['shuttle']['fname'])

@app.route('/contact', methods=["GET", "POST"])
def contact():
    if request.method == "GET":
        return render_template('contact.html')
    else:
        data={}
        data['fname']=request.form['fname']
        data['lname']=request.form['lname']
        data['email']=request.form['email']
        data['message']=request.form['message']
        recievers=['info@genuinecr.com']
        send_email.send_message(recievers, data)
        flash('Your message has been send, we will get back at you as soon as possible. Thanks!')
        return redirect('/contact')
    
@app.route('/tours/<tour_type>')
def tours(tour_type):
    tours=Tour.getbyType(tour_type)
    tour_type=Tour.getType(tour_type)
    
    return render_template('tours.html', tours=tours,tour_type=tour_type[0])

@app.route('/tour_detail/<tour_id>')
def tour_detail(tour_id):
    tour=Tour.getId(tour_id)
    
    if tour.departure_time and tour.return_time:
        tour.departure_time=time.fromisoformat("0"+str(tour.departure_time)).strftime('%H:%M')
        tour.return_time=time.fromisoformat(str(tour.return_time)).strftime('%H:%M')
    
    return render_template('tour_details.html', tour=tour)

@app.route('/tour_order/<tour_id>', methods=['post'])
def tour_order(tour_id):
    
    if Customer.validations(request.form) and Tour_Order.validations(request.form):
        # Saving customer
        data={}
        data['fname']=request.form['fname']
        data['lname']=request.form['lname']
        data['email']=request.form['email']
        data['cellphone']=request.form['cellphone']
        if Customer.getEmail(data['email']) == None:
            if Customer.getAll() == None:
                data ['id']=1
            else:
                data ['id']=len(Customer.getAll()) + 1
            Customer.save(data)
        else:
            customer=Customer.getEmail(data['email']) 
            data['id']=customer.id
            Customer.updateByID(data)
        # Saving order
        order={}
        order['people_qty']=request.form['people_qty']
        order['tour_date']=request.form['date']
        order['tour_id']=tour_id
        order['customer_id']=customer.id
        
        order_id=Tour_Order.save(order)
        #Sending Email
        recievers=[f"{Customer.getId(order['customer_id']).email}",'info@genuinecr.com']
        details=Tour_Order.getTourDetailsById(order_id)
        
        send_email.send_tour_confirmation_email(recievers, details)
        
    return render_template('confirmation.html', customer=details['fname'])

@app.route('/team')
def team():
    return render_template("team.html")

@app.route('/dropdown_update/<from_id>', methods=["GET"])
def dropdown_update(from_id):
    route=Route.getByFromId(from_id)
    response = jsonify(route)
    response.headers.add('Access-Control-Allow-Origin', '*')
    return response

@app.route('/all_tours')
def all_tours():
    tours=Tour.getAll()
    return render_template('all_tours.html', tours=tours)