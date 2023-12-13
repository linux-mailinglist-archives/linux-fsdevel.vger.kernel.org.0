Return-Path: <linux-fsdevel+bounces-5814-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 25509810BA9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 08:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB583B20D61
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 07:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E7C1A733;
	Wed, 13 Dec 2023 07:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="XCUzwBdJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R6VTVj7I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C96E8DC;
	Tue, 12 Dec 2023 23:40:26 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 62D2B3200A90;
	Wed, 13 Dec 2023 02:40:25 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 13 Dec 2023 02:40:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1702453224; x=1702539624; bh=+xadsfRa9t
	5Ek/KCGD+z2BjSpseXGN+GqLXIGDzo42w=; b=XCUzwBdJQoGDiXeCf/4+w+19aS
	jXvU+cTqB2FVUT+m798geBPyDjnB8RJrgDr3B4ZM7SE6Q7WOEgintCLCiz9dfgxf
	c1zizWJXjLGUDvJIcl7PNBK4+T8scxm6Pqw7PhrwIdEpCGiQmNQtbFywxaZhWax2
	wBknrpa9p05NSaZMA9fO/uR4U4mOXxZx2Z6OAKJlBfmI27MGgzllTIpelsrGWVYy
	q7ASZWHGcqSeCbChf6G5MapzM3DEaHrDqU6q/6fGcRHysi0SGLRjFQ+W26xQUDIg
	dIQFfG7RVdHXvypUHUNvKCnreg4KyR4H5SknqcdHBpSNHo2Z0IceO7ius9rA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1702453224; x=1702539624; bh=+xadsfRa9t5Ek/KCGD+z2BjSpseX
	GN+GqLXIGDzo42w=; b=R6VTVj7I+OJdCqOLai9tUq2i+99xlc9idnS0jQ8uLOd7
	U+RZq3jA7vJStAiPRS+kBThXEB2tt8BwBTop2AwLC5ZelNF7C4fGgOI8PlfDLZfN
	r9fJCA6I/JGSAvvZzb2UzlN7RXRVo+2mZele+R0545c73r0A9j//n/76QR1e7dmx
	n8vIViLtS81WdKd9czC90UKT0ghXs12qHKX7usEmQA25HAgrV+WJjnsNsAsec0cB
	8o2fi/p/PO3fcqXXfj+SZhOmBJh26RSuPSo209ZiKHiFphOdg6aCAVKgmdvgmEZr
	QBgJf3nvUkEBk5+SQc/ZxE3Hq3tl5wTYal+HWtfoKw==
X-ME-Sender: <xms:6F95ZbyXLa9klDHGG_J-qs6wuQMdjdk8SjIrMa9uulBtQK3-MI0B7A>
    <xme:6F95ZTSfAr5BiconF4ODlLLFLPp--RVrMOtEE5M-wu62xlRvBfBpxHa2Kd7dO-yht
    OH3Jai0zIXHarc17Sg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudelhedgudduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:6F95ZVXZdhVkmI5LCHXeIqENe2Yjwis6JI4_czu28lK7egWSvsByvw>
    <xmx:6F95ZVhTHEC_OBsIejQwagDsdBX1S79kIH6I96jDQeiCkZYY8h6j1A>
    <xmx:6F95ZdBQVCDzSzOjb7TTs8F00-HFzlTn-UELcDF0rbFzr-kjN1Jl0g>
    <xmx:6F95ZR3BEvOGSUbD2YuteAN9Dyf5PhvlPLwCaa3uUBmyMNTHOGCyzw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 0CD9BB6008D; Wed, 13 Dec 2023 02:40:24 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1283-g327e3ec917-fm-20231207.002-g327e3ec9
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <833f0dd5-ded8-4925-9c3c-639728000598@app.fastmail.com>
In-Reply-To: <eab9dee1-a542-b079-7c49-7f3cb2974e47@themaw.net>
References: <20231212214819.247611-1-arnd@kernel.org>
 <eab9dee1-a542-b079-7c49-7f3cb2974e47@themaw.net>
Date: Wed, 13 Dec 2023 08:40:01 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Ian Kent" <raven@themaw.net>, "Arnd Bergmann" <arnd@kernel.org>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>
Cc: "Jan Kara" <jack@suse.cz>, "Miklos Szeredi" <mszeredi@redhat.com>,
 "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>,
 "Dave Chinner" <dchinner@redhat.com>, "Amir Goldstein" <amir73il@gmail.com>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] statmount: reduce runtime stack usage
Content-Type: text/plain

On Wed, Dec 13, 2023, at 02:13, Ian Kent wrote:
> On 13/12/23 05:48, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>>
>> prepare_kstatmount() constructs a copy of 'struct kstatmount' on the stack
>> and copies it into the local variable on the stack of its caller. Because
>> of the size of this structure, this ends up overflowing the limit for
>> a single function's stack frame when prepare_kstatmount() gets inlined
>> and both copies are on the same frame without the compiler being able
>> to collapse them into one:
>>
>> fs/namespace.c:4995:1: error: stack frame size (1536) exceeds limit (1024) in '__se_sys_statmount' [-Werror,-Wframe-larger-than]
>>   4995 | SYSCALL_DEFINE4(statmount, const struct mnt_id_req __user *, req,
>>
>> Mark the inner function as noinline_for_stack so the second copy is
>> freed before calling do_statmount() enters filesystem specific code.
>> The extra copy of the structure is a bit inefficient, but this
>> system call should not be performance critical.
>
> Are you sure this is not performance sensitive, or is the performance
> critical comment not related to the system call being called many times?
>
>
> It's going to be a while (if ever) before callers change there ways.
>
> Consider what happens when a bunch of mounts are being mounted.
>
>
> First there are a lot of events and making the getting of mount info.
> more efficient means more of those events get processed (itself an issue
> that's going to need notification sub-system improvement) resulting in
> the system call being called even more.

Ok, I'll send a v2 that is more efficent. I expected it to look uglier,
but I don't think it's actually that bad:

--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4957,15 +4957,12 @@ static int prepare_kstatmount(struct kstatmount *ks, struct mnt_id_req *kreq,
        if (!access_ok(buf, bufsize))
                return -EFAULT;
 
-       *ks = (struct kstatmount){
-               .mask           = kreq->param,
-               .buf            = buf,
-               .bufsize        = bufsize,
-               .seq = {
-                       .size   = seq_size,
-                       .buf    = kvmalloc(seq_size, GFP_KERNEL_ACCOUNT),
-               },
-       };
+       memset(ks, 0, sizeof(*ks));
+       ks->mask        = kreq->param,
+       ks->buf         = buf,
+       ks->bufsize     = bufsize,
+       ks->seq.size    = seq_size,
+       ks->seq.buf     = kvmalloc(seq_size, GFP_KERNEL_ACCOUNT),
        if (!ks->seq.buf)
                return -ENOMEM;
        return 0;

