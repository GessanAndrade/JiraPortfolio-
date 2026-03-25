public with sharing class Helper {
    public List<Developer__c> createFakeDevelopers(Integer count, Id addressId) {
        List<Developer__c> developers = new List<Developer__c>();
        for (Integer i = 0; i < count; i++) {
            developers.add(new Developer__c(
                Name__c = 'Developer ' + i,
                Age__c = 25 + i,
                Bio__c = 'Bio for Developer ' + i,
                Address__c = addressId,
                Birth__c = Date.newInstance(1990, 1, 1).addDays(i * 365),
                Level__c = 'Junior',
                Role__c = 'Developer',
                Start_Job__c = Date.today().addDays(-i * 30),
                Task_On__c = i
            ));
        }
        return developers;
    }

    public List<Task__c> createFakeTasks(Integer count, Id developerId) {
        List<Task__c> tasks = new List<Task__c>();
        for (Integer i = 0; i < count; i++) {
            tasks.add(new Task__c(
                Status__c = 'To Do',
                Title__c = 'Task Title ' + i,
                Developer__c = developerId
            ));
        }
        return tasks;
    }

    public List<Address__c> createFakeAddresses(Integer count) {
        List<Address__c> addresses = new List<Address__c>();
        for (Integer i = 0; i < count; i++) {
            addresses.add(new Address__c(
                City__c = 'City ' + i,
                CEP__c = 'CEP' + i
            ));
        }
        return addresses;
    }

    public List<Sprint__c> createFakeSprints(Integer count) {
        List<Sprint__c> sprints = new List<Sprint__c>();
        for (Integer i = 0; i < count; i++) {
            sprints.add(new Sprint__c(
                Status__c = 'Active',
                Date_Begin__c = Date.today().addDays(i * 7),
                Date_End__c = Date.today().addDays((i + 1) * 7)
            ));
        }
        return sprints;
    }

    public List<Sprint_Task__c> createFakeSprintTasks(Integer count, Id sprintId, Id taskId) {
        List<Sprint_Task__c> sprintTasks = new List<Sprint_Task__c>();
        for (Integer i = 0; i < count; i++) {
            sprintTasks.add(new Sprint_Task__c(
                Sprint_FKN__c = sprintId,
                Task__c = taskId
            ));
        }
        return sprintTasks;
    }
}