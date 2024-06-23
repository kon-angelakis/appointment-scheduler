const fields = ['firstName', 'lastName', 'email', 'username', 'password', 'department'];
const submitButton = document.getElementById('submitButton');

fields.forEach(field => {
    document.getElementById(field).addEventListener('input', validateForm);
});

function validateForm() {
    let isValid = true;
    isValid &= validateField('firstName', /^[A-Za-z\s-]+$/, 'Invalid first name');
    isValid &= validateField('lastName', /^[A-Za-z\s-]+$/, 'Invalid last name');
    isValid &= validateField('email', /^[^\s@]+@[^\s@]+\.[^\s@]+$/, 'Invalid email address');
    isValid &= validateField('username', /^[a-z0-9._]+$/, 'Invalid username');
    isValid &= validateField('password', /^(?=.*[A-Z])(?=.*[0-9!@#$%^&*(),.?":{}|<>]).{8,}$/, 'Invalid password');
    isValid &= document.getElementById('department').value !== '';
    toggleSubmitButton(isValid);
}

