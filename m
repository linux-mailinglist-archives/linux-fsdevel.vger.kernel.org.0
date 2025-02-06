Return-Path: <linux-fsdevel+bounces-41055-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C7EFA2A641
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 11:43:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EE9116699F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 10:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01823227587;
	Thu,  6 Feb 2025 10:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZfyC3Xdu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cqwfBvPL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C49518B03;
	Thu,  6 Feb 2025 10:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738838610; cv=fail; b=cnLVYl4p31HKkqIZ7DabAkpPqM5erE9l+p54w3Nnf56njd9ol2QaQHa78nk+NngI1m6gFWeddSIkpD79WWJqKL761/PCAPstaN2u84jO+qzmLdNEBXFuA3yXfCjUjXxPDjq5oOWXAYOYvRo09OnLkAKdgQDZYe+NlJatSdszjsY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738838610; c=relaxed/simple;
	bh=ZFdqxmVZCbWbCnaTmXReMBP5I9lAjjIIBRm+3aVKokg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Bmlkf/8nuUGMo4u3nylXydnogvxElOPqz6k+wnJOL2Ez91M623DEhqTXQIbKwK3gNIwnbF3b7qkBIU84+aLokgxDaIhMaBjpcd1iNlYdnA5bnUg8MHLG0TtjCunHYtZsK2F1xGs1wUJQ/nAjyT04x9z2VbzDcAdeliVDfPBTBLI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZfyC3Xdu; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cqwfBvPL; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5166B7oL032706;
	Thu, 6 Feb 2025 10:43:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=CcKG6Nx5PDOISVE2muvOmeYdIsTGXmCemF9FaVsKD+g=; b=
	ZfyC3XduvYdIlsvnTEsEnZLjj33E9DGnJs1s9flLghitZtn+RrTj4JIvjjUwR/TQ
	oVjsA7t35DxG71DIM7ROZunUbdJ53TDX8e1POZiD5LzVfTwQ9LhD1TwEsIpe9eT4
	GObx9dAUVGMBh8LlhYuOFBvhsejsLpQn3exmdM3BRp0exAcNfsgE9SEqDs4wlcHE
	Uj5008QlLa/VyEesQzoCbxtatriBsxzoGmnLK+3keywqBCRsuusHZwVOsETBBgd6
	4NncIrAsGGt4hrL6GfVeRIotEBt60Mco7c5i52THU0juoKhJkOMbwDxnDe8EMTpi
	Z3YKHeqvYR1sB7oGyi+9Mg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44mqk88c1g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Feb 2025 10:43:16 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 516AbgHR020618;
	Thu, 6 Feb 2025 10:43:14 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44j8frnu14-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Feb 2025 10:43:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eXW5ySY4U7nVo100mmOnbHOAEEbo4/HUzxe0Vk23kFBA22bfxqbrullEoZFquAamXttzJYb8NlbZKPCzPM1+aVyxwfJBIEEJwK385LMph/w6RCNtOW9FBkUHoD3JKowFhDJhhSmrxfM+YaRXmaJv+GLKn86ilddWPV6J7g8W6sh3IGRTUNJFAMHHoVJtDsZakPBzkeRg98SwUtWO3rGSeE5A0zl+Vl3VPKtCw2U0WmxjIOz+kLBWaAhzTgPNzg3PgHMSawx0L4FlJ45+k6leslQg3p6nmusBZtfR1EjtXyRy/PJb/ZQwmYV73vACdjZ9nLQRuyarcVNDw5JVp3Nn7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CcKG6Nx5PDOISVE2muvOmeYdIsTGXmCemF9FaVsKD+g=;
 b=NRRKnqB36bohEVV6Vx4P/JfdAF/cG7HLKIbZ3ltNSFBJ3t1MfwNQcVY9EtzilbNsOGHmkezdWVP4bQpKsSg9FDXWzCr8q9j+TewLVnnr7sfwtaDOCXj0XeFjjGfZFxy6DTDQfVoR5QpcTuoXp8ifRDEFzKo5PZj5iI3ot2zQSPL9xOnhV61dj8rkPRQNSMTADrsR+SVjs9Nzvf/BBdxgQo/S47T3ggwgVkFxzbZtDtC4gnS2Cu/K/3rcc66ppni1ZTHm70JL8UVN9GOZUdhxo8B2YtrZv4q9xk+g1SB2xsyG8VxEtgcOER5KpzZtuhOuJKSyeLZVr6dAKlRXwBjuZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CcKG6Nx5PDOISVE2muvOmeYdIsTGXmCemF9FaVsKD+g=;
 b=cqwfBvPLciZWq8iyrDLlkyjW68RYj0yds/HEO4wPOziy+6zzvuGyWGKkdKZqcEvujGltsNUvTT1NpRSdTfOt4y/JZjUS46gEBTTwUOgZtzqCuDQ5np5bakCevZssNtSTlsknzf5GZYtIivtKhicprN4pCgjHb62RbDZB0xCcnHk=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SJ0PR10MB5584.namprd10.prod.outlook.com (2603:10b6:a03:3d3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.12; Thu, 6 Feb
 2025 10:43:12 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8422.009; Thu, 6 Feb 2025
 10:43:12 +0000
Message-ID: <2150abab-5c70-424b-ad83-74868f8afc8a@oracle.com>
Date: Thu, 6 Feb 2025 10:43:08 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 07/10] xfs: Add xfs_file_dio_write_atomic()
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: brauner@kernel.org, cem@kernel.org, dchinner@redhat.com, hch@lst.de,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com
References: <20250204120127.2396727-1-john.g.garry@oracle.com>
 <20250204120127.2396727-8-john.g.garry@oracle.com>
 <20250205195540.GY21808@frogsfrogsfrogs>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250205195540.GY21808@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P265CA0004.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:339::20) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SJ0PR10MB5584:EE_
X-MS-Office365-Filtering-Correlation-Id: 0083c884-b9e6-4d6f-2a9c-08dd469b0d8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MlRrbXZOUEdLM3hVclVzUDVhRmlSMXdOSlc0MWVoamtuTnNHeHZUZFc0b0VT?=
 =?utf-8?B?dTVxNHlrR0pTVnVGUHVIbXNkbTErbFR6cHEveEJ3WGU0L3JFREgzOUxicFhP?=
 =?utf-8?B?Y1FiVkxVTnZGaDVaRUlmMEpWY243bzdiVDBxRkFvMmxYckpERnV5VDFCYlVq?=
 =?utf-8?B?S2gxckZQbE1vRzZtZnR0djQ4aVdyaEFtZHhhaG1LUGNiY1lPdVo3d2lSVXZ6?=
 =?utf-8?B?YytsdU4yUjF2NkRROEFsdUVuYUxBRU1Lc055SlBWM3JlcGhMckJseXk3bmJ2?=
 =?utf-8?B?K09pQ1c3V3JPMnpEMmZQWDBxWFloRjRmTnNSOUhEeDg4Yi9idWc0dWVsWkcz?=
 =?utf-8?B?Vi9MWXYwbzBxZDhKd2hxZ0pEMmt0VTNqRU8yai83U2FWaUJkQ3RiS1RxYXYx?=
 =?utf-8?B?SlZ1ZnBDN1I5Nm9LLzNiZjFsUW55blEreTVjVlJONU1sNXBZbWU0RHUxYThG?=
 =?utf-8?B?QUQ3bWpvWEF6R2h2QzRva1Q5UmszVG80VkZ6UTBmYjdKZWRUTUxxUjdYb1Jt?=
 =?utf-8?B?VWtxZHUvS1RoOTdOK1lnbmNBV0ZNTTY3aWxpSm1wY0F2NFdzYVNkbVpuNDdS?=
 =?utf-8?B?Nkg5YURhSTBWWEgrZ1VyMUN0VkxSY1U4SjNjZmlPR2lWT1RvbUVsVSs1MVpa?=
 =?utf-8?B?cUUvSXYvdWRjcEtsWWVuUTVUMGs5eG0zWWpjT0tOSnJVdUlVT3hHR2hCbjdL?=
 =?utf-8?B?M1JwVGh6ZUtZdVdHYXFBRkkxaTlqQ3UwVVJjVHRiQzFqYlNsNEJXN2FSUEMr?=
 =?utf-8?B?akF5dmh0dVBoQmJteDhLWVlMN2hMWmVpeFRIc0ZaUFZEbnZkR3gyL1hWRFJB?=
 =?utf-8?B?TnNJVUYyVE8xWmc3UkNGcWFldkhuSDRWTm1pbVJnbUltY0dCajVEMVVXK2ZZ?=
 =?utf-8?B?YzRvOE1RMjJRQlczNFRTUWtPclN3SS9EcUlkT3EzM1Znc2lqMVVpUDY5RHI3?=
 =?utf-8?B?SGRYbHF2c0FvZzBpLzY4VkU0QmdWQ0I5blJDc01ucVZib2daZlNyOGFsOWpC?=
 =?utf-8?B?ckErWU1YcERMemFZSHdxKzBJN2drM0kraE1Wc3N0a1NJVnVKVWZEeXkvbGtv?=
 =?utf-8?B?eFBiRXpPZVFpMnpPUjhPckpycDdmaEcvVm9reGpEWURCZjNwU3VoVjJBTXh2?=
 =?utf-8?B?b1VQU0VMOUVzUkpCL0JSbnlwNDd2OEZ4bnljYXRoSDYwbCsyQzR0OW1MTEF4?=
 =?utf-8?B?blJhQklXNjZMR0taZWZVQnRMUFNWMnhlazFTUTl5aXpYN2h3QWIyVzN2TXFR?=
 =?utf-8?B?dTNTL2ZkQTRaMVFscy9PbkVubStBUW91dmMrSjFuOTYvVHVoOFpobUdxR1hD?=
 =?utf-8?B?bzJhSWI3NUpTaldzRUlmSllqcGhCdHpEWnVod1RVQ3k4WklJakZHZ2hyVWw5?=
 =?utf-8?B?ZGVIOHd1dXdwOXJ1MDJmU0ZlMThJWXJObzc5cFJXWi9LV3MzVktGS1daeEd3?=
 =?utf-8?B?RVFmUndIWW1QS2hGYkwxOG5rTFYrYkJTRG1Pc050SGVGczkvQTNpRnBLTDlj?=
 =?utf-8?B?SktvNmpza1ltaGRlWWNWYzBCS3QvbmFNWUh5dGpZWk05WWhrZ0pabUlTYy9B?=
 =?utf-8?B?UkdubjBIYW5RYVRWZElpN3RDL1dkVHNTWjg5T0lpOXRQRTBFeldzMmtTdjN4?=
 =?utf-8?B?Qy9OcWxnc1ZmQW01MFlyN0E5THVzTVBiZ0tBKytMR2hxcTVIZFczWFVLUWhS?=
 =?utf-8?B?bHBGd1FLeVB2K2JKVXJOa2dLSG92STJrL0dGSTkxam9wc25wNU1qNkN4MDgz?=
 =?utf-8?B?bWc3Ymp0WFNnOXVsMHE2MVhWZHFUUnhNN01uT3U4OG9XUjhGMDVhNDIzbjAz?=
 =?utf-8?B?emNoY1Vka2dPVUhxaDNxdHNNUXVNVnpPS1R3YUxDRnFrOVdlSFhaQ1BoUmcr?=
 =?utf-8?Q?O8oUlHX3XtEBV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MkNqM3ZONkk3ejJ2RjZDN0hGRVdDWDF5WjZ3MUpMVjdQVWFMQ0tzdlZZRVRx?=
 =?utf-8?B?eEg1Sk9WWUI3d2hmS3lSM09FbHFvOGVxMFV0SEgza0U4ZDk5TjB1ckcrS0Q1?=
 =?utf-8?B?ajFvQW5XMmhCODFNNjFLbElocHpZQitmZnJxY1JTOEdZQ0VQZTRienNaV3pu?=
 =?utf-8?B?ck1lOFJFcVFMbWtTT05vcHlSWVdjaEwzTUVlb1cxb1ZDZWU2VHhkT3RhMGhW?=
 =?utf-8?B?ZzZNeEdmOWJmejNpOFBaVWcyQ2ZLTlV2TWFMODdJbncvSzd6S1QwdjJuS2sz?=
 =?utf-8?B?ME9nVjNJNjdTVFNZc3puaVdUbkx1N1RBYUVERWhjTy9QT3VmMmx2QkV4MG00?=
 =?utf-8?B?Qk1wdU5ZR1RDbFJSOXJUVzQ2aTVOTTM0OTRZTjdEK0RrUnBGbm9UbkVQU0dq?=
 =?utf-8?B?VHhmRDZidjgwUUYva2dndHJJLzdQYk1RUTlPVEh1djU2R0VTdVRtR1cyWS9D?=
 =?utf-8?B?ZXl5dXg4TzhnRmo1NVoxaWJ6M2pPOUg3MWpBZ2RVTHlpR3V1aklIS0V1WTQ5?=
 =?utf-8?B?UVFrZmVuZnBCcFBuNTFsc3ZWSTNDdk1rT1k2bEVsakQvMXlLQzIrQ2piS2Ix?=
 =?utf-8?B?YUdqT0RTL2ZOMUhKT1ZGT3o1cmdTeCt1Qi9zYWVXaE9Td0ErQmpoZUkyZ1RL?=
 =?utf-8?B?SGhQNFozVjhGd0hXSUJzcW9OQnlMbTFrTWs0cjJIeG5UOTQ3TVZ1Mno1dkx6?=
 =?utf-8?B?ZEUwQ1dCWlFvKzlQZWR2c3BoWVhpaExTTGYrRkIwdUxleUkrVEhMWjd1eVhS?=
 =?utf-8?B?clFhamNqd3hQQnFrbGU5OEx1Sy9RSStDYTlOckpzdHA4MER6VkxiQUFZUFJG?=
 =?utf-8?B?MzVROVdWbTQ1NG5JN2kySG1JWWFSTmhqUmNzNWR1bWJYSUdFNEhSSFZzMi94?=
 =?utf-8?B?SHpkLzBlMXFGZ2Yzb2VCbHpSOCtjNlh1ZE9FOFlvdjlLVmdPNVB5Z1ZhM3Zq?=
 =?utf-8?B?cEJDZ3JFOEFuNG1sOWVIbzVXQ1daMEVNd1RBdUJCa2lSQTh5NGpXbDFGUVNl?=
 =?utf-8?B?QTArb2IzREsyWkVIWnQzTmZxL3BXZlEzQUszNVcxWS9mUmJIOWVFdzQ4RjU3?=
 =?utf-8?B?eE03Z0Q2RXNDcUNScTA0OGp3dTJ4ejdmL0t2cVNtelRNSlhqcXZCQUJVT29U?=
 =?utf-8?B?a21BUk5USktSM2xBMkNCSFE4NnBSK3RQaGswK0Q1ZDZVT1JwRDF5dnZ3RWVM?=
 =?utf-8?B?aTRyRTQvRGNMUlNoSmtJM3NOb29sbDlvMHpubkpDbHBUMzIrWjVSR2dzQytw?=
 =?utf-8?B?amJjUFRMMkh2VkMwcnRSRHV0K3I4YzNadFdhR2Y0VW9PYkdGOFliRThkeWdY?=
 =?utf-8?B?SmxzNU91bys1Z1poSnFOWUlLTWZtdHlDYWxtUlFrYk9MTVp0NTU2U1pVUVhN?=
 =?utf-8?B?U04xL0VKNXJGQm16bmUyTEZ0RENxbnN4UDFYTjlvdTFQaEp3MmdPNUZZVmEz?=
 =?utf-8?B?cVZkVVpsVjVmamVCWkUrS3ozK2svOENkNDJ3Q0NEMHlaTlhCVTRIWC9BN2ZE?=
 =?utf-8?B?N09SU0l5T0ZZbGZRU3BJcktpUkNlVmZNSTZqNGh5TUdBMkpHeElwSWxOdFJ2?=
 =?utf-8?B?WS9WdERRQWthUFRvSXRNV2ZVay9ZMktSK0pTMlRKRDk4TVgyZXFNN1RpSktL?=
 =?utf-8?B?K1hZNlAxL3RYU2VYV0hWRlBQUlh3T0R5bitkakE1R0ZPeFVKZkhqb3hUaDRV?=
 =?utf-8?B?dDY1WHFrTG1ORTBmSHdTbUxnWkRnYSt4WTJOMDVVMWVZTGZwSmxpelorT3dU?=
 =?utf-8?B?Q2QrdnFKbjFacUJaTWNTU0VIZGhnUXJZMjN0d283MEdGRHl3alUzR0ZSQjFR?=
 =?utf-8?B?V0dtaTZyOXRHbUJaMzZjdGh6dk10VDc4NU1NWlJBRHdkM1J0RzVlQ1VaSTZC?=
 =?utf-8?B?M0hFeUJYQXIvbU1CVzRHdy9rSWVYZ2wrbDQxc1dVV28rS25YSmZVbW9XOVYy?=
 =?utf-8?B?WXExVmg5OUFVYW44bllxN1hvd1FCNzJMTFNVWk03SS92dTl0MWpRSVQvT0Zl?=
 =?utf-8?B?MGE0Y3BBcGViMHpnbnlHaGZBVDNqUW9MR3lDT05kVHppNmhMZytBWWF6bndX?=
 =?utf-8?B?Ly9wRWhGMnl2dm1JdmprWnRHSFBSNG5sUE9EOUpPQmZOTmRFb21JdGdkR0xK?=
 =?utf-8?B?YjRMaVo5d1ZvZ1Nsbmp0MUYveHQ2NE1sa2pxZll0UlRadGVxQVFWVUtoTmpW?=
 =?utf-8?B?MlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	cGafCMsdPLos0bYcqxNAFsWcHmmfc/UwP27ua+xo1i1keEJEau4g1JeMMrglkAmGrFNozZkJCEz+NUvFIuDhwqoRHZzwTIvvcxzwSbUB3q8GfLmnOudiRDapDA8TEgxcTJ+FgKNgzDaX3MpOJ91yfLpbL/UfQOrYLffezSYxF7V99XduEpki+NxQ1AALEO+4FOdFPy693XyN60pp8mRiGpLsml4SDlX1UIGTtlOts1NDrgWKXRcvBGztZFDlBMer8Wtz1PEAtlXC+eJyv0CQvSZbgmU22ff1n4Q+IZj8SEMA0+zp4Qq4P7J+nWf4+28nkaGcgsq9yM54YjtODxu2+Eeliktxf/pDSCeN0CXmAAl3XyNTdqHPfWanAgvrK37ZZ8G0I4eLZsEBGBdXHppfivPcQvJiewY/XZSn1SrzToK21CMg4U8ftyTDej/sSIR7EGUY7fytH+Ur8thwj4xe2u4l/sTT2LNPNW0J6d0trpvyaNAlCsrdapZQXPsg3cOqHZGvRgrqNDpmFXorUsU8D2eRUNAaXqO+2vmX184rP1PLLSEqYlgLr7uwpmKxxGbu8cJwAnbPmxExgBRzdGXnMzgbUAdfFF+4DP4SBMXU4Cg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0083c884-b9e6-4d6f-2a9c-08dd469b0d8b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 10:43:12.0079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ecA/VGdEWZazv4q1SbfgOxHZapyZMUrxpkkX5UKo5zJT2MVy0aUxa1inHYpk/ZofqIM81fhX46J366UAa1EFAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5584
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-06_02,2025-02-05_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502060088
X-Proofpoint-GUID: UIvmxR5rn85NPoc33DiLYT7nh81QM7dV
X-Proofpoint-ORIG-GUID: UIvmxR5rn85NPoc33DiLYT7nh81QM7dV

On 05/02/2025 19:55, Darrick J. Wong wrote:
> On Tue, Feb 04, 2025 at 12:01:24PM +0000, John Garry wrote:
>> Add xfs_file_dio_write_atomic() for dedicated handling of atomic writes.
>>
>> In case of -EAGAIN being returned from iomap_dio_rw(), reissue the write
>> in CoW-based atomic write mode.
>>
>> In the CoW-based atomic write mode, first unshare blocks so that we don't
>> have a cow fork for the data in the range which we are writing.
>>
>> Signed-off-by: John Garry <john.g.garry@oracle.com>
>> ---
>>   fs/xfs/xfs_file.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 51 insertions(+)
>>
>> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
>> index fd05b66aea3f..12af5cdc3094 100644
>> --- a/fs/xfs/xfs_file.c
>> +++ b/fs/xfs/xfs_file.c
>> @@ -619,6 +619,55 @@ xfs_file_dio_write_aligned(
>>   	return ret;
>>   }
>>   
>> +static noinline ssize_t
>> +xfs_file_dio_write_atomic(
>> +	struct xfs_inode	*ip,
>> +	struct kiocb		*iocb,
>> +	struct iov_iter		*from)
>> +{
>> +	unsigned int		iolock = XFS_IOLOCK_SHARED;
>> +	bool			use_cow = false;
>> +	unsigned int		dio_flags;
>> +	ssize_t			ret;
>> +
>> +retry:
>> +	ret = xfs_ilock_iocb_for_write(iocb, &iolock);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = xfs_file_write_checks(iocb, from, &iolock);
>> +	if (ret)
>> +		goto out_unlock;
>> +
>> +	if (use_cow) {
>> +		ret = xfs_reflink_unshare(ip, iocb->ki_pos,
>> +			iov_iter_count(from));
> 
> Nit: continuation lines should be indented two tabs:
> 
> 		ret = xfs_reflink_unshare(ip, iocb->ki_pos,
> 				iov_iter_count(from));

ok

> 
>> +		if (ret)
>> +			goto out_unlock;
>> +	}
>> +
>> +	trace_xfs_file_direct_write(iocb, from);
>> +	if (use_cow)
>> +		dio_flags = IOMAP_DIO_ATOMIC_COW;
>> +	else
>> +		dio_flags = 0;
> 
> I also think you could eliminate use_cow by initializing dio_flags to
> zero at the top, OR'ing in IOMAP_DIO_ATOMIC_COW in the retry clause
> below, and using (dio_flags & IOMAP_DIO_ATOMIC_COW) to determine if you
> should call unshare above.

ok, fine, if you think that it is better

> 
> Note: This serializes all the software untorn direct writes.  I think
> a more performant solution would allocate the cow staging blocks ondisk,
> attach them to the directio ioend context, and alter ->iomap_begin and
> the ioend remap to use the attached blocks, but that's a lot more
> surgery.

sure, that does sound like it's quite intrusive. But whatever we do I 
would like to keep the behaviour that racing reads and atomic writes 
mean that a read sees all old or all new data. That is how SCSI and NVMe 
behaves, even though it is not an advertised atomic write feature.

Thanks,
John

