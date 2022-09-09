Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E37B35B42BC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Sep 2022 01:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbiIIXCP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Sep 2022 19:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiIIXCN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Sep 2022 19:02:13 -0400
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com [66.111.4.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18959D4BD4;
        Fri,  9 Sep 2022 16:02:12 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id 7A8C95806ED;
        Fri,  9 Sep 2022 19:02:09 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 09 Sep 2022 19:02:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1662764529; x=1662771729; bh=LZ
        qIYAsRBDLHzzFlN7g+AhI2hMyU/ynXCZmSXJx2o4o=; b=Fd9GWSBue9IWHe503e
        u6NjmzZkClyF2iQ1lgniAHchY/0TuAinaS2NWLg6kXBU39151pE1ovKNVS25Z/eq
        IFGfoDCZdfi9vsheNiozUhWQhBFe09NjS0fOO3MHFGf7ZJIdFE7URE2+4T8ry1tP
        Nbg2/Rj0tE3Ek4flC4ACTOcql6PzwfFTME2lnOV+B3N/lL/hnKnCQ6GH5+XhazC2
        Nmlg33RcE4W1FIQN8y/vZurktFXXaUv+E4bgIUTmtxklpt0y22GN9mlaZnVA1HvP
        jkswfdiKSGu/tJLd7oZD/eoKEIjjf2SfU40zdSq1rOcMST2//OkJ9MhjZ2EdQs+x
        twzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1662764529; x=1662771729; bh=LZqIYAsRBDLHzzFlN7g+AhI2hMyU
        /ynXCZmSXJx2o4o=; b=R0rm0u9Q8CX9dbZ2DhuKZkJyLwqDkiL/bcQEMyyhRDy3
        DKn59ZmnL3PU6DmHyrEOtbWOQxV0Jvh3Grnr7NnwLKmBBu1OqZr7MHMw5AF8nOc3
        yZwD78eLbs+PQ7ZV3R0sH3zp40EzNkJRkYIFQoQD0TzJshF7fsO77EIAhb/np+v5
        fD3+R4uPoMhtBl6YFx1Id+vdQVHvRNN3JNjDEgZx0z97eg2UtW70uB3fK3NPtcQq
        YXJKLKjalf08E+dU2zl2hDz2uNpIpr6InQLeo3pXVpi6p5g0dYXSjFu2qp7lvcHO
        z/6UG76BNmJ0JLKn+JDTKA1iOr5MetWJtzkldsMOKw==
X-ME-Sender: <xms:7sUbY3rI1KJg6T2GIL1QERVjHifgXO5lm0MnxXu08ZpG7b3CagZfXw>
    <xme:7sUbYxoUJWW56KV29pr_aHSFZMDTg3SRysBUXhQlGa9zL3CR6D-tSmooacFF6F7T4
    vngwaKGwj26JDXPHtA>
X-ME-Received: <xmr:7sUbY0NDMWxhzD2mgtmpwtlR72xtvAmgXhoiiyjc53F64CGLIQNkCJkgvMmlVTESiy-95w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfedtiedgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdttddttddtvdenucfhrhhomhepfdfmihhr
    ihhllhcutecurdcuufhhuhhtvghmohhvfdcuoehkihhrihhllhesshhhuhhtvghmohhvrd
    hnrghmvgeqnecuggftrfgrthhtvghrnhepvdekkeelteduteduledtgfevledtgeekjeeu
    ieehgeeltdduteeuueekhffhledvnecuffhomhgrihhnpehinhhtvghlrdgtohhmpdhmvg
    hmrdhprghgvgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvg
X-ME-Proxy: <xmx:7sUbY65BD7T0lBkv38MIfA5C7WIcBVzxQYY2iqyB0VQfm1zOuugzwQ>
    <xmx:7sUbY24PLQzdG8vOj0k1OQ385SW1ySugRFGwv36hbK-YXtzdMEgHpA>
    <xmx:7sUbYygCW8klPbx4kDGz3VpnpXvXc5mSI7G4ZJw8EFDOAiv-qLQgWA>
    <xmx:8cUbY7VMkXPqPikJg5h1mEfMk_BDtkjgyhUL44T0t1A43JkcVR9sBQ>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Sep 2022 19:02:06 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 2DAF3104A9B; Sat, 10 Sep 2022 02:02:03 +0300 (+03)
Date:   Sat, 10 Sep 2022 02:02:03 +0300
From:   "Kirill A . Shutemov" <kirill@shutemov.name>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Hugh Dickins <hughd@google.com>,
        Chao Peng <chao.p.peng@linux.intel.com>,
        kvm list <kvm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org,
        linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Nakajima, Jun" <jun.nakajima@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        David Hildenbrand <david@redhat.com>, aarcange@redhat.com,
        ddutile@redhat.com, dhildenb@redhat.com,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>,
        Michal Hocko <mhocko@suse.com>,
        Muchun Song <songmuchun@bytedance.com>,
        "Gupta, Pankaj" <pankaj.gupta@amd.com>
Subject: Re: [PATCH v7 00/14] KVM: mm: fd-based approach for supporting KVM
 guest private memory
Message-ID: <20220909230203.czdpronokk3lxses@box.shutemov.name>
References: <20220706082016.2603916-1-chao.p.peng@linux.intel.com>
 <ff5c5b97-acdf-9745-ebe5-c6609dd6322e@google.com>
 <20220818132421.6xmjqduempmxnnu2@box>
 <c6ccbb96-5849-2e2f-3b49-4ea711af525d@google.com>
 <20220820002700.6yflrxklmpsavdzi@box.shutemov.name>
 <95bd287b-d17f-fda8-58c9-20700b1e0c72@kernel.org>
 <20220909143236.sznwzkpedldrlnn5@box.shutemov.name>
 <762581e4-a6bf-41d1-b0d3-72543153ffb1@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <762581e4-a6bf-41d1-b0d3-72543153ffb1@www.fastmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 09, 2022 at 12:11:05PM -0700, Andy Lutomirski wrote:
> 
> 
> On Fri, Sep 9, 2022, at 7:32 AM, Kirill A . Shutemov wrote:
> > On Thu, Sep 08, 2022 at 09:48:35PM -0700, Andy Lutomirski wrote:
> >> On 8/19/22 17:27, Kirill A. Shutemov wrote:
> >> > On Thu, Aug 18, 2022 at 08:00:41PM -0700, Hugh Dickins wrote:
> >> > > On Thu, 18 Aug 2022, Kirill A . Shutemov wrote:
> >> > > > On Wed, Aug 17, 2022 at 10:40:12PM -0700, Hugh Dickins wrote:
> >> > > > > 
> >> > > > > If your memory could be swapped, that would be enough of a good reason
> >> > > > > to make use of shmem.c: but it cannot be swapped; and although there
> >> > > > > are some references in the mailthreads to it perhaps being swappable
> >> > > > > in future, I get the impression that will not happen soon if ever.
> >> > > > > 
> >> > > > > If your memory could be migrated, that would be some reason to use
> >> > > > > filesystem page cache (because page migration happens to understand
> >> > > > > that type of memory): but it cannot be migrated.
> >> > > > 
> >> > > > Migration support is in pipeline. It is part of TDX 1.5 [1]. And swapping
> >> > > > theoretically possible, but I'm not aware of any plans as of now.
> >> > > > 
> >> > > > [1] https://www.intel.com/content/www/us/en/developer/articles/technical/intel-trust-domain-extensions.html
> >> > > 
> >> > > I always forget, migration means different things to different audiences.
> >> > > As an mm person, I was meaning page migration, whereas a virtualization
> >> > > person thinks VM live migration (which that reference appears to be about),
> >> > > a scheduler person task migration, an ornithologist bird migration, etc.
> >> > > 
> >> > > But you're an mm person too: you may have cited that reference in the
> >> > > knowledge that TDX 1.5 Live Migration will entail page migration of the
> >> > > kind I'm thinking of.  (Anyway, it's not important to clarify that here.)
> >> > 
> >> > TDX 1.5 brings both.
> >> > 
> >> > In TDX speak, mm migration called relocation. See TDH.MEM.PAGE.RELOCATE.
> >> > 
> >> 
> >> This seems to be a pretty bad fit for the way that the core mm migrates
> >> pages.  The core mm unmaps the page, then moves (in software) the contents
> >> to a new address, then faults it in.  TDH.MEM.PAGE.RELOCATE doesn't fit into
> >> that workflow very well.  I'm not saying it can't be done, but it won't just
> >> work.
> >
> > Hm. From what I see we have all necessary infrastructure in place.
> >
> > Unmaping is NOP for inaccessible pages as it is never mapped and we have
> > mapping->a_ops->migrate_folio() callback that allows to replace software
> > copying with whatever is needed, like TDH.MEM.PAGE.RELOCATE.
> >
> > What do I miss?
> 
> Hmm, maybe this isn't as bad as I thought.
> 
> Right now, unless I've missed something, the migration workflow is to
> unmap (via try_to_migrate) all mappings, then migrate the backing store
> (with ->migrate_folio(), although it seems like most callers expect the
> actual copy to happen outside of ->migrate_folio(),

Most? I guess you are talking about MIGRATE_SYNC_NO_COPY, right? AFAICS,
it is HMM thing and not a common thing.

> and then make new
> mappings.  With the *current* (vma-based, not fd-based) model for KVM
> memory, this won't work -- we can't unmap before calling
> TDH.MEM.PAGE.RELOCATE.

We don't need to unmap. The page is not mapped from core-mm PoV.

> But maybe it's actually okay with some care or maybe mild modifications
> with the fd-based model.  We don't have any mmaps, per se, to unmap for
> secret / INACCESSIBLE memory.  So maybe we can get all the way to
> ->migrate_folio() without zapping anything in the secure EPT and just
> call TDH-MEM.PAGE.RELOCATE from inside migrate_folio().  And there will
> be nothing to fault back in.  From the core code's perspective, it's
> like migrating a memfd that doesn't happen to have my mappings at the
> time.

Modifications needed if we want to initiate migation from userspace. IIRC,
we don't have any API that can initiate page migration for file ranges,
without mapping the file.

But kernel can do it fine for own housekeeping, like compaction doesn't
need any VMA. And we need compaction working for long term stability of
the system.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
