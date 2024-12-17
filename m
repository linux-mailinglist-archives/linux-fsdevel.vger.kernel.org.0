Return-Path: <linux-fsdevel+bounces-37663-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE9909F582F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 21:53:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32D8916FF90
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 20:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A4C1F9F51;
	Tue, 17 Dec 2024 20:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="T8208+uz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RiSUtL7F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B811F9EDC;
	Tue, 17 Dec 2024 20:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734468758; cv=fail; b=kYZdqKRw9RyFXB/D5U6bNZKhxlvBtDZJQY1Lq6HbRzkTmkg7L/faf41LGL/LC/T/mRROLEfKUrE2GNZArN1g2gNAUkWWVdqVOYxQWKAgj0/iVgO1E8iQGDl7f/tUJcUTybnzlf4TVvkLeh9X/spI5OJqNF4BbdDyIrbkYD44olM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734468758; c=relaxed/simple;
	bh=A3YvWMh/MmRo65CAdOhDhJ/HkGfF1r9j0xpFkNmQ1yM=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IhO1TpNAgZxP3WZ0qttRyi711lz9XLt8VA8ptMK3shC+WUEiK4ZEG65jrrLsdQezXYUFxSqC44AwvkTXr6tFDA9ueLpwVATH5o++ePOQSfIJ+SdZ9PwS6rVF1R2TnpoS2fuvZGtk3z9/p2qtAy1WWzXn1iXGtEfehFzhakvP9Bk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=T8208+uz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RiSUtL7F; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BHJr0sp023746;
	Tue, 17 Dec 2024 20:52:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=HC0eJgFziGEph82vDk10qZFJz+Ry65qksuxbuq1pnI4=; b=
	T8208+uzyCMZhzsI5ZK2BbNO1Yus60mWtK5YFaSyoaj7VDAoIGYPDHaElTXqJvdM
	gkRHYBRldtlZrsCNRxV03lh3P3b0TMIK0FjzhkXrO5sLHn6zUsPM3kWQ5cP+6raw
	TKia4Xggb8nWlof3p1ToDRX5fjEGVt6dHpZUKqxwtQpRYQnCF52jNgE5WwZvQOxK
	Tyd5UJOhhpbKgIE1TRD+7Q6P4VvndZ8XKIjaRVr+LFm8fConfTJklnbDRLfMFe7R
	rnbXtXMjwxFTWhVZUp6wWUP3mKXbmAT2ROT9/KsvBVStimCtzFjUG12lSsx+2fN7
	S1RQuUjmxURV/N5mDHs8QQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43h22cq2rc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Dec 2024 20:52:01 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BHJAfWS006411;
	Tue, 17 Dec 2024 20:51:59 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43h0f9vv4e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Dec 2024 20:51:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wGq5GL5ycrsBTRkHuC9nfnk9+f3IAnsBQJLDN3RohnwL+fP6T0wicXOvwqJtT+iYuUhKvQe3Dz82N0VH9gibsuy80ihvUoA6OODXzjeJ2DVoj3a2exV1WxptxPaJz831dHXpG2ZKwG3LMgUEaKTyiXO+XyXlm9PkB1B8qflpWZ3cnnlh75J2SqlZAfm6TwK7NMqjd1A+qOhM81OXJoAvxDArWzqpOq3/C+YteNT9nqZZTvEeK07lUrhBAl0sKV5H6iyn74cOqit4zcSZUIjNBC+0o6WtwuFoZ5G8e5adcWjHvLcb6TgmGnIv/NI7ex/rckYWlfE3q+A+AbYJKllwyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HC0eJgFziGEph82vDk10qZFJz+Ry65qksuxbuq1pnI4=;
 b=zKYNd6D0rue3aHwH/lvXKpjhjnx3POgQ1WPDqI5584w0YBU0wJbR8ahL2U/2dbnudsQb+qfocikw/Otpl84Jw0kmOudlLDDbgzv+V3IONn+HponB9jsvOICU5Z0UF2nbKqdZUZDGNzAaKiITYakcs7HAJ7sNnuosu0F8bCitYohI2AABfQ/uzuHbp80poaFJ2IEi0FXrGdTU51CWyrrpx1SyOeZxgljneBRRKeVPY1B8vGdl5cr9gicDhYcjaUrOc1Mm/1bmJtudDmKFhHqX1fjYYsNjinJRIyv7co6tddjib5t79uIOEnPsbODE7lIgBIhGxU6tKgd4AlxcqW5GEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HC0eJgFziGEph82vDk10qZFJz+Ry65qksuxbuq1pnI4=;
 b=RiSUtL7FA/uQ5g32zkkvZNn7RFBHDul16d7eNSCcfJFPHL5XQPn9RXAYUCWio5szoSj5UeIjTquIkBaIkQfSv6mGtnoqICQNdE5KgdEpszmzczzuuZgjtnihAYjE8HQ7lwbREgSXCoGFlAuGUUlsxssC5OPeK8KVimZBIL5fPek=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH7PR10MB7010.namprd10.prod.outlook.com (2603:10b6:510:274::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Tue, 17 Dec
 2024 20:51:57 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8272.005; Tue, 17 Dec 2024
 20:51:57 +0000
Message-ID: <870c2e1f-eb60-479b-9429-761810cf8e5d@oracle.com>
Date: Tue, 17 Dec 2024 20:51:53 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 09/11] block/bdev: lift block size restrictions and use
 common definition
From: John Garry <john.g.garry@oracle.com>
To: Luis Chamberlain <mcgrof@kernel.org>, willy@infradead.org, hch@lst.de,
        hare@suse.de, dave@stgolabs.net, david@fromorbit.com,
        djwong@kernel.org
Cc: ritesh.list@gmail.com, kbusch@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org, gost.dev@samsung.com,
        p.raghav@samsung.com, da.gomez@samsung.com, kernel@pankajraghav.com
References: <20241214031050.1337920-1-mcgrof@kernel.org>
 <20241214031050.1337920-10-mcgrof@kernel.org>
 <9fadee49-b545-440e-b0c9-e552bec1f079@oracle.com>
Content-Language: en-US
Organization: Oracle Corporation
In-Reply-To: <9fadee49-b545-440e-b0c9-e552bec1f079@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0122.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:192::19) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH7PR10MB7010:EE_
X-MS-Office365-Filtering-Correlation-Id: 287331b1-528a-47ef-7a7c-08dd1edca52f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c1Y1M3ZSdlJabmc4NUdLT3c2UlMxOG1UcnUxNlA0YXlQZDFFTnAzdTJUb2Zt?=
 =?utf-8?B?WlRZQ2JLMGVJUlpIMXVFMDB3Q1NnS2ptdld5SGFyS2w0dWhjcnlINEhreHU2?=
 =?utf-8?B?UXBiRVpnT0o2L0VHRmYwS0UxZHJDL21EVmhFUzhrcll1bXhoVzNvcjNRWWtO?=
 =?utf-8?B?N3dyU2Q5dVpQQ1J5dEpRK2ttRnR3dy8wdXlpRm1wSHR5Q0k4V204TGZxVnk2?=
 =?utf-8?B?TTlWeGUyUGtsMGs5aWxnMTlweHBoWHJZNmg4azJtK1pPKzRFNDhIMEp0Ly9F?=
 =?utf-8?B?dFY0c2hCT05SS3NZaTlpYzYxdTNJSmc1MDJRSUNma2ZraUtUdEkxZGRKMnR6?=
 =?utf-8?B?bGsyN2JaZklHV1NQV1NpTU9GN3lMaFdFNkdJWTROUjBZOGx6aWhmbjFvd1hS?=
 =?utf-8?B?UjdSTGMxSSs3NXllNVpjMHJRRUY5TndaWmZEL3ZUK25paitiOWxpSUFueTBB?=
 =?utf-8?B?L1ViRDlFcVRRYU1oQUg0UmEwbWRXV0NGTEg3cjUzczU5dHdQQjZIQTNSSVVV?=
 =?utf-8?B?bERpUkJHTnRSY2Nhbm0rRUlPdjdRVGZWQzhYR3pEZnB4SHN6SFd3NDVVbU9y?=
 =?utf-8?B?SFFsQ3F6bTFkUnRjQk83OHZVT1pWdEowdVJXYVFaQmI1MFRFV1JQVlE1T1pI?=
 =?utf-8?B?ZFVyTVZGYzk2eTJuTlNxWnFUSE9PUDhrVDc2WE9MbTdCcW9aeng5UVMxZVZa?=
 =?utf-8?B?U1VMZkVMZjUrbEJnOEkxYmhsdnFhRkNTMU5XZWVIaXpOUlpuT0lFTkV6LzlD?=
 =?utf-8?B?Wi96ZW9lS0JjK2E2WXRiK0s2V1A3ZkNpMktsMlllUFE3dTF1eTc4VnA1YmdT?=
 =?utf-8?B?Q0haNUhEaFV4UVhzbFVWbmVTejRDVWJPa2dlUytRYnZOQzVhZmJ0alhxMDFl?=
 =?utf-8?B?aXJzWVRFUngwN3A1Ym9FVXFvVGFJVzRtTGprVDJWblpYTGo4c1c0SStGSEtP?=
 =?utf-8?B?Y3hiUCt0UUVNZUlwSVR1TFg3bi9GK0tyWjNpVkFJNmVCcFhZWFEyT3lkNEY4?=
 =?utf-8?B?MlRqRVNXVEdQeDNBVzJsbzl4dHh0Z2JId1VrdFhoUVBQWEdOQ3h6TGpSb0Ev?=
 =?utf-8?B?dlpWSlVOR1c3ZUxESnJrWVBHenhIYitlSG9LNExHQ3R1cmJKWVptU2dPMEQ2?=
 =?utf-8?B?dFY5TFNrNFgzNkRDaWRScHFOMGI0L2hmN2tHQUgwQ1hheHJKRVBrSmtSOEdR?=
 =?utf-8?B?ZzBxa2JKQXoyRS92Q2sxWkQrVHRJekljTjdHcCtjR2RnVWFJMTIzZEp2ZlAy?=
 =?utf-8?B?U1NtbTVpZFNWaEJpRmZjbDA2eXM1cjJaYU1oZkwzdDF0MERjSzl1V0ZZN3ZR?=
 =?utf-8?B?cFd2V3JnYThLeHJObmdySWdwT1JoREs1ZjNSSUtPd0RvVnRqMUFNOU5PTEEx?=
 =?utf-8?B?N01CNm94NUNia1lTMUlpT0lqRkZPVzFUZWZCei9IYW9Md3JOem9pRnZHS2Y2?=
 =?utf-8?B?UmttSTNUUFR1RnUxcmV2cWR3UDBRY3VjSmZPMFRWTTVUZXAwbUdRMDMycEJM?=
 =?utf-8?B?NFI5REw5azZVNGhEeHB2Uld5Q1VjQU1KbTVIcGFLRUIzMi80NE1MZ2JYY243?=
 =?utf-8?B?aXp0RVI3S1BmU1c3SHV0SHNrd1YvcE8yYW9qeHo4V3c0ZXZYUTVRY3JweEV1?=
 =?utf-8?B?MUpabzNnQStiREltZjJtYjRIbGN0VS9WM29EVTVpY0NSandwUlJrMjdPUm93?=
 =?utf-8?B?YmgrdVlaeEdBQjJZMXZYZ3BYZ2gwdUdoZzdyTHNyVnppVzBmVnZyT3hGekQ5?=
 =?utf-8?B?WWlOR1FtMlp6bkJtMDBvaEpEcm8rcXh1TnJWVjF5VHBvZnQwalpPM0JMSC9W?=
 =?utf-8?B?NDNtYUFnOG9HcXlQRytwMkFGb3VUWHRZMnRVYkY2QXhtdnVrbldLaWtRTTBM?=
 =?utf-8?Q?WGaso4/CT3lam?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TlBVU3BHZ3Vkb0FNelhxSjcraGR0ZmtON0x3Sng0T2RiL0huTHFVaXZtMFRS?=
 =?utf-8?B?eE5JbkpNL05QazA2aHF4WGFNOGM1Z1hyb0J5VkhlUTBXSTdVK2w4TVNhQVhS?=
 =?utf-8?B?aElOa1YxVVdDSG96dXhWeTFwR2RDMHVwQkRTU0NDZko2RnRtd3pFMkJFWjlq?=
 =?utf-8?B?cU5pOXFSb21mZUhnQUFxd0RRNnRUQUFySFRDSk5kdWxRNWhvdWw2SW5PcjdT?=
 =?utf-8?B?TXdBS0JNbFg5c1BMSTR0eUt2MDhvYnc3L0s0cGlrblA5dTFLek9ZaitiemM2?=
 =?utf-8?B?Ui9XSVlDNEg3UzFnbkxlMmhacWd0SGU4UE84dW8vTTVLRlRHcUU0b3ZGNTFh?=
 =?utf-8?B?TWtWeE5pUjZxWmR0YXpPZGM4MVdlMENIUmdJNGJYQnR0NysvUXZHQXMzeVk2?=
 =?utf-8?B?RmxwWjdIV2wxMjlsRWppYll6Y0xKOHhwODFTMFpKOEpLRk5hNUVZdEh6akZ1?=
 =?utf-8?B?amdQNlNJQjdRY2wrMW5Bb0R4eTFjVUxYZjVBZUZWeTIxY1paazcwL0c5d29D?=
 =?utf-8?B?N3Z6ZldSWFRBQW5hczRXQ3NjRktGTHZlTEh2TUJOei8vNTIzaENiWFNqVnE1?=
 =?utf-8?B?am1jRDdqOXB2anR4cmN2b24zazhleDJnelErdkVHOFpFZHpXaFBtTUlYZ1JT?=
 =?utf-8?B?NnJidmllRERyeEh3cU5MRkJBcmhrMWRuSnJGZTJaSW5EejBJcjRhZ0lKeU1h?=
 =?utf-8?B?WE9uR2xoVmU1a3ExcnFpQ2FxVVJ2YXp1ZjV0clltRWlHWUduMzJXcmN5S0o2?=
 =?utf-8?B?bjNWMTBwbW1nRW9LVjBHdVJpVlJ5d3hnU2xraFhlN1RYVHRjVUdteXVabTlM?=
 =?utf-8?B?MGtHb2dmMHJybUtRekdnVUZIenlzMnR5bytla25VQnpxZWdGR3pVUUZ6SEQw?=
 =?utf-8?B?bHN4MDFFRGdlUnJyWDhYZjJ1K0lFWmRWS3hZZFpsVERHNzdNRU9CU3RYWENG?=
 =?utf-8?B?NmtCd0hQU1JoVzMwUDlmOVh3R3dHZFMza2Nmb1hNSHpHV2ZlWGtQTFl1QVpl?=
 =?utf-8?B?aXRSUWM3ZG1MUkpFZFYrWmdQZXVkUXR2T2JQRnhnMmRQZjdmRy9Pc1dldnlp?=
 =?utf-8?B?YVhrZkFpandoTTZFTEpIU3hwVmR5OGFqdHBmN1ByZnJZQVdzdVZtV01RN1Uw?=
 =?utf-8?B?dXpwRS9oNVNETFZRcUE4TGRGUUtxa010SzBvSDN1RlJqRVNTZGdZZkx3eCtU?=
 =?utf-8?B?VnQ4NC9LVEZwODE4KzFnQWprSkV2OTk5YnhwL0NNeVNOZTdRN1RpbFI3WjV0?=
 =?utf-8?B?YkE1Rm1TV1gwSUxjbEkxdmNaZ0lqL2MzUGsxVE1LRmEvOWJuZEdkbjBXZGVF?=
 =?utf-8?B?Wi81VFV5S1NuQTd1OEZ5YkFINWNTeFZ4TURiZ0VTMWFSTUdIOE9RSEVFUUhh?=
 =?utf-8?B?UU5XZ1Y3YnRlSlpsdVJzNGM0QURIMGRWbGphWUl0d1B6VUN4Z0hXSU80d3k4?=
 =?utf-8?B?RFNPUG1CQU90elhTK2cvbmRpL25oam03dnhZdDRWalNZRHZINzFhbUx4TGVD?=
 =?utf-8?B?VTdINGtXL0NpWDQ5WSsxYzZwTU1kREdnbERQakd2cXl4Mm5yS05FZmFCczMz?=
 =?utf-8?B?WGpXZjYzMmRkVzJiSkt3dFlFMVQ1Q1NKSHdZRTdrTWdBb3h5Q2svcVpBZlVT?=
 =?utf-8?B?cUxtNTczbHVpU0JVbjhxK2lBY2RQNGdlZEZmR1pYNWdOTW5IVXNESEU4QlhC?=
 =?utf-8?B?K0RveFM0MHgzRnZKSmlKaTVuUy94dWRIZ3JRVWhVZ3NhN3lQQTVxbjNvN2Fl?=
 =?utf-8?B?UWYzQUl6cjVFVmdnajVQSElqQnlscFpualJXVE8rRlVMdTRqUU5mbmIwZU1a?=
 =?utf-8?B?MEE4cXFtejZiRW50T1B6bkZ1cGdzL0p1dER5Y3BhNVYvRTVKZ3U5OE02QTRl?=
 =?utf-8?B?NXlMUVNRa3Vsd3NXTXBBa1k1ZkVmazhMSTdycG1Tb2hnVDRGMTcrNERZd3ZH?=
 =?utf-8?B?UmVSNUk5Zi9QOU1jaXdVeEMzdjlJM3BiS2VNaitTUXVQMVdHd1dsU0xBWHM1?=
 =?utf-8?B?OCtUSkRHYitOK0h2S2dJL2JBQWZ6UDErenFQRVB4a09YaFJ0Q04zSnlmN0Zm?=
 =?utf-8?B?cUxnQjdKT3lGd3NuOWlZVXlVcWxtdzkxRkE1Z25CdUtlcTllTyt2UlUvcjZh?=
 =?utf-8?B?VUNKS05EZVkwUXk4U1IvUXd0UzRvOWNIRE9JeFZCTUxGaXdIVHRCUHYvN0Nt?=
 =?utf-8?B?V1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	olCb2jU00x9ZaXbzXf/BpI7KwzuGejSzf1/OL4Io5M+VzYgjsz6o8grWsecpOdv3WM6R7t++2ToBeeHRxeN8KXjaKuJLs5biD+IBjJxA0oRDxvx+UrSN44/rzeyp8RyYbQm72kHMMfbFf8udg4OkMAPrhadradHCw/6nl1Ptbo32RvVuSbj1aDieQMBuqsH03lsSebNSjirU74eI622yrcgicH/vZk9IDBAWLA4qxLEeL9evAl0Rw1SVabwvroZ2xlKR07mQJ5AV15TtViv4UesJBSP2V1VuZxwEguezm6yy01nTJyXoDMMKrhhkABi3/QY9g7i1iAPN5DP/E8Cs8jriAWeW+2X+yTvs4bFKS+LnHIF4FhNrK+c4u4Yh5sTlM8bUMFPcOXbr2a481xdgWgGOFlWQ31yAweuNvPNm/uxWeRamXzSOtOU9lUvC6ogz+AOU3eUujGHgTJ2uSy/IHbBRZbL8xexLZ9g5mJ7IfNEo/logZahZrrfnuLBvpzawDPblES0LM+1J7ktZ61T8DbTthhusXgJzj/y+LsG6S/K5u6GL5PzPUSazDWoWfHLui75la1lCuidBMez3juKkx7UlkzDYkABBxU8EC3B84HA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 287331b1-528a-47ef-7a7c-08dd1edca52f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 20:51:57.5061
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I/GFg10E2rELsmxfZVDkFbimkBBslDj1E8fCA02W9DPQGr6AV7aom1bKoUYqoOWf6pO1jFP0Ub0uppAo1ILoYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7010
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-17_11,2024-12-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 bulkscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412170157
X-Proofpoint-GUID: Y34FPOJzIjJEnyJudbTgyKAQI9YOBslg
X-Proofpoint-ORIG-GUID: Y34FPOJzIjJEnyJudbTgyKAQI9YOBslg

On 16/12/2024 08:55, John Garry wrote:
> On 14/12/2024 03:10, Luis Chamberlain wrote:
>> index 167d82b46781..b57dc4bff81b 100644
>> --- a/block/bdev.c
>> +++ b/block/bdev.c
>> @@ -157,8 +157,7 @@ int set_blocksize(struct file *file, int size)
>>       struct inode *inode = file->f_mapping->host;
>>       struct block_device *bdev = I_BDEV(inode);
>> -    /* Size must be a power of two, and between 512 and PAGE_SIZE */
>> -    if (size > PAGE_SIZE || size < 512 || !is_power_of_2(size))
>> +    if (blk_validate_block_size(size))
>>           return -EINVAL;
> 
> I suppose that this can be sent as a separate patch to be merged now.

And if you want to send this as a separate prep change, feel free to add:

Reviewed-by: John Garry <john.g.garry@oracle.com>

