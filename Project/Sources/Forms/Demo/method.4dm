// PetitExplorateur — a kid-friendly launcher: tap a big tile to play a game.

Case of

		//______________________________________________________
	: (Form event code=On Load)

		Form.transition:=cs.hero.ElementTransition.new()
		Form.fx:=cs.CardFx.new(Form.transition)

		//______________________________________________________
	: (Form event code=On Timer)

		Form.transition.onTimer()

		//______________________________________________________
	: (Form event code=On Clicked)

		If (Position("play_"; FORM Event.objectName)=1)

			Form.fx.press(Num(Substring(FORM Event.objectName; 6)))

		End if

		//______________________________________________________
	: (Form event code=On Unload)

		SET TIMER(0)

		//______________________________________________________
End case
