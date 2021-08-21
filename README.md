# dvsd_4bit_binary_counter

# Openlane 

## Step 1: setting OpenLane and SKY130_PDK 

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
       
       
you can install all SKY130  

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


## Step 4: Running openlane

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


## Step 5: magic layout generate 

![T-10](https://user-images.githubusercontent.com/88899069/130263482-1cae4239-1f15-4370-bf50-48deca90239a.png)


```sh
bash-4:$

magic dvsd_4bit_binary_counter.mag

```
![Screenshot from 2021-08-20 21-52-38](https://user-images.githubusercontent.com/88899069/130264092-1211e24a-ab7b-4c75-9b3a-03df196cc362.png)
![magic_layout(1)](https://user-images.githubusercontent.com/88899069/130264133-08094a4a-d5e8-41d0-8463-b5da329835de.png)

## Step 5: Tikcon converter into spice

![tkcon_converter_spice_counter](https://user-images.githubusercontent.com/88899069/130330700-cdf8cd20-ac43-4816-b07c-da367d758bce.png)

