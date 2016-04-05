# YODA
## Your Own Digital Accelerator
### EEE 4084 F Project

[100 Marks]

#### Hand-ins
- [] Part 1: Feature List
- [] Part 2: Conceptual Design
- [] Part 3: Final Paper
- [] Part 4: Conference Presentation

#### Part 1: Feature List [10 Marks]
1. Draw up a project feature list and prototype specification, and publish it on the Vula Blog. There is an example blog so that you can have a rough idea about what is required. This specification is what you plan to implement for the proof-of-concept prototype. The idea is to make it involved enough so that it is a worthy project, but easy enough so that you can implement it in the time provided. The course lecturer and TA will evaluate these and either ask you to add more features, or recommend that you remove some.

#### Part 2: Conceptual Design [30 Marks]
The first major task is to design your accelerator. This does not involve implementation, although you do need to do some implementation at the same time in order to meet the project time budget. Go wild. Assume that you have infinite resources. Assume that you have access to the PCIe interface of the PC. Assume that you have access to a huge development team. Etc. Etc. Etc.

1. Compile your design into an IEEE-style conference paper. At a real conference, this would be equivalent to the paper you submit for the first round of review. The page limit is 4 pages. Submit your paper to the Vula Assignment for the YODA Conceptual Design.
2. In the “introduction” section, introduce the topic and what it’s all about. Provide some discussion relating to why it would be a good idea to provide FPGA-based acceleration for the algorithm.
3. In the “overview” section, provide high-level block diagrams to explain how you plan to implement the design. Also include an overview of how your device should be used.
4. In the “detail design” section, provide detailed block diagrams, flow-charts and explanations of the inner workings of your product. Do not go down to gate-level (obviously), but it should be possible for a competent engineer to implement your system from the descriptions you give.
5. In the “conclusion” section, summarise your project and state that the prototype implementation is nearing completion and that the final paper should contain practical results.

#### Part 3: Final Paper [30 Marks]
The next task is to implement a prototype of your design on a real FPGA. This is a proof-of-concept prototype, not the final thing (as we have insufficient time and other resources for you to make a commercial version). Feel free to use online resources and open-source modules (and make sure you reference them in the paper). There are many websites that host these, such as http://opencores.org/, http://www.fpga4fun.com/, https://github.com/, etc. If you go to http://sdrg.ee.uct.ac.za/Bootcamp/ and follow the link to the resources, you’ll find modules for an RS-232 interface, as well as displaying colourful text on a VGA monitor. You will have to port the embedded RAM and ROM modules to Xilinx, but that is not too difficult.

1. Add new sections to your “Conceptual Design” paper to include measurements and results of this proof-of-principle prototype. Also implement the changes recommended by the “reviewer comments”. At a real conference, this would be
equivalent to the paper you submit for final publication. The page limit is 6 pages (in total, including the conceptual design sections). Submit your paper to the Vula Assignment for the final YODA paper.
2. Your implementation is not the same as what your design dictates. You might have, for instance, a PCIe interface in the design, but only an RS-232 interface in the prototype. The “methodology” section is used for specifying how your proof-of-concept prototype differs from the design, and how you plan to test final product features on said prototype.
3. In the “results” section, provide measurement results made with your prototype. Include as much detail as is practical. You can, for instance, implement a golden measure on the PC and compare the processing times. You can use logical arguments and information from the literature to extrapolate these results to what you would expect from the final commercial product.
4. In the “conclusion” section, summarise your project and results.

#### Part 4: Conference Presentation [30 Marks]
The YODA project concludes with a 15 minute power-point presentation during a mini-conference. This means that you have 13 minutes in which to present your work, so that 2 minutes can be used for questions and discussion. Believe it or not, this is the same time as you will have at a real conference. Some conferences are nice and give you a 20 minute slot, but this is not always the case. In order to give all the groups a chance to present, we will have to be very strict with time enforcement. Do not use more than one slide per minute (excluding the title slide).
