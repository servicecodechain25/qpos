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

      {/* Hidden print-only section for better layout control */}
      <div className="print-only">
        {barcodes.map((b, index) => (
          <div key={index} className="barcode-label-print">
            {/* <div className="product-name">{b.name}</div> */}
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
        </div>
      )}

      <style dangerouslySetInnerHTML={{
        __html: `
  .barcode-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
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
    
    .print-only {
      display: block !important;
    }
    
    body {
      margin: 0 !important;
      padding: 0 !important;
    }
    
    @page {
      size: 50.8mm 38.1mm;
      margin: 0;
    }
    
    .barcode-label-print {
      width: 50.8mm;
      height: 38.1mm;
      margin: 0;
      padding: 2mm;
      box-sizing: border-box;
      
      display: flex !important;
      flex-direction: column !important;
      align-items: center !important;
      justify-content: center !important;
      text-align: center;
      
      page-break-after: always;
      page-break-inside: avoid;
      break-after: page;
      break-inside: avoid;
    }
    
    .barcode-label-print:last-child {
      page-break-after: auto;
    }
    
    .barcode-label-print img {
      width: auto;
      max-width: 46mm;
      height: auto;
      max-height: 20mm;
      object-fit: contain;
      display: block;
    }
    
    .barcode-label-print .product-name {
      font-size: 9px;
      font-weight: bold;
      margin: 0 0 1mm 0;
      max-width: 100%;
      line-height: 1.1;
      overflow: hidden;
      text-overflow: ellipsis;
    }
    
    .barcode-label-print .barcode-text {
      font-size: 8px;
      margin: 1mm 0;
      line-height: 1;
      font-weight: bold;
      letter-spacing: 0.5px;
    }
    
    .barcode-label-print .price-info {
      font-size: 7px;
      width: 100%;
      border-top: 1px solid #000;
      padding-top: 1mm;
      margin-top: 1mm;
      display: flex;
      justify-content: space-between;
      line-height: 1;
      font-weight: bold;
    }
  }
`}} />

    </div>
  );
};

export default BarcodeBulkGenerate;
