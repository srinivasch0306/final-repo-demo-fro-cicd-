public with sharing class RecaptchaController {
    @AuraEnabled
    public static Boolean verifyCaptcha(String recaptchaResponse) {
        // Replace with your Google reCAPTCHA secret key
        String secretKey = '6Lf1o3YqAAAAACxIMPoF30WNR6vhMAd6AYdgTsjo';
        
        // Construct the URL to verify the reCAPTCHA response with Google's API
        String verifyUrl = 'https://www.google.com/recaptcha/api/siteverify';
        HttpRequest req = new HttpRequest();
        req.setEndpoint(verifyUrl);
        req.setMethod('POST');
        
        // Add parameters to the request
        req.setBody('secret=' + secretKey + '&response=' + recaptchaResponse);
        req.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        
        Http http = new Http();
        HttpResponse res = http.send(req);
        
        // Parse the response from Google reCAPTCHA
        if (res.getStatusCode() == 200) {
            // Parse JSON response
            Map<String, Object> result = (Map<String, Object>)JSON.deserializeUntyped(res.getBody());
            Boolean success = (Boolean)result.get('success');
            return success;
        }
        
        return false;
    }
}