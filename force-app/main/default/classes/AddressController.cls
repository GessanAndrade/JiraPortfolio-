public with sharing class AddressController {
    
    @AuraEnabled(cacheable=true)
    public static List<Address__c> getAllAddresses() {
        return AddressService.getAllAddresses();
    }

    @AuraEnabled(cacheable=true)
    public static Address__c getAddressById(Id addressId) {
        return AddressService.getAddressById(addressId);
    }

    @AuraEnabled
    public static void createAddress(String city, String cep) {
        AddressService.createAddress(city, cep);
    }

}