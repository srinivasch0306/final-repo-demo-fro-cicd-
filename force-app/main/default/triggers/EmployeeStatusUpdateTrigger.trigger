trigger EmployeeStatusUpdateTrigger on Employee_Information__c (before update) {
    for (Employee_Information__c record : Trigger.new) {
        Employee_Information__c oldRecord = Trigger.oldMap.get(record.Id);
        
        // Check if Credentials_logged_out__c is being checked
        if (record.Credentials_logged_out__c == true && 
            oldRecord.Credentials_logged_out__c == false) {
            
            // Automatically set status to 'ended'
            record.Status__c = 'ended';
        }
    }
}