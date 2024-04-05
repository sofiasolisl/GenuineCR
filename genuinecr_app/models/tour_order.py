from genuinecr_app.config.mysqlconnection import connectToMySQL
from flask import flash

class Tour_Order:
    def __init__(self, data):
        self.id=data['id']
        self.customer_id=data['customer_id']
        self.tour_id = data['tour_id']
        self.people_qty = data['people_qty']
        self.tour_date = data['tour_date']
        self.created_at = data['created_at']
        self.updated_at = data['updated_at']

    @classmethod
    def getAll (cls):
        query="SELECT * FROM tour_orders;"
        results=connectToMySQL('oaerflmy_crauthentic').query_db(query)
        tour_orders=[]
        for tour_order in results:
            tour_orders.append(cls(tour_order))
        return tour_orders
        
    @classmethod
    def getId (cls,id):
        query="SELECT * FROM tour_orders WHERE id = %(id)s"
        data={
            'id':id
        }
        result=connectToMySQL('oaerflmy_crauthentic').query_db(query,data)
        #print("Result", result)
        if len(result)>0:
            return cls(result[0])
        else:
            return None
    @classmethod
    def getTourDetailsById (cls,id):
        query=f"SELECT * FROM tour_orders LEFT JOIN customers on customers.id=tour_orders.customer_id LEFT JOIN tours on tours.id=tour_orders.tour_id WHERE tour_orders.id = {id};"
        result=connectToMySQL('oaerflmy_crauthentic').query_db(query)
        #print("Result", result)
        if len(result)>0:
            return result[0]
        else:
            return None
    @classmethod
    def save(cls, data):
        query = "INSERT INTO tour_orders ( people_qty,tour_date, customer_id, tour_id, created_at, updated_at) VALUES (%(people_qty)s, %(tour_date)s, %(customer_id)s, %(tour_id)s, NOW(),NOW());"
        mysql = connectToMySQL('oaerflmy_crauthentic')
        result = mysql.query_db(query, data)
        #print("el id es",result)
        return result
    @staticmethod
    def validations(route):
        is_valid=True
        if route['people_qty'] == "":
            flash('Specify number of participants')
            is_valid=False
        if route['date'] == "":
            flash('Specify date of tour')
            is_valid=False
        return is_valid