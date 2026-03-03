Return-Path: <linux-fsdevel+bounces-79286-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KLbGD9Nbp2knhAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79286-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 23:08:19 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AC1C51F7DBB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 23:08:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 57B6A3034A2A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2026 22:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0085B386C17;
	Tue,  3 Mar 2026 22:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k/bOPIoe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CBA37EFF2;
	Tue,  3 Mar 2026 22:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772575691; cv=none; b=rmVL1snJZYrhVckCLRm/f1oQJVIa5yU2JCIENZj5ZbL8zuCN+xytHhJ6FTYbf0hQg5D9uN7xlKxT8I1+4mPTD8bVNpey4lY5J4styntPYO4thblhTi6Nv5Tyn7BTQfKkiUqPfYMxqbuTUf0rlHuuHEqjJyufNO3Aqn0CoFB7yqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772575691; c=relaxed/simple;
	bh=HYHLkG9d8l387LsfjPeLC/Pn7ygrv02/lOJJGWdLEzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r3rifwUX90TeoQUoIDTGgqIMciCOLfyaaEQOK7X+LBhDDVk3rmxueQuFnBUKDFmFG5ZQCkPngWUflyt+GBLUrsV3g7CvwtBomzFpQnf2r1HUGpeLTIvXK5W2KRUV1YzxCykFHbVDB28/7xtR/ABrPNZfkn98a3xd/yjVw074Tgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k/bOPIoe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D8E3C2BCAF;
	Tue,  3 Mar 2026 22:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772575691;
	bh=HYHLkG9d8l387LsfjPeLC/Pn7ygrv02/lOJJGWdLEzk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k/bOPIoeRv+xpWXkS2RVt+6rKiaHAwUN8PO9hBp01Rswu/ltHfw84LrzdqpubTy66
	 /LKPYAXhRRb5J7Pcp/zlQkijKF9VbL6lcM+xGe6sLGpsS+HoMMdNGZrL6bCgeszAlQ
	 m1JMPEGFYufNYtN2vTqvL74Ooh0R2jgHyt6IhoreAFzJOnT69Noh7zOxfCdMNYg8BT
	 rru5h+7saa/eUUewTR+C6MNKgZ6rP2x+sHYp8d1PnTCO4cBnoJy2GAQtajipkIRHcv
	 pDSgEd6m5R6Lfwm9hjune0fqb+3toNF9dqLETe+icugKWMIn4Sr8Nlbkz7zg82JqAu
	 Lagx+/+9n0F7g==
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id 3155CF40070;
	Tue,  3 Mar 2026 17:08:10 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 03 Mar 2026 17:08:10 -0500
X-ME-Sender: <xms:ylunaRe_wLS051LnTGLJ7uABzh6y7v4F0E1ATOUyEDqfYNHEP0Y9QQ>
    <xme:ylunabHZ2DNpaGs2nxBjN4TTuteuP9rHaCaGZo_GFVHs4sZmd_C1gOAt-SBUN25cV
    4Qp48FBsuptllboL_sW87KyWqPZo40EeF4ooa9nzVbtGr-hl5ZtFw>
X-ME-Received: <xmr:ylunaXjR4OOf_AXNEFLTJG9eHWgSZIznk2f4QLq4rbjMAc3wB0w8FXKF_DYkst4RX3kL4GF7HtOLKH1FXBRugLPr3KJNSfyX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddviedujeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrhhnpe
    ekgffhhfeuheelhfekteeuffejveetjeefffettedtteegfefftdduteduudfgleenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnod
    hmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieejtdelkeegjeduqddujeej
    keehheehvddqsghoqhhunheppehkvghrnhgvlhdrohhrghesfhhigihmvgdrnhgrmhgvpd
    hnsggprhgtphhtthhopeduuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghl
    ihgtvghrhihhlhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepsghrrghunhgvrheskh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepsghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepphgruhhlmhgtkheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epghgrrhihsehgrghrhihguhhordhnvghtpdhrtghpthhtohepghhrvghgkhhhsehlihhn
    uhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheptghmlhhlrghmrghssehgoh
    hoghhlvgdrtghomhdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhushhtqdhfohhrqdhlihhnuhigsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:ylunaf1qvOocIejJ-AmtIEZj6OrRbDRdxdY87jGMUK6cSmfx5Kx-Yw>
    <xmx:ylunaScV5gm_AXYggec6MOvrhthVDgD7eIC9ntzLex09IzD158nvgQ>
    <xmx:ylunadxImnK0XRGNu4gtcYhSlupC1CIgNQBSiiws6KCaSOWpdf6kCQ>
    <xmx:ylunaSxEgaIduRRGHggPBPVCFpMVyove-Vud1nwOvGJbSABwJ5OTQw>
    <xmx:ylunaWZg2H-f8p7npgfXdJskNnjZafm8WWnyE5GDZtb3zSJHF6HlG9m3>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Mar 2026 17:08:09 -0500 (EST)
Date: Tue, 3 Mar 2026 14:08:08 -0800
From: Boqun Feng <boqun@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Carlos Llamas <cmllamas@google.com>, linux-fsdevel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] rust: poll: make PollCondVar upgradable
Message-ID: <aadbyBmaV8zCYiog@tardis.local>
References: <20260213-upgrade-poll-v2-0-984a0fb184fb@google.com>
 <20260213-upgrade-poll-v2-1-984a0fb184fb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260213-upgrade-poll-v2-1-984a0fb184fb@google.com>
X-Rspamd-Queue-Id: AC1C51F7DBB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,garyguo.net,linuxfoundation.org,google.com,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-79286-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[boqun@kernel.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On Fri, Feb 13, 2026 at 11:29:41AM +0000, Alice Ryhl wrote:
> Rust Binder currently uses PollCondVar, but it calls synchronize_rcu()
> in the destructor, which we would like to avoid. Add a variation of
> PollCondVar, which uses kfree_rcu() instead.
> 
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/kernel/sync/poll.rs | 160 ++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 159 insertions(+), 1 deletion(-)
> 
> diff --git a/rust/kernel/sync/poll.rs b/rust/kernel/sync/poll.rs
> index 0ec985d560c8d3405c08dbd86e48b14c7c34484d..9555f818a24d777dd908fca849015c3490ce38d3 100644
> --- a/rust/kernel/sync/poll.rs
> +++ b/rust/kernel/sync/poll.rs
> @@ -5,12 +5,21 @@
>  //! Utilities for working with `struct poll_table`.
>  
>  use crate::{
> +    alloc::AllocError,
>      bindings,
> +    container_of,
>      fs::File,
>      prelude::*,
> +    sync::atomic::{Acquire, Atomic, Relaxed, Release},
> +    sync::lock::{Backend, Lock},
>      sync::{CondVar, LockClassKey},
> +    types::Opaque, //
> +};
> +use core::{
> +    marker::{PhantomData, PhantomPinned},
> +    ops::Deref,
> +    ptr,
>  };
> -use core::{marker::PhantomData, ops::Deref};
>  
>  /// Creates a [`PollCondVar`] initialiser with the given name and a newly-created lock class.
>  #[macro_export]
> @@ -66,6 +75,7 @@ pub fn register_wait(&self, file: &File, cv: &PollCondVar) {
>  ///
>  /// [`CondVar`]: crate::sync::CondVar
>  #[pin_data(PinnedDrop)]
> +#[repr(transparent)]
>  pub struct PollCondVar {
>      #[pin]
>      inner: CondVar,
> @@ -78,6 +88,17 @@ pub fn new(name: &'static CStr, key: Pin<&'static LockClassKey>) -> impl PinInit
>              inner <- CondVar::new(name, key),
>          })
>      }
> +
> +    /// Use this `CondVar` as a `PollCondVar`.
> +    ///
> +    /// # Safety
> +    ///
> +    /// After the last use of the returned `&PollCondVar`, `__wake_up_pollfree` must be called on
> +    /// the `wait_queue_head` at least one grace period before the `CondVar` is destroyed.
> +    unsafe fn from_non_poll(c: &CondVar) -> &PollCondVar {
> +        // SAFETY: Layout is the same. Caller ensures that PollTables are cleared in time.
> +        unsafe { &*ptr::from_ref(c).cast() }
> +    }
>  }
>  
>  // Make the `CondVar` methods callable on `PollCondVar`.
> @@ -104,3 +125,140 @@ fn drop(self: Pin<&mut Self>) {
>          unsafe { bindings::synchronize_rcu() };
>      }
>  }
> +
> +/// Wrapper around [`CondVar`] that can be upgraded to [`PollCondVar`].
> +///
> +/// By using this wrapper, you can avoid rcu for cases that don't use [`PollTable`], and in all
> +/// cases you can avoid `synchronize_rcu()`.
> +///
> +/// # Invariants
> +///
> +/// `active` either references `simple`, or a `kmalloc` allocation holding an
> +/// `UpgradePollCondVarInner`. In the latter case, the allocation remains valid until
> +/// `Self::drop()` plus one grace period.
> +#[pin_data(PinnedDrop)]
> +pub struct UpgradePollCondVar {
> +    #[pin]
> +    simple: CondVar,
> +    active: Atomic<*const CondVar>,
> +    #[pin]
> +    _pin: PhantomPinned,
> +}
> +
> +#[pin_data]
> +#[repr(C)]
> +struct UpgradePollCondVarInner {
> +    #[pin]
> +    upgraded: CondVar,
> +    #[pin]
> +    rcu: Opaque<bindings::callback_head>,
> +}
> +
> +impl UpgradePollCondVar {
> +    /// Constructs a new upgradable condvar initialiser.
> +    pub fn new(name: &'static CStr, key: Pin<&'static LockClassKey>) -> impl PinInit<Self> {
> +        pin_init!(&this in Self {
> +            simple <- CondVar::new(name, key),
> +            // SAFETY: `this->simple` is in-bounds. Pointer remains valid since this type is
> +            // pinned.
> +            active: Atomic::new(unsafe { &raw const (*this.as_ptr()).simple }),
> +            _pin: PhantomPinned,
> +        })
> +    }
> +
> +    /// Obtain a [`PollCondVar`], upgrading if necessary.
> +    ///
> +    /// You should use the same lock as what is passed to the `wait_*` methods. Otherwise wakeups
> +    /// may be missed.
> +    pub fn poll<T: ?Sized, B: Backend>(
> +        &self,
> +        lock: &Lock<T, B>,
> +        name: &'static CStr,
> +        key: Pin<&'static LockClassKey>,
> +    ) -> Result<&PollCondVar, AllocError> {
> +        let mut ptr = self.active.load(Acquire);
> +        if ptr::eq(ptr, &self.simple) {
> +            self.upgrade(lock, name, key)?;
> +            ptr = self.active.load(Acquire);
> +            debug_assert_ne!(ptr, ptr::from_ref(&self.simple));
> +        }
> +        // SAFETY: Signature ensures that last use of returned `&PollCondVar` is before drop(), and
> +        // drop() calls `__wake_up_pollfree` followed by waiting a grace period before the
> +        // `CondVar` is destroyed.
> +        Ok(unsafe { PollCondVar::from_non_poll(&*ptr) })
> +    }
> +
> +    fn upgrade<T: ?Sized, B: Backend>(
> +        &self,
> +        lock: &Lock<T, B>,
> +        name: &'static CStr,
> +        key: Pin<&'static LockClassKey>,
> +    ) -> Result<(), AllocError> {
> +        let upgraded = KBox::pin_init(
> +            pin_init!(UpgradePollCondVarInner {
> +                upgraded <- CondVar::new(name, key),
> +                rcu: Opaque::uninit(),
> +            }),
> +            GFP_KERNEL,
> +        )
> +        .map_err(|_| AllocError)?;
> +
> +        // SAFETY: The value is treated as pinned.
> +        let upgraded = KBox::into_raw(unsafe { Pin::into_inner_unchecked(upgraded) });
> +
> +        let res = self.active.cmpxchg(
> +            ptr::from_ref(&self.simple),
> +            // SAFETY: This operation stays in-bounds of the above allocation.
> +            unsafe { &raw mut (*upgraded).upgraded },
> +            Release,
> +        );
> +
> +        if res.is_err() {
> +            // Already upgraded, so still succeess.
> +            // SAFETY: The cmpxchg failed, so take back ownership of the box.
> +            drop(unsafe { KBox::from_raw(upgraded) });
> +            return Ok(());
> +        }
> +
> +        // If a normal waiter registers in parallel with us, then either:
> +        // * We took the lock first. In that case, the waiter sees the above cmpxchg.
> +        // * They took the lock first. In that case, we wake them up below.
> +        drop(lock.lock());
> +        self.simple.notify_all();

Hmm.. what if the waiter gets its `&CondVar` before `upgrade()` and use
that directly?

	<waiter>				<in upgrade()>
	let poll_cv: &UpgradePollCondVar = ...;
	let cv = poll_cv.deref();
						cmpxchg();
						drop(lock.lock());
						self.simple.notify_all();
	let mut guard = lock.lock();
	cv.wait(&mut guard);

we still miss the wake-up, right?

It's creative, but I particularly hate we use an empty lock critical
section to synchronize ;-)

Do you think the complexity of a dynamic upgrading is worthwhile, or we
should just use the box-allocated PollCondVar unconditionally?

I think if the current users won't benefit from the dynamic upgrading
then we can avoid the complexity. We can always add it back later.
Thoughts?

Regards,
Boqun

> +
> +        Ok(())
> +    }
> +}
> +
> +// Make the `CondVar` methods callable on `UpgradePollCondVar`.
> +impl Deref for UpgradePollCondVar {
> +    type Target = CondVar;
> +
> +    fn deref(&self) -> &CondVar {
> +        // SAFETY: By the type invariants, this is either `&self.simple` or references an
> +        // allocation that lives until `UpgradePollCondVar::drop`.
> +        unsafe { &*self.active.load(Acquire) }
> +    }
> +}
> +
> +#[pinned_drop]
> +impl PinnedDrop for UpgradePollCondVar {
> +    #[inline]
> +    fn drop(self: Pin<&mut Self>) {
> +        // ORDERING: All calls to upgrade happens-before Drop, so no synchronization is required.
> +        let ptr = self.active.load(Relaxed);
> +        if ptr::eq(ptr, &self.simple) {
> +            return;
> +        }
> +        // SAFETY: When the pointer is not &self.active, it is an `UpgradePollCondVarInner`.
> +        let ptr = unsafe { container_of!(ptr.cast_mut(), UpgradePollCondVarInner, upgraded) };
> +        // SAFETY: The pointer points at a valid `wait_queue_head`.
> +        unsafe { bindings::__wake_up_pollfree((*ptr).upgraded.wait_queue_head.get()) };
> +        // This skips drop of `CondVar`, but that's ok because we reimplemented its drop here.
> +        //
> +        // SAFETY: `__wake_up_pollfree` ensures that all registered PollTable instances are gone in
> +        // one grace period, and this is the destructor so no new PollTable instances can be
> +        // registered. Thus, it's safety to rcu free the `UpgradePollCondVarInner`.
> +        unsafe { bindings::kvfree_call_rcu((*ptr).rcu.get(), ptr.cast::<c_void>()) };
> +    }
> +}
> 
> -- 
> 2.53.0.273.g2a3d683680-goog
> 

