Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A01A51147E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Apr 2022 11:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbiD0Jkm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Apr 2022 05:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbiD0Jkc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Apr 2022 05:40:32 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2081.outbound.protection.outlook.com [40.92.99.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E87932B26C;
        Wed, 27 Apr 2022 02:36:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I/pnxbDYX8D1n4oTOg5fxUIQekN5qhWGfdNGphFBc/n1WCIAYpBEa/Ey0d2i3jbbPpkz0tSGsmzFCyA0Usw+yC8uA5VeyaqyWft3iivVdShDaBm0rHVIKAzM35Hj/mCH/WefP99+szFa6YRnjb1t/RYooFCEMBobQJUtQvad0WZYbWZ+/X5wwT+YJq1H5jzgAxIdNQ98FFn0i0j0RM1w9lcQNZb3PXveQw4OnkScgH0Z5xcVdAL84y4Z20flx6YEX/khJBhuQzsdB/lYdZzzq0ntn+2Nk3KX2xxq0UGkIAAhexuwcEKio7va+Jb9m5hv3Q9AhGtsC7qTQnUNurhf0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8bc0VA7NjTfc10O2vTJg7NTIQa/Al+Kv3WZgNRuLvIA=;
 b=koiCEKK8aEwYBvjzOjjD8KT/p7l79HFfTGdQNv3f12RDm0sYUntpOLRAIEwIAKPu4eRbK4hNhNpm+RnzjVrx5PHpT3Yb57CiFbXlrK8yWiAT0YfxdaU3QKaBKvubmAFr1hSSboZ+sGz6GzJ7iM0tSNk17dy7P2sg3JoU4wX3/H1MjX5PETzxUo7Lkhu/nJO5DpK/osdFLvkMT9sdxhEnO+MYZReHSCrwQd9QTKM9WoZWoMXtP1Ra9P/xAITPRrTNTWCpLovuKf6gFvQPnWzD+W1K0BYjUCtPV4+FvWRFV+OJr/iEJKQ5tE6oAX3/Ki9zqe4eFfaHiDnjpFna+4c0IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8bc0VA7NjTfc10O2vTJg7NTIQa/Al+Kv3WZgNRuLvIA=;
 b=ENM+CVDjOI0B35Ddf1OxHyQaRKdkqK96TP96zeMkKUrsZCT4xx3/ieNT5dHBIkqLfvUHDOBPxKcUYAYaauU8bBBWfXuVueIghhQO/pf3jidOJ1Uda74m2getRSlPOdDvuKwJFNgounZ3rWhmZyhFGeDRmQQrKCswQvm5izOSZUBmYAuypWgrso4j6mmprwWJ5RCImhbxq25dBsXMzmQLHTB2pQtVlqzpdjuWtS2gVE3Wl6PFyIj9o5uEMZIyP1RVr41JWFFg4iGRTYAC3sB/svUlYM02AClZbQvedfsIcMoxMMy6zSgRylBx/RNDHxbDMl3HzkL61HHfz/3b7/cNvQ==
Received: from TYYP286MB1115.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:ce::9) by
 OS3P286MB1057.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:10f::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.14; Wed, 27 Apr 2022 09:32:58 +0000
Received: from TYYP286MB1115.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ed8c:9e75:ddab:8c5e]) by TYYP286MB1115.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ed8c:9e75:ddab:8c5e%4]) with mapi id 15.20.5186.021; Wed, 27 Apr 2022
 09:32:58 +0000
From:   Xie Yongmei <yongmeixie@hotmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Cc:     yongmeixie@hotmail.comc, Xie Yongmei <yongmeixie@hotmail.com>
Subject: [PATCH 2/3] writeback: per memcg dirty flush
Date:   Wed, 27 Apr 2022 05:32:40 -0400
Message-ID: <TYYP286MB1115132A9443D0B6D21DAD89C5FA9@TYYP286MB1115.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220427093241.108281-1-yongmeixie@hotmail.com>
References: <20220427093241.108281-1-yongmeixie@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [HMiPaF3wZ5f624u3a2Cil/zMNEGOepzi]
X-ClientProxiedBy: HK0PR01CA0067.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::31) To TYYP286MB1115.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:ce::9)
X-Microsoft-Original-Message-ID: <20220427093241.108281-3-yongmeixie@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d90ecebe-28b7-41ba-fbc2-08da2830ea44
X-MS-Exchange-SLBlob-MailProps: zswcL9HXbeUs2ByizIwMZz3XeV1no+ZLtKVE8mk0WkDdb8wbxO0RIKOp367exO0P2XNE3cqNBquMgA3Tzx7Ug7Yam54FBek78ouRrTlUrEKOUGVSk5k27eWJWYeMpoefkvKUPHarOy5vu/NNnaZAQWiyc5R4YBSISEvQtPH/ORjIIdmxu1PlzOO7/+Df0/RZcyydhcvaQuW0H8KGecDNa6GAYMn19nXFwPc1JR6PERpsOwsl8GUryfJ3picwVeXisrOnCvyqkt62m3cRV93QjuJuvRaNcII99uGqXbRIUKYLeGkIs3lSfSjtrha7FuFutnbn+ywBkwTku4E8iQpxqOSUqpbDZk5zexRLX6cYe8kSW0208LaUNcR3MWAF9Sit6j+8/YQ67ugemSCmXbwa5Tnibq5qhO1f28JvoSzZn6DVd3aFSwAQs1smbADWuPABLAUxVo8MaP+Ha0yVHhGPZo6Av8252dMq4EupAAQ7diNRaAjy3ETkG4dqxY/7BrdATDUUN6N3ribERiqla+BBtsahKLcYREBf1ECfJmSt9+S9k/Uv1RqoalFU8uaUzZprJOpm/XDnjWwFz/vWwMItvjbemCcNXG0JQY+NEjQ5yThawUreGNSCOSVk/nr4bIwHNHiDAKAAmqp+bu3/hkqW7Ae6Zz6LfxX/fjVXrO2I8YNV8myk0rVDsEV/7SW2uGUYNi5VZyFWblpU4Vg6ewgM0YD5/Pw68VubROq/Be/eS1P+NSahUHdI+H8lH9mD+WVS
X-MS-TrafficTypeDiagnostic: OS3P286MB1057:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0nUH2oFcDYTvTMr1GpsmWyrI7+VXlhXmKqifbN/UH7gC4zXDbMopZ1DWRxnFv3PWZ7li414opCcgdB2dTC2GiComZ3oihFtCIrrdR7GOeLzjApw3p3hHXLela0mwbW1s4j0EGd97xGzzQT0PymsKFUejVVkZ0JkLB2C/4ePjvJsrcJzEEcE9LnY/1pZQ2hqScPCcEB8dV2RdU+ldQ4G4g/rY+fMsiIB1sRbQcuQHTRkQYqEa1UUi/CMwfJJb4HU6yqXaL1DQGkm8y40KRV85Ih92UmoCa6xU9I5bBxo90jWjo+zVs7xqv460RrMRFUqUzbDneUluyPrAm7d2InFacwSXBOj7yXhNzdFg6213+YTPeBX6xDQ1aZzPr2stT6q/gSpkAQfHx8sy7lg6u5hLKadDu0qAEoMTjGt5+aIeGOBDTPSGNpLBzmo/CXLjPQDhEy9V2k6LlvLOr8e1FSrZBQjhIMDzrJwEjcJBG6CB4skkH+CGfWQ7gavZUAZHxZgzKOdR0zKO4NokGr9jVLR+x8AOaOypcPHY1MXYUhU8onauN40T77frlmV0mNxkEck8+JsM8sfxclM9u9hTwcoBtg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YF0zGO9HKkLET+DR1NKjE2RPyJ6IuOESkjU5vziOV9asQTP1OB5kemGbjYP8?=
 =?us-ascii?Q?qJ/XbKL+Em3rtX90DIHI7vI6N3xApGdGiWG44YuV5m03ntLA8WK4Ljw/pFdG?=
 =?us-ascii?Q?dIdJQXV7wOyNJADr80dqKxIgktdTjLIUPixiJdlMFRCuxDp18f25IswdSlZH?=
 =?us-ascii?Q?2JKDY48TdIY7/ogJkIy+J0Sohs4HQ0gIQxiQPHyWyEY2pOj8LSdKBOWcWo2z?=
 =?us-ascii?Q?riRzmh7hXlAq1I7tK/FNPbEtj0uaW2qZqMd2GRD3OiCCQ91Xq7X3+H7e/wDl?=
 =?us-ascii?Q?CKUn3JmAqhDF5tTFnZpvZwo0QIAxH4UcZqFJbmMM6E3NkffnqFBmcJwkdZcU?=
 =?us-ascii?Q?2Kb36y9MgpmITz+dc+DxrpoOH6G4534eGWUJ2GXyx8hHhLKaeVmq9HHyQdcN?=
 =?us-ascii?Q?NdX0vCH7l33qp7MwG919MLmTl3sGWyOKSDDpctqWLeeCw76i8oFtX6KIab0+?=
 =?us-ascii?Q?5QIVwsIRJIYXbu2gfCpQo9R2ooee5QPCPKOHjEqqEN80Mp6L3g6+fFuW9I8N?=
 =?us-ascii?Q?FbXaRLgBLZBEPQJqTOhZKN2L2n5ndWB6oFNfAmgHzwUWs1eKsnJixQ4XuFF5?=
 =?us-ascii?Q?bJkka3kSNN2uR+GT7SVktFw8j8L4k8A7FgCITvmZZJSbywfuXuoXgFYoAENJ?=
 =?us-ascii?Q?ysQO00GO1SYkddM6oll14cGksOfnyLzKGhC4Wtrzn+fPGNOwZXkQk7c1VS7v?=
 =?us-ascii?Q?mlbp2LaX0Pl+y9J3/M730a8JGhghX4eNsUuVjGdcy+OrUEps/p/XoBjZQ36B?=
 =?us-ascii?Q?cDA0EGQjR5WaC2tUWWfrV9XZ0M+ROzjmrcjbUZVG6N8J+0gG9vVc2WucTXEf?=
 =?us-ascii?Q?n8sTohFPe4xtRVx9qecYjw+UjNWntr/UD2FHZeGxfeLYY63DcGkKyWPi7XXv?=
 =?us-ascii?Q?vQ5UZrtnUSAafBjHnc0w3MngEd8Bq5qhI7REgrqonmydRfY4aOWQvgnPgOHC?=
 =?us-ascii?Q?AGva7eIrIs2Ix7KgItgZg0v7+IGJ9JDS0JG5rsFcCpuZZSKcKXBhadEeZcRe?=
 =?us-ascii?Q?qDx9bro5J6g2M+f7z50wliwvBkoHzfTXJqm62DCC4iXbquHIYdTQmH0rpGQ7?=
 =?us-ascii?Q?5XtDCteobp2r0kpKyQ9ZiuHPHwj50iluqou9JEO9l4FqZHVArqMOjqHYfH3C?=
 =?us-ascii?Q?4BPKcaipJJH45wtPDSa4maFkqrHPAvyHKBwn2MSFzBm5pkkQGLc6xtGrv1BZ?=
 =?us-ascii?Q?ASiCl2cTxrvrk+ThEel/NRb7udIYuh2l0xye2dJXtEt0Fgc1yMs0VwpPWXrD?=
 =?us-ascii?Q?kEtqiPBxFCg2UG4452asWlwP4OSABqDU2H62cGEXNhT4VOia+8Ev+13Lcc9u?=
 =?us-ascii?Q?CAPNflWBLCTLJLk3g33473XHLsZqRQu4jRSoFHisQYUjq8/VRUDYuHu2Mvjj?=
 =?us-ascii?Q?MjJBRp5ZLsWHptUwCsW3zMCbx7V0sdTk3iq/K0NvWp9nTdr5EPiEjAyiEweX?=
 =?us-ascii?Q?g6wKCM46Kog=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-05f45.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: d90ecebe-28b7-41ba-fbc2-08da2830ea44
X-MS-Exchange-CrossTenant-AuthSource: TYYP286MB1115.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2022 09:32:58.3882
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

Currently, dirty writeback is under global control. We can tune it by
parameters in /proc/sys/vm/
  - dirty_expire_centisecs: expire interval in centiseconds
  - dirty_writeback_centisecs: periodcal writeback interval in centiseconds
  - dirty_background_bytes/dirty_background_ratio: async writeback
    threshold
  - dirty_bytes/dirty_ratio: sync writeback threshold

Sometimes, we'd like to specify special wrtiteback policy for user
application, especially for offline application in co-location scenerio.

This patch provides dirty flush policy per memcg, user can specify them
in memcg interface.

Actually, writeback code maintains two dimensions of dirty pages control in
balance_dirty_pages.
   - gdtc for global control
   - mdtc for cgroup control

When dirty pages is under both of control, it leaves the check quickly.
Otherwise, it computes the wb threshold (along with bg_threshold) taking
the writeout bandwidth into consideration. And computes position ratio
against wb_thresh for both global control and cgroup control as well.
After that, it takes the smaller one (IOW the strict one) as the factor
to generate task ratelimit based on wb's dirty_ratelimit.

So far, the writeback code can control the dirty limit for both global
view and cgroup view. That means the framework works well for controlling
cgroup's dirty limit.

This patch only provides an extra interface for memcg to tune writeback
behavior.

Signed-off-by: Xie Yongmei <yongmeixie@hotmail.com>
---
 include/linux/memcontrol.h |  22 ++++++
 init/Kconfig               |   7 ++
 mm/memcontrol.c            | 136 +++++++++++++++++++++++++++++++++++++
 mm/page-writeback.c        |  15 +++-
 4 files changed, 178 insertions(+), 2 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index a68dce3873fc..386fc9b70c95 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -344,6 +344,11 @@ struct mem_cgroup {
 	struct deferred_split deferred_split_queue;
 #endif
 
+#ifdef CONFIG_CGROUP_WRITEBACK_PARA
+	int dirty_background_ratio;
+	int dirty_ratio;
+#endif
+
 	struct mem_cgroup_per_node *nodeinfo[];
 };
 
@@ -1634,6 +1639,23 @@ static inline void mem_cgroup_flush_foreign(struct bdi_writeback *wb)
 
 #endif	/* CONFIG_CGROUP_WRITEBACK */
 
+#ifdef CONFIG_CGROUP_WRITEBACK_PARA
+unsigned int wb_dirty_background_ratio(struct bdi_writeback *wb);
+unsigned int wb_dirty_ratio(struct bdi_writeback *wb);
+#else
+static inline
+unsigned int wb_dirty_background_ratio(struct bdi_writeback *wb)
+{
+	return dirty_background_ratio;
+}
+
+static inline
+unsigned int wb_dirty_ratio(struct bdi_writeback *wb)
+{
+	return vm_dirty_ratio;
+}
+#endif
+
 struct sock;
 bool mem_cgroup_charge_skmem(struct mem_cgroup *memcg, unsigned int nr_pages,
 			     gfp_t gfp_mask);
diff --git a/init/Kconfig b/init/Kconfig
index ddcbefe535e9..0b8152000d6e 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -989,6 +989,13 @@ config CGROUP_WRITEBACK
 	depends on MEMCG && BLK_CGROUP
 	default y
 
+config CGROUP_WRITEBACK_PARA
+	bool "Enable setup dirty flush parameters per memcg"
+	depends on CGROUP_WRITEBACK
+	default y
+	help
+	  This feature helps cgroup could specify its own diry wriback policy.
+
 menuconfig CGROUP_SCHED
 	bool "CPU controller"
 	default n
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index e8922bacfe2a..b1c1b150637a 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4822,6 +4822,112 @@ static int mem_cgroup_slab_show(struct seq_file *m, void *p)
 }
 #endif
 
+#ifdef CONFIG_CGROUP_WRITEBACK_PARA
+unsigned int wb_dirty_background_ratio(struct bdi_writeback *wb)
+{
+	struct mem_cgroup *memcg;
+
+	if (mem_cgroup_disabled() || !wb)
+		return dirty_background_ratio;
+
+	memcg = mem_cgroup_from_css(wb->memcg_css);
+	if (memcg == root_mem_cgroup || memcg->dirty_background_ratio < 0)
+		return dirty_background_ratio;
+
+	return memcg->dirty_background_ratio;
+}
+
+unsigned int wb_dirty_ratio(struct bdi_writeback *wb)
+{
+	struct mem_cgroup *memcg;
+
+	if (mem_cgroup_disabled() || !wb)
+		return vm_dirty_ratio;
+
+	memcg = mem_cgroup_from_css(wb->memcg_css);
+	if (memcg == root_mem_cgroup || memcg->dirty_ratio < 0)
+		return vm_dirty_ratio;
+
+	return memcg->dirty_ratio;
+}
+
+static void wb_memcg_inherit_from_parent(struct mem_cgroup *parent,
+					 struct mem_cgroup *memcg)
+{
+	memcg->dirty_background_ratio = parent->dirty_background_ratio;
+	memcg->dirty_ratio = parent->dirty_ratio;
+}
+
+static void wb_memcg_init(struct mem_cgroup *memcg)
+{
+	memcg->dirty_background_ratio = -1;
+	memcg->dirty_ratio = -1;
+}
+
+static int mem_cgroup_dirty_background_ratio_show(struct seq_file *m, void *v)
+{
+	struct mem_cgroup *memcg = mem_cgroup_from_css(seq_css(m));
+
+	seq_printf(m, "%d\n", memcg->dirty_background_ratio);
+	return 0;
+}
+
+static ssize_t
+mem_cgroup_dirty_background_ratio_write(struct kernfs_open_file *of,
+					char *buf, size_t nbytes,
+					loff_t off)
+{
+	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
+	int ret, background_ratio;
+
+	buf = strstrip(buf);
+	ret = kstrtoint(buf, 0, &background_ratio);
+	if (ret)
+		return ret;
+
+	if (background_ratio < -1 || background_ratio > 100)
+		return -EINVAL;
+
+	memcg->dirty_background_ratio = background_ratio;
+	return nbytes;
+}
+
+static int mem_cgroup_dirty_ratio_show(struct seq_file *m, void *v)
+{
+	struct mem_cgroup *memcg = mem_cgroup_from_css(seq_css(m));
+
+	seq_printf(m, "%d\n", memcg->dirty_ratio);
+	return 0;
+}
+
+static ssize_t
+mem_cgroup_dirty_ratio_write(struct kernfs_open_file *of,
+			     char *buf, size_t nbytes, loff_t off)
+{
+	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
+	int ret, dirty_ratio;
+
+	buf = strstrip(buf);
+	ret = kstrtoint(buf, 0, &dirty_ratio);
+	if (ret)
+		return ret;
+
+	if (dirty_ratio < -1 || dirty_ratio > 100)
+		return -EINVAL;
+
+	memcg->dirty_ratio = dirty_ratio;
+	return nbytes;
+}
+#else
+static void wb_memcg_inherit_from_parent(struct mem_cgroup *parent,
+					 struct mem_cgroup *memcg)
+{
+}
+
+static inline void wb_memcg_init(struct mem_cgroup *memcg)
+{
+}
+#endif
 static struct cftype mem_cgroup_legacy_files[] = {
 	{
 		.name = "usage_in_bytes",
@@ -4948,6 +5054,20 @@ static struct cftype mem_cgroup_legacy_files[] = {
 		.write = mem_cgroup_reset,
 		.read_u64 = mem_cgroup_read_u64,
 	},
+#ifdef CONFIG_CGROUP_WRITEBACK_PARA
+	{
+		.name = "dirty_background_ratio",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.seq_show = mem_cgroup_dirty_background_ratio_show,
+		.write = mem_cgroup_dirty_background_ratio_write,
+	},
+	{
+		.name = "dirty_ratio",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.seq_show = mem_cgroup_dirty_ratio_show,
+		.write = mem_cgroup_dirty_ratio_write,
+	},
+#endif
 	{ },	/* terminate */
 };
 
@@ -5151,11 +5271,13 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
 		page_counter_init(&memcg->swap, &parent->swap);
 		page_counter_init(&memcg->kmem, &parent->kmem);
 		page_counter_init(&memcg->tcpmem, &parent->tcpmem);
+		wb_memcg_inherit_from_parent(parent, memcg);
 	} else {
 		page_counter_init(&memcg->memory, NULL);
 		page_counter_init(&memcg->swap, NULL);
 		page_counter_init(&memcg->kmem, NULL);
 		page_counter_init(&memcg->tcpmem, NULL);
+		wb_memcg_init(memcg);
 
 		root_mem_cgroup = memcg;
 		return &memcg->css;
@@ -6414,6 +6536,20 @@ static struct cftype memory_files[] = {
 		.seq_show = memory_oom_group_show,
 		.write = memory_oom_group_write,
 	},
+#ifdef CONFIG_CGROUP_WRITEBACK_PARA
+	{
+		.name = "dirty_background_ratio",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.seq_show = mem_cgroup_dirty_background_ratio_show,
+		.write = mem_cgroup_dirty_background_ratio_write,
+	},
+	{
+		.name = "dirty_ratio",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.seq_show = mem_cgroup_dirty_ratio_show,
+		.write = mem_cgroup_dirty_ratio_write,
+	},
+#endif
 	{ }	/* terminate */
 };
 
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 7e2da284e427..cec2ef032927 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -395,12 +395,23 @@ static void domain_dirty_limits(struct dirty_throttle_control *dtc)
 		 * per-PAGE_SIZE, they can be obtained by dividing bytes by
 		 * number of pages.
 		 */
+#ifdef CONFIG_CGROUP_WRITEBACK_PARA
+		ratio = (wb_dirty_ratio(dtc->wb) * PAGE_SIZE) / 100;
+		bg_ratio = (wb_dirty_background_ratio(dtc->wb) * PAGE_SIZE) / 100;
+		if (!ratio && bytes)
+			ratio = min(DIV_ROUND_UP(bytes, global_avail),
+				    PAGE_SIZE);
+		if (!bg_ratio && bg_bytes)
+			bg_ratio = min(DIV_ROUND_UP(bg_bytes, global_avail),
+				       PAGE_SIZE);
+#else
 		if (bytes)
 			ratio = min(DIV_ROUND_UP(bytes, global_avail),
 				    PAGE_SIZE);
 		if (bg_bytes)
 			bg_ratio = min(DIV_ROUND_UP(bg_bytes, global_avail),
 				       PAGE_SIZE);
+#endif
 		bytes = bg_bytes = 0;
 	}
 
@@ -418,8 +429,8 @@ static void domain_dirty_limits(struct dirty_throttle_control *dtc)
 		bg_thresh = thresh / 2;
 	tsk = current;
 	if (rt_task(tsk)) {
-		bg_thresh += bg_thresh / 4 + global_wb_domain.dirty_limit / 32;
-		thresh += thresh / 4 + global_wb_domain.dirty_limit / 32;
+		bg_thresh += bg_thresh / 4 + dtc_dom(dtc)->dirty_limit / 32;
+		thresh += thresh / 4 + dtc_dom(dtc)->dirty_limit / 32;
 	}
 	dtc->thresh = thresh;
 	dtc->bg_thresh = bg_thresh;
-- 
2.27.0

