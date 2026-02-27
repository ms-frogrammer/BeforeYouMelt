
#macro SNOWMAN_1        "snowman_1"
#macro SNOWMAN_1_2      "snowman_1_2"

#macro CAMPFIRE_1		"campfire_1"

#macro BIRD_1           "bird_1"

#macro HUT_1            "hut_1"

function get_dialogue_text_with_id(_text_id)
{
    #region FUNCTION SHORTCUTS
        var _add = new_dialogue_txt;
        var _option = dialogue_option;

        var _col = textbox_color;
        var _float = textbox_float;
        var _shake = textbox_shake;
        
        var _portrait = textbox_set_portrait;
        var _speaker = textbox_set_speaker;
        var _voice = textbox_set_voice
    #endregion

    switch(_text_id)
    {
        
    #region SNOMWAN_1
        case SNOWMAN_1:
                _speaker("Snowman_1");
            _add("What. Are. You. Doing?..");
                _shake(0, 50);
            _add("Are you seriously going somewhere?");
            _add("*Scoffs*");
                _float(0, 20);
            _add("You are outrageous. I bet that head of yours has more dirt than snow...");
            _add("Like a tiny little brain of dirt!");
                _shake(0, 50);
            _add("Don't you realize how pointless that is?")
            _add("The winter is over soon. You will melt. We all will.");
                _shake(25, 39);
            _add("So where could you be possibly going?");
                _float(0, 40);
            _add("To what do- melt somewhere else?");
            _add("Ha-Ha-Ha-ha-ha-ha...");
                _float(0, 20);
            _add("*Ehem*");
                _shake(0, 5);
            _add("...Alright, you know what, I understand. Not everyone can see as far as I can...");
                _float(29, 40);
            _add("But now that I clearly opened up your button-eyes and enlightened you...");
            _add("...you will stop this at once.")
                _option("*Stare*", SNOWMAN_1_2);
            break;

         case SNOWMAN_1_2:
                _speaker("Snowman_1");
            _add("...");
            _add("Wow...");
                _float(0, 3);
            _add("You're worse than I thought.");
            _add("You have to get lost now.")
            _add("I am not sharing this place with anyone.");
            _add("Especially with a loser like yourself.");
            _add("Bye.");
                _shake(0, 10);
            break;
    #endregion

	#region CAMPFIRE
		 case CAMPFIRE_1:
				_speaker("Campfire 2");
			_add("Her: ...What a night.");
                _voice(sfx_voice_1);

            _add("Him: Mmmm...");
                _voice(sfx_voice_2);

            _add("Her: Hey!");
                _shake(5, 15);
                _voice(sfx_voice_1);

            _add("Him: Hey!");
                _float(5, 15);
                _voice(sfx_voice_2);

            _add("Her: Do you think that objects can be possessed by spirits?");
                _voice(sfx_voice_1);
            _add("Like, if someone close to me died, could their spirit remain in one of the objects inside of my house?")
                _voice(sfx_voice_1);

            _add("Him: Hmm, like live in something that you've associated with them?");
                _voice(sfx_voice_2);

            _add("Her: Yes! Or maybe even in one of their own things.          After all people keep some stuff of those who passed away.");
                _voice(sfx_voice_1);
            _add("You know, like a reminder.");
                _voice(sfx_voice_1);

            _add("Him: Sounds about right. Not to ruin your spirit though but... I don't think there are any spirits involved.");
                _voice(sfx_voice_2);

            _add("Her: ...No?");
                _voice(sfx_voice_1);

            _add("Him: I think it's just a way people learnt to cope with their grief.");
                _voice(sfx_voice_2);
            _add("Isn't that how all these things come about anyway?            Wanting to believe in something more.");
                _voice(sfx_voice_2);
                
            _add("Her: *Sighs*");
                _shake(5, 12);
                _voice(sfx_voice_1);
            _add("Doesn't sound like any fun...");
                _voice(sfx_voice_1);
                
            _add("Him: *Smirks*");
                _float(5, 10);
                _voice(sfx_voice_2);

            _add("And yet, here we are. Alive.");
                _voice(sfx_voice_2);
                _float(21, 27);

            _add("Freezing our buttocks. Isn't it fun?");
                _voice(sfx_voice_2);
                _shake(0, 21);
                _voice(sfx_voice_2);

            _add("Her: He-he-he-he...");
                _float(5, 25);
                _voice(sfx_voice_1);
            _add("Right.");
                _voice(sfx_voice_1);

            _add("...");

            _add("Him: Maybe there isn't much more to it.");
                _voice(sfx_voice_2);
            _add("But we can make the most out of what there is.")
                _voice(sfx_voice_2);
            
            _add("Her: Look at you getting all philosophical...");
                _float(5, 50);
                _voice(sfx_voice_1);

            _add("Him: Hey! you started this.");
                _shake(5, 8);
                _voice(sfx_voice_2);

            _add("*Both laugh*");
               

			break;
	#endregion
    
    #region BIRD
        case BIRD_1:
            _speaker("Bird");

            _add("That hut on the hill...")
                _voice(sfx_voice_3);
            _add("Take me with you.");
                _voice(sfx_voice_3);
            _add("I am ready.");
                _voice(sfx_voice_3);
        break;

    #endregion


    #region HUT

        case HUT_1:
            _speaker("Bird");

            _add("You've come so far...");
                _voice(sfx_voice_3);
            _add("Thank you for taking me.")
                _voice(sfx_voice_3);
            _add("...it's truly a sight to see.");
                _voice(sfx_voice_3);
            
    #endregion
    }
}