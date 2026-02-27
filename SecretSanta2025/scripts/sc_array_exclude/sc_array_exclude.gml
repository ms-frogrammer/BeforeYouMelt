// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function array_exclude(arr_A, arr_B){
	var arr_C = [];
	for (var i = 0; i < array_length(arr_A); i++) {
	    var found = false;
	    for (var j = 0; j < array_length(arr_B); j++) {
	        if (arr_A[i] == arr_B[j]) {
	            found = true;
	            break;
	        }
	    }
	    if (!found) {
	        array_push(arr_C, arr_A[i]);
	    }
	}
	
	return arr_C;
}