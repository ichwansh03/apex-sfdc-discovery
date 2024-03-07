/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 03-07-2024
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
trigger TestTrigger on Book__c (before insert) {
    Book__c[] books = Trigger.new;
    TestApex.applyDiscount(books);
}