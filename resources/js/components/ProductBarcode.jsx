import React from 'react';

const ProductBarcode = ({ code, mrp, price }) => {
    const printBarcode = () => {
        const printWindow = window.open('', '_blank');
        const barcodeUrl = `/admin/product/barcode/generate?code=${code}&mrp=${mrp}&price=${price}`;

        printWindow.document.write(`
            <html>
                <head>
                    <title>Print Barcode - ${code}</title>
                    <style>
                        @page { size: 50.8mm 38.1mm; margin: 0; }
                        body { 
                            margin: 0; 
                            display: flex; 
                            align-items: center; 
                            justify-content: center; 
                            height: 38.1mm;
                            width: 50.8mm;
                        }
                        img { 
                            width: 100%; 
                            height: 100%;
                            object-fit: contain;
                            image-rendering: pixelated;
                        }
                    </style>
                </head>
                <body>
                    <img src="${barcodeUrl}" onload="window.print(); window.close();" />
                </body>
            </html>
        `);
        printWindow.document.close();
    };

    const barcodeUrl = `/admin/product/barcode/generate?code=${code}&mrp=${mrp}&price=${price}`;

    return (
        <div className="barcode-container p-3 border rounded bg-light text-center">
            <div className="mb-3">
                <img
                    src={barcodeUrl}
                    alt={code}
                    className="img-fluid"
                    style={{ maxHeight: '150px', imageRendering: 'pixelated' }}
                />
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