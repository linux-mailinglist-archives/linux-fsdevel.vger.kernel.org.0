Return-Path: <linux-fsdevel+bounces-55757-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC38B0E5EA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 00:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0056617484F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 21:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4334F28C5B0;
	Tue, 22 Jul 2025 21:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="lZEheYGP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip191b.ess.barracuda.com (outbound-ip191b.ess.barracuda.com [209.222.82.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3955286D7C
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Jul 2025 21:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753221501; cv=fail; b=DTzy0fi/wVARoai1URfYeGXzoPNpHo47EWDwJ4TbpbGJsCqhRwq8PVyNtWoEpnMoHKMwU+uTlD2+Z7aXm3GAliQ8C7sc1IrPYLyWdLQyfBb07DBUYGTxkubKJli2NJ/zhNjOtFAqKDC3sakuhjXycxz1q1Oo4ImqsOmN1dokL2w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753221501; c=relaxed/simple;
	bh=rcDueinILoYtR//pl4jt4GZRPTAvmfUFe+377E08hGw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UIRjp6liTI4d/cOfixxMjj+4QuMLmv/XH/dW15GAj0fHGN0gLhGYuVcEUrLLQU9y92tetMtLtcIHNbnrpYamWzSRAMQ1FkP36p491FDO6RPOXIeytNyQBWPGW1gVxG4nSMmqh6QPyIKIrDNepzmA1T6IJ+j8/n5cumBRmzbTBkw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=lZEheYGP; arc=fail smtp.client-ip=209.222.82.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2137.outbound.protection.outlook.com [40.107.92.137]) by mx-outbound18-36.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Tue, 22 Jul 2025 21:58:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WE0+G5xTS6+rW63d9tjxdNeAnl0dTuSTkWip1y0sPq7r4+ezLFCv1bAmdzKL5mC1Dy24cWIRO7L0XzJtiYwBtDia/5R7puVEDZpNoynFUIEmuVmxs8itp/gBp/s6ppZZuK3ZscPOS6aVdufW/WaFfVTtSD9VWOM4p18A0mBappiVitBUqEjGgZnjzb8YaUZRweCDxhgv2+SbwtYw3ZYlolI3+xZTCBCRpVeWgV//95+ay6gOYsAkt7XCfNqrKXoS7FeRmYLnyDUUNliG6xl6LezUnZ+fJd0lEysh9/gLT49MlZ9ODXcn+mRMFI9UEOwoxTOhZml+bedtM5C8tZ4WOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/uFxtjaGfmt8YYdylsnSpPlaFB5LVxo0CpPegCM5fxQ=;
 b=g7ZVB3zeRAahXAvLeVDmXA6IRurpe5Lyi2MHZX5JS0TEysX2Lip/vXPWN3BI+1D7+P8naV8t2etXqiQPDxTcq8BE649BrAoskWNpTKG6BotE384WC3t6TXSflYaZAWGQYozqXEBzhKnSKQR3OErcgus/80/3dLcVPQly0uVCWEeUFPM2X35dfm/68Tx0trHbcKWHEuJo23y3l9eOZdY3E0sr1+soIw89dwLJ2t8FjSwvsoFJH18u76kcDYcD4BPiyPmOvIIDSztheeT35E232HNVJKaEeD24gv8cpWtdCFS2mcc3KDngYqxkpnW4gqU+wUzoKMTrA1lj0MOR+dLGQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/uFxtjaGfmt8YYdylsnSpPlaFB5LVxo0CpPegCM5fxQ=;
 b=lZEheYGPPTyKcDUnEdhnfTj4AE1LNnPwyyXigcFuArS6zgZGOe/N92V6Jmj32x7KElG3pCqc2lVli0C7CU3ja2xRf2lDYt5KfNHR9tb1lrZWzgdFK8Ytlt9plxVhgl6F/+yVtTkKaKYFl2c7JoU1403WaQsg2nhsnCkZuljv7mc=
Received: from PH7P220CA0178.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:33b::17)
 by IA0PPF0A4D809AB.namprd19.prod.outlook.com (2603:10b6:20f:fc04::c88) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.22; Tue, 22 Jul
 2025 21:58:01 +0000
Received: from SN1PEPF000252A3.namprd05.prod.outlook.com
 (2603:10b6:510:33b:cafe::53) by PH7P220CA0178.outlook.office365.com
 (2603:10b6:510:33b::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.29 via Frontend Transport; Tue,
 22 Jul 2025 21:58:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 SN1PEPF000252A3.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.20
 via Frontend Transport; Tue, 22 Jul 2025 21:58:00 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id F0D35B2;
	Tue, 22 Jul 2025 21:57:59 +0000 (UTC)
From: Bernd Schubert <bschubert@ddn.com>
Date: Tue, 22 Jul 2025 23:57:58 +0200
Subject: [PATCH 1/5] fuse: {io-uring} Add queue length counters
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250722-reduced-nr-ring-queues_3-v1-1-aa8e37ae97e6@ddn.com>
References: <20250722-reduced-nr-ring-queues_3-v1-0-aa8e37ae97e6@ddn.com>
In-Reply-To: <20250722-reduced-nr-ring-queues_3-v1-0-aa8e37ae97e6@ddn.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Joanne Koong <joannelkoong@gmail.com>, linux-fsdevel@vger.kernel.org, 
 Bernd Schubert <bschubert@ddn.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753221478; l=3054;
 i=bschubert@ddn.com; s=20240529; h=from:subject:message-id;
 bh=rcDueinILoYtR//pl4jt4GZRPTAvmfUFe+377E08hGw=;
 b=5TtQmKzPvco7Y2ZXZOxCz3TUAPSl4hMpJ74Zcb5VDJnm9B2HASzyebIy1XPtPKr53gNwJaiCw
 Pz6LC5EZClEBVjcA4pXTaa4covtqZX1UsgAXqDj8/mD1dXAGCY8svMY
X-Developer-Key: i=bschubert@ddn.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A3:EE_|IA0PPF0A4D809AB:EE_
X-MS-Office365-Filtering-Correlation-Id: da50ffdc-1ea9-401a-6d10-08ddc96ad36e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cVF1UkJ5NHVSTVBiR2ZhOUx2enJVZVdNUXdUYlhGU0xhU2ZDbXMyb2Vyb2hs?=
 =?utf-8?B?ZWhVWnF5ZXJtU0gxWUtJUFp1aTZLL0x1bE96Z0xjTm1vb3lwbEJFTDE5dXh6?=
 =?utf-8?B?bGxobmhWU2NEb1A1aU1lM3dZVk5aSzZYeVFneWlpSnJ4elV3b01qaFNRanlV?=
 =?utf-8?B?MEp6eGVCOE1saWsyRFJlam5QZ3JScVhzL1g3c0V3Y3B2TGJrbGdtdGN1YzJ4?=
 =?utf-8?B?czdjMklaaWFZRzdEMHYwN0pmZngwd3hEWGZScHMwSXlvZTEwOWRkWkRodGJK?=
 =?utf-8?B?a1ErYm9udFRmOGcwUGJXUjhXZmp1Um5lMnRmN2JnZERvcmlsNzBBb3lGNlBu?=
 =?utf-8?B?MTlvVnBIUFR0UUZTak15Qkp1UUY4RjVwdzF6SkQxcmM2WUtva1h0WDdWNWYy?=
 =?utf-8?B?OHpxbkhBVEJ2cTJVMTFhelFvc1ZabjFHRmhUK21yTG5RbzlzcHdTS1N6TVor?=
 =?utf-8?B?ZnJOREdPZDlwR3QyelpLbnBkaXpUQjl6cG14N05wS1c4bk50SW1FM3doQ3lF?=
 =?utf-8?B?cDVYVUN4OGNsWkNLZzI1NnpZMzNhMDVHc0J3VWhqTkpmZzdhNEZaYkxsV0ZY?=
 =?utf-8?B?WStIb3E3b3pPbG1MY3p3VnV0alVDZE9DTURLcjUvbjhpNFVnUG1hcXB0dklo?=
 =?utf-8?B?N1dKSWhFRVdVeUZmcG8wVHlrV2cxN0dZcGdMT1RGNmpjT3FIMHNRNFR6ai9Y?=
 =?utf-8?B?VlkyUS9pV3ZqaHg3bVhmMXY0VmZwaXdtcUZPOHJrQjljcFU4L3pYc3N6TFlZ?=
 =?utf-8?B?cFJLb1J4Y2EvRWVYaVdMR0lxWFFFR1cxT0tUS2t5N2dUOFVacnlSNFBvS2xJ?=
 =?utf-8?B?WldQUWozM3dPc0c3RWRWNmdJSkRWMFhNUGNDZEF5VWx0WVAxRjRIakhEQlhK?=
 =?utf-8?B?bFcxZ21jUW5pWS9Yd3hRY0FlbStCbmhVQjU2QnhrNHA4RUtjRWVSSEowbEtH?=
 =?utf-8?B?L3hjYktDeWlWcEd5OTlPYWJIWnhodmpnTEJ5U01OVFBkTnQranV4U2gzMUNW?=
 =?utf-8?B?Qk5PakxoUXQvdlZRRWI1K2luL1JTUDZqTE1MU09GVXVNSXVCNU1TLy9JSUw0?=
 =?utf-8?B?WGdkRFlINTBWWDBLbnNuQnYrS3dtZ1ZwcWp5ZFlqbHVvQzlXRlJ4TFV3ZFFU?=
 =?utf-8?B?dlp5R1dNN3BPSHlRaWJKeTFVOVdTWDNDN3I1Mlp0N1BnYXdtR1VhSC9oUGMv?=
 =?utf-8?B?c1paNnlmTkN0dlJ1MkxBUkxRblBEK2NpTkZzWUd1MWJIRFNjMWRuWSs2QmVi?=
 =?utf-8?B?UGV5bnNOKzBGS1hCaHBuYmVtSlQ5VTFHQk51USswNUNHZ2ZmZ2JyM3RkdHFT?=
 =?utf-8?B?NEtJaCtsem5BZ0JaTzFCZWtRTFVIZEJkMThGVkEzZ3ZaM0UrL0VXbTdmTlRJ?=
 =?utf-8?B?cVYwRzRWUUh0U3dobk12UmdjWFdjWWdWL1l2U3E0cHF4TlhDaGY4ZjJlRnNH?=
 =?utf-8?B?ZlkyR2RKTittOWNENG0wQjVxb0VIN2c3ZEJVbHhWczFnQ0luQkoxQnl2RU0w?=
 =?utf-8?B?TU15UE1ibm02UjIyOWNwSTVqSmRHVTgxNXJLQjVWRWl2Z3BkZVNIZllCbDJJ?=
 =?utf-8?B?NmxLT2lwa1NCRHphTHlqZEFiZllKVTM3WEdnbVBaL0dmakVRdjhJaGl0bnRy?=
 =?utf-8?B?MzJ1ODhGSUxRWnhRRjFHY3Rlb1JYVHk1UFloVmpveFU0Z2tINWhCcnAwYUQ3?=
 =?utf-8?B?UmRlSnV2czFoaWZqczJtTXh3L25uRzJZb2xaVWY3c2FLZXBXQlkvN0pEeWJn?=
 =?utf-8?B?VVJ4ZWpWVmVFUDYxUXRVKzZ3djMwU0xjOXd0aHdMUkY4UGY2VVRJcHZ3bzlE?=
 =?utf-8?B?MnJEMzA5NjB5NTVtMkVQVjEwOHd1VnRGb1NMK1BSd1dRL0prZTRXZm9pTWNJ?=
 =?utf-8?B?NVpwUjAyZFlCcGNlSkpRd01JUGxWYUhkbVNmUkRHbEt2N3dPRU1aY0VMSEln?=
 =?utf-8?B?Rmg1K01BRnhCbGpoaFJtQTNZQzFzZGhCUXVpRGNDUlJZendWQll3eVUvcDBI?=
 =?utf-8?B?ZzJRcUV4bDUrd3JmbWRFdDYyemFxdVFHbDU5THFqN3VVS054VUFKTllNWHRi?=
 =?utf-8?Q?w/jkBj?=
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(19092799006)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xFhrAVJz9bLuPL19KmSJwYQseBODfDeSrbWGfkiJI10ZF7FHGSJThQrO/pOAzd1UqLS4JZ4V3XsmBO2u1uku+gTxb4iTwlRxa8cJCXP6hiOUpBhtp+oi98864PGMIoR1SjU/wic6UNNgOPG6Sgly9brfyivqHU29TeVU3OFxRmhSAUoXj0zSTlzNTjZlUiq8zkundFzmWAgeDjq7/tN3vcl0EGZKHo1j+6iq1ZhHjjhfHd779QLrEQaj8wI2W1EUi7W6hQM3HqQ1oQb+4q/s1CmQMwhcallaV7y/c3aK6k+GYxadnUokzbmoeKm1KL61Grq72uT19SyVK3PDC6VBs+pYLKxiNoVDagu/Q0k3BTiAImlN9Vg63Btg8RZ449Go2nCFwn8zh3dXFlx7UJnlViiVjSyyDX/lhYrDDNko/eomei/WXYZieaa9/RFmldWgNlwSjYe2+GxF1bEk+gCpSQVeokOK7Pp8UVWyJQDQPT1MmEYeY0v7uQ+vD2uCx/7pEi3my/YQWkQqDw6EcOFqcvFlNuEruTipr+c2Ex8LPdlQQkEL7i2sIBSYpQGD/0/btw//+mhUz0H9RJ/6dNlwCRxKvnxAo5Qb2LgSXhAYpLO+Kf99ms5pn6/1Ig059sRQJ3sv44ikedBNudgC2vjbNQ==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 21:58:00.6245
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da50ffdc-1ea9-401a-6d10-08ddc96ad36e
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF0A4D809AB
X-BESS-ID: 1753221490-104644-7904-2581-1
X-BESS-VER: 2019.1_20250709.1638
X-BESS-Apparent-Source-IP: 40.107.92.137
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVkaWZiZAVgZQ0DIpxSw5MdXQIN
	kkyTjFLNHM2NgwOTUpJdkEyE4xSVaqjQUAHAy6z0EAAAA=
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.266236 [from 
	cloudscan8-171.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

This is another preparation and will be used for decision
which queue to add a request to.
---
 fs/fuse/dev_uring.c   | 17 +++++++++++++++--
 fs/fuse/dev_uring_i.h |  3 +++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index 249b210becb1cc2b40ae7b2fdf3a57dc57eaac42..2f2f7ff5e95a63a4df76f484d30cce1077b29123 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -85,13 +85,13 @@ static void fuse_uring_req_end(struct fuse_ring_ent *ent, struct fuse_req *req,
 	lockdep_assert_not_held(&queue->lock);
 	spin_lock(&queue->lock);
 	ent->fuse_req = NULL;
+	queue->nr_reqs--;
 	if (test_bit(FR_BACKGROUND, &req->flags)) {
 		queue->active_background--;
 		spin_lock(&fc->bg_lock);
 		fuse_uring_flush_bg(queue);
 		spin_unlock(&fc->bg_lock);
 	}
-
 	spin_unlock(&queue->lock);
 
 	if (error)
@@ -111,6 +111,7 @@ static void fuse_uring_abort_end_queue_requests(struct fuse_ring_queue *queue)
 	list_for_each_entry(req, &queue->fuse_req_queue, list)
 		clear_bit(FR_PENDING, &req->flags);
 	list_splice_init(&queue->fuse_req_queue, &req_list);
+	queue->nr_reqs = 0;
 	spin_unlock(&queue->lock);
 
 	/* must not hold queue lock to avoid order issues with fi->lock */
@@ -1280,10 +1281,13 @@ void fuse_uring_queue_fuse_req(struct fuse_iqueue *fiq, struct fuse_req *req)
 	req->ring_queue = queue;
 	ent = list_first_entry_or_null(&queue->ent_avail_queue,
 				       struct fuse_ring_ent, list);
+	queue->nr_reqs++;
+
 	if (ent)
 		fuse_uring_add_req_to_ring_ent(ent, req);
 	else
 		list_add_tail(&req->list, &queue->fuse_req_queue);
+
 	spin_unlock(&queue->lock);
 
 	if (ent)
@@ -1319,6 +1323,7 @@ bool fuse_uring_queue_bq_req(struct fuse_req *req)
 	set_bit(FR_URING, &req->flags);
 	req->ring_queue = queue;
 	list_add_tail(&req->list, &queue->fuse_req_bg_queue);
+	queue->nr_reqs++;
 
 	ent = list_first_entry_or_null(&queue->ent_avail_queue,
 				       struct fuse_ring_ent, list);
@@ -1351,8 +1356,16 @@ bool fuse_uring_queue_bq_req(struct fuse_req *req)
 bool fuse_uring_remove_pending_req(struct fuse_req *req)
 {
 	struct fuse_ring_queue *queue = req->ring_queue;
+	bool removed = fuse_remove_pending_req(req, &queue->lock);
 
-	return fuse_remove_pending_req(req, &queue->lock);
+	if (removed) {
+		/* Update counters after successful removal */
+		spin_lock(&queue->lock);
+		queue->nr_reqs--;
+		spin_unlock(&queue->lock);
+	}
+
+	return removed;
 }
 
 static const struct fuse_iqueue_ops fuse_io_uring_ops = {
diff --git a/fs/fuse/dev_uring_i.h b/fs/fuse/dev_uring_i.h
index 51a563922ce14158904a86c248c77767be4fe5ae..c63bed9f863d53d4ac2bed7bfbda61941cd99083 100644
--- a/fs/fuse/dev_uring_i.h
+++ b/fs/fuse/dev_uring_i.h
@@ -94,6 +94,9 @@ struct fuse_ring_queue {
 	/* background fuse requests */
 	struct list_head fuse_req_bg_queue;
 
+	/* number of requests queued or in userspace */
+	unsigned int nr_reqs;
+
 	struct fuse_pqueue fpq;
 
 	unsigned int active_background;

-- 
2.43.0


