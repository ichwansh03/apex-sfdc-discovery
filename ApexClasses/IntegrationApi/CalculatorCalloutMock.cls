/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 04-28-2024
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
@isTest
global class CalculatorCalloutMock implements WebServiceMock {
    
    global void doInvoke(
    	Object stub,
        Object request,
        Map<String, Object> response,
        String endPoint,
        String soapAction,
        String requestName,
        String responseNS,
        String responseName,
        String responseType) {
            //start - specify the response you want to send
            calculatorServices.doAddResponse response_x = new calculatorServices.doAddResponse();
            response_x.return_x = 3.0;
            //end
            response.put('response_x', response_x);
        }

}