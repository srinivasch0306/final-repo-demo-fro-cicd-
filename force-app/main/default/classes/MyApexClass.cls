public class MyApexClass {
    public static void updateContactNames(String suffix) {
        // Example logic: Add a suffix to Contact names
        List<Contact> contactsToUpdate = [SELECT Id, FirstName FROM Contact WHERE FirstName != NULL];
        for (Contact c : contactsToUpdate) {
            c.FirstName += ' ' + suffix;
        }
        update contactsToUpdate;
    }
}