Return-Path: <linux-fsdevel+bounces-29625-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C58A397B8E9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2024 10:00:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCD611F211D3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2024 08:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5507516E89B;
	Wed, 18 Sep 2024 08:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jla3drzP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JWgEWhPM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F051170836;
	Wed, 18 Sep 2024 08:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726646405; cv=fail; b=hpfuQaOma4LqJLRmnJ5/c30HTNgHjvIaRqzIkAyr5q6f8pig5H9/TQXzOUMeQgWj3RVqcTzqd2jA9AqU1RFkAKx1BA4Ip/8rCgeBWZQEUsGXKvkxX8DMfn65wd/cpHgXkRRCEDmoBxoaUyaTnq5lOiFrH70C9oeMUg0M54owV3w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726646405; c=relaxed/simple;
	bh=JrEw7ra8mj3OIykIEES5GMvNcbCv5RzgNETSIvyAyVU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=i0XRndMrDGV7V47zn7Wz/pXXciL46W6ghkVk2Jgk+p673/jTlPdMnpy+UJ/kjGstTDOZG+FJtvXlyL0esutFCmbYBnHEaTCMzXzfpptcPuzRdcc90fABIM75Niiu+fBHQ9yzDAh/oFIlbQoWQ6Jx3N4MEJC22d07Vxkq+YLqydQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jla3drzP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JWgEWhPM; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48I7tqLD011237;
	Wed, 18 Sep 2024 07:59:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=O2pqjaNlJjXubMFDNqhhjH8mnbvrRt4/0DJYTPR2A7g=; b=
	jla3drzP6OaHpn2eQOl7QrYVIKoH67fXCYYbnkqXDVQYmRVGYHQ7Zar0PdzS5Avi
	aNMy6AgtLRZeRJiUo/PKFlrZFZU9GPdNeIlZLi3FvfTyDVAoueqnQ2pjGXp8Mw+w
	IJv04DH54ATmWmhADUGKEJjQhkT02+yza8yuKN0PA6RGG9EyOYUZrBzht4A49d1b
	YuIjQvbyMSLX1LHQmxDQ9sgrd9dOdYZTrw7URf5s88b+xRRvcmN4vzQZxloixo21
	mvvuCsT3w9xlqrdWKzN61OyMoilvPw3EVH8PfluRCY5I7MuFWqK00U3odg72/E6i
	DhywxJsDo/zav/kPJZh2hw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41n3nsgmgu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Sep 2024 07:59:48 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48I7YHf9017831;
	Wed, 18 Sep 2024 07:59:47 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41nycxpg4u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Sep 2024 07:59:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a2QVYJ3UjtOtsv/lcx6ZpUuswjSMRRA/f6zuEnIGS1WI7NWg66KYiAuAX/DcmgWzZ1Aur3g/m8KwMK6Jubyc5I1lceysFELoU6BpGNP0YXBtdrdQ8VmrxYFFWv49fo9OfAhfH++5Bee9PMIkwv3e8wrxz+yRYZiv9hD8xG7xmJ/65NYbOlS4S8LUeWVjM81xIYlXe3enV76rBTerEUQG2uIgvE+oLIJmiHfYJdTjo4bJU+LPdSqYbCqGoYslwpaR9xiwv7Hyi0YHF2EdeJzZRBIfJaCUviVxdHGUXjdnH2ElhP1LJR/61SRso/fPuuIYsai1uFL8VnZhm9qgt6FHpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O2pqjaNlJjXubMFDNqhhjH8mnbvrRt4/0DJYTPR2A7g=;
 b=cYkcDjQIi9IDDz1frFyGbmL8H0yZhEiiTEhSOPfts0OrbNRglvSugoMB1Fn+MncdPnO9wnklfltYIwIBP5DcxxNUmvcdeUIrPj9wZ0Bnx6nHLU24Dph7wv4sYta9k5hFoAJ1BOD+i8cCssO9RojKE5wCVrZPsD9bfWgWYXZf7Vw90zUSODEOxCbEOK7/bVN5m2o88ITpf1lW2VN5oVSCPQqwEar8o2lY3x1LX4Nrf8k3h/Ivv1FcvJT+gwhQDj8c7PApM0hWla2sC+jlxCfvOUkPf0ru6EAFyChF4j3TnQuk5xpfvvCQ5Ty9ioJeMc9md2cZnLi50IS6vaK6zshs1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O2pqjaNlJjXubMFDNqhhjH8mnbvrRt4/0DJYTPR2A7g=;
 b=JWgEWhPM9XJBbqQZdoWzIvCN+s87x6olj8Rzjac3l0LGNha01sfdcy5ChYLGzFvkOCgsCKoZIgB8uKuYhjubabZIzyq2ffso2Q216dHMv/DdqaWsdI3B1273PIOz78yMvR4yBFA3QeXOk4EvFZWbjK2iZdJU8krmOCAX5aax7CM=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SA1PR10MB5823.namprd10.prod.outlook.com (2603:10b6:806:235::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.15; Wed, 18 Sep
 2024 07:59:45 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%3]) with mapi id 15.20.7982.011; Wed, 18 Sep 2024
 07:59:45 +0000
Message-ID: <8e13fa74-f8f7-49d3-b640-0daf50da5acb@oracle.com>
Date: Wed, 18 Sep 2024 08:59:41 +0100
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
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <Zun+yci6CeiuNS2o@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0316.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:197::15) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SA1PR10MB5823:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bae5142-47c6-40f0-a3f7-08dcd7b7dc19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bERyTmYxR2Z5aGFMTDlQUGNMV2tVekhjbzk5b01Cd04velRHd0w0RW9nRlVw?=
 =?utf-8?B?M0dyOE1LTCtrVWdwcnpBOEtTT2dwbjdrSnB3RW5wMEcwbFUrcnBLTGU0bDlt?=
 =?utf-8?B?RWdMTzNieEIvWE94dDhFMGhBbVJNZFJ3WG1LaHh6cWVMdDhNWFhvWktqRUts?=
 =?utf-8?B?ajdrd2tYR0ZFZTEzYUJORk5SbE1aMDZDQXJIZTc0L0JyL25LbVhKeG1BNHVq?=
 =?utf-8?B?U1FWUnVld216SGpMMWRyaktuOUpDWXBlazdnWkhQamhYUGlwcUtKUHhrcmNJ?=
 =?utf-8?B?QmpPV1ovcCttcXRWRFNjenFRb3NYQzU0SklVd0RHSHdsWjZwVHhLNis0UCs3?=
 =?utf-8?B?VU5mUmg1bU9pS25kNHVMWTlFWE1vTHA3Vy9zK2lzc0ZjdVh0a0lkS3ZJWnRt?=
 =?utf-8?B?RWg3VVpNL1pOeVdqcE1aYnZidTdyWlc4dlNWdFQ4aUpJNkh0Z25wa1ZBY1BS?=
 =?utf-8?B?L0w5WDM3MUpldko5eDBnNFZocHJiVXdUUE4vZTJISjNpSFFRbE1mcW9SVkxy?=
 =?utf-8?B?K1ZFWFBxV0lmZTM0VHBFNEZjaHNsK3VzQUZhMUd4MFdJVTlQY0RXbnZDQU5N?=
 =?utf-8?B?UlZQUGthcDVmTTZJWm56RUp4UzNxNzZMSFFYekxMWWx2d3o4K3ovNlowcytv?=
 =?utf-8?B?a0p4L0VUVkIzbEpuMkppQmEwS0l6MDJmVkx5VVo3TVJUcEdkejFySE1CU2VL?=
 =?utf-8?B?YmlIZHBaTDBWZzRXNkZOWHRUbDBTU0lrbzBtUlprMmIxeENkNUVBRklvNi9a?=
 =?utf-8?B?eDJQTUpxSFF4MDBiV2hSdGlhRUl1OW1aUDdBZnprdEdCRzJuNmIwVE1ydFVs?=
 =?utf-8?B?Z3E1cTJNV3RDcFMxOXgrd1d6bUl2UEZLeFVRNmFiK3JMZTlzWDBjVFRjY0N1?=
 =?utf-8?B?WUdNUUlEZkFldXFkbWNpSXhXU0E2WWJBM1JIaEZ6ZkV6a1p2RlpUS3ZWU253?=
 =?utf-8?B?WW4rRlZNOHQ0b2xENjNaMTIrbzBJdWQ4bG1XRmdPZzRuY3cyZEx5bXltTGRt?=
 =?utf-8?B?UmEwU1U2NTVQY3lMcEU1SmkvY2I3T2RjbXVqc0E5Uno4c0UyMXJibjR3Ym5l?=
 =?utf-8?B?UnpIWlVPTzJnakN3dS8wVWJTNzhjTVNzYU1oZEVEem53bnAxQ2p5K0ZIc2NG?=
 =?utf-8?B?Z3VDeFV6U0lmblJxMWxpZnArZk9oU1J4WEsxVXBLRVBOWkxTNHpTT3Z3K0g5?=
 =?utf-8?B?Ui9UdFhiVkthS01hVVpyZURZVHBDeEZNRHlya08ydmszeUZkd0FwQzJIVGV0?=
 =?utf-8?B?bFU4MG8zMDU3RHpXUWRnL092ek9ObnhGU0ZDa2ViMTJKeWJyTXRYdlhseHZY?=
 =?utf-8?B?QS83SnBWczQ4SEJ4Vy9naURFeUloRkU2ckduUmZGNFNjTFRYZ2l3SEQzRElU?=
 =?utf-8?B?OWFLaUU1TndDTW1neVRuZ2RnM2J6MHBSQ1VqYmxJK0M1c2diVXpvZzYzY2hq?=
 =?utf-8?B?QW8vM1MxamNvTnkxSU5kNzNLZmJIcUowV25aKzA5elpVTGMzdWs2SllFOXc1?=
 =?utf-8?B?ZW5VcGhEU2pqNzk4NG5uN2wraGRRTmNXSG02dmdTczU4WG1OcXFrMHVuT2pF?=
 =?utf-8?B?aVRrN2kvMnhzYXZjeXY1Y3Q3WHFIQld5NTVDdlpneUtPMlQvRHVOcDlDSGV5?=
 =?utf-8?B?emo5Vk9tdDIrVU0zQ0IwOG5iNjA5dG1RaUJ3cytmaXlnYUdDV0ZwR3hMcnFU?=
 =?utf-8?B?K2JJb0RvdUhKVTRYR29mOFgwcFRFM09JcDl5Z0xsaVBIZGV4cTZMaktBbFZJ?=
 =?utf-8?B?NnFSaWt2OWZ3MXpaYlZGWVVPZFRLSHg1WmdBNVNTc1VZRjlUcUI2ZGM5TnlC?=
 =?utf-8?B?QzJ1MlBLNnh6QXFIRmx5Zz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eHJxS1dlTFJNSGlDU0pLWjRrSkR6Yk0ySjcwRTNGN3R4RXNxVE42MUhiczJT?=
 =?utf-8?B?TlN3cURDMm50S2pHREhzeEkzQVkwWnRaYUxaREFCQ2JQbG9SUFFYY1k0ZVB2?=
 =?utf-8?B?bDdRTStueUVtR3p6Vm9kcWlDN1ZSNUR6QThoNjAxcTlIZ0pJREdRTU5CTG5j?=
 =?utf-8?B?cUJrbnpaejE3NlRoZjNCVDhMQlI2ZlAvYkRvRkJuMUlpdXd4anJmMlNVYlR3?=
 =?utf-8?B?dlB3Q3FhcnVpYWZsUDRmM3NSZGE4R2JnbVZxOFkraldXNXRiaHRrYzVIaHk4?=
 =?utf-8?B?QmdleG5NZG5TcDhQL0NNVlV1VUVmQ2wxS0NkVmRENGxBaHdDMFE1ZlZrRmsw?=
 =?utf-8?B?SGJTaUN6VnpTR3IrNXlveU5wamVSeEhvMDl5MmFOQm9nc0NPUWEzVmx0VDdU?=
 =?utf-8?B?ajUyZVh1R1hYekZmSlBKajhaaXhOL0xsOUgyclpoWjFydjdmVS9vcnB1ZTBD?=
 =?utf-8?B?cGw2QzJKUk9EZlBmdmFxM2ZLNS9Jd1BTU0cwMnA5cWtXRmdLSEZEVktyVkFo?=
 =?utf-8?B?a28wWGVuTVdoQWdmNEhhOU14ak1wdHhEOUtCN09XSFJkSkluVWduR0s5dGtR?=
 =?utf-8?B?WGZHN1VTWHF4RzBnOEozQmNXL09JOUppVU9VVXlxVGlHRGUrN25TMExlbmJh?=
 =?utf-8?B?TW5MZFIrc1Y1NEYrVUJidlVIRlNadkhFWmxLbEw4NTJtVmhmNmViVWM0ZEFH?=
 =?utf-8?B?WVlxdlZHYkNXcFdIZWgzbVJRaFNYOHpiY1QwUHRPa1JZN3BFNHFQdXZWVFhO?=
 =?utf-8?B?U3luU3lCNXRVd2doTGtHYVlXMlRseWNLM3hsT2VSNFZFblFNR09NS3N5a1Y2?=
 =?utf-8?B?STFtRUNGaXlDaUlmTlVHWWEyenlZMnpjMXE1NjNiQkpKcVFTUjFabndqNElJ?=
 =?utf-8?B?UlVtcUg0c1FoOUhzU3JqMVMrS2RiVUQ1NWVTQkxjUnVHdjNHaEpXVDFEbFVP?=
 =?utf-8?B?ZkZLUkRKRENnTm5HUjFBTzVLWWxEZFY0cjJPRDhvTmZicERUaDBYWUhzbWlx?=
 =?utf-8?B?OWMzU0Z5RVVyTmdqOGJpbkQyRVd0OUo4NmpMR0lWSXFRSTRSRytoa2dTRmhM?=
 =?utf-8?B?U2lLNkt4dW9ObGlVZ0M1QWRmQkdTUFJMejdDb3ZJK0ZPb3c3TC9WUURCOHM3?=
 =?utf-8?B?RjBSeTNHbHVBS0x6T3U1Z082cGxDUUFpZjYrVU1HME9qSjhLTFp3OEtqeFZQ?=
 =?utf-8?B?Tm90UForRTVxUG5HbGdtQnVienMveHhadzZlVEc0cVlJNTRTTGdJUUkwZzFS?=
 =?utf-8?B?QlRyRmVmK3pjNTZ4U2pmTGtZK21zQ2NoWFd0eW00dEFkVDE2M3JzMUZsRHQr?=
 =?utf-8?B?a1dDYXA1dGtQY1QvZFBKQldVNVJoQUdvdjM5cUFaWGl6WENpYVQ2dnoyR2FI?=
 =?utf-8?B?NmhEZmNueXpHOUJreXA4MFhxZ2pqazBUT1Q5Wk1ETTVoU0VFb2dHTU95bnB5?=
 =?utf-8?B?VWZjSW1NT25qWlE0NVhvRVl2STk4TWxrbWNadGNqOUF1TXk3LzZ1Tmgva2pr?=
 =?utf-8?B?Z054TDlPN0g2TGd6V0llQjhpQkJXM0tGcDlPdkRCNFpkWHpwYVJLeW4xQ2Rh?=
 =?utf-8?B?NUIzd0orVWpaN01KWHZVY2hPZVpwdmtzWjFJaG9NTWZrTTV1OTZIYnhWSVhO?=
 =?utf-8?B?NXVlc0RKUktHakhiY0hFajhwU0FxbllsWFBzRUd3NHNUajNZU0VucFZOWVN2?=
 =?utf-8?B?OUU3cGRBdUVSWi9VUXdpSnlPRXpSTTB2cDYxQ0h3bmdhK0JreDkxZnhxOUJn?=
 =?utf-8?B?QS9Db3RxNFVCMmJTQzlUTTJ2Vnp0c3RIZkJJa21adUxXR3JRVUxOVkhMWkgw?=
 =?utf-8?B?d25LeG05TVhobzVHMkdRK1FHbkxXVHBDUFdGVmdhMnBFeXZiVkYvT3dBc1Fr?=
 =?utf-8?B?bDNldXN5TGVHeVo5Sm1ldWE1SEVzTklkNy85eVNNdFhLem1HY25md3I3akVG?=
 =?utf-8?B?UjE3K2FKeEVWOEZLRGtyZ2djcTh2OGMzb24yY1B4ZC9UUlhLbnZHQ3NxMWtI?=
 =?utf-8?B?UFkvblUvcnZRcXd5SUVqeE44T3R5eW9YQ28yajBHUkVzWlNIM2Z1T2NWVG9W?=
 =?utf-8?B?Qmh0NmJmMkI3SkE3alc5TGpPalc4V0dNS1hrSXZSbmYyVm9JR2dlOHJmbHZ4?=
 =?utf-8?Q?5R6h8omkL7cKVf29Xp75NSB8l?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	C7a5YPWgSQbtEg4tlPlCA88EgmpFX6Q8XAnaD5TgA2RDXI+NI2TmuYyVPSu9VvnmeOLA/uvheE0vW0oY7ji28lxZQjYl20jboUoO4jY6d4KMsdqoM22ByqnOD6j95wkzOlJU23mQZMzgE4iOUJlvWaiFBby7m7cYmZXYzDMqUeJ8pEtKaDpXNKTgY7OTgr+q8gUOvZIcegk266ca0U9qTYWQKbRUrVRi4YK2KgrpDvvtYvqDWQJxUm3aZFTlOQ7xEWFQ35jQZkMbyNrIZFcvC2PiQWgdbKV9EqqPS9OTZe939TN2BKk8nB5hPdvzaCI8ievZx3FNtlk7PTNCGHF6fM4vvh3OE8rOYqZIECZotF7Eq2tEgJfrbXQdMBtYmDflDmNnx5N9hQHnjjXv/7Ddxkubmq8TYupsWzUVwWvBQ+z5McFY8dG1SIWikcKOB7lbsKhzO/6ZryAnyR/JDZd8GY/+Ex4sU4tY83xEjztXvDWQkYO9u+ZkAMGLTGi1tzvhZG93NMpxjtlLHZ0yKjtbzFwpH+t8yqftTgAk0yD85knWl/Gkcd2I2/IWbOIJw6JvrHQ4QEWyVoRqf4ln5PDbRWHpLfxpeq/XN37OKEvrjLE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bae5142-47c6-40f0-a3f7-08dcd7b7dc19
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2024 07:59:45.3538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ECQd08bEZ/nPSzL4or0lfd2uke1vAXE4UFjeUfImjO+LI6ML7159FBfv3CzQ5yufQcCnrxq95KJAmVqqWrvllw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5823
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-18_06,2024-09-16_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 mlxscore=0 phishscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409180049
X-Proofpoint-GUID: ZAeYvnWsaRCtLavqAsXz3aewXj6WmDda
X-Proofpoint-ORIG-GUID: ZAeYvnWsaRCtLavqAsXz3aewXj6WmDda

On 17/09/2024 23:12, Dave Chinner wrote:
> On Mon, Sep 16, 2024 at 11:24:56AM +0100, John Garry wrote:
>> On 16/09/2024 08:03, Dave Chinner wrote:
>>> OTOH, we can't do this with atomic writes. Atomic writes require
>>> some mkfs help because they require explicit physical alignment of
>>> the filesystem to the underlying storage.
>>
>> If we are enabling atomic writes at mkfs time, then we can ensure agsize %
>> extsize == 0. That provides the physical alignment guarantee. It also makes
>> sense to ensure extsize is a power-of-2.
> 
> No, mkfs does not want to align anything to "extsize". It needs to
> align the filesystem geometry to be compatible with the underlying
> block device atomic write alignment parameters.
> 
> We just don't care if extsize is not an exact multiple of agsize.
> As long as extsize is aligned to the atomic write boundaries and the
> start of the AG is aligned to atomic write boundaries, we can
> allocate hardware aligned extsize sized extents from the AG.
> 
> AGs are always going to contain lots of non-aligned, randomly sized
> extents for other stuff like metadata and unaligned file data.
> Aligned allocation is all about finding extsized aligned free space
> within the AG and has nothing to do with the size of the AG itself.

Fine, we can go the way of aligning the agsize to the atomic write unit 
max for mkfs.

> 
>> However, extsize is re-configurble per inode. So, for an inode enabled for
>> atomic writes, we must still ensure agsize % new extsize == 0 (and also new
>> extsize is a power-of-2)
> 
> Ensuring that the extsize is aligned to the hardware atomic write
> limits is a kernel runtime check when enabling atomic writes on an
> inode.
> 
> In this case, we do not care what the AG size is - it is completely
> irrelevant to these per-inode runtime checks because mkfs has
> already guaranteed that the AG is correctly aligned to the
> underlying hardware. That means is extsize is also aligned to the
> underlying hardware, physical extent layout is guaranteed to be
> compatible with the hardware constraints for atomic writes...

Sure, we would just need to enforce that extsize is a power-of-2 then.

> 
>>> Hence we'll eventually end
>>> up with atomic writes needing to be enabled at mkfs time, but force
>>> align will be an upgradeable feature flag.
>>
>> Could atomic writes also be an upgradeable feature? We just need to ensure
>> that agsize % extsize == 0 for an inode enabled for atomic writes.
> 
> To turn the superblock feature bit on, we have to check the AGs are
> correctly aligned to the *underlying hardware*. If they aren't
> correctly aligned (and there is a good chance they will not be)
> then we can't enable atomic writes at all. The only way to change
> this is to physically move AGs around in the block device (i.e. via
> xfs_expand tool I proposed).
 > > i.e. the mkfs dependency on having the AGs aligned to the underlying
> atomic write capabilities of the block device never goes away, even
> if we want to make the feature dynamically enabled.
> 
> IOWs, yes, an existing filesystem -could- be upgradeable, but there
> is no guarantee that is will be.
> 
> Quite frankly, we aren't going to see block devices that filesystems
> already exist on suddenly sprout support for atomic writes mid-life.

I would not be so sure. Some SCSI devices used in production which I 
know implicitly write 32KB atomically. And we would like to use them for 
atomic writes. 32KB is small and I guess that there is a small chance of 
pre-existing AGs not being 32KB aligned. I would need to check if there 
is even a min alignment for AGs...

> Hence if mkfs detects atomic write support in the underlying device,
> it should *always* modify the geometry to be compatible with atomic
> writes and enable atomic write support.

The current solution is to enable via commandline.

> 
> Yes, that means the "incompat with reflink" issue needs to be fixed
> before we take atomic writes out of experimental (i.e. we consistently
> apply the same "full support" criteria we applied to DAX).

In the meantime, if mkfs auto-enables atomic writes (when the HW 
supports), what will it do to reflink feature (in terms of enabling)?

> 
> Hence by the time atomic writes are a fully supported feature, we're
> going to be able to enable them by default at mkfs time for any
> hardware that supports them...
> 
>> Valid
>> extsize values may be quite limited, though, depending on the value of
>> agsize.
> 
> No. The only limit agsize puts on extsize is that a single aligned
> extent can't be larger than half the AG size. Forced alignment and
> atomic writes don't change that.
> 

ok

Thanks,
John


