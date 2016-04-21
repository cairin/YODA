
import time
#import serial

# configure the serial connections (the parameters differs on the device you are connecting to)
#ser = serial.Serial(
#    port='/dev/ttyUSB1',
#   baudrate=10000
#)

#ser.isOpen()

print('Welcome to The Fourier Awakens CLI')
print('Use the following commands to control the output:\n\ta - Choose the amplitude.\n\tc - Choose the number of Fourier Coefficients.')
print('\tf - Choose the frequency.\n\tw - Choose the synthesised waveform.\n\te - Exit application.')


#loop for sending serial data - may need to make a function.
while 1:
    # get keyboard input
    command = input(">> ")
    if(command == 'e'):
#        ser.close()
        break
    elif(command == 'a'):
        print('Set an amplitude for the DDS.')
        amp = input("\n>> ")
        if(isInt(amp)):
            print(amp)
#            ser.write(amp)
        else:
            print("Input was not an integer.")
    elif(command == 'c'):
        print('Choose a number of coefficients (from 1-16):')
        coe = input("\n>> ")
        if(isInt(coe)):
            print(coe)
#            ser.write(coe)
        else:
            print("Input was not an integer.")
    elif(command == 'f'):
        print('Set a frequency for the DDS.')
        freq = input("\n>> ")
        if(isInt(freq)):
            print(freq)
#            ser.write(freq)
        else:
            print("Input was not an integer.")
    elif(command == 'w'):
        print('The following waveforms are available:\n\t1 - square\n\t2 - triangle\n\t3 - sawtooth\n\t4 - bonus')
        wav = input("\n>> ")
        if(isInt(wav)):
            print(wav)
#            ser.write(wav)
        else:
            print("Input was not an integer.")
    else:
        # send the character to the device
        #ser.write(command)
        print('Command not valid.')

        #For receiving stuff.
        #out = ''
        # let's wait one second before reading output (let's give device time to answer)
        #time.sleep(1)
        #while ser.inWaiting() > 0:
            #out += ser.read(1)

        #if out != '':
            #print(">>" + out)


def isInt(s):
    try: 
        int(s)
        return True
    except ValueError:
        return False
