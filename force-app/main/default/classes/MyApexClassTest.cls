@isTest
public class MyApexClassTest {
    @isTest
    static void testUpdateContactNames() {
        // Create test data
        Contact c1 = new Contact(FirstName = 'John', LastName = 'Doe', Email = 'john.doe@example.com');
        Contact c2 = new Contact(FirstName = 'Jane', LastName = 'Smith', Email = 'jane.smith@example.com');
        insert new List<Contact>{ c1, c2 };

        // Call the method to be tested
        Test.startTest();
        MyApexClass.updateContactNames('TestSuffix');
        Test.stopTest();

        // Verify the results
        List<Contact> updatedContacts = [SELECT FirstName FROM Contact WHERE Id IN :new List<Id>{ c1.Id, c2.Id }];
        for (Contact c : updatedContacts) {
            System.assert(c.FirstName.endsWith('TestSuffix'), 'FirstName should have the suffix');
        }
    }
}