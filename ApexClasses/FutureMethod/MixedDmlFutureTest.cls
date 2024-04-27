/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 04-27-2024
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
@isTest
public class MixedDMLFutureTest {

    @isTest static void testFuture() {
        User thisUser = [SELECT Id FROM User WHERE Id = :UserInfo.getUserId()];
        //runAs() allows mixed DML operations in test ctx
        System.runAs(thisUser) {
            Test.startTest();
            MixedDMLFuture.useFutureMethod();
            Test.stopTest();
        }
        //future method will run after stopTest()
        Account[] accts = [SELECT Id FROM Account WHERE Name = 'Acme'];
        System.assertEquals(1, accts.size());
        //verify user is inserted
        User[] users = [SELECT Id FROM User WHERE username='ichwan.sholihin@amfs.com'];
        System.assertEquals(1, users.size());
    }
}