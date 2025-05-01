Return-Path: <linux-fsdevel+bounces-47812-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90713AA5A77
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 07:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A9313A60B8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 05:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73222550A7;
	Thu,  1 May 2025 05:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bxxf6uXh";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wOX3u/QW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57257253B71;
	Thu,  1 May 2025 05:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746075907; cv=fail; b=dAPjszz7UebIuLpjwLk9ZXISF7xnZHnE7+FsUosBE4GBwSIxb77dN+R+lOVeyX/5vSmJMObQBNoKtu6HgKw+C6quIA89QbO8PInnBRtAugkfad9q6Hu2aoUjzz9OtOVGxe3uVeNd7GDmngGdWf171wJgtDVxiIHLkH5JKqhghcM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746075907; c=relaxed/simple;
	bh=DN+DH/cUaXLuzlfKuIYj+Vbl63Kt0pm4T8gew31kDQI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YW8ogwpAzpf+jzV3++vKlzCeET4bTtmeLPha+q7WVbuwP21LXQiPOw2NZMLMwZzXxd1DzC5BL7nk2695gYPsbY7mYPrcfb80oputq72q5mKdYnQ/K5TbwDO4DLmK1EyYHYHcDhzl+2f/GF0k4isPyQ4IcGm3I1WBS9RqO0FSiO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bxxf6uXh; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wOX3u/QW; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5412SBf2025858;
	Thu, 1 May 2025 05:04:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=bU7CRYnRehF1EUzxecud8Ec9uGcUZQOYwGY4VP/obew=; b=
	bxxf6uXhZxngVGhzTCySDeeULrQrGlMMxKznAhqLr8TX6ZHLVz8+fbt7v+wUJQY2
	F7SkdV2jqlaYiXYiDktalAYCZukPTZ9i1gLX7rmwK7dQ2wO4CLkB5Sx8ehKNKtyU
	Wu1m3h4NZAB9+kaEWe20UEK6aZCAESE16/ppd9VVEEJQpsrVQflhYAGYBYWKPCji
	j6R6AAl5mGAUEsXZSkDnUoGX+YhNlLsHlOSl1d2SCgDlyG13USfloSJrLmDHpNxM
	v27dgsqArNKFgxMzhL8OCbRJCgOJxNZwNIOiEA63wJVFPQWwMcnLpikvP2bHNiGp
	KX29GcfPC0lPJLa+jbFHRw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46b6utahf3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 May 2025 05:04:54 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5414qU7m013828;
	Thu, 1 May 2025 05:04:53 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazlp17013060.outbound.protection.outlook.com [40.93.20.60])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 468nxc7e5t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 May 2025 05:04:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AOQwJi0ck5lQfxswWkt/fOnyJjrXH1HAilTWkRtgfrM9pv1eLtQtINIK443oSt06quaTzvqTxYk7tnpKjMfszWUD9pTfeCioMoMbrdKkOxDR3fAqwahfWZA1jdj1ne+2gA4YprMGnNh1y+J2hEY+fAD+vDMfMMeRn1Hih4sf+fxQ8q+Ajm7MrQjugXuDgLpbHhKeTQh4OAaIexKxBo1ToRjooB8j+EvbkmgTWxQ9S1uqS4R+QJ4LCvwySVKSi05PAQ0kbJImxEO3tg2ASt3hmu/Xeb99dCqw0+CaEl38tHI5utnJG3hcWYSb1AmTJoQg78DihR2bRd5sKfRrpAIKOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bU7CRYnRehF1EUzxecud8Ec9uGcUZQOYwGY4VP/obew=;
 b=nw3ymZQ99tsooltnqFC83nov2hLzoiuSAYPxJfGHv4lC3/UKJuJvX9sFI8XdeDyQUaiQeO7k8OnliV97H1sLuDwk0dpyMCEMdhG+kkHHWN2NDb69YsAOd8a5OvMnAaGnrGjqGBbMWoLYwz7QaT7b59Hcn8SOx2zhz5fgS0l5X4174ldEukbqG1DKF7r93h0p8Y/PysOm2lt81HohSQKPhXiZ/pUn+6PmIezxA5S2FXJ248mWC/6X6Mhx5L3apsDC8zHPGEewKu2quGE0oCWrA2IAUyuRYpmEFYZ2CdR7/oz9TAN75JdKwOr2S2D0N+tgC1Cl72Zg5TT2qIT6ELeZew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bU7CRYnRehF1EUzxecud8Ec9uGcUZQOYwGY4VP/obew=;
 b=wOX3u/QW+N2qdaQidZw6ixfcjTCJClMdOtD8/7Xy6FnFFH6awEswQ4Fge3u9yEqcOtJ7bJPjn8X9zPNE9MgpPQKwIoZ0TvPqOls3b48DYslucK+DKCxscsASHxmX/+/fDaRDMDZfeVptvRH4ufId2xdcrtJDckhpdL6EPq3xH50=
Received: from CH2PR10MB4312.namprd10.prod.outlook.com (2603:10b6:610:7b::9)
 by CH3PR10MB7779.namprd10.prod.outlook.com (2603:10b6:610:1af::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Thu, 1 May
 2025 05:04:51 +0000
Received: from CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2]) by CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2%6]) with mapi id 15.20.8699.019; Thu, 1 May 2025
 05:04:51 +0000
Message-ID: <cdf83383-8595-447c-9d24-891e850cab56@oracle.com>
Date: Thu, 1 May 2025 06:04:47 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 00/15] large atomic writes for xfs
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: hch@lst.de, linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        linux-api@vger.kernel.org, brauner@kernel.org, viro@zeniv.linux.org.uk,
        jack@suse.cz, cem@kernel.org
References: <20250425164504.3263637-1-john.g.garry@oracle.com>
 <972bd2fc-4dc9-42d5-ab05-dab29fd0e444@oracle.com>
 <20250501043151.GE1035866@frogsfrogsfrogs>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250501043151.GE1035866@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0055.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2af::11) To CH2PR10MB4312.namprd10.prod.outlook.com
 (2603:10b6:610:7b::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4312:EE_|CH3PR10MB7779:EE_
X-MS-Office365-Filtering-Correlation-Id: 59a0dbf1-6690-4d82-9cd4-08dd886db3ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UlNIbjhJcE9DcS9rY3g3eDYxSjh1K0hJSm1CQXdHK3NFUzBaYVJaVVRLS0JU?=
 =?utf-8?B?UWFTNEZWeGtKS3lJTVA2K24yb0hVUTIzVmsxQ2tPUC92MG1OUzZ1SEMrbmFM?=
 =?utf-8?B?eUVlWFFRdUh3SnlyaFR6QVMyVEhYbExwbU1QS2Faa0h2Nk9CalkxKzBmTU9Q?=
 =?utf-8?B?UWZPS2VsNUNtUU40REhvT3RvOGFhekJDRkxzVitEbFR2NHRzKzVDekxaRERi?=
 =?utf-8?B?UmlwWDhGdTlORkE2TEhxNmpTVXQ3Z21CMjlqQW5VQWRDcHpINXcyMTZCK2RJ?=
 =?utf-8?B?UHk3MmhyWGpiSXRkYk1SOEtuSVVZdmxOb0JVTEkvYTZ4TmZDcGpoak9wSmQ3?=
 =?utf-8?B?OGh3L1Vsc0RGYTkvMGJPd1lFZFFod1pwWGpONGU3bVpXRG9rcmxBcVVwRWcy?=
 =?utf-8?B?QndRaXFISGlPV1djaXFWM3VHSm1jV3VmTTZMcytJa3NrNGhEb0psTUk2Wko1?=
 =?utf-8?B?UmZ6WjdsVVU3Y1gvSzhTV1B3alRSaCtiS2UzU1dZVWkrRjZRVmlJSHB2Q3h5?=
 =?utf-8?B?d2xrdlJMTHB6VjJwdWpFWjlXbk8vamNWaDkvZUdIU0VoeUovdEM1K0s4NkpF?=
 =?utf-8?B?bmUwVjlMdHpPSzl4UGJLNitlbm5FNHBOODhKcTE1b2QvTEhuM25rbkl3UVVI?=
 =?utf-8?B?dnJDQlZMVzVrQlBrYUk3TlR5S1p3a216Si85YnpKZGZNM3NzQ3I0ZHJlelZE?=
 =?utf-8?B?VzUvL0pETmdpZW1IcS9yWE9VVzV0MjZ0aW9zdXlrdDJsVGFaWi9zYXBkdUpH?=
 =?utf-8?B?R0JYMkVZb1J6VGhOUytrS29RVTFWTFRxZ2RTb0h2UFluTFE1bHhNRWo5aUs0?=
 =?utf-8?B?UGdrRVJiZWhHdDNsUjlEaVpXTTRGemRSMXhRM0xBMUpHd1plT0pDZDl0Y2ZN?=
 =?utf-8?B?akY3WjFvSGl2b0dwTFVzZksxaUZqVDNsYXJlWmpqUkgwc3FBUkE4aEVzaVNo?=
 =?utf-8?B?T3ZUYkV5bVFsMUgyK1NTbkxKVXkwdXZURUl4QzcwN0RhM1M4WGJXMk5HYVQ4?=
 =?utf-8?B?TDRDd01QcTFFTUFma1FGODV0WktKRVlPekp1VitONVVydm9aQkh0VTZDNEE4?=
 =?utf-8?B?V1duN0w3QVp6Y2JhcnI0OGZXK0xWNTUyVVFnUTRYdStTSVZGcWVOZzQyOWt6?=
 =?utf-8?B?NHpOUFF2SDAvMmJ1alBwWnA3aUJZMUJpTGIzNVN6aC9ub1JvaDI4ODVia3pL?=
 =?utf-8?B?R0F5bnJSNDJkbEZ2S005bWFJVmhmdnIyaVhUcnQzNGg1RG0zL2I2NUVxMllB?=
 =?utf-8?B?L3NWRlJiUjk0cEdlc2ptdlRxVXJZbVlkWWdlbHg0RTBFYWk2eUY5MW1oeStU?=
 =?utf-8?B?dkE3ZlVHZWV2dGtYK2VFMzd4Yk91VUgrKzJZMnpYY1RhNmo1OWo4OTZMWDBQ?=
 =?utf-8?B?OEdqdDd3SUVjNmdQeGQ5akVhQ0s5MCsxdTU1T3EyeDltVE56ZVVGK1RPRFQx?=
 =?utf-8?B?TG9aREFQZDFJcFNWUEZLY0Iwb2UwejJMcHcrQjQwZHB0U2lRN1FYUjBMVXhm?=
 =?utf-8?B?TFFYZE00aGxEVW42T05xTExjZ3YxMHFJNi9oZkQ4WFpRUC9tN094cmc3R2I3?=
 =?utf-8?B?eGtJWFpzWHB2YWR3OEVoN0xhVElEMW9BVGxZbCsxRnozNmlDeWNTS05Nd0o5?=
 =?utf-8?B?dzA1STZTcVNYYm1uekRnV1g1Mi9KV3lNVFNPRnJWL3RiNGZ0bUR3ZERoQXB4?=
 =?utf-8?B?cnFTQTFMNk10NEU3OG01L1B1NDlDT2NNSFk2NkNTeWp3a05HcHJxRXVZdnAv?=
 =?utf-8?B?a003c0dVdXM1blBNazd3MzV2bmhpYkxiajRpNzVObUNsbmQwMTBsaVNGeE12?=
 =?utf-8?B?aFM3QUFUSk9uek8wWFc1N1JLNU1MTUFPR2d0RFZyTU5YKzFYY0xRUHdBRUtV?=
 =?utf-8?B?SmdBdEJJZVozTXd0bTVZSE1KTGJBMTlENFhyL3NENU1oaGh6ZFUwYUxZSkNt?=
 =?utf-8?Q?UaFDJl19xtQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4312.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?THZSeVFLSG9yR0EwVVpDcnBHUXVGemZENUw2emRYMVhBTmdIUWNQMlMrY3ZD?=
 =?utf-8?B?b29veUNqMHhyZ2dTRlAvcWo1Z3A5d1JYTm85cTRDYnZ0TnU3R0pIM3B4REhv?=
 =?utf-8?B?N3E0L2NwK2xDL1BXb1M5dFBoVjJXejA1dWlkTFpxRmRBK1JDYXNQMDJYSVEw?=
 =?utf-8?B?dlp4S2JNU0lCT3hIUFJOTE53cFlGS2tEKzEva2s1c3NjODgzdWR5V0x5Tkdz?=
 =?utf-8?B?QWRLNTYzNVpoZ201cHVJQ0U2ZEhvYjVmRlMvVkREV2NTOTU4cmJlcWUzU3FF?=
 =?utf-8?B?cnk5WlZtS1JINXY3bFBjc1BXamxqTUhvYks5UVZtR2lDUG5XeW1wZ0xUaGZ5?=
 =?utf-8?B?b3A2dzJYaU5lY3dPaVNFR2I1U2FIQ2lyY2ExMmtUUlVWMjBCQkNCOUFNSGJ2?=
 =?utf-8?B?YmplVC91TmJPSmJ3eGcyTUZHS2hqdStGVzJjNDZ6WlpkUmRPdThmK1E3Z1RF?=
 =?utf-8?B?cnRtN25yUDU3akNYZ0FsYUpaNEIwbDJVQzVmc0lnMWZJVWkxYnNocEQxRkJS?=
 =?utf-8?B?SUZDcUpPY2RaSk9WQkxGcGNJdlNzV2tVRmU0SlYxZ2ZLeFJOT2tSY095MVBD?=
 =?utf-8?B?dytaQ0Zkeld2TUJsN0RJM1NFZW02NEI2VWN4RDRlL3lPcGh1eWhPeHRJQXox?=
 =?utf-8?B?aURMK1dISnd2ZTRlMnVqWkFGaTdkTHAyUXRoMkZwcTdmM2xrZ3p4MjB1b0R6?=
 =?utf-8?B?Y1I1empNcFJyMHBpc3pUa1dpUUxFMzZsU0xqWWdrQlBlSWxlcEhIVHozWFNB?=
 =?utf-8?B?M1ZHaEZiUnhBZ1M4MzNEMmdlaHhjRUhvOFpMM00xeUNxaUVSWUhVdktnUHVk?=
 =?utf-8?B?RkxnbjZkNWU5UmNWcldzQml5L3g3S3FrWHNaRllMWlN5NEFXNDdBWjVFMkdh?=
 =?utf-8?B?dnJHaFI5RkROQjE4a28zSWZ1OERBbHZBdVIrajBhVjBDN1lxYzZUNERtcEdD?=
 =?utf-8?B?dTdvYWlVQjdsMHlBdFlvenhuZWhhcU40aHA4NTlnY3FXOXpiOFNLNXBnczh1?=
 =?utf-8?B?eFVYWHl0RzJuYlRUY1IrZ0pEL1Ixb2tVbnl2cUdHOXN1UHRDbWZYU3hTaUtq?=
 =?utf-8?B?OTdMOXFNSHhhQ29nSGlxd2ZEK3k5WWM0MVM3bVhPZkZGcGVhTGFzYlVqdEhB?=
 =?utf-8?B?MlRtTGpTZFlLb0FzMWxWSHdsOGxhYUZDbHdiWjRkcjB0TzZKSzc3bzkrZWRs?=
 =?utf-8?B?VExSZWdqdWJEbnhzdTg4Qk9Jd2U5TFRLMG94TlNhUVdtUEVVcTUxVVRFQkNh?=
 =?utf-8?B?Q3drSGY2VXgveDk1UHI1TzV6NTNZeDdmUy9vSERGeUs1ZUtmVDVSajMxWkVq?=
 =?utf-8?B?VHgrUUhvdWljRmhQSU9vd2p1U1RoU3RrdDQ5N2RLVEg3cE04ay9SQ0FNUjdW?=
 =?utf-8?B?VmVGNFBnWEZHaTVWdzgzcUFtTlZ5UjlYTk1sdVM3OWduYmNoOXV5V2lqK25K?=
 =?utf-8?B?TUNVVmdZUFBsdmxBNkNDeXpYakViVFp1ZWhhdjVQZHRQM3prTDlYQVFJZjhz?=
 =?utf-8?B?OUZ2MmZoNUNWd0FEaGtHSmZ1SXJFTHREalZwaXNOeW1sMEhTemhtUzRvV0xx?=
 =?utf-8?B?V3NyQVVDc0Q2TXhvOHBUNWJpZGZUVmIwbGhLazZaNjBLVzFTQ29weHJnc1ll?=
 =?utf-8?B?czVuL1d6MXNuNlNrUW5IS2VQSVB2cElqZ29MRDNTV1h0YmhUZEtUU3E5UHRX?=
 =?utf-8?B?R3lwMnQ1N0ZMWnZ6d1gzRHFzbE9jaHJTb0xQNzFKNVRONXZHZVNkd3Fnbmhm?=
 =?utf-8?B?T3BqdnlhcmRWT2d6NFlQRTI0T3lPQ25JZy9nbldrTzVZVnRlck9zTlF5aTRr?=
 =?utf-8?B?VHBGNE0xZi9CN1dXa05qaVo4MjJ1K29DeVZNQm9XZEo0cDVXVFJiK2hBUnJm?=
 =?utf-8?B?cDkxSi9iNHBuVHNzZld0YjgwZVVuSVB1M3djU3dXM3hJcy85SVhrUkY0cWFU?=
 =?utf-8?B?TWNnM25GakJFQ2tDQ2RyR0dxdGhhbWFmU2pydU91VUJXQkY4MEZHVTJGbnU0?=
 =?utf-8?B?M0V1bEJ5MTFKWTRrRXNkbVBreUM5dmo4ZU1vbk82eDFVTmlJUlRUbGZpRU5C?=
 =?utf-8?B?emVhU0dxT1pwU00rN1k2ZkU2WEo5RDVxOUpGYitIcGlzVzI3OG5wbVRPQkR1?=
 =?utf-8?Q?1fWCZDu5BENcprYEmH8pdXL1q?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5YvhvaqX1Blu5+FBW+YW+8iJcqLZ4YhlvFe0R6Mr/v8n7cSb7hPg9/VevR8+pPTss0WlJkQb90wWqGaWnxyRnFeUkZe5UpFaOx7nmNg3tI9o3SesFmHQTTblU8jAEqoQA2XnUjaBCNBYvJb4/1Wey96tnNbVHdLPOhMOWxyYe0vfwzfwNjfBCuYmEuHxeIWtCylyz6dxx8n2Bpfhy6zON5/uW65JWny/A7EyPBPZ92eMIHmRZb35odqRM+vB/hEckKNnt954bDZ+sh/rKCTPwq/g0BUZa/BnZTJYLMMfrPFnReuRMGjzyLqfD6VPcglNEAhCLBIujXPsCD0QAMJbh8hi55D32DPaWtQFHzHSJBInj675WfBLKtY6R3HxHk4usrb/xjGY9wdP5xYjMDVPez4LpJrNojPlJb6KjWhoQIZjrBe/Ut9pTcN9K6DMCqjme4gBc9+7Nl1QmY5GEzoA0XLNayReH59GcOViTgpJUKcTDMOsaor7BzC7aK3Sj8BF89f6/+IT0xNq/PLpSHE9PLAZ1Y2zd6jZqoI+NUqf4tGW1awCCrZMziB4hT+K+E5hURlS6gsXrQjocLI/vvlLMhvbsD+cub7Khv/5AuTUZhs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59a0dbf1-6690-4d82-9cd4-08dd886db3ee
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4312.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2025 05:04:51.0182
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nOQTkiEDe7fmidYo1oQ2sjbrETNDaQPFWIsJUmlyA+YanNbUZaOAiiTqiIEirOlJGwae0foCVqoanQPTxI8fHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7779
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-01_01,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505010036
X-Proofpoint-GUID: qbUhEQmvgvKvld1qIgRRI8qU21u1KnXa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAxMDAzNiBTYWx0ZWRfX2xpmBY/w0I3Q jUVCg0C5UktNDDC6n5XwoONNqGul5jHJhOGW1NODPnbBfQaxqEUNz5ZwPh61ktVXlWFMOl3wS7t 2Kpe9Fg4QXxmKbEk7so2y/a9T2G3fS698OdWzA3a6hD3AxLnvHhOBJNv+Rr4AqtMw9wbGGP5xvy
 OQTWXobMz+TIBBp9QqsXm06g8oWXU8EMLaD26R7E8JKmp6ouLs55m/B4b34mbo08nWnRuOcflhE SR80rVkMYrqCj54Wi23F2uXRgaU1gOTPoYnoe0p7T+J15pC8MtvIiMVd0SMVvbhFc9pKjxtrIN8 XIhsYBAoJyVcsSN1NfINFyQNcfoiOM8wAO6d0JOL14SEMFkdTnnqxSEqEuQsao4iueafgNTHbjX
 ryYuSI6zSE+RtC7WFoHK6ObjUWUv9WzymrV0e9ALWRcOjOdFSU1chPVcPLLFRHXhvdN16Bf5
X-Authority-Analysis: v=2.4 cv=ZuHtK87G c=1 sm=1 tr=0 ts=681300f6 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=AuJBjO-WP9nkoYTDqLUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: qbUhEQmvgvKvld1qIgRRI8qU21u1KnXa

On 01/05/2025 05:31, Darrick J. Wong wrote:
> On Wed, Apr 30, 2025 at 03:14:04PM +0100, John Garry wrote:
>> Hi Christoph,
>>
>> At this point, is your only issue now with
>> 05/15 xfs: ignore HW which cannot atomic write a single block
>> ?
>>
>> I am not sure on 15/15...
> 
> This series still needs reviews of patches 2, 3, 5, and 15, if I'm not
> mistaken.

I can review 2 and 3, but I am not familiar with the code so I don't 
think that there is much value in that. I feel that very few are. So who 
else will?


