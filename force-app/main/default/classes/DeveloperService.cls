public with sharing class DeveloperService {
  public static List<Developer__c> getAllDevelopers() {
    DeveloperDomain.validateDeveloperAcessibility();

    try {
      return DeveloperSelector.getAllDevelopers();
    } catch (Exception e) {
      throw new AuraHandledException('Unable to load developers.');
    }
  }

  public static Developer__c getDeveloperById(Id developerId) {
    DeveloperDomain.validateDeveloperAcessibility();
    if (developerId == null) {
      throw ErrorHandler.handled('DeveloperId cannot be null.');
    }

    try {
      Developer__c developer = DeveloperSelector.getDeveloperById(developerId);
      if (developer == null) {
        throw ErrorHandler.handled('Developer not found.');
      }

      return developer;
    } catch (AuraHandledException e) {
      throw e;
    } catch (Exception e) {
      throw ErrorHandler.handled('Unable to load developer.');
    }
  }

  public static void createDeveloper(String name, Id addressId) {
    DeveloperDomain.validateDeveloperCreateability();
    if (String.isBlank(name) || addressId == null) {
      throw ErrorHandler.handled('Name and Address are required.');
    }

    Developer__c developer = new Developer__c(
      Name__c = name.trim(),
      Address__c = addressId
    );

    DeveloperDomain.validateDeveloperFields(developer);

    try {
      insert developer;
    } catch (DmlException e) {
      throw ErrorHandler.handled('Unable to create developer.');
    }
  }

  public static void updateDeveloper(Developer__c developer) {
    DeveloperDomain.validateDeveloperUpdateability();
    if (developer == null || developer.Id == null) {
      throw ErrorHandler.handled('Developer Id is required.');
    }

    DeveloperDomain.validateDeveloperFields(developer);

    try {
      update developer;
    } catch (DmlException e) {
      throw ErrorHandler.handled('Unable to update developer.');
    }
  }
}
