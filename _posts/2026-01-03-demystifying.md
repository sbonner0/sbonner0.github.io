---
title: "Demystifying Intel’s GPU Software Stack for Local LLMs"
date: 2026-01-03 09:00:00 +0000
categories: [llm]
tags: [intel arc, gpu, local LLMs]
pin: false
---

As I touched on in my previous [post](https://sbonner0.github.io/posts/intel-arc/), I have been investigating local LLM offerings on Intel GPUs. As part of this, I had to gain familiarity with different nomenclature to what I was used having historically only used NVIDIA hardware. This blog aims to be a quick demystification of some of these terms. It is not an exhaustive list of relevant ones, just some that stuck with me now I am more familiar with the Intel ecosystem. This post focuses on the SYCL execution stack rather Vulkan or others.

**SYCL:** [SYCL](https://www.khronos.org/sycl/) is a modern, open, C++ based high-level programming model for writing portable accelerator (including GPU) code across vendors. It is standardised by the [Khronos Group](https://www.khronos.org/) and was first introduced in 2014. SYCL itself is a specification rather than a concrete implementation, with multiple conformant toolchains provided by different vendors. SYCL occupies a similar space to CUDA in that it enables explicit, data-parallel programming of GPUs and other accelerators from C++, but while CUDA is NVIDIA-specific, SYCL code can run on hardware from multiple vendors via different backends.

**OneAPI:** [OneAPI](https://www.intel.com/content/www/us/en/developer/articles/technical/oneapi-what-is-it.html) provides Intel’s primary implementation of the SYCL programming model. In practice, oneAPI is a collection of compilers, runtimes, and libraries that enable SYCL-based code to run across a range of accelerators, most notably Intel CPUs and Arc GPUs, but also, via appropriate backends, hardware from other vendors. Intel provides a [download](https://www.intel.com/content/www/us/en/developer/tools/oneapi/base-toolkit-download.html) of all the different components for both Linux and Windows. As we saw in the previous blog, the popular local LLM library llama-cpp has [support](https://github.com/ggml-org/llama.cpp/blob/master/docs/backend/SYCL.md) for running inference on Intel Arc GPUs using OneAPI. One of the core components of oneAPI is [Data Parallel C++ (DPC++)](https://www.intel.com/content/www/us/en/developer/tools/oneapi/data-parallel-c-plus-plus.html), which is Intel's SYCL language implementation and [compiler](https://www.intel.com/content/www/us/en/developer/tools/oneapi/dpc-compiler.html). OneAPI also wraps up the surrounding runtimes, libraries and tooling (including elements we will see later, such as OneDNN).

**Level Zero**: [Level Zero](https://www.intel.com/content/www/us/en/docs/dpcpp-cpp-compiler/developer-guide-reference/2025-2/intel-oneapi-level-zero.html) is part of the oneAPI ecosystem and is an API that enables direct access to the bare-metal hardware, such as GPUs. It is similar in function to the CUDA Driver API on an NVIDIA system. Besides ensuring it is installed correctly, Level Zero is not something that the average LLM user would have to directly interact with regularly. Any Intel GPU that are installed in a system will appear as a Level Zero device. For example, my own A750:

```text
[level_zero:gpu][level_zero:0] Intel(R) oneAPI Unified Runtime over Level-Zero, Intel(R) Arc(TM) A750 Graphics 12.55.8 [1.13.35563]
```

**OneDNN:** [OneDNN](https://www.intel.com/content/www/us/en/developer/tools/oneapi/onednn.html) is a neural network library that is part of the oneAPI ecosystem. It is roughly analogous to NVIDIA's cuDNN as it provides optimised implementations of core primitives essential for deep learning such as convolutions, matrix multiplies and pooling operations. Popular machine learning packages such as PyTorch use the OneDNN library when running on Intel hardware to achieve higher performance. In the context of local LLMs, OneDNN may be utilised under the hood by libraries like llama-cpp when executing on Intel GPUs to accelerate inference workloads.
