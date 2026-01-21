Return-Path: <linux-fsdevel+bounces-74853-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EAsWC3DOcGkOaAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74853-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 14:02:40 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E1425747D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 14:02:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 079D0A03DF2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 12:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E45348BD36;
	Wed, 21 Jan 2026 12:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dzohWtPN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D083B8BCE
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jan 2026 12:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768999916; cv=none; b=BLCo0QpgwuP0oy8iF8QVdeeM5/UQffsX0zX51JiFdF2YhwVk+0O2NyfM4HufRcXQjXwEVdfJ/FAH+8l8YV6JKiYcZryCO0+x/Rn7Kfv1MAXTdaMq1yH4keeZu9dNubdDkGetJ+VUHSNsJ4mReZbQSIdBognhNj9LzgDqXJHyViM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768999916; c=relaxed/simple;
	bh=rCJVN3mlY/He+ltCptalObxFFliAQg62cnToC5h9nm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YR6VFNizdPc4GdFgkCkiU75gAfWMoBJ2qE8ihozHcAy8fi3mPduV8USTbI/tG31BZVmoDJxA7737M9Cm9bP9pRTb4ylJlrXb1o/Moz8zIMzETN8joyf/dFPe/6c4yBA5iarmWwLHQF+15blsFYhYzqz2uDl9KK3EoAKy6qLdHZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dzohWtPN; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8c655e0ee70so689120985a.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jan 2026 04:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768999914; x=1769604714; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ff1eounqvwFWz5fvkxu9F0ExQjANboKm57xpRsw3Ti0=;
        b=dzohWtPNJPGs5Ql2vW5x94bHwtVSlSweONpyQYd3FJ7/4fe0I35ixpp865jqSEyifK
         SzNQvpR6XUcub7W2cUZeeqyCyjh0QUJfpymMlJesOLSYsfZQIEjm9GcMTIIrBXhwWz33
         zYIzLpFmk9Pumk99ALC4//Z1oYQVhs5QyzcmAl0oUXA+j3dgH8tTy9HFk3pAjaaYMqqz
         L7JIJucXuZVvwBYpGON3wxHF/zB3qbO//MUxwqyRhJY23cLe9G8GggiH2elqiTnL7VPd
         noAhyTtaQ6OietXTdS4kiY2sEI07zbZpMCGg388BnkJIXnf3K29m7B+7RVd5RuJXlDdy
         O8eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768999914; x=1769604714;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ff1eounqvwFWz5fvkxu9F0ExQjANboKm57xpRsw3Ti0=;
        b=PzNg9OQxBLGwUHjTVKVvvpsjNXTAaouAfaEujiCAoYodVz8O6hBsBfm2rQCpz+okUr
         IfumTUXcR04zL+f91yF20K7lUpyUCz1xB0oB6D+hlYurkDaO2PjJVJAxXSciE8lTi6us
         i98vWb30L1DwdCCZ6+vRaHYFTx9hXS/2QvS7TyAU698KuAxpASYitxJEMoYA0QcV/qkO
         ctS6WVdxZC2j+xiN+oBmJHcqYorp+9heOHRjzNCJRpAUZpart/eNwNubXy7FIZK+2YHP
         O0RCJax3TVapB+ifRMlW6/Cewtmxm+t51aP/nF1SyRBx3CPcoFVtij05b2rvqCvShq4S
         RcvA==
X-Forwarded-Encrypted: i=1; AJvYcCWWMoJmfLDEGhK6Btp3Edz/07QerHmEdvJ1NeEu9c6ETK1JlQNHrtylYduJw1eRVWlb+cFyNtZRvuKgd2Ux@vger.kernel.org
X-Gm-Message-State: AOJu0YwziggGXwPimA4VF48QNfc58SvypPIJ3LR7I41CVjDrncQ2Ep16
	P3agJs4TXftL24/oFzp5L+ABS1TKABkEvrvK8HkodF5hBKmo1+R/9O6H
X-Gm-Gg: AZuq6aKk6HablAFWdbf6c3wI3PxFtL5utDEIywZdiq6nnfMrPkp+cRg4DhcAyFGt1XM
	gk1/weNZlW+x+dejAaNWdPsR1nBP+Esh5IBuTyHJBtm+LPJ0Lq7ptxFJyw3JKJ5qvFsJGgq/pit
	EIM6jvSGPTDt34yaDMCddKWkoEpwSs0sEB8zrjnkbr3hFVL7JbO/RlXxpYhKAx3fkZImfC8Dc3W
	0/CYvjlndMu0KZ7P4UUwv5B9stM8eYS4lor2CA9F9fZZSe81xKSPsdndx+67VHkijdyGA4sJRO6
	3mAov529yIyFE5DsqGE/SQiX8UfohQvQ8vHqj4y8OArDC4ftV9fvGOX5jISDhsEYcv/nFo2Fwbs
	CGaVbnrR6UPvQOOCVZWpaRQl9mamIfhu/w5Q9IOJq8FEvZnSplXvEhi8+xuqiuFrkKZ+NRnt1dE
	k6OxSjTzzkfD0t60nZhCr42C9yMkhEXnPUSQfQqT4PHE+wgCj2kFXbTTxhVI3Ac2CchA194ZFFI
	GiUOHBAmk3XHiE=
X-Received: by 2002:a05:620a:4720:b0:8c5:310d:3b2a with SMTP id af79cd13be357-8c6ccdbeeb5mr646477385a.19.1768999913732;
        Wed, 21 Jan 2026 04:51:53 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8942e6c9b83sm124581826d6.46.2026.01.21.04.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 04:51:53 -0800 (PST)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id E712CF4006A;
	Wed, 21 Jan 2026 07:51:51 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 21 Jan 2026 07:51:51 -0500
X-ME-Sender: <xms:58twaUGSkaSpbx7JXEZcxEnx57vxUAoduMTdegZwu8a5u5M9Mg5GDQ>
    <xme:58twaSODH4rN0LeVuGC31txCvV3AQMyf8ig2IJvk2hLk-vjtj30YHp05UAGQa1dQS
    OkaXFlxYQ8baIGqrvq8taVpGT6EHGEFNrqf1a-WVwRcwP_f0pryVQ>
X-ME-Received: <xmr:58twaWuQzJC_XwZiqktfROP6_V5V9E36i7JgsETfbmSkp98jrJIAlfDR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeeffedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueevieduffei
    vdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
    hquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedq
    udejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmh
    gvrdhnrghmvgdpnhgspghrtghpthhtohepvddtpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopegvlhhvvghrsehgohhoghhlvgdrtghomhdprhgtphhtthhopegrlhhitggvrh
    ihhhhlsehgohhoghhlvgdrtghomhdprhgtphhtthhopehgrghrhiesghgrrhihghhuohdr
    nhgvthdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehruhhsthdqfhhorhdqlhhinhhugiesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrshgrnhdquggvvhesghhoohhglhgvghhr
    ohhuphhsrdgtohhmpdhrtghpthhtohepfihilhhlsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopehpvghtvghriiesihhnfhhrrgguvggrugdrohhrgh
X-ME-Proxy: <xmx:58twaXXugDnVSIzPc3Z6tmRgJ0gzc-8kpLQlF6EU4_1T359kNr0AvQ>
    <xmx:58twadSMEqXBgc6u8BpISVpCgFbZnNBK-m9n-slSUZr_BmMMRXyQQQ>
    <xmx:58twaVJYT_K8atwdL48TaGRLXMspI_cX4L6NB3oMz9TS27ghfquNNg>
    <xmx:58twae3_JXhGRQsrMvzx9L3rTqWlzKH6-fDOyUi1yXzfXsRfn6I7KQ>
    <xmx:58twaYJ89IAFyCeo86kIWY9aLZFkQt1cwWFbCBN6iPl_iRTb-RzRxx1k>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Jan 2026 07:51:51 -0500 (EST)
Date: Wed, 21 Jan 2026 20:51:48 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Marco Elver <elver@google.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Gary Guo <gary@garyguo.net>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, kasan-dev@googlegroups.com,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Elle Rhumsaa <elle@weathered-steel.dev>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>
Subject: Re: [PATCH 2/2] rust: sync: atomic: Add atomic operation helpers
 over raw pointers
Message-ID: <aXDL5NUOH_qr390Q@tardis-2.local>
References: <20260120115207.55318-1-boqun.feng@gmail.com>
 <20260120115207.55318-3-boqun.feng@gmail.com>
 <aW-sGiEQg1mP6hHF@elver.google.com>
 <DFTKIA3DYRAV.18HDP8UCNC8NM@garyguo.net>
 <aXDEOeqGkDNc-rlT@google.com>
 <CANpmjNMq_oqvOmO9F2f-v3FTr6p0EwENo70ppvKLXDjgPbR22g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNMq_oqvOmO9F2f-v3FTr6p0EwENo70ppvKLXDjgPbR22g@mail.gmail.com>
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[google.com,garyguo.net,vger.kernel.org,googlegroups.com,kernel.org,infradead.org,arm.com,protonmail.com,umich.edu,weathered-steel.dev,gmail.com];
	TAGGED_FROM(0.00)[bounces-74853-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	DKIM_TRACE(0.00)[gmail.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[boqunfeng@gmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 9E1425747D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Jan 21, 2026 at 01:36:04PM +0100, Marco Elver wrote:
[..]
> >
> > > However this will mean that Rust code will have one more ordering than the C
> > > API, so I am keen on knowing how Boqun, Paul, Peter and others think about this.
> >
> > On that point, my suggestion would be to use the standard LKMM naming
> > such as rcu_dereference() or READ_ONCE().

I don't think we should confuse Rust users that `READ_ONCE()` has
dependency orderings but `atomc_load()` doesn't. They are the same on
the aspect. One of the reasons that I don't want to introduce
rcu_dereference() and READ_ONCE() on Rust side is exactly this, they are
the same at LKMM level, so should not be treated differently.

> >
> > I'm told that READ_ONCE() apparently has stronger guarantees than an
> > atomic consume load, but I'm not clear on what they are.
> 
> It's also meant to enforce ordering through control-dependencies, such as:
> 
>    if (READ_ONCE(x)) WRITE_ONCE(y, 1);

Note that it also applies to atomic_read() and atomic_set() as well.

Regards,
Boqun

