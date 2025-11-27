# MPI Microbenchmarks

This repository contains a collection of MPI microbenchmarks designed to evaluate message-passing performance, including communication latency, bandwidth, neighbor exchange patterns, and communication–computation overlap.

The primary benchmark included is the **Non-blocking Overlap Benchmark (NOB)**, which measures the ability of an MPI stack and network hardware to overlap nonblocking communication with computation.

---

## Non-blocking Overlap Benchmark (NOB)

NOB quantifies how much communication can be hidden behind computation when using nonblocking MPI operations (`MPI_Isend`, `MPI_Irecv`, `MPI_Waitall`) in a 2D neighbor-exchange pattern.

The benchmark runs three phases:

1. **Pure communication**  
2. **Pure computation**  
3. **Communication + computation combined**

Using these timings, the benchmark computes the overlap ratio:

$$
\text{overlap} = 100 \times 
\frac{\max\left(0,\; \min\left(t_{\text{pure}} + t_{\text{comp}} - t_{\text{ovrl}},\; t_{\min}\right)\right)}
     {t_{\min}},
\quad
t_{\min} = \min\left(t_{\text{pure}},\; t_{\text{comp}}\right)
$$

Interpretation:

- **0%** → no overlap (communication and computation are serialized)  
- **100%** → full overlap (communication fully hidden behind compute)

---

## Features

- 2D Cartesian neighbor exchange: left, right, top, bottom
- Nonblocking communication: `MPI_Isend`, `MPI_Irecv`
- Flexible message sizes (1 MiB → 256 MiB)
- Calibrated compute workload to match communication time
- Reports:
  - pure communication time  
  - pure computation time  
  - combined time  
  - overlap percentage  
- Works with all major MPI implementations (Open MPI, MPICH, MVAPICH, Intel MPI)
- Detects:
  - NIC offload capabilities  
  - MPI asynchronous progress behavior  
  - UCX/OFI progress engines  

---

## Build nd Install
If directly cloning the git repository use:
`
$ ./autogen.sh
$ cd examples/
$ mpirun [ Runtime options] ./executable

## Example output:
`
Size (Bytes)       Communication(us)  Computation(us)   Overall(us)        Overlapping %
1048576            120.1              130.4             245.7              3.2
2097152            240.8              130.5             260.2              43.1
4194304            430.3              130.5             440.9              94.8

`

