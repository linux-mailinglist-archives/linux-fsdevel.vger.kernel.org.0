Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8A831CFD07
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 May 2020 20:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730935AbgELSRX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 May 2020 14:17:23 -0400
Received: from mailrelay115.isp.belgacom.be ([195.238.20.142]:26516 "EHLO
        mailrelay115.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730934AbgELSRW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 May 2020 14:17:22 -0400
IronPort-SDR: XLHJZvM85Y/wWWMS7jaUJTRfDk22UeI837iQWRFiJcqOKMtbLpNxeYLeWrBcfgDNaiu1oQ9zt9
 24URL+D94do0dp09BFLY4GStmlcolJeIHjAeGD1hmax34ywUH5J4X5MFYo25vpBBVmdYcMiyxH
 DqA8HW85HIFMaVmbo+FNj7C334Dtf0s/uZadXVYpczgxm3V6mnPCGVBWHtNOYqiYgUMfLQNLCf
 xNuV5+JU0hxmRg1XLQRPzC4oYUBHjLyNONfkl5gsg0C6cNpLyJ/Kbo0u66pPtm7+tPp3Owj32I
 4UE=
X-Belgacom-Dynamic: yes
IronPort-PHdr: =?us-ascii?q?9a23=3AYD34xhc0ze1hIeaccVIMT+EBlGMj4u6mDksu8p?=
 =?us-ascii?q?Mizoh2WeGdxcW+bB7h7PlgxGXEQZ/co6odzbaP7uaxAydZuMbJmUtBWaQEbw?=
 =?us-ascii?q?UCh8QSkl5oK+++Imq/EsTXaTcnFt9JTl5v8iLzG0FUHMHjew+a+SXqvnYdFR?=
 =?us-ascii?q?rlKAV6OPn+FJLMgMSrzeCy/IDYbxlViDanbr5+MRW7oR/Vu8UIjoduN7s9xx?=
 =?us-ascii?q?jUqXZUZupawn9lK0iOlBjm/Mew+5Bj8yVUu/0/8sNLTLv3caclQ7FGFToqK2?=
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
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2BnFQAE57pe/xCltltmglKBey2BZBI?=
 =?us-ascii?q?sjSWFfIwYj16BegsBAQEBAQEBAQE0AQIEAQGERIIEJzoEDQIDAQEBAwIFAQE?=
 =?us-ascii?q?GAQEBAQEBBAQBbAQBAQcKAgGETiEBAwEBBQoBCwgwgjsig0ILASMjT3ASglt?=
 =?us-ascii?q?LglgpsT0zhVGDV4FAgTiHXYUBgUE/hF+KQgSYEJpbglSCcZUrDB2dOi2PcJ8?=
 =?us-ascii?q?+BhmBVk0gGDuCaVAYDYlElUZCMDcCBggBAQMJVwEiAY4IAQE?=
X-IPAS-Result: =?us-ascii?q?A2BnFQAE57pe/xCltltmglKBey2BZBIsjSWFfIwYj16Be?=
 =?us-ascii?q?gsBAQEBAQEBAQE0AQIEAQGERIIEJzoEDQIDAQEBAwIFAQEGAQEBAQEBBAQBb?=
 =?us-ascii?q?AQBAQcKAgGETiEBAwEBBQoBCwgwgjsig0ILASMjT3ASgltLglgpsT0zhVGDV?=
 =?us-ascii?q?4FAgTiHXYUBgUE/hF+KQgSYEJpbglSCcZUrDB2dOi2PcJ8+BhmBVk0gGDuCa?=
 =?us-ascii?q?VAYDYlElUZCMDcCBggBAQMJVwEiAY4IAQE?=
Received: from 16.165-182-91.adsl-dyn.isp.belgacom.be (HELO biggussolus.home) ([91.182.165.16])
  by relay.skynet.be with ESMTP; 12 May 2020 20:17:20 +0200
From:   Fabian Frederick <fabf@skynet.be>
To:     jack@suse.cz, amir73il@gmail.com
Cc:     linux-fsdevel@vger.kernel.org, Fabian Frederick <fabf@skynet.be>
Subject: [PATCH V2 1/6 linux-next] fanotify: prefix should_merge()
Date:   Tue, 12 May 2020 20:17:15 +0200
Message-Id: <20200512181715.405728-1-fabf@skynet.be>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

prefix function with fanotify_ like others

Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 fs/notify/fanotify/fanotify.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 5435a40f82be..95480d3dcff7 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -70,7 +70,7 @@ static bool fanotify_name_event_equal(struct fanotify_name_event *fne1,
 	return !memcmp(fne1->name, fne2->name, fne1->name_len);
 }
 
-static bool should_merge(struct fsnotify_event *old_fsn,
+static bool fanotify_should_merge(struct fsnotify_event *old_fsn,
 			 struct fsnotify_event *new_fsn)
 {
 	struct fanotify_event *old, *new;
@@ -129,7 +129,7 @@ static int fanotify_merge(struct list_head *list, struct fsnotify_event *event)
 		return 0;
 
 	list_for_each_entry_reverse(test_event, list, list) {
-		if (should_merge(test_event, event)) {
+		if (fanotify_should_merge(test_event, event)) {
 			FANOTIFY_E(test_event)->mask |= new->mask;
 			return 1;
 		}
-- 
2.26.2

