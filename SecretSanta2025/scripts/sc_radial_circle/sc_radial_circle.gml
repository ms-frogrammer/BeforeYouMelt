function draw_graident_cirlce(_x, _y, _r, _c1, _c2, _a1, _a2, _q) {
    // Arguments: x, y, radius, inner_color, outer_color, inner_alpha, outer_alpha

    draw_primitive_begin(pr_trianglefan);
    draw_vertex_color(_x, _y, _c1, _a1);

    for (var i = 0; i <= _q; i++) {
        var angle = i * 360 / _q;
        var px = _x + lengthdir_x(_r, angle);
        var py = _y + lengthdir_y(_r, angle);
        draw_vertex_color(px, py, _c1, _a2);
    }

    draw_primitive_end();   
}