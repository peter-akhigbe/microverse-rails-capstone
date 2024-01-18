// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

const footerBtn = document.querySelector('.footer-btn');
const formBtn = document.querySelector('.form-btn');

footerBtn.addEventListener('click', () => {
    formBtn.click();
});