@isTest
public class AddressControllerTest {

    @testSetup
    public static void setup() {
        Helper helper = new Helper();
        List<Address__c> addresses = helper.createFakeAddresses(2);
        insert addresses;
    }

    @isTest
    public static void testGetAllAddresses() {
        List<Address__c> addresses = AddressController.getAllAddresses();
        System.Assert.areEqual(2, addresses.size(), 'Expected 2 addresses');
    }

    @isTest
    public static void testGetAddressById() {
        Address__c address = [SELECT Id FROM Address__c LIMIT 1];
        Address__c result = AddressController.getAddressById(address.Id);
        System.Assert.isNotNull(result, 'Expected to find an address'); 
    }

    @isTest
    public static void testCreateAddress() {
        AddressController.createAddress('City Test', 'CEP Test');  
        Address__c result = [SELECT Id FROM Address__c WHERE City__c = 'City Test' AND CEP__c = 'CEP Test' LIMIT 1];
        System.Assert.isNotNull(result, 'Expected to find the created address');    
    } 
}