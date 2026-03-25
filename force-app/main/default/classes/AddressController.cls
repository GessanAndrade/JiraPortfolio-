public with sharing class AddressController {
    
    @AuraEnabled(cacheable=true)
    public static List<Address__c> getAllAddresses() {

        AddressDomain.validateAddressAcessibility();

        return AddressService.getAllAddresses();
    }

    @AuraEnabled(cacheable=true)
    public static Address__c getAddressById(Id addressId) {

        AddressDomain.validateAddressAcessibility();

        return AddressService.getAddressById(addressId);
    }

    @AuraEnabled
    public static void createAddress(String city, String cep) {

        AddressDomain.validateAddressCreateability();

        AddressService.createAddress(city, cep);
    }

}