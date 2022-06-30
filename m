Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7B8561FAD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jun 2022 17:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233782AbiF3PsR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jun 2022 11:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235391AbiF3PsQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jun 2022 11:48:16 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDFD7E031
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jun 2022 08:48:13 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 3DE1E5C0125;
        Thu, 30 Jun 2022 11:48:13 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 30 Jun 2022 11:48:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1656604093; x=1656690493; bh=d/Jx+H6PRm1zswCa7BlI7vrZ4Pgg7g9MR8o
        4YwOt3uU=; b=DQ9YoCSC5hojtjSXW6gTYnuWPm38OAuPb73zgz4jaOs6oj7DlVN
        zgwmgjF64x0FmKFL2PhKcvyiuZd+VyGP+8gAjkeixne9a8GCDEwHrAq9EZqh32Ox
        TTSXIs40hIbQbC+HYlLPjvomw8ulfEQgnryoysnsdLEF0PTdFCe7VgA3gzqcbmRV
        5NP83UrtLuB65dbuaXvklwgsiluFpvdR1JIC1do+NaD/ee55nQnEXjgw01uFewP9
        0M1XpYxaXfqZZftacLrmO475vqrE/SGlh2EdEtwlobpDm616XW//ewEO/KBeIcpT
        WDn+LEvtfwrKOcOTME3QpHTrQ9xnu5Md4fw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:message-id:mime-version
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1656604093; x=
        1656690493; bh=d/Jx+H6PRm1zswCa7BlI7vrZ4Pgg7g9MR8o4YwOt3uU=; b=G
        ZBpscr4gvBBB2Qem+2bA3Gon8mT/plwZjGu1wC2ZrSzs4AhoPXEB+rl2P8kKbYgg
        aJgC2iS8+i+nc8mSV92dsYm/+eNz9jKtlWgi4JTphokdYhIPxEiwV6Mc9Vjd4oqq
        5GZJ0mXK4B4x0RgOPx2hiyaviuk6mSDNwKv17Y9WXJMgozcgV1Hn2fQ/kpHpucI6
        b3poxxavaZBmxo856rn/j8RCaUYkwlG3dYvuW88kNg606ufdQKSiqNVmCa13oJkk
        /Kw0erUYvy/vAfZ+01edkHW65TX8MR43V+3iH0VPBksHhBNHsO138JsmYlEqy16d
        vYKMthfbjcO2cQGE2od7w==
X-ME-Sender: <xms:vMW9YomVVPIpQUme6nVAeRJQWp5xPCeKZRgIW32xsprqGHsZrNPR7A>
    <xme:vMW9Yn3dnhy9ZBDQRa-70ICK3PXBAnLgo_qi4Bm0TswKAD8e0LjJH8Xd4eayXylvX
    YOiD0ZY-381vaTbkNs>
X-ME-Received: <xmr:vMW9Ymr0PnccngxJikyX3I5tWNEyOgL5kqRuhKS7HZYopvX5fWCDFtj2FZcQMlMCJCnWGIKrmH2togNUbXxmDQdw-3Jl_w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudehuddgledvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfggtggusehttdertd
    dttddvnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepjeeukeethedtfeekhfdvuefgkedvvdelheefueduud
    duleeugffgudfgkedvleffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:vcW9Ykm5ANgrpt8Gvw3Jx9JRAUrGqBvkjZCE_913fJG4hZPqChr0bQ>
    <xmx:vcW9Ym0-Vvg_ButgX5ZFUEdcYSgPej2hTxdMbJtf6dGCJ0pjhF6Avg>
    <xmx:vcW9YrseMczbKrYbKUDsePfegsu1jPaPPsJMcARfuIQQrLgwvqo4ag>
    <xmx:vcW9Yr90isrP2ThDdY8KFwdtnvlgYZhmRXTpdKc3Rl2DjZhCq1ONiw>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Jun 2022 11:48:12 -0400 (EDT)
Date:   Thu, 30 Jun 2022 08:48:10 -0700
From:   Boris Burkov <boris@bur.io>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: XArray multiple marks support
Message-ID: <Yr3Fum4Gb9sxkrB3@zen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Matthew,

I was reading the XArray documentation and noticed a comment that there
is potential support for searching by ANDs of multiple marks, but it was
waiting for a use case. I think I might have such a use case, but I'm
looking for some feedback on its validity.

I'm working on some fragmentation issues in a space allocator in btrfs,
so I'm attempting to categorize the allocation unit of this allocator
(block group) by size class to help. I've got a branch where I migrated
btrfs's storage of block groups from a linked list to an xarray, since
marks felt like a really nice way for me to iterate by size class.

e.g.:
mark = get_size_class_mark(size);
xa_for_each_marked(block_groups, index, block_group, mark) {
        // try to allocate in block_group
}

Further, this allocator already operates in passes, which try harder and
harder to find a block_group, which also fits nicely, since eventually,
I can make the mark XA_PRESENT.

i.e.:
while (pass < N) {
        mark = get_size_class_mark(size);
        if (pass > K)
                mark = XA_PRESENT;
        xa_for_each_marked(block_groups, index, block_group, mark) {
                // try to allocate in block_group
        }
        if (happy)
                break;
        pass++;
}

However, I do feel a bit short on marks! Currently, I use one for "not
in any size class" which leaves just two size classes. Even a handful
more would give me a lot of extra flexibility. So with that said, if I
could use ANDs in the iteration to make it essentially 7 marks, that
would be sweet. I don't yet see a strong need for ORs, in my case.

Does this seem like a good enough justification to support finding by
combination of marks? If not, my alternative, for what it's worth, is
to have an array of my block group data structure indexed by size class.
If you do think it's a good idea, I'm happy to help with implementing
it or testing it, if that would be valuable.

Thanks for your time,
Boris
