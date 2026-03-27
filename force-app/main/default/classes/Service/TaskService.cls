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
      throw ErrorHandler.handNotNullError('TaskId');
    }

    Task__c task = selector.getTaskById(taskId);
    if (task == null) {
      throw ErrorHandler.handNotFoundError('Task');
    }

    return task;
  }

  public List<Task__c> getTasksByTasksIds(List<Id> taskIds) {
    domain.validateTaskAccessibility();

    if (taskIds == null || taskIds.isEmpty()) {
      throw ErrorHandler.handNotNullError('TaskIds or Empty');
    }
    return selector.getTasksByTasksIds(taskIds);
  }

  public List<Task__c> getTasksFromSprintTasksAndIdDeveloper(
    List<Id> taskIds,
    Id developerId
  ) {
    domain.validateTaskAccessibility();

    if (taskIds == null || taskIds.isEmpty()) {
      throw ErrorHandler.handNotNullError('TaskIds or empty.');
    }
    if (developerId == null) {
      throw ErrorHandler.handNotNullError('DeveloperId');
    }
    return selector.getTasksFromSprintTasksAndIdDeveloper(taskIds, developerId);
  }

  public Developer__c getDeveloperByTaskId(Id taskId) {
    domain.validateTaskAccessibility();

    if (taskId == null) {
      throw ErrorHandler.handNotNullError('TaskId');
    }

    Task__c task = selector.getTaskById(taskId);
    if (task == null) {
      throw ErrorHandler.handNotFoundError('Task');
    }

    if (task.Developer__c == null) {
      throw ErrorHandler.handNotNullError('Task');
    }

    return developerSelector.getDeveloperById(task.Developer__c);
  }

  public void updateTaskDeveloper(Id taskId, Id developerId) {
    domain.validateTaskUpdateability();

    if (taskId == null || developerId == null) {
      throw ErrorHandler.handRequiredError('TaskId and DeveloperId');
    }

    Task__c taskToUpdate = selector.getTaskById(taskId);
    if (taskToUpdate == null) {
      throw ErrorHandler.handNotFoundError('Task');
    }

    taskToUpdate.Developer__c = developerId;

    try {
      update taskToUpdate;
    } catch (DmlException e) {
      throw ErrorHandler.handUnableError(e, 'developer.');
    }
  }

  public void updateTaskStatus(Id taskId, String newStatus) {
    domain.validateTaskUpdateability();

    Task__c taskToUpdate = selector.getTaskById(taskId);

    taskToUpdate.Status__c = newStatus;

    try {
      update taskToUpdate;
    } catch (DmlException e) {
      throw ErrorHandler.handUnableError(e, 'task status.');
    }
  }
}
