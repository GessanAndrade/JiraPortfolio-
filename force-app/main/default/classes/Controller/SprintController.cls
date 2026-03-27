public with sharing class SprintController {
  @AuraEnabled(cacheable=true)
  public static List<Sprint__c> getAllSprints() {
    return FactorySprint.createSprintService().getAllSprints();
  }

  @AuraEnabled(cacheable=true)
  public static Sprint__c getActiveSprint() {
    return FactorySprint.createSprintService().getActiveSprint();
  }

  @AuraEnabled
  public static void createSprint(String name, Date startDate, Date endDate) {
    FactorySprint.createSprintService().createSprint(name, startDate, endDate);
  }

  @AuraEnabled
  public static void updateSprintDates(
    Id sprintId,
    Date newStartDate,
    Date newEndDate
  ) {
    FactorySprint.createSprintService()
      .updateSprintDates(sprintId, newStartDate, newEndDate);
  }

  @AuraEnabled(cacheable=true)
  public static List<Task__c> getTasksBySprint(Id sprintId) {
    return FactorySprint.createSprintService().getTasksBySprint(sprintId);
  }

  @AuraEnabled(cacheable=true)
  public static List<Task__c> getTasksFromActiveSprint() {
    return FactorySprint.createSprintService().getTasksFromActiveSprint();
  }
}
