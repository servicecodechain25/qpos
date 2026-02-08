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
          <div key={index} className="barcode-label-print">
            <img src={b.img} alt={b.value} />
          </div>
        ))}
      </div>

      {barcodes.length > 0 && (
        <div style={{ marginBottom: "15px", marginTop: "15px" }} className="no-print">
          <button onClick={() => window.print()} className="btn btn-primary">
            🖨️ Print Barcodes
          </button>
          <p className="text-muted small mt-2 mb-0">
            Thermal printer: set paper size to <strong>1.5" × 2"</strong> and turn off <strong>Headers and footers</strong> in the print dialog so only labels print.
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
      @page {
        size: 50.8mm 38.1mm;
        margin: 0;
      }
      
      /* Text-only mode uses smaller labels: 0.75" x 2" (19.05mm x 50.8mm) */
      .mode-text-only {
        @page {
          size: 50.8mm 19.05mm;
          margin: 0;
        }
      }
      
      body {
        margin: 0 !important;
        padding: 0 !important;
      }

      .no-print, 
      .main-footer, 
      .main-sidebar, 
      .main-header, 
      .content-header {
        display: none !important;
      }
      
      .print-only {
        display: block !important;
        width: 50.8mm !important;
        margin: 0 !important;
        padding: 0 !important;
      }

      .barcode-label-print {
        width: 50.8mm !important;
        height: 38.1mm !important;
        padding: 0.5mm !important;
        box-sizing: border-box !important;
        display: flex !important;
        flex-direction: column !important;
        align-items: center !important;
        justify-content: center !important;
        text-align: center !important;
        page-break-after: always !important;
        break-after: page !important;
        overflow: hidden !important;
      }

      .barcode-label-print:last-child {
        page-break-after: auto !important;
        break-after: auto !important;
      }
      
      /* Text-only mode labels are narrower */
      .mode-text-only .barcode-label-print {
        height: 19.05mm !important;
      }

      .barcode-label-print .product-name {
        font-size: 10pt !important;
        font-weight: bold !important;
        margin: 0 0 1mm 0 !important;
        width: 100% !important;
        white-space: nowrap !important;
        overflow: hidden !important;
        text-overflow: ellipsis !important;
      }

      .barcode-label-print img {
        width: 100% !important;
        height: 100% !important;
        max-height: 38mm !important;
        object-fit: contain !important;
        display: block !important;
      }

      .barcode-label-print .barcode-text {
        font-size: 9pt !important;
        margin: 1mm 0 !important;
        letter-spacing: 1mm !important;
        font-weight: bold !important;
      }

      .barcode-label-print .price-info {
        font-size: 9pt !important;
        width: 100% !important;
        border-top: 1px solid #000 !important;
        padding-top: 1mm !important;
        margin-top: 1mm !important;
        display: flex !important;
        justify-content: space-between !important;
        font-weight: bold !important;
      }
    }
  `
      }} />

    </div>
  );
};

export default BarcodeBulkGenerate;
