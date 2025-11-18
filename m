Return-Path: <linux-fsdevel+bounces-68992-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 86080C6AD3C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 18:08:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 715184F0933
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 17:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6181B3730F5;
	Tue, 18 Nov 2025 17:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lDE4DAvW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="G7prHEMe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6541329B783;
	Tue, 18 Nov 2025 17:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763485265; cv=fail; b=syhBNwqSd4okP4Juau1UjxwnygwmT5cB6mta8sGh9Ev/nSQOVa/KSl80A30YAciiRY+MIvNAhNDLG0zoKPI2uU/Aybg/ibUQl1FSGbmPvq6r/YgHvILppCAPO/1yFxXMq11f2WtueG9qYLB3H3zeyAD+766l3I0Xt2en/0egaqc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763485265; c=relaxed/simple;
	bh=B3UKWqyU7RPPJxxHUoKnjGAXCMW5uKFxIuxmHwQD40c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EOTfLGcIRkoW7NTt2owSnazgnioUEwoMpMZZWvvdHoi3ewN5KR4ZDCTl9lWrsCaCFUyHVQ+t/ZsWuzS9fEnqVpa77dCLEC/0ptEF9yW2wKQsKyDHcyG/CZn4cUepXlZ6fkl384kD1qh4rUadbxuTg/KfgCacYO5UGG37tTcydAY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lDE4DAvW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=G7prHEMe; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AIDRwFa019665;
	Tue, 18 Nov 2025 16:58:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=d+nvmHjX1KBnG/DyUSyvWmEd6KVm/GoY2cJngYy2RLw=; b=
	lDE4DAvWNp6WuXpwSoHv4+0xyggsCeRjUjFLwIX+WLrm6NAxMMJeSpG4No9IYmx0
	NpkrnXax6y+/xxK6PDrnQxTAs2hfRU904PK4O/yU6cq3/kPqoKpdmQNPyOlYb5gl
	mXm2MHXMjFdd//Wia8us39olu6yctGNTehX9UFjtHwbH7EZShRbHR+w3AUQ6bssc
	Eqf12jRujhs0HI+EkJnu4suYbwUpkZXq50bssU6/haim6JM5Ur7VNimA5U5L1x7S
	gj5fqwP81ddEouu7FKpXktXZUJCqDQhs7QshNg/aC/OK3KSkzOdHVNI081a4OIDT
	EEDREuLl0Op8xpM9K4jPZA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aejbun6ca-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Nov 2025 16:58:37 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AIG0SYI009602;
	Tue, 18 Nov 2025 16:58:36 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012048.outbound.protection.outlook.com [40.107.209.48])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4aefydefuu-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Nov 2025 16:58:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ktB7d4QM7aAFpnEj63C1GgiCzWU+Rdv415B45Xg+3Xn/h91W4AcL/BYSWe+xKq+kZDAsPSAvOvocDyYnJBCcK4WMQ/Nv+SG2xXp/esDfdcH/niG9JBo8797tp6XeTDBnvn+jlsv7yMtbKf/oOyMtdwY0l/yecv5o4Wtw01HkvrH7YFPga0LuJduSL7WN3b2SJX1IUOZXRBmOOlW3PGL0TzomE9FXtd57JMQG7hSmrUxAWMDBMhSCfqwA3SBc0Y1Jcq6csr0mp3I58dEhB+s/jAvX8XdqMQsHJJCR+k+7TrmROwwHEdO20FuKFf+w3C5GQA4CtOfFgbfOZObSSOd7Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d+nvmHjX1KBnG/DyUSyvWmEd6KVm/GoY2cJngYy2RLw=;
 b=ZhE3gCAql4Av4JaxYcTfM0o8JXn6FJeMrkND9NH7JwwtorqiWvOzcnxB461EPeBgRAQNmwIojjRJCZ5ZTfL0w8TzGRj0neU52RE4vAiZlgOpKuQm1LkSjadzT1wRUXVGCvxfWJJFZQWmYDDcejLPOQCX4yUWs6scpQAaGQe89hdNJoG6A+YWU5eHiDEsnaY0u/rFFzanZ335ho4BEhx/G8av2k0QmvOJhWZDMyD6FPImwHwd/H+gPHm3EY//+97UmjWVHGsKLaqP6cEnZpnEZ4VtoJsA/52qXZZ2SnRW42HVKrIiH7Zt7xDlA/biMf5jjYXPxuAI+8I4gY/oCMo3wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d+nvmHjX1KBnG/DyUSyvWmEd6KVm/GoY2cJngYy2RLw=;
 b=G7prHEMe7SF8TFmhh0bgOD5xocX7g8GISmVI5JMdMPdtJojV3XyH0UpvjRG9p+2Wp7Mro8yGuRlnQMM91K/sG1zpM5sve737okksW+c0W1WHtnQf72bYHtEYgVdBlAikoUW3V9OgTRxb4+e479pMhb6HML2BENbYj3s7sipe7yo=
Received: from BLAPR10MB5124.namprd10.prod.outlook.com (2603:10b6:208:325::7)
 by DS0PR10MB8224.namprd10.prod.outlook.com (2603:10b6:8:1ce::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Tue, 18 Nov
 2025 16:58:32 +0000
Received: from BLAPR10MB5124.namprd10.prod.outlook.com
 ([fe80::d147:697d:43d4:16df]) by BLAPR10MB5124.namprd10.prod.outlook.com
 ([fe80::d147:697d:43d4:16df%6]) with mapi id 15.20.9298.007; Tue, 18 Nov 2025
 16:58:31 +0000
Message-ID: <050d60a8-7689-46f3-a303-28e01944b386@oracle.com>
Date: Tue, 18 Nov 2025 11:58:28 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/3] Allow knfsd to use atomic_open()
To: Benjamin Coddington <bcodding@hammerspace.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, Trond Myklebust <trondmy@kernel.org>,
        Mike Snitzer <snitzer@kernel.org>
References: <cover.1763483341.git.bcodding@hammerspace.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <cover.1763483341.git.bcodding@hammerspace.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0082.namprd03.prod.outlook.com
 (2603:10b6:610:cc::27) To BLAPR10MB5124.namprd10.prod.outlook.com
 (2603:10b6:208:325::7)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5124:EE_|DS0PR10MB8224:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d1d08f3-9713-4a61-e126-08de26c3b376
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?NCtRVkFjbjl0RzJJb0tFMHF2dW8wN3FocDAwbWs4K095UTczaEVhRUY4aU5R?=
 =?utf-8?B?ZGx1Z0ttS1VQYjI0bXpyN25xZTI1c2x6dmliU3g3UEV0VTJYRFdta0ttb0g3?=
 =?utf-8?B?WmpxWTRJN0RhTG9lZUNiNG1qNTRHbGpUbEdQTmc2MWk4NUpJbW5TajdXalBs?=
 =?utf-8?B?eDJjQ0kwa24rVk9Kc0p1VVBjY0VyM2RJcTFKblNCcEFZdlpNVVUxZzhuQmd4?=
 =?utf-8?B?VFZ2M1JlaWZrbmNKTCt5aVJhSERucVFFa0pFNmFlMU5OWGp2YVlMazA1RjFP?=
 =?utf-8?B?ZW5ZSi9WQ2lacnBaaE1nbzFMUUtVazJxR1lVYmwzeVNnRlNFRUk3Vi9yWVZW?=
 =?utf-8?B?SHNXZmc5T24vdEFVQXkxVUgvcVdFT0MreGxZWDYzOXRMVjFyejd6cDEvT3BN?=
 =?utf-8?B?VGJUSVovRG1KMXhZKzVIVngwa0xrSXk0OFQvWEgwS2FzcnBKalNMRzQzakZZ?=
 =?utf-8?B?UTFOY1RaWjVNSzhGM05GTE05VVVZUDZXQ0ZWVVFnbmFrYjZmMDVxS0Z6TW91?=
 =?utf-8?B?cmRSRzZWWVRlVWhLNklGcU9pT3NCVldqSFZVcXcxVXp4ajZjNnpGU1NxT1Ru?=
 =?utf-8?B?dnlRSkVkZmlCUGR0MEZuekl4Y3EzejloQlBJSmsvVVh0cm5VZ29RKzFyQjR4?=
 =?utf-8?B?OXJQUXVhR1EwZ2ZOdmxVek40KzJKMVBMT3R6bHZoMERzK05rbW14MWtwMnFS?=
 =?utf-8?B?bHNuSndNMEZPUWJGMmVIOEdvc1lwZERtN2pxM0hLVms1YWtDLzRDK2NyVzlS?=
 =?utf-8?B?Vm01S2xrU2JkVXV0U2JHNWxVeWwzNzNWVS9VQjl4eGxnUk9DT2ZLa3dTWGJv?=
 =?utf-8?B?RWdxSFEwUmpSdFVlME5waVhJd0xqM1I5c0FZaTBQQm1JbWFPTnhHTTByQmxO?=
 =?utf-8?B?dXVtRkI1OTZQSlFEMEJtYWNrUGNGYzhSOGNSNm5KWlV0WW03bGNsamUvSzBl?=
 =?utf-8?B?S25SOEVnY25nZDRjUGNCTzB6Z1NweUFUejB2UnNTdVdCUlplV3JLNUZkbk4v?=
 =?utf-8?B?aFYzVHllUGhqVlpkZS8zdzZaaXdVaitVNURZV1MvSHVjcWR2WGRKQ2lQSUpS?=
 =?utf-8?B?c0hkMnRiVWhnZDFvekFGa0hNOVhaVlgzS3p0WFNKZDZkR2NmTGNNRUllY1Y0?=
 =?utf-8?B?NFFPSHdxaFc2NVpEc0hKKzMySXNQdE1CZlM5TktnTzhVaXNRcVNjdXJibCtZ?=
 =?utf-8?B?d0w1UThTQkQweWRibzBkUWNwWkVtZ1oyQ0xkbyszcU15c2MzRlIwYzU5KzFu?=
 =?utf-8?B?aDkyQVd4TzZsUTNMOVVKQVk3TlZpdTJ0WmtZVFZ5ajh0d3ZEcWhhYmFDaGph?=
 =?utf-8?B?Q2VQUE4xaGFFNHM1UnF5czN4Y2EwUUUvNHFJVndCK3l6dTJiVkg1am0ySHhB?=
 =?utf-8?B?amlRelVFQXlpUmUzblo4TGJ1dFFmOHNndUI0RUcxQnVUU0dzVTNLcno3NFJw?=
 =?utf-8?B?REl2U0xGUHZzZTg0RFRSSVVTZ2VwY1N2WG92Z256ZjkwYXAyOGVEKzBoMjdF?=
 =?utf-8?B?dGZTcGpRcm41V0NpNnJIZVRObERNb2pRWEJNODhUR0tkVDFJUDA5NElTaGhD?=
 =?utf-8?B?VlFoSEQzejhHQS9rOXpSOUZrTHB2eHQ0c3RmYjlPdkxKUGpiRHFFUzJHQjVT?=
 =?utf-8?B?Sk5qZ1Rqb0twdHhiM1pFdGVxa3ZpajBSN1NPUUs1ZDMwOWx5U2hRR3ZFSFF3?=
 =?utf-8?B?RUZlK3pYVkhqVHc2S25nUStISXhWMHhaMm9Cdm1GY2xua2Vyai9GbHhhVERN?=
 =?utf-8?B?dDgzTEcrOFJnTVdVWExMNTNDZ3BDZUFSSFVvNUF2ZkdjajZGUk4zWnJ5Ti96?=
 =?utf-8?B?QmVBUUVvVjUwUmNSbmxrOC8rdjVSWjRzZ0p0YVIzVVJDdStiQUdnZHF0elRq?=
 =?utf-8?B?enllZXJJaGFYM3dSaEdRY1I4akc1YlBpUG5lRjRVek4zOG96dnFtd0JEbTE0?=
 =?utf-8?Q?WpDzFG/I8sGTVs1iMvyvhS4QxuQsbxN9?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5124.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?aWNCc1BjYlh1cU1iaXUrSlN0VTRoMWVHQUVrbzNWRlJvYTRwRWRjazBucUFI?=
 =?utf-8?B?L3dMMjBtbmpKNzc2SGRVV2RsMHdBL0RLVlF2NGRReG9WOWdVUk95NVIvdDdE?=
 =?utf-8?B?bldYakcxT3VDeVNHOWtHUE1EWnY2allKdkhXTE5JZlZXSHJ6OXp5MjV0TUQx?=
 =?utf-8?B?dHdwdEhmT2M3WXozd2YyTEI1ZlZZb2YwbnFDTWZUMFprZXFlZXlWOHRhK2tm?=
 =?utf-8?B?T04xa0hndmJMeXJVWVBXSEEvUFB6QTBZanVOeGdkbzluSmRGRnpLT3FQUUdR?=
 =?utf-8?B?SzI1TUdCeDYxWHV4N0VpN1FtR2w4NUh6SFN5RldFMWx5djhsejVSL05YRkha?=
 =?utf-8?B?bjB1TEdsOERvWkF0bU54Rit6Uk5wZEQ4WitSRWZEcVpMR3dJMU0xaEZtamo1?=
 =?utf-8?B?RU16SUs1Z1NGYzdCRmpuRnpYVGhPMHhhby9VTWRNSU9WSFlRVUl2ZHhWOFBP?=
 =?utf-8?B?bU85SjBOcnJJS1J3NnE4S0xIUkowaHdZN0RtcS93ckNOa21xU291eHEzVHZp?=
 =?utf-8?B?M0FwV2tYOXQ0Mmt3K1Zad0FSVWVlOXZmY1JKTmhjZ1U4U0x1Y01CMnl2Vjkv?=
 =?utf-8?B?V3g4Rk44VjBvUUhIZ3FyS1RZL1E4QUFkazN4MmJ0dTVYeXU5dkRSRlMvYnpZ?=
 =?utf-8?B?YWl5R2hmQ2xlZE9qT0FvM25sWkRJMnBncEF0eVJYb3Vsc1p3bCs3RGlXcUVj?=
 =?utf-8?B?K1lpdVhEcU9yUFN6Q0h0djROV2tmWUFzZlZqVmJHKzRjTXU1WDB2OTBBemRI?=
 =?utf-8?B?YU01MFVmeG1zRXdoK2paOXQ0TjBEak0wOER3cVRpN21Qd3plNHEwd1FuWXVM?=
 =?utf-8?B?eE10dUFiTTdwdjVoWk5FZGVsVCszMThQMnVqUHA5R1ZXcWJpQUtBdUl4dlNv?=
 =?utf-8?B?YmNGamVIQmJVcFI3ekVwYkN3WE5tL0svdFJJTTBUa2d2UGhvWDJwMXpLcWFs?=
 =?utf-8?B?c0RhTW4xL2U2SGlPaVQ3bW1NbzcxdHFnMEJGREdoZ2laT0JRcTZ0NUFGWmwy?=
 =?utf-8?B?ZVhwMGRmc0xURWFyWW9BNEZLRDlEeHk1cHg1ZjI1Kzlkem0zOFZ3cG04Si9K?=
 =?utf-8?B?TVhUSlk3cWpibld1S3RDaGNBSzJGbUpXT1RhVXFwVkZOT0ZWeVBHT1hoYnIz?=
 =?utf-8?B?cWdWVXBCT0Z4UlVzNlE4ZDBuSkxrMzNLM040L1QvRVFxMTlEdjZrbVRzVzJ0?=
 =?utf-8?B?WmR6N2k2MWk1d0FGQks1R2FaWlhvZFovU1R0cWNjbmJ5bnFoU05yNjEycnhC?=
 =?utf-8?B?MUFYWHdHd1UzRHoxQ29HRFM3U0xSQlB5S3p4dm4rRFVoemtvV1JpVVFJWmhP?=
 =?utf-8?B?T2NOT1N4V05iUzRVNWVXTmYwV2hRWDZ0b0ZqUVcwK0ZzdWpFdzdNNmpicmlp?=
 =?utf-8?B?MEpQRlcrTTVrdmZ0M2lkOTExRHpxTWh4RmhSQkxaNTE5MlJmTWJtYlZEbkN6?=
 =?utf-8?B?K2RLNUwzczlCUkV0U3hUTTFaS0xKa3l1ZnRkUys1endWMTFTZGQ3L1ZuUDU1?=
 =?utf-8?B?U1R5RHNJK1djOWozdjUyeXQvcWd4cUpocjlKOWcvcGZRSGNPZXk3ZGRTVERH?=
 =?utf-8?B?cGJuejJwNFk1N3pLR3g0akRlWW1iRW41QXduMWU2NkNwZG5uaW9TZjFyWHpY?=
 =?utf-8?B?andwTnFXanNjS2ViOTVJbVpubyt5ajYrcUNLc3pqSnJML1FGWUVoaG5YR1Bz?=
 =?utf-8?B?WmdhTFNnV280SXN1am5KUDN5TGF4OWRCc084Q0VwR0JzVWR5TUtJV29KdERR?=
 =?utf-8?B?a1dsWndLNTNKTkY1ZS9HamNoOUNWc21XR3ExYis1Q3pWS1J6S0VHNUNEb3Bk?=
 =?utf-8?B?dWlpSnk2ZWZGNFhRTkZqTVpqTXN5Yy9QMmgwSU5jdlhsY0ltNStKa0VDWGVs?=
 =?utf-8?B?VVQxUDRjR2hOQ0xxSGZ6VFlJbC9sbzZpL2ZjVVVHQm1FeUxGRW83ZklPS1c5?=
 =?utf-8?B?Ym1VZzhOaS9KMUhuNjFMaklNWEx3T3NuZkZXV2owcGp4ZXVWUG1oR3R2NWgy?=
 =?utf-8?B?dk5QUFEzNXlKTUkwbStlbG1aQThjbHRIY1dPS0UvRU1ZSUFGRTZpTkJldHJo?=
 =?utf-8?B?QWoyRU5WYlpXaTk5OFRia3B6bmZpYVlhb1o5bDJLUGt4dVU0ZTQ3cTUwU1Z4?=
 =?utf-8?Q?Au+qAxoNgA0LL64ShBjpMk4QO?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+4+66JohhBAuVHe1NUjloNM+G9tiLAB03nrKbjZwzRS0IgWsdFI13DsHvbKfLKV7zKggYPUMKE9fIm/4x5fUMePalDgRrEsrsSQxOzn7g249VKWIXwTS3XGi06dzVQk+l113T8DaC0KTETv97p1pC5SGZRfZAb+gDhLnthM3UQBTDxUhOd4RAL4f45au9158NNRDP9OO954tpCVlHwUzyGy0SnHm0nzbj2s4mAWPnrLHiZpncWCL3EAEKmg7Pxjd2NpEMtJsqKmqRD4MkACOVpG07SPISv+0VjQD3dPlq/mvEiBdfa+70XkSMMGkfDP7q6Q4+WoNWzuLDkJ8Vz2yQ1UlJ6BnlZJQcB+23nn85sNDPknsQFd4vC0lZO8+bxoKqjgOTsK3t2QTw1u28VtLrl7lMDWOPLbm4xorK0uZPuRo/gW0v3cdQUiJjrqwINev1jOs9vBbvrs7Mxm+rZR6G6hykob87P+lJThxyxZswXdFX7kF0Spsqh2U8jHCnQNAM78NXbjCfSF05hpY411GRXIPNgUVFHD89KTCmHM4Tw3d8J0AR9S9GrhbqiFsEb9b39lotN/JNuxZaJuxwjAn+XB2hrrehLsefQJJbUwdXCU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d1d08f3-9713-4a61-e126-08de26c3b376
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5124.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 16:58:31.6994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7SujgRHbPz5wSavgeXAypZuWIa2wn4gRXe1JLRPdRrE4Kl5yhh6yuQG4D+RyVALM5D02Rd7XzkWjX8NQPDGw8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8224
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-18_02,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=919 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511180137
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfX+AVjgMLJhK1B
 JNWaqzhBRihFqrBDddtjtlJPQVw45nPC8dsmsmMUwSaEo4OkKaC5qhVOEGME7FgIGOyQOgAj8/T
 irwFnuer2sQNKSkabmDNo+LjM1oVsL7uQ4F6BaKzhA+/RkbcXaLmCDDXmJqz9+dI8EAbFhoBwaF
 3FNQBl5JgJn34+cswleq4gO0cnW8vs0fTXD9N0nOhu3Rd9Eqz4xc4RgfknUCcXcMmngPrcDwsGM
 +wpzS53VN4bi1QNCs60950+oBptvTUeo30bufW6qnaowf7WM1UeFSnIyb7Y3WU1jx4DFC+q9W/t
 GgRpfpAzUev3UjsJcYtMdn8+9SFHnZG/Kf0jrZw2Ha77XDYTvwNIXLGaekoqNnFKpTrmsz95CNl
 aC8fAWsumFitxQTqmW97D2g7rHr0v5uGD6EXeZF5MeQTl4Ld7zo=
X-Proofpoint-GUID: c-wCbs0FzbP145mGJ92IlUu_1TEIv5CT
X-Proofpoint-ORIG-GUID: c-wCbs0FzbP145mGJ92IlUu_1TEIv5CT
X-Authority-Analysis: v=2.4 cv=Rdydyltv c=1 sm=1 tr=0 ts=691ca5bd b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=LFakn9FWMrV3anf20MwA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13643

On 11/18/25 11:33 AM, Benjamin Coddington wrote:
> We have workloads that will benefit from allowing knfsd to use atomic_open()
> in the open/create path.  There are two benefits; the first is the original
> matter of correctness: when knfsd must perform both vfs_create() and
> vfs_open() in series there can be races or error results that cause the
> caller to receive unexpected results.

Commit fb70bf124b05 ("NFSD: Instantiate a struct file when creating a
regular NFSv4 file") was supposed to address this. If there are still
issues, then a Fixes: tag and some explanation of where there are gaps
would be welcome in the commit message or cover letter. We might need
to identify LTS backport requirements, in that case.


> The second benefit is that for some
> network filesystems, we can reduce the number of remote round-trip
> operations by using a single atomic_open() path which provides a performance
> benefit. 
> 
> I've implemented this with the simplest possible change - by modifying
> dentry_create() which has a single user: knfsd.  The changes cause us to
> insert ourselves part-way into the previously closed/static atomic_open()
> path, so I expect VFS folks to have some good ideas about potentially
> superior approaches.
> 
> Thanks for any comment and critique.
> 
> Benjamin Coddington (3):
>   VFS: move dentry_create() from fs/open.c to fs/namei.c
>   VFS: Prepare atomic_open() for dentry_create()
>   VFS/knfsd: Teach dentry_create() to use atomic_open()
> 
>  fs/namei.c         | 84 ++++++++++++++++++++++++++++++++++++++++++----
>  fs/nfsd/nfs4proc.c |  8 +++--
>  fs/open.c          | 41 ----------------------
>  include/linux/fs.h |  2 +-
>  4 files changed, 83 insertions(+), 52 deletions(-)
> 


-- 
Chuck Lever

