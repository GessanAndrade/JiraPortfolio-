public with sharing class TaskController {
  @AuraEnabled(cacheable=true)
  public static List<Task__c> getTasksByDeveloper(Id developerId) {
    TaskService service = new TaskService(
      new TaskDomain(),
      new TaskSelector(),
      new DeveloperSelector()
    );

    return service.getTasksByDeveloper(developerId);
  }

  @AuraEnabled(cacheable=true)
  public static Task__c getTaskById(Id taskId) {
    TaskService service = new TaskService(
      new TaskDomain(),
      new TaskSelector(),
      new DeveloperSelector()
    );

    return service.getTaskById(taskId);
  }

  @AuraEnabled(cacheable=true)
  public static Developer__c getDeveloperByTaskId(Id taskId) {
    TaskService service = new TaskService(
      new TaskDomain(),
      new TaskSelector(),
      new DeveloperSelector()
    );

    return service.getDeveloperByTaskId(taskId);
  }

  @AuraEnabled
  public static void updateTaskDeveloper(Id taskId, Id developerId) {
    TaskService service = new TaskService(
      new TaskDomain(),
      new TaskSelector(),
      new DeveloperSelector()
    );

    service.updateTaskDeveloper(taskId, developerId);
  }

  @AuraEnabled
  public static void updateTaskStatus(Id taskId, String newStatus) {
    TaskService service = new TaskService(
      new TaskDomain(),
      new TaskSelector(),
      new DeveloperSelector()
    );

    service.updateTaskStatus(taskId, newStatus);
  }
}
