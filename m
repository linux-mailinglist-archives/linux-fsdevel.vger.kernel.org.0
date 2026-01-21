Return-Path: <linux-fsdevel+bounces-74877-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SAn+Hh8ZcWmodQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74877-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 19:21:19 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D765B325
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 19:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 90FEE7CAE59
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 15:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 554EE47CC63;
	Wed, 21 Jan 2026 15:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CKh7gnHZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9A1478E45
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jan 2026 15:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769010852; cv=none; b=orZjHyWVEg81xituQ/WazZ2bAidRIlNu6fQDzyMNcoAKXHbDM0Mc2Wa8Tvv7bciM2JAtP56c0VAyblYR+yxC4D7xCkOw4zw/pPKCOUVVGJmEk8Sy2EAOVfoX72yMWuteLS0CvZgjEitHrxmJjOMdSHuIXpN6fn9K6TE89BYFLIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769010852; c=relaxed/simple;
	bh=YHIVmzsUwXYFRNT8PxJqLUDcsjT4fcomkaFdrmmVUOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LKv/LmFiQI1qLZVtkVGb4AZI5+UM1GJTGp5yLPCH8IPcAxdSHXxk7bZQw82YhPxkfO5rsRadv3YqonDtwm/nLiOs1jIgLTshge7LjBgfKiQzo/zvJNuOhnW3R5dPZfYkxApZ9cN8pgcvyhZYiM2NaI1kQWZ83nRxY/se7GVrVkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CKh7gnHZ; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-4042f55de3aso663733fac.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jan 2026 07:54:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769010849; x=1769615649; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vBuHUIxWMnLe6s7TwsvCGhfWapOm3oLq0HDTyptAlGo=;
        b=CKh7gnHZGVZKQv8D23HVLbRstU0Ao6rc9TYSif9ODKThLw0C8FyoSRugvSGgG2IrB4
         5UNwacMhyPJRwvab5WQnp5pqS3FongWUB/OwoR0nsmfgnMXoStumm9Q/3xYQgNlCorok
         xw7ekPGAEfzogA6cAI5Qd/75ZUo6RmFdEf4MhM1CqJ6BPrkDm5IgvJjZ0JSHYQOX/sQA
         KToazpjWZgb2rhUYTqaPsYd1enFMyGW4DrMlBJZufJY6wQrdTfscTWE2tbOcyo0jSpLE
         34z9rQwy87inBjoi/f0s3UFIpwgkgwTqA2rgxsmrDHVxwTimcAxZRSvwmOaqUCNTD+mP
         3hnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769010849; x=1769615649;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vBuHUIxWMnLe6s7TwsvCGhfWapOm3oLq0HDTyptAlGo=;
        b=ctVYB4+GugaP72KeoyTC7Qqn54xXL7ZxtpMNmqZG5Fk6uRhk+3xUJOIJNBP44Cv+Uf
         gNB2ADS3lhBQXLaOlQYBC1aRDGsvnwSJ/+rNXbiGfzK4/f9lOJ6E+6xwA79ypFQ1wTv6
         n6S3Qbp0mcIlQDnbC4Rurbzu12pCYjn2ezWhfHd0YBV5Rz/HYjtlbEJKIyBwadFtMbrl
         4WNJkE7tJa7sLuc0PIEUScagTCV6Cjs6mI57uu1Kkwl2vaEwBbACGTc8iHgXMuVVvxaK
         fAIJlF8s48LytZcxyBvagCHMyroHk7z7LJuoPmVsOxcqt1ZFiE17HQWlH4+xPn/v/shI
         5eAg==
X-Forwarded-Encrypted: i=1; AJvYcCWNEsQ62AmZm1noDOBHJW5GEReByIdH6ioFd5W7M9yoiaQrFdCQr2Y14PAx8Q35bmGNnASrfzAuO7AZUeXH@vger.kernel.org
X-Gm-Message-State: AOJu0YwYkO5fFsdK9uN4PjtPrAcxJaI5fmar8Eo3pETz4JThW79waUyS
	VQtQIMcmBhNg8pcY29kqcZmixKTJfPsy+J/Tl0ZgpIf/vMhy8lZCA4BYg4BFAE9/
X-Gm-Gg: AZuq6aK7YmJr5XvOmBrv5Bh2k86H/0YtMeixPlJIFRpvFijhqDac4TWhSdcK+CFroEy
	0smx/kAJ6xBc0Lov7LDkT32jrHvzThDCsydWml1u4HMs9Rz+2ukhHbeM+ZEg9lHREyTPRHUaJPx
	gdFOIPWGpE8oAOG9fmUo7acpCAvefxSqoWd2iyH2oU6U94JoLDMRAHDbBeyf9xEXwZnfu3C/fGH
	kuRR6gTj7bFUl6xlT+16NSqNNEJ+276RG9npoc8DIFbvkJMRP4C/mJ16nLKcbLP5kt1X1dhPkVf
	FN/tARNj5ktFp4qPHPpEEDhPXHTMqJpvOFI1QHMb8WHe8xywW4EIU4Jk+zIDd3/IGtcnfhjLPEt
	Dlf486+8n2iI5w3uhezHdLCHwb4Pt6wRrYAyrebHNH095Zcs0FaELs75giNmXUUvHLUeR+213GB
	QpL/4NzjvHSjB7/lYwk9WV1yJ/8cHMlivZBtHylXndDE4HUdcYmBbdgx4cEcHwUx3CNCoyEZY+8
	1P3wPBCmTIG7GY=
X-Received: by 2002:a05:6214:21ef:b0:87c:19af:4b76 with SMTP id 6a1803df08f44-89398144853mr314752936d6.17.1769004274227;
        Wed, 21 Jan 2026 06:04:34 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8942e6d8a94sm124931226d6.56.2026.01.21.06.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 06:04:33 -0800 (PST)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 82E98F4006D;
	Wed, 21 Jan 2026 09:04:31 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 21 Jan 2026 09:04:31 -0500
X-ME-Sender: <xms:79xwaRPgS8h0JnF8HDazDYFECjiK0XRf_br3BZs2plL4fMjDAe722Q>
    <xme:79xwaY1R9fsjITBQ4yKxSWOJU3sP5x_pIHLOyR7_TbiehKPP2R_EqaVSuweruAo4k
    eaLFD_gv1cDSAb28i6hpJyT-SMrIX3LLsRJuMe-AYXeWe0Oy8PO3Q>
X-ME-Received: <xmr:79xwaY2vAFacNlU5ffdaLISbe6CBRMyv8522yQ8kaXcNVrqe9RXlb3h6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeefgeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpefhtedvgfdtueekvdekieetieetjeeihedvteehuddujedvkedtkeefgedvvdeh
    tdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgv
    rhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfh
    gvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthho
    pedvtddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghlihgtvghrhihhlhesgh
    hoohhglhgvrdgtohhmpdhrtghpthhtohepvghlvhgvrhesghhoohhglhgvrdgtohhmpdhr
    tghpthhtohepghgrrhihsehgrghrhihguhhordhnvghtpdhrtghpthhtoheplhhinhhugi
    dqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhushht
    qdhfohhrqdhlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplh
    hinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehkrghsrghnqdguvghvsehgohhoghhlvghgrhhouhhpshdrtghomhdprhgtphhtthhope
    ifihhllheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvthgvrhiisehinhhfrhgr
    uggvrggurdhorhhg
X-ME-Proxy: <xmx:79xwae-7AjQM7cRhrID17z6Ip7K1eCj6XX0BcbwSoxR7SPnuwnSQmg>
    <xmx:79xwacalaiU0QPeoC1XhJN7CzYPqHVgjh_4cloRVJjbl_SZf2a1WGg>
    <xmx:79xwaVxjU5nPqxd_mcPpASdcQ9Jeq9x06toUhHgGaDVEK_wxZroVPQ>
    <xmx:79xwaS-vARAtWkjKWHBijayn1MXGlO2wWdH4VjAucuXb14OOmzvCBQ>
    <xmx:79xwaZxny1W8998ySnA5TLfT8cQGMeb3X_G-z8hLwsB6H5O6XZsesuNN>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Jan 2026 09:04:30 -0500 (EST)
Date: Wed, 21 Jan 2026 22:04:28 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Marco Elver <elver@google.com>, Gary Guo <gary@garyguo.net>,
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
Message-ID: <aXDc7KYgkD7g4HVd@tardis-2.local>
References: <20260120115207.55318-1-boqun.feng@gmail.com>
 <20260120115207.55318-3-boqun.feng@gmail.com>
 <aW-sGiEQg1mP6hHF@elver.google.com>
 <DFTKIA3DYRAV.18HDP8UCNC8NM@garyguo.net>
 <aXDEOeqGkDNc-rlT@google.com>
 <CANpmjNMq_oqvOmO9F2f-v3FTr6p0EwENo70ppvKLXDjgPbR22g@mail.gmail.com>
 <aXDL5NUOH_qr390Q@tardis-2.local>
 <aXDPliPQs8jU_wfz@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXDPliPQs8jU_wfz@google.com>
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
	TAGGED_FROM(0.00)[bounces-74877-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	DKIM_TRACE(0.00)[gmail.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,tardis-2.local:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[boqunfeng@gmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 49D765B325
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Jan 21, 2026 at 01:07:34PM +0000, Alice Ryhl wrote:
> On Wed, Jan 21, 2026 at 08:51:48PM +0800, Boqun Feng wrote:
> > On Wed, Jan 21, 2026 at 01:36:04PM +0100, Marco Elver wrote:
> > [..]
[...]
> > 
> > Note that it also applies to atomic_read() and atomic_set() as well.
> 
> Just to be completely clear ... am I to understand this that READ_ONCE()
> and the LKMM's atomic_load() *are* the exact same thing? Because if so,
> then this was really confusing:
> 
> > my argument was not about naming, it's
> > about READ_ONCE() being more powerful than atomic load (no, not because
> > of address dependency, they are the same on that, it's because of the
> > behaviors of them regarding a current access on the same memory
> > location)
> > https://lore.kernel.org/all/aWuV858wU3MeYeaX@tardis-2.local/
> 
> Are they the *exact* same thing or not? Do you mean that they are the
> same under LKMM, but different under some other context?

Right, they are the same thing under LKMM when used for inter-thread
synchronization when they are atomic. But when READ_ONCE() (and
__READ_ONCE()) used on types that are larger than machine word size,
they are not guaranteed to be atomic, hence semantics-wise READ_ONCE()
firstly guarantees "once" (volatile and no data race with WRITE_ONCE())
and then on certain types, it's atomic as well.

* In the case that we need atomicity, we should just use atomic_load().
* In the case that we don't need atomicity and no data race, we can just
  use read_volatile().
* In the case that there is a non-atomic concurrent write, that suggests
  we have a bug in C code or we simply should have some other
  synchronization. Or if we believe the conncurrent write has at last
  per-byte atomicity, then we can have `READ_ONCE()`-like function that
  returns a `MaybeUninit` to bear the possible tearing.

Regards,
Boqun

> 
> Alice

