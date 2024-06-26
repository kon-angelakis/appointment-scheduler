// Check local storage for theme on page load
document.addEventListener('DOMContentLoaded', (event) => {
    const body = document.body;
    const icon = document.querySelector('.floating-btn .fas');
    //Session management for theme
    const theme = localStorage.getItem('theme');

    if (theme === 'light') {
        body.classList.add('light-theme');
        icon.classList.remove('fa-moon');
        icon.classList.add('fa-sun');
    }
});
// Toggles theme to the reverse of what it was and stores it locally
function toggleTheme() {
    const body = document.body;
    body.classList.toggle('light-theme');

    const icon = document.querySelector('.floating-btn .fas');
    if (body.classList.contains('light-theme')) {
        localStorage.setItem('theme', 'light');
        icon.classList.remove('fa-moon');
        icon.classList.add('fa-sun');
    } else {
        localStorage.setItem('theme', 'dark');
        icon.classList.remove('fa-sun');
        icon.classList.add('fa-moon');
    }
}