/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 03-07-2024
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public class DmlSamples {

    public static List<Database.upsertResult> upsertLeads(List<Lead> leads) {

        List<Database.upsertResult> uResults = Database.upsert(leads, false);

        List<Task> tasks = new List<Task>();
        for(Database.upsertResult result: uResults) {
            if (result.isSuccess() && result.isCreated())
                tasks.add(new Task(Subject = 'Follow-up', WhoId = result.getId()));
        }

        Database.insert(tasks);

        return uResults;

    }

    public static void transactionData() {
        Account a = new Account(Name='ichwansh');

        insert a;

        Assert.isNull([SELECT Name FROM Account WHERE Id = :a.Id].Name);

        //create savepoint while Name is null
        SavePoint sp = Database.setSavePoint();

        //change account number
        a.Name = '123';

        update a;

        Assert.areEqual('123', [SELECT Name FROM Account WHERE Id = :a.Id].Name);

        //rollback to the previous null value
        Database.rollback(sp);

        Assert.isNull([SELECT Name FROM Account WHERE Id = :a.Id].Name);

    }

   
    public static void loopsData(){

        Savepoint sp = Database.setSavePoint();

        insert new Account[]{new Account(Name = 'yyy'),
                                    new Account(Name = 'yyy'),
                                    new Account(Name = 'yyy')};

        //the single sObject format executes the for loop once per returned record
        Integer i = 0;

        for(Account tmp : [SELECT Id FROM Account WHERE Name = 'yyy']) {
            i++;
        }

        //since there were 3 accounts named 'yyy' in the db, the loop executed 3 times
        System.assert(i == 3);

        Database.rollback(sp);

    }


    //One common usage of this map type is for in-memory “joins” between two tables.
    public static void mapEntriesData() {

        //populate map from SOQL Query
        Map<ID, Account> m = new Map<ID, Account>([SELECT Id, Name FROM Account LIMIT 10]);

        //after populating the map, iterate through the map entries
        for (ID idKey : m.keyset()) {
            Account a = m.get(idKey);
            System.debug(a);
        }

    }

}