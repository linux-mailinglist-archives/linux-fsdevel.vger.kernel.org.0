Return-Path: <linux-fsdevel+bounces-48103-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5460AA968F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 16:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B443E1888749
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 14:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C93E2750F4;
	Mon,  5 May 2025 14:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EJRHb1xm";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mxIZJvG6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E819F2749DB;
	Mon,  5 May 2025 14:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746456542; cv=fail; b=FbyHLaZs4IeGTUVoV1LpsbDy2v1iex0U4ZJCR14Hs7igyFaUuWEGXeZyQiRq09IdG7/xNjU6Kc6J7AMOlPWEsV+gfD0+BHpCMGQfpVrswMLiCQZ/5N9jRStlDe8fBEgMTq/3ID4f3LKkjTwGj4wcUxevuWbmlnK87ae2ndayA8Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746456542; c=relaxed/simple;
	bh=HMCaZD008wtfqSj30bXYiiEUioQG7q1pq4RtyTHQa1U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GjSzYeSgqLqL5bBe9n79paLI3Hi+oHY03/0eyVirVJWYpfVlOQqGpUIkhv3gyNfwVlGX++vJvHdX7rz0RGSmUyIIMxN6TejNbUzgzF90XAlP04i3OrBueI3z9kYCN9DqHnMnWvbJVvQ416hsnlT3G7M9ch/3XPS/QnkyiTwHJCA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EJRHb1xm; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mxIZJvG6; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 545EHSXG021000;
	Mon, 5 May 2025 14:48:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=C82b0dGmxSDBuUHLJhdt9IfIP0/sSjsDxAvEJyO24CY=; b=
	EJRHb1xmx2kobX7yIkU3qbrXQMvBMUSXlD4Z9dIF9PRcgyExFVwgB4uo5AvktoRi
	67vPJs6Kzay2M9W9AEl4ineXpLMZNWcOj3gRS2OB9oaHixAw8ZV7qa0quGn7l2Gg
	1KTsq235NRyXWi3ldWigzKRAYEWeebI7uI5Rb9lZy1IMknNcGGrXdt0XOULQHT8Z
	AadSelgVGkU05ZTqlEVIA6H1i3To1KYUO9ULzaPJEIpah7xkaue4L2zabVKWCEJD
	UFv1GJadivy3OsuUbjTrnGtmIcEABivEk3aIXg4ywt2Vidwem/MXoPw3R3ejhzVV
	/imzPJZltNT6z7QLn/4A1g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46exy5033j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 May 2025 14:48:47 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 545EjUjq025130;
	Mon, 5 May 2025 14:48:36 GMT
Received: from sj2pr03cu002.outbound.protection.outlook.com (mail-westusazlp17013078.outbound.protection.outlook.com [40.93.1.78])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46d9ke14wx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 May 2025 14:48:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hbTOZmPxUFd8EpdaTCyAYQFvVBrlhYSbiubQTBr81693LM1B4LBvGAZLA7y/6wFo6MnIskclEvOHr/UmMTivGsbXebO1nGjGYi9jTP1hE5A86RJmfdV5fzZ5BiziXCbUo3UNFTxeqnIpibAgskt8xTtIMUKHTi9cVn4hjJy3EnAYfx+ZiDHuQlfAgfBcm7Al86gKFhC/tPnKRe5bJB3CYk5YrWfsHkMFBXd9dXLc/p+UY7cmeaD//BGbeUpxG/GzmW2WpZ9Bp1vWQYozOV8jZ24h/Uu89iRguOjebuprl66J8ndWwm0XyWDJvaR1KtYYHq5EiXGbIs6CFyKmUhkPfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C82b0dGmxSDBuUHLJhdt9IfIP0/sSjsDxAvEJyO24CY=;
 b=gSGHTtVKVlW0SHfqJPDolxO9rQOFoPhCeHgJpgKdavz12eTlYdzL7a3AYoYdiFXElxkr6NVmquyieESg8JYHp8NuWWhbO9dK7FBHS5dah2XP8DOEqjAK0CDr4x01DS/yeNx0sa6QRQSUrIpElcmZbsftLwUoAJNhrlCLMJZzyZmLI2xqLXhjTDLSI/liEQyqYuVNna99Zc7hcXbKyMWx+/mQBq1OMtjOt+jzUWZ1oh8yqQG3Ezcxp+ff6Jcs1Pk7TkJ1kTGLXJvTv1eiUkIyRAv8ofkN4MjcaInZpOGZhSrEdb8/isPzIDZW9Bi+4rgYzxvNDE/tSKQOkx1rCjHCNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C82b0dGmxSDBuUHLJhdt9IfIP0/sSjsDxAvEJyO24CY=;
 b=mxIZJvG6HE/rO6iy6AZ9M0gmQolM0aK86hp+IK0E+TkW2AX2He+HdFwLR3K6MRMcTqtBbE2S52leJapN4OZntGInFAhrCXtqmRZkPsqIiu4HwITYWXdUlU8vwEIFuFkPiw8u6OW7sgC2pM82XO70Niboy7OHgXalibXqicp7LPQ=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS4PPFA0EC85B6E.namprd10.prod.outlook.com (2603:10b6:f:fc00::d3b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.25; Mon, 5 May
 2025 14:48:22 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%7]) with mapi id 15.20.8699.022; Mon, 5 May 2025
 14:48:22 +0000
Message-ID: <40def355-38db-4424-b9f0-b82bba62462b@oracle.com>
Date: Mon, 5 May 2025 15:48:17 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 02/16] xfs: only call xfs_setsize_buftarg once per
 buffer target
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, brauner@kernel.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, cem@kernel.org,
        linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        linux-api@vger.kernel.org
References: <20250504085923.1895402-1-john.g.garry@oracle.com>
 <20250504085923.1895402-3-john.g.garry@oracle.com>
 <20250505054031.GA20925@lst.de>
 <8ea91e81-9b96-458e-bd4e-64eada31e184@oracle.com>
 <20250505104901.GA10128@lst.de>
 <bb8efa28-19e6-42f5-9a26-cdc0bc48926e@oracle.com>
 <20250505142234.GG1035866@frogsfrogsfrogs>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250505142234.GG1035866@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM8P190CA0012.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::17) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS4PPFA0EC85B6E:EE_
X-MS-Office365-Filtering-Correlation-Id: dcc68a08-f71d-4359-97e1-08dd8be3e215
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L1dJTHEyNVp0Q05XSlRZZ3Fyck04Y1Z0dG9ST25BN1lNWjJodWxrWDVvdi9r?=
 =?utf-8?B?Y0JLdDdTRkN5U0VPeTZIcTI2eFhKNnh3Zml3RkZoNXNtTy95c0Q5bVFLZjBh?=
 =?utf-8?B?OWpZcjhNUzQxaHpCb1BvNDJJQVlIRTZLZThrK3A0Z2xWSkQwdzlJVzVPVnhh?=
 =?utf-8?B?d3N1WXVPaldCYURab1J1ZE1Nc1pHVStYQldiU3BBMjVDeHpsK2ZHZVVhZFVk?=
 =?utf-8?B?c3U1aE54a1pTT1dWODhGaTdCMCtqRWFJYXhHdWU5NmdzaTRvZVE4bkJnZ2Ft?=
 =?utf-8?B?MUlJeDVybnU0Q1Vua0dYOTg3eTVySExvMDB1YVhkaE1pbloxMW5udittYTlB?=
 =?utf-8?B?cjgxTTI2SjBaZWk5UEhRWHNGRkJNSTR6bk9SNTMyYk9uSm53a3ZDeDV1Uzli?=
 =?utf-8?B?SGc5RzIzeHk0UHIrby9LVXZPOWhXRVYvRW9FcVFjWG1CMkZsR05KSkhSb293?=
 =?utf-8?B?Q0h1anpHWHpod2trWXd6MUtqQUdvM0lqN205VzlkUytqUGJFYWpNdVpTVnZu?=
 =?utf-8?B?Ti9XK2RTT2pDbFVBbzdjNUo4VXM4Z0k5bVIvRk1WOThmNG5DNlZZMUdiZFI3?=
 =?utf-8?B?aVUzMjBZYWs1OWp0WHoxWjhQRHRFL2xLTFVXL2hlMmJWUEtmQ3ZuYS8yZXFp?=
 =?utf-8?B?cmtZQzBsbjNsM2cwdHRLYjZzc3RzNVZORXhaUjJsYzNqOXVtMWh2dkhvbVcv?=
 =?utf-8?B?K3RmeVBNaXZsT1gybXI5aTYvWVRyT1pNQlp4SGVTOGFJU1dlMlZucFZSMVJG?=
 =?utf-8?B?VWxQOEVqWWFUNWVJcm9Ia2tLUXVGS3Z4RHlOcU5XTjM2TmtJMU13ZlZUbm1U?=
 =?utf-8?B?cjBVOS8zWitRbFM5Rm1ELzBhVGNWK1lGby94cno2dHp3UVFyeWY2UDZKOTZo?=
 =?utf-8?B?NmxQSGtqMnprS0pDOGY0d2U2K0ZwYTI5djEzUG93aU5sb2tqOU5CMUtkalRZ?=
 =?utf-8?B?UzVxTTFBZ2dDdUJBWXBhb294MkYrbWZEN1ZDS3hBSVFqZDY1L2srUm91YjNY?=
 =?utf-8?B?VlQ3MEpiRnp1RU1VcmtkTVlFdkgrTUIraGlqZkpEa0J3RGx2UkNpM3duZCt0?=
 =?utf-8?B?RjdIM2ttUWpkazVyZHNqS0htK1lWc1kvMGoycHlrTlBIazlJSldXTjd6bDJi?=
 =?utf-8?B?RExsL1JYYkhpQzZabGpqVVJiZTBXekphWkd4SFhZK1gwSWVSSHBxTUZxaEdV?=
 =?utf-8?B?U25WWXo2RzIrR25Vbm5zcTUyV0FnUnN6c3QwMDNTMnU5RXduRzN6QU1YOTVX?=
 =?utf-8?B?L1Zqc2pXejBCUDZlTHk4aDlGL3g0bWl0cC9mL3ZRcTRHc0l6UFRVR1crdEI4?=
 =?utf-8?B?Nnl6WWZKZk92V3BkTklidnUwVlVPR2RWVUVmU0gxN2ZINXpvN3BRdldjcVVP?=
 =?utf-8?B?N21BVmFiRS9HZ0xSSkFSTWRWZFFUOHlFZGRqd0tTWDlPZWVndGlrWjJuUVdK?=
 =?utf-8?B?ZG1nd1lNTDBsR1ZpOHg5eExzdzNlSHhna0tXemNpUkE5anppUC9FV2JLZFVp?=
 =?utf-8?B?WlVoSWloazNTdFpVak56Vk5oTkZSYWJGdHFHYThvbUsrZkJqbGF5R21GT2Fv?=
 =?utf-8?B?RzBVSGxHM2RoMHJqazBTcmtsWDYzOHltVVhmeEF0ZWtQa0FFUjhnMnBQVFZr?=
 =?utf-8?B?ektqZzk2S0hrZWRpNWh5akU2cGdwRGtSd0FNanRPTGJ6MGxmZmNtMkJsNHdR?=
 =?utf-8?B?RkZveUVPdlAxNE4rSVBQUENCeG5hMEZwU2prNGJhcS9qM1FDQS8rQS9aVGI1?=
 =?utf-8?B?WE9GcXJ1NTV2Y2c5RGVhN3dCRk1iOXoxSkVMSzFyaXhJaWNRblkrMFdEMTBh?=
 =?utf-8?B?QURSYUYyUVZERXFtVTM3ek42ZncwWmhYb1NmL3EzaG9neEUweDNGVEZYbGZN?=
 =?utf-8?B?MWl2T0tkQlRDWFJRZWNnSlAvNEZsKzNEZGxNK0tsNlpDeWFJVytSQzV1TTNG?=
 =?utf-8?Q?SepQwFw8P1A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZHRoSEVTODJSZ1RsenNBMHRHeDRCazZLVkFHVjJ5RnNwVUtlc09PVURhcFBp?=
 =?utf-8?B?bE9MZ3lzOVBZbHlkeUZnSi82UlBDMWM1dUdNSEZQK1FzZkZTcFAvT0lmM3FB?=
 =?utf-8?B?NVYrZXo4ZElkTEN1U0czV2E0UG96U1NaTERzSXJHUnp2dlUrRnEyUjJwQ2E0?=
 =?utf-8?B?ZjBGZUt5L29ObnpWbVRDMzRGSWpiV3ZTbE1hU3VEdC95bzR1dW9NUUx3NHpP?=
 =?utf-8?B?ZWJ2RkFOd0lMdEZqOFYzRGZ1ZjllQURSMkZZRTlQZ0lPWlpabmpzcXBZcmt4?=
 =?utf-8?B?YWZCaW8raVBhZDdyN2NHRm5rMkY3SUdaOG5LVkNoZloxNEE0THpETi9NNStr?=
 =?utf-8?B?RXRxRXMzWldDRlpISWcxZm90NFM3VHVOQVJWc2RIeExkYndhSm5FZmlsMWRl?=
 =?utf-8?B?eDhLZHl0aGhDck5IUDgrOGFhL2hhczN0UHpkR3pqRTkwd1MwSUJ1UHVqMyt1?=
 =?utf-8?B?SU9tdnR5aWRPOGZrMTU4aHR4dk5EUm5lMkcwd1g1U0dGR3Y0NXNERmVmcUhs?=
 =?utf-8?B?dE9vMzZGd2s2WjR0bG1GcHJDdFZORlNTNGJNZG5IVy9tRHdDQmdDdGNsNWgv?=
 =?utf-8?B?SkR2dUNIL2tGK0tudzRIbVp4OSsrbzRsRGVnTDd3SXBmYWZ3ekVZZTFGejZq?=
 =?utf-8?B?dzJmRWFHMFJ3NTFTaGFScVBFaVVJRTlRVm1wRlh0eTBoNjFTRmVLbW9sRGxP?=
 =?utf-8?B?MmhPN2ZNM3N6RTFNQ25oVDRlL21xUkM2akVOVnJqV0VidTFLZFFxSVNPd0dl?=
 =?utf-8?B?c0grc24wZkFDdUxRS3YzY2I4N3FpQUcwYXRyOWNTbnRyQkoyQzJqb2p4b1VS?=
 =?utf-8?B?S3FwdTZjYnBoN0pVUTNRMkJOVjRZcGdkTlozQ2owYWozTm1WdmpKZndyRnpO?=
 =?utf-8?B?Y1dLdnBpaFNJazlscUtzTUJCVVNBWE1nOHhqMFNRMllZSERnTFBaR2drM0dj?=
 =?utf-8?B?aDEzT1h1SUlGMG9wWFUzNXZqeTc2aDJNNmVtUnQ3c2hkaFM1c2F1NTFNVjlN?=
 =?utf-8?B?QVlWSGtrU2s2bmRQZDYzOXFIRGxFWUdkVWt2dk9wQ1JWV3Mwbi9xTVYxbkp3?=
 =?utf-8?B?LzRFby9KTmJydEhjdCswekJDeDVMaDRDaHJJaUpnVDJFa2c0UUNJUFNlZmlV?=
 =?utf-8?B?cEF3cXRFZDVFNktBT1QrTk1uRXYzQkVvb210TCtyc1d0YUxEYlFFMHJ0OFVa?=
 =?utf-8?B?OTVKalczWHZQblhVcVRFVElPS1lQMTRZdmNVZ2RtM3FZTmtudHNwcTVCNThQ?=
 =?utf-8?B?dVlHcVEyWU5ZQjdDMUpaTU1ZTmh5NXhIOUxhenRyMmVXZDZSWHRVUDArRXFR?=
 =?utf-8?B?OEJpUjJVMzRvZ1ZhNmxNeGpnZ3NjMXlnT2FoUzZyZXJYN2hOQ0JlVTRJNUEz?=
 =?utf-8?B?SCtGcVVNd2V3bWNtVHdnQm5BNFFudDNadEMvUm43WDRNWFU1NHdQcEJWbXl4?=
 =?utf-8?B?dUFzWVdWdS83NVFUazFucTR3K1Y5N1FucmtITDlCd2paUGVScDhXT3dhOGR4?=
 =?utf-8?B?TzRCMUpGNU9KdzNKenljNm5YS0M1d0V2Q0JuVzI0TFRhTVJNdXdBUWI5dklV?=
 =?utf-8?B?bXJ1VDNmYTdxeWxtL3BrTUFDUjNnZ0pSR0wxNWhzSEYwaDhKNVBnN2NOSXVH?=
 =?utf-8?B?WHcrNlRPQWxUK0h2QWhrK1haMExYSU9rS2xtWFhic3U2QlEyK1RrTzdBSVNo?=
 =?utf-8?B?Ym81RlgwTE5XQ3ZqaTZRbjBRM05vdTJvZjZoNWZvR3hzVmI0cU9tRlZGZTND?=
 =?utf-8?B?cDkxcmRIMm43RUFrZTFEZEgzRXFCM1RaR28yd1JITE5BeFpjc0wwdysyb1BR?=
 =?utf-8?B?RjZoQWtGQWx2MFJKMWt3aGZVelBqeWRlaDcwcnNmdGpuYnQvNEc2cFNQZFJM?=
 =?utf-8?B?c3NYTVoyMmNnQmg4NlVDNjZnbnNJNThQcGJFM3FMSUtkR2hlbUVadGVMM2xh?=
 =?utf-8?B?QTRtZzNzRjU4MzVHWTh4Uk1UUk44ays4a3BjNmtVVUxoSEZIRHhTelVGRmF3?=
 =?utf-8?B?aUhEL1J5V2NhWm9iZVpCdHlncEp3VjVVZ2k5MzBheWFQcWlWUmVDalJmUkJE?=
 =?utf-8?B?SUVJRmZVVzZKcXBsUFFjTks4U3RmaEp5VjVZUDJwVG5wT0VqWTB4cmErd1Bk?=
 =?utf-8?B?NmhnKzJiMmlGVWJlMFdremFwVERUUzBxNWNxN2g2UTd1WmRtUS9HTDFTa1ZL?=
 =?utf-8?B?bHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2zP7rqllQpjMM3jM41+GrxIUKerZnRA49lfLhSwlO4/TZydL+t+JIuL2SMWs3pblKwCBNKQhAr/2bN9xJ84TZeew+2cr0rowa/HYPj3s1Z5nYQGtP0b/atXmZyKoCizNxc9d5lTKuZBcHCAUVk6wKVj1CDuKLfPQYv47M3qIWUk2fNybro8rZ/4ZSgsvW4ZthsPVdIbbOol4PbGGLQG016LHZdPJSO/VIADSgeWaax5c+wkM3zCkGCJZXm5araxK+8/lo28BdhPvHYdpc3BW5bYBCCdS28OSYG1tlg6KUovnH6l3XxWfG2iMcGhyZbeSNfFiwWfFDjcGIsQjq/vQiNvsyNEEsViDcAHK1gR1c+lrHkDr6C7hN4RyTRSGuynWMU8WVL2VFKAwipr2w0Lso+iorcsfxBuF+uzat8DV6tjLh16ClFrNJ1umNCm2N1qmQngmeBUFNnj00yoOzbVzu1xlpa+oyRPXBlsKm9l3eX7Lx6vrc6jyfsK+lsksxfxGO4rbMKyBCMIsl8WdESx1tKDpgWdNeZ5mJLgQ/+TzRWgP+qVhKcZCq6kdqlLWV+vhUSK/jHPonpmOHVpOExcMd+abYrWQfEoTg9E4KIwWD0s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcc68a08-f71d-4359-97e1-08dd8be3e215
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 14:48:22.5986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V+QDr2o3OMpDH4pVojPznTXLAgNLwBU+AVI9pldtzxFR0nu9Hd9Xcdy/IM+Jcln25lBm4+TqccF5mbG0Wl3pCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFA0EC85B6E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-05_06,2025-05-05_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 malwarescore=0 mlxlogscore=824 mlxscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505050142
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA1MDE0MSBTYWx0ZWRfX4rqDSLaqcxGo DvdG1qPzN7YQhldPH0+98Z6SdsOHglzbyQqH6dRxZ1NVnuEJ7BM4carxrqpr4M3hlkIz0uK38As +CQSCPNhfRp5PKp0zCoOa2S6xnlnexGw1gdLSi3IY72W/Q0aqbSx4ZRk77cBo7UVT48vGkwIR+D
 qkzVzgE8V4Yg7iZUQjc8Ub/xSEEHFsuKoJIsL1Cs8my7+YgvW29y+HPzLda332EAU5qori+G5PR wOjK4L6HtPSP5xoamxj5iyAZCKtO6s178OVs8fLyRU/Ks7+jUyEpfyehn/HdN14IpQni/bqConA /kMBnViSFRusHF3R4Lac2hxpEoYpsV/ZgtcmqQTk5KHqh54HnmsD/cBvlYATXw6gAGjMvr2HOKh
 676OYmAn4ra5oFQ/VnSYT53BjDmydTJnVfqf5x9IlKW2I2aDhgTSAqSkDFoGgELkl2drZu4C
X-Authority-Analysis: v=2.4 cv=JO47s9Kb c=1 sm=1 tr=0 ts=6818cfd0 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=hPUp1NJM1-LhcnNJhF4A:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13129
X-Proofpoint-ORIG-GUID: 02JLyHI-lvPkddiotSgk4ubvxqogPzHf
X-Proofpoint-GUID: 02JLyHI-lvPkddiotSgk4ubvxqogPzHf

On 05/05/2025 15:22, Darrick J. Wong wrote:
>>> Yes.  Or in fact just folding it into xfs_alloc_buftarg, which might
>>> be even simpler.
>> Yes, that was my next question..
>>
>>>   While you're at it adding a command why we are doing
>>> the sync would also be really useful, and having it in just one place
>>> helps with that.
>> ok, there was such comment in xfs_preflush_devices().
>>
>> @Darrick, please comment on whether happy with changes discussed.
> I put the sync_blockdev calls in a separate function so that the
> EIO/ENOSPC/whatever errors that come from the block device sync don't
> get morphed into ENOMEM by xfs_alloc_buftarg before being passed up.  I
> suppose we could make that function return an ERR_PTR, but I was trying
> to avoid making even more changes at the last minute, again.

It seems simpler to just have the individual sync_blockdev() calls from 
xfs_alloc_buftarg(), rather than adding ERR_PTR() et al handling in both 
xfs_alloc_buftarg() and xfs_open_devices().



