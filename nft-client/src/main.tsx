import * as React from "react";
import * as ReactDOM from "react-dom/client";
import App from "./App";
import { createThirdwebClient } from "thirdweb";
import { ThirdwebProvider } from "thirdweb/react";
import { QueryClient, QueryClientProvider } from "@tanstack/react-query";
import { defineChain } from "thirdweb/chains";
import "./index.css";

const client = createThirdwebClient({
  clientId: import.meta.env.VITE_THIRDWEB_CLIENT_ID,
});

const queryClient = new QueryClient();

const polygon = defineChain(137);

ReactDOM.createRoot(document.getElementById("root")!).render(
  <React.StrictMode>
    <QueryClientProvider client={queryClient}>
      <ThirdwebProvider client={client} activeChain={polygon}>
        <App />
      </ThirdwebProvider>
    </QueryClientProvider>
  </React.StrictMode>
);
