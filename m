Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4DA645424
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Dec 2022 07:42:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbiLGGm2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Dec 2022 01:42:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiLGGm1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Dec 2022 01:42:27 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CBCDE3A;
        Tue,  6 Dec 2022 22:42:26 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id w4-20020a17090ac98400b002186f5d7a4cso608811pjt.0;
        Tue, 06 Dec 2022 22:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ajKDnuwA4Us+MMWaVcyV6GgYE/6+swXfRs41D6z60TY=;
        b=OyA/HaQ+8v8ruJ2Eg4bhx+F/tuUOB98+r5uBDpuoOht2tIq16hJGL5pWwgGpHzRShd
         q2PqXuKF/+1DPHGB/wMqt4vw2SPm1W3sg9TKJanWwvNQKaxIe0BCQgTcB+/C4eZ+fr6+
         dIvZeWKmS0dL9cP7eITsVu/PJd+8PFuTQGhUGhcIpeejDyWQTXP9Ro++iYa0Kaqnh2ir
         jg89xRAWPMTSIzKivoD2YZ4qoxzup6oX3QciLjw/p7c1xk1x5yGnEMinx1o570ga6u+D
         QyPAhAN/gwiwMh1asc8pyTHq2wSRc0eYKWpI1zMimms+ikHaqU/1li+T2KD/3eXNIXt5
         y/Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ajKDnuwA4Us+MMWaVcyV6GgYE/6+swXfRs41D6z60TY=;
        b=MSxaR1biC46efJEQAxl+ByFiWW9TFaVSOqfyWaqvHEzLg0s+juK+BBTmXUtwHFLg+n
         YEo6UhxlbEilgX6+SpPIKdkJDL+w2SCMsFolYyKeRb1wmtvSxdX3W/92lkj58qMyRCTN
         vbW8114YhSMYRafte2R+JgUGmGrUocpOyKPwGq+pFxumDXCKcF8saMyNsAgwqx5ALOHQ
         lueffZjiNaX6D2NCuT1bPZ9Q8gRdLYIxuOiL7FpKcEAuWjuGOb44GUq/IC5J3OqUflAX
         U7W8aSQxbFIYW8iyjIqitvD/cZoBc9AVekJkF7keLfk5k35tW2rhpETJ/HV3gAvJRFdo
         xN8w==
X-Gm-Message-State: ANoB5plbnZXT6xedqtF0E/K07s89tcEll/GgA0KDCgQzAF/yxWJzABKe
        1vsR9b/7ScGOh5dVPwCGenU=
X-Google-Smtp-Source: AA0mqf6ab4asLGOhAGbUXQMY4V98YIPh9KklWvYNM/2t0PF0uNgvlOF3iEz2xBH0xeEJOnxeeXGBpA==
X-Received: by 2002:a17:903:330e:b0:189:57e4:c470 with SMTP id jk14-20020a170903330e00b0018957e4c470mr63949789plb.66.1670395345919;
        Tue, 06 Dec 2022 22:42:25 -0800 (PST)
Received: from localhost ([192.55.54.55])
        by smtp.gmail.com with ESMTPSA id ij19-20020a170902ab5300b001769e6d4fafsm13685126plb.57.2022.12.06.22.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 22:42:25 -0800 (PST)
Date:   Tue, 6 Dec 2022 22:42:24 -0800
From:   Isaku Yamahata <isaku.yamahata@gmail.com>
To:     Chao Peng <chao.p.peng@linux.intel.com>
Cc:     Isaku Yamahata <isaku.yamahata@gmail.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
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
        Quentin Perret <qperret@google.com>, tabba@google.com,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        wei.w.wang@intel.com
Subject: Re: [PATCH v10 7/9] KVM: Update lpage info when private/shared
 memory are mixed
Message-ID: <20221207064224.GC3632095@ls.amr.corp.intel.com>
References: <20221202061347.1070246-1-chao.p.peng@linux.intel.com>
 <20221202061347.1070246-8-chao.p.peng@linux.intel.com>
 <20221205224959.GA3632095@ls.amr.corp.intel.com>
 <20221206120224.GC1216605@chaop.bj.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221206120224.GC1216605@chaop.bj.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 06, 2022 at 08:02:24PM +0800,
Chao Peng <chao.p.peng@linux.intel.com> wrote:

> On Mon, Dec 05, 2022 at 02:49:59PM -0800, Isaku Yamahata wrote:
> > On Fri, Dec 02, 2022 at 02:13:45PM +0800,
> > Chao Peng <chao.p.peng@linux.intel.com> wrote:
> > 
> > > A large page with mixed private/shared subpages can't be mapped as large
> > > page since its sub private/shared pages are from different memory
> > > backends and may also treated by architecture differently. When
> > > private/shared memory are mixed in a large page, the current lpage_info
> > > is not sufficient to decide whether the page can be mapped as large page
> > > or not and additional private/shared mixed information is needed.
> > > 
> > > Tracking this 'mixed' information with the current 'count' like
> > > disallow_lpage is a bit challenge so reserve a bit in 'disallow_lpage'
> > > to indicate a large page has mixed private/share subpages and update
> > > this 'mixed' bit whenever the memory attribute is changed between
> > > private and shared.
> > > 
> > > Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> > > ---
> > >  arch/x86/include/asm/kvm_host.h |   8 ++
> > >  arch/x86/kvm/mmu/mmu.c          | 134 +++++++++++++++++++++++++++++++-
> > >  arch/x86/kvm/x86.c              |   2 +
> > >  include/linux/kvm_host.h        |  19 +++++
> > >  virt/kvm/kvm_main.c             |   9 ++-
> > >  5 files changed, 169 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> > > index 283cbb83d6ae..7772ab37ac89 100644
> > > --- a/arch/x86/include/asm/kvm_host.h
> > > +++ b/arch/x86/include/asm/kvm_host.h
> > > @@ -38,6 +38,7 @@
> > >  #include <asm/hyperv-tlfs.h>
> > >  
> > >  #define __KVM_HAVE_ARCH_VCPU_DEBUGFS
> > > +#define __KVM_HAVE_ARCH_SET_MEMORY_ATTRIBUTES
> > >  
> > >  #define KVM_MAX_VCPUS 1024
> > >  
> > > @@ -1011,6 +1012,13 @@ struct kvm_vcpu_arch {
> > >  #endif
> > >  };
> > >  
> > > +/*
> > > + * Use a bit in disallow_lpage to indicate private/shared pages mixed at the
> > > + * level. The remaining bits are used as a reference count.
> > > + */
> > > +#define KVM_LPAGE_PRIVATE_SHARED_MIXED		(1U << 31)
> > > +#define KVM_LPAGE_COUNT_MAX			((1U << 31) - 1)
> > > +
> > >  struct kvm_lpage_info {
> > >  	int disallow_lpage;
> > >  };
> > > diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> > > index e2c70b5afa3e..2190fd8c95c0 100644
> > > --- a/arch/x86/kvm/mmu/mmu.c
> > > +++ b/arch/x86/kvm/mmu/mmu.c
> > > @@ -763,11 +763,16 @@ static void update_gfn_disallow_lpage_count(const struct kvm_memory_slot *slot,
> > >  {
> > >  	struct kvm_lpage_info *linfo;
> > >  	int i;
> > > +	int disallow_count;
> > >  
> > >  	for (i = PG_LEVEL_2M; i <= KVM_MAX_HUGEPAGE_LEVEL; ++i) {
> > >  		linfo = lpage_info_slot(gfn, slot, i);
> > > +
> > > +		disallow_count = linfo->disallow_lpage & KVM_LPAGE_COUNT_MAX;
> > > +		WARN_ON(disallow_count + count < 0 ||
> > > +			disallow_count > KVM_LPAGE_COUNT_MAX - count);
> > > +
> > >  		linfo->disallow_lpage += count;
> > > -		WARN_ON(linfo->disallow_lpage < 0);
> > >  	}
> > >  }
> > >  
> > > @@ -6986,3 +6991,130 @@ void kvm_mmu_pre_destroy_vm(struct kvm *kvm)
> > >  	if (kvm->arch.nx_huge_page_recovery_thread)
> > >  		kthread_stop(kvm->arch.nx_huge_page_recovery_thread);
> > >  }
> > > +
> > > +static bool linfo_is_mixed(struct kvm_lpage_info *linfo)
> > > +{
> > > +	return linfo->disallow_lpage & KVM_LPAGE_PRIVATE_SHARED_MIXED;
> > > +}
> > > +
> > > +static void linfo_set_mixed(gfn_t gfn, struct kvm_memory_slot *slot,
> > > +			    int level, bool mixed)
> > > +{
> > > +	struct kvm_lpage_info *linfo = lpage_info_slot(gfn, slot, level);
> > > +
> > > +	if (mixed)
> > > +		linfo->disallow_lpage |= KVM_LPAGE_PRIVATE_SHARED_MIXED;
> > > +	else
> > > +		linfo->disallow_lpage &= ~KVM_LPAGE_PRIVATE_SHARED_MIXED;
> > > +}
> > > +
> > > +static bool is_expected_attr_entry(void *entry, unsigned long expected_attrs)
> > > +{
> > > +	bool expect_private = expected_attrs & KVM_MEMORY_ATTRIBUTE_PRIVATE;
> > > +
> > > +	if (xa_to_value(entry) & KVM_MEMORY_ATTRIBUTE_PRIVATE) {
> > > +		if (!expect_private)
> > > +			return false;
> > > +	} else if (expect_private)
> > > +		return false;
> > > +
> > > +	return true;
> > > +}
> > > +
> > > +static bool mem_attrs_mixed_2m(struct kvm *kvm, unsigned long attrs,
> > > +			       gfn_t start, gfn_t end)
> > > +{
> > > +	XA_STATE(xas, &kvm->mem_attr_array, start);
> > > +	gfn_t gfn = start;
> > > +	void *entry;
> > > +	bool mixed = false;
> > > +
> > > +	rcu_read_lock();
> > > +	entry = xas_load(&xas);
> > > +	while (gfn < end) {
> > > +		if (xas_retry(&xas, entry))
> > > +			continue;
> > > +
> > > +		KVM_BUG_ON(gfn != xas.xa_index, kvm);
> > > +
> > > +		if (!is_expected_attr_entry(entry, attrs)) {
> > > +			mixed = true;
> > > +			break;
> > > +		}
> > > +
> > > +		entry = xas_next(&xas);
> > > +		gfn++;
> > > +	}
> > > +
> > > +	rcu_read_unlock();
> > > +	return mixed;
> > > +}
> > > +
> > > +static bool mem_attrs_mixed(struct kvm *kvm, struct kvm_memory_slot *slot,
> > > +			    int level, unsigned long attrs,
> > > +			    gfn_t start, gfn_t end)
> > > +{
> > > +	unsigned long gfn;
> > > +
> > > +	if (level == PG_LEVEL_2M)
> > > +		return mem_attrs_mixed_2m(kvm, attrs, start, end);
> > > +
> > > +	for (gfn = start; gfn < end; gfn += KVM_PAGES_PER_HPAGE(level - 1))
> > > +		if (linfo_is_mixed(lpage_info_slot(gfn, slot, level - 1)) ||
> > > +		    !is_expected_attr_entry(xa_load(&kvm->mem_attr_array, gfn),
> > > +					    attrs))
> > > +			return true;
> > > +	return false;
> > > +}
> > > +
> > > +static void kvm_update_lpage_private_shared_mixed(struct kvm *kvm,
> > > +						  struct kvm_memory_slot *slot,
> > > +						  unsigned long attrs,
> > > +						  gfn_t start, gfn_t end)
> > > +{
> > > +	unsigned long pages, mask;
> > > +	gfn_t gfn, gfn_end, first, last;
> > > +	int level;
> > > +	bool mixed;
> > > +
> > > +	/*
> > > +	 * The sequence matters here: we set the higher level basing on the
> > > +	 * lower level's scanning result.
> > > +	 */
> > > +	for (level = PG_LEVEL_2M; level <= KVM_MAX_HUGEPAGE_LEVEL; level++) {
> > > +		pages = KVM_PAGES_PER_HPAGE(level);
> > > +		mask = ~(pages - 1);
> > > +		first = start & mask;
> > > +		last = (end - 1) & mask;
> > > +
> > > +		/*
> > > +		 * We only need to scan the head and tail page, for middle pages
> > > +		 * we know they will not be mixed.
> > > +		 */
> > > +		gfn = max(first, slot->base_gfn);
> > > +		gfn_end = min(first + pages, slot->base_gfn + slot->npages);
> > > +		mixed = mem_attrs_mixed(kvm, slot, level, attrs, gfn, gfn_end);
> > > +		linfo_set_mixed(gfn, slot, level, mixed);
> > > +
> > > +		if (first == last)
> > > +			return;
> > 
> > 
> > continue.
> 
> Ya!
> 
> > 
> > > +
> > > +		for (gfn = first + pages; gfn < last; gfn += pages)
> > > +			linfo_set_mixed(gfn, slot, level, false);
> > > +
> > > +		gfn = last;
> > > +		gfn_end = min(last + pages, slot->base_gfn + slot->npages);
> > 
> > if (gfn == gfn_end) continue.
> 
> Do you see a case where gfn can equal to gfn_end? Though it does not
> hurt to add a check.

If last == base_gfn + npages, gfn == gfn_end can occur.


> > > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > > index 9a07380f8d3c..5aefcff614d2 100644
> > > --- a/arch/x86/kvm/x86.c
> > > +++ b/arch/x86/kvm/x86.c
> > > @@ -12362,6 +12362,8 @@ static int kvm_alloc_memslot_metadata(struct kvm *kvm,
> > >  		if ((slot->base_gfn + npages) & (KVM_PAGES_PER_HPAGE(level) - 1))
> > >  			linfo[lpages - 1].disallow_lpage = 1;
> > >  		ugfn = slot->userspace_addr >> PAGE_SHIFT;
> > > +		if (kvm_slot_can_be_private(slot))
> > > +			ugfn |= slot->restricted_offset >> PAGE_SHIFT;
> > 
> > Is there any alignment restriction? If no, It should be +=.
> > In practice, alignment will hold though.
> 
> All we need here is checking whether both userspace_addr and
> restricted_offset are aligned to HPAGE_SIZE or not. '+=' actually can
> yield wrong value in cases when userspace_addr + restricted_offset is
> aligned to HPAGE_SIZE but individually they may not align to HPAGE_SIZE.

Ah, got it. The blow comment explains it.

> Thanks,
> Chao
> > 
> > Thanks,
> > 
> > >  		/*
> > >  		 * If the gfn and userspace address are not aligned wrt each
> > >  		 * other, disable large page support for this slot.
-- 
Isaku Yamahata <isaku.yamahata@gmail.com>
