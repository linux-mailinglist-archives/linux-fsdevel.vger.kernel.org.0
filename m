Return-Path: <linux-fsdevel+bounces-72299-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C44ACCECB9E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 01 Jan 2026 02:13:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3AEE33015A86
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Jan 2026 01:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F027269811;
	Thu,  1 Jan 2026 01:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d9cdXSKs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3542625B2F4
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 Jan 2026 01:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767230028; cv=none; b=jE7qkFG/2ROK94wYIl6xWLnlzHKGgi5/i/Qdbqt4SUpCK79K4Z1Yeg/3xtKLhvGukHF8wPwP3L8Dq1Qf7jw8KIPpHEOD3CrOpFvyrzjbnqg1umbqlG707uhJAmNaSniR78LxgXl7zXsUpS8Q+BF3OCQPbRG2+wqd0jgWkzNTpNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767230028; c=relaxed/simple;
	bh=WW9T6v83YpHrdRU6GxDyOasG1bC9q4PJavZbqVhfXcs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QwW6cfgWRbYuC9AsS8W2RsdobNJhxjxh/FZjZOO2k5kbYUE5jqI7nbVcLlY0DqKDHFHK4GPuNyzin2kSa8/o1uyVe6pO8c8sI53sb/PWxIp2Uch5ZrEa2tTaH/8LRNoqcBT0/BNEXAhtDiP98EUxle2YnhNPHq03WsicfebQT0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d9cdXSKs; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4ee158187aaso123504921cf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 Dec 2025 17:13:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767230022; x=1767834822; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IrjRP9q8c0tglfIoe+XxWLIY8X9nzFBO0FXW5gpQW5g=;
        b=d9cdXSKsyXys4TH9A/im43O8vTr1JMNwjD3BQoEyqz0w27o2T4KBXY40DPOYIwCnr7
         xt8hspRhtt7vmhioknSbw8uZhGM5L7P5LC0kj7YoqATfjDG2v8px/0tD8atxQoZvoEaX
         pF5HlLcoT+bUd9pUruVUtubGGVwtRpKpLHZcD4IoTFcus2WelSOepVom2i8BIG4aELOj
         uduQAe0tIdPGfaLkGEOkS4JUki2cf98vtAKOT6EB37/I+B5EliUgAxTm8BSX5W17rnBK
         6aFm0go7pC4qbaYo4ph9GV1luuAfZJzdh4t0MapZSHNB2ncn+NEDh+Am3B5+mAlr08Lu
         TlGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767230022; x=1767834822;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IrjRP9q8c0tglfIoe+XxWLIY8X9nzFBO0FXW5gpQW5g=;
        b=t1l8VxQPpVdwAlHw3n3igtQ3yxP1YVl8qFIf1ev6JqSI5xzoCUBR8d5sx4JOR1aO3H
         2y9/b/UwkXsWcTDQqmRuLl5sQ76Zyo7vWLw88VWvgNOhONA/uJRKNszEDPaFo38oiJsl
         PFVZnGIvb/OFA3iYep8zK4xAPijn+sAr7mBSlVlRHposjVi71wzntR/rNhusYY3nIxWl
         vEvi3nIpa7snEFOTTxyS/9Bx0iEIiL7DOkGYB3mE3fAnRqRkNWJ9Cx1fDNccKm+DuNx6
         zLSLuCCTB5DKzmhYLfnRIXWyZkhni8Xxhf/Bo218UvqclNl/dKBx1DQnMfJemmuGsvNm
         4r/A==
X-Forwarded-Encrypted: i=1; AJvYcCUeEVcR5fOIGAZqvOyuExMkc4DWMS/inJpLC1AyQ016I7rnB33s0RnsMJlO7QXDh3LFZRXHa2qaNwNZkGBy@vger.kernel.org
X-Gm-Message-State: AOJu0YzxhRLRwucoEGMwlbrPAGHZfq9zEy6nO+U13HkX9+J0nQ+KSL3i
	k8mt1jcM+JoihCQLv3CbBLU2IulJvJNbjk1PJ+QrkfHIxo57C9oJHaln
X-Gm-Gg: AY/fxX7TBMsnpXKFirKyKrXogEt9aW/yTZszQvUUdP7gBXRwzWX/W4lDa+5r0rdeYu/
	696GswGXXt0xQZGzRWVmzIgaG78Wr/S+10aWJOJgXOsyoUC5eOaAo/EDbNdqeeTzat6ovQG5Jyi
	4nW4olLmNU83DFSy2cxRIQNg1M/ieb8VDXoIcOtDC9td+NGfaginfxi4CrXQGQ+XPf/BeI4qHSK
	dr+w5jPA6bMDaXN4NmHJ8E3SJh/ffzPXS8IOojox6X9mDMLBNzVZuLFXpQkzkN+2s5f+V3rZiMe
	MRbr7WtqeexL6wB58ecrpmDIRHShYoAMMfS/rHjHOwpoOohLEh1GevGtenHZ5qOPBWO+6oU7hVw
	NjkwPRMsxfiGGInV1L3tSVpv8TfuZWbkNatVGPxGhV1GWfHPT6DSMpYWMbpR9zzPT2qWURKxbCk
	ekYYrX106r4Rm8B931m/wY/vPoKKomGmMB+p8GewrR4Dy1RAcFaVXCEgnEVxyTdBRWbXTK+TgID
	fVvmk4bNMOTA5o=
X-Google-Smtp-Source: AGHT+IGqbWQCQzh9nbyhwAaF7d7/2+0PkqXfRpFE3/XyT4YpnYVUp5bmjdZmquhjJvald9WQ52Pa+Q==
X-Received: by 2002:a05:622a:4295:b0:4ee:bff:7fbf with SMTP id d75a77b69052e-4f4abcf6ad2mr546707501cf.4.1767230022154;
        Wed, 31 Dec 2025 17:13:42 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4f4ac65344bsm270256121cf.28.2025.12.31.17.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 17:13:41 -0800 (PST)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id E4468F40068;
	Wed, 31 Dec 2025 20:13:40 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 31 Dec 2025 20:13:40 -0500
X-ME-Sender: <xms:RMpVadPHBw4HBWMphwZq1pgT5fJC3CPbmHQdu9lumn0k_7tYA_K5Zw>
    <xme:RMpVaebD7MRte1FUx824DzyNRDhFHHs5jKY1c49B8N_xNeevq0B9BQWiJqISO_B39
    gw_jYgNYPWjNbzD3VMqTucRL2adjXPXpe_QWRduAlkODRVoIHm-JQ>
X-ME-Received: <xmr:RMpVae68p8xT8IdkM28rMzPeCmKXgzEK_Fu8NZtRu9S-Y5HsM8UQOPoHTAc0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdekgeegfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveeiudffiedv
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqh
    hunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddu
    jeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvg
    drnhgrmhgvpdhnsggprhgtphhtthhopeefvddpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtoheprghlihgtvghrhihhlhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepghgrrh
    ihsehgrghrhihguhhordhnvghtpdhrtghpthhtohepfihilhhlsehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtth
    hopehprghulhhmtghksehkvghrnhgvlhdrohhrghdprhgtphhtthhopehrihgthhgrrhgu
    rdhhvghnuggvrhhsohhnsehlihhnrghrohdrohhrghdprhgtphhtthhopehmrghtthhsth
    ekkeesghhmrghilhdrtghomhdprhgtphhtthhopehlihhnmhgrghejsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtoheptggrthgrlhhinhdrmhgrrhhinhgrshesrghrmhdrtghomh
X-ME-Proxy: <xmx:RMpVaVBbBnEmsQiqDEJQI5Vp0m45h3JWVi6J1Pr1FKmD2fDWfoTQfQ>
    <xmx:RMpVad6o7wE9nCfGGPHsTn7JE1D5TdpllKBohOy44er65HeDGb9yTw>
    <xmx:RMpVacLbQ_HpVXpiYbyGWy8IQvxsGN4hN7_-_vbGrAjs-x6Qe3tfAw>
    <xmx:RMpVaZyYzNE9MuelcekvFHC5-yl3HGyzOTwnMf1gpdHCRpnXK7Rjsw>
    <xmx:RMpVaUG0QewaINsxwC5mQQPkaOvDexnwM1B5CSPYFOpTguWdmMUW_fdb>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 31 Dec 2025 20:13:39 -0500 (EST)
Date: Thu, 1 Jan 2026 09:13:35 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Gary Guo <gary@garyguo.net>, Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>,	Magnus Lindholm <linmag7@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Miguel Ojeda <ojeda@kernel.org>,
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
Subject: Re: [PATCH 0/5] Add READ_ONCE and WRITE_ONCE to Rust
Message-ID: <aVXKP8vQ6uAxtazT@tardis-2.local>
References: <20251231-rwonce-v1-0-702a10b85278@google.com>
 <20251231151216.23446b64.gary@garyguo.net>
 <aVXFk0L-FegoVJpC@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aVXFk0L-FegoVJpC@google.com>

On Thu, Jan 01, 2026 at 12:53:39AM +0000, Alice Ryhl wrote:
> On Wed, Dec 31, 2025 at 03:12:16PM +0000, Gary Guo wrote:
> > On Wed, 31 Dec 2025 12:22:24 +0000
> > Alice Ryhl <aliceryhl@google.com> wrote:
> > 
> > > There are currently a few places in the kernel where we use volatile
> > > reads when we really should be using `READ_ONCE`. To make it possible to
> > > replace these with proper `READ_ONCE` calls, introduce a Rust version of
> > > `READ_ONCE`.
> > > 
> > > A new config option CONFIG_ARCH_USE_CUSTOM_READ_ONCE is introduced so
> > > that Rust is able to use conditional compilation to implement READ_ONCE
> > > in terms of either a volatile read, or by calling into a C helper
> > > function, depending on the architecture.
> > > 
> > > This series is intended to be merged through ATOMIC INFRASTRUCTURE.
> > 
> > Hi Alice,
> > 
> > I would prefer not to expose the READ_ONCE/WRITE_ONCE functions, at
> > least not with their atomic semantics.
> > 
> > Both callsites that you have converted should be using
> > 
> > 	Atomic::from_ptr().load(Relaxed)
> > 
> > Please refer to the documentation of `Atomic` about this. Fujita has a
> > series that expand the type to u8/u16 if you need narrower accesses.
> 
> Why? If we say that we're using the LKMM, then it seems confusing to not
> have a READ_ONCE() for cases where we interact with C code, and that C
> code documents that READ_ONCE() should be used.
> 

The problem of READ_ONCE() and WRITE_ONCE() is that the semantics is
complicated. Sometimes they are used for atomicity, sometimes they are
used for preventing data race. So yes, we are using LKMM in Rust as
well, but whenever possible, we need to clarify the intentation of the
API, using Atomic::from_ptr().load(Relaxed) helps on that front.

IMO, READ_ONCE()/WRITE_ONCE() is like a "band aid" solution to a few
problems, having it would prevent us from developing a more clear view
for concurrent programming.

Regards,
Boqun

> Alice

