import React, { useRef, useEffect } from 'react';
import Barcode from 'react-barcode';
import jsPDF from 'jspdf';
import html2canvas from 'html2canvas';

const ProductBarcode = ({ code, format = 'CODE128' }) => {
    const barcodeRef = useRef(null);
console.log("barcodeRef",barcodeRef);
console.log("code",code);

    const printBarcode = () => {
        const printWindow = window.open('', '_blank');
        printWindow.document.write(`
            <html>
                <head>
                    <title>Barcode</title>
                    <style>
                        body { text-align: center; margin: 20px; }
                        svg { max-width: 100%; height: auto; }
                    </style>
                </head>
                <body>
                    <h2>Product Barcode</h2>
                    <div>${barcodeRef.current.innerHTML}</div>
                </body>
            </html>
        `);
        printWindow.document.close();
        printWindow.print();
    };

    const downloadPDF = async () => {
        if (barcodeRef.current) {
            const canvas = await html2canvas(barcodeRef.current);
            const imgData = canvas.toDataURL('image/png');
            const doc = new jsPDF();
            doc.addImage(imgData, 'PNG', 10, 10, 180, 60);
            doc.text(`Product SKU: ${code}`, 10, 80);
            doc.save(`barcode-${code}.pdf`);
        }
    };

    return (
        <div className="barcode-container">
            <div ref={barcodeRef} style={{ padding: '20px', background: 'white' }}>
                <Barcode value={code} format={format} />
            </div>
            <div className="mt-2">
                <button
                    onClick={printBarcode}
                    className="btn btn-sm btn-primary mr-2"
                >
                    Print Barcode
                </button>
                <button
                    onClick={downloadPDF}
                    className="btn btn-sm btn-success"
                >
                    Download PDF
                </button>
            </div>
        </div>
    );
};

export default ProductBarcode;