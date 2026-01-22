Return-Path: <linux-fsdevel+bounces-74968-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cAfqEfatcWlmLQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74968-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 05:56:22 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E4DB461CD0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 05:56:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 89FE04F04AB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 04:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1924657E7;
	Thu, 22 Jan 2026 04:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JcdbrGub"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010000.outbound.protection.outlook.com [52.101.61.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645ED3E9F76;
	Thu, 22 Jan 2026 04:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769057761; cv=fail; b=SmoZyk6WQdZ6x6p4DtWnx/gDU/G3PR7TMmubdcp9n/NuIHa4mGXK6/rGyJ5o/kDiWg7+laIiDaXpz0+OM++PZ2KWoe+xejd/Z1iwbdA+YcWKrUwWd24opvzMnct2PbqLM+PKQ1E8a8EE9AsQLFvXLzGW44Abj3lbqd6Cooe+uwM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769057761; c=relaxed/simple;
	bh=taErEWo3wtb8SoJX2kUl2b5x7FDoHkAAjaNHQDrb4Vw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=D5KjmMMRDf4MZBPSdf3GdwclbO/RxmQ78g88ebWKh+tFjA7MuV2GBw34rurX8LkM7hrctuAXZT6vWUN6hmjSfFMWjl04Uj4TO7FISRajWqx8xJRPuCAD9AukiEPdpp6K+Jmt2o4t0Jmxni1WADiYW9ENT2WRuUvowJAXB7SXYDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JcdbrGub; arc=fail smtp.client-ip=52.101.61.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vxMNJcUqOXlMc/5rwu6uoe65qpPLReD8xQCYw8RxE7hQtKVFJjcO/emPTnPn1ML7yuXN3HHnXxVKuQTHQ8M5QSkMRr6BqWjNlR2z3e0NNzbv2i+FMaAwWMfz9lRuK4DXkDbUFfTT5Le8+N3n81AFDjrxOHgtnrcTRvR21IA1tMUXYYeaLvupKlkTJBRLnigsxQ+dvWOLT51CiDRCgGw4+61h7JLo1kuE/ZtqlvpfCJYHuDgW/Nj37N1SV7xhLr9soo976RGFtUDpZz/HN9JavFxbycQ89zk2wi2OpJnpdtZqVuvVyWKN7I1TnFyeyl6xw1+QZ93qYVfZOK/5UL4mvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PY+/9yI2DkjPtD2WbhVRo6+166R0+Mpz+watVViGEjI=;
 b=HfkYZSqtkaDbk6ZM2tChTaJhUv5On0NvU0B9eU8WnV/JwXDvUvf3V3/U01GiBrH/L4qe7pKJSGSsuGbakC9leenBxN6VXSFVc8xLXIRQDu3SZmnvJNjkrxpoTh2fYNWfLhi+hhS6sr9t1UVa3nF2QdWTk1L4MTRc8HZPYgchvgCVEQDaxgRIwGZmTD9NpFPaHRI1GT100Rhn/Jx64KhdWXb9ciW745bGTKmfFmamyp/Xv9d7fuF97xh60XG6abip/vvIpOfDUPP4Esq2k5SmdwQeDYPG4cz6nt9ZhzWm4JKQaHt/+l5qr+R6MczLUK9GiKw8Nxf75zxRveumv/0C1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PY+/9yI2DkjPtD2WbhVRo6+166R0+Mpz+watVViGEjI=;
 b=JcdbrGubWFcuFyvU77i/L4l+/+H2rJj6le8VP54tNQGAv+I32GePSuAfLEdMNj576VB91Uq8WCX4DpS5HiDdab2X8zHHfu9imhwuMJar2NToJctlVL/B11BhvVvh7zs21nAS2U8Mcw3DXSGojrJeSgUYUk0JqMnh9JdXEwGRIfg=
Received: from DS7PR05CA0085.namprd05.prod.outlook.com (2603:10b6:8:56::15) by
 CH8PR12MB9816.namprd12.prod.outlook.com (2603:10b6:610:262::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Thu, 22 Jan
 2026 04:55:55 +0000
Received: from DS3PEPF000099DF.namprd04.prod.outlook.com
 (2603:10b6:8:56:cafe::63) by DS7PR05CA0085.outlook.office365.com
 (2603:10b6:8:56::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.3 via Frontend Transport; Thu,
 22 Jan 2026 04:55:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099DF.mail.protection.outlook.com (10.167.17.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Thu, 22 Jan 2026 04:55:55 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 21 Jan
 2026 22:55:53 -0600
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
Subject: [PATCH v5 0/7] dax/hmem, cxl: Coordinate Soft Reserved handling with CXL and HMEM
Date: Thu, 22 Jan 2026 04:55:36 +0000
Message-ID: <20260122045543.218194-1-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DF:EE_|CH8PR12MB9816:EE_
X-MS-Office365-Filtering-Correlation-Id: b0f10887-24d1-4960-bcc1-08de597286a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+0dq455H0gKCQv9BTqg57zp0W6n5/HkvwT5w8CmoLgk5SQ6ZzWi82RsWUaGp?=
 =?us-ascii?Q?2Ux849U5k2z7SnlzX2xsm5rfpKKMkKThsfc8o2gWZHGFoVnwpR9G5+ZYyhcA?=
 =?us-ascii?Q?dHwqRDU4SojxXmeRjazQgXJ4no1CWSCfSfRAfFYroRuclfAtdfpK+idqLKCs?=
 =?us-ascii?Q?ZaClMHgxWR5NbUCcmO0pY90v5bfUAVL+UbuIja7/ybkPD+u2VRXp5W45jXMO?=
 =?us-ascii?Q?M/CntbsPr7Lk9wy/9xIhgGO1n/DnB74PS25HhlwHJJDkIID1y2ayzTVUHWbl?=
 =?us-ascii?Q?S0Yc2gz6iMqg16J4gZvk/EE4rglOlfVk6IPCaFivGHIpWopLeDu1LZ3GJb+I?=
 =?us-ascii?Q?5Av8NArs79TUCT1OVjir9jIhbbPdm9mildgONzRfqma+MqPKaCZL04kDsQJp?=
 =?us-ascii?Q?oskTQo6BUog2q2R3WZucRM6YIij5KwBAPTbOdJpMkBBHJn/UMxADrvgcCvkv?=
 =?us-ascii?Q?vEcJNCuOPegUhg6T+K25YGOksejhFkK6NFVyUoh36v6hz4iNiU5ORzUbYKxQ?=
 =?us-ascii?Q?ZropHO1RScOyQy8w0gJCX2BIcxb/I7jcpmLDc8aAEMmxawtAuehiSMrRx2n9?=
 =?us-ascii?Q?aa2VBx2NCooz2mwRddEgkSykrxBnMn760gpk4guHHqqLMFApxoHvMqZ+RbdG?=
 =?us-ascii?Q?md+vjkl2DakaEUi7GB6OvewoLyVyA5X1lqa87nR1TNdgV7CWYvkt3epZEIM9?=
 =?us-ascii?Q?tJg2mEcEtPcICnLIK7SYj3p1kGXS9slOtclke3CYKEnIRywuLzL3jCvI8vCC?=
 =?us-ascii?Q?lG101Z8mqILhvFhUQkCk1lfZHjJq4ZJQMv7HsmQDZbTtxv0YqfyQ2Yi9p/W0?=
 =?us-ascii?Q?ioCzWCzPRPFL2aKglntNMtBsRmwAX/onyYRGzDmN8IlEPDC+TUEQykH1T/SI?=
 =?us-ascii?Q?i/GJDilG77To4QJVT5kqffxt6cMIR5OQjSFcp9b3fbc9Bm1UpdyeHjlT4Kcg?=
 =?us-ascii?Q?KJyL9OuFUg84k66D6xEJdtFDqsafz41pguvJ/MYyyAXH4riT7bj1dg4VZuPJ?=
 =?us-ascii?Q?ZUg8WoA+8xDXsxeA6hQw8rxmp9S0WpEfgySPN7oukN5rBOfdsgrhqRsMi6wh?=
 =?us-ascii?Q?IcjbgzN83XahuDBQ52fmEaHnqN2U7wnaYJiMJl8ea/LvOKEPYVlyWQNyF3oN?=
 =?us-ascii?Q?x+7LIFxNNeZEXtvcwZE6NqbibU/ritvpHmPSxVTlKcn8gLTGwY3sFUgAIdYj?=
 =?us-ascii?Q?lrqYyi4GhBEer9ZrCtD2V+qbOsK0OueSW0M4vLLw6LqrRvpn4yv3KAEhrmys?=
 =?us-ascii?Q?SXORfpix1u2Aedi0fQwtJ1m9xanKuJbBs1XLlQLkjnrHiXpLc0IN9RXjPwuM?=
 =?us-ascii?Q?gE4fpu9d9nIkp0XDrGPK+gQvPAvW76jCExfHvULJ1mr5GxW3fws5sWEm2ETk?=
 =?us-ascii?Q?u59dPDWwkFIMxIeXA8TOd1Ff9EuDQEEoQql6ovYo5J6L8rcLemyHFSk7wY97?=
 =?us-ascii?Q?2FKVNCtIPAd2E05UE7QHA0N0YgCnQ0lfc1q/N0f519NbMc4L86e4dep7ASFM?=
 =?us-ascii?Q?BCxQ4MgUAboPKIlPJxN+EgYdmaqeUZsaq4LfEdmJ+uFVhyBs2xuNL0Lv+gEB?=
 =?us-ascii?Q?8SxYcjq/fEe9TG32Bv4NuAgcDF9hGieLwiDIqVf13VPY4i5qKxDRQ0a9qd+/?=
 =?us-ascii?Q?dIqTmX6Ey+lPJoncMYNJ/ll0VhSqcogVG35Ef1tTv9uUvu/bGsbznH2lpD+q?=
 =?us-ascii?Q?Sou1vGrsOXEE3YnoQIOvwyah2TY=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 04:55:55.2544
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0f10887-24d1-4960-bcc1-08de597286a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9816
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
	TAGGED_FROM(0.00)[bounces-74968-lists,linux-fsdevel=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:mid,amd.com:dkim,dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: E4DB461CD0
X-Rspamd-Action: no action

This series aims to address long-standing conflicts between HMEM and
CXL when handling Soft Reserved memory ranges.

Reworked from Dan's patch:
https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/patch/?id=ab70c6227ee6165a562c215d9dcb4a1c55620d5d

Previous work:
https://lore.kernel.org/all/20250715180407.47426-1-Smita.KoralahalliChannabasappa@amd.com/

Link to v4:
https://lore.kernel.org/all/20251120031925.87762-1-Smita.KoralahalliChannabasappa@amd.com/

The series is based on branch "for-7.0/cxl-init" and base-commit is
base-commit: bc62f5b308cbdedf29132fe96e9d591e526527e1

[1] Hotplug works. After offlining the memory I can tear down the regions
and recreate them back. dax_cxl creates dax devices and onlines memory.
850000000-284fffffff : CXL Window 0
  850000000-284fffffff : region0
    850000000-284fffffff : dax0.0
      850000000-284fffffff : System RAM (kmem)

[2] With CONFIG_CXL_REGION disabled, all the resources are handled by
HMEM. Soft Reserved range shows up in /proc/iomem, no regions come up
and dax devices are created from HMEM.
850000000-284fffffff : CXL Window 0
  850000000-284fffffff : Soft Reserved
    850000000-284fffffff : dax0.0
      850000000-284fffffff : System RAM (kmem)

[3] Region assembly failure works same as [2].
Before:
2850000000-484fffffff : Soft Reserved
  2850000000-484fffffff : CXL Window 1
    2850000000-484fffffff : dax4.0
      2850000000-484fffffff : System RAM (kmem)

After tearing down dax4.0 and creating it back:

Logs:
[  547.847764] unregister_dax_mapping:  mapping0: unregister_dax_mapping
[  547.855000] trim_dev_dax_range: dax dax4.0: delete range[0]: 0x2850000000:0x484fffffff
[  622.474580] alloc_dev_dax_range: dax dax4.1: alloc range[0]: 0x0000002850000000:0x000000484fffffff
[  752.766194] Fallback order for Node 0: 0 1
[  752.766199] Fallback order for Node 1: 1 0
[  752.766200] Built 2 zonelists, mobility grouping on.  Total pages: 8096220
[  752.783234] Policy zone: Normal
[  752.808604] Demotion targets for Node 0: preferred: 1, fallback: 1
[  752.815509] Demotion targets for Node 1: null

After:
2850000000-484fffffff : Soft Reserved
  2850000000-484fffffff : CXL Window 1
    2850000000-484fffffff : dax4.1
      2850000000-484fffffff : System RAM (kmem)

v5 updates:
- Patch 1 dropped as its been merged for-7.0/cxl-init.
- Added Reviewed-by tags.
- Shared dax_cxl_mode between dax/cxl.c and dax/hmem.c and used
  -EPROBE_DEFER to defer dax_cxl.
- CXL_REGION_F_AUTO check for resetting decoders.
- Teardown all CXL regions if any one CXL region doesn't fully contain
  the Soft Reserved range.
- Added helper cxl_region_contains_sr() to determine Soft Reserved
  ownership.
- bus_rescan_devices() to retry dax_cxl.
- Added guard(rwsem_read)(&cxl_rwsem.region).

v4 updates:
- No changes patches 1-3.
- New patches 4-7.
- handle_deferred_cxl() has been enhanced to handle case where CXL
  regions do not contiguously and fully cover Soft Reserved ranges.
- Support added to defer cxl_dax registration.
- Support added to teardown cxl regions.

v3 updates:
 - Fixed two "From".

v2 updates:
 - Removed conditional check on CONFIG_EFI_SOFT_RESERVE as dax_hmem
   depends on CONFIG_EFI_SOFT_RESERVE. (Zhijian)
 - Added TODO note. (Zhijian)
 - Included region_intersects_soft_reserve() inside CONFIG_EFI_SOFT_RESERVE
   conditional check. (Zhijian)
 - insert_resource_late() -> insert_resource_expand_to_fit() and
   __insert_resource_expand_to_fit() replacement. (Boris)
 - Fixed Co-developed and Signed-off by. (Dan)
 - Combined 2/6 and 3/6 into a single patch. (Zhijian).
 - Skip local variable in remove_soft_reserved. (Jonathan)
 - Drop kfree with __free(). (Jonathan)
 - return 0 -> return dev_add_action_or_reset(host...) (Jonathan)
 - Dropped 6/6.
 - Reviewed-by tags (Dave, Jonathan)

Dan Williams (2):
  dax/hmem: Request cxl_acpi and cxl_pci before walking Soft Reserved
    ranges
  dax/hmem: Gate Soft Reserved deferral on DEV_DAX_CXL

Smita Koralahalli (5):
  cxl/region: Skip decoder reset on detach for autodiscovered regions
  cxl/region: Add helper to check Soft Reserved containment by CXL
    regions
  dax: Introduce dax_cxl_mode for CXL coordination
  dax/hmem, cxl: Defer and resolve ownership of Soft Reserved memory
    ranges
  dax/hmem: Reintroduce Soft Reserved ranges back into the iomem tree

 drivers/cxl/core/region.c |  58 ++++++++++++++++-
 drivers/cxl/cxl.h         |   7 ++
 drivers/dax/Kconfig       |   2 +
 drivers/dax/bus.c         |   3 +
 drivers/dax/bus.h         |   8 +++
 drivers/dax/cxl.c         |   9 +++
 drivers/dax/hmem/hmem.c   | 132 ++++++++++++++++++++++++++++++++++----
 7 files changed, 207 insertions(+), 12 deletions(-)

-- 
2.17.1


