Return-Path: <linux-fsdevel+bounces-62135-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A36E2B85521
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 16:46:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 459CB7C3B95
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 14:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF65B30CB5A;
	Thu, 18 Sep 2025 14:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="TO/eaAe8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-4319.protonmail.ch (mail-4319.protonmail.ch [185.70.43.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFB030C620
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Sep 2025 14:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758206746; cv=none; b=PknppSkdX5m5+8S7q/DQj1EFVH4T5eqBbCcb/QCa3yBCBLNcyH/BKqDwl4IowIDy1okZql+racSuQbY/8LhR/Uan1sJLRGPGL+ZlIw0IOPy1ErmY8Ob4X0l/qLKHEV83INlFZVKSPCr67RCWq6iD34/ftJ7pGt+uYKfptawKtZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758206746; c=relaxed/simple;
	bh=+UgYxx1BHBHGbRZ9HqN539ZaU2MSiTdwwwtcvH6kzZ0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MRSTRrVac+4OVULl3PifAWENOUVaMB05pRlRVo9ybe1F/BvxEVHg4cI1NTQXu+dnsESOGZSEnB+KMEP0tkc9E4rgkev10bfVuqQd1VY3wAqJtrWT0It30JPP+eKxVPM9SG0Ax25haiDaT+JfbBZPYN5vw78THHstviLfYNvzl8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=TO/eaAe8; arc=none smtp.client-ip=185.70.43.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1758206741; x=1758465941;
	bh=IkIWbcDezBOVmVawtSnjMHqDnlXRjl6QRBP3w/Gwm14=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=TO/eaAe8ZSmuoy0swQd2y7iM+cMYtGTau6hCPtb6PqChvSymlf8aYOSzf+XaRXqps
	 t4EPFlTPqGDwtEQP4+ts1oAtvE7mVjxHOWlaCkPQmrQtkNtpS7UXXQUf/jybLkkd1O
	 Fagh5UsXhuZVoHopH8hp31xtzaAmpgv1PwF2kRhQYEaHHy9q53YjpAa3BuCxxJiqPF
	 Bi9RdkUEeEVgDGNLohpxmG9tXfNYQVmk1XQCHZHhJYjFgOTiLOznxjswNUh3uX3q7+
	 Z1NUrXVMGHruQIC9ZEipkrpuwhLMpvjB6I06HHiRd2Vr1xZDZuykDfvCixgJjDVwAg
	 0Fo13Sq1jh9hA==
Date: Thu, 18 Sep 2025 14:45:36 +0000
To: "aliceryhl@google.com" <aliceryhl@google.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "arnd@arndb.de" <arnd@arndb.de>
From: ManeraKai <manerakai@protonmail.com>
Cc: "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "manerakai@protonmail.com" <manerakai@protonmail.com>
Subject: [PATCH 2/3] rust: miscdevice: Implemented `read` and `write`
Message-ID: <20250918144356.28585-3-manerakai@protonmail.com>
In-Reply-To: <20250918144356.28585-1-manerakai@protonmail.com>
References: <20250918144356.28585-1-manerakai@protonmail.com>
Feedback-ID: 38045798:user:proton
X-Pm-Message-ID: e9435c9509f46a2a15d96b514e7389f2d7900d88
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Added the general declaration in `FileOperations`. And implemented the
safe wrapping for misc.

Note: Renamed some raw pointer variables to `raw_<name>`. I'm not sure
this way of naming is good or not. I would like your opinion.

Signed-off-by: ManeraKai <manerakai@protonmail.com>
---
 rust/kernel/fs/file_operations.rs |  20 +++++-
 rust/kernel/miscdevice.rs         | 108 +++++++++++++++++++++++-------
 2 files changed, 104 insertions(+), 24 deletions(-)

diff --git a/rust/kernel/fs/file_operations.rs b/rust/kernel/fs/file_operat=
ions.rs
index aa60cd46a012..b21a2bae4803 100644
--- a/rust/kernel/fs/file_operations.rs
+++ b/rust/kernel/fs/file_operations.rs
@@ -14,7 +14,7 @@
     miscdevice::MiscDeviceRegistration,
     mm::virt::VmaNew,
     seq_file::SeqFile,
-    types::ForeignOwnable,
+    types::ForeignOwnable, uaccess::{UserSliceReader, UserSliceWriter},
 };
=20
 /// Trait implemented by the private data of an open misc device.
@@ -23,6 +23,24 @@ pub trait FileOperations: Sized {
     /// What kind of pointer should `Self` be wrapped in.
     type Ptr: ForeignOwnable + Send + Sync;
=20
+    /// Handler for read.
+    fn read(
+        _device: <Self::Ptr as ForeignOwnable>::Borrowed<'_>,
+        _buf: UserSliceWriter,
+        _offset: &mut i64,
+    ) -> Result<i64> {
+        build_error!(VTABLE_DEFAULT_ERROR)
+    }
+
+    /// Handler for write.
+    fn write(
+        _device: <Self::Ptr as ForeignOwnable>::Borrowed<'_>,
+        mut _buf: UserSliceReader,
+        _offset: &mut i64,
+    ) -> Result<i64> {
+        build_error!(VTABLE_DEFAULT_ERROR)
+    }
+
     /// Called when the misc device is opened.
     ///
     /// The returned pointer will be stored as the private data for the fi=
le.
diff --git a/rust/kernel/miscdevice.rs b/rust/kernel/miscdevice.rs
index 578f33383ce6..f4b6388a3742 100644
--- a/rust/kernel/miscdevice.rs
+++ b/rust/kernel/miscdevice.rs
@@ -8,6 +8,8 @@
 //!
 //! Reference: <https://www.kernel.org/doc/html/latest/driver-api/misc_dev=
ices.html>
=20
+use bindings::loff_t;
+
 use crate::{
     bindings,
     device::Device,
@@ -17,7 +19,7 @@
     mm::virt::VmaNew,
     prelude::*,
     seq_file::SeqFile,
-    types::{ForeignOwnable, Opaque},
+    types::{ForeignOwnable, Opaque}, uaccess::UserSlice,
 };
 use core::{marker::PhantomData, mem::MaybeUninit, pin::Pin};
=20
@@ -112,6 +114,54 @@ fn drop(self: Pin<&mut Self>) {
 struct MiscdeviceVTable<T: FileOperations>(PhantomData<T>);
=20
 impl<T: FileOperations> MiscdeviceVTable<T> {
+    unsafe extern "C" fn read(
+        raw_file: *mut bindings::file,
+        raw_buf: *mut ffi::c_char,
+        size: usize,
+        raw_offset: *mut loff_t,
+    ) -> c_long {
+        // SAFETY: The read call of a file can access file and its private=
_data.
+        let raw_device =3D unsafe { (*raw_file).private_data };
+
+        // SAFETY: The read call of a file can borrow the private_data of =
the file.
+        let device =3D unsafe { <T::Ptr as ForeignOwnable>::borrow(raw_dev=
ice) };
+
+        let user_slice =3D UserSlice::new(UserPtr::from_ptr(raw_buf as *mu=
t c_void), size);
+        let user_slice_writer =3D user_slice.writer();
+
+        // SAFETY: The read call of a file can access and modify the offse=
t pointer value.
+        let offset =3D unsafe { &mut *raw_offset };
+
+        match T::read(device, user_slice_writer, offset) {
+            Ok(ret) =3D> ret as c_long,
+            Err(err) =3D> err.to_errno() as c_long,
+        }
+    }
+
+    unsafe extern "C" fn write(
+        raw_file: *mut bindings::file,
+        raw_buf: *const ffi::c_char,
+        size: usize,
+        raw_offset: *mut loff_t,
+    ) -> c_long {
+        // SAFETY: The read call of a file can access file and its private=
_data.
+        let raw_device =3D unsafe { (*raw_file).private_data };
+
+        // SAFETY: The read call of a file can borrow the private_data of =
the file.
+        let device =3D unsafe { <T::Ptr as ForeignOwnable>::borrow(raw_dev=
ice) };
+
+        let user_slice =3D UserSlice::new(UserPtr::from_ptr(raw_buf as *mu=
t c_void), size);
+        let user_slice_reader =3D user_slice.reader();
+
+        // SAFETY: The read call of a file can access and modify the offse=
t pointer value.
+        let offset =3D unsafe { &mut *raw_offset };
+
+        match T::write(device, user_slice_reader, offset) {
+            Ok(ret) =3D> ret as c_long,
+            Err(err) =3D> err.to_errno() as c_long,
+        }
+    }
+
     /// # Safety
     ///
     /// `file` and `inode` must be the file and inode for a file that is u=
ndergoing initialization.
@@ -124,13 +174,13 @@ impl<T: FileOperations> MiscdeviceVTable<T> {
         }
=20
         // SAFETY: The open call of a file can access the private data.
-        let misc_ptr =3D unsafe { (*raw_file).private_data };
+        let raw_misc =3D unsafe { (*raw_file).private_data };
=20
         // SAFETY: This is a miscdevice, so `misc_open()` set the private =
data to a pointer to the
         // associated `struct miscdevice` before calling into this method.=
 Furthermore,
         // `misc_open()` ensures that the miscdevice can't be unregistered=
 and freed during this
         // call to `fops_open`.
-        let misc =3D unsafe { &*misc_ptr.cast::<MiscDeviceRegistration<T>>=
() };
+        let misc =3D unsafe { &*raw_misc.cast::<MiscDeviceRegistration<T>>=
() };
=20
         // SAFETY:
         // * This underlying file is valid for (much longer than) the dura=
tion of `T::open`.
@@ -157,16 +207,19 @@ impl<T: FileOperations> MiscdeviceVTable<T> {
     ///
     /// `file` and `inode` must be the file and inode for a file that is b=
eing released. The file
     /// must be associated with a `MiscDeviceRegistration<T>`.
-    unsafe extern "C" fn release(_inode: *mut bindings::inode, file: *mut =
bindings::file) -> c_int {
+    unsafe extern "C" fn release(
+        _inode: *mut bindings::inode,
+        raw_file: *mut bindings::file,
+    ) -> c_int {
         // SAFETY: The release call of a file owns the private data.
-        let private =3D unsafe { (*file).private_data };
+        let raw_device =3D unsafe { (*raw_file).private_data };
         // SAFETY: The release call of a file owns the private data.
-        let ptr =3D unsafe { <T::Ptr as ForeignOwnable>::from_foreign(priv=
ate) };
+        let device =3D unsafe { <T::Ptr as ForeignOwnable>::from_foreign(r=
aw_device) };
=20
         // SAFETY:
         // * The file is valid for the duration of this call.
         // * There is no active fdget_pos region on the file on this threa=
d.
-        T::release(ptr, unsafe { File::from_raw_file(file) });
+        T::release(device, unsafe { File::from_raw_file(raw_file) });
=20
         0
     }
@@ -176,21 +229,21 @@ impl<T: FileOperations> MiscdeviceVTable<T> {
     /// `file` must be a valid file that is associated with a `MiscDeviceR=
egistration<T>`.
     /// `vma` must be a vma that is currently being mmap'ed with this file=
.
     unsafe extern "C" fn mmap(
-        file: *mut bindings::file,
+        raw_file: *mut bindings::file,
         vma: *mut bindings::vm_area_struct,
     ) -> c_int {
         // SAFETY: The mmap call of a file can access the private data.
-        let private =3D unsafe { (*file).private_data };
+        let raw_device =3D unsafe { (*raw_file).private_data };
         // SAFETY: This is a Rust Miscdevice, so we call `into_foreign` in=
 `open` and
         // `from_foreign` in `release`, and `fops_mmap` is guaranteed to b=
e called between those
         // two operations.
-        let device =3D unsafe { <T::Ptr as ForeignOwnable>::borrow(private=
.cast()) };
+        let device =3D unsafe { <T::Ptr as ForeignOwnable>::borrow(raw_dev=
ice) };
         // SAFETY: The caller provides a vma that is undergoing initial VM=
A setup.
         let area =3D unsafe { VmaNew::from_raw(vma) };
         // SAFETY:
         // * The file is valid for the duration of this call.
         // * There is no active fdget_pos region on the file on this threa=
d.
-        let file =3D unsafe { File::from_raw_file(file) };
+        let file =3D unsafe { File::from_raw_file(raw_file) };
=20
         match T::mmap(device, file, area) {
             Ok(()) =3D> 0,
@@ -201,16 +254,16 @@ impl<T: FileOperations> MiscdeviceVTable<T> {
     /// # Safety
     ///
     /// `file` must be a valid file that is associated with a `MiscDeviceR=
egistration<T>`.
-    unsafe extern "C" fn ioctl(file: *mut bindings::file, cmd: c_uint, arg=
: c_ulong) -> c_long {
+    unsafe extern "C" fn ioctl(raw_file: *mut bindings::file, cmd: c_uint,=
 arg: c_ulong) -> c_long {
         // SAFETY: The ioctl call of a file can access the private data.
-        let private =3D unsafe { (*file).private_data };
+        let raw_device =3D unsafe { (*raw_file).private_data };
         // SAFETY: Ioctl calls can borrow the private data of the file.
-        let device =3D unsafe { <T::Ptr as ForeignOwnable>::borrow(private=
) };
+        let device =3D unsafe { <T::Ptr as ForeignOwnable>::borrow(raw_dev=
ice) };
=20
         // SAFETY:
         // * The file is valid for the duration of this call.
         // * There is no active fdget_pos region on the file on this threa=
d.
-        let file =3D unsafe { File::from_raw_file(file) };
+        let file =3D unsafe { File::from_raw_file(raw_file) };
=20
         match T::ioctl(device, file, cmd, arg) {
             Ok(ret) =3D> ret as c_long,
@@ -223,19 +276,19 @@ impl<T: FileOperations> MiscdeviceVTable<T> {
     /// `file` must be a valid file that is associated with a `MiscDeviceR=
egistration<T>`.
     #[cfg(CONFIG_COMPAT)]
     unsafe extern "C" fn compat_ioctl(
-        file: *mut bindings::file,
+        raw_file: *mut bindings::file,
         cmd: c_uint,
         arg: c_ulong,
     ) -> c_long {
         // SAFETY: The compat ioctl call of a file can access the private =
data.
-        let private =3D unsafe { (*file).private_data };
+        let raw_device =3D unsafe { (*raw_file).private_data };
         // SAFETY: Ioctl calls can borrow the private data of the file.
-        let device =3D unsafe { <T::Ptr as ForeignOwnable>::borrow(private=
) };
+        let device =3D unsafe { <T::Ptr as ForeignOwnable>::borrow(raw_dev=
ice) };
=20
         // SAFETY:
         // * The file is valid for the duration of this call.
         // * There is no active fdget_pos region on the file on this threa=
d.
-        let file =3D unsafe { File::from_raw_file(file) };
+        let file =3D unsafe { File::from_raw_file(raw_file) };
=20
         match T::compat_ioctl(device, file, cmd, arg) {
             Ok(ret) =3D> ret as c_long,
@@ -247,15 +300,18 @@ impl<T: FileOperations> MiscdeviceVTable<T> {
     ///
     /// - `file` must be a valid file that is associated with a `MiscDevic=
eRegistration<T>`.
     /// - `seq_file` must be a valid `struct seq_file` that we can write t=
o.
-    unsafe extern "C" fn show_fdinfo(seq_file: *mut bindings::seq_file, fi=
le: *mut bindings::file) {
+    unsafe extern "C" fn show_fdinfo(
+        seq_file: *mut bindings::seq_file,
+        raw_file: *mut bindings::file,
+    ) {
         // SAFETY: The release call of a file owns the private data.
-        let private =3D unsafe { (*file).private_data };
+        let raw_device =3D unsafe { (*raw_file).private_data };
         // SAFETY: Ioctl calls can borrow the private data of the file.
-        let device =3D unsafe { <T::Ptr as ForeignOwnable>::borrow(private=
) };
+        let device =3D unsafe { <T::Ptr as ForeignOwnable>::borrow(raw_dev=
ice) };
         // SAFETY:
         // * The file is valid for the duration of this call.
         // * There is no active fdget_pos region on the file on this threa=
d.
-        let file =3D unsafe { File::from_raw_file(file) };
+        let file =3D unsafe { File::from_raw_file(raw_file) };
         // SAFETY: The caller ensures that the pointer is valid and exclus=
ive for the duration in
         // which this method is called.
         let m =3D unsafe { SeqFile::from_raw(seq_file) };
@@ -264,6 +320,12 @@ impl<T: FileOperations> MiscdeviceVTable<T> {
     }
=20
     const VTABLE: bindings::file_operations =3D bindings::file_operations =
{
+        read: if T::HAS_READ { Some(Self::read) } else { None },
+        write: if T::HAS_WRITE {
+            Some(Self::write)
+        } else {
+            None
+        },
         open: Some(Self::open),
         release: Some(Self::release),
         mmap: if T::HAS_MMAP { Some(Self::mmap) } else { None },
--=20
2.43.0



