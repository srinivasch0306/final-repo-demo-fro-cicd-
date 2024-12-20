trigger EmployeeInfoComplianceLockTrigger on Employee_Information__c (before update) {
    for (Employee_Information__c record : Trigger.new) {
        Employee_Information__c oldRecord = Trigger.oldMap.get(record.Id);
        
        if (oldRecord.Credentials_logged_out__c == true) {
            Boolean isOnlyCredentialsFieldChanged = true;
            
            SObjectType objType = Schema.getGlobalDescribe().get('Employee_Information__c');
            Map<String, Schema.SObjectField> fieldsMap = objType.getDescribe().fields.getMap();
            
            for (String fieldName : fieldsMap.keySet()) {
                Schema.SObjectField field = fieldsMap.get(fieldName);
                
                if (field.getDescribe().isUpdateable()) {
                    if (field != Schema.Employee_Information__c.Credentials_logged_out__c && 
                        record.get(field) != oldRecord.get(field)) {
                        isOnlyCredentialsFieldChanged = false;
                        break;
                    }
                }
            }
            
            if (!isOnlyCredentialsFieldChanged) {
                record.addError('This record is locked. Only the Credentials Logged Out field can be modified.');
            }
        }
    }
}