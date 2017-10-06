#!/usr/bin/env groovy

println "hello!"

def format = /\d+[.]\d+[.]\d+/

assert "1111.2222.3331" ==~ format
