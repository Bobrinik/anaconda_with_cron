#!/bin/bash
export SHELL=/bin/bash
sudo cron && opt/conda/bin/jupyter notebook --notebook-dir=/opt/notebooks --ip='*' --port=8888 --no-browser