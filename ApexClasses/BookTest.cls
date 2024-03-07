/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 03-07-2024
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
@IsTest
public class BookTest {

    @IsTest(seeAllData=true)
    static void validateBook() {
        Book__c b = new Book_c(Name='Behind the cloud', Price__c=100);
        System.debug('Price before inserting new book: '+b.Price__c);

        //insert
        insert b;

        //retrieve the new book
        b = [SELECT Price__c FROM Book__c WHERE Id =:b.Id];
        System.debug('Price after trigger fired: '+b.Price__c);

        //test that the trigger correctly updated the price
        System.assertEquals(90, b.Price__c);
    }
}