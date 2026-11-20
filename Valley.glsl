// Ember Grove | single-sun procedural valley
// Select 0, 1, 2, 3, or 4 for Buffer A, B, C, D, or Image.
// Channel wiring (in order): A=[A], B=[A,B], C=[C,B,A], D=[A,B,C], Image=[D,C].
// C and D require mipmaps in their consumers. All scene data is generated in GLSL.
#ifndef VALLEY_PASS
#define VALLEY_PASS 4
#endif
#if VALLEY_PASS == 0
float rnd(int x,int seed){uint h=uint(x)*747796405u+uint(seed)*2891336453u+277803737u;h=((h>>((h>>28u)+4u))^h)*277803737u;return float((h>>22u)^h)/4294967296.;}
float noise2(vec2 p){ivec2 i=ivec2(floor(p));vec2 f=fract(p);f=f*f*(3.-2.*f);return mix(mix(rnd(i.x,i.y),rnd(i.x+1,i.y),f.x),mix(rnd(i.x,i.y+1),rnd(i.x+1,i.y+1),f.x),f.y);}
float ridge0(float x){const vec2 pts[10]=vec2[](vec2(0.00000,182.00000),vec2(95.00000,198.00000),vec2(183.00000,225.00000),vec2(287.00000,258.00000),vec2(356.00000,282.00000),vec2(451.00000,324.00000),vec2(520.00000,355.00000),vec2(591.00000,397.00000),vec2(700.00000,464.00000),vec2(1100.00000,526.00000));float y=pts[0].y;for(int i=1;i<10;i++)y=mix(y,pts[i].y,clamp((x-pts[i-1].x)/(pts[i].x-pts[i-1].x),0.,1.));return y;}
float ridge1(float x){const vec2 pts[15]=vec2[](vec2(0.00000,185.00000),vec2(185.00000,195.00000),vec2(247.00000,187.00000),vec2(301.00000,196.00000),vec2(369.00000,220.00000),vec2(414.00000,232.00000),vec2(479.00000,202.00000),vec2(510.00000,214.00000),vec2(554.00000,188.00000),vec2(605.00000,205.00000),vec2(760.00000,124.00000),vec2(988.00000,110.00000),vec2(1016.00000,96.00000),vec2(1047.00000,113.00000),vec2(1100.00000,108.00000));float y=pts[0].y;for(int i=1;i<15;i++)y=mix(y,pts[i].y,clamp((x-pts[i-1].x)/(pts[i].x-pts[i-1].x),0.,1.));return y;}
float ridge2(float x){const vec2 pts[13]=vec2[](vec2(0.00000,202.00000),vec2(121.00000,213.00000),vec2(232.00000,228.00000),vec2(312.00000,250.00000),vec2(425.00000,298.00000),vec2(525.00000,282.00000),vec2(631.00000,253.00000),vec2(710.00000,247.00000),vec2(818.00000,215.00000),vec2(899.00000,211.00000),vec2(982.00000,166.00000),vec2(1045.00000,140.00000),vec2(1100.00000,121.00000));float y=pts[0].y;for(int i=1;i<13;i++)y=mix(y,pts[i].y,clamp((x-pts[i-1].x)/(pts[i].x-pts[i-1].x),0.,1.));return y;}
float ridge3(float x){const vec2 pts[14]=vec2[](vec2(0.00000,236.00000),vec2(105.00000,260.00000),vec2(231.00000,284.00000),vec2(327.00000,308.00000),vec2(432.00000,342.00000),vec2(504.00000,361.00000),vec2(577.00000,384.00000),vec2(622.00000,397.00000),vec2(676.00000,365.00000),vec2(773.00000,331.00000),vec2(865.00000,307.00000),vec2(954.00000,276.00000),vec2(1023.00000,257.00000),vec2(1100.00000,235.00000));float y=pts[0].y;for(int i=1;i<14;i++)y=mix(y,pts[i].y,clamp((x-pts[i-1].x)/(pts[i].x-pts[i-1].x),0.,1.));return y;}
float ridge4(float x){const vec2 pts[6]=vec2[](vec2(0.00000,204.00000),vec2(242.00000,217.00000),vec2(411.00000,262.00000),vec2(516.00000,250.00000),vec2(654.00000,233.00000),vec2(1100.00000,167.00000));float y=pts[0].y;for(int i=1;i<6;i++)y=mix(y,pts[i].y,clamp((x-pts[i-1].x)/(pts[i].x-pts[i-1].x),0.,1.));return y;}
float ridge5(float x){const vec2 pts[6]=vec2[](vec2(0.00000,218.00000),vec2(214.00000,245.00000),vec2(385.00000,292.00000),vec2(499.00000,308.00000),vec2(649.00000,268.00000),vec2(1100.00000,194.00000));float y=pts[0].y;for(int i=1;i<6;i++)y=mix(y,pts[i].y,clamp((x-pts[i-1].x)/(pts[i].x-pts[i-1].x),0.,1.));return y;}
float leftShore(float x){const vec2 pts[12]=vec2[](vec2(129.72823,48.40606),vec2(159.51025,40.67114),vec2(182.23618,36.49257),vec2(209.35163,33.85039),vec2(235.64879,23.74074),vec2(266.94493,11.95276),vec2(293.38477,1.09472),vec2(320.08190,-3.58301),vec2(347.77235,1.29766),vec2(383.30042,10.01158),vec2(414.34146,24.73680),vec2(436.85477,36.94792));float y=pts[0].y;for(int i=1;i<12;i++)y=mix(y,pts[i].y,clamp((x-pts[i-1].x)/(pts[i].x-pts[i-1].x),0.,1.));return y;}
float rightShore(float x){const vec2 pts[12]=vec2[](vec2(129.72823,148.44524),vec2(159.51025,160.70062),vec2(182.23618,169.99644),vec2(209.35163,177.06357),vec2(235.64879,175.85730),vec2(266.94493,169.33074),vec2(293.38477,160.19392),vec2(320.08190,123.01655),vec2(347.77235,127.17049),vec2(383.30042,92.96465),vec2(414.34146,68.54156),vec2(436.85477,47.27160));float y=pts[0].y;for(int i=1;i<12;i++)y=mix(y,pts[i].y,clamp((x-pts[i-1].x)/(pts[i].x-pts[i-1].x),0.,1.));return y;}

float ridge(vec2 q,float u,float line,float crest,float front,float back,float flutes){
 float dz=q.y-crest-55.*sin(q.x*.013)-28.*sin(q.x*.030),r=max(0.,-dz);
 float f=fract((u*.050+r*.031+1.42*noise2(vec2(u*.021,r*.009))+.36*noise2(vec2(u*.086,r*.009)))/3.14159);
 float cut=max(1.-f/.27,(f-.27)/.73)*(.56+.65*noise2(vec2(u*.014,r*.006)));
 return 70.+(266.17-line)*q.y/804.-abs(dz)*(dz<0.?front:back)-(cut*.94+.1*noise2(q*.09))*flutes*min(1.,abs(dz)/48.);
}
float bell(float x){return exp(-x*x);}
float land(vec2 q){
 float x=q.x,z=q.y,u=550.+804.*x/max(z,2.),h=-1000.;
h=max(h,ridge(q,u,ridge0(u),302.0,0.78,0.5,8.0));
h=max(h,ridge(q,u,ridge1(u),1420.0,0.47,0.8,4.0));
h=max(h,ridge(q,u,ridge2(u),685.0,0.56,0.6,7.0));
h=max(h,ridge(q,u,ridge3(u),435.0,0.53,0.48,6.0));
h=max(h,ridge(q,u,ridge4(u),1035.0,0.44,0.58,4.0));
h=max(h,ridge(q,u,ridge5(u),810.0,0.45,0.53,3.0));
 float l=leftShore(z)-14.*bell((z-190.)/43.)+32.*bell((z-422.)/24.);
 float r=rightShore(z)+28.*bell((z-206.)/64.)-14.*bell((z-321.)/21.)+20.*bell((z-225.)/42.);
 h=max(h,clamp(.48*max(l-x,x-r),-10.,46.)+2.6*(noise2(q*.047)-.5));
 vec2 shelf=(q-vec2(141.,312.))/vec2(72.,65.);
 h=max(h,44.*sqrt(max(0.,1.-dot(shelf,shelf)))-19.);
 float woods=smoothstep(1.3,9.3,h)*(1.-smoothstep(106.,130.,h));
 h+=woods*(2.9*(noise2(q*.16)-.46)+.96*(noise2(q*.39)-.5)-.74*max(0.,1.-5.*abs(noise2(q*vec2(.081,.043))-.49)));
 vec2 tongue=(q-vec2(18.,322.))/vec2(35.,36.);float w=smoothstep(0.,1.,1.-dot(tongue,tongue))*clamp(h/1.7,0.,1.);
 float blocks=noise2(q*.30)+.45*noise2(q*.65)-.72,lv=max(h,0.)/4.2+.4*blocks;
 return mix(h,2.28*(floor(lv)+clamp((fract(lv)-.33)/.36,0.,1.))+1.65*blocks,w);
}
int object;vec3 origin,dims,position;vec2 datum,strike;float unit;
void setRock(int id){object=id;
 datum=id==0?vec2(1450,235):id==1?vec2(1800,305):id==2?vec2(1510,435):vec2(1840,202);
 float z=id==0?970.:id==1?550.:id==2?457.:1480.;unit=z/1404.;
 strike=vec2((datum.x-960.)/1404.,(464.4-datum.y)/1404.);position=vec3(strike.x*z,70.+strike.y*z,z);
 origin=id==0?vec3(838,25,-340):id==1?vec3(1552,183,-138):id==2?vec3(1380,353,-76):vec3(1628,133,-111);
 dims=id==0?vec3(2120,650,230):id==1?vec3(2210,618,154):id==2?vec3(1700,590,82):vec3(2084,372,110);}
vec3 axes(){return vec3(strike,1.);}
    vec3 world(vec3 p){return position+unit*(vec3(p.x-datum.x,datum.y-p.y,0.)+axes()*p.z);}
    vec3 localDir(vec3 v){vec3 a=axes();return vec3(v.x-a.x*v.z,-v.y+a.y*v.z,v.z);}
    vec3 worldNormal(vec3 g){vec3 a=axes();return normalize(vec3(g.x,-g.y,g.z-a.x*g.x+a.y*g.y));}
  
const vec2 watershed[] = vec2[](vec2(890.000,466.000),
vec2(997.000,402.000),
vec2(1058.000,352.000),
vec2(1093.000,320.000),
vec2(1099.000,310.000),
vec2(1109.000,303.000),
vec2(1125.000,277.000),
vec2(1137.000,265.000),
vec2(1147.000,260.000),
vec2(1157.000,249.000),
vec2(1185.000,263.000),
vec2(1195.000,259.000),
vec2(1211.000,263.000),
vec2(1225.000,255.000),
vec2(1233.000,255.000),
vec2(1245.000,244.000),
vec2(1257.000,241.000),
vec2(1263.000,242.000),
vec2(1277.000,235.000),
vec2(1291.000,206.000),
vec2(1293.000,205.000),
vec2(1295.000,200.000),
vec2(1303.000,189.000),
vec2(1309.000,184.000),
vec2(1323.000,184.000),
vec2(1333.000,188.000),
vec2(1335.000,186.000),
vec2(1339.000,177.000),
vec2(1343.000,176.000),
vec2(1345.000,168.000),
vec2(1353.000,164.000),
vec2(1361.000,154.000),
vec2(1365.000,144.000),
vec2(1375.000,131.000),
vec2(1377.000,125.000),
vec2(1379.000,125.000),
vec2(1381.000,117.000),
vec2(1383.000,115.000),
vec2(1387.000,106.000),
vec2(1391.000,102.000),
vec2(1393.000,97.000),
vec2(1403.000,86.000),
vec2(1407.000,85.000),
vec2(1409.000,81.000),
vec2(1421.000,77.000),
vec2(1435.000,78.000),
vec2(1455.000,86.000),
vec2(1465.000,93.000),
vec2(1480.000,93.000),
vec2(1487.000,85.000),
vec2(1495.000,79.000),
vec2(1505.000,83.000),
vec2(1511.000,83.000),
vec2(1521.000,70.000),
vec2(1531.000,69.000),
vec2(1539.000,75.000),
vec2(1547.000,76.000),
vec2(1561.000,87.000),
vec2(1569.000,96.000),
vec2(1585.000,127.000),
vec2(1591.000,130.000),
vec2(1599.000,142.000),
vec2(1607.000,147.000),
vec2(1627.000,153.000),
vec2(1633.000,149.000),
vec2(1647.000,153.000),
vec2(1655.000,147.000),
vec2(1667.000,146.000),
vec2(1687.000,157.000),
vec2(1707.000,172.000),
vec2(1733.000,185.000),
vec2(1759.000,190.000),
vec2(1780.000,204.000),
vec2(1810.000,211.000),
vec2(1870.000,237.000),
vec2(2000.000,288.000),
vec2(2070.000,340.000));
const vec4 blocks[] = vec4[](vec4(1022.000,349.000,67.000,-28.000),
vec4(1098.000,281.000,50.000,-34.000),
vec4(1158.000,229.000,49.000,-51.000),
vec4(1208.000,234.000,45.000,-14.000),
vec4(1256.000,207.000,43.000,-21.000),
vec4(1318.000,156.000,39.000,-52.000),
vec4(1356.000,128.000,31.000,-32.000),
vec4(1420.000,50.000,46.000,-74.000),
vec4(1457.000,60.000,37.000,-41.000),
vec4(1494.000,52.000,28.000,-17.000),
vec4(1534.000,40.000,54.000,-57.000),
vec4(1584.000,74.000,42.000,-25.000),
vec4(1624.000,98.000,55.000,-20.000),
vec4(1670.000,122.000,48.000,-34.000),
vec4(1725.000,146.000,58.000,-9.000),
vec4(1803.000,153.000,64.000,-16.000),
vec4(1874.000,169.000,69.000,-2.000),
vec4(1970.000,207.000,87.000,4.000),
vec4(1475.000,175.000,36.000,-105.000),
vec4(1277.000,282.000,45.000,-91.000));
const float twists[]=float[](8.0,-3.0,5.0,-4.0,6.0,-5.0,5.0,-4.0,4.0,-5.0,6.0,-5.0,4.0,-6.0,3.0,5.0,-4.0,3.0,8.0,-5.0);
float noise3(vec3 p);
float hash(vec3 p);
float smin(float a,float b,float r){float h=max(r-abs(a-b),0.)/r;return min(a,b)-.25*r*h*h;}
float roundBox(vec3 p,vec3 b,float r){vec3 q=abs(p)-b+r;return length(max(q,0.))+min(max(q.x,max(q.y,q.z)),0.)-r;}
float roof(float x){
 int lo=0,hi=watershed.length()-1;
 for(int i=0;i<8;i++){int m=(hi+lo)/2;if(x<watershed[m].x)hi=m;else lo=m;}
 vec2 a=watershed[lo],b=watershed[hi];return mix(a.y,b.y,clamp((x-a.x)/max(.01,b.x-a.x),0.,1.));}
vec2 facets(vec3 p,float scale){
 // Piecewise planar, elongated cells. The two closest nuclei determine the joint.
 vec3 q=vec3(.93*p.x+.368*p.y,(-.368*p.x+.93*p.y)*.25,p.z)/scale;
 vec3 cell=floor(q),w=fract(q);float a=10.,b=10.,tilt=0.;
 for(int z=-1;z<=1;z++)for(int y=-1;y<=1;y++)for(int x=-1;x<=1;x++){
  vec3 k=vec3(x,y,z),id=cell+k;
  vec3 off=k+.5+.38*(vec3(hash(id),hash(id+57.),hash(id+13.))-.5)-w;
  float t=dot(off,off);
  if(t<a){b=a;a=t;tilt=dot(off,vec3(hash(id+5.),hash(id+9.),hash(id+31.))-.5);}
  else b=min(b,t);
 }
 float edge=(sqrt(b)-sqrt(a))*scale;return vec2(tilt*smoothstep(0.,2.8,edge),edge);
}
float buttress(vec3 p,vec4 station,float w,float len){
 float h=p.y-station.y,x=p.x-station.x+station.z*h;
 float nose=station.w-.25*h;
 float front=max(nose-1.45*x,nose+.47*x);
 float crown=station.y-p.y+.34*max(-x,0.)+.69*max(x,0.)+.62*max(station.w-p.z,0.);
 return max(max((front-p.z)*.58,crown*.70),max(abs(x)-w*(.45+.55*clamp(h/42.,0.,1.)),max(p.z-16.,(h-len)*.61)));
}
float rockField(vec3 p){
 if(object==3){
  float x=p.x-1849.;float crest=168.+max(-.39*x,.21*x)+4.*sin(x*.071)+2.2*sin(x*.13+.8);
  float summit=crest+.58*abs(p.z);
  return max(max(summit-p.y,-p.z-40.-.17*x-.22*(p.y-195.)+3.*noise3(p*.048)),max(p.z-90.,p.y-435.));}
 if(object==1||object==2){
  float k=object==1?1.:.49;vec2 uv=object==1?vec2(1870,370):vec2(1535,470);
  vec3 q=vec3(p.xy-uv,p.z)/k;
  if(object==2)q.y=(q.y-32.)/.56;
  float ball=(length((q-vec3(24.+.26*q.y,28.,16.))/vec3(308,209,119))-1.)*125.;
  float cap=-137.-.105*q.x+.31*max(-q.x-34.,0.)+.71*max(-q.x-116.,0.)-.16*q.z-q.y;
  // A single retreating bedrock front. Its orientation turns gradually
  // through the nose. Local breaks follow the steep joint set.
  vec3 jointSpace=vec3(.031*q.x+.011*q.y,.018*q.y,.025*q.z);
  float mass=noise3(jointSpace*.52);
  float joints=noise3(jointSpace);
  float flakes=abs(noise3(jointSpace*2.63)-.47);
  float scar=abs(noise3(vec3(.025*q.x+.012*q.y,q.y*.009,q.z*.022))-.46);
  float breakage=15.*(mass-.50)+7.*abs(joints-.43)+2.5*flakes+5.*exp(-scar*scar*290.);
  float west=-q.z-100.-.62*(q.x+62.)-.20*q.y;
  float east=-q.z-104.+.30*(q.x+53.)-.31*q.y;
  float face=-smin(-west,-east,42.)+breakage;
  float lip=q.x-.38*q.y+16.*(mass-.5)+3.2*joints;
  float sheets=2.2*abs(noise3(vec3(lip*.032,q.y*.010,q.z*.026))-.38);
  float d=-smin(smin(-ball,-cap-(mass-.5)*9.,8.),-(face+sheets),15.);
  float skin=.87*(noise3(jointSpace*3.6)-.5);
  float foot=60.-.11*q.x+.46*abs(q.z+102.)+.0019*pow(max(-120.-q.x,0.),2.)+.074*abs(q.x+15.);
  foot+=4.*noise3(vec3(q.x*.04,4.,q.z*.039));
  float toe=max(max(foot-q.y,abs(q.z+104.)-77.),max(-252.-q.x,q.x-285.));
  return k*(object==2?.56:1.)*smin(d+skin,toe,3.);
 }
 float d=1000.;
 for(int i=0;i<blocks.length();i++){
  vec4 s=blocks[i];vec2 q=p.xy-s.xy;
  float down=dot(q,vec2(-.368,.93)),lat=dot(q,vec2(.93,.368));
  float dep=p.z+.32*max(down,0.)-(s.w+69.)+.00032*down*down;
  float angle=radians(twists[i]+(s.x<1470.?26.:-13.));
  vec2 ac=mat2(cos(angle),sin(angle),-sin(angle),cos(angle))*vec2(lat,dep);
  d=smin(d,roundBox(vec3(ac.x,down-177.,ac.y),vec3(s.z+.043*max(down,0.),194,76),6.5),4.);
 }
 d=smin(d,buttress(p,vec4(1473,166,.69,-163),57.,197.),3.);
 d=smin(d,buttress(p,vec4(1414,83,.35,-127),48.,236.),3.);
 d=smin(d,buttress(p,vec4(1160,251,.46,-86),29.,90.),3.);
 float top=roof(p.x);
 float shoulder=.23+.24*smoothstep(20.,125.,abs(p.x-1450.));
 d=max(d,(top+shoulder*max(-p.z,0.)+.61*max(p.z,0.)-p.y)*.72);
 for(int i=0;i<3;i++){
  vec4 s=i==0?vec4(1479,99,9,48):i==1?vec4(1352,187,8,110):vec4(1209,272,15,114);
  float dy=p.y-s.y,a=p.x-s.x+.37*dy;
  d=max(d,-max(max(abs(a)-s.z+.075*dy,-.8*dy),max(dy-s.w,p.z+56.+.60*abs(a)-.24*dy)));}
 for(int i=0;i<4;i++){
  vec4 s=i==0?vec4(1602,183,95,13):i==1?vec4(1618,231,116,21):i==2?vec4(1630,268,87,18):vec4(1490,130,38,8);
  float dx=p.x-s.x,span=max(0.,1.-dx*dx/(s.z*s.z)),bed=p.y-s.y-.33*dx-2.1*sin(.032*dx);
  d=max(d,-max(max(-bed-6.5*span,bed+.36*(p.z+90.)),max(abs(dx)-s.z,p.z+20.-s.w*span+.09*dx)));}
 // A deposition slope shared by the gullies. Its crest sits inside
 // the cliff, so the debris has no free-standing conical summits.
 float slopeRun=-p.z-108.;
 float crossRun=p.x+.31*p.z;
 float drainage=noise3(vec3(crossRun*.023,p.z*.012,3.));
 float gravel=noise3(vec3(crossRun*.078,p.z*.038,7.));
 float apronY=353.-.065*(p.x-1190.)+.49*sqrt(slopeRun*slopeRun+180.)+.47*max(1130.-p.x,0.)+.39*max(p.x-1400.,0.)+
              10.*(drainage-.5)+3.8*(gravel-.5);
 float tal=max((apronY-p.y)*.79,max((1040.-p.x)*.59,(p.x-1540.)*.61));
 tal=max(tal,max(-p.z-317.,p.z-168.));
 d=smin(d,tal,7.);
 // A forestable bedrock spur grades into the west talus.
 vec3 spur=(p-vec3(1127.,402.,-130.))/vec3(128.,39.,82.);
 float shoulderFoot=(length(spur)-1.)*38.+4.*noise3(p*.035);
 d=smin(d,shoulderFoot,6.);
 if(abs(d)<10. && p.y>top+2. && tal>2.){
  vec2 f=facets(p,24.),g=facets(p,8.);
  float fault=abs(noise3(vec3(.037*p.x+.014*p.y,.020*p.y,.033*p.z))-.48);
  float relief=4.2*f.x+1.15*g.x+.62*exp(-f.y*f.y*.36)+6.8*fault;
  d+=smoothstep(2.,15.,p.y-top)*smoothstep(2.,14.,tal)*relief;}
 return d;
}
    float sd(vec3 p){return rockField(p);}
    vec3 gradient(vec3 p,float e){vec2 h=vec2(e,0);return vec3(sd(p+h.xyy)-sd(p-h.xyy),sd(p+h.yxy)-sd(p-h.yxy),sd(p+h.yyx)-sd(p-h.yyx));}
    float hash(vec3 p){p=fract(p*.1031);p+=dot(p,p.yzx+33.33);return fract((p.x+p.y)*p.z);}
    float noise3(vec3 p){vec3 i=floor(p),f=fract(p);f=f*f*(3.-2.*f);
      return mix(mix(mix(hash(i),hash(i+vec3(1,0,0)),f.x),mix(hash(i+vec3(0,1,0)),hash(i+vec3(1,1,0)),f.x),f.y),
      mix(mix(hash(i+vec3(0,0,1)),hash(i+vec3(1,0,1)),f.x),mix(hash(i+vec3(0,1,1)),hash(i+1.),f.x),f.y),f.z);}
    float softShadow(vec3 p,vec3 n,vec3 light){
      vec3 ray=localDir(light);vec3 start=p+localDir(n)*2.4;float t=3.,v=1.;
      for(int i=0;i<24;i++){float h=sd(start+ray*t);v=min(v,5.*max(h,0.)/t);if(h<-.6||t>100.)break;t+=clamp(h*.72,2.,17.);}
      return smoothstep(0.,1.,v);}
    float lineDistance(vec2 p,vec2 a,vec2 b){vec2 d=b-a;return length(p-a-d*clamp(dot(p-a,d)/dot(d,d),0.,1.));}

bool intersectRock(vec3 eye,vec3 ray,out vec3 p,out vec3 wp){      vec3 localEye=vec3(datum,0.)+localDir(eye-position)/unit;
      vec3 dir=localDir(ray);
      vec3 inv=1./(sign(dir+1.e-9)*max(abs(dir),vec3(1.e-7)));
      vec3 a=(origin-localEye)*inv,b=(dims-localEye)*inv;
      vec3 nearT=min(a,b),farT=max(a,b);
      float t=max(0.,max(nearT.x,max(nearT.y,nearT.z))),end=min(farT.x,min(farT.y,farT.z));
      if(t>=end)return false;
      bool hit=false;p=vec3(0.);
      for(int i=0;i<155;i++){p=localEye+dir*t;float d=sd(p);if(d<.14){hit=true;break;}t+=max(.12,d*.66);if(t>end)break;}
      if(!hit)return false;
      wp=world(p);return true;
}

// Four adjacent, procedurally evaluated elevation samples share one texel.
float elevationNode(ivec2 node){
    node=clamp(node,ivec2(0),ivec2(1536));
    vec4 values=texelFetch(iChannel0,node/2,0);
    return values[(node.y%2)*2+node.x%2];
}
vec2 elevationComponents(ivec2 node){
    float units=(elevationNode(node)+48.)*128.;
    return vec2(floor(units/256.),mod(units,256.));
}
float bed(vec2 world){
    vec2 at=(world+vec2(1100,40))/vec2(2200,1800)*1537.-.5;
    ivec2 i=ivec2(floor(at));
    // Match fixed-point bilinear filtering of the approved renderer's procedural elevation target.
    vec2 f=floor(fract(at)*256.+.5)/256.;
    vec2 value=mix(mix(elevationComponents(i),elevationComponents(i+ivec2(1,0)),f.x),
                   mix(elevationComponents(i+ivec2(0,1)),elevationComponents(i+ivec2(1)),f.x),f.y);
    return dot(floor(value*16.+.5)/16.,vec2(256,1))/128.-48.;
}
vec2 rockSurvey(vec2 world){
    vec2 local=world-vec2(-100,320);
    if(any(lessThan(local,vec2(0)))||any(greaterThanEqual(local,vec2(1024,768))))return vec2(0);
    vec2 texel=vec2(769,0)+clamp(local,vec2(.5),vec2(1023.5,767.5));
    return textureLod(iChannel0,texel/iChannelResolution[0].xy,0.).rg;
}
float cap(vec2 world){return rockSurvey(world).x;}
float mantle(vec2 world,float h){return rockSurvey(world).y;}

float elevationAt(ivec2 node){
    vec2 world=(vec2(min(node,ivec2(1536)))+.5)/1537.*vec2(2200,1800)-vec2(1100,40);
    return floor(clamp((land(world)+48.)*128.,0.,65535.))/128.-48.;
}
// Every branch vertex uses the same indices and seeds as the approved crown.
struct NeedleVertex { vec3 p; vec4 radial; };
NeedleVertex branchVertex(int id,int rings,int arms,int shoots,int variant) {
 vec3 point;vec4 radial;
 int cell=id/6,k=id%6;ivec2 quad[6]=ivec2[](ivec2(0,0),ivec2(0,1),ivec2(1,0),ivec2(0,1),ivec2(1,1),ivec2(1,0));
 int side=(cell%3+quad[k].y)%3;int seg=(cell/3)%2+quad[k].x;
 int shoot=(cell/6)%shoots,arm=(cell/(6*shoots))%arms,tier=cell/(6*shoots*arms);
 int seed=tier*389+arm*37+variant*9209;float t=(float(tier)+.37)/float(rings);
 float phi=float(tier)*2.39996+(float(arm)+.8*rnd(seed,0))*6.283185/float(arms);
 float len=.17*pow(1.-t,.74)*(.66+.62*rnd(seed,1));float base=.10+.87*t+(.5-rnd(seed,2))*.8/float(rings);
 float start=shoot==0?0.:.17+.39*rnd(seed,7+shoot);
 float ang=phi+(shoot==0?0.:(shoot%2==0?-1.:1.)*(.35+.41*rnd(seed,4+shoot)));
 vec2 d=vec2(cos(ang),sin(ang)),l=vec2(-d.y,d.x);
 float u=float(seg)*.5,reach=len*(1.-start)*(.84+.25*rnd(seed,11+shoot));
 float a=float(side)*2.094395+.7*rnd(seed,19+shoot),span=reach*(shoot==0?.35:.27)*(seg==0?.17:seg==2?.012:1.)*(.75+.50*rnd(seed,side+23));
 vec2 pos=vec2(cos(phi),sin(phi))*start*len+d*reach*u+l*cos(a)*span;
 point=vec3(pos.x,base-len*(.22*start+.3*u+.29*sin(3.14159*u))+sin(a)*span*.71,pos.y);
 vec2 facing=d*.28+l*cos(a);radial=vec4(facing.x,sin(a),facing.y,.18+.56*u+.22*max(0.,sin(a)));
 return NeedleVertex(point,radial);
}

vec4 crownData(int address){
    int shoot=address/18,variant=shoot/790,local=shoot%790;
    int level=local<570?0:local<750?1:2;
    local-=level==0?0:level==1?570:750;
    int vertex=(address%18)/2,segment=vertex/3;
    int id=local*36+(segment==0?0:segment==1?2:20)+(vertex%3)*6;
    NeedleVertex v=branchVertex(id,level==0?19:level==1?12:8,level==0?6:5,level==0?5:level==1?3:1,variant);
    return address%2==0?vec4(v.p,1.):v.radial;
}
void mainImage(out vec4 result,in vec2 pixel){
    ivec2 cell=ivec2(pixel);
    if(iFrame==0 && cell.x<768 && cell.y>=769){
        int address=(cell.y-769)*768+cell.x;
        result=address<3*790*18?crownData(address):vec4(0);return;
    }
    // A shoot's nine vertices are static. Cache their exact local bounds once.
    if(iFrame==1 && cell.x<768 && cell.y>=825 && cell.y<832){
        int slot=(cell.y-825)*768+cell.x;
        if(slot>=2*3*790){result=vec4(0);return;}
        vec3 low=vec3(2),high=vec3(-2);
        for(int j=0;j<9;j++){
            int index=(slot/2)*18+2*j;
            vec3 vertex=texelFetch(iChannel0,ivec2(index%768,769+index/768),0).xyz;
            low=min(low,vertex); high=max(high,vertex);
        }
        result=vec4(slot%2==0?low:high,1);return;
    }
    if(iFrame==1 && cell.x<768 && cell.y>=769){result=texelFetch(iChannel0,cell,0);return;}
    if(iFrame==2 && cell.x>=769 && cell.x<1793 && cell.y>=768){
        int index=(cell.y-768)*1024+cell.x-769;
        if(index<513*369){
            float z=2.+1648.*pow(float(index/513)/368.,1.63);
            float x=(float(index%513)/256.-1.)*(z*.81+35.);
            vec2 q=vec2(x,z),ex=vec2(max(1.4,z*.00085),0.);
            vec2 dx=q-ex,px=q+ex,dz=q-ex.yx,pz=q+ex.yx;
            vec3 normal=normalize(vec3(bed(dx)+rockSurvey(dx).y-bed(px)-rockSurvey(px).y,2.*ex.x,
                                       bed(dz)+rockSurvey(dz).y-bed(pz)-rockSurvey(pz).y));
            result=vec4(bed(q)+rockSurvey(q).y,normal);return;
        }
    }
    if(iFrame>1){result=texelFetch(iChannel0,cell,0);return;}
    if(cell.x<769 && cell.y<769){
        if(iFrame==1){result=texelFetch(iChannel0,cell,0);return;}
        ivec2 base=cell*2;
        result=vec4(elevationAt(base),elevationAt(base+ivec2(1,0)),
                    elevationAt(base+ivec2(0,1)),elevationAt(base+ivec2(1)));return;
    }
    result=vec4(0);
    if(cell.x<769||cell.x>=1793||cell.y>=768)return;
    vec2 world=pixel-vec2(769,0)+vec2(-100,320);
    if(iFrame==0){
        for(int id=0;id<3;id++){
            setRock(id);vec3 p,wp;
            if(intersectRock(vec3(world.x,520.,world.y),vec3(0,-1,0),p,wp))
                result.r=max(result.r,floor(max(wp.y,0.)*64.)/64.);
        }
    }else{
        result.r=texelFetch(iChannel0,cell,0).r;
        float ground=bed(world),debris=0.;
        for(int i=0;i<8;i++)for(int j=0;j<4;j++){
            float a=float(i)*.785398,d=3.*exp2(float(j));
            float wall=cap(world+vec2(cos(a),sin(a))*d);
            debris=max(debris,min(wall,ground+28.)-d*.69-ground);
        }
        result.g=round(clamp(debris/42.5,0.,1.)*255.)*(42.5/255.);
    }
}

#elif VALLEY_PASS == 1
float rnd(int x,int seed){uint h=uint(x)*747796405u+uint(seed)*2891336453u+277803737u;h=((h>>((h>>28u)+4u))^h)*277803737u;return float((h>>22u)^h)/4294967296.;}
float noise2(vec2 p){ivec2 i=ivec2(floor(p));vec2 f=fract(p);f=f*f*(3.-2.*f);return mix(mix(rnd(i.x,i.y),rnd(i.x+1,i.y),f.x),mix(rnd(i.x,i.y+1),rnd(i.x+1,i.y+1),f.x),f.y);}

// Four adjacent, procedurally evaluated elevation samples share one texel.
float elevationNode(ivec2 node){
    node=clamp(node,ivec2(0),ivec2(1536));
    vec4 values=texelFetch(iChannel0,node/2,0);
    return values[(node.y%2)*2+node.x%2];
}
vec2 elevationComponents(ivec2 node){
    float units=(elevationNode(node)+48.)*128.;
    return vec2(floor(units/256.),mod(units,256.));
}
float bed(vec2 world){
    vec2 at=(world+vec2(1100,40))/vec2(2200,1800)*1537.-.5;
    ivec2 i=ivec2(floor(at));
    // Match fixed-point bilinear filtering of the approved renderer's procedural elevation target.
    vec2 f=floor(fract(at)*256.+.5)/256.;
    vec2 value=mix(mix(elevationComponents(i),elevationComponents(i+ivec2(1,0)),f.x),
                   mix(elevationComponents(i+ivec2(0,1)),elevationComponents(i+ivec2(1)),f.x),f.y);
    return dot(floor(value*16.+.5)/16.,vec2(256,1))/128.-48.;
}
vec2 rockSurvey(vec2 world){
    vec2 local=world-vec2(-100,320);
    if(any(lessThan(local,vec2(0)))||any(greaterThanEqual(local,vec2(1024,768))))return vec2(0);
    vec2 texel=vec2(769,0)+clamp(local,vec2(.5),vec2(1023.5,767.5));
    return textureLod(iChannel0,texel/iChannelResolution[0].xy,0.).rg;
}
float cap(vec2 world){return rockSurvey(world).x;}
float mantle(vec2 world,float h){return rockSurvey(world).y;}


float treeHeight(vec4 r){return fract(r.w/32.)*32.;}
int treeStyle(vec4 r){return int(r.w/32.)%8;}
float isLarch(vec4 r){return float(int(r.w/256.)%2);}
int treeLevel(float z){return z<200.?0:z<410.?1:2;}
vec2 tileSize(int level){return level==0?vec2(96,256):level==1?vec2(64,128):vec2(32,64);}
int tileKey(vec2 pix,int level){ivec2 cell=ivec2(floor(pix/tileSize(level)))+ivec2(20,24);return level*65536+clamp(cell.y,0,255)*256+clamp(cell.x,0,255);}
int rootKey(vec4 root,bool mirrorView){if(root.z<=0.)return 999999;
 vec2 xy=vec2(960.+root.x*1404./root.z,464.4+(70.-(mirrorView?-1.:1.)*(root.y+.5*treeHeight(root)))*1404./root.z);
 return tileKey(xy,treeLevel(root.z));}
ivec2 sortAddress(int i,bool mirrorView){int linear=i+(mirrorView?262144:0);return ivec2(linear%int(iResolution.x),linear/int(iResolution.x));}

vec4 grow(int i){if(i>=145049)return vec4(0);
 float z=mix(100.,1150.,rnd(i,1)),x=(2.*rnd(i,2)-1.)*(.71*z+10.);
 float h=mix(7.,21.,rnd(i,3)),chance=rnd(i,4),orange=step(.88,rnd(i,5));bool valid=true;
 if(i>=135000&&i<139000){float u=mix(-30.,580.,rnd(i,6));z=302.;for(int k=0;k<4;k++){x=(u-550.)*z/804.;z=302.+55.*sin(x*.013)+28.*sin(x*.03);}z+=55.*(rnd(i,7)-.62);x=(u-550.)*z/804.;h=mix(5.,14.,rnd(i,8));}
 if(i>=139000&&i<143000){float d=i%2==0?715.:1270.;x=(rnd(i,9)-.5)*d*1.36;z=d+88.*(rnd(i,10)-.5);h=mix(5.,10.,rnd(i,11));}
 if(i>=143000&&i<144700){x=mix(175.,405.,rnd(i,12));z=mix(410.,600.,rnd(i,13));h=mix(6.,12.,rnd(i,8));}
 if(i>=144700&&i<144720){x=mix(112.,129.,rnd(i,1));z=mix(297.,325.,rnd(i,2));orange=1.;}
 if(i>=144720&&i<144730){const vec2 hero[]=vec2[](vec2(301,119),vec2(252,155),vec2(362,130),vec2(479,140),vec2(539,149),vec2(581,155),vec2(612,148),vec2(655,147),vec2(701,137),vec2(743,132));vec2 a=hero[i-144720];z=a.y;x=(a.x-550.)*z/804.;h=i==144720?26.:mix(12.,18.,rnd(i,7));orange=0.;}
 if(i>=144730&&i<145017){
 const vec4 stands[]=vec4[](vec4(-31,115,22,46),vec4(-27,165,20,39),vec4(16,155,12,4),vec4(121,263,21,117),vec4(81,293,15,46),vec4(65,366,10,35));
 int idx=i-144730;vec4 c=stands[0];for(int k=0;k<6;k++){c=stands[k];if(idx<int(c.w))break;idx-=int(c.w);}
 float r=sqrt(-2.*log(max(.00001,rnd(i,43)))),a=6.283185*rnd(i,46);
 x=c.x+c.z*r*cos(a);z=c.y+c.z*.8*r*sin(a);h=mix(12.,27.,rnd(i,45));orange=0.;}
 vec2 p=vec2(x,z);float y=bed(p),rock=cap(p),m=noise2(p*.028),grove=noise2(p*.014+13.);
 if(i<135000){
 valid=y<89.+m*21.&&chance<.09+.60*m*grove&&(y<58.||grove>.48)&&length(vec2(bed(p+vec2(1,0))-y,bed(p+vec2(0,1))-y))<1.;
 float sx=550.+804.*x/z,sy=266.17+(70.-y)*804./z;
 if(sx>470.&&sx<802.&&sy>454.&&z<229.)valid=valid&&rnd(i,14)<.045;
 h*=1.-.29*clamp(y/100.,0.,1.);}
 if(rock>y+2.){valid=i>=143000&&i<144700&&abs(rock-cap(p+vec2(2,0)))<1.7&&abs(rock-cap(p+vec2(0,2)))<1.7&&rnd(i,16)<.47;y=rock;}
 else if(i>=143000&&i<144700)valid=chance<.24;
 vec2 uv=(p-vec2(-100,320))/vec2(1024,768);
 if(all(equal(uv,clamp(uv,0.,1.))))y=max(y,bed(p)+mantle(p,bed(p)));
 if(y<1.6)valid=false;
 float sx=960.+1404.*x/z,sy=464.4+(70.-y)*1404./z;
 if(i<144720&&z<213.&&sy>585.&&sx<1260.&&orange>.5)orange=0.;
 if(z<163.&&abs(sx-518.)<68.&&sy>620.)valid=false;
 if(i<135000&&orange>.5&&rnd(i,23)<.39)orange=0.;
 if(i>=145017){
 // A second, overlapping stand fills the understory behind the hero whorls.
 int j=i-145017;z=mix(90.,101.,rnd(j,66));float frameX=mix(145.,742.,rnd(j,65));
 x=(frameX-960.)*z/1404.;y=bed(vec2(x,z));h=mix(8.,18.,rnd(j,68));orange=0.;valid=y>1.6;
 if(j==0){z=83.5;x=(517.-960.)*z/1404.;y=70.+(464.4-934.)*z/1404.;h=15.;valid=true;}}

 return valid?vec4(x,y-.25,z,h+32.*floor(rnd(i,17)*8.)+256.*orange):vec4(0);}
int group,cols,rows;float floorAt(vec2 p){return bed(p);}
const float PI=3.14159265;
vec3 place(vec2 p,float z){return vec3((p.x-960.)*z/1404.,70.+(464.4-p.y)*z/1404.,z);}
vec3 surface(int i,vec2 uv,out float tag){
 float u=uv.x,v=uv.y,a=2.*PI*u;
 if(group==20){
 // Place granite rubble at the actual zero elevation crossings on each shore.
 float z=mix(181.,434.,rnd(i/2,16));bool east=i%2==0;float l=east?65.:-55.,r=east?265.:75.;
 for(int j=0;j<12;j++){float m=(l+r)*.5;bool dry=floorAt(vec2(m,z))>0.;if(dry==east)r=m;else l=m;}
 float x=.5*(l+r)+mix(-2.,2.,rnd(i,18)),y=floorAt(vec2(x,z)),size=mix(.40,1.36,rnd(i,17));if(abs(y)>6.)size=0.;
 vec3 d=vec3(cos(a)*sin(PI*v),cos(PI*v),sin(a)*sin(PI*v));d=sign(d)*pow(abs(d),vec3(.77));
 tag=-8.;return vec3(x,y-.19,z)+d*size*vec3(1.6,.60,.94)*(1.+.11*noise2(d.xy*4.+float(i)));}
 if(group==0||group==18){
 int tuft=i;if(group==18){i=5+int(rnd(tuft,1)*15.);u=rnd(tuft,2);a=2.*PI*u;v=acos(mix(-.20,1.,rnd(tuft,3)))/PI;}
 const vec4 rocks[]=vec4[](vec4(167,995,128,72),vec4(523,959,125,86),vec4(742,1103,92,83),vec4(1055,1115,211,73),vec4(388,1010,158,68),vec4(362,978,124,73),vec4(434,960,68,63),vec4(642,1030,111,49),vec4(749,1061,112,49),vec4(139,867,82,54),vec4(56,881,99,64),vec4(120,928,61,46),vec4(855,1092,88,41),vec4(24,993,80,39),vec4(125,1098,105,53),vec4(288,1096,113,39),vec4(503,1084,78,41),vec4(243,1022,42,24),vec4(448,1025,37,19),vec4(550,1054,59,25));
 const float depths[]=float[](15.7,16.1,13.1,14.1,15.,14.2,14.7,14.6,14.4,17.1,17.,16.8,14.,13.8,12.7,13.2,13.6,13.8,13.9,14.4);
 vec4 b=rocks[i];float z=depths[i];vec3 dir=vec3(cos(a)*sin(PI*v),cos(PI*v),sin(a)*sin(PI*v));
 bool moss=i>=5;vec3 shape=sign(dir)*pow(abs(dir),vec3(moss?1.:.67));
 float n=noise2(dir.xy*4.+dir.z*3.+float(i));
 shape*=.97+(moss?.035:.09)*n+(moss?.007:.012)*noise2(dir.xy*22.+dir.z*13.);
 shape.y-=moss?0.:.20*shape.x+.12*shape.z;
 vec3 center=place(b.xy,z)+shape*vec3(b.z,b.w,b.z*.67)*z/1404.;tag=moss?12.:11.;
 if(group==18){vec3 n=normalize(dir/vec3(b.z,b.w,b.z*.67));vec3 side=normalize(cross(n,vec3(.01,.97,.18))),up=cross(n,side);
 float angle=rnd(tuft,4)*6.283;float polar=angle+uv.x*6.283;
 float petals=cos(5.*(polar-angle))*.26+.72;
 center+=z/1404.*mix(1.,2.8,rnd(tuft,5))*(n*(1.1-.91*uv.y)+uv.y*petals*(cos(polar)*side+sin(polar)*up));}return center;
 }
 if(group==17){
 // Eight irregular whorls on the spruce nearest the moss shelf.
 int tier=i/(7*20*16),arm=(i/(20*16))%7,fan=(i/16)%20,j=i%16,seed=tier*103+arm*37;
 float f=(float(tier)+.3)/8.,az=float(tier)*2.4+float(arm)*.898+.36*(rnd(seed,5)-.5);
 vec3 d=vec3(cos(az),0,sin(az)),side=vec3(-d.z,0,d.x);
 vec3 origin=mix(place(vec2(518,660),83.),place(vec2(516,929),83.),f);
 float len=(.4+6.05*pow(f,.78))*(.75+.40*rnd(seed,7)),t=(float(fan/2)+1.)/11.;
 vec3 anchor=origin+d*len*(1.16*t-.16*t*t)+vec3(0.,len*(-1.06*t+.75*t*t),0.);
 float twigLen=len*(1.-float(fan/2+1)/15.)*mix(.47,.72,rnd(seed,fan));
 vec3 twig=d*.45+side*(fan%2==0?.72:-.72)+vec3(0.,-.62,0.);
 float along=float(j/2)/8.;vec3 q=anchor+twig*twigLen*along;
 float span=twigLen*(.38-.22*along);
 vec3 dir=twig*.5+d*.33+side*(j%2==0?-.49:.49)+vec3(0,-.18,0);
 vec3 ridge=normalize(cross(dir,vec3(0,1,0)));
 tag=22.125;return q+span*(dir*u+ridge*(v-.5)*.28*sin(PI*u)+vec3(0.,.03*sin(PI*u),0.));
 }
 if(group==19){tag=21.;return place(mix(vec2(516,928),vec2(518,660),u),83.)+vec3((v-.5)*.29*(1.-u),0.,0.);}
 if(group==1){
 float x=mix(-300.,1450.,u);float y=828.+.19*max(x-130.,0.)+.23*max(x-400.,0.)+7.*noise2(vec2(x*.025,1.))+380.*v;
 tag=10.;return place(vec2(x,y),mix(19.1,10.6,v));}
 if(group==2){
 float y=mix(-190.,915.,v),z=i==0?18.6:34.,base=i==0?15.+.014*(480.-y):131.+(800.-y)*.058+5.*sin(y*.011);
 float r=(i==0?70.+33.*v+58.*pow(v,12.):17.+5.*v)*(.96+.035*sin(a*11.+3.*v)+.05*noise2(vec2(9.*cos(a),4.*v+6.*sin(a))));
 tag=19.;return place(vec2(base,y),z)+vec3(cos(a)*r,0.,sin(a)*r)*z/1404.;}
 // Each branch forks into lateral, drooping sprays with individual pointed needles.
 if(group>=3&&group<=5){
 // The branch survey is in the design lens's 1100-unit horizontal frame.
 const vec4 limbs[]=vec4[](vec4(93,-60,384,65),vec4(169,-23,283,18),vec4(9,99,214,223),vec4(12,143,206,201),vec4(7,213,169,322),vec4(3,306,147,370),vec4(22,-17,256,35),vec4(29,44,199,154),vec4(134,-24,335,113),vec4(1117,198,1041,273),vec4(1127,251,1044,322),vec4(1118,337,997,433),vec4(1125,492,990,561),vec4(1118,547,1030,623));
 const float spread[]=float[](1.09,.84,.8,.75,.74,.65,1.21,1.33,1.05,.89,.7,.93,1.12,.82);
 const float depths[]=float[](18.,18.,18.,18.,18.,18.,19.,19.,17.,24.,23.,23.,21.,21.);
 int limb=group==3?i:group==4?i/36:i/(36*15*28),lat=group==4?i%36:(i/(15*28))%36,shoot=(i/28)%15,j=i%28;
 float z=depths[limb];vec4 b=limbs[limb]*1.74545;
 vec3 p0=place(b.xy,z),p1=place(b.zw,z+1.5),d=p1-p0;
 int seed=limb*101+lat;float t=group==3?u:(float(lat/2)+.12+.71*rnd(seed,4))/18.;
 vec3 root=mix(p0,p1,t)+vec3(0.,-.25,.26)*sin(PI*t);
 if(group==3){tag=-.1;return root+vec3(0.,(v-.5)*.08*pow(1.-u,1.7),0.);}
 float side=lat%2==0?-1.:1.;
 float width=1.17*spread[limb]*(.28+.72*pow(max(.0001,sin(PI*t)),.52))*(.6+.45*rnd(seed,3));
 vec3 branch=vec3(d.x*mix(.06,.19,rnd(seed,4))+side*width*.48,width*(side>0.?mix(-.15,.32,rnd(seed,1)):-1.)*mix(.7,1.55,rnd(seed,7)),width*side*.85);
 if(group==4){tag=21.;return root+u*branch+vec3(0.,(v-.5)*.04*(1.-u),0.);}
 vec3 axis=normalize(branch),s=normalize(cross(axis,vec3(0,1,0)));
 float f=(float(shoot)+mix(.05,.92,rnd(seed,shoot+22)))/15.,angle=float(shoot)*2.39996+.96*(rnd(seed,shoot+71)-.5);
 vec3 outDir=s*cos(angle)+cross(axis,s)*sin(angle);float scale=width*.67;
 vec3 spr=(outDir*.56+axis*.71+vec3(0,-.29,0))*scale*(1.-.61*f)*mix(.72,1.22,rnd(seed,shoot+56));
 vec3 az=normalize(spr),tangent=normalize(cross(az,vec3(0,1,0)));
 float g=(float(j)+mix(.07,.93,rnd(i,5)))/28.,phi=float(j)*2.39996+mix(-.47,.47,rnd(i,9));
 vec3 rad=tangent*cos(phi)+cross(az,tangent)*sin(phi);
 vec3 tip=(rad*.57+az*.65+vec3(0,-.16,0))*scale*mix(.21,.48,rnd(i,4))*(1.-.5*g);
 tag=.15+.29*f;return root+branch*f+spr*g+tip*u+cross(az,rad)*max(.006,scale*.017)*(1.-.37*g)*(2.*v-1.)*sin(PI*u);
 }
 if(group==6||group==7||group==13||group==14){
 bool close=group>=13;bool spine=group==7||group==14;
 int fr=spine?i:i/36,leaf=i%36;
 const vec2 starts[]=vec2[](vec2(275,895),vec2(405,893),vec2(843,1013),vec2(34,1119));
 int cluster=close?3:fr/7;int arm=fr%7;vec2 o=starts[cluster];
 float angle=mix(-2.95,-.20,(float(arm)+.4*rnd(fr,2))/7.);
 vec2 extent=vec2(cos(angle),sin(angle))*(cluster==3?245.:cluster==0?90.:46.)*(.66+.54*rnd(fr,7));
 float t=spine?u:(float(leaf/2)+.7)/19.;vec2 p=o+extent*t+vec2(0.,.42*abs(extent.x)*t*t-22.*t*(1.-t));
 if(spine)p.x+=(v-.5)*1.8;else{float side=leaf%2==0?-1.:1.;vec2 d=normalize(extent);
 float w=(cluster==3?49.:cluster==0?18.:9.)*(.22+.78*sin(PI*pow(t,.8)))*(.70+.48*rnd(i,2));
 vec2 dir=normalize(d*.52+side*vec2(-d.y,d.x));p+=w*(dir*u+vec2(-dir.y,dir.x)*(v-.5)*.37*sin(u*PI));}
 tag=close?25.125:13.125;return place(p,(close?7.1:15.35)+.08*t+.05*u);}
 if(group==8||group==9){
 bool stem=group==9;int flower=stem?i:i/9;vec2 o=flower==0?vec2(371,981):vec2(422,988);
 vec2 p;if(stem)p=o+vec2(-8.*sin(PI*u)+3.*u+(v-.5)*1.9,111.*u);
 else{float theta=6.283*float(i%9)/9.;p=o+vec2(cos(theta)*12.*u+(v-.5)*8.*sin(PI*u),4.*sin(theta)*u-11.*u*u);}
 if(!stem){float theta=6.283*float(i%9)/9.;p=o+vec2(cos(theta)*(4.+10.*u)+(v-.5)*10.*sin(PI*u),3.*sin(theta)*(1.+u)-7.*u*u+(v-.5)*4.*sin(PI*u));}tag=stem?16.125:18.125;return place(p,12.8+.05*float(flower)+.03*u);}
 if(group==10){
 int cl=i/3;vec2 o=cl<4?vec2(284,1060):cl<8?vec2(467,1060):vec2(72,908);
 o+=vec2(rnd(cl,2)-.5,rnd(cl,4)-.5)*(cl<8?49.:99.);
 float phi=float(i%3)*2.0944+5.*rnd(cl,7);vec2 dir=vec2(cos(phi),sin(phi)*.63);float w=cl<8?24.:39.;
 vec2 p=o+dir*u*w+vec2(-dir.y,dir.x)*(v-.5)*w*pow(max(0.,sin(PI*u)),.58);
 tag=14.125;return place(p,12.5+.05*float(cl)+.08*sin(u*PI));}
 if(group==11){vec2 o=i==0?vec2(506,988):vec2(592,1030);vec2 p=o+vec2(64.*u,31.*u+6.*sin(PI*u)+(v-.5)*19.*sin(PI*u));tag=15.125;return place(p,13.4+.05*abs(v-.5)+.11*sin(u*PI));}
 if(group==12){int cl=i/20;vec2 o=cl==0?vec2(643,956):cl==1?vec2(974,1067):vec2(150,871);
 float a=mix(-2.98,-.17,rnd(i,2));float len=mix(17.,62.,rnd(i,5));vec2 p=o+len*vec2(cos(a)*u,sin(a)*u+.19*u*u)+vec2((v-.5)*(1.-u)*3.2,0.);
 tag=20.125;return place(p,cl==2?16.6:13.7);}
 // Arching main stem, six lateral pedicels and their amber seed heads.
 vec2 o=vec2(149,871),d=vec2(40,-123);float t=group==15&&i==0?u:.58+.068*float(group==16?i:i-1);
 vec2 p=o+d*t+vec2(10.*sin(t*PI),0.);float f=i%2==0?-1.:1.;
 if(group==15){if(i>0)p+=vec2(f*17.,-11.)*u;p.x+=(v-.5)*1.7;tag=16.125;}
 else{p+=vec2(-f*17.,-11.)+vec2(cos(a)*sin(PI*v),cos(PI*v))*4.8;tag=17.125;}
 return place(p,16.3+.06*v);}
const int patchCount=274267;
void unpackPatch(int id,out int inst,out ivec2 cell,out ivec2 span){
 if(id<4800){group=0;cols=60;rows=36;int ix=id-0;inst=ix/240;span=ivec2(3,3);cell=ivec2(ix%20,(ix/20)%12)*span;return;}
 if(id<5000){group=1;cols=100;rows=4;int ix=id-4800;inst=ix/200;span=ivec2(2,1);cell=ivec2(ix%50,(ix/50)%4)*span;return;}
 if(id<6200){group=2;cols=48;rows=50;int ix=id-5000;inst=ix/600;span=ivec2(2,2);cell=ivec2(ix%24,(ix/24)%25)*span;return;}
 if(id<6424){group=3;cols=32;rows=1;int ix=id-6200;inst=ix/16;span=ivec2(2,1);cell=ivec2(ix%16,(ix/16)%1)*span;return;}
 if(id<7432){group=4;cols=6;rows=1;int ix=id-6424;inst=ix/2;span=ivec2(3,1);cell=ivec2(ix%2,(ix/2)%1)*span;return;}
 if(id<219112){group=5;cols=2;rows=1;int ix=id-7432;inst=ix/1;span=ivec2(2,1);cell=ivec2(ix%1,(ix/1)%1)*span;return;}
 if(id<219868){group=6;cols=4;rows=2;int ix=id-219112;inst=ix/1;span=ivec2(4,2);cell=ivec2(ix%1,(ix/1)%1)*span;return;}
 if(id<219973){group=7;cols=15;rows=1;int ix=id-219868;inst=ix/5;span=ivec2(3,1);cell=ivec2(ix%5,(ix/5)%1)*span;return;}
 if(id<220009){group=8;cols=6;rows=3;int ix=id-219973;inst=ix/2;span=ivec2(3,3);cell=ivec2(ix%2,(ix/2)%1)*span;return;}
 if(id<220017){group=9;cols=12;rows=1;int ix=id-220009;inst=ix/4;span=ivec2(3,1);cell=ivec2(ix%4,(ix/4)%1)*span;return;}
 if(id<220101){group=10;cols=10;rows=5;int ix=id-220017;inst=ix/2;span=ivec2(5,5);cell=ivec2(ix%2,(ix/2)%1)*span;return;}
 if(id<220105){group=11;cols=14;rows=5;int ix=id-220101;inst=ix/2;span=ivec2(7,5);cell=ivec2(ix%2,(ix/2)%1)*span;return;}
 if(id<220225){group=12;cols=8;rows=1;int ix=id-220105;inst=ix/2;span=ivec2(4,1);cell=ivec2(ix%2,(ix/2)%1)*span;return;}
 if(id<220729){group=13;cols=6;rows=2;int ix=id-220225;inst=ix/2;span=ivec2(3,2);cell=ivec2(ix%2,(ix/2)%1)*span;return;}
 if(id<220764){group=14;cols=15;rows=1;int ix=id-220729;inst=ix/5;span=ivec2(3,1);cell=ivec2(ix%5,(ix/5)%1)*span;return;}
 if(id<220785){group=15;cols=12;rows=1;int ix=id-220764;inst=ix/3;span=ivec2(4,1);cell=ivec2(ix%3,(ix/3)%1)*span;return;}
 if(id<220821){group=16;cols=12;rows=8;int ix=id-220785;inst=ix/6;span=ivec2(4,4);cell=ivec2(ix%3,(ix/3)%2)*span;return;}
 if(id<238741){group=17;cols=3;rows=2;int ix=id-220821;inst=ix/1;span=ivec2(3,2);cell=ivec2(ix%1,(ix/1)%1)*span;return;}
 if(id<270741){group=18;cols=10;rows=1;int ix=id-238741;inst=ix/1;span=ivec2(10,1);cell=ivec2(ix%1,(ix/1)%1)*span;return;}
 if(id<270747){group=19;cols=12;rows=1;int ix=id-270741;inst=ix/6;span=ivec2(2,1);cell=ivec2(ix%6,(ix/6)%1)*span;return;}
 if(id<274267){group=20;cols=10;rows=6;int ix=id-270747;inst=ix/4;span=ivec2(5,3);cell=ivec2(ix%2,(ix/2)%2)*span;return;}
 inst=0;cell=ivec2(0);span=ivec2(1);}

vec2 originalProjection(vec3 p){return vec2(960.,464.4)+vec2(p.x,-(p.y-70.))*1404./p.z;}
int depthBand(float z){return z<9.?0:z<15.8?1:z<20.?2:z<28.?3:z<48.?4:z<120.?5:6;}
float bandDepth(int band){return band==0?7.1:band==1?14.3:band==2?18.:band==3?23.:band==4?34.:band==5?83.:320.;}
int patchKey(vec4 r){if(r.z<.1)return 16777200;int lvl=int(r.w/524288.);
 float tile=16.*exp2(float(lvl));ivec2 xy=ivec2(floor(r.xy/tile))+ivec2(48);return ((depthBand(r.z)*5+lvl)*256+clamp(xy.y,0,255))*256+clamp(xy.x,0,255);}
ivec2 patchAddress(int idx,int width){int i=524288+idx;return ivec2(i%width,i/width);}
// Invert the camera projection at the depth used by the lookup grid. The
// swept bounds include both extrema of the truck, so the same bins work in motion.
vec2 sweptPoint(vec3 p,float basis,float camera){
    float z=p.z+.09*camera;
    vec2 ray=vec2(p.x-camera,70.+.035*camera-p.y)/z;
    return vec2(960.,464.4)+1404.*(ray*(basis+.09*camera)+vec2(camera,-.035*camera))/basis;
}
vec4 boundPatch(int idx){
 if(idx>=patchCount)return vec4(0);
 int inst;ivec2 cell,span;unpackPatch(idx,inst,cell,span);float tag;
 vec2 lo=vec2(1.e8),hi=-lo;vec3 center=surface(inst,(vec2(cell)+.5*vec2(span))/vec2(cols,rows),tag);
 // Bounds include every vertex in the patch rather than assuming a straight sprig.
 for(int y=0;y<=span.y;y++)for(int x=0;x<=span.x;x++){
 vec3 wp=surface(inst,vec2(cell+ivec2(x,y))/vec2(cols,rows),tag);
 float basis=bandDepth(depthBand(center.z));
 vec2 a=sweptPoint(wp,basis,-1.84),b=sweptPoint(wp,basis,.80);
 vec2 q=originalProjection(wp);lo=min(lo,min(q,min(a,b)));hi=max(hi,max(q,max(a,b)));}
 vec2 q=(hi+lo)*.5;
 if(q.x< -455.||q.x>2320.||q.y< -65.||q.y>1230.)return vec4(0);
 float radius=max(hi.x-lo.x,hi.y-lo.y)*.5;
 int lvl=int(clamp(ceil(log2(max(1.,(radius+4.)/14.))),0.,4.));
 return vec4(q,center.z,float(idx+524288*lvl));}

void sortPatches(out vec4 root,int idx,ivec2 at){
 if(iFrame<=1){root=boundPatch(idx);return;}
 vec4 a=texelFetch(iChannel1,at,0);if(iFrame>191){root=a;return;}
 int stepN=iFrame-2,stage=1;for(int k=1;k<=19;k++){if(stepN<k){stage=k;break;}stepN-=k;}
 int stride=1<<(stage-1-stepN),other=idx^stride;vec4 b=texelFetch(iChannel1,patchAddress(other,int(iResolution.x)),0);
 int ka=patchKey(a),kb=patchKey(b);bool first=ka<kb||(ka==kb&&a.w<=b.w);
 bool low=((idx&(1<<stage))==0)==((idx&stride)==0);root=low==first?a:b;}
const int worldStart=1048576,canopyStart=1310720;
ivec2 bufferAddress(int i){int width=int(iResolution.x);return ivec2(i%width,i/width);}
int worldCell(ivec2 tile){return tile.y*256+tile.x;}
int worldKey(vec4 r){
    if(r.z<=0.)return 999999;
    return worldCell(ivec2(floor((r.xz+vec2(1100,40))/10.)));
}
void sortWorld(out vec4 root,int idx,ivec2 at){
    if(iFrame<=1){root=grow(idx);return;}
    vec4 a=texelFetch(iChannel1,at,0);
    if(iFrame>172){root=a;return;}
    int stepN=iFrame-2,stage=1;
    for(int k=1;k<=18;k++){if(stepN<k){stage=k;break;}stepN-=k;}
    int stride=1<<(stage-1-stepN);
    vec4 b=texelFetch(iChannel1,bufferAddress(worldStart+(idx^stride)),0);
    int ka=worldKey(a),kb=worldKey(b);
    bool first=ka<kb||(ka==kb&&(a.z<b.z||(a.z==b.z&&a.x<=b.x)));
    bool low=((idx&(1<<stage))==0)==((idx&stride)==0);
    root=low==first?a:b;
}
int worldBucket(int key){
    int lo=0,hi=262144;
    for(int j=0;j<19;j++){if(lo>=hi)break;int mid=(lo+hi)/2;
        if(worldKey(texelFetch(iChannel1,bufferAddress(worldStart+mid),0))<key)lo=mid+1;else hi=mid;
    }
    return lo;
}
vec4 crownHeights(int index){
    ivec2 grid=2*ivec2(index%769,index/769);
    vec2 spacing=vec2(2200,1800)/1537.;
    vec2 center=(vec2(grid)+1.)*spacing-vec2(1100,40);
    if(center.y<70.||center.y>1330.||abs(center.x)>center.y*.73+35.)return vec4(0);
    ivec2 lo=ivec2(floor((center+vec2(1100,40)-6.)/10.));
    ivec2 hi=ivec2(floor((center+vec2(1100,40)+6.)/10.));
    vec4 result=vec4(0);
    for(int y=lo.y;y<=hi.y;y++)for(int x=lo.x;x<=hi.x;x++){
        int key=worldCell(ivec2(x,y)),start=worldBucket(key);
        for(int j=0;j<256;j++){
            if(start+j>=262144)break;
            vec4 root=texelFetch(iChannel1,bufferAddress(worldStart+start+j),0);
            if(worldKey(root)!=key)break;
            float h=treeHeight(root),diameter=max(1.,h*.24);
            vec2 d=(center-root.xz)/spacing;
            for(int k=0;k<4;k++){
                vec2 at=d+vec2(k%2,k/2)-.5;
                result[k]=max(result[k],h*(1.-2.*length(at)/diameter));
            }
        }
    }
    return round(result*7.)/7.;
}
// Ranges in the two sorted crown arrays, cached after the final sort.
int treeLowerBound(int key,bool mirrorView){
    int low=0,high=262144;
    for(int j=0;j<19 && low<high;j++){
        int mid=(low+high)/2;
        vec4 root=texelFetch(iChannel1,sortAddress(mid,mirrorView),0);
        if(rootKey(root,mirrorView)<key)low=mid+1;else high=mid;
    }
    return low;
}
void mainImage(out vec4 root,in vec2 pixel){ivec2 at=ivec2(pixel);int linear=at.x+at.y*int(iResolution.x);
 const int rangeStart=canopyStart+769*769;
 if(linear>=rangeStart && linear<rangeStart+6*64*64){
    if(iFrame<173){root=vec4(0);return;}
    if(iFrame>173){root=texelFetch(iChannel1,at,0);return;}
    int index=linear-rangeStart, plane=index/4096;
    int key=(plane%3)*65536+((index/64)%64)*256+index%64;
    root=vec4(treeLowerBound(key,plane>=3),treeLowerBound(key+1,plane>=3),0,1);return;
 }
 if(linear>=canopyStart){
    int index=linear-canopyStart;
    if(index>=769*769||iFrame<173){root=vec4(0);return;}
    root=iFrame==173?crownHeights(index):texelFetch(iChannel1,at,0);return;
 }
 if(linear>=worldStart){sortWorld(root,linear-worldStart,at);return;}
 if(linear>=524288){sortPatches(root,linear-524288,at);return;}
 bool mirrored=linear>=262144;int i=linear%262144;
 if(iFrame<=1){root=grow(i);return;}
 vec4 a=texelFetch(iChannel1,at,0);if(iFrame>172){root=a;return;}
 int stepN=iFrame-2,stage=1;for(int k=1;k<=18;k++){if(stepN<k){stage=k;break;}stepN-=k;}
 int stride=1<<(stage-1-stepN),other=i^stride;
 vec4 b=texelFetch(iChannel1,sortAddress(other,mirrored),0);
 int ka=rootKey(a,mirrored),kb=rootKey(b,mirrored);
 bool first=ka<kb||(ka==kb&&(a.z<b.z||(a.z==b.z&&a.x<=b.x)));
 bool low=((i&(1<<stage))==0)==((i&stride)==0);
 root=low==first?a:b;}

#elif VALLEY_PASS == 2
float rnd(int x,int seed){uint h=uint(x)*747796405u+uint(seed)*2891336453u+277803737u;h=((h>>((h>>28u)+4u))^h)*277803737u;return float((h>>22u)^h)/4294967296.;}
float noise2(vec2 p){ivec2 i=ivec2(floor(p));vec2 f=fract(p);f=f*f*(3.-2.*f);return mix(mix(rnd(i.x,i.y),rnd(i.x+1,i.y),f.x),mix(rnd(i.x,i.y+1),rnd(i.x+1,i.y+1),f.x),f.y);}

struct TreeView {int rings;int arms;int shoots;int variant;float rotation;float orange;float aspect;float tilt;};
TreeView design(int lod,int variant,float angle,float orange,float aspect,float tilt){
 return TreeView(lod==0?19:lod==1?12:8,lod==0?6:5,lod==0?5:lod==1?3:1,variant,angle,orange,aspect,tilt);
}
struct SampleVertex{vec3 pos;vec3 normal;float exposure;float sunSide;vec3 local;};
vec2 rayShear;float treeBend;
SampleVertex projectSpray(int id,TreeView v){
 int address=18*(790*v.variant+(v.rings==19?0:v.rings==12?570:750))+2*id;
 ivec2 at=ivec2(address%768,769+address/768);
 vec3 point=texelFetch(iChannel2,at,0).xyz;
 vec4 radial=texelFetch(iChannel2,at+ivec2(1,0),0);
 float a=v.rotation;mat2 rot=mat2(cos(a),sin(a),-sin(a),cos(a));
 vec2 offset=rot*point.xz;
 float sunSide=smoothstep(-.14,.91,dot(normalize(offset+vec2(.0001)),normalize(vec2(-.94*.329*3.1,.42))));
 offset*=v.aspect*(1.+.22*v.orange);
 vec2 rn=rot*radial.xz;vec3 n=normalize(vec3(rn.x,radial.y+.04,rn.y));
 vec3 local=vec3(offset.x+treeBend*point.y*point.y,point.y,offset.y);
 return SampleVertex(vec3(local.xy-rayShear*offset.y,offset.y),n,radial.w,sunSide,local);
}
float cross2(vec2 a,vec2 b){return a.x*b.y-a.y*b.x;}
struct CrownHit {float depth;vec3 normal;float exposure;float sunSide;vec3 local;};
void hitTriangle(vec2 pixel, SampleVertex a, SampleVertex b, SampleVertex c,inout CrownHit hit){
 vec2 e=b.pos.xy-a.pos.xy,f=c.pos.xy-a.pos.xy,q=pixel-a.pos.xy;
 float area=cross2(e,f);if(abs(area)<1.e-11)return;
 vec3 w;w.y=cross2(q,f)/area;w.z=cross2(e,q)/area;w.x=1.-w.y-w.z;
 if(min(w.x,min(w.y,w.z))<0.)return;
 float z=dot(w,vec3(a.pos.z,b.pos.z,c.pos.z));if(z>=hit.depth)return;
 hit=CrownHit(z,a.normal*w.x+b.normal*w.y+c.normal*w.z,
 dot(w,vec3(a.exposure,b.exposure,c.exposure)),dot(w,vec3(a.sunSide,b.sunSide,c.sunSide)),
 a.local*w.x+b.local*w.y+c.local*w.z);
}
// Bound the rotated, sheared shoot in screen space. Wind contributes
// at most |bend| * max(y*y). Keep a float-rounding margin at the edges.
bool outsideShoot(vec2 pixel, int index, TreeView v){
    int slot=index*2;
    ivec2 at=ivec2(slot%768,825+slot/768);
    vec3 low=texelFetch(iChannel2,at,0).xyz;
    vec3 high=texelFetch(iChannel2,at+ivec2(1,0),0).xyz;
    vec3 center=(low+high)*.5, halfSize=(high-low)*.5;
    float sn=sin(v.rotation), cs=cos(v.rotation);
    float scale=v.aspect*(1.+.22*v.orange);
    vec2 xAxis=scale*(vec2(cs,-sn)-rayShear.x*vec2(sn,cs));
    vec2 yAxis=-scale*rayShear.y*vec2(sn,cs);
    vec2 mid=vec2(dot(xAxis,center.xz),center.y+dot(yAxis,center.xz));
    vec2 radius=vec2(dot(abs(xAxis),halfSize.xz),halfSize.y+dot(abs(yAxis),halfSize.xz));
    radius.x+=abs(treeBend)*max(low.y*low.y,high.y*high.y);
    return any(greaterThan(abs(pixel-mid),radius+vec2(.00002)));
}
bool hitCrown(vec2 pixel,TreeView v,out CrownHit hit){
 hit=CrownHit(2.,vec3(0),0.,0.,vec3(0));
 if(pixel.y<-.12||pixel.y>1.05||abs(pixel.x)>.40)return false;
 for(int tier=0;tier<19;tier++){
 if(tier>=v.rings)break;
 float t=(float(tier)+.37)/float(v.rings),axis=.10+.87*t;
 float maxReach=.17*pow(1.-t,.74)*1.28;
 if(abs(pixel.x)>maxReach*2.2 || pixel.y>axis+.41/float(v.rings)+maxReach*(.45+.5*abs(v.tilt))
 ||pixel.y<axis-.41/float(v.rings)-maxReach*(.98+1.7*abs(v.tilt)))continue;
 for(int arm=0;arm<6;arm++){if(arm>=v.arms)break;
 for(int shoot=0;shoot<5;shoot++){if(shoot>=v.shoots)break;
 int start=((tier*v.arms+arm)*v.shoots+shoot)*36;
 int index=790*v.variant+(v.rings==19?0:v.rings==12?570:750)+start/36;
 if(outsideShoot(pixel,index,v))continue;
 // Nine unique vertices per tapered shoot. Test its projected box first.
 SampleVertex verts[9];vec2 lo=vec2(9),hi=vec2(-9);
 for(int j=0;j<3;j++)for(int k=0;k<3;k++){
 int id=start/36*9+j*3+k;
 SampleVertex pt=projectSpray(id,v);verts[3*j+k]=pt;
 lo=min(lo,pt.pos.xy);hi=max(hi,pt.pos.xy);}
 if(any(lessThan(pixel,lo))||any(greaterThan(pixel,hi)))continue;
 for(int j=0;j<2;j++)for(int k=0;k<3;k++){int a=3*j+k,b=3*j+(k+1)%3;
 hitTriangle(pixel,verts[a],verts[b],verts[a+3],hit);hitTriangle(pixel,verts[b],verts[b+3],verts[a+3],hit);}
 }}}
 return hit.depth<1.;
}


// Library code below is bundled from shader-skills (MIT): https://github.com/gokayfem/shader-skills
// ---- shader-skills library: common ----
const float PI  = 3.14159265358979;
const float TAU = 6.28318530717959;

// ---- shader-skills library: hash ----
// PCG-style 1D integer hash.
uint pcgHash(uint v) {
    uint state = v * 747796405u + 2891336453u;
    uint word = ((state >> ((state >> 28u) + 4u)) ^ state) * 277803737u;
    return (word >> 22u) ^ word;
}
// 3D integer hash, three decorrelated outputs.
uvec3 pcg3d(uvec3 v) {
    v = v * 1664525u + 1013904223u;
    v.x += v.y * v.z;
    v.y += v.z * v.x;
    v.z += v.x * v.y;
    v ^= v >> 16u;
    v.x += v.y * v.z;
    v.y += v.z * v.x;
    v.z += v.x * v.y;
    return v;
}
// Map a uint to [0,1) using the top 24 bits, so the result can never round up to 1.0.
float uintToUnit(uint h) { return float(h >> 8u) * (1.0 / 16777216.0); }
vec2 uintToUnit(uvec2 h) { return vec2(h >> 8u) * (1.0 / 16777216.0); }
vec3 uintToUnit(uvec3 h) { return vec3(h >> 8u) * (1.0 / 16777216.0); }
vec4 uintToUnit(uvec4 h) { return vec4(h >> 8u) * (1.0 / 16777216.0); }
// Random float in [0,1) for an integer-valued 2D input.
float hash12(vec2 p) {
    uvec2 q = uvec2(ivec2(floor(p)));
    return uintToUnit(pcgHash(q.x + pcgHash(q.y)));
}
// Random vec3 in [0,1)^3 for an integer-valued 3D input.
vec3 hash33(vec3 p) { return uintToUnit(pcg3d(uvec3(ivec3(floor(p))))); }

// ---- shader-skills library: noise ----
// Quintic fade 6t^5 - 15t^4 + 10t^3: C2-continuous interpolation weights for lattice noise.
vec2 quinticFade(vec2 f) { return f * f * f * (f * (f * 6.0 - 15.0) + 10.0); }
vec3 quinticFade(vec3 f) { return f * f * f * (f * (f * 6.0 - 15.0) + 10.0); }
// Derivative of quinticFade: 30 t^2 (t - 1)^2.
vec2 quinticFadeDeriv(vec2 f) { return 30.0 * f * f * (f * (f - 2.0) + 1.0); }
vec3 quinticFadeDeriv(vec3 f) { return 30.0 * f * f * (f * (f - 2.0) + 1.0); }
// Unit gradient for a 2D lattice point.
vec2 latticeGradient(vec2 cell) {
    float a = TAU * hash12(cell);
    return vec2(cos(a), sin(a));
}
// 2D gradient (Perlin-style) noise with analytic derivatives. Returns vec3(value, d/dx, d/dy). Gradient noise has less grid-aligned blockiness than value noise. Prefer it for fBm.
vec3 gradientNoiseD(vec2 p) {
    vec2 i = floor(p), f = fract(p);
    vec2 u = quinticFade(f), du = quinticFadeDeriv(f);
    vec2 ga = latticeGradient(i);
    vec2 gb = latticeGradient(i + vec2(1.0, 0.0));
    vec2 gc = latticeGradient(i + vec2(0.0, 1.0));
    vec2 gd = latticeGradient(i + vec2(1.0, 1.0));
    float va = dot(ga, f);
    float vb = dot(gb, f - vec2(1.0, 0.0));
    float vc = dot(gc, f - vec2(0.0, 1.0));
    float vd = dot(gd, f - vec2(1.0, 1.0));
    float k = va - vb - vc + vd;
    float value = va + u.x * (vb - va) + u.y * (vc - va) + u.x * u.y * k;
    vec2 deriv = ga + u.x * (gb - ga) + u.y * (gc - ga) + u.x * u.y * (ga - gb - gc + gd)
               + du * (vec2(vb - va, vc - va) + u.yx * k);
    return vec3(value, deriv);
}
// 2D gradient noise.
float gradientNoise(vec2 p) { return gradientNoiseD(p).x; }
// Dot product of a hashed 3D gradient with the offset to its lattice corner.
float latticeGradDot(vec3 cell, vec3 corner, vec3 f) {
    vec3 g = hash33(cell + corner) * 2.0 - 1.0;
    return dot(g, f - corner);
}
// 3D gradient noise.
float gradientNoise(vec3 p) {
    vec3 i = floor(p), f = fract(p);
    vec3 u = quinticFade(f);
    return mix(mix(mix(latticeGradDot(i, vec3(0, 0, 0), f), latticeGradDot(i, vec3(1, 0, 0), f), u.x),
                   mix(latticeGradDot(i, vec3(0, 1, 0), f), latticeGradDot(i, vec3(1, 1, 0), f), u.x), u.y),
               mix(mix(latticeGradDot(i, vec3(0, 0, 1), f), latticeGradDot(i, vec3(1, 0, 1), f), u.x),
                   mix(latticeGradDot(i, vec3(0, 1, 1), f), latticeGradDot(i, vec3(1, 1, 1), f), u.x), u.y), u.z);
}
// 3D gradient noise with analytic derivatives. Returns vec4(value, d/dx, d/dy, d/dz); value equals gradientNoise(p). The trilinear blend is expanded as a polynomial in the fade weights, so the gradient is the same blend of the corner gradients plus the chain-rule term of the fade.
vec4 gradientNoiseD(vec3 p) {
    vec3 i = floor(p), f = fract(p);
    vec3 u = quinticFade(f), du = quinticFadeDeriv(f);
    vec3 g000 = hash33(i) * 2.0 - 1.0;
    vec3 g100 = hash33(i + vec3(1, 0, 0)) * 2.0 - 1.0;
    vec3 g010 = hash33(i + vec3(0, 1, 0)) * 2.0 - 1.0;
    vec3 g110 = hash33(i + vec3(1, 1, 0)) * 2.0 - 1.0;
    vec3 g001 = hash33(i + vec3(0, 0, 1)) * 2.0 - 1.0;
    vec3 g101 = hash33(i + vec3(1, 0, 1)) * 2.0 - 1.0;
    vec3 g011 = hash33(i + vec3(0, 1, 1)) * 2.0 - 1.0;
    vec3 g111 = hash33(i + vec3(1, 1, 1)) * 2.0 - 1.0;
    float v000 = dot(g000, f);
    float v100 = dot(g100, f - vec3(1, 0, 0));
    float v010 = dot(g010, f - vec3(0, 1, 0));
    float v110 = dot(g110, f - vec3(1, 1, 0));
    float v001 = dot(g001, f - vec3(0, 0, 1));
    float v101 = dot(g101, f - vec3(1, 0, 1));
    float v011 = dot(g011, f - vec3(0, 1, 1));
    float v111 = dot(g111, f - vec3(1, 1, 1));
    // value = v000 + kx u.x + ky u.y + kz u.z + kxy u.x u.y + kyz u.y u.z + kzx u.z u.x + kxyz u.x u.y u.z
    float kx = v100 - v000, ky = v010 - v000, kz = v001 - v000;
    float kxy = v000 - v100 - v010 + v110;
    float kyz = v000 - v010 - v001 + v011;
    float kzx = v000 - v100 - v001 + v101;
    float kxyz = -v000 + v100 + v010 - v110 + v001 - v101 - v011 + v111;
    float value = v000 + kx * u.x + ky * u.y + kz * u.z
                + kxy * u.x * u.y + kyz * u.y * u.z + kzx * u.z * u.x + kxyz * u.x * u.y * u.z;
    vec3 grad = g000 + (g100 - g000) * u.x + (g010 - g000) * u.y + (g001 - g000) * u.z
              + (g000 - g100 - g010 + g110) * u.x * u.y
              + (g000 - g010 - g001 + g011) * u.y * u.z
              + (g000 - g100 - g001 + g101) * u.z * u.x
              + (-g000 + g100 + g010 - g110 + g001 - g101 - g011 + g111) * u.x * u.y * u.z
              + du * vec3(kx + kxy * u.y + kzx * u.z + kxyz * u.y * u.z,
                          ky + kxy * u.x + kyz * u.z + kxyz * u.x * u.z,
                          kz + kyz * u.y + kzx * u.x + kxyz * u.x * u.y);
    return vec4(value, grad);
}
const int FBM_MAX_OCTAVES = 12;
// Fractional Brownian motion over 2D gradient noise. Each octave is rotated to hide lattice alignment. persistence 0.5 is the classic look (H = 1). Lower is smoother, higher is rougher.
float fbm(vec2 p, int octaves, float lacunarity, float persistence) {
    const mat2 octaveRotation = mat2(0.8, 0.6, -0.6, 0.8);
    float sum = 0.0, amp = 1.0, norm = 0.0;
    for (int i = 0; i < FBM_MAX_OCTAVES; i++) {
        if (i >= octaves) break;
        sum += amp * gradientNoise(p);
        norm += amp;
        amp *= persistence;
        p = lacunarity * (octaveRotation * p) + vec2(17.13, -3.71);
    }
    return 1.4 * sum / norm;
}
// 2D fBm with the usual defaults (lacunarity 2.01 so octave peaks never re-align, persistence 0.5).
float fbm(vec2 p, int octaves) { return fbm(p, octaves, 2.01, 0.5); }
// fBm over 3D gradient noise.
float fbm(vec3 p, int octaves, float lacunarity, float persistence) {
    const mat3 octaveRotation = mat3(0.00, 0.80, 0.60,
                                     -0.80, 0.36, -0.48,
                                     -0.60, -0.48, 0.64);
    float sum = 0.0, amp = 1.0, norm = 0.0;
    for (int i = 0; i < FBM_MAX_OCTAVES; i++) {
        if (i >= octaves) break;
        sum += amp * gradientNoise(p);
        norm += amp;
        amp *= persistence;
        p = lacunarity * (octaveRotation * p) + vec3(17.13, -3.71, 5.29);
    }
    return sum / norm;
}
// Terrain fBm where each octave is damped by the accumulated slope, so detail settles in valleys and steep slopes stay smooth. This gives an eroded look without simulation.
float erodedFbm(vec2 p, int octaves) {
    const mat2 octaveRotation = mat2(0.8, 0.6, -0.6, 0.8);
    float h = 0.0, amp = 0.5;
    vec2 slope = vec2(0.0);
    for (int i = 0; i < FBM_MAX_OCTAVES; i++) {
        if (i >= octaves) break;
        vec3 n = gradientNoiseD(p);
        slope += n.yz;
        h += amp * n.x / (1.0 + dot(slope, slope));
        amp *= 0.5;
        p = 2.0 * (octaveRotation * p);
    }
    return 2.0 * h;
}
// Ridged multifractal: inverted |noise| creates sharp crests; each octave is weighted by the previous one, so detail gathers along ridges.
float ridgedFbm(vec2 p, int octaves) {
    const mat2 octaveRotation = mat2(0.8, 0.6, -0.6, 0.8);
    float sum = 0.0, amp = 0.5, weight = 1.0, norm = 0.0;
    for (int i = 0; i < FBM_MAX_OCTAVES; i++) {
        if (i >= octaves) break;
        float n = 1.0 - abs(gradientNoise(p) * 1.4);
        n *= n;
        sum += amp * n * weight;
        norm += amp;
        weight = clamp(n * 2.0, 0.0, 1.0);
        amp *= 0.5;
        p = 2.01 * (octaveRotation * p) + vec2(17.13, -3.71);
    }
    return sum / norm;
}

// ---- shader-skills library: water ----
// Exact unpolarized dielectric Fresnel for a positive incident cosine and positive refractive indices. Returns 1 for total internal reflection. Caller chooses etaIncident/etaTransmitted for the ray's side.
float fresnelDielectric(float cosIncident, float etaIncident, float etaTransmitted) {
    float ci = clamp(abs(cosIncident),0.0,1.0);
    float ei = max(etaIncident,0.000001), et = max(etaTransmitted,0.000001);
    if (abs(ei-et)<0.0000001) return 0.0;
    float sinT2 = (ei*ei)/(et*et)*max(0.0,1.0-ci*ci);
    if (sinT2>=1.0) return 1.0;
    float ct = sqrt(max(0.0,1.0-sinT2));
    float rs = (ei*ci-et*ct)/max(ei*ci+et*ct,0.000001);
    float rp = (et*ci-ei*ct)/max(et*ci+ei*ct,0.000001);
    return clamp(0.5*(rs*rs+rp*rp),0.0,1.0);
}

// ---- shader-skills library: color ----
// Exact sRGB decode (EOTF): encoded [0,1] -> linear.
vec3 srgbToLinear(vec3 c) {
    c = max(c, 0.0);
    return mix(c / 12.92, pow((c + 0.055) / 1.055, vec3(2.4)), step(0.04045, c));
}
// Exact sRGB encode (OETF): linear -> display [0,1]. Apply exactly once, after tonemapping. pow(c, 1/2.2) is visibly wrong near black (0.001 encodes to 0.013 here vs 0.043 with 2.2).
vec3 linearToSrgb(vec3 c) {
    c = max(c, 0.0);
    return mix(c * 12.92, 1.055 * pow(c, vec3(1.0 / 2.4)) - 0.055, step(0.0031308, c));
}

// ---- shader-skills library: volume ----
// Henyey-Greenstein phase function. g in (-1, 1): > 0 forward (silver linings), < 0 backward.
float phaseHG(float mu, float g) {
    float g2 = g * g;
    return (1.0 - g2) / (4.0 * PI * pow(max(1.0 + g2 - 2.0 * g * mu, 1e-6), 1.5));
}
// Distance fog amount (0 = clear, 1 = fully fogged) for distance t.
float distanceFog(float t, float density) { return 1.0 - exp(-t * density); }
// Analytic height fog for density a * exp(-b * y) along the ray segment [0, t]. Thick near the ground, thin above. Returns the fog amount in [0,1].
float heightFog(vec3 ro, vec3 rd, float t, float a, float b) {
    float base = a * exp(-ro.y * b);
    float amount = (abs(rd.y) < 1e-4) ? base * t
                                       : base * (1.0 - exp(-t * rd.y * b)) / (rd.y * b);
    return 1.0 - exp(-max(amount, 0.0));
}


vec3 shadeCrown(vec3 p,vec3 worldNormal,float exposureValue,float sunSide,float orange,float skyVisibility){
 vec3 c;vec3 sun=normalize(vec3(-.94*.329,.080+.014*.88,1.));
 vec3 sunColor=mix(vec3(.46,.52,.89),vec3(1.52,.83,.42),.88);

        vec3 n=normalize(worldNormal);
        float exposure=clamp(exposureValue,0.,1.);
        float pores=fbm(p.xz*1.4+vec2(p.y*.31,p.y*.72),3);
        float visibleSky=clamp(.51+.36*n.y+.25*exposure+.18*pores,.13,1.);
        float wrap=clamp(.39+.61*dot(n,sun),0.,1.);
        vec3 albedo=srgbToLinear(mix(vec3(.145,.245,.230),vec3(.53,.369,.211),orange));
        float visibility=skyVisibility;
        float skylight=(.28+.73*visibleSky)*(.47+.53*exposure);
        c=albedo*(vec3(.72,.86,1.07)*skylight+sunColor*(.19+.63*sunSide)*wrap*visibility);
        float transmission=smoothstep(.32,.87,exposure)*sunSide*(.24+.76*wrap)*visibility;
        c+=srgbToLinear(mix(vec3(.46,.34,.178),vec3(.66,.482,.283),orange))*transmission;
         c*=.9+.46*pores;return linearToSrgb(c);
}

// Four adjacent, procedurally evaluated elevation samples share one texel.
float elevationNode(ivec2 node){
    node=clamp(node,ivec2(0),ivec2(1536));
    vec4 values=texelFetch(iChannel2,node/2,0);
    return values[(node.y%2)*2+node.x%2];
}
vec2 elevationComponents(ivec2 node){
    float units=(elevationNode(node)+48.)*128.;
    return vec2(floor(units/256.),mod(units,256.));
}
float bed(vec2 world){
    vec2 at=(world+vec2(1100,40))/vec2(2200,1800)*1537.-.5;
    ivec2 i=ivec2(floor(at));
    // Match fixed-point bilinear filtering of the approved renderer's procedural elevation target.
    vec2 f=floor(fract(at)*256.+.5)/256.;
    vec2 value=mix(mix(elevationComponents(i),elevationComponents(i+ivec2(1,0)),f.x),
                   mix(elevationComponents(i+ivec2(0,1)),elevationComponents(i+ivec2(1)),f.x),f.y);
    return dot(floor(value*16.+.5)/16.,vec2(256,1))/128.-48.;
}
vec2 rockSurvey(vec2 world){
    vec2 local=world-vec2(-100,320);
    if(any(lessThan(local,vec2(0)))||any(greaterThanEqual(local,vec2(1024,768))))return vec2(0);
    vec2 texel=vec2(769,0)+clamp(local,vec2(.5),vec2(1023.5,767.5));
    return textureLod(iChannel2,texel/iChannelResolution[2].xy,0.).rg;
}
float cap(vec2 world){return rockSurvey(world).x;}
float mantle(vec2 world,float h){return rockSurvey(world).y;}


float treeHeight(vec4 r){return fract(r.w/32.)*32.;}
int treeStyle(vec4 r){return int(r.w/32.)%8;}
float isLarch(vec4 r){return float(int(r.w/256.)%2);}
int treeLevel(float z){return z<200.?0:z<410.?1:2;}
vec2 tileSize(int level){return level==0?vec2(96,256):level==1?vec2(64,128):vec2(32,64);}
int tileKey(vec2 pix,int level){ivec2 cell=ivec2(floor(pix/tileSize(level)))+ivec2(20,24);return level*65536+clamp(cell.y,0,255)*256+clamp(cell.x,0,255);}
int rootKey(vec4 root,bool mirrorView){if(root.z<=0.)return 999999;
 vec2 xy=vec2(960.+root.x*1404./root.z,464.4+(70.-(mirrorView?-1.:1.)*(root.y+.5*treeHeight(root)))*1404./root.z);
 return tileKey(xy,treeLevel(root.z));}
ivec2 sortAddress(int i,bool mirrorView){int linear=i+(mirrorView?262144:0);return ivec2(linear%int(iChannelResolution[1].x),linear/int(iChannelResolution[1].x));}

const vec4 controls=vec4(-.94,.88,.53,.45);float phase,truck;const int integrated=1,stage=6;const float spacing=.9;
vec3 sunlight(){return normalize(vec3(controls.x*.329,.080+.014*controls.y,1.));}
bool hasGround(){return true;}float baseHeight(vec2 p){return bed(p);}
vec4 contactAt(vec2 p){return vec4(rockSurvey(p),0,1);}
float castVisibility(vec3 p,vec3 sun,bool includeGround){
    if(p.z<215.||p.z>1100.||p.x< -155.||p.x>930.)return 1.;
    float shade=0.;
    for(int i=0;i<16;i++){
        float t=2.8*exp2(float(i)*.48);
        vec3 q=p+sun*t;
        vec4 field=contactAt(q.xz);
        float solid=field.x;
        if(includeGround || field.y>.1)solid=max(solid,baseHeight(q.xz)+field.y);
        float penumbra=.65+t*.032;
        shade=max(shade,smoothstep(-penumbra,penumbra,solid+field.z-q.y-1.9));
    }
    return 1.-.62*shade;
}
vec3 ambientLight(){return mix(vec3(.32,.42,.64),vec3(.42,.48,.54),controls.y);}
vec3 film(vec3 c){return linearToSrgb(clamp(c,0.,1.));}
vec3 key(){return mix(vec3(.46,.52,.89),vec3(1.52,.83,.42),controls.y);}
vec3 airColor(float scatter){
    return srgbToLinear(mix(vec3(.486,.503,.653),vec3(1.,.830,.721),smoothstep(.14,.86,scatter)));
}
float forwardLight(vec3 ray){
    return clamp(phaseHG(dot(ray,sunlight()),.70)/phaseHG(1.,.70),0.,1.);
}
vec3 valleyAir(vec3 c,vec3 worldPos,vec3 cameraPos){
    vec3 delta=worldPos-cameraPos;float z=length(delta);vec3 ray=delta/max(z,.01);
    float forward=forwardLight(ray);
    float ext=(.00012+.0026*pow(forward,2.2))*controls.z*1.8;
    float distanceVeil=distanceFog(z,ext);
    float bank=exp(-abs(worldPos.y-5.)*.20);
    float folds=.61+.38*sin(worldPos.z*.037+.48*gradientNoise(worldPos.xz*.022));
    float low=heightFog(cameraPos,ray,z,.012*controls.z,.078)*(.42+.48*folds);
    float nearFactor=smoothstep(150.,360.,z);
    distanceVeil*=.40+.60*nearFactor;
    float veil=clamp(distanceVeil+.34*bank*folds*controls.z+low,0.,.93);
    // Intersect each view ray with two drifting, shallow ground-mist bands.
    for(int layer=0;layer<2;layer++){
        float h=layer==0?5.1:14.3;
        float t=(cameraPos.y-h)/max(.0001,-ray.y);
        vec3 at=cameraPos+t*ray;
        float reach=exp(-pow((at.z-(layer==0?312.:506.))/(layer==0?65.:82.),2.));
        float field=.72+.40*gradientNoise(at.xz*vec2(.028,.062)+vec2(.32*sin(phase),0.));
        veil+=controls.z*.53*reach*field*smoothstep(t-16.,t+11.,z);
    }
    for(int i=0;i<2;i++){
        float bandZ=i==0?245.:376.;
        float at=(bandZ-cameraPos.z)/max(.01,ray.z);
        vec3 q=cameraPos+ray*at;
        float drift=gradientNoise(vec2(q.x*.026+sin(phase)*.19,bandZ*.038));
        float density=exp(-pow((q.y-3.3-2.8*drift)/(i==0?2.2:3.5),2.));
        veil+=controls.z*.59*density*(.57+.52*drift)*smoothstep(at-12.,at+9.,z);
    }
    veil=min(veil,.94);
    float upperMist=exp(-pow((worldPos.y-49.)/18.,2.))*smoothstep(325.,690.,z);
    veil+=upperMist*.57*controls.z*.87;
    vec3 air=airColor(forward);
    air+=key()*.28*forward*upperMist;
    c=mix(c,air,clamp(veil,0.,.95));
    // Two finite banks lie in successive hollows. Integrate only the length
    // of the viewing ray in front of the surface, so nearer crowns occlude mist.
    float tau=0.;
    for(int i=0;i<2;i++){
        float centre=i==0?485.:745.,halfDepth=i==0?100.:145.;
        float start=max(0.,(centre-halfDepth-cameraPos.z)/max(ray.z,.01));
        float finish=min(z,(centre+halfDepth-cameraPos.z)/max(ray.z,.01));
        if(finish<=start)continue;
        float stepSize=(finish-start)/5.;
        for(int j=0;j<5;j++){
            vec3 q=cameraPos+ray*(start+(float(j)+.5)*stepSize);
            float hills=smoothstep(.06,.23,q.x/max(1.,q.z));
            float wind=gradientNoise(q.xz*.013+vec2(.10*sin(phase),0.));
            float eddy=gradientNoise(q.xz*vec2(.022,.008)+vec2(.16*sin(phase),3.7));
            float sheetHeight=(i==0?74.:108.)+.072*q.x+11.*wind+4.*eddy;
            float altitude=(q.y-sheetHeight)/(i==0?13.:22.);
            float longitudinal=(q.z-centre)/halfDepth;
            float edges=max(0.,1.-longitudinal*longitudinal);
            tau+=stepSize*hills*edges*exp(-altitude*altitude)*max(.15,.78+.78*wind+.32*eddy)*(i==0?.0078:.0068);
        }
    }
    vec3 scatter=srgbToLinear(mix(vec3(.495,.541,.685),vec3(.93,.746,.625),
                                 clamp(.95*forward+.15*(1.-ray.x),0.,1.)));
    c=mix(c,scatter,1.-exp(-tau*max(0.,controls.z)));
    // Inversions cling to the wooded benches at the feet of both cliffs.
    // Sample the final segment of the sightline, including the canopy behind
    // a foreground crown only when the ray actually reaches that far.
    float contactDepth=0.;
    if(hasGround() && worldPos.z>355. && ray.x>.045){
        for(int j=0;j<6;j++){
            vec3 q=worldPos-ray*(4.+8.*float(j));
            float locality=smoothstep(363.,445.,q.z)*(1.-smoothstep(965.,1090.,q.z))
                         *smoothstep(.008,.145,q.x/max(1.,q.z));
            float ground=baseHeight(q.xz)+contactAt(q.xz).y;
            float belt=smoothstep(37.,70.,ground)*(1.-smoothstep(140.,178.,ground));
            float h=(q.y-ground-8.)/18.;
            contactDepth+=.53*exp(-h*h)*belt*locality;
        }
    }
    vec3 bankTint=srgbToLinear(mix(vec3(.372,.394,.465),vec3(.475,.495,.590),smoothstep(485.,800.,worldPos.z)));
    return mix(c,bankTint,1.-exp(-contactDepth*controls.z));
}
int object;vec3 origin,dims,position;vec2 datum,strike;float unit;
void setRock(int id){object=id;
 datum=id==0?vec2(1450,235):id==1?vec2(1800,305):id==2?vec2(1510,435):vec2(1840,202);
 float z=id==0?970.:id==1?550.:id==2?457.:1480.;unit=z/1404.;
 strike=vec2((datum.x-960.)/1404.,(464.4-datum.y)/1404.);position=vec3(strike.x*z,70.+strike.y*z,z);
 origin=id==0?vec3(838,25,-340):id==1?vec3(1552,183,-138):id==2?vec3(1380,353,-76):vec3(1628,133,-111);
 dims=id==0?vec3(2120,650,230):id==1?vec3(2210,618,154):id==2?vec3(1700,590,82):vec3(2084,372,110);}
vec3 axes(){return vec3(strike,1.);}
    vec3 world(vec3 p){return position+unit*(vec3(p.x-datum.x,datum.y-p.y,0.)+axes()*p.z);}
    vec3 localDir(vec3 v){vec3 a=axes();return vec3(v.x-a.x*v.z,-v.y+a.y*v.z,v.z);}
    vec3 worldNormal(vec3 g){vec3 a=axes();return normalize(vec3(g.x,-g.y,g.z-a.x*g.x+a.y*g.y));}
  
const vec2 watershed[] = vec2[](vec2(890.000,466.000),
vec2(997.000,402.000),
vec2(1058.000,352.000),
vec2(1093.000,320.000),
vec2(1099.000,310.000),
vec2(1109.000,303.000),
vec2(1125.000,277.000),
vec2(1137.000,265.000),
vec2(1147.000,260.000),
vec2(1157.000,249.000),
vec2(1185.000,263.000),
vec2(1195.000,259.000),
vec2(1211.000,263.000),
vec2(1225.000,255.000),
vec2(1233.000,255.000),
vec2(1245.000,244.000),
vec2(1257.000,241.000),
vec2(1263.000,242.000),
vec2(1277.000,235.000),
vec2(1291.000,206.000),
vec2(1293.000,205.000),
vec2(1295.000,200.000),
vec2(1303.000,189.000),
vec2(1309.000,184.000),
vec2(1323.000,184.000),
vec2(1333.000,188.000),
vec2(1335.000,186.000),
vec2(1339.000,177.000),
vec2(1343.000,176.000),
vec2(1345.000,168.000),
vec2(1353.000,164.000),
vec2(1361.000,154.000),
vec2(1365.000,144.000),
vec2(1375.000,131.000),
vec2(1377.000,125.000),
vec2(1379.000,125.000),
vec2(1381.000,117.000),
vec2(1383.000,115.000),
vec2(1387.000,106.000),
vec2(1391.000,102.000),
vec2(1393.000,97.000),
vec2(1403.000,86.000),
vec2(1407.000,85.000),
vec2(1409.000,81.000),
vec2(1421.000,77.000),
vec2(1435.000,78.000),
vec2(1455.000,86.000),
vec2(1465.000,93.000),
vec2(1480.000,93.000),
vec2(1487.000,85.000),
vec2(1495.000,79.000),
vec2(1505.000,83.000),
vec2(1511.000,83.000),
vec2(1521.000,70.000),
vec2(1531.000,69.000),
vec2(1539.000,75.000),
vec2(1547.000,76.000),
vec2(1561.000,87.000),
vec2(1569.000,96.000),
vec2(1585.000,127.000),
vec2(1591.000,130.000),
vec2(1599.000,142.000),
vec2(1607.000,147.000),
vec2(1627.000,153.000),
vec2(1633.000,149.000),
vec2(1647.000,153.000),
vec2(1655.000,147.000),
vec2(1667.000,146.000),
vec2(1687.000,157.000),
vec2(1707.000,172.000),
vec2(1733.000,185.000),
vec2(1759.000,190.000),
vec2(1780.000,204.000),
vec2(1810.000,211.000),
vec2(1870.000,237.000),
vec2(2000.000,288.000),
vec2(2070.000,340.000));
const vec4 blocks[] = vec4[](vec4(1022.000,349.000,67.000,-28.000),
vec4(1098.000,281.000,50.000,-34.000),
vec4(1158.000,229.000,49.000,-51.000),
vec4(1208.000,234.000,45.000,-14.000),
vec4(1256.000,207.000,43.000,-21.000),
vec4(1318.000,156.000,39.000,-52.000),
vec4(1356.000,128.000,31.000,-32.000),
vec4(1420.000,50.000,46.000,-74.000),
vec4(1457.000,60.000,37.000,-41.000),
vec4(1494.000,52.000,28.000,-17.000),
vec4(1534.000,40.000,54.000,-57.000),
vec4(1584.000,74.000,42.000,-25.000),
vec4(1624.000,98.000,55.000,-20.000),
vec4(1670.000,122.000,48.000,-34.000),
vec4(1725.000,146.000,58.000,-9.000),
vec4(1803.000,153.000,64.000,-16.000),
vec4(1874.000,169.000,69.000,-2.000),
vec4(1970.000,207.000,87.000,4.000),
vec4(1475.000,175.000,36.000,-105.000),
vec4(1277.000,282.000,45.000,-91.000));
const float twists[]=float[](8.0,-3.0,5.0,-4.0,6.0,-5.0,5.0,-4.0,4.0,-5.0,6.0,-5.0,4.0,-6.0,3.0,5.0,-4.0,3.0,8.0,-5.0);
float noise3(vec3 p);
float hash(vec3 p);
float smin(float a,float b,float r){float h=max(r-abs(a-b),0.)/r;return min(a,b)-.25*r*h*h;}
float roundBox(vec3 p,vec3 b,float r){vec3 q=abs(p)-b+r;return length(max(q,0.))+min(max(q.x,max(q.y,q.z)),0.)-r;}
float roof(float x){
 int lo=0,hi=watershed.length()-1;
 for(int i=0;i<8;i++){int m=(hi+lo)/2;if(x<watershed[m].x)hi=m;else lo=m;}
 vec2 a=watershed[lo],b=watershed[hi];return mix(a.y,b.y,clamp((x-a.x)/max(.01,b.x-a.x),0.,1.));}
vec2 facets(vec3 p,float scale){
 // Piecewise planar, elongated cells. The two closest nuclei determine the joint.
 vec3 q=vec3(.93*p.x+.368*p.y,(-.368*p.x+.93*p.y)*.25,p.z)/scale;
 vec3 cell=floor(q),w=fract(q);float a=10.,b=10.,tilt=0.;
 for(int z=-1;z<=1;z++)for(int y=-1;y<=1;y++)for(int x=-1;x<=1;x++){
  vec3 k=vec3(x,y,z),id=cell+k;
  vec3 off=k+.5+.38*(vec3(hash(id),hash(id+57.),hash(id+13.))-.5)-w;
  float t=dot(off,off);
  if(t<a){b=a;a=t;tilt=dot(off,vec3(hash(id+5.),hash(id+9.),hash(id+31.))-.5);}
  else b=min(b,t);
 }
 float edge=(sqrt(b)-sqrt(a))*scale;return vec2(tilt*smoothstep(0.,2.8,edge),edge);
}
float buttress(vec3 p,vec4 station,float w,float len){
 float h=p.y-station.y,x=p.x-station.x+station.z*h;
 float nose=station.w-.25*h;
 float front=max(nose-1.45*x,nose+.47*x);
 float crown=station.y-p.y+.34*max(-x,0.)+.69*max(x,0.)+.62*max(station.w-p.z,0.);
 return max(max((front-p.z)*.58,crown*.70),max(abs(x)-w*(.45+.55*clamp(h/42.,0.,1.)),max(p.z-16.,(h-len)*.61)));
}
float rockField(vec3 p){
 if(object==3){
  float x=p.x-1849.;float crest=168.+max(-.39*x,.21*x)+4.*sin(x*.071)+2.2*sin(x*.13+.8);
  float summit=crest+.58*abs(p.z);
  return max(max(summit-p.y,-p.z-40.-.17*x-.22*(p.y-195.)+3.*noise3(p*.048)),max(p.z-90.,p.y-435.));}
 if(object==1||object==2){
  float k=object==1?1.:.49;vec2 uv=object==1?vec2(1870,370):vec2(1535,470);
  vec3 q=vec3(p.xy-uv,p.z)/k;
  if(object==2)q.y=(q.y-32.)/.56;
  float ball=(length((q-vec3(24.+.26*q.y,28.,16.))/vec3(308,209,119))-1.)*125.;
  float cap=-137.-.105*q.x+.31*max(-q.x-34.,0.)+.71*max(-q.x-116.,0.)-.16*q.z-q.y;
  // A single retreating bedrock front. Its orientation turns gradually
  // through the nose. Local breaks follow the steep joint set.
  vec3 jointSpace=vec3(.031*q.x+.011*q.y,.018*q.y,.025*q.z);
  float mass=noise3(jointSpace*.52);
  float joints=noise3(jointSpace);
  float flakes=abs(noise3(jointSpace*2.63)-.47);
  float scar=abs(noise3(vec3(.025*q.x+.012*q.y,q.y*.009,q.z*.022))-.46);
  float breakage=15.*(mass-.50)+7.*abs(joints-.43)+2.5*flakes+5.*exp(-scar*scar*290.);
  float west=-q.z-100.-.62*(q.x+62.)-.20*q.y;
  float east=-q.z-104.+.30*(q.x+53.)-.31*q.y;
  float face=-smin(-west,-east,42.)+breakage;
  float lip=q.x-.38*q.y+16.*(mass-.5)+3.2*joints;
  float sheets=2.2*abs(noise3(vec3(lip*.032,q.y*.010,q.z*.026))-.38);
  float d=-smin(smin(-ball,-cap-(mass-.5)*9.,8.),-(face+sheets),15.);
  float skin=.87*(noise3(jointSpace*3.6)-.5);
  float foot=60.-.11*q.x+.46*abs(q.z+102.)+.0019*pow(max(-120.-q.x,0.),2.)+.074*abs(q.x+15.);
  foot+=4.*noise3(vec3(q.x*.04,4.,q.z*.039));
  float toe=max(max(foot-q.y,abs(q.z+104.)-77.),max(-252.-q.x,q.x-285.));
  return k*(object==2?.56:1.)*smin(d+skin,toe,3.);
 }
 float d=1000.;
 for(int i=0;i<blocks.length();i++){
  vec4 s=blocks[i];vec2 q=p.xy-s.xy;
  float down=dot(q,vec2(-.368,.93)),lat=dot(q,vec2(.93,.368));
  float dep=p.z+.32*max(down,0.)-(s.w+69.)+.00032*down*down;
  float angle=radians(twists[i]+(s.x<1470.?26.:-13.));
  vec2 ac=mat2(cos(angle),sin(angle),-sin(angle),cos(angle))*vec2(lat,dep);
  d=smin(d,roundBox(vec3(ac.x,down-177.,ac.y),vec3(s.z+.043*max(down,0.),194,76),6.5),4.);
 }
 d=smin(d,buttress(p,vec4(1473,166,.69,-163),57.,197.),3.);
 d=smin(d,buttress(p,vec4(1414,83,.35,-127),48.,236.),3.);
 d=smin(d,buttress(p,vec4(1160,251,.46,-86),29.,90.),3.);
 float top=roof(p.x);
 float shoulder=.23+.24*smoothstep(20.,125.,abs(p.x-1450.));
 d=max(d,(top+shoulder*max(-p.z,0.)+.61*max(p.z,0.)-p.y)*.72);
 for(int i=0;i<3;i++){
  vec4 s=i==0?vec4(1479,99,9,48):i==1?vec4(1352,187,8,110):vec4(1209,272,15,114);
  float dy=p.y-s.y,a=p.x-s.x+.37*dy;
  d=max(d,-max(max(abs(a)-s.z+.075*dy,-.8*dy),max(dy-s.w,p.z+56.+.60*abs(a)-.24*dy)));}
 for(int i=0;i<4;i++){
  vec4 s=i==0?vec4(1602,183,95,13):i==1?vec4(1618,231,116,21):i==2?vec4(1630,268,87,18):vec4(1490,130,38,8);
  float dx=p.x-s.x,span=max(0.,1.-dx*dx/(s.z*s.z)),bed=p.y-s.y-.33*dx-2.1*sin(.032*dx);
  d=max(d,-max(max(-bed-6.5*span,bed+.36*(p.z+90.)),max(abs(dx)-s.z,p.z+20.-s.w*span+.09*dx)));}
 // A deposition slope shared by the gullies. Its crest sits inside
 // the cliff, so the debris has no free-standing conical summits.
 float slopeRun=-p.z-108.;
 float crossRun=p.x+.31*p.z;
 float drainage=noise3(vec3(crossRun*.023,p.z*.012,3.));
 float gravel=noise3(vec3(crossRun*.078,p.z*.038,7.));
 float apronY=353.-.065*(p.x-1190.)+.49*sqrt(slopeRun*slopeRun+180.)+.47*max(1130.-p.x,0.)+.39*max(p.x-1400.,0.)+
              10.*(drainage-.5)+3.8*(gravel-.5);
 float tal=max((apronY-p.y)*.79,max((1040.-p.x)*.59,(p.x-1540.)*.61));
 tal=max(tal,max(-p.z-317.,p.z-168.));
 d=smin(d,tal,7.);
 // A forestable bedrock spur grades into the west talus.
 vec3 spur=(p-vec3(1127.,402.,-130.))/vec3(128.,39.,82.);
 float shoulderFoot=(length(spur)-1.)*38.+4.*noise3(p*.035);
 d=smin(d,shoulderFoot,6.);
 if(abs(d)<10. && p.y>top+2. && tal>2.){
  vec2 f=facets(p,24.),g=facets(p,8.);
  float fault=abs(noise3(vec3(.037*p.x+.014*p.y,.020*p.y,.033*p.z))-.48);
  float relief=4.2*f.x+1.15*g.x+.62*exp(-f.y*f.y*.36)+6.8*fault;
  d+=smoothstep(2.,15.,p.y-top)*smoothstep(2.,14.,tal)*relief;}
 return d;
}
    float sd(vec3 p){return rockField(p);}
    vec3 gradient(vec3 p,float e){vec2 h=vec2(e,0);return vec3(sd(p+h.xyy)-sd(p-h.xyy),sd(p+h.yxy)-sd(p-h.yxy),sd(p+h.yyx)-sd(p-h.yyx));}
    float hash(vec3 p){p=fract(p*.1031);p+=dot(p,p.yzx+33.33);return fract((p.x+p.y)*p.z);}
    float noise3(vec3 p){vec3 i=floor(p),f=fract(p);f=f*f*(3.-2.*f);
      return mix(mix(mix(hash(i),hash(i+vec3(1,0,0)),f.x),mix(hash(i+vec3(0,1,0)),hash(i+vec3(1,1,0)),f.x),f.y),
      mix(mix(hash(i+vec3(0,0,1)),hash(i+vec3(1,0,1)),f.x),mix(hash(i+vec3(0,1,1)),hash(i+1.),f.x),f.y),f.z);}
    float softShadow(vec3 p,vec3 n,vec3 light){
      vec3 ray=localDir(light);vec3 start=p+localDir(n)*2.4;float t=3.,v=1.;
      for(int i=0;i<24;i++){float h=sd(start+ray*t);v=min(v,5.*max(h,0.)/t);if(h<-.6||t>100.)break;t+=clamp(h*.72,2.,17.);}
      return smoothstep(0.,1.,v);}
    float lineDistance(vec2 p,vec2 a,vec2 b){vec2 d=b-a;return length(p-a-d*clamp(dot(p-a,d)/dot(d,d),0.,1.));}

bool intersectRock(vec3 eye,vec3 ray,out vec3 p,out vec3 wp){      vec3 localEye=vec3(datum,0.)+localDir(eye-position)/unit;
      vec3 dir=localDir(ray);
      vec3 inv=1./(sign(dir+1.e-9)*max(abs(dir),vec3(1.e-7)));
      vec3 a=(origin-localEye)*inv,b=(dims-localEye)*inv;
      vec3 nearT=min(a,b),farT=max(a,b);
      float t=max(0.,max(nearT.x,max(nearT.y,nearT.z))),end=min(farT.x,min(farT.y,farT.z));
      if(t>=end)return false;
      bool hit=false;p=vec3(0.);
      for(int i=0;i<155;i++){p=localEye+dir*t;float d=sd(p);if(d<.14){hit=true;break;}t+=max(.12,d*.66);if(t>end)break;}
      if(!hit)return false;
      wp=world(p);return true;
}
vec3 rockColor(vec3 p,vec3 wp,vec3 eye){      vec3 raw=gradient(p,spacing*.66);vec3 n=worldNormal(raw);
      vec3 light=sunlight();
      float occ=clamp(.60*(1.-sd(p+localDir(n)*6.)/6.)+.40*(1.-sd(p+localDir(n)*19.)/19.),0.,.88);
      float shadow=softShadow(p,n,light);
      if(integrated==1)shadow*=castVisibility(wp+n*2.,light,true);
      float crack=0.,grit=noise3(p*.75);
      if(object==0){
          vec3 coords=vec3(.83*p.x+.37*p.y,p.y*.5,p.z)*.079;
          float weather=noise3(coords),f=weather-.5;
          vec3 grad=vec3(noise3(coords+vec3(.14,0,0))-weather,
                    noise3(coords+vec3(0,.14,0))-weather,noise3(coords+vec3(0,0,.14))-weather);
          n=normalize(n-(grad-n*dot(n,grad))*(1.25+.9*abs(f)));
      }
      if(stage>=3){
        if(object==0){
          float joint=p.x*.93+p.y*.368;
          float scratch=abs(fract(joint*.23+.14*noise3(p*.045))-.5);
          float score=(1.-smoothstep(.025,.09+fwidth(joint)*.085,scratch))*smoothstep(.41,.66,noise3(p*.052));
          crack=clamp(smoothstep(.28,.70,noise3(p*.038))*(1.-smoothstep(.16,1.40,facets(p,24.).y))*.55+score*.47*(1.-smoothstep(1430.,1495.,p.x)),0.,1.);
        }
        if(object==1||object==2){
          vec2 q=object==1?p.xy:vec2(1870,370)+(p.xy-vec2(1535,470))/.49;
          // Fracture edges and narrow mineral seams follow the tilted
          // granite sheets; finer joints die out before crossing a whole face.
          vec3 local=object==1?p:vec3((p.xy-vec2(1535,470))/.49+vec2(1870,370),p.z/.49);
          vec2 coarse=facets(local*.86,20.);
          float exposure=noise3(local*.028);
          float seam=(1.-smoothstep(.25,1.45,coarse.y))*smoothstep(.30,.74,exposure);
          vec3 uvw=vec3(local.x*.13+local.y*.047,local.y*.093,local.z*.074);
          float grain=noise3(uvw);
          vec3 g=vec3(noise3(uvw+vec3(.17,0,0))-grain,noise3(uvw+vec3(0,.17,0))-grain,noise3(uvw+vec3(0,0,.17))-grain);
          n=normalize(n-.64*(g-dot(g,n)*n));
          crack=.79*seam;
        }
        n=normalize(n+.025*vec3(grit-.5,noise3(p*.61+19.)-.5,noise3(p*.64+8.)-.5));
      }
      float direct=max(0.,dot(n,light))*mix(.33,1.,shadow);
      float bounce=clamp(.55-.32*n.y-.22*n.z,0.,1.);
      float diffuse=.68*direct+.20+.17*max(n.y,0.)+.045*bounce;
      vec3 c=vec3(pow(max(.012,diffuse*(1.-.25*occ)),.76)*(1.-.30*crack));
      float snow=0.;
      if(stage>=4 && object==0){
        float shelf=smoothstep(.765,.825,worldNormal(gradient(p,3.4)).y);
        float shelter=clamp(.08+occ*2.+(1.-shadow)*.52+max(0.,sd(p+vec3(0,0,-7))-sd(p+vec3(0,-7,0)))*.04,0.,1.);
        float grains=noise3(p*.19)*.32+noise3(p*.052)*.68;
        float apron=0.;
        for(int i=0;i<3;i++){vec2 uv=i==0?vec2(1090,323):i==1?vec2(1200,313):vec2(1328,293);
          float down=p.y-uv.y;apron=max(apron,smoothstep(0.,15.,down)*(1.-smoothstep(52.,91.,down))*(1.-smoothstep(.5,1.,abs(p.x-uv.x+.37*down)/(6.+.48*max(0.,down)))));}
        float ledge=0.;
        for(int j=0;j<4;j++){vec3 s=j==0?vec3(1602,183,95):j==1?vec3(1618,231,116):j==2?vec3(1630,268,87):vec3(1490,130,38);
          float dx=p.x-s.x;float bed=p.y-s.y-.33*dx-2.1*sin(.032*dx)+.36*(p.z+90.);
          ledge=max(ledge,(1.-smoothstep(1.,5.,abs(bed)))*(1.-smoothstep(s.z*.78,s.z,abs(dx))));}
        float gully=(1.-smoothstep(4.,14.,abs(p.x-1480.+.37*(p.y-99.))))*smoothstep(94.,106.,p.y)*(1.-smoothstep(128.,143.,p.y));
        float run=-p.z-108.,crossRun=p.x+.31*p.z;
        float floorY=353.-.065*(p.x-1190.)+.49*sqrt(run*run+180.)+.47*max(1130.-p.x,0.)+.39*max(p.x-1400.,0.)+
                     10.*(noise3(vec3(crossRun*.023,p.z*.012,3.))-.5)+
                     3.8*(noise3(vec3(crossRun*.078,p.z*.038,7.))-.5);
        float track=abs(noise3(vec3(crossRun*.017,p.z*.006,19.))-.48);
        apron=(1.-smoothstep(.044,.19,track))*(1.-smoothstep(1.5,7.,abs(p.y-floorY)))*
              smoothstep(-29.,6.,run)*(1.-smoothstep(55.,145.,run));
        float catchment=max(apron,max(ledge,gully));
        snow=shelf*catchment*smoothstep(.27,.58,shelter+.83*catchment+.39*grains)*(1.-smoothstep(366.,445.,p.y));
        n=normalize(mix(n,vec3(0,1,0),snow*.27));
        c=mix(c,vec3(.72+.18*direct),snow);}
      if(stage>=5){
        vec3 albedo=mix(vec3(.49,.43,.46),vec3(.63,.52,.52),noise3(wp*.051));
        vec3 radiance=srgbToLinear(albedo)*(ambientLight()*vec3(.74,.86,1.35)*(.64+.68*max(n.y,0.))
                         +key()*(.13+2.9*direct));
        float reflectedKey=dot(n,normalize(vec3(light.x,.075,-.055)));
        radiance+=srgbToLinear(albedo)*key()*1.10*pow(max(reflectedKey,0.),1.5);
        c=linearToSrgb(radiance*(1.-.23*occ)*(1.-.09*crack));
        if(object==1||object==2){float weather=noise3(p*vec3(.047,.054,.036));
          float dry=noise3(vec3(p.x*.086+p.y*.045,p.y*.052,p.z*.064));
          c*=.79+.22*weather+.19*dry+.055*noise3(p*.22);
          float east=smoothstep(1770.,1840.,p.x+.15*(p.y-305.));
          c=mix(c,vec3(.225,.214,.306)+.045*weather,east*.24);
          float split=noise3(vec3(.062*p.x+.031*p.y,p.y*.015,p.z*.035));
          float cleft=(1.-smoothstep(.025,.11,abs(split-.49)));
          c*=1.-.20*cleft*smoothstep(.22,.63,weather);
          c+=vec3(.062,.034,.029)*max(0.,-n.x); }
        if(object==0){float band=noise3(p*vec3(.086,.018,.060));
          float inclusion=noise3(p*.047)*.65+noise3(p*.128)*.35;
          c*=.91+.10*band+.085*inclusion;
          c+=vec3(.044,.035,.037)*max(0.,dot(n,normalize(vec3(-.92,.2,-.43))))*(.4+.6*shadow);c=mix(c,mix(vec3(.50,.555,.71),vec3(.88,.84,.79),max(direct,.23*bounce)),snow);
          float ridge=smoothstep(302.,348.,p.y)*(1.-smoothstep(380.,420.,p.y))*smoothstep(.69,.87,n.y)*(1.-snow);
          c+=ridge*vec3(.095,.078,.045);}
        if(stage>=6){
          float grass=object==1||object==2?smoothstep(.78,.94,n.y):object==0?smoothstep(.73,.94,n.y)*smoothstep(295.,370.,p.y)*(1.-snow):0.;
          c=mix(c,mix(vec3(.266,.286,.224),vec3(.74,.63,.47),direct),grass*(.79+.21*noise3(p*.18)));}
        if(stage>=6 && (object==1||object==2)){
          vec3 q=object==1?vec3(p.xy-vec2(1870.,370.),p.z):vec3((p.xy-vec2(1535.,470.))/.49,p.z/.49);
          if(object==2)q.y=(q.y-32.)/.56;
          float cap=-137.-.105*q.x+.31*max(-q.x-34.,0.)+.71*max(-q.x-116.,0.)-.16*q.z;
          float damp=noise3(wp*vec3(.20,.042,.17));
          float below=q.y-cap;
          float lip=smoothstep(-2.,2.,below)*(1.-smoothstep(3.,9.+9.*damp,below));
          c=mix(c,linearToSrgb(srgbToLinear(vec3(.28,.26,.215))*(ambientLight()+key()*direct)),lip*.78);
          c*=1.-.13*smoothstep(.44,.69,damp)*exp(-max(below,0.)/46.);
        }
        if(integrated==1 && object!=3){
          vec4 foot=contactAt(wp.xz);
          float ground=baseHeight(wp.xz)+foot.y;
          float gap=wp.y-ground+7.*(noise3(wp*.082)-.5);
          float cover=(1.-smoothstep(1.,34.,gap))*(.28+.72*smoothstep(.13,.83,n.y))*(1.-snow);
          c*=.70+.30*smoothstep(0.,18.,gap);
          float litter=noise3(wp*.12)*.52+noise3(wp*.034)*.48;
          c=mix(c,mix(vec3(.235,.224,.246),vec3(.419,.392,.282),litter),cover*.77);
        }
        
        if(object==3)c=mix(c,vec3(.55,.58,.72),.52);
        c=film(valleyAir(srgbToLinear(c),wp,eye));
      }
return clamp(c,0.,1.);}
vec3 skyRadiance(vec3 ray){float alt=max(0.,ray.y),scatter=forwardLight(ray);
        vec3 sky=mix(vec3(.95,.769,.681),vec3(.613,.619,.714),smoothstep(.025,.38,alt));
        float east=smoothstep(.01,.66,ray.x)*smoothstep(.035,.29,alt);
        sky=mix(sky,vec3(.419,.502,.684),east*.92);
        sky=mix(sky,vec3(1.,.891,.736),pow(scatter,1.65));
        vec2 p=ray.xy*vec2(7.,67.)+vec2(.03*sin(phase),4.);
        float cloud=fbm(p+gradientNoise(p*.44),4);
        sky+=vec3(.084,.050,.038)*smoothstep(.10,.42,cloud);
        float stratus=exp(-pow((ray.y-.118-.005*gradientNoise(vec2(ray.x*17.,3.)))/.006,2.));
        sky+=vec3(.115,.042,.008)*stratus*smoothstep(.0,.30,cloud+.11)*scatter;
        float glow=length(ray-sunlight());
        sky+=vec3(.17,.17,.15)*exp(-31.*glow);
        sky=mix(sky,vec3(1.,1.,.967),1.-smoothstep(.008,.013,glow));
        return clamp(sky,0.,1.);}
vec3 cameraEye(){return vec3(truck,70.+.035*truck,-.09*truck);}
vec3 decodeOct(vec2 e){vec3 n=vec3(e,1.-abs(e.x)-abs(e.y));if(n.z<0.)n.xy=(1.-abs(n.yx))*sign(n.xy);return normalize(n);}
int bucketStart(int key,bool mirrored){
 int lo=0,hi=262144;for(int j=0;j<19;j++){if(lo>=hi)break;int mid=(lo+hi)/2;
 if(rootKey(texelFetch(iChannel1,sortAddress(mid,mirrored),0),mirrored)<key)lo=mid+1;else hi=mid;}return lo;}
ivec2 treeRange(int key,bool mirrored){
    int y=(key/256)%256,x=key%256;
    int width=int(iChannelResolution[1].x);
    int slot=1310720+769*769+((mirrored?3:0)+key/65536)*4096+y*64+x;
    if(x<64 && y<64 && slot<width*int(iChannelResolution[1].y)){
        vec4 entry=texelFetch(iChannel1,ivec2(slot%width,slot/width),0);
        if(entry.w==1.)return ivec2(entry.xy);
    }
    return ivec2(bucketStart(key,mirrored),bucketStart(key+1,mirrored));
}
struct ForestHit {float z;vec3 color;};
float canopyNode(ivec2 node){
    node=clamp(node,ivec2(0),ivec2(1536));
    ivec2 pair=node/2;
    int at=1310720+pair.y*769+pair.x,width=int(iChannelResolution[1].x);
    return texelFetch(iChannel1,ivec2(at%width,at/width),0)[node.x%2+2*(node.y%2)];
}
float canopyHeight(vec2 world){
    vec2 at=(world+vec2(1100,40))*1537./vec2(2200,1800)-.5;
    ivec2 node=ivec2(floor(at));vec2 t=fract(at);
    return mix(mix(canopyNode(node),canopyNode(node+ivec2(1,0)),t.x),
               mix(canopyNode(node+ivec2(0,1)),canopyNode(node+ivec2(1)),t.x),t.y);
}
float skyVisibilityAt(vec3 p){
    float obstruction=0.;
    for(int j=0;j<5;j++){
        vec3 q=p+sunlight()*(4.5*exp2(float(j)*.81));
        obstruction=max(obstruction,smoothstep(-.25,3.,bed(q.xz)+canopyHeight(q.xz)-q.y));
    }
    return 1.-.76*obstruction;
}
vec3 finishSlope(vec3 c,vec3 p){
    vec3 air=valleyAir(c,p,cameraEye());
    float layer=smoothstep(93.,168.,p.z)*(1.-smoothstep(232.,365.,p.z));
    float west=smoothstep(-.045,.24,-p.x/max(1.,p.z));
    air=mix(air,srgbToLinear(vec3(.61,.49,.401)),.135*layer*west);
    float halo=exp(-65.*length(normalize(p-cameraEye())-sunlight()))*smoothstep(480.,850.,p.z);
    return film(air+key()*.47*halo);
}
void testTree(vec4 r,vec3 ro,vec3 rd,bool mirrored,inout ForestHit best){
 float h=treeHeight(r);int style=treeStyle(r);float orange=isLarch(r);int level=treeLevel(r.z);
 float rotation=r.x*3.17+r.z*.71;float width=(.88+.055*float(style))*(1.+.22*orange);
 float z=r.z-ro.z;if(z-.33*h>best.z)return;
 vec3 local=(ro+rd*z-r.xyz)/h;vec2 xy=local.xy;
 if(xy.y<-.14||xy.y>1.05||abs(xy.x)>.45)return;
 float wind=(sin(phase+r.x*.08+r.z*.037)+.4*sin(2.*phase+r.z*.13))*controls.w*.015;
 TreeView v=design(level,style%3,rotation,orange,.88+.055*float(style),-rd.y);
 rayShear=rd.xy;treeBend=wind;
 CrownHit hit;if(!hitCrown(local.xy,v,hit))return;
 float tz=z+h*hit.depth;if(tz>=best.z)return;
 vec3 normal=hit.normal;float sunSide=hit.sunSide;
 vec3 worldPos=ro+rd*tz;
 vec3 c=shadeCrown(worldPos,normal,hit.exposure,sunSide,orange,skyVisibilityAt(worldPos));
 c=srgbToLinear(c);
 float nearW=(1.-smoothstep(125.,206.,worldPos.z))*smoothstep(-.08,.12,-worldPos.x/max(1.,worldPos.z));
 c*=mix(vec3(1.),vec3(.83,1.,.77),nearW*(1.-orange));
 float shelf=smoothstep(472.,505.,r.z)*(1.-smoothstep(598.,637.,r.z))*smoothstep(100.,132.,cap(r.xz))*smoothstep(118.,139.,r.y);
 c+=shelf*(ambientLight()*vec3(.075,.083,.058)+key()*vec3(.095,.070,.027)*sunSide*(.24+.76*hit.exposure));
 c=finishSlope(c*castVisibility(worldPos+normal*1.2,sunlight(),false),worldPos);
 best=ForestHit(tz,c);
}
vec3 treeLayer(vec3 back,float limit,vec3 ro,vec3 rd,bool mirrored,out float nearest){
 ForestHit best=ForestHit(limit,back);
 vec2 pixel=vec2(960.+rd.x*1404.,464.4+(mirrored?rd.y:-rd.y)*1404.);
 for(int level=0;level<3;level++){
 if(level==1&&best.z<185.)break;if(level==2&&best.z<390.)break;
 vec2 tile=tileSize(level);
 for(int dy=-1;dy<=1;dy++)for(int dx=-1;dx<=1;dx++){
 int key=tileKey(pixel+vec2(dx,dy)*tile,level);ivec2 range=treeRange(key,mirrored);int start=range.x;
 for(int i=0;i<800;i++){if(start+i>=range.y)break;vec4 r=texelFetch(iChannel1,sortAddress(start+i,mirrored),0);
 testTree(r,ro,rd,mirrored,best);}
 }}
 nearest=best.z;return best.color;
}
vec4 slopeNode(int x,int row){
    int index=row*513+x;
    return texelFetch(iChannel2,ivec2(769+index%1024,768+index/1024),0);
}
vec4 slopeSurface(vec2 world){
    float row=floor(368.*pow(clamp((world.y-2.)/1648.,0.,1.),1./1.63));
    int j=clamp(int(row),0,367);
    vec2 z=2.+1648.*pow(vec2(j,j+1)/368.,vec2(1.63));
    float v=clamp((world.y-z.x)/(z.y-z.x),0.,1.);
    vec2 widths=z*.81+35.;
    float fc=clamp((world.x/mix(widths.x,widths.y,v)+1.)*256.,0.,512.);
    int col=min(511,int(fc));
    float dist=(fc-float(col))*mix(widths.x,widths.y,v);
    if(dist<=(1.-v)*widths.x){
        float u=dist/widths.x;
        return (1.-u-v)*slopeNode(col,j)+u*slopeNode(col+1,j)+v*slopeNode(col,j+1);
    }
    float u=(dist-(1.-v)*widths.x)/widths.y;
    return (1.-v)*slopeNode(col+1,j)+(v-u)*slopeNode(col,j+1)+u*slopeNode(col+1,j+1);
}
float groundAt(vec2 world){return slopeSurface(world).x;}
vec3 landColor(vec3 wp,vec3 ro){
    vec3 n=normalize(slopeSurface(wp.xz).yzw);
        vec3 p=wp,sun=sunlight(),c;
        float fracture=erodedFbm(vec2(p.x*.084+p.y*.028,p.z*.018),4);
        float bedding=erodedFbm(vec2(p.x*.032-p.y*.026,p.z*.025),4);
        float side=dot(normalize(n+vec3(.36*bedding,.06*bedding,0.)),normalize(vec3(sun.x*2.6,.15,-.24)));
        side-=.23*(1.-smoothstep(610.,810.,p.z));
        float stratum=p.y*.19+fracture*3.6+p.x*.037;
        float variation=.76+.29*fracture+.12*sin(stratum);
        vec3 granite=srgbToLinear(mix(vec3(.295,.284,.423),vec3(.787,.599,.6),smoothstep(.54,.98,side)))*variation;
        // Oblique fractures tilt across the granite face; shelves retain narrow
        // discontinuous seams of snow where cut planes meet.
        vec2 faultUV=vec2(p.x*.066-p.y*.039,p.z*.013+p.y*.009);
        float fault=erodedFbm(faultUV,4);
        granite*=.91+.40*fault;
        float hollow=bed(p.xz+vec2(3.,0.))+bed(p.xz-vec2(3.,0.))-2.*p.y;
        float couloir=smoothstep(1.05,3.2,hollow+.72*fracture);
        float shelf=smoothstep(.975,.996,n.y)*smoothstep(.1,.7,sin(stratum));
        float snow=smoothstep(93.,155.,p.y)*clamp(couloir*.54+shelf*.26+smoothstep(.12,.31,fault)*smoothstep(.52,.91,n.y)*.36,0.,1.);
        granite=mix(granite,srgbToLinear(mix(vec3(.53,.54,.66),vec3(.86,.75,.77),max(side,0.))),snow);
        vec3 loam=srgbToLinear(mix(vec3(.19,.19,.225),vec3(.396,.36,.30),.5+.44*fracture));
        float rock=smoothstep(41.,93.,p.y)+.65*(1.-smoothstep(.35,.77,n.y));
        c=mix(loam*(.64+.70*max(side,0.)),granite,clamp(rock,0.,1.));
        // Weathered soil, moss pockets and embedded granite share a relief
        // field. Use its analytic gradients for stable world-space normals.
        float forestBelt=smoothstep(.4,7.,p.y)*(1.-smoothstep(104.,142.,p.y));
        vec2 site=p.xz+vec2(p.y*.29,-.17*p.y);
        vec3 hummock=gradientNoiseD(site*.31);
        vec3 pebbles=gradientNoiseD(site*1.48+vec2(8.9,-3.3));
        float detail=1.-smoothstep(.23,.95,max(fwidth(site.x),fwidth(site.y))*1.48);
        vec2 gradient=.52*hummock.yz+.34*pebbles.yz*detail;
        vec3 floorNormal=normalize(n+vec3(-gradient.x,0.,-gradient.y)*max(n.y,.23));
        float mossPatch=fbm(site*.14+vec2(2.,15.),4)+hummock.x*.33;
        float clast=smoothstep(.10,.37,hummock.x+.18*bedding+.16*pebbles.x*detail);
        vec3 soil=mix(vec3(.227,.192,.184),vec3(.418,.382,.232),smoothstep(-.22,.24,mossPatch));
        vec3 rockFace=mix(vec3(.29,.268,.302),vec3(.52,.452,.402),.50+.46*pebbles.x);
        float pockets=clamp(.80+.42*hummock.x+.13*pebbles.x*detail,.45,1.);
        float irradiance=clamp(dot(floorNormal,sun)*.87+.24,0.,1.)*skyVisibilityAt(p);
        vec3 floorColor=srgbToLinear(mix(soil,rockFace,clast))*pockets*
            (vec3(.55,.65,.79)+key()*irradiance*1.9);
        c=mix(c,floorColor,forestBelt*smoothstep(.18,.57,n.y));
        // The near wooded bank is dark humus and moss even on steep cut faces.
        float understory=(1.-smoothstep(148.,244.,p.z))*(1.-smoothstep(62.,91.,p.y))*smoothstep(2.,8.,p.y);
        vec3 groundGrain=gradientNoiseD(p.xy*.44+p.z*.31);
        vec3 humus=mix(vec3(.128,.153,.143),vec3(.275,.279,.212),smoothstep(-.25,.28,groundGrain.x+.33*bedding));
        c=mix(c,srgbToLinear(humus)*(.70+.39*max(0.,floorNormal.y)),understory);
        float bankWeight=1.-smoothstep(.48,1.,length((p.xz-vec2(18.,322.))/vec2(35.,36.)));
        if(bankWeight>0.){
            // Use an orthonormal tangent frame on each bank. On steep slopes,
            // a top-down projection stretches soil and stones down the face.
            vec3 tangent=normalize(vec3(n.y,-n.x,0.)+vec3(.00001,0.,0.));
            vec3 bitangent=normalize(cross(n,tangent));
            // Fixed projections keep material coordinates continuous across normals.
            vec3 weights=pow(abs(n),vec3(3.));
            weights/=max(.0001,dot(weights,vec3(1.)));
            vec3 coarse=weights.x*gradientNoiseD(p.zy*.45)+weights.y*gradientNoiseD(p.xz*.45)+weights.z*gradientNoiseD(p.xy*.45);
            vec3 grit=weights.x*gradientNoiseD(p.zy*1.32)+weights.y*gradientNoiseD(p.xz*1.32)+weights.z*gradientNoiseD(p.xy*1.32);
            float resolved=1.-smoothstep(.4,1.2,max(length(dFdx(p)),length(dFdy(p)))*1.32);
            vec3 bumps=tangent*(coarse.y+.4*grit.y*resolved)+bitangent*(coarse.z+.4*grit.z*resolved);
            vec3 floorNormal=normalize(n-.36*bumps);
            float grass=smoothstep(-.22,.25,coarse.x+.23*grit.x);
            float stone=smoothstep(.12,.34,coarse.x-.30*grit.x);
            vec3 earth=mix(vec3(.265,.231,.220),vec3(.42,.398,.265),grass);
            vec3 mineral=mix(vec3(.30,.28,.32),vec3(.49,.45,.424),.5+.59*grit.x);
            float irradiance=max(0.,dot(floorNormal,sun));
            vec3 floorColor=srgbToLinear(mix(earth,mineral,stone))*
                (vec3(.59,.65,.75)+key()*irradiance*(.65+.50*skyVisibilityAt(p)));
            c=mix(c,floorColor,forestBelt*bankWeight);
        }
        c*=mix(vec3(.58,.68,1.03),vec3(1.),controls.y/.88);
    return finishSlope(c*castVisibility(wp+n*1.2,sun,false),wp);
}
bool softFirstRow;
vec3 environment(vec3 ro,vec3 rd,bool reflected,float limit,out float visibleZ){
 vec3 c=skyRadiance(normalize(rd));float closest=limit;
 for(int id=0;id<4;id++){setRock(id);vec3 p,wp;if(intersectRock(ro,normalize(rd),p,wp)&&wp.z-ro.z<closest){c=rockColor(p,wp,ro);closest=wp.z-ro.z;}}
 float t=reflected?max(10.,(1.-ro.y)/max(.001,rd.y)):8.,last=t;
 for(int j=0;j<265;j++){if(t>=closest)break;vec3 wp=ro+rd*t;float h=groundAt(wp.xz);
 if(wp.y<h&&(!reflected||wp.y>.02)){
 for(int k=0;k<7;k++){float mid=(last+t)*.5;vec3 q=ro+rd*mid;if(q.y<groundAt(q.xz))t=mid;else last=mid;}
 closest=t;c=landColor(ro+rd*t,ro);break;}last=t;
 t+=clamp((wp.y-h)*.57,1.4,max(6.,wp.z*.019));}
 vec3 result=treeLayer(c,closest,ro,rd,reflected,visibleZ);
 if(!reflected){vec3 p=ro+rd*visibleZ;softFirstRow=visibleZ<closest&&p.z<236.&&p.x/p.z<.22;}
 return result;
}
int depthBand(float z){return z<9.?0:z<15.8?1:z<20.?2:z<28.?3:z<48.?4:z<120.?5:6;}
float bandDepth(int band){return band==0?7.1:band==1?14.3:band==2?18.:band==3?23.:band==4?34.:band==5?83.:320.;}
int patchKey(vec4 r){if(r.z<.1)return 16777200;int lvl=int(r.w/524288.);
 float tile=16.*exp2(float(lvl));ivec2 xy=ivec2(floor(r.xy/tile))+ivec2(48);return ((depthBand(r.z)*5+lvl)*256+clamp(xy.y,0,255))*256+clamp(xy.x,0,255);}
ivec2 patchAddress(int idx,int width){int i=524288+idx;return ivec2(i%width,i/width);}

int firstPatch(int key){int lo=0,hi=524288;for(int j=0;j<20;j++){if(lo>=hi)break;int mid=(lo+hi)/2;
 if(patchKey(texelFetch(iChannel1,patchAddress(mid,int(iChannelResolution[1].x)),0))<key)lo=mid+1;else hi=mid;}return lo;}
// Rebuild the close fern on its own optical plane so defocus can cross its silhouette.
const ivec2 lensSize=ivec2(420,192);
const vec2 lensOrigin=vec2(-255.,850.);
float cameraTruck(){
    float f=min(mod(iTime*48.,248.)*.5,123.);
    return f<=62.?-.92*(1.-cos(f*3.14159265/62.)):-1.84+1.32*(1.-cos((f-62.)*3.14159265/61.));
}
vec2 fernProjection(vec2 point,float z,float truck){
    vec2 local=point-vec2(960,464.4);
    return vec2(960,464.4)+(local*z+vec2(-truck,.035*truck)*1404.)/(z+.09*truck)+vec2(1404.*truck/325.,0.);
}
vec4 lensFern(int address){
    if(address>=lensSize.x*lensSize.y)return vec4(0);
    float truck=cameraTruck();
    vec2 canonical=lensOrigin+(vec2(address%lensSize.x,address/lensSize.x)+.5)/.7;
    vec2 pos=fernProjection(canonical,7.16,truck);
    float depth=100.;vec4 best=vec4(0);
    for(int fr=0;fr<7;fr++){
        float angle=mix(-2.95,-.20,(float(fr)+.4*rnd(fr,2))/7.);
        vec2 ext=vec2(cos(angle),sin(angle))*245.*(.66+.54*rnd(fr,7));
        vec2 d=normalize(ext),origin=vec2(34,1119);
        for(int leaf=-1;leaf<36;leaf++){
            bool stem=leaf<0;int inst=fr*36+max(0,leaf);
            float t=(float(max(0,leaf)/2)+.7)/19.,side=leaf%2==0?-1.:1.;
            vec2 root=origin+ext*t+vec2(0.,.42*abs(ext.x)*t*t-22.*t*(1.-t));
            vec2 dir=normalize(d*.52+side*vec2(-d.y,d.x));
            float width=49.*(.22+.78*sin(3.14159265*pow(t,.8)))*(.70+.48*rnd(inst,2));
            if(!stem&&distance(canonical,root)>(width+15.))continue;
            int cols=stem?15:6,rows=stem?1:2;
            for(int col=0;col<cols;col++)for(int row=0;row<rows;row++){
                vec3 verts[4];vec2 coords[4];
                for(int k=0;k<4;k++){
                    vec2 uv=vec2(col+(k==1||k==2?1:0),row+(k>=2?1:0))/vec2(cols,rows);
                    float along=stem?uv.x:t,z=7.1+.08*along+.05*uv.x;
                    vec2 point=stem?origin+ext*along+vec2((uv.y-.5)*1.8,.42*abs(ext.x)*along*along-22.*along*(1.-along)):
                        root+width*(dir*uv.x+vec2(-dir.y,dir.x)*(uv.y-.5)*.37*sin(uv.x*3.14159265));
                    verts[k]=vec3(fernProjection(point,z,truck),z);coords[k]=uv;
                }
                for(int k=1;k<3;k++){
                    vec2 a=verts[0].xy,b=verts[k].xy-a,c=verts[k+1].xy-a,q=pos-a;
                    float det=cross2(b,c);if(abs(det)<.0001)continue;
                    float u=cross2(q,c)/det,v=cross2(b,q)/det;
                    if(min(min(u,v),1.-u-v)<0.)continue;
                    float z=verts[0].z*(1.-u-v)+u*verts[k].z+v*verts[k+1].z;
                    if(z>=depth)continue;
                    depth=z;vec2 uv=coords[0]*(1.-u-v)+u*coords[k]+v*coords[k+1];
                    float margin=abs(2.*uv.y-1.),ny=.38+.60*sin(uv.y*3.14159265);
                    float light=.21+.40*ny/sqrt(ny*ny+.49)+.17*margin;
                    best=vec4(mix(vec3(.09,.132,.12),vec3(.247,.291,.205),light),1.);
                }
            }
        }
    }
    return best;
}

int group,cols,rows;float floorAt(vec2 p){return 0.;}

vec3 place(vec2 p,float z){return vec3((p.x-960.)*z/1404.,70.+(464.4-p.y)*z/1404.,z);}
vec3 surface(int i,vec2 uv,out float tag){
 float u=uv.x,v=uv.y,a=2.*PI*u;
 if(group==20){
 // Place granite rubble at the actual zero elevation crossings on each shore.
 float z=mix(181.,434.,rnd(i/2,16));bool east=i%2==0;float l=east?65.:-55.,r=east?265.:75.;
 for(int j=0;j<12;j++){float m=(l+r)*.5;bool dry=floorAt(vec2(m,z))>0.;if(dry==east)r=m;else l=m;}
 float x=.5*(l+r)+mix(-2.,2.,rnd(i,18)),y=floorAt(vec2(x,z)),size=mix(.40,1.36,rnd(i,17));if(abs(y)>6.)size=0.;
 vec3 d=vec3(cos(a)*sin(PI*v),cos(PI*v),sin(a)*sin(PI*v));d=sign(d)*pow(abs(d),vec3(.77));
 tag=-8.;return vec3(x,y-.19,z)+d*size*vec3(1.6,.60,.94)*(1.+.11*noise2(d.xy*4.+float(i)));}
 if(group==0||group==18){
 int tuft=i;if(group==18){i=5+int(rnd(tuft,1)*15.);u=rnd(tuft,2);a=2.*PI*u;v=acos(mix(-.20,1.,rnd(tuft,3)))/PI;}
 const vec4 rocks[]=vec4[](vec4(167,995,128,72),vec4(523,959,125,86),vec4(742,1103,92,83),vec4(1055,1115,211,73),vec4(388,1010,158,68),vec4(362,978,124,73),vec4(434,960,68,63),vec4(642,1030,111,49),vec4(749,1061,112,49),vec4(139,867,82,54),vec4(56,881,99,64),vec4(120,928,61,46),vec4(855,1092,88,41),vec4(24,993,80,39),vec4(125,1098,105,53),vec4(288,1096,113,39),vec4(503,1084,78,41),vec4(243,1022,42,24),vec4(448,1025,37,19),vec4(550,1054,59,25));
 const float depths[]=float[](15.7,16.1,13.1,14.1,15.,14.2,14.7,14.6,14.4,17.1,17.,16.8,14.,13.8,12.7,13.2,13.6,13.8,13.9,14.4);
 vec4 b=rocks[i];float z=depths[i];vec3 dir=vec3(cos(a)*sin(PI*v),cos(PI*v),sin(a)*sin(PI*v));
 bool moss=i>=5;vec3 shape=sign(dir)*pow(abs(dir),vec3(moss?1.:.67));
 float n=noise2(dir.xy*4.+dir.z*3.+float(i));
 shape*=.97+(moss?.035:.09)*n+(moss?.007:.012)*noise2(dir.xy*22.+dir.z*13.);
 shape.y-=moss?0.:.20*shape.x+.12*shape.z;
 vec3 center=place(b.xy,z)+shape*vec3(b.z,b.w,b.z*.67)*z/1404.;tag=moss?12.:11.;
 if(group==18){vec3 n=normalize(dir/vec3(b.z,b.w,b.z*.67));vec3 side=normalize(cross(n,vec3(.01,.97,.18))),up=cross(n,side);
 float angle=rnd(tuft,4)*6.283;float polar=angle+uv.x*6.283;
 float petals=cos(5.*(polar-angle))*.26+.72;
 center+=z/1404.*mix(1.,2.8,rnd(tuft,5))*(n*(1.1-.91*uv.y)+uv.y*petals*(cos(polar)*side+sin(polar)*up));}return center;
 }
 if(group==17){
 // Eight irregular whorls on the spruce nearest the moss shelf.
 int tier=i/(7*20*16),arm=(i/(20*16))%7,fan=(i/16)%20,j=i%16,seed=tier*103+arm*37;
 float f=(float(tier)+.3)/8.,az=float(tier)*2.4+float(arm)*.898+.36*(rnd(seed,5)-.5);
 vec3 d=vec3(cos(az),0,sin(az)),side=vec3(-d.z,0,d.x);
 vec3 origin=mix(place(vec2(518,660),83.),place(vec2(516,929),83.),f);
 float len=(.4+6.05*pow(f,.78))*(.75+.40*rnd(seed,7)),t=(float(fan/2)+1.)/11.;
 vec3 anchor=origin+d*len*(1.16*t-.16*t*t)+vec3(0.,len*(-1.06*t+.75*t*t),0.);
 float twigLen=len*(1.-float(fan/2+1)/15.)*mix(.47,.72,rnd(seed,fan));
 vec3 twig=d*.45+side*(fan%2==0?.72:-.72)+vec3(0.,-.62,0.);
 float along=float(j/2)/8.;vec3 q=anchor+twig*twigLen*along;
 float span=twigLen*(.38-.22*along);
 vec3 dir=twig*.5+d*.33+side*(j%2==0?-.49:.49)+vec3(0,-.18,0);
 vec3 ridge=normalize(cross(dir,vec3(0,1,0)));
 tag=22.125;return q+span*(dir*u+ridge*(v-.5)*.28*sin(PI*u)+vec3(0.,.03*sin(PI*u),0.));
 }
 if(group==19){tag=21.;return place(mix(vec2(516,928),vec2(518,660),u),83.)+vec3((v-.5)*.29*(1.-u),0.,0.);}
 if(group==1){
 float x=mix(-300.,1450.,u);float y=828.+.19*max(x-130.,0.)+.23*max(x-400.,0.)+7.*noise2(vec2(x*.025,1.))+380.*v;
 tag=10.;return place(vec2(x,y),mix(19.1,10.6,v));}
 if(group==2){
 float y=mix(-190.,915.,v),z=i==0?18.6:34.,base=i==0?15.+.014*(480.-y):131.+(800.-y)*.058+5.*sin(y*.011);
 float r=(i==0?70.+33.*v+58.*pow(v,12.):17.+5.*v)*(.96+.035*sin(a*11.+3.*v)+.05*noise2(vec2(9.*cos(a),4.*v+6.*sin(a))));
 tag=19.;return place(vec2(base,y),z)+vec3(cos(a)*r,0.,sin(a)*r)*z/1404.;}
 // Each branch forks into lateral, drooping sprays with individual pointed needles.
 if(group>=3&&group<=5){
 // The branch survey is in the design lens's 1100-unit horizontal frame.
 const vec4 limbs[]=vec4[](vec4(93,-60,384,65),vec4(169,-23,283,18),vec4(9,99,214,223),vec4(12,143,206,201),vec4(7,213,169,322),vec4(3,306,147,370),vec4(22,-17,256,35),vec4(29,44,199,154),vec4(134,-24,335,113),vec4(1117,198,1041,273),vec4(1127,251,1044,322),vec4(1118,337,997,433),vec4(1125,492,990,561),vec4(1118,547,1030,623));
 const float spread[]=float[](1.09,.84,.8,.75,.74,.65,1.21,1.33,1.05,.89,.7,.93,1.12,.82);
 const float depths[]=float[](18.,18.,18.,18.,18.,18.,19.,19.,17.,24.,23.,23.,21.,21.);
 int limb=group==3?i:group==4?i/36:i/(36*15*28),lat=group==4?i%36:(i/(15*28))%36,shoot=(i/28)%15,j=i%28;
 float z=depths[limb];vec4 b=limbs[limb]*1.74545;
 vec3 p0=place(b.xy,z),p1=place(b.zw,z+1.5),d=p1-p0;
 int seed=limb*101+lat;float t=group==3?u:(float(lat/2)+.12+.71*rnd(seed,4))/18.;
 vec3 root=mix(p0,p1,t)+vec3(0.,-.25,.26)*sin(PI*t);
 if(group==3){tag=-.1;return root+vec3(0.,(v-.5)*.08*pow(1.-u,1.7),0.);}
 float side=lat%2==0?-1.:1.;
 float width=1.17*spread[limb]*(.28+.72*pow(max(.0001,sin(PI*t)),.52))*(.6+.45*rnd(seed,3));
 vec3 branch=vec3(d.x*mix(.06,.19,rnd(seed,4))+side*width*.48,width*(side>0.?mix(-.15,.32,rnd(seed,1)):-1.)*mix(.7,1.55,rnd(seed,7)),width*side*.85);
 if(group==4){tag=21.;return root+u*branch+vec3(0.,(v-.5)*.04*(1.-u),0.);}
 vec3 axis=normalize(branch),s=normalize(cross(axis,vec3(0,1,0)));
 float f=(float(shoot)+mix(.05,.92,rnd(seed,shoot+22)))/15.,angle=float(shoot)*2.39996+.96*(rnd(seed,shoot+71)-.5);
 vec3 outDir=s*cos(angle)+cross(axis,s)*sin(angle);float scale=width*.67;
 vec3 spr=(outDir*.56+axis*.71+vec3(0,-.29,0))*scale*(1.-.61*f)*mix(.72,1.22,rnd(seed,shoot+56));
 vec3 az=normalize(spr),tangent=normalize(cross(az,vec3(0,1,0)));
 float g=(float(j)+mix(.07,.93,rnd(i,5)))/28.,phi=float(j)*2.39996+mix(-.47,.47,rnd(i,9));
 vec3 rad=tangent*cos(phi)+cross(az,tangent)*sin(phi);
 vec3 tip=(rad*.57+az*.65+vec3(0,-.16,0))*scale*mix(.21,.48,rnd(i,4))*(1.-.5*g);
 tag=.15+.29*f;return root+branch*f+spr*g+tip*u+cross(az,rad)*max(.006,scale*.017)*(1.-.37*g)*(2.*v-1.)*sin(PI*u);
 }
 if(group==6||group==7||group==13||group==14){
 bool close=group>=13;bool spine=group==7||group==14;
 int fr=spine?i:i/36,leaf=i%36;
 const vec2 starts[]=vec2[](vec2(275,895),vec2(405,893),vec2(843,1013),vec2(34,1119));
 int cluster=close?3:fr/7;int arm=fr%7;vec2 o=starts[cluster];
 float angle=mix(-2.95,-.20,(float(arm)+.4*rnd(fr,2))/7.);
 vec2 extent=vec2(cos(angle),sin(angle))*(cluster==3?245.:cluster==0?90.:46.)*(.66+.54*rnd(fr,7));
 float t=spine?u:(float(leaf/2)+.7)/19.;vec2 p=o+extent*t+vec2(0.,.42*abs(extent.x)*t*t-22.*t*(1.-t));
 if(spine)p.x+=(v-.5)*1.8;else{float side=leaf%2==0?-1.:1.;vec2 d=normalize(extent);
 float w=(cluster==3?49.:cluster==0?18.:9.)*(.22+.78*sin(PI*pow(t,.8)))*(.70+.48*rnd(i,2));
 vec2 dir=normalize(d*.52+side*vec2(-d.y,d.x));p+=w*(dir*u+vec2(-dir.y,dir.x)*(v-.5)*.37*sin(u*PI));}
 tag=close?25.125:13.125;return place(p,(close?7.1:15.35)+.08*t+.05*u);}
 if(group==8||group==9){
 bool stem=group==9;int flower=stem?i:i/9;vec2 o=flower==0?vec2(371,981):vec2(422,988);
 vec2 p;if(stem)p=o+vec2(-8.*sin(PI*u)+3.*u+(v-.5)*1.9,111.*u);
 else{float theta=6.283*float(i%9)/9.;p=o+vec2(cos(theta)*12.*u+(v-.5)*8.*sin(PI*u),4.*sin(theta)*u-11.*u*u);}
 if(!stem){float theta=6.283*float(i%9)/9.;p=o+vec2(cos(theta)*(4.+10.*u)+(v-.5)*10.*sin(PI*u),3.*sin(theta)*(1.+u)-7.*u*u+(v-.5)*4.*sin(PI*u));}tag=stem?16.125:18.125;return place(p,12.8+.05*float(flower)+.03*u);}
 if(group==10){
 int cl=i/3;vec2 o=cl<4?vec2(284,1060):cl<8?vec2(467,1060):vec2(72,908);
 o+=vec2(rnd(cl,2)-.5,rnd(cl,4)-.5)*(cl<8?49.:99.);
 float phi=float(i%3)*2.0944+5.*rnd(cl,7);vec2 dir=vec2(cos(phi),sin(phi)*.63);float w=cl<8?24.:39.;
 vec2 p=o+dir*u*w+vec2(-dir.y,dir.x)*(v-.5)*w*pow(max(0.,sin(PI*u)),.58);
 tag=14.125;return place(p,12.5+.05*float(cl)+.08*sin(u*PI));}
 if(group==11){vec2 o=i==0?vec2(506,988):vec2(592,1030);vec2 p=o+vec2(64.*u,31.*u+6.*sin(PI*u)+(v-.5)*19.*sin(PI*u));tag=15.125;return place(p,13.4+.05*abs(v-.5)+.11*sin(u*PI));}
 if(group==12){int cl=i/20;vec2 o=cl==0?vec2(643,956):cl==1?vec2(974,1067):vec2(150,871);
 float a=mix(-2.98,-.17,rnd(i,2));float len=mix(17.,62.,rnd(i,5));vec2 p=o+len*vec2(cos(a)*u,sin(a)*u+.19*u*u)+vec2((v-.5)*(1.-u)*3.2,0.);
 tag=20.125;return place(p,cl==2?16.6:13.7);}
 // Arching main stem, six lateral pedicels and their amber seed heads.
 vec2 o=vec2(149,871),d=vec2(40,-123);float t=group==15&&i==0?u:.58+.068*float(group==16?i:i-1);
 vec2 p=o+d*t+vec2(10.*sin(t*PI),0.);float f=i%2==0?-1.:1.;
 if(group==15){if(i>0)p+=vec2(f*17.,-11.)*u;p.x+=(v-.5)*1.7;tag=16.125;}
 else{p+=vec2(-f*17.,-11.)+vec2(cos(a)*sin(PI*v),cos(PI*v))*4.8;tag=17.125;}
 return place(p,16.3+.06*v);}
const int patchCount=274267;
void unpackPatch(int id,out int inst,out ivec2 cell,out ivec2 span){
 if(id<4800){group=0;cols=60;rows=36;int ix=id-0;inst=ix/240;span=ivec2(3,3);cell=ivec2(ix%20,(ix/20)%12)*span;return;}
 if(id<5000){group=1;cols=100;rows=4;int ix=id-4800;inst=ix/200;span=ivec2(2,1);cell=ivec2(ix%50,(ix/50)%4)*span;return;}
 if(id<6200){group=2;cols=48;rows=50;int ix=id-5000;inst=ix/600;span=ivec2(2,2);cell=ivec2(ix%24,(ix/24)%25)*span;return;}
 if(id<6424){group=3;cols=32;rows=1;int ix=id-6200;inst=ix/16;span=ivec2(2,1);cell=ivec2(ix%16,(ix/16)%1)*span;return;}
 if(id<7432){group=4;cols=6;rows=1;int ix=id-6424;inst=ix/2;span=ivec2(3,1);cell=ivec2(ix%2,(ix/2)%1)*span;return;}
 if(id<219112){group=5;cols=2;rows=1;int ix=id-7432;inst=ix/1;span=ivec2(2,1);cell=ivec2(ix%1,(ix/1)%1)*span;return;}
 if(id<219868){group=6;cols=4;rows=2;int ix=id-219112;inst=ix/1;span=ivec2(4,2);cell=ivec2(ix%1,(ix/1)%1)*span;return;}
 if(id<219973){group=7;cols=15;rows=1;int ix=id-219868;inst=ix/5;span=ivec2(3,1);cell=ivec2(ix%5,(ix/5)%1)*span;return;}
 if(id<220009){group=8;cols=6;rows=3;int ix=id-219973;inst=ix/2;span=ivec2(3,3);cell=ivec2(ix%2,(ix/2)%1)*span;return;}
 if(id<220017){group=9;cols=12;rows=1;int ix=id-220009;inst=ix/4;span=ivec2(3,1);cell=ivec2(ix%4,(ix/4)%1)*span;return;}
 if(id<220101){group=10;cols=10;rows=5;int ix=id-220017;inst=ix/2;span=ivec2(5,5);cell=ivec2(ix%2,(ix/2)%1)*span;return;}
 if(id<220105){group=11;cols=14;rows=5;int ix=id-220101;inst=ix/2;span=ivec2(7,5);cell=ivec2(ix%2,(ix/2)%1)*span;return;}
 if(id<220225){group=12;cols=8;rows=1;int ix=id-220105;inst=ix/2;span=ivec2(4,1);cell=ivec2(ix%2,(ix/2)%1)*span;return;}
 if(id<220729){group=13;cols=6;rows=2;int ix=id-220225;inst=ix/2;span=ivec2(3,2);cell=ivec2(ix%2,(ix/2)%1)*span;return;}
 if(id<220764){group=14;cols=15;rows=1;int ix=id-220729;inst=ix/5;span=ivec2(3,1);cell=ivec2(ix%5,(ix/5)%1)*span;return;}
 if(id<220785){group=15;cols=12;rows=1;int ix=id-220764;inst=ix/3;span=ivec2(4,1);cell=ivec2(ix%3,(ix/3)%1)*span;return;}
 if(id<220821){group=16;cols=12;rows=8;int ix=id-220785;inst=ix/6;span=ivec2(4,4);cell=ivec2(ix%3,(ix/3)%2)*span;return;}
 if(id<238741){group=17;cols=3;rows=2;int ix=id-220821;inst=ix/1;span=ivec2(3,2);cell=ivec2(ix%1,(ix/1)%1)*span;return;}
 if(id<270741){group=18;cols=10;rows=1;int ix=id-238741;inst=ix/1;span=ivec2(10,1);cell=ivec2(ix%1,(ix/1)%1)*span;return;}
 if(id<270747){group=19;cols=12;rows=1;int ix=id-270741;inst=ix/6;span=ivec2(2,1);cell=ivec2(ix%6,(ix/6)%1)*span;return;}
 if(id<274267){group=20;cols=10;rows=6;int ix=id-270747;inst=ix/4;span=ivec2(5,3);cell=ivec2(ix%2,(ix/2)%2)*span;return;}
 inst=0;cell=ivec2(0);span=ivec2(1);}



vec3 lightProject(vec3 p){
    vec3 l=normalize(vec3(-.94*.329,.080+.014*.88,1.));
    vec3 r=normalize(cross(l,vec3(0,1,0))),u=cross(r,l),d=p-vec3(-6,63.8,17);
    return vec3(512.+512.*vec2(dot(d,r),dot(d,u))/11.,.5-.5*dot(d,l)/27.);
}
vec3 shadowVertex(int inst,vec2 uv){
    float tag;vec3 p=surface(inst,uv,tag);
    p.x+=.45*(tag>1.?0.:max(tag,0.))*.081*sin(p.z*.16+p.y*.21);
    return lightProject(p);
}
vec4 shadowBounds(int id){
    if(id>=270747||(id>=220225&&id<220764))return vec4(0);
    int inst;ivec2 cell,span;unpackPatch(id,inst,cell,span);
    vec3 lo=vec3(1e10),hi=-lo;
    for(int y=0;y<=span.y;y++)for(int x=0;x<=span.x;x++){
        vec3 p=shadowVertex(inst,vec2(cell+ivec2(x,y))/vec2(cols,rows));
        lo=min(lo,p);hi=max(hi,p);
    }
    if(any(lessThan(hi,vec3(0)))||any(greaterThan(lo,vec3(1024,1024,1))))return vec4(0);
    vec2 lower=max(lo.xy,vec2(0)),upper=min(hi.xy,vec2(1023.999));
    float radius=.5*max(upper.x-lower.x,upper.y-lower.y);
    int level=int(ceil(log2(max(1.,radius/2.))));
    return vec4((lower+upper)*.5,1.+float(level),float(id));
}
int levelStart(int level){return (1048576-(1048576>>(2*level)))/3;}
int lightKey(vec4 record){
    if(record.z<=0.)return 999999;
    int level=int(record.z)-1;float tile=2.*exp2(float(level));
    ivec2 cell=ivec2(record.xy/tile);return levelStart(level)+cell.y*(512>>level)+cell.x;
}
ivec2 loc(int i){int w=int(iResolution.x);return ivec2(i%w,i/w);}
vec4 previous(int i){return texelFetch(iChannel0,loc(i),0);}
int firstLight(int key){
    int lo=0,hi=524288;
    for(int k=0;k<20;k++){if(lo>=hi)break;int mid=(lo+hi)/2;
        if(lightKey(previous(mid))<key)lo=mid+1;else hi=mid;
    }return lo;
}
vec4 lightSort(int id){
    if(iFrame==0)return shadowBounds(id);
    vec4 a=previous(id);
    if(iFrame>190)return a;
    int stepN=iFrame-1,stage=1;
    for(int k=1;k<=19;k++){if(stepN<k){stage=k;break;}stepN-=k;}
    int stride=1<<(stage-1-stepN);
    vec4 b=previous(id^stride);int ka=lightKey(a),kb=lightKey(b);
    bool first=ka<kb||(ka==kb&&a.w<=b.w);
    bool low=((id&(1<<stage))==0)==((id&stride)==0);return low==first?a:b;
}
void shadowTriangle(vec2 pos,vec3 a,vec3 b,vec3 c,inout float z){
    vec2 ab=b.xy-a.xy,ac=c.xy-a.xy,q=pos-a.xy;float det=cross2(ab,ac);
    if(abs(det)<.000001)return;
    float u=cross2(q,ac)/det,v=cross2(ab,q)/det;
    if(min(min(u,v),1.-u-v)<0.)return;
    float h=a.z+u*(b.z-a.z)+v*(c.z-a.z);
    if(h>=0.)z=min(z,h);
}
void shadowPatch(vec2 pos,int id,inout float depth){
    int inst;ivec2 cell,span;unpackPatch(id,inst,cell,span);
    vec2 stepUV=1./vec2(cols,rows);
    for(int y=0;y<span.y;y++)for(int x=0;x<span.x;x++){
        vec2 uv=vec2(cell+ivec2(x,y))*stepUV;
        vec3 a=shadowVertex(inst,uv),b=shadowVertex(inst,uv+vec2(stepUV.x,0)),
             c=shadowVertex(inst,uv+stepUV),d=shadowVertex(inst,uv+vec2(0,stepUV.y));
        shadowTriangle(pos,a,b,c,depth);shadowTriangle(pos,a,c,d,depth);
    }
}
float shadowDepth(vec2 pos){
    float depth=1.;
    for(int level=0;level<9;level++){
        float tile=2.*exp2(float(level));ivec2 center=ivec2(pos/tile);int count=512>>level;
        for(int y=-1;y<=1;y++)for(int x=-1;x<=1;x++){
            ivec2 cell=center+ivec2(x,y);
            if(any(lessThan(cell,ivec2(0)))||any(greaterThanEqual(cell,ivec2(count))))continue;
            int key=levelStart(level)+cell.y*count+cell.x;
            ivec2 range=ivec2(previous(524288+key).xy);
            for(int j=0;j<range.y;j++){
                vec4 record=previous(range.x+j);
                if(any(greaterThan(abs(record.xy-pos),vec2(tile))))continue;
                shadowPatch(pos,int(record.w),depth);
            }
        }
    }return depth;
}
vec3 renderMirror(vec2 pixel){
    truck=cameraTruck();phase=iTime*6.2831853/(124./24.);
    vec3 eye=cameraEye();eye.y=-eye.y;
    vec3 sum=vec3(0);
    const vec2 offsets[4]=vec2[4](vec2(-.125,-.375),vec2(.375,-.125),vec2(-.375,.125),vec2(.125,.375));
    for(int i=0;i<4;i++){
        vec2 uv=(pixel+vec2(322.,0.)+offsets[i])/vec2(1344,756);
        vec3 rd=vec3((uv.x-.5)*2.*(16./9.)/2.6-truck/325.,-(uv.y-.57)*2./2.6,1.);
        float z;sum+=clamp(environment(eye,rd,true,1600.,z),0.,1.);
    }
    return round(sum*.25*255.)/255.;
}
void mainImage(out vec4 c,in vec2 px){
 int atlasH=int(floor(.68*iResolution.y));if(int(px.y)>=atlasH){
 int address=int(px.x)+(int(px.y)-atlasH)*int(iResolution.x);
 if(address>=184*84*35){c=iFrame>=192?lensFern(address-184*84*35):vec4(0);return;}
 if(iFrame<192){c=vec4(0);return;}
 if(iFrame>192){c=texelFetch(iChannel0,ivec2(px),0);return;}
 int X=address%184-30+48,Y=(address/184)%84-5+48,bandGroup=address/(184*84);
 int key=(bandGroup*256+Y)*256+X;int first=firstPatch(key);
 c=vec4(first,firstPatch(key+1)-first,0,0);return;}
 if(iFrame>=193&&px.x<1022.&&px.y<413.){c=vec4(renderMirror(px),1.);return;}
 int id=int(px.x)+int(px.y)*int(iResolution.x);
 if(id<524288){c=lightSort(id);return;}
 if(iFrame>192){c=previous(id);return;}
 if(id<524288+levelStart(9)){
     c=vec4(0);if(iFrame<191)return;
     if(iFrame>191){c=previous(id);return;}
     int key=id-524288;
     int first=firstLight(key);c=vec4(first,firstLight(key+1)-first,0,1);return;
 }
 int at=id-900000;
 if(at<0||at>=262144||iFrame<192){c=vec4(0);return;}
 ivec2 corner=2*ivec2(at%512,at/512);
 c=vec4(shadowDepth(vec2(corner)+1.));
}

#elif VALLEY_PASS == 3
float rnd(int x,int seed){uint h=uint(x)*747796405u+uint(seed)*2891336453u+277803737u;h=((h>>((h>>28u)+4u))^h)*277803737u;return float((h>>22u)^h)/4294967296.;}
float noise2(vec2 p){ivec2 i=ivec2(floor(p));vec2 f=fract(p);f=f*f*(3.-2.*f);return mix(mix(rnd(i.x,i.y),rnd(i.x+1,i.y),f.x),mix(rnd(i.x,i.y+1),rnd(i.x+1,i.y+1),f.x),f.y);}

struct TreeView {int rings;int arms;int shoots;int variant;float rotation;float orange;float aspect;float tilt;};
TreeView design(int lod,int variant,float angle,float orange,float aspect,float tilt){
 return TreeView(lod==0?19:lod==1?12:8,lod==0?6:5,lod==0?5:lod==1?3:1,variant,angle,orange,aspect,tilt);
}
struct SampleVertex{vec3 pos;vec3 normal;float exposure;float sunSide;vec3 local;};
vec2 rayShear;float treeBend;
SampleVertex projectSpray(int id,TreeView v){
 int address=18*(790*v.variant+(v.rings==19?0:v.rings==12?570:750))+2*id;
 ivec2 at=ivec2(address%768,769+address/768);
 vec3 point=texelFetch(iChannel0,at,0).xyz;
 vec4 radial=texelFetch(iChannel0,at+ivec2(1,0),0);
 float a=v.rotation;mat2 rot=mat2(cos(a),sin(a),-sin(a),cos(a));
 vec2 offset=rot*point.xz;
 float sunSide=smoothstep(-.14,.91,dot(normalize(offset+vec2(.0001)),normalize(vec2(-.94*.329*3.1,.42))));
 offset*=v.aspect*(1.+.22*v.orange);
 vec2 rn=rot*radial.xz;vec3 n=normalize(vec3(rn.x,radial.y+.04,rn.y));
 vec3 local=vec3(offset.x+treeBend*point.y*point.y,point.y,offset.y);
 return SampleVertex(vec3(local.xy-rayShear*offset.y,offset.y),n,radial.w,sunSide,local);
}
float cross2(vec2 a,vec2 b){return a.x*b.y-a.y*b.x;}
struct CrownHit {float depth;vec3 normal;float exposure;float sunSide;vec3 local;};
void hitTriangle(vec2 pixel, SampleVertex a, SampleVertex b, SampleVertex c,inout CrownHit hit){
 vec2 e=b.pos.xy-a.pos.xy,f=c.pos.xy-a.pos.xy,q=pixel-a.pos.xy;
 float area=cross2(e,f);if(abs(area)<1.e-11)return;
 vec3 w;w.y=cross2(q,f)/area;w.z=cross2(e,q)/area;w.x=1.-w.y-w.z;
 if(min(w.x,min(w.y,w.z))<0.)return;
 float z=dot(w,vec3(a.pos.z,b.pos.z,c.pos.z));if(z>=hit.depth)return;
 hit=CrownHit(z,a.normal*w.x+b.normal*w.y+c.normal*w.z,
 dot(w,vec3(a.exposure,b.exposure,c.exposure)),dot(w,vec3(a.sunSide,b.sunSide,c.sunSide)),
 a.local*w.x+b.local*w.y+c.local*w.z);
}
// Bound the rotated, sheared shoot in screen space. Wind contributes
// at most |bend| * max(y*y). Keep a float-rounding margin at the edges.
bool outsideShoot(vec2 pixel, int index, TreeView v){
    int slot=index*2;
    ivec2 at=ivec2(slot%768,825+slot/768);
    vec3 low=texelFetch(iChannel0,at,0).xyz;
    vec3 high=texelFetch(iChannel0,at+ivec2(1,0),0).xyz;
    vec3 center=(low+high)*.5, halfSize=(high-low)*.5;
    float sn=sin(v.rotation), cs=cos(v.rotation);
    float scale=v.aspect*(1.+.22*v.orange);
    vec2 xAxis=scale*(vec2(cs,-sn)-rayShear.x*vec2(sn,cs));
    vec2 yAxis=-scale*rayShear.y*vec2(sn,cs);
    vec2 mid=vec2(dot(xAxis,center.xz),center.y+dot(yAxis,center.xz));
    vec2 radius=vec2(dot(abs(xAxis),halfSize.xz),halfSize.y+dot(abs(yAxis),halfSize.xz));
    radius.x+=abs(treeBend)*max(low.y*low.y,high.y*high.y);
    return any(greaterThan(abs(pixel-mid),radius+vec2(.00002)));
}
bool hitCrown(vec2 pixel,TreeView v,out CrownHit hit){
 hit=CrownHit(2.,vec3(0),0.,0.,vec3(0));
 if(pixel.y<-.12||pixel.y>1.05||abs(pixel.x)>.40)return false;
 for(int tier=0;tier<19;tier++){
 if(tier>=v.rings)break;
 float t=(float(tier)+.37)/float(v.rings),axis=.10+.87*t;
 float maxReach=.17*pow(1.-t,.74)*1.28;
 if(abs(pixel.x)>maxReach*2.2 || pixel.y>axis+.41/float(v.rings)+maxReach*(.45+.5*abs(v.tilt))
 ||pixel.y<axis-.41/float(v.rings)-maxReach*(.98+1.7*abs(v.tilt)))continue;
 for(int arm=0;arm<6;arm++){if(arm>=v.arms)break;
 for(int shoot=0;shoot<5;shoot++){if(shoot>=v.shoots)break;
 int start=((tier*v.arms+arm)*v.shoots+shoot)*36;
 int index=790*v.variant+(v.rings==19?0:v.rings==12?570:750)+start/36;
 if(outsideShoot(pixel,index,v))continue;
 // Nine unique vertices per tapered shoot. Test its projected box first.
 SampleVertex verts[9];vec2 lo=vec2(9),hi=vec2(-9);
 for(int j=0;j<3;j++)for(int k=0;k<3;k++){
 int id=start/36*9+j*3+k;
 SampleVertex pt=projectSpray(id,v);verts[3*j+k]=pt;
 lo=min(lo,pt.pos.xy);hi=max(hi,pt.pos.xy);}
 if(any(lessThan(pixel,lo))||any(greaterThan(pixel,hi)))continue;
 for(int j=0;j<2;j++)for(int k=0;k<3;k++){int a=3*j+k,b=3*j+(k+1)%3;
 hitTriangle(pixel,verts[a],verts[b],verts[a+3],hit);hitTriangle(pixel,verts[b],verts[b+3],verts[a+3],hit);}
 }}}
 return hit.depth<1.;
}


// Library code below is bundled from shader-skills (MIT): https://github.com/gokayfem/shader-skills
// ---- shader-skills library: common ----
const float PI  = 3.14159265358979;
const float TAU = 6.28318530717959;

// ---- shader-skills library: hash ----
// PCG-style 1D integer hash.
uint pcgHash(uint v) {
    uint state = v * 747796405u + 2891336453u;
    uint word = ((state >> ((state >> 28u) + 4u)) ^ state) * 277803737u;
    return (word >> 22u) ^ word;
}
// 3D integer hash, three decorrelated outputs.
uvec3 pcg3d(uvec3 v) {
    v = v * 1664525u + 1013904223u;
    v.x += v.y * v.z;
    v.y += v.z * v.x;
    v.z += v.x * v.y;
    v ^= v >> 16u;
    v.x += v.y * v.z;
    v.y += v.z * v.x;
    v.z += v.x * v.y;
    return v;
}
// Map a uint to [0,1) using the top 24 bits, so the result can never round up to 1.0.
float uintToUnit(uint h) { return float(h >> 8u) * (1.0 / 16777216.0); }
vec2 uintToUnit(uvec2 h) { return vec2(h >> 8u) * (1.0 / 16777216.0); }
vec3 uintToUnit(uvec3 h) { return vec3(h >> 8u) * (1.0 / 16777216.0); }
vec4 uintToUnit(uvec4 h) { return vec4(h >> 8u) * (1.0 / 16777216.0); }
// Random float in [0,1) for an integer-valued 2D input.
float hash12(vec2 p) {
    uvec2 q = uvec2(ivec2(floor(p)));
    return uintToUnit(pcgHash(q.x + pcgHash(q.y)));
}
// Random vec3 in [0,1)^3 for an integer-valued 3D input.
vec3 hash33(vec3 p) { return uintToUnit(pcg3d(uvec3(ivec3(floor(p))))); }

// ---- shader-skills library: noise ----
// Quintic fade 6t^5 - 15t^4 + 10t^3: C2-continuous interpolation weights for lattice noise.
vec2 quinticFade(vec2 f) { return f * f * f * (f * (f * 6.0 - 15.0) + 10.0); }
vec3 quinticFade(vec3 f) { return f * f * f * (f * (f * 6.0 - 15.0) + 10.0); }
// Derivative of quinticFade: 30 t^2 (t - 1)^2.
vec2 quinticFadeDeriv(vec2 f) { return 30.0 * f * f * (f * (f - 2.0) + 1.0); }
vec3 quinticFadeDeriv(vec3 f) { return 30.0 * f * f * (f * (f - 2.0) + 1.0); }
// Unit gradient for a 2D lattice point.
vec2 latticeGradient(vec2 cell) {
    float a = TAU * hash12(cell);
    return vec2(cos(a), sin(a));
}
// 2D gradient (Perlin-style) noise with analytic derivatives. Returns vec3(value, d/dx, d/dy). Gradient noise has less grid-aligned blockiness than value noise. Prefer it for fBm.
vec3 gradientNoiseD(vec2 p) {
    vec2 i = floor(p), f = fract(p);
    vec2 u = quinticFade(f), du = quinticFadeDeriv(f);
    vec2 ga = latticeGradient(i);
    vec2 gb = latticeGradient(i + vec2(1.0, 0.0));
    vec2 gc = latticeGradient(i + vec2(0.0, 1.0));
    vec2 gd = latticeGradient(i + vec2(1.0, 1.0));
    float va = dot(ga, f);
    float vb = dot(gb, f - vec2(1.0, 0.0));
    float vc = dot(gc, f - vec2(0.0, 1.0));
    float vd = dot(gd, f - vec2(1.0, 1.0));
    float k = va - vb - vc + vd;
    float value = va + u.x * (vb - va) + u.y * (vc - va) + u.x * u.y * k;
    vec2 deriv = ga + u.x * (gb - ga) + u.y * (gc - ga) + u.x * u.y * (ga - gb - gc + gd)
               + du * (vec2(vb - va, vc - va) + u.yx * k);
    return vec3(value, deriv);
}
// 2D gradient noise.
float gradientNoise(vec2 p) { return gradientNoiseD(p).x; }
// Dot product of a hashed 3D gradient with the offset to its lattice corner.
float latticeGradDot(vec3 cell, vec3 corner, vec3 f) {
    vec3 g = hash33(cell + corner) * 2.0 - 1.0;
    return dot(g, f - corner);
}
// 3D gradient noise.
float gradientNoise(vec3 p) {
    vec3 i = floor(p), f = fract(p);
    vec3 u = quinticFade(f);
    return mix(mix(mix(latticeGradDot(i, vec3(0, 0, 0), f), latticeGradDot(i, vec3(1, 0, 0), f), u.x),
                   mix(latticeGradDot(i, vec3(0, 1, 0), f), latticeGradDot(i, vec3(1, 1, 0), f), u.x), u.y),
               mix(mix(latticeGradDot(i, vec3(0, 0, 1), f), latticeGradDot(i, vec3(1, 0, 1), f), u.x),
                   mix(latticeGradDot(i, vec3(0, 1, 1), f), latticeGradDot(i, vec3(1, 1, 1), f), u.x), u.y), u.z);
}
// 3D gradient noise with analytic derivatives. Returns vec4(value, d/dx, d/dy, d/dz); value equals gradientNoise(p). The trilinear blend is expanded as a polynomial in the fade weights, so the gradient is the same blend of the corner gradients plus the chain-rule term of the fade.
vec4 gradientNoiseD(vec3 p) {
    vec3 i = floor(p), f = fract(p);
    vec3 u = quinticFade(f), du = quinticFadeDeriv(f);
    vec3 g000 = hash33(i) * 2.0 - 1.0;
    vec3 g100 = hash33(i + vec3(1, 0, 0)) * 2.0 - 1.0;
    vec3 g010 = hash33(i + vec3(0, 1, 0)) * 2.0 - 1.0;
    vec3 g110 = hash33(i + vec3(1, 1, 0)) * 2.0 - 1.0;
    vec3 g001 = hash33(i + vec3(0, 0, 1)) * 2.0 - 1.0;
    vec3 g101 = hash33(i + vec3(1, 0, 1)) * 2.0 - 1.0;
    vec3 g011 = hash33(i + vec3(0, 1, 1)) * 2.0 - 1.0;
    vec3 g111 = hash33(i + vec3(1, 1, 1)) * 2.0 - 1.0;
    float v000 = dot(g000, f);
    float v100 = dot(g100, f - vec3(1, 0, 0));
    float v010 = dot(g010, f - vec3(0, 1, 0));
    float v110 = dot(g110, f - vec3(1, 1, 0));
    float v001 = dot(g001, f - vec3(0, 0, 1));
    float v101 = dot(g101, f - vec3(1, 0, 1));
    float v011 = dot(g011, f - vec3(0, 1, 1));
    float v111 = dot(g111, f - vec3(1, 1, 1));
    // value = v000 + kx u.x + ky u.y + kz u.z + kxy u.x u.y + kyz u.y u.z + kzx u.z u.x + kxyz u.x u.y u.z
    float kx = v100 - v000, ky = v010 - v000, kz = v001 - v000;
    float kxy = v000 - v100 - v010 + v110;
    float kyz = v000 - v010 - v001 + v011;
    float kzx = v000 - v100 - v001 + v101;
    float kxyz = -v000 + v100 + v010 - v110 + v001 - v101 - v011 + v111;
    float value = v000 + kx * u.x + ky * u.y + kz * u.z
                + kxy * u.x * u.y + kyz * u.y * u.z + kzx * u.z * u.x + kxyz * u.x * u.y * u.z;
    vec3 grad = g000 + (g100 - g000) * u.x + (g010 - g000) * u.y + (g001 - g000) * u.z
              + (g000 - g100 - g010 + g110) * u.x * u.y
              + (g000 - g010 - g001 + g011) * u.y * u.z
              + (g000 - g100 - g001 + g101) * u.z * u.x
              + (-g000 + g100 + g010 - g110 + g001 - g101 - g011 + g111) * u.x * u.y * u.z
              + du * vec3(kx + kxy * u.y + kzx * u.z + kxyz * u.y * u.z,
                          ky + kxy * u.x + kyz * u.z + kxyz * u.x * u.z,
                          kz + kyz * u.y + kzx * u.x + kxyz * u.x * u.y);
    return vec4(value, grad);
}
const int FBM_MAX_OCTAVES = 12;
// Fractional Brownian motion over 2D gradient noise. Each octave is rotated to hide lattice alignment. persistence 0.5 is the classic look (H = 1). Lower is smoother, higher is rougher.
float fbm(vec2 p, int octaves, float lacunarity, float persistence) {
    const mat2 octaveRotation = mat2(0.8, 0.6, -0.6, 0.8);
    float sum = 0.0, amp = 1.0, norm = 0.0;
    for (int i = 0; i < FBM_MAX_OCTAVES; i++) {
        if (i >= octaves) break;
        sum += amp * gradientNoise(p);
        norm += amp;
        amp *= persistence;
        p = lacunarity * (octaveRotation * p) + vec2(17.13, -3.71);
    }
    return 1.4 * sum / norm;
}
// 2D fBm with the usual defaults (lacunarity 2.01 so octave peaks never re-align, persistence 0.5).
float fbm(vec2 p, int octaves) { return fbm(p, octaves, 2.01, 0.5); }
// fBm over 3D gradient noise.
float fbm(vec3 p, int octaves, float lacunarity, float persistence) {
    const mat3 octaveRotation = mat3(0.00, 0.80, 0.60,
                                     -0.80, 0.36, -0.48,
                                     -0.60, -0.48, 0.64);
    float sum = 0.0, amp = 1.0, norm = 0.0;
    for (int i = 0; i < FBM_MAX_OCTAVES; i++) {
        if (i >= octaves) break;
        sum += amp * gradientNoise(p);
        norm += amp;
        amp *= persistence;
        p = lacunarity * (octaveRotation * p) + vec3(17.13, -3.71, 5.29);
    }
    return sum / norm;
}
// Terrain fBm where each octave is damped by the accumulated slope, so detail settles in valleys and steep slopes stay smooth. This gives an eroded look without simulation.
float erodedFbm(vec2 p, int octaves) {
    const mat2 octaveRotation = mat2(0.8, 0.6, -0.6, 0.8);
    float h = 0.0, amp = 0.5;
    vec2 slope = vec2(0.0);
    for (int i = 0; i < FBM_MAX_OCTAVES; i++) {
        if (i >= octaves) break;
        vec3 n = gradientNoiseD(p);
        slope += n.yz;
        h += amp * n.x / (1.0 + dot(slope, slope));
        amp *= 0.5;
        p = 2.0 * (octaveRotation * p);
    }
    return 2.0 * h;
}
// Ridged multifractal: inverted |noise| creates sharp crests; each octave is weighted by the previous one, so detail gathers along ridges.
float ridgedFbm(vec2 p, int octaves) {
    const mat2 octaveRotation = mat2(0.8, 0.6, -0.6, 0.8);
    float sum = 0.0, amp = 0.5, weight = 1.0, norm = 0.0;
    for (int i = 0; i < FBM_MAX_OCTAVES; i++) {
        if (i >= octaves) break;
        float n = 1.0 - abs(gradientNoise(p) * 1.4);
        n *= n;
        sum += amp * n * weight;
        norm += amp;
        weight = clamp(n * 2.0, 0.0, 1.0);
        amp *= 0.5;
        p = 2.01 * (octaveRotation * p) + vec2(17.13, -3.71);
    }
    return sum / norm;
}

// ---- shader-skills library: water ----
// Exact unpolarized dielectric Fresnel for a positive incident cosine and positive refractive indices. Returns 1 for total internal reflection. Caller chooses etaIncident/etaTransmitted for the ray's side.
float fresnelDielectric(float cosIncident, float etaIncident, float etaTransmitted) {
    float ci = clamp(abs(cosIncident),0.0,1.0);
    float ei = max(etaIncident,0.000001), et = max(etaTransmitted,0.000001);
    if (abs(ei-et)<0.0000001) return 0.0;
    float sinT2 = (ei*ei)/(et*et)*max(0.0,1.0-ci*ci);
    if (sinT2>=1.0) return 1.0;
    float ct = sqrt(max(0.0,1.0-sinT2));
    float rs = (ei*ci-et*ct)/max(ei*ci+et*ct,0.000001);
    float rp = (et*ci-ei*ct)/max(et*ci+ei*ct,0.000001);
    return clamp(0.5*(rs*rs+rp*rp),0.0,1.0);
}

// ---- shader-skills library: color ----
// Exact sRGB decode (EOTF): encoded [0,1] -> linear.
vec3 srgbToLinear(vec3 c) {
    c = max(c, 0.0);
    return mix(c / 12.92, pow((c + 0.055) / 1.055, vec3(2.4)), step(0.04045, c));
}
// Exact sRGB encode (OETF): linear -> display [0,1]. Apply exactly once, after tonemapping. pow(c, 1/2.2) is visibly wrong near black (0.001 encodes to 0.013 here vs 0.043 with 2.2).
vec3 linearToSrgb(vec3 c) {
    c = max(c, 0.0);
    return mix(c * 12.92, 1.055 * pow(c, vec3(1.0 / 2.4)) - 0.055, step(0.0031308, c));
}

// ---- shader-skills library: volume ----
// Henyey-Greenstein phase function. g in (-1, 1): > 0 forward (silver linings), < 0 backward.
float phaseHG(float mu, float g) {
    float g2 = g * g;
    return (1.0 - g2) / (4.0 * PI * pow(max(1.0 + g2 - 2.0 * g * mu, 1e-6), 1.5));
}
// Distance fog amount (0 = clear, 1 = fully fogged) for distance t.
float distanceFog(float t, float density) { return 1.0 - exp(-t * density); }
// Analytic height fog for density a * exp(-b * y) along the ray segment [0, t]. Thick near the ground, thin above. Returns the fog amount in [0,1].
float heightFog(vec3 ro, vec3 rd, float t, float a, float b) {
    float base = a * exp(-ro.y * b);
    float amount = (abs(rd.y) < 1e-4) ? base * t
                                       : base * (1.0 - exp(-t * rd.y * b)) / (rd.y * b);
    return 1.0 - exp(-max(amount, 0.0));
}


vec3 shadeCrown(vec3 p,vec3 worldNormal,float exposureValue,float sunSide,float orange,float skyVisibility){
 vec3 c;vec3 sun=normalize(vec3(-.94*.329,.080+.014*.88,1.));
 vec3 sunColor=mix(vec3(.46,.52,.89),vec3(1.52,.83,.42),.88);

        vec3 n=normalize(worldNormal);
        float exposure=clamp(exposureValue,0.,1.);
        float pores=fbm(p.xz*1.4+vec2(p.y*.31,p.y*.72),3);
        float visibleSky=clamp(.51+.36*n.y+.25*exposure+.18*pores,.13,1.);
        float wrap=clamp(.39+.61*dot(n,sun),0.,1.);
        vec3 albedo=srgbToLinear(mix(vec3(.145,.245,.230),vec3(.53,.369,.211),orange));
        float visibility=skyVisibility;
        float skylight=(.28+.73*visibleSky)*(.47+.53*exposure);
        c=albedo*(vec3(.72,.86,1.07)*skylight+sunColor*(.19+.63*sunSide)*wrap*visibility);
        float transmission=smoothstep(.32,.87,exposure)*sunSide*(.24+.76*wrap)*visibility;
        c+=srgbToLinear(mix(vec3(.46,.34,.178),vec3(.66,.482,.283),orange))*transmission;
         c*=.9+.46*pores;return linearToSrgb(c);
}

// Four adjacent, procedurally evaluated elevation samples share one texel.
float elevationNode(ivec2 node){
    node=clamp(node,ivec2(0),ivec2(1536));
    vec4 values=texelFetch(iChannel0,node/2,0);
    return values[(node.y%2)*2+node.x%2];
}
vec2 elevationComponents(ivec2 node){
    float units=(elevationNode(node)+48.)*128.;
    return vec2(floor(units/256.),mod(units,256.));
}
float bed(vec2 world){
    vec2 at=(world+vec2(1100,40))/vec2(2200,1800)*1537.-.5;
    ivec2 i=ivec2(floor(at));
    // Match fixed-point bilinear filtering of the approved renderer's procedural elevation target.
    vec2 f=floor(fract(at)*256.+.5)/256.;
    vec2 value=mix(mix(elevationComponents(i),elevationComponents(i+ivec2(1,0)),f.x),
                   mix(elevationComponents(i+ivec2(0,1)),elevationComponents(i+ivec2(1)),f.x),f.y);
    return dot(floor(value*16.+.5)/16.,vec2(256,1))/128.-48.;
}
vec2 rockSurvey(vec2 world){
    vec2 local=world-vec2(-100,320);
    if(any(lessThan(local,vec2(0)))||any(greaterThanEqual(local,vec2(1024,768))))return vec2(0);
    vec2 texel=vec2(769,0)+clamp(local,vec2(.5),vec2(1023.5,767.5));
    return textureLod(iChannel0,texel/iChannelResolution[0].xy,0.).rg;
}
float cap(vec2 world){return rockSurvey(world).x;}
float mantle(vec2 world,float h){return rockSurvey(world).y;}


float treeHeight(vec4 r){return fract(r.w/32.)*32.;}
int treeStyle(vec4 r){return int(r.w/32.)%8;}
float isLarch(vec4 r){return float(int(r.w/256.)%2);}
int treeLevel(float z){return z<200.?0:z<410.?1:2;}
vec2 tileSize(int level){return level==0?vec2(96,256):level==1?vec2(64,128):vec2(32,64);}
int tileKey(vec2 pix,int level){ivec2 cell=ivec2(floor(pix/tileSize(level)))+ivec2(20,24);return level*65536+clamp(cell.y,0,255)*256+clamp(cell.x,0,255);}
int rootKey(vec4 root,bool mirrorView){if(root.z<=0.)return 999999;
 vec2 xy=vec2(960.+root.x*1404./root.z,464.4+(70.-(mirrorView?-1.:1.)*(root.y+.5*treeHeight(root)))*1404./root.z);
 return tileKey(xy,treeLevel(root.z));}
ivec2 sortAddress(int i,bool mirrorView){int linear=i+(mirrorView?262144:0);return ivec2(linear%int(iChannelResolution[1].x),linear/int(iChannelResolution[1].x));}

const vec4 controls=vec4(-.94,.88,.53,.45);float phase,truck;const int integrated=1,stage=6;const float spacing=.9;
vec3 sunlight(){return normalize(vec3(controls.x*.329,.080+.014*controls.y,1.));}
bool hasGround(){return true;}float baseHeight(vec2 p){return bed(p);}
vec4 contactAt(vec2 p){return vec4(rockSurvey(p),0,1);}
float castVisibility(vec3 p,vec3 sun,bool includeGround){
    if(p.z<215.||p.z>1100.||p.x< -155.||p.x>930.)return 1.;
    float shade=0.;
    for(int i=0;i<16;i++){
        float t=2.8*exp2(float(i)*.48);
        vec3 q=p+sun*t;
        vec4 field=contactAt(q.xz);
        float solid=field.x;
        if(includeGround || field.y>.1)solid=max(solid,baseHeight(q.xz)+field.y);
        float penumbra=.65+t*.032;
        shade=max(shade,smoothstep(-penumbra,penumbra,solid+field.z-q.y-1.9));
    }
    return 1.-.62*shade;
}
vec3 ambientLight(){return mix(vec3(.32,.42,.64),vec3(.42,.48,.54),controls.y);}
vec3 film(vec3 c){return linearToSrgb(clamp(c,0.,1.));}
vec3 key(){return mix(vec3(.46,.52,.89),vec3(1.52,.83,.42),controls.y);}
vec3 airColor(float scatter){
    return srgbToLinear(mix(vec3(.486,.503,.653),vec3(1.,.830,.721),smoothstep(.14,.86,scatter)));
}
float forwardLight(vec3 ray){
    return clamp(phaseHG(dot(ray,sunlight()),.70)/phaseHG(1.,.70),0.,1.);
}
vec3 valleyAir(vec3 c,vec3 worldPos,vec3 cameraPos){
    vec3 delta=worldPos-cameraPos;float z=length(delta);vec3 ray=delta/max(z,.01);
    float forward=forwardLight(ray);
    float ext=(.00012+.0026*pow(forward,2.2))*controls.z*1.8;
    float distanceVeil=distanceFog(z,ext);
    float bank=exp(-abs(worldPos.y-5.)*.20);
    float folds=.61+.38*sin(worldPos.z*.037+.48*gradientNoise(worldPos.xz*.022));
    float low=heightFog(cameraPos,ray,z,.012*controls.z,.078)*(.42+.48*folds);
    float nearFactor=smoothstep(150.,360.,z);
    distanceVeil*=.40+.60*nearFactor;
    float veil=clamp(distanceVeil+.34*bank*folds*controls.z+low,0.,.93);
    // Intersect each view ray with two drifting, shallow ground-mist bands.
    for(int layer=0;layer<2;layer++){
        float h=layer==0?5.1:14.3;
        float t=(cameraPos.y-h)/max(.0001,-ray.y);
        vec3 at=cameraPos+t*ray;
        float reach=exp(-pow((at.z-(layer==0?312.:506.))/(layer==0?65.:82.),2.));
        float field=.72+.40*gradientNoise(at.xz*vec2(.028,.062)+vec2(.32*sin(phase),0.));
        veil+=controls.z*.53*reach*field*smoothstep(t-16.,t+11.,z);
    }
    for(int i=0;i<2;i++){
        float bandZ=i==0?245.:376.;
        float at=(bandZ-cameraPos.z)/max(.01,ray.z);
        vec3 q=cameraPos+ray*at;
        float drift=gradientNoise(vec2(q.x*.026+sin(phase)*.19,bandZ*.038));
        float density=exp(-pow((q.y-3.3-2.8*drift)/(i==0?2.2:3.5),2.));
        veil+=controls.z*.59*density*(.57+.52*drift)*smoothstep(at-12.,at+9.,z);
    }
    veil=min(veil,.94);
    float upperMist=exp(-pow((worldPos.y-49.)/18.,2.))*smoothstep(325.,690.,z);
    veil+=upperMist*.57*controls.z*.87;
    vec3 air=airColor(forward);
    air+=key()*.28*forward*upperMist;
    c=mix(c,air,clamp(veil,0.,.95));
    // Two finite banks lie in successive hollows. Integrate only the length
    // of the viewing ray in front of the surface, so nearer crowns occlude mist.
    float tau=0.;
    for(int i=0;i<2;i++){
        float centre=i==0?485.:745.,halfDepth=i==0?100.:145.;
        float start=max(0.,(centre-halfDepth-cameraPos.z)/max(ray.z,.01));
        float finish=min(z,(centre+halfDepth-cameraPos.z)/max(ray.z,.01));
        if(finish<=start)continue;
        float stepSize=(finish-start)/5.;
        for(int j=0;j<5;j++){
            vec3 q=cameraPos+ray*(start+(float(j)+.5)*stepSize);
            float hills=smoothstep(.06,.23,q.x/max(1.,q.z));
            float wind=gradientNoise(q.xz*.013+vec2(.10*sin(phase),0.));
            float eddy=gradientNoise(q.xz*vec2(.022,.008)+vec2(.16*sin(phase),3.7));
            float sheetHeight=(i==0?74.:108.)+.072*q.x+11.*wind+4.*eddy;
            float altitude=(q.y-sheetHeight)/(i==0?13.:22.);
            float longitudinal=(q.z-centre)/halfDepth;
            float edges=max(0.,1.-longitudinal*longitudinal);
            tau+=stepSize*hills*edges*exp(-altitude*altitude)*max(.15,.78+.78*wind+.32*eddy)*(i==0?.0078:.0068);
        }
    }
    vec3 scatter=srgbToLinear(mix(vec3(.495,.541,.685),vec3(.93,.746,.625),
                                 clamp(.95*forward+.15*(1.-ray.x),0.,1.)));
    c=mix(c,scatter,1.-exp(-tau*max(0.,controls.z)));
    // Inversions cling to the wooded benches at the feet of both cliffs.
    // Sample the final segment of the sightline, including the canopy behind
    // a foreground crown only when the ray actually reaches that far.
    float contactDepth=0.;
    if(hasGround() && worldPos.z>355. && ray.x>.045){
        for(int j=0;j<6;j++){
            vec3 q=worldPos-ray*(4.+8.*float(j));
            float locality=smoothstep(363.,445.,q.z)*(1.-smoothstep(965.,1090.,q.z))
                         *smoothstep(.008,.145,q.x/max(1.,q.z));
            float ground=baseHeight(q.xz)+contactAt(q.xz).y;
            float belt=smoothstep(37.,70.,ground)*(1.-smoothstep(140.,178.,ground));
            float h=(q.y-ground-8.)/18.;
            contactDepth+=.53*exp(-h*h)*belt*locality;
        }
    }
    vec3 bankTint=srgbToLinear(mix(vec3(.372,.394,.465),vec3(.475,.495,.590),smoothstep(485.,800.,worldPos.z)));
    return mix(c,bankTint,1.-exp(-contactDepth*controls.z));
}
int object;vec3 origin,dims,position;vec2 datum,strike;float unit;
void setRock(int id){object=id;
 datum=id==0?vec2(1450,235):id==1?vec2(1800,305):id==2?vec2(1510,435):vec2(1840,202);
 float z=id==0?970.:id==1?550.:id==2?457.:1480.;unit=z/1404.;
 strike=vec2((datum.x-960.)/1404.,(464.4-datum.y)/1404.);position=vec3(strike.x*z,70.+strike.y*z,z);
 origin=id==0?vec3(838,25,-340):id==1?vec3(1552,183,-138):id==2?vec3(1380,353,-76):vec3(1628,133,-111);
 dims=id==0?vec3(2120,650,230):id==1?vec3(2210,618,154):id==2?vec3(1700,590,82):vec3(2084,372,110);}
vec3 axes(){return vec3(strike,1.);}
    vec3 world(vec3 p){return position+unit*(vec3(p.x-datum.x,datum.y-p.y,0.)+axes()*p.z);}
    vec3 localDir(vec3 v){vec3 a=axes();return vec3(v.x-a.x*v.z,-v.y+a.y*v.z,v.z);}
    vec3 worldNormal(vec3 g){vec3 a=axes();return normalize(vec3(g.x,-g.y,g.z-a.x*g.x+a.y*g.y));}
  
const vec2 watershed[] = vec2[](vec2(890.000,466.000),
vec2(997.000,402.000),
vec2(1058.000,352.000),
vec2(1093.000,320.000),
vec2(1099.000,310.000),
vec2(1109.000,303.000),
vec2(1125.000,277.000),
vec2(1137.000,265.000),
vec2(1147.000,260.000),
vec2(1157.000,249.000),
vec2(1185.000,263.000),
vec2(1195.000,259.000),
vec2(1211.000,263.000),
vec2(1225.000,255.000),
vec2(1233.000,255.000),
vec2(1245.000,244.000),
vec2(1257.000,241.000),
vec2(1263.000,242.000),
vec2(1277.000,235.000),
vec2(1291.000,206.000),
vec2(1293.000,205.000),
vec2(1295.000,200.000),
vec2(1303.000,189.000),
vec2(1309.000,184.000),
vec2(1323.000,184.000),
vec2(1333.000,188.000),
vec2(1335.000,186.000),
vec2(1339.000,177.000),
vec2(1343.000,176.000),
vec2(1345.000,168.000),
vec2(1353.000,164.000),
vec2(1361.000,154.000),
vec2(1365.000,144.000),
vec2(1375.000,131.000),
vec2(1377.000,125.000),
vec2(1379.000,125.000),
vec2(1381.000,117.000),
vec2(1383.000,115.000),
vec2(1387.000,106.000),
vec2(1391.000,102.000),
vec2(1393.000,97.000),
vec2(1403.000,86.000),
vec2(1407.000,85.000),
vec2(1409.000,81.000),
vec2(1421.000,77.000),
vec2(1435.000,78.000),
vec2(1455.000,86.000),
vec2(1465.000,93.000),
vec2(1480.000,93.000),
vec2(1487.000,85.000),
vec2(1495.000,79.000),
vec2(1505.000,83.000),
vec2(1511.000,83.000),
vec2(1521.000,70.000),
vec2(1531.000,69.000),
vec2(1539.000,75.000),
vec2(1547.000,76.000),
vec2(1561.000,87.000),
vec2(1569.000,96.000),
vec2(1585.000,127.000),
vec2(1591.000,130.000),
vec2(1599.000,142.000),
vec2(1607.000,147.000),
vec2(1627.000,153.000),
vec2(1633.000,149.000),
vec2(1647.000,153.000),
vec2(1655.000,147.000),
vec2(1667.000,146.000),
vec2(1687.000,157.000),
vec2(1707.000,172.000),
vec2(1733.000,185.000),
vec2(1759.000,190.000),
vec2(1780.000,204.000),
vec2(1810.000,211.000),
vec2(1870.000,237.000),
vec2(2000.000,288.000),
vec2(2070.000,340.000));
const vec4 blocks[] = vec4[](vec4(1022.000,349.000,67.000,-28.000),
vec4(1098.000,281.000,50.000,-34.000),
vec4(1158.000,229.000,49.000,-51.000),
vec4(1208.000,234.000,45.000,-14.000),
vec4(1256.000,207.000,43.000,-21.000),
vec4(1318.000,156.000,39.000,-52.000),
vec4(1356.000,128.000,31.000,-32.000),
vec4(1420.000,50.000,46.000,-74.000),
vec4(1457.000,60.000,37.000,-41.000),
vec4(1494.000,52.000,28.000,-17.000),
vec4(1534.000,40.000,54.000,-57.000),
vec4(1584.000,74.000,42.000,-25.000),
vec4(1624.000,98.000,55.000,-20.000),
vec4(1670.000,122.000,48.000,-34.000),
vec4(1725.000,146.000,58.000,-9.000),
vec4(1803.000,153.000,64.000,-16.000),
vec4(1874.000,169.000,69.000,-2.000),
vec4(1970.000,207.000,87.000,4.000),
vec4(1475.000,175.000,36.000,-105.000),
vec4(1277.000,282.000,45.000,-91.000));
const float twists[]=float[](8.0,-3.0,5.0,-4.0,6.0,-5.0,5.0,-4.0,4.0,-5.0,6.0,-5.0,4.0,-6.0,3.0,5.0,-4.0,3.0,8.0,-5.0);
float noise3(vec3 p);
float hash(vec3 p);
float smin(float a,float b,float r){float h=max(r-abs(a-b),0.)/r;return min(a,b)-.25*r*h*h;}
float roundBox(vec3 p,vec3 b,float r){vec3 q=abs(p)-b+r;return length(max(q,0.))+min(max(q.x,max(q.y,q.z)),0.)-r;}
float roof(float x){
 int lo=0,hi=watershed.length()-1;
 for(int i=0;i<8;i++){int m=(hi+lo)/2;if(x<watershed[m].x)hi=m;else lo=m;}
 vec2 a=watershed[lo],b=watershed[hi];return mix(a.y,b.y,clamp((x-a.x)/max(.01,b.x-a.x),0.,1.));}
vec2 facets(vec3 p,float scale){
 // Piecewise planar, elongated cells. The two closest nuclei determine the joint.
 vec3 q=vec3(.93*p.x+.368*p.y,(-.368*p.x+.93*p.y)*.25,p.z)/scale;
 vec3 cell=floor(q),w=fract(q);float a=10.,b=10.,tilt=0.;
 for(int z=-1;z<=1;z++)for(int y=-1;y<=1;y++)for(int x=-1;x<=1;x++){
  vec3 k=vec3(x,y,z),id=cell+k;
  vec3 off=k+.5+.38*(vec3(hash(id),hash(id+57.),hash(id+13.))-.5)-w;
  float t=dot(off,off);
  if(t<a){b=a;a=t;tilt=dot(off,vec3(hash(id+5.),hash(id+9.),hash(id+31.))-.5);}
  else b=min(b,t);
 }
 float edge=(sqrt(b)-sqrt(a))*scale;return vec2(tilt*smoothstep(0.,2.8,edge),edge);
}
float buttress(vec3 p,vec4 station,float w,float len){
 float h=p.y-station.y,x=p.x-station.x+station.z*h;
 float nose=station.w-.25*h;
 float front=max(nose-1.45*x,nose+.47*x);
 float crown=station.y-p.y+.34*max(-x,0.)+.69*max(x,0.)+.62*max(station.w-p.z,0.);
 return max(max((front-p.z)*.58,crown*.70),max(abs(x)-w*(.45+.55*clamp(h/42.,0.,1.)),max(p.z-16.,(h-len)*.61)));
}
float rockField(vec3 p){
 if(object==3){
  float x=p.x-1849.;float crest=168.+max(-.39*x,.21*x)+4.*sin(x*.071)+2.2*sin(x*.13+.8);
  float summit=crest+.58*abs(p.z);
  return max(max(summit-p.y,-p.z-40.-.17*x-.22*(p.y-195.)+3.*noise3(p*.048)),max(p.z-90.,p.y-435.));}
 if(object==1||object==2){
  float k=object==1?1.:.49;vec2 uv=object==1?vec2(1870,370):vec2(1535,470);
  vec3 q=vec3(p.xy-uv,p.z)/k;
  if(object==2)q.y=(q.y-32.)/.56;
  float ball=(length((q-vec3(24.+.26*q.y,28.,16.))/vec3(308,209,119))-1.)*125.;
  float cap=-137.-.105*q.x+.31*max(-q.x-34.,0.)+.71*max(-q.x-116.,0.)-.16*q.z-q.y;
  // A single retreating bedrock front. Its orientation turns gradually
  // through the nose. Local breaks follow the steep joint set.
  vec3 jointSpace=vec3(.031*q.x+.011*q.y,.018*q.y,.025*q.z);
  float mass=noise3(jointSpace*.52);
  float joints=noise3(jointSpace);
  float flakes=abs(noise3(jointSpace*2.63)-.47);
  float scar=abs(noise3(vec3(.025*q.x+.012*q.y,q.y*.009,q.z*.022))-.46);
  float breakage=15.*(mass-.50)+7.*abs(joints-.43)+2.5*flakes+5.*exp(-scar*scar*290.);
  float west=-q.z-100.-.62*(q.x+62.)-.20*q.y;
  float east=-q.z-104.+.30*(q.x+53.)-.31*q.y;
  float face=-smin(-west,-east,42.)+breakage;
  float lip=q.x-.38*q.y+16.*(mass-.5)+3.2*joints;
  float sheets=2.2*abs(noise3(vec3(lip*.032,q.y*.010,q.z*.026))-.38);
  float d=-smin(smin(-ball,-cap-(mass-.5)*9.,8.),-(face+sheets),15.);
  float skin=.87*(noise3(jointSpace*3.6)-.5);
  float foot=60.-.11*q.x+.46*abs(q.z+102.)+.0019*pow(max(-120.-q.x,0.),2.)+.074*abs(q.x+15.);
  foot+=4.*noise3(vec3(q.x*.04,4.,q.z*.039));
  float toe=max(max(foot-q.y,abs(q.z+104.)-77.),max(-252.-q.x,q.x-285.));
  return k*(object==2?.56:1.)*smin(d+skin,toe,3.);
 }
 float d=1000.;
 for(int i=0;i<blocks.length();i++){
  vec4 s=blocks[i];vec2 q=p.xy-s.xy;
  float down=dot(q,vec2(-.368,.93)),lat=dot(q,vec2(.93,.368));
  float dep=p.z+.32*max(down,0.)-(s.w+69.)+.00032*down*down;
  float angle=radians(twists[i]+(s.x<1470.?26.:-13.));
  vec2 ac=mat2(cos(angle),sin(angle),-sin(angle),cos(angle))*vec2(lat,dep);
  d=smin(d,roundBox(vec3(ac.x,down-177.,ac.y),vec3(s.z+.043*max(down,0.),194,76),6.5),4.);
 }
 d=smin(d,buttress(p,vec4(1473,166,.69,-163),57.,197.),3.);
 d=smin(d,buttress(p,vec4(1414,83,.35,-127),48.,236.),3.);
 d=smin(d,buttress(p,vec4(1160,251,.46,-86),29.,90.),3.);
 float top=roof(p.x);
 float shoulder=.23+.24*smoothstep(20.,125.,abs(p.x-1450.));
 d=max(d,(top+shoulder*max(-p.z,0.)+.61*max(p.z,0.)-p.y)*.72);
 for(int i=0;i<3;i++){
  vec4 s=i==0?vec4(1479,99,9,48):i==1?vec4(1352,187,8,110):vec4(1209,272,15,114);
  float dy=p.y-s.y,a=p.x-s.x+.37*dy;
  d=max(d,-max(max(abs(a)-s.z+.075*dy,-.8*dy),max(dy-s.w,p.z+56.+.60*abs(a)-.24*dy)));}
 for(int i=0;i<4;i++){
  vec4 s=i==0?vec4(1602,183,95,13):i==1?vec4(1618,231,116,21):i==2?vec4(1630,268,87,18):vec4(1490,130,38,8);
  float dx=p.x-s.x,span=max(0.,1.-dx*dx/(s.z*s.z)),bed=p.y-s.y-.33*dx-2.1*sin(.032*dx);
  d=max(d,-max(max(-bed-6.5*span,bed+.36*(p.z+90.)),max(abs(dx)-s.z,p.z+20.-s.w*span+.09*dx)));}
 // A deposition slope shared by the gullies. Its crest sits inside
 // the cliff, so the debris has no free-standing conical summits.
 float slopeRun=-p.z-108.;
 float crossRun=p.x+.31*p.z;
 float drainage=noise3(vec3(crossRun*.023,p.z*.012,3.));
 float gravel=noise3(vec3(crossRun*.078,p.z*.038,7.));
 float apronY=353.-.065*(p.x-1190.)+.49*sqrt(slopeRun*slopeRun+180.)+.47*max(1130.-p.x,0.)+.39*max(p.x-1400.,0.)+
              10.*(drainage-.5)+3.8*(gravel-.5);
 float tal=max((apronY-p.y)*.79,max((1040.-p.x)*.59,(p.x-1540.)*.61));
 tal=max(tal,max(-p.z-317.,p.z-168.));
 d=smin(d,tal,7.);
 // A forestable bedrock spur grades into the west talus.
 vec3 spur=(p-vec3(1127.,402.,-130.))/vec3(128.,39.,82.);
 float shoulderFoot=(length(spur)-1.)*38.+4.*noise3(p*.035);
 d=smin(d,shoulderFoot,6.);
 if(abs(d)<10. && p.y>top+2. && tal>2.){
  vec2 f=facets(p,24.),g=facets(p,8.);
  float fault=abs(noise3(vec3(.037*p.x+.014*p.y,.020*p.y,.033*p.z))-.48);
  float relief=4.2*f.x+1.15*g.x+.62*exp(-f.y*f.y*.36)+6.8*fault;
  d+=smoothstep(2.,15.,p.y-top)*smoothstep(2.,14.,tal)*relief;}
 return d;
}
    float sd(vec3 p){return rockField(p);}
    vec3 gradient(vec3 p,float e){vec2 h=vec2(e,0);return vec3(sd(p+h.xyy)-sd(p-h.xyy),sd(p+h.yxy)-sd(p-h.yxy),sd(p+h.yyx)-sd(p-h.yyx));}
    float hash(vec3 p){p=fract(p*.1031);p+=dot(p,p.yzx+33.33);return fract((p.x+p.y)*p.z);}
    float noise3(vec3 p){vec3 i=floor(p),f=fract(p);f=f*f*(3.-2.*f);
      return mix(mix(mix(hash(i),hash(i+vec3(1,0,0)),f.x),mix(hash(i+vec3(0,1,0)),hash(i+vec3(1,1,0)),f.x),f.y),
      mix(mix(hash(i+vec3(0,0,1)),hash(i+vec3(1,0,1)),f.x),mix(hash(i+vec3(0,1,1)),hash(i+1.),f.x),f.y),f.z);}
    float softShadow(vec3 p,vec3 n,vec3 light){
      vec3 ray=localDir(light);vec3 start=p+localDir(n)*2.4;float t=3.,v=1.;
      for(int i=0;i<24;i++){float h=sd(start+ray*t);v=min(v,5.*max(h,0.)/t);if(h<-.6||t>100.)break;t+=clamp(h*.72,2.,17.);}
      return smoothstep(0.,1.,v);}
    float lineDistance(vec2 p,vec2 a,vec2 b){vec2 d=b-a;return length(p-a-d*clamp(dot(p-a,d)/dot(d,d),0.,1.));}

bool intersectRock(vec3 eye,vec3 ray,out vec3 p,out vec3 wp){      vec3 localEye=vec3(datum,0.)+localDir(eye-position)/unit;
      vec3 dir=localDir(ray);
      vec3 inv=1./(sign(dir+1.e-9)*max(abs(dir),vec3(1.e-7)));
      vec3 a=(origin-localEye)*inv,b=(dims-localEye)*inv;
      vec3 nearT=min(a,b),farT=max(a,b);
      float t=max(0.,max(nearT.x,max(nearT.y,nearT.z))),end=min(farT.x,min(farT.y,farT.z));
      if(t>=end)return false;
      bool hit=false;p=vec3(0.);
      for(int i=0;i<155;i++){p=localEye+dir*t;float d=sd(p);if(d<.14){hit=true;break;}t+=max(.12,d*.66);if(t>end)break;}
      if(!hit)return false;
      wp=world(p);return true;
}
vec3 rockColor(vec3 p,vec3 wp,vec3 eye){      vec3 raw=gradient(p,spacing*.66);vec3 n=worldNormal(raw);
      vec3 light=sunlight();
      float occ=clamp(.60*(1.-sd(p+localDir(n)*6.)/6.)+.40*(1.-sd(p+localDir(n)*19.)/19.),0.,.88);
      float shadow=softShadow(p,n,light);
      if(integrated==1)shadow*=castVisibility(wp+n*2.,light,true);
      float crack=0.,grit=noise3(p*.75);
      if(object==0){
          vec3 coords=vec3(.83*p.x+.37*p.y,p.y*.5,p.z)*.079;
          float weather=noise3(coords),f=weather-.5;
          vec3 grad=vec3(noise3(coords+vec3(.14,0,0))-weather,
                    noise3(coords+vec3(0,.14,0))-weather,noise3(coords+vec3(0,0,.14))-weather);
          n=normalize(n-(grad-n*dot(n,grad))*(1.25+.9*abs(f)));
      }
      if(stage>=3){
        if(object==0){
          float joint=p.x*.93+p.y*.368;
          float scratch=abs(fract(joint*.23+.14*noise3(p*.045))-.5);
          float score=(1.-smoothstep(.025,.09+fwidth(joint)*.085,scratch))*smoothstep(.41,.66,noise3(p*.052));
          crack=clamp(smoothstep(.28,.70,noise3(p*.038))*(1.-smoothstep(.16,1.40,facets(p,24.).y))*.55+score*.47*(1.-smoothstep(1430.,1495.,p.x)),0.,1.);
        }
        if(object==1||object==2){
          vec2 q=object==1?p.xy:vec2(1870,370)+(p.xy-vec2(1535,470))/.49;
          // Fracture edges and narrow mineral seams follow the tilted
          // granite sheets; finer joints die out before crossing a whole face.
          vec3 local=object==1?p:vec3((p.xy-vec2(1535,470))/.49+vec2(1870,370),p.z/.49);
          vec2 coarse=facets(local*.86,20.);
          float exposure=noise3(local*.028);
          float seam=(1.-smoothstep(.25,1.45,coarse.y))*smoothstep(.30,.74,exposure);
          vec3 uvw=vec3(local.x*.13+local.y*.047,local.y*.093,local.z*.074);
          float grain=noise3(uvw);
          vec3 g=vec3(noise3(uvw+vec3(.17,0,0))-grain,noise3(uvw+vec3(0,.17,0))-grain,noise3(uvw+vec3(0,0,.17))-grain);
          n=normalize(n-.64*(g-dot(g,n)*n));
          crack=.79*seam;
        }
        n=normalize(n+.025*vec3(grit-.5,noise3(p*.61+19.)-.5,noise3(p*.64+8.)-.5));
      }
      float direct=max(0.,dot(n,light))*mix(.33,1.,shadow);
      float bounce=clamp(.55-.32*n.y-.22*n.z,0.,1.);
      float diffuse=.68*direct+.20+.17*max(n.y,0.)+.045*bounce;
      vec3 c=vec3(pow(max(.012,diffuse*(1.-.25*occ)),.76)*(1.-.30*crack));
      float snow=0.;
      if(stage>=4 && object==0){
        float shelf=smoothstep(.765,.825,worldNormal(gradient(p,3.4)).y);
        float shelter=clamp(.08+occ*2.+(1.-shadow)*.52+max(0.,sd(p+vec3(0,0,-7))-sd(p+vec3(0,-7,0)))*.04,0.,1.);
        float grains=noise3(p*.19)*.32+noise3(p*.052)*.68;
        float apron=0.;
        for(int i=0;i<3;i++){vec2 uv=i==0?vec2(1090,323):i==1?vec2(1200,313):vec2(1328,293);
          float down=p.y-uv.y;apron=max(apron,smoothstep(0.,15.,down)*(1.-smoothstep(52.,91.,down))*(1.-smoothstep(.5,1.,abs(p.x-uv.x+.37*down)/(6.+.48*max(0.,down)))));}
        float ledge=0.;
        for(int j=0;j<4;j++){vec3 s=j==0?vec3(1602,183,95):j==1?vec3(1618,231,116):j==2?vec3(1630,268,87):vec3(1490,130,38);
          float dx=p.x-s.x;float bed=p.y-s.y-.33*dx-2.1*sin(.032*dx)+.36*(p.z+90.);
          ledge=max(ledge,(1.-smoothstep(1.,5.,abs(bed)))*(1.-smoothstep(s.z*.78,s.z,abs(dx))));}
        float gully=(1.-smoothstep(4.,14.,abs(p.x-1480.+.37*(p.y-99.))))*smoothstep(94.,106.,p.y)*(1.-smoothstep(128.,143.,p.y));
        float run=-p.z-108.,crossRun=p.x+.31*p.z;
        float floorY=353.-.065*(p.x-1190.)+.49*sqrt(run*run+180.)+.47*max(1130.-p.x,0.)+.39*max(p.x-1400.,0.)+
                     10.*(noise3(vec3(crossRun*.023,p.z*.012,3.))-.5)+
                     3.8*(noise3(vec3(crossRun*.078,p.z*.038,7.))-.5);
        float track=abs(noise3(vec3(crossRun*.017,p.z*.006,19.))-.48);
        apron=(1.-smoothstep(.044,.19,track))*(1.-smoothstep(1.5,7.,abs(p.y-floorY)))*
              smoothstep(-29.,6.,run)*(1.-smoothstep(55.,145.,run));
        float catchment=max(apron,max(ledge,gully));
        snow=shelf*catchment*smoothstep(.27,.58,shelter+.83*catchment+.39*grains)*(1.-smoothstep(366.,445.,p.y));
        n=normalize(mix(n,vec3(0,1,0),snow*.27));
        c=mix(c,vec3(.72+.18*direct),snow);}
      if(stage>=5){
        vec3 albedo=mix(vec3(.49,.43,.46),vec3(.63,.52,.52),noise3(wp*.051));
        vec3 radiance=srgbToLinear(albedo)*(ambientLight()*vec3(.74,.86,1.35)*(.64+.68*max(n.y,0.))
                         +key()*(.13+2.9*direct));
        float reflectedKey=dot(n,normalize(vec3(light.x,.075,-.055)));
        radiance+=srgbToLinear(albedo)*key()*1.10*pow(max(reflectedKey,0.),1.5);
        c=linearToSrgb(radiance*(1.-.23*occ)*(1.-.09*crack));
        if(object==1||object==2){float weather=noise3(p*vec3(.047,.054,.036));
          float dry=noise3(vec3(p.x*.086+p.y*.045,p.y*.052,p.z*.064));
          c*=.79+.22*weather+.19*dry+.055*noise3(p*.22);
          float east=smoothstep(1770.,1840.,p.x+.15*(p.y-305.));
          c=mix(c,vec3(.225,.214,.306)+.045*weather,east*.24);
          float split=noise3(vec3(.062*p.x+.031*p.y,p.y*.015,p.z*.035));
          float cleft=(1.-smoothstep(.025,.11,abs(split-.49)));
          c*=1.-.20*cleft*smoothstep(.22,.63,weather);
          c+=vec3(.062,.034,.029)*max(0.,-n.x); }
        if(object==0){float band=noise3(p*vec3(.086,.018,.060));
          float inclusion=noise3(p*.047)*.65+noise3(p*.128)*.35;
          c*=.91+.10*band+.085*inclusion;
          c+=vec3(.044,.035,.037)*max(0.,dot(n,normalize(vec3(-.92,.2,-.43))))*(.4+.6*shadow);c=mix(c,mix(vec3(.50,.555,.71),vec3(.88,.84,.79),max(direct,.23*bounce)),snow);
          float ridge=smoothstep(302.,348.,p.y)*(1.-smoothstep(380.,420.,p.y))*smoothstep(.69,.87,n.y)*(1.-snow);
          c+=ridge*vec3(.095,.078,.045);}
        if(stage>=6){
          float grass=object==1||object==2?smoothstep(.78,.94,n.y):object==0?smoothstep(.73,.94,n.y)*smoothstep(295.,370.,p.y)*(1.-snow):0.;
          c=mix(c,mix(vec3(.266,.286,.224),vec3(.74,.63,.47),direct),grass*(.79+.21*noise3(p*.18)));}
        if(stage>=6 && (object==1||object==2)){
          vec3 q=object==1?vec3(p.xy-vec2(1870.,370.),p.z):vec3((p.xy-vec2(1535.,470.))/.49,p.z/.49);
          if(object==2)q.y=(q.y-32.)/.56;
          float cap=-137.-.105*q.x+.31*max(-q.x-34.,0.)+.71*max(-q.x-116.,0.)-.16*q.z;
          float damp=noise3(wp*vec3(.20,.042,.17));
          float below=q.y-cap;
          float lip=smoothstep(-2.,2.,below)*(1.-smoothstep(3.,9.+9.*damp,below));
          c=mix(c,linearToSrgb(srgbToLinear(vec3(.28,.26,.215))*(ambientLight()+key()*direct)),lip*.78);
          c*=1.-.13*smoothstep(.44,.69,damp)*exp(-max(below,0.)/46.);
        }
        if(integrated==1 && object!=3){
          vec4 foot=contactAt(wp.xz);
          float ground=baseHeight(wp.xz)+foot.y;
          float gap=wp.y-ground+7.*(noise3(wp*.082)-.5);
          float cover=(1.-smoothstep(1.,34.,gap))*(.28+.72*smoothstep(.13,.83,n.y))*(1.-snow);
          c*=.70+.30*smoothstep(0.,18.,gap);
          float litter=noise3(wp*.12)*.52+noise3(wp*.034)*.48;
          c=mix(c,mix(vec3(.235,.224,.246),vec3(.419,.392,.282),litter),cover*.77);
        }
        
        if(object==3)c=mix(c,vec3(.55,.58,.72),.52);
        c=film(valleyAir(srgbToLinear(c),wp,eye));
      }
return clamp(c,0.,1.);}
vec3 skyRadiance(vec3 ray){float alt=max(0.,ray.y),scatter=forwardLight(ray);
        vec3 sky=mix(vec3(.95,.769,.681),vec3(.613,.619,.714),smoothstep(.025,.38,alt));
        float east=smoothstep(.01,.66,ray.x)*smoothstep(.035,.29,alt);
        sky=mix(sky,vec3(.419,.502,.684),east*.92);
        sky=mix(sky,vec3(1.,.891,.736),pow(scatter,1.65));
        vec2 p=ray.xy*vec2(7.,67.)+vec2(.03*sin(phase),4.);
        float cloud=fbm(p+gradientNoise(p*.44),4);
        sky+=vec3(.084,.050,.038)*smoothstep(.10,.42,cloud);
        float stratus=exp(-pow((ray.y-.118-.005*gradientNoise(vec2(ray.x*17.,3.)))/.006,2.));
        sky+=vec3(.115,.042,.008)*stratus*smoothstep(.0,.30,cloud+.11)*scatter;
        float glow=length(ray-sunlight());
        sky+=vec3(.17,.17,.15)*exp(-31.*glow);
        sky=mix(sky,vec3(1.,1.,.967),1.-smoothstep(.008,.013,glow));
        return clamp(sky,0.,1.);}
vec3 cameraEye(){return vec3(truck,70.+.035*truck,-.09*truck);}
vec3 decodeOct(vec2 e){vec3 n=vec3(e,1.-abs(e.x)-abs(e.y));if(n.z<0.)n.xy=(1.-abs(n.yx))*sign(n.xy);return normalize(n);}
int bucketStart(int key,bool mirrored){
 int lo=0,hi=262144;for(int j=0;j<19;j++){if(lo>=hi)break;int mid=(lo+hi)/2;
 if(rootKey(texelFetch(iChannel1,sortAddress(mid,mirrored),0),mirrored)<key)lo=mid+1;else hi=mid;}return lo;}
ivec2 treeRange(int key,bool mirrored){
    int y=(key/256)%256,x=key%256;
    int width=int(iChannelResolution[1].x);
    int slot=1310720+769*769+((mirrored?3:0)+key/65536)*4096+y*64+x;
    if(x<64 && y<64 && slot<width*int(iChannelResolution[1].y)){
        vec4 entry=texelFetch(iChannel1,ivec2(slot%width,slot/width),0);
        if(entry.w==1.)return ivec2(entry.xy);
    }
    return ivec2(bucketStart(key,mirrored),bucketStart(key+1,mirrored));
}
struct ForestHit {float z;vec3 color;};
float canopyNode(ivec2 node){
    node=clamp(node,ivec2(0),ivec2(1536));
    ivec2 pair=node/2;
    int at=1310720+pair.y*769+pair.x,width=int(iChannelResolution[1].x);
    return texelFetch(iChannel1,ivec2(at%width,at/width),0)[node.x%2+2*(node.y%2)];
}
float canopyHeight(vec2 world){
    vec2 at=(world+vec2(1100,40))*1537./vec2(2200,1800)-.5;
    ivec2 node=ivec2(floor(at));vec2 t=fract(at);
    return mix(mix(canopyNode(node),canopyNode(node+ivec2(1,0)),t.x),
               mix(canopyNode(node+ivec2(0,1)),canopyNode(node+ivec2(1)),t.x),t.y);
}
float skyVisibilityAt(vec3 p){
    float obstruction=0.;
    for(int j=0;j<5;j++){
        vec3 q=p+sunlight()*(4.5*exp2(float(j)*.81));
        obstruction=max(obstruction,smoothstep(-.25,3.,bed(q.xz)+canopyHeight(q.xz)-q.y));
    }
    return 1.-.76*obstruction;
}
vec3 finishSlope(vec3 c,vec3 p){
    vec3 air=valleyAir(c,p,cameraEye());
    float layer=smoothstep(93.,168.,p.z)*(1.-smoothstep(232.,365.,p.z));
    float west=smoothstep(-.045,.24,-p.x/max(1.,p.z));
    air=mix(air,srgbToLinear(vec3(.61,.49,.401)),.135*layer*west);
    float halo=exp(-65.*length(normalize(p-cameraEye())-sunlight()))*smoothstep(480.,850.,p.z);
    return film(air+key()*.47*halo);
}
void testTree(vec4 r,vec3 ro,vec3 rd,bool mirrored,inout ForestHit best){
 float h=treeHeight(r);int style=treeStyle(r);float orange=isLarch(r);int level=treeLevel(r.z);
 float rotation=r.x*3.17+r.z*.71;float width=(.88+.055*float(style))*(1.+.22*orange);
 float z=r.z-ro.z;if(z-.33*h>best.z)return;
 vec3 local=(ro+rd*z-r.xyz)/h;vec2 xy=local.xy;
 if(xy.y<-.14||xy.y>1.05||abs(xy.x)>.45)return;
 float wind=(sin(phase+r.x*.08+r.z*.037)+.4*sin(2.*phase+r.z*.13))*controls.w*.015;
 TreeView v=design(level,style%3,rotation,orange,.88+.055*float(style),-rd.y);
 rayShear=rd.xy;treeBend=wind;
 CrownHit hit;if(!hitCrown(local.xy,v,hit))return;
 float tz=z+h*hit.depth;if(tz>=best.z)return;
 vec3 normal=hit.normal;float sunSide=hit.sunSide;
 vec3 worldPos=ro+rd*tz;
 vec3 c=shadeCrown(worldPos,normal,hit.exposure,sunSide,orange,skyVisibilityAt(worldPos));
 c=srgbToLinear(c);
 float nearW=(1.-smoothstep(125.,206.,worldPos.z))*smoothstep(-.08,.12,-worldPos.x/max(1.,worldPos.z));
 c*=mix(vec3(1.),vec3(.83,1.,.77),nearW*(1.-orange));
 float shelf=smoothstep(472.,505.,r.z)*(1.-smoothstep(598.,637.,r.z))*smoothstep(100.,132.,cap(r.xz))*smoothstep(118.,139.,r.y);
 c+=shelf*(ambientLight()*vec3(.075,.083,.058)+key()*vec3(.095,.070,.027)*sunSide*(.24+.76*hit.exposure));
 c=finishSlope(c*castVisibility(worldPos+normal*1.2,sunlight(),false),worldPos);
 best=ForestHit(tz,c);
}
vec3 treeLayer(vec3 back,float limit,vec3 ro,vec3 rd,bool mirrored,out float nearest){
 ForestHit best=ForestHit(limit,back);
 vec2 pixel=vec2(960.+rd.x*1404.,464.4+(mirrored?rd.y:-rd.y)*1404.);
 for(int level=0;level<3;level++){
 if(level==1&&best.z<185.)break;if(level==2&&best.z<390.)break;
 vec2 tile=tileSize(level);
 for(int dy=-1;dy<=1;dy++)for(int dx=-1;dx<=1;dx++){
 int key=tileKey(pixel+vec2(dx,dy)*tile,level);ivec2 range=treeRange(key,mirrored);int start=range.x;
 for(int i=0;i<800;i++){if(start+i>=range.y)break;vec4 r=texelFetch(iChannel1,sortAddress(start+i,mirrored),0);
 testTree(r,ro,rd,mirrored,best);}
 }}
 nearest=best.z;return best.color;
}
vec4 slopeNode(int x,int row){
    int index=row*513+x;
    return texelFetch(iChannel0,ivec2(769+index%1024,768+index/1024),0);
}
vec4 slopeSurface(vec2 world){
    float row=floor(368.*pow(clamp((world.y-2.)/1648.,0.,1.),1./1.63));
    int j=clamp(int(row),0,367);
    vec2 z=2.+1648.*pow(vec2(j,j+1)/368.,vec2(1.63));
    float v=clamp((world.y-z.x)/(z.y-z.x),0.,1.);
    vec2 widths=z*.81+35.;
    float fc=clamp((world.x/mix(widths.x,widths.y,v)+1.)*256.,0.,512.);
    int col=min(511,int(fc));
    float dist=(fc-float(col))*mix(widths.x,widths.y,v);
    if(dist<=(1.-v)*widths.x){
        float u=dist/widths.x;
        return (1.-u-v)*slopeNode(col,j)+u*slopeNode(col+1,j)+v*slopeNode(col,j+1);
    }
    float u=(dist-(1.-v)*widths.x)/widths.y;
    return (1.-v)*slopeNode(col+1,j)+(v-u)*slopeNode(col,j+1)+u*slopeNode(col+1,j+1);
}
float groundAt(vec2 world){return slopeSurface(world).x;}
vec3 landColor(vec3 wp,vec3 ro){
    vec3 n=normalize(slopeSurface(wp.xz).yzw);
        vec3 p=wp,sun=sunlight(),c;
        float fracture=erodedFbm(vec2(p.x*.084+p.y*.028,p.z*.018),4);
        float bedding=erodedFbm(vec2(p.x*.032-p.y*.026,p.z*.025),4);
        float side=dot(normalize(n+vec3(.36*bedding,.06*bedding,0.)),normalize(vec3(sun.x*2.6,.15,-.24)));
        side-=.23*(1.-smoothstep(610.,810.,p.z));
        float stratum=p.y*.19+fracture*3.6+p.x*.037;
        float variation=.76+.29*fracture+.12*sin(stratum);
        vec3 granite=srgbToLinear(mix(vec3(.295,.284,.423),vec3(.787,.599,.6),smoothstep(.54,.98,side)))*variation;
        // Oblique fractures tilt across the granite face; shelves retain narrow
        // discontinuous seams of snow where cut planes meet.
        vec2 faultUV=vec2(p.x*.066-p.y*.039,p.z*.013+p.y*.009);
        float fault=erodedFbm(faultUV,4);
        granite*=.91+.40*fault;
        float hollow=bed(p.xz+vec2(3.,0.))+bed(p.xz-vec2(3.,0.))-2.*p.y;
        float couloir=smoothstep(1.05,3.2,hollow+.72*fracture);
        float shelf=smoothstep(.975,.996,n.y)*smoothstep(.1,.7,sin(stratum));
        float snow=smoothstep(93.,155.,p.y)*clamp(couloir*.54+shelf*.26+smoothstep(.12,.31,fault)*smoothstep(.52,.91,n.y)*.36,0.,1.);
        granite=mix(granite,srgbToLinear(mix(vec3(.53,.54,.66),vec3(.86,.75,.77),max(side,0.))),snow);
        vec3 loam=srgbToLinear(mix(vec3(.19,.19,.225),vec3(.396,.36,.30),.5+.44*fracture));
        float rock=smoothstep(41.,93.,p.y)+.65*(1.-smoothstep(.35,.77,n.y));
        c=mix(loam*(.64+.70*max(side,0.)),granite,clamp(rock,0.,1.));
        // Weathered soil, moss pockets and embedded granite share a relief
        // field. Use its analytic gradients for stable world-space normals.
        float forestBelt=smoothstep(.4,7.,p.y)*(1.-smoothstep(104.,142.,p.y));
        vec2 site=p.xz+vec2(p.y*.29,-.17*p.y);
        vec3 hummock=gradientNoiseD(site*.31);
        vec3 pebbles=gradientNoiseD(site*1.48+vec2(8.9,-3.3));
        float detail=1.-smoothstep(.23,.95,max(fwidth(site.x),fwidth(site.y))*1.48);
        vec2 gradient=.52*hummock.yz+.34*pebbles.yz*detail;
        vec3 floorNormal=normalize(n+vec3(-gradient.x,0.,-gradient.y)*max(n.y,.23));
        float mossPatch=fbm(site*.14+vec2(2.,15.),4)+hummock.x*.33;
        float clast=smoothstep(.10,.37,hummock.x+.18*bedding+.16*pebbles.x*detail);
        vec3 soil=mix(vec3(.227,.192,.184),vec3(.418,.382,.232),smoothstep(-.22,.24,mossPatch));
        vec3 rockFace=mix(vec3(.29,.268,.302),vec3(.52,.452,.402),.50+.46*pebbles.x);
        float pockets=clamp(.80+.42*hummock.x+.13*pebbles.x*detail,.45,1.);
        float irradiance=clamp(dot(floorNormal,sun)*.87+.24,0.,1.)*skyVisibilityAt(p);
        vec3 floorColor=srgbToLinear(mix(soil,rockFace,clast))*pockets*
            (vec3(.55,.65,.79)+key()*irradiance*1.9);
        c=mix(c,floorColor,forestBelt*smoothstep(.18,.57,n.y));
        // The near wooded bank is dark humus and moss even on steep cut faces.
        float understory=(1.-smoothstep(148.,244.,p.z))*(1.-smoothstep(62.,91.,p.y))*smoothstep(2.,8.,p.y);
        vec3 groundGrain=gradientNoiseD(p.xy*.44+p.z*.31);
        vec3 humus=mix(vec3(.128,.153,.143),vec3(.275,.279,.212),smoothstep(-.25,.28,groundGrain.x+.33*bedding));
        c=mix(c,srgbToLinear(humus)*(.70+.39*max(0.,floorNormal.y)),understory);
        float bankWeight=1.-smoothstep(.48,1.,length((p.xz-vec2(18.,322.))/vec2(35.,36.)));
        if(bankWeight>0.){
            // Use an orthonormal tangent frame on each bank. On steep slopes,
            // a top-down projection stretches soil and stones down the face.
            vec3 tangent=normalize(vec3(n.y,-n.x,0.)+vec3(.00001,0.,0.));
            vec3 bitangent=normalize(cross(n,tangent));
            // Fixed projections keep material coordinates continuous across normals.
            vec3 weights=pow(abs(n),vec3(3.));
            weights/=max(.0001,dot(weights,vec3(1.)));
            vec3 coarse=weights.x*gradientNoiseD(p.zy*.45)+weights.y*gradientNoiseD(p.xz*.45)+weights.z*gradientNoiseD(p.xy*.45);
            vec3 grit=weights.x*gradientNoiseD(p.zy*1.32)+weights.y*gradientNoiseD(p.xz*1.32)+weights.z*gradientNoiseD(p.xy*1.32);
            float resolved=1.-smoothstep(.4,1.2,max(length(dFdx(p)),length(dFdy(p)))*1.32);
            vec3 bumps=tangent*(coarse.y+.4*grit.y*resolved)+bitangent*(coarse.z+.4*grit.z*resolved);
            vec3 floorNormal=normalize(n-.36*bumps);
            float grass=smoothstep(-.22,.25,coarse.x+.23*grit.x);
            float stone=smoothstep(.12,.34,coarse.x-.30*grit.x);
            vec3 earth=mix(vec3(.265,.231,.220),vec3(.42,.398,.265),grass);
            vec3 mineral=mix(vec3(.30,.28,.32),vec3(.49,.45,.424),.5+.59*grit.x);
            float irradiance=max(0.,dot(floorNormal,sun));
            vec3 floorColor=srgbToLinear(mix(earth,mineral,stone))*
                (vec3(.59,.65,.75)+key()*irradiance*(.65+.50*skyVisibilityAt(p)));
            c=mix(c,floorColor,forestBelt*bankWeight);
        }
        c*=mix(vec3(.58,.68,1.03),vec3(1.),controls.y/.88);
    return finishSlope(c*castVisibility(wp+n*1.2,sun,false),wp);
}
bool softFirstRow;
vec3 environment(vec3 ro,vec3 rd,bool reflected,float limit,out float visibleZ){
 vec3 c=skyRadiance(normalize(rd));float closest=limit;
 for(int id=0;id<4;id++){setRock(id);vec3 p,wp;if(intersectRock(ro,normalize(rd),p,wp)&&wp.z-ro.z<closest){c=rockColor(p,wp,ro);closest=wp.z-ro.z;}}
 float t=reflected?max(10.,(1.-ro.y)/max(.001,rd.y)):8.,last=t;
 for(int j=0;j<265;j++){if(t>=closest)break;vec3 wp=ro+rd*t;float h=groundAt(wp.xz);
 if(wp.y<h&&(!reflected||wp.y>.02)){
 for(int k=0;k<7;k++){float mid=(last+t)*.5;vec3 q=ro+rd*mid;if(q.y<groundAt(q.xz))t=mid;else last=mid;}
 closest=t;c=landColor(ro+rd*t,ro);break;}last=t;
 t+=clamp((wp.y-h)*.57,1.4,max(6.,wp.z*.019));}
 vec3 result=treeLayer(c,closest,ro,rd,reflected,visibleZ);
 if(!reflected){vec3 p=ro+rd*visibleZ;softFirstRow=visibleZ<closest&&p.z<236.&&p.x/p.z<.22;}
 return result;
}
int group,cols,rows;float floorAt(vec2 p){return bed(p);}

vec3 place(vec2 p,float z){return vec3((p.x-960.)*z/1404.,70.+(464.4-p.y)*z/1404.,z);}
vec3 surface(int i,vec2 uv,out float tag){
 float u=uv.x,v=uv.y,a=2.*PI*u;
 if(group==20){
 // Place granite rubble at the actual zero elevation crossings on each shore.
 float z=mix(181.,434.,rnd(i/2,16));bool east=i%2==0;float l=east?65.:-55.,r=east?265.:75.;
 for(int j=0;j<12;j++){float m=(l+r)*.5;bool dry=floorAt(vec2(m,z))>0.;if(dry==east)r=m;else l=m;}
 float x=.5*(l+r)+mix(-2.,2.,rnd(i,18)),y=floorAt(vec2(x,z)),size=mix(.40,1.36,rnd(i,17));if(abs(y)>6.)size=0.;
 vec3 d=vec3(cos(a)*sin(PI*v),cos(PI*v),sin(a)*sin(PI*v));d=sign(d)*pow(abs(d),vec3(.77));
 tag=-8.;return vec3(x,y-.19,z)+d*size*vec3(1.6,.60,.94)*(1.+.11*noise2(d.xy*4.+float(i)));}
 if(group==0||group==18){
 int tuft=i;if(group==18){i=5+int(rnd(tuft,1)*15.);u=rnd(tuft,2);a=2.*PI*u;v=acos(mix(-.20,1.,rnd(tuft,3)))/PI;}
 const vec4 rocks[]=vec4[](vec4(167,995,128,72),vec4(523,959,125,86),vec4(742,1103,92,83),vec4(1055,1115,211,73),vec4(388,1010,158,68),vec4(362,978,124,73),vec4(434,960,68,63),vec4(642,1030,111,49),vec4(749,1061,112,49),vec4(139,867,82,54),vec4(56,881,99,64),vec4(120,928,61,46),vec4(855,1092,88,41),vec4(24,993,80,39),vec4(125,1098,105,53),vec4(288,1096,113,39),vec4(503,1084,78,41),vec4(243,1022,42,24),vec4(448,1025,37,19),vec4(550,1054,59,25));
 const float depths[]=float[](15.7,16.1,13.1,14.1,15.,14.2,14.7,14.6,14.4,17.1,17.,16.8,14.,13.8,12.7,13.2,13.6,13.8,13.9,14.4);
 vec4 b=rocks[i];float z=depths[i];vec3 dir=vec3(cos(a)*sin(PI*v),cos(PI*v),sin(a)*sin(PI*v));
 bool moss=i>=5;vec3 shape=sign(dir)*pow(abs(dir),vec3(moss?1.:.67));
 float n=noise2(dir.xy*4.+dir.z*3.+float(i));
 shape*=.97+(moss?.035:.09)*n+(moss?.007:.012)*noise2(dir.xy*22.+dir.z*13.);
 shape.y-=moss?0.:.20*shape.x+.12*shape.z;
 vec3 center=place(b.xy,z)+shape*vec3(b.z,b.w,b.z*.67)*z/1404.;tag=moss?12.:11.;
 if(group==18){vec3 n=normalize(dir/vec3(b.z,b.w,b.z*.67));vec3 side=normalize(cross(n,vec3(.01,.97,.18))),up=cross(n,side);
 float angle=rnd(tuft,4)*6.283;float polar=angle+uv.x*6.283;
 float petals=cos(5.*(polar-angle))*.26+.72;
 center+=z/1404.*mix(1.,2.8,rnd(tuft,5))*(n*(1.1-.91*uv.y)+uv.y*petals*(cos(polar)*side+sin(polar)*up));}return center;
 }
 if(group==17){
 // Eight irregular whorls on the spruce nearest the moss shelf.
 int tier=i/(7*20*16),arm=(i/(20*16))%7,fan=(i/16)%20,j=i%16,seed=tier*103+arm*37;
 float f=(float(tier)+.3)/8.,az=float(tier)*2.4+float(arm)*.898+.36*(rnd(seed,5)-.5);
 vec3 d=vec3(cos(az),0,sin(az)),side=vec3(-d.z,0,d.x);
 vec3 origin=mix(place(vec2(518,660),83.),place(vec2(516,929),83.),f);
 float len=(.4+6.05*pow(f,.78))*(.75+.40*rnd(seed,7)),t=(float(fan/2)+1.)/11.;
 vec3 anchor=origin+d*len*(1.16*t-.16*t*t)+vec3(0.,len*(-1.06*t+.75*t*t),0.);
 float twigLen=len*(1.-float(fan/2+1)/15.)*mix(.47,.72,rnd(seed,fan));
 vec3 twig=d*.45+side*(fan%2==0?.72:-.72)+vec3(0.,-.62,0.);
 float along=float(j/2)/8.;vec3 q=anchor+twig*twigLen*along;
 float span=twigLen*(.38-.22*along);
 vec3 dir=twig*.5+d*.33+side*(j%2==0?-.49:.49)+vec3(0,-.18,0);
 vec3 ridge=normalize(cross(dir,vec3(0,1,0)));
 tag=22.125;return q+span*(dir*u+ridge*(v-.5)*.28*sin(PI*u)+vec3(0.,.03*sin(PI*u),0.));
 }
 if(group==19){tag=21.;return place(mix(vec2(516,928),vec2(518,660),u),83.)+vec3((v-.5)*.29*(1.-u),0.,0.);}
 if(group==1){
 float x=mix(-300.,1450.,u);float y=828.+.19*max(x-130.,0.)+.23*max(x-400.,0.)+7.*noise2(vec2(x*.025,1.))+380.*v;
 tag=10.;return place(vec2(x,y),mix(19.1,10.6,v));}
 if(group==2){
 float y=mix(-190.,915.,v),z=i==0?18.6:34.,base=i==0?15.+.014*(480.-y):131.+(800.-y)*.058+5.*sin(y*.011);
 float r=(i==0?70.+33.*v+58.*pow(v,12.):17.+5.*v)*(.96+.035*sin(a*11.+3.*v)+.05*noise2(vec2(9.*cos(a),4.*v+6.*sin(a))));
 tag=19.;return place(vec2(base,y),z)+vec3(cos(a)*r,0.,sin(a)*r)*z/1404.;}
 // Each branch forks into lateral, drooping sprays with individual pointed needles.
 if(group>=3&&group<=5){
 // The branch survey is in the design lens's 1100-unit horizontal frame.
 const vec4 limbs[]=vec4[](vec4(93,-60,384,65),vec4(169,-23,283,18),vec4(9,99,214,223),vec4(12,143,206,201),vec4(7,213,169,322),vec4(3,306,147,370),vec4(22,-17,256,35),vec4(29,44,199,154),vec4(134,-24,335,113),vec4(1117,198,1041,273),vec4(1127,251,1044,322),vec4(1118,337,997,433),vec4(1125,492,990,561),vec4(1118,547,1030,623));
 const float spread[]=float[](1.09,.84,.8,.75,.74,.65,1.21,1.33,1.05,.89,.7,.93,1.12,.82);
 const float depths[]=float[](18.,18.,18.,18.,18.,18.,19.,19.,17.,24.,23.,23.,21.,21.);
 int limb=group==3?i:group==4?i/36:i/(36*15*28),lat=group==4?i%36:(i/(15*28))%36,shoot=(i/28)%15,j=i%28;
 float z=depths[limb];vec4 b=limbs[limb]*1.74545;
 vec3 p0=place(b.xy,z),p1=place(b.zw,z+1.5),d=p1-p0;
 int seed=limb*101+lat;float t=group==3?u:(float(lat/2)+.12+.71*rnd(seed,4))/18.;
 vec3 root=mix(p0,p1,t)+vec3(0.,-.25,.26)*sin(PI*t);
 if(group==3){tag=-.1;return root+vec3(0.,(v-.5)*.08*pow(1.-u,1.7),0.);}
 float side=lat%2==0?-1.:1.;
 float width=1.17*spread[limb]*(.28+.72*pow(max(.0001,sin(PI*t)),.52))*(.6+.45*rnd(seed,3));
 vec3 branch=vec3(d.x*mix(.06,.19,rnd(seed,4))+side*width*.48,width*(side>0.?mix(-.15,.32,rnd(seed,1)):-1.)*mix(.7,1.55,rnd(seed,7)),width*side*.85);
 if(group==4){tag=21.;return root+u*branch+vec3(0.,(v-.5)*.04*(1.-u),0.);}
 vec3 axis=normalize(branch),s=normalize(cross(axis,vec3(0,1,0)));
 float f=(float(shoot)+mix(.05,.92,rnd(seed,shoot+22)))/15.,angle=float(shoot)*2.39996+.96*(rnd(seed,shoot+71)-.5);
 vec3 outDir=s*cos(angle)+cross(axis,s)*sin(angle);float scale=width*.67;
 vec3 spr=(outDir*.56+axis*.71+vec3(0,-.29,0))*scale*(1.-.61*f)*mix(.72,1.22,rnd(seed,shoot+56));
 vec3 az=normalize(spr),tangent=normalize(cross(az,vec3(0,1,0)));
 float g=(float(j)+mix(.07,.93,rnd(i,5)))/28.,phi=float(j)*2.39996+mix(-.47,.47,rnd(i,9));
 vec3 rad=tangent*cos(phi)+cross(az,tangent)*sin(phi);
 vec3 tip=(rad*.57+az*.65+vec3(0,-.16,0))*scale*mix(.21,.48,rnd(i,4))*(1.-.5*g);
 tag=.15+.29*f;return root+branch*f+spr*g+tip*u+cross(az,rad)*max(.006,scale*.017)*(1.-.37*g)*(2.*v-1.)*sin(PI*u);
 }
 if(group==6||group==7||group==13||group==14){
 bool close=group>=13;bool spine=group==7||group==14;
 int fr=spine?i:i/36,leaf=i%36;
 const vec2 starts[]=vec2[](vec2(275,895),vec2(405,893),vec2(843,1013),vec2(34,1119));
 int cluster=close?3:fr/7;int arm=fr%7;vec2 o=starts[cluster];
 float angle=mix(-2.95,-.20,(float(arm)+.4*rnd(fr,2))/7.);
 vec2 extent=vec2(cos(angle),sin(angle))*(cluster==3?245.:cluster==0?90.:46.)*(.66+.54*rnd(fr,7));
 float t=spine?u:(float(leaf/2)+.7)/19.;vec2 p=o+extent*t+vec2(0.,.42*abs(extent.x)*t*t-22.*t*(1.-t));
 if(spine)p.x+=(v-.5)*1.8;else{float side=leaf%2==0?-1.:1.;vec2 d=normalize(extent);
 float w=(cluster==3?49.:cluster==0?18.:9.)*(.22+.78*sin(PI*pow(t,.8)))*(.70+.48*rnd(i,2));
 vec2 dir=normalize(d*.52+side*vec2(-d.y,d.x));p+=w*(dir*u+vec2(-dir.y,dir.x)*(v-.5)*.37*sin(u*PI));}
 tag=close?25.125:13.125;return place(p,(close?7.1:15.35)+.08*t+.05*u);}
 if(group==8||group==9){
 bool stem=group==9;int flower=stem?i:i/9;vec2 o=flower==0?vec2(371,981):vec2(422,988);
 vec2 p;if(stem)p=o+vec2(-8.*sin(PI*u)+3.*u+(v-.5)*1.9,111.*u);
 else{float theta=6.283*float(i%9)/9.;p=o+vec2(cos(theta)*12.*u+(v-.5)*8.*sin(PI*u),4.*sin(theta)*u-11.*u*u);}
 if(!stem){float theta=6.283*float(i%9)/9.;p=o+vec2(cos(theta)*(4.+10.*u)+(v-.5)*10.*sin(PI*u),3.*sin(theta)*(1.+u)-7.*u*u+(v-.5)*4.*sin(PI*u));}tag=stem?16.125:18.125;return place(p,12.8+.05*float(flower)+.03*u);}
 if(group==10){
 int cl=i/3;vec2 o=cl<4?vec2(284,1060):cl<8?vec2(467,1060):vec2(72,908);
 o+=vec2(rnd(cl,2)-.5,rnd(cl,4)-.5)*(cl<8?49.:99.);
 float phi=float(i%3)*2.0944+5.*rnd(cl,7);vec2 dir=vec2(cos(phi),sin(phi)*.63);float w=cl<8?24.:39.;
 vec2 p=o+dir*u*w+vec2(-dir.y,dir.x)*(v-.5)*w*pow(max(0.,sin(PI*u)),.58);
 tag=14.125;return place(p,12.5+.05*float(cl)+.08*sin(u*PI));}
 if(group==11){vec2 o=i==0?vec2(506,988):vec2(592,1030);vec2 p=o+vec2(64.*u,31.*u+6.*sin(PI*u)+(v-.5)*19.*sin(PI*u));tag=15.125;return place(p,13.4+.05*abs(v-.5)+.11*sin(u*PI));}
 if(group==12){int cl=i/20;vec2 o=cl==0?vec2(643,956):cl==1?vec2(974,1067):vec2(150,871);
 float a=mix(-2.98,-.17,rnd(i,2));float len=mix(17.,62.,rnd(i,5));vec2 p=o+len*vec2(cos(a)*u,sin(a)*u+.19*u*u)+vec2((v-.5)*(1.-u)*3.2,0.);
 tag=20.125;return place(p,cl==2?16.6:13.7);}
 // Arching main stem, six lateral pedicels and their amber seed heads.
 vec2 o=vec2(149,871),d=vec2(40,-123);float t=group==15&&i==0?u:.58+.068*float(group==16?i:i-1);
 vec2 p=o+d*t+vec2(10.*sin(t*PI),0.);float f=i%2==0?-1.:1.;
 if(group==15){if(i>0)p+=vec2(f*17.,-11.)*u;p.x+=(v-.5)*1.7;tag=16.125;}
 else{p+=vec2(-f*17.,-11.)+vec2(cos(a)*sin(PI*v),cos(PI*v))*4.8;tag=17.125;}
 return place(p,16.3+.06*v);}
const int patchCount=274267;
void unpackPatch(int id,out int inst,out ivec2 cell,out ivec2 span){
 if(id<4800){group=0;cols=60;rows=36;int ix=id-0;inst=ix/240;span=ivec2(3,3);cell=ivec2(ix%20,(ix/20)%12)*span;return;}
 if(id<5000){group=1;cols=100;rows=4;int ix=id-4800;inst=ix/200;span=ivec2(2,1);cell=ivec2(ix%50,(ix/50)%4)*span;return;}
 if(id<6200){group=2;cols=48;rows=50;int ix=id-5000;inst=ix/600;span=ivec2(2,2);cell=ivec2(ix%24,(ix/24)%25)*span;return;}
 if(id<6424){group=3;cols=32;rows=1;int ix=id-6200;inst=ix/16;span=ivec2(2,1);cell=ivec2(ix%16,(ix/16)%1)*span;return;}
 if(id<7432){group=4;cols=6;rows=1;int ix=id-6424;inst=ix/2;span=ivec2(3,1);cell=ivec2(ix%2,(ix/2)%1)*span;return;}
 if(id<219112){group=5;cols=2;rows=1;int ix=id-7432;inst=ix/1;span=ivec2(2,1);cell=ivec2(ix%1,(ix/1)%1)*span;return;}
 if(id<219868){group=6;cols=4;rows=2;int ix=id-219112;inst=ix/1;span=ivec2(4,2);cell=ivec2(ix%1,(ix/1)%1)*span;return;}
 if(id<219973){group=7;cols=15;rows=1;int ix=id-219868;inst=ix/5;span=ivec2(3,1);cell=ivec2(ix%5,(ix/5)%1)*span;return;}
 if(id<220009){group=8;cols=6;rows=3;int ix=id-219973;inst=ix/2;span=ivec2(3,3);cell=ivec2(ix%2,(ix/2)%1)*span;return;}
 if(id<220017){group=9;cols=12;rows=1;int ix=id-220009;inst=ix/4;span=ivec2(3,1);cell=ivec2(ix%4,(ix/4)%1)*span;return;}
 if(id<220101){group=10;cols=10;rows=5;int ix=id-220017;inst=ix/2;span=ivec2(5,5);cell=ivec2(ix%2,(ix/2)%1)*span;return;}
 if(id<220105){group=11;cols=14;rows=5;int ix=id-220101;inst=ix/2;span=ivec2(7,5);cell=ivec2(ix%2,(ix/2)%1)*span;return;}
 if(id<220225){group=12;cols=8;rows=1;int ix=id-220105;inst=ix/2;span=ivec2(4,1);cell=ivec2(ix%2,(ix/2)%1)*span;return;}
 if(id<220729){group=13;cols=6;rows=2;int ix=id-220225;inst=ix/2;span=ivec2(3,2);cell=ivec2(ix%2,(ix/2)%1)*span;return;}
 if(id<220764){group=14;cols=15;rows=1;int ix=id-220729;inst=ix/5;span=ivec2(3,1);cell=ivec2(ix%5,(ix/5)%1)*span;return;}
 if(id<220785){group=15;cols=12;rows=1;int ix=id-220764;inst=ix/3;span=ivec2(4,1);cell=ivec2(ix%3,(ix/3)%1)*span;return;}
 if(id<220821){group=16;cols=12;rows=8;int ix=id-220785;inst=ix/6;span=ivec2(4,4);cell=ivec2(ix%3,(ix/3)%2)*span;return;}
 if(id<238741){group=17;cols=3;rows=2;int ix=id-220821;inst=ix/1;span=ivec2(3,2);cell=ivec2(ix%1,(ix/1)%1)*span;return;}
 if(id<270741){group=18;cols=10;rows=1;int ix=id-238741;inst=ix/1;span=ivec2(10,1);cell=ivec2(ix%1,(ix/1)%1)*span;return;}
 if(id<270747){group=19;cols=12;rows=1;int ix=id-270741;inst=ix/6;span=ivec2(2,1);cell=ivec2(ix%6,(ix/6)%1)*span;return;}
 if(id<274267){group=20;cols=10;rows=6;int ix=id-270747;inst=ix/4;span=ivec2(5,3);cell=ivec2(ix%2,(ix/2)%2)*span;return;}
 inst=0;cell=ivec2(0);span=ivec2(1);}

vec2 originalProjection(vec3 p){return vec2(960.,464.4)+vec2(p.x,-(p.y-70.))*1404./p.z;}
int depthBand(float z){return z<9.?0:z<15.8?1:z<20.?2:z<28.?3:z<48.?4:z<120.?5:6;}
float bandDepth(int band){return band==0?7.1:band==1?14.3:band==2?18.:band==3?23.:band==4?34.:band==5?83.:320.;}
int patchKey(vec4 r){if(r.z<.1)return 16777200;int lvl=int(r.w/524288.);
 float tile=16.*exp2(float(lvl));ivec2 xy=ivec2(floor(r.xy/tile))+ivec2(48);return ((depthBand(r.z)*5+lvl)*256+clamp(xy.y,0,255))*256+clamp(xy.x,0,255);}
ivec2 patchAddress(int idx,int width){int i=524288+idx;return ivec2(i%width,i/width);}
struct ForegroundHit {float z;int id;int instance;int grp;vec2 uv;};
vec3 projectPoint(vec3 p){vec3 q=p-cameraEye();return vec3(960.+1404.*(q.x/q.z+truck/325.),464.4-1404.*q.y/q.z,q.z);}
void fgTri(vec2 pos,vec3 a,vec3 b,vec3 c,vec2 u,vec2 v,vec2 w,inout ForegroundHit best,int idx,int inst){
 vec2 ab=b.xy-a.xy,ac=c.xy-a.xy;float det=cross2(ab,ac);if(abs(det)<.00004)return;
 float s=cross2(pos-a.xy,ac)/det,t=cross2(ab,pos-a.xy)/det;
 if(min(s,min(t,1.-s-t))<0.)return;vec3 ba=vec3(1.-s-t,s,t)/vec3(a.z,b.z,c.z);
 float z=1./dot(ba,vec3(1));if(z>=best.z)return;
 best=ForegroundHit(z,idx,inst,group,z*(u*ba.x+v*ba.y+w*ba.z));}
vec3 movingSurface(int instance,vec2 uv,out float material){
    vec3 p=surface(instance,uv,material);
    float bend=material>1.?0.:max(material,0.);
    p.x+=controls.w*bend*.081*sin(phase+p.z*.16+p.y*.21);
    return p;
}
void patchHit(vec2 pos,int idx,inout ForegroundHit best){
 int inst;ivec2 cell,span;unpackPatch(idx,inst,cell,span);float tag;
 for(int y=0;y<span.y;y++)for(int x=0;x<span.x;x++){
 vec2 s=1./vec2(cols,rows),a=vec2(cell+ivec2(x,y))*s;
 vec2 b=a+vec2(s.x,0),c=a+s,d=a+vec2(0,s.y);
 vec3 A=projectPoint(movingSurface(inst,a,tag)),B=projectPoint(movingSurface(inst,b,tag)),C=projectPoint(movingSurface(inst,c,tag)),D=projectPoint(movingSurface(inst,d,tag));
 if(any(lessThan(pos,min(min(A.xy,B.xy),min(C.xy,D.xy))))||any(greaterThan(pos,max(max(A.xy,B.xy),max(C.xy,D.xy)))))continue;
 fgTri(pos,A,B,C,a,b,c,best,idx,inst);fgTri(pos,A,C,D,a,c,d,best,idx,inst);}}
ivec2 bucketRange(int band,int lvl,ivec2 tile){
 ivec2 xy=tile+ivec2(30,5);if(any(lessThan(xy,ivec2(0)))||any(greaterThanEqual(xy,ivec2(184,84))))return ivec2(0);
 int address=xy.x+184*(xy.y+84*(lvl+5*band));int width=int(iChannelResolution[2].x);
 ivec2 loc=ivec2(address%width,address/width+int(floor(.68*iChannelResolution[2].y)));
 return ivec2(texelFetch(iChannel2,loc,0).xy+.5);}
vec2 designPixel(vec2 pixel,float worldDepth){
    float depth=worldDepth+.09*truck;
    vec2 centered=pixel-vec2(960.+1404.*truck/325.,464.4);
    return vec2(960.,464.4)+(centered*depth+1404.*vec2(truck,-.035*truck))/worldDepth;
}
ForegroundHit frontLayer(vec2 pos,float stopZ){
 ForegroundHit best=ForegroundHit(stopZ,-1,0,0,vec2(0));
 for(int band=1;band<7;band++){
 float dep=bandDepth(band);if(dep*.72>best.z)continue;
 vec2 remap=designPixel(pos,dep);
 
 if(band==1&&(remap.x>1460.||remap.y<751.))continue;
 if(band==5&&(remap.x<370.||remap.x>670.||remap.y<610.||remap.y>980.))continue;
 if(band==6&&remap.y<620.)continue;
 for(int lvl=0;lvl<5;lvl++){float tile=16.*exp2(float(lvl));ivec2 cell=ivec2(floor(remap/tile));
 for(int dy=-1;dy<=1;dy++)for(int dx=-1;dx<=1;dx++){
 ivec2 range=bucketRange(band,lvl,cell+ivec2(dx,dy));
 for(int j=0;j<range.y;j++){vec4 record=texelFetch(iChannel1,patchAddress(range.x+j,int(iChannelResolution[1].x)),0);
 if(record.z*.87>best.z)continue;float bound=tile*.9;
 vec2 delta=abs(remap-record.xy);if(max(delta.x,delta.y)>bound+4.)continue;
 patchHit(pos,int(record.w)%524288,best);}
 }}}
 return best;
}
vec3 surfaceVertex(int i,vec2 uv,out vec3 n,out float edgeWeight,out float tag){
    float tmp;vec3 p=movingSurface(i,uv,tag);
vec2 h=vec2(.0007,0.);
 vec3 du=surface(i,uv+h,tmp)-surface(i,uv-h,tmp),dv=surface(i,uv+h.yx,tmp)-surface(i,uv-h.yx,tmp);
 n=cross(du,dv);if(length(n)<.0000001)n=vec3(0,1,0);n=normalize(n);
 if(group==0){n=normalize(n+vec3(0.,.001,0.));}else if(group==2){if(n.z>0.&&sin(uv.x*2.*PI)<0.)n=-n;}else if(n.z>0.)n=-n;
 if(group>=6&&group<17&&group!=16)n=normalize(vec3(n.x*.3,.38+.60*sin(uv.y*PI),-.7));
 if(group==0&&i>=5){float a=uv.x*2.*PI;vec3 smoothN=vec3(cos(a)*sin(PI*uv.y),1.6*cos(PI*uv.y),1.8*sin(a)*sin(PI*uv.y));n=normalize(mix(normalize(smoothN),n,.21));}
 if(group==18){float a=6.283185*rnd(i,2),y=mix(-.20,1.,rnd(i,3)),r=sqrt(1.-y*y);vec3 shell=normalize(vec3(cos(a)*r,1.6*y,1.8*sin(a)*r));n=normalize(mix(shell,n,.12));}

edgeWeight=group==18?-mix(.3,.95,uv.y)*(.5+.5*rnd(i,6)):group==5?.28+.69*rnd(i,8):group==3?-.69:group==2?0.:abs(2.*uv.y-1.);return p;
}
float closeVisibility(vec3 p,vec3 normal){
    vec3 l=sunlight(),r=normalize(cross(l,vec3(0,1,0))),u=cross(r,l);
    vec3 d=p+normal*.012-vec3(-6,63.8,17);
    vec3 uvz=vec3(dot(d,r)/11.,dot(d,u)/11.,-dot(d,l)/27.)*.5+.5;
    if(any(greaterThan(abs(uvz.xy-.5),vec2(.498)))||uvz.z<0.||uvz.z>1.)return 1.;
    float sum=0.;int w=int(iChannelResolution[2].x);
    for(int i=0;i<12;i++){
        float a=float(i)*2.39996;vec2 dq=vec2(cos(a),sin(a))*sqrt((float(i)+.5)/12.)*.0034;
        ivec2 node=clamp(ivec2((uvz.xy+dq)*1024.),ivec2(0),ivec2(1023));
        int at=900000+(node.y/2)*512+node.x/2;
        float depth=texelFetch(iChannel2,ivec2(at%w,at/w),0)[node.x%2+2*(node.y%2)];
        sum+=step(uvz.z-.001,depth);
    }return sum/12.;
}
vec4 fgColor(ForegroundHit hit){
    int i;ivec2 cell,span;unpackPatch(hit.id,i,cell,span);
    vec2 grid=hit.uv*vec2(cols,rows),base=clamp(floor(grid),vec2(0),vec2(cols-1,rows-1));
    vec2 f=grid-base;bool lower=f.y<=f.x;
    vec3 weights=lower?vec3(1.-f.x,f.x-f.y,f.y):vec3(1.-f.y,f.y-f.x,f.x);
    vec3 n=vec3(0),p=vec3(0);float edgeWeight=0.,tag=0.;
    for(int k=0;k<3;k++){
        vec2 corner=k==0?vec2(0):k==2?vec2(1):lower?vec2(1,0):vec2(0,1);
        vec3 vn;float margin,material;
        p+=weights[k]*surfaceVertex(i,(base+corner)/vec2(cols,rows),vn,margin,material);
        n+=weights[k]*vn;edgeWeight+=weights[k]*margin;tag+=weights[k]*material;
    }
    n=normalize(n);
    if(tag>=10.)tag=round(tag*10000.)/10000.;
    vec2 species=vec2(edgeWeight,tag);
 vec2 crown=vec2(edgeWeight,clamp(mod(fract(tag)+.001,.125)/.036,0.,1.));vec3 sun=sunlight(),c;

        
        vec2 barkUV=vec2(p.x*11.+p.z*5.+.3*sin(p.y*.8),p.y*.93);
        float plated=gradientNoise(vec2(barkUV.x*.75,p.y*4.1));
        float furrow=fbm(barkUV+vec2(plated*.8,0.),4);
        float lichen=smoothstep(.25,.51,fbm(p.xy*21.+p.z*5.,3));
        vec3 bark=srgbToLinear(mix(vec3(.10,.077,.082),vec3(.30,.22,.191),smoothstep(-.28,.30,furrow)));
        float rim=max(dot(n,normalize(vec3(sun.x,.20,.48))),0.);
        vec3 needle=srgbToLinear(mix(vec3(.060,.136,.129),vec3(.29,.291,.165),.12+.49*species.x));
        c=mix(mix(bark,vec3(.135,.14,.10),lichen*.0),needle,step(0.,species.x))*(.49+.84*rim)+key()*.061*pow(rim,4.);
        if(species.y>=0.&&species.x>0.){
            float scatter=pow(1.-abs(dot(n,normalize(cameraEye()-p))),2.);
            c+=vec3(.24,.152,.054)*scatter*max(0.,dot(n,sun))*(.50+.5*species.x);
        }
        if(species.y>=10.){
            int mat=int(species.y);float thin=fract(species.y)>.06?1.:0.;
            vec3 view=normalize(cameraEye()-p);
            float s=clamp(dot(n,sun),0.,1.),fres=1.-abs(dot(n,view));
            float vis=closeVisibility(p,n);
            vec3 edgeDir=normalize(sun-view*dot(view,sun));
            float facingEdge=clamp(dot(n,edgeDir),0.,1.);
            float canopyBounce=.24+.76*vis;
            float wrap=smoothstep(-.42,.78,dot(n,sun));
            float margin=crown.x;
            vec3 ink=vec3(.15,.165,.115),lit=vec3(.36,.355,.18);
            if(mat==11){
                // Broad mineral domains determine color. The grain perturbs the normal.
                float patchwork=fbm(p.xz*2.7+p.xy*.96,4);
                vec2 grain=gradientNoiseD((p.xz+.28*p.xy)*22.).yz;
                float footprint=length(fwidth(p))*22.;
                vec3 rockN=normalize(n+vec3(grain.x,0.,grain.y)*.115*(1.-smoothstep(.24,1.,footprint)));
                float top=smoothstep(.62,.92,rockN.y+.18*patchwork);
                float split=abs(gradientNoise(p.xy*vec2(5.8,2.)+p.z*1.3)+.42*gradientNoise(p.xz*2.));
                float joint=(1.-smoothstep(.007,.037,split))*smoothstep(.06,.31,patchwork);
                float dapple=.84+.16*gradientNoise(p.xz*4.+1.3*p.xy);
                float rockKey=max(dot(rockN,normalize(vec3(sun.x*1.8,.51,.78))),0.);
                float occlusion=clamp(.78+.22*vis,.0,1.);
                float textureRock=fbm(p.xy*9.+p.z*4.7,3);
                float lichenRock=smoothstep(.24,.38,textureRock+.23*patchwork);
                float faceLight=clamp(.12+.82*max(dot(rockN,normalize(vec3(-.55,.66,.51))),0.),0.,1.);
                vec3 stone=mix(vec3(.126,.132,.181),vec3(.83,.639,.57),
                    top*(.88+.12*rockKey)*(.81+.19*vis)*(.95+.05*dapple));
                stone+=vec3(.124,.109,.122)*faceLight*(1.-top);
                stone=mix(stone,vec3(.38,.375,.323),lichenRock*.27);
                c=srgbToLinear(stone*(.96+.30*patchwork+.17*textureRock-.28*joint));
                c+=srgbToLinear(vec3(.64,.416,.287))*top*max(rockKey-.18,0.)*(.38+.62*vis)*.4;
                vec2 bed=p.xz*vec2(5.1,10.7)+.49*p.xy;
                float fissure=gradientNoise(bed+.83*gradientNoise(bed*.36));
                float localJoint=1.-smoothstep(.009,.054,abs(fissure));
                float lip=smoothstep(.03,.11,fissure)*(1.-smoothstep(.11,.23,fissure));
                c*=1.-.23*localJoint*(.34+.66*top);
                c+=srgbToLinear(vec3(.56,.39,.31))*.29*lip*top*(.30+.70*vis);
                float crest=smoothstep(.33,.71,rockKey+.38*fissure);
                c+=srgbToLinear(vec3(.65,.43,.28))*crest*top*(.46+.54*vis);
            }else if(mat==12){
                float lumps=fbm(p*13.1,4,2.01,.5);
                float tip=gradientNoise(p*45.);
                vec3 raking=normalize(vec3(sun.x*1.7,.43,.74));
                float upsun=dot(n,raking);
                float rim=smoothstep(.52,.91,fres)*smoothstep(.08,.64,upsun);
                float steep=max(0.,dot(n,normalize(vec3(-.59,.65,.48))));
                float contact=.72+.28*smoothstep(-.24,.44,n.y);
                vec3 body=mix(vec3(.075,.091,.040),vec3(.222,.231,.098),.42+.76*lumps+.22*steep);
                vec3 gold=mix(vec3(.40,.405,.153),vec3(.80,.65,.29),.53+.69*tip);
                c=srgbToLinear(body*contact*(.84+.46*lumps+.16*tip))+
                    srgbToLinear(gold)*rim*(1.03+.53*vis)*mix(.22,1.,smoothstep(12.8,14.2,p.z));
                float cover=smoothstep(-.51,-.11,n.y+.50*lumps);
                c=mix(srgbToLinear(vec3(.126,.136,.151)*(.78+.42*lumps)),c,cover);
                float stars=gradientNoise(p*79.);c*=.92+.31*stars;c+=srgbToLinear(gold)*rim*.40*smoothstep(.04,.32,stars);
                if(margin<0.){
                    float tuft=-margin;
                    c*=.56+.50*tuft;
                    c+=srgbToLinear(vec3(.71,.59,.30))*tuft*tuft*(.004+rim*.26);
                }
            }else if(mat==19){
                vec2 uv=vec2(p.x*4.3+p.z*2.3,p.y*1.35);
                uv+=vec2(.66*gradientNoise(uv*.73),.42*gradientNoise(uv*.53+12.));
                vec2 cell=floor(uv),fr=fract(uv);float d1=9.,d2=9.;
                for(int j=-1;j<=1;j++)for(int i=-1;i<=1;i++){
                    vec2 off=vec2(i,j),coord=cell+off;
                    vec2 delta=off+.13+.73*vec2(hash12(coord),hash12(coord+47.))-fr;
                    float dd=dot(delta,delta);if(dd<d1){d2=d1;d1=dd;}else d2=min(dd,d2);
                }
                float plate=smoothstep(.015,.26,d2-d1);
                float flake=fbm(p.xy*vec2(13.,5.)+p.z*4.,3);
                float lichen=smoothstep(.12,.24,fbm(vec2(p.x+p.z*.32,p.y)*2.4,4)+.38*flake);
                vec3 wood=mix(vec3(.097,.084,.102),vec3(.19,.153,.168),plate*(.8+.32*flake));
                wood*=.75+.53*max(dot(n,normalize(vec3(-.45,.21,-.90))),0.)+.52*flake+.17*gradientNoise(p.xy*vec2(31.,9.)+p.z*8.);
                wood=mix(wood,vec3(.268,.290,.253),lichen*.49);
                float rootMoss=smoothstep(.11,.57,crown.x+.28*flake-.16*n.x);
                wood=mix(wood,vec3(.20,.224,.092)*(.80+.45*flake),rootMoss);
                
                float axisZ=p.z>28.?34.:18.6;
                float yFrame=464.4+(70.-p.y)*1404./axisZ;
                float axisU=p.z>28.?131.+(800.-yFrame)*.058+5.*sin(yFrame*.011):15.+.014*(480.-yFrame);
                vec3 macroN=normalize(vec3(p.x-(axisU-960.)*axisZ/1404.,0.,p.z-axisZ));
                float cutEdge=pow(1.-abs(dot(macroN,view)),5.)*max(macroN.x,0.);
                c=srgbToLinear(wood)+srgbToLinear(vec3(.92,.607,.383))*cutEdge*(.51+.49*vis);
            }else{
                if(mat==13){ink=vec3(.12,.137,.066);lit=vec3(.65,.544,.235);}
                if(mat==14){ink=vec3(.143,.215,.167);lit=vec3(.35,.41,.251);}
                if(mat==15){ink=vec3(.32,.12,.055);lit=vec3(.72,.35,.116);}
                if(mat==16){ink=vec3(.22,.25,.167);lit=vec3(.46,.438,.247);}
                if(mat==17){ink=vec3(.39,.283,.136);lit=vec3(.83,.634,.315);}
                if(mat==18){ink=vec3(.48,.373,.309);lit=vec3(.77,.637,.509);}
                if(mat==20){ink=vec3(.264,.24,.135);lit=vec3(.66,.51,.361);}
                if(mat==24){ink=vec3(.088,.15,.143);lit=vec3(.25,.323,.246);}
                if(mat==21){ink=vec3(.14,.095,.086);lit=vec3(.37,.228,.164);}
                if(mat==22){ink=vec3(.074,.152,.112);lit=vec3(.68,.533,.295);}
                if(mat==23){ink=vec3(.065,.126,.106);lit=vec3(.61,.526,.245);}
                if(mat==25){ink=vec3(.107,.148,.125);lit=vec3(.30,.354,.228);}
                float tissue=gradientNoise(p*29.);
                float vein=1.-smoothstep(.02,.13,margin);
                float transmission=.10+.47*margin*margin+.25*fres+.18*wrap;
                float face=clamp(.24+.52*max(n.y,0.)+.22*max(dot(n,sun),0.),0.,1.);
                float transmit=transmission*(.33+.67*wrap)*canopyBounce*thin;
                if(mat==17)transmit=(.27+.53*fres+.18*max(n.y,0.))*(.62+.38*vis)*thin;
                if(mat==18)transmit=(.10+.27*crown.y+.32*max(dot(n,normalize(vec3(-.66,.65,-.31))),0.)+.19*fres)*(.64+.36*vis)*thin;
                if(mat==20||mat==13)transmit+=thin*.32*pow(margin,2.)*(.39+.61*vis);
                if(mat==14||mat==15)transmit+=thin*.20*crown.y*margin;
                if(mat==22)transmit=.045+.72*pow(max(n.y,0.),1.4)*(.22+.78*pow(fres,1.3))*(.35+.65*max(dot(n,edgeDir),0.));
                if(mat==25)transmit*=.28;
                c=mix(srgbToLinear(ink)*(.66+.42*face),srgbToLinear(lit),clamp(transmit,0.,1.));
                c*=.88+.22*tissue+.1*vein;
                if(mat==14||mat==15||mat==18){
                    float ribs=cos(28.*crown.y-11.*margin);
                    c*=.90+.12*crown.y+.12*vein+.045*ribs;
                    c+=srgbToLinear(lit)*(.10*vein+.05*max(0.,ribs))*crown.y;
                }
                if(mat==22){
                    float sky=clamp(n.y*.43+.52,0.,1.);
                    float border=pow(fres,1.7)*smoothstep(.12,.83,n.y)*max(dot(n,edgeDir),0.);
                    c=srgbToLinear(mix(vec3(.076,.123,.108),vec3(.20,.263,.228),sky))*(.87+.22*tissue)
                        +srgbToLinear(vec3(.68,.49,.26))*border;
                    c=mix(c,srgbToLinear(vec3(.63,.47,.37)),.018);
                }
            }
            if(mat==10){
                float leafmold=fbm(p.xy*11.+p.z*4.,4);
                c*=.64+.78*smoothstep(-.42,.36,leafmold);
            }
            if(mat==27){
                float fringe=.23+.77*pow(fres,1.15);
                float sunward=clamp(dot(n,edgeDir)*.62+.38*n.y+.12,0.,1.);
                c=srgbToLinear(vec3(.139,.197,.160))+srgbToLinear(vec3(.87,.675,.377))*sunward*fringe;
            }
            if(mat==13||mat==15||mat==17||mat==20||mat==23){
                float blade=smoothstep(.65,.98,margin);
                float back=clamp(dot(normalize(p-cameraEye()),sun),0.,1.);
                float glint=(.11+.89*max(dot(n,edgeDir)+.14,0.))*back;
                vec3 transmission=mat==15?vec3(.94,.47,.18):vec3(.95,.77,.48);
                c+=srgbToLinear(transmission)*(.22+.78*vis)*thin*glint*
                   (mat==17?.12+.39*fres:(.055+.55*blade));
            }
            if(mat==13||mat==20||mat==17||mat==23){
                float slope=dot(n,normalize(vec3(-.47,.64,-.19)));
                float exposed=smoothstep(-.23,.77,slope);
                float edgeLight=smoothstep(.56,.95,margin+.12*n.y);
                if(mat==17)edgeLight=pow(fres,1.7);
                c+=srgbToLinear(vec3(.99,.837,.58))*thin*(.38+.62*vis)*edgeLight*exposed;
            }
            c*=mix(vec3(.59,.72,1.05),vec3(1.),controls.y/.88);
            // Store the close-subject circle of confusion for the resolve. The
            // isolated lens fern is resolved separately across its silhouette.
            float coc=clamp(74.*abs(1./max(p.z,1.)-1./15.25),0.,2.);
            float focus=.40+.075*coc;
            if(mat==23){
                float top=max(n.y,0.),rimNeedle=pow(fres,1.4)*smoothstep(.10,.80,top);
                float toward=clamp(dot(n,edgeDir)*.75+.25,0.,1.);
                c=srgbToLinear(mix(vec3(.058,.120,.100),vec3(.199,.265,.200),top))+
                    srgbToLinear(vec3(.89,.682,.357))*rimNeedle*toward*(.60+.40*vis);
            }
            if(mat==18){
                float petal=dot(n,normalize(vec3(-.57,.73,-.37)));
                vec3 blush=mix(vec3(.34,.237,.185),vec3(.795,.669,.568),smoothstep(-.53,.81,petal));
                c=srgbToLinear(blush)*(.65+.35*crown.y)+srgbToLinear(vec3(.43,.32,.20))*.15*fres;
            }
            if(mat==28)c=mix(srgbToLinear(vec3(.266,.308,.103)),srgbToLinear(vec3(.69,.573,.211)),.26+.60*margin+.14*crown.y);
            if(mat==25)c=srgbToLinear(mix(vec3(.09,.132,.12),vec3(.247,.291,.205),.21+.40*max(n.y,0.)+.18*crown.y+.17*margin));
            if(mat==13||mat==20)c*=.37+.37*wrap;
            if(mat==22)c=mix(srgbToLinear(vec3(.095,.153,.126)),c,.60);
            return vec4(film(c),mat==25?1.:(mat==22||mat==27?.75:focus));
        }
if(tag< -7.5){
    float grain=fbm(p.xy*1.23+p.z*.57,3);
    vec3 stone=mix(vec3(.27,.26,.29),vec3(.49,.454,.426),max(0.,n.y));
    c=srgbToLinear(stone+grain*.045)*(vec3(.68,.73,.85)+key()*(.18+.69*max(0.,dot(n,sun))));
}
return vec4(film(valleyAir(c,p,cameraEye())),tag>=0.&&edgeWeight>0.?0.:1.);}

void renderSample(out vec4 color,in vec2 uv){
 float f=mod(iTime*48.,248.)*.5;truck=f<=62.?-.92*(1.-cos(f*3.14159265/62.)):-1.84+1.32*(1.-cos((min(f,123.)-62.)*3.14159265/61.));phase=iTime*6.2831853/(124./24.);
 vec3 ro=cameraEye(),rd=vec3((uv.x-.5)*2.*iResolution.x/iResolution.y/2.6-truck/325.,(uv.y-.57)*2./2.6,1.);
 float water=rd.y<0.?-ro.y/rd.y:9999.,z;vec3 c=environment(ro,rd,false,min(1600.,water),z);
 if(water<1600.&&z>=water){vec3 p=ro+water*rd,sun=sunlight();float near=1.-smoothstep(100.,550.,p.z);
        vec2 lake=p.xz;
        float exposure=smoothstep(-.50,.43,fbm(lake*.023+vec2(7.,12.),3));
        float shore=smoothstep(.15,5.4,-bed(lake));
        float ruffle=(.38+.62*exposure)*mix(.38,1.,shore);
        vec2 drift=vec2(cos(phase)-1.,sin(phase));
        vec2 bend=vec2(gradientNoise(lake*.055),gradientNoise(lake*.038+17.));
        vec2 slope=vec2(0.);
        // Each wind patch has an independent direction, wavelength and envelope.
        // The noise derivative supplies short crests with finite, tapered ends.
        for(int j=0;j<4;j++){
            float k=float(j),seed=8.72*k;
            float angle=.21*sin(2.39*k);
            vec2 along=vec2(cos(angle),sin(angle)),across=vec2(-along.y,along.x);
            float freq=.47*exp2(1.05*k);
            vec2 st=vec2(dot(lake,along)*(.29+.066*k),dot(lake,across))*freq;
            float clock=phase*(1.+mod(k,2.))+.83*k;
            vec2 travel=vec2(cos(clock)-cos(.83*k),sin(clock)-sin(.83*k));
            st+=vec2(seed,seed*.91)+bend*(.52+.24*k)+travel*(.31+.24*k);
            st.y+=1.8*gradientNoise(lake*vec2(.019,.031)+seed);
            vec3 swell=gradientNoiseD(st);
            float resolved=1.-smoothstep(.32,1.30,max(fwidth(st.x),fwidth(st.y)));
            float fetchWeight=smoothstep(-.58,.38,gradientNoise(lake*(.024+k*.011)+seed));
            slope+=(along*swell.y*.20+across*swell.z)*(.90/(1.+.48*k))*fetchWeight*resolved;
        }
        slope*=ruffle;
        vec2 displaced=clamp(uv+vec2(slope.x*.011,slope.y*.0085),.001,.999);
        vec2 mirrorPixel=clamp(displaced*vec2(1344,756)-vec2(322,0),vec2(4),vec2(1018,409));
        float blur=.56+.94*ruffle+.52*(1.-near);
        vec3 reflectedLight=srgbToLinear(textureLod(iChannel2,mirrorPixel/iChannelResolution[2].xy,blur).rgb);
        vec3 normal=normalize(vec3(-.088*slope.x,1.,-.095*slope.y));
        vec3 view=normalize(ro-p);
        float fresnel=.55+.35*fresnelDielectric(max(.01,dot(view,normal)),1.,1.333);
        vec3 deep=srgbToLinear(mix(vec3(.247,.251,.321),vec3(.431,.369,.417),1.-near));
        vec3 radiance=mix(deep,reflectedLight,fresnel);
        float sparkle=pow(max(dot(reflect(-sun,normal),view),0.),140.);
        radiance+=key()*.33*sparkle;
        radiance+=vec3(.036,.030,.030)*slope.y*ruffle;
        float inlet=smoothstep(208.,388.,p.z);
        radiance+=vec3(.19,.116,.086)*inlet*inlet;
        float mist=exp(-pow((lake.y-303.-18.*bend.y)/24.,2.))*smoothstep(-.37,.36,fbm(lake*vec2(.037,.067)+drift*.14,3));
        radiance=mix(radiance,vec3(.63,.49,.48),mist*.32*controls.z);
        c=film(mix(radiance,valleyAir(radiance,p,ro),.51+.42*inlet));}
 vec2 pos=vec2(960.+(uv.x-.5)*1080.*iResolution.x/iResolution.y,(1.-uv.y)*1080.);
 ForegroundHit fh=frontLayer(pos,min(water,z));color=fh.id>=0?fgColor(fh):vec4(c,softFirstRow?.76:1.);
}

// The four visibility queries follow the 4x MSAA pattern of the approved render.
void mainImage(out vec4 color,in vec2 pixel){
    const vec2 samples[4]=vec2[4](vec2(.375,.125),vec2(.875,.375),vec2(.125,.625),vec2(.625,.875));
    ivec2 quadrant=ivec2(pixel)%2;
    vec2 samplePixel=floor(pixel*.5)+samples[quadrant.x+2*quadrant.y];
    renderSample(color,samplePixel/(iResolution.xy*.5));
    color=floor(clamp(color,0.,1.)*255.+.5)/255.;
}

#elif VALLEY_PASS == 4
// Resolve supersamples before applying the original optical filter widths.
vec4 worldLevel(vec2 uv,int level){
    ivec2 size=textureSize(iChannel0,level);
    vec2 pos=uv*vec2(size)-.5;
    ivec2 ij=ivec2(floor(pos));vec2 f=floor(fract(pos)*256.+.5)/256.;
    ivec2 hi=size-1;
    vec4 a=round(texelFetch(iChannel0,clamp(ij,ivec2(0),hi),level)*255.);
    vec4 b=round(texelFetch(iChannel0,clamp(ij+ivec2(1,0),ivec2(0),hi),level)*255.);
    vec4 c=round(texelFetch(iChannel0,clamp(ij+ivec2(0,1),ivec2(0),hi),level)*255.);
    vec4 d=round(texelFetch(iChannel0,clamp(ij+ivec2(1),ivec2(0),hi),level)*255.);
    return floor(16.*mix(mix(a,b,f.x),mix(c,d,f.x),f.y)+.5)/(16.*255.);
}
vec4 worldSample(vec2 uv,float lod){
    float scale=iChannelResolution[0].y/(1.4*iResolution.y);
    float mip=lod+max(0.,log2(scale));
    int base=int(floor(mip));return mix(worldLevel(uv,base),worldLevel(uv,base+1),fract(mip));
}
// Smooth scene color timing from twelve review swatches. No reference texture.
vec3 finishValley(vec2 uv){
 vec3 base=worldSample(uv,0.).rgb;
 vec3 mid=base-worldSample(uv,4.).rgb;
 vec3 high=base-worldSample(uv,1.).rgb;
 float needleCoverage=1.-worldSample(uv,.70).a;
 vec2 q=vec2(uv.x,1.-uv.y);vec3 change=vec3(0.);float total=.065;
 // sky_right
 {vec2 d=(q-vec2(0.885417,0.092593))/vec2(0.177083,0.087407);float w=exp(-1.60*dot(d,d));
 change+=w*(vec3(-0.057160,-0.023252,-0.002448)+(.55*mid+.45*(base-vec3(0.554910,0.557253,0.660230)))*0.305645+high*0.000000);total+=w;}
 // sun_halo
 {vec2 d=(q-vec2(0.213542,0.222222))/vec2(0.141667,0.196667);float w=exp(-1.60*dot(d,d));
 change+=w*(vec3(0.320000,0.155966,0.111011)+(.55*mid+.45*(base-vec3(0.632521,0.578710,0.479551)))*-0.206608+high*0.000000);total+=w;}
 // valley_mist
 {vec2 d=(q-vec2(0.458333,0.425926))/vec2(0.106250,0.087407);float w=exp(-1.60*dot(d,d));
 change+=w*(vec3(0.155569,0.115373,0.089110)+(.55*mid+.45*(base-vec3(0.693375,0.601882,0.592339)))*-0.340000+high*0.000000);total+=w;}
 // peak_lit
 {vec2 d=(q-vec2(0.580729,0.203704))/vec2(0.071000,0.174815);float w=exp(-1.60*dot(d,d));
 change+=w*(vec3(0.046859,0.053454,0.053180)+(.55*mid+.45*(base-vec3(0.778055,0.682753,0.670266)))*-0.340000+high*0.453992);total+=w;}
 // peak_shadow
 {vec2 d=(q-vec2(0.684896,0.231481))/vec2(0.075260,0.152963);float w=exp(-1.60*dot(d,d));
 change+=w*(vec3(0.139763,0.093637,0.082904)+(.55*mid+.45*(base-vec3(0.516521,0.449492,0.506831)))*0.092832+high*0.924073);total+=w;}
 // dome
 {vec2 d=(q-vec2(0.911458,0.296296))/vec2(0.115104,0.174815);float w=exp(-1.60*dot(d,d));
 change+=w*(vec3(-0.234802,-0.149292,-0.108268)+(.55*mid+.45*(base-vec3(0.521440,0.431919,0.485139)))*-0.340000+high*1.397317);total+=w;}
 // slope_forest_R
 {vec2 d=(q-vec2(0.807292,0.453704))/vec2(0.177083,0.152963);float w=exp(-1.60*dot(d,d));
 change+=w*(vec3(0.017539,0.031763,0.035744)+(.55*mid+.45*(base-vec3(0.340097,0.324520,0.366640)))*-0.122067+high*0.000000);total+=w;}
 // peninsula
 {vec2 d=(q-vec2(0.690104,0.574074))/vec2(0.154948,0.131111);float w=exp(-1.60*dot(d,d));
 change+=w*(vec3(0.218889,0.159160,0.138068)+(.55*mid+.45*(base-vec3(0.288647,0.299503,0.349686)))*2.271578+high*0.000000);total+=w;}
 // forest_L
 {vec2 d=(q-vec2(0.260417,0.592593))/vec2(0.177083,0.262222);float w=exp(-1.60*dot(d,d));
 change+=w*(vec3(0.059313,0.026061,0.038020)+(.55*mid+.45*(base-vec3(0.349282,0.321091,0.293253)))*0.340379+high*0.000000);total+=w;}
 // lake_near
 {vec2 d=(q-vec2(0.625000,0.833333))/vec2(0.177083,0.218519);float w=exp(-1.60*dot(d,d));
 change+=w*(vec3(0.111048,0.066914,0.043275)+(.55*mid+.45*(base-vec3(0.359894,0.359232,0.414086)))*0.377993+high*0.115911);total+=w;}
 // lake_far
 {vec2 d=(q-vec2(0.611979,0.657407))/vec2(0.110677,0.062000);float w=exp(-1.60*dot(d,d));
 change+=w*(vec3(0.102633,0.012900,-0.227771)+(.55*mid+.45*(base-vec3(0.471861,0.462216,0.566370)))*2.884100+high*0.000000);total+=w;}
 // fg_moss
 {vec2 d=(q-vec2(0.234375,0.870370))/vec2(0.177083,0.131111);float w=exp(-1.60*dot(d,d));
 change+=w*(vec3(0.114909,0.080657,0.067561)+(.55*mid+.45*(base-vec3(0.186731,0.176916,0.114729)))*0.937292+high*0.000000);total+=w;}
 return clamp(base-high*.72*needleCoverage+change/total*(.45+.55*clamp(.88/.88,0.,1.)),0.,1.);
}

vec4 fernSample(ivec2 node){
    if(any(lessThan(node,ivec2(0)))||any(greaterThanEqual(node,ivec2(420,192))))return vec4(0);
    int at=184*84*35+node.x+420*node.y,width=int(iChannelResolution[1].x);
    return texelFetch(iChannel1,ivec2(at%width,at/width+int(floor(.68*iChannelResolution[1].y))),0);
}
vec4 resolveFern(vec2 uv){
    float f=min(mod(iTime*48.,248.)*.5,123.);
    float truck=f<=62.?-.92*(1.-cos(f*3.14159265/62.)):-1.84+1.32*(1.-cos((f-62.)*3.14159265/61.));
    vec2 screen=vec2(uv.x,1.-uv.y)*vec2(1920,1080);
    vec2 canonical=vec2(960,464.4)+((screen-vec2(960.+1404.*truck/325.,464.4))*(7.16+.09*truck)-vec2(-truck,.035*truck)*1404.)/7.16;
    vec2 node=(canonical-vec2(-255,850))*.70-.5;
    if(any(lessThan(node,vec2(-5)))||any(greaterThan(node,vec2(425,197))))return vec4(0);
    ivec2 center=ivec2(floor(node+.5));vec4 sum=vec4(0);float total=0.;
    for(int y=-4;y<=4;y++)for(int x=-4;x<=4;x++){
        ivec2 at=center+ivec2(x,y);vec2 d=vec2(at)-node;
        float w=exp(-.29*dot(d,d));sum+=w*fernSample(at);total+=w;
    }
    return sum/total;
}

void mainImage(out vec4 color,in vec2 pixel){vec2 uv=pixel/iResolution.xy;float a=worldSample(uv,0.).a;
 vec3 c=finishValley(uv);float w=smoothstep(.24,.39,a)*(1.-smoothstep(.56,.70,a));
 c=mix(c,worldSample(uv,.22+log2(1.+clamp((a-.40)/.075,0.,2.))).rgb,w);
 c=mix(c,worldSample(uv,.78).rgb,1.-smoothstep(.025,.16,abs(a-.75)));vec4 fern=resolveFern(uv);color=vec4(c*(1.-fern.a)+fern.rgb,1.);}

#endif
