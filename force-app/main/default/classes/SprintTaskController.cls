public with sharing class SprintTaskController {
  @AuraEnabled(cacheable=true)
  public static List<Task__c> getTasksBySprintTasks(List<Id> taskIds) {
    TaskService taskService = new TaskService(
      new TaskDomain(),
      new TaskSelector(),
      new DeveloperSelector()
    );

    return taskService.getTasksByTasksIds(taskIds);
  }

  @AuraEnabled(cacheable=true)
  public static List<Task__c> getTasksFromSprintTasksAndIdDeveloper(
    List<Id> taskIds,
    Id developerId
  ) {
    TaskService taskService = new TaskService(
      new TaskDomain(),
      new TaskSelector(),
      new DeveloperSelector()
    );

    return taskService.getTasksFromSprintTasksAndIdDeveloper(
      taskIds,
      developerId
    );
  }

  @AuraEnabled
  public static void createTaskBySprint(Id sprintId, Id task) {
    SprintTaskService sprintTaskService = new SprintTaskService(
      new SprintTaskDomain(),
      new SprintTaskSelector(),
      new TaskService(
        new TaskDomain(),
        new TaskSelector(),
        new DeveloperSelector()
      )
    );

    sprintTaskService.createTaskBySprint(sprintId, task);
  }

  @AuraEnabled
  public static void updateTaskStatus(Id taskId, String newStatus) {
    SprintTaskService sprintTaskService = new SprintTaskService(
      new SprintTaskDomain(),
      new SprintTaskSelector(),
      new TaskService(
        new TaskDomain(),
        new TaskSelector(),
        new DeveloperSelector()
      )
    );

    sprintTaskService.updateTaskStatus(taskId, newStatus);
  }

  @AuraEnabled(cacheable=true)
  public static Decimal getPointsByDeveloperActiveSprint(Id developerId) {
    SprintTaskService sprintTaskService = new SprintTaskService(
      new SprintTaskDomain(),
      new SprintTaskSelector(),
      new TaskService(
        new TaskDomain(),
        new TaskSelector(),
        new DeveloperSelector()
      )
    );

    return sprintTaskService.getPointsByDeveloperActiveSprint(developerId);
  }
}
