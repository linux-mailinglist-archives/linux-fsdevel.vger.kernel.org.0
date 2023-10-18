Return-Path: <linux-fsdevel+bounces-639-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF617CDB8E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 14:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C74B3281C8C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 12:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA8D347C6;
	Wed, 18 Oct 2023 12:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l6H2IcdA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4864F2E3E2;
	Wed, 18 Oct 2023 12:26:29 +0000 (UTC)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6AA0116;
	Wed, 18 Oct 2023 05:26:27 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1c5cd27b1acso56935005ad.2;
        Wed, 18 Oct 2023 05:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697631987; x=1698236787; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TOXJ6HCqnTLSNdE+9pmC2+R+Ar90JbQvM+mVG2JfMR8=;
        b=l6H2IcdAtcJ5znLozguRdMvBzON4CR8fO4yVgukzlvZTOqFqDStDjq0MFLFMQqdv3K
         W4P+ndjG2Eq4oI1iWBJjNwUxLQPSmmuxOqHX+O4z9IdkPGpsRykCPGswpftGTLAvrwho
         toJt9Iue9nX+LXiB7XRvitW4mksINFhJzt+/VIr644rIi860MALp83so+x9XO2I9D2IK
         hUa7hLaeCaxLP+nOLxArg+WE0qEgqY53/+ze+zyjhQU4WOPaGVe2x373YLeY3ILHsxHj
         qMq2r0OsrfMg32JWIqsdxAk5fJ+79EqNuLRExd5AwoYwWJ7b4775p2XoKLF3CRbLFZBE
         lSlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697631987; x=1698236787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TOXJ6HCqnTLSNdE+9pmC2+R+Ar90JbQvM+mVG2JfMR8=;
        b=BZoK0QpVmIDxwE1uE5vSZTk+BiflnOw16NbAQ8R+JQLdYDCbXfmnH7/rgCJFe3nc7c
         e6bKLM/ryg+M3CjbYBhbJmufiMJD5QsOoIBTFhpwAlEEoY8OwO8PPjq+GqYNi1WvQ+I4
         Vc0l6jMel+rgCPYJ9F3LC3vNFfyXZ/bIJI8YBGWO665PrVs5h/v1q9zGvienTtCBHF7z
         RSF6CtBqPXBUibK3cJU0cQozdCzZfU9lNJtlekdctpfynYGfvP8c4pwrnE98+aGO5qu4
         LGehAckalwSi5hPz5TMR7Ghk9IeqgLPuelGVHvZhwVVr8Wt6oCQBTFxN2v6jq9m9yTUa
         HK4w==
X-Gm-Message-State: AOJu0YxVfVQKPbcxttax33hKk2UqerEZ+Rut4fw/eTfhYn5DUxvKiRct
	wwKR97Ffv8GqPAgWJ3bc5h0=
X-Google-Smtp-Source: AGHT+IHmI+V3WZWkIG5bC05LPMNEeVYGYnLJAfVX+xOxPrJPBJdygDxXPnb/BwmwGl65cxUCLX/UBQ==
X-Received: by 2002:a17:902:cf47:b0:1bb:9f07:5e0 with SMTP id e7-20020a170902cf4700b001bb9f0705e0mr4697508plg.60.1697631987295;
        Wed, 18 Oct 2023 05:26:27 -0700 (PDT)
Received: from wedsonaf-dev.. ([2804:389:7122:43b8:9b73:6339:3351:cce0])
        by smtp.googlemail.com with ESMTPSA id j1-20020a170902c3c100b001c736b0037fsm3411046plj.231.2023.10.18.05.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 05:26:27 -0700 (PDT)
From: Wedson Almeida Filho <wedsonaf@gmail.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Matthew Wilcox <willy@infradead.org>
Cc: Kent Overstreet <kent.overstreet@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fsdevel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	Wedson Almeida Filho <walmeida@microsoft.com>
Subject: [RFC PATCH 11/19] rust: fs: introduce `FileSystem::read_xattr`
Date: Wed, 18 Oct 2023 09:25:10 -0300
Message-Id: <20231018122518.128049-12-wedsonaf@gmail.com>
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
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Wedson Almeida Filho <walmeida@microsoft.com>

Allow Rust file systems to expose xattrs associated with inodes.
`overlayfs` uses an xattr to indicate that a directory is opaque (i.e.,
that lower layers should not be looked up). The planned file systems
need to support opaque directories, so they must be able to implement
this.

Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
 rust/bindings/bindings_helper.h |  1 +
 rust/kernel/error.rs            |  2 ++
 rust/kernel/fs.rs               | 43 +++++++++++++++++++++++++++++++++
 3 files changed, 46 insertions(+)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 53a99ea512d1..fa754c5e85a2 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -15,6 +15,7 @@
 #include <linux/refcount.h>
 #include <linux/wait.h>
 #include <linux/sched.h>
+#include <linux/xattr.h>
 
 /* `bindgen` gets confused at certain things. */
 const size_t BINDINGS_ARCH_SLAB_MINALIGN = ARCH_SLAB_MINALIGN;
diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
index 484fa7c11de1..6c167583b275 100644
--- a/rust/kernel/error.rs
+++ b/rust/kernel/error.rs
@@ -81,6 +81,8 @@ macro_rules! declare_err {
     declare_err!(EIOCBQUEUED, "iocb queued, will get completion event.");
     declare_err!(ERECALLCONFLICT, "Conflict with recalled state.");
     declare_err!(ENOGRACE, "NFS file lock reclaim refused.");
+    declare_err!(ENODATA, "No data available.");
+    declare_err!(EOPNOTSUPP, "Operation not supported on transport endpoint.");
 }
 
 /// Generic integer kernel error.
diff --git a/rust/kernel/fs.rs b/rust/kernel/fs.rs
index ee3dce87032b..adf9cbee16d2 100644
--- a/rust/kernel/fs.rs
+++ b/rust/kernel/fs.rs
@@ -42,6 +42,14 @@ pub trait FileSystem {
 
     /// Reads the contents of the inode into the given folio.
     fn read_folio(inode: &INode<Self>, folio: LockedFolio<'_>) -> Result;
+
+    /// Reads an xattr.
+    ///
+    /// Returns the number of bytes written to `outbuf`. If it is too small, returns the number of
+    /// bytes needs to hold the attribute.
+    fn read_xattr(_inode: &INode<Self>, _name: &CStr, _outbuf: &mut [u8]) -> Result<usize> {
+        Err(EOPNOTSUPP)
+    }
 }
 
 /// The types of directory entries reported by [`FileSystem::read_dir`].
@@ -418,6 +426,7 @@ impl<T: FileSystem + ?Sized> Tables<T> {
 
             sb.0.s_magic = params.magic as _;
             sb.0.s_op = &Tables::<T>::SUPER_BLOCK;
+            sb.0.s_xattr = &Tables::<T>::XATTR_HANDLERS[0];
             sb.0.s_maxbytes = params.maxbytes;
             sb.0.s_time_gran = params.time_gran;
             sb.0.s_blocksize_bits = params.blocksize_bits;
@@ -487,6 +496,40 @@ impl<T: FileSystem + ?Sized> Tables<T> {
         shutdown: None,
     };
 
+    const XATTR_HANDLERS: [*const bindings::xattr_handler; 2] = [&Self::XATTR_HANDLER, ptr::null()];
+
+    const XATTR_HANDLER: bindings::xattr_handler = bindings::xattr_handler {
+        name: ptr::null(),
+        prefix: crate::c_str!("").as_char_ptr(),
+        flags: 0,
+        list: None,
+        get: Some(Self::xattr_get_callback),
+        set: None,
+    };
+
+    unsafe extern "C" fn xattr_get_callback(
+        _handler: *const bindings::xattr_handler,
+        _dentry: *mut bindings::dentry,
+        inode_ptr: *mut bindings::inode,
+        name: *const core::ffi::c_char,
+        buffer: *mut core::ffi::c_void,
+        size: usize,
+    ) -> core::ffi::c_int {
+        from_result(|| {
+            // SAFETY: The C API guarantees that `inode_ptr` is a valid inode.
+            let inode = unsafe { &*inode_ptr.cast::<INode<T>>() };
+
+            // SAFETY: The c API guarantees that `name` is a valid null-terminated string. It
+            // also guarantees that it's valid for the duration of the callback.
+            let name = unsafe { CStr::from_char_ptr(name) };
+
+            // SAFETY: The C API guarantees that `buffer` is at least `size` bytes in length.
+            let buf = unsafe { core::slice::from_raw_parts_mut(buffer.cast(), size) };
+            let len = T::read_xattr(inode, name, buf)?;
+            Ok(len.try_into()?)
+        })
+    }
+
     const DIR_FILE_OPERATIONS: bindings::file_operations = bindings::file_operations {
         owner: ptr::null_mut(),
         llseek: Some(bindings::generic_file_llseek),
-- 
2.34.1


