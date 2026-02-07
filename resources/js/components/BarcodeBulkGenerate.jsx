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
            {/* <div className="product-name">{b.name}</div> */}
            {printMode === "barcode" && <img
  src={b.img}
  alt={b.value}
  style={{
    width: "100%",
    imageRendering: "pixelated"
  }}
  className="barcode-img"
/>

}
            <div className="barcode-text">{b.value}</div>
            {/* {printMode === "label" && ( */}
            <div className="price-info">
              <span>MRP: {b.purchase_price}</span>
              <span>Cherry P: {b.price}</span>
            </div>
            {/* )} */}
          </div>
        ))}
      </div>

      {/* Hidden print-only section for better layout control */}
      <div className={`print-only mode-${printMode}`}>
  {barcodes.map((b, index) => (
    <div key={index} className={`barcode-label-print `}>
      {/* <div className="product-name">{b.name}</div>  Uncommented – remove if not needed */}
      {printMode === "barcode" && <img src={b.img} alt={b.value} />}
      <div className="barcode-text">{b.value}</div>
      {/* {printMode === "label" && ( */}
        <div className="price-info">
          <span>MRP: {b.purchase_price}</span>
          <span>Cherry P: {b.price}</span>
        </div>
      {/* )} */}
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
    /* === Screen preview styles – unchanged from your original === */
    .barcode-grid {
      display: grid;
      grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
      gap: 15px;
      margin-top: 20px;
    }
    .barcode-label {
      border: 1px solid #ddd;
      padding: 10px;
      width: 2in;
    height: 1.5in;
      text-align: center;
      border-radius: 5px;
      background: #f9f9f9;
    }
       .barcode-svg svg {
    width: 100%;
    height: 60px;
  }
     .barcode-img {
    width: 100%;
    height: auto;
    image-rendering: pixelated; /* 🔥 critical */
  }
    .product-name {
      font-weight: bold;
      font-size: 14px;
      margin-bottom: 5px;
      white-space: nowrap;
      overflow: hidden;
      text-overflow: ellipsis;
    }
    .barcode-text {
      font-size: 12px;
      letter-spacing: 2px;
      margin: 5px 0;
    }
    .price-info {
      display: flex;
      justify-content: space-between;
      font-size: 12px;
      font-weight: bold;
      color: #333;
      border-top: 1px dashed #ccc;
      padding-top: 5px;
    }
    .print-only {
      display: none;
    }

    @media print {
      * {
        -webkit-print-color-adjust: exact !important;
        print-color-adjust: exact !important;
      }
      
      .no-print {
        display: none !important;
      }
      
      .main-footer, .main-sidebar, .main-header, .content-header, .navbar {
        display: none !important;
      }
      
      body, .wrapper, .content-wrapper, .content, .container-fluid, .container {
        margin: 0 !important;
        padding: 0 !important;
        background: none !important;
      }
      
      .print-only {
        display: block !important;
        margin: 0 !important;
        padding: 0 !important;
      }

      /* === BARCODE MODE – almost identical to your original code === */
      @page {
        size: 38.1mm 50.8mm;
        margin: 0;
      }
      
      .barcode-label-print {
        width: 34.1mm;
        height: 46.8mm;
        margin: 0 !important;
        margin-left: 0.4in !important;           /* your original had this */
        margin-top: 0 !important;
        margin-bottom: 0 !important;
        padding: 0.2in;
        box-sizing: border-box;
        
        display: flex !important;
        flex-direction: column !important;
        align-items: center !important;
        justify-content: center !important;
        text-align: center !important;
        
        page-break-inside: avoid;
        break-inside: avoid;
      }
      
      .barcode-label-print:first-child {
        margin-top: 0 !important;
        padding-top: 0.2in;
      }
      
      .barcode-label-print:not(:first-child) {
        page-break-before: always;
        break-before: page;
        margin-top: 0 !important;
      }
      
      .barcode-label-print img {
        width: auto !important;
        max-width: 26mm !important;
        height: auto !important;
        max-height: 14mm !important;
        object-fit: contain !important;
        display: block !important;
        margin: 0 !important;
      }
      
      .barcode-label-print .product-name {
        font-size: 8px;
        font-weight: bold;
        margin: 0 0 1mm 0;
        max-width: 100%;
        line-height: 1.1;
        overflow: hidden;
        text-overflow: ellipsis;
        text-align: center;
      }
      
      .barcode-label-print .barcode-text {
        font-size: 7px;
        margin: 1mm 0;
        line-height: 1;
        font-weight: bold;
        letter-spacing: 0.5px;
        text-align: center;
      }
      
      .barcode-label-print .price-info {
        font-size: 6px;
        width: 100%;
        max-width: 100%;
        border-top: 1px solid #000;
        padding-top: 1mm;
        margin-top: 1mm;
        display: flex;
        justify-content: space-between;
        line-height: 1;
        font-weight: bold;
        text-align: center;
        box-sizing: border-box;
      }

  /* === LABEL MODE – ultra-clean: force start at pixel 0, no feed blanks === */

.mode-label @page {
  size: 38.1mm 12.7mm;
  margin: 0;
}

.mode-label .print-only,
.mode-label .print-only * {
  margin: 0 !important;
  padding: 0 !important;
}

.mode-label .barcode-label-print {
  width: 37.8mm !important;               /* max safe width */
  height: 12.5mm !important;              /* use almost full height to avoid cut */
  margin: 0 !important;
  margin-left: 9mm !important;
  padding: 0.3mm 1.5mm !important;        /* symmetric, minimal */
  box-sizing: border-box !important;

  display: flex !important;
  flex-direction: column !important;
  justify-content: flex-start !important;
  align-items: center !important;
  text-align: center !important;

  page-break-before: avoid !important;
  page-break-after: avoid !important;
  page-break-inside: avoid !important;
  break-before: avoid !important;
  break-after: avoid !important;
  break-inside: avoid !important;

  overflow: hidden !important;
}

/* Zero everything on first label/content */
.mode-label .barcode-label-print:first-of-type,
.mode-label .barcode-label-print:first-child {
  margin: 0 !important;
  margin-left: 9mm !important;
  padding-top: 0mm !important;
}

/* Children no extra space */
.mode-label .product-name,
.mode-label .barcode-text {
  margin-top: 0 !important;
  font-size: 7.2px !important;
  line-height: 1 !important;
}

.mode-label .price-info {
  font-size: 6.2px !important;
  margin-top: 0.3mm !important;
  padding-top: 0.2mm !important;
  border-top: 0.4px solid #000 !important;
  justify-content: center !important;
  width: 100% !important;
}
  `
}} />

    </div>
  );
};

export default BarcodeBulkGenerate;
