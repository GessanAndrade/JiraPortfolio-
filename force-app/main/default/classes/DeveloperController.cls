public with sharing class DeveloperController {
  @AuraEnabled(cacheable=true)
  public static List<Developer__c> getAllDevelopers() {
    DeveloperService service = new DeveloperService(
      new DeveloperSelector(),
      new DeveloperDomain()
    );

    return service.getAllDevelopers();
  }

  @AuraEnabled(cacheable=true)
  public static Developer__c getDeveloperById(Id developerId) {
    DeveloperService service = new DeveloperService(
      new DeveloperSelector(),
      new DeveloperDomain()
    );

    return service.getDeveloperById(developerId);
  }

  @AuraEnabled
  public static void createDeveloper(String name, Id addressId) {
    DeveloperService service = new DeveloperService(
      new DeveloperSelector(),
      new DeveloperDomain()
    );

    service.createDeveloper(name, addressId);
  }

  @AuraEnabled
  public static void updateDeveloper(Developer__c developer) {
    DeveloperService service = new DeveloperService(
      new DeveloperSelector(),
      new DeveloperDomain()
    );

    service.updateDeveloper(developer);
  }
}
