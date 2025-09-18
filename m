Return-Path: <linux-fsdevel+bounces-57340-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43EE3B20971
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 14:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4BE73B0E2F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 12:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E382D3EC7;
	Mon, 11 Aug 2025 12:57:18 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D90130E58;
	Mon, 11 Aug 2025 12:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754917037; cv=none; b=mIMgCOwIfHRIU8ye6j6j5TfvfkKZgsGd7ROiYkrNKiFIq6QiBSmOlfQ/ryNkOboG3DrwxWFxcF51GYmwjWowoZe1KnK/lk81QL9k6Qs87ZoJAv6/9ymOQGR7stGd0oMS14mSp3593EcCiXz2Kw880n7Tjj6VPtt5oVeCzC6FMUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754917037; c=relaxed/simple;
	bh=LUhjUlqRyq9v1tilHoxAILYg/7omOW937aK51lV7LSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=acDnOYr9yhvdbrqKpK4Tc7Yczh4zR4mPmAQvEXed2ldV/9alNbt6EuNWYxiNGTOioFaT/KaqNNcSztts4qiQweX37yfTglOi0seoctMjsDqcAzPduSX9GqSNf8Rgxp2XmnkHCkobMy70FsP+9EVnthXSmoct+H+SUyXYl6OcfRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9FB341D13;
	Mon, 11 Aug 2025 05:57:06 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3E5BD3F63F;
	Mon, 11 Aug 2025 05:57:08 -0700 (PDT)
Date: Mon, 11 Aug 2025 14:56:46 +0200
From: Beata Michalska <beata.michalska@arm.com>
To: Tamir Duberstein <tamird@gmail.com>
Cc: Andreas Hindborg <a.hindborg@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Janne Grunau <j@jannau.net>
Subject: Re: [PATCH v2 3/3] rust: xarray: add `insert` and `reserve`
Message-ID: <aJnojv8AWj2isnit@arm.com>
References: <20250713-xarray-insert-reserve-v2-0-b939645808a2@gmail.com>
 <20250713-xarray-insert-reserve-v2-3-b939645808a2@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250713-xarray-insert-reserve-v2-3-b939645808a2@gmail.com>

Hi Tamir,

Apologies for such a late drop.

On Sun, Jul 13, 2025 at 08:05:49AM -0400, Tamir Duberstein wrote:
> Add `Guard::{insert,reserve}` and `Guard::{insert,reserve}_limit`, which
> are akin to `__xa_{alloc,insert}` in C.
> 
> Note that unlike `xa_reserve` which only ensures that memory is
> allocated, the semantics of `Reservation` are stricter and require
> precise management of the reservation. Indices which have been reserved
> can still be overwritten with `Guard::store`, which allows for C-like
> semantics if desired.
> 
> `__xa_cmpxchg_raw` is exported to facilitate the semantics described
> above.
> 
> Tested-by: Janne Grunau <j@jannau.net>
> Reviewed-by: Janne Grunau <j@jannau.net>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---
>  include/linux/xarray.h |   2 +
>  lib/xarray.c           |  28 ++-
>  rust/helpers/xarray.c  |   5 +
>  rust/kernel/xarray.rs  | 494 +++++++++++++++++++++++++++++++++++++++++++++++--
>  4 files changed, 512 insertions(+), 17 deletions(-)
> 
> diff --git a/include/linux/xarray.h b/include/linux/xarray.h
> index be850174e802..64f2a5e06ceb 100644
> --- a/include/linux/xarray.h
> +++ b/include/linux/xarray.h
> @@ -563,6 +563,8 @@ void *__xa_erase(struct xarray *, unsigned long index);
>  void *__xa_store(struct xarray *, unsigned long index, void *entry, gfp_t);
>  void *__xa_cmpxchg(struct xarray *, unsigned long index, void *old,
>  		void *entry, gfp_t);
> +void *__xa_cmpxchg_raw(struct xarray *, unsigned long index, void *old,
> +		void *entry, gfp_t);
>  int __must_check __xa_insert(struct xarray *, unsigned long index,
>  		void *entry, gfp_t);
>  int __must_check __xa_alloc(struct xarray *, u32 *id, void *entry,
> diff --git a/lib/xarray.c b/lib/xarray.c
> index 76dde3a1cacf..58202b6fbb59 100644
> --- a/lib/xarray.c
> +++ b/lib/xarray.c
> @@ -1738,9 +1738,6 @@ void *xa_store(struct xarray *xa, unsigned long index, void *entry, gfp_t gfp)
>  }
>  EXPORT_SYMBOL(xa_store);
>  
> -static inline void *__xa_cmpxchg_raw(struct xarray *xa, unsigned long index,
> -			void *old, void *entry, gfp_t gfp);
> -
>  /**
>   * __xa_cmpxchg() - Conditionally replace an entry in the XArray.
>   * @xa: XArray.
> @@ -1767,7 +1764,29 @@ void *__xa_cmpxchg(struct xarray *xa, unsigned long index,
>  }
>  EXPORT_SYMBOL(__xa_cmpxchg);
>  
> -static inline void *__xa_cmpxchg_raw(struct xarray *xa, unsigned long index,
> +/**
> + * __xa_cmpxchg_raw() - Conditionally replace an entry in the XArray.
> + * @xa: XArray.
> + * @index: Index into array.
> + * @old: Old value to test against.
> + * @entry: New value to place in array.
> + * @gfp: Memory allocation flags.
> + *
> + * You must already be holding the xa_lock when calling this function.
> + * It will drop the lock if needed to allocate memory, and then reacquire
> + * it afterwards.
> + *
> + * If the entry at @index is the same as @old, replace it with @entry.
> + * If the return value is equal to @old, then the exchange was successful.
> + *
> + * This function is the same as __xa_cmpxchg() except that it does not coerce
> + * XA_ZERO_ENTRY to NULL on egress.
> + *
> + * Context: Any context.  Expects xa_lock to be held on entry.  May
> + * release and reacquire xa_lock if @gfp flags permit.
> + * Return: The old value at this index or xa_err() if an error happened.
> + */
> +void *__xa_cmpxchg_raw(struct xarray *xa, unsigned long index,
>  			void *old, void *entry, gfp_t gfp)
>  {
>  	XA_STATE(xas, xa, index);
> @@ -1787,6 +1806,7 @@ static inline void *__xa_cmpxchg_raw(struct xarray *xa, unsigned long index,
>  
>  	return xas_result(&xas, curr);
>  }
> +EXPORT_SYMBOL(__xa_cmpxchg_raw);
>  
>  /**
>   * __xa_insert() - Store this entry in the XArray if no entry is present.
> diff --git a/rust/helpers/xarray.c b/rust/helpers/xarray.c
> index 60b299f11451..b6c078e6a343 100644
> --- a/rust/helpers/xarray.c
> +++ b/rust/helpers/xarray.c
> @@ -2,6 +2,11 @@
>  
>  #include <linux/xarray.h>
>  
> +void *rust_helper_xa_zero_entry(void)
> +{
> +	return XA_ZERO_ENTRY;
> +}
> +
>  int rust_helper_xa_err(void *entry)
>  {
>  	return xa_err(entry);
> diff --git a/rust/kernel/xarray.rs b/rust/kernel/xarray.rs
> index 101f61c0362d..a43414bb4d7e 100644
> --- a/rust/kernel/xarray.rs
> +++ b/rust/kernel/xarray.rs
> @@ -9,7 +9,12 @@
>      prelude::*,
>      types::{ForeignOwnable, NotThreadSafe, Opaque},
>  };
> -use core::{iter, marker::PhantomData, mem, ptr::NonNull};
> +use core::{
> +    fmt, iter,
> +    marker::PhantomData,
> +    mem, ops,
> +    ptr::{null_mut, NonNull},
> +};
>  
>  /// An array which efficiently maps sparse integer indices to owned objects.
>  ///
> @@ -25,29 +30,81 @@
>  ///
>  /// ```rust
>  /// # use kernel::alloc::KBox;
> -/// # use kernel::xarray::XArray;
> +/// # use kernel::xarray::{StoreError, XArray};
>  /// # use pin_init::stack_pin_init;
>  ///
>  /// stack_pin_init!(let xa = XArray::new(Default::default()));
>  ///
>  /// let dead = KBox::new(0xdead, GFP_KERNEL)?;
>  /// let beef = KBox::new(0xbeef, GFP_KERNEL)?;
> +/// let leet = KBox::new(0x1337, GFP_KERNEL)?;
> +///
> +/// let mut guard = xa.lock();
> +///
> +/// let index = guard.insert_limit(.., dead, GFP_KERNEL)?;
> +///
> +/// assert_eq!(guard.get(index), Some(&0xdead));
> +///
> +/// let beef = {
> +///     let ret = guard.insert(index, beef, GFP_KERNEL);
> +///     assert!(ret.is_err());
> +///     let StoreError { value, error } = ret.unwrap_err();
> +///     assert_eq!(error, EBUSY);
> +///     value
> +/// };
> +///
> +/// let reservation = guard.reserve_limit(.., GFP_KERNEL);
> +/// assert!(reservation.is_ok());
> +/// let reservation1 = reservation.unwrap();
> +/// let reservation = guard.reserve_limit(.., GFP_KERNEL);
> +/// assert!(reservation.is_ok());
> +/// let reservation2 = reservation.unwrap();
> +///
> +/// assert_eq!(reservation1.index(), index + 1);
> +/// assert_eq!(reservation2.index(), index + 2);
> +///
> +/// let dead = {
> +///     let ret = guard.remove(index);
> +///     assert!(ret.is_some());
> +///     ret.unwrap()
> +/// };
> +/// assert_eq!(*dead, 0xdead);
> +///
> +/// drop(guard); // Reservations can outlive the guard.
> +///
> +/// let () = reservation1.fill(dead)?;
> +///
> +/// let index = reservation2.index();
>  ///
>  /// let mut guard = xa.lock();
>  ///
> -/// assert_eq!(guard.get(0), None);
> +/// let beef = {
> +///     let ret = guard.insert(index, beef, GFP_KERNEL);
> +///     assert!(ret.is_err());
> +///     let StoreError { value, error } = ret.unwrap_err();
> +///     assert_eq!(error, EBUSY);
> +///     value
> +/// };
>  ///
> -/// assert_eq!(guard.store(0, dead, GFP_KERNEL)?.as_deref(), None);
> -/// assert_eq!(guard.get(0).copied(), Some(0xdead));
> +/// // `store` ignores reservations.
> +/// {
> +///    let ret = guard.store(index, beef, GFP_KERNEL);
> +///    assert!(ret.is_ok());
> +///    assert_eq!(ret.unwrap().as_deref(), None);
> +/// }
>  ///
> -/// *guard.get_mut(0).unwrap() = 0xffff;
> -/// assert_eq!(guard.get(0).copied(), Some(0xffff));
> +/// assert_eq!(guard.get(index), Some(&0xbeef));
>  ///
> -/// assert_eq!(guard.store(0, beef, GFP_KERNEL)?.as_deref().copied(), Some(0xffff));
> -/// assert_eq!(guard.get(0).copied(), Some(0xbeef));
> +/// // We trampled the reservation above, so filling should fail.
> +/// let leet = {
> +///    let ret = reservation2.fill_locked(&mut guard, leet);
> +///    assert!(ret.is_err());
> +///    let StoreError { value, error } = ret.unwrap_err();
> +///    assert_eq!(error, EBUSY);
> +///    value
> +/// };
>  ///
> -/// guard.remove(0);
> -/// assert_eq!(guard.get(0), None);
> +/// assert_eq!(guard.get(index), Some(&0xbeef));
>  ///
>  /// # Ok::<(), Error>(())
>  /// ```
> @@ -126,6 +183,19 @@ fn iter(&self) -> impl Iterator<Item = NonNull<T::PointedTo>> + '_ {
>          .map_while(|ptr| NonNull::new(ptr.cast()))
>      }
>  
> +    fn with_guard<F, U>(&self, guard: Option<&mut Guard<'_, T>>, f: F) -> U
> +    where
> +        F: FnOnce(&mut Guard<'_, T>) -> U,
> +    {
> +        match guard {
> +            None => f(&mut self.lock()),
> +            Some(guard) => {
> +                assert_eq!(guard.xa.xa.get(), self.xa.get());
> +                f(guard)
> +            }
> +        }
> +    }
> +
>      /// Attempts to lock the [`XArray`] for exclusive access.
>      pub fn try_lock(&self) -> Option<Guard<'_, T>> {
>          // SAFETY: `self.xa` is always valid by the type invariant.
> @@ -172,6 +242,7 @@ fn drop(&mut self) {
>  /// The error returned by [`store`](Guard::store).
>  ///
>  /// Contains the underlying error and the value that was not stored.
> +#[derive(Debug)]
>  pub struct StoreError<T> {
>      /// The error that occurred.
>      pub error: Error,
> @@ -185,6 +256,11 @@ fn from(value: StoreError<T>) -> Self {
>      }
>  }
>  
> +fn to_usize(i: u32) -> usize {
> +    i.try_into()
> +        .unwrap_or_else(|_| build_error!("cannot convert u32 to usize"))
> +}
> +
>  impl<'a, T: ForeignOwnable> Guard<'a, T> {
>      fn load<F, U>(&self, index: usize, f: F) -> Option<U>
>      where
> @@ -219,7 +295,7 @@ pub fn remove(&mut self, index: usize) -> Option<T> {
>          // - The caller holds the lock.
>          let ptr = unsafe { bindings::__xa_erase(self.xa.xa.get(), index) }.cast();
>          // SAFETY:
> -        // - `ptr` is either NULL or came from `T::into_foreign`.
> +        // - `ptr` is either `NULL` or came from `T::into_foreign`.
>          // - `&mut self` guarantees that the lifetimes of [`T::Borrowed`] and [`T::BorrowedMut`]
>          // borrowed from `self` have ended.
>          unsafe { T::try_from_foreign(ptr) }
> @@ -267,13 +343,272 @@ pub fn store(
>              })
>          } else {
>              let old = old.cast();
> -            // SAFETY: `ptr` is either NULL or came from `T::into_foreign`.
> +            // SAFETY: `ptr` is either `NULL` or came from `T::into_foreign`.
>              //
>              // NB: `XA_ZERO_ENTRY` is never returned by functions belonging to the Normal XArray
>              // API; such entries present as `NULL`.
>              Ok(unsafe { T::try_from_foreign(old) })
>          }
>      }
> +
> +    /// Stores an element at the given index if no entry is present.
> +    ///
> +    /// May drop the lock if needed to allocate memory, and then reacquire it afterwards.
> +    ///
> +    /// On failure, returns the element which was attempted to be stored.
> +    pub fn insert(
> +        &mut self,
> +        index: usize,
> +        value: T,
> +        gfp: alloc::Flags,
> +    ) -> Result<(), StoreError<T>> {
> +        build_assert!(
> +            mem::align_of::<T::PointedTo>() >= 4,
> +            "pointers stored in XArray must be 4-byte aligned"
> +        );
> +        let ptr = value.into_foreign();
> +        // SAFETY: `self.xa` is always valid by the type invariant.
> +        //
> +        // INVARIANT: `ptr` came from `T::into_foreign`.
> +        match unsafe { bindings::__xa_insert(self.xa.xa.get(), index, ptr.cast(), gfp.as_raw()) } {
> +            0 => Ok(()),
> +            errno => {
> +                // SAFETY: `ptr` came from `T::into_foreign` and `__xa_insert` does not take
> +                // ownership of the value on error.
> +                let value = unsafe { T::from_foreign(ptr) };
> +                Err(StoreError {
> +                    value,
> +                    error: Error::from_errno(errno),
> +                })
> +            }
> +        }
> +    }
> +
> +    /// Stores an element somewhere in the given range of indices.
> +    ///
> +    /// On success, takes ownership of `ptr`.
> +    ///
> +    /// On failure, ownership returns to the caller.
> +    ///
> +    /// # Safety
> +    ///
> +    /// `ptr` must be `NULL` or have come from a previous call to `T::into_foreign`.
> +    unsafe fn alloc(
> +        &mut self,
> +        limit: impl ops::RangeBounds<u32>,
> +        ptr: *mut T::PointedTo,
> +        gfp: alloc::Flags,
> +    ) -> Result<usize> {
> +        // NB: `xa_limit::{max,min}` are inclusive.
> +        let limit = bindings::xa_limit {
> +            max: match limit.end_bound() {
> +                ops::Bound::Included(&end) => end,
> +                ops::Bound::Excluded(&end) => end - 1,
> +                ops::Bound::Unbounded => u32::MAX,
> +            },
> +            min: match limit.start_bound() {
> +                ops::Bound::Included(&start) => start,
> +                ops::Bound::Excluded(&start) => start + 1,
> +                ops::Bound::Unbounded => 0,
> +            },
> +        };
> +
> +        let mut index = u32::MAX;
> +
> +        // SAFETY:
> +        // - `self.xa` is always valid by the type invariant.
> +        // - `self.xa` was initialized with `XA_FLAGS_ALLOC` or `XA_FLAGS_ALLOC1`.
> +        //
> +        // INVARIANT: `ptr` is either `NULL` or came from `T::into_foreign`.
> +        match unsafe {
> +            bindings::__xa_alloc(
> +                self.xa.xa.get(),
> +                &mut index,
> +                ptr.cast(),
> +                limit,
> +                gfp.as_raw(),
> +            )
> +        } {
> +            0 => Ok(to_usize(index)),
> +            errno => Err(Error::from_errno(errno)),
> +        }
> +    }
> +
> +    /// Allocates an entry somewhere in the array.
> +    ///
> +    /// On success, returns the index at which the entry was stored.
> +    ///
> +    /// On failure, returns the entry which was attempted to be stored.
> +    pub fn insert_limit(
> +        &mut self,
> +        limit: impl ops::RangeBounds<u32>,
> +        value: T,
> +        gfp: alloc::Flags,
> +    ) -> Result<usize, StoreError<T>> {
> +        build_assert!(
> +            mem::align_of::<T::PointedTo>() >= 4,
> +            "pointers stored in XArray must be 4-byte aligned"
> +        );
> +        let ptr = value.into_foreign();
> +        // SAFETY: `ptr` came from `T::into_foreign`.
> +        unsafe { self.alloc(limit, ptr, gfp) }.map_err(|error| {
> +            // SAFETY: `ptr` came from `T::into_foreign` and `self.alloc` does not take ownership of
> +            // the value on error.
> +            let value = unsafe { T::from_foreign(ptr) };
> +            StoreError { value, error }
> +        })
> +    }
> +
> +    /// Reserves an entry in the array.
> +    pub fn reserve(&mut self, index: usize, gfp: alloc::Flags) -> Result<Reservation<'a, T>> {
> +        // NB: `__xa_insert` internally coerces `NULL` to `XA_ZERO_ENTRY` on ingress.
> +        let ptr = null_mut();
> +        // SAFETY: `self.xa` is always valid by the type invariant.
> +        //
> +        // INVARIANT: `ptr` is `NULL`.
> +        match unsafe { bindings::__xa_insert(self.xa.xa.get(), index, ptr, gfp.as_raw()) } {
> +            0 => Ok(Reservation { xa: self.xa, index }),
> +            errno => Err(Error::from_errno(errno)),
> +        }
> +    }
> +
> +    /// Reserves an entry somewhere in the array.
> +    pub fn reserve_limit(
> +        &mut self,
> +        limit: impl ops::RangeBounds<u32>,
> +        gfp: alloc::Flags,
> +    ) -> Result<Reservation<'a, T>> {
> +        // NB: `__xa_alloc` internally coerces `NULL` to `XA_ZERO_ENTRY` on ingress.
> +        let ptr = null_mut();
> +        // SAFETY: `ptr` is `NULL`.
> +        unsafe { self.alloc(limit, ptr, gfp) }.map(|index| Reservation { xa: self.xa, index })
> +    }
> +}
> +
> +/// A reserved slot in an array.
> +///
> +/// The slot is released when the reservation goes out of scope.
> +///
> +/// Note that the array lock *must not* be held when the reservation is filled or dropped as this
> +/// will lead to deadlock. [`Reservation::fill_locked`] and [`Reservation::release_locked`] can be
> +/// used in context where the array lock is held.
> +#[must_use = "the reservation is released immediately when the reservation is unused"]
> +pub struct Reservation<'a, T: ForeignOwnable> {
> +    xa: &'a XArray<T>,
> +    index: usize,
> +}
> +
> +impl<T: ForeignOwnable> fmt::Debug for Reservation<'_, T> {
> +    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
> +        f.debug_struct("Reservation")
> +            .field("index", &self.index())
> +            .finish()
> +    }
> +}
> +
> +impl<T: ForeignOwnable> Reservation<'_, T> {
> +    /// Returns the index of the reservation.
> +    pub fn index(&self) -> usize {
> +        self.index
> +    }
> +
> +    /// Replaces the reserved entry with the given entry.
> +    ///
> +    /// # Safety
> +    ///
> +    /// `ptr` must be `NULL` or have come from a previous call to `T::into_foreign`.
> +    unsafe fn replace(guard: &mut Guard<'_, T>, index: usize, ptr: *mut T::PointedTo) -> Result {
> +        // SAFETY: `xa_zero_entry` wraps `XA_ZERO_ENTRY` which is always safe to use.
> +        let old = unsafe { bindings::xa_zero_entry() };
> +
> +        // NB: `__xa_cmpxchg_raw` is used over `__xa_cmpxchg` because the latter coerces
> +        // `XA_ZERO_ENTRY` to `NULL` on egress, which would prevent us from determining whether a
> +        // replacement was made.
> +        //
> +        // SAFETY: `self.xa` is always valid by the type invariant.
> +        //
> +        // INVARIANT: `ptr` is either `NULL` or came from `T::into_foreign` and `old` is
> +        // `XA_ZERO_ENTRY`.
> +        let ret =
> +            unsafe { bindings::__xa_cmpxchg_raw(guard.xa.xa.get(), index, old, ptr.cast(), 0) };
> +
> +        // SAFETY: `__xa_cmpxchg_raw` returns the old entry at this index on success or `xa_err` if
> +        // an error happened.
> +        match unsafe { bindings::xa_err(ret) } {
> +            0 => {
> +                if ret == old {
> +                    Ok(())
> +                } else {
> +                    Err(EBUSY)
> +                }
> +            }
> +            errno => Err(Error::from_errno(errno)),
> +        }
> +    }
> +
> +    fn fill_inner(&self, guard: Option<&mut Guard<'_, T>>, value: T) -> Result<(), StoreError<T>> {
> +        let Self { xa, index } = self;
> +        let index = *index;
> +
> +        let ptr = value.into_foreign();
> +        xa.with_guard(guard, |guard| {
> +            // SAFETY: `ptr` came from `T::into_foreign`.
> +            unsafe { Self::replace(guard, index, ptr) }
> +        })
> +        .map_err(|error| {
> +            // SAFETY: `ptr` came from `T::into_foreign` and `Self::replace` does not take ownership
> +            // of the value on error.
> +            let value = unsafe { T::from_foreign(ptr) };
> +            StoreError { value, error }
> +        })
> +    }
> +
> +    /// Fills the reservation.
> +    pub fn fill(self, value: T) -> Result<(), StoreError<T>> {
> +        let result = self.fill_inner(None, value);
> +        mem::forget(self);
> +        result
> +    }
> +
> +    /// Fills the reservation without acquiring the array lock.
> +    ///
> +    /// # Panics
> +    ///
> +    /// Panics if the passed guard locks a different array.
> +    pub fn fill_locked(self, guard: &mut Guard<'_, T>, value: T) -> Result<(), StoreError<T>> {
> +        let result = self.fill_inner(Some(guard), value);
> +        mem::forget(self);
> +        result
> +    }
> +
> +    fn release_inner(&self, guard: Option<&mut Guard<'_, T>>) -> Result {
> +        let Self { xa, index } = self;
> +        let index = *index;
> +
> +        xa.with_guard(guard, |guard| {
> +            let ptr = null_mut();
> +            // SAFETY: `ptr` is `NULL`.
> +            unsafe { Self::replace(guard, index, ptr) }
> +        })
> +    }
> +
> +    /// Releases the reservation without acquiring the array lock.
> +    ///
> +    /// # Panics
> +    ///
> +    /// Panics if the passed guard locks a different array.
> +    pub fn release_locked(self, guard: &mut Guard<'_, T>) -> Result {
> +        let result = self.release_inner(Some(guard));
> +        mem::forget(self);
> +        result
> +    }
> +}
> +
> +impl<T: ForeignOwnable> Drop for Reservation<'_, T> {
> +    fn drop(&mut self) {
> +        // NB: Errors here are possible since `Guard::store` does not honor reservations.
> +        let _: Result = self.release_inner(None);
This seems bit risky as one can drop the reservation while still holding the
lock?
> +    }
>  }
>  
>  // SAFETY: `XArray<T>` has no shared mutable state so it is `Send` iff `T` is `Send`.
> @@ -282,3 +617,136 @@ unsafe impl<T: ForeignOwnable + Send> Send for XArray<T> {}
>  // SAFETY: `XArray<T>` serialises the interior mutability it provides so it is `Sync` iff `T` is
>  // `Send`.
>  unsafe impl<T: ForeignOwnable + Send> Sync for XArray<T> {}
> +
> +#[macros::kunit_tests(rust_xarray_kunit)]
> +mod tests {
> +    use super::*;
> +    use pin_init::stack_pin_init;
> +
> +    fn new_kbox<T>(value: T) -> Result<KBox<T>> {
> +        KBox::new(value, GFP_KERNEL).map_err(Into::into)
I believe this should be GFP_ATOMIC as it is being called while holding the xa
lock.

Otherwise:

Tested-By: Beata Michalska <beata.michalska@arm.com>

---
BR
Beata
> +    }
> +
> +    #[test]
> +    fn test_alloc_kind_alloc() -> Result {
> +        test_alloc_kind(AllocKind::Alloc, 0)
> +    }
> +
> +    #[test]
> +    fn test_alloc_kind_alloc1() -> Result {
> +        test_alloc_kind(AllocKind::Alloc1, 1)
> +    }
> +
> +    fn test_alloc_kind(kind: AllocKind, expected_index: usize) -> Result {
> +        stack_pin_init!(let xa = XArray::new(kind));
> +        let mut guard = xa.lock();
> +
> +        let reservation = guard.reserve_limit(.., GFP_KERNEL)?;
> +        assert_eq!(reservation.index(), expected_index);
> +        reservation.release_locked(&mut guard)?;
> +
> +        let insertion = guard.insert_limit(.., new_kbox(0x1337)?, GFP_KERNEL);
> +        assert!(insertion.is_ok());
> +        let insertion_index = insertion.unwrap();
> +        assert_eq!(insertion_index, expected_index);
> +
> +        Ok(())
> +    }
> +
> +    #[test]
> +    fn test_insert_and_reserve_interaction() -> Result {
> +        const IDX: usize = 0x1337;
> +
> +        fn insert<T: ForeignOwnable>(
> +            guard: &mut Guard<'_, T>,
> +            value: T,
> +        ) -> Result<(), StoreError<T>> {
> +            guard.insert(IDX, value, GFP_KERNEL)
> +        }
> +
> +        fn reserve<'a, T: ForeignOwnable>(guard: &mut Guard<'a, T>) -> Result<Reservation<'a, T>> {
> +            guard.reserve(IDX, GFP_KERNEL)
> +        }
> +
> +        #[track_caller]
> +        fn check_not_vacant<'a>(guard: &mut Guard<'a, KBox<usize>>) -> Result {
> +            // Insertion fails.
> +            {
> +                let beef = new_kbox(0xbeef)?;
> +                let ret = insert(guard, beef);
> +                assert!(ret.is_err());
> +                let StoreError { error, value } = ret.unwrap_err();
> +                assert_eq!(error, EBUSY);
> +                assert_eq!(*value, 0xbeef);
> +            }
> +
> +            // Reservation fails.
> +            {
> +                let ret = reserve(guard);
> +                assert!(ret.is_err());
> +                assert_eq!(ret.unwrap_err(), EBUSY);
> +            }
> +
> +            Ok(())
> +        }
> +
> +        stack_pin_init!(let xa = XArray::new(Default::default()));
> +        let mut guard = xa.lock();
> +
> +        // Vacant.
> +        assert_eq!(guard.get(IDX), None);
> +
> +        // Reservation succeeds.
> +        let reservation = {
> +            let ret = reserve(&mut guard);
> +            assert!(ret.is_ok());
> +            ret.unwrap()
> +        };
> +
> +        // Reserved presents as vacant.
> +        assert_eq!(guard.get(IDX), None);
> +
> +        check_not_vacant(&mut guard)?;
> +
> +        // Release reservation.
> +        {
> +            let ret = reservation.release_locked(&mut guard);
> +            assert!(ret.is_ok());
> +            let () = ret.unwrap();
> +        }
> +
> +        // Vacant again.
> +        assert_eq!(guard.get(IDX), None);
> +
> +        // Insert succeeds.
> +        {
> +            let dead = new_kbox(0xdead)?;
> +            let ret = insert(&mut guard, dead);
> +            assert!(ret.is_ok());
> +            let () = ret.unwrap();
> +        }
> +
> +        check_not_vacant(&mut guard)?;
> +
> +        // Remove.
> +        assert_eq!(guard.remove(IDX).as_deref(), Some(&0xdead));
> +
> +        // Reserve and fill.
> +        {
> +            let beef = new_kbox(0xbeef)?;
> +            let ret = reserve(&mut guard);
> +            assert!(ret.is_ok());
> +            let reservation = ret.unwrap();
> +            let ret = reservation.fill_locked(&mut guard, beef);
> +            assert!(ret.is_ok());
> +            let () = ret.unwrap();
> +        };
> +
> +        check_not_vacant(&mut guard)?;
> +
> +        // Remove.
> +        assert_eq!(guard.remove(IDX).as_deref(), Some(&0xbeef));
> +
> +        Ok(())
> +    }
> +}
> 
> -- 
> 2.50.1
> 
> 

