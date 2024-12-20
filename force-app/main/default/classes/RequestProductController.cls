// RequestProductController.cls
public with sharing class RequestProductController {

    @AuraEnabled(cacheable=true)
    public static Map<String, Object> getAvailableProducts(List<String> selectedValues) {
        Map<String, Object> result = new Map<String, Object>();
        List<String> availableProducts = new List<String>();
        Integer recordCount = 0;

        try {
            // Query Products__c based on selectedValues
            // Replace 'Products__c' and 'Type__c' with your actual object and field names
            String query = 'SELECT Type__c FROM Products__c WHERE Employee__c = Null AND Type__c IN :selectedValues';
            List<Products__c> products = Database.query(query);

            for (Products__c product : products) {
                availableProducts.add(product.Type__c);
            }

            recordCount = availableProducts.size();
        } catch (Exception e) {
            System.debug('Error querying available products: ' + e.getMessage());
            result.put('error', 'Error querying available products: ' + e.getMessage());
            return result;
        }

        result.put('availableProducts', availableProducts);
        result.put('recordCount', recordCount);

        return result;
    }

    @AuraEnabled
    public static void createRequestProduct(String selectProduct, String employee) {
        Request_Product__c newRequestProduct = new Request_Product__c(
            Select_Product__c = selectProduct,
            Employee__c = employee
        );

        try {
            insert newRequestProduct;
            System.debug('Created Product: ' + newRequestProduct.id);
        } catch (Exception e) {
            System.debug('Error creating Request Product: ' + e.getMessage());
            throw new AuraHandledException('Error creating Request Product: ' + e.getMessage());
        }
    }
}