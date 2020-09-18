using System.Linq;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
#if UNITY_EDITOR
using UnityEditor;

public class MeshGenerator : EditorWindow {
	[MenuItem("Editor/QuadGenerator")]
	static void Open() {
		GetWindow<MeshGenerator>("Generator");
	}

	//string path_name;

	Mesh referenceMesh;
	int N;

	void OnGUI() {
		//path_name = EditorGUILayout.TextField("Path_Name", path_name);
		if (GUILayout.Button("Generate Triangle Polygons")) {
			GenerateTrianglePolygons(); }
		N = EditorGUILayout.IntField("Num", N);
		referenceMesh = (Mesh) EditorGUILayout.ObjectField("Reference Mesh", referenceMesh, typeof(Mesh), false);
		if (GUILayout.Button("Mesh N Copy")) {
			MeshNCopy(); }
	}

  void GenerateTrianglePolygons() {
    var vertices = new List<Vector3>();
    var uv = new List<Vector3>();
    var triangles = new List<int>();
    for (int i = 0; i < N; i++) {
      vertices.Add(new Vector3(0, 0, 0));
      vertices.Add(new Vector3(0, 0, 1));
      vertices.Add(new Vector3(1, 0, 0));
      triangles.Add(3 * i + 0);
      triangles.Add(3 * i + 1);
      triangles.Add(3 * i + 2);
      uv.Add(new Vector3(0, 0, i));
      uv.Add(new Vector3(0, 0, i));
      uv.Add(new Vector3(0, 0, i));
    }
    var mesh = new Mesh();
    mesh.indexFormat = UnityEngine.Rendering.IndexFormat.UInt32;
		mesh.vertices = vertices.ToArray();
		mesh.SetUVs(0, uv);
		mesh.triangles = triangles.ToArray();
    string path = string.Format("Assets/{0}Polygons.asset", N);
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
