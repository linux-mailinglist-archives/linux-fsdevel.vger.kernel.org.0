Return-Path: <linux-fsdevel+bounces-72492-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B504ACF8786
	for <lists+linux-fsdevel@lfdr.de>; Tue, 06 Jan 2026 14:21:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B4CF30B6B76
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jan 2026 13:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4862732F751;
	Tue,  6 Jan 2026 13:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RVe5xUIT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB2E32E13A
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Jan 2026 13:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767704985; cv=none; b=MaeGlkP/7JC6EZal4H84dgWNr+Dfl8uKNOpCvUK4sdjlagAGhKXqgFAj5C04//lAbX6o/Ppru/5ep5X2O7RSfxaamV8T5J2QQiiQxir6fxLEyKkK9qtlzzAVUJEgQwivflYp+fqCIjfLs2H8+xlUfxb26V0kaS1biagRgbObrGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767704985; c=relaxed/simple;
	bh=7vNqbhncbz2ImZAWXhLrEG8jeofeaKSGrO+Rt1M8f0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YSA5ykqqn+pkGu6fk/55EzMp4KOob4dNmI8nfdDM129IlazStx5B7AARXEf3kZMxrf/j8p0XimrBTem8BPutmq6w9wnsNkRgBYXq4xBmwMcBxSYo1gZKNhZ4AdzbTAU0ZTWSxZIhc7lLxTSi4vSrJIpLyeEjaC03iqeBWkX+D+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RVe5xUIT; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8ba0d6c68a8so90453485a.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Jan 2026 05:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767704983; x=1768309783; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JpzahlfiGpAFEOQGjh5jjjaXUgZ9jhcXoloaQUEBJwU=;
        b=RVe5xUITdR78PuScG3gXhIryZDhqamHfCSere5daOlkm3u7xWsadhsSeh4KGP9RP86
         3HRsAdemsSYGZdq15BM+8S+AhguN/z8ioIY/Ca5DKx2lYn2okFiD6PvQQqSNj3ul3byE
         1o32TVcYRePiMSNKlmJA2/OFKhZW1ocSO1K6nAaURXbdDpbfPiybkQVPdSvfNS8vw7IN
         VCivcw5qYqfadvl0h7qZC/7jRiJw2awIa6Pzfigpx2zAkUTkqQvi3ljqncEnm+BZnmCC
         hL1pNbiICJ1zQT86xDAv2kyfmdPOumuTE1BVCjbQBZTu/rBvZ36l9ymf0SFNqIG6Jc9E
         +7jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767704983; x=1768309783;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JpzahlfiGpAFEOQGjh5jjjaXUgZ9jhcXoloaQUEBJwU=;
        b=dpjEYe9BUsGoP2zlf0hil5iHFo49X7xXUKpJW/SE9EVErFEKJW1lSF0ed6dQHAZC0y
         VVtVh0hGF6eEuoZ2nMaJizwM64iy0MxQhhOjNXNq4NoayUYwSYstI3C0pZ40gfLx43OH
         jYaKLiwMKbIuVXaGkBaC/PHyzX2Aaz9Y/KgfAO9ytmaHh0Pxvj8hRQbErrlwYzmzWsai
         w5QZ22TonVO2VkQpIoRabR1SiroCKIYLNoabhfA6Jnpi09Fbra/GV07MD/IVqGjvTepu
         3rX32AYTF+SiuupLpDFgrwShbHH1zlgoD5iw0kXC1yxzfVJmnATlIeHuWswWDD72Ket8
         wzlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcnYAjRxK6JUaafN3yMnNTqFphylCHZwPUpBq6WgirHOjq41FUq2GOK978323mDYDTgUxP2NGNVdnq5Qg4@vger.kernel.org
X-Gm-Message-State: AOJu0YwsJNgH5Rs4A1aBqc3lDnTMSGjJgRxmRw4Vs+OwtYYQBzFMZMja
	icCJrqLSZTQxdiFd5M2dAnOyo/2+/lisGBHPtAW30F4PPbdcdr2nZoiT
X-Gm-Gg: AY/fxX7qmcHeoJDgIPCP+Vh2x6kcNcVk+EmSdWHxdcwYbp67VG5XmYkmG1KPu4fhVj9
	IKDCoZ/WqBu/U+tYftpeiRX0NObmpNubCX0D962tOL2H+OXM1yeOHnA2bw6luVwrjU2DfgQNVC0
	X4VyeoRtQG95Kk2r3Eb/LJ9AeigNQ54rJrP9hkWJhfeBU4oH7j1Y+CxP4FdlUK0BtmasTvHLM8m
	24G0ckNleWj2bGLSW6uuXlmXp/+VqAFWD3qSe4dDdOEp7CSqduA6L27gvnxPOgxxUfEn2NBbHE0
	2horDMqd0WUj7fR9NCpQiv4y1IaF+4emYWpa2Zh2RC33q/OuDVlXvXP8RjZYZs976CjvtaNu6rD
	mLyBY1m8Cu3zk8yt0moIkOAqgHK0Nfh9wI9T+f9zvYpxTHrvISa47HxeiBTzMeYXfSrWtcsMuYF
	hebCRC0aySgvQrgVAMV+ukheKAeXvdaFUIplHa+9REaT1lErNBHbMJpf5tEF/rwFkQ4dpOxOaHY
	xrDpUZFpPdLe6M=
X-Google-Smtp-Source: AGHT+IE/G8uVi22ATP3WXoVJPNVxriboWDTjcasbHlPDtJRw+IZ7O9Erdw+Esh+/t/URn4jtbR4Hhg==
X-Received: by 2002:a05:620a:708b:b0:8c2:2b5c:6bb3 with SMTP id af79cd13be357-8c37ec03772mr311728985a.85.1767704982941;
        Tue, 06 Jan 2026 05:09:42 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-890770ce659sm13118086d6.10.2026.01.06.05.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 05:09:42 -0800 (PST)
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfauth.phl.internal (Postfix) with ESMTP id C2639F4006A;
	Tue,  6 Jan 2026 08:09:41 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Tue, 06 Jan 2026 08:09:41 -0500
X-ME-Sender: <xms:lQldad4o6VabieTCt7VP58h0fxSMJlnDJTqq9xmv4gUsrGb-cUuIaw>
    <xme:lQldaW3w0iVE7aXBFYGf2kwkmwV7ZmcAciKP2d4j9qH8XOU2umqBPTN4JSUHhyLas
    MMcI5zPbhgT9iepLo_t-G6251LnGrpdPhJIjqxnQG4vnpq4XEYmtQ>
X-ME-Received: <xmr:lQldaXhp32blzk3e-OBl_fGY-rmkxQc2DpKO7gj9iS1ZTCXrKa1lzqId>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutddtvdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueevieduffei
    vdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
    hquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedq
    udejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmh
    gvrdhnrghmvgdpnhgspghrtghpthhtohepfedvpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopegrrdhhihhnuggsohhrgheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprg
    hlihgtvghrhihhlhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepghgrrhihsehgrghr
    hihguhhordhnvghtpdhrtghpthhtohepfihilhhlsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopehpvghtvghriiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehprghu
    lhhmtghksehkvghrnhgvlhdrohhrghdprhgtphhtthhopehrihgthhgrrhgurdhhvghnug
    gvrhhsohhnsehlihhnrghrohdrohhrghdprhgtphhtthhopehmrghtthhsthekkeesghhm
    rghilhdrtghomhdprhgtphhtthhopehlihhnmhgrghejsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:lQldaRhoUQCXatEp-h38AqvV77rEtxvLNRGsFs8u2ms1OXSWNmrpQA>
    <xmx:lQldaTL4wxZLBZcRJjEHFu3dFfuCMiPW4zPdLeIt9ZiOItPMMXuaFg>
    <xmx:lQldaRiB9oounBOronYP2u5oKk5izsY-IGiIW14zReJVSjSCA01RJg>
    <xmx:lQldaXQI6hAF-uCxxcjncArfbu2vke8bZCG4ZKq76q5AAcla84LNSA>
    <xmx:lQldaWaMzSdWWEga_pd7OPdzFUdDDo_J3WFoBuhK1tVbKT2LHOV3QlIj>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Jan 2026 08:09:40 -0500 (EST)
Date: Tue, 6 Jan 2026 21:09:37 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>, Gary Guo <gary@garyguo.net>,
	Will Deacon <will@kernel.org>,	Peter Zijlstra <peterz@infradead.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>,	Magnus Lindholm <linmag7@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Miguel Ojeda <ojeda@kernel.org>,
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
Subject: Re: [PATCH 0/5] Add READ_ONCE and WRITE_ONCE to Rust
Message-ID: <aV0JkZdrZn97-d7d@tardis-2.local>
References: <20251231-rwonce-v1-0-702a10b85278@google.com>
 <20251231151216.23446b64.gary@garyguo.net>
 <aVXFk0L-FegoVJpC@google.com>
 <OFUIwAYmy6idQxDq-A3A_s2zDlhfKE9JmkSgcK40K8okU1OE_noL1rN6nUZD03AX6ixo4Xgfhi5C4XLl5RJlfA==@protonmail.internalid>
 <aVXKP8vQ6uAxtazT@tardis-2.local>
 <87fr8ij4le.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fr8ij4le.fsf@t14s.mail-host-address-is-not-set>

On Tue, Jan 06, 2026 at 01:41:33PM +0100, Andreas Hindborg wrote:
> "Boqun Feng" <boqun.feng@gmail.com> writes:
> 
[...]
> >> > I would prefer not to expose the READ_ONCE/WRITE_ONCE functions, at
> >> > least not with their atomic semantics.
> >> >
> >> > Both callsites that you have converted should be using
> >> >
> >> > 	Atomic::from_ptr().load(Relaxed)
> >> >
> >> > Please refer to the documentation of `Atomic` about this. Fujita has a
> >> > series that expand the type to u8/u16 if you need narrower accesses.
> >>
> >> Why? If we say that we're using the LKMM, then it seems confusing to not
> >> have a READ_ONCE() for cases where we interact with C code, and that C
> >> code documents that READ_ONCE() should be used.
> >>
> >
> > The problem of READ_ONCE() and WRITE_ONCE() is that the semantics is
> > complicated. Sometimes they are used for atomicity, sometimes they are
> > used for preventing data race. So yes, we are using LKMM in Rust as
> > well, but whenever possible, we need to clarify the intentation of the
> > API, using Atomic::from_ptr().load(Relaxed) helps on that front.
> >
> > IMO, READ_ONCE()/WRITE_ONCE() is like a "band aid" solution to a few
> > problems, having it would prevent us from developing a more clear view
> > for concurrent programming.
> 
> What is the semantics of a non-atomic write in C code under lock racing
> with a READ_ONCE/atomic relaxed read in Rust? That is the hrtimer case.
> 

Some C code believes a plain write to a properly aligned location is
atomic (see KCSAN_ASSUME_PLAIN_WRITES_ATOMIC, and no, this doesn't mean
it's recommended to assume such), and I guess that's the case for
hrtimer, if it's not much a trouble you can replace the plain write with
WRITE_ONCE() on C side ;-)

Regards,
Boqun

> 
> Best regards,
> Andreas Hindborg
> 
> 
> 

