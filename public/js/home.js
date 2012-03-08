(function($){
	function CreateReminderDetailsForm($form){
		var $what = $form.find('input[name=what]'),
			$month = $form.find('input[name=month]'),
			$day = $form.find('input[name=day]'),
			$year = $form.find('input[name=year]'),
			$hours = $form.find('select[name=hours]'),
			$minutes = $form.find('select[name=minutes]'),
			$amPm = $form.find('select[name=amPm]'),
			$reminderOffset = $form.find('select[name=reminderOffset]');

		$form.find('input[name="when"]').datepicker({showOtherMonths: true, selectOtherMonths: true });

		this.populate = function(data){
			$what.val(data.what);
			$month.val(data.month);
			$day.val(data.day);
			$year.val(data.year);
			$hours.val(data.hours);
			$minutes.val(data.minutes);
			$amPm.val(data.amPm);
			$reminderOffset.val(data.reminderOffset);
		};

		this.submit = function(){
			$form.submit();
		}
	}

	var $dialog = $('#create-reminder-details-dialog');
	var detailsForm = new CreateReminderDetailsForm($dialog.find('form'));

	$dialog.find('footer .create').click(function(){
		detailsForm.submit();
	});

	// alert boxes
	$('.alert').click(function(e){
		var $clicked = $(e.target);
		if($clicked.hasClass('close')){
			$(this).hide('fast');
		}

		if($clicked.hasClass('quick-reminder')){
			var data = $clicked.data();
			detailsForm.populate(data);
			$dialog.modal();
			return false;
		}
	});

	$('#create-reminder-main button.create').click(function(){
		var data = {
			what: $('#create-reminder-main input[name=title]').val(),
			month: new Date().getMonth() + 1,
			day: new Date().getDate(),
			year: new Date().getFullYear(),
			hours: 5,
			minutes: 45,
			amPm: "PM",
			reminderOffset: 120
		};

		detailsForm.populate(data);
		$dialog.modal();
		return false;
	});
})(jQuery);