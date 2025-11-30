const express = require("express");
const app = express();

// Use port from environment (for Kubernetes later) or default 3000
const PORT = process.env.PORT || 3000;

app.get("/", (req, res) => {
  res.json({
    service: "cloudcorex-node-api",
    status: "ok",
    message: "Hello from CloudCoreX DevOps lab!",
    timestamp: new Date().toISOString()
  });
});

app.listen(PORT, () => {
  console.log(`CloudCoreX Node API listening on port ${PORT}`);
});// Introduce a bug on purpose
app.get("/", (req, res) => {
  throw new Error("Simulated crash in production");
});

