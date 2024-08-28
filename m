Return-Path: <linux-fsdevel+bounces-27624-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23985962E14
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 19:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4612F1C20C9B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 17:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D241A4F26;
	Wed, 28 Aug 2024 17:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Gwfplbur";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ex81G/gh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08EC71993AF;
	Wed, 28 Aug 2024 17:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724864495; cv=fail; b=W62EYKW/8jgj0KZ4Gxoj75O1yvJ1o+EsMP/tXMwh7Xq1P6xtPtPsepFkEI0AlfcRJFOvwyC3rtTn8V4FPyrc7pLGAQh/pagayJo40h9m3zaFR194kpgoslo31c5WTxKoOFuRg0semdT/4S/s3qLXSqHn0XIwQoNe2E2X3+RNmEc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724864495; c=relaxed/simple;
	bh=WZDRnFGhv9sbf37wlfj5OPgYES0T3N4FfXH6HUVG37M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=P4zgAzAZ/kvCcYCPxs+KauN0apgIqVXY2ii+s50IkYS6VvmV9ShKUeKfuY47h1mK+T6iPKfVsUsFuViY+YBHpSEo9TMdPc/SZdsZaI2sSM5UKdVx8cJs2S1cDhDX7+3zKiEJu3dW+a+JZHZzfwW3BGnLJVDCycTgPdyUPVXEt/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Gwfplbur; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ex81G/gh; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47SGtoCX018471;
	Wed, 28 Aug 2024 17:01:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=IpCdzY1OrMmW/st
	XAV2x8AZ3LYAepV3j2Rd4Dzdb3Mc=; b=Gwfplbur8pQSJjiI8WBlkrg0XaWK6ez
	Xk4QoWictbMeLev9nXTjiXtGIAHFOFEgKkAiyNHAjyj34avVkKtkSRj+SHf4OQ3J
	mLSMz3AptiGXaUHJrV3MLxO2Y7JAPWIztft3m1+7gHPNceH1I4Q7kZO0JYdcf8at
	Qr+s02Ef3yPNRlsrXXvwLd3cdRHbIU7yBeErZLKut9rQnZKUr//H3UqfEcG8BDSo
	2lIA32V+Afh8STkdVNkhiJwvabNG4a6g8VPwoFQROVJD8OY3J79AE45TmLKrr3lI
	Ry1JBSZDAjiRsnx/o/Gq8IJbvG/djdKbrKz3wvMpnCdizpdGSWV34Gg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 419pur9u21-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Aug 2024 17:01:09 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47SGalVd020154;
	Wed, 28 Aug 2024 17:01:08 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 418j8panm0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Aug 2024 17:01:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b/kgqQNJgqflGxDEbAJ7i+lYGvdbZiIJ2x/4w95Ie6sjeyL+Q7NDSQ1SaVPh0Yv5HHUqFO0K6paYoBkTlO532tM2OXOUpbJutTmpX5k2vQHPF8bc/4EyN1RZfaSOetWjjPRWKPzrB/LHOr0fIRkiHujnAN8Zm24pfPNFf6qoQXekjkODbwKPFCB09Uvg7mIbREM2dVkubjSMdGLNPqmYR8+OnwgrHcMKw9aX5D1kikMtsBNm+akMqDnEMApqCAnjgrfPGauqwSZguAWAbhXZl2S0fQ0AMH5pjHE5c78I8TZkAcz8kfLYKr0Lr7BQYJM8yMSiL7ndqHyRbeCt88zj6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IpCdzY1OrMmW/stXAV2x8AZ3LYAepV3j2Rd4Dzdb3Mc=;
 b=TWg3PIoMVNiv33KwctD+WcvAgGg5TMEOtld7cqdlLj9VHZxuTtRqY5AyK+GeJkHH2I8Sq2eBKUTK3W4/ksMRMoC6rkLtG8xLDAWWjjCx5zNlTsMZ/Jl617c7IZ95qJNn3K9TFGH9nWOd+/Xw/zU0v76Yfo/rWoegRtqaepF0ZTn+4tHPTcofpMT/UPcNdjICxt9K6X9i2zrT4wj0TBSXTUZn03S90zH3nPrJL8/lcZiQftD+Lsc/2tpDeU4vXkYzkvghFvzYtxG8FKcnCvcGu0Gfw4FxNcHDxBEgw7wsHjL7SJ0bw5jFnvM+GtyoRCIZLShTqpCoYfsV0NCRxNX/YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IpCdzY1OrMmW/stXAV2x8AZ3LYAepV3j2Rd4Dzdb3Mc=;
 b=ex81G/ghcabYmyuHwk4rxuHBWEmlsjdJ24yqeQurq5/FRrOD1OvnZdv34hzL94LbHw43OiKbvgAVcdpT4o0Z+r/dbDC2RgexJohuHAr1Ihlw6Iid0cyDNC05b7kYx+wH74uOCPqLN0oQ8TykL7wDQtH+ju5KS7pQclYpOXdqtrM=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB5854.namprd10.prod.outlook.com (2603:10b6:510:127::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.14; Wed, 28 Aug
 2024 17:01:04 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7918.017; Wed, 28 Aug 2024
 17:01:04 +0000
Date: Wed, 28 Aug 2024 13:01:01 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: NeilBrown <neilb@suse.de>
Cc: Mike Snitzer <snitzer@kernel.org>, linux-nfs@vger.kernel.org,
        Jeff Layton <jlayton@kernel.org>, Anna Schumaker <anna@kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v13 04/19] nfsd: factor out __fh_verify to allow NULL
 rqstp to be passed
Message-ID: <Zs9XzSHGysK4eCJO@tissot.1015granger.net>
References: <>
 <ZstOonct0HiaRCBM@tissot.1015granger.net>
 <172462948890.6062.12952329291740788286@noble.neil.brown.name>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172462948890.6062.12952329291740788286@noble.neil.brown.name>
X-ClientProxiedBy: CH2PR12CA0007.namprd12.prod.outlook.com
 (2603:10b6:610:57::17) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH7PR10MB5854:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ddc0636-4eb1-4b53-cea3-08dcc78300b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YRytLUFqTHdP9L4g/WhoyFYELAEQxSdtmW7uQ0IZeUxB0ftEZoRpEdcE1wmi?=
 =?us-ascii?Q?t8BF9odDEmlowudtpd4DCcPTVL3NQzOQvPcHHOSHOU3B2p8pBLEjJX8PmfdD?=
 =?us-ascii?Q?sBsLqUPAeMRN24Suzx2QpHlMQLiET+stjklX9M4JPl5/1P5eL1hhZuSJllQK?=
 =?us-ascii?Q?Zr3enkzAjsE7Y1Q4NNepuxBZCYmPdVTZOOujsIjYJam2JfwrEcR5hIQoX15V?=
 =?us-ascii?Q?Y1j6YxQCfHMeYdEVabK8fPptlgl2vfFJJ5qheAJPLCWvwQWptBcfdTYmbGkx?=
 =?us-ascii?Q?YgfVc0tpMJ+wngKJX17EVNfZBZtjNEIG4PEmSjY5tRGF64W+jA/9gjlRrft7?=
 =?us-ascii?Q?+7sZPMkwRMzZQPNG7wEeJgrdkK98vX3liKJGEuhCszUvNHTH6n+OCGEkNNuJ?=
 =?us-ascii?Q?1OHnZA+b7lJQgo0dmaXdZl/8hL6QoK6vg/UQkuOFAhaYMSSD5K8cNF7xhNg3?=
 =?us-ascii?Q?u0sA8TvY87K67LsXho/g2r6lPTKDCvLW1PFibK7HFpEKZAJVpPrTyCDjB1pQ?=
 =?us-ascii?Q?b4pRagLQO9gTXoSgVXXkkhNPdtT7lmyIqzSS8WwFxz3lcIOFvxg6GRtSIWoZ?=
 =?us-ascii?Q?5x1gFjM3CIQzBkySqq+NjCOUvytxVWcMtVhAkH0QbNF1ae2wOrtWTZAZ5o9g?=
 =?us-ascii?Q?y/imq9r+MKi62QoYijfUE7T1umD0UHwuiI/gbZZ7RoWgwkJJwMozovSTyzZT?=
 =?us-ascii?Q?yAuAgf4NSzJxyEvkBxHINVHyIfcT8LeGTtaSBljWyuuXDXxvDfLC/BIP4puP?=
 =?us-ascii?Q?M74uXh01ayEZKMs5SeaZRPulul/3FJ0z7CzUx23ug3VUaRoMxsgu1L7bsSIM?=
 =?us-ascii?Q?5lZrqcWLrtcuqSNsYgAZv8rtIHXKp9VJThWedcJ/YWsC6TJu8Mc7LunkW8yG?=
 =?us-ascii?Q?FOC7r8OqChqK3+ML1gireNljqo7KdmeqaPGXjZO7ojzBMUIzCoXNyLIFWwp5?=
 =?us-ascii?Q?tmrFt2cPFernTRPAt+s35t6likdL+3aBlz8GxsMUA94BsPhjHNswRTm78Ir6?=
 =?us-ascii?Q?bvklu8qL5rOMeA8v08XZdnz74Lt6UpXH7RQ7jFIXg/a8PSLWctyky32ysIuT?=
 =?us-ascii?Q?f0jvTOGFU6qbCZ6eRAO3RyEqoIumz4jycASbggCi9c6L2jJ6v2q9FmwFer+j?=
 =?us-ascii?Q?oTSYqBFOKgYwswZ8W92DKhCmKcVKtDFtIDwj4lUdeKEEeTG8TnY1/DQY9pxW?=
 =?us-ascii?Q?DZ5GnQW90k24v1XTvakuUX69K+zr6o10WpEs5rIKCdj1hDrL1xjmpL8bb2e3?=
 =?us-ascii?Q?4lttHdojwwKFsA2y0TSLz3vnodWty2bHJHxd1dVBrpIvkFJfdvb8gIHo6hPl?=
 =?us-ascii?Q?ih+RJx+4LQ7d+ynd8ZUAWvmuaICdFcfw7sp3e5QFXs5qkw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+L8pOeAXNfN5NLZWpuRZiRenEg0zbogGS1uVKa16gA0l8XPRE5r/kkuNlvGq?=
 =?us-ascii?Q?mjKWC0aCaPFek+ssC5DH/Hb+fXJsp5rEcZW7QzOyzaXF5JewdiBf3i21xTYk?=
 =?us-ascii?Q?l2YIyp7PKwv2UAUaFNbPAXYdT4vXWjq3nTYtMeoc+UlILCQ08if9iA/p8zCf?=
 =?us-ascii?Q?dPR81lFjYALrn5g3cobW7DjnQwcRFzKj8qL/ahKvbL9wnxw6kyBacyv5x3VC?=
 =?us-ascii?Q?Bcn+6TK8oSLA7U95elFt+tjD4Dj8S1XIooI2Xy1obtO/ybssOssuGPx744/s?=
 =?us-ascii?Q?sO+kakyoHZTlOVEecxtLwgTbo2fPdQfqUaeXAkr81UPL6P2SlYH8a2dvIrVi?=
 =?us-ascii?Q?yEeNIg9bYYQfKMEPsQak0EaiCyKBJFbfdlfjiPX/1FMM+k9ue+kYrrmy9r/D?=
 =?us-ascii?Q?xnrtOaNr5GNzetNoG2VNnEBBtSlxD1GO+IM1dGLrBaT/DouyIOdE7mCiqiTt?=
 =?us-ascii?Q?BxfX6gwrRUTzJPxBL8HFC9rHltLwbs3YOfzrTZoPGyE3rOyX08E2yGyoR2qZ?=
 =?us-ascii?Q?kvA1tzRh9QY+gePfXXUBN0u6Boyx5bp4CzefPIt5Hnz+XKbQyHO+IEowx9vW?=
 =?us-ascii?Q?XLJBbikWpvfkNjFeklnRbwnq3dVGKmNT/dcqyZ7fv3KQZEjtIheQUZCv/VWa?=
 =?us-ascii?Q?Y8XpaeTSojkB9YNHe3F0FhIVhNB4RP92nHUmt4xKm19MZMggzEvr9xj3Lr74?=
 =?us-ascii?Q?fEBplzoPSmDMuAomSe3InXqSFy0CW/zrFbx2dSYE7N7634ojbIMbr+FIjFg+?=
 =?us-ascii?Q?8YHuKdN9QNWziN57xj1lO6Ie9beDuln0Bvtx0jUOI0cVi6YqOFmDSFhnu/41?=
 =?us-ascii?Q?uLLzAtgOcuZvm6B8i7ZwyiFFgG1/mbJeKATsqCFBeVU3qEHKPjuMJQyqB6P3?=
 =?us-ascii?Q?HTBZ1f0X2mAmsCKTN3vC1/qJ/GKeqdgGP3ZXWWsJS0WthAIhC/6/8OEVBcka?=
 =?us-ascii?Q?lRsGlTcjxujjVOrpgnlJBpLx3uB2LGDRChpsxX6MAogIVyRxLKKTOdH74gUz?=
 =?us-ascii?Q?LnmnCJOxqd3SLFXUPddw+7kDa5oGZ+Y6CAazgiLCqOqZy7MilJUHIf5z3vwP?=
 =?us-ascii?Q?uaOIRYMNgGhdZ61ph4TwyeyJzpFi6qLkW//1z8nGR5qNJYAtC8pfxA3TX4lK?=
 =?us-ascii?Q?0NChmYQa+nbi+GKmrrFfsRHhMz8ZCNx+QvA8yV/+qHB0rsHOG4h26U3TV7Rp?=
 =?us-ascii?Q?s2Nsvsc6K3MMefmZf9vOfkquCBs1mNMv0qNnB2k8zSkPHuUL1z4ZQbi/rZv8?=
 =?us-ascii?Q?qWna57mfAW6LXM2p/SvskFfcrq47r+ElWFWVm99Pczd+wzjNS0700d8RqRAZ?=
 =?us-ascii?Q?liBZqu7iT+qo5H+5Jre/0Sj/r718v8eboUay5lMJ7oKq1q/L3zWesy+1MoV6?=
 =?us-ascii?Q?Objwjpx3SEvTI80YqxMfrEHKnOSf2ogq3HNB8Yei5PjiDer6ZNhs0EvX5s+d?=
 =?us-ascii?Q?CrbbYQ9iNK0dzQ4KcpKzwaEF4wukMC1EKEsSP+76iwfILvCK6LJ+8YkgKJt4?=
 =?us-ascii?Q?QbhvneCX54VqnkVGWjQRYgIdVc2ibvm9puGhHznFlnKNtN+9KmxrUOC+Erfj?=
 =?us-ascii?Q?uk3br4A32FBUohFkwSw4PLHNHGXMhjHsKX6V06Lj?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	GHaZSndV08OmFMZA8r3xg7DU0Y9caoqAWm2a8kOgzShR/vYGVBtrLJhJ9st/zQEHbFsxb/tAANwGMiples+2vQKmutEkeS8wF36YFyiG3PWNvPHOfg/xmZ4cA+ZxJ5z80zrsa0jTMsxlSoDEPMCg8OrNjYDS0/Fx99j7I9pcWJ2XRugCyfSyI4rLGDqeqIY9c0pOMB12vlZY13Rp0lkqcBpoUXyzWwCPpItrrc34/o6cUNpUtiHR0n3yaxy0GH1U/T3tsPY4j87uD8S2q7FLOY1Dj5irQTdbtx/87AD4sDUR+Iarr7JwxPq9Imc25lpA+C15SJLcyEYK3t1cuJYIDU2NlKOAYP39sPCy/zdoMOhtQf/e6tswPvZDYFRQYfzaOJfSMPl2au3shMiEfH6+H6d2+XL8CNYfmoiTHJSs7jcKznp7ZrR4cn3XQM/gIS15J4Cxbr/dCd1qSVPu9+2ZK1DEo/o5CX5n6AuDvi9MTFjsAJkRdspUWYDCfysmzFRpUXb4nIGWRJAWd3zfAD1SgtF8SzWtykussw1R8tWeXJGqajX0RQqsSwYc9zPjgrW9SArmSHDavgi2WNGGFg7MmFToGTvtw3lsyHHv/ztDW24=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ddc0636-4eb1-4b53-cea3-08dcc78300b6
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 17:01:04.8358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bz7B1j+bWsbiL6ibZoLP48/lqHDMeTpD/st1vMeNPz+f53CPTdaPPpCa6X3nOR2YFAicsWqXlLKBpW59vW6bLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5854
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-28_07,2024-08-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=612
 adultscore=0 mlxscore=0 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408280122
X-Proofpoint-ORIG-GUID: NuU5jVq5QbLrFK_0kqHBiOC-DtLcl1bi
X-Proofpoint-GUID: NuU5jVq5QbLrFK_0kqHBiOC-DtLcl1bi

On Mon, Aug 26, 2024 at 09:44:48AM +1000, NeilBrown wrote:
> On Mon, 26 Aug 2024, Chuck Lever wrote:
> > See comment on 5/N: since that patch makes this a public API again,
> > consider not removing this kdoc comment but rather updating it.
> 
> What exactly do you consider to be a "public API"??  Anything without
> "static"?  That seems somewhat arbitrary.
> 
> I think of __fh_verify() as a private API used by fh_verify() and
> nfsd_file_acquire_local() and nothing else.
> 
> It seems pointless duplication the documentation for __fh_verify() and
> fh_verify().  Maybe one could refer to the other "fh_verify is like
> fh_verify except ....."
> 
> ??
> 
> > 
> > 
> > > -__be32
> > > -fh_verify(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type, int access)
> > > +static __be32
> > > +__fh_verify(struct svc_rqst *rqstp,

An alternative would be to leave __fh_verify() as a static, and then
add an fh_verify_local() API, echoing nfsd_file_acquire_local(), and
then give that API a kdoc comment.

That would make it clear who the intended consumer is.

-- 
Chuck Lever

