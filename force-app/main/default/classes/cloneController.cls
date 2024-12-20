public class cloneController {

    @AuraEnabled(cacheable=true)
    public static List<String> getObjectNames() {
        List<String> objectNames = new List<String>();
        for (Schema.SObjectType objectType : Schema.getGlobalDescribe().values()) {
            objectNames.add(objectType.getDescribe().getName());
        }
        objectNames.sort();
        return objectNames;
    }
    
    
}