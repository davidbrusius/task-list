function FavoriteList(element) {
  this.element = $(element);
}

FavoriteList.prototype.bindEvents = function () {
  this.element.on('ajax:success', '[data-create-favorite]', this._onCreate);
  this.element.on('ajax:success', '[data-destroy-favorite]', this._onDestroy);
};

FavoriteList.prototype._onCreate = function (event, data) {
  var target = $(event.delegateTarget);

  target.find('[data-create-favorite]').replaceWith(data);
};

FavoriteList.prototype._onDestroy = function (event, data) {
  var target = $(event.delegateTarget);

  target.find('[data-destroy-favorite]').replaceWith(data);
};
