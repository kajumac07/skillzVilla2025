"use client";

import React, { useRef, useState, FormEvent } from "react";

const OTP_LENGTH = 6;

export default function LoginComponent() {
  const [mobile, setMobile] = useState<string>("");
  const [otp, setOtp] = useState<string[]>(new Array(OTP_LENGTH).fill(""));
  const inputsRef = useRef<HTMLInputElement[]>([]);

  const handleMobileChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const cleaned = e.target.value.replace(/[^0-9]/g, "").slice(0, 15);
    setMobile(cleaned);
  };

  const handleOtpChange = (index: number, value: string) => {
    if (!/^[0-9]*$/.test(value)) return;
    const next = [...otp];
    next[index] = value.slice(-1);
    setOtp(next);
    if (value && index < inputsRef.current.length - 1) {
      inputsRef.current[index + 1]?.focus();
    }
  };

  const handleOtpKeyDown = (
    e: React.KeyboardEvent<HTMLInputElement>,
    index: number
  ) => {
    if (e.key === "Backspace" && otp[index] === "" && index > 0) {
      inputsRef.current[index - 1]?.focus();
    }
  };

  const handleOtpPaste = (e: React.ClipboardEvent<HTMLInputElement>) => {
    e.preventDefault();
    const pasted = e.clipboardData
      .getData("text")
      .replace(/\D/g, "")
      .slice(0, OTP_LENGTH)
      .split("");
    const next = [...otp];
    for (let i = 0; i < OTP_LENGTH; i++) next[i] = pasted[i] || "";
    setOtp(next);
    const firstEmpty = next.findIndex((c) => c === "");
    const focusIndex = firstEmpty === -1 ? OTP_LENGTH - 1 : firstEmpty;
    inputsRef.current[focusIndex]?.focus();
  };

  const submit = (e: FormEvent) => {
    e.preventDefault();
    const code = otp.join("");
    // UI-only: replace with real auth call when integrating with Firebase
    // Example: await sendToFirebase(mobile, code)
    console.log("Would submit:", { mobile, code });
  };

  return (
    <div className="min-h-screen flex items-center justify-center bg-gradient-to-b from-gray-100 to-gray-200 p-6">
      <div className="max-w-4xl w-full bg-white rounded-2xl shadow-xl overflow-hidden grid grid-cols-1 md:grid-cols-2">
        {/* Left panel - brand/illustration */}
        <div className="hidden md:flex flex-col justify-center items-center bg-gradient-to-br from-indigo-600 via-purple-600 to-pink-500 text-white p-10">
          <div className="w-40 h-40 rounded-xl bg-white/10 flex items-center justify-center mb-6">
            <svg
              width="48"
              height="48"
              viewBox="0 0 24 24"
              fill="none"
              xmlns="http://www.w3.org/2000/svg"
            >
              <path
                d="M12 2L20 7v7c0 5-3.5 9.5-8 11-4.5-1.5-8-6-8-11V7l8-5z"
                fill="white"
                fillOpacity="0.12"
              />
              <path
                d="M12 7a5 5 0 100 10 5 5 0 000-10z"
                stroke="white"
                strokeOpacity="0.9"
                strokeWidth="1.2"
                strokeLinecap="round"
                strokeLinejoin="round"
              />
            </svg>
          </div>
          <h3 className="text-2xl font-semibold">Welcome back</h3>
          <p className="mt-2 text-center text-sm max-w-xs">
            Fast, secure login with OTP — no passwords required. Sign in using
            your mobile number or continue with Google / Apple.
          </p>
        </div>

        {/* Right panel - form */}
        <div className="p-8 md:p-12">
          <h2 className="text-2xl font-bold text-gray-800">Sign in</h2>
          <p className="mt-2 text-sm text-gray-500">
            Enter your mobile number to receive a {OTP_LENGTH}-digit OTP.
          </p>

          <form onSubmit={submit} className="mt-6 space-y-6">
            <label className="block">
              <span className="text-sm font-medium text-gray-700">
                Mobile number
              </span>
              <div className="mt-1">
                <div className="flex">
                  <span className="inline-flex items-center px-3 rounded-l-md border border-r-0 border-gray-300 bg-gray-50 text-sm text-gray-600">
                    +91
                  </span>
                  <input
                    type="tel"
                    inputMode="numeric"
                    value={mobile}
                    onChange={handleMobileChange}
                    placeholder="Enter mobile number"
                    className="flex-1 block w-full rounded-r-md border border-gray-300 px-4 py-2 focus:outline-none focus:ring-2 focus:ring-indigo-400"
                    aria-label="Mobile number"
                  />
                </div>
              </div>
            </label>

            <div>
              <span className="text-sm font-medium text-gray-700">
                Enter OTP
              </span>
              <div className="mt-2 flex gap-2">
                {otp.map((digit, i) => (
                  <input
                    key={i}
                    ref={(el) => {
                      if (el) inputsRef.current[i] = el;
                    }}
                    value={digit}
                    onChange={(e) => handleOtpChange(i, e.target.value)}
                    onKeyDown={(e) =>
                      handleOtpKeyDown(
                        e as unknown as React.KeyboardEvent<HTMLInputElement>,
                        i
                      )
                    }
                    onPaste={handleOtpPaste}
                    inputMode="numeric"
                    type="text"
                    maxLength={1}
                    className="w-12 h-12 text-center text-lg rounded-lg border border-gray-300 focus:border-indigo-400 focus:ring-2 focus:ring-indigo-300"
                    aria-label={`OTP digit ${i + 1}`}
                  />
                ))}
              </div>
            </div>

            <div className="flex items-center justify-between">
              <button
                type="submit"
                className="inline-flex items-center gap-2 px-5 py-2 rounded-lg bg-indigo-600 text-white font-medium shadow hover:bg-indigo-700 transition"
              >
                Verify & Sign in
              </button>

              <button
                type="button"
                onClick={() => alert("Resend OTP")}
                className="text-sm text-indigo-600 underline"
              >
                Resend OTP
              </button>
            </div>

            <div className="flex items-center justify-center gap-3 text-sm text-gray-400">
              <span className="h-px w-16 bg-gray-200 inline-block" />
              <span>or continue with</span>
              <span className="h-px w-16 bg-gray-200 inline-block" />
            </div>

            <div className="flex gap-3">
              <button
                type="button"
                className="flex-1 inline-flex items-center justify-center gap-3 rounded-lg border border-gray-200 px-4 py-2 hover:shadow-sm transition"
              >
                {/* Google icon */}
                <svg
                  width="20"
                  height="20"
                  viewBox="0 0 533.5 544.3"
                  xmlns="http://www.w3.org/2000/svg"
                  className="shrink-0"
                  aria-hidden
                >
                  <path
                    d="M533.5 278.4c0-18.5-1.5-36.3-4.3-53.6H272v101.5h147.1c-6.4 34.6-25.8 63.9-55.3 83.5v69.4h89.3c52.2-48.1 82.4-118.9 82.4-200.8z"
                    fill="#4285F4"
                  />
                  <path
                    d="M272 544.3c74.2 0 136.6-24.6 182.2-66.8l-89.3-69.4c-24.8 16.6-56.6 26.4-92.9 26.4-71.4 0-132-48.1-153.5-112.7H28.8v70.9C74.2 486 165.6 544.3 272 544.3z"
                    fill="#34A853"
                  />
                  <path
                    d="M118.5 327.8c-11.6-34.6-11.6-71.9 0-106.5V150.4H28.8c-39.5 78.9-39.5 171.5 0 250.4l89.7-73z"
                    fill="#FBBC05"
                  />
                  <path
                    d="M272 107.7c39.9 0 75.9 13.7 104.2 40.6l78-78C408.6 24 346.2 0 272 0 165.6 0 74.2 58.3 28.8 150.4l89.7 70.9C140 155.8 200.6 107.7 272 107.7z"
                    fill="#EA4335"
                  />
                </svg>
                <span>Google</span>
              </button>

              <button
                type="button"
                className="flex-1 inline-flex items-center justify-center gap-3 rounded-lg border border-gray-200 px-4 py-2 hover:shadow-sm transition"
              >
                {/* Apple icon */}
                <svg
                  width="18"
                  height="20"
                  viewBox="0 0 24 24"
                  fill="none"
                  xmlns="http://www.w3.org/2000/svg"
                  className="shrink-0"
                  aria-hidden
                >
                  <path
                    d="M16.365 1.43c0 1.02-.386 2.01-1.085 2.737-.78.8-1.967 1.487-3.149 1.064-.131-.046-.263-.101-.396-.164-.222-.107-.445-.222-.667-.345-.747-.43-1.49-1.187-1.903-2.054C8.72 1.875 9.575.83 10.832.83c.917 0 1.884.403 2.583 1.083.289.286.546.61.9.86.15.11.308.205.47.28.009-.001.01-.003.01-.007z"
                    fill="#111"
                  />
                  <path
                    d="M20.5 7.5c-.735-1.173-1.854-2.1-3.164-2.66-1.425-.62-3.03-.74-4.524-.34-1.085.306-2.023.95-2.79 1.63-.56.52-1.022 1.12-1.37 1.77-.24.45-.44.93-.6 1.41-.72 2.04-.18 4.32 1.31 5.81 1.45 1.45 3.63 2.16 5.22 1.66.47-.13.92-.31 1.36-.54 1.17-.58 2.16-1.56 2.97-2.61.44-.58.8-1.24 1.06-1.94.45-1.17.59-2.46.09-3.67-.08-.24-.16-.47-.26-.69z"
                    fill="#111"
                  />
                </svg>
                <span>Apple</span>
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
    </div>
  );
}
