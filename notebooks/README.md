# Using Sample Notebooks

## Environment Setup

To install the pre-configured python environment using the [conda](https://docs.conda.io/en/latest/) environment manager, you must first install either [Miniconda](https://docs.conda.io/en/latest/miniconda.html) or [Anaconda](https://www.anaconda.com/).

From the command line, create a new conda environment using the provided [conda-lock](https://github.com/conda-incubator/conda-lock) file specific to your platform, named `conda-{platform}.lock`. If you're unsure of your platform, run the following command and note the value listed after "platform:":

```bash
conda info
```

For example, to create a new environment called "aurorabp" on a 64-bit Windows computer, run the following command:

```bash
conda create --name aurorabp --file conda-win64.lock
```

Alternatively, if you're using an ARM-based Mac, the command would be:

```bash
conda create --name aurorabp --file conda-osx-arm64.lock
```

## Running Notebooks

First, you must activate the conda environment created during [Environment Setup](#environment-setup) by running the following command:

```bash
conda activate aurorabp
```

Next, start a Jupyter notebook server by running the following comamnd:

```bash
jupyter notebook
```