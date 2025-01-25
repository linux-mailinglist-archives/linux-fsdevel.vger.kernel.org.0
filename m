Return-Path: <linux-fsdevel+bounces-40119-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F643A1C4B8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Jan 2025 18:44:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7921D3A9DD0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Jan 2025 17:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC54A78F49;
	Sat, 25 Jan 2025 17:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="p6fA+oZl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip168b.ess.barracuda.com (outbound-ip168b.ess.barracuda.com [209.222.82.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007CB8635E
	for <linux-fsdevel@vger.kernel.org>; Sat, 25 Jan 2025 17:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737827080; cv=fail; b=RkTcjzRIW7cpYvyYQ1pO0P2L5kqaupMVOUN4+En0Xc3DLdmIVKtnBFuQpvbu4xnXVYgnV6XV3XHsRDEiOdlEAalR3E0/1Glk9ZTBeTpstxcXmfz+IDTUt3vdlZVhhLecB6M+6ZR2sswpF0PFq9GJmTgSnnjS915Bl6LQx+nfIxI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737827080; c=relaxed/simple;
	bh=v4ub08QzNfgJQoFBhgvB3O/P+pplcrRRkYHV1rn2Wb0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=vCugCUIlFSrXR2UHu8hZ4+06mqcqRCfm5CiYSIb4U9Xdarmsk37I73mzB5vEwFnyUq2xgCaG7QRPpaggcL8GopZZWFDxoFWEfSJo4NcheHTjRq42ALBeDKkzbGcYgtoV46LKXD3s4GjO7AKkHy3SRwFg/HtDU8j+lUs17hmsLyk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=p6fA+oZl; arc=fail smtp.client-ip=209.222.82.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2049.outbound.protection.outlook.com [104.47.73.49]) by mx-outbound42-127.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Sat, 25 Jan 2025 17:44:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RGvSg76qW+TV40o6LxElsTOzOyB18M7fH78/7WCUQPUkAMtuQQS0jETbuyiaGW06+x2GdCtHI4XkMmOR/Fb9ZW7k+0V7dpw7We+xn30FPIsKffypR2no9bJm0VGGh3xR+cj+MTm7lheLk1gbGOkJV8fpgl4+yHlmSuGwpdAa48faWZxwMVXZTMIIsLSXgjGMEKW76TefxAhu/aVDMvKovZRwNReuQJhYQo6tE9CcaskkQE7zj0NISaD/3uQSBt8HFW4n7GWeZfSZfdVny562DszDanbjflIF9OhRde8i6cWGUDnfLPJsD2lc+4kOOI7UbQKeZJXoomYUdnU+zD4/tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OrXenzNo0SJk6uour9g1yQfrC+nllpXhcqBhrrxRJWs=;
 b=o7snh1ed8gs2aB/uQ7BfFXn6xZREmqwJtY9X8/IiDGIBVnq38Lau3KZA03lmGGX5yWZ9O/60AcYWw2P6FCPNx0o9YeiLPxGDEHhr4PUI/SN6oLhAwBxdrov2HYFk/YLuLG+UEWb6yqXMEDx5TolKDa0KuAVh23wcwAlKVKw1Wm/xfrRXCo2BlFdK1AlEetftWm9x2mXZTowXi0Btxg8Oah53iP0BSbuKMf9FOVoAb/SFsnbryFpfsllXACUELOKGYa9IlmhJGqPSZKoLGeuIJsKgi9EfEYqHdtwrxOpbqtWMdCMtFaM34JsVpUXu5egmkHiP5rMpS1/cQIsVg+0Lrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OrXenzNo0SJk6uour9g1yQfrC+nllpXhcqBhrrxRJWs=;
 b=p6fA+oZlwe6Tl/4GpfcZ47wFqJ2eIk/irdgA8R1eo5nS/hZYmc+gnrpghG/XdYZsyib1fIcJNw0ycJefEVq24Dt7j9V6aUgHC+cgeOoz0aUmoZ/kybLUWD5yoOoH3slPBdQ2BuHQZfMbJ562grDVO0BvfqtcpiqWIozUkx4bu28=
Received: from BN7PR06CA0059.namprd06.prod.outlook.com (2603:10b6:408:34::36)
 by BY3PR19MB5239.namprd19.prod.outlook.com (2603:10b6:a03:368::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.20; Sat, 25 Jan
 2025 17:44:02 +0000
Received: from BN3PEPF0000B070.namprd21.prod.outlook.com
 (2603:10b6:408:34:cafe::1a) by BN7PR06CA0059.outlook.office365.com
 (2603:10b6:408:34::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.21 via Frontend Transport; Sat,
 25 Jan 2025 17:44:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 BN3PEPF0000B070.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.0
 via Frontend Transport; Sat, 25 Jan 2025 17:44:01 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id 2FAE334;
	Sat, 25 Jan 2025 17:44:00 +0000 (UTC)
From: Bernd Schubert <bschubert@ddn.com>
Subject: [PATCH v2 0/7] fuse: {io-uring} Ensure fuse requests are set/read
 with locks
Date: Sat, 25 Jan 2025 18:43:55 +0100
Message-Id: <20250125-optimize-fuse-uring-req-timeouts-v2-0-7771a2300343@ddn.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANsilWcC/5WNMRKCMBAAv8Jc7TlJIAJW/sOhEDjgChJMQkZl+
 LuRH1juFrsbeHJMHq7ZBo4ie7YmgTpl0E0PMxJynxiUUFpIVaBdAs/8IRxWT7g6NiM6emKyZNf
 gUWtZi7Iuu0shIWUWRwO/jsW9STyxD9a9j2OUP/tHPEoU2FZ50eohV1TpW9+bc2dnaPZ9/wLPB
 7VAzgAAAA==
X-Change-ID: 20250124-optimize-fuse-uring-req-timeouts-55190797c641
To: Miklos Szeredi <miklos@szeredi.hu>, 
 Pavel Begunkov <asml.silence@gmail.com>, Luis Henriques <luis@igalia.com>
Cc: linux-fsdevel@vger.kernel.org, Joanne Koong <joannelkoong@gmail.com>, 
 Bernd Schubert <bschubert@ddn.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737827039; l=1525;
 i=bschubert@ddn.com; s=20240529; h=from:subject:message-id;
 bh=v4ub08QzNfgJQoFBhgvB3O/P+pplcrRRkYHV1rn2Wb0=;
 b=jH39avanZaaE6glzJYbIAiIBJvay6nSVnQigjQjqJdDKjxtSn3LyLwoZtVNgwTIdMpIj7eUyT
 b7C2blmxFxACNyBluAEfJfTVJ+OBEFcrovEAVjKt1SJSecjmoaICOLY
X-Developer-Key: i=bschubert@ddn.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B070:EE_|BY3PR19MB5239:EE_
X-MS-Office365-Filtering-Correlation-Id: 244d32cc-397d-46ed-1afc-08dd3d67da97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ajJvSytYcTdRU0syZHgwZVVvNWNhZldQaVNPVGtZMEJSNkNHS2taVXVSWjVF?=
 =?utf-8?B?WExMT0hMREJUZWFSdEsxbUlaSUErY05sWXNNYklQL1JkVmZxdzRvd1NVS2do?=
 =?utf-8?B?Zk1qRWswZ2kzMnZHL2pCdXNDZTcyYUdNK2R5VnEwamJWb0l2VnRWS2I0d1dx?=
 =?utf-8?B?SDE2aWs4ZUNTQS9NUGhiS09WaHpCRjhjUk4zU0xSWVFSNXYvNGsxK0VIYTVU?=
 =?utf-8?B?YmJQdTByTkZiNVFkNEVEV2NTN1doTVRha2h4MFFUUUR2UzUwZTd4c2E2c1Jt?=
 =?utf-8?B?NE5NYlA1dDdFcUdlVmZWUnFSZDcxVHdmRGdkVGIybTdkY1o5NXJuRTE1VGpu?=
 =?utf-8?B?SlZVeDVnY01mRjhtbGZsYkhTYkh2OTdxdDZSbHdIQmJCbkVJM2EyRGJLdElz?=
 =?utf-8?B?dlIyaEhKUzUyNHkvaEpSRmVaa2JKSm96dWJqeVMxUnMrOWJjQm96Q0pPQzds?=
 =?utf-8?B?a2FNZmRpV3l3TVluQlBmQm1SUnpIelJTN1BmcXJiR0ZLZUkzcm4wbTJnS3p3?=
 =?utf-8?B?bXNJQ01meEc0VEtwMy81NHJaQ1ZFU1JWTloxWS8zVTRPeW42UjlqZytLRjZj?=
 =?utf-8?B?VlFXZytNRU1SU2Q1TjRkYlhPT2xmQTcwVHZIOEM4RDJZeTQxRnRta3NTOGY1?=
 =?utf-8?B?aFgrOUMwM21mbjNxbTh2VU9VWEl6aU40R3lBMWp3cTJMTmRiT1I5bEFHU2JC?=
 =?utf-8?B?NzlwQ1NHS2ZoK2x4VGU4dWFMQ3V6c0ZqVHJ1cEhFQ1JLUzZ6SHR2ZENTc3Vx?=
 =?utf-8?B?bjNIM05EZlF1SmFpM3pEYXpsaTZ4MERIbG5YVEd4dXRSMExNaGZlZThQOW5t?=
 =?utf-8?B?SXBEWHc5bEVTZmFsVlZxczZyVnlYV0RBT041NWMrQUxUeEJqcVpVZXhXaHhT?=
 =?utf-8?B?NUVCMVM2SnlML1N5Zkp2bG5aUjRvWXlPR0xzODNFUEl5VmcxL3FWMEpWdkxY?=
 =?utf-8?B?U2dhWkpQN2FGYUZ5MHpIYVpidk12c2xSNzhSNlRlaW1FeFhtR0pFbjV2YkNZ?=
 =?utf-8?B?QjlRUDFMSithN3R1SWFMYnBkN0Q3dG83bmhnbjViTEpacThYSndCUS96cGhQ?=
 =?utf-8?B?YmowWGNvaHpnNFliVDRJTnVPTzhhNDBIYU5rdU0yZEllSDhLWnUxbFlBL2xo?=
 =?utf-8?B?Z2ZoQStuZ04xbnE0bDBxY0xqdVRGeERpb2hwVVdBcDhjdUJ0cTBvcWJxL0lh?=
 =?utf-8?B?Y1dHdWtwNk9nVE1td0ZGL09LQkhPMFpwaFUyZDJ1c0JYY2lQaDNLYytiQldM?=
 =?utf-8?B?dFdGMzZTeWNDVVNaVjd1aGhzTVFjcmRpRFdtWUo3SXZuejdLSng0cHNMdHNl?=
 =?utf-8?B?a1VaOGdpMjZkNWMxMW9vdDRvT1M0WnJabm80cnpUd0h1UDlCMXI4eFpvY21C?=
 =?utf-8?B?MjVHVnJGTWg4a0N4ZGJhRGhxa3VlL3laRXRuVDIxTWphK01OeWFmL1JWR2Fq?=
 =?utf-8?B?QmhvRFVRcHVldlZnOGF2SG1sNUM3bUJiQklqWWo4aHpueUVvVUJQMTkxN0ox?=
 =?utf-8?B?MmxGaDdZYy9QTzRxUkFsdTY3N0VkUDF4VDJjb2tRRVlYVlhQWU5IWEl3di9S?=
 =?utf-8?B?L2t3UGRMaDVnRGc1Q3A5aTBRQkxFMGZxaTVqNmUvQks5cm93VU04QnkwU3lF?=
 =?utf-8?B?NGxrdU1Fblg4SnNSV0ZIWmhTZ1Q3SGkwYTF4WUpzTUh1ZXBIRTdhazVNK3Ix?=
 =?utf-8?B?V1pMOHhpSlBGdFcyWVNEc0tDZThwR3BqWmpJSjNXamxmOWNoeVJTV0ZSa2Uy?=
 =?utf-8?B?dWFPcGRmYWl4YkpMeC9VNWxtZWl0R1VZREpWSjJjWWh2TUY4Qkp5TFM4bm1u?=
 =?utf-8?B?eXBhY2dncXp3UG03dTZOb2RGazdSTkYzOXVvU2RyR1hQVHkrR1pvM090dWpG?=
 =?utf-8?B?WXJmSVVFNFpJcmxxQy9PaGNLRWNCWnZseHhnZkV3Y3B4THY2SktRT3Z1WSsr?=
 =?utf-8?B?REhQVFgwRlA2ekJTOVBtY1prT1UyZ0o5OEplWnZUUXlScEFPMXN4bC9hVktM?=
 =?utf-8?Q?6bsG+085SNJKVQKNsxEvNjC/gzZHZ8=3D?=
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	s2bIAjPY7u+s19Vgm8NoakOruQb+f/QHeh8/QQDYG8C+C1OF8kATp7op5tX+wxKiuCeVMp1A168WPp68Lh/pJd+8F4xSShsqxTcyo+SP0/Mdv7GWs01CIARJ8KJS/36oios7idU/+lGUDyi0rCdhVMsqPwu8Ikr7PNYlzrWPZRGFSvEJeujj4IU1AliD669HKVSTx1xHnmxhMOgD6gi3st4o135sAOZ3wA3M6BI87+qcBu6EL3GrWqZDBFy0WIu2uqMcqgmkdcHlTRW7jPgm0VfX5t8XqvCGks5sd+Oxeu/Jo+bcm23NAj4sZT9G2fmCtsdc7UzJulykLwNlLoHwiDYVNOvXZwE8rc6v/rj2yaf9DNXHCRo2ElXwsNR7SB/3cR/NAXDc5wdXl39I2d+gXu+SOGvS4K6CY0KS8kFYTEeC1SAoypBnQVGiFl/6NVqf54xwDxVZ62a1yMu6T3Mr/ewzZvnApCotu72osY27y55qYagBRgb3dHv18hX1xNQb0ryNAdUHGCPNmOFU0JeckCx4dFTShskffGBpksypWaJCyRhi1FXSyKAU4Mf4xC9jxbev63F2/lrKX6NfUb4ZYrOlpjubhjPP5YZwa/McWRJxgSranJF+3ruUJvA4abAHlD5OGFdTlwZbbZjgZ2B7+w==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2025 17:44:01.3333
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 244d32cc-397d-46ed-1afc-08dd3d67da97
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B070.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR19MB5239
X-BESS-ID: 1737827044-110879-13400-467-1
X-BESS-VER: 2019.1_20250123.1616
X-BESS-Apparent-Source-IP: 104.47.73.49
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoYmFhZAVgZQ0NI81dAwydDEMM
	kgLSnVNCXFwtjQODUpMTHFODnJ0MxSqTYWADu5e9pBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.262052 [from 
	cloudscan10-24.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

The timeout optimization patch Joanne had set ent->fuse_req to NULL
while holding a lock and that made me to realize we might have
a problem there.

And based on that, I believe we also need to set/read pdu->ent
with write,read_once.

Cc: Luis Henriques <luis@igalia.com>
Cc: Joanne Koong <joannelkoong@gmail.com>

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
Changes in v2:
- Further patch split to simplify review
- Fix order of reading and setting ent->fuse_req in fuse_uring_entry_teardown
- Fix compilation of individual patches (Joanne)
- Included v2 of the timeout optimization patch
- Link to v1: https://lore.kernel.org/r/20250124-optimize-fuse-uring-req-timeouts-v1-0-b834b5f32e85@ddn.com

---
Bernd Schubert (7):
      fuse: Access fuse_req under lock in fuse_uring_req_end
      fuse: Use the existing fuse_req in fuse_uring_commit
      fuse: {uring} Add struct fuse_req parameter to several functions
      fuse: Use READ_ONCE in fuse_uring_send_in_task
      fuse: use locked req consistently in fuse_uring_next_fuse_req()
      fuse: Access entries with queue lock in fuse_uring_entry_teardown
      fuse: {io-uring} Use {WRITE,READ}_ONCE for pdu->ent

 fs/fuse/dev_uring.c | 88 +++++++++++++++++++++++++++--------------------------
 1 file changed, 45 insertions(+), 43 deletions(-)
---
base-commit: 9859b70e784b07f92196d1cef7cda4ace101fd33
change-id: 20250124-optimize-fuse-uring-req-timeouts-55190797c641

Best regards,
-- 
Bernd Schubert <bschubert@ddn.com>


