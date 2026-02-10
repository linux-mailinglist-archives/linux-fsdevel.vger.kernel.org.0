Return-Path: <linux-fsdevel+bounces-76812-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKFkOCbUimnWOAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76812-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 07:45:58 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 45BD3117712
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 07:45:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 56F2B30378B5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 06:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6481B32F742;
	Tue, 10 Feb 2026 06:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="F7FTl2EU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013052.outbound.protection.outlook.com [40.93.196.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E22B20CCDC;
	Tue, 10 Feb 2026 06:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770705923; cv=fail; b=F6g/NcawuH8yYYeA0Frr81PkIwDfqFnsQoFbpQoNUBzcNGZQjtswyct7mBuPfCjue617s7X17X2rQps5WGw92F8WWJely6GfE3RHXbcyhvWc8aVOU+KYh+dEEGF2nV3/MWMmoXivAOmyeRPHozOYqLfu2w0SbC4lhik7eBZLOiQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770705923; c=relaxed/simple;
	bh=d7MDX3alLr0RvMXGd/hcCZzm0JpaASnGNF1iLF80qvg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OyBoyvEY2lYLe3vjOP/IQh4ZsiAb8yKjV3Po4tbN0QUWXRKUJSbO3o6G2JvduV6ktBQRzw1ebHiP4QyyS872KklGC0MG7lo0xYpxq+PaH4tTSkQBlvz7K+2kMyRnwHFD/nTPm7reMmtEj0VBchrs5m67qBz2fijitKOyGBHd730=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=F7FTl2EU; arc=fail smtp.client-ip=40.93.196.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mj8F64ohT/VfLB3Nx38+NMGmMKnO3mKDi4x1PzIBQyet1NWi0pkBkLzQWmPRuN7qkcxiby7+qhn2Xh739ZQYlTAWunfha/HxtenyInTLHSQkh55aPrHoLzqJ8aGQGByyr+jD1gPdV69mgWejxCvNwnsE9u/An2QoW13Rwq+aUe3q+hXgYJQsgnhBcyv/n4/PwIp4V6pUaWUJbq/MR7XOL0iDFjwtq9MevYcRFR+qYa6S9UBniCrsAJ84sH2Cu9D0n5+A8Bv94/P+GrvxKgWUOq46FGH4QvgDhpCdl1k/6Tx7lRL1vPy5Y/IgQzP2zjxj1b5OGshk3nN110Wiw9lLEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IK459voMZoyKk/oBtDN2JSV0mkRaD48bIM5ijPg4GRs=;
 b=rc+oapEZoqApHBVVMgtKpiFZUpYFVGoxLYtLWov582cZTBFvt01cfwd1+J+Glz9NhAcopyDfP05q/dhAKwPBqJDvFVglZeyOy1goPDfny0YkyojiLIPS/+SZ5a5UTqw01um+vYoAp0K5U7/fUcwgKoqkuHOziI1TMQfxunPgOjQ5/m/y1kUprCA04A3Seal0USLzr0PMFP98X1NmrAwAgAWD+23yM2dfGAJSRLe03Iz3VOQsLzHFqooD7Zq2VlJAhp9MMHaQP00N2YZdikWFUmUk9DG9/R/olgPpdQFgEbJOMezb7z2ryoW5ybV4d0oXTV7A/hDQB/PHycSgm5GtkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IK459voMZoyKk/oBtDN2JSV0mkRaD48bIM5ijPg4GRs=;
 b=F7FTl2EU6XWOH42gC6v2NSRv0jG2tVBkNfdzVrq05MYMT3D1+iCwmlMtEFTaaV1DvjtX9yV3aVmng4Mz3Dwo8YWs/z2aGULqlnzfw92tLo3u/J5AXnawO/qDBJfq1fOxhDXD4EaogPjzVkoPBfbfrI4TItlYGk65kIAObaqFAPs=
Received: from SJ0PR03CA0004.namprd03.prod.outlook.com (2603:10b6:a03:33a::9)
 by SA5PPF37951B1C9.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8c6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 10 Feb
 2026 06:45:16 +0000
Received: from SJ1PEPF000026C5.namprd04.prod.outlook.com
 (2603:10b6:a03:33a:cafe::c6) by SJ0PR03CA0004.outlook.office365.com
 (2603:10b6:a03:33a::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.19 via Frontend Transport; Tue,
 10 Feb 2026 06:45:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C5.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Tue, 10 Feb 2026 06:45:16 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 10 Feb
 2026 00:45:15 -0600
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
Subject: [PATCH v6 1/9] dax/hmem: Request cxl_acpi and cxl_pci before walking Soft Reserved ranges
Date: Tue, 10 Feb 2026 06:44:53 +0000
Message-ID: <20260210064501.157591-2-Smita.KoralahalliChannabasappa@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C5:EE_|SA5PPF37951B1C9:EE_
X-MS-Office365-Filtering-Correlation-Id: 11f9a2db-b775-4d24-e214-08de686ff337
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|30052699003|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LEgCGL/jEznlb0xI/7ftY+21bhtGkfVubpPKiOaH4BG5Jox3hISXJjR2J1sj?=
 =?us-ascii?Q?G3TC0PXtM/UU/y8bWHRiuGBoz0B6HUZehjqfo5cs/sZsr73vTMPIHhbB1jKm?=
 =?us-ascii?Q?egiVd4JAKxAeg5etI6hB4aBviv0rSA8rs6EBzgSy5hrsh/HA0X62NaKIQczo?=
 =?us-ascii?Q?Y2phzSyX0UFy/8OMYyCS2tEVlrpE84VEKHt1eK0MT5rZMqNcisR+xax0d8/a?=
 =?us-ascii?Q?XWcYWPQZMBc9IXsJZgu1muDQTxvU/RSjtwp5xbK7XxvrTc2yp2ORYt8n54UI?=
 =?us-ascii?Q?G3HhAL9P1nQaviIJxnwSsxwEARXc6rz+GG4hxA83eqAfMxjUHEhj7BdjitC1?=
 =?us-ascii?Q?K0XvH09wHXyZtDF3o/A7Fp+8JjpcBeiAl8MYgHYHITidoht2/PPrl/UJJiCD?=
 =?us-ascii?Q?69FlsfAAXgZDgf219LGZgFBaL9WR433DOZUkY7TCUbA7hsCewDW2NeMNEPsA?=
 =?us-ascii?Q?qW8Y0qErIRTZfpAWRAI/8V+juzdOdzP6WAMUY45fMm9ze1i+Y/vdE1xPLERZ?=
 =?us-ascii?Q?dOzjXTGwL5u2Vx5is+OmrfqLRbd8eVoxeQVjOFs49b/LQ6aYRNbMvCdiSLj/?=
 =?us-ascii?Q?P8F1WdqNasIahupSHmD2oJM3KizLw2+Nug8gUPyyGHGK/3xi7HsaUtaEUkwg?=
 =?us-ascii?Q?5HWNjHdSx9Zc2lH0K+VppEC+6NIsdm83lqIbg/8sl3VP6XNXHgyif9PaeIb6?=
 =?us-ascii?Q?mD+Gx5AQbu2z3bwzOV5Y+/i52kRhY/Q2To2Ezn/B8v88YjJnP/mP8ZQroX2r?=
 =?us-ascii?Q?hnMyPVxml+vkKPXBgUBDkQ2Pv9Buefh0eqnt6ro+PMkVe178Sj1+un1Lb9qo?=
 =?us-ascii?Q?s22wMNVd+N35qdCZ82xq4wuVcfUAYfDYUCDfok2X7HjrVder5XSrqne562v7?=
 =?us-ascii?Q?x3zDKPmvEbjbR60Af/wrMh9WODCPMeiT/EuypdAYEuxaWgVdI/rhC45URMvI?=
 =?us-ascii?Q?B/ixjRI/sokzjlrXcjnFWdk3Cb8fICgUW82wbkgBOSmz2hHqgB+iBNtmFgrp?=
 =?us-ascii?Q?OiuMC0VovTfA/3jcgrx4vGQNU3NP/1QcdaCepUVkqA9Avdfb9zV5hNgt4rbY?=
 =?us-ascii?Q?m1muIpR5N8zgaaCwXOEYeiDSYQLhOPQAyrfgTYWBDTCeNBzdA0/xinfiHMXn?=
 =?us-ascii?Q?TKt07GSjPzPwvT5ZgJ53J8INayNg3m+ls5muBLIkEdNiCH4MSl6gp1CSxsX1?=
 =?us-ascii?Q?psk2dP8Gz5h2jxNlZNlO/oCPwD6Kg75qaGeDZ8uiG9nF4qL6ZiJcFquFBmrl?=
 =?us-ascii?Q?6Knd0aFMKToezhOaJFEfKzt/G3hjF2WlE3IGBjbX9xEgar9iy5QL4LeNXLOe?=
 =?us-ascii?Q?oHLPX4fHn+347o3/qm4mhYa3SFuBjHfwqK+/hduTGbvCI6FSZzm44vd5kXO+?=
 =?us-ascii?Q?VzUQX5LXb1//Ze507eS8V2QeuMQse9xoeqiIB6bqBwBa+0N3DvUtvw1h4lnU?=
 =?us-ascii?Q?ab/EUDROKdPto3SAOIQ8zwhrXLtK/FR7Z6SAXkEF6AVzWWNPq/oC4fnBnEn2?=
 =?us-ascii?Q?umi56TuQ9OfYUG1iUvkeGlmJB7xrRhHW3GOT9b/DiI3xawzr8Bl8OdeFIeaV?=
 =?us-ascii?Q?YvGwjcKS8axALRauvcoP9SJknLcsCDVZDERhQ1/DANZ4UoICyeuwKuA++SaM?=
 =?us-ascii?Q?7Ph5YBJ09IxABmPgeYbjDQygSMKNMPP0x4G8J8UBBPkwnQbe/m86NdJ+fN6t?=
 =?us-ascii?Q?Y2TLYg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(30052699003)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	RqK+UTQueQzmePFBpu79f5alpjiq1Drygcc7ggW505eUnjbR6I3dtxn6YMPfquXDNWAW0f4MsGW32YI4W6JDJC3UuzFW1tIGzWttUBeu0X8iSFvijA6JlnKY5Ro1Z8pLmmO/QVYbX2s/zZfCRwKPOk6RzManZtJ/oRVV/Gd53EtvtS50FrwmeguziRWtBhGN+FN60QS8h+i2tocbni5FEwE/ohCQUQZj3vH74i9C9pfN56SysHBecx5IM5LBSFBjvRahlMZdsoujLZQxeBJmWzycwsfoMF4aYEpjCSUg+dGlJcyTPfqfGy+3E6LJW8pryBQMv4HHAu3fhhaL3bWrLViohzQZe99vODlD4DbLbKDSlSvyibXNf3pDiqQpiRI1JosY2tNHGZ0spnrVe8gMKw7UUbTBmxB+dQmb0fSXZcmD6SKN3AQW5Qnmyufz6AiQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 06:45:16.3377
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11f9a2db-b775-4d24-e214-08de686ff337
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF37951B1C9
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
	TAGGED_FROM(0.00)[bounces-76812-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,intel.com,huawei.com,amd.com,stgolabs.net,infradead.org,suse.cz,zohomail.com,oss.qualcomm.com,gmail.com,fujitsu.com,linuxfoundation.org,alien8.de];
	DKIM_TRACE(0.00)[amd.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Smita.KoralahalliChannabasappa@amd.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,amd.com:mid,amd.com:dkim,amd.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 45BD3117712
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
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
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


