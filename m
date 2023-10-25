Return-Path: <linux-fsdevel+bounces-1211-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F07257D7717
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 23:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F17F5B21245
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 21:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6CD935888;
	Wed, 25 Oct 2023 21:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="iRbIVns0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A0DC8C0
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Oct 2023 21:51:38 +0000 (UTC)
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCFF6192;
	Wed, 25 Oct 2023 14:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1698270694; x=1698529894;
	bh=+mIMtJy5g/3pP0bfV4kNM3vtmyjGkqlYbw5iT4J0tl8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=iRbIVns0Dvfe0uo4iphsA8sVRHbI3fybSM6Y3MW1meOEMhMW3SdN9huZmKHpXxX2A
	 oAK5DOYYJZdr4M/kC5NJ+cqGDRzHm0csHrZ4b6h6eWh/WH8RjXWL5YFH4eqIncxgIJ
	 EDkHDM3DRwaW+RxWzN2/5QYQpFRbt83ITw/C427DwracoFThk79D0EYG8u3lo7UpQs
	 FS7NOh7g+xWsN0rozPH61QKY3ppBd5gPVD4R5zuO4AN2dgdGKfGi97VAyLAaXJOs9/
	 9+4MysEB0mgU9ipH7wCJyhJkoNKt1bVhQErSz7YIkKG7dA/2UiizCzBeuMdLrL5lPb
	 nu1WNLGiBcOsQ==
Date: Wed, 25 Oct 2023 21:51:28 +0000
To: Boqun Feng <boqun.feng@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, llvm@lists.linux.dev, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, Alan Stern <stern@rowland.harvard.edu>, Andrea Parri <parri.andrea@gmail.com>, Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, "Paul E. McKenney" <paulmck@kernel.org>, Akira Yokosawa <akiyks@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, Joel Fernandes <joel@joelfernandes.org>, Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>, Alexander Viro
	<viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, kent.overstreet@gmail.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, elver@google.com, Matthew Wilcox <willy@infradead.org>, Dave Chinner <david@fromorbit.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] rust: types: Add read_once and write_once
Message-ID: <VEhpQqgTM0U-aNYRUQ89ICIHW9Eehr66yw92DrmBZcZOah2mLqlz24HxEwDwYPVDOnaigDiZDEVl5mWqZJxoAtRheqTMjzpxuTKe0sr1uZs=@proton.me>
In-Reply-To: <20231025195339.1431894-1-boqun.feng@gmail.com>
References: <20231025195339.1431894-1-boqun.feng@gmail.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

> In theory, `read_volatile` and `write_volatile` in Rust can have UB in
> case of the data races [1]. However, kernel uses volatiles to implement

I would not write "In theory", but rather state that data races involving
`read_volatile` is documented to still be UB.

> READ_ONCE() and WRITE_ONCE(), and expects races on these marked accesses

Missing "`"?

> don't cause UB. And they are proven to have a lot of usages in kernel.
>=20
> To close this gap, `read_once` and `write_once` are introduced, they
> have the same semantics as `READ_ONCE` and `WRITE_ONCE` especially
> regarding data races under the assumption that `read_volatile` and

I would separate implementation from specification. We specify
`read_once` and `write_once` to have the same semantics as `READ_ONCE`
and `WRITE_ONCE`. But we implement them using
`read_volatile`/`write_volatile`, so we might still encounter UB, but it
is still a sort of best effort. As soon as we have the actual thing in
Rust, we will switch the implementation.

> `write_volatile` have the same behavior as a volatile pointer in C from
> a compiler point of view.
>=20
> Longer term solution is to work with Rust language side for a better way
> to implement `read_once` and `write_once`. But so far, it should be good
> enough.
>=20
> Suggested-by: Alice Ryhl <aliceryhl@google.com>
> Link: https://doc.rust-lang.org/std/ptr/fn.read_volatile.html#safety [1]
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> ---
>=20
> Notice I also make the primitives only work on T: Copy, since I don't
> think Rust side and C side will use a !Copy type to communicate, but we
> can always remove that constrait later.
>=20
>=20
>  rust/kernel/prelude.rs |  2 ++
>  rust/kernel/types.rs   | 43 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 45 insertions(+)
>=20
> diff --git a/rust/kernel/prelude.rs b/rust/kernel/prelude.rs
> index ae21600970b3..351ad182bc63 100644
> --- a/rust/kernel/prelude.rs
> +++ b/rust/kernel/prelude.rs
> @@ -38,3 +38,5 @@
>  pub use super::init::{InPlaceInit, Init, PinInit};
>=20
>  pub use super::current;
> +
> +pub use super::types::{read_once, write_once};

Do we really want people to use these so often that they should be in
the prelude?

Sure there will not really be any name conflicts, but I think an
explicit import might make sense.

> diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
> index d849e1979ac7..b0872f751f97 100644
> --- a/rust/kernel/types.rs
> +++ b/rust/kernel/types.rs

I don't think this should go into `types.rs`. But I do not have a good
name for the new module.

> @@ -432,3 +432,46 @@ pub enum Either<L, R> {
>      /// Constructs an instance of [`Either`] containing a value of type =
`R`.
>      Right(R),
>  }
> +
> +/// (Concurrent) Primitives to interact with C side, which are considere=
d as marked access:
> +///
> +/// tools/memory-memory/Documentation/access-marking.txt
> +

Accidental empty line? Or is this meant as a comment for both
functions?

> +/// The counter part of C `READ_ONCE()`.
> +///
> +/// The semantics is exactly the same as `READ_ONCE()`, especially when =
used for intentional data
> +/// races.

It would be great if these semantics are either linked or spelled out
here. Ideally both.

> +///
> +/// # Safety
> +///
> +/// * `src` must be valid for reads.
> +/// * `src` must be properly aligned.
> +/// * `src` must point to a properly initialized value of value `T`.
> +#[inline(always)]
> +pub unsafe fn read_once<T: Copy>(src: *const T) -> T {

Why only `T: Copy`?

> +    // SAFETY: the read is valid because of the function's safety requir=
ement, plus the assumption
> +    // here is that 1) a volatile pointer dereference in C and 2) a `rea=
d_volatile` in Rust have the
> +    // same semantics, so this function should have the same behavior as=
 `READ_ONCE()` regarding
> +    // data races.

I would explicitly state that we might have UB here due to data races.
But that we have not seen any invalid codegen and thus assume there to
be no UB (you might also want to write this in the commit message).

--
Cheers,
Benno

> +    unsafe { src.read_volatile() }
> +}
> +
> +/// The counter part of C `WRITE_ONCE()`.
> +///
> +/// The semantics is exactly the same as `WRITE_ONCE()`, especially when=
 used for intentional data
> +/// races.
> +///
> +/// # Safety
> +///
> +/// * `dst` must be valid for writes.
> +/// * `dst` must be properly aligned.
> +#[inline(always)]
> +pub unsafe fn write_once<T: Copy>(dst: *mut T, value: T) {
> +    // SAFETY: the write is valid because of the function's safety requi=
rement, plus the assumption
> +    // here is that 1) a write to a volatile pointer dereference in C an=
d 2) a `write_volatile` in
> +    // Rust have the same semantics, so this function should have the sa=
me behavior as
> +    // `WRITE_ONCE()` regarding data races.
> +    unsafe {
> +        core::ptr::write_volatile(dst, value);
> +    }
> +}
> --
> 2.41.0

