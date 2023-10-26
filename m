Return-Path: <linux-fsdevel+bounces-1248-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 612107D848B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Oct 2023 16:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 910EA1C20F2F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Oct 2023 14:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891182EAEC;
	Thu, 26 Oct 2023 14:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qsort+ud"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D362E65D;
	Thu, 26 Oct 2023 14:23:26 +0000 (UTC)
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD82C1A2;
	Thu, 26 Oct 2023 07:23:24 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-d9ca471cf3aso675304276.2;
        Thu, 26 Oct 2023 07:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698330204; x=1698935004; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qmQ12llQk3IZSo1cj6ehbveeVOkoR+zL/LYihr+kgBA=;
        b=Qsort+udxHwK3UZgVeua4g2+z/2T7uXFTeokbC0yqQCMMJ7VGRZBwzf2xib7SljoCK
         lYYS0JcQgOQYLj7JHxSkzFfUTf2OEDKLwJFYYUu8Ti4mTiFm4S30XWJi7TaCvngrIxZ1
         sx9m+lKb7U+nCWnB0EG/PSSKhepWoxwN5pe8mdjevGLr9MbzgErufgIh756mQzFy/Ijd
         BIpK692GUs6RpLRGNc2IQifyE3TNpb1wRUexyDoDF8oCw/wPoEvAXdquJ3fie+2Phmes
         RAtBNHtuRmVIf4j99MXmdHpUIZc+hiewP4IQ66XOklNa30w2hQ1xi4oGwJFjNSA8iUXq
         IELQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698330204; x=1698935004;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qmQ12llQk3IZSo1cj6ehbveeVOkoR+zL/LYihr+kgBA=;
        b=fEX5Gs9VeLWZWeJp1zS2Ie9G5boLeu7PGgsnQ4q2GoO+p2vhL71H4O40PeFwscvfGI
         UoqMMfQsFC+Bhs4dNJzPNusfBh780TuS6ymJDNW8ks34Z1GnJW5OUmBy9i7iW3WQ4NjW
         IRMpmH+/XtURG/ehMQfwg8nfM7Z5/+2DePFJ3Hr5ex4Ukr6bKqOjOzkjdhe0dvyveN2V
         Vxu8/TUgsc5DTtTIxOXFYNirFqiD/XLoswBQs441ZIrWVXTRZWi53otCcfZj5T1kjZEZ
         x+I5rurZAIy/2AhgLMleIUp6e6AtVO9vinWxOuaQt6Jmo5XAd9h/Ah44y/syCrhpe3Qe
         gOTQ==
X-Gm-Message-State: AOJu0YwDBRplwBeWLsD7rc0yHGVdqGXr9JX4SnmsBHvbOlmhNYp/Mq4u
	BLP/55kMuqJCT0wWOVsTgxw=
X-Google-Smtp-Source: AGHT+IH1fP8m0ZfURzq/DYK3dN0nkQ4K1zNYSBgKw8eHs+E9drhtEjW1W3aytItYucb04Mw1q71plA==
X-Received: by 2002:a25:aca7:0:b0:d9c:fd8d:833a with SMTP id x39-20020a25aca7000000b00d9cfd8d833amr19746794ybi.59.1698330204037;
        Thu, 26 Oct 2023 07:23:24 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id 205-20020a2505d6000000b00d814d8dfd69sm5314546ybf.27.2023.10.26.07.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 07:23:23 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailauth.nyi.internal (Postfix) with ESMTP id A68B127C005B;
	Thu, 26 Oct 2023 10:23:22 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 26 Oct 2023 10:23:22 -0400
X-ME-Sender: <xms:WnY6ZXn4lB9TVEVhjEs-iMQ9zSHVUF7Brqfa3pebbcmICW4qc1-epA>
    <xme:WnY6Za2dLI94QaOdsGzzxDYwgH4jbKkYMI2jLX_H5AqoCUD_hHvTwuPsl-uc2J0Yv
    ZV5GmpIhA6KvHlGUw>
X-ME-Received: <xmr:WnY6ZdrohGQwXZCTCBX8y3wgWXGPxQW0ied1kmNm-PKN5gslsVoPX1-kodA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrledvgdejiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveeiudff
    iedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    hoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieeg
    qddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigi
    hmvgdrnhgrmhgv
X-ME-Proxy: <xmx:WnY6Zflspi88sF3fgu01H4l2D0B37XPK_uXRLMaRv-2LcyiuWY0dHw>
    <xmx:WnY6ZV3gk2_I24ou6ijCgALyVCEzmtKZEcc60DuXfHxUIXZDP2aIHg>
    <xmx:WnY6ZeuxLFr0iJhu9Gs7yct3EP3TeJ3owikW4OPYePen44xv2Z0Q8w>
    <xmx:WnY6ZSK-H_V8jB0yAOJA6Ttrl4PfsNmA3jL339jK2qrz7MGEyht4JQ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Oct 2023 10:23:21 -0400 (EDT)
Date: Thu, 26 Oct 2023 07:23:21 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Gary Guo <gary@garyguo.net>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	llvm@lists.linux.dev, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Andrea Parri <parri.andrea@gmail.com>,	Will Deacon <will@kernel.org>,
 Nicholas Piggin <npiggin@gmail.com>,	David Howells <dhowells@redhat.com>,
	Jade Alglave <j.alglave@ucl.ac.uk>,	Luc Maranget <luc.maranget@inria.fr>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,	Daniel Lustig <dlustig@nvidia.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,	Tom Rix <trix@redhat.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, kent.overstreet@gmail.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, elver@google.com,
	Matthew Wilcox <willy@infradead.org>,	Dave Chinner <david@fromorbit.com>,
 linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC] rust: types: Add read_once and write_once
Message-ID: <ZTp2WVlMxqmlC4Rb@Boquns-Mac-mini.home>
References: <20231025195339.1431894-1-boqun.feng@gmail.com>
 <20231026081345.GJ31411@noisy.programming.kicks-ass.net>
 <20231026113610.1425be1b@eugeo>
 <20231026111625.GK33965@noisy.programming.kicks-ass.net>
 <ZTp2AVY5twZOKEtX@Boquns-Mac-mini.home>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTp2AVY5twZOKEtX@Boquns-Mac-mini.home>

On Thu, Oct 26, 2023 at 07:21:53AM -0700, Boqun Feng wrote:
> On Thu, Oct 26, 2023 at 01:16:25PM +0200, Peter Zijlstra wrote:
> > On Thu, Oct 26, 2023 at 11:36:10AM +0100, Gary Guo wrote:
> > 
> > > There's two reasons that we are using volatile read/write as opposed to
> > > relaxed atomic:
> > > * Rust lacks volatile atomics at the moment. Non-volatile atomics are
> > >   not sufficient because the compiler is allowed (although they
> > >   currently don't) optimise atomics. If you have two adjacent relaxed
> > >   loads, they could be merged into one.
> > 
> > Ah yes, that would be problematic, eg, if lifted out of a loop things
> > could go sideways fast.
> > 
> 
> Maybe we can workaround this limitation by using compiler barriers, i.e.
> 
> 	compiler_fence(SeqCst);
> 	load(Relaxed);
> 	compiler_fence(Acquire);
> 
> this is slightly stronger than a volatile atomic.
> 
> > > * Atomics only works for integer types determined by the platform. On
> > >   some 32-bit platforms you wouldn't be able to use 64-bit atomics at
> > >   all, and on x86 you get less optimal sequence since volatile load is
> > >   permitted to tear while atomic load needs to use LOCK CMPXCHG8B.
> > 
> > We only grudgingly allowed u64 READ_ONCE() on 32bit platforms because
> > the fallout was too numerous to fix. Some of them are probably bugs.
> > 
> > Also, I think cmpxchg8b without lock prefix would be sufficient, but
> > I've got too much of a head-ache to be sure. Worse is that we still
> > support targets without cmpxchg8b.
> > 
> > It might be interesting to make the Rust side more strict in this regard
> > and see where/when we run into trouble.
> > 
> 
> Sounds good to me. If the compiler barriers make sense for now, then
> we can do:
> 
> 	pub unsafe fn read_once_usize(ptr: *const usize) -> usize {
> 		core::sync::atomic::compiler_fence(SeqCst);
> 		let r = unsafe { *ptr.cast::<AtomicUsize>() }.load(Relaxed);
> 		core::sync::atomic::compiler_fence(Acquire);
> 		r
> 	}
> 

I forgot to mention, this can also resolve the comments from Marco, i.e.
switching implemention to Acquire if ARM64 & LTO.

Regards,
Boqun

> and if the other side (i.e. write) is also atomic (e.g. WRITE_ONCE()),
> we don't have data race.
> 
> However, there are still cases where data races are ignored in C code,
> for example inode::i_state: reads out of locks race with writes inside
> locks, since writes are done by plain accesses. Nothing can be done to
> fix that from Rust side only, and fixing the C side is a separate topic.
> 
> Thoughts?
> 
> Regards,
> Boqun
> 
> > > * Atomics doesn't work for complex structs. Although I am not quite sure
> > >   of the value of supporting it.
> > 
> > So on the C side we mandate the size is no larger than machine word,
> > with the exception of the u64 on 32bit thing. We don't mandate strict
> > integer types because things like pte_t are wrapper types.
> > 
> > 

