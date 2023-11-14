Return-Path: <linux-fsdevel+bounces-2819-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C1987EABA0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Nov 2023 09:30:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F6671C20A02
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Nov 2023 08:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1505E168BF;
	Tue, 14 Nov 2023 08:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="YieOsOBy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QPS1Dter"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33120168B1;
	Tue, 14 Nov 2023 08:30:38 +0000 (UTC)
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 356491AC;
	Tue, 14 Nov 2023 00:30:36 -0800 (PST)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.nyi.internal (Postfix) with ESMTP id B4D995C02AD;
	Tue, 14 Nov 2023 03:30:32 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Tue, 14 Nov 2023 03:30:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to; s=fm3; t=
	1699950632; x=1700037032; bh=e9TuNY/MgUAE3JgFVSVk32xC4oXMQG0XMcL
	r2XaWy5s=; b=YieOsOBya8bi01V64pl/+Hptg6wcpg+kVdeuU9ed4rD0x4RjOhI
	9ZwBL3+FTduDfzW4KY9bGh0/kKDL7Ys92YgPYB6bOI9QEusE+mNsVOOoUgdRRLvY
	PGTSaxuze3nE/EPW38vZbgoRye72FL5jpaDjyT3DiGodyC1mDBLgxaIBvNxm4Lb+
	NtIjqx7oiUfIQIECa8xGxKYSyQMjVuTOE9SVUs4Xq0fEoN819okpN2ghADO+I1l3
	2/QM82COZwBijH8E4A5J1EvineaNNdXbwUTSxuR4HPvxKhkLWhZ8hbva0FQQLv0C
	6eBo6kic09UJgTCi/A6UNSEy/mridC57rUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1699950632; x=1700037032; bh=e9TuNY/MgUAE3JgFVSVk32xC4oXMQG0XMcL
	r2XaWy5s=; b=QPS1DterzM8AsAGl81Tkm4vZn97jwLaC/Rutn1rScC6FlEipkTo
	84myra5htLkhpFljrnmap/3tNud3W8O1YM9fxyGalrcnHwIZOEvB8Yy+mbdGLA9n
	RwL7H0vdtgCSLle2e6VH0SFi1cTGfXj8o1UlsmR9gOSKudHHtUdu6938IHsEsEuC
	3t7Xz22l5Mkez4qteQkGXqa4Gg8+bMrgwICvrXehL7RNYV1TDhoaii1hIfzJp3E9
	v/E22t71mJHtEsRI6jR6TV0fCtlwEHnCRDdky/0/0dlIxTxtjlxjdQrkHp+cWpoo
	k8iE4Bj07pe1vmbJqikqW9OHKNLejbI7yOw==
X-ME-Sender: <xms:KDBTZfMcuTtXDXICwtvbv4qf_XMylGYCPutk41fE8WCpH7xuXNKqyw>
    <xme:KDBTZZ_BzW-wQPmrB64Sx_QGQLWu3TpPIKJ6DymnRK-EwIa6IcGvHiYMfOiB8a-0l
    NnBDvje3Mvn>
X-ME-Received: <xmr:KDBTZeSihM5Z3EHZ8FJPq0v3K7Wo-Rcd8AKj0285Cuxj8nIi54aW1vykRpKX2ZePGdKBra1mhriPzHFQzsOqE5mwqgX8AqS_2Ma6E7kLgb9KjENLnCdrQumk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudefuddguddvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefkffggfgfvvehfhffujggtgfesthekredttdefjeenucfhrhhomhepkfgr
    nhcumfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrh
    hnpeeujedtffffueehfefgvdefkeduffdvjeevvedukeevveekhedtheegkeeujedvveen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghvvg
    hnsehthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:KDBTZTuf5T_ThwE16gXqlZ5AD7OszJbFQdKytzxGlMKusvfXBt14hQ>
    <xmx:KDBTZXeSe7JDugEs0T-RobutcW2XHYtbFIaB5fPdvz8uluxCxa-FMQ>
    <xmx:KDBTZf3izrydV4SUDjECloqGgppoSG8cFJPjJhd5BfZ6LXv3YqT4Og>
    <xmx:KDBTZe7cnqUJYvhPHKIVHZkMcN72xMwSaT-IXPfG4N1b5v1-w-xtzw>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Nov 2023 03:30:29 -0500 (EST)
Message-ID: <e2654c2c-947a-60e5-7b86-9a13590f6211@themaw.net>
Date: Tue, 14 Nov 2023 16:30:25 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Edward Adam Davis <eadavis@qq.com>,
 syzbot+662f87a8ef490f45fa64@syzkaller.appspotmail.com,
 autofs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <000000000000ae5995060a125650@google.com>
 <tencent_3744B76B9760E6DA33798369C96563B2C405@qq.com>
 <4fcf49456c32087f5306e84c4a8df5b2bd9f4146.camel@themaw.net>
 <20231114044110.GR1957730@ZenIV>
Content-Language: en-US
From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] autofs: fix null deref in autofs_fill_super
In-Reply-To: <20231114044110.GR1957730@ZenIV>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 14/11/23 12:41, Al Viro wrote:
> On Tue, Nov 14, 2023 at 12:25:35PM +0800, Ian Kent wrote:
>>>          root_inode = autofs_get_inode(s, S_IFDIR | 0755);
>>> +       if (!root_inode)
>>> +               goto fail;
>> Yes, I think this is the only thing it could be.
>>
>> There's one small problem though, it leaks the dentry info. ino,
>> allocated just above. I think this should goto label fail_ino instead.
>>
>> Note that once the root dentry is allocated then the ino struct will
>> be freed when the dentry is freed so ino doesn't need to be freed.
> There's a simpler solution:
>
>          root_inode = autofs_get_inode(s, S_IFDIR | 0755);
> 	if (root_inode) {
> 		root_inode->i_uid = ctx->uid;
> 		root_inode->i_gid = ctx->gid;
> 	}
>          root = d_make_root(root_inode);
>          if (!root)
>                  goto fail_ino;
>
> d_make_root(NULL) will quietly return NULL, which is all you
> need.  FWIW, I would probably bring the rest of initialization
>          root_inode->i_fop = &autofs_root_operations;
>          root_inode->i_op = &autofs_dir_inode_operations;
> in there as well.
>
> Incidentally, why bother with separate fail_dput thing?  Shove it
> into ->s_root and return ret - autofs_kill_sb() will take care
> of dropping it...
>
> How about the following:

Yes, I think so, AFAICS so far it looks like everything is covered.

I'll look around a bit longer, I need to go over that mount API code

again anyway ...


I'll prepare a patch, the main thing that I was concerned about was

whether the cause really was NULL root_inode but Edward more or less

tested that.


Ian

> static int autofs_fill_super(struct super_block *s, struct fs_context *fc)
> {
> 	struct autofs_fs_context *ctx = fc->fs_private;
> 	struct autofs_sb_info *sbi = s->s_fs_info;
> 	struct inode *root_inode;
> 	struct autofs_info *ino;
>
> 	pr_debug("starting up, sbi = %p\n", sbi);
>
> 	sbi->sb = s;
> 	s->s_blocksize = 1024;
> 	s->s_blocksize_bits = 10;
> 	s->s_magic = AUTOFS_SUPER_MAGIC;
> 	s->s_op = &autofs_sops;
> 	s->s_d_op = &autofs_dentry_operations;
> 	s->s_time_gran = 1;
>
> 	/*
> 	 * Get the root inode and dentry, but defer checking for errors.
> 	 */
> 	ino = autofs_new_ino(sbi);
> 	if (!ino)
> 		return -ENOMEM;
>
> 	root_inode = autofs_get_inode(s, S_IFDIR | 0755);
> 	if (root_inode) {
> 		root_inode->i_uid = ctx->uid;
> 		root_inode->i_gid = ctx->gid;
> 		root_inode->i_fop = &autofs_root_operations;
> 		root_inode->i_op = &autofs_dir_inode_operations;
> 	}
> 	s->s_root = d_make_root(root_inode);
> 	if (unlikely(!s->s_root)) {
> 		autofs_free_ino(ino);
> 		return -ENOMEM;
> 	}
> 	s->s_root->d_fsdata = ino;
>
> 	if (ctx->pgrp_set) {
> 		sbi->oz_pgrp = find_get_pid(ctx->pgrp);
> 		if (!sbi->oz_pgrp) {
> 			int ret = invalf(fc, "Could not find process group %d",
> 				     ctx->pgrp);
> 			return ret;
> 		}
> 	} else {
> 		sbi->oz_pgrp = get_task_pid(current, PIDTYPE_PGID);
> 	}
>
> 	if (autofs_type_trigger(sbi->type))
> 		managed_dentry_set_managed(s->s_root);
>
> 	pr_debug("pipe fd = %d, pgrp = %u\n",
> 		 sbi->pipefd, pid_nr(sbi->oz_pgrp));
>
> 	sbi->flags &= ~AUTOFS_SBI_CATATONIC;
> 	return 0;
> }
>
> No gotos, no labels to keep track of...

