"use client";

import React, { useState } from "react";
import { useRouter } from "next/navigation";
import { signInWithEmailAndPassword, signOut } from "firebase/auth";
import { collection, query, where, getDocs } from "firebase/firestore";
import { auth, db } from "@/lib/firebase";

export default function LoginComponent() {
  const router = useRouter();
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setError(null);
    if (!email || !password) {
      setError("Please provide email and password.");
      return;
    }

    setLoading(true);
    try {
      // Sign in with Firebase Auth
      const cred = await signInWithEmailAndPassword(auth, email, password);
      const user = cred.user;

      const adminsRef = collection(db, "admins");
      const q = query(adminsRef, where("email", "==", user.email));
      const snap = await getDocs(q);

      if (snap.empty) {
        // Not present in admins collection -> revoke sign-in and show error
        await signOut(auth);
        setError("You do not have admin access.");
        setLoading(false);
        return;
      }

      // Admin found -> redirect to dashboard root
      router.push("/");
    } catch (err: unknown) {
      console.error(err);
      // Map common Firebase errors to friendly messages
      const code =
        (err instanceof Error && (err as { code?: string })?.code) || "";
      if (code === "auth/user-not-found")
        setError("No user found with this email.");
      else if (code === "auth/wrong-password") setError("Incorrect password.");
      else if (code === "auth/invalid-email")
        setError("Invalid email address.");
      else setError("Failed to sign in. Please try again.");
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="min-h-screen flex items-center justify-center bg-gradient-to-b from-gray-100 to-gray-200 p-6">
      <div className="max-w-md w-full bg-white rounded-2xl shadow-xl overflow-hidden p-8">
        <h2 className="text-2xl font-bold text-gray-800">Admin Sign in</h2>
        <p className="mt-2 text-sm text-gray-500">
          Sign in with your email and password.
        </p>

        <form onSubmit={handleSubmit} className="mt-6 space-y-4">
          <label className="block">
            <span className="text-sm font-medium text-gray-700">Email</span>
            <input
              type="email"
              value={email}
              onChange={(e) => setEmail(e.target.value.trim())}
              placeholder="you@company.com"
              className="mt-1 block w-full rounded-md border border-gray-300 px-4 py-2 focus:outline-none focus:ring-2 focus:ring-indigo-400"
              aria-label="Email"
              required
            />
          </label>

          <label className="block">
            <span className="text-sm font-medium text-gray-700">Password</span>
            <input
              type="password"
              value={password}
              onChange={(e) => setPassword(e.target.value)}
              placeholder="Enter your password"
              className="mt-1 block w-full rounded-md border border-gray-300 px-4 py-2 focus:outline-none focus:ring-2 focus:ring-indigo-400"
              aria-label="Password"
              required
            />
          </label>

          {error && (
            <p className="text-sm text-red-600" role="alert">
              {error}
            </p>
          )}

          <div className="flex items-center justify-between">
            <button
              type="submit"
              disabled={loading}
              className="inline-flex items-center gap-2 px-5 py-2 rounded-lg bg-indigo-600 text-white font-medium shadow hover:bg-indigo-700 transition disabled:opacity-60"
            >
              {loading ? "Signing in..." : "Sign in"}
            </button>

            <button
              type="button"
              onClick={() => {
                setEmail("");
                setPassword("");
                setError(null);
              }}
              className="text-sm text-indigo-600 underline"
            >
              Reset
            </button>
          </div>

          <p className="text-xs text-gray-400 text-center">
            By continuing you agree to our{" "}
            <button className="underline">Terms</button> and{" "}
            <button className="underline">Privacy Policy</button>.
          </p>
        </form>
      </div>
    </div>
  );
}
