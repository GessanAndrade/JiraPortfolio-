public with sharing class AddressController {
  @AuraEnabled(cacheable=true)
  public static List<Address__c> getAllAddresses() {
    return FactoryAddress.createAddressService().getAllAddresses();
  }

  @AuraEnabled(cacheable=true)
  public static Address__c getAddressById(Id addressId) {
    return FactoryAddress.createAddressService().getAddressById(addressId);
  }

  @AuraEnabled
  public static void createAddress(String city, String cep) {
    FactoryAddress.createAddressService().createAddress(city, cep);
  }
}
