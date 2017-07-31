# CarShader_Unity

**模拟真实车漆的shader例子**  

**版本： **  

Unity2017.1.0b6

**原shader来自：**  

[GitHub Pages](https://github.com/QianMo/Awesome-Unity-Shader).  

**项目运行：**  

![image](https://github.com/kurong00/CarShader_Unity/blob/master/deomoGIF.gif)







## 学习思路  

**1.	为什么利用MatCap实现Shader？**  
        采用Material Capture(材质捕获) 思想的Shader，可以用低廉的计算成本，就可以达到类似PBS（Physically Based Shading：一个基于物体表面材质属性的着色方法）非常真实的渲染效果。这是一种在移动平台实现次时代渲染效果的一种优秀解决方案。  
        
        
        
        
        
       
**2.	 MatCap实现Shader的思路**
        使用某特定材质球的贴图，作为当前材质的视图空间环境贴图（view-space environment map），来实现具有均匀表面着色的反射材质物体的显示。基于MatCap思想的Shader，可以无需提供任何光照，只需提供一张或多张合适的MatCap贴图作为光照结果的指导即可。不像一般的Shader，需要在Shader代码中进行漫长的演算，基于MatCap思想的Shader相当于MatCap贴图已经把光照结果应该是怎样赋给Shader，因此从效率来说是非常有利。  
   
   
   
   
**3.	MatCap的局限性**  
        因为从某种意义上来说，基于MatCap的Shader，就是某种固定光照条件下，从某个特定方向，特定角度的光照表现结果。正是因为是选择的固定的MatCap贴图，得到相对固定的整体光照表现，若单单仅使用MatCap，就仅适用于摄像机不调整角度的情形，并不适合摄像机会频繁旋转，调节角度的情形。但我们可以在某些Shader中，用MatCap配合与光照交互的其他属性，如将MatCap结合一个作为光照反射的颜色指导的Reflection Cube Map，就有了与光照之间的交互表现。这样，就可以适当弥补MatCap太过单一整体光照表现的短板。
        
        
        
