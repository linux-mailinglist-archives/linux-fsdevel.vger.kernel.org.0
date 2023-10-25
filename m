Return-Path: <linux-fsdevel+bounces-1214-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B10BB7D785A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Oct 2023 01:03:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EE302821CE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 23:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508BF374FB;
	Wed, 25 Oct 2023 23:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jXCfQ4Mk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A221E37159;
	Wed, 25 Oct 2023 23:03:34 +0000 (UTC)
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB3CBB;
	Wed, 25 Oct 2023 16:03:32 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-d81d09d883dso196429276.0;
        Wed, 25 Oct 2023 16:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698275012; x=1698879812; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=61JSi82jmprMEy2wjLB3v55zpvhJh5bM0LopIsNdZBI=;
        b=jXCfQ4MkgGZo0vVIaUkQGcBd881pWRRXMSrwxv/sCVleGYRejRAr87UbXvghsAPxHn
         l3i0yypXGre04zp0ZRfEVy8Fmc8+khED2wJDIgRWowq2mBfQWtUCkiJy7vgSsoXwnsso
         +za+35BYb2yeBGUzDoKB3VYs7+Oqpi80RryGtFaME5ulMd/9ByVYFJuEHC5X+yPIuVQl
         PYQypJ6mPdz9Y5NxBX4IjjIXv4/5pb9IuKIdaB+63q4gBhFvHZNxE7u/LdX3DW5G9Lmp
         In5Nzr2ce/PxOEnXw1ciR4y/5OXaqAd3dkwa3onqoe/gpI3hHwEbX8hiiOKN5bZBd8yH
         ZpHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698275012; x=1698879812;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=61JSi82jmprMEy2wjLB3v55zpvhJh5bM0LopIsNdZBI=;
        b=TnkJ7udCbkcQL66SWDbbdCgGzyb0kXp5ZGNPMVcAq+waQ4EcSnYfe+hD/NdB0L3R6G
         br+xf+bZcZ8SD57X6XJJTniSrrPNOUZlCxdMZHgtDHT98wlQ7pnYF48OI2BlEwOJ7+WP
         XgRprXnjiYPg3FNoiB+ZXeR2IbLXTbHwy3Xv3vb4v8vAIJkxr86oy8VS4C4MvNUNgzPr
         fD9MUEF45tXKjeFGWdLf4/awwYpmgRuopCCHLuEyNEu+EiE184FInLF/Gx8bGxaKt84V
         xBgOgFzJFHqBZHUP74LGxJncB6G3Mlhc+ecMdX8AkLpSIo33j8KIhXbobsOms97lF4Xx
         KyTQ==
X-Gm-Message-State: AOJu0Yy28fr0NaeZHBnDjSDR3ZI0ebm1vyD8KK3ADoM3Fkwa1BXqFd2R
	FrMQp9x4L84/E7BiMJ7W1eA=
X-Google-Smtp-Source: AGHT+IHzO+kZQE6t+6SokT/XjMJiUdNBfvOO3vMCUbf3gh0kZ9vOkSrhSIeP9wvnukh1IIjW55IOtw==
X-Received: by 2002:a25:cfc9:0:b0:da0:68a0:7cc6 with SMTP id f192-20020a25cfc9000000b00da068a07cc6mr3923847ybg.17.1698275011722;
        Wed, 25 Oct 2023 16:03:31 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id m10-20020a258c8a000000b00d9a4aad7f40sm4722392ybl.24.2023.10.25.16.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 16:03:31 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailauth.nyi.internal (Postfix) with ESMTP id 15D0227C005B;
	Wed, 25 Oct 2023 19:03:30 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 25 Oct 2023 19:03:30 -0400
X-ME-Sender: <xms:wZ45ZXhrsAQv86EZB20iNdVStWugNJLSiSs8UqlV8WOzkdpe3iscVg>
    <xme:wZ45ZUCuQeq1Fm7OMN92dciAz3VWEIKPi3isoU5Jy_HhjiwzD_MfmO3hxdl73AXqq
    a9wQ14E2glff84OkA>
X-ME-Received: <xmr:wZ45ZXEJ5dqgov2_NYos_099EEN_Matr_EBjJtuXtODoXPxOeC9MHdFg1eE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrledugdduiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtugfgjgesthekrodttddtjeenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeelgfegfeehtdeftedvjeffffdutddtvdduvddutdeigfffheehjeeutdeu
    keeuieenucffohhmrghinheprhhushhtqdhlrghnghdrohhrghenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgr
    uhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsoh
    hquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:wZ45ZUT3D_EgD3vYO4rUAkdJ_hj7h1AKSYudX2jVrHUrRPsJrL5ACg>
    <xmx:wZ45ZUwk5yKED0_O9mfPn1S6DyCpCrQEmzr1U-03ZkU6bGSLR_qkHw>
    <xmx:wZ45Za5Y_WVxM_VIkdzobstZ76uBfYKYIPpNf_yGiTzqLqsPJg-8jQ>
    <xmx:wp45ZVRw4Nc-eD9_tWFDJqqPeb_AOUnatoLTu8HK250Oa41qsU7erA>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Oct 2023 19:03:28 -0400 (EDT)
Date: Wed, 25 Oct 2023 16:02:45 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, llvm@lists.linux.dev,
	Miguel Ojeda <ojeda@kernel.org>,	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
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
	Nick Desaulniers <ndesaulniers@google.com>,	Tom Rix <trix@redhat.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, kent.overstreet@gmail.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, elver@google.com,
	Matthew Wilcox <willy@infradead.org>,	Dave Chinner <david@fromorbit.com>,
 linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] rust: types: Add read_once and write_once
Message-ID: <ZTmelWlSncdtExXp@boqun-archlinux>
References: <20231025195339.1431894-1-boqun.feng@gmail.com>
 <VEhpQqgTM0U-aNYRUQ89ICIHW9Eehr66yw92DrmBZcZOah2mLqlz24HxEwDwYPVDOnaigDiZDEVl5mWqZJxoAtRheqTMjzpxuTKe0sr1uZs=@proton.me>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <VEhpQqgTM0U-aNYRUQ89ICIHW9Eehr66yw92DrmBZcZOah2mLqlz24HxEwDwYPVDOnaigDiZDEVl5mWqZJxoAtRheqTMjzpxuTKe0sr1uZs=@proton.me>

On Wed, Oct 25, 2023 at 09:51:28PM +0000, Benno Lossin wrote:
> > In theory, `read_volatile` and `write_volatile` in Rust can have UB in
> > case of the data races [1]. However, kernel uses volatiles to implement
> 
> I would not write "In theory", but rather state that data races involving
> `read_volatile` is documented to still be UB.
> 

Good point.

> > READ_ONCE() and WRITE_ONCE(), and expects races on these marked accesses
> 
> Missing "`"?
> 

Yeah, but these are C macros, and here is the commit log, so I wasn't so
sure I want to add "`", but I guess it's good for consistency.

> > don't cause UB. And they are proven to have a lot of usages in kernel.
> > 
> > To close this gap, `read_once` and `write_once` are introduced, they
> > have the same semantics as `READ_ONCE` and `WRITE_ONCE` especially
> > regarding data races under the assumption that `read_volatile` and
> 
> I would separate implementation from specification. We specify
> `read_once` and `write_once` to have the same semantics as `READ_ONCE`
> and `WRITE_ONCE`. But we implement them using
> `read_volatile`/`write_volatile`, so we might still encounter UB, but it
> is still a sort of best effort. As soon as we have the actual thing in
> Rust, we will switch the implementation.
> 

Sounds good, I will use this in the next version.

> > `write_volatile` have the same behavior as a volatile pointer in C from
> > a compiler point of view.
> > 
> > Longer term solution is to work with Rust language side for a better way
> > to implement `read_once` and `write_once`. But so far, it should be good
> > enough.
> > 
> > Suggested-by: Alice Ryhl <aliceryhl@google.com>
> > Link: https://doc.rust-lang.org/std/ptr/fn.read_volatile.html#safety [1]
> > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> > ---
> > 
> > Notice I also make the primitives only work on T: Copy, since I don't
> > think Rust side and C side will use a !Copy type to communicate, but we
> > can always remove that constrait later.
> > 
> > 
> >  rust/kernel/prelude.rs |  2 ++
> >  rust/kernel/types.rs   | 43 ++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 45 insertions(+)
> > 
> > diff --git a/rust/kernel/prelude.rs b/rust/kernel/prelude.rs
> > index ae21600970b3..351ad182bc63 100644
> > --- a/rust/kernel/prelude.rs
> > +++ b/rust/kernel/prelude.rs
> > @@ -38,3 +38,5 @@
> >  pub use super::init::{InPlaceInit, Init, PinInit};
> > 
> >  pub use super::current;
> > +
> > +pub use super::types::{read_once, write_once};
> 
> Do we really want people to use these so often that they should be in
> the prelude?
> 

The reason I prelude them is because that `READ_ONCE` and `WRITE_ONCE`
have total ~7000 users in kernel, but now think about it, maybe it's
better not.

> Sure there will not really be any name conflicts, but I think an
> explicit import might make sense.
> 
> > diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
> > index d849e1979ac7..b0872f751f97 100644
> > --- a/rust/kernel/types.rs
> > +++ b/rust/kernel/types.rs
> 
> I don't think this should go into `types.rs`. But I do not have a good
> name for the new module.
> 

kernel::sync?

> > @@ -432,3 +432,46 @@ pub enum Either<L, R> {
> >      /// Constructs an instance of [`Either`] containing a value of type `R`.
> >      Right(R),
> >  }
> > +
> > +/// (Concurrent) Primitives to interact with C side, which are considered as marked access:
> > +///
> > +/// tools/memory-memory/Documentation/access-marking.txt
> > +
> 
> Accidental empty line? Or is this meant as a comment for both
> functions?
> 

Right, it's the documentation for both functions.

> > +/// The counter part of C `READ_ONCE()`.
> > +///
> > +/// The semantics is exactly the same as `READ_ONCE()`, especially when used for intentional data
> > +/// races.
> 
> It would be great if these semantics are either linked or spelled out
> here. Ideally both.
> 

Actually I haven't found any document about `READ_ONCE()` races with
writes is not UB: we do have document saying `READ_ONCE()` will disable
KCSAN checks, but no document says (explicitly) that it's not a UB.

> > +///
> > +/// # Safety
> > +///
> > +/// * `src` must be valid for reads.
> > +/// * `src` must be properly aligned.
> > +/// * `src` must point to a properly initialized value of value `T`.
> > +#[inline(always)]
> > +pub unsafe fn read_once<T: Copy>(src: *const T) -> T {
> 
> Why only `T: Copy`?
> 

I actually explained this above, after "---" of the commit log, but
maybe it's worth its own documentation? The reason that it only works
with `T: Copy`, is that these primitives should be mostly used for
C/Rust communication, and using a `T: !Copy` is probably wrong (or at
least complicated) for communication, since users need to handle which
one should be used after `read_once()`. This is in the same spirit as
`read_volatile` documentation:

```
Like read, read_volatile creates a bitwise copy of T, regardless of
whether T is Copy. If T is not Copy, using both the returned value and
the value at *src can violate memory safety. However, storing non-Copy
types in volatile memory is almost certainly incorrect.
```

I want to start with restrict usage.

> > +    // SAFETY: the read is valid because of the function's safety requirement, plus the assumption
> > +    // here is that 1) a volatile pointer dereference in C and 2) a `read_volatile` in Rust have the
> > +    // same semantics, so this function should have the same behavior as `READ_ONCE()` regarding
> > +    // data races.
> 
> I would explicitly state that we might have UB here due to data races.
> But that we have not seen any invalid codegen and thus assume there to

I'd rather not claim this (no invalid codegen), not because it's not
true, but because it's not under our control. We have written doc in
Rust says:

```
... so the precise semantics of what “volatile” means here is subject
to change over time. That being said, the semantics will almost always
end up pretty similar to C11’s definition of volatile.
```

, so we have some confidence to say `read_volatile` equals to a volatile
read, and `write_volatile` equals to a volatile write. Therefore, we can
assume they have the same behaviors as `READ_ONCE()` and `WRITE_ONCE()`,
but that's it. Going futher to talk about codegen means we have more
guarantee from Rust compiler implementation.

In other words, we are not saying racing `read_volatile`s don't have
UBs, we are saying racing `read_volatile`s behave the same as a volatile
read on UBs.

Regards,
Boqun

> be no UB (you might also want to write this in the commit message).
> 
> --
> Cheers,
> Benno
> 
> > +    unsafe { src.read_volatile() }
> > +}
> > +
> > +/// The counter part of C `WRITE_ONCE()`.
> > +///
> > +/// The semantics is exactly the same as `WRITE_ONCE()`, especially when used for intentional data
> > +/// races.
> > +///
> > +/// # Safety
> > +///
> > +/// * `dst` must be valid for writes.
> > +/// * `dst` must be properly aligned.
> > +#[inline(always)]
> > +pub unsafe fn write_once<T: Copy>(dst: *mut T, value: T) {
> > +    // SAFETY: the write is valid because of the function's safety requirement, plus the assumption
> > +    // here is that 1) a write to a volatile pointer dereference in C and 2) a `write_volatile` in
> > +    // Rust have the same semantics, so this function should have the same behavior as
> > +    // `WRITE_ONCE()` regarding data races.
> > +    unsafe {
> > +        core::ptr::write_volatile(dst, value);
> > +    }
> > +}
> > --
> > 2.41.0
> 

