import { LightningElement, track } from 'lwc';

export default class CaptchaCheckboxComponent extends LightningElement {
    recaptchaVerified = false;
    @track isCheckboxChecked = false;

    renderedCallback() {
        if (!window.grecaptcha) {
            const recaptchaScript = document.createElement('script');
            recaptchaScript.src = 'https://www.google.com/recaptcha/api.js';
            recaptchaScript.async = true;
            recaptchaScript.defer = true;
            recaptchaScript.onload = this.initializeRecaptcha.bind(this);
            document.body.appendChild(recaptchaScript);
        } else {
            this.initializeRecaptcha();
        }
    }

    initializeRecaptcha() {
        if (this.template.querySelector('.recaptcha-container').children.length === 0) {
            grecaptcha.render(this.template.querySelector('.recaptcha-container'), {
                /*'sitekey': '6LdwzHYqAAAAAP_WiQxU8jGffimOe1YFtNGiv4Xa', */
                'theme': 'light',
                'size': 'normal',
                'callback': () => {
                    this.recaptchaVerified = true;
                }
            });
        }
    }

    handleCheckboxChange(event) {
        this.isCheckboxChecked = event.target.checked;
    }

    handleSubmit() {
        if (this.isCheckboxChecked && this.recaptchaVerified) {
            alert('Verification successful! Proceeding...');
        } else {
            alert('Please check the checkbox and complete the reCAPTCHA.');
        }
    }
}