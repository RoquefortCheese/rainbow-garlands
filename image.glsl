// Welcome! This is a Shadertoy-style shader.
// mainImage runs once for each pixel, every frame.
// Try changing a number, then watch the preview on the right.

const float E = 2.718281828459045235360287471352;

void mainImage(out vec4 fragColor, in vec2 fragCoord)
{
    vec2 px = 1. / iResolution.xy;
    vec2 uv = fragCoord * px;
    vec2 mouse = iMouse.xy * px;

    uv += iTime * 0.125;
    uv -= mouse;
    uv *= 3.;

    vec3 color;
    for (int ch = 0; ch < 3; ch++) {
        float sum = 0.;
        for (int octave = 0; octave < 8; octave++) {
            float product = 0.;
            product += sin((uv[0] + uv[1] * 4. + float(ch * 256)) * pow(E + cos(iTime) / 512., float(octave)));
            product -= cos((uv[1] - uv[0] * 4. + float(ch * 256)) * pow(E + sin(iTime) / 256., float(octave)));
            sum += product * pow(2., float(-octave) + sin(iTime) / 8.);
        }

        color[ch] = pow(sum, 0.5);
    }

    float mi = min(color.r, min(color.g, color.b));
    float ma = max(color.r, max(color.g, color.b));
    color = (color - mi) / (ma - mi);

    fragColor.rgb = color;
}
