library(overseer)


models <- Overseer$new()

#pull in the model file here
models$add_model_file("capparelli.cpp")
models$add_model_file("stockmann.cpp")

models