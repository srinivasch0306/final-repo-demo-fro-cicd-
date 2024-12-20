public class AccountUpdater {

    // Method to update the name of an Account based on its ID
    public static void updateAccountName(Id accountId, String newAccountName) {
        // Check if the account ID and name are not null
        if (accountId != null && String.isNotBlank(newAccountName)) {
            // Query the Account record using the provided Account ID
            Account acc = [SELECT Id, Name FROM Account WHERE Id = :accountId LIMIT 1];

            // Update the Account name
            acc.Name = newAccountName;

            // Update the record in Salesforce
            update acc;
        } else {
            System.debug('Account ID or new account name is invalid.');
        }
    }
}