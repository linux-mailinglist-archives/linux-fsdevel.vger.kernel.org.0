Return-Path: <linux-fsdevel+bounces-76326-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CJD0IsRkg2nAmAMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76326-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 16:24:52 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 534E7E87BD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 16:24:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3E16B3047290
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Feb 2026 15:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA78428834;
	Wed,  4 Feb 2026 15:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NoRqQfUn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869533C1963
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Feb 2026 15:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770217737; cv=none; b=EvMaYy6DqTr56u9wCzyVr5+2uZc90LV/J1YjDkJ35hIXQfOzXh5enKQFDnHHjymPv0wiw/8X9oObU5zgQp3VxC5IhQs27h68cgZleEX6Tanf6YpPdRXKarmzpQIKYzJluQNsnjjmGBNXyHKSZ0+ubOKD20UPxoP1CGbK0MVGxmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770217737; c=relaxed/simple;
	bh=IjqjMOJajvnorBGXQdKraFIEBsIfZVyXFbmpkEkKipI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fKl/wr79m6wNXAyow3j4eWpjha7SE/gHNvDqLy33Q+gjna7oeEgSc/GKhwWeNv3AW++/b+Wfd7NV3MpH5mfsg3DaIPQB5UEjnbnK8qn/Q15eRRupCuXLhlZ4KcWJYlkyLdP4RXPGyiy/AEM2lBoSpNATmR/TJQnKZtuz6jmjXn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NoRqQfUn; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ea45f316-fed7-4dc5-a1d8-8cb112d93ce3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770217724;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aO4TLmZhw25T5ng/BNy9fFN25DHdxqBT0pzqkhXfyvk=;
	b=NoRqQfUnOTPOEs1AE9hoOXicqXhbbl5FbSct7Lqog25ILWFhsSKSGUOhv6qxWWUXF6VTgp
	ArBxWdKOefXIr3pj9QxpY4T9p3YhUnEPKGbr98AxoS4T/iV1CtV5Sai9a8SmLCgwqjslW+
	+B65yBsnfBZuedn3RKkQ1kp6/elMXgk=
Date: Wed, 4 Feb 2026 15:08:36 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v14 2/9] rust: rename `AlwaysRefCounted` to `RefCounted`.
To: Andreas Hindborg <a.hindborg@kernel.org>, Miguel Ojeda
 <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Leon Romanovsky <leon@kernel.org>, Paul Moore <paul@paul-moore.com>,
 Serge Hallyn <sergeh@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Igor Korotin <igor.korotin.linux@gmail.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
 Stephen Boyd <sboyd@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-block@vger.kernel.org, linux-security-module@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-pm@vger.kernel.org, linux-pci@vger.kernel.org,
 Oliver Mangold <oliver.mangold@pm.me>
References: <20260204-unique-ref-v14-0-17cb29ebacbb@kernel.org>
 <20260204-unique-ref-v14-2-17cb29ebacbb@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Igor Korotin <igor.korotin@linux.dev>
In-Reply-To: <20260204-unique-ref-v14-2-17cb29ebacbb@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76326-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,garyguo.net,protonmail.com,google.com,umich.edu,linuxfoundation.org,intel.com,paul-moore.com,ffwll.ch,zeniv.linux.org.uk,suse.cz,collabora.com,oracle.com,ti.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[40];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[igor.korotin@linux.dev,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,collabora.com:email,pm.me:email]
X-Rspamd-Queue-Id: 534E7E87BD
X-Rspamd-Action: no action

Hello Andreas

On 2/4/2026 11:56 AM, Andreas Hindborg wrote:
> From: Oliver Mangold <oliver.mangold@pm.me>
> 
> There are types where it may both be reference counted in some cases and
> owned in others. In such cases, obtaining `ARef<T>` from `&T` would be
> unsound as it allows creation of `ARef<T>` copy from `&Owned<T>`.
> 
> Therefore, we split `AlwaysRefCounted` into `RefCounted` (which `ARef<T>`
> would require) and a marker trait to indicate that the type is always
> reference counted (and not `Ownable`) so the `&T` -> `ARef<T>` conversion
> is possible.
> 
> - Rename `AlwaysRefCounted` to `RefCounted`.
> - Add a new unsafe trait `AlwaysRefCounted`.
> - Implement the new trait `AlwaysRefCounted` for the newly renamed
>    `RefCounted` implementations. This leaves functionality of existing
>    implementers of `AlwaysRefCounted` intact.
> 
> Original patch by Oliver Mangold <oliver.mangold@pm.me> [1].
> 
> Link: https://lore.kernel.org/r/20251117-unique-ref-v13-2-b5b243df1250@pm.me [1]
> Suggested-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> ---
>   rust/kernel/auxiliary.rs        |  7 +++++-
>   rust/kernel/block/mq/request.rs | 15 +++++++------
>   rust/kernel/cred.rs             | 13 ++++++++++--
>   rust/kernel/device.rs           | 10 ++++++---
>   rust/kernel/device/property.rs  |  7 +++++-
>   rust/kernel/drm/device.rs       | 10 ++++++---
>   rust/kernel/drm/gem/mod.rs      |  8 ++++---
>   rust/kernel/fs/file.rs          | 16 ++++++++++----
>   rust/kernel/i2c.rs              | 16 +++++++++-----
>   rust/kernel/mm.rs               | 15 +++++++++----
>   rust/kernel/mm/mmput_async.rs   |  9 ++++++--
>   rust/kernel/opp.rs              | 10 ++++++---
>   rust/kernel/owned.rs            |  2 +-
>   rust/kernel/pci.rs              | 10 ++++++++-
>   rust/kernel/pid_namespace.rs    | 12 +++++++++--
>   rust/kernel/platform.rs         |  7 +++++-
>   rust/kernel/sync/aref.rs        | 47 ++++++++++++++++++++++++++---------------
>   rust/kernel/task.rs             | 10 ++++++---
>   rust/kernel/types.rs            |  3 ++-
>   19 files changed, 164 insertions(+), 63 deletions(-)
> 
> diff --git a/rust/kernel/auxiliary.rs b/rust/kernel/auxiliary.rs
> index be76f11aecb7e..c410dcfc7b6f7 100644
> --- a/rust/kernel/auxiliary.rs
> +++ b/rust/kernel/auxiliary.rs
> @@ -11,6 +11,7 @@
>       driver,
>       error::{from_result, to_result, Result},
>       prelude::*,
> +    sync::aref::{AlwaysRefCounted, RefCounted},
>       types::Opaque,
>       ThisModule,
>   };
> @@ -283,7 +284,7 @@ unsafe impl<Ctx: device::DeviceContext> device::AsBusDevice<Ctx> for Device<Ctx>
>   kernel::impl_device_context_into_aref!(Device);
>   
>   // SAFETY: Instances of `Device` are always reference-counted.
> -unsafe impl crate::sync::aref::AlwaysRefCounted for Device {
> +unsafe impl RefCounted for Device {
>       fn inc_ref(&self) {
>           // SAFETY: The existence of a shared reference guarantees that the refcount is non-zero.
>           unsafe { bindings::get_device(self.as_ref().as_raw()) };
> @@ -302,6 +303,10 @@ unsafe fn dec_ref(obj: NonNull<Self>) {
>       }
>   }
>   
> +// SAFETY: We do not implement `Ownable`, thus it is okay to obtain an `ARef<Device>` from a
> +// `&Device`.
> +unsafe impl AlwaysRefCounted for Device {}
> +
>   impl<Ctx: device::DeviceContext> AsRef<device::Device<Ctx>> for Device<Ctx> {
>       fn as_ref(&self) -> &device::Device<Ctx> {
>           // SAFETY: By the type invariant of `Self`, `self.as_raw()` is a pointer to a valid
> diff --git a/rust/kernel/block/mq/request.rs b/rust/kernel/block/mq/request.rs
> index ce3e30c81cb5e..cf013b9e2cacf 100644
> --- a/rust/kernel/block/mq/request.rs
> +++ b/rust/kernel/block/mq/request.rs
> @@ -9,7 +9,7 @@
>       block::mq::Operations,
>       error::Result,
>       sync::{
> -        aref::{ARef, AlwaysRefCounted},
> +        aref::{ARef, AlwaysRefCounted, RefCounted},
>           atomic::Relaxed,
>           Refcount,
>       },
> @@ -229,11 +229,10 @@ unsafe impl<T: Operations> Send for Request<T> {}
>   // mutate `self` are internally synchronized`
>   unsafe impl<T: Operations> Sync for Request<T> {}
>   
> -// SAFETY: All instances of `Request<T>` are reference counted. This
> -// implementation of `AlwaysRefCounted` ensure that increments to the ref count
> -// keeps the object alive in memory at least until a matching reference count
> -// decrement is executed.
> -unsafe impl<T: Operations> AlwaysRefCounted for Request<T> {
> +// SAFETY: All instances of `Request<T>` are reference counted. This implementation of `RefCounted`
> +// ensure that increments to the ref count keeps the object alive in memory at least until a
> +// matching reference count decrement is executed.
> +unsafe impl<T: Operations> RefCounted for Request<T> {
>       fn inc_ref(&self) {
>           self.wrapper_ref().refcount().inc();
>       }
> @@ -255,3 +254,7 @@ unsafe fn dec_ref(obj: core::ptr::NonNull<Self>) {
>           }
>       }
>   }
> +
> +// SAFETY: We currently do not implement `Ownable`, thus it is okay to obtain an `ARef<Request>`
> +// from a `&Request` (but this will change in the future).
> +unsafe impl<T: Operations> AlwaysRefCounted for Request<T> {}
> diff --git a/rust/kernel/cred.rs b/rust/kernel/cred.rs
> index ffa156b9df377..20ef0144094be 100644
> --- a/rust/kernel/cred.rs
> +++ b/rust/kernel/cred.rs
> @@ -8,7 +8,12 @@
>   //!
>   //! Reference: <https://www.kernel.org/doc/html/latest/security/credentials.html>
>   
> -use crate::{bindings, sync::aref::AlwaysRefCounted, task::Kuid, types::Opaque};
> +use crate::{
> +    bindings,
> +    sync::aref::RefCounted,
> +    task::Kuid,
> +    types::{AlwaysRefCounted, Opaque},
> +};
>   
>   /// Wraps the kernel's `struct cred`.
>   ///
> @@ -76,7 +81,7 @@ pub fn euid(&self) -> Kuid {
>   }
>   
>   // SAFETY: The type invariants guarantee that `Credential` is always ref-counted.
> -unsafe impl AlwaysRefCounted for Credential {
> +unsafe impl RefCounted for Credential {
>       #[inline]
>       fn inc_ref(&self) {
>           // SAFETY: The existence of a shared reference means that the refcount is nonzero.
> @@ -90,3 +95,7 @@ unsafe fn dec_ref(obj: core::ptr::NonNull<Credential>) {
>           unsafe { bindings::put_cred(obj.cast().as_ptr()) };
>       }
>   }
> +
> +// SAFETY: We do not implement `Ownable`, thus it is okay to obtain an `ARef<Credential>` from a
> +// `&Credential`.
> +unsafe impl AlwaysRefCounted for Credential {}
> diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
> index 031720bf5d8ca..e09dad5f9afea 100644
> --- a/rust/kernel/device.rs
> +++ b/rust/kernel/device.rs
> @@ -7,8 +7,8 @@
>   use crate::{
>       bindings, fmt,
>       prelude::*,
> -    sync::aref::ARef,
> -    types::{ForeignOwnable, Opaque},
> +    sync::aref::{ARef, RefCounted},
> +    types::{AlwaysRefCounted, ForeignOwnable, Opaque},
>   };
>   use core::{any::TypeId, marker::PhantomData, ptr};
>   
> @@ -492,7 +492,7 @@ pub fn fwnode(&self) -> Option<&property::FwNode> {
>   kernel::impl_device_context_into_aref!(Device);
>   
>   // SAFETY: Instances of `Device` are always reference-counted.
> -unsafe impl crate::sync::aref::AlwaysRefCounted for Device {
> +unsafe impl RefCounted for Device {
>       fn inc_ref(&self) {
>           // SAFETY: The existence of a shared reference guarantees that the refcount is non-zero.
>           unsafe { bindings::get_device(self.as_raw()) };
> @@ -504,6 +504,10 @@ unsafe fn dec_ref(obj: ptr::NonNull<Self>) {
>       }
>   }
>   
> +// SAFETY: We do not implement `Ownable`, thus it is okay to obtain an `ARef<Device>` from a
> +// `&Device`.
> +unsafe impl AlwaysRefCounted for Device {}
> +
>   // SAFETY: As by the type invariant `Device` can be sent to any thread.
>   unsafe impl Send for Device {}
>   
> diff --git a/rust/kernel/device/property.rs b/rust/kernel/device/property.rs
> index 3a332a8c53a9e..a8bb824ad0ec1 100644
> --- a/rust/kernel/device/property.rs
> +++ b/rust/kernel/device/property.rs
> @@ -14,6 +14,7 @@
>       fmt,
>       prelude::*,
>       str::{CStr, CString},
> +    sync::aref::{AlwaysRefCounted, RefCounted},
>       types::{ARef, Opaque},
>   };
>   
> @@ -359,7 +360,7 @@ fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
>   }
>   
>   // SAFETY: Instances of `FwNode` are always reference-counted.
> -unsafe impl crate::types::AlwaysRefCounted for FwNode {
> +unsafe impl RefCounted for FwNode {
>       fn inc_ref(&self) {
>           // SAFETY: The existence of a shared reference guarantees that the
>           // refcount is non-zero.
> @@ -373,6 +374,10 @@ unsafe fn dec_ref(obj: ptr::NonNull<Self>) {
>       }
>   }
>   
> +// SAFETY: We do not implement `Ownable`, thus it is okay to obtain an `ARef<FwNode>` from a
> +// `&FwNode`.
> +unsafe impl AlwaysRefCounted for FwNode {}
> +
>   enum Node<'a> {
>       Borrowed(&'a FwNode),
>       Owned(ARef<FwNode>),
> diff --git a/rust/kernel/drm/device.rs b/rust/kernel/drm/device.rs
> index 3ce8f62a00569..38ce7f389ed00 100644
> --- a/rust/kernel/drm/device.rs
> +++ b/rust/kernel/drm/device.rs
> @@ -11,8 +11,8 @@
>       error::from_err_ptr,
>       error::Result,
>       prelude::*,
> -    sync::aref::{ARef, AlwaysRefCounted},
> -    types::Opaque,
> +    sync::aref::{AlwaysRefCounted, RefCounted},
> +    types::{ARef, Opaque},
>   };
>   use core::{alloc::Layout, mem, ops::Deref, ptr, ptr::NonNull};
>   
> @@ -198,7 +198,7 @@ fn deref(&self) -> &Self::Target {
>   
>   // SAFETY: DRM device objects are always reference counted and the get/put functions
>   // satisfy the requirements.
> -unsafe impl<T: drm::Driver> AlwaysRefCounted for Device<T> {
> +unsafe impl<T: drm::Driver> RefCounted for Device<T> {
>       fn inc_ref(&self) {
>           // SAFETY: The existence of a shared reference guarantees that the refcount is non-zero.
>           unsafe { bindings::drm_dev_get(self.as_raw()) };
> @@ -213,6 +213,10 @@ unsafe fn dec_ref(obj: NonNull<Self>) {
>       }
>   }
>   
> +// SAFETY: We do not implement `Ownable`, thus it is okay to obtain an `ARef<Device>` from a
> +// `&Device`.
> +unsafe impl<T: drm::Driver> AlwaysRefCounted for Device<T> {}
> +
>   impl<T: drm::Driver> AsRef<device::Device> for Device<T> {
>       fn as_ref(&self) -> &device::Device {
>           // SAFETY: `bindings::drm_device::dev` is valid as long as the DRM device itself is valid,
> diff --git a/rust/kernel/drm/gem/mod.rs b/rust/kernel/drm/gem/mod.rs
> index a7f682e95c018..ad6840a440165 100644
> --- a/rust/kernel/drm/gem/mod.rs
> +++ b/rust/kernel/drm/gem/mod.rs
> @@ -10,8 +10,7 @@
>       drm::driver::{AllocImpl, AllocOps},
>       error::{to_result, Result},
>       prelude::*,
> -    sync::aref::{ARef, AlwaysRefCounted},
> -    types::Opaque,
> +    types::{ARef, AlwaysRefCounted, Opaque},
>   };
>   use core::{ops::Deref, ptr::NonNull};
>   
> @@ -253,7 +252,7 @@ extern "C" fn free_callback(obj: *mut bindings::drm_gem_object) {
>   }
>   
>   // SAFETY: Instances of `Object<T>` are always reference-counted.
> -unsafe impl<T: DriverObject> crate::types::AlwaysRefCounted for Object<T> {
> +unsafe impl<T: DriverObject> crate::types::RefCounted for Object<T> {
>       fn inc_ref(&self) {
>           // SAFETY: The existence of a shared reference guarantees that the refcount is non-zero.
>           unsafe { bindings::drm_gem_object_get(self.as_raw()) };
> @@ -267,6 +266,9 @@ unsafe fn dec_ref(obj: NonNull<Self>) {
>           unsafe { bindings::drm_gem_object_put(obj.as_raw()) }
>       }
>   }
> +// SAFETY: We do not implement `Ownable`, thus it is okay to obtain an `ARef<Device>` from a
> +// `&Object`.
> +unsafe impl<T: DriverObject> crate::types::AlwaysRefCounted for Object<T> {}
>   
>   impl<T: DriverObject> super::private::Sealed for Object<T> {}
>   
> diff --git a/rust/kernel/fs/file.rs b/rust/kernel/fs/file.rs
> index 23ee689bd2400..06e457d62a939 100644
> --- a/rust/kernel/fs/file.rs
> +++ b/rust/kernel/fs/file.rs
> @@ -12,8 +12,8 @@
>       cred::Credential,
>       error::{code::*, to_result, Error, Result},
>       fmt,
> -    sync::aref::{ARef, AlwaysRefCounted},
> -    types::{NotThreadSafe, Opaque},
> +    sync::aref::RefCounted,
> +    types::{ARef, AlwaysRefCounted, NotThreadSafe, Opaque},
>   };
>   use core::ptr;
>   
> @@ -197,7 +197,7 @@ unsafe impl Sync for File {}
>   
>   // SAFETY: The type invariants guarantee that `File` is always ref-counted. This implementation
>   // makes `ARef<File>` own a normal refcount.
> -unsafe impl AlwaysRefCounted for File {
> +unsafe impl RefCounted for File {
>       #[inline]
>       fn inc_ref(&self) {
>           // SAFETY: The existence of a shared reference means that the refcount is nonzero.
> @@ -212,6 +212,10 @@ unsafe fn dec_ref(obj: ptr::NonNull<File>) {
>       }
>   }
>   
> +// SAFETY: We do not implement `Ownable`, thus it is okay to obtain an `ARef<File>` from a
> +// `&File`.
> +unsafe impl AlwaysRefCounted for File {}
> +
>   /// Wraps the kernel's `struct file`. Not thread safe.
>   ///
>   /// This type represents a file that is not known to be safe to transfer across thread boundaries.
> @@ -233,7 +237,7 @@ pub struct LocalFile {
>   
>   // SAFETY: The type invariants guarantee that `LocalFile` is always ref-counted. This implementation
>   // makes `ARef<LocalFile>` own a normal refcount.
> -unsafe impl AlwaysRefCounted for LocalFile {
> +unsafe impl RefCounted for LocalFile {
>       #[inline]
>       fn inc_ref(&self) {
>           // SAFETY: The existence of a shared reference means that the refcount is nonzero.
> @@ -249,6 +253,10 @@ unsafe fn dec_ref(obj: ptr::NonNull<LocalFile>) {
>       }
>   }
>   
> +// SAFETY: We do not implement `Ownable`, thus it is okay to obtain an `ARef<LocalFile>` from a
> +// `&LocalFile`.
> +unsafe impl AlwaysRefCounted for LocalFile {}
> +
>   impl LocalFile {
>       /// Constructs a new `struct file` wrapper from a file descriptor.
>       ///
> diff --git a/rust/kernel/i2c.rs b/rust/kernel/i2c.rs
> index 39b0a9a207fda..b5e3c236a5c16 100644
> --- a/rust/kernel/i2c.rs
> +++ b/rust/kernel/i2c.rs
> @@ -17,8 +17,10 @@
>       of,
>       prelude::*,
>       types::{
> +        ARef,
>           AlwaysRefCounted,
> -        Opaque, //
> +        Opaque,
> +        RefCounted, //
>       }, //
>   };
>   
> @@ -31,8 +33,6 @@
>       }, //
>   };
>   
> -use kernel::types::ARef;
> -
>   /// An I2C device id table.
>   #[repr(transparent)]
>   #[derive(Clone, Copy)]
> @@ -416,7 +416,7 @@ pub fn get(index: i32) -> Result<ARef<Self>> {
>   kernel::impl_device_context_into_aref!(I2cAdapter);
>   
>   // SAFETY: Instances of `I2cAdapter` are always reference-counted.
> -unsafe impl crate::types::AlwaysRefCounted for I2cAdapter {
> +unsafe impl crate::types::RefCounted for I2cAdapter {
>       fn inc_ref(&self) {
>           // SAFETY: The existence of a shared reference guarantees that the refcount is non-zero.
>           unsafe { bindings::i2c_get_adapter(self.index()) };
> @@ -427,6 +427,9 @@ unsafe fn dec_ref(obj: NonNull<Self>) {
>           unsafe { bindings::i2c_put_adapter(obj.as_ref().as_raw()) }
>       }
>   }
> +// SAFETY: We do not implement `Ownable`, thus it is okay to obtain an `ARef<Device>` from an
> +// `&I2cAdapter`.
> +unsafe impl AlwaysRefCounted for I2cAdapter {}
>   
>   /// The i2c board info representation
>   ///
> @@ -492,7 +495,7 @@ unsafe impl<Ctx: device::DeviceContext> device::AsBusDevice<Ctx> for I2cClient<C
>   kernel::impl_device_context_into_aref!(I2cClient);
>   
>   // SAFETY: Instances of `I2cClient` are always reference-counted.
> -unsafe impl AlwaysRefCounted for I2cClient {
> +unsafe impl RefCounted for I2cClient {
>       fn inc_ref(&self) {
>           // SAFETY: The existence of a shared reference guarantees that the refcount is non-zero.
>           unsafe { bindings::get_device(self.as_ref().as_raw()) };
> @@ -503,6 +506,9 @@ unsafe fn dec_ref(obj: NonNull<Self>) {
>           unsafe { bindings::put_device(&raw mut (*obj.as_ref().as_raw()).dev) }
>       }
>   }
> +// SAFETY: We do not implement `Ownable`, thus it is okay to obtain an `ARef<Device>` from an
> +// `&I2cClient`.
> +unsafe impl AlwaysRefCounted for I2cClient {}
>   
>   impl<Ctx: device::DeviceContext> AsRef<device::Device<Ctx>> for I2cClient<Ctx> {
>       fn as_ref(&self) -> &device::Device<Ctx> {
> diff --git a/rust/kernel/mm.rs b/rust/kernel/mm.rs
> index 4764d7b68f2a7..dd9e3969e7206 100644
> --- a/rust/kernel/mm.rs
> +++ b/rust/kernel/mm.rs
> @@ -13,8 +13,8 @@
>   
>   use crate::{
>       bindings,
> -    sync::aref::{ARef, AlwaysRefCounted},
> -    types::{NotThreadSafe, Opaque},
> +    sync::aref::RefCounted,
> +    types::{ARef, AlwaysRefCounted, NotThreadSafe, Opaque},
>   };
>   use core::{ops::Deref, ptr::NonNull};
>   
> @@ -55,7 +55,7 @@ unsafe impl Send for Mm {}
>   unsafe impl Sync for Mm {}
>   
>   // SAFETY: By the type invariants, this type is always refcounted.
> -unsafe impl AlwaysRefCounted for Mm {
> +unsafe impl RefCounted for Mm {
>       #[inline]
>       fn inc_ref(&self) {
>           // SAFETY: The pointer is valid since self is a reference.
> @@ -69,6 +69,9 @@ unsafe fn dec_ref(obj: NonNull<Self>) {
>       }
>   }
>   
> +// SAFETY: We do not implement `Ownable`, thus it is okay to obtain an `ARef<Mm>` from a `&Mm`.
> +unsafe impl AlwaysRefCounted for Mm {}
> +
>   /// A wrapper for the kernel's `struct mm_struct`.
>   ///
>   /// This type is like [`Mm`], but with non-zero `mm_users`. It can only be used when `mm_users` can
> @@ -91,7 +94,7 @@ unsafe impl Send for MmWithUser {}
>   unsafe impl Sync for MmWithUser {}
>   
>   // SAFETY: By the type invariants, this type is always refcounted.
> -unsafe impl AlwaysRefCounted for MmWithUser {
> +unsafe impl RefCounted for MmWithUser {
>       #[inline]
>       fn inc_ref(&self) {
>           // SAFETY: The pointer is valid since self is a reference.
> @@ -105,6 +108,10 @@ unsafe fn dec_ref(obj: NonNull<Self>) {
>       }
>   }
>   
> +// SAFETY: We do not implement `Ownable`, thus it is okay to obtain an `ARef<MmWithUser>` from a
> +// `&MmWithUser`.
> +unsafe impl AlwaysRefCounted for MmWithUser {}
> +
>   // Make all `Mm` methods available on `MmWithUser`.
>   impl Deref for MmWithUser {
>       type Target = Mm;
> diff --git a/rust/kernel/mm/mmput_async.rs b/rust/kernel/mm/mmput_async.rs
> index b8d2f051225c7..aba4ce675c860 100644
> --- a/rust/kernel/mm/mmput_async.rs
> +++ b/rust/kernel/mm/mmput_async.rs
> @@ -10,7 +10,8 @@
>   use crate::{
>       bindings,
>       mm::MmWithUser,
> -    sync::aref::{ARef, AlwaysRefCounted},
> +    sync::aref::RefCounted,
> +    types::{ARef, AlwaysRefCounted},
>   };
>   use core::{ops::Deref, ptr::NonNull};
>   
> @@ -34,7 +35,7 @@ unsafe impl Send for MmWithUserAsync {}
>   unsafe impl Sync for MmWithUserAsync {}
>   
>   // SAFETY: By the type invariants, this type is always refcounted.
> -unsafe impl AlwaysRefCounted for MmWithUserAsync {
> +unsafe impl RefCounted for MmWithUserAsync {
>       #[inline]
>       fn inc_ref(&self) {
>           // SAFETY: The pointer is valid since self is a reference.
> @@ -48,6 +49,10 @@ unsafe fn dec_ref(obj: NonNull<Self>) {
>       }
>   }
>   
> +// SAFETY: We do not implement `Ownable`, thus it is okay to obtain an `ARef<MmWithUserAsync>`
> +// from a `&MmWithUserAsync`.
> +unsafe impl AlwaysRefCounted for MmWithUserAsync {}
> +
>   // Make all `MmWithUser` methods available on `MmWithUserAsync`.
>   impl Deref for MmWithUserAsync {
>       type Target = MmWithUser;
> diff --git a/rust/kernel/opp.rs b/rust/kernel/opp.rs
> index a760fac287655..06fe2ca776a4f 100644
> --- a/rust/kernel/opp.rs
> +++ b/rust/kernel/opp.rs
> @@ -16,8 +16,8 @@
>       ffi::{c_char, c_ulong},
>       prelude::*,
>       str::CString,
> -    sync::aref::{ARef, AlwaysRefCounted},
> -    types::Opaque,
> +    sync::aref::RefCounted,
> +    types::{ARef, AlwaysRefCounted, Opaque},
>   };
>   
>   #[cfg(CONFIG_CPU_FREQ)]
> @@ -1041,7 +1041,7 @@ unsafe impl Send for OPP {}
>   unsafe impl Sync for OPP {}
>   
>   /// SAFETY: The type invariants guarantee that [`OPP`] is always refcounted.
> -unsafe impl AlwaysRefCounted for OPP {
> +unsafe impl RefCounted for OPP {
>       fn inc_ref(&self) {
>           // SAFETY: The existence of a shared reference means that the refcount is nonzero.
>           unsafe { bindings::dev_pm_opp_get(self.0.get()) };
> @@ -1053,6 +1053,10 @@ unsafe fn dec_ref(obj: ptr::NonNull<Self>) {
>       }
>   }
>   
> +// SAFETY: We do not implement `Ownable`, thus it is okay to obtain an `ARef<OPP>` from an
> +// `&OPP`.
> +unsafe impl AlwaysRefCounted for OPP {}
> +
>   impl OPP {
>       /// Creates an owned reference to a [`OPP`] from a valid pointer.
>       ///
> diff --git a/rust/kernel/owned.rs b/rust/kernel/owned.rs
> index fe30580331df9..b02edda11fcf6 100644
> --- a/rust/kernel/owned.rs
> +++ b/rust/kernel/owned.rs
> @@ -25,7 +25,7 @@
>   ///
>   /// Note: The underlying object is not required to provide internal reference counting, because it
>   /// represents a unique, owned reference. If reference counting (on the Rust side) is required,
> -/// [`AlwaysRefCounted`](crate::types::AlwaysRefCounted) should be implemented.
> +/// [`RefCounted`](crate::types::RefCounted) should be implemented.
>   ///
>   /// # Safety
>   ///
> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
> index bea76ca9c3da5..9ee8f2bc6db9e 100644
> --- a/rust/kernel/pci.rs
> +++ b/rust/kernel/pci.rs
> @@ -19,6 +19,10 @@
>       },
>       prelude::*,
>       str::CStr,
> +    sync::aref::{
> +        AlwaysRefCounted,
> +        RefCounted, //
> +    },
>       types::Opaque,
>       ThisModule, //
>   };
> @@ -467,7 +471,7 @@ unsafe impl<Ctx: device::DeviceContext> device::AsBusDevice<Ctx> for Device<Ctx>
>   impl crate::dma::Device for Device<device::Core> {}
>   
>   // SAFETY: Instances of `Device` are always reference-counted.
> -unsafe impl crate::sync::aref::AlwaysRefCounted for Device {
> +unsafe impl RefCounted for Device {
>       fn inc_ref(&self) {
>           // SAFETY: The existence of a shared reference guarantees that the refcount is non-zero.
>           unsafe { bindings::pci_dev_get(self.as_raw()) };
> @@ -479,6 +483,10 @@ unsafe fn dec_ref(obj: NonNull<Self>) {
>       }
>   }
>   
> +// SAFETY: We do not implement `Ownable`, thus it is okay to obtain an `ARef<Device>` from a
> +// `&Device`.
> +unsafe impl AlwaysRefCounted for Device {}
> +
>   impl<Ctx: device::DeviceContext> AsRef<device::Device<Ctx>> for Device<Ctx> {
>       fn as_ref(&self) -> &device::Device<Ctx> {
>           // SAFETY: By the type invariant of `Self`, `self.as_raw()` is a pointer to a valid
> diff --git a/rust/kernel/pid_namespace.rs b/rust/kernel/pid_namespace.rs
> index 979a9718f153d..4f6a94540e33d 100644
> --- a/rust/kernel/pid_namespace.rs
> +++ b/rust/kernel/pid_namespace.rs
> @@ -7,7 +7,11 @@
>   //! C header: [`include/linux/pid_namespace.h`](srctree/include/linux/pid_namespace.h) and
>   //! [`include/linux/pid.h`](srctree/include/linux/pid.h)
>   
> -use crate::{bindings, sync::aref::AlwaysRefCounted, types::Opaque};
> +use crate::{
> +    bindings,
> +    sync::aref::RefCounted,
> +    types::{AlwaysRefCounted, Opaque},
> +};
>   use core::ptr;
>   
>   /// Wraps the kernel's `struct pid_namespace`. Thread safe.
> @@ -41,7 +45,7 @@ pub unsafe fn from_ptr<'a>(ptr: *const bindings::pid_namespace) -> &'a Self {
>   }
>   
>   // SAFETY: Instances of `PidNamespace` are always reference-counted.
> -unsafe impl AlwaysRefCounted for PidNamespace {
> +unsafe impl RefCounted for PidNamespace {
>       #[inline]
>       fn inc_ref(&self) {
>           // SAFETY: The existence of a shared reference means that the refcount is nonzero.
> @@ -55,6 +59,10 @@ unsafe fn dec_ref(obj: ptr::NonNull<PidNamespace>) {
>       }
>   }
>   
> +// SAFETY: We do not implement `Ownable`, thus it is okay to obtain an `ARef<PidNamespace>` from
> +// a `&PidNamespace`.
> +unsafe impl AlwaysRefCounted for PidNamespace {}
> +
>   // SAFETY:
>   // - `PidNamespace::dec_ref` can be called from any thread.
>   // - It is okay to send ownership of `PidNamespace` across thread boundaries.
> diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
> index 35a5813ffb33f..139517c21961e 100644
> --- a/rust/kernel/platform.rs
> +++ b/rust/kernel/platform.rs
> @@ -13,6 +13,7 @@
>       irq::{self, IrqRequest},
>       of,
>       prelude::*,
> +    sync::aref::{AlwaysRefCounted, RefCounted},
>       types::Opaque,
>       ThisModule,
>   };
> @@ -490,7 +491,7 @@ pub fn optional_irq_by_name(&self, name: &CStr) -> Result<IrqRequest<'_>> {
>   impl crate::dma::Device for Device<device::Core> {}
>   
>   // SAFETY: Instances of `Device` are always reference-counted.
> -unsafe impl crate::sync::aref::AlwaysRefCounted for Device {
> +unsafe impl RefCounted for Device {
>       fn inc_ref(&self) {
>           // SAFETY: The existence of a shared reference guarantees that the refcount is non-zero.
>           unsafe { bindings::get_device(self.as_ref().as_raw()) };
> @@ -502,6 +503,10 @@ unsafe fn dec_ref(obj: NonNull<Self>) {
>       }
>   }
>   
> +// SAFETY: We do not implement `Ownable`, thus it is okay to obtain an `ARef<Device>` from a
> +// `&Device`.
> +unsafe impl AlwaysRefCounted for Device {}
> +
>   impl<Ctx: device::DeviceContext> AsRef<device::Device<Ctx>> for Device<Ctx> {
>       fn as_ref(&self) -> &device::Device<Ctx> {
>           // SAFETY: By the type invariant of `Self`, `self.as_raw()` is a pointer to a valid
> diff --git a/rust/kernel/sync/aref.rs b/rust/kernel/sync/aref.rs
> index e175aefe86151..61caddfd89619 100644
> --- a/rust/kernel/sync/aref.rs
> +++ b/rust/kernel/sync/aref.rs
> @@ -19,11 +19,9 @@
>   
>   use core::{marker::PhantomData, mem::ManuallyDrop, ops::Deref, ptr::NonNull};
>   
> -/// Types that are _always_ reference counted.
> +/// Types that are internally reference counted.
>   ///
>   /// It allows such types to define their own custom ref increment and decrement functions.
> -/// Additionally, it allows users to convert from a shared reference `&T` to an owned reference
> -/// [`ARef<T>`].
>   ///
>   /// This is usually implemented by wrappers to existing structures on the C side of the code. For
>   /// Rust code, the recommendation is to use [`Arc`](crate::sync::Arc) to create reference-counted
> @@ -40,9 +38,8 @@
>   /// at least until matching decrements are performed.
>   ///
>   /// Implementers must also ensure that all instances are reference-counted. (Otherwise they
> -/// won't be able to honour the requirement that [`AlwaysRefCounted::inc_ref`] keep the object
> -/// alive.)
> -pub unsafe trait AlwaysRefCounted {
> +/// won't be able to honour the requirement that [`RefCounted::inc_ref`] keep the object alive.)
> +pub unsafe trait RefCounted {
>       /// Increments the reference count on the object.
>       fn inc_ref(&self);
>   
> @@ -55,11 +52,27 @@ pub unsafe trait AlwaysRefCounted {
>       /// Callers must ensure that there was a previous matching increment to the reference count,
>       /// and that the object is no longer used after its reference count is decremented (as it may
>       /// result in the object being freed), unless the caller owns another increment on the refcount
> -    /// (e.g., it calls [`AlwaysRefCounted::inc_ref`] twice, then calls
> -    /// [`AlwaysRefCounted::dec_ref`] once).
> +    /// (e.g., it calls [`RefCounted::inc_ref`] twice, then calls [`RefCounted::dec_ref`] once).
>       unsafe fn dec_ref(obj: NonNull<Self>);
>   }
>   
> +/// Always reference-counted type.
> +///
> +/// It allows deriving a counted reference [`ARef<T>`] from a `&T`.
> +///
> +/// This provides some convenience, but it allows "escaping" borrow checks on `&T`. As it
> +/// complicates attempts to ensure that a reference to T is unique, it is optional to provide for
> +/// [`RefCounted`] types. See *Safety* below.
> +///
> +/// # Safety
> +///
> +/// Implementers must ensure that no safety invariants are violated by upgrading an `&T` to an
> +/// [`ARef<T>`]. In particular that implies [`AlwaysRefCounted`] and [`crate::types::Ownable`]
> +/// cannot be implemented for the same type, as this would allow violating the uniqueness guarantee
> +/// of [`crate::types::Owned<T>`] by dereferencing it into an `&T` and obtaining an [`ARef`] from
> +/// that.
> +pub unsafe trait AlwaysRefCounted: RefCounted {}
> +
>   /// An owned reference to an always-reference-counted object.
>   ///
>   /// The object's reference count is automatically decremented when an instance of [`ARef`] is
> @@ -70,7 +83,7 @@ pub unsafe trait AlwaysRefCounted {
>   ///
>   /// The pointer stored in `ptr` is non-null and valid for the lifetime of the [`ARef`] instance. In
>   /// particular, the [`ARef`] instance owns an increment on the underlying object's reference count.
> -pub struct ARef<T: AlwaysRefCounted> {
> +pub struct ARef<T: RefCounted> {
>       ptr: NonNull<T>,
>       _p: PhantomData<T>,
>   }
> @@ -79,16 +92,16 @@ pub struct ARef<T: AlwaysRefCounted> {
>   // it effectively means sharing `&T` (which is safe because `T` is `Sync`); additionally, it needs
>   // `T` to be `Send` because any thread that has an `ARef<T>` may ultimately access `T` using a
>   // mutable reference, for example, when the reference count reaches zero and `T` is dropped.
> -unsafe impl<T: AlwaysRefCounted + Sync + Send> Send for ARef<T> {}
> +unsafe impl<T: RefCounted + Sync + Send> Send for ARef<T> {}
>   
>   // SAFETY: It is safe to send `&ARef<T>` to another thread when the underlying `T` is `Sync`
>   // because it effectively means sharing `&T` (which is safe because `T` is `Sync`); additionally,
>   // it needs `T` to be `Send` because any thread that has a `&ARef<T>` may clone it and get an
>   // `ARef<T>` on that thread, so the thread may ultimately access `T` using a mutable reference, for
>   // example, when the reference count reaches zero and `T` is dropped.
> -unsafe impl<T: AlwaysRefCounted + Sync + Send> Sync for ARef<T> {}
> +unsafe impl<T: RefCounted + Sync + Send> Sync for ARef<T> {}
>   
> -impl<T: AlwaysRefCounted> ARef<T> {
> +impl<T: RefCounted> ARef<T> {
>       /// Creates a new instance of [`ARef`].
>       ///
>       /// It takes over an increment of the reference count on the underlying object.
> @@ -117,12 +130,12 @@ pub unsafe fn from_raw(ptr: NonNull<T>) -> Self {
>       ///
>       /// ```
>       /// use core::ptr::NonNull;
> -    /// use kernel::sync::aref::{ARef, AlwaysRefCounted};
> +    /// use kernel::sync::aref::{ARef, RefCounted};
>       ///
>       /// struct Empty {}
>       ///
>       /// # // SAFETY: TODO.
> -    /// unsafe impl AlwaysRefCounted for Empty {
> +    /// unsafe impl RefCounted for Empty {
>       ///     fn inc_ref(&self) {}
>       ///     unsafe fn dec_ref(_obj: NonNull<Self>) {}
>       /// }
> @@ -140,7 +153,7 @@ pub fn into_raw(me: Self) -> NonNull<T> {
>       }
>   }
>   
> -impl<T: AlwaysRefCounted> Clone for ARef<T> {
> +impl<T: RefCounted> Clone for ARef<T> {
>       fn clone(&self) -> Self {
>           self.inc_ref();
>           // SAFETY: We just incremented the refcount above.
> @@ -148,7 +161,7 @@ fn clone(&self) -> Self {
>       }
>   }
>   
> -impl<T: AlwaysRefCounted> Deref for ARef<T> {
> +impl<T: RefCounted> Deref for ARef<T> {
>       type Target = T;
>   
>       fn deref(&self) -> &Self::Target {
> @@ -165,7 +178,7 @@ fn from(b: &T) -> Self {
>       }
>   }
>   
> -impl<T: AlwaysRefCounted> Drop for ARef<T> {
> +impl<T: RefCounted> Drop for ARef<T> {
>       fn drop(&mut self) {
>           // SAFETY: The type invariants guarantee that the `ARef` owns the reference we're about to
>           // decrement.
> diff --git a/rust/kernel/task.rs b/rust/kernel/task.rs
> index 49fad6de06740..0a6e38d984560 100644
> --- a/rust/kernel/task.rs
> +++ b/rust/kernel/task.rs
> @@ -9,8 +9,8 @@
>       ffi::{c_int, c_long, c_uint},
>       mm::MmWithUser,
>       pid_namespace::PidNamespace,
> -    sync::aref::ARef,
> -    types::{NotThreadSafe, Opaque},
> +    sync::aref::{AlwaysRefCounted, RefCounted},
> +    types::{ARef, NotThreadSafe, Opaque},
>   };
>   use core::{
>       cmp::{Eq, PartialEq},
> @@ -348,7 +348,7 @@ pub fn active_pid_ns(&self) -> Option<&PidNamespace> {
>   }
>   
>   // SAFETY: The type invariants guarantee that `Task` is always refcounted.
> -unsafe impl crate::sync::aref::AlwaysRefCounted for Task {
> +unsafe impl RefCounted for Task {
>       #[inline]
>       fn inc_ref(&self) {
>           // SAFETY: The existence of a shared reference means that the refcount is nonzero.
> @@ -362,6 +362,10 @@ unsafe fn dec_ref(obj: ptr::NonNull<Self>) {
>       }
>   }
>   
> +// SAFETY: We do not implement `Ownable`, thus it is okay to obtain an `ARef<Task>` from a
> +// `&Task`.
> +unsafe impl AlwaysRefCounted for Task {}
> +
>   impl Kuid {
>       /// Get the current euid.
>       #[inline]
> diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
> index 4aec7b699269a..9b96aa2ebdb7e 100644
> --- a/rust/kernel/types.rs
> +++ b/rust/kernel/types.rs
> @@ -18,7 +18,8 @@
>       },
>       sync::aref::{
>           ARef,
> -        AlwaysRefCounted, //
> +        AlwaysRefCounted,
> +        RefCounted, //
>       }, //
>   };
>   
> 

For Rust I2C subsystem:

Acked-by: Igor Korotin <igor.korotin.linux@gmail.com>

Thanks
Igor

