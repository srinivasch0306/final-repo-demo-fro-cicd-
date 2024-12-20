trigger UpdateAccountContactCount_Negative on Contact (after insert, after update, after delete) {
    List<Account> accountsToUpdate = new List<Account>();
    
    // Handle inserts and updates
    if (Trigger.isInsert || Trigger.isUpdate) {
        for (Contact con : Trigger.new) {
            for (Account acc : [SELECT Id, Number_of_Contacts__c FROM Account WHERE Id = :con.AccountId]) {
                acc.Number_of_Contacts__c	= (acc.Number_of_Contacts__c	 == null ? 0 : acc.Number_of_Contacts__c) + 1; // Increment count
                accountsToUpdate.add(acc);
            }
        }
    }

    // Handle deletes
    if (Trigger.isDelete) {
        for (Contact con : Trigger.old) {
            for (Account acc : [SELECT Id, Number_of_Contacts__c FROM Account WHERE Id = :con.AccountId]) {
                acc.Number_of_Contacts__c = (acc.Number_of_Contacts__c == null ? 0 : acc.Number_of_Contacts__c) - 1; // Decrement count
                accountsToUpdate.add(acc);
            }
        }
    }

    // Perform the update
    if (!accountsToUpdate.isEmpty()) {
        update accountsToUpdate;
    }
}