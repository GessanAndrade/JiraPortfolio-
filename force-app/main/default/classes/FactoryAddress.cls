public with sharing class FactoryAddress {
  public static AddressService createAddressService() {
    return new AddressService(new AddressSelector(), new AddressDomain());
  }
}
