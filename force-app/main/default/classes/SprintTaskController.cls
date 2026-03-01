public with sharing class SprintTaskController {

    @AuraEnabled(cacheable=true)
    public static List<Task__c> getTasksBySprintTasks(List<Id> taskIds) {
        return TaskService.getTasksByTasksIds(taskIds);
    }

    @AuraEnabled(cacheable=true)
    public static List<Task__c> getTasksFromSprintTasksAndIdDeveloper(List<Id> taskIds, Id developerId) {
        return TaskService.getTasksFromSprintTasksAndIdDeveloper(taskIds, developerId);
    }

    @AuraEnabled
    public static void createTaskBySprint(Id sprintId, Id task) {
        SprintTaskService.createTaskBySprint(sprintId, task);
    }

    @AuraEnabled
    public static void updateTaskStatus(Id taskId, String newStatus) {
        SprintTaskService.updateTaskStatus(taskId, newStatus);
    }

    @AuraEnabled(cacheable=true)
    public static Decimal getPointsByDeveloperActiveSprint(Id developerId) {
        return SprintTaskService.getPointsByDeveloperActiveSprint(developerId);
    }
}