"use client";

const kpis = [
  {
    title: "Total Users",
    value: "12,480",
    change: "+12%",
    gradient: "from-indigo-500 to-purple-500",
  },
  {
    title: "Total Services",
    value: "86",
    change: "+4%",
    gradient: "from-emerald-500 to-teal-500",
  },
  {
    title: "Total Revenue",
    value: "₹4,82,000",
    change: "+18%",
    gradient: "from-orange-500 to-pink-500",
  },
  {
    title: "Today's Orders",
    value: "142",
    change: "+9%",
    gradient: "from-blue-500 to-cyan-500",
  },
];

export default function DashboardPage() {
  return (
    <>
      {/* HEADER */}
      <div className="mb-8">
        <h1 className="text-3xl font-bold text-gray-800">Dashboard</h1>
        <p className="text-sm text-gray-500 mt-1">
          Overview of platform performance
        </p>
      </div>

      {/* KPI CARDS */}
      <div className="grid grid-cols-1 sm:grid-cols-2 xl:grid-cols-4 gap-6 mb-10">
        {kpis.map((item) => (
          <div
            key={item.title}
            className={`rounded-2xl p-5 text-white shadow-lg bg-gradient-to-r ${item.gradient}`}
          >
            <p className="text-sm opacity-90">{item.title}</p>

            <div className="mt-3 flex items-end justify-between">
              <h3 className="text-3xl font-bold">{item.value}</h3>
              <span className="text-sm bg-white/20 px-2 py-1 rounded">
                {item.change}
              </span>
            </div>
          </div>
        ))}
      </div>

      {/* MIDDLE SECTION */}
      <div className="grid grid-cols-1 xl:grid-cols-3 gap-6 mb-10">
        {/* REVENUE CHART */}
        <div className="xl:col-span-2 bg-white rounded-2xl shadow p-6">
          <div className="flex items-center justify-between mb-4">
            <h3 className="text-lg font-semibold">Revenue Overview</h3>
            <span className="text-sm text-gray-400">Last 7 days</span>
          </div>

          <div className="flex items-end gap-4 h-56">
            {[45, 70, 55, 90, 75, 95, 65].map((h, i) => (
              <div
                key={i}
                className="flex-1 rounded-t-lg bg-gradient-to-t from-indigo-500 to-indigo-300"
                style={{ height: `${h}%` }}
              />
            ))}
          </div>

          <div className="mt-4 flex justify-between text-xs text-gray-400">
            <span>Mon</span>
            <span>Tue</span>
            <span>Wed</span>
            <span>Thu</span>
            <span>Fri</span>
            <span>Sat</span>
            <span>Sun</span>
          </div>
        </div>

        {/* QUICK STATS */}
        <div className="bg-white rounded-2xl shadow p-6">
          <h3 className="text-lg font-semibold mb-5">Quick Stats</h3>

          <div className="space-y-4 text-sm">
            <StatRow label="All Time Orders" value="8,942" />
            <StatRow label="Today's Revenue" value="₹18,200" />
            <StatRow label="Active Users" value="3,120" />
            <StatRow label="Pending KYC" value="37" danger />
          </div>
        </div>
      </div>

      {/* RECENT ACTIVITY */}
      <div className="bg-white rounded-2xl shadow p-6">
        <h3 className="text-lg font-semibold mb-4">Recent Activity</h3>

        <div className="divide-y text-sm">
          <Activity text="Rahul Sharma completed KYC" time="2 mins ago" />
          <Activity text="New order placed" time="10 mins ago" />
          <Activity text="Anjali Verma registered" time="1 hour ago" />
        </div>
      </div>
    </>
  );
}

/* ---------------- Small Components ---------------- */

function StatRow({
  label,
  value,
  danger,
}: {
  label: string;
  value: string;
  danger?: boolean;
}) {
  return (
    <div className="flex justify-between items-center">
      <span className="text-gray-500">{label}</span>
      <span
        className={`font-semibold ${danger ? "text-red-600" : "text-gray-800"}`}
      >
        {value}
      </span>
    </div>
  );
}

function Activity({ text, time }: { text: string; time: string }) {
  return (
    <div className="flex justify-between py-3">
      <span>{text}</span>
      <span className="text-gray-400">{time}</span>
    </div>
  );
}
