Return-Path: <linux-fsdevel+bounces-37726-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2C939F6493
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 12:16:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1CA01636DB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 11:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8791D1990D6;
	Wed, 18 Dec 2024 11:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Slk4IN2X";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="udOW64Vh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8FA19E98D;
	Wed, 18 Dec 2024 11:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734520562; cv=fail; b=NPTrMhmA86s3TIRMh/yOBYw+A5CUxWkQWf6klvKUjqVg4bpuePGTWTpBEiB/lRiQns99/K3wLWT36dAM9DIcIsX8oeKYKa20+H1RnI6d31HOgM7YaLF5zOle7TtxXmUkjpVt/zDK/j1LGHWfOIlIr/T74zAoz7dKwOrCZUc95YE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734520562; c=relaxed/simple;
	bh=KU99XYu9RJ10UP+wy+MLBH8/vN+6OdobGditWWbTeow=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ooQhuzY8o9YmVQKRR1qV0n8GNkk6e/h/shBDT34S/ftDRJ5o9JH/tbEeNSpd7mKxpieea17/bCOM+aICwdrzBS/4J6b45c5XGwEml85W/Q3b1cIuciYJsg/nJE/LFtDi/Mo3wyIbtFqA12rMnGafqzb8FIPcz8FqZe0+3e3m6jA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Slk4IN2X; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=udOW64Vh; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BI8tpoZ032013;
	Wed, 18 Dec 2024 11:15:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=X0ma16ovp2mPuKYbpDbs+4k07rXJbHIC/p2fOSNVJp4=; b=
	Slk4IN2XyhLANQcc39+qQ/fy200Knhw5dRepDCntGpNVmEvjpHvqrUCDctPeeSlg
	/twCEihBgVhNT14oIesQLAzOsW+SQSKPU/wVswNixEE+LAWOT7p6dcdIFkiyvAZB
	Jo0nUlcrxMAZBdhJXtti/VWD7w+dslausFgUUPoobjVbUPYtEjOQtIyu7j1FoLvo
	smk/30H6JNdXpgXtjlVyqIAcARquaarYW8RwNGdlOaSk6TCZ/Lps7guAX/FLDQ/R
	0bZnNi8L79er2B8AX/krqQFeijLPP6ubWLe+qOQKxugibxAXqUUetWql6P3KVjzL
	rmsk8VXx+qhw4kUSOR+Yaw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43jaj5e944-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Dec 2024 11:15:49 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BIAVb3U000786;
	Wed, 18 Dec 2024 11:15:48 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43h0f9ujpy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Dec 2024 11:15:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i7uISR6+9+OdQZ3ddXc9qFFV+h3TqJEZy3A7Pxl5LqkOZltFvYJgCSdfGoSOsAnNZVD5UZSVW9cz/ukPoOyMKe3mczRbwvrXSnQ0Wu22Y5uuYp5Hv3EOz87jojIvwk1gdDFiqNxC27xY0rjYRStTSTs+zVF1tcaIN5BvmYaCTlFczjWBybZ0ttoJaS6M1RjT/70cOBg7NkWWWlpx6ROX1meaSHC3O0BhooiNGcrVvS5DOaZ0YrOA0i82shIzpUsI6LiWBgXpjm8exN9DkXFm0i+tfyLKW3J+03lW9HWNlOsYZvJQ+il4pMGL+GRENVnNkUFZEsNblwLVOkHvtBFAfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X0ma16ovp2mPuKYbpDbs+4k07rXJbHIC/p2fOSNVJp4=;
 b=lQHNuhZm9UC329lbSlYRT76XAstkm/uOKI2z31tYGh6XOTEEiP/bgug0cmqSaP9dHC90aqYjFGFyH1wrlQeOTwODwgJjAv3VOx41eGRsrINNodXlGxnrKV9AHOpLc051MDTNYoKIGiJY57H6yknSitmy5Ef91ejHhhskamwcwk/9Xn1WE2Mi0lteJDZK3NDL0pUIMWOp4Z2RMLRI7/7Snieb22dcvUbBYnN6uIGYzmLEm9Omah3b9KHfZPt57PRxgX/bchgfwpCaFDP0AtXMxA9j/CrMNEUu73ZZi0w6GP9V3Fwk5OIJf8kqY1Avmr123xv+98v1TrCfwhJHtT5fmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X0ma16ovp2mPuKYbpDbs+4k07rXJbHIC/p2fOSNVJp4=;
 b=udOW64VhcvOLbKozhjZT4/EO9FgDng2UHObqMZBBi5s9O0ygje8jpNPiA4psAIJIZl55DUz5jQlD66M/nio/jB/IQAced89n0k2wvhg5GvWtpesrH03u7oBxGniIsrcyyAqZgcgSK1sFpQ1RYqrOlGRMeMeo4r3u/GsdHIO8fQw=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS0PR10MB6774.namprd10.prod.outlook.com (2603:10b6:8:13c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Wed, 18 Dec
 2024 11:15:46 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8272.005; Wed, 18 Dec 2024
 11:15:46 +0000
Message-ID: <93eecf38-272b-426f-96ec-21939cd3fbc5@oracle.com>
Date: Wed, 18 Dec 2024 11:15:42 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] iomap: Add zero unwritten mappings dio support
To: Christoph Hellwig <hch@lst.de>, "Darrick J. Wong" <djwong@kernel.org>
Cc: brauner@kernel.org, cem@kernel.org, dchinner@redhat.com,
        ritesh.list@gmail.com, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        martin.petersen@oracle.com
References: <20241210125737.786928-1-john.g.garry@oracle.com>
 <20241210125737.786928-3-john.g.garry@oracle.com>
 <20241211234748.GB6678@frogsfrogsfrogs>
 <4d34e14f-6596-483b-86e8-d4b7e44acd9a@oracle.com>
 <20241212204007.GL6678@frogsfrogsfrogs> <20241213144740.GA17593@lst.de>
 <20241214005638.GJ6678@frogsfrogsfrogs> <20241217070845.GA19358@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20241217070845.GA19358@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0272.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:195::7) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS0PR10MB6774:EE_
X-MS-Office365-Filtering-Correlation-Id: 56b5abf5-1060-4cfc-8eac-08dd1f5551a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dzE0SThPcUYzTzA5N2Y3d2IrZmM1K2NKTkJtWDBCcnI4Q0lFTk1VN1lRQ0E3?=
 =?utf-8?B?dkkxZ242OWNzZjMwYllQcENUd1c1bUtHRktseHZGZFdleXp5cXlramoxZXdP?=
 =?utf-8?B?R3R6ZXNxNGtVbXpUZjlmMDRCRm1oSFRtSXg3YmlKTXlLa1RXV3oraENiWjJE?=
 =?utf-8?B?UkVPcEEzYWIxNTNPb1RlVXg4VjNUQ2ZnWmdLekRIQ0M0SWMvY3JXV3drSkRl?=
 =?utf-8?B?RHIrQzd2anZYNmc1NzlRY2YxaURsTTBienZWb2QrWit6b2VBWExUcTVNN1FX?=
 =?utf-8?B?TGRKZm5Ya2xhR1lsWHNDNnJQQlBPQkNXMHpPc1I0dU9PdFp3WmZCVTZuOEtF?=
 =?utf-8?B?TUs3SFBMd2l4aWdHeVRMTHlGTzRNbXVoQnlhUWVvcDZOVVhkNCtNSnliYnpM?=
 =?utf-8?B?d2hHVG4rT3FxY3Zwd0RIWDNybEh2NzVCVklIYllHLzU0Q1VycTBObVZwR2o3?=
 =?utf-8?B?ems2MmhpaUxCZUFrSUkwU2doTzh2WFBWMTZVWGtuSW9UaVY1N1pOaFVnQVBJ?=
 =?utf-8?B?bFJxWUc4VDh1UnJWY05OV2lpVDZQbm5vQUlqZHJ5aWFBRHdTUVJ3ZTZETXJ6?=
 =?utf-8?B?TkowRDJzOFdrQkN5SytDdy93cTd4TTdLM1AxdVE3d1ZEeXpaRmJJc3g5NXhz?=
 =?utf-8?B?UzZxbTdkakUrRXBwRWRNdnRnWmQvMW0zV3ovWjJoZjJRYW9CbHJwaDRTdWtI?=
 =?utf-8?B?enNlYTJqOUREc2Rmck5taTRDd2tDdnFoWkZEUkZhSzl4amNheENsVWM3N1Fy?=
 =?utf-8?B?LytQQk1QN2tFaE9GRUtlV0svUEswbU11N00zREM5QWllRGQveXRmcXk5aVRH?=
 =?utf-8?B?eVk1SzZKTjgxSCt6d2lnVXRvZ2pVNGcxQU1nc0l1QnhwU2ZIeDBpWjFzb1FB?=
 =?utf-8?B?MzBiYkpYRFNJdWJkcnRRcDNXRjIyeXI4Z3pzUzJZZERpNncrVlUxS0QvQm51?=
 =?utf-8?B?R1R1UHI2d29BMDVKYWlhTW9mTTRFY3RqTm4zaWxnbTlxcVEwMXh4eVBKdUpS?=
 =?utf-8?B?bVVyYzlwK0gyK0NCamp2NldUR2xoNUIxWWE4d1JUQ1VkOW9kajQxZnRpQk1N?=
 =?utf-8?B?eXR0SGZmUWIyS3g0VDYxY3p1UFZkcVJUZTc4eWl5cHg0dmxscGN4WFg5MDFP?=
 =?utf-8?B?RlpPaWNNZW8wWStBeWtWR0w5ZVBkbU82ZEg2SlgxRWZwTy9EdEJiamROZjcr?=
 =?utf-8?B?NGdlUjFFTzJUeGVjZGFtdEtyOGlWSGhSb3lRdHRSNTg1S0F6STBadWYzclV2?=
 =?utf-8?B?SjdtbGNYWUJRd0pNR2V3S3RWckxrcDd0Vy9mNHFCVWUyZHFlRTUvcHlsVWFC?=
 =?utf-8?B?YUFsN2YvQjIrNjIycXlZMXRoeDlYeG5Fc0RZeGo3TW40U2VGdDQwWjcxMEQy?=
 =?utf-8?B?MElmRUU1RStseDBIVWtXY005QlJkQU9YNm1nOSsxVSs2YUNydWcxVlpqUWZl?=
 =?utf-8?B?M0thNDhUU3VtNjlkSHJ0VzVmMjB3Y2RPS2RuVVk3Zk1nTmh6Q21XNm9JaUg4?=
 =?utf-8?B?RXNaczhkODBtdEFJdTNiRExweXpHdnRSMmtwRi91elJpUmtkRVhmWUhMYXN1?=
 =?utf-8?B?QWpSNG81Mk1XMEcxYUZvM2h1clFsZjlZQ1pMRVNYSGVqYjk5RFpTOWMwOTY4?=
 =?utf-8?B?eC9SdDFRSDdmWWltYjEzRG5maGNNNVMxQzN5VllwcWNPdkg1RzU3S1d4dlVm?=
 =?utf-8?B?QUFKSXIvNTU1UUJETFdwVjc4TUgzMlNnSmhMbzlYbGY3bnJmYnFmeUNXKzgy?=
 =?utf-8?B?OU9YUS9NVU1KQks2U3hYbldBbWxnRzJ0Z1NTWlVJM2s1SzZyQVYwREJPK0Ri?=
 =?utf-8?B?bUF3eTdiaHYvT3dxUWJNQTRkcFYzZDZzaDMrcjNqMGpkNnNhMWdOazRVUDRo?=
 =?utf-8?Q?m2ulz1XWoOWZ1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L2VzWk1sNnJ5c2tnaTFCb2c1ZkhJVG4vcDh4V0Y5bG9QUG1jZ2VSbnpPUkln?=
 =?utf-8?B?ZkU0YmN0VCthanRlYWt5SXNQNFlyT3Urc29YeXhvZ3VLck1mOWxERkdhZUhH?=
 =?utf-8?B?czV5VGVCT2xxNHhnYkI1T0RITVEyeFo1S2IrS0ZpMDc3SnhmOGROUWc1cm4w?=
 =?utf-8?B?OEFFTzQzTkNiWXdRM1RvQ3RkUXNIQ0FBRkJMamg4bUkyL3FjZDBKMmxVZTd1?=
 =?utf-8?B?QVZsck1LdlcybS9GYkRvYUF0TGNwSk4yZjJIU1I0bVBHb25oSjB0Q2ZEbHpz?=
 =?utf-8?B?RDlJZkdiajRlTEpUM3ZkL2pTN0dpOWhTT01QOUdRd0c2UFVkWWVLWlBvQ21w?=
 =?utf-8?B?ZGJWYkt3a2hYbmJBUTNqczV1OVNLRlh4eGowRHExSzJRUjBQdUJrRnI5UjVT?=
 =?utf-8?B?K0R5MEdaaGoxcEduTUt2VGlhTVhJN0hlUVk1d2ozK2M1b1cxQk55RkRHT0s3?=
 =?utf-8?B?Ymw4RVJ3YWpSTUlkM3lQQnZaK21xQzVLQ091a0pwb1hYbzRIb2FTcTFpRmdm?=
 =?utf-8?B?cHFHV3ZNQVB0RXZTUzd1YU9VR0ZxZGhWanR3SW9TejRnQVBnRUdRV2FDMjBh?=
 =?utf-8?B?RWRxUThKMmxYY295VEozY2ZBOWFaNnZLcjQzVGlLVFBYbElXTGVjRnFzVm4x?=
 =?utf-8?B?c25xQUZZcFlia0txTDNHbDBqUldUSTMvV2tVVG81K1Exc3BFbU9QdkxXRk9Q?=
 =?utf-8?B?MVlPYTZuZEdDeHF6WEVBd2wyT2g5Y3ZHSU1YWnFFbDVaRG1QdHNDN25Kb2Uv?=
 =?utf-8?B?cXNnM3FPRWVJMVpUQjBFY055QitNT0dMYTdqY0tuTUFwakdsZUx6N09SNXZP?=
 =?utf-8?B?c01HVmFXVjNUUTFXVW1HdDNkWDBnU0taSVRHRXlESTZPNUlWUTE1N1J6WStU?=
 =?utf-8?B?bXFyQ2VFamg3anFVNlhwaWVEc3A1OUdOVkF4dEZNMTRXWFUxeSsvZkJUSTZl?=
 =?utf-8?B?K1pjM1pGVi9kY3dPdVhKVmxvUFJTQ1lYR2REck1kNndkS2ZyL0ZMOTRUdmNt?=
 =?utf-8?B?azRoMkJzanAxWWlWN1ZrUzlzTHU5TkRNa0FhSU8xNDZvVVFlcTNIWit5cGpi?=
 =?utf-8?B?cVFtYVA4dWFwa3N5OHBmSVBFbEo5dzhrQXgrMjErZ05jdS8vNW9qdUtaZkZL?=
 =?utf-8?B?WkN6UE1ET0FoNlpPb3EvSmFDcVRmRnhtVC9CTkxBUWhhbmcvSG5xRlRVT1Ix?=
 =?utf-8?B?VmRxTEVxbFFNOWxQTy9mVjRSZ1lEQStQMUlPTytXWlYwTXpkY3cwSWNHNkNn?=
 =?utf-8?B?QlRXMHppVm0wdXNXMmpxMDRSUDNtdUtnL1IwS0FSWEswQWlySDBvdWdjb1FZ?=
 =?utf-8?B?ZEIzcmdhL0U5UlJQdVlRdk9IbXpMWjVlSERiWWwxWWNIT0J6QTJhcWNhMXVE?=
 =?utf-8?B?ZEdHbWZFRHJNYmFiVXkyb3o0NGV0NC9UTkRUNDFISXgrK0JKZWZnVU5qVUdB?=
 =?utf-8?B?UW1SRWFTMVNpalMxakVETDlUQUswLy9HS3ViKzRJbWpGTmpkN1RaQnAzZkU3?=
 =?utf-8?B?RmFpd0JZVFQ0eHdVWTM0aXpZWWM1WVpSV3JkS1RRVEdVdWFoOGM4MmdpTW9V?=
 =?utf-8?B?MENLeDFpRmxnYVB0U1YxbFZyU2xucnNMS0c2c0R0d0V4SWxIbWFZeThhWnJk?=
 =?utf-8?B?RGlyQjZhNXJmSWxnSVFtbUxiSkp0dDlDL2tYNWhIM0pCK1dWWlc0b0lQR0xN?=
 =?utf-8?B?QW1maWFLK0pQQTJyQ2V6NXY2U3VZTlVJR0lRVndFVWFJUlh2Q1ZKUmhFWFRy?=
 =?utf-8?B?MDVnL3NCNzdFbTE0SVA0NlYyUjZMSlpGb0NHcGJtd1V1Yitpa2NwTUVNNDFS?=
 =?utf-8?B?Yk5WSHFaR21yL0ZnbGNGSDdTSzFPVzNQUTZlbUlOZWVEK29oSWxOSDlvK1JJ?=
 =?utf-8?B?VnAwZGF3bTZQR3p5Q2c2c0tKQTBwaWtiR3pwalgrbTJaWnZ4YXlpMWVVTXAw?=
 =?utf-8?B?eHdWVGVvb2liczkrbzZPVXNPSkJJRUR0MDBiMERncFkzMWtINllNYmd4REp6?=
 =?utf-8?B?Ylk4Q2dqbVYvQ1hlb1k2Y1o3ZlR1SnhvUmdoMS9HM1VSdHhITUQ1UUZqZGFK?=
 =?utf-8?B?cVlKOXhSUmlHdE5vU0cvSThhYTYwam80UGY3eVcvOXpzNG9Na1o3anBTb0w3?=
 =?utf-8?B?Sk9vL25jRGxseTk1aTM1MjZqQmhvcGNnK3EzVjhSdW4zUmlTSmtjbXErVENN?=
 =?utf-8?B?aHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	B+6KzRXycxanfZbz3bBBvsOogLPcHKkYBt27gQBcBNOMpZxlHl31pFEXQ0gdHC9Iw0CpBqMikltXuCj/h72nEKzXkni1vClkvjm+qzaa+76gtCmZcxaykAr0veNzN1mxPaZP0Zv87/AjpE8XSVi6dZxbNWai3R7z11pPvqzLpfotHOKRpcjaZeEQUKw5BXzniDxGR/tAkX61aSNZVz9iAg9w6JZEHKpxnqnzSA+auEZbDs/F0mrxfibjnA6mnX4b6euCyB+aEXlRjwENKpn6QruZN0cRn87xeztotrZm/xOTwW/1nJWe4+6TE83UW8qe904lx54mu8A8Vz8u9DJNbealn3Fy08PhMDPaVlRdI7TjDcI7xzRmCXLi1EOBv40htylA9fPf51mU+Z6cLQr/L0B4esM/DlgPIm45aTyvH9J6u150aP0oBTMZbv7sGlKp1QQPfOoYaHdQEfBf/4aKo6oh1bqADa6ot5kGzObAeYcS5k8OBaVNAOunG+XrbWlp5+fEmnr4NO6ZE3tlEWM4CsYGBCswRs0Z4h8KIeRdpwo8HGacG7Zyfy/Q7lzBnBxj7odMvbfk/hOtAtBtzeK0/sCnslhG8E9fneW3IqzAZD8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56b5abf5-1060-4cfc-8eac-08dd1f5551a6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 11:15:46.1418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h/YZBmE9gWAWF3yBNXYuxAxJWEERI53SwuK6j1Xx6hxMml5Ca9VQTm4Q6efHVP/0sgn12Gh7h94cx03x/BmC0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6774
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-18_03,2024-12-18_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 phishscore=0 mlxscore=0 mlxlogscore=751
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412180090
X-Proofpoint-GUID: 7jAK2ZVjsPe0aAuztUPkkMTweG5sO3yh
X-Proofpoint-ORIG-GUID: 7jAK2ZVjsPe0aAuztUPkkMTweG5sO3yh

On 17/12/2024 07:08, Christoph Hellwig wrote:
> On Fri, Dec 13, 2024 at 04:56:38PM -0800, Darrick J. Wong wrote:
>>>> "If you receive -EBADMAP, then call fallocate(FALLOC_FL_MAKE_OVERWRITE)
>>>> to force all the mappings to pure overwrites."
>>>
>>> Ewwwwwwwwwwwwwwwwwwwww.
>>>
>>> That's not a sane API in any way.
>>
>> Oh I know, I'd much rather stick to the view that block untorn writes
>> are a means for programs that only ever do IO in large(ish) blocks to
>> take advantage of a hardware feature that also wants those large
>> blocks.
> 
> I (vaguely) agree ith that.
> 
>> And only if the file mapping is in the correct state, and the
>> program is willing to *maintain* them in the correct state to get the
>> better performance.
> 
> I kinda agree with that, but the maintain is a bit hard as general
> rule of thumb as file mappings can change behind the applications
> back.  So building interfaces around the concept that there are
> entirely stable mappings seems like a bad idea.

I tend to agree.

> 
>> I don't want xfs to grow code to write zeroes to
>> mapped blocks just so it can then write-untorn to the same blocks.
> 
> Agreed.
> 

So if we want to allow large writes over mixed extents, how to handle?

Note that some time ago we also discussed that we don't want to have a 
single bio covering mixed extents as we cannot atomically convert all 
unwritten extents to mapped.

Thanks,
John




