diagnostic(off, derivative_uniformity);
struct NeedleVertex {
    p: vec3<f32>,
    radial: vec4<f32>,
}

struct Params {
    iResolution: vec3<f32>,
    iTime: f32,
    channelSizes: array<vec4<f32>, 4>,
    iFrame: i32,
}

var<private> object: i32;
var<private> datum: vec2<f32>;
var<private> unit: f32;
var<private> strike: vec2<f32>;
var<private> position: vec3<f32>;
var<private> origin: vec3<f32>;
var<private> dims: vec3<f32>;
@group(0) @binding(1)
var tex0_: texture_2d<f32>;
@group(0) @binding(5)
var samp0_: sampler;
@group(0) @binding(0)
var<uniform> unnamed: Params;
var<private> col: vec4<f32>;
var<private> gl_FragCoord_1: vec4<f32>;
@group(0) @binding(2)
var tex1_: texture_2d<f32>;
@group(0) @binding(6)
var samp1_: sampler;
@group(0) @binding(3)
var tex2_: texture_2d<f32>;
@group(0) @binding(7)
var samp2_: sampler;
@group(0) @binding(4)
var tex3_: texture_2d<f32>;
@group(0) @binding(8)
var samp3_: sampler;

fn rockSurveyvf2_(world: ptr<function, vec2<f32>>) -> vec2<f32> {
    var local: vec2<f32>;
    var texel: vec2<f32>;
    var phi_3579_: bool;

    let _e14 = (*world);
    local = (_e14 - vec2<f32>(-100f, 320f));
    let _e16 = local;
    let _e18 = any((_e16 < vec2<f32>(0f, 0f)));
    phi_3579_ = _e18;
    if !(_e18) {
        let _e20 = local;
        phi_3579_ = any((_e20 >= vec2<f32>(1024f, 768f)));
    }
    let _e24 = phi_3579_;
    if _e24 {
        return vec2<f32>(0f, 0f);
    }
    let _e25 = local;
    texel = (vec2<f32>(769f, 0f) + clamp(_e25, vec2<f32>(0.5f, 0.5f), vec2<f32>(1023.5f, 767.5f)));
    let _e28 = texel;
    let _e31 = unnamed.channelSizes[0i];
    let _e34 = textureSampleLevel(tex0_, samp0_, (_e28 / _e31.xy), 0f);
    return _e34.xy;
}

fn capvf2_(world_1: ptr<function, vec2<f32>>) -> f32 {
    var param: vec2<f32>;

    let _e2 = (*world_1);
    param = _e2;
    let _e3 = rockSurveyvf2_((&param));
    return _e3.x;
}

fn axes() -> vec3<f32> {
    let _e2 = strike;
    return vec3<f32>(_e2.x, _e2.y, 1f);
}

fn worldvf3_(p: ptr<function, vec3<f32>>) -> vec3<f32> {
    let _e8 = position;
    let _e9 = unit;
    let _e11 = (*p)[0u];
    let _e13 = datum[0u];
    let _e16 = datum[1u];
    let _e18 = (*p)[1u];
    let _e21 = axes();
    let _e23 = (*p)[2u];
    return (_e8 + ((vec3<f32>((_e11 - _e13), (_e16 - _e18), 0f) + (_e21 * _e23)) * _e9));
}

fn hashvf3_(p_1: ptr<function, vec3<f32>>) -> f32 {
    let _e6 = (*p_1);
    (*p_1) = fract((_e6 * 0.1031f));
    let _e9 = (*p_1);
    let _e10 = (*p_1);
    let _e15 = (*p_1);
    (*p_1) = (_e15 + vec3(dot(_e9, (_e10.yzx + vec3(33.33f)))));
    let _e19 = (*p_1)[0u];
    let _e21 = (*p_1)[1u];
    let _e24 = (*p_1)[2u];
    return fract(((_e19 + _e21) * _e24));
}

fn facetsvf3f1_(p_2: ptr<function, vec3<f32>>, scale: ptr<function, f32>) -> vec2<f32> {
    var q: vec3<f32>;
    var cell: vec3<f32>;
    var w: vec3<f32>;
    var a: f32;
    var b: f32;
    var tilt: f32;
    var z: i32;
    var y: i32;
    var x: i32;
    var k: vec3<f32>;
    var id: vec3<f32>;
    var off: vec3<f32>;
    var param_1: vec3<f32>;
    var param_2: vec3<f32>;
    var param_3: vec3<f32>;
    var t: f32;
    var param_4: vec3<f32>;
    var param_5: vec3<f32>;
    var param_6: vec3<f32>;
    var edge: f32;

    let _e42 = (*p_2)[0u];
    let _e45 = (*p_2)[1u];
    let _e49 = (*p_2)[0u];
    let _e52 = (*p_2)[1u];
    let _e57 = (*p_2)[2u];
    let _e59 = (*scale);
    q = (vec3<f32>(((0.93f * _e42) + (0.368f * _e45)), (((-0.368f * _e49) + (0.93f * _e52)) * 0.25f), _e57) / vec3(_e59));
    let _e62 = q;
    cell = floor(_e62);
    let _e64 = q;
    w = fract(_e64);
    a = 10f;
    b = 10f;
    tilt = 0f;
    z = -1i;
    loop {
        let _e66 = z;
        if (_e66 <= 1i) {
            y = -1i;
            loop {
                let _e68 = y;
                if (_e68 <= 1i) {
                    x = -1i;
                    loop {
                        let _e70 = x;
                        if (_e70 <= 1i) {
                            let _e72 = x;
                            let _e74 = y;
                            let _e76 = z;
                            k = vec3<f32>(f32(_e72), f32(_e74), f32(_e76));
                            let _e79 = cell;
                            let _e80 = k;
                            id = (_e79 + _e80);
                            let _e82 = k;
                            let _e85 = id;
                            param_1 = _e85;
                            let _e86 = hashvf3_((&param_1));
                            let _e87 = id;
                            param_2 = (_e87 + vec3(57f));
                            let _e90 = hashvf3_((&param_2));
                            let _e91 = id;
                            param_3 = (_e91 + vec3(13f));
                            let _e94 = hashvf3_((&param_3));
                            let _e100 = w;
                            off = (((_e82 + vec3(0.5f)) + ((vec3<f32>(_e86, _e90, _e94) - vec3(0.5f)) * 0.38f)) - _e100);
                            let _e102 = off;
                            let _e103 = off;
                            t = dot(_e102, _e103);
                            let _e105 = t;
                            let _e106 = a;
                            if (_e105 < _e106) {
                                let _e108 = a;
                                b = _e108;
                                let _e109 = t;
                                a = _e109;
                                let _e110 = off;
                                let _e111 = id;
                                param_4 = (_e111 + vec3(5f));
                                let _e114 = hashvf3_((&param_4));
                                let _e115 = id;
                                param_5 = (_e115 + vec3(9f));
                                let _e118 = hashvf3_((&param_5));
                                let _e119 = id;
                                param_6 = (_e119 + vec3(31f));
                                let _e122 = hashvf3_((&param_6));
                                tilt = dot(_e110, (vec3<f32>(_e114, _e118, _e122) - vec3(0.5f)));
                            } else {
                                let _e127 = b;
                                let _e128 = t;
                                b = min(_e127, _e128);
                            }
                            continue;
                        } else {
                            break;
                        }
                        continuing {
                            let _e130 = x;
                            x = (_e130 + 1i);
                        }
                    }
                    continue;
                } else {
                    break;
                }
                continuing {
                    let _e132 = y;
                    y = (_e132 + 1i);
                }
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e134 = z;
            z = (_e134 + 1i);
        }
    }
    let _e136 = b;
    let _e138 = a;
    let _e141 = (*scale);
    edge = ((sqrt(_e136) - sqrt(_e138)) * _e141);
    let _e143 = tilt;
    let _e144 = edge;
    let _e147 = edge;
    return vec2<f32>((_e143 * smoothstep(0f, 2.8f, _e144)), _e147);
}

fn rooff1_(x_1: ptr<function, f32>) -> f32 {
    var lo: i32;
    var hi: i32;
    var i: i32;
    var m: i32;
    var indexable: array<vec2<f32>, 77>;
    var a_1: vec2<f32>;
    var indexable_1: array<vec2<f32>, 77>;
    var b_1: vec2<f32>;
    var indexable_2: array<vec2<f32>, 77>;

    lo = 0i;
    hi = 76i;
    i = 0i;
    loop {
        let _e21 = i;
        if (_e21 < 8i) {
            let _e23 = hi;
            let _e24 = lo;
            m = ((_e23 + _e24) / 2i);
            let _e27 = (*x_1);
            let _e28 = m;
            indexable = array<vec2<f32>, 77>(vec2<f32>(890f, 466f), vec2<f32>(997f, 402f), vec2<f32>(1058f, 352f), vec2<f32>(1093f, 320f), vec2<f32>(1099f, 310f), vec2<f32>(1109f, 303f), vec2<f32>(1125f, 277f), vec2<f32>(1137f, 265f), vec2<f32>(1147f, 260f), vec2<f32>(1157f, 249f), vec2<f32>(1185f, 263f), vec2<f32>(1195f, 259f), vec2<f32>(1211f, 263f), vec2<f32>(1225f, 255f), vec2<f32>(1233f, 255f), vec2<f32>(1245f, 244f), vec2<f32>(1257f, 241f), vec2<f32>(1263f, 242f), vec2<f32>(1277f, 235f), vec2<f32>(1291f, 206f), vec2<f32>(1293f, 205f), vec2<f32>(1295f, 200f), vec2<f32>(1303f, 189f), vec2<f32>(1309f, 184f), vec2<f32>(1323f, 184f), vec2<f32>(1333f, 188f), vec2<f32>(1335f, 186f), vec2<f32>(1339f, 177f), vec2<f32>(1343f, 176f), vec2<f32>(1345f, 168f), vec2<f32>(1353f, 164f), vec2<f32>(1361f, 154f), vec2<f32>(1365f, 144f), vec2<f32>(1375f, 131f), vec2<f32>(1377f, 125f), vec2<f32>(1379f, 125f), vec2<f32>(1381f, 117f), vec2<f32>(1383f, 115f), vec2<f32>(1387f, 106f), vec2<f32>(1391f, 102f), vec2<f32>(1393f, 97f), vec2<f32>(1403f, 86f), vec2<f32>(1407f, 85f), vec2<f32>(1409f, 81f), vec2<f32>(1421f, 77f), vec2<f32>(1435f, 78f), vec2<f32>(1455f, 86f), vec2<f32>(1465f, 93f), vec2<f32>(1480f, 93f), vec2<f32>(1487f, 85f), vec2<f32>(1495f, 79f), vec2<f32>(1505f, 83f), vec2<f32>(1511f, 83f), vec2<f32>(1521f, 70f), vec2<f32>(1531f, 69f), vec2<f32>(1539f, 75f), vec2<f32>(1547f, 76f), vec2<f32>(1561f, 87f), vec2<f32>(1569f, 96f), vec2<f32>(1585f, 127f), vec2<f32>(1591f, 130f), vec2<f32>(1599f, 142f), vec2<f32>(1607f, 147f), vec2<f32>(1627f, 153f), vec2<f32>(1633f, 149f), vec2<f32>(1647f, 153f), vec2<f32>(1655f, 147f), vec2<f32>(1667f, 146f), vec2<f32>(1687f, 157f), vec2<f32>(1707f, 172f), vec2<f32>(1733f, 185f), vec2<f32>(1759f, 190f), vec2<f32>(1780f, 204f), vec2<f32>(1810f, 211f), vec2<f32>(1870f, 237f), vec2<f32>(2000f, 288f), vec2<f32>(2070f, 340f));
            let _e31 = indexable[_e28][0u];
            if (_e27 < _e31) {
                let _e33 = m;
                hi = _e33;
            } else {
                let _e34 = m;
                lo = _e34;
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e35 = i;
            i = (_e35 + 1i);
        }
    }
    let _e37 = lo;
    indexable_1 = array<vec2<f32>, 77>(vec2<f32>(890f, 466f), vec2<f32>(997f, 402f), vec2<f32>(1058f, 352f), vec2<f32>(1093f, 320f), vec2<f32>(1099f, 310f), vec2<f32>(1109f, 303f), vec2<f32>(1125f, 277f), vec2<f32>(1137f, 265f), vec2<f32>(1147f, 260f), vec2<f32>(1157f, 249f), vec2<f32>(1185f, 263f), vec2<f32>(1195f, 259f), vec2<f32>(1211f, 263f), vec2<f32>(1225f, 255f), vec2<f32>(1233f, 255f), vec2<f32>(1245f, 244f), vec2<f32>(1257f, 241f), vec2<f32>(1263f, 242f), vec2<f32>(1277f, 235f), vec2<f32>(1291f, 206f), vec2<f32>(1293f, 205f), vec2<f32>(1295f, 200f), vec2<f32>(1303f, 189f), vec2<f32>(1309f, 184f), vec2<f32>(1323f, 184f), vec2<f32>(1333f, 188f), vec2<f32>(1335f, 186f), vec2<f32>(1339f, 177f), vec2<f32>(1343f, 176f), vec2<f32>(1345f, 168f), vec2<f32>(1353f, 164f), vec2<f32>(1361f, 154f), vec2<f32>(1365f, 144f), vec2<f32>(1375f, 131f), vec2<f32>(1377f, 125f), vec2<f32>(1379f, 125f), vec2<f32>(1381f, 117f), vec2<f32>(1383f, 115f), vec2<f32>(1387f, 106f), vec2<f32>(1391f, 102f), vec2<f32>(1393f, 97f), vec2<f32>(1403f, 86f), vec2<f32>(1407f, 85f), vec2<f32>(1409f, 81f), vec2<f32>(1421f, 77f), vec2<f32>(1435f, 78f), vec2<f32>(1455f, 86f), vec2<f32>(1465f, 93f), vec2<f32>(1480f, 93f), vec2<f32>(1487f, 85f), vec2<f32>(1495f, 79f), vec2<f32>(1505f, 83f), vec2<f32>(1511f, 83f), vec2<f32>(1521f, 70f), vec2<f32>(1531f, 69f), vec2<f32>(1539f, 75f), vec2<f32>(1547f, 76f), vec2<f32>(1561f, 87f), vec2<f32>(1569f, 96f), vec2<f32>(1585f, 127f), vec2<f32>(1591f, 130f), vec2<f32>(1599f, 142f), vec2<f32>(1607f, 147f), vec2<f32>(1627f, 153f), vec2<f32>(1633f, 149f), vec2<f32>(1647f, 153f), vec2<f32>(1655f, 147f), vec2<f32>(1667f, 146f), vec2<f32>(1687f, 157f), vec2<f32>(1707f, 172f), vec2<f32>(1733f, 185f), vec2<f32>(1759f, 190f), vec2<f32>(1780f, 204f), vec2<f32>(1810f, 211f), vec2<f32>(1870f, 237f), vec2<f32>(2000f, 288f), vec2<f32>(2070f, 340f));
    let _e39 = indexable_1[_e37];
    a_1 = _e39;
    let _e40 = hi;
    indexable_2 = array<vec2<f32>, 77>(vec2<f32>(890f, 466f), vec2<f32>(997f, 402f), vec2<f32>(1058f, 352f), vec2<f32>(1093f, 320f), vec2<f32>(1099f, 310f), vec2<f32>(1109f, 303f), vec2<f32>(1125f, 277f), vec2<f32>(1137f, 265f), vec2<f32>(1147f, 260f), vec2<f32>(1157f, 249f), vec2<f32>(1185f, 263f), vec2<f32>(1195f, 259f), vec2<f32>(1211f, 263f), vec2<f32>(1225f, 255f), vec2<f32>(1233f, 255f), vec2<f32>(1245f, 244f), vec2<f32>(1257f, 241f), vec2<f32>(1263f, 242f), vec2<f32>(1277f, 235f), vec2<f32>(1291f, 206f), vec2<f32>(1293f, 205f), vec2<f32>(1295f, 200f), vec2<f32>(1303f, 189f), vec2<f32>(1309f, 184f), vec2<f32>(1323f, 184f), vec2<f32>(1333f, 188f), vec2<f32>(1335f, 186f), vec2<f32>(1339f, 177f), vec2<f32>(1343f, 176f), vec2<f32>(1345f, 168f), vec2<f32>(1353f, 164f), vec2<f32>(1361f, 154f), vec2<f32>(1365f, 144f), vec2<f32>(1375f, 131f), vec2<f32>(1377f, 125f), vec2<f32>(1379f, 125f), vec2<f32>(1381f, 117f), vec2<f32>(1383f, 115f), vec2<f32>(1387f, 106f), vec2<f32>(1391f, 102f), vec2<f32>(1393f, 97f), vec2<f32>(1403f, 86f), vec2<f32>(1407f, 85f), vec2<f32>(1409f, 81f), vec2<f32>(1421f, 77f), vec2<f32>(1435f, 78f), vec2<f32>(1455f, 86f), vec2<f32>(1465f, 93f), vec2<f32>(1480f, 93f), vec2<f32>(1487f, 85f), vec2<f32>(1495f, 79f), vec2<f32>(1505f, 83f), vec2<f32>(1511f, 83f), vec2<f32>(1521f, 70f), vec2<f32>(1531f, 69f), vec2<f32>(1539f, 75f), vec2<f32>(1547f, 76f), vec2<f32>(1561f, 87f), vec2<f32>(1569f, 96f), vec2<f32>(1585f, 127f), vec2<f32>(1591f, 130f), vec2<f32>(1599f, 142f), vec2<f32>(1607f, 147f), vec2<f32>(1627f, 153f), vec2<f32>(1633f, 149f), vec2<f32>(1647f, 153f), vec2<f32>(1655f, 147f), vec2<f32>(1667f, 146f), vec2<f32>(1687f, 157f), vec2<f32>(1707f, 172f), vec2<f32>(1733f, 185f), vec2<f32>(1759f, 190f), vec2<f32>(1780f, 204f), vec2<f32>(1810f, 211f), vec2<f32>(1870f, 237f), vec2<f32>(2000f, 288f), vec2<f32>(2070f, 340f));
    let _e42 = indexable_2[_e40];
    b_1 = _e42;
    let _e44 = a_1[1u];
    let _e46 = b_1[1u];
    let _e47 = (*x_1);
    let _e49 = a_1[0u];
    let _e52 = b_1[0u];
    let _e54 = a_1[0u];
    return mix(_e44, _e46, clamp(((_e47 - _e49) / max(0.01f, (_e52 - _e54))), 0f, 1f));
}

fn buttressvf3vf4f1f1_(p_3: ptr<function, vec3<f32>>, station: ptr<function, vec4<f32>>, w_1: ptr<function, f32>, len: ptr<function, f32>) -> f32 {
    var h: f32;
    var x_2: f32;
    var nose: f32;
    var front: f32;
    var crown: f32;

    let _e29 = (*p_3)[1u];
    let _e31 = (*station)[1u];
    h = (_e29 - _e31);
    let _e34 = (*p_3)[0u];
    let _e36 = (*station)[0u];
    let _e39 = (*station)[2u];
    let _e40 = h;
    x_2 = ((_e34 - _e36) + (_e39 * _e40));
    let _e44 = (*station)[3u];
    let _e45 = h;
    nose = (_e44 - (0.25f * _e45));
    let _e48 = nose;
    let _e49 = x_2;
    let _e52 = nose;
    let _e53 = x_2;
    front = max((_e48 - (1.45f * _e49)), (_e52 + (0.47f * _e53)));
    let _e58 = (*station)[1u];
    let _e60 = (*p_3)[1u];
    let _e62 = x_2;
    let _e67 = x_2;
    let _e72 = (*station)[3u];
    let _e74 = (*p_3)[2u];
    crown = ((((_e58 - _e60) + (0.34f * max(-(_e62), 0f))) + (0.69f * max(_e67, 0f))) + (0.62f * max((_e72 - _e74), 0f)));
    let _e79 = front;
    let _e81 = (*p_3)[2u];
    let _e84 = crown;
    let _e87 = x_2;
    let _e89 = (*w_1);
    let _e90 = h;
    let _e98 = (*p_3)[2u];
    let _e100 = h;
    let _e101 = (*len);
    return max(max(((_e79 - _e81) * 0.58f), (_e84 * 0.7f)), max((abs(_e87) - (_e89 * (0.45f + (0.55f * clamp((_e90 / 42f), 0f, 1f))))), max((_e98 - 16f), ((_e100 - _e101) * 0.61f))));
}

fn roundBoxvf3vf3f1_(p_4: ptr<function, vec3<f32>>, b_2: ptr<function, vec3<f32>>, r: ptr<function, f32>) -> f32 {
    var q_1: vec3<f32>;

    let _e8 = (*p_4);
    let _e10 = (*b_2);
    let _e12 = (*r);
    q_1 = ((abs(_e8) - _e10) + vec3(_e12));
    let _e15 = q_1;
    let _e20 = q_1[0u];
    let _e22 = q_1[1u];
    let _e24 = q_1[2u];
    let _e29 = (*r);
    return ((length(max(_e15, vec3(0f))) + min(max(_e20, max(_e22, _e24)), 0f)) - _e29);
}

fn sminf1f1f1_(a_2: ptr<function, f32>, b_3: ptr<function, f32>, r_1: ptr<function, f32>) -> f32 {
    var h_1: f32;

    let _e6 = (*r_1);
    let _e7 = (*a_2);
    let _e8 = (*b_3);
    let _e13 = (*r_1);
    h_1 = (max((_e6 - abs((_e7 - _e8))), 0f) / _e13);
    let _e15 = (*a_2);
    let _e16 = (*b_3);
    let _e18 = (*r_1);
    let _e20 = h_1;
    let _e22 = h_1;
    return (min(_e15, _e16) - (((0.25f * _e18) * _e20) * _e22));
}

fn valueNoise3vf3_(p_5: ptr<function, vec3<f32>>) -> f32 {
    var i_1: vec3<f32>;
    var f: vec3<f32>;
    var param_7: vec3<f32>;
    var param_8: vec3<f32>;
    var param_9: vec3<f32>;
    var param_10: vec3<f32>;
    var param_11: vec3<f32>;
    var param_12: vec3<f32>;
    var param_13: vec3<f32>;
    var param_14: vec3<f32>;

    let _e23 = (*p_5);
    i_1 = floor(_e23);
    let _e25 = (*p_5);
    f = fract(_e25);
    let _e27 = f;
    let _e28 = f;
    let _e30 = f;
    f = ((_e27 * _e28) * (vec3(3f) - (_e30 * 2f)));
    let _e35 = i_1;
    param_7 = _e35;
    let _e36 = hashvf3_((&param_7));
    let _e37 = i_1;
    param_8 = (_e37 + vec3<f32>(1f, 0f, 0f));
    let _e39 = hashvf3_((&param_8));
    let _e41 = f[0u];
    let _e43 = i_1;
    param_9 = (_e43 + vec3<f32>(0f, 1f, 0f));
    let _e45 = hashvf3_((&param_9));
    let _e46 = i_1;
    param_10 = (_e46 + vec3<f32>(1f, 1f, 0f));
    let _e48 = hashvf3_((&param_10));
    let _e50 = f[0u];
    let _e53 = f[1u];
    let _e55 = i_1;
    param_11 = (_e55 + vec3<f32>(0f, 0f, 1f));
    let _e57 = hashvf3_((&param_11));
    let _e58 = i_1;
    param_12 = (_e58 + vec3<f32>(1f, 0f, 1f));
    let _e60 = hashvf3_((&param_12));
    let _e62 = f[0u];
    let _e64 = i_1;
    param_13 = (_e64 + vec3<f32>(0f, 1f, 1f));
    let _e66 = hashvf3_((&param_13));
    let _e67 = i_1;
    param_14 = (_e67 + vec3(1f));
    let _e70 = hashvf3_((&param_14));
    let _e72 = f[0u];
    let _e75 = f[1u];
    let _e78 = f[2u];
    return mix(mix(mix(_e36, _e39, _e41), mix(_e45, _e48, _e50), _e53), mix(mix(_e57, _e60, _e62), mix(_e66, _e70, _e72), _e75), _e78);
}

fn rockFieldvf3_(p_6: ptr<function, vec3<f32>>) -> f32 {
    var x_3: f32;
    var crest: f32;
    var summit: f32;
    var param_15: vec3<f32>;
    var k_1: f32;
    var uv: vec2<f32>;
    var q_2: vec3<f32>;
    var ball: f32;
    var cap: f32;
    var jointSpace: vec3<f32>;
    var mass: f32;
    var param_16: vec3<f32>;
    var joints: f32;
    var param_17: vec3<f32>;
    var flakes: f32;
    var param_18: vec3<f32>;
    var scar: f32;
    var param_19: vec3<f32>;
    var breakage: f32;
    var west: f32;
    var east: f32;
    var face: f32;
    var param_20: f32;
    var param_21: f32;
    var param_22: f32;
    var lip: f32;
    var sheets: f32;
    var param_23: vec3<f32>;
    var d: f32;
    var param_24: f32;
    var param_25: f32;
    var param_26: f32;
    var param_27: f32;
    var param_28: f32;
    var param_29: f32;
    var skin: f32;
    var param_30: vec3<f32>;
    var foot: f32;
    var param_31: vec3<f32>;
    var toe: f32;
    var param_32: f32;
    var param_33: f32;
    var param_34: f32;
    var d_1: f32;
    var i_2: i32;
    var s: vec4<f32>;
    var indexable_3: array<vec4<f32>, 20>;
    var q_3: vec2<f32>;
    var down: f32;
    var lat: f32;
    var dep: f32;
    var angle: f32;
    var indexable_4: array<f32, 20>;
    var ac: vec2<f32>;
    var param_35: vec3<f32>;
    var param_36: vec3<f32>;
    var param_37: f32;
    var param_38: f32;
    var param_39: f32;
    var param_40: f32;
    var param_41: vec3<f32>;
    var param_42: vec4<f32>;
    var param_43: f32;
    var param_44: f32;
    var param_45: f32;
    var param_46: f32;
    var param_47: f32;
    var param_48: vec3<f32>;
    var param_49: vec4<f32>;
    var param_50: f32;
    var param_51: f32;
    var param_52: f32;
    var param_53: f32;
    var param_54: f32;
    var param_55: vec3<f32>;
    var param_56: vec4<f32>;
    var param_57: f32;
    var param_58: f32;
    var param_59: f32;
    var param_60: f32;
    var param_61: f32;
    var top: f32;
    var param_62: f32;
    var shoulder: f32;
    var i_3: i32;
    var s_1: vec4<f32>;
    var local_1: vec4<f32>;
    var dy: f32;
    var a_3: f32;
    var i_4: i32;
    var s_2: vec4<f32>;
    var local_2: vec4<f32>;
    var local_3: vec4<f32>;
    var dx: f32;
    var span: f32;
    var bed: f32;
    var slopeRun: f32;
    var crossRun: f32;
    var drainage: f32;
    var param_63: vec3<f32>;
    var gravel: f32;
    var param_64: vec3<f32>;
    var apronY: f32;
    var tal: f32;
    var param_65: f32;
    var param_66: f32;
    var param_67: f32;
    var spur: vec3<f32>;
    var shoulderFoot: f32;
    var param_68: vec3<f32>;
    var param_69: f32;
    var param_70: f32;
    var param_71: f32;
    var f_1: vec2<f32>;
    var param_72: vec3<f32>;
    var param_73: f32;
    var g: vec2<f32>;
    var param_74: vec3<f32>;
    var param_75: f32;
    var fault: f32;
    var param_76: vec3<f32>;
    var relief: f32;
    var phi_3133_: bool;

    let _e297 = object;
    if (_e297 == 3i) {
        let _e300 = (*p_6)[0u];
        x_3 = (_e300 - 1849f);
        let _e302 = x_3;
        let _e304 = x_3;
        let _e308 = x_3;
        let _e313 = x_3;
        crest = (((168f + max((-0.39f * _e302), (0.21f * _e304))) + (4f * sin((_e308 * 0.071f)))) + (2.2f * sin(((_e313 * 0.13f) + 0.8f))));
        let _e319 = crest;
        let _e321 = (*p_6)[2u];
        summit = (_e319 + (0.58f * abs(_e321)));
        let _e325 = summit;
        let _e327 = (*p_6)[1u];
        let _e330 = (*p_6)[2u];
        let _e333 = x_3;
        let _e337 = (*p_6)[1u];
        let _e341 = (*p_6);
        param_15 = (_e341 * 0.048f);
        let _e343 = valueNoise3vf3_((&param_15));
        let _e348 = (*p_6)[2u];
        let _e351 = (*p_6)[1u];
        return max(max((_e325 - _e327), ((((-(_e330) - 40f) - (0.17f * _e333)) - (0.22f * (_e337 - 195f))) + (3f * _e343))), max((_e348 - 90f), (_e351 - 435f)));
    }
    let _e355 = object;
    let _e357 = object;
    if ((_e355 == 1i) || (_e357 == 2i)) {
        let _e360 = object;
        k_1 = select(0.49f, 1f, (_e360 == 1i));
        let _e363 = object;
        uv = select(vec2<f32>(1535f, 470f), vec2<f32>(1870f, 370f), vec2((_e363 == 1i)));
        let _e367 = (*p_6);
        let _e369 = uv;
        let _e370 = (_e367.xy - _e369);
        let _e372 = (*p_6)[2u];
        let _e376 = k_1;
        q_2 = (vec3<f32>(_e370.x, _e370.y, _e372) / vec3(_e376));
        let _e379 = object;
        if (_e379 == 2i) {
            let _e382 = q_2[1u];
            q_2[1u] = ((_e382 - 32f) / 0.56f);
        }
        let _e386 = q_2;
        let _e388 = q_2[1u];
        ball = ((length(((_e386 - vec3<f32>((24f + (0.26f * _e388)), 28f, 16f)) / vec3<f32>(308f, 209f, 119f))) - 1f) * 125f);
        let _e398 = q_2[0u];
        let _e402 = q_2[0u];
        let _e409 = q_2[0u];
        let _e416 = q_2[2u];
        let _e420 = q_2[1u];
        cap = (((((-137f - (0.105f * _e398)) + (0.31f * max((-(_e402) - 34f), 0f))) + (0.71f * max((-(_e409) - 116f), 0f))) - (0.16f * _e416)) - _e420);
        let _e423 = q_2[0u];
        let _e426 = q_2[1u];
        let _e430 = q_2[1u];
        let _e433 = q_2[2u];
        jointSpace = vec3<f32>(((0.031f * _e423) + (0.011f * _e426)), (0.018f * _e430), (0.025f * _e433));
        let _e436 = jointSpace;
        param_16 = (_e436 * 0.52f);
        let _e438 = valueNoise3vf3_((&param_16));
        mass = _e438;
        let _e439 = jointSpace;
        param_17 = _e439;
        let _e440 = valueNoise3vf3_((&param_17));
        joints = _e440;
        let _e441 = jointSpace;
        param_18 = (_e441 * 2.63f);
        let _e443 = valueNoise3vf3_((&param_18));
        flakes = abs((_e443 - 0.47f));
        let _e447 = q_2[0u];
        let _e450 = q_2[1u];
        let _e454 = q_2[1u];
        let _e457 = q_2[2u];
        param_19 = vec3<f32>(((0.025f * _e447) + (0.012f * _e450)), (_e454 * 0.009f), (_e457 * 0.022f));
        let _e460 = valueNoise3vf3_((&param_19));
        scar = abs((_e460 - 0.46f));
        let _e463 = mass;
        let _e466 = joints;
        let _e471 = flakes;
        let _e474 = scar;
        let _e476 = scar;
        breakage = ((((15f * (_e463 - 0.5f)) + (7f * abs((_e466 - 0.43f)))) + (2.5f * _e471)) + (5f * exp(((-(_e474) * _e476) * 290f))));
        let _e483 = q_2[2u];
        let _e487 = q_2[0u];
        let _e492 = q_2[1u];
        west = (((-(_e483) - 100f) - (0.62f * (_e487 + 62f))) - (0.2f * _e492));
        let _e496 = q_2[2u];
        let _e500 = q_2[0u];
        let _e505 = q_2[1u];
        east = (((-(_e496) - 104f) + (0.3f * (_e500 + 53f))) - (0.31f * _e505));
        let _e508 = west;
        let _e510 = east;
        param_20 = -(_e508);
        param_21 = -(_e510);
        param_22 = 42f;
        let _e512 = sminf1f1f1_((&param_20), (&param_21), (&param_22));
        let _e514 = breakage;
        face = (-(_e512) + _e514);
        let _e517 = q_2[0u];
        let _e519 = q_2[1u];
        let _e522 = mass;
        let _e526 = joints;
        lip = (((_e517 - (0.38f * _e519)) + (16f * (_e522 - 0.5f))) + (3.2f * _e526));
        let _e529 = lip;
        let _e532 = q_2[1u];
        let _e535 = q_2[2u];
        param_23 = vec3<f32>((_e529 * 0.032f), (_e532 * 0.01f), (_e535 * 0.026f));
        let _e538 = valueNoise3vf3_((&param_23));
        sheets = (2.2f * abs((_e538 - 0.38f)));
        let _e542 = ball;
        let _e544 = cap;
        let _e546 = mass;
        param_24 = -(_e542);
        param_25 = (-(_e544) - ((_e546 - 0.5f) * 9f));
        param_26 = 8f;
        let _e550 = sminf1f1f1_((&param_24), (&param_25), (&param_26));
        let _e551 = face;
        let _e552 = sheets;
        param_27 = _e550;
        param_28 = -((_e551 + _e552));
        param_29 = 15f;
        let _e555 = sminf1f1f1_((&param_27), (&param_28), (&param_29));
        d = -(_e555);
        let _e557 = jointSpace;
        param_30 = (_e557 * 3.6f);
        let _e559 = valueNoise3vf3_((&param_30));
        skin = (0.87f * (_e559 - 0.5f));
        let _e563 = q_2[0u];
        let _e567 = q_2[2u];
        let _e573 = q_2[0u];
        let _e580 = q_2[0u];
        foot = ((((60f - (0.11f * _e563)) + (0.46f * abs((_e567 + 102f)))) + (0.0019f * pow(max((-120f - _e573), 0f), 2f))) + (0.074f * abs((_e580 + 15f))));
        let _e586 = q_2[0u];
        let _e589 = q_2[2u];
        param_31 = vec3<f32>((_e586 * 0.04f), 4f, (_e589 * 0.039f));
        let _e592 = valueNoise3vf3_((&param_31));
        let _e594 = foot;
        foot = (_e594 + (4f * _e592));
        let _e596 = foot;
        let _e598 = q_2[1u];
        let _e601 = q_2[2u];
        let _e607 = q_2[0u];
        let _e610 = q_2[0u];
        toe = max(max((_e596 - _e598), (abs((_e601 + 104f)) - 77f)), max((-252f - _e607), (_e610 - 285f)));
        let _e614 = k_1;
        let _e615 = object;
        let _e619 = d;
        let _e620 = skin;
        param_32 = (_e619 + _e620);
        let _e622 = toe;
        param_33 = _e622;
        param_34 = 3f;
        let _e623 = sminf1f1f1_((&param_32), (&param_33), (&param_34));
        return ((_e614 * select(1f, 0.56f, (_e615 == 2i))) * _e623);
    }
    d_1 = 1000f;
    i_2 = 0i;
    loop {
        let _e625 = i_2;
        if (_e625 < 20i) {
            let _e627 = i_2;
            indexable_3 = array<vec4<f32>, 20>(vec4<f32>(1022f, 349f, 67f, -28f), vec4<f32>(1098f, 281f, 50f, -34f), vec4<f32>(1158f, 229f, 49f, -51f), vec4<f32>(1208f, 234f, 45f, -14f), vec4<f32>(1256f, 207f, 43f, -21f), vec4<f32>(1318f, 156f, 39f, -52f), vec4<f32>(1356f, 128f, 31f, -32f), vec4<f32>(1420f, 50f, 46f, -74f), vec4<f32>(1457f, 60f, 37f, -41f), vec4<f32>(1494f, 52f, 28f, -17f), vec4<f32>(1534f, 40f, 54f, -57f), vec4<f32>(1584f, 74f, 42f, -25f), vec4<f32>(1624f, 98f, 55f, -20f), vec4<f32>(1670f, 122f, 48f, -34f), vec4<f32>(1725f, 146f, 58f, -9f), vec4<f32>(1803f, 153f, 64f, -16f), vec4<f32>(1874f, 169f, 69f, -2f), vec4<f32>(1970f, 207f, 87f, 4f), vec4<f32>(1475f, 175f, 36f, -105f), vec4<f32>(1277f, 282f, 45f, -91f));
            let _e629 = indexable_3[_e627];
            s = _e629;
            let _e630 = (*p_6);
            let _e632 = s;
            q_3 = (_e630.xy - _e632.xy);
            let _e635 = q_3;
            down = dot(_e635, vec2<f32>(-0.368f, 0.93f));
            let _e637 = q_3;
            lat = dot(_e637, vec2<f32>(0.93f, 0.368f));
            let _e640 = (*p_6)[2u];
            let _e641 = down;
            let _e646 = s[3u];
            let _e649 = down;
            let _e651 = down;
            dep = (((_e640 + (0.32f * max(_e641, 0f))) - (_e646 + 69f)) + ((0.00032f * _e649) * _e651));
            let _e654 = i_2;
            indexable_4 = array<f32, 20>(8f, -3f, 5f, -4f, 6f, -5f, 5f, -4f, 4f, -5f, 6f, -5f, 4f, -6f, 3f, 5f, -4f, 3f, 8f, -5f);
            let _e656 = indexable_4[_e654];
            let _e658 = s[0u];
            angle = radians((_e656 + select(-13f, 26f, (_e658 < 1470f))));
            let _e663 = angle;
            let _e665 = angle;
            let _e667 = angle;
            let _e670 = angle;
            let _e675 = lat;
            let _e676 = dep;
            ac = (mat2x2<f32>(vec2<f32>(cos(_e663), sin(_e665)), vec2<f32>(-(sin(_e667)), cos(_e670))) * vec2<f32>(_e675, _e676));
            let _e680 = ac[0u];
            let _e681 = down;
            let _e684 = ac[1u];
            let _e687 = s[2u];
            let _e688 = down;
            param_35 = vec3<f32>(_e680, (_e681 - 177f), _e684);
            param_36 = vec3<f32>((_e687 + (0.043f * max(_e688, 0f))), 194f, 76f);
            param_37 = 6.5f;
            let _e693 = roundBoxvf3vf3f1_((&param_35), (&param_36), (&param_37));
            let _e694 = d_1;
            param_38 = _e694;
            param_39 = _e693;
            param_40 = 4f;
            let _e695 = sminf1f1f1_((&param_38), (&param_39), (&param_40));
            d_1 = _e695;
            continue;
        } else {
            break;
        }
        continuing {
            let _e696 = i_2;
            i_2 = (_e696 + 1i);
        }
    }
    let _e698 = (*p_6);
    param_41 = _e698;
    param_42 = vec4<f32>(1473f, 166f, 0.69f, -163f);
    param_43 = 57f;
    param_44 = 197f;
    let _e699 = buttressvf3vf4f1f1_((&param_41), (&param_42), (&param_43), (&param_44));
    let _e700 = d_1;
    param_45 = _e700;
    param_46 = _e699;
    param_47 = 3f;
    let _e701 = sminf1f1f1_((&param_45), (&param_46), (&param_47));
    d_1 = _e701;
    let _e702 = (*p_6);
    param_48 = _e702;
    param_49 = vec4<f32>(1414f, 83f, 0.35f, -127f);
    param_50 = 48f;
    param_51 = 236f;
    let _e703 = buttressvf3vf4f1f1_((&param_48), (&param_49), (&param_50), (&param_51));
    let _e704 = d_1;
    param_52 = _e704;
    param_53 = _e703;
    param_54 = 3f;
    let _e705 = sminf1f1f1_((&param_52), (&param_53), (&param_54));
    d_1 = _e705;
    let _e706 = (*p_6);
    param_55 = _e706;
    param_56 = vec4<f32>(1160f, 251f, 0.46f, -86f);
    param_57 = 29f;
    param_58 = 90f;
    let _e707 = buttressvf3vf4f1f1_((&param_55), (&param_56), (&param_57), (&param_58));
    let _e708 = d_1;
    param_59 = _e708;
    param_60 = _e707;
    param_61 = 3f;
    let _e709 = sminf1f1f1_((&param_59), (&param_60), (&param_61));
    d_1 = _e709;
    let _e711 = (*p_6)[0u];
    param_62 = _e711;
    let _e712 = rooff1_((&param_62));
    top = _e712;
    let _e714 = (*p_6)[0u];
    shoulder = (0.23f + (0.24f * smoothstep(20f, 125f, abs((_e714 - 1450f)))));
    let _e720 = d_1;
    let _e721 = top;
    let _e722 = shoulder;
    let _e724 = (*p_6)[2u];
    let _e730 = (*p_6)[2u];
    let _e735 = (*p_6)[1u];
    d_1 = max(_e720, ((((_e721 + (_e722 * max(-(_e724), 0f))) + (0.61f * max(_e730, 0f))) - _e735) * 0.72f));
    i_3 = 0i;
    loop {
        let _e739 = i_3;
        if (_e739 < 3i) {
            let _e741 = i_3;
            if (_e741 == 0i) {
                local_1 = vec4<f32>(1479f, 99f, 9f, 48f);
            } else {
                let _e743 = i_3;
                local_1 = select(vec4<f32>(1209f, 272f, 15f, 114f), vec4<f32>(1352f, 187f, 8f, 110f), vec4((_e743 == 1i)));
            }
            let _e747 = local_1;
            s_1 = _e747;
            let _e749 = (*p_6)[1u];
            let _e751 = s_1[1u];
            dy = (_e749 - _e751);
            let _e754 = (*p_6)[0u];
            let _e756 = s_1[0u];
            let _e758 = dy;
            a_3 = ((_e754 - _e756) + (0.37f * _e758));
            let _e761 = d_1;
            let _e762 = a_3;
            let _e765 = s_1[2u];
            let _e767 = dy;
            let _e770 = dy;
            let _e773 = dy;
            let _e775 = s_1[3u];
            let _e778 = (*p_6)[2u];
            let _e780 = a_3;
            let _e784 = dy;
            d_1 = max(_e761, -(max(max(((abs(_e762) - _e765) + (0.075f * _e767)), (-0.8f * _e770)), max((_e773 - _e775), (((_e778 + 56f) + (0.6f * abs(_e780))) - (0.24f * _e784))))));
            continue;
        } else {
            break;
        }
        continuing {
            let _e791 = i_3;
            i_3 = (_e791 + 1i);
        }
    }
    i_4 = 0i;
    loop {
        let _e793 = i_4;
        if (_e793 < 4i) {
            let _e795 = i_4;
            if (_e795 == 0i) {
                local_2 = vec4<f32>(1602f, 183f, 95f, 13f);
            } else {
                let _e797 = i_4;
                if (_e797 == 1i) {
                    local_3 = vec4<f32>(1618f, 231f, 116f, 21f);
                } else {
                    let _e799 = i_4;
                    local_3 = select(vec4<f32>(1490f, 130f, 38f, 8f), vec4<f32>(1630f, 268f, 87f, 18f), vec4((_e799 == 2i)));
                }
                let _e803 = local_3;
                local_2 = _e803;
            }
            let _e804 = local_2;
            s_2 = _e804;
            let _e806 = (*p_6)[0u];
            let _e808 = s_2[0u];
            dx = (_e806 - _e808);
            let _e810 = dx;
            let _e811 = dx;
            let _e814 = s_2[2u];
            let _e816 = s_2[2u];
            span = max(0f, (1f - ((_e810 * _e811) / (_e814 * _e816))));
            let _e822 = (*p_6)[1u];
            let _e824 = s_2[1u];
            let _e826 = dx;
            let _e829 = dx;
            bed = (((_e822 - _e824) - (0.33f * _e826)) - (2.1f * sin((0.032f * _e829))));
            let _e834 = d_1;
            let _e835 = bed;
            let _e837 = span;
            let _e840 = bed;
            let _e842 = (*p_6)[2u];
            let _e847 = dx;
            let _e850 = s_2[2u];
            let _e853 = (*p_6)[2u];
            let _e856 = s_2[3u];
            let _e857 = span;
            let _e860 = dx;
            d_1 = max(_e834, -(max(max((-(_e835) - (6.5f * _e837)), (_e840 + (0.36f * (_e842 + 90f)))), max((abs(_e847) - _e850), (((_e853 + 20f) - (_e856 * _e857)) + (0.09f * _e860))))));
            continue;
        } else {
            break;
        }
        continuing {
            let _e867 = i_4;
            i_4 = (_e867 + 1i);
        }
    }
    let _e870 = (*p_6)[2u];
    slopeRun = (-(_e870) - 108f);
    let _e874 = (*p_6)[0u];
    let _e876 = (*p_6)[2u];
    crossRun = (_e874 + (0.31f * _e876));
    let _e879 = crossRun;
    let _e882 = (*p_6)[2u];
    param_63 = vec3<f32>((_e879 * 0.023f), (_e882 * 0.012f), 3f);
    let _e885 = valueNoise3vf3_((&param_63));
    drainage = _e885;
    let _e886 = crossRun;
    let _e889 = (*p_6)[2u];
    param_64 = vec3<f32>((_e886 * 0.078f), (_e889 * 0.038f), 7f);
    let _e892 = valueNoise3vf3_((&param_64));
    gravel = _e892;
    let _e894 = (*p_6)[0u];
    let _e898 = slopeRun;
    let _e899 = slopeRun;
    let _e906 = (*p_6)[0u];
    let _e912 = (*p_6)[0u];
    let _e917 = drainage;
    let _e921 = gravel;
    apronY = ((((((353f - (0.065f * (_e894 - 1190f))) + (0.49f * sqrt(((_e898 * _e899) + 180f)))) + (0.47f * max((1130f - _e906), 0f))) + (0.39f * max((_e912 - 1400f), 0f))) + (10f * (_e917 - 0.5f))) + (3.8f * (_e921 - 0.5f)));
    let _e925 = apronY;
    let _e927 = (*p_6)[1u];
    let _e931 = (*p_6)[0u];
    let _e935 = (*p_6)[0u];
    tal = max(((_e925 - _e927) * 0.79f), max(((1040f - _e931) * 0.59f), ((_e935 - 1540f) * 0.61f)));
    let _e940 = tal;
    let _e942 = (*p_6)[2u];
    let _e946 = (*p_6)[2u];
    tal = max(_e940, max((-(_e942) - 317f), (_e946 - 168f)));
    let _e950 = d_1;
    param_65 = _e950;
    let _e951 = tal;
    param_66 = _e951;
    param_67 = 7f;
    let _e952 = sminf1f1f1_((&param_65), (&param_66), (&param_67));
    d_1 = _e952;
    let _e953 = (*p_6);
    spur = ((_e953 - vec3<f32>(1127f, 402f, -130f)) / vec3<f32>(128f, 39f, 82f));
    let _e956 = spur;
    let _e960 = (*p_6);
    param_68 = (_e960 * 0.035f);
    let _e962 = valueNoise3vf3_((&param_68));
    shoulderFoot = (((length(_e956) - 1f) * 38f) + (4f * _e962));
    let _e965 = d_1;
    param_69 = _e965;
    let _e966 = shoulderFoot;
    param_70 = _e966;
    param_71 = 6f;
    let _e967 = sminf1f1f1_((&param_69), (&param_70), (&param_71));
    d_1 = _e967;
    let _e968 = d_1;
    let _e970 = (abs(_e968) < 10f);
    phi_3133_ = _e970;
    if _e970 {
        let _e972 = (*p_6)[1u];
        let _e973 = top;
        phi_3133_ = (_e972 > (_e973 + 2f));
    }
    let _e977 = phi_3133_;
    let _e978 = tal;
    if (_e977 && (_e978 > 2f)) {
        let _e981 = (*p_6);
        param_72 = _e981;
        param_73 = 24f;
        let _e982 = facetsvf3f1_((&param_72), (&param_73));
        f_1 = _e982;
        let _e983 = (*p_6);
        param_74 = _e983;
        param_75 = 8f;
        let _e984 = facetsvf3f1_((&param_74), (&param_75));
        g = _e984;
        let _e986 = (*p_6)[0u];
        let _e989 = (*p_6)[1u];
        let _e993 = (*p_6)[1u];
        let _e996 = (*p_6)[2u];
        param_76 = vec3<f32>(((0.037f * _e986) + (0.014f * _e989)), (0.02f * _e993), (0.033f * _e996));
        let _e999 = valueNoise3vf3_((&param_76));
        fault = abs((_e999 - 0.48f));
        let _e1003 = f_1[0u];
        let _e1006 = g[0u];
        let _e1010 = f_1[1u];
        let _e1013 = f_1[1u];
        let _e1019 = fault;
        relief = ((((4.2f * _e1003) + (1.15f * _e1006)) + (0.62f * exp(((-(_e1010) * _e1013) * 0.36f)))) + (6.8f * _e1019));
        let _e1023 = (*p_6)[1u];
        let _e1024 = top;
        let _e1027 = tal;
        let _e1030 = relief;
        let _e1032 = d_1;
        d_1 = (_e1032 + ((smoothstep(2f, 15f, (_e1023 - _e1024)) * smoothstep(2f, 14f, _e1027)) * _e1030));
    }
    let _e1034 = d_1;
    return _e1034;
}

fn sdvf3_(p_7: ptr<function, vec3<f32>>) -> f32 {
    var param_77: vec3<f32>;

    let _e2 = (*p_7);
    param_77 = _e2;
    let _e3 = rockFieldvf3_((&param_77));
    return _e3;
}

fn localDirvf3_(v: ptr<function, vec3<f32>>) -> vec3<f32> {
    var a_4: vec3<f32>;

    let _e5 = axes();
    a_4 = _e5;
    let _e7 = (*v)[0u];
    let _e9 = a_4[0u];
    let _e11 = (*v)[2u];
    let _e15 = (*v)[1u];
    let _e18 = a_4[1u];
    let _e20 = (*v)[2u];
    let _e24 = (*v)[2u];
    return vec3<f32>((_e7 - (_e9 * _e11)), (-(_e15) + (_e18 * _e20)), _e24);
}

fn intersectRockvf3vf3vf3vf3_(eye: ptr<function, vec3<f32>>, ray: ptr<function, vec3<f32>>, p_8: ptr<function, vec3<f32>>, wp: ptr<function, vec3<f32>>) -> bool {
    var localEye: vec3<f32>;
    var param_78: vec3<f32>;
    var dir: vec3<f32>;
    var param_79: vec3<f32>;
    var inv: vec3<f32>;
    var a_5: vec3<f32>;
    var b_4: vec3<f32>;
    var nearT: vec3<f32>;
    var farT: vec3<f32>;
    var t_1: f32;
    var end: f32;
    var hit: bool;
    var i_5: i32;
    var d_2: f32;
    var param_80: vec3<f32>;
    var param_81: vec3<f32>;

    let _e41 = datum;
    let _e45 = (*eye);
    let _e46 = position;
    param_78 = (_e45 - _e46);
    let _e48 = localDirvf3_((&param_78));
    let _e49 = unit;
    localEye = (vec3<f32>(_e41.x, _e41.y, 0f) + (_e48 / vec3(_e49)));
    let _e53 = (*ray);
    param_79 = _e53;
    let _e54 = localDirvf3_((&param_79));
    dir = _e54;
    let _e55 = dir;
    let _e59 = dir;
    inv = (vec3(1f) / (sign((_e55 + vec3(0.000000001f))) * max(abs(_e59), vec3<f32>(0.0000001f, 0.0000001f, 0.0000001f))));
    let _e65 = origin;
    let _e66 = localEye;
    let _e68 = inv;
    a_5 = ((_e65 - _e66) * _e68);
    let _e70 = dims;
    let _e71 = localEye;
    let _e73 = inv;
    b_4 = ((_e70 - _e71) * _e73);
    let _e75 = a_5;
    let _e76 = b_4;
    nearT = min(_e75, _e76);
    let _e78 = a_5;
    let _e79 = b_4;
    farT = max(_e78, _e79);
    let _e82 = nearT[0u];
    let _e84 = nearT[1u];
    let _e86 = nearT[2u];
    t_1 = max(0f, max(_e82, max(_e84, _e86)));
    let _e91 = farT[0u];
    let _e93 = farT[1u];
    let _e95 = farT[2u];
    end = min(_e91, min(_e93, _e95));
    let _e98 = t_1;
    let _e99 = end;
    if (_e98 >= _e99) {
        return false;
    }
    hit = false;
    (*p_8) = vec3<f32>(0f, 0f, 0f);
    i_5 = 0i;
    loop {
        let _e101 = i_5;
        if (_e101 < 155i) {
            let _e103 = localEye;
            let _e104 = dir;
            let _e105 = t_1;
            (*p_8) = (_e103 + (_e104 * _e105));
            let _e108 = (*p_8);
            param_80 = _e108;
            let _e109 = sdvf3_((&param_80));
            d_2 = _e109;
            let _e110 = d_2;
            if (_e110 < 0.14f) {
                hit = true;
                break;
            }
            let _e112 = d_2;
            let _e115 = t_1;
            t_1 = (_e115 + max(0.12f, (_e112 * 0.66f)));
            let _e117 = t_1;
            let _e118 = end;
            if (_e117 > _e118) {
                break;
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e120 = i_5;
            i_5 = (_e120 + 1i);
        }
    }
    let _e122 = hit;
    if !(_e122) {
        return false;
    }
    let _e124 = (*p_8);
    param_81 = _e124;
    let _e125 = worldvf3_((&param_81));
    (*wp) = _e125;
    return true;
}

fn setRocki1_(id_1: ptr<function, i32>) {
    var local_4: vec2<f32>;
    var local_5: vec2<f32>;
    var z_1: f32;
    var local_6: f32;
    var local_7: f32;
    var local_8: vec3<f32>;
    var local_9: vec3<f32>;
    var local_10: vec3<f32>;
    var local_11: vec3<f32>;

    let _e42 = (*id_1);
    object = _e42;
    let _e43 = (*id_1);
    if (_e43 == 0i) {
        local_4 = vec2<f32>(1450f, 235f);
    } else {
        let _e45 = (*id_1);
        if (_e45 == 1i) {
            local_5 = vec2<f32>(1800f, 305f);
        } else {
            let _e47 = (*id_1);
            local_5 = select(vec2<f32>(1840f, 202f), vec2<f32>(1510f, 435f), vec2((_e47 == 2i)));
        }
        let _e51 = local_5;
        local_4 = _e51;
    }
    let _e52 = local_4;
    datum = _e52;
    let _e53 = (*id_1);
    if (_e53 == 0i) {
        local_6 = 970f;
    } else {
        let _e55 = (*id_1);
        if (_e55 == 1i) {
            local_7 = 550f;
        } else {
            let _e57 = (*id_1);
            local_7 = select(1480f, 457f, (_e57 == 2i));
        }
        let _e60 = local_7;
        local_6 = _e60;
    }
    let _e61 = local_6;
    z_1 = _e61;
    let _e62 = z_1;
    unit = (_e62 / 1404f);
    let _e65 = datum[0u];
    let _e69 = datum[1u];
    strike = vec2<f32>(((_e65 - 960f) / 1404f), ((464.4f - _e69) / 1404f));
    let _e74 = strike[0u];
    let _e75 = z_1;
    let _e78 = strike[1u];
    let _e79 = z_1;
    let _e82 = z_1;
    position = vec3<f32>((_e74 * _e75), (70f + (_e78 * _e79)), _e82);
    let _e84 = (*id_1);
    if (_e84 == 0i) {
        local_8 = vec3<f32>(838f, 25f, -340f);
    } else {
        let _e86 = (*id_1);
        if (_e86 == 1i) {
            local_9 = vec3<f32>(1552f, 183f, -138f);
        } else {
            let _e88 = (*id_1);
            local_9 = select(vec3<f32>(1628f, 133f, -111f), vec3<f32>(1380f, 353f, -76f), vec3((_e88 == 2i)));
        }
        let _e92 = local_9;
        local_8 = _e92;
    }
    let _e93 = local_8;
    origin = _e93;
    let _e94 = (*id_1);
    if (_e94 == 0i) {
        local_10 = vec3<f32>(2120f, 650f, 230f);
    } else {
        let _e96 = (*id_1);
        if (_e96 == 1i) {
            local_11 = vec3<f32>(2210f, 618f, 154f);
        } else {
            let _e98 = (*id_1);
            local_11 = select(vec3<f32>(2084f, 372f, 110f), vec3<f32>(1700f, 590f, 82f), vec3((_e98 == 2i)));
        }
        let _e102 = local_11;
        local_10 = _e102;
    }
    let _e103 = local_10;
    dims = _e103;
    return;
}

fn rndi1i1_(x_4: ptr<function, i32>, seed: ptr<function, i32>) -> f32 {
    var h_2: u32;

    let _e10 = (*x_4);
    let _e13 = (*seed);
    h_2 = (((bitcast<u32>(_e10) * 747796405u) + (bitcast<u32>(_e13) * 2891336453u)) + 277803737u);
    let _e18 = h_2;
    let _e19 = h_2;
    let _e25 = h_2;
    h_2 = (((_e18 >> bitcast<u32>(((_e19 >> bitcast<u32>(28u)) + 4u))) ^ _e25) * 277803737u);
    let _e28 = h_2;
    let _e31 = h_2;
    return (f32(((_e28 >> bitcast<u32>(22u)) ^ _e31)) / 4294967300f);
}

fn valueNoise2vf2_(p_9: ptr<function, vec2<f32>>) -> f32 {
    var i_6: vec2<i32>;
    var f_2: vec2<f32>;
    var param_82: i32;
    var param_83: i32;
    var param_84: i32;
    var param_85: i32;
    var param_86: i32;
    var param_87: i32;
    var param_88: i32;
    var param_89: i32;

    let _e16 = (*p_9);
    i_6 = vec2<i32>(floor(_e16));
    let _e19 = (*p_9);
    f_2 = fract(_e19);
    let _e21 = f_2;
    let _e22 = f_2;
    let _e24 = f_2;
    f_2 = ((_e21 * _e22) * (vec2(3f) - (_e24 * 2f)));
    let _e30 = i_6[0u];
    param_82 = _e30;
    let _e32 = i_6[1u];
    param_83 = _e32;
    let _e33 = rndi1i1_((&param_82), (&param_83));
    let _e35 = i_6[0u];
    param_84 = (_e35 + 1i);
    let _e38 = i_6[1u];
    param_85 = _e38;
    let _e39 = rndi1i1_((&param_84), (&param_85));
    let _e41 = f_2[0u];
    let _e44 = i_6[1u];
    let _e47 = i_6[0u];
    param_86 = _e47;
    param_87 = (_e44 + 1i);
    let _e48 = rndi1i1_((&param_86), (&param_87));
    let _e50 = i_6[0u];
    let _e53 = i_6[1u];
    param_88 = (_e50 + 1i);
    param_89 = (_e53 + 1i);
    let _e55 = rndi1i1_((&param_88), (&param_89));
    let _e57 = f_2[0u];
    let _e60 = f_2[1u];
    return mix(mix(_e33, _e39, _e41), mix(_e48, _e55, _e57), _e60);
}

fn rightShoref1_(x_5: ptr<function, f32>) -> f32 {
    var y_1: f32;
    var i_7: i32;
    var indexable_5: array<vec2<f32>, 12>;
    var indexable_6: array<vec2<f32>, 12>;
    var indexable_7: array<vec2<f32>, 12>;
    var indexable_8: array<vec2<f32>, 12>;

    y_1 = 148.44524f;
    i_7 = 1i;
    loop {
        let _e15 = i_7;
        if (_e15 < 12i) {
            let _e17 = y_1;
            let _e18 = i_7;
            indexable_5 = array<vec2<f32>, 12>(vec2<f32>(129.72823f, 148.44524f), vec2<f32>(159.51025f, 160.70062f), vec2<f32>(182.23618f, 169.99644f), vec2<f32>(209.35162f, 177.06357f), vec2<f32>(235.64879f, 175.8573f), vec2<f32>(266.94492f, 169.33073f), vec2<f32>(293.38477f, 160.19392f), vec2<f32>(320.0819f, 123.01655f), vec2<f32>(347.77234f, 127.17049f), vec2<f32>(383.3004f, 92.96465f), vec2<f32>(414.34146f, 68.54156f), vec2<f32>(436.85477f, 47.2716f));
            let _e21 = indexable_5[_e18][1u];
            let _e22 = (*x_5);
            let _e23 = i_7;
            indexable_6 = array<vec2<f32>, 12>(vec2<f32>(129.72823f, 148.44524f), vec2<f32>(159.51025f, 160.70062f), vec2<f32>(182.23618f, 169.99644f), vec2<f32>(209.35162f, 177.06357f), vec2<f32>(235.64879f, 175.8573f), vec2<f32>(266.94492f, 169.33073f), vec2<f32>(293.38477f, 160.19392f), vec2<f32>(320.0819f, 123.01655f), vec2<f32>(347.77234f, 127.17049f), vec2<f32>(383.3004f, 92.96465f), vec2<f32>(414.34146f, 68.54156f), vec2<f32>(436.85477f, 47.2716f));
            let _e27 = indexable_6[(_e23 - 1i)][0u];
            let _e29 = i_7;
            indexable_7 = array<vec2<f32>, 12>(vec2<f32>(129.72823f, 148.44524f), vec2<f32>(159.51025f, 160.70062f), vec2<f32>(182.23618f, 169.99644f), vec2<f32>(209.35162f, 177.06357f), vec2<f32>(235.64879f, 175.8573f), vec2<f32>(266.94492f, 169.33073f), vec2<f32>(293.38477f, 160.19392f), vec2<f32>(320.0819f, 123.01655f), vec2<f32>(347.77234f, 127.17049f), vec2<f32>(383.3004f, 92.96465f), vec2<f32>(414.34146f, 68.54156f), vec2<f32>(436.85477f, 47.2716f));
            let _e32 = indexable_7[_e29][0u];
            let _e33 = i_7;
            indexable_8 = array<vec2<f32>, 12>(vec2<f32>(129.72823f, 148.44524f), vec2<f32>(159.51025f, 160.70062f), vec2<f32>(182.23618f, 169.99644f), vec2<f32>(209.35162f, 177.06357f), vec2<f32>(235.64879f, 175.8573f), vec2<f32>(266.94492f, 169.33073f), vec2<f32>(293.38477f, 160.19392f), vec2<f32>(320.0819f, 123.01655f), vec2<f32>(347.77234f, 127.17049f), vec2<f32>(383.3004f, 92.96465f), vec2<f32>(414.34146f, 68.54156f), vec2<f32>(436.85477f, 47.2716f));
            let _e37 = indexable_8[(_e33 - 1i)][0u];
            y_1 = mix(_e17, _e21, clamp(((_e22 - _e27) / (_e32 - _e37)), 0f, 1f));
            continue;
        } else {
            break;
        }
        continuing {
            let _e42 = i_7;
            i_7 = (_e42 + 1i);
        }
    }
    let _e44 = y_1;
    return _e44;
}

fn bellf1_(x_6: ptr<function, f32>) -> f32 {
    let _e1 = (*x_6);
    let _e3 = (*x_6);
    return exp((-(_e1) * _e3));
}

fn leftShoref1_(x_7: ptr<function, f32>) -> f32 {
    var y_2: f32;
    var i_8: i32;
    var indexable_9: array<vec2<f32>, 12>;
    var indexable_10: array<vec2<f32>, 12>;
    var indexable_11: array<vec2<f32>, 12>;
    var indexable_12: array<vec2<f32>, 12>;

    y_2 = 48.40606f;
    i_8 = 1i;
    loop {
        let _e15 = i_8;
        if (_e15 < 12i) {
            let _e17 = y_2;
            let _e18 = i_8;
            indexable_9 = array<vec2<f32>, 12>(vec2<f32>(129.72823f, 48.40606f), vec2<f32>(159.51025f, 40.67114f), vec2<f32>(182.23618f, 36.49257f), vec2<f32>(209.35162f, 33.85039f), vec2<f32>(235.64879f, 23.74074f), vec2<f32>(266.94492f, 11.95276f), vec2<f32>(293.38477f, 1.09472f), vec2<f32>(320.0819f, -3.58301f), vec2<f32>(347.77234f, 1.29766f), vec2<f32>(383.3004f, 10.01158f), vec2<f32>(414.34146f, 24.7368f), vec2<f32>(436.85477f, 36.94792f));
            let _e21 = indexable_9[_e18][1u];
            let _e22 = (*x_7);
            let _e23 = i_8;
            indexable_10 = array<vec2<f32>, 12>(vec2<f32>(129.72823f, 48.40606f), vec2<f32>(159.51025f, 40.67114f), vec2<f32>(182.23618f, 36.49257f), vec2<f32>(209.35162f, 33.85039f), vec2<f32>(235.64879f, 23.74074f), vec2<f32>(266.94492f, 11.95276f), vec2<f32>(293.38477f, 1.09472f), vec2<f32>(320.0819f, -3.58301f), vec2<f32>(347.77234f, 1.29766f), vec2<f32>(383.3004f, 10.01158f), vec2<f32>(414.34146f, 24.7368f), vec2<f32>(436.85477f, 36.94792f));
            let _e27 = indexable_10[(_e23 - 1i)][0u];
            let _e29 = i_8;
            indexable_11 = array<vec2<f32>, 12>(vec2<f32>(129.72823f, 48.40606f), vec2<f32>(159.51025f, 40.67114f), vec2<f32>(182.23618f, 36.49257f), vec2<f32>(209.35162f, 33.85039f), vec2<f32>(235.64879f, 23.74074f), vec2<f32>(266.94492f, 11.95276f), vec2<f32>(293.38477f, 1.09472f), vec2<f32>(320.0819f, -3.58301f), vec2<f32>(347.77234f, 1.29766f), vec2<f32>(383.3004f, 10.01158f), vec2<f32>(414.34146f, 24.7368f), vec2<f32>(436.85477f, 36.94792f));
            let _e32 = indexable_11[_e29][0u];
            let _e33 = i_8;
            indexable_12 = array<vec2<f32>, 12>(vec2<f32>(129.72823f, 48.40606f), vec2<f32>(159.51025f, 40.67114f), vec2<f32>(182.23618f, 36.49257f), vec2<f32>(209.35162f, 33.85039f), vec2<f32>(235.64879f, 23.74074f), vec2<f32>(266.94492f, 11.95276f), vec2<f32>(293.38477f, 1.09472f), vec2<f32>(320.0819f, -3.58301f), vec2<f32>(347.77234f, 1.29766f), vec2<f32>(383.3004f, 10.01158f), vec2<f32>(414.34146f, 24.7368f), vec2<f32>(436.85477f, 36.94792f));
            let _e37 = indexable_12[(_e33 - 1i)][0u];
            y_2 = mix(_e17, _e21, clamp(((_e22 - _e27) / (_e32 - _e37)), 0f, 1f));
            continue;
        } else {
            break;
        }
        continuing {
            let _e42 = i_8;
            i_8 = (_e42 + 1i);
        }
    }
    let _e44 = y_2;
    return _e44;
}

fn ridge5f1_(x_8: ptr<function, f32>) -> f32 {
    var y_3: f32;
    var i_9: i32;
    var indexable_13: array<vec2<f32>, 6>;
    var indexable_14: array<vec2<f32>, 6>;
    var indexable_15: array<vec2<f32>, 6>;
    var indexable_16: array<vec2<f32>, 6>;

    y_3 = 218f;
    i_9 = 1i;
    loop {
        let _e15 = i_9;
        if (_e15 < 6i) {
            let _e17 = y_3;
            let _e18 = i_9;
            indexable_13 = array<vec2<f32>, 6>(vec2<f32>(0f, 218f), vec2<f32>(214f, 245f), vec2<f32>(385f, 292f), vec2<f32>(499f, 308f), vec2<f32>(649f, 268f), vec2<f32>(1100f, 194f));
            let _e21 = indexable_13[_e18][1u];
            let _e22 = (*x_8);
            let _e23 = i_9;
            indexable_14 = array<vec2<f32>, 6>(vec2<f32>(0f, 218f), vec2<f32>(214f, 245f), vec2<f32>(385f, 292f), vec2<f32>(499f, 308f), vec2<f32>(649f, 268f), vec2<f32>(1100f, 194f));
            let _e27 = indexable_14[(_e23 - 1i)][0u];
            let _e29 = i_9;
            indexable_15 = array<vec2<f32>, 6>(vec2<f32>(0f, 218f), vec2<f32>(214f, 245f), vec2<f32>(385f, 292f), vec2<f32>(499f, 308f), vec2<f32>(649f, 268f), vec2<f32>(1100f, 194f));
            let _e32 = indexable_15[_e29][0u];
            let _e33 = i_9;
            indexable_16 = array<vec2<f32>, 6>(vec2<f32>(0f, 218f), vec2<f32>(214f, 245f), vec2<f32>(385f, 292f), vec2<f32>(499f, 308f), vec2<f32>(649f, 268f), vec2<f32>(1100f, 194f));
            let _e37 = indexable_16[(_e33 - 1i)][0u];
            y_3 = mix(_e17, _e21, clamp(((_e22 - _e27) / (_e32 - _e37)), 0f, 1f));
            continue;
        } else {
            break;
        }
        continuing {
            let _e42 = i_9;
            i_9 = (_e42 + 1i);
        }
    }
    let _e44 = y_3;
    return _e44;
}

fn ridge4f1_(x_9: ptr<function, f32>) -> f32 {
    var y_4: f32;
    var i_10: i32;
    var indexable_17: array<vec2<f32>, 6>;
    var indexable_18: array<vec2<f32>, 6>;
    var indexable_19: array<vec2<f32>, 6>;
    var indexable_20: array<vec2<f32>, 6>;

    y_4 = 204f;
    i_10 = 1i;
    loop {
        let _e15 = i_10;
        if (_e15 < 6i) {
            let _e17 = y_4;
            let _e18 = i_10;
            indexable_17 = array<vec2<f32>, 6>(vec2<f32>(0f, 204f), vec2<f32>(242f, 217f), vec2<f32>(411f, 262f), vec2<f32>(516f, 250f), vec2<f32>(654f, 233f), vec2<f32>(1100f, 167f));
            let _e21 = indexable_17[_e18][1u];
            let _e22 = (*x_9);
            let _e23 = i_10;
            indexable_18 = array<vec2<f32>, 6>(vec2<f32>(0f, 204f), vec2<f32>(242f, 217f), vec2<f32>(411f, 262f), vec2<f32>(516f, 250f), vec2<f32>(654f, 233f), vec2<f32>(1100f, 167f));
            let _e27 = indexable_18[(_e23 - 1i)][0u];
            let _e29 = i_10;
            indexable_19 = array<vec2<f32>, 6>(vec2<f32>(0f, 204f), vec2<f32>(242f, 217f), vec2<f32>(411f, 262f), vec2<f32>(516f, 250f), vec2<f32>(654f, 233f), vec2<f32>(1100f, 167f));
            let _e32 = indexable_19[_e29][0u];
            let _e33 = i_10;
            indexable_20 = array<vec2<f32>, 6>(vec2<f32>(0f, 204f), vec2<f32>(242f, 217f), vec2<f32>(411f, 262f), vec2<f32>(516f, 250f), vec2<f32>(654f, 233f), vec2<f32>(1100f, 167f));
            let _e37 = indexable_20[(_e33 - 1i)][0u];
            y_4 = mix(_e17, _e21, clamp(((_e22 - _e27) / (_e32 - _e37)), 0f, 1f));
            continue;
        } else {
            break;
        }
        continuing {
            let _e42 = i_10;
            i_10 = (_e42 + 1i);
        }
    }
    let _e44 = y_4;
    return _e44;
}

fn ridge3f1_(x_10: ptr<function, f32>) -> f32 {
    var y_5: f32;
    var i_11: i32;
    var indexable_21: array<vec2<f32>, 14>;
    var indexable_22: array<vec2<f32>, 14>;
    var indexable_23: array<vec2<f32>, 14>;
    var indexable_24: array<vec2<f32>, 14>;

    y_5 = 236f;
    i_11 = 1i;
    loop {
        let _e15 = i_11;
        if (_e15 < 14i) {
            let _e17 = y_5;
            let _e18 = i_11;
            indexable_21 = array<vec2<f32>, 14>(vec2<f32>(0f, 236f), vec2<f32>(105f, 260f), vec2<f32>(231f, 284f), vec2<f32>(327f, 308f), vec2<f32>(432f, 342f), vec2<f32>(504f, 361f), vec2<f32>(577f, 384f), vec2<f32>(622f, 397f), vec2<f32>(676f, 365f), vec2<f32>(773f, 331f), vec2<f32>(865f, 307f), vec2<f32>(954f, 276f), vec2<f32>(1023f, 257f), vec2<f32>(1100f, 235f));
            let _e21 = indexable_21[_e18][1u];
            let _e22 = (*x_10);
            let _e23 = i_11;
            indexable_22 = array<vec2<f32>, 14>(vec2<f32>(0f, 236f), vec2<f32>(105f, 260f), vec2<f32>(231f, 284f), vec2<f32>(327f, 308f), vec2<f32>(432f, 342f), vec2<f32>(504f, 361f), vec2<f32>(577f, 384f), vec2<f32>(622f, 397f), vec2<f32>(676f, 365f), vec2<f32>(773f, 331f), vec2<f32>(865f, 307f), vec2<f32>(954f, 276f), vec2<f32>(1023f, 257f), vec2<f32>(1100f, 235f));
            let _e27 = indexable_22[(_e23 - 1i)][0u];
            let _e29 = i_11;
            indexable_23 = array<vec2<f32>, 14>(vec2<f32>(0f, 236f), vec2<f32>(105f, 260f), vec2<f32>(231f, 284f), vec2<f32>(327f, 308f), vec2<f32>(432f, 342f), vec2<f32>(504f, 361f), vec2<f32>(577f, 384f), vec2<f32>(622f, 397f), vec2<f32>(676f, 365f), vec2<f32>(773f, 331f), vec2<f32>(865f, 307f), vec2<f32>(954f, 276f), vec2<f32>(1023f, 257f), vec2<f32>(1100f, 235f));
            let _e32 = indexable_23[_e29][0u];
            let _e33 = i_11;
            indexable_24 = array<vec2<f32>, 14>(vec2<f32>(0f, 236f), vec2<f32>(105f, 260f), vec2<f32>(231f, 284f), vec2<f32>(327f, 308f), vec2<f32>(432f, 342f), vec2<f32>(504f, 361f), vec2<f32>(577f, 384f), vec2<f32>(622f, 397f), vec2<f32>(676f, 365f), vec2<f32>(773f, 331f), vec2<f32>(865f, 307f), vec2<f32>(954f, 276f), vec2<f32>(1023f, 257f), vec2<f32>(1100f, 235f));
            let _e37 = indexable_24[(_e33 - 1i)][0u];
            y_5 = mix(_e17, _e21, clamp(((_e22 - _e27) / (_e32 - _e37)), 0f, 1f));
            continue;
        } else {
            break;
        }
        continuing {
            let _e42 = i_11;
            i_11 = (_e42 + 1i);
        }
    }
    let _e44 = y_5;
    return _e44;
}

fn ridge2f1_(x_11: ptr<function, f32>) -> f32 {
    var y_6: f32;
    var i_12: i32;
    var indexable_25: array<vec2<f32>, 13>;
    var indexable_26: array<vec2<f32>, 13>;
    var indexable_27: array<vec2<f32>, 13>;
    var indexable_28: array<vec2<f32>, 13>;

    y_6 = 202f;
    i_12 = 1i;
    loop {
        let _e15 = i_12;
        if (_e15 < 13i) {
            let _e17 = y_6;
            let _e18 = i_12;
            indexable_25 = array<vec2<f32>, 13>(vec2<f32>(0f, 202f), vec2<f32>(121f, 213f), vec2<f32>(232f, 228f), vec2<f32>(312f, 250f), vec2<f32>(425f, 298f), vec2<f32>(525f, 282f), vec2<f32>(631f, 253f), vec2<f32>(710f, 247f), vec2<f32>(818f, 215f), vec2<f32>(899f, 211f), vec2<f32>(982f, 166f), vec2<f32>(1045f, 140f), vec2<f32>(1100f, 121f));
            let _e21 = indexable_25[_e18][1u];
            let _e22 = (*x_11);
            let _e23 = i_12;
            indexable_26 = array<vec2<f32>, 13>(vec2<f32>(0f, 202f), vec2<f32>(121f, 213f), vec2<f32>(232f, 228f), vec2<f32>(312f, 250f), vec2<f32>(425f, 298f), vec2<f32>(525f, 282f), vec2<f32>(631f, 253f), vec2<f32>(710f, 247f), vec2<f32>(818f, 215f), vec2<f32>(899f, 211f), vec2<f32>(982f, 166f), vec2<f32>(1045f, 140f), vec2<f32>(1100f, 121f));
            let _e27 = indexable_26[(_e23 - 1i)][0u];
            let _e29 = i_12;
            indexable_27 = array<vec2<f32>, 13>(vec2<f32>(0f, 202f), vec2<f32>(121f, 213f), vec2<f32>(232f, 228f), vec2<f32>(312f, 250f), vec2<f32>(425f, 298f), vec2<f32>(525f, 282f), vec2<f32>(631f, 253f), vec2<f32>(710f, 247f), vec2<f32>(818f, 215f), vec2<f32>(899f, 211f), vec2<f32>(982f, 166f), vec2<f32>(1045f, 140f), vec2<f32>(1100f, 121f));
            let _e32 = indexable_27[_e29][0u];
            let _e33 = i_12;
            indexable_28 = array<vec2<f32>, 13>(vec2<f32>(0f, 202f), vec2<f32>(121f, 213f), vec2<f32>(232f, 228f), vec2<f32>(312f, 250f), vec2<f32>(425f, 298f), vec2<f32>(525f, 282f), vec2<f32>(631f, 253f), vec2<f32>(710f, 247f), vec2<f32>(818f, 215f), vec2<f32>(899f, 211f), vec2<f32>(982f, 166f), vec2<f32>(1045f, 140f), vec2<f32>(1100f, 121f));
            let _e37 = indexable_28[(_e33 - 1i)][0u];
            y_6 = mix(_e17, _e21, clamp(((_e22 - _e27) / (_e32 - _e37)), 0f, 1f));
            continue;
        } else {
            break;
        }
        continuing {
            let _e42 = i_12;
            i_12 = (_e42 + 1i);
        }
    }
    let _e44 = y_6;
    return _e44;
}

fn ridge1f1_(x_12: ptr<function, f32>) -> f32 {
    var y_7: f32;
    var i_13: i32;
    var indexable_29: array<vec2<f32>, 15>;
    var indexable_30: array<vec2<f32>, 15>;
    var indexable_31: array<vec2<f32>, 15>;
    var indexable_32: array<vec2<f32>, 15>;

    y_7 = 185f;
    i_13 = 1i;
    loop {
        let _e15 = i_13;
        if (_e15 < 15i) {
            let _e17 = y_7;
            let _e18 = i_13;
            indexable_29 = array<vec2<f32>, 15>(vec2<f32>(0f, 185f), vec2<f32>(185f, 195f), vec2<f32>(247f, 187f), vec2<f32>(301f, 196f), vec2<f32>(369f, 220f), vec2<f32>(414f, 232f), vec2<f32>(479f, 202f), vec2<f32>(510f, 214f), vec2<f32>(554f, 188f), vec2<f32>(605f, 205f), vec2<f32>(760f, 124f), vec2<f32>(988f, 110f), vec2<f32>(1016f, 96f), vec2<f32>(1047f, 113f), vec2<f32>(1100f, 108f));
            let _e21 = indexable_29[_e18][1u];
            let _e22 = (*x_12);
            let _e23 = i_13;
            indexable_30 = array<vec2<f32>, 15>(vec2<f32>(0f, 185f), vec2<f32>(185f, 195f), vec2<f32>(247f, 187f), vec2<f32>(301f, 196f), vec2<f32>(369f, 220f), vec2<f32>(414f, 232f), vec2<f32>(479f, 202f), vec2<f32>(510f, 214f), vec2<f32>(554f, 188f), vec2<f32>(605f, 205f), vec2<f32>(760f, 124f), vec2<f32>(988f, 110f), vec2<f32>(1016f, 96f), vec2<f32>(1047f, 113f), vec2<f32>(1100f, 108f));
            let _e27 = indexable_30[(_e23 - 1i)][0u];
            let _e29 = i_13;
            indexable_31 = array<vec2<f32>, 15>(vec2<f32>(0f, 185f), vec2<f32>(185f, 195f), vec2<f32>(247f, 187f), vec2<f32>(301f, 196f), vec2<f32>(369f, 220f), vec2<f32>(414f, 232f), vec2<f32>(479f, 202f), vec2<f32>(510f, 214f), vec2<f32>(554f, 188f), vec2<f32>(605f, 205f), vec2<f32>(760f, 124f), vec2<f32>(988f, 110f), vec2<f32>(1016f, 96f), vec2<f32>(1047f, 113f), vec2<f32>(1100f, 108f));
            let _e32 = indexable_31[_e29][0u];
            let _e33 = i_13;
            indexable_32 = array<vec2<f32>, 15>(vec2<f32>(0f, 185f), vec2<f32>(185f, 195f), vec2<f32>(247f, 187f), vec2<f32>(301f, 196f), vec2<f32>(369f, 220f), vec2<f32>(414f, 232f), vec2<f32>(479f, 202f), vec2<f32>(510f, 214f), vec2<f32>(554f, 188f), vec2<f32>(605f, 205f), vec2<f32>(760f, 124f), vec2<f32>(988f, 110f), vec2<f32>(1016f, 96f), vec2<f32>(1047f, 113f), vec2<f32>(1100f, 108f));
            let _e37 = indexable_32[(_e33 - 1i)][0u];
            y_7 = mix(_e17, _e21, clamp(((_e22 - _e27) / (_e32 - _e37)), 0f, 1f));
            continue;
        } else {
            break;
        }
        continuing {
            let _e42 = i_13;
            i_13 = (_e42 + 1i);
        }
    }
    let _e44 = y_7;
    return _e44;
}

fn ridgevf2f1f1f1f1f1f1_(q_4: ptr<function, vec2<f32>>, u: ptr<function, f32>, line: ptr<function, f32>, crest_1: ptr<function, f32>, front_1: ptr<function, f32>, back: ptr<function, f32>, flutes: ptr<function, f32>) -> f32 {
    var dz: f32;
    var r_2: f32;
    var f_3: f32;
    var param_90: vec2<f32>;
    var param_91: vec2<f32>;
    var cut: f32;
    var param_92: vec2<f32>;
    var param_93: vec2<f32>;

    let _e45 = (*q_4)[1u];
    let _e46 = (*crest_1);
    let _e49 = (*q_4)[0u];
    let _e55 = (*q_4)[0u];
    dz = (((_e45 - _e46) - (55f * sin((_e49 * 0.013f)))) - (28f * sin((_e55 * 0.03f))));
    let _e60 = dz;
    r_2 = max(0f, -(_e60));
    let _e63 = (*u);
    let _e65 = r_2;
    let _e68 = (*u);
    let _e70 = r_2;
    param_90 = vec2<f32>((_e68 * 0.021f), (_e70 * 0.009f));
    let _e73 = valueNoise2vf2_((&param_90));
    let _e76 = (*u);
    let _e78 = r_2;
    param_91 = vec2<f32>((_e76 * 0.086f), (_e78 * 0.009f));
    let _e81 = valueNoise2vf2_((&param_91));
    f_3 = fract((((((_e63 * 0.05f) + (_e65 * 0.031f)) + (1.42f * _e73)) + (0.36f * _e81)) / 3.14159f));
    let _e86 = f_3;
    let _e89 = f_3;
    let _e93 = (*u);
    let _e95 = r_2;
    param_92 = vec2<f32>((_e93 * 0.014f), (_e95 * 0.006f));
    let _e98 = valueNoise2vf2_((&param_92));
    cut = (max((1f - (_e86 / 0.27f)), ((_e89 - 0.27f) / 0.73f)) * (0.56f + (0.65f * _e98)));
    let _e102 = (*line);
    let _e105 = (*q_4)[1u];
    let _e109 = dz;
    let _e111 = dz;
    let _e113 = (*front_1);
    let _e114 = (*back);
    let _e118 = cut;
    let _e120 = (*q_4);
    param_93 = (_e120 * 0.09f);
    let _e122 = valueNoise2vf2_((&param_93));
    let _e125 = (*flutes);
    let _e127 = dz;
    return (((70f + (((266.17f - _e102) * _e105) / 804f)) - (abs(_e109) * select(_e114, _e113, (_e111 < 0f)))) - ((((_e118 * 0.94f) + (0.1f * _e122)) * _e125) * min(1f, (abs(_e127) / 48f))));
}

fn ridge0f1_(x_13: ptr<function, f32>) -> f32 {
    var y_8: f32;
    var i_14: i32;
    var indexable_33: array<vec2<f32>, 10>;
    var indexable_34: array<vec2<f32>, 10>;
    var indexable_35: array<vec2<f32>, 10>;
    var indexable_36: array<vec2<f32>, 10>;

    y_8 = 182f;
    i_14 = 1i;
    loop {
        let _e15 = i_14;
        if (_e15 < 10i) {
            let _e17 = y_8;
            let _e18 = i_14;
            indexable_33 = array<vec2<f32>, 10>(vec2<f32>(0f, 182f), vec2<f32>(95f, 198f), vec2<f32>(183f, 225f), vec2<f32>(287f, 258f), vec2<f32>(356f, 282f), vec2<f32>(451f, 324f), vec2<f32>(520f, 355f), vec2<f32>(591f, 397f), vec2<f32>(700f, 464f), vec2<f32>(1100f, 526f));
            let _e21 = indexable_33[_e18][1u];
            let _e22 = (*x_13);
            let _e23 = i_14;
            indexable_34 = array<vec2<f32>, 10>(vec2<f32>(0f, 182f), vec2<f32>(95f, 198f), vec2<f32>(183f, 225f), vec2<f32>(287f, 258f), vec2<f32>(356f, 282f), vec2<f32>(451f, 324f), vec2<f32>(520f, 355f), vec2<f32>(591f, 397f), vec2<f32>(700f, 464f), vec2<f32>(1100f, 526f));
            let _e27 = indexable_34[(_e23 - 1i)][0u];
            let _e29 = i_14;
            indexable_35 = array<vec2<f32>, 10>(vec2<f32>(0f, 182f), vec2<f32>(95f, 198f), vec2<f32>(183f, 225f), vec2<f32>(287f, 258f), vec2<f32>(356f, 282f), vec2<f32>(451f, 324f), vec2<f32>(520f, 355f), vec2<f32>(591f, 397f), vec2<f32>(700f, 464f), vec2<f32>(1100f, 526f));
            let _e32 = indexable_35[_e29][0u];
            let _e33 = i_14;
            indexable_36 = array<vec2<f32>, 10>(vec2<f32>(0f, 182f), vec2<f32>(95f, 198f), vec2<f32>(183f, 225f), vec2<f32>(287f, 258f), vec2<f32>(356f, 282f), vec2<f32>(451f, 324f), vec2<f32>(520f, 355f), vec2<f32>(591f, 397f), vec2<f32>(700f, 464f), vec2<f32>(1100f, 526f));
            let _e37 = indexable_36[(_e33 - 1i)][0u];
            y_8 = mix(_e17, _e21, clamp(((_e22 - _e27) / (_e32 - _e37)), 0f, 1f));
            continue;
        } else {
            break;
        }
        continuing {
            let _e42 = i_14;
            i_14 = (_e42 + 1i);
        }
    }
    let _e44 = y_8;
    return _e44;
}

fn landvf2_(q_5: ptr<function, vec2<f32>>) -> f32 {
    var x_14: f32;
    var z_2: f32;
    var u_1: f32;
    var h_3: f32;
    var param_94: f32;
    var param_95: vec2<f32>;
    var param_96: f32;
    var param_97: f32;
    var param_98: f32;
    var param_99: f32;
    var param_100: f32;
    var param_101: f32;
    var param_102: f32;
    var param_103: vec2<f32>;
    var param_104: f32;
    var param_105: f32;
    var param_106: f32;
    var param_107: f32;
    var param_108: f32;
    var param_109: f32;
    var param_110: f32;
    var param_111: vec2<f32>;
    var param_112: f32;
    var param_113: f32;
    var param_114: f32;
    var param_115: f32;
    var param_116: f32;
    var param_117: f32;
    var param_118: f32;
    var param_119: vec2<f32>;
    var param_120: f32;
    var param_121: f32;
    var param_122: f32;
    var param_123: f32;
    var param_124: f32;
    var param_125: f32;
    var param_126: f32;
    var param_127: vec2<f32>;
    var param_128: f32;
    var param_129: f32;
    var param_130: f32;
    var param_131: f32;
    var param_132: f32;
    var param_133: f32;
    var param_134: f32;
    var param_135: vec2<f32>;
    var param_136: f32;
    var param_137: f32;
    var param_138: f32;
    var param_139: f32;
    var param_140: f32;
    var param_141: f32;
    var l: f32;
    var param_142: f32;
    var param_143: f32;
    var param_144: f32;
    var r_3: f32;
    var param_145: f32;
    var param_146: f32;
    var param_147: f32;
    var param_148: f32;
    var param_149: vec2<f32>;
    var shelf: vec2<f32>;
    var woods: f32;
    var param_150: vec2<f32>;
    var param_151: vec2<f32>;
    var param_152: vec2<f32>;
    var tongue: vec2<f32>;
    var w_2: f32;
    var blocks: f32;
    var param_153: vec2<f32>;
    var param_154: vec2<f32>;
    var lv: f32;

    let _e152 = (*q_5)[0u];
    x_14 = _e152;
    let _e154 = (*q_5)[1u];
    z_2 = _e154;
    let _e155 = x_14;
    let _e157 = z_2;
    u_1 = (550f + ((804f * _e155) / max(_e157, 2f)));
    h_3 = -1000f;
    let _e161 = h_3;
    let _e162 = u_1;
    param_94 = _e162;
    let _e163 = ridge0f1_((&param_94));
    let _e164 = (*q_5);
    param_95 = _e164;
    let _e165 = u_1;
    param_96 = _e165;
    param_97 = _e163;
    param_98 = 302f;
    param_99 = 0.78f;
    param_100 = 0.5f;
    param_101 = 8f;
    let _e166 = ridgevf2f1f1f1f1f1f1_((&param_95), (&param_96), (&param_97), (&param_98), (&param_99), (&param_100), (&param_101));
    h_3 = max(_e161, _e166);
    let _e168 = h_3;
    let _e169 = u_1;
    param_102 = _e169;
    let _e170 = ridge1f1_((&param_102));
    let _e171 = (*q_5);
    param_103 = _e171;
    let _e172 = u_1;
    param_104 = _e172;
    param_105 = _e170;
    param_106 = 1420f;
    param_107 = 0.47f;
    param_108 = 0.8f;
    param_109 = 4f;
    let _e173 = ridgevf2f1f1f1f1f1f1_((&param_103), (&param_104), (&param_105), (&param_106), (&param_107), (&param_108), (&param_109));
    h_3 = max(_e168, _e173);
    let _e175 = h_3;
    let _e176 = u_1;
    param_110 = _e176;
    let _e177 = ridge2f1_((&param_110));
    let _e178 = (*q_5);
    param_111 = _e178;
    let _e179 = u_1;
    param_112 = _e179;
    param_113 = _e177;
    param_114 = 685f;
    param_115 = 0.56f;
    param_116 = 0.6f;
    param_117 = 7f;
    let _e180 = ridgevf2f1f1f1f1f1f1_((&param_111), (&param_112), (&param_113), (&param_114), (&param_115), (&param_116), (&param_117));
    h_3 = max(_e175, _e180);
    let _e182 = h_3;
    let _e183 = u_1;
    param_118 = _e183;
    let _e184 = ridge3f1_((&param_118));
    let _e185 = (*q_5);
    param_119 = _e185;
    let _e186 = u_1;
    param_120 = _e186;
    param_121 = _e184;
    param_122 = 435f;
    param_123 = 0.53f;
    param_124 = 0.48f;
    param_125 = 6f;
    let _e187 = ridgevf2f1f1f1f1f1f1_((&param_119), (&param_120), (&param_121), (&param_122), (&param_123), (&param_124), (&param_125));
    h_3 = max(_e182, _e187);
    let _e189 = h_3;
    let _e190 = u_1;
    param_126 = _e190;
    let _e191 = ridge4f1_((&param_126));
    let _e192 = (*q_5);
    param_127 = _e192;
    let _e193 = u_1;
    param_128 = _e193;
    param_129 = _e191;
    param_130 = 1035f;
    param_131 = 0.44f;
    param_132 = 0.58f;
    param_133 = 4f;
    let _e194 = ridgevf2f1f1f1f1f1f1_((&param_127), (&param_128), (&param_129), (&param_130), (&param_131), (&param_132), (&param_133));
    h_3 = max(_e189, _e194);
    let _e196 = h_3;
    let _e197 = u_1;
    param_134 = _e197;
    let _e198 = ridge5f1_((&param_134));
    let _e199 = (*q_5);
    param_135 = _e199;
    let _e200 = u_1;
    param_136 = _e200;
    param_137 = _e198;
    param_138 = 810f;
    param_139 = 0.45f;
    param_140 = 0.53f;
    param_141 = 3f;
    let _e201 = ridgevf2f1f1f1f1f1f1_((&param_135), (&param_136), (&param_137), (&param_138), (&param_139), (&param_140), (&param_141));
    h_3 = max(_e196, _e201);
    let _e203 = z_2;
    param_142 = _e203;
    let _e204 = leftShoref1_((&param_142));
    let _e205 = z_2;
    param_143 = ((_e205 - 190f) / 43f);
    let _e208 = bellf1_((&param_143));
    let _e211 = z_2;
    param_144 = ((_e211 - 422f) / 24f);
    let _e214 = bellf1_((&param_144));
    l = ((_e204 - (14f * _e208)) + (32f * _e214));
    let _e217 = z_2;
    param_145 = _e217;
    let _e218 = rightShoref1_((&param_145));
    let _e219 = z_2;
    param_146 = ((_e219 - 206f) / 64f);
    let _e222 = bellf1_((&param_146));
    let _e225 = z_2;
    param_147 = ((_e225 - 321f) / 21f);
    let _e228 = bellf1_((&param_147));
    let _e231 = z_2;
    param_148 = ((_e231 - 225f) / 42f);
    let _e234 = bellf1_((&param_148));
    r_3 = (((_e218 + (28f * _e222)) - (14f * _e228)) + (20f * _e234));
    let _e237 = h_3;
    let _e238 = l;
    let _e239 = x_14;
    let _e241 = x_14;
    let _e242 = r_3;
    let _e247 = (*q_5);
    param_149 = (_e247 * 0.047f);
    let _e249 = valueNoise2vf2_((&param_149));
    h_3 = max(_e237, (clamp((0.48f * max((_e238 - _e239), (_e241 - _e242))), -10f, 46f) + (2.6f * (_e249 - 0.5f))));
    let _e254 = (*q_5);
    shelf = ((_e254 - vec2<f32>(141f, 312f)) / vec2<f32>(72f, 65f));
    let _e257 = h_3;
    let _e258 = shelf;
    let _e259 = shelf;
    h_3 = max(_e257, ((44f * sqrt(max(0f, (1f - dot(_e258, _e259))))) - 19f));
    let _e267 = h_3;
    let _e269 = h_3;
    woods = (smoothstep(1.3f, 9.3f, _e267) * (1f - smoothstep(106f, 130f, _e269)));
    let _e273 = woods;
    let _e274 = (*q_5);
    param_150 = (_e274 * 0.16f);
    let _e276 = valueNoise2vf2_((&param_150));
    let _e279 = (*q_5);
    param_151 = (_e279 * 0.39f);
    let _e281 = valueNoise2vf2_((&param_151));
    let _e285 = (*q_5);
    param_152 = (_e285 * vec2<f32>(0.081f, 0.043f));
    let _e287 = valueNoise2vf2_((&param_152));
    let _e296 = h_3;
    h_3 = (_e296 + (_e273 * (((2.9f * (_e276 - 0.46f)) + (0.96f * (_e281 - 0.5f))) - (0.74f * max(0f, (1f - (5f * abs((_e287 - 0.49f)))))))));
    let _e298 = (*q_5);
    tongue = ((_e298 - vec2<f32>(18f, 322f)) / vec2<f32>(35f, 36f));
    let _e301 = tongue;
    let _e302 = tongue;
    let _e306 = h_3;
    w_2 = (smoothstep(0f, 1f, (1f - dot(_e301, _e302))) * clamp((_e306 / 1.7f), 0f, 1f));
    let _e310 = (*q_5);
    param_153 = (_e310 * 0.3f);
    let _e312 = valueNoise2vf2_((&param_153));
    let _e313 = (*q_5);
    param_154 = (_e313 * 0.65f);
    let _e315 = valueNoise2vf2_((&param_154));
    blocks = ((_e312 + (0.45f * _e315)) - 0.72f);
    let _e319 = h_3;
    let _e322 = blocks;
    lv = ((max(_e319, 0f) / 4.2f) + (0.4f * _e322));
    let _e325 = h_3;
    let _e326 = lv;
    let _e328 = lv;
    let _e335 = blocks;
    let _e338 = w_2;
    return mix(_e325, ((2.28f * (floor(_e326) + clamp(((fract(_e328) - 0.33f) / 0.36f), 0f, 1f))) + (1.65f * _e335)), _e338);
}

fn elevationAtvi2_(node: ptr<function, vec2<i32>>) -> f32 {
    var world_2: vec2<f32>;
    var param_155: vec2<f32>;

    let _e12 = (*node);
    world_2 = ((((vec2<f32>(min(_e12, vec2<i32>(1536i, 1536i))) + vec2(0.5f)) / vec2(1537f)) * vec2<f32>(2200f, 1800f)) - vec2<f32>(1100f, 40f));
    let _e21 = world_2;
    param_155 = _e21;
    let _e22 = landvf2_((&param_155));
    return ((floor(clamp(((_e22 + 48f) * 128f), 0f, 65535f)) / 128f) - 48f);
}

fn elevationNodevi2_(node_1: ptr<function, vec2<i32>>) -> f32 {
    var values: vec4<f32>;

    let _e9 = (*node_1);
    (*node_1) = clamp(_e9, vec2<i32>(0i, 0i), vec2<i32>(1536i, 1536i));
    let _e11 = (*node_1);
    let _e14 = textureLoad(tex0_, (_e11 / vec2(2i)), 0i);
    values = _e14;
    let _e16 = (*node_1)[1u];
    let _e26 = (*node_1)[0u];
    let _e36 = values[(((_e16 - (i32(floor((f32(_e16) / f32(2i)))) * 2i)) * 2i) + (_e26 - (i32(floor((f32(_e26) / f32(2i)))) * 2i)))];
    return _e36;
}

fn elevationComponentsvi2_(node_2: ptr<function, vec2<i32>>) -> vec2<f32> {
    var units: f32;
    var param_156: vec2<i32>;

    let _e6 = (*node_2);
    param_156 = _e6;
    let _e7 = elevationNodevi2_((&param_156));
    units = ((_e7 + 48f) * 128f);
    let _e10 = units;
    let _e13 = units;
    return vec2<f32>(floor((_e10 / 256f)), (_e13 - (floor((_e13 / 256f)) * 256f)));
}

fn bedvf2_(world_3: ptr<function, vec2<f32>>) -> f32 {
    var at: vec2<f32>;
    var i_15: vec2<i32>;
    var f_4: vec2<f32>;
    var value: vec2<f32>;
    var param_157: vec2<i32>;
    var param_158: vec2<i32>;
    var param_159: vec2<i32>;
    var param_160: vec2<i32>;

    let _e23 = (*world_3);
    at = ((((_e23 + vec2<f32>(1100f, 40f)) / vec2<f32>(2200f, 1800f)) * 1537f) - vec2(0.5f));
    let _e29 = at;
    i_15 = vec2<i32>(floor(_e29));
    let _e32 = at;
    f_4 = (floor(((fract(_e32) * 256f) + vec2(0.5f))) / vec2(256f));
    let _e40 = i_15;
    param_157 = _e40;
    let _e41 = elevationComponentsvi2_((&param_157));
    let _e42 = i_15;
    param_158 = (_e42 + vec2<i32>(1i, 0i));
    let _e44 = elevationComponentsvi2_((&param_158));
    let _e46 = f_4[0u];
    let _e49 = i_15;
    param_159 = (_e49 + vec2<i32>(0i, 1i));
    let _e51 = elevationComponentsvi2_((&param_159));
    let _e52 = i_15;
    param_160 = (_e52 + vec2<i32>(1i, 1i));
    let _e54 = elevationComponentsvi2_((&param_160));
    let _e56 = f_4[0u];
    let _e60 = f_4[1u];
    value = mix(mix(_e41, _e44, vec2(_e46)), mix(_e51, _e54, vec2(_e56)), vec2(_e60));
    let _e63 = value;
    return ((dot((floor(((_e63 * 16f) + vec2(0.5f))) / vec2(16f)), vec2<f32>(256f, 1f)) / 128f) - 48f);
}

fn branchVertexi1i1i1i1i1_(id_2: ptr<function, i32>, rings: ptr<function, i32>, arms: ptr<function, i32>, shoots: ptr<function, i32>, variant: ptr<function, i32>) -> NeedleVertex {
    var cell_1: i32;
    var k_2: i32;
    var quad: array<vec2<i32>, 6>;
    var side: i32;
    var seg: i32;
    var shoot: i32;
    var arm: i32;
    var tier: i32;
    var seed_1: i32;
    var t_2: f32;
    var phi: f32;
    var param_161: i32;
    var param_162: i32;
    var len_1: f32;
    var param_163: i32;
    var param_164: i32;
    var base: f32;
    var param_165: i32;
    var param_166: i32;
    var start: f32;
    var local_12: f32;
    var param_167: i32;
    var param_168: i32;
    var ang: f32;
    var local_13: f32;
    var param_169: i32;
    var param_170: i32;
    var d_3: vec2<f32>;
    var l_1: vec2<f32>;
    var u_2: f32;
    var reach: f32;
    var param_171: i32;
    var param_172: i32;
    var a_6: f32;
    var param_173: i32;
    var param_174: i32;
    var span_1: f32;
    var local_14: f32;
    var param_175: i32;
    var param_176: i32;
    var pos: vec2<f32>;
    var point: vec3<f32>;
    var facing: vec2<f32>;
    var radial: vec4<f32>;

    let _e97 = (*id_2);
    cell_1 = (_e97 / 6i);
    let _e99 = (*id_2);
    k_2 = (_e99 - (i32(floor((f32(_e99) / f32(6i)))) * 6i));
    quad = array<vec2<i32>, 6>(vec2<i32>(0i, 0i), vec2<i32>(0i, 1i), vec2<i32>(1i, 0i), vec2<i32>(0i, 1i), vec2<i32>(1i, 1i), vec2<i32>(1i, 0i));
    let _e107 = cell_1;
    let _e115 = k_2;
    let _e118 = quad[_e115][1u];
    let _e119 = ((_e107 - (i32(floor((f32(_e107) / f32(3i)))) * 3i)) + _e118);
    side = (_e119 - (i32(floor((f32(_e119) / f32(3i)))) * 3i));
    let _e127 = cell_1;
    let _e128 = (_e127 / 3i);
    let _e136 = k_2;
    let _e139 = quad[_e136][0u];
    seg = ((_e128 - (i32(floor((f32(_e128) / f32(2i)))) * 2i)) + _e139);
    let _e141 = cell_1;
    let _e142 = (_e141 / 6i);
    let _e143 = (*shoots);
    shoot = (_e142 - (i32(floor((f32(_e142) / f32(_e143)))) * _e143));
    let _e151 = cell_1;
    let _e152 = (*shoots);
    let _e154 = (_e151 / (6i * _e152));
    let _e155 = (*arms);
    arm = (_e154 - (i32(floor((f32(_e154) / f32(_e155)))) * _e155));
    let _e163 = cell_1;
    let _e164 = (*shoots);
    let _e166 = (*arms);
    tier = (_e163 / ((6i * _e164) * _e166));
    let _e169 = tier;
    let _e171 = arm;
    let _e174 = (*variant);
    seed_1 = (((_e169 * 389i) + (_e171 * 37i)) + (_e174 * 9209i));
    let _e177 = tier;
    let _e180 = (*rings);
    t_2 = ((f32(_e177) + 0.37f) / f32(_e180));
    let _e183 = tier;
    let _e186 = arm;
    let _e188 = seed_1;
    param_161 = _e188;
    param_162 = 0i;
    let _e189 = rndi1i1_((&param_161), (&param_162));
    let _e193 = (*arms);
    phi = ((f32(_e183) * 2.39996f) + (((f32(_e186) + (0.8f * _e189)) * 6.283185f) / f32(_e193)));
    let _e197 = t_2;
    let _e201 = seed_1;
    param_163 = _e201;
    param_164 = 1i;
    let _e202 = rndi1i1_((&param_163), (&param_164));
    len_1 = ((0.17f * pow((1f - _e197), 0.74f)) * (0.66f + (0.62f * _e202)));
    let _e206 = t_2;
    let _e209 = seed_1;
    param_165 = _e209;
    param_166 = 2i;
    let _e210 = rndi1i1_((&param_165), (&param_166));
    let _e213 = (*rings);
    base = ((0.1f + (0.87f * _e206)) + (((0.5f - _e210) * 0.8f) / f32(_e213)));
    let _e217 = shoot;
    if (_e217 == 0i) {
        local_12 = 0f;
    } else {
        let _e219 = shoot;
        let _e221 = seed_1;
        param_167 = _e221;
        param_168 = (7i + _e219);
        let _e222 = rndi1i1_((&param_167), (&param_168));
        local_12 = (0.17f + (0.39f * _e222));
    }
    let _e225 = local_12;
    start = _e225;
    let _e226 = phi;
    let _e227 = shoot;
    if (_e227 == 0i) {
        local_13 = 0f;
    } else {
        let _e229 = shoot;
        let _e239 = shoot;
        let _e241 = seed_1;
        param_169 = _e241;
        param_170 = (4i + _e239);
        let _e242 = rndi1i1_((&param_169), (&param_170));
        local_13 = (select(1f, -1f, ((_e229 - (i32(floor((f32(_e229) / f32(2i)))) * 2i)) == 0i)) * (0.35f + (0.41f * _e242)));
    }
    let _e246 = local_13;
    ang = (_e226 + _e246);
    let _e248 = ang;
    let _e250 = ang;
    d_3 = vec2<f32>(cos(_e248), sin(_e250));
    let _e254 = d_3[1u];
    let _e257 = d_3[0u];
    l_1 = vec2<f32>(-(_e254), _e257);
    let _e259 = seg;
    u_2 = (f32(_e259) * 0.5f);
    let _e262 = len_1;
    let _e263 = start;
    let _e266 = shoot;
    let _e268 = seed_1;
    param_171 = _e268;
    param_172 = (11i + _e266);
    let _e269 = rndi1i1_((&param_171), (&param_172));
    reach = ((_e262 * (1f - _e263)) * (0.84f + (0.25f * _e269)));
    let _e273 = side;
    let _e276 = shoot;
    let _e278 = seed_1;
    param_173 = _e278;
    param_174 = (19i + _e276);
    let _e279 = rndi1i1_((&param_173), (&param_174));
    a_6 = ((f32(_e273) * 2.094395f) + (0.7f * _e279));
    let _e282 = reach;
    let _e283 = shoot;
    let _e287 = seg;
    if (_e287 == 0i) {
        local_14 = 0.17f;
    } else {
        let _e289 = seg;
        local_14 = select(1f, 0.012f, (_e289 == 2i));
    }
    let _e292 = local_14;
    let _e294 = side;
    let _e296 = seed_1;
    param_175 = _e296;
    param_176 = (_e294 + 23i);
    let _e297 = rndi1i1_((&param_175), (&param_176));
    span_1 = (((_e282 * select(0.27f, 0.35f, (_e283 == 0i))) * _e292) * (0.75f + (0.5f * _e297)));
    let _e301 = phi;
    let _e303 = phi;
    let _e306 = start;
    let _e308 = len_1;
    let _e310 = d_3;
    let _e311 = reach;
    let _e313 = u_2;
    let _e316 = l_1;
    let _e317 = a_6;
    let _e320 = span_1;
    pos = ((((vec2<f32>(cos(_e301), sin(_e303)) * _e306) * _e308) + ((_e310 * _e311) * _e313)) + ((_e316 * cos(_e317)) * _e320));
    let _e324 = pos[0u];
    let _e325 = base;
    let _e326 = len_1;
    let _e327 = start;
    let _e329 = u_2;
    let _e332 = u_2;
    let _e339 = a_6;
    let _e341 = span_1;
    let _e346 = pos[1u];
    point = vec3<f32>(_e324, ((_e325 - (_e326 * (((0.22f * _e327) + (0.3f * _e329)) + (0.29f * sin((3.14159f * _e332)))))) + ((sin(_e339) * _e341) * 0.71f)), _e346);
    let _e348 = d_3;
    let _e350 = l_1;
    let _e351 = a_6;
    facing = ((_e348 * 0.28f) + (_e350 * cos(_e351)));
    let _e356 = facing[0u];
    let _e357 = a_6;
    let _e360 = facing[1u];
    let _e361 = u_2;
    let _e364 = a_6;
    radial = vec4<f32>(_e356, sin(_e357), _e360, ((0.18f + (0.56f * _e361)) + (0.22f * max(0f, sin(_e364)))));
    let _e370 = point;
    let _e371 = radial;
    return NeedleVertex(_e370, _e371);
}

fn crownDatai1_(address: ptr<function, i32>) -> vec4<f32> {
    var shoot_1: i32;
    var variant_1: i32;
    var local_15: i32;
    var level: i32;
    var local_16: i32;
    var local_17: i32;
    var vertex: i32;
    var segment: i32;
    var id_3: i32;
    var local_18: i32;
    var v_1: NeedleVertex;
    var local_19: i32;
    var local_20: i32;
    var param_177: i32;
    var param_178: i32;
    var param_179: i32;
    var param_180: i32;
    var param_181: i32;
    var local_21: vec4<f32>;

    let _e36 = (*address);
    shoot_1 = (_e36 / 18i);
    let _e38 = shoot_1;
    variant_1 = (_e38 / 790i);
    let _e40 = shoot_1;
    local_15 = (_e40 - (i32(floor((f32(_e40) / f32(790i)))) * 790i));
    let _e48 = local_15;
    if (_e48 < 570i) {
        local_16 = 0i;
    } else {
        let _e50 = local_15;
        local_16 = select(2i, 1i, (_e50 < 750i));
    }
    let _e53 = local_16;
    level = _e53;
    let _e54 = level;
    if (_e54 == 0i) {
        local_17 = 0i;
    } else {
        let _e56 = level;
        local_17 = select(750i, 570i, (_e56 == 1i));
    }
    let _e59 = local_17;
    let _e60 = local_15;
    local_15 = (_e60 - _e59);
    let _e62 = (*address);
    vertex = ((_e62 - (i32(floor((f32(_e62) / f32(18i)))) * 18i)) / 2i);
    let _e71 = vertex;
    segment = (_e71 / 3i);
    let _e73 = local_15;
    let _e75 = segment;
    if (_e75 == 0i) {
        local_18 = 0i;
    } else {
        let _e77 = segment;
        local_18 = select(20i, 2i, (_e77 == 1i));
    }
    let _e80 = local_18;
    let _e82 = vertex;
    id_3 = (((_e73 * 36i) + _e80) + ((_e82 - (i32(floor((f32(_e82) / f32(3i)))) * 3i)) * 6i));
    let _e92 = level;
    if (_e92 == 0i) {
        local_19 = 19i;
    } else {
        let _e94 = level;
        local_19 = select(8i, 12i, (_e94 == 1i));
    }
    let _e97 = level;
    let _e100 = level;
    if (_e100 == 0i) {
        local_20 = 5i;
    } else {
        let _e102 = level;
        local_20 = select(1i, 3i, (_e102 == 1i));
    }
    let _e105 = id_3;
    param_177 = _e105;
    let _e106 = local_19;
    param_178 = _e106;
    param_179 = select(5i, 6i, (_e97 == 0i));
    let _e107 = local_20;
    param_180 = _e107;
    let _e108 = variant_1;
    param_181 = _e108;
    let _e109 = branchVertexi1i1i1i1i1_((&param_177), (&param_178), (&param_179), (&param_180), (&param_181));
    v_1 = _e109;
    let _e110 = (*address);
    if ((_e110 - (i32(floor((f32(_e110) / f32(2i)))) * 2i)) == 0i) {
        let _e120 = v_1.p;
        local_21 = vec4<f32>(_e120.x, _e120.y, _e120.z, 1f);
    } else {
        let _e126 = v_1.radial;
        local_21 = _e126;
    }
    let _e127 = local_21;
    return _e127;
}

fn mainImagevf4vf2_(result: ptr<function, vec4<f32>>, pixel: ptr<function, vec2<f32>>) {
    var cell_2: vec2<i32>;
    var address_1: i32;
    var local_22: vec4<f32>;
    var param_182: i32;
    var slot: i32;
    var low: vec3<f32>;
    var high: vec3<f32>;
    var j: i32;
    var index: i32;
    var vertex_1: vec3<f32>;
    var index_1: i32;
    var z_3: f32;
    var x_15: f32;
    var q_6: vec2<f32>;
    var ex: vec2<f32>;
    var dx_1: vec2<f32>;
    var px: vec2<f32>;
    var dz_1: vec2<f32>;
    var pz: vec2<f32>;
    var normal: vec3<f32>;
    var param_183: vec2<f32>;
    var param_184: vec2<f32>;
    var param_185: vec2<f32>;
    var param_186: vec2<f32>;
    var param_187: vec2<f32>;
    var param_188: vec2<f32>;
    var param_189: vec2<f32>;
    var param_190: vec2<f32>;
    var param_191: vec2<f32>;
    var param_192: vec2<f32>;
    var base_1: vec2<i32>;
    var param_193: vec2<i32>;
    var param_194: vec2<i32>;
    var param_195: vec2<i32>;
    var param_196: vec2<i32>;
    var world_4: vec2<f32>;
    var id_4: i32;
    var param_197: i32;
    var p_10: vec3<f32>;
    var wp_1: vec3<f32>;
    var param_198: vec3<f32>;
    var param_199: vec3<f32>;
    var param_200: vec3<f32>;
    var param_201: vec3<f32>;
    var ground: f32;
    var param_202: vec2<f32>;
    var debris: f32;
    var i_16: i32;
    var j_1: i32;
    var a_7: f32;
    var d_4: f32;
    var wall: f32;
    var param_203: vec2<f32>;
    var phi_4072_: bool;
    var phi_4079_: bool;
    var phi_4111_: bool;
    var phi_4118_: bool;
    var phi_4125_: bool;
    var phi_4203_: bool;
    var phi_4209_: bool;
    var phi_4227_: bool;
    var phi_4234_: bool;
    var phi_4240_: bool;
    var phi_4384_: bool;
    var phi_4429_: bool;
    var phi_4436_: bool;

    let _e106 = (*pixel);
    cell_2 = vec2<i32>(_e106);
    let _e109 = unnamed.iFrame;
    let _e110 = (_e109 == 0i);
    phi_4072_ = _e110;
    if _e110 {
        let _e112 = cell_2[0u];
        phi_4072_ = (_e112 < 768i);
    }
    let _e115 = phi_4072_;
    phi_4079_ = _e115;
    if _e115 {
        let _e117 = cell_2[1u];
        phi_4079_ = (_e117 >= 769i);
    }
    let _e120 = phi_4079_;
    if _e120 {
        let _e122 = cell_2[1u];
        let _e126 = cell_2[0u];
        address_1 = (((_e122 - 769i) * 768i) + _e126);
        let _e128 = address_1;
        if (_e128 < 42660i) {
            let _e130 = address_1;
            param_182 = _e130;
            let _e131 = crownDatai1_((&param_182));
            local_22 = _e131;
        } else {
            local_22 = vec4<f32>(0f, 0f, 0f, 0f);
        }
        let _e132 = local_22;
        (*result) = _e132;
        return;
    }
    let _e134 = unnamed.iFrame;
    let _e135 = (_e134 == 1i);
    phi_4111_ = _e135;
    if _e135 {
        let _e137 = cell_2[0u];
        phi_4111_ = (_e137 < 768i);
    }
    let _e140 = phi_4111_;
    phi_4118_ = _e140;
    if _e140 {
        let _e142 = cell_2[1u];
        phi_4118_ = (_e142 >= 825i);
    }
    let _e145 = phi_4118_;
    phi_4125_ = _e145;
    if _e145 {
        let _e147 = cell_2[1u];
        phi_4125_ = (_e147 < 832i);
    }
    let _e150 = phi_4125_;
    if _e150 {
        let _e152 = cell_2[1u];
        let _e156 = cell_2[0u];
        slot = (((_e152 - 825i) * 768i) + _e156);
        let _e158 = slot;
        if (_e158 >= 4740i) {
            (*result) = vec4<f32>(0f, 0f, 0f, 0f);
            return;
        }
        low = vec3<f32>(2f, 2f, 2f);
        high = vec3<f32>(-2f, -2f, -2f);
        j = 0i;
        loop {
            let _e160 = j;
            if (_e160 < 9i) {
                let _e162 = slot;
                let _e165 = j;
                index = (((_e162 / 2i) * 18i) + (2i * _e165));
                let _e168 = index;
                let _e176 = index;
                let _e180 = textureLoad(tex0_, vec2<i32>((_e168 - (i32(floor((f32(_e168) / f32(768i)))) * 768i)), (769i + (_e176 / 768i))), 0i);
                vertex_1 = _e180.xyz;
                let _e182 = low;
                let _e183 = vertex_1;
                low = min(_e182, _e183);
                let _e185 = high;
                let _e186 = vertex_1;
                high = max(_e185, _e186);
                continue;
            } else {
                break;
            }
            continuing {
                let _e188 = j;
                j = (_e188 + 1i);
            }
        }
        let _e190 = slot;
        let _e199 = low;
        let _e200 = high;
        let _e202 = select(_e200, _e199, vec3(((_e190 - (i32(floor((f32(_e190) / f32(2i)))) * 2i)) == 0i)));
        (*result) = vec4<f32>(_e202.x, _e202.y, _e202.z, 1f);
        return;
    }
    let _e208 = unnamed.iFrame;
    let _e209 = (_e208 == 1i);
    phi_4203_ = _e209;
    if _e209 {
        let _e211 = cell_2[0u];
        phi_4203_ = (_e211 < 768i);
    }
    let _e214 = phi_4203_;
    phi_4209_ = _e214;
    if _e214 {
        let _e216 = cell_2[1u];
        phi_4209_ = (_e216 >= 769i);
    }
    let _e219 = phi_4209_;
    if _e219 {
        let _e220 = cell_2;
        let _e221 = textureLoad(tex0_, _e220, 0i);
        (*result) = _e221;
        return;
    }
    let _e223 = unnamed.iFrame;
    let _e224 = (_e223 == 2i);
    phi_4227_ = _e224;
    if _e224 {
        let _e226 = cell_2[0u];
        phi_4227_ = (_e226 >= 769i);
    }
    let _e229 = phi_4227_;
    phi_4234_ = _e229;
    if _e229 {
        let _e231 = cell_2[0u];
        phi_4234_ = (_e231 < 1793i);
    }
    let _e234 = phi_4234_;
    phi_4240_ = _e234;
    if _e234 {
        let _e236 = cell_2[1u];
        phi_4240_ = (_e236 >= 768i);
    }
    let _e239 = phi_4240_;
    if _e239 {
        let _e241 = cell_2[1u];
        let _e245 = cell_2[0u];
        index_1 = ((((_e241 - 768i) * 1024i) + _e245) - 769i);
        let _e248 = index_1;
        if (_e248 < 189297i) {
            let _e250 = index_1;
            z_3 = (2f + (1648f * pow((f32((_e250 / 513i)) / 368f), 1.63f)));
            let _e257 = index_1;
            let _e268 = z_3;
            x_15 = (((f32((_e257 - (i32(floor((f32(_e257) / f32(513i)))) * 513i))) / 256f) - 1f) * ((_e268 * 0.81f) + 35f));
            let _e272 = x_15;
            let _e273 = z_3;
            q_6 = vec2<f32>(_e272, _e273);
            let _e275 = z_3;
            ex = vec2<f32>(max(1.4f, (_e275 * 0.00085f)), 0f);
            let _e279 = q_6;
            let _e280 = ex;
            dx_1 = (_e279 - _e280);
            let _e282 = q_6;
            let _e283 = ex;
            px = (_e282 + _e283);
            let _e285 = q_6;
            let _e286 = ex;
            dz_1 = (_e285 - _e286.yx);
            let _e289 = q_6;
            let _e290 = ex;
            pz = (_e289 + _e290.yx);
            let _e293 = dx_1;
            param_183 = _e293;
            let _e294 = bedvf2_((&param_183));
            let _e295 = dx_1;
            param_184 = _e295;
            let _e296 = rockSurveyvf2_((&param_184));
            let _e299 = px;
            param_185 = _e299;
            let _e300 = bedvf2_((&param_185));
            let _e302 = px;
            param_186 = _e302;
            let _e303 = rockSurveyvf2_((&param_186));
            let _e307 = ex[0u];
            let _e309 = dz_1;
            param_187 = _e309;
            let _e310 = bedvf2_((&param_187));
            let _e311 = dz_1;
            param_188 = _e311;
            let _e312 = rockSurveyvf2_((&param_188));
            let _e315 = pz;
            param_189 = _e315;
            let _e316 = bedvf2_((&param_189));
            let _e318 = pz;
            param_190 = _e318;
            let _e319 = rockSurveyvf2_((&param_190));
            normal = normalize(vec3<f32>((((_e294 + _e296.y) - _e300) - _e303.y), (2f * _e307), (((_e310 + _e312.y) - _e316) - _e319.y)));
            let _e324 = q_6;
            param_191 = _e324;
            let _e325 = bedvf2_((&param_191));
            let _e326 = q_6;
            param_192 = _e326;
            let _e327 = rockSurveyvf2_((&param_192));
            let _e330 = normal;
            (*result) = vec4<f32>((_e325 + _e327.y), _e330.x, _e330.y, _e330.z);
            return;
        }
    }
    let _e336 = unnamed.iFrame;
    if (_e336 > 1i) {
        let _e338 = cell_2;
        let _e339 = textureLoad(tex0_, _e338, 0i);
        (*result) = _e339;
        return;
    }
    let _e341 = cell_2[0u];
    let _e342 = (_e341 < 769i);
    phi_4384_ = _e342;
    if _e342 {
        let _e344 = cell_2[1u];
        phi_4384_ = (_e344 < 769i);
    }
    let _e347 = phi_4384_;
    if _e347 {
        let _e349 = unnamed.iFrame;
        if (_e349 == 1i) {
            let _e351 = cell_2;
            let _e352 = textureLoad(tex0_, _e351, 0i);
            (*result) = _e352;
            return;
        }
        let _e353 = cell_2;
        base_1 = (_e353 * vec2(2i));
        let _e356 = base_1;
        param_193 = _e356;
        let _e357 = elevationAtvi2_((&param_193));
        let _e358 = base_1;
        param_194 = (_e358 + vec2<i32>(1i, 0i));
        let _e360 = elevationAtvi2_((&param_194));
        let _e361 = base_1;
        param_195 = (_e361 + vec2<i32>(0i, 1i));
        let _e363 = elevationAtvi2_((&param_195));
        let _e364 = base_1;
        param_196 = (_e364 + vec2<i32>(1i, 1i));
        let _e366 = elevationAtvi2_((&param_196));
        (*result) = vec4<f32>(_e357, _e360, _e363, _e366);
        return;
    }
    (*result) = vec4<f32>(0f, 0f, 0f, 0f);
    let _e369 = cell_2[0u];
    let _e370 = (_e369 < 769i);
    phi_4429_ = _e370;
    if !(_e370) {
        let _e373 = cell_2[0u];
        phi_4429_ = (_e373 >= 1793i);
    }
    let _e376 = phi_4429_;
    phi_4436_ = _e376;
    if !(_e376) {
        let _e379 = cell_2[1u];
        phi_4436_ = (_e379 >= 768i);
    }
    let _e382 = phi_4436_;
    if _e382 {
        return;
    }
    let _e383 = (*pixel);
    world_4 = ((_e383 - vec2<f32>(769f, 0f)) + vec2<f32>(-100f, 320f));
    let _e387 = unnamed.iFrame;
    if (_e387 == 0i) {
        id_4 = 0i;
        loop {
            let _e389 = id_4;
            if (_e389 < 3i) {
                let _e391 = id_4;
                param_197 = _e391;
                setRocki1_((&param_197));
                let _e393 = world_4[0u];
                let _e395 = world_4[1u];
                param_198 = vec3<f32>(_e393, 520f, _e395);
                param_199 = vec3<f32>(0f, -1f, 0f);
                let _e397 = intersectRockvf3vf3vf3vf3_((&param_198), (&param_199), (&param_200), (&param_201));
                let _e398 = param_200;
                p_10 = _e398;
                let _e399 = param_201;
                wp_1 = _e399;
                if _e397 {
                    let _e401 = (*result)[0u];
                    let _e403 = wp_1[1u];
                    (*result)[0u] = max(_e401, (floor((max(_e403, 0f) * 64f)) / 64f));
                }
                continue;
            } else {
                break;
            }
            continuing {
                let _e410 = id_4;
                id_4 = (_e410 + 1i);
            }
        }
    } else {
        let _e412 = cell_2;
        let _e413 = textureLoad(tex0_, _e412, 0i);
        (*result)[0u] = _e413.x;
        let _e416 = world_4;
        param_202 = _e416;
        let _e417 = bedvf2_((&param_202));
        ground = _e417;
        debris = 0f;
        i_16 = 0i;
        loop {
            let _e418 = i_16;
            if (_e418 < 8i) {
                j_1 = 0i;
                loop {
                    let _e420 = j_1;
                    if (_e420 < 4i) {
                        let _e422 = i_16;
                        a_7 = (f32(_e422) * 0.785398f);
                        let _e425 = j_1;
                        d_4 = (3f * exp2(f32(_e425)));
                        let _e429 = world_4;
                        let _e430 = a_7;
                        let _e432 = a_7;
                        let _e435 = d_4;
                        param_203 = (_e429 + (vec2<f32>(cos(_e430), sin(_e432)) * _e435));
                        let _e438 = capvf2_((&param_203));
                        wall = _e438;
                        let _e439 = debris;
                        let _e440 = wall;
                        let _e441 = ground;
                        let _e444 = d_4;
                        let _e447 = ground;
                        debris = max(_e439, ((min(_e440, (_e441 + 28f)) - (_e444 * 0.69f)) - _e447));
                        continue;
                    } else {
                        break;
                    }
                    continuing {
                        let _e450 = j_1;
                        j_1 = (_e450 + 1i);
                    }
                }
                continue;
            } else {
                break;
            }
            continuing {
                let _e452 = i_16;
                i_16 = (_e452 + 1i);
            }
        }
        let _e454 = debris;
        (*result)[1u] = (round((clamp((_e454 / 42.5f), 0f, 1f) * 255f)) * 0.16666667f);
    }
    return;
}

fn main_1() {
    var param_204: vec4<f32>;
    var param_205: vec2<f32>;

    let _e4 = gl_FragCoord_1;
    param_205 = _e4.xy;
    mainImagevf4vf2_((&param_204), (&param_205));
    let _e6 = param_204;
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
