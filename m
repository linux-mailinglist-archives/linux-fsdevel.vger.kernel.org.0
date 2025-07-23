Return-Path: <linux-fsdevel+bounces-55823-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA2CB0F1CB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 14:02:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A865F7AE652
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 12:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D055527EFFA;
	Wed, 23 Jul 2025 12:02:02 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0AD24888C;
	Wed, 23 Jul 2025 12:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753272122; cv=none; b=ceQ/nILHfJQBtWi9TGWU1ZqTuJzywwfESPPG3ZmWw7STwsn+NjqpBKcWsuznmK+CGcd+Rw/eNmHo4CGjSV2diNunIOMZwVD3vxtjjBmOFTR+6ve+cubqS8ZSIiTuYTMq9wQYd3Y8yzRtpK9+RF7HUx8+ptBP8/Kuv26BVh5tyVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753272122; c=relaxed/simple;
	bh=PjryDDK5qPTp8dCMfOz6hzHAQURUAXKfBOOjhQl8K+Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PEq/GU14ftpEri1zw4r9/1JE184ejOByJD9/Cwzp72Y41QBwt4N40hIRLdzVrHUogVz4DkmPy9C2CiGXcNpHjuj/ReUWH+d9xbnRMxGce6eT1pv+3FADUVjcJYHK7LZ6/bNuCPEKkWAtYvV3r20KSlp2BTD7wH0tAGEmeUdNj5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4bnCQF4vJHztScj;
	Wed, 23 Jul 2025 20:00:53 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id AA1DD1401F3;
	Wed, 23 Jul 2025 20:01:57 +0800 (CST)
Received: from huawei.com (10.175.124.27) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 23 Jul
 2025 20:01:56 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <dhowells@redhat.com>, <pc@manguebit.org>, <brauner@kernel.org>
CC: <netfs@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <yuehaibing@huawei.com>
Subject: [PATCH -next] netfs: Remove unused declaration netfs_queue_write_request()
Date: Wed, 23 Jul 2025 20:23:29 +0800
Message-ID: <20250723122329.923223-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 dggpemf500002.china.huawei.com (7.185.36.57)

Commit c245868524cc ("netfs: Remove the old writeback code") removed
the implementation but leave declaration.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 include/linux/netfs.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index f43f075852c0..185bd8196503 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -442,7 +442,6 @@ size_t netfs_limit_iter(const struct iov_iter *iter, size_t start_offset,
 			size_t max_size, size_t max_segs);
 void netfs_prepare_write_failed(struct netfs_io_subrequest *subreq);
 void netfs_write_subrequest_terminated(void *_op, ssize_t transferred_or_error);
-void netfs_queue_write_request(struct netfs_io_subrequest *subreq);
 
 int netfs_start_io_read(struct inode *inode);
 void netfs_end_io_read(struct inode *inode);
-- 
2.34.1


