Return-Path: <linux-fsdevel+bounces-57910-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7B0B26A86
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 17:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 704183A9536
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 15:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBFBF210F65;
	Thu, 14 Aug 2025 15:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="S+orSTWs";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Ku7FswKT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2F41F473A;
	Thu, 14 Aug 2025 15:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755183821; cv=fail; b=H7cww1gcVciyfAG2TbEy6YFnI4Dr5UuakhIlIWo1Vy3cydBq1zREnJDtow0226DC4ZUwy7kLZZveCJIdOIClDEShvgTW4XvZvVHnYSrsVBPqzU1u7FdxyOmkbDAR10Ia8cHgwu2tDVkrA684C/fqCXWbjiwN8HiHP8CJcIX8lWA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755183821; c=relaxed/simple;
	bh=KztpK0hlZoASjNawfJwwnHSgRGK8upGyqJKky8Rt7dY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oJdMzVGT+buLTMdUyF7fPj0GszPhvYHMwO9JqQ1FdliwTUiE4YSme12GNE2UZdr9TzL7bwsW3GUA+eyaFIp+rYDeOoGa+VLNNWodiFl+Pi2fiJYQzriaizgK3lxdVvqaGRM+qwKl0pMiPpwPSjtZ9ovxMIggcCrDJIxOWbnZwVE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=S+orSTWs; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Ku7FswKT; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57ECg2bK020123;
	Thu, 14 Aug 2025 15:02:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=ruVo4bE9HMjDGZ50Zv
	tt5A4/2reL2eAIhhXpl7m1MgI=; b=S+orSTWsQ81PvQGmFtX3bKkrw3e7YVQGhK
	kcFvODpR3V4uawnrH+MHD82oL/WV9JHRji1zwzX8KOjVa1xxPN6JnTLcsWTsChuo
	4vATa+YAcUpzOC+nJigxfpeLYIN0ziNkXJgS3EWxtZj9oLhq1bW8VT8ihq3Ff/Qr
	HWxtgF0nAFPQLXFGBD3yIONsRQlF0eaREEtJn2wmMKgd0NduWwgaUwwuZDx/lXP7
	zqY3wP8kWZh+BLXb87cYb6+dlj91xAcl87T5xvSAvX0FX9bGUv5q62zPYmrbBkk/
	Furcb3Y+H4Z7IG6LGHv0yYrqtXabE3/7qOPWu3GX73eYq4oLx4Aw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dvx4j75r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Aug 2025 15:02:23 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57EDcXSg017415;
	Thu, 14 Aug 2025 15:02:21 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48dvscvey3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Aug 2025 15:02:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GYa9wvKkJ9EcslbMLy1MpwRDegJalnQmCkfHWTTuHL7OozjRfmmaaQDHScq/nOVCuB51yl2qY5mNBHb0/l1komVKbTsVzQaV8Uxk/2utuTGod5MUnm2IlpxYJq+CW9AXbOloeqPFG32syhjqa9xbIJnV9C1UYMSCpQyntn6Ep43DXu58RGm2DBxIa1OIPO0dImrdVyEqS+4QzvYj4Exz0JHUTKmAnjhbzoNEaZIBxwoamk5P5R6VJm7Fz+LbSv2O4rMgVtOGFd8/M6u28HS1GGKygkAS2wVlbs7shgtXuYG9kbAQluP2UQriA2DEPy9wyjNOIUrg1CCWsJaRBltp1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ruVo4bE9HMjDGZ50Zvtt5A4/2reL2eAIhhXpl7m1MgI=;
 b=k8h0kbiu+0HiO50FUr85IszSKq7DYWVSa7MIF9Jse26p0d7EMl8lontRGG5WoPMEj08er/HPiWJTD2v5cG4UQ5mwXeduFtqjnDL+rJJ0ZbR14HOUmcvQFZUL6F9vf6itNefIbF3VcW1yWHwAulI7I2KBeJxOmxKyjt2DQi+pyyutH/BGrK1kYw/+A9r0cZyHDZDCuTg9UbBl0TkuvVG677XHevcvpHq+Ai/Q9MgqRuXFziJb4kYciY+68G49aVRrQDGPnKRAomknIhLRrCDfnL2wR5LnjGaESk031Uj6UgNt6ceRH/x9V/ciuRoxRX2IFTv6HYlDQ33e56xzc0en0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ruVo4bE9HMjDGZ50Zvtt5A4/2reL2eAIhhXpl7m1MgI=;
 b=Ku7FswKTPNK/Lw5LsFm9Sx1Jt9Mrcbz9oqAsCWZVP9fCjOb9/ZqRHjz97jTBIwksQG0VFL9WMfnDQaTltUoTzr3vrlRfBz+oRWp7xbbamC9XWuBsFU6JcxYv6AxvNrI9OXw/+9LaC62cDZFluTVLBKXbPQL5vam4uTmIaTEsehY=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ5PPF912A858AF.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::7b9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.14; Thu, 14 Aug
 2025 15:02:13 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9031.014; Thu, 14 Aug 2025
 15:02:13 +0000
Date: Thu, 14 Aug 2025 16:02:10 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Mark Brown <broonie@kernel.org>
Cc: David Hildenbrand <david@redhat.com>, Usama Arif <usamaarif642@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, corbet@lwn.net, rppt@kernel.org,
        surenb@google.com, mhocko@suse.com, hannes@cmpxchg.org,
        baohua@kernel.org, shakeel.butt@linux.dev, riel@surriel.com,
        ziy@nvidia.com, laoar.shao@gmail.com, dev.jain@arm.com,
        baolin.wang@linux.alibaba.com, npache@redhat.com,
        Liam.Howlett@oracle.com, ryan.roberts@arm.com, vbabka@suse.cz,
        jannh@google.com, Arnd Bergmann <arnd@arndb.de>, sj@kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        kernel-team@meta.com
Subject: Re: [PATCH v4 7/7] selftests: prctl: introduce tests for disabling
 THPs except for madvise
Message-ID: <de8da320-3286-4639-8f61-b99d1186ca41@lucifer.local>
References: <13220ee2-d767-4133-9ef8-780fa165bbeb@lucifer.local>
 <bac33bcc-8a01-445d-bc42-29dabbdd1d3f@redhat.com>
 <5b341172-5082-4df4-8264-e38a01f7c7d7@lucifer.local>
 <0b7543dd-4621-432c-9185-874963e8a6af@redhat.com>
 <5dce29cc-3fad-416f-844d-d40c9a089a5f@lucifer.local>
 <b433c998-0f7b-4ca4-a867-5d1235149843@sirena.org.uk>
 <eb90eff6-ded8-40a3-818f-fce3331df464@redhat.com>
 <47e98636-aace-4a42-b6a4-3c63880f394b@sirena.org.uk>
 <1387eeb8-fc61-4894-b12f-6cae3ad920bd@redhat.com>
 <620a586e-54a2-4ce0-9cf7-2ddf4b6ef59d@sirena.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <620a586e-54a2-4ce0-9cf7-2ddf4b6ef59d@sirena.org.uk>
X-ClientProxiedBy: LO4P265CA0033.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ae::6) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ5PPF912A858AF:EE_
X-MS-Office365-Filtering-Correlation-Id: 47697ff3-3920-41e0-fc24-08dddb438cdf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?X/EBtLzqqP9Q8jLt/nS8KNb+hKIzUJYsOJgMKM1SrWFGxOpWWJ/MA6IYDqUg?=
 =?us-ascii?Q?wpEG9w4z5pY9KyqeCNYy2ZG+wDoJdNrtrWeEMQDtettcNajRgNxbBSd3gR/o?=
 =?us-ascii?Q?Vg5ssnoEIOIVB1zreZx2UbeuZmlIuUiFMcMU1Hxd6F3eJqF/58dOE2X+s/Xb?=
 =?us-ascii?Q?/Qp4huPsoch4v7U5VdaLhTUUTlzFBmmRR+6Bydz5/uchmqtSPTNhF0LSeoDe?=
 =?us-ascii?Q?7Mv34kE1Cqd5EV0BgTiy4cLmCkmJbuGIU1ZLmOsBWFJE9hQ6Vx2Dfk1gd1wQ?=
 =?us-ascii?Q?fwxzUu1rHL8h5NrNSjyOoY315VGTVLOQ88QEn2fFFBXdLMVGr50/DOT/UxiR?=
 =?us-ascii?Q?gHnErevuvE0INU0rweiFVGawxJrr/cSPnxDOerz0A2wjNJyKU2hTAxTUTjxa?=
 =?us-ascii?Q?DppvRZs+qXicdLkJnnnbdf9vz3pU7chqc9rsl53qr56bIJC/al1DuuJMC6/X?=
 =?us-ascii?Q?zZe4QXGaO0dmskzh9EwbljZ8SeUFvNHndKvtw61dWbnPx3Zi89K4FXeHtOjP?=
 =?us-ascii?Q?tI+lZN/kXV9BVS7Qrbd7YILIDlQ23aWiKn89a6q71BP6mAF8N6inscdHQS4h?=
 =?us-ascii?Q?UxV1PK6p9CIkHHyb87hA6an1bghi15kHHTe9eo2SCVfOfnYJ0nzdC3fuyXNg?=
 =?us-ascii?Q?oSarOiPG9eaShXmbqHuBheHzDU8Ehk3u2mM3k32YYYzoZItqZF6BIH8W2NKc?=
 =?us-ascii?Q?8elVNDmgas4Y3gkM2sO9o3NRcr0n7p+q9tmIsap25I1ACoKgkdJSZ7Dnwf+v?=
 =?us-ascii?Q?eUZWgquX3+3JikGK53igQtiuX6TA/A6F6WmY+8JqR0eqWV8gC3GhR501xWYR?=
 =?us-ascii?Q?PzHr5DLAraCGIG5hVk8w6Le713dAM9ijw2e0nZR2UPQboNz1bQxuUcHET3U9?=
 =?us-ascii?Q?z2pSFBrCLmQHlWoebR2b3aUgzYfM6CyVtkSCLHy9Lj+4yzE9pP8EgEsq8lxA?=
 =?us-ascii?Q?F0SDR6nK2vLf9JuAq8UfTV1qgFWikvn5M7XXy2JJQpmwsa0qdznYBAV4o2yE?=
 =?us-ascii?Q?XY/3io/AiczddxChyixgAWMIBtDo4kuExET0L/rvojt8ugHK9KTP8cMjS7EP?=
 =?us-ascii?Q?29i5kYVExIjWb3XWPvM2coJLzell9K5kOEDucBeEc9dsFEih+QfyQRoiJCO9?=
 =?us-ascii?Q?LGP5N3fc0+dxAFrhSsy9tqX3Gg+5dli6byIPib9+eD1HKBawMl/HdJakT/QY?=
 =?us-ascii?Q?YIxhnLkvl3G8aGBkGDvArHzbG+z2edI3AICo90kF7n44/YAJfLZ2Qm9ClnaM?=
 =?us-ascii?Q?NZjto7YoAhAxpTdnrsoVPYxnnt54ZmqnemnbhqChMZlSj/3c6qT/O8y6uE0G?=
 =?us-ascii?Q?Q5EEO6PLxGZYp24HEUQ6UN8f9sA7y4m/ksKCMte3NTLdG2WP3vFLQ+Fx0MTP?=
 =?us-ascii?Q?uRvxhghky0CXJz19Ae4BxVXFgdLQ1rzUPp5PcpA9iCp+wCeyxw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VyMAPZMbe7wGAoK+XF+M0jJg51J2XANh3ad3Tq3BDerJohpEb+c3FMRKA64C?=
 =?us-ascii?Q?y5TgEQsFptFPr+3vw2VVKSTg1RJecM6a952fAenisTYH10fhLPbMp7li/w80?=
 =?us-ascii?Q?PONElPUfcG2J1A1w2BKVbeGyWZrndx+FjRAeUN2v6kzOHu2cgGbsxqhy/mmE?=
 =?us-ascii?Q?FTzn1nuONVZNaNTxQ7bD+zzMeg936IDjlaU7zGk20EzoL3BLqzhAE077x913?=
 =?us-ascii?Q?scftn5mXQTwBTEh36p28KBqdv/ev7zvsjl9hvCIXjMOuJrmECGdkxFybi2AA?=
 =?us-ascii?Q?vS3/Dym+xq9CV1UU4RgANN3XaaN7dwukwWCOIAqh0H4yYaG6ppfeSOTHjs6L?=
 =?us-ascii?Q?naMASwGMb+K1TtwTJ9WYVdde3AKB/0crnvqkYxksjNStiywSChU9fUK10pvZ?=
 =?us-ascii?Q?iUdiY8KgNz0SPsXheM0DNMbcHvRoXBue98T0vJGa8Bx0TiEUMP4nTG6Wvc1b?=
 =?us-ascii?Q?Wl51YUVe0X48/VEq5IYXHYhb1ILm8busLAciGgZ9WmnjEylxUqWRWUe2cS1O?=
 =?us-ascii?Q?aX/rEYtU+oarw1TVOw8wvGki7roWieLZYWAZRHyLyb1Yl281ww5BuVd3Prpv?=
 =?us-ascii?Q?8tjbAMjX8bSRQmSqmPGpOTY/NHxwjea+g1Ha62ExjvC0dH4rXDJHhUGZX+dx?=
 =?us-ascii?Q?JcOH5ydJTkhMezRpjPEOGh0012edziIMKndSNR/UcvlSw22IngOKfax+cru9?=
 =?us-ascii?Q?SKWgDbRpXeuQNQgnDniqzEj0y8I7q6bR2IpJBbmkfOBeNAQvCCGvEQWX5Atu?=
 =?us-ascii?Q?P10DI2EhsXRWQuPcmgrJH0KEuG3vnVQj1E+q0tlZ9ntdxxpkvCifUQpRufNf?=
 =?us-ascii?Q?HyNhPe+RZytlhGdhosSpeFcBRMPquWbxMNCpAvUG8V1m57UzHQdbgwgOp2Xc?=
 =?us-ascii?Q?t7a7aFQKwXkjm4S+KJQ+K+GqD0wnW1GnpDKpsQzVHNbw9pXG71IS0cs98sVX?=
 =?us-ascii?Q?BjMCxmcESgcAs6i/UX/0oTJFD/VpveZuV36etpKZf6/iJ2HgCVQQZCh4SG8k?=
 =?us-ascii?Q?HE5enAZBQxFMPOa+oqtfwtEfbsrAY+dd2Wi0o5+4s7M18tRaGVAeCEtTs/xv?=
 =?us-ascii?Q?0GffOqH5CrLGPU6kooPzK1qUQuvhTm+MhZBfBun14CGmxLLcZTV+iQJWXP1F?=
 =?us-ascii?Q?EzcflP6Aw6wGVXuzotNRO6itXZh65qCoc3GhilX/cG0ujPjOSoCK7tLzNPvE?=
 =?us-ascii?Q?W1wqmQogWxyjTSHdM/vzNZa+PVbhXu7V2TcjJrlwSUZP/xP7qz8ntB3wNqoY?=
 =?us-ascii?Q?Jw8ZVbF1lSx9vIIPs/UQRsfxrqRkSFilA2M8Cfp1EGt+qk2yUW0MhvKsrcdd?=
 =?us-ascii?Q?KVekWDmoeUlOCzXd2Ngdac4W2xTXqAsGAvepHE73n1491QnsNqonAwLo6sV+?=
 =?us-ascii?Q?RRVDsmpIY4d9H2QeIxLq+ertJH43jlX1h0Lti1ngfUznsysHSApzqFY8VKmN?=
 =?us-ascii?Q?9HdpSIoRQNvlw1GJFzpwXlDS7wA3cJVk99CilSiKH4RvMM4k/c3zoLmtP8pb?=
 =?us-ascii?Q?3IfR6+x7FkcjkbSevseUle9GBVtM+oEsDpkEKvEmTUjHrW4ZPrh6NOM8Vca4?=
 =?us-ascii?Q?m6pIaiitWtxywEF1mbqmyKri+9fG2ouCi6ikZESFVjEazA6ax69dUEBqFsvy?=
 =?us-ascii?Q?lg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	s6zMjF13Nyv86F9J/onKqY8v+pRrmT825TbBBjuvcwYFyHMSZKdsTuegbhVzLNWX27q9fO83dlGWvF4nUyv8OPx68A8TB0ocWVcJ56MU+R1yvKfctgiKjYl8gqnz6REgGQEi0WsB3hKxIkEiyyiKIHc7NmGOcDO4g9SxUkIAqV6MErZyglVqNk1mQsCR4vUplPtizEmcefkTztBLFLBdvUgw+Ukdhox03dNAMHmjaa3HSwhU5Ny1FeXlnzqqkk4U1KkK7QLjWaiGripRmkj25Yj2V1xJLAjKKv4JiYQjep8c6wmz4Z/wsLoFtzaHPEh8bM15PE5luWKs7tHE8FboKiKgOWQDwTNcZ0xGnxzWDwyLbUmcBgz63b5Yg1B0uSW0n7AHJ7Buz7S0iQ/6dJYD6eZ44BBmpcPFGH6b4U+yAyp0GzCDETZrRsTQvG6tecJ7MSJSVCKdkkMDmslSk1rWThI7uvwAB1HT3Duv881H3llN8WRcX0/oubolPd/R/3mTeFIItxavo64H1O06lQ1VmxKg2KITl1lRlP6GGcaXi3+/iOLxT8a3+7h8NZIs5S2KJq7+qHJeufLaajXV4/RbU+Dome/UywFFmo+n0Puc2vM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47697ff3-3920-41e0-fc24-08dddb438cdf
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 15:02:13.0169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Zi9ahBdhjqH1TlXtl7zCFcJCRyGYL1iA41GjnniFGUkivykQtt2X3eJ7I0K3/Va3LInMJAphAIGZ/0Y7HhHYiBbWn5VLUcmR/4V729+3FM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF912A858AF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_02,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 bulkscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508140127
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE0MDEyOCBTYWx0ZWRfXyXQOZbM6BRum
 NfU6onoDnPVEwCKNTKqcWck9V0yMepi/uP+IooFGVF0EVufAamacR14r95y5/8vhIpCVOY7kF04
 MNyRxTVruJLi5uOp20H+OLJhrPSbmqGqqs9nWm8EVo5BbzimYnO3jsz/LiC77/wWii5krZyrsHl
 TBUl9YiXHAFOM/5EqPvYuFeWZrg0SdxX2Su728WvhTOsTBEbIpk7SrQvRMLHwyQZmYkQiXYaQO/
 VFvDsDsThJHvbridg4vJQ47HgqiiVVCSnAZ72EFfAqvhinkEKm25DOwcBNw85VcgoTQhOIL5FLE
 jiUNl263DoNuQ8isEGUR1/j5YZUqn32OodrUD0ZLTGuJ/5Jo2CazoKIP59wWvGO6wpSk+65Re47
 KPtnxSK2fmF9e8+1z9dIfpD8uvd8OGn2Z2RgA9zbgdek/V/fBIMzQvlz6uOu3Ny19x/1JSLL
X-Authority-Analysis: v=2.4 cv=eIsTjGp1 c=1 sm=1 tr=0 ts=689dfa7f b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=7lCyswls6S6VAn4xJEQA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: HGsy_lMiapVXjdqRI4hM_HqBiLC_rgzU
X-Proofpoint-ORIG-GUID: HGsy_lMiapVXjdqRI4hM_HqBiLC_rgzU

On Thu, Aug 14, 2025 at 02:08:57PM +0100, Mark Brown wrote:
> On Thu, Aug 14, 2025 at 02:59:13PM +0200, David Hildenbrand wrote:
> > On 14.08.25 14:09, Mark Brown wrote:
>
> > > Perhaps this is something that needs considering in the ABI, so
> > > userspace can reasonably figure out if it failed to configure whatever
> > > is being configured due to a missing feature (in which case it should
> > > fall back to not using that feature somehow) or due to it messing
> > > something else up?  We might be happy with the tests being version
> > > specific but general userspace should be able to be a bit more robust.
>
> > Yeah, the whole prctl() ship has sailed, unfortunately :(
>
> Perhaps a second call or sysfs file or something that returns the
> supported mask?  You'd still have a boostrapping issue with existing
> versions but at least at any newer stuff would be helped.

Ack yeah I do wish we had better APIs for expressing what was
available/not. Will put this sort of thing on the TODO...

Overall I don't want to hold this up unnecesarily, and I bow to the
consensus if others feel we ought not to _assume_ same kernel at least best
effort.

Usama - It's ok to leave it as is in this case since obviously only tip
kernel will have this feature.

Cheers, Lorenzo

