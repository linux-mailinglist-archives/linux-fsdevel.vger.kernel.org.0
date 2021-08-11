Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61EC33E8ABC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Aug 2021 09:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235222AbhHKHGR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Aug 2021 03:06:17 -0400
Received: from mail-mw2nam12on2045.outbound.protection.outlook.com ([40.107.244.45]:14976
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235109AbhHKHGP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Aug 2021 03:06:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VfXGFMwWbK/0i1zOOf4F+mPRuL0XRE6gO0SmRfQFsNWWKlmwGZU5Oa7diu4zSj/AuvGW4IZV/H/K5Ux7ABbW23sTV7clQ8ugGBz/8Qu4eZ91taROGIydKpt9N/E3yQjlfjCuoF1XuInJNNzQjhDIpvzGWu9QGxe1vfJNOAH9NhQq3nj30pNlTloCujVf0uQJ1Rj1oZuWPzAEHXGq1viw9P/gMioEPZRVSTM/pltIJRk5uxALJnEXrzMXi4mTQw5R/Mv0WBRIebqfdKmm2aLaccpk2KMp2qk8GW4JjwDMOtTB+qheRZ+N9o9JPrmQUTW1WYy4b7raVc2fFbxeerm3BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Qr4pRnz29uMZ7Cjmb00B57WKjTa/QSBcI34CJYxxzQ=;
 b=kM45ib8xFlUXCWcohBxo58EoPSAmEnSlR2Bkj0PvWvJgaynN0sLPMU3zXRKoWpHjt9suFUO6M5f6v0EakiB/FjLaapa5hR5jFxzfwsdMOUzqBBzeFaUvEavWGXIHLjX4ZSHi4ob+DVQrx5N5CTaVc48lKxzq7loP7hjkfogEYRLTtc4y2rToBc6a/R09G7hvevTqwrE+eKuWmkSONumYb9uZy/btlmiDop35g8Kz1I6Z9mp1EQ1CTwuVx7EGeooscbNuHckMn/Ic/Lm7BD2sSveu2izljKnqHgs89hwQ5/PgPtFwGnfYjejKnIWJNoEWe5lO/PHeZ5+/d+CzLyTB3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.32) smtp.rcpttodomain=linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=quarantine sp=none pct=100)
 action=none header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Qr4pRnz29uMZ7Cjmb00B57WKjTa/QSBcI34CJYxxzQ=;
 b=f2EGPWvGb9DsmS1SuUlIfg2Mf+h8PbrJLmY2VKzcT5GbOlJ7x1wb6g5xGEffe59D7u6hyJN8waBzjFjIK83y2uz9qBr9W17UQBVj+l9fC3v4NQXpE9VLu6FEC3rnzvsQSUCsvaNp2wXNn/kN1TSDMRdIDT875hRc4kMEjWhxjauKRRA+bXTksq58LqEHSCQLLlldouHmxE3C91uHrRtZiy1aRximG4my0cf/2Wk9a+eZ4P6PzH8ClvpNHkes2OOOSOuVBQ/PS4lUlLNOT062TrWfGHjcpgvAgj72gpCNE9Cu5Mhu8w0eGxUJNjPqRf0XAXRJE4lGBrZxjY+S0NYKCg==
Received: from DM3PR03CA0017.namprd03.prod.outlook.com (2603:10b6:0:50::27) by
 BN9PR12MB5034.namprd12.prod.outlook.com (2603:10b6:408:104::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.19; Wed, 11 Aug
 2021 07:05:50 +0000
Received: from DM6NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:50:cafe::bc) by DM3PR03CA0017.outlook.office365.com
 (2603:10b6:0:50::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16 via Frontend
 Transport; Wed, 11 Aug 2021 07:05:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.32)
 smtp.mailfrom=nvidia.com; linux-foundation.org; dkim=none (message not
 signed) header.d=none;linux-foundation.org; dmarc=pass action=none
 header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.32 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.32; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.32) by
 DM6NAM11FT040.mail.protection.outlook.com (10.13.173.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4415.16 via Frontend Transport; Wed, 11 Aug 2021 07:05:49 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 11 Aug
 2021 00:05:47 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 11 Aug
 2021 07:05:47 +0000
Received: from sandstorm.attlocal.net (172.20.187.6) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 11 Aug 2021 00:05:47 -0700
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-s390@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v2 1/3] mm/gup: documentation corrections for gup/pup
Date:   Wed, 11 Aug 2021 00:05:40 -0700
Message-ID: <20210811070542.3403116-2-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210811070542.3403116-1-jhubbard@nvidia.com>
References: <20210811070542.3403116-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9c42fc56-42d3-4ca4-f112-08d95c96732a
X-MS-TrafficTypeDiagnostic: BN9PR12MB5034:
X-Microsoft-Antispam-PRVS: <BN9PR12MB5034E0613195FCA478E9617EA8F89@BN9PR12MB5034.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EAOQkSXRNOsv2rZ0FIGG7Z2hRCIZPGCDwHTWZ6XmUNOTRMr2bqMKMNGgY1aIY55h5m7ZZKPU6/ELXw/sHcK2d4i+3c1zyU4ltvolLKX8EAgABTeXmzVoB2Cps1ZCH3sB4uBtlLIaHYOjzMRoT6cyiEnFs4bcC33uLNjiBtCDWKzbvbdoDPUMe/oH+X5KpJ+/ry5+UmFyKm83Iso4Dzs+YflW8azoSq5BCT8asXH/zgZ6N0NSaXW1C5pxFY5r8suUO5FyIr8v2teKcOZXQUr65f/gK6SD11186zO5z18S7b/pACCL2veFz/F/gVRF7uSayaqdBU+i1aZ4+b9BlYAvee8h1Ph68YEvpe2RshAdUowR1hoab1LhqBhVHRZlnWju0yX+K0fZl0pcn3G0NkTu01jOO/TLdKeLkoG40d6Sh1GuL9Fo4fio2yG2tDajOddigW31hbVy3WtlhRnw3gek2pPi0jKNYd9smofRXvBXu85N3KT6jPtYsQ//yjCe10GxjiLNRs/+d2iMx4OS0kat8nsj1IxBrpBXKoaTGxepEb80M8VkKDEb3zUl8rbQouV3VX4F4ej4/brq9PWxR3bXRKu1qLxZIt79o2gN7/CkZ272/ro+DnuI/TVWQB4gc6O48wuf4XXwEYznisjo5Z53jeROZhoToCOuv4lC274MwwCv1DUpQQ/dIzzx/uw+5xFVa0t6dRj1g9nG+okPxKdUSg==
X-Forefront-Antispam-Report: CIP:216.228.112.32;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid01.nvidia.com;CAT:NONE;SFS:(4636009)(396003)(39860400002)(136003)(346002)(376002)(46966006)(36840700001)(86362001)(36756003)(478600001)(8936002)(83380400001)(5660300002)(36860700001)(356005)(6666004)(1076003)(47076005)(2906002)(8676002)(7416002)(6916009)(426003)(26005)(70206006)(186003)(316002)(336012)(54906003)(82310400003)(82740400003)(70586007)(7636003)(4326008)(2616005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2021 07:05:49.5610
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c42fc56-42d3-4ca4-f112-08d95c96732a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.32];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5034
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The documentation for try_grab_compound_head() and try_grab_page() has
fallen a little out of date. Update and clarify a few points.

Also make it kerneldoc-correct, by adding @args documentation.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Matthew Wilcox <willy@infradead.org>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 mm/gup.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 2630ed1bb4f4..52f08e3177e9 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -92,10 +92,17 @@ static inline struct page *try_get_compound_head(struct page *page, int refs)
 	return head;
 }
 
-/*
+/**
  * try_grab_compound_head() - attempt to elevate a page's refcount, by a
  * flags-dependent amount.
  *
+ * Even though the name includes "compound_head", this function is still
+ * appropriate for callers that have a non-compound @page to get.
+ *
+ * @page:  pointer to page to be grabbed
+ * @refs:  the value to (effectively) add to the page's refcount
+ * @flags: gup flags: these are the FOLL_* flag values.
+ *
  * "grab" names in this file mean, "look at flags to decide whether to use
  * FOLL_PIN or FOLL_GET behavior, when incrementing the page's refcount.
  *
@@ -103,8 +110,14 @@ static inline struct page *try_get_compound_head(struct page *page, int refs)
  * same time. (That's true throughout the get_user_pages*() and
  * pin_user_pages*() APIs.) Cases:
  *
- *    FOLL_GET: page's refcount will be incremented by 1.
- *    FOLL_PIN: page's refcount will be incremented by GUP_PIN_COUNTING_BIAS.
+ *    FOLL_GET: page's refcount will be incremented by @refs.
+ *
+ *    FOLL_PIN on compound pages that are > two pages long: page's refcount will
+ *    be incremented by @refs, and page[2].hpage_pinned_refcount will be
+ *    incremented by @refs * GUP_PIN_COUNTING_BIAS.
+ *
+ *    FOLL_PIN on normal pages, or compound pages that are two pages long:
+ *    page's refcount will be incremented by @refs * GUP_PIN_COUNTING_BIAS.
  *
  * Return: head page (with refcount appropriately incremented) for success, or
  * NULL upon failure. If neither FOLL_GET nor FOLL_PIN was set, that's
@@ -141,6 +154,8 @@ __maybe_unused struct page *try_grab_compound_head(struct page *page,
 		 *
 		 * However, be sure to *also* increment the normal page refcount
 		 * field at least once, so that the page really is pinned.
+		 * That's why the refcount from the earlier
+		 * try_get_compound_head() is left intact.
 		 */
 		if (hpage_pincount_available(page))
 			hpage_pincount_add(page, refs);
@@ -184,10 +199,8 @@ static void put_compound_head(struct page *page, int refs, unsigned int flags)
  * @flags:   gup flags: these are the FOLL_* flag values.
  *
  * Either FOLL_PIN or FOLL_GET (or neither) may be set, but not both at the same
- * time. Cases:
- *
- *    FOLL_GET: page's refcount will be incremented by 1.
- *    FOLL_PIN: page's refcount will be incremented by GUP_PIN_COUNTING_BIAS.
+ * time. Cases: please see the try_grab_compound_head() documentation, with
+ * "refs=1".
  *
  * Return: true for success, or if no action was required (if neither FOLL_PIN
  * nor FOLL_GET was set, nothing is done). False for failure: FOLL_GET or
-- 
2.32.0

