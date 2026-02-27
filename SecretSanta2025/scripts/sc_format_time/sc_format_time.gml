function frames_to_string(_frames)
{
    var _min = (_frames/60) div 60;
    var _min_str = string_format(_min, 1, 0);

    var _sec = _frames div 60 - (_min * 60);
    var _sec_str = string_format(_sec, 2, 0);
    _sec_str = string_replace(_sec_str, " ", "0");

    var _ms = (_frames - (_min * 3600 + _sec * 60)) * 16.67;
    var _ms_str = string_format(_ms, 2, 0);
    _ms_str = string_replace(_ms_str, " ", "0"); 
    _ms_str = string_copy(_ms_str, 1, 2);
    var _str = _min_str + " m " + _sec_str + " s " + _ms_str + " ms";

    return _str;
}