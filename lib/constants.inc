; Regions
MEM_EWRAM    = 0x02000000
MEM_IWRAM    = 0x03000000
MEM_IO       = 0x04000000
MEM_PALETTE  = 0x05000000
MEM_VRAM     = 0x06000000
MEM_OAM      = 0x07000000
MEM_GAMEPAK0 = 0x08000000
MEM_GAMEPAK1 = 0x0A000000
MEM_GAMEPAK2 = 0x0C000000
MEM_SRAM     = 0x0E000000

; Registers
REG_DISPCNT  = 0x00000000
REG_DISPSTAT = 0x00000004
REG_BG0CNT   = 0x00000008
REG_DMA0SAD  = 0x000000B0
REG_DMA0DAD  = 0x000000B4
REG_DMA0CNT  = 0x000000B8
REG_IE       = 0x00000200
REG_IF       = 0x00000202
REG_IME      = 0x00000208

; DISPSTAT masks
STAT_VBLANK_FLG = 1 shl 0
STAT_HBLANK_FLG = 1 shl 1
STAT_VBLANK_IRQ = 1 shl 3
STAT_HBLANK_IRQ = 1 shl 4

; IRQ masks
IRQ_VBLANK = 1 shl 0
IRQ_HBLANK = 1 shl 1

; CPSR flag masks
FLAG_N = 1 shl 31
FLAG_Z = 1 shl 30
FLAG_C = 1 shl 29
FLAG_V = 1 shl 28

; CPSR mode masks
MODE_USR = 0x10
MODE_FIQ = 0x11
MODE_IRQ = 0x12
MODE_SVC = 0x13
MODE_ABT = 0x17
MODE_SYS = 0x1F
