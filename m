Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89948226238
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jul 2020 16:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbgGTOec (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jul 2020 10:34:32 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:38095 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbgGTOec (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jul 2020 10:34:32 -0400
Received: from mail-qk1-f171.google.com ([209.85.222.171]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1N95qT-1krodm4BvT-016C7p; Mon, 20 Jul 2020 16:34:30 +0200
Received: by mail-qk1-f171.google.com with SMTP id k18so15466062qke.4;
        Mon, 20 Jul 2020 07:34:29 -0700 (PDT)
X-Gm-Message-State: AOAM533vXOXAQA92gQlYFoAKT5yHOm1tb++FWh4RgrKXSqNGI4F7RuQG
        UTA4LMhsn9U2RLn+KpXP96RHNp1NzVIa1IEFOpY=
X-Google-Smtp-Source: ABdhPJwIxgAdvjUjPU+4jzybDNb2QFZAVcL3HMLlxw2RLgRPrBNFIwh83Ml0UJm/YApy5c7tnsKEhhbWEGttCx/g1AI=
X-Received: by 2002:a37:b484:: with SMTP id d126mr21885286qkf.394.1595255668502;
 Mon, 20 Jul 2020 07:34:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200720092435.17469-1-rppt@kernel.org> <20200720092435.17469-4-rppt@kernel.org>
 <CAK8P3a0NyvRMqH7X0YNO5E6DGtvZXD5ZcD6Y6n7AkocufkMnHA@mail.gmail.com> <20200720142053.GC8593@kernel.org>
In-Reply-To: <20200720142053.GC8593@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 20 Jul 2020 16:34:12 +0200
X-Gmail-Original-Message-ID: <CAK8P3a07jAec4hKyNMcha032TT6OXjYHaZZ4Za9ncDsvapeg8Q@mail.gmail.com>
Message-ID: <CAK8P3a07jAec4hKyNMcha032TT6OXjYHaZZ4Za9ncDsvapeg8Q@mail.gmail.com>
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
X-Provags-ID: V03:K1:srrbyHaYU7EURbuMbY9QNOdm0/1jFcAICWf2FjgUlgnNHilq/LO
 rBs+nFhQT+5iIsJmYAQw+8rXEKBmp79SA6mGjT4SESma9NSNCFpU9Ae/HzvXu9rk77SCMvZ
 2auhZfsYsysXj7Eo8MYxrJCgxTWYRIHK9fnqhw37ua2xI7VhVkEPtYe60zjVSgGcDR7SUi5
 ma2V/rkp2axitpYG3xo9g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:I7O8pHReyM0=:+GyzYzxPRQVMTgado+BH7U
 RS5BLfeUxXEmyQxeTKuEipi+zA2jHyaw9lQFUOU3MbdZ24aGfLx+YWZANHxK4fnKDlF30bryv
 Fm8h0wQxJzWh75bIJpNMlUyjKLqj5cNaIcvE3YLv/XMcgW9Vc03IqlhtmsGhdfnHsNdK6DAoI
 W1HI2s2gbRdUsMkNyFlGTeXX5DeuDtlTXc0wpkrVjzsTeiB4SoyZH5eHUpOFgntthGIyjM1tu
 7sGtqPslChROHkISlm4Smq53sqo+rx3lHSmaeoKPBfMSv6Mt4Xbyn+2B82IH0RRPd6PBp6N9J
 bWqvjj3NmDgtjs8atteTozw0fuEBqLleYOnCsdzGKg3STwchEf2RxZMJMK/UfE7WhFBV6XKFj
 V1XKCXrM4qdG2Mk78OJR63VFavGUvSODtyq2ya2Z9clhZQv4XsnGCG8LDkfxWWfh8ai1xzVW7
 8G7LNmTKbwpdhllsZn4vWzYb+k1nVQ0StRbxSqsnkPUOh629SxEN/pC3pVrSwUUeCumc64xNF
 9SimHb2+KaYzVzhFDMRkRuD23Mt1SlWptSwAQ950IbH5bVanc19AYRmAuxm7FJGyP5GQ5BX5K
 wfUlC8VJmfdSyAcj4xxrZ/ITQ2zE8SXSUVaAwGjvULDylMiAPpjdvR8syw2Z9zfLTSWBOFWJ7
 9S2cXNwtuXGrRYGIUN1KaaNMKyztQOs9YLZaFAKbwqFr1vLnkp/kieMKEgGMUkaTyvljfoJVu
 xQHv2hbDF7N4NTj2aPIoUM6RLhyltBTyP85pgWeTVGx7OTgDrykIbZtD8XFQhXMddlgFYDMOp
 R874jyVt5R1zRlwAi5SIEtq+zdbCEaJGzNbEPHTGFMLilmit9w8uQGfsfEARZwrhVqmbNr6s6
 6stsfbUov7A0y4GcRkq1kLed6ZreDjPRUj0fMA/j81z5IlbXItFSazULvr7wsIgDzQ03xStq+
 Qfv6ySmj5Vxypu6JxhUCM9fCUFmvC1ek3klVxOT4RqH9BJJz/dGvC
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 20, 2020 at 4:21 PM Mike Rapoport <rppt@kernel.org> wrote:
> On Mon, Jul 20, 2020 at 01:30:13PM +0200, Arnd Bergmann wrote:
> > On Mon, Jul 20, 2020 at 11:25 AM Mike Rapoport <rppt@kernel.org> wrote:
> > >
> > > From: Mike Rapoport <rppt@linux.ibm.com>
> > >
> > > Introduce "secretmemfd" system call with the ability to create memory areas
> > > visible only in the context of the owning process and not mapped not only
> > > to other processes but in the kernel page tables as well.
> > >
> > > The user will create a file descriptor using the secretmemfd system call
> > > where flags supplied as a parameter to this system call will define the
> > > desired protection mode for the memory associated with that file
> > > descriptor. Currently there are two protection modes:
> > >
> > > * exclusive - the memory area is unmapped from the kernel direct map and it
> > >               is present only in the page tables of the owning mm.
> > > * uncached  - the memory area is present only in the page tables of the
> > >               owning mm and it is mapped there as uncached.
> > >
> > > For instance, the following example will create an uncached mapping (error
> > > handling is omitted):
> > >
> > >         fd = secretmemfd(SECRETMEM_UNCACHED);
> > >         ftruncate(fd, MAP_SIZE);
> > >         ptr = mmap(NULL, MAP_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED,
> > >                    fd, 0);
> > >
> > > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> >
> > I wonder if this should be more closely related to dmabuf file
> > descriptors, which
> > are already used for a similar purpose: sharing access to secret memory areas
> > that are not visible to the OS but can be shared with hardware through device
> > drivers that can import a dmabuf file descriptor.
>
> TBH, I didn't think about dmabuf, but my undestanding is that is this
> case memory areas are not visible to the OS because they are on device
> memory rather than normal RAM and when dmabuf is backed by the normal
> RAM, the memory is visible to the OS.

No, dmabuf is normally about normal RAM that is shared between multiple
devices, the idea is that you can have one driver allocate a buffer in RAM
and export it to user space through a file descriptor. The application can then
go and mmap() it or pass it into one or more other drivers.

This can be used e.g. for sharing a buffer between a video codec and the
gpu, or between a crypto engine and another device that accesses
unencrypted data while software can only observe the encrypted version.

       Arnd
