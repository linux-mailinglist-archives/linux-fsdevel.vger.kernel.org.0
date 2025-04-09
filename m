Return-Path: <linux-fsdevel+bounces-46049-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1940A81F88
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 10:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FE673B1467
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 08:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B631025C6E2;
	Wed,  9 Apr 2025 08:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cv4DsvyL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="sXVPtMA/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93FD17A2E7;
	Wed,  9 Apr 2025 08:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744186583; cv=fail; b=ui07n8LWb4Ko/iXvcKKrSgjOx/VOaxQLQB0+mBTQeoDyOXzQ6fu7wD2mjQSS2a9SENjdDd4m0+U/I67mttSkwfg6EzcUrXBQnDg+ROishceQP0DFVfZR1T0mYv8W+5+38jgzvmyGLXdfFpbQ6mnOYXadN/2kT/O262nawAMxrBc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744186583; c=relaxed/simple;
	bh=UlU7s3P2l0/EgqikRXatxXS9If0IyMGh3CxysjCz0ZQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DwPnndYFojgio/kf29hIye1oKkg/P58QvrXaIyHOBEg9aSleHBTme9RPJyTvHhPmfFX3Jblx3HqL3jaqVmP1HfjhbHCpxhcx4tbfWGOPWKHsQZX8xmvad/GKoSg5PV3TfJemBJiexfmlsINStz7Pj5jXSdVLgYOMym072KeZpw8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cv4DsvyL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=sXVPtMA/; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5397u08t010896;
	Wed, 9 Apr 2025 08:15:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=zDiSo1BfRpIq/FItdN/5Dis/0byiof014Vf5Ap73G8U=; b=
	cv4DsvyLI9pbchTaafaRfQfMmxq31wjAWwyA4RmckXLnnCWJRY1088JsHYFvA5bm
	5Hf1gTRY7Gz8+FOVjVPeQyF0uswBMK+07afx2TKFer61jHdWCx65qZM8RrrBxkPu
	MDPcsLQzXmkks0lMnG3gCMhUpxisBlPCkPwLUQKZ4isqA9ObPwOolAoqTX760OEQ
	npy3/oHRfedNhhjk3OrhJAvgQH9Tq5F5ACK4MYIzcxGP9WY+/Bl3d4HEU4RhSs6V
	r1kvMhHaZf+I2TJNpWZPTnnotvLdzPuficUY+FfE1+5zdAG7Vrq0nbvUJIKW4ET7
	FtTgQpq4its7YKA0WT7CGA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45tu41ejh4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Apr 2025 08:15:30 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5398DBcm002089;
	Wed, 9 Apr 2025 08:15:29 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2042.outbound.protection.outlook.com [104.47.58.42])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45ttyag49u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Apr 2025 08:15:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MxUuh7QA4aiWtzmExqtL/SqwClJMj5alpA4MOy/HXffwvR+bUq2aRf5kRW/TIp67Oa2zkgOS4aI2dQeVUJCF3nJvah/WlNeK2L5KRC7aQZmE/yojfwrcEWYir3HcRW/fcVwnQ1Mrg3AeIJ3Ph3/wFclLvuawbZQUgh2A+hIG6np4vaKpYku073K1Y7THdPJujjnWI3qJicU+t107VNYl004LazWVuMF7aT1G9FkgoNSBgXcdW6zt10MvvHWrt03pTG8F28DaeiwiXxCCqCsy5OvfVk+aMrAlytnsxJsgIGcEAGb8jKHi5L1U+YNGSuhEOC8mAipntMZq1NSXxUs11g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zDiSo1BfRpIq/FItdN/5Dis/0byiof014Vf5Ap73G8U=;
 b=SM1FRCflAdUpcTucrvfpxWvxrJBMCPI/ixEPAmKamBrfcrRIqbPHz03iLPpT+8d0dVImBAjDHVDveucFDGahEaStrHaoHqJJYTA8fBtYD3WqJVSCEdgsnwQT0kL2GnvH/X0cJ2dGJcgaYDmjmnTlA1EIR0IewaKCOi082cvCAkqhgip63BWXw2OzAJaMEcmvsmMPx48qSBJ2RETl8MoH6gZHHE8gLRfyG2WqcvsRNw8dYTyBn22oWRm/yj0ZRRP9TQAv667pJpaJFzYLJazHioPs69QB76xt5SlVc/SOg20CUy4TCEEVJfsO5fdE53x4DH7GQ6xKxV5jTg0KuloKWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zDiSo1BfRpIq/FItdN/5Dis/0byiof014Vf5Ap73G8U=;
 b=sXVPtMA/XT6I7f7S8wIIJspJj8lYLLWVMBiERw/BFmZCGNEIju+c3iCbhA2UJ2NlLcPS6rYji+bk/+lpjhE+zYLOMTUpp57iNnl84DmW7edH55QuYFUjWSLPXqHDCAEYEflKVg+qJKFediOM8Fk8NRIaWEiU7BpVmvuSZMyOOZg=
Received: from MN2PR10MB4318.namprd10.prod.outlook.com (2603:10b6:208:1d8::20)
 by IA4PR10MB8611.namprd10.prod.outlook.com (2603:10b6:208:564::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.21; Wed, 9 Apr
 2025 08:15:27 +0000
Received: from MN2PR10MB4318.namprd10.prod.outlook.com
 ([fe80::e563:43f1:4b02:5835]) by MN2PR10MB4318.namprd10.prod.outlook.com
 ([fe80::e563:43f1:4b02:5835%4]) with mapi id 15.20.8606.029; Wed, 9 Apr 2025
 08:15:27 +0000
Message-ID: <ed53dc33-c811-4c20-8713-8d2d32cb81d7@oracle.com>
Date: Wed, 9 Apr 2025 09:15:23 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 11/12] xfs: add xfs_compute_atomic_write_unit_max()
To: Dave Chinner <david@fromorbit.com>, "Darrick J. Wong" <djwong@kernel.org>
Cc: brauner@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk, jack@suse.cz,
        cem@kernel.org, linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com
References: <20250408104209.1852036-1-john.g.garry@oracle.com>
 <20250408104209.1852036-12-john.g.garry@oracle.com>
 <Z_WnbfRhKR6RQsSA@dread.disaster.area>
 <20250409004156.GL6307@frogsfrogsfrogs>
 <Z_YF9HpdbkJDLeuR@dread.disaster.area>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <Z_YF9HpdbkJDLeuR@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0077.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8::17) To MN2PR10MB4318.namprd10.prod.outlook.com
 (2603:10b6:208:1d8::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4318:EE_|IA4PR10MB8611:EE_
X-MS-Office365-Filtering-Correlation-Id: 58184ff5-5476-4e52-67a4-08dd773eaef6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZWdMTnVTYmJjSkFmd090V3g1b2pXeXJ0cThjemNhbTlLMGkwb09aUFBvSkQy?=
 =?utf-8?B?cnF2WTlWVDFkMElSRlBhMm5ZTk1wTzNqRmV5UGc1S2RjbHhJTndXRlkzZUFp?=
 =?utf-8?B?SStlRWFxSkp2bkNpN09TNkRXMk11TVl3aFZ3bWJEQklkK2xVU2RUa013N2ZK?=
 =?utf-8?B?RWNCVXFtMnhCVVlOQWpGWE80LzVUZ0FqMzQ1anlteGJ5T2tHWXE2SXVpb2hl?=
 =?utf-8?B?K2JhVngzVzVrNUJ1QjlUZWNzV0QzcXV0UVFvekRCZERTb1Z2RHVrTThTdkN6?=
 =?utf-8?B?WlBWZ1NhU3ZVWGhYd1VZQWhGRXpOV1JSaXZ1cTV2U1dBOXhMenZ0OEJVcmdV?=
 =?utf-8?B?cWtYYVZaR0ZCSnV3OVlGaXF3V3BiUnEyQkthSE50eFBSaUNjMzg3NXp5Q3lG?=
 =?utf-8?B?dDJhVUVFeXpjWjliUDRtY1lJUHVoTEhhdldNT2ZwdkxHL05UcXRsY1lycDdz?=
 =?utf-8?B?NUN1dVR1bVZQdmx4eHI3MlE0OXhzRW5IYnNJd2p5bmJZNWtHbjV6bnovNG00?=
 =?utf-8?B?ZFArL0oyYTQ1dEVnaHNZTG9qUWJnRWhIYXN2a2QzeDRKYXdiclhVSkxEeWRk?=
 =?utf-8?B?WGFmTGVBOW95NWFDNE5hM3VWUnowTFU5MWRQMExZdllUUVZsME91ODE3OVVn?=
 =?utf-8?B?bzFvQjNYVnkvVzlFR0VnUEdNY3JCKzV1QTJKaUtpUGlBeTllSFM1QldaTUw1?=
 =?utf-8?B?bko2Z25uc29OcTVpSVhpLzlVanJCcjNETGtQN2xsRVlRaElHSGttZUMvT2Fx?=
 =?utf-8?B?aks4OFB4SEhOc3M0MlVWKzAxUmRsUDdlQlc4eHNLOGpRR2hTTjFWcENJN2hB?=
 =?utf-8?B?R2VDaUszSXQ2Q1RRNjlPMkYzMjRSVmRaMzBZVkdpYklNWThqT1FITzNvZ0Nw?=
 =?utf-8?B?UHYweWdaLzRtOVp6M1JJd0pJbjNLK2VGaEN2R0p1U3M3dDZ3Z293c0I5RnJ3?=
 =?utf-8?B?QkV6RUtJM3AzaitheVplaFp5QTEvRjlOdGFmekY4eTdHRWJtV2hiZFEzdUYy?=
 =?utf-8?B?NndNbG8rNVlib0FrbXNiRGpCcDJaRnl6bUVXemVMQVl2RnVpbEprWHYvN1lr?=
 =?utf-8?B?TWhsV0NpbmQzYmtWeTBZeEdtVmpMN013eVNHQzgyVHRPMTlYSXVRTU9CL2Uw?=
 =?utf-8?B?YWliNThLWFBrTkp2NWR5U3g5Nm9zNkpQK1BaRm01TTB3a1c0N01NUncrSFZH?=
 =?utf-8?B?aFZTQXZjaDQ5NmNMTjNwSDZWUnpKOWNZY1JoZVFDcVYxeXFVSG9Ya3V1U0tw?=
 =?utf-8?B?NThHVzFyL1Fsc1NRWFRLdzExTUlYUlhwcXZNak0rM2FHQ3R4LzcwK0dUMVor?=
 =?utf-8?B?T1YvOWROMWNTSmFTSTZaNnFnWm9kSlBrMnpHQ2R2clVYTGsybjBPU3diaGNV?=
 =?utf-8?B?OE0vUHNkUGxwV1ArZ1NoUjVPd3IvZkpUSVZ6YjZycEs3NVQzTVkrb2FvTUov?=
 =?utf-8?B?T2tweWgydzR6dzY2ZUxOUWpZOGlnbGVqMXp2YnlwQ1hKV2twL1MrcWJoUWo4?=
 =?utf-8?B?REtPdThYTlVGYWpId05MaUcra2I1V1RicGtLNHQ2Zk9wbXlTUHl6SjVkTlI4?=
 =?utf-8?B?Q0Y5cDR1TW1LLzFzMG9nTDRCdGtRNTVVYVpQL0dRWUExSFpkVnlIMlBiYXBz?=
 =?utf-8?B?ZS9UREk1WHJFNTBxMTNuTG41VVRScWowYTJkc3NJWktjQU1sQUZqME8yZVdW?=
 =?utf-8?B?b3BWVmsxeUVYT3hHVm5NbkhMeVk0NmtUYkw5RnQxR1F5VUM3NEhjUTVkYm9n?=
 =?utf-8?B?NTkxNzhJcU84dFZrLzVxU1BrY0VZRkZ0b20xdzc2V0pITks3dmtLVnNucVZz?=
 =?utf-8?B?dXdyemVSejB3ajNSZGJIQ3Vib0xYQkpkanBSVXBwTXMzWWJqR0Q5TWdqTEFE?=
 =?utf-8?Q?m8yRJo/xoBSpO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4318.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MkVtWkw3RGlRQ1F0VEl0Y3A2RVk3cEs4cmJpT05LdXRvci9Fbis3RGZac0x4?=
 =?utf-8?B?TDFOaG5lQVhPQmQ5STF5aGJnN1A2SmRQY3MzeU9nczBDeUNNdGR3UWJBRlpl?=
 =?utf-8?B?SzQ5UDhTTFNkZXZ4clhNcnpwRmE0QlpwTWRtNWxFZThNZ2ZrSjU5R3ZEMFFp?=
 =?utf-8?B?YXlwS0ljb2VZNEdKandRdFFaak9Sa3lySUhXLy9SSURhTndlc1Q5R3ZEcE9B?=
 =?utf-8?B?Y0gwQ3Qzam8xRUxBa0dQb1ZpbkVRaFhDVXkyLzB1d3A5eEowNTJBQXRLRHI1?=
 =?utf-8?B?VWx1bVlDSVRxYlJ3NDUxeWxOQnpPSXZGWmZxRkRYQzBNY0hzMDl0RmtpUTZY?=
 =?utf-8?B?NE44UFVZQW5CS0F0blpMeUkzTjZIOVFranhHcmZPb1JlWUIzcklNQmNVaHE1?=
 =?utf-8?B?eXR0YVRHaXhHYmg1N2ZZcHNtR3lZSkRCVEhZYlcwUWVDL08wRVBrdHNpSW54?=
 =?utf-8?B?ekRtU2RHdU15YVM4UkZVemZPK0gzejVCS2ZNZngrSDM0cjdYSDdkSHpmNEk2?=
 =?utf-8?B?RUJTaUZaZU9pSTRRdlh6T1hQOWs3NXYxNWFPMlc0WnhTaWJCK2ZUS05PdC9L?=
 =?utf-8?B?cUg4bzNqODlITUJIWFozeFA5VGtXWkJWUGNlMGUzMmw0cFVFaW9maU41Qkh5?=
 =?utf-8?B?TFpOT09GbUR1bU5kUlNyQ0Y0Q2ZZTVl4TmE3NGRlTkw3R1lPLyt6eGxOSmht?=
 =?utf-8?B?SUZHL0N0b0lUZ0Qvc3NBeFgxUDNaOERBZFhkbEYvemxYS20xUm0yR1dUNDlF?=
 =?utf-8?B?OHUrWHFnUitWZG1KQ0FyQ1VTVjh3TG9wUmJUOFNpNUdZbDZVZkQwZkV0bkZC?=
 =?utf-8?B?aU9wUmx1WElXbmwxYnRRUGpUTnFrUlBPbFNEMm1IbHZnUVo5TTlsaWJHbHV1?=
 =?utf-8?B?UlRtWmVzRjYwbGZzaWp3eUJpb0J5TitxMEhvbzFZbGVRcWJNOFRJU01zb05H?=
 =?utf-8?B?SUJHcU9PYVhSK25vT0RQdWN1TG5TMThCSTVyT0dLd29hWmZaOG5McURVcTlF?=
 =?utf-8?B?bUVPbXNPeExLVytyRVRRdmxtSzQ0YWVYbmtTSFpRUVdkZlNobzhGT0xRUFJr?=
 =?utf-8?B?ZVNqTFlRY1ZJQzh5a2FHNDV4SHdMdUpuZkZvbEpqUmhVNnNKeFZSV2pFTUZ5?=
 =?utf-8?B?Yjd5SmVhY1pzd1hFQkRscGdxVHFxNURsdExOM1pWTGJjbTg5ZlhJM2FVb3pL?=
 =?utf-8?B?UzRUeVVzRSttdGNVR29uOW44OTU3Mjl6blIxeGRKcUdKb2cwRDQzOThxSmhP?=
 =?utf-8?B?a0cvaUxDRWM2Vm51YklsN2JsUjBtVlZpd0xKaFdzNE1OYlNYdFJFNXU1d1Rm?=
 =?utf-8?B?WnFBM1E0UnF0NG1lVDMzMy9aZWF6NjJxaGtVL2l5cC8yT2hvN1BiU1JLQy9L?=
 =?utf-8?B?SkNzRmNmeUw3bkc3MnkwL3hVWHZjN3NVVVpITEc0UmZlZ1VTRFhtTWl3aEd5?=
 =?utf-8?B?b2JneUZwWXZHUmZ3S1dRdmoyVktIUnFVTDdHVjBFRWpDeVNGREhuY2pJWlJy?=
 =?utf-8?B?WWVHQU9DL05KY2tXV0cyOGlOdWJNTnRBK3VSY1ppNUZGWmVvZytOQWNSZlJa?=
 =?utf-8?B?VS90elNnV0ZVVXV6aEdqTUZIRVlUM09uTndBYmtxc1pzaGNuNVprR00vOHRv?=
 =?utf-8?B?eFRXRHRtdGtIbkNINjhTOVkxZmdaTlZEejhpYmpvWEJMb2p1SDdZTVRld0ZS?=
 =?utf-8?B?YXJiQ1kzaXV4OWNWQUNSWUhqNXBLTU1qaDhUcHZaZGZtek84WXpZUExrZG5r?=
 =?utf-8?B?dFRScWNFdmFBZmZZSUlUOUFFVmlNMzljdzhzWHhsTUN5SnBaaW01R09hUlV6?=
 =?utf-8?B?dHZTd0VaZUFEVmRUZjkwTkxacW9NelprUkxLQjBEN09BSUhqM3dXSVRTeXFv?=
 =?utf-8?B?N3JTNDFTSWdIUEU5QXRlSXVFQ2pMeGZZWitHeHVKeXlsRUZSUmFCbFlmc1Vn?=
 =?utf-8?B?TjUvQnFoV2ZINk1jc2U1QzhQVU01MDdMOC9WaWhwd1hob2U4T1JjVGJRa3k0?=
 =?utf-8?B?cks5Y0t3QVR1aTVHNmMwVGVGdHpKSGVmUlNKTmd5MHRhUnhNMm5RK3N2TXpx?=
 =?utf-8?B?b0dncEZZWkdhbmZIVGllVkV6bUlVM0pMY0t2cmtuVFgvZndCTVMxRkE1cVFQ?=
 =?utf-8?B?OVgvRS9QK2w3cVRRckgxZEczNlYrMDY5NS9rejlCcCtRMldOWk9WVkFtcVQr?=
 =?utf-8?B?V2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Ug5LIeotCJpP1TSPjE+87Ij9vF4DeBXBo4Kt91i7ImxzX1zX3aEG6Va7YGhcV4jtY78zT7YxMfx13k6rP9Qjareh5eb2Mr+CLZDL6HfYy+WJCY5/13h7mVoLoYc+zPjHRJ2eRGW9nfbzl2ggHNDEBmZjZ6Q1qc716F6E6d67CFaBcbjY01cWIqlPwInsC9xLwXjuHeIATgRsFBxr/b/DPrPEdQRSNSqLedeXByI6KBwW8UI4wazP4x0+krXs9GeERvH1va2t2rdZ3/VUv5xSO22DgqY6f6hZpsioZ2MfTo8w/nbvVQuWdN2SOd7sEs7rnuFyMiyQTlsx6trSIyOhUAQm1XOBUbS7RHpSIvvL+2znml8nWEgMBHxiwwbaMtSpATs2XNE5t6yEUNpKErpbkxEdCgixjZ7gFIg6aMOmwMBvYz7mmX8XPIVxhV4DgSo0p9vroYhShcybQW/R9xO+/8ytzSdBHy9wq5DqqV9rxOEGTTvPWhOTe/lVyFmUsh3HFAocK9TQPfHsqKtpnMYXreUr7KBCLSSNcNYx0cIatgc5SOuL7EG1NAW80F6X3tcJ49bfGMiKYj5yXDcH1AaZfjj3yoooK4WOW4uKYJpxRVU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58184ff5-5476-4e52-67a4-08dd773eaef6
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4318.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 08:15:26.9874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lrm+Ky9fp2jcAtwvrOUb3K8o9gs/NMOknP05Hp2BAh9+9j/gU2vvrWBQYSZ5H4+C/gEOSPrsZeTqpysR+exELA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8611
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-09_02,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 bulkscore=0 mlxscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504090039
X-Proofpoint-ORIG-GUID: zqV-ISZ5i5yosb4JjZ9BXjfF_rdgsJod
X-Proofpoint-GUID: zqV-ISZ5i5yosb4JjZ9BXjfF_rdgsJod

On 09/04/2025 06:30, Dave Chinner wrote:
>> This is why I don't agree with adding a static 16MB limit -- we clearly
>> don't need it to emulate current hardware, which can commit up to 64k
>> atomically.  Future hardware can increase that by 64x and we'll still be
>> ok with using the existing tr_write transaction type.
>>
>> By contrast, adding a 16MB limit would result in a much larger minimum
>> log size.  If we add that to struct xfs_trans_resv for all filesystems
>> then we run the risk of some ancient filesystem with a 12M log failing
>> suddenly failing to mount on a new kernel.
>>
>> I don't see the point.
> You've got stuck on ithe example size of 16MB I gave, not
> the actual reason I gave that example.

You did provide a relatively large value in 16MB. When I say relative, I 
mean relative to what can be achieved with HW offload today.

The target user we see for this feature is DBs, and they want to do 
writes in the 16/32/64KB size range. Indeed, these are the sort of sizes 
we see supported in terms of disk atomic write support today.

Furthermore, they (DBs) want fast and predictable performance which HW 
offload provides. They do not want to use a slow software-based 
solution. Such a software-based solution will always be slower, as we 
need to deal with block alloc/de-alloc and extent remapping for every write.

So are there people who really want very large atomic write support and 
will tolerate slow performance, i.e. slower than what can be achieved 
with double-write buffer or some other application logging?

Thanks,
John

