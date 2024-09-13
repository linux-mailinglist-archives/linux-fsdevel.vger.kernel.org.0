Return-Path: <linux-fsdevel+bounces-29270-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F1A977646
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 03:10:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A034B1C240B2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 01:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2A63FE4;
	Fri, 13 Sep 2024 01:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="dBGJ8TSo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF146FB0;
	Fri, 13 Sep 2024 01:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726189818; cv=none; b=H1ZvkbWMMD2DvzGFhYts+Fjp2xAb6KmN6E/4+KF2hyRJ4ZsnaRzKq/t65evL/umlvpRu0//QZMI2yC/mQgDI4XRGYfqyDoYdZwuXTSvPdRlrk5Yw6jgBqgxRC7Mhv+eMdAVjrO6/9m5aTni/YLOgHPjqf8kys5a8Z1/34r7wzE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726189818; c=relaxed/simple;
	bh=XBgrpuoq4hRtz86vdXl0c4EV9l90zxrAxQaCSeOvMhU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UF+WxtzjhvPBKaWhyOvHwgydFKx5QVI7aJUSyaV9MQOTnBuzTIccx6SECsKwHM5+b0eccmRM2wEYVhCxj1j95pEpYwUcicGC7UQEAfgbglNlGYsulw2muLGsS9vGZHSZkQUW8QJLwUNcILsx5J1t0Rbln+cfz2czYCzxxfCb8bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=dBGJ8TSo; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1726189812; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=Mw+/81krP88Ksmnw+O1cYqT1saIevh6obb5Szk1gZuE=;
	b=dBGJ8TSoiFiRgCfvYFOKszmMZCVUCjx4DfM6S6ttT6qqcJE+wPH2UxuaGd9rFTvjGhulNjadAxZ5Qn2S455V8Mmnh5WRNIeW7Uta+Z2LBh9AnxwRyFEZkWm0OoJhMKsWkxWs/d8JPrIEHbOmlVXD8hN/BhjD7f+pA9RnvzFFs3Q=
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0WEslOoF_1726189805)
          by smtp.aliyun-inc.com;
          Fri, 13 Sep 2024 09:10:12 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: viro@zeniv.linux.org.uk
Cc: brauner@kernel.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] fs/inode: Modify mismatched function name
Date: Fri, 13 Sep 2024 09:10:04 +0800
Message-Id: <20240913011004.128859-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No functional modification involved.

fs/inode.c:242: warning: expecting prototype for inode_init_always(). Prototype was for inode_init_always_gfp() instead.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=10845
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 fs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/inode.c b/fs/inode.c
index c391365cdfa7..6763900a7a87 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -229,7 +229,7 @@ static int no_open(struct inode *inode, struct file *file)
 }
 
 /**
- * inode_init_always - perform inode structure initialisation
+ * inode_init_always_gfp - perform inode structure initialisation
  * @sb: superblock inode belongs to
  * @inode: inode to initialise
  * @gfp: allocation flags
-- 
2.32.0.3.g01195cf9f


