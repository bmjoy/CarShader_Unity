using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CameraAnimator : MonoBehaviour {

    [SerializeField] private GameObject target;//Camera要面向的物件
    [SerializeField] private float speed;//相机环绕移动的速度
    private Vector3 cameraPosition;//相机要移动的位置
    private float number;
    private float radius;//移动的半径
    public bool isBegin=false;

    private void Start()
    {
        //绕x和z轴移动，而y轴不会改变
        cameraPosition.y = transform.position.y;

        //计算当前摄影机和目标物体的半径
        radius = Vector3.Distance(target.transform.position, transform.position);
    }

    private void Update()
    {
        if (isBegin)
        {
            number += Time.deltaTime * speed * 0.1f;
            //计算并定新的x和y軸位置
            //负数是顺时针旋转，正数是逆时针旋转
            cameraPosition.x = radius * Mathf.Cos(-number);
            cameraPosition.z = radius * Mathf.Sin(-number);
            transform.position = cameraPosition;
            transform.LookAt(target.transform.position);
        }
    }
}
