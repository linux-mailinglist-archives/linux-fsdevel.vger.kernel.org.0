Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E94170FF08
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 May 2023 22:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236376AbjEXUQO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 May 2023 16:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjEXUQJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 May 2023 16:16:09 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D04BC186
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 May 2023 13:16:05 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-ba802c775caso2605618276.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 May 2023 13:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684959365; x=1687551365;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=et28JU3wkykvEfV7tUaeZmOsEZymHIt/E70MuyiU1No=;
        b=G2x7cKfO2HsF6MKrRXtuGOoWc4Yj9Z0Q1nyrd66b5CwhWsYKjq6PGytnNGnWnoUbYg
         0jM5j8y6re71Mo5bG/5Ojl0FuWMuSP9Eaoaxj5HQpFpkslAfyM1khFmi/TCdIov7pGs1
         35dPUO8OrPbZFQbz/PVLHobvQlt75SleU+2ukbo6ZGqKu4GeU1PfbY6dp1LYUPK5l9gh
         L9G4O1nBLIgKKq1HPdPHhPEBqnrucIszUNCbUVyzwlbALVm3SP6WSm1IH5u9OT/3syhL
         D/r8JPmU9oz+tOmHzugTg/xI95+Lz3S8lUd5+91fPkwHf4Yn5e/eFKasubnMlzF3zHuL
         SiTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684959365; x=1687551365;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=et28JU3wkykvEfV7tUaeZmOsEZymHIt/E70MuyiU1No=;
        b=LBwr8q/pwlaT4kNqtxRbhg0sbquRX4WYkSPQmmvHLmoK2a+MzNRF9ebf9QAL2Ukgvv
         1uq3p7l6RcycR58XrpShF7zgr2XZygkrg3n+Zz8BTvwUST1pyN7c+4n/wz4dXc420VAp
         qv23CrQFWDo0wOiwlA7nd4tGUSclTtu9THfacAa+AbvuZvFRhtJri6+KM9qvzxoFVN7v
         ky8HVVsi3M9ls7+OMzjOx12vWSyH1AJY4ZMP5VGOE3luUVulHqBdOqpVVuLQm25LqTPF
         yKLLMFxd6AeON2lWGyydWBxJRZxJxlDELiCOIfkWwRQBK35nlYn5jTpM/itYC3lLMVYE
         bWQg==
X-Gm-Message-State: AC+VfDysZvyCjluWyI+eW62D/K6yGD70d8f2lumo8u32FX2O2J6r0cFr
        +UFeXbweio0d0U3aP+oWeBFDjIJkAFU=
X-Google-Smtp-Source: ACHHUZ6+sl+l+zuedDR2LRUIRB6sxCHVVBdT9tzV4JiB2otIi8oPUFcdAUNp1gY5P1OZhcp9jKCI0u1SitE=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:ba05:0:b0:ba8:95dd:3ccb with SMTP id
 t5-20020a25ba05000000b00ba895dd3ccbmr566879ybg.5.1684959365091; Wed, 24 May
 2023 13:16:05 -0700 (PDT)
Date:   Wed, 24 May 2023 13:16:03 -0700
In-Reply-To: <ZG2qv9sWl2RUnGqd@li-a450e7cc-27df-11b2-a85c-b5a9ac31e8ef.ibm.com>
Mime-Version: 1.0
References: <20220706082016.2603916-1-chao.p.peng@linux.intel.com>
 <20220706082016.2603916-9-chao.p.peng@linux.intel.com> <ZGxo9ylqYI8JXjGn@li-a450e7cc-27df-11b2-a85c-b5a9ac31e8ef.ibm.com>
 <ZGzLf4zgxpBjghaF@google.com> <ZG2qv9sWl2RUnGqd@li-a450e7cc-27df-11b2-a85c-b5a9ac31e8ef.ibm.com>
Message-ID: <ZG5wg3VbG4rCYrfk@google.com>
Subject: Re: [PATCH v7 08/14] KVM: Rename mmu_notifier_*
From:   Sean Christopherson <seanjc@google.com>
To:     Kautuk Consul <kconsul@linux.vnet.ibm.com>
Cc:     Chao Peng <chao.p.peng@linux.intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org,
        linux-kselftest@vger.kernel.org,
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
        ak@linux.intel.com, david@redhat.com, aarcange@redhat.com,
        ddutile@redhat.com, dhildenb@redhat.com,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>
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

On Wed, May 24, 2023, Kautuk Consul wrote:
> On 2023-05-23 07:19:43, Sean Christopherson wrote:
> > On Tue, May 23, 2023, Kautuk Consul wrote:
> > > On 2022-07-06 16:20:10, Chao Peng wrote:
> > > > diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> > > > index e9153b54e2a4..c262ebb168a7 100644
> > > > --- a/include/linux/kvm_host.h
> > > > +++ b/include/linux/kvm_host.h
> > > > @@ -765,10 +765,10 @@ struct kvm {
> > > >  
> > > >  #if defined(CONFIG_MMU_NOTIFIER) && defined(KVM_ARCH_WANT_MMU_NOTIFIER)
> > > >  	struct mmu_notifier mmu_notifier;
> > > > -	unsigned long mmu_notifier_seq;
> > > > -	long mmu_notifier_count;
> > > > -	gfn_t mmu_notifier_range_start;
> > > > -	gfn_t mmu_notifier_range_end;
> > > > +	unsigned long mmu_updating_seq;
> > > > +	long mmu_updating_count;
> > > 
> > > Can we convert mmu_updating_seq and mmu_updating_count to atomic_t ?
> > 
> > Heh, can we?  Yes.  Should we?  No.
> > 
> > > I see that not all accesses to these are under the kvm->mmu_lock
> > > spinlock.
> > 
> > Ya, working as intended.  Ignoring gfn_to_pfn_cache for the moment, all accesses
> > to mmu_invalidate_in_progress (was mmu_notifier_count / mmu_updating_count above)
> > are done under mmu_lock.  And for for mmu_notifier_seq (mmu_updating_seq above),
> > all writes and some reads are done under mmu_lock.  The only reads that are done
> > outside of mmu_lock are the initial snapshots of the sequence number.
> > 
> > gfn_to_pfn_cache uses a different locking scheme, the comments in
> > mmu_notifier_retry_cache() do a good job explaining the ordering.
> > 
> > > This will also remove the need for putting separate smp_wmb() and
> > > smp_rmb() memory barriers while accessing these structure members.
> > 
> > No, the memory barriers aren't there to provide any kind of atomicity.  The barriers
> > exist to ensure that stores and loads to/from the sequence and invalidate in-progress
> > counts are ordered relative to the invalidation (stores to counts) and creation (loads)
> > of SPTEs.  Making the counts atomic changes nothing because atomic operations don't
> > guarantee the necessary ordering.
> I'm not saying that the memory barriers provide atomicity.
> My comment was based on the assumption that "all atomic operations are
> implicit memory barriers". If that assumption is true then we won't need
> the memory barriers here if we use atomic operations for protecting
> these 2 structure members.

Atomics aren't memory barriers on all architectures, e.g. see the various
definitions of smp_mb__after_atomic().

Even if atomic operations did provide barriers, using an atomic would be overkill
and a net negative.  On strongly ordered architectures like x86, memory barriers are
just compiler barriers, whereas atomics may be more expensive.  Of course, the only
accesses outside of mmu_lock are reads, so on x86 that "atomic" access is just a
READ_ONCE() load, but that's not the case for all architectures.

Anyways, the point is that atomics and memory barriers are different things that
serve different purposes.
