Return-Path: <linux-fsdevel+bounces-54353-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07D72AFE88A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 14:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BCDB18885FE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 12:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE352D8380;
	Wed,  9 Jul 2025 12:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AkO5ysgM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="n5t2abMP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8D372613;
	Wed,  9 Jul 2025 12:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752062648; cv=fail; b=s2B0wqo+Qhjjmblpp3ZvsSfvrefd/98GtQZMhW+J1OtwHlswenSeENVJGDaWavUPO3y8i8oSKHGxAL1JfQgXkr4hDIFxLdqj8Dd2JWeLDeBkt5+53cGy7zd0K6Fgt1pjiUSlMXnMLARp04r/+a26LSI58PB0edsNjI9r2RkZ1Lw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752062648; c=relaxed/simple;
	bh=zXzK5id1ArNKrasTERI30QwelssEgX6tArfLJnFIKMM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Bq5NgTrOv9SjNe0/0bS8Wvg67o5D0A8QEAJSI7jJyrN8GDWVxqo0gmMuijhVnJAsc7dG17PKy0P8zfOem/B41uOHiog50LGoSScOSsrZaTYPRi15X1hDiTOTRMpcqAlWSt8/U+OYxeyJquUUZ0YRT4c0BA+wK07tFXSwXS+PMD8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AkO5ysgM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=n5t2abMP; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 569A2ZPf014758;
	Wed, 9 Jul 2025 12:03:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=eIxfcHvetXzn9c+iJ92N+BnD6NqlF01XqIi/1JU3Fq0=; b=
	AkO5ysgME49haXyMT4aVIX59UraOu6G6QA0xCuoV7rgeQNEB2Hw+vMGBAv7aQXgV
	GFA3FL3zg33T2YXRWkm3DeBccGP5AfaNLHzaZrwTWs/sft8VWZL5Iodfzlho9RSi
	JhorFaxQoAHyWu/7sRn52ODgjtnKv5sKmURFmOSsyboXLFxbAqYVfIIUAMhNtHK+
	Mvcp8EF2FrQRSNuK874ehwogSitgfWJeYWsiLzK/RNYzAkSOkLzkZpPR1+Mm9Yoz
	tVbn8hS8RKNidEwW+zZeoFgYWPRwPIBGmPtZpY6ptkbGEqyCR3O3JrYN+u2pR/eP
	tRp1CNIqnf221qKna2Tw1w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47spadr5yu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Jul 2025 12:03:59 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 569AWDqh023604;
	Wed, 9 Jul 2025 12:03:58 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ptgb4v89-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Jul 2025 12:03:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b7xzrHYosNgS0JxBezwc5qM+gDyfXAV2num2+MBfsDWaMfZoVh0Pnxiht2Hpe00LbtvpzmUCCBhW8GNUT9ksGvSgoO7fT7e9LJGE4vKeBBW3qAOTT2UaU9ShmSxfSusJS+ngOLab/2IihHlpYmSOHWEBD2Yc9jrHMHF0OvhV0avdz0evCWKwCaOzZV7gnQRRi+Ct8Gk/WPIOxeOagPfWRq9mGt4S+iI0nzSMJvuDs3qzTlGkhL+l0o1TS91UpXMbQYtAP2ji6E98B7pJBbndvgmpkvff8hO5ukrtv7DGI+sZjNBTI2rX+DjzlVhtc0NlUckfv6U2F5fuYQZI04l+SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eIxfcHvetXzn9c+iJ92N+BnD6NqlF01XqIi/1JU3Fq0=;
 b=Ay/9VOfZPxgmNWGumu0daVhz7pXh4HnfbJUXJMJsjp0UgV0DJ959TynIM4phpBY5m0OfruXn+nu84z/q3CENFBST73xi9SMRRmDxYqCMH852GM/B34kwgm8AYDu+FNFQ2+gz11pk66CXL+W7q9v8DrmRPMifyq62N5nCHX3Be37pGsTtnAsGJqYtfmfTGRnWbDxKXV2KkKqIcwWLxKaIPvbGbkJXCb35YfDLnRRts7Vg2iYIPL0ZezZWVJri3ZYTdT42RyIJjg+AKX3qnzUeBpgOzajifCYptt3sEA4EnI0hHN2Scx9j6Nky4n1ZFPy2pdLwcqxFQEENpDKzgSNbhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eIxfcHvetXzn9c+iJ92N+BnD6NqlF01XqIi/1JU3Fq0=;
 b=n5t2abMPqBGM3tXUzGiKyjrdwQxK5PoKA3j0tlwQUga3D7kfSwcI8afo0tX7nLHCN0FXheUwPxxorI51D+6mAxHoW/BUIhURPb9Z5PHEK0SaYF8kbruP6KK/fCuYE8/2RcEHH0PilBhaW85D7jeZcR3fYQKOjTYhBpnl0P7+Pxs=
Received: from CY4PR1001MB2310.namprd10.prod.outlook.com
 (2603:10b6:910:4a::17) by PH8PR10MB6501.namprd10.prod.outlook.com
 (2603:10b6:510:22b::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Wed, 9 Jul
 2025 12:03:49 +0000
Received: from CY4PR1001MB2310.namprd10.prod.outlook.com
 ([fe80::5661:9254:4b5c:3428]) by CY4PR1001MB2310.namprd10.prod.outlook.com
 ([fe80::5661:9254:4b5c:3428%6]) with mapi id 15.20.8901.021; Wed, 9 Jul 2025
 12:03:49 +0000
Message-ID: <ef0e0364-29e2-47c2-8f0a-93f385cebf08@oracle.com>
Date: Wed, 9 Jul 2025 17:33:39 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15] fs/proc: do_task_stat: use __for_each_thread()
To: "Heyne, Maximilian" <mheyne@amazon.de>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman"
 <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Sauerwein, David" <dssauerw@amazon.de>,
        Sasha Levin <sashal@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <20250605-monty-tee-7cec3e1e@mheyne-amazon>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20250605-monty-tee-7cec3e1e@mheyne-amazon>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0176.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::18) To CY4PR1001MB2310.namprd10.prod.outlook.com
 (2603:10b6:910:4a::17)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR1001MB2310:EE_|PH8PR10MB6501:EE_
X-MS-Office365-Filtering-Correlation-Id: fe00c799-4f24-4013-f70b-08ddbee0aa13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y1ZzbWw0a1ZHNGNuTDVWblZxL3RmcWVVR3hOVXVoZ2d5RzYzR0c2M0M2aHJG?=
 =?utf-8?B?a21JSnUyZ2lzY2RsZ2tOZmlXbXVpRE5kSzFaaHdWSlI0MkZ1ZFkwTjh1N0M1?=
 =?utf-8?B?Z2ZDb2VjUDNjYVUxZ0lIa0k5VWFBdEtEdUE4cnlYdlNtb2tjZ2psZlhhWVlO?=
 =?utf-8?B?TnorVnpSSmI3SGhBdzk2ZUZmeXgzK2dMakhIeHpWRllhcGtTY2JYc3AzMHdH?=
 =?utf-8?B?UWRFNmdJS2p3SjErakRRL0pWNzZqb0VxeTNmRW9qYXhFWjhDWk85RDNlRk5H?=
 =?utf-8?B?bnd0ck5sZFZGVFh6OVhkbzVEZ2dsTU4yZ05neWxjTnR4eUdZU0VNT3pZYzU3?=
 =?utf-8?B?V1lWL2tBWXNzbHhzZmZYSjEwbi9PUXhIbEZzdkQxRm5sbUVKNm15Y0REUUQ2?=
 =?utf-8?B?M05aNE54bTNMWHZRTGRhOXVYRTNhQjBOeHp1NFpQc2J6ZE1KNGZpb1ppMUwv?=
 =?utf-8?B?ZnE1ckdkd2tHakd2ZmFhNy9rWDlENWVGeWQzNmVUR0hSYnBRTzVJZ2creE5o?=
 =?utf-8?B?bHRsSEdFV0Q5MDhlRWc2Z3hOUmgwUEJuUVdaY0k0SC9Hd3g0cGxnbm5VTzJu?=
 =?utf-8?B?QVYwbG91Q2l1anVSY3o3c0RUZWtKSGkvcjFoSXFuMWJyYTZ6UTVYcFh1dXRF?=
 =?utf-8?B?bFNQSkFEWndWY1NiS1Fqamd3Zk1MejloS1krVDdyNHd1cEVTVFJwTDVMYjlt?=
 =?utf-8?B?M3puRjZwR1k1WkVyOEYxSXJKeE5aK1h1VjR3WVRTZ0hremd6SG9LVVdiNHNi?=
 =?utf-8?B?U29zU3phT3A2WFpETGhqdEhzQzhqRXJlUCtqeVp0QXVvclgrbnk4Rnl4R1p1?=
 =?utf-8?B?c3l4TlFJQmZwa1NPZkd1Q09aZ0hpLytTMm4rOVN4aWhYSEpiM3JvdHJhbFdK?=
 =?utf-8?B?Q0FKbzZPZStWaVF0SVNzU1Q1Y21tMHorVmZXWTRndnFCTDFLSFBOVk9teXRq?=
 =?utf-8?B?U2lYMDJyWC9pMDlwRlIzVUp0a1EyRDZpOHhGeEpLTnRISWRweDlRRlNnTmtH?=
 =?utf-8?B?ZldKTzV5T3VsQytFdnB1QlZZaFlYT0FuZ2ZLUjJVbHpQQkM0UmhBYXl4dFdP?=
 =?utf-8?B?QmFzbmo2dlpqTjUyU3puNlRhOTBTbnFrdkViOUtuUkhpa3Vab2RUZ2VLYzds?=
 =?utf-8?B?RmZZbm9pTTZLbXZva3ZTL2M5QXN4R3VBNlc3WHNBemxzU0hPZTVnSXdBcG1W?=
 =?utf-8?B?b3g2dXByVWR0akJROGtmSHpiSjg4NGpiek9CSWpCNGZPb094VnV1VFlYS21x?=
 =?utf-8?B?TnQ1S205NkQ1dHVLc2RPbGt4SlNRbzJmTVl5SkNYZEc0aVhaRjBWajE2QmtO?=
 =?utf-8?B?UnFjQ0w5aGdtWFF5YkdpM09OUUgyd1RkL1J5dURNcFBWMExYektLYzFYc1kw?=
 =?utf-8?B?U1V3QVp1WmNONHQ5WDd3Y1RhTVgrSHRCMG5ockk1NG50aHEwYWZIVU1MNWRq?=
 =?utf-8?B?dXhCTGV0SnZyV0RGVVdza1B1WmJLMU1pVHFDU1hJUjcxV1c0Y0tLWmpiMU5I?=
 =?utf-8?B?TS9vdlQ0NTNUM3E3ODlRaE94V1hDZlNTMndXTFhWSit3dno4c0VCNWVucXVy?=
 =?utf-8?B?NTVzRklYMzhTQ2FTM3d2b3F1Sk0yMk5PNUpiS3pOMmZYdHR6dmpKRkdPTTBL?=
 =?utf-8?B?T2ZWQ052czdYVkw2N0ljbFNXdU12UGtFNjBRL1FGNk5QODBaQXMyRmJWWk00?=
 =?utf-8?B?YmhwTWN4NW5qZlNKcS8zaytUMEJnQXdjU09ubnZZYktpSitqaFh0Q29qU2la?=
 =?utf-8?B?MVhJU2c0VUtOQ2JIYmkwbFFWVlJxd1Nrbk5xdDUzKysrbkVkZ0xXNE9DSmFD?=
 =?utf-8?B?OHE5VE1IQlN1WWx4Q1l0WVZqSHVWdm1GUGpyWlBhbFBCL3IzWUZhYmQyZ3FU?=
 =?utf-8?B?MW9MWlRNcG5aa1RXd1NaWTh1cDY4dDRIVGpVU3Y1UVpsd1RNMUFZZEdYcnla?=
 =?utf-8?Q?JE5HZogm+fY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1001MB2310.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UGNYTnB5UFRib2hCQ2Y4V0dDc3luQVMxbS8xMnV2OVo1T1pnMVZiTnpvUm9F?=
 =?utf-8?B?dDdoekdLWU1zc2htWlMwRnNOd3VhaGJlNTl4N1hEMCtydk9rdmgxV3VJN3pC?=
 =?utf-8?B?eWJzK3dZcGJkK2ptSi9pR2RyTXl5dDNKUGVUbVRnbHhaV3RyMG8rMjIzT1Zw?=
 =?utf-8?B?dlAwbHVnQkgyRG9IS2ozOHRuT3F3UWRVd2d4S2NQTkpYa0tDOE9zV1ZoU1A1?=
 =?utf-8?B?b2U1QldNK0ZYMTh4c0hmT1piN2tyazBybFA5UTBFNE9SZWlrQXNtRjBVMTNZ?=
 =?utf-8?B?a2tHSlZhQXpDWk9NellyUXU3aGwyWEpVUEV4NUVvVGhFTWVzdDFhdGFlck9y?=
 =?utf-8?B?Y09hcmtHSnNwRWpvSTFlYWFNVURPOTJIemZMd2VQNVd0eEV2NWo1Y3l2cExW?=
 =?utf-8?B?OWVKcFEydG9hNGo0UDd3TWxSV0RFN1FtSFg1YTQycWltWlNueVdtREdpeXoy?=
 =?utf-8?B?YVZSN0kwVFlEeVczU1BxaE9BMEhNWk1CeXAycW4xU0RGVzYrNTlwaVVhWFor?=
 =?utf-8?B?TE1lS2hGc0xSaXEwN1M1MUdKMlViZTZqS3JLbUF5clJ6Q1FzT1ZCdUFxVXYr?=
 =?utf-8?B?Qng0VEg0Q0lnZk5rVTJMdFNqWjNzZ2s1clJ6aURROUpTR1F5Y08zY0VRVW05?=
 =?utf-8?B?Ym1wYXgwOFZaODlJZTFmbzJzbHdxc0FJcVg4MThFaGl5SnY4K21Pa1RLR3hE?=
 =?utf-8?B?L2VQcWhtVnFuNWVibXZsNU8xUzd5eEFzd1lOblhGMEdkaUNPRXhVbGhSK1lw?=
 =?utf-8?B?OGQyYktSdy93aW9EYWJmZTZrOGU2Q0xYMENSdGl1aGFoN1ZJOTkzekEzWE5s?=
 =?utf-8?B?RlppUDNPMEdGM1A1a010eTczRWFJVmlKZVU5Qmp5aVFZYnFqV3FOL1NGdkZM?=
 =?utf-8?B?ejZ5YUV0VFgyV1UzWHQ3VVUvdzhJVkxlaXM4QThPYU9Xb3VNMW9qV1Z2bzlr?=
 =?utf-8?B?ZkV6Q1hJZnduQklKZkpxZUFHeWQ4NlJqUXdxRFg3aTM2MDhIbG5ObVdXdkQy?=
 =?utf-8?B?R1E3M2xDQjh5S3pwQWpVWTNWMkQvRFdjbWxOWFBGUVBFdnVCWS8ycGhNeEtv?=
 =?utf-8?B?SmY0L2xoZkE2cEhYM0NZRHBoeEtVbE5kWVJrdkpkTXl1MUxKUkJuQThrTE95?=
 =?utf-8?B?MmlRZEFSc1ZuWENvWDlJY1NXbSthSHJJdFBHNDNnMTJDR2hjQjBvSnVaQ2Jx?=
 =?utf-8?B?cXk5UElLTk8zc1hoTldWNmVSNk84T21OYTZhMTdjS0ZwT1JtR1JURkxtSEdj?=
 =?utf-8?B?TkxwM1hFZ09DTzBPU3g5SjdHRWpmem1JRWtld1IzK2d6UTlXQ252OVBLMWIv?=
 =?utf-8?B?SXcxY3B6ck5JRnErK0YyMExna0YrQTVSdFpqSi82YXB3cFNIQURSZjBwa0Fw?=
 =?utf-8?B?MmFNZXBpZUQ4dG5lTmZSZVNqOWhHbFZ4MmQ1dEpabVVNR2lGSEFPOEhRTXFV?=
 =?utf-8?B?QVd6VldvdmhwdmdhamkrZlZOQ1pYM2ZVMnk4a1BIZDdzeWhDeWZablFNWWdI?=
 =?utf-8?B?VHlKYWlpbHpySnhndXRJcVhoVEZmNTM2WnRETktVb3dHVmJXUDJ6OFcwOGVT?=
 =?utf-8?B?NFFjK3hnaUN6SFBoNmZqc241WStIM096cEFhK0dWUER1VXl6SXVkVU9UaWxw?=
 =?utf-8?B?OGd4UURxWlFCa2JsKzNKRmlvVGFWSkZCVE9WMXNVMXliU2V1ZXd0YlhSbW9J?=
 =?utf-8?B?a0lmVmYxOTJ3ektTWDNIQUdyc3EvODhEQlhiaGlwMzNxcVl2R1VENDNNdWp1?=
 =?utf-8?B?V1dEeU5DMmJhU2xma3JPUFp5a3JycUpoa1BXbW1sMjNxOGhoS0hDZXZQdHJT?=
 =?utf-8?B?S1l6c0Y3eDVIV0lsS0VQdHVhdmxsaE9MWVhhY2tPdVEwL1RCL3RKQkpreUZH?=
 =?utf-8?B?ZGFhZmMzMHVDQSs0TmdrdWhpVGR0cXo5ckt6L0w0cDlQdXBBb29qck5wUFVw?=
 =?utf-8?B?ZFNtb0NKQXRYMHVWb1UvWnhTTTVNOHZoSzFhTkg3WFJBZi95TzBnd0haWENM?=
 =?utf-8?B?ckhCWUxsWmQybFlGeW10MHZ4Z2JyUnFJSkkwZFBnY3NJb2V0Mlkyb01QVXNI?=
 =?utf-8?B?aHB0c1RpblpkMWZtQzYvN2V5MTgvRHh6TEl1TkJTVDlCUnRnUjJrUDFTayt4?=
 =?utf-8?B?VWE4c0hnMERrbGpLTDlaL1BSQTlkY3VQQ0dVcm1HcmZDQWxTdmgxUFAxYUVu?=
 =?utf-8?Q?NACL9SxhF3Wjk+sAob/a0vs=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vwhR4s0L2GckS9KaEPJSuyNa3kqpL9OfYtY3B/8DKdXhDQEZ5Rm7iJ0SzOngT/XrM4yhGOFqKcFn7nsCU6TNl4TaEg8mItcCLR4GPgKUoHhDetNVEu0Al7nHqlX5gGy/9OztQk/Rd2H8ntKZ4IVrksUmxgi638mKJ7DAQGdGUbKCDat74MKJaE7QK3DDIbOxRyYnHHygrDtns7S4XwXY4fDRGDV7nrXGVjaHAXzkUA51Eof8bR3N6Nif0otCbyuD+b7LY8lAMEw2JfGOkl0zg7Kvt5JhcImc7MWiBOmKbBHNmvtSuhrkkLLucxwACUHbSTroxR+46KtP51HnNMBgLm5xUF7kPj0cdRQyjUdYJcTZCjGcMRt/sUK+3wSy1BGr3njWtNd8X83tqYX8H9udowZKA4JmZw0PSXBLnNJpeAGrxe9GUGZ3fWg37a7ksWAPl2JZ8Ae5Zm0Vm86qhNE6MiL9FoSWDA3FJulWItm6h48gcd2JvWljnl5t/X4Pu6Wi5MozDwNLdcZerySXMb8qvYoJKZIf7nWGzPTO9g2b3dDj/XSeT4rmfHGnssbX/VHd0JRE5O2kdo64nEJ2BZElEz7HDRLJ2C5ZjxpyaQMsTww=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe00c799-4f24-4013-f70b-08ddbee0aa13
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1001MB2310.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 12:03:49.4924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: orVEZMuBhEElEmCfcx/p1uVMm+cnjDnebGvfduc9Rv7zjy61u+kZbELPE3Km0hF2DxTjLUB6jiYJ/3mstzJ3d4+lkrf3kBESifGf56NfgyYVxASyjSmumhT7jiaendIn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6501
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_02,2025-07-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507090108
X-Proofpoint-ORIG-GUID: kMsO0GzQCMMHxJj3kOZ8eRJQ9HDmvbvM
X-Authority-Analysis: v=2.4 cv=caXSrmDM c=1 sm=1 tr=0 ts=686e5aaf b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=PtDNVHqPAAAA:8 a=Z4Rwk6OoAAAA:8 a=iJxYc2lspb_qI3TMNB0A:9 a=QEXdDO2ut3YA:10 a=BpimnaHY1jUKGyF_4-AF:22
 a=HkZW87K1Qel5hWWM3VKY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA5MDEwNiBTYWx0ZWRfX+ZUotQxneqAS 2EiyD5cUDVR2xQPFdSZPHXhgDdVllIrl0xDBzN8oQ3TsxBSkftHPm0UMnu095IYn5+Uj13MF0K4 sY6/7Wzz28tHLkpvvBZAvUise5ORy5PX5rGjzl+RkbywNE/gFjOcRKmTpfaqjWfBLxeUhke5R6y
 lcj4KS/gtJHsMmtwmZ7wF9z/a740YYR1D6TzZFiRWF2Cf91mn0NVIgBfrjq+0adUpJlZxqQS2Ig 8uL+Xb8hS6cqWyk0CzejQaRMmfOVOnqVCZjvSMHmukv7BB4W+uI+Z84QyNqYf97f1ftW/O7B/MA ANJUEIT2A3sWcRKmtHkKGKxSxd4Kooyrl/Q5hKHDDdkTNyBf9UUZ/hm1DNJcRhK8GKCXNUHVrfD
 GZGIYzL99OF0NiVYq/hAmNaAMLYq5FoVTU/+Ub+ZEGLIqnAgOYSZPA9NmAh6neTmpOdCfd+2
X-Proofpoint-GUID: kMsO0GzQCMMHxJj3kOZ8eRJQ9HDmvbvM

Hi,

+ stable

On 05/06/25 19:37, Heyne, Maximilian wrote:
> From: Oleg Nesterov <oleg@redhat.com>
> 
> [ Upstream commit 7904e53ed5a20fc678c01d5d1b07ec486425bb6a ]
> 
> do/while_each_thread should be avoided when possible.
> 
> Link: https://lkml.kernel.org/r/20230909164501.GA11581@redhat.com
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> Cc: Eric W. Biederman <ebiederm@xmission.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Stable-dep-of: 7601df8031fd ("fs/proc: do_task_stat: use sig->stats_lock to=ather the threads/children stats")
> [mheyne: adjusted context]
> Signed-off-by: Maximilian Heyne <mheyne@amazon.de>
> ---
> 
> Compile-tested only.
> We're seeing soft lock-ups with 5.10.237 because of the backport of
> commit 4fe85bdaabd6 ("fs/proc: do_task_stat: use sig->stats_lock to
> gather the threads/children stats"). I'm assuming this is broken on 5.15
> too.
> 

Note: We saw this as well after backporting the above mentioned commit 
from 5.15.y and your backport resolves it for us as well on 5.15.y based 
branch.


Thanks,
Harshit
> ---
>   fs/proc/array.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/proc/array.c b/fs/proc/array.c
> index 2cb01aaa67187..2ff568dc58387 100644
> --- a/fs/proc/array.c
> +++ b/fs/proc/array.c
> @@ -530,18 +530,18 @@ static int do_task_stat(struct seq_file *m, struct pi=_namespace *ns,
>   		cgtime = sig->cgtime;
>   = 		if (whole) {
> -			struct task_struct *t = task;
> +			struct task_struct *t;
>   = 			min_flt = sig->min_flt;
>   			maj_flt = sig->maj_flt;
>   			gtime = sig->gtime;
>   = 			rcu_read_lock();
> -			do {
> +			__for_each_thread(sig, t) {
>   				min_flt += t->min_flt;
>   				maj_flt += t->maj_flt;
>   				gtime += task_gtime(t);
> -			} while_each_thread(task, t);
> +			}
>   			rcu_read_unlock();
>   		}
>   	} while (need_seqretry(&sig->stats_lock, seq));
> -- =2.47.1
> 
> 
> 
> 
> Amazon Web Services Development Center Germany GmbH
> Tamara-Danz-Str. 13
> 10243 Berlin
> Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
> Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
> Sitz: Berlin
> Ust-ID: DE 365 538 597
> 
> 


