function validateField(fieldId, regex, errorMessage) {
    const input = document.getElementById(fieldId);
    const errorIcon = document.getElementById('error-' + fieldId);
    const tooltip = document.getElementById('tooltip-' + fieldId);

    const isValid = regex.test(input.value);
    if (!isValid && input.value !== '') {
        errorIcon.style.display = 'inline';
        tooltip.innerText = errorMessage;
    } else {
        errorIcon.style.display = 'none';
    }
    return isValid;
}


function validatePassword() {
    const passwordInput = document.getElementById('password');
    const errorIcon = document.getElementById('error-password');
    const tooltip = document.getElementById('tooltip-password');
    const requirementSpecial = document.getElementById('requirement-special');
    const requirementUppercase = document.getElementById('requirement-uppercase');
    const requirementLength = document.getElementById('requirement-length');
    const password = passwordInput.value;

    tooltip.style.display = 'none';
    errorIcon.style.display = 'none';
    // Check for special character
    const hasSpecialChar = /[!@#$%^&*(),.?":{}|<>]/.test(password);
    if (hasSpecialChar) {
        requirementSpecial.style.textDecoration = 'line-through';
    } else {
        requirementSpecial.style.textDecoration = 'none';
    }

    // Check for uppercase letter
    const hasUpperCase = /[A-Z]/.test(password);
    if (hasUpperCase) {
        requirementUppercase.style.textDecoration = 'line-through';
    } else {
        requirementUppercase.style.textDecoration = 'none';
    }

    // Check for length
    const isLengthValid = password.length >= 8;
    if (isLengthValid) {
        requirementLength.style.textDecoration = 'line-through';
    } else {
        requirementLength.style.textDecoration = 'none';
    }

    // Update tooltip visibility based on all conditions
    if ((!hasSpecialChar || !hasUpperCase || !isLengthValid) && password !== "")  {
        tooltip.style.display = 'block';
        errorIcon.style.display = 'inline';
        return false;

    } else {
        if (password !== ""){
            tooltip.style.display = 'none';
            errorIcon.style.display = 'none';
            return true;
        }

    }
}


function toggleSubmitButton(isValid) {
    if (isValid) {
        submitButton.disabled = false;
        submitButton.classList.remove('disabled');
    } else {
        submitButton.disabled = true;
        submitButton.classList.add('disabled');
    }
}

document.addEventListener('DOMContentLoaded', validateForm);