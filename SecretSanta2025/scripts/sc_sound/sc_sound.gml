function snd_play(_snd_id, _loop = false)
{
	return audio_play_sound(_snd_id, 1, _loop);
}

function snd_play_rndpitch(_snd_id, _loop = false)
{
	return audio_play_sound(_snd_id, 1, _loop, 1, 0, random_range(0.8, 1.2));
}
