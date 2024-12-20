public class ContactUpdater_MissingExceptionHandling {
    public static void updateContactPhone(Id contactId, String newPhone) {
        Contact con = [SELECT Id, Phone FROM Contact WHERE Id = :contactId];
        con.Phone = newPhone;
        update con;
    }
}