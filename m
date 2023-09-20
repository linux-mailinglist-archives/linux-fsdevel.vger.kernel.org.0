Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCB867A866B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Sep 2023 16:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235091AbjITOYW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Sep 2023 10:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235092AbjITOYT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Sep 2023 10:24:19 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96555CE
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Sep 2023 07:24:10 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1c395534687so59647715ad.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Sep 2023 07:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695219850; x=1695824650; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DOI6e5Fz0eSccYOGv0a2XgOrMIQyrqURVkPdu4XpUSk=;
        b=OdKcggWCZY2WLZg3BR5y9Qaj6VyhXLyvl6oJlR09C7EAcdWY7dpuz50dDSjkdtsSix
         RMq4f2c/gEEGfZc3SPb7ZbGg38xceu/gcoJCvba3XRu7T9YAfJmD94dU2FUkIKE8Scpv
         AjMy76ufmRmNk7SZqkvRXWqyoQMPu2HUzT3Xi1u7MZjreQ/5XUKrlvPn57iY//9mAIEO
         uhPy6gEzm3RXtu+TSpKXLcEc//YAmg35x5qKKnXJG/tuB4GKwyzMKJABJ8gPnDz/mO6q
         /giYzhixp+w5k4J00eWuKJF+0OWk+J0bGfmL7vSpMRs5E9O8HO4hXDdrjVXFbI0ThYsn
         eOqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695219850; x=1695824650;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DOI6e5Fz0eSccYOGv0a2XgOrMIQyrqURVkPdu4XpUSk=;
        b=kjEL4LDPYNsN9o125jNIlNT8Y6kFTxIYaenbjALm/Zx6BhWG4g/uKIwcC9sm8nL7Dm
         NrXuWGS+GFpsL/0DLxaiWhQS7VwzkySJGpxtg3O4EYHBPs4jJbENg7Ca1hLhyNUHnZ7s
         0uhm2TFXu90/5D+52IDucv67Q6T7Sfs+dmElSyh2ghqdAyzAe/oUNlOFj8kbiGazm/CJ
         Xk27mWZc2lDesqqI/2Olg6qecjf0t+HcLWvIyTazddFVd7DqFx/Agp94zCYKEoKD/+Qv
         1fmFT1O15897+0aqJMuffeiD0H6hszUvaQ9jJj14FqNX94DcrIiEZL3bogG5Dh44V66v
         48Rg==
X-Gm-Message-State: AOJu0YyctcwHUAKHLiNTLyt5dxoEF+y4pfROoLg6pLyGq51bJie4mety
        AfTSr3aS3+QvBwTEtCkIiEqbX4XiHLA=
X-Google-Smtp-Source: AGHT+IG+7+KaIB01fLVIPGeb7tjb/zu/hrsNFs+xXo/mmyM/aDSVQYbb0kWI4ACm+gkgu18FM/xCEI0V+P0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:f203:b0:1c0:ac09:4032 with SMTP id
 m3-20020a170902f20300b001c0ac094032mr25326plc.9.1695219850013; Wed, 20 Sep
 2023 07:24:10 -0700 (PDT)
Date:   Wed, 20 Sep 2023 07:24:08 -0700
In-Reply-To: <e397d30c-c6af-e68f-d18e-b4e3739c5389@linux.intel.com>
Mime-Version: 1.0
References: <20230914015531.1419405-1-seanjc@google.com> <20230914015531.1419405-15-seanjc@google.com>
 <e397d30c-c6af-e68f-d18e-b4e3739c5389@linux.intel.com>
Message-ID: <ZQsAiGuw/38jIOV7@google.com>
Subject: Re: [RFC PATCH v12 14/33] KVM: Add KVM_CREATE_GUEST_MEMFD ioctl() for
 guest-specific backing memory
From:   Sean Christopherson <seanjc@google.com>
To:     Binbin Wu <binbin.wu@linux.intel.com>
Cc:     kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.linux.dev, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
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
        "Serge E. Hallyn" <serge@hallyn.com>,
        Chao Peng <chao.p.peng@linux.intel.com>,
        Fuad Tabba <tabba@google.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Anish Moorthy <amoorthy@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        Xu Yilun <yilun.xu@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Ackerley Tng <ackerleytng@google.com>,
        Maciej Szmigiero <mail@maciej.szmigiero.name>,
        David Hildenbrand <david@redhat.com>,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>,
        Wang <wei.w.wang@intel.com>,
        Liam Merwick <liam.merwick@oracle.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 19, 2023, Binbin Wu wrote:
> 
> 
> On 9/14/2023 9:55 AM, Sean Christopherson wrote:
> [...]
> > +
> > +static void kvm_gmem_invalidate_begin(struct kvm_gmem *gmem, pgoff_t start,
> > +				      pgoff_t end)
> > +{
> > +	struct kvm_memory_slot *slot;
> > +	struct kvm *kvm = gmem->kvm;
> > +	unsigned long index;
> > +	bool flush = false;
> > +
> > +	KVM_MMU_LOCK(kvm);
> > +
> > +	kvm_mmu_invalidate_begin(kvm);
> > +
> > +	xa_for_each_range(&gmem->bindings, index, slot, start, end - 1) {
> > +		pgoff_t pgoff = slot->gmem.pgoff;
> > +
> > +		struct kvm_gfn_range gfn_range = {
> > +			.start = slot->base_gfn + max(pgoff, start) - pgoff,
> > +			.end = slot->base_gfn + min(pgoff + slot->npages, end) - pgoff,
> > +			.slot = slot,
> > +			.may_block = true,
> > +		};
> > +
> > +		flush |= kvm_mmu_unmap_gfn_range(kvm, &gfn_range);
> > +	}
> > +
> > +	if (flush)
> > +		kvm_flush_remote_tlbs(kvm);
> > +
> > +	KVM_MMU_UNLOCK(kvm);
> > +}
> > +
> > +static void kvm_gmem_invalidate_end(struct kvm_gmem *gmem, pgoff_t start,
> > +				    pgoff_t end)
> > +{
> > +	struct kvm *kvm = gmem->kvm;
> > +
> > +	KVM_MMU_LOCK(kvm);
> > +	if (xa_find(&gmem->bindings, &start, end - 1, XA_PRESENT))
> > +		kvm_mmu_invalidate_end(kvm);
> kvm_mmu_invalidate_begin() is called unconditionally in
> kvm_gmem_invalidate_begin(),
> but kvm_mmu_invalidate_end() is not here.
> This makes the kvm_gmem_invalidate_{begin, end}() calls asymmetric.

Another ouch :-(

And there should be no need to acquire mmu_lock() unconditionally, the inode's
mutex protects the bindings, not mmu_lock.

I'll get a fix posted today.  I think KVM can also add a sanity check to detect
unresolved invalidations, e.g.

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 7ba1ab1832a9..2a2d18070856 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1381,8 +1381,13 @@ static void kvm_destroy_vm(struct kvm *kvm)
         * No threads can be waiting in kvm_swap_active_memslots() as the
         * last reference on KVM has been dropped, but freeing
         * memslots would deadlock without this manual intervention.
+        *
+        * If the count isn't unbalanced, i.e. KVM did NOT unregister between
+        * a start() and end(), then there shouldn't be any in-progress
+        * invalidations.
         */
        WARN_ON(rcuwait_active(&kvm->mn_memslots_update_rcuwait));
+       WARN_ON(!kvm->mn_active_invalidate_count && kvm->mmu_invalidate_in_progress);
        kvm->mn_active_invalidate_count = 0;
 #else
        kvm_flush_shadow_all(kvm);


or an alternative style

	if (kvm->mn_active_invalidate_count)
		kvm->mn_active_invalidate_count = 0;
	else
		WARN_ON(kvm->mmu_invalidate_in_progress)

> > +	KVM_MMU_UNLOCK(kvm);
> > +}
> > +
> > +static long kvm_gmem_punch_hole(struct inode *inode, loff_t offset, loff_t len)
> > +{
> > +	struct list_head *gmem_list = &inode->i_mapping->private_list;
> > +	pgoff_t start = offset >> PAGE_SHIFT;
> > +	pgoff_t end = (offset + len) >> PAGE_SHIFT;
> > +	struct kvm_gmem *gmem;
> > +
> > +	/*
> > +	 * Bindings must stable across invalidation to ensure the start+end
> > +	 * are balanced.
> > +	 */
> > +	filemap_invalidate_lock(inode->i_mapping);
> > +
> > +	list_for_each_entry(gmem, gmem_list, entry) {
> > +		kvm_gmem_invalidate_begin(gmem, start, end);
> > +		kvm_gmem_invalidate_end(gmem, start, end);
> > +	}
> Why to loop for each gmem in gmem_list here?
> 
> IIUIC, offset is the offset according to the inode, it is only meaningful to
> the inode passed in, i.e, it is only meaningful to the gmem binding with the
> inode, not others.

The code is structured to allow for multiple gmem instances per inode.  This isn't
actually possible in the initial code base, but it's on the horizon[*].  I included
the list-based infrastructure in this initial series to ensure that guest_memfd
can actually support multiple files per inode, and to minimize the churn when the
"link" support comes along.

[*] https://lore.kernel.org/all/cover.1691446946.git.ackerleytng@google.com

