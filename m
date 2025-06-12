Return-Path: <linux-fsdevel+bounces-51459-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C66AD719F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 15:21:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B8EA3B4EB0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 13:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A9D242D63;
	Thu, 12 Jun 2025 13:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UKVFuon0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="SRSxeht7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCBA25B1FF;
	Thu, 12 Jun 2025 13:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749734145; cv=fail; b=pNabbntYI+13FrXxzprL2yZm8rojBtAetjm2Ynzv7JbncVQpqZTTNVUp5GnPGKamUYsevG00DEMHxJ0Fa7/3JYltuud7MFZER7CjzQbb2pVTC6safLZPULHjeliEJjC7SEdMmTtaTO/wx8mnNwvq2irKtXOFRcwfSV22wkrZWt0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749734145; c=relaxed/simple;
	bh=x2PdTFcVC8hCQkpJeYYN0uxm4n+dka5rJmKxg3JRgd0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kGRlTRUWxjEXe9va1BASobk15S7GlvSdYznLV0p2owuH161qLJWNmq6jK2rR0Sofl/Zv5ZjQEwMtCCcbkqDoPcwy2kobAndb3JVxNF2pQUjHyigZ+Y2yXDjZTxGAPXKqrtmb7Vt1a11lZDof/RHcsM8KgDk4rh80wzY1a3smg/w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UKVFuon0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=SRSxeht7; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55C7fcLq022116;
	Thu, 12 Jun 2025 13:15:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Oe3HVy6F7flwe5caPSAadhkzKPwY10M9tVnqbBQ98ag=; b=
	UKVFuon01jGWXCW0rcuYo0NPmrKvrfNHPZrsTp+pP+NCPfkqRX11IMzqJuWImZSZ
	DCGt0i99A3E3NQRRfkv30pSTYZ7L7gV4LRVZlOYJLIsifZOgrFKTm4PkmgauC063
	7XavQ27uxLBLal6s2ol6t61aXfELslS4CLoJICAm4ncSIozMHXDrCCIYEoL6BO8R
	eFCl7zmOAJB2CrO/LAG/Isv3khVmQjmmP/eT2oHR6sPQTgYR00J+Buixg496jC8A
	jHigEbJNp4lEcn+HnEAp9uvWItZUUIETghMZC3ApXTF2AEn3Of+C0r2ANDZ4ik90
	5jjgMDnq2WlRxCK//U4tUA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474dad9j97-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Jun 2025 13:15:33 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55CBToi3037950;
	Thu, 12 Jun 2025 13:15:32 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013022.outbound.protection.outlook.com [40.107.201.22])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 474bvht954-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Jun 2025 13:15:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=foGDJucdTmXRUgfdyDW6ic6Mgcb+WjooXnfTDYI21fBfhfCkk6ZDp8SdbuIKS19guCuD6fhtDXwCjuZWh8MxLjfGKhye44Adczcxxthp+ZZO9Xg7UeeID6jTuGoeP9IceEIucUDBUXnLgNwWGAAQ42JKNidpVaA9dfPHPd1Q7AozoWQxPclc11X0vQplVUxz9XQ86dadrlh7ZgWI+47R/AMLBoGmCQZ8OD88/VqStCwdUwYSWIJJjzztZv1ptGwO5CvBx9Xt658b0SqwUI/FjQKBXTraa8LyHbem7jY5ooSrkMsjAivFWINbcRl/8rHk7l95PT6gVeVygbVdcZx6LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oe3HVy6F7flwe5caPSAadhkzKPwY10M9tVnqbBQ98ag=;
 b=FHGJkKk7m8s7HSYbmYyqt/zKgEyZ6wbk0N3tBoIQA0XH6tYLBxOJLFJTG4knJ3iH7d4beh1be6KEkChRIZ979xgUuzioaiW0rMqKQ0fBMehdkEaKqY3b4ApwJ3PtQS3WElNz8s/vaLV97phdzC28TUoJFpWcAjuV9pTVz1Y0RK7eWsWs3lmTscD78WPesNHCVfuz+78/V8r+v0ETmWLeqfCTk0dvasDJm/Uzkenq4g1942rTXjYomMAra+yW5g2FWGPJ1FrhRun/feJXQ0aA0nrvFNTadv7tkL7Lk0jV4LoP+mTOxTel8I7fGcfmzHki0UzcWQWOe/gkfh04L8slQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oe3HVy6F7flwe5caPSAadhkzKPwY10M9tVnqbBQ98ag=;
 b=SRSxeht7+N1U4qUGq4ZLgbkrznnwHRneHgfc0m4Y1yyhmbrMUWQaCiSDlhwi2pYJa/RJDjnTdrB0/U+dfrt93Gk1B25YC5YxdfD9GyzqIlxYIuW8T7b5iUKGtvNvJ6LJ7sqAjpDB4+/rq7Pjz83MtKc339gG5oqFvbDF5ja8zo0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA1PR10MB7588.namprd10.prod.outlook.com (2603:10b6:806:376::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Thu, 12 Jun
 2025 13:15:24 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8813.024; Thu, 12 Jun 2025
 13:15:24 +0000
Message-ID: <021f7782-e88d-4f60-8f24-2372c2478dfa@oracle.com>
Date: Thu, 12 Jun 2025 09:15:22 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] NFSD: add the ability to enable use of RWF_DONTCACHE
 for all IO
To: Christoph Hellwig <hch@infradead.org>, Jeff Layton <jlayton@kernel.org>
Cc: Mike Snitzer <snitzer@kernel.org>, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
References: <20250610205737.63343-1-snitzer@kernel.org>
 <20250610205737.63343-2-snitzer@kernel.org>
 <4b858fb1-25f6-457f-8908-67339e20318e@oracle.com>
 <aEnWhlXjzOmRfCJf@kernel.org>
 <7c48e17c4b575375069a4bd965f346499e66ac3a.camel@kernel.org>
 <aEp-HYht82wLT7Vl@infradead.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <aEp-HYht82wLT7Vl@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5PR02CA0009.namprd02.prod.outlook.com
 (2603:10b6:610:1ed::10) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SA1PR10MB7588:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f85c0a4-eb23-4ac5-009d-08dda9b330ac
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?UjM4NWMza3Ivbk1rSHh6bTNCTGhMTEEycDNBWDA5VWljZUJGMk44WHZHSTBr?=
 =?utf-8?B?eVlIUTg2TFNTYnhOZ1FOMFhJT09jc0Jlbks2a2RPelFwQUd4bDN2c29qSkxS?=
 =?utf-8?B?S3JwNG1PWWk0WU5rRm5OekUzUjlzWG42ZFJXK0wvbDJQdGlhMFZZZnE2ZTU3?=
 =?utf-8?B?QkcwN0FaSmd1YUJFVVg2amJVL0hWQXBjcWRDRXBtYkZwbS91Zlpqa1RVUEl1?=
 =?utf-8?B?a1JOSlcrZkZJK1QwUW1hOGlpZ3hKdmkyaHh3Uktob2YwQTkreGQwN1E1L1R2?=
 =?utf-8?B?eHprenR2UzhnN3BFdWJhSmNBR1grWGdLendCamEzUVg2ZEZQVnludWRaaWYr?=
 =?utf-8?B?bktkeVIyK0RQWGNtWmliNnM3UUJVWTIxS1RCWTQ2eldOc3dmdEdhV3doaURo?=
 =?utf-8?B?M0c1bkZOM2pjb2w1T09EL3IvcnRiMnUvdXdOT1JFV2VLemNxK0xkTXE4ZDhO?=
 =?utf-8?B?SGUxMzQ2eE0yN09iODFmT0RHV01mTlFQV1pRbUJBZXplMGZKcEtrNXZqZ1dm?=
 =?utf-8?B?UWlLaHkvb0VHV2lVMm5kK3FET0FnUmwxbGNXb25uS1BLRFZDT2xEVEd4Qmpj?=
 =?utf-8?B?SjdtL0NtUEVwMitET3pkQTJYSml3TzdYVmdxWEY4cXh4V2dCM0poTGlhTFVz?=
 =?utf-8?B?TzR2NGFrUU5VeE56QVBrQnVhSnQ0MVFiS2pBc0FCSzFnU2c5OUg2M3ZZWmNk?=
 =?utf-8?B?MFpTU3RDYzNWRGZiTFNSNWgxd3BxL1pFM0d3RUQwVy9pOVdNeks1bzYzUFBn?=
 =?utf-8?B?UG0rZU9zU3J6cjIvZTRTaWZYUit0V3NpRjB4WXdCSWN2K1I2VjJqVUR3aVdL?=
 =?utf-8?B?NmZ6dnlYRU1uRllwTC9oMGFKMnZhWDFrUkhUWVI0N3FFam5YdzVlWnZqeWF0?=
 =?utf-8?B?ZmhiSjdQbmpFejd0RmRrVEUyTmhKZzVKbVFBU1hVTEZ1Y3p1QXNqWUZsdUJM?=
 =?utf-8?B?bTlIQUlJRm94N2ozV25ONDJ6allkY0ZRQlpWUEo3aElmTU5hQ0NvdUo5VVFL?=
 =?utf-8?B?czdXemhZSkx4eWM0cVVNWFdBemxSZXpWQlFxQWkzVm01NmZvYTd6dmZVTitX?=
 =?utf-8?B?Vk9hNEtuMTBJb1YrSXM1enRHTEZZejZwRnVVY2xvaXlKZ1hjV21XeTRGQzhP?=
 =?utf-8?B?UFRMNFFvLzBWaFRGbFMxUkYxNnpCcHJ3dTFFTUFEMlVHTHJXTXlQMmRSRU1i?=
 =?utf-8?B?eTh6a1lCT2hlU3ZKVkdSTFVQZlFiNjBMaXpVazVnajY0UE9hSEsxWG5ycEJv?=
 =?utf-8?B?SXhVRENIYzhsSElYYStpWGFvdklpT0V0MkxUNDQ3VXVFUXNzc0sxbWM0c3kw?=
 =?utf-8?B?MktiOW1FVWFEdERsMDArM3BocEtxeTlrSmh3aUNEVTZycFlseHkyWDdMejh4?=
 =?utf-8?B?bGVSWVF1V2lVZEhEWllXRXJZRFVmeEFHS3ZCeTM2YXNjNHBqOWo0RE9JWGZF?=
 =?utf-8?B?TUkwZzBreUtoL1pjZkdtTHBqMTJJRnVXL01CYWsydTJoaEdNTCtrRTlhZkpj?=
 =?utf-8?B?VU9mQkpFVWZuRmFuVGxFVXV1aEg2WHNvazZjZ2Z0cXMwVVgzd2NPZHYvWGFL?=
 =?utf-8?B?d3BkTUNzb21jODZYbnpIYmJsNVVzV0FoYTV3TXhRazlVeGdWWnNSU1F0Q3VQ?=
 =?utf-8?B?OE1leDFhRmJLQ1laSjBvRHkyK0RFTldRQXdhR3BMSzVmd05uMG1mdXFKYzFi?=
 =?utf-8?B?TER2RVZuQWsxa0JwVTZsRWlMaXViM1pXanFEMUpzVVZxaDZiSFdkTGJQKzhJ?=
 =?utf-8?B?ZE1QTUpSS3J3enJVd2dXYTNBRlNDTlBmREpLNVdwMVVYT1I1YkdWWGZvNHA2?=
 =?utf-8?B?M3ZKL3ZsTUVCbi92K21laGFQdkw3R2k5VWl4RlBnMDVXS2JmKzNENm1mV3ZI?=
 =?utf-8?B?bitsKzk3UEIrRml2c1c0eEV3ME14d0VmQUNFMjNVODd2VGY3S1hiRkRtVFdv?=
 =?utf-8?Q?ZUgjFsBFPyo=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?ektuUkhwb0UvamdsdTk0Sk9aZDQzVmZpRjhrR2FIOXdBSEh2ZlRZSmxJK1FT?=
 =?utf-8?B?SFltQkI5S2JuUkRmZHpZRGpndXFRdmc4bHZCTXEzTnd0cy9paERYc3VoRDdJ?=
 =?utf-8?B?bmVKNUdHRGZSaXFRMW9oUUxnaUFjbU1La0Z5QjVyWlhCOGhkbXB3YUpqaEhV?=
 =?utf-8?B?OGUzbEJlbWliWmlhMksxV0l6cWpUcFgyQTVEaXN2TE9DUnViQUVCU1dRQmRt?=
 =?utf-8?B?V0lPUDFGVENOTW9KZElDUG85UlpBU0NiOWRLTTd1dVUxU3ptTk43dVQxTmcv?=
 =?utf-8?B?RUg3SkRyakRLK2hUZUZBR1g1MlJvZmljaUZKYjI3VE9DblNMY3BxNHNid3h2?=
 =?utf-8?B?dzdseFdEaG9DYjhlVFVxUElCc1hWaWVIYklSY01ETVUrYWlyUm5RaUhxWFlF?=
 =?utf-8?B?YjFpQk5DNkZDMHRNekxEc1FYQXZ0TnEzbWZrZGdMcjBJcU9VOU1HZFAySkE3?=
 =?utf-8?B?UlozUENpZHRyU29tYy9DTURYbTRXSnhrYUF5RjJ4YXZZbE16ZlpiL3MwK1FZ?=
 =?utf-8?B?Z0pod0hqVXoxVStUVUtwMkg5YzlXK250eTc2bTVlN3daamMybU9RR3B0dHZs?=
 =?utf-8?B?V05DblNCa3BERjZ2b292WVZVREN3TWw0bFQ3bEZENFo4ZnRSN2VUVENVZlhT?=
 =?utf-8?B?c1JEMkd1N1JnZ3hqUVh5aEtwRTZzaWIzYlZrQmFJeENtYjh4d3RSZldIWEZv?=
 =?utf-8?B?Vmh2WnNzMFJSL01sbFplR2FKM1o3NnpOVm1vTjZ2T1lDaFoxeGIrdGVFTUxD?=
 =?utf-8?B?VHhySWFiZ1NndDQ4Tm9mZHlHdzdHTm1YWWFKMkRycXFNbkxudkt2ZE5TQmJi?=
 =?utf-8?B?OHV2dlNDaUVGa1J1anJFLzhMU0VIZWEzWUxmNGtJRWZZMjErcE9XWGc1cjhW?=
 =?utf-8?B?bEV2VU5IaWhPQTN6cXp4NmpLdzFvajl1VENPVS85SjcyUFlJQnRFUE1MTnQw?=
 =?utf-8?B?Y2RFNXN6WkxkMDN6RDlXOGRwOEFvczd2Qm53RGxIbUZSbnovR2t2WVM0MGdG?=
 =?utf-8?B?ajFCUGJyeGd0c2xNYjZhaW1nQmJoRElkWGRZeFQ1RVlQd3l1OStZTmgwSW9l?=
 =?utf-8?B?ZzFWNmVCbHprS0lPTk83SFY1RGo4UXFMQ0JxZVhMa3VYeDV1ZHRSRGpyYU5T?=
 =?utf-8?B?WVNOOWl3b3ZqUjFQcU1QSThCYlZ6WTZjaWpyWTRUZVl2R0Y0dVF0dU04WU9t?=
 =?utf-8?B?eWdIckRMZGdDeFUrMkdlUlBaREk5UHVsdEo3THppaWhReGRMaHdCcER2dkdB?=
 =?utf-8?B?UTlKc1krUVRtdXhDRmZGZ0tFWlFTaW5zWGhPbjIxS2tQVmEyVlp6aVZLc0VQ?=
 =?utf-8?B?cFFFaTVxYks0clYrMDFEdjMxZlFLL01zaHBzdGVPUTI2cG1QMTNUWUovZVBG?=
 =?utf-8?B?VWk0WHIzS0VsSFJHUVN1d3MyRjhJVHRCbHcxVnVLNUk0T3R6ekZrdzhpbzBB?=
 =?utf-8?B?a1hWMThlRGhBZGF4OGlsTmpZRjRWQ1NTTndCWkJxWDh6ZFZRYjVPV1kwV01R?=
 =?utf-8?B?aUMrME1qdFBmY0ZzTDFjT1haeHhWek4wV2VrMnAwcXZnY1c0akdMQTVzRUlj?=
 =?utf-8?B?VG1Vbk52UTdWK3pUYnBBVjhCbTkxQXV1cVpjTlhUWUI4blU2cncvVk8yV0dE?=
 =?utf-8?B?NEFrOEJiS2hIQys3S0k3d2ppTWNkbnJUZ29EOWZGNlV1QUtudzV3WHJPU0ln?=
 =?utf-8?B?VmcwL1NVN0JQeU05cGVNT0dUcnNUNnR6QUl0dFA1dkJHRWxDV1NPcFpXeVJy?=
 =?utf-8?B?LzBnNk5BbUlodmRjRXZrVVZORWt2WWl0bE1EdXZ4cUhHM0YxSWpNU0JvRjZh?=
 =?utf-8?B?cXJuand6WWthYU9WRkM3K3NRM0l6Q2dRenBNVko1VHNhaGxLa3NmM1MrOWg1?=
 =?utf-8?B?dVY3a0FmNCtkVkZzbWZUYjN0M2VFaHQvSytKa1lOYkdPSHhsaVQ5SWRjanFD?=
 =?utf-8?B?S1ZXTHYwVUM3QnpaY0RJVm1JOE94ZTZDQUVBSWVRYzVlMWFUNVVqdVhLakJY?=
 =?utf-8?B?VG9EeVAwUGVvcUlKbEEvOWx2b2RvSXVnTlBEdURDdHRFSkRyRy9mZTNGM2Fy?=
 =?utf-8?B?NjhWOEpnNHBRRVMrdTdKbnYyK0pEU2RXM3lNNFFYR09sRzBRcndJc2Z4bkJ2?=
 =?utf-8?B?YTFoQllqRzFMSDhPYjNxNTM0SVNkRDJCNDYydVJrcDB2T0Yvdk9qTkU3K1pt?=
 =?utf-8?B?ZVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	d+zccx3sMywkWGzBVWSskZcTkmhcBDnn9aP+owHYY9lFHOWujBWB75dl889P4m2izSfAPKW824hy1TZNpg4QjbsTcGBCvnrUVZX1ENRQkOA0/ANmY++mOcJAKwV9TnRcAeSbV2dJZror9GKsSJgtOf8d9+IKiR0Fy4sG1WFLUqILQk3+bpquOAByFXJpDB2EEbgcjlph92dOU2DHTeCWR2AK6qP/wU205rmiaWULbzdaGiqGfexrIrwYEap437XcOgLY0RVoKH/CzOjet9e1311eGJG/5s78Gbxotqhstj/yWGUAZA3iL5P7CJqCgjzec8PMWWoitZ3So1UtMm2kRwFNl2lxNPGh1ArcS0zSH3GhSXw5af/zJujHlT+fMuaF9aKG+PZ0qqs6wNC8YsALhXozGC7hD3D3HOy7WL6vtHcXgeN+fOHyQazIAUou0YGbGzRro+gt5q0VscR+bouonkZEN0w5k7CO7OdaYXBw2CYmnBYd0+wBmzx/Hbb28yhMFFiAzWv7k7YzkUxF7TsjroMkrUp9bnLKuk+b3j9IBZdSLgzN0F2VSyY4kuj6I1VB+5m9kDgvKMxnFWJ0cC3xmQQw+DJFjIlU9STry+yQ3sk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f85c0a4-eb23-4ac5-009d-08dda9b330ac
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 13:15:23.9532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MZzOMQNdeC/LrR7JfJfpmBRc3Zq6rSftopTX5BtCffFh3sBdHdFF5s5KrcHZZEKmjwVyg8B/8xPP1WceZom3rQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7588
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-12_08,2025-06-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 mlxlogscore=700
 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506120102
X-Proofpoint-ORIG-GUID: G193nyEtDJuYaIN-yjlxxR-713z_JGeq
X-Authority-Analysis: v=2.4 cv=EJwG00ZC c=1 sm=1 tr=0 ts=684ad2f5 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=TRtTYcYt5kwXhoch:21 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=ncsAT7wJOI67gbZNU-MA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13207
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEyMDEwMSBTYWx0ZWRfXyG2UsNKdOx/u cCDrlCYUTN+aS7uyDnfs/brHDMI9U8KDxsR05bMHD5+XTSE6ZsbpCZ9zcp2VRR+4ByCnNFL2sVw hKfhCYkNxmzsqccrNheu3xEedtxOMV5O1jPdwqtqBDSO3EHiWj8cMlj+9c3hEPvCovUp3RJArj8
 OoD/GGTyhd+AmlSbWoM466SWyTE3H50fiVZA+avcH4AbN6x88rEdDk3KbfdjXhfHKe3rksWabjC t1gefdWT07gXYN5oQhp9u9xEmDmGhZF5C9NNY0T21mADehOO3q2crx/wGCdqsaC28ZeiL/WrwhD GCaufF1kABX1Rf7HsvwgqK5AYI2OzLgakGKiKgliB8N52zmffnFT58cpOsih2LU5u3XI2H/NUke
 31yvSsm0P85R1TMSL2AzLjAq7dQuvrXq74z/pJBuL45GHMzLLePyinLwKuE9sPM+7u+edLu2
X-Proofpoint-GUID: G193nyEtDJuYaIN-yjlxxR-713z_JGeq

On 6/12/25 3:13 AM, Christoph Hellwig wrote:
> On Wed, Jun 11, 2025 at 04:29:58PM -0400, Jeff Layton wrote:
>> I think if we can crack the problem of receiving WRITE payloads into an
>> already-aligned buffer, then that becomes much more feasible. I think
>> that's a solveable problem.
> 
> It's called RDMA :)
> 
> To place write payloads into page aligned buffer, the NIC needs to split
> the various headers from the payload.  The data placement part of RDMA
> naturally takes care of that.  If you want to do it without TCP, you need
> hardware that is aware of the protocol headers up to the XDR level.  I
> know and the days where NFS was a big thing there were NICs that could do
> this offload with the right firmware, and I wouldn't be surprised if
> that's still the case.
> 
> 

Agreed: RDMA is the long-standing solution to this problem.

For TCP:

 - For low workload intensity, handling unaligned payloads is adequate.

 - For moderate intensity workloads, software RXE, or better, software
   iWARP is the right answer. It's just a matter of making those drivers
   work efficiently.

 - For high intensity workloads, hardware RDMA is the right answer.


-- 
Chuck Lever

