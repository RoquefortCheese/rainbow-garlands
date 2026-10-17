// Welcome! This is a Shadertoy-style shader.
// mainImage runs once for each pixel, every frame.
// Try changing a number, then watch the preview on the right.

const float E = 2.718281828459045235360287471352;

void mainImage(out vec4 fragColor, in vec2 fragCoord)
{
    vec2 px = 1. / iResolution.xy;
    vec2 uv = fragCoord * px;

    vec3 color;
    for (int ch = 0; ch < 3; ch++) {
        float sum = 0.;
        for (int octave = 0; octave < 8; octave++) {
            float product = 1.;
            for (int axis = 0; axis < 2; axis++) {
                product *= sin((uv[axis] + uv[1 - axis] + float(ch * 256)) * pow(E, float(octave)));
            }
            sum += product * pow(2., float(-octave));
        }
        sum = (sum + 2.) / 4.;
        color[ch] = sum;
    }

    fragColor.rgb = color;
}
