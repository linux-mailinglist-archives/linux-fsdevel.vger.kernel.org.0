Return-Path: <linux-fsdevel+bounces-48051-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA40DAA916D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 12:55:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16332175D50
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 10:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1CDB202960;
	Mon,  5 May 2025 10:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jELqov31";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="C3z6F1Bo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74FB1FC0F3;
	Mon,  5 May 2025 10:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746442542; cv=fail; b=oXP+mEPoiNChK9/xpRvuPT0exTjol9STB0P92zIUi5bCj31FhwQJrRcsthOva79FJrGPeVEpxMKXuRTJxzkhS63pwJ7iZAGDWJsCldzEPkG9f5KM3lFhYYrygp9UZ+gBa9UzBHTMyi2ogYxkr8VbbuDL7lhbVQPMEI3nE/jI8tI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746442542; c=relaxed/simple;
	bh=RLiUF+4m0Tln7USgjHxaFyMCdFo69kaRVO9xvvEMCuE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=T+T0yrThWVNSRUNlee3G2D5JB6alywt73SXTk83S16yDSrmo1RRKAVymIqDCEssorwarS1ZAU8I38o9Uw7TEiNN5StZtgwWMq1hNNVKsbQTXeDuKqD+5TIFk4RQmNejq7dAuJFc+fNEGFcOe43oh9TysXfdSO/xmOvv8yoevi0M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jELqov31; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=C3z6F1Bo; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 545AMKdD015673;
	Mon, 5 May 2025 10:55:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=jYXQaSboLRvKxtMit4R2JvqoCbtEblBJ308p79UwmWU=; b=
	jELqov31pqlLqGm5WM+KvTzLvB3sYpJ+dw02SEYc49eI1lZynTMi9TNxnB2pLFEk
	7dvIPE2/Bl+opDuPBrGNNklRKLLZTpzLYfzkOZ+Bi06aiJhzxg4IgZInMyctkRyL
	2ynUxIOuvA9ezHxfEXemx8BTxfEevthKkAIY2wPREXVqn4ZrCHmP370LWCYK8k0x
	7wrDB9Veajjqbx8++gAj1HsNglOkkOsOOhYiwYpGqGzyZST/lw5jDDhPoPLRfH+f
	353Tdve35hOCONENxw9Yh0bFvnWF2HwSi+23ceEDV0mexquSjeiP/rhAhECMwL/K
	n/4Q6Qdghl3fKi4j7Y2sFg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46eugy81kf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 May 2025 10:55:26 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5458IBFZ037578;
	Mon, 5 May 2025 10:55:26 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazlp17013063.outbound.protection.outlook.com [40.93.20.63])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46d9k79kp6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 May 2025 10:55:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dD4ZgKkPrtoBiQ7o8afNAPGs9QVVcDCcCFjswefoZDgjleVvAijVxq8XIuGrIWzBrP51tgdXnWqPl7KAd3PX4hpZiWYBUGLFKc3XxwOA9d3IS7zk3XO08sFKoPzd05MyKmjWh8Lmkq+sBVh8wQV/Z/jlLs7RdT9jgbAxLcqYWT0GnnvXZuta0VB0dDK+BDUYpbIYC2c0BxCLYkYqZ72NwlUHaDJTOGcr52UN2L2s822ANIRzoMjU7RO8tGbity2o5AW7JEuAAeRkxZbElmxewWSXg4eoqhkZwgpmf3SOzN1BYthkJ5CbE78oIm+Ogdb4KGhzylyZmqZqNz396VC63A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jYXQaSboLRvKxtMit4R2JvqoCbtEblBJ308p79UwmWU=;
 b=r8NvaAWLBNLywvLIesddWKZBmzhpsIqX10fPwPBIkL/Qpa8Q1XA64KGnZgXkwdFYmQIrCgHWyOylBMWlP0MNYP+qiy2U2nTOfGBuUzYqu8+/KMjRBjQNA8ZKOsAtWsVhGWUY1zRbDdvOGW2Q+vAPdi1Dol8vBkmCfKy7DDHwu5Vi8ZlBSl0aXQ1Pt+9kNcYhl2VpiVCDQALK7yX926W3cypDBen2hTMulG5Vw1E96QfmrQ+QQ7ET8R1vlJXyYywyCObxdzSGyfAmsX9MbZWJB398Tw4uOHlqa1WuQlm5UOhkTVKOELQJH1vSAQDZup2aEz0MuB08RMzysbUzArHWvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jYXQaSboLRvKxtMit4R2JvqoCbtEblBJ308p79UwmWU=;
 b=C3z6F1Bo7FIXmTBMpXZ42uYRtEaa2Gcen6D5K8lgJW1HiQ4Qqdl0pR8D+FJ0W/lJ0asCABeohhYIdOTUBswJulLPwN14pZIMPME/GX3gHNxfXZh0ANXxiq+O0sPhwIFDZRMDxOJ6J+uMT/2o4/XBQyLaDwpl8vESiyAJP7+KZ4g=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by MW4PR10MB5883.namprd10.prod.outlook.com (2603:10b6:303:18f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Mon, 5 May
 2025 10:55:18 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%7]) with mapi id 15.20.8699.022; Mon, 5 May 2025
 10:55:17 +0000
Message-ID: <bb8efa28-19e6-42f5-9a26-cdc0bc48926e@oracle.com>
Date: Mon, 5 May 2025 11:55:13 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 02/16] xfs: only call xfs_setsize_buftarg once per
 buffer target
To: Christoph Hellwig <hch@lst.de>
Cc: brauner@kernel.org, djwong@kernel.org, viro@zeniv.linux.org.uk,
        jack@suse.cz, cem@kernel.org, linux-fsdevel@vger.kernel.org,
        dchinner@redhat.com, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com,
        linux-ext4@vger.kernel.org, linux-block@vger.kernel.org,
        catherine.hoang@oracle.com, linux-api@vger.kernel.org
References: <20250504085923.1895402-1-john.g.garry@oracle.com>
 <20250504085923.1895402-3-john.g.garry@oracle.com>
 <20250505054031.GA20925@lst.de>
 <8ea91e81-9b96-458e-bd4e-64eada31e184@oracle.com>
 <20250505104901.GA10128@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250505104901.GA10128@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO3P265CA0015.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:bb::20) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|MW4PR10MB5883:EE_
X-MS-Office365-Filtering-Correlation-Id: 78e12f90-cbed-47ef-6bbf-08dd8bc35292
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V29mTWhKamxTRURWSGhJbXdtR1hnQk5KWmJwNmw1V0tQZFVLbE80ZlpNMi9m?=
 =?utf-8?B?VlpSYklBdktXcTkyNGJmMHVPWHhpSXljQkx4M2t5MUZnMWdYRi9CV0hmd3NB?=
 =?utf-8?B?dExUV1pFTjVYdlFJeEtHem1TVmZJd3EyZjVySEsrRUxNdFprU2hvS3MwR241?=
 =?utf-8?B?d1dWNGxpTmpsY2NqR1FJYlJXcFg1R2E2alI3eDJqM3kzSWFHQkpuR3NqNW1p?=
 =?utf-8?B?MldaNk5OR2ttbEY4ZFU2dXludkhkcjRkZEwrM1djL3h3bG9BclBETUNGY0Y3?=
 =?utf-8?B?QnBseFR0WUY0WDROMjJmdmtwbjVnM05BNnJaL2pGZWRaNVNzTXc3TkNaSmJv?=
 =?utf-8?B?ZUV2WU1QdEZjOG00SzZKbEh1YVgrbkd1UnVQNWNUQ3hTRjVpZUlLb2ppY2la?=
 =?utf-8?B?Yk5mdUpUZW9SWUMzQUYwZThYRUxkMFdJZ2hob3JUaWwrVC9vY3dNUmJheEgv?=
 =?utf-8?B?eURmWnZSZ2Y4UTdZeWNlUTUzdjRMbzZaS2RxSHh1OUhPSzltM2pIekFXaGhS?=
 =?utf-8?B?c2Y3S1J5MWpLRklUMXM3RW5ubmlzbittMlpqOE5VTFBtUTlad1VKWXZ2K3Nz?=
 =?utf-8?B?b0p6OUxMenJKdGFuay8zT2h3dUdSWTdEK1Q2Q3JENFgyazhpQzdCMjVqVHFZ?=
 =?utf-8?B?Nk1Xc2RZWWVpd3ZDS295WEc4TFRKZjBINS90RG11QW8xeEh6R3R4cGVXVkp4?=
 =?utf-8?B?WFRqcmo4aytUbVJUTXpTNTUyM2RZWWwyd1hXV1dUYnB3V0VCM1FpZEVvL042?=
 =?utf-8?B?LzhXeVBTbzZiVjA2dXk0Kzh3dGNOR2REU2pyZUVxNHZzZTNGYU1qZHZIVWxE?=
 =?utf-8?B?SEQxTHdteDhLWXJNYmF6UFNIVWpkK1o2NnQ4UGhXd3VyZVgxU3hwYmdvWm9D?=
 =?utf-8?B?ZTZRU09USW1QVEhLd1MzUUhrRG4zUFl3a08wRlhPVjJZODd4VFhZeHZVS0ZD?=
 =?utf-8?B?dG85WTNBZTEySzkxZGZJVnV3K0I5dllpcWlmT2xUczVkdHUyU05pSlMxaVlw?=
 =?utf-8?B?dE5qR3Rhc2xMckFkakxEYWlTeVNXSTI5bmF1cDVaZkJXMWVTaUl0Q21lUGR4?=
 =?utf-8?B?bThpWHBzeXRNSUVHbWZuejlJWmNRMWxwSjFMaUpMSFZMS0hOYXZtTytjMUZM?=
 =?utf-8?B?aWJqWjhoVlFQOXNGTGtSV2t3cmRXVEh0SUVrMzExMDlQV0JnQWNQaXpQaXdL?=
 =?utf-8?B?aXZWSWpySlFrK0Z0eEhQVU9tQy90MFZ0VklMaFVmeHlnRnFtaDRRKzdPdERF?=
 =?utf-8?B?SENiSVlZSERQYmVGS0FUelMvSTNSZkNTVW4zdHdSbzlHTGVubE8yb2I4MTgy?=
 =?utf-8?B?Q3cyVUl6dEx5OTNoOGNjbjlMamZDaGF4QzNkekV0RDEwQTgxS0toWEZMK2o0?=
 =?utf-8?B?K2Z6SHU2bFBWbjVMSzFjT0NmU0V5Rm1ENjN3cnNiNUg4ZE9ZWmF2eHBaTjZi?=
 =?utf-8?B?WHplSkVubVNkelVVWDdEZWtpL3BzR2pTUStNNWZCWlJEc0hHMCtoYnUrNnJi?=
 =?utf-8?B?cEpmbmFiMGZQVVJUWkt3UHFvbjk5MnBuNk5EU2l5aHlEcEZrdWExMHhkMFhZ?=
 =?utf-8?B?UWhHSlVram5Xc3cvL0paTUJxT1dJWDNPK0QyTkhlQ0NQVUttWXZyL1c3WTRk?=
 =?utf-8?B?UVA5VVU2OG05MkJCdXBaNk9XYmdqMERmNk42bzZTRUJhTmZtMUIzcGUrSE5S?=
 =?utf-8?B?NnRVVmdXN2p1QmtTQ1NQejhYRU9YRHlBVlRGUSt5YzFUSG9wQXBOalpydmxs?=
 =?utf-8?B?TUlTOHpSajFTNU1VcW5DOE9vaDFHeGJXeGVER1V3clVFYjcwYnJ6b05rdGdG?=
 =?utf-8?B?eFVGc0xXeDNUZUtrV0ZSMEUrdmpzbTBPYVRJK1dYS3dqWmY2UUFZcXNncFdG?=
 =?utf-8?B?K3B2dUY1VllXRVJ4aml2aFdRcXc2R0l2RkNqUnRzaTB0eVRtNzIvVUFvMmtM?=
 =?utf-8?Q?CgmYjejZSjE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S01KRi9FclZFalZLTEllWmJteW9WTnRRNWxzVUcvMm5Ia3o0ZDF2ZGt2WU5m?=
 =?utf-8?B?cFc0Y0E4RjR1SUJSNHV4TTZOMzE0VWF5UXdDK25CYS93a3VFd3FTWDNqVjds?=
 =?utf-8?B?SFQvYjdJL0ViQ29rV0lLWTlxS216aFVodlF4NXZ3SENOSndJMjlyd3RPaCtO?=
 =?utf-8?B?cHo5YWlUNGJUeW9ySCtKYm4rVGhzRllYZkZJUHdxN1FWZ2tOa29VbGg0V0po?=
 =?utf-8?B?blhBc1Y0Y2dzY1p0c296MzdObXJXUDZ2WURvRXhBQnVHK1NUdDFxa1JIYjQw?=
 =?utf-8?B?aUlHRGRtQnkzMWlZSFpmTFBBZjZsWElBa1lqQVUzQnlKMDhUdVNCdUdZeE1h?=
 =?utf-8?B?c1ZvWWo0TUpzNXlFV3U5bDZLRHdmK2VEeGxJbWxJUkJDNVpZa0dVUGxzQXNE?=
 =?utf-8?B?Nlc3Y1gwRkxhVkM1bnVZNStFaTk4aXFWeFdnYUpYdDFDVGVxRnJTdnJTVjBJ?=
 =?utf-8?B?WDRiS1Y2VnVsTEVaaVh5NUk5VFhvYmw1bzNHZWVzYlV1cS96eTdOaWh5c01n?=
 =?utf-8?B?bmM4YXZ5amlPMVdPNzdDMnRSZGtIdVhqOGtFNXJpdjZwTEMvWmpJUGtHM0t0?=
 =?utf-8?B?bWJjWlhxMUp3MlU3RFMxTkZvUUpLY0Z5dm13L3l6UXY4WmJPSVZNbmU2cVE0?=
 =?utf-8?B?d2huKzVjVEJ5c3AxZGpzWkc2UFp4by9nOTNKaHhQcHowZUw2WUswdm82NURB?=
 =?utf-8?B?YzhLSUhwK3krYTMrUnJOenJyTWFxVFBxRmE1MW9NRFdDcGdhZFk4WU1zaU9L?=
 =?utf-8?B?ZzE4MUw2MVRuUEs3L2U5VUJUSWNHdDkwYlVhOHVoSkZGbWl3d080L01sck4r?=
 =?utf-8?B?RnlpdmdZOFZzZ20wR3V1bm95SlFwTm9JNTBMYm5BTVpJNTQzQVJJS3FPYmtD?=
 =?utf-8?B?Ry9DRks1ZktLVVNrV3FXNFMzSDAvcHV4bzF1Qzc5K1kzdWt1M0xmazMxWm9K?=
 =?utf-8?B?a3J4RTU1cGxjeDBHUUk5WVAvNTVTcjZ2RnBwN090bUI5eGo2aWhwR1Z5NUNN?=
 =?utf-8?B?UGFmYm13MDFLZVgxUHkxWHF3eGI5N0E0QXl0NEZrZU1UVUNvSG12aXN6ZE95?=
 =?utf-8?B?dVp4c2MwYVhwVk5IWWFTL2k0Vk1kUUpPejZsQXE4NzNOMHlZRzBrbE5MY2FB?=
 =?utf-8?B?UDN2Z3FyQXM3WlZEOUJMNjlUR2RtNkhyTVJtSm04RlBVaDl0UnpqSVZtS0pS?=
 =?utf-8?B?eWZ1WHJ3d3R1Y29uTzlYdnVsOGpFNkNBWmpVSmFScVdhSGtoZlJoR0lOVTRQ?=
 =?utf-8?B?N1Q3aXFEekgvVS9qd2lybmNjY09lYmlpOTZncW1vdFlrREs0VTE1Zm8wUk16?=
 =?utf-8?B?TndQYVdxUkoxakNuVUF2cUhpK1FXbU03V0s5dU11YXVRU3lxYU9NS1ErZE02?=
 =?utf-8?B?a1JDLzBtS0JrWkt0a09BWlFDRjJNaTk3dTZEOUJYaE5jeXpRN29kbTh3RVRL?=
 =?utf-8?B?VXNmdGl2UU1FZmtwVk5hTSs2MDNCeXExYkFZVDJFSnJHR0dGaGM2ZWMxTlQx?=
 =?utf-8?B?VnlZMjVhcmdmQ3MwNWhQc2QyV3l5dWo3VkNEcW5WclhSaWFpR0tyTFN1WXJi?=
 =?utf-8?B?K2crcWc0U3AxMndTSVpwUWNRa0FPRmtaM0Q3UDJKZGJvbTlUR01hZ1RBVFlm?=
 =?utf-8?B?SHRuL2xydksvZTVvdXU5YkdBZDBmK1Y5WS9BRWVSWWRiaUNQN2RKZDhNSjEy?=
 =?utf-8?B?V2tWMnh1aFZUVEJuUGhoVC9HT2JtRGFUbmpxeXpJbWhyckdWeU5XTExHYmh0?=
 =?utf-8?B?NWJrMld3dmRXRXB1VWZ5ckp3bFlXZGo5SmY5bEZnL1RBV1J3SnpFbGE2aHFX?=
 =?utf-8?B?bEI0WEhiMG1LSGZKOFRvbW1HSlhhbTlCUzRtQnpUZUMreWlqMnp1NEIrVVJx?=
 =?utf-8?B?YTB5T2VpNnlpZHZVQm5wNmlsY24xbW1qd3Y5MUwyelpKZ0dKRWJQNzBwL3Fh?=
 =?utf-8?B?Vmt6OXRJUk0weFhsdzJtN3lxSGxWZ0JxMVRMRFdSRWlwVitIa2w1SmNLQUZT?=
 =?utf-8?B?aDBIQllsM2VYeFFrVnFQZkEyZXpWS1VmL3UwT3kyUGcyMkcrZlRXMlpqa2JF?=
 =?utf-8?B?VklQaXhicnNhOWc4ZE5KSjJqaGZoeTFDVmVwWnc4WWp2NlkwUmR4V1RVTW1R?=
 =?utf-8?B?eXJuNk1ocGdIOVllUkE1MjFWeTlialJmRkZUR1lnNGhRQ1FZZUJleWZvdVVQ?=
 =?utf-8?B?akE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gZfSl/VE6ei7hco4DuswK34YRSXEVy85J34y0C6lX1iYCzr3me+kUk4zCsi/Vfid173KhHYH4qaDjVxDDza83WjyB6hBa6nMHt5k+2BV7xJiosnfnixETsU6LuRWvjq6wSmOGhJWRriQifWiUfL0RxHYbYD7Ds9wSmBi0flvHWUeq7ub6eq/YcK8Oy5V2tYKTAtDwYGlnpIPJHps0OtRZl3Fh6h8WF2WprpKfS8e56VFZZ0JQzal9g0Zxhu4gr/t24TmUg5xrXlcbDfcsI1QL9lpRhvnQtIIdumyaWF5t71y3XTctc2dXkE2aFmYFcdHsYYdueDuQd0NptWXGe1lw4TX7CV17vltGaBWLeeag0KEcrWjLiXIDeoQjMq+9y8CXmxt8S48vOjT1U+zhan/6OCLXuIVRGINWA0c1UHWIik2SULhZFLWFs/jIuBRvatxcp46XjqMVyJ5i49BPjUc0CLyT2uT573J9koR1InHDZZf87gQw4/9wIXaxEhWedNhz1SwX2aVcXPLL7NX7b2RnXr0s8vhUcZOOKIw2rMrVsCzHootJkOL+Ghp8au3k/HJDmdl+bNSVngeQNn02WqOELHY22Q6z8iVvZ1lDXdQfoE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78e12f90-cbed-47ef-6bbf-08dd8bc35292
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 10:55:17.9405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CCuxgShZINn9YTtuqmAGoE+V8B3J/cMxBwltli9RW06h/zusIATyn2f9jE4fdFBPwxnd9ZikdZvQXKnFd0BBCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5883
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-05_05,2025-04-30_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 adultscore=0 mlxscore=0 spamscore=0 mlxlogscore=989 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505050104
X-Proofpoint-GUID: ZQYJ4753WVdCHDA_HRIM7pchIX-qKO75
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA1MDEwMyBTYWx0ZWRfX7y3zClcwGP05 hzg7pg6r+ZZSDvVyzE77H0T6PvFzvk4Xq/aUUBAV0X1MbaCIHEhLx4ZsPLlQRZ9LxI1F02lZWVE 5crQ8emH9TR+idRdIzfvKSqOZcrM9tUZ89KoUsUx9/NRuGra4xmWhvAx/4mv1CifwFcjVy5fag0
 G8rrO0/TANk9Av1zlprIF9XPPzp/O+sOOwCpAvMTRZoz//ZIgNhMY6nYpt557qaOHmXMzlR97vQ 4kUcK+rCW7RYz98v2Phh1t4n8m5EJqbD99aW9LM4s9exezzlhVo3YW5DOlplbgFgBvDkRgVIgVT I3IncRqKOl7BUhWmJzYIKykblWhOqI/j3r5kp9J9JwQupBw8K3+8MC+9yhrUM+0apKpjd1IAxkV
 z9s370qnFieVSqvPAEdXKkt9dQQOJJWRzSWwRCYs4K6ojZW4KCSW7FD+nlRw/JRA3U/dImFr
X-Proofpoint-ORIG-GUID: ZQYJ4753WVdCHDA_HRIM7pchIX-qKO75
X-Authority-Analysis: v=2.4 cv=NOPV+16g c=1 sm=1 tr=0 ts=6818991e cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=15AC0CraAwGHpATqzikA:9 a=QEXdDO2ut3YA:10

On 05/05/2025 11:49, Christoph Hellwig wrote:
> On Mon, May 05, 2025 at 11:04:55AM +0100, John Garry wrote:
>> @@ -503,6 +509,9 @@ xfs_open_devices(
>>   		mp->m_logdev_targp = xfs_alloc_buftarg(mp, logdev_file);
>>   		if (!mp->m_logdev_targp)
>>   			goto out_free_rtdev_targ;
>> +		error = sync_blockdev(mp->m_logdev_targp->bt_bdev);
>> +		if (error)
>> +			goto out_free_rtdev_targ;
>>   	} else {
>>   		mp->m_logdev_targp = mp->m_ddev_targp;
>>   		/* Handle won't be used, drop it */
>>
>>
>> Right?
> Yes.  Or in fact just folding it into xfs_alloc_buftarg, which might
> be even simpler.

Yes, that was my next question..

>  While you're at it adding a command why we are doing
> the sync would also be really useful, and having it in just one place
> helps with that.

ok, there was such comment in xfs_preflush_devices().

@Darrick, please comment on whether happy with changes discussed.

Thanks,
John


