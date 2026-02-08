import React, { useEffect, useState } from "react";
import axios from "axios";

const BarcodeBulkGenerate = () => {
  const [products, setProducts] = useState([]);
  const [productId, setProductId] = useState("");
  const [skuId, setSkuId] = useState("");
  const [quantity, setQuantity] = useState(1);
  const [barcodes, setBarcodes] = useState([]);
  const [loading, setLoading] = useState(false);
  const [printMode, setPrintMode] = useState("barcode"); // 'barcode' or 'label'

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
        mode: printMode,
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
      <h2 className="no-print">Bulk Barcode Generator</h2>

      <div style={{ display: "flex", gap: "10px", marginBottom: "20px", alignItems: "center" }} className="no-print">
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
          className="form-control"
          style={{ width: "200px" }}
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
          className="form-control"
          style={{ width: "80px" }}
        />

        <select
          value={printMode}
          onChange={(e) => setPrintMode(e.target.value)}
          className="form-control"
          style={{ width: "150px" }}
        >
          <option value="barcode">Barcode Mode</option>
          <option value="label">Label Mode</option>
          <option value="text-only">Text-Only Mode</option>
        </select>

        <button
          onClick={generateBarcodes}
          className="btn btn-primary"
          disabled={loading || products.length === 0 || !productId}
        >
          {loading ? "Generating..." : "Generate"}
        </button>

      </div>

      <div className="barcode-grid no-print">
        {barcodes.map((b, index) => (
          <div key={index} className="barcode-label">
            <img
              src={b.img}
              alt={b.value}
              style={{
                width: "100%",
                imageRendering: "pixelated",
                margin: "auto",
                display: "block"
              }}
              className="barcode-img"
            />
          </div>
        ))}
      </div>

      {/* Hidden print-only section for better layout control */}
      <div className={`print-only mode-${printMode}`}>
        {barcodes.map((b, index) => (
          <div key={index} className="barcode-label-print"><img src={b.img} alt={b.value} /></div>
        ))}
      </div>

      {barcodes.length > 0 && (
        <div style={{ marginBottom: "15px", marginTop: "15px" }} className="no-print">
          <button onClick={() => window.print()} className="btn btn-primary">
            🖨️ Print Barcodes
          </button>
          <p className="text-muted small mt-2 mb-0">
            Thermal printer: set paper size to <strong>{printMode === 'text-only' ? '2" × 0.75"' : '2" × 1.5"'}</strong> and turn off <strong>Headers and footers</strong> in the print dialog.
          </p>
        </div>
      )}

      <style dangerouslySetInnerHTML={{
        __html: `
    /* === Screen preview styles === */
    .barcode-grid {
      display: grid;
      grid-template-columns: repeat(auto-fill, minmax(180px, 1fr));
      gap: 15px;
      margin-top: 20px;
    }
    .barcode-label {
      border: 1px solid #ddd;
      padding: 10px;
      text-align: center;
      border-radius: 5px;
      background: #f9f9f9;
    }
    .barcode-img {
      width: 100%;
      height: auto;
      image-rendering: pixelated;
    }
    .product-name {
      font-weight: bold;
      font-size: 13px;
      margin-bottom: 5px;
      white-space: nowrap;
      overflow: hidden;
      text-overflow: ellipsis;
    }
    .barcode-text {
      font-size: 11px;
      letter-spacing: 1px;
      margin: 5px 0;
    }
    .price-info {
      display: flex;
      justify-content: space-between;
      font-size: 11px;
      font-weight: bold;
      color: #333;
      border-top: 1px dashed #ccc;
      padding-top: 5px;
    }
    .print-only {
      display: none;
    }

    @media print {
      html, body {
        height: auto !important;
        margin: 0 !important;
        padding: 0 !important;
        background: #fff !important;
      }

      .no-print, 
      .main-footer, 
      .main-sidebar, 
      .main-header, 
      .content-header {
        display: none !important;
        height: 0 !important;
        margin: 0 !important;
        padding: 0 !important;
      }
      
      .print-only {
        display: block !important;
        width: 100% !important;
        margin: 0 !important;
        padding: 0 !important;
      }

      .barcode-label-print {
        display: flex !important;
        flex-direction: column !important;
        align-items: center !important;
        justify-content: center !important;
        width: 100% !important;
        height: ${printMode === 'text-only' ? '19.0mm' : '38.0mm'} !important;
        padding: 0 !important;
        margin: 0 !important;
        page-break-after: always !important;
        break-after: page !important;
        overflow: hidden !important;
        box-sizing: border-box !important;
      }

      .barcode-label-print:last-child {
        page-break-after: auto !important;
        break-after: auto !important;
      }
      
      .barcode-label-print img {
        width: 100% !important;
        height: 100% !important;
        display: block !important;
        object-fit: contain !important;
        image-rendering: pixelated !important;
      }
    }
  `
      }} />

    </div>
  );
};

export default BarcodeBulkGenerate;
