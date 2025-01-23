Return-Path: <linux-fsdevel+bounces-39961-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98238A1A668
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 15:59:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB0543A750B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 14:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE5DF21171F;
	Thu, 23 Jan 2025 14:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Q2YfjDYg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="iv/GE6Vx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5040220FAB7;
	Thu, 23 Jan 2025 14:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737644377; cv=fail; b=moJXIquV7A8GtaxaNaOJenWiSfPaVYAyfcpwJhLZB4SM+gTxlxkw9oF2OTRaP290+OFNCFZtBBOkJq5KeopEIJuEWJpeaavCWRbH0rCyTq9fFCGxU9Q0PwmQfSc4O/FCmkwLTm1I6SIRVoqZTr/0ukL7c5KE6a7ANbp47T62aoc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737644377; c=relaxed/simple;
	bh=eZkxk20cN8JFJFz3yeR32kpoX4wsaEHWdQ5TyquwszM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=u0BCIa/8Ag9DW78i9ooDNrhCe5dSZW/gopK22um3hR5uJCrPxtF55uwSs0oGQfZ3fsPTulDQRmo58cA8dyTTOYRcoEyewPyKliJhs8M7Fzh6b8OgMELgkWrrwo9l5l40MtRMAgsWLywKDGcR/b2FmexcCEdWKCQT5o+iLbbMsgk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Q2YfjDYg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=iv/GE6Vx; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50NDaM3M006900;
	Thu, 23 Jan 2025 14:59:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=MOEQao0ClLI+8b3Aex55hThvzUkjXA3T05LzWMzV5sY=; b=
	Q2YfjDYgM+44tBU/g0OuMK8UtzH1+ew2g2g09GHQKsM+UjAd7zE4t53M633rsmnB
	SfDIUFjiA8HChu65zRMSsN8uVrki54+0mnFwHPyG9Nv/HaWmkKgvlJbgvcoaNsYa
	2mToEg0bcmNCnvxzhQZYo/z+9HWtZjXkj2WS8/5tTCM8TotpiE0qLkHGa+6WyRMQ
	m56JitGd9r9WwQjrWmFtU+M6F+Wh6Z8AgM/bku8I4vs++jQa9vQtO9V11uVqHfdH
	NzyREmlbLRuyPvDckwwa32DuGDzG7Nyp/eFAyglIoTlQWlwUjUig2amYGr7nRO2y
	A4IpmV5oBBM1fN1nGSRUPg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4485qat45e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jan 2025 14:59:26 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50NDn75J018690;
	Thu, 23 Jan 2025 14:59:25 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2044.outbound.protection.outlook.com [104.47.74.44])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4491c5253k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jan 2025 14:59:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CB9DJL3VoGx48O/cgu60YWT+20jgBpsaY/wcrrGNoQMRu7z9ikO+8vu/SrYXlD2bqn1GgTYnKGS9esiyDMYCn7C4zDEPDC9CgjOQNyoNDXDuQHk51e1yz2oGU2TTg5cfRALdbRg1aakFj7jXpi88tjfGidex3qDMj+cIoya7l/eTmB5hX5UIO/IGJtkxkXZGYhl3CERCLhmRtw7xapgIGQt80pWUHncw72/bdT6gWjAenUJHHTBI2MwPmq04YmGRKblvMU6fTLBbxQGpfFV33kgSVLrXvzeU/AiA5hhShudc+bMIqcUQTVNohANydM/A/PSgYlSIKdhh6lNuI21hXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MOEQao0ClLI+8b3Aex55hThvzUkjXA3T05LzWMzV5sY=;
 b=yepJlgfKT0fUDO2y1pdAsn1UdmSBIOGxwUAQTd18I1CIvw3G35SydcOvHT3duh9DaAS43eRj9AwVfbxPQt5+YS7RsjUR4N70ay2ogCRoT2KCYU4f8zbAaPZouvCilvgGWkV+7MW1bTF/uU8J9C0wZwjF0LHStEreehsPv904CujRr8XdZFLu4KkvnRAWVocevwMKu4V+WxwqzHZONZjHS1RMwg4JD/yU7yAB3/LJTyXhK9E+jIfi//Ro2NNqw8+jUdY/qs5zUB21jwcv43swV2KMhKXc+E0ydBeuhfZPwnjG+DREQ0ihwXO1L1wFoKY8td01byUzBswyPvAJJ1ClHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MOEQao0ClLI+8b3Aex55hThvzUkjXA3T05LzWMzV5sY=;
 b=iv/GE6Vxjy2OUj9aHmvh+s+j4ReS4sQQN7HQidGGRGp8hVzPcF5sXzSPJSNHAXntLzv5PPjLVYHhhcmjDVMFzdR021gTFZRkqpvzemVI/3VMLhY0tdwJ6sfWxAMDWqJcgBWzC3GrT6TqKM+J7tAkF1m8ExUJMer9YwnAoLH+vVA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CY8PR10MB6657.namprd10.prod.outlook.com (2603:10b6:930:55::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.24; Thu, 23 Jan
 2025 14:59:23 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.8356.020; Thu, 23 Jan 2025
 14:59:23 +0000
Message-ID: <6d3bdbf1-fab5-48f6-9664-ef27fb742c55@oracle.com>
Date: Thu, 23 Jan 2025 09:59:21 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nfsd: map EBUSY to NFS4ERR_ACCESS for all operations
To: Amir Goldstein <amir73il@gmail.com>
Cc: NeilBrown <neilb@suse.de>, Jeff Layton <jlayton@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Miklos Szeredi <miklos@szeredi.hu>
References: <CAOQ4uxh4PS0d6HuHCM_GTfNDpkM1EJ5G55Fs83tDRW0bGu2v-A@mail.gmail.com>
 <173750034870.22054.1620003974639602049@noble.neil.brown.name>
 <CAOQ4uxiXC8Xa7zEKYeJ0pADg3Mq19jpA6uEtZfG1QORzuZy9gQ@mail.gmail.com>
 <c2401cbe-eae9-44ab-b36c-5f91b42c430d@oracle.com>
 <CAOQ4uxi3=tLsRNyoJk4WPWK5fZrZG=o_8wYBM6f4Cc5Y48DbrA@mail.gmail.com>
 <50c4f76e-0d5b-41a7-921e-32c812bd92f3@oracle.com>
 <CAOQ4uxiVLTv94=Xkiqw4NJHa8RysE3bGDx64TLuLF+nxkOh-Eg@mail.gmail.com>
 <d36de874-7603-478b-a01e-b7d1eb7110d3@oracle.com>
 <CAOQ4uxgnQ-4azkpsPm+tyd7zgXWUxXq7vWCfksPPF864rpN27Q@mail.gmail.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CAOQ4uxgnQ-4azkpsPm+tyd7zgXWUxXq7vWCfksPPF864rpN27Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR04CA0093.namprd04.prod.outlook.com
 (2603:10b6:610:75::8) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CY8PR10MB6657:EE_
X-MS-Office365-Filtering-Correlation-Id: 37c2fde7-2eff-431d-fb39-08dd3bbe85fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S2FkK3g1S1J2dVIzeFBYemU5QTVETE1qWFRSL1o5aTRLVWxuSy9VT291a1Vi?=
 =?utf-8?B?MWJwRWV5cmtYc2lqQ1JkektYVjM5WHdpUjB1OTdocW1FUG51ekVRRXhRaUJr?=
 =?utf-8?B?NU1kUmZ6WUhXUDZnVWIzK2I2MVMyWVQ3TCtXMXZ5cWZ3Uk83R1F4T0JKVUxv?=
 =?utf-8?B?UGxYZ2I2MVp6VGlnK3A4ZWl2dWNFbDZ3YTNMVy92NUxzejhCUjFoQjZRN0xr?=
 =?utf-8?B?RW4zRnRDb0hpMUZwNFB4QXNwejZUTmtCSkVEMVFvUExEYllKbUxKK0dDSXdo?=
 =?utf-8?B?bFA5K1h3dTZaaVM4dDExUGUzcS9JcDZzNEZQeUpMMkJCSTVOSGhCSmFZQitn?=
 =?utf-8?B?MWhNZ2k2eHNON2tsaGlrZEJJTFJEZE9PT2RUTkZOTHAvRGIwcWs1a1V4V005?=
 =?utf-8?B?QkJxdk4ySnd2VnhFMUdTS202Znk0SWh6RnZTdFdoS2ErVFRKOGRwdm1LbTFq?=
 =?utf-8?B?N3FKWVUxMGhRZThaeExnQlFPUGcxUkRKSktPNStHNzczRWUvOEMzNlI4WDdp?=
 =?utf-8?B?VENXTzZidCt3SUxyeld5VHJuOXl4dkdLcGdWeVBXVms2YTNTUi9mOXdvTDAw?=
 =?utf-8?B?Um9MRmtmK3BiVHpmbHpuL2ZVUnM0dTJhNWhTSFJiNmUzUVlzc2tWbVE5NldO?=
 =?utf-8?B?MkJIL0FYZjNvSThmWFRWUEVHUkowV0Q4dDRyZW1WOXg1SkwxMTFrbGxnVndq?=
 =?utf-8?B?bmdJQUpneEx3eVNnTVR6ckZBY2t5ZXRsNkh0b0E4ZFlKRHpDbGVWM0hSbEww?=
 =?utf-8?B?T0lmN1VYeWZzcU9YTlp1ZDNRYlkvNTNKZHZBNHd4SUJtNjU3U254blBSdGJ4?=
 =?utf-8?B?ZksxK2VsTE52WFduZzBRdVdtQmYxM1J4c2o1Z1VleUxNVW52d0Y5M1BEVW1j?=
 =?utf-8?B?Q2NFaEFvSTZDN040amtUNkd1NVpzNGw1cXd1Mi9lUGR3TVF6Q3R2VVpGbFZP?=
 =?utf-8?B?eVoyMys0T3BJa2RDOVJHRGZoZ09EWDRiNElHL3VUQ3pLU21TZHA4YnU2Vi9F?=
 =?utf-8?B?R01XYjk4WTgyUXF2YXc1VTluZThSYTB0MWlJcU1BL0ZKQWtub2lTMGFvU3lm?=
 =?utf-8?B?THhmMnZla21CL1hJRlFNQzA3V3NkeHFFM1R0TjF6TUFmeVc5dElwaWVjU01U?=
 =?utf-8?B?RDhtaThVMC9TV2djWm5qM0hGNUtMV3FXQnFJTzRhWjNQTWQ4eXBEbkhLTGlD?=
 =?utf-8?B?YkpLcGUvalBQWGVPTmkva2Jsa0g3Szd6WUtIbEYrU1R3Ry8wcklGQlAxOU83?=
 =?utf-8?B?TWhNOTUvNVpWaWVQbmcvWmFXTi9XVFVoQ2dRZ1ppWHJlQ3JCaWorVkxuY0tv?=
 =?utf-8?B?WFl1YXcxcjFwUjVjL0d0KzdJaEQrSGduSVhLR2VHVmR6TC9LWkt1bk1UbGJY?=
 =?utf-8?B?VGZYQzVUS2pNclJyZzRaeS8rVVVlQThQdUVEclM5Nmw1eWczRkNVa1dLbG14?=
 =?utf-8?B?bmNEOGE0TnMzek4rVXhteHlsL0ZNN3RDNVhjeUYyWXAxVk1NSkhyY3VXR1M3?=
 =?utf-8?B?YmRMdVNyVllnQm1ESXJ1ZjkyVzhtRlBGUzI3clNON2xvOHpvWGwzL2FXOXRY?=
 =?utf-8?B?ZWdabDc4WmZrMU1mUXYzNVY0Smk1QWF0K1hEMXJ5WDNhenhuaTg4d3VFbTE2?=
 =?utf-8?B?WWtiSkw3OVErSXpocUVzVHZEcHJTMVhMSlJxVXVhRlp2elVqa2ErWlN6S2ZN?=
 =?utf-8?B?NG0zODFxV1ZoWmhlbGxnM2xRd3ZncGtENnloRmNmOUxYdUd5RHBjdlBlVU5Q?=
 =?utf-8?B?ZDl3TmV4Z3lrbWdxR2U0RFJZbkFRSHQyclQ0Snl4UjJud2VJalRpekxZbEFU?=
 =?utf-8?B?Z3JEREMxMkErWlptdXNkU2xWRjFjRWFGK3dFVHF3ZS9idCtCY3FhVzdqUHcx?=
 =?utf-8?Q?sPRuDbBKjcptt?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UUp3dWoweTI3dFFQQ1A2a0dCS1VhM2xPYXhvWE05V2xHY1d2bnBoL3lhdlJq?=
 =?utf-8?B?UDRoWEIwZnN0V29hYzBpNTF2ZFlyNWNRajQxeUpYa3AzanBxNVBzd3ZVbVZQ?=
 =?utf-8?B?VTRkMlY5R3VPQTBGNVpWWlFEbnBPMkVLdXhLN2VVRkNSa1pDdlluTjhWOVdp?=
 =?utf-8?B?K2wrL1lIUUc5TGxxY253VnlFanRyMzlNb3FYR3cwZXFGSmIzWGRTcUZlcG94?=
 =?utf-8?B?ZUNRRy83MXBlUDU0TFJMSHRqc1RMYzlFdVE0Qk9TcDVIVkwxOGpBcm1ZZ0M3?=
 =?utf-8?B?ZVNRUzZpV1BrQTVUQ2M1N1lKdkpJd2REcXBRMzlaSE8rOTliL0NmSmI2NytB?=
 =?utf-8?B?d1VXQ3hyTTg5ZEI1NmhXblFBcjJvL2pvZEhjcExXQlJ1V2ltZGp2UWdaYUJZ?=
 =?utf-8?B?L0NhSHQxT1pUUnl4R20vekZQT2FCSkpZSW9QUFNvN2MvYXd5UlJrQ1B1T3c3?=
 =?utf-8?B?Qzd4aVF1Mlk4YVNRZnJ1M1hLWFhlUG5URXNwT2pyc2VZN2pqWk9aOFJZdDlw?=
 =?utf-8?B?V0ZqQisreWxFN2dNV3M0QU16ZGd4VE1yNEw2SVFGK2xacUdycVNUYUd4M0w1?=
 =?utf-8?B?VnNxdnUwRnA5OWswZlpvSENPc3lNcUQzalY3L2NEWnliYmdKQ28xTENNd0Ir?=
 =?utf-8?B?RThTSkNsTTlwamtCdE5MdHFvSXRXTUZ5bVhaZWVKdUxwNzYzMkxlMm4rMVE5?=
 =?utf-8?B?dCtqN3pBSkVyT3gvb1lMQndJYWJ2Wmx1YkVGS050Q0FvTHordmhOV0ZYa0JI?=
 =?utf-8?B?a1REMWM5Q1BCR2tENVF2VThJZDJuQWE2ZXhQVUZvc3kwK1hzZVFhR3hhekhU?=
 =?utf-8?B?M29tSFhZNG1PQmRkZ21pL0lOUjViMmhIS0VmSko3aVFlUlB2Z1U0aHlZQTg5?=
 =?utf-8?B?OHErT3JsU0Z1WmxQdTZVWnJvb0JRdVZSeWlXZVFqSW9vOTE5SnVwaVZUT3A4?=
 =?utf-8?B?cnp3TWlUY0tHTU5UakdwUGJoMjdycHl2SkJHNlEvaHJ2R0gxSzlZRjlXQnRq?=
 =?utf-8?B?M3JLYm1UV01iOExDbnBsZFhSUFRWWkN6R2I3SnZGcStyZFlCWVBUY3BtNFZp?=
 =?utf-8?B?ZEFWb25hbEprSTl1UDJSWi8rbkNPR2J4bHNNT3Rkd2s3SXRkNC9HQUROTEFV?=
 =?utf-8?B?ZGVGR3c4aS9ka1BPQnZtWXVIVGhuRURkTDBUU1R5K0pqMHk4SmplNTg1d1Fk?=
 =?utf-8?B?dzRPa3FkZ0hGTEROR3puUHoyRWhnVVZKek9jUzZRZUxIYmNwbEFzUlpIc0dE?=
 =?utf-8?B?a3N1WXRxTjFOSHdMOWpYZkIxOXZoM2JSbHBPaWRWU2FtYUNUb3VwL1I4dk1X?=
 =?utf-8?B?VmZKTWpIYkRoZ09VbFpCb1VDRkJ6d045VnY5MVVodGZkRnRtdXdMNXlUME5N?=
 =?utf-8?B?dWorbVE5VU1uM1J4RWhVdk5ONHp5T2xkSkR3RnJPbVRDS1laY0tLcldOKzc3?=
 =?utf-8?B?N0M5Ylk0cmNBZmx2Ri9CMU03WURsL2pleEhaUGxJOHlFR2JmSm9mYlNTUW1v?=
 =?utf-8?B?bGNQK3JYbHJYL09NS2tzUFptZTJHaFNGNzFnaDhWZjJvOUc3QjRQZFNMZ0FZ?=
 =?utf-8?B?QlVOeS9MdktDeHNGRkppOXlqUFRJV3BEaFJqditCL3VaR0N2Q2NGMU5DR3Y2?=
 =?utf-8?B?RTNxRlBZaGpzU21nNWRHQi9EKzdHS2tEQWJGb2hjeDZ4WTdSTTFVR1dMNVk5?=
 =?utf-8?B?NlF6TUkyT0oxRUJxWlAwNDhPL2xNWjFlZk5QQTVCRTFXWTFTNE5rK3ZkL2NR?=
 =?utf-8?B?bDBWdXh4c1ZUdFVzdkdzcTNoS1YxS0dIejFDQUZUL0t4Rkp2T2YzY1FlSEIy?=
 =?utf-8?B?cHNZaXprUmdFVmJ0dDlWTlVQL2JmcGtHM2ZveElXV1dnb2hybmJZdWRGT3Jl?=
 =?utf-8?B?RFYvT1RhbklxUGgrZENDVVY2VmdWVGNBS1c1UkNqWFpvdnRKZ1BRaEhJazVa?=
 =?utf-8?B?emNlSXVQa3cyUXc3dU1qRFY4TWhmRTJwMmZsQXErYjNJNnFTTmF6TFo2Ymta?=
 =?utf-8?B?R05BdG1sREJWMzU4TGtSY2ZpYlMyU1JuN3ZpUXVWS0VuV0loV2ZvRXpkRGo4?=
 =?utf-8?B?N0xNOHBvalV2eHNjbXp0b3ZCdWtRQzJrYjVIcTM2bENBTnFkSDNjVTVXenBL?=
 =?utf-8?B?N0lZbUdjdnBzQTNRaXIzdEovKzU4UmRvUTdRMFZQWSswTVE1b1Jvc0xjdXJv?=
 =?utf-8?B?OXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7+4CELfAiMmPyxAwHuXJq2fcd04c1itS27jbf73P5buJCh4npml4ruKW2tbY7G1O0noGpPIY+61UKsxRy2wGom82CxqDMj3EZtKZgjm1jX4lm2BCEZ3yoMhJe9D/QftKVpCC4L+guQtZmRIIAJd17Xt90w6i7U8Fq59NoM9dHheAU9XlfiluIiavbsRa3KFP1ws/wNORbNhFUrUXNX2TsSO/U67E9oTh5hwBX2ayJOWP5ZMReSOfI4MAX32kuwnmuP+7r3ZvdVfUKsQe9YrWyud69A+xk5Y8uR6rr2Kr2BC8ccijkAhP55m4ARkdM70+fh1U4jf3fzikIKELl/ZQCJ8ow0pbi+qqhUHi17zg62YE1VK/m3gbNJTDSh+GGwCr6KpCjd6Qm6Jep1kRlnDl63lDWsHwiAuly2IoySnHODUbKt7lEZ+tPYKvGMKqpuYj+saBvcP0lSVnUhYyN0NRZ/+zy18TrZbCVuv3PspAECLl32jSevzT/uqqutBCBMJWLnNkPBLWSa44z5DAWXrOiqIN8J7mkleVWPw0greHTCh4HnKhV/E6RXxN/2nG2tD6453l9M5GLbRsC07WkstJ/0aJqeM/1Waf8NsBJP963YU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37c2fde7-2eff-431d-fb39-08dd3bbe85fb
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 14:59:23.5329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nmMbjmmQcR/EwicI4RIGqCMf//1OuoCc4xuaBEVM5NDC6f/3nWTPG9FVSKhRyMm0ucx0WdGssnqLgsVlmNcpTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6657
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-23_06,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 phishscore=0
 adultscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501230112
X-Proofpoint-GUID: hPGQeUNH8tFMc0aJPqwlrIxA3PlnECY5
X-Proofpoint-ORIG-GUID: hPGQeUNH8tFMc0aJPqwlrIxA3PlnECY5

On 1/22/25 3:11 PM, Amir Goldstein wrote:
> On Wed, Jan 22, 2025 at 8:20 PM Chuck Lever <chuck.lever@oracle.com> wrote:
>>
>> On 1/22/25 1:53 PM, Amir Goldstein wrote:
>>>>> I am fine with handling EBUSY in unlink/rmdir/rename/open
>>>>> only for now if that is what everyone prefers.
>>>>
>>>> As far as I can tell, NFSv2 and NFSv3 REMOVE/RMDIR are working
>>>> correctly. NFSv4 REMOVE needs to return a status code that depends
>>>> on whether the target object is a file or not. Probably not much more
>>>> than something like this:
>>>>
>>>>           status = vfs_unlink( ... );
>>>> +       /* RFC 8881 Section 18.25.4 paragraph 5 */
>>>> +       if (status == nfserr_file_open && !S_ISREG(...))
>>>> +               status = nfserr_access;
>>>>
>>>> added to nfsd4_remove().
>>>
>>> Don't you think it's a bit awkward mapping back and forth like this?
>>
>> Yes, it's awkward. It's an artifact of the way NFSD's VFS helpers have
>> been co-opted for new versions of the NFS protocol over the years.
>>
>> With NFSv2 and NFSv3, the operations and their permitted status codes
>> are roughly similar so that these VFS helpers can be re-used without
>> a lot of fuss. This is also why, internally, the symbolic status codes
>> are named without the version number in them (ie, nfserr_inval).
>>
>> With NFSv4, the world is more complicated.
>>
>> The NFSv4 code was prototyped 20 years ago using these NFSv2/3 helpers,
>> and is never revisited until there's a bug. Thus there is quite a bit of
>> technical debt in fs/nfsd/vfs.c that we're replacing over time.
>>
>> IMO it would be better if these VFS helpers returned errno values and
>> then the callers should figure out the conversion to an NFS status code.
>> I suspect that's difficult because some of the functions invoked by the
>> VFS helpers (like fh_verify() ) also return NFS status codes. We just
>> spent some time extracting NFS version-specific code from fh_verify().
>>
>>
>>> Don't you think something like this is a more sane way to keep the
>>> mapping rules in one place:
>>>
>>> @@ -111,6 +111,26 @@ nfserrno (int errno)
>>>           return nfserr_io;
>>>    }
>>>
>>> +static __be32
>>> +nfsd_map_errno(int host_err, int may_flags, int type)
>>> +{
>>> +       switch (host_err) {
>>> +       case -EBUSY:
>>> +               /*
>>> +                * According to RFC 8881 Section 18.25.4 paragraph 5,
>>> +                * removal of regular file can fail with NFS4ERR_FILE_OPEN.
>>> +                * For failure to remove directory we return NFS4ERR_ACCESS,
>>> +                * same as NFS4ERR_FILE_OPEN is mapped in v3 and v2.
>>> +                */
>>> +               if (may_flags == NFSD_MAY_REMOVE && type == S_IFREG)
>>> +                       return nfserr_file_open;
>>> +               else
>>> +                       return nfserr_acces;
>>> +       }
>>> +
>>> +       return nfserrno(host_err);
>>> +}
>>> +
>>>    /*
>>>     * Called from nfsd_lookup and encode_dirent. Check if we have crossed
>>>     * a mount point.
>>> @@ -2006,14 +2026,7 @@ nfsd_unlink(struct svc_rqst *rqstp, struct
>>> svc_fh *fhp, int type,
>>>    out_drop_write:
>>>           fh_drop_write(fhp);
>>>    out_nfserr:
>>> -       if (host_err == -EBUSY) {
>>> -               /* name is mounted-on. There is no perfect
>>> -                * error status.
>>> -                */
>>> -               err = nfserr_file_open;
>>> -       } else {
>>> -               err = nfserrno(host_err);
>>> -       }
>>> +       err = nfsd_map_errno(host_err, NFSD_MAY_REMOVE, type);
>>>    out:
>>>           return err;
>>
>> No, I don't.
>>
>> NFSD has Kconfig options that disable support for some versions of NFS.
>> The code that manages which status code to return really needs to be
>> inside the functions that are enabled or disabled by Kconfig.
>>
>> As I keep repeating: there is no good way to handle the NFS status codes
>> in one set of functions. Each NFS version has its variations that
>> require special handling.
>>
>>
> 
> ok.
> 
>>>> Let's visit RENAME once that is addressed.
>>>
>>> And then next patch would be:
>>>
>>> @@ -1828,6 +1828,7 @@ nfsd_rename(struct svc_rqst *rqstp, struct
>>> svc_fh *ffhp, char *fname, int flen,
>>>           __be32          err;
>>>           int             host_err;
>>>           bool            close_cached = false;
>>> +       int             type;
>>>
>>>           err = fh_verify(rqstp, ffhp, S_IFDIR, NFSD_MAY_REMOVE);
>>>           if (err)
>>> @@ -1922,8 +1923,10 @@ nfsd_rename(struct svc_rqst *rqstp, struct
>>> svc_fh *ffhp, char *fname, int flen,
>>>     out_dput_new:
>>>           dput(ndentry);
>>>     out_dput_old:
>>> +       type = d_inode(odentry)->i_mode & S_IFMT;
>>>           dput(odentry);
>>>     out_nfserr:
>>> -        err = nfserrno(host_err);
>>> +       err = nfsd_map_errno(host_err, NFSD_MAY_REMOVE, type);
>>
>> Same problem here: the NFS version-specific status codes have to be
>> figured out in the callers, not in nfsd_rename(). The status codes
>> are not common to all NFS versions.
>>
>>
> 
> ok.
> 
>>>> Then handle OPEN as a third patch, because I bet we are going to meet
>>>> some complications there.
>>>
>>> Did you think of anything better to do for OPEN other than NFS4ERR_ACCESS?
>>
>> I haven't even started to think about that yet.
>>
> 
> ok. Let me know when you have any ideas about that.
> 
> My goal is to fix EBUSY WARN for open from FUSE.
> The rest is cleanup that I don't mind doing on the way.

I've poked at nfsd4_remove(). It's not going to work the way I prefer.
But I'll take care of the clean up for remove, rename, and link.

Understood that fixing OPEN is your main priority.


-- 
Chuck Lever

