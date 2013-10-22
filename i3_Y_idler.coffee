include("ThumbWheel.coffee") 

tolarance = 0.1
beltguide_hight = 2
belt_width = 6

moving_gap = 0.5

bearing_inner_r = 1.5
bearing_outer_r = 5
bearing_width = 4

bar_rad = 4

pullywall_thickness = 1
pullyrad = 14
pully_r2 = pullyrad + beltguide_hight
pully_widthi = belt_width + moving_gap 
pully_widtho = pully_widthi + (pullywall_thickness * 2) 

thumbwheel_standoff = 7

pully_opening = new Cylinder(
  {
    r: bearing_outer_r - 1.25
    h: pully_widtho + 2
    center: true
  })

bearing = new Cylinder(
  {
    r: bearing_outer_r
    h: bearing_width
    center: true
  }).subtract new Cylinder(
    {
      r: bearing_inner_r
      h: bearing_width
      center: true
    }).color([0.5,0.5,0.55])
bearingS = new Cylinder(
  {
    r: bearing_outer_r + tolarance
    h: bearing_width + tolarance * 2
    center: false
  }).translate([0,0, - bearing_width / 2])
  
  
pully = new Cylinder(
  {
    r: pully_r2
    h: pully_widtho
    $fn:128
    center: true
  }).subtract(new Cylinder(
  {
    r: pully_r2
    h: pully_widthi
    $fn:128
    center: true
  })).union(new Cylinder(
  {
    r: pullyrad
    h: pully_widthi
    $fn:128
    center: true
  })).subtract([bearingS,bearing,pully_opening])
pully.color([0.5,0.1,0.1])


#sidea
pully2a = new Cylinder( #outercore
  {
    r: pullyrad
    h: pully_widthi
    $fn:128
    center: true
  }).union(new Cylinder( #belt guide wall
  {
    r: pully_r2
    h: pullywall_thickness
    $fn:128
    center: [true, true, - ((pully_widthi / 2) + (pullywall_thickness / 2))]
  })).translate([0,0,pullywall_thickness / 2]).subtract([bearingS,bearing,pully_opening])
pully2a.color([0.5,0.1,0.1])

#sideb
pully2b = new Cylinder(
  {
    r: pullyrad - 2
    h: pully_widthi - 1.5
    $fn:128
    #center: true
  })

pully2b.union(new Cylinder(
  {
    r: pully_r2
    h: pullywall_thickness
    $fn:128
    #center: [true, true, (pully_widthi - 2.5) / 2]
  })).rotate([180,0,0]).translate([0,0,1 + (7.5 / 2)])
pully2b.subtract([bearingS,bearing,pully_opening])
pully2b.color([0.5,0.1,0.1])

pully2S = new Cylinder(
  {
    r: pullyrad - 2 + tolarance
    h: pully_widthi - 1.5
    $fn:128
    #center: true
  }).translate([0,0,-0.5])

pully2a.subtract(pully2S)


part1_width_i = pully_widtho + moving_gap 
part1_width_o = 6 + part1_width_i
part1_len = 38
part1_height = 12
part1_rad = part1_height / 2


p1sa_r = pullyrad + beltguide_hight + (moving_gap * 2)

torsionbolt = new Cylinder(
  {
    r: 3
    h: 2.5
    $fn: 6
  }).rotate([0,0,90])
torsionbolt.union(new Cylinder(
  {
    r: 1.5
    h: 25
  })).color([0,0,0])
torsionbolt.rotate([-90, 0, 0]).translate([0,p1sa_r-0.3,part1_rad])

pullyshaft = new Cylinder(
  {
    r: bearing_inner_r 
    h: part1_width_o + 6
    center: true
  })
pully.subtract(pullyshaft)
pullyshaft.rotate([0,90,0]).translate([0, 0, part1_height / 2]) 


bar1 = new Cylinder({r:bar_rad, h: 100, center:true})
bar1.rotate([0,90,0]).translate([0,0,17])
bar2 = new Cylinder({r:bar_rad, h: 100, center:true})
bar2.rotate([0,90,0]).translate([0,0,38])
bar1.color([0.3,0.3,0.35])
bar2.color([0.3,0.3,0.35])

part1a = new Cylinder(
  {
    r: part1_rad
    h: part1_width_o
    center: true
  }).rotate([0,90,0]).translate([0, 0, part1_rad])

part1a.union(new Cube(
  {
    size: [part1_width_o, part1_len - part1_rad, part1_height]
    center: [true, false, false]
  }))

part1b = new Cube(
  {
    size: [part1_width_o, 5, part1_height]
    center: [true, false, false]
  }).translate([0,p1sa_r,0])



part1Sa = new Cylinder(
  {
    r: p1sa_r
    h: part1_width_i
    center: true
  }).rotate([0,90,0]).translate([0, 0, part1_rad])
  
p1sb_len = part1_len - part1_rad - p1sa_r
part1Sb = new Cube(
  {
    size: [part1_width_i, p1sb_len, part1_height]
    center: [true, false, false]
  }).translate([0, part1_len - part1_rad - p1sb_len, 0])

part1Sc = new Cylinder(
  {
    r: bar_rad
    h: part1_width_o
    center: true
  }).rotate([0,90,0]).translate([0, 0, bar_rad])
part1Sc.union(new Cube(
  {
    size: [part1_width_o, p1sb_len - bar_rad, bar_rad * 2]
    center: [true, false, false]
  })).translate([0,part1_len - (p1sb_len + 1), part1_rad + 2])

part1Sd = new Cube(
  {
    size: [part1_width_i + moving_gap, p1sb_len, part1_height]
    center: [true, false, false]
  }).translate([0, part1_len - part1_rad - p1sb_len, 0])
  
part1 = part1a.subtract(part1Sb)
part1.union([part1a, part1b])
part1.subtract([pullyshaft, part1Sa, part1Sc, torsionbolt])
part1.color([0.1,0.1,0.5])


part2 = new Cube(
  {
    size: [part1_width_o,thumbwheel_standoff + bar_rad + 2,36]
    center: [true, false, false]
  }).translate([0,-2,10])
part2.color([0.1,0.5,0.1])

thumbwheel = new ThumbWheel(
  {
    total_radius:16
    knobbles_radius:4
    knobbles_num:8
  })

pully.rotate([0,90,0])
pully.translate([0,-22,26 + part1_rad])
part1.translate([0,-22,26])
torsionbolt.translate([0,-22,26])

part2.subtract([part1, torsionbolt, bar1, bar2])
part1.subtract(part1Sd)
part1.translate([0,0,-moving_gap])
part2.subtract(part1)
thumbwheel.rotate([-90,0,0])
thumbwheel.translate([0,thumbwheel_standoff + bar_rad,26 + part1_rad])

pully.translate([0,-22,-26 + part1_rad])
pully.rotate([0,-90,0])
pully.translate([-15,15, pully_widtho / 2])


pully2a.translate([20,-25,pully_widtho / 2 - pullywall_thickness / 2])
pully2b.rotate([180,0,0])
pully2b.translate([-20,-25,pully_widtho / 2 +  pullywall_thickness / 2])


part1.translate([0,0,+moving_gap])
part1.translate([0,22,-26])
part2.translate([0,2,-10])
part2.rotate([-90,0,0])
part1.translate([part1_width_o,0,0])
part2.translate([-part1_width_o,0,thumbwheel_standoff + bar_rad + 2])

thumbwheel.translate([0,-thumbwheel_standoff - bar_rad,- 26 - part1_rad])
thumbwheel.rotate([90,0,0])
thumbwheel.translate([0,-55,0])


assembly.add(part1)
#assembly.add(torsionbolt)
#assembly.add(bar1)
#assembly.add(bar2)
assembly.add(part2)
#assembly.add(pully)
#assembly.add(bearingS)
#assembly.add(bearing)
assembly.add(pully2a)
assembly.add(pully2b)
assembly.add(thumbwheel)


