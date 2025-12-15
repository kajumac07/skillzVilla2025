"use client";

import { useEffect } from "react";
import { useRouter, usePathname } from "next/navigation";
import { getAuth, onAuthStateChanged, signOut } from "firebase/auth";
import Link from "next/link";

export default function Layout({ children }: { children: React.ReactNode }) {
  const router = useRouter();
  const pathname = usePathname();
  const auth = getAuth();

  useEffect(() => {
    const unsub = onAuthStateChanged(auth, (user) => {
      if (!user) {
        router.replace("/login");
      }
    });
    return () => unsub();
  }, [auth, router]);

  const linkClass = (path: string) =>
    `block px-3 py-2 rounded ${
      pathname === path ? "bg-indigo-100 font-semibold" : "hover:bg-gray-100"
    }`;

  return (
    <div className="min-h-screen flex bg-gray-100">
      {/* Sidebar (20%) */}
      <aside className="w-[20%] min-w-[220px] bg-white shadow-lg p-4">
        <h2 className="text-xl font-bold mb-6">Admin</h2>

        <nav className="space-y-2">
          <Link href="/" className={linkClass("/")}>
            Dashboard
          </Link>
          <Link href="/categories" className={linkClass("/categories")}>
            Categories
          </Link>
          <Link href="/sub-categories" className={linkClass("/sub-categories")}>
            Sub Categories
          </Link>
          <Link href="/users" className={linkClass("/users")}>
            Users
          </Link>
        </nav>

        <button
          onClick={async () => {
            await signOut(auth);
            router.replace("/login");
          }}
          className="mt-10 text-sm text-red-600 underline"
        >
          Logout
        </button>
      </aside>

      {/* Page Content (80%) */}
      <main className="flex-1 p-6">{children}</main>
    </div>
  );
}
