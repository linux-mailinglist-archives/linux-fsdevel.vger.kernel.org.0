Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B75F511493
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Apr 2022 11:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbiD0Jk3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Apr 2022 05:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiD0Jk1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Apr 2022 05:40:27 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2081.outbound.protection.outlook.com [40.92.99.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7814332BCF1;
        Wed, 27 Apr 2022 02:36:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I2J3mR8d7sWLjO95c1Tpb82+Brlq3ONFZaAYmqLzVWs1GaYOSCq7WvGWtbVTnFnfJcv6JXpg+wcHUsH5pZ16YBD0wCJhDv7L6DjTWa9aj6YDuwQEJQ/JMxg1xspJzVO0Nh3SubVl3wq6QjyiqsQ/eAI8CyIZ8RgV25k4uo6L2CNGsa0mIZ0LKfmUiWMY8vOPJT+Gm9mKCeMdHNuWOuk9eA66KIQjIn8tkS9vL6Y2UxxtOIUkAdblXSmdaJ7GguWtyNXeJ7UEyMbCcfcFMZYt0S3j2cgZEkgl7+A7chL0uTmKg/bV4+/2suO6p7DPxhd1PBzr+DrBA9ENuts4TXFc+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rGR6+NgsNpXIWjEwY9hs+rTt5kII+sa1gLwGI9mLJ0M=;
 b=nNAFfmCX+SC4jWkh7OWJI5MMf72U2pipUwIDbknGA+BJszkj3ekLkKfuVWfi+XZKe7vZ2+s4p8Huym/PatbxhPHSdB6dNeQw9GqV20QPC9gGCj8hY4CoORM1/6yQW1uKhAyoT68BXgPKRN5s4wjDhW1gkCo8qjaos2eY1jb1oP68R/n3xg2bwCt9Ko7ARD8qYBoMjGr2+y5QEGlRenKnNP/kUy2SroyQoOqou16c3koro2r+Q2Ziv1r8+8TIR9CNKSwiq8RGe+XrjDZVT54J1j0AyLhNOycDx1pUSo3alfpj0WSIAxzO9TNCZqu34eHIrtteLHka9zfEMrkMxPs3TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rGR6+NgsNpXIWjEwY9hs+rTt5kII+sa1gLwGI9mLJ0M=;
 b=WrKj4mt7o3j7mocAOJ/lVWfsPJpizuJKJn7LJvUXSu4Q2Hj4kdd/2Nd0cRdBT7XyScgk+NKLY4sqEzy+oKDuSRQ9NcfCRY5D/mik6pz1djTP7R6Jgb0Z9RVYDm8aE5yfcXYjBpA01xbY4Qv3gC+7Prp7l72vLT42x4wGkmT1fI+jC8Aahac0/QWeiqkyR2j8G8S9mW/idM9k3s63mthNpPUcw5LGvmQSBGRYJWa+vkzVK8Fj1d6Cn5klYlHQCzanIydHHnuZd5ByQC+2AoifaNB1UjaK3P3BehGVZZjwxpnWf9wFhKAYa1dUAWdiTvapNs8EXvLGKBYVZcr7YFeGsQ==
Received: from TYYP286MB1115.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:ce::9) by
 OS3P286MB1057.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:10f::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.14; Wed, 27 Apr 2022 09:33:01 +0000
Received: from TYYP286MB1115.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ed8c:9e75:ddab:8c5e]) by TYYP286MB1115.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ed8c:9e75:ddab:8c5e%4]) with mapi id 15.20.5186.021; Wed, 27 Apr 2022
 09:33:01 +0000
From:   Xie Yongmei <yongmeixie@hotmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Cc:     yongmeixie@hotmail.comc, Xie Yongmei <yongmeixie@hotmail.com>
Subject: [PATCH 3/3] writeback: specify writeback period and expire interval per memcg
Date:   Wed, 27 Apr 2022 05:32:41 -0400
Message-ID: <TYYP286MB1115331A1F4852D7CA3E86A2C5FA9@TYYP286MB1115.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220427093241.108281-1-yongmeixie@hotmail.com>
References: <20220427093241.108281-1-yongmeixie@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [XbBKjZKgJ/uPV0EtxqE/Feo+t1tbxwHe]
X-ClientProxiedBy: HK0PR01CA0067.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::31) To TYYP286MB1115.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:ce::9)
X-Microsoft-Original-Message-ID: <20220427093241.108281-4-yongmeixie@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 974a3c04-51bb-4c67-f184-08da2830ebef
X-MS-Exchange-SLBlob-MailProps: Zv/SX2iM+5XXEEEdR/xMXhNCeF/y1+93HUjrN3m8MDCUewaI1nR/wSpNIuOIuWJzda/Pjr8Q7LMUGAFZf0frLZogWCQ9BY6YTIMtEPWm6ZbPnAqMV3jQ9Qa8J8MiiU0HlP2sNpaoBFWmF/M0BJhIeKkBzpxCSWlETieosOVhPZF7/mgnV1k0KGoXL62N9wBMFPQffkwXiRMCQk+HHIpH33Ee58kIdF7b0GlIS9mJxinW8oRxZ25FODJlHYgXKVs0EnKMr5S55OXW0zgVUkKVWRrTxCqg+cLjjbH1ViBKgfZLIKJX/am0TYN+OaXNnA9rhI3VRBxhXHhg+V3rrUNS1/qlcUDJcEkoBOV31zMfxvb/G77wwb4ye5usXRmBm1w86MYdWkx9H7naMYPDez872ZDZJC1xUN6FgJFOyQS5+GBt0wQsfIUt9qn1Jm+w2nhZIkWA8flHkz884zWlYdBXhzXHXPeKVJmir6FOpM5wkDSNj2Fuh86N5pvX13jA/J2NqLhROt5VrcGnq5h7IMdXzb3tdVp2RVmhccnjdNgXiqEjOU1PVsmO8Il3WeugD3d6ra21ypzd9RQxs1PD2eNvMWbzBR8HZhIluBQTW5eFuGKkI7n2yowvigy8kzJ7ZhO2Ko9nn+87FlO3O6YOaDPX7W10vWJMsRtz1OdrfMma+I8g9R5gSwM9M9QGQmdVS6cJYLu2bGZNxo4=
X-MS-TrafficTypeDiagnostic: OS3P286MB1057:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iO5u6YuWYb/R8PJf91wLiHCKPY7pGEMs6DahvS/9awUvcHe33x0/AjAXfWJo2ZqkEhL6D6dU/Kaha3a4KVmA06YXdINlBeFjs2zy/FqcWFMl89NxEOyQ+2wavY/t+2noNZPFMFBnqgi8M7B/XLcLnaregehr5t9NuXL5xW+rbRHxXnhXruIajOc0ZGTxIYD6ujhR8C4t+L8077yGZGmEAmuvgV+rlK01gvV2SY2IhNE/mc319Diy8yfakPRFBnJFOIGjNmDnk1aqDyGVj/xZupStfvxgDrBNhxWmBR3GuEseS4tqiRECve2UHSZUyqKq9A4/0y5iqnX6fkePYE0BNsxGgOprms7rtNsiF89NjSC13zuW+KLXb/DoT8g+6ngzkVyzNIuDHkMCeUbcmK6psn2zEi5r5kVxXJoVWVhePa2VONK2cSrEEOO2IUlOIlaZ5mz7bFEspibZrFiD3sd/co0KM9qzZYeDPT6hR79YxYXkDGFv6zBa+J9tk4bWfVTTfrL0DFt9BjUE7J3SjpqMEwzzSHQPimIugjfwdsuvIV6fxQu8cLnaO7eYovClfMKf44GZ91+xiTNuJyGHFo7REA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mmuDWfVau0H2Y0fYYbmM8KswuSTgsVi4FEdaQM6RfvxZuByCoNp8JZVyCNUj?=
 =?us-ascii?Q?5onMCW5jd7V3u0iVjYK2o+vXihk8FLp5KyZyCU3fwkYKv4cTShUsqus2kSLg?=
 =?us-ascii?Q?aehjaH6LIPewvb66H3ant2p1kbT0I9O2fW3x51/dTJWsJwgyou7QwI/q4l3R?=
 =?us-ascii?Q?g0lpPq0TmSxcHofq7yV8uOfZmYXnspZqyVNYJlDyUdYfFPBy3BOwNmyX9xoG?=
 =?us-ascii?Q?tdG3d6IEX2CLRZ7vK6vme/fXUzWZIu8TgyJO2ITMqPaFnSTfDkjG8+lJyLAw?=
 =?us-ascii?Q?fzoCqAfdGzZ4rMaOumAxBd9yfFYOfxRKMEvzDZFDiDHE223CU2x0QkqUS3oa?=
 =?us-ascii?Q?Anpkg1eNTSFaqnPvIhfSKO6nuGgQQac6tp+myBpeoTH3aTCXYHEvLYPs2Uub?=
 =?us-ascii?Q?u0ujQVCMg7VRceX5RlLwAb9aCHMB2RdGDSWFrg+1ZQtE2CRNrhs9pagrydpz?=
 =?us-ascii?Q?A1NhX9gnEs3MFZd7BKlSYpnkqdAOoxHiSdyVn88U65UD0J0WOAtFWpiASvgp?=
 =?us-ascii?Q?Lu8l+Q4axID9QbDl/XeJi235ggS/dYeHhw/RRH70Uem9WpqkgjM8edngcjy/?=
 =?us-ascii?Q?u40jXLIGqrjX+2LEFIR+CFqbeWs2JMXCBBxBguzBVjcq2EqIy6ynpU0xpkCh?=
 =?us-ascii?Q?zJmvIlVu6KhBvcKhS3BOJbQdYZyM85whq5aXt+cNik0ihcuZhDOKEPGfnjt/?=
 =?us-ascii?Q?nBlTs6WgaoWDZ31bb8wtWmGFFt90fUHmq4ZasIvLSWjLC+gmpYXp55QDtBzY?=
 =?us-ascii?Q?9fHxUwuuny6csOH6p9F49PmRRGAv3e0ULgX2xVLN5rpgE5M5qLaq8xGE1Qk3?=
 =?us-ascii?Q?CG+CviadJodUcg4xyKNwGKRUKEGeykHkxcMd1h9j3+EH2OlLpf6815vymVeJ?=
 =?us-ascii?Q?Cq9rFpkAmHIijo8yJ5BifGMVPT4glDzgaRNuyv3zEdW59HrjvMAtTCSFYKj4?=
 =?us-ascii?Q?KdpLV4sSxncM0WU+EUEni4rN84hPLPHJB/Js82Qfidlb3eV5SGA5ywot3H5q?=
 =?us-ascii?Q?vzBRxDdCap8BmfpWubZYR48BMb8KKoKkFW5Aro8eLos8FLObMqAhweBlztoK?=
 =?us-ascii?Q?ZuZ8HZbuWa2+2reUaeW7VRhaHloXOSG6gHhOegLIPBYQ/VB8Nky/8ydz4FaL?=
 =?us-ascii?Q?jH5Kk7wnHLMer0Ka0mZ3ibvivQVa0cWKQBamFdHPiad3xSQxeSlBES5kCvGw?=
 =?us-ascii?Q?CyJMG0QFAInejstroSQfqzjc9DETmDgOxOYna60uGE88deA7fsqRC2rjdwkC?=
 =?us-ascii?Q?pxJdklHzvFr6vt+ZucjEaNmSqdUEQ2ysNxzT0io/j30Nrf0OfuMBiwrB+AVP?=
 =?us-ascii?Q?gIuH+UGn1dHFfjlYX/KAFqRKUCoutLgmYwzXcwWUB8/Ga4+z4HKcu2TIM/jl?=
 =?us-ascii?Q?ejB6RWFzWsXjiBfq4FGedx4odbL3Tco4lFGE0G+jtdYybL6kp96vhfUObnpd?=
 =?us-ascii?Q?2UP/kuABmYs=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-05f45.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 974a3c04-51bb-4c67-f184-08da2830ebef
X-MS-Exchange-CrossTenant-AuthSource: TYYP286MB1115.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2022 09:33:01.1851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB1057
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

dirty_writeback_interval: dirty wakeup period
dirty_expire_interval: expire period

This patch provides per memcg setttings for writeback interval.

Dirty writeback could be triggered in the below ways:
  - mark_inode_dirty: when the first time of dirtying pages for this inode,
		it tries to wakeup the callback hook wb_workfn in
		wakeup period later.
  - wb_workfn: if there're more writeback works to do, it would wakeup the
		callback hook wb_workfn in another wakeup period later.
  - external event: kswad found dirty pages piled up at the end of inactive
		list or desktop mode timer.
  - buffered write context: balance_dirty_pages tries to wake up background
		writeback once dirty pages above freerun level of pages.
  - sync context: sync(fs sync) writeback immediately

No matter how writeback is triggered, wb_workfn is the unique callback hook
to manipulate the flushing things. Actually, wb_check_old_data_flush
handles the period writeback and decides the scope of dirty pages which
have to be written back because they were too old.

Signed-off-by: Xie Yongmei <yongmeixie@hotmail.com>
---
 fs/fs-writeback.c          |  11 ++--
 include/linux/memcontrol.h |  16 ++++++
 mm/backing-dev.c           |   4 +-
 mm/memcontrol.c            | 114 +++++++++++++++++++++++++++++++++++++
 4 files changed, 140 insertions(+), 5 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 591fe9cf1659..f59e4709ec39 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -1980,6 +1980,7 @@ static long wb_writeback(struct bdi_writeback *wb,
 	struct inode *inode;
 	long progress;
 	struct blk_plug plug;
+	unsigned int dirty_expire = wb_dirty_expire_interval(wb);
 
 	blk_start_plug(&plug);
 	spin_lock(&wb->list_lock);
@@ -2015,7 +2016,7 @@ static long wb_writeback(struct bdi_writeback *wb,
 		 */
 		if (work->for_kupdate) {
 			dirtied_before = jiffies -
-				msecs_to_jiffies(dirty_expire_interval * 10);
+				msecs_to_jiffies(dirty_expire * 10);
 		} else if (work->for_background)
 			dirtied_before = jiffies;
 
@@ -2101,15 +2102,16 @@ static long wb_check_old_data_flush(struct bdi_writeback *wb)
 {
 	unsigned long expired;
 	long nr_pages;
+	unsigned int writeback_interval = wb_dirty_writeback_interval(wb);
 
 	/*
 	 * When set to zero, disable periodic writeback
 	 */
-	if (!dirty_writeback_interval)
+	if (!writeback_interval)
 		return 0;
 
 	expired = wb->last_old_flush +
-			msecs_to_jiffies(dirty_writeback_interval * 10);
+			msecs_to_jiffies(writeback_interval * 10);
 	if (time_before(jiffies, expired))
 		return 0;
 
@@ -2194,6 +2196,7 @@ void wb_workfn(struct work_struct *work)
 	struct bdi_writeback *wb = container_of(to_delayed_work(work),
 						struct bdi_writeback, dwork);
 	long pages_written;
+	unsigned int writeback_interval = wb_dirty_writeback_interval(wb);
 
 	set_worker_desc("flush-%s", bdi_dev_name(wb->bdi));
 
@@ -2222,7 +2225,7 @@ void wb_workfn(struct work_struct *work)
 
 	if (!list_empty(&wb->work_list))
 		wb_wakeup(wb);
-	else if (wb_has_dirty_io(wb) && dirty_writeback_interval)
+	else if (wb_has_dirty_io(wb) && writeback_interval)
 		wb_wakeup_delayed(wb);
 }
 
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 386fc9b70c95..c1dc88bb8f80 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -347,6 +347,8 @@ struct mem_cgroup {
 #ifdef CONFIG_CGROUP_WRITEBACK_PARA
 	int dirty_background_ratio;
 	int dirty_ratio;
+	int dirty_writeback_interval;
+	int dirty_expire_interval;
 #endif
 
 	struct mem_cgroup_per_node *nodeinfo[];
@@ -1642,6 +1644,8 @@ static inline void mem_cgroup_flush_foreign(struct bdi_writeback *wb)
 #ifdef CONFIG_CGROUP_WRITEBACK_PARA
 unsigned int wb_dirty_background_ratio(struct bdi_writeback *wb);
 unsigned int wb_dirty_ratio(struct bdi_writeback *wb);
+unsigned int wb_dirty_writeback_interval(struct bdi_writeback *wb);
+unsigned int wb_dirty_expire_interval(struct bdi_writeback *wb);
 #else
 static inline
 unsigned int wb_dirty_background_ratio(struct bdi_writeback *wb)
@@ -1654,6 +1658,18 @@ unsigned int wb_dirty_ratio(struct bdi_writeback *wb)
 {
 	return vm_dirty_ratio;
 }
+
+static inline
+unsigned int wb_dirty_writeback_interval(struct bdi_writeback *wb)
+{
+	return dirty_writeback_interval;
+}
+
+static inline
+unsigned int wb_dirty_expire_interval(struct bdi_writeback *wb)
+{
+	return dirty_expire_interval;
+}
 #endif
 
 struct sock;
diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 7176af65b103..685558362ad8 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -15,6 +15,7 @@
 #include <linux/writeback.h>
 #include <linux/device.h>
 #include <trace/events/writeback.h>
+#include <linux/memcontrol.h>
 
 struct backing_dev_info noop_backing_dev_info;
 EXPORT_SYMBOL_GPL(noop_backing_dev_info);
@@ -264,8 +265,9 @@ subsys_initcall(default_bdi_init);
 void wb_wakeup_delayed(struct bdi_writeback *wb)
 {
 	unsigned long timeout;
+	unsigned int dirty_interval = wb_dirty_writeback_interval(wb);
 
-	timeout = msecs_to_jiffies(dirty_writeback_interval * 10);
+	timeout = msecs_to_jiffies(dirty_interval * 10);
 	spin_lock_bh(&wb->work_lock);
 	if (test_bit(WB_registered, &wb->state))
 		queue_delayed_work(bdi_wq, &wb->dwork, timeout);
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index b1c1b150637a..c392aec22e2e 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4851,17 +4851,49 @@ unsigned int wb_dirty_ratio(struct bdi_writeback *wb)
 	return memcg->dirty_ratio;
 }
 
+unsigned int wb_dirty_writeback_interval(struct bdi_writeback *wb)
+{
+	struct mem_cgroup *memcg;
+
+	if (mem_cgroup_disabled() || !wb)
+		return dirty_writeback_interval;
+
+	memcg = mem_cgroup_from_css(wb->memcg_css);
+	if (memcg == root_mem_cgroup || memcg->dirty_writeback_interval < 0)
+		return dirty_writeback_interval;
+
+	return memcg->dirty_writeback_interval;
+}
+
+unsigned int wb_dirty_expire_interval(struct bdi_writeback *wb)
+{
+	struct mem_cgroup *memcg;
+
+	if (mem_cgroup_disabled() || !wb)
+		return dirty_expire_interval;
+
+	memcg = mem_cgroup_from_css(wb->memcg_css);
+	if (memcg == root_mem_cgroup || memcg->dirty_expire_interval < 0)
+		return dirty_expire_interval;
+
+	return memcg->dirty_expire_interval;
+}
+
 static void wb_memcg_inherit_from_parent(struct mem_cgroup *parent,
 					 struct mem_cgroup *memcg)
 {
 	memcg->dirty_background_ratio = parent->dirty_background_ratio;
 	memcg->dirty_ratio = parent->dirty_ratio;
+	memcg->dirty_writeback_interval = parent->dirty_writeback_interval;
+	memcg->dirty_expire_interval = parent->dirty_expire_interval;
 }
 
 static void wb_memcg_init(struct mem_cgroup *memcg)
 {
 	memcg->dirty_background_ratio = -1;
 	memcg->dirty_ratio = -1;
+	memcg->dirty_writeback_interval = -1;
+	memcg->dirty_expire_interval = -1;
 }
 
 static int mem_cgroup_dirty_background_ratio_show(struct seq_file *m, void *v)
@@ -4918,6 +4950,64 @@ mem_cgroup_dirty_ratio_write(struct kernfs_open_file *of,
 	memcg->dirty_ratio = dirty_ratio;
 	return nbytes;
 }
+
+static int mem_cgroup_dirty_writeback_interval_show(struct seq_file *m, void *v)
+{
+	struct mem_cgroup *memcg = mem_cgroup_from_css(seq_css(m));
+
+	seq_printf(m, "%d\n", memcg->dirty_writeback_interval);
+	return 0;
+}
+
+static ssize_t
+mem_cgroup_dirty_writeback_interval_write(struct kernfs_open_file *of,
+					  char *buf, size_t nbytes,
+					  loff_t off)
+{
+	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
+	int ret, writeback_interval;
+
+	buf = strstrip(buf);
+	ret = kstrtoint(buf, 0, &writeback_interval);
+	if (ret)
+		return ret;
+
+	if (writeback_interval < -1)
+		return -EINVAL;
+
+	if (memcg->dirty_writeback_interval != writeback_interval) {
+		memcg->dirty_writeback_interval = writeback_interval;
+		wakeup_flusher_threads(WB_REASON_PERIODIC);
+	}
+	return nbytes;
+}
+
+static int mem_cgroup_dirty_expire_interval_show(struct seq_file *m, void *v)
+{
+	struct mem_cgroup *memcg = mem_cgroup_from_css(seq_css(m));
+
+	seq_printf(m, "%d\n", memcg->dirty_expire_interval);
+	return 0;
+}
+
+static ssize_t
+mem_cgroup_dirty_expire_interval_write(struct kernfs_open_file *of,
+				       char *buf, size_t nbytes, loff_t off)
+{
+	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
+	int ret, expire_interval;
+
+	buf = strstrip(buf);
+	ret = kstrtoint(buf, 0, &expire_interval);
+	if (ret)
+		return ret;
+
+	if (expire_interval < -1)
+		return -EINVAL;
+
+	memcg->dirty_expire_interval = expire_interval;
+	return nbytes;
+}
 #else
 static void wb_memcg_inherit_from_parent(struct mem_cgroup *parent,
 					 struct mem_cgroup *memcg)
@@ -5067,6 +5157,18 @@ static struct cftype mem_cgroup_legacy_files[] = {
 		.seq_show = mem_cgroup_dirty_ratio_show,
 		.write = mem_cgroup_dirty_ratio_write,
 	},
+	{
+		.name = "dirty_writeback_interval_centisecs",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.seq_show = mem_cgroup_dirty_writeback_interval_show,
+		.write = mem_cgroup_dirty_writeback_interval_write,
+	},
+	{
+		.name = "dirty_expire_interval_centisecs",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.seq_show = mem_cgroup_dirty_expire_interval_show,
+		.write = mem_cgroup_dirty_expire_interval_write,
+	},
 #endif
 	{ },	/* terminate */
 };
@@ -6549,6 +6651,18 @@ static struct cftype memory_files[] = {
 		.seq_show = mem_cgroup_dirty_ratio_show,
 		.write = mem_cgroup_dirty_ratio_write,
 	},
+	{
+		.name = "dirty_writeback_interval_centisecs",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.seq_show = mem_cgroup_dirty_writeback_interval_show,
+		.write = mem_cgroup_dirty_writeback_interval_write,
+	},
+	{
+		.name = "dirty_expire_interval_centisecs",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.seq_show = mem_cgroup_dirty_expire_interval_show,
+		.write = mem_cgroup_dirty_expire_interval_write,
+	},
 #endif
 	{ }	/* terminate */
 };
-- 
2.27.0

