; Basic functions for testing

include 'utility.inc'

macro TestInit {
      ; Setup red color
      mov     r0, 0x1F
      imm32t  r1, 0x5000000
      strh    r0, [r1]

      ; Setup DISPCNT
      mov     r0, 1
      lsl     r0, 8
      imm32t  r1, 0x4000000
      strh    r0, [r1]

      ; Setup BG0CNT
      mov     r0, 0
      add     r1, 8
      strh    r0, [r1]

      ; Reset status register
      mov     r7, 0
}

macro TestPassed {
      ; Setup green color
      mov     r0, 0x1F
      lsl     r0, 5
      imm32t  r1, 0x5000000
      strh    r0, [r1]
}

macro TestFailed status {
      ; Set status register
      mov     r7, status
      bl      test_loop
}

macro TestLoop {
      ; Loop indefinitely
test_loop:
      b       test_loop
}