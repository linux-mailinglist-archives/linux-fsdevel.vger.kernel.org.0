Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A952634F32A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Mar 2021 23:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232896AbhC3V1i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Mar 2021 17:27:38 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:50866 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232636AbhC3V1A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Mar 2021 17:27:00 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12ULP4ob145272;
        Tue, 30 Mar 2021 21:25:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=sK0+kX48zyKrc5O2jB5SJhTBEc3qU76zrUCMJUFl03Y=;
 b=xHhR6d6nQsLVaxBawJD5zMHg1xZreANZojqmD2mUUb6npmTtWt+yTcoyz+HoVrkWIttx
 uXJPDPRmgrYg8fpeg6BxfLImmd2Sn5tqlP+cWauVjALUn9POWoWwYCaOja2cCXf6gyp8
 M+cbrpaSRsu/mFsnHiC0UvG5BmpSsCvmhkwxWK7cEEmhsz/+Im4rP6y99YYeBPrxLUEU
 er5F4PI4FtXSpOoYHLogD7flMFVkGqOlN1WkBHdI0KZ+oPBvMt2db3jzGnLuvB0RQKQm
 vt1H+pOI66W4xttL071bh8pQTFv1oFkfA4omugUd8Uj3fyde3+o/DRJvGZ4mHVP37Z96 sw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 37mad9r8en-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Mar 2021 21:25:46 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12ULOasw149688;
        Tue, 30 Mar 2021 21:25:45 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by userp3020.oracle.com with ESMTP id 37mac4kd23-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Mar 2021 21:25:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eFKUdrzP6VSwPriPv6mUQFJXns6GWGNM0V43jpZCElbOv+tTGjfaNiBHsV1GfH/Gu8GYwqvog5RpY6xrJCnKmZbRxGXbIFFt+fqctNLGkloxRt4AWYOAx5Sl+oSIsdJcA18z9hIyu3W8tXaLTOBskhJ5ewrDXL+cqV9Td0Mp7c4f03zFv0DqcbB2msaRVtC7wdjvX3GoZr3zxv6NdoTXTR/nuvEL0RhbrlvSi8Kf3Pjeo350Az3d7ojyfF4p+WFNIYhvLdFOtxdzfrJu4NVGeWTEMVMV8LekQzpXWEAIgejRzKfYOBPJ3OTnY30sM339OEmNdVsufHZ9KzVGl4BVDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sK0+kX48zyKrc5O2jB5SJhTBEc3qU76zrUCMJUFl03Y=;
 b=SUckduC53kdsmvRAR2pdpdVThl8oKiY0clG4jXQl0Ctuc0BW9f+aTGOscM7xZzgXUbskWMzn21bxj0Nvo7vRARZoZo7pll7VyOeoWCW5ewMTnG75mfnCew83NHO/ww9JBj8Khp2zzwuhfQCSBVjcFOZiEcyNSw7190Pqup60p9hyIoz8PHcFPwwdbA8TgVu56shjFAF1HXR1k77KrBf3oLmheHBBuSfZK1AgPjVmisDppMm10VgZgiYDLP9tY13V6uNbsT5DmHm2UtknZk4kMrXUQcGtnjJX08VbbXUBcnbABRfIE/SRGSm7Tolq1AX7I6ie/7qV8+GByIEpj3FkbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sK0+kX48zyKrc5O2jB5SJhTBEc3qU76zrUCMJUFl03Y=;
 b=FVoanjandHOy3oIvNB3bPsR6CbqjHx7K00TawVWBV+pKetYL5d9rC5kIKhAciiEjrqmP3Y0UbJbRz550oVsrOo3pjXo69ktBm0m4yym1YBOWfrXhZI0XNk1UxTlBjMidFHS5ywx5ggmuzmRUQ/AMPJ7nBUkLhlcb7IToCY154KM=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB3533.namprd10.prod.outlook.com (2603:10b6:208:118::32)
 by MN2PR10MB3613.namprd10.prod.outlook.com (2603:10b6:208:115::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.29; Tue, 30 Mar
 2021 21:25:42 +0000
Received: from MN2PR10MB3533.namprd10.prod.outlook.com
 ([fe80::cc79:c40e:430f:e254]) by MN2PR10MB3533.namprd10.prod.outlook.com
 ([fe80::cc79:c40e:430f:e254%4]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 21:25:42 +0000
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
Subject: [RFC v2 10/43] PKRAM: pass a list of preserved ranges to the next kernel
Date:   Tue, 30 Mar 2021 14:35:45 -0700
Message-Id: <1617140178-8773-11-git-send-email-anthony.yznaga@oracle.com>
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
Received: from ca-qasparc-x86-2.us.oracle.com (148.87.23.8) by BYAPR11CA0099.namprd11.prod.outlook.com (2603:10b6:a03:f4::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26 via Frontend Transport; Tue, 30 Mar 2021 21:25:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 83c2a063-b13c-4c74-5cc4-08d8f3c25f9d
X-MS-TrafficTypeDiagnostic: MN2PR10MB3613:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR10MB3613400718311B6038E6F86EEC7D9@MN2PR10MB3613.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pC9EMlPEER2Pr2zpc+tiQnmD/d4d/bOTojvE5qlTGIq12L/Nfth/OCtStGM9RVrUpMAUI0LiH+BMZMmNr9NurOul/Yh7g+AP7oMt0QK3XKIbeERfPzqJtXBvlj/BRjr831NzWLmGLyZz+aF3JcYwtB2PF4Y/5YYP0RzxVzDaMpylhRhVtR1fvf2x0VEk+qUufVPKhTHxjvNkDGPxsxyDMy9FDHjBgrrDhEVmq7iP/4HcgRiTB95HbssdJf/ZEGD22zVoUtWBgvjgTadYeTQZtCouwzdlrshiOwGZOOD6VSYhSx93BkHSIquVsHt37cTT7J2UF7ANm46J21C++R0fVxzfSHII9Mmvn5AGFcIXl+0W192qfHI/06SA+XnYmHcz8WZZ0JjR5XlH7LFXse2rdW1XeS8RKz0AyB8S5tdmPYJnK+gzN0J+vvl4a45/3nO69UfMcode4Bg79KxUaAQ1l03rsV0hlbZ+tYAQG0zpur/C44IjU9xpiX6Pb6xE56z9S99cPNKk6nFAVxfM7jP3QHiNSPRGnTXsFFhX9zN136nHrHakx/sgTocYHosCKMU4hN0VcU+ZH7J6jDRxV2xPLkNWgVEnxZtmENuqbH/qsAM5WEn+mA1Aqjl6i2d5SCgpo5yNWpLkoNWcO91+Ua1HuQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB3533.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(346002)(366004)(396003)(136003)(376002)(8676002)(26005)(44832011)(5660300002)(8936002)(4326008)(7406005)(52116002)(956004)(186003)(7416002)(7696005)(6486002)(66476007)(2906002)(16526019)(66946007)(478600001)(38100700001)(36756003)(86362001)(6666004)(66556008)(316002)(83380400001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?I2fl42ClRvZJRdAWpmpQh2iiOg+UPP82EqZVErQAj8BHuL3IE9fsl//D7uZ/?=
 =?us-ascii?Q?xFUBiSNxC896axp4eSej34Bxk6hwKxbRqdYrgspUCs/j/XFXEIKC3sSd+Mat?=
 =?us-ascii?Q?YK5D5T+QKMdSJRdPei+GgrH+Divjo687PpksmATjmF0uatpO1g3f0UIZOcUY?=
 =?us-ascii?Q?zZE6PogY5jOKasToUvaFdjYDLR8de7H0iI0EdvQoYodUpFR23/3nXz+JzzxP?=
 =?us-ascii?Q?v6qSLIK51tL2OPUaRUc4PKoOI5fp4vdTqHF8zqNlYpPF1Ty22jyh1sXkcsKv?=
 =?us-ascii?Q?36YCU83uNUxvZeQX3ExthT9iWBxyO5oyfbWVp89efUVSW2v//ExjK2AZIL18?=
 =?us-ascii?Q?BWpcX2krU/FNO61+GzuNyA8OU2PFA8n3qOi1dH7XV1srRpekm1D1TJ7xJfZs?=
 =?us-ascii?Q?no8cBobDBcQAlIuRlGnnJV/QpumwMwVi3B6KTwGL093dLxseJSsHpNSs78QC?=
 =?us-ascii?Q?duta6IXlCkAuCSAudu8Ct5Z5V4KrxTNwBsPSI29QVoZPXDHjtshX8QPnr6lb?=
 =?us-ascii?Q?MBjQFgf2DkI/9jGIYDT5ElPxjpx/hHoXBAweoaLMm0WycLIqLM45wIe8D/Ss?=
 =?us-ascii?Q?C71oX0TGK0dbndJ6dd0YX3pzjgxayeEXEyuJP5f6YBZtfXkEENOD3Dm2Dw+G?=
 =?us-ascii?Q?76Gn9bBPJ5MrZrj7WNW1AnJLb+41KOWXTvDCzg5PR8YdKYhK+Q9NJhO73oB5?=
 =?us-ascii?Q?2vUYp6xhqnSbu9gNRIV9lttFXxGRZyWBjQvYJFKL4Hw43A8475dcG01PvjGk?=
 =?us-ascii?Q?OOih41VB6AuMfVfyTMA9imogiFUrBZkMKTB/0V8KVxrfi/Hcc5X0WEwmGUM9?=
 =?us-ascii?Q?2SORNaFEKkloVlYOrJJSj+HZsPASgjw4am4ysvb95WehYb0QpzQ+WswqfI6q?=
 =?us-ascii?Q?x+GAdv0dJkmLZv6Q4lERVO6twnjTvotoD6+XYg5+hvg7U3YixxR2Ulif7K0p?=
 =?us-ascii?Q?LW2j6yPXhofh5TBz1uozjscHc8I3QQMSKa9fhP4oioixO2rrU/lM9ZBN2NDM?=
 =?us-ascii?Q?9lFN32jFJMttVKv9g/hG7AWdIrA6+N/UXewvYXzOD7YAVcE+h6go2Azq/1F3?=
 =?us-ascii?Q?pJ3rKW/aJkWwaOSsyOTRgZuv/+twNAwEkzg5PYVmw+VFRdHmxzDzmO89UqSN?=
 =?us-ascii?Q?DCyc5OxA57jejElm+L4lI3muBVgVdbvzzNpsHV+iJd81NXPM2SIF/KJLUSb9?=
 =?us-ascii?Q?rqN34xsSSFTR+rynjuj7wgc8ymPxjSIoeMwxNpUw5e22DixBjnM0AwASW+HU?=
 =?us-ascii?Q?C7WWQyfE9Smt1duWSZ+OBNA+AYJXjxHc8nx2lTBzgK5/pv+PzeRfBRJP2KGw?=
 =?us-ascii?Q?WQIibQpiufHWwDnqgdx4KB3f?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83c2a063-b13c-4c74-5cc4-08d8f3c25f9d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB3533.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 21:25:42.7757
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YOZ0qbY8YHHG0lleKe3U0aWcg4g6rUT8ck1nFYiAEUv94sCc0cZVsgp7xtIMtwPEMo+glilq3s44tj68iVCOgpMBVdR1whJ7Zcf7h2WZCG4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3613
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9939 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 malwarescore=0 spamscore=0 mlxscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103300000 definitions=main-2103300156
X-Proofpoint-ORIG-GUID: PQ_3p6rZNQQPFETrM5UOYB9qLkQavGnj
X-Proofpoint-GUID: PQ_3p6rZNQQPFETrM5UOYB9qLkQavGnj
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9939 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0 adultscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103300000
 definitions=main-2103300156
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In order to build a new memblock reserved list during boot that
includes ranges preserved by the previous kernel, a list of preserved
ranges is passed to the next kernel via the pkram superblock. The
ranges are stored in ascending order in a linked list of pages. A more
complete memblock list is not prepared to avoid possible conflicts with
changes in a newer kernel and to avoid having to allocate a contiguous
range larger than a page.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 mm/pkram.c | 183 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 176 insertions(+), 7 deletions(-)

diff --git a/mm/pkram.c b/mm/pkram.c
index a9e6cd8ca084..4cfa236a4126 100644
--- a/mm/pkram.c
+++ b/mm/pkram.c
@@ -86,6 +86,20 @@ struct pkram_node {
 #define PKRAM_LOAD		2
 #define PKRAM_ACCMODE_MASK	3
 
+struct pkram_region {
+	phys_addr_t base;
+	phys_addr_t size;
+};
+
+struct pkram_region_list {
+	__u64	prev_pfn;
+	__u64	next_pfn;
+
+	struct pkram_region regions[0];
+};
+
+#define PKRAM_REGIONS_LIST_MAX \
+	((PAGE_SIZE-sizeof(struct pkram_region_list))/sizeof(struct pkram_region))
 /*
  * The PKRAM super block contains data needed to restore the preserved memory
  * structure on boot. The pointer to it (pfn) should be passed via the 'pkram'
@@ -98,13 +112,20 @@ struct pkram_node {
  */
 struct pkram_super_block {
 	__u64	node_pfn;		/* first element of the node list */
+	__u64	region_list_pfn;
+	__u64	nr_regions;
 };
 
+static struct pkram_region_list *pkram_regions_list;
+static int pkram_init_regions_list(void);
+static unsigned long pkram_populate_regions_list(void);
+
 static unsigned long pkram_sb_pfn __initdata;
 static struct pkram_super_block *pkram_sb;
 
 extern int pkram_add_identity_map(struct page *page);
 extern void pkram_remove_identity_map(struct page *page);
+extern void pkram_find_preserved(unsigned long start, unsigned long end, void *private, int (*callback)(unsigned long base, unsigned long size, void *private));
 
 /*
  * For convenience sake PKRAM nodes are kept in an auxiliary doubly-linked list
@@ -862,21 +883,48 @@ static void __pkram_reboot(void)
 	struct page *page;
 	struct pkram_node *node;
 	unsigned long node_pfn = 0;
+	unsigned long rl_pfn = 0;
+	unsigned long nr_regions = 0;
+	int err = 0;
 
-	list_for_each_entry_reverse(page, &pkram_nodes, lru) {
-		node = page_address(page);
-		if (WARN_ON(node->flags & PKRAM_ACCMODE_MASK))
-			continue;
-		node->node_pfn = node_pfn;
-		node_pfn = page_to_pfn(page);
+	if (!list_empty(&pkram_nodes)) {
+		err = pkram_add_identity_map(virt_to_page(pkram_sb));
+		if (err) {
+			pr_err("PKRAM: failed to add super block to pagetable\n");
+			goto done;
+		}
+		list_for_each_entry_reverse(page, &pkram_nodes, lru) {
+			node = page_address(page);
+			if (WARN_ON(node->flags & PKRAM_ACCMODE_MASK))
+				continue;
+			node->node_pfn = node_pfn;
+			node_pfn = page_to_pfn(page);
+		}
+		err = pkram_init_regions_list();
+		if (err) {
+			pr_err("PKRAM: failed to init regions list\n");
+			goto done;
+		}
+		nr_regions = pkram_populate_regions_list();
+		if (IS_ERR_VALUE(nr_regions)) {
+			err = nr_regions;
+			pr_err("PKRAM: failed to populate regions list\n");
+			goto done;
+		}
+		rl_pfn = page_to_pfn(virt_to_page(pkram_regions_list));
 	}
 
+done:
 	/*
 	 * Zero out pkram_sb completely since it may have been passed from
 	 * the previous boot.
 	 */
 	memset(pkram_sb, 0, PAGE_SIZE);
-	pkram_sb->node_pfn = node_pfn;
+	if (!err && node_pfn) {
+		pkram_sb->node_pfn = node_pfn;
+		pkram_sb->region_list_pfn = rl_pfn;
+		pkram_sb->nr_regions = nr_regions;
+	}
 }
 
 static int pkram_reboot(struct notifier_block *notifier,
@@ -952,3 +1000,124 @@ static int __init pkram_init(void)
 	return 0;
 }
 module_init(pkram_init);
+
+static int count_region_cb(unsigned long base, unsigned long size, void *private)
+{
+	unsigned long *nr_regions = (unsigned long *)private;
+
+	(*nr_regions)++;
+	return 0;
+}
+
+static unsigned long pkram_count_regions(void)
+{
+	unsigned long nr_regions = 0;
+
+	pkram_find_preserved(0, PHYS_ADDR_MAX, &nr_regions, count_region_cb);
+
+	return nr_regions;
+}
+
+/*
+ * To faciliate rapidly building a new memblock reserved list during boot
+ * with the addition of preserved memory ranges a regions list is built
+ * before reboot.
+ * The regions list is a linked list of pages with each page containing an
+ * array of preserved memory ranges.  The ranges are stored in each page
+ * and across the list in address order.  A linked list is used rather than
+ * a single contiguous range to mitigate against the possibility that a
+ * larger, contiguous allocation may fail due to fragmentation.
+ *
+ * Since the pages of the regions list must be preserved and the pkram
+ * pagetable is used to determine what ranges are preserved, the list pages
+ * must be allocated and represented in the pkram pagetable before they can
+ * be populated.  Rather than recounting the number of regions after
+ * allocating pages and repeating until a precise number of pages are
+ * are allocated, the number of pages needed is estimated.
+ */
+static int pkram_init_regions_list(void)
+{
+	struct pkram_region_list *rl;
+	unsigned long nr_regions;
+	unsigned long nr_lpages;
+	struct page *page;
+
+	nr_regions = pkram_count_regions();
+
+	nr_lpages = DIV_ROUND_UP(nr_regions, PKRAM_REGIONS_LIST_MAX);
+	nr_regions += nr_lpages;
+	nr_lpages = DIV_ROUND_UP(nr_regions, PKRAM_REGIONS_LIST_MAX);
+
+	for (; nr_lpages; nr_lpages--) {
+		page = pkram_alloc_page(GFP_KERNEL | __GFP_ZERO);
+		if (!page)
+			return -ENOMEM;
+		rl = page_address(page);
+		if (pkram_regions_list) {
+			rl->next_pfn = page_to_pfn(virt_to_page(pkram_regions_list));
+			pkram_regions_list->prev_pfn = page_to_pfn(page);
+		}
+		pkram_regions_list = rl;
+	}
+
+	return 0;
+}
+
+struct pkram_regions_priv {
+	struct pkram_region_list *curr;
+	struct pkram_region_list *last;
+	unsigned long nr_regions;
+	int idx;
+};
+
+static int add_region_cb(unsigned long base, unsigned long size, void *private)
+{
+	struct pkram_regions_priv *priv;
+	struct pkram_region_list *rl;
+	int i;
+
+	priv = (struct pkram_regions_priv *)private;
+	rl = priv->curr;
+	i = priv->idx;
+
+	if (!rl) {
+		WARN_ON(1);
+		return 1;
+	}
+
+	if (!i)
+		priv->last = priv->curr;
+
+	rl->regions[i].base = base;
+	rl->regions[i].size = size;
+
+	priv->nr_regions++;
+	i++;
+	if (i == PKRAM_REGIONS_LIST_MAX) {
+		u64 next_pfn = rl->next_pfn;
+
+		if (next_pfn)
+			priv->curr = pfn_to_kaddr(next_pfn);
+		else
+			priv->curr = NULL;
+
+		i = 0;
+	}
+	priv->idx = i;
+
+	return 0;
+}
+
+static unsigned long pkram_populate_regions_list(void)
+{
+	struct pkram_regions_priv priv = { .curr = pkram_regions_list };
+
+	pkram_find_preserved(0, PHYS_ADDR_MAX, &priv, add_region_cb);
+
+	/*
+	 * Link the first node to the last populated one.
+	 */
+	pkram_regions_list->prev_pfn = page_to_pfn(virt_to_page(priv.last));
+
+	return priv.nr_regions;
+}
-- 
1.8.3.1

