Return-Path: <linux-fsdevel+bounces-74969-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kKsKLRuucWlmLQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74969-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 05:56:59 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E5261D11
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 05:56:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 92AEE4E7F02
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 04:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174604657ED;
	Thu, 22 Jan 2026 04:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ize6AMEF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011003.outbound.protection.outlook.com [52.101.52.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64B94657EC;
	Thu, 22 Jan 2026 04:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769057766; cv=fail; b=lblIArV35eDR7c1LOQLdHV99TsKXfYihdDtv/8x5Y+O/5cMHNh/gkL6PZoYbrH8Q2g8YnuvggkLaG/dTicMee/SLErIsGsTGYbxaHA3QPphkKFKV7iyuwxC20zbPdrJmEtsJNEfs13nbEr746+eFHx+LbNN9OPZz0OaHJRYuNGM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769057766; c=relaxed/simple;
	bh=jpaWI8+HhUxeDlqEWFtrxMXxNG8pYPp0GeoCXLCV49s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qhxOo6lTLEXxeAurQjozhkXpEafFwTXMRo6NhbYleDCEpWCUjAKdp2Pc9Dksp3PlHpxCj90ffLr/uoUYjUQLKXDYsGRK3WpX3SIJuUAfIvZJYnvLZ/a5uPEbL6s7b7+IQHy4GZHKj37DeifhAQ27vsZ7HrI9lfjEsgUMDsVNOuk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ize6AMEF; arc=fail smtp.client-ip=52.101.52.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jon6+P3jqPk1bYtbn0vNi9nsXegtIlTFKBXIg5xjdmR8yNGxMvjlnQX61JNa4dMTe5VRH1kJMvO9SLYJFoDiCQnkiBNzxVr2cpVMxldjqG4H0UXy/mJHNuUWpBw1wPWqCmdatEksv5iylrvwg6PrvfUzR5IxAWbWjmN2CTL4mGXTfecihIBp8SzkmXeuPxDxn7DemaqR15LDlPamJtjmsNYaVUutDP5IyIC4nrlEKX/uPiNfqZTpNKp3kCS0XSR0yim5lFE8QxCSeVdTkNd+A7KcT0z/92fLvm+bGDUYYAjNZFzZCybaAoVjh1+nrJ32n/yFLHLW8F3PmxlVOXoT8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cCzW9G+VjXYcPMGsTsIlMVCC5Yd4oDjqF7gtCXZ9/0s=;
 b=Xs2ML3rzYNsgcN1YLiHC+AiC21f8ui5Zz3eYGjEGltFRB/drk54Ao+cJDnyEKXO2sjOn7foQIFLk9zAYPYAptWtLW85ZHU61wCPDXS0EmIW1QM4lsiJOFoUD0lexHi6zWoNbCr0lqOUV3WixKjECVPjrsIDugG2YcAjhYvuIXCKwb5atPCuKI173cg4kRMWX2U0OKeeXg5SMY956b/VZLrDhTQfPxOTO9Ep+Qt5ejNW3tuHisVc05X/EL7Y3oaajP+xhUm8BKTZ6vBbvOjdxzzu0kXBWFLvoRt9mTGYcwTCzf0JSb/fHu9MHulvnTLKaxBgWdHcdxyJBvKn6bS942Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cCzW9G+VjXYcPMGsTsIlMVCC5Yd4oDjqF7gtCXZ9/0s=;
 b=ize6AMEF3AfH2JOvtGqA95F9eAur3Ye5/8LPBnQ/0oROlkV2GK0dDgt9IX3HsgSNPnA6Ei1iCUoAVbj0xIgwc8MlwWE0ALh3JJ6D3/UnHYF2uN/yXkhfuSdDmBQEE8gctHu8buBCj9tMGhyvvF0esCBXZHzpNCjq7i3kIvpAXYI=
Received: from DS7PR03CA0220.namprd03.prod.outlook.com (2603:10b6:5:3ba::15)
 by IA1PR12MB6460.namprd12.prod.outlook.com (2603:10b6:208:3a8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Thu, 22 Jan
 2026 04:55:56 +0000
Received: from DS3PEPF000099DC.namprd04.prod.outlook.com
 (2603:10b6:5:3ba:cafe::39) by DS7PR03CA0220.outlook.office365.com
 (2603:10b6:5:3ba::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.10 via Frontend Transport; Thu,
 22 Jan 2026 04:55:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099DC.mail.protection.outlook.com (10.167.17.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Thu, 22 Jan 2026 04:55:56 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 21 Jan
 2026 22:55:54 -0600
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
Subject: [PATCH v5 1/7] dax/hmem: Request cxl_acpi and cxl_pci before walking Soft Reserved ranges
Date: Thu, 22 Jan 2026 04:55:37 +0000
Message-ID: <20260122045543.218194-2-Smita.KoralahalliChannabasappa@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DC:EE_|IA1PR12MB6460:EE_
X-MS-Office365-Filtering-Correlation-Id: 5af0b657-deb5-446e-e159-08de59728735
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|30052699003|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AwTViOPY7mKAjMe+XLampD41rIjCC4Fr7IAdkmqhfiDsY0zi44P/96uA4Vma?=
 =?us-ascii?Q?OVNt93hzxDOtTIXRJaMxmGYuICz2DBS5sm/5hwhQITdg/FgE4gZhi1j+tm1S?=
 =?us-ascii?Q?K2HkWSOpBgkh3I84jVmTKrwhBmIC/rCfg3n3u0JhuXS5naed+sWnx5ny/33E?=
 =?us-ascii?Q?WEKS+eo7Gi7aVj9PRfzjVMCa8WAaXF6jHaETVFP8Lw2Q5wszUWN9CmpFlUdw?=
 =?us-ascii?Q?oEvh3QKJv+DqBbykvsVv/WWjjcrhGWeS11w+UC5H6ZmGh4iXQLHlYeN96jF9?=
 =?us-ascii?Q?jUe0ddEwz5ZvV58+BoYODfbf8JkGNUBCcMOYtvuda+DlZ3DN25dfCSyh2p9o?=
 =?us-ascii?Q?YxbWCl/MmKZAERfUHimIXGyS5X4FXgfD6ka8Of4vqKLpsQKw63ozGu/QjUfk?=
 =?us-ascii?Q?N54ZZUCIS1dNEuG6EpeLXvn8WSccl2HpVhFpVILMayqOFWbet6D48mkRnqWk?=
 =?us-ascii?Q?E5t+IY8tF8V4jkRlR7pTQZd6qPjn3ZqbY83+n7U/XpvcEHl0n56sbQdOVjGx?=
 =?us-ascii?Q?gL08sB9Iea6fdCRDjij3nehMMBKpIMYuugLkzgVtye3RWSxoRc7RgyQpBexq?=
 =?us-ascii?Q?LTVWV33up3ifl8Re0S0TSTM9FwLhz81zbXvLViyLBi53gUKURyXemxGt0moj?=
 =?us-ascii?Q?T+ApmRdXc6yT66YJ+FZcMTGSDom2Gh87Uk9l9ee9xrTncQFtGbdKoyv3rWrh?=
 =?us-ascii?Q?lGEXTDE7rMbMy/4n6a+Yu3m9JbaTRep9K8C4F+sr+f1bE9eoxcVsUt7AoHSm?=
 =?us-ascii?Q?/s4mjBz6KniUUXhkbxNhkvhHbRuipikgcO9ujBNKfJgzWNLfhijLLDAHqjtc?=
 =?us-ascii?Q?XZ9+yeLjFDvItSE8niQ3hMN5CcO118Oab4b1j14PIPC2QyGGJCZxNpTeJ2nr?=
 =?us-ascii?Q?s1oSJAdXCQknvIVt4UlnkD7YVkMwgw8Z6g5J/TUhQvr4PsGH+xduQqbrxGSg?=
 =?us-ascii?Q?KnYkRqC0ANi5JZNrZoZF/jkZTkhEb5eZEaGS7sl2BCrR82Gl+MVXoOScAtIi?=
 =?us-ascii?Q?yt+IEN0GlDfA6f0s7HyzenZ7t+DK3vkl+882FeoWW9HrPSPTkNgYxcktkf3O?=
 =?us-ascii?Q?9LgDXiXkjhSzkiwK77LtoUn7lT42r/4OdLzTBMeyGvL1j3uiwSRzv1s/xZW7?=
 =?us-ascii?Q?VX5sQ0LkiNc09ihsloL2BWu+Q/0ExugGKuLgBckJoUPC1MnaY29U4Yy8VQyq?=
 =?us-ascii?Q?l6wLB7EBIsvDJImhpxxI5hUn5i+iEcdTb/Tb6Mu+GNA8Hg/xLN5J9O8CBYVf?=
 =?us-ascii?Q?W8pLBIsoT9hLzY8Xhrq6CnVBEXZgiPx9bq2L91/z/H88hooDLAHq9YjI+lmG?=
 =?us-ascii?Q?ftEGlQ6pwKSA2pVwj+xWhsAPDix1bQifHWPCzl+Flue68iYdEN+eoX8AsI6f?=
 =?us-ascii?Q?H2SCzB5x6HG/m/hY6n3xuuBpJ7IcS6u/atdzQDmvjSKZhplMa00eRksVuZP+?=
 =?us-ascii?Q?4Fd+jwrtWjWBOm5VFW1/P01gZnVK6BRipl41BtluBqmGHKJmq0UvRvpYHsr1?=
 =?us-ascii?Q?/pzPX7AiG1t6Tl+tiPJUrw3HrZ3sr/t5XBiaMkmNf0hI6GkVI6xuliWHqjno?=
 =?us-ascii?Q?KwshR2sy/83E25YaOk2xUzIaPXxLbyGHb3FLV1gg9cvBTVS2KFalNdtsc1Z2?=
 =?us-ascii?Q?8SflOQnJU+EY78B1G5ZW0Zfr+HcjSoIYe5iJHXx27ukrD2lU6Rp2MnBcEENL?=
 =?us-ascii?Q?KuPBtg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(30052699003)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 04:55:56.1996
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5af0b657-deb5-446e-e159-08de59728735
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6460
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
	TAGGED_FROM(0.00)[bounces-74969-lists,linux-fsdevel=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,amd.com:dkim,amd.com:mid,intel.com:email,ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 80E5261D11
X-Rspamd-Action: no action

From: Dan Williams <dan.j.williams@intel.com>

Ensure cxl_acpi has published CXL Window resources before HMEM walks Soft
Reserved ranges.

Replace MODULE_SOFTDEP("pre: cxl_acpi") with an explicit, synchronous
request_module("cxl_acpi"). MODULE_SOFTDEP() only guarantees eventual
loading, it does not enforce that the dependency has finished init
before the current module runs. This can cause HMEM to start before
cxl_acpi has populated the resource tree, breaking detection of overlaps
between Soft Reserved and CXL Windows.

Also, request cxl_pci before HMEM walks Soft Reserved ranges. Unlike
cxl_acpi, cxl_pci attach is asynchronous and creates dependent devices
that trigger further module loads. Asynchronous probe flushing
(wait_for_device_probe()) is added later in the series in a deferred
context before HMEM makes ownership decisions for Soft Reserved ranges.

Add an additional explicit Kconfig ordering so that CXL_ACPI and CXL_PCI
must be initialized before DEV_DAX_HMEM. This prevents HMEM from consuming
Soft Reserved ranges before CXL drivers have had a chance to claim them.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dax/Kconfig     |  2 ++
 drivers/dax/hmem/hmem.c | 17 ++++++++++-------
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/dax/Kconfig b/drivers/dax/Kconfig
index d656e4c0eb84..3683bb3f2311 100644
--- a/drivers/dax/Kconfig
+++ b/drivers/dax/Kconfig
@@ -48,6 +48,8 @@ config DEV_DAX_CXL
 	tristate "CXL DAX: direct access to CXL RAM regions"
 	depends on CXL_BUS && CXL_REGION && DEV_DAX
 	default CXL_REGION && DEV_DAX
+	depends on CXL_ACPI >= DEV_DAX_HMEM
+	depends on CXL_PCI >= DEV_DAX_HMEM
 	help
 	  CXL RAM regions are either mapped by platform-firmware
 	  and published in the initial system-memory map as "System RAM", mapped
diff --git a/drivers/dax/hmem/hmem.c b/drivers/dax/hmem/hmem.c
index 1cf7c2a0ee1c..008172fc3607 100644
--- a/drivers/dax/hmem/hmem.c
+++ b/drivers/dax/hmem/hmem.c
@@ -139,6 +139,16 @@ static __init int dax_hmem_init(void)
 {
 	int rc;
 
+	/*
+	 * Ensure that cxl_acpi and cxl_pci have a chance to kick off
+	 * CXL topology discovery at least once before scanning the
+	 * iomem resource tree for IORES_DESC_CXL resources.
+	 */
+	if (IS_ENABLED(CONFIG_DEV_DAX_CXL)) {
+		request_module("cxl_acpi");
+		request_module("cxl_pci");
+	}
+
 	rc = platform_driver_register(&dax_hmem_platform_driver);
 	if (rc)
 		return rc;
@@ -159,13 +169,6 @@ static __exit void dax_hmem_exit(void)
 module_init(dax_hmem_init);
 module_exit(dax_hmem_exit);
 
-/* Allow for CXL to define its own dax regions */
-#if IS_ENABLED(CONFIG_CXL_REGION)
-#if IS_MODULE(CONFIG_CXL_ACPI)
-MODULE_SOFTDEP("pre: cxl_acpi");
-#endif
-#endif
-
 MODULE_ALIAS("platform:hmem*");
 MODULE_ALIAS("platform:hmem_platform*");
 MODULE_DESCRIPTION("HMEM DAX: direct access to 'specific purpose' memory");
-- 
2.17.1


