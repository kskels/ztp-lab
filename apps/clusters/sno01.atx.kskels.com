apiVersion: app.k8s.io/v1beta1
kind: Application
metadata:
  name: cluster-sno01-atx-kskels-com
  namespace: ztp-clusters
spec:
  componentKinds:
  - group: apps.open-cluster-management.io
    kind: Subscription
  descriptor: {}
  selector:
    matchExpressions:
      - key: app
        operator: In
        values: 
          - cluster-sno01-atx-kskels-com
---
apiVersion: apps.open-cluster-management.io/v1
kind: Subscription
metadata:
  annotations:
    apps.open-cluster-management.io/git-branch: main
    apps.open-cluster-management.io/git-path: clusters/sno01.atx.kskels.com
    apps.open-cluster-management.io/reconcile-option: merge
  labels:
    app: cluster-sno01-telco-ocp-run
  name: cluster-sno01-tor-subscription-1
  namespace: ztp-clusters
spec:
  channel: ztp-clusters/ztp-repository
  placement:
    placementRef:
      kind: PlacementRule
      name: local-cluster
