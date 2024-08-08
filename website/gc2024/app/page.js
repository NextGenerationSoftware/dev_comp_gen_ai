import Link from "next/link";
import Image from "next/image";
import Categories from "@/components/categories";

export default function Home() {
  return (
    <main className="flex min-h-screen flex-col items-center justify-between p-24">
      <div className="flex flex-col min-h-[100dvh]">
        <header className="px-4 lg:px-6 h-14 flex items-center">
          <Link href="#" className="flex items-center justify-center" prefetch={false}>
            <Image src="/crowddata_logo.png" width={120} height={120} className="rounded-xl"/>
            <span className="sr-only">Crowddata</span>
          </Link>
          <nav className="ml-auto flex gap-4 sm:gap-6">
            <Link
              href="#purpose"
              className="text-sm font-medium hover:underline underline-offset-4"
              prefetch={false}>
              Categories
            </Link>
            <Link
              href="#purpose"
              className="text-sm font-medium hover:underline underline-offset-4"
              prefetch={false}>
              Purpose
            </Link>
            <Link
              href="#achievements"
              className="text-sm font-medium hover:underline underline-offset-4"
              prefetch={false}>
              Achievements
            </Link>
            <Link
              href="mailto:hallo@patrickgerard.de"
              className="text-sm font-medium hover:underline underline-offset-4"
              prefetch={false}>
              Contact
            </Link>
          </nav>
        </header>
        <div className="flex-1">
          <section className="w-full py-12 md:py-24 lg:py-32">
            <div className="container px-4 md:px-6">
              <div
                className="grid gap-6 lg:grid-cols-[1fr_400px] lg:gap-12 xl:grid-cols-[1fr_600px]">
                <div className="flex flex-col justify-center space-y-4">
                  <div className="space-y-2">
                    <h1
                      className="text-3xl font-bold tracking-tighter sm:text-5xl xl:text-6xl/none">
                      Discover the Power of Open-Source for AI Training
                    </h1>
                    <p className="max-w-[600px] text-muted-foreground md:text-xl">
                      Our open-source data platform offers a wide range of categories to explore and discover datasets that can be used to fine-tune and train AI models.
                    </p>
                  </div>
                  <div className="flex flex-col gap-2 min-[400px]:flex-row">
                    <Link
                      href="#categories"
                      className="inline-flex h-10 items-center justify-center rounded-md bg-primary px-8 text-sm font-medium text-primary-foreground shadow transition-colors hover:bg-primary/90 focus-visible:outline-none focus-visible:ring-1 focus-visible:ring-ring disabled:pointer-events-none disabled:opacity-50"
                      prefetch={false}>
                      Explore Categories
                    </Link>
                    <Link
                      href="#categories"
                      className="inline-flex h-10 items-center justify-center rounded-md bg-primary px-8 text-sm font-medium text-primary-foreground shadow transition-colors hover:bg-primary/90 focus-visible:outline-none focus-visible:ring-1 focus-visible:ring-ring disabled:pointer-events-none disabled:opacity-50"
                      prefetch={false}>
                      Download App
                    </Link>
                  </div>
                </div>
                <div className="relative w-full pb-[56.25%] h-0 overflow-hidden">
                  <iframe className="absolute top-0 left-0 w-full h-full border-0" src="https://www.youtube.com/embed/DkG0Tzb41sI?si=-pQpqThZo_7ifgGB" title="YouTube video player" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerPolicy="strict-origin-when-cross-origin" allowFullScreen></iframe>
                </div>
              </div>
            </div>
          </section>
          <section id="categories" className="w-full py-12 md:py-24 lg:py-32 bg-muted">
            <div className="container px-4 md:px-6">
              <div
                className="flex flex-col items-center justify-center space-y-4 text-center">
                <div className="space-y-2">
                  <div className="inline-block rounded-lg bg-muted px-3 py-1 text-sm">Categories</div>
                  <h2 className="text-3xl font-bold tracking-tighter sm:text-5xl">
                    Explore Our Open-Source Categories for AI Training
                  </h2>
                  <p
                    className="max-w-[600px] text-muted-foreground md:text-xl/relaxed lg:text-base/relaxed xl:text-xl/relaxed">
                    Browse through our datasets.
                  </p>
                </div>
              </div>
              <Categories/>
            </div>
          </section>
          <section className="w-full py-12 md:py-24 lg:py-32">
            <div className="container px-4 md:px-6">
              <div
                className="flex flex-col items-center justify-center space-y-4 text-center">
                <div className="space-y-2">
                  <div className="inline-block rounded-lg bg-muted px-3 py-1 text-sm" id="purpose">Purpose</div>
                  <h2 className="text-3xl font-bold tracking-tighter sm:text-5xl">
                    Discover the Power of Open-Source for AI Training
                  </h2><br/>
                  <p className="max-w-[1000px] text-muted-foreground md:text-xl/relaxed lg:text-base/relaxed xl:text-xl/relaxed">
                  Our open-source app is crafted to empower developers and companies to advance the world through AI. We address the challenge of finding quality and accessible datasets by allowing users to easily contribute to open-source datasets.
                  <br /><br />
                  You can upload files, take pictures, and engage in activities like planting trees or providing medical datasets to make a positive environmental impact. Additionally, you can earn rewards for contributing to sponsored datasets, enabling you to support meaningful projects while enhancing AI capabilities.
                </p>
  
                </div>
                <div
                  className="grid max-w-5xl items-center gap-6 py-12 lg:grid-cols-2 lg:gap-12">
                  <img
                    src="/crowddata_tech.png"
                    width="550"
                    height="310"
                    alt="Image"
                    className="mx-auto aspect-video overflow-hidden rounded-xl object-cover object-center sm:w-full lg:order-last" />
                  <div className="flex flex-col justify-center space-y-4">
                    <ul className="grid gap-6">
                      <li>
                        <div className="grid gap-1">
                          <h3 className="text-xl font-bold">Discover new Datasets for AI Training</h3>
                          <p className="text-muted-foreground">
                            Explore a vast collection of open-source datasets across various
                            categories that can be used to fine-tune and train AI models.
                          </p>
                        </div>
                      </li>
                      <li>
                        <div className="grid gap-1">
                          <h3 className="text-xl font-bold">Contribute to the Community</h3>
                          <p className="text-muted-foreground">
                            Join the open-source community and contribute to the projects you find interesting,
                            helping to advance the field of AI.
                          </p>
                        </div>
                      </li>
                      <li>
                        <div className="grid gap-1">
                          <h3 className="text-xl font-bold">Use our Datasets and enhance the world</h3>
                          <p className="text-muted-foreground">
                            By using our datasets, you can enhance your AI models and contribute to projects that make a positive impact on the world.
                          </p>
                        </div>
                      </li>
                    </ul>
                  </div>
                </div>
              </div>
            </div>
          </section>
          <section className="w-full py-12 md:py-24 lg:py-32 bg-muted">
            <div className="container px-4 md:px-6">
              <div className="flex flex-col items-center justify-center space-y-4 text-center">
                <div className="space-y-2">
                  <div className="inline-block rounded-lg bg-muted px-3 py-1 text-sm" id="achievements">Achievements</div>
                  <h2 className="text-3xl font-bold tracking-tighter sm:text-5xl">What We've Accomplished</h2>
                  <p className="max-w-[600px] text-muted-foreground md:text-xl/relaxed lg:text-base/relaxed xl:text-xl/relaxed">
                    Check out some of the amazing things we've been able to achieve with the help of our open-source
                    community.
                  </p>
                </div>
                <div className="mx-auto grid max-w-5xl items-center gap-6 py-12 lg:grid-cols-3 lg:gap-12">
                  <div className="rounded-lg border bg-background p-6">
                    <div className="flex items-center justify-center gap-4">
                      <div className="bg-muted rounded-md flex items-center justify-center aspect-square w-12">
                        <HeartIcon className="w-6 h-6 text-primary" />
                      </div>
                      <div>
                        <h4 className="text-lg font-medium">Saved Lives</h4>
                        <p className="text-muted-foreground">
                        With your help, CrowdData has contributed to open source tools used to develop medical AI applications.
                        </p>
                        <div className="text-lg font-bold"></div>
                      </div>
                    </div>
                  </div>
                  <div className="rounded-lg border bg-background p-6">
                    <div className="flex items-center justify-center gap-4">
                      <div className="bg-muted rounded-md flex items-center justify-center aspect-square w-12">
                        <TreesIcon className="w-6 h-6 text-primary" />
                      </div>
                      <div>
                        <h4 className="text-lg font-medium">Planted Trees</h4>
                        <p className="text-muted-foreground">
                          CrowdData planted many trees in exchange for contributions to environmental datasets.
                        </p>
                        <div className="text-lg font-bold"></div>
                      </div>
                    </div>
                  </div>
                  <div className="rounded-lg border bg-background p-6">
                    <div className="flex items-center justify-center gap-4">
                      <div className="bg-muted rounded-md flex items-center justify-center aspect-square w-12">
                        <DollarSignIcon className="w-6 h-6 text-primary" />
                      </div>
                      <div>
                        <h4 className="text-lg font-medium">Paid Out Money</h4>
                        <p className="text-muted-foreground">
                          CrowdData paid out money to contributors for their contributions for private datasets of sponsors.
                        </p>
                        <div className="text-lg font-bold"></div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </section>
        </div>
        <footer
          className="flex flex-col gap-2 sm:flex-row py-6 w-full shrink-0 items-center px-4 md:px-6 border-t">
          <p className="text-xs text-muted-foreground">&copy; 2024 CrowdData. All rights reserved.</p>
          <nav className="sm:ml-auto flex gap-4 sm:gap-6">
            <Link
              href="#"
              className="text-xs hover:underline underline-offset-4"
              prefetch={false}>
              Terms of Service
            </Link>
            <Link
              href="#"
              className="text-xs hover:underline underline-offset-4"
              prefetch={false}>
              Privacy
            </Link>
          </nav>
        </footer>
      </div>
    </main>
  );
}

function DollarSignIcon(props) {
  return (
    <svg
      {...props}
      xmlns="http://www.w3.org/2000/svg"
      width="24"
      height="24"
      viewBox="0 0 24 24"
      fill="none"
      stroke="currentColor"
      strokeWidth="2"
      strokeLinecap="round"
      strokeLinejoin="round"
    >
      <line x1="12" x2="12" y1="2" y2="22" />
      <path d="M17 5H9.5a3.5 3.5 0 0 0 0 7h5a3.5 3.5 0 0 1 0 7H6" />
    </svg>
  );
}

function HeartIcon(props) {
  return (
    <svg
      {...props}
      xmlns="http://www.w3.org/2000/svg"
      width="24"
      height="24"
      viewBox="0 0 24 24"
      fill="none"
      stroke="currentColor"
      strokeWidth="2"
      strokeLinecap="round"
      strokeLinejoin="round"
    >
      <path d="M19 14c1.49-1.46 3-3.21 3-5.5A5.5 5.5 0 0 0 16.5 3c-1.76 0-3 .5-4.5 2-1.5-1.5-2.74-2-4.5-2A5.5 5.5 0 0 0 2 8.5c0 2.3 1.5 4.05 3 5.5l7 7Z" />
    </svg>
  );
}

function TreesIcon(props) {
  return (
    <svg
      {...props}
      xmlns="http://www.w3.org/2000/svg"
      width="24"
      height="24"
      viewBox="0 0 24 24"
      fill="none"
      stroke="currentColor"
      strokeWidth="2"
      strokeLinecap="round"
      strokeLinejoin="round"
    >
      <path d="M10 10v.2A3 3 0 0 1 8.9 16v0H5v0h0a3 3 0 0 1-1-5.8V10a3 3 0 0 1 6 0Z" />
      <path d="M7 16v6" />
      <path d="M13 19v3" />
      <path d="M12 19h8.3a1 1 0 0 0 .7-1.7L18 14h.3a1 1 0 0 0 .7-1.7L16 9h.2a1 1 0 0 0 .8-1.7L13 3l-1.4 1.5" />
    </svg>
  );
}
