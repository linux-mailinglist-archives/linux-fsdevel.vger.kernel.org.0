Return-Path: <linux-fsdevel+bounces-64998-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F14D3BF8C3E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 22:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E835942102A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 20:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1BB227F736;
	Tue, 21 Oct 2025 20:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="WlpIKvj4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip191b.ess.barracuda.com (outbound-ip191b.ess.barracuda.com [209.222.82.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176CC27587E
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Oct 2025 20:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761079625; cv=fail; b=QCWCOd5UdAnJ3KZIIQCUER1PfCPaUt9b0hanEPY3cNfKc95pytKEFldkS+gI9M9sfnvXNeCrM88FemkqanqR0yqy2POYVXWW/paKGf8i5MB0aMYJ51gfj7fstIDOmhrsAHuXHJl4RtiLzgP1UiO507x7d0Tahjumq7r/bMPX4Ig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761079625; c=relaxed/simple;
	bh=3qZZriTm4j0ZK2ZwU14xft7Dd6Zys6cef3jefYd1lv4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L57wTMvxJocyUTEubwfpVT4rlqP5T8zNYAo8JX0yeJxiZ5nsnsRxiFqwhRlJxmjYxxdhJU6o6TDzKuuprL6Y3fi2LULHxigzpfAEThczdCbaLCoDfbWydVayfsXx1ZMDAtQ0ESz0cggbhcKKpz9ewNGAAPUlKWhzb7FDm9CqW4Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=WlpIKvj4; arc=fail smtp.client-ip=209.222.82.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11021084.outbound.protection.outlook.com [52.101.52.84]) by mx-outbound18-128.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Tue, 21 Oct 2025 20:46:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XgQmfPjQ1VYKbLhm6oTJpMmiztbP7pYu3G0cbRQBrJPusC70r1mKp3B46Tr54isV4wWjJ8TcnlRRXLB7ot5SOgyskmfXvnHYLKbrphK7Lqs13QW2UIZdx5lIKzTdJmv+PWAJEy4NA9l1OJiNnw3g1vLEgx/PXV7L6mkPRlbQd1bsC9jfHVmQTTwAH8VGH0d06GHHO6EV8xWJCCDnhwsKYEQLpriZi32LIzjrj19U1EdFk9o5iYuudTlkpmGceITbIcWGrkYTn+VSfhAitV9tbvF//PCpiWwsS6n2/d3m3W4m/KwrDr5POeeW7fEQ8jTsnE4Gz/VU2lbutteISuquFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IaT3cZOw+AKB2zqUJG9uePU9MI3MuRaLgVdeZxYBR5E=;
 b=yBs+Yqc6AI4CCOfqlHCUvXY32rJSQxzISr+8w56HLAf99fnH0BchaO1d5TKdGW2Ctgnbii3O5AOBmyQxF2xzV1yjxGUYWHFVOsZ2XIF7al9e9bA80bm666olf0zCUj1gq+sufFmmtrINQHNdl3R3v4dMNQH5RCkjuuopHSJfgJ9+XkY1/IuIT3dnjkjOluqVETFLfpD4jZkzBqaQj5b54Fir7LFhi69otmj+A36yOCSoDcE/YfQkZ0Z6U0wXgdF1IfakuW5EMSVnaWsKtUOp8P5Fpc2xZ/5Bk3jkRc0jgd+D4hFuUGiVh7mRxEQoR2r+kl5fFpABjxe6DZIGi4KJ+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IaT3cZOw+AKB2zqUJG9uePU9MI3MuRaLgVdeZxYBR5E=;
 b=WlpIKvj4swvhfmZnXNa2cLJ3mNxAXXCGmIcvwa0ODMSXVB6QYrnUJn5pOlx1FTKAJfiX1pi7b/jPFxErtB3TdPy7teuNRr9gslO9XbbmbkVGUWPYW1RT4UqtZ8Rfrj/egwxUrCx2yfq2VmtP5zWMFeFRx+wRRYyLfeJSR3KXn+Q=
Received: from MN2PR05CA0065.namprd05.prod.outlook.com (2603:10b6:208:236::34)
 by MN2PR19MB3853.namprd19.prod.outlook.com (2603:10b6:208:1e3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Tue, 21 Oct
 2025 20:46:49 +0000
Received: from BL6PEPF0001AB74.namprd02.prod.outlook.com
 (2603:10b6:208:236:cafe::b2) by MN2PR05CA0065.outlook.office365.com
 (2603:10b6:208:236::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.12 via Frontend Transport; Tue,
 21 Oct 2025 20:46:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 BL6PEPF0001AB74.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.7
 via Frontend Transport; Tue, 21 Oct 2025 20:46:49 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id 43DD44C;
	Tue, 21 Oct 2025 20:46:48 +0000 (UTC)
From: Bernd Schubert <bschubert@ddn.com>
Date: Tue, 21 Oct 2025 22:46:43 +0200
Subject: [PATCH 2/2] fuse: Fix whitespace for fuse_uring_args_to_ring()
 comment
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-io-uring-fixes-copy-finish-v1-2-913ecf8aa945@ddn.com>
References: <20251021-io-uring-fixes-copy-finish-v1-0-913ecf8aa945@ddn.com>
In-Reply-To: <20251021-io-uring-fixes-copy-finish-v1-0-913ecf8aa945@ddn.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Luis Henriques <luis@igalia.com>, Joanne Koong <joannelkoong@gmail.com>, 
 Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org, 
 Bernd Schubert <bschubert@ddn.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761079605; l=769;
 i=bschubert@ddn.com; s=20240529; h=from:subject:message-id;
 bh=3qZZriTm4j0ZK2ZwU14xft7Dd6Zys6cef3jefYd1lv4=;
 b=jZXp6cLuqUaV1x0K+i55L7BlxDJK/WVWziUf94DjKIVlOT3+q2cUqgE/3PKZzIVWzY79vxN1m
 VuaTcSXiMsAAv7ur/2UhBBreN8LSRfQfYLN4teBIy9xjK4sor3hJ+jK
X-Developer-Key: i=bschubert@ddn.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB74:EE_|MN2PR19MB3853:EE_
X-MS-Office365-Filtering-Correlation-Id: 0858f54b-515b-41de-bc9c-08de10e2f506
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026|19092799006;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K3g0dEVwemdmZ1RJajk2Ulc2RmQ5NnNwaUhDbmU5SWY2S0V2cGlsL04rWUI4?=
 =?utf-8?B?V0U4TVZjYnpZN1Y1aTl0dEhpSm1NVWJOODZ5WEVURU1SN1ZOc0dEYTVDbjIy?=
 =?utf-8?B?RTV3TkcwdWQ3RzR2VmxYZGFuTk96d3J3S3I0WG5uK05QRStjT091VDF3aGZn?=
 =?utf-8?B?K1NvRk1GNSt1SWFhRCtZbDBBR0VmZ25WcTdjUitLeFlLU09INng0eERDdGdS?=
 =?utf-8?B?R3hTL0hvSmp1QjVpSkdoWWMwZTBYT2Z0dGRneHhXTXgvNHhjMHREUXM3bFNK?=
 =?utf-8?B?UXY5SGtnYzdvbXAvS3Zibk1MRFYyckx1ZE5ZS1VmNWxnZkF2K2hkdjlnb3Zr?=
 =?utf-8?B?dWd1SmI5RTBlb09WSXMrTk45OFhNQnNLcnNZZWx4V3M5b25aVkJtenZnc2pz?=
 =?utf-8?B?eUFXaGNzOHVpSkI4aFdsTHBxdDU2MDgzMkQvRFl4anhtL0NUd2NpNTM5ZHpu?=
 =?utf-8?B?Q2Y4MHhzMW9yOVhLVUtTS3luTHBEZDl1YVUramJjaTYrUmwvNE1KLzJ0TmVL?=
 =?utf-8?B?VkIzWHJad2F4VkJBTXNxQ1ZEM2hOb1o3aExObGZmdldMOW9LTVdLRUh4YWJB?=
 =?utf-8?B?elY1UVJZbE5hNWhrbHUzUXRIb0lob0hGbFl2bmNQeVVHM2pmVW5ycmtZdlhz?=
 =?utf-8?B?c1dUOUFyTnRrMmlvMHIxcGoveHJYcTNvWnI3dW1OT0IyVXcrQlNLOHFLYTFX?=
 =?utf-8?B?OHJTdW5Rd2I4V3grMWlmR3REU3kwSWdHbk9JZm9NTWtCd1Y4aUQ5TWhzSGxu?=
 =?utf-8?B?ZXB2NEtOYkhRZFN2dGVuU2ZFSEs1RmRPbG8wRW1OUmNsNWlMRzB6Sk5lZ0Ry?=
 =?utf-8?B?R3JzelorcHFEZ3FQL0VkUW14akE3bWVBbG9FRlZBWDRjYjVFN0Q5MlZFaE51?=
 =?utf-8?B?Q3pES3FqY0sybXBYcEp5ZHZNRzNmYm1SNHFaN0wwVkRwZElhZkZlMFFQZDRv?=
 =?utf-8?B?R3hJSXFadzJtbGtoSEl3VCs2aFJsL3JyVWFZSjZBN3drdEhlcXhSYzJwYjJh?=
 =?utf-8?B?QjBweHk5N2d4VVUyeWpwYTBaNzZSTDJOUjl6ZFNGSEtWRkowYldFM0pvT0I0?=
 =?utf-8?B?VTVBMkpSalZhVWsyekVRcG5USnY0dkpCbGhXcm0zYTJXbFk5aTVBa2pTa2l6?=
 =?utf-8?B?SWcvcXJhamsyVWZzVG1UeWtuSElWQWorcWdaeXRUWnpQMkJmTTQxaGhuSHlO?=
 =?utf-8?B?NFBqaVJyNjRUTXVmMTZMcEtMYkZPRTFiUEwwbXNrVDJZellyUXFQdlBTdG5v?=
 =?utf-8?B?NERPK0hVaFZyK3poMVJBT0JTZStzVmhvZzM5Y1oxMlRaVGl6dFVZa3grTjdR?=
 =?utf-8?B?dDg3Qmlkak9ZNXNkcWlqNy9ZdS9qWHdSbUNQOEwrYkxFOWlWb1poNlJRbDB0?=
 =?utf-8?B?OGIwbkVtNjNJWVB3OFo3eEJtRThzSkpLclgreGRQeDQ4eWRsYkcrbmlWeWU3?=
 =?utf-8?B?WEtaSVU4cm9EOE5ENVN4aFZxTlNkWUJvV09vUURjUnh5VktvTW1rMXhMUG9E?=
 =?utf-8?B?djI0cUJEdGZFL21JZUZOWXpoUmhxZ0VmcDI3L09DcUIzVWxxTUhqMGk4TUll?=
 =?utf-8?B?L09IUkNPejFyNEp0NFVOUzZGRUp1YjBBc0dFci9uN2JnRXRLT1hJay9oazFt?=
 =?utf-8?B?RCtCMktFNjNxSXNzMWNKWWVCd3QvWDVIb0RzMGlDVUZlWCttdXRkcEhnbVhj?=
 =?utf-8?B?ZVpLeC9DV1dkWU04cFJiOWsyMDdweVFhclpBYnVaSGx4QUc0MmRwYXNRNlJu?=
 =?utf-8?B?Qjh2WFF5QjVnaUJKMUhhL1kwcUU1aTBuVUZPZzhEeXVwcXVoaUJpaE1jRkpU?=
 =?utf-8?B?SEpBMlZzU0FIMlp3T2NaR1VQZnRuT1VxTGZaRXF4eCtPY0hGYjJXaTdIQnRh?=
 =?utf-8?B?am5hZ0N4b0dQbU16KzZnNmkxN0ptbU1GbDg1c0dtSUJhUk4rMjg2QnYvRkt1?=
 =?utf-8?B?WlR4aU9VYzR3ZW5VNkpOSTZJczlnOGpTZm9NUEY2RFhIRGt2bTBjSFpOdXA5?=
 =?utf-8?B?NERES1pUajVMN1BZWnRtUDMwZWtsbGxmdERZUzRVVHZRTzFpbFJmZlJHNWQ5?=
 =?utf-8?B?TldzeERER1daNjhHTzc2RE9GdmFBRUJHazdqUmxrald3UnB5UDRDSTFwRHdq?=
 =?utf-8?Q?DoR0=3D?=
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026)(19092799006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	sb+Qy2OtUCE+4Yyc8U4sJszw4M7ft8BpRVZxSm5yIsN7JEsJvUviEBFbp0jHUKc/z5K8g7ghvdYIPJisfUUwi5m2xgHHzfnrSEbym0KvCoTNeYDYTjuFBbtRhqO8vxtq6bKNgUMVUFuuFptPvBL4vLDzTTgVO/X7L4dVO/29MZ5H/n4kq+1cPKTnsXZdkfyI++E+gkb1RDTVUfam+mkZQOb+VFQuB8o/lkN/FebAPKVle79keH7jU5DHyHYWV3W5aks78wm4VSQ/vPvwLwpoxTtgd4bLKH+5cmtip03DwC2zVFVi8jAbjvr1nPlbhTUXWZrEzUZMGv95tx44iz4FxPcn3v61vLHNRatbiPe95sud7mZNse57o5m2EU/AfmQfBL1b0GjJMZsyi0GKarQ0UCF0IH6DtpQnVNIQPU7Nu8Rg8OwyyrYNth6m0d1x84k+8nYpdTjnuocvg+tjAzD69j7fa5U2DmDtE3hbfd1MabmoaxdEycR2tl/8fnVYkD7Ih1aU1kBBnYtuzqJIeRpti7xHX2SLSd0evNGmKgbNDmJ4vk482DT2w6Jzaw6rWlnJRXEBTx5/eCfM371jBN//wHrZxIz8UdxE2vczifBXNcJrryI0SZFF+5x3R8yAwR13kFZTIbY28R5vqqONTCY9Rg==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 20:46:49.1330
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0858f54b-515b-41de-bc9c-08de10e2f506
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB74.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR19MB3853
X-BESS-ID: 1761079618-104736-7708-4894-1
X-BESS-VER: 2019.1_20251001.1803
X-BESS-Apparent-Source-IP: 52.101.52.84
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVuYmxkBGBlDM3MLAIM0kMdHEON
	kw0cLEJMnMLDXRINHYNDHNNCnF0FipNhYA40HF20AAAAA=
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.268376 [from 
	cloudscan8-220.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

The function comment accidentally got wrong indentation.

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
 fs/fuse/dev_uring.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index 3721c2d91627f5438b6997df3de63734704e56ff..670964862fb1ed4f3ce8712a1f828e6a5702fab4 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -603,9 +603,9 @@ static int fuse_uring_copy_from_ring(struct fuse_ring *ring,
 	return err;
 }
 
- /*
-  * Copy data from the req to the ring buffer
-  */
+/*
+ * Copy data from the req to the ring buffer
+ */
 static int fuse_uring_args_to_ring(struct fuse_ring *ring, struct fuse_req *req,
 				   struct fuse_ring_ent *ent)
 {

-- 
2.43.0


