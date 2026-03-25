public with sharing class AddressSelector {
    
    public static List<Address__c> getAllAddresses() {
        List<Address__c> addresses = [SELECT Id, City__c, CEP__c FROM Address__c];  

       SObjectAccessDecision decision =
            Security.stripInaccessible(
                AccessType.READABLE,
                addresses
            );

        return (List<Address__c>)decision.getRecords();
    }

    public static Address__c getAddressById(Id addressId) {
      
        Address__c address = [
            SELECT Id, Name, City__c, CEP__c
            FROM Address__c
            WHERE Id = :addressId
            LIMIT 1
        ];
    
        SObjectAccessDecision decision =
            Security.stripInaccessible(
                AccessType.READABLE,
                new List<Address__c>{address}
            );
    
        return (Address__c)decision.getRecords()[0];
    }

}