#!/bin/bash

awk '{print $2}' weights-Psi-reweight-MC-order10.xvg > weights_by_frame_MC-order10.dat
