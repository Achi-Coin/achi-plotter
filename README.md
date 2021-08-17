# achi-plotter (pipelined multi-threaded)

This is a new implementation of a achi plotter which is designed as a processing pipeline,
similar to how GPUs work, only the "cores" are normal software CPU threads.

As a result this plotter is able to fully max out any storage device's bandwidth,
simply by increasing the number of "cores", ie. threads.

## Usage

```
For <poolkey> and <farmerkey> see output of `achi keys show`.
<tmpdir> needs about 220 GiB space, it will handle about 25% of all writes. (Examples: './', '/mnt/tmp/')
<tmpdir2> needs about 110 GiB space and ideally is a RAM drive, it will handle about 75% of all writes.
Combined (tmpdir + tmpdir2) peak disk usage is less than 256 GiB.
In case of <count> != 1, you may press Ctrl-C for graceful termination after current plot is finished or double Ctrl-c to terminate immediatelly\

Usage:
  achi_plot [OPTION...]

  -n, --count arg      Number of plots to create (default = 1, -1 = infinite)
  -r, --threads arg    Number of threads (default = 4)
  -u, --buckets arg    Number of buckets (default = 256)
  -v, --buckets3 arg   Number of buckets for phase 3+4 (default = buckets)
  -t, --tmpdir arg     Temporary directory, needs ~220 GiB (default = $PWD)
  -2, --tmpdir2 arg    Temporary directory 2, needs ~110 GiB [RAM] (default = <tmpdir>)
  -d, --finaldir arg   Final directory (default = <tmpdir>)
  -p, --poolkey arg    Pool Public Key (48 bytes)
  -f, --farmerkey arg  Farmer Public Key (48 bytes)
  -G, --tmptoggle      Alternate tmpdir/tmpdir2 (default = false)
      --help           Print help
```

Make sure to crank up `<threads>` if you have plenty of cores, the default is 4.
Depending on the phase more threads will be launched, the setting is just a multiplier.

RAM usage depends on `<threads>` and `<buckets>`.
With the new default of 256 buckets it's about 0.5 GB per thread at most.

### RAM disk setup on Linux
`sudo mount -t tmpfs -o size=110G tmpfs /mnt/ram/`

Note: 128 GiB System RAM minimum required for RAM disk.

## How to Support

https://github.com/madMAx43v3r/chia-plotter

## How to Verify

To make sure the plots are valid you can use the `ProofOfSpace` tool from [achipos](https://github.com/Achi-Coin/achipos):

```bash
git clone https://github.com/Achi-Coin/achipos.git
cd achipos && mkdir build && cd build && cmake .. && make -j8
./ProofOfSpace check -f plot-k32-???.plot [num_iterations]
```

## Dependencies

- cmake (>=3.14)
- libsodium-dev

## Install
---
### Ubuntu 20.04
```bash
sudo apt install -y libsodium-dev cmake g++ git
# Checkout the source and install
git clone https://github.com/Achi-Coin/achi-plotter.git 
cd achi-plotter

git submodule update --init
./make_devel.sh
./build/achi_plot --help
```

The binaries will end up in `build/`, you can copy them elsewhere freely (on the same machine, or similar OS).

```
If a maximum open file limit error occurs (as default OS setting is 256, which is too low for default bucket size of `256`), run this before starting the plotter
```
ulimit -n 3000
```
This file limit change will only affect the current session.

