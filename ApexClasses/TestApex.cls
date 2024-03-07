/**
 * @description       : 
 * @author            : Ichwan Sholihin
 * @group             : 
 * @last modified on  : 03-07-2024
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public class TestApex {
    
    //create object custom for book before
    @InvocableMethod
    public static void applyDiscount(Book__c[] books) {
        for (Book__c b : books) {
            b.Price__c *= 0.9;
        }
    }
}