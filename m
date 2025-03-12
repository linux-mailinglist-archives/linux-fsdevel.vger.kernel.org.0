Return-Path: <linux-fsdevel+bounces-43846-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D9FA5E700
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 23:06:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6D363BAF99
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 22:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5359D1EF0B6;
	Wed, 12 Mar 2025 22:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gQAs4tIf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IUnNaPyq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FC0800;
	Wed, 12 Mar 2025 22:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741817188; cv=fail; b=owAB30VQ8Ov5EKTxtAmtJskM0tfAy4VkwJQyNVCV98BBLPdlsUdObAfMxv+58495L5zcRK2m2dlenVwBxrh/fNIt666hTfILAODwbDC5x7Aq8TQb0qp47sPT99VLATQV5WJ1cvp26XSJKFIw8/r9mdI+8dYDC9upaKKKMn2vzYM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741817188; c=relaxed/simple;
	bh=mClz7QF3eNg6b9PQV0DA54R9epBjN17HWAxAaGyqrn8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DhO5wP6zaIzKwhCpHNKxuOPxmquqAU4+bHyarlZb131MoT/7P5BZeSINlvZ36HQuqbTZZudcrbnLXpEZ2glnSRLSOZzqJq8CsDpS74k0clfL1JnnbDubKPq/+4N7vZ0vODdgL5b+4xZY54aOpxqwK/5t0vbChfK9vAHtb4t5R2o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gQAs4tIf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=IUnNaPyq; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52CItmVP002703;
	Wed, 12 Mar 2025 22:06:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=9RknU2zVpyIZyNtJysDc3ZdHPypuvcx1vpWopRtB1uA=; b=
	gQAs4tIf9VuzOE9Z1d3Xd3LA5gkZmG16unxhho0yPAWndZHZSyO0fquP1fzNg1m5
	NhB48FSbfyHbB/JXvKFB+2biZckBB7dTz3sluvm33p7LPhnwXQ/j9TZ0iDV5EEB/
	J0z8m3jzrVGDpDpYnnQ2XClMEvpXirGLzu6QbZkxoEGETSQymUJIxYXxisOoLSZV
	Z7jJWP0q3dWXJ56TT9d/wd2AW1yRlmke5MZYjxfjR/pSHeEMPZ5LWZI4Ql5fVHp4
	vaCFkhrMADk8ZnXMCOAWH+HasoEMLdy5yhA0qAmtLc/Z4Pzxkntb/mxFFaaDYJSp
	fJJfuIklLSwQdFlKkIl3uw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45au6vjx9k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Mar 2025 22:06:19 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52CLdq3l008683;
	Wed, 12 Mar 2025 22:06:18 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45atn3w0tf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Mar 2025 22:06:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IBieTiEOZJ1D9CZzw4r8DNCU3aG1yXPrShEkx8jOKfc1GXrkb/wNV6T1q4YBGLKi25jN7xbnnsslfzCUzpMu4IsT22wcPg603DhLscnTNnTZVplYqswp/Q8uPLmEIgY/XQ7AddmhfJZGhstxu/xWu2ljDJNND1NVI0ZYlN6ezfIM/77k9SW35NPlKOMDIq+J2PnvdbHE7+bjGziMQopraR7S+Kd+kNSsE7uJ9cj3nk7FN7HHq1D/yJ+YrArPfkK4uFlnXujfgL4Z9eunrlMGt1IWWxHnaHzXzDTffn0gl39/Xx1u7ak8hYztM+hG9YcarBzEX8UAtIWW32/BUO1QCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9RknU2zVpyIZyNtJysDc3ZdHPypuvcx1vpWopRtB1uA=;
 b=ocKz70KEIqEK34scz451pEC+3PByKKdgcq7IlYPcAvyXnwNe629mRK8acrIvbqWk/qpDvGNPk0oRziT0l6ShHqX/yZpAnc0uM6KpY/qGGdKtWC9SDm2C8cxxTRa0RnIfYDmXLJn82Wzwq0g3aNIH4PyjnI6VVAN0qZcCvaSfw8JEvwQAMl+5qtyXjS5gF1w1FBb8MZaBTKizERRe2wsHfTuSbykZGlNgPdbwySdr/FayH3J9NjoRpX+cOXpfP9uImpoBncwEWCN/QxUJKYE4xFWa4ylLT8l+AhpQ6Ps4boRQXRjtANBOAaXzO2tA4pWIYibMjA/FCTLWZ80MU3SpUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9RknU2zVpyIZyNtJysDc3ZdHPypuvcx1vpWopRtB1uA=;
 b=IUnNaPyqD4t1PIZgZW3qSZIb564IEdKsVUg478pHESuCAMFC5Pw4XQn2Bl91rznay+Ck8SAeuBW+14LZK+1DX3zqXY5NDbQconb4tTHniKgUL7ZlJgsae6HrTGtSOraG32wGcI5YNU1Xmgp5gWciowyS78UjCLb8Qr+hzt2tnx0=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by BLAPR10MB4945.namprd10.prod.outlook.com (2603:10b6:208:324::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Wed, 12 Mar
 2025 22:06:15 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 22:06:15 +0000
Message-ID: <62f035a9-05e7-40fc-ae05-3d21255d89f4@oracle.com>
Date: Wed, 12 Mar 2025 22:06:11 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 03/10] xfs: Refactor xfs_reflink_end_cow_extent()
To: "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>
Cc: brauner@kernel.org, cem@kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com
References: <20250310183946.932054-1-john.g.garry@oracle.com>
 <20250310183946.932054-4-john.g.garry@oracle.com>
 <Z9E2kSQs-wL2a074@infradead.org>
 <589f2ce0-2fd8-47f6-bbd3-28705e306b68@oracle.com>
 <Z9FHSyZ7miJL7ZQM@infradead.org> <20250312154636.GX2803749@frogsfrogsfrogs>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250312154636.GX2803749@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0162.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9::30) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|BLAPR10MB4945:EE_
X-MS-Office365-Filtering-Correlation-Id: 15ed99bf-01a7-493e-b63e-08dd61b21b62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d0hkanVlak1DY1dORVVKaVJ6YkQyVG84bTlRc0ltK0wvQVlIQWZaTU1yeVpu?=
 =?utf-8?B?MmJxd2dGcFcvSlJPWEF0clBudVdUNnNuY3NhaEk2T0RUaTFtdllpbzJOUVVn?=
 =?utf-8?B?UmhEZUpwN3ZFdkZVQ2Vrem11a3VWRkFGRHlrTjBiZGFnMWU3cHA5WVZFNXZx?=
 =?utf-8?B?dWdoZnlCdlFoWkFnMTM0MlM0OXJ1MDdTREZueVZNNnFhSEdFZ2w0anB0cmpn?=
 =?utf-8?B?N2pyN1k5ZnprcWlaZWdId1FQaWtzU1lrTnBvcEVwODVSOFMvR29oSS90Tk1y?=
 =?utf-8?B?bVczV3pabEtoVVdOdVlkdVYzTjNxTnhtSmU1eGtKR3VzTXdOZ1kwWU93UUY4?=
 =?utf-8?B?VWRuekRHV2gyN0tlT255QXVrTWRLY0RCUnJoeFhmTzJoSkFQeU00WmdDK2No?=
 =?utf-8?B?RzgvdXNzeHRsZVJqbnRscUJrMGM3ZEpGNytvMUc4RnpUZ054bi9NWXhDL2t4?=
 =?utf-8?B?SHUvQ0dTZmJFYjVsbWUzY3VhQU9MUTlQdytxRkdicjF1RUNkN2ZEN0lXd09z?=
 =?utf-8?B?c1FkMGxvWHFoRDY1NUpDUzRXVDB3RnVnNGQ4VnRkQXNXV0hZUHpYMGd3N2RE?=
 =?utf-8?B?YWVWSGxVeFg3TlFiUE94RXl1VXdpM0RoR29PaE5IMFBuT0p1RTN3OHlseUJv?=
 =?utf-8?B?WkE0enpRVkJ5TDhIdzNWOEdKNkV1em15eGxjUnVlVnB4YTQrTmREeDVOV3ps?=
 =?utf-8?B?UEpKNDdnZjFhalVZbjhhSHFiNWo2cDJuVGlYdjRmNHlCZHROWHhxTFR0YzR0?=
 =?utf-8?B?ZWZFWTdRYlkxeXZVMndYWDIwMG50MS9ycUkyaEIxbHg5dUdnZ0RCNDlTZGdk?=
 =?utf-8?B?UnpML3VvM05yR2JTb3FVZEpBNkZoMFBLVk5mTHdKNGdPMDZEUFNHL0dlNTA0?=
 =?utf-8?B?VU1nd245dmttbjNxWWRxN3JoSUFhNDRwd0pEZFN1ZzhiNTlPemxvOHNOZ3hG?=
 =?utf-8?B?NnlGRFJHNytKWE8yOE52Z2JzbmxlVUZJRmdvNXNWbFdaNmZUZGNxQ0YreHZ5?=
 =?utf-8?B?K1dHWHJucHJzV0lXQmV0SHZNMlcyTmdGcWxpOVlqV3RqVFlvOWtyUnRDTDQv?=
 =?utf-8?B?anNBc0Vzb2NzSGZKNmNtVlBJMkVCb2xZcmFyUHdmVjdUUEhKZ1EzNDZuVmMr?=
 =?utf-8?B?YStYeEs0di9mM3hmeXJoWDlyQjgreW5PVTNLTm9NTXNYdVZPR3R1U3dmeGtr?=
 =?utf-8?B?Nk9oem91SVZmQnJNak12UUxCMjVmTWVEbnAzME5ydW9RNWR2Q01GK2J1Nm5D?=
 =?utf-8?B?c1M2NWNTWC96dnMvM01PZkFKZTdsWlBRQnp2NU9PbElHQ0c0VzFVL05FMEZk?=
 =?utf-8?B?MldqL3Qwam1EWWwwVVBYTk81Yk4rM2lwL0FrMlY5WEcxcmZWaGQxa3pHVktj?=
 =?utf-8?B?dUVaNUVoYm44V3BDMm1GTng1MFl6MHJWa0RYSEhjQjlySmRHazhoYVhJYjhs?=
 =?utf-8?B?QitiV2MzY2g1NkZWc1pqSkRtTTZteWhhYWkrcEhQMjJDeEt4bW9GWE9WRVVa?=
 =?utf-8?B?Q3J0UUlnSDhNQkJYRjVMRzhRTWk2T2RwSEd5ZTkzaDdEUnVVR3liMkRMc2Rh?=
 =?utf-8?B?dzRPTm93YUxBbFluMlozejdCRUQyc3h1RW1mWjNhMzBxbWpjbFM5V1VKbUY2?=
 =?utf-8?B?S0tPZEg1WTlLSnNMaWtBQ2hkLzVHcVB0bDRYdEZMMVFSSk9VRXBtbWFiWXhP?=
 =?utf-8?B?WW9sUWZVMVpSTTB2cmZPaG1WalBldktqM1dtcHdrTDdTenZhYWg3YktKSzY2?=
 =?utf-8?B?L0psUG5mOUUvZktodjJWcTRERFl4aDl2d3VoS09XL0dvUzdwQUZtaVFUQkFw?=
 =?utf-8?B?N3dRRm5pc2U2Z1ovOFFyVVNhVTNSak5qNTZzSVhBU1krMTFZRTdrbWRXczYw?=
 =?utf-8?Q?7QFvOda428p8Q?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UVdPSzBDU09lVnYvc3RBY3VOQXNBcFV3cElXMTkzMXB4NG1VdCtlQWhIYXln?=
 =?utf-8?B?V0V1UHA1ZElFSmxjMWc0a3RBMnNxQ1dqeXhuVzRIdkdWWGtUdmxKRlJQY3FY?=
 =?utf-8?B?eWZvUit3cmc1SWRBSVJvNktnRmxhQmFQTDNzWVNFTFZHSzZKbmNacG56ZVFn?=
 =?utf-8?B?V21rUHNlSko4MFpXb215YVd6S0cyazV4OUlEMEFvc0RXNGdzZTFyVXIzU3lK?=
 =?utf-8?B?N05MUDByS3FVMEVmTVd6Q1Vtb3o4TldhRkNzMGZBTlZESFp1L2ZCTzFZTUtP?=
 =?utf-8?B?Nk9HaHlueWdaeFIxalNQVGNHbFhLcnVSTWNqanN1OEY3SVB2NHFDQWtyNU9K?=
 =?utf-8?B?b0Y4bEcyYnF5cXpRN1hLQlcyVUtFTUpMOHRobjA4ZWg2UUNLUWYrdkdpLzNF?=
 =?utf-8?B?RzhaNTVKaDdvYUJhT2l1MzM5cUlrb0kyOXIrVkduT3EreHZlWTBKVnhXOGtn?=
 =?utf-8?B?YkJWOTFERDNtODJyVm1xU0ZEN1FzYURRSG05eDRUdXE1SVdvVGhDK3M3bkNu?=
 =?utf-8?B?dlV2S05wZUMrV0pKdFRxaTBpTjVxWWV6bDJHaXAwRG5LRGp2VXBlMDAvN09K?=
 =?utf-8?B?NWxXVG5aNVduLzE3UG56ckNQVkwrSlNxTCtvNk9uL3BzbWN4NjJJWENOL2dR?=
 =?utf-8?B?UFo3Uzljdy9hQjBZM1d6QlI0NndNdFN1Sng2RUgvZnQwTjNPQ2dBRlhDVnk5?=
 =?utf-8?B?S2tCZytNOEQxdXd0aVBpTm9vSHRtVFY5bmJlSlJZZWJmMWFNWkVjTldOSzFR?=
 =?utf-8?B?eUgrN0hLK0w5RUoxT0VNemxsVGh2N0VHSy9WaDZOQ0krMDBpWkNXMmNkQUh4?=
 =?utf-8?B?MUNVRVB4VFBXa3hMc2dEWVdWMXBEalJHcmE2SVJhYWx0dmZyNm8wN1dUZWxK?=
 =?utf-8?B?VTVRVCt0cDc4QjU4WithMHMvMDI2K2RSemdYZThldXRuTytYRWdnbzV1dE8z?=
 =?utf-8?B?UnFmL2ZoMGY5VGp3SHN1ZGxHUFFHS1dGd09ZbFh6OUl2dmZ2ZTg1NUVYb2ZV?=
 =?utf-8?B?NFhWTVNrT0VCK1pDU1V0THB5ZXNaSEVrbmF5VmZZOUVEcktDWHlPZXVjL2cw?=
 =?utf-8?B?UmZJenF2SXptdmtUSjEybFRWdkVMNEtCc1hac2dQRzVWWlVRRDk5UDN2dFZ1?=
 =?utf-8?B?RUZNa1J2eG15K2dhc1VHK2JHekFFT0dzUlJQQ0tBbVZtaFQ1WnJvZk8weER0?=
 =?utf-8?B?WWlpM3h2Vmg0R3pFQVNtU0tmVjlCM1cyRzR4SkhnVVQrT1N1bXU5SG4wQnc2?=
 =?utf-8?B?SG9MZHMvVWVDdXlTaUJUUGlyRmM1b2JYOFNSQjhSMGhjd080SEorZGg2UkZ5?=
 =?utf-8?B?R1hROVRuQjFPbHNpS0dnRjhnQnB0SGRYN1JiWWlSd2ZISk1TQWt6SStObFR4?=
 =?utf-8?B?VytQWUxMeWRGbDFtNm1SZUs5RVFvdllHSjhoSlp4b2MvQ1BpTUVzb1U0citp?=
 =?utf-8?B?UGdaVHhjV1VTRFFYM3dMUURsSUc1VlJLS3lmeitUTDJJUVBCZVVpc1dHMXVs?=
 =?utf-8?B?czFnajBaa0dkK2xzS1pUN0czWUJxVG1yUkszdDNJWmt3YmVHaWhpaXhKOHl5?=
 =?utf-8?B?U3J6eGlJU3RERkMzQUF3Y2VpczBTek13MUo0TmlXeVNHWXN3SkVCeVlsN3lX?=
 =?utf-8?B?RERjL3kzOERza0pXQUJFbEdwck9iVURqTEdwZUxOQjZPYS9sZjlZV1V3OW5z?=
 =?utf-8?B?UnIxWGlCNUJydGNocUtKOGtRU2xNVyt6d1F5RVhpV2doOGdqUURMQk9iTldh?=
 =?utf-8?B?WExoUWZnQ2xHeGt3K1JFYy9nMUgzc000WVJkVjkxQUlJVWhrRXo3MVh5Nkpp?=
 =?utf-8?B?cm5GcnBYQ01CcExaZVNDVXhlUlVBV1l3V0JjbXh4S2MyQ2M4d2JyaGxXODRX?=
 =?utf-8?B?eVJTSnI4NEtxQzZGeUs1NmVNMnZKblJOWkZRUnpvZ1BsaC91a1NNeVB5eUYv?=
 =?utf-8?B?T3I1aWVEejJTYzdBQzZBdVFBYUw1VFNCVWc3T1JBbHphZUR4UmVsM3ZzdW5l?=
 =?utf-8?B?enFHTFJnaVhPd0RZS3lwOXlYVFNhUjJYWDA4OHlwRjZrYXN2ZWtJTVduSjZm?=
 =?utf-8?B?Vlo0by83STJxajQvNnNaZXIrZnlvRmtTT0h0a1pxaWxUN1N5K01DWkFuajU1?=
 =?utf-8?B?MXVlY2VIeUViM3M0ZGJRTU1HZW9EZGNMdWFKSHBQZE1nTVlUOFBvZmw3ZGpS?=
 =?utf-8?B?aWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	45Ir9eiB/c5s08jJ9sX2TqAy7Lk+KEq4tGcwBV1exSJZue1QOQ7EK0DsEJPZzwko/O5iJieN1QgH0FRPoLx1up1u1rrL2GKtfoGJDKJmJ7Ye00Lvi12MtDapNU2xmEI/1pvJosCAVl52ixpasZ2VN7FWY9i7A0x4MdjSy2OijEcLK3MS61D5IOC7Siaai/wrd5+XO1CNuPfgqPRBNkstnAM8qbSCu7awx2dBZ6dLTWn6RR/jlnPTSWuiF5mTtUSbFuRrf1QSCwZ+S4LjrgNwUhNMMuSZ7bo4oQXRbeJkaciy7fqDtk1mFzLlmXj7f7ot6wep1t2u/cNL5kUNIQGKj8Zy/em03142KB6rNzLd6UJzasHxu6RkK0WT2a75hUEqgXN1TUX1pTTloaLZJnQGXlBoEgucVgxfQC5lp7eZSqPPecioQ0l2g+gn2/CTm0Dqcajascegizj5Cwbq6CxIP6s5Na7h561EghtBZJSM0EsF8MZAYoDchS0KtEYlbh6+iwidEiEaGPi4anQYSZDGjY4gYDL30sE640WpDz3stimpQ+2Jo3vCwvVnjAuUoDGvBWate7lgZ3SF2Bgr/2eeyPjgWiBpTQHdWB6MGkOwZEc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15ed99bf-01a7-493e-b63e-08dd61b21b62
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 22:06:15.0742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xF1kIKgau6nJ8nok8AbPl1E1/3y3IgRDW04ZlCjl26vHbD2xNWSHCvHhEd+YiUxVrw5frIUZXkU/uBMxRGt8IQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4945
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-12_06,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2503120157
X-Proofpoint-GUID: V6YaQATMZamig7isk875iywgpsBHffcj
X-Proofpoint-ORIG-GUID: V6YaQATMZamig7isk875iywgpsBHffcj

On 12/03/2025 15:46, Darrick J. Wong wrote:
> On Wed, Mar 12, 2025 at 01:35:23AM -0700, Christoph Hellwig wrote:
>> On Wed, Mar 12, 2025 at 08:27:05AM +0000, John Garry wrote:
>>> On 12/03/2025 07:24, Christoph Hellwig wrote:
>>>> On Mon, Mar 10, 2025 at 06:39:39PM +0000, John Garry wrote:
>>>>> Refactor xfs_reflink_end_cow_extent() into separate parts which process
>>>>> the CoW range and commit the transaction.
>>>>>
>>>>> This refactoring will be used in future for when it is required to commit
>>>>> a range of extents as a single transaction, similar to how it was done
>>>>> pre-commit d6f215f359637.
>>>>
>>>> Darrick pointed out that if you do more than just a tiny number
>>>> of extents per transactions you run out of log reservations very
>>>> quickly here:
>>>>
>>>> https://urldefense.com/v3/__https://lore.kernel.org/all/20240329162936.GI6390@frogsfrogsfrogs/__;!!ACWV5N9M2RV99hQ!PWLcBof1tKimKUObvCj4vOhljWjFmjtzVHLx9apcU5Rah1xZnmp_3PIq6eSwx6TdEXzMLYYyBfmZLgvj$
>>>>
>>>> how does your scheme deal with that?
>>>>
>>> The resblks calculation in xfs_reflink_end_atomic_cow() takes care of this,
>>> right? Or does the log reservation have a hard size limit, regardless of
>>> that calculation?
>>
>> The resblks calculated there are the reserved disk blocks and have
>> nothing to do with the log reservations, which comes from the
>> tr_write field passed in.  There is some kind of upper limited to it
>> obviously by the log size, although I'm not sure if we've formalized
>> that somewhere.  Dave might be the right person to ask about that.
> 
> The (very very rough) upper limit for how many intent items you can
> attach to a tr_write transaction is:
> 
> per_extent_cost = (cui_size + rui_size + bui_size + efi_size + ili_size)
> max_blocks = tr_write::tr_logres / per_extent_cost
> 
> (ili_size is the inode log item size)

So will it be something like this:

static size_t
xfs_compute_awu_max_extents(
	struct xfs_mount	*mp)
{
	struct xfs_trans_res	*resp = &M_RES(mp)->tr_write;
	size_t			logtotal = xfs_bui_log_format_sizeof(1)+
				xfs_cui_log_format_sizeof(1) +
				xfs_efi_log_format_sizeof(1) +
				xfs_rui_log_format_sizeof(1) +
				sizeof(struct xfs_inode_log_format);

	return rounddown_pow_of_two(resp->tr_logres / logtotal);
}

static inline void
xfs_compute_awu_max(
	struct xfs_mount	*mp, int jjcount)
{
....
	mp->m_awu_max =
	min_t(unsigned int, awu_max, xfs_compute_awu_max_extents(mp));
}

> 
> ((I would halve that for the sake of paranoia))
> 
> since you have to commit all those intent items into the first
> transaction in the chain.  The difficulty we've always had is computing
> the size of an intent item in the ondisk log, since that's a (somewhat
> minor) layering violation -- it's xfs_cui_log_format_sizeof() for a CUI,
> but then there' could be overhead for the ondisk log headers themselves.
> 
> Maybe we ought to formalize the computation of that since reap.c also
> has a handwavy XREAP_MAX_DEFER_CHAIN that it uses to roll the scrub
> transaction periodically... because I'd prefer we not add another
> hardcoded limit.  My guess is that the software fallback can probably
> support any awu_max that a hardware wants to throw at us, but let's
> actually figure out the min(sw, hw) that we can support and cap it at
> that.
> 
> --D


