public interface IDeveloperDomain {
  void validateDeveloperFields(Developer__c developer);

  void validateDeveloperAccessibility();

  void validateDeveloperCreateability();

  void validateDeveloperUpdateability();

  void validateDeveloperDeletability();
}
