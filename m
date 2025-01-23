Return-Path: <linux-fsdevel+bounces-39977-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E96A1A838
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 17:56:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8BE2188BF93
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 16:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F9F2116ED;
	Thu, 23 Jan 2025 16:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="OVCKxX6A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip191a.ess.barracuda.com (outbound-ip191a.ess.barracuda.com [209.222.82.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3D2145B03
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jan 2025 16:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737651350; cv=fail; b=MYFFkMO7o1XsHfwo1/snJirfWqq0Aiq+U2bOD0BAZ+d+8LCna8BnpgKIFcrTyY2VK3MJAuMVtsKtLnD3gylRDdHPBoMamjhqNX/AtCjJ6JrtEUmzyxet4io5Nn55Jz9V4bsINEJ/XRIk3ZObB5pJ5MkjaeGHl3Dvb4UiY2lmwyM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737651350; c=relaxed/simple;
	bh=vJiSTPcDjBuPe0BbCVIsUueQRN8D+nxOgr6/skELfv0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AEAK+51OccdT5vlmztffEBWKIoPIQHR/BOUN6f2lw3R7uLG+SjKydnDZIqn+Xo/BrYokiwnR1t5tH3InQmIShh0jvwHUIoyPZe7KUut18NnQL8Dxb4T7VPolgA5qe5J3bwJHewUezTfI+yLSAXsCwITHXuDhAmHxeOO0LWVrVnk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=OVCKxX6A; arc=fail smtp.client-ip=209.222.82.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172]) by mx-outbound8-185.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Thu, 23 Jan 2025 16:55:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s0naieexWCDeOD90NU7dCR7bLDVy+uqsl2sj3Ya3kZdzq6q92NNg9wPW1+YsVBZMYfDV+w3CEwYDQYXfax9ruqFeBN1i5DHOUSGazzMeCvHdU0z4OIb8CcPPL948H1v7ZqVNo9EtIxrKcZRQju8FNK2inpOVOpY9gy82qjAVuuTN4IcvMQoiSZta2AOgOY9PxkG2OC4BAEqVPVEoiCnzjBe47YKLVZvMHfVw9Fj2ghhMq+Qcjk8gc5U7bY943EM8sQ+x5+R+JB5jbMUS7Tzllnju6HSuDeUQknan9yus65awEv93R5i13OyRJSfetZmp1lLG1uhzjIuuzqlZZOp0cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rWusXsdlKywO2V/skLWKe/EpEAxlJZ+7XWmQTYCbxDs=;
 b=IBSe0PxhMtpdkUeMhU/ZEDxVHJ2GB8SZDjIV05qzVpbm0HpMF6njglpxdcB/xdvScSFkZbsFVZGiaK9hBDg7JbzQsTWz21CQ76zLyf1b0z7Z0tzJPy8gCDmXBIAEdoWEBAfjjI1czOQQ+OoopFKhf5ba0gJrvcxoQm9ZOAMxsoB7eKkFrmfo5/y8KnYIIQzPBvPrsAiBAROa109PQiE/8byqzzFKCvzjNbsMw9Zm1SEIV6EaVqlelDpQDHGFuavWHeDIwMI0KpPCRqqhx3OI76r/wxonRaKnSXm6LJSTLb/++DRIF2cKyRAORwkI9beh/H9wPXntGhMZT40zZZWD0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rWusXsdlKywO2V/skLWKe/EpEAxlJZ+7XWmQTYCbxDs=;
 b=OVCKxX6AbpANQrHV+e0AQjyENBkbFAb1XAW++W5ffsRKHtStNv+7ef5nXRl3NHOh4dN+Q+5CtknbnMnyFAbgoQjc7xBter9A1JhJJuKEFDgFugjTQ7tdPkK/KY+N8lo2Ih8s6yp3wSKdXCWzLA7OZFBdcZpLziHPDYx0kq4HSGU=
Received: from BYAPR08CA0059.namprd08.prod.outlook.com (2603:10b6:a03:117::36)
 by SA1PR19MB5199.namprd19.prod.outlook.com (2603:10b6:806:184::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.16; Thu, 23 Jan
 2025 16:55:36 +0000
Received: from SJ1PEPF000026C6.namprd04.prod.outlook.com
 (2603:10b6:a03:117:cafe::88) by BYAPR08CA0059.outlook.office365.com
 (2603:10b6:a03:117::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.13 via Frontend Transport; Thu,
 23 Jan 2025 16:55:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 SJ1PEPF000026C6.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.8
 via Frontend Transport; Thu, 23 Jan 2025 16:55:35 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id 5BA4D34;
	Thu, 23 Jan 2025 16:55:35 +0000 (UTC)
From: Bernd Schubert <bschubert@ddn.com>
Date: Thu, 23 Jan 2025 17:55:33 +0100
Subject: [PATCH 4/5] fuse: Remove unneeded include in fuse_dev_i.h
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250123-fuse-uring-for-6-14-incremental-to-v10-v1-4-8aee9f27c066@ddn.com>
References: <20250123-fuse-uring-for-6-14-incremental-to-v10-v1-0-8aee9f27c066@ddn.com>
In-Reply-To: <20250123-fuse-uring-for-6-14-incremental-to-v10-v1-0-8aee9f27c066@ddn.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, 
 Luis Henriques <luis@igalia.com>, Joanne Koong <joannelkoong@gmail.com>, 
 linux-fsdevel@vger.kernel.org, Bernd Schubert <bschubert@ddn.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737651330; l=749;
 i=bschubert@ddn.com; s=20240529; h=from:subject:message-id;
 bh=vJiSTPcDjBuPe0BbCVIsUueQRN8D+nxOgr6/skELfv0=;
 b=gba6irkkSeo8evthngQuonwlD9zKqqTMtcWh3OrRiewcC7FFcXKnYysdTcY2B0mYOpCbNDhdd
 xAyB1k5IeSCAxsiypJ+HmTlNHbAoVs1mjSTZhtIyNVQWXkbwTQZIAmW
X-Developer-Key: i=bschubert@ddn.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C6:EE_|SA1PR19MB5199:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c1f3217-2cb0-4def-d159-08dd3bcec200
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eGZyYWVwZUR2VDJyTlE1cS9NRzdhanNaUGRlQldPbCtiRTVDN05mUXBQbWpm?=
 =?utf-8?B?Zi84UlkxWmlvYzdRUUFxRWV4OUFhT2l4ejVQS1QvSHRRZVc2RVdNRTVwcGZQ?=
 =?utf-8?B?M0tKQW9mOVAyUmpUc2Rrc3NLbnNtK0RaTWlrcTVHdjY0UGNVbWR4VHMxOWdM?=
 =?utf-8?B?bjUxeXBSZUYzL1k3S21LZVRlN3lJZHR4dkp3ejg2YzZnTlZ5VnhHQS9vaDBJ?=
 =?utf-8?B?elMzZzY5QkV0Q1QybEpTdVlaQWwyNU5RRkMreDJVWWNQUHNWZjMwcEs1SXdv?=
 =?utf-8?B?UStHR3B6a2FrYTgzL05LUzE5Q0Y0d1hlUit0S1dyRXo5enFLQzNWeFhVSlFj?=
 =?utf-8?B?OWx0ZHVUbUE0TGdod1VxSWsrOUZwbVM1TnlubFE2YWo1eTNlclJ5U0g5dU5r?=
 =?utf-8?B?S2pYV0VzRmtqdkEyZXdEeFFPUlcwUTArUDFpUEpGUmdYczlnWE5nb01PNkpK?=
 =?utf-8?B?cUh3dGFBcHBBb0ZzU3YxQm5ZVTM0TW5kRkNHOVowRFgreTNRZDBGb1NwMkdy?=
 =?utf-8?B?ZTdDSG04QUJROGcyamhiT0QvTFJHWjN2cHdOZTlTWFJoemtKVUpIY2dTU3Rz?=
 =?utf-8?B?YkxtQ25ZcGoyRW53VEpLMDQxbWZFeVJGVXhPYTRuZFhQWnVjK0VnM2IzUmhk?=
 =?utf-8?B?T09OdmcrenRkUm50VFlERGhFRDJML0VnTExVYk9WN3FJZkxnNzJWaE9wN1JE?=
 =?utf-8?B?NzJlbWtyMTdzUzVLa2xJZXVPRXJDUmZXdkFIKzltTzcwSGJ1cFAweXFlN1do?=
 =?utf-8?B?Y09OdnRXMnJNb1Q0U0ZKN2kxRU1qTkZJeE9CVW5ScVM5ZGp6YWpabEpVR25s?=
 =?utf-8?B?SjJSR1docVlFRDRnSHpEY2lNUHBhV2pud1FNRWRBNGxTSXhtYjRPZHl1T3NE?=
 =?utf-8?B?cm1waU44UjlGM2hQU2c3VERnekRoL0Z5ZzJKLzJRcjBYV0VGamlFWGk5bER0?=
 =?utf-8?B?UXNaSHJrVC9FZ0lxVGxlN25lQzZTM3FTWGg2R2YyZTNudnZQMnVRSVBOUzgy?=
 =?utf-8?B?YlFScEkrOG5ja1hvNDNIVVFvMEMyTnFrbHY1TUl3ZEJrZHg1MzNUZ3lhU1RR?=
 =?utf-8?B?MTBSdndwVEs1R3BDeGNqc1dnYTVoYmlXUXhET3RSRGYvYnFveWJYU0VYd3Q2?=
 =?utf-8?B?ZU0vY3RKL0JyQ0ZVUUxGZyt6bGczQVE3elJaQnYwTFJQbUp3ZjMzTFBtNFMr?=
 =?utf-8?B?bVlDQ3hnM3ovYXk2MFViekdtRjRJNGp4S2d0eTVRQ2xaYzhHd3NIbThqS2NY?=
 =?utf-8?B?MUM5Q2ZYcFRwMkhwYWJuVzFEWmZuaElVbkhFOEY1d2N4QitsZ2U1L2svTTEz?=
 =?utf-8?B?bG1teVA4VEZ2T0lETSsyazNOOEVtL3ZqVzFhL282ZVVaM21kN3hUWk5yUzRF?=
 =?utf-8?B?VkdYRytvNTl6cnBkVE4rSmFUcnROTjV2RWg4aGF2Szh6QTdvUlZRMUpvSExZ?=
 =?utf-8?B?UHpXQ1JZL3FYQkV0QnYwcHVYU2M4RGR4dHlqbVVsTEcrZlpncHdTK3hJSmJw?=
 =?utf-8?B?d3E4aStubENBWGtWcFl1YkpzeWJxUU16VDVvbFA2L2R5TDQzaFp3R0hvTmhL?=
 =?utf-8?B?L09pLzdiUHpSVEVZbXlXck1ySkNlOU1RcDNuMitOWlVwOVFOQXlMOVBLUm9t?=
 =?utf-8?B?VXVaUDViNlZJK3kra1dLUU04UEpBSjNsbFdBWWRIMmJYVTJWb1EwMFdHbjNt?=
 =?utf-8?B?ZkRvampsNUpRNlR2bGdPODhhYlpwRWhpRzgra29SUGZ3YnFJKytPZWNKSzcv?=
 =?utf-8?B?VzNJckdSdG9QTnkyWUlGNC92aEhBeUtMQ1FuWThCTXlCYVFadFgzRWRNTnF1?=
 =?utf-8?B?WFZmWXlpenZNR1I0cXB6TU5GZ2ppR2RHRm5xbXF0anE2Mk1neDdpblUxc0x2?=
 =?utf-8?B?Y01lT2QrWldRbzhRVmRVblFZVzJoU2d5Zk00UHl0TjhxVis1REpTbUNVTHBJ?=
 =?utf-8?B?MGQvYmpDWnNQYnFxOGZTakUxbFRvRkZvL3hWdXJQcEd6S2hkbmYwY25ScnNv?=
 =?utf-8?Q?7wRpfCuJAN1xy4KQWL2WRWBn+qfHe8=3D?=
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	UwlQZEI5uOvv2I+BVVBp+dhBe5Ag3A8MyBMEiqKUMltfkJvcrVOStp71lRtR5rA1Cwxb0cv5t0H14QRfn5XXHlldCt5QZVMaJtv7Ml5MKTlhHwM0aSI6IllOAjmyeM0I2B+Wtwz4ngzNAGka+/Age1zBxGsd49akZcCJ3yuZ1FiW5BsI2gIkKjUQ8D6C9aYSt8uNjQMb0nCqLkk8+RySj8TIe5OHHPqgaDJ8hp94uSoPcf7uqyowQbI550i1zUPgeZcP8C6ZVqmTUv4Uar47kX/yh4Nr7+RTDBjnGeyxMI0sVMM3HORTFccP3T655mXmx5vuNd7GH9FbQY1FtsgeLoRDAfJXS97Y7lV2oCZWy+QfKHzKt2oTi9s+KVYkMyxFxx16egEwHSO36yw0gYz9jIKcS9Kp/VCHsDqJJTvde2nG2FQZ3bshmp2VzTlU0MBd/5mIUUoJfKf3cyo3vjtum9wSUpTdvgyuD8vRbg0mmGtpoxSDrcZalw+VmHvDvxZEPBdcgBedc5RECyQkFyacTMjQFvuntgYU0TJv5tmK5qAYkFJMg2ZoJ2ammvpuUvAPhWxmJzPYmOnPZM3laymsnWj4GUovZiOTouqk8mQWISG9C92t5OzoNLmts5ewqo9mx98fqRWHSJAftc9MfZvNqQ==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 16:55:35.9675
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c1f3217-2cb0-4def-d159-08dd3bcec200
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR19MB5199
X-BESS-ID: 1737651338-102233-13470-14868-1
X-BESS-VER: 2019.1_20250122.1822
X-BESS-Apparent-Source-IP: 104.47.55.172
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVuZGZkBGBlAsxTLJzCTV3Ng4Od
	k8JTnJ0sw0ydzI3NAkxdzUKNHENFWpNhYAesBOfkAAAAA=
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.262005 [from 
	cloudscan9-95.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

This include was accidentally added and is not needed.

Fixes: fuse: {io-uring} Make hash-list req unique finding functions non-static
Spotted in review by: Luis Henriques <luis@igalia.com>
Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
 fs/fuse/fuse_dev_i.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/fuse/fuse_dev_i.h b/fs/fuse/fuse_dev_i.h
index 429661ae065464c62a093cf719c5ece38686bbbe..3b2bfe1248d3573abe3b144a6d4bf6a502f56a40 100644
--- a/fs/fuse/fuse_dev_i.h
+++ b/fs/fuse/fuse_dev_i.h
@@ -7,7 +7,6 @@
 #define _FS_FUSE_DEV_I_H
 
 #include <linux/types.h>
-#include <linux/fs.h>
 
 /* Ordinary requests have even IDs, while interrupts IDs are odd */
 #define FUSE_INT_REQ_BIT (1ULL << 0)

-- 
2.43.0


