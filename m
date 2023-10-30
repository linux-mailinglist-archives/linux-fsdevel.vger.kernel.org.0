Return-Path: <linux-fsdevel+bounces-1525-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F147DB48A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Oct 2023 08:42:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A63B2814E9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Oct 2023 07:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E8296FB1;
	Mon, 30 Oct 2023 07:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="UEi0XaOD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38572918
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Oct 2023 07:41:53 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11olkn2101.outbound.protection.outlook.com [40.92.18.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2087A2;
	Mon, 30 Oct 2023 00:41:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XkbY8sPxiBcmFZD06LJh06cCCz2RS1jC4RISjUujG3oDxp6IzqECAnBuo+CYJwUGVuZG5vImuJjjBWLNOFrgzhTcHTcteb1EqZDleGznc+7kwym1o+u05/r9riyHI8twdNHd6iOlyVB95yfcWE/htVfx715qG/znsknHL31EfB3bsMddAP+cHDT1xM4WvjXiXMUO0Wvdd7B+/vISTUGbwJ8Hba6WxdghUWfwdKgadIlbs30eWZJgfNOJTNUz4KFTVH16KpEMEq8HZV7F/pPQqxv9uU52RXn9t/XiDjdRFHM3C5ZgNdfLjCz9mvTHZc1QFBHyUxK3EaC+fWa8s/KOUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vvfMIPrRaI9nRJnjmTglFevwrok4cT1bM4EX4WtXQHA=;
 b=fsHLB++339BJEDuVYmdLNna6YFxKid6ke6IWptSyPh4CrEgTrdFCsKwd04P91Uq1IPl5BpBDn2cpp0jhoRjDnKZOr0Pa5XXGCXJgsvO7/Cv3EfIb8G4RZ4TysV5BoAcNnGBZl7i673KbKyVSPDotznDmFqT++W3+hliAc+783kr2lO2kLz6tX8yzN5Fp1W1MOPxpX4ixA6qxT/wthb3AeGswVgYPlrK39iyHDRVkLDI8OKGnuizZt+Eir0ITVFLmxI+rwNufBA6IK1tK+iQYtVjbtbU5niz5OSqzXKKk3E4CICVuFA6X2Vm1SK5NTuJkwQC9v+RQoHRpzLRJtiPP5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vvfMIPrRaI9nRJnjmTglFevwrok4cT1bM4EX4WtXQHA=;
 b=UEi0XaOD1sUK4qd3B84//x+mnwZUX3oE3RW1fVtC6yaZrblGW3yFOQV66kh5v5plclLhJJCfUl5mof+3SsfG9fO3WVSe7esVDmLtHCNr9+eRT2V/2geG+Qk7V4AZR59gW8S30ltwCHAN1X2Nc/9Iw83oXHZxIQGwz67tkaaAiyQlC0iUlInmiQmZktj9yVoKdMUq0B1Z0srCvLDu+sf+rPOoT+yiKXo675GrHdkaQ6TOOC9WgNMo7PUzHLpZ1MIvyr9dPf24EFHRtdupZ61xV6np24qftxcU7TojAfoR1n7pDRmMLGNcNKflhhxNOXm4B7UqhJL1mi+Mz0sXVevE1Q==
Received: from MW4PR84MB3145.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1e1::10)
 by DM3PR84MB3692.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:0:1e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.29; Mon, 30 Oct
 2023 07:41:49 +0000
Received: from MW4PR84MB3145.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::6761:2623:329a:27d6]) by MW4PR84MB3145.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::6761:2623:329a:27d6%3]) with mapi id 15.20.6933.027; Mon, 30 Oct 2023
 07:41:48 +0000
From: Youling Tang <youling.tang@outlook.com>
To: Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	tangyouling@kylinos.cn,
	youling.tang@outlook.com
Subject: [PATCH] readahead: Update the file_ra_state.ra_pages with each readahead operation
Date: Mon, 30 Oct 2023 15:41:30 +0800
Message-ID:
 <MW4PR84MB3145AFD512F2C777635765B381A1A@MW4PR84MB3145.NAMPRD84.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [K4EcORULqWqsEe8xctEACmQSjMROm7kF]
X-ClientProxiedBy: TYCPR01CA0067.jpnprd01.prod.outlook.com
 (2603:1096:405:2::31) To MW4PR84MB3145.NAMPRD84.PROD.OUTLOOK.COM
 (2603:10b6:303:1e1::10)
X-Microsoft-Original-Message-ID:
 <20231030074130.1538968-1-youling.tang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR84MB3145:EE_|DM3PR84MB3692:EE_
X-MS-Office365-Filtering-Correlation-Id: d886a587-3402-4e42-7b94-08dbd91bac6d
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	L5FiTsJSjQeJUpb+UeqnlN3BftMKa25dQOgqUBAeOCVGqhi53n94pl0WnEuT6JuxUV91RbU7G0Luk8OKAa5CWZpxE4t9LxScyGpKhsv4wuB1VUWd7g8N4TqSZ05b2Ps052QL1M12uwgj/Ns/g/fO/R1TM60+c6DB09Lujmp6mHQrLEFtyeAivvVcnVTDFXJmK0j8MEEqzaHClZ5ZO+R+oVuQ3PO4ilhNK7ytB39KDA6rmaGqkzmPwvIiN3k2cjzpREVUoMEvrzKVMcsvQFcMbD1Qex9Dm2CHV1MRTleJoxGO3lEM4e/rg0McL+duDiSKFUTWzk1CVUlg2UmCfa5Vg2R8SONaUFNajrTdXD9cQfrLvOFtXQsedg1WsXjnPOiTlYiiZINYBQRh1FI1GwYzhurQY6rH0qUuVLDg13V8PlKlGQYPaksIksGq99wpcrt9vURL9h9reMwhP2rLdgAoANPLXQwrFbSQCQ6jcVGyWDvPKCpOvfO1vxxIo1K9O/P1lXjOM4dQQvYm2gWg9C9CJrKSMOMJaXmATHRJxf2BwBeLettTxR4NroovE8DmIX0/FKKDoPL3nqepaIaLR0N5RvP+8M2dWq5kQBoLXnrFfrU4nlWj/F+KSz5HfpipiAh6
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jELSgBrRdf9KhZxmrIdeF1y+qCWQfRZT9zPsst3RikPAqYSVtSJtxwbTJcS6?=
 =?us-ascii?Q?wkEiBA60uLrV3JTPPMdaApoIVuUGDadiNhWtYGQEXn2xlhpR8WpgPWYP03Uf?=
 =?us-ascii?Q?ra8J2dIqPxx04KzUnEZdBI4TcUkI/ZL14pfUDqPqk9enbibXB5FNxgOBPNjY?=
 =?us-ascii?Q?9g7DxQxcDY9wU9rkzNXQVXmLHC2YpaprEKJVZTIqkBPIN9I+ucc8gRi7VsJ+?=
 =?us-ascii?Q?5ICn5AV6Dv7/DQt5c/353Cr//jwYGplJnFgahmJRSXSa/AKbX1/PryWeS0q+?=
 =?us-ascii?Q?8kja9ruAa3XD+Bl45lF7NEBEhR74JzScz82z0je2+ukj7+gqw7HWVfHA6U2X?=
 =?us-ascii?Q?wp6qzVrqR3Fdpe5ttW7YOjYqPU40vQPv67dQSFBUzCRVKfSps1+LJNaQ9Dak?=
 =?us-ascii?Q?pf4aQqP/qy59MGZOyE1YcP9GGG1auw4OiWjkOsuG+7Qc5wA8eXsxoDMPZ+Dk?=
 =?us-ascii?Q?myt5gpMGhQbjDjatecmLyn3gYGbr3u0LfEY27tk6NvR0Sv2r89QiXgSgorr5?=
 =?us-ascii?Q?lTsoX0Yz8G+GCGGCjUXy933RI06qKULacsMCZSj5o+YRAQrUNAsAuMbwOacQ?=
 =?us-ascii?Q?oGFla1NSD2/uxEHZA6mpBZaVC3sFk/TVphFsyx+Jj3RYdsqdZSZ5kWIHyqvQ?=
 =?us-ascii?Q?15Ni11RqHPfJ+pRSleMGzfp0dTsneSAL7ZAZC4kKoBEeLNi4KCkH05ojQuwi?=
 =?us-ascii?Q?/Zl1/L5jUsmvXQmCDUK7ykjWhupV7zqS4IagKAyObFNRQsjYn3iiwuHoG1Cx?=
 =?us-ascii?Q?OyP1CV4JQcEhzSuaBIbuMzZ3+ahl7GoQgjQpnRhrauzaL4erygNkHkOQlJgt?=
 =?us-ascii?Q?vfDbkRkjZUk8XhcnOi02Oo37LQRR3ks9ptEwRfN6NIbSN4ahgv1MtVpQmp1o?=
 =?us-ascii?Q?MMzmJpzmcCWgqIeUn27Fs6nLlY7rlwyc+D9G8+pwm2OQCeP4RtLnQkJ+qCQz?=
 =?us-ascii?Q?gp2yAT7ygEuEyEa+ZDJseDqbWXLJ1NkYYF9CeTSRHd0vJVbHYadLAVDLuYB6?=
 =?us-ascii?Q?NOthIS84kKh3qLV/w1lk9xZMDYupIgX6FjFcH3M7vdRJ1lKBEOpjSxl9Xpe7?=
 =?us-ascii?Q?QTWS2VtwxwU5rayjNZIVLZC6tYRUM0z2kyEp+AhpB8oxAxLmyKDSy6pTbG3p?=
 =?us-ascii?Q?BlCPM4Xrz83G1YK6TBGHQlAAu2/5652onWICz2hatHexf5elbuWXbTemulIx?=
 =?us-ascii?Q?bzAnq8V4pW1tIEAB81M0ukee8/ZP3Us8EA9QRDzr60LDnTYW3g31ElkCd1Q?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d886a587-3402-4e42-7b94-08dbd91bac6d
X-MS-Exchange-CrossTenant-AuthSource: MW4PR84MB3145.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 07:41:48.5400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR84MB3692

From: Youling Tang <tangyouling@kylinos.cn>

Changing the read_ahead_kb value midway through a sequential read of a
large file found that the ra->ra_pages value remained unchanged (new
ra_pages can only be detected the next time the file is opened). Because
file_ra_state_init() is only called once in do_dentry_open() in most
cases.

In ondemand_readahead(), update bdi->ra_pages to ra->ra_pages to ensure
that the maximum pages that can be allocated by the readahead algorithm
are the same as (read_ahead_kb * 1024) / PAGE_SIZE after read_ahead_kb
is modified.

Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
---
 mm/readahead.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index e815c114de21..3dbabf819187 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -554,12 +554,14 @@ static void ondemand_readahead(struct readahead_control *ractl,
 {
 	struct backing_dev_info *bdi = inode_to_bdi(ractl->mapping->host);
 	struct file_ra_state *ra = ractl->ra;
-	unsigned long max_pages = ra->ra_pages;
+	unsigned long max_pages;
 	unsigned long add_pages;
 	pgoff_t index = readahead_index(ractl);
 	pgoff_t expected, prev_index;
 	unsigned int order = folio ? folio_order(folio) : 0;
 
+	max_pages = ra->ra_pages = bdi->ra_pages;
+
 	/*
 	 * If the request exceeds the readahead window, allow the read to
 	 * be up to the optimal hardware IO size
-- 
2.25.1


