// import './bootstrap';
import React from 'react'
import Pos from "./components/Pos";
import Purchase from './components/Purchase/Purchase';
import ProductBarcode from './components/ProductBarcode';
import BarcodeBulkGenerate from "./components/BarcodeBulkGenerate";
import "../css/app.css";
import { createRoot } from 'react-dom/client';
// export default function app() {
//   return (
//     <Pos />
//   )
// }
// Check for the 'cart' element and render the 'cart' component using createRoot
if (document.getElementById("cart")) {
    const cartRoot = createRoot(document.getElementById("cart"));
    cartRoot.render(<Pos />);
}

// Check for the 'purchase' element and render the 'Purchase' component using createRoot
if (document.getElementById("purchase")) {
    const purchaseRoot = createRoot(
        document.getElementById("purchase")
    );
    purchaseRoot.render(<Purchase />);
}

// Check for the 'product-barcode' element and render the ProductBarcode component
if (document.getElementById("product-barcode")) {
    const el = document.getElementById("product-barcode");
    const barcodeCode = el.getAttribute('data-code');
    const mrp = el.getAttribute('data-mrp');
    const price = el.getAttribute('data-price');
    const barcodeRoot = createRoot(el);
    barcodeRoot.render(<ProductBarcode code={barcodeCode} mrp={mrp} price={price} />);
}

if (document.getElementById("barcode-bulk-generator")) {
    const barcodeRoot = createRoot(document.getElementById("barcode-bulk-generator"));
    barcodeRoot.render(<BarcodeBulkGenerate />);
}