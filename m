Return-Path: <linux-fsdevel+bounces-72570-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 13BCDCFBC8E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 07 Jan 2026 03:54:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 110F33043D70
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jan 2026 02:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A9024886A;
	Wed,  7 Jan 2026 02:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h0h5xQ4L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561291A704B
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Jan 2026 02:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767754437; cv=none; b=KUvy5Sv8jEWpkEQ53kXwlzJtVQQWMCl+VCoDodUYSznAPocRrstvoZtwYe0wm0FUDIedC1IfXDW3RJzcVejoViwSR6ZybwNmYzRTx9eFvuv7y4TA15lA6fiKt8KaDCbqz994UM5lWtbizwOA0b1FRJr6WBh7TaINshT1zkkeozk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767754437; c=relaxed/simple;
	bh=H2WSDowZ9Yd/XdfZEyaAlHFGYOxomJFEKMh7vrcocT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uMBYK2sxwx78dUsyTWBtdmL4AnZie091TApAxAaqln8IGJqSuXZJyoKlTuv04MKRH0o+rRC3NWKPHsZGehhmkyaKcjLvINHYLJPvT3eZCKUt+Ie+SEDiwhNw74N0NS9xOxDGSl0YtZrTR68a9rKWiKKCRw1eUaV8LIVMNz92t9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h0h5xQ4L; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c227206e6dcso1237000a12.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Jan 2026 18:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767754436; x=1768359236; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/yQRPN2bRGk3Fc8VecQayp5kHElaztK+y5PRLikB7fk=;
        b=h0h5xQ4LmUsL8ru2vVq2PHNP/Eg663pC+WJOaOps7187Hav258eLGWrqEqurZizEaG
         romnR26l6ouC5C/8M+hYT63R8P5Y4m6j6hPxM3YbGAAYJTFW+/bKRkVPl1YLaclN50K3
         7NR83rA2kDQg/YRm+37L9Kcu+y63hB4Zy7GC5Ra8VQdC04qcm11aVCl4Fg6kPAQmZUkp
         bPt2gH5PTOvklrDEoxEddDonCbpUSpQoN0weTGD001BJIJQdfGwssfZGdlVhb3DVaDCb
         gSKv2XIYVo80guKd3Vj15zeFkT3oF5eyPvI02tHtRJQ74gcOzi4kYQ5L4sHrDp7KkKOp
         aZ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767754436; x=1768359236;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/yQRPN2bRGk3Fc8VecQayp5kHElaztK+y5PRLikB7fk=;
        b=lTPrd6HGw8377PfE4ezKOpsDxZPfXXavGj/R8SIMf5+e49vMYYaIf01XqPFg37CeJH
         t7ZlCH7cPOAskzVZO8cXiyTgibBf0CELsi0N1HCZN76B+BcqJNJJ9t1IxHCl2YtNCaMG
         1sjQVRH1+7h7kcOcnQb9ImCpN/4+WHjUkTpABHt183fDmE+Qy5q5FpNNBpGDssagAJog
         QlV+atEDwSoJkiH2nS7k2ENOp80CQdJ0uz4Vzp4FqqE82cMp9/9dhPH/V1N5koIrNl4h
         HNPJ+LkzxMNSVcboCptP22FyuCqSF05rsck1N/hIhPs7jF+W3qNzYSUY//BpzQFfteKn
         eKLA==
X-Forwarded-Encrypted: i=1; AJvYcCXdOZMWXJ/MeWs8Nu1R39+c0hNrtOc0NtwH1GKJi/ifGkaEnVbeN+s+UadWRPInlCPNZ/rn6+h3qysxPkr6@vger.kernel.org
X-Gm-Message-State: AOJu0YyPDQVKkiaz18dHnyBPvSqUs9538tsvmHKTBI9oX3H089GxoW8b
	YwJOElXEw2OTq6tvNaP01HkNMrwvc+5g2qdEUIdSz+6Pm4dbs7NPEmYn
X-Gm-Gg: AY/fxX6EqLa8r9yuXigO/ARhHYxnbC/dc43wAyR6wpyL3mHX1fRYjHifvX+fvXMYPJz
	6nFN0FIl2zHFlwpQo6L3F8hY1vrbn59FJivNWglZPRKXPPbHABiQUE6wzzCbOhBGkfgAXWMV1yH
	KxlVqBM9S3FORqFGNizdVBOXUQa1/pQZI25XEV9lMLlU+hgAL+lxEHNjgETt3SXM94ulOj01CV0
	sFnASA6xlkzUvcOJ2AyMif0IxHHnaaoKfx1wn46wY6JEOwVj5LiCASmPUYwU5h4ZweDAYKa3eDH
	x1xElgfPV8ufTplxbSJjgqU/AjUgtnLAGia1B63Z9s0MeBH1HFVHIK72b9MquEOa9WobtsXJgER
	SmEyemW9GceAwhhDgN+UNNfYw3REr0T78r0I0xyk+4Zqe2fySTX5x2eGeQPK868Ox+gbYQ18k6f
	bdLAi8KzvRujnwGs4n6rJjRC1OTL4JGj+mOp6JunjUBG6f1+2jh5muW9bFFiXCHhIl6K0rp7HGx
	2QVTdnbffTvp2Q=
X-Google-Smtp-Source: AGHT+IG5ln7HBmFkYUtgtCJWbHsit4QUg+m7/QlpcPikX3dXSHbBBf5OWyElnQmQUiI/+hz/5+QSXw==
X-Received: by 2002:a05:6214:590f:b0:890:2df9:c6a3 with SMTP id 6a1803df08f44-890842a264bmr12754276d6.50.1767748105800;
        Tue, 06 Jan 2026 17:08:25 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-890772346f8sm24105326d6.35.2026.01.06.17.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 17:08:25 -0800 (PST)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id 81DA5F40068;
	Tue,  6 Jan 2026 20:08:24 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 06 Jan 2026 20:08:24 -0500
X-ME-Sender: <xms:CLJdad6yFd4A4SYS7HRq3AX_2t4vwARcYtnzkYULI0Q6RZEWrXA5dw>
    <xme:CLJdaW2yxe8cFxXbBevKWnpOTk5okqtJ488BEjNFkIZfsubfPBNLHedM91nuDnCpa
    _Lor5ns-hZIagmtrBODTYqyOYSlUr1AU-VfmEzVPUIMe0_VBC8A8eA>
X-ME-Received: <xmr:CLJdaXgDiFVsHGf2kB7EmEeO7fri4d-JS1CNBfT1yWhPp2V440ReWFp5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutddujeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpefhtedvgfdtueekvdekieetieetjeeihedvteehuddujedvkedtkeefgedvvdeh
    tdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgv
    rhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfh
    gvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthho
    peefvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhhuhgssggrrhgusehnvh
    hiughirgdrtghomhdprhgtphhtthhopegrlhhitggvrhihhhhlsehgohhoghhlvgdrtgho
    mhdprhgtphhtthhopehgrghrhiesghgrrhihghhuohdrnhgvthdprhgtphhtthhopegrrd
    hhihhnuggsohhrgheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepfhhujhhithgrrdht
    ohhmohhnohhrihesghhmrghilhdrtghomhdprhgtphhtthhopehlhihuuggvsehrvgguhh
    grthdrtghomhdprhgtphhtthhopeifihhllheskhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepphgvthgvrhiisehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheprhhitghhrg
    hrugdrhhgvnhguvghrshhonheslhhinhgrrhhordhorhhg
X-ME-Proxy: <xmx:CLJdaRj6dhDVq8lxTc8HuDnERZb0ZcrKm75Ob5ByOTBCMMbT-xt8-w>
    <xmx:CLJdaTIi709hg2yhV8aB01YgGZ0-cshTZTMwVvNA6j5bcIDTXjSbWg>
    <xmx:CLJdaRhjE2LrxMqGD0j71yzr6022CSN7H5VH_V8JVg8dgxEh4cPfnw>
    <xmx:CLJdaXRCQvODOvo4irJon2oa1PJOB3MEAv3Bx2i8VY_lhxuGZqT5IQ>
    <xmx:CLJdaWY-ekMv9Tn3KnxmEGKAGEkIvGzwbd-tjpW-Bc2jbiPOwT55pxku>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Jan 2026 20:08:23 -0500 (EST)
Date: Wed, 7 Jan 2026 09:08:21 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: John Hubbard <jhubbard@nvidia.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Gary Guo <gary@garyguo.net>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>, lyude@redhat.com,
	will@kernel.org, peterz@infradead.org, richard.henderson@linaro.org,
	mattst88@gmail.com, linmag7@gmail.com, catalin.marinas@arm.com,
	ojeda@kernel.org, bjorn3_gh@protonmail.com, lossin@kernel.org,
	tmgross@umich.edu, dakr@kernel.org, mark.rutland@arm.com,
	frederic@kernel.org, tglx@linutronix.de, anna-maria@linutronix.de,
	jstultz@google.com, sboyd@kernel.org, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, linux-kernel@vger.kernel.org,
	linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 4/5] rust: hrtimer: use READ_ONCE instead of read_volatile
Message-ID: <aV2yBUW7W_dytCUG@tardis-2.local>
References: <20251231-rwonce-v1-0-702a10b85278@google.com>
 <20251231-rwonce-v1-4-702a10b85278@google.com>
 <20260101.111123.1233018024195968460.fujita.tomonori@gmail.com>
 <L2dmGLLYJbusZn9axfRubM0hIOSTuny2cW3uyUhOVGvck7lQxTzDe0Xxf8Hw2cLxICT8kdmNAE74e-LV7YrReg==@protonmail.internalid>
 <20260101.130012.2122315449079707392.fujita.tomonori@gmail.com>
 <87ikdej4s1.fsf@t14s.mail-host-address-is-not-set>
 <20260106152300.7fec3847.gary@garyguo.net>
 <aV1XxWbXwkdM_AdA@google.com>
 <4f3f87ad-62f0-4557-8371-123a2306f573@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f3f87ad-62f0-4557-8371-123a2306f573@nvidia.com>

On Tue, Jan 06, 2026 at 04:47:35PM -0800, John Hubbard wrote:
> On 1/6/26 10:43 AM, Alice Ryhl wrote:
> > On Tue, Jan 06, 2026 at 03:23:00PM +0000, Gary Guo wrote:
> >> On Tue, 06 Jan 2026 13:37:34 +0100
> >> Andreas Hindborg <a.hindborg@kernel.org> wrote:
> >>
> >>> "FUJITA Tomonori" <fujita.tomonori@gmail.com> writes:
> >>>>
> >>>> Sorry, of course this should be:
> >>>>
> >>>> +__rust_helper ktime_t rust_helper_hrtimer_get_expires(const struct hrtimer *timer)
> >>>> +{
> >>>> +	return hrtimer_get_expires(timer);
> >>>> +}
> >>>>  
> >>>
> >>> This is a potentially racy read. As far as I recall, we determined that
> >>> using read_once is the proper way to handle the situation.
> >>>
> >>> I do not think it makes a difference that the read is done by C code.
> >>
> >> If that's the case I think the C code should be fixed by inserting the
> >> READ_ONCE?
> > 
> > I maintain my position that if this is what you recommend C code does,
> > it's confusing to not make the same recommendation for Rust abstractions
> > to the same thing.
> > 
> > After all, nothing is stopping you from calling atomic_read() in C too.
> > 
> 
> Hi Alice and everyone!
> 
> I'm having trouble fully understanding the latest reply, so maybe what
> I'm saying is actually what you just said.
> 
> Anyway, we should use READ_ONCE in both the C and Rust code. Relying
> on the compiler for that is no longer OK. We shouldn't be shy about
> fixing the C side (not that I think you have been, so far!).
> 

Agreed on most of it, except that we should be more explicit in Rust,
by using atomic_load[1] instead of READ_ONCE().

[1]: https://lore.kernel.org/rust-for-linux/aV0FxCRzXFrNLZik@tardis-2.local/

Regards,
Boqun

> thanks,
> -- 
> John Hubbard
> 

