public class ContactHandler_MissingBulkification {
    public static void updateContactEmails(List<Id> contactIds, String newEmail) {
        for (Id contactId : contactIds) {
            Contact con = [SELECT Id, Email FROM Contact WHERE Id = :contactId];
            con.Email = newEmail;
            update con;
        }
    }
}