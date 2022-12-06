Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD2A3644858
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Dec 2022 16:50:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234115AbiLFPt4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Dec 2022 10:49:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233864AbiLFPtb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Dec 2022 10:49:31 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B43AD286D5
        for <linux-fsdevel@vger.kernel.org>; Tue,  6 Dec 2022 07:49:28 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id h10so17669837ljk.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Dec 2022 07:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZgXzVCO1OCRwjAZ65xIfYxlpH5JEmDjmLd1r8UgB90I=;
        b=YDlQIMLZ1TrD8HLPFmpAy1nUjSqrC6DimAKnD5PX/9U/Hkfbl+PAuaqn6eyudePAL/
         XdAO4Y2LJu8jK/u/vHUKJ4Yrg4Bu6CcI9Cp13NQSd4EEALaMTAF43oGOBbkSHLMWJZew
         VBVjPJhisKdIegVeU2j+I1gfsP+HHDHSdHqItbK0ObvCJ3vGHDcvYAVHdqiK+hpVDt6A
         aGqh+YFoCDDnlu6vbz0TU8iT9GjKwmc4omVbFWDhRxxhtyC86vojtae5sUA2v56QZaQS
         XofeqJgFBJ7sIBVYgxziNf/pL9NIeN66U/SJva0SZj6ungKTfSgVexSSbj4DvlFx82mM
         v0tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZgXzVCO1OCRwjAZ65xIfYxlpH5JEmDjmLd1r8UgB90I=;
        b=td+pgxfwBNnP/2SmTsSDwINj/LZ6dqIs8sjzkfBHJzeN1XSX5f6HAPxSo082EJFMsU
         1aXF0CZtuoJb8oXp8BJ8jqJr7QCQCFOl5WlCr3oNI+x2G0uMg2eNcutSroLl3GZVPj6O
         EA+hGEQrQF0a8nkyk8aB7KLG9Ke7KPBGDCzltsyE35a1LwLdF5EIcGkf7/kt+LBW4p+/
         DqewSBjmrjZXhjKurD4Gs9SzAhyDT4vB2kz1DFRK0gf4FDE1qXzZDDM20xMG38dd1pau
         Aovpby8EXkDvhUW95bosI0i1Nh52vUTJnDpwQp+uRuIhTqOtJ3WAZ/320WGKFmAsVYmC
         lN6g==
X-Gm-Message-State: ANoB5pk+th7xF1zpavDdkRLpiGHCY9p+VSrdToNWdB1wxZyGxNFvKwqe
        45TWefpVD7oD++LOF9uPOZZb9MSGvH75qF1wRvbsNQ==
X-Google-Smtp-Source: AA0mqf53ULfcaVf99mN6yfwo/i5dAXkqh588pxGSl1Mpx6AZ2ttTevA2OsFQ6+Jwt2fKkYQ85oGqqCkL/Y3QkpgFpUk=
X-Received: by 2002:a2e:964c:0:b0:279:f197:440d with SMTP id
 z12-20020a2e964c000000b00279f197440dmr4247034ljh.517.1670341766820; Tue, 06
 Dec 2022 07:49:26 -0800 (PST)
MIME-Version: 1.0
References: <20221202061347.1070246-1-chao.p.peng@linux.intel.com>
 <20221202061347.1070246-6-chao.p.peng@linux.intel.com> <CA+EHjTy5+Ke_7Uh72p--H9kGcE-PK4EVmp7ym6Q1-PO28u6CCQ@mail.gmail.com>
 <20221206115623.GB1216605@chaop.bj.intel.com>
In-Reply-To: <20221206115623.GB1216605@chaop.bj.intel.com>
From:   Fuad Tabba <tabba@google.com>
Date:   Tue, 6 Dec 2022 15:48:50 +0000
Message-ID: <CA+EHjTx3_Vkh9Jb_ZJNi5Xx=O24eM-jpF0gR+UGf9W0ORgNyhQ@mail.gmail.com>
Subject: Re: [PATCH v10 5/9] KVM: Use gfn instead of hva for mmu_notifier_retry
To:     Chao Peng <chao.p.peng@linux.intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Miaohe Lin <linmiaohe@huawei.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, Hugh Dickins <hughd@google.com>,
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
        ak@linux.intel.com, david@redhat.com, aarcange@redhat.com,
        ddutile@redhat.com, dhildenb@redhat.com,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        wei.w.wang@intel.com
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

On Tue, Dec 6, 2022 at 12:01 PM Chao Peng <chao.p.peng@linux.intel.com> wrote:
>
> On Mon, Dec 05, 2022 at 09:23:49AM +0000, Fuad Tabba wrote:
> > Hi Chao,
> >
> > On Fri, Dec 2, 2022 at 6:19 AM Chao Peng <chao.p.peng@linux.intel.com> wrote:
> > >
> > > Currently in mmu_notifier invalidate path, hva range is recorded and
> > > then checked against by mmu_notifier_retry_hva() in the page fault
> > > handling path. However, for the to be introduced private memory, a page
> > > fault may not have a hva associated, checking gfn(gpa) makes more sense.
> > >
> > > For existing hva based shared memory, gfn is expected to also work. The
> > > only downside is when aliasing multiple gfns to a single hva, the
> > > current algorithm of checking multiple ranges could result in a much
> > > larger range being rejected. Such aliasing should be uncommon, so the
> > > impact is expected small.
> > >
> > > Suggested-by: Sean Christopherson <seanjc@google.com>
> > > Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> > > ---
> > >  arch/x86/kvm/mmu/mmu.c   |  8 +++++---
> > >  include/linux/kvm_host.h | 33 +++++++++++++++++++++------------
> > >  virt/kvm/kvm_main.c      | 32 +++++++++++++++++++++++---------
> > >  3 files changed, 49 insertions(+), 24 deletions(-)
> > >
> > > diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> > > index 4736d7849c60..e2c70b5afa3e 100644
> > > --- a/arch/x86/kvm/mmu/mmu.c
> > > +++ b/arch/x86/kvm/mmu/mmu.c
> > > @@ -4259,7 +4259,7 @@ static bool is_page_fault_stale(struct kvm_vcpu *vcpu,
> > >                 return true;
> > >
> > >         return fault->slot &&
> > > -              mmu_invalidate_retry_hva(vcpu->kvm, mmu_seq, fault->hva);
> > > +              mmu_invalidate_retry_gfn(vcpu->kvm, mmu_seq, fault->gfn);
> > >  }
> > >
> > >  static int direct_page_fault(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
> > > @@ -6098,7 +6098,9 @@ void kvm_zap_gfn_range(struct kvm *kvm, gfn_t gfn_start, gfn_t gfn_end)
> > >
> > >         write_lock(&kvm->mmu_lock);
> > >
> > > -       kvm_mmu_invalidate_begin(kvm, gfn_start, gfn_end);
> > > +       kvm_mmu_invalidate_begin(kvm);
> > > +
> > > +       kvm_mmu_invalidate_range_add(kvm, gfn_start, gfn_end);
> > >
> > >         flush = kvm_rmap_zap_gfn_range(kvm, gfn_start, gfn_end);
> > >
> > > @@ -6112,7 +6114,7 @@ void kvm_zap_gfn_range(struct kvm *kvm, gfn_t gfn_start, gfn_t gfn_end)
> > >                 kvm_flush_remote_tlbs_with_address(kvm, gfn_start,
> > >                                                    gfn_end - gfn_start);
> > >
> > > -       kvm_mmu_invalidate_end(kvm, gfn_start, gfn_end);
> > > +       kvm_mmu_invalidate_end(kvm);
> > >
> > >         write_unlock(&kvm->mmu_lock);
> > >  }
> > > diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> > > index 02347e386ea2..3d69484d2704 100644
> > > --- a/include/linux/kvm_host.h
> > > +++ b/include/linux/kvm_host.h
> > > @@ -787,8 +787,8 @@ struct kvm {
> > >         struct mmu_notifier mmu_notifier;
> > >         unsigned long mmu_invalidate_seq;
> > >         long mmu_invalidate_in_progress;
> > > -       unsigned long mmu_invalidate_range_start;
> > > -       unsigned long mmu_invalidate_range_end;
> > > +       gfn_t mmu_invalidate_range_start;
> > > +       gfn_t mmu_invalidate_range_end;
> > >  #endif
> > >         struct list_head devices;
> > >         u64 manual_dirty_log_protect;
> > > @@ -1389,10 +1389,9 @@ void kvm_mmu_free_memory_cache(struct kvm_mmu_memory_cache *mc);
> > >  void *kvm_mmu_memory_cache_alloc(struct kvm_mmu_memory_cache *mc);
> > >  #endif
> > >
> > > -void kvm_mmu_invalidate_begin(struct kvm *kvm, unsigned long start,
> > > -                             unsigned long end);
> > > -void kvm_mmu_invalidate_end(struct kvm *kvm, unsigned long start,
> > > -                           unsigned long end);
> > > +void kvm_mmu_invalidate_begin(struct kvm *kvm);
> > > +void kvm_mmu_invalidate_range_add(struct kvm *kvm, gfn_t start, gfn_t end);
> > > +void kvm_mmu_invalidate_end(struct kvm *kvm);
> > >
> > >  long kvm_arch_dev_ioctl(struct file *filp,
> > >                         unsigned int ioctl, unsigned long arg);
> > > @@ -1963,9 +1962,9 @@ static inline int mmu_invalidate_retry(struct kvm *kvm, unsigned long mmu_seq)
> > >         return 0;
> > >  }
> > >
> > > -static inline int mmu_invalidate_retry_hva(struct kvm *kvm,
> > > +static inline int mmu_invalidate_retry_gfn(struct kvm *kvm,
> > >                                            unsigned long mmu_seq,
> > > -                                          unsigned long hva)
> > > +                                          gfn_t gfn)
> > >  {
> > >         lockdep_assert_held(&kvm->mmu_lock);
> > >         /*
> > > @@ -1974,10 +1973,20 @@ static inline int mmu_invalidate_retry_hva(struct kvm *kvm,
> > >          * that might be being invalidated. Note that it may include some false
> >
> > nit: "might be" (or) "is being"
> >
> > >          * positives, due to shortcuts when handing concurrent invalidations.
> >
> > nit: handling
>
> Both are existing code, but I can fix it either.

That was just a nit, please feel free to ignore it, especially if it
might cause headaches in the future with merges.
>
> >
> > >          */
> > > -       if (unlikely(kvm->mmu_invalidate_in_progress) &&
> > > -           hva >= kvm->mmu_invalidate_range_start &&
> > > -           hva < kvm->mmu_invalidate_range_end)
> > > -               return 1;
> > > +       if (unlikely(kvm->mmu_invalidate_in_progress)) {
> > > +               /*
> > > +                * Dropping mmu_lock after bumping mmu_invalidate_in_progress
> > > +                * but before updating the range is a KVM bug.
> > > +                */
> > > +               if (WARN_ON_ONCE(kvm->mmu_invalidate_range_start == INVALID_GPA ||
> > > +                                kvm->mmu_invalidate_range_end == INVALID_GPA))
> >
> > INVALID_GPA is an x86-specific define in
> > arch/x86/include/asm/kvm_host.h, so this doesn't build on other
> > architectures. The obvious fix is to move it to
> > include/linux/kvm_host.h.
>
> Hmm, INVALID_GPA is defined as ZERO for x86, not 100% confident this is
> correct choice for other architectures, but after search it has not been
> used for other architectures, so should be safe to make it common.

With this fixed,

Reviewed-by: Fuad Tabba <tabba@google.com>
And the necessary work to port to arm64 (on qemu/arm64):
Tested-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad


>
> Thanks,
> Chao
> >
> > Cheers,
> > /fuad
> >
> > > +                       return 1;
> > > +
> > > +               if (gfn >= kvm->mmu_invalidate_range_start &&
> > > +                   gfn < kvm->mmu_invalidate_range_end)
> > > +                       return 1;
> > > +       }
> > > +
> > >         if (kvm->mmu_invalidate_seq != mmu_seq)
> > >                 return 1;
> > >         return 0;
> > > diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> > > index b882eb2c76a2..ad55dfbc75d7 100644
> > > --- a/virt/kvm/kvm_main.c
> > > +++ b/virt/kvm/kvm_main.c
> > > @@ -540,9 +540,7 @@ static void kvm_mmu_notifier_invalidate_range(struct mmu_notifier *mn,
> > >
> > >  typedef bool (*hva_handler_t)(struct kvm *kvm, struct kvm_gfn_range *range);
> > >
> > > -typedef void (*on_lock_fn_t)(struct kvm *kvm, unsigned long start,
> > > -                            unsigned long end);
> > > -
> > > +typedef void (*on_lock_fn_t)(struct kvm *kvm);
> > >  typedef void (*on_unlock_fn_t)(struct kvm *kvm);
> > >
> > >  struct kvm_hva_range {
> > > @@ -628,7 +626,8 @@ static __always_inline int __kvm_handle_hva_range(struct kvm *kvm,
> > >                                 locked = true;
> > >                                 KVM_MMU_LOCK(kvm);
> > >                                 if (!IS_KVM_NULL_FN(range->on_lock))
> > > -                                       range->on_lock(kvm, range->start, range->end);
> > > +                                       range->on_lock(kvm);
> > > +
> > >                                 if (IS_KVM_NULL_FN(range->handler))
> > >                                         break;
> > >                         }
> > > @@ -715,8 +714,7 @@ static void kvm_mmu_notifier_change_pte(struct mmu_notifier *mn,
> > >         kvm_handle_hva_range(mn, address, address + 1, pte, kvm_set_spte_gfn);
> > >  }
> > >
> > > -void kvm_mmu_invalidate_begin(struct kvm *kvm, unsigned long start,
> > > -                             unsigned long end)
> > > +void kvm_mmu_invalidate_begin(struct kvm *kvm)
> > >  {
> > >         /*
> > >          * The count increase must become visible at unlock time as no
> > > @@ -724,6 +722,17 @@ void kvm_mmu_invalidate_begin(struct kvm *kvm, unsigned long start,
> > >          * count is also read inside the mmu_lock critical section.
> > >          */
> > >         kvm->mmu_invalidate_in_progress++;
> > > +
> > > +       if (likely(kvm->mmu_invalidate_in_progress == 1)) {
> > > +               kvm->mmu_invalidate_range_start = INVALID_GPA;
> > > +               kvm->mmu_invalidate_range_end = INVALID_GPA;
> > > +       }
> > > +}
> > > +
> > > +void kvm_mmu_invalidate_range_add(struct kvm *kvm, gfn_t start, gfn_t end)
> > > +{
> > > +       WARN_ON_ONCE(!kvm->mmu_invalidate_in_progress);
> > > +
> > >         if (likely(kvm->mmu_invalidate_in_progress == 1)) {
> > >                 kvm->mmu_invalidate_range_start = start;
> > >                 kvm->mmu_invalidate_range_end = end;
> > > @@ -744,6 +753,12 @@ void kvm_mmu_invalidate_begin(struct kvm *kvm, unsigned long start,
> > >         }
> > >  }
> > >
> > > +static bool kvm_mmu_unmap_gfn_range(struct kvm *kvm, struct kvm_gfn_range *range)
> > > +{
> > > +       kvm_mmu_invalidate_range_add(kvm, range->start, range->end);
> > > +       return kvm_unmap_gfn_range(kvm, range);
> > > +}
> > > +
> > >  static int kvm_mmu_notifier_invalidate_range_start(struct mmu_notifier *mn,
> > >                                         const struct mmu_notifier_range *range)
> > >  {
> > > @@ -752,7 +767,7 @@ static int kvm_mmu_notifier_invalidate_range_start(struct mmu_notifier *mn,
> > >                 .start          = range->start,
> > >                 .end            = range->end,
> > >                 .pte            = __pte(0),
> > > -               .handler        = kvm_unmap_gfn_range,
> > > +               .handler        = kvm_mmu_unmap_gfn_range,
> > >                 .on_lock        = kvm_mmu_invalidate_begin,
> > >                 .on_unlock      = kvm_arch_guest_memory_reclaimed,
> > >                 .flush_on_ret   = true,
> > > @@ -791,8 +806,7 @@ static int kvm_mmu_notifier_invalidate_range_start(struct mmu_notifier *mn,
> > >         return 0;
> > >  }
> > >
> > > -void kvm_mmu_invalidate_end(struct kvm *kvm, unsigned long start,
> > > -                           unsigned long end)
> > > +void kvm_mmu_invalidate_end(struct kvm *kvm)
> > >  {
> > >         /*
> > >          * This sequence increase will notify the kvm page fault that
> > > --
> > > 2.25.1
> > >
