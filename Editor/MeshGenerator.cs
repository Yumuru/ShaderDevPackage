using System.Linq;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
#if UNITY_EDITOR
using UnityEditor;

public class MeshGenerator : EditorWindow {
	[MenuItem("Generator/Quad")]
	static void Open() {
		GetWindow<MeshGenerator>("Generator");
	}

	//string path_name;
	int resolution = 16;

	Mesh referenceMesh;
	int N;

	void OnGUI() {
		//path_name = EditorGUILayout.TextField("Path_Name", path_name);
		resolution = EditorGUILayout.IntField("Resolution", resolution);
		if (GUILayout.Button("Generate Quad")) {
			GenerateQuad(); }
		N = EditorGUILayout.IntField("Num", N);
		referenceMesh = (Mesh) EditorGUILayout.ObjectField("Reference Mesh", referenceMesh, typeof(Mesh), false);
		if (GUILayout.Button("Mesh N Copy")) {
			MeshNCopy(); }
	}

	void GenerateQuad() {
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
		mesh.vertices = vertices.ToArray();
		mesh.triangles = triangles.ToArray();
		mesh.uv = uvs.ToArray();
    string path = string.Format("Assets/{0}x{0}.asset", resolution.ToString());
		AssetDatabase.CreateAsset(mesh, path);
		AssetDatabase.SaveAssets();
	}

	void MeshNCopy() {
		var vertices = new List<Vector3>();
		var uv = new List<Vector3>();
		var triangles = new List<int>();
		var normals = new List<Vector3>();
		var tangents = new List<Vector4>();
		var colors = new List<Color>();
		for (int i = 0; i < N; i++) {
			vertices.AddRange(referenceMesh.vertices);
			uv.AddRange(referenceMesh.uv.Select(v => new Vector3(v.x, v.y, i)));
			triangles.AddRange(referenceMesh.triangles
				.Select(index => index + i * referenceMesh.vertexCount));
			normals.AddRange(referenceMesh.normals);
			tangents.AddRange(referenceMesh.tangents);
			colors.AddRange(referenceMesh.colors);
		}
		var mesh = new Mesh();
		mesh.indexFormat = UnityEngine.Rendering.IndexFormat.UInt32;
		mesh.vertices = vertices.ToArray();
		mesh.SetUVs(0, uv);
		mesh.triangles = triangles.ToArray();
		mesh.normals = normals.ToArray();
		mesh.tangents = tangents.ToArray();
		mesh.colors = colors.ToArray();
		string path = string.Format("Assets/{0}x{1}.asset", referenceMesh.name, N);
		AssetDatabase.CreateAsset(mesh, path);
		AssetDatabase.SaveAssets();
	}
}
#endif
