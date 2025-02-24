Return-Path: <linux-fsdevel+bounces-42372-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 898E3A41299
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 02:25:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B887F172821
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 01:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C6038DE0;
	Mon, 24 Feb 2025 01:24:14 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2723081732;
	Mon, 24 Feb 2025 01:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740360254; cv=none; b=qHvijBCKJq0N7HUyI3428OE0q2M8XcglNc5B1PmIBLyjd+kg0Dfyh9GZ5B92FkdxaY9tFmVH6KqQ4euueSVOJMw+BCSwX3t7Z5Pl081J3Nnx0U7gv8UrCZ16QL4yM24YlpWLICCoMm1g0MB0UsjFqR7QLjXE8hiU6Q6+Gb63X18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740360254; c=relaxed/simple;
	bh=muEyjcQX89HxkIdlTEjavVGhd848csPb2p7ljgYJI1k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bztTaNndBXN32/nwqMeK5/DuixYmhUKQfFaixU0PXMoc70SQgOJYkBguxkwrIht2ft0nUCw/196Z0+aXsLBcKrkuWd0UtWBsghUfM/+uy9k21GaI+dz/1p4NLkKxll9EnCVG4EeD1aFWnXvFm3WlDfHQJpcIBzVeVvdJRNwkSyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Z1NGb72j9z21p0d;
	Mon, 24 Feb 2025 09:20:55 +0800 (CST)
Received: from kwepemf100017.china.huawei.com (unknown [7.202.181.16])
	by mail.maildlp.com (Postfix) with ESMTPS id 85E4C140368;
	Mon, 24 Feb 2025 09:23:59 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemf100017.china.huawei.com
 (7.202.181.16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 24 Feb
 2025 09:23:58 +0800
From: Zizhi Wo <wozizhi@huawei.com>
To: <linux-ext4@vger.kernel.org>, <jack@suse.com>, <tytso@mit.edu>
CC: <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<wozizhi@huawei.com>, <yangerkun@huawei.com>
Subject: [PATCH] ext4: Modify the comment about mb_optimize_scan
Date: Mon, 24 Feb 2025 09:20:05 +0800
Message-ID: <20250224012005.689549-1-wozizhi@huawei.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemf100017.china.huawei.com (7.202.181.16)

Commit 196e402adf2e ("ext4: improve cr 0 / cr 1 group scanning") introduces
the sysfs control interface "mb_max_linear_groups" to address the problem
that rotational devices performance degrades when the "mb_optimize_scan"
feature is enabled, which may result in distant block group allocation.

However, the name of the interface was incorrect in the comment to the
ext4/mballoc.c file, and this patch fixes it, without further changes.

Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
---
 fs/ext4/mballoc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index b25a27c86696..68b54afc78c7 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -187,7 +187,7 @@
  * /sys/fs/ext4/<partition>/mb_min_to_scan
  * /sys/fs/ext4/<partition>/mb_max_to_scan
  * /sys/fs/ext4/<partition>/mb_order2_req
- * /sys/fs/ext4/<partition>/mb_linear_limit
+ * /sys/fs/ext4/<partition>/mb_max_linear_groups
  *
  * The regular allocator uses buddy scan only if the request len is power of
  * 2 blocks and the order of allocation is >= sbi->s_mb_order2_reqs. The
@@ -209,7 +209,7 @@
  * get traversed linearly. That may result in subsequent allocations being not
  * close to each other. And so, the underlying device may get filled up in a
  * non-linear fashion. While that may not matter on non-rotational devices, for
- * rotational devices that may result in higher seek times. "mb_linear_limit"
+ * rotational devices that may result in higher seek times. "mb_max_linear_groups"
  * tells mballoc how many groups mballoc should search linearly before
  * performing consulting above data structures for more efficient lookups. For
  * non rotational devices, this value defaults to 0 and for rotational devices
-- 
2.39.2


