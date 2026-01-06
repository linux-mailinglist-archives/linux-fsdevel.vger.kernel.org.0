Return-Path: <linux-fsdevel+bounces-72507-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7DECF8D21
	for <lists+linux-fsdevel@lfdr.de>; Tue, 06 Jan 2026 15:40:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 63EF930970B3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jan 2026 14:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB4A93128AD;
	Tue,  6 Jan 2026 14:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NPjDBhnJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4B6312832
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Jan 2026 14:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767710013; cv=none; b=IcFSIOITC1/bOt1KoVxktjlbFXX+AOFkM8RGJeN7WGGbzqzbensBrUQAVkD51O1a1lt3v7j1DYhYg4wdLlEEc0lAyOaBF1ePAl/hfR9Q9o/Agrv89x1I/G9S22OPfKGIxGdllezKty5C3ivMIlQrngSmd6/ADM6Z2qgpprvNA9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767710013; c=relaxed/simple;
	bh=5awYPo9NRWSLRCDApAgIhPhlaNoMqw/wWzDsCNCKgag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IQ9SegmwoD78gjDVPaOv9+A/Kl6mG0G3mrKLUIO/EfVkrAuLHAzhFuY0w90LjTHfIhCYQACrAjlCaVGj8+MIgidcZ3u2bUnGQohAHk4aL6A8i1fy0HVNlNnA7HeKxI/ZFpVpZc/R+tSeqy4aJiClSP28ZBEijtoYyiWsZbgMIsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NPjDBhnJ; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4fc42188805so9684831cf.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Jan 2026 06:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767710010; x=1768314810; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jp2FJp4mip9k/yNPjJbmpok2wWGuJgO5Pl2nOe2MRoU=;
        b=NPjDBhnJbF7YbUnSTXW1s+xTnwn1Tp6DufSFi0OhXq6rg67j57FRXaKQRzi4lfnuR9
         dc0kLw76+F/uGfIBaCUGegXqqgT1xZqJpjg1KXRuGAu08aMZGGDLDK+FQk8+9+yFKkyL
         BU23OiXaNr6fVXPm1+ifsJp17YF+7xUX0DX+lUzr9VnG5RgWD9Br3xOKpqcTn+om31PE
         vGkqs7AQxJXRvieeVxtjLV6lat5Qw7eUNPuMyHyn71kp3NzttrFfbQX5x/YYkPSWagtu
         2wzNdL7Vdhp1AlJ5Xpdmkbi33AA/KyHB5yYnZpG2jN+2qgee+H1mFtwziE5ijxkKfmdD
         TMUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767710010; x=1768314810;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Jp2FJp4mip9k/yNPjJbmpok2wWGuJgO5Pl2nOe2MRoU=;
        b=ewcutvG+92zOhblWLqd4neVVyJYxXeLwydhx0/hCDLPWZpXkikRrL7MsUyBskyPatt
         Xtf6LtWp/djtM05NU4V+8s9Mg1M2AsRcujXO6/lPapS0cQZFMH71sFgeK1TM+Q1ki3hg
         tAX9iyA/iDF0J8/13BdIJKc5vu5uOiz3kHG1if2Sw+Gat4RWmE4tayUcx5FhE9L6kGSt
         CfIm3cJ0Kp3Tv0dNCn2DE3TRmbR6hoAKpyQtPiLdlfwwM3CbJ7nglJ0WwJybl7CmmcSr
         BwiCPF8x/kBEMIiSJdlZhrD2Ip10PWej2MYjjOYpSfHUZdW/TGIKUAy4jTaJ9x99s9nr
         GlFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJQJ7dxv9aEb2phvVHspxG+SaLPnWaZaeZUvRvPnHiqqe9Uhah5wBwZZCigXO9jG9PA7lDXWIsNTOj47ba@vger.kernel.org
X-Gm-Message-State: AOJu0YwBUnxloqhG1HSM8wG+61qYgJP7r8iuMiCTbqhIts1L6lje6vYR
	X1PrrHVCvBkcffkv2Dx3x6RH/esuyfkx9N+lWy6Airw6iuxSAGw8gX9c+zyxmywX
X-Gm-Gg: AY/fxX5H8c2aeHHipaAn+wxR9Or5ioOoGblwdnz8/dDvIB5hzB0mWD9VK2mJA71UYKF
	CMCG0T+ZPFKwiwpzHGm3pPr+H5gIWb9/i82IU3Ye7GCqor+lAnSrmsXjORcdMr0oXsBq4bbMfn/
	+es7N/znqri6cZdcerv5R1TcgosDcilQ/cykFTJNLVAolWnVdUC3gKhc0waP/iM0JHRo67/ymER
	07lPe7S0GmeIirLet7ymVnDhzO0larZrYMsECfaHFbv8xcCMA6BgZYr/xpwVT0dVsDZc3D0MrHE
	HKP+bqPTD6ajO+PTFsB3rdrHhgtzP5Siodf34lPmEn2XdhlNnhUlXBCwWYbiyFV0q3+a+bUJKus
	YKb8ydqtYSL8kvu5QqJ4+k9qVuPZJ/buRVf+uoBUyP1vi3TfNoPQ/4n/Zg4+zAu0xRT2MQFtxi9
	I4FZ96o1jVtuXoKkHYk1vfPYu1lIpeQepVpZZAimiaziUpF1etrtltPqmF6AkvVmsxONj/uhnQk
	bTYP5IZf/ll3e9PeuLR6iDYtw==
X-Google-Smtp-Source: AGHT+IG5y3ihX/nTQRrfdnHMzNLd9H06QzeACVIIpJzxoRgRUvLgvocrP0wK6dPyXld6Qki9Sw/yPg==
X-Received: by 2002:a05:620a:288c:b0:8ba:3d82:de2d with SMTP id af79cd13be357-8c37eba72a1mr370948885a.67.1767704008339;
        Tue, 06 Jan 2026 04:53:28 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c37f4b917dsm164759585a.17.2026.01.06.04.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 04:53:27 -0800 (PST)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 1A164F4006A;
	Tue,  6 Jan 2026 07:53:27 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 06 Jan 2026 07:53:27 -0500
X-ME-Sender: <xms:xwVdaeSwbODV7JqbJ70h7aGUkLI7HOUIqGtt0UjiY610MF7ckv8YEg>
    <xme:xwVdaTtqxf6X0AeSmMq2jiMUHiapXLUuSuZyJ5C68VWdlE2GQRJ4aEWMigN514O-Z
    BWYgOWPHY2GeXQDqo442If5_P2j_xb-eKTigT9gEv78i-Ij-tjV0A>
X-ME-Received: <xmr:xwVdaXZb5P9ZpRNJkzh2SnpqGPacj89O-78H8b7BMQL9JrV7xyey9juS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutddtvdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueevieduffei
    vdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
    hquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedq
    udejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmh
    gvrdhnrghmvgdpnhgspghrtghpthhtohepfedupdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopegrrdhhihhnuggsohhrgheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprg
    hlihgtvghrhihhlhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepfihilhhlsehkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvggrugdrohhrgh
    dprhgtphhtthhopehrihgthhgrrhgurdhhvghnuggvrhhsohhnsehlihhnrghrohdrohhr
    ghdprhgtphhtthhopehmrghtthhsthekkeesghhmrghilhdrtghomhdprhgtphhtthhope
    hlihhnmhgrghejsehgmhgrihhlrdgtohhmpdhrtghpthhtoheptggrthgrlhhinhdrmhgr
    rhhinhgrshesrghrmhdrtghomhdprhgtphhtthhopehojhgvuggrsehkvghrnhgvlhdroh
    hrgh
X-ME-Proxy: <xmx:xwVdae9J9x8NVgALl-fYcI0QyRYoJ8m4It2cassa207a7v4AO5AS5w>
    <xmx:xwVdaRDZBNB3WNQx4PzUXkrUELWrCDwMSb-w1jqBFkK0Cfzgn4_t8w>
    <xmx:xwVdaSspqARYw-uR9irVFm2eOEvEv4sQoz9Uj2_d1Kyqx7WVrftBdw>
    <xmx:xwVdaTY_Z8cWkR_hhc-sOC9FlhMGZEOlJUBtP3nKJNhE-HvXSTqXtA>
    <xmx:xwVdaQ2LGWFdzBBPz915RcVkKGU6vZncXMNXyt0GIVzyJMw7Lo_LJt7k>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Jan 2026 07:53:26 -0500 (EST)
Date: Tue, 6 Jan 2026 20:53:24 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>, Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>,	Magnus Lindholm <linmag7@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,	Mark Rutland <mark.rutland@arm.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,	Lyude Paul <lyude@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,	rust-for-linux@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/5] rust: sync: add READ_ONCE and WRITE_ONCE
Message-ID: <aV0FxCRzXFrNLZik@tardis-2.local>
References: <20251231-rwonce-v1-0-702a10b85278@google.com>
 <AaMhgQBVJNQ-lfS70C2wyfbsXmJnxoK2QB0Qn6z77hc-gErX1ZpvLzFO-EJrFXKRQml2Qfqe87TLzFwYybVb1g==@protonmail.internalid>
 <20251231-rwonce-v1-2-702a10b85278@google.com>
 <87ldiaj560.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ldiaj560.fsf@t14s.mail-host-address-is-not-set>

On Tue, Jan 06, 2026 at 01:29:11PM +0100, Andreas Hindborg wrote:
> "Alice Ryhl" <aliceryhl@google.com> writes:
> 
> > There are currently a few places in the kernel where we use volatile
> > reads when we really should be using `READ_ONCE`. To make it possible to
> > replace these with proper `READ_ONCE` calls, introduce a Rust version of
> > `READ_ONCE`.
> >
> > I've written the code to use Rust's volatile ops directly when possible.
> > This results in a small amount of code duplication, but I think it makes
> > sense for READ_ONCE and WRITE_ONCE to be implemented in pure Rust when
> > possible. Otherwise they would unconditionally be a function call unless
> > you have a system where you can perform cross-language inlining.
> >
> > I considered these functions in the bindings crate instead of kernel
> > crate. I actually think it would make a lot of sense. But it implies
> > some annoying complications on old compilers since the #![feature()]
> > invocations in kernel/lib.rs do not apply in the bindings crate.
> >
> > For now, we do not support using READ_ONCE on compound types even if
> > they have the right size. This can be added later.
> >
> > This fails checkpatch due to a misordered MAINTAINERS entry, but this is
> > a pre-existing problem.
> >
> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> > ---
> >  MAINTAINERS                |   2 +
> >  rust/helpers/helpers.c     |   1 +
> >  rust/helpers/rwonce.c      |  34 ++++++++
> >  rust/kernel/sync.rs        |   2 +
> >  rust/kernel/sync/rwonce.rs | 188 +++++++++++++++++++++++++++++++++++++++++++++
> >  5 files changed, 227 insertions(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 12f49de7fe036c2439c00f9f4c67b2219d72a4c3..1d0cae158fe2cc7d99b6a64c11176b635e2d14e4 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -4117,9 +4117,11 @@ F:	arch/*/include/asm/atomic*.h
> >  F:	include/*/atomic*.h
> >  F:	include/linux/refcount.h
> >  F:	scripts/atomic/
> > +F:	rust/helpers/rwonce.c
> >  F:	rust/kernel/sync/atomic.rs
> >  F:	rust/kernel/sync/atomic/
> >  F:	rust/kernel/sync/refcount.rs
> > +F:	rust/kernel/sync/rwonce.rs
> >
> >  ATTO EXPRESSSAS SAS/SATA RAID SCSI DRIVER
> >  M:	Bradley Grove <linuxdrivers@attotech.com>
> > diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
> > index 79c72762ad9c4b473971e6210c9577860d2e2b08..28b79ca7844fb744e5ad128238824921c055ec82 100644
> > --- a/rust/helpers/helpers.c
> > +++ b/rust/helpers/helpers.c
> > @@ -48,6 +48,7 @@
> >  #include "rcu.c"
> >  #include "refcount.c"
> >  #include "regulator.c"
> > +#include "rwonce.c"
> >  #include "scatterlist.c"
> >  #include "security.c"
> >  #include "signal.c"
> > diff --git a/rust/helpers/rwonce.c b/rust/helpers/rwonce.c
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..55c621678cd632e728cb925b6a4a2e34e2fc4884
> > --- /dev/null
> > +++ b/rust/helpers/rwonce.c
> > @@ -0,0 +1,34 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +/*
> > + * Copyright (C) 2025 Google LLC.
> > + */
> > +
> > +#ifdef CONFIG_ARCH_USE_CUSTOM_READ_ONCE
> > +
> > +__rust_helper u8 rust_helper_read_once_1(const u8 *ptr)
> > +{
> > +	return READ_ONCE(*ptr);
> > +}
> > +
> > +__rust_helper u16 rust_helper_read_once_2(const u16 *ptr)
> > +{
> > +	return READ_ONCE(*ptr);
> > +}
> > +
> > +__rust_helper u32 rust_helper_read_once_4(const u32 *ptr)
> > +{
> > +	return READ_ONCE(*ptr);
> > +}
> > +
> > +__rust_helper u64 rust_helper_read_once_8(const u64 *ptr)
> > +{
> > +	return READ_ONCE(*ptr);
> > +}
> > +
> > +__rust_helper void *rust_helper_read_once_ptr(void * const *ptr)
> > +{
> > +	return READ_ONCE(*ptr);
> > +}
> > +
> > +#endif
> > diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
> > index 5df87e2bd212e192b8a67644bd99f05b9d4afd75..a5bf7bdc3fa8a044786eafae39fe8844aeeef057 100644
> > --- a/rust/kernel/sync.rs
> > +++ b/rust/kernel/sync.rs
> > @@ -20,6 +20,7 @@
> >  pub mod poll;
> >  pub mod rcu;
> >  mod refcount;
> > +pub mod rwonce;
> >  mod set_once;
> >
> >  pub use arc::{Arc, ArcBorrow, UniqueArc};
> > @@ -30,6 +31,7 @@
> >  pub use lock::spinlock::{new_spinlock, SpinLock, SpinLockGuard};
> >  pub use locked_by::LockedBy;
> >  pub use refcount::Refcount;
> > +pub use rwonce::{READ_ONCE, WRITE_ONCE};
> >  pub use set_once::SetOnce;
> >
> >  /// Represents a lockdep class. It's a wrapper around C's `lock_class_key`.
> > diff --git a/rust/kernel/sync/rwonce.rs b/rust/kernel/sync/rwonce.rs
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..a1660e43c9ef94011812d1816713cf031a73de1d
> > --- /dev/null
> > +++ b/rust/kernel/sync/rwonce.rs
> > @@ -0,0 +1,188 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +// Copyright (C) 2025 Google LLC.
> > +
> > +//! Rust version of the raw `READ_ONCE`/`WRITE_ONCE` functions.
> > +//!
> > +//! C header: [`include/asm-generic/rwonce.h`](srctree/include/asm-generic/rwonce.h)
> > +
> > +/// Read the pointer once.
> > +///
> > +/// # Safety
> > +///
> > +/// It must be safe to `READ_ONCE` the `ptr` with this type.
> > +#[inline(always)]
> > +#[must_use]
> > +#[track_caller]
> > +#[expect(non_snake_case)]
> 
> I really do not think we need to have screaming snake case here. I
> understand that this is what the macro looks like in C code, but we do
> not need to carry that over.
> 

We should really do a atomic_load and atomic_store (implemented by
Atomic::from_ptr()) to those usages:

    unsafe atomic_load<T: AtomicType, O: AcquireOrRelaxed>(ptr: *mut T, ordering: O) -> T {
        Atomic::from_ptr(ptr).load(ordering)
    }

    unsafe atomic_store<T: AtomicType, O: AcquireOrRelaxed>(ptr: *mut T, v: T, ordering: O) {
        Atomic::from_ptr(ptr).store(v, ordering);
    }

This unifies the underlying implementation and clarify the atomicity of
these operations.

Regards,
Boqun

> 
> Best regards,
> Andreas Hindborg
> 

