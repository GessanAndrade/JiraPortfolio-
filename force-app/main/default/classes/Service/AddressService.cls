public with sharing class AddressService {
  private IAddressSelector selector;
  private IAddressDomain domain;

  public AddressService(IAddressSelector selector, IAddressDomain domain) {
    this.selector = selector;
    this.domain = domain;
  }

  public List<Address__c> getAllAddresses() {
    domain.validateAddressAccessibility();

    try {
      return selector.getAllAddresses();
    } catch (Exception e) {
      throw ErrorHandler.handled('Unable to load addresses.');
    }
  }

  public Address__c getAddressById(Id addressId) {
    domain.validateAddressAccessibility();

    if (addressId == null) {
      throw new AuraHandledException('AddressId cannot be null.');
    }

    try {
      Address__c address = selector.getAddressById(addressId);
      if (address == null) {
        throw ErrorHandler.handled('Address not found.');
      }
      return address;
    } catch (AuraHandledException e) {
      throw e;
    } catch (Exception e) {
      throw ErrorHandler.handled('Unable to load address.');
    }
  }

  public void createAddress(String city, String cep) {
    domain.validateAddressCreateability();

    if (String.isBlank(city) || String.isBlank(cep)) {
      throw ErrorHandler.handled('City and CEP are required.');
    }

    Address__c address = new Address__c(
      City__c = city.trim(),
      CEP__c = cep.trim()
    );

    domain.validateAddressFields(address);

    try {
      insert address;
    } catch (DmlException e) {
      throw ErrorHandler.handled('Unable to create address.');
    }
  }
}
