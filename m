Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10D2D31C5CF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Feb 2021 04:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbhBPDbw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Feb 2021 22:31:52 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68]:59528 "EHLO
        mx0a-002c1b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229497AbhBPDbv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Feb 2021 22:31:51 -0500
X-Greylist: delayed 1393 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Feb 2021 22:31:49 EST
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
        by mx0a-002c1b01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11G37kPd021288;
        Mon, 15 Feb 2021 19:07:46 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version;
 s=proofpoint20171006; bh=ZxJRvxfkZd7JUYzca9azCkyuubE8h9/aVFT+aQrieqQ=;
 b=narnpgcrhhLPAY726z41Ejbi/PsSLcKfPvUaX35kmO6NZ9QLb0TSQLoBPgWqCysW3nET
 ML6Jw/HurZRlUAepuOkorU68FCXSVEdZCtUXdEYmavjh2QmfNrUnEM9VWYaWrzgJGMPC
 5M0uqB3vZxBogiUwpWppp/I6lSGQwzOMLCSRcM8u4QbGst10Zzrp4EDRphqgfA9SKKNE
 60qZflAOsXGsTao/HEMFgup9ie4xxt+bKPvg16dCBC9osYmXT5OJa6++jqZzcCObZmCA
 yFP/g1G3lA1E6Edxe8tVokg53Abst3MzN6QB7KJnR7nFnOk4afprEkfT0Hr52lQWXITZ 1Q== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by mx0a-002c1b01.pphosted.com with ESMTP id 36peqnvq0j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Feb 2021 19:07:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dYFFtvZMnt70I4hoRZ2gIwpATOVGnI+2md12rvQxA3J6Ir7kKxT18pZbX8Z3fP3jqy+QDg1JglCNyUkaUJixpeexyjaxR/AAjzjQ5xjvuN0UTnU2/RTevvE0Q7MHBipyH0G5Gr3iSdOuBRaZMVyOp0v4tb5E0vYL+52sXg6IbJDaZt60nCF9x9X0lwpBEPvSm5Udf7mGIcUTZZUbuwZTfUXOAlJox2Dzd6o7ODsFMyAp1EiyDGJB5STQ54ihwGNae3epuGGwBjZb23IDhu6FkrwTwX+EqTxcrmOXz5qrLpF7tqG0o7nt2bbMRJIUPQv7JpdfP8qHFFj3dblb2UgWOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZxJRvxfkZd7JUYzca9azCkyuubE8h9/aVFT+aQrieqQ=;
 b=QT/Z/+/GZRJniOPkj2BBiIHAHiVWq4El3xSxMqKhcX1mdbn11c5Dha1/2/g6OyBgVhhnOywnjPRvsUyTLc/dsq2YdSNu7Sz3cTqRor5RPuHg5e2RIzQXqBibqNPkVjYW6XDl+OxUnRHERzIhYm4kBrp4s+EUfIgYDIWNjOoq3kToF/ocTtz86vUOkv29EFVnIwconk5us3KffhXCGIvb3IWNVBgTMFjrAHOWxi4tpxcXiUEQvKvqwS3HtnPhsHAY0dKLgIAnYXUd2axZPpVuu16HOPzlfWG2xjoNSISvkjef2boaj65+4M6waya/Sv0cof1xsEfWHm/JUi4LS814qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Authentication-Results: lwn.net; dkim=none (message not signed)
 header.d=none;lwn.net; dmarc=none action=none header.from=nutanix.com;
Received: from DM6PR02MB6250.namprd02.prod.outlook.com (2603:10b6:5:1f5::26)
 by DM5PR02MB3180.namprd02.prod.outlook.com (2603:10b6:4:61::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.29; Tue, 16 Feb
 2021 03:07:44 +0000
Received: from DM6PR02MB6250.namprd02.prod.outlook.com
 ([fe80::6059:b0b7:ce3e:cb7e]) by DM6PR02MB6250.namprd02.prod.outlook.com
 ([fe80::6059:b0b7:ce3e:cb7e%6]) with mapi id 15.20.3846.039; Tue, 16 Feb 2021
 03:07:44 +0000
From:   Eiichi Tsukata <eiichi.tsukata@nutanix.com>
To:     corbet@lwn.net, mike.kravetz@oracle.com, mcgrof@kernel.org,
        keescook@chromium.org, yzaikin@google.com,
        akpm@linux-foundation.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Cc:     felipe.franciosi@nutanix.com,
        Eiichi Tsukata <eiichi.tsukata@nutanix.com>
Subject: [RFC PATCH] mm, oom: introduce vm.sacrifice_hugepage_on_oom
Date:   Tue, 16 Feb 2021 03:07:13 +0000
Message-Id: <20210216030713.79101-1-eiichi.tsukata@nutanix.com>
X-Mailer: git-send-email 2.9.3
Content-Type: text/plain
X-Originating-IP: [192.146.154.244]
X-ClientProxiedBy: BY3PR05CA0022.namprd05.prod.outlook.com
 (2603:10b6:a03:254::27) To DM6PR02MB6250.namprd02.prod.outlook.com
 (2603:10b6:5:1f5::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from eiichi-tsukata.ubvm.nutanix.com (192.146.154.244) by BY3PR05CA0022.namprd05.prod.outlook.com (2603:10b6:a03:254::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.12 via Frontend Transport; Tue, 16 Feb 2021 03:07:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dde58638-9aae-462e-e1d2-08d8d22807a2
X-MS-TrafficTypeDiagnostic: DM5PR02MB3180:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR02MB3180637D2A6F8248BC0505EB80879@DM5PR02MB3180.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9IDRnPQWr+p1xeSeeutaAy/kHUMaoy3ZUqsPMbAjfjvSnh+0AvsX1afRkY/kKgiSZuJYoRTtP3JnBN5Xth/isKIMO0o1QpGB6eVAEMZMO33p8pMH39bgeNqIVLywIaCBqBR6JO8udQnN5HGykkvefJQuHKHueycGpdgq92Ne8ckL7B8ar+2VWaw4HAxe25NXbORgICSEBP1wwkV2YNYgkmppg2hVWT0IKV4a4hu8U5Ghnkm9W4VpkMrMCuM7GUKo5a9XlsBvMCzsQJNbcTLTxMDh0AKHCOYLEiAUSfUrpCLR7oGT1kqy6786UqwPvhjKNlZL2Yw8XvAmeHvMezIFUsWtlCgv2mZhQor0HoQyrveiw4tn11BuoV3KGBreMKZmGvnGHW3/XZymCwpXVTCHVOQlaQ+rI74B3TCM3Z6+t6Q3qSpVvWVETG3BzHN2sMaSdar8Mvk/MdbfUUgE03WroEeaZ3nDxB5ZguOsPqAUk9nYrLLhMF03QvSzbo1jKvwkIXs+k6ekCzGpUo2KBndYH7oAT9KvooQziwUYrHI5fa/L5DYkFlPuGmpUR915R2HP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR02MB6250.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(39860400002)(346002)(366004)(136003)(8936002)(478600001)(7416002)(52116002)(1076003)(316002)(66946007)(107886003)(6486002)(7696005)(8676002)(26005)(66476007)(66556008)(83380400001)(86362001)(2906002)(956004)(186003)(36756003)(44832011)(2616005)(16526019)(6666004)(5660300002)(4326008)(921005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?FM5GNUNuV/usfbV5gl+K/H6lUPRzGLLe6AzVVroeoPOJDHr1zo0TXScYMLAc?=
 =?us-ascii?Q?bfpeCt1C/ziOgJzfddOzYkpbmSdBephu2vTOlSKiyQAko3QTquCwu+Z/VavZ?=
 =?us-ascii?Q?di+yz7rE9z6m4EIXEc9c4o+V23WEjQIlQh6Y4uVPtjD8cJFYEkVwj6PsDKY2?=
 =?us-ascii?Q?MKozmw5koozHPkO8JtZIaNbNhEtlEskpu3fUnv1jzBCxqmqjE7MpGya9anBo?=
 =?us-ascii?Q?CqEB/mf2glTBXvabgC80jP4d29f5ksRZUzqAy0oIXZckNQDyNx4M1PyT7l5W?=
 =?us-ascii?Q?hfKubuD7AKNM48j0uKHklW3ASU6tqsIicFF1CqS1QZdMgbC9vtWikqCwOb2S?=
 =?us-ascii?Q?M+MTkS3UiTg12PmuHfO6o/Y8ecyL8qtQIjo2lxGsDPvjJHu0hgov7HYr0GXF?=
 =?us-ascii?Q?7NbNL/3iyWEKeTAa+iQmCgBrm42g7YpkBE3JoJ6tyWrutIJ46rnNhmrM1eQb?=
 =?us-ascii?Q?nSPCEY57cGlLUhvv6i6fOTgusC1S+0MvxNMfJDG9VKOQEf1B1qxG5HQKZzIC?=
 =?us-ascii?Q?zXTE+acEtpOHzk3yDBry77RYUiuwtXftdOuYz01Y8aL8zIQZzYV9YXQb3hwM?=
 =?us-ascii?Q?uN/tKAygNZFxZGiyo2Yb4P3f/TJ5yY/x86JAbqe4yV0rhvNdVNZReLjFnCBf?=
 =?us-ascii?Q?uwKRVxLWN3x+OhRo6ZXBddUgWgAOEx8HWLLLbmRE0ESpyikZKB5aA8Rl7mmm?=
 =?us-ascii?Q?v0KVv7jNrWUQRAa0CVZFriKH6EWoDRlZv5oozVXLUH1oQupkeQWIE0g672Lv?=
 =?us-ascii?Q?+D6N9SkGYkeTtrvoNB4I/mn3sTCmbymq1lpln9Od/fcQHRxn+PY/+CeWQxkt?=
 =?us-ascii?Q?ra3HHzTLQIX8jscTDkE1B5cOBJ/2CCaNgXxJgH0jUwFv7e7Fl0YtEW/7tN0i?=
 =?us-ascii?Q?NbOz4pPP4+Vr09iM3tSYt0+53mD6BT8u2XyswJrW+OmwGnQ97nb/Emwn19Nv?=
 =?us-ascii?Q?wGRSzOox5gD6ski8FFzwj3OSLwCvp1FpEO9kLjnsC3v7CEqaR2iHcuaN161h?=
 =?us-ascii?Q?I/4ve4FZvQG0epK73qa+LDRYxECHUDx2MIA+qHRFEnBF1UTlHApvNwCG9/KD?=
 =?us-ascii?Q?a0aMzjuv43UuE6A5K4IymNvQFQ0/S/Ana+CBfU8lrroFFIkROwP6b+5xKifE?=
 =?us-ascii?Q?dqdZi6jemrX52z9n/ncRBnX6Zrzyo9WrII/lJAwI49jI+hgaKRp9llpLCdQJ?=
 =?us-ascii?Q?65r8cNi+EYsuVbWHjaPdAKZ2PvaiDvh2xT4NykQ7uUDziqP+P+aq6hm5OmQl?=
 =?us-ascii?Q?C1hqvBvMFfSwtXhapGYPHJOKKKfqQTV74MqOjdTPtLPCpXQdWRjSb/y7P5jG?=
 =?us-ascii?Q?BRaH2FljNmnLDzBqzHnjqGlc?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dde58638-9aae-462e-e1d2-08d8d22807a2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR02MB6250.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2021 03:07:44.3024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /lKz80Hx3hld74l/xJdKf+9bHIPp+oOyu0DC0HUpoYcLhGK4J4qN8+DruV1iyiy/+JPEnn4CfsAnIaW9AMzJDNLTuxdx8nkbndd/qgKpwyo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB3180
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-15_16:2021-02-12,2021-02-15 signatures=0
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hugepages can be preallocated to avoid unpredictable allocation latency.
If we run into 4k page shortage, the kernel can trigger OOM even though
there were free hugepages. When OOM is triggered by user address page
fault handler, we can use oom notifier to free hugepages in user space
but if it's triggered by memory allocation for kernel, there is no way
to synchronously handle it in user space.

This patch introduces a new sysctl vm.sacrifice_hugepage_on_oom. If
enabled, it first tries to free a hugepage if available before invoking
the oom-killer. The default value is disabled not to change the current
behavior.

Signed-off-by: Eiichi Tsukata <eiichi.tsukata@nutanix.com>
---
 Documentation/admin-guide/sysctl/vm.rst | 12 ++++++++++++
 include/linux/hugetlb.h                 |  2 ++
 include/linux/oom.h                     |  1 +
 kernel/sysctl.c                         |  9 +++++++++
 mm/hugetlb.c                            |  4 ++--
 mm/oom_kill.c                           | 23 +++++++++++++++++++++++
 6 files changed, 49 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
index e35a3f2fb006..f2f195524be6 100644
--- a/Documentation/admin-guide/sysctl/vm.rst
+++ b/Documentation/admin-guide/sysctl/vm.rst
@@ -65,6 +65,7 @@ Currently, these files are in /proc/sys/vm:
 - page-cluster
 - panic_on_oom
 - percpu_pagelist_fraction
+- sacrifice_hugepage_on_oom
 - stat_interval
 - stat_refresh
 - numa_stat
@@ -807,6 +808,17 @@ The initial value is zero.  Kernel does not use this value at boot time to set
 the high water marks for each per cpu page list.  If the user writes '0' to this
 sysctl, it will revert to this default behavior.
 
+sacrifice_hugepage_on_oom
+=========================
+
+This value controls whether the kernel should attempt to break up hugepages
+when out-of-memory happens. OOM happens under memory cgroup would not invoke
+this.
+
+If set to 0 (default), the kernel doesn't touch the hugepage pool during OOM
+conditions.
+If set to 1, the kernel frees one hugepage at a time, if available, before
+invoking the oom-killer.
 
 stat_interval
 =============
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index b5807f23caf8..8aad2f2ab6e6 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -145,6 +145,8 @@ int hugetlb_reserve_pages(struct inode *inode, long from, long to,
 long hugetlb_unreserve_pages(struct inode *inode, long start, long end,
 						long freed);
 bool isolate_huge_page(struct page *page, struct list_head *list);
+int free_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed,
+			bool acct_surplus);
 void putback_active_hugepage(struct page *page);
 void move_hugetlb_state(struct page *oldpage, struct page *newpage, int reason);
 void free_huge_page(struct page *page);
diff --git a/include/linux/oom.h b/include/linux/oom.h
index 2db9a1432511..0bfae027ec16 100644
--- a/include/linux/oom.h
+++ b/include/linux/oom.h
@@ -127,4 +127,5 @@ extern struct task_struct *find_lock_task_mm(struct task_struct *p);
 extern int sysctl_oom_dump_tasks;
 extern int sysctl_oom_kill_allocating_task;
 extern int sysctl_panic_on_oom;
+extern int sysctl_sacrifice_hugepage_on_oom;
 #endif /* _INCLUDE_LINUX_OOM_H */
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index c9fbdd848138..d2e3ec625f5f 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2708,6 +2708,15 @@ static struct ctl_table vm_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
 	},
+	{
+		.procname	= "sacrifice_hugepage_on_oom",
+		.data		= &sysctl_sacrifice_hugepage_on_oom,
+		.maxlen		= sizeof(sysctl_sacrifice_hugepage_on_oom),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
+	},
 	{
 		.procname	= "overcommit_ratio",
 		.data		= &sysctl_overcommit_ratio,
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 4bdb58ab14cb..e2d57200fd00 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1726,8 +1726,8 @@ static int alloc_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed,
  * balanced over allowed nodes.
  * Called with hugetlb_lock locked.
  */
-static int free_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed,
-							 bool acct_surplus)
+int free_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed,
+			bool acct_surplus)
 {
 	int nr_nodes, node;
 	int ret = 0;
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 04b19b7b5435..fd2c1f427926 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -43,6 +43,7 @@
 #include <linux/kthread.h>
 #include <linux/init.h>
 #include <linux/mmu_notifier.h>
+#include <linux/hugetlb.h>
 
 #include <asm/tlb.h>
 #include "internal.h"
@@ -52,6 +53,7 @@
 #include <trace/events/oom.h>
 
 int sysctl_panic_on_oom;
+int sysctl_sacrifice_hugepage_on_oom;
 int sysctl_oom_kill_allocating_task;
 int sysctl_oom_dump_tasks = 1;
 
@@ -1023,6 +1025,22 @@ static void check_panic_on_oom(struct oom_control *oc)
 		sysctl_panic_on_oom == 2 ? "compulsory" : "system-wide");
 }
 
+static int sacrifice_hugepage(void)
+{
+	int ret;
+
+	spin_lock(&hugetlb_lock);
+	ret = free_pool_huge_page(&default_hstate, &node_states[N_MEMORY], 0);
+	spin_unlock(&hugetlb_lock);
+	if (ret) {
+		pr_warn("Out of memory: Successfully sacrificed a hugepage\n");
+		hugetlb_show_meminfo();
+	} else {
+		pr_warn("Out of memory: No free hugepage available\n");
+	}
+	return ret;
+}
+
 static BLOCKING_NOTIFIER_HEAD(oom_notify_list);
 
 int register_oom_notifier(struct notifier_block *nb)
@@ -1100,6 +1118,11 @@ bool out_of_memory(struct oom_control *oc)
 		return true;
 	}
 
+	if (!is_memcg_oom(oc) && sysctl_sacrifice_hugepage_on_oom) {
+		if (sacrifice_hugepage())
+			return true;
+	}
+
 	select_bad_process(oc);
 	/* Found nothing?!?! */
 	if (!oc->chosen) {
-- 
2.29.2

