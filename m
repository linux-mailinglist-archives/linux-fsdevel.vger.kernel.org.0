Return-Path: <linux-fsdevel+bounces-29824-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 417EA97E707
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 10:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B64311F215EE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 08:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2CF64EB5E;
	Mon, 23 Sep 2024 08:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="i67wTpJu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RuL9DFAT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552648F66;
	Mon, 23 Sep 2024 08:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727078428; cv=fail; b=MGaVpwBX7wb8kTtV4XaRpzbG7WvOpDV+k3N3vmP62Q7w+KvTBskOtNpVDR7mqVoQC7YawtGBuGra0ElF/2QebQXxOux+8Depx11llxuNI3PIE9EjDiefOQ7NPV3XILQMx+75jGZBBOBqYQfD6ReZmYSVjbTV5MTyBIjFG6VRE6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727078428; c=relaxed/simple;
	bh=1MWedKpM0gsh2S1WeF7JnNd/YVKvBBF0YjCsGb1MZeE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eHH7vwmludkMh85c4kDJSU0ELaDAgV/9i8eeklHe/MJQtXDF8hHkM2VA2WTAR+P2EBrtt7B9RIA4EVoF+1Rq7COSl7d8DZXDMY2j8kZ81KT+e0Xb4mwMEID5zPxjm9vrP/xxx5nHkO9f6ZQmXEaRnrKbzzsPEgh1iYCXsHeycEg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=i67wTpJu; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RuL9DFAT; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48N7tY3M023847;
	Mon, 23 Sep 2024 08:00:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=ujy2lEDwkD8eulgYy/Pr90OqkMC522sklAjskyhLRxA=; b=
	i67wTpJu/oauywnrfJaVHxo7IMTtA+BYrbw691iZUr3B+rs3vEpJeDSUYcz948pP
	ehuuVvar/93eg3sT7PPbhlgUod4gr/V6Sb5s94sYg9SeUXgz2PcKfnOorvkydIxv
	ROB0vwH0H4bQobDOxpACdMryzYO9CxvJbsB/2pk++/m9c5YG/Vitu+hRpjSeCph9
	QrJzMbibEqSRxR7MujkDSFmm88eH71CDG77eC0NRCMOJBy7WzPKoEAEKxWIXQmss
	BWbouoN/zyb/qCVEZQ+DxHfoiTU/wHieUjLk1QSWpWk2DXIMKg/UD/Z2iguy0jBn
	4j9dpI/bLzAx9LirE42i8Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41smx31jjf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Sep 2024 08:00:13 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48N70ldS030694;
	Mon, 23 Sep 2024 08:00:13 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2046.outbound.protection.outlook.com [104.47.70.46])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41smkdq5q0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Sep 2024 08:00:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Iwlb7yzc0TkWI4PV6L7DffOTJLhhnwRSjLFW1ZS7Pqv1xXP1yQWu96Aiw0QdM7KkktK+9/aHoF9nDVmXFZnNDV+cCGzaxG0sdiCQgKkIEmZG79DWeeVBUxCKblFbr7y0whqNFGvSu0/Mw6blFUnT64hHngQ+ACW8oNUsjF7hdJSl0BhnAMU3alGt9MOPwd1+oa5RGwZbkDM42nAIOsFUmaq3rdVI8x2fOX9koxkJZltVOGZ1AoEV4lvRmO8wyBz5of4NQaORPbsSzYfq11fIM5V8qzDD1AhZFOHIaKKGv4T5VJJXG9IPSPKmNVrzaYM0hq1hE99dk56rsni+mXDC6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ujy2lEDwkD8eulgYy/Pr90OqkMC522sklAjskyhLRxA=;
 b=TjNoWz1luojeylnTbYSri/51Pfw7yiVTfxqYvDBbHyseSuCZIElkETBaqr4QQZibnPl/IBH8Lpgu9n7jBGNcpdAX0W1fhlEqeMTW0r+PHiBWdTTwsQxRaJI/VcK1iOxC6l6igX0QieMx9f4EnVUsvQ7TI7AchyfMaL5scdWAb/4dW3DAwjdmoYscjM6iY5WaJEEgG34dl+t6XIL8HVrD8tp+y+IPoV1NtH88N8kArsAJzT6CrC8Xf+ZEHVU6IcGQAk6qiKBOZiapzx/SbUT7A3ykif7ZgcJfaA2jDvo1AUq7imnDDihuNw1avgDLI7ot7CqZBNEauQxfS+hrxV9bcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ujy2lEDwkD8eulgYy/Pr90OqkMC522sklAjskyhLRxA=;
 b=RuL9DFATARZJQmIiTizxwsKRg9DCdShZiUVIl1LkkxBdjAefmbneOhRDJzREIMnCp62fOz14LlzmrL6sQ7nFwJZPqbK+uR+kzk4d1p7b+lJqYM0BByryDULo5q7C+NTPL7weVrvLhQcWsS7do0cD4DxK654riy3xfff+ltjCkyQ=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS7PR10MB7129.namprd10.prod.outlook.com (2603:10b6:8:e6::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8005.7; Mon, 23 Sep 2024 08:00:10 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%3]) with mapi id 15.20.8005.010; Mon, 23 Sep 2024
 08:00:10 +0000
Message-ID: <591f0499-2a5a-437a-be11-453d40169f5c@oracle.com>
Date: Mon, 23 Sep 2024 09:00:07 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/14] forcealign for xfs
To: Dave Chinner <david@fromorbit.com>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, chandan.babu@oracle.com,
        djwong@kernel.org, dchinner@redhat.com, hch@lst.de,
        viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com,
        martin.petersen@oracle.com
References: <20240813163638.3751939-1-john.g.garry@oracle.com>
 <87frqf2smy.fsf@gmail.com> <ZtjrUI+oqqABJL2j@dread.disaster.area>
 <877cbq3g9i.fsf@gmail.com> <ZtlQt/7VHbOtQ+gY@dread.disaster.area>
 <8734m7henr.fsf@gmail.com> <ZufYRolfyUqEOS1c@dread.disaster.area>
 <c8a9dba5-7d02-4aa2-a01f-dd7f53b24938@oracle.com>
 <Zun+yci6CeiuNS2o@dread.disaster.area>
 <8e13fa74-f8f7-49d3-b640-0daf50da5acb@oracle.com>
 <ZvDZHC1NJWlOR6Uf@dread.disaster.area>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZvDZHC1NJWlOR6Uf@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0011.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ad::19) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS7PR10MB7129:EE_
X-MS-Office365-Filtering-Correlation-Id: a09effeb-d0af-4ece-01de-08dcdba5bed1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RVBTR0RpSGZRVGRQeDZjSDQyRWhuV0x1M3d4REtQS1NnVkJLb0dkUW8vY2Ir?=
 =?utf-8?B?Q3ZQdGh2ZjE3T3FlbGJUZHpXczk5SzUwTGdib0tqeHB4SHVNeDlrM29ESkJp?=
 =?utf-8?B?OWdxcS9CVEUyQ25lS1VlbDJIQ3JKaW01ZFMrTXhHZytPSGtjUXVZVVA2Wis2?=
 =?utf-8?B?a3NyWDZxYVJnV2lYUEUwVEc0NW4xOVFMNjVwTlVsOHFkS2QraFd3eWFDSG1U?=
 =?utf-8?B?N3hCK2h6ODJpRlJKMTgyVVBXeWdMWFlwUGxNSWZhNUVlZTVFZFVPRE84U0Q0?=
 =?utf-8?B?eGFna2N3NHVxcVJYWUNLNzBGU2R0Zk9jNjg3azlVRVY4djF1S0tpVWJnaHVG?=
 =?utf-8?B?NEdsNmxoMFNqL3JYZ0JMOUtXUzhDT1ovL053LzY3ekttMmVFeEsrUDVTTTc3?=
 =?utf-8?B?TjV0TS9wU0pobm5FTWlRMDFCaCszM2VmYjQrNWlPb2I4K3VkZ292bkVLY3hs?=
 =?utf-8?B?OEdzNGtHMW1zZmpucnFtdTNZMXFLRUIxZnhaeFU2TnZ3dlVZYUVZUytlWW13?=
 =?utf-8?B?OTNBS29LTWEvZGsyOEQ1TmhhbFl1cTJzbGJqZlFtRm5sdGxLUm1neWVDWWRr?=
 =?utf-8?B?L1BFNmJWalJCNTU0T3RYMFVkNllHQU9zZEtJMjdycFlZb2RGMWFneWpLSDFh?=
 =?utf-8?B?d3htbk9haVQ3eFFPUC90VUlVRVZCYkd3YmoxTEZRdTBYNWRrQXlBR3c5clFF?=
 =?utf-8?B?WVJ6SDRKbGJnU0JXd1BOMkxuQjUwQ1c1emE5eEJyRE1BMmQxYXRmTGt3eWpL?=
 =?utf-8?B?V3JqTS9USGszdTZKY0JTd2JvaDY2RWtPOEhMQ2FHVUFLc0RkQTBxY0YyYjVr?=
 =?utf-8?B?VytmbW9IR1JwdDhSSFJLbXZhcENvSzFxVzhZMnRYWDY5N1prdy83RHJnQ2pL?=
 =?utf-8?B?UzdZSDVmU0ROZEkyWmUxNnc5dFdRMWp1b3I0cUdwZEZBamNjSk5qNTdzcGY0?=
 =?utf-8?B?NEJuT2MxQ0xrVEZUNC9hRmpnQ2hNRzRpRFkwaDN5RjlTck9lU2dNN0Y4WGxR?=
 =?utf-8?B?am9RV3VQYXk1eGVhc0RXMldYdVB2Y20vc2FPaWtmWk44VVg0REtaSUpsMkR3?=
 =?utf-8?B?SnFSSWYrOUVjRUpYczBkdnozQnE5STZIWS91VmtuWnZjeHdhUHFvenExb21L?=
 =?utf-8?B?eWJnamtrb0xxZDEyNlNIaUtIV2tOK2trRHJxbFF0MzB5TWZVSS9uNEdIMHYv?=
 =?utf-8?B?bFpnSzJPa0FtTk41NExhV1YwWVlJRVlQTWdVSVNPRTVkc25tNExkQzh1R2Q4?=
 =?utf-8?B?cnNZanZTeE5QbFhqdXJXNVgxdGRLRHlMZCs1bUdGWjFyYWNDSFE5a0lndWpt?=
 =?utf-8?B?RGdVQ1NNWGtwQlcrZnpKRTdYQ2RReWJDZWR4SHJqV1lTUG1lbzV4WnNzYWJj?=
 =?utf-8?B?ZDVvMDFuQzFvb3U0V2lhUzl0NWN3MVNCSGdnbDBXUVhyNlo0VXNLSWFqZitE?=
 =?utf-8?B?L2ZaTzV2SUN1dytyM3pjZndJQ2ZGOVhyUlVKVWpQbWdWUjRNNjdqOEZDUzg0?=
 =?utf-8?B?ck5XSjZHZEp5bXZJbFVBdnMrRzBkVkFoak9ydzJWMlN1SE92NFVmdVJ5ZlRx?=
 =?utf-8?B?WFR3dTEwVytkVHdVa203KzRTVlpFOEd2ZlphcUpnUjJKQWVOenJ0eHZqSnRj?=
 =?utf-8?B?VUJLRzc1VHZpbHk5Wmx5LzVPWWczdUg3VnFWSmx4aGRIYkR6YWxqb29rSk5T?=
 =?utf-8?B?Zm1FMG1uQ3BpL3NDVjBqZjdmTHpTdFRIb3RoZHVMTTQ4UGNpS0EvbnlRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WDZDbG5YWjRHbEJiNTZyTGplUVBZZXdlVzFwTHFiS0wrWjZNT0pHMURrcmRk?=
 =?utf-8?B?d0NnVVJhZWtKL1h2WEUxbExEYmgyUjlvNzhzbzBFb0JucUFBMkhYTFRmQTdu?=
 =?utf-8?B?T280OC92TXJTVGFtdW11cEFVbll4TTBFcHJKcEtmaUEzSEg1MFZrcHlBUWNQ?=
 =?utf-8?B?TWhZNGZ4Y0p1bVRKZ3FSeWZKQ3BxYUcwM3UwcXdnLzB1L1VlL0ZSd2JUTVVa?=
 =?utf-8?B?TGEvS3dISWU1ODhKd3VtblVHQUY2aDFocS8xSTRYVmhVUTdKcmcyNlowelZa?=
 =?utf-8?B?ZTNTY1dYQzhoTko5eE5kS2VLRlk0MEhtL0xFL1FOTzM1WnVxYTFMSHlxQWpZ?=
 =?utf-8?B?OHJsUzF3anI4TjlUY0FwTDdGWGdZS25MRVo5NzNnVTJNTlVmNnBDd1JqRTl3?=
 =?utf-8?B?c3cvTFRMdndWaHdDVTY5RmRXVXRvblQ3NC9HcnUvYWtQd0cwdWN0RXczUUNC?=
 =?utf-8?B?amYvVXk4b3J1WVkwWHpPRGNQNXJtZnpjZ01RYVNKNGFoMkxISDB3OUF2MFNE?=
 =?utf-8?B?V3FZT1l6MDVFMktETEZGMFFvUFdCLy9RVE1FeWFsSnhMTnpCRHBNdys4VkZw?=
 =?utf-8?B?QlR6R3h1c2QyMHdQWll3VVl3ajVsZGZrcVVEZHRoUHoyWngyd25NQkVKRVo4?=
 =?utf-8?B?Wk9KVUlpZWpsbWxuS3M2Vk1RQXZZdWtwNWhhc1h0YkUvc1JXSmVkUGRleEVN?=
 =?utf-8?B?MHpYMmpWUFQvNXZnb2wyRnpIY1ZMV1VEZ3ZrSVlESWxsWWhVbU5nYzdGZkdP?=
 =?utf-8?B?WUk5cU5obmhBbDh6eWc5TVdZYnV5NHBWZkl5QTNjSjA0S1RPRTBTRWxjVVcx?=
 =?utf-8?B?YWVxOTdmbzRicy9KR21WMGZ2U282V2dNS0g2NURpOG8rTFRWSTZPR09VdWNS?=
 =?utf-8?B?dWplSVo4eTc0S204ODY2T1AvazJCZElkN2t1ajI3NjJncjZBQ0xZWUJtYk1I?=
 =?utf-8?B?UzBGRXZFdG04UW5YT29VM09sNjBaNXdhWkdwSGRpVE5uVnJtbU9pRzgvV2xB?=
 =?utf-8?B?WUJVTWFHblEzQkxGbEVPNlhXaktoa1RBNldvLzcwNnNONkRlTHZQdVlaSWdy?=
 =?utf-8?B?VXBPLys4c1RhVXBIWHdSQWc3T3VHd3ZobXJxZGVHZ0FHaytVOSs2aDNRaUVM?=
 =?utf-8?B?anlQRnNseFJtNlpqVjBaRWdkK0tURFNIVGJNUXUzYmI1MjBPMkZVZHF1QUNu?=
 =?utf-8?B?NWp6LzJySUllZjB1ai9pRnptWkNBYk9tMElSWDY3T1FySFNsbFg0YmlLZG1x?=
 =?utf-8?B?UDBoTW1RT2thL3hYQ0gwWlQ1MFN2enc3WGQ4UXpkQk9CeDQrelhuWURQWWVp?=
 =?utf-8?B?ejl2Yk43UE5zcnFGQmRWVXgyZ2JGdVJxaTgxTENOaXFpWDBNZGtvRlhvS1lW?=
 =?utf-8?B?Qm9lRENUYXJiMm9pY2luelVoaGkxeitpcWc3cE1jaUtQRmdWK2lJVVBHcFRo?=
 =?utf-8?B?QStGSW1CNTcyL1MzditWYUd2M1h0S215NzJleTR6OWJjQlNkUzhXa2tRL2oy?=
 =?utf-8?B?dHJuMDdjMmcxSGdYRmluUndFNS85QUdsQ1YwMGRZcitjdEtZYXZrNUorbnA5?=
 =?utf-8?B?KzQ2WVNJMnJrWHhwd1BWdzhRM1FTVlZ1ZDVMVWtGWjZjcVhURVUxOG9tMmY2?=
 =?utf-8?B?VnBwZi9IdVNkVGNjUDc1ZnUxUGlqcTl2dW44TmthSEJncURJMGZHN2dNUVk2?=
 =?utf-8?B?aFpCdXM3elpIU3cvZ0pUU01LMzBRYllWaXJLTjZ2YkcrdXlXMUl4cStBQ0hP?=
 =?utf-8?B?YkNnWVp3YUJUTTRQcWNaTVpISzl5eHZRejlzK0s5RVd0M2dNbXdhSDVudFpm?=
 =?utf-8?B?UnZiQjJ1Q0dtbzlSOFI0MW96eTNpRnJob1E2Z1BCaUlQVFlsOVNLZ3FQQmoy?=
 =?utf-8?B?bnd5bXZWZnI2aXdTRk5rRzJWbC9kZlRqSlRQLzJLTGdldkV4NW5ablg2Y2F6?=
 =?utf-8?B?dWowK0YxL1BVK1RibndJckUzMmFWTXRBa2doVHdCS01zU3dFU3BwajMvT3dk?=
 =?utf-8?B?b3ZJZW9NdlNFVW9rQnpsYkl6VlllVDcveXY0ei9uU0VGQk9jbisxcmlZeklw?=
 =?utf-8?B?ZGxzNTh3VFZFdklkR0FvdHUra05lM0lCeTUxOWRxL012d2V6OXY3eEtXeGdF?=
 =?utf-8?B?SjYvK052UlkxRXhEK3VIcFA3N0Rvc2I1SXlpMkhnQWJ2VVp0UVI4NG9BTHdo?=
 =?utf-8?B?dWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	O3vi+0mqRZ4TYOlhIuc8r1xsRoATQZqj6YXc/g0fZz329OPd5fchrjTANSrO0myzoqi0ZElF2HxCDWf55QLYyVeBsRM6UufHlJK6YdSYDydyZTTGic2xhkciiIWtfdWOqiI4AF/l2Sfg/Y5IpICJqqirId9oW5VTWK43AkC9oDGl9Z2xN5coO1z1bCuo97cRU/EyEIRzTJUC2IrVcR1GZgY7WMPVihvXTYyGVdL7s1+kmnCeWiaawb7tLlCsKwOKHcjYsx1SWblVU6q8rt1IlLmHdWwJIdddXXUOW8A3LtCzCXA8dn64G2HLm1INhmxu2PXB2xlTnYRVD1A7cPn4h2UjRD6kaOAEPgdWFMncmmSikf68v0nfouvnkFh0cpheXBSx7n64YppYspnDe2b4K/hBCFlmh0ZO+sH9JMUGxS9rNJNvBKVmjnHSfCTVA92W09t8RxMK9x+9O2p2nbLYbtmO6dG1kUSU/4fMDU8kw2jJPW5as3L3C010FQMY5uokPdcZmx7ZsM+dW/gTrpfXgU7iirSNNEfmqajwJo5aKx0lq6RfPpjXFscUKLYemhprNGZmCKzhKRISYpz4O+hanTeplegUJMc3NmKy0f/APQE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a09effeb-d0af-4ece-01de-08dcdba5bed1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2024 08:00:09.9753
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4MX9jTsZmwesaeksLnG4RhxHdUgjpEk3RW4cFEeXH63BbsriUXqDVZOBPmEsyEHwpTL7xR/LtFjN74jZsBPH5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7129
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-23_04,2024-09-19_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 mlxlogscore=874 malwarescore=0 adultscore=0 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409230058
X-Proofpoint-ORIG-GUID: EkT_R76VbNMqzjZ41sMyiQQtDrW_nadA
X-Proofpoint-GUID: EkT_R76VbNMqzjZ41sMyiQQtDrW_nadA

On 23/09/2024 03:57, Dave Chinner wrote:
>> In the meantime, if mkfs auto-enables atomic writes (when the HW supports),
>> what will it do to reflink feature (in terms of enabling)?
> I didn't say we should always "auto-enable atomic writes".
> 
> I said if the hardware is atomic write capable, then mkfs should
> always*align the filesystem* to atomic write constraints.  A kernel
> upgrade will eventually allow reflink and atomic writes to co-exist,
> but only if the filesystem is correctly aligned to the hardware
> constrains for atomic writes. We need to ensure we leave that
> upgrade path open....
> 
> .... and only once we have full support can we make "mkfs
> auto-enable atomic writes".

ok, fine. The current maximum value of atomic write unit max is 512KB 
(assuming 4K PAGE_SIZE and 512B sector size), so that should not be too 
needlessly inefficient for laying out the AGs. However, for 16KB+ 
PAGE_SIZE, that value could naturally be larger. However having HW which 
supports such large atomics would be very unlikely.

Thanks,
John


