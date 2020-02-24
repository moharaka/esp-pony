use "lib:info"

class LED
	var _state: U32
	let _pin: U32

	new create( pin:U32, initial: U32 ) =>
		_pin = pin
		_state = initial
		//components/soc/include/hal/gpio_types.h (GPIO_MODE_OUTPUT) and 
		//components/soc/esp32/include/soc/gpio_caps.h (GPIO_MODE_DEF_OUTPUT)
		//components/bt/host/bluedroid/external/sbc/decoder/include/oi_stddefs.h (BIT1=0x00000002)
		@gpio_pad_select_gpio[None](_pin)
		@gpio_set_direction[None](_pin, U32(2))

	fun ref toggle() =>
		if _state == 1 then
			_state = 0
		else
			_state = 1
		end
		@gpio_set_level[I32](_pin, _state)

actor Main
	let led: LED

	new create(env: Env) =>
		// CONFIG_BLINK_GPIO == 5 : esp-idf/examples/get-started/blink/build/include/sdkconfig.h
		led = LED(5, 0)
		let loopDelay:U32 = 100
		var counter = U32(1)
		repeat
			led.toggle()
			@vTaskDelay[None](loopDelay)
			counter = counter + 1
			until counter > 10 end

