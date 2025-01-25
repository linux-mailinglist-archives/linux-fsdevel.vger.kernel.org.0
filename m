Return-Path: <linux-fsdevel+bounces-40116-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE128A1C4B4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Jan 2025 18:44:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FD34165A1B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Jan 2025 17:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E06A8634D;
	Sat, 25 Jan 2025 17:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="Ew3k9b4d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip191b.ess.barracuda.com (outbound-ip191b.ess.barracuda.com [209.222.82.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D544C7346F
	for <linux-fsdevel@vger.kernel.org>; Sat, 25 Jan 2025 17:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737827066; cv=fail; b=W91/qxaq2yTFfQsTF4TV5qRU5XsRa2TSyl/oO6fMPnWdBKX/ZvNJbFC8Zjvq6KtuRIFeuIFGP5ViMA0T0f5evhtd9fuzOlPZZ+cPNE2zF0xQ7RMBU/Swt2GYqzk0m5biTiVq1h6WrJtXsqACRivSGaAKaJ6IMIK2ZpU7LHbrV3s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737827066; c=relaxed/simple;
	bh=8ViY751sXI0roqKjjWjbzj1DUuxSYU/09ekd/2WhF8Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LtCmR79pYQC729m9nbrVBgRVqFjNdGeZU2s5uwnih7GjCaFWzc4O0TV69bsCe4soG/OVQjck3lpS3n09brk+RjphHfawqtLtXXfclrnjzWlx7fC6lPCB5okJKOyexmQ4p5+twpSzRPH88RtLhe3sRrryKqXlSHPSfzLzA4tnAo8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=Ew3k9b4d; arc=fail smtp.client-ip=209.222.82.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175]) by mx-outbound17-96.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Sat, 25 Jan 2025 17:44:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TiCLUE9qsf6YQ/ENzvncao7EEhcPiai6csZFJDGgnjEGta2N59ZOOSqj9JbiC8GZS/ANEtzM9+aq/mod7ZAITmCUru/u1hfWhRrWVAN/kbKi61RhcZUb3BtV6ftsdFqLQnaaBrxX7miKyMSrDOFcxv3oke3LrlmquKqqNoD6yAqFSLxSXSraALiVahLRm+U3aWH5pa9OqymZY087Y9ftXoB+3sqhkCzloKMO6lukhlDmwPK8aZKLxUARm3wS0VvSskDW3jv4LD8unrmmE4c4Zr7PJQSkx5F+Q8Am4+voFt6+fOdNwKZt++BrsxdL/pIgteHSOFT55i4fpVMwCdYfew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WxUuYZgtPj62MR57a4H9xDcQAms7H/7ePxsxw+gPzEs=;
 b=XMaQ0zb9CCyX3mHK/e5VbS/gLIaCQuBGgVkL//Ft2eSoYwWSHypsWxeOWcEOPcPSMCRFamlPHZ/In2ynFubqtYM/yCyNZbO+0z6R6CqJjYBWcLDv5yruToUKK0nrhg8QqEk/SrNaUpQzf+Q7Xp9JAh4AdWvHMcvk8l3lNG7SZyOJBqVu196T76rGIDc6lAU6eXcHX90Mdr8CKoTgh21SvCUZWi8jSzelP2THaj2ThrxXVMaBNnNsrz7Y3ZqE1JawkF+Wp9/0m3kjdqTJZ1cSzRd13hjUfUV704A7lGhtYl+OZE+aVBmT2ygMhOFwP4coT8l5nnmMs7tm+Hu/ovhOnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WxUuYZgtPj62MR57a4H9xDcQAms7H/7ePxsxw+gPzEs=;
 b=Ew3k9b4dvgp9VdhgC4oSn9UtI6MTDZ8SIy4rw/2v/z5sLnoWgcSOYwPlxTooyjTh2qVchV8ahk0bwGevz/8bPtLTyJilCDv0pGSFOmMEjOlUeTOmvxKnwJUhyKXBw0F4ve5Ln9dknOVhqSKQ0x6BtKTW+Zh5PUVlByYJ5y953Bg=
Received: from BN9P220CA0025.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::30)
 by DM4PR19MB7971.namprd19.prod.outlook.com (2603:10b6:8:185::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.20; Sat, 25 Jan
 2025 17:44:06 +0000
Received: from BN3PEPF0000B06F.namprd21.prod.outlook.com
 (2603:10b6:408:13e:cafe::2a) by BN9P220CA0025.outlook.office365.com
 (2603:10b6:408:13e::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.21 via Frontend Transport; Sat,
 25 Jan 2025 17:44:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 BN3PEPF0000B06F.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.0
 via Frontend Transport; Sat, 25 Jan 2025 17:44:06 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id 1D38F34;
	Sat, 25 Jan 2025 17:44:05 +0000 (UTC)
From: Bernd Schubert <bschubert@ddn.com>
Date: Sat, 25 Jan 2025 18:44:00 +0100
Subject: [PATCH v2 5/7] fuse: use locked req consistently in
 fuse_uring_next_fuse_req()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250125-optimize-fuse-uring-req-timeouts-v2-5-7771a2300343@ddn.com>
References: <20250125-optimize-fuse-uring-req-timeouts-v2-0-7771a2300343@ddn.com>
In-Reply-To: <20250125-optimize-fuse-uring-req-timeouts-v2-0-7771a2300343@ddn.com>
To: Miklos Szeredi <miklos@szeredi.hu>, 
 Pavel Begunkov <asml.silence@gmail.com>, Luis Henriques <luis@igalia.com>
Cc: linux-fsdevel@vger.kernel.org, Joanne Koong <joannelkoong@gmail.com>, 
 Bernd Schubert <bschubert@ddn.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737827039; l=3287;
 i=bschubert@ddn.com; s=20240529; h=from:subject:message-id;
 bh=8ViY751sXI0roqKjjWjbzj1DUuxSYU/09ekd/2WhF8Q=;
 b=1E48PmMbqqoXbKq6KFTj5yMo++1ll3fUR0g7haN57ozyJbEWQqdKWw7m0kGg9z4UjBX63u7aJ
 9JB4ThLErPWBL2W/CWRvRk3k9yAAyQCLpCE8S1tmAhILQPSdw7Ue5JJ
X-Developer-Key: i=bschubert@ddn.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06F:EE_|DM4PR19MB7971:EE_
X-MS-Office365-Filtering-Correlation-Id: fab79d5e-6712-4d00-2ff2-08dd3d67dd74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SnVwUWtDSHppRytQcWV0N25GWFk5Y1lXU3RzT0ppS0tYVUF4YmQxb1F5NkhL?=
 =?utf-8?B?UjBtdldlOHVWNVEraWkxeVFlU1dEdzdUMWtWUGNibkZtb1RUeTAyWjhxQ3Zk?=
 =?utf-8?B?eU9JV2JZbTkvVzIrWTJObmUxRUo5UzIrZmpJVzlJckV1akxMMTZYeTk0Visy?=
 =?utf-8?B?UWFBak5scUhoUXlVRklVZEdHclpkOHBKeU80S2dNenBTSncvWGJyVjQvYjRC?=
 =?utf-8?B?ckwxZVp5MHlKZjBJdHF3dmNvNU9ydDJUSFAzMGF4WDgvOU8zODMvZEY2L0cx?=
 =?utf-8?B?alkvZG1zRDFKNUx3ZE5DUFhPbVRYQ0JMeXgrVno5Z2pqZ2ttVFEwbU9zaVJ5?=
 =?utf-8?B?M3FjTGNiSHlubXZ6bVdqelJqOHRONnNLdGd0NWd0NGdJbXE1SittcTJzSFdj?=
 =?utf-8?B?dUNjN01nYTFCajh2QmIxS0t4T1hZSlYwOXllV1phdElIR1NEbUJ5ZThEOXIy?=
 =?utf-8?B?SEZIT1hsd3JuQWJKUzAwUlR5NUw4ODIwSjg2MVVlR1YrZUtMbXlJVXlNZkxN?=
 =?utf-8?B?N0R4WjJ5RjhUbklCSjcxUXdMQXYreVQ4Q3BYMVNWZHV5NWgyTVM0TFM0RU5H?=
 =?utf-8?B?L0puR1o3N2N0aGlVZGVSTzM4QmRoMzdhS3NGZ2FLaGtBYm5oNU0zai8zcDBi?=
 =?utf-8?B?RFlTY002QVgyOHAyRllxRHFnR3dLbjJVZUFvNHJuN0JJNVdWczNsWEFJbHBI?=
 =?utf-8?B?QU54a1ByVkw3Q1JBS1lVOGtLaVBUSWIrTWdaVFM0NTNCUnhycUpSMGhZSmZs?=
 =?utf-8?B?ZHhVNENXeFAxZ2l3MHFMcWNSaDRJdkVvSUhBeVZjQjZFS2FybXNjandwdFNs?=
 =?utf-8?B?aEpjbG5TTE8vWGltK2g2ZVNFWm9SWUtlMFlaN1c2aElKVXlzaVM4WVg3TTdr?=
 =?utf-8?B?UlFUMzFFMjdOQTl2VFJTcDF4MWlOVVRaZmlPYURDRTdaQ1FZZjZiOU1lMFpY?=
 =?utf-8?B?R0lUWWxKdjdnY0ppd1Fxd3dVZWxNMTU4ZzFwQ1RQNzJlMzFkZGFiN3h0WEM0?=
 =?utf-8?B?amhvdkdRRDZxY2diUzRQemhtZDhPRU5iZjdjRktFN1VzT2Z5RU1ZajFTRW05?=
 =?utf-8?B?SVQ3bXovUXYyMWNYUW4zZ1hOT1hKbzF4TFBjSTdKNERsNzRUZjFxNXVmbWtP?=
 =?utf-8?B?QWo4RWU2eDZVVGd4RFp2K3JqeUE2ZG84L3dBZzA1S2ZRTTB0cHVuc0V4R1hI?=
 =?utf-8?B?QXd2S3hqUTRzRkQ5R0ZDME16NjdWZDRBckJKUEM4c0ZlSDFKZGFIYVlEa0Ez?=
 =?utf-8?B?alE1Q3poUFkxQTNXTlVzelEwVzVYVzEvTEszMWlYdjRaaHVYRFFOSWVONWoz?=
 =?utf-8?B?ZGxmendUQUIzL2pvODJncWNpOVFaS29IaXAwdTdYc2l0MUNlQTM0Vi8xSFF1?=
 =?utf-8?B?QldaOWtQUmRJS0R0Z0t5bFpwaU55eGluRUtXbG9Wb2UrSDdxVHZjNS9iZkhj?=
 =?utf-8?B?dHQ5OEJpdnVrY2lwQk9PcWIwQWVwMUR0bDE4MkNDRjhpcGxkR3NFRndPaElD?=
 =?utf-8?B?Q2RFSkFjaFVCakxFZVpWZFFlU3EzeVBOdEI0Z0MybXY3eEszMHVVekMvT3ZG?=
 =?utf-8?B?Y0h0UmNqTUpZTUs1ekNhVVN4WHRSRE5PK3FTTG9WQ2FBNVgxUDVrZHlsVFFn?=
 =?utf-8?B?Yjh0clRaOFphbDFvN0VyS2ZBQWxXbUs5SnVlMjltTGYyK2dJTTlCU2g0VE1I?=
 =?utf-8?B?MXQzLzBpaitEclc4ZGw3NGtzd2RrK2lRbFU5c2s4S1hWMEpDT09NbUtVTkE4?=
 =?utf-8?B?RStSVjE2MElCR2lZVStsUS9VdFVoYlJwRXloQ29UQk4wTXlzbFIvQkpOK2hG?=
 =?utf-8?B?VWErNEVUaUU2Q2NUajAzV1RSOWVsWDhJbG0rNHptS1FuWVExM0JrMTNyb2Nw?=
 =?utf-8?B?c2MwQUJKOVgwbEdjdllVMFdoNmVmSlJwSEpwdng4S04zRW53TEZLNG5pOGZ5?=
 =?utf-8?B?WXJHMWZhSktyTkVqejRCdjUwWnJwT1Z1L2RPcnpJcUJsZmlSVDBRbVFwaGJV?=
 =?utf-8?Q?px1BDW0G1OQIZ86cV5kmfiYrVJxWSg=3D?=
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	tJkGKFAKOUowDeRjkcK4yCt5gk3xXd362faY2NT2SI8XZpsIIREyg75BvojAcWs2dVWLM+BYFpNInxy2SWSSAXJ+1kf9S4dJf0Yi3c2NhoJw00KwXbr/2wZ1HuO1xK9TNRoEAhBCshztOJVJjzKuAj28rCQwm4GchejgiTeftcoXf/D56Lr5brmzx/Mk6QLt0JIE66kyjLexfSkKcQwxg5xpknG4ac0KcoBR+nyblEkaL2BQ68FfjN6KU9zBEXV4JuGnaQHTxlqYO67Lw+v9XYnJOHWMQhsjByV9lCwHWyTzRgqQ5kwYZTeXK/B63+ALMSxXQK0TuzuDRnzsCh7Ta6yfWxUNYShk9iyFp/GgMLmduYx/dArUk81IpGLt+qkqA8vsAkpsXusN9cI9hHhp8cOZ6JV872DHnPUY4lwN52ptFkL2xnaJjHUCxAyOkXrPHku96ZSIGGiPbZjr4GRcBdRSvJjOsTmP4jP0i+5/vJXoASn/s+JLXLHCqWnqEEMyvm8rez5HWw8nclpWHdGfGnxTh7ZPwlXv+AOJDwTzY8LntwI8j7g4A1f8XvdfvpMVMYXQGOGq1gw4LEFIHbPd/Zvejj0HbbENeSQs+E3m/pl9jr4rILityP0dqafFd0vOkEp2yV2+SH1KWhLd8GgAVw==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2025 17:44:06.1220
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fab79d5e-6712-4d00-2ff2-08dd3d67dd74
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR19MB7971
X-BESS-ID: 1737827050-104448-13353-1019-1
X-BESS-VER: 2019.1_20250123.1616
X-BESS-Apparent-Source-IP: 104.47.58.175
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVsaG5pZAVgZQ0NDQwDjFINHCwi
	jZOM3MwjTRLNHQzCLN1MLIwNjc3NxQqTYWAOoP0QtBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.262052 [from 
	cloudscan21-118.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

This changes fuse_uring_next_fuse_req() and subfunctions
to use req obtained with a lock to avoid possible issues by
compiler induced re-ordering.

Also fix a function comment, that was missed during previous
code refactoring.

Fixes: a4bdb3d786c0 ("fuse: enable fuse-over-io-uring")
Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
 fs/fuse/dev_uring.c | 32 ++++++++++++--------------------
 1 file changed, 12 insertions(+), 20 deletions(-)

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index 80bb7396a8410022bbef1efa0522974bda77c81a..e90dd4ae5b2133e427855f1b0e60b73f008f7bc9 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -75,16 +75,15 @@ static void fuse_uring_flush_bg(struct fuse_ring_queue *queue)
 	}
 }
 
-static void fuse_uring_req_end(struct fuse_ring_ent *ent, int error)
+static void fuse_uring_req_end(struct fuse_ring_ent *ent, struct fuse_req *req,
+			       int error)
 {
 	struct fuse_ring_queue *queue = ent->queue;
-	struct fuse_req *req;
 	struct fuse_ring *ring = queue->ring;
 	struct fuse_conn *fc = ring->fc;
 
 	lockdep_assert_not_held(&queue->lock);
 	spin_lock(&queue->lock);
-	req = ent->fuse_req;
 	ent->fuse_req = NULL;
 	if (test_bit(FR_BACKGROUND, &req->flags)) {
 		queue->active_background--;
@@ -684,7 +683,7 @@ static int fuse_uring_prepare_send(struct fuse_ring_ent *ent,
 	if (!err)
 		set_bit(FR_SENT, &req->flags);
 	else
-		fuse_uring_req_end(ent, err);
+		fuse_uring_req_end(ent, req, err);
 
 	return err;
 }
@@ -768,12 +767,8 @@ static void fuse_uring_add_req_to_ring_ent(struct fuse_ring_ent *ent,
 	fuse_uring_add_to_pq(ent, req);
 }
 
-/*
- * Release the ring entry and fetch the next fuse request if available
- *
- * @return true if a new request has been fetched
- */
-static bool fuse_uring_ent_assign_req(struct fuse_ring_ent *ent)
+/* Fetch the next fuse request if available */
+static struct fuse_req *fuse_uring_ent_assign_req(struct fuse_ring_ent *ent)
 	__must_hold(&queue->lock)
 {
 	struct fuse_req *req;
@@ -784,12 +779,10 @@ static bool fuse_uring_ent_assign_req(struct fuse_ring_ent *ent)
 
 	/* get and assign the next entry while it is still holding the lock */
 	req = list_first_entry_or_null(req_queue, struct fuse_req, list);
-	if (req) {
+	if (req)
 		fuse_uring_add_req_to_ring_ent(ent, req);
-		return true;
-	}
 
-	return false;
+	return req;
 }
 
 /*
@@ -819,7 +812,7 @@ static void fuse_uring_commit(struct fuse_ring_ent *ent, struct fuse_req *req,
 
 	err = fuse_uring_copy_from_ring(ring, req, ent);
 out:
-	fuse_uring_req_end(ent, err);
+	fuse_uring_req_end(ent, req, err);
 }
 
 /*
@@ -830,17 +823,16 @@ static void fuse_uring_next_fuse_req(struct fuse_ring_ent *ent,
 				     unsigned int issue_flags)
 {
 	int err;
-	bool has_next;
+	struct fuse_req *req;
 
 retry:
 	spin_lock(&queue->lock);
 	fuse_uring_ent_avail(ent, queue);
-	has_next = fuse_uring_ent_assign_req(ent);
+	req = fuse_uring_ent_assign_req(ent);
 	spin_unlock(&queue->lock);
 
-	if (has_next) {
-		err = fuse_uring_send_next_to_ring(ent, ent->fuse_req,
-						   issue_flags);
+	if (req) {
+		err = fuse_uring_send_next_to_ring(ent, req, issue_flags);
 		if (err)
 			goto retry;
 	}

-- 
2.43.0


