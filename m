Return-Path: <linux-fsdevel+bounces-40118-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A2CAA1C4B7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Jan 2025 18:44:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5114418826E5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Jan 2025 17:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372AD126BF9;
	Sat, 25 Jan 2025 17:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="qtjob2Oo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip191a.ess.barracuda.com (outbound-ip191a.ess.barracuda.com [209.222.82.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D7D78F2F
	for <linux-fsdevel@vger.kernel.org>; Sat, 25 Jan 2025 17:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737827068; cv=fail; b=umNgtBSNa2DX3uMGLaTzRMOk9BGTgfTBeh3jc4y+B67t4JSCOiz/9JyOf1Jo6jxK7EPPlMA0rBqKqJqR6Kqx8zBFy6tH+sC/llVzDJvMpi2UG/isldL61uWB5wvidUMvKtJhEVstb7/P1XnNQlS4ZZUvCnKOaqC0UQUsUCjlZLQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737827068; c=relaxed/simple;
	bh=yUJ9fXw+s7PSlnZC/eBwvb7lEDcN1GM+kxlmJV+H/ow=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mmdrE890uAjhLTVV9vozb+gCEbu9VKXSsW65cap/qAM2GeqTW3l1bn7IJ8iIzyPFv7FoxjUa8mWxjaGJw7G9Rs0yWj+w2FnccHPgTAsSIUWfIarpzSiKlAdFzWz4+6uJTUDDkAxulFBu4scoO93hb4DCMUESxSHmzLNWIs0LMUQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=qtjob2Oo; arc=fail smtp.client-ip=209.222.82.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176]) by mx-outbound14-217.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Sat, 25 Jan 2025 17:44:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wM8V1gyUz3tA8nQmiTsb2Y+kv5j+vQNaz1iVEIGUIZ2mgwqSJkhRO8MefE+Vn4krAFIwvbySDZOd2UfkAvcwGQ+UbNF1aYjlp1VFAt76qTBAqDSNmJHsP5qzksp9aKh8AS2hhl1o3IibG29w/mSO5KBU9gq9wFiMFZXnVrDVZwdrkmZwIxWg6ffJ1Fbgh+6TCmR+pPZh7iby+FTww8jFEadMwlAXZ3wx3/VtuytpfvIiXI8qqNDBk6lSYabH3L42B80TlXg4+SJDzvURmsovNluW7t7fawFF03O8/Gs4w5b9B6ypX8EGaI0viYI9fmib/ShxIrtC5qb4fl7WzdSz9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dAfioqXjLs4pfelmWFqDTo02xoS2SmdmMM5Z0wKOsrA=;
 b=SZ6wQziWtppYvIy3mQuAjOx1AXmEp1MasePcoZDcB0Kjfw6jOo1S8A0EIHnXOx9lCxwGL+yxT7lltZt/mgs+fo3KHhXECMHpUNU62yLCiftlKmO1zmIrXN0jR8HbgCpnRRchL4CH5hbkZx6Etq2e6ZwVJDP8+F9gxP1BqwdlyYV5CJazqRuPou3M790MboDJ9bzoNmzauPSvz1BS8CocodVWeyEAH+Gbz4gDgoflvPOkk+FgpVmuxwb5U9DZQZQaZd0/s0n+nFCtrDfkDJ1gn4RrRVBfazk5jsCB0RYm/eiaAbwtUEqsrvP3QYIUjjy4HWTO7k9IipOmnxRkmYp3yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dAfioqXjLs4pfelmWFqDTo02xoS2SmdmMM5Z0wKOsrA=;
 b=qtjob2OoorRdJ8dqE0mfnPwGAGu4RU/UDJ5lkwPGOAPVE5GVJc81bygVumJ4h0oTdTFHes5g7AusmOGzwmNS1ZaPydsiH2Ai3UCAY10L8NayMuk/Mum7D9kNBCdotZ0TKYveWX51CTrpBAF11pb7jFS5+ARRsW5/wZnx5MmdJAA=
Received: from CY5PR19CA0069.namprd19.prod.outlook.com (2603:10b6:930:69::15)
 by PH7PR19MB5634.namprd19.prod.outlook.com (2603:10b6:510:13d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Sat, 25 Jan
 2025 17:44:08 +0000
Received: from CY4PEPF0000FCC3.namprd03.prod.outlook.com
 (2603:10b6:930:69:cafe::8a) by CY5PR19CA0069.outlook.office365.com
 (2603:10b6:930:69::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.21 via Frontend Transport; Sat,
 25 Jan 2025 17:44:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 CY4PEPF0000FCC3.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.8
 via Frontend Transport; Sat, 25 Jan 2025 17:44:07 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id 0F00334;
	Sat, 25 Jan 2025 17:44:06 +0000 (UTC)
From: Bernd Schubert <bschubert@ddn.com>
Date: Sat, 25 Jan 2025 18:44:02 +0100
Subject: [PATCH v2 7/7] fuse: {io-uring} Use {WRITE,READ}_ONCE for pdu->ent
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250125-optimize-fuse-uring-req-timeouts-v2-7-7771a2300343@ddn.com>
References: <20250125-optimize-fuse-uring-req-timeouts-v2-0-7771a2300343@ddn.com>
In-Reply-To: <20250125-optimize-fuse-uring-req-timeouts-v2-0-7771a2300343@ddn.com>
To: Miklos Szeredi <miklos@szeredi.hu>, 
 Pavel Begunkov <asml.silence@gmail.com>, Luis Henriques <luis@igalia.com>
Cc: linux-fsdevel@vger.kernel.org, Joanne Koong <joannelkoong@gmail.com>, 
 Bernd Schubert <bschubert@ddn.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737827039; l=1124;
 i=bschubert@ddn.com; s=20240529; h=from:subject:message-id;
 bh=yUJ9fXw+s7PSlnZC/eBwvb7lEDcN1GM+kxlmJV+H/ow=;
 b=5N7hGYGIhYFnH9uzcIP+Zc+0k//B6d9DAp7f+EAH8nXuwxvDB5sA+6izrQx09tl3VxUEsOU56
 1yzkI+Qb1eTChKE/SGlOn2zHbr7/WvmeAIOB0qdayOpqFvhCwO9mNy9
X-Developer-Key: i=bschubert@ddn.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC3:EE_|PH7PR19MB5634:EE_
X-MS-Office365-Filtering-Correlation-Id: eea8e6ca-3d24-4df4-ffe2-08dd3d67de56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZUtITmcwNkxBYWxFS2lhQWRXMmJudC9WcnVOTGF6VGhCVm1HOXpTYStEODBY?=
 =?utf-8?B?cTNhWVJ3VEpOdTFsV2pjTFA0M0lNYUxralJ6QlNMVnRjbzAzdjJsaXJ6d0RD?=
 =?utf-8?B?b3N4aWkrYS93NGNEaUpMQzd4UFFob2VxZ3pHYUpIbjdtRWljTXc2cjhBN3NM?=
 =?utf-8?B?QmtUbVFUNHJjVG1oclFaaTNQNm01WGpVNGZFL1gyYTBtNXcvazU1R2lBOFNz?=
 =?utf-8?B?eXJPM2JldUMzTVdxTnNtUjlWVkpoblMzeWRkRDVIZ1FwWEp1ZmVPcjMyalV0?=
 =?utf-8?B?dUVSR1dyUm11VDc3VHNaTUN2SmxHSEk0QURjSGtRL2RwVTI1L2FGNElhL3ZI?=
 =?utf-8?B?cTRicFNIU1BORTdhcHQ1U0loTHo1MHZMVndBeGdLZUhodEQwcTl1akg5dXRP?=
 =?utf-8?B?NEtFN1BNWWNMa05NV3RkTmg3Z3EzZ1lmRmFWTmR2bFdSMStrazVQMDhKUjNa?=
 =?utf-8?B?M1NSVDRJZHRzRnRhbnowamVKbE1vVGJJS3ZMSThGQmN4MTdObmhOUFdGUXN0?=
 =?utf-8?B?djJsRzNOQ20yRHVwaVFQZVRIa25HQTVwM3JFaGRseWFNUTZMcXg4Z3Z6dEV1?=
 =?utf-8?B?RDkxN1NQR2J6S3pEWXRCT2xHZ1E0Rm1lSHJtLytUSFh4Z1FiV2R0VndMc0FL?=
 =?utf-8?B?Y0FVWlNZM2hqYzNzNkZTQUxacVhGZHA2SXRiTkVDWFdlUzFyQktrdTdMZUlq?=
 =?utf-8?B?ZXFmT3ZHRno1WDQ3YTEyVFNwcHpVZFdrQUtzRGkzNm42T0dGSFRZVjRmVDZp?=
 =?utf-8?B?S0Z1QWZBbTRWNFlVTmdxbW9LU2RLQTYxVU1hVUFhSytqSTdqUFZqZXZ3MVFT?=
 =?utf-8?B?VnRHZFdPaitzMU9Eb2JiV1NZVk1jc1dWdGZzUkhiWHlJcFRSVHVWRUZrc2Fn?=
 =?utf-8?B?WlNrd1BhTU16QVJSVkRBa0MxZUhqanNNbmhSNkFNODRpNzE4QkRCUFlYVjFq?=
 =?utf-8?B?am1CaXJ1c0hoN1E2cDRhMiszQ0p0dEMrUXQ2aWtWTkphdDV3c3djSzdaWVNX?=
 =?utf-8?B?NzQ0cFNBWVF6clo3dER5Z3JrNnA5UlNWUFphRWRqUDFJU251MTJBc1JacFFP?=
 =?utf-8?B?eFhCYlZoMnZrcWRRdHdnSnRxR0wvRDRXOFdmVk1yVWs4cmJYeGhQQ2Y0Ryt3?=
 =?utf-8?B?bjhQMWRuZjJqME5GbTQ4Rm5ReEtYYkdZMk54b2hReDhSMTVoYXRFSS8relBE?=
 =?utf-8?B?UHIyQU9Vd3VCUjdva2JHenMzRFNQZlJjRGpjNi9DdEdQM2F5aEpML1J2SG1n?=
 =?utf-8?B?TXFnZGllQzFaVGVUN3MwRjlwc2tmbW1NazlhTjNrTVBUVEVoaUpwcVpadXJN?=
 =?utf-8?B?bzE5QXF2Um5TY2RneWVMSGJqRlBvU1d6YldVYWZBWm56Y0tCUEtKbWdNTXVZ?=
 =?utf-8?B?NnNWODlGelNIaXNTYVhpWVhTRm40eFV6SU1IbUpjZkhWc2UzS3V3a1pvY1FS?=
 =?utf-8?B?SXJEZzUzbm9hNEVYZGxVVy82V1NXZEFiZytsaXI3QzgxeEpKTXY4NmZZRkg5?=
 =?utf-8?B?SkpEYWp6bGNicUdTSXdzZFVtL2NYQ2FEQTFmSzV5akJUcTFZWXJwL21ib0hJ?=
 =?utf-8?B?L3JFTWZhNFhKSkpib0FuL3M5NWhoNEphaHlFaEZCNFhEL045bnd6elRsU3hQ?=
 =?utf-8?B?d2VhM2Z6a3JBeXVjTUtucHY5NkxQWDk3dDZEZ2JjQ3ZibHhRNEgrUU9qU0pS?=
 =?utf-8?B?MXJDNUVlcks0d3ZoajFOc2IrR2JKR1V4VnJlN1VtWkExdVlLSTJ5RitHaDUw?=
 =?utf-8?B?Y2VHWXNnMC9mbEplbENGWUFZSzVNbkdkSHlNYTJReU8vSEozQ2t1UkNlVysy?=
 =?utf-8?B?eks5Z3JVV3AwdlVUOWRxU01nRy9Icm1nSFJGMm54OWtsUnpaaHdjRHRTNUgv?=
 =?utf-8?B?MU0wMlJDdXQ0M09yT0VSSDhYUVVyMDlJMGZBdXlhTkJBS0h6dUFocElUK2ZT?=
 =?utf-8?B?TmRwcTF2cVNZK1NvRThZOXlxeEhZbzh4dGEyZ0FYaG15UnQxaFYybnpwd3Qw?=
 =?utf-8?Q?aliha+EwVedLABLVCSCBRt+nq8X1eo=3D?=
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	SzfupL+zwg18E/QjOEZ4oVWV/fbzWB8k92boE9pSUeW5pY34Y0ZpyqXlec27aXxHa+QJOqnKbhfw0DMpwMmLDUALeenJQABA45I0BB/6dFhYWdwVmT7iUABHTMOoYEEmELqeeMpuu+ZBMORkIaEohTjb5gQdc/0avJiwMzCn5+Xct5AgP1d2NyhJmgx4IU+3W1llZk9xIQy/Wr3b8qJsOa5WSJLrD4Gj0SxhBAoLJG2YusADl1z54UzKFUnNEoez3hKau6Wge8/1FHCGdjUyUMDxJhek0v7s4fgAHU4oQOuxhaSmsD3MBJm3Q/Ykj18EF02XdlGxFCh5xLpDgFwlbOD+iFN484qezgAv++yZUK+GO2jnbbOy3WVTHKpAlaartQXLA8nhrUyyaejUtqOaVWB4cNmEOjlzwGVBTX/xHSkPJV+CWSig1YENDNRwKfr/BC5NrWCbom+YmaI0fkq9DHjEH5I9Tdlchab3cgqjtdtJj6lJsM+4f6zVwmGIFP+0Rp8Ct2DBRy+EVRmnG++WswudWiSEmrCghettQ8B4tV83rN4BpINW2K/q5klBXzoH3p8gM58GIqqa15xs8VMF1oMtxDx49QLQCdgLeApp89s54p4CC681qoTnAd4jYKZVlXsJUOpFPSyFoegK9uKVtg==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2025 17:44:07.6866
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eea8e6ca-3d24-4df4-ffe2-08dd3d67de56
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR19MB5634
X-BESS-ID: 1737827051-103801-13471-3784-1
X-BESS-VER: 2019.1_20250123.1616
X-BESS-Apparent-Source-IP: 104.47.56.176
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoYGloZAVgZQ0DLR3CA1ydA0EQ
	hMzIxMTS0t05JSTC0MDMzMjVIsUpVqYwGzPM/4QQAAAA==
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.262052 [from 
	cloudscan9-132.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

This is set and read by different threads, we better use
_ONCE.

Fixes: 284985711dc5 ("fuse: Allow to queue fg requests through io-uring")
Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
 fs/fuse/dev_uring.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index 9af5314f63d54cb1158e9372f4472759f5151ac3..257ee375e79a369c18088664781dd29d538078ac 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -36,7 +36,7 @@ static void uring_cmd_set_ring_ent(struct io_uring_cmd *cmd,
 	struct fuse_uring_pdu *pdu =
 		io_uring_cmd_to_pdu(cmd, struct fuse_uring_pdu);
 
-	pdu->ent = ring_ent;
+	WRITE_ONCE(pdu->ent, ring_ent);
 }
 
 static struct fuse_ring_ent *uring_cmd_to_ring_ent(struct io_uring_cmd *cmd)
@@ -44,7 +44,7 @@ static struct fuse_ring_ent *uring_cmd_to_ring_ent(struct io_uring_cmd *cmd)
 	struct fuse_uring_pdu *pdu =
 		io_uring_cmd_to_pdu(cmd, struct fuse_uring_pdu);
 
-	return pdu->ent;
+	return READ_ONCE(pdu->ent);
 }
 
 static void fuse_uring_flush_bg(struct fuse_ring_queue *queue)

-- 
2.43.0


