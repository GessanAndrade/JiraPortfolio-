public with sharing class TaskSelector {
    public static List<Task__c> getTasksByTasksIds(List<Id> taskIds){
        
        List<Task__c> tasks = [SELECT Name, Status__c, Title__c, Developer__r.Name__c, Developer__r.Id, Points__c FROM Task__c WHERE Id IN :taskIds];

        SObjectAccessDecision decision =
            Security.stripInaccessible(
                AccessType.READABLE,
                tasks
            );

        return (List<Task__c>)decision.getRecords();
    }

    public static List<Task__c> getTaskByDeveloper(Id developerId){
       
        List<Task__c> tasks = [SELECT Name, Status__c, Title__c, Developer__r.Name__c, Developer__r.Id, Points__c FROM Task__c WHERE Developer__c = :developerId];

        SObjectAccessDecision decision =
            Security.stripInaccessible(
                AccessType.READABLE,
                tasks
            );

        return (List<Task__c>)decision.getRecords();
    }

    public static List<Task__c> getTasksFromSprintTasksAndIdDeveloper(List<Id> taskIds, Id developerId) {
        return [SELECT Id, Title__c, Developer__r.Name__c, Developer__r.Id, Points__c FROM Task__c WHERE Id IN :taskIds AND Developer__c = :developerId];
    }

    public static Task__c getTaskById(Id taskId){
       
        Task__c task = [SELECT Id, Title__c, Developer__r.Name__c, Developer__r.Id, Points__c FROM Task__c WHERE Id = :taskId];

        SObjectAccessDecision decision =
            Security.stripInaccessible(
                AccessType.READABLE,
                new List<Task__c>{task}
            );

        return (Task__c)decision.getRecords()[0];
    }

}