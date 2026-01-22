Return-Path: <linux-fsdevel+bounces-74975-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uOhnAeaucWlmLQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74975-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 06:00:22 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C680C61DB5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 06:00:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7EDE9508A95
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 04:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C657D477E38;
	Thu, 22 Jan 2026 04:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NHtaRJzT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010040.outbound.protection.outlook.com [52.101.56.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C22132E757;
	Thu, 22 Jan 2026 04:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769057775; cv=fail; b=uQ48eq5ahWRq61aFFdLWT4KLrF/xafV+pcsdoVo3MVhV1ZYvBPOg2DudED65ZvcA92ke5Sk9vQVdEvrpwtBiPHhHcZ2b0994oyjaLDo4sE9K/i/AV4KIv9EVduybdl7F9c3sClbVDQC4YACZeJLlb9CtZLK1Jg4lV6AaZ0Av1hk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769057775; c=relaxed/simple;
	bh=Yp2RmsT2/A6pqE02FU3hd1IN9L2R6jX8r/GKWSy9Z7M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pPa2b3hug3TxgYxUq93Nl/+RZGBUrqkEsLIgGkT2ogr//N7Gxta6VseFHBH5WJVnpyOiW1i5bAM0sBu/sutz8SCU0k+Ph2bp5T2HgzbKqDY3RmtCJETmbKlGO+kQMtg7uQ7VZ+LH3zVERWrfUbNaYtJkaNY694G+69eTo8w9cTM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NHtaRJzT; arc=fail smtp.client-ip=52.101.56.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ML2wO+F/kG6xLAiT/lUnMJAJTo249CmtcAVQJn4Rtsz8YpVFnTQgXeB0wCMLA29VU/nIWP+YJw8Kpg5trx21H5CvcG/B6iWHbJaS0G6mzvIZ0WneBGJ/xmUFjB7tJwu7mTR2E5u6obfNyozeXQCVvkPNTJdIXgx8VXR3Uvh1WqA28SjILZIw3BFT69IWW0K+lcX9poS09Akrgzwl/T4ZUxcJ88rKCpTHr19fLeXuQdxtLQ/CCyBKa5KvWiHw0HC9yfB1oMYScjIEGMLQD8kCaXE5GXROg4onj9pQr7t0Sxzyt2LrpUgNPX+FiCfYEVnSlSGghDSddt+kraqb1TnoFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g3nTSAVrzuX2EDjOyZDApiZXz/wmVpFG8hwYvGzVtd8=;
 b=E4bQFswjsqxuvIjPpheDK+12eABHZs96yuQfsxKTWqk7W+1CrBYqOvYjGDQscY/7ZfQHiCACI7M/ciaBPfKarcNEDhcfadXEv5fTz3x3Tq3YvbwdbIQGHx2T48RlF9Z/put0Ty13YRpyonzExJaxQJSjMpXYkOTuXlBIfusOTengTkEKafihbWXBi7/LMRAv8vR0ATOl2GtuDdgL3ZnvoTr3Yrbn/RLekh/mByVrorVNrP0MKrRh4oeht9Pi4Vs5fbFsd7LualpK3yeKcMsoZxkcY2YkS3In0/LJARtZG8F5ruUNrYENhIuu+fpirjdx09qocSYb8oZlUWPQU3f8xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g3nTSAVrzuX2EDjOyZDApiZXz/wmVpFG8hwYvGzVtd8=;
 b=NHtaRJzTjkGNSe4WdPC4+9F47LzJV/UvOj4fU15xG1rEGrivIpIhw54Qcp8BobS3TGa0o172xkN0xqVisv7ONwCXM753+BwDpS77JBRW2wHvYiU4pAZ2fHPioOWIrEmkwBjTDv6dc/EC3I5zzqC5F2/er33P47y6GfINQDGq1EM=
Received: from CH3P221CA0026.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1e7::27)
 by IA1PR12MB9529.namprd12.prod.outlook.com (2603:10b6:208:592::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Thu, 22 Jan
 2026 04:56:03 +0000
Received: from DS3PEPF000099E1.namprd04.prod.outlook.com
 (2603:10b6:610:1e7:cafe::ad) by CH3P221CA0026.outlook.office365.com
 (2603:10b6:610:1e7::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.11 via Frontend Transport; Thu,
 22 Jan 2026 04:56:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099E1.mail.protection.outlook.com (10.167.17.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Thu, 22 Jan 2026 04:56:02 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 21 Jan
 2026 22:56:00 -0600
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
Subject: [PATCH v5 7/7] dax/hmem: Reintroduce Soft Reserved ranges back into the iomem tree
Date: Thu, 22 Jan 2026 04:55:43 +0000
Message-ID: <20260122045543.218194-8-Smita.KoralahalliChannabasappa@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E1:EE_|IA1PR12MB9529:EE_
X-MS-Office365-Filtering-Correlation-Id: dfe248b8-4c8a-41cb-3e84-08de59728ae7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QzWNTBK/3cVNexX9wt182EZkrRhPkfSzavty3AsoiO9ah7F7i2XWLpMbwcjB?=
 =?us-ascii?Q?jhSbuAsETDrgvpiSe7kBahjYHAJ98rQymeb/1/wLeQLfXT2fT67zli78O6Ql?=
 =?us-ascii?Q?d5Vf6XEmYiqx5wKD/awWHYZaMG5WAKLTo5YPRHgwpWs6rMwwHxlfZK9wttrJ?=
 =?us-ascii?Q?B/petbumfb7NsVQFm5ZWR4X4bCPQnWRAN/ARFA5xodrqZ00ELCOxEmwGhRHj?=
 =?us-ascii?Q?hKYvZDW2oXrrWiVcTF14e1qx+GSjHPxFdbciLAWysf89u7QEsaEvNZ6Ks5wY?=
 =?us-ascii?Q?HF+wshUrBtljR82qfP9IvsIH/wG/F5f5XPXmk4K/E1Sg9ADexMyCKGMBicS8?=
 =?us-ascii?Q?sll6VtyLjXbEwR46vWc92Uc5qoJZ8Ese/7+tuKHjogbl9hVLAMZhiW7eNutK?=
 =?us-ascii?Q?GmlnXE6alRrWyb9mp1oLbu0a/+zIza86BJw/TW1myCNmp1nFIwYCrfFT8HRS?=
 =?us-ascii?Q?cznawrRx6K63hH9ubQ1B6nxgi4/PgA4RLqtLCFMGcrkylw5uE5D6ASCRk8TK?=
 =?us-ascii?Q?YUmrsMW2+YdcIfoDdHeBnWZ2+sXdBFzLd1pfHKPfaPcmFADka7QgCH+2w8LV?=
 =?us-ascii?Q?tSaPVKKOZEJBIOxUaz5gFCq7Us8gejPhvmhTBkahCoqsnxxznQveKTUcZlUc?=
 =?us-ascii?Q?C9dX+7T/jS0/iKpK9tboLHelOtTtthP4xjjPEFPOxDC37wGzlExKdXAri6g/?=
 =?us-ascii?Q?HOzlpIlpjsbX0uysz5QX4XfMMH6e581WHfWB0hJNCNqu+aRvhG+DQmz6tD5A?=
 =?us-ascii?Q?TBvmC47Uoa4ElQawPje6Q7ApILBjAxQZfedaeebNqVZF/kpuNqJtrCG34lB3?=
 =?us-ascii?Q?C9B3SioChBEbYZg4etzK7iIgVLWEoHighKLJUbFK8eThryfcZHoybed4qe96?=
 =?us-ascii?Q?B23l0fMPixm5LnxrBvY9hJzaiX0S4x65qqj2U/Z+jQDPdlay3lLG+2aUYLW4?=
 =?us-ascii?Q?VCefw7r8dd67rDuAMIJqVoMcgursNHlHMEgzwlR6cTANJtVL6mtgQ3zIFV3X?=
 =?us-ascii?Q?ZskwJDiv13zSITljRlvE6CvKek/X3nIZzGTB4FZtcj2rnmSbIx1CV3p3fuW2?=
 =?us-ascii?Q?I5YLc5BBHKtq3EAXLKdw+krIoq3J/SnyVLF3osiJphXm8aLxOarHxlzBhNG7?=
 =?us-ascii?Q?d2lGnLK/9am0fQqyf0QPQSR2V7kXKPlY9XZG19fqhS3nFJ4HiT/apHNtd+c2?=
 =?us-ascii?Q?Dm/O69wTi9ASwSqK8i3yCCN8llO9+d64lj+YNTCKeows+ti3g6anEDrxc/te?=
 =?us-ascii?Q?k9ZpVMC/3obF7JsdXlTVqDOt8XFFeSEYXL3w4dT/CQS8n5eTmzWjZRWuajSH?=
 =?us-ascii?Q?WkcLAEvUwaUjoYzVxVo2BxxpmScwSdw3A+xtgtCA2Mtv4ccS0v9ku439xxfh?=
 =?us-ascii?Q?9HDZuQQKq1V1X1jJEqbBZ3vA3CZqzgmGnQ24+tCbbXQav+4XhxI92nE5Tqf0?=
 =?us-ascii?Q?GQU/S7BBCGnaQx3JWyVxFfCnZFXWuNSc1A++NMdz2fJYm43okHzoL6ghPvUq?=
 =?us-ascii?Q?iNOMpjnOiu1sfl0O9uGz3Dcwn6CskTjqyW+fQGrC3FVZBL4v2HeE+7rTlAH2?=
 =?us-ascii?Q?F3lvfWpDDLj1XDw3lvsAkSvCVmr/DQE6ELZLAGDn7tr9jUyMQ3nLoV2T0wFk?=
 =?us-ascii?Q?o7i3UUOQJgC8PV5wSpFMdV6B9U7MHQI2qkbuJJnpq29WrQvmAjKg4onM367w?=
 =?us-ascii?Q?nKnWVg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 04:56:02.4250
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dfe248b8-4c8a-41cb-3e84-08de59728ae7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9529
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
	TAGGED_FROM(0.00)[bounces-74975-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,intel.com,huawei.com,amd.com,stgolabs.net,infradead.org,suse.cz,zohomail.com,oss.qualcomm.com,gmail.com,fujitsu.com,linuxfoundation.org,alien8.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Smita.KoralahalliChannabasappa@amd.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[amd.com,quarantine];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,amd.com:dkim,amd.com:mid,fujitsu.com:email,intel.com:email,huawei.com:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: C680C61DB5
X-Rspamd-Action: no action

Reworked from a patch by Alison Schofield <alison.schofield@intel.com>

Reintroduce Soft Reserved range into the iomem_resource tree for HMEM
to consume.

This restores visibility in /proc/iomem for ranges actively in use, while
avoiding the early-boot conflicts that occurred when Soft Reserved was
published into iomem before CXL window and region discovery.

Link: https://lore.kernel.org/linux-cxl/29312c0765224ae76862d59a17748c8188fb95f1.1692638817.git.alison.schofield@intel.com/
Co-developed-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Co-developed-by: Zhijian Li <lizhijian@fujitsu.com>
Signed-off-by: Zhijian Li <lizhijian@fujitsu.com>
Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/dax/hmem/hmem.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/dax/hmem/hmem.c b/drivers/dax/hmem/hmem.c
index bcb57d8678d7..f3ef4faf158f 100644
--- a/drivers/dax/hmem/hmem.c
+++ b/drivers/dax/hmem/hmem.c
@@ -64,6 +64,34 @@ struct dax_defer_work {
 	struct work_struct work;
 };
 
+static void remove_soft_reserved(void *r)
+{
+	remove_resource(r);
+	kfree(r);
+}
+
+static int add_soft_reserve_into_iomem(struct device *host,
+				       const struct resource *res)
+{
+	struct resource *soft __free(kfree) =
+		kzalloc(sizeof(*soft), GFP_KERNEL);
+	int rc;
+
+	if (!soft)
+		return -ENOMEM;
+
+	*soft = DEFINE_RES_NAMED_DESC(res->start, (res->end - res->start + 1),
+				      "Soft Reserved", IORESOURCE_MEM,
+				      IORES_DESC_SOFT_RESERVED);
+
+	rc = insert_resource(&iomem_resource, soft);
+	if (rc)
+		return rc;
+
+	return devm_add_action_or_reset(host, remove_soft_reserved,
+					no_free_ptr(soft));
+}
+
 static int hmem_register_device(struct device *host, int target_nid,
 				const struct resource *res)
 {
@@ -94,7 +122,9 @@ static int hmem_register_device(struct device *host, int target_nid,
 	if (rc != REGION_INTERSECTS)
 		return 0;
 
-	/* TODO: Add Soft-Reserved memory back to iomem */
+	rc = add_soft_reserve_into_iomem(host, res);
+	if (rc)
+		return rc;
 
 	id = memregion_alloc(GFP_KERNEL);
 	if (id < 0) {
-- 
2.17.1


