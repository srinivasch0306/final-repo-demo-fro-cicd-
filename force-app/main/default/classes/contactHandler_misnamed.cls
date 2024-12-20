public class contactHandler_misnamed {
    public static void updtCntctEmails(List<Id> cIds, String eml) {
        for (Id cId : cIds) {
            Contact con = [SELECT Id, Email FROM Contact WHERE Id = :cId];
            con.Email = eml;
            update con;
        }
    }
}