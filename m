Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83DC934F321
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Mar 2021 23:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232877AbhC3V1g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Mar 2021 17:27:36 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:42886 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232641AbhC3V1A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Mar 2021 17:27:00 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12ULOMhL011475;
        Tue, 30 Mar 2021 21:25:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=ys/+06gv3pRz4k4hL35/QbiXotjBjyeNpQ6nps7tU34=;
 b=SOL77G6IO+HlfCTKPrNCCwOwu0OQQ+tCkdrGjSJS3MYQDWuxR+c+CD7057xnyhlJRQxa
 I//0gqirhBpmFyxpnBE5l/kzObEcogOBAq23YnpuFH6jJqQBLs4WtINcxzpvYFfvfRBW
 gtIR5F0c1h+sx32PAxNqJdRIunrP4t4CfaQWdvBR5V0nmQUpX9OtCpfqIVOAP+NT7hVi
 NqIMXVuemdulMXLtns5eNhj+pocJtE5VLoeFNeclyLAnVjV7yPQnmlokHI+5hTFt9hYi
 WEvNlm7bvpWbzO0r6LUlbbb6LveNe7Tlp9FXhGPCp/pr1ON2RRS6f7MQFF2PILYerxd7 LA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 37mab3g8vh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Mar 2021 21:25:42 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12ULObm5149856;
        Tue, 30 Mar 2021 21:25:42 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by userp3020.oracle.com with ESMTP id 37mac4kcx1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Mar 2021 21:25:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KIYHuYJudj/qLQ8ieSJmxHSL8/pwAa44oaQ0P/IrvrXN0KQY/91Um1R+3HqaWOqOzVUpb3pB7q1QHbi+e21eUAB9jiZl0N5WaOa+Ph+T3RbUG7nIb264vwrqcJtJ3ElVZ3iNZVfaK4BvgIyOgpR2xCi0GV0otYNJ7Z2itcIjLUyxs0+ru764MR5YR9Pd/KvA5XqfYuK/USFOo8teIL9Hx9+bS5SGu+T0wdi4IOh1lr0tXCHjluhRTY8QkE+Ket1PNzgvmjKu+3GFL6YwVcKo6ENjzfH0dSUbmHh81TqMmcZIIIl5iDIaZAqxHsqgtTyB+Wztmr7X3aAK1pQ+DCq5IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ys/+06gv3pRz4k4hL35/QbiXotjBjyeNpQ6nps7tU34=;
 b=Yk3LAZWsSMEVQFXnx1DlgGVKG1gr4velt4s/IYyW+NwOhHwMKSNFERrF0z644YGPHs7q8TyrLFSJxfp2Xl2KHcBZq+udQxn43hMjRbQlIeC9bqiMbTxSO3p+X8yWkPSeExoBkfA+Bs0X2bgWgmesgL/BeSvUeNWKyA2mBsIJ127Ox9XZdoxfESrnlpl+u2rL+qAuEDTkvGg/cDfoyRQoiHezYXfwCwxGLdV4oMKWXp0jjaCRIMvoID8Z24NsoKjWM0KGdmJCAYUKLMuIEv8PQhx4sDMLClsUPclGhtgHHEVJfeNxfY19clhu5XgPd2Cfx6Peeo4Ci21e519/zPjaxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ys/+06gv3pRz4k4hL35/QbiXotjBjyeNpQ6nps7tU34=;
 b=Dmb+fpi4wD4zuw66vcQxomkjC+MafBL2cW5E1Sz0yitzCpdLLm9VcSCx6EkF9jzF/4k2lfMkbO07egJpuK0eCrKQ2aq4yqAxFNEerHN2s09IxY1dblmeN/NqKLOPwfJiyTGn2TiIc+wmLXqMpOMZj00ZmK2e8N4VS0lsBbPhzfY=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB3533.namprd10.prod.outlook.com (2603:10b6:208:118::32)
 by MN2PR10MB3613.namprd10.prod.outlook.com (2603:10b6:208:115::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.29; Tue, 30 Mar
 2021 21:25:38 +0000
Received: from MN2PR10MB3533.namprd10.prod.outlook.com
 ([fe80::cc79:c40e:430f:e254]) by MN2PR10MB3533.namprd10.prod.outlook.com
 ([fe80::cc79:c40e:430f:e254%4]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 21:25:38 +0000
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
Subject: [RFC v2 09/43] PKRAM: track preserved pages in a physical mapping pagetable
Date:   Tue, 30 Mar 2021 14:35:44 -0700
Message-Id: <1617140178-8773-10-git-send-email-anthony.yznaga@oracle.com>
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
Received: from ca-qasparc-x86-2.us.oracle.com (148.87.23.8) by BYAPR11CA0099.namprd11.prod.outlook.com (2603:10b6:a03:f4::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26 via Frontend Transport; Tue, 30 Mar 2021 21:25:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d7791852-43e6-48d0-8074-08d8f3c25d19
X-MS-TrafficTypeDiagnostic: MN2PR10MB3613:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR10MB3613011F484E58EB0CDF0517EC7D9@MN2PR10MB3613.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1468;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yb2UGdWaxWxic4lHS+gcxx0xNGi82a5rCCZQAFc6a8IDHLgOhpPYGvnKkXLeJ3vKW7SRPA8o2HI1J3PnfOonMWOkwcySi5utN0F2Xic+cAwK0yzCOyfzgCM5GpExaP2e0HRg63CLHsIRZZ9UnfHn7uJ7CtDBrPYp6ydcSpJxEqER12cPustewuWZnMIjURpOsbHdPRI+PIlYFgU6Psp1aqwUz1KLFVDzSgayCqEQCxhaGtsPnfbBoSB8+7nK4Ur55eK+F+/6/x3KPVoAquUBPiFltv1TE/iaV5tR92c9QLFtwNli8SNgRd5r4dRYQqQTmrhBwa+V8AszrT4z058LmPqm8pu8XwfgjXggfCQMLqCchOJGRzVx3m4eURHU8+OXZjWoI2Aiji/rF919Ue+IVl56uZ9/XAyMieAn5pNXjykZ2tZzWl/Qo5H10MhGX/PxFS/CqTRXVE0Jt7QZ8N1h6s0eLXXvsoZdR74nkkvnVJYs6+gaGACwyUy6PKvOUoLxYN5R0LAHigiBkHWoT7aYa3u9+/nrT41GGcsfBHSOVlDJicA5njr54FvTiP3X0cQfm73BmNhEFqAQzQDPDzOXyJfHfxp63tPAJI+AVX4u6b4c8cb+aJwU3kikdR42qfT2BkMHASMoGmlHA1z+fZB38A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB3533.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(346002)(366004)(396003)(136003)(376002)(8676002)(26005)(44832011)(5660300002)(8936002)(4326008)(7406005)(52116002)(956004)(30864003)(186003)(7416002)(7696005)(6486002)(66476007)(2906002)(16526019)(66946007)(478600001)(38100700001)(36756003)(86362001)(6666004)(66556008)(316002)(83380400001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?SiCYrmtcuaEa/F1G9UIGKcik9TEWpmFKLLjl7V4qnsutI0T1wlQjMQgU8+/8?=
 =?us-ascii?Q?6UPwVqxglV0MX0DvX0CZAAuNtK1GyQLWKz0CwITTiyU9I+iJ2Y093ZNIarI6?=
 =?us-ascii?Q?DbaNX2za4oNHXzDtorBTdiL3/Vc9ntqcNUnIBBCag/Bye2rRPyem/JlDJoM9?=
 =?us-ascii?Q?7b3NkfzufRziHR++Bhz2jENoN4qgrGpjrbr3NmbPxpXP6RVt636a3OJSvwMV?=
 =?us-ascii?Q?bTmZrzt0WhixnXTkuO2KY/t2M78d9UmT3gMVnYYOBFjFcgI1kjMRScJ4Xled?=
 =?us-ascii?Q?XXjsJ+IsOJV25Z/tDqCblSCLtX1SBzlfL4qIHTDyathFDuW3+jExr+tv8BEn?=
 =?us-ascii?Q?Io3AJ0ex/kCp26hrROcjLBhn0zEWPZtIZcV8e9ofJsxrJUKC4ab5IOhfiW1t?=
 =?us-ascii?Q?7qz6ckuBkD0cqeWMhLB5L6a8Yco40M1+17K2V1U1bWkRLQuyPuPqlT6RE36L?=
 =?us-ascii?Q?fBe0VTRqDEd+seTqz4MJPoKO8+2Cmv31PRWQDx0FwlQ0RZIz6cFLZvm6f9Aw?=
 =?us-ascii?Q?uOoMgMq/Q6LD4lDGyn4Go15FLV6j8dW/E2GJb0E/ghV09Z5HR97szQYphUib?=
 =?us-ascii?Q?nLyy8UbRHm/c1im3v7dab5B3j5a6QOdKktgtFAppM8errTga9AI1/+NX8ggx?=
 =?us-ascii?Q?ZrJozIsgkPtCdF+J/3fC6RWCDIjzwWt97X7s07tXFWdZ8t/gOUP1R4c2lefn?=
 =?us-ascii?Q?wdb0vwBnaRNYRyGaAItHQbnKrz5mcKMmKdgL3OsM/6MNcyYmH59BpnXZn9qC?=
 =?us-ascii?Q?Vblretk6QROCCGN1Kz1feHZJE8sA2LQUvEkOMClOOXeH8WsTehMIgxDPFNhE?=
 =?us-ascii?Q?sMvVzNUBDXLySpWG967BRgi1XinKEXbbjZlKel22rpVXgl4LNdlsu3Gkvbqh?=
 =?us-ascii?Q?SaiMQQPKZ7G4Z82tRL9pIw4AiSGhyrFCoYWUtp3CwUKsERojlqPCzZXB3EW0?=
 =?us-ascii?Q?stztv05b/kPrN9C1mas1MMzaIgXq2Q1eJH4KqKq+k4j/5SLutfk3VSmWGI1k?=
 =?us-ascii?Q?1kjUn9VGZKL0vxJSWWc4LWW4Wfc3EdQcDJUxBtZrNnZ517tcAQ0DxrMNdDtj?=
 =?us-ascii?Q?2u2eYH+1QOFA9oBEaU20rIMjt1LT4HKVQlqVKXLJjcD4SDDH63L5gYgq5IBD?=
 =?us-ascii?Q?p1Tdq+gx/mrXB5oyBL8mDQpr9GqhvVdZt5UOBb112ljF31j823XxYYp/RTHb?=
 =?us-ascii?Q?JudtgQHePBZpcVp8YyP6WC5iEe3Jarxp2vbp4WaiO11peOMnl7RV1Peb7a1K?=
 =?us-ascii?Q?CBaZMKshQ5IJEH3BPIxh0aRTuQ8tpvj9/ySb+CVBQUYMk5syj8KTq5loW2gV?=
 =?us-ascii?Q?A2aQI1NQE4kSww/yeHcEoBki?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7791852-43e6-48d0-8074-08d8f3c25d19
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB3533.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 21:25:38.5002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ddLMi5sK2RptwMUGvC9c98IB8rpCCp4KFGJ28/r7Kblwolw+JFZH2G6t+ETixPr3/HoxTFnIPDYj7xsNKMGtM1YAInLmr+pYOdfrY1DXjTE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3613
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9939 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 malwarescore=0 spamscore=0 mlxscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103300000 definitions=main-2103300156
X-Proofpoint-ORIG-GUID: PM7D4WN6LX8NRO0AsWT9UFEq5MOfWWPV
X-Proofpoint-GUID: PM7D4WN6LX8NRO0AsWT9UFEq5MOfWWPV
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9939 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 lowpriorityscore=0
 spamscore=0 priorityscore=1501 phishscore=0 malwarescore=0 suspectscore=0
 clxscore=1015 impostorscore=0 adultscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103300000
 definitions=main-2103300156
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Later patches in this series will need a way to efficiently identify
physically contiguous ranges of preserved pages independent of their
virtual addresses. To facilitate this all pages to be preserved across
kexec are added to a pseudo identity mapping pagetable.

The pagetable makes use of the existing architecture definitions for
building a memory mapping pagetable except that a bitmap is used to
represent the presence or absence of preserved pages at the PTE level.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 mm/Makefile          |   2 +-
 mm/pkram.c           |  30 +++-
 mm/pkram_pagetable.c | 376 +++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 404 insertions(+), 4 deletions(-)
 create mode 100644 mm/pkram_pagetable.c

diff --git a/mm/Makefile b/mm/Makefile
index ab3a724769b5..f5c0dd0a3707 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -120,4 +120,4 @@ obj-$(CONFIG_MEMFD_CREATE) += memfd.o
 obj-$(CONFIG_MAPPING_DIRTY_HELPERS) += mapping_dirty_helpers.o
 obj-$(CONFIG_PTDUMP_CORE) += ptdump.o
 obj-$(CONFIG_PAGE_REPORTING) += page_reporting.o
-obj-$(CONFIG_PKRAM) += pkram.o
+obj-$(CONFIG_PKRAM) += pkram.o pkram_pagetable.o
diff --git a/mm/pkram.c b/mm/pkram.c
index 2809371a9aec..a9e6cd8ca084 100644
--- a/mm/pkram.c
+++ b/mm/pkram.c
@@ -103,6 +103,9 @@ struct pkram_super_block {
 static unsigned long pkram_sb_pfn __initdata;
 static struct pkram_super_block *pkram_sb;
 
+extern int pkram_add_identity_map(struct page *page);
+extern void pkram_remove_identity_map(struct page *page);
+
 /*
  * For convenience sake PKRAM nodes are kept in an auxiliary doubly-linked list
  * connected through the lru field of the page struct.
@@ -121,11 +124,24 @@ static int __init parse_pkram_sb_pfn(char *arg)
 
 static inline struct page *pkram_alloc_page(gfp_t gfp_mask)
 {
-	return alloc_page(gfp_mask);
+	struct page *page;
+	int err;
+
+	page = alloc_page(gfp_mask);
+	if (page) {
+		err = pkram_add_identity_map(page);
+		if (err) {
+			__free_page(page);
+			page = NULL;
+		}
+	}
+
+	return page;
 }
 
 static inline void pkram_free_page(void *addr)
 {
+	pkram_remove_identity_map(virt_to_page(addr));
 	free_page((unsigned long)addr);
 }
 
@@ -163,6 +179,7 @@ static void pkram_truncate_link(struct pkram_link *link)
 		if (!p)
 			continue;
 		page = pfn_to_page(PHYS_PFN(p));
+		pkram_remove_identity_map(page);
 		put_page(page);
 	}
 }
@@ -615,10 +632,15 @@ static int __pkram_save_page(struct pkram_access *pa, struct page *page,
 int pkram_save_file_page(struct pkram_access *pa, struct page *page)
 {
 	struct pkram_node *node = pa->ps->node;
+	int err;
 
 	BUG_ON((node->flags & PKRAM_ACCMODE_MASK) != PKRAM_SAVE);
 
-	return __pkram_save_page(pa, page, page->index);
+	err = __pkram_save_page(pa, page, page->index);
+	if (!err)
+		err = pkram_add_identity_map(page);
+
+	return err;
 }
 
 static int __pkram_bytes_save_page(struct pkram_access *pa, struct page *page)
@@ -652,6 +674,8 @@ static struct page *__pkram_prep_load_page(pkram_entry_t p)
 		prep_transhuge_page(page);
 	}
 
+	pkram_remove_identity_map(page);
+
 	return page;
 }
 
@@ -898,7 +922,7 @@ static int __init pkram_init_sb(void)
 	if (!pkram_sb) {
 		struct page *page;
 
-		page = pkram_alloc_page(GFP_KERNEL | __GFP_ZERO);
+		page = alloc_page(GFP_KERNEL | __GFP_ZERO);
 		if (!page) {
 			pr_err("PKRAM: Failed to allocate super block\n");
 			return 0;
diff --git a/mm/pkram_pagetable.c b/mm/pkram_pagetable.c
new file mode 100644
index 000000000000..9c5443bd7686
--- /dev/null
+++ b/mm/pkram_pagetable.c
@@ -0,0 +1,376 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bitops.h>
+//#include <asm/pgtable.h>
+#include <linux/mm.h>
+
+static pgd_t *pkram_pgd;
+static DEFINE_SPINLOCK(pkram_pgd_lock);
+
+#define set_p4d(p4dp, p4d)	WRITE_ONCE(*(p4dp), (p4d))
+
+#define PKRAM_PTE_BM_BYTES	(PTRS_PER_PTE / BITS_PER_BYTE)
+#define PKRAM_PTE_BM_MASK	(PAGE_SIZE / PKRAM_PTE_BM_BYTES - 1)
+
+static pmd_t make_bitmap_pmd(unsigned long *bitmap)
+{
+	unsigned long val;
+
+	val = __pa(ALIGN_DOWN((unsigned long)bitmap, PAGE_SIZE));
+	val |= (((unsigned long)bitmap & ~PAGE_MASK) / PKRAM_PTE_BM_BYTES);
+
+	return __pmd(val);
+}
+
+static unsigned long *get_bitmap_addr(pmd_t pmd)
+{
+	unsigned long val, off;
+
+	val = pmd_val(pmd);
+	off = (val & PKRAM_PTE_BM_MASK) * PKRAM_PTE_BM_BYTES;
+
+	val = (val & PAGE_MASK) + off;
+
+	return __va(val);
+}
+
+int pkram_add_identity_map(struct page *page)
+{
+	unsigned long paddr;
+	unsigned long *bitmap;
+	unsigned int index;
+	struct page *pg;
+	pgd_t *pgd;
+	p4d_t *p4d;
+	pud_t *pud;
+	pmd_t *pmd;
+
+	if (!pkram_pgd) {
+		spin_lock(&pkram_pgd_lock);
+		if (!pkram_pgd) {
+			pg = alloc_page(GFP_ATOMIC|__GFP_ZERO);
+			if (!pg)
+				goto nomem;
+			pkram_pgd = page_address(pg);
+		}
+		spin_unlock(&pkram_pgd_lock);
+	}
+
+	paddr = __pa(page_address(page));
+	pgd = pkram_pgd;
+	pgd += pgd_index(paddr);
+	if (pgd_none(*pgd)) {
+		spin_lock(&pkram_pgd_lock);
+		if (pgd_none(*pgd)) {
+			pg = alloc_page(GFP_ATOMIC|__GFP_ZERO);
+			if (!pg)
+				goto nomem;
+			p4d = page_address(pg);
+			set_pgd(pgd, __pgd(__pa(p4d)));
+		}
+		spin_unlock(&pkram_pgd_lock);
+	}
+	p4d = p4d_offset(pgd, paddr);
+	if (p4d_none(*p4d)) {
+		spin_lock(&pkram_pgd_lock);
+		if (p4d_none(*p4d)) {
+			pg = alloc_page(GFP_ATOMIC|__GFP_ZERO);
+			if (!pg)
+				goto nomem;
+			pud = page_address(pg);
+			set_p4d(p4d, __p4d(__pa(pud)));
+		}
+		spin_unlock(&pkram_pgd_lock);
+	}
+	pud = pud_offset(p4d, paddr);
+	if (pud_none(*pud)) {
+		spin_lock(&pkram_pgd_lock);
+		if (pud_none(*pud)) {
+			pg = alloc_page(GFP_ATOMIC|__GFP_ZERO);
+			if (!pg)
+				goto nomem;
+			pmd = page_address(pg);
+			set_pud(pud, __pud(__pa(pmd)));
+		}
+		spin_unlock(&pkram_pgd_lock);
+	}
+	pmd = pmd_offset(pud, paddr);
+	if (pmd_none(*pmd)) {
+		spin_lock(&pkram_pgd_lock);
+		if (pmd_none(*pmd)) {
+			if (PageTransHuge(page)) {
+				set_pmd(pmd, pmd_mkhuge(*pmd));
+				spin_unlock(&pkram_pgd_lock);
+				goto done;
+			}
+			bitmap = bitmap_zalloc(PTRS_PER_PTE, GFP_ATOMIC);
+			if (!bitmap)
+				goto nomem;
+			set_pmd(pmd, make_bitmap_pmd(bitmap));
+		} else {
+			BUG_ON(pmd_large(*pmd));
+			bitmap = get_bitmap_addr(*pmd);
+		}
+		spin_unlock(&pkram_pgd_lock);
+	} else {
+		BUG_ON(pmd_large(*pmd));
+		bitmap = get_bitmap_addr(*pmd);
+	}
+
+	index = pte_index(paddr);
+	BUG_ON(test_bit(index, bitmap));
+	set_bit(index, bitmap);
+	smp_mb__after_atomic();
+	if (bitmap_full(bitmap, PTRS_PER_PTE))
+		set_pmd(pmd, pmd_mkhuge(*pmd));
+done:
+	return 0;
+nomem:
+	return -ENOMEM;
+}
+
+void pkram_remove_identity_map(struct page *page)
+{
+	unsigned long *bitmap;
+	unsigned long paddr;
+	unsigned int index;
+	pgd_t *pgd;
+	p4d_t *p4d;
+	pud_t *pud;
+	pmd_t *pmd;
+
+	/*
+	 * pkram_pgd will be null when freeing metadata pages after a reboot
+	 */
+	if (!pkram_pgd)
+		return;
+
+	paddr = __pa(page_address(page));
+	pgd = pkram_pgd;
+	pgd += pgd_index(paddr);
+	if (pgd_none(*pgd)) {
+		WARN_ONCE(1, "PKRAM: %s: no pgd for 0x%lx\n", __func__, paddr);
+		return;
+	}
+	p4d = p4d_offset(pgd, paddr);
+	if (p4d_none(*p4d)) {
+		WARN_ONCE(1, "PKRAM: %s: no p4d for 0x%lx\n", __func__, paddr);
+		return;
+	}
+	pud = pud_offset(p4d, paddr);
+	if (pud_none(*pud)) {
+		WARN_ONCE(1, "PKRAM: %s: no pud for 0x%lx\n", __func__, paddr);
+		return;
+	}
+	pmd = pmd_offset(pud, paddr);
+	if (pmd_none(*pmd)) {
+		WARN_ONCE(1, "PKRAM: %s: no pmd for 0x%lx\n", __func__, paddr);
+		return;
+	}
+	if (PageTransHuge(page)) {
+		BUG_ON(!pmd_large(*pmd));
+		pmd_clear(pmd);
+		return;
+	}
+
+	if (pmd_large(*pmd)) {
+		spin_lock(&pkram_pgd_lock);
+		if (pmd_large(*pmd))
+			set_pmd(pmd, __pmd(pte_val(pte_clrhuge(*(pte_t *)pmd))));
+		spin_unlock(&pkram_pgd_lock);
+	}
+
+	bitmap = get_bitmap_addr(*pmd);
+	index = pte_index(paddr);
+	clear_bit(index, bitmap);
+	smp_mb__after_atomic();
+
+	spin_lock(&pkram_pgd_lock);
+	if (!pmd_none(*pmd) && bitmap_empty(bitmap, PTRS_PER_PTE)) {
+		pmd_clear(pmd);
+		spin_unlock(&pkram_pgd_lock);
+		bitmap_free(bitmap);
+	} else {
+		spin_unlock(&pkram_pgd_lock);
+	}
+}
+
+struct pkram_pg_state {
+	int (*range_cb)(unsigned long base, unsigned long size, void *private);
+	unsigned long start_addr;
+	unsigned long curr_addr;
+	unsigned long min_addr;
+	unsigned long max_addr;
+	void *private;
+	bool tracking;
+};
+
+#define pgd_none(a)  (pgtable_l5_enabled() ? pgd_none(a) : p4d_none(__p4d(pgd_val(a))))
+
+static int note_page(struct pkram_pg_state *st, unsigned long addr, bool present)
+{
+	if (!st->tracking && present) {
+		if (addr >= st->max_addr)
+			return 1;
+		/*
+		 * addr can be < min_addr if the page straddles the
+		 * boundary
+		 */
+		st->start_addr = max(addr, st->min_addr);
+		st->tracking = true;
+	} else if (st->tracking) {
+		unsigned long base, size;
+		int ret;
+
+		/* Continue tracking if upper bound has not been reached */
+		if (present && addr < st->max_addr)
+			return 0;
+
+		addr = min(addr, st->max_addr);
+
+		base = st->start_addr;
+		size = addr - st->start_addr;
+		st->tracking = false;
+
+		ret = st->range_cb(base, size, st->private);
+
+		if (addr == st->max_addr)
+			return 1;
+		else
+			return ret;
+	}
+
+	return 0;
+}
+
+static int walk_pte_level(struct pkram_pg_state *st, pmd_t addr, unsigned long P)
+{
+	unsigned long *bitmap;
+	int present;
+	int i, ret;
+
+	bitmap = get_bitmap_addr(addr);
+	for (i = 0; i < PTRS_PER_PTE; i++) {
+		unsigned long curr_addr = P + i * PAGE_SIZE;
+
+		if (curr_addr < st->min_addr)
+			continue;
+		present = test_bit(i, bitmap);
+		ret = note_page(st, curr_addr, present);
+		if (ret)
+			break;
+	}
+
+	return ret;
+}
+
+static int walk_pmd_level(struct pkram_pg_state *st, pud_t addr, unsigned long P)
+{
+	pmd_t *start;
+	int i, ret;
+
+	start = (pmd_t *)pud_page_vaddr(addr);
+	for (i = 0; i < PTRS_PER_PMD; i++, start++) {
+		unsigned long curr_addr = P + i * PMD_SIZE;
+
+		if (curr_addr + PMD_SIZE <= st->min_addr)
+			continue;
+		if (!pmd_none(*start)) {
+			if (pmd_large(*start))
+				ret = note_page(st, curr_addr, true);
+			else
+				ret = walk_pte_level(st, *start, curr_addr);
+		} else
+			ret = note_page(st, curr_addr, false);
+		if (ret)
+			break;
+	}
+
+	return ret;
+}
+
+static int walk_pud_level(struct pkram_pg_state *st, p4d_t addr, unsigned long P)
+{
+	pud_t *start;
+	int i, ret;
+
+	start = (pud_t *)p4d_page_vaddr(addr);
+	for (i = 0; i < PTRS_PER_PUD; i++, start++) {
+		unsigned long curr_addr = P + i * PUD_SIZE;
+
+		if (curr_addr + PUD_SIZE <= st->min_addr)
+			continue;
+		if (!pud_none(*start)) {
+			if (pud_large(*start))
+				ret = note_page(st, curr_addr, true);
+			else
+				ret = walk_pmd_level(st, *start, curr_addr);
+		} else
+			ret = note_page(st, curr_addr, false);
+		if (ret)
+			break;
+	}
+
+	return ret;
+}
+
+static int walk_p4d_level(struct pkram_pg_state *st, pgd_t addr, unsigned long P)
+{
+	p4d_t *start;
+	int i, ret;
+
+	if (PTRS_PER_P4D == 1)
+		return walk_pud_level(st, __p4d(pgd_val(addr)), P);
+
+	start = (p4d_t *)pgd_page_vaddr(addr);
+	for (i = 0; i < PTRS_PER_P4D; i++, start++) {
+		unsigned long curr_addr = P + i * P4D_SIZE;
+
+		if (curr_addr + P4D_SIZE <= st->min_addr)
+			continue;
+		if (!p4d_none(*start)) {
+			if (p4d_large(*start))
+				ret = note_page(st, curr_addr, true);
+			else
+				ret = walk_pud_level(st, *start, curr_addr);
+		} else
+			ret = note_page(st, curr_addr, false);
+		if (ret)
+			break;
+	}
+
+	return ret;
+}
+
+void pkram_walk_pgt(struct pkram_pg_state *st, pgd_t *pgd)
+{
+	pgd_t *start = pgd;
+	int i, ret = 0;
+
+	for (i = 0; i < PTRS_PER_PGD; i++, start++) {
+		unsigned long curr_addr = i * PGDIR_SIZE;
+
+		if (curr_addr + PGDIR_SIZE <= st->min_addr)
+			continue;
+		if (!pgd_none(*start))
+			ret = walk_p4d_level(st, *start, curr_addr);
+		else
+			ret = note_page(st, curr_addr, false);
+		if (ret)
+			break;
+	}
+}
+
+void pkram_find_preserved(unsigned long start, unsigned long end, void *private, int (*callback)(unsigned long base, unsigned long size, void *private))
+{
+	struct pkram_pg_state st = {
+		.range_cb = callback,
+		.min_addr = start,
+		.max_addr = end,
+		.private = private,
+	};
+
+	if (!pkram_pgd)
+		return;
+
+	pkram_walk_pgt(&st, pkram_pgd);
+}
-- 
1.8.3.1

