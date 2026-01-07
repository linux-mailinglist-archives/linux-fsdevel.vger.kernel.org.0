Return-Path: <linux-fsdevel+bounces-72563-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 481DACFB947
	for <lists+linux-fsdevel@lfdr.de>; Wed, 07 Jan 2026 02:22:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E0FA302E071
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jan 2026 01:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F3B20297C;
	Wed,  7 Jan 2026 01:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JBiKB+kH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E307260D
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Jan 2026 01:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767748740; cv=none; b=tIvAcqrkdZN5EZlP3JTsqHfIqjdmLkFrDrh9zA00mRS0DQo2QzYcr07W/Ptxhy0hGvjXLhMCPl+T6wQS9FG7mAJ2LkDO2AFvyWfQvNqxR9GSNsjT0Nk11VvfHHCULwPHejNSdto7eVEYPafrZ9BOAQF4SzvY3XI7PP9GJraCfEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767748740; c=relaxed/simple;
	bh=7aK67iGgcDmAxLareT1ziFSZV7B6VsFItJjUvryk7xU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QbemcOd7i5tS9oyLmkqJSRzxCCCk0XpCXN9BKc6d0aSUYlNPJFTTDHMIL85Xuu8g4/KF7eWpFmjxZBRd0QhhJ/xAF+ItvAIlJDh0ehf/yxVjeir5ml2Vvz57MXvPpd3zFVD9aCNpfDU4qlObV7WrOV4BpTH9qt6EVv4CmMXwMCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JBiKB+kH; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8c0d16bb24dso132309285a.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Jan 2026 17:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767748737; x=1768353537; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6FoRkeDHF5yoSsn09BRVFk/fdmiabmgZC1/0wAMN4j8=;
        b=JBiKB+kHtjUB/WrN1BWsrayhfPE981cghtKGXYL0WXYoB8yTBLpoXgqV58Qhy2n0IO
         HqdydK54fRmgChyUItfTZVMLQR6dne/ugnGLS2A8C/6uVAwQtt16lhSIvY6Yg6mx+o3p
         91PPQkUe+HFL1afIU3xG44j+8wncuwdU3P2cNwJhip5oQXYf5xRuz1I/5FIbT5EVdUOG
         AwJl5mb0voV2uNyM8WoBiz4FN0eejV37MQPqjaaJ1G33gnB0A2p6hw9iD/nuo17+Ipef
         4HPCVX50kPSWO8TV5HlwIG6uaZahgQLv+4hMSRMrhqBmRvBEjQs/COvl8W+w+oOS29Za
         uDag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767748737; x=1768353537;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6FoRkeDHF5yoSsn09BRVFk/fdmiabmgZC1/0wAMN4j8=;
        b=GQaz9Lds/UOf4C03KpJJILQ6LEX/wXXLbHUKWBn2sMvOI+n0XptTMezF3j0X1Wp213
         gd0kCRxLyljSDZNYhNx3eUU64E5qefSwnGIzVODbKuN49G1urJ9GAS22lZq4u0r+Vx6n
         CqCoFae4T/BLDtH3h6WnX11GDkO4BzWdKgvcNlx9pSvmDA55SiIiG06DPSJqe3KNLrOA
         tYTIfTiyumHABhRRGFzFri30POTEFJabJbvONXzWAqQjseK4ZLaAHpBMNqTpeVw0MCQK
         aD4oty0S5IDDf2m0XeATEhpi17z3avdy/w+6uWsR8Q6ySW2o6QaP0dTb2Hdkrkj+VAL6
         BcEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxhhV36k0oZzshXRnyeDnWe6YMkFBzS6GPY47pXBEnWial3omcae1MvFj62dty6ND/4er2EQsQ3b4NWAbu@vger.kernel.org
X-Gm-Message-State: AOJu0YzHUN6A1q4d1unZ0l89OSWYZ6AhtuXNHDT3tyoZpHK4s5cfJTkn
	AMgTAnZCF27A9pwil78jSnCIyweTjJVnPgCovul5siI6sOM04KXnq3xJ
X-Gm-Gg: AY/fxX7helEwEBNq32ciOuqWckyVBrvv7ALlymt5MhMUVjTXo6XGqpLvBj0kWLRlj5L
	u7Xj6l//SRP7g8H7yqkafsjRxNetN9kTZ69NdUsLOsZ4+1bxGzTchUA7G9F0YL4NBx0dCiTmnnF
	hly2OYV6Zb/vKGEg56vyXxF/KKkpYNoHtOSJTXVg7TQCQyZozJA8pMHjc6EjwE5bJYOsshmi2i3
	otG9BsqNakT6nKnCGOtPRnZOwES+UhSafZk5li8AW+f+9CbZ4Q/Ounxm5BzcCkpvS10mgCU0P7r
	GgWVZyzTOlkqs7Fi9Fzv6oFGf9kRTyFWlPTteZboxRRsEHwrG8nQBr5vVLOdzPhBfI04L8Q8+tB
	fOnoQ9uoXN1Al7z17pxcQd+UK4tVOh+RE9uxkPiTzKvSEDJ9q+GVoUqmkAoR1yZYc6sSt4oMssU
	OQFo0aBjQEwr2geIRIpbZ8HT8BaIqB5aAgS91eoSXyNgXmiZGsU3JFuObL/v0kfWQAWoTzqguvt
	eq8BVaSwAWL77A=
X-Google-Smtp-Source: AGHT+IFypmDgkHig19yVDiKuuUnEQYc/zF0z8166O/+XxI2JReUaqgJQqu7rh5QVdnDjZBol/ryuNw==
X-Received: by 2002:a05:620a:4012:b0:8b2:d56a:f2f3 with SMTP id af79cd13be357-8c38941be00mr104779485a.87.1767748737114;
        Tue, 06 Jan 2026 17:18:57 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c37f4a794bsm282570585a.9.2026.01.06.17.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 17:18:56 -0800 (PST)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id 1C8CDF4006A;
	Tue,  6 Jan 2026 20:18:56 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 06 Jan 2026 20:18:56 -0500
X-ME-Sender: <xms:gLRdaY-yjhbzv4p2fZMRj6erfzZOY68KWppOaI6UeJGOh3-UH5E7hQ>
    <xme:gLRdaQrCY2wrMERsU2JznKHNlX-9KKP-0kOEck9XsTxLmoYZjcKnrs5Ac4f7YwNOY
    mMwvrsU00wXUHE08TVUcHAipkB4fiEUh6U3D7PUZGmXfz742i_Y_A>
X-ME-Received: <xmr:gLRdaZm4B2Ro7V8aBF_MvptT5t8wujf85ERgDstIsRIwOFbidl-JSxRK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutddujeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueevieduffei
    vdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
    hquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedq
    udejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmh
    gvrdhnrghmvgdpnhgspghrtghpthhtohepfedupdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopegrlhhitggvrhihhhhlsehgohhoghhlvgdrtghomhdprhgtphhtthhopehgrg
    hrhiesghgrrhihghhuohdrnhgvthdprhgtphhtthhopegrrdhhihhnuggsohhrgheskhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepfhhujhhithgrrdhtohhmohhnohhrihesghhmrg
    hilhdrtghomhdprhgtphhtthhopehlhihuuggvsehrvgguhhgrthdrtghomhdprhgtphht
    thhopeifihhllheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvthgvrhiisehinh
    hfrhgruggvrggurdhorhhgpdhrtghpthhtoheprhhitghhrghrugdrhhgvnhguvghrshho
    nheslhhinhgrrhhordhorhhgpdhrtghpthhtohepmhgrthhtshhtkeeksehgmhgrihhlrd
    gtohhm
X-ME-Proxy: <xmx:gLRdadZj977ZiEnz2Kf_LmogUwCOvPRUpQILeyFM4DSWqHgcYwphnQ>
    <xmx:gLRdaWtqSc1QT6voJxAydCjIsF9vAj7osKx1o4OKibHaQXSg77aXPg>
    <xmx:gLRdaerOVV9-qaJ-sjqAUOK2pjk5RG7CKOqJ-JRJs_pDvqRtpP-D6g>
    <xmx:gLRdaYlrVNTIVHAW2Sr95-1vVTxcrEy0PMiHIHPyw3Jy0l_NtPRupA>
    <xmx:gLRdaWT8a84q9OfI6IMFkdffJAs2-WgcqdgDLHDDZxJZH6uUKmY8e-mH>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Jan 2026 20:18:55 -0500 (EST)
Date: Wed, 7 Jan 2026 09:18:53 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Gary Guo <gary@garyguo.net>, Andreas Hindborg <a.hindborg@kernel.org>,
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
Message-ID: <aV20fQSjMN1n6rrs@tardis-2.local>
References: <20251231-rwonce-v1-0-702a10b85278@google.com>
 <20251231-rwonce-v1-4-702a10b85278@google.com>
 <20260101.111123.1233018024195968460.fujita.tomonori@gmail.com>
 <L2dmGLLYJbusZn9axfRubM0hIOSTuny2cW3uyUhOVGvck7lQxTzDe0Xxf8Hw2cLxICT8kdmNAE74e-LV7YrReg==@protonmail.internalid>
 <20260101.130012.2122315449079707392.fujita.tomonori@gmail.com>
 <87ikdej4s1.fsf@t14s.mail-host-address-is-not-set>
 <20260106152300.7fec3847.gary@garyguo.net>
 <aV1XxWbXwkdM_AdA@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aV1XxWbXwkdM_AdA@google.com>

On Tue, Jan 06, 2026 at 06:43:17PM +0000, Alice Ryhl wrote:
> On Tue, Jan 06, 2026 at 03:23:00PM +0000, Gary Guo wrote:
> > On Tue, 06 Jan 2026 13:37:34 +0100
> > Andreas Hindborg <a.hindborg@kernel.org> wrote:
> > 
> > > "FUJITA Tomonori" <fujita.tomonori@gmail.com> writes:
> > > >
> > > > Sorry, of course this should be:
> > > >
> > > > +__rust_helper ktime_t rust_helper_hrtimer_get_expires(const struct hrtimer *timer)
> > > > +{
> > > > +	return hrtimer_get_expires(timer);
> > > > +}
> > > >  
> > > 
> > > This is a potentially racy read. As far as I recall, we determined that
> > > using read_once is the proper way to handle the situation.
> > > 
> > > I do not think it makes a difference that the read is done by C code.
> > 
> > If that's the case I think the C code should be fixed by inserting the
> > READ_ONCE?
> 
> I maintain my position that if this is what you recommend C code does,
> it's confusing to not make the same recommendation for Rust abstractions
> to the same thing.

The problem here is that C code should use atomic operation here, and
it can be done via READ_ONCE() in C, and in Rust, it should be done by
Atomic::from_ptr().load().

The recommendation is not "using READ_ONCE()" for C, it should be "using
reads that are atomic here", and that's why introducing READ_ONCE() in
Rust is a bad idea, because what we need here is an atomic operation not
a "magical thing that C relies on so we are fine".

> 
> After all, nothing is stopping you from calling atomic_read() in C too.
> 

Actually using atomic_read() in C should also work, it'll be technically
correct as well.

Regards,
Boqun

> Alice

