public interface ISprintTaskDomain {
  void validateSprintTaskFields(Sprint_Task__c sprintTask);

  void validateSprintTaskAccessibility();

  void validateSprintTaskCreateability();

  void validateSprintTaskUpdateability();

  void validateSprintTaskDeletability();
}
