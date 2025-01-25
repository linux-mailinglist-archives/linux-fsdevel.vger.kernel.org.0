Return-Path: <linux-fsdevel+bounces-40117-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABEBAA1C4B5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Jan 2025 18:44:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0FFD3A4E14
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Jan 2025 17:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43CAD43AA9;
	Sat, 25 Jan 2025 17:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="mygVivVQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip191a.ess.barracuda.com (outbound-ip191a.ess.barracuda.com [209.222.82.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01457405A
	for <linux-fsdevel@vger.kernel.org>; Sat, 25 Jan 2025 17:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737827066; cv=fail; b=aDkpnsiQ0lrlTngBhE248HdC9V27U0oROzakG7TjmxMUR1ywlCtcDs61NoV2Zf0gKNYg4mlGZBnHdQow+ta7AnWNpCad3mb7F0hPfS9YPCEtlSmsrrfActY7AF7FXyy+0FGioZYC4UqPw2ri2MGw2HjTGmabLN2tGEEkfYf03wo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737827066; c=relaxed/simple;
	bh=9pIH8SQN7l30Y0x3YkGM4lsHwYA/oWC7Cwq+mNoGsO4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DCsok5IiPwM44FXKzwJfbrygAWi7oUGH7uKqkS/bf42j4IE4ybPim0mJ94P0teq2w7VlE2RpD2G/mAutwIIo3w9kBFPyMZ3MYT9uTilhTwTzeln2kgYsX+nNfG01b/G0r6umGCFFG8Uu57i7+RX+FoYnsQ2zx3mfx0FOn1PawGs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=mygVivVQ; arc=fail smtp.client-ip=209.222.82.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40]) by mx-outbound8-214.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Sat, 25 Jan 2025 17:44:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IWlKJ8eRFfzOjE4iWjGXK1D51WiEQLToHsCpzULQuZ2K4AgJips5qRc3I0UxPrRBnfYfK75N9C4+Y/NACuSMLqHjO6atO5mDAVYu684X9OYIe1fpSRguMwnUF+pwkf9g0nPJjH/grCet8QzYyNeV4inSvButzctdAgiEM94oPXIkCSDF+4j+8/2vwGAuBmu2ZqEZyZ82VuGpXUwT20wFFlLl6shdsGBXuM4FuONz798ZOYwj9X4RVfT7rZPcsU0/R2sAWqgmK6GYBaLmn8giIhkI1XFDmt2UabAJIPUybxgUQpwFGHPlmnns8yFCfEUQ2w1dhyEpQ3POEDaRFmodFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wsrWFwwxmuB4lEDyyGIfS9yT4/clx/pPsew7D+uWJZ8=;
 b=eeIjQJzACQjF3mS0FLXGoFk7ylEghvDAuthY+dnu9RzoG2PzcJikWxZLugvq7u/DZ9XZH/SwbuMprhQah2EAxDVz+Rsx1GWhFwnWwlj/66xaMGOmP6nKvl4F2E4RburYsGJ6ol0/9vdU82HbnicXU/OuwVVI6MIMPx+fXHnIn0uNUtqxCk2s5nTpPOLmeXA47CTmwNuivaEvtt7ZJf1quWYt11VbTqZCawxgrzmdIRdfS1rzWiES8FTDADbENXPpeDRMYVvOoQwChpME4maW5XWe+4bNc4JTRv7zAatJlVAyAjc8z5NU9W1VV2ZqEddm53NhJ1m3N3+l+K36Fqrz4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wsrWFwwxmuB4lEDyyGIfS9yT4/clx/pPsew7D+uWJZ8=;
 b=mygVivVQxTDVgfTam9xpDbr0E1Q+eZW9uQ2s6cdqJmHu4/f6tyrMRrjDvC1U2YVOGGbd4jZ8kWSIE4nn/MHBjJR++LRa+2GMzP9aPdU5YzqEnjffILjdnF7DuNCHb/345gSXXSS8FrpA2qgyBsQXrEUug3+PTHGpzFvSvoyzx6E=
Received: from MN0P223CA0005.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:52b::22)
 by SA1PR19MB6622.namprd19.prod.outlook.com (2603:10b6:806:255::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.20; Sat, 25 Jan
 2025 17:44:02 +0000
Received: from BL02EPF0002992C.namprd02.prod.outlook.com
 (2603:10b6:208:52b:cafe::3d) by MN0P223CA0005.outlook.office365.com
 (2603:10b6:208:52b::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.21 via Frontend Transport; Sat,
 25 Jan 2025 17:44:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 BL02EPF0002992C.mail.protection.outlook.com (10.167.249.57) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.8
 via Frontend Transport; Sat, 25 Jan 2025 17:44:02 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id 2E78D58;
	Sat, 25 Jan 2025 17:44:01 +0000 (UTC)
From: Bernd Schubert <bschubert@ddn.com>
Date: Sat, 25 Jan 2025 18:43:56 +0100
Subject: [PATCH v2 1/7] fuse: Access fuse_req under lock in
 fuse_uring_req_end
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250125-optimize-fuse-uring-req-timeouts-v2-1-7771a2300343@ddn.com>
References: <20250125-optimize-fuse-uring-req-timeouts-v2-0-7771a2300343@ddn.com>
In-Reply-To: <20250125-optimize-fuse-uring-req-timeouts-v2-0-7771a2300343@ddn.com>
To: Miklos Szeredi <miklos@szeredi.hu>, 
 Pavel Begunkov <asml.silence@gmail.com>, Luis Henriques <luis@igalia.com>
Cc: linux-fsdevel@vger.kernel.org, Joanne Koong <joannelkoong@gmail.com>, 
 Bernd Schubert <bschubert@ddn.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737827039; l=1546;
 i=bschubert@ddn.com; s=20240529; h=from:subject:message-id;
 bh=9pIH8SQN7l30Y0x3YkGM4lsHwYA/oWC7Cwq+mNoGsO4=;
 b=NW2w8z8qZC9zbO1RrJagoqknn1z2ixwQm+DugVAOUW9MSpwP7EmblP3o+pnAfuXaDITzMeTKu
 fbIS6/Wxi9GA4MEO6Vyuf4xK9UYydfjSG+q9pbSw2SYx1KfPVqQl1BS
X-Developer-Key: i=bschubert@ddn.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992C:EE_|SA1PR19MB6622:EE_
X-MS-Office365-Filtering-Correlation-Id: c71344bd-f1a0-4cec-207b-08dd3d67db31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OGx3SDJ6NkZHYllDRmpPbGVDWSswcUM0VzJ2ZlJhTlkrVGhRbFJPY3NoUGxt?=
 =?utf-8?B?UUhWOWNXWlMwZm1ENEpkNmFjeEdma3lLaUpNQjE0WVpXNkozMjNWMk5RRzdW?=
 =?utf-8?B?RWJNVUZMdlZkUUFrcWRDcTFLS1JDYWZjVU1nenY3c1RQZmJKVTk2NGxPSWVM?=
 =?utf-8?B?UCt2L0dENDJiTWh0ZzBOTzFodS9MT0d6ZktXR2F5ZmJpbXRTY1BneEpwajJs?=
 =?utf-8?B?SmJDMi9PeDMrbE90a2hUMGxDU1o3K1l4aGNHZE9wUTRNVGlxNGI2bU9tRzd1?=
 =?utf-8?B?bDZLQ2VXUVJxR2dYZW9jTUZybDN3ZXNFNnVPYVJKVDY1QkhydU5jM3YrbVZK?=
 =?utf-8?B?WjcrR2MvZ3F6QmdwNjFsVVZYaUFhbEY5UlFEbXU0bmlVMExzSFQrR3BvVnhP?=
 =?utf-8?B?V1NPTHlqVnRlbWJJM0VzaWZzanNVK3NBbGE5OGVHZHZIUE1GOFQ0bWpzRmZE?=
 =?utf-8?B?WGgxZGNUWVdIQklLOHhYMGpTUllNdzRxZlVQeEJ3aVVmOEZFdmEzbVJ4dndH?=
 =?utf-8?B?SDh3K0NDV1hybHYzbVlJV1NQelhra1NsVkRTMjhaU2ZYOHR5UWFhNW1MdGVS?=
 =?utf-8?B?NHJzeS9IR0Vya1pEOFVrZWtDUmdjeTl6OVUzT0VsVnBFQkdTZUp4SHFHZVVt?=
 =?utf-8?B?djg3K1QrTnB6SmUxVnNXSDN4RGd2R3ZFT0o0SGxCMHpzRXBIbWtxdUZMK0RK?=
 =?utf-8?B?eHJhVVB3WDZIZ2lWSWQxbERxaDNQTE43K3Y0cVdSc3MvckQ4ZHZicW5BMHRu?=
 =?utf-8?B?cFN3RkIzeHUvVUZlT2RiWFlITGpqR2puUlpkOUQ1RUFONU5jZERpSTh3bnVE?=
 =?utf-8?B?Vit0VlJVRUxIZWVKbHNwRzY2S3JjVzliVjZqTGxnNXlIWUpNVjlEQ3cxSVpY?=
 =?utf-8?B?emlHcmRKanRSVzZaWmFaQzNWV29yQlFwTmpBWW5KQjA3YUxOWWtZUHlVc2s2?=
 =?utf-8?B?bHl2K3FkSUIydkVWbnRRTnl3OEdNRnluNWVGdTBXSXJCMnFMekZKZTJLMytQ?=
 =?utf-8?B?bTVyZFM5S3JXMVlLQkRzK1UyOEtoc1ZEQ0EwMnlPc2VzUVNyRkVnN2Y3UkJH?=
 =?utf-8?B?eXlubEJsZklvNEt4elk2TzZPdlEyUGxjZm5WL29YclpTdzVEUlBoVlJTOG5y?=
 =?utf-8?B?aE5EUG9jTmdKM3ZsdWRsV0lKMXBGM3FoWC9MdDBBY0FENHY1NlFCN2xPOS9s?=
 =?utf-8?B?M2FlZUtyR25aS1ZNTTRWZEphOCt2WDYvVThMbHEyTVVQalBrSmJ5N0s4TnM3?=
 =?utf-8?B?WWQyVmFQQWlOOGg2Q1c4SVhqT2pGUXdYWCtRUndiSGw5WFpxN2picWdJR2pH?=
 =?utf-8?B?L1pBK1NnVUQwWEJDVzJvR1Z3MVhSL3NhbDM0dkxTMmRnSEFkdk55ZmhoeEg1?=
 =?utf-8?B?aHhObkpKTjcrVVc0Z25NeW05T3RHcUdxOEs3aWtXRXJ5V2M0U2xqRklQdGQr?=
 =?utf-8?B?U21TVzFUVjVRMHN5Yi8wN1hsYzVMVVBaYjMzN2NsUEtEKytIQkVqcHhoUnlo?=
 =?utf-8?B?eGY2bUVHZEtsNzhtMzRXQy9LRzZoZEg0UkFueENBS3dEanM2aHNrNnB4Y21y?=
 =?utf-8?B?Mk4vVUduRE1WUDZzakNISEpGWnlhZFlKVllzemdBM3JRMGxuUndmbEdzemJa?=
 =?utf-8?B?SWY1Y29wOGgwcXgwVDBPMWdnY3FvM1FsalB1bjhaWllGYmx0YVFST1dSVVBv?=
 =?utf-8?B?TmZQSnFLZXQvcGNzcG9YcGhtU0RuSzNyYjRDZ2V2bEw2OGU3RVpmNktqaXQy?=
 =?utf-8?B?Tnh3ang4NTVyTXg3RTNhbCtIV1p0T0tUWmpyNi9jb0RMZy9ORXg4ZThKekZw?=
 =?utf-8?B?cEF4b1Z3WFFVanNqbVlQV3RKUnlnMU4weEVZNXdKYUM3VTNkMGNla3JKZmZm?=
 =?utf-8?B?SThKZXlQUDRDNDVYNE1ISDRrZlZzYXY3MDlWWm4zVlB1bHZORHZ2NFN5M083?=
 =?utf-8?B?NXRZamJVVXE3dlJrVE12MGt4eGJ0TmxUWW9oZHpMZmNaYVZYUitlbzhVbEN5?=
 =?utf-8?Q?bKvmLjoaBnl1kZYB2Y4mx7Pd2ix3Hw=3D?=
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	aFhUhhAjnWs+yXBU6tMbndUPRHTPhQjRMYwjP5ySASQ7EJ7bW6Q92WnZO90WCvpntE7uCGjIngUVDWsddjOYBnNZShPlzsYpMW3qQe/Rq4JA7JdVahJ8yYw52yMRsSK09/GPBisqRBzOQqLiqdrRx+Rgm8OvZCMyBs3tKNfFEP8ysN3DwkpUicmZiAETXl8/gKRYROVc7ZQ/bGkyCvhKMLoOZ+g8X3YCXyfDzP6T6zYh1uP0nY6U10gXwVR3+Pe0bXJ0aOTHPB57JykdM0HBIPOP4LjNRmHS2RlXdkbYlP+i93ixvOJY+/6HFWilnARtmUIoxA3xP84kHC5oVAaJPLDpc5ukzBnwbuw1K6d7vZRJrEzEL7QxQmzhcIL+RLq3FlpIsSAVy77QklKxwwIZP5LPp5Bri62WBfrRWQVO+xM3JzJwAaxVenfX5o0zGrm6k8V3krCdqEQCzh7CwISyXGTioTapQlKwcE3QtxETF8pDxLQdlns3jdZTCHWWxEF5X+hi+Ch6bs+ogpE+0yLEESW0q/UV/jm9VzrZayhnBgveDt4MxH7X0qVFLCPnkpoehvOyagXEJD/mywTMT4H5edpjdSayNIiNsSDboNOqC3befznDJgG5ISicVS+QQ0E/pf5cQmNSurASbYFEysxpYw==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2025 17:44:02.2646
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c71344bd-f1a0-4cec-207b-08dd3d67db31
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR19MB6622
X-BESS-ID: 1737827046-102262-13353-247966-1
X-BESS-VER: 2019.1_20250123.1616
X-BESS-Apparent-Source-IP: 104.47.56.40
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoamBoZAVgZQ0MIkKdEyxSDFyM
	TEwtTIONHUJMUk2cQw2Tg1Odks0chIqTYWANel82ZBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.262052 [from 
	cloudscan14-221.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

We should better read and set ent->fuse_req while holding
a lock, at it can be accessed from other threads, for
example during teardown.

This was part of a patch from Joanne for timeout optimizations
and I had split it out.

Fixes: a4bdb3d786c0 ("fuse: enable fuse-over-io-uring")
Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
 fs/fuse/dev_uring.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index 5c9b5a5fb7f7539149840378e224eb640cf8ef08..2477bbdfcbab7cd27a513bbcf9b6ed69e90d2e72 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -78,12 +78,14 @@ static void fuse_uring_flush_bg(struct fuse_ring_queue *queue)
 static void fuse_uring_req_end(struct fuse_ring_ent *ent, int error)
 {
 	struct fuse_ring_queue *queue = ent->queue;
-	struct fuse_req *req = ent->fuse_req;
+	struct fuse_req *req;
 	struct fuse_ring *ring = queue->ring;
 	struct fuse_conn *fc = ring->fc;
 
 	lockdep_assert_not_held(&queue->lock);
 	spin_lock(&queue->lock);
+	req = ent->fuse_req;
+	ent->fuse_req = NULL;
 	if (test_bit(FR_BACKGROUND, &req->flags)) {
 		queue->active_background--;
 		spin_lock(&fc->bg_lock);
@@ -97,8 +99,7 @@ static void fuse_uring_req_end(struct fuse_ring_ent *ent, int error)
 		req->out.h.error = error;
 
 	clear_bit(FR_SENT, &req->flags);
-	fuse_request_end(ent->fuse_req);
-	ent->fuse_req = NULL;
+	fuse_request_end(req);
 }
 
 /* Abort all list queued request on the given ring queue */

-- 
2.43.0


