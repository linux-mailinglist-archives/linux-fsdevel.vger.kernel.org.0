Return-Path: <linux-fsdevel+bounces-39734-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02E27A1733B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 20:44:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F8453A74E2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 19:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935271EF0AA;
	Mon, 20 Jan 2025 19:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HDi7w8YK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HYZEC+fU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3001EF0A5;
	Mon, 20 Jan 2025 19:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737402262; cv=fail; b=NKsCiNVP/l/kSTg7AZkPzGjFtcjmjKlnff4ERHuoM64UiZCSKVcxduTAL1uHoC8wGrTPr9jaqcaEvdtwuMzvIOxgISHCyQ+U85mYHuPhwA+f/SGOlzFB12XAmalYKzhGxRByTX4+sO1YSo7ZDzAWRji8StyA+jGvaubhvOLwj30=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737402262; c=relaxed/simple;
	bh=dVcUxGVx3akgvu/CCErI0e10R5a4G9beMPTpPvKy6T0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=e2O32VSBLA0KiqkfQJUpmN/E1O54Nk5cPAquR5LG5GinQwQN2B8LHX653Gx0jiUJSBE0MNKuJ1AngoIsxO5ZjNCb9j4rSNJp1XfPTMmo5KrNGi2bjKCx0iVJUsh4NaaCvlwr1D35yXMZzABYsn3oN2TwgLYbaMPek/C6Q16zweQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HDi7w8YK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HYZEC+fU; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50KGMtY9024911;
	Mon, 20 Jan 2025 19:44:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=fLA55I8WdqaLxNMjxf7W6k2U2ZsujZqa43m0wWYvqQg=; b=
	HDi7w8YK263KVkIIh92nfSVKz3EDVMeUGARu/FNK/ofc8YwsG0oKQjpKTHkBNSaN
	ZHvupgpV2DytUyDCxtxYujHcBscBaQlMb1eYabzVg+XY+ftE0iGqpq08mgN1bv5B
	gESodN8xRJJ8pnyl0Rq8lom295c3vxQTFgpv60M6byNuHfj3AbLQ7squccXnwnmt
	5eCCiak/eiqBf6dn5XJVUD6zVIKWMjbXolZGG1xMAkRe4bky6JAntqctffMNqjUU
	37och5rI/wFdz4pkR+E5g+rWel6GgE2NnvFk7Br7rOJHYFAYV5pBQuWTiA53NKyJ
	74jo+Q+/nS+PAGTsZ825Xg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4485nsc3s4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Jan 2025 19:44:07 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50KGrX9k005506;
	Mon, 20 Jan 2025 19:44:06 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 449193e89h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Jan 2025 19:44:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MQ+wmAHQioQNq0/2SF4jM0kjB+IfUpTJlcDTAKYfHrM60UqqQhdRbrnssv8mEfIhLuZmI5j7/kLKP7mgGnEthoz7W6FCOZ6uEnCukSycFLL2MfT+vCmkEnJVytaxd6ESqg+GSsQOmm7Y8T99kGw/QhZIlAfdi+7hfNbBi5PuXi/T5PKX0lVELPOtyIfdhBsH8LC6QazSaeN+H8T+EfoKAc4kpkh3xSzLCcZQKZXGSTI6gCUFWa6a6iabUwf1b7O6v+0tMUdnO+MRF0r4TQStqrymQpoDS3TOQvXE3vz3GfpaQf9JNs3m54Z7qZKE/DB+CblY1mhyepT1EjJXOIfgZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fLA55I8WdqaLxNMjxf7W6k2U2ZsujZqa43m0wWYvqQg=;
 b=cX+buUWq/sXwVcCfNm5Kng+baRXuqXXFzlBZuOQmdbD0xL9UzGeqMVhAcLyYIq4M7Ls/sl9mrPYm2+x1UWT/UysY3OqOmPo7POYKIxfL8nKfpjg5Leg/rJyzWZD24X8CC4Qb5HkgAMoxINW67zPgq2hklsUmw3e8biVDaG/bzQC17b6AzeAdiRh9hbD2KwWDLWPlrqEn3iH78bW2UwuM0Sk6wUwSk796bl+QBBckXBFsfZpjvM0d/6t+LrSjqXmrlpZue27PF4RUaouLy88bSuWwUW7wpZYB/nQnYniFn4aIDQtIBYH0UsVeLS9ATLgAW7/Cc6wlCBT/WB0n/XehCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fLA55I8WdqaLxNMjxf7W6k2U2ZsujZqa43m0wWYvqQg=;
 b=HYZEC+fUdCZelFabobFcWccwka5XGpdkfNGHDrFTAktb4Qea3MXW0wG/FZp3AH5jAj8YkaTrHYmVN2veD84Bjx+TqAH8pNSGpvwI638u17t3A9qjWN7oVX9s+/9NbaoMLbuLncU/SbGcj85N/+JJm3hnHGFp4k/OovgVfc9R2q8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB5721.namprd10.prod.outlook.com (2603:10b6:510:130::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Mon, 20 Jan
 2025 19:44:04 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.8356.020; Mon, 20 Jan 2025
 19:44:04 +0000
Message-ID: <2ff69e9c-5757-4308-941b-52e08d00ef18@oracle.com>
Date: Mon, 20 Jan 2025 14:44:02 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfsd: map EBUSY for all operations
To: Trond Myklebust <trondmy@hammerspace.com>,
        "amir73il@gmail.com" <amir73il@gmail.com>
Cc: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <20250120172016.397916-1-amir73il@gmail.com>
 <c47d74711fc88bda03ef06c390ef342d00ca4cba.camel@hammerspace.com>
 <CAOQ4uxgQbEwww8QFHo2wHMm2K2XR+UmOL3qTbr-gJuxqZxqnsQ@mail.gmail.com>
 <9fc1d00dc27daad851f8152572764ae6fe604374.camel@hammerspace.com>
 <CAOQ4uxiLsfK0zRGdMCqsvUzsQ05gkvQCJbsUiRcrS3o-sCPf1A@mail.gmail.com>
 <f7c76f0e70762a731de62f2db67cddba79ad03d0.camel@hammerspace.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <f7c76f0e70762a731de62f2db67cddba79ad03d0.camel@hammerspace.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0P223CA0024.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:116::12) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH7PR10MB5721:EE_
X-MS-Office365-Filtering-Correlation-Id: 21d79c1d-0930-4d5b-6cd9-08dd398acbcb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?amRjYnFCQXhEK1BWMktVRlFiWVBrK3dFTU50d2l1MUZTeUswMEd1OVJtSkNG?=
 =?utf-8?B?V2RLMFl4YkVIWE1Sd3JzcFZmY0JidzVHK1lnV0trdjA3Ynd4VFVsZHJEMGly?=
 =?utf-8?B?eURic3l2eHpkYkdFbytxb1lNZGpCa3BGVlVYeER3czBmT0tBZTFydWIyOHB4?=
 =?utf-8?B?UTFRVkM0WlNHWVNITTl6UmJRRGkybm1DQ1FDaWZ6MkN2eFZlZDNWQmFKeUtT?=
 =?utf-8?B?cjRFV004d2dZQ1JCTUd1T3dtMDQ5K2pxWFlpUnE4THhRdnd3bUorSGorWmQ4?=
 =?utf-8?B?akZmbWdpb3FUbExlaHdRcTFzRkJaMWZuTzhWUnlyZzAyQXY4Q2RwZXNaWjd6?=
 =?utf-8?B?eElCTlhYYm1BdTBNM0VEMXRCcG0wOUpRRTFESWNJMWNJc1BuK0VjNGVmb1pk?=
 =?utf-8?B?Y1g5cm94d3NvSG9XQk4zRGhLRm9MQkdiL1pZZUFqUzh5L3pCQjVoenV0cU41?=
 =?utf-8?B?aGVpMFRvVFNBamxXOFdScHpnSzNJdnVQeXNuQWpia3FMbVZTS2dGb0RYL2dn?=
 =?utf-8?B?QUtNYkJ5NlFYVFVqVVAxUUttZzdyRFowbjlRdnQ2cFpDUGRwSUVRcjMzMlVR?=
 =?utf-8?B?ak55UE1mYk9qTWZ0dGsyTC9kd1huQUE0V0NyMzZ5eTlOLzRFM2VKR09MczJK?=
 =?utf-8?B?eU9vUlJxU1huVDlMRThXRHdjTWNXL3dPMzMzLzJlb0MzM1BJakkvdm80a2NH?=
 =?utf-8?B?eWUrUnY0Yll6dFRRcmRsZW9mOGhibWxaUy9BOUtvYlBZaGx2Mjh2KytRbXYv?=
 =?utf-8?B?bzc1ZUQrSThTSHFaaHRub3VMbXFGSEY2b01Pb3QwVFRNVnhQWVYxSFh2eTdh?=
 =?utf-8?B?M2hNZ1YvSUpKRUJ4RzcyMWtJcXdBSFF1VjNsMkxzY25lTWs4QnFEODhYOTNH?=
 =?utf-8?B?dm9rWWJ3eEl0WGxReVhpOXJzVlg4eWp0TWdpNHZjbG9XN0haN2xVczUyVkcv?=
 =?utf-8?B?T04rdkRCOEdvMGRKWUFBWU9IblJ5Y2xyc2paVGxWSno5VG9NYXpERnBVS2xO?=
 =?utf-8?B?Y1lwWW5KSDlqSmZ5OG9PelZmMzR4NWdqRWZtSjhNNk8zcW9UcnBiMGthYTBK?=
 =?utf-8?B?SnZrYUhJSlRPenlZK1hMYWtLSnJvQkhmeU9sb3E3SW5TUXR6UlVKdlNTaEwx?=
 =?utf-8?B?Z1NnQU9CSWZPOEtSelJsZXBXcWRzNGg1MGVnck1qK2xPa05sdVZuRXRETHlM?=
 =?utf-8?B?MkN2cDhwcTRaa2VNdURBUDhwbmxwVDJHdlMrZjhIQURJOXVGOHF6Q3ljWnRo?=
 =?utf-8?B?Y1FFdFhWNHR4R1lIWkQ1VnhRSmJwYTVWRStTNGNlMHY2VGJ5Z1NzMG5yMDVv?=
 =?utf-8?B?MW41M3dkRVpjLy8yTFJmcktnU1VBTVdkQzNwek9NTEp2NEtKdG9iMDZrY2I1?=
 =?utf-8?B?ZkFMZ2E0ZHRHN2QrTXNtRy9aL2dDVjF4aGM3cE1OUVRkRXhGbnk0eUZrcklE?=
 =?utf-8?B?UzVOYThQM3dTVVQzQ3k0ZTBIbEdldWpyYzJrYzFiMFB5TmxmdG5USFdqalY1?=
 =?utf-8?B?TElCTTRSR0doWUxlS1BoZmZycnR0YUxHWUVyYWhTcGRwQ2crQXZhNTd1WEZz?=
 =?utf-8?B?czU3T3RtcGlGc0JONzVqQlM4c3Y0UXFHbFVPQXRZWjJ4K3diZ1c2eGJ1SG52?=
 =?utf-8?B?R3Q2TDVFVWJkT1B0UVNBa0k3Y0ZRK01UQlkrMTJsWG5JUGltb0x4TTNpdjA0?=
 =?utf-8?B?SFN6aE5PQ2NwS3Q3akJzU3FQS0h5SHFBb1NwNmtDbjBtdnhqeGR2bDlDdnhB?=
 =?utf-8?B?K01vU1UrbkR3QU42ZERCeU8rcXhhUzY2K2tIb0hIY2o4T1BBdFFpRktzZ0tY?=
 =?utf-8?B?UWpRbXBtSFdyVVpMWkE3M1dyQW03dm83RlZiZkZlOXNLR3c0VjhNdHMrU2Zm?=
 =?utf-8?Q?99NuQe2LGMoG4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dGVrUXg0TVhyTnZmcmJRbkQvcFh2WFA0OFRNQzYrVGFyT1NkYUNJeGNUYnNG?=
 =?utf-8?B?bVh3cXM0MWJCRFJaeXRXRUF5QjU4clJrcFRpVjZ6d2g3aFkzeGs2cnJHZEJ3?=
 =?utf-8?B?NGR0TU14UWlwTTN0N1BmemVudnVDVWEvVjFGaTNHRG5wcW9Kb1VkVEUwbStk?=
 =?utf-8?B?dW1CM0dGa3JjR0VVTnhzQmhpMVBGYUVQYWFhOU5iUlB2a2NXZDdjUE1YWDVy?=
 =?utf-8?B?YVJic0IxcTZ1QThtNjFNMEVPUVJpL2t5QlJiYVZSd3VKbUJ0N0VpYXN2WUdz?=
 =?utf-8?B?Q215bk9JSWg5QWtuVFR4UVQwakF4b0RtMTVmM0JlNDVkc0JLR3pickZCWFhX?=
 =?utf-8?B?V3FGWXZIaXdRMXJ5cFZCdHg3SXk2UnpDOFFvSWI5UlRDSThCZjVqRTdzY25D?=
 =?utf-8?B?bGI2aTJHMEJwcFpwRGs3dEpwSmVzWW5acDVJNUFiaDN5V2pUTUM5eDVXKzE3?=
 =?utf-8?B?YVBHVjZTYjd5Nk1VSVAzR01aMnBHYlRmekNNR0RzNThoZk52azAwUkl5U2hm?=
 =?utf-8?B?ODU4aE5jdjV3ejIyNXVCRGUxQXFJdWNDMHluR0xwT1M3bUROTTZkY2NlQVU4?=
 =?utf-8?B?S3VPbTA0VUhUNFl5cktZRURvNXUrVWxrTThWTEpOMHVrc2FNYk1QOVYxdXBM?=
 =?utf-8?B?ckZkMy90eWpzTndkVXdsQmNFa0R1YklGbU1xZDYzTW5PMHJhc3JkbUhGYXYw?=
 =?utf-8?B?ejRzWFdhOFMxaU1GREFtRHljYXQxRC9jZVNjTThCOEs1aHhFK09qWmR6dlpX?=
 =?utf-8?B?MUg5amRuVGZneFBIemZrYUtPRWVPaFhjZzVTV3R3Vmw4Zi9CQUVVOWFHQjFH?=
 =?utf-8?B?d1BXK3FISlNwZU1qYmhGVTRhMHRCWmlJMWVpVVVsUFVBcFZJdE1tU2U3U0tz?=
 =?utf-8?B?MW81UTVkQUZUZlFSRkEwS2oya1lqVUZlN1hVMXBWWHl5cWJDU0VFWWI4alhX?=
 =?utf-8?B?MENzZmQ0ZEpMbzJPanNleDFQd2RDTllseVphTjh3OHMrSmorSnlSQXJTT3hv?=
 =?utf-8?B?T3Ric0ZGZCt5WHJTa25JdkovdWk1ZkhGajdrdVZ5Zzc4WVdKRkcvdFBHUWVo?=
 =?utf-8?B?cUFzNWVKbVZtcFFGdUMxVmYyM2drV2RmWkVZQ2FwOUJBSGlITXJTNjJ4MExt?=
 =?utf-8?B?WXRDaTVxcU1JdEU5dUdLTGNLVHBTeGJsMUQ3VnhyNkw2cXpQd3drbExrd3Rl?=
 =?utf-8?B?M3h5SjFKQnlhcEtxNlNpaUJJQmttQW1DVlBMTHAvMmEzeEYxZW4vUnE2VVhZ?=
 =?utf-8?B?dmIvcEppWjJ1VkRyUzZ1RnNta2VLbFp0cTFhQ0tlUCtIMzNteE56KzFXd3Fs?=
 =?utf-8?B?cC9CcURpcWlISU9jZG54UHgzUVpEQzVVRDBWbDRyUDBrSGVvL1pVeXJ3cG45?=
 =?utf-8?B?RjNISjBwN28vd3BoYkhWYWpXSkJFYm85SnhOdnlIUXB3TVQ5MTRYSXdHbU1r?=
 =?utf-8?B?UGlKaG5VK3NVd2Q1Qjg4Y1p3Z2pQRDEzMzFieFNTVVZRRmRtS24wUTBvTHow?=
 =?utf-8?B?K1I3WGEyNksrWlZWMGwxNGw1QW9mY2pHc01GZVJJb2hwejR6c2J2VXh1Qnln?=
 =?utf-8?B?Y0N3c2ZkQUYzMHRsaXJDVTc1aWIwdFpXOVJaMmowVzNmNTR2RzZpblQzVytW?=
 =?utf-8?B?S2l0Z0xmOXMwY0svOUdPQXZkVEt3Skh1dUZJV2plL0hKRGVGZXcrK2oxVzdI?=
 =?utf-8?B?ZU4rYUsyUkRBSGhqbVcvRGFWWGgyNm1EY2tWWGpFcFkvY284ZmQyZlpadG5I?=
 =?utf-8?B?R1NlUlNHNjdKc08wa2N4cWNhaG5qdFdCTnRjQ21RWWpOSjBIYjgzcUFsOXR5?=
 =?utf-8?B?cjhNOG9wUWU5R0VrWW5pLy9wNTRPSHM3ZjlxYnRzYWVSdGhNY0QwUktScTlB?=
 =?utf-8?B?cjJPTWU2clRoQUhEaW5IcGgvYXV4UkRlRlFDbmtsSTNDSndGRk00dG5oZ1R2?=
 =?utf-8?B?c2diQWJnU2lwZ0duVmFPajBvYTY2Rm1CNENRUW1oTi81Nm94djZYWXJ5Mk1y?=
 =?utf-8?B?akVIRktZQVFVWndId052YmQxd2hNSXNQRXhHeDg0MzBVZ2xzem9tUDU5bkxi?=
 =?utf-8?B?NTkrYWJlM2YyK1Y3aHBNYW5rZlQ0aXZuSlRzSXc4aHA0V2pvbVZ2NXlBcXcy?=
 =?utf-8?B?YS9HeEtzVEVGTStpZEN1bUVrU2tWOUVWMTdxeXJteFJEUGo2UDM1bzZwbFJK?=
 =?utf-8?B?dmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	McRkhAsaw/poDDnyzpHvNOVPMnETgHtfr0zIej0XdIR/pCH3KzhK0vEzMvSzCHCPlhXjK5ATRLwlf0ZE1IcdfyTRGRHHgls7sYmUgXywVK1kzP3eWrnZRSNjA/rZLT2H+1iBOlUrCbKbsCB3kA2camMyznbRdOS5wNuOVmW/yX0Ubhy0jwWu1m1cr9vkl+1Z5Ge0Xhy+AsxKAK70/AkyfdB0jy2NktE1T3V+dl/lHUkI+IyEk9aRrJ8/XSYKz4xlRI3r0yos02X+iEHi5iHBvR5TePP3gFtTbE0YI0EDPDES8MOwcPE6zDFcto47MObWbBywqOJPT7NRDmB2RF0lklTUrLCH3Ymx/Ba1hdNC7dfMK76mOkJlCZzPajdozGEufA5CZpacWS0K/bYP/OEEeB+kHGHIMhGqSyGfTl+49URRdLXYX+6HCCQfPKjwWg3bWowdlAC8GKneIsSsJiBci5oknLAkzyTv7esYmHmPtSlZltx6AP6aI6aI5aBubaqb513mqLO5U2zXkcQRs3tzaM8oUUfRSAdJi7O+MBoCYnsSnJQf4mOWu4UoZFfAuYrnQNb+OBN5Cp5o4xmFa/U5bGolJMZ6LXbpavdtTFRhjMg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21d79c1d-0930-4d5b-6cd9-08dd398acbcb
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2025 19:44:04.5135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jYhdjDw5JXq7H1++IGz7gfJkECsYvihkob+r34GYklUWKklXIu9npjrRGzONwe/23esnmjnL6SCOSLBIMgMNNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5721
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-20_05,2025-01-20_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501200160
X-Proofpoint-GUID: Yj7vOfxZXn3YAumuDErDm5bweQwfQwNm
X-Proofpoint-ORIG-GUID: Yj7vOfxZXn3YAumuDErDm5bweQwfQwNm

On 1/20/25 2:29 PM, Trond Myklebust wrote:
> On Mon, 2025-01-20 at 20:14 +0100, Amir Goldstein wrote:
>> On Mon, Jan 20, 2025 at 7:45 PM Trond Myklebust
>> <trondmy@hammerspace.com> wrote:
>>>
>>> On Mon, 2025-01-20 at 19:21 +0100, Amir Goldstein wrote:
>>>> On Mon, Jan 20, 2025 at 6:28 PM Trond Myklebust
>>>> <trondmy@hammerspace.com> wrote:
>>>>>
>>>>> On Mon, 2025-01-20 at 18:20 +0100, Amir Goldstein wrote:
>>>>>> v4 client maps NFS4ERR_FILE_OPEN => EBUSY for all operations.
>>>>>>
>>>>>> v4 server only maps EBUSY => NFS4ERR_FILE_OPEN for
>>>>>> rmdir()/unlink()
>>>>>> although it is also possible to get EBUSY from rename() for
>>>>>> the
>>>>>> same
>>>>>> reason (victim is a local mount point).
>>>>>>
>>>>>> Filesystems could return EBUSY for other operations, so just
>>>>>> map
>>>>>> it
>>>>>> in server for all operations.
>>>>>>
>>>>>> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
>>>>>> ---
>>>>>>
>>>>>> Chuck,
>>>>>>
>>>>>> I ran into this error with a FUSE filesystem and returns -
>>>>>> EBUSY
>>>>>> on
>>>>>> open,
>>>>>> but I noticed that vfs can also return EBUSY at least for
>>>>>> rename().
>>>>>>
>>>>>> Thanks,
>>>>>> Amir.
>>>>>>
>>>>>>   fs/nfsd/vfs.c | 10 ++--------
>>>>>>   1 file changed, 2 insertions(+), 8 deletions(-)
>>>>>>
>>>>>> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
>>>>>> index 29cb7b812d713..a61f99c081894 100644
>>>>>> --- a/fs/nfsd/vfs.c
>>>>>> +++ b/fs/nfsd/vfs.c
>>>>>> @@ -100,6 +100,7 @@ nfserrno (int errno)
>>>>>>                { nfserr_perm, -ENOKEY },
>>>>>>                { nfserr_no_grace, -ENOGRACE},
>>>>>>                { nfserr_io, -EBADMSG },
>>>>>> +             { nfserr_file_open, -EBUSY},
>>>>>>        };
>>>>>>        int     i;
>>>>>>
>>>>>> @@ -2006,14 +2007,7 @@ nfsd_unlink(struct svc_rqst *rqstp,
>>>>>> struct
>>>>>> svc_fh *fhp, int type,
>>>>>>   out_drop_write:
>>>>>>        fh_drop_write(fhp);
>>>>>>   out_nfserr:
>>>>>> -     if (host_err == -EBUSY) {
>>>>>> -             /* name is mounted-on. There is no perfect
>>>>>> -              * error status.
>>>>>> -              */
>>>>>> -             err = nfserr_file_open;
>>>>>> -     } else {
>>>>>> -             err = nfserrno(host_err);
>>>>>> -     }
>>>>>> +     err = nfserrno(host_err);
>>>>>>   out:
>>>>>>        return err;
>>>>>>   out_unlock:
>>>>>
>>>>> If this is a transient error, then it would seem that
>>>>> NFS4ERR_DELAY
>>>>> would be more appropriate.
>>>>
>>>> It is not a transient error, not in the case of a fuse file open
>>>> (it is busy as in locked for as long as it is going to be locked)
>>>> and not in the case of failure to unlink/rename a local
>>>> mountpoint.
>>>> NFS4ERR_DELAY will cause the client to retry for a long time?
>>>>
>>>>> NFS4ERR_FILE_OPEN is not supposed to apply
>>>>> to directories, and so clients would be very confused about how
>>>>> to
>>>>> recover if you were to return it in this situation.
>>>>
>>>> Do you mean specifically for OPEN command, because commit
>>>> 466e16f0920f3 ("nfsd: check for EBUSY from vfs_rmdir/vfs_unink.")
>>>> added the NFS4ERR_FILE_OPEN response for directories five years
>>>> ago and vfs_rmdir can certainly return a non-transient EBUSY.
>>>>
>>>
>>> I'm saying that clients expect NFS4ERR_FILE_OPEN to be returned in
>>> response to LINK, REMOVE or RENAME only in situations where the
>>> error
>>> itself applies to a regular file.
>>
>> This is very far from what upstream nfsd code implements (since 2019)
>> 1. out of the above, only REMOVE returns NFS4ERR_FILE_OPEN
>> 2. NFS4ERR_FILE_OPEN is not limited to non-dir
>> 3. NFS4ERR_FILE_OPEN is not limited to silly renamed file -
>>      it will also be the response for trying to rmdir a mount point
>>      or trying to unlink a file which is a bind mount point
> 
> Fair enough. I believe the name given to this kind of server behaviour
> is "bug".

I would greatly appreciate it if a bugzilla.kernel.org bug could be
opened that lists the affected operations and what the proper
expected behavior is. Bonus points for documenting the commit hashes
that introduce the incorrect behavior.

Free <insert your preferred adult beverage here>.

-- 
Chuck Lever

