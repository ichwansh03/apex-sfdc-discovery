/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 03-08-2024
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public class InstanceValueReference extends StringWriter {

    public override void printString() {
        System.debug('change writer!');
    }

    public void mainValue() {
        String webUrl = 'www.amfs.com';

        System.debug('before value call '+webUrl);
        passByValue(webUrl);
        System.debug('after value call '+webUrl);
    }

    public void passByValue(String webUrl) {
        webUrl = 'www.axa.com';
    }

    public void mainReference() {
        Account a = new Account();
        a.Name = 'Abdul';
        a.Website = 'www.axa.com';

        System.debug('before reference call '+a);
        passByReference(a);
        System.debug('after reference call '+a);
    }

    public void passByReference(Account a) {
        a.Website = 'www.amfs.com';
    }

}