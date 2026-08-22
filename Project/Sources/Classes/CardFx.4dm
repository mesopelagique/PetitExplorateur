/*
CardFx — the press a tile gives back before its game opens, animated by Hero (cs.hero).

A tile is three objects — the panel, the logo, the name — so a press moves all three as
one. It is a TRANSLATION, not a scale: shrinking a text object's box makes 4D re-wrap the
name, so we move the whole tile down and back instead.

The dialog a game opens is modal, so the launch must not happen until the press has been
seen: it hangs off the last tween's .then(), never alongside it.

Store the instance in Form.fx.
*/

property transition : cs.hero.ElementTransition
property tiles : Integer:=4                       // grows as more games are added
property homes : Collection
property pending : Integer:=-1
property busy : Boolean:=False

property dip : Real:=8
property _parts : Collection:=["card"; "logo"; "name"]

Class constructor($transition : cs.hero.ElementTransition)

	This.transition:=$transition
	This.homes:=[]

	var $i : Integer
	For ($i; 1; This.tiles)
		var $home : Object:={}
		var $part : Text
		For each ($part; This._parts)
			$home[$part]:=cs.hero.ElementState.new($part+"_"+String($i)).top
		End for each
		This.homes.push($home)
	End for

	// === === === === === === === === === === === === === === === === === === === ===
	// A tile was tapped: press it, and let the press decide when to launch.
Function press($i : Integer)

	If (This.busy)
		return
	End if
	This.busy:=True
	This.pending:=$i
	This._move($i; This.dip; 90; "easeOutQuad"; Formula(Form.fx._spring()))

	// …and back up, overshooting a little
Function _spring()

	This._move(This.pending; 0; 280; "easeOutBack"; Formula(Form.fx._launch()))

	// Only now, with the press fully seen, hand over to the game.
Function _launch()

	var $i : Integer:=This.pending
	This.busy:=False
	This.pending:=-1
	LAUNCH_ENTRY($i)

	// === === === === === === === === === === === === === === === === === === === ===
	// Move a whole tile by $offset from its resting place; only the panel carries $then.
Function _move($i : Integer; $offset : Real; $duration : Real; $easing : Text; $then : 4D.Function)

	var $home : Object:=This.homes[($i-1)]
	var $part : Text
	For each ($part; This._parts)
		var $animation : cs.hero.ElementAnimation:=This.transition.animate($part+"_"+String($i))\
			.to({top: $home[$part]+$offset})\
			.duration($duration)\
			.easing($easing)
		If ($part="card")
			$animation.then($then)
		End if
		$animation.start()
	End for each
