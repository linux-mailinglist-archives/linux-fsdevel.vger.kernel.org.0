Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 207515F0FBF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Sep 2022 18:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232046AbiI3QT1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Sep 2022 12:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231997AbiI3QTZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Sep 2022 12:19:25 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA3191C937A
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Sep 2022 09:19:23 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id q17so5309845lji.11
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Sep 2022 09:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=l4aQ5hemtjsltDjjTFlU40Ar40/n0aYhBBQw2x9xe4M=;
        b=n5IXmIQPtFLCjFkpUE2OwV3H+1+xrjCHl08IJahd5SyBcKJ/UsdBT0ARbrXIomUclN
         fd8sqCRfVDzZ+eC1NLtqAp85IzNsTsvVkvysUm5VB52PQNwCA+yB4jBC1xuC3abZlkL3
         co9ueIAqbCn/IDfi+RRnhmBQfNkNlKbH/RmP/Gy9yuqVbaafOyHxCJY2JFPjHrbWeyua
         MRGR4fju3q766ysi3eZBbex8yLYzg8fVBN0u24+SImCGIZCtg/U83iul66WqacM8s0qy
         dn97lGXvlczA2HSN41cwl43KlCmWxBUo/uGJrr47oJcMCi3tp0jWH6xze24KGsk1CzdL
         IBTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=l4aQ5hemtjsltDjjTFlU40Ar40/n0aYhBBQw2x9xe4M=;
        b=3xcHlXhN3t0ny5viEPLUqUh/42cAHKfre7xwJFNHfC1+dnxkIsVGlz718S633ioeiq
         SPP4ExXGSe7O9lX7Ap05gGKvHkJmjIr28lZG+Fg2wpOpT42HtOvMaszWpKA1B2867/6a
         h+bjvfqqXwRbYulXk9YELrO6XvZW1d1XelBK+o0cPxAUcxexmCGwFMhHdBytvET1Vmk5
         5Bc+bMWLnFeU8Q8vPKE/SsCcalg4YCCPgo/j+Cb6LBhGpy1DxNc7Tmh+k08BKLstgki4
         GK055xQ2bgOZKTPqoNppcAMew+aDGbloTVRmDaVuPb3eJnkckq6fsomTCOzaERBDzXNQ
         XSDw==
X-Gm-Message-State: ACrzQf3YWg7JFmOMfjZcCQCp8kHNK/42r766mP94DEc3F+MhbzIHgQsN
        lPrLozV3MncHHHnoBm9b+kkFm+9l9rl2lqjrhHbpAw==
X-Google-Smtp-Source: AMsMyM74N5LK+lGu2FSq6RuG8EoPePtn6IJGRM9qjqNHtPAGMTrCCfMcbV+Z5ehpLR7mFWYQ45apCQbGVR2FeZvjGGE=
X-Received: by 2002:a2e:9954:0:b0:26c:5555:b121 with SMTP id
 r20-20020a2e9954000000b0026c5555b121mr3154070ljj.280.1664554761893; Fri, 30
 Sep 2022 09:19:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220915142913.2213336-1-chao.p.peng@linux.intel.com>
 <20220915142913.2213336-2-chao.p.peng@linux.intel.com> <d16284f5-3493-2892-38e6-f1fa5c10bdbb@redhat.com>
 <Yyi+l3+p9lbBAC4M@google.com> <CA+EHjTzy4iOxLF=5UX=s5v6HSB3Nb1LkwmGqoKhp_PAnFeVPSQ@mail.gmail.com>
 <20220926142330.GC2658254@chaop.bj.intel.com> <CA+EHjTz5yGhsxUug+wqa9hrBO60Be0dzWeWzX00YtNxin2eYHg@mail.gmail.com>
 <YzN9gYn1uwHopthW@google.com>
In-Reply-To: <YzN9gYn1uwHopthW@google.com>
From:   Fuad Tabba <tabba@google.com>
Date:   Fri, 30 Sep 2022 17:19:00 +0100
Message-ID: <CA+EHjTw3din891hMUeRW-cn46ktyMWSdoB31pL+zWpXo_=3UVg@mail.gmail.com>
Subject: Re: [PATCH v8 1/8] mm/memfd: Introduce userspace inaccessible memfd
To:     Sean Christopherson <seanjc@google.com>
Cc:     Chao Peng <chao.p.peng@linux.intel.com>,
        David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, aarcange@redhat.com, ddutile@redhat.com,
        dhildenb@redhat.com, Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>, wei.w.wang@intel.com,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On Tue, Sep 27, 2022 at 11:47 PM Sean Christopherson <seanjc@google.com> wrote:
>
> On Mon, Sep 26, 2022, Fuad Tabba wrote:
> > Hi,
> >
> > On Mon, Sep 26, 2022 at 3:28 PM Chao Peng <chao.p.peng@linux.intel.com> wrote:
> > >
> > > On Fri, Sep 23, 2022 at 04:19:46PM +0100, Fuad Tabba wrote:
> > > > > Then on the KVM side, its mmap_start() + mmap_end() sequence would:
> > > > >
> > > > >   1. Not be supported for TDX or SEV-SNP because they don't allow adding non-zero
> > > > >      memory into the guest (after pre-boot phase).
> > > > >
> > > > >   2. Be mutually exclusive with shared<=>private conversions, and is allowed if
> > > > >      and only if the entire gfn range of the associated memslot is shared.
> > > >
> > > > In general I think that this would work with pKVM. However, limiting
> > > > private<->shared conversions to the granularity of a whole memslot
> > > > might be difficult to handle in pKVM, since the guest doesn't have the
> > > > concept of memslots. For example, in pKVM right now, when a guest
> > > > shares back its restricted DMA pool with the host it does so at the
> > > > page-level.
>
> Y'all are killing me :-)

 :D

> Isn't the guest enlightened?  E.g. can't you tell the guest "thou shalt share at
> granularity X"?  With KVM's newfangled scalable memslots and per-vCPU MRU slot,
> X doesn't even have to be that high to get reasonable performance, e.g. assuming
> the DMA pool is at most 2GiB, that's "only" 1024 memslots, which is supposed to
> work just fine in KVM.

The guest is potentially enlightened, but the host doesn't necessarily
know which memslot the guest might want to share back, since it
doesn't know where the guest might want to place the DMA pool. If I
understand this correctly, for this to work, all memslots would need
to be the same size and sharing would always need to happen at that
granularity.

Moreover, for something like a small DMA pool this might scale, but
I'm not sure about potential future workloads (e.g., multimedia
in-place sharing).

>
> > > > pKVM would also need a way to make an fd accessible again
> > > > when shared back, which I think isn't possible with this patch.
> > >
> > > But does pKVM really want to mmap/munmap a new region at the page-level,
> > > that can cause VMA fragmentation if the conversion is frequent as I see.
> > > Even with a KVM ioctl for mapping as mentioned below, I think there will
> > > be the same issue.
> >
> > pKVM doesn't really need to unmap the memory. What is really important
> > is that the memory is not GUP'able.
>
> Well, not entirely unguppable, just unguppable without a magic FOLL_* flag,
> otherwise KVM wouldn't be able to get the PFN to map into guest memory.
>
> The problem is that gup() and "mapped" are tied together.  So yes, pKVM doesn't
> strictly need to unmap memory _in the untrusted host_, but since mapped==guppable,
> the end result is the same.
>
> Emphasis above because pKVM still needs unmap the memory _somehwere_.  IIUC, the
> current approach is to do that only in the stage-2 page tables, i.e. only in the
> context of the hypervisor.  Which is also the source of the gup() problems; the
> untrusted kernel is blissfully unaware that the memory is inaccessible.
>
> Any approach that moves some of that information into the untrusted kernel so that
> the kernel can protect itself will incur fragmentation in the VMAs.  Well, unless
> all of guest memory becomes unguppable, but that's likely not a viable option.

Actually, for pKVM, there is no need for the guest memory to be
GUP'able at all if we use the new inaccessible_get_pfn(). This of
course goes back to what I'd mentioned before in v7; it seems that
representing the memslot memory as a file descriptor should be
orthogonal to whether the memory is shared or private, rather than a
private_fd for private memory and the userspace_addr for shared
memory. The host can then map or unmap the shared/private memory using
the fd, which allows it more freedom in even choosing to unmap shared
memory when not needed, for example.

Cheers,
/fuad
