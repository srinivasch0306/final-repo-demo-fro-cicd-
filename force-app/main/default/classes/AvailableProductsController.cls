// AvailableProductsController.cls
public with sharing class AvailableProductsController {

    @AuraEnabled(cacheable=true)
    public static Map<String, Object> getAvailableProducts(String selectedValues) {
        Map<String, Object> result = new Map<String, Object>();
        List<String> availableProducts = new List<String>();
        Integer recordCount = 0;

        try {
            // Query Products__c based on selectedValues
            // Replace 'Products__c' and 'Type__c' with your actual object and field names
            String query = 'SELECT Type__c FROM Products__c WHERE Type__c INCLUDES (:selectedValues)';
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
}