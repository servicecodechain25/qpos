import React, { useState, useEffect, useRef } from 'react';
import { BrowserMultiFormatReader } from '@zxing/library';
import axios from 'axios';
import toast from 'react-hot-toast';

const ScanToCart = ({ onScanSuccess }) => {
    const [scanning, setScanning] = useState(false);
    const [manualBarcode, setManualBarcode] = useState('');
    const videoRef = useRef(null);
    const codeReader = useRef(new BrowserMultiFormatReader());

    const startScanning = async () => {
        setScanning(true);
        try {
            const result = await codeReader.current.decodeOnceFromVideoDevice(undefined, videoRef.current);
            if (result) {
                handleScan(result.text);
            }
        } catch (err) {
            console.error('Scanning error:', err);
            toast.error('Scanning failed');
        } finally {
            setScanning(false);
        }
    };

    const stopScanning = () => {
        codeReader.current.reset();
        setScanning(false);
    };

    const handleScan = async (barcode) => {
        try {
            const response = await axios.get(`/admin/products/barcode/${barcode}`);
            const product = response.data.data;
            // Add to cart logic
            await axios.post('/admin/cart', { id: product.id });
            toast.success(`${product.name} added to cart`);
            if (onScanSuccess) onScanSuccess();
        } catch (error) {
            console.error('Error adding product:', error);
            toast.error('Product not found or out of stock');
        }
    };

    const handleManualSubmit = (e) => {
        e.preventDefault();
        if (manualBarcode.trim()) {
            handleScan(manualBarcode.trim());
            setManualBarcode('');
        }
    };

    useEffect(() => {
        return () => {
            codeReader.current.reset();
        };
    }, []);

    return (
        <div className="scan-to-cart">
            <h5>Barcode Scanner</h5>
            <div className="mb-3">
                <video
                    ref={videoRef}
                    style={{ width: '100%', maxWidth: '300px', display: scanning ? 'block' : 'none' }}
                />
                {!scanning ? (
                    <button
                        onClick={startScanning}
                        className="btn btn-primary"
                        disabled={scanning}
                    >
                        Start Scanning
                    </button>
                ) : (
                    <button
                        onClick={stopScanning}
                        className="btn btn-secondary"
                    >
                        Stop Scanning
                    </button>
                )}
            </div>
            <form onSubmit={handleManualSubmit} className="mb-3">
                <div className="input-group">
                    <input
                        type="text"
                        className="form-control"
                        placeholder="Enter barcode manually"
                        value={manualBarcode}
                        onChange={(e) => setManualBarcode(e.target.value)}
                    />
                    <button type="submit" className="btn btn-outline-primary">
                        Add
                    </button>
                </div>
            </form>
        </div>
    );
};

export default ScanToCart;