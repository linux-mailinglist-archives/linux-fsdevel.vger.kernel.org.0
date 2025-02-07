Return-Path: <linux-fsdevel+bounces-41187-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 407D2A2C226
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 13:02:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A82C016A2BB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 12:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 580071DF725;
	Fri,  7 Feb 2025 12:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="j7kRLFFt";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nLr7QbE/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020811DED44;
	Fri,  7 Feb 2025 12:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738929753; cv=fail; b=TMl9bZeSbe/q3rsFtziCILp2VWugetkQfqg9MyFQ8mb1mkER992bmVRhEruoRQYrURvC+qJZhgYC1MU3p131OcZ68K79mivg5WyPjyCl/5T49mRauERhCq39J/UZRK+16AkwcxKB6LcZN2sCP9CFdpPY+PLXcCc7fX1BiB4+Lo8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738929753; c=relaxed/simple;
	bh=UJluoNChwR6SJLhdANXH7n8eyJ8vUHw2zbiVBgLsK8s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EL7sjJIbGS3UmMWK5MxWnkBz8uBva2FM5uAtoNH+/sBzlmvuzeZFF4+g04qjKz0PKZPsFzwylHfkv9hRwMX1jy0yL0iDcld8Jwp/+btlj5sl+WmiKOjVKU3oTK2Iz6vZWiJD8EbrzWc4qCTKQDCuCPruaTrTL2NHgl1SoTAGM00=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=j7kRLFFt; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nLr7QbE/; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5171ubkD032410;
	Fri, 7 Feb 2025 12:01:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=/yMk0VvRNkVgeSPocz6FiRmcGFem974u5AnwOdxIWL0=; b=
	j7kRLFFtNebcKDCUkRS+Cno7niNHkFG7Z2iySz2hIXaN74B4c10FPhVky/gYYcuK
	bG0F0STM9Lq3mPhe/PXWeaIJ1bbwAYFw08ulvwW65ao2K64f13jORBTtV2UxC0A2
	DYAylnSluY7yGNHRkdK/0QV8hm7D8NtWsRnWk8hUcgR/pR3rUmg5PDiTI9biO8/G
	+YO8+eJoQfskXDHFt3Nl0r7GNbMvnJp50DdCs0AI6HOTQhMDU0v/5vzLOOYAN6iS
	sCxhC+Bf3HK30/1V/JdunZlm7NFp2nNZeKo7052CQ+KouGnVvCLLIWsX48juFBvV
	iDLMTAwu78iufauFRHUfNg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44n0nb1jgy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Feb 2025 12:01:39 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 517B69Fl027915;
	Fri, 7 Feb 2025 12:01:38 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2042.outbound.protection.outlook.com [104.47.58.42])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44j8drejja-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Feb 2025 12:01:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zWw1gRInLQvQQK4nJL3ixPafh7uTSHiZ0yCt2YBm+z0yKpjeIP85+m3ENT55KlCeH61tT0W9tDp9gg8/89Ov/IF6f7Zq/4VGQQSJ2I4SqYqRP+rX/kaTfrXG8yZzUBLQT1nnPauHOfQCagbQlrMMqOn1K/aO0h9wYsoGWI7+NKSVCRjYmMWdQyUJBuoT67d8twuAEI6EnyMU+UZQ5z3O4RNhirWWkooMQUdOUYHC3df2qUUHjFGTCQLobToiMKCikGYLt8z4ycAYZQg0uwhJXrv0Rua6xmJ2t87pdTZqLC6RyskWMVuJkghCoQoRUdfKhjJ2e/hizAQO3lzDGhC1NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/yMk0VvRNkVgeSPocz6FiRmcGFem974u5AnwOdxIWL0=;
 b=ya/AjTiQTY7JWCDuUmIXn8uXxM4LD1CeVE+cp+tTGD27OXxEDZTfQMegt1m69AAlc4Tmx3v1lrBVC6TUdj0HFADvtcToIe8Jf2IdldjjyaV2k5+Qpv/u/iGMB1uPNkTJmIPAXOLRW1e6rcIDfN2Fdib5jzd8jVWm0LE3hPebwxSX9izb1EIfar1y1ichWp0epA3k0O9kXwm39VZhmNbpZhVXx22Smzf3Dwzed0Jk/18TJKsm0CRyKqwBljGpoM7o1U1qgWTGdFw8d42ZXtG1vnixstweV7pnvTf2axlhBYJCkfl2NfA6My8Au1IahlZPlMGKGX4QXz7bKwlytUyyAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/yMk0VvRNkVgeSPocz6FiRmcGFem974u5AnwOdxIWL0=;
 b=nLr7QbE/t/NHhwNR3/jLtAHFrzK2ptu3D1GK+a5gvKB/10lJwh6YWyhyMiIcndj3pVx/Ucngw/CQNeoicqGQekU3kBrRTNGW5qWVsgpt6K0EdDcb+CjKwjDrpxqw0gK/gvtYzDI206g85wdnJ0Wk3/nL08uKJsAiTECZ/cEiPOE=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CY8PR10MB6708.namprd10.prod.outlook.com (2603:10b6:930:94::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Fri, 7 Feb
 2025 12:01:36 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8422.009; Fri, 7 Feb 2025
 12:01:35 +0000
Message-ID: <e86ed85f-6941-44ef-96a5-0ca15faaec1d@oracle.com>
Date: Fri, 7 Feb 2025 12:01:32 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] extsize and forcealign design in filesystems
 for atomic writes
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: lsf-pc@lists.linux-foundation.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, djwong@kernel.org, dchinner@redhat.com,
        hch@lst.de, ritesh.list@gmail.com, jack@suse.cz, tytso@mit.edu,
        linux-ext4@vger.kernel.org
References: <Z5nTaQgLGdD6hSvL@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <35939b19-088b-450e-8fa6-49165b95b1d3@oracle.com>
 <Z5pRzML2jkjL01F5@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <e00bac5d-5b6c-4763-8a76-e128f34dee12@oracle.com>
 <Z53JVhAzF9s1qJcr@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <4a492767-ee83-469c-abd1-484d0e3b46cb@oracle.com>
 <Z6WjSJ9EbBt3qbIp@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <Z6WjSJ9EbBt3qbIp@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0181.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a::25) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CY8PR10MB6708:EE_
X-MS-Office365-Filtering-Correlation-Id: b5693513-7dbd-49cf-99eb-08dd476f2bac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bCs2SE9mVFRIcEptd2RjbmVPUXdNeEljR1prcmhhSUN0OW5KRmNzU0ZnL1Vy?=
 =?utf-8?B?WDhIZHNPNUxrTzNSMTAxVkNjNG41bVlZUjZpWjVQaUFGRnFxTUxkWWorWnkr?=
 =?utf-8?B?ekRDZUJRYlk4dDlncFp5SXdabGE1WG9IOGdRN3pXT1VHNnAvaWZDYzM1VTZ0?=
 =?utf-8?B?VERHbDBGZnBNbEdaNGpXb0duYzBpZVpXMjNVM05rR3c3WWhkR3NlajZOZWZ1?=
 =?utf-8?B?N2ljMHp5bUVhb29xeEp2ZS93aFNybTZBOGw2NEw0Syt6WDF5VFppbDhpSDZD?=
 =?utf-8?B?UUhLWkMyV3F3Rnl1MFRGVXU5Y2Q3UkNQb0RHcm5LMzhjWXJBVnhQUDVld3BI?=
 =?utf-8?B?Z2l5WFdmSENKdSsrMUpuRnJIYTY4dzF5WWNJK0RwUlhsZGwwR1V0ZXUvdmQw?=
 =?utf-8?B?TFNyYit3RHRVVm1Bb0JSQmtROC9oWkhtVWdxVGwvdWoxS0VFaXFxd1NlcHoy?=
 =?utf-8?B?VWxRMGdZZUxlK1dDRUhsNEZvTW50WVFnMnhGTy9nK3NtcTg2VmIxa2NzMWps?=
 =?utf-8?B?bS9HR0Y3WkFNVll0NTlxNGQ4S1NSTXFIeTVtWHA3QWZNSTVaUFVRQXlBSUV2?=
 =?utf-8?B?TUxyU0FkNVlHa3Y4NmJ1Q01Xc1dOamxlZ1cvcHl1OU1FcnZGdWN4VkFvemN5?=
 =?utf-8?B?RC9HR0E5TWkwcnZQYlVwVmZaTytzRk1zU1JON3hvcStBajhmZmJxYXQ2UVJE?=
 =?utf-8?B?U0ZoZlBHQjV1S2RPeExRWHFZQzNRTDc5M3VPRDhncDMxUTdLVlJmMlhBMGcr?=
 =?utf-8?B?cjhrSm9ZWVhCSVZtSWhkQjQ2Vlcwc0RxU0FyN2tYTVpOVHJubmtKTmNXV2hD?=
 =?utf-8?B?OExRK2pVRTZReTlPQXBNU29OV2tpUVZYM0VSUTNwN2VkNUs3dHl6T054UitE?=
 =?utf-8?B?enNRaXltVWtsRWxpRG50eFVsemR3Y2grRlRoY3BGaGU2TXJzblFxVlpQQkZp?=
 =?utf-8?B?ZWpjYjIyWGlubjNkbVhIWWwvWHgvaHN1WkxaWUl1OWdVMDYyTW4wZTk2NFgv?=
 =?utf-8?B?ZjNhVEllb0ZNSXVLb2ZZNjREcjFBdVZkZmV2eStQRE1LNVprTTdqbXJIdllW?=
 =?utf-8?B?ek96NFdCZldFZG9oZHJ4djVRNndETmRYWTgvaUU4N0gzVFQyV0xjSDlZaXdo?=
 =?utf-8?B?cE1wRDJiQ0tFVGMyQitEYlBmVVJ1YU5tMEhIYW1acm8wME02dU9wUkdaSlNJ?=
 =?utf-8?B?U3lqcFFFUmd6MVlDY3RMZmsrVFp4MW5VNVltQStXa3ViRTZiQ0F5V3BSSStJ?=
 =?utf-8?B?OUhLdFFwVHo2cnltMzhNQ1NJR1EwazNRRWdnTmcySWpGT3FOd3hLU1JacjNC?=
 =?utf-8?B?NUY5N0k0SHdyNVdSRkdTYnAvd3RmbU8vb0UxZi9yQ2EvTyt6KzZOTXQzRVhT?=
 =?utf-8?B?cWxQaG5nRVZHNGVYZGZMY04xMkJ3Vyt0dThoTFcrQ05EUTViaDFaek92YjBF?=
 =?utf-8?B?T1h2V2MwdXBSM1lCd2dvdmY4amNOcGZzcXdtQ0JMZmlQSDd0WFdNWHlWcFQr?=
 =?utf-8?B?eGh3SHJ6QjFHYkQxNVB3R0U5emM1Unc3V1hmSSs3ZXEyQ3Myd29NR1hZRVlQ?=
 =?utf-8?B?bHBrODRFOUphNEVXcHRhOFlVRStRa2UreFVVRkJldThkMW0rbk1oa0lIRU9H?=
 =?utf-8?B?N2hyZ0R6SU5hVkxmZTg3b0NBOStZSHRyS3pvcHVWaFdBUCtvdTdSd2tSOVdC?=
 =?utf-8?B?OThQZjYrWFdiZFhYUDhxU3A5b3JJbWIrWnNVV2RvcUg1NlhlYm1Xem9lMUxS?=
 =?utf-8?B?MWVaMTc3S2NaQzRNWk9EMUZPWmxMUGg2UjJwbGRId3lXRC8yZGNpaFZLR0tE?=
 =?utf-8?B?RzRickpBT3IyczF1TVViaUp4TDR3OHdBNU1EcFVMTmpxZ2p6L0NMYnNwRi8z?=
 =?utf-8?B?WmFJWTIrZktKV3VHL2JPakdvODhsWHdDcVhZWHlhRjVjaGc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U3JUNkV0RW5hMndSMVhqRmNpdGZlZkhzQ3QrZ2xwajZCQXBwN0tGRlFSZnVW?=
 =?utf-8?B?cVYyWnJqUmFzNWlLQWdvK3YvbzRodmRTS3U1S0Y0aEsvWTdwZUhYbUlUTVBV?=
 =?utf-8?B?TlVvT2pKUG9OT3BrNHUrUzZyTDVWZ1VjeEMvOE5tcjY5SllqZFE5RVNmZ21W?=
 =?utf-8?B?MkRGaHNNN2ZMaHdqVWI3UFlYV2M2WFFKbTdaVTRCWjgvWWkrL3VNUzBZbmtC?=
 =?utf-8?B?OWI1MGZGYTR3THNER01tM0d5RGR6dXFmTkFiZXhaN2Fid0lVSklhL1A0UXhq?=
 =?utf-8?B?TTFYRTVDYTh3ZllHRXo1NElGaWM1cmZudnpGY294MVJZdGNtMzNjTDh1WUVx?=
 =?utf-8?B?MjhwdXNHdDR3U1drd0R1UWQrSHFzaDR0ZVBRYlFYR0IzU3pXUzdueE1taUt3?=
 =?utf-8?B?Kzh6VEdiSVQydnVBUUt2U3AyT3JndWhmaTdJRFVJejkyN01UdElmQng1VlhD?=
 =?utf-8?B?cmYyK2lGUWZmaEFEUkpiSTF2V0g5M2lNNXpzRmxZczRXTGFENUZFdGlmZ3lS?=
 =?utf-8?B?NXNiN2x5bDRYL2lCV0dRZ0EyVVN6Vi9ZaGJrTmg0MisxeWtrSDh3eUxtUVRR?=
 =?utf-8?B?alNsbXdYakxYYlp1YThhSVFubDhRMENDK0VXanRCUnJYNW5wb3ZXVWZwYW5W?=
 =?utf-8?B?ZXRvYS9NUkJOTW9Hc21DZTdUVk83cVpVTUtERm8xSzdPTnNRbmdzZGpGZmc1?=
 =?utf-8?B?dmEvN3pyT2E4MWFlT1QvcFh1RU9oL2JnWUNuZXRtNmhQTDVTT09SOWxVRC94?=
 =?utf-8?B?SWFlYnpNWUJ4d1VoL1daWXhZd0xxTHVnUDY3MnN3bE1sM1ZUWXE1RnNLRVpt?=
 =?utf-8?B?UDBETG1xWUNYbHFza3RBQkNaajQ1MkZPbmJQN09zemY3dVdnWlpCVE44UUFT?=
 =?utf-8?B?aDlsTm8xV3BCMEV6WjBtTFNaR1BzOVRrdm5pTXA5YkhiR3FoTlorUjFubUFx?=
 =?utf-8?B?SVVDOHI4NnlpR2NOSkRGeG5KRDdyZlkxekQydmRndXlXWUs4SDZ4UGc1bmZE?=
 =?utf-8?B?L1FRY0dXVldXY1NsWkJRQmpFWFJ1Nm9jMVN3VmdoOWJTc3ZYN0FlS29IYWJl?=
 =?utf-8?B?TTAySXJpbHo5cFZZNU1FdFJ1dEs0aXo5cjRVYkx1bDdOM1JycytxOXhOUnFw?=
 =?utf-8?B?RFB1MUdyTEZoVHhPRVRTa0tvV3NQN3JXZm5YRWFrOVZQaUp6VXlQTDRKbVRa?=
 =?utf-8?B?TjYwS2NQV0Nnd0k0WmF3d04wV0xOU3FlRHYxOEpFd2xqRDZOYXIrbXBZTFNE?=
 =?utf-8?B?ajEwMHVBeTFDbFNuZlJ5WU5uSkEwaVlnT2djM25aWjhCWngvM0dGSDBQSWlC?=
 =?utf-8?B?QlpGSkNXN290aVU4YmVVc0plb1AzZlord0tjTkptUmJSZlprOUs1V3lsTGtC?=
 =?utf-8?B?TGlpWkpmbVBoNXloZDkzaVRySEM0a045Tm1HS2VJZTljWXBYUTBaYm1aakhU?=
 =?utf-8?B?ZXVGa0l4OHd5Z0RpdnJXUlVqd04ya3pQZ1RXckp0bHNHMVNOWWpKc05TODdG?=
 =?utf-8?B?UERxanh2dXZHb1FhRUl0cHpJMng3NXcrSUZBcFU0bEUzNkdLdmY3M1U5M2kv?=
 =?utf-8?B?bUlNd2thZ2l4VUZ1WFBnYTZxdmxxc2lrUGZVRWZxblFVcFM2MER5a3JQNVZI?=
 =?utf-8?B?WUJDcGhqRURJWFY2WUREd0xFeGFyeThOaW5LUWMwTjNDTWZzY2RqYVduZVND?=
 =?utf-8?B?UmJPZmd2TmJZNG5DcWJPNjBKQS9aUUJtRUJyS2plOUxUOFpUK2ZRT3NFZEZY?=
 =?utf-8?B?UldaWCtVLzJMNVZBNHdTUjRNVzhZQlBaN1Y3OXlSRTlMbC9pbGhDM3NmRmhU?=
 =?utf-8?B?NFRRa3lEdnhjdEt5ckpzaEdsRk8yRG5lZGN4d095clRVT0x4WmdzQ0VmRWMw?=
 =?utf-8?B?dWVEZzV6ZitKdlVFUHpDbU9TdnlZV3l3NDdlb1lvRURkd3B5ZEhMVUc0TCtD?=
 =?utf-8?B?TXFMWWlGZFRXZFI0NXlkTjhERUdCdWMxNHJrZmIxTUY2ZkxES0p5Y2E4NEhQ?=
 =?utf-8?B?YW1Rc3g0aFVrL2MvNVBFSVlVSDlCUDJGdGVnN2FvZ1FzTmx2WitWZ3BDWnBP?=
 =?utf-8?B?RGZMU3FnamFRRXlvK0xVclZmREg5MmxHdjdRNFROSkYvVThUZ1JTSlJ6RVAy?=
 =?utf-8?B?TlByUG5ieWNxZjBwTUxLbzBlajl1bVhYbHhoUzBERnN1eUgyRkpzdUFxVzBH?=
 =?utf-8?B?cGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	yvQijsxKaSTWKtFkvVhAmDCPTMWR6LnLPb0ePLRE58NRZF19tS+euf7lD7Lbz07cE4eEOkC6wKTgYz5j1qWL6NkHOW4iwZr1hjrRnFNaIU17Z3KzcXfNdHUlVPifxz5jhCZr9+B/rrGYZXnwylc1DhA/AfiHVOI3l2P9yhbiyzV48KCLFyZ+ATQAMpSqscuZL91+AOA2ucPXqmpeVwbkhGkpzGc62DJzQgp83UhLtpEjyZ1rNq7j0VzNqLuTVSjRgIpRMH1tMyA4THwNN2S9rdBLg5z2za3hEsdN7MH3pdYIDRdjHocS+NQPk/z235e/OdGYwbevRkVkunO7b8t/gXwaPyNOOT32J78TKmfh77tZ0mPFB6IG2fyeFBx/cKktBOwMvWMe9eca6IpAWBPYbg5M4zGikCyDj1va9jxrNvPCzBW6GdYQgUCxiclS8E/uVFN6sT8COSGZNgySpNkxiMKa35OjbFkiJYdBBnAsrNzTucqTKY4ryoKS8ohgvR1pkIXzBJw3pheoz/Y0icpRslyA2NXTn8zu884v0bVCuc6JQL1B7bdpqh19e4XNHglq4CJLAjULkYHPrweRnIlEUSohdFXdGu37r7awg4PDxD4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5693513-7dbd-49cf-99eb-08dd476f2bac
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 12:01:35.8479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N6VmiB3Tllvdu/rgVcKM/7Pqq6ZC4g3ODzFogXmfoPA+R1EGmEtChNqZ4DcC7GRCGefZ205b8aqCihL4f8K15g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6708
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-07_05,2025-02-07_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502070092
X-Proofpoint-ORIG-GUID: BicUOa2nJgSSWFI2vsz0_Kp5e3WamTCk
X-Proofpoint-GUID: BicUOa2nJgSSWFI2vsz0_Kp5e3WamTCk


> Yes, bigalloc is indeed good enough as a start but yes eventually
> something like forcealign will be beneficial as not everyone prefers an
> FS-wide cluster-size allocation granularity.
> 
> We do have a patch for atomic writes with bigalloc that was sent way
> back in mid 2024 but then we went into the same discussion of mixed
> mapping[1].
> 
> Hmm I think it might be time to revisit that and see if we can do
> something better there.
> 
> [1] https://urldefense.com/v3/__https://lore.kernel.org/linux-ext4/37baa9f4c6c2994df7383d8b719078a527e521b9.1729825985.git.ritesh.list@gmail.com/__;!!ACWV5N9M2RV99hQ!OJKieZJEIvc-M87u_dxAxiEGC4zN0PQmfdLT6k73Y7_Lvr9m-iodyrytRCFxDPbVzsOlk-1kuXXvaKLA-y9kCQ$

Feel free to pick up the iomap patches I had for zeroing when trying to 
atomic write mixed mappings - that's in my v3 series IIRC.

But you might still get some push back on them...

>>
>>>
>>>>> I agree that forcealign is not the only way we can have atomic writes
>>>>> work but I do feel there is value in having forcealign for FSes and
>>>>> hence we should have a discussion around it so we can get the interface
>>>>> right.
>>>>>
>>>> I thought that the interface for forcealign according to the candidate xfs
>>>> implementation was quite straightforward. no?
>>> As mentioned in the original proposal, there are still a open problems
>>> around extsize and forcealign.
>>>
>>> - The allocation and deallocation semantics are not completely clear to
>>> 	me for example we allow operations like unaligned punch_hole but not
>>> 	unaligned insert and collapse range, and I couldn't see that
>>> 	documented anywhere.
>>
>> For xfs, we were imposing the same restrictions as which we have for
>> rtextsize > 1.
>>
>> If you check the following:
>> https://urldefense.com/v3/__https://lore.kernel.org/linux-xfs/20240813163638.3751939-9-john.g.garry@oracle.com/__;!!ACWV5N9M2RV99hQ!OJKieZJEIvc-M87u_dxAxiEGC4zN0PQmfdLT6k73Y7_Lvr9m-iodyrytRCFxDPbVzsOlk-1kuXXvaKLSPqPbqA$
>>
>> You can see how the large allocunit value is affected by forcealign, and
>> then check callers of xfs_is_falloc_aligned() -> xfs_inode_alloc_unitsize()
>> to see how this affects some fallocate modes.
> 
> True, but it's something that just implicitly happens when we use
> forcealign. I eventually found out while testing forcealign with
> different operations but such things can come as a surprise to users
> especially when we support some operations to be unaligned and then
> reject some other similar ones.
> 
> punch_hole/collapse_range is just an example and yes it might not be
> very important to support unaligned collapse range but in the long run
> it would be good to have these things documented/discussed.

Maybe the man pages can be documented for forcealign/rtextsize > 1 punch 
holes/collapse behaviour - at a quick glance, I could not see anything. 
Indeed, I am not sure how bigalloc affects punch holes/collapse range 
either.

Thanks,
John

