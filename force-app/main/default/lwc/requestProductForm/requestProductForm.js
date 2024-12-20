// requestProductForm.js
import { LightningElement, track, wire } from 'lwc';
import getAvailableProducts from '@salesforce/apex/RequestProductController.getAvailableProducts';
import createRequestProduct from '@salesforce/apex/RequestProductController.createRequestProduct';

export default class RequestProductForm extends LightningElement {
    @track selectedProducts = [];
    @track availableProducts = [];
    @track recordCount = 0;
    @track error = '';
    @track recordCreated = false;

    // Computed property to filter out duplicate products
    get uniqueAvailableProducts() {
        return [...new Set(this.availableProducts)];
    }

    handleProductChange(event) {
        this.selectedProducts = event.detail.value;

        if (this.selectedProducts.length > 0) {
            getAvailableProducts({ selectedValues: this.selectedProducts })
                .then(result => {
                    if (result.error) {
                        console.error('Error fetching available products:', result.error);
                        this.error = 'Error fetching available products: ' + result.error;
                        this.recordCount = 0; // Reset record count if there's an error
                    } else {
                        console.log('Available Products:', result.availableProducts);
                        console.log('Record Count:', result.recordCount);
                        this.availableProducts = result.availableProducts;
                        this.recordCount = result.recordCount;
                        this.error = ''; // Clear any previous errors
                    }
                })
                .catch(error => {
                    console.error('Error fetching available products:', error);
                    this.error = 'Error fetching available products: ' + error.message;
                    this.recordCount = 0; // Reset record count if there's an error
                });
        } else {
            this.availableProducts = [];
            this.recordCount = 0;
            this.error = ''; // Clear any previous errors
        }
    }

    handleSubmit() {
        // Check if there are no available products before submitting
        if (this.recordCount === 0) {
            this.error = 'No products available. Please select at least one product.';
        } else {
            // Clear the previous error before submitting
            this.error = '';
            this.template.querySelector('lightning-record-edit-form').submit();
        }
    }

    handleSuccess(event) {
        console.log('Request Product created successfully', event.detail.id);
        this.recordCreated = true;
        this.dispatchEvent(new CustomEvent('submit'));
    }

    // Updated onerror handler to handle the validation rule error
    handleError(event) {
        console.error('Error creating Request Product:', event.detail.message);
        this.error = event.detail.output.errors[0].message;
    }
}