Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF7CF5A35F2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Aug 2022 10:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345124AbiH0IgV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 27 Aug 2022 04:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbiH0IgT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 27 Aug 2022 04:36:19 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70C14B14EC;
        Sat, 27 Aug 2022 01:36:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TRn4JAVnSRE7dSLyjcLJ5Eb3xcKqQMMqMNmHhtMp7YOdAncnU0SubYx8gaJf0JYtE+gpnIYWa0UQ8nABIFfW49Sr2og6tmG7eLSgAyeRZ7J0aY1HKT2kny1T5N/cb69SjbKQep3ePUfF7Qr3mnI3a0v0AUsgoPF6yE8KGtJnIOR19zmkyzSC83dgdS/eJgb+6fyXo/7NkttFMm0zToUy1sfn5mVOjkEqm1OdUc8sopk8UlQbW1JCxNMO6E9lbFM7OJSpJl34W66s6s7Q8Lp6kbSWZLvXBL04LXQ7kHkf03Y9ODNKrPiPfYqpQsDsC9gAL92ms1SYzTJpPdXAZky+bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1se43bUMAuKkiRhgWx+GCO+PuzkFi6R5U8K9kr66PVU=;
 b=QXQeaoETZ/yLGtZwuHySGH7LFNFYNCXGVIJf7GnO1NgNwhZ5z8nRix/yOjKqAliIv6GuHJgJ7GRVgovPCx6OM91WI2if59gihCDULYYj9Rct6PzVREqpu5UJQw/+iGYwsej84kRzAK2lnXA280jrBBMq9cT+qTRQ+1JEQJ5wRoOhoeV/hvaMgVfG8TMHz0i3EOaYiH4nyFYcMGulXYmQ4MIulxj8tAELuqiQWtAxqIF3l9ZDuR67wVBFQrrwYm6Sfk+BV61nbQqERbSuau4a/l3TyFIbY8skmG1DAFa9mnXlG0di3kt5FcmTy9Jcu8wi7PgU1Gorio0dRyAjL81wJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1se43bUMAuKkiRhgWx+GCO+PuzkFi6R5U8K9kr66PVU=;
 b=MYgtZjwqzG6Ih6wekWj7eIwOKOc2sW+4TK13gy6L+Rbp8hJxnvgbLbaAlP3vSSnyfJBczdTNL1JLuKIwRrlY/4UyZFCbZXgdSyRGZxt620GFX2owQP119R6onJw0nQcS/p0HKpcWtlvSccyXfuS1E/BlruwzE/Y8V3CN44HF2g89/nqIRGwTC/YwlPBoKHuS5qOJPm96GyJp0k/NCiVKqOBGzFwivQSmSkALIgDjomJDH61SoC3jJCm43npqGwCr5Bdd6+iNMM9sn46kGRAY5uoIFN2BA82mfM3DK3rQHl/gRIJTXq6lnipcdynXiK1nBXuMozOuFzfRpKMzz9e00A==
Received: from DM6PR03CA0045.namprd03.prod.outlook.com (2603:10b6:5:100::22)
 by CY4PR12MB1333.namprd12.prod.outlook.com (2603:10b6:903:41::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Sat, 27 Aug
 2022 08:36:13 +0000
Received: from DM6NAM11FT085.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:100:cafe::bc) by DM6PR03CA0045.outlook.office365.com
 (2603:10b6:5:100::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15 via Frontend
 Transport; Sat, 27 Aug 2022 08:36:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.234) by
 DM6NAM11FT085.mail.protection.outlook.com (10.13.172.236) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5566.15 via Frontend Transport; Sat, 27 Aug 2022 08:36:13 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 DRHQMAIL101.nvidia.com (10.27.9.10) with Microsoft SMTP Server (TLS) id
 15.0.1497.38; Sat, 27 Aug 2022 08:36:12 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Sat, 27 Aug 2022 01:36:12 -0700
Received: from sandstorm.attlocal.net (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Sat, 27 Aug 2022 01:36:11 -0700
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>, Jan Kara <jack@suse.cz>,
        Logan Gunthorpe <logang@deltatee.com>,
        <linux-block@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-xfs@vger.kernel.org>, <linux-nfs@vger.kernel.org>,
        <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 3/6] iov_iter: new iov_iter_pin_pages*() routines
Date:   Sat, 27 Aug 2022 01:36:04 -0700
Message-ID: <20220827083607.2345453-4-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220827083607.2345453-1-jhubbard@nvidia.com>
References: <20220827083607.2345453-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 37c9f01e-66aa-4fcb-ef44-08da88073340
X-MS-TrafficTypeDiagnostic: CY4PR12MB1333:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SAMTNaoa7WNBuMuYYeIzOBA6mR/Vo8mXEqEXLG2d+h97217MgupLC6E1/cGhNFJGu9meNvULQohRuXkL9LOx7MhrzJ6l7TXv6eD1pWLknTfbT6poogyKNIVUPJDiMxliucXvpGG1GUnJR4B20hHo/7rvewHb5D6sefWURP0bVdCj46ThXtJ7DhLqidA+Qh1GkdEcrL3a30lom+gHcpv18h//IIOb6uco/4Rj4od4f+UUStTTl522U2k/CvnF3rM/qNDhjWB4ouCYvcjPdiKV5cLXnX6Sfm0YH+KGgzqBUHivRqYaFSeEb8uZu89gh1r9d+SU8n+LuldPSXXXi4lVg428qJcBXyYGPEOaPGr8ujqEjxev/tl6o0zzATuqcbfmrTqYv4sjagSO3LwlhStkJPm1DEWdxUZFzOYPO3I6mL5q/WspxxuX/QEXpHh9mBAxZGqJYjDoR+vokq5vwQfWQB0gMI3058zwyZdOghx1E0Z2++PqezCpxW1wK1EMcHuCsjU4QBuhzcp/P9hyB2qxUP3clstwlCj8443jRhymDZlN+Mb1bMpoXZV8hZEmw8J9pWhAub5djnkeZZeWjit0ud0nob8Lw8FCdZ/8/syt2fBuKjZ1aasNJKOKGJ99jizL2Q8HiUTpkZZ8OkCPCkOYai76Zvhu2ejwtDYd8RNKQM+IMF7NbYbC/vYmMkYYK3foS/jJRh2nPF9Z5ZrSc+/Um4MeegybttluXnbXnBY9i+hPOtDYGvnG+HBfCt1oz7eAx0IUH+S2b4WSRuT3opszcjAU1Ang9Tlxb3CEwHqq4Csh2KJ7uhn83uTgEbqlBqlO
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(346002)(136003)(376002)(40470700004)(46966006)(36840700001)(82740400003)(83380400001)(36860700001)(426003)(47076005)(2616005)(186003)(2906002)(1076003)(336012)(356005)(81166007)(40460700003)(26005)(107886003)(86362001)(6666004)(40480700001)(82310400005)(70586007)(316002)(41300700001)(478600001)(36756003)(7416002)(54906003)(5660300002)(6916009)(8936002)(8676002)(4326008)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2022 08:36:13.1138
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37c9f01e-66aa-4fcb-ef44-08da88073340
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT085.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1333
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Provide two new wrapper routines that are intended for user space pages
only:

    iov_iter_pin_pages()
    iov_iter_pin_pages_alloc()

Internally, these routines call pin_user_pages_fast(), instead of
get_user_pages_fast().

As always, callers must use unpin_user_pages() or a suitable FOLL_PIN
variant, to release the pages, if they actually were acquired via
pin_user_pages_fast().

This is a prerequisite to converting bio/block layers over to use
pin_user_pages_fast().

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 include/linux/uio.h |  4 +++
 lib/iov_iter.c      | 74 ++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 74 insertions(+), 4 deletions(-)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index 5896af36199c..e26908e443d1 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -251,6 +251,10 @@ ssize_t iov_iter_get_pages2(struct iov_iter *i, struct page **pages,
 			size_t maxsize, unsigned maxpages, size_t *start);
 ssize_t iov_iter_get_pages_alloc2(struct iov_iter *i, struct page ***pages,
 			size_t maxsize, size_t *start);
+ssize_t iov_iter_pin_pages(struct iov_iter *i, struct page **pages,
+			size_t maxsize, unsigned int maxpages, size_t *start);
+ssize_t iov_iter_pin_pages_alloc(struct iov_iter *i, struct page ***pages,
+			size_t maxsize, size_t *start);
 int iov_iter_npages(const struct iov_iter *i, int maxpages);
 void iov_iter_restore(struct iov_iter *i, struct iov_iter_state *state);
 
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 4b7fce72e3e5..1c08014c8498 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1425,9 +1425,23 @@ static struct page *first_bvec_segment(const struct iov_iter *i,
 	return page;
 }
 
+enum pages_alloc_internal_flags {
+	USE_FOLL_GET,
+	USE_FOLL_PIN
+};
+
+/*
+ * TODO: get rid of the how_to_pin arg, and just call pin_user_pages_fast()
+ * unconditionally for the user_back_iter(i) case in this function. That can be
+ * done once all callers are ready to deal with FOLL_PIN pages for their
+ * user-space pages. (FOLL_PIN pages must be released via unpin_user_page(),
+ * rather than put_page().)
+ */
 static ssize_t __iov_iter_get_pages_alloc(struct iov_iter *i,
 		   struct page ***pages, size_t maxsize,
-		   unsigned int maxpages, size_t *start)
+		   unsigned int maxpages, size_t *start,
+		   enum pages_alloc_internal_flags how_to_pin)
+
 {
 	unsigned int n;
 
@@ -1454,7 +1468,12 @@ static ssize_t __iov_iter_get_pages_alloc(struct iov_iter *i,
 		n = want_pages_array(pages, maxsize, *start, maxpages);
 		if (!n)
 			return -ENOMEM;
-		res = get_user_pages_fast(addr, n, gup_flags, *pages);
+
+		if (how_to_pin == USE_FOLL_PIN)
+			res = pin_user_pages_fast(addr, n, gup_flags, *pages);
+		else
+			res = get_user_pages_fast(addr, n, gup_flags, *pages);
+
 		if (unlikely(res <= 0))
 			return res;
 		maxsize = min_t(size_t, maxsize, res * PAGE_SIZE - *start);
@@ -1497,10 +1516,31 @@ ssize_t iov_iter_get_pages2(struct iov_iter *i,
 		return 0;
 	BUG_ON(!pages);
 
-	return __iov_iter_get_pages_alloc(i, &pages, maxsize, maxpages, start);
+	return __iov_iter_get_pages_alloc(i, &pages, maxsize, maxpages, start,
+					  USE_FOLL_GET);
 }
 EXPORT_SYMBOL(iov_iter_get_pages2);
 
+/*
+ * A FOLL_PIN variant that calls pin_user_pages_fast() instead of
+ * get_user_pages_fast().
+ */
+ssize_t iov_iter_pin_pages(struct iov_iter *i,
+		   struct page **pages, size_t maxsize, unsigned int maxpages,
+		   size_t *start)
+{
+	if (!maxpages)
+		return 0;
+	if (WARN_ON_ONCE(!pages))
+		return -EINVAL;
+	if (WARN_ON_ONCE(!user_backed_iter(i)))
+		return -EINVAL;
+
+	return __iov_iter_get_pages_alloc(i, &pages, maxsize, maxpages, start,
+					  USE_FOLL_PIN);
+}
+EXPORT_SYMBOL(iov_iter_pin_pages);
+
 ssize_t iov_iter_get_pages_alloc2(struct iov_iter *i,
 		   struct page ***pages, size_t maxsize,
 		   size_t *start)
@@ -1509,7 +1549,8 @@ ssize_t iov_iter_get_pages_alloc2(struct iov_iter *i,
 
 	*pages = NULL;
 
-	len = __iov_iter_get_pages_alloc(i, pages, maxsize, ~0U, start);
+	len = __iov_iter_get_pages_alloc(i, pages, maxsize, ~0U, start,
+					 USE_FOLL_GET);
 	if (len <= 0) {
 		kvfree(*pages);
 		*pages = NULL;
@@ -1518,6 +1559,31 @@ ssize_t iov_iter_get_pages_alloc2(struct iov_iter *i,
 }
 EXPORT_SYMBOL(iov_iter_get_pages_alloc2);
 
+/*
+ * A FOLL_PIN variant that calls pin_user_pages_fast() instead of
+ * get_user_pages_fast().
+ */
+ssize_t iov_iter_pin_pages_alloc(struct iov_iter *i,
+		   struct page ***pages, size_t maxsize,
+		   size_t *start)
+{
+	ssize_t len;
+
+	*pages = NULL;
+
+	if (WARN_ON_ONCE(!user_backed_iter(i)))
+		return -EINVAL;
+
+	len = __iov_iter_get_pages_alloc(i, pages, maxsize, ~0U, start,
+					 USE_FOLL_PIN);
+	if (len <= 0) {
+		kvfree(*pages);
+		*pages = NULL;
+	}
+	return len;
+}
+EXPORT_SYMBOL(iov_iter_pin_pages_alloc);
+
 size_t csum_and_copy_from_iter(void *addr, size_t bytes, __wsum *csum,
 			       struct iov_iter *i)
 {
-- 
2.37.2

