Return-Path: <linux-fsdevel+bounces-62134-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F3E1B85518
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 16:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45798544DF1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 14:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F9C30CB34;
	Thu, 18 Sep 2025 14:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="k1xLcwX/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-4325.protonmail.ch (mail-4325.protonmail.ch [185.70.43.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A0C2FBDEB;
	Thu, 18 Sep 2025 14:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758206740; cv=none; b=fajd/ZtPIcHR1VEkVDAccftHihlNz2jLcBu2jgBJRNL/14cQke8R4iH6SfrUMn9QqPYNyVHetKmTZAtr4BeQd4vCapHPytEoIp2REAuMTNv8CR6p8AIfPNZ63HjFStsgz9lIT948jSDiaDfvqQPZ6xEeybiqDCpxbtiFxncjqJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758206740; c=relaxed/simple;
	bh=FqKN3y9EJEW0j8ov4oajdKc8YkhGP3e6hjWAMhhQ43k=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dwjJnB4zFbNUjMFnLpX8YIowKDk+Q6qqS2G9UJaa+AbkgPjp8Dt2Q0R34bMq+ZBPHs0y86bD57uQS22kJ4hF9NL3e/ev3Lxo54luDck/aIhUr5OEFHROfU2+g02A/Tia1b0tDzj6B80DrL2/I6o89QJzHifDok88g3odbbqsLzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=k1xLcwX/; arc=none smtp.client-ip=185.70.43.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1758206735; x=1758465935;
	bh=m+R27tzJ7AmHjz4WVvVD6BHl+2wxeikQjtVZLPSv+t8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=k1xLcwX/oo9Lf6mtVPDUyNlBda5tO3thhGFMfeEBhwnQWRtC0ayZ7tx1TY2V4Rr95
	 Fls61q2Bpkt6N4RduYt7ChOWuEa8VSWJHF+gsRvFWhNYFSjuKDo50rriqK+9xMYAPT
	 eh1xXZnBRBHCfwkwcXNXwMK6F/HRj4k2vya+wTbF2Mz1T/pZ0Wm51lD2/Ppbz+F72e
	 wWYzWeNmIWiyjmjra7Lt0ET4S6futlsxErTe5zTYwowUHhUCis5y60Osra5oFHmvXv
	 WEuik1syH5Uhb4rm/jXKExGI3h1P3YW0fAza6q5JFFMDCKhv92WdK5snP42xc3l+D5
	 JEbLROai/n/gA==
Date: Thu, 18 Sep 2025 14:45:28 +0000
To: "aliceryhl@google.com" <aliceryhl@google.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "arnd@arndb.de" <arnd@arndb.de>
From: ManeraKai <manerakai@protonmail.com>
Cc: "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "manerakai@protonmail.com" <manerakai@protonmail.com>
Subject: [PATCH 1/3] rust: miscdevice: Moved `MiscDevice` to a more general abstraction
Message-ID: <20250918144356.28585-2-manerakai@protonmail.com>
In-Reply-To: <20250918144356.28585-1-manerakai@protonmail.com>
References: <20250918144356.28585-1-manerakai@protonmail.com>
Feedback-ID: 38045798:user:proton
X-Pm-Message-ID: 78458ab6c2c2afb94af3e6754a82a25015208283
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This new general abstraction is called `FileOperations`.

`struct file_operations` is not only meant for misc. Its methods are
accessible from any other driver type. This change, however, doesn't
generalize the safe wrapping for all driver types, but rather just the
method declarations. The actual safe wrappings are left for every driver
type to implement. This may make each implementation simpler. For
example, misc can choose not to implement the safe wrapping for `lock`,
`sendfile`, or `sendpage`, since they have no use in misc drivers.

Signed-off-by: ManeraKai <manerakai@protonmail.com>
---
 rust/kernel/fs.rs                 |  1 +
 rust/kernel/fs/file_operations.rs | 91 +++++++++++++++++++++++++++++++
 rust/kernel/miscdevice.rs         | 86 ++---------------------------
 samples/rust/rust_misc_device.rs  |  6 +-
 4 files changed, 101 insertions(+), 83 deletions(-)
 create mode 100644 rust/kernel/fs/file_operations.rs

diff --git a/rust/kernel/fs.rs b/rust/kernel/fs.rs
index 0121b38c59e6..94519b41086b 100644
--- a/rust/kernel/fs.rs
+++ b/rust/kernel/fs.rs
@@ -5,4 +5,5 @@
 //! C headers: [`include/linux/fs.h`](srctree/include/linux/fs.h)
=20
 pub mod file;
+pub mod file_operations;
 pub use self::file::{File, LocalFile};
diff --git a/rust/kernel/fs/file_operations.rs b/rust/kernel/fs/file_operat=
ions.rs
new file mode 100644
index 000000000000..aa60cd46a012
--- /dev/null
+++ b/rust/kernel/fs/file_operations.rs
@@ -0,0 +1,91 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Wrapper for struct file_operations.
+//!
+//! C headers: [`include/linux/fs.h`](srctree/include/linux/fs.h).
+
+use macros::vtable;
+
+#[cfg(CONFIG_COMPAT)]
+use crate::fs::File;
+use crate::{
+    build_error,
+    error::{Result, VTABLE_DEFAULT_ERROR},
+    miscdevice::MiscDeviceRegistration,
+    mm::virt::VmaNew,
+    seq_file::SeqFile,
+    types::ForeignOwnable,
+};
+
+/// Trait implemented by the private data of an open misc device.
+#[vtable]
+pub trait FileOperations: Sized {
+    /// What kind of pointer should `Self` be wrapped in.
+    type Ptr: ForeignOwnable + Send + Sync;
+
+    /// Called when the misc device is opened.
+    ///
+    /// The returned pointer will be stored as the private data for the fi=
le.
+    fn open(_file: &File, _misc: &MiscDeviceRegistration<Self>) -> Result<=
Self::Ptr>;
+
+    /// Called when the misc device is released.
+    fn release(device: Self::Ptr, _file: &File) {
+        drop(device);
+    }
+
+    /// Handle for mmap.
+    ///
+    /// This function is invoked when a user space process invokes the `mm=
ap` system call on
+    /// `file`. The function is a callback that is part of the VMA initial=
izer. The kernel will do
+    /// initial setup of the VMA before calling this function. The functio=
n can then interact with
+    /// the VMA initialization by calling methods of `vma`. If the functio=
n does not return an
+    /// error, the kernel will complete initialization of the VMA accordin=
g to the properties of
+    /// `vma`.
+    fn mmap(
+        _device: <Self::Ptr as ForeignOwnable>::Borrowed<'_>,
+        _file: &File,
+        _vma: &VmaNew,
+    ) -> Result {
+        build_error!(VTABLE_DEFAULT_ERROR)
+    }
+
+    /// Handler for ioctls.
+    ///
+    /// The `cmd` argument is usually manipulated using the utilities in [=
`kernel::ioctl`].
+    ///
+    /// [`kernel::ioctl`]: mod@crate::ioctl
+    fn ioctl(
+        _device: <Self::Ptr as ForeignOwnable>::Borrowed<'_>,
+        _file: &File,
+        _cmd: u32,
+        _arg: usize,
+    ) -> Result<isize> {
+        build_error!(VTABLE_DEFAULT_ERROR)
+    }
+
+    /// Handler for ioctls.
+    ///
+    /// Used for 32-bit userspace on 64-bit platforms.
+    ///
+    /// This method is optional and only needs to be provided if the ioctl=
 relies on structures
+    /// that have different layout on 32-bit and 64-bit userspace. If no i=
mplementation is
+    /// provided, then `compat_ptr_ioctl` will be used instead.
+    #[cfg(CONFIG_COMPAT)]
+    fn compat_ioctl(
+        _device: <Self::Ptr as ForeignOwnable>::Borrowed<'_>,
+        _file: &File,
+        _cmd: u32,
+        _arg: usize,
+    ) -> Result<isize> {
+        build_error!(VTABLE_DEFAULT_ERROR)
+    }
+
+    /// Show info for this fd.
+    fn show_fdinfo(
+        _device: <Self::Ptr as ForeignOwnable>::Borrowed<'_>,
+        _m: &SeqFile,
+        _file: &File,
+    ) {
+        build_error!(VTABLE_DEFAULT_ERROR)
+    }
+}
diff --git a/rust/kernel/miscdevice.rs b/rust/kernel/miscdevice.rs
index 6373fe183b27..578f33383ce6 100644
--- a/rust/kernel/miscdevice.rs
+++ b/rust/kernel/miscdevice.rs
@@ -11,9 +11,9 @@
 use crate::{
     bindings,
     device::Device,
-    error::{to_result, Error, Result, VTABLE_DEFAULT_ERROR},
+    error::{to_result, Error},
     ffi::{c_int, c_long, c_uint, c_ulong},
-    fs::File,
+    fs::{file_operations::FileOperations, File},
     mm::virt::VmaNew,
     prelude::*,
     seq_file::SeqFile,
@@ -30,7 +30,7 @@ pub struct MiscDeviceOptions {
=20
 impl MiscDeviceOptions {
     /// Create a raw `struct miscdev` ready for registration.
-    pub const fn into_raw<T: MiscDevice>(self) -> bindings::miscdevice {
+    pub const fn into_raw<T: FileOperations>(self) -> bindings::miscdevice=
 {
         // SAFETY: All zeros is valid for this C type.
         let mut result: bindings::miscdevice =3D unsafe { MaybeUninit::zer=
oed().assume_init() };
         result.minor =3D bindings::MISC_DYNAMIC_MINOR as ffi::c_int;
@@ -66,7 +66,7 @@ unsafe impl<T> Send for MiscDeviceRegistration<T> {}
 // parallel.
 unsafe impl<T> Sync for MiscDeviceRegistration<T> {}
=20
-impl<T: MiscDevice> MiscDeviceRegistration<T> {
+impl<T: FileOperations> MiscDeviceRegistration<T> {
     /// Register a misc device.
     pub fn register(opts: MiscDeviceOptions) -> impl PinInit<Self, Error> =
{
         try_pin_init!(Self {
@@ -108,84 +108,10 @@ fn drop(self: Pin<&mut Self>) {
         unsafe { bindings::misc_deregister(self.inner.get()) };
     }
 }
-
-/// Trait implemented by the private data of an open misc device.
-#[vtable]
-pub trait MiscDevice: Sized {
-    /// What kind of pointer should `Self` be wrapped in.
-    type Ptr: ForeignOwnable + Send + Sync;
-
-    /// Called when the misc device is opened.
-    ///
-    /// The returned pointer will be stored as the private data for the fi=
le.
-    fn open(_file: &File, _misc: &MiscDeviceRegistration<Self>) -> Result<=
Self::Ptr>;
-
-    /// Called when the misc device is released.
-    fn release(device: Self::Ptr, _file: &File) {
-        drop(device);
-    }
-
-    /// Handle for mmap.
-    ///
-    /// This function is invoked when a user space process invokes the `mm=
ap` system call on
-    /// `file`. The function is a callback that is part of the VMA initial=
izer. The kernel will do
-    /// initial setup of the VMA before calling this function. The functio=
n can then interact with
-    /// the VMA initialization by calling methods of `vma`. If the functio=
n does not return an
-    /// error, the kernel will complete initialization of the VMA accordin=
g to the properties of
-    /// `vma`.
-    fn mmap(
-        _device: <Self::Ptr as ForeignOwnable>::Borrowed<'_>,
-        _file: &File,
-        _vma: &VmaNew,
-    ) -> Result {
-        build_error!(VTABLE_DEFAULT_ERROR)
-    }
-
-    /// Handler for ioctls.
-    ///
-    /// The `cmd` argument is usually manipulated using the utilities in [=
`kernel::ioctl`].
-    ///
-    /// [`kernel::ioctl`]: mod@crate::ioctl
-    fn ioctl(
-        _device: <Self::Ptr as ForeignOwnable>::Borrowed<'_>,
-        _file: &File,
-        _cmd: u32,
-        _arg: usize,
-    ) -> Result<isize> {
-        build_error!(VTABLE_DEFAULT_ERROR)
-    }
-
-    /// Handler for ioctls.
-    ///
-    /// Used for 32-bit userspace on 64-bit platforms.
-    ///
-    /// This method is optional and only needs to be provided if the ioctl=
 relies on structures
-    /// that have different layout on 32-bit and 64-bit userspace. If no i=
mplementation is
-    /// provided, then `compat_ptr_ioctl` will be used instead.
-    #[cfg(CONFIG_COMPAT)]
-    fn compat_ioctl(
-        _device: <Self::Ptr as ForeignOwnable>::Borrowed<'_>,
-        _file: &File,
-        _cmd: u32,
-        _arg: usize,
-    ) -> Result<isize> {
-        build_error!(VTABLE_DEFAULT_ERROR)
-    }
-
-    /// Show info for this fd.
-    fn show_fdinfo(
-        _device: <Self::Ptr as ForeignOwnable>::Borrowed<'_>,
-        _m: &SeqFile,
-        _file: &File,
-    ) {
-        build_error!(VTABLE_DEFAULT_ERROR)
-    }
-}
-
 /// A vtable for the file operations of a Rust miscdevice.
-struct MiscdeviceVTable<T: MiscDevice>(PhantomData<T>);
+struct MiscdeviceVTable<T: FileOperations>(PhantomData<T>);
=20
-impl<T: MiscDevice> MiscdeviceVTable<T> {
+impl<T: FileOperations> MiscdeviceVTable<T> {
     /// # Safety
     ///
     /// `file` and `inode` must be the file and inode for a file that is u=
ndergoing initialization.
diff --git a/samples/rust/rust_misc_device.rs b/samples/rust/rust_misc_devi=
ce.rs
index e7ab77448f75..d052294cebb8 100644
--- a/samples/rust/rust_misc_device.rs
+++ b/samples/rust/rust_misc_device.rs
@@ -100,9 +100,9 @@
 use kernel::{
     c_str,
     device::Device,
-    fs::File,
+    fs::{file_operations::FileOperations, File},
     ioctl::{_IO, _IOC_SIZE, _IOR, _IOW},
-    miscdevice::{MiscDevice, MiscDeviceOptions, MiscDeviceRegistration},
+    miscdevice::{MiscDeviceOptions, MiscDeviceRegistration},
     new_mutex,
     prelude::*,
     sync::Mutex,
@@ -154,7 +154,7 @@ struct RustMiscDevice {
 }
=20
 #[vtable]
-impl MiscDevice for RustMiscDevice {
+impl FileOperations for RustMiscDevice {
     type Ptr =3D Pin<KBox<Self>>;
=20
     fn open(_file: &File, misc: &MiscDeviceRegistration<Self>) -> Result<P=
in<KBox<Self>>> {
--=20
2.43.0



