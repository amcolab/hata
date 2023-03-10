$(() => {
  $('.submit-button').on('click', () => {
    let screen = $('form').attr('screen');
    $('.form-submit-button').trigger('click');
    $('.submit-button').attr('disabled', true).text(screen == 'answer' ? '回答が完了しました。' : '採点済みのお題を再度採点出来ません。');
    $('form').attr('is_answered', true);
    if (screen == 'assessment') {
      $('.answer_content').each((index, answer) => {
        let answer_point = $(answer).attr('answer_point');
        let answer_id = $(answer).attr('answer_id');
        if (answer_point != null || answer_point != "") {
          let radios = $(`[name="points[${answer_id}]"]`);
          radios.each((index, radio) => {
            if ($(radio).val() === answer_point) {
              $(radio).trigger('click');
            }
          })
        }
      })
    } else {
      if ($('#answer_content').val() != '' || $('#answer_content') != null) {
        $('#answer_content').val($('#content').val());
      }
    }
  });

  $('#answer_content')
    .on('focus', () => {
      if ($('form').attr('is_answered') == "true") {
        $('#answer_content').css({ 'box-shadow': '0 0 0 0.25rem rgb(254 67 80 / 25%)', 'border-color': 'rgb(254 67 80)' });
        $('.error').text('回答済みのお題を再度回答出来ません。');
      }
    })
    .on('focusout', () => {
      if ($('form').attr('is_answered') == "true") {
        $('#answer_content').css({ 'box-shadow': '', 'border-color': '#ced4da' });
      }
    });
});
