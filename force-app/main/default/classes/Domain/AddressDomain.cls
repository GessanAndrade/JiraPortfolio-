public with sharing class AddressDomain implements IAddressDomain {
  public void validateAddressFields(Address__c address) {
    if (String.isBlank(address.City__c)) {
      throw new AuraHandledException('City is required.');
    }
    if (String.isBlank(address.CEP__c)) {
      throw new AuraHandledException('CEP is required.');
    }
  }

  public void validateAddressAccessibility() {
    if (!Schema.sObjectType.Address__c.isAccessible()) {
      throw new AuraHandledException(
        'You do not have permission to access Address.'
      );
    }
  }

  public void validateAddressCreateability() {
    if (!Schema.sObjectType.Address__c.isCreateable()) {
      throw new AuraHandledException(
        'You do not have permission to create Address.'
      );
    }
  }

  public void validateAddressUpdateability() {
    if (!Schema.sObjectType.Address__c.isUpdateable()) {
      throw new AuraHandledException(
        'You do not have permission to update Address.'
      );
    }
  }

  public void validateAddressDeletability() {
    if (!Schema.sObjectType.Address__c.isDeletable()) {
      throw new AuraHandledException(
        'You do not have permission to delete Address.'
      );
    }
  }
}
