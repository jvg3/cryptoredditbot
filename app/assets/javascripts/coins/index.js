var Coin = Coin || {};

Coin.init = function() {
  $.ajax({
    method: 'GET',
    url: 'https://api.coinmarketcap.com/v1/ticker/',
    success: function (data) {
      console.log(data);
      console.log('good');
      $.each(data, function (key, value) {

        $('.hour-' + value.symbol).html(value.percent_change_1h)
        $('.day-' + value.symbol).html(value.percent_change_7d)
        $('.week-' + value.symbol).html(value.percent_change_24h)

        if (parseInt(value.percent_change_1h) > 1) {
          $('.hour-' + value.symbol).addClass('red')
        } else {
          $('.hour-' + value.symbol).addClass('green')
        }

        if (parseInt(value.percent_change_7d) > 1) {
          $('.day-' + value.symbol).addClass('red')
        } else {
          $('.day-' + value.symbol).addClass('green')
        }

        if (parseInt(value.percent_change_24h) > 1) {
          $('.week-' + value.symbol).addClass('red')
        } else {
          $('.week-' + value.symbol).addClass('green')
        }

      });

    },
    error: function(jxHR) {
      console.log(jxHR);
      console.log('ya fucked up');
    }
  })
}