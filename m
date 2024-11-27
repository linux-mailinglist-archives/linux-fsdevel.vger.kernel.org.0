Return-Path: <linux-fsdevel+bounces-35945-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13CDD9DA039
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2024 02:20:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1554285146
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2024 01:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0698F4414;
	Wed, 27 Nov 2024 01:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0BuNviK9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AB5EC2
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Nov 2024 01:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732670418; cv=none; b=UBHr6CKHj7hYohotRRzeLHlgrNwm1FB7vU4OMwMBw82d1woq/ukXJvoZ+X2oPP8DgimZsD8PuezcjPlFLYOvnx+G+eh225+Ca6s3X3HYxWGWML8YiEjm/w1Kqe1ol4ayJeyQOf7hbSGzuStXvcPXrdTZU+Xa0ICMqvNeonw5Fl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732670418; c=relaxed/simple;
	bh=YWCUr70gn4t3OvMz06vS6CFhEI98E2b+ARswXMygY/o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J8L9PNzw/5FXzd0ffd7XIoevLhMso9HajUxXOCgOPyxgNHcdRWG2FtQ0nUxHAtUonhk2z6NkL924hILiyBOKnJ6cdWbIXdhhY4a29FKzQwPfU4zOVfBiPZCZVI1eanRdHdwduY9Y5slnNnaPjRJqf+zwhPqCCA5wX7loLEDpJqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=0BuNviK9; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=Iu7sBxv0Zu62SlLXv5TIMkzRXoU1QxfT3DXzntsJJ0U=; b=0BuNviK91Pu4LSXzzZFaxaf7zq
	Qk4caeVI8zj0LuktYfuuxebrqMrMFNbpUcU3M8G476Da2mH/8wRawF9UcLhK3wp2VpotkrunCBRvD
	Mscp+E6MsJvazASl1Kllkvryg/W92WHEn69U+Q8YR7J64D7CIUI63OoyerhU0+5nM7wJ+QI9A10oD
	KtW2gdnItGXV26hCaMjKw4Sgk2nNh8tPHGEXAyR5dKpyRfqNOugdOg0YPynDDjFqcxpkLUUNQXx6s
	/YlampcY9onR6oFywHl0yPJhwGGuH0rpJaDtPCu7bKoV6+W5jwzPW93FAklSaY1wYdakVAeKeREXD
	v7dYPvQA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tG6j0-0000000C0D3-2ekx;
	Wed, 27 Nov 2024 01:20:14 +0000
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: gregkh@linuxfoundation.org,
	russ.weight@linux.dev,
	dakr@redhat.com
Cc: mcgrof@kernel.org,
	song@kernel.org,
	mricon@kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] firmware_loader: minor spelling fixes
Date: Tue, 26 Nov 2024 17:20:12 -0800
Message-ID: <20241127012012.2860726-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>

From: Luis Chamberlain <mcgrof@kernel.org>

Run codespell on the *.[ch] files for the firmware loader.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---

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


