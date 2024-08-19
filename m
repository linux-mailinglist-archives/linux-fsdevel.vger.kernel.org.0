Return-Path: <linux-fsdevel+bounces-26270-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A28956CC3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 16:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0B752811E8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 14:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D3516CD18;
	Mon, 19 Aug 2024 14:10:58 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC2616CD0D;
	Mon, 19 Aug 2024 14:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724076658; cv=none; b=O90WhgExjK67tqayTT8jXJCGMPJ6azhdvYWzJ7Wgh9OTC3s17NOfWvuKj2S0oJO7Nn0CpLlQw99kP0o+lI4lE2EKM6smtTBh5IOSwYSO9HTW2Yu7MqFa5yF6OWV775jLOOIsBrGvTouKWMmywDWWGq4dtbM9808l2+beIX7QW2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724076658; c=relaxed/simple;
	bh=AT80N4kX0Weit1QCb6vW/2az1vWcL8RNu9TsMON4QT4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DqwMsifQ9ainONFvtcYxZxX7N26HyldCsUM2HG84MU+6zZ4eggmmhQd12Ux6rqUtfdKirMGVWVMYkDDzhieAdOqr0lx7Uquw0SSRo7w3Ueu9g30aMPcBm4nBxzBGpZpNBAXAxD3c9UFvBLyuNBSl7z7MTGzm08fwmWSVEPfMv7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WnZBr5kJ6z20m7R;
	Mon, 19 Aug 2024 22:06:12 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 69D5318001B;
	Mon, 19 Aug 2024 22:10:52 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 19 Aug
 2024 22:10:51 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <dhowells@redhat.com>, <jlayton@kernel.org>
CC: <netfs@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <yuehaibing@huawei.com>
Subject: [PATCH -next] netfs: Remove unused declaration netfs_queue_write_request()
Date: Mon, 19 Aug 2024 21:52:59 +0800
Message-ID: <20240819135259.120068-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemf500002.china.huawei.com (7.185.36.57)

Commit c245868524cc ("netfs: Remove the old writeback code")
removed the implementation but leave declaration.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 include/linux/netfs.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 983816608f15..712c34f6c332 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -434,7 +434,6 @@ size_t netfs_limit_iter(const struct iov_iter *iter, size_t start_offset,
 void netfs_prepare_write_failed(struct netfs_io_subrequest *subreq);
 void netfs_write_subrequest_terminated(void *_op, ssize_t transferred_or_error,
 				       bool was_async);
-void netfs_queue_write_request(struct netfs_io_subrequest *subreq);
 
 int netfs_start_io_read(struct inode *inode);
 void netfs_end_io_read(struct inode *inode);
-- 
2.34.1


