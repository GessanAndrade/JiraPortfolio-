public with sharing class TaskController {

    @AuraEnabled(cacheable=true)
    public static List<Task__c> getTasksByDeveloper(Id developerId) {

        if(!Schema.sObjectType.Task__c.isAccessible()){
            throw new AuraHandledException('You do not have permission to access Task.');
        }

        return TaskService.getTasksByDeveloper(developerId);
    }

    @AuraEnabled(cacheable=true)
    public static Task__c getTaskById(Id taskId) {

        if(!Schema.sObjectType.Task__c.isAccessible()){
            throw new AuraHandledException('You do not have permission to access Task.');
        }

        return TaskService.getTaskById(taskId);
    }

    @AuraEnabled(cacheable=true)
    public static Developer__c getDeveloperByTaskId(Id taskId){

        if(!Schema.sObjectType.Task__c.isAccessible()){
            throw new AuraHandledException('You do not have permission to access Task.');
        }

        return TaskService.getDeveloperByTaskId(taskId);
    }

    @AuraEnabled
    public static void updateTaskDeveloper(Id taskId, Id developerId) {

        if(!Schema.sObjectType.Task__c.isUpdateable()){
            throw new AuraHandledException('You do not have permission to update Task.');
        }

        TaskService.updateTaskDeveloper(taskId, developerId);
    }

    @AuraEnabled
    public static void updateTaskStatus(Id taskId, String newStatus) {

        if(!Schema.sObjectType.Task__c.isUpdateable()){
            throw new AuraHandledException('You do not have permission to update Task.');
        }

       TaskService.updateTaskStatus(taskId, newStatus);
    }
}