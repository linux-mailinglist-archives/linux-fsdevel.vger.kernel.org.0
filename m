Return-Path: <linux-fsdevel+bounces-76814-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aApKEULUimnWOAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76814-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 07:46:26 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E4071117746
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 07:46:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA383303FFE7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 06:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA43330652;
	Tue, 10 Feb 2026 06:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EzVM3ZFW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010010.outbound.protection.outlook.com [52.101.85.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2298D2E0914;
	Tue, 10 Feb 2026 06:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770705924; cv=fail; b=Eg4gUZWKBsqjM0+FhzJp0++kR9XKp44ktBSGn+Ta3RmaZfwWiNSrg696BUiXr234y/+pXGKjGNFHKA/loRQomU18uG9+gr3VXmnuXWVS2j3qCRjxqRCCpSCZpFUHFX1X6+RFNukcRC/Vpy1Zs/sTXWM6tOYEemHpnr/SpjaADEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770705924; c=relaxed/simple;
	bh=fSBagLuNrIcZvQHDHfAS0MmpzkTYqc8RqwO2Pq+AYSI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fy7xmj7k2G2rS8Zy9twRHb2WX4xGD434qRUfhXjGls9nM5QRu6rEokeZutKBczqz1vb+PtootsXB+SoN8s04R4CluNArWdpCSQrNaikMYY/S8HG3+PxvXoLpDPPlYUEr+w6BpXMnFoGr3X5fpmAi57rMhm+KUSptsqd+QJ8ANpk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EzVM3ZFW; arc=fail smtp.client-ip=52.101.85.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q7aGiyxI45f9GKDCekUMyNvIvZAtFlNLCHHeRc+isp1octy7FgyOvmxJnU9r5DvhR+0CYjmVgSHxrZtDovBRiAchZk+rHjYHWs+JMptAZMx9q8BCJ3FYLaEm7lOmTjaUwDhgjPEH8ROYcr0OajSh1tNWlW3k+hB3Eq30o6VvaV4LjYO0UjPA0YD1MYb9k/qwObXk2J27Vjeb7rihlS7xqbIkTWZsyC1d04HcM+vHHBz6fammYTmF0pcbF88oXOcWpGclTkxNhzFk+6PgQzeggxBBS/TH6P/wttLwQHeIFcQ0rYfanGnKbkSsh7LFt9wQWkD9D9dfQ8LqwNlyJcIMuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U1lpbM+zjnyS0RiDy1wWSG3Ep5G86cy2JkZ7v1L3SFs=;
 b=sLW1VFuegTfBYAfRK3xjAElaETSkZcRqBYi4SU4YyStAj1anrikdyYUI4PcSf/e1phxHYY/rypJaEkXWpgZFjbVlE/Q7rGrD0WAA75FduyaUy+F7ZjLLP0adXnvnRc8ic/vfO5bJs9cJ4/ulZKW0Ksi3FOlTNss3J+6RxwulvbXgNQLEmdRbArwRniF/iUAntGGQ93UtbHShjg1CKYG3LMHPIXw8btjECm9C8v0S2dlaIhdm67tkNEToRa6jCQD7e8+IBbHJMGDOoay+W0Xfo49GJcFVBGYrduu84QqdFXMQ2D/7NWzcvk9jwowiQdMDgxV4mtyUJKfwH8NxSl9k0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U1lpbM+zjnyS0RiDy1wWSG3Ep5G86cy2JkZ7v1L3SFs=;
 b=EzVM3ZFWTjDDewSuLckjNzsvlOAD9fKoRuLfnzCSJh+3aE0YXUov7Czm29EqnBQhMnz6klTB4KvJz/yk3ic3jBWx8uSYMEeaSQ3vQAovSJ51izxC+8XMXqu51cZJBJzdeHYDMDGn/EQZW+L65N9sdM3l90NiXEa+f2RS3xKzgCM=
Received: from SJ0PR03CA0015.namprd03.prod.outlook.com (2603:10b6:a03:33a::20)
 by IA1PR12MB6041.namprd12.prod.outlook.com (2603:10b6:208:3d7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Tue, 10 Feb
 2026 06:45:19 +0000
Received: from SJ1PEPF000026C5.namprd04.prod.outlook.com
 (2603:10b6:a03:33a:cafe::99) by SJ0PR03CA0015.outlook.office365.com
 (2603:10b6:a03:33a::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.19 via Frontend Transport; Tue,
 10 Feb 2026 06:45:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C5.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Tue, 10 Feb 2026 06:45:19 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 10 Feb
 2026 00:45:18 -0600
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
Subject: [PATCH v6 4/9] dax/cxl, hmem: Initialize hmem early and defer dax_cxl binding
Date: Tue, 10 Feb 2026 06:44:56 +0000
Message-ID: <20260210064501.157591-5-Smita.KoralahalliChannabasappa@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C5:EE_|IA1PR12MB6041:EE_
X-MS-Office365-Filtering-Correlation-Id: c0d1208a-ae97-431d-782e-08de686ff4e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xKUX3jJuwUZMFT7JDublPF0K8ZOqvgfWEUOxNqjEGTTdsZK9vHlRk3S81nTp?=
 =?us-ascii?Q?oPamzlSWIhKkH/hHMexXt5H9pxs4TN2R5/U1bPWpzd0/G+CE4jvL3oW8F59z?=
 =?us-ascii?Q?AG4Yi1bh2SC4a7vTVLvDn3F1kMjoKdlYJ6ovlkF+eqT1Qt0qqZ0iQHKlMRu6?=
 =?us-ascii?Q?ZMMRXkUDSBipkXkcC7SFpg6TEX8GXK8GlUCTqLP17MCFylu0ucESmRtYoaXD?=
 =?us-ascii?Q?F8JLhcP4HfvN6NOxW03CWwT+sizG+BrLWFUaKjYtD7CPDHc4/HatisYDc7rh?=
 =?us-ascii?Q?OVdEQcf+uH9aoGFZnP3YVcKvwjKtgInUM34MZkg4PRb3pJseOOI6x8mzGDAR?=
 =?us-ascii?Q?Pcj9oKlZVPdUpPzboytQQhPHaxIzaBJDH2U2Kkw2KsvoO6CvsB4Hd1A74IOH?=
 =?us-ascii?Q?2AmzWunEpS522t/rVETCeekd4hFhrUazhUe4iZsomlyJO16Ak99MliNYTQtF?=
 =?us-ascii?Q?0DIvSFAmyhSDfNpHJYrDgfGsMEK1HSdaQ69crys7P/H/Ur1hzjDx1RGc4Tmz?=
 =?us-ascii?Q?/1EGrt3ZF2WEl7vLvtSSRGUMc7ew7L2emg43Nr4RdVj2SVMURmm2fvUNbWsB?=
 =?us-ascii?Q?rLALjNWkeBddaQCOXNxNlc9cqGQ01qQWEVEMZAFFso3vABDl7c0M2QseIpAc?=
 =?us-ascii?Q?NIcwO4psxtBxxJeEpW6a7qInVmCidjFoSKOEvCfq5PGyydJsRj9JIkOatSKa?=
 =?us-ascii?Q?WQoVgtwncjTfwyisOW1LYxS99+GXhBhChCbqTWlDLKabu5UaouGAV6JCuIKo?=
 =?us-ascii?Q?qZiLv3hdZYf8fh4jKm6MSn7CIGpLgtW2qaQAv/pjXjxtTNxfhBLpXc5AJJl5?=
 =?us-ascii?Q?eYrc6vHgZ1hy17P5yEhTM7asptpHbk/+I2zFDpjZGqajOSjtu9w7co3l/mfR?=
 =?us-ascii?Q?8qqiMhpsWQjx90/m5T6pwNQcDVKt3Nw8Hml7EsHd9GS5TFcvw3pGtjt3lD6n?=
 =?us-ascii?Q?Yl5ml8VWK/Dmpu5GbFo42528qvRK8VqLibYFCKaOiyOVlPbNNz1A0qeHoLIR?=
 =?us-ascii?Q?p5ntSEmkjyYTP5rLvYUMZRL51skshtj5EcyWn3gOJjtc+3IKuu54PPdbHtsg?=
 =?us-ascii?Q?AJdv8kWdt/C4OZpI5UsznR13RJsc6VIHhzWVHKst/vLGLv1HCaujPyjiZOf/?=
 =?us-ascii?Q?VwP+5ZhFrV6gI/EqrEMkaZA6Fy4W3sz4dMikz1DmgjrtfIz194x66HYeHfWz?=
 =?us-ascii?Q?7BmFOit40Vlchh7iL6rHMGAtZykGp59dspS9eVrDtkiyCYj1LolEc0WBXUN2?=
 =?us-ascii?Q?3ZSSpij6gz55JnBz2Fq6MNdgZstBf+JLJgYxATwYk+2asjtBLHL9koIiTPjJ?=
 =?us-ascii?Q?gkT55HMUb0QQcxAHMYpHg7K/UTmmOsX8fEVxlLJJOL1wSMTRYXtQyb2CGKUz?=
 =?us-ascii?Q?pATht1mWtyBxm1/4tOZzNAczT8tbPbsSc7bG9TI63N/j+FWsWDG+1HteOKV4?=
 =?us-ascii?Q?fEZ5phdl+K8EMIYGGdXcuNkjYq7uLD02cjOzAgLL9U6AcQw7ohHlYbdfCWoG?=
 =?us-ascii?Q?+vZgGGEJYMaPnwjOoIZhRCQlZd0x/SO8sv6uABWynpovDyGL+Sl/NyP99QKU?=
 =?us-ascii?Q?oN3CqvHbIe4EYLhE21/J5uxKZ05SEPfajTCj305nrd/wtbxOYahuI2YVJAzO?=
 =?us-ascii?Q?dYhtXoWvlFouLBuwY9pEoMa++4oZ2vgVMC2mdlFHZpFtUGrnHFgDOxmMoqF5?=
 =?us-ascii?Q?ekYZmg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/CWQhtAuQEZVrIV4goeC0akaOIixMT5WTpqGABGE4ZHXxEa/kmU4t9H9qjl3ga9oT7YTBzIwmhjg/XE736aOHQbEEYXhnE1snwQiNoEjSohqHQEFg1gqqE/Kvwg5jGbzidtOI2agL7TohkmU4mKF7gjFimrQhH6hbZzHuink+PG04QNkMtKcqkTzN9zU7JMZ0GveZX9vETNtnyJeBXbVZhYyKPqImQKMv9NeL4AG6m2zF0I+O5PDxoE0kPgoPKWfMIlosyOCCnN4oNpfFadEqJ2rgQBI5p22ZaTDoCWgfhNZp7pSsyHityyHKSzhDC9wv9Z+5qq8KqkLYoaw2KNnP2GXb8kt/V3Ya5thoYhmkENkNnJKqZLuVirfW3JQz1Xnya7rZ5Lf+IgUv7N5zaMljyHMWdkZcid706cNH+pruan8X12aCf1YWx5GNMckRhMQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 06:45:19.1141
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0d1208a-ae97-431d-782e-08de686ff4e3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6041
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
	TAGGED_FROM(0.00)[bounces-76814-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,intel.com,huawei.com,amd.com,stgolabs.net,infradead.org,suse.cz,zohomail.com,oss.qualcomm.com,gmail.com,fujitsu.com,linuxfoundation.org,alien8.de];
	DKIM_TRACE(0.00)[amd.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Smita.KoralahalliChannabasappa@amd.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:mid,amd.com:dkim,amd.com:email,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: E4071117746
X-Rspamd-Action: no action

From: Dan Williams <dan.j.williams@intel.com>

Move hmem/ earlier in the dax Makefile so that hmem_init() runs before
dax_cxl.

In addition, defer registration of the dax_cxl driver to a workqueue
instead of using module_cxl_driver(). This ensures that dax_hmem has
an opportunity to initialize and register its deferred callback and make
ownership decisions before dax_cxl begins probing and claiming Soft
Reserved ranges.

Mark the dax_cxl driver as PROBE_PREFER_ASYNCHRONOUS so its probe runs
out of line from other synchronous probing avoiding ordering
dependencies while coordinating ownership decisions with dax_hmem.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
---
 drivers/dax/Makefile |  3 +--
 drivers/dax/cxl.c    | 27 ++++++++++++++++++++++++++-
 2 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/drivers/dax/Makefile b/drivers/dax/Makefile
index 5ed5c39857c8..70e996bf1526 100644
--- a/drivers/dax/Makefile
+++ b/drivers/dax/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
+obj-y += hmem/
 obj-$(CONFIG_DAX) += dax.o
 obj-$(CONFIG_DEV_DAX) += device_dax.o
 obj-$(CONFIG_DEV_DAX_KMEM) += kmem.o
@@ -10,5 +11,3 @@ dax-y += bus.o
 device_dax-y := device.o
 dax_pmem-y := pmem.o
 dax_cxl-y := cxl.o
-
-obj-y += hmem/
diff --git a/drivers/dax/cxl.c b/drivers/dax/cxl.c
index 13cd94d32ff7..a2136adfa186 100644
--- a/drivers/dax/cxl.c
+++ b/drivers/dax/cxl.c
@@ -38,10 +38,35 @@ static struct cxl_driver cxl_dax_region_driver = {
 	.id = CXL_DEVICE_DAX_REGION,
 	.drv = {
 		.suppress_bind_attrs = true,
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 };
 
-module_cxl_driver(cxl_dax_region_driver);
+static void cxl_dax_region_driver_register(struct work_struct *work)
+{
+	cxl_driver_register(&cxl_dax_region_driver);
+}
+
+static DECLARE_WORK(cxl_dax_region_driver_work, cxl_dax_region_driver_register);
+
+static int __init cxl_dax_region_init(void)
+{
+	/*
+	 * Need to resolve a race with dax_hmem wanting to drive regions
+	 * instead of CXL
+	 */
+	queue_work(system_long_wq, &cxl_dax_region_driver_work);
+	return 0;
+}
+module_init(cxl_dax_region_init);
+
+static void __exit cxl_dax_region_exit(void)
+{
+	flush_work(&cxl_dax_region_driver_work);
+	cxl_driver_unregister(&cxl_dax_region_driver);
+}
+module_exit(cxl_dax_region_exit);
+
 MODULE_ALIAS_CXL(CXL_DEVICE_DAX_REGION);
 MODULE_DESCRIPTION("CXL DAX: direct access to CXL regions");
 MODULE_LICENSE("GPL");
-- 
2.17.1


