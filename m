Return-Path: <linux-fsdevel+bounces-37558-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B14F29F3C92
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 22:19:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBDE118910C3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 21:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40231D63E2;
	Mon, 16 Dec 2024 21:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="QzIL1Gat"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip191a.ess.barracuda.com (outbound-ip191a.ess.barracuda.com [209.222.82.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43301D0F61
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Dec 2024 21:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734383672; cv=fail; b=g2K2gEsdEeXBW3u1ujgtpfSst0eijdPlpq5Nz+vBeV1S/fBav/VxrC+q4swl/Quh2nqkrJgVwjGDnGmbaWVotHSYQi60TTbvhwLpxjShR2PHRxUfQcxcREiZ3LYuZHndr5o59G6ejmt8U7lew61Tw0jSau5pa6hBJ2iYn3dMYbM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734383672; c=relaxed/simple;
	bh=Y+jl8fICPjJPTBlBvriWveQNF5Y6GNKCsIMoskeilno=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U1UPJo10lfl1RNxdJPC1r5LBCFTNwBzGSuzl47DHvVT9mTd1si6Hjpd0KttA1tnUekuKiF7FhrGOUaH79cjsWIchPFr8LJ5G2T6b6XCiZ+OC3o7xktxuhpCJ4iqoJBSMAWnvyvuyzRKoTZ5sV4SDIDnQLDb5XeY61LZaWcdiTdE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=QzIL1Gat; arc=fail smtp.client-ip=209.222.82.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40]) by mx-outbound44-94.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 16 Dec 2024 21:14:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L27Le/izyTaq6nlGmByD1/yn0TDZQofvh7Fh7DnisL3vRZ3pd8hJnYeoQnwanOeGQo8DENK/wiC/KnduqKM4rPHwszG3yXEKWj2xwOsWE2l4Wn+ZKxTZaiPekVB9YR5PYfI0ip6e52Mrtcba8yjTUyGj0F4lMWcsmU+EDDWfLwl2LYmRyxfbcaa8swHCBzO+HOY2GX6di/q111RFfmDREkYKORCtWA1DAHbVi8H34x6RRFcYfOd/5zeE+bd6Wa9tE1evhPf/A2yBTC31JMgFBffxwh+Klhky574oCkJ7EuizAv5p9spZPo7SndaK3oiLdbS0pIuwn5aMqvImjw5diQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZdSps3YBtV07uS+VoI+vP2dxi49kD12z1ukJ6D+LLZM=;
 b=hRfvQttVW/pd3G/sACmRhCicCY3vTFakwYTgOglhvzVSLXqTGK7kcHtbXdNMKJDPQFkVihkl0Q64mopz3vXxGyTYlaQvuUP0OTeCi1oIIGgrbLm+nKik+PoU8zTp41uscUulsl3wB4ORVQNVI7uuEAa9kJr4kqvDXDCCWTwlxZUULomXGkqgmY5qc3VL+XAKuZRJ/eTxGJbxsaVqIWMF48/zGlJowp2k8tBhvrjqpy7Z59lJZouVYnMTE8TAwnCxQ/79Y8lV8yMAdI/1Evx2zwMN4wAFrsJX7EGKDlQe42mEngHTX4FCdrTzrW+GUM0mcSdjnqrla4PRdbvMroxU1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZdSps3YBtV07uS+VoI+vP2dxi49kD12z1ukJ6D+LLZM=;
 b=QzIL1GatPy8uqiXCPAzlQpLr+Y3p9AaPQ4pNubYzhbI5T8JCZTXvUqlOqZqpky/COPNnS9+BmcsHNSApcYI1xnu1+bviASBaFQFdnjssZ4IDoHRisp9fUBuOAk9MeSzwSRcjboJriw0OiICkSv0heSvHe8yhGFed5fUOIRK8T/I=
Received: from MW2PR16CA0062.namprd16.prod.outlook.com (2603:10b6:907:1::39)
 by PH8PR19MB6976.namprd19.prod.outlook.com (2603:10b6:510:228::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Mon, 16 Dec
 2024 21:14:13 +0000
Received: from SJ5PEPF000001D4.namprd05.prod.outlook.com
 (2603:10b6:907:1:cafe::5f) by MW2PR16CA0062.outlook.office365.com
 (2603:10b6:907:1::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8137.28 via Frontend Transport; Mon,
 16 Dec 2024 21:14:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 SJ5PEPF000001D4.mail.protection.outlook.com (10.167.242.56) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15
 via Frontend Transport; Mon, 16 Dec 2024 21:14:12 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id 8F48A4A;
	Mon, 16 Dec 2024 21:14:11 +0000 (UTC)
From: Bernd Schubert <bschubert@ddn.com>
Date: Mon, 16 Dec 2024 22:14:06 +0100
Subject: [PATCH v3 1/2] fuse: Allocate only namelen buf memory in
 fuse_notify_
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241216-fuse_name_max-limit-6-13-v3-1-b4b04966ecea@ddn.com>
References: <20241216-fuse_name_max-limit-6-13-v3-0-b4b04966ecea@ddn.com>
In-Reply-To: <20241216-fuse_name_max-limit-6-13-v3-0-b4b04966ecea@ddn.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, Shachar Sharon <synarete@gmail.com>, 
 Jingbo Xu <jefflexu@linux.alibaba.com>, Bernd Schubert <bschubert@ddn.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734383650; l=2235;
 i=bschubert@ddn.com; s=20240529; h=from:subject:message-id;
 bh=Y+jl8fICPjJPTBlBvriWveQNF5Y6GNKCsIMoskeilno=;
 b=fheJ52aKEMXDrTMC/tlz/BJNO8fTP7i0b8vZMJXYCKPKahBG+UdhzeBJG0jEBBuxFYfInzurQ
 WIHH/M6sdbBCP1IoUQtGCKN1VQMUeePg8/lfV1s+DK+PrAI79TWpHh3
X-Developer-Key: i=bschubert@ddn.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D4:EE_|PH8PR19MB6976:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fb126ac-9457-4d18-0d09-08dd1e1696e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZVN6N3JjdktMbDdsYnVWNUtHVzNyRTRBTEVscXlYOE1ZdWNrNVYxdGZTQmkv?=
 =?utf-8?B?ekFOL29SVCtLSmN3bzhMVFVLWm5FY2w0bTNYYkxFckZRQU85SDhsOVJwaTlF?=
 =?utf-8?B?RkkrYmpUYmF1Zkd6V1FlaWNLa1VXZ1ZYUUZLdnJiVXc4Q3JiditianpLOFlC?=
 =?utf-8?B?UFJ2THN3S0JTcHZGQVV6bU50VHlDUzNHbUl0SFdBNUM3ZFNPRkFSZW9rVFpk?=
 =?utf-8?B?SmpTQzgvNTVZMkVBVzMxak8zcGViTDhlZ0VhZTN6RWpEM0lDQWdVWkxYbGZl?=
 =?utf-8?B?K1hBSi9mT3Y2MjFRR1pVdXR6OGh0cDcvY0lzMGRTdzRaOHJVbVV2ai8xOWJj?=
 =?utf-8?B?a3FwMmNYVVRKOFJKQU9kNzR0cGV3cEtLOEVWbHFZQ0lsUm9HRVNpc0hYR3Fq?=
 =?utf-8?B?eTgvNmVaMlBncis3T1ZzQXhoK2NWRmNRVGVCdlBTWmRLN0UwSXY5TXQ1VWwy?=
 =?utf-8?B?aksybDRZRDIxS2ZpZnJOTWhRV29LRjM5elhzUW5lUURPemE4cm1WbTdkSzl5?=
 =?utf-8?B?Q2NOVi95ck8vRU9TMnhHT1FHWXpFYUR1QkhvZHBTNFU2OUg1bHpMVDVOTzl4?=
 =?utf-8?B?czN1T2V6SGVNb2dxTStEUW5JTW5XNVJSWk9JSmM0WEloa2dGNHZqR0FwSzc5?=
 =?utf-8?B?bktlcDl5a0hKK1ljNzQrdGg1WVI0bGxiSTBFZ2pRV1A0cWRqY1pYbmE3SzNJ?=
 =?utf-8?B?Zm04d0xEaWJyVy9iSHRFUURhTWlGSGFUdUFqUjQ3OGxNODl2TjdkaWNCdEd5?=
 =?utf-8?B?S0s0MjVnOHVLRWJQUTMxZGd0UGV1UHVmTElQSE5iZHNuUllBSkJWbytMbFpv?=
 =?utf-8?B?VzNoUGpZa1BNMW1PbTJ4eTdLNW9HTjlEbkF1eEpDNjNtaUYySGpKUHh2Zjgr?=
 =?utf-8?B?Nk02OVM0UXp5QkxqdkU2ODBWbFdEODJCQ1h0VWJWVVgyNVlMcXdnempqTC9Q?=
 =?utf-8?B?RGxpVTZYUjlYTDNGSDFyVEcyMXVXTlJKVmNUWUZ2VkFjQThURm9CZktNL1dn?=
 =?utf-8?B?VzNWV3JGZGpNNUtSZTJQSGNuaVdHNjhRa0hyK2N2Qy8yeUltSEVFVFRPMXIr?=
 =?utf-8?B?ZlN6WnZERXUxU29kelVTbXJtL0RWMnJTaXVMMklKM01aL2ljVkQya0JablZI?=
 =?utf-8?B?WVJETWN3TnNTMEhpN1FlWVpaVWFJT1c5YkhNVTYySk40dExpbm9EbTdlUzlF?=
 =?utf-8?B?WUhxWVpCVEN5aFl0c2JESGlnTDRpM3FqM2lndlRtSFYwVkJqMXlRcmRpemY0?=
 =?utf-8?B?YXYwSVJJYll6U1dhdTRJRVJIbWwxKzJWWmVucDdHeWhFQVNUditMMkh5OTNJ?=
 =?utf-8?B?SkxEMTQyYlUwYVNUcEd6VHlQK2FuU2xodS9tOXkwNFZqUUdzK0hKbi9aOTJw?=
 =?utf-8?B?c1d1QU5lQmxrYTV6QUJWTUFFVmwxUUg0NVc3VXFCU1RMbUhTSFNnTVoySWhZ?=
 =?utf-8?B?N1JFTHZuVGhQYlo0UVh1V3Btam9CNDBvRm5LRCtVSXhodkJXdzQ5bHpveDJW?=
 =?utf-8?B?UGl0V3N1b1gvRk1BSjhLVWRTYnUySHE4Tk91a3BwMEplNCtFR0I1eWJnYUlh?=
 =?utf-8?B?ZzdDZUxyUWRxdnFMT25uc1FQSjh1NHhZQ0ZVYnhiWS9CYWFCNGtKc0owMk5T?=
 =?utf-8?B?Z2JTS09MRUZhczB0NmJQaE03b2xTMk1mNnZQQXRoVlhUd09PS1RrczFxekZi?=
 =?utf-8?B?bVp5MmszQm85L3N5aGxNbmNjZDY2dFovM1NLaGtHWTVZN21MaGFWV3dCWkFI?=
 =?utf-8?B?Zk12WHJKcnhDa2FUaHB2OHIvZ3h0ZzFIeDY3WVYvSnBHWk9VR3doaUhVRDdV?=
 =?utf-8?B?TDB5eDIrUTB2Y21zN0ZqVVJPaXBkMlZ4azAxeVNWUm5DN1FocUJHV1ZyS1JO?=
 =?utf-8?B?aVRiUmFVMXlPSWtXQ3hlODRXNjFkVTUybm9OaE9VdVoxTU9JeTF4NTcwcUtr?=
 =?utf-8?B?Z0RWcTdDbk9oako1L1BWQWtKeTlENG9NWGQ4UGpZUFJxcHkrdGltZUNIUG51?=
 =?utf-8?Q?WcRBJlIYxkXYwlfcVH+6ssJRvIU9/8=3D?=
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Wn06UK26fSS8cZLnSPNdAxyn5OOUSFXy+ygOnGWae28l7K9G64Ek1YJeuRzmx1S3HEqr6ExFM3yLpt4zaGH3e2MbLQBpjHsOzieYmpB4CHTTBjQV7l4ZE9QbYtz7I9s8PNaLofaOMSHXT6qbATHLJVHkXAeYo/e5YILAQgZIeQotwqBt+xzHkuq5T1EYUqMmcqnac49v0cq64r2nlnLGxziyl/Pemm7xychICjf69COZK9dC080qlIrcZN8aYSSJMQdYPUsRZ84zyA5swnBnose1VWM2YStLGV8wa/XxTdJzmmWyHTBIjeqShrlVBcwbo06dbcDQJerm3rDiOY3Dd9m95kqH+NuQbSi1Tf3EEvhFR7nVA+B5TPrhbXcDgImaUkNboCp2Munl2+pf9WSSQsMQoBVAI0HjfEN73qK94rfnVWokkU4vhod+L1Ndr/Lf1zu2QhGybIYXfX3y0y/5dJRUi3jbWUw4s7JXhVAae8ObBPhNGmYy+ZcbUAQ+SM+22vw/duHyVi6rbexz5Owv3GECHN4PjVhXUO8KK2MblQJF40gHtb+NX5BU/jQxrADCKV3lSwXWikSto08I8xmf4K9C5G5zt2mh4Y76gPxt6QDyjpe1GxqZWXOn36g+TEV+KQYjXhPL3uGBRngIFGSnXQ==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 21:14:12.4920
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fb126ac-9457-4d18-0d09-08dd1e1696e0
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR19MB6976
X-BESS-ID: 1734383658-111358-8094-8412-1
X-BESS-VER: 2019.1_20241212.2019
X-BESS-Apparent-Source-IP: 104.47.73.40
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVkaGZgZAVgZQMM3U2CQxycLSMC
	kxMcnE1CA12dggNdEoJdksJcUkKSlZqTYWAOjb6fxBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.261160 [from 
	cloudscan9-188.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

fuse_notify_inval_entry and fuse_notify_delete were using fixed allocations
of FUSE_NAME_MAX to hold the file name. Often that large buffers are not
needed as file names might be smaller, so this uses the actual file name
size to do the allocation.

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/fuse/dev.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 27ccae63495d14ea339aa6c8da63d0ac44fc8885..c979ce93685f8338301a094ac513c607f44ba572 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1525,14 +1525,10 @@ static int fuse_notify_inval_entry(struct fuse_conn *fc, unsigned int size,
 				   struct fuse_copy_state *cs)
 {
 	struct fuse_notify_inval_entry_out outarg;
-	int err = -ENOMEM;
-	char *buf;
+	int err;
+	char *buf = NULL;
 	struct qstr name;
 
-	buf = kzalloc(FUSE_NAME_MAX + 1, GFP_KERNEL);
-	if (!buf)
-		goto err;
-
 	err = -EINVAL;
 	if (size < sizeof(outarg))
 		goto err;
@@ -1549,6 +1545,11 @@ static int fuse_notify_inval_entry(struct fuse_conn *fc, unsigned int size,
 	if (size != sizeof(outarg) + outarg.namelen + 1)
 		goto err;
 
+	err = -ENOMEM;
+	buf = kzalloc(outarg.namelen + 1, GFP_KERNEL);
+	if (!buf)
+		goto err;
+
 	name.name = buf;
 	name.len = outarg.namelen;
 	err = fuse_copy_one(cs, buf, outarg.namelen + 1);
@@ -1573,14 +1574,10 @@ static int fuse_notify_delete(struct fuse_conn *fc, unsigned int size,
 			      struct fuse_copy_state *cs)
 {
 	struct fuse_notify_delete_out outarg;
-	int err = -ENOMEM;
-	char *buf;
+	int err;
+	char *buf = NULL;
 	struct qstr name;
 
-	buf = kzalloc(FUSE_NAME_MAX + 1, GFP_KERNEL);
-	if (!buf)
-		goto err;
-
 	err = -EINVAL;
 	if (size < sizeof(outarg))
 		goto err;
@@ -1597,6 +1594,11 @@ static int fuse_notify_delete(struct fuse_conn *fc, unsigned int size,
 	if (size != sizeof(outarg) + outarg.namelen + 1)
 		goto err;
 
+	err = -ENOMEM;
+	buf = kzalloc(outarg.namelen + 1, GFP_KERNEL);
+	if (!buf)
+		goto err;
+
 	name.name = buf;
 	name.len = outarg.namelen;
 	err = fuse_copy_one(cs, buf, outarg.namelen + 1);

-- 
2.43.0


