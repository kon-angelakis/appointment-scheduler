const fields = ['firstName', 'lastName', 'email', 'am', 'password'];
const submitButton = document.getElementById('submitButton');

fields.forEach(field => {
    document.getElementById(field).addEventListener('input', validateForm);
});

function validateForm() {
    let isValid = true;
    isValid &= validateField('firstName', /^[A-Za-z\s-]+$/, 'Invalid first name');
    isValid &= validateField('lastName', /^[A-Za-z\s-]+$/, 'Invalid last name');
    isValid &= validateField('email', /^[^\s@]+@[^\s@]+\.[^\s@]+$/, 'Invalid email address');
    isValid &= validateField('am', /^[pP]\d{5}$/, 'Invalid username');
    isValid &= validatePassword();
    toggleSubmitButton(isValid);
}
