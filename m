Return-Path: <linux-fsdevel+bounces-10410-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD7784ABBF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 02:44:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FAF21C235CD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 01:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0AA15C0;
	Tue,  6 Feb 2024 01:44:14 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4E31373
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Feb 2024 01:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707183854; cv=none; b=jRpCioe9x7xobbS1VvW5Onudq7JaHMOIXajU9hOP4v5VMwXff1faVJwyokPGm20W3tyjrPgCLlOOE/Bv++C4IbERzrL8v2gY1g2gRsERAtxjrRZcKB1DC9/kogmMo4VJZqFiwVDm8Eps0P+8xNAhqMT13rITbLKnNvtzPN81dZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707183854; c=relaxed/simple;
	bh=f36y5nrtN6YokISYgJlldjZLZLXxYY35d5sKh4DpgvE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=b5dPghn01u7hzd4VO6b0CrKfzo0d6dS59Qbhccsz2iVe7J0MO/AVdxnFDzxsm9AAWcZszAtR7liF6eaBnRaCh5OISwF7uysStlDOdK7UdzyaNaHcexHr/EAEPqorNeu2U/aYKuZagcn7iOLt2o5dazwOY2PqF34u+9dMqRGW6YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4TTQwN6bJ0z29l5L;
	Tue,  6 Feb 2024 09:42:12 +0800 (CST)
Received: from dggpemm500021.china.huawei.com (unknown [7.185.36.109])
	by mail.maildlp.com (Postfix) with ESMTPS id 5327C1A0172;
	Tue,  6 Feb 2024 09:44:08 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemm500021.china.huawei.com
 (7.185.36.109) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 6 Feb
 2024 09:44:08 +0800
From: Huang Xiaojia <huangxiaojia2@huawei.com>
To: <viro@zeniv.linux.org.uk>, <brauner@kernel.org>, <jack@suse.cz>,
	<yuehaibing@huawei.com>, <linux-fsdevel@vger.kernel.org>
CC: <huangxiaojia2@huawei.com>
Subject: [PATCH-next] epoll: Remove ep_scan_ready_list() in comments
Date: Tue, 6 Feb 2024 09:43:53 +0800
Message-ID: <20240206014353.4191262-1-huangxiaojia2@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500021.china.huawei.com (7.185.36.109)

Since commit 443f1a042233 ("lift the calls of ep_send_events_proc()
into the callers"), ep_scan_ready_list() has been removed.
But there are still several in comments. All of them should
be replaced with other caller functions.

Signed-off-by: Huang Xiaojia <huangxiaojia2@huawei.com>
---
 fs/eventpoll.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 3534d36a1474..786e023a48b2 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -206,7 +206,7 @@ struct eventpoll {
 	 */
 	struct epitem *ovflist;
 
-	/* wakeup_source used when ep_scan_ready_list is running */
+	/* wakeup_source used when ep_send_events or __ep_eventpoll_poll is running */
 	struct wakeup_source *ws;
 
 	/* The user that created the eventpoll descriptor */
@@ -1153,7 +1153,7 @@ static inline bool chain_epi_lockless(struct epitem *epi)
  * This callback takes a read lock in order not to contend with concurrent
  * events from another file descriptor, thus all modifications to ->rdllist
  * or ->ovflist are lockless.  Read lock is paired with the write lock from
- * ep_scan_ready_list(), which stops all list modifications and guarantees
+ * ep_start/done_scan(), which stops all list modifications and guarantees
  * that lists state is seen correctly.
  *
  * Another thing worth to mention is that ep_poll_callback() can be called
@@ -1751,7 +1751,7 @@ static int ep_send_events(struct eventpoll *ep,
 			 * availability. At this point, no one can insert
 			 * into ep->rdllist besides us. The epoll_ctl()
 			 * callers are locked out by
-			 * ep_scan_ready_list() holding "mtx" and the
+			 * ep_send_events() holding "mtx" and the
 			 * poll callback will queue them in ep->ovflist.
 			 */
 			list_add_tail(&epi->rdllink, &ep->rdllist);
@@ -1904,7 +1904,7 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
 		__set_current_state(TASK_INTERRUPTIBLE);
 
 		/*
-		 * Do the final check under the lock. ep_scan_ready_list()
+		 * Do the final check under the lock. ep_start/done_scan()
 		 * plays with two lists (->rdllist and ->ovflist) and there
 		 * is always a race when both lists are empty for short
 		 * period of time although events are pending, so lock is
-- 
2.34.1


