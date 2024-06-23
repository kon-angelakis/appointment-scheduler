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