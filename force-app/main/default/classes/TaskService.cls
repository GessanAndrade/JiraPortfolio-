public with sharing class TaskService {
  public static List<Task__c> getTasksByDeveloper(Id developerId) {
    if (developerId == null) {
      throw new AuraHandledException('DeveloperId cannot be null.');
    }
    return TaskSelector.getTaskByDeveloper(developerId);
  }

  public static Task__c getTaskById(Id taskId) {
    if (taskId == null) {
      throw new AuraHandledException('TaskId cannot be null.');
    }

    Task__c task = TaskSelector.getTaskById(taskId);
    if (task == null) {
      throw new AuraHandledException('Task not found.');
    }

    return task;
  }

  public static List<Task__c> getTasksByTasksIds(List<Id> taskIds) {
    if (taskIds == null || taskIds.isEmpty()) {
      throw new AuraHandledException('TaskIds cannot be empty.');
    }
    return TaskSelector.getTasksByTasksIds(taskIds);
  }

  public static List<Task__c> getTasksFromSprintTasksAndIdDeveloper(
    List<Id> taskIds,
    Id developerId
  ) {
    if (taskIds == null || taskIds.isEmpty()) {
      throw new AuraHandledException('TaskIds cannot be empty.');
    }
    if (developerId == null) {
      throw new AuraHandledException('DeveloperId cannot be null.');
    }
    return TaskSelector.getTasksFromSprintTasksAndIdDeveloper(
      taskIds,
      developerId
    );
  }

  public static Developer__c getDeveloperByTaskId(Id taskId) {
    if (taskId == null) {
      throw new AuraHandledException('TaskId cannot be null.');
    }

    Task__c task = TaskSelector.getTaskById(taskId);
    if (task == null) {
      throw new AuraHandledException('Task not found.');
    }

    if (task.Developer__c == null) {
      throw new AuraHandledException('Task has no assigned developer.');
    }

    return DeveloperSelector.getDeveloperById(task.Developer__c);
  }

  public static void updateTaskDeveloper(Id taskId, Id developerId) {
    if (!Schema.sObjectType.Task__c.isUpdateable()) {
      throw new AuraHandledException(
        'You do not have permission to update Task.'
      );
    }

    if (taskId == null || developerId == null) {
      throw new AuraHandledException('TaskId and DeveloperId are required.');
    }

    Task__c taskToUpdate = TaskSelector.getTaskById(taskId);
    if (taskToUpdate == null) {
      throw new AuraHandledException('Task not found.');
    }
    if (!Schema.sObjectType.Task__c.fields.Developer__c.isUpdateable()) {
      throw new AuraHandledException(
        'You do not have permission to update task developer.'
      );
    }

    taskToUpdate.Developer__c = developerId;

    try {
      update taskToUpdate;
    } catch (DmlException e) {
      throw new AuraHandledException('Unable to update task developer.');
    }
  }

  public static void updateTaskStatus(Id taskId, String newStatus) {
    if (!Schema.sObjectType.Task__c.isUpdateable()) {
      throw new AuraHandledException(
        'You do not have permission to update Task.'
      );
    }

    if (taskId == null || String.isBlank(newStatus)) {
      throw new AuraHandledException('TaskId and Status are required.');
    }

    Task__c taskToUpdate = TaskSelector.getTaskById(taskId);
    if (taskToUpdate == null) {
      throw new AuraHandledException('Task not found.');
    }

    if (taskToUpdate.Status__c == 'Done') {
      throw new AuraHandledException('You cannot modify a completed task.');
    }
    if (!Schema.sObjectType.Task__c.fields.Status__c.isUpdateable()) {
      throw new AuraHandledException(
        'You do not have permission to update task status.'
      );
    }

    taskToUpdate.Status__c = newStatus;

    try {
      update taskToUpdate;
    } catch (DmlException e) {
      throw new AuraHandledException('Unable to update task status.');
    }
  }
}
