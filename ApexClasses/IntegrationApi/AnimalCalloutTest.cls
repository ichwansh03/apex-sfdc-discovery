/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 04-28-2024
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
@isTest
public class AnimalsCalloutTest {

    @isTest static void testGetCallout(){
        //create the mock response based on a static resource
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('GetAnimalResource');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type','application/json;charset=UTF-8');
        //associate the callout with a mock response
        Test.setMock(HttpCalloutMock.class, mock);
        //call method to test
        HttpResponse result = AnimalsCallout.makeGetCallout();
        //verify mock response is not null
        Assert.areNotEqual(null, result, 'the callout returned a null response');
        //verify status code
        Assert.areEqual(200, result.getStatusCode(), 'the status code is not 200');
        //verify content type
        Assert.areEqual('application/json;charset=UTF-8', result.getHeader('Content-Type'), 'the content type value is not expected');
        //verify the array contains 3 items
        Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(result.getBody());
        List<Object> animals = (List<Object>) results.get('animals');
        Assert.areEqual(3, animals.size(), 'the array should only contain 3 items');
    }
    
    @isTest static void testPostCallout() {
        Test.setMock(HttpCalloutMock.class, new AnimalsHttpCalloutMock());
        //this causes a fake response to be sent from the class that implements HttpCalloutMock
        HttpResponse response = AnimalsCallout.makePostCallout();
        //verify that the response received contains fake values
        String contentType = response.getHeader('Content-Type');
        Assert.isTrue(contentType == 'application/json');
        String actualValue = response.getBody();
        System.debug(response.getBody());
        String expectedValue = '{"animals": ["majestic badger", "fluffy bunny", "mighty moose"]}';
        Assert.areEqual(expectedValue, actualValue);
        Assert.areEqual(200, response.getStatusCode());
    }
}