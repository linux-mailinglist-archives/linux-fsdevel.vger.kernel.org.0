Return-Path: <linux-fsdevel+bounces-36575-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D609E6061
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2024 23:17:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18D6E283B57
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2024 22:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7739C1C3C1F;
	Thu,  5 Dec 2024 22:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="isOFeQeb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GRsZDxoQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD635028C
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Dec 2024 22:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733437041; cv=fail; b=Eb5+14pZuPL/dwYNcqZIG2IoQdpgb0qM5JDVIP/T+gvCr81Ixui8EOu/LnwQj0gTuAmUzRe+6rQBC0Al3svg4kTh+nB6e/DNuX23tJ9VP9ebbX00FYTqtEK7YdsPmJCvwHRC4S0q8rSqfXD3YDLaC7yCN3QqRPnCacq3FCx7as4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733437041; c=relaxed/simple;
	bh=32beyVqhVItXz4NKDtSYOyRA1DLi7j+IdNvlk5K9JkA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cF0yBdN1MXmxqv4tQQ9wy1n8o93TNaKLRy/EIlTB7xR6dfRtIMPGU/S9p2OzrxCQB8zCwODPG5rzhp80U7p9786ldylk01ohKgu3X1muPHSyGGNt9ZkZGAQ/sFaxMcIEJl0fF6/Qi965NRdBhXJLKp6wr14Ht2KjVAWg0uxHkR0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=isOFeQeb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GRsZDxoQ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B5LNYdA025095;
	Thu, 5 Dec 2024 22:16:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=bUVfSdkWbzHYdNIPQQXo2dBC4iLFVvK/az3sfSsflpI=; b=
	isOFeQebW22mLBGw/ZU1QzwdEFOd1zE/3Ll1MU8L27szI2IicbaKlYxxbGTVwalS
	k4FoT1v5sxC8cRWzryADJW3i2A+LWKrpHUv9zZIN+213SUpEkYeU2QcPbxRfZ3Ld
	B/FBOFfTjJ1sjjFZcT/gAIlSBmKQQPllNg654UfgpeYyf0NAC+YSOCwBfIShhMjO
	6Rk0awvYeXub0NwyxegqFdENo4anN6cG1WFMLHh3ZUKp+Euh3l2Qs5Wv8QbJmnvx
	OJNIn4Spu0MyKcguJh0BJOttIpluPgfTN4puKymc/IS4AktH69KLAYSJocdz35z2
	zK+xq7Tq6VOo2NjMEaRtYg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 437smamck5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Dec 2024 22:16:57 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B5ME60X001355;
	Thu, 5 Dec 2024 22:16:56 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2048.outbound.protection.outlook.com [104.47.58.48])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 437s5bh54p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Dec 2024 22:16:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ouj8KAU/kw/BdqaCvHqFT8LbtqznRXyx/lnYwhW19TioPrcw1s4lTk1jvXD8UVNDBhm1Fzl4MBjqm6rV4G/FHXfbFMU4bZYSGYDyHDLL45Pg22BGRwGSwvPwv2RejNpCA53oFAQYs/LkzGwgNltHxbzImvIoTTip9K9Am6eB/jBi/m4C5W/Q24Yz25/ZrS3ejRZRV2mjGYn83SQ5MaECHznDta28rllNXgeqzvEOJpKo3RJkB/HCGs4G8hYn4KwmWRuhejrP4UvITnKtpfi4f/XXBAHYi7HzPWTHVLyDkG2YNzpYs1GDyAyHQkCohtcr6SgYQeukXVfq9p/+KYyyrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bUVfSdkWbzHYdNIPQQXo2dBC4iLFVvK/az3sfSsflpI=;
 b=MbwPkjGTQTEXdUN61i5Iooo5Ucs9d7SPqvmJu6MmynZmPhbQefFXptF9KvckcX/fdu3BJrxYNgg98+d+RTzmX6jVmjB5FuIq/wabZ7FC7ZjwK2VfpbiGxN1m5hdk8wtN2CyZwAKt6X0yCLs6FF6IvH/mq7zkyBHi5PQQQ4YDdJbsDcKgaHE8RnV9mpbDqjDALWgPLLjibM8n3N7RLQnlOzlqvGoerOA9/q4f8zDoxlaAu2J3S2saaJAgcrHX5RuvHaAM664FOCT/f3cVnC5etyKC9tRXg8Ibyp8cyr8uZq092RurhT8vluyFyYr3CqWjPb+uZDFXey40rgm28RSWpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bUVfSdkWbzHYdNIPQQXo2dBC4iLFVvK/az3sfSsflpI=;
 b=GRsZDxoQ3Kp2LW9XpfhfMTk8M+mfWKMifqEVMwwdBOajdI71vrzNVaom8pJoCzlKqvGePpYVB7Q6xW2jhbUwVERuftv3YBE95k6QDLqw0zEDXG6hduurAJ4/xypWeWSuk6oXTCLgHsQJ8As3VupJhVtmwxeVtuWQAlwErgMMuFk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ2PR10MB7671.namprd10.prod.outlook.com (2603:10b6:a03:547::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Thu, 5 Dec
 2024 22:16:47 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%7]) with mapi id 15.20.8230.010; Thu, 5 Dec 2024
 22:16:47 +0000
Message-ID: <ece94ca6-07a3-41ca-85cb-a24b539b58d8@oracle.com>
Date: Thu, 5 Dec 2024 17:16:45 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/5] Improve simple directory offset wrap behavior
To: cel@kernel.org, Hugh Dickens <hughd@google.com>,
        Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, yukuai3@huawei.com,
        yangerkun@huaweicloud.com
References: <20241204155257.1110338-1-cel@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20241204155257.1110338-1-cel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5P222CA0004.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:610:1ee::8) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SJ2PR10MB7671:EE_
X-MS-Office365-Filtering-Correlation-Id: 97942cd5-f96f-4558-6b8f-08dd157a824f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Zi90cG4vNUZSNXdobHJBNUdjY1ViTkhyN1dLT0FXU1FkbkI2R2RMSmd5aGJK?=
 =?utf-8?B?YSt1Z1pEbnNaaDl0VlZZcDd5bkh5TzZXdXd2SVViVTNOdEUxVVVHQjZ3WmhB?=
 =?utf-8?B?NndiUzVXTGlzSjBHNnF2eTdqWFVnaFlWNEJSQ1BsUmU4bWk4ZFE2dzFrTm1Q?=
 =?utf-8?B?VWJmZm1IV3dZWWlCRjM5UE94T1I0WjdneFV1L3BjNjlsNlFzRWpTZUh0dlJh?=
 =?utf-8?B?QjU4dFUzbmRsYnBGOXZKMCtXUnh2dFhodVorNjl6Qngxc0psejdwV2x4c2Jl?=
 =?utf-8?B?Z1pDanZvdDQ2OGVvOHFSS1FKVlMxdjJQdGkzL2VuOEgxRXRyMjFGSk1GNXlz?=
 =?utf-8?B?dHhnSHIrUmZ1L3ZpbExadDZBZUVPMDVvQ0ZwK2JjbGJWWnJWSEY4YXp5NDdI?=
 =?utf-8?B?d1pDeSt5bmlSU2JXeVR4eHl0SWg5M2JYT3JvOUJjMGRUaG83T2hDVDV0dU5i?=
 =?utf-8?B?R3IrZkRwTWtTZ2YxcXZ5bUFFQzlsQUhUNWJzWmI1VURmQkVSaDRuaG9ieldt?=
 =?utf-8?B?a2dsTWFGa2I4aXpNS0p0bkxMOGZZQllZc2lNOHdVam1ydnA2NmszRFNnZlVP?=
 =?utf-8?B?Y2VqRkFaVFRLME5ab3lBRmh1VW1VQUNjYmFMUFdZSjNmTUpTOTBiMGpieFkr?=
 =?utf-8?B?Z3FyNzVHTm9pblpVNlBNaTZKT05SREdaTjFmamNORWRyaE1OcVZ5RTZEUjBj?=
 =?utf-8?B?NUFnTkRkZU54RzFtaEU4QVhzZ2RIcmF5SVQwRTBIY3FuLzlFcDRPRE9vWXlv?=
 =?utf-8?B?Q3BXNFY1WXZIYjN0WHNlK21EMGlvUmQ0VExGUWwrY3RMYXFwaS9yU2REZXQr?=
 =?utf-8?B?LzZLODl2Q3djMEI3a29QcFVRNHVFWWU3UlNPY3dFMjQ3UDlEVGtuRmc5Rk5R?=
 =?utf-8?B?d3dFT0Vmd1pDMnRXR3NvWnVDM2Fpa0RUQW9BMmdITDRtcEhseXVUZHpqeVpu?=
 =?utf-8?B?VUpSZk9VTGZuNzRPQzAvczJDSFdUSVlERW5tWDdqUlRlc0FpQlo2ajFLWW5P?=
 =?utf-8?B?czNtU21VUFN1M1ZaaGpFMm1RNlNnMnJieTQxRnBlSExtazlsVFRPWjkyY24y?=
 =?utf-8?B?azU4bm50aWFlZ2RIK2g0WDM1QzFYbS93ZFNiYWdCTmNYaDlSc3p2UTd0Z3Fw?=
 =?utf-8?B?OGpJSENseVQ2T2Q4eWRQTUZNcnV3c2U5Nlh1azNlbGZpcjBGcGNwL1h1U3Vt?=
 =?utf-8?B?YkswTGZzUlFsanJoaEdHZlphdTFaT1dXUWhKdDdtdVowbjBCTmNNcVQzR2NS?=
 =?utf-8?B?d2F5dGlOQ2ovUVlsOUJ1TTFTelFZTVZsQ05NMmovSUVOWHFzNHdySFRmejVS?=
 =?utf-8?B?bzlwNHhpeU9nQTFqdms0bUNIbFljWE5yeCtVTWt3RGtvTDdYaWF5YXRZUlh5?=
 =?utf-8?B?YlBUT1FvZktYT3NZQTYyS2NUSXZ5S1hiNTFXakh3R0FaUThZb0tOSXJJY3E0?=
 =?utf-8?B?RWNvQXhYZ1VlVk9mZEVabFB5ZlhjOHBHVUo0SjR2WEVkZVd5cmxMRHRPWDlK?=
 =?utf-8?B?OE94cGRUa2puUlNtZElMT0tsOEk5OTFqcW1BMXRrR3NpbHpycXlqbkUxZkQ1?=
 =?utf-8?B?bTJLMUI5dDN1T0NOdGRTRURsSTVaUGQrejdTcFJycmRzRWk5TXJWelgwZ3Jy?=
 =?utf-8?B?ZVU3cjRvb0pNRlBRVzVsUlBHcS9sNUNPVGMwc0s1UktRQmlVbjlmUkoyVXR0?=
 =?utf-8?B?V0ZBUGVnTWxoZU5OKzNQVDRueUFFRzFtRm9mbWhGTnE5SGxFaHc1VFYxbGpu?=
 =?utf-8?B?aTJqMlY5dHp6LzFnME5qUG04dldwbUtiUWpNb2xwRDdYVmJuS0ordWtqOVF2?=
 =?utf-8?Q?JpyhC2963lQY8qVh0R4HSnpUd6hY8vabt9SOM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U3diWngrMkxQaHlEMHVmRVRHbk95ajdvVWRienpjVEI4b1lPN2U3NnJxcU14?=
 =?utf-8?B?ZzBOSFh3VS84S2xxdTA4UWhDa0NnWkFTWkQzUkVYVmZyNFJNL05KZ1FuUSsz?=
 =?utf-8?B?SExyQzVzYkxWZnpLZ2s3amtNcnM5dWcrRzBqUERCUHZmcm9QdUxycEJYZGpE?=
 =?utf-8?B?OXFUUVZCdkNDMmxHalY3cDZSTW9HL1VmcVcwaDNmbHNqaUQwQWdUZS9CaXkx?=
 =?utf-8?B?LzdXS0ZjRXIxRldiTHZVb2U5Z1dsbUhHNy9qMG9yNHVpeGxROFRwSjloanRD?=
 =?utf-8?B?cURKVHN1THZvR3NKWTlNcm5wd25zRlVpLy9nVW5NWHpJR0pXcHJQVklHZ1RW?=
 =?utf-8?B?RXdRdnZaTkpKVEtxTVFraVBtTkZXOUFxUnpMaTBFTm12Wnl5NGN0UEVpQTRZ?=
 =?utf-8?B?ekZMcy9wY0E0MWNWVUpEeWlIeFA2dk9xcDZQWDJDbkxPeTlrS045TjhzOE01?=
 =?utf-8?B?ZTlqRkdBbzdHQWYvVm02L0ZOTmhsYW9zMXgwS2NSdUJuZG5pcU5Xb2k2Q0cz?=
 =?utf-8?B?VjVhUHJLVTZsNWYzTWFhUGJvQmpNOGM3WFRzQjV1Rjh4TVBHME5QMjF6SjlR?=
 =?utf-8?B?OWlpSjJCU3NyVFRWdnZXU0dLKzd2alR4QkpLSk9mSCs5ZUpXSSt2ZlV5a2xl?=
 =?utf-8?B?MVdCTkljSU5ZOHdvVHJZNlVkN0dyOEFtbUtCa0xBTnpCZ3dRTnp3V0RHc3Bw?=
 =?utf-8?B?WFo3SFExcGNORGtUZmg5c0tnK3M3SzFtT2ErWHB5QWFkRno2RktsSTJnVXZH?=
 =?utf-8?B?eGZCeTkzV2Z4cGpXMzJWRjNXamsyUTdrUmtBYnUxS2huQVpLNXBNTTNvQlFq?=
 =?utf-8?B?WUcvTXVuQVVKMDh6SHZYZmUvSzdweFE5a0Q5MjVlTUdqdk40Z2tRSHNuT0p1?=
 =?utf-8?B?YWs5c2JFaHdDdDJ1QzlHMlYwcWtVYWlXWkIybE9uUmk3RFdNNFZidmxSTGFC?=
 =?utf-8?B?TktvcEFEVW9abHF1VWh0Wklkb1Z3TnljMWE5VDhVUnlhUFdINWdCS2pNeTlu?=
 =?utf-8?B?aXY5VzBXNWVnQjcvNkMwZEN5bmV6RUV5U0ZTRGVuWjYyVmxvajNJaFJ3WWZz?=
 =?utf-8?B?cExZTWYzbktJZ0xpU0kzTkVwUkZTbDljbmxpQVAyS01jUytnc1UySXFUNHRa?=
 =?utf-8?B?K0d1cXBrRGVPM1ltUjZKQkpRRmpYY1VsS0hNSlBDMjJ3YVlVSlFTOFpMZkty?=
 =?utf-8?B?Skh3NFBWUnB5cVhNcVlHZGduV3NrcDZ4TWYxRGVWMDAzVm5VNXRHNW5uVFpP?=
 =?utf-8?B?UnIzNXVyZ05mMVozSGdjOHloTU1MRnVuTjBBanNtQW1ESDhIL0wvTVBjMmJT?=
 =?utf-8?B?QzBUeW15QXlxTkNoaUNEOG1OSU1DNWpLaXBuRml0OVFJSlZROW1hb0FOS2ox?=
 =?utf-8?B?UGxObkQzL2tXRytpeXdWUlNFMmdMVE9lYXFDRklzS0VjVWxGdStmL3oySmFj?=
 =?utf-8?B?ZVBUUWVWK2trK0JzUEk3N1AxbElUVVFJdHVyemFEalBaY1pWUzQyMEdDL0My?=
 =?utf-8?B?VkQ2dkxpTlpqNXlJSnF0N1MzNW5kWnJRQ251cTEyT2JZeWVEZ1J0Q2hXcW5S?=
 =?utf-8?B?blBiOXZQOGk3dG1BdGVWMmdCQXFXbUl6c3JLbnRMNW5mYjhsQ0RCQ1pGVENL?=
 =?utf-8?B?WVd6akZrYTJpdlFrVlZ2NS9TMm5qb1JkQ1krQ2U3NWwvRFBKaldiTEVBcEQ2?=
 =?utf-8?B?STAwQ3oyKzY0VHdPRjlUa3RaMDRSYWthT3NNMUo5V3M5NmhEN1k5cm51a0JP?=
 =?utf-8?B?Vzlnd1E1dVlyK3lCd0tEUndrYnNMaEh1anFmM3BuU1oyTzhCbkZDZHM1Y2FD?=
 =?utf-8?B?a3IyaTdPOXFlaWV5TnFMSEF0REhVQ1RrZU1xa2gvL1hDUk1idnQ2bWhuWHdu?=
 =?utf-8?B?Y3UxODNDcWVOcytoaVp1akJzSEkxL1I4RVNJZmNUY1lGYTh3aHdwd2d3c0x1?=
 =?utf-8?B?cDZGTHZQVWlxWnJuUXlGdllrcnpCdlVTYjd1QkQ2a0xwNUlGNUEwMm10WVN0?=
 =?utf-8?B?S0hpWUdpVlpWa1V1Uy9iZVFhMjkrZW8ya01iUnBoenFxYVBzR05HOUYxWUpt?=
 =?utf-8?B?OTJXUWVlY0ltMVpYbURDb0dydVNPQ1p5R3N1azBEWDhySmhHTTZ0Z0hGR2xG?=
 =?utf-8?Q?KL4Pii7RXXfIPQFIUvqZQ1Js+?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	a8jy5E3RztbcsGZULkyo5kIRevkX8t6d+3V/dO5zS/Lo5QSNGEA/SD5lOiadm6ylr3M3F0SsxQPNiftw5NyMkkQCRzjjuVrWggNAhima86N763FPwOfSTqdf1vkG6WJPT+7vmbPlnci22bbizfWnC62z/il1iUCQuxafyugfu+MFiffE5olzqNc+IWVhlRu3mOPCfgpxCAbGf0xa0a1KD0/hUsSWExO5v/3ID5riHY3WjXNh6LzYlOElSfMBN3TN0YIklG7NCVrKUUQLeeDRIkSuRooCLPC1DRwYHwzV6hSkyQFKqbflPOiSUAJh8bNClGOpwRITv9oTNWv4cKCJ01VU213NWl4dCwZ3GjnXAwGTAMjus6kRjo7v6H3wLE3f2f5Gw1Oq6JRqT4dR1zzaJMaqXyRh5xZfRT7MjrGagCOP8TDEopVIW1ZPkKNxjjc0GOsHOoczbf0X4RJgzDO5aGOy3e8DiQQjuPVqx1qcMaJoJODFk12MDJsbUjm12kYiuARYTXGGSTZhvgZDDBMuPvB8pfmwJKgq4TLl6ftkY/udV83dKx+s2IjKw1IxhjsD+YhbjFflBShSrmccEOhv/IjUAzgLPhOuNcZk7y/muRs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97942cd5-f96f-4558-6b8f-08dd157a824f
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 22:16:47.4100
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WBK6NMzRZ9HTFbJgyiiBRc2VsZgGJAXRnL3yB+cNKQRp/kxNxlw4AsMwGedX5ne6TVvXlpxVOxHvEbhQmG8AAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7671
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-05_16,2024-12-05_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 bulkscore=0 phishscore=0 malwarescore=0 mlxscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412050165
X-Proofpoint-ORIG-GUID: N0tjykT6ebWUXz24GMUTaltQvTI0oGAM
X-Proofpoint-GUID: N0tjykT6ebWUXz24GMUTaltQvTI0oGAM

On 12/4/24 10:52 AM, cel@kernel.org wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> The purpose of this series is to construct a set of upstream fixes
> that can be backported to v6.6 to address CVE-2024-46701.
> 
> My original plan was to add a cursor dentry. However, I've found a
> solution that does not need one. In fact, most or all of the
> reported issues are gone with 4/5. Thus I'm not sure 5/5 is
> necessary, but it seems like a robust improvement.
> 
> Changes since v3:
> - Series is no longer RFC
> - Series passes xfstests locally and via NFS export
> - Patch 2/5 was replaced; it now removes simple_offset_empty()
> - 4/5 and 5/5 were rewritten based on test results
> - Patch descriptions have been clarified
> 
> This series (still against v6.12) has been pushed to:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/log/?h=tmpfs-fixes
> 
> Next step is to try backporting these to v6.6 to see if anything
> else is needed.
> 
> Chuck Lever (5):
>    libfs: Return ENOSPC when the directory offset range is exhausted
>    Revert "libfs: Add simple_offset_empty()"
>    Revert "libfs: fix infinite directory reads for offset dir"
>    libfs: Replace simple_offset end-of-directory detection
>    libfs: Use d_children list to iterate simple_offset directories
> 
>   fs/libfs.c         | 158 ++++++++++++++++++++++-----------------------
>   include/linux/fs.h |   1 -
>   mm/shmem.c         |   4 +-
>   3 files changed, 81 insertions(+), 82 deletions(-)
> 

I've backported these, as a proof of concept, to origin/linux-6.6.y. You
can find that here:

https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/log/?h=nfsd-6.6.y

This series passes xfstests, including generic/736.

It would be a little cleaner if I could also backport da549bdd15c2
("dentry: switch the lists of children to hlist"), but that has similar
risks as backporting the Maple tree patches.


-- 
Chuck Lever

