Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3176934F301
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Mar 2021 23:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232776AbhC3V1X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Mar 2021 17:27:23 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:49756 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232503AbhC3V0y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Mar 2021 17:26:54 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12ULNj1o130310;
        Tue, 30 Mar 2021 21:26:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=AMXtTm3E0dn7+dTav4N7vCwJiggNJoJ6HvREteOIM8g=;
 b=SG/d9zVrC9H+wcodhUKy3I8642yg7a4tO/ZOfiHT7EmqMTpiBJLNE3ttOD4kPqNp0vvj
 gKu+Ph4d8Gy04WWXINRkEfi+qwtiwkcYnnJ7ddL2Vecfjbk6J+zF1H/UH2MYG2PEwwxh
 Ew0TuunckqA0N+HuqcxByIiiIqifFIiMuIlpKdeoG4gv8mw78ndkkQRTjU3snyXyl3Rz
 +wi4R05yw9dH3MAL9nvZS2W0V3TMxF/5poliiTJmAKTZHTWGL2MRDWFRhcS/QEtmO+v4
 Rq6UARU35e3jO5oOSLNSmVC3ZM3vCMuOL7ZPzIGIXGw0VJyTdooMoOyuW2Gi6NCvxkX1 Fw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 37mabqr8ns-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Mar 2021 21:26:09 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12ULPSoj105808;
        Tue, 30 Mar 2021 21:26:08 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by userp3030.oracle.com with ESMTP id 37mabkbcad-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Mar 2021 21:26:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JAw6wRdNV39R6eRIGGec9FetM4AZziA6WZ8tWn3IwmsOrQi2WmIqVPNzhq9v4Nvq2eQh8aag8zpSKwsaAnx3cIlEYBtr/2N0FEbWT5BwG8OVz1AHDPEeBYtisihn82ldi1uqPNNxbzNTx0NyzvUyxSY7GpzlcEl7wSnLlSgyk54ANMgDotL1N3tI2DHgm8W1T9EkAxrwwregNq06Yd9jR1LyDMp/BsWaUFHE3/6vyQc1ViOE/xCbMnr2SIdNnMsWH0t/am4B1RwdiCHVviHEjuICVzDYDB/LCRYyv8LIKnsLCp6URGZDn7MIYSortsscDsT2WV4UALYhUYA76Ab59w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AMXtTm3E0dn7+dTav4N7vCwJiggNJoJ6HvREteOIM8g=;
 b=jMKTdu9y1pjnt89WQzOV2+MgG6LgNROIZ8HyR7AiQyKXITm3IxZRxczfqcQQxFyR7Rkq6hOvOqkBBJ6owKwJhKfkRhOgg5w+Ajp1FlxwZ5geSNEJkDn9gfzmcaqXQFXQ/VCz2gocw8o7zWzAP/cHaZ/5A6ikpw184jzZ7FIABAdGFDEzOjJJ7izBW/AGM/wcEliFGMHHiDLZbxX6SE+S2icd49UAY93NeKUk9U+RD8+zEaCtXykxBei9WF/t12LEUw+cZbHr2mMKpEMIqovNrI+Mcc0xTrvNeAIQ6tt5IuZ8eu1/L6TbTUE046qqgKeOHbGnECvKeLVizOFDjnVP6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AMXtTm3E0dn7+dTav4N7vCwJiggNJoJ6HvREteOIM8g=;
 b=fpwhHvHOntMqkm1BVDnfS5/T+xZklo8ddo/pjqrdxEM/35f3uMNOZkIzq3jbWE75lRID00l7iAWoQVOMiTqOPvt0zudbseduRQ/hNTuk0SYDpNsteTvKG2HTj5iz2AMcz0zknI+f53StD4IOPsCwpy9xR7eeZ08P8JwvT8kZkbg=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB3533.namprd10.prod.outlook.com (2603:10b6:208:118::32)
 by MN2PR10MB3613.namprd10.prod.outlook.com (2603:10b6:208:115::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.29; Tue, 30 Mar
 2021 21:26:05 +0000
Received: from MN2PR10MB3533.namprd10.prod.outlook.com
 ([fe80::cc79:c40e:430f:e254]) by MN2PR10MB3533.namprd10.prod.outlook.com
 ([fe80::cc79:c40e:430f:e254%4]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 21:26:05 +0000
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
Subject: [RFC v2 15/43] PKRAM: provide a way to ban pages from use by PKRAM
Date:   Tue, 30 Mar 2021 14:35:50 -0700
Message-Id: <1617140178-8773-16-git-send-email-anthony.yznaga@oracle.com>
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
Received: from ca-qasparc-x86-2.us.oracle.com (148.87.23.8) by BYAPR11CA0099.namprd11.prod.outlook.com (2603:10b6:a03:f4::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26 via Frontend Transport; Tue, 30 Mar 2021 21:26:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9a97ad74-0825-459f-2788-08d8f3c26cb9
X-MS-TrafficTypeDiagnostic: MN2PR10MB3613:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR10MB36134D902B66E84B97D9DD1BEC7D9@MN2PR10MB3613.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B8TltwCHssxUBgT2wbjjhhQUpZmth0E0q0wv/PSBnJEPTA5bHAFJUgXJOi8EhFNRt26VeXdTvtSwLVEZFLF5uIxHf3ztsM9zlMXZF4jb9uegslju4ag7jpzv+mAz4imNXWb9YJ3VrBhJ5P8X7hi/mFmtZt7QaMsgx97hbvxIjYQTQUNcM6qVgM3ZvYEPXcZNAEnRu48DDF9ZpjnTTNW4rUWlAPEfwvY02mmtSnSgUwT7etc2prgaTPrMb3qlf22c+nbViPKyVbTE7D/PMQxTLP93YSUa1V2WFi+250uCpUXrB6NZHsNIWeeT1yuX11D2uKFZTiqRQ7s0UWgNxWnIvlHWkfp+ZbId2I1ciW8PJwgA6879j6P4yvDkGNw5FlCwrxivtJvmVu760nyNSr39DOWFgaGXeD6Np1BL7Fe2r4GZgZscOMNgZC4qnBhhxXEiiJYu+SYbBlw9OI4kVlB1arb1hivTe1VB2DRsTOq6L6fjrxLMu8TYC73y8SwenS1KEj+SgW4zRAEou4abg8MtBnP0IF3WjtNl/P570pYzDBeGHQjx2Z7S2GuuZVEdh+ZLnzGvK799QJhtnpsvbxeV+VBzqCeCacMO2kqXDas3IDCuJQxODST4UHS1KiP0mtVgz1uEWgT2qXy9tztA3GlW8vaifabgo2RrdNvyppTvdJg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB3533.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(346002)(366004)(396003)(136003)(376002)(8676002)(26005)(44832011)(5660300002)(8936002)(4326008)(7406005)(52116002)(956004)(186003)(7416002)(7696005)(6486002)(66476007)(2906002)(16526019)(66946007)(478600001)(38100700001)(36756003)(86362001)(6666004)(66556008)(316002)(83380400001)(2616005)(43043002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?0PuWjNRcsA9GwmSUcqzt43RbsPaBLMbr3e77P+eaUf7j68Qg53VTe9+x0x4u?=
 =?us-ascii?Q?H5+Smt/3ecObKVYqdPOaQuboYAOqTjOQ+4waPyR41FolkMcUHWCY6iCtQR0W?=
 =?us-ascii?Q?t09nEAkTcrVHnbR3DEP77f/I2X/pCwnYPaPFF5BaWYcX9WB/6KJ2lw9V9rqc?=
 =?us-ascii?Q?MdVR85Bm0XHiPACmAa75M1A155Y8XIVjgwpv+GZ63YHpvvUw8dKj5E0ZUWXq?=
 =?us-ascii?Q?9rvwLuSaNGUvcxECcpnqACcACnNeqdgDTRTeJanK1hYHLg5mIPv6WM6SkKVo?=
 =?us-ascii?Q?m+mXquHduETKYiN1t1JB73KmciIT0Y6z4d7pvuFctNQPdJOBwOnMc1MUgCNB?=
 =?us-ascii?Q?yNFZUHhvclPvJD7JLcdrCGfT/Kl60oI3H2sFQ6FA9H8npkVeT8Yk10nnwYg5?=
 =?us-ascii?Q?ejeKppvuEVzKTp9mElVbf7YawBALV6trOu27SkX05EOsEkuJqnZut6fthQ9Z?=
 =?us-ascii?Q?UMACZyK9SAS/M1O56+lCTMY372al8rsbalYZAtXjGbPMVG9j+mDOZgDRV4gZ?=
 =?us-ascii?Q?cQOf4JTE2WONUblRDBgkGNSbeoODK7BXywh6nyTvHVIWUYwotigY9ZdZUKC8?=
 =?us-ascii?Q?KvNoqVFuBpQPFgSHJKqe1PgiW3UoooA4YgDduXYNyAThGa1167fdNCMXfh7t?=
 =?us-ascii?Q?ZvbkevIkFwfPL9Y5t6IxQCJAeCsPP9+PZ0HjHDUCFWC2LNLrw3/grJn8xaju?=
 =?us-ascii?Q?soT26lOsLOEreRRb6PIX7FpaKWDl2IqScf/6qonwKlXsgoqvvDJfKHOmJqao?=
 =?us-ascii?Q?Qlb5leBcoQn/4TKR6r9vpKpwtvNhjPRo0oCeVh/iaZmoIpAE+f6pIFAMbkRm?=
 =?us-ascii?Q?vkwrDRImaZovm9NyvtWp3F1GsA+yhfJI2LjzzIC0Sy2qJPP+coobuGmxwHFx?=
 =?us-ascii?Q?CIl2aaVHjOLXkXgG3/zwGC9yg9cKP23SOG8aTbNm8u1AA3eHA2MmSixHbSVl?=
 =?us-ascii?Q?EoY64OFZRstFYZBEQfEnd/g3QLbDsFXN08a++CQu5vPSyZr+eUKo2hgS+oCp?=
 =?us-ascii?Q?1BdZ/+hYIHmM9FBWE9QDqYPSgyekvEqs7G4sl4Klf/moSnMkzyQgXdRsV+MJ?=
 =?us-ascii?Q?bhopJ8P+v3gBehjMoUfkyd5gKH2AXaE4CyaB1rQ8Tvxc3+5fhMz31e+bUWpM?=
 =?us-ascii?Q?bpEIvRO87RzAwyXUo/4xCgUvgfh2eENd44JVlpVYmkHcXLvOhOYbaZtVD/MS?=
 =?us-ascii?Q?ZR59/U11+2TeGXJT1JGGoBaZp0oAbKIiNFNpkqq7nKaf2nqySMmyKsq6sIhc?=
 =?us-ascii?Q?IqC92bN5sUAKlwiRPXKbegKT59bif8KbSxcc0cPk8VCv8FKFsIAP/61zcFFC?=
 =?us-ascii?Q?98A04QIvbHkG8Pawgk9mtU/X?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a97ad74-0825-459f-2788-08d8f3c26cb9
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB3533.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 21:26:04.8002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UOzFZuN1J1q6ZplvWq6PvaMvwAYM9dWzCrZ/CTCamOniUATPQ9veyEPRQDaOWQej6/nCyyUQ/2H57fJjzv02P51I+ULk4AFdVAZsPOWnrHA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3613
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9939 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103300000 definitions=main-2103300156
X-Proofpoint-ORIG-GUID: 31NP70dNym8jOVnYu71GidvBiy2sTXFV
X-Proofpoint-GUID: 31NP70dNym8jOVnYu71GidvBiy2sTXFV
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9939 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 suspectscore=0 adultscore=0 mlxscore=0
 bulkscore=0 spamscore=0 clxscore=1015 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103300000
 definitions=main-2103300156
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Not all memory ranges can be used for saving preserved over-kexec data.
For example, a kexec kernel may be loaded before pages are preserved.
The memory regions where the kexec segments will be copied to on kexec
must not contain preserved pages or else they will be clobbered.

Originally-by: Vladimir Davydov <vdavydov.dev@gmail.com>
Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 include/linux/pkram.h |   2 +
 mm/pkram.c            | 205 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 207 insertions(+)

diff --git a/include/linux/pkram.h b/include/linux/pkram.h
index c2099a4f2004..97a7c2ac44a9 100644
--- a/include/linux/pkram.h
+++ b/include/linux/pkram.h
@@ -103,10 +103,12 @@ int pkram_prepare_save(struct pkram_stream *ps, const char *name,
 extern unsigned long pkram_reserved_pages;
 void pkram_reserve(void);
 void pkram_cleanup(void);
+void pkram_ban_region(unsigned long start, unsigned long end);
 #else
 #define pkram_reserved_pages 0UL
 static inline void pkram_reserve(void) { }
 static inline void pkram_cleanup(void) { }
+static inline void pkram_ban_region(unsigned long start, unsigned long end) { }
 #endif
 
 #endif /* _LINUX_PKRAM_H */
diff --git a/mm/pkram.c b/mm/pkram.c
index 8670d1633a9d..d15be75c1032 100644
--- a/mm/pkram.c
+++ b/mm/pkram.c
@@ -141,6 +141,28 @@ struct pkram_super_block {
 unsigned long __initdata pkram_reserved_pages;
 
 /*
+ * For tracking a region of memory that PKRAM is not allowed to use.
+ */
+struct banned_region {
+	unsigned long start, end;		/* pfn, inclusive */
+};
+
+#define MAX_NR_BANNED		(32 + MAX_NUMNODES * 2)
+
+static unsigned int nr_banned;			/* number of banned regions */
+
+/* banned regions; arranged in ascending order, do not overlap */
+static struct banned_region banned[MAX_NR_BANNED];
+/*
+ * If a page allocated for PKRAM turns out to belong to a banned region,
+ * it is placed on the banned_pages list so subsequent allocation attempts
+ * do not encounter it again. The list is shrunk when system memory is low.
+ */
+static LIST_HEAD(banned_pages);			/* linked through page::lru */
+static DEFINE_SPINLOCK(banned_pages_lock);
+static unsigned long nr_banned_pages;
+
+/*
  * The PKRAM super block pfn, see above.
  */
 static int __init parse_pkram_sb_pfn(char *arg)
@@ -207,12 +229,116 @@ void __init pkram_reserve(void)
 	pr_info("PKRAM: %lu pages reserved\n", pkram_reserved_pages);
 }
 
+/*
+ * Ban pfn range [start..end] (inclusive) from use in PKRAM.
+ */
+void pkram_ban_region(unsigned long start, unsigned long end)
+{
+	int i, merged = -1;
+
+	/* first try to merge the region with an existing one */
+	for (i = nr_banned - 1; i >= 0 && start <= banned[i].end + 1; i--) {
+		if (end + 1 >= banned[i].start) {
+			start = min(banned[i].start, start);
+			end = max(banned[i].end, end);
+			if (merged < 0)
+				merged = i;
+		} else
+			/*
+			 * Regions are arranged in ascending order and do not
+			 * intersect so the merged region cannot jump over its
+			 * predecessors.
+			 */
+			BUG_ON(merged >= 0);
+	}
+
+	i++;
+
+	if (merged >= 0) {
+		banned[i].start = start;
+		banned[i].end = end;
+		/* shift if merged with more than one region */
+		memmove(banned + i + 1, banned + merged + 1,
+			sizeof(*banned) * (nr_banned - merged - 1));
+		nr_banned -= merged - i;
+		return;
+	}
+
+	/*
+	 * The region does not intersect with an existing one;
+	 * try to create a new one.
+	 */
+	if (nr_banned == MAX_NR_BANNED) {
+		pr_err("PKRAM: Failed to ban %lu-%lu: "
+		       "Too many banned regions\n", start, end);
+		return;
+	}
+
+	memmove(banned + i + 1, banned + i,
+		sizeof(*banned) * (nr_banned - i));
+	banned[i].start = start;
+	banned[i].end = end;
+	nr_banned++;
+}
+
+static void pkram_show_banned(void)
+{
+	int i;
+	unsigned long n, total = 0;
+
+	pr_info("PKRAM: banned regions:\n");
+	for (i = 0; i < nr_banned; i++) {
+		n = banned[i].end - banned[i].start + 1;
+		pr_info("%4d: [%08lx - %08lx] %ld pages\n",
+			i, banned[i].start, banned[i].end, n);
+		total += n;
+	}
+	pr_info("Total banned: %ld pages in %d regions\n",
+		total, nr_banned);
+}
+
+/*
+ * Returns true if the page may not be used for storing preserved data.
+ */
+static bool pkram_page_banned(struct page *page)
+{
+	unsigned long epfn, pfn = page_to_pfn(page);
+	int l = 0, r = nr_banned - 1, m;
+
+	epfn = pfn + compound_nr(page) - 1;
+
+	/* do binary search */
+	while (l <= r) {
+		m = (l + r) / 2;
+		if (epfn < banned[m].start)
+			r = m - 1;
+		else if (pfn > banned[m].end)
+			l = m + 1;
+		else
+			return true;
+	}
+	return false;
+}
+
 static inline struct page *pkram_alloc_page(gfp_t gfp_mask)
 {
 	struct page *page;
+	LIST_HEAD(list);
+	unsigned long len = 0;
 	int err;
 
 	page = alloc_page(gfp_mask);
+	while (page && pkram_page_banned(page)) {
+		len++;
+		list_add(&page->lru, &list);
+		page = alloc_page(gfp_mask);
+	}
+	if (len > 0) {
+		spin_lock(&banned_pages_lock);
+		nr_banned_pages += len;
+		list_splice(&list, &banned_pages);
+		spin_unlock(&banned_pages_lock);
+	}
 	if (page) {
 		err = pkram_add_identity_map(page);
 		if (err) {
@@ -235,6 +361,53 @@ static inline void pkram_free_page(void *addr)
 	free_page((unsigned long)addr);
 }
 
+static void __banned_pages_shrink(unsigned long nr_to_scan)
+{
+	struct page *page;
+
+	if (nr_to_scan <= 0)
+		return;
+
+	while (nr_banned_pages > 0) {
+		BUG_ON(list_empty(&banned_pages));
+		page = list_first_entry(&banned_pages, struct page, lru);
+		list_del(&page->lru);
+		__free_page(page);
+		nr_banned_pages--;
+		nr_to_scan--;
+		if (!nr_to_scan)
+			break;
+	}
+}
+
+static unsigned long
+banned_pages_count(struct shrinker *shrink, struct shrink_control *sc)
+{
+	return nr_banned_pages;
+}
+
+static unsigned long
+banned_pages_scan(struct shrinker *shrink, struct shrink_control *sc)
+{
+	int nr_left = nr_banned_pages;
+
+	if (!sc->nr_to_scan || !nr_left)
+		return nr_left;
+
+	spin_lock(&banned_pages_lock);
+	__banned_pages_shrink(sc->nr_to_scan);
+	nr_left = nr_banned_pages;
+	spin_unlock(&banned_pages_lock);
+
+	return nr_left;
+}
+
+static struct shrinker banned_pages_shrinker = {
+	.count_objects = banned_pages_count,
+	.scan_objects = banned_pages_scan,
+	.seeks = DEFAULT_SEEKS,
+};
+
 static inline void pkram_insert_node(struct pkram_node *node)
 {
 	list_add(&virt_to_page(node)->lru, &pkram_nodes);
@@ -709,6 +882,31 @@ static int __pkram_save_page(struct pkram_access *pa, struct page *page,
 	return 0;
 }
 
+static int __pkram_save_page_copy(struct pkram_access *pa, struct page *page)
+{
+	int nr_pages = compound_nr(page);
+	pgoff_t index = page->index;
+	int i, err;
+
+	for (i = 0; i < nr_pages; i++, index++) {
+		struct page *p = page + i;
+		struct page *new;
+
+		new = pkram_alloc_page(pa->ps->gfp_mask);
+		if (!new)
+			return -ENOMEM;
+
+		copy_highpage(new, p);
+		err = __pkram_save_page(pa, new, index);
+		if (err) {
+			pkram_free_page(page_address(new));
+			return err;
+		}
+	}
+
+	return 0;
+}
+
 /**
  * Save file page @page to the preserved memory node and object associated
  * with pkram stream access @pa. The stream must have been initialized with
@@ -731,6 +929,10 @@ int pkram_save_file_page(struct pkram_access *pa, struct page *page)
 
 	BUG_ON((node->flags & PKRAM_ACCMODE_MASK) != PKRAM_SAVE);
 
+	/* if page is banned, relocate it */
+	if (pkram_page_banned(page))
+		return __pkram_save_page_copy(pa, page);
+
 	err = __pkram_save_page(pa, page, page->index);
 	if (!err)
 		err = pkram_add_identity_map(page);
@@ -968,6 +1170,7 @@ static void __pkram_reboot(void)
 	int err = 0;
 
 	if (!list_empty(&pkram_nodes)) {
+		pkram_show_banned();
 		err = pkram_add_identity_map(virt_to_page(pkram_sb));
 		if (err) {
 			pr_err("PKRAM: failed to add super block to pagetable\n");
@@ -1054,6 +1257,7 @@ static int __init pkram_init_sb(void)
 		page = alloc_page(GFP_KERNEL | __GFP_ZERO);
 		if (!page) {
 			pr_err("PKRAM: Failed to allocate super block\n");
+			__banned_pages_shrink(ULONG_MAX);
 			return 0;
 		}
 		pkram_sb = page_address(page);
@@ -1076,6 +1280,7 @@ static int __init pkram_init(void)
 {
 	if (pkram_init_sb()) {
 		register_reboot_notifier(&pkram_reboot_notifier);
+		register_shrinker(&banned_pages_shrinker);
 		sysfs_update_group(kernel_kobj, &pkram_attr_group);
 	}
 	return 0;
-- 
1.8.3.1

