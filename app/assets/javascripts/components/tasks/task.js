function Task(element) {
  this.element = $(element);
}

Task.prototype.bindEvents = function () {
  this.element.on('ajax:success', '[data-create-task]', this._onCreate);
  this.element.on('ajax:success', '[data-update-task]', this._onUpdate);
  this.element.on('ajax:success', '[data-destroy-task]', this._onDestroy);
};

Task.prototype._onCreate = function (event, data) {
  var target = $(event.delegateTarget);

  target.find('[data-list-tasks]').append(data);
};

Task.prototype._onUpdate = function (event, data) {
  var target = $(event.target);

  target.parents('[data-update-task]').replaceWith(data);
};

Task.prototype._onDestroy = function (event, data) {
  var target = $(event.target);

  target.parents('[data-destroy-task]').hide('slow');
};
