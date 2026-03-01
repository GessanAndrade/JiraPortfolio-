public with sharing class SprintController {

    @AuraEnabled(cacheable=true)
    public static List<Sprint__c> getAllSprints() {
        return SprintService.getAllSprints();
    }

    @AuraEnabled(cacheable=true)
    public static Sprint__c getActiveSprint() {
        return SprintService.getActiveSprint();
    }

    @AuraEnabled
    public static void createSprint(String name, Date startDate, Date endDate) {
        SprintService.createSprint(name, startDate, endDate);
    }

    @AuraEnabled
    public static void updateSprintDates(Id sprintId, Date newStartDate, Date newEndDate) {
        SprintService.updateSprintDates(sprintId, newStartDate, newEndDate);
    }

    @AuraEnabled(cacheable=true)
    public static List<Task__c> getTasksBySprint(Id sprintId) {
        return SprintService.getTasksBySprint(sprintId);
    }

    @AuraEnabled(cacheable=true)
    public static List<Task__c> getTasksFromActiveSprint() {    
        return SprintService.getTasksFromActiveSprint();
    }
}