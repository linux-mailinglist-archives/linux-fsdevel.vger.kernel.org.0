Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA665591233
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Aug 2022 16:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236894AbiHLObB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Aug 2022 10:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235317AbiHLObA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Aug 2022 10:31:00 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D551CB10;
        Fri, 12 Aug 2022 07:30:59 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 555105C0046;
        Fri, 12 Aug 2022 10:30:56 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 12 Aug 2022 10:30:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1660314656; x=1660401056; bh=M3
        MbplBIwl853hk2/PIOPlXrFz0V9VywUt08s+uBFWc=; b=qDLFPe+gLm+/z45jUp
        gD1UvOGWYdhSo5E9SwWBLGldN1kUuLTENtVPbHIdv3hf8qvJeBvPfiRf5YclZRX/
        RLn75eWjWu3W8emeTTnw8aTXUulREPgharGzwtUvg1fNzXZyI0N2nRyynX0q+HeY
        7U/ZDoyPNff3L86fomnW7vkKEtgQa3Gos4SxdyDEBe48rak8I0xku+rSsC+bOw8M
        saHAHh04yQquyC+JkWW5yjyREoVpwc3IGAQJ/ScGqcHEAMEVYahRdgEf8hH2vQZ8
        v94zBjExxClOApEhuxJH6GjhfdMMnL95VEx+wzc3N4SI5jgdAFNORBbHwoGZ2Qi9
        kU+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1660314656; x=1660401056; bh=M3MbplBIwl853hk2/PIOPlXrFz0V
        9VywUt08s+uBFWc=; b=cG9MWGAal32lE95MfUxQ/10J6t2iXDTt1UN6kMXynFqU
        G3Q3nVWNM12MIAF9aM44YEFZB/aCC9R6qapvdo6o3bl9lv35OU527D+1Ry780WQ3
        cpemd/Bmh29v2uqNr2a5GZjIZGda68AzECthe1fwRxsCfgcQg5KzF1J6zt2guETh
        cu8WldLbTReoBKK5K5j9SkdO2TEY6oO/59kXpZGV83wc5umqvAOTRd0Vjo2nGPz4
        pSewfnRC5zv4T3d/oyfurbm8gALCMRUf2KUq58UDChCl9PMF9n4IaUVCxc5h7Ss+
        2FjVMhXN9yul6fQOiPiXJ9kocjc2UNDD7GqwpU3TWg==
X-ME-Sender: <xms:IGT2YqRzi_7ixlZKVcu0X8fDH1QvWTQtTGFIyCjJLoohWQKNYeu6gA>
    <xme:IGT2Yvywa8YTqFIbZ4QSTD3M3nvBqHm9TIrp51mGUtFJNpdgzV_7cQOk_6uedMCKj
    cW-wyJLVIKD3mIGbyE>
X-ME-Received: <xmr:IGT2Yn0bjeQ8VLJ4L8nuUomxtUfo4R8m3wLZ4MqwL7RuydMfrMj9b3jM0e4VnjkLVf8DnQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdegiedgjeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttd
    dttddttddvnecuhfhrohhmpedfmfhirhhilhhlucetrdcuufhhuhhtvghmohhvfdcuoehk
    ihhrihhllhesshhhuhhtvghmohhvrdhnrghmvgeqnecuggftrfgrthhtvghrnhephfeige
    fhtdefhedtfedthefghedutddvueehtedttdehjeeukeejgeeuiedvkedtnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhirhhilhhlsehshh
    huthgvmhhovhdrnhgrmhgv
X-ME-Proxy: <xmx:IGT2YmBu5hhEK1NJZYEIKn59laaUQUEQGNAHpNzP6TWaki7-obVoNw>
    <xmx:IGT2YjgDC94s4-b1cQcPuDB0AKSBs6rc75vWIQvqgrJya6u2y8CFtg>
    <xmx:IGT2YipLG3gHIjMulanLOm-YnCGHxDRqr5nc5482d69K82Xsi5i7dQ>
    <xmx:IGT2Yms_TnK5Yw5Bdzv0NYLUVcs_gv-mKNNFrA7whoLyhi0AhUgbYw>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Aug 2022 10:30:55 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id E33AD104A2F; Fri, 12 Aug 2022 17:33:56 +0300 (+03)
Date:   Fri, 12 Aug 2022 17:33:56 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: State of the Page (August 2022)
Message-ID: <20220812143356.4kv5cycwbcy2t7ul@box.shutemov.name>
References: <YvV1KTyzZ+Jrtj9x@casper.infradead.org>
 <20220812101639.ijonnx7zeus7h2hn@box.shutemov.name>
 <YvZW/exP02XceTVl@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvZW/exP02XceTVl@casper.infradead.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 12, 2022 at 02:34:53PM +0100, Matthew Wilcox wrote:
> On Fri, Aug 12, 2022 at 01:16:39PM +0300, Kirill A. Shutemov wrote:
> > On Thu, Aug 11, 2022 at 10:31:21PM +0100, Matthew Wilcox wrote:
> > > ==============================
> > > State Of The Page, August 2022
> > > ==============================
> > > 
> > > I thought I'd write down where we are with struct page and where
> > > we're going, just to make sure we're all (still?) pulling in a similar
> > > direction.
> > > 
> > > Destination
> > > ===========
> > > 
> > > For some users, the size of struct page is simply too large.  At 64
> > > bytes per 4KiB page, memmap occupies 1.6% of memory.  If we can get
> > > struct page down to an 8 byte tagged pointer, it will be 0.2% of memory,
> > > which is an acceptable overhead.
> > 
> > Right. This is attractive. But it brings cost of indirection.
> 
> It does, but it also crams 8 pages into a single cacheline instead of
> occupying one cacheline per page.

If you really need info about these pages and reference their memdesc it
is likely be 9 cache lines that scattered across memory instead of 8 cache
lines next to each other in the same page.

And it's going to be two cachelines instead of one if we need info about
one page. I think it is the most common case.

Initially, I thought we can offset the cost by caching memdescs instead of
struct page/folio. Like page cache store memdesc, but it would require
memdesc_to_pfn() which is not possible, unless we want to store pfn
explicitly in memdesc.

I don't want to be buzzkill, I like the idea a lot, but abstractions are
often costly. Getting it upstream without noticeable performance
regressions going to be a challenge.

> > It can be especially painful for physical memory scanning. I guess we can
> > derive some info from memdesc type itself, like if it can be movable. But
> > still looks like an expensive change.
> 
> I just don't think of physical memory scanning as something we do
> often, or in a performance-sensitive path.  I'm OK with slowing down
> kcompactd if it makes walking the LRU list faster.
> 
> > Do you have any estimation on how much CPU time we will pay to reduce
> > memory (and cache) overhead? RAM size tend to grow faster than IPC.
> > We need to make sure it is the right direction.
> 
> I don't.  I've heard colourful metaphors from the hyperscale crowd about
> how many more VMs they could sell, usually in terms of putting pallets
> of money in the parking lot and setting them on fire.  But IPC isn't the
> right metric either, CPU performance is all about cache misses these days.

As I said above, I don't expect the new scheme to be cache-friendly
either.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
