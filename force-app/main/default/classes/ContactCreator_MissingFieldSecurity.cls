public class ContactCreator_MissingFieldSecurity {
    public static void createNewContact(String firstName, String lastName, String email) {
        Contact con = new Contact(FirstName = firstName, LastName = lastName, Email = email);
        insert con;
    }
}