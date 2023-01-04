Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D72E365E00A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jan 2023 23:34:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240543AbjADWeQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Jan 2023 17:34:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240347AbjADWeP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Jan 2023 17:34:15 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 363864260E;
        Wed,  4 Jan 2023 14:34:13 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id C324A5C00EA;
        Wed,  4 Jan 2023 17:34:10 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 04 Jan 2023 17:34:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1672871650; x=
        1672958050; bh=GhHK13puG9rbbmVLp8YxJh1oi2E1z8eW7EP8WFvlzbE=; b=P
        2rxRqqhwAYm82oHQZlx0eRquBq9ZbKOP3GKdJ563/G6LTzhGjkMpyJFzH5eUa/PX
        DaoAw+MhLf5t9tMzc9+3GHXPUF9LYA77CjlOcFP46f3PYJa2fy7U7HMVVgphFDwG
        /2QNvnirm2bH+0W8S3DJT1quRzS/nlbBZggpwkDPpCnOf76gYEEBn0HKaK/3s31u
        I1gLXMRob7wXikMCPXv5ZDFRimmLxTp8ZnnNq47QSeU3gr3Tcp0oxIwy9V383U2u
        aohzsLAqeKXo0Q9O1iKb4/s/upBfdrQxyQBLf19sBR7bdctl5vjxSwhcLjwlWivJ
        yTQ9nSFLzQyXM4p2VRBmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1672871650; x=
        1672958050; bh=GhHK13puG9rbbmVLp8YxJh1oi2E1z8eW7EP8WFvlzbE=; b=s
        XjvCay9qgfp5zZA/FK9sFizwgm3P949Px1iTHcIgW8gTVg86SVON5Wfbk9cu7P4h
        IufKBgZaD/y0adTibbCtd70bGu1wcKNqiggPDE8SZ3BfIz/ezIJLA7rXBpyO9lfm
        eM0GadwVZqDfSaDY/hwqpMYHohA8QlCgljo1xvKYbTRugVk4vk+dXit1lNVSqEDn
        +j+uLX8se25VVGGvly4Zz/t9lWJ3DUU+oxshdq8DGxmVjeMmORnRpkER5W+ftKTR
        I5ivgROXearuZrs3UY5aOwws/2XFAnKoJmvR2z8dH7IuwZJl7/3jMM4ZABFD5gxh
        e9zPd/1+v4UP3k/fKunug==
X-ME-Sender: <xms:4f61Y0kq7rlqRwa5qrGsGybkL6fvzLhofq5cbBitIKGmcyWSwvl3SQ>
    <xme:4f61Yz2zp7ViQ0uVBBNH1kf7n-onscPjH9L7mgZfYkU69rCQ8gCFcp5HaVsIa_-XL
    vJCcakZ8eCNjSDtG5A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrjeejucetufdoteggodetrfdotffvucfrrh
    hofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpefgkeeuleegieeghfduudeltdekfeffjeeuleehleefudettddtgfevueeffeeigeen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:4f61Yyp3DB1iBTFWX1mslGa6YZRkjsTkLa0ihJVdErUrhV-OYzSxtg>
    <xmx:4f61Ywnl-RxDAY2VGVQX6wdyc8nVnhG1BE6fwNKJ9i59vMLOAkwexQ>
    <xmx:4f61Yy1fvAgq5OEIcQ4B2FVdKhaiVIrhU8pzKUnQQPaH6n7XRoI93Q>
    <xmx:4v61Y7sWXUG5KKCDli-ondi4lSho29TgaWtYpUSJFStWM5SUaTI30w>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 9628CB60086; Wed,  4 Jan 2023 17:34:09 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1185-g841157300a-fm-20221208.002-g84115730
Mime-Version: 1.0
Message-Id: <ab7a9477-ddc7-430f-b4ee-c67251e879b0@app.fastmail.com>
In-Reply-To: <CAHk-=wi8XyAUF9_z6-oa4Ava6PVZeE-=TVNcFK1puQHpOtqLLw@mail.gmail.com>
References: <000000000000dbce4e05f170f289@google.com>
 <5f45bb9a-5e00-48dd-82b0-46b19b1b98a3@app.fastmail.com>
 <CAHk-=wi8XyAUF9_z6-oa4Ava6PVZeE-=TVNcFK1puQHpOtqLLw@mail.gmail.com>
Date:   Wed, 04 Jan 2023 23:33:50 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Linus Torvalds" <torvalds@linux-foundation.org>
Cc:     syzbot <syzbot+7bb7cd3595533513a9e7@syzkaller.appspotmail.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        christian.brauner@ubuntu.com,
        "Damien Le Moal" <damien.lemoal@opensource.wdc.com>,
        jlayton@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        "Matthew Wilcox" <willy@infradead.org>,
        ZhangPeng <zhangpeng362@huawei.com>,
        "Viacheslav Dubeyko" <slava@dubeyko.com>,
        linux-m68k@lists.linux-m68k.org
Subject: Re: [syzbot] [hfs?] WARNING in hfs_write_inode
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 4, 2023, at 20:06, Linus Torvalds wrote:
>
> I suspect this code is basically all dead. From what I can tell, hfs
> only gets updates for
>
>  (a) syzbot reports
>
>  (b) vfs interface changes

There is clearly no new work going into it, and most data exchange
with MacOS would use HFS+, but I think there are still some users.

> and the last real changes seem to have been by Ernesto A. Fern=C3=A1nd=
ez
> back in 2018.
>
> Hmm. Looking at that code, we have another bug in there, introduced by
> an earlier fix for a similar issue: commit 8d824e69d9f3 ("hfs: fix OOB
> Read in __hfs_brec_find") added
>
> +       if (HFS_I(main_inode)->cat_key.CName.len > HFS_NAMELEN)
> +               return -EIO;
>
> but it's after hfs_find_init(), so it should actually have done a
> hfs_find_exit() to not leak memory.
>
> So we should probably fix that too.
>
> Something like this ENTIRELY UNTESTED patch?
>
> Do we have anybody who looks at hfs?

Adding Viacheslav Dubeyko to Cc, he's at least been reviewing
patches for HFS and HFS+ somewhat recently. The linux-m68k
list may have some users dual-booting old MacOS.

Viacheslav, see the start of the thread at
https://lore.kernel.org/lkml/000000000000dbce4e05f170f289@google.com/

     Arnd
