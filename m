Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 747F834F31A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Mar 2021 23:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232836AbhC3V1d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Mar 2021 17:27:33 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:50812 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232624AbhC3V05 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Mar 2021 17:26:57 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12ULP4lH145287;
        Tue, 30 Mar 2021 21:25:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=XvhIVW1YeC3SfNdVXSE6ELE9IxQAzoSdaTuSqk4akz4=;
 b=DiY+ZxAssM0WGlPPytqDLZkcN2RCb4VdQqHXdc+TTQa88pLYH2/95P2VVWzdKnlk+3+U
 wZf+RlhYyAakT1/VpoMqzcT5IC/+oQwwoTb7/BDgHXYl7XlrY5Wke6bSRux1pEdbsqTn
 TwXpLlEPhrA3TSceiqbAif6nIg82D9BxhmDqmZ68HEnuUxFc1yok5N+A/oUpmFnx5c00
 jOzEOGC4qOHDAFhvX9YXH3rmsxtpQiIDiRKe2NvuaiIgwSM6UEGW2HDWq2dOXtdvKFbr
 5bV6uL8A122yxtM12JRbsBDrBg9n+XRjk9cAEHuSz0wGHfCMWLXzkBYj9LYYtctZDJfy rw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 37mad9r8eb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Mar 2021 21:25:38 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12ULPYUh124923;
        Tue, 30 Mar 2021 21:25:37 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by aserp3030.oracle.com with ESMTP id 37mabnk6wj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Mar 2021 21:25:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mO1I4GGO3P/dZbG4QmxkdkGYWxI3Qp3veweN4SqLgTyTQqulGwo99CHhRLXFJuSkc8Cn/28mAVFlorBOlq2SeVT/7b8j6aY3mC2hUycy0OMfVhRaDXmHj5da5H6cKZL5sY9VXIcyPV8UPbZL4nOYTh9+mU/edu3wFtiE61Z1uKzvmMKnjzGfsBQAcQ/T7D4vbQsZSlraaGuBpsbSdGbcT605B2kP/ZxNj0M/7mx+M2MsOK9xf8vgmFjHOUrPrM0oJYKD3MPHzrc1UeSK6qD+1g3Vc+IJ7p41Snrkmyha/Ll1ysqNyvj2DSAM4wgZqOlQdWK+dYq0KZiZF6EdMk/ogQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XvhIVW1YeC3SfNdVXSE6ELE9IxQAzoSdaTuSqk4akz4=;
 b=L13g1nfF+upp44adpu7d51hkr2VurQt6pyMPkxDNNjtDiZlKkajnVnejQ/mAw2jfILxJAAwvwvDXDlfY9X53//HynWKJVl7hXxvkCW+QWOejuTMNSiHYwDR9S/pceUj20XiEHiIoTKVVCjn2Fk0PwaM8JeR9vLvUbJyfolD3XKR1mj+Tqny6F6rz4ACGoucEC61uIQKiF51WGmzlRTD7vAQmrlHNMKl0n1SaAueQ3+qIPFpHXUryhP3XmuEhUBDREolikXNwPE8JRjWnGVIGggaE0tbLu5YihPoLfjNRqzauSUghZTnOa667DF+O/pEfooU7oexNKc46zVbRNMgUyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XvhIVW1YeC3SfNdVXSE6ELE9IxQAzoSdaTuSqk4akz4=;
 b=psm0brCwe2IiwwUOjtjTuTwYf8wcfBd4ihtWnui5oYcOKDWdWQHufg3Gss5ldBk6G80g+QISRgb9Nw6TbRoNnystgzXNb6yJ2tYrZjBIeW5nTzWTXgHG36FqRUg2yffsqX5KKTvsyP29orBiI4ERcJw5OQ56L/A+5LwQOa+al2w=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB3533.namprd10.prod.outlook.com (2603:10b6:208:118::32)
 by MN2PR10MB3357.namprd10.prod.outlook.com (2603:10b6:208:12e::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Tue, 30 Mar
 2021 21:25:30 +0000
Received: from MN2PR10MB3533.namprd10.prod.outlook.com
 ([fe80::cc79:c40e:430f:e254]) by MN2PR10MB3533.namprd10.prod.outlook.com
 ([fe80::cc79:c40e:430f:e254%4]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 21:25:30 +0000
From:   Anthony Yznaga <anthony.yznaga@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     willy@infradead.org, corbet@lwn.net, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        rppt@kernel.org, akpm@linux-foundation.org, hughd@google.com,
        ebiederm@xmission.com, keescook@chromium.org, ardb@kernel.org,
        nivedita@alum.mit.edu, jroedel@suse.de, masahiroy@kernel.org,
        nathan@kernel.org, terrelln@fb.com, vincenzo.frascino@arm.com,
        martin.b.radev@gmail.com, andreyknvl@google.com,
        daniel.kiper@oracle.com, rafael.j.wysocki@intel.com,
        dan.j.williams@intel.com, Jonathan.Cameron@huawei.com,
        bhe@redhat.com, rminnich@gmail.com, ashish.kalra@amd.com,
        guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        iamjoonsoo.kim@lge.com, vbabka@suse.cz, alex.shi@linux.alibaba.com,
        david@redhat.com, richard.weiyang@gmail.com,
        vdavydov.dev@gmail.com, graf@amazon.com, jason.zeng@intel.com,
        lei.l.li@intel.com, daniel.m.jordan@oracle.com,
        steven.sistare@oracle.com, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, kexec@lists.infradead.org
Subject: [RFC v2 07/43] mm: PKRAM: link nodes by pfn before reboot
Date:   Tue, 30 Mar 2021 14:35:42 -0700
Message-Id: <1617140178-8773-8-git-send-email-anthony.yznaga@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1617140178-8773-1-git-send-email-anthony.yznaga@oracle.com>
References: <1617140178-8773-1-git-send-email-anthony.yznaga@oracle.com>
Content-Type: text/plain
X-Originating-IP: [148.87.23.8]
X-ClientProxiedBy: BYAPR11CA0099.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::40) To MN2PR10MB3533.namprd10.prod.outlook.com
 (2603:10b6:208:118::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ca-qasparc-x86-2.us.oracle.com (148.87.23.8) by BYAPR11CA0099.namprd11.prod.outlook.com (2603:10b6:a03:f4::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26 via Frontend Transport; Tue, 30 Mar 2021 21:25:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8cbab8f2-e3c5-476c-47ba-08d8f3c257f3
X-MS-TrafficTypeDiagnostic: MN2PR10MB3357:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR10MB3357A498F0362D3CA3907023EC7D9@MN2PR10MB3357.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VFx8a+KrpvLWopgfain6CYKS10TMOy//BycVXo5CacmIuHSeIJQOANkD6NzH9+ENC1ixlIeQbaCNVMtyb9TqFbHeyzGxR1b94RxIhnY3tp+n+pzYc0CEhv8pLPI+EtT5vDpGeJtStz4XTxv0fqQ9H2/4rxxFlhFez/NZ5yt6VSoMHsW28y1vqJh6Br47MiTrEa7GRk+3CgH46hFQtbEV+2ra2i+nKA1nbnE0QOCW+AXqXr5FJmNCdOkMF1gckpH+Fdqyq0teLW//4CNuEUP/NUWmNXjxrX2XKlz7UsJZETo4eDJwSJb+/oGJFLTPXovyVuu4a9PatwSiLzDrTWn6o2X5p/hBYefV2JYWI06PXcs3yXc/7UEDdpJq+RpKlBsme/cQMLpnL4Eze6PnT7SGYs0v7/Exo1JqOb61Llr3rv7vHY2YptIfuti4OIQqWpqGg9Ed+BiUQotmrz2ni7ONyRHwjnYAl+IZ/UMJ+CFb0lAbDfBAS8h55LaJ195v3Rbk4URWdBXoAPHYZFRV7+swKNymO26N+FhrewqrgwNGTA8p4z9HiuVh6JvLkemRN8NFmQxsL74pAsX4G9yOYPSSNjJ/OFwOW+GBVdejV1nYnW8CMH9zOOVQYenjBSOb6fmhJLS8e3LE2AVwdZQJiyRCEg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB3533.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(346002)(39860400002)(366004)(396003)(2616005)(5660300002)(956004)(6666004)(4326008)(16526019)(66946007)(186003)(44832011)(86362001)(478600001)(7406005)(26005)(38100700001)(8936002)(52116002)(83380400001)(8676002)(7696005)(2906002)(66476007)(66556008)(36756003)(6486002)(316002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?9Vlr0/2PgkPpUU0qcqde04DLi47hAuKHl8LJQYKfwe4a1CM1I/yWz/RUDZIg?=
 =?us-ascii?Q?pWcvmzmn7kys2H6kL2WcpMuzesco+g2YLMFahcsr8NhFjrDAKUfiFY0+reT9?=
 =?us-ascii?Q?V7xOu2vdDDHg/Tnn/u1qOIIL0udtHK9dzcjY6T6M4JrxOCCAfktHS+HQbWou?=
 =?us-ascii?Q?vlX3Tauixtj6kIQ1Ym+532LDVdx3B363c6f81zIxqR7Iif7KGbkG+yhp9iew?=
 =?us-ascii?Q?6lwa7CC8nTrLPfqS5V+wIagBE+AC+zWVPWPC2LyRPInbnNzWyNMCDkv3zAey?=
 =?us-ascii?Q?NUtmjpkVUtAGnd0jDo7skhXEornxtWk+jXHgXPsfKMmFK2lX0cUbCE2+hwBO?=
 =?us-ascii?Q?WGVOgYinPxnW6bTCDtJLzLjSwV6lQP9XkN8U5QyUntkhsQh730RF0o41ebHA?=
 =?us-ascii?Q?h8gQadGn/N+HiCxwcCJi709g+AyU2Mrlh0wBKIfuxH+55crPIBdA/ZgwUXO4?=
 =?us-ascii?Q?B6il5Mc0Mb0LDffDJKOTcY12wpL8L3ICfyr2BmpKn9OBhIJQddBpN3CmOoGI?=
 =?us-ascii?Q?zFkmBsRwAMrY6oSiiP9qrAvs8XrMgR2nGRPIocGD6KKm+dluIaoG6PLE7N5u?=
 =?us-ascii?Q?ZqotofNwk3DNZ6g4ys34921Im95gpzBG+kHeJl4afT60DRXBNv3KFQQwURuN?=
 =?us-ascii?Q?5zBqGUI3RcPQC6oe3dfRT0tRKehSxiqI1BaaEiVC2zsV9Eom9mmyP37c18NQ?=
 =?us-ascii?Q?1iXxPRg7e1pOz/5zTfjVEYBsrT34f1ni9sDFguMgCaWFvscXgIC5t/tI5OBo?=
 =?us-ascii?Q?MXz1Q9qRcRRIQZCWIropg6vKecc10AtorHPqwHhPgXra46oqOKJd62wlice1?=
 =?us-ascii?Q?zcWyUt+PiztTiHr+mseh+KGUk6s5+wb0B6u4uG6p3c++jmZ7F8KZIVUAmi3+?=
 =?us-ascii?Q?tIDIJTBL/esuMbcfJXyCV1HgwY3h4BgnYwYRuLTEiQaNJ6QRv4huXoB2sH40?=
 =?us-ascii?Q?NBjTtZYz/ux0Pw7eHVeCj9pvoozFklYlhh6DLh8iplMu6PphxlEX8F9wpMT+?=
 =?us-ascii?Q?d/0+Dt3938utLQvvp8t7H5FJ+l4AGfKmSf875sN14vDjHsTfLYFYuuX+b4hi?=
 =?us-ascii?Q?N64nTknuhZo04OZy+BzbGFNKHrdQGYQKkusvHOHhg2m0t1XFYqbwk76Ffi9K?=
 =?us-ascii?Q?ehEcPgd5R3dxZrsAaLgk6Elfs+U1DHNI7nctachqqmj21+lkQdtvKZaBkyIe?=
 =?us-ascii?Q?L39cWZVkemnDHTmbsA1aCZ9dMCqRWCZ0wYuzxcr7YG79X0Sy91wkC/zTI/T5?=
 =?us-ascii?Q?sBf11omCim5ctQYcDRy6DYS7p3Mk2lBEwEWHZCA2yA+S7gIZMtYiD0MZ2OJM?=
 =?us-ascii?Q?xtCYdm0uZDb18P2612WDiepc?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cbab8f2-e3c5-476c-47ba-08d8f3c257f3
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB3533.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 21:25:29.9480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pSV0MmixcpdxD2rcgUAE+cDe0j25Ud4Hq6BRreNeAmElVkVB5yTjxpoR6geQQp+ZGFhvLqfoI1ufaB1ejnWukH1l0TIpQH8tH95HAQ0rsAw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3357
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9939 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 spamscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103300000 definitions=main-2103300156
X-Proofpoint-ORIG-GUID: My3yf6FMdkUK03pJEZ61I8lRZOQsyJqW
X-Proofpoint-GUID: My3yf6FMdkUK03pJEZ61I8lRZOQsyJqW
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9939 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0 adultscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103300000
 definitions=main-2103300156
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Since page structs are used for linking PKRAM nodes and cleared
on boot, organize all PKRAM nodes into a list singly-linked by pfns
before reboot to facilitate restoring the node list in the new kernel.

Originally-by: Vladimir Davydov <vdavydov.dev@gmail.com>
Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 mm/pkram.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/mm/pkram.c b/mm/pkram.c
index d81af26c9a66..975f200aef38 100644
--- a/mm/pkram.c
+++ b/mm/pkram.c
@@ -2,12 +2,16 @@
 #include <linux/err.h>
 #include <linux/gfp.h>
 #include <linux/highmem.h>
+#include <linux/init.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/mm.h>
+#include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/notifier.h>
 #include <linux/pkram.h>
+#include <linux/reboot.h>
 #include <linux/sched.h>
 #include <linux/string.h>
 #include <linux/types.h>
@@ -62,11 +66,15 @@ struct pkram_obj {
  * singly-linked list of PKRAM link structures (see above), the node has a
  * pointer to the head of.
  *
+ * To facilitate data restore in the new kernel, before reboot all PKRAM nodes
+ * are organized into a list singly-linked by pfn's (see pkram_reboot()).
+ *
  * The structure occupies a memory page.
  */
 struct pkram_node {
 	__u32	flags;
 	__u64	obj_pfn;	/* points to the first obj of the node */
+	__u64	node_pfn;	/* points to the next node in the node list */
 
 	__u8	name[PKRAM_NAME_MAX];
 };
@@ -75,6 +83,10 @@ struct pkram_node {
 #define PKRAM_LOAD		2
 #define PKRAM_ACCMODE_MASK	3
 
+/*
+ * For convenience sake PKRAM nodes are kept in an auxiliary doubly-linked list
+ * connected through the lru field of the page struct.
+ */
 static LIST_HEAD(pkram_nodes);			/* linked through page::lru */
 static DEFINE_MUTEX(pkram_mutex);		/* serializes open/close */
 
@@ -780,3 +792,41 @@ size_t pkram_read(struct pkram_access *pa, void *buf, size_t count)
 	}
 	return read_count;
 }
+
+/*
+ * Build the list of PKRAM nodes.
+ */
+static void __pkram_reboot(void)
+{
+	struct page *page;
+	struct pkram_node *node;
+	unsigned long node_pfn = 0;
+
+	list_for_each_entry_reverse(page, &pkram_nodes, lru) {
+		node = page_address(page);
+		if (WARN_ON(node->flags & PKRAM_ACCMODE_MASK))
+			continue;
+		node->node_pfn = node_pfn;
+		node_pfn = page_to_pfn(page);
+	}
+}
+
+static int pkram_reboot(struct notifier_block *notifier,
+		       unsigned long val, void *v)
+{
+	if (val != SYS_RESTART)
+		return NOTIFY_DONE;
+	__pkram_reboot();
+	return NOTIFY_OK;
+}
+
+static struct notifier_block pkram_reboot_notifier = {
+	.notifier_call = pkram_reboot,
+};
+
+static int __init pkram_init(void)
+{
+	register_reboot_notifier(&pkram_reboot_notifier);
+	return 0;
+}
+module_init(pkram_init);
-- 
1.8.3.1

