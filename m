Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA2B34F370
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Mar 2021 23:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233259AbhC3V3g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Mar 2021 17:29:36 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:43838 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233273AbhC3V2j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Mar 2021 17:28:39 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12ULQVT2012650;
        Tue, 30 Mar 2021 21:27:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=gS3vG8u54ctfaUP8I95zzdfhlydj+cI0QRKyrDCE0ws=;
 b=l9/qd24WwoIYMhviHj746zW45j6qpTni5G2PFlQljJsAJQMHI267hETuOWCshulFzamF
 lGiJghFbqjix/A1hs6gB2QSqIlpQ45omznFDBU4E4qsI+1UjAhlLoa2btoSxG+n720Am
 zarrDxsb8kU4HyaD+hlSlYMLLpiSz0AvOkpYXDmMYK1/caiWCdDw7sgLzJobrMhe7tQE
 v9aOxUWV/TLZa/Yag+R4L2q83nANkQFf4FLKV+SNobY4pEnu56UfBo+2QNsNyZphbbU/
 pjvIHdeC3tr1JS6T+LaVelatrCwnYV5ArY6ZRfm2P83zuu5aB0MhpSAaXbS8+toQaNlW BA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 37mab3g90v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Mar 2021 21:27:50 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12ULPZ71125105;
        Tue, 30 Mar 2021 21:27:49 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by aserp3030.oracle.com with ESMTP id 37mabnk883-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Mar 2021 21:27:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VAd6h5Z8farIW7kDvlo1a7/fvIoPKXulEQNKGhoAPoeylt/6D8ShfZu5P1bSd/VRIq+vzacPxxdIsyKt3w2E1X6n6WhkNMe1RjdIdtimtuus6cjVRdA+VcHeGXDv0w0PebQpiwt6cVocNi5DrvL/SWda+EILLVrhEM8dpRHkExFGZI9dluICPHLk0pUOIC/yqfUi42czPW87w6Nf8BD4iFn7oCY2ezpoiHFdyo5TPsKaadwz8mK/PTA29v6zXequhdHfIBE2b1i5Mz6Iyoo62S38+xUgdBS5iv4V0eB18d3TR7RP16YA4kQErdPXeP+KIB8lzKadq9ln2DI0Wt7vSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gS3vG8u54ctfaUP8I95zzdfhlydj+cI0QRKyrDCE0ws=;
 b=W3gBoiyDJsgDaLBnjxqiPaTLiYr8rCCs0iipNoez3XDnBSJyTGc7r6JEdCIUdJR1iRiS8kBnYQu10joa3d58k2icJ7zT/kNVBM0qlTQ/zS94lcgpu2ynNr8+YlEKfzaqaV5dafMmxr4f3QQEXjsiWfK9RSeX3GK456ZVWMxrJDJbjmv+Pp0cOUSH1V3LmHbm8iX2aS4Rcdzq8SEddk65KsU2N/Hw43t3wxlqI47oDYRgR6/83amvMxlRckrC5qXAkuxdGoOccSdfMaUuvCc8+gBTN+vhnskyHpOZmU1pvnemudJblWLdtI6DA7/ulLaVevv1CyOlGfk5HHksdcVylg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gS3vG8u54ctfaUP8I95zzdfhlydj+cI0QRKyrDCE0ws=;
 b=n2zYWj00cHRvDyzUsHQTGNpAKlMYE6MzjWqfxjY3AYSTnb+o2vk05eDG3PNZUnjiDITlrkCu6MJ1Q04rQXAkB0in1/nbsRxe2YI+JeNsE8UbnIb5rZ71uwvJ53g4qAA+FhP68KMBgpNY6sbrgjqa+JL+yprbXuDEe6XPWj/IoOo=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB3533.namprd10.prod.outlook.com (2603:10b6:208:118::32)
 by BLAPR10MB5265.namprd10.prod.outlook.com (2603:10b6:208:325::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26; Tue, 30 Mar
 2021 21:27:45 +0000
Received: from MN2PR10MB3533.namprd10.prod.outlook.com
 ([fe80::cc79:c40e:430f:e254]) by MN2PR10MB3533.namprd10.prod.outlook.com
 ([fe80::cc79:c40e:430f:e254%4]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 21:27:45 +0000
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
Subject: [RFC v2 38/43] mm: implement splicing a list of pages to the LRU
Date:   Tue, 30 Mar 2021 14:36:13 -0700
Message-Id: <1617140178-8773-39-git-send-email-anthony.yznaga@oracle.com>
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
Received: from ca-qasparc-x86-2.us.oracle.com (148.87.23.8) by BYAPR11CA0099.namprd11.prod.outlook.com (2603:10b6:a03:f4::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26 via Frontend Transport; Tue, 30 Mar 2021 21:27:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9026485b-54f8-49ef-2632-08d8f3c2a8ad
X-MS-TrafficTypeDiagnostic: BLAPR10MB5265:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BLAPR10MB52650547F47440DD32284542EC7D9@BLAPR10MB5265.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MnJIItaxKp8tjkoUCon9IrN3svugaZizax9s/07rSN3Loi1o/JHCIgto+muTPLCjJ3njqBuPFvA9qX4jlAeOScVoTWvwpveaNWXjSdVvIR2fhZqL7AhOipCJEcbq6PvsuIgYdVWj97F9aChT5pLnUKjQJl9gVk7ZcHVwDEkssMsxHkzxch0Z8AWYC+qV+zWni1f8wXOYJgan6ezXHxHp5xKpe6UGkzXky9etBiM7FwCv4M2gEeKUKNvaqjJPEyA2ElmYLJ1doNzNKjgc4Pongl2h1YYTeOUGA68Y9e9ayYCX0Fb8XS3HexELXgXGyPT16FTWQmhQuaBJ/deQuAQ2JHQYsQ9m3JcPmFiwuwlYpXsqX2iXwq6uQ0g4JjnPXEUkqEDGuXEeCNHR161S9Ho5macfM+xW5aTaFHM0p5VjrCUrcoZJiKyscR2MN4SFuY+BnPqemH2+SJauMFUcY70PcYhWNCLG4NLnE6Jegq5sXCDyay0wOv/uUx+x0+JrX6euyrcNFrhgQpaO0mzZpLp0jXp/RNe58m2547AenwKQcIQpxfmviTrnuu83/iUIpakGqQrp0PWx59OSlrSICmIMaegcpRCg3+LJk872GdQZOsHv3Ql0Ib/15U5dZuurZfXAl+uY342xs+qL8maSvryLhjHg+rCu4O/nUF6YSHYyXAk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB3533.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(136003)(346002)(376002)(39860400002)(26005)(956004)(52116002)(186003)(38100700001)(36756003)(4326008)(8676002)(44832011)(2906002)(316002)(66476007)(2616005)(7696005)(478600001)(8936002)(86362001)(6666004)(83380400001)(7416002)(66946007)(5660300002)(16526019)(6486002)(7406005)(66556008)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?XRF6Zxwa/GKcSbl355G5fZESpiN3H2ftDoha65OHq9NJvD3YlLMUAdeeOkCw?=
 =?us-ascii?Q?+/IcLrMEHIlBPiD2OCTvq2TpQEFm5+4q2d2P4qjHt48DrfJkJFuE09XLw2FO?=
 =?us-ascii?Q?S1Wp4RViPyvlCUYMVutZcbpP9MiWgduCd32Khtuf1RSjMqzMuQw6ZIGlmYee?=
 =?us-ascii?Q?DaVt3K9+OmAM9qCwSMF/savrp+LkVVRangdqs7vMvrVJXzIbcwKK+/kg4x8h?=
 =?us-ascii?Q?RtAJP0ZRHW4ADSqMZ1dMhSq6oRDFva90Yg2qCtuLLByOxIftnkHVApC6uJuq?=
 =?us-ascii?Q?QQFvRhyI9WyMWYBqQadhxvG8rFfDJPuD/idNtcvHklUj/YwN08cEnUfXBKzb?=
 =?us-ascii?Q?8OqBBzhhdSxFJ1IOWXxtNyS/8hFtaDcCkQn8v4N4woARwjoZHHE1eX9DZhcf?=
 =?us-ascii?Q?O3tAOcSYFDjGJ4vrksnw9dbTPKUacgNS44pgZqDcUZVt07fOUjKEN+azp6ot?=
 =?us-ascii?Q?QARG1TZoDX/NxZev2XpkRIwB1QW8GOu0tEqI/JzkceJSeyPM8ZZRwgCk2Hfh?=
 =?us-ascii?Q?bb7uU5VyxOunlR4UZdzudye4iK3jK0z+/CVXCTNhuS3P7sFbN/QiZV/BYGCG?=
 =?us-ascii?Q?Y3qIVTuQYJ2AGYnCKbcFg5/toNVWnajGMzMfv2Tl2cc21qXGP4SMV8QKJTbs?=
 =?us-ascii?Q?Gzg1Sp4jt2QoPhd+WLNVhMNev+cIgGR9FhXT+nLjlvSWlUgrVqeVr1TdyzYl?=
 =?us-ascii?Q?6/y82sHIgO1FUbxf/rqZ74G/U+lSOi733RYaEpxPTae7GhY+LrrzOqYpZsE6?=
 =?us-ascii?Q?YoH9NZN70e3a+4cAqULFLxOZWy/ukucW5h3VI5Rns/8E3vPj3x8oyJ2AwvNj?=
 =?us-ascii?Q?J6ksfw4PUufSChxr1Merp82GjssIH0CHyzQ3MuJ/V37GgqdqKO+1UT4Dn0G4?=
 =?us-ascii?Q?mi/pftnIHFp3H1m1Qzoga6ZM4EGBiZM7RikSXF5a9wZcBEojtQ9gX5GqW/Wm?=
 =?us-ascii?Q?KgaPjxZiNwkwXBlNc1/9yOMChOVAOt3ozNvaDzmbTO7GSkVzMiRSUqQLXg6g?=
 =?us-ascii?Q?pMSLEP3bkVRNo9OFlHvAm8VhZucF/5QFnZEpvkymiLa4fOjGdhCG0G7uz34Y?=
 =?us-ascii?Q?DC67GAg4m7r9Ge0/rzOaL/Rl3B5/51QB0C9sNajw+pdFKwUQmuzeET3qOSUy?=
 =?us-ascii?Q?7RZ/WbrTaLLpOJM/TJEQ3ispgqv/YfskDZMYROK1jLHQPHy8Ghx06Zx1IBHg?=
 =?us-ascii?Q?zWKItn5YZImKpRbpexkdflD0p9bwCYAdcr/bBacmnLAzTDbCd1eOZ4yH+zRI?=
 =?us-ascii?Q?K/Vox2hqY2dowhafSA6RgS+ArHFOera/yqZIi01vMh7V10xTtoI27/IReVJz?=
 =?us-ascii?Q?h8yzKdlTI+r5q5D8WldLTscL?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9026485b-54f8-49ef-2632-08d8f3c2a8ad
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB3533.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 21:27:45.3579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KQUtAJogR7awilxkKBv/hFhx7u4AIJt0m6FEuvWhkQpLn9TkKjZ8zE9Yyi4kD4VAvPjdZlu6hPCHfVHVNcKnbymCpTaE53fdSkd76nvdoFs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5265
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9939 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 spamscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103300000 definitions=main-2103300156
X-Proofpoint-ORIG-GUID: aLCqfneXsEiwzpXEDaj3edm0I6pdUiFB
X-Proofpoint-GUID: aLCqfneXsEiwzpXEDaj3edm0I6pdUiFB
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9939 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 lowpriorityscore=0
 spamscore=0 priorityscore=1501 phishscore=0 malwarescore=0 suspectscore=0
 clxscore=1015 impostorscore=0 adultscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103300000
 definitions=main-2103300156
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Considerable contention on the LRU lock happens when multiple threads
are used to insert pages into a shmem file in parallel. To alleviate this
provide a way for pages to be added to the same LRU to be staged so that
they can be added by splicing lists and updating stats once with the lock
held. For now only unevictable pages are supported.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 include/linux/swap.h | 13 ++++++++
 mm/swap.c            | 86 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 99 insertions(+)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 4cc6ec3bf0ab..254c9c8d71d0 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -351,6 +351,19 @@ extern void lru_note_cost(struct lruvec *lruvec, bool file,
 
 extern void lru_cache_add_inactive_or_unevictable(struct page *page,
 						struct vm_area_struct *vma);
+struct lru_splice {
+	struct list_head	splice;
+	struct list_head	*lru_head;
+	struct lruvec		*lruvec;
+	enum lru_list		lru;
+	unsigned long		nr_pages[MAX_NR_ZONES];
+	unsigned long		pgculled;
+};
+#define LRU_SPLICE_INIT(name)	{ .splice = LIST_HEAD_INIT(name.splice) }
+#define LRU_SPLICE(name) \
+	struct lru_splice name = LRU_SPLICE_INIT(name)
+extern void lru_splice_add(struct page *page, struct lru_splice *splice);
+extern void add_splice_to_lru_list(struct lru_splice *splice);
 
 /* linux/mm/vmscan.c */
 extern unsigned long zone_reclaimable_pages(struct zone *zone);
diff --git a/mm/swap.c b/mm/swap.c
index 31b844d4ed94..a1db6a748608 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -200,6 +200,92 @@ int get_kernel_page(unsigned long start, int write, struct page **pages)
 }
 EXPORT_SYMBOL_GPL(get_kernel_page);
 
+/*
+ * Update stats and move accumulated pages from an lru_splice to the lru.
+ */
+void add_splice_to_lru_list(struct lru_splice *splice)
+{
+	struct lruvec *lruvec = splice->lruvec;
+	enum lru_list lru = splice->lru;
+	unsigned long flags = 0;
+	int zid;
+
+	if (list_empty(&splice->splice))
+		return;
+
+	spin_lock_irqsave(&lruvec->lru_lock, flags);
+	for (zid = 0; zid < MAX_NR_ZONES; zid++) {
+		if (splice->nr_pages[zid])
+			update_lru_size(lruvec, lru, zid, splice->nr_pages[zid]);
+	}
+	count_vm_events(UNEVICTABLE_PGCULLED, splice->pgculled);
+	list_splice_init(&splice->splice, splice->lru_head);
+	spin_unlock_irqrestore(&lruvec->lru_lock, flags);
+}
+
+static void add_page_to_lru_splice(struct page *page, struct lru_splice *splice,
+				   struct lruvec *lruvec, enum lru_list lru)
+{
+	if (list_empty(&splice->splice)) {
+		int zid;
+
+		splice->lruvec = lruvec;
+		splice->lru_head = &lruvec->lists[lru];
+		splice->lru = lru;
+		for (zid = 0; zid < MAX_NR_ZONES; zid++)
+			splice->nr_pages[zid] = 0;
+		splice->pgculled = 0;
+	}
+
+	BUG_ON(splice->lruvec != lruvec);
+	BUG_ON(splice->lru_head != &lruvec->lists[lru]);
+
+	list_add(&page->lru, &splice->splice);
+	splice->nr_pages[page_zonenum(page)] += thp_nr_pages(page);
+}
+
+/*
+ * Similar in functionality to __pagevec_lru_add_fn() but here the page is
+ * being added to an lru_splice and the LRU lock is not held.
+ */
+static void page_lru_splice_add(struct page *page, struct lru_splice *splice, struct lruvec *lruvec)
+{
+	enum lru_list lru;
+	int was_unevictable = TestClearPageUnevictable(page);
+	int nr_pages = thp_nr_pages(page);
+
+	VM_BUG_ON_PAGE(PageLRU(page), page);
+	/* XXX only supports unevictable pages at the moment */
+	VM_BUG_ON_PAGE(was_unevictable, page);
+
+	SetPageLRU(page);
+	smp_mb__after_atomic();
+
+	lru = LRU_UNEVICTABLE;
+	ClearPageActive(page);
+	SetPageUnevictable(page);
+	if (!was_unevictable)
+		splice->pgculled += nr_pages;
+
+	add_page_to_lru_splice(page, splice, lruvec, lru);
+	trace_mm_lru_insertion(page);
+}
+
+void lru_splice_add(struct page *page, struct lru_splice *splice)
+{
+	struct lruvec *lruvec;
+
+	VM_BUG_ON_PAGE(PageActive(page) && PageUnevictable(page), page);
+	VM_BUG_ON_PAGE(PageLRU(page), page);
+
+	get_page(page);
+	lruvec = mem_cgroup_page_lruvec(page, page_pgdat(page));
+	if (lruvec != splice->lruvec)
+		add_splice_to_lru_list(splice);
+	page_lru_splice_add(page, splice, lruvec);
+	put_page(page);
+}
+
 static void pagevec_lru_move_fn(struct pagevec *pvec,
 	void (*move_fn)(struct page *page, struct lruvec *lruvec))
 {
-- 
1.8.3.1

