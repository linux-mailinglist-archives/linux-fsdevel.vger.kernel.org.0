Return-Path: <linux-fsdevel+bounces-37427-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF9EB9F209D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Dec 2024 20:23:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14E901888006
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Dec 2024 19:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1581AA78E;
	Sat, 14 Dec 2024 19:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UcpzpMt7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IRZqUNjZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E035719A2B0
	for <linux-fsdevel@vger.kernel.org>; Sat, 14 Dec 2024 19:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734204196; cv=fail; b=WlXp5IjoQurGhKKhNLx9v9Cg9F0jToDD2MMUswiVLdV/S95TNPgXFsuc9KieHk+CoVmOQ5zwu8WHKHWei+Lb1UXWVj8YMY+aEeq0ZfAwTa8miq0zA2QQKFysyDIsBYky9kTVaPlxIImp3Fa1Rzh8BzTCUE1RtLZLf83h7hax+Fk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734204196; c=relaxed/simple;
	bh=CAm+lFnaMEdwaDFIDlSqzCdzco3038E7y3Ns6VWFlFQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DfLh/B0hem4nEnwB/iiBZctnHY3IeFTC1Pb2zMm58B0Fp5zfxJi0z4P0N4Nx9Uu8WYwOFsjlA7KQfqSRe5d+SKeQB9LRIqZFXh+8ZRuVYD7CK4fNmUXZZuWXl7o//87otptzR6B6+OqSjA6f1e/zI3K35bSXAO0YPcjplE+eqJk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UcpzpMt7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=IRZqUNjZ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BEIrkJJ027375;
	Sat, 14 Dec 2024 19:22:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=H7aJMl/wO9Rd+wsBPNftbvoi+ejRtQJVJM6hIQQq+wA=; b=
	UcpzpMt7Ij25duInQXU9wMc28HanRfkCfTD/Jj0N1w8fMbTOZAr6AeKf4tn9RaOa
	gmBh80TgzyOr7rEGN7rp2NpKs56/dNZKf1VKH77zVpdQeXZ140N7/I16qRpp0bUI
	gYWm1c1jPSIsjNRGMlJogtHcFaTXLw9/iHIDkosbiE2sKrwzU6D8BrbZLnv5G/kF
	VLsc/PZDoPjBc2QIJB8qS6J6MW/ZhjX6DJ09QsT1APxL6jiQjv7V/bQ4I/PKWa4T
	4mt7vVPfsw9o5KncDdta6xswCCROQEmznNhKRHJ/vs8fo8m9F8CtRYfVvdGdQCJH
	M1AV1xVR6up/jxZDAXai/A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43h0t28pep-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 14 Dec 2024 19:22:46 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BEEphIk006499;
	Sat, 14 Dec 2024 19:22:45 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2045.outbound.protection.outlook.com [104.47.70.45])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43h0f6q1ea-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 14 Dec 2024 19:22:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cVY+kEtZvLhImfNuazOFFaBFU8QfEvm+S/jyYe7dNXwB3P98IkW/7zmRAtXdx731brkhdUpFcXTb+HHFBMTOURujSjimmYg/jeR6pvB+1JAmzYGzvGr7Wi9fMhh/F7som6wFav3gyXVQzEmw2BNWVPQ1Bd/QrqrpZGfXTK3s0WwhfMJhfRG7WXis/Wfr16qZrluLcKBJwG/6Wh8Ywyc5WPzW3c/2wqFBQaIgo9xa/4pNQXFp3EGmnZnDE1hqoYp0B6EpkawD7EyOtASBChmc9UYMJAAWaIl4sDYLT3m2IegnzN7I6OTx8EL8zVzWvvCjFSYwEySh3K2uVGsDRvhoyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H7aJMl/wO9Rd+wsBPNftbvoi+ejRtQJVJM6hIQQq+wA=;
 b=CzGm1jCAwKSl5TE0ylmU5gNqTYa6+Elqd3vJAMPGYhOwFK+wmEMBCsTkNsf47HbcaQEuMoRyCJ60Wc77BrNPEaZuo72tmxlrQo3oq+3KSmWD2gZDP8VsRwLpQtHIVm14+G63AP2cO8Vx3cMMc9Eh3ipM7vRSM9Nu6Dkp+i1tRFsoUHPUOTdVPdbxH9qhJA1Em2apHuSrJbG4aT0GK4VS1ioXAENFhCYMik509Z21TOZnCoSrVbL7KNo1098B9+ALXWmf41BT7U2SdV+x9EVDKVZ5RS12o8DWLxhY1Gq5k7PU1bISP1/tcQSWnuIp2rhBSHwjep6m3mN1VGjTb/suTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H7aJMl/wO9Rd+wsBPNftbvoi+ejRtQJVJM6hIQQq+wA=;
 b=IRZqUNjZFz9Kn1hg8d4PvEMnbddquTWZh6p791pyDHqLNmnad4pBQShkyVwALuOT1pabtkaVrvlb4xUgcNfzlalU08bD5avoPkhU9hPpmc3JDdNk+z5fTeF+EqBGfES42Rkfs0/Z16YZAs7HORszKgynCAA/2gpefz0OosbwguY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB5756.namprd10.prod.outlook.com (2603:10b6:510:146::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.18; Sat, 14 Dec
 2024 19:22:43 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%7]) with mapi id 15.20.8251.008; Sat, 14 Dec 2024
 19:22:43 +0000
Message-ID: <99addf69-4757-4eb9-b6d1-e554a72070c3@oracle.com>
Date: Sat, 14 Dec 2024 14:22:41 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/5] libfs: Use d_children list to iterate
 simple_offset directories
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Hugh Dickens <hughd@google.com>, Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, yukuai3@huawei.com,
        yangerkun@huaweicloud.com
References: <20241204155257.1110338-1-cel@kernel.org>
 <20241204155257.1110338-6-cel@kernel.org>
 <5eb7bbdb-0928-4c80-bf03-9de27d6f3f89@oracle.com>
 <8c716ca1-84f9-4644-95cf-9965e8a30284@oracle.com>
 <20241214174949.GA1977892@ZenIV>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20241214174949.GA1977892@ZenIV>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR11CA0022.namprd11.prod.outlook.com
 (2603:10b6:610:54::32) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH0PR10MB5756:EE_
X-MS-Office365-Filtering-Correlation-Id: 324da65d-580f-4c7b-23d1-08dd1c74aebe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K2JlWmJGRnZzcmFYaHVkLzRtdmVWcmpoc2FMMjBUbnF0anNXYklIVzk1V3Z3?=
 =?utf-8?B?S2F1SFJtRE4zUUg1VUVralZ3cERTcFRCTEJHZlZZWTJlMllJcFVYWWo4WTc4?=
 =?utf-8?B?NFQzVlF1MTRPQzdPNk96N1BMaTdSTW1PQjRuSHJkZ0FhRzYrT0FoMTZWQmxQ?=
 =?utf-8?B?a3BiVkltRXRIMTZHRkRpSDdlYURCd0RhdG5DYnVOOHZFazA2d3NGNVhzVnph?=
 =?utf-8?B?TDAyeWZkeVBiUmZjVTFqOVR6UldyMzVYRXYranRPdWxrVlh0NjlXUmkyeVJr?=
 =?utf-8?B?WkhXK2xTWWhPaFJRNGplT3VST0FoSmo2OEl4WDMyQm9yQzQ0Uk5LcXdoM296?=
 =?utf-8?B?MFdrcTlLTExwNkM4cVBxRVlWTTZNakI2WVh3NmhjSlBFc2crekRXSVUzRGF6?=
 =?utf-8?B?amdialIvb2Erc3JacE45WnJ4eFA2LzlYRktxQmJOYUpPRHgwak5KT3VnRWti?=
 =?utf-8?B?a1BnS0RHM0hwTVczazFRdm1vWjZDOXdQZjh5THJtR1R3Wm5FWHBUU2toTVAy?=
 =?utf-8?B?cXRXRlFFbGEyR25VNWNVMHVVNW03R1I3Undsd2RHVElaT2dWYnVSa3kxcDNG?=
 =?utf-8?B?M0tpVHhwMC9HMnNqbU5jd2FROWRXMnRDWkZRWHVQNjJFdm1BOEE1RllUK0Z4?=
 =?utf-8?B?MGtpY3o1a0RUTVNPRHc5OXhETGFwNGloMitXK3lLYjR2V05pSkIrUmN3NFha?=
 =?utf-8?B?cnNHdzF4aExnb2JFbm1ZQkpLMmZoR3ppTkVQUG5uTDRhc2RabGJKeitmSEJn?=
 =?utf-8?B?aUV3VnBTZTcyRjBWTHNBYS9BTForaHlpYzJjSGFrRWRjNWYxMWwrNnVZQTcy?=
 =?utf-8?B?akNCVkcySXl1VzZheDhwWm1FMkJnWXpVSlU4MHZYUDJpa294cDNoQ3JTT0du?=
 =?utf-8?B?U2Nhd0FGM3lRWS9ndVVDYmkrRlVBQjVKdHdiNFpIK2Q5dkpXZUdpejNsem44?=
 =?utf-8?B?UjVPWFpSa3NkZTdMWG9xVDFUelpXeWZHMzNGMnhwaGdZRnVYQ21mb21xaXhl?=
 =?utf-8?B?cE15dUVkSzNUOEd3SWJUN2dnU3Bpb05GNHR2ZWJkVDNrbUo2ZWh6S01xTWs2?=
 =?utf-8?B?U05qSVZpa09ucHMyQ2FSanpOWVJ2ejQrcFhZK29nbDVtTDBqeWxtQ0d5Z05U?=
 =?utf-8?B?c0hrTnRKWXBLTTcvVDVPcmg2OTRLS1F0WTA1TEp6YlpPaFhWNGprNUdHSDY2?=
 =?utf-8?B?N2p1ZitLeklXRjhhL1lTMU1FSWhtMEp3aUdJVUJFQUZmMytHS3RqcXdLVmlZ?=
 =?utf-8?B?MmNVYURHTUxDSDNtc3VjVTlVVVREYUNOODJBL1d6MUxOenRRV2swUTgrNDNi?=
 =?utf-8?B?NG5UbFFtUzVxbnBCcHNocDFNQjhqQ1JNeGFRRFAzd1IzazNneWFYeHBCbVdR?=
 =?utf-8?B?eWhoWUpKWkhLa1NDSE9GVjNlU1VoRDRxMjRxM1E1REp1c3dBTko1cWlMZ1pS?=
 =?utf-8?B?K244dGlEUXFZalJISG9ydXloRmRZN0RUYnM5bEFvY2FnbzJXMXhOd0wzZzBI?=
 =?utf-8?B?UHUwZ21IeTNVVDJnc1NGSWIwSENpS1VWSTRPNzNCbldQRlc3ZVJiS2FualJa?=
 =?utf-8?B?akRFT2UrUHppVVV2dHYrY1U0OEFsVUp0Z3cxNFgwOFEvMUpzQ0dHSjdESGhl?=
 =?utf-8?B?TkJRSVIwR3YzcTNzUmpuc1RWMzVKeVo3RmliY01Wa2VvL3lQcHJEQ3ZqaG5a?=
 =?utf-8?B?YmZrREM0aWdQU21MS1RLeUxTN3N6cTdBbUQxaVVPay9UOXF2eW4rcjIyN3hF?=
 =?utf-8?B?cnoxRzJqTzh4a2ZVbW5va0txcmowcDF0dE02SElsaUdpUlBXUGVqWmdlWXUx?=
 =?utf-8?B?TnV2d1RSQ1J0Wjd6TUMrdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RXl0azRIVUNWSG5uQ254Z0F4Tnk4N2s1SUJpR2owVUNrRlNzdlp4SE15VnVH?=
 =?utf-8?B?Q0UyTEtvR0hYUGxQVmdqNDFVNHZVbjRNR3lwTURwbUxsaGZzRnRsZ3o4V29i?=
 =?utf-8?B?cTcvZzJKWVgrdVppTnhoZFRsOFZBSkdKRVd0am9UaWR1aHRTUjY3RVdNVE40?=
 =?utf-8?B?S0Y3MVJ3OU9oRmtDNm5ld1FqWjM4OXpVVVI1NjVuVUs4eThDVDN5Z2tDa1FC?=
 =?utf-8?B?TnprTGNxOE00M2F2L3R4YjF4Mkxyb3NGZnFlUjg2bmc5b3puaWdhcGlTVFVM?=
 =?utf-8?B?dEM5N1k5NStrY2tTakkzc282eERuNms5ZklLUWFlMmEzVUNCMWxHQmtJWDNW?=
 =?utf-8?B?TVRyc2ZEWUxEUE5BSE5UY25STDhtU1FnaVJ5d1dwQ2ZkazJzU2ZXaUg1bGFH?=
 =?utf-8?B?TE9kU0o2RWdFZjI1R0ZmQzRvVXd6cXBiR0xVSVNoM29uY2lheVJuQVJJQWJp?=
 =?utf-8?B?akQ3VjlrUmJXYUdZL2pVc0NOWks4bm9LVlN5QlovbzZFVzRtNVhSWHpTc0F4?=
 =?utf-8?B?RHFOUFZEaTVpM3VXaE1XQ09CTzczUlF3MXMyeTYza1hNY2o4elkvY1U5RGlN?=
 =?utf-8?B?R2paZzRYZG5jUFJiOEZScXpXSGwyYzc4Y1pMd3NSaUVoZnhsYVlvbUVEN3RQ?=
 =?utf-8?B?anB3YnBlT08xbmNLNnp4K2xKRjZPZC9NbCtHRHUrSkNUZ0ducFZVb2pKWlZv?=
 =?utf-8?B?MXlrUzdCdHRjU29vOGFpa1RsZVJ3NDUxNWZUT3Z2SEZyeEtsZi9RMnBjZGtK?=
 =?utf-8?B?VjNRWU5PczRKSlQzUDNSTlBtOTRKcEJEVnhNRDA3TTl4VGNNUGk2WVYvM1BR?=
 =?utf-8?B?RXRqRUFIWTJ6ZENUMkQyVFRMZDBRNXpjdVJOVG1pMk1QZG1hc0YxaVBvc2Ji?=
 =?utf-8?B?VlhXWFZkTGJtY2R0UkxpL2F1RWhHNTFITE9HSFNMMnRFbHptOGt3bzJMQTBD?=
 =?utf-8?B?ckpqK081cXR6V1JlNjhOSWs0SHg2SlNrZmFCTVVTL05qdGpMQWRCWWNXS20v?=
 =?utf-8?B?ZEVFS0FCQlpWcUdNTnJZL3lBZ1N6UmQ5bERxSXlKWG44cHRLeG1vNEVOZ0h2?=
 =?utf-8?B?RkFuNDF3UzcwWC9vbURISG5Xckl2dHloL2dmVTZMVFJyVllwdGJmWkxaaVh6?=
 =?utf-8?B?b3BkTHU5TEpDMnc3ZE12a1FaMXZ0RktaalJLSVU4a0J6a3B1Y2t3NGVwenI4?=
 =?utf-8?B?K01oWmVtbWFxckwzR2FNemhhY0tFbzZwWXIvSFEzNEQxbDBGZFN2eGJDVmtp?=
 =?utf-8?B?T1MxS2twSW1jakFRTERqbG1iQ2dDNEljdHZzY04xSkVHaWhxOUI2cStMRmFF?=
 =?utf-8?B?ZGZLVFVpeVlGQWtPSVdqemFLSnlKbmZyYzNaejA3NnJuWHVhM3g0bFd1ZHZw?=
 =?utf-8?B?MnNWVGZhclRZWXNzZXJiaUtBcDVhZlc4R0FyRHNESWRER2lwYjlINDF3c2pz?=
 =?utf-8?B?MUFpQzVWVWl4WCtEZVZEVFBnYnBTNjNzRnV1TnFMVm5DVE1Sak94a2FtcmZE?=
 =?utf-8?B?bUdjbzlPVkdzVy9ZbE8rODkwV2x6YUhaZzlIVHFkeEIrYlA1cDE0MFRRaUh5?=
 =?utf-8?B?ekhzR1A0SHJFTDY2cjdHb1BrdHVMZVJ3SWhHb0lmdlJMd1A2WmsvTnJCTG9h?=
 =?utf-8?B?UlI5T29kWkFodVdENEhid2V6L1RNNndzWmNmbUM0QjNadXpCZUVXaWVYQ0h3?=
 =?utf-8?B?eURZOHRxR3drUWYxaWNPcUQ4YnZpZ2JkNUlNMFpTQXlUb3ZqVjJuK0ovMktx?=
 =?utf-8?B?Y1lPQ0g1UGlVQlZBb1hNVjU4K3NKTzhrSklNYlpHbGlOSXcvc2dwVlM4d2pi?=
 =?utf-8?B?L255SHBoTFlEeGk3NHdjNStrWjkrWkYyOEhhQWoxMXZFcjl1NW00MEJyTDJ3?=
 =?utf-8?B?eG53enl4Um1pMjZLY014bzQvRlgyMGxXZERYSFdZRzBFdk1Xb0pUTmdqUWI1?=
 =?utf-8?B?QjIzU0c4Q3NDd3hpR0J1bHVsdWppS1h6NndtKzZORXJwdjFGM25oODRZU0R6?=
 =?utf-8?B?V2dwbStVSVpQV253Z1A2WkFyeTlJSzNua2NWd1lpVWRPSGxIOHJKK3pwZlhD?=
 =?utf-8?B?YzQrR253YUw5QmJNQ2lhRHlVUHJQc3ozcWE5OXhNZEp6elhMaGFRdnRXRmN2?=
 =?utf-8?Q?oJy5+0HcbEPXzTUFb25LlIjGX?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9iWDgvNvI0klSdCrHOW5W0ZhuT0J+S35PIWpxMYwV3lKyx5+B0LgxBvUPK6HiU8MrChhG8jtMMByPkZVfpWMo/NYx6EvQKz7raiFsBr2r+hyu+ZiV1iSLtPi1g/bpPUFq4xkmos5dm7Si+nfLtZbLNR7BoIfUfjU7iLvwz0Htfsy4e5rcKVoGRK0xf4r7qZwvI1557Ripvt+B0RIeT6giOAGu6qVweePWPx4SGYFBFWkJpWpGFD28zoZpUEg0Mfq9DvldBHuBMyVh86D/KxhNGCQmmjMeIeDlOT9eJy9ABBC80iBKID5j84Fsuw9QeaYx/beFIE2izsmy0crYERrLv+bo4NFN/lP0b6mgH6yb8iL0zJdZnhm5UPSwiFDujpGMlxDoYDtmnt6EOkl/9o77lm/PY4guZsEY7TbswXJpljFBhaIEszuOINE/PPW1TuXOba3hR22NPx3BOq3O3GKQ+nDweK1kKqbM+VxEGloP8+GqHptjG+8IDhfy9sO1GMMZ4j3YCpBScfXI4Fku4uNiPfZxBWNribJYLLVVMRlGNYStkX8PbK4wBUMgvQf6zUxx64Fy/sex1UJpSUnE4r2uLPgULRbn+vGpM+gnzsTn88=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 324da65d-580f-4c7b-23d1-08dd1c74aebe
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2024 19:22:43.1422
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2lKAyObmo8nawUP2KVMlpPOTBkusvy29eEVitDC1bzFFj5G/nqLVzM6m/dyZRnZwznPsB6uL9IsSOXz+sTS0Ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5756
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-14_08,2024-12-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 bulkscore=0 spamscore=0 mlxlogscore=840 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412140159
X-Proofpoint-ORIG-GUID: ORtYIfMcCbsl5satQWUyftZ_HGKGh_N8
X-Proofpoint-GUID: ORtYIfMcCbsl5satQWUyftZ_HGKGh_N8

On 12/14/24 12:49 PM, Al Viro wrote:
> On Sat, Dec 14, 2024 at 12:13:30PM -0500, Chuck Lever wrote:
>>>> +/* Cf. find_next_child() */
>>>> +static struct dentry *find_next_sibling_locked(struct dentry *parent,
>>>> +                           struct dentry *dentry)
>>>
>>> There might be a better name for this function.
> 
> There might be better calling conventions for it, TBH.
> AFAICS, all callers are directly surrounded by grabbing/releasing
> ->d_lock on parent.  Why not fold that in, and to hell with any
> mentionings of "locked" in the name...

I've tried it both ways, couldn't make up my mind. I'll try it again.


-- 
Chuck Lever

