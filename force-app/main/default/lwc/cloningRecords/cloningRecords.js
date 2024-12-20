import { LightningElement, wire, track } from 'lwc';
import getObjectNames from '@salesforce/apex/cloneController.getObjectNames';

export default class CloningRecords extends LightningElement {
isTrue = false;
objectOptions = [];
@track selectedObject;

handleClick(){
    this.isTrue = true;
}
closeModal(){
    this.isTrue = false;
}

@wire(getObjectNames)
objectNames({ data, error }) {
    if (data) {
        this.objectOptions = data.map(objName => ({ label: objName, value: objName }));
    } else if (error) {
        // Handle error
    }
}


clickNext(event){
    this.selectedObject = event.detail.value;
    alert('You clicked Next : '+ selectedObject);
}

}