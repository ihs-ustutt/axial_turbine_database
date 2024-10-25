#!/bin/bash

# Check if Python is installed
if ! command -v python3 &>/dev/null; then
    echo "Python3 is not installed. Please install Python3 and try again."
    exit 1
fi

# Check if Jupyter is installed globally
if command -v jupyter &>/dev/null; then
    echo "Jupyter is already installed globally."
    INSTALL_JUPYTER=false
else
    echo "Jupyter is not installed globally. It will be installed in the virtual environment."
    INSTALL_JUPYTER=true
fi

# Create a virtual environment
VENV_DIR="env_databse_axial_turbine"
if [ ! -d "$VENV_DIR" ]; then
    echo "Creating a virtual environment..."
    python3 -m venv "$VENV_DIR"
else
    echo "Virtual environment '$VENV_DIR' already exists."
fi

# Activate the virtual environment
source "$VENV_DIR/bin/activate"

# Install Jupyter only if it's not globally available
if [ "$INSTALL_JUPYTER" = true ]; then
    echo "Installing Jupyter in the virtual environment..."
    pip install jupyter
else
    echo "Skipping Jupyter installation since it is available globally."
fi

# Install numpy, matplotlib, and ipykernel
echo "Installing numpy, matplotlib, and ipykernel in the virtual environment..."
pip install numpy matplotlib ipykernel

# Add the virtual environment as a Jupyter kernel
KERNEL_NAME="myenv_kernel"
echo "Adding the virtual environment as a Jupyter kernel..."
python -m ipykernel install --user --name="$KERNEL_NAME" --display-name "axial_turbine"

echo "Setup complete. To start using, activate the virtual environment with:"
echo "source $VENV_DIR/bin/activate"
echo "Then, you can launch Jupyter Notebook with:"
echo "jupyter notebook"

# Deactivate the environment at the end
deactivate

