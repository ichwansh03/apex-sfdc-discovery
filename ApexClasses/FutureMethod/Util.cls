/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 04-27-2024
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public class Util {

    @future
    public static void insertUserWithRole(
        String uname, String al, String em, String lname) {
        	
            Profile p = [SELECT Id FROM Profile WHERE Name = 'Standard User'];
            UserRole r = [SELECT Id FROM UserRole WHERE Name = 'COO'];
            
            User u = new User(alias = al, email=em, 
            emailencodingkey='UTF-8', lastname=lname, 
            languagelocalekey='en_US', 
            localesidkey='en_US', profileid = p.Id, userroleid = r.Id,
            timezonesidkey='America/Los_Angeles', 
            username=uname);
            u.Entity__c = 'AMFS';
            insert u;
        }
}