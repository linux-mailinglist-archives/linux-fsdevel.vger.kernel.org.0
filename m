Return-Path: <linux-fsdevel+bounces-70145-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A1FAEC926CD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 16:11:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 490CF4E2095
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 15:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0768E309DC5;
	Fri, 28 Nov 2025 15:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="hHCTDtIb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sender3-pp-f112.zoho.com (sender3-pp-f112.zoho.com [136.143.184.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D273127F16C;
	Fri, 28 Nov 2025 15:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764342702; cv=pass; b=BdGjkmbyqe1yfNnCJ5vQ1idBpYdVzEkLU0tougSeDQcHt5qJBcnFqPMfsCLrM8wcZVmxhytivOTeSvMuyVevitHQljEeA8lt2+CFzZj3L15/6kEubhaWZ46nzWXt/pQdOcZBz7rwV0bCBHEbAKVSxY03XZRatMWyYgQTuw8AenQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764342702; c=relaxed/simple;
	bh=wYu86pI3gfsKzzNd6+8gThCWRG5HoAnZPy5f/sf/MNo=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=dG07hKUWA7aqPO+kXHpfYpwtpEtRI6oDkInCmo9CSq5Ixtzdwj++dmtbvvA85DIagV2XtH22XCAh0u0a4Y+DsYMDJURxGV6L1MejK9zXfgrsFqbQC2K/gocNTOr15+LqgHGNbhpEUka4WDEmY7bJOQO/6SegYiWpuoXY7x+sD4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=hHCTDtIb; arc=pass smtp.client-ip=136.143.184.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1764342602; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=gZcBbihTsSkA4tWyQpixd48pmDK3jY0gszTIO+4gFvcsMy0UZMKqmD7LslLMXHrjcApQ5r1Byqs9cXcbEfUhcKRvoALAbJcd9xn1nxJwO8Upvru2QlQrneg/UWH+TtFaNQ7WPPzndyORrhEiS+yuOnEygLM3anR6Lknf2pxtYU4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1764342602; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=wCxJ4NzqKxdh4wewyY3/df10XmJJltVNgKThcSpiCYU=; 
	b=N/zTCn5KT81zuQCqyf8u1fsZRxnQ+GudJczU1+g0wVFcFFGzXo2ehUOCWJwzzdvIigGzXokygwbMLCmSJ+kwRrbB/eSeJ4Psye0cTo2CYuVe+NuIeiNQtWi0gX9lVEuGox0tILEumXrW8JGk5jUsVLhKtGfeSC+Rl4wxjp6KBSM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1764342602;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=wCxJ4NzqKxdh4wewyY3/df10XmJJltVNgKThcSpiCYU=;
	b=hHCTDtIbHO/FdiDg6NPihWgzooJflCTGzw830CNOzCDyMrHHH30lbnbg3aKYA0TC
	qyh9eX0r+PCEIPrGscLNU+69Mvhl2i66FvJsMbLvxtBtdjggDGIllYPo5QZpyH1+liE
	fr9ELYpVmojzN8i3l4gOifnmZArQdy+Hv5cWlz0g=
Received: by mx.zohomail.com with SMTPS id 176434259940774.21658293213216;
	Fri, 28 Nov 2025 07:09:59 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v13 1/4] rust: types: Add Ownable/Owned types
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20251117-unique-ref-v13-1-b5b243df1250@pm.me>
Date: Fri, 28 Nov 2025 12:09:38 -0300
Cc: Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Benno Lossin <lossin@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dave Ertman <david.m.ertman@intel.com>,
 Ira Weiny <ira.weiny@intel.com>,
 Leon Romanovsky <leon@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Viresh Kumar <vireshk@kernel.org>,
 Nishanth Menon <nm@ti.com>,
 Stephen Boyd <sboyd@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 =?utf-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Paul Moore <paul@paul-moore.com>,
 Serge Hallyn <sergeh@kernel.org>,
 Asahi Lina <lina+kernel@asahilina.net>,
 rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org,
 dri-devel@lists.freedesktop.org,
 linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org,
 linux-pm@vger.kernel.org,
 linux-pci@vger.kernel.org,
 linux-security-module@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <C95B13F7-B3F5-4508-A862-EAD22EF56FE2@collabora.com>
References: <20251117-unique-ref-v13-0-b5b243df1250@pm.me>
 <20251117-unique-ref-v13-1-b5b243df1250@pm.me>
To: Oliver Mangold <oliver.mangold@pm.me>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External

Hi Oliver,

> On 17 Nov 2025, at 07:07, Oliver Mangold <oliver.mangold@pm.me> wrote:
>=20
> From: Asahi Lina <lina+kernel@asahilina.net>
>=20
> By analogy to `AlwaysRefCounted` and `ARef`, an `Ownable` type is a
> (typically C FFI) type that *may* be owned by Rust, but need not be. =
Unlike
> `AlwaysRefCounted`, this mechanism expects the reference to be unique
> within Rust, and does not allow cloning.
>=20
> Conceptually, this is similar to a `KBox<T>`, except that it delegates
> resource management to the `T` instead of using a generic allocator.
>=20
> [ om:
>  - Split code into separate file and `pub use` it from types.rs.
>  - Make from_raw() and into_raw() public.
>  - Remove OwnableMut, and make DerefMut dependent on Unpin instead.
>  - Usage example/doctest for Ownable/Owned.
>  - Fixes to documentation and commit message.
> ]
>=20
> Link: =
https://lore.kernel.org/all/20250202-rust-page-v1-1-e3170d7fe55e@asahilina=
.net/
> Signed-off-by: Asahi Lina <lina+kernel@asahilina.net>
> Co-developed-by: Oliver Mangold <oliver.mangold@pm.me>
> Signed-off-by: Oliver Mangold <oliver.mangold@pm.me>
> Co-developed-by: Andreas Hindborg <a.hindborg@kernel.org>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
> ---
> rust/kernel/lib.rs       |   1 +
> rust/kernel/owned.rs     | 195 =
+++++++++++++++++++++++++++++++++++++++++++++++
> rust/kernel/sync/aref.rs |   5 ++
> rust/kernel/types.rs     |   2 +
> 4 files changed, 203 insertions(+)
>=20
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index 3dd7bebe7888..e0ee04330dd0 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -112,6 +112,7 @@
> pub mod of;
> #[cfg(CONFIG_PM_OPP)]
> pub mod opp;
> +pub mod owned;
> pub mod page;
> #[cfg(CONFIG_PCI)]
> pub mod pci;
> diff --git a/rust/kernel/owned.rs b/rust/kernel/owned.rs
> new file mode 100644
> index 000000000000..a2cdd2cb8a10
> --- /dev/null
> +++ b/rust/kernel/owned.rs
> @@ -0,0 +1,195 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Unique owned pointer types for objects with custom drop logic.
> +//!
> +//! These pointer types are useful for C-allocated objects which by =
API-contract
> +//! are owned by Rust, but need to be freed through the C API.
> +
> +use core::{
> +    mem::ManuallyDrop,
> +    ops::{Deref, DerefMut},
> +    pin::Pin,
> +    ptr::NonNull,
> +};
> +
> +/// Type allocated and destroyed on the C side, but owned by Rust.
> +///
> +/// Implementing this trait allows types to be referenced via the =
[`Owned<Self>`] pointer type. This
> +/// is useful when it is desirable to tie the lifetime of the =
reference to an owned object, rather
> +/// than pass around a bare reference. [`Ownable`] types can define =
custom drop logic that is
> +/// executed when the owned reference [`Owned<Self>`] pointing to the =
object is dropped.
> +///
> +/// Note: The underlying object is not required to provide internal =
reference counting, because it
> +/// represents a unique, owned reference. If reference counting (on =
the Rust side) is required,
> +/// [`AlwaysRefCounted`](crate::types::AlwaysRefCounted) should be =
implemented.
> +///
> +/// # Safety
> +///
> +/// Implementers must ensure that the [`release()`](Self::release) =
function frees the underlying
> +/// object in the correct way for a valid, owned object of this type.
> +///
> +/// # Examples
> +///
> +/// A minimal example implementation of [`Ownable`] and its usage =
with [`Owned`] looks like this:
> +///
> +/// ```
> +/// # #![expect(clippy::disallowed_names)]
> +/// # use core::cell::Cell;
> +/// # use core::ptr::NonNull;
> +/// # use kernel::sync::global_lock;
> +/// # use kernel::alloc::{flags, kbox::KBox, AllocError};
> +/// # use kernel::types::{Owned, Ownable};
> +///
> +/// // Let's count the allocations to see if freeing works.
> +/// kernel::sync::global_lock! {
> +///     // SAFETY: we call `init()` right below, before doing =
anything else.
> +///     unsafe(uninit) static FOO_ALLOC_COUNT: Mutex<usize> =3D 0;
> +/// }
> +/// // SAFETY: We call `init()` only once, here.
> +/// unsafe { FOO_ALLOC_COUNT.init() };
> +///
> +/// struct Foo {
> +/// }

nit: this can be simply:

struct Foo;

> +///
> +/// impl Foo {
> +///     fn new() -> Result<Owned<Self>, AllocError> {
> +///         // We are just using a `KBox` here to handle the actual =
allocation, as our `Foo` is
> +///         // not actually a C-allocated object.
> +///         let result =3D KBox::new(
> +///             Foo {},
> +///             flags::GFP_KERNEL,
> +///         )?;
> +///         let result =3D NonNull::new(KBox::into_raw(result))
> +///             .expect("Raw pointer to newly allocation KBox is =
null, this should never happen.");
> +///         // Count new allocation
> +///         *FOO_ALLOC_COUNT.lock() +=3D 1;
> +///         // SAFETY: We just allocated the `Self`, thus it is valid =
and there cannot be any other
> +///         // Rust references. Calling `into_raw()` makes us =
responsible for ownership and we won't
> +///         // use the raw pointer anymore. Thus we can transfer =
ownership to the `Owned`.
> +///         Ok(unsafe { Owned::from_raw(result) })
> +///     }
> +/// }
> +///
> +/// // SAFETY: What out `release()` function does is safe of any =
valid `Self`.
> +/// unsafe impl Ownable for Foo {
> +///     unsafe fn release(this: NonNull<Self>) {
> +///         // The `Foo` will be dropped when `KBox` goes out of =
scope.
> +///         // SAFETY: The [`KBox<Self>`] is still alive. We can pass =
ownership to the [`KBox`], as
> +///         // by requirement on calling this function, the `Self` =
will no longer be used by the
> +///         // caller.
> +///         unsafe { KBox::from_raw(this.as_ptr()) };
> +///         // Count released allocation
> +///         *FOO_ALLOC_COUNT.lock() -=3D 1;
> +///     }
> +/// }
> +///
> +/// {
> +///    let foo =3D Foo::new().expect("Failed to allocate a Foo. This =
shouldn't happen");
> +///    assert!(*FOO_ALLOC_COUNT.lock() =3D=3D 1);
> +/// }
> +/// // `foo` is out of scope now, so we expect no live allocations.
> +/// assert!(*FOO_ALLOC_COUNT.lock() =3D=3D 0);
> +/// ```
> +pub unsafe trait Ownable {
> +    /// Releases the object.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Callers must ensure that:
> +    /// - `this` points to a valid `Self`.
> +    /// - `*this` is no longer used after this call.
> +    unsafe fn release(this: NonNull<Self>);
> +}
> +
> +/// An owned reference to an owned `T`.
> +///
> +/// The [`Ownable`] is automatically freed or released when an =
instance of [`Owned`] is
> +/// dropped.
> +///
> +/// # Invariants
> +///
> +/// - The [`Owned<T>`] has exclusive access to the instance of `T`.
> +/// - The instance of `T` will stay alive at least as long as the =
[`Owned<T>`] is alive.
> +pub struct Owned<T: Ownable> {
> +    ptr: NonNull<T>,
> +}
> +
> +// SAFETY: It is safe to send an [`Owned<T>`] to another thread when =
the underlying `T` is [`Send`],
> +// because of the ownership invariant. Sending an [`Owned<T>`] is =
equivalent to sending the `T`.
> +unsafe impl<T: Ownable + Send> Send for Owned<T> {}
> +
> +// SAFETY: It is safe to send [`&Owned<T>`] to another thread when =
the underlying `T` is [`Sync`],
> +// because of the ownership invariant. Sending an [`&Owned<T>`] is =
equivalent to sending the `&T`.
> +unsafe impl<T: Ownable + Sync> Sync for Owned<T> {}
> +
> +impl<T: Ownable> Owned<T> {

Can you make sure that impl Owned<T> follows the struct declaration?

IOW: please move the Send and Sync impls to be after the impl above.

> +    /// Creates a new instance of [`Owned`].
> +    ///
> +    /// It takes over ownership of the underlying object.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Callers must ensure that:
> +    /// - `ptr` points to a valid instance of `T`.
> +    /// - Ownership of the underlying `T` can be transferred to the =
`Self<T>` (i.e. operations
> +    ///   which require ownership will be safe).
> +    /// - No other Rust references to the underlying object exist. =
This implies that the underlying
> +    ///   object is not accessed through `ptr` anymore after the =
function call (at least until the
> +    ///   the `Self<T>` is dropped.

It looks like this can be written more succinctly as:

"This implies that the underlying object is not accessed through `ptr` =
anymore until `Self<T>` is dropped."

> +    /// - The C code follows the usual shared reference requirements. =
That is, the kernel will never
> +    ///   mutate or free the underlying object (excluding interior =
mutability that follows the usual
> +    ///   rules) while Rust owns it.
> +    /// - In case `T` implements [`Unpin`] the previous requirement =
is extended from shared to
> +    ///   mutable reference requirements. That is, the kernel will =
not mutate or free the underlying
> +    ///   object and is okay with it being modified by Rust code.
> +    pub unsafe fn from_raw(ptr: NonNull<T>) -> Self {
> +        Self {
> +            ptr,
> +        }
> +    }
> +
> +    /// Consumes the [`Owned`], returning a raw pointer.
> +    ///
> +    /// This function does not actually relinquish ownership of the =
object. After calling this
> +    /// function, the caller is responsible for ownership previously =
managed
> +    /// by the [`Owned`].
> +    pub fn into_raw(me: Self) -> NonNull<T> {
> +        ManuallyDrop::new(me).ptr
> +    }
> +
> +    /// Get a pinned mutable reference to the data owned by this =
`Owned<T>`.
> +    pub fn get_pin_mut(&mut self) -> Pin<&mut T> {
> +        // SAFETY: The type invariants guarantee that the object is =
valid, and that we can safely
> +        // return a mutable reference to it.
> +        let unpinned =3D unsafe { self.ptr.as_mut() };
> +
> +        // SAFETY: We never hand out unpinned mutable references to =
the data in
> +        // `Self`, unless the contained type is `Unpin`.
> +        unsafe { Pin::new_unchecked(unpinned) }
> +    }
> +}
> +
> +impl<T: Ownable> Deref for Owned<T> {
> +    type Target =3D T;
> +
> +    fn deref(&self) -> &Self::Target {
> +        // SAFETY: The type invariants guarantee that the object is =
valid.
> +        unsafe { self.ptr.as_ref() }
> +    }
> +}
> +
> +impl<T: Ownable + Unpin> DerefMut for Owned<T> {
> +    fn deref_mut(&mut self) -> &mut Self::Target {
> +        // SAFETY: The type invariants guarantee that the object is =
valid, and that we can safely
> +        // return a mutable reference to it.
> +        unsafe { self.ptr.as_mut() }
> +    }
> +}
> +
> +impl<T: Ownable> Drop for Owned<T> {
> +    fn drop(&mut self) {
> +        // SAFETY: The type invariants guarantee that the `Owned` =
owns the object we're about to
> +        // release.
> +        unsafe { T::release(self.ptr) };
> +    }
> +}
> diff --git a/rust/kernel/sync/aref.rs b/rust/kernel/sync/aref.rs
> index 0d24a0432015..e175aefe8615 100644
> --- a/rust/kernel/sync/aref.rs
> +++ b/rust/kernel/sync/aref.rs
> @@ -29,6 +29,11 @@
> /// Rust code, the recommendation is to use [`Arc`](crate::sync::Arc) =
to create reference-counted
> /// instances of a type.
> ///
> +/// Note: Implementing this trait allows types to be wrapped in an =
[`ARef<Self>`]. It requires an
> +/// internal reference count and provides only shared references. If =
unique references are required
> +/// [`Ownable`](crate::types::Ownable) should be implemented which =
allows types to be wrapped in an
> +/// [`Owned<Self>`](crate::types::Owned).
> +///
> /// # Safety
> ///
> /// Implementers must ensure that increments to the reference count =
keep the object alive in memory
> diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
> index dc0a02f5c3cf..7bc07c38cd6c 100644
> --- a/rust/kernel/types.rs
> +++ b/rust/kernel/types.rs
> @@ -11,6 +11,8 @@
> };
> use pin_init::{PinInit, Wrapper, Zeroable};
>=20
> +pub use crate::owned::{Ownable, Owned};
> +
> pub use crate::sync::aref::{ARef, AlwaysRefCounted};
>=20
> /// Used to transfer ownership to and from foreign (non-Rust) =
languages.
>=20
> --=20
> 2.51.2
>=20
>=20
>=20

With the changes above,

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>=

