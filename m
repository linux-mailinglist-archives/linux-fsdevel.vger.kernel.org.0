Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6637775FCCF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jul 2023 19:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbjGXRAm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jul 2023 13:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbjGXRAj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jul 2023 13:00:39 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28BE81709
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jul 2023 10:00:37 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-26814a011deso544860a91.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jul 2023 10:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690218036; x=1690822836;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RiFFb9olEr1IXMurVCQB0i8J9xB8UVFiN6yE37xYj5w=;
        b=iUh3Wr2Es7ZayOSlRIyCXv0ISRPLliUqI/wxpz9npizX1RGnl3Zt97AZrYUR8pVjnH
         OwuM0g2/mnG2Ws1vH1RTNrF8tqURzEVkr4hahdERkph4Nww3rEaO/unCqdjsW1luIjbU
         y9Vd6q8CcxdQP+GEmRHglSZNO6vM+UxAwTBpxBMCbqTq0hlf3MD2sKnPBjpHoFEjKPFr
         Tmb3ea8A/X/JO92m7TD8v5eZc4l7fpKAQniXW7MS+8KISe8P4Nbdl//npN/iD7LNKC4a
         rVBOiRv2FN5pQA6p+V2In5eaYYH21fAVeDedlt36+Mezc1EEot9BPPcgeqHdCs8LHv6O
         cdZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690218036; x=1690822836;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RiFFb9olEr1IXMurVCQB0i8J9xB8UVFiN6yE37xYj5w=;
        b=ZpqHZm6mIQNbNiydfzFtvCVEmQAhtJzAx+4LspB16T3n38dgAcTWfcFJ/VBSBMrbRH
         nS7WUbQ4WR/wD6UcUNbD/MRKglg20iw2KNzG6RKPKqVMsIg+L4eiCIxS4DSdr3zOYaIS
         mVqoN7XmXAjHtl2fyI94KnINimO1WDXJ24el8yfS1fCZTfGMfnyQ8Kl/IlsZ/17FSzGP
         xV8cPsb+d9wV0n9wbvQdM2i+TibeVKW1bn7MeP8OANGWZvlG3W3K8gtEgcQt4Tc4WNcv
         bxVYTgCrlm9wmlcEJVCUxYN7/cINTBol53xvTGyuVurQEFBFcN3M781C7ebKmaC2ZVgC
         1e9w==
X-Gm-Message-State: ABy/qLZn2H2xp/cJyR0gVxt1N1uElkP9/9rNvKu1AD5xxA3Xxe4XPwbk
        29G0+Zp/GDj961b/cOjlElXlJADBVQw=
X-Google-Smtp-Source: APBJJlGFNY8Nsd+UpmzZCGDOgI47OKk03bkzsFP32ko2G/RNTdNXayC/49Rk0sPPfbjIVmYJcM3mAoRuscc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:2308:b0:1b8:80c9:a98e with SMTP id
 d8-20020a170903230800b001b880c9a98emr42778plh.13.1690218036394; Mon, 24 Jul
 2023 10:00:36 -0700 (PDT)
Date:   Mon, 24 Jul 2023 10:00:34 -0700
In-Reply-To: <110f1aa0-7fcd-1287-701a-89c2203f0ac2@amd.com>
Mime-Version: 1.0
References: <20230718234512.1690985-1-seanjc@google.com> <110f1aa0-7fcd-1287-701a-89c2203f0ac2@amd.com>
Message-ID: <ZL6uMk/8UeuGj8CP@google.com>
Subject: Re: [RFC PATCH v11 00/29] KVM: guest_memfd() and per-page attributes
From:   Sean Christopherson <seanjc@google.com>
To:     "Nikunj A. Dadhania" <nikunj@amd.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Huacai Chen <chenhuacai@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Anup Patel <anup@brainfault.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, kvm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chao Peng <chao.p.peng@linux.intel.com>,
        Fuad Tabba <tabba@google.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Ackerley Tng <ackerleytng@google.com>,
        Maciej Szmigiero <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>,
        Wang <wei.w.wang@intel.com>,
        Liam Merwick <liam.merwick@oracle.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 24, 2023, Nikunj A. Dadhania wrote:
> On 7/19/2023 5:14 AM, Sean Christopherson wrote:
> > This is the next iteration of implementing fd-based (instead of vma-based)
> > memory for KVM guests.  If you want the full background of why we are doing
> > this, please go read the v10 cover letter[1].
> > 
> > The biggest change from v10 is to implement the backing storage in KVM
> > itself, and expose it via a KVM ioctl() instead of a "generic" sycall.
> > See link[2] for details on why we pivoted to a KVM-specific approach.
> > 
> > Key word is "biggest".  Relative to v10, there are many big changes.
> > Highlights below (I can't remember everything that got changed at
> > this point).
> > 
> > Tagged RFC as there are a lot of empty changelogs, and a lot of missing
> > documentation.  And ideally, we'll have even more tests before merging.
> > There are also several gaps/opens (to be discussed in tomorrow's PUCK).
> 
> As per our discussion on the PUCK call, here are the memory/NUMA accounting 
> related observations that I had while working on SNP guest secure page migration:
> 
> * gmem allocations are currently treated as file page allocations
>   accounted to the kernel and not to the QEMU process.

We need to level set on terminology: these are all *stats*, not accounting.  That
distinction matters because we have wiggle room on stats, e.g. we can probably get
away with just about any definition of how guest_memfd memory impacts stats, so
long as the information that is surfaced to userspace is useful and expected.

But we absolutely need to get accounting correct, specifically the allocations
need to be correctly accounted in memcg.  And unless I'm missing something,
nothing in here shows anything related to memcg.

>   Starting an SNP guest with 40G memory with memory interleave between
>   Node2 and Node3
> 
>   $ numactl -i 2,3 ./bootg_snp.sh
> 
>     PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND
>  242179 root      20   0   40.4g  99580  51676 S  78.0   0.0   0:56.58 qemu-system-x86
> 
>   -> Incorrect process resident memory and shared memory is reported

I don't know that I would call these "incorrect".  Shared memory definitely is
correct, because by definition guest_memfd isn't shared.  RSS is less clear cut;
gmem memory is resident in RAM, but if we show gmem in RSS then we'll end up with
scenarios where RSS > VIRT, which will be quite confusing for unaware users (I'm
assuming the 40g of VIRT here comes from QEMU mapping the shared half of gmem
memslots).

>   Accounting of the memory happens in the host page fault handler path,
>   but for private guest pages we will never hit that.
> 
> * NUMA allocation does use the process mempolicy for appropriate node 
>   allocation (Node2 and Node3), but they again do not get attributed to 
>   the QEMU process
> 
>   Every 1.0s: sudo numastat  -m -p qemu-system-x86 | egrep -i "qemu|PID|Node|Filepage"   gomati: Mon Jul 24 11:51:34 2023
> 
>   Per-node process memory usage (in MBs)
>   PID                               Node 0          Node 1          Node 2          Node 3           Total
>   242179 (qemu-system-x86)           21.14            1.61           39.44           39.38          101.57
>   Per-node system memory usage (in MBs):
>                             Node 0          Node 1          Node 2          Node 3           Total
>   FilePages                2475.63         2395.83        23999.46        23373.22        52244.14
> 
> 
> * Most of the memory accounting relies on the VMAs and as private-fd of 
>   gmem doesn't have a VMA(and that was the design goal), user-space fails 
>   to attribute the memory appropriately to the process.
>
>   /proc/<qemu pid>/numa_maps
>   7f528be00000 interleave:2-3 file=/memfd:memory-backend-memfd-shared\040(deleted) anon=1070 dirty=1070 mapped=1987 mapmax=256 active=1956 N2=582 N3=1405 kernelpagesize_kB=4
>   7f5c90200000 interleave:2-3 file=/memfd:rom-backend-memfd-shared\040(deleted)
>   7f5c90400000 interleave:2-3 file=/memfd:rom-backend-memfd-shared\040(deleted) dirty=32 active=0 N2=32 kernelpagesize_kB=4
>   7f5c90800000 interleave:2-3 file=/memfd:rom-backend-memfd-shared\040(deleted) dirty=892 active=0 N2=512 N3=380 kernelpagesize_kB=4
> 
>   /proc/<qemu pid>/smaps
>   7f528be00000-7f5c8be00000 rw-p 00000000 00:01 26629                      /memfd:memory-backend-memfd-shared (deleted)
>   7f5c90200000-7f5c90220000 rw-s 00000000 00:01 44033                      /memfd:rom-backend-memfd-shared (deleted)
>   7f5c90400000-7f5c90420000 rw-s 00000000 00:01 44032                      /memfd:rom-backend-memfd-shared (deleted)
>   7f5c90800000-7f5c90b7c000 rw-s 00000000 00:01 1025                       /memfd:rom-backend-memfd-shared (deleted)

This is all expected, and IMO correct.  There are no userspace mappings, and so
not accounting anything is working as intended.

> * QEMU based NUMA bindings will not work. Memory backend uses mbind() 
>   to set the policy for a particular virtual memory range but gmem 
>   private-FD does not have a virtual memory range visible in the host.

Yes, adding a generic fbind() is the way to solve silve.
