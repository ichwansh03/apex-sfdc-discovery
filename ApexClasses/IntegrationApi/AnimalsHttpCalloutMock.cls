/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 04-28-2024
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
@isTest
global class AnimalsHttpCalloutMock implements HttpCalloutMock {

    global HttpResponse respond(HttpRequest request) {
        //create a fake response
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type','application/json');
        response.setBody('{"animals": ["majestic badger", "fluffy bunny", "mighty moose"]}');
        response.setStatusCode(200);
        return response;
    }
}