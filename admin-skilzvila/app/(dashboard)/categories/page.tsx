"use client";

import { useEffect, useState } from "react";
import {
  getFirestore,
  collection,
  addDoc,
  getDocs,
  updateDoc,
  deleteDoc,
  doc,
  serverTimestamp,
  query,
  orderBy,
  Timestamp,
} from "firebase/firestore";
import {
  getStorage,
  ref,
  uploadBytes,
  getDownloadURL,
  deleteObject,
} from "firebase/storage";
import {
  FiSearch,
  FiPlus,
  FiEdit2,
  FiTrash2,
  FiX,
  FiImage,
} from "react-icons/fi";
import { MdCategory } from "react-icons/md";

type Category = {
  id: string;
  name: string;
  imageUrl: string;
  createdAt?: Timestamp;
};

export default function CategoriesPage() {
  const db = getFirestore();
  const storage = getStorage();

  /* ---------------- STATE ---------------- */
  const [categories, setCategories] = useState<Category[]>([]);
  const [loadingList, setLoadingList] = useState(true);
  const [saving, setSaving] = useState(false);
  const [deletingId, setDeletingId] = useState<string | null>(null);

  const [name, setName] = useState("");
  const [image, setImage] = useState<File | null>(null);
  const [preview, setPreview] = useState<string | null>(null);
  const [editing, setEditing] = useState<Category | null>(null);

  const [search, setSearch] = useState("");
  const [showDeleteConfirm, setShowDeleteConfirm] = useState<string | null>(
    null
  );

  /* ---------------- FETCH ---------------- */

  const fetchCategories = async () => {
    setLoadingList(true);
    const q = query(collection(db, "categories"), orderBy("createdAt", "desc"));
    const snap = await getDocs(q);

    const list: Category[] = snap.docs.map((d) => ({
      id: d.id,
      ...d.data(),
    })) as Category[];
    setCategories(list);
    setLoadingList(false);
  };

  useEffect(() => {
    fetchCategories();
  }, []);

  /* ---------------- IMAGE PREVIEW ---------------- */

  const handleImage = (file: File | null) => {
    setImage(file);
    if (file) {
      setPreview(URL.createObjectURL(file));
    } else {
      setPreview(null);
    }
  };

  /* ---------------- ADD / UPDATE ---------------- */

  const handleSave = async () => {
    if (!name.trim()) {
      alert("Category name is required");
      return;
    }

    setSaving(true);

    try {
      let imageUrl = editing?.imageUrl || "";

      if (image) {
        const imgRef = ref(storage, `categories/${Date.now()}-${image.name}`);
        await uploadBytes(imgRef, image);
        imageUrl = await getDownloadURL(imgRef);
      }

      if (editing) {
        await updateDoc(doc(db, "categories", editing.id), {
          name,
          imageUrl,
          updatedAt: serverTimestamp(),
        });
      } else {
        await addDoc(collection(db, "categories"), {
          name,
          imageUrl,
          createdAt: serverTimestamp(),
          updatedAt: serverTimestamp(),
        });
      }

      resetForm();
      fetchCategories();
    } catch (err) {
      console.error(err);
      alert("Failed to save category");
    } finally {
      setSaving(false);
    }
  };

  const resetForm = () => {
    setName("");
    setImage(null);
    setPreview(null);
    setEditing(null);
  };

  /* ---------------- DELETE ---------------- */

  const handleDelete = async (categoryId: string, imageUrl?: string) => {
    if (!window.confirm("Are you sure you want to delete this category?"))
      return;

    setDeletingId(categoryId);
    try {
      // Delete from Firestore
      await deleteDoc(doc(db, "categories", categoryId));

      // Delete image from Storage if exists
      if (imageUrl) {
        try {
          const imageRef = ref(storage, imageUrl);
          await deleteObject(imageRef);
        } catch (storageErr) {
          console.warn("Could not delete image, continuing...", storageErr);
        }
      }

      // Update local state
      setCategories((prev) => prev.filter((cat) => cat.id !== categoryId));
    } catch (err) {
      console.error("Error deleting category:", err);
      alert("Failed to delete category");
    } finally {
      setDeletingId(null);
      setShowDeleteConfirm(null);
    }
  };

  /* ---------------- EDIT ---------------- */

  const startEdit = (cat: Category) => {
    setEditing(cat);
    setName(cat.name);
    setPreview(cat.imageUrl);
    window.scrollTo({ top: 0, behavior: "smooth" });
  };

  /* ---------------- FILTER ---------------- */

  const filtered = categories.filter((c) =>
    c.name.toLowerCase().includes(search.toLowerCase())
  );

  /* ---------------- UI ---------------- */

  return (
    <div className="min-h-screen bg-gradient-to-br from-gray-50 to-blue-50 p-4 md:p-6">
      {/* HEADER */}
      <div className="mb-8">
        <div className="flex flex-col md:flex-row md:items-center justify-between gap-4 mb-6">
          <div className="flex items-center gap-3">
            <div className="p-3 bg-white rounded-xl shadow-sm">
              <MdCategory className="text-2xl text-indigo-600" />
            </div>
            <div>
              <h1 className="text-3xl font-bold text-gray-800">Categories</h1>
              <p className="text-gray-600">
                Create & manage platform categories
              </p>
            </div>
          </div>

          <div className="relative w-full md:w-auto">
            <div className="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
              <FiSearch className="text-gray-400" />
            </div>
            <input
              type="text"
              placeholder="Search categories..."
              value={search}
              onChange={(e) => setSearch(e.target.value)}
              className="pl-10 pr-4 py-3 w-full md:w-80 border border-gray-300 rounded-xl bg-white focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500 shadow-sm transition-all duration-200"
            />
          </div>
        </div>

        {/* ADD / EDIT CARD */}
        <div className="bg-white rounded-2xl shadow-lg p-6 mb-8 border border-gray-100">
          <div className="flex items-center justify-between mb-6">
            <h3 className="text-xl font-semibold text-gray-800 flex items-center gap-2">
              <FiPlus className={`${editing ? "hidden" : ""}`} />
              {editing ? (
                <span className="flex items-center gap-2">
                  <FiEdit2 /> Edit Category
                </span>
              ) : (
                "Add New Category"
              )}
            </h3>

            {editing && (
              <button
                onClick={resetForm}
                className="flex items-center gap-2 px-4 py-2 text-sm text-gray-600 hover:text-gray-800 hover:bg-gray-100 rounded-lg transition-colors"
              >
                <FiX /> Cancel Edit
              </button>
            )}
          </div>

          <div className="grid grid-cols-1 lg:grid-cols-12 gap-6 items-end">
            <div className="lg:col-span-4">
              <label className="block text-sm font-medium text-gray-700 mb-2">
                Category Name *
              </label>
              <input
                type="text"
                placeholder="e.g., Electronics, Fashion"
                value={name}
                onChange={(e) => setName(e.target.value)}
                className="w-full px-4 py-3 border border-gray-300 rounded-xl focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500 transition-all duration-200"
              />
            </div>

            <div className="lg:col-span-4">
              <label className="block text-sm font-medium text-gray-700 mb-2">
                Category Image
              </label>
              <div className="flex items-center gap-4">
                <label className="flex-1 cursor-pointer">
                  <div className="px-4 py-3 border-2 border-dashed border-gray-300 rounded-xl hover:border-indigo-400 hover:bg-indigo-50 transition-all duration-200 text-center">
                    <input
                      type="file"
                      accept="image/*"
                      onChange={(e) => handleImage(e.target.files?.[0] || null)}
                      className="hidden"
                    />
                    <span className="text-gray-600">
                      {image ? image.name : "Choose an image..."}
                    </span>
                  </div>
                </label>
              </div>
            </div>

            <div className="lg:col-span-2">
              <div className="h-24 w-24 rounded-xl overflow-hidden bg-gradient-to-br from-gray-50 to-gray-100 border-2 border-gray-200 flex items-center justify-center shadow-inner">
                {preview ? (
                  <img
                    src={preview}
                    alt="preview"
                    className="h-full w-full object-cover"
                  />
                ) : (
                  <div className="text-center p-4">
                    <FiImage className="text-gray-400 mx-auto mb-2" />
                    <span className="text-xs text-gray-500">Preview</span>
                  </div>
                )}
              </div>
            </div>

            <div className="lg:col-span-2">
              <button
                onClick={handleSave}
                disabled={saving}
                className="w-full px-6 py-3 bg-gradient-to-r from-indigo-600 to-purple-600 text-white rounded-xl hover:from-indigo-700 hover:to-purple-700 disabled:opacity-50 disabled:cursor-not-allowed font-medium shadow-md hover:shadow-lg transition-all duration-200 flex items-center justify-center gap-2"
              >
                {saving ? (
                  <>
                    <div className="w-4 h-4 border-2 border-white border-t-transparent rounded-full animate-spin"></div>
                    Saving...
                  </>
                ) : editing ? (
                  <>
                    <FiEdit2 /> Update
                  </>
                ) : (
                  <>
                    <FiPlus /> Add Category
                  </>
                )}
              </button>
            </div>
          </div>
        </div>
      </div>

      {/* CATEGORIES LIST */}
      <div className="bg-white rounded-2xl shadow-lg overflow-hidden border border-gray-100">
        <div className="px-6 py-4 border-b border-gray-100">
          <h3 className="text-lg font-semibold text-gray-800">
            All Categories ({filtered.length})
          </h3>
        </div>

        {loadingList ? (
          <div className="p-8">
            <div className="flex flex-col items-center justify-center py-12">
              <div className="w-12 h-12 border-4 border-indigo-200 border-t-indigo-600 rounded-full animate-spin mb-4"></div>
              <p className="text-gray-600">Loading categories...</p>
            </div>
          </div>
        ) : !filtered.length ? (
          <div className="p-8 text-center">
            <div className="max-w-md mx-auto py-12">
              <div className="w-20 h-20 mx-auto bg-gray-100 rounded-full flex items-center justify-center mb-6">
                <MdCategory className="text-3xl text-gray-400" />
              </div>
              <h4 className="text-xl font-medium text-gray-700 mb-2">
                No categories found
              </h4>
              <p className="text-gray-500 mb-6">
                {search
                  ? "Try a different search term"
                  : "Get started by adding your first category"}
              </p>
              {search && (
                <button
                  onClick={() => setSearch("")}
                  className="px-6 py-2 bg-gray-100 hover:bg-gray-200 rounded-lg text-gray-700 transition-colors"
                >
                  Clear Search
                </button>
              )}
            </div>
          </div>
        ) : (
          <div className="overflow-x-auto">
            <table className="min-w-full divide-y divide-gray-200">
              <thead className="bg-gray-50">
                <tr>
                  <th className="px-6 py-4 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                    Image
                  </th>
                  <th className="px-6 py-4 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                    Name
                  </th>
                  <th className="px-6 py-4 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                    Actions
                  </th>
                </tr>
              </thead>

              <tbody className="bg-white divide-y divide-gray-100">
                {filtered.map((cat) => (
                  <tr
                    key={cat.id}
                    className="hover:bg-blue-50/50 transition-colors duration-150"
                  >
                    <td className="px-6 py-4 whitespace-nowrap">
                      <div className="h-16 w-16 rounded-lg overflow-hidden border border-gray-200 shadow-sm">
                        {cat.imageUrl ? (
                          <img
                            src={cat.imageUrl}
                            alt={cat.name}
                            className="h-full w-full object-cover"
                          />
                        ) : (
                          <div className="h-full w-full bg-gradient-to-br from-gray-100 to-gray-200 flex items-center justify-center">
                            <FiImage className="text-gray-400" />
                          </div>
                        )}
                      </div>
                    </td>

                    <td className="px-6 py-4">
                      <div>
                        <span className="font-medium text-gray-900">
                          {cat.name}
                        </span>
                      </div>
                    </td>

                    <td className="px-6 py-4 whitespace-nowrap">
                      <div className="flex items-center gap-3">
                        <button
                          onClick={() => startEdit(cat)}
                          className="flex items-center gap-2 px-4 py-2 bg-indigo-50 text-indigo-700 hover:bg-indigo-100 rounded-lg transition-colors duration-200"
                          title="Edit category"
                        >
                          <FiEdit2 /> Edit
                        </button>

                        <button
                          onClick={() => handleDelete(cat.id, cat.imageUrl)}
                          disabled={deletingId === cat.id}
                          className="flex items-center gap-2 px-4 py-2 bg-red-50 text-red-700 hover:bg-red-100 rounded-lg transition-colors duration-200 disabled:opacity-50"
                          title="Delete category"
                        >
                          {deletingId === cat.id ? (
                            <>
                              <div className="w-4 h-4 border-2 border-red-700 border-t-transparent rounded-full animate-spin"></div>
                              Deleting...
                            </>
                          ) : (
                            <>
                              <FiTrash2 /> Delete
                            </>
                          )}
                        </button>
                      </div>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        )}

        {!loadingList && filtered.length > 0 && (
          <div className="px-6 py-4 border-t border-gray-100 bg-gray-50">
            <div className="flex items-center justify-between text-sm text-gray-600">
              <span>
                Showing <span className="font-semibold">{filtered.length}</span>{" "}
                of <span className="font-semibold">{categories.length}</span>{" "}
                categories
              </span>
              {search && (
                <button
                  onClick={() => setSearch("")}
                  className="text-indigo-600 hover:text-indigo-800 hover:underline"
                >
                  Clear search
                </button>
              )}
            </div>
          </div>
        )}
      </div>
    </div>
  );
}
