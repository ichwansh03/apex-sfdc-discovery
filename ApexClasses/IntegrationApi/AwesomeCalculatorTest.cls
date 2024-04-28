/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 04-28-2024
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
@isTest
private class AwesomeCalculatorTest {

    @isTest static void testCallout() {
        //this causes a fake response to be generated
        Test.setMock(WebServiceMock.class, new CalculatorCalloutMock());
        //call the method that invokes a callout
        Double x = 1.0;
        Double y = 2.0;
        Double result = AwesomeCalculator.add(x, y);
        //verify that a fake result is returned
        Assert.areEqual(3.0, result);
    }
}