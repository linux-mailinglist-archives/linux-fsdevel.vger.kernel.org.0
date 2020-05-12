Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C12ED1CFD1C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 May 2020 20:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730712AbgELSTp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 May 2020 14:19:45 -0400
Received: from mailrelay115.isp.belgacom.be ([195.238.20.142]:26711 "EHLO
        mailrelay115.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726300AbgELSTo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 May 2020 14:19:44 -0400
IronPort-SDR: +0kegYNzNUyQzv2uQu8pKdpA2imwc+KEVKzVpe9RcC70/rA29hfsA5Dv1ufFvfedozFk6W7NIN
 gr/BfhO/6n9KV7yWiVfGhByI4teZPzihz2OQ2jMOKDTPRbh5RS/OGEn5Ik6KOu/bWgfXVwwEhx
 WqdwACaKb7n9AW5UXRY7DtFeEy76+5j6KxzhtLhIVECVJxnMFRhSTGX5dkjw9+3bhMtf375w+i
 o7mypJxRHLh46/kwPD9E5ztxZwAT9Fex1C3yU1A7RfBiFGfJ6tLD819vrXYK6D/YscOYOQc8D9
 J3Q=
X-Belgacom-Dynamic: yes
IronPort-PHdr: =?us-ascii?q?9a23=3AN/WlexcXzUccqDqEwKMKjl/xlGMj4u6mDksu8p?=
 =?us-ascii?q?Mizoh2WeGdxcW+bB7h7PlgxGXEQZ/co6odzbaP7uaxAydZuMfJmUtBWaQEbw?=
 =?us-ascii?q?UCh8QSkl5oK+++Imq/EsTXaTcnFt9JTl5v8iLzG0FUHMHjew+a+SXqvnYdFR?=
 =?us-ascii?q?rlKAV6OPn+FJLMgMSrzeCy/IDYbxlViDanbr5+MRW7oR/Vu8UIjoduN7s9xx?=
 =?us-ascii?q?/UqXZUZupawn9lK0iOlBjm/Mew+5Bj8yVUu/0/8sNLTLv3caclQ7FGFToqK2?=
 =?us-ascii?q?866tHluhnFVguP+2ATUn4KnRpSAgjK9w/1U5HsuSbnrOV92S2aPcrrTbAoXD?=
 =?us-ascii?q?mp8qlmRAP0hCoBKjU09nzchM5tg6JBuB+vpwJxzZPabo+WM/RxcazTcMgGSW?=
 =?us-ascii?q?dCRMtdSzZMDp+gY4YJEuEPPfxYr474p1YWrRWxHxKjBOL1xT9Om3T43bc63P?=
 =?us-ascii?q?o8Hg7YxgwgHs4BsHfJp9jyOqcdS/u6zKfTwDXYbPNX2TH955bUchw7uv6DQ6?=
 =?us-ascii?q?t9fMzMwkYgCw3LlE+fqZD5PzyLzOQNtXCW4eRjWO+ri2AqqgF8riahy8ksl4?=
 =?us-ascii?q?TFmp8ZxkzF+Ct2z4g4ONO1RVBmbNOkEpZdqS6UO5d4TM0tR2xmuCY0xqMCtJ?=
 =?us-ascii?q?O9YSMEy4wnygbbZvCaaYSE/xHuWPiLLTtlhX9oeKiziwuz/EWm1+byTNO70E?=
 =?us-ascii?q?xQoSpAitTMs3cN2AHN5cWfUft9+1uh2S6I1wDO9uFIOUA0mrTfK54m2rM/jZ?=
 =?us-ascii?q?sTsUvMHi/rg0X2l6iWdkE5+uiz8ejnYrLmppqCOINsiwH+NLohmtCnDOk8Lw?=
 =?us-ascii?q?QCRXWX9Oei2LH54EH0QbVHgucrnqTYqJzaIN4Upq+9Aw9byIYj7BO/Ai+o0N?=
 =?us-ascii?q?sChnYHIklIeAmEj4npPVHBPuz4Ae2kjFuyiDtr3ezJPqX9ApXRKXjOiLXhcq?=
 =?us-ascii?q?xh5E5f0wcz1s1f54lKBb0bPP3yW1f7tMbEAR8hLwy03+HnBc1n2YMbWGKPGK?=
 =?us-ascii?q?2UPa3TsV+M/e8vLOyMa5UUuDb5MfQq+/nujXohk18HYaapxYcXaGy/Hvl+J0?=
 =?us-ascii?q?WZYHzsgsoOEGsTsAo+V/Hlh0OcUTFNY3a/RLw85j4lB4K8F4vDRZ6igKaH3C?=
 =?us-ascii?q?ilGp1afGdGCkqDEX3wbYWLR+8MaD6OIs9mijEEW6KuRJQv1Ry1rw/6yLpmLu?=
 =?us-ascii?q?zK9S0Er57sz8Z6tKXvkkQw/Dd3J9+AyGzLRHMw1moNRiVph6F7iUN4w1aHl6?=
 =?us-ascii?q?N/hq92D9tWst1AWAYzM9by1eF2BsrzUQGJKtmAQliOWda3BzwtCNg8lYxdK3?=
 =?us-ascii?q?1hEsmv20iQlxGhBKUYwuSG?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2BKBwB56Lpe/xCltltmhHqBZBIsjSW?=
 =?us-ascii?q?FfowYkVgLAQEBAQEBAQEBNAECBAEBhESCBCc4EwIDAQEBAwIFAQEGAQEBAQE?=
 =?us-ascii?q?BBAQBbAQBAQcKAgGETiEBAwEBBQoBQ4I7IoNCCwEjI09wEoMmglgpsUAzhVG?=
 =?us-ascii?q?DUYFAgTiHXYUBgUE/hF+KQgSya4JUgnGVKwwdnTqQHZ87IoFWTSAYgyRQGA2?=
 =?us-ascii?q?fCkIwNwIGCAEBAwlXASIBjggBAQ?=
X-IPAS-Result: =?us-ascii?q?A2BKBwB56Lpe/xCltltmhHqBZBIsjSWFfowYkVgLAQEBA?=
 =?us-ascii?q?QEBAQEBNAECBAEBhESCBCc4EwIDAQEBAwIFAQEGAQEBAQEBBAQBbAQBAQcKA?=
 =?us-ascii?q?gGETiEBAwEBBQoBQ4I7IoNCCwEjI09wEoMmglgpsUAzhVGDUYFAgTiHXYUBg?=
 =?us-ascii?q?UE/hF+KQgSya4JUgnGVKwwdnTqQHZ87IoFWTSAYgyRQGA2fCkIwNwIGCAEBA?=
 =?us-ascii?q?wlXASIBjggBAQ?=
Received: from 16.165-182-91.adsl-dyn.isp.belgacom.be (HELO biggussolus.home) ([91.182.165.16])
  by relay.skynet.be with ESMTP; 12 May 2020 20:19:39 +0200
From:   Fabian Frederick <fabf@skynet.be>
To:     jack@suse.cz, amir73il@gmail.com
Cc:     linux-fsdevel@vger.kernel.org, Fabian Frederick <fabf@skynet.be>
Subject: [PATCH V2 6/6 linux-next] fanotify: don't write with size under sizeof(response)
Date:   Tue, 12 May 2020 20:19:21 +0200
Message-Id: <20200512181921.405973-1-fabf@skynet.be>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

fanotify_write() only aligned copy_from_user size to sizeof(response)
for higher values. This patch avoids all values below as suggested
by Amir Goldstein and set to response size unconditionally.

Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
V2: don't write with size under sizeof(response), not only 0

 fs/notify/fanotify/fanotify_user.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 02a314acc757..63b5dffdca9e 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -487,8 +487,10 @@ static ssize_t fanotify_write(struct file *file, const char __user *buf, size_t
 
 	group = file->private_data;
 
-	if (count > sizeof(response))
-		count = sizeof(response);
+	if (count < sizeof(response))
+		return -EINVAL;
+
+	count = sizeof(response);
 
 	pr_debug("%s: group=%p count=%zu\n", __func__, group, count);
 
-- 
2.26.2

