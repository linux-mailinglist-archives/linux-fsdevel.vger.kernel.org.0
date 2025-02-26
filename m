Return-Path: <linux-fsdevel+bounces-42705-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FC6AA4664C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 17:14:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1FE544319E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 16:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92804224B0C;
	Wed, 26 Feb 2025 16:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="m4e268aq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Xmb4gZSI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530DD2248AA;
	Wed, 26 Feb 2025 16:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740585655; cv=fail; b=sSue3VFT83qLKqRU95mT0hwfph2FPmF37Wvwpp7iqc36jqEMVM0GcKrwEt9SHAx5ZXe+A7tfhGlAvf/RPAfQzMjOGS5zcjARVFSVkYGZXvQikSU5QdD7rdNBTnbCn4EXDh20xDx6loViAA5jozz/3nD8rTdw69SbHtN6AxpHMDs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740585655; c=relaxed/simple;
	bh=fqDyEFHwKAZ/WbQL1gMiKkNYLuR1myy5Vrqv59LVN1E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CHBLWWkYuUi8HfWvJB7fCTwh6D+HL//NMWOOLv3gnnx4gHbyNfKMe1eXlVKFwPaq5TBOAjC0U/QE0YuyDRetEFhTt/SOJxYvzUqtmGkxU5aolOTQj+LGI7fP9ReQ3xUm8XMTeRXU9XpCFgQug7qJStc9BXvqvPqo7aTo2JIhW30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=m4e268aq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Xmb4gZSI; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51QEtfas005884;
	Wed, 26 Feb 2025 16:00:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=7Cw/HKcBOraU+x+tpTWDlCz5fRrL5X4AARikgluV8e4=; b=
	m4e268aqgkYbEDIvUQ+QMVLW4Vg/+JOLIGK/DzUKrGrMNoHhPBs4CJLqO+QbE95X
	4EEjTeQ95JGEPDmaF0m4tJcMEy8gTSz36SrrQOjL0aeAhixIaSCxSTsbEsJPrRT+
	L6CjEMF84jtKxaXZnKpilMH6MUWI932ckChgHXgzh9ghk4mJpSCtC7tDE3LoLJkt
	rQI01QcGLlUwpBZ/bS6078icrJ584yFfU9vUKSlOmNm9MzUiBHPA61MbA1o/elYR
	3OpHgOQlhjTydaNqsYXe1BNbZkbYknLMFCm9PLsqdFGntUS0xXGGTLXeYiYTtfJ4
	Hk8MO+iNoVNBoXyPmIfpcw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 451psf1dvw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Feb 2025 16:00:48 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51QF1xnF024543;
	Wed, 26 Feb 2025 16:00:47 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44y51avy9b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Feb 2025 16:00:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eA4uCf3NVmCTIq115zMd3PlEd84/vCR/KLb5meFJ+uEADUyXxyXUfuC1Kt1tH0d/eM/FHM7Eh+oXDdLkOmD+qlZBoYfV4jd7YyqV35PYGRnMbLJH3ccf1HN/iWK3ctpRxnlSgfXgLlr0WjJHQSgltU6VkgWKUikJ6E47XtXDmZXAOUEqWzBO6SvwB3H141qt7Bma//tMAGulgR7tEzLSpe3TRnGqVFSJKBcwxInusNxCyzLnkLO2IP8hqe//Tl5d9D7SefbPOkAOEelujl+hzLra2W2Kb9+26tE/Mxoc9SpAlnvhoAhVVdaYX2lLxCRrDuuzGhggteuGnRGmNG3Srg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Cw/HKcBOraU+x+tpTWDlCz5fRrL5X4AARikgluV8e4=;
 b=P9uUjzz1F4Lei8t+LQtvHEQDM15Lez++0GF15PyTD4+ysz7sEAng2DnV4MedpX+7tP3lxk49FPSPoAqAkp7SFZqx4f8Zfnnbqo2jQlmAWcacRK8lYzeUU+PNcYvLWlmUEdN6ElWFqEE2aXwCYN6MKFdK1VlDK8vI0zTepfVE8AJF+zdYBWU6wCEjICdU3rR8H6UajsJY/D9ApNHPmN5oKyqIKIZPgIDivlWZk3MHeMcsbV3ChFAEtRS050HVJrrF2dDTV1PHlu5dkkvcszoiAyPhr/txmORIbgagi8vj7HW4h2iFPagNZHgzkbHSZ5Q9Bu9ZNzm63thjK2iTwMOKLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Cw/HKcBOraU+x+tpTWDlCz5fRrL5X4AARikgluV8e4=;
 b=Xmb4gZSIqcSqcC7MEiWQvkBxGbeo3P0I2RbgO1VWlQp0FocBE9uUy9fN4ghlPbjs5B+50zFTOelG8gQKTvKWZ9bGAcUtTSpG9/nA3Itwxpd/UlOvw3CWBLKBsW4qIFUQT7YigMA3h4Gxa8mCiPwIAPi7lauYJjWTbefVvfDOUJc=
Received: from DS7PR10MB5134.namprd10.prod.outlook.com (2603:10b6:5:3a1::23)
 by CH3PR10MB7562.namprd10.prod.outlook.com (2603:10b6:610:167::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Wed, 26 Feb
 2025 16:00:44 +0000
Received: from DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63]) by DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63%5]) with mapi id 15.20.8489.019; Wed, 26 Feb 2025
 16:00:44 +0000
Message-ID: <5ff2354e-3bc6-4bb8-a481-bb81d717d698@oracle.com>
Date: Wed, 26 Feb 2025 11:00:43 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Chrome and VSCode breakage with the commit
 b9b588f22a0c
To: Takashi Iwai <tiwai@suse.de>
Cc: regressions@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org
References: <874j0lvy89.wl-tiwai@suse.de>
 <dede396a-4424-4e0f-a223-c1008d87a6a8@oracle.com>
 <87jz9d5cdp.wl-tiwai@suse.de>
 <263acb8f-2864-4165-90f7-6166e68180be@oracle.com>
 <87h64g4wr1.wl-tiwai@suse.de>
 <7a4072d6-3e66-4896-8f66-5871e817d285@oracle.com>
 <87eczk4vui.wl-tiwai@suse.de>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <87eczk4vui.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR07CA0015.namprd07.prod.outlook.com
 (2603:10b6:610:20::28) To DS7PR10MB5134.namprd10.prod.outlook.com
 (2603:10b6:5:3a1::23)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5134:EE_|CH3PR10MB7562:EE_
X-MS-Office365-Filtering-Correlation-Id: 37144a53-ceaf-4541-9fdb-08dd567eba1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UUxPeVJGWjBhVjBqNk0zaWJwaTRzOUI2SjZDU29xU1RocVdNeExLNEVRRVZN?=
 =?utf-8?B?R0E1OS9qSHZsVitQaDFvNXFabUdjOC95aXMybGt2Z2psekZoUkRDdG1Eb3dq?=
 =?utf-8?B?dTdxMHR6aUwzYmc5N2tuL3V0UnJwRWliMW0vUGxPUm53SEU1MCt1WGxISUN1?=
 =?utf-8?B?MlRBZkZobDdMM1FVV2RjZ0Yzc0dMeVl3N202WG1GUHdQSkJnNnJSYlkvOTky?=
 =?utf-8?B?T2UvM1lwMGEwMkd4RmlFeElSRDc0TDAzVEJzU2pEMXpuNmpscno0TEpKOUpW?=
 =?utf-8?B?YjVJQzFaMlJ6YmdIMTZYU2YwVWZ1N0UvUmE4b3N0N2g4cjJwb3hwTnA0QlRz?=
 =?utf-8?B?eFlxZkFoazUzQll0QmJ1enVoNFRFdWNpOFlLczg4eGRLUzhOTWtKZVM1b0dS?=
 =?utf-8?B?UTlwQ1J1c1VDNGh4UzBuZ2ZWV3E5cnVQM0MrTVZxTG90VjA2eHhEVjA2VW5L?=
 =?utf-8?B?QUx4QjdST1dGUDNEMDV3dm5kYVZsK2pGMTNSb2Y4aEh0TGZFNlNEVzdNOXJj?=
 =?utf-8?B?dW03czV0bjU1akZmYjF5Q2IySDJtUnQ3OFhGM0g4TURVYVRaMS9wanBiV0s5?=
 =?utf-8?B?OFRZRGQxTWFsWmtBbG95Sk02NmkvU2NDd05ka3N0ZVBzbmdvdG45UzVrM0pN?=
 =?utf-8?B?eEVpU285R2Yrdi94cmlkL3JidnRxWUdzempOUXlGaUV0M1c3L2V0V3V2OHJR?=
 =?utf-8?B?QTl3c2RhU2EyV09WLyswTW1mNG9IMXU0Z2c2WUl6VFVDb0prS1hSV2M4L0JR?=
 =?utf-8?B?elB3Vk5SYnM0dlZQc09uMjZVSEN1U2V0UkpYcUtCUzhpSGRHRy8rb0NOVVhL?=
 =?utf-8?B?MEljSW05cjJKamtwMUx6SG1lU3ZsT09SWGdyRmNQWWhBOGhVT3VPMHMxaFNT?=
 =?utf-8?B?VmZTeUFEdzBNRUlraTBuOFJvd2E3R0czNm55ZllHUlFiUGdFTm5jUjRhMVJB?=
 =?utf-8?B?TTUvUlcxN2o0aWdYSTVBdHJ5U05lTVhDV0FtV0pSaE1uMCtzVHhGcDhHOVli?=
 =?utf-8?B?S251TmdrL1ZhSGRPamUrYysvY2JWZmRyTkxBZVVkVnFnUTFYWExmVkw1VmFZ?=
 =?utf-8?B?R0xzc2tTc1dWQytQZ2d4ZFBqc3plMUdTbEZ3RWw4L2M3dVRaOHd4RXpFeGRF?=
 =?utf-8?B?MVljdGdsdk95TnJEQjUyZy93VEFKUm5mVG9IS2p2aFUxRmRBK1VSbG5Ka0Y5?=
 =?utf-8?B?MWE2TmZSOTBwL3RHRFJEMmczMENiTXg0TVROdmlYK3pQcEdKN2dtcUg5b0Fa?=
 =?utf-8?B?dzltL0xDU2I0TEpPYVNhM00vQSsyTUFHU3lQU2hmZG8xLy9MMDc4Yk10b1Q3?=
 =?utf-8?B?Ymw0YnZ0eVRJY000V29saUFIK3liZzN2V0xUY0ZySWdTc2NBYVhKcUovWi9z?=
 =?utf-8?B?OXRuSmJVbUFBQTd4M1FCR2Y5RkdjYW9MUGlncWZ3ZXowZUJRajZBZnF2NlZP?=
 =?utf-8?B?VWI1d2d5MFdxOW1oU1ZCY0xWVjhOaW9nZHNnM1lBdkdiL0RRY2REcE1KbG5G?=
 =?utf-8?B?TzZCNE1SdGZRcTBEME5pS0puamFPeEgxY0lZSG0vbWhyNmdNN0ZLbm5YNFJ0?=
 =?utf-8?B?RkNBR3ZkbUFUbzYwSURoTXY3K09QY1VjaW41Q2lBSjZOc1ZaQ2c1RWlXU2pY?=
 =?utf-8?B?VjN6dHdPYlB2ZlorVGVZZUF2SG0vOEkvWDd0dFJ2SFZIMTZVelNnZWdldExT?=
 =?utf-8?B?L2I4MXpsdzljbjh0OHdEUUVrTS9ta1QyNVBjT3RhRHBTMlpnSisyUHQyeXNm?=
 =?utf-8?B?czdSN1pOUnBlbC83c0VTOHVRdGJHRk9kQWFza1FaNDR3NEN5NUdMeXc5cUZp?=
 =?utf-8?B?T1lVWGxoYnNub1I1WGZ3QT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5134.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V1pvSncyUFU2MHQrSVFnb3AxVzJKOVF1cnlXd0pZR0lFbHc1eWRTWTB3VEx3?=
 =?utf-8?B?N2FhcEJTQmprdFBNQkh1andMb1dlSlUxOUVkNEJlODBuOG5TK1JZcW5CRUtS?=
 =?utf-8?B?RVcyRGlPakVvL2pPMTdBaTRleFVSdCtrY1dYSUhIa0RHNzVoVVdKR1cxY2FC?=
 =?utf-8?B?aWxoRlpwU0dqZlFoR2JoNUU4aTdaVUxMcGVFbExudVMzb01PK0x1MTJ4OUdV?=
 =?utf-8?B?VFF3WXpyVUhrNnZNN1luZVZ2OTE2Q3gzU2QzeXlaSDBoS0s1aEpUVVZ0eGcx?=
 =?utf-8?B?eVZLaWlDdEFHTENiUDdiUC9yNVd4NlVKRHVQSVp2RVVkV1M4RHdBSDgrczln?=
 =?utf-8?B?ZitIZzdGcjlWYW82OEJPOTRoTW8xR3E3K1Vrd1oyY21jaXJVL1VxZmhHSkxj?=
 =?utf-8?B?Zjc2WGJwOHpVZVZZWW81T0RQUkRQZURvQ0FBM2R1c3lyRzUvTVVHNStnWThP?=
 =?utf-8?B?VUR3R1d6Z055alJiK0hFdHVFMUs3b1JPK3J3WURjN3lCdjBHQllkSUFFM203?=
 =?utf-8?B?SmtIUDlYMnNJeVFyK1Y2bzNSVkdzWmJnb1E5WDJpRXpoYXV2MmF6VzNmNUN4?=
 =?utf-8?B?MS9YdkVnS3FvVWxhY3BodDd4UzFwTGl6dkJPbklqbVJEYWRmaDFWWlNMOWZD?=
 =?utf-8?B?RWFFbzZHVFdhMkpBNERsZzdqakJNeDdyOVhlU1ZyVDV4Zldwek1XNVF3dmxD?=
 =?utf-8?B?eWM4UHEvNUthZEtLQ1AzMFRwVFZ6SzBHS0NyYkY1dFJ3OTVXVDR1MGNsRjU0?=
 =?utf-8?B?dEYvWEhBMXdrNXlXWmN1RkUveXhxcklKRjc3NDdhVHlyUGZ1bUxHU2RVbXdX?=
 =?utf-8?B?WTVValpSakNNLytYaEhrM1NZVzlIcjVyemNMWXR1TkpzdUY1TEQwTDFvbDJN?=
 =?utf-8?B?d1JZWjV4NWxTMElsZXAvZkF3NUdrVGdXR01EWENTSmc0VnNPcldrRVV5TXpv?=
 =?utf-8?B?ODFxZWFTZ2VaaUVzWGNQRVJKdE93WjFEdFlHdDZackRIanVmd0JrcFU3Yjd0?=
 =?utf-8?B?NUlFSlZ6UmxNWXg0Z3Qwam12dHFmcHp1M3kyZStTbHMzMVlteHBhK0NpZkli?=
 =?utf-8?B?Y0tEQytSVmFqTnlZSmhMWXNVRjN6N2ZPSk9iQ21uQVNmRjdCVmRZRzI2YW1K?=
 =?utf-8?B?SllvYVkxeVFZS212cE5udGxHbUQyaFJ5R1dHSjFEWkxReVlnL2g1dFJHZHEv?=
 =?utf-8?B?Q0ZXUlpRdWp1b29WdmxuNG9uVFZVSVNHYkNPUnFVTEVPMXdqWVNVVDhIdkIv?=
 =?utf-8?B?T3dnT0NDNUFBc0Uyb0lJdHhJWnBJb21HcHRVUUN1MlkzdmpMTGNFWVVVU1ps?=
 =?utf-8?B?dEtpL1ZWemRob3Z6M3lpWmFlVEhrNjhOMEFZMFFZK2tPc0E4c2ZXOWpCRHBL?=
 =?utf-8?B?Q3haSmE5WmlZUVBucEwrVVhSblFad0Mzb0xBM2VGQkZZakcxVzRpc1NkVXB5?=
 =?utf-8?B?c1M3Tkdnck5OUXhvS2hzZGZNazd2SlU4V0tYeURwYVk3czhhU3VsdzFMU0I1?=
 =?utf-8?B?bDFjUzdWMUR5S1lzRENpcGs2bkNzMXN6Q3AzZmczVm9QbzBwT1JoNS9kWkh6?=
 =?utf-8?B?a2JCZWg5aXUveVRoTUpuVHdJMTNCcVhZSG4yN3NQVGorWDZkYm1vam1wSmJ1?=
 =?utf-8?B?dHd4QWE5bnRibU1Nam4yRHZWekgrSW5EVC92ZzNFaHpoZmJrc0Faei9nU0M2?=
 =?utf-8?B?R0lLVlVFbjRHVEhxNC84Rk9wR0Rjd3NCSHQ2YXc2c2dPRHJ5MGxrU20wb0da?=
 =?utf-8?B?TGF3b01yemh2RmFOSm4xb0h4dmxwVjRsQW5XNHFlYnBIWm5DNS9TUXF0REt1?=
 =?utf-8?B?bEJ1NzE4R0pSaUtCNUlxb1ZzeWtSNnY1Y3NmVUNuUERrVlhsVUFEaGpBNjVw?=
 =?utf-8?B?OGJMdEVLOFQzSUpIcHFSRzBUd21BQWV5bXpDaFZLRzZnQzVpZmpXeXNCK2pY?=
 =?utf-8?B?NXJxOHVseHFaNVRobGNkUS9OR2wxRmJrenJ5bU50aysycnBVeDJId1hvVlFU?=
 =?utf-8?B?UkdyV2VZaVVGUCtyRDhpMFlCSExNUWhCQ1d6RC9OMjFydGNjZjd0N3dXSVRa?=
 =?utf-8?B?RDJRRGdHQTNGN2RWNkJUWVMzME1VZkIzMVFKWEU5OXpxWm9FaWhvQlljTVk4?=
 =?utf-8?B?RWJYNmlVbXFUN1hDczVtbHJHdG5xWHJCRE5BUXJUR0gzaEZhUjRkdG1tek9s?=
 =?utf-8?B?dFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	h2f2qNEHAIyFf3DHo8siZ7Csxk19/UkcQP/VeF5YWiDz3+WKfmPlsczAxKVU/Xrq3DuI6i+RSxGeiCpYeFhn3oSA5NfqzDde9hP9TbwlASO+ipHTfFgnrDRxUuvgOC+zEAZSYelB6QPvXGHOFoFI09WCuvClY7ZTt2OLgtHGw8vl/cqG2stdZ87NUsHKQuhwRJFta8zL40J6zBn4gDtcib0dgJA3t5LgemCFimwk2Dvn9TlAyKMsQO3M+9oUj+FzIkCOASx7NJBwPxgD8l0uaf+bhDjl6FBimnu0G5XKdvyFdE7XP+TeMFLH61lG26PAqFwb1/5O50W3Fb9SolvrXhEb6BNIaH6b5JKs7iqkjrlcaT3XvXxHBVpjltg1xJkiR+BwRtK3MmNLS1zmqBqKhNrOionwvWWznRUl/6U7y7xTo4nxhpfvkbCBnOEduKnBJSznzFy+SLDXkf8D9nZY2aXXCsjLrbERw0C7t3zmbiJskRCP9nq2Foe5B5QjQr+BxrZM1MrsY9UGmLRD9tBhzblLcoTljd8G7t+h2sRIi8bNd1AouCnZj6sb6MeDAoXfVhP5R4B+JFObHfCt1+vhErrmfcVGJ6Vb+eLNd7N9U3w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37144a53-ceaf-4541-9fdb-08dd567eba1c
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5134.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 16:00:44.7662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EVv9K2pgAN8hL39HhiN2oS/m6iXalu96tW9f79OyJJUQlFAIrDWk++wLGCKeunPE0yw6l/LtX/AQUUgL8qnPlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7562
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-26_04,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502260127
X-Proofpoint-ORIG-GUID: 3x-Jb2ApqAhHcqo1QR2BW3trk3J-CZiM
X-Proofpoint-GUID: 3x-Jb2ApqAhHcqo1QR2BW3trk3J-CZiM

On 2/26/25 9:35 AM, Takashi Iwai wrote:
> On Wed, 26 Feb 2025 15:20:20 +0100,
> Chuck Lever wrote:
>>
>> On 2/26/25 9:16 AM, Takashi Iwai wrote:
>>> On Wed, 26 Feb 2025 15:11:04 +0100,
>>> Chuck Lever wrote:
>>>>
>>>> On 2/26/25 3:38 AM, Takashi Iwai wrote:
>>>>> On Sun, 23 Feb 2025 16:18:41 +0100,
>>>>> Chuck Lever wrote:
>>>>>>
>>>>>> On 2/23/25 3:53 AM, Takashi Iwai wrote:
>>>>>>> [ resent due to a wrong address for regression reporting, sorry! ]
>>>>>>>
>>>>>>> Hi,
>>>>>>>
>>>>>>> we received a bug report showing the regression on 6.13.1 kernel
>>>>>>> against 6.13.0.  The symptom is that Chrome and VSCode stopped working
>>>>>>> with Gnome Scaling, as reported on openSUSE Tumbleweed bug tracker
>>>>>>>   https://bugzilla.suse.com/show_bug.cgi?id=1236943
>>>>>>>
>>>>>>> Quoting from there:
>>>>>>> """
>>>>>>> I use the latest TW on Gnome with a 4K display and 150%
>>>>>>> scaling. Everything has been working fine, but recently both Chrome
>>>>>>> and VSCode (installed from official non-openSUSE channels) stopped
>>>>>>> working with Scaling.
>>>>>>> ....
>>>>>>> I am using VSCode with:
>>>>>>> `--enable-features=UseOzonePlatform --enable-features=WaylandWindowDecorations --ozone-platform-hint=auto` and for Chrome, I select `Preferred Ozone platform` == `Wayland`.
>>>>>>> """
>>>>>>>
>>>>>>> Surprisingly, the bisection pointed to the backport of the commit
>>>>>>> b9b588f22a0c049a14885399e27625635ae6ef91 ("libfs: Use d_children list
>>>>>>> to iterate simple_offset directories").
>>>>>>>
>>>>>>> Indeed, the revert of this patch on the latest 6.13.4 was confirmed to
>>>>>>> fix the issue.  Also, the reporter verified that the latest 6.14-rc
>>>>>>> release is still affected, too.
>>>>>>>
>>>>>>> For now I have no concrete idea how the patch could break the behavior
>>>>>>> of a graphical application like the above.  Let us know if you need
>>>>>>> something for debugging.  (Or at easiest, join to the bugzilla entry
>>>>>>> and ask there; or open another bug report at whatever you like.)
>>>>>>>
>>>>>>> BTW, I'll be traveling tomorrow, so my reply will be delayed.
>>>>>>>
>>>>>>>
>>>>>>> thanks,
>>>>>>>
>>>>>>> Takashi
>>>>>>>
>>>>>>> #regzbot introduced: b9b588f22a0c049a14885399e27625635ae6ef91
>>>>>>> #regzbot monitor: https://bugzilla.suse.com/show_bug.cgi?id=1236943
>>>>>>
>>>>>> We received a similar report a few days ago, and are likewise puzzled at
>>>>>> the commit result. Please report this issue to the Chrome development
>>>>>> team and have them come up with a simple reproducer that I can try in my
>>>>>> own lab. I'm sure they can quickly get to the bottom of the application
>>>>>> stack to identify the misbehaving interaction between OS and app.
>>>>>
>>>>> Do you know where to report to?
>>>>
>>>> You'll need to drive this, since you currently have a working
>>>> reproducer.
>>>
>>> No, I don't have, I'm merely a messenger.
>>
>> Whoever was the original reporter has the ability to reproduce this and
>> answer any questions the Chrome team might have. Please have them drive
>> this. I'm already two steps removed, so it doesn't make sense for me to
>> report a problem for which I have no standing.
> 
> Yeah, I'm going to ask the original reporter, but this is still not
> perfect at all; namely, you'll be missed in the loop.  e.g. who can
> answer to the questions from Chrome team about the breakage commit?
> That's why I asked you posting it previously.  If it has to be done by
> the original reporter, at least, may your name / mail be put as the
> contact for the kernel stuff in the report?

Certainly! Perhaps add Cc: linux-fsdevel@ as well.


-- 
Chuck Lever

