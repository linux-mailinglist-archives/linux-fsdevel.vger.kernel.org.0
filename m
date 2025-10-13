Return-Path: <linux-fsdevel+bounces-64011-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7BEBD5C3B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 20:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CAD9135150E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 18:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4B32D781F;
	Mon, 13 Oct 2025 18:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="tkO5iX66"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip191b.ess.barracuda.com (outbound-ip191b.ess.barracuda.com [209.222.82.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1859213957E
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Oct 2025 18:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760381108; cv=fail; b=ReuMvcPGBh9yHIsMR0bc7Zz7o4iXHmGkE1iSSwerK61Crl0F7ZFCFzIJtIIMIgg+vnsUqEi+vLtTJVW1bjEvumojG94Gb0lQOpiWndnrOOK1lEBK+IW6teDI5/r2WITy7klq138hSnB7ZnjVG06b1VpOjFLfLdz78j9sb40sZKw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760381108; c=relaxed/simple;
	bh=+Y0nzIDQVBcneV12z6JMqlJ+X/H1+CXEMjLzYheQVnc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FIe40SRCblcQBeicVsSosfadtAY8U5V1+NdqFt5Pd4W1e6bstIzNSANcXaLb+e4oWHM4lNHqIkT5p5S2lDNiwX+qkvftv+WR7mD9QP25dxz7eOKUVUaxeAdqWELlYku+zJGG9jptxS6oIqCRuPzX/tzOAOxqf+ahSz2fT1eT6T8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=tkO5iX66; arc=fail smtp.client-ip=209.222.82.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11020077.outbound.protection.outlook.com [52.101.46.77]) by mx-outbound16-186.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 13 Oct 2025 18:45:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AXVWSw1GA8FNlOVBf8MowaYZSYGKx4GAArmSJY/nZAqifgxQBOw9ugwoekXJ6/sW3XXpR/A6MVV3mlYfif0sjqvjgdceOkBmcCmelcJjYvmkqClhzdlyMicKTKBe1YFhyUjeWu0jxrs3uv+7eJ+iEV1Ju/NEwhqjrwf08I077nRn5Uj5qSw5erRlHbnTeIUxIXvuwEbC3EzgNfxffSc1mqi8HJ+yu0sa/d8OTm9vvv8N984CoDCR43v7BbvN9ZzE4vNqzzlKNBm7Jglr31A3Qw1S72i25bh3aTmuV0yJUJuS8T9aJfxczfIowVm/GghMIXUFcgkwsvNTLPzeDHNasg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BThhJU0a+ZXITgjt9zRtpGV4NsMBKdhE7zys5nvNY80=;
 b=NC1Tyjm0FOlcwD/Si+4z44qzHa+qinF5j2W2FulrFxFlqbLSfLx11yyqX/9D7fvakF8ZPQzh7TfFA6NGyuJA/DyTYYp0c1p9xmrjlqQWMIpRoEOhDVjHkYDRZ78XPe+UuRyYCOMZPGui0xeobWaDg7XnSgqDluOCwpoyZfktYOyZnwGgL+H76AGveFch+8OYd1vmrLuYhTDD9+kaFxxYBtigYTkSk6qDmcGv9j7a1/qldsVrYP1y7qzuZqjZz24kHnR1CH25+U5dz0cw0Q2/IONgC23J1AuK3YWxsZBukIBmw/iKCevDam8CpsbbNjTY/9JYo0BhwImYVpnVUduWLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BThhJU0a+ZXITgjt9zRtpGV4NsMBKdhE7zys5nvNY80=;
 b=tkO5iX66kcxT2cHFpI6PVuad1GpEcrEtS7sZU09FR/fgrOG89lexyIWsUVVWi8bh/qDSCKsw3DzbP2R4ur/8NZML3GdHoniECHaKXRZ6rzYgOnwT90v9ZoA9RU+fo2wkImjCQOPA9cGnV+raSklrugjOaKZ427fQntu8YPN0vHU=
Received: from SJ0PR03CA0055.namprd03.prod.outlook.com (2603:10b6:a03:33e::30)
 by BL1PPF728805D7A.namprd19.prod.outlook.com (2603:10b6:20f:fc04::eb4) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 17:10:04 +0000
Received: from CO1PEPF000044F4.namprd05.prod.outlook.com
 (2603:10b6:a03:33e:cafe::ad) by SJ0PR03CA0055.outlook.office365.com
 (2603:10b6:a03:33e::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.12 via Frontend Transport; Mon,
 13 Oct 2025 17:10:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 CO1PEPF000044F4.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.7
 via Frontend Transport; Mon, 13 Oct 2025 17:10:03 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id 20BEE81;
	Mon, 13 Oct 2025 17:10:03 +0000 (UTC)
From: Bernd Schubert <bschubert@ddn.com>
Date: Mon, 13 Oct 2025 19:09:57 +0200
Subject: [PATCH v3 1/6] fuse: {io-uring} Add queue length counters
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-reduced-nr-ring-queues_3-v3-1-6d87c8aa31ae@ddn.com>
References: <20251013-reduced-nr-ring-queues_3-v3-0-6d87c8aa31ae@ddn.com>
In-Reply-To: <20251013-reduced-nr-ring-queues_3-v3-0-6d87c8aa31ae@ddn.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Joanne Koong <joannelkoong@gmail.com>, linux-fsdevel@vger.kernel.org, 
 Luis Henriques <luis@igalia.com>, Gang He <dchg2000@gmail.com>, 
 Bernd Schubert <bschubert@ddn.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760375401; l=3159;
 i=bschubert@ddn.com; s=20240529; h=from:subject:message-id;
 bh=+Y0nzIDQVBcneV12z6JMqlJ+X/H1+CXEMjLzYheQVnc=;
 b=4q+zay7Slpw7/uNK36egr1AEA7piAdct8IzRGM/QauJ6vnd1iObDQSC9I5CkdRAEtSjTwENig
 CCV/94rOEgABsCJfXQZ78rJuFTXoa3Z6XfRQuVnip5aWoTNm4fzKy2L
X-Developer-Key: i=bschubert@ddn.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F4:EE_|BL1PPF728805D7A:EE_
X-MS-Office365-Filtering-Correlation-Id: c99f0b60-d969-4dcf-7ce3-08de0a7b59fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|19092799006|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Rm9HY3A2U0pjSmdyZmcvZnd2MGlITDBOVWxGWnVubDU5S2N5ZUI4SzV3Mi9X?=
 =?utf-8?B?alFBdW5neGxMT1BPYzhTclZPWVE0SDMzbjVhQ1g1bldJMmZsVDhwS1JmYWNV?=
 =?utf-8?B?Ti8rY3AyaWhQOEx0U1NoTFJ5NldVVzlBZUI5OEhZbERzdmlzSDhEM3JZOFRG?=
 =?utf-8?B?eWpsL0xIbW95TFhyMVhxVFBEeEdIVW5TS1RSa3QrbjA4aFhhWHVjN1liako4?=
 =?utf-8?B?SkJ3eHJnNkRRdFd5alduVFZjQ0ZPVTZlM3VvWlFZNGgrQXcxUnhEVktJZGxM?=
 =?utf-8?B?UHJqSW8wNldpV1BXKzRkKzZDOS8yYnNJNXZaSVlqa0NlRHA4Vk5pQTJ4S1Iz?=
 =?utf-8?B?am5QcEM0VEgwUUpsRFVZenpTeUVqS2pBWHpwMzZXTkNOWktxcitxakM5d2F5?=
 =?utf-8?B?OXBoay9vUWhUMzVodUk2NzR3aWtxNFhod1RBOXkxaFk1TFRwclJzaVpUaUl1?=
 =?utf-8?B?ZUJidzI0Z1FITytRS0Z5TkFtcCtXSTVKd3krVkhRRk1FMThuSllNTkowYUpi?=
 =?utf-8?B?NmlrNkp4Y3JVU1NBL00ydkRxVW51OFhxRk9haE1TNnZZQ2o3b3Nqejk2Q2h5?=
 =?utf-8?B?Y1R1R3pnNllPTkYydGJDc1hldGptZExkdHpiN09kSldvVHhkVUJNRDhwZTFu?=
 =?utf-8?B?dU9wYXpXWnlkeDM2OUxROG1Qc05hTkJWeTVYOElESFlUME11NzRJVWZvZkh1?=
 =?utf-8?B?aThFbzlObUpBc00zTmdVdzFsL0hPWVpxWHJkeFFsWW4vV1pjQVExaTZLMmQv?=
 =?utf-8?B?MTlBOVhJN0s4dFJKak1Ia1UrOXF0WFRkSG9TSTVVak0rVlJhTUEzYS8xdmV1?=
 =?utf-8?B?YzNLT0sydmtYZHE2Y0ZOWXZxRmpHTk1DOWRhazU0OWxvdWVtZlhsV3FVWW1z?=
 =?utf-8?B?eHkvalJoWTkxT0R1LzJuL1VWUWtDUWM3cFlkMldNeFVEYVZZTVhWclBnUjhj?=
 =?utf-8?B?NURUSVNwOGdiblBMeDAwelRsU012M1NpTTNWS2pQY0h6M0lZVmNnUmlqeTBL?=
 =?utf-8?B?ZzdIRkNqVENta2F2OTRFZW11ZStDYWN5K3pCSWp2RFlra3FqS3JkR0pZZnUw?=
 =?utf-8?B?dURDY1UxMjZlTzdhcGZjdjByNW1vZCtIQmlsb1BQWnc4OEhiaTlJQWlFN3Z5?=
 =?utf-8?B?WDlYZW96WnV1MVZqUzF0WGJsZ0pEVktNY0hKT04ybG1JeGRIblFIV2VzU3Z0?=
 =?utf-8?B?dE11d1VCQUtEQU1JT1d1ck9waEl5azg1SGtoeHA5U2F0NWppcytocjMwOEdQ?=
 =?utf-8?B?WUNvUndYTXZKOVJPdlk3TzNkSXhZZHJxS2VaQVhhRjkyRUE3OStOOXhwaGxs?=
 =?utf-8?B?azNreDVFekY0eGVJbGtBN1IrcDZ2bDNtMHY5TkpkRU1sTTR2SERCYXczREt6?=
 =?utf-8?B?MzRsdnV6bVhHNHNKNHc1TDIrYmdCd01GS2NyZlVNTTlHZHU2Z3ptdU4raU9J?=
 =?utf-8?B?eHBLUzIwQ2NvcEQ0cGlZbWJYTmhEaktYTHl2Qk9DT1BmcnUzT1hkcnVqTFZZ?=
 =?utf-8?B?T010TGZZSm81WVZINnQwQmhQZmljODFScGxtdmdkNW8wUXZpMFRaVGRZcTdD?=
 =?utf-8?B?LzhEeU45eVJ2anREdjFaUDlMQUVJNnZURENyWWxucjdIcFQyRmJEUFMxL1Js?=
 =?utf-8?B?TmJPcmdUM1lLL1dWY3JxMU5rZHRpVytWUHoyY3drUE1QeUF2SktBc1NVelRs?=
 =?utf-8?B?UHZPTytnbU9VOW0yWlFoSHhqV0t4ZVg0TjhLYm5xT2psZ2ltQjc3ZDIvUGYw?=
 =?utf-8?B?eFN5S2toMXBJbXBlNTdDVmJnM0R2TGRNUjlPTW82SWIzOUo2S0x0WHdGQ1M0?=
 =?utf-8?B?ZitrVmRYWUVqd3JCZ1hJYTQwTFh3VzJpNlFTeTZ1d09OdWxOdERXYnBhTVAx?=
 =?utf-8?B?UDRmUDFPa0JrVGpycm5CdTVGektublBxRVMyYUcyVkNVa0p6Tzhpd1ozM3VS?=
 =?utf-8?B?S3FQanJkS08yUWd2T0p0Q0RkMU52SndSdzI1YkEwbjA1RHF3WUJkTnJwdE5y?=
 =?utf-8?B?ciszOHgzL3VIcFBETDdlMXVUZ2dVRm5BNzBBVWtMOHdZSDVxendib3lYRHZX?=
 =?utf-8?B?TkhXMndQbXViRFc1TGhGcnVEM0J3Qnkybk0vVVJWM1JrcnlSYllGTWM2bkh3?=
 =?utf-8?Q?cyoo=3D?=
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(19092799006)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ha03W2rxlY7UpCIx3rW/L17Ytvj+vSO3R3kcjmgkfu2DU1Q5LdGKkOc+bEc9eel/J+RhQ8XgPLKGH5uzTHyhsGr/7ISMHSlMAGd1U5IMnucqjwjWA8IJ5fiwDeQRvprQ3kqc6B8EQoWiBKSPGNc0B/oz9Q6CqS4LJbiu0bgpuyIV095yz0opjSSVFTaMXQGd0PFuve7JNP8JLpvb4urn+GmriiKGo2MZ6lj9l7buP58EKST7wKRQzwr0mSYa+dLBWOWX4l/Nzkh851VNKGUPtTwxTaZOprM6yny5hRZodq1nipv6ZYh7YHJEeZ2SJy2Ia6lSYvIrvbaLSxpWxkUKL+xT7qf0XOPKDT4HwHLihHB1Md+NlSJTH3TfzaGoDrlTALDePQXUHfJuL3XlZy7An/ZNLRG4yeqGBVyw1U3lm43EtUc1YfyKCvFU2WTrdWyLWCfmHS++WZYJo0XNjJQj1NiphShOWS52m412Kisq78IsPmWoVwM5ZihrrT8LUTS9umgTiZwtKFYU7oxJTDhChTGNoIx5X81wE5UDORmOjonElsRGGmwcHyYXRwjg4EVeOxDqrGFFoBkMfA9sXz1lI3dPDfYqZL+FZsLd4WldQ/PciTuPU4U7TLrH94Er1FmbFJbUz/0BC9fWO6qzhJHc8Q==
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 17:10:03.9296
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c99f0b60-d969-4dcf-7ce3-08de0a7b59fd
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PPF728805D7A
X-OriginatorOrg: ddn.com
X-BESS-ID: 1760381105-104282-8512-7022-1
X-BESS-VER: 2019.1_20251001.1803
X-BESS-Apparent-Source-IP: 52.101.46.77
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVsYGZmZAVgZQMNXcPNEgOdHC1N
	DUwszQ2DApydQi1czMwjQxzcI4zSBRqTYWACSjjN9BAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.268183 [from 
	cloudscan15-199.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
	0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND, BSF_SC0_MISMATCH_TO
X-BESS-BRTS-Status:1

This is another preparation and will be used for decision
which queue to add a request to.

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/dev_uring.c   | 17 +++++++++++++++--
 fs/fuse/dev_uring_i.h |  3 +++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index f6b12aebb8bbe7d255980593b75b5fb5af9c669e..872ae17ffaf49a30c46ef89c1668684a61a0cce4 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -86,13 +86,13 @@ static void fuse_uring_req_end(struct fuse_ring_ent *ent, struct fuse_req *req,
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
@@ -112,6 +112,7 @@ static void fuse_uring_abort_end_queue_requests(struct fuse_ring_queue *queue)
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


