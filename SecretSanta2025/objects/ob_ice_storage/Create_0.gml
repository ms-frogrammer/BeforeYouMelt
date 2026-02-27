type = BLOCK_TYPE.STORAGE;
time_left = -1;

can_take = function()
{
	return parts_left > 0;	
}
take = function()
{
	if can_take()
	{
		parts_left = 0;
		time_left = -1;
		return true;
	}
	return false;
}
refill = function()
{
	parts_left = 1;
	time_left = -1;
}