public with sharing class SprintController {
  @AuraEnabled(cacheable=true)
  public static List<Sprint__c> getAllSprints() {
    SprintDomain.validateSprintAcessibility();

    return SprintService.getAllSprints();
  }

  @AuraEnabled(cacheable=true)
  public static Sprint__c getActiveSprint() {
    SprintDomain.validateSprintAcessibility();

    return SprintService.getActiveSprint();
  }

  @AuraEnabled
  public static void createSprint(String name, Date startDate, Date endDate) {
    SprintDomain.validateSprintCreateability();

    SprintService.createSprint(name, startDate, endDate);
  }

  @AuraEnabled
  public static void updateSprintDates(
    Id sprintId,
    Date newStartDate,
    Date newEndDate
  ) {
    SprintDomain.validateSprintUpdateability();

    SprintService.updateSprintDates(sprintId, newStartDate, newEndDate);
  }

  @AuraEnabled(cacheable=true)
  public static List<Task__c> getTasksBySprint(Id sprintId) {
    SprintDomain.validateSprintAcessibility();

    return SprintService.getTasksBySprint(sprintId);
  }

  @AuraEnabled(cacheable=true)
  public static List<Task__c> getTasksFromActiveSprint() {
    SprintDomain.validateSprintAcessibility();

    return SprintService.getTasksFromActiveSprint();
  }
}
