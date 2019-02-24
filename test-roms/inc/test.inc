; Basic functions for testing

macro TestInit {
  ; Setup red color at palette 0 color 0 (0x5000000)
  mov r0, 0x1F
  mov r1, 5
  lsl r1, r1, 24
  strh r0, [r1]

  ; Setup BG0CNT (0x4000008)
  mov r0, 0
  mov r1, 1
  lsl r1, 26
  add r1, 8
  strh r0, [r1]

  ; Setup DISPCNT (0x4000000)
  mov r0, 1
  lsl r0, 8
  sub r1, 8
  strh r0, [r1]
}

macro TestSucceded {
  ; Setup green color (0x5000000)
  mov r0, 0x1F
  lsl r0, r0, 5
  mov r1, 5
  lsl r1, r1, 24
  strh r0, [r1]
}