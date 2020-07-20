Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9B6F226DCC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jul 2020 20:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731531AbgGTSJG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jul 2020 14:09:06 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:58215 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729029AbgGTSJF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jul 2020 14:09:05 -0400
Received: from mail-qk1-f177.google.com ([209.85.222.177]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MqbI0-1kb3l72gnw-00mbhT; Mon, 20 Jul 2020 20:09:01 +0200
Received: by mail-qk1-f177.google.com with SMTP id h7so488677qkk.7;
        Mon, 20 Jul 2020 11:09:01 -0700 (PDT)
X-Gm-Message-State: AOAM532LQ8HuYgMqhLlbzb6YY2X2/QtBTW0FSzbZAAlDn3gv8mcRSjt6
        XWA2t0IqODVxLfyOqHpTpKnJW5G8B3CxF5IkwjQ=
X-Google-Smtp-Source: ABdhPJxk8AXvQoaaSyG6TPpWGlRFg6r3NFnqCF1QtWJiuwzUOgkiVS3DL9DQU7SzABQpPR/Um1zIkILDDVb8zZFAISI=
X-Received: by 2002:a37:b484:: with SMTP id d126mr22851253qkf.394.1595268540113;
 Mon, 20 Jul 2020 11:09:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200720092435.17469-1-rppt@kernel.org> <20200720092435.17469-4-rppt@kernel.org>
 <CAK8P3a0NyvRMqH7X0YNO5E6DGtvZXD5ZcD6Y6n7AkocufkMnHA@mail.gmail.com> <1595260305.4554.9.camel@linux.ibm.com>
In-Reply-To: <1595260305.4554.9.camel@linux.ibm.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 20 Jul 2020 20:08:43 +0200
X-Gmail-Original-Message-ID: <CAK8P3a34kx4aAFY=-SBHX3suCLwxeZY7+YSRzct93YM_OFbSWA@mail.gmail.com>
Message-ID: <CAK8P3a34kx4aAFY=-SBHX3suCLwxeZY7+YSRzct93YM_OFbSWA@mail.gmail.com>
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
X-Provags-ID: V03:K1:mMIslIN9LPglY3J5UjtYLyGRTynVj4G4C03NTxE+HIOHtsP3EDW
 6vmwXQ/rDd95A8R1jRHFPgcyZMoWnj/4hN3OEW3EpFjaNSHtXpDYrL9Uh6LIjaX+/ZQfhyJ
 B12aXsIQkzUBTOJPJ/HhZPOj1VlOAmNTTwbYN0w8ueDy6Zyx5dxUKhnNVtTvXoqrqjYtebO
 RTzwoOPaMa8GXoCUdWs9Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:dt3ajiaLIoE=:8lPDfmMJiVDwnBROjMIocG
 tGAzx7/zLHCoN1MZgnxqBlxX6FThpKjK7O6ofp2Yw8dIr8mDFbnxbgvstpnukhQhBuosGvt/P
 KaGO5OISWQ4gxbcxsUU8M/L8yxHpuFZGRq6S2LTuauxo3V/v/a2YJVq3B/uQCjjvnK/VbsEy7
 pR6fa8bJI9aVHZ3DgLuBSTKcWxdTbNubrUU3FNViOSG1VgktOgwfjBJwFKzMontW1Z3QsREng
 mMBUJ7OBpw/Fj5ue/t9VFEjrPmE30w71rF4OWFmL8XVDIzU8pGmFiWAtFmjKg5pkDL/XSFEMi
 5nTB5zX+I4MqreHz/MI+jSEE28ftMdi5rPB7Ex0LoMeSz8bUejNnYn9hKBbrSzaullCoJKGu4
 QfTo5R9rVeiNYWwpT4ygereWpfHJEf4nfVq/4FHlDl0b1GdVmfpE8S2VWozJYoZKMdpAe0Yv6
 ucTWi37ZY+8JV2dxhdY3pto1wNDKVhm3ts+rS9bIde/a1rvaiVAYHZ8G64kgTmBWKlX+iCN3f
 UheXvSyqWHaqR5IMwEJdW2A78l2GDhM8zTFBhH/LaPeGMTHFoK58CuwEzEd68SqT0GSJfxrOb
 lVZ1Twq78ZvFdFxnBqDdw6vwJSpF4rM+nSZo+Fs426CfaT7vLYZXBO5raAwXDxZUAKk9GBfHG
 jhunTBDmPA1x2q3g5daoNpAFzXp3JXK+9iXHLd32D4DCLdh3VP0mi53ib+HCIsrUkdSbiVwW7
 5SkKDILDy5UVTZugXj0QFnnp+/iA0caVqf/SoHYR7Em/znOlACY8xTCJLAs5c5I5MDO0N223i
 CR+jPo9UqaBJcTsNFCXLmZdo4EaHJn4wshEZ7Ud+bX+QHKG1F32j5Yc0zUG63xIVdlr9ENaBd
 a3WrKZiEeCqmPMVFkbEtFg4gO1QNrZlsNKDiIq5mh6KWAzxG8DOBt527XkG0Ff5syd9/OYBk+
 HnblSI7zF4+xHOoKeORALKWXkERQX6zg1lpkHtwnbqoHDFivCd4q7
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 20, 2020 at 5:52 PM James Bottomley <jejb@linux.ibm.com> wrote:
> On Mon, 2020-07-20 at 13:30 +0200, Arnd Bergmann wrote:
>
> I'll assume you mean the dmabuf userspace API?  Because the kernel API
> is completely device exchange specific and wholly inappropriate for
> this use case.
>
> The user space API of dmabuf uses a pseudo-filesystem.  So you mount
> the dmabuf file type (and by "you" I mean root because an ordinary user
> doesn't have sufficient privilege).  This is basically because every
> dmabuf is usable by any user who has permissions.  This really isn't
> the initial interface we want for secret memory because secret regions
> are supposed to be per process and not shared (at least we don't want
> other tenants to see who's using what).
>
> Once you have the fd, you can seek to find the size, mmap, poll and
> ioctl it.  The ioctls are all to do with memory synchronization (as
> you'd expect from a device backed region) and the mmap is handled by
> the dma_buf_ops, which is device specific.  Sizing is missing because
> that's reported by the device not settable by the user.

I was mainly talking about the in-kernel interface that is used for
sharing a buffer with hardware. Aside from the limited ioctls, anything
in the kernel can decide on how it wants to export a dma_buf by
calling dma_buf_export()/dma_buf_fd(), which is roughly what the
new syscall does as well. Using dma_buf vs the proposed
implementation for this is not a big difference in complexity.

The one thing that a dma_buf does is that it allows devices to
do DMA on it. This is either something that can turn out to be
useful later, or it is not. From the description, it sounded like
the sharing might be useful, since we already have known use
cases in which "secret" data is exchanged with a trusted execution
environment using the dma-buf interface.

If there is no way the data stored in this new secret memory area
would relate to secret data in a TEE or some other hardware
device, then I agree that dma-buf has no value.

> What we want is the ability to get an fd, set the properties and the
> size and mmap it.  This is pretty much a 100% overlap with the memfd
> API and not much overlap with the dmabuf one, which is why I don't
> think the interface is very well suited.

Does that mean you are suggesting to use additional flags on
memfd_create() instead of a new system call?

      Arnd
