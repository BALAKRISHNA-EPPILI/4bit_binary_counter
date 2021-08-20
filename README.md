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
Now lets test a design which is already present in `openlane/designs` type 

```sh
bash-4:$ ./flow.tcl -design dvsd_cmp -interactive 
```

```sh
bash-4:$

./flow.tcl -design dvsd_cmp -tag <wher you tag this file name>

> which shall display the "successful" message. 

```

## Step 5: magic layout generate 


```sh
bash-4:$

magic <file name>

```
