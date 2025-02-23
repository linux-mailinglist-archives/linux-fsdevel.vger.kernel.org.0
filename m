Return-Path: <linux-fsdevel+bounces-42362-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA87A40F68
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Feb 2025 16:19:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 156173B27B4
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Feb 2025 15:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 299E42080C7;
	Sun, 23 Feb 2025 15:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZQGWKB7E";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MLRm8mla"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58E5EEA9;
	Sun, 23 Feb 2025 15:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740323947; cv=fail; b=gD8xFbHX8gywrssOSzCpttJWKMlvwl91ztoF7gEdTFVa7c3GGm7tTZQQU4foQq3pV5twXy9WmQGqZGklDwILI06w+sbVEdfRNEZobLxotCVzo3S8JsV3SVqI0CTlrZgVxkikU/k+cjIoFh4kN/l7Ch2MYWyYLxlROp2t9Qb6XNk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740323947; c=relaxed/simple;
	bh=nliMCcsxtIe6HTEpdyG8J9NS78O2MS+KbbZkuQT6EZs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=T+Dj8ADbVf4eR9jD19o3NmeR9UuHKfvC6YdV4xKMTPNQicPYMFXzAV5EoTpDKjNU7kI2TCE6xSAW5oXGnNHqh39zwjvOJ67s1lhpoXniRX5lKFnTNcVOlmxBW9qJ+M8Nz/bTo/MdDkxCTjp4i6IXCZQ/5G8ytvSHXKhPT2IkUg4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZQGWKB7E; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MLRm8mla; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51NCivaG010803;
	Sun, 23 Feb 2025 15:18:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=v3w/WHvnLB/il0pYbEtleTTPPTgnfSHTfgOVJyOcX04=; b=
	ZQGWKB7EWCWlJaWMshTUK7GYwvHNq+tL179ifRzvdueofxiI77ZA7Q9XkuEBzCnx
	QE5Z54GbKxtorakZW71XEQrJGnPST4na7LH7m+AcpT7ffyG2ze9bMOzY0ueC4DVK
	rOHZjuSMill0d69PxAItZlsOkVUFLeVa85/TWUDa7YtY7P20tdPlto3fCkOoW6Vs
	Iwe0uyIHcsFAs44lRuu65M3xbopQQTfpuAkAIuEsKaDLAAl/RJ9FJg4CDFCyJPTW
	kYLjwXoXXCPhO/EGlbBRrso4Dwu/Gy3mUM/eGVLHVwPMvOjbmsOcvAjgzuqmE5DK
	H3EehavOxfrswTtMjE+opA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44y56019hc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 23 Feb 2025 15:18:54 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51NBdTq7002929;
	Sun, 23 Feb 2025 15:18:54 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44y5171wb2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 23 Feb 2025 15:18:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tz5aLQM4c5naaFWrD/tgoi/ijmOoK4aiZKlH6gG85EriiHoDGidOQ0zIU4ov3HdZf6IsGKtB5EdTFyAK7FzHnCuTv5dG7nFVPxsBuZLMlzjAXf+pUIZiigsGwrL+3qJgrVg4k9knqu6kWNF253E0mUIRJNJJc7S3mXTHwnHNhZyJ1vtWpDrcIs+PXAK+P/6/ueonmPJUdpGu4AuvR7ARAK4OG7WUT1pfeA5LYk68s2Kml8pAC/okepdIV0aLRczq1gJovcr9uhkGxv4kqwdLFwV+ByDBrFC+kOgv/tt9pgFPCF7wFD9U7f+F0p1/biV9SNrnA/in5H0/xNK3yWw5Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v3w/WHvnLB/il0pYbEtleTTPPTgnfSHTfgOVJyOcX04=;
 b=RhOYAq9++Xl9w2zmsIrUfZ9ab720mnDEt+xCEGpnD2Ht4sl9cjsgYizvSB3SE7+McLS01B5CeRImwl4Cx5l/ggYg9305Vq2JDwqY9tPjGt6wyEfGVOszSam+soJ6FXMZLTK8FIS2xE762h2/O/v7xeeCwnHh54n14Qc2Z1I6KJqKmGoVOpvWZ6jQiEwtzzcXMcpFj3pjEf7U6pPAopLeAbJCB9tipk4B78V/5+hWoOfMY35yG1xlP2xmiwhot/fwH1tqPOjtWugpx3k+pyrHWNCV5nx0m2gRL618yICnA+rnEHQnGLIJWPd9iMVwUM9yX/5qT99VXoC3GBwRByRALQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v3w/WHvnLB/il0pYbEtleTTPPTgnfSHTfgOVJyOcX04=;
 b=MLRm8mlasMffqZPlSaQSMoO3Pb2TFqvWMQachktur3TdwDEYqSkG/OiuVRGG9QeMqAnZrJBRnOnmGNqtuwRlvvu2ZUGHLnjqJdXMayAgPx1iWipx7YkG2MA1UdRtjGeYFzDYonlCNCWIpgk/v6r5d6f6JSnJS6YP7EFJ/PC5fDw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA0PR10MB7369.namprd10.prod.outlook.com (2603:10b6:208:40e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Sun, 23 Feb
 2025 15:18:47 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8466.016; Sun, 23 Feb 2025
 15:18:45 +0000
Message-ID: <dede396a-4424-4e0f-a223-c1008d87a6a8@oracle.com>
Date: Sun, 23 Feb 2025 10:18:41 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Chrome and VSCode breakage with the commit
 b9b588f22a0c
To: Takashi Iwai <tiwai@suse.de>
Cc: regressions@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org
References: <874j0lvy89.wl-tiwai@suse.de>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <874j0lvy89.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0323.namprd03.prod.outlook.com
 (2603:10b6:610:118::6) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA0PR10MB7369:EE_
X-MS-Office365-Filtering-Correlation-Id: e6bb66a2-cf14-4a8d-5a34-08dd541d5c51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OXZxUVYxajNQT0hvNHpYQ0h6ekp6aWxaVnYyMnhDcXN4YW1XVWRkRUZKeGlT?=
 =?utf-8?B?RVVJN1JJK1NHWTJ3SnpyUmR0WDZhczF2eFdTUjJMamQzRWFnTHpBZHRuNXNY?=
 =?utf-8?B?dDEvcCtKWHBhV1NuU29zeDJrL0o3R2E5cnNsMjNTRUJVTHpHR0haN3ZUMGxz?=
 =?utf-8?B?ZkExN0VxWXpuWVR1cTZRTm1jZEEzaDBjbVZFWTdFdTE0ZzRNRzMxYlBXSitt?=
 =?utf-8?B?VW9yLzB5cTdjN0RJRTJ1aGN3U241ZmRIOFVvYlpEeW5UQ05RTm5ocHVqVVZZ?=
 =?utf-8?B?U3ladHdRZEVVMWJsbks0amQ5UlpBT2dEcDdqdG5jaGpITVBUMlpRbEtGTnZW?=
 =?utf-8?B?T3lEYVhOSnU2WHlpNXJJWkFVZ0RVaWtWcWFsY1FxWk1UUG5wbmppRFE4cnQ5?=
 =?utf-8?B?Ryt5NzhLMUJ3Vk95S2hhdHo1M1Bqa3l5dW5RU0RGWjNiQnFzdnRCaStRT3hJ?=
 =?utf-8?B?U1VOREFoK2VBR2diaHJuaHN2bVdoNnl1bHFCRVVsUXJ6R1RCMU82bVM5MXJL?=
 =?utf-8?B?TXN5blNSWEJtVk81bWUyaGF2cWVreEpQZDJTSkdQR1JidUYyYlRWNE9tNVlS?=
 =?utf-8?B?WCtIdkRnSEtaTWdqbTVFcGc4cEdOeE5peEkxcktMY1o0YTZQOVVIaXlsRmdW?=
 =?utf-8?B?SXo5QktCQndNMnBoQUpDUUI5UEtXUEhvTTJCM29leTFUTUtrVldpQk1sVVQw?=
 =?utf-8?B?RDNFNDRSRmR1dnVqRGJneGg1Y0lXNjFIMUpqeUJuL2xHZ3pnWSt0ZFB1NXdG?=
 =?utf-8?B?TFJUQ2xib2YwU3IrOEEzZGFLcnRSQUtjQmY4WUduRjdpcjV2QmpseDVtZlBX?=
 =?utf-8?B?ZEtHazBxU0V3NFR4OFZQZDRDcU1SU1BlVGNTd2FNL2w1ZURjeGRxYkl4amFr?=
 =?utf-8?B?d2FzOVozWURlWkViVVBLejdNd0duWFN3Ukw5OE0yTHh1a2xPT2VTSHAvY3RB?=
 =?utf-8?B?cmYxbGltenNCQWR0MEJLV0o2UlJ6cEFLcDQ5Qy9hYkZIemx0c1ZOWnQxUytv?=
 =?utf-8?B?SFN3aDFxajdJQ3hEZE5RUHJBNHpMZEJXZXc5WlExOTVSS1gxY0ppVTY4b3JS?=
 =?utf-8?B?ek10R3pkamhjOTNHbmF6SFhOTFh3ZkdaVS9iYnhEZ3Y4NFhHbng4MTg3bkl5?=
 =?utf-8?B?Wkp3aGJaYU5oYmJmeHdKNE5FTXR2R0VKRStxQmp6WXdnUndvcnpoWVluUytL?=
 =?utf-8?B?bXFrOUlFNXlUcGtScVJnWk5Rb1RnMEk4TWR5SXVpbTgrR085MHVRK3RGTzE0?=
 =?utf-8?B?UThVSlBuVkhuRCtORmdBL3pqNVNTcVdQQkJXam5IR1JrWlFpQitFMmZvZzN2?=
 =?utf-8?B?R1VwenozSi9iZitvaFFEVUxuWHhWU2VTTFltcXpZMXhabDI5akViZWhNWEto?=
 =?utf-8?B?SDFBTENoU09UVlNaQndKTEVydzBmV3p4S0dvai9IYTlDMlhZM0xrMmlSbHA4?=
 =?utf-8?B?cTJ5cWtMTTZyNXUwTFZZR3cwanEyMTV2WTZCQ1dvOUxmMk9JbXpGZmdjZWwr?=
 =?utf-8?B?TUFRRzB1YXUvVnViSTVBQ1BzQXArZ3ErTlN4ZmE0M1RwTzBRRTRQSjg2bVJa?=
 =?utf-8?B?bjFEdUpySytYUHh4OHRHWWlWbVFmUG1WaHlhbXliallCVlR4QS9iSWhtWnJm?=
 =?utf-8?B?NFE2UHNYOWZQRzI5ditsemRhblR6Sy8rdndrUXhnVnpndnRzQXRXNkhpcVNa?=
 =?utf-8?B?UXMwMi9TRXdITHkrSVpIMEJBMVdreno4aC9qSTQrMFg5bTFYcSswUjB4QzYz?=
 =?utf-8?B?RDkxSVFiUE9xNGJTR1ZwOC9CeERZWlF6ajVEajFpMll5YllJWTVJcTlDSE5Q?=
 =?utf-8?B?UmxYeDdINkJoK29DeXBFQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TE15ZzcrelBQa3MxNUNtaW8vekt0eE1IeXViR3FEenBGSTNRL3dFRGFua0s0?=
 =?utf-8?B?dmE5T2J2cW9wdUdvLzhweHhBcUxmRjZuQyttZFltKzUxK3I3M0FEa1MzOU5l?=
 =?utf-8?B?Ymw2ZUsvL0l2WW5PR1BvZktLaTB3MXhTc1hEazMxdEkxUlJFaVRxd1d5b0Qz?=
 =?utf-8?B?Wm1HbkFVb3Zsei9aZGFKVEE0b2c4YWxQZE9FdlBBNGFhb0w4bkNmSGEvbWFD?=
 =?utf-8?B?SWVwV2VIS2pXMzVsM01GQnBVNDBtYlBHMEg0cmpUdk1wRGVoR0t3YTI0aHRI?=
 =?utf-8?B?UjRZKzd2dmlhY2c2V2p6RUUxVjJKQ0U4VHZKMXVJd3YrK0tCOEdwUFE3aTlG?=
 =?utf-8?B?aUlsMS85T2NvVGNWNy9IRWc4b1dZbEw2cXFyWFVwejk1TEp2TE5WeEUrMmlq?=
 =?utf-8?B?ZytLRmRRZlRJbFBVeDlFNEt2aTl5TFkxSVBPeFFEMHdFTEU4TzBrS1YxWFha?=
 =?utf-8?B?dnRFWVh0Wmw4M1drbi9FWG9aV0FCM01MSnJXK0hiTGttWlhxanhMUmdCc2VE?=
 =?utf-8?B?NnZaQTRaWlVQeS9mY2s1Zitwd0czR05kTTc5SDJhVG1FcE5mZ2hwVEdJbTZR?=
 =?utf-8?B?UWRCNk55NXNOem12Q21qWTZCOG5icEVyVUN4VFFYNlQ3cXM0MjcxRjhmSU94?=
 =?utf-8?B?OW5LTGY3OFM0V0JFZTRmNExZdFJKVmNtbHhWUEtkOGVwQ013UUF1bXU5Z3Q3?=
 =?utf-8?B?ejJEZ29rNDJvMFkyWkhTYldiNmZ3YWNSS2FIUmE2T0F0NnhMMWtDZnZjMGhN?=
 =?utf-8?B?OEFhaWwxK0k1dzJqd2VuV3BJU25Gai80aGpaYkR0YTNYZ3dJeVlxRFZXK3VD?=
 =?utf-8?B?NW1rcGtXWmFHUGhib2ovd3RGWWVwWkZISVlrZ0hRVmN5bU1FMHlxZURQcnV1?=
 =?utf-8?B?K2dYcnZkRDhIUVF5NExEWTl3eUhGeUljOVQyVTN4TW5zYTVFakZWWTc0cWN5?=
 =?utf-8?B?T1psZkhyRXpmeWlLSnlYWEU4ZURaMjVRZGo4N1kveitiNXRCNUorcmhvOWkz?=
 =?utf-8?B?OTMwZFJEcjhxN2pnVnpkd2FTUVVxMFhqWE84OXpHdGkvM0hnKzNVK2hrS1lG?=
 =?utf-8?B?Y05pUkEvaFhBN1VsL3FVQXZGSE1DU2xMK2MrbitxWnAvT2MvdFhueWFRdlpW?=
 =?utf-8?B?WXV3NUFCMk4rc20vMUsyd3QwU3J3eW5vWGh2d21JQWtMS0hXVWs1NllJeUN6?=
 =?utf-8?B?YjFoU2hINnJvdHdxZlhva0NUbzVyUmU0ZGF2ZHZ6anZndEU0dzhlUFo3eEVD?=
 =?utf-8?B?b1RSQVpEQm1POTNOL3lTSURPSWJZOHU3cHVuNHBRdHhSYk1Ma2w1NTRKSmRu?=
 =?utf-8?B?V0Z4cHJIQ1JOdHg5WkpkeWUxYU9sRjdIdlQxS0dPakpadUJOd3ZDaEpnaWNM?=
 =?utf-8?B?M0ZxR09HZ3hjanBzbVc2WlBoOGQ3dG9zZ2dkWXJPQ1h3SzNuZ1VXdWIxU0FJ?=
 =?utf-8?B?dHJLL09mdDNuVXl1dzNwL3pPbEoyNHVKWUxrU0JtUlM5VnRnUFgybWlXaEVp?=
 =?utf-8?B?bmQ1N0t3UWR1a0ZOaWI4MWhKTC9CYVQyajk3NXAzRWgxbGFUVDZUSXlOT3RL?=
 =?utf-8?B?amJyUnB0YXN1VUJ0QSs3aUlqK1hZbTZ3b0o5SndUSkkvbDlTaFl2L3VKS3dl?=
 =?utf-8?B?RmgrdTRScFFQS25zQ2RZMUFIcCt3Zmt3dEpaU2xvL3F1c1NUQ1ZJd2VkSEJn?=
 =?utf-8?B?U3p4ZFJWODM5dXFER2dBWUxYTEVjQ1JEL1hLNE5VZjRUZnVYa0xTZFJTb3oy?=
 =?utf-8?B?YkVrS29JVHRadHVVOWpkQlM0SWJHWjJlazRDME1DMVN0cVo2ZHJOSE0rc1l2?=
 =?utf-8?B?YWpTTWJvY0VscHY4ZSttamhLRXZDMlcxdGtLd2pPYWlWSHh4SDFobzRtUmgr?=
 =?utf-8?B?NE5RNTIyelNaK01NaXhWM2d0WEpDQyt2enpWMlV3RjB3YXROU25XYVdtbzJy?=
 =?utf-8?B?cmtxSUlzYWRUc1c4Z2xlVFY0UVdnRVdIaENwZU52MlhrT3JmZUh3UEd2WU8y?=
 =?utf-8?B?LzZXTGk0OXgrVFNxd0R2c1FoNldBYXZJMUMzM3k1bW9PanhtMzhrS2lXT1dE?=
 =?utf-8?B?TmdkUFJOOHpxTkQ0NmdwN002TFkxMlNIRE1jMTRzNG9vTUpkNzBhbHAvWWdU?=
 =?utf-8?Q?UuM26r/7Jn6GcqRVOU354KOhY?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ZFejBsXoE6GvGNTUxepxsKgC5UBEJfdjMpM0j7Gjw7iIEBFEmuFKVnwDbo0xIyeXx9rTjzQ7WwjOwaV42Fbs/Y2dwNmcV4QhFuVrOOTtXACT73mNRzL3BES4XXSRKz06ohcoTYlnwlbH5twAFLoptzZr0MbO2RZKeRpwh81O0TkRHjREaYrE53A/HHkZhI17CzIVp3bDJBBjQBB0MgTZxgNG5wh+g8PKWjtDgtrmIoysOuz1fKWQMTQvrCudzBEYDqo5YOWDr2nDy0hiAJVb6NY8MEw/RnsIy+mcgWcpbO0ho7rQj//nt+3rk9AJiNaQHYTLF3+i43gPMw0TuSqXVN4jrdtKIBPpj3zNTDucxJJGQTLfhevzbPGnOz0xjEnp078r3H3B/7cFVGOuabyFlVyII/3MGoU7Pwkuv5sCXE9+06ZkfbAo7U4uCSq6851eZ7K8XlfRUORP17OWYLm0D590k3B7uji99QW5CIIL9uPR7ARCsTlYYH+FeispV7NqjVWKShyFloJD/9e/SFed1O30mtMZkSGm7KE40GYltjxAzv+Rf1GJh2QEAOAuyZJwhY8vPr9QCGly/ADRNUBcUt/+1jaR/iR62SBC6SJHlMs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6bb66a2-cf14-4a8d-5a34-08dd541d5c51
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2025 15:18:45.2335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TJ3WEOoizHglsIhzwzemkPB550QxreQ2ot3JfU7U3YHm5+juXYey9YHwAMIx50u5apMxWVahMdkXmf5D4A6H3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7369
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-23_07,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxscore=0 adultscore=0 bulkscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502230120
X-Proofpoint-GUID: FtXOI7NWnrhvdF0_ukTWZPUYKBN2Kirb
X-Proofpoint-ORIG-GUID: FtXOI7NWnrhvdF0_ukTWZPUYKBN2Kirb

On 2/23/25 3:53 AM, Takashi Iwai wrote:
> [ resent due to a wrong address for regression reporting, sorry! ]
> 
> Hi,
> 
> we received a bug report showing the regression on 6.13.1 kernel
> against 6.13.0.  The symptom is that Chrome and VSCode stopped working
> with Gnome Scaling, as reported on openSUSE Tumbleweed bug tracker
>   https://bugzilla.suse.com/show_bug.cgi?id=1236943
> 
> Quoting from there:
> """
> I use the latest TW on Gnome with a 4K display and 150%
> scaling. Everything has been working fine, but recently both Chrome
> and VSCode (installed from official non-openSUSE channels) stopped
> working with Scaling.
> ....
> I am using VSCode with:
> `--enable-features=UseOzonePlatform --enable-features=WaylandWindowDecorations --ozone-platform-hint=auto` and for Chrome, I select `Preferred Ozone platform` == `Wayland`.
> """
> 
> Surprisingly, the bisection pointed to the backport of the commit
> b9b588f22a0c049a14885399e27625635ae6ef91 ("libfs: Use d_children list
> to iterate simple_offset directories").
> 
> Indeed, the revert of this patch on the latest 6.13.4 was confirmed to
> fix the issue.  Also, the reporter verified that the latest 6.14-rc
> release is still affected, too.
> 
> For now I have no concrete idea how the patch could break the behavior
> of a graphical application like the above.  Let us know if you need
> something for debugging.  (Or at easiest, join to the bugzilla entry
> and ask there; or open another bug report at whatever you like.)
> 
> BTW, I'll be traveling tomorrow, so my reply will be delayed.
> 
> 
> thanks,
> 
> Takashi
> 
> #regzbot introduced: b9b588f22a0c049a14885399e27625635ae6ef91
> #regzbot monitor: https://bugzilla.suse.com/show_bug.cgi?id=1236943

We received a similar report a few days ago, and are likewise puzzled at
the commit result. Please report this issue to the Chrome development
team and have them come up with a simple reproducer that I can try in my
own lab. I'm sure they can quickly get to the bottom of the application
stack to identify the misbehaving interaction between OS and app.


-- 
Chuck Lever

