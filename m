Return-Path: <linux-fsdevel+bounces-75508-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mGz3DQ6xd2k3kQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75508-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 19:23:10 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE048C0E0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 19:23:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0043330080A9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 18:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EEFC3081D2;
	Mon, 26 Jan 2026 18:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="b2dB3R9i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11020085.outbound.protection.outlook.com [52.101.85.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5581DE8BE;
	Mon, 26 Jan 2026 18:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769451779; cv=fail; b=Wa2H2EmxwdK2l1Cfs/4Ew0OL72OcISOAJvtnGnLznTPaw42DE+gGkvezHlT7f45VyrFKpHgLNEkZo0EEkiTFGhX2R2PnnYGtZMsPzsWW/7AU+n+jiE8kC6VjKuIum8IDV33Wt+H4AAnKcyytlmTJ33STQ3Mt8aDpkCv49Pv/J+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769451779; c=relaxed/simple;
	bh=b1YuXGoY3GYMoe5hb7IsJ5KbjhVcV8/2e6oi6QWZm+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N0yOKXLX5sJRtNSQsXU3ueW7UUc8BsOzwTwanjNDK9BhbkMDlm+lbHnxTsDz2iYGPiIsgaX3beDmGoI/rBRqLh4e3Ux5SQwCk5OJjwQKaOr8EnG4wPFIIsHnq/uh8Ly/geCvhSyTanlhhaI28+zsEhwzTsfFS1KhpHVTVrc4nt8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=b2dB3R9i; arc=fail smtp.client-ip=52.101.85.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fAVE3n/xy9QwwZ2t+xdK83M/DanX+m9ZR5D85azqEQBXJCSx6n5mQOFxCwF6Sok+D7oAy432cuLp9sfs0IYfpoTpU357akbPXDyVoWTA9U0G/0pvDHGkx0tfphNbwJ9jdKsQupQgyRfqWxgY8+RXsgSqOrIewLSD4nwYfBGXSZ3PjWPmf1iUHVOHIaMbon0Nbq5F4kn04R2UdhxxHvdJbafBsHSZjMghTs5I6E4x37+gvaESgwMv2x4XtWrLfKncukTgYC3QLSfP+ww/CpwBWkxlmJEyQJ/bP5Rs3+KbX0ug0fXZwAkonRwAbAMRT6QPXx1OOJ27D53yM93/UQWUFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HNcaxp5SWML22oSPFy+lTtOBVBs12B+yWB51xaFix9w=;
 b=ZVUrL8/t5FSpRA/AT1KDt3SiTYWZRU72p4P/f37Kubfew/z91+jLkD4wlqZiq57PtzZLQlIkcnNfNxy8lHIBmMzpYbDhZOXhYTcVpudLFYBRio3PXU0O/GQdav2zGy8gQwFKXMnK8eL5C77TENH34sYzdqjG9EKCYgR9zFOTrNmij737VnmDO+Aq/7NofhdOtmMAHOfj9cYpF8/bZei+9q/ZesKUvcvOSXMLKuC84E9WLHm68339e6mZxRYsOgj9WqNEDIZ1qmDyviPI3VprJRgzcr9Jc9BI2oz/nEEneq4qzsgU9pBOWGP9FgEgzsuApa/2tBLVar2wexKN3Rzzwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HNcaxp5SWML22oSPFy+lTtOBVBs12B+yWB51xaFix9w=;
 b=b2dB3R9ifwvrhQuae8lnEx2CpLy9AQX9cO5LBCATXxvC2z1ardvdlqX5MGqdYnxZPsylaDfQDL9a2uUSCAYgxyPvHCZR03NYihxZsxy1NQ1dTGfTZdhiqxNbvRyOxo8D58ehoWNRpmCnbTJAiHzWIuy7svybkZfENkeBSt2tmoY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from DM8PR13MB5239.namprd13.prod.outlook.com (2603:10b6:5:314::5) by
 SA0PR13MB3934.namprd13.prod.outlook.com (2603:10b6:806:92::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.12; Mon, 26 Jan 2026 18:22:53 +0000
Received: from DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3]) by DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3%4]) with mapi id 15.20.9542.010; Mon, 26 Jan 2026
 18:22:53 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: Chuck Lever <cel@kernel.org>
Cc: Trond Myklebust <trondmy@kernel.org>, NeilBrown <neil@brown.name>,
 Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 Anna Schumaker <anna@kernel.org>, Eric Biggers <ebiggers@kernel.org>,
 Rick Macklem <rick.macklem@gmail.com>, linux-nfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH v2 3/3] NFSD: Sign filehandles
Date: Mon, 26 Jan 2026 13:22:49 -0500
X-Mailer: MailMate (2.0r6272)
Message-ID: <D3263C1D-A15E-48EC-B05A-8DC6A0C2B37A@hammerspace.com>
In-Reply-To: <33c02e5a-03e7-42ef-8ccd-790a9b29a763@kernel.org>
References: <> <e545c35e-31fc-4069-8d83-1f9585e82532@app.fastmail.com>
 <176921979948.16766.5458950508894093690@noble.neil.brown.name>
 <686CBEE5-D524-409D-8508-D3D48706CC02@hammerspace.com>
 <77e7a645-66bd-4ce2-b963-2a2488595b00@kernel.org>
 <8be0a065a84bed02735141b4333e9c49a2ab0c90.camel@kernel.org>
 <33c02e5a-03e7-42ef-8ccd-790a9b29a763@kernel.org>
Content-Type: text/plain
X-ClientProxiedBy: PH8P223CA0022.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:510:2db::27) To DM8PR13MB5239.namprd13.prod.outlook.com
 (2603:10b6:5:314::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR13MB5239:EE_|SA0PR13MB3934:EE_
X-MS-Office365-Filtering-Correlation-Id: 16d0d6b7-e68c-426c-936e-08de5d07eb61
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AFadxF2F8SmTkny+/cF40bPOr29Q9Pz+J+twLHIuy4a934HL0tkY9OnxP9vq?=
 =?us-ascii?Q?WxtBKO+9qKLvoWMiCb55l9AYlyrl0M/691VCqLTW6wrUpzZotMAuuBHS8AAQ?=
 =?us-ascii?Q?uvQhgWGvntOfczUKEUYB4DxBNsLivQ01GmvGKf3wavBSZPBMsopBZ2l8rsaR?=
 =?us-ascii?Q?fOvM+hHaRlmk8QOQvo+7GvVEiCk21EyRdTYcZQ5njUUmt6epCXpd5jljS9LW?=
 =?us-ascii?Q?1qOkfVrRjrpmTub8n8l9RgFVJfnko/exxsOKK9vC6XKa+GAHHPUjtexVMdH8?=
 =?us-ascii?Q?gS1xs1at1tP3y/ZFBh/Bg6z4R0GZxgL7L1jJ7bVYZ+ScD+wuBYccGF1rVSsU?=
 =?us-ascii?Q?N4WfqhS8ZXLD35x70sL+bh7FR5Y8C7zXQomfda6L3GrkeSHuKz2ArK7JlwvK?=
 =?us-ascii?Q?vSHf572kZ3JO4WXz8ufhLYyFTdxpGCjbxqKB/38shb+SkukEgt1DE4zSI9fi?=
 =?us-ascii?Q?M51KV4CTvUpi+iFgSIpV6WFvHEZsM2z6NHvXMkt24PoDT1t/nIqdmZv8o1jF?=
 =?us-ascii?Q?qruRXMKe2GYxPn56iv3LcSYb9TYPlX0F4tM+rqTslUROFghVaYjbInZDenuR?=
 =?us-ascii?Q?q86wCtfK3a6+7Dbf7zdQwrpiUkRfJnnAkbC64AVGKY9LVvcfAgnOciyqTgo2?=
 =?us-ascii?Q?OAN3948hIrQm0uW8Q2Z2tjmiMzllZs8tFcEnVPrZR/vphB+S07q28WfVj/A2?=
 =?us-ascii?Q?t+/2hBklVIr5NqqvAWvWt+cEHiqihwWxtJyU8D/9wdF38/QEKFC+zuEaOgrh?=
 =?us-ascii?Q?D0t5mWfCiu4d7mZ/lfNHMM1NRw36srmWLKx+tEBV1AS/8Ldwq3SJ+51ojbrv?=
 =?us-ascii?Q?M1xwbWnZFz8spfTylVIugUMGiro49WgLvpetBlrQ+1/2P7VN8IL3IK7HJMdq?=
 =?us-ascii?Q?3rJqjVlfXM6vWinFPkEMyW9jqUDP0VbxVejxFGq1qkM+q2Z3DNqZzsO7CZ2V?=
 =?us-ascii?Q?H88rsDpnRw577l8fPJnczNjU6hpxsseIkrXuvgzNIXr1v/yDNmTf0gjM3sMN?=
 =?us-ascii?Q?aAauRTHhSLbVxAM7dyGhrWXMGubTbfKJ4unpM9NjRqG4H5p1LMONrLLvcRoK?=
 =?us-ascii?Q?quiMOfWKcfToTx2WUgTWRniJyQp3+sz5PlQXhJIrFw9x9fCkzelxweHND/tR?=
 =?us-ascii?Q?X21eUSRJg0zSmoqhC44Pul8CnV9V9gHlfMAY0PPNWFqUXgXqaZALVHYYTAHc?=
 =?us-ascii?Q?lmPdbVgMURIo77EsT1jy1ftghsDwPr/RPoFiXEQzy7RK5ohYg1BefdyB6fdF?=
 =?us-ascii?Q?6acVI7TL+Fw6zWr7Se4QpBM1MOi2Jwwl6A4Zk5zGDzAnFs8jLmofORfi5xCK?=
 =?us-ascii?Q?LTt5vOOHGmJXWNJbg6iz0R21ls0bk3RA8R75W47RykcrSgl77CkGGzhbZqIr?=
 =?us-ascii?Q?PU1qz+o0clRLWXyg5yWB3ezEU4c0KhGiIuH3sGjrCaygYpwSkSkHOfiV44Js?=
 =?us-ascii?Q?VZNl92mw+qbK2Hzl5vTtBSlfOTsibKpg25G3tfCZ0R9bkioQMhANdhGS88Yt?=
 =?us-ascii?Q?3DPtHbTUxpE9xhcaiQ/Dkaur7pRaUkVkfg26hDc96P3PweTgcPhqw1ihHKFg?=
 =?us-ascii?Q?0q3ZnBwIS31bgwWY7b0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5239.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TQU+HD+nuPn4gm7GUbhDOwPHbkHfLPn7zZS3xze4N2eMlqMViqmeMqLeDgRq?=
 =?us-ascii?Q?UPuv5rQLM/AUCdovCY2iEBxg1AqBUgHbVJ7FefAb7uH55kxHgHd9PRPVRy+D?=
 =?us-ascii?Q?hrTIYoxpPxmu/Q7SDAJBQndH9kuu07zKK6umSoNwoN2NsR8bR+6iv0PhKMiw?=
 =?us-ascii?Q?yTKnUYzUHgbtGvzBB01EDJrhuZbSw3DViU8rt4RYfypYWy36TV0cWX+EIAAk?=
 =?us-ascii?Q?vAH8BCCtp8MaC7WVjX61I/f7ePP7OqpVa1QtkYyWtmjiEG9l3XExHt85upER?=
 =?us-ascii?Q?AmyuFOu+UgjqMRtxgTBo/bm+DpwbEwo0NbB69rVz++YNc/GRzygR2TBBQxui?=
 =?us-ascii?Q?KWDPpVF622U8yX2S+0WU/FaHouJKysjb6nm5x8PpBFeAmB31mcs/H8QxLKJ2?=
 =?us-ascii?Q?FDULfTGdS2Kj2LVm8X9cdZzQOqe7lsmhh0M8f9mmvD8yoWlmmBxUdTBvBSUP?=
 =?us-ascii?Q?59KPNQAnInxg2jmd/jwoEwZYKA81YOfNSgEFzZpbgzCvAHauXildXfqihwxp?=
 =?us-ascii?Q?FhmjqCQYPBv915fGvHlObsRHFQL66/y34BXEqgrg9WY90Yyd2PbCULeAthMi?=
 =?us-ascii?Q?hc5uwInGRwm3Vwf+CmE41Mpp1RBnG8w08j0Evfk3RFO1QnF34xJEM3jFFyar?=
 =?us-ascii?Q?pkxrgvMV+2eaygp+V567ffSIdNhDIDUR2KO9xiVxuYJi4qgP924EIpk7zbWU?=
 =?us-ascii?Q?pwEBNmfK0nIVuh4re8fYA3ZBCA3ur0UxSnI4CRbOQqrXVwnrt93lVL6Bxiov?=
 =?us-ascii?Q?HbcXlVz94wMamwmdGgKwWiifZ4IG5ahBRqe26meMBQB8LcQSSyOI2HB7GoLU?=
 =?us-ascii?Q?xyJSntyx53K6/2J1ImHvG2iL5WW0Ge5j8Dt9Yu3C4HQQ3WLC7MAw6BkKSUcw?=
 =?us-ascii?Q?lFeUMPFFnq0JDAwSt8+YNLARv9jZeACnioJwC0VaRcGslyQ5VDCR3qTQEr/X?=
 =?us-ascii?Q?exxSJkqkl53EWxmZz2TZfHjE05ChH0Itww3liYpQ4NSlAQHSd3bRoXi1stDG?=
 =?us-ascii?Q?3f4sy2UNgIqqx4FrQH4NokowcmQP5JkmvbfHD48WiXLJWDS0HT2WJ2rs4lyc?=
 =?us-ascii?Q?lUb54i/qgnUzpBVsfSjBB6x0tFHsEqecYAcn9l6Mhj9vsKd5GZWo8/JcJMiZ?=
 =?us-ascii?Q?MlDwzpCqm9dmHI7HPbQSnQfV84lbqz9d4tFQJjwjRk3PAmi4NfHWHoB9Hcjc?=
 =?us-ascii?Q?m9X5XPhWQT1iN+o2hE7aJAxIM/53IbMsdlZrsC0w/BHYI8FS9csd8tvD2r1F?=
 =?us-ascii?Q?DPfdFrBsKxno6U3yrSHkQVPPWnp6kc7tdhwgBxmAMooDdm+zoY5L/p+Gbihq?=
 =?us-ascii?Q?RkiD5guzN7B1yEdICfKHex8kN37kGotPy1WYixqJzoRYQAkbF+2i0T+pRJbS?=
 =?us-ascii?Q?MmQthAoq1ZQVSspn33BNdS1u2DtlpmkJjp7r63x4n9MnH0v0GTpKCs/G2itY?=
 =?us-ascii?Q?uprCsmWtUAARCGCBe6p3ILk7IaWk6umAbAbBlAFqrmNnoDbCBbsrt51gp4JK?=
 =?us-ascii?Q?jt7UCVUFlToubhrY7t+HljpbPOvSEv6VOd5XmjTJFGudqfcadFuXC4+41/cE?=
 =?us-ascii?Q?thZwdNEIQbKprpp1Gc+l2ZrJt67qJGfPZiPLcddp/34SiHEULryfdo9/n7NA?=
 =?us-ascii?Q?u0LUTAKqb2/2VZYzbxy+/COhTlpg19UcSWRNKWdUFmKniK4uE8NgJDprxXTq?=
 =?us-ascii?Q?eKJdjZisemxjI+wGOk50sIsrVt+NHZKdDeks0Juse36Jn2qXNw+pyUG7roqw?=
 =?us-ascii?Q?r3yXRFXEK6RypChsau1e7sAkTzt5Kn4=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16d0d6b7-e68c-426c-936e-08de5d07eb61
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5239.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 18:22:52.9987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Mvd3ZGetRolFwRbcX3T1U1nEhdHoKZibWdKvhX5HQfEvL6ZvKyOjiP6xUAGTpbZYvuRJ/7gDoAP585rYBWFkJ+gZq8A1/U+ChN9IP2kr6s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR13MB3934
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[hammerspace.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,brown.name,oracle.com,gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75508-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bcodding@hammerspace.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hammerspace.com:mid,hammerspace.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9DE048C0E0
X-Rspamd-Action: no action

On 24 Jan 2026, at 14:48, Chuck Lever wrote:

> I can't recall if Wireshark is smart enough to introspect Linux NFSD
> file handles (I thought it could). It would be sensible to have some
> Wireshark update code in hand before making the final decision about
> keeping the new auth_type.

I've gone digging and wireshark has a surprising amount of filehandle
dissection code - it currently can "Decode As:"

dissect_fhandle_data_SVR4
dissect_fhandle_data_LINUX_KNFSD_LE
dissect_fhandle_data_LINUX_NFSD_LE
dissect_fhandle_data_NETAPP
dissect_fhandle_data_NETAPP_V4
dissect_fhandle_data_NETAPP_GX_v3
dissect_fhandle_data_LINUX_KNFSD_NEW
dissect_fhandle_data_GLUSTER
dissect_fhandle_data_DCACHE
dissect_fhandle_data_PRIMARY_DATA
dissect_fhandle_data_CELERRA_VNX
dissect_fhandle_data_unknown

.. almost all with finer grained filehandle components.  I certainly can add
patches to parse FH_AT_MAC for the linux(s) decoders, but I admit I don't
have any use case.

I'm completely neutral on keeping FH_AT_MAC at this point.

Ben

