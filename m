Return-Path: <linux-fsdevel+bounces-65103-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A0065BFC186
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 15:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 18B7B566B9B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 13:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099FA33CEB7;
	Wed, 22 Oct 2025 13:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rTUYjDW3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yglBy2WX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5189727456;
	Wed, 22 Oct 2025 13:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761138620; cv=fail; b=iz4MNwQo1nbXV9EIzwblFfQLqm7r9Pm9ID2/9E4IdQ7jqZSUbDaaNr8aWAro/+zRm3aABknWOLwwONNUZrC11/0e7ew3ObUBxCV7MznI4C+yvXHHOfB7QEoM4gIc+hclD+n0PE4zTvXWgyHHaqpQ3H/xxzceL/vHycuGGknJM6Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761138620; c=relaxed/simple;
	bh=kHeIOUL+98JXbmH3q3snpWY8bfLFWUsahVCV4B8NxtM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Bbp2obVMUaVhqHAUwbzW4BME9i3HuwLpTJqHRuUzJ3k8nOOHSsKn0JwxLIRtWLd+xMuzzC6SZ2KJbkbL0XsrpPqX0C+f0TTxoQ2K7f8dVMxLAumCOPtI1400xZWD0Y6BvUK94qhy+UqqNC6NO6Ce3Lmxrd/nIHwwGliks5GFr3Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=rTUYjDW3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yglBy2WX; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59MCfWhH008337;
	Wed, 22 Oct 2025 13:09:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=huxBrYF4RM2wTTIC4ewACvYPxFAb7u/rK+qtd3GEFDU=; b=
	rTUYjDW3Z3g37bkwZUgrsPZSQyUIGfgSM2bFLOYUvMFzD698tYWDEz/mNe10w0ee
	P+gHIXPnFIta/se1r4uB976XBbuyRgIh2pqc+K+q+/VXkcfcgHwIWuvNB+Y+31tK
	s3WSYrSglN3zaNO8DlZno3r4HKXzgG6ZxiXfMV/y1DyzfYdyxnVOIJJG3Y8ZqGjr
	rpu6HnIzXBxqRh4wh6VD4X1a73kq9URPwI0sS4ZgzJt9BDiZdSTQkCdcZMB0Brcn
	zOlY84a6oXe8rVADlUZvad5QgiIptxx2iYqp5WjJrNrVibio7ZwWHcb9/Y6WGlvJ
	hspbM1hThkEDAhORmUq/Bw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49v2vvyne0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Oct 2025 13:09:24 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59MCckvt000865;
	Wed, 22 Oct 2025 13:09:23 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011057.outbound.protection.outlook.com [52.101.62.57])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49v1bd4x83-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Oct 2025 13:09:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f5Xn49TvEnMDJU29ZxoUnT4OAwY1oix4JGU8f1vDeEPD2isUrJ30671VVvBVDsRzgT36kjHH41KB3FyNFEqI1YKX7D2zUJu0Vh1UcpRQaUd1U4ttTvmRoTv37xWtS6W9yTG4Q4DWtzgsWeBYp0j70vSSwfcsJC+XsjqAK7gmEKfBxcJVyySBOnqhoUO9DW3jyrB4EYTLnLeDfahtUJqpQOfXPJHkK0foi1SGJSDC5XKGe+0kJlo2wcRiA4BCClAYJZGPakLxh//r2hfjgkTBVMcaJfq4erSgUfj7bC+s/9QnRDf7PWo0Df5DftC3ISLOj9UntKX2i5KeEeLh/aYedw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=huxBrYF4RM2wTTIC4ewACvYPxFAb7u/rK+qtd3GEFDU=;
 b=mmvRqWnKeSFJB6tE5RLhuW6LiC3W9Hq/3Ccbz0VuAnf1ZEeDH7Fr9KpL8/eAeZ4DEmMc5DO0+95uKqB33YpBshTQvj9b+vL5rDBa0GrOr6yvsz2o9T1gnmllBpD1mcaV8GERiSe5wvIBfWd1pz2R5Xnoyaq5fIAz2heX8si0x6GTaOmCigZKW8gg9qbnMRCIcGVbN5oSt25IS9CfYcEsomY+MqfAs4uICaZRkMJ/90RAP81BFQdEK5Xd2ny99trd8C7gHtGay9iOpohZOk4GGzW/sGPa/6ICdYCGmcoyABtpsXuj+1UgJ3fmX8jAZKuiEJ9er5wKKgHoEUfn8hbA8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=huxBrYF4RM2wTTIC4ewACvYPxFAb7u/rK+qtd3GEFDU=;
 b=yglBy2WXSzC1PGwzArTRLFlpYV4tNtmiMRq/QNIWAbJYKbEvehM/E5zcIjH3YONjmRntOqiK88wMYCWJfHeNQbvnDztk0ktOxjmgBvaOXyb0IR1xlFUPfwPERQKX6WUf01tRmRIW2cG3bQGpuI4OaNf5RljlBFNEjOwFAwDScQE=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by CY8PR10MB6489.namprd10.prod.outlook.com (2603:10b6:930:5f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 13:09:19 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%5]) with mapi id 15.20.9253.011; Wed, 22 Oct 2025
 13:09:19 +0000
Date: Wed, 22 Oct 2025 22:09:08 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Jiaqi Yan <jiaqiyan@google.com>
Cc: =?utf-8?Q?=E2=80=9CWilliam?= Roche <william.roche@oracle.com>,
        Ackerley Tng <ackerleytng@google.com>, jgg@nvidia.com,
        akpm@linux-foundation.org, ankita@nvidia.com,
        dave.hansen@linux.intel.com, david@redhat.com, duenwen@google.com,
        jane.chu@oracle.com, jthoughton@google.com, linmiaohe@huawei.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, muchun.song@linux.dev, nao.horiguchi@gmail.com,
        osalvador@suse.de, peterx@redhat.com, rientjes@google.com,
        sidhartha.kumar@oracle.com, tony.luck@intel.com,
        wangkefeng.wang@huawei.com, willy@infradead.org
Subject: Re: [RFC PATCH v1 0/3] Userspace MFR Policy via memfd
Message-ID: <aPjXdP63T1yYtvkq@hyeyoo>
References: <20250118231549.1652825-1-jiaqiyan@google.com>
 <20250919155832.1084091-1-william.roche@oracle.com>
 <CACw3F521fi5HWhCKi_KrkNLXkw668HO4h8+DjkP2+vBuK-=org@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACw3F521fi5HWhCKi_KrkNLXkw668HO4h8+DjkP2+vBuK-=org@mail.gmail.com>
X-ClientProxiedBy: SE2P216CA0014.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:117::11) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|CY8PR10MB6489:EE_
X-MS-Office365-Filtering-Correlation-Id: d40256e9-67b5-411d-3efa-08de116c35b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ajVPS2JpNzUrc2gxQXN4cVljRW5iTVR6SUFOYVBEZ3Q0S1pNSzZ2WWZjTWtJ?=
 =?utf-8?B?OXBtNjlsWjFhdG9FbkxDdElnK0hxNTYvVXJiK2habnY0ajJnS2dVQXMwQlQr?=
 =?utf-8?B?S1VkT2svbmVEdStFWUUweS9FeGVVZ09kK0hhY0IwUVViQUpZaEhVc3dHOUxh?=
 =?utf-8?B?VUdFanErV3NORkx0S096VTg2UzhudEgzWGhlTmlNcDVTMWFvODhLam1OTjJk?=
 =?utf-8?B?VHI3WFlIYW43ZzY4NnF4eE5XcjU1R1d3TzFLU2RnK21Kakw5b1RzT0ovck5N?=
 =?utf-8?B?UHZQcmhMOVZqeDgvNWV0dXAvcExaeS96OVMyT0JJTHZzQWFGRVZwN3lEYXQ1?=
 =?utf-8?B?M3cydHRVclpGWVdxZ2RqaE1KS1g3KzE5TVgzZk9ZaDBvNGpZYUhtNXlqNGo2?=
 =?utf-8?B?RnYvNWw4S1JXdWZoV3FlTjl4REZUZzQvQ2J2TmZNaURHYXc1eGVRQWpUSlNK?=
 =?utf-8?B?dnhrOGpzbTVJeXNFWE9rT0JtZmdqc0dIL0htZHFoUUJUMFZaVk1LRmRDaVRi?=
 =?utf-8?B?TVhaSkU3ajJNVDZEdzhDczFrZW4rQ29rbmhNc0k3WlYxNUFyelF5N3V3STJB?=
 =?utf-8?B?SThNYWtJZENHZlY0eXVITHhjMDhLSXliUzhmZ0ZPZ1kwak02U1YySDE5emNK?=
 =?utf-8?B?S3g1c1RNRk0yRE9sUHFieHNGTkdWRWRnU01vUG96ekR5NWJEK082bjROUVRk?=
 =?utf-8?B?UkN3R3BCdVI5THRtbzVxbVZmWVFkdlY5T0RXUStMUHV6SVZFWmV2QkNTS1Rz?=
 =?utf-8?B?WFFOQjdlU2Z2M0Zic1prSkw3TWY2YU1WRjVUTFhXOGVNSmIxV2N5ZmJwVmxG?=
 =?utf-8?B?cWRPY1pMZHExWUVreWVEWjJlVVdaa1JlQlhubEw3bm5oZHN1L3paQk5Zd0xD?=
 =?utf-8?B?aW10SElmcWNTbVZwMDU2YjBVUE5ZRjVQcDFXWVpmYlU2S1RsTlhhUmtNYmRm?=
 =?utf-8?B?UGg2S3hyMEJSNUhMYm0xWW0yM2J5N3lSZXBxbG51UEt2eFdsMHVIVm0zdFhB?=
 =?utf-8?B?SUg2STZocU04NC9TeHUrUXdpWnA0dFFqaTdyV0VvaGZiRmx1VVlvTUhXMXpz?=
 =?utf-8?B?U3RyMGhRKzJGZEUvZDlPQmNPaDlRTlJNUEpwMHRSd3NGLzJkU3B0d0dZZFJq?=
 =?utf-8?B?TjljaHgrZ21VWWJFNHY4WlVxK0dHUEtxRk9vc0JvMXg1TTRFMmw5dXpGYm40?=
 =?utf-8?B?WmlETWxMaGFzQ3hDNWoyamlZZHAwS0VuNjhSWUdKaHgrTmFDc2ZUbGFvak5C?=
 =?utf-8?B?MXlyYWxVTko2YzV0cmhrcWlnUkdwYmYvVjViV2VSQi8zU21CbXRTcVQ1VXBD?=
 =?utf-8?B?L2c1QWZ4VHJhYm1tdC9WTVUwRU5TL3M3cTlyd2hXbUNFL0s1cmlRa2p6SXJU?=
 =?utf-8?B?Uit1eFN5OEwvVEFybHVDRzczK2h1MlpWcFJzajdod1c0QTNvR09rRnEweGNI?=
 =?utf-8?B?anNxdDdMa2dvL2I2d0VSbDlSVGs5U0JQSkthaGd2NHNEVWlHUy9GeDVtWmdm?=
 =?utf-8?B?VEhDVFEyb3VHUmFpM1FTazJWS09IQ3hVK0dvOElydDVWZ3ZlTU1lMU91ZEty?=
 =?utf-8?B?Rzd1QTVYL21aWDhzWmFMeDA2c21aMnNmOWUyclBhdnlJZGUrWTMwWFdHemJ0?=
 =?utf-8?B?enRadEJZWTJNUjgrUUxOcU85TmxGVG9xdFRXS2YwMHNCU1JScFM5bVRWVUNP?=
 =?utf-8?B?NXV2QTgzVUVnNStQY3N4amcycExITWlUVHNESDRUZTdSekYrT3JUN1NKUkhS?=
 =?utf-8?B?STFpd0ptR3J4Y1dRanJJdFlTd2xtak5ub3FGbjhQcXNqalUvRDJiU2MzNktx?=
 =?utf-8?B?UVZNdWw0K0MrRGRNamJ3UUowZU9oZlRQUHk1cEdOaVVtdUNWV3k3S2szOWVH?=
 =?utf-8?B?eGc2RGJSUThHZFFRY21Gb1piTFUxN01NZ3hYZG9leTRyVG5zSUowMXhTNXVt?=
 =?utf-8?B?QnQ5M3pHVWtTUXV4RnhhR1pwTmtGR2t3aFFlL1l0QlhSdGNBZTcyQXJaZUhn?=
 =?utf-8?B?ZWNIdEFhanRBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NWptNEZnRGZobzl1M1k0QkhkWUlkNURNSjBKaWZSRlFoSitaZTVTR3hEL1Zo?=
 =?utf-8?B?aHJ0eFJrSHFONVJ5d3VWLzdTTWdDbFlhNkE0RWhaNWhiUmxTRkZlOXZHSWN4?=
 =?utf-8?B?V0UrenlGenVwOEFZZktiRFl2cnNjeGNNMDhkaTROOC9TSFp5aHhPTk1PWXJw?=
 =?utf-8?B?U1djNGF6VXFrMFJVZUQ5KzFtRXZUS2pFL1doZExpSUxPZ1JiQk12NTNSUzZH?=
 =?utf-8?B?VFFBTzRROEhjVTByend6d3BxY0htbXBGTFhvZFZPOUJQNEptUDVCMGJ2TlhX?=
 =?utf-8?B?bzdLWE0xRW1oendQUjFXdEo4RmdrZlg5WHhUNEZyVVRTS2IxdWNoVGtaeFQ2?=
 =?utf-8?B?aWtrTDBxQUxqTzZiYU92M1o2d3NwaDhMYmxIMnh2azFnTWw1Y0o0Z1NFcWov?=
 =?utf-8?B?bGV5dGc2QUhFT3ZaL1FuanV5NnRoclBPbVRxenMrM25vOFpGczhxUjYrRXBT?=
 =?utf-8?B?MVUwNmZ0NXBqY1RpeUJ6R3FPRUNyWlYzVklHQ2hjZ0F2c1JHRktYOWJPdFJa?=
 =?utf-8?B?OHRQY0w3UGk0VEJmbUwwdTlqdFBQc1NOSklZSnMvcHJKblg2VDBhb0kvUWNz?=
 =?utf-8?B?NlRhbXFYdUg1ZFdadVYrdE0zT0VMY0RXUndCYXhLQ3NYeXQzRHhDNnIrR2ZI?=
 =?utf-8?B?WTUxbnM2dG1uY2o5WUFScFc1VGk2SEpUdDloc21sSWFKK3ZYUkJ0MUlIQXl3?=
 =?utf-8?B?ckZOZ08zdjFqVE9FWmh2VVE5ZWlGV2lUUnRuZW9ZVXVjcUFaZDlPWDlEQ0hD?=
 =?utf-8?B?L2VoNm5wS20wYjM1STJ0bTNWZDdsdjArcXd4VWRhQ1dIRmV5cFRBSE9heXdh?=
 =?utf-8?B?dW5YMFRkSUtwRENMM2RDNkN4eXJDaHdlS0pENFBOM1pxVk94WUFVZlpBbkNO?=
 =?utf-8?B?Wkc3bUN1NDVoQmExeHdPSVRQSURCVlR4Rit6VTNlNjV6TUtUZmEzNGhkNkNK?=
 =?utf-8?B?c202TUEreFdzL1lxckhWNFc4Y2UyeEZHZ3RJNzIrT3lXbzZESFFkZjhJbWpl?=
 =?utf-8?B?VTJUdWg3QUJGYkpXSTlOQWZWc05ISElEZWovVFI2aTA0L0ZneXJPNm9IWS83?=
 =?utf-8?B?RGRtQnpLMFBtd1hpaXFvbW44ODllNGgrcTVlVW1kV0NEQmM1R2ZsRWNIc2Yz?=
 =?utf-8?B?Sy9Rb25SUTd6c1N0RHBqYldONlRLZmRDa1B3Y1I1cWpaSUN3N1h0SmUwblQv?=
 =?utf-8?B?cmtyN2FXelEydWptSTJCSzdQYXRCV0tvVVFoc3NhTm1jLys1WTVBeGtxQks2?=
 =?utf-8?B?K0hrTkZYMmIwbTR3SVZpdGdaNGpLN2E1SEZyampyR3VKTW0xYitVZXY4b08w?=
 =?utf-8?B?QVZvY09SZTBFRjA0OWt0UlJmUVlVNGJ0cThVeFRKZDVIck9DN0FnZVN0a2hw?=
 =?utf-8?B?S3MvRlBwUjg0QXpuVGlQNXFXN3RGbWxkdGdZbDRTcmtaVGxKNTc3UWl5RmUr?=
 =?utf-8?B?ZFFQelZ4ZUY4NER1b2laM004Nm55VW9MMGtYc1IrK2trRGJ3WG9DUXJldXcr?=
 =?utf-8?B?aWkyY3Nqei9KNVNWK3d5M1lCcGMvWmFnbVBsUTlpdVJUQ0poWFhneDFtVUVy?=
 =?utf-8?B?YUhOeUFHTEYrbjBrSW9JSnJ2SXhFb3VJU3MyMi8wRG5KL1BuQmNsa1ZUODVN?=
 =?utf-8?B?TXBBSXV0bFJsS1Z3bzBTaDdLSnQvUmsrRHNjV0dCTnRsRnBmRDhQeW5GY1dZ?=
 =?utf-8?B?TjdXUkZ2WCtVK2Q5SDZyRXQ1QnYyYWVTMVJ5ZUIrWFdiVWdtT3A2SzEwdkpj?=
 =?utf-8?B?c244SHhQUUpFL29MVGY0bXU3eExoNHFaQ1BMZkhQWFd4Yi9WNWFycW9pVFRB?=
 =?utf-8?B?UXByUmg5b3EzKzZHMDBDamZwVkhoR2RuMHc0Y1hnamsvRjA1b1V2VTFNOXU2?=
 =?utf-8?B?SlR3WERKNXRxU3hHc0dFS2xickdHRU5wZHd2S0R6OEhPZjYzOHQ2TDNidzVi?=
 =?utf-8?B?R3ZqV05WWnVqSEo4aEl6S1dySXdudzFiTmQ4M1pGKzRtTGJBVDZRcjJGeWIw?=
 =?utf-8?B?MzdKOWJvR2FXWWNib3RIdks0cnk4WGRzQlFxQlowZWpPUHplcThZZmI4Ujcx?=
 =?utf-8?B?ZVFZckV6TE5IM1dwS0RXZW1SbzJ3SEFPSEpsWVE0Ni9NSVgyQm9xVllRcURu?=
 =?utf-8?Q?GoSylY1OCXvmIlKO1NuIlzMYi?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JlV1dDJKB3Q+/pnvJ7zUHMue1LCt5g1VQdPXPXrjoqKJL6A07A5j027STGS6GgXMW0L3DPWlUtdh/PlRLrCO3gfWQA/cUHJcopoecpE78E/YJyQOIhGCGNUrjt0XQTos7VqyH64pXAk5EteM+IJxjgU9ig583IjCmp8AaZAUVCBGzMDcHFWYPMAm8l0NG6fN8zijjy64oJZr56jhynwx9PeqQmx9fXmLOiQ0Zsq/ZHYpdEHUzoaNCQkuhLvs4LlZBkUwauhv8CSnHrmZxG+8X/lC0Gn8JtWkk+zvRnqTBMNFCW6bdMGGp2e8ObAryuKTFZSBlTEPBYJJ7RkFEgoHOJahRSOFf5Ol+ZhxYLl0TIhIG1A4xusKAzBbeTc88Wg8EFPPkYu4mkZkWqe8g0D6HBSRspV8m9Hs0PelQ3uqckp6QV1z7bW2jB3vOGhiimDMPr1EduaNDypTwUtpAfziJWxu9B2vl0Sp5NZSPxLRAVjFDPBO8/gWk797z4TDoSkM+WThJu5QQzqpKHN8gkXNPK8xNV/UShzkC/S0uQ9iwGZ2HZKkoSkNlkLUTDBB6wnmYD02rbMJtxVumIQH8E0ydRJBfDUBXcTTIF4XRzPP1zs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d40256e9-67b5-411d-3efa-08de116c35b9
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 13:09:19.3100
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tqk3l7edyneX2ZFDJ+6xctYGgUUnzs7wAutYMD9ajDqwVviXdKhIIdLRFJ/l1Ir5TDm7m0/a0bq5zhNbw+PHyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6489
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_05,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510220108
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX7R5+yf1RJemm
 nR7S4whBnhI4HXBJbY3L4I5UsyoXG3t+zJsurXhk31vuRdPeAI+mS1ohNs+P+aj9IE25yrabV3W
 Cumez4D6FNVxhV2xllGcRBbi6bLpynyc2G+73DApXO0GVpq4U/GTmXFBp/rtABF201knZzr9s4r
 DNjgdG94Ue+PBK8I5Wk84SR79E6m8DVtGXeIDK5dyAI1ycUEiaoPswIFzEUzFsKt1llqCR9vRBm
 +O+FR8/x2zyK5HS1sZLgKIoYpc+bSwJmkDuvapHlhkvNA5UFIhGlOVChHDFrjX3CeV52bJCWIA+
 USXtcYBG8aotwoBDafOrfwJkVTygCEU0C4xsokVIYVcVg7jmV/e5oDsecLWCbmyoFqxEZCNHKcS
 L8nQKkbZinJCjBrkDZ9tfuuVixdQdw==
X-Proofpoint-ORIG-GUID: ZkThcl003-4dXvsmWkwXSQhTDysP2Goy
X-Proofpoint-GUID: ZkThcl003-4dXvsmWkwXSQhTDysP2Goy
X-Authority-Analysis: v=2.4 cv=FuwIPmrq c=1 sm=1 tr=0 ts=68f8d784 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=yPCof4ZbAAAA:8 a=wpB_Zc1G12QRhWHQA30A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10

On Mon, Oct 13, 2025 at 03:14:32PM -0700, Jiaqi Yan wrote:
> On Fri, Sep 19, 2025 at 8:58 AM “William Roche <william.roche@oracle.com> wrote:
> >
> > From: William Roche <william.roche@oracle.com>
> >
> > Hello,
> >
> > The possibility to keep a VM using large hugetlbfs pages running after a memory
> > error is very important, and the possibility described here could be a good
> > candidate to address this issue.
> 
> Thanks for expressing interest, William, and sorry for getting back to
> you so late.
> 
> >
> > So I would like to provide my feedback after testing this code with the
> > introduction of persistent errors in the address space: My tests used a VM
> > running a kernel able to provide MFD_MF_KEEP_UE_MAPPED memfd segments to the
> > test program provided with this project. But instead of injecting the errors
> > with madvise calls from this program, I get the guest physical address of a
> > location and inject the error from the hypervisor into the VM, so that any
> > subsequent access to the location is prevented directly from the hypervisor
> > level.
> 
> This is exactly what VMM should do: when it owns or manages the VM
> memory with MFD_MF_KEEP_UE_MAPPED, it is then VMM's responsibility to
> isolate guest/VCPUs from poisoned memory pages, e.g. by intercepting
> such memory accesses.
> 
> >
> > Using this framework, I realized that the code provided here has a problem:
> > When the error impacts a large folio, the release of this folio doesn't isolate
> > the sub-page(s) actually impacted by the poison. __rmqueue_pcplist() can return
> > a known poisoned page to get_page_from_freelist().
> 
> Just curious, how exactly you can repro this leaking of a known poison
> page? It may help me debug my patch.
> 
> >
> > This revealed some mm limitations, as I would have expected that the
> > check_new_pages() mechanism used by the __rmqueue functions would filter these
> > pages out, but I noticed that this has been disabled by default in 2023 with:
> > [PATCH] mm, page_alloc: reduce page alloc/free sanity checks
> > https://lore.kernel.org/all/20230216095131.17336-1-vbabka@suse.cz
> 
> Thanks for the reference. I did turned on CONFIG_DEBUG_VM=y during dev
> and testing but didn't notice any WARNING on "bad page"; It is very
> likely I was just lucky.
> 
> >
> >
> > This problem seems to be avoided if we call take_page_off_buddy(page) in the
> > filemap_offline_hwpoison_folio_hugetlb() function without testing if
> > PageBuddy(page) is true first.
> 
> Oh, I think you are right, filemap_offline_hwpoison_folio_hugetlb
> shouldn't call take_page_off_buddy(page) depend on PageBuddy(page) or
> not. take_page_off_buddy will check PageBuddy or not, on the page_head
> of different page orders. So maybe somehow a known poisoned page is
> not taken off from buddy allocator due to this?

Maybe it's the case where the poisoned page is merged to a larger page,
and the PGTY_buddy flag is set on its buddy of the poisoned page, so
PageBuddy() returns false?:

  [ free page A ][ free page B (poisoned) ]

When these two are merged, then we set PGTY_buddy on page A but not on B.

But even after fixing that we need to fix the race condition.

> Let me try to fix it in v2, by the end of the week. If you could test
> with your way of repro as well, that will be very helpful!
>
> > But according to me it leaves a (small) race condition where a new page
> > allocation could get a poisoned sub-page between the dissolve phase and the
> > attempt to remove it from the buddy allocator.
> >
> > I do have the impression that a correct behavior (isolating an impacted
> > sub-page and remapping the valid memory content) using large pages is
> > currently only achieved with Transparent Huge Pages.
> > If performance requires using Hugetlb pages, than maybe we could accept to
> > loose a huge page after a memory impacted MFD_MF_KEEP_UE_MAPPED memfd segment
> > is released ? If it can easily avoid some other corruption.
> >
> > I'm very interested in finding an appropriate way to deal with memory errors on
> > hugetlbfs pages, and willing to help to build a valid solution. This project
> > showed a real possibility to do so, even in cases where pinned memory is used -
> > with VFIO for example.
> >
> > I would really be interested in knowing your feedback about this project, and
> > if another solution is considered more adapted to deal with errors on hugetlbfs
> > pages, please let us know.
> 
> There is also another possible path if VMM can change to back VM
> memory with *1G guest_memfd*, which wraps 1G hugetlbfs. In Ackerley's
> work [1], guest_memfd can split the 1G page for conversions. If we
> re-use the splitting for memory failure recovery, we can probably
> achieve something generally similar to THP's memory failure recovery:
> split 1G to 2M and 4k chunks, then unmap only 4k of poisoned page. We
> still lose the 1G TLB size so VM may be subject to some performance
> sacrifice.
> [1] https://lore.kernel.org/linux-mm/2ae41e0d80339da2b57011622ac2288fed65cd01.1747264138.git.ackerleytng@google.com

I want to take a closer look at the actual patches but either way sounds
good to me.

By the way, please Cc me in future revisions :)

Thanks!

-- 
Cheers,
Harry / Hyeonggon

