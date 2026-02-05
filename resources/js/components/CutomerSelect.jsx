import React, { useState, useEffect } from "react";
import CreatableSelect from "react-select/creatable";
import axios from "axios";
import Swal from "sweetalert2";

const CustomerSelect = ({ setCustomerId, setGuestPhone }) => {
    const [customers, setCustomers] = useState([]);
    const [selectedCustomer, setSelectedCustomer] = useState({ value: 1, label: "Walking Customer" });

    // Fetch existing customers from the backend
    useEffect(() => {
        axios.get("/admin/get/customers").then((response) => {
            const customerOptions = response?.data?.map((customer) => ({
                value: customer.id,
                label: `${customer.name} - ${customer.phone || 'N/A'}`,
                phone: customer.phone // Add phone here
            }));
            setCustomers(customerOptions);
        });
    }, []);
    useEffect(() => {
        setCustomerId(selectedCustomer?.value);
    }, [selectedCustomer]);

    const handleCreateCustomer = async (inputValue) => {
        const { value: phone } = await Swal.fire({
            title: "Enter Phone Number",
            input: "text",
            inputLabel: "Phone Number",
            inputPlaceholder: "Enter customer phone number",
            showCancelButton: true,
            inputValidator: (value) => {
                if (!value) {
                    return "You need to write something!";
                }
            },
        });

        if (phone) {
            axios
                .post("/admin/create/customers", { name: inputValue, phone: phone })
                .then((response) => {
                    const newCustomer = response.data;
                    const newOption = {
                        value: newCustomer.id,
                        label: `${newCustomer.name} - ${newCustomer.phone}`,
                        phone: newCustomer.phone // Add phone here
                    };
                    setCustomers((prev) => [newOption, ...prev]);
                    setSelectedCustomer(newOption);
                    setGuestPhone(newCustomer.phone); // Auto fill on creation
                })
                .catch((error) => {
                    console.error("Error creating customer:", error);
                    // Optionally handle validation errors from backend
                    if (error.response && error.response.data && error.response.data.message) {
                        Swal.fire("Error", error.response.data.message, "error");
                    }
                });
        }
    };

    const handleChange = (newValue) => {
        setSelectedCustomer(newValue);
        // Extract phone number from label "Name - Phone" logic or fetch it.
        // Since label is constructed as "Name - Phone", we can try to parse it or better yet, store phone in the option object.
        // Let's modify the option construction first. To avoid breaking things, I'll stick to basic implementation and improve option object.
        if (newValue && newValue.phone) {
            setGuestPhone(newValue.phone);
        } else {
            setGuestPhone("");
        }
    };

    return (
        <CreatableSelect
            isClearable
            options={customers}
            onChange={handleChange}
            onCreateOption={handleCreateCustomer} // Handle creating a new customer
            value={selectedCustomer}
            placeholder="Select or create customer"
        />
    );
};

export default CustomerSelect;
