var Coin = Coin || {};

$(document).ready(() => {
  console.log('DOC READY')
  Coin.init();
});

Coin.init = function() {
  console.log('KICK OFF AJAX');
  $.ajax({
    method: 'GET',
    url: 'https://api.coinmarketcap.com/v1/ticker/',
    success: function (data) {
      console.log('coinbase success');
      $.each(data, function (key, value) {

        $('.price-' + value.symbol).html(value.price_usd);
        $('.hour-' + value.symbol).html(value.percent_change_1h + '%');
        $('.day-' + value.symbol).html(value.percent_change_7d + '%');
        $('.week-' + value.symbol).html(value.percent_change_24h + '%');

        var floats = [
          parseFloat(value.percent_change_1h),
          parseFloat(value.percent_change_7d),
          parseFloat(value.percent_change_24h)
        ]

        floats = $.map(floats, (val) => {
          var score = val + 50.0;
          if (score < 0) { score = 0; }
          if (score > 90) { score = 90; }
          return Math.floor(score/10);
        });

        $('.hour-' + value.symbol).addClass('score score-' + floats[0]);
        $('.day-' + value.symbol).addClass('score score-' + floats[1]);
        $('.week-' + value.symbol).addClass('score score-' + floats[2]);

        // console.log(res);

        // if (parseFloat(value.percent_change_1h) < 0) {
        //   $('.hour-' + value.symbol).addClass('red');
        // } else {
        //   $('.hour-' + value.symbol).addClass('green');
        // }

        // if (parseFloat(value.percent_change_7d) < 0) {
        //   $('.day-' + value.symbol).addClass('red');
        // } else {
        //   $('.day-' + value.symbol).addClass('green');
        // }

        // if (parseFloat(value.percent_change_24h) < 0) {
        //   $('.week-' + value.symbol).addClass('red');
        // } else {
        //   $('.week-' + value.symbol).addClass('green');
        // }

      });

    },
    error: function(jxHR) {
      console.log(jxHR);
      alert('u broke coinbase??');
    }
  });

  $('form.add-coin-form').on('submit', (e) => {
    e.preventDefault();

    $.ajax({
      method: 'POST',
      url: '/coins.json',
      data: {
        sym: $('#sym').val(),
        name: $('#name').val()
      },
      success: (data) => {
        alert('cool');
      },
      error: (error) => {
        alert(error.responseText);
      }
    });
  });

  $('.add-coin-link').off('click').on('click', (e) => {
    $('.add-coin-link').addClass('hidden');
    $('.add-coin-form').removeClass('hidden');
  });

  $('.source-filter').off('change').on('change', (e) => {
    console.log("ON CHANGE")
    var source = e.target.value;
    $.ajax({
      url: '/coins.js?source=' + source,
      method: 'get'
    });
  })
}