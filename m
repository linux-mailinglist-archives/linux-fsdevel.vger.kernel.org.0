Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 189C46F9D27
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 May 2023 03:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbjEHA77 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 7 May 2023 20:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231976AbjEHA76 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 7 May 2023 20:59:58 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B51F100C1
        for <linux-fsdevel@vger.kernel.org>; Sun,  7 May 2023 17:59:57 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 6E56C320090B;
        Sun,  7 May 2023 20:59:53 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sun, 07 May 2023 20:59:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1683507593; x=
        1683593993; bh=9mr4/wH/xvTwG6JnN9j4VBc8laq91Nnaq1pB0ffavak=; b=t
        /W9pml+33ePA2kUVO9/L8AFOCClVmAQayJd4awQ63u6LufabuiKQiENIMCGXxF0U
        qgu5FoOq28AR2v80j23gJicGkOSbyYsspjw+bFz+EQqyfL4OEpxkkDcXy3GzJfom
        AY12o7+sCtf1FTlsYQVaEQz9DC7uK6ekoKV6wly52k3gKLNCtuiQMsqTI54By7un
        3Z6OXRw84do8JlEidpWFU93Ryo0gdlFVq2YRRNUN5DOXw7UTnCCvpNtpn0kYVlX7
        U58ngPRzTf7ZfdSxNMzoJO7v4hr9GPHgRrmXyBmfy+KsUvm2jz3QxEasSG7WiUk3
        hZCv0wybCjModsiHwfnyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1683507593; x=1683593993; bh=9mr4/wH/xvTwG
        6JnN9j4VBc8laq91Nnaq1pB0ffavak=; b=cwFPgg/l9InA0OkHNrFQ5AYpbNTnl
        VXSoOQn8hu5RBz8Q+nyUZAZccPCta9DdhDvXsDdYgEF4UiglbEHApLoNgg0JAJFA
        yYANmO2zGK4e95zRTlV9eBQFMd82H7cdEfyGAOQd1esj9KgoPCW00XbOGsiBSdZe
        xaj9GuuV4aiXQ4OWaYectuLhmrVNmmFAn1LJOkf5Bx1KMQolHgmWgHxFcCMPvuGw
        fksIAYjS4DVV82qVBji2JDICvyXO34MNjF8emJ1etkVdXb0Ef/6NWsD+HrzAhaf4
        e8DirIesHXvwLytJ9ER9+oU1Z/3mJb2kQjfROF+pCgnvRfnNZXHkdAGmA==
X-ME-Sender: <xms:iElYZGd3KX638KIH4CyzWe8XqBf3wDTXkZdrND-XRAefLelpoEGIAQ>
    <xme:iElYZAN92KWUeGbSZbF3hMXNb159p00keDx7yZVOPBxcPa0GfO7HgeKa5W7wCuRoz
    bcU4_mi_ll5YLa3cZc>
X-ME-Received: <xmr:iElYZHhEou2BN6IUWe9r-0adCdOENpjL6EgrGhLgwiPnLse_9AbqwvoD-X4UTNlys70hMA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeefjedggedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttd
    dttddttddvnecuhfhrohhmpedfmfhirhhilhhlucetrdcuufhhuhhtvghmohhvfdcuoehk
    ihhrihhllhesshhhuhhtvghmohhvrdhnrghmvgeqnecuggftrfgrthhtvghrnhephfeige
    fhtdefhedtfedthefghedutddvueehtedttdehjeeukeejgeeuiedvkedtnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhirhhilhhlsehshh
    huthgvmhhovhdrnhgrmhgv
X-ME-Proxy: <xmx:iElYZD9jHmv10gbA34jYEH6Y200n9PlnXrll03fOLJ2QKZymJGAn7w>
    <xmx:iElYZCugckUfNNLbmFnRyvQjYgVBS7xR31KBv4QO_tFi3ledqscI9A>
    <xmx:iElYZKFwPwDz5XA9_rRahbWiKKJuA8R__jqBhDYxeMrlDIwYJPb3hw>
    <xmx:iUlYZL5nQ72KVajjacN2alYqMR9ROIWupp_opGAm53WTJ8paBxifDA>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 7 May 2023 20:59:52 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 6E43210D1E7; Mon,  8 May 2023 03:59:49 +0300 (+03)
Date:   Mon, 8 May 2023 03:59:49 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [LSF/MM/BPF] Whither Highmem?
Message-ID: <20230508005949.fg2apsozarbcahnr@box.shutemov.name>
References: <ZFgySub+z210Rvsk@casper.infradead.org>
 <20230507234330.cnzbumof2hdl4ci6@box.shutemov.name>
 <ZFhA/CGgfo71jPtK@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZFhA/CGgfo71jPtK@casper.infradead.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 08, 2023 at 01:23:24AM +0100, Matthew Wilcox wrote:
> On Mon, May 08, 2023 at 02:43:30AM +0300, Kirill A. Shutemov wrote:
> > On Mon, May 08, 2023 at 12:20:42AM +0100, Matthew Wilcox wrote:
> > > 
> > > I see there's a couple of spots on the schedule open, so here's something
> > > fun we could talk about.
> > > 
> > > Highmem was originally introduced to support PAE36 (up to 64GB) on x86
> > > in the late 90s.  It's since been used to support a similar extension
> > > on ARM (maybe other 32-bit architectures?)
> > > 
> > > Things have changed a bit since then.  There aren't a lot of systems
> > > left which have more than 4GB of memory _and_ are incapable of running a
> > > 64-bit kernel.
> > 
> > Actual limit is lower. With 3G/1G userspace/kernel split you will have
> > somewhere about 700Mb of virtual address space for direct mapping.
> > 
> > But, I would like to get rid of highmem too. Not sure how realistic it is.
> 
> Right, I was using 4GB because on x86, we have two config options that
> enable highmem, CONFIG_HIGHMEM4G and CONFIG_HIGHMEM64G.  If we get rid
> of the latter, it could be a nice win?

Not really. CONFIG_HIGHMEM64G is basically synonym for PAE that has more
goodies beyond wider phys_addr_t, like NX bit support. PAE and HIGHMEM4G
are mutually exclusive (but NOHIGHMEM is fine).

> Also, the more highmem we have, the more kinds of things we need to put in
> highmem.  Say we have a 3:1 ratio of high to lowmem.  On my 16GB laptop,
> I have 5GB of Cached and 8.5GB of Anon.  That's 13.5GB, so assuming that
> ratio would be similar for a 4GB laptop, it's 5.4:1 and storing _just_
> anon & cached pages in highmem would be more than enough.
> 
> (fwiw, PageTables is 125MB)
> 
> Maybe there's a workload that needs, eg page tables or fs metadata to
> be stored in highmem.  Other than pathological attempts to map one
> page per 2MB, I don't think those exist.
> 
> Something I forgot to say is that I do not think we'll see highmem being
> needed on 64-bit systems.

I hope not. CPU designers must know by now to provide at least 2-bit wider
virtual address space than physical address space.

> We already have CPUs with 128-bit registers,
> and have since the Pentium 3.  128-bit ALUs are missing, but as long as
> we're very firm with CPU vendors that this is the kind of nonsense up
> with which we shall not put, I think we can get 128-bit normal registers
> at the same time that they change the page tables to support more than
> 57 bits of physical memory.

Current architectural limit on x86 PA is 52.

I think we would need 128-bit PTEs before we run out of physical address
space (or get 128-bit GPRs). We don't have bits for new features in PTE
and started to eat out PFN bits.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
