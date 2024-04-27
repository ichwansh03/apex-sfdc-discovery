/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 04-27-2024
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public class GetRestApi {
    
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
}