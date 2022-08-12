Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA6E590EF9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Aug 2022 12:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236759AbiHLKOn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Aug 2022 06:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238308AbiHLKOX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Aug 2022 06:14:23 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9CE3ABD76;
        Fri, 12 Aug 2022 03:13:42 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 1B84F5C0162;
        Fri, 12 Aug 2022 06:13:40 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 12 Aug 2022 06:13:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1660299220; x=1660385620; bh=zE
        POgXch4RnjNYE4POh1BRcOpzKpo4IjzZ+TAEzqKUc=; b=k+ZLIdoG9wrMDEGlfA
        c9djB+sYDhM/K8ns4HF8xToVmTu6BIbIBgNRxE4ogwjmC1Du8NlJs5YMvrRPK7s5
        /hg76wobZJKzWEqbp7NGYH3F8paDa7L3MvHtC+QH/dqFFAyDk1KvkkROTIFzyHc5
        clwzEHx7H40jB8z0I1S1G4YQRt28Aq+3+cKkgvlmMgZZazct8BarCCNOWZgTNrQH
        qUPAQsyseZkG+7m93jcw6BtZasPzwwYyMYbK0ZzZLAqyY3BfsrJuQLmqgo046EB4
        WnPqf4zdiNo/WSdGwZlmybTedWZ5p9t5jsIu6ozm3BOcUn9zDqlIA0qHW6Ao1InE
        rzxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1660299220; x=1660385620; bh=zEPOgXch4RnjNYE4POh1BRcOpzKp
        o4IjzZ+TAEzqKUc=; b=JXF8YA2G2KUv3m6D77HAn6ksFPepbUbd15JuCdAIxWol
        eGwqNYj1fl6xtuJ5ZVDJ5wNkWLP+xLwoBdX0zoXpbm7dry75JJuKsXD50b1iVqKn
        zdzeTVrRY8Ia9xm43DGNHZQ/wxYLvRrwcgpksU1dK8brSc5UkaDnoFjVfE5akN7u
        XNRho3wZUKH1dkB7pUZSRC7naA+qF3eTcKyr1GsD1KzeRn2mOqNmDTSjwR08QihW
        EGUJmPC4zggXTConaycBamJRS+/wh9z/qQL+5rnGtcnXMizOYqDzOS/gAyqB92fC
        gjj8rVg7PgEW/jPui9fgM4RaJlloHDQD2ota7aO7Uw==
X-ME-Sender: <xms:0yf2YjUidQPnmNygUlNK3a3P4ldclFXhebKFLLhUpliEcCo52IEd3w>
    <xme:0yf2YrlKbXx5f4QiyhovPkxOS7uDLUc_fDE2x17rsQSqApa2V5OOSsZeTC2Z2qI_C
    50dNhc-03zgt1NWKhs>
X-ME-Received: <xmr:0yf2YvZel3PNhsPtrT9t-8spVe4elSKRLuWiGfbOA8Ra2QImTmPK_rcRjAacpPCRKQkUgQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdegiedgvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttd
    dttddttddvnecuhfhrohhmpedfmfhirhhilhhlucetrdcuufhhuhhtvghmohhvfdcuoehk
    ihhrihhllhesshhhuhhtvghmohhvrdhnrghmvgeqnecuggftrfgrthhtvghrnhephfeige
    fhtdefhedtfedthefghedutddvueehtedttdehjeeukeejgeeuiedvkedtnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhirhhilhhlsehshh
    huthgvmhhovhdrnhgrmhgv
X-ME-Proxy: <xmx:0yf2YuXeb1qj12vACU70iPBxwwxqohcdVJw9d43PFDnL0Fn5vxB_xA>
    <xmx:0yf2YtlpQ1E1a9K00SXTK3uf2x3IoEg73mZ28oM4-N1gGAAZ-NFEXg>
    <xmx:0yf2Yrejv22MCpDiFSdjGyNEwXmg7-IxDV4jGfno50Jg9nYrdfcJlA>
    <xmx:1Cf2Yix5liigdlgPJj6bhZPTjCLlDD9xB_QsRGDMb5RYbpBucrQ_fA>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Aug 2022 06:13:39 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 03205104A31; Fri, 12 Aug 2022 13:16:39 +0300 (+03)
Date:   Fri, 12 Aug 2022 13:16:39 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: State of the Page (August 2022)
Message-ID: <20220812101639.ijonnx7zeus7h2hn@box.shutemov.name>
References: <YvV1KTyzZ+Jrtj9x@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvV1KTyzZ+Jrtj9x@casper.infradead.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 11, 2022 at 10:31:21PM +0100, Matthew Wilcox wrote:
> ==============================
> State Of The Page, August 2022
> ==============================
> 
> I thought I'd write down where we are with struct page and where
> we're going, just to make sure we're all (still?) pulling in a similar
> direction.
> 
> Destination
> ===========
> 
> For some users, the size of struct page is simply too large.  At 64
> bytes per 4KiB page, memmap occupies 1.6% of memory.  If we can get
> struct page down to an 8 byte tagged pointer, it will be 0.2% of memory,
> which is an acceptable overhead.

Right. This is attractive. But it brings cost of indirection.

It can be especially painful for physical memory scanning. I guess we can
derive some info from memdesc type itself, like if it can be movable. But
still looks like an expensive change.

Do you have any estimation on how much CPU time we will pay to reduce
memory (and cache) overhead? RAM size tend to grow faster than IPC.
We need to make sure it is the right direction.

>    struct page {
>       unsigned long mem_desc;
>    };
> 
> Types of memdesc
> ----------------
> 
> This is very much subject to change as new users present themselves.
> Here are the current ones in-plan:
> 
>  - Undescribed.  Instead of the rest of the word being a pointer,
>    there are 2^28 subtypes available:
>    - Unmappable.  Typically device drivers allocating private memory.
>    - Reserved.  These pages are not allocatable.
>    - HWPoison
>    - Offline (eg balloon)
>    - Guard (see debug_pagealloc)
>  - Slab
>  - Anon Folio
>  - File Folio
>  - Buddy (ie free -- also for PCP?)
>  - Page Table
>  - Vmalloc
>  - Net Pool
>  - Zsmalloc
>  - Z3Fold
>  - Mappable.  Typically device drivers mapping memory to userspace
> 
> That implies 4 bits needed for the tag, so all memdesc allocations
> must be 16-byte aligned.  That is not an undue burden.  Memdescs
> must also be TYPESAFE_BY_RCU if they are mappable to userspace or
> can be stored in a file's address_space.
> 
> It may be worth distinguishing between vmalloc-mappable and
> vmalloc-unmappable to prevent some things being mapped to userspace
> inadvertently.

Given that memdesc represents Slab too, how do we allocate them?

> 
> Contents of a memdesc
> ---------------------
> 
> At least initially, the first word of a memdesc must be identical to the
> current page flags.  That allows various functions (eg set_page_dirty())
> to work on any kind of page without needing to know whether it's a device
> driver page, a vmalloc page, anon or file folio.
> 
> Similarly, both anon and file folios must have the list_head in the
> same place so they can be placed on the same LRU list.  Whether anon
> and file folios become separate types is still unclear to me.
> 
> Mappable
> --------
> 
> All pages mapped to userspace must have:
> 
>  - A refcount
>  - A mapcount
> 
> Preferably in the same place in the memdesc so we can handle them without
> having separate cases for each type of memdesc.  It would be nice to have
> a pincount as well, but that's already an optional feature.
> 
> I propose:
> 
>    struct mappable {
>        unsigned long flags;	/* contains dirty flag */
>        atomic_t _refcount;
>        atomic_t _mapcount;
>    };
> 
>    struct folio {
>       union {
>          unsigned long flags;
>          struct mappable m;
>       };
>       ...
>    };

Hm. How does lockless page cache lookup would look like in this case?

Currently it relies on get_page_unless_zero() and to keep it work there's
should be guarantee that nothing else is allocated where mappable memdesc
was before. Would it require some RCU tricks on memdesc free?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
