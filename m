Return-Path: <linux-fsdevel+bounces-21869-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F55490C7CB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jun 2024 12:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 850CA1C229D6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jun 2024 10:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A79A156984;
	Tue, 18 Jun 2024 09:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ldID+3dN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="edjnSGn+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4500A156661;
	Tue, 18 Jun 2024 09:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718702370; cv=fail; b=lRIAfeN/+VQBY4JP5wj02kKa5VX2nmfdxozMO3bqFUNf1M6TtBpCikGTQCpge59UmuQ3SA8CaCN84j9G7TGUy3Lc1lkoC5cU2NOJHvryDouIslDLXtcVk7LOjT/WN+wtxCaR75ZMHn0OxtWpcwzcO0nhmjPCffukXwcCLOFtOVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718702370; c=relaxed/simple;
	bh=li6PuOglSH6Ka7irL/R2/w1uWDD0K0rEYAlocfSr72I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=N3pTungTNtR/wIbQ4AV/mawYmKIA2MbcdDaSYzpnYKcvv3B5Nvy539Ic6qLSDs5hWD5hrag+snWlGetcBjR6TkhreFHdBmYbjIDMy6krLblchNmHQpBm744shAkWsC1YW2JPz7HB+JIvld+U1pCZQnPHRDaH7p+T+AAdGg7k2QI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ldID+3dN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=edjnSGn+; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45I7tcgJ012651;
	Tue, 18 Jun 2024 09:19:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=NcAgGohBB8WgS/h7jD7RfxYuTsXBwLZ0dSkAF3K/wZs=; b=
	ldID+3dNwSHfCESFWTLIZJqJjyJnCBVTkMRZDfCMy9pdtTOXuB7L5vbfOJzhYHBn
	mYyAy/MNHM31mX7doAGwUZk370vs+94Psp81Swfh03xrNwV/YYOlKm5oOOzLvnnt
	t6n3GkRM6WjMj1dTU8EwCkN9qadmLXuXk85Q6qGiBCc3KMpqe42EVUgpCSqVYDHy
	pM1lqFOcz/mxLOlpqnIe08anWeV6vLI/yscGt1T0qcAIRzIeQKpRQ+rV9MPkO/qk
	7QJDIc9ZKZnpWs8vHs+/dGgbFeojcUeNyvUxnDB9NKWBYr8umeXtK46ZsFvrS8em
	CCZCXGRInJ9UkEAS6A5hSg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ys3gsmg65-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Jun 2024 09:19:14 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45I8fT2h015483;
	Tue, 18 Jun 2024 09:19:13 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2043.outbound.protection.outlook.com [104.47.55.43])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ys1ddv6rb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Jun 2024 09:19:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JY/QcmFZk2HxpmcZKp2XC3T+dN4EzcuwbqwIqTMlbBN4TbHHS1VDWw1uOerQrBcmpDYQdsEzMmKvJHcgeQasdncVCLswA57IisfHcHjbetEDguFK2VSesovoDvDTFLHpgSXUxTTixW9G2zfpz43T19wZhAxkIq9zatSXCz/L87ziGR/78iGdztVUGBjILjPvS685/aItAYm1EqkEAD5PIiFk+lTYS62Hid3Ej9Cc+1hyO9Ifnk+yUY6+v0A6U9PHmO5aBS5w4mG1ZCSwJzGmm9zrj3/rA+XdPWY0+8C2S1qDNR6EpbqgfY0kSNW6AnGCZarA25G5NWHfAcwMC4utKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NcAgGohBB8WgS/h7jD7RfxYuTsXBwLZ0dSkAF3K/wZs=;
 b=YuMk/Rb2XeN1CsucQG3HlQdP6nznZb3Wm2pkksOS+rrsGsjUn6GhWXrrCB2e9fSxsOCnEO58eEP97E2jrFqpiUZ6z3BvTnWqCCLTNGDX/5gxCM1bXwqGs+gPitTuZZVmkrun+jkRXmxE4OsGW+QpZtAHll7CNusZCr3Jl/WhZ/kslDdvv0ZTcAkALc4NcGkCN2crRmxJoOTZWwZj3OrQTxBxzgCzdWxnf4stgisdJAfedivBEZ58ai3j7RKvOYx8KgedUiklNT1RvF48q+wgB/kMqgl1eo9kuGjz3tS0FYxlpDBxwi8EGPEdkKRdTQBUeHGWhHG5P6sL5sVoLPRiFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NcAgGohBB8WgS/h7jD7RfxYuTsXBwLZ0dSkAF3K/wZs=;
 b=edjnSGn+BNTWMPJ2f/WVs5uoLXUpPvZeYI3n0329xFsGCQP5xN4eGyrxcHD1Br6kl+hzV3vYRsthTct2h5Hh5yFwHDic+E3eXlwCSW/GsAnvcHEEsi0kfAaqer50wsLuw0PXE0JNYZsNnCcaXwCQPfcV9AxOXJhtDrRXr0H0UdE=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CO1PR10MB4466.namprd10.prod.outlook.com (2603:10b6:303:9b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Tue, 18 Jun
 2024 09:19:10 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 09:19:10 +0000
Message-ID: <1d188d0e-d94d-4a49-ab88-23f6726b65c2@oracle.com>
Date: Tue, 18 Jun 2024 10:19:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] statx.2: Document STATX_SUBVOL
To: Alejandro Colomar <alx@kernel.org>
Cc: Eric Biggers <ebiggers@kernel.org>,
        Kent Overstreet <kent.overstreet@linux.dev>, linux-man@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20240311203221.2118219-1-kent.overstreet@linux.dev>
 <20240312021908.GC1182@sol.localdomain> <ZfRRaGMO2bngdFOs@debian>
 <019bae0e-ef9d-4678-80cf-ad9e1b42a1d8@oracle.com>
 <bjrixeb4yxanusxjn6w342bbpfp7vartr2hoo2n7ofwdbjztn4@dawohphne57h>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <bjrixeb4yxanusxjn6w342bbpfp7vartr2hoo2n7ofwdbjztn4@dawohphne57h>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR04CA0050.eurprd04.prod.outlook.com
 (2603:10a6:208:1::27) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CO1PR10MB4466:EE_
X-MS-Office365-Filtering-Correlation-Id: cf54e649-b090-4e40-ab9f-08dc8f77b671
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|376011|366013;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?djVWRlVEVnRjbDBwaGdlMlBoL1lENFRRZzZ1RDF6eFNqL25SM01wTjc1UlBK?=
 =?utf-8?B?TzNSYSt4c2NBS09tQStqY0RCQ3V3aXRwc3ZGTnlLd2ZzTmRpbTcwV0N1Mmgx?=
 =?utf-8?B?QUtKRXVocjhQK0QzWUFQVXN1NktHMmxTLzkvVSt5RjJ3Q0duaWNyOHQ2d2VS?=
 =?utf-8?B?SWJqcEFERHNpencvRFNZT3NabEpkQTI2MkI2OU9MSWFTT0lEVE8yYWM0NHRG?=
 =?utf-8?B?dHVOcWV4NklDVHg0ck5kb0NBN3Q2OE8rT3VMWXhRbms1SnlCbWdmaGpWY2FU?=
 =?utf-8?B?dlpwTm15SFlOU3czWVNqZlBCKyszdEptOFF6TmVHRkRQUHBpdXgydUNic290?=
 =?utf-8?B?YzByNkNobEE5U0V1ZkwxV2V1eUYzV0JwTGZ3eEJyZUhKQU5GaXMwZFN3dHdv?=
 =?utf-8?B?UVJLOVAzaWZaQkNIY21BV1h6L2t6UE1CbnZkVzVERTgwV2VCTVJNV1g0K2Fp?=
 =?utf-8?B?M3F5NEVjckE5M1h1Wm1GUHJ2SmRwY1dURWRDRy9TSGdpUGI1bXczTUtIdlh1?=
 =?utf-8?B?N2s2M3BpZDlWdFFVdWVjVGUyM3JxMXNwVTdPWk1Makc4RERZVHVzaTZpbzNF?=
 =?utf-8?B?QjNvR0hORmFxVE04WlVOZVZ4bDIwMHJrZUVQY0pVSlJMTUYwOUNPSjYxRG95?=
 =?utf-8?B?Y1l2enVPTHZoemxmck9odGNPTU1mLysxMk1wRmdqYWpFdWFST29KZ09aUm1G?=
 =?utf-8?B?eGR4TzhtNWlLVGEyclZ4QUx6cGIrZDgwaHZqYm1ZUjZBQmRQd0FkNFYwbWxD?=
 =?utf-8?B?UXhBQi84YUd2ZzJPV3VtRVphZ1lRU3hVSDlhc2wrMjFHOStWOFBhMGhRaU1p?=
 =?utf-8?B?RWN0WEJ2SHdmMlVJYmtGWncrT2NFNkFEc0gzcnZUMVN2TG5JMTVraTJXY1M0?=
 =?utf-8?B?RGt0Q2VuNENhQ2tISnJNUzhBQi9Mdmw0bkEzWjhzM2hWNy9nQ3dpbFdYcW5P?=
 =?utf-8?B?UytNck1rYm1RTTRnSkhiU0RQcHVPK203ZXg4RDZzY1JZVVdNOFVjZWtSc2wy?=
 =?utf-8?B?cVVNSjlvNWZXQkxXVDh4aVErREtUT1p5SnhVdExyN3pkRGpYQVpndmdkcDFv?=
 =?utf-8?B?dnd6V3J5dXkycVBQRm9uamZ0TVZKSXZhTmNmRjhnS0JuK1dUbWh6cXB0S3NT?=
 =?utf-8?B?NFRTN2FwRDBabjM1eFMyRGxGTmU5TmpkcVVGRHFSZmhHTDNEZHlWc2dIVWo3?=
 =?utf-8?B?OU9rSXZ6OVlwemp3MCtUajJrcldjUUMzbXJwUEVRL2NyNWpSUjdoNWZ3N3JR?=
 =?utf-8?B?V25RRWZHN2c5QzBwUnpZWnYyRkx3NUN2U2QvRE5qaEczeS8yN1lMRHp6VW4x?=
 =?utf-8?B?bW9TY2MyZUdjWVY1RU9CVXhuUjB2QU92ck9kSlhtcEQzaXdEbXo5U3ZsdTNR?=
 =?utf-8?B?SlRQYVplbkNEMFdRRSttNVJQUnIyZlZLWnBBbVZkQTVJNGNsWEkrUDZBNy9x?=
 =?utf-8?B?L0VjUUdSOTJ3bE1BNi9GMTh3Y3ZXcFVsZDRrYzNCUEx4VUhhbyt1YytQb3J1?=
 =?utf-8?B?SlJIRHpnbXEySGpwekwxcUIySUxrZ0lUd0xkOGUwdXdKV2FwMVQ1bVJwMmRK?=
 =?utf-8?B?bGdJRVNpSDF1YmZ5NjRwUFJ5ZHhwazlKcnAyTjRYVFhLNmRQRmoyOVc4aHo3?=
 =?utf-8?B?cko2M01rRExnbGF2WDNZQThmNVNlL0dpdEc4Q1pjcHkrendaU0llU3JING9U?=
 =?utf-8?Q?sVj6RXJdbOcTALP+IX2C?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(376011)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cXYrTlozZENidmJRTWV6T0F0VzN4aE8rbDAzMDdCR285TGI1V2hGVU1GRFNt?=
 =?utf-8?B?MEg5WVMxUm81eW1ad0k4dWp6R1VBNTVUUjJoZkxMQndaZ0RsVEhWWUtWNlhl?=
 =?utf-8?B?VUxSUXlLQ2lDR094YVlMTTllblIzdjNHZllRRE5WTm85VWJ6K0NOTjhqdWE0?=
 =?utf-8?B?dVNzN2IvTzVhSy9Rd1Q1V1JER1NwRE40Y296eHdtRkZMTG94ZDY0OHRzdC96?=
 =?utf-8?B?Q2hDaDZPdHlVNzJHWFZHNFZBYUgwbUl4Mk5xMlR5aVdzMlhyUDMvdWlyaC8w?=
 =?utf-8?B?d2tGWDZ1T250YlN2TmtNTDNWQUF1ZVRSYk5mR2lBMkdLUkNSbWdqazRFaTlF?=
 =?utf-8?B?T1ZWZEs0WjgydGhaRDRBYmFXbHBmb1gxejMvcEprdjBqVGpwcWRzNTJvVzlT?=
 =?utf-8?B?RVFubFhNb1Q0d0FtZzE2NVBuTXcrZFpEOFozRVl4c0tmd2VYVG1PL3JXbitU?=
 =?utf-8?B?TjdoYVhKcGxOeWZLOE5ZU0VWTjd1bXBHTVArK3lZb0xFS0ZaL2V4c25tUFJi?=
 =?utf-8?B?VGJNTkJBa1ZGc3ZKSER5L1NCWGRWWWJpTW9vVEljWmlJT01OTTdmRkpiREh5?=
 =?utf-8?B?MkZ3U1B4ZWNYWnhmYkk0NXd6YTZ5ajZQSTlFYzZ4bHhNSGxRejl0b2thMStQ?=
 =?utf-8?B?b2s2WTZZWTlUdnBDMnRFY3QrTjk1MWNFSFlmWC8wV0lSVGNRbFJScjFTUVpF?=
 =?utf-8?B?MjZlMU9ETER0ZjdkWk5QN05CbVFpVUhLVHA2KzBRdFczdGZVdXJHV0dmcEhI?=
 =?utf-8?B?R2ZEb0IxOTNsUmZRZ1BFREx0cFo1dWRuWVFuYm9PQjlEYm5zNitFNW1FZzlX?=
 =?utf-8?B?bGRFMWt4bnlYMmxWdzFFNkRySnBVUlNqREtCVXNSRWxpcG1yZXNRbjJqV1JB?=
 =?utf-8?B?emN2dUNHc0N4MnFsR21iaUVxMG83QUlCNGY0a3p2UGZyWmszUGdUNkc5RFVJ?=
 =?utf-8?B?N3hLb0ZETWwxemlEOXc1TlhwRXNzZWd6QnZhSEY1TE1jRURtYVBPZUhhRWMz?=
 =?utf-8?B?OXUzRU81b2QrTXdhTDNlalpnQXFsNTgyZHdwemd0NE1ON1d4T1NnWERnMGZj?=
 =?utf-8?B?Q3c1dnVRZS9lcDlFZ1ArclFmd2JjMnhHK0tFdERqaXN1MTRNc0xnN2JzaElF?=
 =?utf-8?B?Y3RnU21KU0VtdERoaWhDSVdUeUFVemhaUXFYdU9WNzVHL2J4bTJ3T1E5dkF1?=
 =?utf-8?B?eThKblNkNW5rRnlmWWV3Wmg5anlKcmhTTFBQcVo0VXpjeVlxWHJSRE9OUEMx?=
 =?utf-8?B?NnpwRFZndmYvWU9ldUR1a2FTWGY0enRBMFR4cG8xNDF5eGlJUUh6cVVSUTR5?=
 =?utf-8?B?bXVndWVnUS9aUGZMKy9HOEpnUEFQcnlZVUg1VkVDNGQxNkg4SldjUjZ0Zlph?=
 =?utf-8?B?d0toVXJZbzZlcnMxNVVHc3ZRRUpkMmkzUFJCc2tPZndiaWtCVWhzY285T21D?=
 =?utf-8?B?S2k5TU4yMlhyL2QydHRqa1d5dGNMNzBCYTBFVDBkNWtTVW1pZWJYN2xmbXpF?=
 =?utf-8?B?bjZsVmNQZDAvaEdzc2d2RUkxTnp4RW9zNXY1QWxEYkVmcldCc2RtV1E1b3Fz?=
 =?utf-8?B?dkw5eUhWYVBNSG1rZ2Y4S2dReFBBbzh5V0JiVDQ3b1pQVE9WQW9oQTdFeUxE?=
 =?utf-8?B?U1pyY3Z2bjVBRUYzdGZwcXU5S3h3VVlzUjI2b3JsOE9Qd2IvNEU4KzZ6S3JI?=
 =?utf-8?B?d2xqUGVuY0dFU1ZSamo3SWtKL3hxMmZTZHNDTXVBOGN3QzNhTmNtYnc0VHR6?=
 =?utf-8?B?TWlvMkJtZTZaYUs5eFhicXQyM0lkSVhoV2ZOVjI2WXhHblFlVGlHbDYrM2Jm?=
 =?utf-8?B?bERBVFdNajR4c0ljSWE3Tk5tYW5udlE0MVBKMDIvZlVxcEZGc0NrZFdYSjB2?=
 =?utf-8?B?NkFGSlZjZDJheENYcmloQVJzTThRNHpGbUI2SWJ3TWZMc3BVZS9WVVNZdG1G?=
 =?utf-8?B?dWhpa09BRWlQOTBJZUMySGJZQk4xWGtVc2pUUjJxcjFhNXFZQkhVS08veEtU?=
 =?utf-8?B?YkJxZXF5aXV1alFHb0FieHVMekRqeGdtOExPQTlxQlFtdElINEdzU2hFNE5Y?=
 =?utf-8?B?R1lwM1hJWEp1ZWk0WmwyYXpHekIxMkNIN0xsY0tEUDZGY2QvdkVvNnRwZmd3?=
 =?utf-8?Q?qZ+Y9oa8vYcjqLsfuZnoYKi7w?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	JFQtgBkAC6zrBac9EE3WCZgPYiWYrVfNL8vl4EupllNqnflj9aEBzqyO9uh63TfBT5zL+3qMpmTdPbV24ZAmfpHSD0QeO1YeKjYKK7oacp5XJCZWbuFJsaApzXvwAS9vnVZ3tDILaFirmVL+IZ/DBUJynyDH1ldh42SF/WJx7meGu15fQy5JEM+UJ/Qa3xLNq/rpZV7NhE44rEyuIvbxhAXcNKuc4OQ1aNuxbGqndrkgoILpJnVOoRUR3Hxz6gphu+1h5x6ZWZ69v9XoYeTMjIBITCQzTkWmFiGo0bZURISPmN4IsrlZqStUPslvNsjVLQtw64cX9Q7cyapKFvSEBMMDl7kdR0MQj5o4sz5ZP4m++Ed5exOhjsWd7Pm2fsmJPERMCyIp9hkClmPyukQKvWWNLoomZnLHQ+Mv4AUTzADKmq66XPwqpCxf8sUw3fUwLH4br5SP1dUrNAzMIqoP1CvhD/HwBZ2Mz+0pQax+uhmd3GWyjaBcY9+MvWQDYOlmQaNUcFMv6785jKd7V8CVe7Xuh/trbOUrbzBAgb0pNmD0Vwzn4qA2isEt+rbPyMCyfr1gsqxfHLIWsuT+iI3UmwbpbRpk8JJJwL+AXpT+630=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf54e649-b090-4e40-ab9f-08dc8f77b671
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 09:19:10.6478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WsmSUc5Nz1Gxv3U7y8vpMyEXHGDRFfFyX4ndqTuMraCZrnz5rVlPIB/eOtXUiTdud0DCC4dp1XjezYSBh1kQgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4466
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_02,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 adultscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406180068
X-Proofpoint-ORIG-GUID: E2VZqiMRVswpDljrMYZzUEhQ5-EXLxJV
X-Proofpoint-GUID: E2VZqiMRVswpDljrMYZzUEhQ5-EXLxJV

Hi Alex,

> 
> On Mon, Jun 17, 2024 at 08:36:34AM GMT, John Garry wrote:
>> On 15/03/2024 13:47, Alejandro Colomar wrote:
>>> Hi!
>>
>> Was there ever an updated version of this patch?
>>
>> I don't see anything for this in the man pages git yet.
> When I pick a patch, I explicitly notify the author in a reply in the
> same thread.  I haven't.  I commented some issues with the patch so that
> the author sends some revised patch.
> 

I wanted to send a rebased version of my series 
https://lore.kernel.org/linux-api/20240124112731.28579-1-john.g.garry@oracle.com/

[it was an oversight to not cc you / linux-man@vger.kernel.org there]

Anyway I would like to use a proper baseline, which includes 
STATX_SUBVOL info. So I will send an updated patch for STATX_SUBVOL if I 
don't see it soon.

Thanks,
John


