var app = window.app = {};

app.Ingredients = function() {
  this._input = $('#ingredient-search-1');
  this._initAutocomplete();
};

app.Ingredients.prototype = {

};


_initAutocomplete = function() {
  this._input
    .autocomplete({
      source: '/ingredients',
      appendTo: '#ingredients-results-1',
      select: $.proxy(this._select, this)
    })
    .autocomplete('instance')._renderItem = $.proxy(this._render, this);
}

_select = function(e, ui) {
  this._input.val(ui.item.name);
  return false;
}

_render = function(ul, item) {
  var markup = [
    '<span class="name">' + item.name + '</span>',
  ];
  return $('<li>')
    .append(markup.join(''))
    .appendTo(ul);
}
