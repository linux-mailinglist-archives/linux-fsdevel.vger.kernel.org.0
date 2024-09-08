Return-Path: <linux-fsdevel+bounces-28913-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A72970925
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Sep 2024 20:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C20E2824DD
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Sep 2024 18:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7FF11779BD;
	Sun,  8 Sep 2024 18:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kcGPyvLf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="aUqbEwcG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731421531C8;
	Sun,  8 Sep 2024 18:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725818439; cv=fail; b=kYlYnWdiMuX9jSKiD+iXznsPppnnHPIxxe8p8oh+KUSSkTR6hs8HJzdt6TcopVsqCgbKESQNWyh/QwGou8eaxqhIzeEngTTed+D5rT3Fuot3VkkhuoJ5Qziw6YP7YUw5IetnvxgGrVZfYxUykJziLZesG7XCDSL6am+P18t3LEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725818439; c=relaxed/simple;
	bh=efIXWCSCVONUEPmqops9VTsHt9CSfyqNzYei7acVYzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nihyhHe7btXz7Oc+R+YMlYmeuq6ghSKsOFDx573KOaN/9HDpSBDT9XPrtp0B2OfdaT5NTsR8r3nqXJW4UMjD5Jx0f0FxAG2r+HA8SzxP8z4v5/EvbvRBRroSfhE/QoOe/MIQcljUcGYfFDQCvl1A6JXO5zeMnhjUuKIMjcZoBUY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kcGPyvLf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=aUqbEwcG; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 488Ht2si003254;
	Sun, 8 Sep 2024 18:00:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=Uza7ZMmr2ME3w4b
	FGPh7fR8VK+S2JRaMbD0XWfch2M8=; b=kcGPyvLfyO/JdTGZTV3qQwTXp07y1Wr
	oz3f9aRjCzZguavzaNdU1Ymsc/QAKfc6Kb5Iyu4Tigxwg2FnjlYxgYH7jI9Dd5Ra
	lm88x/DQ5veQkThnmRvqMRE0wS3w8XBaCDkYzEB5bsFljcbtlM52k5QPEuodevN4
	kibrODCTyLq2CwCSfFVJacShb4aJ57jEzemOghLJJVPfcV181zs377+7B9cayclc
	Hy8TNXLa/G2c4CVHL/x0JdiAoAu6LFhztMab6CV6LpSPIQCLbZJG5pnYNYNnGJas
	/CXQEbqp1opzCRETH3Ntrw9GMy9fzIybN1ZeNXmKsWk0zHrZvhwSmQA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41gfct9eaw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 08 Sep 2024 18:00:21 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 488Ce9Y9034168;
	Sun, 8 Sep 2024 18:00:19 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41gd96xjj2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 08 Sep 2024 18:00:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WtntXdD0vXCihA9dNnEC74wuK6+7i0osE8t5J2CUB7xKRkns1Oxy1YxQhAwnNI6pF2J6lLqLyby1e2iKyYM7INuMvA8c+ceuXnw6H7ymw0TKtlI/pVkinKbdTYLX9Hd/sDDM/7ZydqFq1YRlEw48WTpIRlTsi16NpjYuiSsfzQsm3aOTfmcl7Hw7uh7jWI/t84ucFvaMzD7Hjd3aEK01lsxkyg3H//1HBLBD7f4MT5ydfSpLbWSPzueeG9u1xMWxNuJrTVOI//kHqEgWYug6DbBveakeUeWckqbt2jLl9A494eNjbxJgWT0VCYQOKYN774oW0Cb5vvbDzcPQsJcOyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uza7ZMmr2ME3w4bFGPh7fR8VK+S2JRaMbD0XWfch2M8=;
 b=yLUuBW3WdBvsJ+Neg7J2iZy4yzcWpT14ydGxwgx5M6FtA8w3LJtXJyqowP5XMXKe0PLsf2fnj9IOhPTrAHK8gEU7zaRdUiO72myQX8Kw1L/G9Ge6zIGdQBVUlkMypJXGAAGTmninddkKCDvlnFmicxe2ODAZ11MpMQc1cgh5Egwa/pdpr8hJNaHZXl06i4StUIikuUI58eUdp/pjnU4UXSgMzELpPwbmPJvkZ7r+gQAtcDnZdgpbcPAlrNK/yVuH+SvdBFTU74yanmP1AFQvdOeougp9rk6hTIpSbcykbmQ3SELC3TjDXn06qtNKv46ODUw+uvfpD/6WK/ITUnsshw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uza7ZMmr2ME3w4bFGPh7fR8VK+S2JRaMbD0XWfch2M8=;
 b=aUqbEwcGqVfhPjY6oGV+v3HNHQlv/TsqNCCXuE7fuF101W5zqU0yQYGyFdeDAnlj5Wfe9FhoxkU17H0krN7p1nNpde2ZOOCSucN1gvCv42ln72Jxj2eiOd3KckymwjucUAvK7FVGEnEeEqQuDZj6G3dPwvRiNl1ow3fX1i2sYVM=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM4PR10MB7402.namprd10.prod.outlook.com (2603:10b6:8:182::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.10; Sun, 8 Sep
 2024 18:00:15 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7939.022; Sun, 8 Sep 2024
 18:00:15 +0000
Date: Sun, 8 Sep 2024 14:00:11 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Neil Brown <neilb@suse.de>, Olga Kornievskaia <okorniev@redhat.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Tom Haynes <loghyr@gmail.com>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 01/11] nfsd: fix initial getattr on write delegation
Message-ID: <Zt3mK3fn0gWEsD9d@tissot.1015granger.net>
References: <20240905-delstid-v4-0-d3e5fd34d107@kernel.org>
 <20240905-delstid-v4-1-d3e5fd34d107@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905-delstid-v4-1-d3e5fd34d107@kernel.org>
X-ClientProxiedBy: CH0PR04CA0047.namprd04.prod.outlook.com
 (2603:10b6:610:77::22) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DM4PR10MB7402:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c06b25f-ab10-4c3e-d4b6-08dcd030179f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UXltFExaWBh0o1NH9sXYniAEtpJPs3dyQZmyY6H8wAvhXQufnEH5LuJMitay?=
 =?us-ascii?Q?vuWpaGVbDGehQXTmywRWP8DsYmZdDfjmOuzhjHI8xqb1f8c88GQofSqvx9C/?=
 =?us-ascii?Q?5IwKpN3ybGF3zUam8uvT9xUu5xj7tlXne7p2aB2JIMaJh/QtPiqOCAIcdY/t?=
 =?us-ascii?Q?idQKFQhRHvytrhUyM2TFUjQqw8tmsDKqk6YTUGBBTwf9finnrEwXo5cDLeA8?=
 =?us-ascii?Q?OW+YHiKfv5m2PCHLWKgZw+HpNx1lNY86wEwLKXDwpRQ08DJvRtaDwj9cse2B?=
 =?us-ascii?Q?2V9irZqsKU8eXRQ6PNVOkTcqU0g2k3EpVGGYcv3h5F3U+zBLgbh4rn3KHmRo?=
 =?us-ascii?Q?sBPKRcelhNnMSNEG8Qo2IQQhYpFfDr+vydfIb8QOer9BEkeunT9yMHKTBPL4?=
 =?us-ascii?Q?rGfjsjklxiBnUmq2sJhojlmyBi81I3chCsdC2Ol0LTzreUX/hUOyNUGONnp4?=
 =?us-ascii?Q?ruymh48tePcPAM2cH3/gjjqClrZj2EOb48GlhWgg80Nj6TaDE3QinxVlQCq/?=
 =?us-ascii?Q?cagxPM/j1iICcbYz6O+ldsaggPoBqgL4B9a1OGH+0FAKIn71EsqJ/b1TO1Sf?=
 =?us-ascii?Q?Hfz+1KU3oEuUZZlUN8VOq2LMgZgV2Yv8Jy9wWTJQXTZclW3HHZq1d5TycTBa?=
 =?us-ascii?Q?1KdJDjuZuBHhtGCg6Ps3qVUIhbv+fDvZO4iQ0+UlOofVeRhhWae8TWP31AE2?=
 =?us-ascii?Q?3Ko7VmKhCxQY1kk9uAKwtj7SpjX9fPN/FX8KVPdacX8cJQYwzoOui0V86NUs?=
 =?us-ascii?Q?9WNN5E3OEoBCZ9HfhYRjSUPPk3NJV0IRvqFHtfy6gyWLe0JVbz5bniv17omb?=
 =?us-ascii?Q?Of15LCc7wxy2KDhYK8nNePV8GZSo2g8IuLSm0pIPW/6KxrIeZCLm/EPzBTiS?=
 =?us-ascii?Q?uS7uuJgO6vVPm7qzMPH7wGpPko2nraoZ4phxsXb0ERj52+2IV/AB/6nwDzOB?=
 =?us-ascii?Q?tEHf+UNks9gxg0keoP2Xk9VDA43WJUpVzZ1wY3IyyAyxM0QWoivj9Dy5y4bX?=
 =?us-ascii?Q?gSWIP1r9HXihleYOQ4XiV925nQ2RiU7KlAcQH5i5V2oxuHumDpsbYWqaVBAx?=
 =?us-ascii?Q?XnYVr4s3YgQH8YlGTLj076e7fIENZ0q/aL7CWZ4mwnqlCS24y9bj3LVx9Aks?=
 =?us-ascii?Q?RubRdfDLAq4S1iaEzSffWO9GGmnva5mWsIoUF/cKHPMkQyvyyDSxw8iC0pYO?=
 =?us-ascii?Q?MI7ulvLQCj/Y5LCoja4O6mDL0Ph3Dty7VZivFabmxEhg575b7AXzvwsVvBpK?=
 =?us-ascii?Q?mflc2pnBw4NGjW/AVAobu9WCLAD/zXVHGKMT0LiWJ6VG9JpqvdZhdREfX6Ie?=
 =?us-ascii?Q?q3ARhlDnsInYBb6++gr+bwm2qIq02fa9P7yKk6IAlytGPg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?64I0onnxetE/tTNF/7MZq1bD09YkLYlOMGJZunqSuaSARO4MBW7PPHRB6vfx?=
 =?us-ascii?Q?/nDv806jDKQJR/9P97l/TiM1g28CkYdb1G2rQcWWahYEb/Yv0caUkgusRH7S?=
 =?us-ascii?Q?1b6GfBCzN0b2xSgRVYtPsuBfmcfJDHtid9rUney8VRr/JQoFm4d8a/dRMRbe?=
 =?us-ascii?Q?ORBcDrpxJgu6GpGBeGfYVVMcfRArDjAlyf7sjB+/Mtgra2hxQvtE3vfRzfet?=
 =?us-ascii?Q?DXlIFe5XLnptfamBeRGM0k4e/+zcTLc40kh7HWO5nUtA0DtU9s2mWvyt2UtV?=
 =?us-ascii?Q?FHrmPm+oLnjyItw+QsxnRNhrwWAAnPdEUH9zWi7aRcitrN0Tp2jTLKyQlros?=
 =?us-ascii?Q?0JcGKaN3n06r6YtJBlRo0Jz5DfIB1mttBrHJ0dipFdgDwrHlff9e8gYz9/1x?=
 =?us-ascii?Q?QPan+HTu/pzUkz//TQg3S1kwBR3+6lAwiyLS+0tlubLRQ/0e0FSWty69JlH4?=
 =?us-ascii?Q?3oP0kYMRDRFtVeGmQCMxHy8VnM2d/WsaYygSQ+xfMJCzT8ffSNeRWUkIsq6N?=
 =?us-ascii?Q?MSH6awvG4ffxXdoVG7QHrOVomFFaPebwta9VOD5EsMHCxMgcP9Zarfo5lJ8e?=
 =?us-ascii?Q?bum9kqsBYkbZwV1rHLOaCyHxFb7o8rK1/O9lXA60N9n8LJZ2NfgGxfQeVR4R?=
 =?us-ascii?Q?3qRZmzt9sgxL3Lk0JK7ZyiR3MoSGivgGFZRSu0A3SPr59P7zeBlCg6zeuaTt?=
 =?us-ascii?Q?S68qAmyNmaN9mLl7NV7pTT1eSeFLkZMzwFCEPM3f4nymprggyO7lKYQ/7hmZ?=
 =?us-ascii?Q?7sndRWTc/RktD1z31NamaLQgiJHsaNDMa1KqnWB5EV9iRY9+8g9MIFQlFpgT?=
 =?us-ascii?Q?+A8DU1lwKSLef4tch/aDYLVxwgwgPSWxrMRuPHQNOUgxK5UBtopG0eIRNMSP?=
 =?us-ascii?Q?dY/FMPTm7iScRbhzRbkTCAbvj4jf/lbW13IUVtHXLWH5ErSBIqTA1z8wp7cv?=
 =?us-ascii?Q?GMF/NsHBKNuEgoWRlhjlLfAOkFlczf5Zc3QWcU6pk9sZHs2zJLbRAjHNckxv?=
 =?us-ascii?Q?1T7lQCA4kAVcZVGtpgJvN6MSlRL70rDpBJctzdAkbsQG3ThH9Ipt1nUlN045?=
 =?us-ascii?Q?lsvVr6j5me+OQODL0y6hBk7GmYcUHf68zNkrzYgXweBbsHwlVGwei3wDlfQl?=
 =?us-ascii?Q?g8YfB80xgF00DWl00y/u/3tyoEGkk4hr77spdmYfQq9pRNgFbnHtcmbRbl2s?=
 =?us-ascii?Q?B9xWyWDZfYMWsQhEilemfHepr8qEWqfOKS8DC0ppG8gIq8iNDgaO8nvsFkEd?=
 =?us-ascii?Q?6JGqrQ2Fm85enJzy3DsY3/+LhOJs9ewrRypg5LDe4Qz8qKW5RGXZ2a7i+JTI?=
 =?us-ascii?Q?IUYZD0mF1Bp3GYazVZD9y0e9qMpw07Do7HbnEB0n7+reBRZyp7115mYrfO2M?=
 =?us-ascii?Q?m8vMLXP7b52ym9qEvPNc8rZwhX66QCTEmy2lsE+/6vguRB2l1svi219p2KBk?=
 =?us-ascii?Q?ub0ZkWvFcK2Z5Ir77jZgH22wxw4LHie50q8fGzsqaf96f2tviRhrL6dz/FvV?=
 =?us-ascii?Q?LufkIEztSjjRswMi31GbjzRYObjK6D4JNR0qCqcBUci43SNE8rGzQC9dUjnJ?=
 =?us-ascii?Q?tCGu18mLcorYWWnIca7bKvLy/fjQvdajsbJ3gWNp?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	n5RGOcMwngU960j/WUqyVSH7ctkGiz0+9ME99RAprgpHJMe1Egjq3RnOhWDmP2dv5OgErmJgB1ru/IwHe5GETuNdXH3Dku5q8uaFTH2pHyMJR7QnNMTkdofwM0H+FJOTTrS430kRUHrLdUSomO9ff3BaxqcWCG6wCq4JH8bf6epD7Jo41cBNpFXUcvxyyTbrWdRrByi84b55NDdE6lb/67h1EPj+JmU9GU/Lmhj8Zjw3C3HWOtIaPPFUknLIx/e7Nqi99eEsBlXnPSb/h5H35DMBSlArgU20jeHI/FRITp43rjM4esFB7W7KZepf4/dnGrp/bT6IG9NrCMUT2u+cSciJ6g3RMhtHPDTND+DeyhemrdKs6pjLHr4GB2xK8eosCYpkYn7sw/rRirbhgk6ccG5k3TETSwJnLv7o68ceq+JBTCo6AuBRDJT1k2mZ4CmG7qJVDNQHw89yQ4cfccRoN6nB4m4QWWASAg2mtIWMqMOk+eUDp/oXd+n36cLVhSc8VM9SqRxOvAzwCgSEmCVWLmgtBWSy5uPnSegKdXZrIE6ltgQL6BfQVN8har3VHP2X9k9xDnYC323L9rGIqH8OEr2uqK8jF9OLguxBRPklQIM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c06b25f-ab10-4c3e-d4b6-08dcd030179f
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2024 18:00:15.4590
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QgduLWwXtzoOO1EPPHMvTvZ2LRw7yPgDO9eZrW6J9r4oePyouNla4z1DCbcKYQX2bS+EVEZtLGzn9roxteuPXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7402
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-08_07,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 phishscore=0 mlxscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409080154
X-Proofpoint-GUID: u9oziryplqmoGm1q9tqaJkH6c9GFCfxv
X-Proofpoint-ORIG-GUID: u9oziryplqmoGm1q9tqaJkH6c9GFCfxv

On Thu, Sep 05, 2024 at 08:41:45AM -0400, Jeff Layton wrote:
> At this point in compound processing, currentfh refers to the parent of
> the file, not the file itself. Get the correct dentry from the delegation
> stateid instead.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/nfsd/nfs4state.c | 31 +++++++++++++++++++++++--------
>  1 file changed, 23 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index df69dc6af467..db90677fc016 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -5914,6 +5914,26 @@ static void nfsd4_open_deleg_none_ext(struct nfsd4_open *open, int status)
>  	}
>  }
>  
> +static bool
> +nfs4_delegation_stat(struct nfs4_delegation *dp, struct svc_fh *currentfh,
> +		     struct kstat *stat)
> +{
> +	struct nfsd_file *nf = find_rw_file(dp->dl_stid.sc_file);

The xfstests workflow on NFSv4.2 exhausts the capacity of both the
main and scratch devices (backed by xfs) about half-way through
each test run.

Deleting all visible files on both devices frees only a little bit
of space. The test exports can be unshared but not unmounted
(EBUSY). Looks like unlinked but still open files, maybe.

Bisected to this here patch.

Should there be a matching nfsd_file_put() book-end for the new
find_rw_file() call site?


> +	struct path path;
> +
> +	if (!nf)
> +		return false;
> +
> +	path.mnt = currentfh->fh_export->ex_path.mnt;
> +	path.dentry = file_dentry(nf->nf_file);
> +
> +	if (vfs_getattr(&path, stat,
> +			(STATX_INO | STATX_SIZE | STATX_CTIME | STATX_CHANGE_COOKIE),
> +			AT_STATX_SYNC_AS_STAT))
> +		return false;
> +	return true;
> +}
> +
>  /*
>   * The Linux NFS server does not offer write delegations to NFSv4.0
>   * clients in order to avoid conflicts between write delegations and
> @@ -5949,7 +5969,6 @@ nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
>  	int cb_up;
>  	int status = 0;
>  	struct kstat stat;
> -	struct path path;
>  
>  	cb_up = nfsd4_cb_channel_good(oo->oo_owner.so_client);
>  	open->op_recall = false;
> @@ -5985,20 +6004,16 @@ nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
>  	memcpy(&open->op_delegate_stateid, &dp->dl_stid.sc_stateid, sizeof(dp->dl_stid.sc_stateid));
>  
>  	if (open->op_share_access & NFS4_SHARE_ACCESS_WRITE) {
> -		open->op_delegate_type = NFS4_OPEN_DELEGATE_WRITE;
> -		trace_nfsd_deleg_write(&dp->dl_stid.sc_stateid);
> -		path.mnt = currentfh->fh_export->ex_path.mnt;
> -		path.dentry = currentfh->fh_dentry;
> -		if (vfs_getattr(&path, &stat,
> -				(STATX_SIZE | STATX_CTIME | STATX_CHANGE_COOKIE),
> -				AT_STATX_SYNC_AS_STAT)) {
> +		if (!nfs4_delegation_stat(dp, currentfh, &stat)) {
>  			nfs4_put_stid(&dp->dl_stid);
>  			destroy_delegation(dp);
>  			goto out_no_deleg;
>  		}
> +		open->op_delegate_type = NFS4_OPEN_DELEGATE_WRITE;
>  		dp->dl_cb_fattr.ncf_cur_fsize = stat.size;
>  		dp->dl_cb_fattr.ncf_initial_cinfo =
>  			nfsd4_change_attribute(&stat, d_inode(currentfh->fh_dentry));
> +		trace_nfsd_deleg_write(&dp->dl_stid.sc_stateid);
>  	} else {
>  		open->op_delegate_type = NFS4_OPEN_DELEGATE_READ;
>  		trace_nfsd_deleg_read(&dp->dl_stid.sc_stateid);
> 
> -- 
> 2.46.0
> 

-- 
Chuck Lever

