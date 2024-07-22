#!/bin/bash
rm -rf clusterDir
git clone -b App_Kube_cluster https://github.com/amgad96/Full_React_App.git clusterDir
cd clusterDir
sudo kubectl apply -f DB-PersistentVol.yaml
sudo kubectl apply -f MongoDB-DS.yaml
sudo kubectl apply -f Backend-DS.yaml
sudo kubectl apply -f Frontend-DS.yaml
cd ..
rm -rf clusterDir
