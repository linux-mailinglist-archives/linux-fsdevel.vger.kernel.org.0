Return-Path: <linux-fsdevel+bounces-43783-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0678FA5D800
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 09:20:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86E2C3B3CFD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 08:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72DB2233D87;
	Wed, 12 Mar 2025 08:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="N0aPtjZR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HG1FF6Ah"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A981DB356;
	Wed, 12 Mar 2025 08:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741767594; cv=fail; b=XyHZ59fgaBuTRGm9yVTB7TdEqHwqynf5aKwjTFxnidHob7ywHbKxdVMgjhC9AyAPMdDEi45nRIdn+sBsXPs5nszpC7Ryt4Zy63R16BEbfSz4OGU3XxsEylwQ4tRW7WcVXhMFdHfiIk6ShUpa/elxc0m0uKb5RrWporWsUDR+MTI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741767594; c=relaxed/simple;
	bh=iOaji/H+1T1vNq5zq3TmbZFcnAVRvHAyQvdY9OaJEU0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=g8RuELSf3ybyxIzqyFt42pYzzYcQsLgSymoeChf1AEg+yrnYl7K72EH9CbxYm73Yz0FSgcfKOfx+PchAw0kTwL8KuMVJHZA/ktluk6S8Ab+27baQjPZYsn1FAiaM8dciqVmiZl347cHXZz1PwpA50ENYKxXCoa9JIP25fGwJb/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=N0aPtjZR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HG1FF6Ah; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52C1g5T5026124;
	Wed, 12 Mar 2025 08:19:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=7eO4pMZdqAKyq/C39VLEVs0+luH1oB+Q31jW0o2XwXA=; b=
	N0aPtjZR4pEibtVppFgor4lxt6HNYq4b35rraKHuiTpVIM4ot0nYYCvhd6m3iwo3
	60ucvtcjAOnoUuK97sP9v3uCAyjHZ/mH3HV5LsLYcHDWyXOJ5nFcetxz2n2o2uF4
	tHl4uQyyGRzQQJgJaCm/rJwIS7tH5P5/MeMEtNWljA/DA8jEaYxuOqNN7E/td4QU
	K7fbIf4IKg6Phr0ZtjgxKX7+nhx9u82QdMNmWiap/V6vGkzfSedShwVuTUoBi2Ie
	D4l4eLYtyuh9jduDwuaV9Y4Wg8/FXe8ncbPjP6YfO1FZrR1T+/s7jl+I38b7C6PC
	VyA+6esMPgFdGXf5hIv2iw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45au4ds4dg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Mar 2025 08:19:47 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52C6ZffX019462;
	Wed, 12 Mar 2025 08:19:47 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45atn06s1q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Mar 2025 08:19:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EK10DUJNepxvEhD+PHLVRdiWJMMyjgSHA/m39ettKtUzMM5Kw7uagb8GCklX1t4iN53a4Ap+V+Bz3E6O3hnNXHMTG2CyV6Ai35fCbGNuf9zajM9KpwwbeabKc6p/q4NzxxWxGpw8gsQWgWiyw5HHq2t+Iv2jAv5etDip7gkVH/VzP8Z2OIWh4QyUCGBCvrTFrH1jwXZCWpTl6hly76ziQ0lj2gRcL+oPRp+deGnECYJiaeeFkmsg/FlegF3bgmPQW5DhsfYOBV2YMyzHNYoG715amoT8XnRYEEpPEhT0TsVCjH4Oda8pXh1luugK9ZeVTLMUTO9/jIdQ7gy1bayphg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7eO4pMZdqAKyq/C39VLEVs0+luH1oB+Q31jW0o2XwXA=;
 b=kHNBBy27aNljRJqedQi3HuWXWZIkr9kpXWHZam/E4INgF/WYsLO9GNriuURdEhZLRr4MGVhBD/pebO/bM7SgUHeLedUwLpOZmO27mdCUbKixWGBiUhbgaBpsW6xRgJIJYJnymOoeeQtg1KaoDcdW2ula318/oHCOuoJTCL7M7dwO6dI3coLa1a4I67WAeW3JVSmtTK4Jh6H5Wv/6uG2kcmtGfrGyW8yWvCr9ke+hLBI1eE6ALayMUIzY3LpcE0CugBjEQK0hAN9qoOH1po+X9amJ30jQAMXrhouDt9CviwotCFbBw/NErhkINmyZa61NhCiFAUunYzE1DmKB2iDjWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7eO4pMZdqAKyq/C39VLEVs0+luH1oB+Q31jW0o2XwXA=;
 b=HG1FF6Ah6ZL6+1nudvTqhJamRXbE7ce8R+V26WSyPh3I74b4BZ5RA+664UIgVPHHfE492Cab53ApeqTzobnBfp2NVaBrcOQRyk6RKwWw4wdr0IycOidIsfEXc7+m9YF3dSJCXmBnglxXcdduDYODIXfu9oGprVel1JO6WX9S4VQ=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by IA1PR10MB7286.namprd10.prod.outlook.com (2603:10b6:208:3ff::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 08:19:44 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 08:19:44 +0000
Message-ID: <fb9a156b-0d9f-47d6-bfef-dc28aaa99eeb@oracle.com>
Date: Wed, 12 Mar 2025 08:19:41 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 01/10] xfs: Pass flags to xfs_reflink_allocate_cow()
To: Christoph Hellwig <hch@infradead.org>
Cc: brauner@kernel.org, djwong@kernel.org, cem@kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com
References: <20250310183946.932054-1-john.g.garry@oracle.com>
 <20250310183946.932054-2-john.g.garry@oracle.com>
 <Z9E0oEq67RJkDn1h@infradead.org>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <Z9E0oEq67RJkDn1h@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P302CA0018.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c1::14) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|IA1PR10MB7286:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c340394-8ea6-4da4-c7f0-08dd613ea540
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M1FxWTBoNVJyLzZwcFpOYUFIV3NNTE8zUVRDelhxb2NLV0ZqL0RPN0cxN1pT?=
 =?utf-8?B?eTJUM0FpNk12VDZUbC9Eb3c2dHZ4QkdjV1I4UTMySXh4VWJxd0VSYzZWWnEx?=
 =?utf-8?B?N0swY3JZNGhVUktCbkpkckxYVXdvUU0xcDFiN0RyTVFKdjlld2VIakZuU1Np?=
 =?utf-8?B?SnRDeWxMZHFKd24zZk1aTFRxQ0RYbGJMODU5QnEwMDgzcnoxOGM2YXdmdUpn?=
 =?utf-8?B?dUFSZ2xWMDZSbUpFdzlaNWlaRU1FZkVrQllWcEUyZTJvSW1HMW01UjgvSXNY?=
 =?utf-8?B?aHZGRlRUK0NVSDZINVdWOStVTzNuN3k0eGZkdkFZU0Ezc0x3SHFUT0VsY3Nm?=
 =?utf-8?B?TTJxZmtnR3AzbStObnFhemROdEFXTTdmSVBOYjFoV2xyeVRtN2UweDQ3MlRE?=
 =?utf-8?B?anc0eUhEWFA2WDZGLzdRdFZLeVpBOWVKajJ2Mk1PR3YwR1FvV1F0U1VCYjV3?=
 =?utf-8?B?RldodjRKYlhBaXp1THNYRDN2bHlhempkYjlUZ0UrMTZzRmZVUVpONjBJQTdM?=
 =?utf-8?B?L0pHTjkwcGlidnFVb2VEd0FLY05NZmd3bW4xUStzOEYvb3Q5M1NoUmExQ2RQ?=
 =?utf-8?B?T0I2Qm41bDAwUVAxKzFBOFd3Z0hGYlc3eEtrT3lBbWk5dFNJV2dabEdEMXg4?=
 =?utf-8?B?ZVZudW9pZDBaMTZKeGZsYnVQUWZySVdEektRa0ZlVEFUQmFRNENiZi8rYVlJ?=
 =?utf-8?B?Szk2KzViRVZBMlA5b0Riekx3T0x4aUtRZUpSNTUyamJxN3dPdG1qbHJKMUh2?=
 =?utf-8?B?emJ0YVFJR0F1ZGg4SFp2RDNJeFNFdFk2ZGovYTFYYTE0L2tYc1JUdVFyQk5C?=
 =?utf-8?B?enMzMFJCalpWdzRDQkF4YVdEM0txNG5aejVmb3V0RUdyOE9abCs1T0dZT2tl?=
 =?utf-8?B?ZjdlbmFqMlBSckczNlE2VHlEQjBJWHhkRnZxYWZXVEhoYWFReFFaWU8rVmox?=
 =?utf-8?B?b0FlRjdwaHB0NFlHZWcwbW5iR0ZhUU1QbkZRS3p6TitWYVh6U1FPL09ISU82?=
 =?utf-8?B?Si9FNm91MThWYUZlYThlUlk2b0YrSEV0NnY4NERzZkZRTm00ZzUzZkpMU3ph?=
 =?utf-8?B?V0ExVmxvTEJpMkIreXNDK2dHblZ5anY0MUZBZis3VThZLzBKVThkNW05UnVF?=
 =?utf-8?B?MVZXdUJla0JOS215MzFrKzRGK0xKVlJVREVzRzdLUVBFOVNITHkzOG5Udzg1?=
 =?utf-8?B?cmVhQTlrdGY0VnQyVVVHaFNPT3BOWEwyOXZKVG1Id3JaSlR6R0tRdkRhbUpR?=
 =?utf-8?B?SGUwUkVnVGNTRWpzQVJXV0ZBRGVMRUlrZnJkT2xROCtYSEt4cStUTUNaNy9K?=
 =?utf-8?B?ZjdLZFYxYmpKM01tNmtRYWQvNWVaMUhGZlF1WVNnSXI0anY3bFJHNThCNm56?=
 =?utf-8?B?S2pKeGlZdC9tbjJQb0R6c3VPaFlPWVZJekpZYU56RnVSNmRZSmIzQjlublM0?=
 =?utf-8?B?UDVxTkdOSFJpdVFyUzR3OS9xTWRpVkQ2L0IrV3p0Z250bWQ1bE9nYUZacjlG?=
 =?utf-8?B?L21GN3lXSGNOQ2pMRXdlblljMDRhVGVsaUhRODJUTVZDUkVtcWlUUHA0QnZQ?=
 =?utf-8?B?cW5kbHJmL2N0L3BEYTRlLzkzZTlqTXR5L1E4d1k2NXBtblROOXFFNnJyaldM?=
 =?utf-8?B?SUs2bmEwd0pNWUl3T2dTUHNXalpHcEhmZFdLVk1FNisrQ0FVSkREaVlXK2ph?=
 =?utf-8?B?UEI4U3o3WkJDT2hWNmE3MDhPYWJUS2pIVXZJZUMrSXIxVEZaM0RFRVF5cHY5?=
 =?utf-8?B?NlBxUENqNS9IWjhxaFZFVlFLTWFKQU1QNHBmZ0dyMnBYa0dEemY1VDA3N2x3?=
 =?utf-8?B?K1J0VTJRMGNsZ1FuYytHWXlCTFA1VEd4bkJWdkdNbjk2Z2lyT3pYVDBmblA2?=
 =?utf-8?Q?EZxwjoPHgzUeq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YmdUWFdGcDNIdDJ5bGtidHN2dWNQOTZiYmVJbjgveW9Nc0RUbHJtbXBybkh1?=
 =?utf-8?B?SHJFNmhaRTVHQWk3YUpKUm1SdjY0Yi9naFhEelR5M2tYemRlSkNlVG0zTXBL?=
 =?utf-8?B?a2hBemZVZG0xeXlta0lZVVZ6MVlkaUNYb28zczFKMlBBNjI2RVNTdGE0V3JR?=
 =?utf-8?B?Tm1LNC9VUVUzMHcwS0pHY1EvQkFjYVZvM3N5Mi9XbmM2TUdZUk53SW5Sai9p?=
 =?utf-8?B?aDJFVDBXMmxnS2Ntd21NK1NPV0FEZWdyeXJ4Ykt5MzA4c05IaUhYY1FIYjNF?=
 =?utf-8?B?NWJZVzNkdlB4djR2R1VaRENhdEh4Q0dkN3RuSStTemZ2NDhTWlhUQ2xqaExy?=
 =?utf-8?B?eDc4cEFBaVQremI1NmZ0aWlQOWhDZzdpYWVoQ0ZmNFMxd0FPR3V4Q2g4UGdG?=
 =?utf-8?B?MkVSK0FqU3h3Sk1iUkZHeVRHNXFBajJCY3lVRUY4cUl1UzhRakpZbFhjVzI0?=
 =?utf-8?B?Q05vZEEvRG1zUlZmaWZBbkxTM2RxbDBoNVpUV1FjR0dOd1BYMWVyVzdCeGc4?=
 =?utf-8?B?WVFrU0loTzVEVVhyQ3Q3ZE8wWEp0ajJzNzBsT2dOOTBQUytCWVY4Zzg4NW54?=
 =?utf-8?B?WitTeEx0OHNibHhmWEUxSmxqQVJvaWZqcGE0aW9sTWNMdDVMRmRjL092YzI2?=
 =?utf-8?B?cllZVVEwWmNJamR1Rjg2Y1BHTkJrTEpBMVJzN2Z1UFdvQk42Qm5KdFFYNklH?=
 =?utf-8?B?UDVKVnZyYVRpUGZFN2xvTTJsOUhHSjlqUTJpNTJYUE93TXpSNklhTEdUaFF5?=
 =?utf-8?B?YmRuRG5XRzEzb2ppT3ZaK3JMd0VFVmwzNUQzbGVTQjE4YmdaTHNlL09ibDdk?=
 =?utf-8?B?TDZLdHZPQ2wya3FTTHR4RXQ0TU0yR1R1Smhib3VvZU11dk43aThFcFhVTUtp?=
 =?utf-8?B?L29tYTZvK2xycjNzVVlsVDVxZksyVUlFck52V1ZnRnlKa0lUY2x3TVhzUmp4?=
 =?utf-8?B?eThVcGtMV0x0L05jZHRDTDluT20rWnNlTFhab0R0REZOMC9VQ2xoaG9CQU00?=
 =?utf-8?B?L3F6ZlA4K1hwaURobnR1cXpIbHBJYk92Uk9YdjlrWk1lTHpmWmxZV1Z0NjdY?=
 =?utf-8?B?RFhobVM4Z0MvQ0p0YlpaVHJIcTNyRjd5SEdEalF4dWhSdU0vUXg4NHRaUEkx?=
 =?utf-8?B?cXpJQkpOeXJhWHhERDZZeTNmcG5JUG44c0wrVGF1ancrcDhHZkc5dWFRYTN4?=
 =?utf-8?B?TjlYeUF1NGZybzkwTGJKcVkzTlNrNTg1M0NqWWhPbjM1VG9adzF3YWlUQmFo?=
 =?utf-8?B?bTR4L1ZFdTM5b092V3lIQTQrL29Gay96eHR6Zy9wNks1QkZvRW53Q2pWbjlQ?=
 =?utf-8?B?M0plcnVUR2pubDFqMDREVzFJNFRGVXRWbXZaSzdFcHRpVmNmOE91RmJUdk55?=
 =?utf-8?B?MzFnYWdndWJQaG9yMFhjR1htS1ZXTDNEVGpUckd2SEhNRkpZTkowRXd2OHha?=
 =?utf-8?B?R3pRVStGNW1hd0NvNjJqa21aZXhYR3huNGRCK1kwNFFmS3NRMTN4dFRETGFv?=
 =?utf-8?B?RDJQTHJOK0l5K3Z5YVF4NXRUK1NQNEQwd1F1bElaOFE5T0dIMytab3BleHgr?=
 =?utf-8?B?SDFBQS8raXVGdTdhSk9oQ3F4SkU2MUdVY0N1TldqQXc5NjVFdEc0dHlRSm4z?=
 =?utf-8?B?aUJzLzNWVmo0ZGFoa3NoMC83UDl0dWdxdSthL2ZLa3dPdFFHcnRMbHpoZndT?=
 =?utf-8?B?OVBhR3pMaXlLdGpZSDN3VjRUNU1SbVN3RGJRajZDcDBXV1RPcVJUVWVYU211?=
 =?utf-8?B?VW03cVdWSmdrcUJ2T2V0Z3ZPS2htQmRpbUdJVkNMbWgwWlg3cHNnUERaUTN0?=
 =?utf-8?B?Mm5OY1NVbS9ES0w2Z3UyMjRzZm10WWQ4bGI3RGlaL3FiOVN2VXcxdWlkMGV6?=
 =?utf-8?B?SnllSmZJN2dRMWJtRXNUOE9mTlRaRkFqa3JFSWxoeXVWUk81cDgxTkZZU2hV?=
 =?utf-8?B?YTZKUkJuYVk2cWJaNUF2Q29UQkZJZ1lReDd1S3F4UUVPTktLWWhmR3FpOE5I?=
 =?utf-8?B?Wlk0UU5rRWNUeVZFODNFUTluNGVXdUxlbmtQQzFqRFFRRStBQXh1bENDckxV?=
 =?utf-8?B?d0IxbzVYcUp2c1g4Y2dkRERUUHpQSmhqL0RGQUJSUVdLazRVREMxV0ovc2xo?=
 =?utf-8?B?bGhwT3NwZjN2dDZFU1cvalVNSmM2TWVJenVCSFQ5Nm81cjhLMFVMREcybVpK?=
 =?utf-8?B?aEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Xqx5yX1nLfsODStUsUctXLX+FXrdwJIQPUr99jTVwj0W0UxyS0UKzcUuAS+3nVMddpUPaqUM2x+VMwv+WjVgNqzOHSiW6bi38wmSU5d7EYE1qPJ78/vyam+bgx3CAXEDIyhXov7v+KDaKlbERtV8GxRh+9OH3qgQpNvhY7QdqnsxufA3TZ41InJbSyOMRAqCJjDosrCWc0HMKWaCalqjbdKIpa9sm/G6wrmMf4laXpE/W/SfZjncigPzL88ma1mZPubEo1tSRrqJbDwApOyrMR3L3O2w7DelSnMRdmMHbEhDjSvnD2atQab5wqYswLaTRw60OhJVwIV4eE0oEkQn4W9VvNWp2UQRSVPna4sbvGEoiZV4v6Ix8XbG4C9VYP+pwNRhVr2XVIx/GlSEyw9wPI6Dzgbbv5whx57ss0++DWD3MOBIAo3UmpaS17xpVdq+zjRoImce+oJI+tlOx+SNHXuSwwN4knmBRVuZGqTl8KqONi/isU7duyD6WzPPGjTemoRjvBmq4Ywp1UaxvVyZ/Z1sjlCYQg/Gv/2nVn/GWY/Iaw2ZN2c/fWnSEnWJ8C64w5/Cxg5cO05hJnAGC8G2/NQgeEnaNdT31w2nUKQxlXA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c340394-8ea6-4da4-c7f0-08dd613ea540
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 08:19:44.7313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q/PRIZ2CTtRdHnHeUxpgG3RFlLit5n2ofLTcXt8vIkoB+9cWxS7oKxW9YP2KOjoCdoAnC1bX1rGTwFYLENYaTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7286
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-12_03,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=884 bulkscore=0 malwarescore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2503120055
X-Proofpoint-GUID: 6zZ7zK7k4SdaqDhqi-kdEdPpY-4O6iu5
X-Proofpoint-ORIG-GUID: 6zZ7zK7k4SdaqDhqi-kdEdPpY-4O6iu5

On 12/03/2025 07:15, Christoph Hellwig wrote:
> All the patches (but not the cover letter) capitalize the first
> word after the prefix.  While some subsystems do that, xfs does not.
> Please be consistent with the other commit messages.
> 
>> +/*
>> + * Flags for xfs_reflink_allocate_cow()
>> + */
>> +#define XFS_REFLINK_CONVERT	(1u << 0) /* convert unwritten extents now */
> 
> Please add a _UNWRITTEN prefix to avoid any confusion with delalloc
> conversions.
> 

ok, fine

Thanks,
John

