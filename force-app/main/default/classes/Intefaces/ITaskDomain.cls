public interface ITaskDomain {
  void validateTaskFields(Task__c task);

  void validateTaskAccessibility();

  void validateTaskCreateability();

  void validateTaskUpdateability();

  void validateTaskDeletability();
}
