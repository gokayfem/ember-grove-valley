diagnostic(off, derivative_uniformity);
struct Params {
    iResolution: vec3<f32>,
    iTime: f32,
    channelSizes: array<vec4<f32>, 4>,
    iFrame: i32,
}

@group(0) @binding(1)
var tex0_: texture_2d<f32>;
@group(0) @binding(5)
var samp0_: sampler;
@group(0) @binding(0)
var<uniform> unnamed: Params;
@group(0) @binding(2)
var tex1_: texture_2d<f32>;
@group(0) @binding(6)
var samp1_: sampler;
var<private> col: vec4<f32>;
var<private> gl_FragCoord_1: vec4<f32>;
@group(0) @binding(3)
var tex2_: texture_2d<f32>;
@group(0) @binding(7)
var samp2_: sampler;
@group(0) @binding(4)
var tex3_: texture_2d<f32>;
@group(0) @binding(8)
var samp3_: sampler;

fn fernSamplevi2_(node: ptr<function, vec2<i32>>) -> vec4<f32> {
    var at: i32;
    var width: i32;
    var phi_804_: bool;

    let _e15 = (*node);
    let _e17 = any((_e15 < vec2<i32>(0i, 0i)));
    phi_804_ = _e17;
    if !(_e17) {
        let _e19 = (*node);
        phi_804_ = any((_e19 >= vec2<i32>(420i, 192i)));
    }
    let _e23 = phi_804_;
    if _e23 {
        return vec4<f32>(0f, 0f, 0f, 0f);
    }
    let _e25 = (*node)[0u];
    let _e28 = (*node)[1u];
    at = ((540960i + _e25) + (420i * _e28));
    let _e34 = unnamed.channelSizes[1i][0u];
    width = i32(_e34);
    let _e36 = at;
    let _e37 = width;
    let _e45 = at;
    let _e46 = width;
    let _e51 = unnamed.channelSizes[1i][1u];
    let _e57 = textureLoad(tex1_, vec2<i32>((_e36 - (i32(floor((f32(_e36) / f32(_e37)))) * _e37)), ((_e45 / _e46) + i32(floor((0.68f * _e51))))), 0i);
    return _e57;
}

fn resolveFernvf2_(uv: ptr<function, vec2<f32>>) -> vec4<f32> {
    var f: f32;
    var truck: f32;
    var local: f32;
    var screen: vec2<f32>;
    var canonical: vec2<f32>;
    var node_1: vec2<f32>;
    var center: vec2<i32>;
    var sum: vec4<f32>;
    var total: f32;
    var y: i32;
    var x: i32;
    var at_1: vec2<i32>;
    var d: vec2<f32>;
    var w: f32;
    var param: vec2<i32>;
    var phi_947_: bool;

    let _e50 = unnamed.iTime;
    let _e51 = (_e50 * 48f);
    f = min(((_e51 - (floor((_e51 / 248f)) * 248f)) * 0.5f), 123f);
    let _e58 = f;
    if (_e58 <= 62f) {
        let _e60 = f;
        local = (-0.92f * (1f - cos(((_e60 * 3.1415927f) / 62f))));
    } else {
        let _e66 = f;
        local = (-1.84f + (1.32f * (1f - cos((((_e66 - 62f) * 3.1415927f) / 61f)))));
    }
    let _e74 = local;
    truck = _e74;
    let _e76 = (*uv)[0u];
    let _e78 = (*uv)[1u];
    screen = (vec2<f32>(_e76, (1f - _e78)) * vec2<f32>(1920f, 1080f));
    let _e82 = screen;
    let _e83 = truck;
    let _e89 = truck;
    let _e93 = truck;
    let _e95 = truck;
    canonical = (vec2<f32>(960f, 464.4f) + ((((_e82 - vec2<f32>((960f + ((1404f * _e83) / 325f)), 464.4f)) * (7.16f + (0.09f * _e89))) - (vec2<f32>(-(_e93), (0.035f * _e95)) * 1404f)) / vec2(7.16f)));
    let _e103 = canonical;
    node_1 = (((_e103 - vec2<f32>(-255f, 850f)) * 0.7f) - vec2(0.5f));
    let _e108 = node_1;
    let _e110 = any((_e108 < vec2<f32>(-5f, -5f)));
    phi_947_ = _e110;
    if !(_e110) {
        let _e112 = node_1;
        phi_947_ = any((_e112 > vec2<f32>(425f, 197f)));
    }
    let _e116 = phi_947_;
    if _e116 {
        return vec4<f32>(0f, 0f, 0f, 0f);
    }
    let _e117 = node_1;
    center = vec2<i32>(floor((_e117 + vec2(0.5f))));
    sum = vec4<f32>(0f, 0f, 0f, 0f);
    total = 0f;
    y = -4i;
    loop {
        let _e122 = y;
        if (_e122 <= 4i) {
            x = -4i;
            loop {
                let _e124 = x;
                if (_e124 <= 4i) {
                    let _e126 = center;
                    let _e127 = x;
                    let _e128 = y;
                    at_1 = (_e126 + vec2<i32>(_e127, _e128));
                    let _e131 = at_1;
                    let _e133 = node_1;
                    d = (vec2<f32>(_e131) - _e133);
                    let _e135 = d;
                    let _e136 = d;
                    w = exp((-0.29f * dot(_e135, _e136)));
                    let _e140 = w;
                    let _e141 = at_1;
                    param = _e141;
                    let _e142 = fernSamplevi2_((&param));
                    let _e144 = sum;
                    sum = (_e144 + (_e142 * _e140));
                    let _e146 = w;
                    let _e147 = total;
                    total = (_e147 + _e146);
                    continue;
                } else {
                    break;
                }
                continuing {
                    let _e149 = x;
                    x = (_e149 + 1i);
                }
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e151 = y;
            y = (_e151 + 1i);
        }
    }
    let _e153 = sum;
    let _e154 = total;
    return (_e153 / vec4(_e154));
}

fn worldLevelvf2i1_(uv_1: ptr<function, vec2<f32>>, level: ptr<function, i32>) -> vec4<f32> {
    var size: vec2<i32>;
    var pos: vec2<f32>;
    var ij: vec2<i32>;
    var f_1: vec2<f32>;
    var hi: vec2<i32>;
    var a: vec4<f32>;
    var b: vec4<f32>;
    var c: vec4<f32>;
    var d_1: vec4<f32>;

    let _e24 = (*level);
    let _e25 = textureDimensions(tex0_, _e24);
    size = vec2<i32>(_e25);
    let _e27 = (*uv_1);
    let _e28 = size;
    pos = ((_e27 * vec2<f32>(_e28)) - vec2(0.5f));
    let _e33 = pos;
    ij = vec2<i32>(floor(_e33));
    let _e36 = pos;
    f_1 = (floor(((fract(_e36) * 256f) + vec2(0.5f))) / vec2(256f));
    let _e44 = size;
    hi = (_e44 - vec2(1i));
    let _e47 = ij;
    let _e48 = hi;
    let _e50 = (*level);
    let _e51 = textureLoad(tex0_, clamp(_e47, vec2<i32>(0i, 0i), _e48), _e50);
    a = round((_e51 * 255f));
    let _e54 = ij;
    let _e56 = hi;
    let _e58 = (*level);
    let _e59 = textureLoad(tex0_, clamp((_e54 + vec2<i32>(1i, 0i)), vec2<i32>(0i, 0i), _e56), _e58);
    b = round((_e59 * 255f));
    let _e62 = ij;
    let _e64 = hi;
    let _e66 = (*level);
    let _e67 = textureLoad(tex0_, clamp((_e62 + vec2<i32>(0i, 1i)), vec2<i32>(0i, 0i), _e64), _e66);
    c = round((_e67 * 255f));
    let _e70 = ij;
    let _e72 = hi;
    let _e74 = (*level);
    let _e75 = textureLoad(tex0_, clamp((_e70 + vec2<i32>(1i, 1i)), vec2<i32>(0i, 0i), _e72), _e74);
    d_1 = round((_e75 * 255f));
    let _e78 = a;
    let _e79 = b;
    let _e81 = f_1[0u];
    let _e84 = c;
    let _e85 = d_1;
    let _e87 = f_1[0u];
    let _e91 = f_1[1u];
    return (floor(((mix(mix(_e78, _e79, vec4(_e81)), mix(_e84, _e85, vec4(_e87)), vec4(_e91)) * 16f) + vec4(0.5f))) / vec4(4080f));
}

fn worldSamplevf2f1_(uv_2: ptr<function, vec2<f32>>, lod: ptr<function, f32>) -> vec4<f32> {
    var scale: f32;
    var mip: f32;
    var base: i32;
    var param_1: vec2<f32>;
    var param_2: i32;
    var param_3: vec2<f32>;
    var param_4: i32;

    let _e18 = unnamed.channelSizes[0i][1u];
    let _e21 = unnamed.iResolution[1u];
    scale = (_e18 / (1.4f * _e21));
    let _e24 = (*lod);
    let _e25 = scale;
    mip = (_e24 + max(0f, log2(_e25)));
    let _e29 = mip;
    base = i32(floor(_e29));
    let _e32 = (*uv_2);
    param_1 = _e32;
    let _e33 = base;
    param_2 = _e33;
    let _e34 = worldLevelvf2i1_((&param_1), (&param_2));
    let _e35 = base;
    let _e37 = (*uv_2);
    param_3 = _e37;
    param_4 = (_e35 + 1i);
    let _e38 = worldLevelvf2i1_((&param_3), (&param_4));
    let _e39 = mip;
    return mix(_e34, _e38, vec4(fract(_e39)));
}

fn finishValleyvf2_(uv_3: ptr<function, vec2<f32>>) -> vec3<f32> {
    var base_1: vec3<f32>;
    var param_5: vec2<f32>;
    var param_6: f32;
    var mid: vec3<f32>;
    var param_7: vec2<f32>;
    var param_8: f32;
    var high: vec3<f32>;
    var param_9: vec2<f32>;
    var param_10: f32;
    var needleCoverage: f32;
    var param_11: vec2<f32>;
    var param_12: f32;
    var q: vec2<f32>;
    var change: vec3<f32>;
    var total_1: f32;
    var d_2: vec2<f32>;
    var w_1: f32;
    var d_3: vec2<f32>;
    var w_2: f32;
    var d_4: vec2<f32>;
    var w_3: f32;
    var d_5: vec2<f32>;
    var w_4: f32;
    var d_6: vec2<f32>;
    var w_5: f32;
    var d_7: vec2<f32>;
    var w_6: f32;
    var d_8: vec2<f32>;
    var w_7: f32;
    var d_9: vec2<f32>;
    var w_8: f32;
    var d_10: vec2<f32>;
    var w_9: f32;
    var d_11: vec2<f32>;
    var w_10: f32;
    var d_12: vec2<f32>;
    var w_11: f32;
    var d_13: vec2<f32>;
    var w_12: f32;

    let _e114 = (*uv_3);
    param_5 = _e114;
    param_6 = 0f;
    let _e115 = worldSamplevf2f1_((&param_5), (&param_6));
    base_1 = _e115.xyz;
    let _e117 = base_1;
    let _e118 = (*uv_3);
    param_7 = _e118;
    param_8 = 4f;
    let _e119 = worldSamplevf2f1_((&param_7), (&param_8));
    mid = (_e117 - _e119.xyz);
    let _e122 = base_1;
    let _e123 = (*uv_3);
    param_9 = _e123;
    param_10 = 1f;
    let _e124 = worldSamplevf2f1_((&param_9), (&param_10));
    high = (_e122 - _e124.xyz);
    let _e127 = (*uv_3);
    param_11 = _e127;
    param_12 = 0.7f;
    let _e128 = worldSamplevf2f1_((&param_11), (&param_12));
    needleCoverage = (1f - _e128.w);
    let _e132 = (*uv_3)[0u];
    let _e134 = (*uv_3)[1u];
    q = vec2<f32>(_e132, (1f - _e134));
    change = vec3<f32>(0f, 0f, 0f);
    total_1 = 0.065f;
    let _e137 = q;
    d_2 = ((_e137 - vec2<f32>(0.885417f, 0.092593f)) / vec2<f32>(0.177083f, 0.087407f));
    let _e140 = d_2;
    let _e141 = d_2;
    w_1 = exp((-1.6f * dot(_e140, _e141)));
    let _e145 = w_1;
    let _e146 = mid;
    let _e148 = base_1;
    let _e154 = high;
    let _e158 = change;
    change = (_e158 + (((vec3<f32>(-0.05716f, -0.023252f, -0.002448f) + (((_e146 * 0.55f) + ((_e148 - vec3<f32>(0.55491f, 0.557253f, 0.66023f)) * 0.45f)) * 0.305645f)) + (_e154 * 0f)) * _e145));
    let _e160 = w_1;
    let _e161 = total_1;
    total_1 = (_e161 + _e160);
    let _e163 = q;
    d_3 = ((_e163 - vec2<f32>(0.213542f, 0.222222f)) / vec2<f32>(0.141667f, 0.196667f));
    let _e166 = d_3;
    let _e167 = d_3;
    w_2 = exp((-1.6f * dot(_e166, _e167)));
    let _e171 = w_2;
    let _e172 = mid;
    let _e174 = base_1;
    let _e180 = high;
    let _e184 = change;
    change = (_e184 + (((vec3<f32>(0.32f, 0.155966f, 0.111011f) + (((_e172 * 0.55f) + ((_e174 - vec3<f32>(0.632521f, 0.57871f, 0.479551f)) * 0.45f)) * -0.206608f)) + (_e180 * 0f)) * _e171));
    let _e186 = w_2;
    let _e187 = total_1;
    total_1 = (_e187 + _e186);
    let _e189 = q;
    d_4 = ((_e189 - vec2<f32>(0.458333f, 0.425926f)) / vec2<f32>(0.10625f, 0.087407f));
    let _e192 = d_4;
    let _e193 = d_4;
    w_3 = exp((-1.6f * dot(_e192, _e193)));
    let _e197 = w_3;
    let _e198 = mid;
    let _e200 = base_1;
    let _e206 = high;
    let _e210 = change;
    change = (_e210 + (((vec3<f32>(0.155569f, 0.115373f, 0.08911f) + (((_e198 * 0.55f) + ((_e200 - vec3<f32>(0.693375f, 0.601882f, 0.592339f)) * 0.45f)) * -0.34f)) + (_e206 * 0f)) * _e197));
    let _e212 = w_3;
    let _e213 = total_1;
    total_1 = (_e213 + _e212);
    let _e215 = q;
    d_5 = ((_e215 - vec2<f32>(0.580729f, 0.203704f)) / vec2<f32>(0.071f, 0.174815f));
    let _e218 = d_5;
    let _e219 = d_5;
    w_4 = exp((-1.6f * dot(_e218, _e219)));
    let _e223 = w_4;
    let _e224 = mid;
    let _e226 = base_1;
    let _e232 = high;
    let _e236 = change;
    change = (_e236 + (((vec3<f32>(0.046859f, 0.053454f, 0.05318f) + (((_e224 * 0.55f) + ((_e226 - vec3<f32>(0.778055f, 0.682753f, 0.670266f)) * 0.45f)) * -0.34f)) + (_e232 * 0.453992f)) * _e223));
    let _e238 = w_4;
    let _e239 = total_1;
    total_1 = (_e239 + _e238);
    let _e241 = q;
    d_6 = ((_e241 - vec2<f32>(0.684896f, 0.231481f)) / vec2<f32>(0.07526f, 0.152963f));
    let _e244 = d_6;
    let _e245 = d_6;
    w_5 = exp((-1.6f * dot(_e244, _e245)));
    let _e249 = w_5;
    let _e250 = mid;
    let _e252 = base_1;
    let _e258 = high;
    let _e262 = change;
    change = (_e262 + (((vec3<f32>(0.139763f, 0.093637f, 0.082904f) + (((_e250 * 0.55f) + ((_e252 - vec3<f32>(0.516521f, 0.449492f, 0.506831f)) * 0.45f)) * 0.092832f)) + (_e258 * 0.924073f)) * _e249));
    let _e264 = w_5;
    let _e265 = total_1;
    total_1 = (_e265 + _e264);
    let _e267 = q;
    d_7 = ((_e267 - vec2<f32>(0.911458f, 0.296296f)) / vec2<f32>(0.115104f, 0.174815f));
    let _e270 = d_7;
    let _e271 = d_7;
    w_6 = exp((-1.6f * dot(_e270, _e271)));
    let _e275 = w_6;
    let _e276 = mid;
    let _e278 = base_1;
    let _e284 = high;
    let _e288 = change;
    change = (_e288 + (((vec3<f32>(-0.234802f, -0.149292f, -0.108268f) + (((_e276 * 0.55f) + ((_e278 - vec3<f32>(0.52144f, 0.431919f, 0.485139f)) * 0.45f)) * -0.34f)) + (_e284 * 1.397317f)) * _e275));
    let _e290 = w_6;
    let _e291 = total_1;
    total_1 = (_e291 + _e290);
    let _e293 = q;
    d_8 = ((_e293 - vec2<f32>(0.807292f, 0.453704f)) / vec2<f32>(0.177083f, 0.152963f));
    let _e296 = d_8;
    let _e297 = d_8;
    w_7 = exp((-1.6f * dot(_e296, _e297)));
    let _e301 = w_7;
    let _e302 = mid;
    let _e304 = base_1;
    let _e310 = high;
    let _e314 = change;
    change = (_e314 + (((vec3<f32>(0.017539f, 0.031763f, 0.035744f) + (((_e302 * 0.55f) + ((_e304 - vec3<f32>(0.340097f, 0.32452f, 0.36664f)) * 0.45f)) * -0.122067f)) + (_e310 * 0f)) * _e301));
    let _e316 = w_7;
    let _e317 = total_1;
    total_1 = (_e317 + _e316);
    let _e319 = q;
    d_9 = ((_e319 - vec2<f32>(0.690104f, 0.574074f)) / vec2<f32>(0.154948f, 0.131111f));
    let _e322 = d_9;
    let _e323 = d_9;
    w_8 = exp((-1.6f * dot(_e322, _e323)));
    let _e327 = w_8;
    let _e328 = mid;
    let _e330 = base_1;
    let _e336 = high;
    let _e340 = change;
    change = (_e340 + (((vec3<f32>(0.218889f, 0.15916f, 0.138068f) + (((_e328 * 0.55f) + ((_e330 - vec3<f32>(0.288647f, 0.299503f, 0.349686f)) * 0.45f)) * 2.271578f)) + (_e336 * 0f)) * _e327));
    let _e342 = w_8;
    let _e343 = total_1;
    total_1 = (_e343 + _e342);
    let _e345 = q;
    d_10 = ((_e345 - vec2<f32>(0.260417f, 0.592593f)) / vec2<f32>(0.177083f, 0.262222f));
    let _e348 = d_10;
    let _e349 = d_10;
    w_9 = exp((-1.6f * dot(_e348, _e349)));
    let _e353 = w_9;
    let _e354 = mid;
    let _e356 = base_1;
    let _e362 = high;
    let _e366 = change;
    change = (_e366 + (((vec3<f32>(0.059313f, 0.026061f, 0.03802f) + (((_e354 * 0.55f) + ((_e356 - vec3<f32>(0.349282f, 0.321091f, 0.293253f)) * 0.45f)) * 0.340379f)) + (_e362 * 0f)) * _e353));
    let _e368 = w_9;
    let _e369 = total_1;
    total_1 = (_e369 + _e368);
    let _e371 = q;
    d_11 = ((_e371 - vec2<f32>(0.625f, 0.833333f)) / vec2<f32>(0.177083f, 0.218519f));
    let _e374 = d_11;
    let _e375 = d_11;
    w_10 = exp((-1.6f * dot(_e374, _e375)));
    let _e379 = w_10;
    let _e380 = mid;
    let _e382 = base_1;
    let _e388 = high;
    let _e392 = change;
    change = (_e392 + (((vec3<f32>(0.111048f, 0.066914f, 0.043275f) + (((_e380 * 0.55f) + ((_e382 - vec3<f32>(0.359894f, 0.359232f, 0.414086f)) * 0.45f)) * 0.377993f)) + (_e388 * 0.115911f)) * _e379));
    let _e394 = w_10;
    let _e395 = total_1;
    total_1 = (_e395 + _e394);
    let _e397 = q;
    d_12 = ((_e397 - vec2<f32>(0.611979f, 0.657407f)) / vec2<f32>(0.110677f, 0.062f));
    let _e400 = d_12;
    let _e401 = d_12;
    w_11 = exp((-1.6f * dot(_e400, _e401)));
    let _e405 = w_11;
    let _e406 = mid;
    let _e408 = base_1;
    let _e414 = high;
    let _e418 = change;
    change = (_e418 + (((vec3<f32>(0.102633f, 0.0129f, -0.227771f) + (((_e406 * 0.55f) + ((_e408 - vec3<f32>(0.471861f, 0.462216f, 0.56637f)) * 0.45f)) * 2.8841f)) + (_e414 * 0f)) * _e405));
    let _e420 = w_11;
    let _e421 = total_1;
    total_1 = (_e421 + _e420);
    let _e423 = q;
    d_13 = ((_e423 - vec2<f32>(0.234375f, 0.87037f)) / vec2<f32>(0.177083f, 0.131111f));
    let _e426 = d_13;
    let _e427 = d_13;
    w_12 = exp((-1.6f * dot(_e426, _e427)));
    let _e431 = w_12;
    let _e432 = mid;
    let _e434 = base_1;
    let _e440 = high;
    let _e444 = change;
    change = (_e444 + (((vec3<f32>(0.114909f, 0.080657f, 0.067561f) + (((_e432 * 0.55f) + ((_e434 - vec3<f32>(0.186731f, 0.176916f, 0.114729f)) * 0.45f)) * 0.937292f)) + (_e440 * 0f)) * _e431));
    let _e446 = w_12;
    let _e447 = total_1;
    total_1 = (_e447 + _e446);
    let _e449 = base_1;
    let _e450 = high;
    let _e452 = needleCoverage;
    let _e455 = change;
    let _e456 = total_1;
    return clamp(((_e449 - ((_e450 * 0.72f) * _e452)) + ((_e455 / vec3(_e456)) * 1f)), vec3(0f), vec3(1f));
}

fn mainImagevf4vf2_(color: ptr<function, vec4<f32>>, pixel: ptr<function, vec2<f32>>) {
    var uv_4: vec2<f32>;
    var a_1: f32;
    var param_13: vec2<f32>;
    var param_14: f32;
    var c_1: vec3<f32>;
    var param_15: vec2<f32>;
    var w_13: f32;
    var param_16: vec2<f32>;
    var param_17: f32;
    var param_18: vec2<f32>;
    var param_19: f32;
    var fern: vec4<f32>;
    var param_20: vec2<f32>;

    let _e31 = (*pixel);
    let _e33 = unnamed.iResolution;
    uv_4 = (_e31 / _e33.xy);
    let _e36 = uv_4;
    param_13 = _e36;
    param_14 = 0f;
    let _e37 = worldSamplevf2f1_((&param_13), (&param_14));
    a_1 = _e37.w;
    let _e39 = uv_4;
    param_15 = _e39;
    let _e40 = finishValleyvf2_((&param_15));
    c_1 = _e40;
    let _e41 = a_1;
    let _e43 = a_1;
    w_13 = (smoothstep(0.24f, 0.39f, _e41) * (1f - smoothstep(0.56f, 0.7f, _e43)));
    let _e47 = c_1;
    let _e48 = a_1;
    let _e55 = uv_4;
    param_16 = _e55;
    param_17 = (0.22f + log2((1f + clamp(((_e48 - 0.4f) / 0.075f), 0f, 2f))));
    let _e56 = worldSamplevf2f1_((&param_16), (&param_17));
    let _e58 = w_13;
    c_1 = mix(_e47, _e56.xyz, vec3(_e58));
    let _e61 = c_1;
    let _e62 = uv_4;
    param_18 = _e62;
    param_19 = 0.78f;
    let _e63 = worldSamplevf2f1_((&param_18), (&param_19));
    let _e65 = a_1;
    c_1 = mix(_e61, _e63.xyz, vec3((1f - smoothstep(0.025f, 0.16f, abs((_e65 - 0.75f))))));
    let _e72 = uv_4;
    param_20 = _e72;
    let _e73 = resolveFernvf2_((&param_20));
    fern = _e73;
    let _e74 = c_1;
    let _e76 = fern[3u];
    let _e79 = fern;
    let _e81 = ((_e74 * (1f - _e76)) + _e79.xyz);
    (*color) = vec4<f32>(_e81.x, _e81.y, _e81.z, 1f);
    return;
}

fn main_1() {
    var param_21: vec4<f32>;
    var param_22: vec2<f32>;

    let _e8 = gl_FragCoord_1[0u];
    let _e11 = unnamed.iResolution[1u];
    let _e13 = gl_FragCoord_1[1u];
    param_22 = vec2<f32>(_e8, (_e11 - _e13));
    mainImagevf4vf2_((&param_21), (&param_22));
    let _e16 = param_21;
    col = _e16;
    return;
}

@fragment
fn main(@builtin(position) gl_FragCoord: vec4<f32>) -> @location(0) vec4<f32> {
    gl_FragCoord_1 = gl_FragCoord;
    main_1();
    let _e3 = col;
    return _e3;
}
