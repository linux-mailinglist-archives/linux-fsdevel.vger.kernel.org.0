Return-Path: <linux-fsdevel+bounces-74974-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id COrOEZKucWlmLQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74974-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 05:58:58 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 270CB61D93
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 05:58:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 50D073E8D36
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 04:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79521477988;
	Thu, 22 Jan 2026 04:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="e44UtXEF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011049.outbound.protection.outlook.com [40.93.194.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2E74657D2;
	Thu, 22 Jan 2026 04:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769057772; cv=fail; b=KsRa2DulDFYIkpZCmGoQMU9DTQXFUWOZWeDSqoRhBewhuHXq69EbjGJgQw/raAd3m6gyFDaOWEPDgqP8Jh1TyIY2KMquPJfj6+KKmpdaYyJmY3WW9NQWq5VFsIwCwx/PZvbZk3Rp7PdZ1auPkJmpioNBSf0ywAX/Y28rDUT7f2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769057772; c=relaxed/simple;
	bh=eJLI0Ow4VnhahyzRNGPVdDioM+7ksfTtd+hKH9Fk6OQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LEkfgUmoUMFzmsh8BL8TrERXRwxZWsFzg0UvBvhzMG4+5iT4iBDuNK7mrcqMR+jz/hGXcBNWGjePhovME8KTpjEVCtLDvUf81ngAvvKWchFjIJwmLlK34+fP4aNLNB/AsBaO4Mu7OiQ0LazJ6uNa0NFoNpTpYkfRmQo+kWa6gWc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=e44UtXEF; arc=fail smtp.client-ip=40.93.194.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D7rqArkLn9vavlEJI9bRh0eBU3eGjmPUt1d0WecVoKd1Ea71B4Qt/JMVkiIFD5eGkcrvGTuvXIhJKFwJ0mgMfdzVkWowNhpSivIFj6ILGDQBHbe8LrRKh9XG5nZoSM+Wljm7G3TGGmnSXrMzAK+OkR1MpeEpHwprBn4YH4eIPsRusiGpocXh1oaT4BgTXpz3kMVYbWBRjs7Qci4SJ2EMd4ltGsstyP4L2XL3R1ztRSOasR70u24D7UMSEXxUDjf2qFTzY3aeKdLroW3O6c/OANSNx6j4RuQOtNShIxXxn0ImNg6IjWmf/KPbHuTnaMzl7qW04r/QuIokM7gEfp3BiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LsG/Yt6iZOHQkvCHSeLjocxZQyi6/khcb9TdUgaVabQ=;
 b=scqPbZsmhY7+pDDmOodsDY4T2aIYt8BPvuXaYFwBw/DEwxEb15SWc9c1VdNSuIC6/KPJ+BBlEhufdntNsETxiVsW0xK+C8q7nPjgOlv+ZjRmZn54VGYIaIq7k91tjj4P/wGzmaEUNB+EBFgZ3u448pXwuzbLaWqm0qP+DTTmbX/9j68yjBbeZbrwekiQGotQMkVfq6+W1uKBQgs2Se2rU6RXresuggoyOhQYnWG4RBFsY8Tanvx7WgKJfU1foyorBFpq9RWClG5kfR5Bj0TZNNzNMn4nuu2PUoFCFaq3qxPbkrDOldrneuKAJY6wd2cRxTi4caqire1PE4qpN7MhLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LsG/Yt6iZOHQkvCHSeLjocxZQyi6/khcb9TdUgaVabQ=;
 b=e44UtXEFjLSd63OORByFTBFmZ8mNMnQdGZLW2WrLsCA+i329/XfQ2rr87eUbmbFmJPw4L3gsJY6pONuZHs/SNGd+JazdA7j5wlz/bCItuW/7hqj3rHi2jYl9ZRCxnO6vzmi7YXK+GOCGL9e98Q7r4HTmi2xPPH8MyD9EDaQL1pc=
Received: from CH3P221CA0016.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1e7::8)
 by LV8PR12MB9333.namprd12.prod.outlook.com (2603:10b6:408:1fa::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Thu, 22 Jan
 2026 04:56:01 +0000
Received: from DS3PEPF000099E1.namprd04.prod.outlook.com
 (2603:10b6:610:1e7:cafe::75) by CH3P221CA0016.outlook.office365.com
 (2603:10b6:610:1e7::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.11 via Frontend Transport; Thu,
 22 Jan 2026 04:56:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099E1.mail.protection.outlook.com (10.167.17.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Thu, 22 Jan 2026 04:56:00 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 21 Jan
 2026 22:55:59 -0600
From: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<nvdimm@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>
CC: Ard Biesheuvel <ardb@kernel.org>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>, Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso
	<dave@stgolabs.net>, Matthew Wilcox <willy@infradead.org>, Jan Kara
	<jack@suse.cz>, "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown
	<len.brown@intel.com>, Pavel Machek <pavel@kernel.org>, Li Ming
	<ming.li@zohomail.com>, Jeff Johnson <jeff.johnson@oss.qualcomm.com>, "Ying
 Huang" <huang.ying.caritas@gmail.com>, Yao Xingtao <yaoxt.fnst@fujitsu.com>,
	Peter Zijlstra <peterz@infradead.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Nathan Fontenot <nathan.fontenot@amd.com>,
	Terry Bowman <terry.bowman@amd.com>, Robert Richter <rrichter@amd.com>,
	Benjamin Cheatham <benjamin.cheatham@amd.com>, Zhijian Li
	<lizhijian@fujitsu.com>, Borislav Petkov <bp@alien8.de>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>, Tomasz Wolski
	<tomasz.wolski@fujitsu.com>
Subject: [PATCH v5 6/7] dax/hmem, cxl: Defer and resolve ownership of Soft Reserved memory ranges
Date: Thu, 22 Jan 2026 04:55:42 +0000
Message-ID: <20260122045543.218194-7-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260122045543.218194-1-Smita.KoralahalliChannabasappa@amd.com>
References: <20260122045543.218194-1-Smita.KoralahalliChannabasappa@amd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E1:EE_|LV8PR12MB9333:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f9d4344-0d42-40ad-3c72-08de59728a02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hwZMmcu9dQHXuDL63Jj3kfdDT31H/cfB5m/1Daw/q8gcHefpPZ7fWeXENA5F?=
 =?us-ascii?Q?PA6MX+RhW3pzBvwqWk/1dx4+hQUDSarLYRgBcQk/r9deVO2Zn4g5/rkUmjme?=
 =?us-ascii?Q?d1VB0rJRVc/YtpK2DBfIT6ahkiaolOTGuAfd2yho4UFMOopweF29McQV3Qy1?=
 =?us-ascii?Q?+FL75mLssoBvVw8wIezVRqyhbjPLIMoqgq9dv8XbtoR1ZHeg9g6xVXlzT6JO?=
 =?us-ascii?Q?pIctFDEOIWj5OIouy0gT5E+B+Z2vacev51VBSdcp50T+ntOSsq5PKfVe3ni8?=
 =?us-ascii?Q?O1olrzHiaFJwSqR1QXTwo0ye0mQf1xk5W0RRSIEm+kf5p/a1Vpn/2hXSL1Q1?=
 =?us-ascii?Q?ED2/KjYByxeb/pWlRbmYTN6u9gFzUSI/POflA5XLRu1jDqVRNKwzwDsbp8mj?=
 =?us-ascii?Q?qFsxLyPKCefMMcm/fa5dODH+H6VJoKCTuqr9hRwgu0ox8RVXn8zY83PcjuBh?=
 =?us-ascii?Q?cNxKOoIxQ28zWTw5OUBfFs0AMRT8uZAlCve4uizFhrT398mcv7uQ1x/W5B5Q?=
 =?us-ascii?Q?coMoRXEXoPnxTrZv5D85ou2IyrrrM5PgpUCOocRm3x6owr7vhH4lRNhmM0IA?=
 =?us-ascii?Q?gUVXK6c2y+ww2Hi1387PYRXn0ppONte/A5RiMArTsa50Mp2O4xQWChoz/91D?=
 =?us-ascii?Q?vDWeL9oykot7Qr5ROhOSnM3Ru6W5zSRxjEn47NbMT7EJ8TTbt0ZC7K7c5yX6?=
 =?us-ascii?Q?guN1dUmsxki6PQEWGIz4cL/AFPArrhP1qlQKtn1N89xgCdKBX8v7whIEINUz?=
 =?us-ascii?Q?Xa1zHQtL8K3fkMGdhjN9bTu8KcMtRXk5trBmWHkAECWzy1utZI61Tzth6+ic?=
 =?us-ascii?Q?dv+Dd+8o3kxwzbyXgpSXI4M6WGG4YIYAkjTw/LQ39fiLbdzVfAuwTg/rJk/h?=
 =?us-ascii?Q?e437RwzsvASyqnH/7w7ShOGCTHpoUbjiJo//pmyRPrZQ1KjBGTG7tXFlPfVh?=
 =?us-ascii?Q?tAVhLrDdlnY38EIcTvUampcNQNSvnnfM0kfidGH3JoZIEzIANYRUWFtswxJj?=
 =?us-ascii?Q?Lbds/2GNCDTXtj25VXieZ6PfbJrdU0d6klwSx6d9YTLdsdb5kXOGIfjZAi3i?=
 =?us-ascii?Q?K9O4+lnQFRaHIBk8QYSCmhbSL7Ud0GY0ZhVP/eb/q41hFTNsllU7YSAEWBYa?=
 =?us-ascii?Q?qo3k4EumaNtqn4UeV7ckZDRpjzi5IMtjsBXtA2pm+oUt7PhPr0qSOilPkWB9?=
 =?us-ascii?Q?/agCIHwfec+p1+91+woTWwAqQSGN1GhFUOXQk0hBNtECltM/F5BzbpuqtR9j?=
 =?us-ascii?Q?Anis3gkQLowtSejtAtnVXem2nI6yJm0hcpHJMlv6BnMAUdnTBt57ks+6jedm?=
 =?us-ascii?Q?jRnFIrxPRVSGTg2vR4OlqAwfPxI/9LOyXR+fy9kJrjG8w6YM9z4GSmcWkOce?=
 =?us-ascii?Q?wgYknkn0x+cp5/VWrdGPwHgEBS0WCvPDoDq5xLIOtoYygrgqCu1Xb3btM33h?=
 =?us-ascii?Q?YHmaLjTwXy5oHfeui8LzTRzauzBQxEC8mNkK7dla3vW42FYrScaaHNUuRGS3?=
 =?us-ascii?Q?GneD4jel/wuKCmY9+37Xd8SYKpmHI7fph66+cHdOvcNZ0v83VkGxev2AM7Oj?=
 =?us-ascii?Q?WdpHzHfOJpRbdp7bffoRsNuckqGDKz+nF6OJaxRrJNYKJLUs0VJsTFuNDIA5?=
 =?us-ascii?Q?XpcO1Cm60Bejy7yjS8aeP9srilRWsyB+6J2RQVgNJ7CD5m7DnHCRAw7xCIDL?=
 =?us-ascii?Q?QCqhWw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 04:56:00.8941
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f9d4344-0d42-40ad-3c72-08de59728a02
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9333
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-74974-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,intel.com,huawei.com,amd.com,stgolabs.net,infradead.org,suse.cz,zohomail.com,oss.qualcomm.com,gmail.com,fujitsu.com,linuxfoundation.org,alien8.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Smita.KoralahalliChannabasappa@amd.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[amd.com,quarantine];
	R_SPF_SOFTFAIL(0.00)[~all];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,amd.com:dkim,amd.com:mid,ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns,intel.com:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 270CB61D93
X-Rspamd-Action: no action

The current probe time ownership check for Soft Reserved memory based
solely on CXL window intersection is insufficient. dax_hmem probing is not
always guaranteed to run after CXL enumeration and region assembly, which
can lead to incorrect ownership decisions before the CXL stack has
finished publishing windows and assembling committed regions.

Introduce deferred ownership handling for Soft Reserved ranges that
intersect CXL windows at probe time by scheduling deferred work from
dax_hmem and waiting for the CXL stack to complete enumeration and region
assembly before deciding ownership.

Evaluate ownership of Soft Reserved ranges based on CXL region
containment.

   - If all Soft Reserved ranges are fully contained within committed CXL
     regions, DROP handling Soft Reserved ranges from dax_hmem and allow
     dax_cxl to bind.

   - If any Soft Reserved range is not fully claimed by committed CXL
     region, tear down all CXL regions and REGISTER the Soft Reserved
     ranges with dax_hmem instead.

While ownership resolution is pending, gate dax_cxl probing to avoid
binding prematurely.

This enforces a strict ownership. Either CXL fully claims the Soft
Reserved ranges or it relinquishes it entirely.

Co-developed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
---
 drivers/cxl/core/region.c | 25 ++++++++++++
 drivers/cxl/cxl.h         |  2 +
 drivers/dax/cxl.c         |  9 +++++
 drivers/dax/hmem/hmem.c   | 81 ++++++++++++++++++++++++++++++++++++++-
 4 files changed, 115 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 9827a6dd3187..6c22a2d4abbb 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3875,6 +3875,31 @@ static int cxl_region_debugfs_poison_clear(void *data, u64 offset)
 DEFINE_DEBUGFS_ATTRIBUTE(cxl_poison_clear_fops, NULL,
 			 cxl_region_debugfs_poison_clear, "%llx\n");
 
+static int cxl_region_teardown_cb(struct device *dev, void *data)
+{
+	struct cxl_root_decoder *cxlrd;
+	struct cxl_region *cxlr;
+	struct cxl_port *port;
+
+	if (!is_cxl_region(dev))
+		return 0;
+
+	cxlr = to_cxl_region(dev);
+
+	cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
+	port = cxlrd_to_port(cxlrd);
+
+	devm_release_action(port->uport_dev, unregister_region, cxlr);
+
+	return 0;
+}
+
+void cxl_region_teardown_all(void)
+{
+	bus_for_each_dev(&cxl_bus_type, NULL, NULL, cxl_region_teardown_cb);
+}
+EXPORT_SYMBOL_GPL(cxl_region_teardown_all);
+
 static int cxl_region_contains_sr_cb(struct device *dev, void *data)
 {
 	struct resource *res = data;
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index b0ff6b65ea0b..1864d35d5f69 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -907,6 +907,7 @@ int cxl_add_to_region(struct cxl_endpoint_decoder *cxled);
 struct cxl_dax_region *to_cxl_dax_region(struct device *dev);
 u64 cxl_port_get_spa_cache_alias(struct cxl_port *endpoint, u64 spa);
 bool cxl_region_contains_soft_reserve(const struct resource *res);
+void cxl_region_teardown_all(void);
 #else
 static inline bool is_cxl_pmem_region(struct device *dev)
 {
@@ -933,6 +934,7 @@ static inline bool cxl_region_contains_soft_reserve(const struct resource *res)
 {
 	return false;
 }
+static inline void cxl_region_teardown_all(void) { }
 #endif
 
 void cxl_endpoint_parse_cdat(struct cxl_port *port);
diff --git a/drivers/dax/cxl.c b/drivers/dax/cxl.c
index 13cd94d32ff7..b7e90d6dd888 100644
--- a/drivers/dax/cxl.c
+++ b/drivers/dax/cxl.c
@@ -14,6 +14,15 @@ static int cxl_dax_region_probe(struct device *dev)
 	struct dax_region *dax_region;
 	struct dev_dax_data data;
 
+	switch (dax_cxl_mode) {
+	case DAX_CXL_MODE_DEFER:
+		return -EPROBE_DEFER;
+	case DAX_CXL_MODE_REGISTER:
+		return -ENODEV;
+	case DAX_CXL_MODE_DROP:
+		break;
+	}
+
 	if (nid == NUMA_NO_NODE)
 		nid = memory_add_physaddr_to_nid(cxlr_dax->hpa_range.start);
 
diff --git a/drivers/dax/hmem/hmem.c b/drivers/dax/hmem/hmem.c
index 1e3424358490..bcb57d8678d7 100644
--- a/drivers/dax/hmem/hmem.c
+++ b/drivers/dax/hmem/hmem.c
@@ -3,6 +3,7 @@
 #include <linux/memregion.h>
 #include <linux/module.h>
 #include <linux/dax.h>
+#include "../../cxl/cxl.h"
 #include "../bus.h"
 
 static bool region_idle;
@@ -58,9 +59,15 @@ static void release_hmem(void *pdev)
 	platform_device_unregister(pdev);
 }
 
+struct dax_defer_work {
+	struct platform_device *pdev;
+	struct work_struct work;
+};
+
 static int hmem_register_device(struct device *host, int target_nid,
 				const struct resource *res)
 {
+	struct dax_defer_work *work = dev_get_drvdata(host);
 	struct platform_device *pdev;
 	struct memregion_info info;
 	long id;
@@ -69,8 +76,18 @@ static int hmem_register_device(struct device *host, int target_nid,
 	if (IS_ENABLED(CONFIG_DEV_DAX_CXL) &&
 	    region_intersects(res->start, resource_size(res), IORESOURCE_MEM,
 			      IORES_DESC_CXL) != REGION_DISJOINT) {
-		dev_dbg(host, "deferring range to CXL: %pr\n", res);
-		return 0;
+		switch (dax_cxl_mode) {
+		case DAX_CXL_MODE_DEFER:
+			dev_dbg(host, "deferring range to CXL: %pr\n", res);
+			schedule_work(&work->work);
+			return 0;
+		case DAX_CXL_MODE_REGISTER:
+			dev_dbg(host, "registering CXL range: %pr\n", res);
+			break;
+		case DAX_CXL_MODE_DROP:
+			dev_dbg(host, "dropping CXL range: %pr\n", res);
+			return 0;
+		}
 	}
 
 	rc = region_intersects_soft_reserve(res->start, resource_size(res));
@@ -123,8 +140,67 @@ static int hmem_register_device(struct device *host, int target_nid,
 	return rc;
 }
 
+static int cxl_contains_soft_reserve(struct device *host, int target_nid,
+				     const struct resource *res)
+{
+	if (region_intersects(res->start, resource_size(res), IORESOURCE_MEM,
+			      IORES_DESC_CXL) != REGION_DISJOINT) {
+		if (!cxl_region_contains_soft_reserve(res))
+			return 1;
+	}
+
+	return 0;
+}
+
+static void process_defer_work(struct work_struct *_work)
+{
+	struct dax_defer_work *work = container_of(_work, typeof(*work), work);
+	struct platform_device *pdev = work->pdev;
+	int rc;
+
+	/* relies on cxl_acpi and cxl_pci having had a chance to load */
+	wait_for_device_probe();
+
+	rc = walk_hmem_resources(&pdev->dev, cxl_contains_soft_reserve);
+
+	if (!rc) {
+		dax_cxl_mode = DAX_CXL_MODE_DROP;
+		rc = bus_rescan_devices(&cxl_bus_type);
+		if (rc)
+			dev_warn(&pdev->dev, "CXL bus rescan failed: %d\n", rc);
+	} else {
+		dax_cxl_mode = DAX_CXL_MODE_REGISTER;
+		cxl_region_teardown_all();
+	}
+
+	walk_hmem_resources(&pdev->dev, hmem_register_device);
+}
+
+static void kill_defer_work(void *_work)
+{
+	struct dax_defer_work *work = container_of(_work, typeof(*work), work);
+
+	cancel_work_sync(&work->work);
+	kfree(work);
+}
+
 static int dax_hmem_platform_probe(struct platform_device *pdev)
 {
+	struct dax_defer_work *work = kzalloc(sizeof(*work), GFP_KERNEL);
+	int rc;
+
+	if (!work)
+		return -ENOMEM;
+
+	work->pdev = pdev;
+	INIT_WORK(&work->work, process_defer_work);
+
+	rc = devm_add_action_or_reset(&pdev->dev, kill_defer_work, work);
+	if (rc)
+		return rc;
+
+	platform_set_drvdata(pdev, work);
+
 	return walk_hmem_resources(&pdev->dev, hmem_register_device);
 }
 
@@ -174,3 +250,4 @@ MODULE_ALIAS("platform:hmem_platform*");
 MODULE_DESCRIPTION("HMEM DAX: direct access to 'specific purpose' memory");
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Intel Corporation");
+MODULE_IMPORT_NS("CXL");
-- 
2.17.1


