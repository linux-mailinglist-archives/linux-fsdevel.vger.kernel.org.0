Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67862654D64
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Dec 2022 09:24:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235843AbiLWIYu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Dec 2022 03:24:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiLWIYt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Dec 2022 03:24:49 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63CC728E14;
        Fri, 23 Dec 2022 00:24:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671783888; x=1703319888;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=HImD4R1dLRRaXrHVVqh8GNzM0wgrc3l8oV1ABGfcy/k=;
  b=LQ1YGrpFuM0j2WC3aaplICXHv+Q+Ljm0r3qQO6r2uouzTGI14eVNgy9G
   FLUkGCAZHCn/EPcxX47myf7WFRYPKAAOkGDxJe1RCovZUTwQcHv5NNV2X
   uJU/5o72ASuBjai30Es7YR3nApq+SmrDGv1SvO6+ccFN8Nga0ClpKbI+1
   R4xtaEcsRuoNX/qZ58uzF1zc3T3ISeM4Pk0cVcDKvn4ZdLtwjkgwo4uo3
   RlGGQZ4gt+1dpWJaqHP/6htDd+V2d8svgdPYeCEdv4EUNrdNrBOIszv14
   5G0QsRWSSYEIhHkpU4e+BFwgO8lCpZKMHbF+V8BnR95vgSARzc3GDUjiH
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10569"; a="322238904"
X-IronPort-AV: E=Sophos;i="5.96,267,1665471600"; 
   d="scan'208";a="322238904"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2022 00:24:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10569"; a="740807258"
X-IronPort-AV: E=Sophos;i="5.96,267,1665471600"; 
   d="scan'208";a="740807258"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.193.75])
  by FMSMGA003.fm.intel.com with ESMTP; 23 Dec 2022 00:24:35 -0800
Date:   Fri, 23 Dec 2022 16:20:20 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     "Huang, Kai" <kai.huang@intel.com>
Cc:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "jmattson@google.com" <jmattson@google.com>,
        "Hocko, Michal" <mhocko@suse.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "tabba@google.com" <tabba@google.com>,
        "david@redhat.com" <david@redhat.com>,
        "michael.roth@amd.com" <michael.roth@amd.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        "dhildenb@redhat.com" <dhildenb@redhat.com>,
        "bfields@fieldses.org" <bfields@fieldses.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "ddutile@redhat.com" <ddutile@redhat.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "mail@maciej.szmigiero.name" <mail@maciej.szmigiero.name>,
        "naoya.horiguchi@nec.com" <naoya.horiguchi@nec.com>,
        "qperret@google.com" <qperret@google.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "yu.c.zhang@linux.intel.com" <yu.c.zhang@linux.intel.com>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "wanpengli@tencent.com" <wanpengli@tencent.com>,
        "vannapurve@google.com" <vannapurve@google.com>,
        "hughd@google.com" <hughd@google.com>,
        "aarcange@redhat.com" <aarcange@redhat.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Nakajima, Jun" <jun.nakajima@intel.com>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Wang, Wei W" <wei.w.wang@intel.com>,
        "steven.price@arm.com" <steven.price@arm.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linmiaohe@huawei.com" <linmiaohe@huawei.com>
Subject: Re: [PATCH v10 1/9] mm: Introduce memfd_restricted system call to
 create restricted user memory
Message-ID: <20221223082020.GA1829090@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20221202061347.1070246-1-chao.p.peng@linux.intel.com>
 <20221202061347.1070246-2-chao.p.peng@linux.intel.com>
 <5c6e2e516f19b0a030eae9bf073d555c57ca1f21.camel@intel.com>
 <20221219075313.GB1691829@chaop.bj.intel.com>
 <deba096c85e41c3a15d122f2159986a74b16770f.camel@intel.com>
 <20221220072228.GA1724933@chaop.bj.intel.com>
 <126046ce506df070d57e6fe5ab9c92cdaf4cf9b7.camel@intel.com>
 <20221221133905.GA1766136@chaop.bj.intel.com>
 <b898e28d7fd7182e5d069646f84b650c748d9ca2.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b898e28d7fd7182e5d069646f84b650c748d9ca2.camel@intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 22, 2022 at 12:37:19AM +0000, Huang, Kai wrote:
> On Wed, 2022-12-21 at 21:39 +0800, Chao Peng wrote:
> > > On Tue, Dec 20, 2022 at 08:33:05AM +0000, Huang, Kai wrote:
> > > > > On Tue, 2022-12-20 at 15:22 +0800, Chao Peng wrote:
> > > > > > > On Mon, Dec 19, 2022 at 08:48:10AM +0000, Huang, Kai wrote:
> > > > > > > > > On Mon, 2022-12-19 at 15:53 +0800, Chao Peng wrote:
> > > > > > > > > > > > > 
> > > > > > > > > > > > > [...]
> > > > > > > > > > > > > 
> > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > +	/*
> > > > > > > > > > > > > > > +	 * These pages are currently unmovable so don't place them into
> > > > > > > > > > > > > > > movable
> > > > > > > > > > > > > > > +	 * pageblocks (e.g. CMA and ZONE_MOVABLE).
> > > > > > > > > > > > > > > +	 */
> > > > > > > > > > > > > > > +	mapping = memfd->f_mapping;
> > > > > > > > > > > > > > > +	mapping_set_unevictable(mapping);
> > > > > > > > > > > > > > > +	mapping_set_gfp_mask(mapping,
> > > > > > > > > > > > > > > +			     mapping_gfp_mask(mapping) & ~__GFP_MOVABLE);
> > > > > > > > > > > > > 
> > > > > > > > > > > > > But, IIUC removing __GFP_MOVABLE flag here only makes page allocation from
> > > > > > > > > > > > > non-
> > > > > > > > > > > > > movable zones, but doesn't necessarily prevent page from being migrated.  My
> > > > > > > > > > > > > first glance is you need to implement either a_ops->migrate_folio() or just
> > > > > > > > > > > > > get_page() after faulting in the page to prevent.
> > > > > > > > > > > 
> > > > > > > > > > > The current api restrictedmem_get_page() already does this, after the
> > > > > > > > > > > caller calling it, it holds a reference to the page. The caller then
> > > > > > > > > > > decides when to call put_page() appropriately.
> > > > > > > > > 
> > > > > > > > > I tried to dig some history. Perhaps I am missing something, but it seems Kirill
> > > > > > > > > said in v9 that this code doesn't prevent page migration, and we need to
> > > > > > > > > increase page refcount in restrictedmem_get_page():
> > > > > > > > > 
> > > > > > > > > https://lore.kernel.org/linux-mm/20221129112139.usp6dqhbih47qpjl@box.shutemov.name/
> > > > > > > > > 
> > > > > > > > > But looking at this series it seems restrictedmem_get_page() in this v10 is
> > > > > > > > > identical to the one in v9 (except v10 uses 'folio' instead of 'page')?
> > > > > > > 
> > > > > > > restrictedmem_get_page() increases page refcount several versions ago so
> > > > > > > no change in v10 is needed. You probably missed my reply:
> > > > > > > 
> > > > > > > https://lore.kernel.org/linux-mm/20221129135844.GA902164@chaop.bj.intel.com/
> > > > > 
> > > > > But for non-restricted-mem case, it is correct for KVM to decrease page's
> > > > > refcount after setting up mapping in the secondary mmu, otherwise the page will
> > > > > be pinned by KVM for normal VM (since KVM uses GUP to get the page).
> > > 
> > > That's true. Actually even true for restrictedmem case, most likely we
> > > will still need the kvm_release_pfn_clean() for KVM generic code. On one
> > > side, other restrictedmem users like pKVM may not require page pinning
> > > at all. On the other side, see below.
> 
> OK. Agreed.
> 
> > > 
> > > > > 
> > > > > So what we are expecting is: for KVM if the page comes from restricted mem, then
> > > > > KVM cannot decrease the refcount, otherwise for normal page via GUP KVM should.
> > > 
> > > I argue that this page pinning (or page migration prevention) is not
> > > tied to where the page comes from, instead related to how the page will
> > > be used. Whether the page is restrictedmem backed or GUP() backed, once
> > > it's used by current version of TDX then the page pinning is needed. So
> > > such page migration prevention is really TDX thing, even not KVM generic
> > > thing (that's why I think we don't need change the existing logic of
> > > kvm_release_pfn_clean()). 
> > > 
> 
> This essentially boils down to who "owns" page migration handling, and sadly,
> page migration is kinda "owned" by the core-kernel, i.e. KVM cannot handle page
> migration by itself -- it's just a passive receiver.

No, I'm not talking on the page migration handling itself, I know page
migration requires coordination from both core-mm and KVM. I'm more
concerning on the page migration prevention here. This is something we
need to address for TDX before the page migration is supported.

> 
> For normal pages, page migration is totally done by the core-kernel (i.e. it
> unmaps page from VMA, allocates a new page, and uses migrate_pape() or a_ops-
> >migrate_page() to actually migrate the page).
> 
> In the sense of TDX, conceptually it should be done in the same way. The more
> important thing is: yes KVM can use get_page() to prevent page migration, but
> when KVM wants to support it, KVM cannot just remove get_page(), as the core-
> kernel will still just do migrate_page() which won't work for TDX (given
> restricted_memfd doesn't have a_ops->migrate_page() implemented).
> 
> So I think the restricted_memfd filesystem should own page migration handling,
> (i.e. by implementing a_ops->migrate_page() to either just reject page migration
> or somehow support it).
> 
> To support page migration, it may require KVM's help in case of TDX (the
> TDH.MEM.PAGE.RELOCATE SEAMCALL requires "GPA" and "level" of EPT mapping, which
> are only available in KVM), but that doesn't make KVM to own the handling of
> page migration.
> 
> 
> > > Wouldn't better to let TDX code (or who
> > > requires that) to increase/decrease the refcount when it populates/drops
> > > the secure EPT entries? This is exactly what the current TDX code does:
> > > 
> > > get_page():
> > > https://github.com/intel/tdx/blob/kvm-upstream/arch/x86/kvm/vmx/tdx.c#L1217
> > > 
> > > put_page():
> > > https://github.com/intel/tdx/blob/kvm-upstream/arch/x86/kvm/vmx/tdx.c#L1334
> > > 
> 
> As explained above, I think doing so in KVM is wrong: it can prevent by using
> get_page(), but you cannot simply remove it to support page migration.

Removing get_page() is definitely not enough for page migration support.
But the key thing is for page migration prevention, other than
get_page(), do we really have alternative.

Thanks,
Chao
> 
> Sean also said similar thing when reviewing v8 KVM TDX series and I also agree:
> 
> https://lore.kernel.org/lkml/Yvu5PsAndEbWKTHc@google.com/
> https://lore.kernel.org/lkml/31fec1b4438a6d9bb7ff719f96caa8b23ed764d6.camel@intel.com/
> 
