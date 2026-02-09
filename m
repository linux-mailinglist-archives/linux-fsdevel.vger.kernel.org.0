Return-Path: <linux-fsdevel+bounces-76756-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UMfzCL9Dimn3IwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76756-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 21:29:51 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 95CA4114774
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 21:29:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9E2B830205D9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Feb 2026 20:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F09C136BCDA;
	Mon,  9 Feb 2026 20:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="n2Pv8N29";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KuqOYsO8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D72241CB7;
	Mon,  9 Feb 2026 20:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770668972; cv=fail; b=eVFqVcPvuVjTkcUpn239KZUKwdHB2jz9AwPT6J7Ewdeu5a5hNVMAyDxcDm7308jYlBRjkFm3wiMh1CJDu5pVyWIRs27/mTveAMJjcoQWMrpGG06AiQ64fMymqi2P/ZAPBrgFT8lSkSDnpIL3VhLUpcAgmyM+0x4/t0jLGMHjiB0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770668972; c=relaxed/simple;
	bh=arIPTzAJMEXI+aHk4ot3qfpNqiHVv+6zU8+UkQ7HVAk=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=e8ArX6Fd9/jMYVJ0jlLTRwU60j4rlkM9YxrXvnCR5jlnHAz00vpPkwiPtCpPxctG+BvLISLk5b2XhHJcAc1fhHqGk7RhvNV+4UdDfdg46TZHrOEZUZEoqplQvb5YJ7Wb2IrY4s40Sj+vc9x6HBonoj0zsfLLl2ZOHLy2hJOH5uM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=n2Pv8N29; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KuqOYsO8; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 619ECWDX1822404;
	Mon, 9 Feb 2026 20:29:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=47wV2GzSq/VxsBg5aX75Cg4Pb0S4jlw6gdUXA9iPtt4=; b=
	n2Pv8N292dfUNHKbznZCgvs/KLm3GdsCs++uSn/rYkPDFa7g6MsY0T4FV4VGtWMm
	MHwZO/2VqLB46/+FahK2rOu95m8W0xWVDUVhijYDoa40C5SWmwfG1Gyf/xbSDUcr
	6j61vXR4emP278y8ga6RKzsAsdSt4m/chTo8fj1zPsngIHfJcin9FOyB9SE21WvY
	IY5gcUpSgjnZlD4tuv0xamXcZ4GsQs+eV+YZ/K4hZREp23FYwr37r+Ddam6cMsoD
	Uizw036UESAHmapdzvsLBo7ERH0R5vYTQ20Ydc+f17usLpTjU6sx4oKTvJPntIUK
	BELeN3aNEdDqitd6q83NJA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c5xk4tq8w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Feb 2026 20:29:24 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 619JeYuB035679;
	Mon, 9 Feb 2026 20:29:23 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010040.outbound.protection.outlook.com [52.101.201.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4c5uu9j141-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Feb 2026 20:29:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D87OJRyvtnYoF6FeGvxSOKZxRt0vfzTKP5RbWa+PUvXrmfu9llU1IyL68+NqHvKoWi3MlKpSQ2PDKiIfXDFJJd+bt10dQzq8PvigYXgvUOQIhr58GhAjv7VPpcE7GG33rxLLHg1WLkTqtjho/7hSskjhxzK61Ez5BFGYLadekQs9xaRHT4sudcvPXBin4Cny6Aj2K0Hx/dee8dmfAcNMiibx5tcG1ml1/Dpe1ui+oq5XiOrss6O1m1bPql4Ob5jV+unpDe4G1rrUrCa+mYD8JZEOTFDibzkoYU6iLcjpOpTprEId5DcnM2ATZdTyrKnp73abMPeFHQxQXWs1pym5IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=47wV2GzSq/VxsBg5aX75Cg4Pb0S4jlw6gdUXA9iPtt4=;
 b=pH9743KJOiixSfpOz83BqiPmoGWAkHZR7SnPsoPlBPA9f61FvIlLRv6nq3r/selVKFCZ2+YxZFEXcgpbpGF9d88Lwrc8OHist1P/shq0cqQZNHI5VrzvK7IcqZDk05NVQTY8+vVWboG89zUEihz8CTyh4zSSoW7BowlFL4l0xVn0C1dnttMsi5gDH8rAAGOMn0tibzwq2bWoDMpF6ZRPR5DYmw9ml/gavZqnddDjAoPFr6FxzaiodpUJzH3UDXzdcJwKPaMiFG6RNts8jq3iBs3j+RAD1bDcnDz2eLIxH5v52qX68rmIl5uQO6imFrDfkHY2Yxkx9GLw/zMnHSZhdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=47wV2GzSq/VxsBg5aX75Cg4Pb0S4jlw6gdUXA9iPtt4=;
 b=KuqOYsO8bNOPzkGjz96F6nXCb3dLam+R4D7s27c1v4sa1b8C99cNf3IxyQ35dKWuDMO5ZHA12N5IGMl95oq/VEzGlGCt3mgRFBqq4ERlQ/zdMr5lT8FGSLRwgOW4TqM5zW6ZWvx7ZmTj6aC7/iiDictRLptTTgkUH4WNPlvOkME=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS4PPFAFF9EAD68.namprd10.prod.outlook.com (2603:10b6:f:fc00::d41) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.17; Mon, 9 Feb
 2026 20:29:18 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::4083:91ab:47a4:f244]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::4083:91ab:47a4:f244%4]) with mapi id 15.20.9587.010; Mon, 9 Feb 2026
 20:29:18 +0000
Message-ID: <961be2e7-6149-4777-b324-1470b77f8696@oracle.com>
Date: Mon, 9 Feb 2026 15:29:16 -0500
User-Agent: Mozilla Thunderbird
From: Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v5 1/3] NFSD: Add a key for signing filehandles
To: Benjamin Coddington <bcodding@hammerspace.com>,
        Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
        Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Rick Macklem <rick.macklem@gmail.com>
Cc: linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-crypto@vger.kernel.org
References: <cover.1770660136.git.bcodding@hammerspace.com>
 <945449ed749872851596a58830d890a7c8b2a9c0.1770660136.git.bcodding@hammerspace.com>
Content-Language: en-US
In-Reply-To: <945449ed749872851596a58830d890a7c8b2a9c0.1770660136.git.bcodding@hammerspace.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR19CA0003.namprd19.prod.outlook.com
 (2603:10b6:610:4d::13) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS4PPFAFF9EAD68:EE_
X-MS-Office365-Filtering-Correlation-Id: 4492d4f3-d17a-47da-9850-08de6819e683
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007|7142099003;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?WjN5STE1M1lIemhQVDBOQnUrbUhFMGY4RWFHeUhOL3h4SUNMV014RERMVE82?=
 =?utf-8?B?dkdEUHhHNXYzUk0yOTZMT2Z6Z2QxekQrL0VCUmZIUldneTBiMzlFaDNQWFp3?=
 =?utf-8?B?bllUaGJTeGF3cEdTZkl1UDZBaUZ6V2xEckN5QWhWK1kzRjFQeWJkcHVkWjFD?=
 =?utf-8?B?aVNVZ05SVzFueFdLV0NEUzk1dER6NVhEL3MrOW1HM3dlVzFaeU9UcnRKRTht?=
 =?utf-8?B?UzhIR1dpZlk2N01hTWgzMTEzM2JuZGZRdngxWUZBRFduMHc2dkFlWEJoRmNP?=
 =?utf-8?B?NUQ3WFBTa2IyYzFHaUVSbTAzcThqNG5wbmpwbi9objRuenllaklKQlQ2d2VU?=
 =?utf-8?B?Z3JSVnN4QlR4Qm9uTkplMzF1V2FzdmdIWkZsUU83Tyt3dWVKK3ovQzVFSkk5?=
 =?utf-8?B?SUpTVFduODQ0ZC96V1ZCL3hTMDJneitCeVRMdmV1LzFiRUlFMzNXR2NVZnVr?=
 =?utf-8?B?QWJHaUEyWi9PT3IvQ1lDbDdPeEd2K1pCRzI3b3BkSVYxNVdmekltb1g4Q1ll?=
 =?utf-8?B?NHEvK3JRUGR5N3ZMeG0vRjZJY2dNTGtDTDdDajZBUG1QMlB0YWpLdWh5S21L?=
 =?utf-8?B?MWJTTTcrWVJtV2EvNE5pN0lhMmhsb1d4K2poV2lGUkNnWnUwTWh1NEVmczdM?=
 =?utf-8?B?VzhXZitTVTBIck1relZzMndpa1R0V1JYRUpsdzVrdERrYU1GbHhZeUdHZE1M?=
 =?utf-8?B?d2hYbmM3c1BiSUlNZWpVeHI2YWdSd1crc3ZHS2VhV2lQcmd0UzVMUW5vU1BX?=
 =?utf-8?B?RnI1UFVqenZpeXc4Z1N0d1BlQ3MyeklXRktCV2FLUFVrUWdETlBsS3pZSFV5?=
 =?utf-8?B?b1ZVZ3E1eFk5cXZ6VTNLdlFIN1h5bzJKM0QrU2svdzlHV1hoeVZGSmkxNjEw?=
 =?utf-8?B?cWdZcCtVV3I1clJORklrekYreFFBUit5b2YybC9RU3FTQnhvUlJ5cGR1cDJD?=
 =?utf-8?B?eWp4cytBeTF3THJBN1B6M1p6aXRzcCt0bUxUZXZXY0xOQ2NKVkVjT1cxZXpw?=
 =?utf-8?B?Ym9aU25hbXlYSWlkZjFHbVBQZ0pUNlVHZ2VhMGJxUmZzYVNwVkpIM0NyT0lG?=
 =?utf-8?B?UjhPS0xPMmNEeXE4TzhvUjZGMGdYd0VhQkUyL1JQa1NmbEtTajJ2QVQ0ejU5?=
 =?utf-8?B?K3QxZGZoQzNDYmc4VWRMMlVyN1czdHk0SUtCcXJrR3hTSDNsQkljSGp2dFF2?=
 =?utf-8?B?OHdMMDVqWnZpYTBOL1JLQnV0WmQ0SS8wcG5tblVmVW1BMU5KMkFzWDFXZHJo?=
 =?utf-8?B?bUpKSDFyTEFvYnpuTGdHeDBkbWlYMGF0K0NuTkk0bnJjZHNOSnNnSTI1Skc3?=
 =?utf-8?B?MExSOUdLeDlGbWRmN29uQVgvWmhIQk95RlNEN2NsZ09keVVLYnBWNDBCQzVK?=
 =?utf-8?B?YXcwMnltWlBicEpZWUlpekcvci9mMms5OEo3Y29Bb1ZPOFJxKzRGRDF4Nk54?=
 =?utf-8?B?WmlWeG1lZGJEOUhvY0JIY2NwVitTVGl5VWw2Ykw1TURnMUVUVnpnQU93bmZW?=
 =?utf-8?B?eHY0Z1VlUHlXMktSV0NVaHZyZDR2TCtUQkl6MTVuRnZUQjRwWWRZUTEyUEZL?=
 =?utf-8?B?dk8yZEh2eDZVY1VnSE5NM3JQa1dTU1BhUG1weC84dFFhSG50YnRsYUdwUHVK?=
 =?utf-8?B?KzJmanNham9maVlFYzgvQXVvSW1XN29SQy9UeWovWEh2SVRjeWUzZS9TbTRq?=
 =?utf-8?B?bWsxUHZxUDdhT1hTZFV1N2NKd25hNmVhem5TWDh2WEJqWmJjNE5JRkRUdzFV?=
 =?utf-8?B?d0J1WitTVDdXclNWZlZ5UmpQeFJUMldEdkloN0dON0ZERjR2b2pDcjhNU0VG?=
 =?utf-8?B?eFRUZlJJL2poWnIrd3NlSGZmdzdLaHFXY2REOW1EeG5HcnNWajhMdGJGUlk4?=
 =?utf-8?B?VVBjaU9zUXo2d3pCcHN6dDM2NGFWQjNwQ1cxUXRRTHZiY2dOVVIwNEp6amN0?=
 =?utf-8?B?aUpqeFI0Z0NwNXFBK01lc3ZvQUpUdFM1emJSRms1UU4rVXJ3aUhoT2NjRmt6?=
 =?utf-8?B?Vy9yZEsvbVhiREZJaXEzeEJzZTZWL2N3K1lzWk92TVZCamxoNUs0YXdDcjR6?=
 =?utf-8?B?cVMrU05IdHlRd0lYcDdwRmhxTzg4aktkdk4xak9sM0pIdDExbUVNSFFqelU5?=
 =?utf-8?Q?WsA4=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007)(7142099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?SmI4YmdGMmRseG4rWlNHeDkxZU9DYi9uckhIcHpzcVl5V2VYNmdXbnk0NExE?=
 =?utf-8?B?RW85YUg2Q2dLN1dTRnFteHJmb1Z1aHM1bVY1b2xTRDVrRGtBU1hZc2tsWXlJ?=
 =?utf-8?B?ZW9MZDJidlR6bFNmSlhZMjJiamxKNkdiaUxqQVQra2xZWmIva0tQa0hFWktP?=
 =?utf-8?B?MkRCZW56dG9sNW1hblFqb1dqMGJ1VStYRHVxbzNOaUo5SWIrOGpXWjdRMkwr?=
 =?utf-8?B?Q0tZakkvdXdXMzdtRWZ5eDhSWjNNNHViV3JKSUZ4aVdRZGFYcEUrZHJVYkRo?=
 =?utf-8?B?M2JvTzNXeFAwM3c3eUhRV1I0eHpjUUlzbnpRczRhQXp4OWhBcnA1RFZST09R?=
 =?utf-8?B?LzRlQWgzOTJMUHN3SkVUYXRsNlZMY3p6SnQxbWJPaEpHYW9NUnhyV2kzRHZE?=
 =?utf-8?B?bnFhNFkyRWpzMjNXL1RLUXpvbS9ha0laTytlZktMcmdvVm1BL3djWXpMaUxP?=
 =?utf-8?B?TGNFUzdvZ3RTOUhpbHVvUXZjbEpQN3N6eHVjQ2lkL3h6cS85VVRYQ2hXbk1Q?=
 =?utf-8?B?WlcvQmlkaDR1VXBBRzdiMjVvTmZnVWQzQkJvTmJtTzNHdkZybFV5VXZ3UjNl?=
 =?utf-8?B?ZXBLSlZsZkh5Y2srT1Jnbk1aaWtsTVdVYTV4RHhsdnJkTU1lYUNtcW5LK1hk?=
 =?utf-8?B?NDNHd01Bd1MyVkRHTlQ0R3pMQ3MzcGx0OTZLS2hGaGd3VHA0dTZZTHNPaEdU?=
 =?utf-8?B?RW1iUlU2UlhkQ3FhK0k3bHhQSUdMZ2VGckNiSG1Ednp4cnAzM3d6SmsrR3NR?=
 =?utf-8?B?c0E3SStBK2MwTUVjTzNpNVJrMzZodTlWaGs4OGQrLy80eURGY0FmNVF1c0JH?=
 =?utf-8?B?Tno4elhkbDkrYy9qTi8wSHltVGFJOVcvUXhSenV3bjNHUTlnQ3lZaGJsVDh0?=
 =?utf-8?B?a0FSdXlGTXpCODh3RXM3eGJwRVFoN2hhK2ljRXFSTVlLWlI1azRkVUJyR1lD?=
 =?utf-8?B?Rkk3aVVRK2NPemZCWE9lNWdWYkZGOStuVkZnV1h0OWZFVHVvMThjSEYvNGU0?=
 =?utf-8?B?dWw2UmRLSVVsVDdMODlDbndSRmE4YTRnSFIyOXNoUFIvMjl3RWMzbzlYVVNN?=
 =?utf-8?B?UzkyVUNxZXZDbHhNUmhDWTBmemdvMWFQaFBDOHZFK2JYNEduSzFEb3pWQmRP?=
 =?utf-8?B?MDRlZ29KMU80dEVPOGN5VlNlU01YSkJ2WGpJVVhpQUhVRTV0d1hBZExnT2JE?=
 =?utf-8?B?RGlUOGR3QmFkTHZ5RkwxV0NGRjBkdVFGbU41cnVpRW1URGlTNm1hRStTWGNn?=
 =?utf-8?B?STA0UXZKS1VYOTBSNTg3SHpZS1g0SSswM2tudUFqSHJHYnhuK3hJa25ocDkx?=
 =?utf-8?B?aEhLTStIdnFKNm85WmlqSVEyUzFybTZPSXk4SndIelJydmUwLzl6MitFTkM3?=
 =?utf-8?B?bDZsU2MyWlNqaWhORFBDck85SzIyOUthV2t2cFBEM2pPN2RaMHdKMnhmc2dw?=
 =?utf-8?B?Rk1XMVVUWFVXd0RmQWFIbmQ5V1BSRUlnbEVrT3B3dDJoZ2JPWHpoVVRKak9X?=
 =?utf-8?B?SG9VbEtFNUtGcVdSMm45WXNBWWsxTGc5dlluaDk0Y3JtNHZPdWhoc0JQbmZv?=
 =?utf-8?B?bVJpZ1hGZUt5V2YvU0ZrbWFXU1FjQ0VqZ2E1ejFxczdKcXI3RjhIeHpUTWhw?=
 =?utf-8?B?bjEweFQxb3hjN1c5dE9ld0Y3NUUwbFU5YUh4OVRTZ09ITndPQnJ4Q0R2NzVl?=
 =?utf-8?B?RENZZDV3MUJ2S1UrdTNabHhqK2NpTEJBcXdwc3loRjAwR0RWZ2hGYThJOUEy?=
 =?utf-8?B?Rmk1YTlqeXNKd0lQTmpkelFBeUZWemFxVE1zNkdvREU0RCs1U280Z1Q1VlU2?=
 =?utf-8?B?SWFlVmI2Wm9lUnBqbG44MlFxbk5Cemx4NUN0ZDV0d05BempzUnNGdFdhbURs?=
 =?utf-8?B?UDRBTk03VlA1SS9xdzkzNHVvdWxaY2d0cDdSUEJJTk0wOWY0MVg0dmRrL1pk?=
 =?utf-8?B?Rks0ZXh6NmlxOHVPTkpaUHMzZmZlWXQzejBoZTArdFZDNHVaL3k2K2pDVHNI?=
 =?utf-8?B?NHdnNTlqYzdQMC9pdkFHOU9Yay96RGg3dE8rWkxIWHFoUGtwL2JpeVhzNEJB?=
 =?utf-8?B?Q1lLbFVDZlZmbFArQURpWVFhZkpHbWNMTmJWVXZxZWYxbThsbTdGSkwyOWxK?=
 =?utf-8?B?Z3hCUTc2emFPa29Sa0NFZ2pQNWw4cnNrVzFiREdObzRaWXJXVGk4U1pHZnF4?=
 =?utf-8?B?bm8xMzlrS0RiYmVwcGxLU0pMZWVUVncySWtCU3RTL3ZBZ200dmNRRkFCYVFK?=
 =?utf-8?B?c1VtSG5TVUdma2RYendrTXZWYlN4bFNBcjVqalhGaXg1ZXJJaXZMUHNrRkVx?=
 =?utf-8?B?OUdEYkhrbWo3NndGc29yajU2MnkxU1czUXNvTERIQTlzT3pJb0hNZz09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ZxaUc2YnEinPvDTM2xU3KuAB4vE0QA63Bf7CHcYXFJ+GLVA8NG6V6fgF9m+3s3JUIwJBpjTCtxpJjYNQU0ELTOS6xVRdJiQV7O2QU6bZicT9qemGHhhnmItRlSfKtMtiyl6AhoYVGzMWPwR8OOLMO1UuyFiY45esG9dLRw8lMKi9sDPJbTwI0yFGCLGAmTkEnZ4O41wUSpmgEv2moBHe0EA8g4+WNvHuq9KRPk9zVU6uz9oTtrYD+GMIOrWoYZo40F84BD1prx3SPckHISsmD0R3VFFiRJ3NzGiXYUQ+MeHBjAGbsclDuH3Ayqik6OJw1MvibHZwC87RCBy4vOuztWfFv1ND3qmJazXfCmq6ySkQV/8mwZAz4T62tFKeMBvyWjhDOwe727yRL3R35m4ZDPuKyIWtGnwvHPeJBSL3IClo8zZu5r3Oh7dGmFjmgnHvOm7lSy15hn9Bb4h3SqEXBSmMd/E5txgT8VPRkhni5rZZvoDdn5TFQ1fM80LxtQTKbVFOxg1tpRtY54aAel26WgRxIPKq0PcWeaHQZMv5YNi3/s5Y41dpCVSWrE1l65KIvGiAPbX+Xc/odG+P1GGVeqjT5lQzJA34YSc0za1D1Lc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4492d4f3-d17a-47da-9850-08de6819e683
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 20:29:18.4791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gkSjmiBP05O8P7qLv+RV3mPeoNXrxmucuIFQwZTwZ2Ck3o7SvgatlNF8H/xUxR4ZP34lonTWkTFyS++BZ6REwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFAFF9EAD68
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-09_01,2026-02-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 malwarescore=0 phishscore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2602090173
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA5MDE3MyBTYWx0ZWRfX0rCGpeWKl9Kc
 Pccmug/kh/LD7zA96IinL8hPaA/1O67hBA54QB9nzpeubJTfkH/MkGDItFsAUfVMQESpRc+xAXL
 VvLJDz3Itz/cKzbTomQ/TRYr+SD5gy2VaQKyarW8HCA3BLYjozYl7O+WplB/qVAEt8HF6iBK3EN
 dyumyQz9/2N5iRCX53j9LraOXFyawHKTDwa/EEkAwAFEumY3F+RP9UhsdVwA8gdKqkgRNlH/1p6
 wa2w+5WCmxnlpZ/HCe/mqYc52C6QNY+T1WbFklm66mC2Iv6WyRh6aVlNhCjWzE77e7DFU6lbJgd
 b8EfU3IipJ37LxgDPZObMg89O3JJ8R2P4Dbe1yJJqcIhI8YFmmB14HQD2rvl2r+qG8ioiBC6hOD
 VNRwEMVeEHwllEstXJBfmqob/qKaYv3v9uG8EV8UcDX9fruvUUE9ySZEQcnLKN8WU9WoYNrpuNI
 W/e8/XGFEnnx9W/XybA==
X-Proofpoint-GUID: oEq7ekFeopd161uoiiJ86eiPEZvks2tQ
X-Authority-Analysis: v=2.4 cv=ccnfb3DM c=1 sm=1 tr=0 ts=698a43a4 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8
 a=SEtKQCMJAAAA:8 a=wNxckaeOX1VqrAGoRNoA:9 a=QEXdDO2ut3YA:10
 a=kyTSok1ft720jgMXX5-3:22
X-Proofpoint-ORIG-GUID: oEq7ekFeopd161uoiiJ86eiPEZvks2tQ
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-76756-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_TO(0.00)[hammerspace.com,kernel.org,brown.name,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oracle.com:mid,oracle.com:dkim,hammerspace.com:email,oracle.onmicrosoft.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chuck.lever@oracle.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 95CA4114774
X-Rspamd-Action: no action

On 2/9/26 1:09 PM, Benjamin Coddington wrote:
> A future patch will enable NFSD to sign filehandles by appending a Message
> Authentication Code(MAC).  To do this, NFSD requires a secret 128-bit key
> that can persist across reboots.  A persisted key allows the server to
> accept filehandles after a restart.  Enable NFSD to be configured with this
> key the netlink interface.
> 
> Link: https://lore.kernel.org/linux-nfs/cover.1770660136.git.bcodding@hammerspace.com
> Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> ---
>  Documentation/netlink/specs/nfsd.yaml |  6 +++++
>  fs/nfsd/netlink.c                     |  5 ++--
>  fs/nfsd/netns.h                       |  2 ++
>  fs/nfsd/nfsctl.c                      | 38 ++++++++++++++++++++++++++-
>  fs/nfsd/trace.h                       | 25 ++++++++++++++++++
>  include/uapi/linux/nfsd_netlink.h     |  1 +
>  6 files changed, 74 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/netlink/specs/nfsd.yaml b/Documentation/netlink/specs/nfsd.yaml
> index f87b5a05e5e9..8ab43c8253b2 100644
> --- a/Documentation/netlink/specs/nfsd.yaml
> +++ b/Documentation/netlink/specs/nfsd.yaml
> @@ -81,6 +81,11 @@ attribute-sets:
>        -
>          name: min-threads
>          type: u32
> +      -
> +        name: fh-key
> +        type: binary
> +        checks:
> +            exact-len: 16
>    -
>      name: version
>      attributes:
> @@ -163,6 +168,7 @@ operations:
>              - leasetime
>              - scope
>              - min-threads
> +            - fh-key
>      -
>        name: threads-get
>        doc: get the maximum number of running threads
> diff --git a/fs/nfsd/netlink.c b/fs/nfsd/netlink.c
> index 887525964451..4e08c1a6b394 100644
> --- a/fs/nfsd/netlink.c
> +++ b/fs/nfsd/netlink.c
> @@ -24,12 +24,13 @@ const struct nla_policy nfsd_version_nl_policy[NFSD_A_VERSION_ENABLED + 1] = {
>  };
>  
>  /* NFSD_CMD_THREADS_SET - do */
> -static const struct nla_policy nfsd_threads_set_nl_policy[NFSD_A_SERVER_MIN_THREADS + 1] = {
> +static const struct nla_policy nfsd_threads_set_nl_policy[NFSD_A_SERVER_FH_KEY + 1] = {
>  	[NFSD_A_SERVER_THREADS] = { .type = NLA_U32, },
>  	[NFSD_A_SERVER_GRACETIME] = { .type = NLA_U32, },
>  	[NFSD_A_SERVER_LEASETIME] = { .type = NLA_U32, },
>  	[NFSD_A_SERVER_SCOPE] = { .type = NLA_NUL_STRING, },
>  	[NFSD_A_SERVER_MIN_THREADS] = { .type = NLA_U32, },
> +	[NFSD_A_SERVER_FH_KEY] = NLA_POLICY_EXACT_LEN(16),
>  };
>  
>  /* NFSD_CMD_VERSION_SET - do */
> @@ -58,7 +59,7 @@ static const struct genl_split_ops nfsd_nl_ops[] = {
>  		.cmd		= NFSD_CMD_THREADS_SET,
>  		.doit		= nfsd_nl_threads_set_doit,
>  		.policy		= nfsd_threads_set_nl_policy,
> -		.maxattr	= NFSD_A_SERVER_MIN_THREADS,
> +		.maxattr	= NFSD_A_SERVER_MAX,
>  		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
>  	},
>  	{
> diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
> index 9fa600602658..c8ed733240a0 100644
> --- a/fs/nfsd/netns.h
> +++ b/fs/nfsd/netns.h
> @@ -16,6 +16,7 @@
>  #include <linux/percpu-refcount.h>
>  #include <linux/siphash.h>
>  #include <linux/sunrpc/stats.h>
> +#include <linux/siphash.h>

The added #include is a duplicate.


>  
>  /* Hash tables for nfs4_clientid state */
>  #define CLIENT_HASH_BITS                 4
> @@ -224,6 +225,7 @@ struct nfsd_net {
>  	spinlock_t              local_clients_lock;
>  	struct list_head	local_clients;
>  #endif
> +	siphash_key_t		*fh_key;

I will make a note-to-self to update the field name of the other
siphash key in this structure to match its function/purpose.

As a performance note, is this field co-located in the same cache
line(s) as other fields that are accessed by the FH management
code?


>  };
>  
>  /* Simple check to find out if a given net was properly initialized */
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index a58eb1adac0f..36e2acf1d18b 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -1571,6 +1571,32 @@ int nfsd_nl_rpc_status_get_dumpit(struct sk_buff *skb,
>  	return ret;
>  }
>  
> +/**
> + * nfsd_nl_fh_key_set - helper to copy fh_key from userspace
> + * @attr: nlattr NFSD_A_SERVER_FH_KEY
> + * @nn: nfsd_net
> + *
> + * Callers should hold nfsd_mutex, returns 0 on success or negative errno.
> + */

The sv_nrthreads == 0 guard at line 1642 prevents setting the key while
the server is running. This not only guards against spurious key
replacement, but the implementation depends on this to prevent races
from exposing a torn key to the FH management code. That needs to be
documented somewhere as part of the API contract.


> +static int nfsd_nl_fh_key_set(const struct nlattr *attr, struct nfsd_net *nn)
> +{
> +	siphash_key_t *fh_key = nn->fh_key;
> +
> +	if (nla_len(attr) != sizeof(siphash_key_t))
> +		return -EINVAL;
> +
> +	if (!fh_key) {
> +		fh_key = kmalloc(sizeof(siphash_key_t), GFP_KERNEL);
> +		if (!fh_key)
> +			return -ENOMEM;
> +		nn->fh_key = fh_key;
> +	}
> +
> +	fh_key->key[0] = get_unaligned_le64(nla_data(attr));
> +	fh_key->key[1] = get_unaligned_le64(nla_data(attr) + 8);
> +	return 0;
> +}
> +
>  /**
>   * nfsd_nl_threads_set_doit - set the number of running threads
>   * @skb: reply buffer
> @@ -1612,7 +1638,8 @@ int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct genl_info *info)
>  
>  	if (info->attrs[NFSD_A_SERVER_GRACETIME] ||
>  	    info->attrs[NFSD_A_SERVER_LEASETIME] ||
> -	    info->attrs[NFSD_A_SERVER_SCOPE]) {
> +	    info->attrs[NFSD_A_SERVER_SCOPE] ||
> +	    info->attrs[NFSD_A_SERVER_FH_KEY]) {
>  		ret = -EBUSY;
>  		if (nn->nfsd_serv && nn->nfsd_serv->sv_nrthreads)
>  			goto out_unlock;
> @@ -1641,6 +1668,14 @@ int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct genl_info *info)
>  		attr = info->attrs[NFSD_A_SERVER_SCOPE];
>  		if (attr)
>  			scope = nla_data(attr);
> +
> +		attr = info->attrs[NFSD_A_SERVER_FH_KEY];
> +		if (attr) {
> +			ret = nfsd_nl_fh_key_set(attr, nn);
> +			trace_nfsd_ctl_fh_key_set((const char *)nn->fh_key, ret);
> +			if (ret)
> +				goto out_unlock;
> +		}
>  	}
>  
>  	attr = info->attrs[NFSD_A_SERVER_MIN_THREADS];
> @@ -2240,6 +2275,7 @@ static __net_exit void nfsd_net_exit(struct net *net)
>  {
>  	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
>  
> +	kfree_sensitive(nn->fh_key);
>  	nfsd_proc_stat_shutdown(net);
>  	percpu_counter_destroy_many(nn->counter, NFSD_STATS_COUNTERS_NUM);
>  	nfsd_idmap_shutdown(net);
> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> index d1d0b0dd0545..c1a5f2fa44ab 100644
> --- a/fs/nfsd/trace.h
> +++ b/fs/nfsd/trace.h
> @@ -2240,6 +2240,31 @@ TRACE_EVENT(nfsd_end_grace,
>  	)
>  );
>  
> +TRACE_EVENT(nfsd_ctl_fh_key_set,
> +	TP_PROTO(
> +		const char *key,
> +		int result
> +	),
> +	TP_ARGS(key, result),
> +	TP_STRUCT__entry(
> +		__array(unsigned char, key, 16)
> +		__field(unsigned long, result)

If the trace infrastructure isn't passing "result" to print_symbolic()
or its brethren, then let's match its type to the "result" argument
above: int.

But see below:


> +		__field(bool, key_set)
> +	),
> +	TP_fast_assign(
> +		__entry->key_set = true;
> +		if (!key)
> +			__entry->key_set = false;
> +		else
> +			memcpy(__entry->key, key, 16);
> +		__entry->result = result;
> +	),
> +	TP_printk("key=%s result=%ld",
> +		__entry->key_set ? __print_hex_str(__entry->key, 16) : "(null)",
> +		__entry->result
> +	)
> +);

Not sure how I missed this before...

We need to discuss the security implications of writing sensitive
material like the server FH key to the trace log. AFAICT, no other NFSD
tracepoint logs cryptographic material.


> +
>  DECLARE_EVENT_CLASS(nfsd_copy_class,
>  	TP_PROTO(
>  		const struct nfsd4_copy *copy
> diff --git a/include/uapi/linux/nfsd_netlink.h b/include/uapi/linux/nfsd_netlink.h
> index e9efbc9e63d8..97c7447f4d14 100644
> --- a/include/uapi/linux/nfsd_netlink.h
> +++ b/include/uapi/linux/nfsd_netlink.h
> @@ -36,6 +36,7 @@ enum {
>  	NFSD_A_SERVER_LEASETIME,
>  	NFSD_A_SERVER_SCOPE,
>  	NFSD_A_SERVER_MIN_THREADS,
> +	NFSD_A_SERVER_FH_KEY,
>  
>  	__NFSD_A_SERVER_MAX,
>  	NFSD_A_SERVER_MAX = (__NFSD_A_SERVER_MAX - 1)


-- 
Chuck Lever

