public with sharing class SprintService {
  private IsprintDomain sprintDomain;
  private IsprintSelector sprintSelector;
  private IsprintTaskSelector sprintTaskSelector;

  public SprintService(
    IsprintDomain sprintDomain,
    IsprintSelector sprintSelector,
    IsprintTaskSelector sprintTaskSelector
  ) {
    this.sprintDomain = sprintDomain;
    this.sprintSelector = sprintSelector;
    this.sprintTaskSelector = sprintTaskSelector;
  }

  public List<Task__c> getTasksBySprint(Id sprintId) {
    try {
      List<Sprint_Task__c> sprintTasks = sprintTaskSelector.getListTasksBySprint();

      if (sprintTasks == null || sprintTasks.isEmpty()) {
        return new List<Task__c>();
      }

      Set<Id> taskIdsSet = new Set<Id>();
      for (Sprint_Task__c st : sprintTasks) {
        if (st.Task__c != null)
          taskIdsSet.add(st.Task__c);
      }

      if (taskIdsSet.isEmpty()) {
        return new List<Task__c>();
      }

      return TaskSelector.getTasksByTasksIds(new List<Id>(taskIdsSet));
    } catch (Exception e) {
      throw new AuraHandledException('Unable to load tasks for sprint.');
    }
  }

  public List<Task__c> getTasksFromActiveSprint() {
    try {
      List<Sprint_Task__c> tasks = sprintTaskSelector.getListTasksBySprint();

      if (tasks == null || tasks.isEmpty()) {
        return new List<Task__c>();
      }

      Set<Id> taskIdsSet = new Set<Id>();
      for (Sprint_Task__c st : tasks) {
        if (st.Task__c != null)
          taskIdsSet.add(st.Task__c);
      }

      if (taskIdsSet.isEmpty()) {
        return new List<Task__c>();
      }

      return TaskSelector.getTasksByTasksIds(new List<Id>(taskIdsSet));
    } catch (Exception e) {
      throw new AuraHandledException(
        'Unable to load tasks from active sprint.'
      );
    }
  }

  public List<Sprint__c> getAllSprints() {
    try {
      return sprintSelector.getAllSprints();
    } catch (Exception e) {
      throw new AuraHandledException('Unable to load sprints.');
    }
  }

  public Sprint__c getActiveSprint() {
    try {
      List<Sprint__c> activeSprints = sprintSelector.getActiveSprints();
      return (activeSprints == null || activeSprints.isEmpty())
        ? null
        : activeSprints[0];
    } catch (Exception e) {
      throw new AuraHandledException('Unable to load active sprint.');
    }
  }

  public void createSprint(String name, Date startDate, Date endDate) {
    sprintDomain.validateSprintCreateability();
    if (startDate == null || endDate == null) {
      throw new AuraHandledException('StartDate and EndDate are required.');
    }
    if (endDate < startDate) {
      throw new AuraHandledException('EndDate cannot be before StartDate.');
    }

    Sprint__c sprint = new Sprint__c(
      Date_Begin__c = startDate,
      Date_End__c = endDate,
      Status__c = 'Active'
    );

    sprintDomain.validateSprintFields(sprint);

    try {
      insert sprint;
    } catch (DmlException e) {
      throw new AuraHandledException('Unable to create sprint.');
    }
  }

  public void updateSprintDates(
    Id sprintId,
    Date newStartDate,
    Date newEndDate
  ) {
    sprintDomain.validateSprintUpdateability();
    if (sprintId == null) {
      throw new AuraHandledException('SprintId is required.');
    }
    if (newStartDate == null || newEndDate == null) {
      throw new AuraHandledException('StartDate and EndDate are required.');
    }
    if (newEndDate < newStartDate) {
      throw new AuraHandledException('EndDate cannot be before StartDate.');
    }

    Sprint__c sprint = sprintSelector.getSprintById(sprintId);
    if (sprint == null) {
      throw new AuraHandledException('Sprint not found.');
    }

    sprint.Date_Begin__c = newStartDate;
    sprint.Date_End__c = newEndDate;

    sprintDomain.validateSprintFields(sprint);

    try {
      update sprint;
    } catch (DmlException e) {
      throw new AuraHandledException('Unable to update sprint dates.');
    }
  }
}
