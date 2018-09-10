BUILD_PATH = "${PWD}/target/thumbv7em-none-eabihf/release"
TARGET = "${BUILD_PATH}/blinky"
OBJCOPY = "arm-none-eabi-objcopy"
OBJDUMP = "arm-none-eabi-objdump"

.PHONY: all
all: ${TARGET}.bin ${TARGET}.hex ${TARGET}.lst

.PHONY: clean
clean:
	xargo clean

${TARGET}:
	xargo build --release

${TARGET}.bin: ${TARGET}
	${OBJCOPY} -O binary -S $< $@

${TARGET}.hex: ${TARGET}
	${OBJCOPY} -O ihex -S $< $@

${TARGET}.lst: ${TARGET}
	${OBJDUMP} -d $< > $@

.PHONY: flash
flash: ${TARGET}.hex
	sudo openocd -d0 \
		-f board/st_nucleo_f4.cfg \
		-c "program $<" \
		-c "reset run" \
		-c "shutdown"
