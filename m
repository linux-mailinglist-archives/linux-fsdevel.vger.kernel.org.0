Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1C0234F31D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Mar 2021 23:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232859AbhC3V1g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Mar 2021 17:27:36 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:60872 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232628AbhC3V06 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Mar 2021 17:26:58 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12ULPchq123355;
        Tue, 30 Mar 2021 21:26:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=dZRe5gfZ46LFF432m3qLr28Xysmg6HLZTWPgjewoNqc=;
 b=sG6cmxA6GoZd9L1qTnYXmZ+YM2bUvTRgKnkfn0pDPyBXLYGEI4iMyeuAFttonhF2Rny8
 i3K5KmJxTQBnGBpKnEX7BUcAgb8wqEXy5VfjsrM9gWFc+xkl/e2eACwaIrB09H5xn/9d
 lgvv+f0h1NytXOYuk5gvg8snOdb/lheAz6nwCclEo0gdmR6ZF/uLQ3t3jFyoKZSaz/GG
 iaYf0fnpyu3ypVYC9c1ot/wJF9n5uJdW0UvMT8pMaLghGc48i9nLKd+uJ8mFduXluf89
 euKy6XmH4LCCuV6+RhJfGTtKHwzCqXHw/j10Mp+CO7xj1oPzb5nKsQga+pDGvW4l2UUR RQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 37mafv082f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Mar 2021 21:26:16 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12ULPZae124960;
        Tue, 30 Mar 2021 21:26:16 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by aserp3030.oracle.com with ESMTP id 37mabnk7ag-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Mar 2021 21:26:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IPM3b9ZaEMP4Jg8Uge7O0htQi4ZK64dR049VxHRLl2lt7g8uqda6J2U94SuQeVdSz3tYAFyDYvUTYypGRmO0IxGQLO3N2TxPF2vfjrRUQb3FFGrlvyAc2efQXFVdx6jAGXs5n3fJCtWVfcYQtCt7CIEzH4Ah+xIBecl7KxfReVJnv1cl3zZQUr+ZFl8ECjfipV2RH34tqxDHqdGlgk7oDZb9BfehdR9F+UJ8djSGZAdWtlsH0n4fZ7HRW+a2CaMUOoA8AbzdItZ4n3dU7vD7lBmo7WsHnjUeIB5GS+FOvsXX8SzbmLEWIuPx/WzRT3/H9TY4nrdUQF6JWOZX8vu/hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dZRe5gfZ46LFF432m3qLr28Xysmg6HLZTWPgjewoNqc=;
 b=Sh0IAnQiPnV2lb6sgvK+4GZQJ2cXPZ+tInziF8VAv0qnq+8NYg2X3B0FSsU1AQuCWQBDSvQbZptKnodduIImyC5bn9vlxMhE0g+7JXS+AgUu7zQr+HvbdI29Mh4DQjabOYAxSMCeWgh8VZFj5dL5+ZYK6BkglF8Gjvme3E5I604VwAVCMkDA8IBNXi4aH2QVYfknRl2BKoDMrmELnZntaBHkvRalUzpmB3pSwHekWM/52GkwIc8xNBPEtZ3njSwJeuRsDoXN1QYVsCElps3haWjPlGpSodYVeQpA5UKhhsuxmv4K4Z7fxxwfQK71tL79LKT0AZ5VU6QjOl8ApAAjqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dZRe5gfZ46LFF432m3qLr28Xysmg6HLZTWPgjewoNqc=;
 b=uVwXTC+j+3cG/9ajXElcj9Y1R4UuFmxZ+9VvZVUBHLLEJuacEvWxxOfGt/lBpqKH5QPwp3lMs5xSRp4wqLzLEYlUj9+5bT8buUmI/ssszUuJIh9H4hGnHlTLObmffhU2oBiaAat9vgCNq5/1Nfj6VsWRhAPizHehOadr/MLL+s8=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB3533.namprd10.prod.outlook.com (2603:10b6:208:118::32)
 by MN2PR10MB3613.namprd10.prod.outlook.com (2603:10b6:208:115::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.29; Tue, 30 Mar
 2021 21:26:13 +0000
Received: from MN2PR10MB3533.namprd10.prod.outlook.com
 ([fe80::cc79:c40e:430f:e254]) by MN2PR10MB3533.namprd10.prod.outlook.com
 ([fe80::cc79:c40e:430f:e254%4]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 21:26:13 +0000
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
Subject: [RFC v2 17/43] PKRAM: provide a way to check if a memory range has preserved pages
Date:   Tue, 30 Mar 2021 14:35:52 -0700
Message-Id: <1617140178-8773-18-git-send-email-anthony.yznaga@oracle.com>
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
Received: from ca-qasparc-x86-2.us.oracle.com (148.87.23.8) by BYAPR11CA0099.namprd11.prod.outlook.com (2603:10b6:a03:f4::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26 via Frontend Transport; Tue, 30 Mar 2021 21:26:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d042e3f7-f446-43af-c4c0-08d8f3c271d5
X-MS-TrafficTypeDiagnostic: MN2PR10MB3613:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR10MB3613AB191F015B3006AC374FEC7D9@MN2PR10MB3613.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F83kyNQ3xJw0JHlek3GoRwHVCVyRo7FQwiq9/EOAMzURpzzyrahmy37shdNvQdjAQutQnsQLnx1NgD05Wjk1PthWa59r7MNWgDTzpgES6Nn9Nqk1O+269SLDw1t5wboFIAzkqbikvzv9KT+APHJrDWXWoqXnKn1FLEOCd4cfJ00pdrYkrXB1KOR9tQ8nTol5Rbd4sOYzMp3iqVY84ImupnY/FfvTaRsYZy0hkIlhaDAmUUYwGQnNWQREGq44LttexEAY1w5OH6EbSxEwlFg8zfsHc0RZXjb4ZJVQ3chxgKkhiHwgUTgoG5NFqLuK60wRJ5B8sBl3C7CoPTl+vjis/TOhSELT5yUUeqVOS+6VGaLZIrkssBVPDWtxz8zhxnUoaYj8yZ7MsL2VfZrK+nYzI2r1yO4u2dpPW94IXmYdzfHYIa0kaxKofJLptE22ole86eeS9heZ22+gOBi5S3hhyiar2xpG8kPI/j8lWmn6w/wBHXfiGeP0IoZDjySUtWG7Oft6AwEa2D2lXFljpwv0mXQiYPEDK2hvIMXoKt/3GxAtcKbhNY3uIipEOjAU8rLVq4Ryn79cj44Yu0N/2c9MI5J4KhWtYPg9fuwNMh5pCoOzCKGWUaLIXCePGoWsGN5/ZStb4gGjLmEat/SxD3+8gs2sDSf+FFyOJKwmdswI4sA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB3533.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(346002)(366004)(396003)(136003)(376002)(8676002)(26005)(44832011)(5660300002)(8936002)(4326008)(7406005)(52116002)(956004)(186003)(7416002)(7696005)(6486002)(66476007)(2906002)(16526019)(66946007)(478600001)(38100700001)(36756003)(86362001)(6666004)(66556008)(316002)(2616005)(43043002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?xdb/G9NWT8K8GuG59FWc03pHOr+ORZ3FM3v8rLTNXDzHQr2+tYq6kgzrP5Uj?=
 =?us-ascii?Q?4teAjMkGWMLheirY8VXKGt6LTffjNeWBKNm7sPAnLnegKrzHZf1u7oxYgfLY?=
 =?us-ascii?Q?c0GMQAtrawXg21NhbCO/tY4dNtS0vUYNLqjzmtKeIWaXGh2GdIWLKLXrE+7I?=
 =?us-ascii?Q?bRoS9ZtGEIc6VpAyMaYSqE1gpkBrGqBgiN2hUh+0wUj5Dus/DpZnamevkKnE?=
 =?us-ascii?Q?DbcluEWlZz6rY0WZvpZuWu43VtMx1qjdFpRXyObjXJItFNl2tYI9ExjoourZ?=
 =?us-ascii?Q?2vyE1s1Ce2+8B+i4Fb+bBbPuHRrwL24D9ZxtdolKWfP0kI44Ju4BPwrYS3iR?=
 =?us-ascii?Q?XP8eRIYkPftcmmmQLqRhtWjd9MzhjXd5/yat3fcj6YLfdhPHHo3qmeWHiFtP?=
 =?us-ascii?Q?TW8LWfkO0H60sJCp3DS5x3ob5mEdeBYleVCYCq/wDT46Lb+lFwMCxXsToksh?=
 =?us-ascii?Q?fXnp3Nv+0yVMLzmkQjbCjzAWPbMbK1HeDRsdGs8UomrCJdzwZsFtSdpnFYX7?=
 =?us-ascii?Q?eLtYyid2uFgGIk9Puv5vT/3fMuWFAhYFmNvOe/59TnK/AdFxHq4OFPxB02EU?=
 =?us-ascii?Q?1GMNNsb1FDoylTQjzczaUvRY6PJGusggPcZ0mimcwUCgf3J6s7HqFEuJL3cn?=
 =?us-ascii?Q?G0htqwfzBmX0YaKT8dXi8u/p4WYYGUef/iq2IXDXQj8fGfJIaLj0ZFk4w9hs?=
 =?us-ascii?Q?RRvCCCaPx/4FqS+LvpAup76H1kk1kyCCyJqsJ9SQRpinqoAb7P3xRuQo/CxM?=
 =?us-ascii?Q?mZ/I3B8CxQWtQHXzlDi40x9yikre3nXSnwq/un429umOOGKWnjcGfiEUSv9C?=
 =?us-ascii?Q?kD9ur1oxaows7ZYNY08X3pUoyzBi3pDkhNM0E9GIxUHabe7xluh+GCVPR28V?=
 =?us-ascii?Q?mjUP4HG8QJCLhvymcowD3bl9p0hOIjAHxga+6k3K/apC0qJmQDn3nkTivprY?=
 =?us-ascii?Q?so14U/kPhid+9BdvkeLZm+vbh40ri4/Cmj93ZvbCD7MO34z65aZQ5Be5O/AF?=
 =?us-ascii?Q?vVwSUYrHXAz6t65A31SVJB0Z9a+ppbv2mwXAZCAjoO4DLqc7qo9o9ZSo6A8H?=
 =?us-ascii?Q?nDqIty6EOFX4HXDVjPdogNZ+L3Fyvx6esQXA/6xU2q6QBNrmSIUJsZF1tDVv?=
 =?us-ascii?Q?0vV57C9bFGL/H5MAxGzd8V8xKFoDiCoK4CMDBTyxaBHIVYwv42C/LeswKEou?=
 =?us-ascii?Q?2cJpKoBweMo0Jr2Ykh00B42QyPQ6onTgT4Wta4FZnk0OzS8/LlK6GfiJ9AsP?=
 =?us-ascii?Q?AM0Va9x556JPvd2ffXmp8RSWu8W9Sf0qq1sF3Zl1FTJHiFVCXIH1cjbAHnvo?=
 =?us-ascii?Q?bYYXX0PI6ewBREXiPZf3j3je?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d042e3f7-f446-43af-c4c0-08d8f3c271d5
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB3533.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 21:26:13.3584
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C17YwZSnkmCjf1BhxH90gEkHDbdJn5PLHtBCwYozrUJslo6bRgjZ8nV2Pd7OklZnKrGCFBpCIzFnXK3g0f9GFx8pcEMCZ7VpOHibXbDpVr0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3613
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9939 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 spamscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103300000 definitions=main-2103300156
X-Proofpoint-ORIG-GUID: SgAlfM8_FwgFBGMyyYTp0xEuY7rLn9bf
X-Proofpoint-GUID: SgAlfM8_FwgFBGMyyYTp0xEuY7rLn9bf
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9939 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 adultscore=0
 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 mlxlogscore=999
 priorityscore=1501 phishscore=0 malwarescore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103300000
 definitions=main-2103300156
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When a kernel is loaded for kexec the address ranges where the kexec
segments will be copied to may conflict with pages already set to be
preserved. Provide a way to determine if preserved pages exist in a
specified range.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 include/linux/pkram.h |  2 ++
 mm/pkram.c            | 20 ++++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/include/linux/pkram.h b/include/linux/pkram.h
index 97a7c2ac44a9..977cf45a1bcf 100644
--- a/include/linux/pkram.h
+++ b/include/linux/pkram.h
@@ -104,11 +104,13 @@ int pkram_prepare_save(struct pkram_stream *ps, const char *name,
 void pkram_reserve(void);
 void pkram_cleanup(void);
 void pkram_ban_region(unsigned long start, unsigned long end);
+int pkram_has_preserved_pages(unsigned long start, unsigned long end);
 #else
 #define pkram_reserved_pages 0UL
 static inline void pkram_reserve(void) { }
 static inline void pkram_cleanup(void) { }
 static inline void pkram_ban_region(unsigned long start, unsigned long end) { }
+static inline int pkram_has_preserved_pages(unsigned long start, unsigned long end) { return 0; }
 #endif
 
 #endif /* _LINUX_PKRAM_H */
diff --git a/mm/pkram.c b/mm/pkram.c
index d15be75c1032..dcf84ba785a7 100644
--- a/mm/pkram.c
+++ b/mm/pkram.c
@@ -1668,3 +1668,23 @@ void __init pkram_cleanup(void)
 		pkram_reserved_pages--;
 	}
 }
+
+static int has_preserved_pages_cb(unsigned long base, unsigned long size, void *private)
+{
+	int *has_preserved = (int *)private;
+
+	*has_preserved = 1;
+	return 1;
+}
+
+/*
+ * Check whether the memory range [start, end) contains preserved pages.
+ */
+int pkram_has_preserved_pages(unsigned long start, unsigned long end)
+{
+	int has_preserved = 0;
+
+	pkram_find_preserved(start, end, &has_preserved, has_preserved_pages_cb);
+
+	return has_preserved;
+}
-- 
1.8.3.1

