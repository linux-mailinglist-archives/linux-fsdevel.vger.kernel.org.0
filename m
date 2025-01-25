Return-Path: <linux-fsdevel+bounces-40115-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61385A1C4B3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Jan 2025 18:44:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CA271885760
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Jan 2025 17:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1EF186338;
	Sat, 25 Jan 2025 17:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="X8IdVMAL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip191b.ess.barracuda.com (outbound-ip191b.ess.barracuda.com [209.222.82.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76D043AA9
	for <linux-fsdevel@vger.kernel.org>; Sat, 25 Jan 2025 17:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737827066; cv=fail; b=WS/+sD8LR6RzCMHs0/cR6SKHGrY9P6UfIrYt6afU8c98mXS5+PWOxUigODX0tOotKCY0neg8/yF9JnPJxnFcKEnrdIhzv9ciYvCjR9GAODjsuXoTLS1zf1ao99uk364KI7AlqWihvKltz8RbjNUXTOXwZ2PhudpL1ZNvvds+GW8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737827066; c=relaxed/simple;
	bh=z+LkpxfZfeVxDdWJUNaYf2XD9eZE50Kw6bFrhhmhmSQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EJ/8QEa1ePmgVNYTfo3pWLipRMbw2XkkV0aKS93JbuQ5iwiHFNkcf+Yr8EBQSe1y4qaAogV2UKQ4t5U10f9sn/DHG4Z7Q6sNv/uFMoyOBs6Cay2gk60gMpW4/Wbw/W3JIDYGekOsWDyoslXGXIoIIrd84FUl8vKgxIWsYHDTPI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=X8IdVMAL; arc=fail smtp.client-ip=209.222.82.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169]) by mx-outbound-ea22-15.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Sat, 25 Jan 2025 17:44:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wMmhmUABUkXzlXj+vxXyXwEj/Al44KsJCVyddup/ID2ahljglGNL1i4GTJQxoW4kq+MGY1BK35s+ZZvlN88i2HdY9p9NxeM5v3c82rTq1MSwk4mF8UeVsLo4XE0gwo7eyyVJy918UIp/biLU5B7XvArorvyGOwZ5CZYgdgU2xy1WQzlqAjDpUvxMvviSEhPIg94wkEVuG4OxeORuCTEpmlwObsGGjn3br/HFuISPm/ZlZuyYc5hdrIxLX5jqF306fMOq7v11jOnzcRBpWw3/65xA3qYczzXfX7Y4mYSkh0EAMBsnmKwlqs19MKoRalky1j+vFenpvmxwcKVcIoe/0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9/2npZ9T/cU2JxXXXk8BqzZwsh/bxSF8L1abf9EV3A8=;
 b=DCmAr/qMHbysyFrRWWRu04wROq03ojhrONs/CCMEhbWS7hbJ9WmhjIOyIIjjYVQvZnEhg4+z0vJmsQlMQR3vEfYEs8AUOOpb6ieAaOZZVgWCYXtCSqj+O4Qb93pR8EcS4sYM3qvOlGpwT7mENx5nU+pm74bP+NF7XX/WKm3frtGQM68jpJzb3SUrqCHZt7LKXaU48oRR0s1+wmENrhdpsljS1DE8eb8QS++VJchTP6Etj7O9qgxgltmJ18kvJcz5V1PFKGFl2GZnok8T+kktDXo7vCyyfsBPtYsipKfXMpuXRqfnCi4eC6zH/yqmyvjfxpmx6t8DQ59e8cDzyW4T+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9/2npZ9T/cU2JxXXXk8BqzZwsh/bxSF8L1abf9EV3A8=;
 b=X8IdVMALyeTeF77BhhCLkMxGPxWLFCOT36TUozdBJTmm4n+D1q8fYqasr5Fxd6nIWncqLQtFsUPiTNSRX5HQH5i/FIt1175gHz3B+yCx5EfmIlH8o+1HblryCJ0FF7zNpC1p0PKYQOpRFAz4+kEXCXoC7kYfmGzWOSl0rnUkeJE=
Received: from BN9P220CA0002.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::7)
 by SJ0PR19MB4764.namprd19.prod.outlook.com (2603:10b6:a03:2ec::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.17; Sat, 25 Jan
 2025 17:44:03 +0000
Received: from BN3PEPF0000B06F.namprd21.prod.outlook.com
 (2603:10b6:408:13e:cafe::65) by BN9P220CA0002.outlook.office365.com
 (2603:10b6:408:13e::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.22 via Frontend Transport; Sat,
 25 Jan 2025 17:44:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 BN3PEPF0000B06F.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.0
 via Frontend Transport; Sat, 25 Jan 2025 17:44:03 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id 27C5380;
	Sat, 25 Jan 2025 17:44:02 +0000 (UTC)
From: Bernd Schubert <bschubert@ddn.com>
Date: Sat, 25 Jan 2025 18:43:57 +0100
Subject: [PATCH v2 2/7] fuse: Use the existing fuse_req in
 fuse_uring_commit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250125-optimize-fuse-uring-req-timeouts-v2-2-7771a2300343@ddn.com>
References: <20250125-optimize-fuse-uring-req-timeouts-v2-0-7771a2300343@ddn.com>
In-Reply-To: <20250125-optimize-fuse-uring-req-timeouts-v2-0-7771a2300343@ddn.com>
To: Miklos Szeredi <miklos@szeredi.hu>, 
 Pavel Begunkov <asml.silence@gmail.com>, Luis Henriques <luis@igalia.com>
Cc: linux-fsdevel@vger.kernel.org, Joanne Koong <joannelkoong@gmail.com>, 
 Bernd Schubert <bschubert@ddn.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737827039; l=1548;
 i=bschubert@ddn.com; s=20240529; h=from:subject:message-id;
 bh=z+LkpxfZfeVxDdWJUNaYf2XD9eZE50Kw6bFrhhmhmSQ=;
 b=sKwcbSQN9Ek/OdQo9jOOUp0lnEne6txPC542All/wtI1fX5ie2pVk/mbRCIuJTpOjYVWvcJJo
 1ySnwxnyPMTAGnlX+4cdTA8097Q4CI52rglCqAHf/1QHZz61Okh5a0G
X-Developer-Key: i=bschubert@ddn.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06F:EE_|SJ0PR19MB4764:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c73cc26-c89f-4746-f65e-08dd3d67dbb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dTBrUktDRjAyM2ZIRHJCdDE2N1JHNG9UWUFSQXk3MXZ2VFV3VjdKSGdyZWF2?=
 =?utf-8?B?ZEkyb3N6aElXOWxDbE5NVGZ6TitPaEthN1psUEJBYVA3dW9BMHpJV28wTXZt?=
 =?utf-8?B?QTZ0bFcwajdhQjVNK3E4aEpLUVlSbnBxZWxqelhlS3pzVFYrRUhHVkpKRlZE?=
 =?utf-8?B?SXJpMk1FZWFOSHpWZkoveU9OS3hiSDFOQ0RGaG5HaklublB1TThJMFp0M25T?=
 =?utf-8?B?MC9OZThPWVB3S05MZXdUSXU5ZW56M3lKTGR2Z3hoZ3graUtJUFYyTlhIaktX?=
 =?utf-8?B?RU8yVVI0TE5WRWdCOE8xOVVBdTVoQXBVRjVLeTFTY05rZUVKamdjMGUvTElt?=
 =?utf-8?B?enU3MEhId2hZdURjVnd6ak04ZmQ0YUczTnI2ajRKMnNuUk52aXVYUU9XYW8r?=
 =?utf-8?B?aUNEbi9CQjVhd3B5YjV0MDFxdXhKSHBtTGJXR2toNHNxQVA2NWsvdmd6ajNz?=
 =?utf-8?B?QU40NG1XenJzaGJaakkrN1c0YTFkekRNcTN5d0hYaVN5akFQQ08zSkl2bS9R?=
 =?utf-8?B?UnBQdzNMTXNrc2ZVbWVDSkhxeUMvamdZcS9RSnRSTjJyTGhFNGhOeUN4cHgw?=
 =?utf-8?B?eTVzRkk5QXZQYktqREpEaEplcnNuVHBPTmM5Rk9EUGZlR1JDQVJNS0RXK0FF?=
 =?utf-8?B?SUV2ZGp0bFdUaXorU01qV1pmZEdYNUFwRjdVTEN4OHJ4S3krczhkQkV5TlJH?=
 =?utf-8?B?eVFLMmh3ZVNYTDVxOWl1SFhrenUwQ3I1NURKNlFSYm5GR2tzb2k1aTRLdzNh?=
 =?utf-8?B?UHIyK3JmVUlNR3Q5VTBnZnhvZlhJNVFyamlqU2ZiRzI0QXhkTktUQTJ1cWRY?=
 =?utf-8?B?eUx5VDE0Qm9MVU9GNkgwSVdZRmFaQnNlWEpJS1V1TjI0cmdkUU1EVVQ0R2Jm?=
 =?utf-8?B?eUw2bnd2UXBkaTJWMm5wUnRrQjlzU09BMUxsS0ZrbVNPRmpZQ0s2NnZxQWkw?=
 =?utf-8?B?SldWS2FtWkkyR2V3VkxXYmpRcnlSZVE3bUxlWWUrMEx1TDljdzBHWTNJendH?=
 =?utf-8?B?WHE3a05lQnBYdUo1Yy9LRm1mTVE3M0ozZnFWcWQwZ3FwUU1Fa0tJSEdUeFdW?=
 =?utf-8?B?bWtBRkFxWHRHaUQ3VkxqWk5zZDQxNGNIc0JIVFZ5WXppa2NRV3V0YUh6RDNk?=
 =?utf-8?B?ZWxaejF3UDlZZHhuZDBsbEZ4Qlk4NGNRZ0lXTmw4UXcwVDhQREhPWFFHNWFh?=
 =?utf-8?B?TjBRUTRCb0QvQjBFRmdTOU10NTIvejRzOVVDZEI0bDUyZlc3MDkyeHhjbmxL?=
 =?utf-8?B?cE9ENFdIOVNYMVdhNWFHOVZNU0hBMjdQNmx1RW1yN3A4REpjODFZT3A2K3pI?=
 =?utf-8?B?M0lHay8vUFRJeGU2RDBhcjB6aStXZ2JyQ0JWT1ZOaWJXUU1TZlFBeUlIaVFE?=
 =?utf-8?B?eXpYbFFneVdxZEU3Q1lsQlBIRDRvbGZ2YUpEVTJLNDdDbVpDNGNZSjlHSUU4?=
 =?utf-8?B?T1JpN3FpNkJqeGQzTFV2V2VNTmg3QzlYU1BQUGdidW1wOEJGeHBZakl3c2tU?=
 =?utf-8?B?MFRmUG04K0ZQOHQrdC9xUkFoMGpSYzFiN2VkQnQyZlpXOXNxd0FwUlk0aWxN?=
 =?utf-8?B?eUJIRmUwYkhNME5JVW1mci8yYlpuMjlrbFpHRjEwbENYR3R3MnIyWFhNcmFB?=
 =?utf-8?B?eGJDNC84Q0lZKzBPdVFlWVNCT0FZVjVCWVN0bnBWdHY4dkVBNDNFODJ2Ym9l?=
 =?utf-8?B?ajdxM1ZwUDIrb1VkUjRSb3h3WW8zQ1V3eklFejVQT2lqcnJQQlpaMGpITHQ1?=
 =?utf-8?B?RFA5bGUvaWU5S3pubFB6WGtDUVFyV05Za1VVWjF6NnE1YjdkVllPZ0w1Y09n?=
 =?utf-8?B?a2E5YW96R3RjaTM4cHpOaXNpR2tDYWFYSFd1ejd2c1R5RnZ2eUVqRGJyRncv?=
 =?utf-8?B?MmZuTWlDTElLcGJ0WUxGSk5vWTBEaTZCVE9Rd2xZMmRsQ1lzSWx6WDRwSitV?=
 =?utf-8?B?akE5QWpMdGFXRVZ0S1R4TEwrM1orTVY0b2o5clBOWU04MlV3aERIZlJGMG9k?=
 =?utf-8?Q?3PinDUJ9AF6vOPXeHfPJleBCTW615U=3D?=
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	OPymsK0zC7IT5aXJEV+x5FeX/NJndttfErIknTmKzmE/O82myXB7IgDICMWax0HgGBSeJElFs3fJ337ecltzFM5zeQKLs6itUlwtKGV+SB8hxCZv+lyWsNwCWm9EPak/RsXPjUdSjApjx/LZSdsU9G1Ebhx9NoPRcDk2BRjokAmUNSLfOpV+tcQUlFIFi7I4pN0hXjy/uIaYWT4OG/gc7HaYmmLePnyqmT8QeQGjUDib0kybnkPbak3qaTCiVwXrAdDKP43fTj4ffIUNHd3HURdEKIMevpoo1TgQip96ghL/Tj+ljyFQztpxiZemvB5pFrzc++gDFG2AVnpZ+vDLH1iavWRoLiQJemjk1Ko/Nx1pHf3svjZAJo29FFWL6dtG7cXm/rH81ADAzcAsX2KAUx8UH+NKtssldrpejFSKum3lPCB8vR57NRM8nST+cxCF8RZ7xKE8FfOkxgPqwqzf3J1hD7BBTKkqAXWU/g8SGifW46oN/osoYlwlUnHlvXQazBQrRbqm7u4LdvvgOfIOlLfWPmGshM9aYfrbRlHVu7Q2+nh17K8zUROuKg6qliMoIy+6ek+7heFQHlmKlDYUcIg/GuFHE1lae7D7CUsQ8KCc7C5ci7UPGWLUbSi9fd45AJsDknN/Y1ZmppxjR78gFQ==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2025 17:44:03.2002
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c73cc26-c89f-4746-f65e-08dd3d67dbb3
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR19MB4764
X-BESS-ID: 1737827045-105647-32589-1675-1
X-BESS-VER: 2019.3_20250123.1615
X-BESS-Apparent-Source-IP: 104.47.55.169
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoamhgZAVgZQMCXRJDEp0TjJJC
	XZ0CgxydjIKDXN3NgwzcA8ySDZ2DJJqTYWANdKaR9BAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.262052 [from 
	cloudscan21-33.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

fuse_uring_commit_fetch() has obtained a fuse_req and while holding
a lock - we can use that for fuse_uring_commit.

Fixes: 2981fcfd7af1 ("fuse: Add io-uring sqe commit and fetch support")
Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
 fs/fuse/dev_uring.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index 2477bbdfcbab7cd27a513bbcf9b6ed69e90d2e72..3f2aef702694444cb3b817fd2f58b898a0af86bd 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -796,12 +796,11 @@ static bool fuse_uring_ent_assign_req(struct fuse_ring_ent *ent)
  * This is comparible with handling of classical write(/dev/fuse).
  * Also make the ring request available again for new fuse requests.
  */
-static void fuse_uring_commit(struct fuse_ring_ent *ent,
+static void fuse_uring_commit(struct fuse_ring_ent *ent, struct fuse_req *req,
 			      unsigned int issue_flags)
 {
 	struct fuse_ring *ring = ent->queue->ring;
 	struct fuse_conn *fc = ring->fc;
-	struct fuse_req *req = ent->fuse_req;
 	ssize_t err = 0;
 
 	err = copy_from_user(&req->out.h, &ent->headers->in_out,
@@ -923,7 +922,7 @@ static int fuse_uring_commit_fetch(struct io_uring_cmd *cmd, int issue_flags,
 
 	/* without the queue lock, as other locks are taken */
 	fuse_uring_prepare_cancel(cmd, issue_flags, ent);
-	fuse_uring_commit(ent, issue_flags);
+	fuse_uring_commit(ent, req, issue_flags);
 
 	/*
 	 * Fetching the next request is absolutely required as queued

-- 
2.43.0


