import React, { useEffect, useState, useCallback } from "react";
import AsyncSelect from "react-select/async";
import axios from "axios";
import debounce from "lodash.debounce";
import Select from "react-select";

const BarcodeBulkGenerate = () => {
  const [products, setProducts] = useState([]);
  const [productIds, setProductIds] = useState([]);
  const [quantity, setQuantity] = useState(1);
  const [barcodes, setBarcodes] = useState([]);
  const [loading, setLoading] = useState(false);
  const [printMode, setPrintMode] = useState("barcode"); // 'barcode' or 'label'
  const [paperSize, setPaperSize] = useState("thermal-2x1");
  const [customWidth, setCustomWidth] = useState(50.8);
  const [customHeight, setCustomHeight] = useState(38.1);
  const [search, setSearch] = useState("");
  // Paper size options
  const paperSizeOptions = [
    // { value: "24-per-sheet", label: "24 per sheet (a4) (2.48 * 1.334)", width: 63.0, height: 33.9 },
    // { value: "20-per-sheet", label: "20 per sheet (4 * 1)", width: 101.6, height: 25.4 },
    // { value: "18-per-sheet", label: "18 per sheet (a4) (2.5 * 1.835)", width: 63.5, height: 46.6 },
    // { value: "14-per-sheet", label: "14 per sheet (4 * 1.33)", width: 101.6, height: 33.8 },
    // { value: "12-per-sheet", label: "12 per sheet (a4) (2.5 * 2.834)", width: 63.5, height: 72.0 },
    // { value: "10-per-sheet", label: "10 per sheet (4 * 2)", width: 101.6, height: 50.8 },
    { value: "thermal-2x1", label: "Thermal Barcode (2 * 1.5 inch)", width: 50.8, height: 38.1 },
    { value: "thermal-4x1", label: "Thermal Label (1.5 * 0.5 inch)", width: 38, height: 15 },
    { value: "custom", label: "Custom Size", width: 0, height: 0 }
  ];

  const getSelectedPaperSize = () => {
    const selected = paperSizeOptions.find(opt => opt.value === paperSize);
    if (paperSize === "custom") {
      return { width: customWidth, height: customHeight };
    }
    return selected || paperSizeOptions[6]; // default to thermal-2x1
  };

  const handleProductChange = (selectedOptions) => {
    const values = selectedOptions ? selectedOptions.map(opt => opt.value) : [];
    setProductIds(values);
  };

  const selectAll = () => {
    setProductIds(products.map(p => p.id));
  };

  const clearAll = () => {
    setProductIds([]);
  };

  useEffect(() => {
    setLoading(true);

    axios
      .get("/admin/get/products")
      .then((res) => {
        setProducts(res.data?.data || []);
      })
      .catch(() => {
        setProducts([]);
      })
      .finally(() => {
        setLoading(false);
      });
  }, []);

  // ✅ 2. Debounced search
  useEffect(() => {
    const delayDebounce = setTimeout(() => {
      if (search.length < 2) return;

      setLoading(true);

      axios
        .get("/admin/get/products", {
          params: { search: search },
        })
        .then((res) => {
          setProducts(res.data?.data || []);
        })
        .catch(() => {
          setProducts([]);
        })
        .finally(() => {
          setLoading(false);
        });

    }, 300);

    return () => clearTimeout(delayDebounce);
  }, [search]);

  const productOptions = products.map((p) => ({
    value: p.id,
    label: `${p.name} (${p.sku})`,
  }));



  const generateBarcodes = () => {
    if (productIds.length === 0 || quantity < 1) return;

    setLoading(true);
    setBarcodes([]);

    axios
      .post("/admin/product/barcode/bulkGenerate", {
        product_ids: productIds,
        quantity: quantity,
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

      <div style={{ display: "flex", gap: "10px", marginBottom: "20px", alignItems: "center", flexWrap: "wrap" }} className="no-print">
        {products.length === 0 && (
          <p style={{ color: "red" }}>
            No products found. Please add products first.
          </p>
        )}

        {!loading && productIds.length > 0 && barcodes.length === 0 && (
          <p>Click Generate to create labels.</p>
        )}

        <div style={{ width: "400px" }}>
          <Select
            options={productOptions}
            onInputChange={(value) => setSearch(value)}
            onChange={handleProductChange}
            placeholder="Search and select products..."
            isClearable
            isMulti
            isLoading={loading}
          />
        </div>

        <div className="btn-group">
          <button
            onClick={selectAll}
            className="btn btn-outline-secondary btn-sm"
            disabled={loading || products.length === 0}
          >
            Select All
          </button>
          <button
            onClick={clearAll}
            className="btn btn-outline-secondary btn-sm"
            disabled={loading || productIds.length === 0}
          >
            Clear
          </button>
        </div>

        <div style={{ display: "flex", alignItems: "center", gap: "5px" }}>
          <label className="mb-0 small">Qty/Product:</label>
          <input
            type="number"
            min="1"
            max="1000"
            value={quantity}
            onChange={(e) => setQuantity(Math.max(1, Number(e.target.value)))}
            className="form-control"
            style={{ width: "80px", height: "38px" }}
          />
        </div>

        <select
          value={printMode}
          onChange={(e) => setPrintMode(e.target.value)}
          className="form-control"
          style={{ width: "150px", height: "38px" }}
        >
          <option value="barcode">Barcode Mode</option>
          {/* <option value="label">Label Mode</option> */}
          <option value="text-only">Text-Only Mode</option>
        </select>

        {/*<select
          value={paperSize}
          onChange={(e) => setPaperSize(e.target.value)}
          className="form-control"
          style={{ width: "250px", height: "38px" }}
        >
          {paperSizeOptions.map(opt => (
            <option key={opt.value} value={opt.value}>{opt.label}</option>
          ))}
        </select>*/}

        {paperSize === "custom" && (
          <>
            <div style={{ display: "flex", alignItems: "center", gap: "5px" }}>
              <label className="mb-0 small">Width (mm):</label>
              <input
                type="number"
                min="10"
                max="300"
                step="0.1"
                value={customWidth}
                onChange={(e) => setCustomWidth(parseFloat(e.target.value) || 50.8)}
                className="form-control"
                style={{ width: "80px", height: "38px" }}
              />
            </div>
            <div style={{ display: "flex", alignItems: "center", gap: "5px" }}>
              <label className="mb-0 small">Height (mm):</label>
              <input
                type="number"
                min="10"
                max="300"
                step="0.1"
                value={customHeight}
                onChange={(e) => setCustomHeight(parseFloat(e.target.value) || 38.1)}
                className="form-control"
                style={{ width: "80px", height: "38px" }}
              />
            </div>
          </>
        )}

        <button
          onClick={generateBarcodes}
          className="btn btn-primary"
          style={{ height: "38px" }}
          disabled={loading || products.length === 0 || productIds.length === 0}
        >
          {loading ? "Generating..." : `Generate (${productIds.length})`}
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
          {/* <p className="text-muted small mt-2 mb-0">
            {(() => {
              const size = getSelectedPaperSize();
              const widthInch = (size.width / 25.4).toFixed(2);
              const heightInch = (size.height / 25.4).toFixed(2);
              return `Thermal printer: set paper size to ${widthInch}" × ${heightInch}" (${size.width}mm × ${size.height}mm) and turn off Headers and footers in the print dialog.`;
            })()}
          </p> */}
        </div>
      )}

      <style dangerouslySetInnerHTML={{
        __html: (() => {
          const size = getSelectedPaperSize();
          return `
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

      .mode-text-only {
        @page {
          size: 50.8mm 12.7mm;
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

      .mode-text-only .barcode-label-print {
        height: 18.7mm !important;
      }

      .barcode-label-print:last-child {
        page-break-after: auto !important;
        break-after: auto !important;
      }

      .barcode-label-print .product-name {
        font-size: 10pt !important;
        font-weight: bold !important;
        margin: 0 0 2mm 0 !important;
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
        letter-spacing: 2mm !important;
        font-weight: bold !important;
      }

      .barcode-label-print .price-info {
        font-size: 9pt !important;
        width: 100% !important;
        border-top: 1px solid #000 !important;
        padding-top: 1.5mm !important;
        margin-top: 2mm !important;
        display: flex !important;
        justify-content: space-between !important;
        font-weight: bold !important;
      }
    }
  `;
        })()
      }} />

    </div>
  );
};

export default BarcodeBulkGenerate;
