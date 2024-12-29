Return-Path: <linux-fsdevel+bounces-38251-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B29679FE0DD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Dec 2024 00:41:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F12333A1AFB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Dec 2024 23:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8C319ADBA;
	Sun, 29 Dec 2024 23:41:26 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sxb1plsmtpa01-12.prod.sxb1.secureserver.net (sxb1plsmtpa01-12.prod.sxb1.secureserver.net [188.121.53.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63AD619882F
	for <linux-fsdevel@vger.kernel.org>; Sun, 29 Dec 2024 23:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.121.53.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735515686; cv=none; b=oEqJVJEh9tJLzyShNls7zXkB1dPRGhe6s8wuxsEFEp/+G2vuGrNGHyWem/q59HmU5wHxdEQm8H5zz1BLt/2fkKVzZjsBi22efLFCpsl4E6B30TdxPRIs0Fv3zQcye+d8XdOvWVaW8Yl9QEvVwpcaP6OuAED0cQniOi2kwspv4r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735515686; c=relaxed/simple;
	bh=HrfHQrEXWE6KXcctRVRJvbH3DR/f1Rvc4kf5v+IYuTQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TACwZ3eHTDiZEs8ejdcOg0F7nLMnOHu/ZUe9c3ITdUtzruFTkvOGuwE61Ew/ySB2iQa2Y6NoWV0YU3xGqhFCacPS/TNWUbil7mEu0H6MaXp0H2DgpHULauiMmrn2P7srz2SInsnMXiTJsybKl3pYSln2JZSIEM2Y67yo4kL4JyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squashfs.org.uk; spf=pass smtp.mailfrom=squashfs.org.uk; arc=none smtp.client-ip=188.121.53.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squashfs.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squashfs.org.uk
Received: from raspberrypi.fritz.box ([82.69.79.175])
	by :SMTPAUTH: with ESMTPA
	id S2rotGQTRxZ1ZS2s0tFiUA; Sun, 29 Dec 2024 16:38:53 -0700
X-CMAE-Analysis: v=2.4 cv=S8MjwJsP c=1 sm=1 tr=0 ts=6771dd8e
 a=84ok6UeoqCVsigPHarzEiQ==:117 a=84ok6UeoqCVsigPHarzEiQ==:17 a=aUFYUWTwAAAA:8
 a=FXvPX3liAAAA:8 a=FP58Ms26AAAA:8 a=VwQbUJbxAAAA:8 a=NEAV23lmAAAA:8
 a=7dKtaLcL_q_8H7sW4w8A:9 a=o1zmNsm2e553tv4nPYj3:22 a=UObqyxdv-6Yh2QiB9mM_:22
X-SECURESERVER-ACCT: phillip@squashfs.org.uk
From: Phillip Lougher <phillip@squashfs.org.uk>
To: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	akpm@linux-foundation.org
Cc: Phillip Lougher <phillip@squashfs.org.uk>
Subject: [PATCH 3/4] Documentation: update the Squashfs filesystem documentation
Date: Sun, 29 Dec 2024 23:37:51 +0000
Message-Id: <20241229233752.54481-4-phillip@squashfs.org.uk>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241229233752.54481-1-phillip@squashfs.org.uk>
References: <20241229233752.54481-1-phillip@squashfs.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfG8CqR9RklzqpChEkxkSycmMku7z5wab+PIvYuO88BVrS6c1FOxyt0AsIHOfm0PoLL47HG5jiXsZd93TkH+4U+itqUrQ3o1Q/KYqrKHNk74JNp2YyjXw
 dGo7jj6xsrtMhDrhHXc16wwmyWHBcwSl6QUc/N7+GVWeR2v4bKhP76htURYiqvuXvyWzDwLOElcQ/FDOiwVpD3H017JLDsZXRezap2N5MhvbB9t8n0x/3wZr
 PZbQn7xEhMvcnEMb+6cNydqGg8MzvR+5ze15B+qPsuIoQS5O0vqKXmmbtjTHmMHFhoeBQSdQbs7o4C60ru3vSn2krlA7PzgoXRT6XuaZwLM=

This patch updates the following which are out of date.

- Zstd has been added to the compression algorithms supported.
- The filesystem mailing list (for the kernel code) is changed to
  linux-fsdevel rather than the now very little used Sourceforge
  mailing list.
- The Squashfs website has been changed to the Squashfs-tools github
  repository.
- The fact that Squashfs-tools is likely packaged by the linux
  distribution is mentioned.

Signed-off-by: Phillip Lougher <phillip@squashfs.org.uk>
---
 Documentation/filesystems/squashfs.rst | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/Documentation/filesystems/squashfs.rst b/Documentation/filesystems/squashfs.rst
index 4af8d6207509..45653b3228f9 100644
--- a/Documentation/filesystems/squashfs.rst
+++ b/Documentation/filesystems/squashfs.rst
@@ -6,7 +6,7 @@ Squashfs 4.0 Filesystem
 
 Squashfs is a compressed read-only filesystem for Linux.
 
-It uses zlib, lz4, lzo, or xz compression to compress files, inodes and
+It uses zlib, lz4, lzo, xz or zstd compression to compress files, inodes and
 directories.  Inodes in the system are very small and all blocks are packed to
 minimise data overhead. Block sizes greater than 4K are supported up to a
 maximum of 1Mbytes (default block size 128K).
@@ -16,8 +16,8 @@ use (i.e. in cases where a .tar.gz file may be used), and in constrained
 block device/memory systems (e.g. embedded systems) where low overhead is
 needed.
 
-Mailing list: squashfs-devel@lists.sourceforge.net
-Web site: www.squashfs.org
+Mailing list (kernel code): linux-fsdevel@vger.kernel.org
+Web site: github.com/plougher/squashfs-tools
 
 1. Filesystem Features
 ----------------------
@@ -58,11 +58,9 @@ inodes have different sizes).
 
 As squashfs is a read-only filesystem, the mksquashfs program must be used to
 create populated squashfs filesystems.  This and other squashfs utilities
-can be obtained from http://www.squashfs.org.  Usage instructions can be
-obtained from this site also.
-
-The squashfs-tools development tree is now located on kernel.org
-	git://git.kernel.org/pub/scm/fs/squashfs/squashfs-tools.git
+are very likely packaged by your linux distribution (called squashfs-tools).
+The source code can be obtained from github.com/plougher/squashfs-tools.
+Usage instructions can also be obtained from this site.
 
 2.1 Mount options
 -----------------
-- 
2.39.5


