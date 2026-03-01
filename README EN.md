# Jira Lite (Salesforce) — Kanban + Sprint + Workload

Portfolio project that simulates a simplified Jira inside Salesforce using Apex + LWC.
Includes a drag-and-drop Kanban board, active sprint filtering, and automatic Developer workload calculation via Trigger.

## Stack
- Salesforce Platform
- Apex (Controllers / Services / Selectors)
- LWC (Kanban UI)
- Lightning Message Service (LMS)

---

## Features
- Kanban (To Do / Doing / Test / Done / Rejected) with drag-and-drop
- Active Sprint task listing
- Task Status update via Apex
- Developer selection/visualization (LWC)
- Automatic calculation of `Task_On__c` (number of open tasks per Developer)
- Total Developer points in the active sprint (sum of `Points__c`)

---

## Architecture (Apex)

### Controllers (`@AuraEnabled`)
- `TaskController`
- `SprintController`
- `DeveloperController`
- `AddressController`
- `SprintTaskController`

Responsibility: expose endpoints to LWC.

---

### Services (business rules + validations)
- `TaskService` (with AuraHandledException)
- `SprintService` (with AuraHandledException)
- `DeveloperService` (with AuraHandledException)
- `AddressService` (with AuraHandledException)
- `SprintTaskService` (with AuraHandledException)

Responsibility: validation, orchestration, and DML.

---

### Selectors (centralized SOQL)
- `TaskSelector`
- `SprintSelector`
- `SprintTaskSelector`
- `DeveloperSelector`
- `AddressSelector`

Responsibility: queries.

---

## Trigger / Handler
- `TasksOnDeveloperTrigger` (bulk-safe)
- `TaskHandler` (bulk-safe using AggregateResult + mass update)

Rule:  
`Developer__c.Task_On__c` = number of `Task__c` assigned to the developer where  
`Status__c NOT IN ('Done', 'Rejected')`.

---

## Required Objects and Fields

> Note: this repository does not yet include `force-app/main/default/objects/*`.
> Therefore, the objects/fields below must exist in the org (or you can retrieve and add them to the source).

### Address__c
- `City__c` (Text)
- `CEP__c` (Text)

### Developer__c
- `Name__c` (Text)
- `Address__c` (Lookup → Address__c)
- `Task_On__c` (Number)

Optional fields (used in UI/studies):
- `Age__c`, `Role__c`, `Level__c`, `Bio__c`, `Birth__c`, `Start_Job__c`

### Task__c
- `Title__c` (Text)
- `Status__c` (Picklist: To Do, Doing, Test, Done, Rejected)
- `Developer__c` (Lookup → Developer__c)
- `Points__c` (Number/Decimal)

### Sprint__c
- `Name` (Text)
- `Date_Begin__c` (Date)
- `Date_End__c` (Date)
- `Status__c` (Picklist: Active, Inactive, To Do)

### Sprint_Task__c
- `Sprint_FKN__c` (Lookup → Sprint__c)
- `Task__c` (Lookup → Task__c)

---

## Deploy (SFDX)

1) Login:
```bash
sf org login web -a MyOrg