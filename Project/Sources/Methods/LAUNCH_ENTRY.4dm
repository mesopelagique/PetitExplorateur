/*
Opens the game behind tile $index.

One explicit branch per tile, on purpose: the compiler then checks every launcher
exists, so a game that fails to load names itself at compile time instead of failing
silently on the tap. Each game publishes exactly one shared entry point, PLAY_<name>.

Add a new game: give it a tile in the Menu form, a dependency, and a branch here.
*/
#DECLARE($index : Integer)

Case of

		//______________________________________________________
	: ($index=1)

		PLAY_2048

		//______________________________________________________
	: ($index=2)

		PLAY_MathQuiz

		//______________________________________________________
	: ($index=3)

		PLAY_PatternQuiz

		//______________________________________________________
	: ($index=4)

		PLAY_LetterDetective

		//______________________________________________________
End case
