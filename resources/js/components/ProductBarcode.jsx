import React from 'react';

const ProductBarcode = ({ code }) => {
    const printBarcode = () => {
        const printWindow = window.open('', '_blank');
        const barcodeUrl = `/admin/product/barcode/generate?code=${code}`;

        printWindow.document.write(`
            <html>
                <head>
                    <title>Print Barcode - ${code}</title>
                    <style>
                        @page { size: 50.8mm 38.1mm; margin: 0; }
                        body { 
                            margin: 0; 
                            display: flex; 
                            flex-direction: column;
                            align-items: center; 
                            justify-content: center; 
                            height: 38.1mm;
                            width: 50.8mm;
                            text-align: center;
                            font-family: sans-serif;
                        }
                        img { 
                            width: 100%; 
                            max-height: 20mm; 
                            object-fit: contain;
                            image-rendering: pixelated;
                        }
                        .text {
                            font-size: 10pt;
                            font-weight: bold;
                            margin-top: 2mm;
                            letter-spacing: 1mm;
                        }
                    </style>
                </head>
                <body>
                    <img src="${barcodeUrl}" onload="window.print(); window.close();" />
                    <div class="text">${code}</div>
                </body>
            </html>
        `);
        printWindow.document.close();
    };

    const barcodeUrl = `/admin/product/barcode/generate?code=${code}`;

    return (
        <div className="barcode-container p-3 border rounded bg-light text-center">
            <div className="mb-3">
                <img
                    src={barcodeUrl}
                    alt={code}
                    className="img-fluid"
                    style={{ maxHeight: '100px', imageRendering: 'pixelated' }}
                />
                <div className="mt-2 font-weight-bold" style={{ letterSpacing: '2px' }}>{code}</div>
            </div>
            <div className="d-flex justify-content-center gap-2">
                <button
                    onClick={printBarcode}
                    className="btn btn-primary"
                >
                    <i className="fas fa-print mr-1"></i> Print Barcode
                </button>
            </div>
        </div>
    );
};

export default ProductBarcode;