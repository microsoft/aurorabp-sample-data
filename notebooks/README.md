# Using Sample Notebooks

## Environment Setup

To install the pre-configured python environment using the [conda](https://docs.conda.io/en/latest/) environment manager, you must first install either [Miniconda](https://docs.conda.io/en/latest/miniconda.html) or [Anaconda](https://www.anaconda.com/).

From the command line, create a new conda environment using the provided [conda-lock](https://github.com/conda-incubator/conda-lock) file specific to your platform, named `conda-{platform}.lock`. The conda-lock file contains the exact versions of all dependencies used to test this code. If you're unsure of your platform, run the following command and note the value listed after "platform:":

```bash
conda info
```

Specifically, the command to run for each supported platform are shown below:

```bash
# Create environment on x64 Linux.
conda create --name aurorabp --file conda-linux-64.lock

# Create environment on x64 Mac.
conda create --name aurorabp --file conda-osx-64.lock

# Create environment on ARM-based Mac.
conda create --name aurorabp --file conda-osx-arm64.lock

# Create environment on x64 Windows.
conda create --name aurorabp --file conda-win-64.lock
```

Alternatively, if you're using a different platform, or have trouble installing using the conda-lock file, as described above, you can install the latest versions of all dependencies using the `environment.yml` file:

```bash
conda env create --name aurorabp --file environment.yml
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

## Notebooks

The following Jupyter notebook files are provided to give examples of data import, plotting, and prediction:

| Example | File | Description |
|:-------------------- |:-------------------- |:-------------------- |
| Data Plotting Example | `data_plotting_example.ipynb` | This example of sample data manipulation includes binning feature data into intervals and plotting histograms as well as feature comparisons. |
| Waveform Example | `waveform_example.ipynb` | Load sample measurement data, set up filters, and plot waveforms.  |
| Prediction Example | `prediction_example.ipynb` | Example BP prediction from sample feature data. This notebook also demonstrates the correct setup of participant-stratified cross-validation. |
