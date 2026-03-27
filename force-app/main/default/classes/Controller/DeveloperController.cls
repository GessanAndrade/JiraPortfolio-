public with sharing class DeveloperController {
  @AuraEnabled(cacheable=true)
  public static List<Developer__c> getAllDevelopers() {
    return FactoryDeveloper.createDeveloper().getAllDevelopers();
  }

  @AuraEnabled(cacheable=true)
  public static Developer__c getDeveloperById(Id developerId) {
    return FactoryDeveloper.createDeveloper().getDeveloperById(developerId);
  }

  @AuraEnabled
  public static void createDeveloper(String name, Id addressId) {
    FactoryDeveloper.createDeveloper().createDeveloper(name, addressId);
  }

  @AuraEnabled
  public static void updateDeveloper(Developer__c developer) {
    FactoryDeveloper.createDeveloper().updateDeveloper(developer);
  }
}
