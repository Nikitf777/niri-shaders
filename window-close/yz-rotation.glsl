vec4 close_color(vec3 coords_geo, vec3 size_geo) {
    float progress = niri_clamped_progress;
    float max_angle = radians(90.0);
    float angle = progress * max_angle;
    float sin_theta = sin(angle);
    float cos_theta = cos(angle);
    float d = 2.0; // Focal length for perspective projection

    vec2 dest = coords_geo.xy;
    float V = dest.y - 0.5;
    float denom = cos_theta * d + V * sin_theta;

    // Skip pixels where denominator is near zero (behind camera or undefined)
    if (abs(denom) < 0.001) {
        return vec4(0.0, 0.0, 0.0, 0.0);
    }

    // Calculate original Y coordinate before rotation
    float u = (V * d) / denom;
    float y_orig = u + 0.5;

    // Calculate original X coordinate before rotation
    float x_orig = (dest.x - 0.5) * (d - u * sin_theta) / d + 0.5;

    // Convert to texture coordinates
    vec3 coords_geo_orig = vec3(x_orig, y_orig, 1.0);
    vec3 coords_tex = niri_geo_to_tex * coords_geo_orig;
    vec4 color = texture2D(niri_tex, coords_tex.st);

    // Fade out during animation
    color *= (1.0 - progress);

    return color;
}
