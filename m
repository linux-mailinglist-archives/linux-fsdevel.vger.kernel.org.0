Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AEEC7620F2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jul 2023 20:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232560AbjGYSFh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jul 2023 14:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbjGYSFe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jul 2023 14:05:34 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A4F1FDA
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jul 2023 11:05:32 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-583da2ac09fso35150817b3.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jul 2023 11:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690308331; x=1690913131;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BIo8qHauKdQX+T8FT8wbaojm6/JdQZAwM03PT/kIykI=;
        b=7nXQcBRpxoTRBB3DVtfi1G3SLzO+8rbX0pZK3GqB/ZiRovVnhgEY5C+Gs70dPcpJKC
         v8EbJPLKK/PtzLxWiGJ5qeO4LJqB7HN3pWAhYbANBnQSVYoMTUMzCaeCD3zEfSqoM+r2
         fDpLY03C1R0xadVk8zh9oHGZMZqSmWV+dliNXRuRczTowFXc/oEsFJjHeqmHR0h/7zjV
         1SaakHlCZawqmTagIefeOP2xnfIobskVh1rmXibU4Cwg3i96EQeqcAc0By/i+P6tJXi9
         1AMdfmti0ZHyvBS0qJY6Ig052U8rUWQC7aHvZS0sxZXtvMY234BUecIw+5qK/UmUColq
         VbWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690308331; x=1690913131;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BIo8qHauKdQX+T8FT8wbaojm6/JdQZAwM03PT/kIykI=;
        b=ePYSWet3CuCW+ABA3HQmUtTd3d3nLzVZrGeFFlNPaM3clf7BGOUnw44vRbhhVaAgYT
         wLjiWECvqbuzHATj6ZKGVG7ZPI7ylCRm/ItYKbqLnZh11ZS5ruRtyRo7EvjPe3Hf3aF2
         A3/vvlXC5etw8ebZmHrkiCH9WDYDjQL+rBNifEAy3RlRBh6XJ5tTt5GwaEuPq/DALhgs
         o17df+0+DVabOzGz70vaG6r2U80AfVxVhts7xvniwp93EcVI4GnbzKQ4dE/mw/AZY/cn
         BxpSEVq1oI+s1NBNnBDq0gkHHkR6OQ9H8bFfwsZ7j61WtOs4iaKdYltom6NTE/6MeJWw
         wLuw==
X-Gm-Message-State: ABy/qLZ29i+FZ0XZJeNVkWu5DWXjEdTMr5T0yn9f0OIWfc12ZGB5WTIj
        aGrQrcBkOe8oCK1MAwuECK5zLDJ/fOo=
X-Google-Smtp-Source: APBJJlG+f5K6Guu8BWDh2M0jvEhmql8458IaH+LCw2ABsy+ZDoDj1Vv7TcavygUx+nDEGvPQs1RCmsWjSr8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:4509:0:b0:573:5797:4b9e with SMTP id
 s9-20020a814509000000b0057357974b9emr213ywa.1.1690308331572; Tue, 25 Jul 2023
 11:05:31 -0700 (PDT)
Date:   Tue, 25 Jul 2023 11:05:29 -0700
In-Reply-To: <ZLphxpSTL9Fpn1ye@yilunxu-OptiPlex-7050>
Mime-Version: 1.0
References: <20230718234512.1690985-1-seanjc@google.com> <20230718234512.1690985-2-seanjc@google.com>
 <ZLolA2U83tP75Qdd@yzhao56-desk.sh.intel.com> <ZLphxpSTL9Fpn1ye@yilunxu-OptiPlex-7050>
Message-ID: <ZMAO6bhan9l6ybQM@google.com>
Subject: Re: [RFC PATCH v11 01/29] KVM: Wrap kvm_gfn_range.pte in a per-action union
From:   Sean Christopherson <seanjc@google.com>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     Yan Zhao <yan.y.zhao@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
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

On Fri, Jul 21, 2023, Xu Yilun wrote:
> On 2023-07-21 at 14:26:11 +0800, Yan Zhao wrote:
> > On Tue, Jul 18, 2023 at 04:44:44PM -0700, Sean Christopherson wrote:
> > 
> > May I know why KVM now needs to register to callback .change_pte()?
> 
> I can see the original purpose is to "setting a pte in the shadow page
> table directly, instead of flushing the shadow page table entry and then
> getting vmexit to set it"[1].
> 
> IIUC, KVM is expected to directly make the new pte present for new
> pages in this callback, like for COW.

Yes.

> > As also commented in kvm_mmu_notifier_change_pte(), .change_pte() must be
> > surrounded by .invalidate_range_{start,end}().
> > 
> > While kvm_mmu_notifier_invalidate_range_start() has called kvm_unmap_gfn_range()
> > to zap all leaf SPTEs, and page fault path will not install new SPTEs
> > successfully before kvm_mmu_notifier_invalidate_range_end(),
> > kvm_set_spte_gfn() should not be able to find any shadow present leaf entries to
> > update PFN.
> 
> I also failed to figure out how the kvm_set_spte_gfn() could pass
> several !is_shadow_present_pte(iter.old_spte) check then write the new
> pte.

It can't.  .change_pte() has been dead code on x86 for 10+ years at this point,
and if my assessment from a few years back still holds true, it's dead code on
all architectures.

The only reason I haven't formally proposed dropping the hook is that I don't want
to risk the patch backfiring, i.e. I don't want to prompt someone to care enough
to try and fix it.

commit c13fda237f08a388ba8a0849785045944bf39834
Author: Sean Christopherson <seanjc@google.com>
Date:   Fri Apr 2 02:56:49 2021 +0200

    KVM: Assert that notifier count is elevated in .change_pte()
    
    In KVM's .change_pte() notification callback, replace the notifier
    sequence bump with a WARN_ON assertion that the notifier count is
    elevated.  An elevated count provides stricter protections than bumping
    the sequence, and the sequence is guarnateed to be bumped before the
    count hits zero.
    
    When .change_pte() was added by commit 828502d30073 ("ksm: add
    mmu_notifier set_pte_at_notify()"), bumping the sequence was necessary
    as .change_pte() would be invoked without any surrounding notifications.
    
    However, since commit 6bdb913f0a70 ("mm: wrap calls to set_pte_at_notify
    with invalidate_range_start and invalidate_range_end"), all calls to
    .change_pte() are guaranteed to be surrounded by start() and end(), and
    so are guaranteed to run with an elevated notifier count.
    
    Note, wrapping .change_pte() with .invalidate_range_{start,end}() is a
    bug of sorts, as invalidating the secondary MMU's (KVM's) PTE defeats
    the purpose of .change_pte().  Every arch's kvm_set_spte_hva() assumes
    .change_pte() is called when the relevant SPTE is present in KVM's MMU,
    as the original goal was to accelerate Kernel Samepage Merging (KSM) by
    updating KVM's SPTEs without requiring a VM-Exit (due to invalidating
    the SPTE).  I.e. it means that .change_pte() is effectively dead code
    on _all_ architectures.
    
    x86 and MIPS are clearcut nops if the old SPTE is not-present, and that
    is guaranteed due to the prior invalidation.  PPC simply unmaps the SPTE,
    which again should be a nop due to the invalidation.  arm64 is a bit
    murky, but it's also likely a nop because kvm_pgtable_stage2_map() is
    called without a cache pointer, which means it will map an entry if and
    only if an existing PTE was found.
    
    For now, take advantage of the bug to simplify future consolidation of
    KVMs's MMU notifier code.   Doing so will not greatly complicate fixing
    .change_pte(), assuming it's even worth fixing.  .change_pte() has been
    broken for 8+ years and no one has complained.  Even if there are
    KSM+KVM users that care deeply about its performance, the benefits of
    avoiding VM-Exits via .change_pte() need to be reevaluated to justify
    the added complexity and testing burden.  Ripping out .change_pte()
    entirely would be a lot easier.
