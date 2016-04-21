import time
import serial

# configure the serial connections (the parameters differs on the device you are connecting to)
ser = serial.Serial(
    port='/dev/ttyUSB1',
   baudrate=10000
)

ser.isOpen()

print('Welcome to The Fourier Awakens CLI')
print('Enter your commands below.\nInsert "exit" to leave the application.')
print('The following waveforms are available:\n\tWaveform 1\n\tWaveform 2\n\tWaveform 3\n\tWaveform 4')
print('Enter your commands below.\nInsert "exit" to leave the application.')


#loop for sending serial data - may need to make a function.
while 1:
    # get keyboard input
    command = input(">> ")
    if command == 'exit':
        ser.close()
        break
    else:
        # send the character to the device
        ser.write(command)
        print(command)

        #For receiving stuff.
        #out = ''
        # let's wait one second before reading output (let's give device time to answer)
        #time.sleep(1)
        #while ser.inWaiting() > 0:
            #out += ser.read(1)

        #if out != '':
            #print(">>" + out)
