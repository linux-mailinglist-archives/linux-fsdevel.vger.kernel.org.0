Return-Path: <linux-fsdevel+bounces-36511-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DCDD9E4CD0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2024 04:44:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9B5918816A0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2024 03:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A3CA18FDDE;
	Thu,  5 Dec 2024 03:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gWL+Fotz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84C9653
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Dec 2024 03:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733370288; cv=none; b=YLhtKgvkHkNFq1E8sQ06rJ7sp8DRHDTHdzM/1ALJxqCNZFey0PEEvf8mRdG7kNyok/TeB+gOyfYqkpxnnHncTpOve8I4C+HJf2W8kfrdKMvtFvmKOiGQ4Zcb59JiEZu8kYnNtmPWmSeYkyioQp4Aey1p8wQuifJtBi2PekmzpXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733370288; c=relaxed/simple;
	bh=w0hRnH+H7d3kk2z0aPn2rllKFor7zoCilCYlHSpxZMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s8DAgkQOUFYMdnUF7rzM8KI7OEHJzHFaFimojjmckpJDxSa9QFAajRkUK+weqXrFbnZnFgfUn388yGTzEYofAs6t9K+1rICHFsBuKOSEW2OiYZ6uRMSLYoRN9QOtUsH+Hlj8rDXV4tvPlP8zBpanpQHmEK7rK6TdoToLFDlFkhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gWL+Fotz; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=Y6KzfxVnjVTK2J6y8vDYLAuZl0pSk3s6FUpfHNXx2dE=; b=gWL+FotztP0CS2eNHSQI7MgqJF
	+RZLJHb7Us3aCIX3fsSeqxBySn0wEV60uBx/fm0WylWqJC4e7ozTSCsHYHvBsTzsuz5JK+Sxn2j0E
	6e+GQmCnaE1SyM4HIv6Z9fYXTZhxyQ0Lw/ZLCQ5NvMxjz1eO0qAsdLsJICN9IPXHTRiG1YGGit5aC
	8Qqq+EnPXMPF40JQMzQ1O3iSBH0X8OwaCf+bilYfwl/Trp1SuPx54yzTtOXglLlsYcWH7cF60tc+y
	blGcPcPTkD52T6uDA9ykx3O+CMFbrY6ZM070OkXhHTxZjOOzinFb/f28yCuT+kF7/Wag/oI2RIOFB
	GaxGKJOQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tJ2nF-0000000EgAd-2ZA4;
	Thu, 05 Dec 2024 03:44:45 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: gregkh@linuxfoundation.org,
	russ.weight@linux.dev,
	dakr@redhat.com
Cc: mcgrof@kernel.org,
	song@kernel.org,
	mricon@kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2] firmware_loader: minor spelling fixes
Date: Wed,  4 Dec 2024 19:44:44 -0800
Message-ID: <20241205034444.3498690-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>

Run codespell on the *.[ch] files for the firmware loader.

Reviewed-by: Russ Weight <russ.weight@linux.dev>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---

This v2 is just a re-submit and add's Russ Weight's Reviewed-by.
This is intended to help kick test our CI as we explore some area of it.

 drivers/base/firmware_loader/main.c         | 2 +-
 drivers/base/firmware_loader/sysfs_upload.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
index 324a9a3c087a..1aa509756d3e 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -1528,7 +1528,7 @@ static void __device_uncache_fw_images(void)
  * device_cache_fw_images() - cache devices' firmware
  *
  * If one device called request_firmware or its nowait version
- * successfully before, the firmware names are recored into the
+ * successfully before, the firmware names are recorded into the
  * device's devres link list, so device_cache_fw_images can call
  * cache_firmware() to cache these firmwares for the device,
  * then the device driver can load its firmwares easily at
diff --git a/drivers/base/firmware_loader/sysfs_upload.c b/drivers/base/firmware_loader/sysfs_upload.c
index 829270067d16..7a838b30d8eb 100644
--- a/drivers/base/firmware_loader/sysfs_upload.c
+++ b/drivers/base/firmware_loader/sysfs_upload.c
@@ -209,7 +209,7 @@ static void fw_upload_main(struct work_struct *work)
 	/*
 	 * Note: fwlp->remaining_size is left unmodified here to provide
 	 * additional information on errors. It will be reinitialized when
-	 * the next firmeware upload begins.
+	 * the next firmware upload begins.
 	 */
 	mutex_lock(&fw_lock);
 	fw_free_paged_buf(fw_sysfs->fw_priv);
-- 
2.45.2


