Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6110C34F309
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Mar 2021 23:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232662AbhC3V12 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Mar 2021 17:27:28 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:60774 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232491AbhC3V0y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Mar 2021 17:26:54 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12ULPOZn123006;
        Tue, 30 Mar 2021 21:25:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=9KJx/AvLkVuTG95Nz9S7Rml6tSTK5D5P6CG5yLsuZdY=;
 b=sckAMlJlOto+DjOfTm1TeqhIe3N1CQl6wBlChEyUJEsSvv9RGI/vwv0JoccwfIrrgpUu
 EUbBw1YceXSlfApm41nZ585sCQGAA0mIAh9VAVSGe+xbuFICNjW9WVvDLaTxWPlxfKRe
 3c7n9NMnPMcO9b+7C1SkSb+NJMzL1ohdseLRaEilwFN7Y+TPpPP/kS/LhJbKt1zOf/vk
 HPSCc+Rq7fFhTsuKVAQnmFCsOVxRJ05ZpjzBLS/rZHPr2g1ZLHc4zxDJhaxXXlviBCvn
 NmYFsXb8c/ks4bEctQdfx8kM3j2VQ3dSSSlyEH6lt4UqAN6QL8+Vff+Z+ls/0eK3+JXf zA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 37mafv081e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Mar 2021 21:25:24 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12ULOmHf183931;
        Tue, 30 Mar 2021 21:25:24 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
        by aserp3020.oracle.com with ESMTP id 37mac7u3yf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Mar 2021 21:25:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DnVCjXHA7zw/J/hz9kgdMnEX5cslK3Kq4iZ3Ky+hqK21E66VOtrqoKWgVazC8gscyc11QkcR958qFa7PSwlO1F8xMydNLd4ULu8GfigdDV2zYo9MQma8hBIwTsuIlR6bx9M5JhFYAgClkv2tpWEz6Z8Xfqb70C70rz4/pXVS+oEUAfnHF92J6Eex8YcDs6OET/sFoAS7pyIos1x3bUTSWCAkGIJsqPrSuLTMhxb6H+j4odJGuKyNMuhPKnXnucorMm+88wdbbq2pwiSVhwrHzCFaxNaqbeGWLrYjvBPvShUrcgs4jBNqXYj5rPL5EVZ4soeV7MH8y0cpI5R+r37MNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9KJx/AvLkVuTG95Nz9S7Rml6tSTK5D5P6CG5yLsuZdY=;
 b=DzJV3r/nIAaavy3RNN7eAlgzlaAXIKlAn9y1AJ2OOtMTn9KqCTPHF839gSSi7VKrXYvmxoglNPYdoExvcEql1lqcnHhtGB74HKVOPW12sNm46FsYN93phsca1z6QE19H/QHCXzxJcwYkySbpuiYTPAPlefYXNw2oDaDDqnZkKENpkEejLY8uEL69N56BYCAoZb83GXQHHPhPvtIjC0F3OBFaVGcKcI6x/3SBQ2GKg0tT6ZovYirgI68IDl3SWoliGaQvLgc9dk/pKVlyicRVPlcJ/hR0mHZLQAgm66PuNdg1dP01FMYwALl/KQh7/kp+T1PWRd8Vtf6w3WVqZNILGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9KJx/AvLkVuTG95Nz9S7Rml6tSTK5D5P6CG5yLsuZdY=;
 b=UR+T/+dNFBlkljLkyrxFhtVC/wg8otMnUuPwTMWWbsx0RlbTm4Y+t5tmg/gPOGRTeNTO59kB1xVK6tlbWCzrRlBwteRy4KL8cVPpOUtfPIUXJBSCWZ87klDJx4Z518Kc2f1JRd8kKMyDwjPxf/s7CK+YKvWqjORLP4Q9Y01V+QE=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB3533.namprd10.prod.outlook.com (2603:10b6:208:118::32)
 by MN2PR10MB3120.namprd10.prod.outlook.com (2603:10b6:208:122::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Tue, 30 Mar
 2021 21:25:21 +0000
Received: from MN2PR10MB3533.namprd10.prod.outlook.com
 ([fe80::cc79:c40e:430f:e254]) by MN2PR10MB3533.namprd10.prod.outlook.com
 ([fe80::cc79:c40e:430f:e254%4]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 21:25:21 +0000
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
Subject: [RFC v2 05/43] mm: PKRAM: support preserving transparent hugepages
Date:   Tue, 30 Mar 2021 14:35:40 -0700
Message-Id: <1617140178-8773-6-git-send-email-anthony.yznaga@oracle.com>
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
Received: from ca-qasparc-x86-2.us.oracle.com (148.87.23.8) by BYAPR11CA0099.namprd11.prod.outlook.com (2603:10b6:a03:f4::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26 via Frontend Transport; Tue, 30 Mar 2021 21:25:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7da638c5-3afb-45e3-afa9-08d8f3c252cb
X-MS-TrafficTypeDiagnostic: MN2PR10MB3120:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR10MB312071D94967D0B1B09B91C7EC7D9@MN2PR10MB3120.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: srKziVRZBVYXXKXAz9YlwY1e+E5gtEcphN71s15JQY/sbFV55Ii0bKHw94EmHMlJ1U9s/CaTSSuTormn0W8i+F+4iFOZfJ3WnX8UBQOJM2LaRe1DSyCMkW2uqR1Z18pcZCcAhUFxREN7k9pc5Um2oxajdpwmUKWV1IygHnNg6g+ja5ms2FICAd2kWuTd4Xez8eDr4XBXPA8QyMz6Ad/fnqGmjrBaTIMb3KvU/j2kl6JkqjEPm4BDznhXKdr2yrmhOF6UeAyvyGpubIHaW6fERKxxfEXh/7Wu2qV4C86jVw+bxjiaY8lVE+IRcnKiG+JnDnfo5/n1WWS6WtyISK0mx9isrsdMvFzrhuqMDQD1cGEVuziPJFxjUfV8DdqwzH1AIWqhznuNpMQ/FishcSkX/lyDpDdYeuMFbocYfxU9s1QWvTijM05+TwbUYU6jqSq/XDL5Pa90qhKVVdYTr9lbc1aszwTRZ/KukXjeCIYz90wsvACS72p6ktJcSEQflYke16qQg97meXuiCadAeDAVGGdVMTQc9jx94LXJgfN/MXT7djHWFNkN/SFkMS2Q0Yv8zSAYjVqE2BQPUV6zb3RqWgUADOKICZvbfiiYevlUogQCrSGS3wpiapDcHZUJbMs+KhUj+VbuRn9pwu7SOqELGA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB3533.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(366004)(376002)(346002)(396003)(52116002)(316002)(186003)(6486002)(16526019)(5660300002)(2616005)(956004)(6666004)(8676002)(66556008)(44832011)(478600001)(83380400001)(7406005)(38100700001)(86362001)(7696005)(66476007)(66946007)(4326008)(2906002)(26005)(7416002)(36756003)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?aKQ5yCPIQoDErcrOAYYtwRGvWsp0EDoHnHJZ5ix12by3wo1td8Cn0hGjdxhk?=
 =?us-ascii?Q?Ett2VheoEM81loSqOt5Aj/diy/cdGJ4dWh0SCmtXj9zAolMWuWXBFOOVG7vR?=
 =?us-ascii?Q?0zEHu0uaNAszgTBZevhEMMyV6YV7MSCOxA28wjUCHEKMkkIv0sXpV/C+6j+j?=
 =?us-ascii?Q?shCyPGIHAqRQB/Hk3P+qCsH5tmwOMz4H1LfbfG0joKdHAnFsMhpCRQaeyAG0?=
 =?us-ascii?Q?WSgTSl8JSLLcpXxCUuKNUNgEctg/+0WXwjjMTTzNDA4lX8Txxk6lpL2NS8Nr?=
 =?us-ascii?Q?3jgLJZkYGQPfTuHqafnmIPFpCNxfJ2doiWdpB/yXg2eFgMa2ORfLLbdrN/xT?=
 =?us-ascii?Q?F2UBwvP3LfCphU2ViDLnfExKkRXFQx/7GBja8duE3luIs93T+T7zXgYoR6be?=
 =?us-ascii?Q?TipTRq9fY4EhG02qrqjA0GQDJNse3g1H3ETHf+Q/xqBbrFLIbZpUbGtCMAjV?=
 =?us-ascii?Q?tdaOKan989qiDyM25IQZ/BjGR9t5xFvr3rLjp00Tkr1WOGHTPMpfbQJiUAxm?=
 =?us-ascii?Q?h4gHcfNe7eVfwLvXdCSWIxwtQXN0ADy0UNmNfVNUFvdx3WyWrxp13ouar25l?=
 =?us-ascii?Q?0UuVJYzbIYuCyh84MBwsiq4uk7xNSG4/04TzfC8W4GZvUjHf95yXlyvccVMl?=
 =?us-ascii?Q?SOMHIhADopr0v7GxVf1vokEU1j8hEY80lOnoQLYRNSJOUwiq/iUJslkZeUgI?=
 =?us-ascii?Q?iDMdamrGnZIjtIpHGv9489lsFA+RbQofvFwNZtmOej8qWcIa+kACYxWVjAiA?=
 =?us-ascii?Q?VOdUfWWLmMoiHP4DUEonXQ8Y0ZoD3/sgXbDuiB3a6XrJA1t9C9EE1fTywkOZ?=
 =?us-ascii?Q?vK94mS3CCi+V4sSeqYMUiC+vMj5QelQE1gGT+uWk74dIJI3piOZlV8igI9RR?=
 =?us-ascii?Q?ACJof2UPmeifCP+kST0XIwx2EPApIzdSyCnwf3+U/HVB2JEFYgGHbeVNMOjo?=
 =?us-ascii?Q?zdoqZecpymIyGy88kFPku+m+aYQmMeuHG2MWwXiFKQUKr/AyZUlnve/z354F?=
 =?us-ascii?Q?yC691ISSppX8rw0Bifmh2ayhxHF4kUznfVBYgNNTrRKVcn5OLDkTHvHs+TLc?=
 =?us-ascii?Q?UnEMvFLH6s7035sHve/jCiinBeWeVhOh6PGWBZt5YoF5uaLEnAbK+su7BkXZ?=
 =?us-ascii?Q?aJ627F9l6nTsDdjQhv3M+Gv628ejS7r+EawpXH9O+LkJwIwIQ7qMbiesDPLB?=
 =?us-ascii?Q?iNV3DR3QIo+JyhzilpoSbekQ/nVkUIe2nI6RG+rTvcKT6ktO+Scg6hzfsJbh?=
 =?us-ascii?Q?7xg2va6+ZWvxXK3Ev3FAry5WmhNHZAANjTLqeX9tH1e3T9YLJy9pkc88W2BF?=
 =?us-ascii?Q?tHOH8jMujc+258n9wGUSzFsB?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7da638c5-3afb-45e3-afa9-08d8f3c252cb
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB3533.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 21:25:21.2949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UMtv2ipe9iQvNd+S+Xyb+Y871Mv31zjx9rNU0fsHaU/6G5dAOTHGJNCcR4LSSm4tOJhJos/LeEE6Ai/2DTW7T4KrijdFjCSBOcp/EQthmzg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3120
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9939 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 spamscore=0 malwarescore=0 phishscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103300000
 definitions=main-2103300156
X-Proofpoint-ORIG-GUID: 60D6oIWZKJa9H0rka--lxzY85z_1zNud
X-Proofpoint-GUID: 60D6oIWZKJa9H0rka--lxzY85z_1zNud
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9939 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 adultscore=0
 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 mlxlogscore=999
 priorityscore=1501 phishscore=0 malwarescore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103300000
 definitions=main-2103300156
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Support preserving a transparent hugepage by recording the page order and
a flag indicating it is a THP.  Use these values when the page is
restored to reconstruct the THP.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 mm/pkram.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/mm/pkram.c b/mm/pkram.c
index 9c42db66d022..da44a6060c5f 100644
--- a/mm/pkram.c
+++ b/mm/pkram.c
@@ -21,6 +21,9 @@
 
 #define PKRAM_ENTRY_FLAGS_SHIFT	0x5
 #define PKRAM_ENTRY_FLAGS_MASK	0x7f
+#define PKRAM_ENTRY_ORDER_MASK	0x1f
+
+#define PKRAM_PAGE_TRANS_HUGE	0x1	/* page is a transparent hugepage */
 
 /*
  * Keeps references to data pages saved to PKRAM.
@@ -211,7 +214,11 @@ static void pkram_add_link_entry(struct pkram_data_stream *pds, struct page *pag
 	pkram_entry_t p;
 	short flags = 0;
 
+	if (PageTransHuge(page))
+		flags |= PKRAM_PAGE_TRANS_HUGE;
+
 	p = page_to_phys(page);
+	p |= compound_order(page);
 	p |= ((flags & PKRAM_ENTRY_FLAGS_MASK) << PKRAM_ENTRY_FLAGS_SHIFT);
 	link->entry[pds->entry_idx] = p;
 	pds->entry_idx++;
@@ -516,7 +523,7 @@ static int __pkram_save_page(struct pkram_access *pa, struct page *page,
 
 	pkram_add_link_entry(pds, page);
 
-	pa->pages.next_index++;
+	pa->pages.next_index += compound_nr(page);
 
 	return 0;
 }
@@ -542,19 +549,24 @@ int pkram_save_file_page(struct pkram_access *pa, struct page *page)
 
 	BUG_ON((node->flags & PKRAM_ACCMODE_MASK) != PKRAM_SAVE);
 
-	BUG_ON(PageCompound(page));
-
 	return __pkram_save_page(pa, page, page->index);
 }
 
 static struct page *__pkram_prep_load_page(pkram_entry_t p)
 {
 	struct page *page;
+	int order;
 	short flags;
 
 	flags = (p >> PKRAM_ENTRY_FLAGS_SHIFT) & PKRAM_ENTRY_FLAGS_MASK;
 	page = pfn_to_page(PHYS_PFN(p));
 
+	if (flags & PKRAM_PAGE_TRANS_HUGE) {
+		order = p & PKRAM_ENTRY_ORDER_MASK;
+		prep_compound_page(page, order);
+		prep_transhuge_page(page);
+	}
+
 	return page;
 }
 
@@ -588,7 +600,7 @@ static struct page *__pkram_load_page(struct pkram_access *pa, unsigned long *in
 
 	if (index) {
 		*index = pa->pages.next_index;
-		pa->pages.next_index++;
+		pa->pages.next_index += compound_nr(page);
 	}
 
 	/* clear to avoid double free (see pkram_truncate_link()) */
-- 
1.8.3.1

