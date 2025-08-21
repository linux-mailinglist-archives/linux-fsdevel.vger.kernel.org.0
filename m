Return-Path: <linux-fsdevel+bounces-58588-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C8C9B2F370
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 11:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF49A5E6476
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 09:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C002B2EAD14;
	Thu, 21 Aug 2025 09:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="dxPAvgl8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from forward101d.mail.yandex.net (forward101d.mail.yandex.net [178.154.239.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09C82D47E1;
	Thu, 21 Aug 2025 09:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755767423; cv=none; b=HV/WMG/l7YJbavKbDrPe+xo3sTiU20fUbJ8QZawgtMCaNm4PC9dv2sp4qvJ+95kFfZ41kaZSKBEov/pYZ2S+zHS0TlLI8oOurxBY6ULNxZu3d/QpX7oRiFLWMQ9uqvY58/Ebm+IuIpwQ5RCwxOyrHi8NcfSQP/SrFvbDX3pMCXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755767423; c=relaxed/simple;
	bh=1B6OvzyqPt3NKX6tRgVgSodhDFFotO9wljBIKtetzzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FlLKwHEonrq4H3H9WvN21XR/hlANiG6Fj8yhEJeEZvov6e6oROV5wvBKYVQLNV8Nr+1vyU8ZlBca3i44w8ngrdPITrpt08B4ZJPKH+PkXFfuLjvyaTxJLn2OuxLPlSOdYdTEIyk88Q40r06F+7vl59Z5RXyip48sEWJiNKJ62Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=dxPAvgl8; arc=none smtp.client-ip=178.154.239.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Received: from mail-nwsmtp-smtp-production-main-52.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-52.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:39a1:0:640:9b92:0])
	by forward101d.mail.yandex.net (Yandex) with ESMTPS id 2E72BC00D5;
	Thu, 21 Aug 2025 12:10:11 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-52.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 3APmcbNLfa60-SQ1d8bzJ;
	Thu, 21 Aug 2025 12:10:10 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1755767410;
	bh=VDWHBA8DK4ScTmcqyZzWapcx/2ckvO9mmDTzExM4wUY=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=dxPAvgl8F6/BTj9qYO83RWCHTnFpXTm7NR1Z5eabaJebRT2Tf1DGLvaPMYZQaJ62o
	 /oNGwGFlFZUCFsm7r87JM40LviFaQrmm+T6UHJrtyCoTvjFig3e+Y0Rz05NLBZHCAq
	 39hLs+W6JehHIfbYw67l0MwD4KN0E5esMI6ormFU=
Authentication-Results: mail-nwsmtp-smtp-production-main-52.klg.yp-c.yandex.net; dkim=pass header.i=@onurozkan.dev
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: rust-for-linux@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	dakr@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
Subject: [PATCH] rust: file: use to_result for error handling
Date: Thu, 21 Aug 2025 12:10:01 +0300
Message-ID: <20250821091001.28563-1-work@onurozkan.dev>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Simplifies error handling by replacing the manual check
of the return value with the `to_result` helper.

Signed-off-by: Onur Özkan <work@onurozkan.dev>
---
 rust/kernel/fs/file.rs | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/rust/kernel/fs/file.rs b/rust/kernel/fs/file.rs
index 35fd5db35c46..924f01bd64c2 100644
--- a/rust/kernel/fs/file.rs
+++ b/rust/kernel/fs/file.rs
@@ -10,7 +10,7 @@
 use crate::{
     bindings,
     cred::Credential,
-    error::{code::*, Error, Result},
+    error::{code::*, to_result, Error, Result},
     types::{ARef, AlwaysRefCounted, NotThreadSafe, Opaque},
 };
 use core::ptr;
@@ -398,9 +398,8 @@ impl FileDescriptorReservation {
     pub fn get_unused_fd_flags(flags: u32) -> Result<Self> {
         // SAFETY: FFI call, there are no safety requirements on `flags`.
         let fd: i32 = unsafe { bindings::get_unused_fd_flags(flags) };
-        if fd < 0 {
-            return Err(Error::from_errno(fd));
-        }
+        to_result(fd)?;
+
         Ok(Self {
             fd: fd as u32,
             _not_send: NotThreadSafe,
--
2.50.0


