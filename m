Return-Path: <linux-fsdevel+bounces-646-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 188DA7CDB96
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 14:27:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C56A9281D4E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 12:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 013D236B09;
	Wed, 18 Oct 2023 12:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SYkpmUX0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D973636AF4;
	Wed, 18 Oct 2023 12:27:00 +0000 (UTC)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0804112;
	Wed, 18 Oct 2023 05:26:59 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1c9bca1d96cso46359195ad.3;
        Wed, 18 Oct 2023 05:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697632019; x=1698236819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g8+DWlglX7SVD5ZBkaFTJfIFUorn1UXuo+uacl/Dd2w=;
        b=SYkpmUX08FCj/ef78QRCPACay7Z4AKpGKL8Qo233rDQjL7MQYasFx5MQjNpcylJr5G
         4ab8y4jDfcxMZzuVVp/4BrRdhP+vzS6HmaRKrtxhMYP5RmrQvx8BjtBey08hxkoFNdeE
         lCi/KUuzduXqzciwBbRqOvTum6coDX4h+VFzd/FbafBetU8U3Jd3p/xbaYjsFQmVoaJq
         NKgES9gVhZ/3HqL4fhWonRQCagKVjwZcPsqAmupvzCq05z1vjL4E59vSC+SmJgX7fC5m
         lDRZ1Pal1MoeR1hAky7A/URRP5MV9BZ0ilK3T7XxefS+PaQbCPHHgEUe7FCVgqEPa7Xl
         j3/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697632019; x=1698236819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g8+DWlglX7SVD5ZBkaFTJfIFUorn1UXuo+uacl/Dd2w=;
        b=hnydRF7YiV46PBvjUWJrQhWVwlp/pyEGCdgkIa7FOYmi3aql9Vz8/K/w4pKWQGvyHk
         ZhHLRw3wN5Hu2N2vuevy7cQ2HHt1QyY0TLUCWfE5bPfWQgAlu4B3CcL6Hg8yG3KS0J61
         HNrUucfEQ2ZUNLUy4QcUabXFwSD419/OeIqzfJVb+3wdZaHobLbUkkz8SoyDbw/fc7ML
         ep2MGRMH9KiwlwNnyK9Lt9iFliO14T7HfzBpX3YoY7zfUCvCK8kJPB31TSQL5c4pIICO
         1LQxra29HW2xbfYSiprYORsM6r/dahqFvexDxVA3yPyWIf0fG0Mg3acm6fbxQVCB6FWt
         z0GQ==
X-Gm-Message-State: AOJu0YwO//8Dh8Sn+KEnLcCW3Ir5+DhwpQ9GQram78N9AH1M07aFfX48
	W8k+5bI7YpVyddB6PzrtpIRIv5YWdk4=
X-Google-Smtp-Source: AGHT+IEPEG68E5b+I+fTMfrD4FGmDQKMn4J9FhpuHwxW1NHdKzro4p29A2dxB3N/1w74bpJ3ejSh0Q==
X-Received: by 2002:a17:903:2283:b0:1c9:e2ed:66fe with SMTP id b3-20020a170903228300b001c9e2ed66femr5583262plh.52.1697632019096;
        Wed, 18 Oct 2023 05:26:59 -0700 (PDT)
Received: from wedsonaf-dev.. ([2804:389:7122:43b8:9b73:6339:3351:cce0])
        by smtp.googlemail.com with ESMTPSA id j1-20020a170902c3c100b001c736b0037fsm3411046plj.231.2023.10.18.05.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 05:26:58 -0700 (PDT)
From: Wedson Almeida Filho <wedsonaf@gmail.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Matthew Wilcox <willy@infradead.org>
Cc: Kent Overstreet <kent.overstreet@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fsdevel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	Wedson Almeida Filho <walmeida@microsoft.com>
Subject: [RFC PATCH 18/19] rust: fs: export file type from mode constants
Date: Wed, 18 Oct 2023 09:25:17 -0300
Message-Id: <20231018122518.128049-19-wedsonaf@gmail.com>
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

Allow Rust file system modules to use these constants if needed.

Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
 rust/kernel/fs.rs | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/rust/kernel/fs.rs b/rust/kernel/fs.rs
index b07203758674..235a86ed1127 100644
--- a/rust/kernel/fs.rs
+++ b/rust/kernel/fs.rs
@@ -20,6 +20,33 @@
 #[cfg(CONFIG_BUFFER_HEAD)]
 pub mod buffer;
 
+/// Contains constants related to Linux file modes.
+pub mod mode {
+    /// A bitmask used to the file type from a mode value.
+    pub const S_IFMT: u32 = bindings::S_IFMT;
+
+    /// File type constant for block devices.
+    pub const S_IFBLK: u32 = bindings::S_IFBLK;
+
+    /// File type constant for char devices.
+    pub const S_IFCHR: u32 = bindings::S_IFCHR;
+
+    /// File type constant for directories.
+    pub const S_IFDIR: u32 = bindings::S_IFDIR;
+
+    /// File type constant for pipes.
+    pub const S_IFIFO: u32 = bindings::S_IFIFO;
+
+    /// File type constant for symbolic links.
+    pub const S_IFLNK: u32 = bindings::S_IFLNK;
+
+    /// File type constant for regular files.
+    pub const S_IFREG: u32 = bindings::S_IFREG;
+
+    /// File type constant for sockets.
+    pub const S_IFSOCK: u32 = bindings::S_IFSOCK;
+}
+
 /// Maximum size of an inode.
 pub const MAX_LFS_FILESIZE: i64 = bindings::MAX_LFS_FILESIZE;
 
-- 
2.34.1


