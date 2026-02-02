// import './bootstrap';
import React from 'react'
import Pos from "./components/Pos";
import Purchase from './components/Purchase/Purchase';
import ProductBarcode from './components/ProductBarcode';
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
    const barcodeCode = document.getElementById("product-barcode").getAttribute('data-code');
    const barcodeRoot = createRoot(document.getElementById("product-barcode"));
    barcodeRoot.render(<ProductBarcode code={barcodeCode} />);
}

