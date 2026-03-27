public with sharing class AddressController {
  @AuraEnabled(cacheable=true)
  public static List<Address__c> getAllAddresses() {
    AddressService service = new AddressService(
      new AddressSelector(),
      new AddressDomain()
    );

    return service.getAllAddresses();
  }

  @AuraEnabled(cacheable=true)
  public static Address__c getAddressById(Id addressId) {
    AddressService service = new AddressService(
      new AddressSelector(),
      new AddressDomain()
    );

    return service.getAddressById(addressId);
  }

  @AuraEnabled
  public static void createAddress(String city, String cep) {
    AddressService service = new AddressService(
      new AddressSelector(),
      new AddressDomain()
    );

    service.createAddress(city, cep);
  }
}
