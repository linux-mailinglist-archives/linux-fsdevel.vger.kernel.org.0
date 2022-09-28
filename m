Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A01D5EDDCE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Sep 2022 15:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234061AbiI1Ng1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Sep 2022 09:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233742AbiI1NgY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Sep 2022 09:36:24 -0400
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com [66.111.4.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6B26A3D4A;
        Wed, 28 Sep 2022 06:36:15 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id 3051758057F;
        Wed, 28 Sep 2022 09:36:12 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 28 Sep 2022 09:36:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1664372172; x=1664379372; bh=tj
        nmSL00ZZM1oFN2Ay5SF+8t5QvO8oA3qdQmqLG6FSc=; b=pyC2V+ZIEI8hVKL4jk
        eh1aquPI6x2I81olRmeClPVF5hiKuHbjq+E3Y51i2sBCWzatKsoYOW5khczk6WTM
        8J6YL2p0nhiHPsJmx3EYgz1OnPMvJkef/MNp0SnduwLZ1ZX6lpVzr9UkDHbY6eYW
        SluwH3HiuqQUEGPhse5UegddHgqGjwiyQeFgJp003ukUcVs4zntu6M0FWPOP7TFA
        TI1qrvyQWon8bG9iV39m4PEqzPilDsdhorlFNIzyBM1jcAIdglIV3t0JNzf7DuOC
        l9MEdQpNb9xkBzQ6JqtJQX3ZDm5dmTKgJYDwUzRPqvXzX5m9Qt2azaQxldzP1pSO
        v89g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1664372172; x=1664379372; bh=tjnmSL00ZZM1oFN2Ay5SF+8t5QvO
        8oA3qdQmqLG6FSc=; b=I81/AahetSMdo18CBUdQQn4rwPC0r15wzFvsbpWQ8B4E
        746jkJMhyoYQKiBRceB2Gp47egha5pvGShnDJFfhL02LgoLPWnvFMmax8G6dAG0q
        nOowrWfTh38eT9HNrQF46lVjPH8o/pV5CGVhtozHe55WVEbm75M5iXtqRH71uNsA
        rDVoDbE4uPb4u9TexIb2JhapAbg+MC0aMx379ZD4xrzCxncdOz2grYX4F44ffRto
        ql24c4H3yyZ5J5r7YQfN2Ql0whcssZyXK5FiGhdcpWeXcUHZ3L6H3SEluW1n/deT
        NnMVKToWSZCaj+GJfGmYJX0mHnMa+eWkxNShDvaneg==
X-ME-Sender: <xms:yU00Y3kjTKFsA4mKa-lwOV4QqioQlg16k5bYKWHXGWM31PtA16U6ww>
    <xme:yU00Y63sy_55IDIvZxOjGFUOEQrlOw3cI29BFYlHinqPpZqravTtk568kQ5hXMLF9
    QnFQMNC631kQVFFRes>
X-ME-Received: <xmr:yU00Y9qLU-AErVU-Lm2JAIxeEVCEXTkrIaCyGkEHL8g96v_jTXTReZEvuFElOZSloLMXBw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeegkedgieekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdttddttddtvdenucfhrhhomhepfdfmihhr
    ihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpeelgffhfeetlefhveffleevfffgtefffeelfedu
    udfhjeduteeggfeiheefteehjeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhirhhilhhl
    sehshhhuthgvmhhovhdrnhgrmhgv
X-ME-Proxy: <xmx:yU00Y_nTE9FQbvMtkDpXIYFpJprXJRI2pO6aaokPg4j6Pp6bC76pzA>
    <xmx:yU00Y127smmXEKIn220aLfUL0MekHTvkmatnwtwo4Tx3n16KZSxStw>
    <xmx:yU00Y-vwEXbGnyuz1YEqODYDj3tQYEnAcF4PVm9Hf1yGm0Oty962Ig>
    <xmx:zE00Y-RwGOa2beh1OemdZjSQGikerz2RKwrSbfVuTlu93LrEu1bacg>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Sep 2022 09:36:09 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id C0423104667; Wed, 28 Sep 2022 16:36:05 +0300 (+03)
Date:   Wed, 28 Sep 2022 16:36:05 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Sean Christopherson <seanjc@google.com>
Cc:     David Hildenbrand <david@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Chao Peng <chao.p.peng@linux.intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org,
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
        Yu Zhang <yu.c.zhang@linux.intel.com>, luto@kernel.org,
        jun.nakajima@intel.com, dave.hansen@intel.com, ak@linux.intel.com,
        aarcange@redhat.com, ddutile@redhat.com, dhildenb@redhat.com,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>, wei.w.wang@intel.com
Subject: Re: [PATCH v8 1/8] mm/memfd: Introduce userspace inaccessible memfd
Message-ID: <20220928133605.dy2tkdcpb5pkjejj@box.shutemov.name>
References: <20220915142913.2213336-1-chao.p.peng@linux.intel.com>
 <20220915142913.2213336-2-chao.p.peng@linux.intel.com>
 <d16284f5-3493-2892-38e6-f1fa5c10bdbb@redhat.com>
 <20220923005808.vfltoecttoatgw5o@box.shutemov.name>
 <f703e615-3b75-96a2-fb48-2fefd8a2069b@redhat.com>
 <20220926144854.dyiacztlpx4fkjs5@box.shutemov.name>
 <0a99aa24-599c-cc60-b23b-b77887af3702@redhat.com>
 <YzOF7MT15nfBX0Ma@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzOF7MT15nfBX0Ma@google.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 27, 2022 at 11:23:24PM +0000, Sean Christopherson wrote:
> On Mon, Sep 26, 2022, David Hildenbrand wrote:
> > On 26.09.22 16:48, Kirill A. Shutemov wrote:
> > > On Mon, Sep 26, 2022 at 12:35:34PM +0200, David Hildenbrand wrote:
> > > > When using DAX, what happens with the shared <->private conversion? Which
> > > > "type" is supposed to use dax, which not?
> > > > 
> > > > In other word, I'm missing too many details on the bigger picture of how
> > > > this would work at all to see why it makes sense right now to prepare for
> > > > that.
> > > 
> > > IIUC, KVM doesn't really care about pages or folios. They need PFN to
> > > populate SEPT. Returning page/folio would make KVM do additional steps to
> > > extract PFN and one more place to have a bug.
> > 
> > Fair enough. Smells KVM specific, though.
> 
> TL;DR: I'm good with either approach, though providing a "struct page" might avoid
>        refactoring the API in the nearish future.
> 
> Playing devil's advocate for a second, the counter argument is that KVM is the
> only user for the foreseeable future.
> 
> That said, it might make sense to return a "struct page" from the core API and
> force KVM to do page_to_pfn().  KVM already does that for HVA-based memory, so
> it's not exactly new code.

Core MM tries to move away from struct page in favour of struct folio. We
can make interface return folio.

But it would require more work on KVM side.

folio_pfn(folio) + offset % folio_nr_pages(folio) would give you PFN for
base-pagesize PFN for given offset. I guess it is not too hard.

It also gives KVM capability to populate multiple EPT entries for non-zero
order folio and save few cycles.

Does it work for you?

> More importantly, KVM may actually need/want the "struct page" in the not-too-distant
> future to support mapping non-refcounted "struct page" memory into the guest.  The
> ChromeOS folks have a use case involving virtio-gpu blobs where KVM can get handed a
> "struct page" that _isn't_ refcounted[*].  Once the lack of mmu_notifier integration
> is fixed, the remaining issue is that KVM doesn't currently have a way to determine
> whether or not it holds a reference to the page.  Instead, KVM assumes that if the
> page is "normal", it's refcounted, e.g. see kvm_release_pfn_clean().
> 
> KVM's current workaround for this is to refuse to map these pages into the guest,
> i.e. KVM simply forces its assumption that normal pages are refcounted to be true.
> To remove that workaround, the likely solution will be to pass around a tuple of
> page+pfn, where "page" is non-NULL if the pfn is a refcounted "struct page".
> 
> At that point, getting handed a "struct page" from the core API would be a good
> thing as KVM wouldn't need to probe the PFN to determine whether or not it's a
> refcounted page.
> 
> Note, I still want the order to be provided by the API so that KVM doesn't need
> to run through a bunch of helpers to try and figure out the allowed mapping size.
> 
> [*] https://lore.kernel.org/all/CAD=HUj736L5oxkzeL2JoPV8g1S6Rugy_TquW=PRt73YmFzP6Jw@mail.gmail.com

These non-refcounted "struct page" confuses me.

IIUC (probably not), the idea is to share a buffer between host and guest
and avoid double buffering in page cache on the guest ("guest shadow
buffer" means page cache, right?). Don't we already have DAX interfaces to
bypass guest page cache?

And do you think it would need to be handled on inaccessible API lavel or
is it KVM-only thing that uses inaccessible API for some use-cases?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
