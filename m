Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 620E034F303
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Mar 2021 23:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232784AbhC3V1Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Mar 2021 17:27:25 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:60778 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232492AbhC3V0y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Mar 2021 17:26:54 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12ULPchp123355;
        Tue, 30 Mar 2021 21:25:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=zbgaaTx5IAoRKIXeSokkLnV7PhXDVAA2+4m3frQC38Y=;
 b=fAuArSYhZ/0njqM0/xhwEQmh4ItI4T4pbNiTvshbbXDTwzmuELrfdc3mZVUZbOVKEdIY
 3JQcP3t4QDs/96l289WlXmgig3acWTAP4fI9sgN1W6TmIszKh5cJAVXMJ7KbLW3AoKID
 vDpSegCwuYFuQNUYszcZwZcyJkQWoQ9RQil9y192C38tzGw5t6QKGgzw443ph+W4HJRF
 01H8G5YyAT23Arx4syAKL9KMU/bu/AirtRS+li3Rl66mUWW0YJBx0R6PQnkG+FmXYZVF
 OJKS1SVIWiXBX8kVljcAkk+n/ZM3GAFHYWVa0G85LC4Linr0fBJdWmpIQ5Qs+OA/tFhS vw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 37mafv081t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Mar 2021 21:25:38 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12ULOnNn184112;
        Tue, 30 Mar 2021 21:25:38 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by aserp3020.oracle.com with ESMTP id 37mac7u434-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Mar 2021 21:25:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bgNL0vl7ZldyPsNdB1PMN2PD6styoePsPX056HiO6tn6p3orkTqm9zZJvc2a4yptdCGdZ3hs6Un73rcuoO1noJ7W1KFYcaRTqBzFRRxT0kw93uCCU4etc1lxTyzTu8nUO5h5FuJlcWD/RIT/Lz1Um0sXBvUJFSE3/4YsTJGBxUossGiqsNTMZBkmQCmOIXEY2ecGtMQVsp6SDnseU+kTDPS+IPr5duRoGSwOX/e87nT1nAkhrCzI5ml99rK0nze66MRi5mHiJ18c2y2MS22lN1LJFHTWAITix9YKTxywfdk+DP5fB1vkqxPsyt27KMr7JJRQhYbRETn26ECnjgmo0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zbgaaTx5IAoRKIXeSokkLnV7PhXDVAA2+4m3frQC38Y=;
 b=IQwBNOHz+251A5TaIpgy6CdJcSpx8eCVxM/V2pltt/geuQYPF/WGBuuRJAlNDMuyDn1xsxIlF6wCiSOqFDcFRGaZTs1HdQGu8yJitoHUwqG3Glfc9lurrZsWgvCAuaNf1m3WbddjaYHi4akSH8gXiz8a+6APDiEAp9M15whauO85xZYyZcxd9uljTsuY/wLtMAlNTSaCnSPpo13xycMAYNbkv91u9pcdnzKq1aJdOY7HcVZIVOGzr/pLD/JsylOBddwUrLsbrBS/FSaUzJU9Jguyc/c+OSu9PZNHzBZncpUj422P6tRfB1mrrGEEcpwoy3Vmk4rET6vgqtMizaJH0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zbgaaTx5IAoRKIXeSokkLnV7PhXDVAA2+4m3frQC38Y=;
 b=Q6uLLZpuUzxxUJ7Mlk07EnsQc0Vm79PB4ggFWzMNAP4Xw7N1FuYNLDiZGtjTtGZG/pFrAIxZMN9ZT+072RpQLyo49iLqt5UC+aGxu+Yay0zB0euZSuyka3b9RMf7W5UQsNqC1dkJC6/YbcneSS+RsFzh8mm3n44EI77x3t7H7x4=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB3533.namprd10.prod.outlook.com (2603:10b6:208:118::32)
 by MN2PR10MB3613.namprd10.prod.outlook.com (2603:10b6:208:115::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.29; Tue, 30 Mar
 2021 21:25:34 +0000
Received: from MN2PR10MB3533.namprd10.prod.outlook.com
 ([fe80::cc79:c40e:430f:e254]) by MN2PR10MB3533.namprd10.prod.outlook.com
 ([fe80::cc79:c40e:430f:e254%4]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 21:25:34 +0000
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
Subject: [RFC v2 08/43] mm: PKRAM: introduce super block
Date:   Tue, 30 Mar 2021 14:35:43 -0700
Message-Id: <1617140178-8773-9-git-send-email-anthony.yznaga@oracle.com>
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
Received: from ca-qasparc-x86-2.us.oracle.com (148.87.23.8) by BYAPR11CA0099.namprd11.prod.outlook.com (2603:10b6:a03:f4::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26 via Frontend Transport; Tue, 30 Mar 2021 21:25:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 11bc6d82-2e77-4ce4-eef8-08d8f3c25a85
X-MS-TrafficTypeDiagnostic: MN2PR10MB3613:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR10MB361344F44AE04EDF3D731CF4EC7D9@MN2PR10MB3613.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FjAuyE4Tm6FVyUJ6CUgKkl8pjEnBVJhEq/E+VavbW6RwkjSdNyRWKG02F3r/mAqE000M37E7bdJhgnxRIem7UHwvBZy+GnlmurTNeM1DDn1qFHXdFOEfpLIIcfR5T5zEe/DGXRw6aMtmcwYcjVSa9AXJ8kYFF5vze1fmJ1rkXsSVyf77LtQJT9oyZ07PCb6nEAAB1WEN8arnvztE20cFAc4dc0kM3qnfsvgEYStbvl696+vSvp/2du0WNtbSmPFoQ5JpFz+nRjiImnkTe/MM/Pct0R4G/Dd9WiSPZL5wlywr10EUhlU13wceww+dZ/hKZ3Bi3YyVi/HVyQ7CQl+sc3uWO45JFy5EaLEBiXJYmz87aOw8rgRlqMb/EdarVWFaLNjJtlzRzZmwv6ooTWVSbr4Afq6xaUnc5yW75rTbh3dQ9Ni39QfkB4uFghPaL8s2hDIoVWX6ijBnypvCrF7xxIH7siiKYhcjGVDAfgJxtjXc1/p8p0vKb6/kms5/UNMwFxv4i0CDF0z2QzT9n1o87VvT8+v4c6SOPqlwQ14yJU0DJD0NmLuvTnyi12BVe2D62UzD04qnMbDpNQ3zXEhPpMOQa+AIUeAdxKMAyPMWbOEOiIhD1gmZB2Tvz93dgm2Xn6mBrtEfVcgvJXaTn2+q7J0I0IR+lTyfcEPhRay7LQE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB3533.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(346002)(366004)(396003)(136003)(376002)(8676002)(26005)(44832011)(5660300002)(8936002)(4326008)(7406005)(52116002)(956004)(186003)(7416002)(7696005)(6486002)(66476007)(2906002)(16526019)(66946007)(478600001)(38100700001)(36756003)(86362001)(6666004)(66556008)(316002)(83380400001)(2616005)(134885004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?xef5jTi0Ql4g5jbOdmnrSP7ufNtB4VWJoprUt/wKxjSs2v1HU1/az6wnwiiF?=
 =?us-ascii?Q?YeiJ1m/yHteh7s+PuCAVc+FtgtRJRt4bJ+LR/JIjeI3d5BE3wAZaTrsqX5ub?=
 =?us-ascii?Q?kICqkO5bNcRTqfOeyExtvm19r0s3wzlmkpMJlI+UOT3WA8OdXNo3hhlWiEOK?=
 =?us-ascii?Q?bo1CZiydpMgGBAVyGTFdaL0p+27ajqkvdasPeXqoEkD5DTRfdMyR35M9bOO5?=
 =?us-ascii?Q?f98RBn8O3ZwRyyazjXO2TAlLkhLm0+V4H5qXMouVS84cHWgiFQ1ozVSR7LFW?=
 =?us-ascii?Q?sNseNzzlt+h1X3O3T192T23psidgnBcZYvwP6F2KDTTZIBL0zd6Ew6Ai9k/C?=
 =?us-ascii?Q?VBMlrnTzT0B6Zg9Ur1C69UKtluMmLFHP23oNaS+nSOTZnJXUGp/tzNQY+tEs?=
 =?us-ascii?Q?qPQFzyzTx8KzBc4W5fixSakw8RzaUZhUnFKt0lkFNM8MbHSB5lk6ft0tN/5T?=
 =?us-ascii?Q?O+vzaE8cniCDVekGj4KalEirNLpg4brCTyhy3AAQvC/FtZOkCNpiafFpUZeu?=
 =?us-ascii?Q?ABQAx3RZ+Uf4/hh9GClJl12fdzGhQHk3vaFJAKDa3HBsv89G16u4MmX0LXT+?=
 =?us-ascii?Q?WDAthNceNmz6GBvGz5A3+WB3BLSREleTx/ufbeP3b/FvLgXYV+mIBB9asmTY?=
 =?us-ascii?Q?WmjAc9ZQ5LMvs7sHQoemRZA31xnCnSsZApuwxCXCE97hkgQnGbbQG/iQ7ZtT?=
 =?us-ascii?Q?+Z7fwnEYYHPGKqE6Nv45PgQKVVcQeTZqFALONX+Ub34a9/w19Tpk+S1RJ0V1?=
 =?us-ascii?Q?qv08cRHfoe+Wn7QdGCl8RZg3ulYto8oN3mZDOFcKMzZ5oYxOO0GrXhHQPiT9?=
 =?us-ascii?Q?jDH6kQu1b+DYo3RkdSl4SVZxVqIABYO7swdFoUbWjZOXxni9jZmRiWXfZ71h?=
 =?us-ascii?Q?NE6Zrvp0CY5H3Jj202J/SrI/OoSfRmpuXo4WoR7l9cGwmxklTfMTwQYI9FGG?=
 =?us-ascii?Q?EbN60KVgH/P2jtwww8FjTAWGrnIvJ3Yg5Em2B7YjF0q0JkYB1iaGrMo/b9hj?=
 =?us-ascii?Q?dKyxadNzQggsAHINb0TAVKuD0ORToOm8v/OV2hAp1IU+bOne/ssOhTtoU+ul?=
 =?us-ascii?Q?7m4+xQpUUsweEaluc+2lDA2zMCMXZNdHAtU2Z09nK4cmrt7Ft11veqiOdIEq?=
 =?us-ascii?Q?tSTl69+YqZgR+nx/REIA/W/ydUQ3edMxh7RvpvIWVX8BldPmIad487NoVlUu?=
 =?us-ascii?Q?NCu3dqrE3fzrgvEoeHzvVrm3xRlhaC6Sgr8NPLGIfsJ+D8AevQkwZHQgdgD1?=
 =?us-ascii?Q?4/oM4oVxbNnVdBLKpuLSblwQXyIeMMqSoxbQiIVD0lMEkmwQzYpmKuLYBtYD?=
 =?us-ascii?Q?IsdWO14f5uye4ZP1QogWzbui?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11bc6d82-2e77-4ce4-eef8-08d8f3c25a85
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB3533.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 21:25:34.2756
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /hccKn7CWbUJNMdnFma1E+85dLoZxHwH1755RMzlX0AwHQIAY/W2ByyV4A+b4kbXiVjkVyXyZTKre6Agi7u2d0l6r807mZZpel7cN20exvo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3613
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9939 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 spamscore=0 malwarescore=0 phishscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103300000
 definitions=main-2103300156
X-Proofpoint-ORIG-GUID: eIYn0ncoyUl9EbS0Gl3kLgYIW0fZg6LE
X-Proofpoint-GUID: eIYn0ncoyUl9EbS0Gl3kLgYIW0fZg6LE
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9939 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 adultscore=0
 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 mlxlogscore=999
 priorityscore=1501 phishscore=0 malwarescore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103300000
 definitions=main-2103300156
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The PKRAM super block is the starting point for restoring preserved
memory. By providing the super block to the new kernel at boot time,
preserved memory can be reserved and made available to be restored.
To point the kernel to the location of the super block, one passes
its pfn via the 'pkram' boot param. For that purpose, the pkram super
block pfn is exported via /sys/kernel/pkram. If none is passed, any
preserved memory will not be kept, and a new super block will be
allocated.

Originally-by: Vladimir Davydov <vdavydov.dev@gmail.com>
Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 mm/pkram.c | 102 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 100 insertions(+), 2 deletions(-)

diff --git a/mm/pkram.c b/mm/pkram.c
index 975f200aef38..2809371a9aec 100644
--- a/mm/pkram.c
+++ b/mm/pkram.c
@@ -5,15 +5,18 @@
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
+#include <linux/kobject.h>
 #include <linux/list.h>
 #include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/notifier.h>
+#include <linux/pfn.h>
 #include <linux/pkram.h>
 #include <linux/reboot.h>
 #include <linux/sched.h>
 #include <linux/string.h>
+#include <linux/sysfs.h>
 #include <linux/types.h>
 
 #include "internal.h"
@@ -84,12 +87,38 @@ struct pkram_node {
 #define PKRAM_ACCMODE_MASK	3
 
 /*
+ * The PKRAM super block contains data needed to restore the preserved memory
+ * structure on boot. The pointer to it (pfn) should be passed via the 'pkram'
+ * boot param if one wants to restore preserved data saved by the previously
+ * executing kernel. For that purpose the kernel exports the pfn via
+ * /sys/kernel/pkram. If none is passed, preserved memory if any will not be
+ * preserved and a new clean page will be allocated for the super block.
+ *
+ * The structure occupies a memory page.
+ */
+struct pkram_super_block {
+	__u64	node_pfn;		/* first element of the node list */
+};
+
+static unsigned long pkram_sb_pfn __initdata;
+static struct pkram_super_block *pkram_sb;
+
+/*
  * For convenience sake PKRAM nodes are kept in an auxiliary doubly-linked list
  * connected through the lru field of the page struct.
  */
 static LIST_HEAD(pkram_nodes);			/* linked through page::lru */
 static DEFINE_MUTEX(pkram_mutex);		/* serializes open/close */
 
+/*
+ * The PKRAM super block pfn, see above.
+ */
+static int __init parse_pkram_sb_pfn(char *arg)
+{
+	return kstrtoul(arg, 16, &pkram_sb_pfn);
+}
+early_param("pkram", parse_pkram_sb_pfn);
+
 static inline struct page *pkram_alloc_page(gfp_t gfp_mask)
 {
 	return alloc_page(gfp_mask);
@@ -275,6 +304,7 @@ static void pkram_stream_init(struct pkram_stream *ps,
  * @gfp_mask specifies the memory allocation mask to be used when saving data.
  *
  * Error values:
+ *	%ENODEV: PKRAM not available
  *	%ENAMETOOLONG: name len >= PKRAM_NAME_MAX
  *	%ENOMEM: insufficient memory available
  *	%EEXIST: node with specified name already exists
@@ -290,6 +320,9 @@ int pkram_prepare_save(struct pkram_stream *ps, const char *name, gfp_t gfp_mask
 	struct pkram_node *node;
 	int err = 0;
 
+	if (!pkram_sb)
+		return -ENODEV;
+
 	if (strlen(name) >= PKRAM_NAME_MAX)
 		return -ENAMETOOLONG;
 
@@ -410,6 +443,7 @@ void pkram_discard_save(struct pkram_stream *ps)
  * Returns 0 on success, -errno on failure.
  *
  * Error values:
+ *	%ENODEV: PKRAM not available
  *	%ENOENT: node with specified name does not exist
  *	%EBUSY: save to required node has not finished yet
  *
@@ -420,6 +454,9 @@ int pkram_prepare_load(struct pkram_stream *ps, const char *name)
 	struct pkram_node *node;
 	int err = 0;
 
+	if (!pkram_sb)
+		return -ENODEV;
+
 	mutex_lock(&pkram_mutex);
 	node = pkram_find_node(name);
 	if (!node) {
@@ -809,6 +846,13 @@ static void __pkram_reboot(void)
 		node->node_pfn = node_pfn;
 		node_pfn = page_to_pfn(page);
 	}
+
+	/*
+	 * Zero out pkram_sb completely since it may have been passed from
+	 * the previous boot.
+	 */
+	memset(pkram_sb, 0, PAGE_SIZE);
+	pkram_sb->node_pfn = node_pfn;
 }
 
 static int pkram_reboot(struct notifier_block *notifier,
@@ -816,7 +860,8 @@ static int pkram_reboot(struct notifier_block *notifier,
 {
 	if (val != SYS_RESTART)
 		return NOTIFY_DONE;
-	__pkram_reboot();
+	if (pkram_sb)
+		__pkram_reboot();
 	return NOTIFY_OK;
 }
 
@@ -824,9 +869,62 @@ static int pkram_reboot(struct notifier_block *notifier,
 	.notifier_call = pkram_reboot,
 };
 
+static ssize_t show_pkram_sb_pfn(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	unsigned long pfn = pkram_sb ? PFN_DOWN(__pa(pkram_sb)) : 0;
+
+	return sprintf(buf, "%lx\n", pfn);
+}
+
+static struct kobj_attribute pkram_sb_pfn_attr =
+	__ATTR(pkram, 0444, show_pkram_sb_pfn, NULL);
+
+static struct attribute *pkram_attrs[] = {
+	&pkram_sb_pfn_attr.attr,
+	NULL,
+};
+
+static struct attribute_group pkram_attr_group = {
+	.attrs = pkram_attrs,
+};
+
+/* returns non-zero on success */
+static int __init pkram_init_sb(void)
+{
+	unsigned long pfn;
+	struct pkram_node *node;
+
+	if (!pkram_sb) {
+		struct page *page;
+
+		page = pkram_alloc_page(GFP_KERNEL | __GFP_ZERO);
+		if (!page) {
+			pr_err("PKRAM: Failed to allocate super block\n");
+			return 0;
+		}
+		pkram_sb = page_address(page);
+	}
+
+	/*
+	 * Build auxiliary doubly-linked list of nodes connected through
+	 * page::lru for convenience sake.
+	 */
+	pfn = pkram_sb->node_pfn;
+	while (pfn) {
+		node = pfn_to_kaddr(pfn);
+		pkram_insert_node(node);
+		pfn = node->node_pfn;
+	}
+	return 1;
+}
+
 static int __init pkram_init(void)
 {
-	register_reboot_notifier(&pkram_reboot_notifier);
+	if (pkram_init_sb()) {
+		register_reboot_notifier(&pkram_reboot_notifier);
+		sysfs_update_group(kernel_kobj, &pkram_attr_group);
+	}
 	return 0;
 }
 module_init(pkram_init);
-- 
1.8.3.1

