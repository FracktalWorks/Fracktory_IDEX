# Fracktory_IDEX

Step-by-step instructions to set up the build environment for Cura on Windows:

1. Install Python 3.10.4 or higher:
* Download the latest version of Python from the official website: https://www.python.org/downloads/
* Run the installer and make sure to check the box "Add Python to PATH"
* After installation, open a new command prompt and check that Python is installed by running the command python --version
2. Install venv (Python):
* Open a command prompt and run the command python -m venv venv
* Activate the virtual environment by running .\venv\Scripts\activate on Windows
3. Install SIP (Python) 6.5.1:
* Run pip install sip==6.5.1
4. Install CMake 3.23 or higher:
* Download the latest version of CMake from the official website: https://cmake.org/download/
* Run the installer and select "Add CMake to the system PATH" option
5. Install Ninja 1.10 or higher:
* Download the latest version of Ninja from the official website: https://github.com/ninja-build/ninja/releases
* Extract the ninja.exe file to a directory in the system PATH
6. Install Conan 1.56.0:
* Download the latest version of Conan from the official website: https://docs.conan.io/en/latest/installation.html
* Run the installer and follow the instructions
7. Install Visual Studio with MSVC 2022 or higher:
* Download the latest version of Visual Studio from the official website: https://visualstudio.microsoft.com/downloads/
* Run the installer and select the "Desktop development with C++" workload
8. Configure the environment variables:
* Add the following directories to the system PATH variable:
  * C:\Python310\
  * C:\Program Files\CMake\bin\
  * C:\Program Files\Conan\bin\
  * C:\Program Files (x86)\Microsoft Visual Studio\2022\Community\MSBuild\Current\Bin\
* Set the following environment variables:
  * LIB=C:\Program Files (x86)\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.30.30705\lib\onecore\x64\
  * INCLUDE=C:\Program Files (x86)\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.30.30705\include\
    * C:\Program Files (x86)\Windows Kits\10\Include\10.0.19041.0\ucrt
    * C:\Program Files (x86)\Windows Kits\10\Include\10.0.19041.0\shared
    * C:\Program Files (x86)\Windows Kits\10\Include\10.0.19041.0\um
    * C:\Program Files (x86)\Windows Kits\10\Include\10.0.19041.0\winrt
    * C:\Program Files (x86)\Windows Kits\10\Include\10.0.19041.0\cppwinrt
