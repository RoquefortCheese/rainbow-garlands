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
    if (isnan(height(point))) {
        fragColor.rgb = vec3(0);
        return;
    }

    fragColor.rb = vec2(0);
    fragColor.g = height(point);
}
