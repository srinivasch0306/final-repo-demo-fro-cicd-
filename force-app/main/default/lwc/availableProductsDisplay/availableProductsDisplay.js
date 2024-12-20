import { LightningElement, api, wire } from 'lwc';
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';
import getAvailableProducts from '@salesforce/apex/AvailableProductsController.getAvailableProducts';

const fields = ['Request_Product__c.Select_Product__c'];

export default class AvailableProductsDisplay extends LightningElement {
    @api recordId;
    availableProducts;
    selectedValues;

    @wire(getRecord, { recordId: '$recordId', fields })
    wiredRecord(response) {
        if (response.data) {
            this.selectedValues = getFieldValue(response.data, 'Request_Product__c.Select_Product__c');
            this.handleMultiPicklistChange();
        } else if (response.error) {
            // Handle error
        }
    }

    handleMultiPicklistChange(event) {
        this.selectedValues = event.detail.value;
        if (this.selectedValues) {
            getAvailableProducts({ selectedValues: this.selectedValues })
                .then(result => {
                    this.availableProducts = result;
                })
                .catch(error => {
                    // Handle error
                });
        } else {
            this.availableProducts = null;
        }
    }

    showToast(title, message, variant) {
        const event = new ShowToastEvent({
            title: title,
            message: message,
            variant: variant
        });
        this.dispatchEvent(event);
    }
}