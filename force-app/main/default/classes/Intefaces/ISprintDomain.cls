public interface ISprintDomain {
  void validateSprintFields(Sprint__c sprint);

  void validateSprintAccessibility();

  void validateSprintCreateability();

  void validateSprintUpdateability();

  void validateSprintDeletability();
}
