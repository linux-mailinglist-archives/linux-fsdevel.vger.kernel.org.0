Return-Path: <linux-fsdevel+bounces-630-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4399B7CDB80
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 14:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7EE3B213DD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 12:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2461DDFC;
	Wed, 18 Oct 2023 12:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QZl4C7mZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD6518C19;
	Wed, 18 Oct 2023 12:25:50 +0000 (UTC)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B1D7118;
	Wed, 18 Oct 2023 05:25:48 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1caad0bcc95so1770835ad.0;
        Wed, 18 Oct 2023 05:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697631948; x=1698236748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=at7ARN8aRdzn5IC/IbI2nC6fhRb6Ugq4eVty6+/dMiY=;
        b=QZl4C7mZShHYVI6GraBv8bzmSxdo2JE//LRMTQ8yLUUZt65VSQ2yOf0egNqfWv4/3l
         Wj/WINF/VFNlJqYu+m/N/4oLAJCodjBnnK5C0YOPqizNtThhlBlrlBbM3eixrB4eXu5B
         65fY4Smd6CRNIRFWuLHWlZaNVb5JxY50webLig3qgJgyJjQzuGYE26PnVEP9w86lYoGb
         Hqx4vyrWAe/aJezpiMPWatR1d8Il/2Tq7T75/HWOALR3AHUIFiYulpucrZHWfS8EuECQ
         W0R3Jlols6jXaUXV8REXCVsKEfuA4SGFyPFlAmghfKRILOIZwqSooI71ERkFwJbPELkF
         8Alw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697631948; x=1698236748;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=at7ARN8aRdzn5IC/IbI2nC6fhRb6Ugq4eVty6+/dMiY=;
        b=jBBN5D2v4JYbHLZwA6/WXwUZrlTH745ZPQBCvanwr2nl8P3VvNxaNn05UvfZrpC35g
         k21V8BxZJw36wQ7PQDEPFmFleLojw51xbauJE4MwT5q/DYedn0qXqBlc89nGoJpJCEh3
         fvYdUrJiYokEi9N/WRUKKSNy6Xwfb3BAre9szF1RJHy6Vt0waPmC+iH5M17SS0GajMZU
         YrRZSvOYa72wh5ETcUVH/ichZTEgkFv9DAnQfmur6/0uoClNpkU/U6R+0AF4dWp/rnJG
         Y8gsgLfeZIrO7fpfD8YviOdP+XyUeqxrC0e4Th7D5BiaGjGtFEcgVLYObpVEZ4+fSA8O
         9njw==
X-Gm-Message-State: AOJu0YwtH4/Gkr9A3RZ/Wr1ODKuKyFCnJm9YNerVhL29Mv13iU9v+P8x
	BqZAnGTH0iJL+3f9PEtRU0Y=
X-Google-Smtp-Source: AGHT+IG3BgHG9EBP7UAXFrvuxJVUqHqq3mDriTGUcBz7Brmq0oqJCrErxZvdCbnpAA/nfR7nZ2lwCA==
X-Received: by 2002:a17:903:24d:b0:1ca:8b74:17f2 with SMTP id j13-20020a170903024d00b001ca8b7417f2mr5622696plh.6.1697631947921;
        Wed, 18 Oct 2023 05:25:47 -0700 (PDT)
Received: from wedsonaf-dev.. ([2804:389:7122:43b8:9b73:6339:3351:cce0])
        by smtp.googlemail.com with ESMTPSA id j1-20020a170902c3c100b001c736b0037fsm3411046plj.231.2023.10.18.05.25.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 05:25:47 -0700 (PDT)
From: Wedson Almeida Filho <wedsonaf@gmail.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Matthew Wilcox <willy@infradead.org>
Cc: Kent Overstreet <kent.overstreet@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fsdevel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	Wedson Almeida Filho <walmeida@microsoft.com>
Subject: [RFC PATCH 02/19] rust: fs: introduce the `module_fs` macro
Date: Wed, 18 Oct 2023 09:25:01 -0300
Message-Id: <20231018122518.128049-3-wedsonaf@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018122518.128049-1-wedsonaf@gmail.com>
References: <20231018122518.128049-1-wedsonaf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Wedson Almeida Filho <walmeida@microsoft.com>

Simplify the declaration of modules that only expose a file system type.
They can now do it using the `module_fs` macro.

Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
 rust/kernel/fs.rs | 56 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 55 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/fs.rs b/rust/kernel/fs.rs
index f3fb09db41ba..1df54c234101 100644
--- a/rust/kernel/fs.rs
+++ b/rust/kernel/fs.rs
@@ -9,7 +9,7 @@
 use crate::error::{code::*, from_result, to_result, Error};
 use crate::types::Opaque;
 use crate::{bindings, init::PinInit, str::CStr, try_pin_init, ThisModule};
-use core::{marker::PhantomPinned, pin::Pin};
+use core::{marker::PhantomData, marker::PhantomPinned, pin::Pin};
 use macros::{pin_data, pinned_drop};
 
 /// A file system type.
@@ -78,3 +78,57 @@ fn drop(self: Pin<&mut Self>) {
         unsafe { bindings::unregister_filesystem(self.fs.get()) };
     }
 }
+
+/// Kernel module that exposes a single file system implemented by `T`.
+#[pin_data]
+pub struct Module<T: FileSystem + ?Sized> {
+    #[pin]
+    fs_reg: Registration,
+    _p: PhantomData<T>,
+}
+
+impl<T: FileSystem + ?Sized + Sync + Send> crate::InPlaceModule for Module<T> {
+    fn init(module: &'static ThisModule) -> impl PinInit<Self, Error> {
+        try_pin_init!(Self {
+            fs_reg <- Registration::new::<T>(module),
+            _p: PhantomData,
+        })
+    }
+}
+
+/// Declares a kernel module that exposes a single file system.
+///
+/// The `type` argument must be a type which implements the [`FileSystem`] trait. Also accepts
+/// various forms of kernel metadata.
+///
+/// # Examples
+///
+/// ```
+/// # mod module_fs_sample {
+/// use kernel::prelude::*;
+/// use kernel::{c_str, fs};
+///
+/// kernel::module_fs! {
+///     type: MyFs,
+///     name: "myfs",
+///     author: "Rust for Linux Contributors",
+///     description: "My Rust fs",
+///     license: "GPL",
+/// }
+///
+/// struct MyFs;
+/// impl fs::FileSystem for MyFs {
+///     const NAME: &'static CStr = c_str!("myfs");
+/// }
+/// # }
+/// ```
+#[macro_export]
+macro_rules! module_fs {
+    (type: $type:ty, $($f:tt)*) => {
+        type ModuleType = $crate::fs::Module<$type>;
+        $crate::macros::module! {
+            type: ModuleType,
+            $($f)*
+        }
+    }
+}
-- 
2.34.1


