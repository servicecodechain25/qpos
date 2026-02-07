import React, { useCallback, useEffect, useState } from "react";
import Suppliers from "./Suppliers";
import axios from "axios";
import Swal from "sweetalert2";
import toast, { Toaster } from "react-hot-toast";
import DatePicker from "react-datepicker";
import "react-datepicker/dist/react-datepicker.css";

export default function Purchase() {
    const [searchTerm, setSearchTerm] = useState("");
    const [barcode, setBarcode] = useState("");
    const [selectedSupplier, setSelectedSupplier] = useState({
        value: 1,
        label: "Own Supplier",
    });
    const [purchaseId, setPurchaseId] = useState(null);
    const [date, setDate] = useState(null);
    const [supplierId, setSupplierId] = useState(null);
    const [tax, setTax] = useState(0);
    const [discount, setDiscount] = useState(0);
    const [shipping, setShipping] = useState(0);
    const [products, setProducts] = useState([]);
    const [searchResults, setSearchResults] = useState([]);
    useEffect(() => {
        const searchParams = new URLSearchParams(window.location.search);
        const barcodeParam = searchParams.get("barcode");
        const purchase_id = searchParams.get("purchase_id");
        if (barcodeParam) {
            setSearchTerm(barcodeParam);
            setBarcode(barcodeParam);
        }
        if (purchase_id) {
            setPurchaseId(purchase_id);
        }
    }, []);
    useEffect(() => {
        if (barcode) {
            getProducts();
        }
    }, [barcode]);
    useEffect(() => {
        if (purchaseId) {
            getPurchaseProducts();
        }
    }, [purchaseId]);
    const getPurchaseProducts = useCallback(async () => {
        try {
            const res = await axios.get(`/admin/purchase/${purchaseId}`);
            const purchaseData = res.data;
            const purchaseProducts = purchaseData?.items?.map((item) => ({
                item_id: item.id,
                id: item.product_id,
                name: item.name,
                price: item.price,
                purchase_price: item.purchase_price,
                stock: item.stock,
                qty: item.quantity,
                sku: item.sku,
                subTotal: item.purchase_price * item.quantity,
                uid: `${item.product_id}-${Math.random().toString(36).substr(2, 9)}`,
            }));
            setProducts(purchaseProducts);
            setDate(purchaseData?.date ? new Date(purchaseData.date) : null);
            setSelectedSupplier({
                value: purchaseData?.supplier_id,
                label: purchaseData?.supplier?.name,
            });
            setTax(purchaseData?.tax);
            setDiscount(purchaseData?.discount_value);
            setShipping(purchaseData?.shipping);
        } catch (error) {
            console.error("Error fetching products:", error);
        } finally {
        }
    }, [purchaseId]);

    const getProducts = useCallback(async () => {
        if (!searchTerm.trim()) {
            console.log("Search term is empty");
            return;
        }

        // Optional: Uncomment if you want to show loading state
        // setLoading(true);

        try {
            const res = await axios.get("/admin/products", {
                params: { search: searchTerm },
            });

            const productsData = res.data;

            // Ensure productsData and productsData.data exist
            if (productsData?.data && productsData.data.length) {
                productsData.data.forEach((product) => {
                    // All products are now added as new entries to allow different prices
                    const newProduct = {
                        id: product.id,
                        uid: `${product.id}-${Math.random().toString(36).substr(2, 9)}`,
                        name: product.name,
                        price: product.price,
                        purchase_price: product.purchase_price,
                        stock: product.quantity,
                        qty: 1,
                        sku: product.sku,
                        subTotal: product.purchase_price,
                    };
                    setProducts((prevProducts) => [
                        ...prevProducts,
                        newProduct,
                    ]);
                });
            }
        } catch (error) {
            console.error("Error fetching products:", error);
        } finally {
            // Optional: Uncomment if you want to hide loading state
            // setLoading(false);

            // Clear searchTerm if needed
            setSearchTerm("");
        }
    }, [searchTerm]); // Don't forget to add searchTerm as a dependency

    // Handle deletion of a product using unique identifier
    const handleDelete = (uid) => {
        setProducts(products.filter((product) => product.uid !== uid));
    };

    // Update quantity and recalculate subtotal using unique identifier
    const handleQtyChange = (uid, value) => {
        const updatedProducts = products.map((product) => {
            if (product.uid === uid) {
                const newQty = parseInt(value) || 0;
                return {
                    ...product,
                    qty: newQty,
                    subTotal: parseFloat(
                        (product.purchase_price * newQty).toFixed(2)
                    ),
                };
            }
            return product;
        });
        setProducts(updatedProducts);
    };

    // Update purchase price and recalculate subtotal using unique identifier
    const handlePriceChange = (uid, value) => {
        const updatedProducts = products.map((product) => {
            if (product.uid === uid) {
                const newPrice = parseFloat(value) || 0;
                return {
                    ...product,
                    purchase_price: newPrice,
                    subTotal: parseFloat((product.qty * newPrice).toFixed(2)),
                };
            }
            return product;
        });
        setProducts(updatedProducts);
    };

    const handlePrintLabel = async (product, mode = 'barcode') => {
        try {
            const res = await axios.post("/admin/product/barcode/bulkGenerate", {
                product_id: product.id,
                quantity: 1,
            });
            const barcodeData = res.data[0];

            const printControl = `
                <html>
                    <head>
                        <title>Print ${mode === 'barcode' ? 'Barcode' : 'Label'}</title>
                        <style>
                            /* 1.5" x 2" label paper: 38.1mm x 50.8mm */
                            @page { size: 38.1mm 50.8mm; margin: 0; }
                            body { margin: 0; padding: 0; display: flex; justify-content: center; align-items: center; height: 50.8mm; width: 38.1mm; font-family: sans-serif; }
                            .label {
                                width: 38.1mm;
                                height: 50.8mm;
                                padding: 2mm;
                                box-sizing: border-box;
                                text-align: center;
                                display: flex;
                                flex-direction: column;
                                justify-content: center;
                                align-items: center;
                            }
                            .name { font-size: 9px; font-weight: bold; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; width: 100%; margin-bottom: 2px; }
                            img { width: auto; max-width: 34mm; max-height: ${mode === 'barcode' ? '24mm' : '0'}; object-fit: contain; display: ${mode === 'barcode' ? 'block' : 'none'}; }
                            .sku { font-size: 8px; margin: 2px 0; font-weight: bold; }
                            .prices { width: 100%; display: ${mode === 'label' ? 'flex' : 'none'}; justify-content: space-between; font-size: 8px; font-weight: bold; border-top: 1px dashed black; padding-top: 2px; }
                        </style>
                    </head>
                    <body>
                        <div class="label">
                            <div class="name">${product.name}</div>
                            <img src="${barcodeData.img}" />
                            <div class="sku">${barcodeData.value}</div>
                            <div class="prices">
                                <span>MRP: ${barcodeData.purchase_price}</span>
                                <span>C Price: ${barcodeData.price}</span>
                            </div>
                        </div>
                        <script>
                            window.onload = () => {
                                window.print();
                                setTimeout(() => window.close(), 500);
                            };
                        </script>
                    </body>
                </html>
            `;

            /* 1.5" x 2" aspect ratio for preview */
            const width = 285;
            const height = 380;
            const left = (window.screen.width - width) / 2;
            const top = (window.screen.height - height) / 2;
            const printWindow = window.open('', 'PrintLabel', `width=${width},height=${height},top=${top},left=${left},scrollbars=yes`);
            printWindow.document.write(printControl);
            printWindow.document.close();

        } catch (error) {
            console.error("Error printing:", error);
            toast.error("Failed to generate.");
        }
    };
    // Add a new product by searching
    const handleSearchAdd = () => {
        getProducts();
    };

    // Calculate totals with two decimal places
    const calculateTotals = () => {
        const subTotal = products.reduce(
            (sum, product) => sum + product.subTotal,
            0
        );
        const formattedSubTotal = parseFloat(subTotal.toFixed(2));
        const formattedTax = parseFloat((tax || 0).toFixed(2));
        const formattedDiscount = parseFloat((discount || 0).toFixed(2));
        const formattedShipping = parseFloat((shipping || 0).toFixed(2));
        const grandTotal = parseFloat(
            (
                formattedSubTotal +
                formattedTax -
                formattedDiscount +
                formattedShipping
            ).toFixed(2)
        );

        return {
            subTotal: formattedSubTotal,
            tax: formattedTax,
            discount: formattedDiscount,
            shipping: formattedShipping,
            grandTotal,
        };
    };

    const totals = calculateTotals();
    const handleSubmit = async () => {
        if (totals.grandTotal <= 0) {
            //    toast.error("Total must be greater than zero.");
            return;
        }
        if (!date) {
            toast.error("Please select purchase date.");
            return;
        }

        const formattedDate = date instanceof Date
            ? date.getFullYear() + '-' +
            String(date.getMonth() + 1).padStart(2, '0') + '-' +
            String(date.getDate()).padStart(2, '0')
            : date;

        if (!supplierId) {
            toast.error("Please select a supplier.");
            return;
        }

        // Show confirmation dialog
        Swal.fire({
            title: `Are you sure you want to save this purchase?`,
            showDenyButton: true,
            confirmButtonText: "Yes",
            denyButtonText: "No",
            customClass: {
                actions: "my-actions",
                cancelButton: "order-1 right-gap",
                confirmButton: "order-2",
                denyButton: "order-3",
            },
        }).then(async (result) => {
            if (result.isConfirmed) {
                //    console.log("data:", {
                //        products,
                //        supplierId,
                //        totals,
                //    }); return;
                try {
                    const res = await axios.post("/admin/purchase", {
                        purchase_id: purchaseId,
                        date: formattedDate,
                        products,
                        supplierId,
                        totals,
                    });
                    setProducts([]);
                    toast.success(res?.data?.message);
                    window.location.href = "/admin/purchase";
                } catch (err) {
                    toast.error(
                        err.response?.data?.message || "An error occurred"
                    );
                }
            }
        });
    };

    // product search
    useEffect(() => {
        // Define the asynchronous function
        async function getProducts() {
            if (!searchTerm.trim()) {
                setSearchResults([]);
                return;
            }

            try {
                const res = await axios.get("/admin/products", {
                    params: { search: searchTerm },
                });

                const productsData = res.data;
                setSearchResults(productsData?.data || []);
            } catch (error) {
                console.error("Error fetching products:", error);
            }
        }
        // Call the async function inside useEffect
        getProducts();
    }, [searchTerm]);
    // Handle adding selected product to the products list
    // Handle adding selected product to the products list
    const handleProductSelect = (product) => {
        // Add new product entry with a unique identifier to allow duplicates with different prices
        const newProduct = {
            id: product.id,
            uid: `${product.id}-${Math.random().toString(36).substr(2, 9)}`,
            name: product.name,
            price: product.price,
            purchase_price: product.purchase_price,
            stock: product.quantity,
            qty: 1,
            sku: product.sku,
            subTotal: product.purchase_price,
        };
        setProducts((prevProducts) => [...prevProducts, newProduct]);

        // Clear search term and results
        setSearchTerm("");
        setSearchResults([]);
    };
    return (
        <>
            <div className="container-fluid">
                <div className="card">
                    <div className="card-body">
                        <div className="row">
                            <div className="mb-3 col-md-6">
                                <label htmlFor="date" className="form-label">
                                    Purchase Date
                                    <span className="text-danger">*</span>
                                </label>
                                <div>
                                    <DatePicker
                                        name="date"
                                        className="form-control"
                                        placeholderText="Enter purchase date"
                                        selected={date instanceof Date ? date : (date ? new Date(date) : null)}
                                        dateFormat="yyyy-MM-dd"
                                        onChange={(date) => setDate(date)}
                                        portalId="datepicker-portal"
                                    />
                                </div>
                            </div>
                            <div className="mb-3 col-md-6">
                                <label
                                    htmlFor="supplier"
                                    className="form-label"
                                >
                                    Supplier
                                    <span className="text-danger">*</span>
                                </label>
                                <Suppliers
                                    setSupplierId={setSupplierId}
                                    oldSupplier={selectedSupplier}
                                />
                            </div>
                        </div>
                    </div>
                </div>
                <div className="card">
                    <div className="card-body">
                        <div className="row mb-2">
                            <div className="input-group col-6">
                                <div className="input-group-prepend">
                                    <span className="input-group-text">
                                        <i className="fas fa-search"></i>
                                    </span>
                                </div>
                                <input
                                    type="search"
                                    className="form-control form-control-lg"
                                    value={searchTerm}
                                    onChange={(e) =>
                                        setSearchTerm(e.target.value)
                                    }
                                    placeholder="Enter product barcode/name"
                                />
                                <button
                                    className="btn bg-gradient-primary ml-2"
                                    onClick={handleSearchAdd}
                                >
                                    Add Product
                                </button>
                            </div>
                        </div>
                        {/* Display search results below the input */}
                        {searchResults.length > 0 && (
                            <div className="row mb-2">
                                <div
                                    className="col-6"
                                    style={{
                                        maxHeight: "200px",
                                        overflowY: "auto",
                                    }}
                                >
                                    <ul className="list-group">
                                        {searchResults.map((product) => (
                                            <li
                                                key={product.id}
                                                className="list-group-item"
                                                onClick={() =>
                                                    handleProductSelect(product)
                                                }
                                                style={{ cursor: "pointer" }}
                                            >
                                                {product.name}
                                                {product.color ? ` - ${product.color}` : ""}
                                                {product.size ? ` - ${product.size}` : ""}
                                                - ${product.price}
                                            </li>
                                        ))}
                                    </ul>
                                </div>
                            </div>
                        )}
                        <div className="row">
                            <div className="col-12">
                                <table className="table table-sm table-bordered text-center">
                                    <thead>
                                        <tr>
                                            <th>#</th>
                                            <th>Product Name</th>
                                            <th>Purchase Price</th>
                                            <th>Current Stock</th>
                                            <th>Qty</th>
                                            <th>Sub Total</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        {products.map((product, index) => (
                                            <tr key={product.uid}>
                                                <td>{index + 1}</td>
                                                <td>{product.name}</td>
                                                <td className="d-flex align-items-center justify-content-center">
                                                    <input
                                                        type="number"
                                                        min="1"
                                                        className="form-control w-50"
                                                        value={
                                                            product.purchase_price
                                                        }
                                                        onChange={(e) =>
                                                            handlePriceChange(
                                                                product.uid,
                                                                e.target.value
                                                            )
                                                        }
                                                    />
                                                </td>
                                                <td>{product.stock}</td>
                                                <td className="d-flex align-items-center justify-content-center">
                                                    <input
                                                        type="number"
                                                        min="1"
                                                        className="form-control w-50"
                                                        value={product.qty}
                                                        onChange={(e) =>
                                                            handleQtyChange(
                                                                product.uid,
                                                                e.target.value
                                                            )
                                                        }
                                                    />
                                                </td>
                                                <td>
                                                    {product.subTotal.toFixed(
                                                        2
                                                    )}
                                                </td>
                                                <td>
                                                    <button
                                                        className="btn btn-info btn-xs mr-1"
                                                        onClick={() =>
                                                            handlePrintLabel(
                                                                product,
                                                                'barcode'
                                                            )
                                                        }
                                                        type="button"
                                                        title="Print Barcode"
                                                    >
                                                        Barcode
                                                    </button>
                                                    <button
                                                        className="btn btn-success btn-xs mr-1"
                                                        onClick={() =>
                                                            handlePrintLabel(
                                                                product,
                                                                'label'
                                                            )
                                                        }
                                                        type="button"
                                                        title="Print Label"
                                                    >
                                                        Label
                                                    </button>
                                                    <button
                                                        className="btn btn-danger btn-xs"
                                                        onClick={() =>
                                                            handleDelete(
                                                                product.uid
                                                            )
                                                        }
                                                        type="button"
                                                        title="Delete"
                                                    >
                                                        Delete
                                                    </button>
                                                </td>
                                            </tr>
                                        ))}
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <div className="row">
                            <div className="col-6"></div>
                            <div className="col-6">
                                <div className="table-responsive">
                                    <table className="table table-sm">
                                        <tbody>
                                            <tr>
                                                <th>Subtotal:</th>
                                                <td className="text-right">
                                                    {totals.subTotal.toFixed(2)}
                                                </td>
                                            </tr>
                                            <tr>
                                                <th>Tax:</th>
                                                <td className="text-right">
                                                    {totals.tax.toFixed(2)}
                                                </td>
                                            </tr>
                                            <tr>
                                                <th>Discount:</th>
                                                <td className="text-right">
                                                    {totals.discount.toFixed(2)}
                                                </td>
                                            </tr>
                                            <tr>
                                                <th>Shipping:</th>
                                                <td className="text-right">
                                                    {totals.shipping.toFixed(2)}
                                                </td>
                                            </tr>
                                            <tr>
                                                <th>Grand Total:</th>
                                                <td className="text-right">
                                                    {totals.grandTotal.toFixed(
                                                        2
                                                    )}
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div className="card">
                    <div className="card-body">
                        <div className="row">
                            <div className="mb-3 col-md-4">
                                <label htmlFor="tax" className="form-label">
                                    Tax
                                </label>
                                <input
                                    type="number"
                                    className="form-control"
                                    value={tax}
                                    min="0"
                                    onChange={(e) =>
                                        setTax(parseFloat(e.target.value) || 0)
                                    }
                                    placeholder="Enter tax"
                                    name="tax"
                                    required
                                />
                            </div>
                            <div className="mb-3 col-md-4">
                                <label
                                    htmlFor="discount"
                                    className="form-label"
                                >
                                    Discount
                                </label>
                                <input
                                    type="number"
                                    min="0"
                                    className="form-control"
                                    value={discount}
                                    onChange={(e) =>
                                        setDiscount(
                                            parseFloat(e.target.value) || 0
                                        )
                                    }
                                    placeholder="Enter discount"
                                    name="discount"
                                    required
                                />
                            </div>
                            <div className="mb-3 col-md-4">
                                <label
                                    htmlFor="shipping"
                                    className="form-label"
                                >
                                    Shipping Charge
                                </label>
                                <input
                                    type="number"
                                    min="0"
                                    className="form-control"
                                    value={shipping}
                                    onChange={(e) =>
                                        setShipping(
                                            parseFloat(e.target.value) || 0
                                        )
                                    }
                                    placeholder="Enter shipping"
                                    name="shipping"
                                    required
                                />
                            </div>
                        </div>
                    </div>
                </div>
                <button
                    type="submit"
                    className="btn btn-md bg-gradient-primary"
                    onClick={handleSubmit}
                >
                    Create
                </button>
            </div >

            <Toaster position="top-right" reverseOrder={false} />
        </>
    );
}
