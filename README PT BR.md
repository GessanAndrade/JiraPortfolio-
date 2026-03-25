# Jira Lite (Salesforce) — Kanban + Sprint + Workload

Projeto de portfólio que simula um Jira simplificado dentro da Salesforce usando Apex + LWC.
Inclui Kanban com drag-and-drop, sprint ativa e cálculo automático de carga de trabalho por Developer via Trigger.

## Stack

- Salesforce Platform
- Apex (Controllers / Services / Selectors)
- LWC (Kanban UI)
- Lightning Message Service (LMS)
- GitHub Actions (CI para lint e testes LWC)

---

## Funcionalidades

- Kanban (To Do / Doing / Test / Done / Rejected) com drag-and-drop
- Listagem de tasks da Sprint ativa
- Alteração de Status da Task via Apex
- Seleção/visualização de Developer (LWC)
- Cálculo automático de `Task_On__c` (quantidade de tasks abertas por Developer)
- Pontuação total do Developer na sprint ativa (soma de `Points__c`)

---

## Arquitetura (Apex)

### Controllers (`@AuraEnabled`)

- `TaskController`
- `SprintController`
- `DeveloperController`
- `AddressController`
- `SprintTaskController`

Responsabilidade: expor endpoints para LWC.

### Services (regras + validações)

- `TaskService` (com AuraHandledException)
- `SprintService` (com AuraHandledException)
- `DeveloperService` (com AuraHandledException)
- `AddressService` (com AuraHandledException)
- `SprintTaskService` (com AuraHandledException)

Responsabilidade: validação, orquestração e DML.

### Selectors (SOQL centralizado)

- `TaskSelector`
- `SprintSelector`
- `SprintTaskSelector`
- `DeveloperSelector`
- `AddressSelector`

Responsabilidade: consultas.

---

## Trigger / Handler

- `TasksOnDeveloperTrigger` (bulk-safe)
- `TaskHandler` (bulk-safe com AggregateResult + update em massa)

Regra: `Developer__c.Task_On__c` = quantidade de `Task__c` do developer onde `Status__c NOT IN ('Done', 'Rejected')`.

---

## Objetos e Campos Necessários

> Observação: este repositório ainda não inclui `force-app/main/default/objects/*`.
> Portanto, os objetos/campos abaixo precisam existir na org (ou você pode fazer retrieve e adicioná-los ao source).

### Address\_\_c

- `City__c` (Text)
- `CEP__c` (Text)

### Developer\_\_c

- `Name__c` (Text)
- `Address__c` (Lookup → Address\_\_c)
- `Task_On__c` (Number)

Campos opcionais (usados em UI/estudos):

- `Age__c`, `Role__c`, `Level__c`, `Bio__c`, `Birth__c`, `Start_Job__c`

### Task\_\_c

- `Title__c` (Text)
- `Status__c` (Picklist: To Do, Doing, Test, Done, Rejected)
- `Developer__c` (Lookup → Developer\_\_c)
- `Points__c` (Number/Decimal)

### Sprint\_\_c

- `Name` (Text)
- `Date_Begin__c` (Date)
- `Date_End__c` (Date)
- `Status__c` (Picklist: Active, Inactive, To Do)

### Sprint_Task\_\_c

- `Sprint_FKN__c` (Lookup → Sprint\_\_c)
- `Task__c` (Lookup → Task\_\_c)

---

## Deploy (SFDX)

1. Login:

```bash
sf org login web -a MyOrg
```
