/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 03-07-2024
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
@isTest
public class DmlSampleTest {

    public static testMethod void testUpsertLeads() {
        List<Lead> leads = new List<Lead>();
      
        for(Integer i = 0; i < 10; i++) {
            leads.add(new Lead(LastName = 'testLead', Company = 'testCompany'));
        }

        Test.startTest();

        List<Database.upsertResult> results = DmlSamples.upsertLeads(leads);

        Test.stopTest();

        Set<Id> ids = new Set<Id>();

        for(Database.upsertResult result: results) {
                  System.assert(result.isSuccess());
            ids.add(result.getId());
        }

        for(Lead l:[SELECT Id, (SELECT Subject FROM Tasks) FROM Lead WHERE Id IN :ids]) {
            System.assertEquals(1, l.tasks.size());
        }

    }

}