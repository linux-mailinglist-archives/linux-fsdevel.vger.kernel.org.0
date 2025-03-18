Return-Path: <linux-fsdevel+bounces-44295-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A937A66EAA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 09:43:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F574188736E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 08:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9262036FA;
	Tue, 18 Mar 2025 08:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VSV68zsM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gdui/Kne"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763C085260;
	Tue, 18 Mar 2025 08:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742287377; cv=fail; b=qtWV/9I5r8VPLOG0cVxdCfkoGg2gtylpayYwoo68+ReimINuRMfYpvE5xAt+XVrOTy/OKoTIC5nTccV6cO/QLNBE5CYR4r/9Im8TwzFo/VdYJQRCd/gQNA0PFvoqZSEbNmnxLhwrQ4OlABh5Eop8x63rzUwLTRCstSrG1NEOWmo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742287377; c=relaxed/simple;
	bh=62FpvArjjpUqsPITbFQE740idGme5/eOOQPw+mhNeEo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HusoETsVm8bVtgGZMhnKP/obey0PGnUpl6poFaaeNVQ/+rEV0vxXDT2KiLE2yMcUy9Mzb8xMzriONOS1BckQadN0EV2jLFA+//x7TTWch6H/+Ab0bAeEGVmJY5ZgnjbI3uqLwBT2qcIzd61AqP3F2zrx/iwQurpWW76k/WX59KE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VSV68zsM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gdui/Kne; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52I7tmkD015945;
	Tue, 18 Mar 2025 08:42:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=I118NeXQQ8S4n37xXwWLGTjx2ytHoEflzQT5cxaVKiM=; b=
	VSV68zsMkcR36K/CynBJUPY3HxI9TeJivzb2PXSxlp8G6lPKmNMoikuCyjzo7h2c
	f9eq+hz0mkKDm6yMx8yeZRx853TXl2Pi64fSiDRkNSMbKDBzB96XHqB+xb8yHyNN
	YYCFAbNXCAZ8f3kTVS8wBUYRlzm9nBBMl6zPD+3Zj1Xj3VGWWWmm4PNbNCKs1Rc1
	sDbmss6wt6vUULYGlkQr8gXJY11Olmq4vEutzqup0rXmAC8Jh07N6M75hIhhKZP+
	5Q1zLKR2tV1J0k4QOr4j87gWhQywU34aaVw0MxH1q+IsowcrLAyJ8Oio9jBU9nnN
	LfZ9xjVhaa5tgCeQoj2dpw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45d23rvn3u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Mar 2025 08:42:43 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52I7WPEV022319;
	Tue, 18 Mar 2025 08:42:42 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45dxc59h6j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Mar 2025 08:42:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YVLraL8iUEcPSWKvDSXBbuj7LUVOmcKivim2s3EeXMlmxEo3NgVqaAWoEyqLhwmBpowLymcKttA+qPqkw8DGhxzgEyxUtFQ4j25zM7q/v4qQceM9BZ3XufRfAryeF/ssAgvvn+rj1HH+kItHVy6KE1xDNKWDmI9jkpddDfskv4GeB4WgwJ0N/tFxb9cjJXHjTVgwhEkbqckb7hQsH4RGHPesT93wjFPLV+Vk1Fs3cts6dgWgSK/NJfGZM8Rwz7KhvzAUwxyTWnN3ZJoK1W+YCy/gx33MHVyeTKNwSqEI13N9Jw9AY/8Op5+qxl89iudIMWvC33AaixF/qQlYpfJ/dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I118NeXQQ8S4n37xXwWLGTjx2ytHoEflzQT5cxaVKiM=;
 b=DudwQE9NCYupba58Fnlxf7+Onj0+Ex/YWcroNT6ekV4T0Jb9ySUNU/XoSr2OwFNRkaezl8RXH8IVdLNJ/63i0D+yfXO54udxEULxkjhUVEg8mI6Kqsb9HUUqNVioEq62eB+onL9w+iFbOMI8tzh+Lu+BoJSK6eiFT2q79Qd7Eqj1ligFROWhZ3RpKwjAtX7SNF0O7D5vtjPvIJie/jDL7ON+KwsvrHGPwuMk+QjGEX8l8HV6GRqT+Fan053sYOHeLx0mmqKYZoPc9gmOaPBm8k+JgTBsW+lW+V9lVkeKAl35PuuVQ/neBYn+Cz5pwBUoUHSdsBF2WRntJKn5JmyOzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I118NeXQQ8S4n37xXwWLGTjx2ytHoEflzQT5cxaVKiM=;
 b=gdui/KneFlE+tiufYV92tNh6FvLkbmiWCGmz4tIjjDzSOx141rZeaXN5kdXhh90se72ifRWEVD64GtgiLkU4iC7Ee72FEk7QBib8fLvU/niJ+OE7XabrdYPkjViCdz7Pi2ZSpEfZXZiV2FvLJJq/Rt3vp8j1o0iDC5iepSHHJxY=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS7PR10MB7191.namprd10.prod.outlook.com (2603:10b6:8:e3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 08:42:40 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 08:42:40 +0000
Message-ID: <08992e02-9ff4-416e-bd6c-e3e016356200@oracle.com>
Date: Tue, 18 Mar 2025 08:42:36 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 11/13] xfs: add xfs_file_dio_write_atomic()
To: Christoph Hellwig <hch@lst.de>
Cc: brauner@kernel.org, djwong@kernel.org, cem@kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com, tytso@mit.edu,
        linux-ext4@vger.kernel.org
References: <20250313171310.1886394-1-john.g.garry@oracle.com>
 <20250313171310.1886394-12-john.g.garry@oracle.com>
 <20250317064109.GA27621@lst.de>
 <7d9585df-9a1c-42f7-99ca-084dd47ea3ae@oracle.com>
 <20250318054345.GE14470@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250318054345.GE14470@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0469.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a2::25) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS7PR10MB7191:EE_
X-MS-Office365-Filtering-Correlation-Id: 6690a2f9-4727-4535-9f28-08dd65f8d7b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WWl0VmE3dlVScEVaS0Z4TjFYT1hzbUt2SmFWM0VjT0FkQ1ZTZFVSZkc4QTV0?=
 =?utf-8?B?S2FTandSMWg3Nis0UmEwSTdlZ2RMeit5UGF6L21hTHIwdEJTajNwOEN3MlNO?=
 =?utf-8?B?cGlnTGVhYjU0VGpiNkl0LzVmYkpnbklpMVRBREE3RXlCZEIzQ2JyenVsQnJy?=
 =?utf-8?B?aWFpaTEyTXRvYTI5NXJMZHBBcXR5bEtUV3hMMEYzKzFtMExlb010UlRCZnF3?=
 =?utf-8?B?ZHdDQzZIV3IvZDBOUWlxQlFPSyttK3FpVTk5SlhWdk42M1BiaDFUa0FwSjZo?=
 =?utf-8?B?cmRUMXQzVU5kKzRMU2Q5akFVT3ZJOXVNcFRhaTVIK1RzSFB0V2owTGxxMnFq?=
 =?utf-8?B?VThLTTRSYjQzWHFLbFlZVUxlTFlhZGFaT21qVXJaUGx1U0xoVjdONUsraGV1?=
 =?utf-8?B?Y0JDUVVHYzRTdlIydExqeGtQbUhjRVNoWEhtc2FNL0tCM2F0dUJmVUZIby9T?=
 =?utf-8?B?MzR0dmFUcVNwbGlGaTJ4M2ZoK3BmWFkzZU5hREUxeXQzaEwvQWs2ay9TbTRM?=
 =?utf-8?B?cmlQd1BoQ1RvRWxDeFN2SGRWNUwyZ3ZpZHRuVDc5cWpVc0IvaXBmelE3cFNu?=
 =?utf-8?B?SEw0WktSekIxNkxtNmxsdW5SQk5PSCtSQS8zb0prSnl6cklCbW9tSGJRbGRU?=
 =?utf-8?B?UkIyZi9oSHo0VVRNcXV2V0hxek9pbHpmQk1COS9oWWV6MzM3eHN5clhFbXh0?=
 =?utf-8?B?c2xNb0VTTDA4MktmT1JQQWlXNnZJUDR4UWs0aUlZbElYNGlZL1V2Q3F4WWNs?=
 =?utf-8?B?RC9WSktYb2lTakQwenBzemZBeUxPUUZjQzZsUFg5b3JjZ3Rma2VSTXArYmJI?=
 =?utf-8?B?MVJoS2VlT2gyVTd6TjA5WkZNd1V5QmtjR1B4Vi9iTTN0S2FHcVorNmRvcU84?=
 =?utf-8?B?UzNGWW12bGZEa0F0bzFQOXI3Und2VHBoeVAzL1dmZFFQM1hoQmp6elNTZW9w?=
 =?utf-8?B?UXR6TE8wMjl1YjNXRWhKOE0rNFphVWw5Q3dVZkNtdldWTjNHUUdrOXJBUTQ0?=
 =?utf-8?B?WVFPemNVeTBKei8vSFJZTGpYam9zUUJjSnF5eGtydmdDSXRDOE1UaklkcldJ?=
 =?utf-8?B?ZEc4ZDdQVHJwVTM4V3Q0blFVZy9kOVVYQkhoVHJGam5VaTFuQldOZW82SEdB?=
 =?utf-8?B?Y21RWEE4aE10OGdIVzJQaFUvWEdveFVIV3RDanpkYWx1Z3RaSlRnbzIvVzl6?=
 =?utf-8?B?VGdCT3d2NHRKNGN1dHN1UXpmdmhWbXBVNndjV1l2a3N5bGJMcEhMZ2o4WjdS?=
 =?utf-8?B?ZFlNRUVVOFhwQ3Z2SytQeWpUOWhxMTlVSTJnSlpCOHo5LzhvN2VsdEI4Zzk3?=
 =?utf-8?B?djkvNEZyWlRhUjcrUjFwNGhVV1FNZ2NWbzZ5elRxYjFhZXp6UjBWWWlaUmNq?=
 =?utf-8?B?NVllcDdEZElCaDJtdHBwQ0w4enBKTW1sSjdhaW96UU9aVzNEeGNCOVBrNW8x?=
 =?utf-8?B?REs0QmFJdllxenBqMmQrbVdWdUlTK0huNTE5MjFpQVZtaGVSTjNYRisxdldN?=
 =?utf-8?B?aEVnbUVpOGtqT0JaU1ZxeEQ3bVpmK1hBalJqUERrd3JUN1ZKV3pxSUhLSVRB?=
 =?utf-8?B?Rkt6M09zK05ubVQ5NFBWTDBFMEQzdGJUZEdzTnZOSG12U2ZsdCttOVZ2SFJi?=
 =?utf-8?B?bWhTRXpvOS9hUHBGRDNDRzJqaUFYeWNyaTVubFlnaDgyVUduVmtLQkZqRVdX?=
 =?utf-8?B?cHh2RUFjbURsSGtReXNPeXk1L0pmUWlJSzhTYzZBNVYwRkVXV2ZWM2Q0OEZS?=
 =?utf-8?B?U1FRQjl3TkxRZ3BGTVRob3FRQ29kTVdsMXhwcitaVy96Z2FQbERyRUkvS1p4?=
 =?utf-8?B?TGsydUQ2Vmllb0pyK256RjdvUWVKYkRSQ3ZlaUJKZVcyMzdpek4xcHp6aEhF?=
 =?utf-8?Q?u8kgABzCgKD3U?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eHdpT2VGZExrenZxUzdNOGdCSVEwQk13T2tzV3RvWGdZdkRFNTlJR29KZnpp?=
 =?utf-8?B?NDZXeEFyUGtPSWpFSm13ZjBiQ2RjNXJrMTMrU3h3UVlvZW1za3ZnVi9NOGJh?=
 =?utf-8?B?U2lEbDZ1bWNiUUs3aUc5L3pzenJ3VVdsZG9OL3M3bkszNHBZTFpITEZYci9a?=
 =?utf-8?B?b25yZ3Eyd1ZkZWJBaUJZakczOGwyRUJ3a0hxU3JPNlJKb3RVUWNVblBtQVVZ?=
 =?utf-8?B?OVllTC9rN0xSOU9VeVRCWGtJcU1kWnBIaC9pQlNRSm43QzFDUklLUWpXbkFp?=
 =?utf-8?B?WDc2bUl4ekZKY1VtTXJXV29CR0Y5S0NTV3pzOUdNVURNTFlZc0J4Q0lTQWxs?=
 =?utf-8?B?cWFkZGhIQ1JYdUlJamRVQWtITDNTcUFsQVdRQXdVME5nZk5hQjJRc2kvNk1L?=
 =?utf-8?B?QXBRdmVpN3Y0cjdScjRZSWVxVXBmdzExemxJZkNNbUc2eGY4SkVaVVkyZFdV?=
 =?utf-8?B?M0hOVEdMKzAybXhDb3hHZmxFU2IveWlxQ0cveVEyUk1Genp1ejlWcWd6aVJC?=
 =?utf-8?B?c25pUmxOc0UvRHFEL0p4WW02dGxFdWVLamxHWjlsVVYwaG5Wbkl0MFRaTXpD?=
 =?utf-8?B?cDFPMFRyV1hXVUJWMXlaalZBYVU0Nk5BMEtIQ3lFakZBNFNKQURnSzhDNWpi?=
 =?utf-8?B?S0lCd2J2S0pyTXppNG9udkthYmwvNy91TVJLTlpCQjl4RnpVaHk3RnFMalBN?=
 =?utf-8?B?SWF3SDhyeWVTbllKVllXcmdiazZVamhTcjZVZ3NIWmhGNnlmMFd1VDFtRElr?=
 =?utf-8?B?M1NmdFEzRld5RFNUUGJudXUrdm1TdXM5eW9QdktQQU5vLzJzZFN0Vm1RYk52?=
 =?utf-8?B?VFJ3OUVkV2ZzRVZHbktWM0ZzbHpIYXdvMGJHTWE2eFpaVmlkVWJQWmlaS012?=
 =?utf-8?B?c1p0M2htb1hQOWNtYnR2M3UyOGJPSUdGR3o5eUJnZHpkbzArM1hlZG1md0hy?=
 =?utf-8?B?U3JuVm12WkdsUnZEK3NlR2tvZ2dZV3hSWjFRak9ud0JBZ2VHUzgzMTg0RTJw?=
 =?utf-8?B?Rm9iZWhtWHZ4S203Wjc0LzJ0OEJlNWdWbzNpQzAzaEJRck5tcDV0eXhVQ2xI?=
 =?utf-8?B?WGhianh1eVdIVHk4c3lhZVpUeFc1aERpK1BhMDUyVFpQVTRlUVFEWG9Ddkpt?=
 =?utf-8?B?VXZ0aXVPeUF2RldpOUE4R21aaFpuTWNEd29JTDBVN1RMMlpCZnVpdk56UjNP?=
 =?utf-8?B?YU10ODJYOENMa1pYMUJON2RPZkJmYlIzNVFKN0hUODVJMkxFOW5rUUUrRmla?=
 =?utf-8?B?Nkhwb1FENEl2aTZWWGJMaThWejBWdlE5b1o0YkxzbVhVUllkZUI3akJ2QUlo?=
 =?utf-8?B?dWN5aUdGMVNJNHNzMHBMQnVaNWNRdzhjU2gwWnA1M1NON2dQTXJaZEw1KzN0?=
 =?utf-8?B?cmJMV21MNHppQmp0eDZyL1VQTHk4QngrSkJoekhHNTlRd3hHdFp4SmszMnUy?=
 =?utf-8?B?OHpSRGN4N2V1VGNqNUJJc1RvUFlCaHdYdzJNRklHd2JHVTJZR1BaVi9JVFBU?=
 =?utf-8?B?SWkvSnBBdWg1VHRPdGUxb2VkVlBiTElyKzJOTjA1R0QwdmZiZlRrb0lGK1Aw?=
 =?utf-8?B?OFBNVVpIQWRsZktPczd2ZHFITGJ6WUlYSnI5Y2VFRG0zWUxDcmxKdDFVVktD?=
 =?utf-8?B?clBHeFYzYWVrZlo2S2gyVTdqR2c0SmpHWm9NSkY5SUUvbzdUNEd6U1Fxcmh6?=
 =?utf-8?B?dlFtTk01aGRseU1YZm9qOGszR040bFBMUVlnaGE4bmM5R29ZSTR3NDliamhr?=
 =?utf-8?B?QVZQZWlNeWhHWlg5bFJqVzE3L3oyNkd4eWpZRlRyb1NIOHFvNUJIMzZoWnQv?=
 =?utf-8?B?VDRoR2FpZW4zcHIvVFJlQm1DQ3JnNGJETFVJaXJmc25Cdkp3cDBxeVplZGY5?=
 =?utf-8?B?Tys0c2UzMVdRMHB0cGxWMGl1aS9LOVQzRXNWbSt4TjR0NlZyeG1ERU5DNlpm?=
 =?utf-8?B?YitLSzArK1k0dWE4TkdvdWRyMzl5K0hRR1VPUFYxZHAxS3BKZzVMSDhsLzRC?=
 =?utf-8?B?NUhvYW96SDFnQlFsOURZUHdxYUF2OHVtOFE1NmtNVnlXVVprQXo5L1IybmNS?=
 =?utf-8?B?aGZTNFd0THc2MHg5bzFkSVV3QnpsRmlXamZ6NTE4MGNKVmdlVkxXc0FUV3Q2?=
 =?utf-8?B?K2x2WFp6WVNSV3VQcjQzVVdVVjgwTFN0bFJ0bWZrSVllUDZ4d0pTRWFLZHZs?=
 =?utf-8?B?OWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	MhyM17l8udq1uDsfiRtWh7L5earrIvwbWYA86gEiBiB8TFJVEDJi5L7Fw6VOnfNxgeYzPnR7iEQeE+G1VG2yONQfnWxXXuhXoC8l3C39cNF2YkYJJfK8YgWrUvWnkcrknZ7C11mzgYmhlMuA0jxE9Nbw3PhR48wwntwoXuQwJSpWa57oPBqyYcMCqTeUKDMBZBW7QApy0VbaYxk9y6yfVqzOTg/4xCTQrnf0ia8DpWicKdKpFSQzYNDfwXuKw63P+TsjrZu2/UJPpc3sL90M0bHbSbS2zVUSutN5b5p8PeiF9lJ9jRKOkHe9RXoT6CxCU8Yox7/9HfDQoISe8oj+PJOW3DTt97Nl49ZDmZjbW2RDZw4kUrONx/DEv8eGY0M17VWjezOiaLuJ9p7A9dWDN84syNr/AY8P8RZrVvQRHpADNgJDuJkeoKAE91CLhv/4/d94YU/G+U17u/cHKVLU2hvRkmYdWhwIlfBwCG55SZaYf5nMKwsQFOtj6PMyFFznF3+CtJMe/9HdX4p2X49MBKTE17tTS7q+f+XweTaPApDjZIZngTnh0JdVJAYxI4NZ/fiPmpBJFWoVLbXyLNcpb/12oEeGmD7/jJaj5CTejF0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6690a2f9-4727-4535-9f28-08dd65f8d7b9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 08:42:40.4387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hi4QiZ4uFcXp2n8lE2ulrXUbzZaY3I/aG7yerwFYXh0eWnVtXhMXV7bIp6tBYrR2wqgWaY75Kbiyvb8idemrcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7191
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-18_04,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 malwarescore=0 adultscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503180061
X-Proofpoint-GUID: aCfnWmrNgizmDxNNsGfp2oWGH3shj-Fc
X-Proofpoint-ORIG-GUID: aCfnWmrNgizmDxNNsGfp2oWGH3shj-Fc

On 18/03/2025 05:43, Christoph Hellwig wrote:
> On Mon, Mar 17, 2025 at 09:36:13AM +0000, John Garry wrote:
>>> It is only preferred if actually supported by the underlying hardware.
>>> If it isn't it really shouldn't even be tried, as that is just a waste
>>> of cycles.
>>
>> We should not even call this function if atomics are not supported by HW -
>> please see IOCB_ATOMIC checks in xfs_file_write_iter(). So maybe I will
>> mention that the caller must ensure atomics are supported for the write
>> size.
> 
> I see that this is what's done in the current series now.  But that feels
> very wrong.  Why do you want to deprive the user of this nice and useful
> code if they don't have the right hardware? 

I don't think it's fair to say that we deprive the user - so far we just 
don't and nobody has asked for atomics without HW support.

> Why do we limit us to the
> hardware supported size when we support more in software? 

As I see, HW offload gives fast and predictable performance.

The COW method is just a (slow) fallback is when HW offload is not possible.

If we want to allow the user to avail of atomics greater than the 
mounted bdev, then we should have a method to tell the user of the 
optimised threshold. They could read the bdev atomic limits and infer 
this, but that is not a good user experience.

> How do you
> force test the software code if you require the hardware support?
> 
>>>> +	trace_xfs_file_direct_write(iocb, from);
>>>> +	ret = iomap_dio_rw(iocb, from, dops, &xfs_dio_write_ops,
>>>> +			dio_flags, NULL, 0);
>>>
>>> The normal direct I/O path downgrades the iolock to shared before
>>> doing the I/O here.  Why isn't that done here?
>>
>> OK, I can do that. But we still require exclusive lock always for the
>> CoW-based method.
> 
> If you can do away with the lock that's great and useful to get good
> performance.  But if not at least document why this is different from
> others.  Similarly if the COW path needs an exclusive lock document why
> in the code.

ok, I'll do that.

> 
> 
>>
>>>
>>>> +	if (ret == -EAGAIN && !(iocb->ki_flags & IOCB_NOWAIT) &&
>>>> +	    dops == &xfs_direct_write_iomap_ops) {
>>>
>>> This should probably explain the unusual use of EGAIN.  Although I
>>> still feel that picking a different error code for the fallback would
>>> be much more maintainable.
>>
>> I could try another error code - can you suggest one? Is it going to be
>> something unrelated to storage stack, like EREMOTEIO?
> 
> Yes, the funky networking codes tends to be good candidates.  E.g.
> ENOPROTOOPT for something that sounds at least vaguely related.

ok

> 
>>>> +
>>>> +	if (iocb->ki_flags & IOCB_ATOMIC)
>>>> +		return xfs_file_dio_write_atomic(ip, iocb, from);
>>>> +
>>>
>>> Either keep space between all the conditional calls or none.  I doubt
>>> just stick to the existing style.
>>
>> Sure
> 
> FYI, that I doubt should have been in doubt.  I was just so happy to
> finally get the mail out after a flakey connection on the train.
> 

thanks


