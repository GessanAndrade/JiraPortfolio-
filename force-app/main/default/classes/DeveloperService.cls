public with sharing class DeveloperService {
  private IDeveloperSelector selector;
  private IDeveloperDomain domain;

  // Dependency Injection
  public DeveloperService(
    IDeveloperSelector selector,
    IDeveloperDomain domain
  ) {
    this.selector = selector;
    this.domain = domain;
  }

  public List<Developer__c> getAllDevelopers() {
    domain.validateDeveloperAccessibility();

    try {
      return selector.getAllDevelopers();
    } catch (Exception e) {
      throw new AuraHandledException('Unable to load developers.');
    }
  }

  public Developer__c getDeveloperById(Id developerId) {
    domain.validateDeveloperAccessibility();
    if (developerId == null) {
      throw ErrorHandler.handled('DeveloperId cannot be null.');
    }

    try {
      Developer__c developer = selector.getDeveloperById(developerId);
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

  public void createDeveloper(String name, Id addressId) {
    domain.validateDeveloperCreateability();
    if (String.isBlank(name) || addressId == null) {
      throw ErrorHandler.handled('Name and Address are required.');
    }

    Developer__c developer = new Developer__c(
      Name__c = name.trim(),
      Address__c = addressId
    );

    domain.validateDeveloperFields(developer);

    try {
      insert developer;
    } catch (DmlException e) {
      throw ErrorHandler.handled('Unable to create developer.');
    }
  }

  public void updateDeveloper(Developer__c developer) {
    domain.validateDeveloperUpdateability();
    if (developer == null || developer.Id == null) {
      throw ErrorHandler.handled('Developer Id is required.');
    }

    domain.validateDeveloperFields(developer);

    try {
      update developer;
    } catch (DmlException e) {
      throw ErrorHandler.handled('Unable to update developer.');
    }
  }
}
