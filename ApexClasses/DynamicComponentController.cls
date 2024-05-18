/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 05-18-2024
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public class DynamicComponentController {

    public DynamicComponentController(ApexPages.StandardController con) { }
    
    public Component.Apex.SectionHeader getHeaderWithDueDateCheck() {
      date dueDate = date.newInstance(2023, 24, 3);
        boolean overdue = date.today().daysBetween(dueDate) < 0;
        
        Component.Apex.SectionHeader sectionHeader = new Component.Apex.SectionHeader();
        if (overdue) {
            sectionHeader.title = 'This form was due on '+dueDate.format()+'!';
            return sectionHeader;
        } else {
            sectionHeader.title = 'Form Submission';
            return sectionHeader;
        }
    }
}