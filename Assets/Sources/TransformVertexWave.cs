using UnityEngine;
using System.Collections;

public class TransformVertexWave : MonoBehaviour {

	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {

        gameObject.renderer.material.SetFloat("_WaveParam", Time.time);
	}
}
