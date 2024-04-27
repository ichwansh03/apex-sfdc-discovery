/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 04-27-2024
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public class MixedDMLFuture {

    public static void useFutureMethod() {
        //first DML operation
        Account a = new Account(Name='Acme');
        insert a;
        
        //this next opt (insert a user with role)
        //can't be mixed with prev insert unless its within a future method
        Util.insertUserWithRole('ichwan.sholihin@amfs.com', 'ichwan', 'ichwan@amfs.com', 'Sholihin');
    }
}