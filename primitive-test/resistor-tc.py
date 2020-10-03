import matplotlib.pyplot as plt
import numpy as np
import pickle

import SpiceInterface

# resimulate = True
resimulate = False

temps = [_ for _ in range(-40, 120, 10)]

if resimulate:

    # read the generated netlist.
    netlist_path = 'resistor-tc.spice'
    signals = ['i(vr3)', 'i(vr4)', 'i(vr5)', 'i(vr6)', 'i(vr7)', 'i(vr8)']

    # create the object
    spice_interface_obj = SpiceInterface.SpiceInterface(netlist_path=netlist_path)


    # loop through each temperature point
    data = {}
    for signal in signals:
        data[signal] = []

    for temp in temps:

        # set the temparature
        spice_interface_obj.set_temp(temp)

        # run the simulation 
        spice_interface_obj.run_simulation()

        # add the calculated frequency to the array
        step_results = spice_interface_obj.get_signals(signals)

        # append the step values
        for signal in signals:
            data[signal] += step_results[signal]


    # save the data to file
    with open("results.pkl","wb") as file:
        pickle.dump(data, file)


# read the results from file
with open("results.pkl","rb") as file:
    data = pickle.load(file)

# plot the result
plt.plot(temps, [0.001*1.8 / _ for _ in data['i(vr3)']])
plt.plot(temps, [0.001*1.8 / _ for _ in data['i(vr4)']])
plt.plot(temps, [0.001*1.8 / _ for _ in data['i(vr5)']])
plt.plot(temps, [0.001*1.8 / _ for _ in data['i(vr6)']])
plt.plot(temps, [0.001*1.8 / _ for _ in data['i(vr7)']])
plt.plot(temps, [0.001*1.8 / _ for _ in data['i(vr8)']])
plt.legend(['po_0p35', 'po_0p69', 'po_1p41', 'po_2p85', 'po_5p73', 'po'])
plt.xlabel('Temperature ($^\circ C$')
plt.ylabel('Resistance ($k \Omega$)')
plt.title('Sky130 PO Resistors Over Temperature')
plt.show()


