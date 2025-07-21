Return-Path: <linux-fsdevel+bounces-55587-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 53AFEB0C2F1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 13:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFE557A74F9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 11:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 559A629E109;
	Mon, 21 Jul 2025 11:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="X7FA0seS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ruD111BG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F14B29E0F8;
	Mon, 21 Jul 2025 11:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753097349; cv=fail; b=Vd3wX20jp70DD6TFUGS9knsIg7x43akwrilyX1dLtB6gkFwCZ2J8kEpMCeR3DC1bii0SK+XJN+IpqHWp2xvv1J3O+KLuZ/EMXgti1f4dWh2AjvFn0MQvdeuPC7d4Fx543Y8wTREzofFzfuRXVW+OmSKjhRS6dJjpg4YqbXuS4gQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753097349; c=relaxed/simple;
	bh=nJ3f1t5Fg49ZpiaWYoYBcUOlQUD7Q7YhxsHwnrzCF/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RZnt1XVbbJEVS4kujCqzBN4GMMCVEjBaUMXEuxrCtIQli9GfWN/aivO2hbYjTuM4QTTH9cluKx8NQU0HZzTj6G90v86aNw+WxU6esHd6nAP0TSZlmOrBWwNzp3kBhdMkrSnu6K7ICtv4plUVB1g3MxtDBOnI+xwzq09Yy3rF9ls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=X7FA0seS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ruD111BG; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56LBBvOJ012002;
	Mon, 21 Jul 2025 11:28:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=4c11PX6KimWkA/zxHr
	xnra/2AYuLPErAXmkAhmrJ0AU=; b=X7FA0seSMa4NwyHx8aXByUVBRMThWBZsxE
	jQsPwtgw7B9p9kbMGA5hPwSSJ32dlRVy3nB0o4rhQvnDza+8Oi+7e+DQKRU2sYEQ
	eu7kSfQfokDJY4wPseDNaihojpP99v/dRUOCh0y5KqM8nbavgqTIBGVHbEcmkw2Y
	6x/qLDmS0vH1DRx8ya2BBaLPaLpOO7/SpmE2oYFqlPOf/SX7rhlcyUB1d0SdMtRd
	LuJqptt95KfacZTY1Nk6j3tnaHyNmwZifn8ig1N/U7714Wcmf7tQVaxqve/AYY+r
	4VbW5Rwyw4rvaRs0MkP5egHS83IR+f8OA+qOHd69VJjCieAsFTDw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4805tx2ceu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Jul 2025 11:28:34 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56LAaBOq014405;
	Mon, 21 Jul 2025 11:28:32 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4801te6wcq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Jul 2025 11:28:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UyBtjy6xbLc0uUB/8YHPJYXKR8jBNK/xB6ybH27JXGNyaejcIccmH6IDjxrt88a8RCj2wfjBUnEWVapt4i2xvU/LuTsthuCobeojk6qMq7l24fRp8++vvP5L6cZXQHJ8EiltZ8qS58+RPQZMrj4mFhiFleEs4nCi4I0Sh61RE2jc2jp9qN+JUeATK9phoo85nvhokSXY4PMqnJh2UqgkZrhWm7FS6UPjPJ+f4EkqL+GoZZrLAKn0UKIyEzoz7ao3gRctLZYoy7EvHNfwfKDnRIlgp/GL+vWc2X+gmSNMfigBz8eMCgyb4cuOXl/Ch3xfJbDLkd7xZLFBk4pbi4TtKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4c11PX6KimWkA/zxHrxnra/2AYuLPErAXmkAhmrJ0AU=;
 b=NOJGCnvNEhvpLLpqGHrcOShXc8W5K5UGK/LtCdt0XWpcNvSvFYk0SEo95KabBrTLLLeDQtjgjAXlO+DxATKjj691q5+elki8jQUi4iI1Ov8Z3s99e1KeLUbbJr4TC3Ns2DIOp9PXu8BPfkp0vrVpRBrdnvsDy4sOjIGagQnjwQhDE787XJOPrdROI/QZawWU4ZzKxFLvt8aEcIKiHA0ZlmJS4yHq515N497S1fp+RT9ogbwQMO6YJ2rtzVfZR1I7uxbZzZ1RiLRiD4w9OdHX74mzdSkSvuzNwbsmh2hPFjr3Ydo4IQF44QRNaG4LUjw1TGz00rvqt9QksEXa9z2H9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4c11PX6KimWkA/zxHrxnra/2AYuLPErAXmkAhmrJ0AU=;
 b=ruD111BGWMHpIQKXAFXs6Q0rqCvc83S3fTJhAnCjt/Uq9w4+OwXOx3AJJi3F85uHd97iFbf5f+2EiJXizNF1yEPGNBwYH2vAjdyTCeHQh4PApYs9K0QbvLx+7vw5pkXunpmVBKufaRC2gZBqeCGRpPyn92F5MQL0P+95tDka5Qg=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH7PR10MB7766.namprd10.prod.outlook.com (2603:10b6:510:30c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.25; Mon, 21 Jul
 2025 11:28:29 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%4]) with mapi id 15.20.8943.029; Mon, 21 Jul 2025
 11:28:29 +0000
Date: Mon, 21 Jul 2025 12:28:26 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Usama Arif <usamaarif642@gmail.com>, SeongJae Park <sj@kernel.org>,
        Jann Horn <jannh@google.com>, Yafang Shao <laoar.shao@gmail.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH POC] prctl: extend PR_SET_THP_DISABLE to optionally
 exclude VM_HUGEPAGE
Message-ID: <686d2658-a06e-46cb-af22-440b75ac34ed@lucifer.local>
References: <20250721090942.274650-1-david@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250721090942.274650-1-david@redhat.com>
X-ClientProxiedBy: LO4P123CA0060.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:153::11) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH7PR10MB7766:EE_
X-MS-Office365-Filtering-Correlation-Id: 64d514aa-f4af-4127-1fa1-08ddc849b740
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mFTtqjz4oRLmzPDZnh+WIke2WB0fYC17OnLpnEmfTWYwnhQU29AWqc8FV+0B?=
 =?us-ascii?Q?8Rwt4ODMV9TTHXB8F4iGq26XzqADhBypB1GpVa7Xw2vHPgS5EWqodvqmwjX9?=
 =?us-ascii?Q?P39ngrM3z2YGHISxZBnWkoUTKQ2ccYIJiX1kiRdxJcf4rlf9UQiBgJla5vED?=
 =?us-ascii?Q?WbfSKLAotmtu6RRDpY9rbawR3kw0nJeKkupBQF5IA4O+KRrwJypGtFTSlWzD?=
 =?us-ascii?Q?QdsMlWYJ9+pCDmMEWlr17RJwllyJ+bPH6Ef54bs3X3gjFJWef7WVs5RGAtNX?=
 =?us-ascii?Q?/9ktigsjtR5mV202Rq6OqNLt0LED9aTYo9Qhe/p9x6BYkwLPz8QXmjt6Lwzy?=
 =?us-ascii?Q?obzDvenkoB8rVo6wueW77+gWZ0/wZtuWhnhvJs+fniI45eTwYgusQMYWEsmF?=
 =?us-ascii?Q?fDeKOGYz3sjO0Ahl8YIUlKWvsPm2/qVShnnp7kdxuGbhnSvJPs7IU9NfKLBT?=
 =?us-ascii?Q?Z/+ER60VQ8vrCfSkuIWvyMBouKQfzdZgARfRj1NbfjgHBVdEGaRRdPYuKoAO?=
 =?us-ascii?Q?LunaTE4l+FP5sgL9IPV62eIM7V9u1YprHqmuQksfopoouYIIxLYd98T/Orcs?=
 =?us-ascii?Q?J2L4bdjWCXlb7i2qWMIZkoSScfhSvsWepDUxJcBaLbOykUNa/5Od8KAovNCi?=
 =?us-ascii?Q?F1h5eS/nqGpMTv6VnVTP5x4Csp5fKkAbsdCAo2jZzFo49rBkmW61TCVjGxwb?=
 =?us-ascii?Q?ctKZggbItQa7VHyIbVvauVaCIXglDUvSK2e+z0ZYjCTmH+NcvfyHhbJD68nN?=
 =?us-ascii?Q?xMFkGHosw+VJBZy3CnFrm4cBaxhPZKF5TITAm6zWWOVve7h6/ZOafEP1P0tc?=
 =?us-ascii?Q?pkZPqfreEUBYv8ZxvEZSpvEu8/RS1QV6B2kfzP5vVa1nwxh+YGyF2NOPZraE?=
 =?us-ascii?Q?AFSf6fpA2zrMWNxkMWCTUSn5Or/347EIrm24o2PgpLunc8gOaVwijw9buN4I?=
 =?us-ascii?Q?3WFugsNEaDv8bqfAslqLCWe17vWypj5fq6JclXn9J82xZMHAZhSLfUdYZX1S?=
 =?us-ascii?Q?Z0pP/D2EZJ67D0FwdrMI2T81cXrl+lhUSrZfFDNdmZ/LdJhfkVOXYzYMoJ+3?=
 =?us-ascii?Q?LNj1VNPuR/+kJxV35YDvkH9WcrkVFpBw+2TjnxAgKnr7ArNKMzGc0gN/P69u?=
 =?us-ascii?Q?92LdLcWXkRB5OBwA/PNSj3GYdUE0eUSnK1If+MEpuL1YhNLqG6XHlF8inijm?=
 =?us-ascii?Q?B9YRPMut7KO/BxSR9Ek114b64KO31kOwF7dpd/9OLpZOlJB6QpT+kfMSLx+W?=
 =?us-ascii?Q?BcxT+InCDm89H9eRWfWuYo/sQ3vHwOnhZ2q70JbguPKUcM0sgD95CkCxnbnY?=
 =?us-ascii?Q?y1/QgmNA6pMFEYFIGcVWpV8vVx8n7JB8uVSGH/vE92jS1QQei108x9FpQxc+?=
 =?us-ascii?Q?6H9rvvyjHuJECDVM1wUbSoQuDz090PAgiudWunpPYQgS0RzsEF0p/sp6aNLb?=
 =?us-ascii?Q?HnMp0oNfTAE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zeLFzPns6vSfgWBIcs2qILTHG9CTuTW6XGypks0u70SwHAZZyfAPlvb05B03?=
 =?us-ascii?Q?zR30gd3mAx5HK3gk/Rv7zKHK5/if8z13P9V7qOw/yt5+/UaHqZwjcivemaiB?=
 =?us-ascii?Q?HoivyE7x5ULxSpvovxhM5WZTKNPU/t7ThVJhkuBU9gHrhW4mdssOuWQ6GSIU?=
 =?us-ascii?Q?1LW3R+KCk3Rbull5LyG1OR7am0sPpWrGBRI/oaAFnU0ssFX4MlqL6PcKaQBb?=
 =?us-ascii?Q?KiH9YD5KDGufV9VbmYxsxej3AKqSmjIYRPdBR52HInRbCZz6D8rCsTDc6jVT?=
 =?us-ascii?Q?inQ3J+v7aIrgJhjVTexF0bXw5HlyOtoKNNm+NQm5B/cHKYbQX0i1vQMaNuT7?=
 =?us-ascii?Q?XWItSQzr7nPTBGAlEzVrBmYYOx27r0HxvOg0R1rHOxoX03LbdhmQyKYAmDr2?=
 =?us-ascii?Q?kmYHBZVhToV9cPZO2NAmV0qfG9GxBHwPuVsYPa1SWb+Pt11n0q5qqpY6L2q4?=
 =?us-ascii?Q?iULzVC3qBKBZcZT5L614Hl9xNUeoufP4zkinAuw2TPg0uVVEaUvfoyAztTn4?=
 =?us-ascii?Q?9CVnBemPJenvC/4DKHmlPEhtZ685AXQO09jl8c53PsbBR0eUvlhdIXWkWF7i?=
 =?us-ascii?Q?uar30SQgLpGYVV1N6jyuyWcGJsDTfgC8LgdeBJ+5GA7YZAK1xeFHbGsa0orD?=
 =?us-ascii?Q?EImADOgmmugZ0l1EFU8dzp9uBzfrnriemPHcasrOP117QvLVipZcF83JW2/f?=
 =?us-ascii?Q?DhdjuW8VqGrx7RQJoRBsGAoNJw3WUJylb20nkPw/0W9jkI3dHbKAqrIGLUwd?=
 =?us-ascii?Q?MQwYHen2EMGFdtWodQaYyOwUDRxjVBO1DZ9cZdPcgpoc1qJG7WCGNsvYBJYD?=
 =?us-ascii?Q?tCDdbJfmVyDFYs37dpCgbiEAwullZcMM0UdX27saV8v9XXDv7rV5BVVx5808?=
 =?us-ascii?Q?FjZAFTl0yOsML2oV5TOsqyZlAMr62T1SyqTubPKR5Tq2GyEREYUMcgeJcdcs?=
 =?us-ascii?Q?bnT7AwsBJlJAhAWj7DxjcUYj2KeyLh0Ptz4A3gB6YyrUsEh5QT8SnJZIzOHL?=
 =?us-ascii?Q?c+Jz0SYHZYyqD6gVx0nXvknEc/ZEXUoKOVPpYEYm8ccIHcC2Qhk3E/YPK1ge?=
 =?us-ascii?Q?xi3ing/ILsjraCl8E0KuNxy69gs8B5XUrS6FzLNlPejETGMI7sAb5TTA04Bs?=
 =?us-ascii?Q?ABqYIwPkpbjhwhgFWoVm91cAjFBg6bxUZRo80vB3HmShE3G9iSEyWenEga9L?=
 =?us-ascii?Q?PCDuGwUpVoH7bIHQmZkEpxFNeTNydHJf7D9JvptDYNtC9wEcMalYmWljz8hF?=
 =?us-ascii?Q?4h1t7rksRIlhfQH4S56nV3drJZAjowg8NJq44nyIPE0Qzcz9fSypXyXNMGSZ?=
 =?us-ascii?Q?AgRd6APeC2k1CH5uQQvlsQbhskbwGpvWzUtVZyOfRpdiDwxTyhUC4SmhV9wA?=
 =?us-ascii?Q?z69CLbOU+dyU6EQAmfKYV6LZfVMPyApKo0m0KzAVSdMqU4O6nexJhdFoWl+c?=
 =?us-ascii?Q?4qSB0R+IeeYup9VYg7bz7Qii+Eo2jqXXz+m86yF7nHWONrGScZ/sYUQybrDE?=
 =?us-ascii?Q?w1Zu2I+mtD8mReBoQuydeZxq17tzOXs5vhVSzLD5JasB3os/jldaC2fCy4+/?=
 =?us-ascii?Q?hNi/xbsu/V75ryv1OJdvDCjQuNckEO4exoVqL31nMszudheOBg8/j6Q2/dvk?=
 =?us-ascii?Q?+A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	++uIkpiZM6zWppaODzDQcPqYvyD/lvzdSmoMujWeMByEQL5/9w+EnpN0JBBHtHjtcmyQ3CPuspUfsbtiqo8n6FZC4Hdte0DmX+0C0B37AUPDKAGNxSNQl8YjUF46KIfjt75McsGYyqt3mvWGd4WmY+12l2mVa8ZBGObCGXxJNECMbnFr2Gz0AM4frweBV93aKVuUTwp0DxBXGARO4sALYGomFf0Kf9ypxeWYrZhG7JAvCsc7Sd+dOHnrqudnL9vHYuFRmI8lc/4xO/8vcwonhWmVCWeCSNZ4IFg/ymjbgOg6MX3F8EbhALANyuhSDvJmecRAMguIqIVxomhzGKztdDLuuBXL5e9Gp6DLXoU7sOLWDEk+w7Igi8gW7nzny0fAEx6ybmsPhr/0YgPKDQDk87ZRjCba20+LalakpZ/waVZa00wcxl0UIT4qWtwTlNuTH8G2bst/vLFQFJ6CxRjmS21MaVTLNxLx0jbN7PotMF+HRgjLtNMtaq0ailz2gf+4WAN79Y9YKJxO5zSedoJfOmeWwyXS5JG3CxeJMwCUWf72ai7TTzMIn5FyiNL+mDgO3uvNPaL8/ldc3IDH8aN+UUXhnTXtJCLOq1cxJgh4r8c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64d514aa-f4af-4127-1fa1-08ddc849b740
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 11:28:29.0910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X20MCNFdMeulwLJDYrYSesJv7Zpja2n/oZIfCPwCrGXT7+LkEfdLu30gp1XK0oLgSGjLfzbjhzIp4X7kTpstu9ze2/Zuis5MME5dnyClvBs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7766
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-21_03,2025-07-21_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507210102
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIxMDEwMSBTYWx0ZWRfXxPJn4zdMqI0M
 2DRmliWiHkJT1+m2/QqKcHNEeL/BJLJRp8CvtyWLws/osaLjCQkpkwbEASXs+jdzHgwQ4H57YDu
 uKc+Slr7/qTnceUzhHAKUT0Wz6KT0AwTN83yEJpnOJzzexAaxzDFE2t2BwLJ6JU+ZfMRtz2H/g9
 KkdZuPNCn+mDZHZsUuxE1fwra2ymVgew8OrUcQ7jfzEQ4qgjEmHTMROz56DcAQcciqiTdpeDWDW
 Q/jQLmTeon+uk21BptiMvJVBA8sbx2zZNTH9qGLMQ1y5wFqxQ++XTAoxZGJ5uiQ66+vvpno1bbh
 +1PqT+rA+P0tqo83l+L0ROrJVzpI2SYH0pObKuLYiqSIOxxqT6fwp/T7xNIWcifIF3fOpYpgCPZ
 Ikg+JbGXHO3Mk1AOazDZWvjMG/okvtfL6wIeFUt5MrzCGo1Z7tvjNcaarCNaQCbBDcpvPtUm
X-Proofpoint-GUID: 0a4MicoNskJDrdN4mr_xB3iJxX5Rd461
X-Authority-Analysis: v=2.4 cv=IsYecK/g c=1 sm=1 tr=0 ts=687e2462 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8 a=07d9gI8wAAAA:8
 a=Z4Rwk6OoAAAA:8 a=Ikd4Dj_1AAAA:8 a=SRrdq9N9AAAA:8 a=20KFwNOVAAAA:8
 a=7CQSdrXTAAAA:8 a=1XWaLZrsAAAA:8 a=iox4zFpeAAAA:8 a=JfrnYn6hAAAA:8
 a=RJH2xcyeWh7t4usVQXwA:9 a=CjuIK1q_8ugA:10 a=e2CUPOnPG4QKp8I52DXD:22
 a=HkZW87K1Qel5hWWM3VKY:22 a=a-qgeE7W1pNrGK8U0ZQC:22 a=WzC6qhA0u3u7Ye7llzcV:22
 a=1CNFftbPRP8L7MoqJWF3:22 cc=ntf awl=host:12061
X-Proofpoint-ORIG-GUID: 0a4MicoNskJDrdN4mr_xB3iJxX5Rd461

Overall, while I HATE this interface (as y'know, everyone knows :P), since
it _already_ exists and fulfils a real need (and we _have_ to keep
supporting that need) I'm open to us solving the issue this way.

So this might be a way for us to achieve what Usama + others need without
having to splice in horridness.

This as a proof-of-concept is obviously not for 6.17 (and late in the day
anyway :P), so we have at least 6.18 cycle to discuss.

On Mon, Jul 21, 2025 at 11:09:42AM +0200, David Hildenbrand wrote:
> People want to make use of more THPs, for example, moving from
> THP=never to THP=madvise, or from THP=madvise to THP=never.

Nitty, but sort of vague as to what THP= means here, I'd just say 'from
never to madvise, or from madvise to never' - it's pretty clear what you
mean and keeps enough 'flexibility' of interpretation to cover off the
various ways you can do this in the sysfs interfaces.

Same comment for simlar below.

>
> While this is great news for every THP desperately waiting to get
> allocated out there, apparently there are some workloads that require a
> bit of care during that transition: once problems are detected, these
> workloads should be started with the old behavior, without making all
> other workloads on the system go back to the old behavior as well.

I'm confused about what 'old behavior' is here. Also it's not always
necessarily due to problems, there can be a desire to treat THPs as a
resource to be distributed as desired.

So I'd say something like '... transition: individual processes may need to
opt-out from this behaviour for various reasons, and this should be
permitted without needing to make all other workloads on the system
similarly opt-out'.

>
> In essence, the following scenarios are imaginable:
>
> (1) Switch from THP=none to THP=madvise or THP=always, but keep the old
>     behavior (no THP) for selected workloads.

I'd remove 'old behavior' here as it's confusing, and simply refer to THP
being disabled for selected  workloads.

>
> (2) Stay at THP=none, but have "madvise" or "always" behavior for
>     selected workloads.
>
> (3) Switch from THP=madvise to THP=always, but keep the old behavior
>     (THP only when advised) for selected workloads.
>
> (4) Stay at THP=madvise, but have "always" behavior for selected
>     workloads.
>
> In essence, (2) can be emulated through (1), by setting THP!=none while
> disabling THPs for all processes that don't want THPs. It requires
> configuring all workloads, but that is a user-space problem to sort out.

NIT: Delete 'In essence' here.

>
> (4) can be emulated through (3) in a similar way.
>
> Back when (1) was relevant in the past, as people started enabling THPs,
> we added PR_SET_THP_DISABLE, so relevant workloads that were not ready
> yet (i.e., used by Redis) were able to just disable THPs completely. Redis
> still implements the option to use this interface to disable THPs
> completely.
>
> With PR_SET_THP_DISABLE, we added a way to force-disable THPs for a
> workload -- a process, including fork+exec'ed process hierarchy.
> That essentially made us support (1): simply disable THPs for all workloads
> that are not ready for THPs yet, while still enabling THPs system-wide.
>
> The quest for handling (3) and (4) started, but current approaches
> (completely new prctl, options to set other policies per processm,
>  alternatives to prctl -- mctrl, cgroup handling) don't look particularly
> promising. Likely, the future will use bpf or something similar to
> implement better policies, in particular to also make better decisions
> about THP sizes to use, but this will certainly take a while as that work
> just started.

Ack.

>
> Long story short: a simple enable/disable is not really suitable for the
> future, so we're not willing to add completely new toggles.

Yes this is the crux of the problem.

>
> While we could emulate (3)+(4) through (1)+(2) by simply disabling THPs
> completely for these processes, this scares many THPs in our system
> because they could no longer get allocated where they used to be allocated
> for: regions flagged as VM_HUGEPAGE. Apparently, that imposes a
> problem for relevant workloads, because "not THPs" is certainly worse
> than "THPs only when advised".

I don't know what you mean by 'scares' many THPs? :P

>
> Could we simply relax PR_SET_THP_DISABLE, to "disable THPs unless not
> explicitly advised by the app through MAD_HUGEPAGE"? *maybe*, but this

MAD_HUGEPAGE -> MADV_HUGEPAGE

I'm confused by 'unless not explicitly advised' do you mean 'disable THPs
unless explicitly advised by the app through MADV_HUGEPAGE'?

> would change the documented semantics quite a bit, and the versatility
> to use it for debugging purposes, so I am not 100% sure that is what we
> want -- although it would certainly be much easier.
>
> So instead, as an easy way forward for (3) and (4), an option to
> make PR_SET_THP_DISABLE disable *less* THPs for a process.
>
> In essence, this patch:
>
> (A) Adds PR_THP_DISABLE_EXCEPT_ADVISED, to be used as a flag in arg3
>     of prctl(PR_SET_THP_DISABLE) when disabling THPs (arg2 != 0).

prctl(PR_SET_THP_DISABLE, 1, PR_THP_DISABLE_EXCEPT_ADVISED)?

>
>     For now, arg3 was not allowed to be set (-EINVAL). Now it holds
>     flags.

This sentence is redundant.

>
> (B) Makes prctl(PR_GET_THP_DISABLE) return 3 if
>     PR_THP_DISABLE_EXCEPT_ADVISED was set while disabling.
>
>     For now, it would return 1 if THPs were disabled completely. Now
>     it essentially returns the set flags as well.

For now as in 'previously'. I guess right now it's just used as a boolean,
so this seems fine.

>
> (C) Renames MMF_DISABLE_THP to MMF_DISABLE_THP_COMPLETELY, to express
>     the semantics clearly.
>
>     Fortunately, there are only two instances outside of prctl() code.
>
> (D) Adds MMF_DISABLE_THP_EXCEPT_ADVISED to express "no THP except for VMAs
>     with VM_HUGEPAGE" -- essentially "thp=madvise" behavior
>
>     Fortunately, we only have to extend vma_thp_disabled().
>
> (E) Indicates "THP_enabled: 0" in /proc/pid/status only if THPs are not
>     disabled completely

You mean 'are disabled completely' but this has been covered already :P

>
>     Only indicating that THPs are disabled when they are really disabled
>     completely, not only partially.


So the really interesting part in the above is the small delta this change
represents... which makes it a lot more compelling as a solution.

>
> The documented semantics in the man page for PR_SET_THP_DISABLE
> "is inherited by a child created via fork(2) and is preserved across
> execve(2)" is maintained. This behavior, for example, allows for
> disabling THPs for a workload through the launching process (e.g.,
> systemd where we fork() a helper process to then exec()).

Yeah, this is something I REALLY don't want us to perpetuate, as it's
adding a now policy method by the 'back door'.

I had actually come to the conclusion that we absolutely should NOT
implement anything like this, as discussed in the THP cabal meeting.

HOWEVER, since this mechanism ALREADY EXISTS for this case, I am much more
ok with this.

We already perpetuate state for this across fork/exec.

>
> There is currently not way to prevent that a process will not issue
> PR_SET_THP_DISABLE itself to re-enable THP. We could add a "seal" option
> to PR_SET_THP_DISABLE through another flag if ever required. The known
> users (such as redis) really use PR_SET_THP_DISABLE to disable THPs, so
> that is not added for now.

Yeah not a fan of the seal idea, that will add a bunch of complexity and
state that I would rather not have.

I'd far prefer just disallowing re-enabling THP. We could allow
re-disabling with different flags though.

Be good to get some examples of the old + new prctl() invocations in the
commit message too.

>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
> Cc: Nico Pache <npache@redhat.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Dev Jain <dev.jain@arm.com>
> Cc: Barry Song <baohua@kernel.org>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Usama Arif <usamaarif642@gmail.com>
> Cc: SeongJae Park <sj@kernel.org>
> Cc: Jann Horn <jannh@google.com>
> Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
> Cc: Yafang Shao <laoar.shao@gmail.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>
>
> ---
>
> At first, I thought of "why not simply relax PR_SET_THP_DISABLE", but I
> think there might be real use cases where we want to disable any THPs --
> in particular also around debugging THP-related problems, and
> "THP=never" not meaning ... "never" anymore. PR_SET_THP_DISABLE will

Well, not quite anymore :) it's been this way for a while right? Even since
MADV_COLLAPSE was introduced.

> also block MADV_COLLAPSE, which can be very helpful. Of course, I thought

Yes.

I mean I hate, hate, HATE this interface. But it exists and we have to
support it anyway.

> of having a system-wide config to change PR_SET_THP_DISABLE behavior, but
> I just don't like the semantics.

What do you mean?

>
> "prctl: allow overriding system THP policy to always"[1] proposed
> "overriding policies to always", which is just the wrong way around: we
> should not add mechanisms to "enable more" when we already have an
> interface/mechanism to "disable" them (PR_SET_THP_DISABLE). It all gets
> weird otherwise.

Yes. A 'disable but' is more logical.

>
> "[PATCH 0/6] prctl: introduce PR_SET/GET_THP_POLICY"[2] proposed
> setting the default of the VM_HUGEPAGE, which is similarly the wrong way
> around I think now.

Yes.

>
> The proposals by Lorenzo to extend process_madvise()[3] and mctrl()[4]
> similarly were around the "default for VM_HUGEPAGE" idea, but after the
> discussion, I think we should better leave VM_HUGEPAGE untouched.

Well, to be clear, these were more 'if we HAVE to do this, what is the
least awful way of doing this?' rather than proposals per se :P and mctrl()
was really taking existing discussed ideas and -simply seeing how it looked
in code- though in the end we decided better to spell out in words how it
would look.

At least now I'm not in favour of us implementing policy this way (but
again, am open to us extending an _existing_ abomination :)

>
> Happy to hear naming suggestions for "PR_THP_DISABLE_EXCEPT_ADVISED" where
> we essentially want to say "leave advised regions alone" -- "keep THP
> enabled for advised regions",

Seems OK to me. I guess the one point of confusion could be people being
confused between the THP toggle 'madvise' vs. actually having MADV_HUGEPAGE
set, but that's moot, because 'madvise' mode only enables THP if the region
has had MADV_HUGEPAGE set.

>
> The only thing I really dislike about this is using another MMF_* flag,
> but well, no way around it -- and seems like we could easily support
> more than 32 if we want to, or storing this thp information elsewhere.

Yes my exact thoughts. But I will be adding a series to change this for VMA
flags soon enough, and can potentially do mm flags at the same time...

So this shouldn't in the end be as much of a problem.

Maybe it's worth holding off on this until I've done that? But at any rate
I intend to do those changes next cycle, and this will be a next cycle
thing at the earliest anyway.

>
> I think this here (modifying an existing toggle) is the only prctl()
> extension that we might be willing to accept. In general, I agree like
> most others, that prctl() is a very bad interface for that -- but
> PR_SET_THP_DISABLE is already there and is getting used.

Yes.

>
> Long-term, I think the answer will be something based on bpf[5]. Maybe
> in that context, I there could still be value in easily disabling THPs for
> selected workloads (esp. debugging purposes).
>
> Jann raised valid concerns[6] about new flags that are persistent across
> exec[6]. As this here is a relaxation to existing PR_SET_THP_DISABLE I
> consider it having a similar security risk as our existing
> PR_SET_THP_DISABLE, but devil is in the detail.

Yes...

>
> This is *completely* untested and might be utterly broken. It merely
> serves as a PoC of what I think could be done. If this ever goes upstream,
> we need some kselftests for it, and extensive tests.

Well :) I mean we should definitely try this out in anger and it _MUST_
have self tests and put under some pressure.

Usama, can you attack this and see?

>
> [1] https://lore.kernel.org/r/20250507141132.2773275-1-usamaarif642@gmail.com
> [2] https://lkml.kernel.org/r/20250515133519.2779639-2-usamaarif642@gmail.com
> [3] https://lore.kernel.org/r/cover.1747686021.git.lorenzo.stoakes@oracle.com
> [4] https://lkml.kernel.org/r/85778a76-7dc8-4ea8-8827-acb45f74ee05@lucifer.local
> [5] https://lkml.kernel.org/r/20250608073516.22415-1-laoar.shao@gmail.com
> [6] https://lore.kernel.org/r/CAG48ez3-7EnBVEjpdoW7z5K0hX41nLQN5Wb65Vg-1p8DdXRnjg@mail.gmail.com
>
> ---
>  Documentation/filesystems/proc.rst |  5 +--
>  fs/proc/array.c                    |  2 +-
>  include/linux/huge_mm.h            | 20 ++++++++---
>  include/linux/mm_types.h           | 13 +++----
>  include/uapi/linux/prctl.h         |  7 ++++
>  kernel/sys.c                       | 58 +++++++++++++++++++++++-------
>  mm/khugepaged.c                    |  2 +-
>  7 files changed, 78 insertions(+), 29 deletions(-)
>
> diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
> index 2971551b72353..915a3e44bc120 100644
> --- a/Documentation/filesystems/proc.rst
> +++ b/Documentation/filesystems/proc.rst
> @@ -291,8 +291,9 @@ It's slow but very precise.
>   HugetlbPages                size of hugetlb memory portions
>   CoreDumping                 process's memory is currently being dumped
>                               (killing the process may lead to a corrupted core)
> - THP_enabled		     process is allowed to use THP (returns 0 when
> -			     PR_SET_THP_DISABLE is set on the process
> + THP_enabled                 process is allowed to use THP (returns 0 when
> +                             PR_SET_THP_DISABLE is set on the process to disable
> +                             THP completely, not just partially)

Hmm but this means we have no way of knowing if it's set for partial

>   Threads                     number of threads
>   SigQ                        number of signals queued/max. number for queue
>   SigPnd                      bitmap of pending signals for the thread
> diff --git a/fs/proc/array.c b/fs/proc/array.c
> index d6a0369caa931..c4f91a784104f 100644
> --- a/fs/proc/array.c
> +++ b/fs/proc/array.c
> @@ -422,7 +422,7 @@ static inline void task_thp_status(struct seq_file *m, struct mm_struct *mm)
>  	bool thp_enabled = IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE);
>
>  	if (thp_enabled)
> -		thp_enabled = !test_bit(MMF_DISABLE_THP, &mm->flags);
> +		thp_enabled = !test_bit(MMF_DISABLE_THP_COMPLETELY, &mm->flags);
>  	seq_printf(m, "THP_enabled:\t%d\n", thp_enabled);
>  }
>
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index e0a27f80f390d..c4127104d9bc3 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -323,16 +323,26 @@ struct thpsize {
>  	(transparent_hugepage_flags &					\
>  	 (1<<TRANSPARENT_HUGEPAGE_USE_ZERO_PAGE_FLAG))
>
> +/*
> + * Check whether THPs are explicitly disabled through madvise or prctl, or some
> + * architectures may disable THP for some mappings, for example, s390 kvm.
> + */
>  static inline bool vma_thp_disabled(struct vm_area_struct *vma,
>  		vm_flags_t vm_flags)

This _should_ work as we set/clear VM_HUGEPAGE, VM_NOHUGEPAGE in madvise()
unconditionally without bothering to check available THP orders first so no
chicken-and-egg here.

>  {
> +	/* Are THPs disabled for this VMA? */
> +	if (vm_flags & VM_NOHUGEPAGE)
> +		return true;
> +	/* Are THPs disabled for all VMAs in the whole process? */
> +	if (test_bit(MMF_DISABLE_THP_COMPLETELY, &vma->vm_mm->flags))
> +		return true;
>  	/*
> -	 * Explicitly disabled through madvise or prctl, or some
> -	 * architectures may disable THP for some mappings, for
> -	 * example, s390 kvm.
> +	 * Are THPs disabled only for VMAs where we didn't get an explicit
> +	 * advise to use them?

Probably fine to drop the rather pernickety reference to s390 kvm here, I
mean we don't need to spell out massively specific details in a general
handler.

>  	 */
> -	return (vm_flags & VM_NOHUGEPAGE) ||
> -	       test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags);
> +	if (vm_flags & VM_HUGEPAGE)
> +		return false;
> +	return test_bit(MMF_DISABLE_THP_EXCEPT_ADVISED, &vma->vm_mm->flags);
>  }
>
>  static inline bool thp_disabled_by_hw(void)
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 1ec273b066915..a999f2d352648 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -1743,19 +1743,16 @@ enum {
>  #define MMF_VM_MERGEABLE	16	/* KSM may merge identical pages */
>  #define MMF_VM_HUGEPAGE		17	/* set when mm is available for khugepaged */
>
> -/*
> - * This one-shot flag is dropped due to necessity of changing exe once again
> - * on NFS restore
> - */
> -//#define MMF_EXE_FILE_CHANGED	18	/* see prctl_set_mm_exe_file() */
> +#define MMF_HUGE_ZERO_PAGE	18      /* mm has ever used the global huge zero page */
>
>  #define MMF_HAS_UPROBES		19	/* has uprobes */
>  #define MMF_RECALC_UPROBES	20	/* MMF_HAS_UPROBES can be wrong */
>  #define MMF_OOM_SKIP		21	/* mm is of no interest for the OOM killer */
>  #define MMF_UNSTABLE		22	/* mm is unstable for copy_from_user */
> -#define MMF_HUGE_ZERO_PAGE	23      /* mm has ever used the global huge zero page */
> -#define MMF_DISABLE_THP		24	/* disable THP for all VMAs */
> -#define MMF_DISABLE_THP_MASK	(1 << MMF_DISABLE_THP)
> +#define MMF_DISABLE_THP_EXCEPT_ADVISED	23	/* no THP except for VMAs with VM_HUGEPAGE */
> +#define MMF_DISABLE_THP_COMPLETELY	24	/* no THP for all VMAs */
> +#define MMF_DISABLE_THP_MASK	((1 << MMF_DISABLE_THP_COMPLETELY) |\
> +				 (1 << MMF_DISABLE_THP_EXCEPT_ADVISED))

It feels a bit sigh to have to use up low-supply mm flags for this. But
again, I should be attacking this shortage soon enough.

Are we not going ahead with Barry's series that was going to use one of
these in the end?

>  #define MMF_OOM_REAP_QUEUED	25	/* mm was queued for oom_reaper */
>  #define MMF_MULTIPROCESS	26	/* mm is shared between processes */
>  /*
> diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
> index 43dec6eed559a..1949bb9270d48 100644
> --- a/include/uapi/linux/prctl.h
> +++ b/include/uapi/linux/prctl.h
> @@ -177,7 +177,14 @@ struct prctl_mm_map {
>
>  #define PR_GET_TID_ADDRESS	40
>
> +/*
> + * Flags for PR_SET_THP_DISABLE are only applicable when disabling. Bit 0
> + * is reserved, so PR_GET_THP_DISABLE can return 1 when no other flags were
> + * specified for PR_SET_THP_DISABLE.
> + */

Probably worth specifying that you're just returning the flags here.

>  #define PR_SET_THP_DISABLE	41
> +/* Don't disable THPs when explicitly advised (MADV_HUGEPAGE / VM_HUGEPAGE). */
> +# define PR_THP_DISABLE_EXCEPT_ADVISED	(1 << 1)
>  #define PR_GET_THP_DISABLE	42
>
>  /*
> diff --git a/kernel/sys.c b/kernel/sys.c
> index b153fb345ada2..2a34b2f708900 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -2423,6 +2423,50 @@ static int prctl_get_auxv(void __user *addr, unsigned long len)
>  	return sizeof(mm->saved_auxv);
>  }
>
> +static int prctl_get_thp_disable(unsigned long arg2, unsigned long arg3,
> +				 unsigned long arg4, unsigned long arg5)
> +{
> +	unsigned long *mm_flags = &current->mm->flags;
> +
> +	if (arg2 || arg3 || arg4 || arg5)
> +		return -EINVAL;
> +
> +	if (test_bit(MMF_DISABLE_THP_COMPLETELY, mm_flags))
> +		return 1;
> +	else if (test_bit(MMF_DISABLE_THP_EXCEPT_ADVISED, mm_flags))
> +		return 1 | PR_THP_DISABLE_EXCEPT_ADVISED;
> +	return 0;
> +}
> +
> +static int prctl_set_thp_disable(unsigned long thp_disable, unsigned long flags,
> +				 unsigned long arg4, unsigned long arg5)
> +{
> +	unsigned long *mm_flags = &current->mm->flags;
> +
> +	if (arg4 || arg5)
> +		return -EINVAL;
> +
> +	/* Flags are only allowed when disabling. */
> +	if (!thp_disable || (flags & ~PR_THP_DISABLE_EXCEPT_ADVISED))
> +		return -EINVAL;
> +	if (mmap_write_lock_killable(current->mm))
> +		return -EINTR;
> +	if (thp_disable) {
> +		if (flags & PR_THP_DISABLE_EXCEPT_ADVISED) {
> +			clear_bit(MMF_DISABLE_THP_COMPLETELY, mm_flags);
> +			set_bit(MMF_DISABLE_THP_EXCEPT_ADVISED, mm_flags);
> +		} else {
> +			set_bit(MMF_DISABLE_THP_COMPLETELY, mm_flags);
> +			clear_bit(MMF_DISABLE_THP_EXCEPT_ADVISED, mm_flags);
> +		}
> +	} else {
> +		clear_bit(MMF_DISABLE_THP_COMPLETELY, mm_flags);
> +		clear_bit(MMF_DISABLE_THP_EXCEPT_ADVISED, mm_flags);
> +	}
> +	mmap_write_unlock(current->mm);
> +	return 0;
> +}
> +
>  SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
>  		unsigned long, arg4, unsigned long, arg5)
>  {
> @@ -2596,20 +2640,10 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
>  			return -EINVAL;
>  		return task_no_new_privs(current) ? 1 : 0;
>  	case PR_GET_THP_DISABLE:
> -		if (arg2 || arg3 || arg4 || arg5)
> -			return -EINVAL;
> -		error = !!test_bit(MMF_DISABLE_THP, &me->mm->flags);
> +		error = prctl_get_thp_disable(arg2, arg3, arg4, arg5);
>  		break;
>  	case PR_SET_THP_DISABLE:
> -		if (arg3 || arg4 || arg5)
> -			return -EINVAL;
> -		if (mmap_write_lock_killable(me->mm))
> -			return -EINTR;
> -		if (arg2)
> -			set_bit(MMF_DISABLE_THP, &me->mm->flags);
> -		else
> -			clear_bit(MMF_DISABLE_THP, &me->mm->flags);
> -		mmap_write_unlock(me->mm);

I HATE that these were implemented here before.

> +		error = prctl_set_thp_disable(arg2, arg3, arg4, arg5);
>  		break;
>  	case PR_MPX_ENABLE_MANAGEMENT:
>  	case PR_MPX_DISABLE_MANAGEMENT:
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 8a5873d0a23a7..a685077644b4e 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -427,7 +427,7 @@ static inline int collapse_test_exit(struct mm_struct *mm)
>  static inline int collapse_test_exit_or_disable(struct mm_struct *mm)
>  {
>  	return collapse_test_exit(mm) ||
> -	       test_bit(MMF_DISABLE_THP, &mm->flags);
> +	       test_bit(MMF_DISABLE_THP_COMPLETELY, &mm->flags);
>  }
>
>  static bool hugepage_enabled(void)
>
> base-commit: 760b462b3921c5dc8bfa151d2d27a944e4e96081
> --
> 2.50.1
>

