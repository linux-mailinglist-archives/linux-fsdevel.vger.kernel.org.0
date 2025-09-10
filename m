Return-Path: <linux-fsdevel+bounces-60748-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21478B51205
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 11:02:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16BA21C8125D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 09:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76F1311C37;
	Wed, 10 Sep 2025 09:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="I79InGok";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yDMx8Bdv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48C12DF701;
	Wed, 10 Sep 2025 09:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757494920; cv=fail; b=DHIe78esGqpfn8ZCq7E9mzgZijutXerXfhs8mOkZI04YAMpUunDgnlfTDpboVgeCUwn0Of3cz9sSKMUBoMjDJtTPnlyrSy3VvwfKF0idAy05850VFoCBpD7oLl7MbbmXs4tx+msD+pGMoCNgxgj9R6OG015UXr70I/tEzD5ih/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757494920; c=relaxed/simple;
	bh=ySpc9yB12TClqG9xxnHNAcQEyiuJZs9pWCajppQfSec=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iOJSxzb45h2R8ciZmSRlUCddqc5JBZgxkM/Ej+uK87agHnmUSk2YpuCX+8AN+mhDSQ0Utsqbt4hdhaDPz6f6BGBu+SthOCekFxZe/5t/P/Vo7+/7j0JhRbk2A0cmRUKP6dzq8Z9KNfT/NWH7iypUOao+JxuojqCXSnDmgylSryE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=I79InGok; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yDMx8Bdv; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58A8NZrE029384;
	Wed, 10 Sep 2025 09:01:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=cH3SUQkzHCZSQoTnBRg5awatl79xh6Ns+7Axdrtahss=; b=
	I79InGokQQ8L+hG9XRJCMw+w9/CLjhK3m/bhcFUFPFXv2AQTAz5LJh8j2/C5PWPV
	gaQMmWrU1cODZbqKkyg5JyHEUpqZUDBNKj+KsZPq5N/6ZkPtl46qINc/kCDtSS8C
	vG4PD+BoOJn5N166krTpFyJA35PKDmdg+AtIoBZVHKnKIZBBnEVZfNto3D8WDrV+
	xA2QDFp3QCVkMrpbO/JCJjDuB4HDxqcoAtGdnG3sxMKFgNdhbMXpqpNQDxsv1Inp
	wpsnnvts3RBTrkqj4riLR5m7nt6Z/BduMua7/vNdDCWMaocaLBgevQ79hB5GjZpQ
	DCuI2NC7H+k6pXbemN+R6A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4922963qrt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Sep 2025 09:01:34 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58A8oYT5026058;
	Wed, 10 Sep 2025 09:01:33 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012015.outbound.protection.outlook.com [40.107.200.15])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 490bdarp74-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Sep 2025 09:01:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VyX+t+7MJpAUOGbVyGzE4w4qnD5AlVEZ9wFhOy1dbmCgdaq/nrTzzYtkbzKT1iQZ1dcapnAvoIXc0lCW/oDlXGc+dHdOvGYqN/9nbebMBH/c548TpFZP68sPoKZCgWeaFkE3cK4KpmnMenWanRaHrXlyvz4AYLJ4fAYSR8dhbccYep97nsUHNzQDiLyjonqjxlW98vddJgc9+xHVIzv+XWm6gPXDCr8Fh2kllz55ayyvCbrqYj7AUw5N28WiKGxAqem9HQNqRkdqQIpx69hjRXEQqLZrtNcbVo/g5mtAYeEv8cgE4RqkKo4LLyIehjID2xotmjrW2ykTI3sZreNp8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cH3SUQkzHCZSQoTnBRg5awatl79xh6Ns+7Axdrtahss=;
 b=d+g7xzLXChTopV3zXKe3Y//x1Z2b+ylvuHG0wopn6OtoMM7k0LSFYykwIXAjt4UHbKpwlX2n2fUUpRYTEOE6QyF9TTEgzNttJpeckzYvbbH188elIGBRWvMZh5hCelteSmCWn+9o1usBa3IpMJ0riJoa0TXYc3sTylWn/WMWDAoNNuCcJFFL/KPaqhanb4+NM2mXT3y6NPjX28dktlFji70hXouuRvH71Mzb32l5cjCJRLN+/QsU2BFZWDdj7kwXYdHd3ViGH7zhLDQsmQHsNpjk8axmew6F7Js0Y4wVT+9HCHnRRruzSPNiHU9x95gZzuj89uoWKOT1GE6LEG87Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cH3SUQkzHCZSQoTnBRg5awatl79xh6Ns+7Axdrtahss=;
 b=yDMx8BdvFq/yI+9hv94Gqb0eeIECWBPZq8t+MGvAaNuHp830QDsGSj0ke4rjWn3Kipp0irKX58EnDKd1p27N+IiSOPSDkfznrL0f/OA1QsyRtHlAngquM+dV88xdBiCX/x0xdzhUbBl/DNoHtW1QUIM0KoHTrvlRwq+p13gvw5M=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by DS0PR10MB6127.namprd10.prod.outlook.com (2603:10b6:8:c5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 09:01:30 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%7]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 09:01:30 +0000
Message-ID: <7956f88a-310c-48b1-9252-23d843d932df@oracle.com>
Date: Wed, 10 Sep 2025 10:01:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] md: init queue_limits->max_hw_wzeroes_unmap_sectors
 parameter
To: Zhang Yi <yi.zhang@huaweicloud.com>, linux-block@vger.kernel.org,
        linux-raid@vger.kernel.org, drbd-dev@lists.linbit.com
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, hch@lst.de,
        martin.petersen@oracle.com, axboe@kernel.dk, yi.zhang@huawei.com,
        yukuai3@huawei.com, yangerkun@huawei.com
References: <20250825083320.797165-1-yi.zhang@huaweicloud.com>
 <20250825083320.797165-2-yi.zhang@huaweicloud.com>
 <5b0fd2a0-dffc-4f51-bdff-746e9bd611bd@oracle.com>
 <70c56bd4-89b0-41b8-8ac5-c38ac97319ca@huaweicloud.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <70c56bd4-89b0-41b8-8ac5-c38ac97319ca@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P265CA0013.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:339::19) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|DS0PR10MB6127:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f44d3c9-2801-4d60-dcb2-08ddf048a1e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V0JpRVBnVkJ1Mk03YW1kV0hsY0Nzc21VVjZ4TXVkNVpldG56TTBOU1VzeGVO?=
 =?utf-8?B?aktWMVZNTmttU2wwTjE1OC9ramIyS09ndEc3MHI0cEhCdk8vV0tHd1BBYThH?=
 =?utf-8?B?UjdjUlR6bDFPcmpnK1V1RVFnNjNKTTlJdjRnNjFSQ1lrYlI1anB1UG5WbWlo?=
 =?utf-8?B?VlNCUllaKzMzeld3eWRRZlJxc2ZiZGhCZFBXa3ZaUjlSelRBNy9KTDU1SW9x?=
 =?utf-8?B?c0w2SUVFMmoxcEswSEw3WUlYSzhLazVZNWxMb281b2JDUnBrSjZyS2VKRHBM?=
 =?utf-8?B?RE5aSzlkZDkyNktieVRLVDBBaFlnenBlZDQ2TGRwMTQwNnJIQ3BEMXNJK1hk?=
 =?utf-8?B?UjZBMUx2bndIa2NUS3o5WGpLMHE4VTdSNE02d1JCL3VtZjdscExsK2lPaFVJ?=
 =?utf-8?B?Q2lPVUNrRTBUVWlxUG9kUFZ4L0NnVjlUdWFyeXV0VENiM2RLSFdLV3YraWVI?=
 =?utf-8?B?UFpDR2hyV3VRSWNUaDkxWUREakdSUU5uczZmRGhlbzVSdzlzaU1UNEVFemVN?=
 =?utf-8?B?ZFY1cWxZMG5sRUU2V1Nrc2xjOG1maW42M2ZQT2JQUndUS0VYOW9XYURwcC9z?=
 =?utf-8?B?blEwVzQyR2hRb3NGWHVPL2E2NnpMaERmVkNEUTNJNy84Vk13ZXhkaE50aWZk?=
 =?utf-8?B?eTVIQ1hyQXRySG1PbVh0a2hlR3luSmVISjNNa2E4T3AvekJlWDZlTUpzc1Zm?=
 =?utf-8?B?MjNabHRjanV3cmp5cWxDenEzbHpXQm9zamJPdk1kZENwTzExY1FlUmlxQnN2?=
 =?utf-8?B?amV3cEIzR3R5NXZlaTlOVVB5Y0F2SDFqMGtUNEM3b0YrRkovVzVaVko3UVJa?=
 =?utf-8?B?V1lSVEoxRTBqaExSNTlsamNOK2tWak90QXdOUzNDYW4vS3k3Qk5KZTRYS0p3?=
 =?utf-8?B?UEFGd29lZTh1MFdRMEFwOWtwWXR6RXhmTlladVBsOFc3NUJMLy9TdkNvcTNk?=
 =?utf-8?B?OU9zR3krWTRJdVJ3b1I0RXJqNkszcGgvYWszR3VUeG9VZFkreGJMMG1zb2Zj?=
 =?utf-8?B?QkZ2ZU1WSUNDQmM1SGNsWjlpOUlLNWF2VjliaUZqeTBEU1VKaVhXZmxjY2Rj?=
 =?utf-8?B?THloN29mWHAzYTJlbzYwREkrb1pRTmRxK3FPQ2hEL3Y5MGxmaEVuL0VWYTFV?=
 =?utf-8?B?WnpTQ3hWZmJ5WjRtUWUrMklmUDl0OWNmazlJcE5ydXBxOEpDM1ZEc2p4ejhJ?=
 =?utf-8?B?dVdrRWtuMDlUeVpuMTFnTVR1R2FOM2RTaVhzUVZOMGt4U3QvdWRSUS9PZnE2?=
 =?utf-8?B?QWEwbEg5QzhyOS96bGtmS3c3RHZvMDJlTGEycGxoS1h5MDh2Rmh6L01EWGFS?=
 =?utf-8?B?SXJvVVJzVnU5a2pFZjNqY3poNTlWeTcycHBMTHhsank1d1crZ1JoTjBEdzlB?=
 =?utf-8?B?bkt2aENtQ2ttaVdSQklmYnhOaGFVOEZ3NytWcEZ6ZExjcTd6VFFSWHd1UGk1?=
 =?utf-8?B?eEV2Z29aSGVsTndpR1c0eW9iWHBDZW4yR3B4bCtqZWRHTFRLTW91UFlkVzhk?=
 =?utf-8?B?NDRqZXlwdDVQakZpNyttVU1OUndESm9Xc0ZkZTZIL0JxZVNPQk5SQXpVazdr?=
 =?utf-8?B?b1FxU05Icy84dnlMU2gwbXJkc09kaEF5dkxsaTRlK00waFpKOVlhR1ArUTNz?=
 =?utf-8?B?a3h2RUtYdjhmTzFndWh3NDdNdjF5MHVHTFBoM25zdVNwajZBdFBjclhFZTAx?=
 =?utf-8?B?V2FwakltZkFaRXJSTHczMkVpM2Fyd3JPZ1R2ZnNzQWdJR0F6cHdORTZGOFJh?=
 =?utf-8?B?RFBFMjZkTGhkQ2k1TStwTjdrNzNrUzNrNjFBdi9GTXNtSnlnbmlKOWtVU1lU?=
 =?utf-8?B?YVNKM2x6eHFyc3ljNGRyaXVRYkwwNytsN1BIbU1aR0hQR3VjaDZHWTZ4VUlu?=
 =?utf-8?B?T1ZRR0E0S0pVVUN3TXBlYm9RRThkYTRhaG9KR2s4U25sdmp0KzdZdGNNaWds?=
 =?utf-8?Q?ofWNMh0rKDg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RVpZSENTc3hHdUtzOE96dGZZY05IWjNTOTUrVXd6U2ZTOEVQVklXKytXRFFO?=
 =?utf-8?B?SHpxS3phVFNDMGEvWWlXS3JxRnVMcHJZQ2dsek1tOEZnS1ZNRmVldVB3UEt5?=
 =?utf-8?B?MHRQcncxR2drSXYyZFEyZ0tUTVNieFdQNk1PZHhETXlwMW0rZ0dFOVMyZzFq?=
 =?utf-8?B?ZUhjQXpDRlF0SVZiR2RuVk8xUUE0Sm1nQTdlL1FYY3VKb2hZOWl0TXhTbVBB?=
 =?utf-8?B?cTJtb3E4YTh2WTlrdE9tSEh1akgwemRQQ0JxbGUzNkdVSXoyMVA1THNDVmpp?=
 =?utf-8?B?NEJhZUpYYzlVYmczSDZZS016TzQ3SnJhU1BzU2FETFIwSDNXMHpFQk0yYXUw?=
 =?utf-8?B?ZE5FYmwwNnZFS00vUGpJYTE2N2JCSHVqdHpYQUFNMnFJUHRyYlp3UGxPWTZ0?=
 =?utf-8?B?bnN1U216UkYvTENRclZSSHpFUUVrQ09LSnlMejVYckZJRU02M2pMMnc3TGIr?=
 =?utf-8?B?by9kd1VzNDZBeDdCdmNsSWJ5aksvdHdaQ0hIbDQzSmxqc3RXWGxZK0ZRTURH?=
 =?utf-8?B?MHYwcDZybTNQV0NvMTd5dkpwVU5PUWRLTjR4dkFEN0VuNW1BUWcycjJsUDAw?=
 =?utf-8?B?Vm5rR210clRPMUgvWWlEUlE3MkNZRmpTbERGRVZ0czhyZDAvcDNNUGV6VU5j?=
 =?utf-8?B?TEFLZlV6RzNidTh1SjRvWE5HSWtobVY5R0VERXN6L1V3OFc2OFBTUG1PVGU1?=
 =?utf-8?B?ZUYwZWlHQ2RKNE1Edk5xZkFlSnMwOGxkc2N3ZStTeGFhb0Q3U0tvUTVvZi9Y?=
 =?utf-8?B?Q1VjWW94OGU5V01nZlhhcDMxZngrTE54YTRFMkRBc1ppWUdLRENtdzRPM3BD?=
 =?utf-8?B?bHIrMWJ5TzRiVkxtV3dLMWdlQVhESHRYdUxGbVQxYmtwTFdXU2I0MDM3OVNC?=
 =?utf-8?B?ajgzOFc5azdsKzJMZStweGFZelNhai92b2tGbkN0WGJXc0taRnRiTkRiL2ww?=
 =?utf-8?B?Y3hUUUk5T21reWt1SkVIWm5BQUE5N1pjZ25EVkpOUlQrWjVjSGwxd2h1czll?=
 =?utf-8?B?WUlIOHViamlYZFk1aStTSFljbzNqQks1aFVxUlhLWCtBUWg5ZGV3Yi9jUG1X?=
 =?utf-8?B?bGxPRGxkcnI3d0Erc2Q2OTQ0U0w1bjcwL3ZpOUlIRDdVM0Y1d1UrT0FlZHgy?=
 =?utf-8?B?VGtQa2JtcHFyRjZvcUIzZFFkVzFla2F0ZnI2MW52M1hiZElROHRqRVlJQjVs?=
 =?utf-8?B?QzQzRVp3bDF3d3VQSWlpb1J2TXR1amZSWnpXcVc5UDF5eEZybytnMGZZN2lE?=
 =?utf-8?B?RG5pdnFqUWNwU0prVmFRMWszOHZpQnRUU2tuWTZZMk40S3VNSEpHaDYwaVhx?=
 =?utf-8?B?T2c0Nit2ekdHUDdkeXVOMDJ2LzM5Vk54bXZIQTlTS1F6K3NQYlVyeHN4a1ho?=
 =?utf-8?B?ZlZNUHIxTkpwTW9YZEFOWE1nOW5BVGx6Y3hVZnFxQ2JlV0V4Qzd4K2FodGdI?=
 =?utf-8?B?OSsxdkJoYmZlbHhIeVo3TVljcHh2cFdPVFZPZUdpUXc2RWc1RkNlRnoxeXBx?=
 =?utf-8?B?TkRoSWphSXUraEFrQmcwRFp2bi9kWnBBYkZkeHZ4ZjA4TWptNlVtM2FwTm00?=
 =?utf-8?B?dmZ6TC91dXhXWkNFYlhGWmtaNVpPMitqVyt2WThlT04zWlBQZXBIa1pZS0xR?=
 =?utf-8?B?Tnh2eTg3NUhPMFl1QVZ3YnVEdmovS1RyeW9iNU1DOCt1c1R4YkluYnVWUnpT?=
 =?utf-8?B?citTbitHUTRRcW1RcjNGNmovMmZ0SUhzTkJSTlJNb1h6a1UrdHc5SlZEdU44?=
 =?utf-8?B?WmF5ZC9McG1leUR6MnQ1UE9lYlpsdnVQVmdnRHNnanA1bUt1TDVxbks5TWpw?=
 =?utf-8?B?K0JTRnQ4ZWt3Z1doUXkrL1JkZ3BsdGJ0WlA0WkNqVEQweW4zbW4vMVZGSTlL?=
 =?utf-8?B?bFVwc3B0Zm96bytpeVNFL1haemtsV2FkOVZIZzZIY3JhdTc5d2JXWmNxYVlh?=
 =?utf-8?B?elpjMnVzNmk3Mm5RVVh2QUhqTXUxS2hsUjZPdjN0WUJVYlk4ZXRDVXJIQnBs?=
 =?utf-8?B?THNwQldsaUFpNTR0MmdjNmtnbG1PVVZrNWFjUVpETFNyZHhHZDZlOUtMQm1k?=
 =?utf-8?B?R093YVVZemhja1p6bUZ5UTFiK1VxR1k1ZnNQZ1RnZ1hNbWtGc0Q2SHF6emJY?=
 =?utf-8?Q?eoFtOoxOn0hkxYU4ki/bfmUiV?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Pe4H2fzqoK2/OZFuvl4ulXRh9oYdCM63fh6zR2VN9gEBZew6DomzJG537maHlJU/Y4DfiYld7QOcH7jyXQuC7KvpvI4NBda+Ju8knqyndc24TmPVN680ik7xrvGBX92TgYizUp+/bMt9Un1Hfm/113M+G8u1a6i1+gzmckOETAgDoVoiGzg5qKXR3uj2tCCtbMYjDJWdU+NOeJxBN52qzx8Tr31QOH1DY5U6H0hbA9BVT/54uil2mKslZ18nX4NVnxqAtyhef3Y8ldd2tdMexa1h93suqkeBV9kVptyrQBDO11Wn1+PQs81jECsnp2/hGCr5pXM1FudY2IXq97ValfEOGosIcAP229E447BLUmNbmMM3JGz9CjAqGePBKterIyoUINfl9lfnKp3V9dA1IK+C7FHYGpEwmvm0GPGPlpOUnXYWPR9fipg+nNX2myjjLFA2uptwMQgDKt2PY3xDDJcG2JVvpQCz10HS5bY8cLVptUPWTBIxsDg7koeHbi47dQqqCI3oPUEfYknczO+zeBty7pG8vTFOUb8UyfrUZlv6KA22knd1dvt7OmN50TCZGykZiRbAYU05a53TDbJ5HBCs0K+VW6zngogOWDQtFMw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f44d3c9-2801-4d60-dcb2-08ddf048a1e0
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 09:01:30.3031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8wV1y0i7Co/w0+6JBwbWWQrdEHNEkGhVPKL+Q2gXjIOQ/AYKvHIBCSzzZGk51PrACOnb5b/nPHVxoelczRhNwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6127
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_03,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 mlxscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxlogscore=988
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509100081
X-Proofpoint-GUID: IzxC77g9VkhPQnSgxSMUsD1O5bILB_Iq
X-Authority-Analysis: v=2.4 cv=CPEqXQrD c=1 sm=1 tr=0 ts=68c13e6e b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=rUcJnThiqp1qSaHFy7YA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13614
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE1OSBTYWx0ZWRfX+ezZolHkPCoG
 4TE4tBO9YhXm+vtYHrUwREbOrEYjKvGiPxPcXYO1anxiqMYcK3FqY4qvLLSLItdAZrzMNNW4Yqu
 u06qEo+bHjt6Lculf0zCDz268EaCaxbs6/iNl02u7RYsdxRuMqdczX2KYwhA1OHlDvnK0yYCNp7
 A2BGMxKQC6ZOfVNkExXo88swXawEUxEXmctM4tncUpyFGNsM27OJPsj7wcwxWjCvdZZ4OyKP6u/
 3uiHJtWEfOyVt2oWRhVk9vou1HleZSImWdKK4pxTFAjevWJ1VYffE5CiUl9Mxlpu/5J3nFvR4+W
 A2uEFWJe3C40H6uapSjpC/9kW1vL9VdcFeGbyKbY1iL7WmRANnR3itbaMnQIdMAska36NO4L3dw
 3Me3NM4XfKpS2VbRLmjxxBojXdf4Xg==
X-Proofpoint-ORIG-GUID: IzxC77g9VkhPQnSgxSMUsD1O5bILB_Iq

On 10/09/2025 09:55, Zhang Yi wrote:
>> It would be better if we documented why we cannot support this on raid1/10, yet we can on raid0.
>>
>> I am looking through the history of why max_write_zeroes_sectors is set to zero. I have gone as far back as 5026d7a9b, and this tells us that the retry mechanism for WRITE SAME causes an issue where mirrors are offlined (and so we disabled the support); and this was simply copied for write zeroes in 3deff1a70.
> Yes, as discussed with Kuai, it's better to add TODO comments for
> RAID 1, 10, and 5 for now, and we can support them by properly
> propagating unsupported errors to the upper layers. I can send out
> a separate patch to add this comment.

Sure, adding a comment would be good, detailing the technical challenge 
in supporting it.

For now, this series should go in ASAP.

