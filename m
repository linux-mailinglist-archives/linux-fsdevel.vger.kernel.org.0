Return-Path: <linux-fsdevel+bounces-37237-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D669EFED1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 22:51:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9C87287BB4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 21:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B3EC1DDC37;
	Thu, 12 Dec 2024 21:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="Uct1vzqw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip168a.ess.barracuda.com (outbound-ip168a.ess.barracuda.com [209.222.82.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03391D8E06
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Dec 2024 21:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734040250; cv=fail; b=BxFgvwpfoTXCUoOSWHFt4eH0B4md6miDaxCBqvrlCTfbYK+BgX93+FB52L4TKLX+v0ZcG2VxQRODXnfUjxduNUc/54zpeUcbrE0WmGEnaQ+pP/yIxMD+KPbDYcsg6TPBWgCSB13RQ3+CzhU58jZKUIL5xIAKIv76plC1R7xX8eY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734040250; c=relaxed/simple;
	bh=R4RQU4urJ3/dseKJ952zf5zqJ1RRSeM4npAkPi7Pswc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UOl0ZbRkJZTWR4HNd+sXoJEOjD9/rHZB4U3qmx8AM7Su7/oyn8rPmw7KLLWz8dW6qgK89YnJacFrspuwT3Xa/+fpc9zlFLqpzpjthDJ2QZ7qCXtx1BnXU6n1vwUEmDkm9L4LGCurbgBgqx7k/S4BGw742CC+EQwC7XLzVjYTiqM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=Uct1vzqw; arc=fail smtp.client-ip=209.222.82.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175]) by mx-outbound47-50.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Thu, 12 Dec 2024 21:50:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hb0eQDb1lTYz6S8D3BvZczzqe1RLB3p5rP69Ul5zMLkSoQhfckm6RmJhpZmXxA14XKtUL+gOmdszwVpr8A71bXNnviVs+RC79i2oZrJmSs2s6xpuSc1Zz6F02ejYG0f8TOJ4b+Ta44fm9cnDIs1bnpuMA1gdBAWu3zzk4tOpUP19U7vZCmd7278bh9mGObbNkm1du6Y42L2shiCAYYgNc1Q/bB3HPg7h6Wc1nUSfAFDlL+LhlZ3Bk1A1YsIIzbN9p9hgWEEjAKMUbpKmQ5852l+WOoREY/dZdhfw4lJo8cJT9JedIIu+gnYgfDhSDI4YL+Vx26N2goZpsuSdTp0Ytw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=potzp3EIcXcMarb3G7UFG23mJvw1oRBKl6Zbd7WB148=;
 b=nPcFroQrLch2ZJjzfQJpAELleHlRE0v5S8l+HzcOxdb3jHtEfbwJh/YSPURVgmprhusDLUI+CYoX2tgM4NSZcamgi1LekDmdXX5RQJdxrE3EnlfHSZ9xwxCdG6zVwFFx/0W+wtLF7jCFcyY5HNt/UQPOZ7LKGOZ4Ojs6OlyWYXVyrI9X3HNIT0KUSlqE/776pT5qoQ2K75imdkUaYqjr8XUbJ3xPbPMiy1m4b4+oFQnhPvcKe9h+6qcJpK3qPcm5pgEDQk3FTMEq5aNrIpmj2Z7WhxtMVwO8vNrqHdLXvsYOqlqnqSX9Ug+9M8Mw2GqpX6d1vk8E+M+rORhf2o+tkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=potzp3EIcXcMarb3G7UFG23mJvw1oRBKl6Zbd7WB148=;
 b=Uct1vzqweZ/STHUaYgi+4gBj8zphoTFNKh9MgfWiITCbVm+lRUiJYBGOwv0lzCsWUPNRA5axvoj4chV60t+LNlFZhoLeEoCqC144jOQzH/8PVXGsWPYZfE4cTx7/0fT8J5wK75XI4vUOL/NTFAY/+PKS7PY4Z7L0S8US0CQa14s=
Received: from BL1PR13CA0014.namprd13.prod.outlook.com (2603:10b6:208:256::19)
 by PH8PR19MB7760.namprd19.prod.outlook.com (2603:10b6:510:25c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Thu, 12 Dec
 2024 21:50:37 +0000
Received: from BN1PEPF00004689.namprd05.prod.outlook.com
 (2603:10b6:208:256:cafe::56) by BL1PR13CA0014.outlook.office365.com
 (2603:10b6:208:256::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.13 via Frontend Transport; Thu,
 12 Dec 2024 21:50:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 BN1PEPF00004689.mail.protection.outlook.com (10.167.243.134) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15
 via Frontend Transport; Thu, 12 Dec 2024 21:50:36 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id BC8ED4A;
	Thu, 12 Dec 2024 21:50:35 +0000 (UTC)
From: Bernd Schubert <bschubert@ddn.com>
Date: Thu, 12 Dec 2024 22:50:34 +0100
Subject: [PATCH 2/2] fuse: Increase FUSE_NAME_MAX to PATH_MAX
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241212-fuse_name_max-limit-6-13-v1-2-92be52f01eca@ddn.com>
References: <20241212-fuse_name_max-limit-6-13-v1-0-92be52f01eca@ddn.com>
In-Reply-To: <20241212-fuse_name_max-limit-6-13-v1-0-92be52f01eca@ddn.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, Bernd Schubert <bschubert@ddn.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734040233; l=1088;
 i=bschubert@ddn.com; s=20240529; h=from:subject:message-id;
 bh=R4RQU4urJ3/dseKJ952zf5zqJ1RRSeM4npAkPi7Pswc=;
 b=FYYA+mKNX38q0FgOtUFhEZjciWvVoemO63CohihG42u7+I3niUzQ0ttrFk3K7yIPNJSbhoE1W
 NmXx/JsFQVPD4Xv8TUaoiBX3Atcpy+o9p6uDiuBAY6ISYAKQW+1Axx/
X-Developer-Key: i=bschubert@ddn.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004689:EE_|PH8PR19MB7760:EE_
X-MS-Office365-Filtering-Correlation-Id: 16039be8-9539-4737-27b0-08dd1af70315
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NXV4VGlvdjJjUHp6ZVZ6QzRCcnd6SkNzT3RGU1BYY1BnRU12UGZoZWxTdk0v?=
 =?utf-8?B?eTNzTEdwOTBzZ08yRGhtZTNzVUs1MGRzMFpTb1F0dGJEWFVSZHd5N0ZBbWI4?=
 =?utf-8?B?aUZ1SUlwcGhRWUEram4xcnhzMGZIRC9OeXJ6MTdncHZqRWxzYjFSOHgxd0c4?=
 =?utf-8?B?YlY5V1VVSTN4OXBVbEdIRzVGRTFqY3VCNHNTNko2MzBxQ0tJdmNuSXVsVkV1?=
 =?utf-8?B?VCtDZm0yRjU5Vm9mYk5sRFRXWUFQYnlIRUV1YW9DQXQ3dDNIdFVTVXR4enJ6?=
 =?utf-8?B?Slg2ZW9hbXlEYXpWUFFkdFJtRmJoSlhDM1VGYnFXcE8zTmZ0bnZ6MUdaUzQ0?=
 =?utf-8?B?YWl4ZFBrcEpqSlRVVkRkRjJNQ2JoUDNTTTYrTGFkVFc3OUFaMkNvQTR6Ujkw?=
 =?utf-8?B?V3FYV0R1V1gvbE1zTS85Q0d6bkRmQWUwT09oQ0N6VkJKajN6RW40bzZnRG42?=
 =?utf-8?B?V3RqTXZOQWhscjZCLzQ4Y3Mzeit0N0hXaHRoSVp3L3l5b0lIYzhLdStVNVBQ?=
 =?utf-8?B?U1pTR21PRjVIUVZJMmJ2YUEzczdEemxBelBuQ1loOFZ1RFJsVXhnODduV296?=
 =?utf-8?B?STVzOTJIV2hHeWwvdzBtUURjREhGb1EzdC84NmVSU3NxZFRhYWdIQit1TEl3?=
 =?utf-8?B?UGZlbzdVZG1zVU15UmxNOGVXaWZxdHhXaTFvdWhuRURVQ24ycGxCRXNXSjBG?=
 =?utf-8?B?Vi8vNGRHZVF5UVo2Qm1uakN0cDUvR3Q0MkdTTXVlR1RVS3JFMzVsS1E2cVB4?=
 =?utf-8?B?S096SXVWWEdjZjBjUCtiaHJHd1paSndQbFNjR0t1YWtabVRuaWdDUjFWMytw?=
 =?utf-8?B?SW9KUkFoMkZXWW40Wk5sdUdUbzRZd0thY0RJSmhqSXNjWFprbk1pd1VSZVVN?=
 =?utf-8?B?UHo3QWtOd1dVNUlwK0g4VWgyL0pBcVQ1b1RvRnVvNFR1NG1RRnV3THp4K0Qy?=
 =?utf-8?B?Nnl1ekY3QmpuaUtoVU9hcFAvK1lERStSR1VzZ2RCMlpnbnYxbjRpUHEwbFQr?=
 =?utf-8?B?MGsxNDBWTGtPRlBCMmNRNHF1b2dMZkhzWTlLeXFsbjJVN2FWK0c3NG9UN0pT?=
 =?utf-8?B?ZmVEd0FVM0tmVlFHVTBGbncwWEdObjAzNmVCTTY5eGY5eGVuUS9TejUwOVdv?=
 =?utf-8?B?NjIvQnlaRGVRV2ppSTUyVWo4S0ZDcnpycDBiZG5vOFluVXNFREpiVzM1S2F0?=
 =?utf-8?B?c2VHa21aNjFubEczM0pOUGpkWXhQMFhDYmRBc1ExWjJyQXA4dFNPcjNFd3V6?=
 =?utf-8?B?WmphQzlYcEtEQVBwdGNpUmVjVERTSFBVK2E0VWExbTk2UVFPYUVaUi9aZFhU?=
 =?utf-8?B?V1ovdWlWSVgvRDNGN3gwWjQrQWVMcHRLRTI1d0FPKzBMVVJJL2xldCtIQzR5?=
 =?utf-8?B?aHplc0lMZmtLQ1lBbUEwdUNPYXkvd29VcXIwdTl3SUV4WXhEeHVzK3RtbHNq?=
 =?utf-8?B?NzllbnlCd2hhcnZqUmw1My9QV2doUFd3d3BSS1VwY1BoM1ZxdG91cENXL29u?=
 =?utf-8?B?dU95Vjd0dzlIcFVhQ2U3K2dsMTh5eGRtN1JTUW02N001TEc2V2ZQcFErdUlZ?=
 =?utf-8?B?YjlxQWhpNmFzTm1yeGh2T2FsNFAwZFpmWWU3NU1hTXlRMW85czBVKzNBUTV5?=
 =?utf-8?B?eS9sNHZyTFpHL3FNQWM1ZU9zcXBXci9hUkh4MnZxM2VBZmFoaXNTSWY0c0Vq?=
 =?utf-8?B?dDJjQjRNSFQ3SC9FcU1uSFRmSU9XbFpDN2hsSSt4YW9ILzJwZmJoMG9nOU4w?=
 =?utf-8?B?NllDbWhuRm1VUjIrbTUzLy9CVEJHc0lEUFhrVmRNbU4zQjlmZHBUcEJ2MndF?=
 =?utf-8?B?cDM5YlVPNngram41ekRpQ2pneHltMGZHcWtxZmIzYnU0TStOTkV5OFJvcXRw?=
 =?utf-8?B?YlVXMEo0cTB0R0wyeXY4aVY3WGZnNUZUck9HNS9xU3dtTi82MitqTkk2dUZk?=
 =?utf-8?Q?XJuRROW5q52BtVLd+XvI3eRtsrCUGWAf?=
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	MWWSJWQhCpB0QC7EFR5+iJUhnwRoScehsyvKVSjcdq/nYWxGUJZb5cUvhiiQzqX02u6T/ymcFlspSybof+nglivTJecx30ng/dPMShoXK00ZBOv0I8umU8BmDJAPO2qrqqoszFtwwu263isG1oxbrnnUuo23D/6HMn+ftn6egoMvw3s9gxv+O1e3Yt+yJRKCeHqdQ8DYlAOVzGN0MrjUmUxbx8EIAp9Oo1TcSFPLqfSmNPO9U0Bany5nvTowa+chPl6j4Hyc9TA5/j/enSJSekEOY6K9zwr8WYQ4rgefWydGXw7Pi17pvvn3Cp0PfyMu4M14G4C4R+Uj/hN0uCxpwLvKfrXiBkZTJ77O4KJkODcVYXlMhR1j1j+rXDHHmuJBr28gpcFfS9nEdKPxnNN+ZqFg97gLfULlNPxzacAGwySCdG9UHPSVruOT5zlX7ryTLAhifSn2QHdf/VL55k1SuWudbyf2TsdvBIih5t9BXkKvkF10l+oJPZKu3AlFq/oHll4RJZ0Dk2X2+ha5QpyqibiyY6MkDKyhxl3Icj8lkJ2jAII+l6Ctw213pjp4xQn9SLAdHRCSx8kFwWftwML83QaD6iaG66rblKE1GmBGOAGC5u9EVFOPx7U0ArRD4CKDjS05v6mGCTtjP9QJVb2bpA==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 21:50:36.6190
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16039be8-9539-4737-27b0-08dd1af70315
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004689.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR19MB7760
X-BESS-ID: 1734040241-112082-20061-47397-1
X-BESS-VER: 2019.1_20241205.2350
X-BESS-Apparent-Source-IP: 104.47.57.175
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoYGphZAVgZQMDnZyMQs2SDFzC
	zNxNwkOTnN1NIixdjM2NDE3NTQMDFJqTYWAEUWxNFBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.261069 [from 
	cloudscan20-173.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

Our file system has a translation capability for S3-to-posix.
The current value of 1kiB is enough to cover S3 keys, but
does not allow encoding of escape characters. The limit is
increased by factor 3 to allow worst case encoding with %xx.

Testing large file names was hard with libfuse/example file systems,
so I created a new memfs that does not have a 255 file name length
limitation.
https://github.com/libfuse/libfuse/pull/1077

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
 fs/fuse/fuse_i.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 74744c6f286003251564d1235f4d2ca8654d661b..91b4cdd60fd4fe4ca5c3b8f2c9e5999c69d40690 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -39,7 +39,7 @@
 #define FUSE_NOWRITE INT_MIN
 
 /** It could be as large as PATH_MAX, but would that have any uses? */
-#define FUSE_NAME_MAX 1024
+#define FUSE_NAME_MAX (3 * 1024)
 
 /** Number of dentries for each connection in the control filesystem */
 #define FUSE_CTL_NUM_DENTRIES 5

-- 
2.43.0


