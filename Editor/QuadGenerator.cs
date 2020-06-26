using System.Collections;
using System.Collections.Generic;
using UnityEngine;
#if UNITY_EDITOR
using UnityEditor;

public class QuadGenerator : EditorWindow {
	[MenuItem("Generator/Quad")]
	static void Open() {
		GetWindow<QuadGenerator>("Generator");
	}

	//string path_name;
	int resolution = 16;
	float boundsSize = 1f;

	void OnGUI() {
		//path_name = EditorGUILayout.TextField("Path_Name", path_name);
		resolution = EditorGUILayout.IntField("Resolution", resolution);
		boundsSize = EditorGUILayout.FloatField("BoundsSize", boundsSize);
		if (GUILayout.Button("Generate")) {
			Generate(true);
		}
        if (GUILayout.Button("Generate Without Bounds")) {
            Generate(false);
        }
	}

	void Generate(bool containBounds) {
		var mesh = new Mesh();
		var delta = 1f / resolution;
		var vertices = new List<Vector3>();
		var triangles = new List<int>();
		var uvs = new List<Vector2>();
		for (int j = 0; j <= resolution; j++) {
			var y = (float) j / resolution;
			for (int i = 0; i <= resolution; i++) {
				var x = (float) i / resolution;
				vertices.Add(new Vector3(x-0.5f, y-0.5f, 0));
				uvs.Add(new Vector2(x, y));
				if (j == resolution || i == resolution) continue;
				var index = j * (resolution+1) + i;
				triangles.Add(index);
				triangles.Add(index+resolution+1);
				triangles.Add(index+1+resolution+1);
				triangles.Add(index);
				triangles.Add(index+1+resolution+1);
				triangles.Add(index+1);
			}
		}
    if (containBounds) {
      var boundsP = new Vector3[] {
        new Vector3(-boundsSize, -boundsSize, -boundsSize),
        new Vector3(-boundsSize, -boundsSize, boundsSize),
        new Vector3(-boundsSize, boundsSize, -boundsSize),
        new Vector3(-boundsSize, boundsSize, boundsSize),
        new Vector3(boundsSize, -boundsSize, -boundsSize),
        new Vector3(boundsSize, -boundsSize, boundsSize),
        new Vector3(boundsSize, boundsSize, -boundsSize),
        new Vector3(boundsSize, boundsSize, boundsSize),
      };
      foreach (var p in boundsP)
      for (int i = 0; i < 8; i++) {
        vertices.Add(p);
        uvs.Add(Vector2.zero);
      }
    }
		mesh.vertices = vertices.ToArray();
		mesh.triangles = triangles.ToArray();
		mesh.uv = uvs.ToArray();
    string path = null;
    if (containBounds) {
		  path = string.Format("Assets/{0}x{0}_b{1}.asset", resolution.ToString(), boundsSize.ToString());
    } else {
		  path = string.Format("Assets/{0}x{0}.asset", resolution.ToString());
    }
		AssetDatabase.CreateAsset(mesh, path);
		AssetDatabase.SaveAssets();
	}
}
#endif
