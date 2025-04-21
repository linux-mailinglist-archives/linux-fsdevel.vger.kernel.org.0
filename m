Return-Path: <linux-fsdevel+bounces-46810-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B44A95401
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 18:27:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 133653B4E73
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 16:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0011E0E1A;
	Mon, 21 Apr 2025 16:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mfktyoxR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C5D2F3E;
	Mon, 21 Apr 2025 16:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745252860; cv=none; b=AotM3KF3ZNiHwAbOS6xiEpbhCnx7HW3lVbwbf0KgnuKJLENzStupEoSVvRhVbHpXczZPQqNppfeILYTIT6lwytO1v+Wg/S4e/EYEzUix9CqICsLPVRgi1S83k42P4eAK3znpqmuWP/wKeInV7A3Pe4KPggoLDXIDKE+X7PAkQWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745252860; c=relaxed/simple;
	bh=d29f1CbXH/K+cVH+CEkYm8rZ6C6Sgeo7I7Z1B49VYSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LBKZvHAlgJEB+BZTSSi7zjPYLECKk+Xy7x2hDNuIcI0oEkrTC13Gi8L/SEh6ks3kbok4U2hJsDTHFWYbxpJ0bs+KHwd/PQ2tEBan+7slQAuYB+2UCvHZZWqGelz9qjcOA0Z3pDjwQHXJcCtcTwS2HM92YqZAhSWB1TW1FFAbKqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mfktyoxR; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7c5568355ffso334962385a.0;
        Mon, 21 Apr 2025 09:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745252857; x=1745857657; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oLHYuRchr7pwRfQW4u682e1RScHliKjKzEJvvrT1wG0=;
        b=mfktyoxRgLaOqRHlq2BACASEJ1xUe5ywvqnPYzuFFn1FnMHEjOqD5/YvfIhhSfdQgh
         EH6J8Q6kUGua8Yi0umt3U9od2eq2Toly8z9aMfH0hkLPgQ5xX9tZpSTR5fARxWc/OodB
         UfmTVCld07DUaHww36g1RxSCjrdj1zsVHhfUnMIj3LUaKNvyIOkiMbQMvRpemnmizQp+
         z7d+PwQ8TvueikFfT8suy3YPIuCeCGccZ7gq+zOkPHrAsnOM7K5Ynp7Isj//q9wLnoYp
         4flwYCAoxtJkbRrKcQzmoKL+ldGnDVkPkduUamFft7H0kLWXhdyxiKlX4N+q6BmfcBsC
         QJ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745252857; x=1745857657;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oLHYuRchr7pwRfQW4u682e1RScHliKjKzEJvvrT1wG0=;
        b=VMQmRFvn4ukhAasUd6m79vDPmAUfAyDwGUGqdVSkIUccLrEX5uTkNjeGZK3aFgoEF6
         Cycp7SwmrasxgSd9S669tLp4qB2368E7HS1WPNYXnfQYiLT4uVvDogbU7B2RphX/Ff0G
         8bNv25wBLInX+nWcvQG0YFIlPosI8NuBgXdP0RBl4OT32kzU8qZP0r7ARDpMDGZOHaDk
         E/goNdEF67U3NQaoK9TXMrgmqYzITk4VFJYP18cGY0qadJPzJUVStRigwgWs1e/b4sJR
         yQAmIHX2+eYjt2BjYMTgro8OJLeXq5J3vJDn6RFFbKddQsXBMc/hJYVQt2dYjMKWNLNR
         aZZw==
X-Forwarded-Encrypted: i=1; AJvYcCU51y/5Kyivb5xmMIwnJ3soN2dyzlh3gZptber4B5OpzrnQfb6yU65RJWrpJa41mZiilWRatwMKPYLSrOeaRw==@vger.kernel.org, AJvYcCUU7s9w28bJHkOe6F0jGHihOzuqQWpHRH45wUfBvlw54um4AB1VoYmFvvKf0DAVuYAefS3avJb/1H96MSag@vger.kernel.org, AJvYcCUxQ4Gdc1PN3G3blMTMAY9wICRUSppfL2oTCdCbwcSiVS3obnySeoblTOoNETXKR+sBMrnprdNEwhNH@vger.kernel.org, AJvYcCXsNy0w9JeS1I2HuJlbOsBKZKfAbCwN+oQ5vjTAdLgH+LO3a5H/4z1VENNYLjGCfetWIhRB@vger.kernel.org
X-Gm-Message-State: AOJu0YwUnwJA1kHioFcoc/5gtLEwNBVqa97Y+D5jdAHmZMWz8rE8vaZQ
	FrecFTryUCSDraFFM5WTB3A9h9RWO5+UjFLnUoyiYFF+wzBhLTbB
X-Gm-Gg: ASbGncvzJzxMHrS4fwgtZGxEcoVgL2ZLfalG9KcMu4nHBZqlX1DH92M7o3jbTQSoA+I
	mscHqmXqYvnfLoRx4/bvqFV+DtuD3BiegD48A6orpt0vZXy/K/U4vwbgaeHJcCd5iJgEfECPvrJ
	krsJGzMZO/tgvtLL8cNucO6qIPomrcvJyhYWdGZOySqmvCvinrX+xoAgctoxvcyXfp+Tb+pMvel
	ZamuMMCcAAHhb0eNyrGINS+hjyP5IikTDihUbieiZkONcIbnmZGMNfl5jYQR+E9tvN91dFmaMNI
	p4B4qVoqbkJHsMnEcR+INowfJzlDqEKrDDJo67MRXCWUpQQBZ03Zmzr+I46TQN1M2WzQKnMWEu5
	0ETCz6hhywpW3dmHqdd2kgGMZ5RMkIAo=
X-Google-Smtp-Source: AGHT+IHKXIDlBPVp3gyYgxOjFyUzKte/+Px4RacQpXr3c5UOtQ5sJmTvggKv28JeiPdTZfVVuzZ2eg==
X-Received: by 2002:a05:620a:17aa:b0:7c5:a41a:b1a with SMTP id af79cd13be357-7c927f6b4e5mr1830134985a.10.1745252857057;
        Mon, 21 Apr 2025 09:27:37 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c925a6eb31sm438947785a.3.2025.04.21.09.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 09:27:36 -0700 (PDT)
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfauth.phl.internal (Postfix) with ESMTP id D68B31200043;
	Mon, 21 Apr 2025 12:27:35 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Mon, 21 Apr 2025 12:27:35 -0400
X-ME-Sender: <xms:93EGaPl6BmgDg5HRVTlKEySE3NnVGFFCOwIj3_v1rNJpu3CQJ6K5Eg>
    <xme:93EGaC0uwLD5t9mIRSOE_S8HjDz1DQV3c15V-1MFrJQr4xI9-HF4I6GI5qPDpUoMO
    juS44Uj89gQYEOh-A>
X-ME-Received: <xmr:93EGaFpvLHpOndPFbORX2EV6IMd2U1UEDKtmyhUzyLci7s2P5hHfAqbqSDWQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgedufedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpeffvdehfeejjeeliefgtdduuddtjeejveeu
    veeugeefleefkeekuefgudeuhfefgeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpd
    hlfihnrdhnvghtpdhgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrsh
    honhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghn
    gheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohephe
    ekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegurghvihgughhofiesghhoohhg
    lhgvrdgtohhmpdhrtghpthhtoheprhhushhtqdhfohhrqdhlihhnuhigsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtoheprhgtuhesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehlihhnuhigqdgrrhgthhesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehllhhvmheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtth
    hopehlkhhmmheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehojhgvuggr
    sehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhgvgidrghgrhihnohhrsehgmhgrih
    hlrdgtohhm
X-ME-Proxy: <xmx:93EGaHmx0ei2frON30pFqG29hH6FxIISfKFIz4y0bydjQ2hjEbYuGg>
    <xmx:93EGaN0Ki0yvaurBA4rYcYRpOq27QuhicUvHpsftxbYlhIZ31G0jnw>
    <xmx:93EGaGvKmK1ylW0v-5qMLRuZMoRSF1lzFGDRVkp7ot-zrvvXP9n7FA>
    <xmx:93EGaBXjKwcfkYmoa2p6XPyJyMmxu_7rONV9PmDsnLPfsWF3VpWZbA>
    <xmx:93EGaM1awRHGn3vR7mMNQRnUEgoIxz259bYnVfYkzH9QAtkYQ1rePPx1>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Apr 2025 12:27:34 -0400 (EDT)
Date: Mon, 21 Apr 2025 09:27:28 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: David Gow <davidgow@google.com>
Cc: rust-for-linux@vger.kernel.org, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	llvm@lists.linux.dev, lkmm@lists.linux.dev,
	Miguel Ojeda <ojeda@kernel.org>,	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Andrea Parri <parri.andrea@gmail.com>,	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Nicholas Piggin <npiggin@gmail.com>,	David Howells <dhowells@redhat.com>,
	Jade Alglave <j.alglave@ucl.ac.uk>,	Luc Maranget <luc.maranget@inria.fr>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,	Daniel Lustig <dlustig@nvidia.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,	kent.overstreet@gmail.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, elver@google.com,
	Mark Rutland <mark.rutland@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,	Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Catalin Marinas <catalin.marinas@arm.com>,	torvalds@linux-foundation.org,
 linux-arm-kernel@lists.infradead.org,	linux-fsdevel@vger.kernel.org,
 Trevor Gross <tmgross@umich.edu>,	dakr@redhat.com,
 Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,	Albert Ou <aou@eecs.berkeley.edu>,
 linux-riscv@lists.infradead.org
Subject: Re: [RFC v2 00/13] LKMM *generic* atomics in Rust
Message-ID: <aAZx8GARiCW-pq9_@boqun-archlinux>
References: <20241101060237.1185533-1-boqun.feng@gmail.com>
 <CABVgOSm1cDcrsgYutooRG-ZLuzMypAO+ndNFyPy2w3_5B84TSQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABVgOSm1cDcrsgYutooRG-ZLuzMypAO+ndNFyPy2w3_5B84TSQ@mail.gmail.com>

On Sat, Nov 02, 2024 at 03:35:36PM +0800, David Gow wrote:
> On Fri, 1 Nov 2024 at 14:04, Boqun Feng <boqun.feng@gmail.com> wrote:
> >
> > Hi,
> >
> > This is another RFC version of LKMM atomics in Rust, you can find the
> > previous versions:
> >
> > v1: https://lore.kernel.org/rust-for-linux/20240612223025.1158537-1-boqun.feng@gmail.com/
> > wip: https://lore.kernel.org/rust-for-linux/20240322233838.868874-1-boqun.feng@gmail.com/
> >
> > I add a few more people Cced this time, so if you're curious about why
> > we choose to implement LKMM atomics instead of using the Rust ones, you
> > can find some explanation:
> >
> > * In my Kangrejos talk: https://lwn.net/Articles/993785/
> > * In Linus' email: https://lore.kernel.org/rust-for-linux/CAHk-=whkQk=zq5XiMcaU3xj4v69+jyoP-y6Sywhq-TvxSSvfEA@mail.gmail.com/
> >
> > This time, I try implementing a generic atomic type `Atomic<T>`, since
> > Benno and Gary suggested last time, and also Rust standard library is
> > also going to that direction [1].
> >
> > Honestly, a generic atomic type is still not quite necessary for myself,
> > but here are a few reasons that it's useful:
> >
> > *       It's useful for type alias, for example, if you have:
> >
> >         type c_long = isize;
> >
> >         Then `Atomic<c_clong>` and `Atomic<isize>` is the same type,
> >         this may make FFI code (mapping a C type to a Rust type or vice
> >         versa) more readable.
> >
> > *       In kernel, we sometimes switch atomic to percpu for better
> >         scalabity, percpu is naturally a generic type, because it can
> >         have data that is larger than machine word size. Making atomic
> >         generic ease the potential switching/refactoring.
> >
> > *       Generic atomics provide all the functionalities that non-generic
> >         atomics could have.
> >
> > That said, currently "generic" is limited to a few types: the type must
> > be the same size as atomic_t or atomic64_t, other than basic types, only
> > #[repr(<basic types>)] struct can be used in a `Atomic<T>`.
> >
> > Also this is not a full feature set patchset, things like different
> > arithmetic operations and bit operations are still missing, they can be
> > either future work or for future versions.
> >
> > I included an RCU pointer implementation as one example of the usage, so
> > a patch from Danilo is added, but I will drop it once his patch merged.
> >
> > This is based on today's rust-next, and I've run all kunit tests from
> > the doc test on x86, arm64 and riscv.
> >
> > Feedbacks and comments are welcome! Thanks.
> >
> > Regards,
> > Boqun
> >
> > [1]: https://github.com/rust-lang/rust/issues/130539
> >
> 
> Thanks, Boqun.
> 

Hi David,

> I played around a bit with porting the blk-mq atomic code to this. As
> neither an expert in Rust nor an expert in atomics, this is probably
> both non-idiomatic and wrong, but unlike the `core` atomics, it
> provides an Atomic::<u64> on 32-bit systems, which gets UML's 32-bit
> build working again.
> 
> Diff below -- I'm not likely to have much time to work on this again
> soon, so feel free to pick it up/fix it if it suits.
> 

Thanks. These look good to me, however, I think I prefer Gary's patch
for this:

	https://lore.kernel.org/lkml/20250219201602.1898383-4-gary@garyguo.net/

therefore, I won't take this into the next version. But thank you for
taking a look!

Regards,
Boqun

> Thanks,
> -- David
> 
> ---
> diff --git a/rust/kernel/block/mq/operations.rs
> b/rust/kernel/block/mq/operations.rs
> index 9ba7fdfeb4b2..822d64230e11 100644
> --- a/rust/kernel/block/mq/operations.rs
> +++ b/rust/kernel/block/mq/operations.rs
> @@ -11,7 +11,8 @@
>      error::{from_result, Result},
>      types::ARef,
>  };
> -use core::{marker::PhantomData, sync::atomic::AtomicU64,
> sync::atomic::Ordering};
> +use core::marker::PhantomData;
> +use kernel::sync::atomic::{Atomic, Relaxed};
> 
>  /// Implement this trait to interface blk-mq as block devices.
>  ///
> @@ -77,7 +78,7 @@ impl<T: Operations> OperationsVTable<T> {
>          let request = unsafe { &*(*bd).rq.cast::<Request<T>>() };
> 
>          // One refcount for the ARef, one for being in flight
> -        request.wrapper_ref().refcount().store(2, Ordering::Relaxed);
> +        request.wrapper_ref().refcount().store(2, Relaxed);
> 
>          // SAFETY:
>          //  - We own a refcount that we took above. We pass that to `ARef`.
> @@ -186,7 +187,7 @@ impl<T: Operations> OperationsVTable<T> {
> 
>              // SAFETY: The refcount field is allocated but not initialized, so
>              // it is valid for writes.
> -            unsafe {
> RequestDataWrapper::refcount_ptr(pdu.as_ptr()).write(AtomicU64::new(0))
> };
> +            unsafe {
> RequestDataWrapper::refcount_ptr(pdu.as_ptr()).write(Atomic::<u64>::new(0))
> };
> 
>              Ok(0)
>          })
> diff --git a/rust/kernel/block/mq/request.rs b/rust/kernel/block/mq/request.rs
> index 7943f43b9575..8d4060d65159 100644
> --- a/rust/kernel/block/mq/request.rs
> +++ b/rust/kernel/block/mq/request.rs
> @@ -13,8 +13,8 @@
>  use core::{
>      marker::PhantomData,
>      ptr::{addr_of_mut, NonNull},
> -    sync::atomic::{AtomicU64, Ordering},
>  };
> +use kernel::sync::atomic::{Atomic, Relaxed};
> 
>  /// A wrapper around a blk-mq [`struct request`]. This represents an
> IO request.
>  ///
> @@ -102,8 +102,7 @@ fn try_set_end(this: ARef<Self>) -> Result<*mut
> bindings::request, ARef<Self>> {
>          if let Err(_old) = this.wrapper_ref().refcount().compare_exchange(
>              2,
>              0,
> -            Ordering::Relaxed,
> -            Ordering::Relaxed,
> +            Relaxed
>          ) {
>              return Err(this);
>          }
> @@ -168,13 +167,13 @@ pub(crate) struct RequestDataWrapper {
>      /// - 0: The request is owned by C block layer.
>      /// - 1: The request is owned by Rust abstractions but there are
> no [`ARef`] references to it.
>      /// - 2+: There are [`ARef`] references to the request.
> -    refcount: AtomicU64,
> +    refcount: Atomic::<u64>,
>  }
> 
>  impl RequestDataWrapper {
>      /// Return a reference to the refcount of the request that is embedding
>      /// `self`.
> -    pub(crate) fn refcount(&self) -> &AtomicU64 {
> +    pub(crate) fn refcount(&self) -> &Atomic::<u64> {
>          &self.refcount
>      }
> 
> @@ -184,7 +183,7 @@ pub(crate) fn refcount(&self) -> &AtomicU64 {
>      /// # Safety
>      ///
>      /// - `this` must point to a live allocation of at least the size
> of `Self`.
> -    pub(crate) unsafe fn refcount_ptr(this: *mut Self) -> *mut AtomicU64 {
> +    pub(crate) unsafe fn refcount_ptr(this: *mut Self) -> *mut Atomic::<u64> {
>          // SAFETY: Because of the safety requirements of this function, the
>          // field projection is safe.
>          unsafe { addr_of_mut!((*this).refcount) }
> @@ -202,28 +201,22 @@ unsafe impl<T: Operations> Sync for Request<T> {}
> 
>  /// Store the result of `op(target.load())` in target, returning new value of
>  /// target.
> -fn atomic_relaxed_op_return(target: &AtomicU64, op: impl Fn(u64) ->
> u64) -> u64 {
> -    let old = target.fetch_update(Ordering::Relaxed,
> Ordering::Relaxed, |x| Some(op(x)));
> -
> -    // SAFETY: Because the operation passed to `fetch_update` above always
> -    // return `Some`, `old` will always be `Ok`.
> -    let old = unsafe { old.unwrap_unchecked() };
> -
> -    op(old)
> +fn atomic_relaxed_op_return(target: &Atomic::<u64>, op: impl Fn(u64)
> -> u64) -> u64 {
> +    let old = target.load(Relaxed);
> +    let new_val = op(old);
> +    target.compare_exchange(old, new_val, Relaxed);
> +    old
>  }
> 
>  /// Store the result of `op(target.load)` in `target` if `target.load() !=
>  /// pred`, returning [`true`] if the target was updated.
> -fn atomic_relaxed_op_unless(target: &AtomicU64, op: impl Fn(u64) ->
> u64, pred: u64) -> bool {
> -    target
> -        .fetch_update(Ordering::Relaxed, Ordering::Relaxed, |x| {
> -            if x == pred {
> -                None
> -            } else {
> -                Some(op(x))
> -            }
> -        })
> -        .is_ok()
> +fn atomic_relaxed_op_unless(target: &Atomic::<u64>, op: impl Fn(u64)
> -> u64, pred: u64) -> bool {
> +    let old = target.load(Relaxed);
> +    if old == pred {
> +        false
> +    } else {
> +        target.compare_exchange(old, op(old), Relaxed).is_ok()
> +    }
>  }
> 
>  // SAFETY: All instances of `Request<T>` are reference counted. This



