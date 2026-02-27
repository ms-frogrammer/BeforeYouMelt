var _has_signal = false;
var _crate = instance_place(x, y - 4, [ob_crate, ob_kart]);
_has_signal = _crate;

for(var i = 0; i < array_length(reactors); i++)
{
	var _reactor = reactors[i];
	if !instance_exists(_reactor)
	{
		log("Reactor don't exist");
		continue;
	}
	
	_reactor.set_signal(_has_signal);
}
