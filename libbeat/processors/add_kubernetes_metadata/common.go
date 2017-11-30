package add_kubernetes_metadata

import (
	"encoding/json"

	corev1 "github.com/ericchiang/k8s/api/v1"

	"github.com/elastic/beats/libbeat/logp"
)

func GetPodMeta(pod *corev1.Pod) *Pod {
	bytes, err := json.Marshal(pod)
	if err != nil {
		logp.Warn("Unable to marshal %v", pod.String())
		return nil
	}

	po := &Pod{}
	err = json.Unmarshal(bytes, po)
	if err != nil {
		logp.Warn("Unable to marshal %v", pod.String())
		return nil
	}

	return po
}

func GetNamespaceMetadata(namespace *corev1.Namespace) *ObjectMeta {
	bytes, err := json.Marshal(namespace.Metadata)
	if err != nil {
		logp.Warn("Unable to marshal %v", namespace.String())
		return nil
	}

	meta := &ObjectMeta{}
	err = json.Unmarshal(bytes, meta)
	if err != nil {
		logp.Warn("Unable to marshal %v", namespace.String())
		return nil
	}

	return meta
}
