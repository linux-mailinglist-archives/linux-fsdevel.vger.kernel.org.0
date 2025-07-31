Return-Path: <linux-fsdevel+bounces-56418-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F1EB17356
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 16:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12E99178752
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 14:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1643E1A3172;
	Thu, 31 Jul 2025 14:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UvWM/el8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lIX2Iq1o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692B4639;
	Thu, 31 Jul 2025 14:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753972836; cv=fail; b=KBiax3/4VWCB1nAVv6BN5avsa0oqm9I2WmS+lsWuyZF7nG+ajXYixFxayUan/5hToVy0EUiSjuk2xREgqZ+7I4gGAvuGDLh0c/Tt0Q9vKau6q+QenqfY5dLFYIocWhMbrPgF7NXQ6M/Ont++VChCCYLk6inU4IKuI9fDQ7XQFGc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753972836; c=relaxed/simple;
	bh=256MeTCxVNMyEjfXfVSIWHTMSIXgah1kqq0cl6WlOKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FgxxlMPgqpNL9A6LnD//viic+P6d8bgVsEL80qvFd0kvSvrn8BXnLkhCMUaSoZTac1CXc0gboeUdoSeYLN+lvgOw7aAEowYnqZX+2bl+rx0TceQPj3QZU70wOjy0/WRLYqwsqNZGzxzOhXJNHMbPXpBHdKaekYjRxMveoRwsLoQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UvWM/el8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lIX2Iq1o; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56VEcTke010190;
	Thu, 31 Jul 2025 14:39:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=RfLpVCXICHp1s7G3SV
	Epv2Qm2LzV5A39m1+h2FBSXQU=; b=UvWM/el8YkEPzNlBD6u6v4EYE2TrxEAbIK
	ZgiULfo7BhvXLm5ngHZJlttYoZ/a/kazLkvUnMEooh5eIpfmzeaIIvcL7AgOOi1q
	I2ATzoq/N5pShnwr69phu9ongXO2NRHgAd9uIrXM6dh0pTj1Q7B2+1nHI6+vVF3O
	+bCVYEsv6B0myc8Ar7eyOmwFSqjmZWMRB8P4YVl8+BndtmtfEzz2oo17ja3BinAp
	cATGV0LYi1AOta3ErmNfTqxvvMuPit7GvNGfHVpm6ePx8+w1Q0zTdSx0x8kMCpQ6
	VhGrhcV+HyLDsxjn/uFG6aVY+qxslz8GIIKCBGgJV2HdDPuGlF+A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 487y2p14xe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 31 Jul 2025 14:39:40 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56VEAsts010491;
	Thu, 31 Jul 2025 14:39:39 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 484nfcdweu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 31 Jul 2025 14:39:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZpPC8aC3CPwX4VXOewAsFHwJ0Cug3kYEL3FtdS6Knj8P27FVwt4XJxjSeMOz05fXJIgtZe/4fA+icq69yJb5sPLYzcVjalMvO+4zAwbd9smR1jLlKq/fkbZH8U0dJkpmBzPQzYO214H8C86/0Y+taVwhdw2ue0lDIrT5iO/sBgBSTQ0r8Fz5vq4f40wtRqMQs4CAM+nwVMnqvkSVSgjiY4z5nKFjbEk2X6GNFiUXyyu13iy6PT1k9RMmTwepVBdXUAVvJSLEmgtPQchgmeaqExLlMnxeMbA9y748DRhc7dbwb99VtVJBmMrL9yv1fHe14i3207DsGdMUJYgx1I1wmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RfLpVCXICHp1s7G3SVEpv2Qm2LzV5A39m1+h2FBSXQU=;
 b=qUC6rTusYPpDPA61hrJDF82Wn2r2VNJR1Jda0JOjwMvSfjplk3F/IKSJzeDsX1kJBBixyZpr1vHL/A2XnR7Er+6Topfmcxb7CBn6ftPzSbZQgpECPXarfqGIeGwbxgktHuQeimx9XWc/Rg1I7EgKmMpAJvBzoZXIivb+k8/xf97pB2y5MNHliSL27e3d13zhanYc1m7ezHDdXYrxtvRe5zqHbnzvCOM4In31eo7ElAv+GRz6uXsPjh6ERD/EN2Q6eJdCJ4kFMcGNSphnItKKr5EJAjnC7hrQK7UkE/2Q/ih90S7T54hjmYGihBPKMmH43lFWLIS8fVA7Rde5/sCdUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RfLpVCXICHp1s7G3SVEpv2Qm2LzV5A39m1+h2FBSXQU=;
 b=lIX2Iq1ofKcWXTyQhlvFwg4ngc162AH7s685cTTq7dT+Ev77QTfQcz3wBO+VfGnfBO2gpz8Fu8i5OOPvLONRw5bhybWzK8p+iKm2UXjBPPw6N4exkeFhCXRSVuArVQwd4z/RWvhJgV+Cd/Qr8obpE2JkP/zdhiE6JCutEB/7rcI=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by BLAPR10MB5074.namprd10.prod.outlook.com (2603:10b6:208:30d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.14; Thu, 31 Jul
 2025 14:38:47 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8989.013; Thu, 31 Jul 2025
 14:38:47 +0000
Date: Thu, 31 Jul 2025 15:38:44 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Usama Arif <usamaarif642@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, david@redhat.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, corbet@lwn.net,
        rppt@kernel.org, surenb@google.com, mhocko@suse.com,
        hannes@cmpxchg.org, baohua@kernel.org, shakeel.butt@linux.dev,
        riel@surriel.com, ziy@nvidia.com, laoar.shao@gmail.com,
        dev.jain@arm.com, baolin.wang@linux.alibaba.com, npache@redhat.com,
        Liam.Howlett@oracle.com, ryan.roberts@arm.com, vbabka@suse.cz,
        jannh@google.com, Arnd Bergmann <arnd@arndb.de>, sj@kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        kernel-team@meta.com
Subject: Re: [PATCH v2 3/5] mm/huge_memory: treat MADV_COLLAPSE as an advise
 with PR_THP_DISABLE_EXCEPT_ADVISED
Message-ID: <aca74036-f37f-4247-b3b8-112059f53659@lucifer.local>
References: <20250731122825.2102184-1-usamaarif642@gmail.com>
 <20250731122825.2102184-4-usamaarif642@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250731122825.2102184-4-usamaarif642@gmail.com>
X-ClientProxiedBy: FR4P281CA0262.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::6) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|BLAPR10MB5074:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ee7fc90-8670-42c5-f0e7-08ddd03ff52b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sChU2SOzSvac6bve6qqJGu4AomqP95Sw7UGFjjE9YbKS/f/Q+gLFpqoehnpV?=
 =?us-ascii?Q?GKR/9sN5tgWb/8OwMtetgAo8nrmkrcguUpe5jIGu4U8vortYP+2M4sn3+gmx?=
 =?us-ascii?Q?Iaf4tLLJapNIjEhTfngOiM1ybHuMZekorUGRodmegEXkBMZKgM1Kuk8/IIzh?=
 =?us-ascii?Q?2J7KhVx45Oxbcu90UrIliMZSrQ6EF+P+tAOccO/WYcNmE3Tg0inlL4Dwb3t+?=
 =?us-ascii?Q?73wG9vD1oQGeA4uJGFeeVKZm1uY0N6zWAUArM0jHtTlmRanjx3O20PKgIcOx?=
 =?us-ascii?Q?OyjrZKPMt8S2yrfo3s1QBJJfHIlgUkUUFByPjbLVhC0dKK5Ol3WPd5DeAtLy?=
 =?us-ascii?Q?bqoIJ3/w2tGUs7XlFqgnzTkIzywN9ndsWng2kNQ8gsZTyBh/ELU3p2SJjYkb?=
 =?us-ascii?Q?aUKJsFB6bn4p8gtoIboneNZS8iVt0YQcDVsxlV5/MsScjLsGS210ak8UjtAq?=
 =?us-ascii?Q?6mAh0vaLdp09sPcSh+AVV07LpeSUYU/qzU2a7ZN5mv6ZyxCe7A8DGUzDn7As?=
 =?us-ascii?Q?kd1zt7PbeNCT4lTvCt9k3zLgDPhN0ZNgt/uk/ryY34dCwODk0CuPkkc0fDpl?=
 =?us-ascii?Q?v/NhPXG17aWrA93yPfGiWwnYAISOzEYl1EsAbEP9uYYHx4zM2/5/NUaXiW1j?=
 =?us-ascii?Q?PofuENXd7yP8LsyU9+yi4FXySNjLdEMr6htlbTu7bt7FV+21juLFeWQH7rVY?=
 =?us-ascii?Q?M0xKgg82ebDk3SbwCgelwgnNgF9pY7fsedRjwGECCWaAGgecnbNpDNh/Elbv?=
 =?us-ascii?Q?/9PVV1UYSiK8k8+q1L/+RjlqxFhUCIgx0x+j2YJN9gzwwr9UMX3mKGvSHYly?=
 =?us-ascii?Q?EAyvGaR7ZjiUAjAiHst5sXF7cZTjCKUjL6aa5XDMkRAxFahgKc3AlXAPSZ8X?=
 =?us-ascii?Q?bvwJnjA2BI1JhAQE2Y/RJipksdMHogx+uYDcgtrfjXxloCOQ7xCV056Hfra2?=
 =?us-ascii?Q?u+TT/e/zmxUy3FZRhHW0aPpj0wjw8AND7D3fC14vnLzoAk9wAFACYnMDKuGO?=
 =?us-ascii?Q?fjorxvgg/g/Lanal/5XWP8+EPZzc+jpYOBzkEOncHzI8jx3utrp336cNEL36?=
 =?us-ascii?Q?bKHBwU985uSOja36LyI5ISczcDr7YEYXnwRpqGxMaaKanK7kcImY1JFoIGn2?=
 =?us-ascii?Q?ZzYcQB7CNc9ktwJPbTdScMxKnldJuys8ih2Ig8cZhaxszY7diPVdiQKk0YNc?=
 =?us-ascii?Q?7rAPblyoQJXVc5CARA7gp1hQOsajKsQmxJ0DrHse8x9xMeUcLtpP5qq2L+Ep?=
 =?us-ascii?Q?WlxIq9RLcoab/PdjXdE/JWRF0pu5rwuwZwWxLfNFBycKgW0tqqHx2z8SB3F4?=
 =?us-ascii?Q?p5rgEYuNg23VfhJM4wCB6wT4STZWjfmLdKPLwv4m1H7r+/C7tyJukav0dKmU?=
 =?us-ascii?Q?eUlPKJSxy3lM/RbjueKAUcMxO1SmP2eU4N3M8QNhJ5OojIViJaDAQPIa84TL?=
 =?us-ascii?Q?qkopMGmgwEo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GfZ6vWGwEHOixah5UB0wIKPv2RLNlSl+s2tFl8IC1GDKkMWVa/x4gUoJTNhE?=
 =?us-ascii?Q?uBtlOIam6YLFaLxyCAZajTYXmCKZcYhLVuQ8w4AnY0A6r6HPXwBYMEXGdG1c?=
 =?us-ascii?Q?BQjCdkCuqzeBX4yXKRecX8WkOag/2w7lXibzjvh22t7azjViDEmARIISHWK8?=
 =?us-ascii?Q?Akg976P31DkRTSfSKRnO4HLcaf0Onowi++lWNWY4IKnjuOVO4wuVGn4InJZu?=
 =?us-ascii?Q?JMlUqKdeNhfwxQtSxRiahoCNoPUUe2QW+SR/AhsPUL5AntSZfPu6H8PDapFC?=
 =?us-ascii?Q?/zL+YPcrzCTyOcCzrsFOQ2UrjFl4gnXcC4vj+BuiKcyvMbL6Lcv51Eh2CoS/?=
 =?us-ascii?Q?h5gzckhYGxX/LmyRTXyhSH7g2AneTnBH1GtPRRlDbn8Db9VFo9vMZ18MRWx+?=
 =?us-ascii?Q?2V6lNMYtv2Msqwbz/3ZTLiT7l2nXvRqGWre/GwznjxEkSsIIogUJMfjUnffh?=
 =?us-ascii?Q?+DMVDMk3+SK6hi0+0RxkhkGqwmSktAWT5RWDzWg26Hjo/CNZNU2eM6Wd1l70?=
 =?us-ascii?Q?gRjqtQew6Y892n4+IojJ4iMQp1sus9YZxcTxOjrM4t4iFGVk6hD6jkSUyl5l?=
 =?us-ascii?Q?wv6JnaBRmQbHcp8qVKe8+r6i2jm58rkqIxhd5mfc1xmP1NzfuAahbewfFlW2?=
 =?us-ascii?Q?jwKFkUVzL/UAoO/mu4pBpHVMLu7JBBukMdDyXLmBHaC9EhtECKaAJXxHthwF?=
 =?us-ascii?Q?8xm3fWGtNRG+kUayy0iOa5P40Dyk9GqK3YBSLd6rOcrTlkMCtKA112ztPMS2?=
 =?us-ascii?Q?boQ62IutbgNQ7Dl7gZuZ9DZ21bOT6lnaKkF56/FA/HGMkAKQ5jGkWNOks2Pa?=
 =?us-ascii?Q?OEjIRKWOM4WhW1RlRyD7qVweEm9gsWH6pthdpoeTDnxWR5mVdOJ7yzo9v2Ag?=
 =?us-ascii?Q?FnPwiQmeOsR5ygIn36DHpjxwhyJoRRrCPkBsAzHudFt8lyjYHTkmsvmTQS66?=
 =?us-ascii?Q?AdP+HxNJwrVBPOiJNG4+EH6jIBC6/s80e+uTq74DFmzCX1beUAMsd9tSTEAy?=
 =?us-ascii?Q?W2RTGPdZPeITRCmGl7Sb9l1i1TlttokqZ18Cjpjv+jNXKmoRGO0qTnW2LBDi?=
 =?us-ascii?Q?Wl+MI4C6lK5C2r+HfkemXONxOufMw55ULJyF2hAY55OlvzXl5KgN1vOeF4B+?=
 =?us-ascii?Q?/JTHh6zH+zFeCN2hLRPDf9YC4Nyjf05rN6/gtzsjQhXDIs3ZR0hIU4JAWHsS?=
 =?us-ascii?Q?tKM5aacYBuhOhSQ1BtDSZ1AgKajybigIP900vmAOUBo0JZ0RirLkFNsnIWI/?=
 =?us-ascii?Q?lXgQIp1hJ9qP/xcv5WDlldcxPDboGCD6iVarcgfAOrx98LPgCaE3SglveZII?=
 =?us-ascii?Q?4mq/+KRNj7+30/gFQIpwK4mmgi+assp/USx65MrmG4hHLahGIo4VfW3vkbKi?=
 =?us-ascii?Q?NvgkyZ36P4gDQa3+fy8FxCoRfFvW/lzzSlDlyBVk7xpRoCGpuKpzpobEmMfi?=
 =?us-ascii?Q?lttvQnQQfXPN/YI+//Kz9mIAxdhpfLXjdhycxJ3LfwhBOsdDVVKf4YarEns2?=
 =?us-ascii?Q?hBio1VmrNX3F45ItcTeq2SgzCJrVVqmuZDrRZuOG336D12EHrbZYZa8UAN3V?=
 =?us-ascii?Q?bQDNWQSX/H9Bu8Qrd4/n8VRkRuUVP3zNjtbka0ehXBJPR0vGQ3F2oC3A81Jz?=
 =?us-ascii?Q?jg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RDWQfr/U4C18olsqvVPDNr6pwCHBNpJcRiyPp9yWSUc2lmc3nzashazUYdAlAgPkOWoIyTqj53d8CM6TT5d+n+2nzLmseMfozvjvj7S2n9bTOIsdz+azHlRzJkzGDPgY2NQd5HgapYdavaxO0YESzUuFp6CaoFmuu7CPvV6K3fmJgmeeYuD1QMR1TWtQ20XDiN2EQQS6KmRNC8SQh+eVYvljzZQ4EJ8UGGyJthJAbkxkic9WWDa0tfv5qZKyotmRmATGFWvz4/SsB8GLytspIPIwjqyrDNcscnzZWbz8yM4m0P38h4FZ/ctSmhEzVGcf1q4meFyMXvWmukeNPNKWknvNP0Qwf5l0FtQUlWY8WgDSTu/AXiZVbT96lMqN2bqIRnU4evJTqTZkio/3ffKcNuhYEOv7lja81RFM77VEw8v4RKl5OGZoyxQlniFcgJJ3tUPKEwtxq3z9bVwRnUBoUjtTGkYV7PzO1YHm0ejkKq9bLCeDp46zzcMqllZZXa09f7rXqL9qD+MvAb7LZXlx9RZBqdcjT6I36g9gnBS1nDUV2A5yF7rPMTNqdoPzCnG9s7NOBTrsxHwW5iILmKEQrZhS0AhSGCTO0SRPQnZuVC4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ee7fc90-8670-42c5-f0e7-08ddd03ff52b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2025 14:38:47.2190
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xPTVmwVXF+OcMuwVHahV85Ge5RZzFQ/sqSBHLyS2ykXa1WwDyCNDLDe1I7+lyMRyXmu5VcDaZxNRdjhS04BrIsd9znNwsamzMbFhAb+cxQ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5074
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-31_02,2025-07-31_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 bulkscore=0 spamscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507310100
X-Authority-Analysis: v=2.4 cv=COwqXQrD c=1 sm=1 tr=0 ts=688b802c b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=20KFwNOVAAAA:8 a=pGLkceISAAAA:8
 a=BoEdwevmAbuWw87gj0IA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13604
X-Proofpoint-ORIG-GUID: IYodLt8wQYGGsYE14rziTpDnHJr2oNaP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMxMDEwMCBTYWx0ZWRfX0r7pLo8wvn5I
 oaUAyr2/XEmEcYk3OXLQZ7E4F0dVaw82MHYOZTk2V1SNA/07Z5KN/YWVx0/bB06mMKhLZNjE/q0
 wuodho8DIqeZ8fBluua3iX2OC6o6Elm7bqXqePvwhYNcGP1yd6bsDO1TLCpnwsPg6d27Ua7iaVA
 IDuC3MK3ljNW2SwyWLFne+fVa3zth180NOPxkwFRbDfDBay5zWX5WvvvSTpQtLUiwdlhHQj5VU/
 1EqlvibiFRXCJ+wUoCEkQxZJCQfTJYIo4K7v6Xfxa5an/s2UWd8oGJdDWfmXAev/Q39nJfRWQLP
 g4ekqSWozE15rg2RaFMriQwv7PpE0XKBwz4LsAtVDsmdpafBmcJztjfnLJ2/5f5Bq5iON1WfAQe
 /GHyMqeGoqUF0o5OjUID3Se53atIjpuWZ49zNgbydU86jNTYtW18mDwfntZmy8OKplYjHniI
X-Proofpoint-GUID: IYodLt8wQYGGsYE14rziTpDnHJr2oNaP

Nits on subject:

- It's >75 chars
- advise is the verb, advice is the noun.

On Thu, Jul 31, 2025 at 01:27:20PM +0100, Usama Arif wrote:
> From: David Hildenbrand <david@redhat.com>
>
> Let's allow for making MADV_COLLAPSE succeed on areas that neither have
> VM_HUGEPAGE nor VM_NOHUGEPAGE when we have THP disabled
> unless explicitly advised (PR_THP_DISABLE_EXCEPT_ADVISED).

Hmm, I'm not sure about this.

So far this prctl() has been the only way to override MADV_COLLAPSE
behaviour, but now we're allowing for this one case to not.

I suppose the precedent is that MADV_COLLAPSE overrides 'madvise' sysfs
behaviour.

I suppose what saves us here is 'advised' can be read to mean either
MADV_HUGEPAGE or MADV_COLLAPSE.

And yes, MADV_COLLAPSE is clearly the user requesting this behaviour.

I think the vagueness here is one that already existed, because one could
perfectly one have expected MADV_COLLAPSE to obey sysfs and require
MADV_HUGEPAGE to have been applied, but of course this is not the case.

OK so fine.

BUT.

I think the MADV_COLLAPSE man page will need to be updated to mention this.

And I REALLY think we should update the THP doc too to mention all these
prctl() modes.

I'm not sure we cover that right now _at all_ and obviously we should
describe the new flags.

Usama - can you add a patch to this series to do that?

>
> MADV_COLLAPSE is a clear advise that we want to collapse.

advise -> advice.

>
> Note that we still respect the VM_NOHUGEPAGE flag, just like
> MADV_COLLAPSE always does. So consequently, MADV_COLLAPSE is now only
> refused on VM_NOHUGEPAGE with PR_THP_DISABLE_EXCEPT_ADVISED.

You also need to mention the shmem change you've made I think.

>
> Co-developed-by: Usama Arif <usamaarif642@gmail.com>
> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  include/linux/huge_mm.h    | 8 +++++++-
>  include/uapi/linux/prctl.h | 2 +-
>  mm/huge_memory.c           | 5 +++--
>  mm/memory.c                | 6 ++++--
>  mm/shmem.c                 | 2 +-
>  5 files changed, 16 insertions(+), 7 deletions(-)
>
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index b0ff54eee81c..aeaf93f8ac2e 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -329,7 +329,7 @@ struct thpsize {
>   * through madvise or prctl.
>   */
>  static inline bool vma_thp_disabled(struct vm_area_struct *vma,
> -		vm_flags_t vm_flags)
> +		vm_flags_t vm_flags, bool forced_collapse)
>  {
>  	/* Are THPs disabled for this VMA? */
>  	if (vm_flags & VM_NOHUGEPAGE)
> @@ -343,6 +343,12 @@ static inline bool vma_thp_disabled(struct vm_area_struct *vma,
>  	 */
>  	if (vm_flags & VM_HUGEPAGE)
>  		return false;
> +	/*
> +	 * Forcing a collapse (e.g., madv_collapse), is a clear advise to

advise -> advice.

> +	 * use THPs.
> +	 */
> +	if (forced_collapse)
> +		return false;
>  	return test_bit(MMF_DISABLE_THP_EXCEPT_ADVISED, &vma->vm_mm->flags);
>  }
>
> diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
> index 9c1d6e49b8a9..ee4165738779 100644
> --- a/include/uapi/linux/prctl.h
> +++ b/include/uapi/linux/prctl.h
> @@ -185,7 +185,7 @@ struct prctl_mm_map {
>  #define PR_SET_THP_DISABLE	41
>  /*
>   * Don't disable THPs when explicitly advised (e.g., MADV_HUGEPAGE /
> - * VM_HUGEPAGE).
> + * VM_HUGEPAGE / MADV_COLLAPSE).

This is confusing you're mixing VMA flags with MADV ones... maybe just
stick to madvise ones, or add extra context around VM_HUGEPAGE bit?

Would need to be fixed up in a prior commit obviously.

>   */
>  # define PR_THP_DISABLE_EXCEPT_ADVISED	(1 << 1)
>  #define PR_GET_THP_DISABLE	42
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 85252b468f80..ef5ccb0ec5d5 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -104,7 +104,8 @@ unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
>  {
>  	const bool smaps = type == TVA_SMAPS;
>  	const bool in_pf = type == TVA_PAGEFAULT;
> -	const bool enforce_sysfs = type != TVA_FORCED_COLLAPSE;
> +	const bool forced_collapse = type == TVA_FORCED_COLLAPSE;
> +	const bool enforce_sysfs = !forced_collapse;

Can we just get rid of this enforce_sysfs altogether in patch 2/5 and use
forced_collapse?

The first place we use it we negate it:

		return orders & shmem_allowable_huge_orders(file_inode(vma->vm_file),
						   vma, vma->vm_pgoff, 0,
						   !enforce_sysfs);

And the one other place we'd have to negate, but it actually helps document
behaviour I think.


>  	unsigned long supported_orders;
>
>  	/* Check the intersection of requested and supported orders. */
> @@ -122,7 +123,7 @@ unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
>  	if (!vma->vm_mm)		/* vdso */
>  		return 0;
>
> -	if (thp_disabled_by_hw() || vma_thp_disabled(vma, vm_flags))
> +	if (thp_disabled_by_hw() || vma_thp_disabled(vma, vm_flags, forced_collapse))
>  		return 0;
>
>  	/* khugepaged doesn't collapse DAX vma, but page fault is fine. */
> diff --git a/mm/memory.c b/mm/memory.c
> index be761753f240..bd04212d6f79 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -5186,9 +5186,11 @@ vm_fault_t do_set_pmd(struct vm_fault *vmf, struct folio *folio, struct page *pa
>  	 * It is too late to allocate a small folio, we already have a large
>  	 * folio in the pagecache: especially s390 KVM cannot tolerate any
>  	 * PMD mappings, but PTE-mapped THP are fine. So let's simply refuse any
> -	 * PMD mappings if THPs are disabled.
> +	 * PMD mappings if THPs are disabled. As we already have a THP ...
> +	 * behave as if we are forcing a collapse.
>  	 */
> -	if (thp_disabled_by_hw() || vma_thp_disabled(vma, vma->vm_flags))
> +	if (thp_disabled_by_hw() || vma_thp_disabled(vma, vma->vm_flags,
> +						     /* forced_collapse=*/ true))
>  		return ret;
>
>  	if (!thp_vma_suitable_order(vma, haddr, PMD_ORDER))
> diff --git a/mm/shmem.c b/mm/shmem.c
> index e6cdfda08aed..30609197a266 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1816,7 +1816,7 @@ unsigned long shmem_allowable_huge_orders(struct inode *inode,
>  	vm_flags_t vm_flags = vma ? vma->vm_flags : 0;
>  	unsigned int global_orders;
>
> -	if (thp_disabled_by_hw() || (vma && vma_thp_disabled(vma, vm_flags)))
> +	if (thp_disabled_by_hw() || (vma && vma_thp_disabled(vma, vm_flags, shmem_huge_force)))

Hm this is an extra bit of logic, as noted above, we definitely need to
mention we're changing this in the commit message also.

Since shmem_allowable_huge_orders() can only be invoked by
__thp_vma_allowable_orders() with shmem_huge_force set true, and it'd only
be the case should TVA_FORCED_COLLAPSE is set, this makes sense.


>  		return 0;
>
>  	global_orders = shmem_huge_global_enabled(inode, index, write_end,
> --
> 2.47.3
>

