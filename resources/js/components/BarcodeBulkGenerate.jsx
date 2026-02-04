import React, { useEffect, useState } from "react";
import axios from "axios";

const BarcodeBulkGenerate = () => {
  const [products, setProducts] = useState([]);
  const [productId, setProductId] = useState("");
  const [skuId, setSkuId] = useState("");
  const [quantity, setQuantity] = useState(1);
  const [barcodes, setBarcodes] = useState([]);
  const [loading, setLoading] = useState(false);

  const handleProductChange = (e) => {
    setProductId(e.target.value);
    setSkuId(e.target.value);
  };

  useEffect(() => {
    axios
      .get("/admin/get/products")
      .then((res) => {

        const productList = Array.isArray(res.data)
          ? res.data
          : res.data?.data || [];

        setProducts(productList);
      })
      .catch(() => {
        setProducts([]);
      });
  }, []);


  const generateBarcodes = () => {
    if (!productId || quantity < 1) return;

    setLoading(true);
    setBarcodes([]);

    axios
      .post("/admin/product/barcode/bulkGenerate", {
        product_id: productId,
        quantity: quantity,
        sku_id: skuId,
      })
      .then((res) => {
        const data = Array.isArray(res.data) ? res.data : [];

        setBarcodes(data);
      })
      .catch(() => {
        setBarcodes([]);
      })
      .finally(() => setLoading(false));
  };


  return (
    <div className="container">
      <h2>Bulk Barcode Generator</h2>

      <div style={{ display: "flex", gap: "10px", marginBottom: "20px" }}>
        {products.length === 0 && (
          <p style={{ color: "red" }}>
            No products found. Please add products first.
          </p>
        )}

        {!loading && productId && barcodes.length === 0 && (
          <p>No barcodes generated.</p>
        )}

        <select
          value={productId}
          onChange={(e) => handleProductChange(e)}
        >
          <option value="">Select product</option>
          {products.map((p) => (
            <option key={p.id} value={p.id}>
              {p.name}
            </option>
          ))}
        </select>

        <input
          type="number"
          min="1"
          max="1000"
          value={quantity}
          onChange={(e) => setQuantity(Math.max(1, Number(e.target.value)))}
        />


        <button
          onClick={generateBarcodes}
          disabled={loading || products.length === 0 || !productId}
        >
          {loading ? "Generating..." : "Generate"}
        </button>

      </div>

      <div className="barcode-grid">
        {barcodes.map((b, index) => (
          <div key={index} className="barcode-label">

            <img src={b.img} alt={b.value} />

            <div className="barcode-text">{b.value}</div>

          </div>
        ))}
      </div>
      {barcodes.length > 0 && (
        <div style={{ marginBottom: "15px" }}>
          <button onClick={() => window.print()}>
            🖨️ Print Barcodes
          </button>
        </div>
      )}

    </div>
  );
};

export default BarcodeBulkGenerate;
