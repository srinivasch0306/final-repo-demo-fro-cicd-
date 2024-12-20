public class ContactHandler_MissingSOQLLimits {
    
       public static void retrieveContactEmails() {
        List<Contact> contacts = new List<Contact>();
        for (Integer i = 0; i < 200; i++) {
            contacts.add([SELECT Id, Email FROM Contact LIMIT 1]);
        }
        // Do something with contacts
    }
}