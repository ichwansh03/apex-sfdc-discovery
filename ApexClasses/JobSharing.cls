/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 03-08-2024
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public class JobSharing {

    public static boolean manualShareRead(Id recordId, Id userOrGroupId) {
        //create custom object Job first
        Job__Share jobShr = new Job__Share();

        //set the ID of record being shared
        jobShr.ParentId = recordId;

        //set the ID of user or group being granted access
        jobShr.UserOrGroupId = userOrGroupId;

        //set the access level
        jobShr.AccessLevel = 'READ';

        //set rowCause to 'manual' for manual sharing
        //this line can be omitted as 'manual' is the default value for sharing objects
        jobShr.RowCause = Schema.Job__Share.RowCause.Manual;

        //insert the sharing record and capture the save result
        //the false parameter allows for partial processing if multiple records passed
        //into the operation
        Database.SaveResult sr = Database.insert(jobShr, false);

        //process the save result
        if (sr.isSuccess()) {
            return true;
        } else {
            Database.Error err = sr.getErrors()[0];

            //check if the error is related to trivial access level.
            //access level must be more permissive than the object default
            //these sharing records are not required and thus an insert exception is acceptable
            if (err.getStatusCode() == StatusCode.FIELD_FILTER_VALIDATION_EXCEPTION
            && err.getMessage().contains('AccessLevel')) {
                return true;
            }
            else {
                return false;
            }

        }
    }
}