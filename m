Return-Path: <linux-fsdevel+bounces-74970-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SKA2DiiucWlmLQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74970-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 05:57:12 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B18F561D20
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 05:57:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 015934FFE13
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 04:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC14646AEEA;
	Thu, 22 Jan 2026 04:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LqmfsadO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010014.outbound.protection.outlook.com [52.101.46.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50F5314D21;
	Thu, 22 Jan 2026 04:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769057767; cv=fail; b=pU2sJM2cCWQQn1XJ4s2s2ri2RMizZ+bmXNKCHT8WVqeQanbF+QCc2Xv1M/KNWhkyCDOQD0DQBM8BXGSuIssQVbWkvP/PDEeO8jPprAXwoeW1QYBwH0Yyaoevv32wUPX6Sz4D0+0AHMuA/Emi0WEpSxVmLTCtsFugD9x1/2Xd3zE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769057767; c=relaxed/simple;
	bh=zGczhesOvr1/AIzez2p1VtnQ6LI3XxAemAUp1T2J+4M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PTqBQSZfeg3ejt86srgE9w/i7fIh8f4jzeowVGaQgJ3/5DUzdvUKZeoqpro/xse1Uc2yRuMx5rrI5nHvbVI1DJ73XVuMnWAcB9SdovpcbRKvoA9ObDt/DNQYwgyzCSGb3vpCuDowMb7odSJN0m2ncsGzYM0N3wnt99YS5RLCd64=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LqmfsadO; arc=fail smtp.client-ip=52.101.46.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XS/Dnuvdz3IkvM3tTsaosDSiO3HUBUsriizcyOcgTskGZwNlydnrUyhui9+PU9Q1Q7iXFLZE3EhtVnypRZoA5iNY7WRupFxd7vsD0c6+QAkzL4uw+AAAHQWWOBs2E34p79/9Iod+qCnQPO3SYFrHcEVQI6hNLEGNYECqrDw21jDsZ/uZqFoztfXAEAgwNHVScdjsmN7f10A4+JIPOSnVTIEhtSI6bV8SPCuPwkw6exLuq2hfLTRLINxgjkjU8XwuudkhsScGgEZk4gjR0bpF+qmcyQs2fDTqt0/3kGjo+UaCjekGBs/JDZ5M8IsPRSD/n6YlZwKdp7Ztr/6QJu1TCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9TKyXume6br4WMD2WLcu5o3+ZC/akJoHgsg+ksExBco=;
 b=uuC4kofdR6+GNjwEYtpMzP9bbwsZgqacdCOyaOyBCt4KoqpaO3vMTGl0EkanrxR8r8Z+SjQPj/buj52N4THlu+9127bKfN6dHF1DSW+f+m74AxB7GV8m/JOFo1U2OHPKyhQRNVt5jtft6WwEmCBgjJVDGQyOwIbFH+6JRGX7xcnFIRsdVRoh1JRV4U2VnxNUS55uwVxVGBUK6joteZm1daPXLZLpsXK20WduK8KL/LlxGlu2aAQCgM9y1kyNy0KWBhuVqtwuu16vNsvd5OgeqCJNyaPlDprD8qqB4ZeMguEGOkxMghgMTgwiOJBXottSuRmaidnAlh153ta18CQZ2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9TKyXume6br4WMD2WLcu5o3+ZC/akJoHgsg+ksExBco=;
 b=LqmfsadOpRVCl9DyjYT/xWPcPrqXRk9PEo6PGRcwpKj12RDezTGwAsBFWnKfQIfNMSHEkD4ruwrW160k+MPP7d7arY8WW67d3GCtmrMv8kcDdGYT2ZJUO+mAv5T30NxPlRjY0bQWJ7qfXaccTPTISUFjXYSi1f7iFwg6zB1WZ4A=
Received: from DS7PR05CA0106.namprd05.prod.outlook.com (2603:10b6:8:56::24) by
 CH1PPF0316D269B.namprd12.prod.outlook.com (2603:10b6:61f:fc00::604) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Thu, 22 Jan
 2026 04:55:57 +0000
Received: from DS3PEPF000099E2.namprd04.prod.outlook.com
 (2603:10b6:8:56:cafe::ac) by DS7PR05CA0106.outlook.office365.com
 (2603:10b6:8:56::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.3 via Frontend Transport; Thu,
 22 Jan 2026 04:55:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099E2.mail.protection.outlook.com (10.167.17.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Thu, 22 Jan 2026 04:55:57 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 21 Jan
 2026 22:55:55 -0600
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
Subject: [PATCH v5 2/7] dax/hmem: Gate Soft Reserved deferral on DEV_DAX_CXL
Date: Thu, 22 Jan 2026 04:55:38 +0000
Message-ID: <20260122045543.218194-3-Smita.KoralahalliChannabasappa@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E2:EE_|CH1PPF0316D269B:EE_
X-MS-Office365-Filtering-Correlation-Id: 8266bab0-5247-4fc0-92a8-08de597287c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KXuRQM+16S7NoMfQqNl2sbNGzet7ka/TErrakekc33Hr+kBIIoANGmvtBQFV?=
 =?us-ascii?Q?EouQRoQC8prLg9NFYQTtfqP63RYdCkQZ7IwFE4JMwEBa9wF+KaxipbxnTe0J?=
 =?us-ascii?Q?qKHgbR3TiawRFAcmt6icdhC89Lcz0kqbGUEvl1NtTPk4dfHvrKEJBLy5NUhZ?=
 =?us-ascii?Q?ylDpBysDgJINlybuKDxFRg0DyHjAqjU3+MlVxQ9CRO3V6C8zun/U9P7EdzdZ?=
 =?us-ascii?Q?3+8yvVDb/uV4gfBR2I7KJqbYO0mfEe9gnv9ZGbWLIPEYxTbnCQdDqOnjHGaT?=
 =?us-ascii?Q?bLB1gXjQoR/O5YwHifdRy/Vv0XTBTH6BNSJChe2x6Rb/S4/a3PnmrrwLU3Z+?=
 =?us-ascii?Q?HF22ewHZWr4FE6IBpc77n10hnlzdp1MIpTJuOdK47KEUbKprp+hEaB8lTr3L?=
 =?us-ascii?Q?Hzb19dwipCBj5VDV3DibxO2mBm4unt0wOlt5PL3Zo6bC1I2sITHQ0bkYaIzX?=
 =?us-ascii?Q?z63+nb5SniYKW6HfFNqQZx+JRGOP1XNP/Gn8MAqi0JgnBkqCeei5p9neEg6Q?=
 =?us-ascii?Q?P2RMgA0Q1P/8aQvyqlF5zf0TGav0UiN5JQCdMx0U2y+S4tumfxUO95fIP/Oh?=
 =?us-ascii?Q?QlFEznB3lZjbZSjrEZio1dr78p7K1CsOp5E+aVdm677lEfbelA26HB1SVplP?=
 =?us-ascii?Q?1GK3HchrGgbfJKg84M0SJ7z659RogAgA6mnXG/85zJafYEGclJRfByoHrL90?=
 =?us-ascii?Q?X4cQrTYJW696ykedqjecp017N365GOHUmVLFM6ftYtgW70YsdThO3h2i41vh?=
 =?us-ascii?Q?cPe2YTW2YbukYorUJL/wk4MsJDGoLCybpBpcsqmolmUnPMLj8k9R/ctOEDwP?=
 =?us-ascii?Q?NZk9vHbV2nUss36ebmPAK5W/Pes5RarbarGikyKnEi7PY13g8sbY5oiQAhUs?=
 =?us-ascii?Q?bbT/NMdN+/kG72kEQl9UmCibdPrtKEVHR59nldNYDHuKCVNZldUnhQmOp+w0?=
 =?us-ascii?Q?zwuniRfsXYsjQXz03gX5CqYEOa3IxsnBF1Frk1H0rBkdkLsakrJHO6j0pm0q?=
 =?us-ascii?Q?NpVbC1zEIJGgR91uN7fmnHsO/UOF8iBMYyKSoBhjajcxFeso6fj8KQLKL8RD?=
 =?us-ascii?Q?PdiXsuSBsHymJSgDBMzlQJt+UTK16bwBIUMg4/GM7QtLEmm2LG1n48LAGvwD?=
 =?us-ascii?Q?hnBzFsSeatLO3Fg2NbtxSwZwPmxVpBNU4bgawNu7O7BzgSDRJNjLL6YJfYSE?=
 =?us-ascii?Q?jXy4shSWfGLm7C68huQ7d3/+WV5ngHLjsp25d9+5CXkIOzaw/gQoOPWeKJPw?=
 =?us-ascii?Q?rohfmiqpi126Jg92B7kaydvWqBwtcmhfxd6ZWhQQ02kN7lwP8SWE0SK/up1V?=
 =?us-ascii?Q?W1B77ql5q8/m9VT38ZcW5yOlthRUDOboHO+c1dnZulzV3Rf1Tmu3RTJ2/kg7?=
 =?us-ascii?Q?d5HRJ+4reTnJ3SgVmFmejzd2cAAwyPmP87g8nmmpB3qUhdqI0JFl3ndTVh19?=
 =?us-ascii?Q?NtaSqliK5U+AoTdf4yh498H6Cm9Ex7tOBgAr2nMtcM08r9PY47hjLSGMXiSu?=
 =?us-ascii?Q?olwCECLfSwwio84SGYmWKZYc1ljM76jlLg5rXEFLwJyti/qmtwHfHwTWXdnf?=
 =?us-ascii?Q?ZdWl6LndwzzZWnFiony51JNsri8cJ4NZM46du3yVCCJOgPlnVPY1pHxPDi2M?=
 =?us-ascii?Q?6fjUSHuA7lWRarIPaHiuKWkDPYVsi9sMG5LrQtElFxlyALPZ1kVglE87fnNG?=
 =?us-ascii?Q?OQC0BA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 04:55:57.1539
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8266bab0-5247-4fc0-92a8-08de597287c7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF0316D269B
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
	TAGGED_FROM(0.00)[bounces-74970-lists,linux-fsdevel=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,huawei.com:email,amd.com:email,amd.com:dkim,amd.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: B18F561D20
X-Rspamd-Action: no action

From: Dan Williams <dan.j.williams@intel.com>

Replace IS_ENABLED(CONFIG_CXL_REGION) with IS_ENABLED(CONFIG_DEV_DAX_CXL)
so that HMEM only defers Soft Reserved ranges when CXL DAX support is
enabled. This makes the coordination between HMEM and the CXL stack more
precise and prevents deferral in unrelated CXL configurations.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
---
 drivers/dax/hmem/hmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dax/hmem/hmem.c b/drivers/dax/hmem/hmem.c
index 008172fc3607..1e3424358490 100644
--- a/drivers/dax/hmem/hmem.c
+++ b/drivers/dax/hmem/hmem.c
@@ -66,7 +66,7 @@ static int hmem_register_device(struct device *host, int target_nid,
 	long id;
 	int rc;
 
-	if (IS_ENABLED(CONFIG_CXL_REGION) &&
+	if (IS_ENABLED(CONFIG_DEV_DAX_CXL) &&
 	    region_intersects(res->start, resource_size(res), IORESOURCE_MEM,
 			      IORES_DESC_CXL) != REGION_DISJOINT) {
 		dev_dbg(host, "deferring range to CXL: %pr\n", res);
-- 
2.17.1


