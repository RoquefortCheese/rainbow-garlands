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

    vec3 color;
    for (int ch = 0; ch < 3; ch++) {
        float sum = 0.;
        for (int octave = 0; octave < 8; octave++) {
            float product = 0.;
            product += sin((uv[0] + uv[1] * mod(iTime, 5.) + float(ch * 256)) * pow(E, float(octave)));
            product -= cos((uv[1] - uv[0] * 4. + float(ch * 256)) * pow(E, float(octave)));
            sum += product * pow(2., float(-octave));
        }
        sum = (sum + 2.) / 4.;
        color[ch] = sum;
    }

    fragColor.rgb = color;
}
