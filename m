Return-Path: <linux-fsdevel+bounces-74767-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EAsJIps7cGmgXAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74767-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 03:36:11 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 059044FD80
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 03:36:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E7ABA54E44C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 02:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A41280A58;
	Wed, 21 Jan 2026 02:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dtV/tJov"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95197242D70
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jan 2026 02:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768962925; cv=none; b=fRTUnxQHQNr25EkwuoyVtaKldCYwZeaxQVHi4zJAFYe4YNhBDsD4+Ooa0QS/NEpd0oF61u41A0u7Ji7gLIH4bmx6H0ZQxjMB2sGEFELUN6I/mRfK8JcZaxsTU9/+3snnhoRRhGnkt4DRUOSId//on0pkojDWTYEBxu38ug7YTro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768962925; c=relaxed/simple;
	bh=YycTiJrPuZ50XWbU+aKf4d35PZCgfYUN6bofn1fuMIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uHlWJknWfWGo85g+qgKlKg1YiqEwsn6TdMhCGz0ICBAlJ339boGskhk1vJc88DZ7lMVOaA/MzJ1EaffsLptONZzg7Vfvj1Dly7cStT3D5fe6X6jBamJ33JR9mRPEbB2MeQYnWMCLOn1/mqC6NzbYQ35YctrLoLBd7/gY2mAOXRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dtV/tJov; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-5013c912f9fso69573711cf.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 18:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768962922; x=1769567722; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/SYWzQFciEmh1FoU8deqlPVu+NRiIm4WLmRuTDTk8Qc=;
        b=dtV/tJovqzzyACr5s1G+/qmbQ4HHdR5Q4w8KN2zr73rZScisHI6J+9avAKYtKDZHBn
         m/v8wSq5iv7dvhnJiDY1BdX7NqXZtPG+QTKIbCKJvq+YjSOOj8CPrWmorlt3E4cn1t5s
         S9yfwMzZVZ1Jf3j4Lev0sPCKWZMHVP0VykYu0pNjZlJSQmEGwiFO5BpPxLBCelrUFdYL
         WoQAfQr6OyKo+FtvoEjIb0w0FSxFvhMtfWbpGttxhxT15dZQmk4LW0taXsztFyjp7Ysh
         4z/2diXWLlC3m3Da0ST+cZsBn5bzJttibon/WIx4sWMrO4/EMkcPIE9mhXxSFHMSEeVO
         UXJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768962922; x=1769567722;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/SYWzQFciEmh1FoU8deqlPVu+NRiIm4WLmRuTDTk8Qc=;
        b=Th2aJYt0ARklkjTChMIfTGt0n+S5WqK+TCizMifkxOH1wVEj8u6NDFRupqpUqzOTfL
         nfePouJWmdidUdXfji/32OnptRJB6dWozsPJLSp5AjBp5MZ/YQqE7jTBhE8c49Mo+hJy
         /HgSNekIoRyHGxDOJYKmt7bfajJJfhc5bOXtjBKqAToAkjoaFNmmuiiut2QpWWzWr9rz
         BKmDcfRrt/4qmCy2Hw6pCc1BSRjBZmefjZ9g6ZfDas/PjgraXVCZ643U6kkd/QQ456kU
         YSsVQULJtcjcNJe+fC7NbiGUI+ssmZnb0vAH58noSj1uX7412BjuaIEA0wOrRrHGHkmH
         fUpA==
X-Forwarded-Encrypted: i=1; AJvYcCVGB+ksoF+UdxmV8vWTgxkAnwuo7Tnvh54Df0x6zPGMZ5K5Pq6uuAf6IhyZMObDcK7+FgLiAkiSVnnlK+Er@vger.kernel.org
X-Gm-Message-State: AOJu0Yzka7ikjFy/214eaPh9zlUVYnnixto0N2in7u5gzAFy7VyDPg6o
	M/l2NtQK8JWfXTMc6Y4W1PhR/O7wtfGNin3vvSqfQCQIVx9nOd4FcuB/
X-Gm-Gg: AZuq6aLdAOQynvQ+mLW1YYJaVtZgWa5evfDVWoBGl7ko4bcicsZowLZ9fwDYLsn3m+R
	tRRYOYKktck6pmifVBHup6dvUWd1XwmoTfqrDvPqlZqiR/x6BkVSOlb//fChloeJi+iHNvWZBma
	dHM18AFOmpdmvB+b0/A+FX4aOnPp2Glhy/S+9PWSo8NAX92WcBogrpediC60/F4pgezjCEyGyL+
	wuvffhMPk1bodVRqr2WsL7NOYkC9ASAbUIWCH/Q7th6w6x5rpzkQwPuUi/spn/LiPzJ5igQgAFi
	H8C/iLpp5McrUx3Rtb01qcHGp+yGkH8kITq2yrv0WHqnO0EpNic2Ch0ETCaYWnuwRplOEZAYlip
	k8h2UzhZ06hHe8OYoROBLIzGXz4I95RD1haLI7G2CidLjTLdZW0UZozgNDAqyv1c0G0RBLt55WO
	9NMY/+TXjirAmMBiVpm1zGw/O6YMWXUJCA9K8dfamLp0ko8SU2GmRxfJVssLhFR9Ngyf5bG0vI+
	dtERlRLLyvs0EM=
X-Received: by 2002:ac8:5e11:0:b0:4f4:d298:b47c with SMTP id d75a77b69052e-502a1e07becmr238961631cf.28.1768956457813;
        Tue, 20 Jan 2026 16:47:37 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6a7269277sm1143950785a.43.2026.01.20.16.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 16:47:37 -0800 (PST)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id 9A38FF40070;
	Tue, 20 Jan 2026 19:47:35 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 20 Jan 2026 19:47:35 -0500
X-ME-Sender: <xms:JyJwaYlxHCp2CJ9XJSkRGaNnnIfTr2CPMTk66aaLjJ8NL6geKbHEUw>
    <xme:JyJwaRhQ9tHsguPZdsm-gbfKNoOqdj5C8VQgEuisf9r5GzaMoP2vysuiFdK_z8pcP
    CA7y6EHL1cipec_t9rcLTiDCO2FTJ6nC5Bj3OiUnyymky8qMw>
X-ME-Received: <xmr:JyJwaV_rVlfR2KnChLT6z56C5W8d7hPExZS6zuXoB_umworfTbmKYIBO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugedukeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueevieduffei
    vdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
    hquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedq
    udejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmh
    gvrdhnrghmvgdpnhgspghrtghpthhtohepfedupdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopegrlhhitggvrhihhhhlsehgohhoghhlvgdrtghomhdprhgtphhtthhopeifih
    hllheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvthgvrhiisehinhhfrhgruggv
    rggurdhorhhgpdhrtghpthhtoheprhhitghhrghrugdrhhgvnhguvghrshhonheslhhinh
    grrhhordhorhhgpdhrtghpthhtohepmhgrthhtshhtkeeksehgmhgrihhlrdgtohhmpdhr
    tghpthhtoheplhhinhhmrghgjeesghhmrghilhdrtghomhdprhgtphhtthhopegtrghtrg
    hlihhnrdhmrghrihhnrghssegrrhhmrdgtohhmpdhrtghpthhtohepohhjvggurgeskhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepghgrrhihsehgrghrhihguhhordhnvght
X-ME-Proxy: <xmx:JyJwacqvDrVFqbB_v4DJpp2xCk2xPwPBG4Rn1gtnHnXEeTrMnP9C3w>
    <xmx:JyJwabOpMOAo0DJprIqW5L36k5blht_hBf_QHlx2Zajjf827IyzHMQ>
    <xmx:JyJwaYS3LHXmxS1ssanGpUtdI6D3bsmNrDFB6F0TIJxUOa-6eu6UrQ>
    <xmx:JyJwaY8YbtMT8-V977xDI_zpwzJy6oddKb6ufhLgJ-XTerrF5SxqaQ>
    <xmx:JyJwacoE8g49BcHFirTruH_zNcwaBTLPwisaymIERtlin-fIU4ZLuRjF>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Jan 2026 19:47:34 -0500 (EST)
Date: Wed, 21 Jan 2026 08:47:32 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>,	Magnus Lindholm <linmag7@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,	Danilo Krummrich <dakr@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
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
Subject: Re: [PATCH 5/5] rust: fs: use READ_ONCE instead of read_volatile
Message-ID: <aXAiJPPrlzNld3Mu@tardis-2.local>
References: <20251231-rwonce-v1-0-702a10b85278@google.com>
 <20251231-rwonce-v1-5-702a10b85278@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251231-rwonce-v1-5-702a10b85278@google.com>
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,infradead.org,linaro.org,gmail.com,arm.com,garyguo.net,protonmail.com,umich.edu,redhat.com,linutronix.de,google.com,zeniv.linux.org.uk,suse.cz,vger.kernel.org,lists.infradead.org];
	TAGGED_FROM(0.00)[bounces-74767-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	DKIM_TRACE(0.00)[gmail.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,tardis-2.local:mid];
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
X-Rspamd-Queue-Id: 059044FD80
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Dec 31, 2025 at 12:22:29PM +0000, Alice Ryhl wrote:
> Using `READ_ONCE` is the correct way to read the `f_flags` field.
> 
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/kernel/fs/file.rs | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/rust/kernel/fs/file.rs b/rust/kernel/fs/file.rs
> index 23ee689bd2400565223181645157d832a836589f..6b07f08e7012f512e53743266096ce0076d29e1c 100644
> --- a/rust/kernel/fs/file.rs
> +++ b/rust/kernel/fs/file.rs
> @@ -335,12 +335,8 @@ pub fn cred(&self) -> &Credential {
>      /// The flags are a combination of the constants in [`flags`].
>      #[inline]
>      pub fn flags(&self) -> u32 {
> -        // This `read_volatile` is intended to correspond to a READ_ONCE call.
> -        //
> -        // SAFETY: The file is valid because the shared reference guarantees a nonzero refcount.
> -        //
> -        // FIXME(read_once): Replace with `read_once` when available on the Rust side.
> -        unsafe { core::ptr::addr_of!((*self.as_ptr()).f_flags).read_volatile() }
> +        // SAFETY: The `f_flags` field of `struct file` is readable with `READ_ONCE`.
> +        unsafe { kernel::sync::READ_ONCE(&raw const (*self.as_ptr()).f_flags) }

Not a question directly to this patch, but for FS folks: I see we read
and write `f_flags` normally (i.e. without *_ONCE() or any atomic), and
I don't see any synchronization between these read and write (maybe I'm
missing something?), if read and write can happen at the same time, it's
data race. So I assume we must have some assumption on the atomicity of
these accesses to `f_flags`, could you may share or confirm this? Thanks

Regards,
Boqun

>      }
>  }
>  
> 
> -- 
> 2.52.0.351.gbe84eed79e-goog
> 

