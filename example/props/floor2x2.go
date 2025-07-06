components {
  id: "floor0"
  component: "/example/props/floor.model"
  position {
    x: -2.0
    z: 2.0
  }
}
components {
  id: "floor1"
  component: "/example/props/floor.model"
  position {
    x: 2.0
    z: 2.0
  }
}
components {
  id: "floor2"
  component: "/example/props/floor.model"
  position {
    x: -2.0
    z: -2.0
  }
}
components {
  id: "floor3"
  component: "/example/props/floor.model"
  position {
    x: 2.0
    z: -2.0
  }
}
embedded_components {
  id: "collisionobject"
  type: "collisionobject"
  data: "type: COLLISION_OBJECT_TYPE_STATIC\n"
  "mass: 0.0\n"
  "friction: 0.1\n"
  "restitution: 0.5\n"
  "group: \"floor\"\n"
  "mask: \"player\"\n"
  "embedded_collision_shape {\n"
  "  shapes {\n"
  "    shape_type: TYPE_BOX\n"
  "    position {\n"
  "      y: -0.5\n"
  "    }\n"
  "    rotation {\n"
  "    }\n"
  "    index: 0\n"
  "    count: 3\n"
  "    id: \"floor\"\n"
  "  }\n"
  "  data: 4.0\n"
  "  data: 0.5\n"
  "  data: 4.0\n"
  "}\n"
  ""
}
