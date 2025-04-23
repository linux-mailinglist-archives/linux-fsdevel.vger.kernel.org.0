Return-Path: <linux-fsdevel+bounces-47049-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF472A98068
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 09:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB8B81691B5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 07:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F21267F4D;
	Wed, 23 Apr 2025 07:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RMwhmaF1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="A5Nq9Rpz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D761EE00B;
	Wed, 23 Apr 2025 07:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745392579; cv=fail; b=VuxCtoiQniM6S6pKH4RXBkDVDXkHVZjvNF+HFSIVQiYKP66zFa8FcghHj93RIjaFoIiJ5QemSoQ68QUad1v6FDgTHY0NoHRbkwrpM8BR2a++veV8i/trGS5So2oy5mhlQLf7tEfmAWqLiW4AtQyIfXS4ZMEBU9n8oeVOqcxSqr8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745392579; c=relaxed/simple;
	bh=kXKBcV0wdWxhFNRuXSOVPVL9RG9jMyPYB17JOAI2Iic=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=vA6W3NmoHbJJK2KDrLhc+HqNQDs8RAU/qEoBzvZFaD/KWJKDGP63sLAqh7Y3fxwDnVII5N7TbIb+rPP6MZGKUKVr/sKFaO3sNcEqMzJO8GpPxIIqHpfIl8NX50aaPNv6QQAorpbWTLax4Y+EJqxGViDjP4/Xv2l5b8uIp+BxKmg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RMwhmaF1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=A5Nq9Rpz; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53N0uSwn005061;
	Wed, 23 Apr 2025 07:15:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=GkEYPXCLwBubhY989vWEOdqmspm+WO9JHwFxdV6Spag=; b=
	RMwhmaF182KQMBhQPk4NNLQ90RSAlakav2+x28TrqQ3GlyJxSNqquMWPDvrqluy8
	gYw/N+kZG7VUBeh5SL5XDCPqDbuWGOghUx8q37ILhx0BxmH5i+3I82FzQzba09fR
	Vfe2MhJ+3ECLvLFuM1ihTzeep90PiWNozXf+KmSwP+qjezADI/hJCdRrYSUu5ML8
	WOCiesmAgnUG8DM8XcWBUbUT56LQpnZn2s/E/0xrac56M/BRqjYJcv1xQinnmc/p
	kB4wsTnZt5tMseMTSjk42GomEea3yMnkfNTbs3F+SfQjslZTCfVWe2L7+cff3Ftq
	jKjxKYcLzqvK4o1Mc81ACQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 466jh9gmde-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Apr 2025 07:15:50 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53N71Bvb017448;
	Wed, 23 Apr 2025 07:15:49 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2043.outbound.protection.outlook.com [104.47.70.43])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 466jveq4e9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Apr 2025 07:15:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=py5FMLWTO8tOMwivDF8kIudt3LxtGxo1hWh02fczT6zjqdPyx/RPpZ0KKvNFa3t3T4CQp/3rFFYT0gdVlYVvb0m2huC+WKb7utdXuLKJBIHiPaB3EAsxIbxlz0S6y2UEHYFStwwomTKkBh1hn/YilUSXKWAvblo1lJvJFWZvMnZ8bAlsXEGiPaX+FOhhHZifOQ9AenBXnEzlCboFM+FUde4xhaRysoVipqnQOnS1o0wuPwr6QffgYhIVf6Oi/ZaCEbnB2GiRH6DIevam1Djy5ulWDuGsDhg0aM5Ga02K/A26JVOv7LtiK0a5RShp/iMvM8zpIRpCIKA6KC/I1wyvvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GkEYPXCLwBubhY989vWEOdqmspm+WO9JHwFxdV6Spag=;
 b=urA9OkVnvYcPt4T0jPZg+Xp2aIDunrJtBeAPxLom1WvPxYwdGYO34eYhEkZmtzoTaw/HVKFR7WfSx8G3mJQpxf0U16n030EWzUYhA5DDmApnF+b6DdklzuxgpbstcQ4AlNAFyhF2I81j0yNcVqZri64kfL6cFW77pDFhwS6E3cVwJoOxHWTDooEfSrEc1SYhceC0uFreQmWkzmCyA5PU8tM8YtTZr8wRvXz6OGnciHcQDTa5sjDqmzUww6lX7V3oN9mmW96V42U+jMLbtrXIdtuYjQIrJsUSzPcdOw4TgGuTGWKPGuNJ++iUYSfoCHGWCd8MJH3k+LL+AX/ZYkDAKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GkEYPXCLwBubhY989vWEOdqmspm+WO9JHwFxdV6Spag=;
 b=A5Nq9RpzcxpTzT9m29hy70fOOHVdar5Z8Gp21Qx8CB4Npu9NnBb5pt+GxMCQfeElfcCHm6g07BaoxUCnQzml5nW9CjEA0KDkeFW0rTK78QWxbygfnQC/2/uW7dScfxCMIJ3f+pFELPlxvfmJZbPGtoPoAIaq/NRIwzQOW+LLm/s=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DM6PR10MB4139.namprd10.prod.outlook.com (2603:10b6:5:21d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.36; Wed, 23 Apr
 2025 07:15:47 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8655.033; Wed, 23 Apr 2025
 07:15:46 +0000
Message-ID: <f467a921-e7dd-4f5b-ac9f-c6e8c043143c@oracle.com>
Date: Wed, 23 Apr 2025 08:15:43 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 05/15] xfs: ignore HW which cannot atomic write a
 single block
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: brauner@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk, jack@suse.cz,
        cem@kernel.org, linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        linux-api@vger.kernel.org
References: <20250422122739.2230121-1-john.g.garry@oracle.com>
 <20250422122739.2230121-6-john.g.garry@oracle.com>
 <20250423003823.GW25675@frogsfrogsfrogs>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250423003823.GW25675@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0499.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13b::6) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DM6PR10MB4139:EE_
X-MS-Office365-Filtering-Correlation-Id: 30ed22d4-b2be-49cf-d19f-08dd8236ab0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?czc1OGRGRUFENFZLSHMvZmpTb1BKM3RFcnYxWDVqTmhicHFkZjhYNThDQ0FY?=
 =?utf-8?B?NGY3Z2I2WGdEYnBEdzdwWVcrV1BvS3UzTlNHSHQxTFkwWTkyZU4xUjZJRTgw?=
 =?utf-8?B?SFNEWFhlbCtoOTBkVHlrN0UxS3RpL0xTeVFLQVN3dVBVdDNSQVViTkpnUDEx?=
 =?utf-8?B?a3krZEx2bjFXdmRVWDBMaThIWnBIYVMxcEZQK2VFdko4M1liU1BtNmNsL3BL?=
 =?utf-8?B?Q1psSlloL1Q5bVBIT3hyWUd0cEJpSVRyenNGU1ZGek5pVzhFd2lYSHVraVZz?=
 =?utf-8?B?SjNBWmtwMnVsNWJZM05Ha3orVVF4bnpuYjF4cWVvRnRIcWhOV3cyemhKbHVP?=
 =?utf-8?B?U1JtTEtCRWN3M0lwS05SK0N4QWl4YUZLek9MeE1FVm9TNEFTb0l2cHppeFp0?=
 =?utf-8?B?TWZWZWp3TE80SEtZZkhFa2VRUVRuT1gzQ24wWWJRellXNklhTFZVT2ZGMDVH?=
 =?utf-8?B?cGNldW51SVlMdURiV3BoNkluU2pFNGF0clowdTVIOVIrNEFuY1RWR3BrYWtF?=
 =?utf-8?B?Qkh4TFZ2cmpWVXJva1hSZmVjbmg3aTZKQ0dSUVd4UXFtQ1RtY3JSL0QreXJr?=
 =?utf-8?B?VHpwL0tIdGN0N1U4b2diUHFBMCs3M1hkK0srK1BXQlJQZExKOTVwK3N3R0c1?=
 =?utf-8?B?dW5ocU8vV0VDTFhMMWtoc2pxekhpSGhzSDRLcGNTRTZzMEdpUHBuUk9sems0?=
 =?utf-8?B?WGt2YmhuSUVBdHFyNVZMdVRoKzBDRGZobHVNUi9ucW4xWmJEOU5uQlVBUkxJ?=
 =?utf-8?B?Q2ppWHhuYVVVUUxwMlhJTlpuQmw5ZTVLV2I0TTVKbjdvQUpMTmNhRzE0U0ly?=
 =?utf-8?B?Vm5QTHg1VHZUUkMzVlRCMXNpUmlCamZmVmpqay95cjFpeVlMUUIzblNzeEd1?=
 =?utf-8?B?RC9TNWkrN1NNSklFb1VueWRxQno0elRWUzNUcHpIUXJiUWFpbURvdmlodnZv?=
 =?utf-8?B?VjdkLzVYZjQxci9BT3pxYmFjdVgxbE1UVzVXaTlmc3Z5d1gwcmZLM2h6WEZl?=
 =?utf-8?B?U080UjVCdnErUFhGOU5qTGxicHFDYjFuM1RQNkJwdGNBVVlFRzgzYUl5bXlO?=
 =?utf-8?B?em5KYWhMWjA0TUZpVmlEbENOTXdsZ2pKS24yejQrQXhBc0svUUZoTXhqdko2?=
 =?utf-8?B?MXBoenhXRUlwSEFQcUZnbWd2YVJjY1pIeDlncTVZNmttMTRYQnRnOVZZRWo1?=
 =?utf-8?B?eWdORXhndEtESWhkdytvTTZCU2JsS3FIVDRwdGtsOHBibmFlWVFZeC9TNzFG?=
 =?utf-8?B?ekxqemxDOVI4S0doN3pVTXNGZWpLWDdrNzA0RDBvcm5XMDUwMExLU2dEZlJh?=
 =?utf-8?B?SHlvNlFBcGM1U1I0bE5yNzMyNnR1V2pacVJ2NXZnMXl6MGVncE1JUEIwTFF4?=
 =?utf-8?B?ajk4S0lRZCtjVEF2emFDaWJOZU5Xb0NKQzJSWDlpbi9MUllsRTRNbUtscFhn?=
 =?utf-8?B?L29DbkdkMFRxNzJGOTBTaVh1Y3dOdVYrR3lXbGx2bjdUUHRmcmxCNlQrQ1Nu?=
 =?utf-8?B?QU0vdmFZZnRZSW9HUGNmbVppeXpnZ2U3cHZOb1RHais2OFFnVlFKcWRhZjVm?=
 =?utf-8?B?U2VRS292T3hBV3VvRU9mNVNQZlJEWFFzMGtLNFVFRWxlYjBWWXpzQ294ZVBt?=
 =?utf-8?B?N3NXMk0xNU5sRnhlZVdGaDZoeGU2cUZscmh4WmI2RDh6V0JLQlovVm9IMEt6?=
 =?utf-8?B?Z3dYT3F3b3dkZlpYcUsweDFRR0QrcHhERFFTYzd4M1V5MnhQeGpMbXFzVStZ?=
 =?utf-8?B?T0JPYWs1WW5JRkdmWU4wV3FaNVNPS0hQWHFkdWgxTjhxdzlsSExMamJGeHBq?=
 =?utf-8?B?TTlBcWlZL25pUkpmQXBJekJlU05EbEVBT2tmN0JzZ3hOaW5zRmFocjVvVi8v?=
 =?utf-8?B?d3lLRkg1aEl4T2tyK1ZxNmxSOElDckd1aW9jZW1FZUtiY084b3ZPNE1NY3ln?=
 =?utf-8?Q?q2WbzIyRpeA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TC9tMjdLRG9qQ1hOcWUwWDNmMW9NdHFuNjE5c213bUIzWncyVFNkSCtzaUs4?=
 =?utf-8?B?enhTL0VScG1nbjBrTEg0b3M0TXpXbjY0UGZaL0h6OFpWV25vVVJtWkdyQkNH?=
 =?utf-8?B?YlBpVDBkN3dlMkpuZCtkbGVxazBiM0ZkRGxuekZINHN0K20yT0pMRjVWaFhs?=
 =?utf-8?B?N3R1SUczYUVuVnVPdWYxRUthRStKcU82RTZ4czdMM1F6NGo1L09xRUtaYmg2?=
 =?utf-8?B?TjlBd3J2MmtjZENQQnBnd2lzc3pMdWFMalF2ZWsxZUZjdHJxRDFJaFFIaDNR?=
 =?utf-8?B?OTE2NE1weXEybm9hNFRwK2U0WURLWWFabGl2UWx6SzBUT0R4TmpUNW1NbTgy?=
 =?utf-8?B?eGk5S3FWZXJ6L1lkWWVBT3BSdzBVYWZjK1RQbVR4WlQ2dThwdmJQQkZwamVT?=
 =?utf-8?B?QjJwbXczd05ma1A4bk85dEE2SEVVSWx2bFRSTnVDbHdia2YwU0xLWmhTYlBq?=
 =?utf-8?B?Nzl4U2o0V0xwelRHTjV2Y2RWL2V3MndWSHVFQXhxN0RTbjZsWVBBQ0hMckR0?=
 =?utf-8?B?SWRIZTZ5R2Z4NlVVK1ZVOUpWMnc0Wjg1SnRNUlkyZ3RLZ3d5RHBMWWFzbVhp?=
 =?utf-8?B?eHlJRTJ2T1ZlUWNXeUorWm1KeVdYTjlJTXF3dVQwV3B3K0h3R1o4dlZ5dmZy?=
 =?utf-8?B?cStWZzhhajZYbFdvays5a3ZtOFpiZDc4WVd2S2EwajlkSE4wQmxTZ0xOTER6?=
 =?utf-8?B?NW0rcmFxVUlDTWZIOG1BM0tqRHYvZDdJVFVBNWF6a3JIU2FQSStibGNPMmxX?=
 =?utf-8?B?aG1HeG4vRXM1czNQUThnWVlyRHJKZW91U0F0eWFjN1dMZDYwZ050c3Z6TkJv?=
 =?utf-8?B?VU1NeE5Td25SZ2o2d0lJZVBDMlpITTE1SkgzVjV1MGM2eTloSHBSQWdWMHIx?=
 =?utf-8?B?Y2txdnpxdlpRWllabDZnZ2NhZ1dHc0h6dnl3L2t4SkhyS2tPNWg0c1ZyRTA4?=
 =?utf-8?B?Wjl3MW1VVy9lckNWelo5RnFHUkdMLytHSXMrL1ptNlpqajdINnlJditOVTRy?=
 =?utf-8?B?VlI1R1hjSExKd3BCcWNaYThJZjV5bUVNSWlnSGRIZGhSV2RCd3RSMkwrak91?=
 =?utf-8?B?V3NoYzByVHN5TGNYbGthTTlmMlhodnF2YjRTdVczdUpmaVJLMjRqQTY3bG5h?=
 =?utf-8?B?ZDJEdEFaekJzNEsxZWhTVHRQM1YvOVRlNmZGWDEyckxKcldSRmQ2Q3YrcDdU?=
 =?utf-8?B?cXFjZmFlYm9ZWmsrMFB1bHdud2czbStGczI2bmVLRkJLd01uTTFWQmpGQ1Zy?=
 =?utf-8?B?ZFc5d3ExY3ROOE1pUWkxQitsVGZHRUpDRnhmQm01ZmpDcGU4L1BhSWtqcmFS?=
 =?utf-8?B?TGFUaDgxQVBZL0pkUjczeStKYVVIektxVkFIbUoyamUveE9nQmZBQzhOSWFz?=
 =?utf-8?B?OTl6VWYwTWpxWlVKZUUrcHdTNHUrRjY2ekhBL0RRQ21vY2J1dTA2aUJPZGht?=
 =?utf-8?B?bmtVWUFReXlnSExkaWdjQmVLdWZNdVVWNVlWcmdMOGFGQUVLcXZ4UUNySVhk?=
 =?utf-8?B?M2hUMmg2QkhnVEJiNnp6S00vdTU1VFpTNUxpNU9GUTIvS2ZMbGhhNXdTa2pw?=
 =?utf-8?B?MExIN3BEbXNtOGttMjlIUnhTM1liWXFpOUVHZWxCUGNpSGJySS9POTdzbXpR?=
 =?utf-8?B?cUVEaElVSDVDd1lRLzJ5emlpWGhUWmV6VTN5b3VQYi9UUm45aUxOWGh2aUwy?=
 =?utf-8?B?NUl1djBkTi9kbmYzZ1dVV281ajJkcmRRd2FEbVN4dFF4YllXcUpkQ0kzZkNV?=
 =?utf-8?B?c0hVUDBYSDFyM0VWV2MyTk9Jby9SaHlwUzNTcGFFaE9VZWNRRFl4Y0loVjJR?=
 =?utf-8?B?K2ptK1FkZlduR2xZMVlDQWYzeUt5NEl2UXo3cXNoeUtvNklVRk5QOURlNFZ3?=
 =?utf-8?B?WU9WN2dCVitWcG5jQUtYR0lsYTQ3WVNnZW90N280Q2p4MWtkOUJOWUZRaVBa?=
 =?utf-8?B?aE1US041T0xjSElUSHVpaVhyS1VKMzJpWHhCUDA4WWRLS0E5OWcyc25hSkVB?=
 =?utf-8?B?Y3YwVG51R2RDZFdzdE8yMGRubnp5RGJjQ1N1TjRRZ3EyOU9Db0FXUUovUFdQ?=
 =?utf-8?B?WStCbWZ1RWx1MktkOHkwZkNhVHRzNkF2OVZhTHpVT0xNVkFOcFovaG9KTzc0?=
 =?utf-8?B?cExlNTZaN1pmbWFweVpGcGJuM1dkelNLZUxtQWVpQ3pyUWF0bnNQK2RuQlc5?=
 =?utf-8?B?UWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	m0I9JJshhpb6fte8QUEAeFqemJE7iJuL4XK3rIfcyEz8UGO0MuHPeytqSFgfm4nW77Fp7sW/bN+D947F9OL0nqgtc96/L3U1oroovElFlOlapomqBkGE8FAhWhVhVg3n39nOyT8X1IdYtQFonJNKDN+6mfUCO9wn8r+WNWeuC7bLllPlHKWTKddt8zV9pvNwB20fZx0TErvun89PmhohtDnCUpil5oHLRz94NGvPXprSSh0yX7mJn61hh3n3hrtfrjcQYsH3ayD+ETsao+vg5as99EQuuUJbIPmO0nZP6D6rZ2w1n2dgDGhy6KVxA+6KA9PQYtaOhIBpUozC/Z94meOmeI+kS8pkgqxOTbVcnOqJ97oviyFdrjqOTzSajOdJsSOpcq1Uj1xpnyfw31r+LTeR6ML+FeDWOGwW6+hNE5xrXESh633Jb9W0+JE3J2oRFeb99gzqsXPoN/iW6dGxk6Uat6QurlubkDxnPyHVxBF4IZVhP1bsLOo78Eo4mEdnfja7axvHGJFc9JWIH8YAWmOedW0nw7Mu9NwFofOMACShb1sOnU58ZisgpZYXo7Gc8z2H3ydSMJZ736+MVy8tBSmdoo5QXKGQaOBd3F2O/RM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30ed22d4-b2be-49cf-d19f-08dd8236ab0c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 07:15:46.8180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wv/tebvvzUtD7pmGtEZy4isHC+T1pluUfZROMqw2Lm/HRz/zBZtP4aLb5oYPfWP6RHUgbAisl8OJgb2JJmI9og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4139
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-23_05,2025-04-22_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 spamscore=0 suspectscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2504230048
X-Proofpoint-GUID: Dpc1gPHC5UGW6w3PoKfLsOS3E4SEcEol
X-Proofpoint-ORIG-GUID: Dpc1gPHC5UGW6w3PoKfLsOS3E4SEcEol
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDIzMDA0NyBTYWx0ZWRfX8atEcj2pOwGw CcM0jNtkB4ZXi+s95yhiAbw2q8aDBNnNIIR9CZMxPocIky8UUtUSRJNAjnGOty/f/gIQUCc2QqS ku2T3shvrbgtkJBwdKtTMR14igl4M7luO0fBn4X+9zL7gFzwSpc6tqydNpSVGP0yLe6v9H1m7jt
 nbfWqdp7LbPFXGGUNH+wrBhVdsfde8lXas60SziWZbo2SHZvbsdYCIri58h2LvTT0SY+kyFP6XG 7jZ4MXNLoYFq6mq9IFXc5XkLv7OUCZ9ShQIwW+2AvW6q3b/CXh01L3YcPep3MDgSI45MiVXPJd7 s60D5qwrEYW0uRXR5mYpbQMhC5HWyhmssdGaIbW7c6WQrO5n+J3R95Q2Hy3dzDI60KOZGYHqr5M f5SK/vQa

On 23/04/2025 01:38, Darrick J. Wong wrote:
>>   
>> +	/*
>> +	 * Set atomic write unit max for mp. Ignore devices which cannot atomic
>> +	 * a single block, as they would be uncommon and more difficult to
>> +	 * support.
>> +	 */
>> +	if (mp->m_ddev_targp->bt_bdev_awu_min <= mp->m_sb.sb_blocksize &&
>> +	    mp->m_ddev_targp->bt_bdev_awu_max >= mp->m_sb.sb_blocksize)
>> +		mp->m_dd_awu_hw_max = mp->m_ddev_targp->bt_bdev_awu_max;
> If we don't want to use the device's atomic write capabilities due to
> fsblock alignment problems, why not just zero out bt_bdev_awu_min/max?
> That would cut down on the number of "awu" variables around the
> codebase.

Sure, I did consider this, but thought it a bit unpleasant to zero out 
structure members like this.

Ideally we could have not set them in the first place, but need to know 
the blocksize when xfs_alloc_buftarg() is called, but it is not yet set 
for mp/sb. Is there any neat way to know the blocksize when 
xfs_alloc_buftarg() is called?

> 
> /*
>   * Ignore hardware atomic writes if the device can't handle a single
>   * fsblock for us.  Most devices set the min_awu to the LBA size, but
>   * the spec allows for a functionality gap.
>   */
> static void

You would call this around the same point in xfs_mountfs(), right?

> xfs_buftarg_reconcile_awu(
> 	struct xfs_buftarg	*btp)
> {
> 	struct xfs_mount	*mp = btp->bt_mount;
> 
> 	if (btp->bt_bdev_awu_min > mp->m_sb.sb_blocksize ||
> 	    btp->bt_bdev_awu_max < mp->m_sb.sb_blocksize) {
> 		btp->bt_bdev_awu_min = 0;
> 		btp->bt_bdev_awu_max = 0;
> 	}
> }
> 
> 	xfs_buftarg_reconcile_awu(mp->m_ddev_targp);
> 	if (mp->m_rtdev_targp)
> 		xfs_buftarg_reconcile_awu(mp->m_rtdev_targp);
> 
> Hrm?

Cheers,
John

