public with sharing class SprintTaskController {
  @AuraEnabled(cacheable=true)
  public static List<Task__c> getTasksBySprintTasks(List<Id> taskIds) {
    if (!Schema.sObjectType.Task__c.isAccessible()) {
      throw new AuraHandledException(
        'You do not have permission to access Task.'
      );
    }

    return TaskService.getTasksByTasksIds(taskIds);
  }

  @AuraEnabled(cacheable=true)
  public static List<Task__c> getTasksFromSprintTasksAndIdDeveloper(
    List<Id> taskIds,
    Id developerId
  ) {
    if (!Schema.sObjectType.Task__c.isAccessible()) {
      throw new AuraHandledException(
        'You do not have permission to access Task.'
      );
    }

    return TaskService.getTasksFromSprintTasksAndIdDeveloper(
      taskIds,
      developerId
    );
  }

  @AuraEnabled
  public static void createTaskBySprint(Id sprintId, Id task) {
    if (!Schema.sObjectType.Sprint_Task__c.isCreateable()) {
      throw new AuraHandledException(
        'You do not have permission to create Sprint Task.'
      );
    }

    SprintTaskService.createTaskBySprint(sprintId, task);
  }

  @AuraEnabled
  public static void updateTaskStatus(Id taskId, String newStatus) {
    if (!Schema.sObjectType.Task__c.isUpdateable()) {
      throw new AuraHandledException(
        'You do not have permission to update Task.'
      );
    }

    SprintTaskService.updateTaskStatus(taskId, newStatus);
  }

  @AuraEnabled(cacheable=true)
  public static Decimal getPointsByDeveloperActiveSprint(Id developerId) {
    if (!Schema.sObjectType.Sprint_Task__c.isAccessible()) {
      throw new AuraHandledException(
        'You do not have permission to access Sprint Task.'
      );
    }

    return SprintTaskService.getPointsByDeveloperActiveSprint(developerId);
  }
}
