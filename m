Return-Path: <linux-fsdevel+bounces-78636-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0ADYM9KxoGnUlgQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78636-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 21:49:22 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7FA1AF4BD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 21:49:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 80A283044153
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 20:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A449A283FCF;
	Thu, 26 Feb 2026 20:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="I6YG+Bh6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012015.outbound.protection.outlook.com [40.93.195.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0383327B327
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Feb 2026 20:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772138957; cv=fail; b=fwMUtnp4LWIpaAco3MX8LCfTUwauGlVVXLHEKExAFMNPVXQ8i89uSrsXalKGCPN0Quk8wPNogzv/yD3jGlUKdJGx25CR9y4wtq66rHDOSXDRo8D47WD4F4fZL7j6cJK2MfmwlUcPS/R4heGX6wj46Ej4/EtdFMIW9B/k7o9GkOg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772138957; c=relaxed/simple;
	bh=YnGLhm9ZEtahFAjyQNL1OMicVSt/RhyK0P8gnTVLiUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uPPJsyP815uW3yxFMHooxgGwcRsfUqp7FePRd2K65zL4ZOZoHqthxvactCixvQJoMhQ4V6MbVCzbMFRcme7IvGeySm+xuZWNxx8lw1sy/jRBwA7yiKV5cSJqaZOC5oFXdr9UbPj8Dx16McFdwBx0XcaSVXFZIXKywq3CzLNSo1w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=I6YG+Bh6; arc=fail smtp.client-ip=40.93.195.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XUREu/GJWw2QmS8qIFqkzG6rCsPi+/Z2I095Zcx2lmYSwYJdsm7bnVOGC6ZAveHBIrUWckFZIKe0s0BMCt0SdYr4eR5nt+yzN82LF9Knb5yKMDloP8C99S9af1cKIbDe6IIZC5zvHuBPClRJt8SgCNNfj+mIXZbup4wu4hsxVWB2fTeTlgxJjlQBt9KCB3YHXXcCCrF6g2CqKsGZjVDQ60RSWanYsrY+r6m78dxgaphFBNdyD3UBcSqJyEfGG0neZKvCQrPeVAjCErIBGanKeMOboZF4cCYoKnD4m2/i4BJJCw7J/RZnusSHwoCEKktf+sosfPnNhe/BPZjvt3ZS+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8zma5mBBrWc/5mba9cBE0XFLOY+IQdJfbuXFBGzi6Mc=;
 b=li9EgUWcCvvRwIKiWjI6tcORXfuA8uaZr1GdYrsYzr+DBjho72U/DCvfLjkfvshfkUscmjMP1W1vZZIhIIdBkKma9AplnyqtuARWKCf3SWSfOb7o6Cm9kpEFKotUdEyEwJ63WZnwI9Fal5l6GtfzEEI347Y7e2dSRAKmdUiEZ/H13R2cwq/c1N/QcBmS2FAQ8TkU/xeGtek4GjSYe9F5A7K/EtTe6Q0cdVdWIhr5DaPoHQ9YZivNENWyPhz+0jTHA7/8MqlymcZvM5FeA0AW0FNPyKQFT7Bjbbc6DSIllaK7/xpYYqvK7OS1qcAfZ3036ZBaH78lvqZHLb1+AIVhPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8zma5mBBrWc/5mba9cBE0XFLOY+IQdJfbuXFBGzi6Mc=;
 b=I6YG+Bh6f5HYv+KrMBynlnux2DdiPflKnJrhj3UMnSssbmZl1Z8USTAqFZnBX8B05n6fM7U1ms98xKJGUx1Nsv/9ynErTYXO4IYUHEWqdz5hO2bpJb2eVSoQA9HFE488Ud/cmYG2gqKVCEX4+ThaCHxxhA6xesb+9D/p1PXnPGOG9/xaHfun/NeQzFSp7OqCANdUQNvc0XvEYFJ51AdZnO46U9pH5R1w+F332ovHi70h7dN+0BYoaDGmV+En3xfKUNaMuKir5C7TXxhhGYVsrGv4joVbbPz+FnJECSGSUb8BcUFcwYXsGPfOn7AvDMx06iRBENhS8zQqNlk68fsyDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 DS7PR12MB8370.namprd12.prod.outlook.com (2603:10b6:8:eb::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.14; Thu, 26 Feb 2026 20:49:10 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2%4]) with mapi id 15.20.9654.014; Thu, 26 Feb 2026
 20:49:10 +0000
From: Zi Yan <ziy@nvidia.com>
To: Bas van Dijk <bas@dfinity.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, regressions@lists.linux.dev,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 Eero Kelly <eero.kelly@dfinity.org>,
 Andrew Battat <andrew.battat@dfinity.org>,
 Adam Bratschi-Kaye <adam.bratschikaye@dfinity.org>
Subject: Re: [REGRESSION] madvise(MADV_REMOVE) corrupts pages in THP-backed
 MAP_SHARED memfd (bisected to 7460b470a131)
Date: Thu, 26 Feb 2026 15:49:05 -0500
X-Mailer: MailMate (2.0r6290)
Message-ID: <CB5EF1C4-6285-4EEC-ABD0-A8870E7241E8@nvidia.com>
In-Reply-To: <CAKNNEtw5_kZomhkugedKMPOG-sxs5Q5OLumWJdiWXv+C9Yct0w@mail.gmail.com>
References: <CAKNNEtw5_kZomhkugedKMPOG-sxs5Q5OLumWJdiWXv+C9Yct0w@mail.gmail.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0112.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::27) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|DS7PR12MB8370:EE_
X-MS-Office365-Filtering-Correlation-Id: af17ae90-10d2-46fa-199b-08de75787dce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	yTbHNpgBivIs9gpPBaVwbH+D5Nbg7/N9ONYtXfmgV6Cm8V4dwDxMIWz3936sZa8CQlQjEeWOYNXy++kh5zIHvuIRxzaX3cPfGoFJWKNk30zLR24hxMFJtmotaSh2vPU5ug3ulrJiEUSIco6G0ca4ydarD7L6Bdn5A8fj1Eyafhgapnqqe4o5c+HXZwYQwGvXbooMMc6DHKLKTFRVb2nIE6y/i0R6P2tBK8BgHud7U0PqPmrQwzZpRx5jpi+bg6D5dkDXBjaULhtE3lHWqXH/xBe5sCPvjsJW8Kr9jrSvc+ckXgyBNyiPGbwqEoniDPNHBRZSlYUl5J/EaoZcsK116p/AhkkFbrqkArdoLq56IkDhPPtuMVqMHmiuZ+4+cZtzI/0xhXKHGaqa4WMSnjE76qr9pFUnWblB8W3Qn4lO5Ua9BKdQbezMDQnNpFy9Rdlz5EBon1SyBPJHIsd7fQ2WkTxBbcnVChn+6/AiTpyC2KihFA0tCGvXcKEJjYp3fLzYx7PaeKRJs9barigH8BjXajB2W4bQ3k+zyq5bLpOi0/PwUskg5ZL/mdYgdBWaAG2cS4EbuzdGSEJ29xUwEI+ZOKlY++o5QOIglaOKHoIgKnU5uYDZjHRHxEJ97BJsnAl4nv4NGWmR30AawSySwyw9uP3wPiSmnQqMSwmzrVD28Nfkdjf/FZwLG8FJDfmj5re7IoZozIL2afL5641DDg+tD8CrklgadfCvzpfO+UzH3no=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?G28TCbOu7oBHa1Q94kqlZcTuCMbWjYaoXRh4I88MhsHRVQoZ7RlHF2fDvYiO?=
 =?us-ascii?Q?9qNEdc9WeoW1ePAJM/OCkEAYkKT5C5PneL0Dbq26f8h0Cps3+Tt3c2CQmVhw?=
 =?us-ascii?Q?hBfZ3rxpWn7wrIrq7ffHAhHgZng4XMfpyE/Jbmzl0zXBOwI/HmMFaZkzsoe2?=
 =?us-ascii?Q?+0QNpouYHHsuSf5DyCQmcceHP4ARQpd1KtLb/0JaRkkOw8xGQF9FpRQy7ARx?=
 =?us-ascii?Q?/u/xbGogg9qwVzZSmINrcnd4tUhzUptK1cn3CBkVRtGg/S7v3O+dwXhoLcGY?=
 =?us-ascii?Q?U2n3WanBeD1VLh7aajw073gbeXPSzBa6gfKkBXmmHNwoTSu/hszkCanSVsvC?=
 =?us-ascii?Q?zdDfaIVSdd7iYmGk1tgONzF6Cf8u57HK0qIZrzAxnbShCEvZAECSoxd7g6/g?=
 =?us-ascii?Q?MiM3T1XooEvgoQjZ3piCrNE2FLIDCE0bX/T/XCikF21yNYLxrIuGXEcYwOxt?=
 =?us-ascii?Q?yj2e/eu1abirDsKUv8gHAShqfl0lO45MVmQ08AaNhC6VA/B0oxN2aZxkC+Yh?=
 =?us-ascii?Q?n0K74VsZf/rg2aE8p2r1jgr7onGFUB8vxkRPsLDFy0Ri+fWQuRsJRaVDT5Ka?=
 =?us-ascii?Q?nJfEY1N6jIUsn6TDFTJSo+d/8y4VkTEEv+QFxBc1FlCDXsXsNARAKCmk+Tin?=
 =?us-ascii?Q?e+O8CFQi/An28nqW5CXPIuipAz7XzCjLxE8OmhlrAgTXG6K7+/pBFr4PXzcN?=
 =?us-ascii?Q?0DGSwjcG68sN1beT5+KKYsauSV+W4UhArNm3cPxeJNYGolxlhotk3ZqAmsem?=
 =?us-ascii?Q?d3NdH+dElrt9POibU0VLCF5PSOn2HV3xk3e6Dq3DxB1iAns+1y8fvAgWEU6u?=
 =?us-ascii?Q?lRSNlxbMTO3l1opV9lGf/swOEm+Np0uhjVe+zoIEqYYorBFYpbGhhDmBDaWp?=
 =?us-ascii?Q?EiisKpJrp0gAdNY7ctIngpZ10Inqzvo1OKduyn+XcwnCtuaGy7bhqAHH7rZg?=
 =?us-ascii?Q?erRFpqPX9YJVmkKJdRUnHhqUsCaNC/cwrU2ApGk/D1JZ6p8PjuaO+m6hqzOo?=
 =?us-ascii?Q?RBsnbRRVfpyVB6bBxSSfeDGAXBXQMNvlPx4v7FBzai10f8weWzX6RV/MVPFy?=
 =?us-ascii?Q?731Gl+6PxYgK74+Ck8HqMdvxkq8u+t2jG/1MurCD9QLYilngVHpCFJ2NyYx4?=
 =?us-ascii?Q?T72J1hoMapI3f9BBEnp6Jo5BhmI7oAlcsoMUbDGF66UsoT8mhi1LJUfRLVbf?=
 =?us-ascii?Q?zR5xzTkRCMT/TMu9pHAjZo4YxuMADzgpsRiBcmBL5LPkFaXNr927FZ1MBwLY?=
 =?us-ascii?Q?MLa2I7KyaeTRTXxXfJVPwrjGxFXS6xZIMKF01iAr0Vv7EJ+U8gcjVNoJpsCT?=
 =?us-ascii?Q?d0cT3gyhj2oNwoBE6W/NHPJIprWPuyRY2aHRLqMSHS3I2vjrXu1VtpzBJNFk?=
 =?us-ascii?Q?qzG4eZPRuhYKhjq0cLpyWoj3N4fybm2GbHnBEz81eZCc5CRU3c4hw+lFKFzr?=
 =?us-ascii?Q?M58K89mox/YOcuCS1TpCv/QF/X0u9nPqU/ZT3Pe68MMMyxhxPGkDMODGn7AS?=
 =?us-ascii?Q?ICJroD2X/vA0GD9nWMUQ4/jvmrvcqKvOoLZ2xI5rGrir12yffeumhw8D96pn?=
 =?us-ascii?Q?3ombnLAnJQ47ZxNfexJZJd8j4k66yHOJqlkkBN59zXwIv+sX/2Z+mwHig/4V?=
 =?us-ascii?Q?ho1JvkAy5GOi+ITwW1JDDORvX/YePQqIlQV6DkhkWoiO6g4Xsi18Bx0JKLOt?=
 =?us-ascii?Q?ac9aDvHwn5qkTvCCpC0PaiHSm6yK6oOGoZali+crdCw6E8BH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af17ae90-10d2-46fa-199b-08de75787dce
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 20:49:10.2243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9t7zI+e8zVEvYlnBEeXhIG5N1AGGeQQshquUNorXrotyBZZOhQMYqgoIZgGvG2sK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8370
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[ziy@nvidia.com,linux-fsdevel@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-78636-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email]
X-Rspamd-Queue-Id: 2D7FA1AF4BD
X-Rspamd-Action: no action

On 26 Feb 2026, at 15:34, Bas van Dijk wrote:

> #regzbot introduced: 7460b470a131f985a70302a322617121efdd7caa
>
> Hey folks,
>
> We discovered madvise(MADV_REMOVE) on a 4KiB range within a
> huge-page-backed MAP_SHARED memfd region corrupts nearby pages.
>
> Using the reproducible test in
> https://github.com/dfinity/thp-madv-remove-test this was bisected to the
> first bad commit:
>
> commit 7460b470a131f985a70302a322617121efdd7caa
> Author: Zi Yan <ziy@nvidia.com>
> Date:   Fri Mar 7 12:40:00 2025 -0500
>
>     mm/truncate: use folio_split() in truncate operation
>
> v7.0-rc1 still has the regression.
>
> The repo mentioned above explains how to reproduce the regression and
> contains the necessary logs of failed runs on 7460b470a131 and v7.0-rc1, as
> well as a successful run on its parent 4b94c18d1519.

Thanks for the report. I will look into it.

Best Regards,
Yan, Zi

