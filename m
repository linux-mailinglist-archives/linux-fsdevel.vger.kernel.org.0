Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 261FE56761E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Jul 2022 20:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbiGESBu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Jul 2022 14:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbiGESBs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Jul 2022 14:01:48 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E0FC19C14
        for <linux-fsdevel@vger.kernel.org>; Tue,  5 Jul 2022 11:01:47 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id AB9B63200077;
        Tue,  5 Jul 2022 14:01:46 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 05 Jul 2022 14:01:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1657044106; x=1657130506; bh=7lnRwv98OO
        u4JZdxS9Zpa3bPkiFHT3gfuM5R0+kmzO8=; b=ncscX4i58Tbt+sdch06Yw7LKGX
        Y8T6BKBdogSorSmBNlT9JGNT6jMJzL6XmC4gjRG8FtqrR2ziqTVuE2U9pBdPzeqQ
        vdg7MXQW3gRSoo1lOZZEyAZaZaKn9N47oD3gcywOe8pSdkMAt4V8CGnnVpk/eQ55
        jthtLny8AtF+NAYZaxFALE6unMqDghM+3I1bWW2iEW20MltHxjv1MBii65aYPo+c
        3222iY0rZ5DwuPccEmeg5EMjXabAictYBeLoCKlhxxAhSNEbh2dLVOh/sYq/jc0M
        Yx1D43xviCGvpuvHk2n7sLtBzrxrwXCGWF+LhNoyoMiBAGb8bL94xTvHDs0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1657044106; x=1657130506; bh=7lnRwv98OOu4JZdxS9Zpa3bPkiFH
        T3gfuM5R0+kmzO8=; b=ZIuo0FR6jrXm3AK68VF1IV/ziWKOSC4nN5bkJCv01Len
        LHtzv/8Lk9TNJf9oPEnLuJFq2ObO7NjoQy1RUNGxQXHIcTn9Q83kbwgbeygBP2Nf
        wS1oAasUyTnpQt4HdLU3fQ+Wh7MsTlxrnf+n/MU3D3AT8pCDC655Cs0xgo4R4COl
        suN2FY29W3dEhnETlyngxOLcH1gSo1xrGAsyAaKAnWJ+7PQA67b6mhX2J1zKKlXS
        ks02/ejujy7oH8GSqHqjrM75vn5SA/3+aR0bIksF8zLeXXaePFI6CAjMMP/eR+O6
        FLCoB8SdR5Obmv0cQOUIb2ghspCsyU4YFKAD7suebg==
X-ME-Sender: <xms:iXzEYhAgt3m9pSfFUTH14bcVTWlJVSXKr2aK5ZCr75ZkQHFSC2cajA>
    <xme:iXzEYvgifRB0obdXWgkCu7CUIsqswwySo5dICSa461rTZfpaaK4BZsbpBcTYBXx66
    yYGSBKDhTa-kOKzIG8>
X-ME-Received: <xmr:iXzEYskLs7Yj7S89-z_dd641dzF9AHqmVjIgQnf95jaX9bdSSKwM-b6AeX5_Yq3GBivZvab76JGVx5Glej-3vROWKj0heA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudeiuddguddvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesth
    dtredttddtvdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghu
    rhdrihhoqeenucggtffrrghtthgvrhhnpeekvdekffejleelhfevhedvjeduhfejtdfhvd
    evieeiiedugfeugfdtjefgfeeljeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:iXzEYrwGAhdOCUpDn4iOrsrt-ht_hmIIpjujdv9K3O8CPKvv0cmdVg>
    <xmx:iXzEYmSKfRdhkFvsbxil2CWq0BvV6kYSJhHvlHUGZREUd5FmNe1s4g>
    <xmx:iXzEYuZg4JdBCnDrr9NpfJwPlLa782IwgR2PTq2ZBrm0QSepXqyhTw>
    <xmx:inzEYv54wHTmDCdIcdFNDdyzfUtbzt-0sUVExAFszWGFJ6G3l5JKQA>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Jul 2022 14:01:45 -0400 (EDT)
Date:   Tue, 5 Jul 2022 11:01:43 -0700
From:   Boris Burkov <boris@bur.io>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: XArray multiple marks support
Message-ID: <YsR8h34aNzHiS3EY@zen>
References: <Yr3Fum4Gb9sxkrB3@zen>
 <YsNqmIQP7LTs/vXB@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YsNqmIQP7LTs/vXB@casper.infradead.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 04, 2022 at 11:32:56PM +0100, Matthew Wilcox wrote:
> On Thu, Jun 30, 2022 at 08:48:10AM -0700, Boris Burkov wrote:
> > I was reading the XArray documentation and noticed a comment that there
> > is potential support for searching by ANDs of multiple marks, but it was
> > waiting for a use case. I think I might have such a use case, but I'm
> > looking for some feedback on its validity.
> > 
> > I'm working on some fragmentation issues in a space allocator in btrfs,
> > so I'm attempting to categorize the allocation unit of this allocator
> > (block group) by size class to help. I've got a branch where I migrated
> > btrfs's storage of block groups from a linked list to an xarray, since
> > marks felt like a really nice way for me to iterate by size class.
> > 
> > e.g.:
> > mark = get_size_class_mark(size);
> > xa_for_each_marked(block_groups, index, block_group, mark) {
> >         // try to allocate in block_group
> > }
> > 
> > Further, this allocator already operates in passes, which try harder and
> > harder to find a block_group, which also fits nicely, since eventually,
> > I can make the mark XA_PRESENT.
> > 
> > i.e.:
> > while (pass < N) {
> >         mark = get_size_class_mark(size);
> >         if (pass > K)
> >                 mark = XA_PRESENT;
> >         xa_for_each_marked(block_groups, index, block_group, mark) {
> >                 // try to allocate in block_group
> >         }
> >         if (happy)
> >                 break;
> >         pass++;
> > }
> > 
> > However, I do feel a bit short on marks! Currently, I use one for "not
> > in any size class" which leaves just two size classes. Even a handful
> > more would give me a lot of extra flexibility. So with that said, if I
> > could use ANDs in the iteration to make it essentially 7 marks, that
> > would be sweet. I don't yet see a strong need for ORs, in my case.
> 
> Unfortunately, I don't think doing this will work out really well for
> you.  The bits really are independent of each other, and the power of
> the search marks lies in their ability to skip over vast swathes of
> the array when they're not marked.  But to do what you want, we'd end up
> doing something like this:
> 
> leaf array 1:
>   entry 0 is in category 1
>   entry 1 is in category 2
>   entry 2 is in category 5
> 
> and now we have to set all three bits in the parent of leaf array 1,
> so any search will have to traverse all of leaf array 1 in order to find
> out whether there are any entries in the category we're looking for.

Thank you for the explanation. To check my understanding, does this
point also imply that currently the worst case for marked search is if
every leaf array has an entry with each mark set?

> 
> What you could do is keep one XArray per category.  I think that's what
> you're proposing below.  It's a bit poor because each XArray has its
> own lock, so to move a group from one size category to another, you have
> to take two locks.  On the other hand, that means that you can allocate
> from two different size categories at the same time, so maybe that's a
> good thing?

I'll either do this, or convince myself that 3 categories is sufficient.

> 
> > Does this seem like a good enough justification to support finding by
> > combination of marks? If not, my alternative, for what it's worth, is
> > to have an array of my block group data structure indexed by size class.
> > If you do think it's a good idea, I'm happy to help with implementing
> > it or testing it, if that would be valuable.
> > 
> > Thanks for your time,
> > Boris
