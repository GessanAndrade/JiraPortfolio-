public with sharing class TaskController {
  @AuraEnabled(cacheable=true)
  public static List<Task__c> getTasksByDeveloper(Id developerId) {
    return FactoryTask.createTaskService().getTasksByDeveloper(developerId);
  }

  @AuraEnabled(cacheable=true)
  public static Task__c getTaskById(Id taskId) {
    return FactoryTask.createTaskService().getTaskById(taskId);
  }

  @AuraEnabled(cacheable=true)
  public static Developer__c getDeveloperByTaskId(Id taskId) {
    return FactoryTask.createTaskService().getDeveloperByTaskId(taskId);
  }

  @AuraEnabled
  public static void updateTaskDeveloper(Id taskId, Id developerId) {
    FactoryTask.createTaskService().updateTaskDeveloper(taskId, developerId);
  }

  @AuraEnabled
  public static void updateTaskStatus(Id taskId, String newStatus) {
    FactoryTask.createTaskService().updateTaskStatus(taskId, newStatus);
  }
}
