public with sharing class AddressSelector {
    
    public static List<Address__c> getAllAddresses() {
        return [SELECT Id, City__c, CEP__c FROM Address__c];  
    }

    public static Address__c getAddressById(Id addressId) {
        return [SELECT Id, Name, City__c, CEP__c FROM Address__c WHERE Id = :addressId LIMIT 1];
    }

}