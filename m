Return-Path: <linux-fsdevel+bounces-74677-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iE8ROrHAb2lsMQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74677-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 18:51:45 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9572148E00
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 18:51:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 07E409AB1C3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 15:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC6143E48B;
	Tue, 20 Jan 2026 14:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f+XqgduK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5463943DA5F
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 14:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768921157; cv=none; b=gcQOj4KVVAKQ/rf4TMl10hVvYW4Whd+d2ftc8jOeMMu87pzdwM3qLDc6cvDI+Mtmn62pz4/oJizH2dF0376Yra7YGGq8tNm/I7dxfFbakWbiMDPaHJY929vRIsLTl9tZHQokAO+VyS8Dr+4S+1P+s54563yJQud89Q/Ka8qJUeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768921157; c=relaxed/simple;
	bh=iolTe2Nv6CXObYVORHv7J+SxOaQNUXJvbYUG0yhxQwo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SqIG1pvzQAYg/gFKYriXF9eieM6xlg/0lB5Nl9Dvrbu05c3bEcYFnqjmafuQaJxuyTg+kZ+/lbc9mCTv7nNlm2N+a586mzQppIozz7vvvpktQFTMr1O3qf5V0OgIgCm3b8ZCG4C7yiCEMGqfn/wZ2mxdR7fTkaFDVvVkZgrObfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f+XqgduK; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-81f478e5283so4803816b3a.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 06:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768921155; x=1769525955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eSjlYt7iWy0dHDjMoGOdBEcpp+zSyHhPWpL6L/bevUw=;
        b=f+XqgduKHxlnwiDk+dX72xMItu+7DmPTjYlluGUWCvvYVOar24hE9536pRxkPGjD94
         K3Jh1P91PFKxAqAbgDzjSCmO3Raxi7Q0pjle/B5LO0Q/oS3Bc5MFpO+xA7SpBGHS2tGN
         uU3LDYvPXdsBU5+8dI1BSNnW9jbNEbK56WC1o/RHfOWd6ieaTjAQffKzGb7+nlt4Yc+Z
         E29YF8mCcArvWQDMqvUri7fFKXd2ffhsP6w0qbycosnM75bj7aS295Xz+h18C0EOk49n
         jVmUe/00wYdKLaPQbxtMkuSBePXNMODbOGO/rAfIVIDcmZlkBQH5D0gd+4nkZ5mUsJdY
         ZLTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768921155; x=1769525955;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eSjlYt7iWy0dHDjMoGOdBEcpp+zSyHhPWpL6L/bevUw=;
        b=suaH4E/G0t2HV/0Izyd21no7OwG5mYaFD+xUbMjIKdjYsf+PRyJWwMuqBvXhFS0WUA
         WdgVf8Qe/Px8co+c4ofeU+Nz9VCT+GNA19MxaTq5L6fqADxIAFEkRUiPjNG89iN4ygtT
         4X+iKdpTNNxSehCg/8SBeZWM9skBRFb42o8cCv4+Fw4wGQV652bm5Rq17Wc92r7BX/9l
         sPDtyzZ3Qn1r7BMR84y0E0LG4TY8LHEmV5kXn4e8dnTEvW8Uc7rGSb+vQyZLy71kCR7r
         eB+gZT81kLYjRrLfoUWQw66TiKz1gL8I813NinvitF4CJCD/ilpRCfBPWfAfiSAt+6Hq
         f3LQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOAuJn4Qya3kWYrUQ5aU6mgJWkCIlYYLJnDnbeofFT0QZemnecLEUZnwVFHT7doANMAsm8xpjLdFOiUltU@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+wHG2AGbLgQmz2mglE0BXm2j3K9ljCyjWCXER39INVTySquSh
	vObIiu+6Surr5WF+lfOs75Z8IOprzLajWqlVN+j2cRG3Phbm2H+lEDzn
X-Gm-Gg: AY/fxX7x604+p3z9B3xNg47YOadaLVGjc9tbiEA0OY3KtQI0okGsy/It672YO2JhTIc
	Lq07dV5HBFkWnDpufjHkWPJCl2RwxOJSeJgcjcDjbAVEwtBXgxJNRurqbhR7rQ4r1FxLbdmQcmB
	BsFeYBWPLGJ+V1y+MwyZM9SubIn8xzcSGR2Cg6nVwmeE7jwl1G2m+Vej92tSAyxo95t+2a02Rr3
	onR7lgYbKhVZ1/pftjt71Zb1VWda0AN16DU2s98Uqq3WzgMIDgaUAsknYkLBJ9zfV5wPJ4+EJPL
	Hjv5QxOOGmpOQRVjj44fZokXnXtWlNjTq5sJBUPNT4j7m/d2sf89Oc3itqcgKcLFHXkYJypW0AX
	4zzhYzZx0m9WMWfmev2TFBiJ6VGSMUpmKhjTza+eU7/DImSfIZWMI+GoqUO5K53mTitcUUY+mLN
	8bHrB+3m7g9mA56qKbVA03bPQyv8PZxoAQLeP+tHYiWNYjzoBUSbRq
X-Received: by 2002:a05:6a20:918d:b0:38d:eeff:7b1e with SMTP id adf61e73a8af0-38dfe6c1947mr12933114637.34.1768921155419;
        Tue, 20 Jan 2026 06:59:15 -0800 (PST)
Received: from kailas.hsd1.or.comcast.net ([2601:1c2:1803:3ab0::2e2b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c5edf354b3bsm5478104a12.24.2026.01.20.06.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 06:59:14 -0800 (PST)
From: Ryan Foster <foster.ryan.r@gmail.com>
To: gary@garyguo.net
Cc: a.hindborg@kernel.org,
	aliceryhl@google.com,
	bjorn3_gh@protonmail.com,
	boqun.feng@gmail.com,
	dakr@kernel.org,
	gregkh@linuxfoundation.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lossin@kernel.org,
	ojeda@kernel.org,
	rafael@kernel.org,
	rust-for-linux@vger.kernel.org,
	tmgross@umich.edu,
	Ryan Foster <foster.ryan.r@gmail.com>
Subject: [PATCH] rust: replace `kernel::c_str!` with C-Strings in seq_file and device
Date: Tue, 20 Jan 2026 06:59:12 -0800
Message-ID: <20260120145912.281977-1-foster.ryan.r@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <DFTI0P4F3UR9.14CA9H3I19GCB@garyguo.net>
References: <DFTI0P4F3UR9.14CA9H3I19GCB@garyguo.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_FROM(0.00)[bounces-74677-lists,linux-fsdevel=lfdr.de];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[kernel.org,google.com,protonmail.com,gmail.com,linuxfoundation.org,vger.kernel.org,umich.edu];
	DKIM_TRACE(0.00)[gmail.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	FROM_NEQ_ENVFROM(0.00)[fosterryanr@gmail.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 9572148E00
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

C-String literals were added in Rust 1.77. Replace instances of
`kernel::c_str!` with C-String literals where possible.

This patch updates seq_file and device modules to use the native
C-string literal syntax (c"...") instead of the kernel::c_str! macro.

While at it, convert imports to the kernel vertical import style.

Signed-off-by: Ryan Foster <foster.ryan.r@gmail.com>
---
 rust/kernel/device.rs   | 19 ++++++++++++-------
 rust/kernel/seq_file.rs | 12 ++++++++++--
 2 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
index 71b200df0f40..a87350c1a67d 100644
--- a/rust/kernel/device.rs
+++ b/rust/kernel/device.rs
@@ -5,15 +5,20 @@
 //! C header: [`include/linux/device.h`](srctree/include/linux/device.h)
 
 use crate::{
-    bindings, fmt,
+    bindings,
+    fmt,
     prelude::*,
     sync::aref::ARef,
-    types::{ForeignOwnable, Opaque},
+    types::{
+        ForeignOwnable,
+        Opaque, //
+    }, //
+};
+use core::{
+    any::TypeId,
+    marker::PhantomData,
+    ptr, //
 };
-use core::{any::TypeId, marker::PhantomData, ptr};
-
-#[cfg(CONFIG_PRINTK)]
-use crate::c_str;
 
 pub mod property;
 
@@ -462,7 +467,7 @@ unsafe fn printk(&self, klevel: &[u8], msg: fmt::Arguments<'_>) {
             bindings::_dev_printk(
                 klevel.as_ptr().cast::<crate::ffi::c_char>(),
                 self.as_raw(),
-                c_str!("%pA").as_char_ptr(),
+                c"%pA".as_char_ptr(),
                 core::ptr::from_ref(&msg).cast::<crate::ffi::c_void>(),
             )
         };
diff --git a/rust/kernel/seq_file.rs b/rust/kernel/seq_file.rs
index 855e533813a6..109ad6670907 100644
--- a/rust/kernel/seq_file.rs
+++ b/rust/kernel/seq_file.rs
@@ -4,7 +4,15 @@
 //!
 //! C header: [`include/linux/seq_file.h`](srctree/include/linux/seq_file.h)
 
-use crate::{bindings, c_str, fmt, str::CStrExt as _, types::NotThreadSafe, types::Opaque};
+use crate::{
+    bindings,
+    fmt,
+    str::CStrExt as _,
+    types::{
+        NotThreadSafe,
+        Opaque, //
+    }, //
+};
 
 /// A utility for generating the contents of a seq file.
 #[repr(transparent)]
@@ -36,7 +44,7 @@ pub fn call_printf(&self, args: fmt::Arguments<'_>) {
         unsafe {
             bindings::seq_printf(
                 self.inner.get(),
-                c_str!("%pA").as_char_ptr(),
+                c"%pA".as_char_ptr(),
                 core::ptr::from_ref(&args).cast::<crate::ffi::c_void>(),
             );
         }
-- 
2.52.0


