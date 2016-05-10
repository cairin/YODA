System Suggestions
------------------

You are in the fortunate position where your project has a very open-ended
market.  You could design an electronic keyboard, for instance...

You can also think about implementing an arbitrary-waveform generator: similar
to [link](http://www.tek.com/signal-generator/awg70000-arbitrary-waveform-generator).
Your current architecture is more suited to this option than the keyboard...



Paper Review
------------

Section I:
- [ ] Change "'template'" to "`template'"
- [ ] Paragraph 3: don't give the full reference in the text.  Simply say: "DDS was first proposed in 1971 by Tierney, et. al [3]".
- [ ] Equation 1: have a look at [link](http://www.mash.dept.shef.ac.uk/Resources/web-rcostheta-alphaetc.pdf)
- [ ] It might help you to analyse the DDS process:
  1. Integrate the frequency by means of first-order Euler to obtain phase.
  2. Pass the phase through a cosine function to obtain instantaneous amplitude.
  3. Multiply by the overall amplitude to obtain the output signal.

Section I-A:
- [ ] Figure 1: is "n" 24 or 48?  Rather draw your own block diagram that use an existing one that doesn't suit your needs.
- [ ] Don't call it a "parallel delta phase register".  Call it a "frequency word".
- [ ] You can remove figure 2.  It's easier to see it in terms of "integrate frequency to obtain phase".
- [ ] Change "'template'" to "`template'"
- [ ] Move the explanation of the DDS internals to section III.

Section II-A:
- [ ] The PC interface is great for the prototype, but no-one will buy such a product.  A keyboard is much easier to sell ;-)
- [ ] 32-bit phase and amplitude => 16 GiB per DDS.  Seems a bit excessive for a system that's meant to "approximate" the waveform. And good luck in finding a DAC that gives you a noise floor below about 22 bits...
- [ ] You can use a 32-bit frequency word: that's fine, but I'd strongly suggest truncating to a 24-bit amplitude, which implies a 26-bit phase word and therefore 192 MiB per DDS, which is much more reasonable.  For implementation on your Nexys 4, as you specify in section I, I'd suggest a 16-bit amplitude and 18-bit phase, which would imply a 512 kiB LUT.  You can then use symmetry and dual-port ROM to get that down to 64 kiB per DDS on average.
- [ ] You're using PWM.  At what resolution?  If you have 10-bit PWM, you can get away with 10-bit amplitude and 12-bit phase, which implies 40 kib per DDS (you can generate 10-bit wide memory modules on the FPGA).  If you want higher resolution, use a noise-shaper.
- [ ] 45000 DDS modules seem excessive when the keyboard player only has 10 fingers, and the audience can only hear the first 7 harmonics anyway...
- [ ] If you want to generate a very accurate single waveform, it's much easier to program the LUT with the waveform you want and play that back with the selected frequency word.  In that case you'll also use a proper DAC and not PWM.

Section III-A:
- [ ] I don't know what a "Mhz" is.  I think you might mean "MHz".
- [ ] Always put a space between the value and the unit.
- [ ] The S.I. unit of baud rate is "Baud", or "Bd", not "Hz".
- [ ] Never line-break between the value and the unit.  Use an "unbroken space".

Section III-B:
- [ ] As mentioned earlier, it's much more efficient to add a phase shift and calculate the cosine once.
- [ ] I like your "no spacial resources" for the Taylor series option ;-)  Must be a magical FPGA...
- [ ] If you pipeline the Taylor series you can get a sample every clock cycle.
  Your argument about "will limit the maximum frequency" is therefore invalid. one?
- [ ] Figure 4: draw the multiply and sum output to the right of the LUT. This will give a more clear image of the data-flow.

Section III-D:
- [ ] This section requires more detail regarding PWM generation.  Especially limitation is clock frequency and resolution. You can also add a section on noise-shaping: [link](http://sdrg.ee.uct.ac.za/Bootcamp/Resources/Practicals.pdf> section 4.1.2)

Section IV-A:
- [ ] I don't know why you would even consider a CPU implementation...  Remove this section.

Section IV-B:
- [ ] You can remove this section as well

Section IV-C:
- [ ] Slightly more useful, but I don't think DDS is well-suited for GPU, unless you simply want to calculate the waveform instead of providing output on a DAC...

Section IV-D:
- [ ] Typeset it as "$\mathrm{O}(\log(N))$".  "n" is generally a counter, whereas "N" represents the total.
- [ ] I'm not sure you need this section IV at all.  If you need space to present more results in the final paper, this is the section to remove.

Section V:
- [ ] Change "outputted" to "output"


----------
Reviewer 1
----------

- [ ] Figure 3 is too small to read comfortably, could be enlarged.
- [ ] Could have had more detail in the Detailed Design section
- [ ] Good comparison of different architectures
- [ ] Could have been more imaginative in conceptual design

Reviewer 2
----------

- Information presented well.
