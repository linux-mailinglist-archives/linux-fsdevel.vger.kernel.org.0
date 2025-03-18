Return-Path: <linux-fsdevel+bounces-44290-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC122A66D9E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 09:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 376B97A4E83
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 08:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ECAC1EF365;
	Tue, 18 Mar 2025 08:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ntpeec2s";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="E2Q3Z3ix"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F31E1F4C89;
	Tue, 18 Mar 2025 08:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742285571; cv=fail; b=WhfQ5ntD/0FKYhtfOvTxRHBLRoFe3EcePCXyK1lHjM2nY/uiQR0c2SRRjNn0JCc9S+aF+mf40dUSzfUW/IlHDUyQBU2nfNh3lArGXoKCfhef+KeF9F6EbnidOTHlt7XTgLw1M44qHz07/A5b0eRUGxGXZ9MSfkfb6WtmWc5rHtE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742285571; c=relaxed/simple;
	bh=UN027s1nbi2OPd+JPB9vQitCyyMwgeEjiNRj6l09+jA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZkWQweAxqBXQp0wf595FwY9m9Y89qykN9tD5lOiOSN/E5y36thc52/rAs9AcV3DGEzFTGsPqJpzGH6SIfGqj7Y/b+l+YFTCZJmSbfs4j83ge3w6h2VXLA/OLlwPi0ZkGSsu0p5T7aJVCL2Ov0sA+fC1rqRyKvsMxkCZOOL2uWoo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ntpeec2s; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=E2Q3Z3ix; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52I7uVhN026000;
	Tue, 18 Mar 2025 08:12:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=A2gDKR5q0X769ofu/Zg/6Cy7B0AH0ySBH75eA9p8sII=; b=
	ntpeec2sR0B3YBbXIdMQHeo5CygolyUYJZ1Goa5AJ+0m/ByJLIiGiBkzWdKzJR7W
	bSA+vAydfxfCnsV1sXLcffX54/qVyfI69cxWM9sBGFEgXN7alxzPpPRV6vfQrZ/o
	LmaAp/xYtNJC6k5s78CA+Gw66oNd86SmqiRspKEntn/iJ9qNlbwXqiunqKKG5E90
	uogdA9FIunrJoFrcWo/pBAZARTsLqbdikJKIrv8MlL/OEh07CmXZgIjE729hfprP
	gMzXec3naSOJLj8SaVxqxJz1v9TNTCFxtKLkfgchshxYotHkwVb+IZ2uqG929UBy
	mEFY0Jn03SjIFiZnEiKWMA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45d1hfvks6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Mar 2025 08:12:39 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52I6UdFn022346;
	Tue, 18 Mar 2025 08:12:38 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45dxc58js5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Mar 2025 08:12:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YekLQ8KHF3R4MlF+hd+3Mc0Avt53eHy6J58V56xN+se9RVpSlBBgJIeW/M/gBpYE76Jrigraz9jINbKbPEqgp72sQI/ClfHcNrm4LXlZ9YXltat/ZnD++eoOBG8e5gHzJgHporITx16foOcqrY3DdjHMQLTccYiq6vhNTz5K88YdT0jul4ojyVRaemqYKytLwomMHRF8e1IryvZsHAJVU2uula65p2lt04MB5am8YskQVMPZVYuYoqJF38gioXa2pJI50zfTjvlP6HWacklvViobaOIW0C8YismaJxX4RI7xK8iD7HpirRgLevh2blRpe5JwM7BlQg5pG3Rilgd2IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A2gDKR5q0X769ofu/Zg/6Cy7B0AH0ySBH75eA9p8sII=;
 b=mm1kSPAyeG8UxT7azCzJVdLE2qnJGhddsavLL8ePrS3h7jEcpfrXvT37mvDlat/xzUhG8AqwWEK0pinA53ZyA/ASI08B8XpF2N7RLECNQFcUlPZdgyr2zW7YtYuZXWLWMOzeJeX05bbzxeFOY8A3QQ3bzf52dgnHDMkbIx1+Daf1QwFfS7qYUSzIMrwJiARkPlChdwTddJaF69d6eSthieG9BDmjwWl8kRXQU7Ax8d2fhoSPdQl7ubqB2aUrZrjFtLi5mvqmEe13kh9lLKjpZ1pOMFl5zREJd+dzYvMXfnsjvM+Cg/GCNe7Lfg+r43N+xNq4l0/PyAxKpZNKs8u1Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A2gDKR5q0X769ofu/Zg/6Cy7B0AH0ySBH75eA9p8sII=;
 b=E2Q3Z3ixQcvBwvo2OKq99IVf18wF6VH+Jroy5vKy9PMLlXeaPbENe7yz2ArDSsQWKeoUnhQZ1JzkjV8nCd+AgPYtJaR34CdQQC6JyWV49O32JMw4sKBwewZUJuVcgXXPPdm8H9yLKpHqnwxLe+M6CVU3O2GR0vSUGogOJUXPMXo=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by LV8PR10MB7799.namprd10.prod.outlook.com (2603:10b6:408:1ec::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 08:12:31 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 08:12:30 +0000
Message-ID: <abb87172-edce-4b81-a967-b79b061f0bae@oracle.com>
Date: Tue, 18 Mar 2025 08:12:28 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 04/13] xfs: pass flags to xfs_reflink_allocate_cow()
To: Christoph Hellwig <hch@lst.de>
Cc: brauner@kernel.org, djwong@kernel.org, cem@kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com, tytso@mit.edu,
        linux-ext4@vger.kernel.org
References: <20250313171310.1886394-1-john.g.garry@oracle.com>
 <20250313171310.1886394-5-john.g.garry@oracle.com>
 <20250317061523.GD27019@lst.de>
 <7c9b72fa-652a-44d5-9d51-85b609676901@oracle.com>
 <20250318053330.GB14470@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250318053330.GB14470@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0331.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18c::12) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|LV8PR10MB7799:EE_
X-MS-Office365-Filtering-Correlation-Id: a73d53f0-6977-49e8-8012-08dd65f4a11f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cmtGRGFiN3Z2SXArSnBYNEZqM001ZTQzTk54bS9sK3pYVlVhZlJ5WGVlNTh0?=
 =?utf-8?B?NUtqQ0UxaEtkRFFjNFJpZVZmYmx1aEQwUkNPN1BCU0poRm80NGVqVkpoMFhl?=
 =?utf-8?B?dzlDbzRWNkljQ2h4KzNZL0E1ejlFS21MMy9zNVY0bTJ0WG1JYWFva1RsWXpG?=
 =?utf-8?B?YW5HaXprM1JwL1AxRmJOaEJHMmVYZUtlZW5oNnVTSm1jRmJsY2NBNVkrWU14?=
 =?utf-8?B?aGtZOFdZckFEeS8xb1Fvc1FhOXNYcFQvZFJBZW1YWVJsUU53YTNRS3hsSVBt?=
 =?utf-8?B?dk9pS1J2MWM3K2ZSNjYrbURCOCs3NWpwOXVvN1ZnQ0hzVEdLQ2hkUXgwVWRF?=
 =?utf-8?B?Y1dsd2RxdFBTK3NVZjJpS0tsMi9KZEFNaEljVXY4QTBXOFhVRERLOUFpbElQ?=
 =?utf-8?B?S0hwU21WZWN0K2hIazNQRnNRS2IrUjR5ME5lK0xNVmtTdXhnc2kxRG1xa200?=
 =?utf-8?B?aUpZMWV5U1UzNStpcDJvNVVvbGxPMTBPRFpyTFB1YWI5OEFReVI3SkJQYXNI?=
 =?utf-8?B?Um9YalhVb1FvNzBOVjV6cjZoeVZIV2lrUjByMkcvUmY5RVF3RFFvTUtTTWND?=
 =?utf-8?B?TEp6SDJwVzdGdDB3aVNsQkZYaGFCUkI2NDhONDcwM3ZhKzF4MjZLU1pUOS9B?=
 =?utf-8?B?OFZMcytNd0tCTHlESHBNQjZ3NGpYTFJQUjQ2TFRnNE82U2JkenA4eDVjcFR5?=
 =?utf-8?B?Wnd2M2VqaGxoOG1aUE8xaHhqMmU2VHVxTytmczcxUjdubGEwNFVRNGlDTlY2?=
 =?utf-8?B?VXBRMG9WaWk3MDZqcDVlRFFTQWNvdU5NR2o1eHJxZm90WmhoS0ordHpzc1No?=
 =?utf-8?B?cjFlSG5SeERGQ3FrbFFRWUlQaFJTbUhlUE42NjU2LzBBYW1jQjhUQktUdTkx?=
 =?utf-8?B?Qjg1ekNZZTYzczhGSHVoWldKSFRrSlpudHRpVzdSZWlQNWhwWXNiR2tSeHJW?=
 =?utf-8?B?azBZeWJVMGgwWjdZNStVdGwrc3dYWG9rOXVFMy91WWF2UlI0Wmt4eTByMm1v?=
 =?utf-8?B?Tm9melBEUitobDlJVmhWRFR0OUxFVnA1TjNOdzhReXlRUGEzc3haVFZqdStl?=
 =?utf-8?B?M3pydk9DV3FwRWFzS204VXdXa092T1lvelZwY2FiMjhZa0FLRHBvQkkrVkx4?=
 =?utf-8?B?UE5IUThhY3lIbTNXdXB5UXNsVGQ2TE1Ib3ZTYVhaRWVpS2lZcjVMV0tDZElR?=
 =?utf-8?B?Y0dLaXF6c04wVW5ZNmdyNXlVZ0p5U2Q5YUNOTXZxZG93bUdRdkp6bG92ejli?=
 =?utf-8?B?bTl0UzFXWldEN2hlNDg1NHNwbkVWOGZtK3JuYWVwazd0dU5ZQTJ5UFp6c1dp?=
 =?utf-8?B?b2ZVSFUxTFU1L0pzcDRWN08rZWltRE5PTk11a2NFTFMrcGMrdFdGWDJYWEVw?=
 =?utf-8?B?dUkrRXRDRm1NSW5xQndyTk1GcWYrcXJSaEh6ZnFZZ215UkdEeUZkTE8vWTdJ?=
 =?utf-8?B?M2VsUEJ4OFhpZzI2NHNZandCSG4wR0RYYmV5V3Y4TXhxM00zMmZXS0U4S2t2?=
 =?utf-8?B?dU1lWE9PRHNLT05wemljWllJd3BwOWhiM3M0Q0lydjBRcnB1S2k4RkU3Z1FT?=
 =?utf-8?B?bnJUbGlLZmFGeC92UjllbURmcXhxTEdDa1hOWm9Fc1RpNmhGVlJBSHBEM3p1?=
 =?utf-8?B?dE9tbzZJcFNWV1VwZmNOOEE1RU4rRjYzalV5QXlWOFVjU01NKzI5dGYyWTcy?=
 =?utf-8?B?cjJNUmFlK0htWGYvU2hKL1J4bXJsMmZGekFQUEY5Uzl1SUtOTG5OU3pyUXpH?=
 =?utf-8?B?ZmRObW5mM1UwRmU2dHpZVGNkdzNMeER4c0czSWdpWGdDSENGOURONURsSkVM?=
 =?utf-8?B?SlUrMlhpUEErYmc2aE5ydGo1Zmpqc2dvNFFHMnR0eG13LzBxWVpxc1dFM0VV?=
 =?utf-8?Q?0rkS36+vwMPPx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N0pnWG8wbEJ5ZDF0NnYxc3k1RkRtaDZLUVgzbkNYL2syeGt5amVhdldmUmM3?=
 =?utf-8?B?SmU4MkZaK3pkdHZJcFNaV0tjRU1HTHVkVkp2dm5SZ1FBOFFMOUhRSElkSUdp?=
 =?utf-8?B?dHRpUnJmSURtVHpwUmJtRC9LRHNvcndpRmMvMXlWL2c3V3pnWTRFRnRMbHhS?=
 =?utf-8?B?ZFhkUWcrRkQzU3RoRE1yWVZxeGtZaHpEQm9UNTk5M1Jsa251OFpSZjhmVFdo?=
 =?utf-8?B?NnZLYXpOdkp3cmkvT2NycFdHbStrOHBPTmRDdkM1eDdsMlVKbWdOaHJQOXB2?=
 =?utf-8?B?cHMwT05MLzk0eFpOYzgvQW8vMkg1R21yMzB4NlVNWURnQ3Y1RG5IWFVxWndY?=
 =?utf-8?B?bEorbmJoU2RicUZodEkxa2J0emRnZHBJcU0rMXhac3ZOQTJDSVFFYnRidGhK?=
 =?utf-8?B?dTRlVWJKZisrVTRxb0E1QnVCT3l6SVkxVlRUand5dG5qQS9RODVad1ZsS3o2?=
 =?utf-8?B?OHREWmVRZjE2d2Qya2hhNjRjbjNBZ0pRREVrUlFmczhoTWNWRGxDZ3JtQWg0?=
 =?utf-8?B?RnoxVFZxZTZLQmZSQjdOdnBFb2pXeFpLU3pJSEVzT2ozeTVmTzlxakRWQmto?=
 =?utf-8?B?ZlJPdmEwSjBKU0lDNTd0cmRVV3NRUXJ5akhwQ3hieU9oczdnajU1Vk9GOFNv?=
 =?utf-8?B?UWJtQ1orL1Nrd3NKekhOSzBaSFY4SnFaS05VVnF4cVpqdW5JSmEvVFJvMmJr?=
 =?utf-8?B?Q1IrWW03QmxQRlZzemNVTitZZXQ1VUZVbDRHbjNkckw2ZDdDTFFsd290NUdy?=
 =?utf-8?B?aHl6dWRuR1l4Sm5ZYzY1MnpaY3IvTnBCWjlCaENZS3Q1WmJnU0wwS1hnc0FL?=
 =?utf-8?B?QUd6ZWl1NWlZNjZpaVZsLzkrSHFyc1VBUVBFVk9SWmp5S0YzcEtNTHZuL1VY?=
 =?utf-8?B?Mkdxd3kyM2JtRVowNkNBZ0lFT1I2S3gxaTlxU0t1Z0VsLzVNSWpxd1kxSW9Z?=
 =?utf-8?B?ek5XVnNwTnZqQlZvWUJmbStTQk1TMUhRZjBvWTV6T3o0a2NvbW55WXVOZy9m?=
 =?utf-8?B?RmtCUHB0bHl6dEVmQjBsM21YK3l3cThVbDZGSmRBSjk4YnMyNGhRalBsQ2cw?=
 =?utf-8?B?RFdDYW1hUXVBZC8zVXVtZXJsRnhnajhEa0MwYnVETFUrczV3aFlsM2F0VTM0?=
 =?utf-8?B?QzdXVU02ekZxUThUbjZCUmtWTjk0VUE5WGFaeTN1aWRodUxOQ1djT3E5eFZI?=
 =?utf-8?B?R1czd3hCbkx0QXN4SXFqVzJLOTNrWGQyTnpVOXBJbmtOdXZZZDlTUVdFWSsx?=
 =?utf-8?B?cklxcmczanlXRWhiR3RIYXpwN0RaVUtDSDE4SW05bjh6ZVNEemVyWi9VNFpS?=
 =?utf-8?B?dWdEUmtDdGpvRkRwdHFMNXRORnZqclo0U2Q1dHhqQ1RZMXBScDAvK1BhNERz?=
 =?utf-8?B?Q0VKa2w4aVVOUVFRS2NUd0g3SkxPcENaSEhuT29QUjFacEFxTjVVVWtHZVNs?=
 =?utf-8?B?cXNTRDUvNGZTazJhT1MvT1hjcW9UanhLeW0xNkFFbGsxUGJVVHBxL2FQZjVk?=
 =?utf-8?B?aTZITkR2NFZKdHA0V0IzZVNCb2hNYmw2TFZBQkhBdmtNb1dJeVJVMG1zV3Bs?=
 =?utf-8?B?c3JBRFgxZHhmSDNXK3FqVzBOQ3pxMnl4OWhtL1JySlRIMzJvcGtEUEhQS3dN?=
 =?utf-8?B?YjlMaWJkYk9OanU2NXNBcVhFb2tWMEd2d3UzL1RWVjNjVDI0cTIzZXdEcmxN?=
 =?utf-8?B?TFpmOTBWdEk5d3BMdlZ3UHFtNWlXN2h1SnB3U05hazk2OXd1NWgzaGhkVHRs?=
 =?utf-8?B?eGRXdDVUcU9abGt6RlBPWWszWHJQQ0JVNHpaeEtXbDZmZTc5K1ByNmV4blhN?=
 =?utf-8?B?T2dRQ0w1S2dHOHBQSllDOHVwZDhoNHREK2dnL0xFYnVuSXMrdG9Zb3BYWkdQ?=
 =?utf-8?B?MmJ3cXZoYXNuclczTUROSWpScGw5ckV4SUNMS0FTWGlJenRLL2V1ZitReFZJ?=
 =?utf-8?B?RytieElDb3BHSC9HYzg1dzF3aW8rK3RRSnFBTnFISjRQWlp5bzNIMHQ1cExL?=
 =?utf-8?B?Q1FMekUzeDZsc0tXcVNXZ3lYY2EzUlltUEU5cDIxUC9yZ0lTUGVHY3FZblRT?=
 =?utf-8?B?SnU4ZE9yWmFsRXB2YnoyMml0MWRJWEtaeEltRGlJYVNFRXRwZU9GV0JDbEln?=
 =?utf-8?B?ejhNSE5pbEpKZjdKRWJoa0xjZ3RFanphcDNadmh5ZDFzLzFraVh5Vk10Y3lZ?=
 =?utf-8?B?Ync9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3JXGVUkEiUZLdEQ3wpucOGmiFtT0ZSDlsy/XwZH0VGMqi+1nADt2goMuLq5B+fkTKIkGQC/3opkq8s36jFuKxobKh5GBrDIGUxCPKtK5sbj6YqHzFaFXQ2k4JN/K+JRv8qshyzeespQO9+nFX9/IihSh0Z0V/SLuwcPwHTMAHdKoZHGwQkBiaTwZhI4UnSaFMS9i3pACxNoSOT6QP4iZSDdd132eRkVNf0eTkJ2jbrjAqlCPyqzNta3vgSgCpXqwLX/FlYoDpAFbeuY0lLqPNGBDP7vLn9qbDrVCSoREn/OGci0IwoSMv/ts1eEzIjj0+NoMNcOgkEhkvJGNZMoDA9UuUH/eAutyc6Hgy/H1XCEofrh3n4T86ofRhWyplVy39H9gbFEaixSRHEZxLVtcwtMadwPgYreNzxoYSiq4eWYH26P2Ee6Bg3SETrQiKuij6JpaYOR+FSzIUQlhdmF6aZgu6uW8mmlo25tIMISmcjbI7BGXo9LrujbrJmC1LQpX8F+Ze967TlgkxHfohxhucZXvZJgTpK9PlORsrXgRrawftBzFDzc8ozRlKZ+mq4cH/Udrph9zU04C1DChiHfnUZs4wGdK8fR9JPX+odi58B0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a73d53f0-6977-49e8-8012-08dd65f4a11f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 08:12:30.8824
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hgiOr9gGpevJWC5VAcXROES7VzuUMtpoOgIhftfTmTR2HIh5AUrUIsIvslJpZMq3FAKF2TgsOTk4qHzVh6bPpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7799
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-18_04,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 malwarescore=0 adultscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503180057
X-Proofpoint-GUID: 4zm7wZ-MqGDkT68QJGb42EQuUG0_NlyJ
X-Proofpoint-ORIG-GUID: 4zm7wZ-MqGDkT68QJGb42EQuUG0_NlyJ

On 18/03/2025 05:33, Christoph Hellwig wrote:
> On Mon, Mar 17, 2025 at 09:17:10AM +0000, John Garry wrote:
>>>
>>> Given that this is where the policy is implemented now, this comment:
>>>
>>> 	/*
>>> 	 * COW fork extents are supposed to remain unwritten until we're ready
>>>            * to initiate a disk write.  For direct I/O we are going to write the
>>> 	 * data and need the conversion, but for buffered writes we're done.
>>>            */
>>>
>>> from xfs_reflink_convert_unwritten should probably move here now.
>>
>> ok, fine, I can relocate this comment to xfs_direct_write_iomap_begin(),
>> but please let me know if you prefer an rewording.
> 
> I have to admit I found the wording a bit odd, but I failed to come up
> with something significantly better.
> 
maybe when you see the code, you could have a better suggestion, but 
I'll keep the wording the same verbatim for now.


