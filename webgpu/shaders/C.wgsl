diagnostic(off, derivative_uniformity);
struct TreeView {
    rings: i32,
    arms: i32,
    shoots: i32,
    variant: i32,
    rotation: f32,
    orange: f32,
    aspect: f32,
    tilt: f32,
}

struct SampleVertex {
    pos: vec3<f32>,
    normal: vec3<f32>,
    exposure: f32,
    sunSide: f32,
    local: vec3<f32>,
}

struct CrownHit {
    depth: f32,
    normal: vec3<f32>,
    exposure: f32,
    sunSide: f32,
    local: vec3<f32>,
}

struct ForestHit {
    z: f32,
    color: vec3<f32>,
}

struct Params {
    iResolution: vec3<f32>,
    iTime: f32,
    channelSizes: array<vec4<f32>, 4>,
    iFrame: i32,
}

@group(0) @binding(3)
var tex2_: texture_2d<f32>;
@group(0) @binding(7)
var samp2_: sampler;
var<private> treeBend: f32;
var<private> rayShear: vec2<f32>;
@group(0) @binding(0)
var<uniform> unnamed: Params;
var<private> phase: f32;
var<private> object: i32;
var<private> datum: vec2<f32>;
var<private> unit: f32;
var<private> strike: vec2<f32>;
var<private> position: vec3<f32>;
var<private> origin_2: vec3<f32>;
var<private> dims: vec3<f32>;
var<private> truck_2: f32;
@group(0) @binding(2)
var tex1_: texture_2d<f32>;
@group(0) @binding(6)
var samp1_: sampler;
var<private> softFirstRow: bool;
var<private> group: i32;
var<private> cols_1: i32;
var<private> rows_1: i32;
@group(0) @binding(1)
var tex0_: texture_2d<f32>;
@group(0) @binding(5)
var samp0_: sampler;
var<private> col_2: vec4<f32>;
var<private> gl_FragCoord_1: vec4<f32>;
@group(0) @binding(4)
var tex3_: texture_2d<f32>;
@group(0) @binding(8)
var samp3_: sampler;

fn cross2vf2vf2_(a: ptr<function, vec2<f32>>, b: ptr<function, vec2<f32>>) -> f32 {
    let _e5 = (*a)[0u];
    let _e7 = (*b)[1u];
    let _e10 = (*a)[1u];
    let _e12 = (*b)[0u];
    return ((_e5 * _e7) - (_e10 * _e12));
}

fn shadowTrianglevf2vf3vf3vf3f1_(pos: ptr<function, vec2<f32>>, a_1: ptr<function, vec3<f32>>, b_1: ptr<function, vec3<f32>>, c: ptr<function, vec3<f32>>, z: ptr<function, f32>) {
    var ab: vec2<f32>;
    var ac: vec2<f32>;
    var q: vec2<f32>;
    var det: f32;
    var param: vec2<f32>;
    var param_1: vec2<f32>;
    var u: f32;
    var param_2: vec2<f32>;
    var param_3: vec2<f32>;
    var v: f32;
    var param_4: vec2<f32>;
    var param_5: vec2<f32>;
    var h: f32;

    let _e22 = (*b_1);
    let _e24 = (*a_1);
    ab = (_e22.xy - _e24.xy);
    let _e27 = (*c);
    let _e29 = (*a_1);
    ac = (_e27.xy - _e29.xy);
    let _e32 = (*pos);
    let _e33 = (*a_1);
    q = (_e32 - _e33.xy);
    let _e36 = ab;
    param = _e36;
    let _e37 = ac;
    param_1 = _e37;
    let _e38 = cross2vf2vf2_((&param), (&param_1));
    det = _e38;
    let _e39 = det;
    if (abs(_e39) < 0.000001f) {
        return;
    }
    let _e42 = q;
    param_2 = _e42;
    let _e43 = ac;
    param_3 = _e43;
    let _e44 = cross2vf2vf2_((&param_2), (&param_3));
    let _e45 = det;
    u = (_e44 / _e45);
    let _e47 = ab;
    param_4 = _e47;
    let _e48 = q;
    param_5 = _e48;
    let _e49 = cross2vf2vf2_((&param_4), (&param_5));
    let _e50 = det;
    v = (_e49 / _e50);
    let _e52 = u;
    let _e53 = v;
    let _e55 = u;
    let _e57 = v;
    if (min(min(_e52, _e53), ((1f - _e55) - _e57)) < 0f) {
        return;
    }
    let _e62 = (*a_1)[2u];
    let _e63 = u;
    let _e65 = (*b_1)[2u];
    let _e67 = (*a_1)[2u];
    let _e71 = v;
    let _e73 = (*c)[2u];
    let _e75 = (*a_1)[2u];
    h = ((_e62 + (_e63 * (_e65 - _e67))) + (_e71 * (_e73 - _e75)));
    let _e79 = h;
    if (_e79 >= 0f) {
        let _e81 = (*z);
        let _e82 = h;
        (*z) = min(_e81, _e82);
    }
    return;
}

fn lightProjectvf3_(p: ptr<function, vec3<f32>>) -> vec3<f32> {
    var l: vec3<f32>;
    var r: vec3<f32>;
    var u_1: vec3<f32>;
    var d: vec3<f32>;

    l = vec3<f32>(-0.29431123f, 0.08785751f, 0.9516627f);
    let _e12 = l;
    r = normalize(cross(_e12, vec3<f32>(0f, 1f, 0f)));
    let _e15 = r;
    let _e16 = l;
    u_1 = cross(_e15, _e16);
    let _e18 = (*p);
    d = (_e18 - vec3<f32>(-6f, 63.8f, 17f));
    let _e20 = d;
    let _e21 = r;
    let _e23 = d;
    let _e24 = u_1;
    let _e31 = (vec2(512f) + ((vec2<f32>(dot(_e20, _e21), dot(_e23, _e24)) * 512f) / vec2(11f)));
    let _e32 = d;
    let _e33 = l;
    return vec3<f32>(_e31.x, _e31.y, (0.5f - ((0.5f * dot(_e32, _e33)) / 27f)));
}

fn placevf2f1_(p_1: ptr<function, vec2<f32>>, z_1: ptr<function, f32>) -> vec3<f32> {
    let _e9 = (*p_1)[0u];
    let _e11 = (*z_1);
    let _e15 = (*p_1)[1u];
    let _e17 = (*z_1);
    let _e21 = (*z_1);
    return vec3<f32>((((_e9 - 960f) * _e11) / 1404f), (70f + (((464.4f - _e15) * _e17) / 1404f)), _e21);
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

fn valueNoise2vf2_(p_2: ptr<function, vec2<f32>>) -> f32 {
    var i: vec2<i32>;
    var f: vec2<f32>;
    var param_6: i32;
    var param_7: i32;
    var param_8: i32;
    var param_9: i32;
    var param_10: i32;
    var param_11: i32;
    var param_12: i32;
    var param_13: i32;

    let _e16 = (*p_2);
    i = vec2<i32>(floor(_e16));
    let _e19 = (*p_2);
    f = fract(_e19);
    let _e21 = f;
    let _e22 = f;
    let _e24 = f;
    f = ((_e21 * _e22) * (vec2(3f) - (_e24 * 2f)));
    let _e30 = i[0u];
    param_6 = _e30;
    let _e32 = i[1u];
    param_7 = _e32;
    let _e33 = rndi1i1_((&param_6), (&param_7));
    let _e35 = i[0u];
    param_8 = (_e35 + 1i);
    let _e38 = i[1u];
    param_9 = _e38;
    let _e39 = rndi1i1_((&param_8), (&param_9));
    let _e41 = f[0u];
    let _e44 = i[1u];
    let _e47 = i[0u];
    param_10 = _e47;
    param_11 = (_e44 + 1i);
    let _e48 = rndi1i1_((&param_10), (&param_11));
    let _e50 = i[0u];
    let _e53 = i[1u];
    param_12 = (_e50 + 1i);
    param_13 = (_e53 + 1i);
    let _e55 = rndi1i1_((&param_12), (&param_13));
    let _e57 = f[0u];
    let _e60 = f[1u];
    return mix(mix(_e33, _e39, _e41), mix(_e48, _e55, _e57), _e60);
}

fn floorAtvf2_(p_3: ptr<function, vec2<f32>>) -> f32 {
    return 0f;
}

fn surfacei1vf2f1_(i_1: ptr<function, i32>, uv: ptr<function, vec2<f32>>, tag: ptr<function, f32>) -> vec3<f32> {
    var u_2: f32;
    var v_1: f32;
    var a_2: f32;
    var z_2: f32;
    var param_14: i32;
    var param_15: i32;
    var east: bool;
    var l_1: f32;
    var r_1: f32;
    var j: i32;
    var m: f32;
    var dry: bool;
    var param_16: vec2<f32>;
    var x_1: f32;
    var param_17: i32;
    var param_18: i32;
    var y: f32;
    var param_19: vec2<f32>;
    var size: f32;
    var param_20: i32;
    var param_21: i32;
    var d_1: vec3<f32>;
    var param_22: vec2<f32>;
    var tuft: i32;
    var param_23: i32;
    var param_24: i32;
    var param_25: i32;
    var param_26: i32;
    var param_27: i32;
    var param_28: i32;
    var b_2: vec4<f32>;
    var indexable: array<vec4<f32>, 20>;
    var z_3: f32;
    var indexable_1: array<f32, 20>;
    var dir: vec3<f32>;
    var moss: bool;
    var shape: vec3<f32>;
    var n: f32;
    var param_29: vec2<f32>;
    var param_30: vec2<f32>;
    var local: f32;
    var center: vec3<f32>;
    var param_31: vec2<f32>;
    var param_32: f32;
    var n_1: vec3<f32>;
    var side: vec3<f32>;
    var up: vec3<f32>;
    var angle: f32;
    var param_33: i32;
    var param_34: i32;
    var polar: f32;
    var petals: f32;
    var param_35: i32;
    var param_36: i32;
    var tier: i32;
    var arm: i32;
    var fan: i32;
    var j_1: i32;
    var seed_1: i32;
    var f_1: f32;
    var az: f32;
    var param_37: i32;
    var param_38: i32;
    var d_2: vec3<f32>;
    var side_1: vec3<f32>;
    var origin: vec3<f32>;
    var param_39: vec2<f32>;
    var param_40: f32;
    var param_41: vec2<f32>;
    var param_42: f32;
    var len: f32;
    var param_43: i32;
    var param_44: i32;
    var t: f32;
    var anchor: vec3<f32>;
    var twigLen: f32;
    var param_45: i32;
    var param_46: i32;
    var twig: vec3<f32>;
    var along: f32;
    var q_1: vec3<f32>;
    var span: f32;
    var dir_1: vec3<f32>;
    var ridge: vec3<f32>;
    var param_47: vec2<f32>;
    var param_48: f32;
    var x_2: f32;
    var y_1: f32;
    var param_49: vec2<f32>;
    var param_50: vec2<f32>;
    var param_51: f32;
    var y_2: f32;
    var z_4: f32;
    var base: f32;
    var local_1: f32;
    var r_2: f32;
    var local_2: f32;
    var param_52: vec2<f32>;
    var param_53: vec2<f32>;
    var param_54: f32;
    var limb: i32;
    var local_3: i32;
    var local_4: i32;
    var lat: i32;
    var local_5: i32;
    var shoot: i32;
    var j_2: i32;
    var z_5: f32;
    var indexable_2: array<f32, 14>;
    var b_3: vec4<f32>;
    var indexable_3: array<vec4<f32>, 14>;
    var p0_: vec3<f32>;
    var param_55: vec2<f32>;
    var param_56: f32;
    var p1_: vec3<f32>;
    var param_57: vec2<f32>;
    var param_58: f32;
    var d_3: vec3<f32>;
    var seed_2: i32;
    var t_1: f32;
    var local_6: f32;
    var param_59: i32;
    var param_60: i32;
    var root: vec3<f32>;
    var side_2: f32;
    var width: f32;
    var indexable_4: array<f32, 14>;
    var param_61: i32;
    var param_62: i32;
    var branch: vec3<f32>;
    var param_63: i32;
    var param_64: i32;
    var local_7: f32;
    var param_65: i32;
    var param_66: i32;
    var param_67: i32;
    var param_68: i32;
    var axis: vec3<f32>;
    var s: vec3<f32>;
    var f_2: f32;
    var param_69: i32;
    var param_70: i32;
    var angle_1: f32;
    var param_71: i32;
    var param_72: i32;
    var outDir: vec3<f32>;
    var scale: f32;
    var spr: vec3<f32>;
    var param_73: i32;
    var param_74: i32;
    var az_1: vec3<f32>;
    var tangent: vec3<f32>;
    var g: f32;
    var param_75: i32;
    var param_76: i32;
    var phi: f32;
    var param_77: i32;
    var param_78: i32;
    var rad: vec3<f32>;
    var tip: vec3<f32>;
    var param_79: i32;
    var param_80: i32;
    var close: bool;
    var spine: bool;
    var fr: i32;
    var local_8: i32;
    var leaf: i32;
    var cluster: i32;
    var local_9: i32;
    var arm_1: i32;
    var o: vec2<f32>;
    var indexable_5: array<vec2<f32>, 4>;
    var angle_2: f32;
    var param_81: i32;
    var param_82: i32;
    var extent: vec2<f32>;
    var local_10: f32;
    var param_83: i32;
    var param_84: i32;
    var t_2: f32;
    var local_11: f32;
    var p_4: vec2<f32>;
    var side_3: f32;
    var d_4: vec2<f32>;
    var w: f32;
    var local_12: f32;
    var param_85: i32;
    var param_86: i32;
    var dir_2: vec2<f32>;
    var param_87: vec2<f32>;
    var param_88: f32;
    var stem: bool;
    var flower: i32;
    var local_13: i32;
    var o_1: vec2<f32>;
    var p_5: vec2<f32>;
    var theta: f32;
    var theta_1: f32;
    var param_89: vec2<f32>;
    var param_90: f32;
    var cl: i32;
    var o_2: vec2<f32>;
    var local_14: vec2<f32>;
    var param_91: i32;
    var param_92: i32;
    var param_93: i32;
    var param_94: i32;
    var phi_1: f32;
    var param_95: i32;
    var param_96: i32;
    var dir_3: vec2<f32>;
    var w_1: f32;
    var p_6: vec2<f32>;
    var param_97: vec2<f32>;
    var param_98: f32;
    var o_3: vec2<f32>;
    var p_7: vec2<f32>;
    var param_99: vec2<f32>;
    var param_100: f32;
    var cl_1: i32;
    var o_4: vec2<f32>;
    var local_15: vec2<f32>;
    var a_3: f32;
    var param_101: i32;
    var param_102: i32;
    var len_1: f32;
    var param_103: i32;
    var param_104: i32;
    var p_8: vec2<f32>;
    var param_105: vec2<f32>;
    var param_106: f32;
    var o_5: vec2<f32>;
    var d_5: vec2<f32>;
    var t_3: f32;
    var local_16: f32;
    var local_17: i32;
    var p_9: vec2<f32>;
    var f_3: f32;
    var param_107: vec2<f32>;
    var param_108: f32;

    let _e489 = (*uv)[0u];
    u_2 = _e489;
    let _e491 = (*uv)[1u];
    v_1 = _e491;
    let _e492 = u_2;
    a_2 = (6.2831855f * _e492);
    let _e494 = group;
    if (_e494 == 20i) {
        let _e496 = (*i_1);
        param_14 = (_e496 / 2i);
        param_15 = 16i;
        let _e498 = rndi1i1_((&param_14), (&param_15));
        z_2 = mix(181f, 434f, _e498);
        let _e500 = (*i_1);
        east = ((_e500 - (i32(floor((f32(_e500) / f32(2i)))) * 2i)) == 0i);
        let _e509 = east;
        l_1 = select(-55f, 65f, _e509);
        let _e511 = east;
        r_1 = select(75f, 265f, _e511);
        j = 0i;
        loop {
            let _e513 = j;
            if (_e513 < 12i) {
                let _e515 = l_1;
                let _e516 = r_1;
                m = ((_e515 + _e516) * 0.5f);
                let _e519 = m;
                let _e520 = z_2;
                param_16 = vec2<f32>(_e519, _e520);
                let _e522 = floorAtvf2_((&param_16));
                dry = (_e522 > 0f);
                let _e524 = dry;
                let _e525 = east;
                if (_e524 == _e525) {
                    let _e527 = m;
                    r_1 = _e527;
                } else {
                    let _e528 = m;
                    l_1 = _e528;
                }
                continue;
            } else {
                break;
            }
            continuing {
                let _e529 = j;
                j = (_e529 + 1i);
            }
        }
        let _e531 = l_1;
        let _e532 = r_1;
        let _e535 = (*i_1);
        param_17 = _e535;
        param_18 = 18i;
        let _e536 = rndi1i1_((&param_17), (&param_18));
        x_1 = ((0.5f * (_e531 + _e532)) + mix(-2f, 2f, _e536));
        let _e539 = x_1;
        let _e540 = z_2;
        param_19 = vec2<f32>(_e539, _e540);
        let _e542 = floorAtvf2_((&param_19));
        y = _e542;
        let _e543 = (*i_1);
        param_20 = _e543;
        param_21 = 17i;
        let _e544 = rndi1i1_((&param_20), (&param_21));
        size = mix(0.4f, 1.36f, _e544);
        let _e546 = y;
        if (abs(_e546) > 6f) {
            size = 0f;
        }
        let _e549 = a_2;
        let _e551 = v_1;
        let _e555 = v_1;
        let _e558 = a_2;
        let _e560 = v_1;
        d_1 = vec3<f32>((cos(_e549) * sin((3.1415927f * _e551))), cos((3.1415927f * _e555)), (sin(_e558) * sin((3.1415927f * _e560))));
        let _e565 = d_1;
        let _e567 = d_1;
        d_1 = (sign(_e565) * pow(abs(_e567), vec3<f32>(0.77f, 0.77f, 0.77f)));
        (*tag) = -8f;
        let _e571 = x_1;
        let _e572 = y;
        let _e574 = z_2;
        let _e576 = d_1;
        let _e577 = size;
        let _e580 = d_1;
        let _e583 = (*i_1);
        param_22 = ((_e580.xy * 4f) + vec2(f32(_e583)));
        let _e587 = valueNoise2vf2_((&param_22));
        return (vec3<f32>(_e571, (_e572 - 0.19f), _e574) + (((_e576 * _e577) * vec3<f32>(1.6f, 0.6f, 0.94f)) * (1f + (0.11f * _e587))));
    }
    let _e592 = group;
    let _e594 = group;
    if ((_e592 == 0i) || (_e594 == 18i)) {
        let _e597 = (*i_1);
        tuft = _e597;
        let _e598 = group;
        if (_e598 == 18i) {
            let _e600 = tuft;
            param_23 = _e600;
            param_24 = 1i;
            let _e601 = rndi1i1_((&param_23), (&param_24));
            (*i_1) = (5i + i32((_e601 * 15f)));
            let _e605 = tuft;
            param_25 = _e605;
            param_26 = 2i;
            let _e606 = rndi1i1_((&param_25), (&param_26));
            u_2 = _e606;
            let _e607 = u_2;
            a_2 = (6.2831855f * _e607);
            let _e609 = tuft;
            param_27 = _e609;
            param_28 = 3i;
            let _e610 = rndi1i1_((&param_27), (&param_28));
            v_1 = (acos(mix(-0.2f, 1f, _e610)) / 3.1415927f);
        }
        let _e614 = (*i_1);
        indexable = array<vec4<f32>, 20>(vec4<f32>(167f, 995f, 128f, 72f), vec4<f32>(523f, 959f, 125f, 86f), vec4<f32>(742f, 1103f, 92f, 83f), vec4<f32>(1055f, 1115f, 211f, 73f), vec4<f32>(388f, 1010f, 158f, 68f), vec4<f32>(362f, 978f, 124f, 73f), vec4<f32>(434f, 960f, 68f, 63f), vec4<f32>(642f, 1030f, 111f, 49f), vec4<f32>(749f, 1061f, 112f, 49f), vec4<f32>(139f, 867f, 82f, 54f), vec4<f32>(56f, 881f, 99f, 64f), vec4<f32>(120f, 928f, 61f, 46f), vec4<f32>(855f, 1092f, 88f, 41f), vec4<f32>(24f, 993f, 80f, 39f), vec4<f32>(125f, 1098f, 105f, 53f), vec4<f32>(288f, 1096f, 113f, 39f), vec4<f32>(503f, 1084f, 78f, 41f), vec4<f32>(243f, 1022f, 42f, 24f), vec4<f32>(448f, 1025f, 37f, 19f), vec4<f32>(550f, 1054f, 59f, 25f));
        let _e616 = indexable[_e614];
        b_2 = _e616;
        let _e617 = (*i_1);
        indexable_1 = array<f32, 20>(15.7f, 16.1f, 13.1f, 14.1f, 15f, 14.2f, 14.7f, 14.6f, 14.4f, 17.1f, 17f, 16.8f, 14f, 13.8f, 12.7f, 13.2f, 13.6f, 13.8f, 13.9f, 14.4f);
        let _e619 = indexable_1[_e617];
        z_3 = _e619;
        let _e620 = a_2;
        let _e622 = v_1;
        let _e626 = v_1;
        let _e629 = a_2;
        let _e631 = v_1;
        dir = vec3<f32>((cos(_e620) * sin((3.1415927f * _e622))), cos((3.1415927f * _e626)), (sin(_e629) * sin((3.1415927f * _e631))));
        let _e636 = (*i_1);
        moss = (_e636 >= 5i);
        let _e638 = dir;
        let _e640 = dir;
        let _e642 = moss;
        shape = (sign(_e638) * pow(abs(_e640), vec3(select(0.67f, 1f, _e642))));
        let _e647 = dir;
        let _e651 = dir[2u];
        let _e655 = (*i_1);
        param_29 = (((_e647.xy * 4f) + vec2((_e651 * 3f))) + vec2(f32(_e655)));
        let _e659 = valueNoise2vf2_((&param_29));
        n = _e659;
        let _e660 = moss;
        let _e662 = n;
        let _e665 = moss;
        let _e667 = dir;
        let _e671 = dir[2u];
        param_30 = ((_e667.xy * 22f) + vec2((_e671 * 13f)));
        let _e675 = valueNoise2vf2_((&param_30));
        let _e678 = shape;
        shape = (_e678 * ((0.97f + (select(0.09f, 0.035f, _e660) * _e662)) + (select(0.012f, 0.007f, _e665) * _e675)));
        let _e680 = moss;
        if _e680 {
            local = 0f;
        } else {
            let _e682 = shape[0u];
            let _e685 = shape[2u];
            local = ((0.2f * _e682) + (0.12f * _e685));
        }
        let _e688 = local;
        let _e690 = shape[1u];
        shape[1u] = (_e690 - _e688);
        let _e693 = b_2;
        param_31 = _e693.xy;
        let _e695 = z_3;
        param_32 = _e695;
        let _e696 = placevf2f1_((&param_31), (&param_32));
        let _e697 = shape;
        let _e699 = b_2[2u];
        let _e701 = b_2[3u];
        let _e703 = b_2[2u];
        let _e707 = z_3;
        center = (_e696 + (((_e697 * vec3<f32>(_e699, _e701, (_e703 * 0.67f))) * _e707) / vec3(1404f)));
        let _e712 = moss;
        (*tag) = select(11f, 12f, _e712);
        let _e714 = group;
        if (_e714 == 18i) {
            let _e716 = dir;
            let _e718 = b_2[2u];
            let _e720 = b_2[3u];
            let _e722 = b_2[2u];
            n_1 = normalize((_e716 / vec3<f32>(_e718, _e720, (_e722 * 0.67f))));
            let _e727 = n_1;
            side = normalize(cross(_e727, vec3<f32>(0.01f, 0.97f, 0.18f)));
            let _e730 = n_1;
            let _e731 = side;
            up = cross(_e730, _e731);
            let _e733 = tuft;
            param_33 = _e733;
            param_34 = 4i;
            let _e734 = rndi1i1_((&param_33), (&param_34));
            angle = (_e734 * 6.283f);
            let _e736 = angle;
            let _e738 = (*uv)[0u];
            polar = (_e736 + (_e738 * 6.283f));
            let _e741 = polar;
            let _e742 = angle;
            petals = ((cos((5f * (_e741 - _e742))) * 0.26f) + 0.72f);
            let _e748 = z_3;
            let _e750 = tuft;
            param_35 = _e750;
            param_36 = 5i;
            let _e751 = rndi1i1_((&param_35), (&param_36));
            let _e754 = n_1;
            let _e756 = (*uv)[1u];
            let _e761 = (*uv)[1u];
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
        let _e781 = (*i_1);
        tier = (_e781 / 2240i);
        let _e783 = (*i_1);
        let _e784 = (_e783 / 320i);
        arm = (_e784 - (i32(floor((f32(_e784) / f32(7i)))) * 7i));
        let _e792 = (*i_1);
        let _e793 = (_e792 / 16i);
        fan = (_e793 - (i32(floor((f32(_e793) / f32(20i)))) * 20i));
        let _e801 = (*i_1);
        j_1 = (_e801 - (i32(floor((f32(_e801) / f32(16i)))) * 16i));
        let _e809 = tier;
        let _e811 = arm;
        seed_1 = ((_e809 * 103i) + (_e811 * 37i));
        let _e814 = tier;
        f_1 = ((f32(_e814) + 0.3f) / 8f);
        let _e818 = tier;
        let _e821 = arm;
        let _e825 = seed_1;
        param_37 = _e825;
        param_38 = 5i;
        let _e826 = rndi1i1_((&param_37), (&param_38));
        az = (((f32(_e818) * 2.4f) + (f32(_e821) * 0.898f)) + (0.36f * (_e826 - 0.5f)));
        let _e830 = az;
        let _e832 = az;
        d_2 = vec3<f32>(cos(_e830), 0f, sin(_e832));
        let _e836 = d_2[2u];
        let _e839 = d_2[0u];
        side_1 = vec3<f32>(-(_e836), 0f, _e839);
        param_39 = vec2<f32>(518f, 660f);
        param_40 = 83f;
        let _e841 = placevf2f1_((&param_39), (&param_40));
        param_41 = vec2<f32>(516f, 929f);
        param_42 = 83f;
        let _e842 = placevf2f1_((&param_41), (&param_42));
        let _e843 = f_1;
        origin = mix(_e841, _e842, vec3(_e843));
        let _e846 = f_1;
        let _e850 = seed_1;
        param_43 = _e850;
        param_44 = 7i;
        let _e851 = rndi1i1_((&param_43), (&param_44));
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
        param_45 = _e892;
        let _e893 = fan;
        param_46 = _e893;
        let _e894 = rndi1i1_((&param_45), (&param_46));
        twigLen = ((_e884 * (1f - (f32(((_e885 / 2i) + 1i)) / 15f))) * mix(0.47f, 0.72f, _e894));
        let _e897 = d_2;
        let _e899 = side_1;
        let _e900 = fan;
        twig = (((_e897 * 0.45f) + (_e899 * select(-0.72f, 0.72f, ((_e900 - (i32(floor((f32(_e900) / f32(2i)))) * 2i)) == 0i)))) + vec3<f32>(0f, -0.62f, 0f));
        let _e913 = j_1;
        along = (f32((_e913 / 2i)) / 8f);
        let _e917 = anchor;
        let _e918 = twig;
        let _e919 = twigLen;
        let _e921 = along;
        q_1 = (_e917 + ((_e918 * _e919) * _e921));
        let _e924 = twigLen;
        let _e925 = along;
        span = (_e924 * (0.38f - (0.22f * _e925)));
        let _e929 = twig;
        let _e931 = d_2;
        let _e934 = side_1;
        let _e935 = j_1;
        dir_1 = ((((_e929 * 0.5f) + (_e931 * 0.33f)) + (_e934 * select(0.49f, -0.49f, ((_e935 - (i32(floor((f32(_e935) / f32(2i)))) * 2i)) == 0i)))) + vec3<f32>(0f, -0.18f, 0f));
        let _e948 = dir_1;
        ridge = normalize(cross(_e948, vec3<f32>(0f, 1f, 0f)));
        (*tag) = 22.125f;
        let _e951 = q_1;
        let _e952 = span;
        let _e953 = dir_1;
        let _e954 = u_2;
        let _e956 = ridge;
        let _e957 = v_1;
        let _e961 = u_2;
        let _e966 = u_2;
        return (_e951 + ((((_e953 * _e954) + (((_e956 * (_e957 - 0.5f)) * 0.28f) * sin((3.1415927f * _e961)))) + vec3<f32>(0f, (0.03f * sin((3.1415927f * _e966))), 0f)) * _e952));
    }
    let _e974 = group;
    if (_e974 == 19i) {
        (*tag) = 21f;
        let _e976 = u_2;
        param_47 = mix(vec2<f32>(516f, 928f), vec2<f32>(518f, 660f), vec2(_e976));
        param_48 = 83f;
        let _e979 = placevf2f1_((&param_47), (&param_48));
        let _e980 = v_1;
        let _e983 = u_2;
        return (_e979 + vec3<f32>((((_e980 - 0.5f) * 0.29f) * (1f - _e983)), 0f, 0f));
    }
    let _e988 = group;
    if (_e988 == 1i) {
        let _e990 = u_2;
        x_2 = mix(-300f, 1450f, _e990);
        let _e992 = x_2;
        let _e997 = x_2;
        let _e1002 = x_2;
        param_49 = vec2<f32>((_e1002 * 0.025f), 1f);
        let _e1005 = valueNoise2vf2_((&param_49));
        let _e1008 = v_1;
        y_1 = ((((828f + (0.19f * max((_e992 - 130f), 0f))) + (0.23f * max((_e997 - 400f), 0f))) + (7f * _e1005)) + (380f * _e1008));
        (*tag) = 10f;
        let _e1011 = x_2;
        let _e1012 = y_1;
        let _e1014 = v_1;
        param_50 = vec2<f32>(_e1011, _e1012);
        param_51 = mix(19.1f, 10.6f, _e1014);
        let _e1016 = placevf2f1_((&param_50), (&param_51));
        return _e1016;
    }
    let _e1017 = group;
    if (_e1017 == 2i) {
        let _e1019 = v_1;
        y_2 = mix(-190f, 915f, _e1019);
        let _e1021 = (*i_1);
        z_4 = select(34f, 18.6f, (_e1021 == 0i));
        let _e1024 = (*i_1);
        if (_e1024 == 0i) {
            let _e1026 = y_2;
            local_1 = (15f + (0.014f * (480f - _e1026)));
        } else {
            let _e1030 = y_2;
            let _e1034 = y_2;
            local_1 = ((131f + ((800f - _e1030) * 0.058f)) + (5f * sin((_e1034 * 0.011f))));
        }
        let _e1039 = local_1;
        base = _e1039;
        let _e1040 = (*i_1);
        if (_e1040 == 0i) {
            let _e1042 = v_1;
            let _e1045 = v_1;
            local_2 = ((70f + (33f * _e1042)) + (58f * pow(_e1045, 12f)));
        } else {
            let _e1049 = v_1;
            local_2 = (17f + (5f * _e1049));
        }
        let _e1052 = local_2;
        let _e1053 = a_2;
        let _e1055 = v_1;
        let _e1061 = a_2;
        let _e1064 = v_1;
        let _e1066 = a_2;
        param_52 = vec2<f32>((9f * cos(_e1061)), ((4f * _e1064) + (6f * sin(_e1066))));
        let _e1071 = valueNoise2vf2_((&param_52));
        r_2 = (_e1052 * ((0.96f + (0.035f * sin(((_e1053 * 11f) + (3f * _e1055))))) + (0.05f * _e1071)));
        (*tag) = 19f;
        let _e1075 = base;
        let _e1076 = y_2;
        param_53 = vec2<f32>(_e1075, _e1076);
        let _e1078 = z_4;
        param_54 = _e1078;
        let _e1079 = placevf2f1_((&param_53), (&param_54));
        let _e1080 = a_2;
        let _e1082 = r_2;
        let _e1084 = a_2;
        let _e1086 = r_2;
        let _e1089 = z_4;
        return (_e1079 + ((vec3<f32>((cos(_e1080) * _e1082), 0f, (sin(_e1084) * _e1086)) * _e1089) / vec3(1404f)));
    }
    let _e1094 = group;
    let _e1096 = group;
    if ((_e1094 >= 3i) && (_e1096 <= 5i)) {
        let _e1099 = group;
        if (_e1099 == 3i) {
            let _e1101 = (*i_1);
            local_3 = _e1101;
        } else {
            let _e1102 = group;
            if (_e1102 == 4i) {
                let _e1104 = (*i_1);
                local_4 = (_e1104 / 36i);
            } else {
                let _e1106 = (*i_1);
                local_4 = (_e1106 / 15120i);
            }
            let _e1108 = local_4;
            local_3 = _e1108;
        }
        let _e1109 = local_3;
        limb = _e1109;
        let _e1110 = group;
        if (_e1110 == 4i) {
            let _e1112 = (*i_1);
            local_5 = (_e1112 - (i32(floor((f32(_e1112) / f32(36i)))) * 36i));
        } else {
            let _e1120 = (*i_1);
            let _e1121 = (_e1120 / 420i);
            local_5 = (_e1121 - (i32(floor((f32(_e1121) / f32(36i)))) * 36i));
        }
        let _e1129 = local_5;
        lat = _e1129;
        let _e1130 = (*i_1);
        let _e1131 = (_e1130 / 28i);
        shoot = (_e1131 - (i32(floor((f32(_e1131) / f32(15i)))) * 15i));
        let _e1139 = (*i_1);
        j_2 = (_e1139 - (i32(floor((f32(_e1139) / f32(28i)))) * 28i));
        let _e1147 = limb;
        indexable_2 = array<f32, 14>(18f, 18f, 18f, 18f, 18f, 18f, 19f, 19f, 17f, 24f, 23f, 23f, 21f, 21f);
        let _e1149 = indexable_2[_e1147];
        z_5 = _e1149;
        let _e1150 = limb;
        indexable_3 = array<vec4<f32>, 14>(vec4<f32>(93f, -60f, 384f, 65f), vec4<f32>(169f, -23f, 283f, 18f), vec4<f32>(9f, 99f, 214f, 223f), vec4<f32>(12f, 143f, 206f, 201f), vec4<f32>(7f, 213f, 169f, 322f), vec4<f32>(3f, 306f, 147f, 370f), vec4<f32>(22f, -17f, 256f, 35f), vec4<f32>(29f, 44f, 199f, 154f), vec4<f32>(134f, -24f, 335f, 113f), vec4<f32>(1117f, 198f, 1041f, 273f), vec4<f32>(1127f, 251f, 1044f, 322f), vec4<f32>(1118f, 337f, 997f, 433f), vec4<f32>(1125f, 492f, 990f, 561f), vec4<f32>(1118f, 547f, 1030f, 623f));
        let _e1152 = indexable_3[_e1150];
        b_3 = (_e1152 * 1.74545f);
        let _e1154 = b_3;
        param_55 = _e1154.xy;
        let _e1156 = z_5;
        param_56 = _e1156;
        let _e1157 = placevf2f1_((&param_55), (&param_56));
        p0_ = _e1157;
        let _e1158 = z_5;
        let _e1160 = b_3;
        param_57 = _e1160.zw;
        param_58 = (_e1158 + 1.5f);
        let _e1162 = placevf2f1_((&param_57), (&param_58));
        p1_ = _e1162;
        let _e1163 = p1_;
        let _e1164 = p0_;
        d_3 = (_e1163 - _e1164);
        let _e1166 = limb;
        let _e1168 = lat;
        seed_2 = ((_e1166 * 101i) + _e1168);
        let _e1170 = group;
        if (_e1170 == 3i) {
            let _e1172 = u_2;
            local_6 = _e1172;
        } else {
            let _e1173 = lat;
            let _e1177 = seed_2;
            param_59 = _e1177;
            param_60 = 4i;
            let _e1178 = rndi1i1_((&param_59), (&param_60));
            local_6 = (((f32((_e1173 / 2i)) + 0.12f) + (0.71f * _e1178)) / 18f);
        }
        let _e1182 = local_6;
        t_1 = _e1182;
        let _e1183 = p0_;
        let _e1184 = p1_;
        let _e1185 = t_1;
        let _e1188 = t_1;
        root = (mix(_e1183, _e1184, vec3(_e1185)) + (vec3<f32>(0f, -0.25f, 0.26f) * sin((3.1415927f * _e1188))));
        let _e1193 = group;
        if (_e1193 == 3i) {
            (*tag) = -0.1f;
            let _e1195 = root;
            let _e1196 = v_1;
            let _e1199 = u_2;
            return (_e1195 + vec3<f32>(0f, (((_e1196 - 0.5f) * 0.08f) * pow((1f - _e1199), 1.7f)), 0f));
        }
        let _e1205 = lat;
        side_2 = select(1f, -1f, ((_e1205 - (i32(floor((f32(_e1205) / f32(2i)))) * 2i)) == 0i));
        let _e1215 = limb;
        indexable_4 = array<f32, 14>(1.09f, 0.84f, 0.8f, 0.75f, 0.74f, 0.65f, 1.21f, 1.33f, 1.05f, 0.89f, 0.7f, 0.93f, 1.12f, 0.82f);
        let _e1217 = indexable_4[_e1215];
        let _e1219 = t_1;
        let _e1227 = seed_2;
        param_61 = _e1227;
        param_62 = 3i;
        let _e1228 = rndi1i1_((&param_61), (&param_62));
        width = (((1.17f * _e1217) * (0.28f + (0.72f * pow(max(0.0001f, sin((3.1415927f * _e1219))), 0.52f)))) * (0.6f + (0.45f * _e1228)));
        let _e1233 = d_3[0u];
        let _e1234 = seed_2;
        param_63 = _e1234;
        param_64 = 4i;
        let _e1235 = rndi1i1_((&param_63), (&param_64));
        let _e1238 = side_2;
        let _e1239 = width;
        let _e1243 = width;
        let _e1244 = side_2;
        if (_e1244 > 0f) {
            let _e1246 = seed_2;
            param_65 = _e1246;
            param_66 = 1i;
            let _e1247 = rndi1i1_((&param_65), (&param_66));
            local_7 = mix(-0.15f, 0.32f, _e1247);
        } else {
            local_7 = -1f;
        }
        let _e1249 = local_7;
        let _e1251 = seed_2;
        param_67 = _e1251;
        param_68 = 7i;
        let _e1252 = rndi1i1_((&param_67), (&param_68));
        let _e1255 = width;
        let _e1256 = side_2;
        branch = vec3<f32>(((_e1233 * mix(0.06f, 0.19f, _e1235)) + ((_e1238 * _e1239) * 0.48f)), ((_e1243 * _e1249) * mix(0.7f, 1.55f, _e1252)), ((_e1255 * _e1256) * 0.85f));
        let _e1260 = group;
        if (_e1260 == 4i) {
            (*tag) = 21f;
            let _e1262 = root;
            let _e1263 = u_2;
            let _e1264 = branch;
            let _e1267 = v_1;
            let _e1270 = u_2;
            return ((_e1262 + (_e1264 * _e1263)) + vec3<f32>(0f, (((_e1267 - 0.5f) * 0.04f) * (1f - _e1270)), 0f));
        }
        let _e1275 = branch;
        axis = normalize(_e1275);
        let _e1277 = axis;
        s = normalize(cross(_e1277, vec3<f32>(0f, 1f, 0f)));
        let _e1280 = shoot;
        let _e1282 = shoot;
        let _e1284 = seed_2;
        param_69 = _e1284;
        param_70 = (_e1282 + 22i);
        let _e1285 = rndi1i1_((&param_69), (&param_70));
        f_2 = ((f32(_e1280) + mix(0.05f, 0.92f, _e1285)) / 15f);
        let _e1289 = shoot;
        let _e1292 = shoot;
        let _e1294 = seed_2;
        param_71 = _e1294;
        param_72 = (_e1292 + 71i);
        let _e1295 = rndi1i1_((&param_71), (&param_72));
        angle_1 = ((f32(_e1289) * 2.39996f) + (0.96f * (_e1295 - 0.5f)));
        let _e1299 = s;
        let _e1300 = angle_1;
        let _e1303 = axis;
        let _e1304 = s;
        let _e1306 = angle_1;
        outDir = ((_e1299 * cos(_e1300)) + (cross(_e1303, _e1304) * sin(_e1306)));
        let _e1310 = width;
        scale = (_e1310 * 0.67f);
        let _e1312 = outDir;
        let _e1314 = axis;
        let _e1318 = scale;
        let _e1320 = f_2;
        let _e1324 = shoot;
        let _e1326 = seed_2;
        param_73 = _e1326;
        param_74 = (_e1324 + 56i);
        let _e1327 = rndi1i1_((&param_73), (&param_74));
        spr = ((((((_e1312 * 0.56f) + (_e1314 * 0.71f)) + vec3<f32>(0f, -0.29f, 0f)) * _e1318) * (1f - (0.61f * _e1320))) * mix(0.72f, 1.22f, _e1327));
        let _e1330 = spr;
        az_1 = normalize(_e1330);
        let _e1332 = az_1;
        tangent = normalize(cross(_e1332, vec3<f32>(0f, 1f, 0f)));
        let _e1335 = j_2;
        let _e1337 = (*i_1);
        param_75 = _e1337;
        param_76 = 5i;
        let _e1338 = rndi1i1_((&param_75), (&param_76));
        g = ((f32(_e1335) + mix(0.07f, 0.93f, _e1338)) / 28f);
        let _e1342 = j_2;
        let _e1345 = (*i_1);
        param_77 = _e1345;
        param_78 = 9i;
        let _e1346 = rndi1i1_((&param_77), (&param_78));
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
        let _e1368 = (*i_1);
        param_79 = _e1368;
        param_80 = 4i;
        let _e1369 = rndi1i1_((&param_79), (&param_80));
        let _e1372 = g;
        tip = ((((((_e1360 * 0.57f) + (_e1362 * 0.65f)) + vec3<f32>(0f, -0.16f, 0f)) * _e1366) * mix(0.21f, 0.48f, _e1369)) * (1f - (0.5f * _e1372)));
        let _e1376 = f_2;
        (*tag) = (0.15f + (0.29f * _e1376));
        let _e1379 = root;
        let _e1380 = branch;
        let _e1381 = f_2;
        let _e1384 = spr;
        let _e1385 = g;
        let _e1388 = tip;
        let _e1389 = u_2;
        let _e1392 = az_1;
        let _e1393 = rad;
        let _e1395 = scale;
        let _e1399 = g;
        let _e1403 = v_1;
        let _e1407 = u_2;
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
            let _e1431 = (*i_1);
            local_8 = _e1431;
        } else {
            let _e1432 = (*i_1);
            local_8 = (_e1432 / 36i);
        }
        let _e1434 = local_8;
        fr = _e1434;
        let _e1435 = (*i_1);
        leaf = (_e1435 - (i32(floor((f32(_e1435) / f32(36i)))) * 36i));
        let _e1443 = close;
        if _e1443 {
            local_9 = 3i;
        } else {
            let _e1444 = fr;
            local_9 = (_e1444 / 7i);
        }
        let _e1446 = local_9;
        cluster = _e1446;
        let _e1447 = fr;
        arm_1 = (_e1447 - (i32(floor((f32(_e1447) / f32(7i)))) * 7i));
        let _e1455 = cluster;
        indexable_5 = array<vec2<f32>, 4>(vec2<f32>(275f, 895f), vec2<f32>(405f, 893f), vec2<f32>(843f, 1013f), vec2<f32>(34f, 1119f));
        let _e1457 = indexable_5[_e1455];
        o = _e1457;
        let _e1458 = arm_1;
        let _e1460 = fr;
        param_81 = _e1460;
        param_82 = 2i;
        let _e1461 = rndi1i1_((&param_81), (&param_82));
        angle_2 = mix(-2.95f, -0.2f, ((f32(_e1458) + (0.4f * _e1461)) / 7f));
        let _e1466 = angle_2;
        let _e1468 = angle_2;
        let _e1471 = cluster;
        if (_e1471 == 3i) {
            local_10 = 245f;
        } else {
            let _e1473 = cluster;
            local_10 = select(46f, 90f, (_e1473 == 0i));
        }
        let _e1476 = local_10;
        let _e1478 = fr;
        param_83 = _e1478;
        param_84 = 7i;
        let _e1479 = rndi1i1_((&param_83), (&param_84));
        extent = ((vec2<f32>(cos(_e1466), sin(_e1468)) * _e1476) * (0.66f + (0.54f * _e1479)));
        let _e1483 = spine;
        if _e1483 {
            let _e1484 = u_2;
            local_11 = _e1484;
        } else {
            let _e1485 = leaf;
            local_11 = ((f32((_e1485 / 2i)) + 0.7f) / 19f);
        }
        let _e1490 = local_11;
        t_2 = _e1490;
        let _e1491 = o;
        let _e1492 = extent;
        let _e1493 = t_2;
        let _e1497 = extent[0u];
        let _e1500 = t_2;
        let _e1502 = t_2;
        let _e1504 = t_2;
        let _e1506 = t_2;
        p_4 = ((_e1491 + (_e1492 * _e1493)) + vec2<f32>(0f, ((((0.42f * abs(_e1497)) * _e1500) * _e1502) - ((22f * _e1504) * (1f - _e1506)))));
        let _e1512 = spine;
        if _e1512 {
            let _e1513 = v_1;
            let _e1517 = p_4[0u];
            p_4[0u] = (_e1517 + ((_e1513 - 0.5f) * 1.8f));
        } else {
            let _e1520 = leaf;
            side_3 = select(1f, -1f, ((_e1520 - (i32(floor((f32(_e1520) / f32(2i)))) * 2i)) == 0i));
            let _e1530 = extent;
            d_4 = normalize(_e1530);
            let _e1532 = cluster;
            if (_e1532 == 3i) {
                local_12 = 49f;
            } else {
                let _e1534 = cluster;
                local_12 = select(9f, 18f, (_e1534 == 0i));
            }
            let _e1537 = local_12;
            let _e1538 = t_2;
            let _e1545 = (*i_1);
            param_85 = _e1545;
            param_86 = 2i;
            let _e1546 = rndi1i1_((&param_85), (&param_86));
            w = ((_e1537 * (0.22f + (0.78f * sin((3.1415927f * pow(_e1538, 0.8f)))))) * (0.7f + (0.48f * _e1546)));
            let _e1550 = d_4;
            let _e1552 = side_3;
            let _e1554 = d_4[1u];
            let _e1557 = d_4[0u];
            dir_2 = normalize(((_e1550 * 0.52f) + (vec2<f32>(-(_e1554), _e1557) * _e1552)));
            let _e1562 = w;
            let _e1563 = dir_2;
            let _e1564 = u_2;
            let _e1567 = dir_2[1u];
            let _e1570 = dir_2[0u];
            let _e1572 = v_1;
            let _e1576 = u_2;
            let _e1582 = p_4;
            p_4 = (_e1582 + (((_e1563 * _e1564) + (((vec2<f32>(-(_e1567), _e1570) * (_e1572 - 0.5f)) * 0.37f) * sin((_e1576 * 3.1415927f)))) * _e1562));
        }
        let _e1584 = close;
        (*tag) = select(13.125f, 25.125f, _e1584);
        let _e1586 = close;
        let _e1588 = t_2;
        let _e1591 = u_2;
        let _e1594 = p_4;
        param_87 = _e1594;
        param_88 = ((select(15.35f, 7.1f, _e1586) + (0.08f * _e1588)) + (0.05f * _e1591));
        let _e1595 = placevf2f1_((&param_87), (&param_88));
        return _e1595;
    }
    let _e1596 = group;
    let _e1598 = group;
    if ((_e1596 == 8i) || (_e1598 == 9i)) {
        let _e1601 = group;
        stem = (_e1601 == 9i);
        let _e1603 = stem;
        if _e1603 {
            let _e1604 = (*i_1);
            local_13 = _e1604;
        } else {
            let _e1605 = (*i_1);
            local_13 = (_e1605 / 9i);
        }
        let _e1607 = local_13;
        flower = _e1607;
        let _e1608 = flower;
        o_1 = select(vec2<f32>(422f, 988f), vec2<f32>(371f, 981f), vec2((_e1608 == 0i)));
        let _e1612 = stem;
        if _e1612 {
            let _e1613 = o_1;
            let _e1614 = u_2;
            let _e1618 = u_2;
            let _e1621 = v_1;
            let _e1625 = u_2;
            p_5 = (_e1613 + vec2<f32>((((-8f * sin((3.1415927f * _e1614))) + (3f * _e1618)) + ((_e1621 - 0.5f) * 1.9f)), (111f * _e1625)));
        } else {
            let _e1629 = (*i_1);
            theta = ((6.283f * f32((_e1629 - (i32(floor((f32(_e1629) / f32(9i)))) * 9i)))) / 9f);
            let _e1640 = o_1;
            let _e1641 = theta;
            let _e1644 = u_2;
            let _e1646 = v_1;
            let _e1649 = u_2;
            let _e1654 = theta;
            let _e1657 = u_2;
            let _e1659 = u_2;
            let _e1661 = u_2;
            p_5 = (_e1640 + vec2<f32>((((cos(_e1641) * 12f) * _e1644) + (((_e1646 - 0.5f) * 8f) * sin((3.1415927f * _e1649)))), (((4f * sin(_e1654)) * _e1657) - ((11f * _e1659) * _e1661))));
        }
        let _e1666 = stem;
        if !(_e1666) {
            let _e1668 = (*i_1);
            theta_1 = ((6.283f * f32((_e1668 - (i32(floor((f32(_e1668) / f32(9i)))) * 9i)))) / 9f);
            let _e1679 = o_1;
            let _e1680 = theta_1;
            let _e1682 = u_2;
            let _e1686 = v_1;
            let _e1689 = u_2;
            let _e1694 = theta_1;
            let _e1697 = u_2;
            let _e1700 = u_2;
            let _e1702 = u_2;
            let _e1705 = v_1;
            let _e1708 = u_2;
            p_5 = (_e1679 + vec2<f32>(((cos(_e1680) * (4f + (10f * _e1682))) + (((_e1686 - 0.5f) * 10f) * sin((3.1415927f * _e1689)))), ((((3f * sin(_e1694)) * (1f + _e1697)) - ((7f * _e1700) * _e1702)) + (((_e1705 - 0.5f) * 4f) * sin((3.1415927f * _e1708))))));
        }
        let _e1715 = stem;
        (*tag) = select(18.125f, 16.125f, _e1715);
        let _e1717 = flower;
        let _e1721 = u_2;
        let _e1724 = p_5;
        param_89 = _e1724;
        param_90 = ((12.8f + (0.05f * f32(_e1717))) + (0.03f * _e1721));
        let _e1725 = placevf2f1_((&param_89), (&param_90));
        return _e1725;
    }
    let _e1726 = group;
    if (_e1726 == 10i) {
        let _e1728 = (*i_1);
        cl = (_e1728 / 3i);
        let _e1730 = cl;
        if (_e1730 < 4i) {
            local_14 = vec2<f32>(284f, 1060f);
        } else {
            let _e1732 = cl;
            local_14 = select(vec2<f32>(72f, 908f), vec2<f32>(467f, 1060f), vec2((_e1732 < 8i)));
        }
        let _e1736 = local_14;
        o_2 = _e1736;
        let _e1737 = cl;
        param_91 = _e1737;
        param_92 = 2i;
        let _e1738 = rndi1i1_((&param_91), (&param_92));
        let _e1740 = cl;
        param_93 = _e1740;
        param_94 = 4i;
        let _e1741 = rndi1i1_((&param_93), (&param_94));
        let _e1744 = cl;
        let _e1748 = o_2;
        o_2 = (_e1748 + (vec2<f32>((_e1738 - 0.5f), (_e1741 - 0.5f)) * select(99f, 49f, (_e1744 < 8i))));
        let _e1750 = (*i_1);
        let _e1760 = cl;
        param_95 = _e1760;
        param_96 = 7i;
        let _e1761 = rndi1i1_((&param_95), (&param_96));
        phi_1 = ((f32((_e1750 - (i32(floor((f32(_e1750) / f32(3i)))) * 3i))) * 2.0944f) + (5f * _e1761));
        let _e1764 = phi_1;
        let _e1766 = phi_1;
        dir_3 = vec2<f32>(cos(_e1764), (sin(_e1766) * 0.63f));
        let _e1770 = cl;
        w_1 = select(39f, 24f, (_e1770 < 8i));
        let _e1773 = o_2;
        let _e1774 = dir_3;
        let _e1775 = u_2;
        let _e1777 = w_1;
        let _e1781 = dir_3[1u];
        let _e1784 = dir_3[0u];
        let _e1786 = v_1;
        let _e1789 = w_1;
        let _e1791 = u_2;
        p_6 = ((_e1773 + ((_e1774 * _e1775) * _e1777)) + (((vec2<f32>(-(_e1781), _e1784) * (_e1786 - 0.5f)) * _e1789) * pow(max(0f, sin((3.1415927f * _e1791))), 0.58f)));
        (*tag) = 14.125f;
        let _e1798 = cl;
        let _e1802 = u_2;
        let _e1807 = p_6;
        param_97 = _e1807;
        param_98 = ((12.5f + (0.05f * f32(_e1798))) + (0.08f * sin((_e1802 * 3.1415927f))));
        let _e1808 = placevf2f1_((&param_97), (&param_98));
        return _e1808;
    }
    let _e1809 = group;
    if (_e1809 == 11i) {
        let _e1811 = (*i_1);
        o_3 = select(vec2<f32>(592f, 1030f), vec2<f32>(506f, 988f), vec2((_e1811 == 0i)));
        let _e1815 = o_3;
        let _e1816 = u_2;
        let _e1818 = u_2;
        let _e1820 = u_2;
        let _e1825 = v_1;
        let _e1828 = u_2;
        p_7 = (_e1815 + vec2<f32>((64f * _e1816), (((31f * _e1818) + (6f * sin((3.1415927f * _e1820)))) + (((_e1825 - 0.5f) * 19f) * sin((3.1415927f * _e1828))))));
        (*tag) = 15.125f;
        let _e1835 = v_1;
        let _e1840 = u_2;
        let _e1845 = p_7;
        param_99 = _e1845;
        param_100 = ((13.4f + (0.05f * abs((_e1835 - 0.5f)))) + (0.11f * sin((_e1840 * 3.1415927f))));
        let _e1846 = placevf2f1_((&param_99), (&param_100));
        return _e1846;
    }
    let _e1847 = group;
    if (_e1847 == 12i) {
        let _e1849 = (*i_1);
        cl_1 = (_e1849 / 20i);
        let _e1851 = cl_1;
        if (_e1851 == 0i) {
            local_15 = vec2<f32>(643f, 956f);
        } else {
            let _e1853 = cl_1;
            local_15 = select(vec2<f32>(150f, 871f), vec2<f32>(974f, 1067f), vec2((_e1853 == 1i)));
        }
        let _e1857 = local_15;
        o_4 = _e1857;
        let _e1858 = (*i_1);
        param_101 = _e1858;
        param_102 = 2i;
        let _e1859 = rndi1i1_((&param_101), (&param_102));
        a_3 = mix(-2.98f, -0.17f, _e1859);
        let _e1861 = (*i_1);
        param_103 = _e1861;
        param_104 = 5i;
        let _e1862 = rndi1i1_((&param_103), (&param_104));
        len_1 = mix(17f, 62f, _e1862);
        let _e1864 = o_4;
        let _e1865 = len_1;
        let _e1866 = a_3;
        let _e1868 = u_2;
        let _e1870 = a_3;
        let _e1872 = u_2;
        let _e1874 = u_2;
        let _e1876 = u_2;
        let _e1882 = v_1;
        let _e1884 = u_2;
        p_8 = ((_e1864 + (vec2<f32>((cos(_e1866) * _e1868), ((sin(_e1870) * _e1872) + ((0.19f * _e1874) * _e1876))) * _e1865)) + vec2<f32>((((_e1882 - 0.5f) * (1f - _e1884)) * 3.2f), 0f));
        (*tag) = 20.125f;
        let _e1890 = cl_1;
        let _e1893 = p_8;
        param_105 = _e1893;
        param_106 = select(13.7f, 16.6f, (_e1890 == 2i));
        let _e1894 = placevf2f1_((&param_105), (&param_106));
        return _e1894;
    }
    o_5 = vec2<f32>(149f, 871f);
    d_5 = vec2<f32>(40f, -123f);
    let _e1895 = group;
    let _e1897 = (*i_1);
    if ((_e1895 == 15i) && (_e1897 == 0i)) {
        let _e1900 = u_2;
        local_16 = _e1900;
    } else {
        let _e1901 = group;
        if (_e1901 == 16i) {
            let _e1903 = (*i_1);
            local_17 = _e1903;
        } else {
            let _e1904 = (*i_1);
            local_17 = (_e1904 - 1i);
        }
        let _e1906 = local_17;
        local_16 = (0.58f + (0.068f * f32(_e1906)));
    }
    let _e1910 = local_16;
    t_3 = _e1910;
    let _e1911 = o_5;
    let _e1912 = d_5;
    let _e1913 = t_3;
    let _e1916 = t_3;
    p_9 = ((_e1911 + (_e1912 * _e1913)) + vec2<f32>((10f * sin((_e1916 * 3.1415927f))), 0f));
    let _e1922 = (*i_1);
    f_3 = select(1f, -1f, ((_e1922 - (i32(floor((f32(_e1922) / f32(2i)))) * 2i)) == 0i));
    let _e1932 = group;
    if (_e1932 == 15i) {
        let _e1934 = (*i_1);
        if (_e1934 > 0i) {
            let _e1936 = f_3;
            let _e1939 = u_2;
            let _e1941 = p_9;
            p_9 = (_e1941 + (vec2<f32>((_e1936 * 17f), -11f) * _e1939));
        }
        let _e1943 = v_1;
        let _e1947 = p_9[0u];
        p_9[0u] = (_e1947 + ((_e1943 - 0.5f) * 1.7f));
        (*tag) = 16.125f;
    } else {
        let _e1950 = f_3;
        let _e1954 = a_2;
        let _e1956 = v_1;
        let _e1960 = v_1;
        let _e1966 = p_9;
        p_9 = (_e1966 + (vec2<f32>((-(_e1950) * 17f), -11f) + (vec2<f32>((cos(_e1954) * sin((3.1415927f * _e1956))), cos((3.1415927f * _e1960))) * 4.8f)));
        (*tag) = 17.125f;
    }
    let _e1968 = v_1;
    let _e1971 = p_9;
    param_107 = _e1971;
    param_108 = (16.3f + (0.06f * _e1968));
    let _e1972 = placevf2f1_((&param_107), (&param_108));
    return _e1972;
}

fn shadowVertexi1vf2_(inst: ptr<function, i32>, uv_1: ptr<function, vec2<f32>>) -> vec3<f32> {
    var p_10: vec3<f32>;
    var tag_1: f32;
    var param_109: i32;
    var param_110: vec2<f32>;
    var param_111: f32;
    var local_18: f32;
    var param_112: vec3<f32>;

    let _e18 = (*inst);
    param_109 = _e18;
    let _e19 = (*uv_1);
    param_110 = _e19;
    let _e20 = surfacei1vf2f1_((&param_109), (&param_110), (&param_111));
    let _e21 = param_111;
    tag_1 = _e21;
    p_10 = _e20;
    let _e22 = tag_1;
    if (_e22 > 1f) {
        local_18 = 0f;
    } else {
        let _e24 = tag_1;
        local_18 = max(_e24, 0f);
    }
    let _e26 = local_18;
    let _e30 = p_10[2u];
    let _e33 = p_10[1u];
    let _e39 = p_10[0u];
    p_10[0u] = (_e39 + (((0.45f * _e26) * 0.081f) * sin(((_e30 * 0.16f) + (_e33 * 0.21f)))));
    let _e42 = p_10;
    param_112 = _e42;
    let _e43 = lightProjectvf3_((&param_112));
    return _e43;
}

fn unpackPatchi1i1vi2vi2_(id: ptr<function, i32>, inst_1: ptr<function, i32>, cell: ptr<function, vec2<i32>>, span_1: ptr<function, vec2<i32>>) {
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
        cols_1 = 60i;
        rows_1 = 36i;
        let _e97 = (*id);
        ix = (_e97 - 0i);
        let _e99 = ix;
        (*inst_1) = (_e99 / 240i);
        (*span_1) = vec2<i32>(3i, 3i);
        let _e101 = ix;
        let _e109 = ix;
        let _e110 = (_e109 / 20i);
        let _e119 = (*span_1);
        (*cell) = (vec2<i32>((_e101 - (i32(floor((f32(_e101) / f32(20i)))) * 20i)), (_e110 - (i32(floor((f32(_e110) / f32(12i)))) * 12i))) * _e119);
        return;
    }
    let _e121 = (*id);
    if (_e121 < 5000i) {
        group = 1i;
        cols_1 = 100i;
        rows_1 = 4i;
        let _e123 = (*id);
        ix_1 = (_e123 - 4800i);
        let _e125 = ix_1;
        (*inst_1) = (_e125 / 200i);
        (*span_1) = vec2<i32>(2i, 1i);
        let _e127 = ix_1;
        let _e135 = ix_1;
        let _e136 = (_e135 / 50i);
        let _e145 = (*span_1);
        (*cell) = (vec2<i32>((_e127 - (i32(floor((f32(_e127) / f32(50i)))) * 50i)), (_e136 - (i32(floor((f32(_e136) / f32(4i)))) * 4i))) * _e145);
        return;
    }
    let _e147 = (*id);
    if (_e147 < 6200i) {
        group = 2i;
        cols_1 = 48i;
        rows_1 = 50i;
        let _e149 = (*id);
        ix_2 = (_e149 - 5000i);
        let _e151 = ix_2;
        (*inst_1) = (_e151 / 600i);
        (*span_1) = vec2<i32>(2i, 2i);
        let _e153 = ix_2;
        let _e161 = ix_2;
        let _e162 = (_e161 / 24i);
        let _e171 = (*span_1);
        (*cell) = (vec2<i32>((_e153 - (i32(floor((f32(_e153) / f32(24i)))) * 24i)), (_e162 - (i32(floor((f32(_e162) / f32(25i)))) * 25i))) * _e171);
        return;
    }
    let _e173 = (*id);
    if (_e173 < 6424i) {
        group = 3i;
        cols_1 = 32i;
        rows_1 = 1i;
        let _e175 = (*id);
        ix_3 = (_e175 - 6200i);
        let _e177 = ix_3;
        (*inst_1) = (_e177 / 16i);
        (*span_1) = vec2<i32>(2i, 1i);
        let _e179 = ix_3;
        let _e187 = ix_3;
        let _e188 = (_e187 / 16i);
        let _e197 = (*span_1);
        (*cell) = (vec2<i32>((_e179 - (i32(floor((f32(_e179) / f32(16i)))) * 16i)), (_e188 - (i32(floor((f32(_e188) / f32(1i)))) * 1i))) * _e197);
        return;
    }
    let _e199 = (*id);
    if (_e199 < 7432i) {
        group = 4i;
        cols_1 = 6i;
        rows_1 = 1i;
        let _e201 = (*id);
        ix_4 = (_e201 - 6424i);
        let _e203 = ix_4;
        (*inst_1) = (_e203 / 2i);
        (*span_1) = vec2<i32>(3i, 1i);
        let _e205 = ix_4;
        let _e213 = ix_4;
        let _e214 = (_e213 / 2i);
        let _e223 = (*span_1);
        (*cell) = (vec2<i32>((_e205 - (i32(floor((f32(_e205) / f32(2i)))) * 2i)), (_e214 - (i32(floor((f32(_e214) / f32(1i)))) * 1i))) * _e223);
        return;
    }
    let _e225 = (*id);
    if (_e225 < 219112i) {
        group = 5i;
        cols_1 = 2i;
        rows_1 = 1i;
        let _e227 = (*id);
        ix_5 = (_e227 - 7432i);
        let _e229 = ix_5;
        (*inst_1) = (_e229 / 1i);
        (*span_1) = vec2<i32>(2i, 1i);
        let _e231 = ix_5;
        let _e239 = ix_5;
        let _e240 = (_e239 / 1i);
        let _e249 = (*span_1);
        (*cell) = (vec2<i32>((_e231 - (i32(floor((f32(_e231) / f32(1i)))) * 1i)), (_e240 - (i32(floor((f32(_e240) / f32(1i)))) * 1i))) * _e249);
        return;
    }
    let _e251 = (*id);
    if (_e251 < 219868i) {
        group = 6i;
        cols_1 = 4i;
        rows_1 = 2i;
        let _e253 = (*id);
        ix_6 = (_e253 - 219112i);
        let _e255 = ix_6;
        (*inst_1) = (_e255 / 1i);
        (*span_1) = vec2<i32>(4i, 2i);
        let _e257 = ix_6;
        let _e265 = ix_6;
        let _e266 = (_e265 / 1i);
        let _e275 = (*span_1);
        (*cell) = (vec2<i32>((_e257 - (i32(floor((f32(_e257) / f32(1i)))) * 1i)), (_e266 - (i32(floor((f32(_e266) / f32(1i)))) * 1i))) * _e275);
        return;
    }
    let _e277 = (*id);
    if (_e277 < 219973i) {
        group = 7i;
        cols_1 = 15i;
        rows_1 = 1i;
        let _e279 = (*id);
        ix_7 = (_e279 - 219868i);
        let _e281 = ix_7;
        (*inst_1) = (_e281 / 5i);
        (*span_1) = vec2<i32>(3i, 1i);
        let _e283 = ix_7;
        let _e291 = ix_7;
        let _e292 = (_e291 / 5i);
        let _e301 = (*span_1);
        (*cell) = (vec2<i32>((_e283 - (i32(floor((f32(_e283) / f32(5i)))) * 5i)), (_e292 - (i32(floor((f32(_e292) / f32(1i)))) * 1i))) * _e301);
        return;
    }
    let _e303 = (*id);
    if (_e303 < 220009i) {
        group = 8i;
        cols_1 = 6i;
        rows_1 = 3i;
        let _e305 = (*id);
        ix_8 = (_e305 - 219973i);
        let _e307 = ix_8;
        (*inst_1) = (_e307 / 2i);
        (*span_1) = vec2<i32>(3i, 3i);
        let _e309 = ix_8;
        let _e317 = ix_8;
        let _e318 = (_e317 / 2i);
        let _e327 = (*span_1);
        (*cell) = (vec2<i32>((_e309 - (i32(floor((f32(_e309) / f32(2i)))) * 2i)), (_e318 - (i32(floor((f32(_e318) / f32(1i)))) * 1i))) * _e327);
        return;
    }
    let _e329 = (*id);
    if (_e329 < 220017i) {
        group = 9i;
        cols_1 = 12i;
        rows_1 = 1i;
        let _e331 = (*id);
        ix_9 = (_e331 - 220009i);
        let _e333 = ix_9;
        (*inst_1) = (_e333 / 4i);
        (*span_1) = vec2<i32>(3i, 1i);
        let _e335 = ix_9;
        let _e343 = ix_9;
        let _e344 = (_e343 / 4i);
        let _e353 = (*span_1);
        (*cell) = (vec2<i32>((_e335 - (i32(floor((f32(_e335) / f32(4i)))) * 4i)), (_e344 - (i32(floor((f32(_e344) / f32(1i)))) * 1i))) * _e353);
        return;
    }
    let _e355 = (*id);
    if (_e355 < 220101i) {
        group = 10i;
        cols_1 = 10i;
        rows_1 = 5i;
        let _e357 = (*id);
        ix_10 = (_e357 - 220017i);
        let _e359 = ix_10;
        (*inst_1) = (_e359 / 2i);
        (*span_1) = vec2<i32>(5i, 5i);
        let _e361 = ix_10;
        let _e369 = ix_10;
        let _e370 = (_e369 / 2i);
        let _e379 = (*span_1);
        (*cell) = (vec2<i32>((_e361 - (i32(floor((f32(_e361) / f32(2i)))) * 2i)), (_e370 - (i32(floor((f32(_e370) / f32(1i)))) * 1i))) * _e379);
        return;
    }
    let _e381 = (*id);
    if (_e381 < 220105i) {
        group = 11i;
        cols_1 = 14i;
        rows_1 = 5i;
        let _e383 = (*id);
        ix_11 = (_e383 - 220101i);
        let _e385 = ix_11;
        (*inst_1) = (_e385 / 2i);
        (*span_1) = vec2<i32>(7i, 5i);
        let _e387 = ix_11;
        let _e395 = ix_11;
        let _e396 = (_e395 / 2i);
        let _e405 = (*span_1);
        (*cell) = (vec2<i32>((_e387 - (i32(floor((f32(_e387) / f32(2i)))) * 2i)), (_e396 - (i32(floor((f32(_e396) / f32(1i)))) * 1i))) * _e405);
        return;
    }
    let _e407 = (*id);
    if (_e407 < 220225i) {
        group = 12i;
        cols_1 = 8i;
        rows_1 = 1i;
        let _e409 = (*id);
        ix_12 = (_e409 - 220105i);
        let _e411 = ix_12;
        (*inst_1) = (_e411 / 2i);
        (*span_1) = vec2<i32>(4i, 1i);
        let _e413 = ix_12;
        let _e421 = ix_12;
        let _e422 = (_e421 / 2i);
        let _e431 = (*span_1);
        (*cell) = (vec2<i32>((_e413 - (i32(floor((f32(_e413) / f32(2i)))) * 2i)), (_e422 - (i32(floor((f32(_e422) / f32(1i)))) * 1i))) * _e431);
        return;
    }
    let _e433 = (*id);
    if (_e433 < 220729i) {
        group = 13i;
        cols_1 = 6i;
        rows_1 = 2i;
        let _e435 = (*id);
        ix_13 = (_e435 - 220225i);
        let _e437 = ix_13;
        (*inst_1) = (_e437 / 2i);
        (*span_1) = vec2<i32>(3i, 2i);
        let _e439 = ix_13;
        let _e447 = ix_13;
        let _e448 = (_e447 / 2i);
        let _e457 = (*span_1);
        (*cell) = (vec2<i32>((_e439 - (i32(floor((f32(_e439) / f32(2i)))) * 2i)), (_e448 - (i32(floor((f32(_e448) / f32(1i)))) * 1i))) * _e457);
        return;
    }
    let _e459 = (*id);
    if (_e459 < 220764i) {
        group = 14i;
        cols_1 = 15i;
        rows_1 = 1i;
        let _e461 = (*id);
        ix_14 = (_e461 - 220729i);
        let _e463 = ix_14;
        (*inst_1) = (_e463 / 5i);
        (*span_1) = vec2<i32>(3i, 1i);
        let _e465 = ix_14;
        let _e473 = ix_14;
        let _e474 = (_e473 / 5i);
        let _e483 = (*span_1);
        (*cell) = (vec2<i32>((_e465 - (i32(floor((f32(_e465) / f32(5i)))) * 5i)), (_e474 - (i32(floor((f32(_e474) / f32(1i)))) * 1i))) * _e483);
        return;
    }
    let _e485 = (*id);
    if (_e485 < 220785i) {
        group = 15i;
        cols_1 = 12i;
        rows_1 = 1i;
        let _e487 = (*id);
        ix_15 = (_e487 - 220764i);
        let _e489 = ix_15;
        (*inst_1) = (_e489 / 3i);
        (*span_1) = vec2<i32>(4i, 1i);
        let _e491 = ix_15;
        let _e499 = ix_15;
        let _e500 = (_e499 / 3i);
        let _e509 = (*span_1);
        (*cell) = (vec2<i32>((_e491 - (i32(floor((f32(_e491) / f32(3i)))) * 3i)), (_e500 - (i32(floor((f32(_e500) / f32(1i)))) * 1i))) * _e509);
        return;
    }
    let _e511 = (*id);
    if (_e511 < 220821i) {
        group = 16i;
        cols_1 = 12i;
        rows_1 = 8i;
        let _e513 = (*id);
        ix_16 = (_e513 - 220785i);
        let _e515 = ix_16;
        (*inst_1) = (_e515 / 6i);
        (*span_1) = vec2<i32>(4i, 4i);
        let _e517 = ix_16;
        let _e525 = ix_16;
        let _e526 = (_e525 / 3i);
        let _e535 = (*span_1);
        (*cell) = (vec2<i32>((_e517 - (i32(floor((f32(_e517) / f32(3i)))) * 3i)), (_e526 - (i32(floor((f32(_e526) / f32(2i)))) * 2i))) * _e535);
        return;
    }
    let _e537 = (*id);
    if (_e537 < 238741i) {
        group = 17i;
        cols_1 = 3i;
        rows_1 = 2i;
        let _e539 = (*id);
        ix_17 = (_e539 - 220821i);
        let _e541 = ix_17;
        (*inst_1) = (_e541 / 1i);
        (*span_1) = vec2<i32>(3i, 2i);
        let _e543 = ix_17;
        let _e551 = ix_17;
        let _e552 = (_e551 / 1i);
        let _e561 = (*span_1);
        (*cell) = (vec2<i32>((_e543 - (i32(floor((f32(_e543) / f32(1i)))) * 1i)), (_e552 - (i32(floor((f32(_e552) / f32(1i)))) * 1i))) * _e561);
        return;
    }
    let _e563 = (*id);
    if (_e563 < 270741i) {
        group = 18i;
        cols_1 = 10i;
        rows_1 = 1i;
        let _e565 = (*id);
        ix_18 = (_e565 - 238741i);
        let _e567 = ix_18;
        (*inst_1) = (_e567 / 1i);
        (*span_1) = vec2<i32>(10i, 1i);
        let _e569 = ix_18;
        let _e577 = ix_18;
        let _e578 = (_e577 / 1i);
        let _e587 = (*span_1);
        (*cell) = (vec2<i32>((_e569 - (i32(floor((f32(_e569) / f32(1i)))) * 1i)), (_e578 - (i32(floor((f32(_e578) / f32(1i)))) * 1i))) * _e587);
        return;
    }
    let _e589 = (*id);
    if (_e589 < 270747i) {
        group = 19i;
        cols_1 = 12i;
        rows_1 = 1i;
        let _e591 = (*id);
        ix_19 = (_e591 - 270741i);
        let _e593 = ix_19;
        (*inst_1) = (_e593 / 6i);
        (*span_1) = vec2<i32>(2i, 1i);
        let _e595 = ix_19;
        let _e603 = ix_19;
        let _e604 = (_e603 / 6i);
        let _e613 = (*span_1);
        (*cell) = (vec2<i32>((_e595 - (i32(floor((f32(_e595) / f32(6i)))) * 6i)), (_e604 - (i32(floor((f32(_e604) / f32(1i)))) * 1i))) * _e613);
        return;
    }
    let _e615 = (*id);
    if (_e615 < 274267i) {
        group = 20i;
        cols_1 = 10i;
        rows_1 = 6i;
        let _e617 = (*id);
        ix_20 = (_e617 - 270747i);
        let _e619 = ix_20;
        (*inst_1) = (_e619 / 4i);
        (*span_1) = vec2<i32>(5i, 3i);
        let _e621 = ix_20;
        let _e629 = ix_20;
        let _e630 = (_e629 / 2i);
        let _e639 = (*span_1);
        (*cell) = (vec2<i32>((_e621 - (i32(floor((f32(_e621) / f32(2i)))) * 2i)), (_e630 - (i32(floor((f32(_e630) / f32(2i)))) * 2i))) * _e639);
        return;
    }
    (*inst_1) = 0i;
    (*cell) = vec2<i32>(0i, 0i);
    (*span_1) = vec2<i32>(1i, 1i);
    return;
}

fn shadowPatchvf2i1f1_(pos_1: ptr<function, vec2<f32>>, id_1: ptr<function, i32>, depth: ptr<function, f32>) {
    var inst_2: i32;
    var cell_1: vec2<i32>;
    var span_2: vec2<i32>;
    var param_113: i32;
    var param_114: i32;
    var param_115: vec2<i32>;
    var param_116: vec2<i32>;
    var stepUV: vec2<f32>;
    var y_3: i32;
    var x_3: i32;
    var uv_2: vec2<f32>;
    var k: i32;
    var point: vec2<f32>;
    var local_19: vec2<f32>;
    var local_20: vec2<f32>;
    var local_21: vec2<f32>;
    var vertex: array<vec3<f32>, 4>;
    var param_117: i32;
    var param_118: vec2<f32>;
    var param_119: vec2<f32>;
    var param_120: vec3<f32>;
    var param_121: vec3<f32>;
    var param_122: vec3<f32>;
    var param_123: f32;
    var param_124: vec2<f32>;
    var param_125: vec3<f32>;
    var param_126: vec3<f32>;
    var param_127: vec3<f32>;
    var param_128: f32;

    let _e43 = (*id_1);
    param_113 = _e43;
    unpackPatchi1i1vi2vi2_((&param_113), (&param_114), (&param_115), (&param_116));
    let _e44 = param_114;
    inst_2 = _e44;
    let _e45 = param_115;
    cell_1 = _e45;
    let _e46 = param_116;
    span_2 = _e46;
    let _e47 = cols_1;
    let _e49 = rows_1;
    stepUV = (vec2(1f) / vec2<f32>(f32(_e47), f32(_e49)));
    y_3 = 0i;
    loop {
        let _e54 = y_3;
        let _e56 = span_2[1u];
        if (_e54 < _e56) {
            x_3 = 0i;
            loop {
                let _e58 = x_3;
                let _e60 = span_2[0u];
                if (_e58 < _e60) {
                    let _e62 = cell_1;
                    let _e63 = x_3;
                    let _e64 = y_3;
                    let _e68 = stepUV;
                    uv_2 = (vec2<f32>((_e62 + vec2<i32>(_e63, _e64))) * _e68);
                    k = 0i;
                    loop {
                        let _e70 = k;
                        if (_e70 < 4i) {
                            let _e72 = k;
                            if (_e72 == 0i) {
                                let _e74 = uv_2;
                                local_19 = _e74;
                            } else {
                                let _e75 = k;
                                if (_e75 == 1i) {
                                    let _e77 = uv_2;
                                    let _e79 = stepUV[0u];
                                    local_20 = (_e77 + vec2<f32>(_e79, 0f));
                                } else {
                                    let _e82 = k;
                                    if (_e82 == 2i) {
                                        let _e84 = uv_2;
                                        let _e85 = stepUV;
                                        local_21 = (_e84 + _e85);
                                    } else {
                                        let _e87 = uv_2;
                                        let _e89 = stepUV[1u];
                                        local_21 = (_e87 + vec2<f32>(0f, _e89));
                                    }
                                    let _e92 = local_21;
                                    local_20 = _e92;
                                }
                                let _e93 = local_20;
                                local_19 = _e93;
                            }
                            let _e94 = local_19;
                            point = _e94;
                            let _e95 = k;
                            let _e96 = inst_2;
                            param_117 = _e96;
                            let _e97 = point;
                            param_118 = _e97;
                            let _e98 = shadowVertexi1vf2_((&param_117), (&param_118));
                            vertex[_e95] = _e98;
                            continue;
                        } else {
                            break;
                        }
                        continuing {
                            let _e100 = k;
                            k = (_e100 + 1i);
                        }
                    }
                    let _e102 = (*pos_1);
                    param_119 = _e102;
                    let _e104 = vertex[0i];
                    param_120 = _e104;
                    let _e106 = vertex[1i];
                    param_121 = _e106;
                    let _e108 = vertex[2i];
                    param_122 = _e108;
                    let _e109 = (*depth);
                    param_123 = _e109;
                    shadowTrianglevf2vf3vf3vf3f1_((&param_119), (&param_120), (&param_121), (&param_122), (&param_123));
                    let _e110 = param_123;
                    (*depth) = _e110;
                    let _e111 = (*pos_1);
                    param_124 = _e111;
                    let _e113 = vertex[0i];
                    param_125 = _e113;
                    let _e115 = vertex[2i];
                    param_126 = _e115;
                    let _e117 = vertex[3i];
                    param_127 = _e117;
                    let _e118 = (*depth);
                    param_128 = _e118;
                    shadowTrianglevf2vf3vf3vf3f1_((&param_124), (&param_125), (&param_126), (&param_127), (&param_128));
                    let _e119 = param_128;
                    (*depth) = _e119;
                    continue;
                } else {
                    break;
                }
                continuing {
                    let _e120 = x_3;
                    x_3 = (_e120 + 1i);
                }
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e122 = y_3;
            y_3 = (_e122 + 1i);
        }
    }
    return;
}

fn loci1_(i_2: ptr<function, i32>) -> vec2<i32> {
    var w_2: i32;

    let _e6 = unnamed.iResolution[0u];
    w_2 = i32(_e6);
    let _e8 = (*i_2);
    let _e9 = w_2;
    let _e17 = (*i_2);
    let _e18 = w_2;
    return vec2<i32>((_e8 - (i32(floor((f32(_e8) / f32(_e9)))) * _e9)), (_e17 / _e18));
}

fn previousi1_(i_3: ptr<function, i32>) -> vec4<f32> {
    var param_129: i32;

    let _e4 = (*i_3);
    param_129 = _e4;
    let _e5 = loci1_((&param_129));
    let _e6 = textureLoad(tex0_, _e5, 0i);
    return _e6;
}

fn levelStarti1_(level: ptr<function, i32>) -> i32 {
    let _e4 = (*level);
    return ((1048576i - (1048576i >> bitcast<u32>((2i * _e4)))) / 3i);
}

fn shadowDepthvf2_(pos_2: ptr<function, vec2<f32>>) -> f32 {
    var depth_1: f32;
    var level_1: i32;
    var tile: f32;
    var center_1: vec2<i32>;
    var count: i32;
    var y_4: i32;
    var x_4: i32;
    var cell_2: vec2<i32>;
    var key: i32;
    var param_130: i32;
    var range: vec2<i32>;
    var param_131: i32;
    var j_3: i32;
    var record: vec4<f32>;
    var param_132: i32;
    var param_133: vec2<f32>;
    var param_134: i32;
    var param_135: f32;
    var phi_12592_: bool;

    depth_1 = 1f;
    level_1 = 0i;
    loop {
        let _e31 = level_1;
        if (_e31 < 9i) {
            let _e33 = level_1;
            tile = (2f * exp2(f32(_e33)));
            let _e37 = (*pos_2);
            let _e38 = tile;
            center_1 = vec2<i32>((_e37 / vec2(_e38)));
            let _e42 = level_1;
            count = (512i >> bitcast<u32>(_e42));
            y_4 = -1i;
            loop {
                let _e45 = y_4;
                if (_e45 <= 1i) {
                    x_4 = -1i;
                    loop {
                        let _e47 = x_4;
                        if (_e47 <= 1i) {
                            let _e49 = center_1;
                            let _e50 = x_4;
                            let _e51 = y_4;
                            cell_2 = (_e49 + vec2<i32>(_e50, _e51));
                            let _e54 = cell_2;
                            let _e56 = any((_e54 < vec2<i32>(0i, 0i)));
                            phi_12592_ = _e56;
                            if !(_e56) {
                                let _e58 = cell_2;
                                let _e59 = count;
                                phi_12592_ = any((_e58 >= vec2(_e59)));
                            }
                            let _e64 = phi_12592_;
                            if _e64 {
                                continue;
                            }
                            let _e65 = level_1;
                            param_130 = _e65;
                            let _e66 = levelStarti1_((&param_130));
                            let _e68 = cell_2[1u];
                            let _e69 = count;
                            let _e73 = cell_2[0u];
                            key = ((_e66 + (_e68 * _e69)) + _e73);
                            let _e75 = key;
                            param_131 = (524288i + _e75);
                            let _e77 = previousi1_((&param_131));
                            range = vec2<i32>(_e77.xy);
                            j_3 = 0i;
                            loop {
                                let _e80 = j_3;
                                let _e82 = range[1u];
                                if (_e80 < _e82) {
                                    let _e85 = range[0u];
                                    let _e86 = j_3;
                                    param_132 = (_e85 + _e86);
                                    let _e88 = previousi1_((&param_132));
                                    record = _e88;
                                    let _e89 = record;
                                    let _e91 = (*pos_2);
                                    let _e94 = tile;
                                    if any((abs((_e89.xy - _e91)) > vec2(_e94))) {
                                        continue;
                                    }
                                    let _e99 = record[3u];
                                    let _e101 = (*pos_2);
                                    param_133 = _e101;
                                    param_134 = i32(_e99);
                                    let _e102 = depth_1;
                                    param_135 = _e102;
                                    shadowPatchvf2i1f1_((&param_133), (&param_134), (&param_135));
                                    let _e103 = param_135;
                                    depth_1 = _e103;
                                    continue;
                                } else {
                                    break;
                                }
                                continuing {
                                    let _e104 = j_3;
                                    j_3 = (_e104 + 1i);
                                }
                            }
                            continue;
                        } else {
                            break;
                        }
                        continuing {
                            let _e106 = x_4;
                            x_4 = (_e106 + 1i);
                        }
                    }
                    continue;
                } else {
                    break;
                }
                continuing {
                    let _e108 = y_4;
                    y_4 = (_e108 + 1i);
                }
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e110 = level_1;
            level_1 = (_e110 + 1i);
        }
    }
    let _e112 = depth_1;
    return _e112;
}

fn lightKeyvf4_(record_1: ptr<function, vec4<f32>>) -> i32 {
    var level_2: i32;
    var tile_1: f32;
    var cell_3: vec2<i32>;
    var param_136: i32;

    let _e14 = (*record_1)[2u];
    if (_e14 <= 0f) {
        return 999999i;
    }
    let _e17 = (*record_1)[2u];
    level_2 = (i32(_e17) - 1i);
    let _e20 = level_2;
    tile_1 = (2f * exp2(f32(_e20)));
    let _e24 = (*record_1);
    let _e26 = tile_1;
    cell_3 = vec2<i32>((_e24.xy / vec2(_e26)));
    let _e30 = level_2;
    param_136 = _e30;
    let _e31 = levelStarti1_((&param_136));
    let _e33 = cell_3[1u];
    let _e34 = level_2;
    let _e40 = cell_3[0u];
    return ((_e31 + (_e33 * (512i >> bitcast<u32>(_e34)))) + _e40);
}

fn firstLighti1_(key_1: ptr<function, i32>) -> i32 {
    var lo: i32;
    var hi: i32;
    var k_1: i32;
    var mid: i32;
    var param_137: i32;
    var param_138: vec4<f32>;

    lo = 0i;
    hi = 524288i;
    k_1 = 0i;
    loop {
        let _e12 = k_1;
        if (_e12 < 20i) {
            let _e14 = lo;
            let _e15 = hi;
            if (_e14 >= _e15) {
                break;
            }
            let _e17 = lo;
            let _e18 = hi;
            mid = ((_e17 + _e18) / 2i);
            let _e21 = mid;
            param_137 = _e21;
            let _e22 = previousi1_((&param_137));
            param_138 = _e22;
            let _e23 = lightKeyvf4_((&param_138));
            let _e24 = (*key_1);
            if (_e23 < _e24) {
                let _e26 = mid;
                lo = (_e26 + 1i);
            } else {
                let _e28 = mid;
                hi = _e28;
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e29 = k_1;
            k_1 = (_e29 + 1i);
        }
    }
    let _e31 = lo;
    return _e31;
}

fn shadowBoundsi1_(id_2: ptr<function, i32>) -> vec4<f32> {
    var inst_3: i32;
    var cell_4: vec2<i32>;
    var span_3: vec2<i32>;
    var param_139: i32;
    var param_140: i32;
    var param_141: vec2<i32>;
    var param_142: vec2<i32>;
    var lo_1: vec3<f32>;
    var hi_1: vec3<f32>;
    var y_5: i32;
    var x_5: i32;
    var p_11: vec3<f32>;
    var param_143: i32;
    var param_144: vec2<f32>;
    var lower: vec2<f32>;
    var upper: vec2<f32>;
    var radius: f32;
    var level_3: i32;
    var phi_11973_: bool;
    var phi_12052_: bool;

    let _e37 = (*id_2);
    let _e38 = (_e37 >= 270747i);
    phi_11973_ = _e38;
    if !(_e38) {
        let _e40 = (*id_2);
        let _e42 = (*id_2);
        phi_11973_ = ((_e40 >= 220225i) && (_e42 < 220764i));
    }
    let _e46 = phi_11973_;
    if _e46 {
        return vec4<f32>(0f, 0f, 0f, 0f);
    }
    let _e47 = (*id_2);
    param_139 = _e47;
    unpackPatchi1i1vi2vi2_((&param_139), (&param_140), (&param_141), (&param_142));
    let _e48 = param_140;
    inst_3 = _e48;
    let _e49 = param_141;
    cell_4 = _e49;
    let _e50 = param_142;
    span_3 = _e50;
    lo_1 = vec3<f32>(10000000000f, 10000000000f, 10000000000f);
    let _e51 = lo_1;
    hi_1 = -(_e51);
    y_5 = 0i;
    loop {
        let _e53 = y_5;
        let _e55 = span_3[1u];
        if (_e53 <= _e55) {
            x_5 = 0i;
            loop {
                let _e57 = x_5;
                let _e59 = span_3[0u];
                if (_e57 <= _e59) {
                    let _e61 = cell_4;
                    let _e62 = x_5;
                    let _e63 = y_5;
                    let _e67 = cols_1;
                    let _e69 = rows_1;
                    let _e73 = inst_3;
                    param_143 = _e73;
                    param_144 = (vec2<f32>((_e61 + vec2<i32>(_e62, _e63))) / vec2<f32>(f32(_e67), f32(_e69)));
                    let _e74 = shadowVertexi1vf2_((&param_143), (&param_144));
                    p_11 = _e74;
                    let _e75 = lo_1;
                    let _e76 = p_11;
                    lo_1 = min(_e75, _e76);
                    let _e78 = hi_1;
                    let _e79 = p_11;
                    hi_1 = max(_e78, _e79);
                    continue;
                } else {
                    break;
                }
                continuing {
                    let _e81 = x_5;
                    x_5 = (_e81 + 1i);
                }
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e83 = y_5;
            y_5 = (_e83 + 1i);
        }
    }
    let _e85 = hi_1;
    let _e87 = any((_e85 < vec3<f32>(0f, 0f, 0f)));
    phi_12052_ = _e87;
    if !(_e87) {
        let _e89 = lo_1;
        phi_12052_ = any((_e89 > vec3<f32>(1024f, 1024f, 1f)));
    }
    let _e93 = phi_12052_;
    if _e93 {
        return vec4<f32>(0f, 0f, 0f, 0f);
    }
    let _e94 = lo_1;
    lower = max(_e94.xy, vec2<f32>(0f, 0f));
    let _e97 = hi_1;
    upper = min(_e97.xy, vec2<f32>(1023.999f, 1023.999f));
    let _e101 = upper[0u];
    let _e103 = lower[0u];
    let _e106 = upper[1u];
    let _e108 = lower[1u];
    radius = (0.5f * max((_e101 - _e103), (_e106 - _e108)));
    let _e112 = radius;
    level_3 = i32(ceil(log2(max(1f, (_e112 / 2f)))));
    let _e118 = lower;
    let _e119 = upper;
    let _e121 = ((_e118 + _e119) * 0.5f);
    let _e122 = level_3;
    let _e125 = (*id_2);
    return vec4<f32>(_e121.x, _e121.y, (1f + f32(_e122)), f32(_e125));
}

fn lightSorti1_(id_3: ptr<function, i32>) -> vec4<f32> {
    var param_145: i32;
    var a_4: vec4<f32>;
    var param_146: i32;
    var stepN: i32;
    var stage: i32;
    var k_2: i32;
    var stride: i32;
    var b_4: vec4<f32>;
    var param_147: i32;
    var ka: i32;
    var param_148: vec4<f32>;
    var kb: i32;
    var param_149: vec4<f32>;
    var first: bool;
    var low: bool;
    var phi_12294_: bool;
    var phi_12295_: bool;

    let _e23 = unnamed.iFrame;
    if (_e23 == 0i) {
        let _e25 = (*id_3);
        param_145 = _e25;
        let _e26 = shadowBoundsi1_((&param_145));
        return _e26;
    }
    let _e27 = (*id_3);
    param_146 = _e27;
    let _e28 = previousi1_((&param_146));
    a_4 = _e28;
    let _e30 = unnamed.iFrame;
    if (_e30 > 190i) {
        let _e32 = a_4;
        return _e32;
    }
    let _e34 = unnamed.iFrame;
    stepN = (_e34 - 1i);
    stage = 1i;
    k_2 = 1i;
    loop {
        let _e36 = k_2;
        if (_e36 <= 19i) {
            let _e38 = stepN;
            let _e39 = k_2;
            if (_e38 < _e39) {
                let _e41 = k_2;
                stage = _e41;
                break;
            }
            let _e42 = k_2;
            let _e43 = stepN;
            stepN = (_e43 - _e42);
            continue;
        } else {
            break;
        }
        continuing {
            let _e45 = k_2;
            k_2 = (_e45 + 1i);
        }
    }
    let _e47 = stage;
    let _e49 = stepN;
    stride = (1i << bitcast<u32>(((_e47 - 1i) - _e49)));
    let _e53 = (*id_3);
    let _e54 = stride;
    param_147 = (_e53 ^ _e54);
    let _e56 = previousi1_((&param_147));
    b_4 = _e56;
    let _e57 = a_4;
    param_148 = _e57;
    let _e58 = lightKeyvf4_((&param_148));
    ka = _e58;
    let _e59 = b_4;
    param_149 = _e59;
    let _e60 = lightKeyvf4_((&param_149));
    kb = _e60;
    let _e61 = ka;
    let _e62 = kb;
    let _e63 = (_e61 < _e62);
    phi_12295_ = _e63;
    if !(_e63) {
        let _e65 = ka;
        let _e66 = kb;
        let _e67 = (_e65 == _e66);
        phi_12294_ = _e67;
        if _e67 {
            let _e69 = a_4[3u];
            let _e71 = b_4[3u];
            phi_12294_ = (_e69 <= _e71);
        }
        let _e74 = phi_12294_;
        phi_12295_ = _e74;
    }
    let _e76 = phi_12295_;
    first = _e76;
    let _e77 = (*id_3);
    let _e78 = stage;
    let _e83 = (*id_3);
    let _e84 = stride;
    low = (((_e77 & (1i << bitcast<u32>(_e78))) == 0i) == ((_e83 & _e84) == 0i));
    let _e88 = low;
    let _e89 = first;
    let _e91 = a_4;
    let _e92 = b_4;
    return select(_e92, _e91, vec4((_e88 == _e89)));
}

fn linearToSrgbvf3_(c_1: ptr<function, vec3<f32>>) -> vec3<f32> {
    let _e7 = (*c_1);
    (*c_1) = max(_e7, vec3(0f));
    let _e10 = (*c_1);
    let _e12 = (*c_1);
    let _e17 = (*c_1);
    return mix((_e10 * 12.92f), ((pow(_e12, vec3<f32>(0.41666666f, 0.41666666f, 0.41666666f)) * 1.055f) - vec3(0.055f)), step(vec3(0.0031308f), _e17));
}

fn filmvf3_(c_2: ptr<function, vec3<f32>>) -> vec3<f32> {
    var param_150: vec3<f32>;

    let _e4 = (*c_2);
    param_150 = clamp(_e4, vec3(0f), vec3(1f));
    let _e8 = linearToSrgbvf3_((&param_150));
    return _e8;
}

fn key_2() -> vec3<f32> {
    return vec3<f32>(1.3928f, 0.7928f, 0.4764f);
}

fn sunlight() -> vec3<f32> {
    return vec3<f32>(-0.29431123f, 0.08785751f, 0.9516627f);
}

fn srgbToLinearvf3_(c_3: ptr<function, vec3<f32>>) -> vec3<f32> {
    let _e7 = (*c_3);
    (*c_3) = max(_e7, vec3(0f));
    let _e10 = (*c_3);
    let _e13 = (*c_3);
    let _e19 = (*c_3);
    return mix((_e10 / vec3(12.92f)), pow(((_e13 + vec3(0.055f)) / vec3(1.055f)), vec3<f32>(2.4f, 2.4f, 2.4f)), step(vec3(0.04045f), _e19));
}

fn rockSurveyvf2_(world: ptr<function, vec2<f32>>) -> vec2<f32> {
    var local_22: vec2<f32>;
    var texel: vec2<f32>;
    var phi_2192_: bool;

    let _e14 = (*world);
    local_22 = (_e14 - vec2<f32>(-100f, 320f));
    let _e16 = local_22;
    let _e18 = any((_e16 < vec2<f32>(0f, 0f)));
    phi_2192_ = _e18;
    if !(_e18) {
        let _e20 = local_22;
        phi_2192_ = any((_e20 >= vec2<f32>(1024f, 768f)));
    }
    let _e24 = phi_2192_;
    if _e24 {
        return vec2<f32>(0f, 0f);
    }
    let _e25 = local_22;
    texel = (vec2<f32>(769f, 0f) + clamp(_e25, vec2<f32>(0.5f, 0.5f), vec2<f32>(1023.5f, 767.5f)));
    let _e28 = texel;
    let _e31 = unnamed.channelSizes[2i];
    let _e34 = textureSampleLevel(tex2_, samp2_, (_e28 / _e31.xy), 0f);
    return _e34.xy;
}

fn contactAtvf2_(p_12: ptr<function, vec2<f32>>) -> vec4<f32> {
    var param_151: vec2<f32>;

    let _e4 = (*p_12);
    param_151 = _e4;
    let _e5 = rockSurveyvf2_((&param_151));
    return vec4<f32>(_e5.x, _e5.y, 0f, 1f);
}

fn elevationNodevi2_(node: ptr<function, vec2<i32>>) -> f32 {
    var values: vec4<f32>;

    let _e9 = (*node);
    (*node) = clamp(_e9, vec2<i32>(0i, 0i), vec2<i32>(1536i, 1536i));
    let _e11 = (*node);
    let _e14 = textureLoad(tex2_, (_e11 / vec2(2i)), 0i);
    values = _e14;
    let _e16 = (*node)[1u];
    let _e26 = (*node)[0u];
    let _e36 = values[(((_e16 - (i32(floor((f32(_e16) / f32(2i)))) * 2i)) * 2i) + (_e26 - (i32(floor((f32(_e26) / f32(2i)))) * 2i)))];
    return _e36;
}

fn elevationComponentsvi2_(node_1: ptr<function, vec2<i32>>) -> vec2<f32> {
    var units: f32;
    var param_152: vec2<i32>;

    let _e6 = (*node_1);
    param_152 = _e6;
    let _e7 = elevationNodevi2_((&param_152));
    units = ((_e7 + 48f) * 128f);
    let _e10 = units;
    let _e13 = units;
    return vec2<f32>(floor((_e10 / 256f)), (_e13 - (floor((_e13 / 256f)) * 256f)));
}

fn bedvf2_(world_1: ptr<function, vec2<f32>>) -> f32 {
    var at: vec2<f32>;
    var i_4: vec2<i32>;
    var f_4: vec2<f32>;
    var value: vec2<f32>;
    var param_153: vec2<i32>;
    var param_154: vec2<i32>;
    var param_155: vec2<i32>;
    var param_156: vec2<i32>;

    let _e23 = (*world_1);
    at = ((((_e23 + vec2<f32>(1100f, 40f)) / vec2<f32>(2200f, 1800f)) * 1537f) - vec2(0.5f));
    let _e29 = at;
    i_4 = vec2<i32>(floor(_e29));
    let _e32 = at;
    f_4 = (floor(((fract(_e32) * 256f) + vec2(0.5f))) / vec2(256f));
    let _e40 = i_4;
    param_153 = _e40;
    let _e41 = elevationComponentsvi2_((&param_153));
    let _e42 = i_4;
    param_154 = (_e42 + vec2<i32>(1i, 0i));
    let _e44 = elevationComponentsvi2_((&param_154));
    let _e46 = f_4[0u];
    let _e49 = i_4;
    param_155 = (_e49 + vec2<i32>(0i, 1i));
    let _e51 = elevationComponentsvi2_((&param_155));
    let _e52 = i_4;
    param_156 = (_e52 + vec2<i32>(1i, 1i));
    let _e54 = elevationComponentsvi2_((&param_156));
    let _e56 = f_4[0u];
    let _e60 = f_4[1u];
    value = mix(mix(_e41, _e44, vec2(_e46)), mix(_e51, _e54, vec2(_e56)), vec2(_e60));
    let _e63 = value;
    return ((dot((floor(((_e63 * 16f) + vec2(0.5f))) / vec2(16f)), vec2<f32>(256f, 1f)) / 128f) - 48f);
}

fn baseHeightvf2_(p_13: ptr<function, vec2<f32>>) -> f32 {
    var param_157: vec2<f32>;

    let _e2 = (*p_13);
    param_157 = _e2;
    let _e3 = bedvf2_((&param_157));
    return _e3;
}

fn hasGround() -> bool {
    return true;
}

fn airColorf1_(scatter: ptr<function, f32>) -> vec3<f32> {
    var param_158: vec3<f32>;

    let _e6 = (*scatter);
    param_158 = mix(vec3<f32>(0.486f, 0.503f, 0.653f), vec3<f32>(1f, 0.83f, 0.721f), vec3(smoothstep(0.14f, 0.86f, _e6)));
    let _e10 = srgbToLinearvf3_((&param_158));
    return _e10;
}

fn heightFogvf3vf3f1f1f1_(ro: ptr<function, vec3<f32>>, rd: ptr<function, vec3<f32>>, t_4: ptr<function, f32>, a_5: ptr<function, f32>, b_5: ptr<function, f32>) -> f32 {
    var base_1: f32;
    var amount: f32;
    var local_23: f32;

    let _e12 = (*a_5);
    let _e14 = (*ro)[1u];
    let _e16 = (*b_5);
    base_1 = (_e12 * exp((-(_e14) * _e16)));
    let _e21 = (*rd)[1u];
    if (abs(_e21) < 0.0001f) {
        let _e24 = base_1;
        let _e25 = (*t_4);
        local_23 = (_e24 * _e25);
    } else {
        let _e27 = base_1;
        let _e28 = (*t_4);
        let _e31 = (*rd)[1u];
        let _e33 = (*b_5);
        let _e39 = (*rd)[1u];
        let _e40 = (*b_5);
        local_23 = ((_e27 * (1f - exp(((-(_e28) * _e31) * _e33)))) / (_e39 * _e40));
    }
    let _e43 = local_23;
    amount = _e43;
    let _e44 = amount;
    return (1f - exp(-(max(_e44, 0f))));
}

fn uintToUnitu1_(h_2: ptr<function, u32>) -> f32 {
    let _e3 = (*h_2);
    return (f32((_e3 >> bitcast<u32>(8u))) * 0.000000059604645f);
}

fn pcgHashu1_(v_2: ptr<function, u32>) -> u32 {
    var state: u32;
    var word: u32;

    let _e9 = (*v_2);
    state = ((_e9 * 747796405u) + 2891336453u);
    let _e12 = state;
    let _e13 = state;
    let _e19 = state;
    word = (((_e12 >> bitcast<u32>(((_e13 >> bitcast<u32>(28u)) + 4u))) ^ _e19) * 277803737u);
    let _e22 = word;
    let _e25 = word;
    return ((_e22 >> bitcast<u32>(22u)) ^ _e25);
}

fn hash12vf2_(p_14: ptr<function, vec2<f32>>) -> f32 {
    var q_2: vec2<u32>;
    var param_159: u32;
    var param_160: u32;
    var param_161: u32;

    let _e7 = (*p_14);
    q_2 = bitcast<vec2<u32>>(vec2<i32>(floor(_e7)));
    let _e12 = q_2[0u];
    let _e14 = q_2[1u];
    param_159 = _e14;
    let _e15 = pcgHashu1_((&param_159));
    param_160 = (_e12 + _e15);
    let _e17 = pcgHashu1_((&param_160));
    param_161 = _e17;
    let _e18 = uintToUnitu1_((&param_161));
    return _e18;
}

fn latticeGradientvf2_(cell_5: ptr<function, vec2<f32>>) -> vec2<f32> {
    var a_6: f32;
    var param_162: vec2<f32>;

    let _e4 = (*cell_5);
    param_162 = _e4;
    let _e5 = hash12vf2_((&param_162));
    a_6 = (6.2831855f * _e5);
    let _e7 = a_6;
    let _e9 = a_6;
    return vec2<f32>(cos(_e7), sin(_e9));
}

fn quinticFadeDerivvf2_(f_5: ptr<function, vec2<f32>>) -> vec2<f32> {
    let _e4 = (*f_5);
    let _e6 = (*f_5);
    let _e8 = (*f_5);
    let _e9 = (*f_5);
    return (((_e4 * 30f) * _e6) * ((_e8 * (_e9 - vec2(2f))) + vec2(1f)));
}

fn quinticFadevf2_(f_6: ptr<function, vec2<f32>>) -> vec2<f32> {
    let _e4 = (*f_6);
    let _e5 = (*f_6);
    let _e7 = (*f_6);
    let _e9 = (*f_6);
    let _e10 = (*f_6);
    return (((_e4 * _e5) * _e7) * ((_e9 * ((_e10 * 6f) - vec2(15f))) + vec2(10f)));
}

fn gradientNoiseDvf2_(p_15: ptr<function, vec2<f32>>) -> vec3<f32> {
    var i_5: vec2<f32>;
    var f_7: vec2<f32>;
    var u_3: vec2<f32>;
    var param_163: vec2<f32>;
    var du: vec2<f32>;
    var param_164: vec2<f32>;
    var ga: vec2<f32>;
    var param_165: vec2<f32>;
    var gb: vec2<f32>;
    var param_166: vec2<f32>;
    var gc: vec2<f32>;
    var param_167: vec2<f32>;
    var gd: vec2<f32>;
    var param_168: vec2<f32>;
    var va: f32;
    var vb: f32;
    var vc: f32;
    var vd: f32;
    var k_3: f32;
    var value_1: f32;
    var deriv: vec2<f32>;

    let _e27 = (*p_15);
    i_5 = floor(_e27);
    let _e29 = (*p_15);
    f_7 = fract(_e29);
    let _e31 = f_7;
    param_163 = _e31;
    let _e32 = quinticFadevf2_((&param_163));
    u_3 = _e32;
    let _e33 = f_7;
    param_164 = _e33;
    let _e34 = quinticFadeDerivvf2_((&param_164));
    du = _e34;
    let _e35 = i_5;
    param_165 = _e35;
    let _e36 = latticeGradientvf2_((&param_165));
    ga = _e36;
    let _e37 = i_5;
    param_166 = (_e37 + vec2<f32>(1f, 0f));
    let _e39 = latticeGradientvf2_((&param_166));
    gb = _e39;
    let _e40 = i_5;
    param_167 = (_e40 + vec2<f32>(0f, 1f));
    let _e42 = latticeGradientvf2_((&param_167));
    gc = _e42;
    let _e43 = i_5;
    param_168 = (_e43 + vec2<f32>(1f, 1f));
    let _e45 = latticeGradientvf2_((&param_168));
    gd = _e45;
    let _e46 = ga;
    let _e47 = f_7;
    va = dot(_e46, _e47);
    let _e49 = gb;
    let _e50 = f_7;
    vb = dot(_e49, (_e50 - vec2<f32>(1f, 0f)));
    let _e53 = gc;
    let _e54 = f_7;
    vc = dot(_e53, (_e54 - vec2<f32>(0f, 1f)));
    let _e57 = gd;
    let _e58 = f_7;
    vd = dot(_e57, (_e58 - vec2<f32>(1f, 1f)));
    let _e61 = va;
    let _e62 = vb;
    let _e64 = vc;
    let _e66 = vd;
    k_3 = (((_e61 - _e62) - _e64) + _e66);
    let _e68 = va;
    let _e70 = u_3[0u];
    let _e71 = vb;
    let _e72 = va;
    let _e77 = u_3[1u];
    let _e78 = vc;
    let _e79 = va;
    let _e84 = u_3[0u];
    let _e86 = u_3[1u];
    let _e88 = k_3;
    value_1 = (((_e68 + (_e70 * (_e71 - _e72))) + (_e77 * (_e78 - _e79))) + ((_e84 * _e86) * _e88));
    let _e91 = ga;
    let _e93 = u_3[0u];
    let _e94 = gb;
    let _e95 = ga;
    let _e100 = u_3[1u];
    let _e101 = gc;
    let _e102 = ga;
    let _e107 = u_3[0u];
    let _e109 = u_3[1u];
    let _e111 = ga;
    let _e112 = gb;
    let _e114 = gc;
    let _e116 = gd;
    let _e120 = du;
    let _e121 = vb;
    let _e122 = va;
    let _e124 = vc;
    let _e125 = va;
    let _e128 = u_3;
    let _e130 = k_3;
    deriv = ((((_e91 + ((_e94 - _e95) * _e93)) + ((_e101 - _e102) * _e100)) + ((((_e111 - _e112) - _e114) + _e116) * (_e107 * _e109))) + (_e120 * (vec2<f32>((_e121 - _e122), (_e124 - _e125)) + (_e128.yx * _e130))));
    let _e135 = value_1;
    let _e136 = deriv;
    return vec3<f32>(_e135, _e136.x, _e136.y);
}

fn gradientNoisevf2_(p_16: ptr<function, vec2<f32>>) -> f32 {
    var param_169: vec2<f32>;

    let _e2 = (*p_16);
    param_169 = _e2;
    let _e3 = gradientNoiseDvf2_((&param_169));
    return _e3.x;
}

fn distanceFogf1f1_(t_5: ptr<function, f32>, density: ptr<function, f32>) -> f32 {
    let _e3 = (*t_5);
    let _e5 = (*density);
    return (1f - exp((-(_e3) * _e5)));
}

fn phaseHGf1f1_(mu: ptr<function, f32>, g_1: ptr<function, f32>) -> f32 {
    var g2_: f32;

    let _e8 = (*g_1);
    let _e9 = (*g_1);
    g2_ = (_e8 * _e9);
    let _e11 = g2_;
    let _e13 = g2_;
    let _e15 = (*g_1);
    let _e17 = (*mu);
    return ((1f - _e11) / (12.566371f * pow(max(((1f + _e13) - ((2f * _e15) * _e17)), 0.000001f), 1.5f)));
}

fn forwardLightvf3_(ray: ptr<function, vec3<f32>>) -> f32 {
    var param_170: f32;
    var param_171: f32;
    var param_172: f32;
    var param_173: f32;

    let _e8 = (*ray);
    let _e9 = sunlight();
    param_170 = dot(_e8, _e9);
    param_171 = 0.7f;
    let _e11 = phaseHGf1f1_((&param_170), (&param_171));
    param_172 = 1f;
    param_173 = 0.7f;
    let _e12 = phaseHGf1f1_((&param_172), (&param_173));
    return clamp((_e11 / _e12), 0f, 1f);
}

fn valleyAirvf3vf3vf3_(c_4: ptr<function, vec3<f32>>, worldPos: ptr<function, vec3<f32>>, cameraPos: ptr<function, vec3<f32>>) -> vec3<f32> {
    var delta: vec3<f32>;
    var z_6: f32;
    var ray_1: vec3<f32>;
    var forward: f32;
    var param_174: vec3<f32>;
    var ext: f32;
    var distanceVeil: f32;
    var param_175: f32;
    var param_176: f32;
    var bank: f32;
    var folds: f32;
    var param_177: vec2<f32>;
    var low_1: f32;
    var param_178: vec3<f32>;
    var param_179: vec3<f32>;
    var param_180: f32;
    var param_181: f32;
    var param_182: f32;
    var nearFactor: f32;
    var veil: f32;
    var layer: i32;
    var h_3: f32;
    var t_6: f32;
    var at_1: vec3<f32>;
    var reach: f32;
    var field: f32;
    var param_183: vec2<f32>;
    var i_6: i32;
    var bandZ: f32;
    var at_2: f32;
    var q_3: vec3<f32>;
    var drift: f32;
    var param_184: vec2<f32>;
    var density_1: f32;
    var upperMist: f32;
    var air: vec3<f32>;
    var param_185: f32;
    var tau: f32;
    var i_7: i32;
    var centre: f32;
    var halfDepth: f32;
    var start: f32;
    var finish: f32;
    var stepSize: f32;
    var j_4: i32;
    var q_4: vec3<f32>;
    var hills: f32;
    var wind: f32;
    var param_186: vec2<f32>;
    var eddy: f32;
    var param_187: vec2<f32>;
    var sheetHeight: f32;
    var altitude: f32;
    var longitudinal: f32;
    var edges: f32;
    var scatter_1: vec3<f32>;
    var param_188: vec3<f32>;
    var contactDepth: f32;
    var j_5: i32;
    var q_5: vec3<f32>;
    var locality: f32;
    var ground: f32;
    var param_189: vec2<f32>;
    var param_190: vec2<f32>;
    var belt: f32;
    var h_4: f32;
    var bankTint: vec3<f32>;
    var param_191: vec3<f32>;
    var phi_3084_: bool;
    var phi_3091_: bool;

    let _e179 = (*worldPos);
    let _e180 = (*cameraPos);
    delta = (_e179 - _e180);
    let _e182 = delta;
    z_6 = length(_e182);
    let _e184 = delta;
    let _e185 = z_6;
    ray_1 = (_e184 / vec3(max(_e185, 0.01f)));
    let _e189 = ray_1;
    param_174 = _e189;
    let _e190 = forwardLightvf3_((&param_174));
    forward = _e190;
    let _e191 = forward;
    ext = (((0.00012f + (0.0026f * pow(_e191, 2.2f))) * 0.53f) * 1.8f);
    let _e197 = z_6;
    param_175 = _e197;
    let _e198 = ext;
    param_176 = _e198;
    let _e199 = distanceFogf1f1_((&param_175), (&param_176));
    distanceVeil = _e199;
    let _e201 = (*worldPos)[1u];
    bank = exp((-(abs((_e201 - 5f))) * 0.2f));
    let _e208 = (*worldPos)[2u];
    let _e210 = (*worldPos);
    param_177 = (_e210.xz * 0.022f);
    let _e213 = gradientNoisevf2_((&param_177));
    folds = (0.61f + (0.38f * sin(((_e208 * 0.037f) + (0.48f * _e213)))));
    let _e219 = (*cameraPos);
    param_178 = _e219;
    let _e220 = ray_1;
    param_179 = _e220;
    let _e221 = z_6;
    param_180 = _e221;
    param_181 = 0.00636f;
    param_182 = 0.078f;
    let _e222 = heightFogvf3vf3f1f1f1_((&param_178), (&param_179), (&param_180), (&param_181), (&param_182));
    let _e223 = folds;
    low_1 = (_e222 * (0.42f + (0.48f * _e223)));
    let _e227 = z_6;
    nearFactor = smoothstep(150f, 360f, _e227);
    let _e229 = nearFactor;
    let _e232 = distanceVeil;
    distanceVeil = (_e232 * (0.4f + (0.6f * _e229)));
    let _e234 = distanceVeil;
    let _e235 = bank;
    let _e237 = folds;
    let _e241 = low_1;
    veil = clamp(((_e234 + (((0.34f * _e235) * _e237) * 0.53f)) + _e241), 0f, 0.93f);
    layer = 0i;
    loop {
        let _e244 = layer;
        if (_e244 < 2i) {
            let _e246 = layer;
            h_3 = select(14.3f, 5.1f, (_e246 == 0i));
            let _e250 = (*cameraPos)[1u];
            let _e251 = h_3;
            let _e254 = ray_1[1u];
            t_6 = ((_e250 - _e251) / max(0.0001f, -(_e254)));
            let _e258 = (*cameraPos);
            let _e259 = t_6;
            let _e260 = ray_1;
            at_1 = (_e258 + (_e260 * _e259));
            let _e264 = at_1[2u];
            let _e265 = layer;
            let _e269 = layer;
            reach = exp(-(pow(((_e264 - select(506f, 312f, (_e265 == 0i))) / select(82f, 65f, (_e269 == 0i))), 2f)));
            let _e276 = at_1;
            let _e279 = phase;
            param_183 = ((_e276.xz * vec2<f32>(0.028f, 0.062f)) + vec2<f32>((0.32f * sin(_e279)), 0f));
            let _e284 = gradientNoisevf2_((&param_183));
            field = (0.72f + (0.4f * _e284));
            let _e287 = reach;
            let _e289 = field;
            let _e291 = t_6;
            let _e293 = t_6;
            let _e295 = z_6;
            let _e298 = veil;
            veil = (_e298 + (((0.2809f * _e287) * _e289) * smoothstep((_e291 - 16f), (_e293 + 11f), _e295)));
            continue;
        } else {
            break;
        }
        continuing {
            let _e300 = layer;
            layer = (_e300 + 1i);
        }
    }
    i_6 = 0i;
    loop {
        let _e302 = i_6;
        if (_e302 < 2i) {
            let _e304 = i_6;
            bandZ = select(376f, 245f, (_e304 == 0i));
            let _e307 = bandZ;
            let _e309 = (*cameraPos)[2u];
            let _e312 = ray_1[2u];
            at_2 = ((_e307 - _e309) / max(0.01f, _e312));
            let _e315 = (*cameraPos);
            let _e316 = ray_1;
            let _e317 = at_2;
            q_3 = (_e315 + (_e316 * _e317));
            let _e321 = q_3[0u];
            let _e323 = phase;
            let _e327 = bandZ;
            param_184 = vec2<f32>(((_e321 * 0.026f) + (sin(_e323) * 0.19f)), (_e327 * 0.038f));
            let _e330 = gradientNoisevf2_((&param_184));
            drift = _e330;
            let _e332 = q_3[1u];
            let _e334 = drift;
            let _e337 = i_6;
            density_1 = exp(-(pow((((_e332 - 3.3f) - (2.8f * _e334)) / select(3.5f, 2.2f, (_e337 == 0i))), 2f)));
            let _e344 = density_1;
            let _e346 = drift;
            let _e350 = at_2;
            let _e352 = at_2;
            let _e354 = z_6;
            let _e357 = veil;
            veil = (_e357 + (((0.3127f * _e344) * (0.57f + (0.52f * _e346))) * smoothstep((_e350 - 12f), (_e352 + 9f), _e354)));
            continue;
        } else {
            break;
        }
        continuing {
            let _e359 = i_6;
            i_6 = (_e359 + 1i);
        }
    }
    let _e361 = veil;
    veil = min(_e361, 0.94f);
    let _e364 = (*worldPos)[1u];
    let _e370 = z_6;
    upperMist = (exp(-(pow(((_e364 - 49f) / 18f), 2f))) * smoothstep(325f, 690f, _e370));
    let _e373 = upperMist;
    let _e377 = veil;
    veil = (_e377 + (((_e373 * 0.57f) * 0.53f) * 0.87f));
    let _e379 = forward;
    param_185 = _e379;
    let _e380 = airColorf1_((&param_185));
    air = _e380;
    let _e381 = key_2();
    let _e383 = forward;
    let _e385 = upperMist;
    let _e387 = air;
    air = (_e387 + (((_e381 * 0.28f) * _e383) * _e385));
    let _e389 = (*c_4);
    let _e390 = air;
    let _e391 = veil;
    (*c_4) = mix(_e389, _e390, vec3(clamp(_e391, 0f, 0.95f)));
    tau = 0f;
    i_7 = 0i;
    loop {
        let _e395 = i_7;
        if (_e395 < 2i) {
            let _e397 = i_7;
            centre = select(745f, 485f, (_e397 == 0i));
            let _e400 = i_7;
            halfDepth = select(145f, 100f, (_e400 == 0i));
            let _e403 = centre;
            let _e404 = halfDepth;
            let _e407 = (*cameraPos)[2u];
            let _e410 = ray_1[2u];
            start = max(0f, (((_e403 - _e404) - _e407) / max(_e410, 0.01f)));
            let _e414 = z_6;
            let _e415 = centre;
            let _e416 = halfDepth;
            let _e419 = (*cameraPos)[2u];
            let _e422 = ray_1[2u];
            finish = min(_e414, (((_e415 + _e416) - _e419) / max(_e422, 0.01f)));
            let _e426 = finish;
            let _e427 = start;
            if (_e426 <= _e427) {
                continue;
            }
            let _e429 = finish;
            let _e430 = start;
            stepSize = ((_e429 - _e430) / 5f);
            j_4 = 0i;
            loop {
                let _e433 = j_4;
                if (_e433 < 5i) {
                    let _e435 = (*cameraPos);
                    let _e436 = ray_1;
                    let _e437 = start;
                    let _e438 = j_4;
                    let _e441 = stepSize;
                    q_4 = (_e435 + (_e436 * (_e437 + ((f32(_e438) + 0.5f) * _e441))));
                    let _e447 = q_4[0u];
                    let _e449 = q_4[2u];
                    hills = smoothstep(0.06f, 0.23f, (_e447 / max(1f, _e449)));
                    let _e453 = q_4;
                    let _e456 = phase;
                    param_186 = ((_e453.xz * 0.013f) + vec2<f32>((0.1f * sin(_e456)), 0f));
                    let _e461 = gradientNoisevf2_((&param_186));
                    wind = _e461;
                    let _e462 = q_4;
                    let _e465 = phase;
                    param_187 = ((_e462.xz * vec2<f32>(0.022f, 0.008f)) + vec2<f32>((0.16f * sin(_e465)), 3.7f));
                    let _e470 = gradientNoisevf2_((&param_187));
                    eddy = _e470;
                    let _e471 = i_7;
                    let _e475 = q_4[0u];
                    let _e478 = wind;
                    let _e481 = eddy;
                    sheetHeight = (((select(108f, 74f, (_e471 == 0i)) + (0.072f * _e475)) + (11f * _e478)) + (4f * _e481));
                    let _e485 = q_4[1u];
                    let _e486 = sheetHeight;
                    let _e488 = i_7;
                    altitude = ((_e485 - _e486) / select(22f, 13f, (_e488 == 0i)));
                    let _e493 = q_4[2u];
                    let _e494 = centre;
                    let _e496 = halfDepth;
                    longitudinal = ((_e493 - _e494) / _e496);
                    let _e498 = longitudinal;
                    let _e499 = longitudinal;
                    edges = max(0f, (1f - (_e498 * _e499)));
                    let _e503 = stepSize;
                    let _e504 = hills;
                    let _e506 = edges;
                    let _e508 = altitude;
                    let _e510 = altitude;
                    let _e514 = wind;
                    let _e517 = eddy;
                    let _e522 = i_7;
                    let _e526 = tau;
                    tau = (_e526 + (((((_e503 * _e504) * _e506) * exp((-(_e508) * _e510))) * max(0.15f, ((0.78f + (0.78f * _e514)) + (0.32f * _e517)))) * select(0.0068f, 0.0078f, (_e522 == 0i))));
                    continue;
                } else {
                    break;
                }
                continuing {
                    let _e528 = j_4;
                    j_4 = (_e528 + 1i);
                }
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e530 = i_7;
            i_7 = (_e530 + 1i);
        }
    }
    let _e532 = forward;
    let _e535 = ray_1[0u];
    param_188 = mix(vec3<f32>(0.495f, 0.541f, 0.685f), vec3<f32>(0.93f, 0.746f, 0.625f), vec3(clamp(((0.95f * _e532) + (0.15f * (1f - _e535))), 0f, 1f)));
    let _e542 = srgbToLinearvf3_((&param_188));
    scatter_1 = _e542;
    let _e543 = (*c_4);
    let _e544 = scatter_1;
    let _e545 = tau;
    (*c_4) = mix(_e543, _e544, vec3((1f - exp((-(_e545) * 0.53f)))));
    contactDepth = 0f;
    let _e552 = hasGround();
    phi_3084_ = _e552;
    if _e552 {
        let _e554 = (*worldPos)[2u];
        phi_3084_ = (_e554 > 355f);
    }
    let _e557 = phi_3084_;
    phi_3091_ = _e557;
    if _e557 {
        let _e559 = ray_1[0u];
        phi_3091_ = (_e559 > 0.045f);
    }
    let _e562 = phi_3091_;
    if _e562 {
        j_5 = 0i;
        loop {
            let _e563 = j_5;
            if (_e563 < 6i) {
                let _e565 = (*worldPos);
                let _e566 = ray_1;
                let _e567 = j_5;
                q_5 = (_e565 - (_e566 * (4f + (8f * f32(_e567)))));
                let _e574 = q_5[2u];
                let _e577 = q_5[2u];
                let _e582 = q_5[0u];
                let _e584 = q_5[2u];
                locality = ((smoothstep(363f, 445f, _e574) * (1f - smoothstep(965f, 1090f, _e577))) * smoothstep(0.008f, 0.145f, (_e582 / max(1f, _e584))));
                let _e589 = q_5;
                param_189 = _e589.xz;
                let _e591 = baseHeightvf2_((&param_189));
                let _e592 = q_5;
                param_190 = _e592.xz;
                let _e594 = contactAtvf2_((&param_190));
                ground = (_e591 + _e594.y);
                let _e597 = ground;
                let _e599 = ground;
                belt = (smoothstep(37f, 70f, _e597) * (1f - smoothstep(140f, 178f, _e599)));
                let _e604 = q_5[1u];
                let _e605 = ground;
                h_4 = (((_e604 - _e605) - 8f) / 18f);
                let _e609 = h_4;
                let _e611 = h_4;
                let _e615 = belt;
                let _e617 = locality;
                let _e619 = contactDepth;
                contactDepth = (_e619 + (((0.53f * exp((-(_e609) * _e611))) * _e615) * _e617));
                continue;
            } else {
                break;
            }
            continuing {
                let _e621 = j_5;
                j_5 = (_e621 + 1i);
            }
        }
    }
    let _e624 = (*worldPos)[2u];
    param_191 = mix(vec3<f32>(0.372f, 0.394f, 0.465f), vec3<f32>(0.475f, 0.495f, 0.59f), vec3(smoothstep(485f, 800f, _e624)));
    let _e628 = srgbToLinearvf3_((&param_191));
    bankTint = _e628;
    let _e629 = (*c_4);
    let _e630 = bankTint;
    let _e631 = contactDepth;
    return mix(_e629, _e630, vec3((1f - exp((-(_e631) * 0.53f)))));
}

fn cameraEye() -> vec3<f32> {
    let _e4 = truck_2;
    let _e5 = truck_2;
    let _e8 = truck_2;
    return vec3<f32>(_e4, (70f + (0.035f * _e5)), (-0.09f * _e8));
}

fn finishSlopevf3vf3_(c_5: ptr<function, vec3<f32>>, p_17: ptr<function, vec3<f32>>) -> vec3<f32> {
    var air_1: vec3<f32>;
    var param_192: vec3<f32>;
    var param_193: vec3<f32>;
    var param_194: vec3<f32>;
    var layer_1: f32;
    var west: f32;
    var param_195: vec3<f32>;
    var halo: f32;
    var param_196: vec3<f32>;

    let _e26 = cameraEye();
    let _e27 = (*c_5);
    param_192 = _e27;
    let _e28 = (*p_17);
    param_193 = _e28;
    param_194 = _e26;
    let _e29 = valleyAirvf3vf3vf3_((&param_192), (&param_193), (&param_194));
    air_1 = _e29;
    let _e31 = (*p_17)[2u];
    let _e34 = (*p_17)[2u];
    layer_1 = (smoothstep(93f, 168f, _e31) * (1f - smoothstep(232f, 365f, _e34)));
    let _e39 = (*p_17)[0u];
    let _e42 = (*p_17)[2u];
    west = smoothstep(-0.045f, 0.24f, (-(_e39) / max(1f, _e42)));
    let _e46 = air_1;
    param_195 = vec3<f32>(0.61f, 0.49f, 0.401f);
    let _e47 = srgbToLinearvf3_((&param_195));
    let _e48 = layer_1;
    let _e50 = west;
    air_1 = mix(_e46, _e47, vec3(((0.135f * _e48) * _e50)));
    let _e54 = (*p_17);
    let _e55 = cameraEye();
    let _e58 = sunlight();
    let _e64 = (*p_17)[2u];
    halo = (exp((-65f * length((normalize((_e54 - _e55)) - _e58)))) * smoothstep(480f, 850f, _e64));
    let _e67 = air_1;
    let _e68 = key_2();
    let _e70 = halo;
    param_196 = (_e67 + ((_e68 * 0.47f) * _e70));
    let _e73 = filmvf3_((&param_196));
    return _e73;
}

fn castVisibilityvf3vf3b1_(p_18: ptr<function, vec3<f32>>, sun: ptr<function, vec3<f32>>, includeGround: ptr<function, bool>) -> f32 {
    var shade: f32;
    var i_8: i32;
    var t_7: f32;
    var q_6: vec3<f32>;
    var field_1: vec4<f32>;
    var param_197: vec2<f32>;
    var solid: f32;
    var param_198: vec2<f32>;
    var penumbra: f32;
    var phi_2407_: bool;
    var phi_2415_: bool;
    var phi_2423_: bool;
    var phi_2466_: bool;

    let _e32 = (*p_18)[2u];
    let _e33 = (_e32 < 215f);
    phi_2407_ = _e33;
    if !(_e33) {
        let _e36 = (*p_18)[2u];
        phi_2407_ = (_e36 > 1100f);
    }
    let _e39 = phi_2407_;
    phi_2415_ = _e39;
    if !(_e39) {
        let _e42 = (*p_18)[0u];
        phi_2415_ = (_e42 < -155f);
    }
    let _e45 = phi_2415_;
    phi_2423_ = _e45;
    if !(_e45) {
        let _e48 = (*p_18)[0u];
        phi_2423_ = (_e48 > 930f);
    }
    let _e51 = phi_2423_;
    if _e51 {
        return 1f;
    }
    shade = 0f;
    i_8 = 0i;
    loop {
        let _e52 = i_8;
        if (_e52 < 16i) {
            let _e54 = i_8;
            t_7 = (2.8f * exp2((f32(_e54) * 0.48f)));
            let _e59 = (*p_18);
            let _e60 = (*sun);
            let _e61 = t_7;
            q_6 = (_e59 + (_e60 * _e61));
            let _e64 = q_6;
            param_197 = _e64.xz;
            let _e66 = contactAtvf2_((&param_197));
            field_1 = _e66;
            let _e68 = field_1[0u];
            solid = _e68;
            let _e69 = (*includeGround);
            phi_2466_ = _e69;
            if !(_e69) {
                let _e72 = field_1[1u];
                phi_2466_ = (_e72 > 0.1f);
            }
            let _e75 = phi_2466_;
            if _e75 {
                let _e76 = solid;
                let _e77 = q_6;
                param_198 = _e77.xz;
                let _e79 = baseHeightvf2_((&param_198));
                let _e81 = field_1[1u];
                solid = max(_e76, (_e79 + _e81));
            }
            let _e84 = t_7;
            penumbra = (0.65f + (_e84 * 0.032f));
            let _e87 = shade;
            let _e88 = penumbra;
            let _e90 = penumbra;
            let _e91 = solid;
            let _e93 = field_1[2u];
            let _e96 = q_6[1u];
            shade = max(_e87, smoothstep(-(_e88), _e90, (((_e91 + _e93) - _e96) - 1.9f)));
            continue;
        } else {
            break;
        }
        continuing {
            let _e101 = i_8;
            i_8 = (_e101 + 1i);
        }
    }
    let _e103 = shade;
    return (1f - (0.62f * _e103));
}

fn ambientLight() -> vec3<f32> {
    return vec3<f32>(0.408f, 0.4728f, 0.552f);
}

fn capvf2_(world_2: ptr<function, vec2<f32>>) -> f32 {
    var param_199: vec2<f32>;

    let _e2 = (*world_2);
    param_199 = _e2;
    let _e3 = rockSurveyvf2_((&param_199));
    return _e3.x;
}

fn fbmvf2i1f1f1_(p_19: ptr<function, vec2<f32>>, octaves: ptr<function, i32>, lacunarity: ptr<function, f32>, persistence: ptr<function, f32>) -> f32 {
    var sum: f32;
    var amp: f32;
    var norm: f32;
    var i_9: i32;
    var param_200: vec2<f32>;

    sum = 0f;
    amp = 1f;
    norm = 0f;
    i_9 = 0i;
    loop {
        let _e17 = i_9;
        if (_e17 < 12i) {
            let _e19 = i_9;
            let _e20 = (*octaves);
            if (_e19 >= _e20) {
                break;
            }
            let _e22 = amp;
            let _e23 = (*p_19);
            param_200 = _e23;
            let _e24 = gradientNoisevf2_((&param_200));
            let _e26 = sum;
            sum = (_e26 + (_e22 * _e24));
            let _e28 = amp;
            let _e29 = norm;
            norm = (_e29 + _e28);
            let _e31 = (*persistence);
            let _e32 = amp;
            amp = (_e32 * _e31);
            let _e34 = (*lacunarity);
            let _e35 = (*p_19);
            (*p_19) = (((mat2x2<f32>(vec2<f32>(0.8f, 0.6f), vec2<f32>(-0.6f, 0.8f)) * _e35) * _e34) + vec2<f32>(17.13f, -3.71f));
            continue;
        } else {
            break;
        }
        continuing {
            let _e39 = i_9;
            i_9 = (_e39 + 1i);
        }
    }
    let _e41 = sum;
    let _e43 = norm;
    return ((1.4f * _e41) / _e43);
}

fn fbmvf2i1_(p_20: ptr<function, vec2<f32>>, octaves_1: ptr<function, i32>) -> f32 {
    var param_201: vec2<f32>;
    var param_202: i32;
    var param_203: f32;
    var param_204: f32;

    let _e8 = (*p_20);
    param_201 = _e8;
    let _e9 = (*octaves_1);
    param_202 = _e9;
    param_203 = 2.01f;
    param_204 = 0.5f;
    let _e10 = fbmvf2i1f1f1_((&param_201), (&param_202), (&param_203), (&param_204));
    return _e10;
}

fn shadeCrownvf3vf3f1f1f1f1_(p_21: ptr<function, vec3<f32>>, worldNormal: ptr<function, vec3<f32>>, exposureValue: ptr<function, f32>, sunSide: ptr<function, f32>, orange: ptr<function, f32>, skyVisibility: ptr<function, f32>) -> vec3<f32> {
    var sun_1: vec3<f32>;
    var sunColor: vec3<f32>;
    var n_2: vec3<f32>;
    var exposure: f32;
    var pores: f32;
    var param_205: vec2<f32>;
    var param_206: i32;
    var visibleSky: f32;
    var wrap: f32;
    var albedo: vec3<f32>;
    var param_207: vec3<f32>;
    var visibility: f32;
    var skylight: f32;
    var c_6: vec3<f32>;
    var transmission: f32;
    var param_208: vec3<f32>;
    var param_209: vec3<f32>;

    sun_1 = vec3<f32>(-0.29431123f, 0.08785751f, 0.9516627f);
    sunColor = vec3<f32>(1.3928f, 0.7928f, 0.4764f);
    let _e56 = (*worldNormal);
    n_2 = normalize(_e56);
    let _e58 = (*exposureValue);
    exposure = clamp(_e58, 0f, 1f);
    let _e60 = (*p_21);
    let _e64 = (*p_21)[1u];
    let _e67 = (*p_21)[1u];
    param_205 = ((_e60.xz * 1.4f) + vec2<f32>((_e64 * 0.31f), (_e67 * 0.72f)));
    param_206 = 3i;
    let _e71 = fbmvf2i1_((&param_205), (&param_206));
    pores = _e71;
    let _e73 = n_2[1u];
    let _e76 = exposure;
    let _e79 = pores;
    visibleSky = clamp((((0.51f + (0.36f * _e73)) + (0.25f * _e76)) + (0.18f * _e79)), 0.13f, 1f);
    let _e83 = n_2;
    let _e84 = sun_1;
    wrap = clamp((0.39f + (0.61f * dot(_e83, _e84))), 0f, 1f);
    let _e89 = (*orange);
    param_207 = mix(vec3<f32>(0.145f, 0.245f, 0.23f), vec3<f32>(0.53f, 0.369f, 0.211f), vec3(_e89));
    let _e92 = srgbToLinearvf3_((&param_207));
    albedo = _e92;
    let _e93 = (*skyVisibility);
    visibility = _e93;
    let _e94 = visibleSky;
    let _e97 = exposure;
    skylight = ((0.28f + (0.73f * _e94)) * (0.47f + (0.53f * _e97)));
    let _e101 = albedo;
    let _e102 = skylight;
    let _e104 = sunColor;
    let _e105 = (*sunSide);
    let _e109 = wrap;
    let _e111 = visibility;
    c_6 = (_e101 * ((vec3<f32>(0.72f, 0.86f, 1.07f) * _e102) + (((_e104 * (0.19f + (0.63f * _e105))) * _e109) * _e111)));
    let _e115 = exposure;
    let _e117 = (*sunSide);
    let _e119 = wrap;
    let _e123 = visibility;
    transmission = (((smoothstep(0.32f, 0.87f, _e115) * _e117) * (0.24f + (0.76f * _e119))) * _e123);
    let _e125 = (*orange);
    param_208 = mix(vec3<f32>(0.46f, 0.34f, 0.178f), vec3<f32>(0.66f, 0.482f, 0.283f), vec3(_e125));
    let _e128 = srgbToLinearvf3_((&param_208));
    let _e129 = transmission;
    let _e131 = c_6;
    c_6 = (_e131 + (_e128 * _e129));
    let _e133 = pores;
    let _e136 = c_6;
    c_6 = (_e136 * (0.9f + (0.46f * _e133)));
    let _e138 = c_6;
    param_209 = _e138;
    let _e139 = linearToSrgbvf3_((&param_209));
    return _e139;
}

fn canopyNodevi2_(node_2: ptr<function, vec2<i32>>) -> f32 {
    var pair: vec2<i32>;
    var at_3: i32;
    var width_1: i32;

    let _e15 = (*node_2);
    (*node_2) = clamp(_e15, vec2<i32>(0i, 0i), vec2<i32>(1536i, 1536i));
    let _e17 = (*node_2);
    pair = (_e17 / vec2(2i));
    let _e21 = pair[1u];
    let _e25 = pair[0u];
    at_3 = ((1310720i + (_e21 * 769i)) + _e25);
    let _e30 = unnamed.channelSizes[1i][0u];
    width_1 = i32(_e30);
    let _e32 = at_3;
    let _e33 = width_1;
    let _e41 = at_3;
    let _e42 = width_1;
    let _e45 = textureLoad(tex1_, vec2<i32>((_e32 - (i32(floor((f32(_e32) / f32(_e33)))) * _e33)), (_e41 / _e42)), 0i);
    let _e47 = (*node_2)[0u];
    let _e56 = (*node_2)[1u];
    let _e65 = ((_e47 - (i32(floor((f32(_e47) / f32(2i)))) * 2i)) + (2i * (_e56 - (i32(floor((f32(_e56) / f32(2i)))) * 2i))));
    return select(select(select(_e45[0i], _e45[1i], (1i == _e65)), _e45[2i], (2i == _e65)), _e45[3i], (3i == _e65));
}

fn canopyHeightvf2_(world_3: ptr<function, vec2<f32>>) -> f32 {
    var at_4: vec2<f32>;
    var node_3: vec2<i32>;
    var t_8: vec2<f32>;
    var param_210: vec2<i32>;
    var param_211: vec2<i32>;
    var param_212: vec2<i32>;
    var param_213: vec2<i32>;

    let _e17 = (*world_3);
    at_4 = ((((_e17 + vec2<f32>(1100f, 40f)) * 1537f) / vec2<f32>(2200f, 1800f)) - vec2(0.5f));
    let _e23 = at_4;
    node_3 = vec2<i32>(floor(_e23));
    let _e26 = at_4;
    t_8 = fract(_e26);
    let _e28 = node_3;
    param_210 = _e28;
    let _e29 = canopyNodevi2_((&param_210));
    let _e30 = node_3;
    param_211 = (_e30 + vec2<i32>(1i, 0i));
    let _e32 = canopyNodevi2_((&param_211));
    let _e34 = t_8[0u];
    let _e36 = node_3;
    param_212 = (_e36 + vec2<i32>(0i, 1i));
    let _e38 = canopyNodevi2_((&param_212));
    let _e39 = node_3;
    param_213 = (_e39 + vec2<i32>(1i, 1i));
    let _e41 = canopyNodevi2_((&param_213));
    let _e43 = t_8[0u];
    let _e46 = t_8[1u];
    return mix(mix(_e29, _e32, _e34), mix(_e38, _e41, _e43), _e46);
}

fn skyVisibilityAtvf3_(p_22: ptr<function, vec3<f32>>) -> f32 {
    var obstruction: f32;
    var j_6: i32;
    var q_7: vec3<f32>;
    var param_214: vec2<f32>;
    var param_215: vec2<f32>;

    obstruction = 0f;
    j_6 = 0i;
    loop {
        let _e17 = j_6;
        if (_e17 < 5i) {
            let _e19 = (*p_22);
            let _e20 = sunlight();
            let _e21 = j_6;
            q_7 = (_e19 + (_e20 * (4.5f * exp2((f32(_e21) * 0.81f)))));
            let _e28 = obstruction;
            let _e29 = q_7;
            param_214 = _e29.xz;
            let _e31 = bedvf2_((&param_214));
            let _e32 = q_7;
            param_215 = _e32.xz;
            let _e34 = canopyHeightvf2_((&param_215));
            let _e37 = q_7[1u];
            obstruction = max(_e28, smoothstep(-0.25f, 3f, ((_e31 + _e34) - _e37)));
            continue;
        } else {
            break;
        }
        continuing {
            let _e41 = j_6;
            j_6 = (_e41 + 1i);
        }
    }
    let _e43 = obstruction;
    return (1f - (0.76f * _e43));
}

fn hitTrianglevf2structSampleVertexvf3vf3f1f1vf31structSampleVertexvf3vf3f1f1vf31structSampleVertexvf3vf3f1f1vf31structCrownHitf1vf3f1f1vf31_(pixel: ptr<function, vec2<f32>>, a_7: ptr<function, SampleVertex>, b_6: ptr<function, SampleVertex>, c_7: ptr<function, SampleVertex>, hit: ptr<function, CrownHit>) {
    var e: vec2<f32>;
    var f_8: vec2<f32>;
    var q_8: vec2<f32>;
    var area: f32;
    var param_216: vec2<f32>;
    var param_217: vec2<f32>;
    var w_3: vec3<f32>;
    var param_218: vec2<f32>;
    var param_219: vec2<f32>;
    var param_220: vec2<f32>;
    var param_221: vec2<f32>;
    var z_7: f32;

    let _e24 = (*b_6).pos;
    let _e27 = (*a_7).pos;
    e = (_e24.xy - _e27.xy);
    let _e31 = (*c_7).pos;
    let _e34 = (*a_7).pos;
    f_8 = (_e31.xy - _e34.xy);
    let _e37 = (*pixel);
    let _e39 = (*a_7).pos;
    q_8 = (_e37 - _e39.xy);
    let _e42 = e;
    param_216 = _e42;
    let _e43 = f_8;
    param_217 = _e43;
    let _e44 = cross2vf2vf2_((&param_216), (&param_217));
    area = _e44;
    let _e45 = area;
    if (abs(_e45) < 0.00000000001f) {
        return;
    }
    let _e48 = q_8;
    param_218 = _e48;
    let _e49 = f_8;
    param_219 = _e49;
    let _e50 = cross2vf2vf2_((&param_218), (&param_219));
    let _e51 = area;
    w_3[1u] = (_e50 / _e51);
    let _e54 = e;
    param_220 = _e54;
    let _e55 = q_8;
    param_221 = _e55;
    let _e56 = cross2vf2vf2_((&param_220), (&param_221));
    let _e57 = area;
    w_3[2u] = (_e56 / _e57);
    let _e61 = w_3[1u];
    let _e64 = w_3[2u];
    w_3[0u] = ((1f - _e61) - _e64);
    let _e68 = w_3[0u];
    let _e70 = w_3[1u];
    let _e72 = w_3[2u];
    if (min(_e68, min(_e70, _e72)) < 0f) {
        return;
    }
    let _e76 = w_3;
    let _e79 = (*a_7).pos[2u];
    let _e82 = (*b_6).pos[2u];
    let _e85 = (*c_7).pos[2u];
    z_7 = dot(_e76, vec3<f32>(_e79, _e82, _e85));
    let _e88 = z_7;
    let _e90 = (*hit).depth;
    if (_e88 >= _e90) {
        return;
    }
    let _e92 = z_7;
    let _e94 = (*a_7).normal;
    let _e96 = w_3[0u];
    let _e99 = (*b_6).normal;
    let _e101 = w_3[1u];
    let _e105 = (*c_7).normal;
    let _e107 = w_3[2u];
    let _e110 = w_3;
    let _e112 = (*a_7).exposure;
    let _e114 = (*b_6).exposure;
    let _e116 = (*c_7).exposure;
    let _e119 = w_3;
    let _e121 = (*a_7).sunSide;
    let _e123 = (*b_6).sunSide;
    let _e125 = (*c_7).sunSide;
    let _e129 = (*a_7).local;
    let _e131 = w_3[0u];
    let _e134 = (*b_6).local;
    let _e136 = w_3[1u];
    let _e140 = (*c_7).local;
    let _e142 = w_3[2u];
    (*hit) = CrownHit(_e92, (((_e94 * _e96) + (_e99 * _e101)) + (_e105 * _e107)), dot(_e110, vec3<f32>(_e112, _e114, _e116)), dot(_e119, vec3<f32>(_e121, _e123, _e125)), (((_e129 * _e131) + (_e134 * _e136)) + (_e140 * _e142)));
    return;
}

fn projectSprayi1structTreeViewi1i1i1i1f1f1f1f11_(id_4: ptr<function, i32>, v_3: ptr<function, TreeView>) -> SampleVertex {
    var address: i32;
    var local_24: i32;
    var at_5: vec2<i32>;
    var point_1: vec3<f32>;
    var radial: vec4<f32>;
    var a_8: f32;
    var rot: mat2x2<f32>;
    var offset: vec2<f32>;
    var sunSide_1: f32;
    var rn: vec2<f32>;
    var n_3: vec3<f32>;
    var local_25: vec3<f32>;

    let _e39 = (*v_3).variant;
    let _e42 = (*v_3).rings;
    if (_e42 == 19i) {
        local_24 = 0i;
    } else {
        let _e45 = (*v_3).rings;
        local_24 = select(750i, 570i, (_e45 == 12i));
    }
    let _e48 = local_24;
    let _e51 = (*id_4);
    address = ((18i * ((790i * _e39) + _e48)) + (2i * _e51));
    let _e54 = address;
    let _e62 = address;
    at_5 = vec2<i32>((_e54 - (i32(floor((f32(_e54) / f32(768i)))) * 768i)), (769i + (_e62 / 768i)));
    let _e66 = at_5;
    let _e67 = textureLoad(tex2_, _e66, 0i);
    point_1 = _e67.xyz;
    let _e69 = at_5;
    let _e71 = textureLoad(tex2_, (_e69 + vec2<i32>(1i, 0i)), 0i);
    radial = _e71;
    let _e73 = (*v_3).rotation;
    a_8 = _e73;
    let _e74 = a_8;
    let _e76 = a_8;
    let _e78 = a_8;
    let _e81 = a_8;
    rot = mat2x2<f32>(vec2<f32>(cos(_e74), sin(_e76)), vec2<f32>(-(sin(_e78)), cos(_e81)));
    let _e86 = rot;
    let _e87 = point_1;
    offset = (_e86 * _e87.xz);
    let _e90 = offset;
    sunSide_1 = smoothstep(-0.14f, 0.91f, dot(normalize((_e90 + vec2<f32>(0.0001f, 0.0001f))), vec2<f32>(-0.9159586f, 0.40127277f)));
    let _e96 = (*v_3).aspect;
    let _e98 = (*v_3).orange;
    let _e102 = offset;
    offset = (_e102 * (_e96 * (1f + (0.22f * _e98))));
    let _e104 = rot;
    let _e105 = radial;
    rn = (_e104 * _e105.xz);
    let _e109 = rn[0u];
    let _e111 = radial[1u];
    let _e114 = rn[1u];
    n_3 = normalize(vec3<f32>(_e109, (_e111 + 0.04f), _e114));
    let _e118 = offset[0u];
    let _e119 = treeBend;
    let _e121 = point_1[1u];
    let _e124 = point_1[1u];
    let _e128 = point_1[1u];
    let _e130 = offset[1u];
    local_25 = vec3<f32>((_e118 + ((_e119 * _e121) * _e124)), _e128, _e130);
    let _e132 = local_25;
    let _e134 = rayShear;
    let _e136 = offset[1u];
    let _e138 = (_e132.xy - (_e134 * _e136));
    let _e140 = offset[1u];
    let _e144 = n_3;
    let _e146 = radial[3u];
    let _e147 = sunSide_1;
    let _e148 = local_25;
    return SampleVertex(vec3<f32>(_e138.x, _e138.y, _e140), _e144, _e146, _e147, _e148);
}

fn outsideShootvf2i1structTreeViewi1i1i1i1f1f1f1f11_(pixel_1: ptr<function, vec2<f32>>, index: ptr<function, i32>, v_4: ptr<function, TreeView>) -> bool {
    var slot: i32;
    var at_6: vec2<i32>;
    var low_2: vec3<f32>;
    var high: vec3<f32>;
    var center_2: vec3<f32>;
    var halfSize: vec3<f32>;
    var sn: f32;
    var cs: f32;
    var scale_1: f32;
    var xAxis: vec2<f32>;
    var yAxis: vec2<f32>;
    var mid_1: vec2<f32>;
    var radius_1: vec2<f32>;

    let _e30 = (*index);
    slot = (_e30 * 2i);
    let _e32 = slot;
    let _e40 = slot;
    at_6 = vec2<i32>((_e32 - (i32(floor((f32(_e32) / f32(768i)))) * 768i)), (825i + (_e40 / 768i)));
    let _e44 = at_6;
    let _e45 = textureLoad(tex2_, _e44, 0i);
    low_2 = _e45.xyz;
    let _e47 = at_6;
    let _e49 = textureLoad(tex2_, (_e47 + vec2<i32>(1i, 0i)), 0i);
    high = _e49.xyz;
    let _e51 = low_2;
    let _e52 = high;
    center_2 = ((_e51 + _e52) * 0.5f);
    let _e55 = high;
    let _e56 = low_2;
    halfSize = ((_e55 - _e56) * 0.5f);
    let _e60 = (*v_4).rotation;
    sn = sin(_e60);
    let _e63 = (*v_4).rotation;
    cs = cos(_e63);
    let _e66 = (*v_4).aspect;
    let _e68 = (*v_4).orange;
    scale_1 = (_e66 * (1f + (0.22f * _e68)));
    let _e72 = scale_1;
    let _e73 = cs;
    let _e74 = sn;
    let _e78 = rayShear[0u];
    let _e79 = sn;
    let _e80 = cs;
    xAxis = ((vec2<f32>(_e73, -(_e74)) - (vec2<f32>(_e79, _e80) * _e78)) * _e72);
    let _e85 = scale_1;
    let _e88 = rayShear[1u];
    let _e90 = sn;
    let _e91 = cs;
    yAxis = (vec2<f32>(_e90, _e91) * (-(_e85) * _e88));
    let _e94 = xAxis;
    let _e95 = center_2;
    let _e99 = center_2[1u];
    let _e100 = yAxis;
    let _e101 = center_2;
    mid_1 = vec2<f32>(dot(_e94, _e95.xz), (_e99 + dot(_e100, _e101.xz)));
    let _e106 = xAxis;
    let _e108 = halfSize;
    let _e112 = halfSize[1u];
    let _e113 = yAxis;
    let _e115 = halfSize;
    radius_1 = vec2<f32>(dot(abs(_e106), _e108.xz), (_e112 + dot(abs(_e113), _e115.xz)));
    let _e120 = treeBend;
    let _e123 = low_2[1u];
    let _e125 = low_2[1u];
    let _e128 = high[1u];
    let _e130 = high[1u];
    let _e135 = radius_1[0u];
    radius_1[0u] = (_e135 + (abs(_e120) * max((_e123 * _e125), (_e128 * _e130))));
    let _e138 = (*pixel_1);
    let _e139 = mid_1;
    let _e142 = radius_1;
    return any((abs((_e138 - _e139)) > (_e142 + vec2<f32>(0.00002f, 0.00002f))));
}

fn hitCrownvf2structTreeViewi1i1i1i1f1f1f1f11structCrownHitf1vf3f1f1vf31_(pixel_2: ptr<function, vec2<f32>>, v_5: ptr<function, TreeView>, hit_1: ptr<function, CrownHit>) -> bool {
    var tier_1: i32;
    var t_9: f32;
    var axis_1: f32;
    var maxReach: f32;
    var arm_2: i32;
    var shoot_1: i32;
    var start_1: i32;
    var index_1: i32;
    var local_26: i32;
    var param_222: vec2<f32>;
    var param_223: i32;
    var param_224: TreeView;
    var lo_2: vec2<f32>;
    var hi_2: vec2<f32>;
    var j_7: i32;
    var k_4: i32;
    var id_5: i32;
    var pt: SampleVertex;
    var param_225: i32;
    var param_226: TreeView;
    var verts: array<SampleVertex, 9>;
    var j_8: i32;
    var k_5: i32;
    var a_9: i32;
    var b_7: i32;
    var param_227: vec2<f32>;
    var param_228: SampleVertex;
    var param_229: SampleVertex;
    var param_230: SampleVertex;
    var param_231: CrownHit;
    var param_232: vec2<f32>;
    var param_233: SampleVertex;
    var param_234: SampleVertex;
    var param_235: SampleVertex;
    var param_236: CrownHit;
    var phi_1101_: bool;
    var phi_1110_: bool;
    var phi_1184_: bool;
    var phi_1207_: bool;
    var phi_1358_: bool;

    (*hit_1) = CrownHit(2f, vec3<f32>(0f, 0f, 0f), 0f, 0f, vec3<f32>(0f, 0f, 0f));
    let _e74 = (*pixel_2)[1u];
    let _e75 = (_e74 < -0.12f);
    phi_1101_ = _e75;
    if !(_e75) {
        let _e78 = (*pixel_2)[1u];
        phi_1101_ = (_e78 > 1.05f);
    }
    let _e81 = phi_1101_;
    phi_1110_ = _e81;
    if !(_e81) {
        let _e84 = (*pixel_2)[0u];
        phi_1110_ = (abs(_e84) > 0.4f);
    }
    let _e88 = phi_1110_;
    if _e88 {
        return false;
    }
    tier_1 = 0i;
    loop {
        let _e89 = tier_1;
        if (_e89 < 19i) {
            let _e91 = tier_1;
            let _e93 = (*v_5).rings;
            if (_e91 >= _e93) {
                break;
            }
            let _e95 = tier_1;
            let _e99 = (*v_5).rings;
            t_9 = ((f32(_e95) + 0.37f) / f32(_e99));
            let _e102 = t_9;
            axis_1 = (0.1f + (0.87f * _e102));
            let _e105 = t_9;
            maxReach = ((0.17f * pow((1f - _e105), 0.74f)) * 1.28f);
            let _e111 = (*pixel_2)[0u];
            let _e113 = maxReach;
            let _e115 = (abs(_e111) > (_e113 * 2.2f));
            phi_1184_ = _e115;
            if !(_e115) {
                let _e118 = (*pixel_2)[1u];
                let _e119 = axis_1;
                let _e121 = (*v_5).rings;
                let _e125 = maxReach;
                let _e127 = (*v_5).tilt;
                phi_1184_ = (_e118 > ((_e119 + (0.41f / f32(_e121))) + (_e125 * (0.45f + (0.5f * abs(_e127))))));
            }
            let _e135 = phi_1184_;
            phi_1207_ = _e135;
            if !(_e135) {
                let _e138 = (*pixel_2)[1u];
                let _e139 = axis_1;
                let _e141 = (*v_5).rings;
                let _e145 = maxReach;
                let _e147 = (*v_5).tilt;
                phi_1207_ = (_e138 < ((_e139 - (0.41f / f32(_e141))) - (_e145 * (0.98f + (1.7f * abs(_e147))))));
            }
            let _e155 = phi_1207_;
            if _e155 {
                continue;
            }
            arm_2 = 0i;
            loop {
                let _e156 = arm_2;
                if (_e156 < 6i) {
                    let _e158 = arm_2;
                    let _e160 = (*v_5).arms;
                    if (_e158 >= _e160) {
                        break;
                    }
                    shoot_1 = 0i;
                    loop {
                        let _e162 = shoot_1;
                        if (_e162 < 5i) {
                            let _e164 = shoot_1;
                            let _e166 = (*v_5).shoots;
                            if (_e164 >= _e166) {
                                break;
                            }
                            let _e168 = tier_1;
                            let _e170 = (*v_5).arms;
                            let _e172 = arm_2;
                            let _e175 = (*v_5).shoots;
                            let _e177 = shoot_1;
                            start_1 = (((((_e168 * _e170) + _e172) * _e175) + _e177) * 36i);
                            let _e181 = (*v_5).variant;
                            let _e184 = (*v_5).rings;
                            if (_e184 == 19i) {
                                local_26 = 0i;
                            } else {
                                let _e187 = (*v_5).rings;
                                local_26 = select(750i, 570i, (_e187 == 12i));
                            }
                            let _e190 = local_26;
                            let _e192 = start_1;
                            index_1 = (((790i * _e181) + _e190) + (_e192 / 36i));
                            let _e195 = (*pixel_2);
                            param_222 = _e195;
                            let _e196 = index_1;
                            param_223 = _e196;
                            let _e197 = (*v_5);
                            param_224 = _e197;
                            let _e198 = outsideShootvf2i1structTreeViewi1i1i1i1f1f1f1f11_((&param_222), (&param_223), (&param_224));
                            if _e198 {
                                continue;
                            }
                            lo_2 = vec2<f32>(9f, 9f);
                            hi_2 = vec2<f32>(-9f, -9f);
                            j_7 = 0i;
                            loop {
                                let _e199 = j_7;
                                if (_e199 < 3i) {
                                    k_4 = 0i;
                                    loop {
                                        let _e201 = k_4;
                                        if (_e201 < 3i) {
                                            let _e203 = start_1;
                                            let _e206 = j_7;
                                            let _e209 = k_4;
                                            id_5 = ((((_e203 / 36i) * 9i) + (_e206 * 3i)) + _e209);
                                            let _e211 = id_5;
                                            param_225 = _e211;
                                            let _e212 = (*v_5);
                                            param_226 = _e212;
                                            let _e213 = projectSprayi1structTreeViewi1i1i1i1f1f1f1f11_((&param_225), (&param_226));
                                            pt = _e213;
                                            let _e214 = j_7;
                                            let _e216 = k_4;
                                            let _e218 = pt;
                                            verts[((3i * _e214) + _e216)] = _e218;
                                            let _e220 = lo_2;
                                            let _e222 = pt.pos;
                                            lo_2 = min(_e220, _e222.xy);
                                            let _e225 = hi_2;
                                            let _e227 = pt.pos;
                                            hi_2 = max(_e225, _e227.xy);
                                            continue;
                                        } else {
                                            break;
                                        }
                                        continuing {
                                            let _e230 = k_4;
                                            k_4 = (_e230 + 1i);
                                        }
                                    }
                                    continue;
                                } else {
                                    break;
                                }
                                continuing {
                                    let _e232 = j_7;
                                    j_7 = (_e232 + 1i);
                                }
                            }
                            let _e234 = (*pixel_2);
                            let _e235 = lo_2;
                            let _e237 = any((_e234 < _e235));
                            phi_1358_ = _e237;
                            if !(_e237) {
                                let _e239 = (*pixel_2);
                                let _e240 = hi_2;
                                phi_1358_ = any((_e239 > _e240));
                            }
                            let _e244 = phi_1358_;
                            if _e244 {
                                continue;
                            }
                            j_8 = 0i;
                            loop {
                                let _e245 = j_8;
                                if (_e245 < 2i) {
                                    k_5 = 0i;
                                    loop {
                                        let _e247 = k_5;
                                        if (_e247 < 3i) {
                                            let _e249 = j_8;
                                            let _e251 = k_5;
                                            a_9 = ((3i * _e249) + _e251);
                                            let _e253 = j_8;
                                            let _e255 = k_5;
                                            let _e256 = (_e255 + 1i);
                                            b_7 = ((3i * _e253) + (_e256 - (i32(floor((f32(_e256) / f32(3i)))) * 3i)));
                                            let _e265 = a_9;
                                            let _e266 = b_7;
                                            let _e267 = a_9;
                                            let _e269 = (*pixel_2);
                                            param_227 = _e269;
                                            let _e271 = verts[_e265];
                                            param_228 = _e271;
                                            let _e273 = verts[_e266];
                                            param_229 = _e273;
                                            let _e275 = verts[(_e267 + 3i)];
                                            param_230 = _e275;
                                            let _e276 = (*hit_1);
                                            param_231 = _e276;
                                            hitTrianglevf2structSampleVertexvf3vf3f1f1vf31structSampleVertexvf3vf3f1f1vf31structSampleVertexvf3vf3f1f1vf31structCrownHitf1vf3f1f1vf31_((&param_227), (&param_228), (&param_229), (&param_230), (&param_231));
                                            let _e277 = param_231;
                                            (*hit_1) = _e277;
                                            let _e278 = b_7;
                                            let _e279 = b_7;
                                            let _e281 = a_9;
                                            let _e283 = (*pixel_2);
                                            param_232 = _e283;
                                            let _e285 = verts[_e278];
                                            param_233 = _e285;
                                            let _e287 = verts[(_e279 + 3i)];
                                            param_234 = _e287;
                                            let _e289 = verts[(_e281 + 3i)];
                                            param_235 = _e289;
                                            let _e290 = (*hit_1);
                                            param_236 = _e290;
                                            hitTrianglevf2structSampleVertexvf3vf3f1f1vf31structSampleVertexvf3vf3f1f1vf31structSampleVertexvf3vf3f1f1vf31structCrownHitf1vf3f1f1vf31_((&param_232), (&param_233), (&param_234), (&param_235), (&param_236));
                                            let _e291 = param_236;
                                            (*hit_1) = _e291;
                                            continue;
                                        } else {
                                            break;
                                        }
                                        continuing {
                                            let _e292 = k_5;
                                            k_5 = (_e292 + 1i);
                                        }
                                    }
                                    continue;
                                } else {
                                    break;
                                }
                                continuing {
                                    let _e294 = j_8;
                                    j_8 = (_e294 + 1i);
                                }
                            }
                            continue;
                        } else {
                            break;
                        }
                        continuing {
                            let _e296 = shoot_1;
                            shoot_1 = (_e296 + 1i);
                        }
                    }
                    continue;
                } else {
                    break;
                }
                continuing {
                    let _e298 = arm_2;
                    arm_2 = (_e298 + 1i);
                }
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e300 = tier_1;
            tier_1 = (_e300 + 1i);
        }
    }
    let _e303 = (*hit_1).depth;
    return (_e303 < 1f);
}

fn designi1i1f1f1f1f1_(lod: ptr<function, i32>, variant: ptr<function, i32>, angle_3: ptr<function, f32>, orange_1: ptr<function, f32>, aspect: ptr<function, f32>, tilt: ptr<function, f32>) -> TreeView {
    var local_27: i32;
    var local_28: i32;

    let _e16 = (*lod);
    if (_e16 == 0i) {
        local_27 = 19i;
    } else {
        let _e18 = (*lod);
        local_27 = select(8i, 12i, (_e18 == 1i));
    }
    let _e21 = local_27;
    let _e22 = (*lod);
    let _e25 = (*lod);
    if (_e25 == 0i) {
        local_28 = 5i;
    } else {
        let _e27 = (*lod);
        local_28 = select(1i, 3i, (_e27 == 1i));
    }
    let _e30 = local_28;
    let _e31 = (*variant);
    let _e32 = (*angle_3);
    let _e33 = (*orange_1);
    let _e34 = (*aspect);
    let _e35 = (*tilt);
    return TreeView(_e21, select(5i, 6i, (_e22 == 0i)), _e30, _e31, _e32, _e33, _e34, _e35);
}

fn treeLevelf1_(z_8: ptr<function, f32>) -> i32 {
    var local_29: i32;

    let _e7 = (*z_8);
    if (_e7 < 200f) {
        local_29 = 0i;
    } else {
        let _e9 = (*z_8);
        local_29 = select(2i, 1i, (_e9 < 410f));
    }
    let _e12 = local_29;
    return _e12;
}

fn isLarchvf4_(r_3: ptr<function, vec4<f32>>) -> f32 {
    let _e5 = (*r_3)[3u];
    let _e7 = i32((_e5 / 256f));
    return f32((_e7 - (i32(floor((f32(_e7) / f32(2i)))) * 2i)));
}

fn treeStylevf4_(r_4: ptr<function, vec4<f32>>) -> i32 {
    let _e5 = (*r_4)[3u];
    let _e7 = i32((_e5 / 32f));
    return (_e7 - (i32(floor((f32(_e7) / f32(8i)))) * 8i));
}

fn treeHeightvf4_(r_5: ptr<function, vec4<f32>>) -> f32 {
    let _e4 = (*r_5)[3u];
    return (fract((_e4 / 32f)) * 32f);
}

fn testTreevf4vf3vf3b1structForestHitf1vf31_(r_6: ptr<function, vec4<f32>>, ro_1: ptr<function, vec3<f32>>, rd_1: ptr<function, vec3<f32>>, mirrored: ptr<function, bool>, best: ptr<function, ForestHit>) {
    var h_5: f32;
    var param_237: vec4<f32>;
    var style: i32;
    var param_238: vec4<f32>;
    var orange_2: f32;
    var param_239: vec4<f32>;
    var level_4: i32;
    var param_240: f32;
    var rotation: f32;
    var width_2: f32;
    var z_9: f32;
    var local_30: vec3<f32>;
    var xy: vec2<f32>;
    var wind_1: f32;
    var v_6: TreeView;
    var param_241: i32;
    var param_242: i32;
    var param_243: f32;
    var param_244: f32;
    var param_245: f32;
    var param_246: f32;
    var hit_2: CrownHit;
    var param_247: vec2<f32>;
    var param_248: TreeView;
    var param_249: CrownHit;
    var tz: f32;
    var normal: vec3<f32>;
    var sunSide_2: f32;
    var worldPos_1: vec3<f32>;
    var c_8: vec3<f32>;
    var param_250: vec3<f32>;
    var param_251: vec3<f32>;
    var param_252: vec3<f32>;
    var param_253: f32;
    var param_254: f32;
    var param_255: f32;
    var param_256: f32;
    var param_257: vec3<f32>;
    var nearW: f32;
    var shelf: f32;
    var param_258: vec2<f32>;
    var param_259: vec3<f32>;
    var param_260: vec3<f32>;
    var param_261: bool;
    var param_262: vec3<f32>;
    var param_263: vec3<f32>;
    var phi_7267_: bool;
    var phi_7275_: bool;

    let _e93 = (*r_6);
    param_237 = _e93;
    let _e94 = treeHeightvf4_((&param_237));
    h_5 = _e94;
    let _e95 = (*r_6);
    param_238 = _e95;
    let _e96 = treeStylevf4_((&param_238));
    style = _e96;
    let _e97 = (*r_6);
    param_239 = _e97;
    let _e98 = isLarchvf4_((&param_239));
    orange_2 = _e98;
    let _e100 = (*r_6)[2u];
    param_240 = _e100;
    let _e101 = treeLevelf1_((&param_240));
    level_4 = _e101;
    let _e103 = (*r_6)[0u];
    let _e106 = (*r_6)[2u];
    rotation = ((_e103 * 3.17f) + (_e106 * 0.71f));
    let _e109 = style;
    let _e113 = orange_2;
    width_2 = ((0.88f + (0.055f * f32(_e109))) * (1f + (0.22f * _e113)));
    let _e118 = (*r_6)[2u];
    let _e120 = (*ro_1)[2u];
    z_9 = (_e118 - _e120);
    let _e122 = z_9;
    let _e123 = h_5;
    let _e127 = (*best).z;
    if ((_e122 - (0.33f * _e123)) > _e127) {
        return;
    }
    let _e129 = (*ro_1);
    let _e130 = (*rd_1);
    let _e131 = z_9;
    let _e134 = (*r_6);
    let _e137 = h_5;
    local_30 = (((_e129 + (_e130 * _e131)) - _e134.xyz) / vec3(_e137));
    let _e140 = local_30;
    xy = _e140.xy;
    let _e143 = xy[1u];
    let _e144 = (_e143 < -0.14f);
    phi_7267_ = _e144;
    if !(_e144) {
        let _e147 = xy[1u];
        phi_7267_ = (_e147 > 1.05f);
    }
    let _e150 = phi_7267_;
    phi_7275_ = _e150;
    if !(_e150) {
        let _e153 = xy[0u];
        phi_7275_ = (abs(_e153) > 0.45f);
    }
    let _e157 = phi_7275_;
    if _e157 {
        return;
    }
    let _e158 = phase;
    let _e160 = (*r_6)[0u];
    let _e164 = (*r_6)[2u];
    let _e168 = phase;
    let _e171 = (*r_6)[2u];
    wind_1 = (((sin(((_e158 + (_e160 * 0.08f)) + (_e164 * 0.037f))) + (0.4f * sin(((2f * _e168) + (_e171 * 0.13f))))) * 0.45f) * 0.015f);
    let _e179 = style;
    let _e187 = style;
    let _e192 = (*rd_1)[1u];
    let _e194 = level_4;
    param_241 = _e194;
    param_242 = (_e179 - (i32(floor((f32(_e179) / f32(3i)))) * 3i));
    let _e195 = rotation;
    param_243 = _e195;
    let _e196 = orange_2;
    param_244 = _e196;
    param_245 = (0.88f + (0.055f * f32(_e187)));
    param_246 = -(_e192);
    let _e197 = designi1i1f1f1f1f1_((&param_241), (&param_242), (&param_243), (&param_244), (&param_245), (&param_246));
    v_6 = _e197;
    let _e198 = (*rd_1);
    rayShear = _e198.xy;
    let _e200 = wind_1;
    treeBend = _e200;
    let _e201 = local_30;
    param_247 = _e201.xy;
    let _e203 = v_6;
    param_248 = _e203;
    let _e204 = hitCrownvf2structTreeViewi1i1i1i1f1f1f1f11structCrownHitf1vf3f1f1vf31_((&param_247), (&param_248), (&param_249));
    let _e205 = param_249;
    hit_2 = _e205;
    if !(_e204) {
        return;
    }
    let _e207 = z_9;
    let _e208 = h_5;
    let _e210 = hit_2.depth;
    tz = (_e207 + (_e208 * _e210));
    let _e213 = tz;
    let _e215 = (*best).z;
    if (_e213 >= _e215) {
        return;
    }
    let _e218 = hit_2.normal;
    normal = _e218;
    let _e220 = hit_2.sunSide;
    sunSide_2 = _e220;
    let _e221 = (*ro_1);
    let _e222 = (*rd_1);
    let _e223 = tz;
    worldPos_1 = (_e221 + (_e222 * _e223));
    let _e226 = worldPos_1;
    param_250 = _e226;
    let _e227 = skyVisibilityAtvf3_((&param_250));
    let _e228 = worldPos_1;
    param_251 = _e228;
    let _e229 = normal;
    param_252 = _e229;
    let _e231 = hit_2.exposure;
    param_253 = _e231;
    let _e232 = sunSide_2;
    param_254 = _e232;
    let _e233 = orange_2;
    param_255 = _e233;
    param_256 = _e227;
    let _e234 = shadeCrownvf3vf3f1f1f1f1_((&param_251), (&param_252), (&param_253), (&param_254), (&param_255), (&param_256));
    c_8 = _e234;
    let _e235 = c_8;
    param_257 = _e235;
    let _e236 = srgbToLinearvf3_((&param_257));
    c_8 = _e236;
    let _e238 = worldPos_1[2u];
    let _e242 = worldPos_1[0u];
    let _e245 = worldPos_1[2u];
    nearW = ((1f - smoothstep(125f, 206f, _e238)) * smoothstep(-0.08f, 0.12f, (-(_e242) / max(1f, _e245))));
    let _e250 = nearW;
    let _e251 = orange_2;
    let _e256 = c_8;
    c_8 = (_e256 * mix(vec3<f32>(1f, 1f, 1f), vec3<f32>(0.83f, 1f, 0.77f), vec3((_e250 * (1f - _e251)))));
    let _e259 = (*r_6)[2u];
    let _e262 = (*r_6)[2u];
    let _e266 = (*r_6);
    param_258 = _e266.xz;
    let _e268 = capvf2_((&param_258));
    let _e272 = (*r_6)[1u];
    shelf = (((smoothstep(472f, 505f, _e259) * (1f - smoothstep(598f, 637f, _e262))) * smoothstep(100f, 132f, _e268)) * smoothstep(118f, 139f, _e272));
    let _e275 = shelf;
    let _e276 = ambientLight();
    let _e278 = key_2();
    let _e280 = sunSide_2;
    let _e283 = hit_2.exposure;
    let _e289 = c_8;
    c_8 = (_e289 + (((_e276 * vec3<f32>(0.075f, 0.083f, 0.058f)) + (((_e278 * vec3<f32>(0.095f, 0.07f, 0.027f)) * _e280) * (0.24f + (0.76f * _e283)))) * _e275));
    let _e291 = c_8;
    let _e292 = worldPos_1;
    let _e293 = normal;
    let _e296 = sunlight();
    param_259 = (_e292 + (_e293 * 1.2f));
    param_260 = _e296;
    param_261 = false;
    let _e297 = castVisibilityvf3vf3b1_((&param_259), (&param_260), (&param_261));
    param_262 = (_e291 * _e297);
    let _e299 = worldPos_1;
    param_263 = _e299;
    let _e300 = finishSlopevf3vf3_((&param_262), (&param_263));
    c_8 = _e300;
    let _e301 = tz;
    let _e302 = c_8;
    (*best) = ForestHit(_e301, _e302);
    return;
}

fn sortAddressi1b1_(i_10: ptr<function, i32>, mirrorView: ptr<function, bool>) -> vec2<i32> {
    var linear: i32;

    let _e8 = (*i_10);
    let _e9 = (*mirrorView);
    linear = (_e8 + select(0i, 262144i, _e9));
    let _e12 = linear;
    let _e16 = unnamed.channelSizes[1i][0u];
    let _e17 = i32(_e16);
    let _e25 = linear;
    let _e29 = unnamed.channelSizes[1i][0u];
    return vec2<i32>((_e12 - (i32(floor((f32(_e12) / f32(_e17)))) * _e17)), (_e25 / i32(_e29)));
}

fn tileSizei1_(level_5: ptr<function, i32>) -> vec2<f32> {
    var local_31: vec2<f32>;

    let _e7 = (*level_5);
    if (_e7 == 0i) {
        local_31 = vec2<f32>(96f, 256f);
    } else {
        let _e9 = (*level_5);
        local_31 = select(vec2<f32>(32f, 64f), vec2<f32>(64f, 128f), vec2((_e9 == 1i)));
    }
    let _e13 = local_31;
    return _e13;
}

fn tileKeyvf2i1_(pix: ptr<function, vec2<f32>>, level_6: ptr<function, i32>) -> i32 {
    var cell_6: vec2<i32>;
    var param_264: i32;

    let _e11 = (*pix);
    let _e12 = (*level_6);
    param_264 = _e12;
    let _e13 = tileSizei1_((&param_264));
    cell_6 = (vec2<i32>(floor((_e11 / _e13))) + vec2<i32>(20i, 24i));
    let _e18 = (*level_6);
    let _e21 = cell_6[1u];
    let _e26 = cell_6[0u];
    return (((_e18 * 65536i) + (clamp(_e21, 0i, 255i) * 256i)) + clamp(_e26, 0i, 255i));
}

fn rootKeyvf4b1_(root_1: ptr<function, vec4<f32>>, mirrorView_1: ptr<function, bool>) -> i32 {
    var xy_1: vec2<f32>;
    var param_265: vec4<f32>;
    var param_266: f32;
    var param_267: vec2<f32>;
    var param_268: i32;

    let _e20 = (*root_1)[2u];
    if (_e20 <= 0f) {
        return 999999i;
    }
    let _e23 = (*root_1)[0u];
    let _e26 = (*root_1)[2u];
    let _e29 = (*mirrorView_1);
    let _e32 = (*root_1)[1u];
    let _e33 = (*root_1);
    param_265 = _e33;
    let _e34 = treeHeightvf4_((&param_265));
    let _e41 = (*root_1)[2u];
    xy_1 = vec2<f32>((960f + ((_e23 * 1404f) / _e26)), (464.4f + (((70f - (select(1f, -1f, _e29) * (_e32 + (0.5f * _e34)))) * 1404f) / _e41)));
    let _e46 = (*root_1)[2u];
    param_266 = _e46;
    let _e47 = treeLevelf1_((&param_266));
    let _e48 = xy_1;
    param_267 = _e48;
    param_268 = _e47;
    let _e49 = tileKeyvf2i1_((&param_267), (&param_268));
    return _e49;
}

fn bucketStarti1b1_(key_3: ptr<function, i32>, mirrored_1: ptr<function, bool>) -> i32 {
    var lo_3: i32;
    var hi_3: i32;
    var j_9: i32;
    var mid_2: i32;
    var param_269: i32;
    var param_270: bool;
    var param_271: vec4<f32>;
    var param_272: bool;

    lo_3 = 0i;
    hi_3 = 262144i;
    j_9 = 0i;
    loop {
        let _e16 = j_9;
        if (_e16 < 19i) {
            let _e18 = lo_3;
            let _e19 = hi_3;
            if (_e18 >= _e19) {
                break;
            }
            let _e21 = lo_3;
            let _e22 = hi_3;
            mid_2 = ((_e21 + _e22) / 2i);
            let _e25 = mid_2;
            param_269 = _e25;
            let _e26 = (*mirrored_1);
            param_270 = _e26;
            let _e27 = sortAddressi1b1_((&param_269), (&param_270));
            let _e28 = textureLoad(tex1_, _e27, 0i);
            param_271 = _e28;
            let _e29 = (*mirrored_1);
            param_272 = _e29;
            let _e30 = rootKeyvf4b1_((&param_271), (&param_272));
            let _e31 = (*key_3);
            if (_e30 < _e31) {
                let _e33 = mid_2;
                lo_3 = (_e33 + 1i);
            } else {
                let _e35 = mid_2;
                hi_3 = _e35;
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e36 = j_9;
            j_9 = (_e36 + 1i);
        }
    }
    let _e38 = lo_3;
    return _e38;
}

fn treeRangei1b1_(key_4: ptr<function, i32>, mirrored_2: ptr<function, bool>) -> vec2<i32> {
    var y_6: i32;
    var x_6: i32;
    var width_3: i32;
    var slot_1: i32;
    var entry: vec4<f32>;
    var param_273: i32;
    var param_274: bool;
    var param_275: i32;
    var param_276: bool;
    var phi_6959_: bool;

    let _e25 = (*key_4);
    let _e26 = (_e25 / 256i);
    y_6 = (_e26 - (i32(floor((f32(_e26) / f32(256i)))) * 256i));
    let _e34 = (*key_4);
    x_6 = (_e34 - (i32(floor((f32(_e34) / f32(256i)))) * 256i));
    let _e45 = unnamed.channelSizes[1i][0u];
    width_3 = i32(_e45);
    let _e47 = (*mirrored_2);
    let _e49 = (*key_4);
    let _e54 = y_6;
    let _e57 = x_6;
    slot_1 = (((1902081i + ((select(0i, 3i, _e47) + (_e49 / 65536i)) * 4096i)) + (_e54 * 64i)) + _e57);
    let _e59 = x_6;
    let _e61 = y_6;
    let _e63 = ((_e59 < 64i) && (_e61 < 64i));
    phi_6959_ = _e63;
    if _e63 {
        let _e64 = slot_1;
        let _e65 = width_3;
        let _e69 = unnamed.channelSizes[1i][1u];
        phi_6959_ = (_e64 < (_e65 * i32(_e69)));
    }
    let _e74 = phi_6959_;
    if _e74 {
        let _e75 = slot_1;
        let _e76 = width_3;
        let _e84 = slot_1;
        let _e85 = width_3;
        let _e88 = textureLoad(tex1_, vec2<i32>((_e75 - (i32(floor((f32(_e75) / f32(_e76)))) * _e76)), (_e84 / _e85)), 0i);
        entry = _e88;
        let _e90 = entry[3u];
        if (_e90 == 1f) {
            let _e92 = entry;
            return vec2<i32>(_e92.xy);
        }
    }
    let _e95 = (*key_4);
    param_273 = _e95;
    let _e96 = (*mirrored_2);
    param_274 = _e96;
    let _e97 = bucketStarti1b1_((&param_273), (&param_274));
    let _e98 = (*key_4);
    param_275 = (_e98 + 1i);
    let _e100 = (*mirrored_2);
    param_276 = _e100;
    let _e101 = bucketStarti1b1_((&param_275), (&param_276));
    return vec2<i32>(_e97, _e101);
}

fn treeLayervf3f1vf3vf3b1f1_(back: ptr<function, vec3<f32>>, limit: ptr<function, f32>, ro_2: ptr<function, vec3<f32>>, rd_2: ptr<function, vec3<f32>>, mirrored_3: ptr<function, bool>, nearest: ptr<function, f32>) -> vec3<f32> {
    var best_1: ForestHit;
    var pixel_3: vec2<f32>;
    var local_32: f32;
    var level_7: i32;
    var tile_2: vec2<f32>;
    var param_277: i32;
    var dy: i32;
    var dx: i32;
    var key_5: i32;
    var param_278: vec2<f32>;
    var param_279: i32;
    var range_1: vec2<i32>;
    var param_280: i32;
    var param_281: bool;
    var start_2: i32;
    var i_11: i32;
    var r_7: vec4<f32>;
    var param_282: i32;
    var param_283: bool;
    var param_284: vec4<f32>;
    var param_285: vec3<f32>;
    var param_286: vec3<f32>;
    var param_287: bool;
    var param_288: ForestHit;
    var phi_7513_: bool;
    var phi_7525_: bool;

    let _e44 = (*limit);
    let _e45 = (*back);
    best_1 = ForestHit(_e44, _e45);
    let _e48 = (*rd_2)[0u];
    let _e51 = (*mirrored_3);
    if _e51 {
        let _e53 = (*rd_2)[1u];
        local_32 = _e53;
    } else {
        let _e55 = (*rd_2)[1u];
        local_32 = -(_e55);
    }
    let _e57 = local_32;
    pixel_3 = vec2<f32>((960f + (_e48 * 1404f)), (464.4f + (_e57 * 1404f)));
    level_7 = 0i;
    loop {
        let _e61 = level_7;
        if (_e61 < 3i) {
            let _e63 = level_7;
            let _e64 = (_e63 == 1i);
            phi_7513_ = _e64;
            if _e64 {
                let _e66 = best_1.z;
                phi_7513_ = (_e66 < 185f);
            }
            let _e69 = phi_7513_;
            if _e69 {
                break;
            }
            let _e70 = level_7;
            let _e71 = (_e70 == 2i);
            phi_7525_ = _e71;
            if _e71 {
                let _e73 = best_1.z;
                phi_7525_ = (_e73 < 390f);
            }
            let _e76 = phi_7525_;
            if _e76 {
                break;
            }
            let _e77 = level_7;
            param_277 = _e77;
            let _e78 = tileSizei1_((&param_277));
            tile_2 = _e78;
            dy = -1i;
            loop {
                let _e79 = dy;
                if (_e79 <= 1i) {
                    dx = -1i;
                    loop {
                        let _e81 = dx;
                        if (_e81 <= 1i) {
                            let _e83 = pixel_3;
                            let _e84 = dx;
                            let _e86 = dy;
                            let _e89 = tile_2;
                            param_278 = (_e83 + (vec2<f32>(f32(_e84), f32(_e86)) * _e89));
                            let _e92 = level_7;
                            param_279 = _e92;
                            let _e93 = tileKeyvf2i1_((&param_278), (&param_279));
                            key_5 = _e93;
                            let _e94 = key_5;
                            param_280 = _e94;
                            let _e95 = (*mirrored_3);
                            param_281 = _e95;
                            let _e96 = treeRangei1b1_((&param_280), (&param_281));
                            range_1 = _e96;
                            let _e98 = range_1[0u];
                            start_2 = _e98;
                            i_11 = 0i;
                            loop {
                                let _e99 = i_11;
                                if (_e99 < 800i) {
                                    let _e101 = start_2;
                                    let _e102 = i_11;
                                    let _e105 = range_1[1u];
                                    if ((_e101 + _e102) >= _e105) {
                                        break;
                                    }
                                    let _e107 = start_2;
                                    let _e108 = i_11;
                                    param_282 = (_e107 + _e108);
                                    let _e110 = (*mirrored_3);
                                    param_283 = _e110;
                                    let _e111 = sortAddressi1b1_((&param_282), (&param_283));
                                    let _e112 = textureLoad(tex1_, _e111, 0i);
                                    r_7 = _e112;
                                    let _e113 = r_7;
                                    param_284 = _e113;
                                    let _e114 = (*ro_2);
                                    param_285 = _e114;
                                    let _e115 = (*rd_2);
                                    param_286 = _e115;
                                    let _e116 = (*mirrored_3);
                                    param_287 = _e116;
                                    let _e117 = best_1;
                                    param_288 = _e117;
                                    testTreevf4vf3vf3b1structForestHitf1vf31_((&param_284), (&param_285), (&param_286), (&param_287), (&param_288));
                                    let _e118 = param_288;
                                    best_1 = _e118;
                                    continue;
                                } else {
                                    break;
                                }
                                continuing {
                                    let _e119 = i_11;
                                    i_11 = (_e119 + 1i);
                                }
                            }
                            continue;
                        } else {
                            break;
                        }
                        continuing {
                            let _e121 = dx;
                            dx = (_e121 + 1i);
                        }
                    }
                    continue;
                } else {
                    break;
                }
                continuing {
                    let _e123 = dy;
                    dy = (_e123 + 1i);
                }
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e125 = level_7;
            level_7 = (_e125 + 1i);
        }
    }
    let _e128 = best_1.z;
    (*nearest) = _e128;
    let _e130 = best_1.color;
    return _e130;
}

fn erodedFbmvf2i1_(p_23: ptr<function, vec2<f32>>, octaves_2: ptr<function, i32>) -> f32 {
    var h_6: f32;
    var amp_1: f32;
    var slope: vec2<f32>;
    var i_12: i32;
    var n_4: vec3<f32>;
    var param_289: vec2<f32>;

    h_6 = 0f;
    amp_1 = 0.5f;
    slope = vec2<f32>(0f, 0f);
    i_12 = 0i;
    loop {
        let _e18 = i_12;
        if (_e18 < 12i) {
            let _e20 = i_12;
            let _e21 = (*octaves_2);
            if (_e20 >= _e21) {
                break;
            }
            let _e23 = (*p_23);
            param_289 = _e23;
            let _e24 = gradientNoiseDvf2_((&param_289));
            n_4 = _e24;
            let _e25 = n_4;
            let _e27 = slope;
            slope = (_e27 + _e25.yz);
            let _e29 = amp_1;
            let _e31 = n_4[0u];
            let _e33 = slope;
            let _e34 = slope;
            let _e38 = h_6;
            h_6 = (_e38 + ((_e29 * _e31) / (1f + dot(_e33, _e34))));
            let _e40 = amp_1;
            amp_1 = (_e40 * 0.5f);
            let _e42 = (*p_23);
            (*p_23) = ((mat2x2<f32>(vec2<f32>(0.8f, 0.6f), vec2<f32>(-0.6f, 0.8f)) * _e42) * 2f);
            continue;
        } else {
            break;
        }
        continuing {
            let _e45 = i_12;
            i_12 = (_e45 + 1i);
        }
    }
    let _e47 = h_6;
    return (2f * _e47);
}

fn slopeNodei1i1_(x_7: ptr<function, i32>, row: ptr<function, i32>) -> vec4<f32> {
    var index_2: i32;

    let _e9 = (*row);
    let _e11 = (*x_7);
    index_2 = ((_e9 * 513i) + _e11);
    let _e13 = index_2;
    let _e22 = index_2;
    let _e26 = textureLoad(tex2_, vec2<i32>((769i + (_e13 - (i32(floor((f32(_e13) / f32(1024i)))) * 1024i))), (768i + (_e22 / 1024i))), 0i);
    return _e26;
}

fn slopeSurfacevf2_(world_4: ptr<function, vec2<f32>>) -> vec4<f32> {
    var row_1: f32;
    var j_10: i32;
    var z_10: vec2<f32>;
    var v_7: f32;
    var widths: vec2<f32>;
    var fc: f32;
    var col: i32;
    var dist: f32;
    var u_4: f32;
    var param_290: i32;
    var param_291: i32;
    var param_292: i32;
    var param_293: i32;
    var param_294: i32;
    var param_295: i32;
    var u_5: f32;
    var param_296: i32;
    var param_297: i32;
    var param_298: i32;
    var param_299: i32;
    var param_300: i32;
    var param_301: i32;

    let _e41 = (*world_4)[1u];
    row_1 = floor((368f * pow(clamp(((_e41 - 2f) / 1648f), 0f, 1f), 0.61349696f)));
    let _e48 = row_1;
    j_10 = clamp(i32(_e48), 0i, 367i);
    let _e51 = j_10;
    let _e53 = j_10;
    z_10 = (vec2(2f) + (pow((vec2<f32>(f32(_e51), f32((_e53 + 1i))) / vec2(368f)), vec2<f32>(1.63f, 1.63f)) * 1648f));
    let _e64 = (*world_4)[1u];
    let _e66 = z_10[0u];
    let _e69 = z_10[1u];
    let _e71 = z_10[0u];
    v_7 = clamp(((_e64 - _e66) / (_e69 - _e71)), 0f, 1f);
    let _e75 = z_10;
    widths = ((_e75 * 0.81f) + vec2(35f));
    let _e80 = (*world_4)[0u];
    let _e82 = widths[0u];
    let _e84 = widths[1u];
    let _e85 = v_7;
    fc = clamp((((_e80 / mix(_e82, _e84, _e85)) + 1f) * 256f), 0f, 512f);
    let _e91 = fc;
    col = min(511i, i32(_e91));
    let _e94 = fc;
    let _e95 = col;
    let _e99 = widths[0u];
    let _e101 = widths[1u];
    let _e102 = v_7;
    dist = ((_e94 - f32(_e95)) * mix(_e99, _e101, _e102));
    let _e105 = dist;
    let _e106 = v_7;
    let _e109 = widths[0u];
    if (_e105 <= ((1f - _e106) * _e109)) {
        let _e112 = dist;
        let _e114 = widths[0u];
        u_4 = (_e112 / _e114);
        let _e116 = u_4;
        let _e118 = v_7;
        let _e120 = col;
        param_290 = _e120;
        let _e121 = j_10;
        param_291 = _e121;
        let _e122 = slopeNodei1i1_((&param_290), (&param_291));
        let _e124 = u_4;
        let _e125 = col;
        param_292 = (_e125 + 1i);
        let _e127 = j_10;
        param_293 = _e127;
        let _e128 = slopeNodei1i1_((&param_292), (&param_293));
        let _e131 = v_7;
        let _e132 = j_10;
        let _e134 = col;
        param_294 = _e134;
        param_295 = (_e132 + 1i);
        let _e135 = slopeNodei1i1_((&param_294), (&param_295));
        return (((_e122 * ((1f - _e116) - _e118)) + (_e128 * _e124)) + (_e135 * _e131));
    }
    let _e138 = dist;
    let _e139 = v_7;
    let _e142 = widths[0u];
    let _e146 = widths[1u];
    u_5 = ((_e138 - ((1f - _e139) * _e142)) / _e146);
    let _e148 = v_7;
    let _e150 = col;
    param_296 = (_e150 + 1i);
    let _e152 = j_10;
    param_297 = _e152;
    let _e153 = slopeNodei1i1_((&param_296), (&param_297));
    let _e155 = v_7;
    let _e156 = u_5;
    let _e158 = j_10;
    let _e160 = col;
    param_298 = _e160;
    param_299 = (_e158 + 1i);
    let _e161 = slopeNodei1i1_((&param_298), (&param_299));
    let _e164 = u_5;
    let _e165 = col;
    let _e167 = j_10;
    param_300 = (_e165 + 1i);
    param_301 = (_e167 + 1i);
    let _e169 = slopeNodei1i1_((&param_300), (&param_301));
    return (((_e153 * (1f - _e148)) + (_e161 * (_e155 - _e156))) + (_e169 * _e164));
}

fn landColorvf3vf3_(wp: ptr<function, vec3<f32>>, ro_3: ptr<function, vec3<f32>>) -> vec3<f32> {
    var n_5: vec3<f32>;
    var param_302: vec2<f32>;
    var p_24: vec3<f32>;
    var sun_2: vec3<f32>;
    var fracture: f32;
    var param_303: vec2<f32>;
    var param_304: i32;
    var bedding: f32;
    var param_305: vec2<f32>;
    var param_306: i32;
    var side_4: f32;
    var stratum: f32;
    var variation: f32;
    var granite: vec3<f32>;
    var param_307: vec3<f32>;
    var faultUV: vec2<f32>;
    var fault: f32;
    var param_308: vec2<f32>;
    var param_309: i32;
    var hollow: f32;
    var param_310: vec2<f32>;
    var param_311: vec2<f32>;
    var couloir: f32;
    var shelf_1: f32;
    var snow: f32;
    var param_312: vec3<f32>;
    var loam: vec3<f32>;
    var param_313: vec3<f32>;
    var rock: f32;
    var c_9: vec3<f32>;
    var forestBelt: f32;
    var site: vec2<f32>;
    var hummock: vec3<f32>;
    var param_314: vec2<f32>;
    var pebbles: vec3<f32>;
    var param_315: vec2<f32>;
    var detail: f32;
    var gradient: vec2<f32>;
    var floorNormal: vec3<f32>;
    var mossPatch: f32;
    var param_316: vec2<f32>;
    var param_317: i32;
    var clast: f32;
    var soil: vec3<f32>;
    var rockFace: vec3<f32>;
    var pockets: f32;
    var irradiance: f32;
    var param_318: vec3<f32>;
    var floorColor: vec3<f32>;
    var param_319: vec3<f32>;
    var understory: f32;
    var groundGrain: vec3<f32>;
    var param_320: vec2<f32>;
    var humus: vec3<f32>;
    var param_321: vec3<f32>;
    var bankWeight: f32;
    var tangent_1: vec3<f32>;
    var bitangent: vec3<f32>;
    var weights: vec3<f32>;
    var coarse: vec3<f32>;
    var param_322: vec2<f32>;
    var param_323: vec2<f32>;
    var param_324: vec2<f32>;
    var grit: vec3<f32>;
    var param_325: vec2<f32>;
    var param_326: vec2<f32>;
    var param_327: vec2<f32>;
    var resolved: f32;
    var bumps: vec3<f32>;
    var floorNormal_1: vec3<f32>;
    var grass: f32;
    var stone: f32;
    var earth: vec3<f32>;
    var mineral: vec3<f32>;
    var irradiance_1: f32;
    var floorColor_1: vec3<f32>;
    var param_328: vec3<f32>;
    var param_329: vec3<f32>;
    var param_330: vec3<f32>;
    var param_331: vec3<f32>;
    var param_332: bool;
    var param_333: vec3<f32>;
    var param_334: vec3<f32>;

    let _e202 = (*wp);
    param_302 = _e202.xz;
    let _e204 = slopeSurfacevf2_((&param_302));
    n_5 = normalize(_e204.yzw);
    let _e207 = (*wp);
    p_24 = _e207;
    let _e208 = sunlight();
    sun_2 = _e208;
    let _e210 = p_24[0u];
    let _e213 = p_24[1u];
    let _e217 = p_24[2u];
    param_303 = vec2<f32>(((_e210 * 0.084f) + (_e213 * 0.028f)), (_e217 * 0.018f));
    param_304 = 4i;
    let _e220 = erodedFbmvf2i1_((&param_303), (&param_304));
    fracture = _e220;
    let _e222 = p_24[0u];
    let _e225 = p_24[1u];
    let _e229 = p_24[2u];
    param_305 = vec2<f32>(((_e222 * 0.032f) - (_e225 * 0.026f)), (_e229 * 0.025f));
    param_306 = 4i;
    let _e232 = erodedFbmvf2i1_((&param_305), (&param_306));
    bedding = _e232;
    let _e233 = n_5;
    let _e234 = bedding;
    let _e236 = bedding;
    let _e242 = sun_2[0u];
    side_4 = dot(normalize((_e233 + vec3<f32>((0.36f * _e234), (0.06f * _e236), 0f))), normalize(vec3<f32>((_e242 * 2.6f), 0.15f, -0.24f)));
    let _e248 = p_24[2u];
    let _e252 = side_4;
    side_4 = (_e252 - (0.23f * (1f - smoothstep(610f, 810f, _e248))));
    let _e255 = p_24[1u];
    let _e257 = fracture;
    let _e261 = p_24[0u];
    stratum = (((_e255 * 0.19f) + (_e257 * 3.6f)) + (_e261 * 0.037f));
    let _e264 = fracture;
    let _e267 = stratum;
    variation = ((0.76f + (0.29f * _e264)) + (0.12f * sin(_e267)));
    let _e271 = side_4;
    param_307 = mix(vec3<f32>(0.295f, 0.284f, 0.423f), vec3<f32>(0.787f, 0.599f, 0.6f), vec3(smoothstep(0.54f, 0.98f, _e271)));
    let _e275 = srgbToLinearvf3_((&param_307));
    let _e276 = variation;
    granite = (_e275 * _e276);
    let _e279 = p_24[0u];
    let _e282 = p_24[1u];
    let _e286 = p_24[2u];
    let _e289 = p_24[1u];
    faultUV = vec2<f32>(((_e279 * 0.066f) - (_e282 * 0.039f)), ((_e286 * 0.013f) + (_e289 * 0.009f)));
    let _e293 = faultUV;
    param_308 = _e293;
    param_309 = 4i;
    let _e294 = erodedFbmvf2i1_((&param_308), (&param_309));
    fault = _e294;
    let _e295 = fault;
    let _e298 = granite;
    granite = (_e298 * (0.91f + (0.4f * _e295)));
    let _e300 = p_24;
    param_310 = (_e300.xz + vec2<f32>(3f, 0f));
    let _e303 = bedvf2_((&param_310));
    let _e304 = p_24;
    param_311 = (_e304.xz - vec2<f32>(3f, 0f));
    let _e307 = bedvf2_((&param_311));
    let _e310 = p_24[1u];
    hollow = ((_e303 + _e307) - (2f * _e310));
    let _e313 = hollow;
    let _e314 = fracture;
    couloir = smoothstep(1.05f, 3.2f, (_e313 + (0.72f * _e314)));
    let _e319 = n_5[1u];
    let _e321 = stratum;
    shelf_1 = (smoothstep(0.975f, 0.996f, _e319) * smoothstep(0.1f, 0.7f, sin(_e321)));
    let _e326 = p_24[1u];
    let _e328 = couloir;
    let _e330 = shelf_1;
    let _e333 = fault;
    let _e336 = n_5[1u];
    snow = (smoothstep(93f, 155f, _e326) * clamp((((_e328 * 0.54f) + (_e330 * 0.26f)) + ((smoothstep(0.12f, 0.31f, _e333) * smoothstep(0.52f, 0.91f, _e336)) * 0.36f)), 0f, 1f));
    let _e343 = granite;
    let _e344 = side_4;
    param_312 = mix(vec3<f32>(0.53f, 0.54f, 0.66f), vec3<f32>(0.86f, 0.75f, 0.77f), vec3(max(_e344, 0f)));
    let _e348 = srgbToLinearvf3_((&param_312));
    let _e349 = snow;
    granite = mix(_e343, _e348, vec3(_e349));
    let _e352 = fracture;
    param_313 = mix(vec3<f32>(0.19f, 0.19f, 0.225f), vec3<f32>(0.396f, 0.36f, 0.3f), vec3((0.5f + (0.44f * _e352))));
    let _e357 = srgbToLinearvf3_((&param_313));
    loam = _e357;
    let _e359 = p_24[1u];
    let _e362 = n_5[1u];
    rock = (smoothstep(41f, 93f, _e359) + (0.65f * (1f - smoothstep(0.35f, 0.77f, _e362))));
    let _e367 = loam;
    let _e368 = side_4;
    let _e373 = granite;
    let _e374 = rock;
    c_9 = mix((_e367 * (0.64f + (0.7f * max(_e368, 0f)))), _e373, vec3(clamp(_e374, 0f, 1f)));
    let _e379 = p_24[1u];
    let _e382 = p_24[1u];
    forestBelt = (smoothstep(0.4f, 7f, _e379) * (1f - smoothstep(104f, 142f, _e382)));
    let _e386 = p_24;
    let _e389 = p_24[1u];
    let _e392 = p_24[1u];
    site = (_e386.xz + vec2<f32>((_e389 * 0.29f), (-0.17f * _e392)));
    let _e396 = site;
    param_314 = (_e396 * 0.31f);
    let _e398 = gradientNoiseDvf2_((&param_314));
    hummock = _e398;
    let _e399 = site;
    param_315 = ((_e399 * 1.48f) + vec2<f32>(8.9f, -3.3f));
    let _e402 = gradientNoiseDvf2_((&param_315));
    pebbles = _e402;
    let _e404 = site[0u];
    let _e405 = fwidth(_e404);
    let _e407 = site[1u];
    let _e408 = fwidth(_e407);
    detail = (1f - smoothstep(0.23f, 0.95f, (max(_e405, _e408) * 1.48f)));
    let _e413 = hummock;
    let _e416 = pebbles;
    let _e419 = detail;
    gradient = ((_e413.yz * 0.52f) + ((_e416.yz * 0.34f) * _e419));
    let _e422 = n_5;
    let _e424 = gradient[0u];
    let _e427 = gradient[1u];
    let _e431 = n_5[1u];
    floorNormal = normalize((_e422 + (vec3<f32>(-(_e424), 0f, -(_e427)) * max(_e431, 0.23f))));
    let _e436 = site;
    param_316 = ((_e436 * 0.14f) + vec2<f32>(2f, 15f));
    param_317 = 4i;
    let _e439 = fbmvf2i1_((&param_316), (&param_317));
    let _e441 = hummock[0u];
    mossPatch = (_e439 + (_e441 * 0.33f));
    let _e445 = hummock[0u];
    let _e446 = bedding;
    let _e450 = pebbles[0u];
    let _e452 = detail;
    clast = smoothstep(0.1f, 0.37f, ((_e445 + (0.18f * _e446)) + ((0.16f * _e450) * _e452)));
    let _e456 = mossPatch;
    soil = mix(vec3<f32>(0.227f, 0.192f, 0.184f), vec3<f32>(0.418f, 0.382f, 0.232f), vec3(smoothstep(-0.22f, 0.24f, _e456)));
    let _e461 = pebbles[0u];
    rockFace = mix(vec3<f32>(0.29f, 0.268f, 0.302f), vec3<f32>(0.52f, 0.452f, 0.402f), vec3((0.5f + (0.46f * _e461))));
    let _e467 = hummock[0u];
    let _e471 = pebbles[0u];
    let _e473 = detail;
    pockets = clamp(((0.8f + (0.42f * _e467)) + ((0.13f * _e471) * _e473)), 0.45f, 1f);
    let _e477 = floorNormal;
    let _e478 = sun_2;
    let _e483 = p_24;
    param_318 = _e483;
    let _e484 = skyVisibilityAtvf3_((&param_318));
    irradiance = (clamp(((dot(_e477, _e478) * 0.87f) + 0.24f), 0f, 1f) * _e484);
    let _e486 = soil;
    let _e487 = rockFace;
    let _e488 = clast;
    param_319 = mix(_e486, _e487, vec3(_e488));
    let _e491 = srgbToLinearvf3_((&param_319));
    let _e492 = pockets;
    let _e494 = key_2();
    let _e495 = irradiance;
    floorColor = ((_e491 * _e492) * (vec3<f32>(0.55f, 0.65f, 0.79f) + ((_e494 * _e495) * 1.9f)));
    let _e500 = c_9;
    let _e501 = floorColor;
    let _e502 = forestBelt;
    let _e504 = n_5[1u];
    c_9 = mix(_e500, _e501, vec3((_e502 * smoothstep(0.18f, 0.57f, _e504))));
    let _e510 = p_24[2u];
    let _e514 = p_24[1u];
    let _e519 = p_24[1u];
    understory = (((1f - smoothstep(148f, 244f, _e510)) * (1f - smoothstep(62f, 91f, _e514))) * smoothstep(2f, 8f, _e519));
    let _e522 = p_24;
    let _e526 = p_24[2u];
    param_320 = ((_e522.xy * 0.44f) + vec2((_e526 * 0.31f)));
    let _e530 = gradientNoiseDvf2_((&param_320));
    groundGrain = _e530;
    let _e532 = groundGrain[0u];
    let _e533 = bedding;
    humus = mix(vec3<f32>(0.128f, 0.153f, 0.143f), vec3<f32>(0.275f, 0.279f, 0.212f), vec3(smoothstep(-0.25f, 0.28f, (_e532 + (0.33f * _e533)))));
    let _e539 = c_9;
    let _e540 = humus;
    param_321 = _e540;
    let _e541 = srgbToLinearvf3_((&param_321));
    let _e543 = floorNormal[1u];
    let _e548 = understory;
    c_9 = mix(_e539, (_e541 * (0.7f + (0.39f * max(0f, _e543)))), vec3(_e548));
    let _e551 = p_24;
    bankWeight = (1f - smoothstep(0.48f, 1f, length(((_e551.xz - vec2<f32>(18f, 322f)) / vec2<f32>(35f, 36f)))));
    let _e558 = bankWeight;
    if (_e558 > 0f) {
        let _e561 = n_5[1u];
        let _e563 = n_5[0u];
        tangent_1 = normalize((vec3<f32>(_e561, -(_e563), 0f) + vec3<f32>(0.00001f, 0f, 0f)));
        let _e568 = n_5;
        let _e569 = tangent_1;
        bitangent = normalize(cross(_e568, _e569));
        let _e572 = n_5;
        weights = pow(abs(_e572), vec3<f32>(3f, 3f, 3f));
        let _e575 = weights;
        let _e578 = weights;
        weights = (_e578 / vec3(max(0.0001f, dot(_e575, vec3<f32>(1f, 1f, 1f)))));
        let _e582 = weights[0u];
        let _e583 = p_24;
        param_322 = (_e583.zy * 0.45f);
        let _e586 = gradientNoiseDvf2_((&param_322));
        let _e589 = weights[1u];
        let _e590 = p_24;
        param_323 = (_e590.xz * 0.45f);
        let _e593 = gradientNoiseDvf2_((&param_323));
        let _e597 = weights[2u];
        let _e598 = p_24;
        param_324 = (_e598.xy * 0.45f);
        let _e601 = gradientNoiseDvf2_((&param_324));
        coarse = (((_e586 * _e582) + (_e593 * _e589)) + (_e601 * _e597));
        let _e605 = weights[0u];
        let _e606 = p_24;
        param_325 = (_e606.zy * 1.32f);
        let _e609 = gradientNoiseDvf2_((&param_325));
        let _e612 = weights[1u];
        let _e613 = p_24;
        param_326 = (_e613.xz * 1.32f);
        let _e616 = gradientNoiseDvf2_((&param_326));
        let _e620 = weights[2u];
        let _e621 = p_24;
        param_327 = (_e621.xy * 1.32f);
        let _e624 = gradientNoiseDvf2_((&param_327));
        grit = (((_e609 * _e605) + (_e616 * _e612)) + (_e624 * _e620));
        let _e627 = p_24;
        let _e628 = dpdx(_e627);
        let _e630 = p_24;
        let _e631 = dpdy(_e630);
        resolved = (1f - smoothstep(0.4f, 1.2f, (max(length(_e628), length(_e631)) * 1.32f)));
        let _e637 = tangent_1;
        let _e639 = coarse[1u];
        let _e641 = grit[1u];
        let _e643 = resolved;
        let _e647 = bitangent;
        let _e649 = coarse[2u];
        let _e651 = grit[2u];
        let _e653 = resolved;
        bumps = ((_e637 * (_e639 + ((0.4f * _e641) * _e643))) + (_e647 * (_e649 + ((0.4f * _e651) * _e653))));
        let _e658 = n_5;
        let _e659 = bumps;
        floorNormal_1 = normalize((_e658 - (_e659 * 0.36f)));
        let _e664 = coarse[0u];
        let _e666 = grit[0u];
        grass = smoothstep(-0.22f, 0.25f, (_e664 + (0.23f * _e666)));
        let _e671 = coarse[0u];
        let _e673 = grit[0u];
        stone = smoothstep(0.12f, 0.34f, (_e671 - (0.3f * _e673)));
        let _e677 = grass;
        earth = mix(vec3<f32>(0.265f, 0.231f, 0.22f), vec3<f32>(0.42f, 0.398f, 0.265f), vec3(_e677));
        let _e681 = grit[0u];
        mineral = mix(vec3<f32>(0.3f, 0.28f, 0.32f), vec3<f32>(0.49f, 0.45f, 0.424f), vec3((0.5f + (0.59f * _e681))));
        let _e686 = floorNormal_1;
        let _e687 = sun_2;
        irradiance_1 = max(0f, dot(_e686, _e687));
        let _e690 = earth;
        let _e691 = mineral;
        let _e692 = stone;
        param_328 = mix(_e690, _e691, vec3(_e692));
        let _e695 = srgbToLinearvf3_((&param_328));
        let _e696 = key_2();
        let _e697 = irradiance_1;
        let _e699 = p_24;
        param_329 = _e699;
        let _e700 = skyVisibilityAtvf3_((&param_329));
        floorColor_1 = (_e695 * (vec3<f32>(0.59f, 0.65f, 0.75f) + ((_e696 * _e697) * (0.65f + (0.5f * _e700)))));
        let _e706 = c_9;
        let _e707 = floorColor_1;
        let _e708 = forestBelt;
        let _e709 = bankWeight;
        c_9 = mix(_e706, _e707, vec3((_e708 * _e709)));
    }
    let _e713 = c_9;
    c_9 = (_e713 * vec3<f32>(1f, 1f, 1f));
    let _e715 = c_9;
    let _e716 = (*wp);
    let _e717 = n_5;
    param_330 = (_e716 + (_e717 * 1.2f));
    let _e720 = sun_2;
    param_331 = _e720;
    param_332 = false;
    let _e721 = castVisibilityvf3vf3b1_((&param_330), (&param_331), (&param_332));
    param_333 = (_e715 * _e721);
    let _e723 = (*wp);
    param_334 = _e723;
    let _e724 = finishSlopevf3vf3_((&param_333), (&param_334));
    return _e724;
}

fn groundAtvf2_(world_5: ptr<function, vec2<f32>>) -> f32 {
    var param_335: vec2<f32>;

    let _e2 = (*world_5);
    param_335 = _e2;
    let _e3 = slopeSurfacevf2_((&param_335));
    return _e3.x;
}

fn hashvf3_(p_25: ptr<function, vec3<f32>>) -> f32 {
    let _e6 = (*p_25);
    (*p_25) = fract((_e6 * 0.1031f));
    let _e9 = (*p_25);
    let _e10 = (*p_25);
    let _e15 = (*p_25);
    (*p_25) = (_e15 + vec3(dot(_e9, (_e10.yzx + vec3(33.33f)))));
    let _e19 = (*p_25)[0u];
    let _e21 = (*p_25)[1u];
    let _e24 = (*p_25)[2u];
    return fract(((_e19 + _e21) * _e24));
}

fn facetsvf3f1_(p_26: ptr<function, vec3<f32>>, scale_2: ptr<function, f32>) -> vec2<f32> {
    var q_9: vec3<f32>;
    var cell_7: vec3<f32>;
    var w_4: vec3<f32>;
    var a_10: f32;
    var b_8: f32;
    var tilt_1: f32;
    var z_11: i32;
    var y_7: i32;
    var x_8: i32;
    var k_6: vec3<f32>;
    var id_6: vec3<f32>;
    var off: vec3<f32>;
    var param_336: vec3<f32>;
    var param_337: vec3<f32>;
    var param_338: vec3<f32>;
    var t_10: f32;
    var param_339: vec3<f32>;
    var param_340: vec3<f32>;
    var param_341: vec3<f32>;
    var edge: f32;

    let _e42 = (*p_26)[0u];
    let _e45 = (*p_26)[1u];
    let _e49 = (*p_26)[0u];
    let _e52 = (*p_26)[1u];
    let _e57 = (*p_26)[2u];
    let _e59 = (*scale_2);
    q_9 = (vec3<f32>(((0.93f * _e42) + (0.368f * _e45)), (((-0.368f * _e49) + (0.93f * _e52)) * 0.25f), _e57) / vec3(_e59));
    let _e62 = q_9;
    cell_7 = floor(_e62);
    let _e64 = q_9;
    w_4 = fract(_e64);
    a_10 = 10f;
    b_8 = 10f;
    tilt_1 = 0f;
    z_11 = -1i;
    loop {
        let _e66 = z_11;
        if (_e66 <= 1i) {
            y_7 = -1i;
            loop {
                let _e68 = y_7;
                if (_e68 <= 1i) {
                    x_8 = -1i;
                    loop {
                        let _e70 = x_8;
                        if (_e70 <= 1i) {
                            let _e72 = x_8;
                            let _e74 = y_7;
                            let _e76 = z_11;
                            k_6 = vec3<f32>(f32(_e72), f32(_e74), f32(_e76));
                            let _e79 = cell_7;
                            let _e80 = k_6;
                            id_6 = (_e79 + _e80);
                            let _e82 = k_6;
                            let _e85 = id_6;
                            param_336 = _e85;
                            let _e86 = hashvf3_((&param_336));
                            let _e87 = id_6;
                            param_337 = (_e87 + vec3(57f));
                            let _e90 = hashvf3_((&param_337));
                            let _e91 = id_6;
                            param_338 = (_e91 + vec3(13f));
                            let _e94 = hashvf3_((&param_338));
                            let _e100 = w_4;
                            off = (((_e82 + vec3(0.5f)) + ((vec3<f32>(_e86, _e90, _e94) - vec3(0.5f)) * 0.38f)) - _e100);
                            let _e102 = off;
                            let _e103 = off;
                            t_10 = dot(_e102, _e103);
                            let _e105 = t_10;
                            let _e106 = a_10;
                            if (_e105 < _e106) {
                                let _e108 = a_10;
                                b_8 = _e108;
                                let _e109 = t_10;
                                a_10 = _e109;
                                let _e110 = off;
                                let _e111 = id_6;
                                param_339 = (_e111 + vec3(5f));
                                let _e114 = hashvf3_((&param_339));
                                let _e115 = id_6;
                                param_340 = (_e115 + vec3(9f));
                                let _e118 = hashvf3_((&param_340));
                                let _e119 = id_6;
                                param_341 = (_e119 + vec3(31f));
                                let _e122 = hashvf3_((&param_341));
                                tilt_1 = dot(_e110, (vec3<f32>(_e114, _e118, _e122) - vec3(0.5f)));
                            } else {
                                let _e127 = b_8;
                                let _e128 = t_10;
                                b_8 = min(_e127, _e128);
                            }
                            continue;
                        } else {
                            break;
                        }
                        continuing {
                            let _e130 = x_8;
                            x_8 = (_e130 + 1i);
                        }
                    }
                    continue;
                } else {
                    break;
                }
                continuing {
                    let _e132 = y_7;
                    y_7 = (_e132 + 1i);
                }
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e134 = z_11;
            z_11 = (_e134 + 1i);
        }
    }
    let _e136 = b_8;
    let _e138 = a_10;
    let _e141 = (*scale_2);
    edge = ((sqrt(_e136) - sqrt(_e138)) * _e141);
    let _e143 = tilt_1;
    let _e144 = edge;
    let _e147 = edge;
    return vec2<f32>((_e143 * smoothstep(0f, 2.8f, _e144)), _e147);
}

fn valueNoise3vf3_(p_27: ptr<function, vec3<f32>>) -> f32 {
    var i_13: vec3<f32>;
    var f_9: vec3<f32>;
    var param_342: vec3<f32>;
    var param_343: vec3<f32>;
    var param_344: vec3<f32>;
    var param_345: vec3<f32>;
    var param_346: vec3<f32>;
    var param_347: vec3<f32>;
    var param_348: vec3<f32>;
    var param_349: vec3<f32>;

    let _e23 = (*p_27);
    i_13 = floor(_e23);
    let _e25 = (*p_27);
    f_9 = fract(_e25);
    let _e27 = f_9;
    let _e28 = f_9;
    let _e30 = f_9;
    f_9 = ((_e27 * _e28) * (vec3(3f) - (_e30 * 2f)));
    let _e35 = i_13;
    param_342 = _e35;
    let _e36 = hashvf3_((&param_342));
    let _e37 = i_13;
    param_343 = (_e37 + vec3<f32>(1f, 0f, 0f));
    let _e39 = hashvf3_((&param_343));
    let _e41 = f_9[0u];
    let _e43 = i_13;
    param_344 = (_e43 + vec3<f32>(0f, 1f, 0f));
    let _e45 = hashvf3_((&param_344));
    let _e46 = i_13;
    param_345 = (_e46 + vec3<f32>(1f, 1f, 0f));
    let _e48 = hashvf3_((&param_345));
    let _e50 = f_9[0u];
    let _e53 = f_9[1u];
    let _e55 = i_13;
    param_346 = (_e55 + vec3<f32>(0f, 0f, 1f));
    let _e57 = hashvf3_((&param_346));
    let _e58 = i_13;
    param_347 = (_e58 + vec3<f32>(1f, 0f, 1f));
    let _e60 = hashvf3_((&param_347));
    let _e62 = f_9[0u];
    let _e64 = i_13;
    param_348 = (_e64 + vec3<f32>(0f, 1f, 1f));
    let _e66 = hashvf3_((&param_348));
    let _e67 = i_13;
    param_349 = (_e67 + vec3(1f));
    let _e70 = hashvf3_((&param_349));
    let _e72 = f_9[0u];
    let _e75 = f_9[1u];
    let _e78 = f_9[2u];
    return mix(mix(mix(_e36, _e39, _e41), mix(_e45, _e48, _e50), _e53), mix(mix(_e57, _e60, _e62), mix(_e66, _e70, _e72), _e75), _e78);
}

fn rooff1_(x_9: ptr<function, f32>) -> f32 {
    var lo_4: i32;
    var hi_4: i32;
    var i_14: i32;
    var m_1: i32;
    var indexable_6: array<vec2<f32>, 77>;
    var a_11: vec2<f32>;
    var indexable_7: array<vec2<f32>, 77>;
    var b_9: vec2<f32>;
    var indexable_8: array<vec2<f32>, 77>;

    lo_4 = 0i;
    hi_4 = 76i;
    i_14 = 0i;
    loop {
        let _e21 = i_14;
        if (_e21 < 8i) {
            let _e23 = hi_4;
            let _e24 = lo_4;
            m_1 = ((_e23 + _e24) / 2i);
            let _e27 = (*x_9);
            let _e28 = m_1;
            indexable_6 = array<vec2<f32>, 77>(vec2<f32>(890f, 466f), vec2<f32>(997f, 402f), vec2<f32>(1058f, 352f), vec2<f32>(1093f, 320f), vec2<f32>(1099f, 310f), vec2<f32>(1109f, 303f), vec2<f32>(1125f, 277f), vec2<f32>(1137f, 265f), vec2<f32>(1147f, 260f), vec2<f32>(1157f, 249f), vec2<f32>(1185f, 263f), vec2<f32>(1195f, 259f), vec2<f32>(1211f, 263f), vec2<f32>(1225f, 255f), vec2<f32>(1233f, 255f), vec2<f32>(1245f, 244f), vec2<f32>(1257f, 241f), vec2<f32>(1263f, 242f), vec2<f32>(1277f, 235f), vec2<f32>(1291f, 206f), vec2<f32>(1293f, 205f), vec2<f32>(1295f, 200f), vec2<f32>(1303f, 189f), vec2<f32>(1309f, 184f), vec2<f32>(1323f, 184f), vec2<f32>(1333f, 188f), vec2<f32>(1335f, 186f), vec2<f32>(1339f, 177f), vec2<f32>(1343f, 176f), vec2<f32>(1345f, 168f), vec2<f32>(1353f, 164f), vec2<f32>(1361f, 154f), vec2<f32>(1365f, 144f), vec2<f32>(1375f, 131f), vec2<f32>(1377f, 125f), vec2<f32>(1379f, 125f), vec2<f32>(1381f, 117f), vec2<f32>(1383f, 115f), vec2<f32>(1387f, 106f), vec2<f32>(1391f, 102f), vec2<f32>(1393f, 97f), vec2<f32>(1403f, 86f), vec2<f32>(1407f, 85f), vec2<f32>(1409f, 81f), vec2<f32>(1421f, 77f), vec2<f32>(1435f, 78f), vec2<f32>(1455f, 86f), vec2<f32>(1465f, 93f), vec2<f32>(1480f, 93f), vec2<f32>(1487f, 85f), vec2<f32>(1495f, 79f), vec2<f32>(1505f, 83f), vec2<f32>(1511f, 83f), vec2<f32>(1521f, 70f), vec2<f32>(1531f, 69f), vec2<f32>(1539f, 75f), vec2<f32>(1547f, 76f), vec2<f32>(1561f, 87f), vec2<f32>(1569f, 96f), vec2<f32>(1585f, 127f), vec2<f32>(1591f, 130f), vec2<f32>(1599f, 142f), vec2<f32>(1607f, 147f), vec2<f32>(1627f, 153f), vec2<f32>(1633f, 149f), vec2<f32>(1647f, 153f), vec2<f32>(1655f, 147f), vec2<f32>(1667f, 146f), vec2<f32>(1687f, 157f), vec2<f32>(1707f, 172f), vec2<f32>(1733f, 185f), vec2<f32>(1759f, 190f), vec2<f32>(1780f, 204f), vec2<f32>(1810f, 211f), vec2<f32>(1870f, 237f), vec2<f32>(2000f, 288f), vec2<f32>(2070f, 340f));
            let _e31 = indexable_6[_e28][0u];
            if (_e27 < _e31) {
                let _e33 = m_1;
                hi_4 = _e33;
            } else {
                let _e34 = m_1;
                lo_4 = _e34;
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e35 = i_14;
            i_14 = (_e35 + 1i);
        }
    }
    let _e37 = lo_4;
    indexable_7 = array<vec2<f32>, 77>(vec2<f32>(890f, 466f), vec2<f32>(997f, 402f), vec2<f32>(1058f, 352f), vec2<f32>(1093f, 320f), vec2<f32>(1099f, 310f), vec2<f32>(1109f, 303f), vec2<f32>(1125f, 277f), vec2<f32>(1137f, 265f), vec2<f32>(1147f, 260f), vec2<f32>(1157f, 249f), vec2<f32>(1185f, 263f), vec2<f32>(1195f, 259f), vec2<f32>(1211f, 263f), vec2<f32>(1225f, 255f), vec2<f32>(1233f, 255f), vec2<f32>(1245f, 244f), vec2<f32>(1257f, 241f), vec2<f32>(1263f, 242f), vec2<f32>(1277f, 235f), vec2<f32>(1291f, 206f), vec2<f32>(1293f, 205f), vec2<f32>(1295f, 200f), vec2<f32>(1303f, 189f), vec2<f32>(1309f, 184f), vec2<f32>(1323f, 184f), vec2<f32>(1333f, 188f), vec2<f32>(1335f, 186f), vec2<f32>(1339f, 177f), vec2<f32>(1343f, 176f), vec2<f32>(1345f, 168f), vec2<f32>(1353f, 164f), vec2<f32>(1361f, 154f), vec2<f32>(1365f, 144f), vec2<f32>(1375f, 131f), vec2<f32>(1377f, 125f), vec2<f32>(1379f, 125f), vec2<f32>(1381f, 117f), vec2<f32>(1383f, 115f), vec2<f32>(1387f, 106f), vec2<f32>(1391f, 102f), vec2<f32>(1393f, 97f), vec2<f32>(1403f, 86f), vec2<f32>(1407f, 85f), vec2<f32>(1409f, 81f), vec2<f32>(1421f, 77f), vec2<f32>(1435f, 78f), vec2<f32>(1455f, 86f), vec2<f32>(1465f, 93f), vec2<f32>(1480f, 93f), vec2<f32>(1487f, 85f), vec2<f32>(1495f, 79f), vec2<f32>(1505f, 83f), vec2<f32>(1511f, 83f), vec2<f32>(1521f, 70f), vec2<f32>(1531f, 69f), vec2<f32>(1539f, 75f), vec2<f32>(1547f, 76f), vec2<f32>(1561f, 87f), vec2<f32>(1569f, 96f), vec2<f32>(1585f, 127f), vec2<f32>(1591f, 130f), vec2<f32>(1599f, 142f), vec2<f32>(1607f, 147f), vec2<f32>(1627f, 153f), vec2<f32>(1633f, 149f), vec2<f32>(1647f, 153f), vec2<f32>(1655f, 147f), vec2<f32>(1667f, 146f), vec2<f32>(1687f, 157f), vec2<f32>(1707f, 172f), vec2<f32>(1733f, 185f), vec2<f32>(1759f, 190f), vec2<f32>(1780f, 204f), vec2<f32>(1810f, 211f), vec2<f32>(1870f, 237f), vec2<f32>(2000f, 288f), vec2<f32>(2070f, 340f));
    let _e39 = indexable_7[_e37];
    a_11 = _e39;
    let _e40 = hi_4;
    indexable_8 = array<vec2<f32>, 77>(vec2<f32>(890f, 466f), vec2<f32>(997f, 402f), vec2<f32>(1058f, 352f), vec2<f32>(1093f, 320f), vec2<f32>(1099f, 310f), vec2<f32>(1109f, 303f), vec2<f32>(1125f, 277f), vec2<f32>(1137f, 265f), vec2<f32>(1147f, 260f), vec2<f32>(1157f, 249f), vec2<f32>(1185f, 263f), vec2<f32>(1195f, 259f), vec2<f32>(1211f, 263f), vec2<f32>(1225f, 255f), vec2<f32>(1233f, 255f), vec2<f32>(1245f, 244f), vec2<f32>(1257f, 241f), vec2<f32>(1263f, 242f), vec2<f32>(1277f, 235f), vec2<f32>(1291f, 206f), vec2<f32>(1293f, 205f), vec2<f32>(1295f, 200f), vec2<f32>(1303f, 189f), vec2<f32>(1309f, 184f), vec2<f32>(1323f, 184f), vec2<f32>(1333f, 188f), vec2<f32>(1335f, 186f), vec2<f32>(1339f, 177f), vec2<f32>(1343f, 176f), vec2<f32>(1345f, 168f), vec2<f32>(1353f, 164f), vec2<f32>(1361f, 154f), vec2<f32>(1365f, 144f), vec2<f32>(1375f, 131f), vec2<f32>(1377f, 125f), vec2<f32>(1379f, 125f), vec2<f32>(1381f, 117f), vec2<f32>(1383f, 115f), vec2<f32>(1387f, 106f), vec2<f32>(1391f, 102f), vec2<f32>(1393f, 97f), vec2<f32>(1403f, 86f), vec2<f32>(1407f, 85f), vec2<f32>(1409f, 81f), vec2<f32>(1421f, 77f), vec2<f32>(1435f, 78f), vec2<f32>(1455f, 86f), vec2<f32>(1465f, 93f), vec2<f32>(1480f, 93f), vec2<f32>(1487f, 85f), vec2<f32>(1495f, 79f), vec2<f32>(1505f, 83f), vec2<f32>(1511f, 83f), vec2<f32>(1521f, 70f), vec2<f32>(1531f, 69f), vec2<f32>(1539f, 75f), vec2<f32>(1547f, 76f), vec2<f32>(1561f, 87f), vec2<f32>(1569f, 96f), vec2<f32>(1585f, 127f), vec2<f32>(1591f, 130f), vec2<f32>(1599f, 142f), vec2<f32>(1607f, 147f), vec2<f32>(1627f, 153f), vec2<f32>(1633f, 149f), vec2<f32>(1647f, 153f), vec2<f32>(1655f, 147f), vec2<f32>(1667f, 146f), vec2<f32>(1687f, 157f), vec2<f32>(1707f, 172f), vec2<f32>(1733f, 185f), vec2<f32>(1759f, 190f), vec2<f32>(1780f, 204f), vec2<f32>(1810f, 211f), vec2<f32>(1870f, 237f), vec2<f32>(2000f, 288f), vec2<f32>(2070f, 340f));
    let _e42 = indexable_8[_e40];
    b_9 = _e42;
    let _e44 = a_11[1u];
    let _e46 = b_9[1u];
    let _e47 = (*x_9);
    let _e49 = a_11[0u];
    let _e52 = b_9[0u];
    let _e54 = a_11[0u];
    return mix(_e44, _e46, clamp(((_e47 - _e49) / max(0.01f, (_e52 - _e54))), 0f, 1f));
}

fn buttressvf3vf4f1f1_(p_28: ptr<function, vec3<f32>>, station: ptr<function, vec4<f32>>, w_5: ptr<function, f32>, len_2: ptr<function, f32>) -> f32 {
    var h_7: f32;
    var x_10: f32;
    var nose: f32;
    var front: f32;
    var crown: f32;

    let _e29 = (*p_28)[1u];
    let _e31 = (*station)[1u];
    h_7 = (_e29 - _e31);
    let _e34 = (*p_28)[0u];
    let _e36 = (*station)[0u];
    let _e39 = (*station)[2u];
    let _e40 = h_7;
    x_10 = ((_e34 - _e36) + (_e39 * _e40));
    let _e44 = (*station)[3u];
    let _e45 = h_7;
    nose = (_e44 - (0.25f * _e45));
    let _e48 = nose;
    let _e49 = x_10;
    let _e52 = nose;
    let _e53 = x_10;
    front = max((_e48 - (1.45f * _e49)), (_e52 + (0.47f * _e53)));
    let _e58 = (*station)[1u];
    let _e60 = (*p_28)[1u];
    let _e62 = x_10;
    let _e67 = x_10;
    let _e72 = (*station)[3u];
    let _e74 = (*p_28)[2u];
    crown = ((((_e58 - _e60) + (0.34f * max(-(_e62), 0f))) + (0.69f * max(_e67, 0f))) + (0.62f * max((_e72 - _e74), 0f)));
    let _e79 = front;
    let _e81 = (*p_28)[2u];
    let _e84 = crown;
    let _e87 = x_10;
    let _e89 = (*w_5);
    let _e90 = h_7;
    let _e98 = (*p_28)[2u];
    let _e100 = h_7;
    let _e101 = (*len_2);
    return max(max(((_e79 - _e81) * 0.58f), (_e84 * 0.7f)), max((abs(_e87) - (_e89 * (0.45f + (0.55f * clamp((_e90 / 42f), 0f, 1f))))), max((_e98 - 16f), ((_e100 - _e101) * 0.61f))));
}

fn roundBoxvf3vf3f1_(p_29: ptr<function, vec3<f32>>, b_10: ptr<function, vec3<f32>>, r_8: ptr<function, f32>) -> f32 {
    var q_10: vec3<f32>;

    let _e8 = (*p_29);
    let _e10 = (*b_10);
    let _e12 = (*r_8);
    q_10 = ((abs(_e8) - _e10) + vec3(_e12));
    let _e15 = q_10;
    let _e20 = q_10[0u];
    let _e22 = q_10[1u];
    let _e24 = q_10[2u];
    let _e29 = (*r_8);
    return ((length(max(_e15, vec3(0f))) + min(max(_e20, max(_e22, _e24)), 0f)) - _e29);
}

fn sminf1f1f1_(a_12: ptr<function, f32>, b_11: ptr<function, f32>, r_9: ptr<function, f32>) -> f32 {
    var h_8: f32;

    let _e6 = (*r_9);
    let _e7 = (*a_12);
    let _e8 = (*b_11);
    let _e13 = (*r_9);
    h_8 = (max((_e6 - abs((_e7 - _e8))), 0f) / _e13);
    let _e15 = (*a_12);
    let _e16 = (*b_11);
    let _e18 = (*r_9);
    let _e20 = h_8;
    let _e22 = h_8;
    return (min(_e15, _e16) - (((0.25f * _e18) * _e20) * _e22));
}

fn rockFieldvf3_(p_30: ptr<function, vec3<f32>>) -> f32 {
    var x_11: f32;
    var crest: f32;
    var summit: f32;
    var param_350: vec3<f32>;
    var k_7: f32;
    var uv_3: vec2<f32>;
    var q_11: vec3<f32>;
    var ball: f32;
    var cap: f32;
    var jointSpace: vec3<f32>;
    var mass: f32;
    var param_351: vec3<f32>;
    var joints: f32;
    var param_352: vec3<f32>;
    var flakes: f32;
    var param_353: vec3<f32>;
    var scar: f32;
    var param_354: vec3<f32>;
    var breakage: f32;
    var west_1: f32;
    var east_1: f32;
    var face: f32;
    var param_355: f32;
    var param_356: f32;
    var param_357: f32;
    var lip: f32;
    var sheets: f32;
    var param_358: vec3<f32>;
    var d_6: f32;
    var param_359: f32;
    var param_360: f32;
    var param_361: f32;
    var param_362: f32;
    var param_363: f32;
    var param_364: f32;
    var skin: f32;
    var param_365: vec3<f32>;
    var foot: f32;
    var param_366: vec3<f32>;
    var toe: f32;
    var param_367: f32;
    var param_368: f32;
    var param_369: f32;
    var d_7: f32;
    var i_15: i32;
    var s_1: vec4<f32>;
    var indexable_9: array<vec4<f32>, 20>;
    var q_12: vec2<f32>;
    var down: f32;
    var lat_1: f32;
    var dep: f32;
    var angle_4: f32;
    var indexable_10: array<f32, 20>;
    var ac_1: vec2<f32>;
    var param_370: vec3<f32>;
    var param_371: vec3<f32>;
    var param_372: f32;
    var param_373: f32;
    var param_374: f32;
    var param_375: f32;
    var param_376: vec3<f32>;
    var param_377: vec4<f32>;
    var param_378: f32;
    var param_379: f32;
    var param_380: f32;
    var param_381: f32;
    var param_382: f32;
    var param_383: vec3<f32>;
    var param_384: vec4<f32>;
    var param_385: f32;
    var param_386: f32;
    var param_387: f32;
    var param_388: f32;
    var param_389: f32;
    var param_390: vec3<f32>;
    var param_391: vec4<f32>;
    var param_392: f32;
    var param_393: f32;
    var param_394: f32;
    var param_395: f32;
    var param_396: f32;
    var top: f32;
    var param_397: f32;
    var shoulder: f32;
    var i_16: i32;
    var s_2: vec4<f32>;
    var local_33: vec4<f32>;
    var dy_1: f32;
    var a_13: f32;
    var i_17: i32;
    var s_3: vec4<f32>;
    var local_34: vec4<f32>;
    var local_35: vec4<f32>;
    var dx_1: f32;
    var span_4: f32;
    var bed: f32;
    var slopeRun: f32;
    var crossRun: f32;
    var drainage: f32;
    var param_398: vec3<f32>;
    var gravel: f32;
    var param_399: vec3<f32>;
    var apronY: f32;
    var tal: f32;
    var param_400: f32;
    var param_401: f32;
    var param_402: f32;
    var spur: vec3<f32>;
    var shoulderFoot: f32;
    var param_403: vec3<f32>;
    var param_404: f32;
    var param_405: f32;
    var param_406: f32;
    var f_10: vec2<f32>;
    var param_407: vec3<f32>;
    var param_408: f32;
    var g_2: vec2<f32>;
    var param_409: vec3<f32>;
    var param_410: f32;
    var fault_1: f32;
    var param_411: vec3<f32>;
    var relief: f32;
    var phi_5036_: bool;

    let _e297 = object;
    if (_e297 == 3i) {
        let _e300 = (*p_30)[0u];
        x_11 = (_e300 - 1849f);
        let _e302 = x_11;
        let _e304 = x_11;
        let _e308 = x_11;
        let _e313 = x_11;
        crest = (((168f + max((-0.39f * _e302), (0.21f * _e304))) + (4f * sin((_e308 * 0.071f)))) + (2.2f * sin(((_e313 * 0.13f) + 0.8f))));
        let _e319 = crest;
        let _e321 = (*p_30)[2u];
        summit = (_e319 + (0.58f * abs(_e321)));
        let _e325 = summit;
        let _e327 = (*p_30)[1u];
        let _e330 = (*p_30)[2u];
        let _e333 = x_11;
        let _e337 = (*p_30)[1u];
        let _e341 = (*p_30);
        param_350 = (_e341 * 0.048f);
        let _e343 = valueNoise3vf3_((&param_350));
        let _e348 = (*p_30)[2u];
        let _e351 = (*p_30)[1u];
        return max(max((_e325 - _e327), ((((-(_e330) - 40f) - (0.17f * _e333)) - (0.22f * (_e337 - 195f))) + (3f * _e343))), max((_e348 - 90f), (_e351 - 435f)));
    }
    let _e355 = object;
    let _e357 = object;
    if ((_e355 == 1i) || (_e357 == 2i)) {
        let _e360 = object;
        k_7 = select(0.49f, 1f, (_e360 == 1i));
        let _e363 = object;
        uv_3 = select(vec2<f32>(1535f, 470f), vec2<f32>(1870f, 370f), vec2((_e363 == 1i)));
        let _e367 = (*p_30);
        let _e369 = uv_3;
        let _e370 = (_e367.xy - _e369);
        let _e372 = (*p_30)[2u];
        let _e376 = k_7;
        q_11 = (vec3<f32>(_e370.x, _e370.y, _e372) / vec3(_e376));
        let _e379 = object;
        if (_e379 == 2i) {
            let _e382 = q_11[1u];
            q_11[1u] = ((_e382 - 32f) / 0.56f);
        }
        let _e386 = q_11;
        let _e388 = q_11[1u];
        ball = ((length(((_e386 - vec3<f32>((24f + (0.26f * _e388)), 28f, 16f)) / vec3<f32>(308f, 209f, 119f))) - 1f) * 125f);
        let _e398 = q_11[0u];
        let _e402 = q_11[0u];
        let _e409 = q_11[0u];
        let _e416 = q_11[2u];
        let _e420 = q_11[1u];
        cap = (((((-137f - (0.105f * _e398)) + (0.31f * max((-(_e402) - 34f), 0f))) + (0.71f * max((-(_e409) - 116f), 0f))) - (0.16f * _e416)) - _e420);
        let _e423 = q_11[0u];
        let _e426 = q_11[1u];
        let _e430 = q_11[1u];
        let _e433 = q_11[2u];
        jointSpace = vec3<f32>(((0.031f * _e423) + (0.011f * _e426)), (0.018f * _e430), (0.025f * _e433));
        let _e436 = jointSpace;
        param_351 = (_e436 * 0.52f);
        let _e438 = valueNoise3vf3_((&param_351));
        mass = _e438;
        let _e439 = jointSpace;
        param_352 = _e439;
        let _e440 = valueNoise3vf3_((&param_352));
        joints = _e440;
        let _e441 = jointSpace;
        param_353 = (_e441 * 2.63f);
        let _e443 = valueNoise3vf3_((&param_353));
        flakes = abs((_e443 - 0.47f));
        let _e447 = q_11[0u];
        let _e450 = q_11[1u];
        let _e454 = q_11[1u];
        let _e457 = q_11[2u];
        param_354 = vec3<f32>(((0.025f * _e447) + (0.012f * _e450)), (_e454 * 0.009f), (_e457 * 0.022f));
        let _e460 = valueNoise3vf3_((&param_354));
        scar = abs((_e460 - 0.46f));
        let _e463 = mass;
        let _e466 = joints;
        let _e471 = flakes;
        let _e474 = scar;
        let _e476 = scar;
        breakage = ((((15f * (_e463 - 0.5f)) + (7f * abs((_e466 - 0.43f)))) + (2.5f * _e471)) + (5f * exp(((-(_e474) * _e476) * 290f))));
        let _e483 = q_11[2u];
        let _e487 = q_11[0u];
        let _e492 = q_11[1u];
        west_1 = (((-(_e483) - 100f) - (0.62f * (_e487 + 62f))) - (0.2f * _e492));
        let _e496 = q_11[2u];
        let _e500 = q_11[0u];
        let _e505 = q_11[1u];
        east_1 = (((-(_e496) - 104f) + (0.3f * (_e500 + 53f))) - (0.31f * _e505));
        let _e508 = west_1;
        let _e510 = east_1;
        param_355 = -(_e508);
        param_356 = -(_e510);
        param_357 = 42f;
        let _e512 = sminf1f1f1_((&param_355), (&param_356), (&param_357));
        let _e514 = breakage;
        face = (-(_e512) + _e514);
        let _e517 = q_11[0u];
        let _e519 = q_11[1u];
        let _e522 = mass;
        let _e526 = joints;
        lip = (((_e517 - (0.38f * _e519)) + (16f * (_e522 - 0.5f))) + (3.2f * _e526));
        let _e529 = lip;
        let _e532 = q_11[1u];
        let _e535 = q_11[2u];
        param_358 = vec3<f32>((_e529 * 0.032f), (_e532 * 0.01f), (_e535 * 0.026f));
        let _e538 = valueNoise3vf3_((&param_358));
        sheets = (2.2f * abs((_e538 - 0.38f)));
        let _e542 = ball;
        let _e544 = cap;
        let _e546 = mass;
        param_359 = -(_e542);
        param_360 = (-(_e544) - ((_e546 - 0.5f) * 9f));
        param_361 = 8f;
        let _e550 = sminf1f1f1_((&param_359), (&param_360), (&param_361));
        let _e551 = face;
        let _e552 = sheets;
        param_362 = _e550;
        param_363 = -((_e551 + _e552));
        param_364 = 15f;
        let _e555 = sminf1f1f1_((&param_362), (&param_363), (&param_364));
        d_6 = -(_e555);
        let _e557 = jointSpace;
        param_365 = (_e557 * 3.6f);
        let _e559 = valueNoise3vf3_((&param_365));
        skin = (0.87f * (_e559 - 0.5f));
        let _e563 = q_11[0u];
        let _e567 = q_11[2u];
        let _e573 = q_11[0u];
        let _e580 = q_11[0u];
        foot = ((((60f - (0.11f * _e563)) + (0.46f * abs((_e567 + 102f)))) + (0.0019f * pow(max((-120f - _e573), 0f), 2f))) + (0.074f * abs((_e580 + 15f))));
        let _e586 = q_11[0u];
        let _e589 = q_11[2u];
        param_366 = vec3<f32>((_e586 * 0.04f), 4f, (_e589 * 0.039f));
        let _e592 = valueNoise3vf3_((&param_366));
        let _e594 = foot;
        foot = (_e594 + (4f * _e592));
        let _e596 = foot;
        let _e598 = q_11[1u];
        let _e601 = q_11[2u];
        let _e607 = q_11[0u];
        let _e610 = q_11[0u];
        toe = max(max((_e596 - _e598), (abs((_e601 + 104f)) - 77f)), max((-252f - _e607), (_e610 - 285f)));
        let _e614 = k_7;
        let _e615 = object;
        let _e619 = d_6;
        let _e620 = skin;
        param_367 = (_e619 + _e620);
        let _e622 = toe;
        param_368 = _e622;
        param_369 = 3f;
        let _e623 = sminf1f1f1_((&param_367), (&param_368), (&param_369));
        return ((_e614 * select(1f, 0.56f, (_e615 == 2i))) * _e623);
    }
    d_7 = 1000f;
    i_15 = 0i;
    loop {
        let _e625 = i_15;
        if (_e625 < 20i) {
            let _e627 = i_15;
            indexable_9 = array<vec4<f32>, 20>(vec4<f32>(1022f, 349f, 67f, -28f), vec4<f32>(1098f, 281f, 50f, -34f), vec4<f32>(1158f, 229f, 49f, -51f), vec4<f32>(1208f, 234f, 45f, -14f), vec4<f32>(1256f, 207f, 43f, -21f), vec4<f32>(1318f, 156f, 39f, -52f), vec4<f32>(1356f, 128f, 31f, -32f), vec4<f32>(1420f, 50f, 46f, -74f), vec4<f32>(1457f, 60f, 37f, -41f), vec4<f32>(1494f, 52f, 28f, -17f), vec4<f32>(1534f, 40f, 54f, -57f), vec4<f32>(1584f, 74f, 42f, -25f), vec4<f32>(1624f, 98f, 55f, -20f), vec4<f32>(1670f, 122f, 48f, -34f), vec4<f32>(1725f, 146f, 58f, -9f), vec4<f32>(1803f, 153f, 64f, -16f), vec4<f32>(1874f, 169f, 69f, -2f), vec4<f32>(1970f, 207f, 87f, 4f), vec4<f32>(1475f, 175f, 36f, -105f), vec4<f32>(1277f, 282f, 45f, -91f));
            let _e629 = indexable_9[_e627];
            s_1 = _e629;
            let _e630 = (*p_30);
            let _e632 = s_1;
            q_12 = (_e630.xy - _e632.xy);
            let _e635 = q_12;
            down = dot(_e635, vec2<f32>(-0.368f, 0.93f));
            let _e637 = q_12;
            lat_1 = dot(_e637, vec2<f32>(0.93f, 0.368f));
            let _e640 = (*p_30)[2u];
            let _e641 = down;
            let _e646 = s_1[3u];
            let _e649 = down;
            let _e651 = down;
            dep = (((_e640 + (0.32f * max(_e641, 0f))) - (_e646 + 69f)) + ((0.00032f * _e649) * _e651));
            let _e654 = i_15;
            indexable_10 = array<f32, 20>(8f, -3f, 5f, -4f, 6f, -5f, 5f, -4f, 4f, -5f, 6f, -5f, 4f, -6f, 3f, 5f, -4f, 3f, 8f, -5f);
            let _e656 = indexable_10[_e654];
            let _e658 = s_1[0u];
            angle_4 = radians((_e656 + select(-13f, 26f, (_e658 < 1470f))));
            let _e663 = angle_4;
            let _e665 = angle_4;
            let _e667 = angle_4;
            let _e670 = angle_4;
            let _e675 = lat_1;
            let _e676 = dep;
            ac_1 = (mat2x2<f32>(vec2<f32>(cos(_e663), sin(_e665)), vec2<f32>(-(sin(_e667)), cos(_e670))) * vec2<f32>(_e675, _e676));
            let _e680 = ac_1[0u];
            let _e681 = down;
            let _e684 = ac_1[1u];
            let _e687 = s_1[2u];
            let _e688 = down;
            param_370 = vec3<f32>(_e680, (_e681 - 177f), _e684);
            param_371 = vec3<f32>((_e687 + (0.043f * max(_e688, 0f))), 194f, 76f);
            param_372 = 6.5f;
            let _e693 = roundBoxvf3vf3f1_((&param_370), (&param_371), (&param_372));
            let _e694 = d_7;
            param_373 = _e694;
            param_374 = _e693;
            param_375 = 4f;
            let _e695 = sminf1f1f1_((&param_373), (&param_374), (&param_375));
            d_7 = _e695;
            continue;
        } else {
            break;
        }
        continuing {
            let _e696 = i_15;
            i_15 = (_e696 + 1i);
        }
    }
    let _e698 = (*p_30);
    param_376 = _e698;
    param_377 = vec4<f32>(1473f, 166f, 0.69f, -163f);
    param_378 = 57f;
    param_379 = 197f;
    let _e699 = buttressvf3vf4f1f1_((&param_376), (&param_377), (&param_378), (&param_379));
    let _e700 = d_7;
    param_380 = _e700;
    param_381 = _e699;
    param_382 = 3f;
    let _e701 = sminf1f1f1_((&param_380), (&param_381), (&param_382));
    d_7 = _e701;
    let _e702 = (*p_30);
    param_383 = _e702;
    param_384 = vec4<f32>(1414f, 83f, 0.35f, -127f);
    param_385 = 48f;
    param_386 = 236f;
    let _e703 = buttressvf3vf4f1f1_((&param_383), (&param_384), (&param_385), (&param_386));
    let _e704 = d_7;
    param_387 = _e704;
    param_388 = _e703;
    param_389 = 3f;
    let _e705 = sminf1f1f1_((&param_387), (&param_388), (&param_389));
    d_7 = _e705;
    let _e706 = (*p_30);
    param_390 = _e706;
    param_391 = vec4<f32>(1160f, 251f, 0.46f, -86f);
    param_392 = 29f;
    param_393 = 90f;
    let _e707 = buttressvf3vf4f1f1_((&param_390), (&param_391), (&param_392), (&param_393));
    let _e708 = d_7;
    param_394 = _e708;
    param_395 = _e707;
    param_396 = 3f;
    let _e709 = sminf1f1f1_((&param_394), (&param_395), (&param_396));
    d_7 = _e709;
    let _e711 = (*p_30)[0u];
    param_397 = _e711;
    let _e712 = rooff1_((&param_397));
    top = _e712;
    let _e714 = (*p_30)[0u];
    shoulder = (0.23f + (0.24f * smoothstep(20f, 125f, abs((_e714 - 1450f)))));
    let _e720 = d_7;
    let _e721 = top;
    let _e722 = shoulder;
    let _e724 = (*p_30)[2u];
    let _e730 = (*p_30)[2u];
    let _e735 = (*p_30)[1u];
    d_7 = max(_e720, ((((_e721 + (_e722 * max(-(_e724), 0f))) + (0.61f * max(_e730, 0f))) - _e735) * 0.72f));
    i_16 = 0i;
    loop {
        let _e739 = i_16;
        if (_e739 < 3i) {
            let _e741 = i_16;
            if (_e741 == 0i) {
                local_33 = vec4<f32>(1479f, 99f, 9f, 48f);
            } else {
                let _e743 = i_16;
                local_33 = select(vec4<f32>(1209f, 272f, 15f, 114f), vec4<f32>(1352f, 187f, 8f, 110f), vec4((_e743 == 1i)));
            }
            let _e747 = local_33;
            s_2 = _e747;
            let _e749 = (*p_30)[1u];
            let _e751 = s_2[1u];
            dy_1 = (_e749 - _e751);
            let _e754 = (*p_30)[0u];
            let _e756 = s_2[0u];
            let _e758 = dy_1;
            a_13 = ((_e754 - _e756) + (0.37f * _e758));
            let _e761 = d_7;
            let _e762 = a_13;
            let _e765 = s_2[2u];
            let _e767 = dy_1;
            let _e770 = dy_1;
            let _e773 = dy_1;
            let _e775 = s_2[3u];
            let _e778 = (*p_30)[2u];
            let _e780 = a_13;
            let _e784 = dy_1;
            d_7 = max(_e761, -(max(max(((abs(_e762) - _e765) + (0.075f * _e767)), (-0.8f * _e770)), max((_e773 - _e775), (((_e778 + 56f) + (0.6f * abs(_e780))) - (0.24f * _e784))))));
            continue;
        } else {
            break;
        }
        continuing {
            let _e791 = i_16;
            i_16 = (_e791 + 1i);
        }
    }
    i_17 = 0i;
    loop {
        let _e793 = i_17;
        if (_e793 < 4i) {
            let _e795 = i_17;
            if (_e795 == 0i) {
                local_34 = vec4<f32>(1602f, 183f, 95f, 13f);
            } else {
                let _e797 = i_17;
                if (_e797 == 1i) {
                    local_35 = vec4<f32>(1618f, 231f, 116f, 21f);
                } else {
                    let _e799 = i_17;
                    local_35 = select(vec4<f32>(1490f, 130f, 38f, 8f), vec4<f32>(1630f, 268f, 87f, 18f), vec4((_e799 == 2i)));
                }
                let _e803 = local_35;
                local_34 = _e803;
            }
            let _e804 = local_34;
            s_3 = _e804;
            let _e806 = (*p_30)[0u];
            let _e808 = s_3[0u];
            dx_1 = (_e806 - _e808);
            let _e810 = dx_1;
            let _e811 = dx_1;
            let _e814 = s_3[2u];
            let _e816 = s_3[2u];
            span_4 = max(0f, (1f - ((_e810 * _e811) / (_e814 * _e816))));
            let _e822 = (*p_30)[1u];
            let _e824 = s_3[1u];
            let _e826 = dx_1;
            let _e829 = dx_1;
            bed = (((_e822 - _e824) - (0.33f * _e826)) - (2.1f * sin((0.032f * _e829))));
            let _e834 = d_7;
            let _e835 = bed;
            let _e837 = span_4;
            let _e840 = bed;
            let _e842 = (*p_30)[2u];
            let _e847 = dx_1;
            let _e850 = s_3[2u];
            let _e853 = (*p_30)[2u];
            let _e856 = s_3[3u];
            let _e857 = span_4;
            let _e860 = dx_1;
            d_7 = max(_e834, -(max(max((-(_e835) - (6.5f * _e837)), (_e840 + (0.36f * (_e842 + 90f)))), max((abs(_e847) - _e850), (((_e853 + 20f) - (_e856 * _e857)) + (0.09f * _e860))))));
            continue;
        } else {
            break;
        }
        continuing {
            let _e867 = i_17;
            i_17 = (_e867 + 1i);
        }
    }
    let _e870 = (*p_30)[2u];
    slopeRun = (-(_e870) - 108f);
    let _e874 = (*p_30)[0u];
    let _e876 = (*p_30)[2u];
    crossRun = (_e874 + (0.31f * _e876));
    let _e879 = crossRun;
    let _e882 = (*p_30)[2u];
    param_398 = vec3<f32>((_e879 * 0.023f), (_e882 * 0.012f), 3f);
    let _e885 = valueNoise3vf3_((&param_398));
    drainage = _e885;
    let _e886 = crossRun;
    let _e889 = (*p_30)[2u];
    param_399 = vec3<f32>((_e886 * 0.078f), (_e889 * 0.038f), 7f);
    let _e892 = valueNoise3vf3_((&param_399));
    gravel = _e892;
    let _e894 = (*p_30)[0u];
    let _e898 = slopeRun;
    let _e899 = slopeRun;
    let _e906 = (*p_30)[0u];
    let _e912 = (*p_30)[0u];
    let _e917 = drainage;
    let _e921 = gravel;
    apronY = ((((((353f - (0.065f * (_e894 - 1190f))) + (0.49f * sqrt(((_e898 * _e899) + 180f)))) + (0.47f * max((1130f - _e906), 0f))) + (0.39f * max((_e912 - 1400f), 0f))) + (10f * (_e917 - 0.5f))) + (3.8f * (_e921 - 0.5f)));
    let _e925 = apronY;
    let _e927 = (*p_30)[1u];
    let _e931 = (*p_30)[0u];
    let _e935 = (*p_30)[0u];
    tal = max(((_e925 - _e927) * 0.79f), max(((1040f - _e931) * 0.59f), ((_e935 - 1540f) * 0.61f)));
    let _e940 = tal;
    let _e942 = (*p_30)[2u];
    let _e946 = (*p_30)[2u];
    tal = max(_e940, max((-(_e942) - 317f), (_e946 - 168f)));
    let _e950 = d_7;
    param_400 = _e950;
    let _e951 = tal;
    param_401 = _e951;
    param_402 = 7f;
    let _e952 = sminf1f1f1_((&param_400), (&param_401), (&param_402));
    d_7 = _e952;
    let _e953 = (*p_30);
    spur = ((_e953 - vec3<f32>(1127f, 402f, -130f)) / vec3<f32>(128f, 39f, 82f));
    let _e956 = spur;
    let _e960 = (*p_30);
    param_403 = (_e960 * 0.035f);
    let _e962 = valueNoise3vf3_((&param_403));
    shoulderFoot = (((length(_e956) - 1f) * 38f) + (4f * _e962));
    let _e965 = d_7;
    param_404 = _e965;
    let _e966 = shoulderFoot;
    param_405 = _e966;
    param_406 = 6f;
    let _e967 = sminf1f1f1_((&param_404), (&param_405), (&param_406));
    d_7 = _e967;
    let _e968 = d_7;
    let _e970 = (abs(_e968) < 10f);
    phi_5036_ = _e970;
    if _e970 {
        let _e972 = (*p_30)[1u];
        let _e973 = top;
        phi_5036_ = (_e972 > (_e973 + 2f));
    }
    let _e977 = phi_5036_;
    let _e978 = tal;
    if (_e977 && (_e978 > 2f)) {
        let _e981 = (*p_30);
        param_407 = _e981;
        param_408 = 24f;
        let _e982 = facetsvf3f1_((&param_407), (&param_408));
        f_10 = _e982;
        let _e983 = (*p_30);
        param_409 = _e983;
        param_410 = 8f;
        let _e984 = facetsvf3f1_((&param_409), (&param_410));
        g_2 = _e984;
        let _e986 = (*p_30)[0u];
        let _e989 = (*p_30)[1u];
        let _e993 = (*p_30)[1u];
        let _e996 = (*p_30)[2u];
        param_411 = vec3<f32>(((0.037f * _e986) + (0.014f * _e989)), (0.02f * _e993), (0.033f * _e996));
        let _e999 = valueNoise3vf3_((&param_411));
        fault_1 = abs((_e999 - 0.48f));
        let _e1003 = f_10[0u];
        let _e1006 = g_2[0u];
        let _e1010 = f_10[1u];
        let _e1013 = f_10[1u];
        let _e1019 = fault_1;
        relief = ((((4.2f * _e1003) + (1.15f * _e1006)) + (0.62f * exp(((-(_e1010) * _e1013) * 0.36f)))) + (6.8f * _e1019));
        let _e1023 = (*p_30)[1u];
        let _e1024 = top;
        let _e1027 = tal;
        let _e1030 = relief;
        let _e1032 = d_7;
        d_7 = (_e1032 + ((smoothstep(2f, 15f, (_e1023 - _e1024)) * smoothstep(2f, 14f, _e1027)) * _e1030));
    }
    let _e1034 = d_7;
    return _e1034;
}

fn sdvf3_(p_31: ptr<function, vec3<f32>>) -> f32 {
    var param_412: vec3<f32>;

    let _e2 = (*p_31);
    param_412 = _e2;
    let _e3 = rockFieldvf3_((&param_412));
    return _e3;
}

fn axes() -> vec3<f32> {
    let _e2 = strike;
    return vec3<f32>(_e2.x, _e2.y, 1f);
}

fn localDirvf3_(v_8: ptr<function, vec3<f32>>) -> vec3<f32> {
    var a_14: vec3<f32>;

    let _e5 = axes();
    a_14 = _e5;
    let _e7 = (*v_8)[0u];
    let _e9 = a_14[0u];
    let _e11 = (*v_8)[2u];
    let _e15 = (*v_8)[1u];
    let _e18 = a_14[1u];
    let _e20 = (*v_8)[2u];
    let _e24 = (*v_8)[2u];
    return vec3<f32>((_e7 - (_e9 * _e11)), (-(_e15) + (_e18 * _e20)), _e24);
}

fn softShadowvf3vf3vf3_(p_32: ptr<function, vec3<f32>>, n_6: ptr<function, vec3<f32>>, light: ptr<function, vec3<f32>>) -> f32 {
    var ray_2: vec3<f32>;
    var param_413: vec3<f32>;
    var start_3: vec3<f32>;
    var param_414: vec3<f32>;
    var t_11: f32;
    var v_9: f32;
    var i_18: i32;
    var h_9: f32;
    var param_415: vec3<f32>;

    let _e25 = (*light);
    param_413 = _e25;
    let _e26 = localDirvf3_((&param_413));
    ray_2 = _e26;
    let _e27 = (*p_32);
    let _e28 = (*n_6);
    param_414 = _e28;
    let _e29 = localDirvf3_((&param_414));
    start_3 = (_e27 + (_e29 * 2.4f));
    t_11 = 3f;
    v_9 = 1f;
    i_18 = 0i;
    loop {
        let _e32 = i_18;
        if (_e32 < 24i) {
            let _e34 = start_3;
            let _e35 = ray_2;
            let _e36 = t_11;
            param_415 = (_e34 + (_e35 * _e36));
            let _e39 = sdvf3_((&param_415));
            h_9 = _e39;
            let _e40 = v_9;
            let _e41 = h_9;
            let _e44 = t_11;
            v_9 = min(_e40, ((5f * max(_e41, 0f)) / _e44));
            let _e47 = h_9;
            let _e49 = t_11;
            if ((_e47 < -0.6f) || (_e49 > 100f)) {
                break;
            }
            let _e52 = h_9;
            let _e55 = t_11;
            t_11 = (_e55 + clamp((_e52 * 0.72f), 2f, 17f));
            continue;
        } else {
            break;
        }
        continuing {
            let _e57 = i_18;
            i_18 = (_e57 + 1i);
        }
    }
    let _e59 = v_9;
    return smoothstep(0f, 1f, _e59);
}

fn worldNormalvf3_(g_3: ptr<function, vec3<f32>>) -> vec3<f32> {
    var a_15: vec3<f32>;

    let _e5 = axes();
    a_15 = _e5;
    let _e7 = (*g_3)[0u];
    let _e9 = (*g_3)[1u];
    let _e12 = (*g_3)[2u];
    let _e14 = a_15[0u];
    let _e16 = (*g_3)[0u];
    let _e20 = a_15[1u];
    let _e22 = (*g_3)[1u];
    return normalize(vec3<f32>(_e7, -(_e9), ((_e12 - (_e14 * _e16)) + (_e20 * _e22))));
}

fn gradientvf3f1_(p_33: ptr<function, vec3<f32>>, e_1: ptr<function, f32>) -> vec3<f32> {
    var g_4: vec3<f32>;
    var plus: f32;
    var i_19: i32;
    var offset_1: vec3<f32>;
    var d_8: f32;
    var local_36: vec3<f32>;
    var param_416: vec3<f32>;

    g_4 = vec3<f32>(0f, 0f, 0f);
    plus = 0f;
    i_19 = 0i;
    loop {
        let _e15 = i_19;
        if (_e15 < 6i) {
            offset_1 = vec3<f32>(0f, 0f, 0f);
            let _e17 = i_19;
            let _e19 = (*e_1);
            offset_1[(_e17 / 2i)] = _e19;
            let _e21 = i_19;
            if ((_e21 - (i32(floor((f32(_e21) / f32(2i)))) * 2i)) == 0i) {
                let _e30 = (*p_33);
                let _e31 = offset_1;
                local_36 = (_e30 + _e31);
            } else {
                let _e33 = (*p_33);
                let _e34 = offset_1;
                local_36 = (_e33 - _e34);
            }
            let _e36 = local_36;
            param_416 = _e36;
            let _e37 = sdvf3_((&param_416));
            d_8 = _e37;
            let _e38 = i_19;
            if ((_e38 - (i32(floor((f32(_e38) / f32(2i)))) * 2i)) == 0i) {
                let _e47 = d_8;
                plus = _e47;
            } else {
                let _e48 = i_19;
                let _e50 = plus;
                let _e51 = d_8;
                g_4[(_e48 / 2i)] = (_e50 - _e51);
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e54 = i_19;
            i_19 = (_e54 + 1i);
        }
    }
    let _e56 = g_4;
    return _e56;
}

fn rockColorvf3vf3vf3_(p_34: ptr<function, vec3<f32>>, wp_1: ptr<function, vec3<f32>>, eye: ptr<function, vec3<f32>>) -> vec3<f32> {
    var raw: vec3<f32>;
    var param_417: vec3<f32>;
    var param_418: f32;
    var n_7: vec3<f32>;
    var param_419: vec3<f32>;
    var light_1: vec3<f32>;
    var occ: f32;
    var param_420: vec3<f32>;
    var param_421: vec3<f32>;
    var param_422: vec3<f32>;
    var param_423: vec3<f32>;
    var shadow: f32;
    var param_424: vec3<f32>;
    var param_425: vec3<f32>;
    var param_426: vec3<f32>;
    var param_427: vec3<f32>;
    var param_428: vec3<f32>;
    var param_429: bool;
    var crack: f32;
    var grit_1: f32;
    var param_430: vec3<f32>;
    var coords: vec3<f32>;
    var weather: f32;
    var param_431: vec3<f32>;
    var f_11: f32;
    var grad: vec3<f32>;
    var param_432: vec3<f32>;
    var param_433: vec3<f32>;
    var param_434: vec3<f32>;
    var joint: f32;
    var scratch: f32;
    var param_435: vec3<f32>;
    var score: f32;
    var param_436: vec3<f32>;
    var param_437: vec3<f32>;
    var param_438: vec3<f32>;
    var param_439: f32;
    var q_13: vec2<f32>;
    var local_37: vec2<f32>;
    var local_38: vec3<f32>;
    var local_39: vec3<f32>;
    var coarse_1: vec2<f32>;
    var param_440: vec3<f32>;
    var param_441: f32;
    var exposure_1: f32;
    var param_442: vec3<f32>;
    var seam: f32;
    var uvw: vec3<f32>;
    var grain: f32;
    var param_443: vec3<f32>;
    var g_5: vec3<f32>;
    var param_444: vec3<f32>;
    var param_445: vec3<f32>;
    var param_446: vec3<f32>;
    var param_447: vec3<f32>;
    var param_448: vec3<f32>;
    var direct: f32;
    var bounce: f32;
    var diffuse: f32;
    var c_10: vec3<f32>;
    var snow_1: f32;
    var shelf_2: f32;
    var param_449: vec3<f32>;
    var param_450: f32;
    var param_451: vec3<f32>;
    var shelter: f32;
    var param_452: vec3<f32>;
    var param_453: vec3<f32>;
    var grains: f32;
    var param_454: vec3<f32>;
    var param_455: vec3<f32>;
    var apron: f32;
    var i_20: i32;
    var uv_4: vec2<f32>;
    var local_40: vec2<f32>;
    var down_1: f32;
    var ledge: f32;
    var j_11: i32;
    var s_4: vec3<f32>;
    var local_41: vec3<f32>;
    var local_42: vec3<f32>;
    var dx_2: f32;
    var bed_1: f32;
    var gully: f32;
    var run: f32;
    var crossRun_1: f32;
    var floorY: f32;
    var param_456: vec3<f32>;
    var param_457: vec3<f32>;
    var track: f32;
    var param_458: vec3<f32>;
    var catchment: f32;
    var albedo_1: vec3<f32>;
    var param_459: vec3<f32>;
    var radiance: vec3<f32>;
    var param_460: vec3<f32>;
    var reflectedKey: f32;
    var param_461: vec3<f32>;
    var param_462: vec3<f32>;
    var weather_1: f32;
    var param_463: vec3<f32>;
    var dry_1: f32;
    var param_464: vec3<f32>;
    var param_465: vec3<f32>;
    var east_2: f32;
    var split: f32;
    var param_466: vec3<f32>;
    var cleft: f32;
    var band: f32;
    var param_467: vec3<f32>;
    var inclusion: f32;
    var param_468: vec3<f32>;
    var param_469: vec3<f32>;
    var ridge_1: f32;
    var grass_1: f32;
    var local_43: f32;
    var local_44: f32;
    var param_470: vec3<f32>;
    var q_14: vec3<f32>;
    var local_45: vec3<f32>;
    var cap_1: f32;
    var damp: f32;
    var param_471: vec3<f32>;
    var below: f32;
    var lip_1: f32;
    var param_472: vec3<f32>;
    var param_473: vec3<f32>;
    var foot_1: vec4<f32>;
    var param_474: vec2<f32>;
    var ground_1: f32;
    var param_475: vec2<f32>;
    var gap: f32;
    var param_476: vec3<f32>;
    var cover: f32;
    var litter: f32;
    var param_477: vec3<f32>;
    var param_478: vec3<f32>;
    var param_479: vec3<f32>;
    var param_480: vec3<f32>;
    var param_481: vec3<f32>;
    var param_482: vec3<f32>;
    var param_483: vec3<f32>;
    var phi_6507_: bool;

    let _e357 = (*p_34);
    param_417 = _e357;
    param_418 = 0.594f;
    let _e358 = gradientvf3f1_((&param_417), (&param_418));
    raw = _e358;
    let _e359 = raw;
    param_419 = _e359;
    let _e360 = worldNormalvf3_((&param_419));
    n_7 = _e360;
    let _e361 = sunlight();
    light_1 = _e361;
    let _e362 = (*p_34);
    let _e363 = n_7;
    param_420 = _e363;
    let _e364 = localDirvf3_((&param_420));
    param_421 = (_e362 + (_e364 * 6f));
    let _e367 = sdvf3_((&param_421));
    let _e371 = (*p_34);
    let _e372 = n_7;
    param_422 = _e372;
    let _e373 = localDirvf3_((&param_422));
    param_423 = (_e371 + (_e373 * 19f));
    let _e376 = sdvf3_((&param_423));
    occ = clamp(((0.6f * (1f - (_e367 / 6f))) + (0.4f * (1f - (_e376 / 19f)))), 0f, 0.88f);
    let _e382 = (*p_34);
    param_424 = _e382;
    let _e383 = n_7;
    param_425 = _e383;
    let _e384 = light_1;
    param_426 = _e384;
    let _e385 = softShadowvf3vf3vf3_((&param_424), (&param_425), (&param_426));
    shadow = _e385;
    if true {
        let _e386 = (*wp_1);
        let _e387 = n_7;
        param_427 = (_e386 + (_e387 * 2f));
        let _e390 = light_1;
        param_428 = _e390;
        param_429 = true;
        let _e391 = castVisibilityvf3vf3b1_((&param_427), (&param_428), (&param_429));
        let _e392 = shadow;
        shadow = (_e392 * _e391);
    }
    crack = 0f;
    let _e394 = (*p_34);
    param_430 = (_e394 * 0.75f);
    let _e396 = valueNoise3vf3_((&param_430));
    grit_1 = _e396;
    let _e397 = object;
    if (_e397 == 0i) {
        let _e400 = (*p_34)[0u];
        let _e403 = (*p_34)[1u];
        let _e407 = (*p_34)[1u];
        let _e410 = (*p_34)[2u];
        coords = (vec3<f32>(((0.83f * _e400) + (0.37f * _e403)), (_e407 * 0.5f), _e410) * 0.079f);
        let _e413 = coords;
        param_431 = _e413;
        let _e414 = valueNoise3vf3_((&param_431));
        weather = _e414;
        let _e415 = weather;
        f_11 = (_e415 - 0.5f);
        let _e417 = coords;
        param_432 = (_e417 + vec3<f32>(0.14f, 0f, 0f));
        let _e419 = valueNoise3vf3_((&param_432));
        let _e420 = weather;
        let _e422 = coords;
        param_433 = (_e422 + vec3<f32>(0f, 0.14f, 0f));
        let _e424 = valueNoise3vf3_((&param_433));
        let _e425 = weather;
        let _e427 = coords;
        param_434 = (_e427 + vec3<f32>(0f, 0f, 0.14f));
        let _e429 = valueNoise3vf3_((&param_434));
        let _e430 = weather;
        grad = vec3<f32>((_e419 - _e420), (_e424 - _e425), (_e429 - _e430));
        let _e433 = n_7;
        let _e434 = grad;
        let _e435 = n_7;
        let _e436 = n_7;
        let _e437 = grad;
        let _e441 = f_11;
        n_7 = normalize((_e433 - ((_e434 - (_e435 * dot(_e436, _e437))) * (1.25f + (0.9f * abs(_e441))))));
    }
    if true {
        let _e448 = object;
        if (_e448 == 0i) {
            let _e451 = (*p_34)[0u];
            let _e454 = (*p_34)[1u];
            joint = ((_e451 * 0.93f) + (_e454 * 0.368f));
            let _e457 = joint;
            let _e459 = (*p_34);
            param_435 = (_e459 * 0.045f);
            let _e461 = valueNoise3vf3_((&param_435));
            scratch = abs((fract(((_e457 * 0.23f) + (0.14f * _e461))) - 0.5f));
            let _e467 = joint;
            let _e468 = fwidth(_e467);
            let _e471 = scratch;
            let _e474 = (*p_34);
            param_436 = (_e474 * 0.052f);
            let _e476 = valueNoise3vf3_((&param_436));
            score = ((1f - smoothstep(0.025f, (0.09f + (_e468 * 0.085f)), _e471)) * smoothstep(0.41f, 0.66f, _e476));
            let _e479 = (*p_34);
            param_437 = (_e479 * 0.038f);
            let _e481 = valueNoise3vf3_((&param_437));
            let _e483 = (*p_34);
            param_438 = _e483;
            param_439 = 24f;
            let _e484 = facetsvf3f1_((&param_438), (&param_439));
            let _e490 = score;
            let _e493 = (*p_34)[0u];
            crack = clamp((((smoothstep(0.28f, 0.7f, _e481) * (1f - smoothstep(0.16f, 1.4f, _e484.y))) * 0.55f) + ((_e490 * 0.47f) * (1f - smoothstep(1430f, 1495f, _e493)))), 0f, 1f);
        }
        let _e499 = object;
        let _e501 = object;
        if ((_e499 == 1i) || (_e501 == 2i)) {
            let _e504 = object;
            if (_e504 == 1i) {
                let _e506 = (*p_34);
                local_37 = _e506.xy;
            } else {
                let _e508 = (*p_34);
                local_37 = (vec2<f32>(1870f, 370f) + ((_e508.xy - vec2<f32>(1535f, 470f)) / vec2(0.49f)));
            }
            let _e514 = local_37;
            q_13 = _e514;
            let _e515 = object;
            if (_e515 == 1i) {
                let _e517 = (*p_34);
                local_39 = _e517;
            } else {
                let _e518 = (*p_34);
                let _e523 = (((_e518.xy - vec2<f32>(1535f, 470f)) / vec2(0.49f)) + vec2<f32>(1870f, 370f));
                let _e525 = (*p_34)[2u];
                local_39 = vec3<f32>(_e523.x, _e523.y, (_e525 / 0.49f));
            }
            let _e530 = local_39;
            local_38 = _e530;
            let _e531 = local_38;
            param_440 = (_e531 * 0.86f);
            param_441 = 20f;
            let _e533 = facetsvf3f1_((&param_440), (&param_441));
            coarse_1 = _e533;
            let _e534 = local_38;
            param_442 = (_e534 * 0.028f);
            let _e536 = valueNoise3vf3_((&param_442));
            exposure_1 = _e536;
            let _e538 = coarse_1[1u];
            let _e541 = exposure_1;
            seam = ((1f - smoothstep(0.25f, 1.45f, _e538)) * smoothstep(0.3f, 0.74f, _e541));
            let _e545 = local_38[0u];
            let _e548 = local_38[1u];
            let _e552 = local_38[1u];
            let _e555 = local_38[2u];
            uvw = vec3<f32>(((_e545 * 0.13f) + (_e548 * 0.047f)), (_e552 * 0.093f), (_e555 * 0.074f));
            let _e558 = uvw;
            param_443 = _e558;
            let _e559 = valueNoise3vf3_((&param_443));
            grain = _e559;
            let _e560 = uvw;
            param_444 = (_e560 + vec3<f32>(0.17f, 0f, 0f));
            let _e562 = valueNoise3vf3_((&param_444));
            let _e563 = grain;
            let _e565 = uvw;
            param_445 = (_e565 + vec3<f32>(0f, 0.17f, 0f));
            let _e567 = valueNoise3vf3_((&param_445));
            let _e568 = grain;
            let _e570 = uvw;
            param_446 = (_e570 + vec3<f32>(0f, 0f, 0.17f));
            let _e572 = valueNoise3vf3_((&param_446));
            let _e573 = grain;
            g_5 = vec3<f32>((_e562 - _e563), (_e567 - _e568), (_e572 - _e573));
            let _e576 = n_7;
            let _e577 = g_5;
            let _e578 = g_5;
            let _e579 = n_7;
            let _e581 = n_7;
            n_7 = normalize((_e576 - ((_e577 - (_e581 * dot(_e578, _e579))) * 0.64f)));
            let _e587 = seam;
            crack = (0.79f * _e587);
        }
        let _e589 = n_7;
        let _e590 = grit_1;
        let _e592 = (*p_34);
        param_447 = ((_e592 * 0.61f) + vec3(19f));
        let _e596 = valueNoise3vf3_((&param_447));
        let _e598 = (*p_34);
        param_448 = ((_e598 * 0.64f) + vec3(8f));
        let _e602 = valueNoise3vf3_((&param_448));
        n_7 = normalize((_e589 + (vec3<f32>((_e590 - 0.5f), (_e596 - 0.5f), (_e602 - 0.5f)) * 0.025f)));
    }
    let _e608 = n_7;
    let _e609 = light_1;
    let _e612 = shadow;
    direct = (max(0f, dot(_e608, _e609)) * mix(0.33f, 1f, _e612));
    let _e616 = n_7[1u];
    let _e620 = n_7[2u];
    bounce = clamp(((0.55f - (0.32f * _e616)) - (0.22f * _e620)), 0f, 1f);
    let _e624 = direct;
    let _e628 = n_7[1u];
    let _e632 = bounce;
    diffuse = ((((0.68f * _e624) + 0.2f) + (0.17f * max(_e628, 0f))) + (0.045f * _e632));
    let _e635 = diffuse;
    let _e636 = occ;
    let _e642 = crack;
    c_10 = vec3((pow(max(0.012f, (_e635 * (1f - (0.25f * _e636)))), 0.76f) * (1f - (0.3f * _e642))));
    snow_1 = 0f;
    let _e647 = object;
    if (true && (_e647 == 0i)) {
        let _e650 = (*p_34);
        param_449 = _e650;
        param_450 = 3.4f;
        let _e651 = gradientvf3f1_((&param_449), (&param_450));
        param_451 = _e651;
        let _e652 = worldNormalvf3_((&param_451));
        shelf_2 = smoothstep(0.765f, 0.825f, _e652.y);
        let _e655 = occ;
        let _e658 = shadow;
        let _e662 = (*p_34);
        param_452 = (_e662 + vec3<f32>(0f, 0f, -7f));
        let _e664 = sdvf3_((&param_452));
        let _e665 = (*p_34);
        param_453 = (_e665 + vec3<f32>(0f, -7f, 0f));
        let _e667 = sdvf3_((&param_453));
        shelter = clamp((((0.08f + (_e655 * 2f)) + ((1f - _e658) * 0.52f)) + (max(0f, (_e664 - _e667)) * 0.04f)), 0f, 1f);
        let _e673 = (*p_34);
        param_454 = (_e673 * 0.19f);
        let _e675 = valueNoise3vf3_((&param_454));
        let _e677 = (*p_34);
        param_455 = (_e677 * 0.052f);
        let _e679 = valueNoise3vf3_((&param_455));
        grains = ((_e675 * 0.32f) + (_e679 * 0.68f));
        apron = 0f;
        i_20 = 0i;
        loop {
            let _e682 = i_20;
            if (_e682 < 3i) {
                let _e684 = i_20;
                if (_e684 == 0i) {
                    local_40 = vec2<f32>(1090f, 323f);
                } else {
                    let _e686 = i_20;
                    local_40 = select(vec2<f32>(1328f, 293f), vec2<f32>(1200f, 313f), vec2((_e686 == 1i)));
                }
                let _e690 = local_40;
                uv_4 = _e690;
                let _e692 = (*p_34)[1u];
                let _e694 = uv_4[1u];
                down_1 = (_e692 - _e694);
                let _e696 = apron;
                let _e697 = down_1;
                let _e699 = down_1;
                let _e704 = (*p_34)[0u];
                let _e706 = uv_4[0u];
                let _e708 = down_1;
                let _e712 = down_1;
                apron = max(_e696, ((smoothstep(0f, 15f, _e697) * (1f - smoothstep(52f, 91f, _e699))) * (1f - smoothstep(0.5f, 1f, (abs(((_e704 - _e706) + (0.37f * _e708))) / (6f + (0.48f * max(0f, _e712))))))));
                continue;
            } else {
                break;
            }
            continuing {
                let _e721 = i_20;
                i_20 = (_e721 + 1i);
            }
        }
        ledge = 0f;
        j_11 = 0i;
        loop {
            let _e723 = j_11;
            if (_e723 < 4i) {
                let _e725 = j_11;
                if (_e725 == 0i) {
                    local_41 = vec3<f32>(1602f, 183f, 95f);
                } else {
                    let _e727 = j_11;
                    if (_e727 == 1i) {
                        local_42 = vec3<f32>(1618f, 231f, 116f);
                    } else {
                        let _e729 = j_11;
                        local_42 = select(vec3<f32>(1490f, 130f, 38f), vec3<f32>(1630f, 268f, 87f), vec3((_e729 == 2i)));
                    }
                    let _e733 = local_42;
                    local_41 = _e733;
                }
                let _e734 = local_41;
                s_4 = _e734;
                let _e736 = (*p_34)[0u];
                let _e738 = s_4[0u];
                dx_2 = (_e736 - _e738);
                let _e741 = (*p_34)[1u];
                let _e743 = s_4[1u];
                let _e745 = dx_2;
                let _e748 = dx_2;
                let _e754 = (*p_34)[2u];
                bed_1 = ((((_e741 - _e743) - (0.33f * _e745)) - (2.1f * sin((0.032f * _e748)))) + (0.36f * (_e754 + 90f)));
                let _e758 = ledge;
                let _e759 = bed_1;
                let _e764 = s_4[2u];
                let _e767 = s_4[2u];
                let _e768 = dx_2;
                ledge = max(_e758, ((1f - smoothstep(1f, 5f, abs(_e759))) * (1f - smoothstep((_e764 * 0.78f), _e767, abs(_e768)))));
                continue;
            } else {
                break;
            }
            continuing {
                let _e774 = j_11;
                j_11 = (_e774 + 1i);
            }
        }
        let _e777 = (*p_34)[0u];
        let _e780 = (*p_34)[1u];
        let _e788 = (*p_34)[1u];
        let _e792 = (*p_34)[1u];
        gully = (((1f - smoothstep(4f, 14f, abs(((_e777 - 1480f) + (0.37f * (_e780 - 99f)))))) * smoothstep(94f, 106f, _e788)) * (1f - smoothstep(128f, 143f, _e792)));
        let _e797 = (*p_34)[2u];
        run = (-(_e797) - 108f);
        let _e801 = (*p_34)[0u];
        let _e803 = (*p_34)[2u];
        crossRun_1 = (_e801 + (0.31f * _e803));
        let _e807 = (*p_34)[0u];
        let _e811 = run;
        let _e812 = run;
        let _e819 = (*p_34)[0u];
        let _e825 = (*p_34)[0u];
        let _e830 = crossRun_1;
        let _e833 = (*p_34)[2u];
        param_456 = vec3<f32>((_e830 * 0.023f), (_e833 * 0.012f), 3f);
        let _e836 = valueNoise3vf3_((&param_456));
        let _e840 = crossRun_1;
        let _e843 = (*p_34)[2u];
        param_457 = vec3<f32>((_e840 * 0.078f), (_e843 * 0.038f), 7f);
        let _e846 = valueNoise3vf3_((&param_457));
        floorY = ((((((353f - (0.065f * (_e807 - 1190f))) + (0.49f * sqrt(((_e811 * _e812) + 180f)))) + (0.47f * max((1130f - _e819), 0f))) + (0.39f * max((_e825 - 1400f), 0f))) + (10f * (_e836 - 0.5f))) + (3.8f * (_e846 - 0.5f)));
        let _e850 = crossRun_1;
        let _e853 = (*p_34)[2u];
        param_458 = vec3<f32>((_e850 * 0.017f), (_e853 * 0.006f), 19f);
        let _e856 = valueNoise3vf3_((&param_458));
        track = abs((_e856 - 0.48f));
        let _e859 = track;
        let _e863 = (*p_34)[1u];
        let _e864 = floorY;
        let _e870 = run;
        let _e873 = run;
        apron = ((((1f - smoothstep(0.044f, 0.19f, _e859)) * (1f - smoothstep(1.5f, 7f, abs((_e863 - _e864))))) * smoothstep(-29f, 6f, _e870)) * (1f - smoothstep(55f, 145f, _e873)));
        let _e877 = apron;
        let _e878 = ledge;
        let _e879 = gully;
        catchment = max(_e877, max(_e878, _e879));
        let _e882 = shelf_2;
        let _e883 = catchment;
        let _e885 = shelter;
        let _e886 = catchment;
        let _e889 = grains;
        let _e895 = (*p_34)[1u];
        snow_1 = (((_e882 * _e883) * smoothstep(0.27f, 0.58f, ((_e885 + (0.83f * _e886)) + (0.39f * _e889)))) * (1f - smoothstep(366f, 445f, _e895)));
        let _e899 = n_7;
        let _e900 = snow_1;
        n_7 = normalize(mix(_e899, vec3<f32>(0f, 1f, 0f), vec3((_e900 * 0.27f))));
        let _e905 = c_10;
        let _e906 = direct;
        let _e910 = snow_1;
        c_10 = mix(_e905, vec3((0.72f + (0.18f * _e906))), vec3(_e910));
    }
    if true {
        let _e913 = (*wp_1);
        param_459 = (_e913 * 0.051f);
        let _e915 = valueNoise3vf3_((&param_459));
        albedo_1 = mix(vec3<f32>(0.49f, 0.43f, 0.46f), vec3<f32>(0.63f, 0.52f, 0.52f), vec3(_e915));
        let _e918 = albedo_1;
        param_460 = _e918;
        let _e919 = srgbToLinearvf3_((&param_460));
        let _e920 = ambientLight();
        let _e923 = n_7[1u];
        let _e928 = key_2();
        let _e929 = direct;
        radiance = (_e919 * (((_e920 * vec3<f32>(0.74f, 0.86f, 1.35f)) * (0.64f + (0.68f * max(_e923, 0f)))) + (_e928 * (0.13f + (2.9f * _e929)))));
        let _e935 = n_7;
        let _e937 = light_1[0u];
        reflectedKey = dot(_e935, normalize(vec3<f32>(_e937, 0.075f, -0.055f)));
        let _e941 = albedo_1;
        param_461 = _e941;
        let _e942 = srgbToLinearvf3_((&param_461));
        let _e943 = key_2();
        let _e946 = reflectedKey;
        let _e950 = radiance;
        radiance = (_e950 + (((_e942 * _e943) * 1.1f) * pow(max(_e946, 0f), 1.5f)));
        let _e952 = radiance;
        let _e953 = occ;
        let _e957 = crack;
        param_462 = ((_e952 * (1f - (0.23f * _e953))) * (1f - (0.09f * _e957)));
        let _e961 = linearToSrgbvf3_((&param_462));
        c_10 = _e961;
        let _e962 = object;
        let _e964 = object;
        if ((_e962 == 1i) || (_e964 == 2i)) {
            let _e967 = (*p_34);
            param_463 = (_e967 * vec3<f32>(0.047f, 0.054f, 0.036f));
            let _e969 = valueNoise3vf3_((&param_463));
            weather_1 = _e969;
            let _e971 = (*p_34)[0u];
            let _e974 = (*p_34)[1u];
            let _e978 = (*p_34)[1u];
            let _e981 = (*p_34)[2u];
            param_464 = vec3<f32>(((_e971 * 0.086f) + (_e974 * 0.045f)), (_e978 * 0.052f), (_e981 * 0.064f));
            let _e984 = valueNoise3vf3_((&param_464));
            dry_1 = _e984;
            let _e985 = weather_1;
            let _e988 = dry_1;
            let _e991 = (*p_34);
            param_465 = (_e991 * 0.22f);
            let _e993 = valueNoise3vf3_((&param_465));
            let _e996 = c_10;
            c_10 = (_e996 * (((0.79f + (0.22f * _e985)) + (0.19f * _e988)) + (0.055f * _e993)));
            let _e999 = (*p_34)[0u];
            let _e1001 = (*p_34)[1u];
            east_2 = smoothstep(1770f, 1840f, (_e999 + (0.15f * (_e1001 - 305f))));
            let _e1006 = c_10;
            let _e1007 = weather_1;
            let _e1011 = east_2;
            c_10 = mix(_e1006, (vec3<f32>(0.225f, 0.214f, 0.306f) + vec3((0.045f * _e1007))), vec3((_e1011 * 0.24f)));
            let _e1016 = (*p_34)[0u];
            let _e1019 = (*p_34)[1u];
            let _e1023 = (*p_34)[1u];
            let _e1026 = (*p_34)[2u];
            param_466 = vec3<f32>(((0.062f * _e1016) + (0.031f * _e1019)), (_e1023 * 0.015f), (_e1026 * 0.035f));
            let _e1029 = valueNoise3vf3_((&param_466));
            split = _e1029;
            let _e1030 = split;
            cleft = (1f - smoothstep(0.025f, 0.11f, abs((_e1030 - 0.49f))));
            let _e1035 = cleft;
            let _e1037 = weather_1;
            let _e1041 = c_10;
            c_10 = (_e1041 * (1f - ((0.2f * _e1035) * smoothstep(0.22f, 0.63f, _e1037))));
            let _e1044 = n_7[0u];
            let _e1048 = c_10;
            c_10 = (_e1048 + (vec3<f32>(0.062f, 0.034f, 0.029f) * max(0f, -(_e1044))));
        }
        let _e1050 = object;
        if (_e1050 == 0i) {
            let _e1052 = (*p_34);
            param_467 = (_e1052 * vec3<f32>(0.086f, 0.018f, 0.06f));
            let _e1054 = valueNoise3vf3_((&param_467));
            band = _e1054;
            let _e1055 = (*p_34);
            param_468 = (_e1055 * 0.047f);
            let _e1057 = valueNoise3vf3_((&param_468));
            let _e1059 = (*p_34);
            param_469 = (_e1059 * 0.128f);
            let _e1061 = valueNoise3vf3_((&param_469));
            inclusion = ((_e1057 * 0.65f) + (_e1061 * 0.35f));
            let _e1064 = band;
            let _e1067 = inclusion;
            let _e1070 = c_10;
            c_10 = (_e1070 * ((0.91f + (0.1f * _e1064)) + (0.085f * _e1067)));
            let _e1072 = n_7;
            let _e1076 = shadow;
            let _e1080 = c_10;
            c_10 = (_e1080 + ((vec3<f32>(0.044f, 0.035f, 0.037f) * max(0f, dot(_e1072, vec3<f32>(-0.8888578f, 0.19322994f, -0.4154444f)))) * (0.4f + (0.6f * _e1076))));
            let _e1082 = c_10;
            let _e1083 = direct;
            let _e1084 = bounce;
            let _e1089 = snow_1;
            c_10 = mix(_e1082, mix(vec3<f32>(0.5f, 0.555f, 0.71f), vec3<f32>(0.88f, 0.84f, 0.79f), vec3(max(_e1083, (0.23f * _e1084)))), vec3(_e1089));
            let _e1093 = (*p_34)[1u];
            let _e1096 = (*p_34)[1u];
            let _e1101 = n_7[1u];
            let _e1104 = snow_1;
            ridge_1 = (((smoothstep(302f, 348f, _e1093) * (1f - smoothstep(380f, 420f, _e1096))) * smoothstep(0.69f, 0.87f, _e1101)) * (1f - _e1104));
            let _e1107 = ridge_1;
            let _e1109 = c_10;
            c_10 = (_e1109 + (vec3<f32>(0.095f, 0.078f, 0.045f) * _e1107));
        }
        if true {
            let _e1111 = object;
            let _e1113 = object;
            if ((_e1111 == 1i) || (_e1113 == 2i)) {
                let _e1117 = n_7[1u];
                local_43 = smoothstep(0.78f, 0.94f, _e1117);
            } else {
                let _e1119 = object;
                if (_e1119 == 0i) {
                    let _e1122 = n_7[1u];
                    let _e1125 = (*p_34)[1u];
                    let _e1128 = snow_1;
                    local_44 = ((smoothstep(0.73f, 0.94f, _e1122) * smoothstep(295f, 370f, _e1125)) * (1f - _e1128));
                } else {
                    local_44 = 0f;
                }
                let _e1131 = local_44;
                local_43 = _e1131;
            }
            let _e1132 = local_43;
            grass_1 = _e1132;
            let _e1133 = c_10;
            let _e1134 = direct;
            let _e1137 = grass_1;
            let _e1138 = (*p_34);
            param_470 = (_e1138 * 0.18f);
            let _e1140 = valueNoise3vf3_((&param_470));
            c_10 = mix(_e1133, mix(vec3<f32>(0.266f, 0.286f, 0.224f), vec3<f32>(0.74f, 0.63f, 0.47f), vec3(_e1134)), vec3((_e1137 * (0.79f + (0.21f * _e1140)))));
        }
        phi_6507_ = true;
        if true {
            let _e1146 = object;
            let _e1148 = object;
            phi_6507_ = ((_e1146 == 1i) || (_e1148 == 2i));
        }
        let _e1152 = phi_6507_;
        if _e1152 {
            let _e1153 = object;
            if (_e1153 == 1i) {
                let _e1155 = (*p_34);
                let _e1157 = (_e1155.xy - vec2<f32>(1870f, 370f));
                let _e1159 = (*p_34)[2u];
                local_45 = vec3<f32>(_e1157.x, _e1157.y, _e1159);
            } else {
                let _e1163 = (*p_34);
                let _e1167 = ((_e1163.xy - vec2<f32>(1535f, 470f)) / vec2(0.49f));
                let _e1169 = (*p_34)[2u];
                local_45 = vec3<f32>(_e1167.x, _e1167.y, (_e1169 / 0.49f));
            }
            let _e1174 = local_45;
            q_14 = _e1174;
            let _e1175 = object;
            if (_e1175 == 2i) {
                let _e1178 = q_14[1u];
                q_14[1u] = ((_e1178 - 32f) / 0.56f);
            }
            let _e1183 = q_14[0u];
            let _e1187 = q_14[0u];
            let _e1194 = q_14[0u];
            let _e1201 = q_14[2u];
            cap_1 = ((((-137f - (0.105f * _e1183)) + (0.31f * max((-(_e1187) - 34f), 0f))) + (0.71f * max((-(_e1194) - 116f), 0f))) - (0.16f * _e1201));
            let _e1204 = (*wp_1);
            param_471 = (_e1204 * vec3<f32>(0.2f, 0.042f, 0.17f));
            let _e1206 = valueNoise3vf3_((&param_471));
            damp = _e1206;
            let _e1208 = q_14[1u];
            let _e1209 = cap_1;
            below = (_e1208 - _e1209);
            let _e1211 = below;
            let _e1213 = damp;
            let _e1216 = below;
            lip_1 = (smoothstep(-2f, 2f, _e1211) * (1f - smoothstep(3f, (9f + (9f * _e1213)), _e1216)));
            let _e1220 = c_10;
            param_472 = vec3<f32>(0.28f, 0.26f, 0.215f);
            let _e1221 = srgbToLinearvf3_((&param_472));
            let _e1222 = ambientLight();
            let _e1223 = key_2();
            let _e1224 = direct;
            param_473 = (_e1221 * (_e1222 + (_e1223 * _e1224)));
            let _e1228 = linearToSrgbvf3_((&param_473));
            let _e1229 = lip_1;
            c_10 = mix(_e1220, _e1228, vec3((_e1229 * 0.78f)));
            let _e1233 = damp;
            let _e1236 = below;
            let _e1243 = c_10;
            c_10 = (_e1243 * (1f - ((0.13f * smoothstep(0.44f, 0.69f, _e1233)) * exp((-(max(_e1236, 0f)) / 46f)))));
        }
        let _e1245 = object;
        if (true && (_e1245 != 3i)) {
            let _e1248 = (*wp_1);
            param_474 = _e1248.xz;
            let _e1250 = contactAtvf2_((&param_474));
            foot_1 = _e1250;
            let _e1251 = (*wp_1);
            param_475 = _e1251.xz;
            let _e1253 = baseHeightvf2_((&param_475));
            let _e1255 = foot_1[1u];
            ground_1 = (_e1253 + _e1255);
            let _e1258 = (*wp_1)[1u];
            let _e1259 = ground_1;
            let _e1261 = (*wp_1);
            param_476 = (_e1261 * 0.082f);
            let _e1263 = valueNoise3vf3_((&param_476));
            gap = ((_e1258 - _e1259) + (7f * (_e1263 - 0.5f)));
            let _e1267 = gap;
            let _e1271 = n_7[1u];
            let _e1276 = snow_1;
            cover = (((1f - smoothstep(1f, 34f, _e1267)) * (0.28f + (0.72f * smoothstep(0.13f, 0.83f, _e1271)))) * (1f - _e1276));
            let _e1279 = gap;
            let _e1283 = c_10;
            c_10 = (_e1283 * (0.7f + (0.3f * smoothstep(0f, 18f, _e1279))));
            let _e1285 = (*wp_1);
            param_477 = (_e1285 * 0.12f);
            let _e1287 = valueNoise3vf3_((&param_477));
            let _e1289 = (*wp_1);
            param_478 = (_e1289 * 0.034f);
            let _e1291 = valueNoise3vf3_((&param_478));
            litter = ((_e1287 * 0.52f) + (_e1291 * 0.48f));
            let _e1294 = c_10;
            let _e1295 = litter;
            let _e1298 = cover;
            c_10 = mix(_e1294, mix(vec3<f32>(0.235f, 0.224f, 0.246f), vec3<f32>(0.419f, 0.392f, 0.282f), vec3(_e1295)), vec3((_e1298 * 0.77f)));
        }
        let _e1302 = object;
        if (_e1302 == 3i) {
            let _e1304 = c_10;
            c_10 = mix(_e1304, vec3<f32>(0.55f, 0.58f, 0.72f), vec3(0.52f));
        }
        let _e1307 = c_10;
        param_479 = _e1307;
        let _e1308 = srgbToLinearvf3_((&param_479));
        param_480 = _e1308;
        let _e1309 = (*wp_1);
        param_481 = _e1309;
        let _e1310 = (*eye);
        param_482 = _e1310;
        let _e1311 = valleyAirvf3vf3vf3_((&param_480), (&param_481), (&param_482));
        param_483 = _e1311;
        let _e1312 = filmvf3_((&param_483));
        c_10 = _e1312;
    }
    let _e1313 = c_10;
    return clamp(_e1313, vec3(0f), vec3(1f));
}

fn worldvf3_(p_35: ptr<function, vec3<f32>>) -> vec3<f32> {
    let _e8 = position;
    let _e9 = unit;
    let _e11 = (*p_35)[0u];
    let _e13 = datum[0u];
    let _e16 = datum[1u];
    let _e18 = (*p_35)[1u];
    let _e21 = axes();
    let _e23 = (*p_35)[2u];
    return (_e8 + ((vec3<f32>((_e11 - _e13), (_e16 - _e18), 0f) + (_e21 * _e23)) * _e9));
}

fn intersectRockvf3vf3vf3vf3_(eye_1: ptr<function, vec3<f32>>, ray_3: ptr<function, vec3<f32>>, p_36: ptr<function, vec3<f32>>, wp_2: ptr<function, vec3<f32>>) -> bool {
    var localEye: vec3<f32>;
    var param_484: vec3<f32>;
    var dir_4: vec3<f32>;
    var param_485: vec3<f32>;
    var inv: vec3<f32>;
    var a_16: vec3<f32>;
    var b_12: vec3<f32>;
    var nearT: vec3<f32>;
    var farT: vec3<f32>;
    var t_12: f32;
    var end: f32;
    var hit_3: bool;
    var i_21: i32;
    var d_9: f32;
    var param_486: vec3<f32>;
    var param_487: vec3<f32>;

    let _e41 = datum;
    let _e45 = (*eye_1);
    let _e46 = position;
    param_484 = (_e45 - _e46);
    let _e48 = localDirvf3_((&param_484));
    let _e49 = unit;
    localEye = (vec3<f32>(_e41.x, _e41.y, 0f) + (_e48 / vec3(_e49)));
    let _e53 = (*ray_3);
    param_485 = _e53;
    let _e54 = localDirvf3_((&param_485));
    dir_4 = _e54;
    let _e55 = dir_4;
    let _e59 = dir_4;
    inv = (vec3(1f) / (sign((_e55 + vec3(0.000000001f))) * max(abs(_e59), vec3<f32>(0.0000001f, 0.0000001f, 0.0000001f))));
    let _e65 = origin_2;
    let _e66 = localEye;
    let _e68 = inv;
    a_16 = ((_e65 - _e66) * _e68);
    let _e70 = dims;
    let _e71 = localEye;
    let _e73 = inv;
    b_12 = ((_e70 - _e71) * _e73);
    let _e75 = a_16;
    let _e76 = b_12;
    nearT = min(_e75, _e76);
    let _e78 = a_16;
    let _e79 = b_12;
    farT = max(_e78, _e79);
    let _e82 = nearT[0u];
    let _e84 = nearT[1u];
    let _e86 = nearT[2u];
    t_12 = max(0f, max(_e82, max(_e84, _e86)));
    let _e91 = farT[0u];
    let _e93 = farT[1u];
    let _e95 = farT[2u];
    end = min(_e91, min(_e93, _e95));
    let _e98 = t_12;
    let _e99 = end;
    if (_e98 >= _e99) {
        return false;
    }
    hit_3 = false;
    (*p_36) = vec3<f32>(0f, 0f, 0f);
    i_21 = 0i;
    loop {
        let _e101 = i_21;
        if (_e101 < 155i) {
            let _e103 = localEye;
            let _e104 = dir_4;
            let _e105 = t_12;
            (*p_36) = (_e103 + (_e104 * _e105));
            let _e108 = (*p_36);
            param_486 = _e108;
            let _e109 = sdvf3_((&param_486));
            d_9 = _e109;
            let _e110 = d_9;
            if (_e110 < 0.14f) {
                hit_3 = true;
                break;
            }
            let _e112 = d_9;
            let _e115 = t_12;
            t_12 = (_e115 + max(0.12f, (_e112 * 0.66f)));
            let _e117 = t_12;
            let _e118 = end;
            if (_e117 > _e118) {
                break;
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e120 = i_21;
            i_21 = (_e120 + 1i);
        }
    }
    let _e122 = hit_3;
    if !(_e122) {
        return false;
    }
    let _e124 = (*p_36);
    param_487 = _e124;
    let _e125 = worldvf3_((&param_487));
    (*wp_2) = _e125;
    return true;
}

fn setRocki1_(id_7: ptr<function, i32>) {
    var local_46: vec2<f32>;
    var local_47: vec2<f32>;
    var z_12: f32;
    var local_48: f32;
    var local_49: f32;
    var local_50: vec3<f32>;
    var local_51: vec3<f32>;
    var local_52: vec3<f32>;
    var local_53: vec3<f32>;

    let _e42 = (*id_7);
    object = _e42;
    let _e43 = (*id_7);
    if (_e43 == 0i) {
        local_46 = vec2<f32>(1450f, 235f);
    } else {
        let _e45 = (*id_7);
        if (_e45 == 1i) {
            local_47 = vec2<f32>(1800f, 305f);
        } else {
            let _e47 = (*id_7);
            local_47 = select(vec2<f32>(1840f, 202f), vec2<f32>(1510f, 435f), vec2((_e47 == 2i)));
        }
        let _e51 = local_47;
        local_46 = _e51;
    }
    let _e52 = local_46;
    datum = _e52;
    let _e53 = (*id_7);
    if (_e53 == 0i) {
        local_48 = 970f;
    } else {
        let _e55 = (*id_7);
        if (_e55 == 1i) {
            local_49 = 550f;
        } else {
            let _e57 = (*id_7);
            local_49 = select(1480f, 457f, (_e57 == 2i));
        }
        let _e60 = local_49;
        local_48 = _e60;
    }
    let _e61 = local_48;
    z_12 = _e61;
    let _e62 = z_12;
    unit = (_e62 / 1404f);
    let _e65 = datum[0u];
    let _e69 = datum[1u];
    strike = vec2<f32>(((_e65 - 960f) / 1404f), ((464.4f - _e69) / 1404f));
    let _e74 = strike[0u];
    let _e75 = z_12;
    let _e78 = strike[1u];
    let _e79 = z_12;
    let _e82 = z_12;
    position = vec3<f32>((_e74 * _e75), (70f + (_e78 * _e79)), _e82);
    let _e84 = (*id_7);
    if (_e84 == 0i) {
        local_50 = vec3<f32>(838f, 25f, -340f);
    } else {
        let _e86 = (*id_7);
        if (_e86 == 1i) {
            local_51 = vec3<f32>(1552f, 183f, -138f);
        } else {
            let _e88 = (*id_7);
            local_51 = select(vec3<f32>(1628f, 133f, -111f), vec3<f32>(1380f, 353f, -76f), vec3((_e88 == 2i)));
        }
        let _e92 = local_51;
        local_50 = _e92;
    }
    let _e93 = local_50;
    origin_2 = _e93;
    let _e94 = (*id_7);
    if (_e94 == 0i) {
        local_52 = vec3<f32>(2120f, 650f, 230f);
    } else {
        let _e96 = (*id_7);
        if (_e96 == 1i) {
            local_53 = vec3<f32>(2210f, 618f, 154f);
        } else {
            let _e98 = (*id_7);
            local_53 = select(vec3<f32>(2084f, 372f, 110f), vec3<f32>(1700f, 590f, 82f), vec3((_e98 == 2i)));
        }
        let _e102 = local_53;
        local_52 = _e102;
    }
    let _e103 = local_52;
    dims = _e103;
    return;
}

fn skyRadiancevf3_(ray_4: ptr<function, vec3<f32>>) -> vec3<f32> {
    var alt: f32;
    var scatter_2: f32;
    var param_488: vec3<f32>;
    var sky: vec3<f32>;
    var east_3: f32;
    var p_37: vec2<f32>;
    var cloud: f32;
    var param_489: vec2<f32>;
    var param_490: vec2<f32>;
    var param_491: i32;
    var stratus: f32;
    var param_492: vec2<f32>;
    var glow: f32;

    let _e54 = (*ray_4)[1u];
    alt = max(0f, _e54);
    let _e56 = (*ray_4);
    param_488 = _e56;
    let _e57 = forwardLightvf3_((&param_488));
    scatter_2 = _e57;
    let _e58 = alt;
    sky = mix(vec3<f32>(0.95f, 0.769f, 0.681f), vec3<f32>(0.613f, 0.619f, 0.714f), vec3(smoothstep(0.025f, 0.38f, _e58)));
    let _e63 = (*ray_4)[0u];
    let _e65 = alt;
    east_3 = (smoothstep(0.01f, 0.66f, _e63) * smoothstep(0.035f, 0.29f, _e65));
    let _e68 = sky;
    let _e69 = east_3;
    sky = mix(_e68, vec3<f32>(0.419f, 0.502f, 0.684f), vec3((_e69 * 0.92f)));
    let _e73 = sky;
    let _e74 = scatter_2;
    sky = mix(_e73, vec3<f32>(1f, 0.891f, 0.736f), vec3(pow(_e74, 1.65f)));
    let _e78 = (*ray_4);
    let _e81 = phase;
    p_37 = ((_e78.xy * vec2<f32>(7f, 67f)) + vec2<f32>((0.03f * sin(_e81)), 4f));
    let _e86 = p_37;
    let _e87 = p_37;
    param_489 = (_e87 * 0.44f);
    let _e89 = gradientNoisevf2_((&param_489));
    param_490 = (_e86 + vec2(_e89));
    param_491 = 4i;
    let _e92 = fbmvf2i1_((&param_490), (&param_491));
    cloud = _e92;
    let _e93 = cloud;
    let _e96 = sky;
    sky = (_e96 + (vec3<f32>(0.084f, 0.05f, 0.038f) * smoothstep(0.1f, 0.42f, _e93)));
    let _e99 = (*ray_4)[1u];
    let _e102 = (*ray_4)[0u];
    param_492 = vec2<f32>((_e102 * 17f), 3f);
    let _e105 = gradientNoisevf2_((&param_492));
    stratus = exp(-(pow((((_e99 - 0.118f) - (0.005f * _e105)) / 0.006f), 2f)));
    let _e112 = stratus;
    let _e114 = cloud;
    let _e118 = scatter_2;
    let _e120 = sky;
    sky = (_e120 + (((vec3<f32>(0.115f, 0.042f, 0.008f) * _e112) * smoothstep(0f, 0.3f, (_e114 + 0.11f))) * _e118));
    let _e122 = (*ray_4);
    let _e123 = sunlight();
    glow = length((_e122 - _e123));
    let _e126 = glow;
    let _e130 = sky;
    sky = (_e130 + (vec3<f32>(0.17f, 0.17f, 0.15f) * exp((-31f * _e126))));
    let _e132 = sky;
    let _e133 = glow;
    sky = mix(_e132, vec3<f32>(1f, 1f, 0.967f), vec3((1f - smoothstep(0.008f, 0.013f, _e133))));
    let _e138 = sky;
    return clamp(_e138, vec3(0f), vec3(1f));
}

fn environmentvf3vf3b1f1f1_(ro_4: ptr<function, vec3<f32>>, rd_3: ptr<function, vec3<f32>>, reflected: ptr<function, bool>, limit_1: ptr<function, f32>, visibleZ: ptr<function, f32>) -> vec3<f32> {
    var c_11: vec3<f32>;
    var param_493: vec3<f32>;
    var closest: f32;
    var id_8: i32;
    var param_494: i32;
    var p_38: vec3<f32>;
    var wp_3: vec3<f32>;
    var param_495: vec3<f32>;
    var param_496: vec3<f32>;
    var param_497: vec3<f32>;
    var param_498: vec3<f32>;
    var param_499: vec3<f32>;
    var param_500: vec3<f32>;
    var param_501: vec3<f32>;
    var t_13: f32;
    var local_54: f32;
    var last: f32;
    var j_12: i32;
    var wp_4: vec3<f32>;
    var h_10: f32;
    var param_502: vec2<f32>;
    var k_8: i32;
    var mid_3: f32;
    var q_15: vec3<f32>;
    var param_503: vec2<f32>;
    var param_504: vec3<f32>;
    var param_505: vec3<f32>;
    var result: vec3<f32>;
    var param_506: vec3<f32>;
    var param_507: f32;
    var param_508: vec3<f32>;
    var param_509: vec3<f32>;
    var param_510: bool;
    var param_511: f32;
    var p_39: vec3<f32>;
    var phi_8542_: bool;
    var phi_8617_: bool;
    var phi_8618_: bool;
    var phi_8715_: bool;
    var phi_8724_: bool;

    let _e61 = (*rd_3);
    param_493 = normalize(_e61);
    let _e63 = skyRadiancevf3_((&param_493));
    c_11 = _e63;
    let _e64 = (*limit_1);
    closest = _e64;
    id_8 = 0i;
    loop {
        let _e65 = id_8;
        if (_e65 < 4i) {
            let _e67 = id_8;
            param_494 = _e67;
            setRocki1_((&param_494));
            let _e68 = (*rd_3);
            let _e70 = (*ro_4);
            param_495 = _e70;
            param_496 = normalize(_e68);
            let _e71 = intersectRockvf3vf3vf3vf3_((&param_495), (&param_496), (&param_497), (&param_498));
            let _e72 = param_497;
            p_38 = _e72;
            let _e73 = param_498;
            wp_3 = _e73;
            phi_8542_ = _e71;
            if _e71 {
                let _e75 = wp_3[2u];
                let _e77 = (*ro_4)[2u];
                let _e79 = closest;
                phi_8542_ = ((_e75 - _e77) < _e79);
            }
            let _e82 = phi_8542_;
            if _e82 {
                let _e83 = p_38;
                param_499 = _e83;
                let _e84 = wp_3;
                param_500 = _e84;
                let _e85 = (*ro_4);
                param_501 = _e85;
                let _e86 = rockColorvf3vf3vf3_((&param_499), (&param_500), (&param_501));
                c_11 = _e86;
                let _e88 = wp_3[2u];
                let _e90 = (*ro_4)[2u];
                closest = (_e88 - _e90);
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e92 = id_8;
            id_8 = (_e92 + 1i);
        }
    }
    let _e94 = (*reflected);
    if _e94 {
        let _e96 = (*ro_4)[1u];
        let _e99 = (*rd_3)[1u];
        local_54 = max(10f, ((1f - _e96) / max(0.001f, _e99)));
    } else {
        local_54 = 8f;
    }
    let _e103 = local_54;
    t_13 = _e103;
    let _e104 = t_13;
    last = _e104;
    j_12 = 0i;
    loop {
        let _e105 = j_12;
        if (_e105 < 265i) {
            let _e107 = t_13;
            let _e108 = closest;
            if (_e107 >= _e108) {
                break;
            }
            let _e110 = (*ro_4);
            let _e111 = (*rd_3);
            let _e112 = t_13;
            wp_4 = (_e110 + (_e111 * _e112));
            let _e115 = wp_4;
            param_502 = _e115.xz;
            let _e117 = groundAtvf2_((&param_502));
            h_10 = _e117;
            let _e119 = wp_4[1u];
            let _e120 = h_10;
            let _e121 = (_e119 < _e120);
            phi_8618_ = _e121;
            if _e121 {
                let _e122 = (*reflected);
                let _e123 = !(_e122);
                phi_8617_ = _e123;
                if !(_e123) {
                    let _e126 = wp_4[1u];
                    phi_8617_ = (_e126 > 0.02f);
                }
                let _e129 = phi_8617_;
                phi_8618_ = _e129;
            }
            let _e131 = phi_8618_;
            if _e131 {
                k_8 = 0i;
                loop {
                    let _e132 = k_8;
                    if (_e132 < 7i) {
                        let _e134 = last;
                        let _e135 = t_13;
                        mid_3 = ((_e134 + _e135) * 0.5f);
                        let _e138 = (*ro_4);
                        let _e139 = (*rd_3);
                        let _e140 = mid_3;
                        q_15 = (_e138 + (_e139 * _e140));
                        let _e144 = q_15[1u];
                        let _e145 = q_15;
                        param_503 = _e145.xz;
                        let _e147 = groundAtvf2_((&param_503));
                        if (_e144 < _e147) {
                            let _e149 = mid_3;
                            t_13 = _e149;
                        } else {
                            let _e150 = mid_3;
                            last = _e150;
                        }
                        continue;
                    } else {
                        break;
                    }
                    continuing {
                        let _e151 = k_8;
                        k_8 = (_e151 + 1i);
                    }
                }
                let _e153 = t_13;
                closest = _e153;
                let _e154 = (*ro_4);
                let _e155 = (*rd_3);
                let _e156 = t_13;
                param_504 = (_e154 + (_e155 * _e156));
                let _e159 = (*ro_4);
                param_505 = _e159;
                let _e160 = landColorvf3vf3_((&param_504), (&param_505));
                c_11 = _e160;
                break;
            }
            let _e161 = t_13;
            last = _e161;
            let _e163 = wp_4[1u];
            let _e164 = h_10;
            let _e168 = wp_4[2u];
            let _e172 = t_13;
            t_13 = (_e172 + clamp(((_e163 - _e164) * 0.57f), 1.4f, max(6f, (_e168 * 0.019f))));
            continue;
        } else {
            break;
        }
        continuing {
            let _e174 = j_12;
            j_12 = (_e174 + 1i);
        }
    }
    let _e176 = c_11;
    param_506 = _e176;
    let _e177 = closest;
    param_507 = _e177;
    let _e178 = (*ro_4);
    param_508 = _e178;
    let _e179 = (*rd_3);
    param_509 = _e179;
    let _e180 = (*reflected);
    param_510 = _e180;
    let _e181 = treeLayervf3f1vf3vf3b1f1_((&param_506), (&param_507), (&param_508), (&param_509), (&param_510), (&param_511));
    let _e182 = param_511;
    (*visibleZ) = _e182;
    result = _e181;
    let _e183 = (*reflected);
    if !(_e183) {
        let _e185 = (*ro_4);
        let _e186 = (*rd_3);
        let _e187 = (*visibleZ);
        p_39 = (_e185 + (_e186 * _e187));
        let _e190 = (*visibleZ);
        let _e191 = closest;
        let _e192 = (_e190 < _e191);
        phi_8715_ = _e192;
        if _e192 {
            let _e194 = p_39[2u];
            phi_8715_ = (_e194 < 236f);
        }
        let _e197 = phi_8715_;
        phi_8724_ = _e197;
        if _e197 {
            let _e199 = p_39[0u];
            let _e201 = p_39[2u];
            phi_8724_ = ((_e199 / _e201) < 0.22f);
        }
        let _e205 = phi_8724_;
        softFirstRow = _e205;
    }
    let _e206 = result;
    return _e206;
}

fn cameraTruck() -> f32 {
    var f_12: f32;
    var local_55: f32;

    let _e15 = unnamed.iTime;
    let _e16 = (_e15 * 48f);
    f_12 = min(((_e16 - (floor((_e16 / 248f)) * 248f)) * 0.5f), 123f);
    let _e23 = f_12;
    if (_e23 <= 62f) {
        let _e25 = f_12;
        local_55 = (-0.92f * (1f - cos(((_e25 * 3.1415927f) / 62f))));
    } else {
        let _e31 = f_12;
        local_55 = (-1.84f + (1.32f * (1f - cos((((_e31 - 62f) * 3.1415927f) / 61f)))));
    }
    let _e39 = local_55;
    return _e39;
}

fn renderMirrorvf2_(pixel_4: ptr<function, vec2<f32>>) -> vec3<f32> {
    var eye_2: vec3<f32>;
    var sum_1: vec3<f32>;
    var i_22: i32;
    var uv_5: vec2<f32>;
    var indexable_11: array<vec2<f32>, 4>;
    var rd_4: vec3<f32>;
    var z_13: f32;
    var param_512: vec3<f32>;
    var param_513: vec3<f32>;
    var param_514: bool;
    var param_515: f32;
    var param_516: f32;

    let _e39 = cameraTruck();
    truck_2 = _e39;
    let _e41 = unnamed.iTime;
    phase = ((_e41 * 6.2831855f) / 5.1666665f);
    let _e44 = cameraEye();
    eye_2 = _e44;
    let _e46 = eye_2[1u];
    eye_2[1u] = -(_e46);
    sum_1 = vec3<f32>(0f, 0f, 0f);
    i_22 = 0i;
    loop {
        let _e49 = i_22;
        if (_e49 < 4i) {
            let _e51 = (*pixel_4);
            let _e53 = i_22;
            indexable_11 = array<vec2<f32>, 4>(vec2<f32>(-0.125f, -0.375f), vec2<f32>(0.375f, -0.125f), vec2<f32>(-0.375f, 0.125f), vec2<f32>(0.125f, 0.375f));
            let _e55 = indexable_11[_e53];
            uv_5 = (((_e51 + vec2<f32>(322f, 0f)) + _e55) / vec2<f32>(1344f, 756f));
            let _e59 = uv_5[0u];
            let _e64 = truck_2;
            let _e68 = uv_5[1u];
            rd_4 = vec3<f32>((((((_e59 - 0.5f) * 2f) * 1.7777778f) / 2.6f) - (_e64 / 325f)), ((-((_e68 - 0.57f)) * 2f) / 2.6f), 1f);
            let _e74 = eye_2;
            param_512 = _e74;
            let _e75 = rd_4;
            param_513 = _e75;
            param_514 = true;
            param_515 = 1600f;
            let _e76 = environmentvf3vf3b1f1f1_((&param_512), (&param_513), (&param_514), (&param_515), (&param_516));
            let _e77 = param_516;
            z_13 = _e77;
            let _e81 = sum_1;
            sum_1 = (_e81 + clamp(_e76, vec3(0f), vec3(1f)));
            continue;
        } else {
            break;
        }
        continuing {
            let _e83 = i_22;
            i_22 = (_e83 + 1i);
        }
    }
    let _e85 = sum_1;
    return (round(((_e85 * 0.25f) * 255f)) / vec3(255f));
}

fn depthBandf1_(z_14: ptr<function, f32>) -> i32 {
    var local_56: i32;
    var local_57: i32;
    var local_58: i32;
    var local_59: i32;
    var local_60: i32;

    let _e19 = (*z_14);
    if (_e19 < 9f) {
        local_56 = 0i;
    } else {
        let _e21 = (*z_14);
        if (_e21 < 15.8f) {
            local_57 = 1i;
        } else {
            let _e23 = (*z_14);
            if (_e23 < 20f) {
                local_58 = 2i;
            } else {
                let _e25 = (*z_14);
                if (_e25 < 28f) {
                    local_59 = 3i;
                } else {
                    let _e27 = (*z_14);
                    if (_e27 < 48f) {
                        local_60 = 4i;
                    } else {
                        let _e29 = (*z_14);
                        local_60 = select(6i, 5i, (_e29 < 120f));
                    }
                    let _e32 = local_60;
                    local_59 = _e32;
                }
                let _e33 = local_59;
                local_58 = _e33;
            }
            let _e34 = local_58;
            local_57 = _e34;
        }
        let _e35 = local_57;
        local_56 = _e35;
    }
    let _e36 = local_56;
    return _e36;
}

fn patchKeyvf4_(r_10: ptr<function, vec4<f32>>) -> i32 {
    var lvl: i32;
    var tile_3: f32;
    var xy_2: vec2<i32>;
    var param_517: f32;

    let _e19 = (*r_10)[2u];
    if (_e19 < 0.1f) {
        return 16777200i;
    }
    let _e22 = (*r_10)[3u];
    lvl = i32((_e22 / 524288f));
    let _e25 = lvl;
    tile_3 = (16f * exp2(f32(_e25)));
    let _e29 = (*r_10);
    let _e31 = tile_3;
    xy_2 = (vec2<i32>(floor((_e29.xy / vec2(_e31)))) + vec2<i32>(48i, 48i));
    let _e38 = (*r_10)[2u];
    param_517 = _e38;
    let _e39 = depthBandf1_((&param_517));
    let _e41 = lvl;
    let _e45 = xy_2[1u];
    let _e50 = xy_2[0u];
    return ((((((_e39 * 5i) + _e41) * 256i) + clamp(_e45, 0i, 255i)) * 256i) + clamp(_e50, 0i, 255i));
}

fn patchAddressi1i1_(idx: ptr<function, i32>, width_4: ptr<function, i32>) -> vec2<i32> {
    var i_23: i32;

    let _e4 = (*idx);
    i_23 = (524288i + _e4);
    let _e6 = i_23;
    let _e7 = (*width_4);
    let _e15 = i_23;
    let _e16 = (*width_4);
    return vec2<i32>((_e6 - (i32(floor((f32(_e6) / f32(_e7)))) * _e7)), (_e15 / _e16));
}

fn firstPatchi1_(key_6: ptr<function, i32>) -> i32 {
    var lo_5: i32;
    var hi_5: i32;
    var j_13: i32;
    var mid_4: i32;
    var param_518: i32;
    var param_519: i32;
    var param_520: vec4<f32>;

    lo_5 = 0i;
    hi_5 = 524288i;
    j_13 = 0i;
    loop {
        let _e16 = j_13;
        if (_e16 < 20i) {
            let _e18 = lo_5;
            let _e19 = hi_5;
            if (_e18 >= _e19) {
                break;
            }
            let _e21 = lo_5;
            let _e22 = hi_5;
            mid_4 = ((_e21 + _e22) / 2i);
            let _e28 = unnamed.channelSizes[1i][0u];
            let _e30 = mid_4;
            param_518 = _e30;
            param_519 = i32(_e28);
            let _e31 = patchAddressi1i1_((&param_518), (&param_519));
            let _e32 = textureLoad(tex1_, _e31, 0i);
            param_520 = _e32;
            let _e33 = patchKeyvf4_((&param_520));
            let _e34 = (*key_6);
            if (_e33 < _e34) {
                let _e36 = mid_4;
                lo_5 = (_e36 + 1i);
            } else {
                let _e38 = mid_4;
                hi_5 = _e38;
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e39 = j_13;
            j_13 = (_e39 + 1i);
        }
    }
    let _e41 = lo_5;
    return _e41;
}

fn fernProjectionvf2f1f1_(point_2: ptr<function, vec2<f32>>, z_15: ptr<function, f32>, truck: ptr<function, f32>) -> vec2<f32> {
    var local_61: vec2<f32>;

    let _e10 = (*point_2);
    local_61 = (_e10 - vec2<f32>(960f, 464.4f));
    let _e12 = local_61;
    let _e13 = (*z_15);
    let _e15 = (*truck);
    let _e17 = (*truck);
    let _e22 = (*z_15);
    let _e23 = (*truck);
    let _e29 = (*truck);
    return ((vec2<f32>(960f, 464.4f) + (((_e12 * _e13) + (vec2<f32>(-(_e15), (0.035f * _e17)) * 1404f)) / vec2((_e22 + (0.09f * _e23))))) + vec2<f32>(((1404f * _e29) / 325f), 0f));
}

fn lensFerni1_(address_1: ptr<function, i32>) -> vec4<f32> {
    var truck_1: f32;
    var canonical: vec2<f32>;
    var pos_3: vec2<f32>;
    var param_521: vec2<f32>;
    var param_522: f32;
    var param_523: f32;
    var depth_2: f32;
    var best_2: vec4<f32>;
    var fr_1: i32;
    var angle_5: f32;
    var param_524: i32;
    var param_525: i32;
    var ext_1: vec2<f32>;
    var param_526: i32;
    var param_527: i32;
    var d_10: vec2<f32>;
    var origin_1: vec2<f32>;
    var leaf_1: i32;
    var stem_1: bool;
    var inst_4: i32;
    var t_14: f32;
    var side_5: f32;
    var root_2: vec2<f32>;
    var dir_5: vec2<f32>;
    var width_5: f32;
    var param_528: i32;
    var param_529: i32;
    var cols: i32;
    var rows: i32;
    var col_1: i32;
    var row_2: i32;
    var k_9: i32;
    var uv_6: vec2<f32>;
    var along_1: f32;
    var local_62: f32;
    var z_16: f32;
    var point_3: vec2<f32>;
    var local_63: vec2<f32>;
    var verts_1: array<vec3<f32>, 4>;
    var param_530: vec2<f32>;
    var param_531: f32;
    var param_532: f32;
    var coords_1: array<vec2<f32>, 4>;
    var k_10: i32;
    var a_17: vec2<f32>;
    var b_13: vec2<f32>;
    var c_12: vec2<f32>;
    var q_16: vec2<f32>;
    var det_1: f32;
    var param_533: vec2<f32>;
    var param_534: vec2<f32>;
    var u_6: f32;
    var param_535: vec2<f32>;
    var param_536: vec2<f32>;
    var v_10: f32;
    var param_537: vec2<f32>;
    var param_538: vec2<f32>;
    var z_17: f32;
    var uv_7: vec2<f32>;
    var margin: f32;
    var ny: f32;
    var light_2: f32;
    var phi_9108_: bool;

    let _e120 = (*address_1);
    if (_e120 >= 80640i) {
        return vec4<f32>(0f, 0f, 0f, 0f);
    }
    let _e122 = cameraTruck();
    truck_1 = _e122;
    let _e123 = (*address_1);
    let _e132 = (*address_1);
    canonical = (vec2<f32>(-255f, 850f) + ((vec2<f32>(f32((_e123 - (i32(floor((f32(_e123) / f32(420i)))) * 420i))), f32((_e132 / 420i))) + vec2(0.5f)) / vec2(0.7f)));
    let _e141 = canonical;
    param_521 = _e141;
    param_522 = 7.16f;
    let _e142 = truck_1;
    param_523 = _e142;
    let _e143 = fernProjectionvf2f1f1_((&param_521), (&param_522), (&param_523));
    pos_3 = _e143;
    depth_2 = 100f;
    best_2 = vec4<f32>(0f, 0f, 0f, 0f);
    fr_1 = 0i;
    loop {
        let _e144 = fr_1;
        if (_e144 < 7i) {
            let _e146 = fr_1;
            let _e148 = fr_1;
            param_524 = _e148;
            param_525 = 2i;
            let _e149 = rndi1i1_((&param_524), (&param_525));
            angle_5 = mix(-2.95f, -0.2f, ((f32(_e146) + (0.4f * _e149)) / 7f));
            let _e154 = angle_5;
            let _e156 = angle_5;
            let _e160 = fr_1;
            param_526 = _e160;
            param_527 = 7i;
            let _e161 = rndi1i1_((&param_526), (&param_527));
            ext_1 = ((vec2<f32>(cos(_e154), sin(_e156)) * 245f) * (0.66f + (0.54f * _e161)));
            let _e165 = ext_1;
            d_10 = normalize(_e165);
            origin_1 = vec2<f32>(34f, 1119f);
            leaf_1 = -1i;
            loop {
                let _e167 = leaf_1;
                if (_e167 < 36i) {
                    let _e169 = leaf_1;
                    stem_1 = (_e169 < 0i);
                    let _e171 = fr_1;
                    let _e173 = leaf_1;
                    inst_4 = ((_e171 * 36i) + max(0i, _e173));
                    let _e176 = leaf_1;
                    t_14 = ((f32((max(0i, _e176) / 2i)) + 0.7f) / 19f);
                    let _e182 = leaf_1;
                    side_5 = select(1f, -1f, ((_e182 - (i32(floor((f32(_e182) / f32(2i)))) * 2i)) == 0i));
                    let _e192 = origin_1;
                    let _e193 = ext_1;
                    let _e194 = t_14;
                    let _e198 = ext_1[0u];
                    let _e201 = t_14;
                    let _e203 = t_14;
                    let _e205 = t_14;
                    let _e207 = t_14;
                    root_2 = ((_e192 + (_e193 * _e194)) + vec2<f32>(0f, ((((0.42f * abs(_e198)) * _e201) * _e203) - ((22f * _e205) * (1f - _e207)))));
                    let _e213 = d_10;
                    let _e215 = side_5;
                    let _e217 = d_10[1u];
                    let _e220 = d_10[0u];
                    dir_5 = normalize(((_e213 * 0.52f) + (vec2<f32>(-(_e217), _e220) * _e215)));
                    let _e225 = t_14;
                    let _e232 = inst_4;
                    param_528 = _e232;
                    param_529 = 2i;
                    let _e233 = rndi1i1_((&param_528), (&param_529));
                    width_5 = ((49f * (0.22f + (0.78f * sin((3.1415927f * pow(_e225, 0.8f)))))) * (0.7f + (0.48f * _e233)));
                    let _e237 = stem_1;
                    let _e238 = !(_e237);
                    phi_9108_ = _e238;
                    if _e238 {
                        let _e239 = canonical;
                        let _e240 = root_2;
                        let _e242 = width_5;
                        phi_9108_ = (distance(_e239, _e240) > (_e242 + 15f));
                    }
                    let _e246 = phi_9108_;
                    if _e246 {
                        continue;
                    }
                    let _e247 = stem_1;
                    cols = select(6i, 15i, _e247);
                    let _e249 = stem_1;
                    rows = select(2i, 1i, _e249);
                    col_1 = 0i;
                    loop {
                        let _e251 = col_1;
                        let _e252 = cols;
                        if (_e251 < _e252) {
                            row_2 = 0i;
                            loop {
                                let _e254 = row_2;
                                let _e255 = rows;
                                if (_e254 < _e255) {
                                    k_9 = 0i;
                                    loop {
                                        let _e257 = k_9;
                                        if (_e257 < 4i) {
                                            let _e259 = col_1;
                                            let _e260 = k_9;
                                            let _e262 = k_9;
                                            let _e268 = row_2;
                                            let _e269 = k_9;
                                            let _e275 = cols;
                                            let _e277 = rows;
                                            uv_6 = (vec2<f32>(f32((_e259 + select(0i, 1i, ((_e260 == 1i) || (_e262 == 2i))))), f32((_e268 + select(0i, 1i, (_e269 >= 2i))))) / vec2<f32>(f32(_e275), f32(_e277)));
                                            let _e281 = stem_1;
                                            if _e281 {
                                                let _e283 = uv_6[0u];
                                                local_62 = _e283;
                                            } else {
                                                let _e284 = t_14;
                                                local_62 = _e284;
                                            }
                                            let _e285 = local_62;
                                            along_1 = _e285;
                                            let _e286 = along_1;
                                            let _e290 = uv_6[0u];
                                            z_16 = ((7.1f + (0.08f * _e286)) + (0.05f * _e290));
                                            let _e293 = stem_1;
                                            if _e293 {
                                                let _e294 = origin_1;
                                                let _e295 = ext_1;
                                                let _e296 = along_1;
                                                let _e300 = uv_6[1u];
                                                let _e304 = ext_1[0u];
                                                let _e307 = along_1;
                                                let _e309 = along_1;
                                                let _e311 = along_1;
                                                let _e313 = along_1;
                                                local_63 = ((_e294 + (_e295 * _e296)) + vec2<f32>(((_e300 - 0.5f) * 1.8f), ((((0.42f * abs(_e304)) * _e307) * _e309) - ((22f * _e311) * (1f - _e313)))));
                                            } else {
                                                let _e319 = root_2;
                                                let _e320 = width_5;
                                                let _e321 = dir_5;
                                                let _e323 = uv_6[0u];
                                                let _e326 = dir_5[1u];
                                                let _e329 = dir_5[0u];
                                                let _e332 = uv_6[1u];
                                                let _e337 = uv_6[0u];
                                                local_63 = (_e319 + (((_e321 * _e323) + (((vec2<f32>(-(_e326), _e329) * (_e332 - 0.5f)) * 0.37f) * sin((_e337 * 3.1415927f)))) * _e320));
                                            }
                                            let _e344 = local_63;
                                            point_3 = _e344;
                                            let _e345 = k_9;
                                            let _e346 = point_3;
                                            param_530 = _e346;
                                            let _e347 = z_16;
                                            param_531 = _e347;
                                            let _e348 = truck_1;
                                            param_532 = _e348;
                                            let _e349 = fernProjectionvf2f1f1_((&param_530), (&param_531), (&param_532));
                                            let _e350 = z_16;
                                            verts_1[_e345] = vec3<f32>(_e349.x, _e349.y, _e350);
                                            let _e355 = k_9;
                                            let _e356 = uv_6;
                                            coords_1[_e355] = _e356;
                                            continue;
                                        } else {
                                            break;
                                        }
                                        continuing {
                                            let _e358 = k_9;
                                            k_9 = (_e358 + 1i);
                                        }
                                    }
                                    k_10 = 1i;
                                    loop {
                                        let _e360 = k_10;
                                        if (_e360 < 3i) {
                                            let _e363 = verts_1[0i];
                                            a_17 = _e363.xy;
                                            let _e365 = k_10;
                                            let _e367 = verts_1[_e365];
                                            let _e369 = a_17;
                                            b_13 = (_e367.xy - _e369);
                                            let _e371 = k_10;
                                            let _e374 = verts_1[(_e371 + 1i)];
                                            let _e376 = a_17;
                                            c_12 = (_e374.xy - _e376);
                                            let _e378 = pos_3;
                                            let _e379 = a_17;
                                            q_16 = (_e378 - _e379);
                                            let _e381 = b_13;
                                            param_533 = _e381;
                                            let _e382 = c_12;
                                            param_534 = _e382;
                                            let _e383 = cross2vf2vf2_((&param_533), (&param_534));
                                            det_1 = _e383;
                                            let _e384 = det_1;
                                            if (abs(_e384) < 0.0001f) {
                                                continue;
                                            }
                                            let _e387 = q_16;
                                            param_535 = _e387;
                                            let _e388 = c_12;
                                            param_536 = _e388;
                                            let _e389 = cross2vf2vf2_((&param_535), (&param_536));
                                            let _e390 = det_1;
                                            u_6 = (_e389 / _e390);
                                            let _e392 = b_13;
                                            param_537 = _e392;
                                            let _e393 = q_16;
                                            param_538 = _e393;
                                            let _e394 = cross2vf2vf2_((&param_537), (&param_538));
                                            let _e395 = det_1;
                                            v_10 = (_e394 / _e395);
                                            let _e397 = u_6;
                                            let _e398 = v_10;
                                            let _e400 = u_6;
                                            let _e402 = v_10;
                                            if (min(min(_e397, _e398), ((1f - _e400) - _e402)) < 0f) {
                                                continue;
                                            }
                                            let _e408 = verts_1[0i][2u];
                                            let _e409 = u_6;
                                            let _e411 = v_10;
                                            let _e414 = u_6;
                                            let _e415 = k_10;
                                            let _e418 = verts_1[_e415][2u];
                                            let _e421 = v_10;
                                            let _e422 = k_10;
                                            let _e426 = verts_1[(_e422 + 1i)][2u];
                                            z_17 = (((_e408 * ((1f - _e409) - _e411)) + (_e414 * _e418)) + (_e421 * _e426));
                                            let _e429 = z_17;
                                            let _e430 = depth_2;
                                            if (_e429 >= _e430) {
                                                continue;
                                            }
                                            let _e432 = z_17;
                                            depth_2 = _e432;
                                            let _e434 = coords_1[0i];
                                            let _e435 = u_6;
                                            let _e437 = v_10;
                                            let _e440 = u_6;
                                            let _e441 = k_10;
                                            let _e443 = coords_1[_e441];
                                            let _e446 = v_10;
                                            let _e447 = k_10;
                                            let _e450 = coords_1[(_e447 + 1i)];
                                            uv_7 = (((_e434 * ((1f - _e435) - _e437)) + (_e443 * _e440)) + (_e450 * _e446));
                                            let _e454 = uv_7[1u];
                                            margin = abs(((2f * _e454) - 1f));
                                            let _e459 = uv_7[1u];
                                            ny = (0.38f + (0.6f * sin((_e459 * 3.1415927f))));
                                            let _e464 = ny;
                                            let _e466 = ny;
                                            let _e467 = ny;
                                            let _e473 = margin;
                                            light_2 = ((0.21f + ((0.4f * _e464) / sqrt(((_e466 * _e467) + 0.49f)))) + (0.17f * _e473));
                                            let _e476 = light_2;
                                            let _e478 = mix(vec3<f32>(0.09f, 0.132f, 0.12f), vec3<f32>(0.247f, 0.291f, 0.205f), vec3(_e476));
                                            best_2 = vec4<f32>(_e478.x, _e478.y, _e478.z, 1f);
                                            continue;
                                        } else {
                                            break;
                                        }
                                        continuing {
                                            let _e483 = k_10;
                                            k_10 = (_e483 + 1i);
                                        }
                                    }
                                    continue;
                                } else {
                                    break;
                                }
                                continuing {
                                    let _e485 = row_2;
                                    row_2 = (_e485 + 1i);
                                }
                            }
                            continue;
                        } else {
                            break;
                        }
                        continuing {
                            let _e487 = col_1;
                            col_1 = (_e487 + 1i);
                        }
                    }
                    continue;
                } else {
                    break;
                }
                continuing {
                    let _e489 = leaf_1;
                    leaf_1 = (_e489 + 1i);
                }
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e491 = fr_1;
            fr_1 = (_e491 + 1i);
        }
    }
    let _e493 = best_2;
    return _e493;
}

fn mainImagevf4vf2_(c_13: ptr<function, vec4<f32>>, px: ptr<function, vec2<f32>>) {
    var atlasH: i32;
    var address_2: i32;
    var local_64: vec4<f32>;
    var param_539: i32;
    var X: i32;
    var Y: i32;
    var bandGroup: i32;
    var key_7: i32;
    var first_1: i32;
    var param_540: i32;
    var end_1: i32;
    var param_541: i32;
    var column: i32;
    var rowFirst: i32;
    var local_65: i32;
    var param_542: i32;
    var rowEnd: i32;
    var local_66: i32;
    var param_543: i32;
    var param_544: vec2<f32>;
    var id_9: i32;
    var param_545: i32;
    var param_546: i32;
    var param_547: i32;
    var param_548: i32;
    var key_8: i32;
    var first_2: i32;
    var param_549: i32;
    var param_550: i32;
    var at_7: i32;
    var corner: vec2<i32>;
    var param_551: vec2<f32>;
    var phi_12905_: bool;
    var phi_12912_: bool;
    var phi_13008_: bool;

    let _e66 = unnamed.iResolution[1u];
    atlasH = i32(floor((0.68f * _e66)));
    let _e71 = (*px)[1u];
    let _e73 = atlasH;
    if (i32(_e71) >= _e73) {
        let _e76 = (*px)[0u];
        let _e79 = (*px)[1u];
        let _e81 = atlasH;
        let _e85 = unnamed.iResolution[0u];
        address_2 = (i32(_e76) + ((i32(_e79) - _e81) * i32(_e85)));
        let _e89 = address_2;
        if (_e89 >= 540960i) {
            let _e92 = unnamed.iFrame;
            if (_e92 >= 192i) {
                let _e94 = address_2;
                param_539 = (_e94 - 540960i);
                let _e96 = lensFerni1_((&param_539));
                local_64 = _e96;
            } else {
                local_64 = vec4<f32>(0f, 0f, 0f, 0f);
            }
            let _e97 = local_64;
            (*c_13) = _e97;
            return;
        }
        let _e99 = unnamed.iFrame;
        if (_e99 < 192i) {
            (*c_13) = vec4<f32>(0f, 0f, 0f, 0f);
            return;
        }
        let _e102 = unnamed.iFrame;
        if (_e102 > 192i) {
            let _e104 = (*px);
            let _e106 = textureLoad(tex0_, vec2<i32>(_e104), 0i);
            (*c_13) = _e106;
            return;
        }
        let _e107 = address_2;
        X = (((_e107 - (i32(floor((f32(_e107) / f32(184i)))) * 184i)) - 30i) + 48i);
        let _e117 = address_2;
        let _e118 = (_e117 / 184i);
        Y = (((_e118 - (i32(floor((f32(_e118) / f32(84i)))) * 84i)) - 5i) + 48i);
        let _e128 = address_2;
        bandGroup = (_e128 / 15456i);
        let _e130 = bandGroup;
        let _e132 = Y;
        let _e135 = X;
        key_7 = ((((_e130 * 256i) + _e132) * 256i) + _e135);
        let _e137 = key_7;
        param_540 = _e137;
        let _e138 = firstPatchi1_((&param_540));
        first_1 = _e138;
        let _e139 = key_7;
        param_541 = (_e139 + 1i);
        let _e141 = firstPatchi1_((&param_541));
        end_1 = _e141;
        let _e142 = address_2;
        column = (_e142 - (i32(floor((f32(_e142) / f32(184i)))) * 184i));
        let _e150 = column;
        if (_e150 == 0i) {
            let _e152 = first_1;
            local_65 = _e152;
        } else {
            let _e153 = key_7;
            param_542 = (_e153 - 1i);
            let _e155 = firstPatchi1_((&param_542));
            local_65 = _e155;
        }
        let _e156 = local_65;
        rowFirst = _e156;
        let _e157 = column;
        if (_e157 == 183i) {
            let _e159 = end_1;
            local_66 = _e159;
        } else {
            let _e160 = key_7;
            param_543 = (_e160 + 2i);
            let _e162 = firstPatchi1_((&param_543));
            local_66 = _e162;
        }
        let _e163 = local_66;
        rowEnd = _e163;
        let _e164 = first_1;
        let _e166 = end_1;
        let _e167 = first_1;
        let _e170 = rowFirst;
        let _e172 = rowEnd;
        let _e173 = rowFirst;
        (*c_13) = vec4<f32>(f32(_e164), f32((_e166 - _e167)), f32(_e170), f32((_e172 - _e173)));
        return;
    }
    let _e178 = unnamed.iFrame;
    let _e179 = (_e178 >= 193i);
    phi_12905_ = _e179;
    if _e179 {
        let _e181 = (*px)[0u];
        phi_12905_ = (_e181 < 1022f);
    }
    let _e184 = phi_12905_;
    phi_12912_ = _e184;
    if _e184 {
        let _e186 = (*px)[1u];
        phi_12912_ = (_e186 < 413f);
    }
    let _e189 = phi_12912_;
    if _e189 {
        let _e190 = (*px);
        param_544 = _e190;
        let _e191 = renderMirrorvf2_((&param_544));
        (*c_13) = vec4<f32>(_e191.x, _e191.y, _e191.z, 1f);
        return;
    }
    let _e197 = (*px)[0u];
    let _e200 = (*px)[1u];
    let _e204 = unnamed.iResolution[0u];
    id_9 = (i32(_e197) + (i32(_e200) * i32(_e204)));
    let _e208 = id_9;
    if (_e208 < 524288i) {
        let _e210 = id_9;
        param_545 = _e210;
        let _e211 = lightSorti1_((&param_545));
        (*c_13) = _e211;
        return;
    }
    let _e213 = unnamed.iFrame;
    if (_e213 > 192i) {
        let _e215 = id_9;
        param_546 = _e215;
        let _e216 = previousi1_((&param_546));
        (*c_13) = _e216;
        return;
    }
    let _e217 = id_9;
    param_547 = 9i;
    let _e218 = levelStarti1_((&param_547));
    if (_e217 < (524288i + _e218)) {
        (*c_13) = vec4<f32>(0f, 0f, 0f, 0f);
        let _e222 = unnamed.iFrame;
        if (_e222 < 191i) {
            return;
        }
        let _e225 = unnamed.iFrame;
        if (_e225 > 191i) {
            let _e227 = id_9;
            param_548 = _e227;
            let _e228 = previousi1_((&param_548));
            (*c_13) = _e228;
            return;
        }
        let _e229 = id_9;
        key_8 = (_e229 - 524288i);
        let _e231 = key_8;
        param_549 = _e231;
        let _e232 = firstLighti1_((&param_549));
        first_2 = _e232;
        let _e233 = first_2;
        let _e235 = key_8;
        param_550 = (_e235 + 1i);
        let _e237 = firstLighti1_((&param_550));
        let _e238 = first_2;
        (*c_13) = vec4<f32>(f32(_e233), f32((_e237 - _e238)), 0f, 1f);
        return;
    }
    let _e242 = id_9;
    at_7 = (_e242 - 900000i);
    let _e244 = at_7;
    let _e246 = at_7;
    let _e248 = ((_e244 < 0i) || (_e246 >= 262144i));
    phi_13008_ = _e248;
    if !(_e248) {
        let _e251 = unnamed.iFrame;
        phi_13008_ = (_e251 < 192i);
    }
    let _e254 = phi_13008_;
    if _e254 {
        (*c_13) = vec4<f32>(0f, 0f, 0f, 0f);
        return;
    }
    let _e255 = at_7;
    let _e263 = at_7;
    corner = (vec2(2i) * vec2<i32>((_e255 - (i32(floor((f32(_e255) / f32(512i)))) * 512i)), (_e263 / 512i)));
    let _e268 = corner;
    param_551 = (vec2<f32>(_e268) + vec2(1f));
    let _e272 = shadowDepthvf2_((&param_551));
    (*c_13) = vec4(_e272);
    return;
}

fn main_1() {
    var param_552: vec4<f32>;
    var param_553: vec2<f32>;

    let _e4 = gl_FragCoord_1;
    param_553 = _e4.xy;
    mainImagevf4vf2_((&param_552), (&param_553));
    let _e6 = param_552;
    col_2 = _e6;
    return;
}

@fragment
fn main(@builtin(position) gl_FragCoord: vec4<f32>) -> @location(0) vec4<f32> {
    gl_FragCoord_1 = gl_FragCoord;
    main_1();
    let _e3 = col_2;
    return _e3;
}
