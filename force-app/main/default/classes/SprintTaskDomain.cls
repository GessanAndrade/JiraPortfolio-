public with sharing class SprintTaskDomain implements ISprintTaskDomain {
  public void validateSprintTaskFields(Sprint_Task__c sprintTask) {
    if (sprintTask.Sprint_FKN__c == null) {
      throw new AuraHandledException('Sprint is required.');
    }
    if (sprintTask.Task__c == null) {
      throw new AuraHandledException('Task is required.');
    }
  }

  public void validateSprintTaskAccessibility() {
    if (!Schema.sObjectType.Sprint_Task__c.isAccessible()) {
      throw new AuraHandledException(
        'You do not have permission to access Sprint Task.'
      );
    }
  }
  public void validateSprintTaskCreateability() {
    if (!Schema.sObjectType.Sprint_Task__c.isCreateable()) {
      throw new AuraHandledException(
        'You do not have permission to create Sprint Task.'
      );
    }
  }
  public void validateSprintTaskUpdateability() {
    if (!Schema.sObjectType.Sprint_Task__c.isUpdateable()) {
      throw new AuraHandledException(
        'You do not have permission to update Sprint Task.'
      );
    }
  }
  public void validateSprintTaskDeletability() {
    if (!Schema.sObjectType.Sprint_Task__c.isDeletable()) {
      throw new AuraHandledException(
        'You do not have permission to delete Sprint Task.'
      );
    }
  }
}
