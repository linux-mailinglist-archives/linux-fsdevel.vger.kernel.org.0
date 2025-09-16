Return-Path: <linux-fsdevel+bounces-61507-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF1CB58952
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:28:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D6E21B25CC9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1551DE8AF;
	Tue, 16 Sep 2025 00:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SSNAiiKT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C081DB377;
	Tue, 16 Sep 2025 00:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757982479; cv=none; b=hsEUuLrmsnRhI+DDBuvvSVPTgKiXpknmxntBUK3EOZ9UYhf2l5iiCKORZgOux+KSD/NXJZK0/TpTrsHiFpClAeESrG3QZqlRbO3thnaj2THi3B5rMjRssxhJciSQz91YMUVXPHN8PC5KSXMtdw9df1Dtrhq9dBqngDypoALGwZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757982479; c=relaxed/simple;
	bh=HT1DHlHLaa5BWVmlm6m4nWsHeoIvJuY0G6cJhLGNsnY=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MVHZaf6Fbn2rdMkgX9zvSLOsuNru0hTBrWSA0wgwJMd+wzw5hIwPoYwVht8UoykJz49y7l+bl4yMdS0rOwgvYd9RdnzLHcLCwiEYkq4ZDcDttf1m4s7qc8Q1JPFX058teFqSWgEbCMMPhTI9GLK6Y7w/bSLDr29yVNQJWGlyo30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SSNAiiKT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EC14C4CEF5;
	Tue, 16 Sep 2025 00:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757982479;
	bh=HT1DHlHLaa5BWVmlm6m4nWsHeoIvJuY0G6cJhLGNsnY=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=SSNAiiKTXNnXR19X/+9R7tcM8Y+Swyh8nf5ZNC9cIVu7FMp9p5Nt2MXSU1IqlVI1e
	 H2RTBLWHyuURl58wjd25fIAEjMIsAKOMV0LEfIQfr+6FBeSnf/yILggyu+JlHpV47j
	 JLVCzpTuD0MYTblc9+FmqBSr7gJSE6D7XnQ9/KzmEvWDfmIZwjLNnu+MQi0uI1oFVu
	 +qGvcxb6yRiIprJJfcKOBd/MJFORpSNmC7vLwHTH2evuyHoF4PjnPPqLtCq+Ui8dC0
	 C/ddSujREU0qiNaylPRyNA+e8eU88Eb0hW4zl1iUDvisCNa7HseFbxQcxuFEtbm+GV
	 O1NcTu+8/uDOg==
Date: Mon, 15 Sep 2025 17:27:58 -0700
Subject: [PATCH 5/5] fuse: move CREATE_TRACE_POINTS to a separate file
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: bernd@bsbernd.com, linux-xfs@vger.kernel.org, John@groves.net,
 linux-fsdevel@vger.kernel.org, neal@gompa.dev, joannelkoong@gmail.com
Message-ID: <175798150817.382479.14480676596668508285.stgit@frogsfrogsfrogs>
In-Reply-To: <175798150680.382479.9087542564560468560.stgit@frogsfrogsfrogs>
References: <175798150680.382479.9087542564560468560.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Before we start adding new tracepoints for fuse+iomap, move the
tracepoint creation itself to a separate source file so that we don't
have to start pulling iomap dependencies into dev.c just for the iomap
structures.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/Makefile |    3 ++-
 fs/fuse/dev.c    |    1 -
 fs/fuse/trace.c  |   13 +++++++++++++
 3 files changed, 15 insertions(+), 2 deletions(-)
 create mode 100644 fs/fuse/trace.c


diff --git a/fs/fuse/Makefile b/fs/fuse/Makefile
index 36be6d715b111a..46041228e5be2c 100644
--- a/fs/fuse/Makefile
+++ b/fs/fuse/Makefile
@@ -10,7 +10,8 @@ obj-$(CONFIG_FUSE_FS) += fuse.o
 obj-$(CONFIG_CUSE) += cuse.o
 obj-$(CONFIG_VIRTIO_FS) += virtiofs.o
 
-fuse-y := dev.o dir.o file.o inode.o control.o xattr.o acl.o readdir.o ioctl.o
+fuse-y := trace.o	# put trace.o first so we see ftrace errors sooner
+fuse-y += dev.o dir.o file.o inode.o control.o xattr.o acl.o readdir.o ioctl.o
 fuse-y += iomode.o
 fuse-$(CONFIG_FUSE_DAX) += dax.o
 fuse-$(CONFIG_FUSE_PASSTHROUGH) += passthrough.o
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 281bc81f3b448b..871877cac2acf3 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -26,7 +26,6 @@
 #include <linux/seq_file.h>
 #include <linux/nmi.h>
 
-#define CREATE_TRACE_POINTS
 #include "fuse_trace.h"
 
 MODULE_ALIAS_MISCDEV(FUSE_MINOR);
diff --git a/fs/fuse/trace.c b/fs/fuse/trace.c
new file mode 100644
index 00000000000000..93bd72efc98cd0
--- /dev/null
+++ b/fs/fuse/trace.c
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2025 Oracle.  All Rights Reserved.
+ * Author: Darrick J. Wong <djwong@kernel.org>
+ */
+#include "dev_uring_i.h"
+#include "fuse_i.h"
+#include "fuse_dev_i.h"
+
+#include <linux/pagemap.h>
+
+#define CREATE_TRACE_POINTS
+#include "fuse_trace.h"


