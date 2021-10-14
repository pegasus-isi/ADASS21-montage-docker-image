# ADASS21-montage-docker-image

This repository contains instructions on how to build and run the container environment
used in the ADASS21 demo, **Astronomical Image Processing at Scale With Pegasus
and Montage**.

The docker image contains the following:
- compiled Montage binaries
- Pegasus 5.0.1
- HTCondor 8.8
- Jupyter Notebooks
    - Montage+Pegasus workflow
    - Pegasus tutorials

## Usage

### Building the Image

```
docker image build -t adass21-montage .
```

### Running the Container

```
docker container run \
    --privileged \
    --rm \
    --name adass \
    -p 9999:8888 \
    adass21-montage
```

### Accessing the Jupyter Notebooks

1. In a browser window, navigate to `localhost:9999`. 
2. When prompted for a password, enter `scitech`.
3. In the file browser, navigate to `PegasusMontage/PegasusMontage.ipynb` to
    run the jupyter notebook.

