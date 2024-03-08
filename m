Return-Path: <linux-fsdevel+bounces-14019-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76806876A5E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Mar 2024 19:03:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 179721F217DF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Mar 2024 18:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D934358AAF;
	Fri,  8 Mar 2024 18:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dorminy.me header.i=@dorminy.me header.b="d3csgJOs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from box.fidei.email (box.fidei.email [71.19.144.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FC054BDA;
	Fri,  8 Mar 2024 18:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=71.19.144.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709921015; cv=none; b=eeAZNskgRWI6idVBiT27jmK6lEGQ8feamAd6yIEZQTUfvXfrnr+jRN/3Z2ugtZFPbt8ppsQ4DO02WkwVzYGAenKzOlcz+X32NwkPMQ6UnYT0wMAMWF8Gehp9ACowcccfpd1VGWkdRGm5N6QeUt0E5kSV6Qm4+B7p6IaWef/k7pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709921015; c=relaxed/simple;
	bh=yPYse9cLaIMIzQ4VAGXwmwYK5q7NQZ6Jk79N+3nOByU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PGM2xYpyXyqkxnQ4s7AKIDLJ10EXavwmr7nVpXQ7xiMWxRH6EAYy/N0ZGgATeTr0N/3/idxEd7parRxVLxOFMSU6/8Ndr+lUBJo9bWIx6vyumTLppPptuctfb5/z2ZIWrbZeL4Hxnap74O1ugoo0fQr7parddMFrcdfJtlzpwBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dorminy.me; spf=pass smtp.mailfrom=dorminy.me; dkim=pass (2048-bit key) header.d=dorminy.me header.i=@dorminy.me header.b=d3csgJOs; arc=none smtp.client-ip=71.19.144.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dorminy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dorminy.me
Received: from authenticated-user (box.fidei.email [71.19.144.250])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by box.fidei.email (Postfix) with ESMTPSA id E9E6582569;
	Fri,  8 Mar 2024 13:03:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
	t=1709921007; bh=yPYse9cLaIMIzQ4VAGXwmwYK5q7NQZ6Jk79N+3nOByU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d3csgJOsTBJvRPo/w5FyGQnenZgYGfRmewHnQDinhCj1a7+8Wvnr1/TrB7GyOUrqr
	 izMIRkKqQvvSphRRgma3TNo/t/1+iP14JV0D411TZonhtUEHRLi9sSqqEWI8YE93HO
	 O/qGEkjPZaWFdcTOTzcd+OKjBhLvAGXJv0n+Lodgd/mbEKTVv8CXV41QdIVNKJ7D5E
	 VJtf9pe9AdTrHDjbjus/AIohOGjbGL9NUWXmU6c0IqO/IE96ndcxzmBgjG0WAP4nTY
	 pxyWtpgP4tpHvPYRAVN8XtItPL0OMrX25P4r24dfd48lDmzOjrqal4bdarPQ+Lp4NT
	 5ZRM3/PCfnaxg==
From: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
To: corbet@lwn.net,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	clm@meta.com,
	dsterba@suse.com,
	josef@toxicpanda.com
Cc: jbacik@toxicpanda.com,
	kernel-team@meta.com,
	Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH 1/3] fs: add physical_length field to fiemap extents
Date: Fri,  8 Mar 2024 13:03:18 -0500
Message-ID: <0b423d44538f3827a255f1f842b57b4a768b7629.1709918025.git.sweettea-kernel@dorminy.me>
In-Reply-To: <cover.1709918025.git.sweettea-kernel@dorminy.me>
References: <cover.1709918025.git.sweettea-kernel@dorminy.me>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some filesystems support compressed extents which have a larger logical
size than physical, and for those filesystems, it can be useful for
userspace to know how much space those extents actually use. For
instance, the compsize [1] tool for btrfs currently uses btrfs-internal,
root-only ioctl to find the actual disk space used by a file; it would
be better and more useful for this information to require fewer
privileges and to be usable on more filesystems. Therefore, use one of
the padding u64s in the fiemap extent structure to return the actual
physical length; and, for now, return this as equal to the logical
length.

[1] https://github.com/kilobyte/compsize

Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
---
 Documentation/filesystems/fiemap.rst | 26 ++++++++++++++++++--------
 fs/ioctl.c                           |  1 +
 include/uapi/linux/fiemap.h          | 24 +++++++++++++++++-------
 3 files changed, 36 insertions(+), 15 deletions(-)

diff --git a/Documentation/filesystems/fiemap.rst b/Documentation/filesystems/fiemap.rst
index 93fc96f760aa..e3e84573b087 100644
--- a/Documentation/filesystems/fiemap.rst
+++ b/Documentation/filesystems/fiemap.rst
@@ -80,14 +80,24 @@ Each extent is described by a single fiemap_extent structure as
 returned in fm_extents::
 
     struct fiemap_extent {
-	    __u64	fe_logical;  /* logical offset in bytes for the start of
-				* the extent */
-	    __u64	fe_physical; /* physical offset in bytes for the start
-				* of the extent */
-	    __u64	fe_length;   /* length in bytes for the extent */
-	    __u64	fe_reserved64[2];
-	    __u32	fe_flags;    /* FIEMAP_EXTENT_* flags for this extent */
-	    __u32	fe_reserved[3];
+            /*
+             * logical offset in bytes for the start of
+             * the extent from the beginning of the file
+             */
+            __u64 fe_logical;
+            /*
+             * physical offset in bytes for the start
+             * of the extent from the beginning of the disk
+             */
+            __u64 fe_physical;
+            /* length in bytes for this extent */
+            __u64 fe_length;
+            /* physical length in bytes for this extent */
+            __u64 fe_physical_length;
+            __u64 fe_reserved64[1];
+            /* FIEMAP_EXTENT_* flags for this extent */
+            __u32 fe_flags;
+            __u32 fe_reserved[3];
     };
 
 All offsets and lengths are in bytes and mirror those on disk.  It is valid
diff --git a/fs/ioctl.c b/fs/ioctl.c
index 1d5abfdf0f22..f8e5d6dfc62d 100644
--- a/fs/ioctl.c
+++ b/fs/ioctl.c
@@ -139,6 +139,7 @@ int fiemap_fill_next_extent(struct fiemap_extent_info *fieinfo, u64 logical,
 	extent.fe_logical = logical;
 	extent.fe_physical = phys;
 	extent.fe_length = len;
+	extent.fe_physical_length = len;
 	extent.fe_flags = flags;
 
 	dest += fieinfo->fi_extents_mapped;
diff --git a/include/uapi/linux/fiemap.h b/include/uapi/linux/fiemap.h
index 24ca0c00cae3..fd3c7d380666 100644
--- a/include/uapi/linux/fiemap.h
+++ b/include/uapi/linux/fiemap.h
@@ -15,13 +15,23 @@
 #include <linux/types.h>
 
 struct fiemap_extent {
-	__u64 fe_logical;  /* logical offset in bytes for the start of
-			    * the extent from the beginning of the file */
-	__u64 fe_physical; /* physical offset in bytes for the start
-			    * of the extent from the beginning of the disk */
-	__u64 fe_length;   /* length in bytes for this extent */
-	__u64 fe_reserved64[2];
-	__u32 fe_flags;    /* FIEMAP_EXTENT_* flags for this extent */
+	/*
+	 * logical offset in bytes for the start of
+	 * the extent from the beginning of the file
+	 */
+	__u64 fe_logical;
+	/*
+	 * physical offset in bytes for the start
+	 * of the extent from the beginning of the disk
+	 */
+	__u64 fe_physical;
+	/* length in bytes for this extent */
+	__u64 fe_length;
+	/* physical length in bytes for this extent */
+	__u64 fe_physical_length;
+	__u64 fe_reserved64[1];
+	/* FIEMAP_EXTENT_* flags for this extent */
+	__u32 fe_flags;
 	__u32 fe_reserved[3];
 };
 
-- 
2.44.0


