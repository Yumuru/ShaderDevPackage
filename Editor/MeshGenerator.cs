using System.Linq;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
#if UNITY_EDITOR
using UnityEditor;

public class MeshGenerator : EditorWindow {
	[MenuItem("Editor/MeshGenerator")]
	static void Open() {
		GetWindow<MeshGenerator>("Generator");
	}

	//string path_name;

	Mesh referenceMesh;
	int N;

	void OnGUI() {
		//path_name = EditorGUILayout.TextField("Path_Name", path_name);
		N = EditorGUILayout.IntField("Num", N);
		if (GUILayout.Button("Generate Triangle Polygons")) {
			GenerateTrianglePolygons(); }
		referenceMesh = (Mesh) EditorGUILayout.ObjectField("Reference Mesh", referenceMesh, typeof(Mesh), false);
		if (GUILayout.Button("Mesh N Copy")) {
			MeshNCopy(); }
	}

  void GenerateTrianglePolygons() {
    var vertices = new List<Vector3>();
    var uv = new List<Vector4>();
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
		string directory;
		if (referenceMesh != null) {
			var assetPath = AssetDatabase.GetAssetPath(referenceMesh).Split('/');
			directory = assetPath.Take(assetPath.Length-1)
				.Aggregate((s1, s2) => s1 + "/" + s2);
		} else {
			directory = "Assets";
		}
    string path = string.Format("{0}/{1}Polygons.asset", directory, N);
    AssetDatabase.CreateAsset(mesh, path);
    AssetDatabase.SaveAssets();
  }

	void MeshNCopy() {
		var vertices = new List<Vector3>();
		var uv = new List<Vector4>();
		var uv2 = new List<Vector4>();
		var uv3 = new List<Vector4>();
		var uv4 = new List<Vector4>();
		var triangles = new List<int>();
		var normals = new List<Vector3>();
		var tangents = new List<Vector4>();
		var colors = new List<Color>();
		for (int i = 0; i < N; i++) {
			vertices.AddRange(referenceMesh.vertices);
			uv.AddRange(referenceMesh.uv.Select(v => new Vector4(v.x, v.y, i, 0)));
			uv2.AddRange(referenceMesh.uv2.Select(v => new Vector4(v.x, v.y, 0, 0)));
			uv3.AddRange(referenceMesh.uv3.Select(v => new Vector4(v.x, v.y, 0, 0)));
			uv4.AddRange(referenceMesh.uv4.Select(v => new Vector4(v.x, v.y, 0, 0)));
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
		mesh.SetUVs(1, uv2);
		mesh.SetUVs(2, uv3);
		mesh.SetUVs(3, uv4);
		mesh.triangles = triangles.ToArray();
		mesh.normals = normals.ToArray();
		mesh.tangents = tangents.ToArray();
		mesh.colors = colors.ToArray();
		var assetPath = AssetDatabase.GetAssetPath(referenceMesh).Split('/');
		var directory = assetPath.Take(assetPath.Length-1)
			.Aggregate((s1, s2) => s1 + "/" + s2);
		string path = string.Format("{0}/{1}x{2}.asset", directory, referenceMesh.name, N);
		AssetDatabase.CreateAsset(mesh, path);
		AssetDatabase.SaveAssets();
	}
}
#endif
