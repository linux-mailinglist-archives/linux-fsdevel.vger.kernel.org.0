Return-Path: <linux-fsdevel+bounces-11346-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0031A852CAB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 10:43:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4EC04B25ABC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 09:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41BA85381D;
	Tue, 13 Feb 2024 09:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="lAJKQkv8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E956537E3;
	Tue, 13 Feb 2024 09:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707817089; cv=none; b=T/yHYKfrF7fDWoTpBPSsYl/0f3X0ruNxGYM/qXt35skuUko4woleCejFACYdQmAxwnR7DU9OvtILoUh+2E0/QHh1LL61DLw+9WtFGYHS4dN5MiBpIONcv5i49HCBDBsCZCn8N/6vhPV2sD2V5MHPFUEOQnVYo4zcgzdaemM6Ib4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707817089; c=relaxed/simple;
	bh=7g8Bs2Rmp6gOJnEQAVWC55gjo2MoxR/e102tY8njEUU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H91bQu7aYiYsZ8MQZxCLxm9FwAA7C3sO3uWKUU955vFwHSs3au6Sz3peoGNyhoHzZpIrY08x5pmKjI84rcQP30BnNLUczUwNyoRsQZzO1yaSR8fW6iGbcWNL22iD16dLD5Ph9uOOGXQSQOCPeE9QlYY8YqHJJXAU/D68t+w2B0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=lAJKQkv8; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4TYx8D3Xykz9t40;
	Tue, 13 Feb 2024 10:38:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1707817084;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+2ss5SlGBbWn5UCkRFfS2rrVeqSyvxI6jrmUJVBEXU4=;
	b=lAJKQkv8JFUfAalsowcHUM0qevPxPDym9zxQEdcsGZ1QD34oloukLEkuEh9wYi/vwk3vTz
	88MWHR5ma60yh6fcF9kNUWOoPzhytLjV6Ujqkm3NEpqVKXssY+AJ7VmlsSzPHrbWqiHHA/
	nnbX4EV4Fhls9o8I6ajQX4wDUiZx29RHWX8bCkX0wpri4sldWbDFrGm1ryQp5raRgie1qr
	Lqsie4oCOj0gEl5zUVTbX8ms0OBr8KlMQBHEY4+8qUfqB3zPYcRNxXNbTgt3YZGojnJJEv
	sgKHAUiic9WDKzyryMjZWH9/hR/YdqHkJvfMwSZBVuLypx3foevRXAeEudMk+A==
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: mcgrof@kernel.org,
	gost.dev@samsung.com,
	akpm@linux-foundation.org,
	kbusch@kernel.org,
	djwong@kernel.org,
	chandan.babu@oracle.com,
	p.raghav@samsung.com,
	linux-kernel@vger.kernel.org,
	hare@suse.de,
	willy@infradead.org,
	linux-mm@kvack.org,
	david@fromorbit.com
Subject: [RFC v2 13/14] xfs: add an experimental CONFIG_XFS_LBS option
Date: Tue, 13 Feb 2024 10:37:12 +0100
Message-ID: <20240213093713.1753368-14-kernel@pankajraghav.com>
In-Reply-To: <20240213093713.1753368-1-kernel@pankajraghav.com>
References: <20240213093713.1753368-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pankaj Raghav <p.raghav@samsung.com>

Add an experimental CONFIG_XFS_LBS option to enable LBS support in XFS.
Retain the ASSERT for PAGE_SHIFT if CONFIG_XFS_LBS is not enabled.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 fs/xfs/Kconfig     | 11 +++++++++++
 fs/xfs/xfs_mount.c |  4 +++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/Kconfig b/fs/xfs/Kconfig
index 567fb37274d3..6b0db2f7dc13 100644
--- a/fs/xfs/Kconfig
+++ b/fs/xfs/Kconfig
@@ -216,3 +216,14 @@ config XFS_ASSERT_FATAL
 	  result in warnings.
 
 	  This behavior can be modified at runtime via sysfs.
+
+config XFS_LBS
+	bool "XFS large block size support (EXPERIMENTAL)"
+	depends on XFS_FS
+	help
+	  Set Y to enable support for filesystem block size > system's
+	  base page size.
+
+	  This feature is considered EXPERIMENTAL.  Use with caution!
+
+	  If unsure, say N.
diff --git a/fs/xfs/xfs_mount.c b/fs/xfs/xfs_mount.c
index bfbaaecaf668..596aa2cdefbc 100644
--- a/fs/xfs/xfs_mount.c
+++ b/fs/xfs/xfs_mount.c
@@ -131,11 +131,13 @@ xfs_sb_validate_fsb_count(
 	xfs_sb_t	*sbp,
 	uint64_t	nblocks)
 {
-	ASSERT(PAGE_SHIFT >= sbp->sb_blocklog);
 	ASSERT(sbp->sb_blocklog >= BBSHIFT);
 	unsigned long mapping_count;
 	uint64_t bytes = nblocks << sbp->sb_blocklog;
 
+	if (!IS_ENABLED(CONFIG_XFS_LBS))
+		ASSERT(PAGE_SHIFT >= sbp->sb_blocklog);
+
 	mapping_count = bytes >> PAGE_SHIFT;
 
 	/* Limited by ULONG_MAX of page cache index */
-- 
2.43.0


