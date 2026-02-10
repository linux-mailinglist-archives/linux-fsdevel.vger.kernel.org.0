Return-Path: <linux-fsdevel+bounces-76820-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 5DeeJjHUimnrOAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76820-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 07:46:09 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D72F117731
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 07:46:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7456D301511A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 06:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5545D32FA28;
	Tue, 10 Feb 2026 06:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="b6ZcyoPY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011050.outbound.protection.outlook.com [52.101.62.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A69232B9BE;
	Tue, 10 Feb 2026 06:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770705942; cv=fail; b=V/Lunc2qC3lWv8iUuq3JelDtbCiXBvL+HU6wIphFH2e9awt5LM600+GBxzuBuG9vbVolwBLrDdtH2Nb9V4xTDflHn6VjeD8pTuBmUJHjrdJ3dUbfYbjoXVJbMFO/tDvCpApA+dtB1+BpGN0R/kcnCxuXO6h/nmlhfsPgVtOSlQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770705942; c=relaxed/simple;
	bh=7tn6YtUWsWedhVWe1eIn2wQWWWJ4CG00wCOCCSd0W/4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BD4sLGbTVBq0hH53gQ8npmg9sOlCgaK11xJNlFxr8daHf3qlkhMYEUQSZFS4/r5vPDWG8J+lfQRv7ZE91YUwGWFQtuKLTDONEPcEgLL1MNc53/0KWn7fqtzZWHcZfdX4J9jFnOhU6yMBZtHVLntX27ooN0/r4KY+kLiZETn6Rc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=b6ZcyoPY; arc=fail smtp.client-ip=52.101.62.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IuDRR1w7KuSrLvvhrll4gTVdfqRPHQOdXTjVn4Ohj+imednnFuOdMNrG1bCpSmeI+NsmKxjqh5kODwrGy+sr+a+6UXzRxa/CYrf5dR9iBmJWs4RgliFtp+w7eqjt8ObiXiI7TDVDZfjjzkbZpMBTuNs97lWguM2OaRj7iVoOrwieAUbWBOzTfuLSdJJnIW+2wiTE7OcRCRfUZWHPDb4fKyh5X9Vhk+CwgA/uX/zHlQMqwFcfAwe97MSxsavNsUmhISxFBBCXNf50MYbDRGE6E7C7Wf9DK+nbaaJwOLGdwXGXKgBBeA2duKvLj7Xi1CodQSJSa8C+EROBdkvYXw6nPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M+Dl2SvGIWj7ta18s7cC0Ifd7tWD3cQg4ExhFp8Ogv0=;
 b=fCOdCugpqzMs8oPD9COR3ZrhA5S+PMirOflcphyIkmYDPBg4ucRGy6aDEEW5ffScQTQDyy27XFFqDGdJdQRlm1l1oTZKj82J31XOldsoiYMQzEQ8MXA68fBk7l0UL/PmnS0khMlD4aTj2TxHYZF8fCnuCZsBGvSesgAZr/afH9t0GsB/Upq8BxSSeTqWimDPLa1TeRQJUSs48ZCcH2uS4lGhq7L2wBBkTSkPD9ImM/A3BLWxFnrVmIVGwvtLlkdJPdjf3qOpHGaILd8jRl7PYAx3bx8OnKUHecjrCW8Mo7Wow4Bju3eo7qFCqEOV5JmE6xWLv3dJd63DmLtbhEqweQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M+Dl2SvGIWj7ta18s7cC0Ifd7tWD3cQg4ExhFp8Ogv0=;
 b=b6ZcyoPYvKLV8zkdzkrOnOhv2w50rAwlVKL48o3AlttWEw1nYy/f4matVxbi/wMYft/dronlCTPWLX2wjP0BAjhzQL1w9SR4edhyVPhYUJh9ceHSc4HG1qv5uGM+V07Ay6BpcpiWbXIiyLthuS3GQ2s+JL3dlIAxAbcUafILUCA=
Received: from BYAPR06CA0019.namprd06.prod.outlook.com (2603:10b6:a03:d4::32)
 by BL3PR12MB6595.namprd12.prod.outlook.com (2603:10b6:208:38e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Tue, 10 Feb
 2026 06:45:26 +0000
Received: from SJ1PEPF000026C3.namprd04.prod.outlook.com
 (2603:10b6:a03:d4:cafe::dd) by BYAPR06CA0019.outlook.office365.com
 (2603:10b6:a03:d4::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.19 via Frontend Transport; Tue,
 10 Feb 2026 06:45:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C3.mail.protection.outlook.com (10.167.244.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Tue, 10 Feb 2026 06:45:25 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 10 Feb
 2026 00:45:21 -0600
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
Subject: [PATCH v6 8/9] dax/hmem, cxl: Defer and resolve ownership of Soft Reserved memory ranges
Date: Tue, 10 Feb 2026 06:45:00 +0000
Message-ID: <20260210064501.157591-9-Smita.KoralahalliChannabasappa@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C3:EE_|BL3PR12MB6595:EE_
X-MS-Office365-Filtering-Correlation-Id: d5c3ffb1-fa08-4d07-aa6a-08de686ff8a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?apYXWQmomNTploW5iE4MnCywOwjsphr50V08k/YOdd1y0CXTv+HuLI+j8bHs?=
 =?us-ascii?Q?+6LM43GzbTjlLJJ7FIi1zqc98gZwJCsk4/2uWIeR+mS8KLY7c41kXnAfruoV?=
 =?us-ascii?Q?IYgYO+GFnlDmfQGte5OSxQVxduNTBXH08y+f+ZF3hrXabf+jpClJCmAcbZWg?=
 =?us-ascii?Q?Ygu/mImjE6/5ktzicIHcBjgAIJcmV5yF6f0QiFPTN1UlbpTUWY4tyz3gHENe?=
 =?us-ascii?Q?Q42XGqwNewRxQTub/Tp7MDxj/geeR+mFZK0JiEQAa66MY0eepl8PcAg8DPKG?=
 =?us-ascii?Q?vhjXTvXhvSnSNWoA8BfqmuwIr6uqqOOcw0t6UW1yoarN4BmsAQ2/xZc3eVon?=
 =?us-ascii?Q?H7Em2I+cz1ZITOVJWLiuxAob6PTPzkS+uGJKOob3zkqGezh1yUc/ByhvNUaR?=
 =?us-ascii?Q?QX6F0j65yW4kDsn973gQWkP+S5L0tuBtfzjh5n4tkHRJfjsK3hqoOCbRvNvY?=
 =?us-ascii?Q?1AsVgdiBOMK/X6hUAOWuaGywS2FCS29CYUsq3j9LryFJ3XcK+bKrg6WVQ94x?=
 =?us-ascii?Q?jRAWcKL+jKbbh7bJLwh8bDMZeqomOeQrcT2KVTblNnrItgXpD7o/5QwudRT3?=
 =?us-ascii?Q?mKb/GyG6ETxEFtooFGqywUVWutKi8MBCx6L8qiHWWuSFCks+yFp6rWzzTlKh?=
 =?us-ascii?Q?Z178W2CsJ8hWtjCpbN2K1JJKlRO71/2bIwr1trwOUjwm6Cv4H8RGCh0SS4qd?=
 =?us-ascii?Q?yCGXxijgMwOI4PGvq6++r+QVyv/bGSngrCCb7KvQuSg6kbPtUClEoKYZfEOP?=
 =?us-ascii?Q?a1pIJkSYGupDLsndOV/4mRafgNSqHpGrYlhAuUTghjT/Hh5zWW0hHOIIJUed?=
 =?us-ascii?Q?Hx6a2IRMG1YthrAusri4HMjHYlJd2In7L7Xzzx5RJVXg3MDdpymvnGA9VCIJ?=
 =?us-ascii?Q?YaveBqaiT/e93iW+1r0ckVeCMdxnhnwBL+a60a+yzXjHrKKB8iRkybqyAcjm?=
 =?us-ascii?Q?MjZo3+/4XelGxmP8pGbT9fat6IsMo8dq+MB8t/g6/AH5j8R9bPm3HAn8RSNM?=
 =?us-ascii?Q?ioJOntax4XJ0e15R9JpyyftLndacBpTurZeAHu+x5VgHomFTSNK6KgPZoMLH?=
 =?us-ascii?Q?DGVd3c9DtcdDZ+SRl1eRh00ZPNjxbJ87ClLrZywIqAaL2a959hwwRM0hN/pp?=
 =?us-ascii?Q?8+oKWRxKxn4YcBgszOHhbryCjO/ZrFaWLItGkmgazWN1Lwu9CGhk++nrSxDA?=
 =?us-ascii?Q?OmcE5+CoEoYcwNnTO6+O8pCUd3kJBUjcOP2jsgapxLDCXC4fkq+ftAROyndg?=
 =?us-ascii?Q?BJg5uMmKvBVfWF2+AYF8uA3NLs8R6xliP4sce9k4cwprqpmUWK+8vdiQx6tH?=
 =?us-ascii?Q?ujTcg+Z/UCCYTEsBV/L/7fyqUXihRI7dYVTRArPQk+5Gytaa/e0cW60otHPl?=
 =?us-ascii?Q?OxxdvzCx3MMVcADrPKlClE1tJeLtdYcvpjFJaQRwags5quHt+mlpDA5s1S+a?=
 =?us-ascii?Q?0CpJ54lA6P11RrAkLZQA78q5e9oDNUxgGJSGgKk3JUi4zuEuYsmMJmwbYgDk?=
 =?us-ascii?Q?gWwOzlh90jlnvHtuSsKaY6wwo94C4+Us4MyvWVEUeVHdEIIXVNsFHQqvHQPw?=
 =?us-ascii?Q?J4siQ2SQAEaC3aM/PBj5+CdvvRcGe77gVT7N3abpD+Cvi5hgCNGkOFqoFO4D?=
 =?us-ascii?Q?aacwKA8o+0cR3Rb+Hwm7IS8LHT4lepofWqHlBzhzeKvFFIqQ24mNCWbnquyV?=
 =?us-ascii?Q?7pGO1w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	hIyFuh8vmtOf0H74Gia0f5to6+u1jXmYDh9Tt8TSUzriTu+XdMNOx3ErFeHRzvRcA3oaK5o9r0ddD/Ljwke6RxVUhW9QAxZfOe3gZ5yOgoKkaV+g4QxAj863DAN9be8V1Ee1MRVZ/MbHpTgBMTt1l5W+uwMSGXnfWzUn7ZgonIPL6yXOlObfulzPotKS4HlKzgVPvUsZFXZuTjtY3gc6yaDG+SGXQwYJuf4bAuPUT0MWcqpbDqhSuldLAMlvB6+0hTtctDTmX/zTdk71ImT+R7vcSmLmCYOOo227+m31WNGsrl8IhpvBVOmco+FACgmHz9Yfd6Kp6RQMBk8kzYRSd4vWQGA0ztM/r+TxWnAJJErXP497QResSSQ6YzLU4VpgGyKPDrQ/GL0+c3DmNLIsgIqVPilXLd/JHMHeNEhbbqVpdUSc95Nwg3BSv0SrPUvN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 06:45:25.4373
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5c3ffb1-fa08-4d07-aa6a-08de686ff8a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6595
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76820-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,intel.com,huawei.com,amd.com,stgolabs.net,infradead.org,suse.cz,zohomail.com,oss.qualcomm.com,gmail.com,fujitsu.com,linuxfoundation.org,alien8.de];
	DKIM_TRACE(0.00)[amd.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Smita.KoralahalliChannabasappa@amd.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:mid,amd.com:dkim,amd.com:email,intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 5D72F117731
X-Rspamd-Action: no action

The current probe time ownership check for Soft Reserved memory based
solely on CXL window intersection is insufficient. dax_hmem probing is not
always guaranteed to run after CXL enumeration and region assembly, which
can lead to incorrect ownership decisions before the CXL stack has
finished publishing windows and assembling committed regions.

Introduce deferred ownership handling for Soft Reserved ranges that
intersect CXL windows. When such a range is encountered during dax_hmem
probe, schedule deferred work and wait for the CXL stack to complete
enumeration and region assembly before deciding ownership.

Evaluate ownership of Soft Reserved ranges based on CXL region
containment.

   - If all Soft Reserved ranges are fully contained within committed CXL
     regions, DROP handling Soft Reserved ranges from dax_hmem and allow
     dax_cxl to bind.

   - If any Soft Reserved range is not fully claimed by committed CXL
     region, REGISTER the Soft Reserved ranges with dax_hmem.

Use dax_cxl_mode to coordinate ownership decisions for Soft Reserved
ranges. Once, ownership resolution is complete, flush the deferred work
from dax_cxl before allowing dax_cxl to bind.

This enforces a strict ownership. Either CXL fully claims the Soft
reserved ranges or it relinquishes it entirely.

Co-developed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
---
 drivers/dax/bus.c       |  3 ++
 drivers/dax/bus.h       | 19 ++++++++++
 drivers/dax/cxl.c       |  1 +
 drivers/dax/hmem/hmem.c | 78 +++++++++++++++++++++++++++++++++++++++--
 4 files changed, 99 insertions(+), 2 deletions(-)

diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index 92b88952ede1..81985bcc70f9 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -25,6 +25,9 @@ DECLARE_RWSEM(dax_region_rwsem);
  */
 DECLARE_RWSEM(dax_dev_rwsem);
 
+enum dax_cxl_mode dax_cxl_mode = DAX_CXL_MODE_DEFER;
+EXPORT_SYMBOL_NS_GPL(dax_cxl_mode, "CXL");
+
 static DEFINE_MUTEX(dax_hmem_lock);
 static dax_hmem_deferred_fn hmem_deferred_fn;
 static void *dax_hmem_data;
diff --git a/drivers/dax/bus.h b/drivers/dax/bus.h
index b58a88e8089c..82616ff52fd1 100644
--- a/drivers/dax/bus.h
+++ b/drivers/dax/bus.h
@@ -41,6 +41,25 @@ struct dax_device_driver {
 	void (*remove)(struct dev_dax *dev);
 };
 
+/*
+ * enum dax_cxl_mode - State machine to determine ownership for CXL
+ * tagged Soft Reserved memory ranges.
+ * @DAX_CXL_MODE_DEFER: Ownership resolution pending. Set while waiting
+ * for CXL enumeration and region assembly to complete.
+ * @DAX_CXL_MODE_REGISTER: CXL regions do not fully cover Soft Reserved
+ * ranges. Fall back to registering those ranges via dax_hmem.
+ * @DAX_CXL_MODE_DROP: All Soft Reserved ranges intersecting CXL windows
+ * are fully contained within committed CXL regions. Drop HMEM handling
+ * and allow dax_cxl to bind.
+ */
+enum dax_cxl_mode {
+	DAX_CXL_MODE_DEFER,
+	DAX_CXL_MODE_REGISTER,
+	DAX_CXL_MODE_DROP,
+};
+
+extern enum dax_cxl_mode dax_cxl_mode;
+
 typedef void (*dax_hmem_deferred_fn)(void *data);
 
 int dax_hmem_register_work(dax_hmem_deferred_fn fn, void *data);
diff --git a/drivers/dax/cxl.c b/drivers/dax/cxl.c
index a2136adfa186..3ab39b77843d 100644
--- a/drivers/dax/cxl.c
+++ b/drivers/dax/cxl.c
@@ -44,6 +44,7 @@ static struct cxl_driver cxl_dax_region_driver = {
 
 static void cxl_dax_region_driver_register(struct work_struct *work)
 {
+	dax_hmem_flush_work();
 	cxl_driver_register(&cxl_dax_region_driver);
 }
 
diff --git a/drivers/dax/hmem/hmem.c b/drivers/dax/hmem/hmem.c
index 1e3424358490..85854e25254b 100644
--- a/drivers/dax/hmem/hmem.c
+++ b/drivers/dax/hmem/hmem.c
@@ -3,6 +3,7 @@
 #include <linux/memregion.h>
 #include <linux/module.h>
 #include <linux/dax.h>
+#include <cxl/cxl.h>
 #include "../bus.h"
 
 static bool region_idle;
@@ -69,8 +70,18 @@ static int hmem_register_device(struct device *host, int target_nid,
 	if (IS_ENABLED(CONFIG_DEV_DAX_CXL) &&
 	    region_intersects(res->start, resource_size(res), IORESOURCE_MEM,
 			      IORES_DESC_CXL) != REGION_DISJOINT) {
-		dev_dbg(host, "deferring range to CXL: %pr\n", res);
-		return 0;
+		switch (dax_cxl_mode) {
+		case DAX_CXL_MODE_DEFER:
+			dev_dbg(host, "deferring range to CXL: %pr\n", res);
+			dax_hmem_queue_work();
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
@@ -123,8 +134,70 @@ static int hmem_register_device(struct device *host, int target_nid,
 	return rc;
 }
 
+static int hmem_register_cxl_device(struct device *host, int target_nid,
+				    const struct resource *res)
+{
+	if (region_intersects(res->start, resource_size(res), IORESOURCE_MEM,
+			      IORES_DESC_CXL) != REGION_DISJOINT)
+		return hmem_register_device(host, target_nid, res);
+
+	return 0;
+}
+
+static int soft_reserve_has_cxl_match(struct device *host, int target_nid,
+				      const struct resource *res)
+{
+	if (region_intersects(res->start, resource_size(res), IORESOURCE_MEM,
+			      IORES_DESC_CXL) != REGION_DISJOINT) {
+		if (!cxl_region_contains_soft_reserve((struct resource *)res))
+			return 1;
+	}
+
+	return 0;
+}
+
+static void process_defer_work(void *data)
+{
+	struct platform_device *pdev = data;
+	int rc;
+
+	/* relies on cxl_acpi and cxl_pci having had a chance to load */
+	wait_for_device_probe();
+
+	rc = walk_hmem_resources(&pdev->dev, soft_reserve_has_cxl_match);
+
+	if (!rc) {
+		dax_cxl_mode = DAX_CXL_MODE_DROP;
+		dev_dbg(&pdev->dev, "All Soft Reserved ranges claimed by CXL\n");
+	} else {
+		dax_cxl_mode = DAX_CXL_MODE_REGISTER;
+		dev_warn(&pdev->dev,
+			 "Soft Reserved not fully contained in CXL; using HMEM\n");
+	}
+
+	walk_hmem_resources(&pdev->dev, hmem_register_cxl_device);
+}
+
+static void kill_defer_work(void *data)
+{
+	struct platform_device *pdev = data;
+
+	dax_hmem_flush_work();
+	dax_hmem_unregister_work(process_defer_work, pdev);
+}
+
 static int dax_hmem_platform_probe(struct platform_device *pdev)
 {
+	int rc;
+
+	rc = dax_hmem_register_work(process_defer_work, pdev);
+	if (rc)
+		return rc;
+
+	rc = devm_add_action_or_reset(&pdev->dev, kill_defer_work, pdev);
+	if (rc)
+		return rc;
+
 	return walk_hmem_resources(&pdev->dev, hmem_register_device);
 }
 
@@ -174,3 +247,4 @@ MODULE_ALIAS("platform:hmem_platform*");
 MODULE_DESCRIPTION("HMEM DAX: direct access to 'specific purpose' memory");
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Intel Corporation");
+MODULE_IMPORT_NS("CXL");
-- 
2.17.1


