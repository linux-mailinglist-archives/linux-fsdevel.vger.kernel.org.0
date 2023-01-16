Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3363C66C073
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jan 2023 14:58:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231641AbjAPN6X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Jan 2023 08:58:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231343AbjAPN5q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Jan 2023 08:57:46 -0500
X-Greylist: delayed 416 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 16 Jan 2023 05:55:50 PST
Received: from wnew2-smtp.messagingengine.com (wnew2-smtp.messagingengine.com [64.147.123.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D2A21A09;
        Mon, 16 Jan 2023 05:55:50 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailnew.west.internal (Postfix) with ESMTP id 53BD12B067C9;
        Mon, 16 Jan 2023 08:48:50 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 16 Jan 2023 08:48:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1673876929; x=1673884129; bh=LV
        IuqcNr+BEv3OVovuvPG4rkUA8Se79qo5nrRkoOk/4=; b=hzqSbnXXHX1g+A0/Ds
        g4Hdrbl+duGXBSNIacSKQ5cZs2CG5PwGXwtiLLZN/D1xVeIKrrYvQPopYIBziUJH
        gPXBXhBUjHNeNMXfFIzjHp9Pa1dA8lHudIk2RRGqQyo5jwy1ShZ4AnyiC5tk/r40
        2tP/6afRYdUyPyv6NJCiu8ZeWYIveuXlAhsIdCZ8VNMSLGsrMkWlNB0yWBFfdsq6
        D0/u+OuX/k+7NZQW0WeGyV4H/UWm1LOPuec8xME1t0TXJ/AZQz1MvhmIEgnm+7EF
        HgksJGu3O2yE/ei+qxkLuy8wmzA3Nh8veigRKWprNSGQ1Et7bGymXkWwi85bBVe8
        FFYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1673876929; x=1673884129; bh=LVIuqcNr+BEv3OVovuvPG4rkUA8S
        e79qo5nrRkoOk/4=; b=bO+dUcGv+jEMy/lCF06LmFFcOFpJPrpvFNPqUv8hbFss
        wijIsi3XbIRQOiPx3CYSoIfNJ+kMvVXBvkEcXHbu1ioBlsHUVUcnCfsu0WNhjbCw
        g3xs8nJHkgJ8jePTUFPUALiOCs0E7rFIZKG2Hl749XrYY5YejpkedmN4Ug2y+F/5
        UHyZFHbQatARsDjhWIKNsnEOUPbI+YhNeGdQ3px8ojanRDzOkO73gtJ9xxLgQ8hu
        um9K6q4z+hqC80ODYxw9kWYok0RENuF6rPlsUfzn13P45Peo7LfMmqClWZ6ejfXk
        f2bHJYrO6/QBvd8rDNTeGDZ9OJ4iL6BoykAGpaRgpw==
X-ME-Sender: <xms:v1XFY8yLZJzPRKyHnwQL_FJgKaTbKqv-N_O6nu2jz8ifd771a6fyKw>
    <xme:v1XFYwTqbvz09EIDgf_GuyW5XD82H6IQoSkDyKH7_8YTfJVbomZ8uc7dDjRyZlo5n
    doZ4X-PSAOWYvogkJw>
X-ME-Received: <xmr:v1XFY-WTiUwzYZ7NxRzNy44NRpoNKITddppclahQMJaSNJKW0wzVBJZHc91kQIVONmJFfQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddtgedgheeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdttddttddtvdenucfhrhhomhepfdfmihhr
    ihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpefhieeghfdtfeehtdeftdehgfehuddtvdeuheet
    tddtheejueekjeegueeivdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvg
X-ME-Proxy: <xmx:v1XFY6gic2M9Pzyndm04VV1xQRBxde6OVFDFcyBRxOb3rjvvtTtXCA>
    <xmx:v1XFY-B1TKgHRHRV1sisOhg5fm8GczU6f9FE6jwSH4_J4JzxwEAPmw>
    <xmx:v1XFY7IM3MVsig37x5YeGF4QCi0BKrQP0E6iOgeW5J0tq_D9jUtaYA>
    <xmx:wVXFY8pmuU6BstNTCPoiKUslSX2k9Xgz3r8eQqfxFEh-u3NMNdCd8i2rHAo>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Jan 2023 08:48:46 -0500 (EST)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 3ECD8109792; Mon, 16 Jan 2023 16:48:45 +0300 (+03)
Date:   Mon, 16 Jan 2023 16:48:45 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Chao Peng <chao.p.peng@linux.intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
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
Subject: Re: [PATCH v10 0/9] KVM: mm: fd-based approach for supporting KVM
Message-ID: <20230116134845.vboraky2nd56szos@box.shutemov.name>
References: <20221202061347.1070246-1-chao.p.peng@linux.intel.com>
 <Y8H5Z3e4hZkFxAVS@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8H5Z3e4hZkFxAVS@google.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jan 14, 2023 at 12:37:59AM +0000, Sean Christopherson wrote:
> On Fri, Dec 02, 2022, Chao Peng wrote:
> > This patch series implements KVM guest private memory for confidential
> > computing scenarios like Intel TDX[1]. If a TDX host accesses
> > TDX-protected guest memory, machine check can happen which can further
> > crash the running host system, this is terrible for multi-tenant
> > configurations. The host accesses include those from KVM userspace like
> > QEMU. This series addresses KVM userspace induced crash by introducing
> > new mm and KVM interfaces so KVM userspace can still manage guest memory
> > via a fd-based approach, but it can never access the guest memory
> > content.
> > 
> > The patch series touches both core mm and KVM code. I appreciate
> > Andrew/Hugh and Paolo/Sean can review and pick these patches. Any other
> > reviews are always welcome.
> >   - 01: mm change, target for mm tree
> >   - 02-09: KVM change, target for KVM tree
> 
> A version with all of my feedback, plus reworked versions of Vishal's selftest,
> is available here:
> 
>   git@github.com:sean-jc/linux.git x86/upm_base_support
> 
> It compiles and passes the selftest, but it's otherwise barely tested.  There are
> a few todos (2 I think?) and many of the commits need changelogs, i.e. it's still
> a WIP.
> 
> As for next steps, can you (handwaving all of the TDX folks) take a look at what
> I pushed and see if there's anything horrifically broken, and that it still works
> for TDX?

Minor build fix:

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 6eb5336ccc65..4a9e9fa2552a 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -7211,8 +7211,8 @@ void kvm_arch_set_memory_attributes(struct kvm *kvm,
 	int level;
 	bool mixed;
 
-	lockdep_assert_held_write(kvm->mmu_lock);
-	lockdep_assert_held(kvm->slots_lock);
+	lockdep_assert_held_write(&kvm->mmu_lock);
+	lockdep_assert_held(&kvm->slots_lock);
 
 	/*
 	 * KVM x86 currently only supports KVM_MEMORY_ATTRIBUTE_PRIVATE, skip
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 467916943c73..4ef60ba7eb1d 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -2304,7 +2304,7 @@ static inline void kvm_account_pgtable_pages(void *virt, int nr)
 #ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
 static inline unsigned long kvm_get_memory_attributes(struct kvm *kvm, gfn_t gfn)
 {
-	lockdep_assert_held(kvm->mmu_lock);
+	lockdep_assert_held(&kvm->mmu_lock);
 
 	return xa_to_value(xa_load(&kvm->mem_attr_array, gfn));
 }
-- 
  Kiryl Shutsemau / Kirill A. Shutemov
