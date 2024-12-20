public with sharing class TimeSheetController {

    public class SelectOptionWrapper {
        @AuraEnabled
        public String label { get; set; }
        @AuraEnabled
        public String value { get; set; }

        public SelectOptionWrapper(String label, String value) {
            this.label = label;
            this.value = value;
        }
    }

    @AuraEnabled(cacheable=false)
    public static List<String> getDaysOfWeek() {
        return new List<String>{'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'};
    }

    @AuraEnabled(cacheable=false)
    public static List<SelectOptionWrapper> getEmployees() {
        List<SelectOptionWrapper> options = new List<SelectOptionWrapper>();
        try {
            for(SFDC_Employee__c emp : [SELECT Id, Name FROM SFDC_Employee__c]) {
                options.add(new SelectOptionWrapper(emp.Name, emp.Id));
            }
        } catch (Exception e) {
            System.debug('Error fetching employees: ' + e.getMessage());
        }
        return options;
    }

    @AuraEnabled(cacheable=false)
    public static List<SelectOptionWrapper> getWorkItems() {
        List<SelectOptionWrapper> options = new List<SelectOptionWrapper>();
        try {
            for(Master__c workItem : [SELECT Id, Name FROM Master__c]) {
                options.add(new SelectOptionWrapper(workItem.Name, workItem.Id));
            }
        } catch (Exception e) {
            System.debug('Error fetching work items: ' + e.getMessage());
        }
        return options;
    }

    @AuraEnabled
    public static void createTimeSheet(Id employeeId, Id workItemId, Date weekStartDate, Date weekEndDate, Map<String, Decimal> hours) {
        List<Time_Sheet__c> timeSheetsToCreate = new List<Time_Sheet__c>();
        List<String> daysOfWeek = getDaysOfWeek();
        
        Integer daysCount = weekEndDate.daysBetween(weekStartDate) + 1;
        
        for(Integer i = 0; i < daysCount; i++) {
            Time_Sheet__c newTimeSheet = new Time_Sheet__c();
            newTimeSheet.Employee__c = employeeId;
            newTimeSheet.Master__c = workItemId;
            newTimeSheet.Date__c = weekStartDate.addDays(i);
            newTimeSheet.Hours_Worked__c = hours.get(daysOfWeek[i]);
            timeSheetsToCreate.add(newTimeSheet);
        }
        
        if(!timeSheetsToCreate.isEmpty()) {
            insert timeSheetsToCreate;
        }
    }
}