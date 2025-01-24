Return-Path: <linux-fsdevel+bounces-40046-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C462A1BADD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 17:47:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 356771886A04
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 16:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7DD19B5BE;
	Fri, 24 Jan 2025 16:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="hjHeKkzZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip191a.ess.barracuda.com (outbound-ip191a.ess.barracuda.com [209.222.82.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEAC11459E0
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jan 2025 16:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737737257; cv=fail; b=spyYZ0nY3T5Sov6DjA21KsgvDFiLDeyuuzt1doK5fZjVVMUwiI4+9wmxUOv/4HVL/R4sU0uJTr2xhNd0dVB1ArVJVCAyqWyMTVwdE9KdNgbfhZTmNGewnwPdKI7UqRRHvppkmmlGTR09e3fLhUwFp8J0r8YhIslFoZK17V7L76c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737737257; c=relaxed/simple;
	bh=TXMZt2stBIZhV5QMsvTgD1jJCgtZKXxeYmcD90vE+uw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lFDlksvCJ3hKkhPYnMgFihUhoSc1ckRRIzBfMOeVJQ6o66g53tSECZGkWKF9yVmnjR31ik4LIy98XlqqgunemlQlyT0UZpJ71gM56ThT26xfk5yHe/YENvYwqI3avcS+3AZQ7yxk/PMnIZsV3a9NCNY4hwiIkTNqOcUL3X12SxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=hjHeKkzZ; arc=fail smtp.client-ip=209.222.82.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173]) by mx-outbound12-186.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Fri, 24 Jan 2025 16:47:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oSIR5GNKBeM64spCTwp4MpY0sH5+loDJN+U5qfxCSzVyycuNgN1JjYDzFxQxHjDKIR3HqcLW8USwvei2XPs8oJ50PhtauaoHDEbegI75Yz+iN8mjBNlfECCF0E2F4aOPv943JJLYmvRfe3Ajakn4dWPKakm5QD8HzW/1brkLkaxcPywiGMArdopfr1GaKDHL6McUbVuECnTJEMg85eHvlOBY2ilOWkDgxs429KKPshWlv6RcbZ6aMxkSVYCYK2MiFCbogQxWV1SxXoTfoOxHnABtfdCNeEZ7y/jPZ1coRgjrNTDOrRCWIAmfH36Mpck4DVaP7hplacebFoDiYQfi8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4uoQ9ZZI7NMtPOY5SExtUUjVHiMg9a4I2CRP7tHtJv4=;
 b=LpvMeAGwCS0/2HOwcXUbRsFcs8xRmAJW3fztdhR9t0DUOmtB26E8NwjIwrl0Pw1lwBfb1vZIFptDXJam5gEed7eZWnTN/18kQBhjliPKTtsswZm4sEyE6CL1aBUz87BwVTtCCIwmbzdgqCyPh7hmdREGwFLrHE7lxjNoWtynldq7JXqsDrHUZ1IvG2aefBcNB2YyY7ubuhDJxx0fOru9PGxD2oY47KI6HWHEbJLUEBPiC9yinhw+zJ8cUvCPVmob/KUVaMf18u5+Cn6lm4tnhdpAbx0S0GK2laLk6ZHtpzv416vv0mODDPr2ezJOyMUSzK7WWCfpkpGt4MKcSqWxgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4uoQ9ZZI7NMtPOY5SExtUUjVHiMg9a4I2CRP7tHtJv4=;
 b=hjHeKkzZ7Hb6wjMX7ppmd2zUbAD7BrzaHnlbZkG/h9T2iFc1B/wgsJys6iPhdqV6MuHaHDSvBsLAJ4eStwT2bWHLkZaTCuLr2MU6zdNqIm1aDRTh6abqb+9lTQVODfzNL9OE/exGBqZTdNcn0l2ipzUtZ/xcMmjIq/zuiJZB52A=
Received: from DM6PR06CA0041.namprd06.prod.outlook.com (2603:10b6:5:54::18) by
 DS0PR19MB7960.namprd19.prod.outlook.com (2603:10b6:8:165::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8377.16; Fri, 24 Jan 2025 16:47:15 +0000
Received: from CY4PEPF0000E9CE.namprd03.prod.outlook.com
 (2603:10b6:5:54:cafe::7b) by DM6PR06CA0041.outlook.office365.com
 (2603:10b6:5:54::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.18 via Frontend Transport; Fri,
 24 Jan 2025 16:47:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 CY4PEPF0000E9CE.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.8
 via Frontend Transport; Fri, 24 Jan 2025 16:47:13 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id 0467E80;
	Fri, 24 Jan 2025 16:47:12 +0000 (UTC)
From: Bernd Schubert <bschubert@ddn.com>
Date: Fri, 24 Jan 2025 17:46:51 +0100
Subject: [PATCH 1/4] fuse: {io-uring} Use READ_ONCE in
 fuse_uring_send_in_task
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250124-optimize-fuse-uring-req-timeouts-v1-1-b834b5f32e85@ddn.com>
References: <20250124-optimize-fuse-uring-req-timeouts-v1-0-b834b5f32e85@ddn.com>
In-Reply-To: <20250124-optimize-fuse-uring-req-timeouts-v1-0-b834b5f32e85@ddn.com>
To: Miklos Szeredi <miklos@szeredi.hu>, 
 Pavel Begunkov <asml.silence@gmail.com>, Luis Henriques <luis@igalia.com>
Cc: linux-fsdevel@vger.kernel.org, Joanne Koong <joannelkoong@gmail.com>, 
 Bernd Schubert <bschubert@ddn.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737737231; l=1108;
 i=bschubert@ddn.com; s=20240529; h=from:subject:message-id;
 bh=TXMZt2stBIZhV5QMsvTgD1jJCgtZKXxeYmcD90vE+uw=;
 b=otFRD663HbwZK63yBHHiojxYXL4rCAKf2MBbT5OWuCas6uQEW8IOpqgRNeL6fYmT22mxHoalH
 VRqXZv2Y8ubD392HwuTy0H3sttoJMeM04+5ikoeXX8nLCMXgi2xj36f
X-Developer-Key: i=bschubert@ddn.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CE:EE_|DS0PR19MB7960:EE_
X-MS-Office365-Filtering-Correlation-Id: 724bcd9e-c7d2-4b0c-ec59-08dd3c96c105
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZDdZQUgwRTdvNk9FOXlaTkRoWEZubUN3Mmw2c1pzSkZZanhROWphT3Ard0o1?=
 =?utf-8?B?N0djbmgrR0lTZDgwamZDT1NPQmVXdU0vMVhrR2ZEaXdZL1puUkRKQ2owVitD?=
 =?utf-8?B?UXRhRi9hV0pjOUI3UTJXVTBuSXprY1RkTmRvcTBkeEZ2a1REVHo3WVFNdVR5?=
 =?utf-8?B?VzdnSUd6SEVXWkRrY1dJWitzQ2RvSThwU0tRRy82amIzM1dJWHovdGNXRlB4?=
 =?utf-8?B?RHdUTklNRXlVSDRxbG85VUgrbENVN0JoUmMvYUFraUZTcG5ScTlYSVlBN0U1?=
 =?utf-8?B?dVdISW9EaThNWHhjUDRacXFHdEQ1c2hrYU1VVDFCc252SGpsSmVQY0lMdUdH?=
 =?utf-8?B?TTRoT1RTQ3RiOW84SW5yYVBqS3d3L3dUaE1DVDFqRHVQUTFKSTJtQTdyRDZU?=
 =?utf-8?B?Z1lFU2YxSGhwMDJ4MUNwcmJ0WERBT0Q1RUVDR1hoQnhWYlViQUZaa2xEalMx?=
 =?utf-8?B?ZHA3V1dzMnJoV0QrZWVSTGJqbjc2eDNFajVmL3piTlZabGVjek1qclZQNkRa?=
 =?utf-8?B?cm9xU2pXcVhRbmNSUE1SYXZVUnZlWG9QcGZCYWdCK2RMZmR5dEpld0V4V2Zh?=
 =?utf-8?B?M2dnWVRsOTRLQ0lOYXA3NzJJYnF3THk0bS9ncCtzd3prSjRlWlhOWWJYbDQw?=
 =?utf-8?B?K1U1aFFTTGtwZVlJbU0zSzlCcGlJMHdzNXhleHNyVWY0MFZCbld1bis2bWNO?=
 =?utf-8?B?UjVVczBlMUJpSWkzbGNHbnR4Y2xLSnhFTU9yNHJwaTZDTjZVZDZFTGluRVpG?=
 =?utf-8?B?RE1JTHZhVmt5ZEJVOFNTd1ZlV3hwMjJnWjY1L0pkUmJzcWRjNUg5WjhzeXdS?=
 =?utf-8?B?eWt3Q082RDUxUTRuWFFUaEZsa2tHYzlhS2R1d0RiRVdWN3FWZjZsMXBReUZH?=
 =?utf-8?B?cDNlelhtM1VmMHVuZTNnbTZnYVFiR2VMVmFZL2hsYmVPZWJ5ZXREeW9RUWNW?=
 =?utf-8?B?QTdXcEVTaDFaSjJiS2ZvM2JyWDF4VXVJOE5VdmhGQ3I2V3hDL0c0aldIWTFR?=
 =?utf-8?B?UngxTVFIaUt4NENISStaTzd3QmhvbFBtLzR6U2JWazl1cU9qc1RsUTFaM2sx?=
 =?utf-8?B?cTNwb1kraDRGc3ZjOVdDZnhLdWUzOTNSRFBwdFIvekF3WVVVcEM3NnI0Yk9B?=
 =?utf-8?B?TVJZelZ4dnNrdXJPcFcxWU9lR2ovVXdyWFZXcGxkVmtFQzVWZDFHUVU5a0dH?=
 =?utf-8?B?STJheFlqVDY4d3RYSW5MS0lzM2pXM1lSQVh0QTRBYnpqTmNuZTZqcncyc25R?=
 =?utf-8?B?MkZVWE5ETS9DMjdMU0dhVXdSZjFOMk0yc0d6MXVTdk4valdGNElpajdseFEr?=
 =?utf-8?B?ektubVJ4STQwbjlrb1RuL2hWNWpLa1UxWGZjem1zbmpjSTAwUGJDZVV0czhv?=
 =?utf-8?B?M2dJYTJZaEQvNzVLVXJyZUZ5aHYrYVUxOEt4aU1EelhJRk1yQjMrdy9yZmE3?=
 =?utf-8?B?Q1laTyt6T0wrRm9SVlBsbGxzRERUZHpXTE1Rd0dhT1Brbm1TVjMxbUU5WS9L?=
 =?utf-8?B?NEhIWi9WZUZja2thWDgvOUtieXBNSmFtQ2ZYSE1Ud3FJdDNUWExuUkhrdEZk?=
 =?utf-8?B?V2NXU1h5T3dzdm9FanAwSnZhTWRlTmJ4YXhlUjNSYzRCRkRuYXlNRWFHSHY0?=
 =?utf-8?B?V0ZpZ05mOFlRS1BvdEtFRXQrU0pSNmhKS0cxRU1tczN1ZHlpOFlLak9nNGRx?=
 =?utf-8?B?MnB2M2E5Z2RYM2dWSjhBdnhZOXBSSmIzTk11MG9UblhZNjAvQjZTbWVGcmlR?=
 =?utf-8?B?M3hwTVk0WU9JT25IYjBVREVzQmF5c0oyc3Jjc3JVajlOTlZFVGdwV3NDbWp0?=
 =?utf-8?B?azlzSzNBaCs5M2ZITkJkamwxUUVZRnF3V3VzS29DUlJTQm1nekNVSkxkNmlP?=
 =?utf-8?B?WlNyQlQzUzl2MGI3RWNFeEVqTGRUL0dWVFQzbW1xV1JYZDZ1Q2kxWVJYTXJN?=
 =?utf-8?B?QVc2Y0pyRXVwditzY2JuYTFUMlV4OUl6R2VreENiSEp0eXUwZkU0aXcyK2R4?=
 =?utf-8?Q?PzShDWbPPY7vmFkVyOlL5rzui4WxVs=3D?=
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Aa4Knfn0AS1ERhgS38w/rgC47L4tVTBsmUcB6iKbZsDtoalWZhQW91DrygM7/zmK7wv8ZuYNS8eUai4kSrUdtSMMCuQETWv0q8MwLacP4bZRCNEutT9/ETlVoPoEl7/vBoQxe0/G+mVaeWXNNHiokRR9l90adE4ApfIMIwmIvFvIEerE9i4NdjK4EHWZiNrySWh6SeqdvQPY1eEMJpNR7jEtJ9ujcNqxhtUXbwUSugHzRHNj01glf5+9QZNY050DTnvp2vM8E2cX3PYBTvKBa01KEJhiDWBY8hJuM0DM2UETDh/6peB158JjPOPwfJg1CAoat2eZDOLINq7OYqP5A9KFwAs23LXDH0/ZP6vEQr5wDrGN7LMeKOQDci7bo0NJffWTmGchAvhEmm+kXw0ZwGRoCoPbQUfsvfytR/n267Vzro8W5Lvk0RyMZOzmYfgtjUZYBQoxmCtCQja1vYqV5L7O2WX94QhYXHhqZ+EvlP79qjs3L5ksTJ7sL4yYCXq9o5SXVJHMfxlS4Nd5AiN9SltbQk3hjZWFr+cw0ghKEs38JSpShbEP+P1yaumPln4Z98whl+c13XkEKJgJ68fPNDSZs7p/jBQcAt6L3/HaRwRj9BJ5ny6yFQbThqHQ+zxDbOyTUM2sZxOrtMT3Mqsi+Q==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2025 16:47:13.7005
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 724bcd9e-c7d2-4b0c-ec59-08dd3c96c105
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR19MB7960
X-BESS-ID: 1737737236-103258-13472-20903-1
X-BESS-VER: 2019.1_20250123.1616
X-BESS-Apparent-Source-IP: 104.47.58.173
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoYG5hZAVgZQ0CQ5zdjEODUlxc
	LQPNXMONXA1MggCShoapGcaGxkZKJUGwsA9guvE0EAAAA=
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.262028 [from 
	cloudscan19-21.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

The value is read from another task without, while the task that
had set the value was holding queue->lock. Better use READ_ONCE
to ensure the compiler cannot optimize the read.

Fixes: 284985711dc5 ("fuse: Allow to queue fg requests through io-uring")
Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
 fs/fuse/dev_uring.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index 5c9b5a5fb7f7539149840378e224eb640cf8ef08..1834c1933d2bbab0342257fde4b030f06506c55d 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -1202,10 +1202,12 @@ static void fuse_uring_send_in_task(struct io_uring_cmd *cmd,
 {
 	struct fuse_ring_ent *ent = uring_cmd_to_ring_ent(cmd);
 	struct fuse_ring_queue *queue = ent->queue;
+	struct fuse_req *req;
 	int err;
 
 	if (!(issue_flags & IO_URING_F_TASK_DEAD)) {
-		err = fuse_uring_prepare_send(ent);
+		req = READ_ONCE(ent->fuse_req);
+		err = fuse_uring_prepare_send(ent, req);
 		if (err) {
 			fuse_uring_next_fuse_req(ent, queue, issue_flags);
 			return;

-- 
2.43.0


