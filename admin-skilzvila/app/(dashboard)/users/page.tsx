"use client";

import { useEffect, useState } from "react";
import {
  getFirestore,
  collection,
  getDocs,
  query,
  orderBy,
} from "firebase/firestore";

type User = {
  id: string;
  name: string;
  email: string;
  phNumber: string;
  userType: string;
  kycType: string;
};

export default function UsersPage() {
  const [users, setUsers] = useState<User[]>([]);
  const [loading, setLoading] = useState(true);

  const db = getFirestore();

  useEffect(() => {
    const fetchUsers = async () => {
      try {
        const q = query(collection(db, "users"), orderBy("createdAt", "desc"));
        const snapshot = await getDocs(q);

        const list: User[] = snapshot.docs.map((doc) => ({
          id: doc.id,
          ...(doc.data() as Omit<User, "id">),
        }));

        setUsers(list);
      } catch (error) {
        console.error("Failed to fetch users:", error);
      } finally {
        setLoading(false);
      }
    };

    fetchUsers();
  }, [db]);

  /* ---------------- STATES ---------------- */

  if (loading) {
    return (
      <div>
        <h1 className="text-2xl font-semibold mb-6">Users</h1>
        <div className="bg-white rounded-2xl shadow p-6 animate-pulse">
          <div className="h-4 bg-gray-200 rounded w-1/3 mb-4" />
          <div className="space-y-3">
            {Array.from({ length: 5 }).map((_, i) => (
              <div key={i} className="h-10 bg-gray-100 rounded" />
            ))}
          </div>
        </div>
      </div>
    );
  }

  if (!users.length) {
    return <p className="text-gray-500">No users found.</p>;
  }

  /* ---------------- UI ---------------- */

  return (
    <div>
      {/* HEADER */}
      <div className="flex items-center justify-between mb-6">
        <div>
          <h1 className="text-2xl font-semibold">Users</h1>
          <p className="text-sm text-gray-500">Total users: {users.length}</p>
        </div>

        {/* SEARCH (UI only) */}
        <input
          type="text"
          placeholder="Search by email or phone..."
          className="border rounded-lg px-4 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-indigo-400"
        />
      </div>

      {/* TABLE CARD */}
      <div className="overflow-x-auto bg-white rounded-2xl shadow">
        <table className="min-w-full text-sm">
          <thead className="bg-gray-50 text-gray-600 text-left">
            <tr>
              <th className="px-6 py-4">User</th>
              <th className="px-6 py-4">Phone</th>
              <th className="px-6 py-4">User Type</th>
              <th className="px-6 py-4">KYC</th>
            </tr>
          </thead>

          <tbody className="divide-y">
            {users.map((user) => (
              <tr key={user.id} className="hover:bg-gray-50 transition">
                {/* USER */}
                <td className="px-6 py-4">
                  <div className="flex items-center gap-3">
                    <div className="h-10 w-10 rounded-full bg-indigo-100 text-indigo-700 flex items-center justify-center font-semibold">
                      {user.name?.charAt(0) || "U"}
                    </div>
                    <div>
                      <p className="font-medium">
                        {user.name || "Unnamed User"}
                      </p>
                      <p className="text-xs text-gray-500">{user.email}</p>
                    </div>
                  </div>
                </td>

                {/* PHONE */}
                <td className="px-6 py-4">{user.phNumber || "-"}</td>

                {/* USER TYPE */}
                <td className="px-6 py-4">
                  <span
                    className={`px-3 py-1 rounded-full text-xs font-medium ${
                      user.userType === "admin"
                        ? "bg-purple-100 text-purple-700"
                        : user.userType === "mentor"
                        ? "bg-blue-100 text-blue-700"
                        : "bg-green-100 text-green-700"
                    }`}
                  >
                    {user.userType}
                  </span>
                </td>

                {/* KYC */}
                <td className="px-6 py-4">
                  <span
                    className={`px-3 py-1 rounded-full text-xs font-medium ${
                      user.kycType === "verified"
                        ? "bg-green-100 text-green-700"
                        : user.kycType === "pending"
                        ? "bg-yellow-100 text-yellow-700"
                        : "bg-red-100 text-red-700"
                    }`}
                  >
                    {user.kycType || "none"}
                  </span>
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </div>
  );
}
