# 4bit binary counter(dvsd_4bit_binary_counter) RTL2GDS flow

# Table of Contents

- [OPENLANE tool](#OPENLANE-tool)
- [OpenLane ](#OpenLane)
- [OpenLane design stages](#OpenLane-design-stages)
- [Installation process](#installation-process)
	- [ Setting OpenLane and SKY130_PDK](#Setting-OpenLane-and-SKY130_PDK)
- [Test](#Test)
- [Opening OpenLane in Docker](#Opening-OpenLane-in-Docker)
- [Pre-layout Simulation](#Pre-layout-Simulation)
- [Running openlane](#Running-openlane)
- [Magic layout generate](#Magic-layout-generate)
- 	- [tkcon converter into spice](#tkcon-converter-into-spice)
- [Post-layout simulation](#Post-layout-simulation)
- [Key points to Remember](#key-points-to-remember)
- [Area of improvement](#area-of-improvement)
- [References](#references)
- [Acknowledgement](#acknowledgement)
- [Author](#author)

# OPENLANE tool

## OpenLane 

OpenLane is an automated RTL to GDSII flow based on several components including OpenROAD, Yosys, Magic, Netgen, Fault and custom methodology scripts for design exploration and optimization.
For more information check [here](https://openlane.readthedocs.io/)

![openlane flow 1](https://user-images.githubusercontent.com/80625515/130246106-18f73ccc-e8e1-4061-a1b0-8c14bdf711f1.png)

### OpenLane design stagest

1. Synthesis
	- `yosys` - Performs RTL synthesis
	- `abc` - Performs technology mapping
	- `OpenSTA` - Performs static timing analysis on the resulting netlist to generate timing reports
2. Floorplan and PDN
	- `init_fp` - Defines the core area for the macro as well as the rows (used for placement) and the tracks (used for routing)
	- `ioplacer` - Places the macro input and output ports
	- `pdn` - Generates the power distribution network
	- `tapcell` - Inserts welltap and decap cells in the floorplan
3. Placement
	- `RePLace` - Performs global placement
	- `Resizer` - Performs optional optimizations on the design
	- `OpenDP` - Perfroms detailed placement to legalize the globally placed components
4. CTS
	- `TritonCTS` - Synthesizes the clock distribution network (the clock tree)
5. Routing
	- `FastRoute` - Performs global routing to generate a guide file for the detailed router
	- `CU-GR` - Another option for performing global routing.
	- `TritonRoute` - Performs detailed routing
	- `SPEF-Extractor` - Performs SPEF extraction
6. GDSII Generation
	- `Magic` - Streams out the final GDSII layout file from the routed def
	- `Klayout` - Streams out the final GDSII layout file from the routed def as a back-up
7. Checks
	- `Magic` - Performs DRC Checks & Antenna Checks
	- `Klayout` - Performs DRC Checks
	- `Netgen` - Performs LVS Checks
	- `CVC` - Performs Circuit Validity Checks


### Step 1: Installation process

#### Preferred Prerequisites

- Preferred Ubuntu OS)
- Docker 19.03.12+
- GNU Make
- Python 3.6+ with PIP
- Click, Pyyaml: `pip3 install pyyaml click`


##  Setting OpenLane and SKY130_PDK 

The first go to openlane_working_dir path
Then OpenLane by running 
![Screenshot from 2021-08-20 20-54-00](https://user-images.githubusercontent.com/88899069/130256346-8270b98d-4561-4295-9b43-6272249ff6c9.png)


```sh
git clone https://github.com/efabless/openlane.git openlane
cd openlane 
make openlane 
make pdk

```
 

Installation defult pdk directory 

```sh

export PDK_ROOT=<absolute path to where skywater-pdk and open_pdks will reside>
```       
Add this configuration variable

```sh
export STD_CELL_LIBRARY=<Library name>
```       
where the library names is one of:

- sky130_fd_sc_hd
- sky130_fd_sc_hs
- sky130_fd_sc_ms
- sky130_fd_sc_ls
- sky130_fd_sc_hdll

    * You can install the PDK manually, outside of the Makefile, by following the instructions provided [here][30].
    * Refer to [this][24] for more details on OpenLane-compatible PDK structures.
    
       
you can install all Sky130 SCLs 

```sh

make full-pdk
```       
 

## Step 2: Test

On successful completion of previous step, then make test that verifies that the flow and the pdk were properly installed

```sh

make test
```

Then show  display the "successful" message. 

Then follow the next step 

## Step 3: The Docker install

If docker is installed, if you can see the docker version 19.* and above then docker is present and go to next step else install docker manually

```sh
docker --version

```

you can installed docker file following this link 

https://docs.docker.com/engine/install/


## Step 4: Pre-layout Simulation

This is how you can simulate your design.
![simulation command](https://user-images.githubusercontent.com/88899069/130675440-4dff335a-5561-4192-be3c-f06e92111a1c.png)


Pre-layout simulation waveform
![pre-layout counter](https://user-images.githubusercontent.com/88899069/130675943-2c3108c5-ab0c-4a85-ae04-2bae657b57e6.png)


## Step 5: Running openlane

Once you are sure the docker is present, you have to make mount of the current files in **openlane**

```sh
make mount

```
![T-1](https://user-images.githubusercontent.com/88899069/130261505-b1a52cc4-6ef8-4abc-a47c-bae0914f3a41.png)


Now lets test a design which is already present in `openlane/designs` type 


```sh
bash-4:$

./flow.tcl -design dvsd_4bit_binary_counter -tag binary_counter_bala

```
![T-2](https://user-images.githubusercontent.com/88899069/130261987-11f954b3-f085-4842-8d7e-52ee59ab250e.png)


which shall display the "successful" message.
![success_T-9](https://user-images.githubusercontent.com/88899069/130263259-84a11fb6-2600-4975-99de-1f99d78cb3e0.png)


## Step 6: magic layout generate 

![T-10](https://user-images.githubusercontent.com/88899069/130263482-1cae4239-1f15-4370-bf50-48deca90239a.png)


```sh
bash-4:$

magic dvsd_4bit_binary_counter.mag

```
![Screenshot from 2021-08-20 21-52-38](https://user-images.githubusercontent.com/88899069/130264092-1211e24a-ab7b-4c75-9b3a-03df196cc362.png)
![magic_layout(1)](https://user-images.githubusercontent.com/88899069/130264133-08094a4a-d5e8-41d0-8463-b5da329835de.png)

## tkcon converter into spice

![tkcon_converter_spice_counter](https://user-images.githubusercontent.com/88899069/130330700-cdf8cd20-ac43-4816-b07c-da367d758bce.png)

## Step 7: Post-layout simulation 
command for post-layout simulation 
![post-layout simulation command waveform](https://user-images.githubusercontent.com/88899069/130676619-274a5a5d-1ede-40de-abf7-63303c719678.png)


Post-layout simulation waveform
![post-layout waveform](https://user-images.githubusercontent.com/88899069/130677382-eb4df15d-34ed-4dbb-984f-487a9364a0a5.png)


## Key points to Remember

- Keep the top module name and design name always same, else errors would come in the design.

## Area of improvement

- To perform spice simulation of the final GDS layout.

## References

- [GitLab/OpenLane workshop](https://gitlab.com/gab13c/openlane-workshop)
- [The OpenROAD Project/OpenLane](https://github.com/The-OpenROAD-Project/OpenLane)
- Ahmed Ghazy and Mohamed Shalan, "OpenLane: The Open-Source Digital ASIC Implementation Flow", Article No.21, Workshop on Open-Source EDA Technology (WOSET), 2020. [Paper](https://github.com/woset-workshop/woset-workshop.github.io/blob/master/PDFs/2020/a21.pdf)
- [YOUTUBE/OpenLane Overview](https://www.youtube.com/watch?v=d0hPdkYg5QI)
- [GitHUB/openlane_build_script](https://github.com/nickson-jose/openlane_build_script)
- [GitLab/mythcore_synth](https://github.com/deepsita/mythcore_synth)

## Acknowledgement

- [Kunal Ghosh](https://github.com/kunalg123), Founder, VSD Corp. Pvt. Ltd

## Author

- [Balakrishna Eppili](https://github.com/BALAKRISHNA-EPPILI), Bachelor of Technology in Electronics & Communication Engineering,Dronacharya Group of Institutions,Greater Noida, U.P.

