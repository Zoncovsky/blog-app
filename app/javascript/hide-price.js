document.addEventListener('DOMContentLoaded', function() {
  var postTypeSelect = document.getElementById('post_post_type');
  var priceField = document.getElementById('post_price_field');

  function togglePriceFieldVisibility() {
    if (postTypeSelect && postTypeSelect.value === 'text_post') {
      priceField.style.display = 'none';
    } else {
      priceField.style.display = 'block';
    }
  }

  togglePriceFieldVisibility();

  if (postTypeSelect) {
    postTypeSelect.addEventListener('change', togglePriceFieldVisibility);
  }
});
