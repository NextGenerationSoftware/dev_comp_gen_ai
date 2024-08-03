'use client'
import { useState, useEffect } from 'react';
import { getCollectionData } from "@/lib/utils";

export default function Categories() {
    const [data, setData] = useState([]);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState(null);

    useEffect(() => {
        async function fetchData() {
            try {
                const data = await getCollectionData('DATAREQUIRED');
                const countDatataken = await getCollectionData('DATATAKEN');
                // count the number of items of each datarequired id in datataken 
                data.forEach((category) => {
                    category.count = countDatataken.filter((item) => item.datarequired === category.id).length;
                });
                setData(data);
            } catch (error) {
                setError(error);
            } finally {
                setLoading(false);
            }
        }

        fetchData();
    }, []);

    if (loading) return <div>Loading...</div>;
    if (error) return <div>Error: {error.message}</div>;

    return (
        <div className="mx-auto grid max-w-5xl items-start gap-6 py-12 lg:grid-cols-3 lg:gap-12">
            {data.map((category) => (
                <div
                    key={category.id}
                    className="group rounded-lg border bg-background p-6 transition-all hover:bg-accent hover:text-accent-foreground"
                >
                    <div className="flex items-center justify-between">
                        <h3 className="text-xl font-bold">{category.title}</h3>
                        <span className="rounded-full bg-muted px-3 py-1 text-sm font-medium text-muted-foreground">
                            {category.count}
                        </span>
                    </div>
                    <p className="mt-2 text-muted-foreground">{category.description}</p>
                </div>
            ))}
        </div>
    );
}
