Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDBF0226F76
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jul 2020 22:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730637AbgGTUGB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jul 2020 16:06:01 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:54575 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728733AbgGTUGA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jul 2020 16:06:00 -0400
Received: from mail-qt1-f169.google.com ([209.85.160.169]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MY5wD-1kKJKK1kFh-00YRin; Mon, 20 Jul 2020 22:05:57 +0200
Received: by mail-qt1-f169.google.com with SMTP id d27so14285615qtg.4;
        Mon, 20 Jul 2020 13:05:56 -0700 (PDT)
X-Gm-Message-State: AOAM530wM1+5NYF/GLgfVoP1OacVsQvcs3sbyG3/ZN6kiqVwpjRXBmfS
        zqGqaFEHyIv1HnWYz4VYYdeeQtG3ClFZFPeBYjc=
X-Google-Smtp-Source: ABdhPJzP8ED75eP/64ZTWgc8CqM8513IRGly4LjDrHp/zECs6vcVhK6MaJY0JaFbbN4kfnMI9cRAMEvStsrfDJyQR1k=
X-Received: by 2002:ac8:7587:: with SMTP id s7mr25919753qtq.304.1595275555970;
 Mon, 20 Jul 2020 13:05:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200720092435.17469-1-rppt@kernel.org> <20200720092435.17469-4-rppt@kernel.org>
 <CAK8P3a0NyvRMqH7X0YNO5E6DGtvZXD5ZcD6Y6n7AkocufkMnHA@mail.gmail.com>
 <1595260305.4554.9.camel@linux.ibm.com> <CAK8P3a34kx4aAFY=-SBHX3suCLwxeZY7+YSRzct93YM_OFbSWA@mail.gmail.com>
 <1595272585.4554.28.camel@linux.ibm.com>
In-Reply-To: <1595272585.4554.28.camel@linux.ibm.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 20 Jul 2020 22:05:39 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0ExFSSw-SCL=dSXzyv4jnp=yQs=ZooKDrL_tQogazrjg@mail.gmail.com>
Message-ID: <CAK8P3a0ExFSSw-SCL=dSXzyv4jnp=yQs=ZooKDrL_tQogazrjg@mail.gmail.com>
Subject: Re: [PATCH 3/6] mm: introduce secretmemfd system call to create
 "secret" memory areas
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc:     Mike Rapoport <rppt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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
X-Provags-ID: V03:K1:/BdmKC6OFMPwbxcQRFi4H6TmTicjzVIg4ZYaqssND56FMYDUzpX
 n+daFQquXU+NPoe23JNp61NR/TH4LHyjZ2n1+ZGrtfabNngkw2pkhOPsVlYnkA5pRVgh2Vg
 w0cZYmuuHbHP84SUxCWClN9JI8bXve92TeHIQhXDeQJ0hoQbUSnOtZG6GQUWmd1bP4L6gCL
 hDL9ChiXDjjOIVHUZIV3g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:3DTK3zBvEMI=:NRqJOEj9RvMaIyC/eobc3q
 o4FKTi2bR0Pm2Iyd4Zc01N6zfpy5Lq8YEjjs6lIEhegnVNzH+Pf/UzhFYmfxVG8vHYlYoJc73
 Nv+ACbXd1UyAH8KxWM6DhDKbd0OAHSTl9BaNv145s/rBTHBfZY9btZ0D3mtUUlcmPiitwLP4S
 wCT35kBcCKHcxm2/PaGOm5gQCBd5y2SGg98DHeoPFUT8xr8j2MDTnYBYE/QpU54J7zTRxoDP/
 BBqlW4E5i0JI7EeACDdM8xNxz8Mkt6tk1JBuaJG4gWx7cHuoUEHXBKQHKuxFD7H41KE/IjDCQ
 YIO73+fCOfW7i76rFnofkedkOZCRTxJaNRJ3PQdrxBOoYyN/ZyuqLLewOaZH/mNEBTGSIxWko
 LHm0JmvoP91v0X1Lw4DJj08lRKPtOv6XvnZ2jAWLkUxU285hbCfepnwdTI5PuqLI3OCN+Q1e1
 W4XYjV4wAQmy5B37iUWW/fZfwo4jwsMJeswtDSKE/wVvtY4cy70LB0IsqX5utbR66P+6h8D2U
 KplXbBE2jV/EHFSIOl2WnHZ7KOKyadnws89i/ro+Jl6WSxu2MWcCjV5O+NUq1c5golDhugIcZ
 f+iEdsxGm0QWr8qkORSa1380wqQhDxjWCuQYJjvDpbFu5NBT+frvTKwQzo9Xn4FFwyZa5b/mi
 HAka7DVA48nXZPYe0qbPWpEoxbDbtWFqGnLqfE3vlUXykFWuTr4a8EEm9klyg+NGB0PUX0P4e
 xRMNaLb8EYPPhttVck48uK58k0cElC92r2BpbyanrF5T/2ktGs3+dJ0LaACbadttbMrndrOS1
 +F+84x6TbRetSj/rEYahCzuFx2L55zM3l1H9ZtkwlwDaHU127idH51B3J22SDzy4evpIP729x
 GVKKmjuWpX5ZgyU8KvXBMGtLUCDkD51Q8Dj+ZB87I8PumCa4Y5BmngCEq/dqPjz28QX2+PrpX
 z+igUCtPP+6Qbc54sjpOGZXSk4YSZvNs6MR9Bxh0rPGanjTlDEUCP
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 20, 2020 at 9:16 PM James Bottomley <jejb@linux.ibm.com> wrote:
> On Mon, 2020-07-20 at 20:08 +0200, Arnd Bergmann wrote:
> > On Mon, Jul 20, 2020 at 5:52 PM James Bottomley <jejb@linux.ibm.com>
> >
> > If there is no way the data stored in this new secret memory area
> > would relate to secret data in a TEE or some other hardware
> > device, then I agree that dma-buf has no value.
>
> Never say never, but current TEE designs tend to require full
> confidentiality for the entire execution.  What we're probing is
> whether we can improve security by doing an API that requires less than
> full confidentiality for the process.  I think if the API proves useful
> then we will get HW support for it, but it likely won't be in the
> current TEE of today form.

As I understand it, you normally have two kinds of buffers for the TEE:
one that may be allocated by Linux but is owned by the TEE itself
and not accessible by any process, and one that is used for
communication between the TEE and a user process.

The sharing would clearly work only for the second type: data that
a process wants to share with the TEE but as little else as possible.

A hypothetical example might be a process that passes encrypted
data to the TEE (which holds the key) for decryption, receives
decrypted data and then consumes that data in its own address
space. An electronic voting system (I know, evil example) might
receive encrypted ballots and sum them up this way without itself
having the secret key or anything else being able to observe
intermediate results.

> > > What we want is the ability to get an fd, set the properties and
> > > the size and mmap it.  This is pretty much a 100% overlap with the
> > > memfd API and not much overlap with the dmabuf one, which is why I
> > > don't think the interface is very well suited.
> >
> > Does that mean you are suggesting to use additional flags on
> > memfd_create() instead of a new system call?
>
> Well, that was what the previous patch did.  I'm agnostic on the
> mechanism for obtaining the fd: new syscall as this patch does or
> extension to memfd like the old one did.  All I was saying is that once
> you have the fd, the API you use on it is the same as the memfd API.

Ok.

I suppose we could even retrofit dma-buf underneath the
secretmemfd implementation if it ends up being useful later on,

      Arnd
