Return-Path: <linux-fsdevel+bounces-62136-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7071FB85534
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 16:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A4BA1C83AD1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 14:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51FFE30CDB4;
	Thu, 18 Sep 2025 14:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="iytGnq27"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-24431.protonmail.ch (mail-24431.protonmail.ch [109.224.244.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930E530C34D;
	Thu, 18 Sep 2025 14:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758206763; cv=none; b=QMzugz2GE4Aa8omn1rDQ9ar1OjIJMoY2KIL2cXKmiQoMocsgNnza1ecoa/xdGaaW6exQ49D21aowTBRv1z6kgMyZF2PvYTTOSrMZcaQo25DSqrIqBtAfzMglRgTTUWdPunjnLiWiIVkuuvs66izpLxWyAHlVdhH1pC4CjHLBy5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758206763; c=relaxed/simple;
	bh=aCIOVZUs2dSGsGdh/1Ts7QgrL0yj95/pBCTntE0uMAI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Eir4w0g+y/DGbD3kEDTaAjWS0pbt5fUN6bJrq+qfojn6xpvNH4C8Thm5jYXm8gxF3trSzjt52n9dNxrbGzy6fBV147bM5uJogkd6DOAq4tj+m9QbpQeQFibht93suGDoCpgjnT+sH4eagRYDArZseELZ6kLOoPj+W1NPkpbnH/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=iytGnq27; arc=none smtp.client-ip=109.224.244.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1758206750; x=1758465950;
	bh=r6YasiPp7lhsuuq8MRxbmPcGSOWQNI511uYCgolntWc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=iytGnq272gFb2zFF7YnvOG+PCdjKW8smasN3Dx0PZWLbrnvR8YVp+cLAwdXQL/LKh
	 QS2VbQ2P2zY7aAbaSK9G/AeVmBSZJ5lUbrACS3jdExRm/OoUxeASekm3KNghMhkcPY
	 JhEdvfu7yRw/VwGZtjNj790j7XdLJSrqbzQAFTP/LgETl6k7PuKob1BkhiKcvq4L0p
	 5WCntgkxhS0+zEewcOPXB95L+oYRJYdsm0yxKdm+vmpo54sanQ+9yE4USLlm7k+3Po
	 NltxzHVQjVmAEEx8sX7WIdzzGdfW2ZFgOuSdGUIScAoq3JvZx05CRdLKO3qFIl8EVn
	 LjSKLfwW/xi2g==
Date: Thu, 18 Sep 2025 14:45:44 +0000
To: "aliceryhl@google.com" <aliceryhl@google.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "arnd@arndb.de" <arnd@arndb.de>
From: ManeraKai <manerakai@protonmail.com>
Cc: "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "manerakai@protonmail.com" <manerakai@protonmail.com>
Subject: [PATCH 3/3] samples: rust: Updated the example using the Rust MiscDevice abstraction
Message-ID: <20250918144356.28585-4-manerakai@protonmail.com>
In-Reply-To: <20250918144356.28585-1-manerakai@protonmail.com>
References: <20250918144356.28585-1-manerakai@protonmail.com>
Feedback-ID: 38045798:user:proton
X-Pm-Message-ID: ec35da6f210f3eb7ba496a869f1f525a3f75fb43
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This sample driver will now:
- use the new general `FileOperations` abstraction.
- have `read` and `write` methods, that use a persistent kernel buffer to
store data.

Signed-off-by: ManeraKai <manerakai@protonmail.com>
---
 samples/rust/rust_misc_device.rs | 283 +++++++++++++++++++++----------
 1 file changed, 195 insertions(+), 88 deletions(-)

diff --git a/samples/rust/rust_misc_device.rs b/samples/rust/rust_misc_devi=
ce.rs
index d052294cebb8..c8e90eb9b9ad 100644
--- a/samples/rust/rust_misc_device.rs
+++ b/samples/rust/rust_misc_device.rs
@@ -7,92 +7,139 @@
 //! Below is an example userspace C program that exercises this sample's f=
unctionality.
 //!
 //! ```c
-//! #include <stdio.h>
-//! #include <stdlib.h>
-//! #include <errno.h>
-//! #include <fcntl.h>
-//! #include <unistd.h>
-//! #include <sys/ioctl.h>
-//!
-//! #define RUST_MISC_DEV_FAIL _IO('|', 0)
-//! #define RUST_MISC_DEV_HELLO _IO('|', 0x80)
-//! #define RUST_MISC_DEV_GET_VALUE _IOR('|', 0x81, int)
-//! #define RUST_MISC_DEV_SET_VALUE _IOW('|', 0x82, int)
-//!
-//! int main() {
-//!   int value, new_value;
-//!   int fd, ret;
-//!
-//!   // Open the device file
-//!   printf("Opening /dev/rust-misc-device for reading and writing\n");
-//!   fd =3D open("/dev/rust-misc-device", O_RDWR);
-//!   if (fd < 0) {
-//!     perror("open");
-//!     return errno;
-//!   }
-//!
-//!   // Make call into driver to say "hello"
-//!   printf("Calling Hello\n");
-//!   ret =3D ioctl(fd, RUST_MISC_DEV_HELLO, NULL);
-//!   if (ret < 0) {
-//!     perror("ioctl: Failed to call into Hello");
-//!     close(fd);
-//!     return errno;
-//!   }
-//!
-//!   // Get initial value
-//!   printf("Fetching initial value\n");
-//!   ret =3D ioctl(fd, RUST_MISC_DEV_GET_VALUE, &value);
-//!   if (ret < 0) {
-//!     perror("ioctl: Failed to fetch the initial value");
-//!     close(fd);
-//!     return errno;
-//!   }
-//!
-//!   value++;
-//!
-//!   // Set value to something different
-//!   printf("Submitting new value (%d)\n", value);
-//!   ret =3D ioctl(fd, RUST_MISC_DEV_SET_VALUE, &value);
-//!   if (ret < 0) {
-//!     perror("ioctl: Failed to submit new value");
-//!     close(fd);
-//!     return errno;
-//!   }
-//!
-//!   // Ensure new value was applied
-//!   printf("Fetching new value\n");
-//!   ret =3D ioctl(fd, RUST_MISC_DEV_GET_VALUE, &new_value);
-//!   if (ret < 0) {
-//!     perror("ioctl: Failed to fetch the new value");
-//!     close(fd);
-//!     return errno;
-//!   }
-//!
-//!   if (value !=3D new_value) {
-//!     printf("Failed: Committed and retrieved values are different (%d -=
 %d)\n", value, new_value);
-//!     close(fd);
-//!     return -1;
-//!   }
-//!
-//!   // Call the unsuccessful ioctl
-//!   printf("Attempting to call in to an non-existent IOCTL\n");
-//!   ret =3D ioctl(fd, RUST_MISC_DEV_FAIL, NULL);
-//!   if (ret < 0) {
-//!     perror("ioctl: Succeeded to fail - this was expected");
-//!   } else {
-//!     printf("ioctl: Failed to fail\n");
-//!     close(fd);
-//!     return -1;
-//!   }
-//!
-//!   // Close the device file
-//!   printf("Closing /dev/rust-misc-device\n");
-//!   close(fd);
-//!
-//!   printf("Success\n");
-//!   return 0;
-//! }
+//!#include <errno.h>
+//!#include <fcntl.h>
+//!#include <stdint.h>
+//!#include <stdio.h>
+//!#include <stdlib.h>
+//!#include <sys/ioctl.h>
+//!#include <unistd.h>
+//!
+//!#define RUST_MISC_DEV_FAIL _IO('|', 0)
+//!#define RUST_MISC_DEV_HELLO _IO('|', 0x80)
+//!#define RUST_MISC_DEV_GET_VALUE _IOR('|', 0x81, int)
+//!#define RUST_MISC_DEV_SET_VALUE _IOW('|', 0x82, int)
+//!
+//!int main() {
+//!  int value, new_value;
+//!  int fd, ret;
+//!
+//!  // Open the device file
+//!  printf("Opening /dev/rust-misc-device for reading and writing\n");
+//!  fd =3D open("/dev/rust-misc-device", O_RDWR);
+//!  if (fd < 0) {
+//!    perror("open");
+//!    return errno;
+//!  }
+//!
+//!  // Make call into driver to say "hello"
+//!  printf("Calling Hello\n");
+//!  ret =3D ioctl(fd, RUST_MISC_DEV_HELLO, NULL);
+//!  if (ret < 0) {
+//!    perror("ioctl: Failed to call into Hello");
+//!    close(fd);
+//!    return errno;
+//!  }
+//!
+//!  // Get initial value
+//!  printf("Fetching initial value\n");
+//!  ret =3D ioctl(fd, RUST_MISC_DEV_GET_VALUE, &value);
+//!  if (ret < 0) {
+//!    perror("ioctl: Failed to fetch the initial value");
+//!    close(fd);
+//!    return errno;
+//!  }
+//!
+//!  value++;
+//!
+//!  // Set value to something different
+//!  printf("Submitting new value (%d)\n", value);
+//!  ret =3D ioctl(fd, RUST_MISC_DEV_SET_VALUE, &value);
+//!  if (ret < 0) {
+//!    perror("ioctl: Failed to submit new value");
+//!    close(fd);
+//!    return errno;
+//!  }
+//!
+//!  // Ensure new value was applied
+//!  printf("Fetching new value\n");
+//!  ret =3D ioctl(fd, RUST_MISC_DEV_GET_VALUE, &new_value);
+//!  if (ret < 0) {
+//!    perror("ioctl: Failed to fetch the new value");
+//!    close(fd);
+//!    return errno;
+//!  }
+//!
+//!  if (value !=3D new_value) {
+//!    printf("Failed: Committed and retrieved values are different (%d -%=
d)\n",
+//!           value, new_value);
+//!    close(fd);
+//!    return -1;
+//!  }
+//!
+//!  // Call the unsuccessful ioctl
+//!  printf("Attempting to call in to an non-existent IOCTL\n");
+//!  ret =3D ioctl(fd, RUST_MISC_DEV_FAIL, NULL);
+//!  if (ret < 0) {
+//!    perror("ioctl: Succeeded to fail - this was expected");
+//!  } else {
+//!    printf("ioctl: Failed to fail\n");
+//!    close(fd);
+//!    return -1;
+//!  }
+//!
+//!  ssize_t bytes_written;
+//!
+//!  // Write
+//!  char str1[] =3D {'H', 'e', 'l', 'l', 'o', '\0'};
+//!  printf("Attempting to write to the file\n");
+//!  bytes_written =3D write(fd, str1, sizeof(str1) * sizeof(uint8_t));
+//!  if (bytes_written < 0) {
+//!    perror("Error writing to file");
+//!    close(fd);
+//!    return 1;
+//!  }
+//!
+//!  // Write with a custom offset
+//!  printf("Attempting to write to the file with a custom offset\n");
+//!  char str2[] =3D {'i', ',', ' ', 'w', 'o', 'r', 'l', 'd', '!', '\0'};
+//!  // bytes_written =3D write(fd, str2, sizeof(str2) * sizeof(uint8_t));
+//!  bytes_written =3D pwrite(fd, str2, sizeof(str2), 1);
+//!  if (bytes_written < 0) {
+//!    perror("Error writing to file 2");
+//!    close(fd);
+//!    return 1;
+//!  }
+//!
+//!  // Read
+//!  printf("Attempting to read from the file\n");
+//!  char buffer1[20];
+//!  ssize_t readCount1 =3D pread(fd, buffer1, sizeof(buffer1), 0);
+//!  if (readCount1 < 0) {
+//!    perror("Error reading from file\n");
+//!    close(fd);
+//!    return errno;
+//!  }
+//!  printf("Data: \"%s\n\"", buffer1);
+//!
+//!  // Read with a custom offset
+//!  printf("Attempting to read from the file with a custom offset\n");
+//!  char buffer2[20];
+//!  ssize_t readCount2 =3D pread(fd, buffer2, sizeof(buffer2), 4);
+//!  if (readCount2 < 0) {
+//!    perror("Error reading from file\n");
+//!    close(fd);
+//!    return errno;
+//!  }
+//!  printf("Data: \"%s\n\"", buffer2);
+//!
+//!  // Close the device file
+//!  printf("Closing /dev/rust-misc-device\n");
+//!  close(fd);
+//!
+//!  printf("Success\n");
+//!  return 0;
+//!}
 //! ```
=20
 use core::pin::Pin;
@@ -101,12 +148,13 @@
     c_str,
     device::Device,
     fs::{file_operations::FileOperations, File},
+    global_lock,
     ioctl::{_IO, _IOC_SIZE, _IOR, _IOW},
     miscdevice::{MiscDeviceOptions, MiscDeviceRegistration},
     new_mutex,
     prelude::*,
     sync::Mutex,
-    types::ARef,
+    types::{ARef, ForeignOwnable},
     uaccess::{UserSlice, UserSliceReader, UserSliceWriter},
 };
=20
@@ -128,6 +176,11 @@ struct RustMiscDeviceModule {
     _miscdev: MiscDeviceRegistration<RustMiscDevice>,
 }
=20
+global_lock! {
+    // SAFETY: Initialized in module initializer before first use.
+    unsafe(uninit) static DATA: Mutex<KVec<u8>> =3D KVec::new();
+}
+
 impl kernel::InPlaceModule for RustMiscDeviceModule {
     fn init(_module: &'static ThisModule) -> impl PinInit<Self, Error> {
         pr_info!("Initialising Rust Misc Device Sample\n");
@@ -136,6 +189,9 @@ fn init(_module: &'static ThisModule) -> impl PinInit<S=
elf, Error> {
             name: c_str!("rust-misc-device"),
         };
=20
+        // SAFETY: Called exactly once.
+        unsafe { DATA.init() };
+
         try_pin_init!(Self {
             _miscdev <- MiscDeviceRegistration::register(options),
         })
@@ -185,13 +241,64 @@ fn ioctl(me: Pin<&RustMiscDevice>, _file: &File, cmd:=
 u32, arg: usize) -> Result
             RUST_MISC_DEV_SET_VALUE =3D> me.set_value(UserSlice::new(arg, =
size).reader())?,
             RUST_MISC_DEV_HELLO =3D> me.hello()?,
             _ =3D> {
-                dev_err!(me.dev, "-> IOCTL not recognised: {}\n", cmd);
+                dev_warn!(me.dev, "-> IOCTL not recognised: {}\n", cmd);
                 return Err(ENOTTY);
             }
         };
=20
         Ok(0)
     }
+
+    fn read(
+        device: <Self::Ptr as ForeignOwnable>::Borrowed<'_>,
+        mut buf: UserSliceWriter,
+        offset: &mut i64,
+    ) -> Result<i64> {
+        dev_info!(device.dev, "read() called\n");
+
+        let data =3D DATA.lock();
+
+        if *offset >=3D data.len() as i64 {
+            return Ok(0);
+        }
+
+        let slice =3D &data[(*offset as usize)..];
+
+        dev_info!(device.dev, "Writing to user: {:?}\n", slice);
+
+        buf.write_slice(slice)?;
+        *offset +=3D slice.len() as i64;
+
+        Ok(data.len() as i64)
+    }
+
+    fn write(
+        device: <Self::Ptr as ForeignOwnable>::Borrowed<'_>,
+        buf: UserSliceReader,
+        offset: &mut i64,
+    ) -> Result<i64> {
+        dev_info!(device.dev, "write() called\n");
+
+        let mut data =3D DATA.lock();
+
+        let mut tmp =3D KVec::with_capacity(buf.len(), GFP_KERNEL)?;
+        buf.read_all(&mut tmp, GFP_KERNEL)?;
+
+        for (i, val) in tmp.iter().enumerate() {
+            let idx =3D *offset as usize + i;
+            if idx < data.len() {
+                data[idx] =3D *val;
+            } else {
+                data.push(*val, GFP_KERNEL)?;
+            }
+        }
+
+        *offset +=3D tmp.len() as i64;
+
+        dev_info!(device.dev, "Reading from user: {:?}\n", tmp);
+
+        Ok(*offset)
+    }
 }
=20
 #[pinned_drop]
--=20
2.43.0



