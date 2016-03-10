var StudentsDBUtils = {
  hide: function(eleSelector) {
    $(eleSelector).addClass('hidden');
  },
  show: function(eleSelector) {
    $(eleSelector).removeClass('hidden');
  },
  toggle: function(eleSelector) {
    $(eleSelector).toggleClass('hidden');
  }
};
