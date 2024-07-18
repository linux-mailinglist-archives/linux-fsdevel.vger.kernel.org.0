Return-Path: <linux-fsdevel+bounces-23924-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E1EB934EDF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2024 16:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70B411C21E18
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2024 14:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB1CD140E4D;
	Thu, 18 Jul 2024 14:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PfcMPqZa";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="u6YYhT1+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07AC813B286;
	Thu, 18 Jul 2024 14:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721311717; cv=fail; b=FRajFxEsmTD73EK9tJZbTFYqmy+NVkPbCnLN3YQbVldJtpQaJewUe+1W/6NDKYq3wJ3c8Q+ExgvEFXK/j2LeedMT6B5ZySJ0x4xaB/LhP2gujlME1Dan/3uqRbFDTLDlyxQq4fenC/YYgwU3UKeTRci5jPKVCFx9feE4tc+CMrU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721311717; c=relaxed/simple;
	bh=+sT1Zn2jkxYoIoQjArjeqWubYMKQsyWrZ+k/0jcNoME=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ckqxcQbwD6LSRfmN8HPUxUiuh/oOmE5ApqhK+4Exos8QxSYnPW5qB1NEtGGjeQXv1S/NgmeYeCEsZdq/SX7vlPeWwN+iopT6m+GGb00ipQmiuODe39nTcEeJR8bJMRDSsUMYxBwUELbxKsOCr41AbvS0QpLOFOu8sdT0rvbac80=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PfcMPqZa; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=u6YYhT1+; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46IE0vZJ013005;
	Thu, 18 Jul 2024 14:08:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=AF+ell67TEI+xs3aRAKsK4pxSuxh6qTgSOG3Im59Xjo=; b=
	PfcMPqZagXFgdeTSXlpSFggJu3j9IyQQ90TLRO3RWXx4CC5lVGipWEuMQrJGGK3V
	eftABSVIoN0p8nEFMtwRCd3EhJSS911dU75CTzHXsLUTmEY3ziktMIQiY3+gAtII
	waI+5yEp0gQ8fWM5O0BKxOQmugiGZYbsyPFX1vJ2er6HmqDDkKhDbRNmeoU4MrQB
	hSwjmrnE9ki7TuZhV6ZfjyeRzRf5eoISIdlmWSJprIpQeRvKZZ1ipznJm8Y+O7ga
	/ZnInlBBeQkdxBejGU7PCHRPWg3Z5lHOTLDH2G5o9oCeC8jktwb7cb5f1RAeDFT1
	U7HlWla6YBhdXqAZVkqzsQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40f4e9g0gf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Jul 2024 14:08:08 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46IE7iY2006860;
	Thu, 18 Jul 2024 14:08:07 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40dweyyd87-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Jul 2024 14:08:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hbaf/cuK5Q7OR64DZGo0XvV17CJnAA9svblxa624AuwXTlSnVFpDhpyvCI7iaPM3ZDK/BUL0rZ5F2Xeusm64esR5qBwii/CLzECSj+avMdOBGnGzgq1KT1ky1AkANPr7GhS8NBRg0NGr5td+u3VAb5K0H9weDTXY8h6ZViKEAqCIKDbRoQefeJERRcveDWVWJBPD9aiE2BNrEv1n9SeHpm8AAA2OyICdorcdFcUHDfIcWoxCo+ia1U2JE2n0O4nVwjeADY+m2aUpDO1MCc6Fexg1+I56vl5VkBiSAvrDuAJVwiXUA/qmzFZ+lWPG6BH5I9FOIyY8c5iIZZahmzFYyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AF+ell67TEI+xs3aRAKsK4pxSuxh6qTgSOG3Im59Xjo=;
 b=nqsnTKUewZz+IqtOeTNTdgtPl63BKYz6FN6CqxMJkChXOQtT6b3mmVuuTQi8W3b5OIhVbJC6nzTXdkgoo+G6KxOtdYMfCm9qs8gm1h045pYAW83SHvskoQKdxWkeYPBn0UWTMjgg8a40T/a5t+TwnxhnTudcfTzoZqIAtcBrVWvhPKfwrCTGS9HFlAoXx6DQpsJAUas/FzdOq2Oltaeu2mn8UWvm7dmCFKQLOYRLY9/WyD7A1VfKbb2GZ+dAKB3dFC9rm/aDC4bleoiF0TjS+3vR3z36kq1zhZjqftYos5LPIAOUohAP4ilJGTzK9fx4J8gls2IEly33pUNsC3nYdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AF+ell67TEI+xs3aRAKsK4pxSuxh6qTgSOG3Im59Xjo=;
 b=u6YYhT1+POLvFhSd2qVYub4qLLYDlXITUD3gN1+kFNszoNNSxKyTMOWDPNetekC1e6r/VfYEKfTnQ/GnwUedslOCwoUlopSoGcjc9HMH6FQbGIrvpDCsCp9RcpI9vtKm8zECeu69xo5C9IH6cQRrqGKtx3g5MOyhtcNvbCSjix4=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by BY5PR10MB4228.namprd10.prod.outlook.com (2603:10b6:a03:200::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Thu, 18 Jul
 2024 14:08:04 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7762.027; Thu, 18 Jul 2024
 14:08:04 +0000
Message-ID: <2eb8c7b7-7758-49a3-b837-2e2a622c0ed9@oracle.com>
Date: Thu, 18 Jul 2024 15:07:59 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] readv.2: Document RWF_ATOMIC flag
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: alx@kernel.org, linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        axboe@kernel.dk, hch@lst.de, dchinner@redhat.com,
        martin.petersen@oracle.com,
        Himanshu Madhani <himanshu.madhani@oracle.com>
References: <20240717093619.3148729-1-john.g.garry@oracle.com>
 <20240717093619.3148729-3-john.g.garry@oracle.com>
 <20240717214423.GI1998502@frogsfrogsfrogs>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240717214423.GI1998502@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR02CA0218.eurprd02.prod.outlook.com
 (2603:10a6:20b:28f::25) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|BY5PR10MB4228:EE_
X-MS-Office365-Filtering-Correlation-Id: bebeb771-65c2-49fb-64f6-08dca7330a7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?ZmRzUHVwdE1mMUErendmZzE3cHhQWEsxUWliSHFVM3B0UFd2Z1lCanZBa0dU?=
 =?utf-8?B?OVVPVVJ0bm1ncTE3OE5oSXc1VEhnMVZzY0djMVJGY25EdTE2eUh1UUpDKzVK?=
 =?utf-8?B?RU5va0x4ODVtdDFZV09KUVJLTE5icmZHdmY2cXhpamc4eEJ3Z2NMQ0pmZm5B?=
 =?utf-8?B?TURZbWhBSGxCMXJqUTZibWRtZmFleEVhbHBJcDdicS80c1gvTG5uc0k1M3h3?=
 =?utf-8?B?UXRXMHZtVEtJZHp6L24rb0NPdDhlUWxxTnBuSlBUaUVLK0wwZzhSSjFzeVhk?=
 =?utf-8?B?T0FkQ3c3SWdhaHR6YkpNSG93MFpTTkx3aEV4M1B4U0dncnNXZ0QrM0JYMVdI?=
 =?utf-8?B?NzVGOUlNdWdiOGU5U2ZhbXQ5VFhKUU5JK3RJdWpBTFJTbFhLTzZpa1I3Q1pm?=
 =?utf-8?B?K3RzMkRrai9iUUxyRUx4K3hsSCs4a0c1QytzV01ja0prY0RQUFNCS1NzWUFG?=
 =?utf-8?B?RlZlT2F0YXJRaVZJUWd2ZVRqYldsNDVDR0t1M0NuMGxwRVVyeVN3TWtmUlRi?=
 =?utf-8?B?U0hvN3FGSTRoWVNMQnJNd2hHOEpYVzFFRXg3bU1abDMwZDJqT3JsSW1lMk5r?=
 =?utf-8?B?VURXODhFdytYWWdkSkw5blc2cEVtOFNWUHE4YWFVek5mTjBrSjNRTmwwOXFK?=
 =?utf-8?B?SVcvdlFqa1NXWjNWR1ZGTy82RlhyaVNPUHhlTEhMWWxFUk9xNHlWdkZqcHJ6?=
 =?utf-8?B?RFgyWnc4YXFiZHNQQkgxWkJGMlV6Z3BuVmN2Zm54cTdTZXhsZlpaTTdWV1k3?=
 =?utf-8?B?NSs0QmtvdEYrbXNVQ2hKZHZZZVpsZ1lkT1FuV3dFRUtwQ0ZVYzQ1ZU04cXRI?=
 =?utf-8?B?NlpBRVV1Qkx5eHVhWExQZ1B1d3Z4Yk84bUdHNHdyVWQ3WnFhODdQdWVibzE3?=
 =?utf-8?B?K2NHbjZ2YjFiRjI4YWdyWElSS0t2YUd1SE80cHRFdmxMdVExY0RuQjMvbTVB?=
 =?utf-8?B?cjJVaEVvd1hoc3loUXdyZFQyaDFXTUhudW40ckp5YjZpUzg1SHd4ZEpMYjV6?=
 =?utf-8?B?Y2NrMkN5Rjc4cHhkYXU3S0tyODE3MUcwSVRjdUlCV2s0cjlsdGw4OVBkaTNa?=
 =?utf-8?B?OXFLTDRlWjhMZ2xkZXB6NEFMZW5BN1lKbmVJM0RMZkIzeUtzVE0wUWJMdTJk?=
 =?utf-8?B?ZC83UEdqOHhUMTR5VW9GcXhZTjJrbTNQcm1hYnhvRGcvb1RTYmh4MnRDcDAw?=
 =?utf-8?B?S2lrZ09mSktjS1htNkNlOUJBTEc3T0FlSmhsREpVZGowcGREL3dQNytYQmN6?=
 =?utf-8?B?Ui9yckQ0dEFwTW5Na1A5SDcwSFV2R0VUejlPS082Q21RQnZqaGpvVWowV0w2?=
 =?utf-8?B?T0ZMYUZQV1doaXcraUNodkFnL2wzYXl2dk05WnQxRWNqT0VTZVpySHBaeXlX?=
 =?utf-8?B?eDNORDdpKy9QY3JhY0ptQzNlajJLelI2RDJHTDRXUEJla1FVNjRiT0Jtckhp?=
 =?utf-8?B?RXhqdG5CMDVtbzBlVlFKZDh3ZEs4ZTJkRHplelQvYm9HTkkxR0M1Nzk3Q3pS?=
 =?utf-8?B?azJZWWNXMEtTTjFTc0ZJRkxVUmxlMCt3cFJXc0oxbTR5cWV5T3MzOFNPa2xM?=
 =?utf-8?B?cUF6ditSK0kybXRsVlBWRTFYWGdMc2lrUENSSWVjQ3I0MGlGVWoxMG1LM3lQ?=
 =?utf-8?B?aG56R2d1UThJQnVJSUdrbWc4MlNtcUNUMzdsSXFXSTJLU0hDUnRzbGE1bXpU?=
 =?utf-8?B?NzF5b0NUMkRmSU9pVlJ1dW4ybGltdGtDQ2ZYNFczSkg1SWVVWWIvdWdVbk9s?=
 =?utf-8?Q?vm/1zzWgtU0rIZI+XU=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bjJEaGFjcFREbXBuUlNzdnRQd1YzYTg2SlI3S1NmREVJQjhxTGtjWTA1VlFl?=
 =?utf-8?B?b0dLRVpBbTl0QTR3WVFIcGtjbCtjejRiN1hWYTdPdDUvSUp4Y0hJcjc2aXRp?=
 =?utf-8?B?SHlFTFByMGZ3S3llTWxUYVVtS2FHYUhOUkxSdDE4Mm9lMk9walpIUWxzYlV5?=
 =?utf-8?B?T212dTVOaW9zSjNNby9taVloZnErNytwZjZ3TzBJM1FPZ0k1THAxT2YxMzZ3?=
 =?utf-8?B?NmJVeS9aQWQ1bHQ4Ni9xbXpkNG95UTlVWVE4aXd4RjNIcnpIcjFsRjJ3Vzhq?=
 =?utf-8?B?YmZXSzVjL2xhdWd2dkIxeUNLUkhnS091V1EvZVRweTBOUHh1MGhNR0NtQjZh?=
 =?utf-8?B?SXd1VUhWZTB6Z08zZEF3Q2tBcEpMUC9heDFGdTAyKzQvY1JTbFdxVjdGQ2lS?=
 =?utf-8?B?cTdrZHVsZC8ySnVGeS9nM2tsVE5wVkFkdEFYNVNMZDF2Z2hVWWhxRnljRFdX?=
 =?utf-8?B?OUQ4QVhPK29PZjdDNU94REU3MitZR1VnSzcyb1FNb3NTU0l0L3FKOHMzZVhD?=
 =?utf-8?B?TkhJVlgwRFdsVnVPdGJoWWRJdWU2SlpQc2lYR0d1ZUhObGdDUXVpZTZQekky?=
 =?utf-8?B?NXc1UVE1Rm9rNG1lbmc5ZEZ3eVZMcjZPK0owZytoUktvYkxZbFRDOXpueEts?=
 =?utf-8?B?aUNSYVhBRVZvbjdRc0pzdVVwV1RlejdjamVlNXhlcFhCMm50aURLcG5CY3Vu?=
 =?utf-8?B?cEtpRWpkbWVoQlNjN20wSXpsVGJEQ3kxbkw4K1kvRmFaOHFmelhScVY4d1hy?=
 =?utf-8?B?M2RyTDdIWks0cGt3QmdJS0ZEaEtkSGFqVlE0QnFvS0RxcWx0MklJRW4zNmRP?=
 =?utf-8?B?V0Q2bTVwY2E1YzlPQnpHQXpJbXZyVG9Oak9BV3dyY1Q1SGMwY3FBWTRBMEZB?=
 =?utf-8?B?ZFdUcTg2R0R5V0lGTlBaRC9nOXp0c1pndUdYem1PRUVqeW5wY2JSb0lHN0NZ?=
 =?utf-8?B?dkU5d2ZOWExJY0hQajI5QURYMXQ2Tm41MFlWd3FmZGFvL2JxSFpablh1RkZR?=
 =?utf-8?B?U1FFV2s0Z09TQ0lTekN4TGVBc2o2SzBDYTBtV3laQ0dHYnd6TEUvalBFK1Z4?=
 =?utf-8?B?bU0zNmppNVpPYlN6WFdvVWR3Q2h3SUVLekt3ZzNESEhUVituOHRoTTVIRlF6?=
 =?utf-8?B?UjJ4aUMyRzg4MEJxdThDSy85akkra2YxWmtxWmhpVGM1NDBrVTlxRHc4VmJa?=
 =?utf-8?B?RGR5Z2FDV2JmV0pUMmpncFJ1ZWRGdk1sMnZwd3pBRW8vY0VHdk9PYllrTGd4?=
 =?utf-8?B?ZHNzOWJrZytsNzRrekl4bkUwZkphYUNVZ0lCeGZhNHVRQldBQlU0K2FYb1lK?=
 =?utf-8?B?TVZYdDhkRDYyRW9heXE5S0MrdXN2L1ZIcVNGRDk5WjZBVnNkd3J1elJBc2Fr?=
 =?utf-8?B?UkhoMk91S01vbG9mcHNXVGl2ZWhMd0ptOFZMSnY5akJ6ai9MUzJBWDREdHFD?=
 =?utf-8?B?NndkVnNSeWVneGcrYXFkUFJaS3AzOGpYWHpjRjFFdElGUklhQ0RUWWtRRFJD?=
 =?utf-8?B?QlJZWHVoRGYzWEJVVmZ4Q2dsdjFNOXdQQnZuZEVETERWRnl6REZSVjF4aVAy?=
 =?utf-8?B?TFA0a3ArVUJiRW5HNGNtdW9mRjFjaVVaekFOZmI0OVN6TWdCNUxlYmlIaXJz?=
 =?utf-8?B?dkpEZjRvc0hUcCtrSU1oaFNMTXE3aUx1RU1hNFcwdUhyaDhGY0dndkxoZ0tM?=
 =?utf-8?B?VVoxS0hEclZTUVBSTXIwdWpva0tSZnpoU3AzOEIxeWdqYWxZaWN4ZTB3eTcr?=
 =?utf-8?B?aDJrQ1AwZm1xYjFyUE1wMURhL0t4bzNVRGxWSnFYTWhPMGIzbWZyQWUwYlBL?=
 =?utf-8?B?VmFPbm9JeENkU0tsOFkvZFRnK3FkaXY5Y0VNemU5NUNnK3o4Yjhtb3g1YzA2?=
 =?utf-8?B?UnZONTJnTlpQVGNsakQ4QzNIcEgrRkVFL05rUjVibVdFR1d6QUFsNmJZTlBx?=
 =?utf-8?B?SFg2ME9uR2gxVDZ2a2lkazdIL3Z5Q3llQ1NJVFNzNlJ3QUlkbXQvK3dYUllH?=
 =?utf-8?B?OGdVUi9HVFdLZEFVTDlTNWtQdVlhR2cyYndkTzZSRnYxbXNEU04vVTBlbUta?=
 =?utf-8?B?amErbHJuRTNxV1NoWFhtdFNuZHJTdUdCaERtaHJTYXdTNkkrZVBDaFFoaElk?=
 =?utf-8?Q?lAiYr0HPFHSEXnqCZE5QkWSRJ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	3UyYS66Fnz+3eGKWd+1i+KH8dG24lv4nbIat4Z4w+jLMEka0qarByHvd/gYLEKJ5G+7Pq5uV9aAQk4MsgdxozWlWP3NH2E4bYAjghCty31NsujJaX/hRx9cRprfiGYCloCTCUq+CNanuhBhByDztN0A9qCqT9s2GfJuMqv+T3DCoojlvl15sQWtCu0HgX5dlyoV43XmLGCSCGOnEOreRwYHWyqOd4op//TC1uzTKZteOvFycLXCG1+v0IjEYf5aDQ9/c3PRm9z6GtwjTt6OIyQEEgXszZNmqLXBuwMmAGqOVp3JGpIHGKXVbuxm/PGvWKkcahG2uFgr3xuOj7ZtK1O8XDepm3EyF8Idb+G2b9PwofjvO9DypxVheLFA5Usfs7oN/4/bV8niJxJJs7/1XuVXbJnrAVk2pGuBF0u2/GJZu3TP9Q6a3heaZ6QaSqVZXCwy+uvUF9fiFtk3UHVk9GDi+N/S7vmsqKcLefTNrOXkcjw3ZfgMLHCTfiGHOF/hnB7eMxuV+vTAX15CFfoQbI8JW+RnAb9wr0563kTueJK/QX0kJsClB6Stya02+Bv/eweXguy9C04LouwDN+j9RMbr9D8TrzLYfPPCT6dYwcGc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bebeb771-65c2-49fb-64f6-08dca7330a7c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 14:08:04.3003
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Di2bQjjoA03Zxp9Q+czHW0+R5XQ0vqnYf5ms+1r1wHp9eShpZ/gZwO4aYHN1dg+YSyRsGh84vQ5++E3OAX+Lzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4228
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-18_09,2024-07-18_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 mlxscore=0
 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407180094
X-Proofpoint-GUID: _e2PIcMDMg1tt0N_EV3LV-tOzlWnt5i8
X-Proofpoint-ORIG-GUID: _e2PIcMDMg1tt0N_EV3LV-tOzlWnt5i8

On 17/07/2024 22:44, Darrick J. Wong wrote:
> On Wed, Jul 17, 2024 at 09:36:18AM +0000, John Garry wrote:
>> From: Himanshu Madhani <himanshu.madhani@oracle.com>
>>
>> Add RWF_ATOMIC flag description for pwritev2().
>>
>> Signed-off-by: Himanshu Madhani <himanshu.madhani@oracle.com>
>> [jpg: complete rewrite]
>> Signed-off-by: John Garry <john.g.garry@oracle.com>
>> ---
>>   man/man2/readv.2 | 76 ++++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 76 insertions(+)
>>
>> diff --git a/man/man2/readv.2 b/man/man2/readv.2
>> index eecde06dc..9c8a11324 100644
>> --- a/man/man2/readv.2
>> +++ b/man/man2/readv.2
>> @@ -193,6 +193,66 @@ which provides lower latency, but may use additional resources.
>>   .B O_DIRECT
>>   flag.)
>>   .TP
>> +.BR RWF_ATOMIC " (since Linux 6.11)"
>> +Requires that writes to regular files in block-based filesystems be issued with
>> +torn-write protection.
>> +Torn-write protection means that for a power or any other hardware failure,
>> +all or none of the data from the write will be stored,
>> +but never a mix of old and new data.
>> +This flag is meaningful only for
>> +.BR pwritev2 (),
>> +and its effect applies only to the data range written by the system call.
>> +The total write length must be power-of-2 and must be sized in the range
>> +.RI [ stx_atomic_write_unit_min ,
>> +.IR stx_atomic_write_unit_max ].
>> +The write must be at a naturally-aligned offset within the file with respect to
>> +the total write length -
>> +for example,
> 
> Nit: these could be two sentences
> 
> "The write must be at a naturally-aligned offset within the file with
> respect to the total write length.  For example, ..."

ok, sure

> 
>> +a write of length 32KB at a file offset of 32KB is permitted,
>> +however a write of length 32KB at a file offset of 48KB is not permitted.
> 
> Pickier nit: KiB, not KB.

ok

> 
>> +The upper limit of
>> +.I iovcnt
>> +for
>> +.BR pwritev2 ()
>> +is in
> 
> "is given by" ?

ok, fine, I don't mind

> 
>> +.I stx_atomic_write_segments_max.
>> +Torn-write protection only works with
>> +.B O_DIRECT
>> +flag, i.e. buffered writes are not supported.
>> +To guarantee consistency from the write between a file's in-core state with the
>> +storage device,
>> +.BR fdatasync (2),
>> +or
>> +.BR fsync (2),
>> +or
>> +.BR open (2)
>> +and either
>> +.B O_SYNC
>> +or
>> +.B O_DSYNC,
>> +or
>> +.B pwritev2 ()
>> +and either
>> +.B RWF_SYNC
>> +or
>> +.B RWF_DSYNC
>> +is required. Flags
> 
> This sentence   ^^ should start on a new line.

yes

> 
>> +.B O_SYNC
>> +or
>> +.B RWF_SYNC
>> +provide the strongest guarantees for
>> +.BR RWF_ATOMIC,
>> +in that all data and also file metadata updates will be persisted for a
>> +successfully completed write.
>> +Just using either flags
>> +.B O_DSYNC
>> +or
>> +.B RWF_DSYNC
>> +means that all data and any file updates will be persisted for a successfully
>> +completed write.
> 

ughh, this is hard to word both concisely and accurately...

> "any file updates" ?  I /think/ the difference between O_SYNC and
> O_DSYNC is that O_DSYNC persists all data and file metadata updates for
> the file range that was written, whereas O_SYNC persists all data and
> file metadata updates for the entire file.

I think that https://man7.org/linux/man-pages/man2/open.2.html#NOTES 
describes it best.

> 
> Perhaps everything between "Flags O_SYNC or RWF_SYNC..." and "...for a
> successfully completed write." should instead refer readers to the notes
> about synchronized I/O flags in the openat manpage?

Maybe that would be better, but we just need to make it clear that 
RWF_ATOMIC provides the guarantee that the data is atomically updated 
only in addition to whatever guarantee we have for metadata updates from 
O_SYNC/O_DSYNC.


So maybe:
RWF_ATOMIC provides the guarantee that any data is written with 
torn-write protection, and additional flags O_SYNC or O_DSYNC provide
same Synchronized I/O guarantees as documented in <openat manpage reference>

OK?


> 
>> +Not using any sync flags means that there is no guarantee that data or
>> +filesystem updates are persisted.
>> +.TP
>>   .BR RWF_SYNC " (since Linux 4.7)"
>>   .\" commit e864f39569f4092c2b2bc72c773b6e486c7e3bd9
>>   Provide a per-write equivalent of the
>> @@ -279,10 +339,26 @@ values overflows an
>>   .I ssize_t
>>   value.
>>   .TP
>> +.B EINVAL
>> + For
>> +.BR RWF_ATOMIC
>> +set,
> 
> "If RWF_ATOMIC is specified..." ?
> 
> (to be a bit more consistent with the language around the AT_* flags in
> openat)

ok, fine

> 
>> +the combination of the sum of the
>> +.I iov_len
>> +values and the
>> +.I offset
>> +value does not comply with the length and offset torn-write protection rules.
>> +.TP
>>   .B EINVAL
>>   The vector count,
>>   .IR iovcnt ,
>>   is less than zero or greater than the permitted maximum.
>> +For
>> +.BR RWF_ATOMIC
>> +set, this maximum is in
> 
> (same)
> 
> --D
> 

Thanks for checking,
John


