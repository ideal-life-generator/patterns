// var module = {
//   counter: 0,
//   incrementCounter: function() {
//     return ++this.counter;
//   },
//   resetCounter: function() {
//     return this.counter = 0;
//   }
// };

var module = (function() {

  var counter = 0;

  return {
    incrementCounter: function() {
      return ++counter;
    },
    resetCounter: function() {
      return counter = 0;
    }.
    getCounter: function() {
      return counter;
    }
  }

})();