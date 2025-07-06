components {
  id: "floor0"
  component: "/example/props/floor.model"
  position {
    x: -8.0
    z: 8.0
  }
}
components {
  id: "floor1"
  component: "/example/props/floor.model"
  position {
    x: -4.0
    z: 8.0
  }
}
components {
  id: "floor3"
  component: "/example/props/floor.model"
  position {
    x: -8.0
    z: 4.0
  }
}
components {
  id: "floor2"
  component: "/example/props/floor.model"
  position {
    z: 8.0
  }
}
components {
  id: "floor4"
  component: "/example/props/floor.model"
  position {
    x: -4.0
    z: 4.0
  }
}
components {
  id: "floor5"
  component: "/example/props/floor.model"
  position {
    z: 4.0
  }
}
components {
  id: "floor8"
  component: "/example/props/floor.model"
  position {
    x: -8.0
  }
}
components {
  id: "floor6"
  component: "/example/props/floor.model"
  position {
    x: -4.0
  }
}
components {
  id: "floor7"
  component: "/example/props/floor.model"
}
components {
  id: "floor"
  component: "/example/props/floor.model"
  position {
    x: 4.0
    z: 8.0
  }
}
components {
  id: "floor9"
  component: "/example/props/floor.model"
  position {
    x: 4.0
    z: 4.0
  }
}
components {
  id: "floor10"
  component: "/example/props/floor.model"
  position {
    x: 4.0
  }
}
components {
  id: "floor11"
  component: "/example/props/floor.model"
  position {
    x: 8.0
    z: 8.0
  }
}
components {
  id: "floor12"
  component: "/example/props/floor.model"
  position {
    x: 8.0
    z: 4.0
  }
}
components {
  id: "floor13"
  component: "/example/props/floor.model"
  position {
    x: 8.0
  }
}
components {
  id: "floor14"
  component: "/example/props/floor.model"
  position {
    x: -4.0
    z: -4.0
  }
}
components {
  id: "floor15"
  component: "/example/props/floor.model"
  position {
    z: -4.0
  }
}
components {
  id: "floor16"
  component: "/example/props/floor.model"
  position {
    x: -8.0
    z: -4.0
  }
}
components {
  id: "floor17"
  component: "/example/props/floor.model"
  position {
    x: 4.0
    z: -4.0
  }
}
components {
  id: "floor18"
  component: "/example/props/floor.model"
  position {
    x: 8.0
    z: -4.0
  }
}
components {
  id: "floor19"
  component: "/example/props/floor.model"
  position {
    x: -4.0
    z: -8.0
  }
}
components {
  id: "floor20"
  component: "/example/props/floor.model"
  position {
    z: -8.0
  }
}
components {
  id: "floor21"
  component: "/example/props/floor.model"
  position {
    x: -8.0
    z: -8.0
  }
}
components {
  id: "floor22"
  component: "/example/props/floor.model"
  position {
    x: 4.0
    z: -8.0
  }
}
components {
  id: "floor23"
  component: "/example/props/floor.model"
  position {
    x: 8.0
    z: -8.0
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
  "  data: 10.0\n"
  "  data: 0.5\n"
  "  data: 10.0\n"
  "}\n"
  ""
}
