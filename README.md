# Data Explorer
A data explorer web-application built with Shiny.

## Installation
#### 1. RStudio
In RStudio install devtools with `install.packages("devtools")`
```
devtools::install_git("https://github.com/sergiumocanu/dataexplorer")
```
#### 2. Docker
Download and install Docker from [here](https://www.docker.com). 
In a terminal type the following:
```
docker pull sergiumocanu/dataexplorer:latest
````

## Running
#### 1. RStudio
```
dataexplorer::run_app()
```
#### 2. Docker
```
docker run --rm -p 30:30 --name dataexplorer sergiumocanu/dataexplorer:latest
```
In a browser, navigate to `localhost:30`

## Usage
1. Upload corresponding files (note location matters).
2. Inspect raw data in the Table 1 and Table 2 tabs.
3. Data visualizer and summary for both uploaded files in the third tab. Choose various features to explore.
4. Two-patient comparison for various lab tests in the last tab. Choose two different patients to compare lab results.

## Clean-up
#### 1. RStudio
Close browser, in RStudio press the `Esc` key on your keyboard.
#### 2. Docker
Close browser, in terminal press `Ctrl+C` (on Windows you may have to stop the app with `docker stop dataexplorer` or through the Docker Desktop GUI.)
