public with sharing class TaskService implements ITaskService {
  private ITaskDomain domain;
  private ITaskselector selector;
  private IDeveloperSelector developerSelector;

  public TaskService(
    ITaskDomain domain,
    ITaskselector selector,
    IDeveloperSelector developerSelector
  ) {
    this.domain = domain;
    this.selector = selector;
    this.developerSelector = developerSelector;
  }

  public List<Task__c> getTasksByDeveloper(Id developerId) {
    domain.validateTaskAccessibility();

    return selector.getTaskByDeveloper(developerId);
  }

  public Task__c getTaskById(Id taskId) {
    domain.validateTaskAccessibility();

    if (taskId == null) {
      throw ErrorHandler.handled('TaskId cannot be null.');
    }

    Task__c task = selector.getTaskById(taskId);
    if (task == null) {
      throw ErrorHandler.handled('Task not found.');
    }

    return task;
  }

  public List<Task__c> getTasksByTasksIds(List<Id> taskIds) {
    domain.validateTaskAccessibility();

    if (taskIds == null || taskIds.isEmpty()) {
      throw ErrorHandler.handled('TaskIds cannot be empty.');
    }
    return selector.getTasksByTasksIds(taskIds);
  }

  public List<Task__c> getTasksFromSprintTasksAndIdDeveloper(
    List<Id> taskIds,
    Id developerId
  ) {
    domain.validateTaskAccessibility();

    if (taskIds == null || taskIds.isEmpty()) {
      throw ErrorHandler.handled('TaskIds cannot be empty.');
    }
    if (developerId == null) {
      throw ErrorHandler.handled('DeveloperId cannot be null.');
    }
    return selector.getTasksFromSprintTasksAndIdDeveloper(taskIds, developerId);
  }

  public Developer__c getDeveloperByTaskId(Id taskId) {
    domain.validateTaskAccessibility();

    if (taskId == null) {
      throw ErrorHandler.handled('TaskId cannot be null.');
    }

    Task__c task = selector.getTaskById(taskId);
    if (task == null) {
      throw ErrorHandler.handled('Task not found.');
    }

    if (task.Developer__c == null) {
      throw ErrorHandler.handled('Task has no assigned developer.');
    }

    return developerSelector.getDeveloperById(task.Developer__c);
  }

  public void updateTaskDeveloper(Id taskId, Id developerId) {
    domain.validateTaskUpdateability();

    if (!Schema.sObjectType.Task__c.isUpdateable()) {
      throw ErrorHandler.handled('You do not have permission to update Task.');
    }

    if (taskId == null || developerId == null) {
      throw ErrorHandler.handled('TaskId and DeveloperId are required.');
    }

    Task__c taskToUpdate = selector.getTaskById(taskId);
    if (taskToUpdate == null) {
      throw ErrorHandler.handled('Task not found.');
    }
    if (!Schema.sObjectType.Task__c.fields.Developer__c.isUpdateable()) {
      throw ErrorHandler.handled(
        'You do not have permission to update task developer.'
      );
    }

    taskToUpdate.Developer__c = developerId;

    try {
      update taskToUpdate;
    } catch (DmlException e) {
      throw ErrorHandler.handled('Unable to update task developer.');
    }
  }

  public void updateTaskStatus(Id taskId, String newStatus) {
    domain.validateTaskUpdateability();

    Task__c taskToUpdate = selector.getTaskById(taskId);

    taskToUpdate.Status__c = newStatus;

    try {
      update taskToUpdate;
    } catch (DmlException e) {
      throw ErrorHandler.handled('Unable to update task status.');
    }
  }
}
