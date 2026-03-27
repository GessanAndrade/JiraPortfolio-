public with sharing class SprintTaskService {
  private IsprintTaskDomain sprintTaskDomain;
  private IsprintTaskSelector sprintTaskSelector;
  private ITaskService taskService;

  public SprintTaskService(
    IsprintTaskDomain sprintTaskDomain,
    IsprintTaskSelector sprintTaskSelector,
    ITaskService taskService
  ) {
    this.sprintTaskDomain = sprintTaskDomain;
    this.sprintTaskSelector = sprintTaskSelector;
    this.taskService = taskService;
  }

  public Decimal getPointsByDeveloperActiveSprint(Id developerId) {
    sprintTaskDomain.validateSprintTaskAccessibility();

    if (developerId == null) {
      throw new AuraHandledException('DeveloperId cannot be null.');
    }

    try {
      List<Sprint_Task__c> tasks = sprintTaskSelector.getListTasksBySprint();

      if (tasks == null || tasks.isEmpty()) {
        return 0;
      }

      Set<Id> taskIdsSet = new Set<Id>();
      for (Sprint_Task__c st : tasks) {
        if (st.Task__c != null)
          taskIdsSet.add(st.Task__c);
      }

      if (taskIdsSet.isEmpty()) {
        return 0;
      }

      List<Task__c> taskDetails = taskService.getTasksFromSprintTasksAndIdDeveloper(
        new List<Id>(taskIdsSet),
        developerId
      );

      Decimal totalPoints = 0;
      for (Task__c t : taskDetails) {
        totalPoints += (t.Points__c == null ? 0 : t.Points__c);
      }

      return totalPoints;
    } catch (AuraHandledException e) {
      throw e;
    } catch (Exception e) {
      throw new AuraHandledException(
        'Unable to calculate points for active sprint.'
      );
    }
  }

  public List<Task__c> getTasksBySprintTasks(List<Id> taskIds) {
    if (taskIds == null || taskIds.isEmpty()) {
      throw new AuraHandledException('TaskIds cannot be empty.');
    }

    try {
      return TaskSelector.getTasksByTasksIds(taskIds);
    } catch (Exception e) {
      throw new AuraHandledException('Unable to load tasks.');
    }
  }

  public void createTaskBySprint(Id sprintId, Id taskId) {
    sprintTaskDomain.validateSprintTaskCreateability();

    sprintTaskDomain.validateSprintTaskFields(
      new Sprint_Task__c(Sprint_FKN__c = sprintId, Task__c = taskId)
    );

    try {
      insert new Sprint_Task__c(Sprint_FKN__c = sprintId, Task__c = taskId);
    } catch (DmlException e) {
      throw new AuraHandledException('Unable to add task to sprint.');
    }
  }

  public void updateTaskStatus(Id sprintTaskId, String newStatus) {
    sprintTaskDomain.validateSprintTaskUpdateability();

    throw new AuraHandledException(
      'Invalid operation. Update the status on Task__c, not on Sprint_Task__c.'
    );
  }
}
