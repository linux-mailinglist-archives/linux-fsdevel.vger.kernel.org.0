Return-Path: <linux-fsdevel+bounces-31971-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E55499E9A9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 14:25:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DA54281EF1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 12:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8991C1EF081;
	Tue, 15 Oct 2024 12:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NDH6qCo5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="EAdNG/rk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232341EBA1D;
	Tue, 15 Oct 2024 12:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728995091; cv=fail; b=lCWsF1K4P8OxNPIrMlJcS+pCWi4fvyWO/Yr71iKDgPRzFljuZ4iDb2MeET55/AW50s3/pOGJCmEa73Fi8gIalN2V+XUmGQW9hnTxkSG5OCO0civDNPUoSR+34shfT01uqWk7hZue3n12FLDgTiR14lwgNb0d/NxMOjeuDKc59C8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728995091; c=relaxed/simple;
	bh=OJfH1SzB7IW2ue7N7Q+nc7YIS6cTqeYsh6a25YYRECA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mw92N+vQeALoaluTAEs4+m7zeBdVYHFng0E+yj510TS3SA4s1x5ugIgRrgkZayFqzrsUfn9SDziWAJW8vI2ksEeGTitz04hqy3kGra1ibN6oqgy764AUxIknLCtSYrUMLHnLkWfBIxx8rBYjxRM+V27I5fgsSqwAUcpEr8WWby8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NDH6qCo5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=EAdNG/rk; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49FARRiP019598;
	Tue, 15 Oct 2024 12:24:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=gsywRjWODpWu1jvkVR9Gx9UCixZ9EC57U2221tMLe0Q=; b=
	NDH6qCo5io9A9VEU/CPn6fV9zqaNH4xgv4TVr+8wEnNpPQV2uNS+6veB1/1HrqQO
	llcEMDGZ1G8WHdhTeI1SddU9K1D9YtrJItbqx7bJx611zl6fQjrKfKzYClK3KUqy
	2sQFJZ/lSaYWAPSzpyz+X4JOcWx/tZV50LIgvLXtyVYp56+D1izwN8TP+w3mPcn4
	Etv0C2NdTYEwSLVwQsdG18V4zW26/32/y0363ja4+My+q5mdFmHH7GkLkD47JrST
	IOY0vNTIYbqdLXnM+hWWaNsKhk7Yz1HqtCMsxIkMUEIEmXpepdn+jp6LyX8lvS9z
	Nd63l93HG+JLTuQZphxBPA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427gq7gynw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Oct 2024 12:24:33 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49FBNcOi026232;
	Tue, 15 Oct 2024 12:24:33 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fj7bq3c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Oct 2024 12:24:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wtT2FxxInqEweO10/czlPqjRoz6FZSPl7JPgXZq4Q3UOF9LN3y6V56tnYJnucTOkK4J3JyP4vBEkGdq4a6TTiwZDRWByFVkC5AwxI/3kDbQ/UtF9EqwP1x39qo38H+rTjKnoHh9hGG/Y0EwnZ3EZK1/BI/keWawlut4mLQ5KJwV3toBqffNpbT8hYpOqVbJISni8rucPKDInalEVQXzvDhN8BR82rNQZYDwOm//3f0h6UN5ofIIvB9lbkB2Q5Jqf/38S3LA9T8sgMTAriraxQSIWP2U7I0keKz8coH5DaDtLsPU9lsV3wi0QbbTXkhX/9b64xa4ZUp8AGQLH71xkRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gsywRjWODpWu1jvkVR9Gx9UCixZ9EC57U2221tMLe0Q=;
 b=PoYfJnnW7yqZlPkoW8zP4HNMImuNT52b8/LUQ4Qft6GAGl7QGmxrjTS3oU9hJhJHduSzH3DOto1Y5dGzifiYEmTXNPN8j45cdiBKAauTyHkvRKRkERzLwfd2J06XAty6H9wKd1cIBA78JqGz/A2OK61vcnheuybSF92fwKkJfCVJwtgpQZ+FAvgwYSyL29Woq5O3F202/sMjZ+jHI3B3PCJQ9q2CyNesrKYweKh7ER6LRZVUY6eOPKjGa2W9NaSQel2zcR47VtBw3Ej7KCoIvsfh2BBeoq278bnox2+3Rs9fbSrA3rHnIPxODmQtqu0KN7pm0vXUAUHYnC39hq2pNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gsywRjWODpWu1jvkVR9Gx9UCixZ9EC57U2221tMLe0Q=;
 b=EAdNG/rk2SpjPConkMLgWZNv1hfqWpaKEklZB9cOSdo/9kEkzBFJu+TTnBmwCBMrruLNDeh1DUmiNzX0b3l944C08tHizMW13ZJHWsCny5txrikZQxOWjr/fD2kpWOMrfuLb+zf/+n9iYYVQgOvm0R+MFwaIvLr9Wcm4O4K6dBw=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by IA1PR10MB7199.namprd10.prod.outlook.com (2603:10b6:208:3f9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Tue, 15 Oct
 2024 12:24:30 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8048.020; Tue, 15 Oct 2024
 12:24:29 +0000
Message-ID: <e3c72790-ad06-4a59-883d-72ad68cca11b@oracle.com>
Date: Tue, 15 Oct 2024 13:24:25 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 4/7] fs: iomap: Atomic write support
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, brauner@kernel.org, djwong@kernel.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, dchinner@redhat.com,
        cem@kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, hare@suse.de,
        martin.petersen@oracle.com, catherine.hoang@oracle.com,
        mcgrof@kernel.org, ritesh.list@gmail.com, ojaswin@linux.ibm.com
References: <20241015090142.3189518-1-john.g.garry@oracle.com>
 <20241015090142.3189518-5-john.g.garry@oracle.com>
 <20241015121212.GA32583@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20241015121212.GA32583@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P123CA0053.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:310::18) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|IA1PR10MB7199:EE_
X-MS-Office365-Filtering-Correlation-Id: 19fa0ae1-8a16-49a3-85ed-08dced14512c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?di9EMVVvZHpnV08rNWhtUE41Mk5VdkVJekM0eXJtRHk3Ylc4UndEN1JYaW5k?=
 =?utf-8?B?NTVEdVRWL3BCdnlLekU3MkYrU3pvaXU5WkhvOFBJT3BSRDh6eGJyeG5HYmh0?=
 =?utf-8?B?RDAvNUpFMUJHRGk3YjlhQU1rSTRqdHl0Nm5lRmVNeWg4WGxBUUt2ZThvWm8z?=
 =?utf-8?B?dHh3YVVyN1NZT1hUMWs0UUk2UzZzc0Yva05xV3RtZmxjOGNsSlF0Q3NMUFdG?=
 =?utf-8?B?dUhJQzcxL1FuVlQ2eFQ2c2pCUjFqcTd3dEc5M25iSlFZVWlJK3VzNUhMT3Fm?=
 =?utf-8?B?bDlTb0ZHb1dIS2p2TWlkb2pWMHJ0aHczZy9yYmlPbkVINkM4TFdEbHRyLzcz?=
 =?utf-8?B?ck1sTTZnWVgvWkR5QzNOWlJKSS82SjlIdCtuYjBkMEtzZG5EcjBoN3Q2ZVZW?=
 =?utf-8?B?ZXlRZWZmY0E0VzY1cmpvaDlJb2E2WlBHbjRrUWQxQXlNaHdNWkpVYWM0ZmdH?=
 =?utf-8?B?cG5SVXkvSmNZWnl6U2FUU056ZFcvL1dQc2ZXYWdjMGpSRWFiY1I1dExNT2JO?=
 =?utf-8?B?WEwyTDVaZUZXaDNPUGVzTm9sY0pjUUJQaVpGMVdrMDNCK092TmlhbnhzdDhT?=
 =?utf-8?B?SjJjYlJSRVdXZVFvNDhhSDNxV2VYQ2ZkQXNORC9FNmw3d1d6SnNoM0Y0dVRj?=
 =?utf-8?B?c1VKbGxrTnh0dEM0Q21pOG5YY1h3VnNiSUUwTnZGemZyeXM3UE5MMVFveXVw?=
 =?utf-8?B?V3pqUHRSZENvallVU040VTYySFVzaEhINllsSHI0ZVZHYjk2K2ZSUTNOT21k?=
 =?utf-8?B?a21ZNXFJREt3L3NQeERML1B4eTQ0MzYzUmkwMzdqUVoyU3BjWDg1SUsxUUs5?=
 =?utf-8?B?eHNKbXZOakViN1pBSHIwc3hRL0lpbGhnS2tDMkZnSDkrdzZzQm9YQmxpUHYw?=
 =?utf-8?B?VE83dnhMQnBpMnFyNnBMQ2I3dER3a3UvRENTMXJsYXRZeHFCTVkxNkNSNUlJ?=
 =?utf-8?B?VVBuZXNBRHZXbzI1K1lZYnN5UGMvVUQrS2s4THpPSnZzUkJtYmFUbTJuSitE?=
 =?utf-8?B?MmhJc3FZMk5BUjdiWDBkU1dlRjRVbDBJYlZ6aVk3VmRwVGFha05ZdHRWdWtX?=
 =?utf-8?B?MExzWlJnamNyK3IzVVpBWjJDQW5qalVuWW9XeVJaaEE0VFlzUkc4OGcyS2RI?=
 =?utf-8?B?Q0t3TXYwUTYxT29GeDJ0VkJpL3lUditUemJkZXp1OGplQTVVTFRSeXBHVGhj?=
 =?utf-8?B?ZE9ETENqbDhlOUlObmtWWDRnbmExUjIxdWd2ZjZRb0NkcFlkK1pHdWlzTTds?=
 =?utf-8?B?U3phMlgyWnp5R3Y4SzBDdUdwTGI3ZFhVL0lNbFFzZmpRY2dIbm5hMVpKbXFs?=
 =?utf-8?B?TWhRdG5wa3VuZ2lYZG9QbWw2TUpqWEIzUGRMYmUzL0pvZGFpRnJZK1FPMFBn?=
 =?utf-8?B?Vk42Kzg3UXoramJabjlIUUEwQnRYeElDeHFydjhVR29uYWsxbDNjd0RFb1hH?=
 =?utf-8?B?M1d6SHluOGhSZk5objBFQlpmb2lRWkVLYXIzZVZMdEIzKzU2eXoxTFJ2Wnha?=
 =?utf-8?B?V0ljWGxCR3A4WHVTQ3dGK0hIbWVYL3Ird0d0WjZacnNXOHB1d0M0ckJ6M0h4?=
 =?utf-8?B?aXJsaHFMeXZKK2pudUxHR3ZzZXVJQkdqbmRCeXI5WGNmTTcxT3hjQ0pTcmpS?=
 =?utf-8?B?S1I3Z01DdThLN2VoeGxVSVRTcUp4aHlvWTdWbzF3K2xSUmRUa2xVZ083WnN5?=
 =?utf-8?B?UG01UFFUbkE5V1A0QWRINTAzZlcvNjJkdnVzZm9oNDI4b0V6QUE1OW93PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cGJoK3M2d0JhK0JwTzIzS2Z1RFZNRlhRd2FGWXozbWhGUVhTdjgyRU1MVE95?=
 =?utf-8?B?U1hYQ3B2d3ljL08yeFJMZXZqWUpnK2NDd0FxNzAvSzhlVHpEYllVcHg5SmZE?=
 =?utf-8?B?WDE5Nkg4eFAxbUdyS2lqMXczMVZMZVVXbzRkY1lYaWJReUE4SU52NmRjNmNv?=
 =?utf-8?B?YmkrUmlCUGV3RHh2QUpXZFRUTnVXbXJnbXEzeXcvOVZBRUswVnkzQXNnY0tZ?=
 =?utf-8?B?S2p1N0pTQkZBaGJjSlFHQW81QTJhYUZWNzZvKzlSNWxWVDlCR1ZRclVxMW1J?=
 =?utf-8?B?N1ZLOE4vNkVQUnVHZVdObVcvKzlKcFcrWnBna2RTK3RUMzZ1VkQ3dWV1SC82?=
 =?utf-8?B?WVYzbElxWmduZS8vRnJZR0NmRVRHWG5CLzFXRmFqS3gzRTdkdjZqeG45RytY?=
 =?utf-8?B?bXl3ZTVJZVdtcHpDMmNQaXBQZW9rV1F0MEs4NlE1VjRwWk0zcU1vS3hxQy95?=
 =?utf-8?B?dWpvM3JOY2JIWWlsNmE5TUhveG5jdE9zVW01UVRiRDc0R0FwMGdJZk1yVVVp?=
 =?utf-8?B?S0hEb1ladjBTZEdZTk1aVm9uUlYvRWtQZHJ6YzAyVW9qdW8rWFh4S0s2Z2JB?=
 =?utf-8?B?S3JpUnVwTTdSUnR3dmdTS0o4LytSdDQ3TWN0VFRhVlY2RzNxMFNmcmkyM2li?=
 =?utf-8?B?aytUTUo0OGdITGF4ZjhjUzlnVlE5RzRNVlpIaDdoL0VMSnVPNEtKNXNiVzlx?=
 =?utf-8?B?Q1EvSFVpRGE3OGtka1VrYlNaM1N2Z3phSVBjNW9hNVk3UzI5eUt3NmQ4Qzhj?=
 =?utf-8?B?N0JqazhnOVQ5SENRR1pNWlpjMG9iSEh1OUV3RVMwOE1wM0x5TWxWSWtzMFBR?=
 =?utf-8?B?bXlINTVMTnloOVlnNlYrcXB5ZjRKNWY0clFUZGNkMzN5eGpvdXJ0ek5JbkZM?=
 =?utf-8?B?aEw2MzF3cXl6MVVKZUhLUWxUYjRWVW8zbWhZM09qV1hUOVgyTEw5ZWMvTlk1?=
 =?utf-8?B?ZWQ2b2tWUjcrWnhIMmQ2aGFGQ05RMVNPTXFIRzUwY3dqdnpmV3ZaOGpORGo3?=
 =?utf-8?B?MXMrdDB4LzRVL0kwNHZxYWRocEV4aWM5YjdSOW1ubmk1MHJFQXg3QWZ0bTdh?=
 =?utf-8?B?MmtWc01zZ0o4bmdkcFJ2eUZaMjlTNnFnZXNacnFKSmZySEhCZTNlOGQ4NWNQ?=
 =?utf-8?B?RnJEb1FiQnVraHJ6QU91RjBXNldSR1Z2WHA5QWJya3ZJUi9VMWN4ZkdMcTl5?=
 =?utf-8?B?eGViRE5SSnpMMWhPdDBpRkVKZDF4RVNCOElMMHdpNHFQbkJVcEsrd2FEb2U2?=
 =?utf-8?B?azNBUTBtcGYrekx6dzB0d0c4a1hIejRYLzNjdWpXcVJBcDkxdW91dkdrZGc2?=
 =?utf-8?B?RUdtWlFjKzNLZUdWb2tFVGdkTE5wUUp2anIyMC9JazExN0ljaklleHNCZzQ2?=
 =?utf-8?B?T0RxOWNYSzhCYzZGdXAvTWF2Y2JZS2d4NU4wK2h1bTlaSitpb3d1ZTI5aFph?=
 =?utf-8?B?Z2JJajZtb3Z3S2RhZzEzYU9LeWVnbkh6eGIrMnpTN1NqZzNoamczU1VxZjR3?=
 =?utf-8?B?VGNMbnRSWnRPY09QOFpzaXkwN2V0RGdBV2ZQVVVZMzRlVFprbXpFRGR2VWU5?=
 =?utf-8?B?aFRGcEJkdDNTK2psZFZFZ1VPNm1QR0xoVDdWN1VERnVYckJZbENockZpMkVW?=
 =?utf-8?B?MDlveTN1VUd4dldScVZMbE85K1FpZUdrQkFtQ2FWVEwvdnBGTWZvYktaU2lI?=
 =?utf-8?B?WGhqT2FHV0M1NUxTNWlWWWpUNUVMZXJtVGhoQUZ6YkVPVmxFV2duZlkwczA0?=
 =?utf-8?B?SThiR3VXUjhmMnBQcEpXV0JpWUlCaytOK3h1L3AvaE0xUU5WRkMxMUErZjVX?=
 =?utf-8?B?cDlmZjlxaDU0M0s5UGM5Y1Q2Q0hRL2pEdTZYOG1yOWRRSjh4YTNIbXM5V2FM?=
 =?utf-8?B?RzgvS0FLVko2R2QvQ1BHOWdobnZwRy9YSTNhZ2NUeEVNRHJHOVVrL3dNUW5m?=
 =?utf-8?B?aUc4em5YQWZ3VUVnNHBDOThhSTRYemNpM1lZSjgrWVFZYjBxdGl1UGQxZDV5?=
 =?utf-8?B?bGVmTDA2WldNeXlSejNmQU1QNUpXejkzRmRRTUYydW5odFFKZU55SWhQT3I0?=
 =?utf-8?B?ZXNGYjFQS0cxcDU2ZFVycXhJdEI0bG81dXcyOStjTWJjSERmS3UvZHhXQXEr?=
 =?utf-8?B?WDlSbkJzS3B4VVg5czZ0VE1PaFFXK0dLVGdueDBRb2xIWmt1MXZpL1ZaZzI0?=
 =?utf-8?B?NUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NC5VDfehoaDIow4ZTfTKj9Fe5t7gf4R+66nXg3PlZkZt4gQfyFvHiDHrgxKZrMGlKJuCDix4+nP+zVkrmPrPbtTUvhsWMnybSSzjWZzho+rgwgT0M0WZNC0sulRTVT+Gy4vQoqybVbcaHS/CQLGjioVS8IkeX0W6bkDqHlwcmx9sJ4I9niT6QJDpgeKtAHLJ+dTonca0PSdX1tUOtkdCRj4VJ8jHRp6ikcii0i+UD+apcwepwvGjCZfPBVQhbnnBByoYDqxQHLVYhpANPsfK9T4aJd/SVu7D5NoC4JqiFk4NRVafDw4umL8h/OCjjkFX7BoJzNI3RUWwSnnnSGbH8FtDpLm1yPluqzH0EnB+hBUN/T2PclCUA3DsN1KXRn8Cq4rPzkbHydCjThzn6A/6N4BCCxidhqubuXw0l7AOY2luPuVlSlA5xCOw4XFQ4N7vgeRHzx1an+dO8nz5f/Tkro/T7F/1YhkEydnRAbtyLyUs2XgVfpcui2Qndujjo9eeeBJ4rrKHUeK+0NCHimrer46O5hB7KPWGv7huuZz15hOW/HioUov9oyDUnICU9+WNrgfDXVdL3+gl4I89DxMRYGYck7gjClUH9JG0Txkx1CU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19fa0ae1-8a16-49a3-85ed-08dced14512c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 12:24:29.8797
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MdH0HBJRFUpUt7P8oHWbHPFw3pwJb8ixVOUXxAXloXaoVyZMtbA40MraVQn0y/e7DBembS4Gj80ZkqzxyCAzTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7199
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_07,2024-10-15_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 bulkscore=0 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410150085
X-Proofpoint-ORIG-GUID: Ijk6iEbgAzguXQ2ugUUvcEESO8ar9wfM
X-Proofpoint-GUID: Ijk6iEbgAzguXQ2ugUUvcEESO8ar9wfM

On 15/10/2024 13:12, Christoph Hellwig wrote:
> On Tue, Oct 15, 2024 at 09:01:39AM +0000, John Garry wrote:
>> Support direct I/O atomic writes by producing a single bio with REQ_ATOMIC
>> flag set.
>>
>> Initially FSes (XFS) should only support writing a single FS block
>> atomically.
>>
>> As with any atomic write, we should produce a single bio which covers the
>> complete write length.
>>
>> Signed-off-by: John Garry <john.g.garry@oracle.com>
>> ---
>>   .../filesystems/iomap/operations.rst          | 11 ++++++
>>   fs/iomap/direct-io.c                          | 38 +++++++++++++++++--
>>   fs/iomap/trace.h                              |  3 +-
>>   include/linux/iomap.h                         |  1 +
>>   4 files changed, 48 insertions(+), 5 deletions(-)
>>
>> diff --git a/Documentation/filesystems/iomap/operations.rst b/Documentation/filesystems/iomap/operations.rst
>> index 8e6c721d2330..fb95e99ca1a0 100644
>> --- a/Documentation/filesystems/iomap/operations.rst
>> +++ b/Documentation/filesystems/iomap/operations.rst
>> @@ -513,6 +513,17 @@ IOMAP_WRITE`` with any combination of the following enhancements:
>>      if the mapping is unwritten and the filesystem cannot handle zeroing
>>      the unaligned regions without exposing stale contents.
>>   
>> + * ``IOMAP_ATOMIC``: This write is being issued with torn-write
>> +   protection. Only a single bio can be created for the write, and the
>> +   write must not be split into multiple I/O requests, i.e. flag
>> +   REQ_ATOMIC must be set.
>> +   The file range to write must be aligned to satisfy the requirements
>> +   of both the filesystem and the underlying block device's atomic
>> +   commit capabilities.
>> +   If filesystem metadata updates are required (e.g. unwritten extent
>> +   conversion or copy on write), all updates for the entire file range
>> +   must be committed atomically as well.
>> +
>>   Callers commonly hold ``i_rwsem`` in shared or exclusive mode before
>>   calling this function.
>>   
>> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
>> index f637aa0706a3..c968a0e2a60b 100644
>> --- a/fs/iomap/direct-io.c
>> +++ b/fs/iomap/direct-io.c
>> @@ -271,7 +271,7 @@ static int iomap_dio_zero(const struct iomap_iter *iter, struct iomap_dio *dio,
>>    * clearing the WRITE_THROUGH flag in the dio request.
>>    */
>>   static inline blk_opf_t iomap_dio_bio_opflags(struct iomap_dio *dio,
>> -		const struct iomap *iomap, bool use_fua)
>> +		const struct iomap *iomap, bool use_fua, bool atomic)
>>   {
>>   	blk_opf_t opflags = REQ_SYNC | REQ_IDLE;
>>   
>> @@ -283,6 +283,8 @@ static inline blk_opf_t iomap_dio_bio_opflags(struct iomap_dio *dio,
>>   		opflags |= REQ_FUA;
>>   	else
>>   		dio->flags &= ~IOMAP_DIO_WRITE_THROUGH;
>> +	if (atomic)
>> +		opflags |= REQ_ATOMIC;
>>   
>>   	return opflags;
>>   }
>> @@ -293,7 +295,8 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
>>   	const struct iomap *iomap = &iter->iomap;
>>   	struct inode *inode = iter->inode;
>>   	unsigned int fs_block_size = i_blocksize(inode), pad;
>> -	loff_t length = iomap_length(iter);
>> +	const loff_t length = iomap_length(iter);
>> +	bool atomic = iter->flags & IOMAP_ATOMIC;
>>   	loff_t pos = iter->pos;
>>   	blk_opf_t bio_opf;
>>   	struct bio *bio;
>> @@ -303,6 +306,9 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
>>   	size_t copied = 0;
>>   	size_t orig_count;
>>   
>> +	if (atomic && (length != fs_block_size))
> 
> Nit: no need for the inner braces here.

ok

> 
>> +		if (atomic && n != length) {
>> +			/*
>> +			 * This bio should have covered the complete length,
>> +			 * which it doesn't, so error. We may need to zero out
>> +			 * the tail (complete FS block), similar to when
>> +			 * bio_iov_iter_get_pages() returns an error, above.
>> +			 */
>> +			ret = -EINVAL;
> 
> Do we want a WARN_ON_ONCE here because this is a condition that should be
> impossible to hit?

I have no objection - as you said, it should not be hit. But it would be 
nice to see why we are getting the -EINVAL if it were hit (so I can add it)

> 
> Otherwise looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

cheers


