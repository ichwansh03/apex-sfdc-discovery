/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 04-27-2024
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public class RestHttp {
    
    static void getAnimals() {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals');
        request.setMethod('GET');
        HttpResponse response = http.send(request);

        //if the request is successfull, parse the JSON response
        if(response.getStatusCode() == 200) {
            //deserialize the JSON string into collections of primitive data types
            Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
 	        //cast the values in the 'animals' key as a list
            List<Object> animals = (List<Object>) results.get('animals');
            System.debug('Recevied the following animals:');
            
            for (Object animal : animals){
                System.debug(animal);
            }
        }
    }

    static void createAnimals() {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals');
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');
        //set the body as a JSON object
        request.setBody('{"name":"garuda"}');

        HttpResponse response = http.send(request);
        //parse the JSON response
        if(response.getStatusCode() == 201) {
            System.debug(response.getBody());
        } else {
            System.debug('the status code returned was not expected: '+response.getStatusCode()+' : '+response.getStatus());
        }

    }
}