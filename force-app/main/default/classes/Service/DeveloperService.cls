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
      throw ErrorHandler.handUnableError(e, 'developers.');
    }
  }

  public Developer__c getDeveloperById(Id developerId) {
    domain.validateDeveloperAccessibility();
    if (developerId == null) {
      throw ErrorHandler.handNotNullError('DeveloperId.');
    }

    try {
      Developer__c developer = selector.getDeveloperById(developerId);
      if (developer == null) {
        throw ErrorHandler.handNotFoundError('Developer');
      }

      return developer;
    } catch (AuraHandledException e) {
      throw e;
    } catch (Exception e) {
      throw ErrorHandler.handUnableError(e, 'developer');
    }
  }

  public void createDeveloper(String name, Id addressId) {
    domain.validateDeveloperCreateability();
    if (String.isBlank(name) || addressId == null) {
      throw ErrorHandler.handRequiredError('Name and Address');
    }

    Developer__c developer = new Developer__c(
      Name__c = name.trim(),
      Address__c = addressId
    );

    domain.validateDeveloperFields(developer);

    try {
      insert developer;
    } catch (DmlException e) {
      throw ErrorHandler.handUnableError(e, 'developer');
    }
  }

  public void updateDeveloper(Developer__c developer) {
    domain.validateDeveloperUpdateability();
    if (developer == null || developer.Id == null) {
      throw ErrorHandler.handRequiredError('Developer Id');
    }

    domain.validateDeveloperFields(developer);

    try {
      update developer;
    } catch (DmlException e) {
      throw ErrorHandler.handUnableError(e, 'developer.');
    }
  }
}
