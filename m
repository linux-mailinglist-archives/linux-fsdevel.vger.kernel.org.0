Return-Path: <linux-fsdevel+bounces-1247-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C037D8485
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Oct 2023 16:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4329B2132B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Oct 2023 14:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1CF2EAEA;
	Thu, 26 Oct 2023 14:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kd20anX7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E022E64B;
	Thu, 26 Oct 2023 14:22:01 +0000 (UTC)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F2361A2;
	Thu, 26 Oct 2023 07:21:59 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-3b2ea7cca04so540401b6e.2;
        Thu, 26 Oct 2023 07:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698330118; x=1698934918; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dPjnRCIHnU5GzLqzoajHNOA82GCVgkswXThHFIsTG6Y=;
        b=kd20anX7cbOxyOppXyR5BC+9KPjBzdEZ0w3sNaj16Mgp/XItDFqSjOpmY+S/sqcEEU
         gkQj5rs1NrUgs/TarAz65JOstfpsNCMzkayeYg11NLQgQ3JJsIhbvcxD088VKo05/Dh6
         q6NVYjJiRkawp0KJvMpF4K7LzCuDMysNsip8WwNkwl99ekGU0hgTjpy0Kh569vCFIYCu
         VqOuTSE06Wluq9U3rm3rXEFwtyIJu1NyJHsl5SnfcI4N6cQYbwAx1b/mNC5pZasZUND7
         Oy/xGY6XG+paEzxoNrofhx3BmWpfXc6mnKS93ZKnR8bcPHY/eUOPinwQXWBmSG9CAZre
         f1Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698330119; x=1698934919;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dPjnRCIHnU5GzLqzoajHNOA82GCVgkswXThHFIsTG6Y=;
        b=ZCQT421Cu2mxQC8iNlY+N3RIVIap/r8m39VseKMENOFbcYGR1g+Xym4YY5ugFTpLkN
         6lX8FtbWiwSEQvAMkB1MEzdv/kj368Q6zDusdBZ9CDgL+phtbUHTTLR1HYNXhrsWyR0i
         GI/TNzY8Bp6ejsNZh76MAR2rKSQq+vLNn6f4M0E4+BeHhlU1BgXwc7S1mVscF4dVr3ZG
         gigytbYZwcTTfHU91/3I7jx3prtIsmdhENBi11pAlIQOA5JI2BrlPlzHkKPP/Yc5+Ona
         bIbbgwKJV6dIfirJAhWZMrg2ld1aQIUl6/eFFdWPndw6wR3xtuxoNqgm3azkFmV4wqhO
         q3PA==
X-Gm-Message-State: AOJu0YyPXLb+HhZDRjYuhJGAYQT/rnH90jHeP6XyKmmjDoBg8Bk0pNEF
	LlyPG1LvP5GQS8H4ZbJZ2/4o4hG17ZyLBg==
X-Google-Smtp-Source: AGHT+IGOORfdaN+ox+8dGnvK0hFjx7b4auYMD2QU259WIkEBZWSxO8HgvGRbr8aY5mL7QXVUpqpDYA==
X-Received: by 2002:a05:6808:e85:b0:3b2:d8cb:8e14 with SMTP id k5-20020a0568080e8500b003b2d8cb8e14mr24661826oil.28.1698330118606;
        Thu, 26 Oct 2023 07:21:58 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id g202-20020a8152d3000000b005a8a78fa9d2sm6085277ywb.17.2023.10.26.07.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 07:21:58 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailauth.nyi.internal (Postfix) with ESMTP id C94B027C005B;
	Thu, 26 Oct 2023 10:21:56 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 26 Oct 2023 10:21:56 -0400
X-ME-Sender: <xms:BHY6ZRm0CFDRawFDDqLMq38_zm2Qz4TaqVez6HlJZmIklCbNPXNF9w>
    <xme:BHY6Zc1AheJIzLy1eCZLvipKuXSNMJpy2pP_MLBUoZI7GFwy4_2aTEt8vF-rUDNwm
    zMxeY7HQ0G9c7VnxQ>
X-ME-Received: <xmr:BHY6ZXodUaXPHTT8AbNlXgE_ARzGijaca0D56FIcN3Og8YdXc0QqVDLH5A0>
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
X-ME-Proxy: <xmx:BHY6ZRmVYIFyK9hajxKhO7G9pXAEUukEHTKPJLJrKbGr4XnYCrC7Gw>
    <xmx:BHY6Zf21Yzn6zxmITRGYj8jw2L0D-XZgTjFr4KgYUzA2h1ai0BWaow>
    <xmx:BHY6ZQtnGLG5lML1wq6fh7r6fKIRvSH0eumBKpAZgiT44cC_7EZCtw>
    <xmx:BHY6ZUIHVJg3o5U07owCiEI9Tu0kYdhjSk0zcYaETeyW0rI6Nd5xiw>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Oct 2023 10:21:55 -0400 (EDT)
Date: Thu, 26 Oct 2023 07:21:53 -0700
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
Message-ID: <ZTp2AVY5twZOKEtX@Boquns-Mac-mini.home>
References: <20231025195339.1431894-1-boqun.feng@gmail.com>
 <20231026081345.GJ31411@noisy.programming.kicks-ass.net>
 <20231026113610.1425be1b@eugeo>
 <20231026111625.GK33965@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026111625.GK33965@noisy.programming.kicks-ass.net>

On Thu, Oct 26, 2023 at 01:16:25PM +0200, Peter Zijlstra wrote:
> On Thu, Oct 26, 2023 at 11:36:10AM +0100, Gary Guo wrote:
> 
> > There's two reasons that we are using volatile read/write as opposed to
> > relaxed atomic:
> > * Rust lacks volatile atomics at the moment. Non-volatile atomics are
> >   not sufficient because the compiler is allowed (although they
> >   currently don't) optimise atomics. If you have two adjacent relaxed
> >   loads, they could be merged into one.
> 
> Ah yes, that would be problematic, eg, if lifted out of a loop things
> could go sideways fast.
> 

Maybe we can workaround this limitation by using compiler barriers, i.e.

	compiler_fence(SeqCst);
	load(Relaxed);
	compiler_fence(Acquire);

this is slightly stronger than a volatile atomic.

> > * Atomics only works for integer types determined by the platform. On
> >   some 32-bit platforms you wouldn't be able to use 64-bit atomics at
> >   all, and on x86 you get less optimal sequence since volatile load is
> >   permitted to tear while atomic load needs to use LOCK CMPXCHG8B.
> 
> We only grudgingly allowed u64 READ_ONCE() on 32bit platforms because
> the fallout was too numerous to fix. Some of them are probably bugs.
> 
> Also, I think cmpxchg8b without lock prefix would be sufficient, but
> I've got too much of a head-ache to be sure. Worse is that we still
> support targets without cmpxchg8b.
> 
> It might be interesting to make the Rust side more strict in this regard
> and see where/when we run into trouble.
> 

Sounds good to me. If the compiler barriers make sense for now, then
we can do:

	pub unsafe fn read_once_usize(ptr: *const usize) -> usize {
		core::sync::atomic::compiler_fence(SeqCst);
		let r = unsafe { *ptr.cast::<AtomicUsize>() }.load(Relaxed);
		core::sync::atomic::compiler_fence(Acquire);
		r
	}

and if the other side (i.e. write) is also atomic (e.g. WRITE_ONCE()),
we don't have data race.

However, there are still cases where data races are ignored in C code,
for example inode::i_state: reads out of locks race with writes inside
locks, since writes are done by plain accesses. Nothing can be done to
fix that from Rust side only, and fixing the C side is a separate topic.

Thoughts?

Regards,
Boqun

> > * Atomics doesn't work for complex structs. Although I am not quite sure
> >   of the value of supporting it.
> 
> So on the C side we mandate the size is no larger than machine word,
> with the exception of the u64 on 32bit thing. We don't mandate strict
> integer types because things like pte_t are wrapper types.
> 
> 

