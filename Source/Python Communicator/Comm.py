
import time
import serial
import os

# configure the serial connections (the parameters differs on the device you are connecting to)
ser = serial.Serial(
    port='/dev/ttyUSB1',
   baudrate=10000
)

def isInt(s):
    try: 
        int(s)
        return True
    except ValueError:
        return False

ser.isOpen()

print('Welcome to The Fourier Awakens CLI')



#loop for sending serial data - may need to make a function.
while 1:
    # get keyboard input
    print('Use the following commands to control the output:\n\ta - Choose the amplitude.\n\tc - Choose the number of Fourier Coefficients.')
    print('\tf - Choose the frequency.\n\tw - Choose the synthesised waveform.\n\te - Exit application.')
    command = raw_input(">> ")
    if(command == 'e'):
        ser.close()
        os.system('cls' if os.name == 'nt' else 'clear')
        break
    elif(command == 'a'):
        print('Set an amplitude for the DDS.')
        amp = raw_input("\n>> ")
        if(isInt(amp)):
            print(amp)
            ser.write(amp)
        else:
            print("Input was not an integer.")
        os.system('cls' if os.name == 'nt' else 'clear')
    elif(command == 'c'):
        print('Choose a number of coefficients (from 1-16):')
        coe = raw_input("\n>> ")
        if(isInt(coe)):
            print(coe)
            ser.write(coe)
        else:
            print("Input was not an integer.")
        os.system('cls' if os.name == 'nt' else 'clear')
    elif(command == 'f'):
        print('Set a frequency for the DDS.')
        freq = raw_input("\n>> ")
        if(isInt(freq)):
            print(freq)
            ser.write(freq)
        else:
            print("Input was not an integer.")
        os.system('cls' if os.name == 'nt' else 'clear')
    elif(command == 'w'):
        print('The following waveforms are available:\n\t1 - square\n\t2 - triangle\n\t3 - sawtooth\n\t4 - bonus')
        wav = raw_input("\n>> ")
        if(isInt(wav)):
            print(wav)
            ser.write(wav)
        else:
            print("Input was not an integer.")
        os.system('cls' if os.name == 'nt' else 'clear')
    else:
        # send the character to the device
        #ser.write(command)
        print('Command not valid.')
        os.system('cls' if os.name == 'nt' else 'clear')
        #For receiving stuff.
        #out = ''
        # let's wait one second before reading output (let's give device time to answer)
        #time.sleep(1)
        #while ser.inWaiting() > 0:
            #out += ser.read(1)

        #if out != '':
            #print(">>" + out)



