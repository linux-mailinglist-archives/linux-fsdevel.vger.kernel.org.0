Return-Path: <linux-fsdevel+bounces-46493-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B3AA8A3F9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 18:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7EE34431B1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 16:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97EDE20E003;
	Tue, 15 Apr 2025 16:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0WWg247R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795682101AE;
	Tue, 15 Apr 2025 16:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744734155; cv=none; b=Cs5rvbXQt8Kfeeb2jO4Ac0W3ld3EVVgojelV6jejKVuo1vW6UZfPY0oQyodb3koQwHtDqFFmM7sPuiSYoTdSDUpESTRRkvJoMxyHyl10X5sDqA9bAaODdLv6mDlToqW49Y7MlQytqnbDHzjsx0eWOrL9/LeYlpbag5zxMufuQtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744734155; c=relaxed/simple;
	bh=dSOzhLNZCNfgSYqLgagLCyKJ24mlO6SZsyWMt0ky9xI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p5GO4ZALMI+XWZg/fZzPTOMDBToUawNhb4UZYt2xUzz/QwVL7vZEEngON/MUkjYIQXvQgj2chkYRDpxcoO1hgV3zdKqEL1InYkiNTLltTMCl4voagXpLmS72GGGO0UYYV8ZQN6SPNZLMPuUkWfj44h0akm/0Jd6Brk496IOXvQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=0WWg247R; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=9x1v+BBFhbVi5I2LQrtKunknx2YPxRIdHvTS6ZXONRM=; b=0WWg247RbxEKXNjMRy5sGTg8oA
	QharRxFrgAWLqLEaBUVg4eEiUNtpy7Vl760Pp/hvijdzvgaPz3xwYNnuQL2LFdkT3+taW6X2ncw2A
	PzvzSpvlLLo2NbvuDtJk+yoMUg7v1vS7Q47PXu5CXf7zr10+Gnn7PDd+x0hZJ9JbDWxpP64cNMMyy
	vwnLYdJUHYUNhiAcRoZDdT6W6uJFIqqvXjWOCJUuehiVAFbnZ75k5SzcDL/HKGEximVnpXeob+FdO
	ZPYYySjnKAxu7a6JBgUV8T4cEa9lvy3qUhQqKdVngZq5J5XDlFjIXg8k6+KIt2evashlB3C8SyIm2
	/y9Qz44Q==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4j3Q-00000006Olp-2WJY;
	Tue, 15 Apr 2025 16:22:32 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: gregkh@linuxfoundation.org,
	russ.weight@linux.dev,
	dakr@redhat.com
Cc: mcgrof@kernel.org,
	song@kernel.org,
	mricon@kernel.org,
	kdevops@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v3] firmware_loader: minor spelling fixes
Date: Tue, 15 Apr 2025 09:22:31 -0700
Message-ID: <20250415162231.1525179-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.49.0
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

This is intended to kick off kpd lei based patchwork workflow we've been
trying to debug an issue with kpd.

 drivers/base/firmware_loader/main.c         | 2 +-
 drivers/base/firmware_loader/sysfs_upload.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
index cb0912ea3e62..26f07d3ed107 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -1527,7 +1527,7 @@ static void __device_uncache_fw_images(void)
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
2.47.2


