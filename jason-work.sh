docker build -t filebeat-dev .

kubectl apply -f .\jason-filebeat-kubernetes.yaml

kubectl delete pod -n kube-system -l k8s-app=filebeat --now --force

kubectl get pod -n kube-system -l k8s-app=filebeat
