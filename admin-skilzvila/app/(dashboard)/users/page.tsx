"use client";

import { useEffect, useState } from "react";
import {
  getFirestore,
  collection,
  getDocs,
  query,
  orderBy,
  Timestamp,
} from "firebase/firestore";
import {
  FiSearch,
  FiUser,
  FiMail,
  FiPhone,
  FiCheckCircle,
  FiClock,
  FiXCircle,
  FiFilter,
  FiDownload,
} from "react-icons/fi";
import { MdAdminPanelSettings, MdOutlineSchool } from "react-icons/md";
import { HiOutlineUserGroup } from "react-icons/hi";

type User = {
  id: string;
  name: string;
  email: string;
  phNumber: string;
  userType: string;
  kycType: string;
  createdAt?: Timestamp;
};

export default function UsersPage() {
  const [users, setUsers] = useState<User[]>([]);
  const [filteredUsers, setFilteredUsers] = useState<User[]>([]);
  const [loading, setLoading] = useState(true);
  const [searchTerm, setSearchTerm] = useState("");
  const [selectedUserType, setSelectedUserType] = useState<string>("all");
  const [selectedKycType, setSelectedKycType] = useState<string>("all");

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
        setFilteredUsers(list);
      } catch (error) {
        console.error("Failed to fetch users:", error);
      } finally {
        setLoading(false);
      }
    };

    fetchUsers();
  }, [db]);

  // Apply filters and search
  useEffect(() => {
    let result = users;

    // Apply user type filter
    if (selectedUserType !== "all") {
      result = result.filter((user) => user.userType === selectedUserType);
    }

    // Apply KYC type filter
    if (selectedKycType !== "all") {
      result = result.filter((user) => user.kycType === selectedKycType);
    }

    // Apply search
    if (searchTerm.trim() !== "") {
      const term = searchTerm.toLowerCase();
      result = result.filter(
        (user) =>
          user.name?.toLowerCase().includes(term) ||
          user.email?.toLowerCase().includes(term) ||
          user.phNumber?.toLowerCase().includes(term)
      );
    }

    setFilteredUsers(result);
  }, [searchTerm, selectedUserType, selectedKycType, users]);

  const getUserTypeIcon = (type: string) => {
    switch (type) {
      case "admin":
        return <MdAdminPanelSettings className="text-purple-600" />;
      case "mentor":
        return <MdOutlineSchool className="text-blue-600" />;
      default:
        return <HiOutlineUserGroup className="text-green-600" />;
    }
  };

  const getUserTypeColor = (type: string) => {
    switch (type) {
      case "admin":
        return "bg-purple-50 text-purple-700 border-purple-200";
      case "mentor":
        return "bg-blue-50 text-blue-700 border-blue-200";
      default:
        return "bg-green-50 text-green-700 border-green-200";
    }
  };

  const getKycIcon = (kyc: string) => {
    switch (kyc) {
      case "verified":
        return <FiCheckCircle className="text-green-600" />;
      case "pending":
        return <FiClock className="text-yellow-600" />;
      default:
        return <FiXCircle className="text-red-600" />;
    }
  };

  const getKycColor = (kyc: string) => {
    switch (kyc) {
      case "verified":
        return "bg-green-50 text-green-700 border-green-200";
      case "pending":
        return "bg-yellow-50 text-yellow-700 border-yellow-200";
      default:
        return "bg-red-50 text-red-700 border-red-200";
    }
  };

  const formatDate = (timestamp?: Timestamp) => {
    if (!timestamp) return "-";
    const date = timestamp.toDate();
    return date.toLocaleDateString("en-US", {
      month: "short",
      day: "numeric",
      year: "numeric",
    });
  };

  const resetFilters = () => {
    setSearchTerm("");
    setSelectedUserType("all");
    setSelectedKycType("all");
  };

  if (loading) {
    return (
      <div className="min-h-screen bg-gradient-to-br from-gray-50 to-blue-50 p-4 md:p-6">
        <div className="mb-8">
          <div className="flex items-center gap-3 mb-6">
            <div className="p-3 bg-white rounded-xl shadow-sm">
              <HiOutlineUserGroup className="text-2xl text-indigo-600" />
            </div>
            <div>
              <h1 className="text-3xl font-bold text-gray-800">Users</h1>
              <p className="text-gray-600">Manage and monitor user accounts</p>
            </div>
          </div>

          <div className="bg-white rounded-2xl shadow-lg p-8 animate-pulse">
            <div className="h-4 bg-gray-200 rounded w-1/4 mb-6" />
            <div className="space-y-4">
              {Array.from({ length: 6 }).map((_, i) => (
                <div key={i} className="h-16 bg-gray-100 rounded-lg" />
              ))}
            </div>
          </div>
        </div>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-gradient-to-br from-gray-50 to-blue-50 p-4 md:p-6">
      {/* HEADER */}
      <div className="mb-8">
        <div className="flex flex-col md:flex-row md:items-center justify-between gap-4 mb-6">
          <div className="flex items-center gap-3">
            <div className="p-3 bg-white rounded-xl shadow-sm">
              <HiOutlineUserGroup className="text-2xl text-indigo-600" />
            </div>
            <div>
              <h1 className="text-3xl font-bold text-gray-800">Users</h1>
              <p className="text-gray-600">Manage and monitor user accounts</p>
            </div>
          </div>

          <div className="flex items-center gap-4">
            <button className="flex items-center gap-2 px-4 py-2.5 bg-white border border-gray-300 rounded-xl hover:bg-gray-50 transition-colors duration-200 shadow-sm">
              <FiDownload className="text-gray-600" />
              <span className="text-sm font-medium text-gray-700">Export</span>
            </button>
          </div>
        </div>

        {/* SEARCH AND FILTERS BAR */}
        <div className="bg-white rounded-2xl shadow-lg p-6 mb-8 border border-gray-100">
          <div className="grid grid-cols-1 lg:grid-cols-12 gap-4">
            {/* SEARCH */}
            <div className="lg:col-span-4">
              <div className="relative">
                <div className="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                  <FiSearch className="text-gray-400" />
                </div>
                <input
                  type="text"
                  placeholder="Search users by name, email, or phone..."
                  value={searchTerm}
                  onChange={(e) => setSearchTerm(e.target.value)}
                  className="w-full pl-10 pr-4 py-3 border border-gray-300 rounded-xl focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500 transition-all duration-200"
                />
              </div>
            </div>

            {/* USER TYPE FILTER */}
            <div className="lg:col-span-3">
              <div className="relative">
                <div className="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                  <FiUser className="text-gray-400" />
                </div>
                <select
                  value={selectedUserType}
                  onChange={(e) => setSelectedUserType(e.target.value)}
                  className="w-full pl-10 pr-4 py-3 border border-gray-300 rounded-xl bg-white focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500 appearance-none transition-all duration-200"
                >
                  <option value="all">All User Types</option>
                  <option value="admin">Admin</option>
                  <option value="mentor">Mentor</option>
                  <option value="user">Regular User</option>
                </select>
              </div>
            </div>

            {/* KYC FILTER */}
            <div className="lg:col-span-3">
              <div className="relative">
                <div className="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                  <FiFilter className="text-gray-400" />
                </div>
                <select
                  value={selectedKycType}
                  onChange={(e) => setSelectedKycType(e.target.value)}
                  className="w-full pl-10 pr-4 py-3 border border-gray-300 rounded-xl bg-white focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500 appearance-none transition-all duration-200"
                >
                  <option value="all">All KYC Status</option>
                  <option value="verified">Verified</option>
                  <option value="pending">Pending</option>
                  <option value="rejected">Rejected</option>
                  <option value="none">Not Applied</option>
                </select>
              </div>
            </div>

            {/* ACTIONS */}
            <div className="lg:col-span-2">
              <div className="flex gap-3">
                <button
                  onClick={resetFilters}
                  className="flex-1 px-4 py-3 bg-gray-100 text-gray-700 rounded-xl hover:bg-gray-200 transition-colors duration-200 font-medium"
                >
                  Reset
                </button>
              </div>
            </div>
          </div>
        </div>
      </div>

      {/* USERS TABLE */}
      <div className="bg-white rounded-2xl shadow-lg overflow-hidden border border-gray-100">
        <div className="px-6 py-4 border-b border-gray-100 flex items-center justify-between">
          <div>
            <h3 className="text-lg font-semibold text-gray-800">
              User Accounts
            </h3>
            <p className="text-sm text-gray-600 mt-1">
              Showing {filteredUsers.length} of {users.length} users
            </p>
          </div>
        </div>

        {!filteredUsers.length ? (
          <div className="p-12 text-center">
            <div className="max-w-md mx-auto py-12">
              <div className="w-20 h-20 mx-auto bg-gray-100 rounded-full flex items-center justify-center mb-6">
                <HiOutlineUserGroup className="text-3xl text-gray-400" />
              </div>
              <h4 className="text-xl font-medium text-gray-700 mb-2">
                No users found
              </h4>
              <p className="text-gray-500 mb-6">
                {searchTerm ||
                selectedUserType !== "all" ||
                selectedKycType !== "all"
                  ? "Try adjusting your filters or search term"
                  : "No users registered yet"}
              </p>
              {(searchTerm ||
                selectedUserType !== "all" ||
                selectedKycType !== "all") && (
                <button
                  onClick={resetFilters}
                  className="px-6 py-3 bg-indigo-600 text-white rounded-xl hover:bg-indigo-700 transition-colors font-medium"
                >
                  Clear All Filters
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
                    User
                  </th>
                  <th className="px-6 py-4 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                    Contact
                  </th>
                  <th className="px-6 py-4 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                    User Type
                  </th>
                  <th className="px-6 py-4 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                    KYC Status
                  </th>
                  <th className="px-6 py-4 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                    Joined
                  </th>
                </tr>
              </thead>

              <tbody className="bg-white divide-y divide-gray-100">
                {filteredUsers.map((user) => (
                  <tr
                    key={user.id}
                    className="hover:bg-blue-50/30 transition-colors duration-150"
                  >
                    {/* USER */}
                    <td className="px-6 py-4">
                      <div className="flex items-center gap-3">
                        <div className="h-12 w-12 rounded-full bg-gradient-to-br from-indigo-100 to-blue-100 text-indigo-700 flex items-center justify-center font-semibold text-lg">
                          {user.name?.charAt(0).toUpperCase() || "U"}
                        </div>
                        <div>
                          <p className="font-medium text-gray-900">
                            {user.name || "Unnamed User"}
                          </p>
                          <div className="flex items-center gap-1 text-sm text-gray-500 mt-1">
                            <FiMail className="w-3 h-3" />
                            <span>{user.email}</span>
                          </div>
                        </div>
                      </div>
                    </td>

                    {/* CONTACT */}
                    <td className="px-6 py-4">
                      <div className="flex items-center gap-2 text-gray-700">
                        <FiPhone className="text-gray-400" />
                        <span>{user.phNumber || "Not provided"}</span>
                      </div>
                    </td>

                    {/* USER TYPE */}
                    <td className="px-6 py-4">
                      <div className="flex items-center gap-2">
                        <div className="p-1.5 bg-white rounded-lg border">
                          {getUserTypeIcon(user.userType)}
                        </div>
                        <span
                          className={`px-3 py-1.5 rounded-lg text-xs font-medium border ${getUserTypeColor(
                            user.userType
                          )}`}
                        >
                          {user.userType?.charAt(0).toUpperCase() +
                            user.userType?.slice(1) || "User"}
                        </span>
                      </div>
                    </td>

                    {/* KYC STATUS */}
                    <td className="px-6 py-4">
                      <div className="flex items-center gap-2">
                        <div className="p-1.5 bg-white rounded-lg border">
                          {getKycIcon(user.kycType || "none")}
                        </div>
                        <span
                          className={`px-3 py-1.5 rounded-lg text-xs font-medium border ${getKycColor(
                            user.kycType || "none"
                          )}`}
                        >
                          {user.kycType?.charAt(0).toUpperCase() +
                            user.kycType?.slice(1) || "Not Applied"}
                        </span>
                      </div>
                    </td>

                    {/* JOINED DATE */}
                    <td className="px-6 py-4">
                      <span className="text-sm text-gray-600">
                        {formatDate(user.createdAt)}
                      </span>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        )}

        {filteredUsers.length > 0 && (
          <div className="px-6 py-4 border-t border-gray-100 bg-gray-50">
            <div className="flex items-center justify-between text-sm text-gray-600">
              <span>
                Showing{" "}
                <span className="font-semibold">{filteredUsers.length}</span> of{" "}
                <span className="font-semibold">{users.length}</span> users
              </span>
              <div className="flex items-center gap-2">
                <span className="text-gray-500">Filtered by:</span>
                {selectedUserType !== "all" && (
                  <span className="px-2 py-1 bg-gray-200 rounded text-xs">
                    {selectedUserType}
                  </span>
                )}
                {selectedKycType !== "all" && (
                  <span className="px-2 py-1 bg-gray-200 rounded text-xs">
                    {selectedKycType}
                  </span>
                )}
                {searchTerm && (
                  <span className="px-2 py-1 bg-gray-200 rounded text-xs">
                    Search: &quot;{searchTerm}&quot;
                  </span>
                )}
              </div>
            </div>
          </div>
        )}
      </div>
    </div>
  );
}
