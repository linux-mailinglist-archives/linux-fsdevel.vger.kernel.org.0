Return-Path: <linux-fsdevel+bounces-640-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE69E7CDB8F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 14:27:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AAA91C20D21
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 12:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3EB334CD3;
	Wed, 18 Oct 2023 12:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ir5ojnam"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9603A2E3E2;
	Wed, 18 Oct 2023 12:26:33 +0000 (UTC)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F0310F;
	Wed, 18 Oct 2023 05:26:32 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1c9bf22fe05so44152525ad.2;
        Wed, 18 Oct 2023 05:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697631992; x=1698236792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g3z7jtZCawQRFiOqSOKhrwT4h1/aQJhIrBv9urAW4S4=;
        b=Ir5ojnamww0a1FwJtVQJWO9nDqS7BjirzTfs62xLJ+aVnWhNnWQnKYOTjjtftfZND2
         WFJv3Gq+VqqsAanHjlZmOyFnMpaU0sGmVxsFDFwa6lrSdMonOEqHQwmK5bcEHaMe++Uu
         wyWd+JPXBzCBI9TymePqW1MCqVXWEcGnJlb08iH8q9jK/+IVKpFsf/gL4dnOQ8ykjwtE
         YM+k4mLHUJqwfWjuUIU/Zm6jjZ0K3cCNfTV4pGYy18EOZ/9Gtn6SmHltLMaj7hiNym7q
         +21QVlAzUlg/xpiYj9YsjdIXno/G36Vs12JStEPEuj6OFZSSnm19tqiQrCobtndT17R/
         TKGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697631992; x=1698236792;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g3z7jtZCawQRFiOqSOKhrwT4h1/aQJhIrBv9urAW4S4=;
        b=a8QF4frNjHmg7TlEJTZg/MM8ytASGu3+ElZJjClQu5w+bQzcHgKZr0R3/21yFeYEqj
         tarCEaySyJrMbXZedgI53yvkWY9wr5QpMffCD6Mieep8s0mFY2pkNVZREUgKmwzKBqkN
         x9yiQH6JbiWjG5rtuwZp3Pt7NVZgNKDSy2jt3wIh/4JLL+3FUHiUcqx4du+s0u1LqXH/
         svJFwypUb4mX3pJeiqxynXrwuBtX+uUyGco2ogQJmk5bck25M7FTlsrw2AnypHG57qmL
         U0hprCkWpFv36MD83nEbvRHY1JpihdYDJ24NwXReQ5TlgiPGwZsskxN5/viePpApiBvQ
         zizw==
X-Gm-Message-State: AOJu0YwYDH6cb3JrSzDin+ua9XiPhMvpLDDZtmYt/oFKYl1UIhbkq70k
	tlM8UanjZ98CcYqjoie3W7M=
X-Google-Smtp-Source: AGHT+IH8rNj3uMZrih2JbOxA4Yw21v1GLCW55MULU2mj7HkocA8Pcp2kr5/60c3qf0iEX7aGhDHoTg==
X-Received: by 2002:a17:902:c412:b0:1c3:1f0c:fb82 with SMTP id k18-20020a170902c41200b001c31f0cfb82mr5567108plk.41.1697631991812;
        Wed, 18 Oct 2023 05:26:31 -0700 (PDT)
Received: from wedsonaf-dev.. ([2804:389:7122:43b8:9b73:6339:3351:cce0])
        by smtp.googlemail.com with ESMTPSA id j1-20020a170902c3c100b001c736b0037fsm3411046plj.231.2023.10.18.05.26.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 05:26:31 -0700 (PDT)
From: Wedson Almeida Filho <wedsonaf@gmail.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Matthew Wilcox <willy@infradead.org>
Cc: Kent Overstreet <kent.overstreet@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fsdevel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	Wedson Almeida Filho <walmeida@microsoft.com>
Subject: [RFC PATCH 12/19] rust: fs: introduce `FileSystem::statfs`
Date: Wed, 18 Oct 2023 09:25:11 -0300
Message-Id: <20231018122518.128049-13-wedsonaf@gmail.com>
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

Allow Rust file systems to expose their stats. `overlayfs` requires that
this be implemented by all file systems that are part of an overlay.
The planned file systems need to be overlayed with overlayfs, so they
must be able to implement this.

Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
 rust/bindings/bindings_helper.h |  1 +
 rust/kernel/error.rs            |  1 +
 rust/kernel/fs.rs               | 52 ++++++++++++++++++++++++++++++++-
 3 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index fa754c5e85a2..e2b2ccc835e3 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -11,6 +11,7 @@
 #include <linux/fs.h>
 #include <linux/fs_context.h>
 #include <linux/slab.h>
+#include <linux/statfs.h>
 #include <linux/pagemap.h>
 #include <linux/refcount.h>
 #include <linux/wait.h>
diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
index 6c167583b275..829756cf6c48 100644
--- a/rust/kernel/error.rs
+++ b/rust/kernel/error.rs
@@ -83,6 +83,7 @@ macro_rules! declare_err {
     declare_err!(ENOGRACE, "NFS file lock reclaim refused.");
     declare_err!(ENODATA, "No data available.");
     declare_err!(EOPNOTSUPP, "Operation not supported on transport endpoint.");
+    declare_err!(ENOSYS, "Invalid system call number.");
 }
 
 /// Generic integer kernel error.
diff --git a/rust/kernel/fs.rs b/rust/kernel/fs.rs
index adf9cbee16d2..8f34da50e694 100644
--- a/rust/kernel/fs.rs
+++ b/rust/kernel/fs.rs
@@ -50,6 +50,31 @@ pub trait FileSystem {
     fn read_xattr(_inode: &INode<Self>, _name: &CStr, _outbuf: &mut [u8]) -> Result<usize> {
         Err(EOPNOTSUPP)
     }
+
+    /// Get filesystem statistics.
+    fn statfs(_sb: &SuperBlock<Self>) -> Result<Stat> {
+        Err(ENOSYS)
+    }
+}
+
+/// File system stats.
+///
+/// A subset of C's `kstatfs`.
+pub struct Stat {
+    /// Magic number of the file system.
+    pub magic: u32,
+
+    /// The maximum length of a file name.
+    pub namelen: i64,
+
+    /// Block size.
+    pub bsize: i64,
+
+    /// Number of files in the file system.
+    pub files: u64,
+
+    /// Number of blocks in the file system.
+    pub blocks: u64,
 }
 
 /// The types of directory entries reported by [`FileSystem::read_dir`].
@@ -478,7 +503,7 @@ impl<T: FileSystem + ?Sized> Tables<T> {
         freeze_fs: None,
         thaw_super: None,
         unfreeze_fs: None,
-        statfs: None,
+        statfs: Some(Self::statfs_callback),
         remount_fs: None,
         umount_begin: None,
         show_options: None,
@@ -496,6 +521,31 @@ impl<T: FileSystem + ?Sized> Tables<T> {
         shutdown: None,
     };
 
+    unsafe extern "C" fn statfs_callback(
+        dentry: *mut bindings::dentry,
+        buf: *mut bindings::kstatfs,
+    ) -> core::ffi::c_int {
+        from_result(|| {
+            // SAFETY: The C API guarantees that `dentry` is valid for read. `d_sb` is
+            // immutable, so it's safe to read it. The superblock is guaranteed to be valid dor
+            // the duration of the call.
+            let sb = unsafe { &*(*dentry).d_sb.cast::<SuperBlock<T>>() };
+            let s = T::statfs(sb)?;
+
+            // SAFETY: The C API guarantees that `buf` is valid for read and write.
+            let buf = unsafe { &mut *buf };
+            buf.f_type = s.magic.into();
+            buf.f_namelen = s.namelen;
+            buf.f_bsize = s.bsize;
+            buf.f_files = s.files;
+            buf.f_blocks = s.blocks;
+            buf.f_bfree = 0;
+            buf.f_bavail = 0;
+            buf.f_ffree = 0;
+            Ok(0)
+        })
+    }
+
     const XATTR_HANDLERS: [*const bindings::xattr_handler; 2] = [&Self::XATTR_HANDLER, ptr::null()];
 
     const XATTR_HANDLER: bindings::xattr_handler = bindings::xattr_handler {
-- 
2.34.1


