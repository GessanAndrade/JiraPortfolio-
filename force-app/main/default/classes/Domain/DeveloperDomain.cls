public with sharing class DeveloperDomain implements IDeveloperDomain {
  public void validateDeveloperFields(Developer__c developer) {
    if (String.isBlank(developer.Name__c)) {
      throw new AuraHandledException('Name is required.');
    }
    if (developer.Address__c == null) {
      throw new AuraHandledException('Address is required.');
    }
  }

  public void validateDeveloperAccessibility() {
    if (!Schema.sObjectType.Developer__c.isAccessible()) {
      throw new AuraHandledException(
        'You do not have permission to access Developer.'
      );
    }
  }

  public void validateDeveloperCreateability() {
    if (!Schema.sObjectType.Developer__c.isCreateable()) {
      throw new AuraHandledException(
        'You do not have permission to create Developer.'
      );
    }
  }

  public void validateDeveloperUpdateability() {
    if (!Schema.sObjectType.Developer__c.isUpdateable()) {
      throw new AuraHandledException(
        'You do not have permission to update Developer.'
      );
    }
  }

  public void validateDeveloperDeletability() {
    if (!Schema.sObjectType.Developer__c.isDeletable()) {
      throw new AuraHandledException(
        'You do not have permission to delete Developer.'
      );
    }
  }
}
