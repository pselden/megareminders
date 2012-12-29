(function($){
	function CreateReminderDetailsForm($form){
		var $what = $form.find('input[name=what]'),
			$when = $form.find('input[name=when]'),
			$hours = $form.find('select[name=hours]'),
			$minutes = $form.find('select[name=minutes]'),
			$amPm = $form.find('select[name=amPm]'),
			$reminderOffset = $form.find('select[name=reminderOffset]');

		$when.datepicker({showOtherMonths: true, selectOtherMonths: true });

		this.populate = function(data){
			var date = new Date(data.date),
				month = date.getMonth(),
				day = date.getDate(),
				year = date.getFullYear(),
				amPM = date.getHours() < 12 ? 'AM' : 'PM',
				hours = (amPM === 'AM' ? date.getHours() : date.getHours() - 12) || 12,
				minutes = date.getMinutes();

			$what.val(data.what);
			$when.datepicker('setDate', new Date(year, month, day, 0, 0, 0));
			$hours.val(hours);
			$minutes.val(minutes);
			$amPm.val(amPM);
			$reminderOffset.val(data.reminderOffset);
		};

		this.submit = function(){
			$form.submit();
		};

		$form.submit(function(e){
			var when = $when.datepicker('getDate'),
				amPM = $amPm.val(),
				hours = Number($hours.val()),
				minutes = $minutes.val();

			hours = hours === 12 ? 0 : hours;
			hours = amPM === 'AM' ? hours : hours + 12;

			var date = new Date(when.getFullYear(), when.getMonth(), when.getDate(), hours, minutes, 0);
			$(this).find('input[name=date]').val(date.toString());
		});
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

	$('#create-reminder-main').submit(function(e){
		e.preventDefault();
		var what = $(this).find('input[name=title]').val(),
			date = chrono.parseDate(what) || new Date();

		var data = {
			what: what,
			date: date,
			reminderOffset: 0
		};

		detailsForm.populate(data);
		$dialog.modal();
	});
})(jQuery);