trigger TasksOnDeveloperTrigger on Task__c (after insert, after update, before delete) {
    Set<Id> developerIds = new Set<Id>();

    if (Trigger.isAfter && (Trigger.isInsert || Trigger.isUpdate)) {
        for (Task__c t : Trigger.new) {
            if (t.Developer__c != null) developerIds.add(t.Developer__c);

            if (Trigger.isUpdate) {
                Task__c oldT = Trigger.oldMap.get(t.Id);
                if (oldT != null && oldT.Developer__c != null && oldT.Developer__c != t.Developer__c) {
                    developerIds.add(oldT.Developer__c);
                }
            }
        }
    }

    if (Trigger.isBefore && Trigger.isDelete) {
        for (Task__c t : Trigger.old) {
            if (t.Developer__c != null) developerIds.add(t.Developer__c);
        }
    }

    if (!developerIds.isEmpty()) {
        TaskHandler.updateDeveloperTaskOn(developerIds);
    }
}