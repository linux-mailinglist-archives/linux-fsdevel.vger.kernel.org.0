Return-Path: <linux-fsdevel+bounces-38252-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F2C9FE0DF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Dec 2024 00:41:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57C863A1B4A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Dec 2024 23:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5C18198E91;
	Sun, 29 Dec 2024 23:41:27 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sxb1plsmtpa01-12.prod.sxb1.secureserver.net (sxb1plsmtpa01-12.prod.sxb1.secureserver.net [92.204.81.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67103199FAC
	for <linux-fsdevel@vger.kernel.org>; Sun, 29 Dec 2024 23:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.204.81.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735515687; cv=none; b=ofvK79Tuun9WnAYv5flrNJHvehdPNLUGyyY+qFPyH7zS0vlbXG0/MBLVCWPK2S0UdAKS1nGF3JGDaM4oWChKVBot61k43cNgwPPy4cj4W8IKEIBeGbMNNrUAetqv1n+2gKgb43O2TS44IuRXfR1Ha93rlWdKWgnHVCfOv63c1iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735515687; c=relaxed/simple;
	bh=HGd8YxJCwgHx/MCB8ncb5eesXC9PLQtWkKkK08EJpGk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PHBC+EFLKdwj23AyoEELZONLCgyDf6kTJo0WO4NSy/LM0wwE01LfhdDGhK2GHsXeMPvxCgLDgO2p4tdVpW0B3ePtLUHqqU7m8GZgRuQl9N7k16+RYQw/o/BLED3qgKm1pRIyjCtHCReccH4WcajarpxCNahDUS5iB7UScdPFjGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squashfs.org.uk; spf=pass smtp.mailfrom=squashfs.org.uk; arc=none smtp.client-ip=92.204.81.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squashfs.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squashfs.org.uk
Received: from raspberrypi.fritz.box ([82.69.79.175])
	by :SMTPAUTH: with ESMTPA
	id S2rotGQTRxZ1ZS2s2tFiUE; Sun, 29 Dec 2024 16:38:55 -0700
X-CMAE-Analysis: v=2.4 cv=S8MjwJsP c=1 sm=1 tr=0 ts=6771dd8f
 a=84ok6UeoqCVsigPHarzEiQ==:117 a=84ok6UeoqCVsigPHarzEiQ==:17 a=FP58Ms26AAAA:8
 a=FXvPX3liAAAA:8 a=NEAV23lmAAAA:8 a=JZ5mbIEbMWWLeFFGAloA:9
 a=UObqyxdv-6Yh2QiB9mM_:22
X-SECURESERVER-ACCT: phillip@squashfs.org.uk
From: Phillip Lougher <phillip@squashfs.org.uk>
To: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	akpm@linux-foundation.org
Cc: Phillip Lougher <phillip@squashfs.org.uk>
Subject: [PATCH 4/4] squashfs: update Kconfig information
Date: Sun, 29 Dec 2024 23:37:52 +0000
Message-Id: <20241229233752.54481-5-phillip@squashfs.org.uk>
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
X-CMAE-Envelope: MS4xfF+K+jNMCnrk3EFYgXptn8lBixI67938lKsGaUrNIrkuonoqj1+SwucEnuI8OdO80WbrT+qGTLYiSGaVTKGq+3IMLYnDmk0vkwvn9qNO2JnuqyPgTvsB
 9h8exH0kW3Mr48JmSEhDUdiAEDzP8Qz0pm9FOQ/SXt4+XfYTPnZnqZR2e/vEBOzcqzojTRYX15dL0guZYzR5krdlvdQEmbjFt5FWhJTRIaMz5zclIOZONQtK
 VZNxeIwYLlBX0XsQZfZUzukoO0cGJ2g4EDJUg0kMoW2O1SFmOCUEt0nDVckNv+6RpxA5UbiC8luHWtuTvJC7cjTphF2jNhXiXmHWeEiAz4U=

Update the compression algorithms supported, and
the Squashfs website location.

Signed-off-by: Phillip Lougher <phillip@squashfs.org.uk>
---
 fs/squashfs/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/squashfs/Kconfig b/fs/squashfs/Kconfig
index 60fc98bdf421..b1091e70434a 100644
--- a/fs/squashfs/Kconfig
+++ b/fs/squashfs/Kconfig
@@ -5,8 +5,8 @@ config SQUASHFS
 	help
 	  Saying Y here includes support for SquashFS 4.0 (a Compressed
 	  Read-Only File System).  Squashfs is a highly compressed read-only
-	  filesystem for Linux.  It uses zlib, lzo or xz compression to
-	  compress both files, inodes and directories.  Inodes in the system
+	  filesystem for Linux.  It uses zlib, lz4, lzo, xz or zstd compression
+	  to compress both files, inodes and directories.  Inodes in the system
 	  are very small and all blocks are packed to minimise data overhead.
 	  Block sizes greater than 4K are supported up to a maximum of 1 Mbytes
 	  (default block size 128K).  SquashFS 4.0 supports 64 bit filesystems
@@ -16,7 +16,7 @@ config SQUASHFS
 	  Squashfs is intended for general read-only filesystem use, for
 	  archival use (i.e. in cases where a .tar.gz file may be used), and in
 	  embedded systems where low overhead is needed.  Further information
-	  and tools are available from http://squashfs.sourceforge.net.
+	  and tools are available from github.com/plougher/squashfs-tools.
 
 	  If you want to compile this as a module ( = code which can be
 	  inserted in and removed from the running kernel whenever you want),
-- 
2.39.5


