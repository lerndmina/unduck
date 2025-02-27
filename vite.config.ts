import { defineConfig } from "vite";
import { VitePWA } from "vite-plugin-pwa";

export default defineConfig({
  plugins: [
    VitePWA({
      registerType: "autoUpdate",
    }),
  ],
  server: {
    port: 3000,
  },
  preview: {
    port: 3000,
    host: true, // This enables listening on all addresses
    strictPort: true,
    cors: true,
    allowedHosts: true,
  },
});
