Return-Path: <linux-fsdevel+bounces-45544-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 899DAA794E0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 20:14:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA3A61891536
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 18:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D151F1C5F13;
	Wed,  2 Apr 2025 18:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="Z5BdEph1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip191a.ess.barracuda.com (outbound-ip191a.ess.barracuda.com [209.222.82.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EB11E4A4
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Apr 2025 18:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743617642; cv=fail; b=OJLjW7Mna+Ey0UcyQJDjjvYauXVMRF0pwnwN8384E/0IMCexWrn2SKDH1AK7zTQtd/ANOSfer/uFJQEhZgCDUGhTR7nHaVtR2vNVhVzOXn1v+EbZnPecFkyBCpizCyr7svTfK/MdkJ0nPI1LFk0V9547tzUyHqffte4TRadPbjM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743617642; c=relaxed/simple;
	bh=vsRd6HV0HXCXlPebFymnL4yroLUN+ejc4c0byL5fBaE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gee6Z50i+Xtb8mGjNSAwUBGyorG98HbF2opZNrpHXHguMX9Kfl2pGQj4gzlqZqHfzP27zCjOg/9dXN6INum3PyodMkGwIVK2+9BX+05f8MI5ih4TxNaIT60BHbgfTe0beOp1mZKoGjivwTf2X26yG6qKj+HBJcl4rliv7IAFkAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=Z5BdEph1; arc=fail smtp.client-ip=209.222.82.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2041.outbound.protection.outlook.com [104.47.58.41]) by mx-outbound-ea8-37.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 02 Apr 2025 18:13:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PyyJhiRqvkDMimxIm5nBSY7xyVrk5PJO9Td8bgurtvfOZppteEOOrJvdgvERCG1DpSRKDqGfJChRIyavWQxEglTD9E06VDwr3JvdrbiP9QmWpi51YvaGGZJmvuET/gEyhj1R6bRjHfq87hTm8WxQ8QoajRU+JDjv2okVqI7MwMxg3psMI8vykYCfRIykvsdCuHe7fZBxehHqgauFmOj+vr9AVV+j3Sz4zl/5T2bmH5yxDscbU8j60q3PvDBqxEPOSyGIVNHGDG2UsJzA+XAhu2R5fJ5K/41T7YbkVXa70NHfSDbWqCPnjAWVDyd1Q97JROyJka19saT5C/lvd78zpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bWw7OH2SZGmam1SNR6oqhA2eZLnJ6zQW8Ev7HZdxNz4=;
 b=din3z+bbvPRptEDUH7As5fCysiGyySpqfvTBRQ6vahmfDH3jHRCZOSl6nHZTNu0KzL0qO+RDNxSE8sJvELOmBc/qBYWki6z41FuER+AEXRMhk2o6RBH0Tjl+C1vvStwfoPrSFtSBi7gz0Ypru59qi6dJwxh8DHd9aexzL8zAHJsWVriyBroCe7ztfXh/HJvbpGAXsdNyEWfkziKfLgMs92oy3zfbbWlzYFb5YjRkv7RtZpAux6XjEPX92AiV5aRRYT/45FVfykDYt015e/RtdydF3ABtOHPJEen4XJLhKYGJeYZ9gzzHEQqHNkTkm7bqTWl1aJ7/pN9n5S025fkaSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bWw7OH2SZGmam1SNR6oqhA2eZLnJ6zQW8Ev7HZdxNz4=;
 b=Z5BdEph11QqZSwDiIu7DORZ7EfnobW+pBhzd2K+X0nZlc0R/rlkpChVBwwhhdVE547Aswc5YBUy8auUNlmzxnXDeuHFXZZ+tizPWAuapgK8Ir3gdKjry/xoigbruCtc9sHHQ6mBWcozhUI0PHjKf8/jaFbqA3fhpYlLD6x7A77A=
Received: from CH0PR03CA0390.namprd03.prod.outlook.com (2603:10b6:610:119::14)
 by SJ0PR19MB4793.namprd19.prod.outlook.com (2603:10b6:a03:2ca::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.50; Wed, 2 Apr
 2025 17:41:01 +0000
Received: from CH2PEPF0000013B.namprd02.prod.outlook.com
 (2603:10b6:610:119:cafe::ca) by CH0PR03CA0390.outlook.office365.com
 (2603:10b6:610:119::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.24 via Frontend Transport; Wed,
 2 Apr 2025 17:41:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 CH2PEPF0000013B.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.22
 via Frontend Transport; Wed, 2 Apr 2025 17:41:00 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id E331F4E;
	Wed,  2 Apr 2025 17:40:59 +0000 (UTC)
From: Bernd Schubert <bschubert@ddn.com>
Date: Wed, 02 Apr 2025 19:40:51 +0200
Subject: [PATCH 1/4] fuse: Make the fuse_send_one request counter atomic
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250402-fuse-io-uring-trace-points-v1-1-11b0211fa658@ddn.com>
References: <20250402-fuse-io-uring-trace-points-v1-0-11b0211fa658@ddn.com>
In-Reply-To: <20250402-fuse-io-uring-trace-points-v1-0-11b0211fa658@ddn.com>
To: Miklos Szeredi <miklos@szeredi.hu>, Vivek Goyal <vgoyal@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Joanne Koong <joannelkoong@gmail.com>, 
 Josef Bacik <josef@toxicpanda.com>, Bernd Schubert <bschubert@ddn.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1743615658; l=4149;
 i=bschubert@ddn.com; s=20240529; h=from:subject:message-id;
 bh=vsRd6HV0HXCXlPebFymnL4yroLUN+ejc4c0byL5fBaE=;
 b=abcMhdpPvadcD2yNHp6IOl4W5uqJ/ekc50COjKIM5PKz2m5UTYIGF6MYwr4ZFu1W+nO0Q60Et
 Wlb0/nKoRJGBWZNVotIT/OJTeQIsY2LpTLcGJhWTeWlGsnro6x5k6rQ
X-Developer-Key: i=bschubert@ddn.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013B:EE_|SJ0PR19MB4793:EE_
X-MS-Office365-Filtering-Correlation-Id: ed426729-3c01-44f1-0a32-08dd720d88b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?cVA4QWovV3VXSGtpUGFSTTBvaS9hUS9PNWxFTmJqakRKZ2R4TzVsZFdsWnRk?=
 =?utf-8?B?WjhudEhXZ3hWRGdvbUkzTUlNVEdiajFKRytZT1BjWm5VQ2UzOHp1Rml1S2Zh?=
 =?utf-8?B?c2lWNldaQ3VsQU05SExNQW9nUHJURTRNM0l3Z0ZpUWNXaTNSSVFUZkNtRGl0?=
 =?utf-8?B?dVl3Q1RlRmRsT1hnMHRNZ05ZeVlVMndNSDZMN25WajhoSkNpa1hXZHhMeDdv?=
 =?utf-8?B?L3lDcTNKY0Q5SThjRklOb1hlOFhUbU1kTHV4MjhSMVIyeHAvRlVsVm5JaVpN?=
 =?utf-8?B?RkVIOGx3M1c3cDJsV1lQM25YYkpwSTVSaVZWUVdJTCt2S0ZGRE5iMlR1UVlZ?=
 =?utf-8?B?UGN3Skoxc2daeFJWRGxaV1ZGVHkwY1MwSUVpUk5JYUJ1alhDVWw3S2d3N0Z0?=
 =?utf-8?B?MXR4ZHhYWEhndHprVHVjQzZYSWJqN1RFWENkS2lRbWRsTXJRTFBMQ0xGazZs?=
 =?utf-8?B?OGpBVXpvTG5zUWNGN1VZcGVSakFTaDgxZFMxSXZCUjhrcjB0ZWdOdFRyU21M?=
 =?utf-8?B?UFRGMXIzUnY4YWVWVWNJZ1ZzUzJDVWFpeGhnYlo2c2hIZTJzMytTUWIrbE5I?=
 =?utf-8?B?WldJcUMzZldzaWREWnJBMldvQU9zYlhnSzBCbGZkaENJSHZlazkvQzkrMGRs?=
 =?utf-8?B?dDAyVTdVSUM3ek1ITEYzb0FabGloTEhXazd6WUhpUmxkcktSSGgrUjRva2lI?=
 =?utf-8?B?WG5QYlB3S1ArUExVck56MTdMcXdaV04wSytQTVduWWVzL3ZSbmZWUGR4N3g0?=
 =?utf-8?B?RjQxWUwvSG1WdEM2blRUUWFXTDNYYjFKRnVVZ3pkdlFJd0Q1QlYxRW5ZdFhL?=
 =?utf-8?B?THBVZFI5enZ4Qmg5ejNnM0tCWGcrbUJHcHZwdWFMVXNCaThkTTArUVZOTGUy?=
 =?utf-8?B?TXlOSG1tYmVBTjlmdXEvTHNldFZXQStTS2REZmp3TzIva3JjdjVPN3c2T1dC?=
 =?utf-8?B?VUVHNHhES0kzUGNWNDBVZDlkeWczVHF2T1h0bE9USG1UNnpJbVJGMk85NHlm?=
 =?utf-8?B?OFFCamlWODhsYi9IelJpSDJOeEQ4b095NWtSYUh4R0RMQ0NKRSs4aGZkUUFG?=
 =?utf-8?B?WmFCcXhhT3cwc0IzQmJKcG1LT1JtOVpKbyswWVAyVjNDaFl5bFM0ZEQrNWNq?=
 =?utf-8?B?YTcxbFc2TVRPTk9rUEF3TVZpcXN2V0ZDbVp0bTlpbnR0UmJCbWIyQ0tFV2tr?=
 =?utf-8?B?dFR1dkhLODBraEFkSGViSi9LSW5EMlZBTE1zVTlSTXZHR2g4MGQ0QWVQVW5J?=
 =?utf-8?B?R2dLN1VXWGVXNlNPNEJoR1JyeG14TENUNTVjQWxSR1NNdjh4V3gxMEFnZnY0?=
 =?utf-8?B?MnJjME1VY25QRDU0blZqdGM0S0prMXN4L3Fya3RiYnB2UTMzZzlENlZ0UU02?=
 =?utf-8?B?Yk9HMVZsU2xibGVyVTFLVkoyMlJ1TzBZZ2N5VTdROWNVbmhCQ1AwVlhlcHVk?=
 =?utf-8?B?UzNDeitkVWtoU2NtVkJDWFV0RWNVT3JTUW1wbGwyQ2Q5V2hQM2I5SkNvdWpa?=
 =?utf-8?B?NkpHMUYrZ2NYb0M0cTVNYmJDTlV5TU5UaWlyK0dLM1ZHYmIyVm9JaGdsZWxL?=
 =?utf-8?B?MWdUQTFWMjVPVHlTRTErU0R2bkVJellTWWF2K3hTVHNzeFVFMStGbGgyWU9X?=
 =?utf-8?B?azNUbkRjTXVnRE8zcXhVMHgvb2tnQlRucFNjSUplVVNXeEExZUZpVDB3Y0VC?=
 =?utf-8?B?bk5xelFMNGh2YTRsa1FtNlZ4WmVwK3N6cTI2SStuMkNnM1orMFQ2bnJOdkhh?=
 =?utf-8?B?QW5ZZnFqV3dHVGcxVDhmZHA2dE1wbWFCdDlnOTdjc1c2OG9pS1J4cUlQTFh5?=
 =?utf-8?B?TVZVRHdCa0JVNGN1OFUzT3FBVmtHZzdrdmYyRWtROHU5UWtZMGNhUFc5L0Ny?=
 =?utf-8?B?ZGx6Q1o1bWFCTnFoY0VMaDhtdVFOK1FIaytIMWp0KzdzcTRLOEMxcWZzRkJG?=
 =?utf-8?B?TGNIT2YyTGhnNEdFRDVhWDlFZk5qa1ByVGxOeWw0V3hvaU5lSktZMVJ1Nzhi?=
 =?utf-8?Q?++dZTdtN0cHP1Mbj/4jLfOX8Orzbqs=3D?=
X-Forefront-Antispam-Report:
 CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
 cd4zi7mQaZU718EqMf3Ay8upi8lNwzMkHBvTtqqCkvvBIOTtGnpBA2hAh2KgvzqQMziWwsM9VJO2gBIXAqYbVywZgfgjWgGiNNleUz4PwMkN8XqABCmEV/uo+/1BxgNV2vZjlGirlOw6Yz6cDYvWWnD4dv96pl7MrvVSSn9exw7VF0yjQBBmfpHEy9YN07A0959v8TPS5Nx+9jBxBJkFuCtmdtik/s3FCrg6NZSgpVK0ecoOr8R2dAw9z9HpuxzarB02GmcjobXGlpfFW3BhMXDKmqjTqwcNdi0wZNUx7ERa6QrCC8yiaL8r2kCvrwv58cpVXsvA/aoG/GMNMa9NDwBHgtVmrfUHFNziaiAI47Njyp8LyHgq6i5TX3dwUEa0zJqUCrJnoxFL8JsN7DxCm8QAksfzR7V4D6zRBRrDBNz1WOIXCDyMLcSWCxuQXPQe+iagOXXBVIAcUsnlVuqQLfPI/b66bgSk9IpzPKZqxowXcIxE3Q8axh8DWaoRsjECnrlreHnXRKDYJ4mt+2sMdgULcDDXlvgYpQFt4bxfwFGUhgOnMbBH38wa6llSv4hvIMoUz2FYzvJbg+fLKVxodPWfBXWnsfAao7LJziCDC54yyqc1WGuxfO/oB9bmXbaVq6incFwYO0+pT28t172ycg==
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 17:41:00.8830
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed426729-3c01-44f1-0a32-08dd720d88b1
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
 CH2PEPF0000013B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR19MB4793
X-OriginatorOrg: ddn.com
X-BESS-ID: 1743617637-102085-5193-8330-1
X-BESS-VER: 2019.3_20250402.1543
X-BESS-Apparent-Source-IP: 104.47.58.41
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKViYGhqZAVgZQ0DDV2NjSwCzN0M
	LIwDgpJcXQzDTV2MjQyMAw1cTYJDFJqTYWAOwnx0hBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.263603 [from 
	cloudscan23-198.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

No need to take lock, we can have that in atomic way.
fuse-io-uring and virtiofs especially benefit from it
as they don't need the fiq lock at all.

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
 fs/fuse/dev.c        | 24 +++---------------------
 fs/fuse/fuse_dev_i.h |  4 ----
 fs/fuse/fuse_i.h     | 18 +++++++++++++-----
 3 files changed, 16 insertions(+), 30 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 51e31df4c54613280a9c295f530b18e1d461a974..e9592ab092b948bacb5034018bd1f32c917d5c9f 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -204,24 +204,6 @@ unsigned int fuse_len_args(unsigned int numargs, struct fuse_arg *args)
 }
 EXPORT_SYMBOL_GPL(fuse_len_args);
 
-static u64 fuse_get_unique_locked(struct fuse_iqueue *fiq)
-{
-	fiq->reqctr += FUSE_REQ_ID_STEP;
-	return fiq->reqctr;
-}
-
-u64 fuse_get_unique(struct fuse_iqueue *fiq)
-{
-	u64 ret;
-
-	spin_lock(&fiq->lock);
-	ret = fuse_get_unique_locked(fiq);
-	spin_unlock(&fiq->lock);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(fuse_get_unique);
-
 unsigned int fuse_req_hash(u64 unique)
 {
 	return hash_long(unique & ~FUSE_INT_REQ_BIT, FUSE_PQ_HASH_BITS);
@@ -278,7 +260,7 @@ static void fuse_dev_queue_req(struct fuse_iqueue *fiq, struct fuse_req *req)
 	spin_lock(&fiq->lock);
 	if (fiq->connected) {
 		if (req->in.h.opcode != FUSE_NOTIFY_REPLY)
-			req->in.h.unique = fuse_get_unique_locked(fiq);
+			req->in.h.unique = fuse_get_unique(fiq);
 		list_add_tail(&req->list, &fiq->pending);
 		fuse_dev_wake_and_unlock(fiq);
 	} else {
@@ -1177,7 +1159,7 @@ __releases(fiq->lock)
 	struct fuse_in_header ih = {
 		.opcode = FUSE_FORGET,
 		.nodeid = forget->forget_one.nodeid,
-		.unique = fuse_get_unique_locked(fiq),
+		.unique = fuse_get_unique(fiq),
 		.len = sizeof(ih) + sizeof(arg),
 	};
 
@@ -1208,7 +1190,7 @@ __releases(fiq->lock)
 	struct fuse_batch_forget_in arg = { .count = 0 };
 	struct fuse_in_header ih = {
 		.opcode = FUSE_BATCH_FORGET,
-		.unique = fuse_get_unique_locked(fiq),
+		.unique = fuse_get_unique(fiq),
 		.len = sizeof(ih) + sizeof(arg),
 	};
 
diff --git a/fs/fuse/fuse_dev_i.h b/fs/fuse/fuse_dev_i.h
index 3b2bfe1248d3573abe3b144a6d4bf6a502f56a40..e0afd837a8024450bab77312c7eebdcc7a39bd36 100644
--- a/fs/fuse/fuse_dev_i.h
+++ b/fs/fuse/fuse_dev_i.h
@@ -8,10 +8,6 @@
 
 #include <linux/types.h>
 
-/* Ordinary requests have even IDs, while interrupts IDs are odd */
-#define FUSE_INT_REQ_BIT (1ULL << 0)
-#define FUSE_REQ_ID_STEP (1ULL << 1)
-
 struct fuse_arg;
 struct fuse_args;
 struct fuse_pqueue;
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index fee96fe7887b30cd57b8a6bbda11447a228cf446..8aea23ffaf2fa44b284d4efef1e009fb1ca876a0 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -44,6 +44,10 @@
 /** Number of dentries for each connection in the control filesystem */
 #define FUSE_CTL_NUM_DENTRIES 5
 
+/* Ordinary requests have even IDs, while interrupts IDs are odd */
+#define FUSE_INT_REQ_BIT (1ULL << 0)
+#define FUSE_REQ_ID_STEP (1ULL << 1)
+
 /** Maximum of max_pages received in init_out */
 extern unsigned int fuse_max_pages_limit;
 
@@ -490,7 +494,7 @@ struct fuse_iqueue {
 	wait_queue_head_t waitq;
 
 	/** The next unique request id */
-	u64 reqctr;
+	atomic64_t reqctr;
 
 	/** The list of pending requests */
 	struct list_head pending;
@@ -1065,6 +1069,14 @@ static inline void fuse_sync_bucket_dec(struct fuse_sync_bucket *bucket)
 	rcu_read_unlock();
 }
 
+/**
+ * Get the next unique ID for a request
+ */
+static inline u64 fuse_get_unique(struct fuse_iqueue *fiq)
+{
+	return atomic64_add_return(FUSE_REQ_ID_STEP, &fiq->reqctr);
+}
+
 /** Device operations */
 extern const struct file_operations fuse_dev_operations;
 
@@ -1415,10 +1427,6 @@ int fuse_readdir(struct file *file, struct dir_context *ctx);
  */
 unsigned int fuse_len_args(unsigned int numargs, struct fuse_arg *args);
 
-/**
- * Get the next unique ID for a request
- */
-u64 fuse_get_unique(struct fuse_iqueue *fiq);
 void fuse_free_conn(struct fuse_conn *fc);
 
 /* dax.c */

-- 
2.43.0


