import { LightningElement, track } from 'lwc';
import createTimeSheet from '@salesforce/apex/TimeSheetsController.createTimeSheet';
import getEmployees from '@salesforce/apex/TimeSheetsController.getEmployees';
import getWorkItems from '@salesforce/apex/TimeSheetsController.getWorkItems';

export default class TimeSheetForm extends LightningElement {
    @track employeeId;
    @track workItemId;
    @track weekStartDate;
    @track weekEndDate;
    @track hours = {};

    employeeOptions = [];
    workItemOptions = [];

    days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];

    connectedCallback() {
        // Fetch employees and work items (masters) options
        this.fetchEmployees();
        this.fetchWorkItems();
    }

    fetchEmployees() {
        getEmployees()
            .then(result => {
                this.employeeOptions = result.map(emp => ({
                    label: emp.Name,
                    value: emp.Id
                }));
            })
            .catch(error => {
                console.error('Error fetching employees: ' + JSON.stringify(error));
            });
    }

    fetchWorkItems() {
        getWorkItems()
            .then(result => {
                this.workItemOptions = result.map(item => ({
                    label: item.Name,
                    value: item.Id
                }));
            })
            .catch(error => {
                console.error('Error fetching work items: ' + JSON.stringify(error));
            });
    }

    handleEmployeeChange(event) {
        this.employeeId = event.detail.value;
    }

    handleWorkItemChange(event) {
        this.workItemId = event.detail.value;
    }

    handleWeekChange(event) {
        // Handle week change if necessary
    }

    handleHourChange(event) {
        const day = event.target.label;
        this.hours[day] = event.target.value;
    }

    createTimesheet() {
        // Call Apex method to create timesheet
        createTimeSheet({ 
            employeeId: this.employeeId, 
            workItemId: this.workItemId,
            weekStartDate: this.weekStartDate, 
            weekEndDate: this.weekEndDate, 
            hours: this.hours 
        })
            .then(result => {
                // Handle successful creation
                console.log('Timesheet created successfully: ' + result);
            })
            .catch(error => {
                // Handle error
                console.error('Error creating timesheet: ' + JSON.stringify(error));
            });
    }
}