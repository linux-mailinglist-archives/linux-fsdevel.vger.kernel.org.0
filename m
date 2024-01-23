Return-Path: <linux-fsdevel+bounces-8503-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73542838500
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 03:38:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B89428BA4F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 02:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D2F67C085;
	Tue, 23 Jan 2024 02:06:37 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FD57A73E;
	Tue, 23 Jan 2024 02:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705975597; cv=none; b=Y4Dkq7ncpkzIQqti6mzW2wKuhM9Zn4tsmFw8yJuWi0xg9HPAw/Vcyh+3vrg5LrHpTsVFP9Ai0McRUQa6cINOk7Mc8rcdktaeD4cOtiewbKBucFqb04L7tITHcijKfZvLXc1ji1D5ZFdgtXmlZ1jIzl4768xm6ciQV2tEvTu33bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705975597; c=relaxed/simple;
	bh=OPMq39GkcKD7w9vnOus6OMUjCddgPvkIIND28U3QV5o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=X7FMAa+kGg4MESLHp5bu7WCh6Drqc4kLCXpYmyZymjT1nimknzX5ST7QjlkV+WXFo2Qd3yA9voupcTguqZVVszakEFbMrQHpOcH9I6Xh5vtWCVpsIiOkr1oNo0gmMETfpsB8alfTwPHoKzl0cHdkABIpkPqKCOi7wFVzpY5sobw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W.Aw0iP_1705975584;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0W.Aw0iP_1705975584)
          by smtp.aliyun-inc.com;
          Tue, 23 Jan 2024 10:06:30 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: dhowells@redhat.com
Cc: linux-cachefs@redhat.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] netfs, fscache: Remove duplicate include
Date: Tue, 23 Jan 2024 10:06:22 +0800
Message-Id: <20240123020622.83648-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

./fs/netfs/fscache_io.c: linux/uio.h is included more than once.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=8014
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 fs/netfs/fscache_io.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/netfs/fscache_io.c b/fs/netfs/fscache_io.c
index ad572f7ee897..3810e790485c 100644
--- a/fs/netfs/fscache_io.c
+++ b/fs/netfs/fscache_io.c
@@ -6,7 +6,6 @@
  */
 #define FSCACHE_DEBUG_LEVEL OPERATION
 #include <linux/fscache-cache.h>
-#include <linux/uio.h>
 #include <linux/bvec.h>
 #include <linux/slab.h>
 #include <linux/uio.h>
-- 
2.20.1.7.g153144c


