/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 03-08-2024
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
@isTest
public class JobSharingTest {

    static testMethod void testManualShareRead() {
        //select user for the test
        List<User> users = [SELECT Id FROM User WHERE IsActive = true LIMIT 2];
        Id user1Id = users[0].Id;
        Id user2Id = users[1].Id;

        //create new job
        Job__c j = new Job__c();
        j.Name = 'Test Job';
        j.OwnerId = user1Id;
        insert j;

        //insert manual share for user who is not record owner
        System.assertEquals(JobSharing.manualShareRead(j.Id, user2Id), true);

        //query job sharing records
        List<Job__Share> jShr = [SELECT Id, UserOrGroupId, AccessLevel, RowCause FROM job__share WHERE ParentId = :j.Id AND UserOrGroupId = :user2Id];

        //test for only one manual share on job
        System.assertEquals(jShr.size(), 1);

        //test attribute of manual share
        System.assertEquals(jShr[0].AccessLevel, 'Read');
        System.assertEquals(jShr[0].RowCause, 'Manual');
        System.assertEquals(jShr[0].UserOrGroupId, user2Id);

        //test invalid job Id
        delete j;

        //insert manual share for deleted job Id
        System.assertEquals(JobSharing.manualShareRead(j.Id, user2Id), false);
    }
}