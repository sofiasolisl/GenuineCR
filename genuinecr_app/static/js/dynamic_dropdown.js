var from=document.getElementById("from");
var to=document.getElementById("to");

from.onchange=function(e){

    while (to.firstChild) {
        to.removeChild(to.lastChild);
    }
    to.innerHTML='<option disabled selected hidden>Select a location</option>'
    
    fetch("http://localhost:5000/dropdown_update/" + from.value,{method:"GET"})
            .then( response => response.json()
            )
            .then(data => {
                
                for(let i=0 ; i<data.length;i++){
                    let option=document.createElement('option');
                    option.value=data[i].to_location_id
                    option.text=data[i].to_location
                    to.add(option)
                }
                
                
            })
            .catch(error => {
                console.error('Error:', error);
            });
}