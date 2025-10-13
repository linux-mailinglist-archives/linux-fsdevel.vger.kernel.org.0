Return-Path: <linux-fsdevel+bounces-64004-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F81CBD5903
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 19:44:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F6063A7270
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 17:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D58F306499;
	Mon, 13 Oct 2025 17:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="BmQFUUXN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip191b.ess.barracuda.com (outbound-ip191b.ess.barracuda.com [209.222.82.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C65419CCF5
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Oct 2025 17:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760377329; cv=fail; b=uK2zsS5vZcumzqCBxXPEy1+WzN3uZxRwiwFDcrNS/+FKeHFKW/i3ELKH3yK+HSyAwdTHzQuqqDE5+FZ8zp3CzlgpS/yM6aVJXJA0JhH3t7gNHWSv1pHoCttXWoFMVDNqMqF/QctEK5s7/UUOhsZWPzTOrJv/VmOFC9mGzpl9g+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760377329; c=relaxed/simple;
	bh=vR0IydQc2W32EagVU60/mB9LqQAxm93ENywAKRoDKEU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ToHhs25QZFtEM8jYYMJ9iOti4m8CfhiQ66wIRbCaFp1VErmsPa/j+RC6IfLQxKVidCQZOYZxceqjbvCN5RUGvhZiLqSCKQPOG/By6OPtYNaWa2tGNon0e2XkPN2nWeaSMsTyGemLqWT6zJvymirNzjXqyWfIc1JUugYbmA+nSWk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=BmQFUUXN; arc=fail smtp.client-ip=209.222.82.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11021077.outbound.protection.outlook.com [52.101.62.77]) by mx-outbound22-166.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 13 Oct 2025 17:42:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qPscLBYG/qj1lyNL3wCyWgpO0Hm5U4mDAMBO/Wi2bsY5bjIF31Hkg8N1maKvmYgUbtRgiugLlf9mCqcs8iPRA7+yXKWgbpP6m6GONTJfftUPGJE6DZYpjYRLG3KlrhP35H0TupaRx4wVfLPJ88nyeSWDtCqNfRpbipwcPV/wdVVdNmd0qW27Y6y9Dw2WHA8u2S+cbX0ttzqLktI1Swo4H8KgT3p3QTOVFMKuiBILriGCr/DM9qRhVMpNIrYg+ERp8PZ90PWbHBFlHym9Jlsg/Gv1+GjFzkUfD5FK4unXiJjWAMxJKJ5HPsdxtbDToxlhn4fumjykYRsk4ETZlQmRig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oBqey9F1XpvMN9fLr838M2vlpiXYxEVh0W937WwRjvw=;
 b=v1poq1wikV0usgEnGADTQwmd30Btw4pU9LhDNTHQKNi87WRsPlsa3zFvgGppU9/Xt5Rq3ogCC5Oh40ec1QGST1hBt5UJ635bmZB/2tviFegCQrhRHAVe1xqTnbvopPSXAjJzTX64xXILIw5d9JdVRhNOUYOVUeKhhI8W25l2/0FW5+vb03O41gH7m8mivdCiuvjFHTvzbyuSbywHbV1gRJrbMU5+OuZDYioIDXzu5NTSmZtIMZN46GoLw0ams/ti0BZ3f0D+N3yAzr3ObgMRllAaKG0RUsYAiSmTees/gHVc3toXRo64x5LMHz1lIn3GqcvIEmUSne5t4RrOzcHHiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oBqey9F1XpvMN9fLr838M2vlpiXYxEVh0W937WwRjvw=;
 b=BmQFUUXNF+X3eWtJYciZnXRcg5sXyoQ6Ek5BQeiKsvFylPvu9CCYup86ldTgMjqwbrco0lsVRgJCTXQMOz2DhcQ/DzkMIhS/gZbURBOi0kNIy6w9EYV6HttucuHeLZpbiInWupm95utXW7TjpYUrBVHu/RsPIplxhngCVcdNdRI=
Received: from BN9PR03CA0470.namprd03.prod.outlook.com (2603:10b6:408:139::25)
 by PH0PR19MB4972.namprd19.prod.outlook.com (2603:10b6:510:96::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Mon, 13 Oct
 2025 17:10:03 +0000
Received: from BN1PEPF00005FFC.namprd05.prod.outlook.com
 (2603:10b6:408:139:cafe::8) by BN9PR03CA0470.outlook.office365.com
 (2603:10b6:408:139::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.10 via Frontend Transport; Mon,
 13 Oct 2025 17:10:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 BN1PEPF00005FFC.mail.protection.outlook.com (10.167.243.228) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.7
 via Frontend Transport; Mon, 13 Oct 2025 17:10:03 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id 23C2963;
	Mon, 13 Oct 2025 17:10:02 +0000 (UTC)
From: Bernd Schubert <bschubert@ddn.com>
Subject: [PATCH v3 0/6] fuse: {io-uring} Allow to reduce the number of
 queues and request distribution
Date: Mon, 13 Oct 2025 19:09:56 +0200
Message-Id: <20251013-reduced-nr-ring-queues_3-v3-0-6d87c8aa31ae@ddn.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGUy7WgC/43NTQ7CIBCG4as0rB3Djy3UlfcwxiAMLQupgiWap
 neXdqE74/L9knlmIgmjx0T21UQiZp/8EEqITUVMr0OH4G1pwimvqeQcItrRoIUQIfrQwX3EEdN
 ZQKPNRbZW21YqUs5vEZ1/rvTxVLr36THE1/ops2X9A80MKGitUEiNrcTmYG3YmuFKFjLzD8MoF
 T8YXhi5484xrZyp1ZeZ5/kNHZtn1gUBAAA=
X-Change-ID: 20250722-reduced-nr-ring-queues_3-6acb79dad978
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Joanne Koong <joannelkoong@gmail.com>, linux-fsdevel@vger.kernel.org, 
 Luis Henriques <luis@igalia.com>, Gang He <dchg2000@gmail.com>, 
 Bernd Schubert <bschubert@ddn.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760375401; l=1962;
 i=bschubert@ddn.com; s=20240529; h=from:subject:message-id;
 bh=vR0IydQc2W32EagVU60/mB9LqQAxm93ENywAKRoDKEU=;
 b=f445X0QApXuhDOFBxTHVgTsFCg9b/pU2chbzEWwfvwsO7N/k7LETujCL28mu2aXuvAQCVtnwU
 W33TBFxD5PgAi5SX06sD4ejbDO5kx0lRFTSrELT9zwsE9uw+MX49VhI
X-Developer-Key: i=bschubert@ddn.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFC:EE_|PH0PR19MB4972:EE_
X-MS-Office365-Filtering-Correlation-Id: 28534dd3-53c2-4c7a-03ee-08de0a7b59a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|19092799006|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?ZW45Qlh6UGZTS0ZFWm84OXBDeFJpYk53MUJLSDFwUHZGVUF6ZkdJSHFoRk1u?=
 =?utf-8?B?dUhneE1VM3lzWlU2ZXhMTHZEZXcwWmdSU1dkbTNnaGI2bW9kTFNPVGJoRVJw?=
 =?utf-8?B?T0E1VFJEWnZNZmNYNDJvcFJqOEFiZFFZb25lekt1NlBXd3prUUVqOUFvVm5X?=
 =?utf-8?B?T2RvZENNMlJNb3dpemtwN24xazdPSzk5ODRTWkR5MDlyS2R5RUFKaGw3MlJs?=
 =?utf-8?B?WjJpSTE5QnY0NUpka1pLUmJyZFFNOGsvb0V6aHJ1ektPZER5cGt5VHJFWnBM?=
 =?utf-8?B?MU9xRUNrMnl0bUlSTkJZbGNMWnlNUGxsb2p6UzFHc3RpSFJXVXpNQzlmZUVa?=
 =?utf-8?B?WGRiTTljMllWKzRBM1JRYUhzQmZib1ZjT0FTR3VheVE1YWFacG8rMGVEZFF6?=
 =?utf-8?B?SjNENEtYYzVERzZETUx5eWJGVSs3YWkxd3M2ditzdGZPVHRmNmN6K2JSWVdy?=
 =?utf-8?B?N204NWprWlgxUFRsVFY0d0NLZmo0bG96MzJ3d3RDS0xCclhhcWVBQzhueXZu?=
 =?utf-8?B?aDBvb0kxTlExTG5SdkVoR2JjVWg2WkNOZVhyTUZ6eGhETkNSNDdWSUJub1V0?=
 =?utf-8?B?YTRobE95c3IrZEtESnBkSktHSEhCRjJtVFRxZUw3S2hnbzREREgyTEp6elp0?=
 =?utf-8?B?Q2pZR2Z0MTdDT0VaRWtZdkZHVDYxaDdIL3FYNUllOXJUSlVUOVdOZXp2bkwr?=
 =?utf-8?B?QnlaMThobzJEcXg3OFlmWXBhZFVNM1I1TWVnU0Z4b2JKZWhXcmROV3prZmZ0?=
 =?utf-8?B?bm9EbjFwaUlBUm9lMFRrK0dXdGQwQ0M1OEcva2NwMk9nYWx1SU9OQlpxN0ZZ?=
 =?utf-8?B?dTNrQXN3UHkwQWxuLzBsWkdsbEppN29vYjl2RFFTeCtSYjdqOFkwdTFMbGVo?=
 =?utf-8?B?WkJwbmhKYVprVklDZ1BPS05LWElzMXVnYVAyU09QcEZyRTZmYnFMcmZ5MEc1?=
 =?utf-8?B?WTJTcG5FVXVVcFdYcEZnS0I1dTVjamJ3a1g1U1l2akpqS3BYU3pzaFc2aTN4?=
 =?utf-8?B?bXB2ckRySVp6aGQzYjRQZUZjM3ZpZzBSOEszUDdkNitncDNOVEVqamVVbEdu?=
 =?utf-8?B?RXFVcUFHZ3hGL3IzMFQwYW5IdHowdENadjZ2VlRjS1lsMTVMUG5sQ29YMlM4?=
 =?utf-8?B?YTdNMmQraERRM0R3RzRKalB5enZCRXVYbk1xcFpmYkp4VkNuUDJ0NVpuQzlF?=
 =?utf-8?B?MWt3ZWY0c1hPeU9DaytraW5CVDdEQmhQbUh6STVQQ0phc2YrWVNXODVDK2U3?=
 =?utf-8?B?WTdiaTUyUHp5Zjh6TnJsblU1T2VmeDZwWW5WdDJEUnRuTkVXTGlSS0NzVThw?=
 =?utf-8?B?dm1hdTRnVW1icC9DSk5RWUtvTWx2bXFRQko5Mlp3N0hRUzRBOXhyZ1pBcFR4?=
 =?utf-8?B?ZHd3dUhhbjBKTUhZL01LNkg1VGowSnlWQUttQ1NxYzg0QUZMeThUeXZSOCtj?=
 =?utf-8?B?bWRMY0g0Sk1iWkNFczd4aUorUzBhbHFXN25WWnU0eVZ6ME90Z3V0UmZMMHRF?=
 =?utf-8?B?MzJCZDNlaWYrYTBPK0VNa05kVzR5cWZaV3hhSzJRNjV1SHd3SVExcEJqd1h6?=
 =?utf-8?B?Z2t0Q0V5bFdUczY1ZWJGenVmTjN2Z2dacDZSbGp4RWlVYmhhRkdiT1QzOU5S?=
 =?utf-8?B?azRHRnEvSUg2Y0VMSCtKVWI3NjNuVGpzcVdUUHJaOE5BOHloLzQxZHE4SXNk?=
 =?utf-8?B?cDgvQ3VTTW1GRWpjZEJscXRXQ3ZQdFpkZmdiRmZIcEtOUm5CUlZhbS9KenZ4?=
 =?utf-8?B?V0hHaVZGUUkrNnNJV3c5UjJwQ2dsTmlrc011VFI1aUFGVWl2SmZiTFpJODFq?=
 =?utf-8?B?dmNYREJvSlJHcUQ4SDQ5OWhXT2Vmb0JsaWUzcGtibWhrOGpRR2NPd1liZWtR?=
 =?utf-8?B?TWx2cTRFSGt0UjZtbWYrS0xDanJ2SVVJQ1FrbEE2YXRXbndCVm9yQ0JWWitX?=
 =?utf-8?B?RVFmdWdSaUNXNzFJbTJBRXk5em1mWG9CSk1acjdUWUlwdjMzQnhNL3hMSHM1?=
 =?utf-8?B?WjcvZ3c1T2NjSGFRUXF6SzA5dVk5d0phTDQvZFkvcmdoTE9WaStENmdxcWNT?=
 =?utf-8?B?czJGeHM2WlRqWFZuWEN6czh0cFM1MmE0L2c4MlF2MnZ6akNTbnhHMkljTEhv?=
 =?utf-8?Q?C1uw=3D?=
X-Forefront-Antispam-Report:
 CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(19092799006)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
 6RhusYFIBWNn16brxPTC3JHBXFDV2Hm1506Iu71i1cwe0l5dmiNuoJ2w3beOta0wqMQzjlt54WozhZrgIyE7ip8Zr2cedBj/oDZvzndZlgXV4m45MJzkYOyCUjPDE33NWsMaNqTPVrIu0ueGjd7HedBGx7Z0sAB6BMqrDbpEVU4tSvb0WugU8jWYuviYM4B3nN1Krz01RgrIW30ES9CSrV5VvF+RagHWTrpTjrrCfc9bXvpmP2kaXfl5LEi/oYVdCeeHEZypf/xjrprcrSAJrzXY12TpNug05QIF0dKxk9C0Pohqk5wNnGqngUE4gQTZzS6AiIfHiIr+zLm9XUQhovwuYjDy7QA+nOgDUwX3x+sFM/9XCiadpgo1KiKfrXhTG7hzBri98mU/sw7yQXh/L6Zm5G6sSF//Do7ELonwAi/CLyiwji678bHsWgkSCFz5xY3JHqpNDWTKoiAFLnFx95M/eN5gcjHqCeGOzotMUwbi071I7WRW263D2sflfxKA+V1i1G7mIn2OHbtsPjnoqSaV4Wk/QgkQinJv9fBVl70VgTjlF/kda8x/G7IWmk8vfDyzNjcaJVsJ5mvvG/5ciVKt/9M3DDUpPImRM+vsKd4wBt05up4odpvd6KHySUVJYAonQCv4Ta1oqJmhvliGaQ==
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 17:10:03.3098
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28534dd3-53c2-4c7a-03ee-08de0a7b59a6
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
 BN1PEPF00005FFC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR19MB4972
X-OriginatorOrg: ddn.com
X-BESS-ID: 1760377325-105798-8494-12500-1
X-BESS-VER: 2019.1_20251001.1803
X-BESS-Apparent-Source-IP: 52.101.62.77
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoaWhhZAVgZQ0NzU0sDIwNzQ0i
	LZyNQ01cTczDQtMdXU0MjEOM3MIs1IqTYWAMx/4tRBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.268182 [from 
	cloudscan17-139.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_SC0_MISMATCH_TO, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

This adds bitmaps that track which queues are registered and which queues
do not have queued requests.
These bitmaps are then used to map from request core to queue
and also allow load distribution. NUMA affinity is handled and
fuse client/server protocol does not need changes, all is handled
in fuse client internally.

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
Changes in v3:
- removed FUSE_URING_QUEUE_THRESHOLD (Luis)
- Fixed accidentaly early return of queue1 in fuse_uring_best_queue()
- Fixed similar early return 'best_global'
- Added sanity checks for cpu_to_node()
- Removed retry loops in fuse_uring_best_queue() for code simplicity
- Reduced local numa retries in fuse_uring_get_queue
- Added 'FUSE_URING_REDUCED_Q' FUSE_INIT flag to inform userspace
  about the possibility to reduced queues
- Link to v2: https://lore.kernel.org/r/20251003-reduced-nr-ring-queues_3-v2-0-742ff1a8fc58@ddn.com
- Removed wake-on-same cpu patch from this series, 
  it will be send out independently
- Used READ_ONCE(queue->nr_reqs) as the value is updated (with a lock being
  hold) by other threads and possibly cpus.

---
Bernd Schubert (6):
      fuse: {io-uring} Add queue length counters
      fuse: {io-uring} Rename ring->nr_queues to max_nr_queues
      fuse: {io-uring} Use bitmaps to track registered queues
      fuse: {io-uring} Distribute load among queues
      fuse: {io-uring} Allow reduced number of ring queues
      fuse: {io-uring} Queue background requests on a different core

 fs/fuse/dev_uring.c       | 260 ++++++++++++++++++++++++++++++++++++----------
 fs/fuse/dev_uring_i.h     |  14 ++-
 fs/fuse/inode.c           |   2 +-
 include/uapi/linux/fuse.h |   3 +
 4 files changed, 224 insertions(+), 55 deletions(-)
---
base-commit: ec714e371f22f716a04e6ecb2a24988c92b26911
change-id: 20250722-reduced-nr-ring-queues_3-6acb79dad978

Best regards,
-- 
Bernd Schubert <bschubert@ddn.com>


