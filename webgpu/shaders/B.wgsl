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
var<private> group: i32;
var<private> cols: i32;
var<private> rows: i32;
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

fn tileSizei1_(level: ptr<function, i32>) -> vec2<f32> {
    var local: vec2<f32>;

    let _e7 = (*level);
    if (_e7 == 0i) {
        local = vec2<f32>(96f, 256f);
    } else {
        let _e9 = (*level);
        local = select(vec2<f32>(32f, 64f), vec2<f32>(64f, 128f), vec2((_e9 == 1i)));
    }
    let _e13 = local;
    return _e13;
}

fn tileKeyvf2i1_(pix: ptr<function, vec2<f32>>, level_1: ptr<function, i32>) -> i32 {
    var cell: vec2<i32>;
    var param: i32;

    let _e11 = (*pix);
    let _e12 = (*level_1);
    param = _e12;
    let _e13 = tileSizei1_((&param));
    cell = (vec2<i32>(floor((_e11 / _e13))) + vec2<i32>(20i, 24i));
    let _e18 = (*level_1);
    let _e21 = cell[1u];
    let _e26 = cell[0u];
    return (((_e18 * 65536i) + (clamp(_e21, 0i, 255i) * 256i)) + clamp(_e26, 0i, 255i));
}

fn treeLevelf1_(z: ptr<function, f32>) -> i32 {
    var local_1: i32;

    let _e7 = (*z);
    if (_e7 < 200f) {
        local_1 = 0i;
    } else {
        let _e9 = (*z);
        local_1 = select(2i, 1i, (_e9 < 410f));
    }
    let _e12 = local_1;
    return _e12;
}

fn treeHeightvf4_(r: ptr<function, vec4<f32>>) -> f32 {
    let _e4 = (*r)[3u];
    return (fract((_e4 / 32f)) * 32f);
}

fn rootKeyvf4b1_(root: ptr<function, vec4<f32>>, mirrorView: ptr<function, bool>) -> i32 {
    var xy: vec2<f32>;
    var param_1: vec4<f32>;
    var param_2: f32;
    var param_3: vec2<f32>;
    var param_4: i32;

    let _e20 = (*root)[2u];
    if (_e20 <= 0f) {
        return 999999i;
    }
    let _e23 = (*root)[0u];
    let _e26 = (*root)[2u];
    let _e29 = (*mirrorView);
    let _e32 = (*root)[1u];
    let _e33 = (*root);
    param_1 = _e33;
    let _e34 = treeHeightvf4_((&param_1));
    let _e41 = (*root)[2u];
    xy = vec2<f32>((960f + ((_e23 * 1404f) / _e26)), (464.4f + (((70f - (select(1f, -1f, _e29) * (_e32 + (0.5f * _e34)))) * 1404f) / _e41)));
    let _e46 = (*root)[2u];
    param_2 = _e46;
    let _e47 = treeLevelf1_((&param_2));
    let _e48 = xy;
    param_3 = _e48;
    param_4 = _e47;
    let _e49 = tileKeyvf2i1_((&param_3), (&param_4));
    return _e49;
}

fn sortAddressi1b1_(i: ptr<function, i32>, mirrorView_1: ptr<function, bool>) -> vec2<i32> {
    var linear: i32;

    let _e7 = (*i);
    let _e8 = (*mirrorView_1);
    linear = (_e7 + select(0i, 262144i, _e8));
    let _e11 = linear;
    let _e14 = unnamed.iResolution[0u];
    let _e15 = i32(_e14);
    let _e23 = linear;
    let _e26 = unnamed.iResolution[0u];
    return vec2<i32>((_e11 - (i32(floor((f32(_e11) / f32(_e15)))) * _e15)), (_e23 / i32(_e26)));
}

fn rockSurveyvf2_(world: ptr<function, vec2<f32>>) -> vec2<f32> {
    var local_2: vec2<f32>;
    var texel: vec2<f32>;
    var phi_416_: bool;

    let _e14 = (*world);
    local_2 = (_e14 - vec2<f32>(-100f, 320f));
    let _e16 = local_2;
    let _e18 = any((_e16 < vec2<f32>(0f, 0f)));
    phi_416_ = _e18;
    if !(_e18) {
        let _e20 = local_2;
        phi_416_ = any((_e20 >= vec2<f32>(1024f, 768f)));
    }
    let _e24 = phi_416_;
    if _e24 {
        return vec2<f32>(0f, 0f);
    }
    let _e25 = local_2;
    texel = (vec2<f32>(769f, 0f) + clamp(_e25, vec2<f32>(0.5f, 0.5f), vec2<f32>(1023.5f, 767.5f)));
    let _e28 = texel;
    let _e31 = unnamed.channelSizes[0i];
    let _e34 = textureSampleLevel(tex0_, samp0_, (_e28 / _e31.xy), 0f);
    return _e34.xy;
}

fn mantlevf2f1_(world_1: ptr<function, vec2<f32>>, h: ptr<function, f32>) -> f32 {
    var param_5: vec2<f32>;

    let _e2 = (*world_1);
    param_5 = _e2;
    let _e3 = rockSurveyvf2_((&param_5));
    return _e3.y;
}

fn rndi1i1_(x: ptr<function, i32>, seed: ptr<function, i32>) -> f32 {
    var h_1: u32;

    let _e10 = (*x);
    let _e13 = (*seed);
    h_1 = (((bitcast<u32>(_e10) * 747796405u) + (bitcast<u32>(_e13) * 2891336453u)) + 277803737u);
    let _e18 = h_1;
    let _e19 = h_1;
    let _e25 = h_1;
    h_1 = (((_e18 >> bitcast<u32>(((_e19 >> bitcast<u32>(28u)) + 4u))) ^ _e25) * 277803737u);
    let _e28 = h_1;
    let _e31 = h_1;
    return (f32(((_e28 >> bitcast<u32>(22u)) ^ _e31)) / 4294967300f);
}

fn valueNoise2vf2_(p: ptr<function, vec2<f32>>) -> f32 {
    var i_1: vec2<i32>;
    var f: vec2<f32>;
    var param_6: i32;
    var param_7: i32;
    var param_8: i32;
    var param_9: i32;
    var param_10: i32;
    var param_11: i32;
    var param_12: i32;
    var param_13: i32;

    let _e16 = (*p);
    i_1 = vec2<i32>(floor(_e16));
    let _e19 = (*p);
    f = fract(_e19);
    let _e21 = f;
    let _e22 = f;
    let _e24 = f;
    f = ((_e21 * _e22) * (vec2(3f) - (_e24 * 2f)));
    let _e30 = i_1[0u];
    param_6 = _e30;
    let _e32 = i_1[1u];
    param_7 = _e32;
    let _e33 = rndi1i1_((&param_6), (&param_7));
    let _e35 = i_1[0u];
    param_8 = (_e35 + 1i);
    let _e38 = i_1[1u];
    param_9 = _e38;
    let _e39 = rndi1i1_((&param_8), (&param_9));
    let _e41 = f[0u];
    let _e44 = i_1[1u];
    let _e47 = i_1[0u];
    param_10 = _e47;
    param_11 = (_e44 + 1i);
    let _e48 = rndi1i1_((&param_10), (&param_11));
    let _e50 = i_1[0u];
    let _e53 = i_1[1u];
    param_12 = (_e50 + 1i);
    param_13 = (_e53 + 1i);
    let _e55 = rndi1i1_((&param_12), (&param_13));
    let _e57 = f[0u];
    let _e60 = f[1u];
    return mix(mix(_e33, _e39, _e41), mix(_e48, _e55, _e57), _e60);
}

fn capvf2_(world_2: ptr<function, vec2<f32>>) -> f32 {
    var param_14: vec2<f32>;

    let _e2 = (*world_2);
    param_14 = _e2;
    let _e3 = rockSurveyvf2_((&param_14));
    return _e3.x;
}

fn elevationNodevi2_(node: ptr<function, vec2<i32>>) -> f32 {
    var values: vec4<f32>;

    let _e9 = (*node);
    (*node) = clamp(_e9, vec2<i32>(0i, 0i), vec2<i32>(1536i, 1536i));
    let _e11 = (*node);
    let _e14 = textureLoad(tex0_, (_e11 / vec2(2i)), 0i);
    values = _e14;
    let _e16 = (*node)[1u];
    let _e26 = (*node)[0u];
    let _e36 = values[(((_e16 - (i32(floor((f32(_e16) / f32(2i)))) * 2i)) * 2i) + (_e26 - (i32(floor((f32(_e26) / f32(2i)))) * 2i)))];
    return _e36;
}

fn elevationComponentsvi2_(node_1: ptr<function, vec2<i32>>) -> vec2<f32> {
    var units: f32;
    var param_15: vec2<i32>;

    let _e6 = (*node_1);
    param_15 = _e6;
    let _e7 = elevationNodevi2_((&param_15));
    units = ((_e7 + 48f) * 128f);
    let _e10 = units;
    let _e13 = units;
    return vec2<f32>(floor((_e10 / 256f)), (_e13 - (floor((_e13 / 256f)) * 256f)));
}

fn bedvf2_(world_3: ptr<function, vec2<f32>>) -> f32 {
    var at: vec2<f32>;
    var i_2: vec2<i32>;
    var f_1: vec2<f32>;
    var value: vec2<f32>;
    var param_16: vec2<i32>;
    var param_17: vec2<i32>;
    var param_18: vec2<i32>;
    var param_19: vec2<i32>;

    let _e23 = (*world_3);
    at = ((((_e23 + vec2<f32>(1100f, 40f)) / vec2<f32>(2200f, 1800f)) * 1537f) - vec2(0.5f));
    let _e29 = at;
    i_2 = vec2<i32>(floor(_e29));
    let _e32 = at;
    f_1 = (floor(((fract(_e32) * 256f) + vec2(0.5f))) / vec2(256f));
    let _e40 = i_2;
    param_16 = _e40;
    let _e41 = elevationComponentsvi2_((&param_16));
    let _e42 = i_2;
    param_17 = (_e42 + vec2<i32>(1i, 0i));
    let _e44 = elevationComponentsvi2_((&param_17));
    let _e46 = f_1[0u];
    let _e49 = i_2;
    param_18 = (_e49 + vec2<i32>(0i, 1i));
    let _e51 = elevationComponentsvi2_((&param_18));
    let _e52 = i_2;
    param_19 = (_e52 + vec2<i32>(1i, 1i));
    let _e54 = elevationComponentsvi2_((&param_19));
    let _e56 = f_1[0u];
    let _e60 = f_1[1u];
    value = mix(mix(_e41, _e44, vec2(_e46)), mix(_e51, _e54, vec2(_e56)), vec2(_e60));
    let _e63 = value;
    return ((dot((floor(((_e63 * 16f) + vec2(0.5f))) / vec2(16f)), vec2<f32>(256f, 1f)) / 128f) - 48f);
}

fn growi1_(i_3: ptr<function, i32>) -> vec4<f32> {
    var z_1: f32;
    var param_20: i32;
    var param_21: i32;
    var x_1: f32;
    var param_22: i32;
    var param_23: i32;
    var h_2: f32;
    var param_24: i32;
    var param_25: i32;
    var chance: f32;
    var param_26: i32;
    var param_27: i32;
    var orange: f32;
    var param_28: i32;
    var param_29: i32;
    var valid: bool;
    var u: f32;
    var param_30: i32;
    var param_31: i32;
    var k: i32;
    var param_32: i32;
    var param_33: i32;
    var param_34: i32;
    var param_35: i32;
    var d: f32;
    var param_36: i32;
    var param_37: i32;
    var param_38: i32;
    var param_39: i32;
    var param_40: i32;
    var param_41: i32;
    var param_42: i32;
    var param_43: i32;
    var param_44: i32;
    var param_45: i32;
    var param_46: i32;
    var param_47: i32;
    var param_48: i32;
    var param_49: i32;
    var param_50: i32;
    var param_51: i32;
    var a: vec2<f32>;
    var indexable: array<vec2<f32>, 10>;
    var local_3: f32;
    var param_52: i32;
    var param_53: i32;
    var idx: i32;
    var c: vec4<f32>;
    var k_1: i32;
    var indexable_1: array<vec4<f32>, 6>;
    var r_1: f32;
    var param_54: i32;
    var param_55: i32;
    var a_1: f32;
    var param_56: i32;
    var param_57: i32;
    var param_58: i32;
    var param_59: i32;
    var p_1: vec2<f32>;
    var y: f32;
    var param_60: vec2<f32>;
    var rock: f32;
    var param_61: vec2<f32>;
    var m: f32;
    var param_62: vec2<f32>;
    var grove: f32;
    var param_63: vec2<f32>;
    var param_64: vec2<f32>;
    var param_65: vec2<f32>;
    var sx: f32;
    var sy: f32;
    var param_66: i32;
    var param_67: i32;
    var param_68: vec2<f32>;
    var param_69: vec2<f32>;
    var param_70: i32;
    var param_71: i32;
    var uv: vec2<f32>;
    var param_72: vec2<f32>;
    var param_73: vec2<f32>;
    var param_74: vec2<f32>;
    var param_75: f32;
    var sx_1: f32;
    var sy_1: f32;
    var param_76: i32;
    var param_77: i32;
    var j: i32;
    var param_78: i32;
    var param_79: i32;
    var frameX: f32;
    var param_80: i32;
    var param_81: i32;
    var param_82: vec2<f32>;
    var param_83: i32;
    var param_84: i32;
    var local_4: vec4<f32>;
    var param_85: i32;
    var param_86: i32;
    var phi_1048_: bool;
    var phi_1058_: bool;
    var phi_1078_: bool;
    var phi_1120_: bool;
    var phi_1152_: bool;
    var phi_1164_: bool;
    var phi_1174_: bool;
    var phi_1262_: bool;
    var phi_1283_: bool;

    let _e234 = (*i_3);
    if (_e234 >= 145049i) {
        return vec4<f32>(0f, 0f, 0f, 0f);
    }
    let _e236 = (*i_3);
    param_20 = _e236;
    param_21 = 1i;
    let _e237 = rndi1i1_((&param_20), (&param_21));
    z_1 = mix(100f, 1150f, _e237);
    let _e239 = (*i_3);
    param_22 = _e239;
    param_23 = 2i;
    let _e240 = rndi1i1_((&param_22), (&param_23));
    let _e243 = z_1;
    x_1 = (((2f * _e240) - 1f) * ((0.71f * _e243) + 10f));
    let _e247 = (*i_3);
    param_24 = _e247;
    param_25 = 3i;
    let _e248 = rndi1i1_((&param_24), (&param_25));
    h_2 = mix(7f, 21f, _e248);
    let _e250 = (*i_3);
    param_26 = _e250;
    param_27 = 4i;
    let _e251 = rndi1i1_((&param_26), (&param_27));
    chance = _e251;
    let _e252 = (*i_3);
    param_28 = _e252;
    param_29 = 5i;
    let _e253 = rndi1i1_((&param_28), (&param_29));
    orange = step(0.88f, _e253);
    valid = true;
    let _e255 = (*i_3);
    let _e257 = (*i_3);
    if ((_e255 >= 135000i) && (_e257 < 139000i)) {
        let _e260 = (*i_3);
        param_30 = _e260;
        param_31 = 6i;
        let _e261 = rndi1i1_((&param_30), (&param_31));
        u = mix(-30f, 580f, _e261);
        z_1 = 302f;
        k = 0i;
        loop {
            let _e263 = k;
            if (_e263 < 4i) {
                let _e265 = u;
                let _e267 = z_1;
                x_1 = (((_e265 - 550f) * _e267) / 804f);
                let _e270 = x_1;
                let _e275 = x_1;
                z_1 = ((302f + (55f * sin((_e270 * 0.013f)))) + (28f * sin((_e275 * 0.03f))));
                continue;
            } else {
                break;
            }
            continuing {
                let _e280 = k;
                k = (_e280 + 1i);
            }
        }
        let _e282 = (*i_3);
        param_32 = _e282;
        param_33 = 7i;
        let _e283 = rndi1i1_((&param_32), (&param_33));
        let _e286 = z_1;
        z_1 = (_e286 + (55f * (_e283 - 0.62f)));
        let _e288 = u;
        let _e290 = z_1;
        x_1 = (((_e288 - 550f) * _e290) / 804f);
        let _e293 = (*i_3);
        param_34 = _e293;
        param_35 = 8i;
        let _e294 = rndi1i1_((&param_34), (&param_35));
        h_2 = mix(5f, 14f, _e294);
    }
    let _e296 = (*i_3);
    let _e298 = (*i_3);
    if ((_e296 >= 139000i) && (_e298 < 143000i)) {
        let _e301 = (*i_3);
        d = select(1270f, 715f, ((_e301 - (i32(floor((f32(_e301) / f32(2i)))) * 2i)) == 0i));
        let _e311 = (*i_3);
        param_36 = _e311;
        param_37 = 9i;
        let _e312 = rndi1i1_((&param_36), (&param_37));
        let _e314 = d;
        x_1 = (((_e312 - 0.5f) * _e314) * 1.36f);
        let _e317 = d;
        let _e318 = (*i_3);
        param_38 = _e318;
        param_39 = 10i;
        let _e319 = rndi1i1_((&param_38), (&param_39));
        z_1 = (_e317 + (88f * (_e319 - 0.5f)));
        let _e323 = (*i_3);
        param_40 = _e323;
        param_41 = 11i;
        let _e324 = rndi1i1_((&param_40), (&param_41));
        h_2 = mix(5f, 10f, _e324);
    }
    let _e326 = (*i_3);
    let _e328 = (*i_3);
    if ((_e326 >= 143000i) && (_e328 < 144700i)) {
        let _e331 = (*i_3);
        param_42 = _e331;
        param_43 = 12i;
        let _e332 = rndi1i1_((&param_42), (&param_43));
        x_1 = mix(175f, 405f, _e332);
        let _e334 = (*i_3);
        param_44 = _e334;
        param_45 = 13i;
        let _e335 = rndi1i1_((&param_44), (&param_45));
        z_1 = mix(410f, 600f, _e335);
        let _e337 = (*i_3);
        param_46 = _e337;
        param_47 = 8i;
        let _e338 = rndi1i1_((&param_46), (&param_47));
        h_2 = mix(6f, 12f, _e338);
    }
    let _e340 = (*i_3);
    let _e342 = (*i_3);
    if ((_e340 >= 144700i) && (_e342 < 144720i)) {
        let _e345 = (*i_3);
        param_48 = _e345;
        param_49 = 1i;
        let _e346 = rndi1i1_((&param_48), (&param_49));
        x_1 = mix(112f, 129f, _e346);
        let _e348 = (*i_3);
        param_50 = _e348;
        param_51 = 2i;
        let _e349 = rndi1i1_((&param_50), (&param_51));
        z_1 = mix(297f, 325f, _e349);
        orange = 1f;
    }
    let _e351 = (*i_3);
    let _e353 = (*i_3);
    if ((_e351 >= 144720i) && (_e353 < 144730i)) {
        let _e356 = (*i_3);
        indexable = array<vec2<f32>, 10>(vec2<f32>(301f, 119f), vec2<f32>(252f, 155f), vec2<f32>(362f, 130f), vec2<f32>(479f, 140f), vec2<f32>(539f, 149f), vec2<f32>(581f, 155f), vec2<f32>(612f, 148f), vec2<f32>(655f, 147f), vec2<f32>(701f, 137f), vec2<f32>(743f, 132f));
        let _e359 = indexable[(_e356 - 144720i)];
        a = _e359;
        let _e361 = a[1u];
        z_1 = _e361;
        let _e363 = a[0u];
        let _e365 = z_1;
        x_1 = (((_e363 - 550f) * _e365) / 804f);
        let _e368 = (*i_3);
        if (_e368 == 144720i) {
            local_3 = 26f;
        } else {
            let _e370 = (*i_3);
            param_52 = _e370;
            param_53 = 7i;
            let _e371 = rndi1i1_((&param_52), (&param_53));
            local_3 = mix(12f, 18f, _e371);
        }
        let _e373 = local_3;
        h_2 = _e373;
        orange = 0f;
    }
    let _e374 = (*i_3);
    let _e376 = (*i_3);
    if ((_e374 >= 144730i) && (_e376 < 145017i)) {
        let _e379 = (*i_3);
        idx = (_e379 - 144730i);
        c = vec4<f32>(-31f, 115f, 22f, 46f);
        k_1 = 0i;
        loop {
            let _e381 = k_1;
            if (_e381 < 6i) {
                let _e383 = k_1;
                indexable_1 = array<vec4<f32>, 6>(vec4<f32>(-31f, 115f, 22f, 46f), vec4<f32>(-27f, 165f, 20f, 39f), vec4<f32>(16f, 155f, 12f, 4f), vec4<f32>(121f, 263f, 21f, 117f), vec4<f32>(81f, 293f, 15f, 46f), vec4<f32>(65f, 366f, 10f, 35f));
                let _e385 = indexable_1[_e383];
                c = _e385;
                let _e386 = idx;
                let _e388 = c[3u];
                if (_e386 < i32(_e388)) {
                    break;
                }
                let _e392 = c[3u];
                let _e394 = idx;
                idx = (_e394 - i32(_e392));
                continue;
            } else {
                break;
            }
            continuing {
                let _e396 = k_1;
                k_1 = (_e396 + 1i);
            }
        }
        let _e398 = (*i_3);
        param_54 = _e398;
        param_55 = 43i;
        let _e399 = rndi1i1_((&param_54), (&param_55));
        r_1 = sqrt((-2f * log(max(0.00001f, _e399))));
        let _e404 = (*i_3);
        param_56 = _e404;
        param_57 = 46i;
        let _e405 = rndi1i1_((&param_56), (&param_57));
        a_1 = (6.283185f * _e405);
        let _e408 = c[0u];
        let _e410 = c[2u];
        let _e411 = r_1;
        let _e413 = a_1;
        x_1 = (_e408 + ((_e410 * _e411) * cos(_e413)));
        let _e418 = c[1u];
        let _e420 = c[2u];
        let _e422 = r_1;
        let _e424 = a_1;
        z_1 = (_e418 + (((_e420 * 0.8f) * _e422) * sin(_e424)));
        let _e428 = (*i_3);
        param_58 = _e428;
        param_59 = 45i;
        let _e429 = rndi1i1_((&param_58), (&param_59));
        h_2 = mix(12f, 27f, _e429);
        orange = 0f;
    }
    let _e431 = x_1;
    let _e432 = z_1;
    p_1 = vec2<f32>(_e431, _e432);
    let _e434 = p_1;
    param_60 = _e434;
    let _e435 = bedvf2_((&param_60));
    y = _e435;
    let _e436 = p_1;
    param_61 = _e436;
    let _e437 = capvf2_((&param_61));
    rock = _e437;
    let _e438 = p_1;
    param_62 = (_e438 * 0.028f);
    let _e440 = valueNoise2vf2_((&param_62));
    m = _e440;
    let _e441 = p_1;
    param_63 = ((_e441 * 0.014f) + vec2(13f));
    let _e445 = valueNoise2vf2_((&param_63));
    grove = _e445;
    let _e446 = (*i_3);
    if (_e446 < 135000i) {
        let _e448 = y;
        let _e449 = m;
        let _e452 = (_e448 < (89f + (_e449 * 21f)));
        phi_1048_ = _e452;
        if _e452 {
            let _e453 = chance;
            let _e454 = m;
            let _e456 = grove;
            phi_1048_ = (_e453 < (0.09f + ((0.6f * _e454) * _e456)));
        }
        let _e461 = phi_1048_;
        phi_1058_ = _e461;
        if _e461 {
            let _e462 = y;
            let _e464 = grove;
            phi_1058_ = ((_e462 < 58f) || (_e464 > 0.48f));
        }
        let _e468 = phi_1058_;
        phi_1078_ = _e468;
        if _e468 {
            let _e469 = p_1;
            param_64 = (_e469 + vec2<f32>(1f, 0f));
            let _e471 = bedvf2_((&param_64));
            let _e472 = y;
            let _e474 = p_1;
            param_65 = (_e474 + vec2<f32>(0f, 1f));
            let _e476 = bedvf2_((&param_65));
            let _e477 = y;
            phi_1078_ = (length(vec2<f32>((_e471 - _e472), (_e476 - _e477))) < 1f);
        }
        let _e483 = phi_1078_;
        valid = _e483;
        let _e484 = x_1;
        let _e486 = z_1;
        sx = (550f + ((804f * _e484) / _e486));
        let _e489 = y;
        let _e492 = z_1;
        sy = (266.17f + (((70f - _e489) * 804f) / _e492));
        let _e495 = sx;
        let _e497 = sx;
        let _e500 = sy;
        let _e503 = z_1;
        if ((((_e495 > 470f) && (_e497 < 802f)) && (_e500 > 454f)) && (_e503 < 229f)) {
            let _e506 = valid;
            phi_1120_ = _e506;
            if _e506 {
                let _e507 = (*i_3);
                param_66 = _e507;
                param_67 = 14i;
                let _e508 = rndi1i1_((&param_66), (&param_67));
                phi_1120_ = (_e508 < 0.045f);
            }
            let _e511 = phi_1120_;
            valid = _e511;
        }
        let _e512 = y;
        let _e517 = h_2;
        h_2 = (_e517 * (1f - (0.29f * clamp((_e512 / 100f), 0f, 1f))));
    }
    let _e519 = rock;
    let _e520 = y;
    if (_e519 > (_e520 + 2f)) {
        let _e523 = (*i_3);
        let _e525 = (*i_3);
        let _e527 = ((_e523 >= 143000i) && (_e525 < 144700i));
        phi_1152_ = _e527;
        if _e527 {
            let _e528 = rock;
            let _e529 = p_1;
            param_68 = (_e529 + vec2<f32>(2f, 0f));
            let _e531 = capvf2_((&param_68));
            phi_1152_ = (abs((_e528 - _e531)) < 1.7f);
        }
        let _e536 = phi_1152_;
        phi_1164_ = _e536;
        if _e536 {
            let _e537 = rock;
            let _e538 = p_1;
            param_69 = (_e538 + vec2<f32>(0f, 2f));
            let _e540 = capvf2_((&param_69));
            phi_1164_ = (abs((_e537 - _e540)) < 1.7f);
        }
        let _e545 = phi_1164_;
        phi_1174_ = _e545;
        if _e545 {
            let _e546 = (*i_3);
            param_70 = _e546;
            param_71 = 16i;
            let _e547 = rndi1i1_((&param_70), (&param_71));
            phi_1174_ = (_e547 < 0.47f);
        }
        let _e550 = phi_1174_;
        valid = _e550;
        let _e551 = rock;
        y = _e551;
    } else {
        let _e552 = (*i_3);
        let _e554 = (*i_3);
        if ((_e552 >= 143000i) && (_e554 < 144700i)) {
            let _e557 = chance;
            valid = (_e557 < 0.24f);
        }
    }
    let _e559 = p_1;
    uv = ((_e559 - vec2<f32>(-100f, 320f)) / vec2<f32>(1024f, 768f));
    let _e562 = uv;
    let _e563 = uv;
    if all((_e562 == clamp(_e563, vec2(0f), vec2(1f)))) {
        let _e569 = y;
        let _e570 = p_1;
        param_72 = _e570;
        let _e571 = bedvf2_((&param_72));
        let _e572 = p_1;
        param_73 = _e572;
        let _e573 = bedvf2_((&param_73));
        let _e574 = p_1;
        param_74 = _e574;
        param_75 = _e573;
        let _e575 = mantlevf2f1_((&param_74), (&param_75));
        y = max(_e569, (_e571 + _e575));
    }
    let _e578 = y;
    if (_e578 < 1.6f) {
        valid = false;
    }
    let _e580 = x_1;
    let _e582 = z_1;
    sx_1 = (960f + ((1404f * _e580) / _e582));
    let _e585 = y;
    let _e588 = z_1;
    sy_1 = (464.4f + (((70f - _e585) * 1404f) / _e588));
    let _e591 = (*i_3);
    let _e593 = z_1;
    let _e596 = sy_1;
    let _e599 = sx_1;
    let _e602 = orange;
    if (((((_e591 < 144720i) && (_e593 < 213f)) && (_e596 > 585f)) && (_e599 < 1260f)) && (_e602 > 0.5f)) {
        orange = 0f;
    }
    let _e605 = z_1;
    let _e606 = (_e605 < 163f);
    phi_1262_ = _e606;
    if _e606 {
        let _e607 = sx_1;
        phi_1262_ = (abs((_e607 - 518f)) < 68f);
    }
    let _e612 = phi_1262_;
    let _e613 = sy_1;
    if (_e612 && (_e613 > 620f)) {
        valid = false;
    }
    let _e616 = (*i_3);
    let _e618 = orange;
    let _e620 = ((_e616 < 135000i) && (_e618 > 0.5f));
    phi_1283_ = _e620;
    if _e620 {
        let _e621 = (*i_3);
        param_76 = _e621;
        param_77 = 23i;
        let _e622 = rndi1i1_((&param_76), (&param_77));
        phi_1283_ = (_e622 < 0.39f);
    }
    let _e625 = phi_1283_;
    if _e625 {
        orange = 0f;
    }
    let _e626 = (*i_3);
    if (_e626 >= 145017i) {
        let _e628 = (*i_3);
        j = (_e628 - 145017i);
        let _e630 = j;
        param_78 = _e630;
        param_79 = 66i;
        let _e631 = rndi1i1_((&param_78), (&param_79));
        z_1 = mix(90f, 101f, _e631);
        let _e633 = j;
        param_80 = _e633;
        param_81 = 65i;
        let _e634 = rndi1i1_((&param_80), (&param_81));
        frameX = mix(145f, 742f, _e634);
        let _e636 = frameX;
        let _e638 = z_1;
        x_1 = (((_e636 - 960f) * _e638) / 1404f);
        let _e641 = x_1;
        let _e642 = z_1;
        param_82 = vec2<f32>(_e641, _e642);
        let _e644 = bedvf2_((&param_82));
        y = _e644;
        let _e645 = j;
        param_83 = _e645;
        param_84 = 68i;
        let _e646 = rndi1i1_((&param_83), (&param_84));
        h_2 = mix(8f, 18f, _e646);
        orange = 0f;
        let _e648 = y;
        valid = (_e648 > 1.6f);
        let _e650 = j;
        if (_e650 == 0i) {
            z_1 = 83.5f;
            let _e652 = z_1;
            x_1 = ((-443f * _e652) / 1404f);
            let _e655 = z_1;
            y = (70f + ((-469.6f * _e655) / 1404f));
            h_2 = 15f;
            valid = true;
        }
    }
    let _e659 = valid;
    if _e659 {
        let _e660 = x_1;
        let _e661 = y;
        let _e663 = z_1;
        let _e664 = h_2;
        let _e665 = (*i_3);
        param_85 = _e665;
        param_86 = 17i;
        let _e666 = rndi1i1_((&param_85), (&param_86));
        let _e671 = orange;
        local_4 = vec4<f32>(_e660, (_e661 - 0.25f), _e663, ((_e664 + (32f * floor((_e666 * 8f)))) + (256f * _e671)));
    } else {
        local_4 = vec4<f32>(0f, 0f, 0f, 0f);
    }
    let _e675 = local_4;
    return _e675;
}

fn depthBandf1_(z_2: ptr<function, f32>) -> i32 {
    var local_5: i32;
    var local_6: i32;
    var local_7: i32;
    var local_8: i32;
    var local_9: i32;

    let _e19 = (*z_2);
    if (_e19 < 9f) {
        local_5 = 0i;
    } else {
        let _e21 = (*z_2);
        if (_e21 < 15.8f) {
            local_6 = 1i;
        } else {
            let _e23 = (*z_2);
            if (_e23 < 20f) {
                local_7 = 2i;
            } else {
                let _e25 = (*z_2);
                if (_e25 < 28f) {
                    local_8 = 3i;
                } else {
                    let _e27 = (*z_2);
                    if (_e27 < 48f) {
                        local_9 = 4i;
                    } else {
                        let _e29 = (*z_2);
                        local_9 = select(6i, 5i, (_e29 < 120f));
                    }
                    let _e32 = local_9;
                    local_8 = _e32;
                }
                let _e33 = local_8;
                local_7 = _e33;
            }
            let _e34 = local_7;
            local_6 = _e34;
        }
        let _e35 = local_6;
        local_5 = _e35;
    }
    let _e36 = local_5;
    return _e36;
}

fn patchKeyvf4_(r_2: ptr<function, vec4<f32>>) -> i32 {
    var lvl: i32;
    var tile: f32;
    var xy_1: vec2<i32>;
    var param_87: f32;

    let _e19 = (*r_2)[2u];
    if (_e19 < 0.1f) {
        return 16777200i;
    }
    let _e22 = (*r_2)[3u];
    lvl = i32((_e22 / 524288f));
    let _e25 = lvl;
    tile = (16f * exp2(f32(_e25)));
    let _e29 = (*r_2);
    let _e31 = tile;
    xy_1 = (vec2<i32>(floor((_e29.xy / vec2(_e31)))) + vec2<i32>(48i, 48i));
    let _e38 = (*r_2)[2u];
    param_87 = _e38;
    let _e39 = depthBandf1_((&param_87));
    let _e41 = lvl;
    let _e45 = xy_1[1u];
    let _e50 = xy_1[0u];
    return ((((((_e39 * 5i) + _e41) * 256i) + clamp(_e45, 0i, 255i)) * 256i) + clamp(_e50, 0i, 255i));
}

fn patchAddressi1i1_(idx_1: ptr<function, i32>, width: ptr<function, i32>) -> vec2<i32> {
    var i_4: i32;

    let _e4 = (*idx_1);
    i_4 = (524288i + _e4);
    let _e6 = i_4;
    let _e7 = (*width);
    let _e15 = i_4;
    let _e16 = (*width);
    return vec2<i32>((_e6 - (i32(floor((f32(_e6) / f32(_e7)))) * _e7)), (_e15 / _e16));
}

fn originalProjectionvf3_(p_2: ptr<function, vec3<f32>>) -> vec2<f32> {
    let _e8 = (*p_2)[0u];
    let _e10 = (*p_2)[1u];
    let _e16 = (*p_2)[2u];
    return (vec2<f32>(960f, 464.4f) + ((vec2<f32>(_e8, -((_e10 - 70f))) * 1404f) / vec2(_e16)));
}

fn sweptPointvf3f1f1_(p_3: ptr<function, vec3<f32>>, basis: ptr<function, f32>, camera: ptr<function, f32>) -> vec2<f32> {
    var z_3: f32;
    var ray: vec2<f32>;

    let _e15 = (*p_3)[2u];
    let _e16 = (*camera);
    z_3 = (_e15 + (0.09f * _e16));
    let _e20 = (*p_3)[0u];
    let _e21 = (*camera);
    let _e23 = (*camera);
    let _e27 = (*p_3)[1u];
    let _e30 = z_3;
    ray = (vec2<f32>((_e20 - _e21), ((70f + (0.035f * _e23)) - _e27)) / vec2(_e30));
    let _e33 = ray;
    let _e34 = (*basis);
    let _e35 = (*camera);
    let _e39 = (*camera);
    let _e40 = (*camera);
    let _e45 = (*basis);
    return (vec2<f32>(960f, 464.4f) + ((((_e33 * (_e34 + (0.09f * _e35))) + vec2<f32>(_e39, (-0.035f * _e40))) * 1404f) / vec2(_e45)));
}

fn bandDepthi1_(band: ptr<function, i32>) -> f32 {
    var local_10: f32;
    var local_11: f32;
    var local_12: f32;
    var local_13: f32;
    var local_14: f32;

    let _e19 = (*band);
    if (_e19 == 0i) {
        local_10 = 7.1f;
    } else {
        let _e21 = (*band);
        if (_e21 == 1i) {
            local_11 = 14.3f;
        } else {
            let _e23 = (*band);
            if (_e23 == 2i) {
                local_12 = 18f;
            } else {
                let _e25 = (*band);
                if (_e25 == 3i) {
                    local_13 = 23f;
                } else {
                    let _e27 = (*band);
                    if (_e27 == 4i) {
                        local_14 = 34f;
                    } else {
                        let _e29 = (*band);
                        local_14 = select(320f, 83f, (_e29 == 5i));
                    }
                    let _e32 = local_14;
                    local_13 = _e32;
                }
                let _e33 = local_13;
                local_12 = _e33;
            }
            let _e34 = local_12;
            local_11 = _e34;
        }
        let _e35 = local_11;
        local_10 = _e35;
    }
    let _e36 = local_10;
    return _e36;
}

fn placevf2f1_(p_4: ptr<function, vec2<f32>>, z_4: ptr<function, f32>) -> vec3<f32> {
    let _e9 = (*p_4)[0u];
    let _e11 = (*z_4);
    let _e15 = (*p_4)[1u];
    let _e17 = (*z_4);
    let _e21 = (*z_4);
    return vec3<f32>((((_e9 - 960f) * _e11) / 1404f), (70f + (((464.4f - _e15) * _e17) / 1404f)), _e21);
}

fn floorAtvf2_(p_5: ptr<function, vec2<f32>>) -> f32 {
    var param_88: vec2<f32>;

    let _e2 = (*p_5);
    param_88 = _e2;
    let _e3 = bedvf2_((&param_88));
    return _e3;
}

fn surfacei1vf2f1_(i_5: ptr<function, i32>, uv_1: ptr<function, vec2<f32>>, tag: ptr<function, f32>) -> vec3<f32> {
    var u_1: f32;
    var v: f32;
    var a_2: f32;
    var z_5: f32;
    var param_89: i32;
    var param_90: i32;
    var east: bool;
    var l: f32;
    var r_3: f32;
    var j_1: i32;
    var m_1: f32;
    var dry: bool;
    var param_91: vec2<f32>;
    var x_2: f32;
    var param_92: i32;
    var param_93: i32;
    var y_1: f32;
    var param_94: vec2<f32>;
    var size: f32;
    var param_95: i32;
    var param_96: i32;
    var d_1: vec3<f32>;
    var param_97: vec2<f32>;
    var tuft: i32;
    var param_98: i32;
    var param_99: i32;
    var param_100: i32;
    var param_101: i32;
    var param_102: i32;
    var param_103: i32;
    var b: vec4<f32>;
    var indexable_2: array<vec4<f32>, 20>;
    var z_6: f32;
    var indexable_3: array<f32, 20>;
    var dir: vec3<f32>;
    var moss: bool;
    var shape: vec3<f32>;
    var n: f32;
    var param_104: vec2<f32>;
    var param_105: vec2<f32>;
    var local_15: f32;
    var center: vec3<f32>;
    var param_106: vec2<f32>;
    var param_107: f32;
    var n_1: vec3<f32>;
    var side: vec3<f32>;
    var up: vec3<f32>;
    var angle: f32;
    var param_108: i32;
    var param_109: i32;
    var polar: f32;
    var petals: f32;
    var param_110: i32;
    var param_111: i32;
    var tier: i32;
    var arm: i32;
    var fan: i32;
    var j_2: i32;
    var seed_1: i32;
    var f_2: f32;
    var az: f32;
    var param_112: i32;
    var param_113: i32;
    var d_2: vec3<f32>;
    var side_1: vec3<f32>;
    var origin: vec3<f32>;
    var param_114: vec2<f32>;
    var param_115: f32;
    var param_116: vec2<f32>;
    var param_117: f32;
    var len: f32;
    var param_118: i32;
    var param_119: i32;
    var t: f32;
    var anchor: vec3<f32>;
    var twigLen: f32;
    var param_120: i32;
    var param_121: i32;
    var twig: vec3<f32>;
    var along: f32;
    var q: vec3<f32>;
    var span: f32;
    var dir_1: vec3<f32>;
    var ridge: vec3<f32>;
    var param_122: vec2<f32>;
    var param_123: f32;
    var x_3: f32;
    var y_2: f32;
    var param_124: vec2<f32>;
    var param_125: vec2<f32>;
    var param_126: f32;
    var y_3: f32;
    var z_7: f32;
    var base: f32;
    var local_16: f32;
    var r_4: f32;
    var local_17: f32;
    var param_127: vec2<f32>;
    var param_128: vec2<f32>;
    var param_129: f32;
    var limb: i32;
    var local_18: i32;
    var local_19: i32;
    var lat: i32;
    var local_20: i32;
    var shoot: i32;
    var j_3: i32;
    var z_8: f32;
    var indexable_4: array<f32, 14>;
    var b_1: vec4<f32>;
    var indexable_5: array<vec4<f32>, 14>;
    var p0_: vec3<f32>;
    var param_130: vec2<f32>;
    var param_131: f32;
    var p1_: vec3<f32>;
    var param_132: vec2<f32>;
    var param_133: f32;
    var d_3: vec3<f32>;
    var seed_2: i32;
    var t_1: f32;
    var local_21: f32;
    var param_134: i32;
    var param_135: i32;
    var root_1: vec3<f32>;
    var side_2: f32;
    var width_1: f32;
    var indexable_6: array<f32, 14>;
    var param_136: i32;
    var param_137: i32;
    var branch: vec3<f32>;
    var param_138: i32;
    var param_139: i32;
    var local_22: f32;
    var param_140: i32;
    var param_141: i32;
    var param_142: i32;
    var param_143: i32;
    var axis: vec3<f32>;
    var s: vec3<f32>;
    var f_3: f32;
    var param_144: i32;
    var param_145: i32;
    var angle_1: f32;
    var param_146: i32;
    var param_147: i32;
    var outDir: vec3<f32>;
    var scale: f32;
    var spr: vec3<f32>;
    var param_148: i32;
    var param_149: i32;
    var az_1: vec3<f32>;
    var tangent: vec3<f32>;
    var g: f32;
    var param_150: i32;
    var param_151: i32;
    var phi: f32;
    var param_152: i32;
    var param_153: i32;
    var rad: vec3<f32>;
    var tip: vec3<f32>;
    var param_154: i32;
    var param_155: i32;
    var close: bool;
    var spine: bool;
    var fr: i32;
    var local_23: i32;
    var leaf: i32;
    var cluster: i32;
    var local_24: i32;
    var arm_1: i32;
    var o: vec2<f32>;
    var indexable_7: array<vec2<f32>, 4>;
    var angle_2: f32;
    var param_156: i32;
    var param_157: i32;
    var extent: vec2<f32>;
    var local_25: f32;
    var param_158: i32;
    var param_159: i32;
    var t_2: f32;
    var local_26: f32;
    var p_6: vec2<f32>;
    var side_3: f32;
    var d_4: vec2<f32>;
    var w: f32;
    var local_27: f32;
    var param_160: i32;
    var param_161: i32;
    var dir_2: vec2<f32>;
    var param_162: vec2<f32>;
    var param_163: f32;
    var stem: bool;
    var flower: i32;
    var local_28: i32;
    var o_1: vec2<f32>;
    var p_7: vec2<f32>;
    var theta: f32;
    var theta_1: f32;
    var param_164: vec2<f32>;
    var param_165: f32;
    var cl: i32;
    var o_2: vec2<f32>;
    var local_29: vec2<f32>;
    var param_166: i32;
    var param_167: i32;
    var param_168: i32;
    var param_169: i32;
    var phi_1: f32;
    var param_170: i32;
    var param_171: i32;
    var dir_3: vec2<f32>;
    var w_1: f32;
    var p_8: vec2<f32>;
    var param_172: vec2<f32>;
    var param_173: f32;
    var o_3: vec2<f32>;
    var p_9: vec2<f32>;
    var param_174: vec2<f32>;
    var param_175: f32;
    var cl_1: i32;
    var o_4: vec2<f32>;
    var local_30: vec2<f32>;
    var a_3: f32;
    var param_176: i32;
    var param_177: i32;
    var len_1: f32;
    var param_178: i32;
    var param_179: i32;
    var p_10: vec2<f32>;
    var param_180: vec2<f32>;
    var param_181: f32;
    var o_5: vec2<f32>;
    var d_5: vec2<f32>;
    var t_3: f32;
    var local_31: f32;
    var local_32: i32;
    var p_11: vec2<f32>;
    var f_4: f32;
    var param_182: vec2<f32>;
    var param_183: f32;

    let _e489 = (*uv_1)[0u];
    u_1 = _e489;
    let _e491 = (*uv_1)[1u];
    v = _e491;
    let _e492 = u_1;
    a_2 = (6.2831855f * _e492);
    let _e494 = group;
    if (_e494 == 20i) {
        let _e496 = (*i_5);
        param_89 = (_e496 / 2i);
        param_90 = 16i;
        let _e498 = rndi1i1_((&param_89), (&param_90));
        z_5 = mix(181f, 434f, _e498);
        let _e500 = (*i_5);
        east = ((_e500 - (i32(floor((f32(_e500) / f32(2i)))) * 2i)) == 0i);
        let _e509 = east;
        l = select(-55f, 65f, _e509);
        let _e511 = east;
        r_3 = select(75f, 265f, _e511);
        j_1 = 0i;
        loop {
            let _e513 = j_1;
            if (_e513 < 12i) {
                let _e515 = l;
                let _e516 = r_3;
                m_1 = ((_e515 + _e516) * 0.5f);
                let _e519 = m_1;
                let _e520 = z_5;
                param_91 = vec2<f32>(_e519, _e520);
                let _e522 = floorAtvf2_((&param_91));
                dry = (_e522 > 0f);
                let _e524 = dry;
                let _e525 = east;
                if (_e524 == _e525) {
                    let _e527 = m_1;
                    r_3 = _e527;
                } else {
                    let _e528 = m_1;
                    l = _e528;
                }
                continue;
            } else {
                break;
            }
            continuing {
                let _e529 = j_1;
                j_1 = (_e529 + 1i);
            }
        }
        let _e531 = l;
        let _e532 = r_3;
        let _e535 = (*i_5);
        param_92 = _e535;
        param_93 = 18i;
        let _e536 = rndi1i1_((&param_92), (&param_93));
        x_2 = ((0.5f * (_e531 + _e532)) + mix(-2f, 2f, _e536));
        let _e539 = x_2;
        let _e540 = z_5;
        param_94 = vec2<f32>(_e539, _e540);
        let _e542 = floorAtvf2_((&param_94));
        y_1 = _e542;
        let _e543 = (*i_5);
        param_95 = _e543;
        param_96 = 17i;
        let _e544 = rndi1i1_((&param_95), (&param_96));
        size = mix(0.4f, 1.36f, _e544);
        let _e546 = y_1;
        if (abs(_e546) > 6f) {
            size = 0f;
        }
        let _e549 = a_2;
        let _e551 = v;
        let _e555 = v;
        let _e558 = a_2;
        let _e560 = v;
        d_1 = vec3<f32>((cos(_e549) * sin((3.1415927f * _e551))), cos((3.1415927f * _e555)), (sin(_e558) * sin((3.1415927f * _e560))));
        let _e565 = d_1;
        let _e567 = d_1;
        d_1 = (sign(_e565) * pow(abs(_e567), vec3<f32>(0.77f, 0.77f, 0.77f)));
        (*tag) = -8f;
        let _e571 = x_2;
        let _e572 = y_1;
        let _e574 = z_5;
        let _e576 = d_1;
        let _e577 = size;
        let _e580 = d_1;
        let _e583 = (*i_5);
        param_97 = ((_e580.xy * 4f) + vec2(f32(_e583)));
        let _e587 = valueNoise2vf2_((&param_97));
        return (vec3<f32>(_e571, (_e572 - 0.19f), _e574) + (((_e576 * _e577) * vec3<f32>(1.6f, 0.6f, 0.94f)) * (1f + (0.11f * _e587))));
    }
    let _e592 = group;
    let _e594 = group;
    if ((_e592 == 0i) || (_e594 == 18i)) {
        let _e597 = (*i_5);
        tuft = _e597;
        let _e598 = group;
        if (_e598 == 18i) {
            let _e600 = tuft;
            param_98 = _e600;
            param_99 = 1i;
            let _e601 = rndi1i1_((&param_98), (&param_99));
            (*i_5) = (5i + i32((_e601 * 15f)));
            let _e605 = tuft;
            param_100 = _e605;
            param_101 = 2i;
            let _e606 = rndi1i1_((&param_100), (&param_101));
            u_1 = _e606;
            let _e607 = u_1;
            a_2 = (6.2831855f * _e607);
            let _e609 = tuft;
            param_102 = _e609;
            param_103 = 3i;
            let _e610 = rndi1i1_((&param_102), (&param_103));
            v = (acos(mix(-0.2f, 1f, _e610)) / 3.1415927f);
        }
        let _e614 = (*i_5);
        indexable_2 = array<vec4<f32>, 20>(vec4<f32>(167f, 995f, 128f, 72f), vec4<f32>(523f, 959f, 125f, 86f), vec4<f32>(742f, 1103f, 92f, 83f), vec4<f32>(1055f, 1115f, 211f, 73f), vec4<f32>(388f, 1010f, 158f, 68f), vec4<f32>(362f, 978f, 124f, 73f), vec4<f32>(434f, 960f, 68f, 63f), vec4<f32>(642f, 1030f, 111f, 49f), vec4<f32>(749f, 1061f, 112f, 49f), vec4<f32>(139f, 867f, 82f, 54f), vec4<f32>(56f, 881f, 99f, 64f), vec4<f32>(120f, 928f, 61f, 46f), vec4<f32>(855f, 1092f, 88f, 41f), vec4<f32>(24f, 993f, 80f, 39f), vec4<f32>(125f, 1098f, 105f, 53f), vec4<f32>(288f, 1096f, 113f, 39f), vec4<f32>(503f, 1084f, 78f, 41f), vec4<f32>(243f, 1022f, 42f, 24f), vec4<f32>(448f, 1025f, 37f, 19f), vec4<f32>(550f, 1054f, 59f, 25f));
        let _e616 = indexable_2[_e614];
        b = _e616;
        let _e617 = (*i_5);
        indexable_3 = array<f32, 20>(15.7f, 16.1f, 13.1f, 14.1f, 15f, 14.2f, 14.7f, 14.6f, 14.4f, 17.1f, 17f, 16.8f, 14f, 13.8f, 12.7f, 13.2f, 13.6f, 13.8f, 13.9f, 14.4f);
        let _e619 = indexable_3[_e617];
        z_6 = _e619;
        let _e620 = a_2;
        let _e622 = v;
        let _e626 = v;
        let _e629 = a_2;
        let _e631 = v;
        dir = vec3<f32>((cos(_e620) * sin((3.1415927f * _e622))), cos((3.1415927f * _e626)), (sin(_e629) * sin((3.1415927f * _e631))));
        let _e636 = (*i_5);
        moss = (_e636 >= 5i);
        let _e638 = dir;
        let _e640 = dir;
        let _e642 = moss;
        shape = (sign(_e638) * pow(abs(_e640), vec3(select(0.67f, 1f, _e642))));
        let _e647 = dir;
        let _e651 = dir[2u];
        let _e655 = (*i_5);
        param_104 = (((_e647.xy * 4f) + vec2((_e651 * 3f))) + vec2(f32(_e655)));
        let _e659 = valueNoise2vf2_((&param_104));
        n = _e659;
        let _e660 = moss;
        let _e662 = n;
        let _e665 = moss;
        let _e667 = dir;
        let _e671 = dir[2u];
        param_105 = ((_e667.xy * 22f) + vec2((_e671 * 13f)));
        let _e675 = valueNoise2vf2_((&param_105));
        let _e678 = shape;
        shape = (_e678 * ((0.97f + (select(0.09f, 0.035f, _e660) * _e662)) + (select(0.012f, 0.007f, _e665) * _e675)));
        let _e680 = moss;
        if _e680 {
            local_15 = 0f;
        } else {
            let _e682 = shape[0u];
            let _e685 = shape[2u];
            local_15 = ((0.2f * _e682) + (0.12f * _e685));
        }
        let _e688 = local_15;
        let _e690 = shape[1u];
        shape[1u] = (_e690 - _e688);
        let _e693 = b;
        param_106 = _e693.xy;
        let _e695 = z_6;
        param_107 = _e695;
        let _e696 = placevf2f1_((&param_106), (&param_107));
        let _e697 = shape;
        let _e699 = b[2u];
        let _e701 = b[3u];
        let _e703 = b[2u];
        let _e707 = z_6;
        center = (_e696 + (((_e697 * vec3<f32>(_e699, _e701, (_e703 * 0.67f))) * _e707) / vec3(1404f)));
        let _e712 = moss;
        (*tag) = select(11f, 12f, _e712);
        let _e714 = group;
        if (_e714 == 18i) {
            let _e716 = dir;
            let _e718 = b[2u];
            let _e720 = b[3u];
            let _e722 = b[2u];
            n_1 = normalize((_e716 / vec3<f32>(_e718, _e720, (_e722 * 0.67f))));
            let _e727 = n_1;
            side = normalize(cross(_e727, vec3<f32>(0.01f, 0.97f, 0.18f)));
            let _e730 = n_1;
            let _e731 = side;
            up = cross(_e730, _e731);
            let _e733 = tuft;
            param_108 = _e733;
            param_109 = 4i;
            let _e734 = rndi1i1_((&param_108), (&param_109));
            angle = (_e734 * 6.283f);
            let _e736 = angle;
            let _e738 = (*uv_1)[0u];
            polar = (_e736 + (_e738 * 6.283f));
            let _e741 = polar;
            let _e742 = angle;
            petals = ((cos((5f * (_e741 - _e742))) * 0.26f) + 0.72f);
            let _e748 = z_6;
            let _e750 = tuft;
            param_110 = _e750;
            param_111 = 5i;
            let _e751 = rndi1i1_((&param_110), (&param_111));
            let _e754 = n_1;
            let _e756 = (*uv_1)[1u];
            let _e761 = (*uv_1)[1u];
            let _e762 = petals;
            let _e764 = polar;
            let _e766 = side;
            let _e768 = polar;
            let _e770 = up;
            let _e776 = center;
            center = (_e776 + (((_e754 * (1.1f - (0.91f * _e756))) + (((_e766 * cos(_e764)) + (_e770 * sin(_e768))) * (_e761 * _e762))) * ((_e748 / 1404f) * mix(1f, 2.8f, _e751))));
        }
        let _e778 = center;
        return _e778;
    }
    let _e779 = group;
    if (_e779 == 17i) {
        let _e781 = (*i_5);
        tier = (_e781 / 2240i);
        let _e783 = (*i_5);
        let _e784 = (_e783 / 320i);
        arm = (_e784 - (i32(floor((f32(_e784) / f32(7i)))) * 7i));
        let _e792 = (*i_5);
        let _e793 = (_e792 / 16i);
        fan = (_e793 - (i32(floor((f32(_e793) / f32(20i)))) * 20i));
        let _e801 = (*i_5);
        j_2 = (_e801 - (i32(floor((f32(_e801) / f32(16i)))) * 16i));
        let _e809 = tier;
        let _e811 = arm;
        seed_1 = ((_e809 * 103i) + (_e811 * 37i));
        let _e814 = tier;
        f_2 = ((f32(_e814) + 0.3f) / 8f);
        let _e818 = tier;
        let _e821 = arm;
        let _e825 = seed_1;
        param_112 = _e825;
        param_113 = 5i;
        let _e826 = rndi1i1_((&param_112), (&param_113));
        az = (((f32(_e818) * 2.4f) + (f32(_e821) * 0.898f)) + (0.36f * (_e826 - 0.5f)));
        let _e830 = az;
        let _e832 = az;
        d_2 = vec3<f32>(cos(_e830), 0f, sin(_e832));
        let _e836 = d_2[2u];
        let _e839 = d_2[0u];
        side_1 = vec3<f32>(-(_e836), 0f, _e839);
        param_114 = vec2<f32>(518f, 660f);
        param_115 = 83f;
        let _e841 = placevf2f1_((&param_114), (&param_115));
        param_116 = vec2<f32>(516f, 929f);
        param_117 = 83f;
        let _e842 = placevf2f1_((&param_116), (&param_117));
        let _e843 = f_2;
        origin = mix(_e841, _e842, vec3(_e843));
        let _e846 = f_2;
        let _e850 = seed_1;
        param_118 = _e850;
        param_119 = 7i;
        let _e851 = rndi1i1_((&param_118), (&param_119));
        len = ((0.4f + (6.05f * pow(_e846, 0.78f))) * (0.75f + (0.4f * _e851)));
        let _e855 = fan;
        t = ((f32((_e855 / 2i)) + 1f) / 11f);
        let _e860 = origin;
        let _e861 = d_2;
        let _e862 = len;
        let _e864 = t;
        let _e866 = t;
        let _e868 = t;
        let _e873 = len;
        let _e874 = t;
        let _e876 = t;
        let _e878 = t;
        anchor = ((_e860 + ((_e861 * _e862) * ((1.16f * _e864) - ((0.16f * _e866) * _e868)))) + vec3<f32>(0f, (_e873 * ((-1.06f * _e874) + ((0.75f * _e876) * _e878))), 0f));
        let _e884 = len;
        let _e885 = fan;
        let _e892 = seed_1;
        param_120 = _e892;
        let _e893 = fan;
        param_121 = _e893;
        let _e894 = rndi1i1_((&param_120), (&param_121));
        twigLen = ((_e884 * (1f - (f32(((_e885 / 2i) + 1i)) / 15f))) * mix(0.47f, 0.72f, _e894));
        let _e897 = d_2;
        let _e899 = side_1;
        let _e900 = fan;
        twig = (((_e897 * 0.45f) + (_e899 * select(-0.72f, 0.72f, ((_e900 - (i32(floor((f32(_e900) / f32(2i)))) * 2i)) == 0i)))) + vec3<f32>(0f, -0.62f, 0f));
        let _e913 = j_2;
        along = (f32((_e913 / 2i)) / 8f);
        let _e917 = anchor;
        let _e918 = twig;
        let _e919 = twigLen;
        let _e921 = along;
        q = (_e917 + ((_e918 * _e919) * _e921));
        let _e924 = twigLen;
        let _e925 = along;
        span = (_e924 * (0.38f - (0.22f * _e925)));
        let _e929 = twig;
        let _e931 = d_2;
        let _e934 = side_1;
        let _e935 = j_2;
        dir_1 = ((((_e929 * 0.5f) + (_e931 * 0.33f)) + (_e934 * select(0.49f, -0.49f, ((_e935 - (i32(floor((f32(_e935) / f32(2i)))) * 2i)) == 0i)))) + vec3<f32>(0f, -0.18f, 0f));
        let _e948 = dir_1;
        ridge = normalize(cross(_e948, vec3<f32>(0f, 1f, 0f)));
        (*tag) = 22.125f;
        let _e951 = q;
        let _e952 = span;
        let _e953 = dir_1;
        let _e954 = u_1;
        let _e956 = ridge;
        let _e957 = v;
        let _e961 = u_1;
        let _e966 = u_1;
        return (_e951 + ((((_e953 * _e954) + (((_e956 * (_e957 - 0.5f)) * 0.28f) * sin((3.1415927f * _e961)))) + vec3<f32>(0f, (0.03f * sin((3.1415927f * _e966))), 0f)) * _e952));
    }
    let _e974 = group;
    if (_e974 == 19i) {
        (*tag) = 21f;
        let _e976 = u_1;
        param_122 = mix(vec2<f32>(516f, 928f), vec2<f32>(518f, 660f), vec2(_e976));
        param_123 = 83f;
        let _e979 = placevf2f1_((&param_122), (&param_123));
        let _e980 = v;
        let _e983 = u_1;
        return (_e979 + vec3<f32>((((_e980 - 0.5f) * 0.29f) * (1f - _e983)), 0f, 0f));
    }
    let _e988 = group;
    if (_e988 == 1i) {
        let _e990 = u_1;
        x_3 = mix(-300f, 1450f, _e990);
        let _e992 = x_3;
        let _e997 = x_3;
        let _e1002 = x_3;
        param_124 = vec2<f32>((_e1002 * 0.025f), 1f);
        let _e1005 = valueNoise2vf2_((&param_124));
        let _e1008 = v;
        y_2 = ((((828f + (0.19f * max((_e992 - 130f), 0f))) + (0.23f * max((_e997 - 400f), 0f))) + (7f * _e1005)) + (380f * _e1008));
        (*tag) = 10f;
        let _e1011 = x_3;
        let _e1012 = y_2;
        let _e1014 = v;
        param_125 = vec2<f32>(_e1011, _e1012);
        param_126 = mix(19.1f, 10.6f, _e1014);
        let _e1016 = placevf2f1_((&param_125), (&param_126));
        return _e1016;
    }
    let _e1017 = group;
    if (_e1017 == 2i) {
        let _e1019 = v;
        y_3 = mix(-190f, 915f, _e1019);
        let _e1021 = (*i_5);
        z_7 = select(34f, 18.6f, (_e1021 == 0i));
        let _e1024 = (*i_5);
        if (_e1024 == 0i) {
            let _e1026 = y_3;
            local_16 = (15f + (0.014f * (480f - _e1026)));
        } else {
            let _e1030 = y_3;
            let _e1034 = y_3;
            local_16 = ((131f + ((800f - _e1030) * 0.058f)) + (5f * sin((_e1034 * 0.011f))));
        }
        let _e1039 = local_16;
        base = _e1039;
        let _e1040 = (*i_5);
        if (_e1040 == 0i) {
            let _e1042 = v;
            let _e1045 = v;
            local_17 = ((70f + (33f * _e1042)) + (58f * pow(_e1045, 12f)));
        } else {
            let _e1049 = v;
            local_17 = (17f + (5f * _e1049));
        }
        let _e1052 = local_17;
        let _e1053 = a_2;
        let _e1055 = v;
        let _e1061 = a_2;
        let _e1064 = v;
        let _e1066 = a_2;
        param_127 = vec2<f32>((9f * cos(_e1061)), ((4f * _e1064) + (6f * sin(_e1066))));
        let _e1071 = valueNoise2vf2_((&param_127));
        r_4 = (_e1052 * ((0.96f + (0.035f * sin(((_e1053 * 11f) + (3f * _e1055))))) + (0.05f * _e1071)));
        (*tag) = 19f;
        let _e1075 = base;
        let _e1076 = y_3;
        param_128 = vec2<f32>(_e1075, _e1076);
        let _e1078 = z_7;
        param_129 = _e1078;
        let _e1079 = placevf2f1_((&param_128), (&param_129));
        let _e1080 = a_2;
        let _e1082 = r_4;
        let _e1084 = a_2;
        let _e1086 = r_4;
        let _e1089 = z_7;
        return (_e1079 + ((vec3<f32>((cos(_e1080) * _e1082), 0f, (sin(_e1084) * _e1086)) * _e1089) / vec3(1404f)));
    }
    let _e1094 = group;
    let _e1096 = group;
    if ((_e1094 >= 3i) && (_e1096 <= 5i)) {
        let _e1099 = group;
        if (_e1099 == 3i) {
            let _e1101 = (*i_5);
            local_18 = _e1101;
        } else {
            let _e1102 = group;
            if (_e1102 == 4i) {
                let _e1104 = (*i_5);
                local_19 = (_e1104 / 36i);
            } else {
                let _e1106 = (*i_5);
                local_19 = (_e1106 / 15120i);
            }
            let _e1108 = local_19;
            local_18 = _e1108;
        }
        let _e1109 = local_18;
        limb = _e1109;
        let _e1110 = group;
        if (_e1110 == 4i) {
            let _e1112 = (*i_5);
            local_20 = (_e1112 - (i32(floor((f32(_e1112) / f32(36i)))) * 36i));
        } else {
            let _e1120 = (*i_5);
            let _e1121 = (_e1120 / 420i);
            local_20 = (_e1121 - (i32(floor((f32(_e1121) / f32(36i)))) * 36i));
        }
        let _e1129 = local_20;
        lat = _e1129;
        let _e1130 = (*i_5);
        let _e1131 = (_e1130 / 28i);
        shoot = (_e1131 - (i32(floor((f32(_e1131) / f32(15i)))) * 15i));
        let _e1139 = (*i_5);
        j_3 = (_e1139 - (i32(floor((f32(_e1139) / f32(28i)))) * 28i));
        let _e1147 = limb;
        indexable_4 = array<f32, 14>(18f, 18f, 18f, 18f, 18f, 18f, 19f, 19f, 17f, 24f, 23f, 23f, 21f, 21f);
        let _e1149 = indexable_4[_e1147];
        z_8 = _e1149;
        let _e1150 = limb;
        indexable_5 = array<vec4<f32>, 14>(vec4<f32>(93f, -60f, 384f, 65f), vec4<f32>(169f, -23f, 283f, 18f), vec4<f32>(9f, 99f, 214f, 223f), vec4<f32>(12f, 143f, 206f, 201f), vec4<f32>(7f, 213f, 169f, 322f), vec4<f32>(3f, 306f, 147f, 370f), vec4<f32>(22f, -17f, 256f, 35f), vec4<f32>(29f, 44f, 199f, 154f), vec4<f32>(134f, -24f, 335f, 113f), vec4<f32>(1117f, 198f, 1041f, 273f), vec4<f32>(1127f, 251f, 1044f, 322f), vec4<f32>(1118f, 337f, 997f, 433f), vec4<f32>(1125f, 492f, 990f, 561f), vec4<f32>(1118f, 547f, 1030f, 623f));
        let _e1152 = indexable_5[_e1150];
        b_1 = (_e1152 * 1.74545f);
        let _e1154 = b_1;
        param_130 = _e1154.xy;
        let _e1156 = z_8;
        param_131 = _e1156;
        let _e1157 = placevf2f1_((&param_130), (&param_131));
        p0_ = _e1157;
        let _e1158 = z_8;
        let _e1160 = b_1;
        param_132 = _e1160.zw;
        param_133 = (_e1158 + 1.5f);
        let _e1162 = placevf2f1_((&param_132), (&param_133));
        p1_ = _e1162;
        let _e1163 = p1_;
        let _e1164 = p0_;
        d_3 = (_e1163 - _e1164);
        let _e1166 = limb;
        let _e1168 = lat;
        seed_2 = ((_e1166 * 101i) + _e1168);
        let _e1170 = group;
        if (_e1170 == 3i) {
            let _e1172 = u_1;
            local_21 = _e1172;
        } else {
            let _e1173 = lat;
            let _e1177 = seed_2;
            param_134 = _e1177;
            param_135 = 4i;
            let _e1178 = rndi1i1_((&param_134), (&param_135));
            local_21 = (((f32((_e1173 / 2i)) + 0.12f) + (0.71f * _e1178)) / 18f);
        }
        let _e1182 = local_21;
        t_1 = _e1182;
        let _e1183 = p0_;
        let _e1184 = p1_;
        let _e1185 = t_1;
        let _e1188 = t_1;
        root_1 = (mix(_e1183, _e1184, vec3(_e1185)) + (vec3<f32>(0f, -0.25f, 0.26f) * sin((3.1415927f * _e1188))));
        let _e1193 = group;
        if (_e1193 == 3i) {
            (*tag) = -0.1f;
            let _e1195 = root_1;
            let _e1196 = v;
            let _e1199 = u_1;
            return (_e1195 + vec3<f32>(0f, (((_e1196 - 0.5f) * 0.08f) * pow((1f - _e1199), 1.7f)), 0f));
        }
        let _e1205 = lat;
        side_2 = select(1f, -1f, ((_e1205 - (i32(floor((f32(_e1205) / f32(2i)))) * 2i)) == 0i));
        let _e1215 = limb;
        indexable_6 = array<f32, 14>(1.09f, 0.84f, 0.8f, 0.75f, 0.74f, 0.65f, 1.21f, 1.33f, 1.05f, 0.89f, 0.7f, 0.93f, 1.12f, 0.82f);
        let _e1217 = indexable_6[_e1215];
        let _e1219 = t_1;
        let _e1227 = seed_2;
        param_136 = _e1227;
        param_137 = 3i;
        let _e1228 = rndi1i1_((&param_136), (&param_137));
        width_1 = (((1.17f * _e1217) * (0.28f + (0.72f * pow(max(0.0001f, sin((3.1415927f * _e1219))), 0.52f)))) * (0.6f + (0.45f * _e1228)));
        let _e1233 = d_3[0u];
        let _e1234 = seed_2;
        param_138 = _e1234;
        param_139 = 4i;
        let _e1235 = rndi1i1_((&param_138), (&param_139));
        let _e1238 = side_2;
        let _e1239 = width_1;
        let _e1243 = width_1;
        let _e1244 = side_2;
        if (_e1244 > 0f) {
            let _e1246 = seed_2;
            param_140 = _e1246;
            param_141 = 1i;
            let _e1247 = rndi1i1_((&param_140), (&param_141));
            local_22 = mix(-0.15f, 0.32f, _e1247);
        } else {
            local_22 = -1f;
        }
        let _e1249 = local_22;
        let _e1251 = seed_2;
        param_142 = _e1251;
        param_143 = 7i;
        let _e1252 = rndi1i1_((&param_142), (&param_143));
        let _e1255 = width_1;
        let _e1256 = side_2;
        branch = vec3<f32>(((_e1233 * mix(0.06f, 0.19f, _e1235)) + ((_e1238 * _e1239) * 0.48f)), ((_e1243 * _e1249) * mix(0.7f, 1.55f, _e1252)), ((_e1255 * _e1256) * 0.85f));
        let _e1260 = group;
        if (_e1260 == 4i) {
            (*tag) = 21f;
            let _e1262 = root_1;
            let _e1263 = u_1;
            let _e1264 = branch;
            let _e1267 = v;
            let _e1270 = u_1;
            return ((_e1262 + (_e1264 * _e1263)) + vec3<f32>(0f, (((_e1267 - 0.5f) * 0.04f) * (1f - _e1270)), 0f));
        }
        let _e1275 = branch;
        axis = normalize(_e1275);
        let _e1277 = axis;
        s = normalize(cross(_e1277, vec3<f32>(0f, 1f, 0f)));
        let _e1280 = shoot;
        let _e1282 = shoot;
        let _e1284 = seed_2;
        param_144 = _e1284;
        param_145 = (_e1282 + 22i);
        let _e1285 = rndi1i1_((&param_144), (&param_145));
        f_3 = ((f32(_e1280) + mix(0.05f, 0.92f, _e1285)) / 15f);
        let _e1289 = shoot;
        let _e1292 = shoot;
        let _e1294 = seed_2;
        param_146 = _e1294;
        param_147 = (_e1292 + 71i);
        let _e1295 = rndi1i1_((&param_146), (&param_147));
        angle_1 = ((f32(_e1289) * 2.39996f) + (0.96f * (_e1295 - 0.5f)));
        let _e1299 = s;
        let _e1300 = angle_1;
        let _e1303 = axis;
        let _e1304 = s;
        let _e1306 = angle_1;
        outDir = ((_e1299 * cos(_e1300)) + (cross(_e1303, _e1304) * sin(_e1306)));
        let _e1310 = width_1;
        scale = (_e1310 * 0.67f);
        let _e1312 = outDir;
        let _e1314 = axis;
        let _e1318 = scale;
        let _e1320 = f_3;
        let _e1324 = shoot;
        let _e1326 = seed_2;
        param_148 = _e1326;
        param_149 = (_e1324 + 56i);
        let _e1327 = rndi1i1_((&param_148), (&param_149));
        spr = ((((((_e1312 * 0.56f) + (_e1314 * 0.71f)) + vec3<f32>(0f, -0.29f, 0f)) * _e1318) * (1f - (0.61f * _e1320))) * mix(0.72f, 1.22f, _e1327));
        let _e1330 = spr;
        az_1 = normalize(_e1330);
        let _e1332 = az_1;
        tangent = normalize(cross(_e1332, vec3<f32>(0f, 1f, 0f)));
        let _e1335 = j_3;
        let _e1337 = (*i_5);
        param_150 = _e1337;
        param_151 = 5i;
        let _e1338 = rndi1i1_((&param_150), (&param_151));
        g = ((f32(_e1335) + mix(0.07f, 0.93f, _e1338)) / 28f);
        let _e1342 = j_3;
        let _e1345 = (*i_5);
        param_152 = _e1345;
        param_153 = 9i;
        let _e1346 = rndi1i1_((&param_152), (&param_153));
        phi = ((f32(_e1342) * 2.39996f) + mix(-0.47f, 0.47f, _e1346));
        let _e1349 = tangent;
        let _e1350 = phi;
        let _e1353 = az_1;
        let _e1354 = tangent;
        let _e1356 = phi;
        rad = ((_e1349 * cos(_e1350)) + (cross(_e1353, _e1354) * sin(_e1356)));
        let _e1360 = rad;
        let _e1362 = az_1;
        let _e1366 = scale;
        let _e1368 = (*i_5);
        param_154 = _e1368;
        param_155 = 4i;
        let _e1369 = rndi1i1_((&param_154), (&param_155));
        let _e1372 = g;
        tip = ((((((_e1360 * 0.57f) + (_e1362 * 0.65f)) + vec3<f32>(0f, -0.16f, 0f)) * _e1366) * mix(0.21f, 0.48f, _e1369)) * (1f - (0.5f * _e1372)));
        let _e1376 = f_3;
        (*tag) = (0.15f + (0.29f * _e1376));
        let _e1379 = root_1;
        let _e1380 = branch;
        let _e1381 = f_3;
        let _e1384 = spr;
        let _e1385 = g;
        let _e1388 = tip;
        let _e1389 = u_1;
        let _e1392 = az_1;
        let _e1393 = rad;
        let _e1395 = scale;
        let _e1399 = g;
        let _e1403 = v;
        let _e1407 = u_1;
        return ((((_e1379 + (_e1380 * _e1381)) + (_e1384 * _e1385)) + (_e1388 * _e1389)) + ((((cross(_e1392, _e1393) * max(0.006f, (_e1395 * 0.017f))) * (1f - (0.37f * _e1399))) * ((2f * _e1403) - 1f)) * sin((3.1415927f * _e1407))));
    }
    let _e1412 = group;
    let _e1414 = group;
    let _e1417 = group;
    let _e1420 = group;
    if ((((_e1412 == 6i) || (_e1414 == 7i)) || (_e1417 == 13i)) || (_e1420 == 14i)) {
        let _e1423 = group;
        close = (_e1423 >= 13i);
        let _e1425 = group;
        let _e1427 = group;
        spine = ((_e1425 == 7i) || (_e1427 == 14i));
        let _e1430 = spine;
        if _e1430 {
            let _e1431 = (*i_5);
            local_23 = _e1431;
        } else {
            let _e1432 = (*i_5);
            local_23 = (_e1432 / 36i);
        }
        let _e1434 = local_23;
        fr = _e1434;
        let _e1435 = (*i_5);
        leaf = (_e1435 - (i32(floor((f32(_e1435) / f32(36i)))) * 36i));
        let _e1443 = close;
        if _e1443 {
            local_24 = 3i;
        } else {
            let _e1444 = fr;
            local_24 = (_e1444 / 7i);
        }
        let _e1446 = local_24;
        cluster = _e1446;
        let _e1447 = fr;
        arm_1 = (_e1447 - (i32(floor((f32(_e1447) / f32(7i)))) * 7i));
        let _e1455 = cluster;
        indexable_7 = array<vec2<f32>, 4>(vec2<f32>(275f, 895f), vec2<f32>(405f, 893f), vec2<f32>(843f, 1013f), vec2<f32>(34f, 1119f));
        let _e1457 = indexable_7[_e1455];
        o = _e1457;
        let _e1458 = arm_1;
        let _e1460 = fr;
        param_156 = _e1460;
        param_157 = 2i;
        let _e1461 = rndi1i1_((&param_156), (&param_157));
        angle_2 = mix(-2.95f, -0.2f, ((f32(_e1458) + (0.4f * _e1461)) / 7f));
        let _e1466 = angle_2;
        let _e1468 = angle_2;
        let _e1471 = cluster;
        if (_e1471 == 3i) {
            local_25 = 245f;
        } else {
            let _e1473 = cluster;
            local_25 = select(46f, 90f, (_e1473 == 0i));
        }
        let _e1476 = local_25;
        let _e1478 = fr;
        param_158 = _e1478;
        param_159 = 7i;
        let _e1479 = rndi1i1_((&param_158), (&param_159));
        extent = ((vec2<f32>(cos(_e1466), sin(_e1468)) * _e1476) * (0.66f + (0.54f * _e1479)));
        let _e1483 = spine;
        if _e1483 {
            let _e1484 = u_1;
            local_26 = _e1484;
        } else {
            let _e1485 = leaf;
            local_26 = ((f32((_e1485 / 2i)) + 0.7f) / 19f);
        }
        let _e1490 = local_26;
        t_2 = _e1490;
        let _e1491 = o;
        let _e1492 = extent;
        let _e1493 = t_2;
        let _e1497 = extent[0u];
        let _e1500 = t_2;
        let _e1502 = t_2;
        let _e1504 = t_2;
        let _e1506 = t_2;
        p_6 = ((_e1491 + (_e1492 * _e1493)) + vec2<f32>(0f, ((((0.42f * abs(_e1497)) * _e1500) * _e1502) - ((22f * _e1504) * (1f - _e1506)))));
        let _e1512 = spine;
        if _e1512 {
            let _e1513 = v;
            let _e1517 = p_6[0u];
            p_6[0u] = (_e1517 + ((_e1513 - 0.5f) * 1.8f));
        } else {
            let _e1520 = leaf;
            side_3 = select(1f, -1f, ((_e1520 - (i32(floor((f32(_e1520) / f32(2i)))) * 2i)) == 0i));
            let _e1530 = extent;
            d_4 = normalize(_e1530);
            let _e1532 = cluster;
            if (_e1532 == 3i) {
                local_27 = 49f;
            } else {
                let _e1534 = cluster;
                local_27 = select(9f, 18f, (_e1534 == 0i));
            }
            let _e1537 = local_27;
            let _e1538 = t_2;
            let _e1545 = (*i_5);
            param_160 = _e1545;
            param_161 = 2i;
            let _e1546 = rndi1i1_((&param_160), (&param_161));
            w = ((_e1537 * (0.22f + (0.78f * sin((3.1415927f * pow(_e1538, 0.8f)))))) * (0.7f + (0.48f * _e1546)));
            let _e1550 = d_4;
            let _e1552 = side_3;
            let _e1554 = d_4[1u];
            let _e1557 = d_4[0u];
            dir_2 = normalize(((_e1550 * 0.52f) + (vec2<f32>(-(_e1554), _e1557) * _e1552)));
            let _e1562 = w;
            let _e1563 = dir_2;
            let _e1564 = u_1;
            let _e1567 = dir_2[1u];
            let _e1570 = dir_2[0u];
            let _e1572 = v;
            let _e1576 = u_1;
            let _e1582 = p_6;
            p_6 = (_e1582 + (((_e1563 * _e1564) + (((vec2<f32>(-(_e1567), _e1570) * (_e1572 - 0.5f)) * 0.37f) * sin((_e1576 * 3.1415927f)))) * _e1562));
        }
        let _e1584 = close;
        (*tag) = select(13.125f, 25.125f, _e1584);
        let _e1586 = close;
        let _e1588 = t_2;
        let _e1591 = u_1;
        let _e1594 = p_6;
        param_162 = _e1594;
        param_163 = ((select(15.35f, 7.1f, _e1586) + (0.08f * _e1588)) + (0.05f * _e1591));
        let _e1595 = placevf2f1_((&param_162), (&param_163));
        return _e1595;
    }
    let _e1596 = group;
    let _e1598 = group;
    if ((_e1596 == 8i) || (_e1598 == 9i)) {
        let _e1601 = group;
        stem = (_e1601 == 9i);
        let _e1603 = stem;
        if _e1603 {
            let _e1604 = (*i_5);
            local_28 = _e1604;
        } else {
            let _e1605 = (*i_5);
            local_28 = (_e1605 / 9i);
        }
        let _e1607 = local_28;
        flower = _e1607;
        let _e1608 = flower;
        o_1 = select(vec2<f32>(422f, 988f), vec2<f32>(371f, 981f), vec2((_e1608 == 0i)));
        let _e1612 = stem;
        if _e1612 {
            let _e1613 = o_1;
            let _e1614 = u_1;
            let _e1618 = u_1;
            let _e1621 = v;
            let _e1625 = u_1;
            p_7 = (_e1613 + vec2<f32>((((-8f * sin((3.1415927f * _e1614))) + (3f * _e1618)) + ((_e1621 - 0.5f) * 1.9f)), (111f * _e1625)));
        } else {
            let _e1629 = (*i_5);
            theta = ((6.283f * f32((_e1629 - (i32(floor((f32(_e1629) / f32(9i)))) * 9i)))) / 9f);
            let _e1640 = o_1;
            let _e1641 = theta;
            let _e1644 = u_1;
            let _e1646 = v;
            let _e1649 = u_1;
            let _e1654 = theta;
            let _e1657 = u_1;
            let _e1659 = u_1;
            let _e1661 = u_1;
            p_7 = (_e1640 + vec2<f32>((((cos(_e1641) * 12f) * _e1644) + (((_e1646 - 0.5f) * 8f) * sin((3.1415927f * _e1649)))), (((4f * sin(_e1654)) * _e1657) - ((11f * _e1659) * _e1661))));
        }
        let _e1666 = stem;
        if !(_e1666) {
            let _e1668 = (*i_5);
            theta_1 = ((6.283f * f32((_e1668 - (i32(floor((f32(_e1668) / f32(9i)))) * 9i)))) / 9f);
            let _e1679 = o_1;
            let _e1680 = theta_1;
            let _e1682 = u_1;
            let _e1686 = v;
            let _e1689 = u_1;
            let _e1694 = theta_1;
            let _e1697 = u_1;
            let _e1700 = u_1;
            let _e1702 = u_1;
            let _e1705 = v;
            let _e1708 = u_1;
            p_7 = (_e1679 + vec2<f32>(((cos(_e1680) * (4f + (10f * _e1682))) + (((_e1686 - 0.5f) * 10f) * sin((3.1415927f * _e1689)))), ((((3f * sin(_e1694)) * (1f + _e1697)) - ((7f * _e1700) * _e1702)) + (((_e1705 - 0.5f) * 4f) * sin((3.1415927f * _e1708))))));
        }
        let _e1715 = stem;
        (*tag) = select(18.125f, 16.125f, _e1715);
        let _e1717 = flower;
        let _e1721 = u_1;
        let _e1724 = p_7;
        param_164 = _e1724;
        param_165 = ((12.8f + (0.05f * f32(_e1717))) + (0.03f * _e1721));
        let _e1725 = placevf2f1_((&param_164), (&param_165));
        return _e1725;
    }
    let _e1726 = group;
    if (_e1726 == 10i) {
        let _e1728 = (*i_5);
        cl = (_e1728 / 3i);
        let _e1730 = cl;
        if (_e1730 < 4i) {
            local_29 = vec2<f32>(284f, 1060f);
        } else {
            let _e1732 = cl;
            local_29 = select(vec2<f32>(72f, 908f), vec2<f32>(467f, 1060f), vec2((_e1732 < 8i)));
        }
        let _e1736 = local_29;
        o_2 = _e1736;
        let _e1737 = cl;
        param_166 = _e1737;
        param_167 = 2i;
        let _e1738 = rndi1i1_((&param_166), (&param_167));
        let _e1740 = cl;
        param_168 = _e1740;
        param_169 = 4i;
        let _e1741 = rndi1i1_((&param_168), (&param_169));
        let _e1744 = cl;
        let _e1748 = o_2;
        o_2 = (_e1748 + (vec2<f32>((_e1738 - 0.5f), (_e1741 - 0.5f)) * select(99f, 49f, (_e1744 < 8i))));
        let _e1750 = (*i_5);
        let _e1760 = cl;
        param_170 = _e1760;
        param_171 = 7i;
        let _e1761 = rndi1i1_((&param_170), (&param_171));
        phi_1 = ((f32((_e1750 - (i32(floor((f32(_e1750) / f32(3i)))) * 3i))) * 2.0944f) + (5f * _e1761));
        let _e1764 = phi_1;
        let _e1766 = phi_1;
        dir_3 = vec2<f32>(cos(_e1764), (sin(_e1766) * 0.63f));
        let _e1770 = cl;
        w_1 = select(39f, 24f, (_e1770 < 8i));
        let _e1773 = o_2;
        let _e1774 = dir_3;
        let _e1775 = u_1;
        let _e1777 = w_1;
        let _e1781 = dir_3[1u];
        let _e1784 = dir_3[0u];
        let _e1786 = v;
        let _e1789 = w_1;
        let _e1791 = u_1;
        p_8 = ((_e1773 + ((_e1774 * _e1775) * _e1777)) + (((vec2<f32>(-(_e1781), _e1784) * (_e1786 - 0.5f)) * _e1789) * pow(max(0f, sin((3.1415927f * _e1791))), 0.58f)));
        (*tag) = 14.125f;
        let _e1798 = cl;
        let _e1802 = u_1;
        let _e1807 = p_8;
        param_172 = _e1807;
        param_173 = ((12.5f + (0.05f * f32(_e1798))) + (0.08f * sin((_e1802 * 3.1415927f))));
        let _e1808 = placevf2f1_((&param_172), (&param_173));
        return _e1808;
    }
    let _e1809 = group;
    if (_e1809 == 11i) {
        let _e1811 = (*i_5);
        o_3 = select(vec2<f32>(592f, 1030f), vec2<f32>(506f, 988f), vec2((_e1811 == 0i)));
        let _e1815 = o_3;
        let _e1816 = u_1;
        let _e1818 = u_1;
        let _e1820 = u_1;
        let _e1825 = v;
        let _e1828 = u_1;
        p_9 = (_e1815 + vec2<f32>((64f * _e1816), (((31f * _e1818) + (6f * sin((3.1415927f * _e1820)))) + (((_e1825 - 0.5f) * 19f) * sin((3.1415927f * _e1828))))));
        (*tag) = 15.125f;
        let _e1835 = v;
        let _e1840 = u_1;
        let _e1845 = p_9;
        param_174 = _e1845;
        param_175 = ((13.4f + (0.05f * abs((_e1835 - 0.5f)))) + (0.11f * sin((_e1840 * 3.1415927f))));
        let _e1846 = placevf2f1_((&param_174), (&param_175));
        return _e1846;
    }
    let _e1847 = group;
    if (_e1847 == 12i) {
        let _e1849 = (*i_5);
        cl_1 = (_e1849 / 20i);
        let _e1851 = cl_1;
        if (_e1851 == 0i) {
            local_30 = vec2<f32>(643f, 956f);
        } else {
            let _e1853 = cl_1;
            local_30 = select(vec2<f32>(150f, 871f), vec2<f32>(974f, 1067f), vec2((_e1853 == 1i)));
        }
        let _e1857 = local_30;
        o_4 = _e1857;
        let _e1858 = (*i_5);
        param_176 = _e1858;
        param_177 = 2i;
        let _e1859 = rndi1i1_((&param_176), (&param_177));
        a_3 = mix(-2.98f, -0.17f, _e1859);
        let _e1861 = (*i_5);
        param_178 = _e1861;
        param_179 = 5i;
        let _e1862 = rndi1i1_((&param_178), (&param_179));
        len_1 = mix(17f, 62f, _e1862);
        let _e1864 = o_4;
        let _e1865 = len_1;
        let _e1866 = a_3;
        let _e1868 = u_1;
        let _e1870 = a_3;
        let _e1872 = u_1;
        let _e1874 = u_1;
        let _e1876 = u_1;
        let _e1882 = v;
        let _e1884 = u_1;
        p_10 = ((_e1864 + (vec2<f32>((cos(_e1866) * _e1868), ((sin(_e1870) * _e1872) + ((0.19f * _e1874) * _e1876))) * _e1865)) + vec2<f32>((((_e1882 - 0.5f) * (1f - _e1884)) * 3.2f), 0f));
        (*tag) = 20.125f;
        let _e1890 = cl_1;
        let _e1893 = p_10;
        param_180 = _e1893;
        param_181 = select(13.7f, 16.6f, (_e1890 == 2i));
        let _e1894 = placevf2f1_((&param_180), (&param_181));
        return _e1894;
    }
    o_5 = vec2<f32>(149f, 871f);
    d_5 = vec2<f32>(40f, -123f);
    let _e1895 = group;
    let _e1897 = (*i_5);
    if ((_e1895 == 15i) && (_e1897 == 0i)) {
        let _e1900 = u_1;
        local_31 = _e1900;
    } else {
        let _e1901 = group;
        if (_e1901 == 16i) {
            let _e1903 = (*i_5);
            local_32 = _e1903;
        } else {
            let _e1904 = (*i_5);
            local_32 = (_e1904 - 1i);
        }
        let _e1906 = local_32;
        local_31 = (0.58f + (0.068f * f32(_e1906)));
    }
    let _e1910 = local_31;
    t_3 = _e1910;
    let _e1911 = o_5;
    let _e1912 = d_5;
    let _e1913 = t_3;
    let _e1916 = t_3;
    p_11 = ((_e1911 + (_e1912 * _e1913)) + vec2<f32>((10f * sin((_e1916 * 3.1415927f))), 0f));
    let _e1922 = (*i_5);
    f_4 = select(1f, -1f, ((_e1922 - (i32(floor((f32(_e1922) / f32(2i)))) * 2i)) == 0i));
    let _e1932 = group;
    if (_e1932 == 15i) {
        let _e1934 = (*i_5);
        if (_e1934 > 0i) {
            let _e1936 = f_4;
            let _e1939 = u_1;
            let _e1941 = p_11;
            p_11 = (_e1941 + (vec2<f32>((_e1936 * 17f), -11f) * _e1939));
        }
        let _e1943 = v;
        let _e1947 = p_11[0u];
        p_11[0u] = (_e1947 + ((_e1943 - 0.5f) * 1.7f));
        (*tag) = 16.125f;
    } else {
        let _e1950 = f_4;
        let _e1954 = a_2;
        let _e1956 = v;
        let _e1960 = v;
        let _e1966 = p_11;
        p_11 = (_e1966 + (vec2<f32>((-(_e1950) * 17f), -11f) + (vec2<f32>((cos(_e1954) * sin((3.1415927f * _e1956))), cos((3.1415927f * _e1960))) * 4.8f)));
        (*tag) = 17.125f;
    }
    let _e1968 = v;
    let _e1971 = p_11;
    param_182 = _e1971;
    param_183 = (16.3f + (0.06f * _e1968));
    let _e1972 = placevf2f1_((&param_182), (&param_183));
    return _e1972;
}

fn unpackPatchi1i1vi2vi2_(id: ptr<function, i32>, inst: ptr<function, i32>, cell_1: ptr<function, vec2<i32>>, span_1: ptr<function, vec2<i32>>) {
    var ix: i32;
    var ix_1: i32;
    var ix_2: i32;
    var ix_3: i32;
    var ix_4: i32;
    var ix_5: i32;
    var ix_6: i32;
    var ix_7: i32;
    var ix_8: i32;
    var ix_9: i32;
    var ix_10: i32;
    var ix_11: i32;
    var ix_12: i32;
    var ix_13: i32;
    var ix_14: i32;
    var ix_15: i32;
    var ix_16: i32;
    var ix_17: i32;
    var ix_18: i32;
    var ix_19: i32;
    var ix_20: i32;

    let _e95 = (*id);
    if (_e95 < 4800i) {
        group = 0i;
        cols = 60i;
        rows = 36i;
        let _e97 = (*id);
        ix = (_e97 - 0i);
        let _e99 = ix;
        (*inst) = (_e99 / 240i);
        (*span_1) = vec2<i32>(3i, 3i);
        let _e101 = ix;
        let _e109 = ix;
        let _e110 = (_e109 / 20i);
        let _e119 = (*span_1);
        (*cell_1) = (vec2<i32>((_e101 - (i32(floor((f32(_e101) / f32(20i)))) * 20i)), (_e110 - (i32(floor((f32(_e110) / f32(12i)))) * 12i))) * _e119);
        return;
    }
    let _e121 = (*id);
    if (_e121 < 5000i) {
        group = 1i;
        cols = 100i;
        rows = 4i;
        let _e123 = (*id);
        ix_1 = (_e123 - 4800i);
        let _e125 = ix_1;
        (*inst) = (_e125 / 200i);
        (*span_1) = vec2<i32>(2i, 1i);
        let _e127 = ix_1;
        let _e135 = ix_1;
        let _e136 = (_e135 / 50i);
        let _e145 = (*span_1);
        (*cell_1) = (vec2<i32>((_e127 - (i32(floor((f32(_e127) / f32(50i)))) * 50i)), (_e136 - (i32(floor((f32(_e136) / f32(4i)))) * 4i))) * _e145);
        return;
    }
    let _e147 = (*id);
    if (_e147 < 6200i) {
        group = 2i;
        cols = 48i;
        rows = 50i;
        let _e149 = (*id);
        ix_2 = (_e149 - 5000i);
        let _e151 = ix_2;
        (*inst) = (_e151 / 600i);
        (*span_1) = vec2<i32>(2i, 2i);
        let _e153 = ix_2;
        let _e161 = ix_2;
        let _e162 = (_e161 / 24i);
        let _e171 = (*span_1);
        (*cell_1) = (vec2<i32>((_e153 - (i32(floor((f32(_e153) / f32(24i)))) * 24i)), (_e162 - (i32(floor((f32(_e162) / f32(25i)))) * 25i))) * _e171);
        return;
    }
    let _e173 = (*id);
    if (_e173 < 6424i) {
        group = 3i;
        cols = 32i;
        rows = 1i;
        let _e175 = (*id);
        ix_3 = (_e175 - 6200i);
        let _e177 = ix_3;
        (*inst) = (_e177 / 16i);
        (*span_1) = vec2<i32>(2i, 1i);
        let _e179 = ix_3;
        let _e187 = ix_3;
        let _e188 = (_e187 / 16i);
        let _e197 = (*span_1);
        (*cell_1) = (vec2<i32>((_e179 - (i32(floor((f32(_e179) / f32(16i)))) * 16i)), (_e188 - (i32(floor((f32(_e188) / f32(1i)))) * 1i))) * _e197);
        return;
    }
    let _e199 = (*id);
    if (_e199 < 7432i) {
        group = 4i;
        cols = 6i;
        rows = 1i;
        let _e201 = (*id);
        ix_4 = (_e201 - 6424i);
        let _e203 = ix_4;
        (*inst) = (_e203 / 2i);
        (*span_1) = vec2<i32>(3i, 1i);
        let _e205 = ix_4;
        let _e213 = ix_4;
        let _e214 = (_e213 / 2i);
        let _e223 = (*span_1);
        (*cell_1) = (vec2<i32>((_e205 - (i32(floor((f32(_e205) / f32(2i)))) * 2i)), (_e214 - (i32(floor((f32(_e214) / f32(1i)))) * 1i))) * _e223);
        return;
    }
    let _e225 = (*id);
    if (_e225 < 219112i) {
        group = 5i;
        cols = 2i;
        rows = 1i;
        let _e227 = (*id);
        ix_5 = (_e227 - 7432i);
        let _e229 = ix_5;
        (*inst) = (_e229 / 1i);
        (*span_1) = vec2<i32>(2i, 1i);
        let _e231 = ix_5;
        let _e239 = ix_5;
        let _e240 = (_e239 / 1i);
        let _e249 = (*span_1);
        (*cell_1) = (vec2<i32>((_e231 - (i32(floor((f32(_e231) / f32(1i)))) * 1i)), (_e240 - (i32(floor((f32(_e240) / f32(1i)))) * 1i))) * _e249);
        return;
    }
    let _e251 = (*id);
    if (_e251 < 219868i) {
        group = 6i;
        cols = 4i;
        rows = 2i;
        let _e253 = (*id);
        ix_6 = (_e253 - 219112i);
        let _e255 = ix_6;
        (*inst) = (_e255 / 1i);
        (*span_1) = vec2<i32>(4i, 2i);
        let _e257 = ix_6;
        let _e265 = ix_6;
        let _e266 = (_e265 / 1i);
        let _e275 = (*span_1);
        (*cell_1) = (vec2<i32>((_e257 - (i32(floor((f32(_e257) / f32(1i)))) * 1i)), (_e266 - (i32(floor((f32(_e266) / f32(1i)))) * 1i))) * _e275);
        return;
    }
    let _e277 = (*id);
    if (_e277 < 219973i) {
        group = 7i;
        cols = 15i;
        rows = 1i;
        let _e279 = (*id);
        ix_7 = (_e279 - 219868i);
        let _e281 = ix_7;
        (*inst) = (_e281 / 5i);
        (*span_1) = vec2<i32>(3i, 1i);
        let _e283 = ix_7;
        let _e291 = ix_7;
        let _e292 = (_e291 / 5i);
        let _e301 = (*span_1);
        (*cell_1) = (vec2<i32>((_e283 - (i32(floor((f32(_e283) / f32(5i)))) * 5i)), (_e292 - (i32(floor((f32(_e292) / f32(1i)))) * 1i))) * _e301);
        return;
    }
    let _e303 = (*id);
    if (_e303 < 220009i) {
        group = 8i;
        cols = 6i;
        rows = 3i;
        let _e305 = (*id);
        ix_8 = (_e305 - 219973i);
        let _e307 = ix_8;
        (*inst) = (_e307 / 2i);
        (*span_1) = vec2<i32>(3i, 3i);
        let _e309 = ix_8;
        let _e317 = ix_8;
        let _e318 = (_e317 / 2i);
        let _e327 = (*span_1);
        (*cell_1) = (vec2<i32>((_e309 - (i32(floor((f32(_e309) / f32(2i)))) * 2i)), (_e318 - (i32(floor((f32(_e318) / f32(1i)))) * 1i))) * _e327);
        return;
    }
    let _e329 = (*id);
    if (_e329 < 220017i) {
        group = 9i;
        cols = 12i;
        rows = 1i;
        let _e331 = (*id);
        ix_9 = (_e331 - 220009i);
        let _e333 = ix_9;
        (*inst) = (_e333 / 4i);
        (*span_1) = vec2<i32>(3i, 1i);
        let _e335 = ix_9;
        let _e343 = ix_9;
        let _e344 = (_e343 / 4i);
        let _e353 = (*span_1);
        (*cell_1) = (vec2<i32>((_e335 - (i32(floor((f32(_e335) / f32(4i)))) * 4i)), (_e344 - (i32(floor((f32(_e344) / f32(1i)))) * 1i))) * _e353);
        return;
    }
    let _e355 = (*id);
    if (_e355 < 220101i) {
        group = 10i;
        cols = 10i;
        rows = 5i;
        let _e357 = (*id);
        ix_10 = (_e357 - 220017i);
        let _e359 = ix_10;
        (*inst) = (_e359 / 2i);
        (*span_1) = vec2<i32>(5i, 5i);
        let _e361 = ix_10;
        let _e369 = ix_10;
        let _e370 = (_e369 / 2i);
        let _e379 = (*span_1);
        (*cell_1) = (vec2<i32>((_e361 - (i32(floor((f32(_e361) / f32(2i)))) * 2i)), (_e370 - (i32(floor((f32(_e370) / f32(1i)))) * 1i))) * _e379);
        return;
    }
    let _e381 = (*id);
    if (_e381 < 220105i) {
        group = 11i;
        cols = 14i;
        rows = 5i;
        let _e383 = (*id);
        ix_11 = (_e383 - 220101i);
        let _e385 = ix_11;
        (*inst) = (_e385 / 2i);
        (*span_1) = vec2<i32>(7i, 5i);
        let _e387 = ix_11;
        let _e395 = ix_11;
        let _e396 = (_e395 / 2i);
        let _e405 = (*span_1);
        (*cell_1) = (vec2<i32>((_e387 - (i32(floor((f32(_e387) / f32(2i)))) * 2i)), (_e396 - (i32(floor((f32(_e396) / f32(1i)))) * 1i))) * _e405);
        return;
    }
    let _e407 = (*id);
    if (_e407 < 220225i) {
        group = 12i;
        cols = 8i;
        rows = 1i;
        let _e409 = (*id);
        ix_12 = (_e409 - 220105i);
        let _e411 = ix_12;
        (*inst) = (_e411 / 2i);
        (*span_1) = vec2<i32>(4i, 1i);
        let _e413 = ix_12;
        let _e421 = ix_12;
        let _e422 = (_e421 / 2i);
        let _e431 = (*span_1);
        (*cell_1) = (vec2<i32>((_e413 - (i32(floor((f32(_e413) / f32(2i)))) * 2i)), (_e422 - (i32(floor((f32(_e422) / f32(1i)))) * 1i))) * _e431);
        return;
    }
    let _e433 = (*id);
    if (_e433 < 220729i) {
        group = 13i;
        cols = 6i;
        rows = 2i;
        let _e435 = (*id);
        ix_13 = (_e435 - 220225i);
        let _e437 = ix_13;
        (*inst) = (_e437 / 2i);
        (*span_1) = vec2<i32>(3i, 2i);
        let _e439 = ix_13;
        let _e447 = ix_13;
        let _e448 = (_e447 / 2i);
        let _e457 = (*span_1);
        (*cell_1) = (vec2<i32>((_e439 - (i32(floor((f32(_e439) / f32(2i)))) * 2i)), (_e448 - (i32(floor((f32(_e448) / f32(1i)))) * 1i))) * _e457);
        return;
    }
    let _e459 = (*id);
    if (_e459 < 220764i) {
        group = 14i;
        cols = 15i;
        rows = 1i;
        let _e461 = (*id);
        ix_14 = (_e461 - 220729i);
        let _e463 = ix_14;
        (*inst) = (_e463 / 5i);
        (*span_1) = vec2<i32>(3i, 1i);
        let _e465 = ix_14;
        let _e473 = ix_14;
        let _e474 = (_e473 / 5i);
        let _e483 = (*span_1);
        (*cell_1) = (vec2<i32>((_e465 - (i32(floor((f32(_e465) / f32(5i)))) * 5i)), (_e474 - (i32(floor((f32(_e474) / f32(1i)))) * 1i))) * _e483);
        return;
    }
    let _e485 = (*id);
    if (_e485 < 220785i) {
        group = 15i;
        cols = 12i;
        rows = 1i;
        let _e487 = (*id);
        ix_15 = (_e487 - 220764i);
        let _e489 = ix_15;
        (*inst) = (_e489 / 3i);
        (*span_1) = vec2<i32>(4i, 1i);
        let _e491 = ix_15;
        let _e499 = ix_15;
        let _e500 = (_e499 / 3i);
        let _e509 = (*span_1);
        (*cell_1) = (vec2<i32>((_e491 - (i32(floor((f32(_e491) / f32(3i)))) * 3i)), (_e500 - (i32(floor((f32(_e500) / f32(1i)))) * 1i))) * _e509);
        return;
    }
    let _e511 = (*id);
    if (_e511 < 220821i) {
        group = 16i;
        cols = 12i;
        rows = 8i;
        let _e513 = (*id);
        ix_16 = (_e513 - 220785i);
        let _e515 = ix_16;
        (*inst) = (_e515 / 6i);
        (*span_1) = vec2<i32>(4i, 4i);
        let _e517 = ix_16;
        let _e525 = ix_16;
        let _e526 = (_e525 / 3i);
        let _e535 = (*span_1);
        (*cell_1) = (vec2<i32>((_e517 - (i32(floor((f32(_e517) / f32(3i)))) * 3i)), (_e526 - (i32(floor((f32(_e526) / f32(2i)))) * 2i))) * _e535);
        return;
    }
    let _e537 = (*id);
    if (_e537 < 238741i) {
        group = 17i;
        cols = 3i;
        rows = 2i;
        let _e539 = (*id);
        ix_17 = (_e539 - 220821i);
        let _e541 = ix_17;
        (*inst) = (_e541 / 1i);
        (*span_1) = vec2<i32>(3i, 2i);
        let _e543 = ix_17;
        let _e551 = ix_17;
        let _e552 = (_e551 / 1i);
        let _e561 = (*span_1);
        (*cell_1) = (vec2<i32>((_e543 - (i32(floor((f32(_e543) / f32(1i)))) * 1i)), (_e552 - (i32(floor((f32(_e552) / f32(1i)))) * 1i))) * _e561);
        return;
    }
    let _e563 = (*id);
    if (_e563 < 270741i) {
        group = 18i;
        cols = 10i;
        rows = 1i;
        let _e565 = (*id);
        ix_18 = (_e565 - 238741i);
        let _e567 = ix_18;
        (*inst) = (_e567 / 1i);
        (*span_1) = vec2<i32>(10i, 1i);
        let _e569 = ix_18;
        let _e577 = ix_18;
        let _e578 = (_e577 / 1i);
        let _e587 = (*span_1);
        (*cell_1) = (vec2<i32>((_e569 - (i32(floor((f32(_e569) / f32(1i)))) * 1i)), (_e578 - (i32(floor((f32(_e578) / f32(1i)))) * 1i))) * _e587);
        return;
    }
    let _e589 = (*id);
    if (_e589 < 270747i) {
        group = 19i;
        cols = 12i;
        rows = 1i;
        let _e591 = (*id);
        ix_19 = (_e591 - 270741i);
        let _e593 = ix_19;
        (*inst) = (_e593 / 6i);
        (*span_1) = vec2<i32>(2i, 1i);
        let _e595 = ix_19;
        let _e603 = ix_19;
        let _e604 = (_e603 / 6i);
        let _e613 = (*span_1);
        (*cell_1) = (vec2<i32>((_e595 - (i32(floor((f32(_e595) / f32(6i)))) * 6i)), (_e604 - (i32(floor((f32(_e604) / f32(1i)))) * 1i))) * _e613);
        return;
    }
    let _e615 = (*id);
    if (_e615 < 274267i) {
        group = 20i;
        cols = 10i;
        rows = 6i;
        let _e617 = (*id);
        ix_20 = (_e617 - 270747i);
        let _e619 = ix_20;
        (*inst) = (_e619 / 4i);
        (*span_1) = vec2<i32>(5i, 3i);
        let _e621 = ix_20;
        let _e629 = ix_20;
        let _e630 = (_e629 / 2i);
        let _e639 = (*span_1);
        (*cell_1) = (vec2<i32>((_e621 - (i32(floor((f32(_e621) / f32(2i)))) * 2i)), (_e630 - (i32(floor((f32(_e630) / f32(2i)))) * 2i))) * _e639);
        return;
    }
    (*inst) = 0i;
    (*cell_1) = vec2<i32>(0i, 0i);
    (*span_1) = vec2<i32>(1i, 1i);
    return;
}

fn boundPatchi1_(idx_2: ptr<function, i32>) -> vec4<f32> {
    var inst_1: i32;
    var cell_2: vec2<i32>;
    var span_2: vec2<i32>;
    var param_184: i32;
    var param_185: i32;
    var param_186: vec2<i32>;
    var param_187: vec2<i32>;
    var lo: vec2<f32>;
    var hi: vec2<f32>;
    var center_1: vec3<f32>;
    var tag_1: f32;
    var param_188: i32;
    var param_189: vec2<f32>;
    var param_190: f32;
    var y_4: i32;
    var x_4: i32;
    var wp: vec3<f32>;
    var param_191: i32;
    var param_192: vec2<f32>;
    var param_193: f32;
    var basis_1: f32;
    var param_194: f32;
    var param_195: i32;
    var a_4: vec2<f32>;
    var param_196: vec3<f32>;
    var param_197: f32;
    var param_198: f32;
    var b_2: vec2<f32>;
    var param_199: vec3<f32>;
    var param_200: f32;
    var param_201: f32;
    var q_1: vec2<f32>;
    var param_202: vec3<f32>;
    var q_2: vec2<f32>;
    var radius: f32;
    var lvl_1: i32;
    var phi_4285_: bool;
    var phi_4293_: bool;
    var phi_4301_: bool;

    let _e59 = (*idx_2);
    if (_e59 >= 274267i) {
        return vec4<f32>(0f, 0f, 0f, 0f);
    }
    let _e61 = (*idx_2);
    param_184 = _e61;
    unpackPatchi1i1vi2vi2_((&param_184), (&param_185), (&param_186), (&param_187));
    let _e62 = param_185;
    inst_1 = _e62;
    let _e63 = param_186;
    cell_2 = _e63;
    let _e64 = param_187;
    span_2 = _e64;
    lo = vec2<f32>(100000000f, 100000000f);
    let _e65 = lo;
    hi = -(_e65);
    let _e67 = cell_2;
    let _e69 = span_2;
    let _e73 = cols;
    let _e75 = rows;
    let _e79 = inst_1;
    param_188 = _e79;
    param_189 = ((vec2<f32>(_e67) + (vec2<f32>(_e69) * 0.5f)) / vec2<f32>(f32(_e73), f32(_e75)));
    let _e80 = surfacei1vf2f1_((&param_188), (&param_189), (&param_190));
    let _e81 = param_190;
    tag_1 = _e81;
    center_1 = _e80;
    y_4 = 0i;
    loop {
        let _e82 = y_4;
        let _e84 = span_2[1u];
        if (_e82 <= _e84) {
            x_4 = 0i;
            loop {
                let _e86 = x_4;
                let _e88 = span_2[0u];
                if (_e86 <= _e88) {
                    let _e90 = cell_2;
                    let _e91 = x_4;
                    let _e92 = y_4;
                    let _e96 = cols;
                    let _e98 = rows;
                    let _e102 = inst_1;
                    param_191 = _e102;
                    param_192 = (vec2<f32>((_e90 + vec2<i32>(_e91, _e92))) / vec2<f32>(f32(_e96), f32(_e98)));
                    let _e103 = surfacei1vf2f1_((&param_191), (&param_192), (&param_193));
                    let _e104 = param_193;
                    tag_1 = _e104;
                    wp = _e103;
                    let _e106 = center_1[2u];
                    param_194 = _e106;
                    let _e107 = depthBandf1_((&param_194));
                    param_195 = _e107;
                    let _e108 = bandDepthi1_((&param_195));
                    basis_1 = _e108;
                    let _e109 = wp;
                    param_196 = _e109;
                    let _e110 = basis_1;
                    param_197 = _e110;
                    param_198 = -1.84f;
                    let _e111 = sweptPointvf3f1f1_((&param_196), (&param_197), (&param_198));
                    a_4 = _e111;
                    let _e112 = wp;
                    param_199 = _e112;
                    let _e113 = basis_1;
                    param_200 = _e113;
                    param_201 = 0.8f;
                    let _e114 = sweptPointvf3f1f1_((&param_199), (&param_200), (&param_201));
                    b_2 = _e114;
                    let _e115 = wp;
                    param_202 = _e115;
                    let _e116 = originalProjectionvf3_((&param_202));
                    q_1 = _e116;
                    let _e117 = lo;
                    let _e118 = q_1;
                    let _e119 = a_4;
                    let _e120 = b_2;
                    lo = min(_e117, min(_e118, min(_e119, _e120)));
                    let _e124 = hi;
                    let _e125 = q_1;
                    let _e126 = a_4;
                    let _e127 = b_2;
                    hi = max(_e124, max(_e125, max(_e126, _e127)));
                    continue;
                } else {
                    break;
                }
                continuing {
                    let _e131 = x_4;
                    x_4 = (_e131 + 1i);
                }
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e133 = y_4;
            y_4 = (_e133 + 1i);
        }
    }
    let _e135 = hi;
    let _e136 = lo;
    q_2 = ((_e135 + _e136) * 0.5f);
    let _e140 = q_2[0u];
    let _e141 = (_e140 < -455f);
    phi_4285_ = _e141;
    if !(_e141) {
        let _e144 = q_2[0u];
        phi_4285_ = (_e144 > 2320f);
    }
    let _e147 = phi_4285_;
    phi_4293_ = _e147;
    if !(_e147) {
        let _e150 = q_2[1u];
        phi_4293_ = (_e150 < -65f);
    }
    let _e153 = phi_4293_;
    phi_4301_ = _e153;
    if !(_e153) {
        let _e156 = q_2[1u];
        phi_4301_ = (_e156 > 1230f);
    }
    let _e159 = phi_4301_;
    if _e159 {
        return vec4<f32>(0f, 0f, 0f, 0f);
    }
    let _e161 = hi[0u];
    let _e163 = lo[0u];
    let _e166 = hi[1u];
    let _e168 = lo[1u];
    radius = (max((_e161 - _e163), (_e166 - _e168)) * 0.5f);
    let _e172 = radius;
    lvl_1 = i32(clamp(ceil(log2(max(1f, ((_e172 + 4f) / 14f)))), 0f, 4f));
    let _e180 = q_2;
    let _e182 = center_1[2u];
    let _e183 = (*idx_2);
    let _e184 = lvl_1;
    return vec4<f32>(_e180.x, _e180.y, _e182, f32((_e183 + (524288i * _e184))));
}

fn sortPatchesvf4i1vi2_(root_2: ptr<function, vec4<f32>>, idx_3: ptr<function, i32>, at_1: ptr<function, vec2<i32>>) {
    var param_203: i32;
    var a_5: vec4<f32>;
    var stepN: i32;
    var stage: i32;
    var k_2: i32;
    var stride: i32;
    var other: i32;
    var b_3: vec4<f32>;
    var param_204: i32;
    var param_205: i32;
    var ka: i32;
    var param_206: vec4<f32>;
    var kb: i32;
    var param_207: vec4<f32>;
    var first: bool;
    var low: bool;
    var phi_4440_: bool;
    var phi_4441_: bool;

    let _e29 = unnamed.iFrame;
    if (_e29 <= 1i) {
        let _e31 = (*idx_3);
        param_203 = _e31;
        let _e32 = boundPatchi1_((&param_203));
        (*root_2) = _e32;
        return;
    }
    let _e33 = (*at_1);
    let _e34 = textureLoad(tex1_, _e33, 0i);
    a_5 = _e34;
    let _e36 = unnamed.iFrame;
    if (_e36 > 191i) {
        let _e38 = a_5;
        (*root_2) = _e38;
        return;
    }
    let _e40 = unnamed.iFrame;
    stepN = (_e40 - 2i);
    stage = 1i;
    k_2 = 1i;
    loop {
        let _e42 = k_2;
        if (_e42 <= 19i) {
            let _e44 = stepN;
            let _e45 = k_2;
            if (_e44 < _e45) {
                let _e47 = k_2;
                stage = _e47;
                break;
            }
            let _e48 = k_2;
            let _e49 = stepN;
            stepN = (_e49 - _e48);
            continue;
        } else {
            break;
        }
        continuing {
            let _e51 = k_2;
            k_2 = (_e51 + 1i);
        }
    }
    let _e53 = stage;
    let _e55 = stepN;
    stride = (1i << bitcast<u32>(((_e53 - 1i) - _e55)));
    let _e59 = (*idx_3);
    let _e60 = stride;
    other = (_e59 ^ _e60);
    let _e64 = unnamed.iResolution[0u];
    let _e66 = other;
    param_204 = _e66;
    param_205 = i32(_e64);
    let _e67 = patchAddressi1i1_((&param_204), (&param_205));
    let _e68 = textureLoad(tex1_, _e67, 0i);
    b_3 = _e68;
    let _e69 = a_5;
    param_206 = _e69;
    let _e70 = patchKeyvf4_((&param_206));
    ka = _e70;
    let _e71 = b_3;
    param_207 = _e71;
    let _e72 = patchKeyvf4_((&param_207));
    kb = _e72;
    let _e73 = ka;
    let _e74 = kb;
    let _e75 = (_e73 < _e74);
    phi_4441_ = _e75;
    if !(_e75) {
        let _e77 = ka;
        let _e78 = kb;
        let _e79 = (_e77 == _e78);
        phi_4440_ = _e79;
        if _e79 {
            let _e81 = a_5[3u];
            let _e83 = b_3[3u];
            phi_4440_ = (_e81 <= _e83);
        }
        let _e86 = phi_4440_;
        phi_4441_ = _e86;
    }
    let _e88 = phi_4441_;
    first = _e88;
    let _e89 = (*idx_3);
    let _e90 = stage;
    let _e95 = (*idx_3);
    let _e96 = stride;
    low = (((_e89 & (1i << bitcast<u32>(_e90))) == 0i) == ((_e95 & _e96) == 0i));
    let _e100 = low;
    let _e101 = first;
    let _e103 = a_5;
    let _e104 = b_3;
    (*root_2) = select(_e104, _e103, vec4((_e100 == _e101)));
    return;
}

fn worldCellvi2_(tile_1: ptr<function, vec2<i32>>) -> i32 {
    let _e5 = (*tile_1)[1u];
    let _e8 = (*tile_1)[0u];
    return ((_e5 * 256i) + _e8);
}

fn worldKeyvf4_(r_5: ptr<function, vec4<f32>>) -> i32 {
    var param_208: vec2<i32>;

    let _e8 = (*r_5)[2u];
    if (_e8 <= 0f) {
        return 999999i;
    }
    let _e10 = (*r_5);
    param_208 = vec2<i32>(floor(((_e10.xz + vec2<f32>(1100f, 40f)) / vec2(10f))));
    let _e17 = worldCellvi2_((&param_208));
    return _e17;
}

fn bufferAddressi1_(i_6: ptr<function, i32>) -> vec2<i32> {
    var width_2: i32;

    let _e6 = unnamed.iResolution[0u];
    width_2 = i32(_e6);
    let _e8 = (*i_6);
    let _e9 = width_2;
    let _e17 = (*i_6);
    let _e18 = width_2;
    return vec2<i32>((_e8 - (i32(floor((f32(_e8) / f32(_e9)))) * _e9)), (_e17 / _e18));
}

fn sortWorldvf4i1vi2_(root_3: ptr<function, vec4<f32>>, idx_4: ptr<function, i32>, at_2: ptr<function, vec2<i32>>) {
    var param_209: i32;
    var a_6: vec4<f32>;
    var stepN_1: i32;
    var stage_1: i32;
    var k_3: i32;
    var stride_1: i32;
    var b_4: vec4<f32>;
    var param_210: i32;
    var ka_1: i32;
    var param_211: vec4<f32>;
    var kb_1: i32;
    var param_212: vec4<f32>;
    var first_1: bool;
    var low_1: bool;
    var phi_4607_: bool;
    var phi_4608_: bool;
    var phi_4609_: bool;
    var phi_4610_: bool;

    let _e28 = unnamed.iFrame;
    if (_e28 <= 1i) {
        let _e30 = (*idx_4);
        param_209 = _e30;
        let _e31 = growi1_((&param_209));
        (*root_3) = _e31;
        return;
    }
    let _e32 = (*at_2);
    let _e33 = textureLoad(tex1_, _e32, 0i);
    a_6 = _e33;
    let _e35 = unnamed.iFrame;
    if (_e35 > 172i) {
        let _e37 = a_6;
        (*root_3) = _e37;
        return;
    }
    let _e39 = unnamed.iFrame;
    stepN_1 = (_e39 - 2i);
    stage_1 = 1i;
    k_3 = 1i;
    loop {
        let _e41 = k_3;
        if (_e41 <= 18i) {
            let _e43 = stepN_1;
            let _e44 = k_3;
            if (_e43 < _e44) {
                let _e46 = k_3;
                stage_1 = _e46;
                break;
            }
            let _e47 = k_3;
            let _e48 = stepN_1;
            stepN_1 = (_e48 - _e47);
            continue;
        } else {
            break;
        }
        continuing {
            let _e50 = k_3;
            k_3 = (_e50 + 1i);
        }
    }
    let _e52 = stage_1;
    let _e54 = stepN_1;
    stride_1 = (1i << bitcast<u32>(((_e52 - 1i) - _e54)));
    let _e58 = (*idx_4);
    let _e59 = stride_1;
    param_210 = (1048576i + (_e58 ^ _e59));
    let _e62 = bufferAddressi1_((&param_210));
    let _e63 = textureLoad(tex1_, _e62, 0i);
    b_4 = _e63;
    let _e64 = a_6;
    param_211 = _e64;
    let _e65 = worldKeyvf4_((&param_211));
    ka_1 = _e65;
    let _e66 = b_4;
    param_212 = _e66;
    let _e67 = worldKeyvf4_((&param_212));
    kb_1 = _e67;
    let _e68 = ka_1;
    let _e69 = kb_1;
    let _e70 = (_e68 < _e69);
    phi_4610_ = _e70;
    if !(_e70) {
        let _e72 = ka_1;
        let _e73 = kb_1;
        let _e74 = (_e72 == _e73);
        phi_4609_ = _e74;
        if _e74 {
            let _e76 = a_6[2u];
            let _e78 = b_4[2u];
            let _e79 = (_e76 < _e78);
            phi_4608_ = _e79;
            if !(_e79) {
                let _e82 = a_6[2u];
                let _e84 = b_4[2u];
                let _e85 = (_e82 == _e84);
                phi_4607_ = _e85;
                if _e85 {
                    let _e87 = a_6[0u];
                    let _e89 = b_4[0u];
                    phi_4607_ = (_e87 <= _e89);
                }
                let _e92 = phi_4607_;
                phi_4608_ = _e92;
            }
            let _e94 = phi_4608_;
            phi_4609_ = _e94;
        }
        let _e96 = phi_4609_;
        phi_4610_ = _e96;
    }
    let _e98 = phi_4610_;
    first_1 = _e98;
    let _e99 = (*idx_4);
    let _e100 = stage_1;
    let _e105 = (*idx_4);
    let _e106 = stride_1;
    low_1 = (((_e99 & (1i << bitcast<u32>(_e100))) == 0i) == ((_e105 & _e106) == 0i));
    let _e110 = low_1;
    let _e111 = first_1;
    let _e113 = a_6;
    let _e114 = b_4;
    (*root_3) = select(_e114, _e113, vec4((_e110 == _e111)));
    return;
}

fn worldBucketi1_(key: ptr<function, i32>) -> i32 {
    var lo_1: i32;
    var hi_1: i32;
    var j_4: i32;
    var mid: i32;
    var param_213: i32;
    var param_214: vec4<f32>;

    lo_1 = 0i;
    hi_1 = 262144i;
    j_4 = 0i;
    loop {
        let _e14 = j_4;
        if (_e14 < 19i) {
            let _e16 = lo_1;
            let _e17 = hi_1;
            if (_e16 >= _e17) {
                break;
            }
            let _e19 = lo_1;
            let _e20 = hi_1;
            mid = ((_e19 + _e20) / 2i);
            let _e23 = mid;
            param_213 = (1048576i + _e23);
            let _e25 = bufferAddressi1_((&param_213));
            let _e26 = textureLoad(tex1_, _e25, 0i);
            param_214 = _e26;
            let _e27 = worldKeyvf4_((&param_214));
            let _e28 = (*key);
            if (_e27 < _e28) {
                let _e30 = mid;
                lo_1 = (_e30 + 1i);
            } else {
                let _e32 = mid;
                hi_1 = _e32;
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e33 = j_4;
            j_4 = (_e33 + 1i);
        }
    }
    let _e35 = lo_1;
    return _e35;
}

fn crownHeightsi1_(index: ptr<function, i32>) -> vec4<f32> {
    var grid: vec2<i32>;
    var spacing: vec2<f32>;
    var center_2: vec2<f32>;
    var lo_2: vec2<i32>;
    var hi_2: vec2<i32>;
    var result: vec4<f32>;
    var y_5: i32;
    var x_5: i32;
    var key_1: i32;
    var param_215: vec2<i32>;
    var start: i32;
    var param_216: i32;
    var j_5: i32;
    var root_4: vec4<f32>;
    var param_217: i32;
    var param_218: vec4<f32>;
    var h_3: f32;
    var param_219: vec4<f32>;
    var diameter: f32;
    var d_6: vec2<f32>;
    var k_4: i32;
    var at_3: vec2<f32>;
    var phi_4705_: bool;
    var phi_4718_: bool;

    let _e48 = (*index);
    let _e56 = (*index);
    grid = (vec2(2i) * vec2<i32>((_e48 - (i32(floor((f32(_e48) / f32(769i)))) * 769i)), (_e56 / 769i)));
    spacing = vec2<f32>(1.4313598f, 1.1711125f);
    let _e61 = grid;
    let _e65 = spacing;
    center_2 = (((vec2<f32>(_e61) + vec2(1f)) * _e65) - vec2<f32>(1100f, 40f));
    let _e69 = center_2[1u];
    let _e70 = (_e69 < 70f);
    phi_4705_ = _e70;
    if !(_e70) {
        let _e73 = center_2[1u];
        phi_4705_ = (_e73 > 1330f);
    }
    let _e76 = phi_4705_;
    phi_4718_ = _e76;
    if !(_e76) {
        let _e79 = center_2[0u];
        let _e82 = center_2[1u];
        phi_4718_ = (abs(_e79) > ((_e82 * 0.73f) + 35f));
    }
    let _e87 = phi_4718_;
    if _e87 {
        return vec4<f32>(0f, 0f, 0f, 0f);
    }
    let _e88 = center_2;
    lo_2 = vec2<i32>(floor((((_e88 + vec2<f32>(1100f, 40f)) - vec2(6f)) / vec2(10f))));
    let _e96 = center_2;
    hi_2 = vec2<i32>(floor((((_e96 + vec2<f32>(1100f, 40f)) + vec2(6f)) / vec2(10f))));
    result = vec4<f32>(0f, 0f, 0f, 0f);
    let _e105 = lo_2[1u];
    y_5 = _e105;
    loop {
        let _e106 = y_5;
        let _e108 = hi_2[1u];
        if (_e106 <= _e108) {
            let _e111 = lo_2[0u];
            x_5 = _e111;
            loop {
                let _e112 = x_5;
                let _e114 = hi_2[0u];
                if (_e112 <= _e114) {
                    let _e116 = x_5;
                    let _e117 = y_5;
                    param_215 = vec2<i32>(_e116, _e117);
                    let _e119 = worldCellvi2_((&param_215));
                    key_1 = _e119;
                    let _e120 = key_1;
                    param_216 = _e120;
                    let _e121 = worldBucketi1_((&param_216));
                    start = _e121;
                    j_5 = 0i;
                    loop {
                        let _e122 = j_5;
                        if (_e122 < 256i) {
                            let _e124 = start;
                            let _e125 = j_5;
                            if ((_e124 + _e125) >= 262144i) {
                                break;
                            }
                            let _e128 = start;
                            let _e130 = j_5;
                            param_217 = ((1048576i + _e128) + _e130);
                            let _e132 = bufferAddressi1_((&param_217));
                            let _e133 = textureLoad(tex1_, _e132, 0i);
                            root_4 = _e133;
                            let _e134 = root_4;
                            param_218 = _e134;
                            let _e135 = worldKeyvf4_((&param_218));
                            let _e136 = key_1;
                            if (_e135 != _e136) {
                                break;
                            }
                            let _e138 = root_4;
                            param_219 = _e138;
                            let _e139 = treeHeightvf4_((&param_219));
                            h_3 = _e139;
                            let _e140 = h_3;
                            diameter = max(1f, (_e140 * 0.24f));
                            let _e143 = center_2;
                            let _e144 = root_4;
                            let _e147 = spacing;
                            d_6 = ((_e143 - _e144.xz) / _e147);
                            k_4 = 0i;
                            loop {
                                let _e149 = k_4;
                                if (_e149 < 4i) {
                                    let _e151 = d_6;
                                    let _e152 = k_4;
                                    let _e161 = k_4;
                                    at_3 = ((_e151 + vec2<f32>(f32((_e152 - (i32(floor((f32(_e152) / f32(2i)))) * 2i))), f32((_e161 / 2i)))) - vec2(0.5f));
                                    let _e168 = k_4;
                                    let _e169 = k_4;
                                    let _e171 = result[_e169];
                                    let _e172 = h_3;
                                    let _e173 = at_3;
                                    let _e176 = diameter;
                                    result[_e168] = max(_e171, (_e172 * (1f - ((2f * length(_e173)) / _e176))));
                                    continue;
                                } else {
                                    break;
                                }
                                continuing {
                                    let _e182 = k_4;
                                    k_4 = (_e182 + 1i);
                                }
                            }
                            continue;
                        } else {
                            break;
                        }
                        continuing {
                            let _e184 = j_5;
                            j_5 = (_e184 + 1i);
                        }
                    }
                    continue;
                } else {
                    break;
                }
                continuing {
                    let _e186 = x_5;
                    x_5 = (_e186 + 1i);
                }
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e188 = y_5;
            y_5 = (_e188 + 1i);
        }
    }
    let _e190 = result;
    return (round((_e190 * 7f)) / vec4(7f));
}

fn treeLowerBoundi1b1_(key_2: ptr<function, i32>, mirrorView_2: ptr<function, bool>) -> i32 {
    var low_2: i32;
    var high: i32;
    var j_6: i32;
    var mid_1: i32;
    var root_5: vec4<f32>;
    var param_220: i32;
    var param_221: bool;
    var param_222: vec4<f32>;
    var param_223: bool;

    low_2 = 0i;
    high = 262144i;
    j_6 = 0i;
    loop {
        let _e17 = j_6;
        let _e19 = low_2;
        let _e20 = high;
        if ((_e17 < 19i) && (_e19 < _e20)) {
            let _e23 = low_2;
            let _e24 = high;
            mid_1 = ((_e23 + _e24) / 2i);
            let _e27 = mid_1;
            param_220 = _e27;
            let _e28 = (*mirrorView_2);
            param_221 = _e28;
            let _e29 = sortAddressi1b1_((&param_220), (&param_221));
            let _e30 = textureLoad(tex1_, _e29, 0i);
            root_5 = _e30;
            let _e31 = root_5;
            param_222 = _e31;
            let _e32 = (*mirrorView_2);
            param_223 = _e32;
            let _e33 = rootKeyvf4b1_((&param_222), (&param_223));
            let _e34 = (*key_2);
            if (_e33 < _e34) {
                let _e36 = mid_1;
                low_2 = (_e36 + 1i);
            } else {
                let _e38 = mid_1;
                high = _e38;
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e39 = j_6;
            j_6 = (_e39 + 1i);
        }
    }
    let _e41 = low_2;
    return _e41;
}

fn mainImagevf4vf2_(root_6: ptr<function, vec4<f32>>, pixel: ptr<function, vec2<f32>>) {
    var at_4: vec2<i32>;
    var linear_1: i32;
    var index_1: i32;
    var plane: i32;
    var key_3: i32;
    var param_224: i32;
    var param_225: bool;
    var param_226: i32;
    var param_227: bool;
    var index_2: i32;
    var local_33: vec4<f32>;
    var param_228: i32;
    var param_229: vec4<f32>;
    var param_230: i32;
    var param_231: vec2<i32>;
    var param_232: vec4<f32>;
    var param_233: i32;
    var param_234: vec2<i32>;
    var mirrored: bool;
    var i_7: i32;
    var param_235: i32;
    var a_7: vec4<f32>;
    var stepN_2: i32;
    var stage_2: i32;
    var k_5: i32;
    var stride_2: i32;
    var other_1: i32;
    var b_5: vec4<f32>;
    var param_236: i32;
    var param_237: bool;
    var ka_2: i32;
    var param_238: vec4<f32>;
    var param_239: bool;
    var kb_2: i32;
    var param_240: vec4<f32>;
    var param_241: bool;
    var first_2: bool;
    var low_3: bool;
    var phi_5017_: bool;
    var phi_5184_: bool;
    var phi_5185_: bool;
    var phi_5186_: bool;
    var phi_5187_: bool;

    let _e66 = (*pixel);
    at_4 = vec2<i32>(_e66);
    let _e69 = at_4[0u];
    let _e71 = at_4[1u];
    let _e74 = unnamed.iResolution[0u];
    linear_1 = (_e69 + (_e71 * i32(_e74)));
    let _e78 = linear_1;
    let _e80 = linear_1;
    if ((_e78 >= 1902081i) && (_e80 < 1926657i)) {
        let _e84 = unnamed.iFrame;
        if (_e84 < 173i) {
            (*root_6) = vec4<f32>(0f, 0f, 0f, 0f);
            return;
        }
        let _e87 = unnamed.iFrame;
        if (_e87 > 173i) {
            let _e89 = at_4;
            let _e90 = textureLoad(tex1_, _e89, 0i);
            (*root_6) = _e90;
            return;
        }
        let _e91 = linear_1;
        index_1 = (_e91 - 1902081i);
        let _e93 = index_1;
        plane = (_e93 / 4096i);
        let _e95 = plane;
        let _e104 = index_1;
        let _e105 = (_e104 / 64i);
        let _e115 = index_1;
        key_3 = ((((_e95 - (i32(floor((f32(_e95) / f32(3i)))) * 3i)) * 65536i) + ((_e105 - (i32(floor((f32(_e105) / f32(64i)))) * 64i)) * 256i)) + (_e115 - (i32(floor((f32(_e115) / f32(64i)))) * 64i)));
        let _e124 = plane;
        let _e126 = key_3;
        param_224 = _e126;
        param_225 = (_e124 >= 3i);
        let _e127 = treeLowerBoundi1b1_((&param_224), (&param_225));
        let _e129 = key_3;
        let _e131 = plane;
        param_226 = (_e129 + 1i);
        param_227 = (_e131 >= 3i);
        let _e133 = treeLowerBoundi1b1_((&param_226), (&param_227));
        (*root_6) = vec4<f32>(f32(_e127), f32(_e133), 0f, 1f);
        return;
    }
    let _e136 = linear_1;
    if (_e136 >= 1310720i) {
        let _e138 = linear_1;
        index_2 = (_e138 - 1310720i);
        let _e140 = index_2;
        let _e141 = (_e140 >= 591361i);
        phi_5017_ = _e141;
        if !(_e141) {
            let _e144 = unnamed.iFrame;
            phi_5017_ = (_e144 < 173i);
        }
        let _e147 = phi_5017_;
        if _e147 {
            (*root_6) = vec4<f32>(0f, 0f, 0f, 0f);
            return;
        }
        let _e149 = unnamed.iFrame;
        if (_e149 == 173i) {
            let _e151 = index_2;
            param_228 = _e151;
            let _e152 = crownHeightsi1_((&param_228));
            local_33 = _e152;
        } else {
            let _e153 = at_4;
            let _e154 = textureLoad(tex1_, _e153, 0i);
            local_33 = _e154;
        }
        let _e155 = local_33;
        (*root_6) = _e155;
        return;
    }
    let _e156 = linear_1;
    if (_e156 >= 1048576i) {
        let _e158 = linear_1;
        param_230 = (_e158 - 1048576i);
        let _e160 = at_4;
        param_231 = _e160;
        sortWorldvf4i1vi2_((&param_229), (&param_230), (&param_231));
        let _e161 = param_229;
        (*root_6) = _e161;
        return;
    }
    let _e162 = linear_1;
    if (_e162 >= 524288i) {
        let _e164 = linear_1;
        param_233 = (_e164 - 524288i);
        let _e166 = at_4;
        param_234 = _e166;
        sortPatchesvf4i1vi2_((&param_232), (&param_233), (&param_234));
        let _e167 = param_232;
        (*root_6) = _e167;
        return;
    }
    let _e168 = linear_1;
    mirrored = (_e168 >= 262144i);
    let _e170 = linear_1;
    i_7 = (_e170 - (i32(floor((f32(_e170) / f32(262144i)))) * 262144i));
    let _e179 = unnamed.iFrame;
    if (_e179 <= 1i) {
        let _e181 = i_7;
        param_235 = _e181;
        let _e182 = growi1_((&param_235));
        (*root_6) = _e182;
        return;
    }
    let _e183 = at_4;
    let _e184 = textureLoad(tex1_, _e183, 0i);
    a_7 = _e184;
    let _e186 = unnamed.iFrame;
    if (_e186 > 172i) {
        let _e188 = a_7;
        (*root_6) = _e188;
        return;
    }
    let _e190 = unnamed.iFrame;
    stepN_2 = (_e190 - 2i);
    stage_2 = 1i;
    k_5 = 1i;
    loop {
        let _e192 = k_5;
        if (_e192 <= 18i) {
            let _e194 = stepN_2;
            let _e195 = k_5;
            if (_e194 < _e195) {
                let _e197 = k_5;
                stage_2 = _e197;
                break;
            }
            let _e198 = k_5;
            let _e199 = stepN_2;
            stepN_2 = (_e199 - _e198);
            continue;
        } else {
            break;
        }
        continuing {
            let _e201 = k_5;
            k_5 = (_e201 + 1i);
        }
    }
    let _e203 = stage_2;
    let _e205 = stepN_2;
    stride_2 = (1i << bitcast<u32>(((_e203 - 1i) - _e205)));
    let _e209 = i_7;
    let _e210 = stride_2;
    other_1 = (_e209 ^ _e210);
    let _e212 = other_1;
    param_236 = _e212;
    let _e213 = mirrored;
    param_237 = _e213;
    let _e214 = sortAddressi1b1_((&param_236), (&param_237));
    let _e215 = textureLoad(tex1_, _e214, 0i);
    b_5 = _e215;
    let _e216 = a_7;
    param_238 = _e216;
    let _e217 = mirrored;
    param_239 = _e217;
    let _e218 = rootKeyvf4b1_((&param_238), (&param_239));
    ka_2 = _e218;
    let _e219 = b_5;
    param_240 = _e219;
    let _e220 = mirrored;
    param_241 = _e220;
    let _e221 = rootKeyvf4b1_((&param_240), (&param_241));
    kb_2 = _e221;
    let _e222 = ka_2;
    let _e223 = kb_2;
    let _e224 = (_e222 < _e223);
    phi_5187_ = _e224;
    if !(_e224) {
        let _e226 = ka_2;
        let _e227 = kb_2;
        let _e228 = (_e226 == _e227);
        phi_5186_ = _e228;
        if _e228 {
            let _e230 = a_7[2u];
            let _e232 = b_5[2u];
            let _e233 = (_e230 < _e232);
            phi_5185_ = _e233;
            if !(_e233) {
                let _e236 = a_7[2u];
                let _e238 = b_5[2u];
                let _e239 = (_e236 == _e238);
                phi_5184_ = _e239;
                if _e239 {
                    let _e241 = a_7[0u];
                    let _e243 = b_5[0u];
                    phi_5184_ = (_e241 <= _e243);
                }
                let _e246 = phi_5184_;
                phi_5185_ = _e246;
            }
            let _e248 = phi_5185_;
            phi_5186_ = _e248;
        }
        let _e250 = phi_5186_;
        phi_5187_ = _e250;
    }
    let _e252 = phi_5187_;
    first_2 = _e252;
    let _e253 = i_7;
    let _e254 = stage_2;
    let _e259 = i_7;
    let _e260 = stride_2;
    low_3 = (((_e253 & (1i << bitcast<u32>(_e254))) == 0i) == ((_e259 & _e260) == 0i));
    let _e264 = low_3;
    let _e265 = first_2;
    let _e267 = a_7;
    let _e268 = b_5;
    (*root_6) = select(_e268, _e267, vec4((_e264 == _e265)));
    return;
}

fn main_1() {
    var param_242: vec4<f32>;
    var param_243: vec2<f32>;

    let _e4 = gl_FragCoord_1;
    param_243 = _e4.xy;
    mainImagevf4vf2_((&param_242), (&param_243));
    let _e6 = param_242;
    col = _e6;
    return;
}

@fragment
fn main(@builtin(position) gl_FragCoord: vec4<f32>) -> @location(0) vec4<f32> {
    gl_FragCoord_1 = gl_FragCoord;
    main_1();
    let _e3 = col;
    return _e3;
}
