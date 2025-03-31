Return-Path: <linux-fsdevel+bounces-45381-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE012A76CD7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 20:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FBA93AA646
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 18:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C7A215773;
	Mon, 31 Mar 2025 18:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="P9Oo3VUx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mGA1W0m/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C3A145A03;
	Mon, 31 Mar 2025 18:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743445336; cv=fail; b=mU8VW4vwxtQrHoYK7NnzP9r6ip5b6mr5vtL0Dnx4tXAktQPBYCsQtuRAXTZ7BYID1hwHAQBlEpFSioQdMyYouAReyCNJH1097NnBXF46+2ORx1+WrY5riNcWuP54xf4HHL0Nh/H+SGOIFlbhIdzvNjKHSjhYVteARrIAtAeJpaw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743445336; c=relaxed/simple;
	bh=i/bJbbCWRb1xnd9gUmcLJw8jEASVGwqh7Uz8DBVX2hU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=M66QHrrbp+8lT3MMO3WcXNSdjO75Hk8vUsdvXxAcgKhU98kI9p+m/lbfKC4hh7j0izsRv5ezrSHthLjb2lFHyUYmpiLN23lEHWw+qyCnjD+EyOc/wso+TS/bxbMC4GKy54PyH8uzA/iIwHLSPL3h9C4RBqpHfV6KsgWg9MXUTqw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=P9Oo3VUx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mGA1W0m/; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52VICnOD003126;
	Mon, 31 Mar 2025 18:21:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=UzWW+0aVncBVMrOO44bWxG4C/JY7SBmaJy3dtWWxRB0=; b=
	P9Oo3VUxIRD/lL5rvmUJyd4NDwYFjSSYNH1pReENuxve0lq34EFDDUN3j79N4IH2
	Z0hUQ1Xk18ZIIE9kCrnFOAKsGuzyIRang8Y6WVquWWL5o/Sn9jzg7bzbNNvEuiwY
	enVjszXXbklr5mINV0oEy0AiahcrMDIY8SkNF9/rh2mSLJ6AY/kJ9t5jazMP5G8e
	Ytm/9iHIW55eMnzOW9RfEbYUZoTqzJl9szKzzJHo74iJy81GyA4Y9d5SUN3TRndj
	AgOiA4LJpMn10aC26Qf2zGHU6lr2bvFnbqz53LO1Imh8kc80crQ1eMQF0qIvkdfv
	sRt4tk4PSD3v1DGcW6wT2Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45p8fs3vfb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Mar 2025 18:21:55 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52VHd9Xs017277;
	Mon, 31 Mar 2025 18:21:54 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45p7a80pse-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Mar 2025 18:21:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IMee4FslQDafeu+USLN34O0ogvD4NSPiU/v3h5+q8U4vMQ1v3Gysi5ZL+JPyTwCSvcmPiHlVlsHDQmFU3A2XXRu6khyOSEy/6sqW8yzak0qUF39rqzyjejCJnOMNuVfm168jOYjlP4qo9RSB+3gRXzJ0eC+/PLatMQrC3unNwNIdI93pUlf9voQ6UC+kohp14QNFsUfRGPsiH/u5+KEY/IPpsU4aeMUwaxfF7uYO1Ihf7YJcxh0mCsQRqTSmaJXw8slEGJ0OFWg1dmm4zWeeZd6XuJu5iEla6blcBmKuEaMIqfn7nKkF94N2hE6vhCjBAiRYiUdRTWfw9+qQx8Bt9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UzWW+0aVncBVMrOO44bWxG4C/JY7SBmaJy3dtWWxRB0=;
 b=JlTeFcSFxVd5fj+P01216hX+H1ZDDAvH2CUQbnsJ9qJferI2AZ16BojcuCGuddvPkFMdKT+d/dIjfFSdZa3+0ItJ11szB302V4/iePaR7X9hSCtZo7HVfhMt9TUTeEUPFajOeHcjwOwhqU7YCQqbmibsQgkcfFiQDFxgT0pn6jzmz3UET/zCIZVDt1PhYop9rr6SHmJFGLp1gdlrn6KmxcSUzgfMcm8NwUwqhUt4b++331MMHF4UWuDOseHfW1w/JE0lXHEm3clp9BhVzHWrlzdOuR44ZFbhwaNd2GmDEdxRoEkLTlYdqATEmLCxRDj8uJvn9P7lPWTuoFR4qGItEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UzWW+0aVncBVMrOO44bWxG4C/JY7SBmaJy3dtWWxRB0=;
 b=mGA1W0m/P6CEDA7JDQN8EkPZ/ldcwUvgA3Pw5rFVhJTwXS+TJOoLivSoKRbBU788DH02q5b/H2ncCR7zqbp8nx0b637BoDOS3mE9nfXhi350TOjI3hspm285/FmX2pkWhF3W84xoJM6jylT5N7wiDPgEccrx6svce3frOneX5ys=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by IA3PR10MB8441.namprd10.prod.outlook.com (2603:10b6:208:581::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.36; Mon, 31 Mar
 2025 18:21:52 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2%5]) with mapi id 15.20.8583.038; Mon, 31 Mar 2025
 18:21:52 +0000
Message-ID: <a79a9854-5449-4460-ab57-214c51095f10@oracle.com>
Date: Mon, 31 Mar 2025 14:21:50 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] radix-tree: add missing cleanup.h
To: Daniel Gomez <da.gomez@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Ravi Bangoria <ravi.bangoria@amd.com>,
        Matthew Wilcox <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, gost.dev@samsung.com,
        Daniel Gomez <da.gomez@samsung.com>
References: <20250321-fix-radix-tree-build-v1-1-838a1e6540e2@samsung.com>
Content-Language: en-US
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
In-Reply-To: <20250321-fix-radix-tree-build-v1-1-838a1e6540e2@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR02CA0034.namprd02.prod.outlook.com
 (2603:10b6:207:3c::47) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|IA3PR10MB8441:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f3a0dc7-23bc-4b46-fef5-08dd7080e928
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Wk1nYmlNeUFTOTE1R2VoTjZkWGxUaEZWYjQ5cTIwa0JLNkF1RDFXS0RwbFlh?=
 =?utf-8?B?ZlBXbDU0Y1ErV0EzYkxGa3ZxalVURnd0eHZXMFFMZ0x6MFpkYmJLQ2FKZFRD?=
 =?utf-8?B?ZFFoMHRiZVVPelBEU2VPbURYdW5CQy8rRURBNXYrM1VNRnNnOTl5TzhndHJO?=
 =?utf-8?B?MWR1Zk9JNFI4OVB1S2FhUjZQQnVXUldPUkVZQUhFajAyVStsWS9SMXdESWpm?=
 =?utf-8?B?am85TUhZUHJlSU12UnZQZXVTMzdCRDdwVDR5RnUyYnI5UlJzMW9nWEFQYmxX?=
 =?utf-8?B?WnE2UTBRbFhYcjMzekJrSWhCZFBLUms4Q25HOGwrY1lZZC9qU29UcnVRMVN6?=
 =?utf-8?B?RmJHZUxtcGFRaDVRZVQyalBUdmtoNFJkdFY0ZjZYa0xxU01UMXRiV1QrYXlT?=
 =?utf-8?B?NUNNZmE5U1J6TTJOVndjampNeTJGbUszangrOXd2SkYwZ2NTelZKWWdGeHFa?=
 =?utf-8?B?UkFEclMrckgxdFZqcHFoY25rc2NvOFJ4RTYxTG0wTDdnWGZRd2cwL0dlQ25x?=
 =?utf-8?B?bWFIRENXMFNZQ2l1aGw0cXFxRmNIeldBN1NoUFRXUHphcG5SWXRXSXVxRTZ5?=
 =?utf-8?B?YkFKRGxSZVBYRVVPZjJhR1ZwTUNOVkgzTGlrZWpsWWFtYmMvY21LUXVoa3Nh?=
 =?utf-8?B?ZW1FSzNRSm16M0o3ZHBKNm15WlJRbExRN1ZlUlRhQnk2QlNzU041TU56dmUv?=
 =?utf-8?B?US9Ca0VHTXhXZ21jVWJWOHF3eFMrU2puYVAzaEJRK2ZMWjV0Mzd4V1AzWWFP?=
 =?utf-8?B?UVYxU3VwQlBCSjlUY3dOYTlQUi9wZ3pMV0l3M011Q2diL21DUktZUHlablZW?=
 =?utf-8?B?RDlobGJQbXZiUVpsRDVHUWUrbmhxNGQyM0F1YjBBcHRGOGxOWmNFdHllYlR3?=
 =?utf-8?B?NFNEY0IrR1FlaEYxNDFDd29yRERyVHh0VGFmYVBkaW9oQXlGenJwWk9xdnRD?=
 =?utf-8?B?bDdJNWs1QzVmMVhvSUdqQWkrVXdHM3lHdURUY1BLaEdFdkN2UWkvcGxZYWt6?=
 =?utf-8?B?dU94Mm5QanlSR3BOM0Q3bVIvUWtoSWU4ZFRsR1FFeWQ3ZUU5UlZZcmpoUEVU?=
 =?utf-8?B?dVR0TXV1N1BjbFhlWXEwYzIxUUZ0MWtwcWpOVE1qaWNHY3RCV2p3ZE1HNk1h?=
 =?utf-8?B?blNvZGh0eGJCK1M4eWxjbC9VWXFSdW9iQjllY1dPd0hIUGh1Ky94ZEk1OWdN?=
 =?utf-8?B?WGROM3k3SUlab21ZZ3Q4cTBCNzJLaVM5VmlPL0F6Nllyc0xkRDMwTXZLY21N?=
 =?utf-8?B?aUFxVWtMd3RzSmdiWnpjM3gvb1RaVEptTjZvRm0yZHROaVV6Z0dNRmhMcGZJ?=
 =?utf-8?B?ekRwdHhxdUl3M1pXdUlDT3JJcEFidi9qSWVTNjhGdlhuVU5TdWhGOUxtdHZS?=
 =?utf-8?B?TVh2cUN2bjJ2b01rUGxRMTJUaWNMRi9ZWkJyR240Zjkyenh4NmZucGplRFlF?=
 =?utf-8?B?MUcxWFd4Y3NTKzFnYS9zRTE1ckM5by9Rb1AyMDgrNWo1c2cxbzhnK0JZeGlh?=
 =?utf-8?B?a25PUXI3SEJxRUQ4RkNjRHh4RzZndTA4UnJJWFJVVE9MVkpVcjFudTV0OTBp?=
 =?utf-8?B?T3NremMwd0lBcFdoaE9BUjA4b0xYNS9CaUdSenRSalNUenNST3hyOGVVYUhI?=
 =?utf-8?B?bTBaM29ON2VMNWRHTmhrRDNRNDBDcHJNVGVJekJGTFJKWUVXMTB0YWpISFIw?=
 =?utf-8?B?bDlKcHpiWW5aZHhCcS9lNzFHdXNMQ0NLWDA1WEVkeGY2Zm1Ja3NScU03WU83?=
 =?utf-8?B?RlFZc08wZWkvWnFlcUJrck5IRzhKTVhiYnRTUnNxRlI3bDdkR09NQU5SWTJI?=
 =?utf-8?B?TkV3dDlYZHFMdUI0YmJaVDRIS0wvaDhaQzBSN3hwZGNzWlZ6Y1pOVTRldnZM?=
 =?utf-8?B?OEZZSFFSbDVYQTJOdmRNNVM2c0wvWjZ4L1hiMWtieWF3SEcrMWdDNlJlVTRl?=
 =?utf-8?Q?7caaTNwq5KU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z2MyRG1iWXJYYlBtZE81YklWRDAzVVRXNVpXb1FtRHVKY1RWR2I4a3VEMGNB?=
 =?utf-8?B?enBtYjZia205empNV2hBTE9heGJ5d3pSYWsyTmNOSTFlRXBuVVNpdzNCWVZL?=
 =?utf-8?B?UVdlUFZMYXZvNWkrajdqY2cvYllFR01FMjJpbko1c0F3K2gxY0E3bU0zVnVU?=
 =?utf-8?B?S3hKNDlkQ0FNM3FnNGNRSllWRWI4cXc3UHpkYmo4R3ZJTEVDb1k5dmFPbUQr?=
 =?utf-8?B?UGZCU2toVEpsSTRTVWkyYkRhSjcxdUM3Vll1aWU1Uzk1ZzQvYVhuWnp3YXpx?=
 =?utf-8?B?RVBJOEVaWXZ0SEExcUFNYUNrczRkdEw0RmtLVlZmbXl3WHcxWFJjRjZ5M25P?=
 =?utf-8?B?ejJTb2duYVJYSkg4N0xzQVUrT0VOcSs3NFd5cEpNLzB2ZzFtbVh2Unc2eGI5?=
 =?utf-8?B?R1VLNi8ra0R6Q3lOMVJTSTFmVmxsY1VpeFhYc3hpNmhmME9remVGL0dIOGtR?=
 =?utf-8?B?c2xjQ2NIK2V5TjkzaHB6TitMbjNzbmZINmExNXhoVFUxVnFVQko3Tyt0QVdM?=
 =?utf-8?B?ZThrUm9mOStYUFN3OFJ5MUwrT0FiZ1QxQ050NXM3d3g5Q2dEZ2EweW5ZU1lp?=
 =?utf-8?B?RnVoeFF0cmlrWnJPaTZ0M2UwTEVXY0ozdkdtQjJ1T0hSZGFIWHFaZTBrWFZy?=
 =?utf-8?B?RXdxWlM4T3l2RXp2eWRYdUMwaU9hU3VzWjVHYjhqVHpVSG0xVjlYa28zeE9s?=
 =?utf-8?B?blBlSnVxN1pyK0VuY3EzeTZNdTVoUmdZeHBYYWt3YkJWdEVFVmZ0MWRtR1dB?=
 =?utf-8?B?T1BlZWRTWm1jMGJsNUttUTdvQzNhZHBqeEg1MXpHdlFBZHRya1FqanhwdUp2?=
 =?utf-8?B?bnVwRE12Nk5xREpsNzJheGJ0OVJtMG1nQnNRN2c2VWl3RUFrcDQ2NGM3NHRr?=
 =?utf-8?B?b3pXaTl3VjJSRnpCemgxby9qdVhheDJqMGQwNUJjMnY2bzJHR0JmOEQ1aFdz?=
 =?utf-8?B?eWdqcmRKbjZKcFh3WkJnU25KTzhHZEw1STh3UGhVNUxNZEdwYitDNG9aRDlH?=
 =?utf-8?B?WklENnVzVnZDek5xQUtzMGk0aDgwUXpZUWIxNFpzL295Sy9jNUFVSWNHT2h3?=
 =?utf-8?B?UTRCdWNNK0Z6VFZSKzBPQVdVSWFEVm45cHJaQ1RoMFRyN0VIQkR5UmZBQUlW?=
 =?utf-8?B?UGY3anhmMTZnMVRWSFdMZUlrR0F3Y0RHbVhjUTFaRmpBQVBBT1dRQVRDS2ZO?=
 =?utf-8?B?cWpwODgvY0VHRGd4RHE2TVRnN0ZqVXFMTm1tQ0JBakVjMGlQK1RoaW10aHZR?=
 =?utf-8?B?U1JSL0dIUGtRNDFydWhaM242NS82aTJDQWpNSlJ6NGhJa2ptd0Zra29RRXEz?=
 =?utf-8?B?WnltS3Z6RXpUZGdPbjE0WTBBdUNqVFJPcFlybEFrU3dkOHdySlJlVVRRekpz?=
 =?utf-8?B?YjBOZ2t3QU50a1J2NkNvcUhRcmN0bFRFNjNwdTh6cFlSc2ZXRnVMWTdNcXpC?=
 =?utf-8?B?ZE14SC9RaEwzUS8zN0ZVOGxzUU16Rk5nOGdKSG1FeFk0TitxVkd2cHRuQ1hN?=
 =?utf-8?B?U1FVNExkUnZPeGpOUkszSHZnM1BrWWR5Tk9xZys2ZW9ZU0RKYy9lSGxCaTNE?=
 =?utf-8?B?d1IzL2c2SE5RNTZocy9qdWRVbU1vM3V0UElwNkdMellsWE9oaDkyQ3A0V2pD?=
 =?utf-8?B?RE5kazUvYU1ISjlYVUZVempnTk9uSEVyV0dBYlNxcFRaTmdQR1hUei82c0lh?=
 =?utf-8?B?QmVrc1VEOWRLM25VdlJhMG1YeEFhbTBaTExWTDhrbFVWNjVKeXB6YzZrcnI5?=
 =?utf-8?B?aC9PdHhodEkveDlxallVQlJpaFZNWGx1NFl0OWpLbFZLVERyRmVMbjl0WFlS?=
 =?utf-8?B?KzBuelYzREhQM1ZubnFBK2YwcHIxUkNFa2pqZmlBT0s1cmF2OWtZNVZ1VWlw?=
 =?utf-8?B?QTErbm5WRm5BR3JIVmQ2RThmV2JyRW5Ca0hwVjhuazMwenF0VFFzSTJmZ3lF?=
 =?utf-8?B?MU83UjhiNXYybmFmcFdwZklZcGJ6bTZiUzRhN0NPc2F1VjF4L2hmbk5KRXNk?=
 =?utf-8?B?b0VmaDZMbmd1REtrVUJGSTJSUmV0NEV3RWF3WlRyRVcrcFNNSjcyYVpRQXR2?=
 =?utf-8?B?YURBL05LRnp4S2JPMm1KeGMwdHFSa1krWEhwbllnMWI1OHRGOEgxSnBKY2Yw?=
 =?utf-8?B?VDZFYmxiZGNadmRTMngvVElZbFZqK0R3M3lhTEVNL3lUTjVsOGwzRnhEVDlp?=
 =?utf-8?B?RUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4DJooufRQFifnH9yNRnJ9pjVqggipJ2jXC5aGwEmKtGUY1IXFKHFu6br6sSfZzMHEet2xbNWFGmFBZWGKO3PEamMsDB8i5N9oiQd41omjB2+pTn+/XMn9ZczVchOuU78kJu5A66AS4z1yrU1hVd1cIg3q/vilcfaO2Y2jyREdisnCCofJ35WnL1/5/8hjYGZVBUH0uPot8Qg8G2ruaaJCgmtJWpu6Pnp25ZmLux3Fz3CwkqciVD/oDr3sWCoKYAlOt+qjbH8WCIP6ikZjEVwbYM/RDuSEWLp0BbhzTREhc3XN8WU8SGeYYBYWyhkhh9bxxhNXHKf4HSOw47yervb3AQVd/cyyNKueNPEzPSyxHBak5UvuIz+mctrwTC8S9NjFiIMCjHERBMk6aqV5BKrqwUuNp/8KrWFzAjDwyXTQO53gMW7+17PC2M/NLyJyIqFWu/JBR832824rGrcOuqSkIP0UhTdO1n+ITLeVsmW2MSPH12m1lgExDIrb5YS+YKB8W1fs1iu4ixX6d6n2FcznT2v3Lux6qDD4sl0DtBbrd2h0uSuuJmfQ1FFqdxTU5Ztps493ihHKrYdaJK2pq9YeR1fJrMN/3pueqGmXZVFi1g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f3a0dc7-23bc-4b46-fef5-08dd7080e928
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 18:21:52.7957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J6oIHz5pRskE2p8fVT4f666IGNSoqwk64j86kT+nToe7pcqYDHLIKm08vJ4YmM5vDuEY6QA7ztrpEolX6HQ1/J9KLMXUuqv50i7fj/hUjdI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8441
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-31_08,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 phishscore=0 mlxlogscore=999 suspectscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503310129
X-Proofpoint-ORIG-GUID: iasjtNKfZzW7E2rC8bQzd-R2ROvoFKyH
X-Proofpoint-GUID: iasjtNKfZzW7E2rC8bQzd-R2ROvoFKyH

On 3/21/25 4:24 PM, Daniel Gomez wrote:
> From: Daniel Gomez <da.gomez@samsung.com>
> 
> Add shared cleanup.h header for radix-tree testing tools.
> 
> Fixes build error found with kdevops [1]:
> 
> cc -I../shared -I. -I../../include -I../../../lib -g -Og -Wall
> -D_LGPL_SOURCE -fsanitize=address -fsanitize=undefined   -c -o
> radix-tree.o radix-tree.c
> In file included from ../shared/linux/idr.h:1,
>                   from radix-tree.c:18:
> ../shared/linux/../../../../include/linux/idr.h:18:10: fatal error:
> linux/cleanup.h: No such file or directory
>     18 | #include <linux/cleanup.h>
>        |          ^~~~~~~~~~~~~~~~~
> compilation terminated.
> make: *** [<builtin>: radix-tree.o] Error 1
> 
> [1] https://github.com/linux-kdevops/kdevops
> https://github.com/linux-kdevops/linux-mm-kpd/
> actions/runs/13971648496/job/39114756401
> 

This link seems to be broken.

> Fixes: 6c8b0b835f00 ("perf/core: Simplify perf_pmu_register()")
> 
> Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
> ---
>   tools/testing/shared/linux/cleanup.h | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/tools/testing/shared/linux/cleanup.h b/tools/testing/shared/linux/cleanup.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..6e1691f56e300b498c16647bb4b91d8c8be9c3eb
> --- /dev/null
> +++ b/tools/testing/shared/linux/cleanup.h
> @@ -0,0 +1,7 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _TEST_CLEANUP_H
> +#define _TEST_CLEANUP_H

are these header guards needed?

> +
> +#include "../../../../include/linux/cleanup.h"
> +
> +#endif /* _TEST_CLEANUP_H */
> 
> ---
> base-commit: 9388ec571cb1adba59d1cded2300eeb11827679c
> change-id: 20250321-fix-radix-tree-build-28e21dd4a64b
> 
> Best regards,

Tested-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Reviewed-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>


