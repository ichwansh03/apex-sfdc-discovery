/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 05-18-2024
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public class DynamicCaseLoader {

    public final Case caseDetails {get; private set;}
    
    //SOQL query loads the case, with Case fields and related Contact fields
    public DynamicCaseLoader(ApexPages.StandardController controller) {
        String qid = ApexPages.currentPage().getParameters().get('id');
        String theQuery = 'SELECT Id, '+joinList(caseFieldList, ', ') + ' FROM Case WHERE Id = :qid';
        this.caseDetails = Database.query(theQuery);
    }
    
    //A list of fields to show on the Visualforce page
    public List<String> caseFieldList {
        get {
            if (caseFieldList == null) {
                caseFieldList = new List<String>();
                caseFieldList.add('CaseNumber');
                caseFieldList.add('Origin');
                caseFieldList.add('Status');
                caseFieldList.add('Contact.Name');
                caseFieldList.add('Contact.Email');
                caseFieldList.add('Contact.Phone');
            }
            return caseFieldList;
        }
        private set;
    }
    
    //join an Apex list of fields into a SELECT fields list string
    private static String joinList(List<String> theList, String separator) {
        if (theList == null) {
            return null;
        }
        if (separator == null) {
            separator = '';
        }
        
        String joined = '';
        Boolean firstItem = true;
        
        for (String item : theList) {
            if(null != item) {
                if(firstItem) {
                    firstItem = false;
                } else {
                    joined += separator;
                }
                joined += item;
            }
        }
        return joined;
    }
}