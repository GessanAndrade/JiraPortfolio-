public with sharing class SprintService {

    public static List<Task__c> getTasksBySprint(Id sprintId) {
        if (sprintId == null) {
            throw new AuraHandledException('SprintId cannot be null.');
        }

        try {
            List<Sprint_Task__c> sprintTasks = SprintTaskSelector.getListTasksBySprint(sprintId);

            if (sprintTasks == null || sprintTasks.isEmpty()) {
                return new List<Task__c>();
            }

            Set<Id> taskIdsSet = new Set<Id>();
            for (Sprint_Task__c st : sprintTasks) {
                if (st.Task__c != null) taskIdsSet.add(st.Task__c);
            }

            if (taskIdsSet.isEmpty()) {
                return new List<Task__c>();
            }

            return TaskSelector.getTasksByTasksIds(new List<Id>(taskIdsSet));
        } catch (Exception e) {
            throw new AuraHandledException('Unable to load tasks for sprint.');
        }
    }

    public static List<Task__c> getTasksFromActiveSprint() {
        try {
            Sprint__c sprint = SprintService.getActiveSprint();

            if (sprint == null) {
                return new List<Task__c>();
            }

            List<Sprint_Task__c> tasks = SprintTaskSelector.getListTasksBySprint(sprint.Id);

            if (tasks == null || tasks.isEmpty()) {
                return new List<Task__c>();
            }

            Set<Id> taskIdsSet = new Set<Id>();
            for (Sprint_Task__c st : tasks) {
                if (st.Task__c != null) taskIdsSet.add(st.Task__c);
            }

            if (taskIdsSet.isEmpty()) {
                return new List<Task__c>();
            }

            return TaskSelector.getTasksByTasksIds(new List<Id>(taskIdsSet));
        } catch (Exception e) {
            throw new AuraHandledException('Unable to load tasks from active sprint.');
        }
    }

    public static List<Sprint__c> getAllSprints() {
        try {
            return SprintSelector.getAllSprints();
        } catch (Exception e) {
            throw new AuraHandledException('Unable to load sprints.');
        }
    }

    public static Sprint__c getActiveSprint() {
        try {
            List<Sprint__c> activeSprints = SprintSelector.getActiveSprints();
            return (activeSprints == null || activeSprints.isEmpty()) ? null : activeSprints[0];
        } catch (Exception e) {
            throw new AuraHandledException('Unable to load active sprint.');
        }
    }

    public static void createSprint(String name, Date startDate, Date endDate) {
        if (startDate == null || endDate == null) {
            throw new AuraHandledException('StartDate and EndDate are required.');
        }

        if (endDate < startDate) {
            throw new AuraHandledException('EndDate cannot be before StartDate.');
        }

        Sprint__c sprint = new Sprint__c(
            Date_Begin__c = startDate,
            Date_End__c = endDate,
            Status__c = 'to do'
        );

        try {
            insert sprint;
        } catch (DmlException e) {
            throw new AuraHandledException('Unable to create sprint.');
        }
    }

    public static void updateSprintDates(Id sprintId, Date newStartDate, Date newEndDate) {
        if (sprintId == null) {
            throw new AuraHandledException('SprintId is required.');
        }

        if (newStartDate == null || newEndDate == null) {
            throw new AuraHandledException('StartDate and EndDate are required.');
        }

        if (newEndDate < newStartDate) {
            throw new AuraHandledException('EndDate cannot be before StartDate.');
        }

        Sprint__c sprint = SprintSelector.getSprintById(sprintId);
        if (sprint == null) {
            throw new AuraHandledException('Sprint not found.');
        }

        sprint.Date_Begin__c = newStartDate;
        sprint.Date_End__c = newEndDate;

        try {
            update sprint;
        } catch (DmlException e) {
            throw new AuraHandledException('Unable to update sprint dates.');
        }
    }
}