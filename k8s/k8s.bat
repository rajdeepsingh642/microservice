#kubectl delete -f deployment.yaml
#kubectl delete -f service.yaml
#kubectl apply -f deployment.yaml
#kubectl apply -f service.yaml
#kubectl create configmap promtail-config --from-file=promtail-config.yml
#kubectl apply -f promtail-deployment.yaml
#kubectl get all

kubectl delete -f promtail-deployment.yaml
kubectl apply -f promtail-deployment.yaml
kubectl delete -f observability.yaml
kubectl apply -f observability.yaml
kubectl get all -n observability