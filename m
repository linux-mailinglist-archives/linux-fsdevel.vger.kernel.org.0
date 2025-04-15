Return-Path: <linux-fsdevel+bounces-46507-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACFAAA8A5F7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 19:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1CF644095D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 17:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC12922170B;
	Tue, 15 Apr 2025 17:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VdVJ4cf9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lE/enb5u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8AE1BC2A;
	Tue, 15 Apr 2025 17:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744739226; cv=fail; b=LxRhvnZBrydbVgBjE76ryTsJCT2cEQZCnI5/DFHa9OmICjO1xezODqN07pCOKPbMJEvWKkeSeCGUnSug0ZxNVu+oW2XKr+WTVteD78xJt92oSBWDHekg4xCAytJ36uSZ2zvkVEo0GSL8vcDJeFcd63elEpsD8/EOqnDCLy01TPE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744739226; c=relaxed/simple;
	bh=wX9OWC4dopt/pVcq90uTrd1ff+LQAxD2SDypC2FCryU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dER/Od5A/GSZiLt/9Pf2T7FnJcSVvUzeTSa5NyIWIrTjXC1Ty2TRg7NIarpvzJp/0bjDJgYKsH5x1ZrXw1a+Xlw2kKym32GG3j39jqtBLvyFEuLPpS6GTB9kYGag3Jv4xy7iJhGfe3HMRztOql9KULeMGulKtMBnc7a52h98llc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VdVJ4cf9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lE/enb5u; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53FHg4fq031643;
	Tue, 15 Apr 2025 17:46:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=q0YmPj0jzuK5k1m851VpTZwNp1e9U7apOnrNuiU7hro=; b=
	VdVJ4cf92Ohoz0PRGVNk/EDeLzeYYZXLIS99o5+u7DyN7hRuGDqdyQSb4ocLi9l9
	tKX1RX0YXUoEnjuVtdjbgqVDQiayv/I/9zCiYozXx95EYy78V7mSYoFlykzojJQI
	yIceMIvBSIjFGki5l6Hi6XPZopSQgl183b6uqVTCNhBl9kydRG7U4gqnWsYw1xFm
	7ogYBoPAoMdeuDzlfkhUoq/USHDHHOjV54YqI/dk+H8iNF4urkwdD0BFHIIF9Cnr
	y4mrCqM4Y5PrizGFDCbR1THTwHe8f+BIyo8bvQqFuX52fPsTheNL1Y/iHWn8f8Vk
	rBrnxA3Wb4HMR38xB3dS0A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 461944a3yy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Apr 2025 17:46:47 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53FGwsjg030956;
	Tue, 15 Apr 2025 17:46:45 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazlp17011026.outbound.protection.outlook.com [40.93.14.26])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 460dbay8ky-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Apr 2025 17:46:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FxbhGEvu5h/V4lpF0LWwGaX3SWHt1uL2APKxKXUkVOqoKgjrgCHbKwWR4FCGVDTKt2NV8nGD7N2Wp6GmEgJ8VIVY0TuW0J3btyBdyw/PIoyMO5WLezMX1gpK+F0ktcWHasvffmpgkqJ84akUaL5y+cVZm0nK1t8Z4JRvzVxCwjpi6exVSRseTtUIbStJXBLMAN+5gBi9f+jNacBNsyVfOsnPgnyTPyP7jriqfI61DRGCbVD0gXpmXhTQOmgSGKYaQ1p2jTYkx35YdankW+Cgvlfzofz6cllzQtx/KCvWPbwuy/0Y6eIU8GJgs732AQ+P7akvoLyZIDng/451FaUOXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q0YmPj0jzuK5k1m851VpTZwNp1e9U7apOnrNuiU7hro=;
 b=OwGaBK/HZkdI/u/YTjMR8Xrhvsya2JGpC7cbTuRYPv4s883djI4v03zM7j8seZMlp08VXqXHytnbCR6WztS68YjU9t21XGU9IZPYDl5E6br0EbcQoG9eyLK6BshYPihixuacL3H5p5JzUA6eENqFUZzDLTi6wdJYB6KS3Df4x6Z9fW0LZsZGqxx33/jYrbTVBDp+ck9A0O27UBQ/gRglwpzP+hqg8geUsuu0ecl/ssZ8ftgFW95KE6dO8QleIH1jZ4YFKPqFQ1xxh5+LYaow3DhxFR+mE5irZUdcf3FFGTUNgg0xPc2hxanl9MefGOkFHqI27AGNpORA1UXgsSwRqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q0YmPj0jzuK5k1m851VpTZwNp1e9U7apOnrNuiU7hro=;
 b=lE/enb5uGjJotREREquOSiw9HhxABzRFxlYcu7SLjzzutGVAI6kQ6LZ7CBc0kiiq9GkMjDpTvqknKXU82tx+6wKExHhwdV0knkB31FZQCIOXDvetVMhgCGOY5wl+3Ddb3t1Nr33IFYdaPhObUapE9SUnR1UzPGk3ipNtW0Y63Lg=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by BN0PR10MB4951.namprd10.prod.outlook.com (2603:10b6:408:117::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Tue, 15 Apr
 2025 17:46:43 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8632.036; Tue, 15 Apr 2025
 17:46:43 +0000
Message-ID: <cf7e2a1c-0b2c-4295-81e8-0f407fe72768@oracle.com>
Date: Tue, 15 Apr 2025 18:46:38 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 09/14] xfs: add large atomic writes checks in
 xfs_direct_write_iomap_begin()
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: brauner@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk, jack@suse.cz,
        cem@kernel.org, linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        linux-api@vger.kernel.org
References: <20250415121425.4146847-1-john.g.garry@oracle.com>
 <20250415121425.4146847-10-john.g.garry@oracle.com>
 <20250415173439.GU25675@frogsfrogsfrogs>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250415173439.GU25675@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0349.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18d::12) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|BN0PR10MB4951:EE_
X-MS-Office365-Filtering-Correlation-Id: 41e04d41-d703-4207-43f9-08dd7c457bfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RlNyR01kditIbGRRQXJmbmVyc21HUVFrMDFDMEs2YzkwcjBYSVFES1JyaytC?=
 =?utf-8?B?LyswZVRQTCt2aytSZHdJcCswSXQ0VE5ndzdQMG5raFJZNVZBMmJZQy84aGlO?=
 =?utf-8?B?RVU1R1ZuOExxNC9sR0l2VUxDVGpyYzJLUXRHbkRzSDFYV0xOUzd2VXB3bVFG?=
 =?utf-8?B?QW5JMmQ2WC9PTFc2TXV6WnpDUG9KcHdmanJzRktXOVROem4yd3NTWVZjVG5p?=
 =?utf-8?B?UXFQc0VIZCtzVjExa1hNcG5oazU4bjdiWGFoU2JoQVJwQWtzakVnaWhZZGVj?=
 =?utf-8?B?NWRublI1OGlwZWtHRjdEYm1GNHFpQ09LLzVWVkpiNWNkUmd3aTNwbGJzdWJR?=
 =?utf-8?B?eWZrd3ZFK3dnaWxwSkN3c1g4SHZDREJNdHFCQTlGdkJYZDUwOXFSOGhTcFdp?=
 =?utf-8?B?Mjd0TmRRR1BuM3VLaFJKM0JjYTZWU1Jmd1hra1VOUmptT2RzVnM5TXdVdWZV?=
 =?utf-8?B?cmZWTmUxZURvOXAwczd4dG5WSmRoUFFmZ0JPakppSHluRE1vQjFEcHJ1TXZu?=
 =?utf-8?B?NW1tOGF2WVEyVndVN2RYcHRyZ2ozNDVNNnQ3OXFuQlR3WEpvM21IWDc1aGV5?=
 =?utf-8?B?SnVIMTVlQlNNREd6eHJVOVZJT0tVUEgyOHlMV2ZydWk4cjFqRDAzVzJBZDg3?=
 =?utf-8?B?MU9kUURERDhnbC9PV1FvSkJQYU80NVRJaTNXSFpsNUpoL2g0NEtYZHVmZldT?=
 =?utf-8?B?aGdOVEJxSTRwTkhKZnZPOVVsc1p2emRuMTd1dXA3SDZJZndwMWs3RVpwK0Mx?=
 =?utf-8?B?dmRTQWQ3QkNnZ3NYK2VGa1NRWDB6bkVyNTBwNVltVjdWUkRGak1KQm9OSmF5?=
 =?utf-8?B?ZU1LWWFxY0E0ZXZZaWdyMmJJMWJKNERvY2JoQVFnTnByZHJkRDRKSmZ2d2dH?=
 =?utf-8?B?cXdmKzlKejJzWjhzbGZDSlpMeFZPN1JxUWhKR2pOTTh2aFlmSHl0Q2ZpVGdy?=
 =?utf-8?B?Z1lWcVc1c0hFeFFtM2gzTzVucCtzTXpEaWpKUjg3bE95U2wxYnZLM0JLbExm?=
 =?utf-8?B?RGFya3J1SHBocEdlUjMxZ0NGWlVISTZvMW5ZRktSRUxmRlVJUEtYOFg2UkRx?=
 =?utf-8?B?Ny9nNDhTeVN4SEpEUmxubzM1eXQ1cUhqczdlS2FzTkJKb2tBc0hqMlRQOFh4?=
 =?utf-8?B?L1ZadGFpc284RUxmbzcwQjVHSzFUeUszSS91cy8yZ1VIVHljVG0xNDVWNzZs?=
 =?utf-8?B?QnVmMVlwc3pLMDQrby81RURHTit5TUk0b3dwRzJwWEoxTFBtRmlFd0NEdTdQ?=
 =?utf-8?B?RDlrNGNjUmRWZS9BM3BMN0I2cHlNdlJ4dkxOOEtvMlV0R2x1bkY4b2ptQ0Zi?=
 =?utf-8?B?MVFvc3U5YVdMNTZla1BLbEhWUWQxSGxBZDZobVdFaWNlcGhSdGxIREVNTzhk?=
 =?utf-8?B?NHhXTVVXOThOZWt3bHoxVmhzWS9tbThpUkpXZHhUZ01oUW80U3g0R3FReThT?=
 =?utf-8?B?ZXFnK2lwdExEbHZTaGgwZllYU244RVowWjN4RGhLV0pnZHZtV1crTlE3QStH?=
 =?utf-8?B?Nzh6QXFTQkxYc2QrTDdsaWY0YXJzVjlmdHNqQk1rK1pHbTJYT2lNNnFOYThy?=
 =?utf-8?B?dzB4OEk3ZmhCREFoMi9BUDBXM00rZmlHcFhUWm95Zzg5SGdneXJDRklqSXBj?=
 =?utf-8?B?ckIxOHdHaXFzV1NuZzBnSCtZN3ZVWHcyZXRCcWZjdVZUL2d2VnZaNm9QNlVl?=
 =?utf-8?B?Q0xmayszdXh2YzVBRUlPbnUrS1JrRmlVK0UrOXRQUHB4WWZxbm8xUXhOTVJZ?=
 =?utf-8?B?eTVkZHZWTndhd1V1MStISVFucGdlZnYvdm9KS09ZaGkwTEYzcXBiM01MMjNx?=
 =?utf-8?B?blh2Y3FlTC9tRWNVN3E4NFE1ZWNXUWFMc3Fwa0JYMjAvakZjMXpxeUFsWWQ5?=
 =?utf-8?B?bnNQb1RISnBKYzFPazlUODJtN09yaEdocGlsRmhLbEo5aGpJUVMvVW9xTXpV?=
 =?utf-8?Q?DJZPeKu77q4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U05zeVhTVHNRTEJMeW9ndzNGN3JDaDhadk5ISFM5Q2tvY0s0MHo1K1g5VkdJ?=
 =?utf-8?B?dGFxaDhzVGp2dloxd2lCYXBxVUxTUXJoWEpETVBQWHVlejE2LytCYUlKMlZE?=
 =?utf-8?B?MGdNQnIwd2lJYWg1aGUrZGtpd0t0aDhhYmpmWkVEaDJYa2RjZGxEemRwWkhw?=
 =?utf-8?B?VlZVeHRmU1A4V2VXakcwbmVLTitDY004TFpMcTFaRjJjcUkwTSsyY29SYkZw?=
 =?utf-8?B?K0ZEL2hGUUE2RGdrSnNHbis1dnVSZXEyMndYeXhkaGxVWXdkRkNOZy9pOXpt?=
 =?utf-8?B?enBjZlVlY1k5K3hleHYrWVJJd2h0QkxwOVlTUHlBYmFhOTlPZkNDOUJUdWlm?=
 =?utf-8?B?dmNUTlhoQVlPSjhLb2hTZlZaYTQ2Vzk5RHZucVNKLzk0bjRZRnd5dTJzK3ZP?=
 =?utf-8?B?WTI2U3UvcFgyRHVXd1dKdW5iS1IwR2pUTGF4MERYRzZrMEFNZ2Z3VGVsTHN0?=
 =?utf-8?B?bFM0NUlzRkF3L0JqeGVJeVJYaGowTXV6WlZTL0pLTUpzZkRwQ05oWjVUY3hu?=
 =?utf-8?B?Y3dORGJveVlsQ3JqT2xDTjVVRExCanUvZE90OWh6dTZpK0xsS282ODJmcnBD?=
 =?utf-8?B?aFh5T3plNkFEWlBJYm9HSldraHU3SFhZRTlIY25LQkdxSGF2dDlHN01XYm1i?=
 =?utf-8?B?dEcyaXhGdHdibFkybS9Sd0dTc01OQ1p1MklIMXNla2d6eVlXM3p6V1JCWk13?=
 =?utf-8?B?aU0zVzBnU2JGS25rMFI0QlJScndmUUxUWDRpcXlRWnlnZ3VqcDZzc2hab2Fj?=
 =?utf-8?B?Z2ZSUlBIVGhYWFRrNEtmalh5MkFvZUd6ZUxzNjZ1TjR6cHdEempwOVA2T1Nl?=
 =?utf-8?B?U1JoZlZ6Q1BNVlBEZEw3TGRHSHF3UFNISERjYjJIMWp5ajhqdy9yTm9MT0RO?=
 =?utf-8?B?Y0V3c1djb0x4R3JyYzRHV2VxNXRXMkpWYzVqcXRoekxLKzNRSWlKR080K2ww?=
 =?utf-8?B?b1l5dFN1V05wZFlURjZMTEZYelI0T2QrRjQ1S1U0Wk1nT3dPWFZqemMyb3lY?=
 =?utf-8?B?S2xUWlhLQ2tkck1wUjB0a2ljNUI2c0ZxRE1oSlEyNGJiZkpDWTMrYlNTajlj?=
 =?utf-8?B?ell0aS9SM2hTWk42V3lTYkk1cWNuejJVTDJDWGo5NlVLcjVFVWd5RWl3RFVC?=
 =?utf-8?B?K1NGSVowWitUKzRNQU43OHBoV1ZWOTI3UnVvWlFtSDNKTVlvTjRzaksvdU5Y?=
 =?utf-8?B?Zk5meS9rZHFoWEdldXlpL3haSnBuVHZlMmZRQkV1VUhGZlNnd0l6VENyd2F4?=
 =?utf-8?B?cUs3VlF1bHI2NlYrWEwwK3dRbmRWdEVUYUF4cnJ6cGZoQ20rSW9LMVlCNVh1?=
 =?utf-8?B?bERja3NmaDVyNVJNTEFrMzRxSmI0Z3lUbTNNSTlwdE96bThZZ1FoVFQ2TGxB?=
 =?utf-8?B?c24vZ1FDcHlVbGJKLzhvR0RPT29EbWM5bHR1Z3hrY1pJVVJWVjlYdFJya2Ur?=
 =?utf-8?B?SEtUN2RRbnlWTVQwRHEzNGZMUFVGdTIwNUtBQmgwQ2xhOUhsUVUxMGxJZnRR?=
 =?utf-8?B?UThJcW5aS0F3MWs2ZmhwbEUxZTB4YUhxYlp1UFJoRzRDenBHTUFzVmwzVURP?=
 =?utf-8?B?RmdyZU9oc0NqWlBJU3pLKzhXRUNjYkpIM0ZwT0dENmNWdzBuUVRDZXBrRkd1?=
 =?utf-8?B?b0tEVDdrK1lRNlZDZkM5ajk0c05nNTRMOEMxNS9nbnJZOGlLQVFGL3hZeHR4?=
 =?utf-8?B?S2dOZFVHVis5L3poVzJobWx4WWpqUmRMdUJwSkNIWGxPaDJpRjZ3aGpmeFFz?=
 =?utf-8?B?V3hORkRJUXRLN0RTWlFmejhZaDNxWHA0SEJQbWNDeCs1YjRWcnBITVZjNXhu?=
 =?utf-8?B?WXFsenVvVHBlOTdNRTFNK2J6SHJSUkNDN0dGTFFPNkQ5UENQYmgwa0NOSVhD?=
 =?utf-8?B?aUZBcXE4T2lUMXBWOXV2LzZYZ2kxYWordzZZRkNSMmJYTlNsZkFoekYzU0Jv?=
 =?utf-8?B?dXR0dlh3cWJRM2xkaWxGWDJrajllcUZwZHFHZEROSnZDa3F5TXZIUlVaOC8r?=
 =?utf-8?B?bm1NVHN3NWFtTkx3KzNldlh1L3JqUjhmMmJUL1NmN0xJRnRreC9BR1lNdDJs?=
 =?utf-8?B?K3QrRm5OWDZaWWxQMlNDcVNUcEE4enM4TEtYb3lMVXdPc3lXNnpoODJIZHFr?=
 =?utf-8?B?SllLeS9nTjZZd2M4cU5mbms3SVQyNWZ1WUNWQjVjRDF2cnVpQmY1SzgyMTln?=
 =?utf-8?B?R1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3UJQBToBMJj9hcy1XJ+Sx6/yMlYxdy4eOWG2qR6zxR0QwzdaFAu+YugOR2MH+0rZryOorayHPn6kvQagsExC5IOog5FtzH8GarLxImh6+WCNq1LaDPWP+MB+Wf84L66WrD2k2fEehr38/CdD51IKiM0jHbddwBlKT8fKprz15cFyoAuZ9SkktVcQQx0311X1Nt5qy9U7++7CtQrV8/I+ocFsN5wjP9Yp6DmSkAKkqO+Hsw2fJTwxFxSbiVyWxGghXTkhg8Mj0aHKn3teOdqF9tYn0kYQPfXutC5yiMO9L6c3sz9ILcr4yEBCxYBwq0hUHOwT1qv9C+pw203uCqmzc5PGKoTI0hSomOEAnH121zN7CGSukpAvA5C1m2zwNN5hZDht/No5yh51MvusIgRXOKaH9+FuHHbA06i3QLTh45tC9AkOcZgX7yQDCWpUYAKgtsgcUeZMsK9mYJFxECRun7DxF1tg5knVS/yAylbvM0gBdhI8OpF9g77ecLCYb+wxiJYzL+goEhaUPbWWb33iI/e2255+WAztbaKRjaYMymQ2bT64ynA0IKRcV4/JtankZFn98fPhoLQadxQIKYvWmYGeUTSNXu6Dd5bAvAR3xIU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41e04d41-d703-4207-43f9-08dd7c457bfb
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 17:46:43.3289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vnWLMn2KjNVbDTBmF+TAm90yDwa4k6U36sRjOf9C0nyq/uFaZ8t3t4XSfeJJqMnTRNgY+obr3hE64D/MxEelSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4951
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-15_07,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504150124
X-Proofpoint-GUID: NjwNS0_PVnIR9Zxo-vom9jb3Semv2oAm
X-Proofpoint-ORIG-GUID: NjwNS0_PVnIR9Zxo-vom9jb3Semv2oAm

On 15/04/2025 18:34, Darrick J. Wong wrote:
>> +	/*
>> +	 * Spanning multiple extents would mean that multiple BIOs would be
>> +	 * issued, and so would lose atomicity required for REQ_ATOMIC-based
>> +	 * atomics.
>> +	 */
>> +	if (!imap_spans_range(imap, offset_fsb, end_fsb))
>> +		return false;
>> +
>> +	/*
>> +	 * The ->iomap_begin caller should ensure this, but check anyway.
>> +	 */
>> +	if (len > xfs_inode_buftarg(ip)->bt_bdev_awu_max)
>> +		return false;
> This needs to check len against bt_bdev_awu_min so that we don't submit
> too-short atomic writes to the hardware. 

Right, let me check this.

I think that we should only support sane HW which can write 1x FS block 
or more.

> Let's say that the hardware
> minimum is 32k and the fsblock size is 4k.  XFS can perform an out of
> place write for 4k-16k writes, but right now we'll just throw invalid
> commands at the bdev, and it'll return EINVAL.
> 
> /me wonders if statx should grow a atomic_write_unit_min_opt field
> too, unless everyone in block layer land is convinced that awu_min will
> always match lbasize?  (I probably missed that conversation)

Nothing states that it should (match lbasize), but again HW which can 
only write >1 FS block is something which I don't want to support (yet).

Thanks,
John


