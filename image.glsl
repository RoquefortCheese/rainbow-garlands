// Welcome! This is a Shadertoy-style shader.
// mainImage runs once for each pixel, every frame.
// Try changing a number, then watch the preview on the right.

float height(vec2 point) {
    return sqrt(1. - pow(point.x, 2.) - pow(point.y, 2.));
}

void mainImage(out vec4 fragColor, in vec2 fragCoord)
{
    vec2 px = 1. / iResolution.xy;
    vec2 uv = fragCoord * px;

    vec2 point = uv * 4. - 2.;
    float ph = height(point);

    if (isnan(ph)) {
        //fragColor.rgb = vec3(0);
        return;
    }

    vec2 d2;
    for (int axis = 0; axis < 2; axis++) {
        vec2 delta;
        delta[axis] = 1.;
        delta *= 0.01;
        float left = max(0., height(point - delta));
        float right = max(0., height(point + delta));
        d2[axis] = left + right - ph * 2.;
    }
    d2 = normalize(d2);

    fragColor.g = d2.x + d2.y;
}
