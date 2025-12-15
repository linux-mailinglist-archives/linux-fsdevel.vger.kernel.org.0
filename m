Return-Path: <linux-fsdevel+bounces-71355-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E991DCBED18
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 17:04:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2E9BB3001820
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 16:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0764D33291F;
	Mon, 15 Dec 2025 16:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="H3ZTpvXO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TkdZIEO/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93FD2C0F90;
	Mon, 15 Dec 2025 16:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765814661; cv=fail; b=Sfn2wrp+GPQRuRZqWlqTyPSX3Jd4Z6ME6KVJ4iGf9OTZk4oQuar7rfevyggbRTCfXGSNrTB7rrujELTFMIbsw4P3z/PQ3QDHK0iGyPQLhASoSj0XnCZSZBQzjCN1Y6QVA/9iRYF/YNXZ26gv3L6aIYs4KuNgDA7tAs/xNePXvHE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765814661; c=relaxed/simple;
	bh=9HPHuqJCBWCl0RoO1KCOrmMGvw4+NxK2QblR00ZO0J4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OOIjtxjFBwvjZmPlADerXrRBlIfhVhjghc+GvB8inDH33zHHhsZJWIKZo8zq0241yFtDblnn7Sw5fAcj+TNLiQ94yw6sKqGhhi4n8+4KQcPS+kLAGZd4KepuLuwvZ1Qu63xQ3wr7bOHwVrl8xFZsxOzrSjxP4TVjhMOMl1IhS0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=H3ZTpvXO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TkdZIEO/; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BFFNpUB2398829;
	Mon, 15 Dec 2025 16:04:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=xj1DqEc2u/+4728AcmlY6d5yUyZwtrqS5cVpR47JdyQ=; b=
	H3ZTpvXOwWS1Dynfe+cWrpqeoYTmbTRpIbXZ6c4KZAFydRQu3Y1DcEHZwl+2P9+e
	8cvk6V9ti+83lrWGPHVCqmUqj0GYaxzVVg1acxx40alMg3fK/KvP6SUyNNrJYFWv
	0K9izHe8tD4aOgE9RUtclBsPGFvf+o8MHh9Kjuwcs7NOD0fXExJp2q3PmbnWpUMz
	UwNhBUfzRYCowTPu3kX3VPWd1pE6qXSgN95ms8XUMB+rG2VJq1Bpa5CF04oWFgzS
	kWPNWuG4UcdWxH1HtNeR4ixVwkHw4zRnQFZTBX/nTA/2+9YrnR2BNfbK6cNt71CI
	+GaF5EWonK2J+ltQGxdgZw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b10prj9ur-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Dec 2025 16:04:05 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BFFIi85025214;
	Mon, 15 Dec 2025 16:04:04 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013009.outbound.protection.outlook.com [40.93.201.9])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4b0xk9cbq7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Dec 2025 16:04:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sj0Th0BL30D+e1jjMIzSIXBbLgZVBKdZyakD72lcq3rfgOkFVWern2SNfBaFbLLUNJenLmLIoLNQNy4+oNm9U7dw/gjYt4GVN9kzMZbuvpsWNG8Slhr3Hi3oe3HxoDC2SmHcqkKVN5KhoARwjthJRLUzzMBTu0I9AWTCrBDoP4j/AoJGjAjorHxINy9HdUPQGc+Y1vlERe9N5YXDqgyLIXrs24L2+2k0u7+mF7lBZA5mxxLOesXb6To5veJjTukxsHKWtJkDqDShTeA8YkldkU0ysRjVgOc3+yx+iOki2vR2tjFqSITxU5aQ8jAc3wvdxbOPXF9lfFE1rf6i8VO31Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xj1DqEc2u/+4728AcmlY6d5yUyZwtrqS5cVpR47JdyQ=;
 b=MtWSN6HQxwtGCorZbhpEEKThFoqEaupVGrRfQxISGyReIKWQ5g2ZvwpA6k3Z3iwGDJkK0CBq9W/AzzKspjs8anbWGRuGWOXecQJfH2Qvdt+qxXHFpG2s/yNuBgnA3RWSDfMtYQZptsvoXSOmK6zVqtt+WZckb3+ZD1Tm9ek24o01zO368I46mKduaUAPig0G7uwslTdQ9RHH0zLkk3lx8w+gLE/TRqe0NQmA4H6n3nwQUFuF5qeyInuQSwr+dWIXen4ESfaqIs7L9k4mXqV7DoOaDLSCm8TcxFN54fA43Ae8E/wdQkTwJs78iczdtOhXJoJV8PiVTdTNQaOF1DaY1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xj1DqEc2u/+4728AcmlY6d5yUyZwtrqS5cVpR47JdyQ=;
 b=TkdZIEO/OLC94xLFdXRiwiDl+APa5sH21jCA5vs6+uoWagZD4yaEjY1hOmEi/3kPpTBY8BOztlbGUqm4NHPixYuCIykAtCfPyi73nCc5/QKOhqHoK5zrcubV2xoHd+pezf0n47YK1PxHrmXfG6SXkkRJ4nhfICKf65ew5SlO6Vw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by LV3PR10MB7796.namprd10.prod.outlook.com (2603:10b6:408:1ae::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 16:04:00 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 16:04:00 +0000
Message-ID: <02e4f1d6-f16e-4c0f-89d3-c75eea93b96f@oracle.com>
Date: Mon, 15 Dec 2025 11:03:58 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH 2/2] shmem: fix recovery on rename failures
To: Al Viro <viro@zeniv.linux.org.uk>, Hugh Dickins <hughd@google.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
        Christian Brauner
 <brauner@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Linus Torvalds <torvalds@linux-foundation.org>
References: <47e9d03c-7a50-2c7d-247d-36f95a5329ed@google.com>
 <20251212050225.GD1712166@ZenIV> <20251212053452.GE1712166@ZenIV>
 <8ab63110-38b2-2188-91c5-909addfc9b23@google.com>
 <20251212063026.GF1712166@ZenIV>
 <2a102c6d-82d9-2751-cd31-c836b5c739b7@google.com>
 <bed18e79-ab2b-2a8f-0c32-77e6d27e2a05@google.com>
 <20251213072241.GH1712166@ZenIV> <20251214032734.GL1712166@ZenIV>
 <20251214033049.GB460900@ZenIV>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20251214033049.GB460900@ZenIV>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5P222CA0020.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:610:1ee::12) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|LV3PR10MB7796:EE_
X-MS-Office365-Filtering-Correlation-Id: 90c3024f-39fc-4661-b855-08de3bf38f9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eTZ4UzExODcyb2dZbWVGNEZoVW1kYXJ3TExDMS9ldDFWWmJjdktSVlVLNDBk?=
 =?utf-8?B?OWU4dHhoRFc3NDZzU0R5MFV3aEtlYWdmd3pieXRpYnpkUUs4UjdrU1BZL3Js?=
 =?utf-8?B?N2RxN0dVeXhQMllCZVYwRE5KWFhITS9MWkoxSkt0c2Z0OXR2YjJtNnZSTktX?=
 =?utf-8?B?azc3a3p3bEZsSXBKN2JOWkJPS3EvQlBHVk1iRGNHanYrTUZsclo5SFEzUXVl?=
 =?utf-8?B?Mk5jajA4UHI4UU9TWXRlSHNlQVQ5c1FhNGFsUE5JNzVTWHNNZ3A2T2dzQm9Q?=
 =?utf-8?B?S2RMUERIUG1ZWlNNYmY4bE1NNDF2N0h1QUNtZzJVWUY4VUFFb1BDK3dSS1k4?=
 =?utf-8?B?bE85ZnVaK3FDM2lENHh3TkZJeEwzZ1pQUkUzM1pNYms0eTd0eS8vMHRJWVEv?=
 =?utf-8?B?MlVsVWVOc1g4VWwwVnlTMWQ1bjVya3l2THFKNXpvNWlxaVdFNVpqU1R5VFkw?=
 =?utf-8?B?RDAydi8vRy8waEh4WmtFQUx4eHlyblJVQUZwWEdjZEpiNDJXYmpyVml0UGRt?=
 =?utf-8?B?SU9mNEZaVGFkcEt5eVNFblN0WnJTM3FFLzNEMzcvTW5VRFAyeWlJR2NIZXgr?=
 =?utf-8?B?WmJpMHNib3FMTGNqT2tPaTE0bFZuNDI2TEFqdTJaNWxkZ3c3RCsyOU1oOGFW?=
 =?utf-8?B?NDkvSlEwOXUzWktNbmpzVklxQk03aitwUy9xWVJKTVY4Z1Q4YVlIM2dLbGRr?=
 =?utf-8?B?akpYRUpMTWpldFZjZWljSVpsZktzUmZZTFNsRmxoRHNPOHNOVVQ5NVpXNXNC?=
 =?utf-8?B?TEV5R2pSM1Z1VmE1SlNDTlhvRjNrU2F0SjF4ZnU0ZmxxcnlvWndBSFNvbEpy?=
 =?utf-8?B?dmt6a2ZEd2M5d0x4U0ZEOFpkeGZqSFVvN3JtMnBnUmpKM04xdmdYaHlMRmtH?=
 =?utf-8?B?ZExYNmhGNlduRGNsTy9TUkxQVnR1UklnMW1OUjQ2TTQxZHFGK3lKTG83QU5R?=
 =?utf-8?B?Uk4zbFVKVzM2bkJISmEwcXlqMUs3aE5zajg4N3B6M2JnYk13SFNhMTlSVkJX?=
 =?utf-8?B?VDJWdWZyVTdBQkJGRDlNbDR5N3hheUduQS9aYy9GRlVoVm5QeEtXSGswUzdl?=
 =?utf-8?B?andaUzBEbWlXOWFQRVhBcUxCeDh5VUM4cXI5bzB1NXhSR1FsYXdpRHVzbkE5?=
 =?utf-8?B?TVdib3MvNWRxaWFKWUNtR3ByY1A2Y0wrS2dOSCtRU20xM3dWRGx1MG8xbzVz?=
 =?utf-8?B?VktkM2FjYU1kS2Zrd2hQeDAxMXp2Z21XQmNVSk5SeUVzL3cwWUo0a2xoOVVv?=
 =?utf-8?B?Q3BQSXJiM1laTWw0M29nNWpidEJERzRPNTJNQTNhN2VpQlRQcFFYT01YUjJv?=
 =?utf-8?B?cXlaRWhHbjBzeXdML3Rvc3lKN2pFSDkvWFV5MHN4VS9jcTluUmY1TnlWbGdF?=
 =?utf-8?B?NWRWclpYU1J1Z0JtZWhvQjJ4cUoxRmYxS2dOOWczR2xGaVFVR0NEVlBlcHhY?=
 =?utf-8?B?bXRaU1FjQXJES251T2NoQ2J5UCtFNGhzbWFISHZnMFFyOTJ2K051b0hpeE1M?=
 =?utf-8?B?RXV6UC9VTHdGY2RWVjdFVUpFUW0ya0JQZW9meU5oc1NuUTdlVHd5c1pZbExC?=
 =?utf-8?B?UUNaTDBPdzZHRGtzYUNaVExsTHZFZ3o5YkY3WGw1ai9PZlZreXZQSGIyc1o5?=
 =?utf-8?B?bFlTQ25HV2dRU0lLaDltalNMWVlSdnNCTjhzeTN3MFQxak9jUjIwczBLWmda?=
 =?utf-8?B?b3QxcEVsRzlMOVVBbzZSNVBDL2EyYUQ2a2thdERQYUVPRVBScTU4YXVZc1F2?=
 =?utf-8?B?MmZXZVkrUDFSYXpKbXdjVXdLL3JWcXFqcjFaeE5XS2FNeGRmaDJNaGphTUF4?=
 =?utf-8?B?VExzM3JGNGxHbUcvRy9NY1Q2aUlVanBVZThhUEgzRVVvRnVTQ21kcWZVOWpp?=
 =?utf-8?B?bm13cGtDS3IwOU5QZ0JjaW5OcE5qTzlwRVdNcUJNSnIvWDQySm9xR1ZqdTk3?=
 =?utf-8?Q?VCYQS43L0s2euh1j4s4lBLyupHCB5xWn?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V29QdEpQNk9UbkxIQWN5SS95R3RiMk9lbGxuSmdTZHNHc0lUSnNnc0E2eE1i?=
 =?utf-8?B?Mit4QTE3QTJRTE9Ec3B4bHNmSmg3dW1XSG93MS9XL1VLaFJLdUJDTFZnd3JJ?=
 =?utf-8?B?ZkJRc0orZG9kUk94SVlMaUxVYXA4WXp2Rzh6ZVU1TzMzZzBoMHVrN2xDMEd2?=
 =?utf-8?B?T0RnL1hOS05ZOXA5T2pDWkRUWE1oMmNYVnNqcWNod0IxaW02Z2oyeFU2Tmpq?=
 =?utf-8?B?eXdSL1hzdHA5dy83QjAweHVEYjNYZlFqVVZwTys2TnJ5dTZGbmtBdWIvTklv?=
 =?utf-8?B?cGtyOThaRFRDTnR1cEN2RHNQNTdqeVdMc29DSXJNak4xMkN1ZzErU2lEQVZq?=
 =?utf-8?B?UTJKUnJaeFJNTVd2anlWSDFIUFozZ2hta2JiOUU3U3VFUk9pRnQyZHJMOEZw?=
 =?utf-8?B?UENFV0N2ZXVZYmYyeFVMRXVlUGtkY0JISDlBSE84elNJZTBlaHpycmlMQUF6?=
 =?utf-8?B?UmNSdEppRXpRQkJYTUpkaHJwOU1PNitnN2tLNVZhK0lteEhvRVgza0R2VVVj?=
 =?utf-8?B?cnVWVHM5WFV2TEdoRVk1clljTmNrTis2SkYzUGNMMUhFT0I0c0hxcVNTdlRZ?=
 =?utf-8?B?V0dLcy84Q3dobFhsMFdscis1VTk0TThGT3JTVkFnRTRNWktzMFFLT2xRT1ha?=
 =?utf-8?B?SzRwMnNhT0VlZ2ltSUhZOEU3SDZJS2IwWHIvRGJtN0w4Q1Q5eXhIS3pjMFdI?=
 =?utf-8?B?UUNmT2ExS3o5bU52c0l0NDZYY2plcmNNWW5DUjgrMi9VQ1lmeFhxS1ZHbnNB?=
 =?utf-8?B?eW4vbDYySlVBZ016MW51U1hNTHlhOTVodUo1UWxtOUo0SG5sNzhnbDBodnM4?=
 =?utf-8?B?NThQVDlUOWNtSy85aGRmYk5EUlBKK04wNy9oZjNPR0FmKytCeUtlWGc3dFQz?=
 =?utf-8?B?RmVqRVh3WnhJMVg1YmI1aWNKK3VONHVKU1dDRDBVa3FjL044ZFpWcVAwdTVs?=
 =?utf-8?B?dngxSTczZ2kwKysrdWcxanB1R3BscTk1S0pLRjBxZkd3RUpwbXU5d3EzY2FD?=
 =?utf-8?B?dG9SbHNNcTdlNjhzdnk2TUhzK29Xa2dYSURPdzFVTDQ3eEw4dGE1VG9HZjY0?=
 =?utf-8?B?aTlIVU55cDV1MkpIYkJ5azMrWnJQUko2dkhuVWZXdVlMMHNhVFdzNHdmQ3Zq?=
 =?utf-8?B?UGlqQ0h5dVh3WXlQb2w1N1JjTGR1cWgvL3p2L01PdUM2NExkdTM3Y0g5ZEhs?=
 =?utf-8?B?dHZOUFgxMzVDeCthaE1QYnJaVEJYaTVjVXN1bWRaaUN1eGdZMUZ3QTU2WXV1?=
 =?utf-8?B?SU9COXBqcjh1TkdNVHUwYWFEZEh4V0dWM2grSS9KMzdEaHZWdmhVeHA5NWww?=
 =?utf-8?B?N0tUMDNVRlk0NTVCZWJWMHFZRFJURWp3K2NEd2p0NlVhSE16VUNqa1RWeDlJ?=
 =?utf-8?B?Z2Z0MVF5aGRIWUtvamR5V1pkYmZFSG9XTFpYOGwvOEVqdTBmUzJuSGZ4dGZl?=
 =?utf-8?B?YXk4V1R6V0ZxclVPQUgxcEc4d1IzM3N0V08yVElYM1NOYWZXUnROQ1dMWWVi?=
 =?utf-8?B?T3M2WUluTVdQUzZ3RnNHYWk0Y3lUSkU3Q1ZvWGtZam5uVGlLT21uRUFoNCsz?=
 =?utf-8?B?S2J4UTVzQlBsOFNreXdEaGlEZjJ4SGoxc0E0bFFHZ3QxSktJbktDcXEySllM?=
 =?utf-8?B?WWZLSVltYWtBcTBueTFPbGZaL2pRaE1zanVXSjBySWJRV1ZQcVMrb1VSTDJa?=
 =?utf-8?B?aitDOGVZMWkxeDA2K3JZblkwMFNPZ015ZXhiQjZNWUg1SmFPdmRtNzZPNGZB?=
 =?utf-8?B?aDVyTnJaUm03ekVUZ1o3UVRiRWtHZFJTS21qcEpVMDFVcFVNbEQ0SFZSTkxQ?=
 =?utf-8?B?bXpCQ3ZsZ3RjZk9LQUhkay9KZ3BtdnhrbWNvYjROR3hmdGo5NXJnU08vekRE?=
 =?utf-8?B?ZENKdjI3MU5GT1pMZkRWYmJFNnlVUEhvWFhTeXRDWjFlck1MRXVUeS80Umkw?=
 =?utf-8?B?dHhNQU5uN05JT3lGdm1qSnNtcUdHSVRXb2JGeHVmeDZmelJ1M0lkeTRSKzdN?=
 =?utf-8?B?VS9TVUg5ZkZSM1FUUlBIU1g4bXN1NFZEY2J0U0dUeFVnT3Z2djN3YThlRU1V?=
 =?utf-8?B?Q204UlQ4bkhhbG5rbTYwbkY4N3JwSm1sRWx6cDJUZEkwTTZkTDdiZHpBZUVT?=
 =?utf-8?B?MjlKT2RnZHRpcEd0ME1yNW1ieTRyN0ZpZmJVcGRYNzFFeHZhNEZNaWY1L0RQ?=
 =?utf-8?B?dnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	OeFNu7LQAcnqo9o9a13mP3VzQrabaT2gT3BO7ycxNfsVGQ4r9wuY3wst6QaFpu9X8uRKN4j8fB6/xPfMO0GnybJca7ft+VevPvyg5iTlTGSklO2x6CsoJ0fSdGTpKdsTWCZmK9e1vv/FEqxYVVAPiYAUJzhG1bGtQsK6DhU7AtZHDuS1vwQv3gQ31XQKxhB5ezh5Um7YDUEhvIazuMH14ADFPnNTMnkI0VQFykbCQaLMEBQFiq1wyoK9x04A0qVmTsSKt0em4zSpWE2jTB7w2ufUQoSV91si3m6jwvvaAilvDpoq+p9Djoby7fE/7d5Pa8AKgIDdPRrwMatmrLccBE/ivHnB0sHiqpnpcIDDtdKtGM3sJx2rXPeZyUuKwKU8MfaZzU4A2N1XTCDqo7Vs5cr4fUUtmcS+t65y6XUblLz2QMDsW2fBD1ZmS8fVnLBz22c/pEDRI89f+kyNjrm+qUiY/HRytZKx5EVRF0onRHFjPNPnTlhowjasMeh2CgYZExSqKKy/zNW2RNemCELMar1t4Q5jIfX+WAveHTdj34H6l0GcUddMSnIAlJg0liAlNcQRpaWHxIDHDA7LZQH8Dhb/Nycy/wUZe3w4Pux7jw0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90c3024f-39fc-4661-b855-08de3bf38f9f
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 16:04:00.7228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m4VYpxqmB+yBAz+PtyFWu3F8bzHH0S8j7HerxY+nRgmqtuehSSBiLioZw7qtvsph+jgp+TxQIrsRzW2aK0A+7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7796
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-15_03,2025-12-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512150139
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE1MDEzOSBTYWx0ZWRfX3vW+9ocI/fBN
 7kXRmbVvhpkFotSU/LgYznDxJwLuPjDLXRzQ/YfR9OY3f+8Na0r51U08VUsvQcvVYFtcTvxnNNb
 PrTq6rWvkvMi7c6VjiKRgwuOkLjQqZTrxudVFxde4UKW1YJvMTZ5TurF0Oov3YNdrC4O/1tmtKD
 49glmg9+sGNic7PLOTPojsleitq8tCK6xLJKlenRTeYc0AuhUun31PPRAWAHAb+G4Peli8aMB9e
 9BN7pFlI1wcglfH03nzNwNgAS6CBj/7DaETZo3lkk7eXU5rDvbdxb7Yvd4bWggz1sCw3y2pQprz
 d0VVr6aF9VTqU9X2ayF9R8R7uVdwp+oUzjZpO5uMeRgULg5eYkoE4HE2zcJzey2O7FUmHQBWcX5
 CgYJ6SwfcScn9Y2fvpYAjhqMqjJ5Dg==
X-Proofpoint-GUID: o05mN8Oa45dh1b7aWykt6vDJ5HzbzBtd
X-Proofpoint-ORIG-GUID: o05mN8Oa45dh1b7aWykt6vDJ5HzbzBtd
X-Authority-Analysis: v=2.4 cv=dParWeZb c=1 sm=1 tr=0 ts=69403175 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=drOt6m5kAAAA:8 a=yPCof4ZbAAAA:8 a=vg8JRtLtKrb0S5RSmSMA:9 a=QEXdDO2ut3YA:10
 a=RMMjzBEyIzXRtoq5n5K6:22

On 12/13/25 10:30 PM, Al Viro wrote:
> maple_tree insertions can fail if we are seriously short on memory;
> simple_offset_rename() does not recover well if it runs into that.
> The same goes for simple_offset_rename_exchange().
> 
> Moreover, shmem_whiteout() expects that if it succeeds, the caller will
> progress to d_move(), i.e. that shmem_rename2() won't fail past the
> successful call of shmem_whiteout().
> 
> Not hard to fix, fortunately - mtree_store() can't fail if the index we
> are trying to store into is already present in the tree as a singleton.
> 
> For simple_offset_rename_exchange() that's enough - we just need to be
> careful about the order of operations.
> 
> For simple_offset_rename() solution is to preinsert the target into the
> tree for new_dir; the rest can be done without any potentially failing
> operations.
> 
> That preinsertion has to be done in shmem_rename2() rather than in
> simple_offset_rename() itself - otherwise we'd need to deal with the
> possibility of failure after successful shmem_whiteout().
> 
> Fixes: a2e459555c5f ("shmem: stable directory offsets")
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  fs/libfs.c         | 50 +++++++++++++++++++---------------------------
>  include/linux/fs.h |  2 +-
>  mm/shmem.c         | 18 ++++++++++++-----
>  3 files changed, 35 insertions(+), 35 deletions(-)
> 
> diff --git a/fs/libfs.c b/fs/libfs.c
> index 9264523be85c..591eb649ebba 100644
> --- a/fs/libfs.c
> +++ b/fs/libfs.c
> @@ -346,22 +346,22 @@ void simple_offset_remove(struct offset_ctx *octx, struct dentry *dentry)
>   * User space expects the directory offset value of the replaced
>   * (new) directory entry to be unchanged after a rename.
>   *
> - * Returns zero on success, a negative errno value on failure.
> + * Caller must have grabbed a slot for new_dentry in the maple_tree
> + * associated with new_dir, even if dentry is negative.
>   */
> -int simple_offset_rename(struct inode *old_dir, struct dentry *old_dentry,
> -			 struct inode *new_dir, struct dentry *new_dentry)
> +void simple_offset_rename(struct inode *old_dir, struct dentry *old_dentry,
> +			  struct inode *new_dir, struct dentry *new_dentry)
>  {
>  	struct offset_ctx *old_ctx = old_dir->i_op->get_offset_ctx(old_dir);
>  	struct offset_ctx *new_ctx = new_dir->i_op->get_offset_ctx(new_dir);
>  	long new_offset = dentry2offset(new_dentry);
>  
> -	simple_offset_remove(old_ctx, old_dentry);
> +	if (WARN_ON(!new_offset))
> +		return;
>  
> -	if (new_offset) {
> -		offset_set(new_dentry, 0);
> -		return simple_offset_replace(new_ctx, old_dentry, new_offset);
> -	}
> -	return simple_offset_add(new_ctx, old_dentry);
> +	simple_offset_remove(old_ctx, old_dentry);
> +	offset_set(new_dentry, 0);
> +	WARN_ON(simple_offset_replace(new_ctx, old_dentry, new_offset));
>  }
>  
>  /**
> @@ -388,31 +388,23 @@ int simple_offset_rename_exchange(struct inode *old_dir,
>  	long new_index = dentry2offset(new_dentry);
>  	int ret;
>  
> -	simple_offset_remove(old_ctx, old_dentry);
> -	simple_offset_remove(new_ctx, new_dentry);
> +	if (WARN_ON(!old_index || !new_index))
> +		return -EINVAL;
>  
> -	ret = simple_offset_replace(new_ctx, old_dentry, new_index);
> -	if (ret)
> -		goto out_restore;
> +	ret = mtree_store(&new_ctx->mt, new_index, old_dentry, GFP_KERNEL);
> +	if (WARN_ON(ret))
> +		return ret;
>  
> -	ret = simple_offset_replace(old_ctx, new_dentry, old_index);
> -	if (ret) {
> -		simple_offset_remove(new_ctx, old_dentry);
> -		goto out_restore;
> +	ret = mtree_store(&old_ctx->mt, old_index, new_dentry, GFP_KERNEL);
> +	if (WARN_ON(ret)) {
> +		mtree_store(&new_ctx->mt, new_index, new_dentry, GFP_KERNEL);

Under extreme memory pressure, this mtree_store() might also fail?


> +		return ret;
>  	}
>  
> -	ret = simple_rename_exchange(old_dir, old_dentry, new_dir, new_dentry);
> -	if (ret) {
> -		simple_offset_remove(new_ctx, old_dentry);
> -		simple_offset_remove(old_ctx, new_dentry);
> -		goto out_restore;
> -	}
> +	offset_set(old_dentry, new_index);
> +	offset_set(new_dentry, old_index);
> +	simple_rename_exchange(old_dir, old_dentry, new_dir, new_dentry);
>  	return 0;
> -
> -out_restore:
> -	(void)simple_offset_replace(old_ctx, old_dentry, old_index);
> -	(void)simple_offset_replace(new_ctx, new_dentry, new_index);
> -	return ret;
>  }
>  
>  /**
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 04ceeca12a0d..f5c9cf28c4dc 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -3247,7 +3247,7 @@ struct offset_ctx {
>  void simple_offset_init(struct offset_ctx *octx);
>  int simple_offset_add(struct offset_ctx *octx, struct dentry *dentry);
>  void simple_offset_remove(struct offset_ctx *octx, struct dentry *dentry);
> -int simple_offset_rename(struct inode *old_dir, struct dentry *old_dentry,
> +void simple_offset_rename(struct inode *old_dir, struct dentry *old_dentry,
>  			 struct inode *new_dir, struct dentry *new_dentry);
>  int simple_offset_rename_exchange(struct inode *old_dir,
>  				  struct dentry *old_dentry,
> diff --git a/mm/shmem.c b/mm/shmem.c
> index d3edc809e2e7..4232f8a39a43 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -4039,6 +4039,7 @@ static int shmem_rename2(struct mnt_idmap *idmap,
>  	struct inode *inode = d_inode(old_dentry);
>  	int they_are_dirs = S_ISDIR(inode->i_mode);
>  	int error;
> +	int had_offset = false;
>  
>  	if (flags & ~(RENAME_NOREPLACE | RENAME_EXCHANGE | RENAME_WHITEOUT))
>  		return -EINVAL;
> @@ -4050,16 +4051,23 @@ static int shmem_rename2(struct mnt_idmap *idmap,
>  	if (!simple_empty(new_dentry))
>  		return -ENOTEMPTY;
>  
> +	error = simple_offset_add(shmem_get_offset_ctx(new_dir), new_dentry);
> +	if (error == -EBUSY)
> +		had_offset = true;
> +	else if (unlikely(error))
> +		return error;
> +
>  	if (flags & RENAME_WHITEOUT) {
>  		error = shmem_whiteout(idmap, old_dir, old_dentry);
> -		if (error)
> +		if (error) {
> +			if (!had_offset)
> +				simple_offset_remove(shmem_get_offset_ctx(new_dir),
> +						     new_dentry);
>  			return error;
> +		}
>  	}
>  
> -	error = simple_offset_rename(old_dir, old_dentry, new_dir, new_dentry);
> -	if (error)
> -		return error;
> -
> +	simple_offset_rename(old_dir, old_dentry, new_dir, new_dentry);
>  	if (d_really_is_positive(new_dentry)) {
>  		(void) shmem_unlink(new_dir, new_dentry);
>  		if (they_are_dirs) {

Reviewed-by: Chuck Lever <chuck.lever@oracle.com>


-- 
Chuck Lever

