Return-Path: <linux-fsdevel+bounces-39547-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A918BA157B3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 19:58:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF9197A23F3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 18:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 056341A83EB;
	Fri, 17 Jan 2025 18:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SSE9o327";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="G94aIS8w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D8019B3EC;
	Fri, 17 Jan 2025 18:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737140284; cv=fail; b=r3wLr+BNGZxk72cwikOxf125Od67WURpEhTYji0wNjApPu+DW1y3ABSQmrSNBWMqOK3ce8buSWxMn9gOekhzA/pkaH3J5dexPeS3MebMBLJRPmvgZOgUDb3HbIrmHeVnbAx4y1Z77hkcbERxkURvf53L3HS6EOXuhA4/Phywdvk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737140284; c=relaxed/simple;
	bh=1DRYuGCthqpucgIjozdbtOeiwTM1t0gAUYmXylPwcAY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oGpyarobJ/2d8KPYCZAvgBk+QVwD+QKpeAkdRN8o/uxD7noiwJRcJAi0QqmDtIuaSlNfJThEt8RoNLyZG129nW7tejh+GetSMSrwQnJzKjDWNfmHlF9R3T/Nd5b+8A8sSagP61I9ex7OaierYKG5d7IkZPIdVMAzG68Zb0sRRy8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SSE9o327; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=G94aIS8w; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50HICJFH014161;
	Fri, 17 Jan 2025 18:57:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=2l75CU05iV2WnchKX/nq+enXSGDGZNY++CK+J/BJ8Uc=; b=
	SSE9o327NZzXHNl2cKaZnT3AIdVuCX3o9gNcm4/n2l3ilBO/Ct/EIwoT2VT8K0rI
	3r3gwyTWFxG+KSCezicJ0kyXPaBz4jab5DcyQ2MPvEdD8xKdxzvn3JbN8K1Hc0TO
	EWeDw+hCPfda3bWsg/xTBU9wxL20QgXcZWvgRtye2qVUez1KyFvZ+9KLP8T3Ekh6
	eV2i8rIqAUOa5aj2fYcRVZv4XxN68X21sLhIh7ILhuk0e2dgLlhymcMe5VR0ZnLk
	koypgKo8OOzLt6e22hJ1xQQPaViZi3BISWg3xfJfrcvEFMKvWgBKqC9GJ3reIVCN
	9t3j7tJjfQOYUjcWjQdwvw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4478pja3dy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Jan 2025 18:57:05 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50HIm7a0029894;
	Fri, 17 Jan 2025 18:57:04 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 443f3cgd0r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Jan 2025 18:57:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R9x8Zzpd8QF3+EsPHyPBiUB71UexmBFIqkPI1uHJKQEFrxtgoj+dJCenj5lazSsqQl76OhPTcVG9j+ek9mSUh6GIlftliqs4hfpAlUxmkrek5mo0WPjwrx/rTTQ9ktoAsBGhIczLBUoxRzuZ9E3A02ruw4KqEhEvqkv5umvWJOuS7R/uZXQK1cOi2TCtPf7sd3dEFEsx5j6Zlstoqf0jpgRXV1scBhgvDymq3Yu0t67NezVchW8mXJR2pTd3COvYFbdnF9dcjppbcAT7O6xXFrtcrxMiqcGJYdKRLLGtUJyZT3kIbkPJbI6Z/0wWeN8YyN8DkilVJQiAlZ0m1aW0qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2l75CU05iV2WnchKX/nq+enXSGDGZNY++CK+J/BJ8Uc=;
 b=Na52WjX+rzH9zRKb1YnMYDtIpochDIuBzC9kwxD+jNIzAhqOTI/wwq8w5poaVNTKVCmwq28Am5O7CpYiOpzzyVQU4VFd5pLLYhPCdEk+KgOhdjHJiMKEwi2WvdjiLn75Wm1zICrgdnNbE3c6FAKsXoUh6x97HTsnGZFCq/gPdyqnu/tsY+WO2N7m3RkKXx22NHtVN1iTVRg2+1q+7UMs6nm2PSDD6X/KxwQ7bvc/PIackHmjoAtRNtaDHgur3jMsGHCis4tgYFF/xuIGl22gpDhqV+t5fhnso+JhWa7FKljcwtk7RNX6DatiK6s7A+GbCHXZYKyEyFsbFvPDuMLO3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2l75CU05iV2WnchKX/nq+enXSGDGZNY++CK+J/BJ8Uc=;
 b=G94aIS8wupn0nzUBM3QD0pFcpgpPxklQtGA/n2JzhTYF+IyG5AJD7jQD2iCF0pHVXbnmpGPNGt6UhK4OIWkgo5DKPhsRmkCuOKJmhFQnZz7YG60UF9Es74X6HFxskgWBxgbDSYEe81Ge+/++fwjmhxxqJzn9cI3mUwijWr1MOVA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB7347.namprd10.prod.outlook.com (2603:10b6:8:eb::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.16; Fri, 17 Jan
 2025 18:57:02 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.8356.014; Fri, 17 Jan 2025
 18:57:02 +0000
Message-ID: <62a69db1-0713-4153-958d-df4c9cc7a86e@oracle.com>
Date: Fri, 17 Jan 2025 13:57:00 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/24] crypto: Add generic Kerberos library with AEAD
 template for hash-then-crypt
To: David Howells <dhowells@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
        "David S. Miller" <davem@davemloft.net>,
        Marc Dionne <marc.dionne@auristor.com>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Eric Biggers <ebiggers@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
        linux-crypto@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250117183538.881618-1-dhowells@redhat.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250117183538.881618-1-dhowells@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5PR04CA0023.namprd04.prod.outlook.com
 (2603:10b6:610:1f4::23) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS7PR10MB7347:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f62da33-f23e-4dbb-d751-08dd3728ba5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZVBEL1NVRmZzZFBOeEZ0V3N2eWhMWXRUc0tuYWh3Z1k2WEZjVFFoYWYxRDJq?=
 =?utf-8?B?WU9rL3J0eUtTNVhFcW5PRTk3TGRCc0pwQ2FjWjVtZDNlZlRJTFEzbHRuTWQz?=
 =?utf-8?B?OG53ODJOTmpnZTMzWGV2TlhKekVaSG9ob3NSL1R5b1lSMFVGL2EzWGhOa0pB?=
 =?utf-8?B?WVhiL2tFbHVDRkFzWkdHa3FHaXdnR0tsQUtxbGh2NStxZkZSODIySE1kOWZH?=
 =?utf-8?B?ajdzNytuenNRUWxpZitBVFZ1QTdycXVaOHc0T0E3Y2UxeHBybTJFYzJyTHc0?=
 =?utf-8?B?TXdXQ1ZkeGpjbHVaOXZBb0tzOUJRT0pFeWV4eWQzS0JLenpZR0FCRmV5UXpF?=
 =?utf-8?B?ckNyclJZZTBrOTNGbWZTbERzTS9BaWJRL2IwNlpsQ0FGK0xJZ1JOSFpUNXJS?=
 =?utf-8?B?alJOOUtpN0FEcDNsa0FwVDhwTS80c0tPOWNIQkNDdWRxQkptWjBBbU5QMkNi?=
 =?utf-8?B?QVpXcTRUUi9URmpHdlhyQmNZdXg1cHhtNWdUTWxrQlA3MmtVUy9ldGozVUVi?=
 =?utf-8?B?ZThuOWQxaG5IdVlwT3dIMVk0K2pydHhIMkJoZ3BlbXA0SERLdDFWTnloZkN6?=
 =?utf-8?B?cVNKbVJqZ2FNRE5GY0FMN25Xc0J2eGF5WU1USml0Zy9rWmZPUXk2MkhhMnla?=
 =?utf-8?B?NWQ5RERyVzFlbVBoM043VEtoUXBBci9SZldmdkJxRHBJSlB0eVdNVy9CdFlB?=
 =?utf-8?B?dzdFSU1zWSs0VEl0eGdGQXFsWGhXRVlIZGlYU0lTSXJIREpGbW5lVVJEVnBH?=
 =?utf-8?B?dmc3NE14M3lWRmwvVFg1YUdCQzlGTEE1UVc2L1F6QmNOY2tvc2FrOUgyU2Z0?=
 =?utf-8?B?MURvTzNXc0V1WVRyNlZzaWVwT21OejFLcDlUUXVIdGYwdE5HZXB5SVZhUUl4?=
 =?utf-8?B?Q1FkTmJyenllY1laR2JuT2lhSFlYMjViR2hqTnFxYW9KOWg5VWRMeFNzUmZu?=
 =?utf-8?B?Zkc5ay9VSmo4MmFFTFkxS2RZaUR2ZFUrcnlXWXJ0V2p0Mlk3SkFENW5FczNw?=
 =?utf-8?B?cEVodUNxSnVQV2hSaG15d0tuWmx0c3AyY3lTTWJjWndOY1JUcGlGZGYyYllC?=
 =?utf-8?B?VmljNEJNL2hWenlyeDRiZzRDRUNTN2dBS1NmV1V1QVJpYWZnWEE5cDI3VWRI?=
 =?utf-8?B?MDE4L0xFWUxpSExYQmJyZ1pCMVBhR1BSNFcza0YxZ3ltK1dWWUxIV1ZkZy9y?=
 =?utf-8?B?OC9xNnY3VEhLV1ZVYloyem96ZkJ0anlSVWJ4WnNBeXdwMzg3T1RTMGdpV0E5?=
 =?utf-8?B?L25tK0Y1ZzZ2bmlLc28zdFBoRzhoa3Z0MTZDSDJLbnlsYVdwWm5BQnZBVGlN?=
 =?utf-8?B?QlBCakk3bVdnMmFyajJya1I2MktzV3oxRndXYkVoMkJ2T2dCMjRKakdCd2dU?=
 =?utf-8?B?NUYrZFFSSDVrOVo4empldnV6VHVLSDI5dGRTOC83VFM4MVV6c2FRQjVUMEcv?=
 =?utf-8?B?eFNTNytLWjVJODluMlh1Q3BSQUZHMXU1WTdVTFpWcDRhSE1pRmVsRCtqQWRI?=
 =?utf-8?B?KzZaVm5XMUV2clBLUWJJUFVqQUFtWk1MOXA3WUlMdHBIUkJUWHBZeno4aXNk?=
 =?utf-8?B?TXE3M2VnMVNsWnAyY0k0VXdOSi9wOGxIdjdVdUhWRHVlZzAzZXdKdWlDWHB3?=
 =?utf-8?B?STlzTmwwbmUrRmFHTGZaL1M0Y1Rud1NONzhVMkVSR3UzanhnOEN2NzFheEFr?=
 =?utf-8?B?ZWxSQzRZTjVoQXViRnB6eloxZGNhUmxDaFVyemlacUVFOGtWai9UM3dBbSs2?=
 =?utf-8?B?emlHRndnOUhCRStvdU0zeURyakFNUHBwSmw3amZqck84SmduaFUycnk5RzFV?=
 =?utf-8?B?MUE3U0doVWVzenNIcDNlZExmSWpYZ1RQNWpybTJGR0tyaTQ0dC84NWFDVHJQ?=
 =?utf-8?Q?udpsfLQDB0Eka?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QzJabHJyRU1XU3M0ejVyU3ZuYjcxcnNkbTJzSjhHSWdkYmZCSXFveG1hRGxZ?=
 =?utf-8?B?aXc3UlhXZi9UTDRjZElrOHBwbVJyRklROWU3MG5Pc21DMWlKZnlsdkpWK1ZH?=
 =?utf-8?B?bVN1OWFjajNmWkZVZURicmc4TnhTbjc1bnllZVpCb3FNUkxiV3lYSGNUeFR0?=
 =?utf-8?B?Z0RJc3duQ2dxQ0hzNmZSZXozZWpYM2c2WWdkY2F1VlRTeGk4YmdCR2FBQ0Iz?=
 =?utf-8?B?WlBPdzNaYlBhd2RhRlRwaE01NzB0Q2lKYzFLY0habjZTTjhvVUQ0UFROdGVl?=
 =?utf-8?B?ZzBqczVwYXN0L2FQY0dyc2RtdnFBTll3TXNlVmNJQkJGc0crZGZXNzQ0K2o4?=
 =?utf-8?B?Vk9peDBhME9sN0paUUJmeHgxQmp0dnJyd0xNYVhubEVSdVo3YXpTZ2pYQTBz?=
 =?utf-8?B?ZlhzbFZ2V0xzV0sxd0t4Q1lCd2xwNU9zOWJPcmhnMFVDdzBYSUhBSjZQWmlq?=
 =?utf-8?B?aVo4dlo2N1VzNExRRFpvTW1tTDhaL0ZUTmdyd3hyQTJDN3VBQVd2VUVXOHJr?=
 =?utf-8?B?RGRDSUM0SzNoMkhiY2xNYjNVdHNLQWRnQm11WHVLWnRWa1JsVnFVaEVySUM2?=
 =?utf-8?B?WHEvYk16aHZsZVJHdzNGNnVEZkt3cllYTFhJTXlmN0J4djZvL1ZBK2pZNXp5?=
 =?utf-8?B?NFBkRVRoY21XeGtzd3pjdFFUbmlwNlBteVZlVmQ1M0hrdDJuV3JSWXJzTzcx?=
 =?utf-8?B?M1Myd3NtZ0dOVXoxN0JaZGNNOEErZXJaSUluTDY4N1B2QW1kOW1pZXhMY0M1?=
 =?utf-8?B?VzVodDQ2WGhFZmxCT0tZUzZSUTNPSk55b1pMTzgxMGFYaElzTmd1a2dmN0Iw?=
 =?utf-8?B?T2FZVjlIeXdSdFFadFJjeFVteHhlMzNNc2Q4UmtMVmwxcmhVbEZ3a0VhUWVJ?=
 =?utf-8?B?R0dKd0tQa2J1bzEwVXB6UVBzVTR6cmxNYm9WZWFyWmk5QVVYa3hUM2hpR2M4?=
 =?utf-8?B?bG9aMDRYNHA1U01RZFBwYlFzTkc4enFLbG9MaWlBTE04T0RoRW0xK1RpN3A5?=
 =?utf-8?B?V0F1MU9HdmQvVVFTUHNjalU1aU9UZHlzTWpNTlp0K1U2ZXY5cyt3a2lyZWU1?=
 =?utf-8?B?eG9xSUh3YVZYdW5yNXZUekNRaGZEMENYUjhZSVlPdC9MVHp4aXhsWi9IaUNU?=
 =?utf-8?B?RnluaVQwN01vOEtpcmVoOWtFbWVINzk4dStWMzFUYVk2a2FWeWdpSnhycENF?=
 =?utf-8?B?YkhTT1NudTNTUUkyWjJldjlhYTVpYXRSNTVaTUtiamh6YlcrdXFnRHFZREZP?=
 =?utf-8?B?d3o0b3dsOGRFeFZVZVZQM0RyNVlncjVqcEE2QkVWUjFudll4V2dWYUhKckEz?=
 =?utf-8?B?WVBOMGVtL1lnNDFWWlk2OTJnekY4WmdIMy9yeGt1QVQ2SXFtNFRYTG0yREZ2?=
 =?utf-8?B?VktIL1lUcnJ6SDhRc0M4dElhL2NQbzJ0bFVtRWtpTlZmcy83Ujg1dG05NkYz?=
 =?utf-8?B?MUg5cVBPSUxBY3Jsb01sNkJUQ3Q3SU1CWGFyV2RFeWMwVC9EUHdLZWxWZ1Zk?=
 =?utf-8?B?MWVuazNwa1NNUGlWRllRcEhhSTVVUUd6SDhKbklieFp0WWFzYzFjYW9KTmti?=
 =?utf-8?B?ZHhKdEdLUVJORllicWlkeFlOYUg4K1M2MlBhMW80NTY3OWtHUkZPZU5ESDBP?=
 =?utf-8?B?VDd1aUpHUFFES1N0RkdqVEQyekZnWWFxLzk3aEEwRlEwNVhnQlVZeVBTTEs5?=
 =?utf-8?B?TktCdi9KWHBPeFgySTZ2RWltbHJ6TjNWTzVWVjhMWTJVQXhNM1ZFZzFCZkh1?=
 =?utf-8?B?akhSV3pBSU5uZEFPNFV4Q29CM2REem11TlNiN1RJMEc0YWxuVDhhYVl1WFFp?=
 =?utf-8?B?QkhxT202VFpLb29kQ2NlTEFFL240eG9ZaDZ6WEJMallxMmFva2IyNHRROFBC?=
 =?utf-8?B?aDdHZ3o0Vm9RV0FwRlUwb29xMzFqM0czdlVzQkd6TnVYR1VQN1lPSlYyakVH?=
 =?utf-8?B?YnA0eGxySlIzbTVIUVc1ZDJaVVhnai9LQVJERjJGMUc5YTdmVTBZUmVPMUhu?=
 =?utf-8?B?OFloeld5Zlg2SzkzSW1vZXVUOWpIbWsrUTZpNXV4NWNoTVZDTHpKeldNOGpX?=
 =?utf-8?B?KzlnNlI1Nzl6Qk9lUFJ6ZGg4UTRVQTJwZmZGM3BqbjRVbnRNN2sreFlSczJ0?=
 =?utf-8?B?Y3ZOZFdGblF0a1lncU9mM3FaR0V0Tlk0SlNMQTdiblNmTzZNSUY0S0tsT1Vw?=
 =?utf-8?B?NUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	sunfkse//FodHMz+VHVcoHgiAQhVY9QQkbIiK/V4HdAKQHGiSRJA3Q6NptdatAuU3VGV3MlqeUMDH6lZVllNeBIhpeAS8zfEKfY4QkKDougJVU5o2tJWDjar0p5J13GcgeR6ne+HNx87kSzn5C1pmv/tes59TZnNxDZGI/ZCzmGdi/K6Plmz2wREKywRsA0DzYREVgQJHIzUjJFGvAyIk6yvOZWqoqCWkMkSzySkOAT5CDiFs6ogi5AkeqFEUuySZlnnjJhpKikWQbqTTsbpzP+ftnjkeQVtGVocmf0/T9ieh0TP4fN2WyJd6GtbP6dXt7PZdgXfgDJUPi6UbONOrYmX7scq+gnv9wUuAN4+Ie9jK36VqCyTpHs8AmhdcD3uqHDwLy8kOHlm3me1sgnjjjw6D54LCPQLBI4U7lQ4z45POAn71y/dA/qGpYmx9iC0gzN8BZfTPFvAuTnYKhob+/bhSn3O9u3hibu5S66V7x57CDtglrWdNfPWZ3XE4x9ZZpxVpcSPrYeXfhVRbVT3ojzGYikvQ8Rjz+3s3JbMf11fCG1bj+O/c2srsEoXHgKJPyL56ffFQ9ZTK/fEmZzLKKdaSNYbtLSzE4cqaFvdrUE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f62da33-f23e-4dbb-d751-08dd3728ba5c
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 18:57:02.2443
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vOSWcCZLXfiQrwG6Ck2RtYwRuVk/9gZ8+vKhe5yxyHXPJP8N+1QLF5rmfwontpkfdHKOW5ocLIbCueigJLUhDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7347
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-17_06,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501170148
X-Proofpoint-GUID: YXY1Zz5wmd2JO7MvLcKWIg6EztrTRZto
X-Proofpoint-ORIG-GUID: YXY1Zz5wmd2JO7MvLcKWIg6EztrTRZto

On 1/17/25 1:35 PM, David Howells wrote:
> Hi Herbert, Chuck,
> 
> Here's yet another go at a generic Kerberos crypto library in the kernel so
> that I can share code between rxrpc and sunrpc (and cifs?).  I derived some
> of the parts from the sunrpc gss library and added more advanced AES and
> Camellia crypto.
> 
> I added an addition AEAD template type, derived from authenc, that does
> hash-then-crypt rather than crypt-then-hash as authenc does.  I called it
> "krb5enc" for want of a better name.  Possibly I should call it "hashenc"
> or something like that.
> 
> I went back to my previous more library-based approach, but for encrypt
> mode, I replaced the separate skcipher and shash objects with a single
> templated AEAD object - either krb5enc (AES+SHA1 and Camellia) or authenc
> (AES+SHA2).

I'm philosophically in favor of sharing this code. One of the biggest
benefits will be making review/audit easier. Another will be the
opportunities for more hardware acceleration.

But I can't tell if the library API as laid out here will be a good fit
for SunRPC and our kernel XDR implementation until I actually try to use
the API, which I don't have time for right now. The set of enctypes
indeed seems sufficient to support GSS-API Kerberos, and that is a
fundamental requirement for us.

The Linux in-kernel SMB community might be interested in sharing some of
this too, though they seem to have grown their own enctypes. The Cc list
on the thread is already substantial, but they should be included.

I think it would be fine to merge this, as long as the crypto folks are
happy with it, with its current single consumer (RxRPC), and then we can
explore broader sharing.


> Apart from that, things are much as they were previously from the point of
> view of someone using the API.  There's a new pair of functions that, given
> an encoding type, a key and a usage value, will derive the necessary keys
> and return an AEAD or hash handle.  These handles can then be passed to
> operation functions that will do the actual work of performing an
> encryption, a decryption, MIC generation or MIC verification.
> 
> Querying functions are also available to look up an encoding type table by
> kerberos protocol number and to help manage message layout.
> 
> This library has its own self-testing framework that checks more things
> than is possible with the testmgr, including subkey derivation.  It also
> checks things about the output of encrypt + decrypt that testmgr doesn't.
> That said, testmgr is also provisioned with some encryption and
> checksumming tests for Camilla and AES2, though these have to be
> provisioned with the intermediate subkeys rather than the transport key.
> 
> Note that, for purposes of illustration, I've included some rxrpc patches
> that use this interface to implement the rxgk Rx security class.  The
> branch also is based on net-next that carries some rxrpc patches that are a
> prerequisite for this, but the crypto patches don't need it.
> 
> ---
> The patches can be found here also:
> 
> 	http://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-fs.git/log/?h=crypto-krb5
> 
> David
> 
> David Howells (24):
>    crypto/krb5: Add API Documentation
>    crypto/krb5: Add some constants out of sunrpc headers
>    crypto: Add 'krb5enc' hash and cipher AEAD algorithm
>    crypto/krb5: Test manager data
>    crypto/krb5: Implement Kerberos crypto core
>    crypto/krb5: Add an API to query the layout of the crypto section
>    crypto/krb5: Add an API to alloc and prepare a crypto object
>    crypto/krb5: Add an API to perform requests
>    crypto/krb5: Provide infrastructure and key derivation
>    crypto/krb5: Implement the Kerberos5 rfc3961 key derivation
>    crypto/krb5: Provide RFC3961 setkey packaging functions
>    crypto/krb5: Implement the Kerberos5 rfc3961 encrypt and decrypt
>      functions
>    crypto/krb5: Implement the Kerberos5 rfc3961 get_mic and verify_mic
>    crypto/krb5: Implement the AES enctypes from rfc3962
>    crypto/krb5: Implement the AES enctypes from rfc8009
>    crypto/krb5: Implement the AES encrypt/decrypt from rfc8009
>    crypto/krb5: Implement crypto self-testing
>    crypto/krb5: Add the AES self-testing data from rfc8009
>    crypto/krb5: Implement the Camellia enctypes from rfc6803
>    rxrpc: Add the security index for yfs-rxgk
>    rxrpc: Add YFS RxGK (GSSAPI) security class
>    rxrpc: rxgk: Provide infrastructure and key derivation
>    rxrpc: rxgk: Implement the yfs-rxgk security class (GSSAPI)
>    rxrpc: rxgk: Implement connection rekeying
> 
>   Documentation/crypto/index.rst   |    1 +
>   Documentation/crypto/krb5.rst    |  262 +++++++
>   crypto/Kconfig                   |   13 +
>   crypto/Makefile                  |    3 +
>   crypto/krb5/Kconfig              |   26 +
>   crypto/krb5/Makefile             |   18 +
>   crypto/krb5/internal.h           |  257 +++++++
>   crypto/krb5/krb5_api.c           |  452 ++++++++++++
>   crypto/krb5/krb5_kdf.c           |  145 ++++
>   crypto/krb5/rfc3961_simplified.c |  791 ++++++++++++++++++++
>   crypto/krb5/rfc3962_aes.c        |  115 +++
>   crypto/krb5/rfc6803_camellia.c   |  237 ++++++
>   crypto/krb5/rfc8009_aes2.c       |  431 +++++++++++
>   crypto/krb5/selftest.c           |  544 ++++++++++++++
>   crypto/krb5/selftest_data.c      |  291 ++++++++
>   crypto/krb5enc.c                 |  491 +++++++++++++
>   crypto/testmgr.c                 |   16 +
>   crypto/testmgr.h                 |  401 ++++++++++
>   fs/afs/misc.c                    |   13 +
>   include/crypto/krb5.h            |  167 +++++
>   include/keys/rxrpc-type.h        |   17 +
>   include/trace/events/rxrpc.h     |   36 +
>   include/uapi/linux/rxrpc.h       |   17 +
>   net/rxrpc/Kconfig                |   10 +
>   net/rxrpc/Makefile               |    5 +-
>   net/rxrpc/ar-internal.h          |   22 +
>   net/rxrpc/conn_event.c           |    2 +-
>   net/rxrpc/conn_object.c          |    1 +
>   net/rxrpc/key.c                  |  183 +++++
>   net/rxrpc/output.c               |    2 +-
>   net/rxrpc/protocol.h             |   20 +
>   net/rxrpc/rxgk.c                 | 1170 ++++++++++++++++++++++++++++++
>   net/rxrpc/rxgk_app.c             |  284 ++++++++
>   net/rxrpc/rxgk_common.h          |  140 ++++
>   net/rxrpc/rxgk_kdf.c             |  287 ++++++++
>   net/rxrpc/rxkad.c                |    6 +-
>   net/rxrpc/security.c             |    3 +
>   37 files changed, 6874 insertions(+), 5 deletions(-)
>   create mode 100644 Documentation/crypto/krb5.rst
>   create mode 100644 crypto/krb5/Kconfig
>   create mode 100644 crypto/krb5/Makefile
>   create mode 100644 crypto/krb5/internal.h
>   create mode 100644 crypto/krb5/krb5_api.c
>   create mode 100644 crypto/krb5/krb5_kdf.c
>   create mode 100644 crypto/krb5/rfc3961_simplified.c
>   create mode 100644 crypto/krb5/rfc3962_aes.c
>   create mode 100644 crypto/krb5/rfc6803_camellia.c
>   create mode 100644 crypto/krb5/rfc8009_aes2.c
>   create mode 100644 crypto/krb5/selftest.c
>   create mode 100644 crypto/krb5/selftest_data.c
>   create mode 100644 crypto/krb5enc.c
>   create mode 100644 include/crypto/krb5.h
>   create mode 100644 net/rxrpc/rxgk.c
>   create mode 100644 net/rxrpc/rxgk_app.c
>   create mode 100644 net/rxrpc/rxgk_common.h
>   create mode 100644 net/rxrpc/rxgk_kdf.c
> 


-- 
Chuck Lever

