public with sharing class TaskController {

    @AuraEnabled(cacheable=true)
    public static List<Task__c> getTasksByDeveloper(Id developerId) {
        return TaskService.getTasksByDeveloper(developerId);
    }

    @AuraEnabled(cacheable=true)
    public static Task__c getTaskById(Id taskId) {
        return TaskService.getTaskById(taskId);
    }

    @AuraEnabled(cacheable=true)
    public static Developer__c getDeveloperByTaskId(Id taskId){
        return TaskService.getDeveloperByTaskId(taskId);
    }

    @AuraEnabled
    public static void updateTaskDeveloper(Id taskId, Id developerId) {
        TaskService.updateTaskDeveloper(taskId, developerId);
    }

    @AuraEnabled
    public static void updateTaskStatus(Id taskId, String newStatus) {
       TaskService.updateTaskStatus(taskId, newStatus);
    }
}