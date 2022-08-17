Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F962596CD2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Aug 2022 12:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235062AbiHQK3q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Aug 2022 06:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbiHQK3p (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Aug 2022 06:29:45 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5CA775399
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Aug 2022 03:29:41 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id A8A873200A2D;
        Wed, 17 Aug 2022 06:29:38 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 17 Aug 2022 06:29:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1660732178; x=1660818578; bh=nq
        EWiR7pHJAN6SWkq0ZJTwd01tGFrLCgeNeHZjg9e04=; b=qabXqT3dPxfvNPdaDM
        2AC2/ouTn9ntwhiPm0rocA9TAZB5qQuef+NqJQxGmyfS+i5L2W00Q/4dZFOX/8mF
        vPN2aWRoKw30nGsgi2yotNbzWRNxAiKk1mrlN/RL/SwuUMpDZ+JRY1sZTG0zMbDq
        fiU0ckSRsGjG7usUG0101csMbx1gmwDQ1hwO/n0S2gNzO/r6NoqbFeGoNHAsji01
        cUFW83q/1zj/HJgRPnzAphHWZ7WuZJ6iZIG8HUNphhPeyLEwqosEgN5oyyNAuu8e
        xXVa0S0o4X82Y1NLB1iWcPJ8FSHJmxRiNmyhc9G1bbjoJv9oj/IVdGJcxhxMWeqr
        VNfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1660732178; x=1660818578; bh=nqEWiR7pHJAN6SWkq0ZJTwd01tGF
        rLCgeNeHZjg9e04=; b=e0uHHh6fLyJ31e4G9LnDAqb4jQDDeb5pQYiZTLOiihc3
        X/IWT+GOdBM0KvvLCd4a7a/As6+T06OYiuEJE8qTdqurxsMAFfVhFywYK/G3SstD
        d6pRsbNxTUHy6xQ+zV00FKqSSJ33AkBkGfRJaHZuuTWgu+yKb2QBZgRQ9LOinL5h
        yMGzqmNm1+xAAGTMoI01xXbXPFJJTLB6YPVzg8CsQQX/lBgrFZKjgU/CaxSlrIZM
        +CFIKGi7FojrZeYj2r04twq9+mGR5QWc92VW87/A0WWgWGtsGVfiaN66noIqErLA
        1ywhsqV8Uyxj9CjlhO83x84MoVB19KbV4FsS3Tz4QQ==
X-ME-Sender: <xms:EcP8YlrZtpOcUOUJF7novB-3AtcHTfnCWlD9e4NSOt0EejSohgwt0w>
    <xme:EcP8YnqDD9_8RRyYZYth3_B7Lhi4RyfLUo_s8slhdjlVYUFY6umAVH8LtTcho51oc
    1GnWVIqLhh2IH79Xqg>
X-ME-Received: <xmr:EcP8YiPvkuEEXWCjIemsPoc1f9DUh9-AbxrTb2txRG1DeGJxfL69Uycsx_RvDDWmsrTKbA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehiedgvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdttddttddtvdenucfhrhhomhepfdfmihhr
    ihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpefhieeghfdtfeehtdeftdehgfehuddtvdeuheet
    tddtheejueekjeegueeivdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvg
X-ME-Proxy: <xmx:EcP8Yg6wkCFXcUFgEmFCusMbkPv5NsfpTI_GZYSpM9-LvZ49hfqAOw>
    <xmx:EcP8Yk5O8_UR-9HxOHI_kh3Y-VF8JVppVGg8NeSLSoisV0MwKg9BXw>
    <xmx:EcP8YogHwaUZb5xohIgdbb3f7xVe7p3HjO9UsaP4vmpV8j2J2NChgg>
    <xmx:EsP8YuSDZIgYwKXFY8vrwFLDjv51BfUBl5C_9K8JRWMQffOM6Repvg>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Aug 2022 06:29:37 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 7BD29104A77; Wed, 17 Aug 2022 13:29:35 +0300 (+03)
Date:   Wed, 17 Aug 2022 13:29:35 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ira Weiny <ira.weiny@intel.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: folio_map
Message-ID: <20220817102935.cqcqpmuu3vanfb63@box.shutemov.name>
References: <YvvdFrtiW33UOkGr@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvvdFrtiW33UOkGr@casper.infradead.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 16, 2022 at 07:08:22PM +0100, Matthew Wilcox wrote:
> Some of you will already know all this, but I'll go into a certain amount
> of detail for the peanut gallery.
> 
> One of the problems that people want to solve with multi-page folios
> is supporting filesystem block sizes > PAGE_SIZE.  Such filesystems
> already exist; you can happily create a 64kB block size filesystem on
> a PPC/ARM/... today, then fail to mount it on an x86 machine.
> 
> kmap_local_folio() only lets you map a single page from a folio.
> This works for the majority of cases (eg ->write_begin() works on a
> per-page basis *anyway*, so we can just map a single page from the folio).
> But this is somewhat hampering for ext2_get_page(), used for directory
> handling.  A directory record may cross a page boundary (because it
> wasn't a page boundary on the machine which created the filesystem),
> and juggling two pages being mapped at once is tricky with the stack
> model for kmap_local.
> 
> I don't particularly want to invest heavily in optimising for HIGHMEM.
> The number of machines which will use multi-page folios and HIGHMEM is
> not going to be large, one hopes, as 64-bit kernels are far more common.
> I'm happy for 32-bit to be slow, as long as it works.
> 
> For these reasons, I proposing the logical equivalent to this:
> 
> +void *folio_map_local(struct folio *folio)
> +{
> +       if (!IS_ENABLED(CONFIG_HIGHMEM))
> +               return folio_address(folio);
> +       if (!folio_test_large(folio))
> +               return kmap_local_page(&folio->page);
> +       return vmap_folio(folio);
> +}
> +
> +void folio_unmap_local(const void *addr)
> +{
> +       if (!IS_ENABLED(CONFIG_HIGHMEM))
> +               return;
> +       if (is_vmalloc_addr(addr))
> +               vunmap(addr);
> +	else
> +       	kunmap_local(addr);
> +}
> 
> (where vmap_folio() is a new function that works a lot like vmap(),
> chunks of this get moved out-of-line, etc, etc., but this concept)

So it aims at replacing kmap_local_page(), but for folios, right?
kmap_local_page() interface can be used from any context, but vmap helpers
might_sleep(). How do we rectify this?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
