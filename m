Return-Path: <linux-fsdevel+bounces-76811-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oA9SHBbUimnWOAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76811-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 07:45:42 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1942C1176FA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 07:45:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7FED0302AC14
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 06:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CFEC32E757;
	Tue, 10 Feb 2026 06:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iaXTZ0/U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010035.outbound.protection.outlook.com [40.93.198.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6074B3A1DB;
	Tue, 10 Feb 2026 06:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770705923; cv=fail; b=uD3lpSxfHnsyFDOAZbiLDapUY3tY3tXV7FfoZGQpKkaS4LXdsYHhaByEEUKjPDxOOznHuF7q+JpFWQKv8aQ4P+gewp76+yFjRK4QfSRxOxLh8wNG2W6suh/Cq8cONGQ+iaECHBfp4Jisp495FiPqUc5I6Q/usYyv6YS0G7V469E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770705923; c=relaxed/simple;
	bh=zGczhesOvr1/AIzez2p1VtnQ6LI3XxAemAUp1T2J+4M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ygh1iOjT1dYbTMAVaG917WK2ycDHW/vOB7/N36cGhW8qwxuDOKjJuNAX9N/7NF86QeYq6AfAUm+8URxPOYifj75mCYddN7kT++ULtywfbtEDZfAbSH0X8Z3pydQzLVH+ordLVZ7dIzyFWfZCo333Vls/4wW5HT7OVuX8BMzLUFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iaXTZ0/U; arc=fail smtp.client-ip=40.93.198.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ftJK1pYKWZe8ns/uFHkJ2D8YvF7s5uullB2fGU/gnxzaWQ8d1Ij2fK7zzoW6tIzoUudOsObUVvLH9z4fXVxicGQOMulwzqDRSSlGRifN0+Mu1Cg1DpaP7pZEbuvip0AGNhdJ54W2IQ/Tl/mjOQC/gz7ssk37S/rrEU/TUMpMd1wegt7plXvwgoIiwcUUoHNHMzFMUR0CkKg9BFO42NXf9VSp6TZq9yYKMhsw3xYsHtjWqEj62bjd6JJgoUQ5Phtq5YnhWOFebt3uwfPYBpjh6jcGeRZY+YrTgfLrYquZW+yFIAXU0WUlFFsCYBkeW8j1dZA4ui+suC1Lih4rX3NxMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9TKyXume6br4WMD2WLcu5o3+ZC/akJoHgsg+ksExBco=;
 b=tihJpvss4JZbLBB4UAFhmJVoqBUxVGKuR/rLc6TkC2upx+CSdvTGpdLEnpkPMbF2WxqGPHyEWjSRBqu5W4Eqz2V0EHEBbywZ5C17pcAy4V0pse5Wjz+MvdSYvg6bKj4OTV69yNdiBMJtl0fA1OrnWupgdnduWoUmku6XcI5VPZ2Li0cWqguvOsU2fUEREmGXZzr3KXPUbwssuCosoqVoSrW4XcMVbTDKZllP1mKNd9+/WqJCnAzkCv8LGoh5W+J1yPurTkyRj41R4ZDKJRF7wkFVCudWk7ksXywMl+tX6rn3a/UxnD86Sj+VTSNaAKVk1ONwHrKc27TsF2mGACSJVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9TKyXume6br4WMD2WLcu5o3+ZC/akJoHgsg+ksExBco=;
 b=iaXTZ0/UBT239cwENamwf87yTTk41AFVFYSmkpi/W+kc4VIZ3qVE5/CJ+PAFceJicklVIBmVQWDqbA/XBJP89iIHk7J4lDRHKxvodCzXtd+WM8FMAWtrogyVE8YBozIFaOoFsgPuEImnlZpgaVE20/ZcpmFtp/atUyN4fdOWxc0=
Received: from SJ0PR03CA0007.namprd03.prod.outlook.com (2603:10b6:a03:33a::12)
 by LV8PR12MB9418.namprd12.prod.outlook.com (2603:10b6:408:202::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 06:45:17 +0000
Received: from SJ1PEPF000026C5.namprd04.prod.outlook.com
 (2603:10b6:a03:33a:cafe::e3) by SJ0PR03CA0007.outlook.office365.com
 (2603:10b6:a03:33a::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.19 via Frontend Transport; Tue,
 10 Feb 2026 06:45:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C5.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Tue, 10 Feb 2026 06:45:17 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 10 Feb
 2026 00:45:16 -0600
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
Subject: [PATCH v6 2/9] dax/hmem: Gate Soft Reserved deferral on DEV_DAX_CXL
Date: Tue, 10 Feb 2026 06:44:54 +0000
Message-ID: <20260210064501.157591-3-Smita.KoralahalliChannabasappa@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C5:EE_|LV8PR12MB9418:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f56c7f3-7275-4467-637a-08de686ff3c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dXHBC84TI4wFL9A4ka8RBKPYcmdWRlCncI+vljAJO1ZMC3hqthFCiY5KPKDl?=
 =?us-ascii?Q?tdzrdetPPobXlhXq9el2HFSSb7BHICwGV7xOXmyvsg/oJeyGWZ7vVFIGr8j4?=
 =?us-ascii?Q?FW4w65pk0kFQcYSBn1EppFzdhQppZr2PSRQ3F3YiWBSLkqJQtIKgqDFInwm4?=
 =?us-ascii?Q?GNCZzukHu+mv4Ng+hQoaqSU2HBSXJoyY5yaOTmgf3GqDaJJgBLVpczkZbp+t?=
 =?us-ascii?Q?Oj8dNCx9oFsF9jOMowV9CRZ/xb8BOnUsULoU70vWr9YXeXDKWrWbdZWzWcXt?=
 =?us-ascii?Q?DjMxWrXdk84LJoXd1laGXsS/EEwC8jPHgmMieg4/9IWzVrGER0VBR3H3+2U2?=
 =?us-ascii?Q?69fjSWTyYxuBmmv4IAJU5LAO9ao9h2jxi4L9sykE+CqakId1kpBW9qEHKz6E?=
 =?us-ascii?Q?uMgsqRU9JTou9Pmys77KMMB24kMY2fNI4oqLj8yuzQXvdiTmFHQyHvpK7Zfx?=
 =?us-ascii?Q?1M7C7dqtzRy9e71JqTAeDiuEhIsDp9GKpr4ErfxHe4WHwG+0EUGtkknIEvS+?=
 =?us-ascii?Q?6nYZ9t6JDD/ijNhZwGkRrfKO1XV0DKi6fVyrypIQUlKhtnJGEkXWf4wDXP0m?=
 =?us-ascii?Q?hoUiwA9GbFuj1pLVn3ou1KdOFDn2jZg/9HpK2wFgtvDpH1DR+dz15LuUlHSd?=
 =?us-ascii?Q?p/xixB14wYALAuiacmK1+gmfQuq6NuOoK4io0qZFsd+BUc6bRPxuZOAv8oJl?=
 =?us-ascii?Q?udXgVtqDOOD9dioEKmfEJwyJFMgaH679F2IkQS7YqssdP8mNF2Ovv7pE/Rch?=
 =?us-ascii?Q?8VXQWOvpe4sqPUrbEJgiXszyyz+Yz1D2w9YO2Swq2XHGfjacm9U/yvBgw6Al?=
 =?us-ascii?Q?dY2v8lsfk57xyCma921/4NZpTrXm9rqIbtrMCD7CDG1aLPYbLIbn0wKe08Sk?=
 =?us-ascii?Q?zPfPd7FFgEjtKpQkiM/wq/IXUINdJr3USJeoKBgXndZqhRb4AS02k7Gwml30?=
 =?us-ascii?Q?WcaKHTnVUTanyZHvcrzkdVK2nw5IdzkCM9b63AKiE31If0QtkoItOhPN5xz3?=
 =?us-ascii?Q?6BjxOED+nVAlQjCbd/EwiKkEF1o41tkIo3o9iFBdKh3hg7pC5FqeJ0zlRJoE?=
 =?us-ascii?Q?qNcXw0nuG4DTvHMmNxVYKb8E8DkJTww2udVi0vQSpgjciRZAdo3BJVfvQgmZ?=
 =?us-ascii?Q?3pxslHyOhhAARedr0EdO78o8VHtEDTAh37NvAuOHTlbGbINgiPr7KsgTZmab?=
 =?us-ascii?Q?c5i42JQ7czA0HxWdRS4kdqxFfS2Dqs+5DiOW58FCh8kwwdbXufeeHgUHw5/5?=
 =?us-ascii?Q?tP0ZGIhwjG6+PDikVp5EHUZib4eujA7EFSrI+wOMZp9XpcK2Erl6w83y5gvn?=
 =?us-ascii?Q?W5lOMBUURc1t3rBWeShGONukGBNEKAvhmSx/e/2F9jY48QAbOjabe2FBojxZ?=
 =?us-ascii?Q?8MlCbK93RoGXOSJ0GCYS2x8LgKkrb2JxolnA7BELjFEJSbnT+wwa9wewo1wl?=
 =?us-ascii?Q?6pWLL9lwu0NyLb/hB8GoWpYf45MrNwvf2cfGRTFNR6Y9J10siCj+Hr/2AO12?=
 =?us-ascii?Q?sb7H3OReUf7YmpsqqqyHYV4xmFFMg+6WBwHvQfjeB2jh9fVXoFpXo+g2KE/A?=
 =?us-ascii?Q?X3ab7ebsTxYTYQOxQuRl4V8BEwvmUz9Aw4lecsShpb7NTYnYBZp9zq1YGtdG?=
 =?us-ascii?Q?4zxcVfOms/oTk3MuZkSBAhVNfQZkGEJ6bRY0e9WiMxQ7/9cSwgiwF0deL06Y?=
 =?us-ascii?Q?WjORRA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	UVAxr9NWnhN991R6z6Fn8Rxs7ncAdctltVrmQ1+UIyYnb/ladc20DQNOG6VffKjB91XD7wPm4RAkYkw0D2+O5UBk/mkodDri943VAM4yjriyoHUip7qzWemMR2Dv4bhI7zB/fKCidFvV+s9LcHxNLsZgc5r1AzHPlA41p48caCcAm9IpGRT2dqsQ5pQEwieqfp+WS32UlmTzl97bP1HySA0TD+EF/3qZeKuS+CWbaVl6CEDWpM2VV6B9nqSIqQWtd/cWRo/7GMtgISwQlzwN4CJVtPPGlHPG4A48kUQbe+7sZ0Tl+do/E8F6cS68GIPHppJrQHCXAuUp8iojMxjCvMxK0kfguYc7ASHsFJQ+MP0Gryp4zJDTtc/J4Rr32NTg/cJAiG+9ruDTzfPel6DnCN7sPxpEP2JhRwMTwYjYOxAxiC17EvKizAkpvrYmkbS3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 06:45:17.2524
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f56c7f3-7275-4467-637a-08de686ff3c3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9418
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76811-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,intel.com,huawei.com,amd.com,stgolabs.net,infradead.org,suse.cz,zohomail.com,oss.qualcomm.com,gmail.com,fujitsu.com,linuxfoundation.org,alien8.de];
	DKIM_TRACE(0.00)[amd.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Smita.KoralahalliChannabasappa@amd.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,amd.com:mid,amd.com:dkim,amd.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 1942C1176FA
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


