Return-Path: <linux-fsdevel+bounces-822-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D22047D0E56
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Oct 2023 13:24:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 235A5B21483
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Oct 2023 11:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38C718E10;
	Fri, 20 Oct 2023 11:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="hk1zlwoa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XXMigayB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F399C18E03
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Oct 2023 11:23:48 +0000 (UTC)
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D08AC2;
	Fri, 20 Oct 2023 04:23:47 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id E55A15C0C3D;
	Fri, 20 Oct 2023 07:23:44 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Fri, 20 Oct 2023 07:23:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm2; t=1697801024; x=1697887424; bh=wp
	E9zAbVzd//8TsG30moNfOnsvMj+EYkAkZbMvhvoao=; b=hk1zlwoa5Jk84W10dt
	zWmZx4aJpGDQ6xaymLZL3MOxO4FNGDGJHVFPcx5aMJLVJn5cXz4Ay/i7yhCiWACh
	86OVeuIb8x0O1Iuiv/qil1ttasrCaSCggTDvdhJnn4ZpeH8h7wbU0ae89n7WxxhF
	vlb/ssQbXaVcrG5Zl369oT05fONGRaNwoCDjDTOJtXxamyWsImti6cuyD7ziK9D1
	1nv/7sodihqIx3kMnBkZ4L8D18yz3oKzV/crHIZkJYUQwkoMv2R+iPcHCzCD+AZl
	r8gyfvnCmUQQn9Zb0DjFognLtuh3TZkRyLBgP4ytj792YpaeYZP3ajgtuW4/bA6L
	BmJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1697801024; x=1697887424; bh=wpE9zAbVzd//8
	TsG30moNfOnsvMj+EYkAkZbMvhvoao=; b=XXMigayBs9CwyZww9675DooC525/F
	BuG4C2qbxz+qV42S38RoHo4+BBOweEo0fu3MIaIJ2XdlU3DZ72GJB38HIDW5iAwF
	f5+sBW5mgP9YXTw0+bLYSlF1L6mDwVvVt5wcHwY4mmEc7lltTlYHKDmEGoql3CAe
	pa9g+gV36ak+eddzmLkiEBBaWy7/t0LOMBNErYTiJru4uLZ0grneiWqK5EQkWiwW
	yb0755gtwFpradsNao75i3U9xoZCkngrnC3bQ4vk+nc8vO4yAApGZP1nLVnLyiZT
	oHQ73Cs2FdRFMKrh1d3Djhrv9tb0yTe15THfEtY29XJiLJdYC+heePZVQ==
X-ME-Sender: <xms:QGMyZYzZzBB4D3kQMCosu-m-LG0_srYuUxO1xxdAP2jzbGT65BtOuw>
    <xme:QGMyZcSEsm_7-depqOQffpO3oyQT95XQZjG4HnvXWXXr8RkUQ7Dh978hfMGUN31tP
    Y4iA3QYYoN6mLyI-P8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrjeekgdefkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:QGMyZaX3WkYfe4CPrZPzzBUPSJIiqwdfcgQ7Ihe7zHO6IJWOIGM26g>
    <xmx:QGMyZWgbOVYD3ZI6eE0yamwZc_Bei6R7QaZbBGRuYIeSahS_xIGBTg>
    <xmx:QGMyZaDfE7WGjoZBTNTtzW42EcULJPb1vuEUl0L06EQPB8wF8oLgYw>
    <xmx:QGMyZQDIlly3jfufdoKyM6Gc3RjDWerVZbOB1hpaE3aTck3y3_d-Pw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id A322DB60089; Fri, 20 Oct 2023 07:23:44 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1048-g9229b632c5-fm-20231019.001-g9229b632
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <f1cddf6e-2103-4786-84ff-12c305341d7c@app.fastmail.com>
In-Reply-To: <432f1c1c-2f77-4b1b-b3f8-28330fd6bac3@kadam.mountain>
References: 
 <CA+G9fYt75r4i39DuB4E3y6jRLaLoSEHGbBcJy=AQZBQ2SmBbiQ@mail.gmail.com>
 <71adfca4-4e80-4a93-b480-3031e26db409@app.fastmail.com>
 <CADYN=9+HDwqAz-eLV7uVuMa+_+foj+_keSG-TmD2imkwVJ_mpQ@mail.gmail.com>
 <432f1c1c-2f77-4b1b-b3f8-28330fd6bac3@kadam.mountain>
Date: Fri, 20 Oct 2023 13:23:22 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Dan Carpenter" <dan.carpenter@linaro.org>,
 "Anders Roxell" <anders.roxell@linaro.org>
Cc: "Naresh Kamboju" <naresh.kamboju@linaro.org>,
 "open list" <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org,
 linux-fsdevel@vger.kernel.org, autofs@vger.kernel.org,
 "Ian Kent" <raven@themaw.net>, "Bill O'Donnell" <bodonnel@redhat.com>,
 "Christian Brauner" <brauner@kernel.org>
Subject: Re: autofs: add autofs_parse_fd()
Content-Type: text/plain

On Fri, Oct 20, 2023, at 12:45, Dan Carpenter wrote:
> On Fri, Oct 20, 2023 at 11:55:57AM +0200, Anders Roxell wrote:
>> On Fri, 20 Oct 2023 at 08:37, Arnd Bergmann <arnd@arndb.de> wrote:
>> >
>> > On Thu, Oct 19, 2023, at 17:27, Naresh Kamboju wrote:
>> > > The qemu-x86_64 and x86_64 booting with 64bit kernel and 32bit rootfs we call
>> > > it as compat mode boot testing. Recently it started to failed to get login
>> > > prompt.
>> > >
>> > > We have not seen any kernel crash logs.
>> > >
>> > > Anders, bisection is pointing to first bad commit,
>> > > 546694b8f658 autofs: add autofs_parse_fd()
>> > >
>> > > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>> > > Reported-by: Anders Roxell <anders.roxell@linaro.org>
>> >
>> > I tried to find something in that commit that would be different
>> > in compat mode, but don't see anything at all -- this appears
>> > to be just a simple refactoring of the code, unlike the commits
>> > that immediately follow it and that do change the mount
>> > interface.
>> >
>> > Unfortunately this makes it impossible to just revert the commit
>> > on top of linux-next. Can you double-check your bisection by
>> > testing 546694b8f658 and the commit before it again?
>> 
>> I tried these two patches again:
>> 546694b8f658 ("autofs: add autofs_parse_fd()") - doesn't boot
>> bc69fdde0ae1 ("autofs: refactor autofs_prepare_pipe()") - boots
>> 
>
> One difference that I notice between those two patches is that we no
> long call autofs_prepare_pipe().  We just call autofs_check_pipe().

Indeed, so some of the f_flags end up being different. I assumed
this was done intentionally, but it might be worth checking if
the patch below makes any difference when the flags get put
back the way they were. This is probably not the correct fix, but
may help figure out what is going on. It should apply to anything
from 546694b8f658 ("autofs: add autofs_parse_fd()") to the current
linux-next:

--- a/fs/autofs/inode.c
+++ b/fs/autofs/inode.c
@@ -358,6 +358,11 @@ static int autofs_fill_super(struct super_block *s, struct fs_context *fc)
        pr_debug("pipe fd = %d, pgrp = %u\n",
                 sbi->pipefd, pid_nr(sbi->oz_pgrp));
 
+        /* We want a packet pipe */
+        sbi->pipe->f_flags |= O_DIRECT;
+        /* We don't expect -EAGAIN */
+        sbi->pipe->f_flags &= ~O_NONBLOCK;
+
        sbi->flags &= ~AUTOFS_SBI_CATATONIC;
 
        /*

