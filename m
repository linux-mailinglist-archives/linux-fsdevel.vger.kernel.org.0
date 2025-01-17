Return-Path: <linux-fsdevel+bounces-39475-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 016EDA14D86
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 11:27:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E533188BDDD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 10:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE5A1FC10F;
	Fri, 17 Jan 2025 10:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QqSoKQhN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Z1/02Tl2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E48471750;
	Fri, 17 Jan 2025 10:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737109615; cv=fail; b=abwJaAWhC01TmYUYRJaf7j5gZXzZt96v+RLFgYbZ3V9pOHN5lHXj3LChM1Pt4mvj5DmB/Mqx/wzr199hFefIgoDwVZW6sJmqaDj6vRBfVGEA1iJ3NiaDVZyq1tEvcdd+zATWTAdhQq3gLW/gTjTOvVCyGDpxcq0RrpwDH4Goozg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737109615; c=relaxed/simple;
	bh=nqAfkeKTjfSI380mWjvVG7FYDYJB0Xnvd/xPRsLlFNA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hXvmOVnA/cZEICjm7sPgIF+JcaonUy5ayZYdJkGkHFrXn/UmW4M466/g7ZGdbVj2JDi6NOngeRgh0P5i4mJHVWAsefJGIss3kb2LVOFqmD5jkIdGbhLnFyK06XCC45ohdWrpVzO01QFvfWGPz4jF7a24Xn5jydT6812Eu1hZnsI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QqSoKQhN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Z1/02Tl2; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50H5uWDR001518;
	Fri, 17 Jan 2025 10:26:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=gb/M4wKHHMlq526h44gDbBSFRRdrgIkz7neLypSJxEY=; b=
	QqSoKQhNFykIPaTLju3IskSaATOojAb1KBdU5kua+GJtd7j6n02M61SVknfr7JzZ
	OUMMRmqIEHe5vsbufj/ngIPufcXomECm8064xvUCBLwPnwe7Aa1kaLZUGy3M0mKS
	CXmiVl9uXkuEHHRhuc9G+X+JOMHrrySwcblTOXLLVzr0GPKfZ9QaGoZMM4QytCof
	218lNkvhjEg3S+BMVezAZm/kYPwpguYY31v6Q8CqxKlbEHzTUj06758SrHWp52Ui
	R2GYnPw9riQfXGT5oP7wRTicIOPSYFF+dPozxNl1VMR29SrjrYlliLsra81JQ5Oh
	P2Kfln662JFktG1K6BvEzQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 446912vxwm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Jan 2025 10:26:41 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50H90cKw037036;
	Fri, 17 Jan 2025 10:26:39 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2043.outbound.protection.outlook.com [104.47.57.43])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 443f3ck9th-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Jan 2025 10:26:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NDANf7dnfBWaGr0xQr3hs6fBlNxu3D07aeSMgDox4rRhn5MRzSfhPJTQ3z4HMcXcFdKik0/yBAQ//Z0YH/LpZpUNNc3F3OkHEIZaqhMJ4su+zRPBR/IK7LDnFbF84VMFeHeUKUmCRt69X+w+kpGG+WQCibKoC1tVabXqGGcvdWR1aAk9hYSz0RNmVCUx1qSGElM6PAMgZAK90qnrkDmQ1vB+8N9HizUBDVlTgkCTcQ5CfEPzu8w1nkeq2XUcrXPrEHO8QldgLRJvLY8tVFmi7zH+lFeIaxxpDgb4RGlOWE7QS9N6Nca1vr0hcleo/2bz3MFphEmu/tHTiRxr1eYkIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gb/M4wKHHMlq526h44gDbBSFRRdrgIkz7neLypSJxEY=;
 b=Evr94Ghq6nVHXC3Y1b91hsbpqRVEcNC4sOLD5fpYQav0kChNun/tuOI9/QKWHg74ihupeYFpx9ZVskKuu1J+Sk8d2EoEJK4lHozOYXlmVNyc5L9yWr+oPjpWtuwNXzx4dTutbBwXcUk0P2Mx9TlU1SW+ZNdQhRt72HjNEBOnXFuQKuqn6NU+DqEqRXdqX+tDUU3iN3h2OXQVeODtJjf8Pg2BhI0Ed2yTkoeKiYCtkNTYXC9n4MroMin03+Hh7xgg5iQqx7aA8co/RS4v+tmudcf2gxkqfcHhwF5nWspo9zNOQ2Wi5/dO0a+9ZXXGaZmNFH5h4jLyET9duBI+WO+VEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gb/M4wKHHMlq526h44gDbBSFRRdrgIkz7neLypSJxEY=;
 b=Z1/02Tl23RWo0M8JqFYjPiUX4fkXleCQ1xWBPEhP9jDfVjTmiBuHRQ+9u88gLWWRe2ndo9t2tJlMpYnRWmDCij9KXb/lgSxQ06cBGjKxP/wXyQwjIBTSesgLIUIDotKF5oLuTd6nL7odTiYBHCUjueSNxpHyINugspJyVY/EWDg=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SJ2PR10MB7787.namprd10.prod.outlook.com (2603:10b6:a03:56c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Fri, 17 Jan
 2025 10:26:37 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8356.010; Fri, 17 Jan 2025
 10:26:37 +0000
Message-ID: <01e781da-0798-4de6-ad03-6099f15f308e@oracle.com>
Date: Fri, 17 Jan 2025 10:26:34 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] iomap: Lift blocksize restriction on atomic writes
To: "Darrick J. Wong" <djwong@kernel.org>, Dave Chinner <david@fromorbit.com>
Cc: brauner@kernel.org, cem@kernel.org, dchinner@redhat.com, hch@lst.de,
        ritesh.list@gmail.com, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        martin.petersen@oracle.com
References: <20241204154344.3034362-1-john.g.garry@oracle.com>
 <20241204154344.3034362-2-john.g.garry@oracle.com>
 <Z1C9IfLgB_jDCF18@dread.disaster.area>
 <3ab6000e-030d-435a-88c3-9026171ae9f1@oracle.com>
 <Z1IX2dFida3coOxe@dread.disaster.area>
 <20241212013433.GC6678@frogsfrogsfrogs>
 <Z4Xq6WuQpVOU7BmS@dread.disaster.area>
 <20250114235726.GA3566461@frogsfrogsfrogs>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250114235726.GA3566461@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0075.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:138::8) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SJ2PR10MB7787:EE_
X-MS-Office365-Filtering-Correlation-Id: 1468e16f-156e-4a4b-d9ef-08dd36e16c4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a3R1RUtTeWwrQmtieXdWeHpjZDUzV0d3MUlKZnI3YWs4NWEvSDdrOUJ6Um5i?=
 =?utf-8?B?dmdkaVEwNzRMaTF2cXRPUkJ1Y1NyMDkxTmx2a1IrTTF4MS81MkcvYytvS2U1?=
 =?utf-8?B?Z3ZtcWFjbTRYVkdaTW1TK1pzL0RYWVJNUFJZbXM2SVk5OHBqdFBhNGd5cHZH?=
 =?utf-8?B?RVlqUFFJVmVJTVlCOER0bjAra3YyYUFQMStWMGNkZ1pPSHMxMGJDcTRMT3Qy?=
 =?utf-8?B?cE55dG9sOUtVZUFSTGJ1VW02Syt6bU50UHIzMFpUcmVNNkJFRFVMUkk0Rkgx?=
 =?utf-8?B?NHZSNzMzUlE3emNiU29ZVFVUUzIyaUFKbUgydVM3K0tDS29qU1V1eXl4V1dj?=
 =?utf-8?B?U1dKdm5KSjV6WkY5N2U3MkRpallySmJoNDJSTmJ6VGt0U3puRTdoejhNY240?=
 =?utf-8?B?RnJ4RUduVmZTWFVMQTdIUlk4ZHFpeTZXVDZNQXZMeU5TZDMxaTJ1NzIzNkMz?=
 =?utf-8?B?OU9QNUE5Rjg2VzdkS0xqTjRPVGpxRnZsVndydTUxRWVINlUyRXRQT3ZYU3Zi?=
 =?utf-8?B?M1pXWU9MQWxuNFRzMWpIUzFxNURwRmRwVzBFdGRjLzFlaTc2bmZIL3p1VzBN?=
 =?utf-8?B?eEUxY1hhUjhxdTJMTzI1ZkpLdzRGS1hpblZpYjBHeHJTK2gvYU8vOUdHajM4?=
 =?utf-8?B?YzVVY1RDa0p5NU0rV0VtRjAwak45VVZISU1EQjZXaGJ0b20vNDNUaXJ2MkVW?=
 =?utf-8?B?bjZLSXdZcGQ5aWxITXZBZXBubzZXUjhrRG81enJsNG12WnpBZnRqMkhyN25a?=
 =?utf-8?B?amw0VkRLa2k4UWxHWGN4SzAzQ0JDRGd6bXVqY3RDNTZGT2hTSWpTMkZqbUR3?=
 =?utf-8?B?SVQ2S3VQVE9MckJTSVZkL0c0S0IwMkR2cllCQzBSbmxpaUVucXJaRXV5TVpM?=
 =?utf-8?B?bXdhV1RKNXlJZjNycHZBN1ZCMzR6OG5tbGViRzZBd2hSb1pXNDBiY254YW1H?=
 =?utf-8?B?Y213LzhJVHFQdVFWNkFwOU5TVmdvUVNTNmRmUHZLbzRGbHhBQ3FWZmFIaW9O?=
 =?utf-8?B?aDBtZnRYeHFFajY0bThnWTZ4Mi93MW9WdU9JSFlMMHRFRENwN1lQbVE2YW1J?=
 =?utf-8?B?UC83bjRwZk5HQ2MzVWhHcTdGb2FzQytDUS9kUHc2dm45YnhLdEFyd1FaTXUr?=
 =?utf-8?B?a1lJVmdic3pDRWdHS0p3TEJpVCtIUXRHYlBmemdKOXNEcXpBYUhxL0ZxQkdE?=
 =?utf-8?B?ZVVtTUtvSUhWaWI4dmN4Z0k1c0Z4OGxpKzhVTHA1MEpKdjVUQUNFVSs2ZjN5?=
 =?utf-8?B?Vm9ySEw0RXlacDROd3ZwUzU2Z2hXSGgvUmhiblE2YzlERVdHaDZwVnJpYVgv?=
 =?utf-8?B?VkRIQitjSEF4RkVBV0wzZ0tkWC9MVGd0QVl4NUxUTzdDaVZtY0hSd0JlOTFv?=
 =?utf-8?B?SE4zU1RTV1BtMGhDcnduajl4SGdCVE1tc2h1YmwxNkhlZ2dTWnJJSTlCUUJt?=
 =?utf-8?B?dEtHV1V0Wlp6MFBIZzBMa3dVb2cyNVJCSk0xVWg1emRrTDJzbWN5aUJXQ2Q5?=
 =?utf-8?B?R1YybVVueDVsanJEd2dLZlpGT0RBZEM1U0NzVEhPd2o2Nmd5OTBIQnVoUjM5?=
 =?utf-8?B?UFY4U2xqb1ZRS0lnKzFyMG95UWEzdWhJMFFsS3VDZjFlUGxab0JUUG1uQURi?=
 =?utf-8?B?U3R0QXlNbUZxMkZKUlVhUzVUY0ZhUlV1R2NjMmw2cUZFd3BMMVdWYzhXZTNy?=
 =?utf-8?B?c25CSlBMUlh4bzBaUmZyMUVUTTNYOE00aVFoOTRaY1A5bE5VcHQ5UHh6RjVI?=
 =?utf-8?B?UkVrMUUvQ2QyVUNwdTFMczhLODNSUC9yUmZWU0Q3TUlTV2hPUWZoR2xURDhL?=
 =?utf-8?B?cU0vN2l1MUpEZGpZRGRlV25ZYWpicXJyTnlqYkpBbGZ1bzZNQ0pzSS9sVlYz?=
 =?utf-8?Q?RfR7UjbA59D4x?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MTBvejducGczRExTbDJpN3psTVFEdml1ZWl5dUl5NHZ2UWJuNEEzb2tzWXQy?=
 =?utf-8?B?c3oyRHRIS3N2YzA5RDRiK2p1T1VhVmhldTlmTTg5ZVg1c2s0SmwrUEd6aVFT?=
 =?utf-8?B?SmgwVE1zUnJzSWxCVEtCelNhKzNObEZrM0dXSUV4ZE9sTFQyaXZKc0xweC9j?=
 =?utf-8?B?UTg0Szg1bTlzdzB6eWE5WXhZOHhTTkFKYVd0YW9CWVRzVnJpRkxuUHdsQi9o?=
 =?utf-8?B?K1hGRGZ3UmdkZldJSW9tNkE3b0RucFQ0aVJJeVVFK1FqTU1sZ0p2eEpmT1pD?=
 =?utf-8?B?b01IR21qK0p1QmEyMy90TTBiR3VlUDV2U09OcFFxVzNPUkRwN2t4SXNEaTRZ?=
 =?utf-8?B?R1MvQnR1OUdsSEc1bCtuR3pNdE1OZ0Y3SFNvWHF6ek1zd2xnK2xONHNLZmFJ?=
 =?utf-8?B?OGlvWFU1N05nYW9QVlJZeC9Ja1VsWGxBV2ZEY3JRZVJQcVl5dURqQVIxZjRz?=
 =?utf-8?B?RURpMVBmaWtmTGw5Sk9Ia2pFSXFWU1ByaVpPL041ZkUvS2F0UGZMczFjKzlp?=
 =?utf-8?B?TDI2R0FTaFNMNG5UTW8zT1J5UWM2V3hzMzFKNFJSbGhjTHRtSUlPZjNUVlVR?=
 =?utf-8?B?YjVmaTdsdFVVdDV1Ykxyc3R1R2lLR296UjhWUytMbmJoaUlUdXNacExQYkZj?=
 =?utf-8?B?bzF3NWU1ZVJaWEphSXFHWmZsNE5Gb1FNeDVQTTVuWDB5WTYzR1BFY3E4eDJ0?=
 =?utf-8?B?K25rWVVsUjRlQzltWnQ1ZFUwcTBEMExuUHZpUURmK0RGTzAyRHVXT01ESENO?=
 =?utf-8?B?Q0tQbVdSSWZmQTdPYitUWWZ4UEJTck5ycGp3L1pxaTlLVlY5SjVCU3d2OWZK?=
 =?utf-8?B?WUpCZUtFU3NBajIrL0NMdlRGbTgzakpiNCtZL3RJUW5YV3hEN2p6TGVySENa?=
 =?utf-8?B?R2hWTVIyVEEybXhOamRVRndQcnR1ckVyUHBzTzJIa0JPYk40cFRBVEdFQkht?=
 =?utf-8?B?WWVmSUN4SC9NUVFCQVVDRmNpaW12djRxRXRlTFRkQVl3N0JDazJIWmRmcnpr?=
 =?utf-8?B?K0tTSXBwS3hzY0wwWERKeVpna0VXS3MwNitRUlFZb0UralpHTml4Q0phQTd3?=
 =?utf-8?B?UFF4MVNaRTQ3eXVwdWdIbFA1UEY1RDNGRzVJNzloNW9RSldPaTRSNXBMWnUz?=
 =?utf-8?B?RVM4OXg4QkN0VTFPL2h0ZWV4aE9QbUtGTnF1dnRmR1h3a0xiVG9xZ3ZxYVZI?=
 =?utf-8?B?aEtBNHlVZDdOYVVoYytTWmxmWGFZUjQ2OTJ4aERId2ZOYnhjb1BUQ1crMHh4?=
 =?utf-8?B?M0VXUXN6T1RWb3pCTVVsbWdKNDZRUTVWekN2UUNpWUFhdmIxbHAzaUM3ZGs2?=
 =?utf-8?B?dzAwOFprZ1V5SEtQUTZhQlRnWERFYTJvd2lDY0dEemVxQUgxb1lmV2hPWEVz?=
 =?utf-8?B?RlczN3FiSHgzYXZKdS9DemFoWEpTb2VkaEVJbGNxL2JHeW5BZW1KWThCVXM3?=
 =?utf-8?B?WlBXWmsyNnhOWDlBMm0rYzFtaFlndFpmUU5VUEpzRkVLdVpwb2dadkZaYnM1?=
 =?utf-8?B?Mm5uZ0Fkc2dpWWdqelZ1cGdNL1lFMk40bGlnQ2VqdUNadG54TlZRQnNEOW4v?=
 =?utf-8?B?ZzVRTlVGakRSZmZSUFRNSGNkcG5qalJrbEVxS0tFZmlHZU1OM2VoeXJRdkxi?=
 =?utf-8?B?SkJFM3lLNkt5VVJMYm9kaUhpU3NTRUczQ3JkUFArTi9kUHFocHZoTEZXUVgy?=
 =?utf-8?B?TEdDSkcyczZUTHVIZTdLR3I4QjdETFJraEVNbE54bndRRkpldmpyNVAraFp5?=
 =?utf-8?B?YlRHTllDQXZUNnpBY0poYk94Yktwa1E3QURnbzFwQnRhU25TSGZ4c2VJdFdi?=
 =?utf-8?B?d2o3WksrQ1JndjRzbU54cGcrYlJsUkdjVFNMcFUrcnEraENGbEZseUttSUxl?=
 =?utf-8?B?R2ZkdFNsL0ZvZFB5ZDZTYmMrWFdwOFpSRHVvT3RMZGM2d0E0WUlWL0dXZ3NI?=
 =?utf-8?B?UFRmQzF4M1daS0pXYnY1eUdQWVlNT08ySnFYT3ZReW53R01mRnVxYS9QVk5G?=
 =?utf-8?B?K3QrR0grSHYwSTZrUzVmSy9TcW9MdlZEYlRtMUtLRG5lM3laM294cVhsZTR4?=
 =?utf-8?B?aCtOVXhTaDJkTlRUTHRRN1UwSG01cHJ5SGNMZmszV2YrRmtLUy9KcnZBOXZY?=
 =?utf-8?B?ZndaaTBXL1RjVVRBSVVKT0ZMVjM3V0NhVGRTVFc3SzBOdElxREptaWlxNG4v?=
 =?utf-8?B?eEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xm01xORpbragYlRUv76P/x0R2YwNtFrb7DfwcAzHC8ISiF6LLKYR/WsjTl4YbJL52PCnTj6KjuzPfx215xS2C01XdWJBxrV0h2lDxhF2MqNp+hBX9hGYrvCocWTIL2SHDY7/+JNjprjRSSy5wpEMt9n6Ltr/a5GiXnsGaMm2mO2gsU65e7mIGU/IbKD3BTrsrThq4epQ0cZ/AKHCkEhNGMwTme94G9zYMHRxThLpUlzdL+kOz/PCQB8DiZd0d6Vt0r/WLH+DvngxJ7x/YLxn7+aEGLN0QnamCdowZh1zkKO/8gsc0JimHgDIrJa35j1wa9JKbfKVxwleM1nd8D72TjC7EX9CHyk9/cjjiRmbg+U+NCRtZmcB/uSFBGQa/j/keTjZYQA+9WhjNs7ijT42UnHhRsrABumyK6pKMmNSLlLcIoS/USlGWt1iT0LXVaeRFfZmnfnKcFH1iIPh9BfQC06AR/vBU10TQEFu4XFQsnLGg7RMZ70SPH3kZGAAyq/LOwcOTJHYmSM9hQgWPhhwRjdAkGnpAPEfv9KbPoZX4pzL7083JuMVY3n96/xKBolVddDLPeqXBtA61e+i2C/UFLo/xQvIJJ3IldaLXUQTOp0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1468e16f-156e-4a4b-d9ef-08dd36e16c4f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 10:26:37.1497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: do3RD1WC7DnKPBYn7nsyFzSp/LU/IjTegK6o2GLEpsjCM8YAjXO+uOvFSg+OYLJvYkORTv/K2JLtf7rbqJyL9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7787
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-17_04,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 spamscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501170083
X-Proofpoint-ORIG-GUID: dtxr-R1vjsMb7zozpU-hP5pmhttKeH7t
X-Proofpoint-GUID: dtxr-R1vjsMb7zozpU-hP5pmhttKeH7t

On 14/01/2025 23:57, Darrick J. Wong wrote:
>> i.e. RWF_ATOMIC as implemented by a COW capable filesystem should
>> always be able to succeed regardless of IO alignment. In these
>> situations, the REQ_ATOMIC block layer offload to the hardware is a
>> fast path that is enabled when the user IO and filesystem extent
>> alignment matches the constraints needed to do a hardware atomic
>> write.
>>
>> In all other cases, we implement RWF_ATOMIC something like
>> always-cow or prealloc-beyond-eof-then-xchg-range-on-io-completion
>> for anything that doesn't correctly align to hardware REQ_ATOMIC.
>>
>> That said, there is nothing that prevents us from first implementing
>> RWF_ATOMIC constraints as "must match hardware requirements exactly"
>> and then relaxing them to be less stringent as filesystems
>> implementations improve. We've relaxed the direct IO hardware
>> alignment constraints multiple times over the years, so there's
>> nothing that really prevents us from doing so with RWF_ATOMIC,
>> either. Especially as we have statx to tell the application exactly
>> what alignment will get fast hardware offloads...
> Ok, let's do that then.  Just to be clear -- for any RWF_ATOMIC direct
> write that's correctly aligned and targets a single mapping in the
> correct state, we can build the untorn bio and submit it.  For
> everything else, prealloc some post EOF blocks, write them there, and
> exchange-range them.

I have some doubt about this, but I may be misunderstanding the concept:

So is there any guarantee that what we write into is aligned (after the 
exchange-range routine)? If not, surely every subsequent write with 
RWF_ATOMIC to that logical range will require this exchange-range 
routine until we get something aligned (and correct granularity) - correct?

I know that getting unaligned blocks continuously is unlikely, unless a 
heavily fragmented disk. However, databases prefer guaranteed 
performance (which HW offload gives).

We can use extszhint to hint at granularity, but that does not help with 
alignment (AFAIK).

> 
> Tricky questions: How do we avoid collisions between overlapping writes?
> I guess we find a free file range at the top of the file that is long
> enough to stage the write, and put it there?  And purge it later?
> 
> Also, does this imply that the maximum file size is less than the usual
> 8EB?
> 
> (There's also the question about how to do this with buffered writes,
> but I guess we could skip that for now.)


