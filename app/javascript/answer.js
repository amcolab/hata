$(() => {
  $('.submit-button').on('click', () => {
    let screen = $('form').attr('screen');
    if (screen == 'assessment') {
      assessment_round_validation()
      $('.form-submit-button').trigger('click');
      $('form').attr('is_answered', true);
      $('.submit-button').attr('disabled', true).text('採点済みのお題を再度採点出来ません。');
    } else {
      answer_round_validation();
    }
  });

  function answer_round_validation() {
    let content = $('#answer_content');
    let answer = $('#content');
    let submit_button = $('.submit-button');
    let error = $('.error');
    if (answer.val() == '' || answer.val() == null) {
      if (content.val().length > 140) {
        content.val('');
        error.text('回答は140字以内に入力してください。');
      } else {
        $('.form-submit-button').trigger('click');
        $('form').attr('is_answered', true);
        submit_button.attr('disabled', true).text('回答が完了しました。');
        error.text('');
      }
    } else {
      content.val(answer.val());
      submit_button.attr('disabled', true).text('回答が完了しました。');
    }
  }

  function assessment_round_validation() {
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
  }

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
