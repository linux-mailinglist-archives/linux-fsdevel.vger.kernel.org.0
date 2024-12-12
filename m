Return-Path: <linux-fsdevel+bounces-37236-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E1B59EFECE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 22:51:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 524B716B9E1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 21:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F4B1B21AA;
	Thu, 12 Dec 2024 21:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="QiCakhpb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip191b.ess.barracuda.com (outbound-ip191b.ess.barracuda.com [209.222.82.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC981D79BE
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Dec 2024 21:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734040249; cv=fail; b=ZXNubXak8hLq4rD/qIFFUGAfYhClX0p+JSWBx9vwo9oTTAwuJGuIYsKBeakgtttgopj6tIf7L9Af9mupYkbnC4Mn0HlK1Cuf8HLTGfpQm+PzqJfwAhENWszuurrskBsKT8cFpYW0STDRU/CIvXsub7n3/NfOhHi4jjB8kDXhjjo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734040249; c=relaxed/simple;
	bh=27uI/83Wo66dN1R2ZFpFey9JybTCeP7Z38LGSptFJX0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mtGaDhP8yYRprYCHIRsDX4JPMwB64lff8cMGRX7ewoKDPNlC65SQfjfOQFLveBdI0J8sRL5D5Ofn8K+VTiuhT1auZr5SK8IsP28Us2HuJizUspCGGn6wbXaVI5MJv/hX6lw8btlE2+GUlSHwE2wXNbai1pmjsmTCSgg3UIGeQTQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=QiCakhpb; arc=fail smtp.client-ip=209.222.82.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170]) by mx-outbound18-182.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Thu, 12 Dec 2024 21:50:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GTAJNtd15FliiTcSovldOHCPg5nnj0detdRWhfqKFimQx8yFyvTuRB50873djl8dPxLZkABTwoBMD73HeA1+SE7NQYMKhjV5p+o/0gholIvxkpfDbC5W8FGpRf54su3m1BHuwKuDk2v3DHJSRpuCfDKz3Hhb2fiH/Z26sM8ziSBd6TJtwBfgsUwDOqo+Id8AnFL8Xs/Xt4uTTCzSBEkQH3bPYiwOwjIbcLxrOWA6aori7AkbhBnlhTy8zLM+oH93GO3JV+u59iKni33olgnmLlbMSpuaDB67//55R7lqNwXF2PdRfD9SJNtVclqn+vm7VV0k8EBMTq7xQYSJi23/PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QxauPhNoPknuKGY0jNish0hJHf40Fk7uU8ChAZBk2sk=;
 b=Renak1yRrUCg1/CCjeRd5FoNtGUye0FQZ6vEyM0f5fAcCLNQqLUz9BDOEYvBKYSdj3CI06YmT04Gexj2d6fjjvJTMaIDriJtHGVaT7YaS0vzuYN+4Hk2yc0F6u5zlmE61HWZJOIx5wXbkUtIrFMNBjz6Bnlk1QJ5dm6S4H3lKZOFTIyJHQLtxAQCOcpI1GNZbx88fUcr8UVg9EwAobGirybvATNzS1QjfWxnWLWb5AqJNf1JJ6mV4wcbDxW5b6vzoBAxSZIIm4DEP9uAloY9Ron8SgRWIQNCVaCn8rMPMzWQKC6+QHKPANRzt4VSxuB0AtZkO6JJQwqMQTwpHgzdOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QxauPhNoPknuKGY0jNish0hJHf40Fk7uU8ChAZBk2sk=;
 b=QiCakhpbzHWhMkR1x6GojiLuLRDNvJElQZs8q5ZhhOR+B/t6+FdaW1r4EQkQsl9r1/xS4xv09236aYSJNZBlR+haU1+ucWKar4pQgLiSc4f521+c4+D0sbvFdqdq2IC/gC3qUoPh+GSHaWf56KL05zLb4aKir3zZJDwyikqlyz4=
Received: from BN9PR03CA0497.namprd03.prod.outlook.com (2603:10b6:408:130::22)
 by BY5PR19MB4728.namprd19.prod.outlook.com (2603:10b6:a03:1d3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Thu, 12 Dec
 2024 21:50:36 +0000
Received: from BN3PEPF0000B06B.namprd21.prod.outlook.com
 (2603:10b6:408:130:cafe::1) by BN9PR03CA0497.outlook.office365.com
 (2603:10b6:408:130::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15 via Frontend Transport; Thu,
 12 Dec 2024 21:50:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 BN3PEPF0000B06B.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8272.0
 via Frontend Transport; Thu, 12 Dec 2024 21:50:35 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id C318355;
	Thu, 12 Dec 2024 21:50:34 +0000 (UTC)
From: Bernd Schubert <bschubert@ddn.com>
Date: Thu, 12 Dec 2024 22:50:33 +0100
Subject: [PATCH 1/2] fuse: Allocate only namelen buf memory in fuse_notify_
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241212-fuse_name_max-limit-6-13-v1-1-92be52f01eca@ddn.com>
References: <20241212-fuse_name_max-limit-6-13-v1-0-92be52f01eca@ddn.com>
In-Reply-To: <20241212-fuse_name_max-limit-6-13-v1-0-92be52f01eca@ddn.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, Bernd Schubert <bschubert@ddn.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734040233; l=2182;
 i=bschubert@ddn.com; s=20240529; h=from:subject:message-id;
 bh=27uI/83Wo66dN1R2ZFpFey9JybTCeP7Z38LGSptFJX0=;
 b=ZVj4R6dtBZXaDSv0Ov36S94Yuq/Y+mn/fyCuBq/KIYae5y0rmG3UIRstWbBKQ3O3g5BBtZ1XE
 6WdrwnMlrAgAq+lSIG/dipA1kjT/eqlwcQ9a+GFr7BOVU1Ay4HWf1Rf
X-Developer-Key: i=bschubert@ddn.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06B:EE_|BY5PR19MB4728:EE_
X-MS-Office365-Filtering-Correlation-Id: a5158ad9-015c-4f68-b6e8-08dd1af7028d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ckpYb2pZTmFpYUJXNEprSnBRbjk4dGg3eEFHcmorWnZiaENRRmkwM1JaKy9O?=
 =?utf-8?B?YU8vZ0tHdFpBaWVsc1ozQmIrMlNSRm1ORHE1T2Y5aDJqcmEySi9OUXlpU1Bn?=
 =?utf-8?B?eW15cWZ0eHV3T1BVeUc1K3NmNVlUVExjV2NGRU02RU9RNnYzTkdBRjRETytJ?=
 =?utf-8?B?ZklVT0E4Y3g3d1JHYkRRZkIzYjNDNFFIMzcvei9aY2tzQmg2VFM4VSsweHlO?=
 =?utf-8?B?d2RsU0FXVVdTaDVRM0pUc3J0SThEVjNWeDl1QXZ5ZzR2TzQyOTdIUE5hVzhE?=
 =?utf-8?B?Y2RqMzhnN3lFN3NFc3U1d3BXeU9nei9LZnliYU5GOTdLenNRQm5aalRtVUFz?=
 =?utf-8?B?aFRyWXdZeVE3Q0tUbTEvTjg1cXlEdE5xMkdZTlFacHFXbWpEYVdkL2E3c2tJ?=
 =?utf-8?B?QXk0U0xNNXFOeVpSMnhGNVNFY0cwc01VeFlBVU9ENG93bllGcHQxVHhqdVZm?=
 =?utf-8?B?QmZ5N2l6UVZaQ25SMXFoSjdjSXF2QnF5UnRpTXNKVnRTS0Q2N3N2dk9Mbm43?=
 =?utf-8?B?N2cybm8vZzc4U0RDbEFUYnp5SDlUc2JhYUdiSThCN05kbW9hSDVNeWFadVRz?=
 =?utf-8?B?bU9jY0ZVWGtGRXRab084TGFaQzIvYjAyZDVpT2E4UVZrdFhYTXRnaHA1K1Zw?=
 =?utf-8?B?QzB6VkpESXNTcXJVZit5YldUUllPMDZOaFlXamJzQksrYVA5WVZzSzNTeGtk?=
 =?utf-8?B?c040dlovU3grYk5kazJpRlpkWE5BT0tTMzladjNZQkg0U1dhd2NuNnZnOUlw?=
 =?utf-8?B?aTB2YlVQTEcyaEw5bmlONVNyQmVPdXQ3aklNc0pubmh3RVNuWjhyYVkrUmRT?=
 =?utf-8?B?UEMyVFpyZGxXeE9yNXFxRnV1YktNSVMrQjdQZ3lzcnNxMGxEazlqbkVuRkRL?=
 =?utf-8?B?ZkhhTmt6QUhaWVhWNnZicCtwNHdwTW1mOW53alptUXVtQVoxOGs2Q3ZSbERW?=
 =?utf-8?B?V0RGK1Q4akxhcWNDcUV1MjZoUXY3dHlVUGdyMkU1emR0bWxhRjRKUE81c0ZP?=
 =?utf-8?B?bnZqcW1jRDdIdlhSbDQxQUUrMnA1VE5LQkZPcE1sN2k4eU9NQVplb3E3UHBP?=
 =?utf-8?B?TzBHZml2Y2ZFREVkMytkTVpNa1hSYXhiZlBPOGltU0tXS2srMEE0eWZUYmRl?=
 =?utf-8?B?N1VLTWJ3OTNUekdhaGNSOTlzSVNWZW5CdUwweHJncnkwbXJKZjRhajJ0ZHlx?=
 =?utf-8?B?bjlvZlZDOVg5UGw1ZWw4YWxnd1ZBS2llSHNWcFZhN1BFMDFjdERVeFFrRFIw?=
 =?utf-8?B?TmNpV3U1cXFsSTlhVFgrRzVuZUllM2d6TkRUQktONjNJZjFJTnBFcUxmUU5G?=
 =?utf-8?B?K01UWnVOUWlrbW4rN0NLcDBnWFZQVXBVOVlHOWt0UU80VXJyMmZLUjUrcnhn?=
 =?utf-8?B?WUg2VkVFeVhHQUpiQngzRDJrQkROS1Uzd1JFWi92cXZlTUpEMDIweWhxMzI2?=
 =?utf-8?B?R1cva0g4MjZ2c3lMUEovbkxxdWRYdWRIT2FEbHBPOUYwOGJBWU1NQ1dsU282?=
 =?utf-8?B?MWUzaGlQeU9zbUhsbDgwMmQ3ZEwwd3RPWGRyY2o1T0hYRk14ZU50QmVXVk5G?=
 =?utf-8?B?aDRWTWthV1BhVWQ3M2RRSTJnYXZhUE9PZWVnR2NoVFV6Z3hCZUdvdldTbVdV?=
 =?utf-8?B?RCtnNG1aR2VkdVFNK1NWSHNVTDJmbEt4QnR2OTJGUGtxbG54UStvNjRIY09a?=
 =?utf-8?B?QXRjV29ISVRaV0R6Z2tPVmdKUVRjbkgyNFRNVERNWWFmRlB3bnJJYTFBUDRV?=
 =?utf-8?B?VEZWekt0ZUx6b0htNzdIK2NNMHBNZXc2NUV5QXU3YWdwbHpQQmtyajFsMzhX?=
 =?utf-8?B?UGtDTjF3RDlURUQ2aTBRMDV6YnpPdG1ZNUZaUzZtZXo5YktqdnBJMDdhNm90?=
 =?utf-8?B?cVhnSWRFOXN1eFhZZE1pT2UwWm94YUxjVS84SHpPMjE4ZDhuL1ozVzZiU2d6?=
 =?utf-8?Q?+IKrt76xr5iSmh5wGgXEYLl7f80R+/Wd?=
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	GoBDiemW+0jr3AJI3XA9tiXAmO0Q4H2qmoTjK8AL1bgpfOymlDsmQ10rq88ZagwdeCtMNvs3tjdG9F8eZtDAue+2g7hERCxyaqFm0iC7YBfSxZFF1iLlso64VQMz74pPDWje9OCL7oisoTkY6OiPb17uBUIyFlxKch6oSJb1YDMxxn6U5HviJlDTcTWF8JFC0UW0E/BC5SKoVy49gZS2kaxifoWxxCY+J2pjeaW/l+7ds6kzsfWDBaAFIBe1n+Gk/5TVwP035avlD5Nn9MbXAY7SnJDpFiAq0wIoIP0MMcHLT4unYRlEaorHjufgggFaBgDYyo2v//GAIOO3f5MJdG6OFdp2OCd2UpfVw93Fh0JmnsgvYuXlgVppRQhV08mmxdc7ckNzcxiUApG+mAjqpDI3sCuX4HHQXl3krzA04EqGOkgfnF42HewihrHv7V7LM8tjHibxJGKFMXZ537/+iZxn4M7GAzuHhX0XhI9f/Jtfk36kvH+osV7spdKAsF7b7N1rxMm4HA/xaoO5b8cNO0t+gUQlOfHuiH7h7wnPN6JtE/RqqM9/H2wLXtNoUJGZff0dEXudHlSBJENGREpQrI/mWC6LvWOYLs5XUkZWYv0jWbP8MOWLkc6k2Tl4kgYJMjVzqlMm0ccP1ZtqJCGFqA==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 21:50:35.6533
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5158ad9-015c-4f68-b6e8-08dd1af7028d
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06B.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR19MB4728
X-BESS-ID: 1734040238-104790-13334-13635-1
X-BESS-VER: 2019.1_20241205.2350
X-BESS-Apparent-Source-IP: 104.47.55.170
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVkaGBhZAVgZQ0Mw4JdHCyNwoMS
	nJ3NQwOS3FIsXC0sA01cDQ3NDAJNVYqTYWAPoFlNVBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.261069 [from 
	cloudscan8-242.us-east-2a.ess.aws.cudaops.com]
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


