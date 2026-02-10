Return-Path: <linux-fsdevel+bounces-76815-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cKT1MWXUimnrOAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76815-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 07:47:01 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B1811777C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 07:47:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E25630495C2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 06:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A18A32E721;
	Tue, 10 Feb 2026 06:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RBHzIT/s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011043.outbound.protection.outlook.com [52.101.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE9632ED2F;
	Tue, 10 Feb 2026 06:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770705925; cv=fail; b=loAKENBkMHfmB2wVCXkJrLLwe6MldUaZahsWDyC1mMAVM5wpMhgwqCgPQgkUkzOrIJk/jIF9g68ojQDOBYGzEIyhirFWPrwmgOvgpgIj3rHjryLk5T1RJh6Fr3YGGJQCYl8zlE6B0iofTUT6ElgRCX8csMFUUTG25FNky58VO04=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770705925; c=relaxed/simple;
	bh=8g5Gx999PXIPj9OmtrqxdsnpOpEIQKvxtpJaTp83EeY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rrBXB1Ho5+ZWmTvy6V7aOjweGJi1SydoheefNLbIJlgy4oq8xZjrgFvsZ/x6RmBn3IftkvNZbAVUuNMvPCNWxB3o8inefMMI0f/DXD8/h5Cz3cpwZiaIbGVbO5w/csgJGomZeaOc3YBITDJtRXX6T4DUBwIfU8bkAu/1BCyOZQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RBHzIT/s; arc=fail smtp.client-ip=52.101.52.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GvAL5PW3WO66+LU0yg5oF/fPzV9LH/rjdeBNt1eIPn1mY+JmWQvBCc/pIp/E/0kzEXbWX4k2j9Z1DH3jt8tcvPXL7yO54n9847sOxLViyB0TQ1ZU+p+HiuIrng9bSAFRfCVzur085n3Nx1BddDovWG4k47mmeeZz8xRkVXXoaxcZqULcowP2bC0UMKrwoVZgfi/NwnMMfC+raxMfgKNuGnADhyxufZ11wu4FlJTyUQeQapzuzrA+oRUfW0CCQfyJTVN+dn2hXBiZqHmVnefhcTfzTFOGFmuC6vMjq70Zz+Kao3vQwrPcYPSIXwZkjSXiUUfLq0ZgM5ehqLYnShmhng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aAEd6VmrtKi4O5rc1S+RYxyvFriIm79YBxdxqvQP81M=;
 b=lWUE4vb0pXnsVP7YfqiZfCmtQ3im0ykMBJsyzScQiOWz9/Z28zIWPz9gYHNcQmLRW+3UXTIGIrg3rSofBaUdKwqlW90lrP4reHBApN6NPtJGmiFuoVgHziGxqvVEqqVfGBYf0gTwLvDIjWh58u22sWqvgb/NYRTtKanV+A5l7Gr5IjfNCA8DcdnJJKF6o1u+0ea7ai4UCX7ABDeae/R2Oa100q+6Ozmb8SAfr1yv5Xye9apyQc3MOW1Z2QuxGfipaYLhRfVcrApdH5aCKGITBj5GjxIlotBTdQkfY1GGranW1ldXGBF5I2o/21ykh6+uBK7vMKv7dKVD81OrXxV+Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aAEd6VmrtKi4O5rc1S+RYxyvFriIm79YBxdxqvQP81M=;
 b=RBHzIT/s+6CCmIsB0KbP/jVyzMQF4wLezEe5k2o3ut49nnsutN8cbrGFtjbAIwY3nfw0H5/jgsUsPmFppP6dsbFoXMCZf/C2L2I6bJhc4/C1YHRx9eQJ3mzbeINjbmKwpi0MxJD0AlQ9HfMS48q4q7HOKxpw8ygNm2fUDt7xBh0=
Received: from SJ0PR03CA0009.namprd03.prod.outlook.com (2603:10b6:a03:33a::14)
 by SN7PR12MB7201.namprd12.prod.outlook.com (2603:10b6:806:2a8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 06:45:18 +0000
Received: from SJ1PEPF000026C5.namprd04.prod.outlook.com
 (2603:10b6:a03:33a:cafe::85) by SJ0PR03CA0009.outlook.office365.com
 (2603:10b6:a03:33a::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.18 via Frontend Transport; Tue,
 10 Feb 2026 06:45:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C5.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Tue, 10 Feb 2026 06:45:18 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 10 Feb
 2026 00:45:17 -0600
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
Subject: [PATCH v6 3/9] cxl/region: Skip decoder reset on detach for autodiscovered regions
Date: Tue, 10 Feb 2026 06:44:55 +0000
Message-ID: <20260210064501.157591-4-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260210064501.157591-1-Smita.KoralahalliChannabasappa@amd.com>
References: <20260210064501.157591-1-Smita.KoralahalliChannabasappa@amd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C5:EE_|SN7PR12MB7201:EE_
X-MS-Office365-Filtering-Correlation-Id: f1be60fa-bdb3-4e6d-4a5d-08de686ff46b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?STXUz3PokPvwAmvkyWQQQ1HpRsJkZgm3u/r2+UNpUHqgEqG5AL76ZF7pWdMd?=
 =?us-ascii?Q?M4zHNJUo6YfQBCCMmdmVLCCjNlgQHJ7pQScRDLc5oRq8NoXndXqCgozL/B7M?=
 =?us-ascii?Q?C9ziZc3UDZmUXg4PHo063IdguJS5aPYOp6Pxdv2AOHaknNxomVlgVxDmxMLa?=
 =?us-ascii?Q?9qgZ+Zjd7vwbiz+0EQCH8fxJ7wC0FA06THTN1aNgP9MS9/qB0KrTPsl/H+pR?=
 =?us-ascii?Q?WfdPzi/sPtWutARZye9Is5p+0rgkPkIm9qys89+789q4F0nUs3YE9qfNIxGm?=
 =?us-ascii?Q?gMWdwG9HotgenkiPh/o2cnE26fqlfYbq1Cn5uh9nEUupjGVr2QYNiD/e87W8?=
 =?us-ascii?Q?53ys2mnKa5RvD2wapwRnSjbE+PEpbf7/XKEW5B+ABeiY/npuCXx7JwinVfnF?=
 =?us-ascii?Q?1l8eysyBEp2QMA49l/U24d7lcIpITiTJYC4M2uXuj6yLdGCcaepDXeoicZN+?=
 =?us-ascii?Q?HPlY4nmhjS4r7oMDnB3jFSdpiLuSdUTV1KXW6nRQ76aFVLuJii14G+UzAwuE?=
 =?us-ascii?Q?Hp1OvNGcS4+G22kkicRxUAWoMWOYB4MsFIrvZqnvx/AZYKqXCgT7xP0N+UKx?=
 =?us-ascii?Q?FQkMhYn5evgFStPEr7qCib67dDxiseWtR4QGOhVR1nIbBOVo03oEUFXiwwGD?=
 =?us-ascii?Q?fFukYB6aSIbCxIzX0gF99Id7xx5KOHmAByfwI93h1J0wFzzgru2S+eaqEF/i?=
 =?us-ascii?Q?COwlztaQShCBVbucHllMVZzzPON9+at78UKMIUE+Lp7sXY8hTpnMi1G8EL43?=
 =?us-ascii?Q?E/8EUz70Dzwa0xPSmhhIvH8fUkzZBTAjWM23jUHS5y9mEdHuMLOm9Xy3aa2B?=
 =?us-ascii?Q?XeFTWP0woRgHD/aUWDYHh1SOHMcwwYJu5ybxTJxb0OjB9yW3c+WxPTWG2mpS?=
 =?us-ascii?Q?LTCQB/5wjasE7kxqC4eG/URWXsJmX4jQAj8i6tJ2btRV/qqSJq16pBaVfK4H?=
 =?us-ascii?Q?6+FghZfJbBRVC8aDe2zMBIXQDGXlxkunY/TkhpF80c5hIzG5mxHgQd1HxkMh?=
 =?us-ascii?Q?RwxprdihYGgjJXff6apDaPeJfWhLNh6MeklSN1hECgebDJo2saSvoSP18yF9?=
 =?us-ascii?Q?PrhuiGOxH+YqZEwlIy/SFEoDaylgXaEF9HsGQiyj/3nyl6pf2f6s3tx/RQqz?=
 =?us-ascii?Q?1wODBKnuMWG4sAVi1Q1+FF1RsH6YRz3+CoyPQeftxo/jpzvD3C/OE0ZqFCQV?=
 =?us-ascii?Q?VQ7M4vcQHDpKVptTioD03GEl4BmeU0Hx2OV62vI6qkCysl6emqIbpE1Eyw3z?=
 =?us-ascii?Q?oATgqkHnrsIaiyQxfe5iF20tHJkrxs3fBZEls1Wl/aBsSMbWJUpbz5ezeRKX?=
 =?us-ascii?Q?CV0FD7O6LDoNAFYp6opCeykwGFwERbpCqXlKa7CUwCChTrkcyWxoPKlmy0Pk?=
 =?us-ascii?Q?lnLyDERB67VP/26+PKqMbfbOQOAjvGiXh7sf+r1wXHh4w9EG9oYayA3a9hHa?=
 =?us-ascii?Q?ocBhsWWTQU7hWHshAYC3D+aBFn1qv3SEtqu6MBkbOj4RYrkHfiknb7WFoagN?=
 =?us-ascii?Q?3hEJPikMhMJJz1John33H96du1XhRIs6oTBSPfUA3+hglRMqpGZ80LWm8GQN?=
 =?us-ascii?Q?vuB5eBx7/qgzmU4+qDymMFKFmuLwrPRAOVIwOQ/ZDEMF3RP2It7y1F/4JdbG?=
 =?us-ascii?Q?lgDpCJ1tgSdX9m0giCH749rf1fVWNBvGEWSLi9Zj3BgNlvTncx4ToSmAf4Cw?=
 =?us-ascii?Q?qn0IbA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	07tAYcUN4h1Lllp+Ye4PF2TL8PqoIQSxL/Jg0KofmfGo/QMbSB0VkLVmZWmFiHp6+nKxvyL6LZ4PyiWfSMwHynBd5uhyS2mX1DJYFF+xEDG9UG53uNw8Dz0y5hihM5zE64T3w5JU1TngO6zD+WB/3dvd0ovQPWGZ8QUxlec60uBZZPoW30twpi4uhyF+usBsvVC3zn+AflEUxjBh+TKV3RSiriBk1EhFhzVOjmozsRgXzxDPZPmogvgDvsfAPoutAAONNBtu96MBrooUOdya2GlLHqx+QzkmEsZUfc3+fbA5eFNgO6s2Xupz4pT0lwbdoZjGiWhHJNQvI7jLcLSCWaZv96Gd3+x31i/lUguQiUMjoi+7tqJ83HcdODuPFhKH3quePuJkfOT0px5DZ5hUJj3TePBn+oQDZzNXvnWaB/BJR1lzWPkJjXeHuvIJ/Qxe
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 06:45:18.3269
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1be60fa-bdb3-4e6d-4a5d-08de686ff46b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7201
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76815-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,intel.com,huawei.com,amd.com,stgolabs.net,infradead.org,suse.cz,zohomail.com,oss.qualcomm.com,gmail.com,fujitsu.com,linuxfoundation.org,alien8.de];
	DKIM_TRACE(0.00)[amd.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Smita.KoralahalliChannabasappa@amd.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,amd.com:mid,amd.com:dkim,amd.com:email,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 40B1811777C
X-Rspamd-Action: no action

__cxl_decoder_detach() currently resets decoder programming whenever a
region is detached if cxl_config_state is beyond CXL_CONFIG_ACTIVE. For
autodiscovered regions, this can incorrectly tear down decoder state
that may be relied upon by other consumers or by subsequent ownership
decisions.

Skip cxl_region_decode_reset() during detach when CXL_REGION_F_AUTO is
set.

Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/cxl/core/region.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index ae899f68551f..45ee598daf95 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2178,7 +2178,9 @@ __cxl_decoder_detach(struct cxl_region *cxlr,
 		cxled->part = -1;
 
 	if (p->state > CXL_CONFIG_ACTIVE) {
-		cxl_region_decode_reset(cxlr, p->interleave_ways);
+		if (!test_bit(CXL_REGION_F_AUTO, &cxlr->flags))
+			cxl_region_decode_reset(cxlr, p->interleave_ways);
+
 		p->state = CXL_CONFIG_ACTIVE;
 	}
 
-- 
2.17.1


