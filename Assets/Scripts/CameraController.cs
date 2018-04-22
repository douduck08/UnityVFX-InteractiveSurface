using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CameraController : MonoBehaviour {

	public float turnSpeed = 5.0f;
	public float moveSpeed = 10.0f;
	
	Vector3 m_preMousePosition;
	
	void Update () {
		transform.Translate (GetKeyInput () * moveSpeed * Time.deltaTime, Space.Self);
		if(Input.GetMouseButtonDown(0)) {
			m_preMousePosition = Input.mousePosition;
		}
		if (Input.GetMouseButton(0)) {
			Vector3 pos = Camera.main.ScreenToViewportPoint(Input.mousePosition - m_preMousePosition);
			transform.RotateAround(transform.position, transform.right, -pos.y * turnSpeed);
			transform.RotateAround(transform.position, Vector3.up, pos.x * turnSpeed);
		}
	}

	Vector3 GetKeyInput () {
        Vector3 p_Velocity = new Vector3();
        if (Input.GetKey (KeyCode.W)){
            p_Velocity += new Vector3(0, 0 , 1);
        }
        if (Input.GetKey (KeyCode.S)){
            p_Velocity += new Vector3(0, 0, -1);
        }
        if (Input.GetKey (KeyCode.A)){
            p_Velocity += new Vector3(-1, 0, 0);
        }
        if (Input.GetKey (KeyCode.D)){
            p_Velocity += new Vector3(1, 0, 0);
        }
        return p_Velocity;
    }
}
