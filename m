Return-Path: <linux-fsdevel+bounces-15105-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28442886FD6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 16:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC8FF1F22275
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 15:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3631524C4;
	Fri, 22 Mar 2024 15:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="BmrvXjEn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Dv6sth6y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E771843AAB;
	Fri, 22 Mar 2024 15:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711121543; cv=none; b=kuBKLMb2h51FxiEcUBLlunZAfzeYZcEI+ehRCkH/s2yZQDuSIR+e1rBfd3C2lGZay2NpQnkClpsntqk2pMb0L9EmG7g9fNeUkKV2lwucp9ehQ9NhruU0yP7gfAVnoSx0N3fbea40KspIcDxSkJtwT3/jXodv763NEXzntOHAkTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711121543; c=relaxed/simple;
	bh=9TNkZT4dp7ID5qIMMJen1ZJY1/o2ksRE529bNt185EA=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=rRUvFmR6O3olArq1lzd0+ZEYFtfhazuxV3wMsvgIqezhngYSseei/8wMjGlvKy0XSGFodNwKm6TxG4clBkpg2ImxFbf6guTy1FEkCf4+L7G6JaOBGhy8n38tGpG/cT46AtBRhW/G9SXMPcT0xevR/0domB3Usrd9rtgps3tLz+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=BmrvXjEn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Dv6sth6y; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id D48CB13800DA;
	Fri, 22 Mar 2024 11:32:19 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Fri, 22 Mar 2024 11:32:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1711121539;
	 x=1711207939; bh=X5fVNcRghc6AmkKQ9qMZefGfp8+ukNErti+4NvQOZ1Y=; b=
	BmrvXjEnEFVMR3k6MqJ2rgDbQlgfH3eW5ie+E+r3kuCsJ11bOrVMye3+kRX1X2rB
	baw3mMc0mHhASY/2EwRDl1hqFJzvs6vxqug0cNU6chAXGZjI5lSXAp5mIpqkTHef
	Z/T5lSjMSF1rPw4MFvw+54yl/9kx4wgPWqDKGezjkr775cthi7rGv+/5CTSMvEoF
	utd+/KSJMNOIKkX3et29hbV0kWgbej1M8T2DhDkbzRR/9nVrlpdOt1iihoLcET5L
	ZmEj9+9+0xz1SOPZxOl2VuQDRT8lhdKaT9qNrJqJRRHE6AGhq5evXjPMb7u217lQ
	QAkMiqZ0p2WeTUmGux5CiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1711121539; x=
	1711207939; bh=X5fVNcRghc6AmkKQ9qMZefGfp8+ukNErti+4NvQOZ1Y=; b=D
	v6sth6yHmlD5Y4Q4ET3Pyv47BM9BHCMEQh6XIXFwH1kCcIXHsEZJdv7YE0zIRSCY
	yv39RCGyRsuZxcKaSzg6WV03hyps0jLLCJL4xBaSU69M/4nf5bW/r2qdnV7x4nz7
	PiyOY3bsRP+Qn6pJDOpSISk2NjCndWN/Nv452YLP49Y4ZqAnUvAIVGDbM57FBDvr
	04MH7QSt9wYkm1TiwxIzGwoIikbrlRkX18dFObAgNfZKG1E3Y03GE7RBEjL1VpDo
	WrfXjtTT196mNdOzp23r+HQSUE4acnoPz3LAjjxp3/dxmVNdF1P4cKZ4P4KbI/iX
	AI7itHaaPK/NKR3atChjg==
X-ME-Sender: <xms:g6T9ZWye7lPHt9eg9xvJlvYdk-_x9MkASRaUiqzgPeH45fCwiFoy3Q>
    <xme:g6T9ZSSYdBofd27fn1WZ7BDd59XJV1b26w5wtalIkLcBW386GjsVyq_wl1BX-gjrj
    7jMQsnIewZv5AjINFs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddtvddgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:g6T9ZYV35XQP0-g4G14IHfr93oAXUQ9vIXgTpXeOU_suK-AWnC7MIQ>
    <xmx:g6T9ZcjNlLgGx3GpcOqouPBNoX2Edi2E6SHwam0gg2kju9BBfnXL3A>
    <xmx:g6T9ZYAS4ah1OxZqia_GuWors-RFIo1cdU3XNqnhbPCHrk5dgFl9xQ>
    <xmx:g6T9ZdJ8Wq2Z67owMJY5aFtiOuV_MKz0ESv3j0zzqs67cLT5NzB2mQ>
    <xmx:g6T9ZU7_a_JXT7OxQpKqFYnPjk7USqoXrRxRdTZz1hWUUst3HmIOMw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 1C9C6B6008D; Fri, 22 Mar 2024 11:32:19 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-332-gdeb4194079-fm-20240319.002-gdeb41940
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <32b1164e-9d5f-40c0-9a4e-001b2c9b822f@app.fastmail.com>
In-Reply-To: <20240322151002.3653639-2-gnoack@google.com>
References: <20240322151002.3653639-1-gnoack@google.com>
 <20240322151002.3653639-2-gnoack@google.com>
Date: Fri, 22 Mar 2024 16:31:58 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 linux-security-module@vger.kernel.org,
 =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: "Jeff Xu" <jeffxu@google.com>,
 "Jorge Lucangeli Obes" <jorgelo@chromium.org>,
 "Allen Webb" <allenwebb@google.com>, "Dmitry Torokhov" <dtor@google.com>,
 "Paul Moore" <paul@paul-moore.com>,
 "Konstantin Meskhidze" <konstantin.meskhidze@huawei.com>,
 "Matt Bobrowski" <repnop@google.com>, linux-fsdevel@vger.kernel.org,
 "Christian Brauner" <brauner@kernel.org>
Subject: Re: [PATCH v11 1/9] fs: Add and use vfs_get_ioctl_handler()
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024, at 16:09, G=C3=BCnther Noack wrote:
> From: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
>
> Add a new vfs_get_ioctl_handler() helper to identify if an IOCTL comma=
nd
> is handled by the first IOCTL layer.  Each IOCTL command is now handled
> by a dedicated function, and all of them use the same signature.

Sorry I didn't already reply the previous time you sent this.
I don't really like the idea of going through another indirect
pointer for each of the ioctls here, both because of the
complexity at the source level, and the potential cost on
architectures that need heavy barriers around indirect
function calls.
=20
> -static int ioctl_fibmap(struct file *filp, int __user *p)
> +static int ioctl_fibmap(struct file *filp, unsigned int fd, unsigned=20
> long arg)
>  {
> +	int __user *p =3D (void __user *)arg;

The new version doesn't seem like an improvement when you
need the extra type casts here.=20

As a completely different approach, would it perhaps be
sufficient to define security_file_ioctl_compat() in a
way that it may return a special error code signifying
"don't call into fops->{unlocked,compat}_ioctl"?

This way landlock could trivially allow ioctls on e.g.
normal file systems, sockets and block devices but prevent
them on character devices it does not trust.

      Arnd

