public with sharing class TaskDomain {
    
    public static void validateTaskFields(Task__c task) {
        if(String.isBlank(task.Title__c)) {
            throw new AuraHandledException('Title is required.');
        }
        if(task.Developer__c == null) {
            throw new AuraHandledException('Developer is required.');
        }
    }
    public static void validateTaskAcessibility() {
        if(!Schema.sObjectType.Task__c.isAccessible()) {
            throw new AuraHandledException('You do not have permission to access Task.');
        }
    }
    public static void validateTaskCreateability() {
        if(!Schema.sObjectType.Task__c.isCreateable()) {
            throw new AuraHandledException('You do not have permission to create Task.');
        }
    }
    public static void validateTaskUpdateability() {
        if(!Schema.sObjectType.Task__c.isUpdateable()) {
            throw new AuraHandledException('You do not have permission to update Task.');
        }
    }
    public static void validateTaskDeletability() {
        if(!Schema.sObjectType.Task__c.isDeletable()) {
            throw new AuraHandledException('You do not have permission to delete Task.');
        }
    }
    
}