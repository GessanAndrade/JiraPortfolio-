import { api, LightningElement, wire } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { subscribe, MessageContext } from 'lightning/messageService';
import SIMPLE_CHANNEL from '@salesforce/messageChannel/SimpleMessageChannel__c';

import updateDeveloper from '@salesforce/apex/DeveloperController.updateDeveloper';
import getDeveloperById from '@salesforce/apex/DeveloperController.getDeveloperById';
import getDeveloperByTaskId from '@salesforce/apex/TaskController.getDeveloperByTaskId';
import updateTaskDeveloper from '@salesforce/apex/TaskController.updateTaskDeveloper';
import getPointsByDeveloperActiveSprint from '@salesforce/apex/SprintTaskController.getPointsByDeveloperActiveSprint';
import Profile_undefined from '@salesforce/resourceUrl/Profile_undefined';
import Carga_Relax from '@salesforce/resourceUrl/Carga_Relax';
import Carga_Working from '@salesforce/resourceUrl/Carga_Working';
import Carga_Hard_Working from '@salesforce/resourceUrl/Carga_Hard_Working';
import Carga_Much_Working from '@salesforce/resourceUrl/Carga_Much_Working';

// Picklist (Salesforce UI API)
import { getObjectInfo, getPicklistValues } from 'lightning/uiObjectInfoApi';
import DEVELOPER_OBJECT from '@salesforce/schema/Developer__c';
import ROLE_FIELD from '@salesforce/schema/Developer__c.Role__c';
import LEVEL_FIELD from '@salesforce/schema/Developer__c.Level__c';

export default class DeveloperPanelLWC extends LightningElement {
    @api recordId;

    error;
    developer;

    profileImage = Profile_undefined;
    cargaImage = Carga_Relax;
    statusCarga = 'Relax';

    // Picklist options
    roleOptions = [];
    levelOptions = [];

    receivedMessage = '';

    subscribeToMessageChannel() {
        subscribe(this.messageContext, SIMPLE_CHANNEL, (message) => {
            if (message.Integer === 0) {
                this.processarDeveloper(message.Id);
                this.receivedMessage = message.Id;
            } else {
                updateTaskDeveloper({ taskId: this.recordId, developerId: message.Id })
                    .then(() => {
                        this.dispatchEvent(
                            new ShowToastEvent({
                                title: 'Sucesso!',
                                message: 'Developer atualizado com sucesso.',
                                variant: 'success'
                            })
                        );
                    })
                    .catch((error) => {
                        this.dispatchEvent(
                            new ShowToastEvent({
                                title: 'Erro ao atualizar',
                                message: 'Ocorreu um erro ao atualizar o developer.' + ' Detalhes: ' + error.body.message,
                                variant: 'error'
                            })
                        );
                    });
            }
        });
    }

    @wire(MessageContext) messageContext;

    @wire(getObjectInfo, { objectApiName: DEVELOPER_OBJECT }) objectInfo;

    @wire(getPicklistValues, {
        recordTypeId: '$objectInfo.data.defaultRecordTypeId',
        fieldApiName: ROLE_FIELD
    }) wiredRole({ data, error }) {
        if (data) {
            this.roleOptions = data.values;
        } else if (error) {
            console.error('Error loading Role picklist:', error);
        }
    }

    @wire(getPicklistValues, {
        recordTypeId: '$objectInfo.data.defaultRecordTypeId',
        fieldApiName: LEVEL_FIELD
    }) wiredLevel({ data, error }) {
        if (data) {
            this.levelOptions = data.values;
        } else if (error) {
            console.error('Error loading Level picklist:', error);
        }
    }

    processarDeveloper(developerIdcode) {
        getDeveloperById({ developerId: developerIdcode })
            .then((result) => {
                this.developer = {...result }; // As reticencias criam uma cópia do objeto, evitando que seja um proxy reativo. 
                // Um proxy reativo é um objeto que é monitorado para mudanças, e quando uma mudança ocorre, 
                // ele pode disparar atualizações na interface do usuário ou em outros lugares onde o objeto é usado. 
                // Ao criar uma cópia do objeto usando as reticências, você está criando um novo objeto que não é monitorado para mudanças, 
                // o que pode ser útil em alguns casos para evitar atualizações indesejadas ou para trabalhar com dados de forma mais controlada.

                //Depois de cadastrada a imagem no salesforce, você pode baixa-la para o seu projeto com sf project retrieve start -m StaticResource:Name_da_imagem.

                getPointsByDeveloperActiveSprint({ developerId: this.developer.Id })
                    .then((pointsDev) => {
                        this.updateCargaStatus(pointsDev);
                    })
                    .catch((error) => {
                        console.error('Error fetching points:', error);
                    });
            })
            .catch((error) => {
                this.error = error;
                console.error('Error fetching developer:', error);
            });
    }

    updateCargaStatus(pointsDev) {
        if (pointsDev <= 2) {
            this.cargaImage = Carga_Relax;
            this.statusCarga = 'Relax';
        } else if (pointsDev > 2 && pointsDev <= 5) {
            this.cargaImage = Carga_Working;
            this.statusCarga = 'Working';
        } else if (pointsDev > 5 && pointsDev <= 15) {
            this.cargaImage = Carga_Hard_Working;
            this.statusCarga = 'Hard Working';
        } else {
            this.cargaImage = Carga_Much_Working;
            this.statusCarga = 'Much Working';
        }
    }

    salvarAlteracoes() {
        updateDeveloper({ developer: this.developer })
            .then(() => {

                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Sucesso!',
                        message: 'Developer atualizado com sucesso.',
                        variant: 'success'
                    })
                );

            })
            .catch((error) => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Erro ao atualizar',
                        message: 'Ocorreu um erro ao atualizar o developer.',
                        variant: 'error'
                    })
                );
            });
    }

    handleNameChange(event) {
        this.developer.Name__c = event.target.value;
    }

    handleRoleChange(event) {
        this.developer.Role__c = event.detail.value;
    }

    handleLevelChange(event) {
        this.developer.Level__c = event.detail.value;
    }

    handleAgeChange(event) {
        this.developer.Age__c = event.target.value;
    }

    handleBioChange(event) {
        this.developer.Bio__c = event.target.value;
    }

    connectedCallback() {
        // Teste de comunicação via Message Service
        this.subscribeToMessageChannel();
        // Fim do teste de comunicação via Message Service

        getDeveloperByTaskId({ taskId: this.recordId })
            .then((devId) => {
                this.processarDeveloper(devId.Id);
            })
            .catch((error) => {
                this.error = error;
                console.error('Error fetching developer ID:', error);
            });
    }

    // Executado quando o componente sai da página
    disconnectedCallback() {

        // Se houver inscrição ativa
        if (this.subscription) {

            // Cancela a inscrição
            unsubscribe(this.subscription);

            // Limpa referência
            this.subscription = null;

            console.log('Unsubscribe executado.');
        }
    }
}