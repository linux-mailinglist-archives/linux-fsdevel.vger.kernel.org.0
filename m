Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0C7F34F387
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Mar 2021 23:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233483AbhC3VaM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Mar 2021 17:30:12 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:44076 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233357AbhC3V3Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Mar 2021 17:29:16 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12ULOvvL011652;
        Tue, 30 Mar 2021 21:27:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=NHGH6ndUHZ5DHk3h7VkhiG92ASmxYIQKyhSSVSB4ZGM=;
 b=VX4lGUu8LQcppxTZeBeB22Vtd36LymbkIr8DDZlqAHhR2V/Ss/PvmLIX33f/y+gPbCk3
 5envP0bpjN0JKknyGnR0R4f83M7uw5jWIvDVzxaeTnEAhy2YHD6qMRlmBX9wtmAiPe4Q
 kqzwVzTkFbCaIDnh2lnoppMQ6QOp7E3whdJelS1u7oUSinZ/jUj2YT4DXwvoFctUmv26
 1/ZEXYG0VdrNBr0IrqZyg82j5Ndk/iDlNVnNnB46GMhRyqmH1G6SiD+gKDi/Cq8R5Cis
 yP74IuKMeWmkNrGcUV7FQvcJr2/e/Mz6iX5n1M6iqqEN+seHXbPi4800cptYBHB1hOHI pg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 37mab3g8yd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Mar 2021 21:27:18 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12ULPZFq125048;
        Tue, 30 Mar 2021 21:27:17 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by aserp3030.oracle.com with ESMTP id 37mabnk7w3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Mar 2021 21:27:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c04z8XXuleftJYRZmcRB9p25by3iokCCnVa3EuOFauAe7RunDvHYeXfVx+bwDiCgSq3vv5NFeTm8dvJv2zFXTbu2mC+G3iURa9GhDqviMqX3UvK1Kiu6d8JpPsf48Gf2tvTG0Y8DXEa3hRngKuhSZCgkYgzT9fHg6fRD8TVBfp1HmK9gqictkgMk0+bQyumJfKH7EiICPH4QgmyFO4MeOkl0k/ASOzbeO8GQ7up/zDJl435iN+W6l1JZgbwDivRQx1ZOHGJERGF7XWXh2s8+ILfoYtJmzaeu+ntCKm7bP7yPTaD3g4lf2Cf9h8NfNqwT1szw1N1EXMfVJtEpjKY95g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NHGH6ndUHZ5DHk3h7VkhiG92ASmxYIQKyhSSVSB4ZGM=;
 b=PcrjsZ2cJWjksr81qtVtnl+A6eaZdnbvZQDWIFIIwfjDeiKBVHbfBPU61qw9EWVkfSvnP4m3Ux9qe5eEzmelK3/UdyYINDfbhH+oNhIkNlLJSI7JbVG1EeC73blETbi6RUEmy9wfxyqPQxsIV3ductU61uOpDrt5e8lnX13JEGYInDvvKjls7k9uWzlBQszH4OiC6XTHbUx7416AUe8DAs+WmZu6BhOpMkTEB0CwGwkb8eM4F/h7ya2JjYGlG7FDVGNPGJRUtvAPjXscfzWSkyXpirHXgya1zsVNR+gi5o+cfh3sWLE3rrIAi1gJltV0OV75YPsfHo9uXGPEy22EyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NHGH6ndUHZ5DHk3h7VkhiG92ASmxYIQKyhSSVSB4ZGM=;
 b=tfj+7CqI6CoufZNknPgQaI3QYkLYOIC0f5uG85BwO/YRkiZj49c6P8230kBr55YqKOoXFWuzrC3c7/PSs9MJf90l9YFljZV0PHjfyeBUW4cAlCaw2NdPl32XZ/5/L48ld2S02o4iBDafooem+sn6LIZVBjMO4oaqMCX/J6C7HRE=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB3533.namprd10.prod.outlook.com (2603:10b6:208:118::32)
 by MN2PR10MB3679.namprd10.prod.outlook.com (2603:10b6:208:11d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26; Tue, 30 Mar
 2021 21:27:14 +0000
Received: from MN2PR10MB3533.namprd10.prod.outlook.com
 ([fe80::cc79:c40e:430f:e254]) by MN2PR10MB3533.namprd10.prod.outlook.com
 ([fe80::cc79:c40e:430f:e254%4]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 21:27:14 +0000
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
Subject: [RFC v2 31/43] memblock, mm: defer initialization of preserved pages
Date:   Tue, 30 Mar 2021 14:36:06 -0700
Message-Id: <1617140178-8773-32-git-send-email-anthony.yznaga@oracle.com>
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
Received: from ca-qasparc-x86-2.us.oracle.com (148.87.23.8) by BYAPR11CA0099.namprd11.prod.outlook.com (2603:10b6:a03:f4::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26 via Frontend Transport; Tue, 30 Mar 2021 21:27:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f8acbf99-9e5c-4d72-0901-08d8f3c295e4
X-MS-TrafficTypeDiagnostic: MN2PR10MB3679:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR10MB3679A4EF28047F22D2251CDAEC7D9@MN2PR10MB3679.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:923;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rXGz90M7GEoBjJp0YmpV0C6DeLzrGiGiWavsTQHYpR54oDUbjGoJ/UJEIbGCKB21JFOJ1+fAJW5rU4E4XJYcww7z4Yjx+urXzQ7+r/7PmDrI6e9FLl0aEQzmH2w1FrAjkEQ+thytvt87e4BEQ8WGOMTl/TccrFkF42QmmmtA8cHoMkpmlrK97/epJU2dvQm84hhNFIEFiIPKhMJjU+qpMQhHymvGja5HJR8aImB4HU5Htu7q0yi1buaWYy6xOXSNtI3ke/VYWApcqy5on6YbGrYSDVe/DhFSFHr6ZgXF1iHmrwHnZQcD6xEq/7yMQMZZQtj7mgeXo5GNUM8R636dCQMrLc9rLw+gu92VAEpO1fUR6dye6R+bW9+v3VEqkI4uwTPaPr9trzCzODMrFPnpiEToS8yr65ya+u8j1nHwDQ6DBiGIOYl3N1ATi3jKAGvie8c1sUy6aDdUGIse+VpTFyQLWNbnpP6RYwMwGDHfWCF3XeWCoWcEytpl7FbgSwR9U9w3Ne2UAMnZwfhBi/XBGp1GHdh9w5VEOwKNMsJ2I/1rRNOD7HbHKwTXmzxPGhPiFzrT2XcCTij3pYSMMKz+mj02dvlDUCdM8M1Sm8mcgW4mVCJopuVKCR3QeyQvlli/Hcd1dOn7erOilfxeMns/tw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB3533.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(396003)(136003)(346002)(376002)(956004)(2906002)(66476007)(16526019)(8676002)(316002)(2616005)(7406005)(8936002)(44832011)(83380400001)(38100700001)(6486002)(26005)(66946007)(66556008)(7416002)(186003)(6666004)(4326008)(86362001)(52116002)(36756003)(5660300002)(478600001)(7696005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?7cj/HhsOgT2nxjIFgpq5E/GFlkNEmnnqysNktHsswiLgy2Li61vKoFSlnp7h?=
 =?us-ascii?Q?kETe+ROFB47nqrxdPcEbMN1VFqn++Fq/35KgvZucmRcLYdfO9KctQquzpUnn?=
 =?us-ascii?Q?HTeENmpd3nsG+Xol8rQoT7DnyIUvm//ORRtCM7crAfeYdIRF35cv3L756LI2?=
 =?us-ascii?Q?I3n3Qzajbas2BeZq2VjDGRn/mvjZ+8YjoIerbCNESsby3iPApIqpedeoRfp/?=
 =?us-ascii?Q?/iX4IwiDL6GxgQztn9x9tSiuE4myocgDKMxyTwv93xyHJOCTU6zUQimVVoyn?=
 =?us-ascii?Q?/DlESma0co9J4tTKUmMTV0gmCRcZVw1At2LsAwLrVq5WMR/OrulRNZLeojTn?=
 =?us-ascii?Q?VpY7/Uj62zVa8kGnMliXNl5RcOYpESefxULSeMeKR/0isucVqMCz4OY96OEZ?=
 =?us-ascii?Q?nTZ/iCFYcWVZ/S/6DyTOip7wcXGtDuo1Rdf2w8jI1FZNfA1vLZYoYtBNGXPE?=
 =?us-ascii?Q?MdltRKdV4sFbNtG3NPPUIRhRfNABzf4F3IOyC2yUU/uqvQ28ZGHNPElQP/H/?=
 =?us-ascii?Q?2/dRsHhVVGEqa6Gvh4LG2XgtG9jJy7N+24XviWzKSUQR3Noq3di8EbELh1li?=
 =?us-ascii?Q?4qTHGj03/lX+lilC9B2ghnxySu+bBEsovztOXKa050S0K+Qv0EXdYAPGA4fC?=
 =?us-ascii?Q?YP5Evxv7ybgKs5WPP77nVCGh81xlGvF9kHbOp7mgMG4eOf7p0vajnP81Xvkg?=
 =?us-ascii?Q?2bhj5Wgw5mdcems3in6igJB+87zdb3Aoj2qijNUIBOAGHedhfLFVfoG0wJyk?=
 =?us-ascii?Q?xEfrXQKBew3UI9w1OXGUIa8ql4fQc2ad+fN/bNvzf86tupbpVGaRV/m8lP3x?=
 =?us-ascii?Q?QrZJ1f8H6LcJj6MToryuZ1Ti1F2Fw1lWfb+l+j9ix6ExK0xt2ika+e3mjRhF?=
 =?us-ascii?Q?NYSC1iu78WmDExKZycVtfQyeJtAedpLqlRBJwYTAEGGcDXlJmoxaIKaYOq8B?=
 =?us-ascii?Q?BLMv+Wje7rA5h5Nvk6mci7FDXsiGP0lYSuqqPkCF+q/TsqNFQxUDbgZDtP0q?=
 =?us-ascii?Q?itXt2PyExw5FLxixuWX34y9rg3tTXaXUN42el6w0NWwmmZayPWjxyeXRQWoX?=
 =?us-ascii?Q?/EkgA1AXLc2/0UrNLDLkiNU8rY1K4yv0KqtyJv6tmGN9O4NhAsYeRc1y4nrq?=
 =?us-ascii?Q?Zz1idqwhhHCpF2pEC14lxE+X8Jpy6W0qchcMQWo05Bf/lwAUc2opsblyCmx3?=
 =?us-ascii?Q?RVufJrRoG8pWptfIYXYZwhTzBGyWQrNqw9d3xglQKYIctu/8ZCouZHxsWIZi?=
 =?us-ascii?Q?N4vGwgsLFAx1Lyw6BsY5T/FaSbxi+KM3dAiKXuAUnz3BemRushMa98If60e6?=
 =?us-ascii?Q?JcaLxpDedUHQLQZCiX7gcTAA?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8acbf99-9e5c-4d72-0901-08d8f3c295e4
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB3533.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 21:27:14.5824
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oc2w91Nc4yDtfRtNwUAxJJuO7itB3FX7FVCzz5dkdq6r5YURA1bNPFST+3nHrsiTAT4QhhgdQGPoSr9F3ur7iPZkL2Aljt4BGuJTf3pgyKY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3679
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9939 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 spamscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103300000 definitions=main-2103300156
X-Proofpoint-ORIG-GUID: Horf0USydyvf5IQz3rkxBKd0oRJMI9V2
X-Proofpoint-GUID: Horf0USydyvf5IQz3rkxBKd0oRJMI9V2
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9939 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 lowpriorityscore=0
 spamscore=0 priorityscore=1501 phishscore=0 malwarescore=0 suspectscore=0
 clxscore=1015 impostorscore=0 adultscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103300000
 definitions=main-2103300156
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Preserved pages are represented in the memblock reserved list, but page
structs for pages in the reserved list are initialized early while boot
is single threaded which means that a large number of preserved pages
can impact boot time. To mitigate, defer initialization of preserved
pages by skipping them when other reserved pages are initialized and
initializing them later with a separate kernel thread.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 arch/x86/mm/init_64.c |  1 -
 include/linux/mm.h    |  2 +-
 mm/memblock.c         | 11 +++++++++--
 mm/page_alloc.c       | 55 +++++++++++++++++++++++++++++++++++++++++++--------
 4 files changed, 57 insertions(+), 12 deletions(-)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 69bd71996b8b..8efb2fb2a88b 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1294,7 +1294,6 @@ void __init mem_init(void)
 	after_bootmem = 1;
 	x86_init.hyper.init_after_bootmem();
 
-	pkram_cleanup();
 	totalram_pages_add(pkram_reserved_pages);
 	/*
 	 * Must be done after boot memory is put on freelist, because here we
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 64a71bf20536..2a93b2a6ec8d 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2337,7 +2337,7 @@ extern unsigned long free_reserved_area(void *start, void *end,
 extern void adjust_managed_page_count(struct page *page, long count);
 extern void mem_init_print_info(const char *str);
 
-extern void reserve_bootmem_region(phys_addr_t start, phys_addr_t end);
+extern void reserve_bootmem_region(phys_addr_t start, phys_addr_t end, int nid);
 
 /* Free the reserved page into the buddy system, so it gets managed. */
 static inline void free_reserved_page(struct page *page)
diff --git a/mm/memblock.c b/mm/memblock.c
index afaefa8fc6ab..461ea0f85495 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -2007,11 +2007,18 @@ static unsigned long __init free_low_memory_core_early(void)
 	unsigned long count = 0;
 	phys_addr_t start, end;
 	u64 i;
+	struct memblock_region *r;
 
 	memblock_clear_hotplug(0, -1);
 
-	for_each_reserved_mem_range(i, &start, &end)
-		reserve_bootmem_region(start, end);
+	for_each_reserved_mem_region(r) {
+		if (IS_ENABLED(CONFIG_DEFERRED_STRUCT_PAGE_INIT) && memblock_is_preserved(r))
+			continue;
+
+		start = r->base;
+		end = r->base + r->size;
+		reserve_bootmem_region(start, end, NUMA_NO_NODE);
+	}
 
 	/*
 	 * We need to use NUMA_NO_NODE instead of NODE_DATA(0)->node_id
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index cfc72873961d..999fcc8fe907 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -72,6 +72,7 @@
 #include <linux/padata.h>
 #include <linux/khugepaged.h>
 #include <linux/buffer_head.h>
+#include <linux/pkram.h>
 
 #include <asm/sections.h>
 #include <asm/tlbflush.h>
@@ -1475,15 +1476,18 @@ static void __meminit __init_single_page(struct page *page, unsigned long pfn,
 }
 
 #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
-static void __meminit init_reserved_page(unsigned long pfn)
+static void __meminit init_reserved_page(unsigned long pfn, int nid)
 {
 	pg_data_t *pgdat;
-	int nid, zid;
+	int zid;
 
-	if (!early_page_uninitialised(pfn))
-		return;
+	if (nid == NUMA_NO_NODE) {
+		if (!early_page_uninitialised(pfn))
+			return;
+
+		nid = early_pfn_to_nid(pfn);
+	}
 
-	nid = early_pfn_to_nid(pfn);
 	pgdat = NODE_DATA(nid);
 
 	for (zid = 0; zid < MAX_NR_ZONES; zid++) {
@@ -1495,7 +1499,7 @@ static void __meminit init_reserved_page(unsigned long pfn)
 	__init_single_page(pfn_to_page(pfn), pfn, zid, nid);
 }
 #else
-static inline void init_reserved_page(unsigned long pfn)
+static inline void init_reserved_page(unsigned long pfn, int nid)
 {
 }
 #endif /* CONFIG_DEFERRED_STRUCT_PAGE_INIT */
@@ -1506,7 +1510,7 @@ static inline void init_reserved_page(unsigned long pfn)
  * marks the pages PageReserved. The remaining valid pages are later
  * sent to the buddy page allocator.
  */
-void __meminit reserve_bootmem_region(phys_addr_t start, phys_addr_t end)
+void __meminit reserve_bootmem_region(phys_addr_t start, phys_addr_t end, int nid)
 {
 	unsigned long start_pfn = PFN_DOWN(start);
 	unsigned long end_pfn = PFN_UP(end);
@@ -1515,7 +1519,7 @@ void __meminit reserve_bootmem_region(phys_addr_t start, phys_addr_t end)
 		if (pfn_valid(start_pfn)) {
 			struct page *page = pfn_to_page(start_pfn);
 
-			init_reserved_page(start_pfn);
+			init_reserved_page(start_pfn, nid);
 
 			/* Avoid false-positive PageTail() */
 			INIT_LIST_HEAD(&page->lru);
@@ -2008,6 +2012,35 @@ static int __init deferred_init_memmap(void *data)
 	return 0;
 }
 
+#ifdef CONFIG_PKRAM
+static int __init deferred_init_preserved(void *dummy)
+{
+	unsigned long start = jiffies;
+	unsigned long nr_pages = 0;
+	struct memblock_region *r;
+	phys_addr_t spa, epa;
+	int nid;
+
+	for_each_reserved_mem_region(r) {
+		if (!memblock_is_preserved(r))
+			continue;
+
+		spa = r->base;
+		epa = r->base + r->size;
+		nid = memblock_get_region_node(r);
+
+		reserve_bootmem_region(spa, epa, nid);
+		nr_pages += ((epa - spa) >> PAGE_SHIFT);
+	}
+
+	pr_info("initialised %lu preserved pages in %ums\n", nr_pages,
+					jiffies_to_msecs(jiffies - start));
+
+	pgdat_init_report_one_done();
+	return 0;
+}
+#endif /* CONFIG_PKRAM */
+
 /*
  * If this zone has deferred pages, try to grow it by initializing enough
  * deferred pages to satisfy the allocation specified by order, rounded up to
@@ -2107,6 +2140,10 @@ void __init page_alloc_init_late(void)
 
 	/* There will be num_node_state(N_MEMORY) threads */
 	atomic_set(&pgdat_init_n_undone, num_node_state(N_MEMORY));
+#ifdef CONFIG_PKRAM
+	atomic_inc(&pgdat_init_n_undone);
+	kthread_run(deferred_init_preserved, NULL, "pgdatainit_preserved");
+#endif
 	for_each_node_state(nid, N_MEMORY) {
 		kthread_run(deferred_init_memmap, NODE_DATA(nid), "pgdatinit%d", nid);
 	}
@@ -2114,6 +2151,8 @@ void __init page_alloc_init_late(void)
 	/* Block until all are initialised */
 	wait_for_completion(&pgdat_init_all_done_comp);
 
+	pkram_cleanup();
+
 	/*
 	 * The number of managed pages has changed due to the initialisation
 	 * so the pcpu batch and high limits needs to be updated or the limits
-- 
1.8.3.1

