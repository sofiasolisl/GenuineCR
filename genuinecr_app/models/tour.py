from genuinecr_app.config.mysqlconnection import connectToMySQL
from flask import flash

class Tour:
    def __init__(self, data):
        self.id=data['id']
        self.name=data['name']
        self.location = data['location']
        self.description = data['description']
        self.price = data['price']
        self.person_min = data['person_min']
        self.includes = data['includes']
        self.bring = data['bring']
        self.departure_time=data['departure']
        self.return_time=data['return']
        self.created_at = data['created_at']
        self.updated_at = data['updated_at']
        self.img=data['img']
        self.min_age=data['min_age']

 
    @classmethod
    def getAll (cls):
        query="SELECT * FROM tours;"
        results=connectToMySQL('oaerflmy_crauthentic').query_db(query)
        tours=[]
        for tour in results:
            tours.append(cls(tour))
        return tours
    @classmethod
    def getbyType (cls,type):
        query=f"SELECT * FROM tours WHERE tour_type_id1={type}"
        results=connectToMySQL('oaerflmy_crauthentic').query_db(query)
        tours=[]
        for tour in results:
            tours.append(cls(tour))
        return tours
    @classmethod
    def getType (cls,type_id):
        query=f"SELECT * FROM tour_type WHERE id={type_id}"
        results=connectToMySQL('oaerflmy_crauthentic').query_db(query)
        return results
        
    @classmethod
    def getId (cls,id):
        query="SELECT * FROM tours WHERE id = %(id)s"
        data={
            'id':id
        }
        result=connectToMySQL('oaerflmy_crauthentic').query_db(query,data)
        #print("Result", result)
        if len(result)>0:
            return cls(result[0])
        else:
            return None