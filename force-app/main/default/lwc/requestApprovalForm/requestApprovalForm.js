// requestApprovalForm.js
import { LightningElement, api } from 'lwc';

export default class RequestApprovalForm extends LightningElement {
    @api recordId;

    handleSubmit() {
        // Perform any submission logic here
    }

    handleProductChange(event) {
        // Handle the change in the Select_Product__c multi-picklist
        // You can use event.detail.value to get the selected values
        const selectedValues = event.detail.value;
        // Perform any logic or pass data to child components
    }
}