Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D453225D7A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jul 2020 13:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728582AbgGTLae (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jul 2020 07:30:34 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:35313 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728058AbgGTLad (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jul 2020 07:30:33 -0400
Received: from mail-qk1-f170.google.com ([209.85.222.170]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MRSdf-1k9Ok72cqr-00NTol; Mon, 20 Jul 2020 13:30:30 +0200
Received: by mail-qk1-f170.google.com with SMTP id 80so14817204qko.7;
        Mon, 20 Jul 2020 04:30:30 -0700 (PDT)
X-Gm-Message-State: AOAM533b9YzZWWSK2VaipD1h2AnkEirKKrzZLtfVzSdHYYCMguVcfIZV
        XQGqfFuBGbZHRM6c7FcqDgXWQoYgJwKsrLkTPDg=
X-Google-Smtp-Source: ABdhPJybaWn8qrmG7q01lgvZCZBti2IcqiiH7/UJUKpkh5l1pzukFrbCvJJFdRaOz1n0M6O3nf2Yvp55077wbmpCEEY=
X-Received: by 2002:a05:620a:1654:: with SMTP id c20mr20996310qko.138.1595244629225;
 Mon, 20 Jul 2020 04:30:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200720092435.17469-1-rppt@kernel.org> <20200720092435.17469-4-rppt@kernel.org>
In-Reply-To: <20200720092435.17469-4-rppt@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 20 Jul 2020 13:30:13 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0NyvRMqH7X0YNO5E6DGtvZXD5ZcD6Y6n7AkocufkMnHA@mail.gmail.com>
Message-ID: <CAK8P3a0NyvRMqH7X0YNO5E6DGtvZXD5ZcD6Y6n7AkocufkMnHA@mail.gmail.com>
Subject: Re: [PATCH 3/6] mm: introduce secretmemfd system call to create
 "secret" memory areas
To:     Mike Rapoport <rppt@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Idan Yaniv <idan.yaniv@ibm.com>,
        Ingo Molnar <mingo@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, linux-nvdimm@lists.01.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        linaro-mm-sig@lists.linaro.org,
        Sumit Semwal <sumit.semwal@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:TfMVKI8Xwwil9I21P8OmonrH2jkQ8LQLt3AUMzzKE3uFso+l/Ie
 dWFOAW34L1oerzNOfgd6/x4mRQaYHRpbfB5vnLm9Jc5BD+P3vDLbFxj9ZPunj8IhEkHh8yT
 NpZP+/Dh2Vtk2D8LkfOIR3jZGQmfRIAwPyWb4mamJnPb00tX7n5moKVad9lP6bc2Sxsn/Zv
 uJkF+a1KD/24lXRqsz0BQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:by+CjfWV5wU=:5W1HSFIYkjF1Xls7nDjsrF
 zPOIOYqc6MG1WsW/TJkgz8B543REI1efhIjAZTCl8hl54UAoxo0qtrlUXi27OkDb06rCki8SE
 PrH9QehiykmvXgC0CWGnP5UhgZJq88hRye+jhN+/c4q6JdMdLDdsfAKBZkbVJqHv4euRSHcCB
 pMRldOesaZG68Ri01KstRYq+uO0qvC3cGFOgL7jE62JZwc1MZMVCNAAruGz6LyGDGZ5ffjlZu
 cI+6BSG4/1Tuo0qd90tDZdQdLzdqbGbGvm9dRT4V42fJfmB1QaHt1jjrtDzWYc82XBKzC90WN
 strBEtRNEN6rijs14n8XSpcfCoZBjCQdcXBvomqj2rbiTUJNpf7nD8WbtR0ijUN63PwOdr+qw
 NLdAhi5bJWI16DWIfaabkdoK1O47W3P9Z0fQuFNw8TG0D9XKAPvrJGrP7Sypuly1/UPgiWrf3
 34/vTl1bkVSzZWfMi+J3YVwdec5oJ8AR58c+F69IBoBz8htFMSXfAjMQVBigZMgnVGkXqoYRy
 5xQe5sbB1GaaXEVgxVpZsTXlf2p/JuU3PZG2+ZpjCUWVrT1yVUGU6E+inuYNt5UarVcidxnS/
 Kv/7GjAApsC1rmKxa0RGN1uWHd/b2I5CsaMyfilr3Up/Hib6etrERmTZUH/t6+UHQtYjpBL6G
 HY7LqdFXjkXb2qPUm6BpCbyuWeqlJ2Y3ULn6o0TF/gOHv3nkqIL4IV2yvc5vmyrYGn9ISS2yy
 0ibKXIMN7KdKRllILtPYah2wamWjdw25ghSi3b6Yd1/uJZYzfL0ZQq1Zyjqog/Xyb0YnhthyD
 ptQoabXcOne1rys3kOv80NTwZZzp2R+MtSQTJNil9zt1ZmbW0wRejytP8kBuM1SOJcnew6y/G
 x/k/iNo+p9hCG/1dUA/DgqUBr9JWlPUNRqhi+Pijmj1sGzbXgl/L53e72cY7EfOjjzKDoVTBH
 ISVSBtTHqZruPQS8vu9AvidlRNnn7ts46+P9XBMolGWhQBYjbhJQC
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 20, 2020 at 11:25 AM Mike Rapoport <rppt@kernel.org> wrote:
>
> From: Mike Rapoport <rppt@linux.ibm.com>
>
> Introduce "secretmemfd" system call with the ability to create memory areas
> visible only in the context of the owning process and not mapped not only
> to other processes but in the kernel page tables as well.
>
> The user will create a file descriptor using the secretmemfd system call
> where flags supplied as a parameter to this system call will define the
> desired protection mode for the memory associated with that file
> descriptor. Currently there are two protection modes:
>
> * exclusive - the memory area is unmapped from the kernel direct map and it
>               is present only in the page tables of the owning mm.
> * uncached  - the memory area is present only in the page tables of the
>               owning mm and it is mapped there as uncached.
>
> For instance, the following example will create an uncached mapping (error
> handling is omitted):
>
>         fd = secretmemfd(SECRETMEM_UNCACHED);
>         ftruncate(fd, MAP_SIZE);
>         ptr = mmap(NULL, MAP_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED,
>                    fd, 0);
>
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>

I wonder if this should be more closely related to dmabuf file
descriptors, which
are already used for a similar purpose: sharing access to secret memory areas
that are not visible to the OS but can be shared with hardware through device
drivers that can import a dmabuf file descriptor.

      Arnd
