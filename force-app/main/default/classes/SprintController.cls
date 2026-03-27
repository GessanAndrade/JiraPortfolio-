public with sharing class SprintController {
  @AuraEnabled(cacheable=true)
  public static List<Sprint__c> getAllSprints() {
    SprintService service = new SprintService(
      new SprintDomain(),
      new SprintSelector(),
      new SprintTaskSelector()
    );

    return service.getAllSprints();
  }

  @AuraEnabled(cacheable=true)
  public static Sprint__c getActiveSprint() {
    SprintService service = new SprintService(
      new SprintDomain(),
      new SprintSelector(),
      new SprintTaskSelector()
    );

    return service.getActiveSprint();
  }

  @AuraEnabled
  public static void createSprint(String name, Date startDate, Date endDate) {
    SprintService service = new SprintService(
      new SprintDomain(),
      new SprintSelector(),
      new SprintTaskSelector()
    );

    service.createSprint(name, startDate, endDate);
  }

  @AuraEnabled
  public static void updateSprintDates(
    Id sprintId,
    Date newStartDate,
    Date newEndDate
  ) {
    SprintService service = new SprintService(
      new SprintDomain(),
      new SprintSelector(),
      new SprintTaskSelector()
    );

    service.updateSprintDates(sprintId, newStartDate, newEndDate);
  }

  @AuraEnabled(cacheable=true)
  public static List<Task__c> getTasksBySprint(Id sprintId) {
    SprintService service = new SprintService(
      new SprintDomain(),
      new SprintSelector(),
      new SprintTaskSelector()
    );

    return service.getTasksBySprint(sprintId);
  }

  @AuraEnabled(cacheable=true)
  public static List<Task__c> getTasksFromActiveSprint() {
    SprintService service = new SprintService(
      new SprintDomain(),
      new SprintSelector(),
      new SprintTaskSelector()
    );

    return service.getTasksFromActiveSprint();
  }
}
