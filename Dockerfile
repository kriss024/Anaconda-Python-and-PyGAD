FROM continuumio/anaconda3:latest

LABEL maintainer="Krzysztof Bruszewski <krzysztof.bruszewski@gmail.com>"

# Installing packages for operating system
RUN apt update -y \
&& apt -y install graphviz

# Updating Anaconda packages
RUN conda update conda -y \
&& conda update anaconda -y \
&& conda update --all -y \
&& python -m pip install --upgrade pip

# Installing additional libraries
RUN pip install psycopg2-binary \
&& pip install pip install https://storage.googleapis.com/tensorflow/linux/cpu/tensorflow_cpu-2.6.0-cp38-cp38-manylinux2010_x86_64.whl \
&& pip install pygad \
&& pip install keras

RUN conda install -y -c conda-forge pydotplus \
&& conda install -y -c anaconda joblib

# Installing extensions for Jupyter Notebooks
RUN pip install jupyter_contrib_nbextensions \
&& jupyter contrib nbextension install --system \
&& pip install jupyter_nbextensions_configurator \
&& jupyter nbextensions_configurator enable --system \
&& jupyter nbextension enable hinterland/hinterland \
&& pip install yapf \
&& pip install nbconvert==5.6.1

# Creating a directory for Jupyter Notebooks
RUN mkdir -p /home/notebooks

# Setting working directory
WORKDIR /home/notebooks

# Jupyter listens port: 8888
EXPOSE 8888

# Run Jupytewr Notebook
CMD jupyter notebook --notebook-dir=/home/notebooks --ip='*' --port 8888 --no-browser --allow-root