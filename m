Return-Path: <linux-fsdevel+bounces-55759-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1622B0E647
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 00:15:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 021401C851DA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 22:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B13452877FB;
	Tue, 22 Jul 2025 22:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="wnmi/GDg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip168b.ess.barracuda.com (outbound-ip168b.ess.barracuda.com [209.222.82.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141ED1AB6F1
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Jul 2025 22:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753222531; cv=fail; b=XtfgVRYnlF9pEz5tUH2dB9Fmmf67sPohLOUCWZgWDNLelRtYIEx67Rm9XAoEQMbCEeoep2JNYLpGBhlr/yOBeQ0eFf2g1UojdryTCc5tWBO7+hxGZQ4efNW8NT6bzB1teVYuMGMjCejqHyADjUnGhujGo+Y9tclEYKLSjyFHIPk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753222531; c=relaxed/simple;
	bh=w/L7yCgWhCV4ITcOi86P9JsgEKSgy22n0MpesYMLOpY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=gsPN9aKEZpVOJuIv+VL+ajjMK3LjKk5xDfTVMI1wWNXqSngGJelj9r5nF/qrSigIFvNnURGIN+P2nH9xhF1ezojV24gqQaGpxke6kGIRbPkqe02qmG1P/8c8cwBjfFw8MvVHtqjxwXDmsEIPYeAj2/YlVQHYUYK5/05EDR7W6gw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=wnmi/GDg; arc=fail smtp.client-ip=209.222.82.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2106.outbound.protection.outlook.com [40.107.244.106]) by mx-outbound44-195.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Tue, 22 Jul 2025 22:15:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ua9xLmeZfxcPagpee7c+BG4X1x/Wgluwsmv/Vba7qK9uqhOo/tTYbHSvxDcJFucfaKrJyaX5h2TFO12aVpMEaxJgewdYuSbx9xYBmwjTzRD11aWYudVI3305w2U7Rp0XSXDSxPRnXBtRSwEAoaP7kX8bZZM2hB5c+ni5QdwXberMslSKyu6HczmSuLRuZ30RDKQfCq7Fsy2vjtZsutNZ4m7r84KF1CMT+m/OzH/AiXFUEurqOS/JeD2n9YIdi+XOoPpbnHROjT2ChWlmx9M2sV8Xhd8s2436mHd+2RkFjIrUV6cpYxxJtZ+u7C+ZVm7tENMkQaNAalXbS0mXVJD3Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TmZfzeb7S1dp0Kfahq1i2VByPvuE3gARkcxSdiK7ZpQ=;
 b=NZ4wL1sT9c3zUp2cGJiQAUmbWBPZ0yu75ewFLjOwrAAlooySao8jStuDCEH2gwp6Zo0v5nt6qcrRhXxu+xvIiVMpJBRkRvEY2tpf71oyACWi0/ZBoUdUKJffE39xOzlES8eTcMKkKXmFCHCX/jZDn5SU0tKWISArn545tVLSO1aw9Z9uYNW872IRF33+xtNZapJFyw/dWe9NzTfadZAKehq4ZuiY1T/qvrdurnJKvxgS8w2Mpp8825TF+ZqRZEuupG70pQ/AFYE2gHQftUFb0k1YM7PXnYAp0Qo8JkZAwQ81d34UHTZMZzCSQEMikGYon9w/GSd2vh2HBl86KtjmZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TmZfzeb7S1dp0Kfahq1i2VByPvuE3gARkcxSdiK7ZpQ=;
 b=wnmi/GDgRjF18pbxNZeZS6Rn3MpsmY2JcRH0Cz5QsllUZILkC6ywP9e9V90AppXoVmNN0LQHCcYYYNWP66T5edkZXzvzkMEohvdaB3OsLbVn73CLxLnViY+LWHs366o5w9f+MlmyKFLxwyOYztbKUeVcYwfJkZTWRtU6K+IbesY=
Received: from BY3PR03CA0026.namprd03.prod.outlook.com (2603:10b6:a03:39a::31)
 by DM3PPF95629A250.namprd19.prod.outlook.com (2603:10b6:f:fc00::747) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Tue, 22 Jul
 2025 22:15:11 +0000
Received: from SJ5PEPF000001F7.namprd05.prod.outlook.com
 (2603:10b6:a03:39a:cafe::db) by BY3PR03CA0026.outlook.office365.com
 (2603:10b6:a03:39a::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.29 via Frontend Transport; Tue,
 22 Jul 2025 22:15:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 SJ5PEPF000001F7.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.20
 via Frontend Transport; Tue, 22 Jul 2025 22:15:11 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id 51E4FB0;
	Tue, 22 Jul 2025 22:15:10 +0000 (UTC)
From: Bernd Schubert <bschubert@ddn.com>
Subject: [PATCH 0/2] fuse: Flush io-uring bg requests
Date: Wed, 23 Jul 2025 00:15:08 +0200
Message-Id: <20250723-bg-flush-v1-0-cd7b089f3b23@ddn.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGwNgGgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDcyNj3aR03bSc0uIM3bREC2MDC2NTc3OjVCWg8oKi1LTMCrBR0bG1tQC
 0ciAoWgAAAA==
X-Change-ID: 20250723-bg-flush-fa830835772e
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, "Darrick J. Wong" <djwong@kernel.org>, 
 Bernd Schubert <bschubert@ddn.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753222509; l=811;
 i=bschubert@ddn.com; s=20240529; h=from:subject:message-id;
 bh=w/L7yCgWhCV4ITcOi86P9JsgEKSgy22n0MpesYMLOpY=;
 b=ksWYcA0yfCaIN/mikzbUbRl81vvwSIBrMjAdm5JIaS/nctRvoxp0TX6KU/f6uJ+RmtAZblmM0
 7MU/COIqZTxC1xIj6M8ILCltcWybLQnz2uHYZbd7XcS7gFFSo7o6I/v
X-Developer-Key: i=bschubert@ddn.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F7:EE_|DM3PPF95629A250:EE_
X-MS-Office365-Filtering-Correlation-Id: ca024117-f467-42da-95a2-08ddc96d39bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|19092799006|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dmhwbzQ0T3FCN2Y4WHlDd1JpRU1RTFVLOG9Hdjl1ZEViVURBTjVsZ0ZYaVFI?=
 =?utf-8?B?Y2luOFNMOEpITjFRelM2TWYrTDBqNDBROGJGZ0hLVHJ6OXJKNVFoRktvTEk2?=
 =?utf-8?B?dlJOOHY3YnpWWUtnamI1RlBzRkZXSFhLZ1V2cHhNUHlvUm4raElsOC9KL2Vq?=
 =?utf-8?B?c0p6TjFJNXhORmdFVzg0bGl3MmVjWEhYSGtZRUNXZkRkRi9ybzdXaDgveEg2?=
 =?utf-8?B?czBUdis5RU5aMkFqaG9tUWo2MnVrdzRSdFVtSk81bmNrc3FXQXQ1c3ByRmFv?=
 =?utf-8?B?L3RVVTBwT216cjJoa3lQa2thdWNGVzRORFdPYm83NEI3WlgyaWZlMWJsWmdB?=
 =?utf-8?B?VVNDb3BpbjM0UEFpbVNIODFydktPVVlWRDAxdW00TmZkM3BFaEMyK1FmK05v?=
 =?utf-8?B?eUJLeG1HQ0EyblBRcDBLUmVzSHFJa0FqdjVBa1VOeEluNHg0aXlWTW8wYjQ5?=
 =?utf-8?B?Y3h3cFJQOEFzUktkVU84L2IwbGpjd3BEeSszZlp6RXBRZG50WldWdkRiUENn?=
 =?utf-8?B?c29YY2tHTnF1bkpUeVBhZklNcUhxbDVrTzR6QnpjTXArbmpxZVpvWE5FbS9r?=
 =?utf-8?B?M1ZZQTFUT3o1NVpuWXkrZS8rNWQyaTkrYTdjWUZTUGZhSWl4R2tyNUFtMU1T?=
 =?utf-8?B?TjJFMThvRmlOcllrTUZUMXJpM3MvMVlTR2xiVFB1eGhZOFFQajBsQUR3RkYr?=
 =?utf-8?B?cUdqcVJUWWVURFhydHBJUExiTzZCekpIdU1MZkZ2Z0RWUjFrRW1aYTNLQXEx?=
 =?utf-8?B?ZHV1ckJ5SzJneXI3Wk1XSnNqVU9JT1QzQmgyelprUStLam94UkFBUk1nRUVB?=
 =?utf-8?B?K0UyNVduL3JIZFdvL252V29yOFRVQ2lkMnVpRktMa1hEY2tJNkNKcnpBSVUz?=
 =?utf-8?B?K01jT2hGczNQNUlXbTRMRkxvc2JrNUxWRnhEOEc2aTVZZkE5TDdJTy9LS2Nk?=
 =?utf-8?B?Zy8xbjFqbm93ajh6QnpDaGtQSHlDYWl5TmhLWWtvNU91OHkvSHE2Mk9QUjhV?=
 =?utf-8?B?QlVYRUx5bEtDK1FEb0VUY1Q0UkR0VWRIYlBVajNvcXlGbjMzS2NEekJES2NR?=
 =?utf-8?B?eDljekY1b01ob2YrSHJJZm53RVo3Y0tvdjM3ZU1GcDVRUnF3MDF3Z3h0bm1W?=
 =?utf-8?B?SzYrTmlxZStTdTcyV3pIb05IYllKaGVTL1pEYmdRUFNYc202NDBoRVhRNGFa?=
 =?utf-8?B?MnJLRTcvZ1pKR3REbkpKVmY5VFVpRGZHajYvZGRSbUxQOEl0a2R1Q3NmeVIw?=
 =?utf-8?B?K24wQkhrT0NCb1pSUkdMY2Z4OWw5bmtQSmJtdG51L1kzQTUxL2N3Tmx2YjZ4?=
 =?utf-8?B?WnlNaTR0bFl6UW9HUGk5ZlB4bHIxeVhSUk5CZlQ0QUp3RXZDYXlyUXJmQmw0?=
 =?utf-8?B?YW5uVVdiYXlMUjkyeUZSYkl6WHFZWnFTcDFaMnh2UFJOKzFkUUVnaEZJSytN?=
 =?utf-8?B?OXF0dHU1VURqWHRtTWNRTzd1c0lBci9Hb21RK2haaW9FVjlLYkdIVWl3d3Y3?=
 =?utf-8?B?b05ONkxQV1pPUHB0ZlY2YlVIaHE5VHc2dkozbXNla25wOWYwQmpoWGFvSU5s?=
 =?utf-8?B?cC85NW90VWdjQndmSlZCdVBJTFNuV01RNFlMaVdSLzBxcC9uNW9USmtMVGNi?=
 =?utf-8?B?SXRZODJTQ3FrM0JrZUpBSTRSU0M1RENDOGdjKzBmKzZHY1hOYndaTHptSTlu?=
 =?utf-8?B?VFNMMUg1VE5RdWpFS0NKbDI2dHh6d1RkRjZ2cThlOTFRM1NGYlJsQld0R3dY?=
 =?utf-8?B?bXBzRCtsdjgwMjFrWkhzV3RGdGU4M2xWdmlPYy8va29RaUdrMlg1c3NkeVJt?=
 =?utf-8?B?VnNGL0RqZjFqTVQ2TW1HeVkydHQzamJwNCtWY3ptSnhGbkwzSURNaWg0bnZY?=
 =?utf-8?B?NFJNYTU0NmxRT29IWDdET20zL3B6bEZaYzVlcTZmeEFHZWdCQ09qb3ZWNUdj?=
 =?utf-8?B?NllPZEpTWjNFdnRpY2IxK3R3N2NQRGlpTGEzUWx1bFlWSWxxWWNwU2hNS2ZC?=
 =?utf-8?B?VHJtakVFN1h6VWNmNjg1djZDOVloTUhMR1lhamY2ZU5RNEQ0aDlPMHQzRXJJ?=
 =?utf-8?B?UElacXlwUVpYSGV6c093S3ZzWXQvR1Y3akxOQT09?=
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(19092799006)(376014)(13003099007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	DJHGdRm9I4by5Psu5gf6STEIosllI4GGYEqPlP3cEWdG4b24uPFZWdqziGcOWg2v0ARosC0+CHUTMvHFJZZmO+LknBcD8+pmn3lporFtLdHr8DD3BLtSBstr58Y2jTO+QN9Z1CU7NDEqEMV8JcHxyg6+6E7bg6IaHHFK4FaYtp6iCimqPzyMc1JjIDih2AJGMFhAXUVtlY0L0iCJ0ufMe/BcnQkkNPYVUdqMj9gFKalm3rB5klYJz5ASo3jAufsda2pgw7Tou9GJnTl64RlczhTKjoJgfUxSAWy/hPm+UfvpIZ2yWElS5+MD2lQrvQF32Qd2pmEBmvUyUNeX9k7L+Tn91zArPjMu87ASH+a6H/aQ54wIumKOOK7QBuuE/2uIEOa7l/rw2vYAfVIvE/KhUSIwJ3C/GKBRh9zEMp+hgx5EmI+nVgzUOjz7yny3rQYn2ibVqgDvRE5sl/FdU2+ZAgZSRugIH8u1vtWcaFQ5i6GMEMza34of2999IrsJ0pQTDbk5SEhUCJfkGTvutMWM37T4ZDBv+KAP2effBB/pMRnRDJijxJHJIPOxfhJ8pM03OhyCswNdRtYCYf/cM+ErNzOU30tIipIJp6SvAtMsvpFg0A6d6sNWeiz8c/tgERkMcPDGemj7SuAZjrFEgzDvuQ==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 22:15:11.1746
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca024117-f467-42da-95a2-08ddc96d39bf
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF95629A250
X-BESS-ID: 1753222517-111459-7628-16211-1
X-BESS-VER: 2019.1_20250709.1638
X-BESS-Apparent-Source-IP: 40.107.244.106
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVuYWlkBGBlDMwCzRwMTQwtAsKd
	nYzMDMLM3YBIRSDVOSzcxMLE2VamMBxOSfFEAAAAA=
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.266236 [from 
	cloudscan8-155.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

This is on top of Darricks iomap patches and allows to flush
fuse-io-uring bg requests. We actually see busy mount points
in some xfstests and these patches seem to solve that.

https://lore.kernel.org/r/175279449501.710975.16858401145201411486.stgit@frogsfrogsfrogs

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
Bernd Schubert (2):
      fuse: Refactor io-uring bg queue flush and queue abort
      fuse: Flush the io-uring bg queue from fuse_uring_flush_bg

 fs/fuse/dev.c         |  2 ++
 fs/fuse/dev_uring.c   | 17 ++++++++++-------
 fs/fuse/dev_uring_i.h |  8 ++++++--
 3 files changed, 18 insertions(+), 9 deletions(-)
---
base-commit: 5ef3da3900942680e3cded352be2dede505e2c26
change-id: 20250723-bg-flush-fa830835772e

Best regards,
-- 
Bernd Schubert <bschubert@ddn.com>


