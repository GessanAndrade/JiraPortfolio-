public with sharing class SprintTaskController {
  @AuraEnabled(cacheable=true)
  public static List<Task__c> getTasksBySprintTasks(List<Id> taskIds) {
    return FactoryTask.createTaskService().getTasksByTasksIds(taskIds);
  }

  @AuraEnabled(cacheable=true)
  public static List<Task__c> getTasksFromSprintTasksAndIdDeveloper(
    List<Id> taskIds,
    Id developerId
  ) {
    return FactoryTask.createTaskService()
      .getTasksFromSprintTasksAndIdDeveloper(taskIds, developerId);
  }

  @AuraEnabled
  public static void createTaskBySprint(Id sprintId, Id task) {
    FactorySprintTask.createSprintTaskService()
      .createTaskBySprint(sprintId, task);
  }

  @AuraEnabled
  public static void updateTaskStatus(Id taskId, String newStatus) {
    FactorySprintTask.createSprintTaskService()
      .updateTaskStatus(taskId, newStatus);
  }

  @AuraEnabled(cacheable=true)
  public static Decimal getPointsByDeveloperActiveSprint(Id developerId) {
    return FactorySprintTask.createSprintTaskService()
      .getPointsByDeveloperActiveSprint(developerId);
  }
}
