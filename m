Return-Path: <linux-fsdevel+bounces-65002-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08478BF8F0C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 23:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF209566D71
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 21:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3010286417;
	Tue, 21 Oct 2025 21:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="lhiQ+V5b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip168b.ess.barracuda.com (outbound-ip168b.ess.barracuda.com [209.222.82.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE8415C158
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Oct 2025 21:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761082423; cv=fail; b=gcB0a381MH6GQ5dIlF8S+O13KyzFHNQSsc/T0BBjQXDAl/ru/AMcRC9FVnoE53VRkJoZAY1J2YqdquH8mqww5xa2k9FboeE3vdP8J8g2kQInDlczaWHHpYeXxSLkS6kyxaZ7akUB1T+oob2lUcrUVFOEndDIRYKkunVc8P1SxAo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761082423; c=relaxed/simple;
	bh=3o4dvjOFW8KMyi6xV7UIZjzBudnC5pH2I0r9Ej7fFlQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a3jaYCv9KPew49MXIFI7bDUJkd4xDmFYThAo9s8SezaOODjlBt0icpB8PfOu4q14eVU5lKtWJr8+WaBjE1a9YUSyqXZlpTf/zGhZFtWHo/huIpvpEqtuXS8iW/B5ajY7lB1/YEe2G+s30kIIZZPMZVadiHtwujNyKXcZMk+8bFA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=lhiQ+V5b; arc=fail smtp.client-ip=209.222.82.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11020093.outbound.protection.outlook.com [52.101.85.93]) by mx-outbound19-42.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Tue, 21 Oct 2025 21:33:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vamYKFsctT6Dfb99PCCgqzyVX2p8eVfP+6++QGzUz6Orxo0trvyvgdo33JcgQIr0VeEtgSBp1x0+HipR+Fgb4IW6CAs+WggIXDIiyhrtg/9Za9XMPnVdWi18gnFRKLBw4YdAphoQSEY+SojPV8vhOK9C7ut7w8Sw+OFRk0sdjtbU3fcNgcEuwBSpYwNIndP7prDM0z5N/JipBj6yQF9gep4z9521WBUMGKqxxpL0ZgnSmBRE1XQV5r85BQf0GRFbCgPSoZbqAiNKr0lHwc9DY1JwQIt77Xe1avrn88Kv2vQoJqhz3xbBEwq4tYbEWfgQKBOzljW8NYlVJfUlPgfgNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sJW5F4R55hsQGyfZTPcZDcBVvukgprpEzeJ0KrQazwA=;
 b=yPOYxgeNNUGiINVrJejjIvb0xXhE7iM3ej7jxNJho0JhzFgmb28MFgDtz3t3Gg6wemewWNim6c+lFyQcXfwtqrNoeg32MoEioKhFhwV5z+lAIuRyjO7vrJLL1AMS+vmK4ntyv8XCTEg+0tgW3SWRTacDRShKsST0eVmdheUVG8js8KEYw44uKbPt63U2CE/jmIEhXlBbt8f6mG2GJHXBpf7H9CTCACm1YR0Gj1l4RfGzel/OZENHXLFtx3Ie139D2f+CEkpnPajEM/Ji2dONvT/0iXA8NuL0jFp/Q1P/8XEz12DC7Bmbkn+B8tPqvn6ZsHwDqWcb/MGvL3oS8Bcqqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sJW5F4R55hsQGyfZTPcZDcBVvukgprpEzeJ0KrQazwA=;
 b=lhiQ+V5brevp0t8cS0Yimz0ktuDUexzmLYBNF5Ljqhb7KCpxYgxLllrObyGD3v3yc14sODqjyST39FnPJnVR1v1bTljDKSzEspENrPrxUnoDboJL6ZTitdE2oiQNns4vIBaD++c/mNE/4oIZb73lNVMWvMKezWdOro1MbSD2SFA=
Received: from PH7P222CA0003.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:33a::18)
 by DM4PR19MB7954.namprd19.prod.outlook.com (2603:10b6:8:18b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Tue, 21 Oct
 2025 21:33:35 +0000
Received: from SN1PEPF000252A1.namprd05.prod.outlook.com
 (2603:10b6:510:33a:cafe::10) by PH7P222CA0003.outlook.office365.com
 (2603:10b6:510:33a::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.12 via Frontend Transport; Tue,
 21 Oct 2025 21:33:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 SN1PEPF000252A1.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.7
 via Frontend Transport; Tue, 21 Oct 2025 21:33:34 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id B3B7163;
	Tue, 21 Oct 2025 21:33:33 +0000 (UTC)
From: Bernd Schubert <bschubert@ddn.com>
Date: Tue, 21 Oct 2025 23:33:30 +0200
Subject: [PATCH 1/2] fuse: Move ring queues_refs decrement
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-io-uring-fixes-cancel-mem-leak-v1-1-26b78b2c973c@ddn.com>
References: <20251021-io-uring-fixes-cancel-mem-leak-v1-0-26b78b2c973c@ddn.com>
In-Reply-To: <20251021-io-uring-fixes-cancel-mem-leak-v1-0-26b78b2c973c@ddn.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Joanne Koong <joannelkoong@gmail.com>, linux-fsdevel@vger.kernel.org, 
 Jian Huang Li <ali@ddn.com>, Bernd Schubert <bschubert@ddn.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761082412; l=1748;
 i=bschubert@ddn.com; s=20240529; h=from:subject:message-id;
 bh=3o4dvjOFW8KMyi6xV7UIZjzBudnC5pH2I0r9Ej7fFlQ=;
 b=A/YSbVdfVAT2CealMi6jESJgDsSoN7my0k05zM/EmIemg1xdLWMruVAlmpSDrBTht5kZXht0O
 uecMYD1bL3pDN3oO5bxb0LErdI248hV1EKIF6FBl9D6pan7U+bDnOGg
X-Developer-Key: i=bschubert@ddn.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A1:EE_|DM4PR19MB7954:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ae13489-607a-477a-d661-08de10e97d15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|19092799006|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aW5vUGNyZjA1bzRLbjEwZnJYYnBwaFlVemxJRXpjRDRhbU5naFRGTjh3UCtr?=
 =?utf-8?B?dE43cWJoRUp3cVFxN2ZkUjBqTExmdDF5OHFkS3kxZ3htYUtKbHBneVhJbUVP?=
 =?utf-8?B?YkxDWnRYcEZuZXBxNXN3U0dLdkJ0bW5jdU95Z0dQYmZTMVBRU1FUd1pVZ3Nw?=
 =?utf-8?B?VzdDVDkrWXhUU0E5cHVsTUQ3YVlramtDVnFyYW1ta3lQdWxYMGkrZGJGazU1?=
 =?utf-8?B?WS93OHZNMUxhTkgwS2RYU1JpRG0vVDVSemRzdEdVM0JOek5wRDVHVkxvOHl2?=
 =?utf-8?B?cTl1Umd0aWdLc3ZpRzFsMzdxajAwYlhaS2FRdkdST0I4NjRRc1dhWWV0QW5a?=
 =?utf-8?B?YzJNNUpKVDZkYSt5NEh6ZGVEVVVPNDkvdGd2Q3B1aWt6YW1iRWQwLzM3WTRv?=
 =?utf-8?B?cEIvUGJ2OXpQRHArQkpuS21mcEZncGFLa2lIYUp2cFV2Y0t6enBDYkF6NGpK?=
 =?utf-8?B?TTNWcE4yZk5ZSjZlVU5xT1NISHlab29rTDZzOTNpcXdoWnErc3ZqWWNVWXZo?=
 =?utf-8?B?T0ZLRDI1OXEreWpFcXdqVUhTcU1NeXdwM3NxejFKMEYvSGF5bkJONFpWbmNS?=
 =?utf-8?B?Y0d4UnNrSDc1ZHU3alk2K2szQmt2Zy9kQm9CYU1UZnhkNGtNdXVpNGtrNkRw?=
 =?utf-8?B?b3dmYmJ3MEV2bytWaXhQVU5NdWY2ME9ETmhvd3IrdlRNSWltZnMyWU13cURz?=
 =?utf-8?B?S0ZNaGQ1Q3U3OFpwWEYyZDl6YS92eWJtYVJ3K1Q1anY3dk8zTmk5d3BQZkhR?=
 =?utf-8?B?QXRpdW1tWEp1cmFXSnZXazdhYVVpNHVQMGVtZnd0V1dnc1VlOUp0TDJGdmhS?=
 =?utf-8?B?S0g4dS80Qm5XWmJVdmJGQU1Eck5ZS1JYSVUzYmowQ29icnhmRHJjR2lqdXhl?=
 =?utf-8?B?SzkvZWNJNWdhRGRTaDlpMHBMQ3VTV1I5bGpZVDNaV2FoYU1POGJjUkFLZ1hF?=
 =?utf-8?B?NFZMdTk1ZExnZ2JwU1BaN0VXZG9XNXVZWDFQYjBQamttNU0vSC9iQlBrdDBp?=
 =?utf-8?B?UGU1d0xvcjZUTXUxeW9yYitrSU9GYU5XemR1bVVmK25ROFdDSm1uN3J3TS9o?=
 =?utf-8?B?Ums0T3k0SjBWMUErVEhJNXlyNmU3dnNOSlBHYjBWckNIcDJ6U3FMWXJLbVZ4?=
 =?utf-8?B?bzQ2a2JwRUxJdS92OHBzcmxZdlhKbUFiR2hnK1NoRFVXZGxQNmNSbng1RE9F?=
 =?utf-8?B?SEF6enhlRldyM3poK1FzUEpMaWZka0orbDNEK2k3MC9PSTAzWGFNc3I4RFhX?=
 =?utf-8?B?R1phSm9OTVI3dXpZUVJvZlhBeXN2SVJqRkl5eDdKM0pMNUFqelJJVjc1OFk3?=
 =?utf-8?B?bndmTVB6Szg4SzFxbDNUUU5KVTFZRlRrS2pEdGp2K0pMVk1SSXAya05MbmhK?=
 =?utf-8?B?N3lNRlhZS0VtczBjNURpYzhLSmpVMVZ0RFFEaWVoVXIwSXVGZnZjdzJ1VjQv?=
 =?utf-8?B?dENkQStWL1F1NTJkNXcwa0V0Vm5zcEtndGc3ZGFHMCtLL0FBd2NIQ2pWNVZR?=
 =?utf-8?B?MWN0NXUxU1NodzBnZFhUbzc0cDhka2pqVGk5aC81MStMMThGelhrVEtobStG?=
 =?utf-8?B?L0Uxd1BNSVU0dHgyazFwQnBWaUlXVXlmZS9naFhBd2V1eVNYblY4YmJSVW5j?=
 =?utf-8?B?d0htRmo3enFjbFJHZ0R4Q1ZZamRzNGVpUGY1SmJVRUVuT2pNZzZDSzNOUCtS?=
 =?utf-8?B?S09XdzNmeFFNQis5OU53Tk9Xd2grbVo0eXRmYzZsOVFiS29rYzlTT3RvTFAr?=
 =?utf-8?B?VGJZSStNQ25nSnN2Q3l3bFpCbkRJZkI0djZaOUtGUjExd1dWUWVjZjZ5ella?=
 =?utf-8?B?WUx5NTVtb2pvWUhCWmtXalU0WjNUUllSVlJJNzJ1VG9TMU9WemsyZDlMZzFo?=
 =?utf-8?B?MmpscUJnZGI4WHV1bmU4b0VkM0dsMVl0S3FpK29uTnh3TENRNkZIMTkrNGx5?=
 =?utf-8?B?RmVDajZrUS9aOGhNbk1Pb2p5bEMvblZvYjVyakx3U3lRYmlxb1ExeUdGMzNz?=
 =?utf-8?B?S0lxcEUvdFFXRDNoK0dtRlJQQm9PZEo4QjIydnBpdVFSbG9tSkxqeGl3V3VR?=
 =?utf-8?B?YUhnSVVBVHdLVjRmODJEUW9TOVVMN2FFeThEQTM1M1V0dS9mK1pLbU5ub2VG?=
 =?utf-8?Q?gIog=3D?=
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(19092799006)(1800799024)(36860700013);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	q0OUwc0KbVYSVjveiCxPQo0MC8eRt2qF/Dgn3T0A7HdZF9ZYLyFHKDIsZCAgwqgCWn+a6SCKFPyA6+AzOLtYXfpAVoMVzhSYN3lj+TF12BRXeI55L2V6CFNKDWsKQLfn7FT3smCRbrk5pyDwh9FllapJKkWQh8scshrJvJG+y+nkN/Qh9VhAT0D1G3NRhFDgof9CvRRbH73t3gGZSeXLfk+5VA1IaZwFc5mZdaafULKNfVTluiKpodvzWkzepplE9Yy4Cu3yC+pAsLsRWXFyfoyv1xs+RbhZTp7ZnHBazDKzdShKWrs+pv+SMjWwXh1BoUQ0MGJImxSL6k0i0/TfP210nSgsTXnYmbRbH9ybO5U/VF2A9hjWL2UGc4fLpBS+GBFNswNH5xFOjUHhJ7TbopclIPbQcTwHI56LS2kD1RbdfPiuiRsP9/hrfRZ7pXX3MuD/6bDQFyxh1P6ZFgG0NqdxfD0zIKr/sYzJnfwO4HuksuFRNTav426Ju77Byk0BimtvXqsvFYRhLzEO/x+DuqIw31J4GTnIQ/2aI64+Y8FPQXmQgbleYOEQC3+VXl377t7iXTKUcM3RPjdjF17b75k6TcAFaB2jS6n3aHStpwJ3i3YFDpF/tjsKuLIRxSVz1vCtelDOYYOtR48Nor1dOA==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 21:33:34.4328
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ae13489-607a-477a-d661-08de10e97d15
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR19MB7954
X-BESS-ID: 1761082417-104906-7688-1070-1
X-BESS-VER: 2019.1_20251001.1803
X-BESS-Apparent-Source-IP: 52.101.85.93
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoZmliZAVgZQMNHCOM3E0CjFIC
	ktzSzFxNgw0dzUKMXENMkyzcjEzNJUqTYWAPfRXJ1BAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.268377 [from 
	cloudscan9-51.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

This is just to avoid code dup with an upcoming commit.

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
 fs/fuse/dev_uring.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index f6b12aebb8bbe7d255980593b75b5fb5af9c669e..e7c1095b83b11fe46080c24f539df17e70969e21 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -328,7 +328,7 @@ static void fuse_uring_entry_teardown(struct fuse_ring_ent *ent)
 {
 	struct fuse_req *req;
 	struct io_uring_cmd *cmd;
-
+	ssize_t queue_refs;
 	struct fuse_ring_queue *queue = ent->queue;
 
 	spin_lock(&queue->lock);
@@ -356,15 +356,16 @@ static void fuse_uring_entry_teardown(struct fuse_ring_ent *ent)
 
 	if (req)
 		fuse_uring_stop_fuse_req_end(req);
+
+	queue_refs = atomic_dec_return(&queue->ring->queue_refs);
+	WARN_ON_ONCE(queue_refs < 0);
 }
 
 static void fuse_uring_stop_list_entries(struct list_head *head,
 					 struct fuse_ring_queue *queue,
 					 enum fuse_ring_req_state exp_state)
 {
-	struct fuse_ring *ring = queue->ring;
 	struct fuse_ring_ent *ent, *next;
-	ssize_t queue_refs = SSIZE_MAX;
 	LIST_HEAD(to_teardown);
 
 	spin_lock(&queue->lock);
@@ -381,11 +382,8 @@ static void fuse_uring_stop_list_entries(struct list_head *head,
 	spin_unlock(&queue->lock);
 
 	/* no queue lock to avoid lock order issues */
-	list_for_each_entry_safe(ent, next, &to_teardown, list) {
+	list_for_each_entry_safe(ent, next, &to_teardown, list)
 		fuse_uring_entry_teardown(ent);
-		queue_refs = atomic_dec_return(&ring->queue_refs);
-		WARN_ON_ONCE(queue_refs < 0);
-	}
 }
 
 static void fuse_uring_teardown_entries(struct fuse_ring_queue *queue)

-- 
2.43.0


