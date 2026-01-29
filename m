Return-Path: <linux-fsdevel+bounces-75859-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yNHhHyFoe2lEEgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75859-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 15:01:05 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F1FC1B0A7B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 15:01:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C5E53302351E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 14:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6DC37417B;
	Thu, 29 Jan 2026 14:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZQb4eZR5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="z69bcQlO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E0C19CCF5;
	Thu, 29 Jan 2026 14:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769695251; cv=fail; b=dHINHia8qExGOjeViyq8StZLEI3SeMoo7ntZG5QGka5PBKFu/iNHOQHsyn4IaGGk35Zyj+DypTa77F7o68DK8UWaZhz/LwbLAjLPCehjPCZx42NmG1McCuu9I0MD4FnQ30HuZEyOycig5izweMEmx+lg100PEgq4z8NQKGsCmjo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769695251; c=relaxed/simple;
	bh=RBufz2LwHGu2xv4q5bUHNvqsrfXHmuQTxyTrnFpcrgg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HV6yE4JfmkpyWNdBP9pfx/79S2tMuPfrirvTVouaGCRb7oxrOxQawD2Ld+UQ8k+/PWVWNTchinXk2DWiRd1d/rINBzal0mdE8wF5+xEY5hsR0P1UjxUXUArSavS5hswald0RyHmjWAi5Ve6BL5PBEVDbG74t8CYnfQpz9/en1OE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZQb4eZR5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=z69bcQlO; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60TDgFTR448870;
	Thu, 29 Jan 2026 14:00:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=8gz5YY/4y23QoNLAk9vEVPBcxycxafi3j6m4EZQ4uv0=; b=
	ZQb4eZR5ZHTTBVWvrJNcoq6RHLmfwdeLiNdlG7E180THUe7Byi6Hz7TnO1MmuB1P
	BprvLnWcLGnbzCRV+IODs82SEDc4Gw/lw9b6Pg3NM3NzQN8HUmffVQqsAAKTTngi
	mpUbdaTpTqFrryXWoIpK7X217/GNRaieV7niyUaUVJg6/8Vs+t/k+ji997rRfTsp
	PSV9clzDxKR71zma56Hhjpgijs4Ns4km98uwx2D92OtIyFdupndlKfOh0HkkVOz7
	zWG8q4n5UbzSt/C2MGjfZyHrKANdSumQX+4kyRPXGrhGupgsWAPeXjPsEhealS7q
	aqAJxSyf3V3DTGEM0+WaRw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bxx09kxyd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Jan 2026 14:00:36 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60TCoSMo019779;
	Thu, 29 Jan 2026 14:00:35 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011041.outbound.protection.outlook.com [40.107.208.41])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4bvmhhnrcm-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Jan 2026 14:00:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JksiSNhialzXL6Cgzxb2SPhABN35M/hWQ4tjSU0foUzbnwN9BSnftKlp9zDMPo2yc0z8as1gvuoF9BeBlizspcgguNfUXa/hsRkVgqTiOpIopHXTNlchI+Yt/InB5irtvPrN9QVHMElT/MrL4kdtZvCRN0rQgmbwhptscQBCI0AybfFRRa4y0CHLNH2FOD668/dakpTnEQkL2oa1cL53AZV6TnTW6nyn6H22XJtPbzULA+VoeqczLo54vMeYxp1a4mC2lK7OgV7alhbNrmEptjeq7aZb+IhZx/pk0PHzGmHkMSL/TvjYN5WBLxMNVr05TDPD7wgyvB6KwrOFBys0YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8gz5YY/4y23QoNLAk9vEVPBcxycxafi3j6m4EZQ4uv0=;
 b=DG5YvQYPXnFovcf9j1cw0D6RMrvfMbvIX8xO3yNBjbxR1hV8/fn2RQkzaPL0CnyZo1jhkPewR0oOSn+zZkkZvPwCleF+0sTRm3BqfLCYw34MyFnor5P8aUK/Y3APStfIu7pAtzliX88h3wwGRi7dek9rH50Iot4t0BepDUI40B74zxp+In/OxIHECf5mOdcE1UQ+7bPgUdR4ywH6FzUEU69+qeUykIvFZzmMfARfhe/9LliivA41LvAzYfomNcJBiXXrcKa/uTCyyP+lELzflAbJkIw5LIKS6NT0GzYNhHYo1X99lxWC6qfZ+sy6NKHnoshKMx2X3HFJRLkPsNGLZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8gz5YY/4y23QoNLAk9vEVPBcxycxafi3j6m4EZQ4uv0=;
 b=z69bcQlO4Pf8lsRc/v3iNHPBSMGiLDz1sjiYzxcP7ieqyHGd2q9lw/ADhnxxcwDVcVTRQGfvzzz3I/kLDSsE8whE8u4WlMuwCr3tjTzvl52Cxem1W3LJjO5BBCS1+xVE6nSZwQEr4DCx5ixnoi3lpFaQOjurFj49yOFrMvA9vJA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MN2PR10MB4221.namprd10.prod.outlook.com (2603:10b6:208:1d7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.10; Thu, 29 Jan
 2026 14:00:31 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::4083:91ab:47a4:f244]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::4083:91ab:47a4:f244%4]) with mapi id 15.20.9520.010; Thu, 29 Jan 2026
 14:00:31 +0000
Message-ID: <3564cc91-9d19-468c-99de-06eb5d29523b@oracle.com>
Date: Thu, 29 Jan 2026 09:00:16 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] nfsd and special kernel filesystems
To: Amir Goldstein <amir73il@gmail.com>,
        Christian Brauner <brauner@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Neil Brown <neil@brown.name>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
References: <20260129100212.49727-1-amir73il@gmail.com>
From: Chuck Lever <chuck.lever@oracle.com>
Content-Language: en-US
In-Reply-To: <20260129100212.49727-1-amir73il@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0248.namprd03.prod.outlook.com
 (2603:10b6:610:e5::13) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|MN2PR10MB4221:EE_
X-MS-Office365-Filtering-Correlation-Id: 629b89a4-4ffe-4096-30f1-08de5f3ec3fe
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?TmR0djJMRjE1R1FtK1p0SHE1NktyeW1sRWdFSWlZVFIzcWwwY0RRN08wM29I?=
 =?utf-8?B?b0lhVHR2STliaUZPMTYrQ3FRRklmc2FLNHpmTzJtWk5GNDY5VGs3Z2Rkakhz?=
 =?utf-8?B?WW1FdFJyRXhyOHBzSmpZbWY3S3JhVnZwS2I1RmhMSnlMMUZEaDlUcTNNcENT?=
 =?utf-8?B?VHh5bGdtTExHSG9MR2Fzd0dkUEFyNDZ6MEpHWWROL2V3aDYxanJLZUFIZFcv?=
 =?utf-8?B?a0NjQTk4Zi9Pdm1FM1lzZ0srQnRLQ09MdDVWYXdTUnZ1cUR0NGdMcmIzYUxC?=
 =?utf-8?B?SkV3R2VIb0I3Tk1RcmJpWnBtWWVtckR0alZGNGEzV25kdDFPUFlqUzU4N09n?=
 =?utf-8?B?UVVsTjRBd1JSTWxqMkpaVFlONGFyUmZlcFp6N2QrbTJpN29VWUIxUnB2dXZG?=
 =?utf-8?B?cUxjV0sxclE2L1ZQTlVzRUxFTXlvYWkvWkROWTh4d0ZLMFdySGVROFlEaDA4?=
 =?utf-8?B?eG5SOEhLTHF3dFhienRodG9PYWJKNm5lUU9GYTNBWUNWYlVyTWJDNVkyMFRL?=
 =?utf-8?B?aGJ6cXptWUxnd2x6LzB0THM5T1ZJelV2aXJqWFNnQUtRUUlFNVNmQllZd1R6?=
 =?utf-8?B?WUNYYzBOYXJoWk5ocEJpTFVUWUdtU1BtanBDdzdEUFg3YlhHYmJ4T3lJeUw0?=
 =?utf-8?B?VG90VzhLU0NKMmZud0VwSis0ZFJqNWlLWmRXdHNvaTViNTN6amFwME5WNTA1?=
 =?utf-8?B?Z0V6R3N0M3U1clgyRndqL3liTW91RVR6OWo0UGVLR3ZmYW1JRVZVTkRqbmR2?=
 =?utf-8?B?NG14UU8vWGFKVUtBak5BbHdCRGtjZUd1bzRhcWgyQmlSNUw3dFpqb1p3cjNn?=
 =?utf-8?B?ajdZckFQTWhDVHYwUDZYZklnSmtJYWlHODE1ZWRBV2JuSjVBRGNnSXEvNk4x?=
 =?utf-8?B?MGVoNzJuVERrNkoyOXlWVjUwK3F1QVlOaVNIcjNyMHI1bjFzTE9rRTZFVTgz?=
 =?utf-8?B?emJ3ZWJZSk9vbFlyb1NsOEV3Uk44Y0U0aEQxWDV6eE1TNVVpaVkvV2dlTmhP?=
 =?utf-8?B?T3VacTFHZUdCRXdqb2dWSjFsY0tXTnZ0dS9ZNHJETXFTVm42OWJ2REhxSGhs?=
 =?utf-8?B?dzkwNXhEN1BCUjU3TTBiTlR5RjRIRnVrVVdmOEFVVXh5b2JGN1hLYkNlRzRz?=
 =?utf-8?B?UDZqTnczdDgvbWdPRmlGVGs5aU5iQm96REJEQXBkcGxLdjl2eVFINlhrUjlu?=
 =?utf-8?B?Q1pLakxhMkVDc05RZTRQNzI3eEdUNU9uVGdveWlxRjhOR25vOXMxTUVkeGtq?=
 =?utf-8?B?STBaTUgweEh2VkxCdVdaTTN0WVp6ZEVpSnNKWm5CcGZmVnkrYmxnbGFCMk9U?=
 =?utf-8?B?YkcxVGJHY0Z2TFVTLzlOZnJKZzBkYUFJWnFsaXNzdWhoL2FmeW1JM0lDSXRI?=
 =?utf-8?B?NlBVYlV3YXVQME1WSnpwTm5ZUTNOTDgxdHF0OTZoL2V2UFBYUHdKV0JodjlM?=
 =?utf-8?B?NXdIcGtCaXluQTNyM0hpS2JvTld6M1pPRVZRSGZiWnVHaXcyanF2NHRwUDQx?=
 =?utf-8?B?R1JzakJqSHg2MGFXNW10YTJjaG1NOW82OExLdHZZa2o3ZHFDMzkwZk9YQVhk?=
 =?utf-8?B?MGRFVDdyTTR2SGZmejJtaGJWWXZ6bWJkYTBPbEllNUJWVWRUeTc1KzRqQjBt?=
 =?utf-8?B?ZXJWQ09CZ2NCS0crd3NYUTY4eVdiczRTdDJuWGhTWkpZWGxIZXBGV0o5Q2NF?=
 =?utf-8?B?Zko0d2tsaHZtaTZPWmR5UTFFd1RGalF6azdZQzN2V214RHJoeGd6c3AwaGxF?=
 =?utf-8?B?NklaYy9PSTlTQTloNU1tVFozS2tDeGg3N2gvRXRTTDg2SUFQNkczemhzNm00?=
 =?utf-8?B?Sm11aEJERXBVdEdUcWxaUGh5LzFtOTF3Qk9rZVU1cU5KZHVrTkErSGpLQjdR?=
 =?utf-8?B?MTBFLzVlamJZSHVwM0U5RWlkbGxVN1QyTEw2eGNSNWQ2b1dDTllmWk90MjZp?=
 =?utf-8?B?ZllPS0Y0ZE9PRjcwV0lLRUwwbVptbkRYbnd0Y1hMWC9GeHRRdW0rcHNSdFha?=
 =?utf-8?B?NmtIOEdxT1hnb0t1d0RDQnpUc3VQYVRhZzlFQVNBT0dOZXpsZDRzWGk0WjEy?=
 =?utf-8?B?VXNRVE85OWtPN3hxRVg5c0VHdEpUK21aS0V5VWU3NHBDaXFmVXR6LzUxcFBy?=
 =?utf-8?Q?DqZU=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?cE0yWmZFS0w5MDQwbDJOcnhicUF4TUdSY3J3dmtWRXZhQ2F6RGdjZDJJL0Fj?=
 =?utf-8?B?bnhiRzBJT1d2WmMyNUpDZjRrM2NXNUViL1U3RUprS0VLQlRQaWdDWDJHdUgz?=
 =?utf-8?B?bWdld1dmN1FvNGNPSmRoaURFLzNmaHQvc3lvdjA2WnZrZ2FyaFdVNkRvVjEy?=
 =?utf-8?B?VHh2aDZWSDg3a1N6R1VhS25hV2J5TVVUMEdHZElnMGtjZ3pmN0tsdXhZM3pw?=
 =?utf-8?B?MFd6eGtmYlEvS3hvVmhIR3NnT1AwOHQ0Sk16UmtDS0trVWVMR3N3ZTFqTGlk?=
 =?utf-8?B?ZkV0VUxxK3VoR2ZpMXBTa2xQWDhYRVlyb3YzRnYxb3lYaVN0TGM4c1IzaHVt?=
 =?utf-8?B?V3NlT3FSZkJ5OUdYLyt4dXJoNWpWZGErMU5CU0ZPUENBMENXWWVnZFFRZXpL?=
 =?utf-8?B?b0tBK09mK3JvbXVCYXF1VDNiY0Vlc2NoVFdSTVVZdXVrNFFYYXd1WTNFaFFh?=
 =?utf-8?B?a1ArMmV4QVJYUWgvdFloWHN5clZYRTgvT1IwRk0zMW9aMTZicjR2VDk1ZTFk?=
 =?utf-8?B?ZmVjSkpWTlNvWTRiRXYya2pIb1FENEFKSEh5ZWRRbEMzOXBzeHV4TmRRMWU2?=
 =?utf-8?B?UDlrQlJ6NUV1R0RBMFJwczFDNkxhK09ZaGZRR0czTUVSK09aTU1meEh4alZi?=
 =?utf-8?B?YUJ4T0FJZWFQRTU5VWFWRngxTHc4TUFzRUpCRzdRWWZxcEFMTDFFNWg5ZTFt?=
 =?utf-8?B?cDNuQW5reVBTZXFSY09nT1FuNUZyYTdJZHRvbW9xYlYvbTlUZ3dEaW5ISVlz?=
 =?utf-8?B?bUlMV1h1RGkwWVkxejJ0cUNPK1d5V2tkcS8zQWZrQWFKTXduRGgyMFhxdjRa?=
 =?utf-8?B?aVRSU0RwR25UdGhUbEdsOVpRbytXaTFOYWRaN1BHMXdhcGJ1eVdOTHlXc2xw?=
 =?utf-8?B?bXMvS1QwNmlmZWYySFVUaXJYUnJua20zejI4M1AranlhR1JIaGlQN2s0K0Q1?=
 =?utf-8?B?UVM0clNReHJZTDR2cGVhTEpnQko3TEtvbkIxWm9uczA1YllSUjduV2dCY2ZJ?=
 =?utf-8?B?VWg0S1l4NW94UTJTd3lKSnRjSWFRZkkxRnBydFI2dy9mOWlVMm5IT0Y5bDJa?=
 =?utf-8?B?QWpIWkRKbGQzNkxpYUxhVGsvNllheDNhTmhMYTB0c1FCZFU0c1daTHRlVnRh?=
 =?utf-8?B?a29kcEFuaXh1UTF3cFBMb2t4WFlrd0JWK3pwVmZ0MTRXM29HWUxNVUhsNVRQ?=
 =?utf-8?B?SDhtWVlpbk1FWlNyeVV6cW5MNm03OEU5cm84b29id0FLWE00RXhudER3L3p5?=
 =?utf-8?B?bnFOMyt4WHRZZUxYMWZLeHpXeE5EU2RHQzE0bE1Qamw2V1UySC9XWW4vZmVI?=
 =?utf-8?B?NHNOZGx5dTJXeFlHYXdwVWFkRXkvbGR3RHBEVUIwY1lWbWROaWN4WTZvdXBy?=
 =?utf-8?B?dDhmYUU4MzlOYTAxZjFOc2Y4RTN1ZlFFdyttam5vUkZaaDVpeFlQYStzVC90?=
 =?utf-8?B?T2pWaE1WVU82dmRLaUxEc1h5cE13U29jeDJwcFY4cTA0U3lwaU1tTDd3SmFE?=
 =?utf-8?B?UDc1b1NMbitLZ3B5ekpPeWpocHV1UHg0S2xmTWxYeGNheXJFTkNWaSt2UlBz?=
 =?utf-8?B?Tk5pdDY2aDRhMEcxQUJSd29ta0JWYkZUL05TR2o3MmkwVjh2NzJmbGtDcCtO?=
 =?utf-8?B?SDNvaWJOcUtsSHJZQzdDZ0tTR1U2dkVHaDkxZWt0SlpSLzk1RXYwQTRhWG03?=
 =?utf-8?B?SVRMR1BMRjFUMlcrVXM4YmpzS3lxVXc4TktiUStQUjBFQjNjT2RudWM0aVhk?=
 =?utf-8?B?QlpGNk5Ta3NEV0Vta3E5MUVJRFRDN3lZWUo4SFVISTlFRUVnTDF2Qlo0SVBM?=
 =?utf-8?B?Z29KQitjMzlkcnhWa3ZCcDRsNG1NcEhpWUZZSWlVMnRnY0JLZzhSOTZ0eEtP?=
 =?utf-8?B?U0p4cnFLK2lnaDlFQW5MSmltd0JqbXNRUXp4Q1NESVJUUitNNDlGeWtFVEJx?=
 =?utf-8?B?V2Fad0RzNHo2a0FFSnI1SEJVVTdQN3EybWp1c2pXZXI4a0F4S3NFZEh3Nmxr?=
 =?utf-8?B?K2I4eEpGZW4yeENjYU5IcTBYSFlXZ1kzalJpZllDdFBmaHZZSkg4aU0wUlM5?=
 =?utf-8?B?WjV4aGhFSWN1VXZwbzMwQzNzLy8yZnYxbFRwRjZMYjhQWDl1MXhxMVhiR1Va?=
 =?utf-8?B?RXYyUklyRGt5U0FkUkFtSzRiSjFRZ2ZkejRXR3JyM1NkbVRGK0tOQ0JCY1Ex?=
 =?utf-8?B?YlorMnFFUVdxRkgwL2xtS2x6R2FBSjJTdDhXNHA1VC95NkdqeDcxUTNoUHlP?=
 =?utf-8?B?cUhFS05kQ0M1d0hlclFxc3phcmo2K24zQWxNL2FvbUpBTkYzL1pIdk1aeUJZ?=
 =?utf-8?B?NGZXcWx6c1NJaCs4d2RMWHhSYzh1ekErUnVKNHFjUTh0OTRNdFh5dz09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Bu4jcVlrJmr97t3puTta3zeLpLT2rXpwZnTYrk6zeBhTbJEh7+LblLwHffZVufEeBfXDPuIObGJLgGQ2ekuxKkIAFi5fRuqX/CSfxNqskFYdQ/WyUAriO9PW41V2FOIHYJICHQDUdq0XZsdKo0XN/iNkE+ZJnwSx+o6HYfQCBIi3r/iYbLMkWZcerK/gRCU2xGv6DKY2MD4BJt4kWjbbWzFWubmZo8B1SHbxNm61ah3HTJ8TVCu/Oawx45utqlDfzmaVFHkcn0vJRQbV4Y+rOCgxSvCx7TokmkMYvZB65dOjDe+8iIsGjekj45Yr8LEsEFoG9q5AI+/0nPT9q9WcIuN404aOe87IvQZ6ZyH3lLSre0akporhF/klBVBAGs2hmCYSL0ipgT6u4fdEZmtB9q7qys07tbAp5J8QqzF/qTEKWhlUKEjdhmaSOGFxr6UJddN59vELiiexHBp8aj58zeC4jziGXqVchQnnDQE1CwogC/P9SH04EaNawSRre56nmF6jjJfuRfOvuLOGubY4wvdPG6r0dDLo9ws1ykq4DqhnyYSMeneKiAO1XaWEe846oWIjZU7l8hAiZsrEWigfp3GcjD6363C1H4YrXDUSQLY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 629b89a4-4ffe-4096-30f1-08de5f3ec3fe
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 14:00:31.5348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wTcj7ymS0iiF24zSeZDchD3lzjfggVC/7CdIm3iVAMWZ8V6R8UM6tmu54n1CYfqByfFtm8qWp85zq39lMt8IMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4221
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_02,2026-01-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601290095
X-Proofpoint-ORIG-GUID: c1AHGnHmKIbHByG64PcvawshATmGQD4V
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDA5NSBTYWx0ZWRfX2xHXVZJ/Mc4t
 ElIgTfxzptMe3Fnv1HCMtCtyJfyqveO4ltQWi4GNArgR1BEl0q7LFWhLW0p3S350ssfM+H5tZr0
 YsPSdAtaRLgq/3GpKsiaYDyNVDUF8FiYBqf0exD8jFI7ktyWF4eaXBVRCqFiQmg/r+7Rbec31mT
 aJCuEbWJ4sd8DqSlTrMcHLq2gWTbywNRW7W9S+aNYe0sJWqQPQvPSpgtI4i+2TrHVCvn5uR54Nm
 LcKkD/q0zX4Zj4KHRza4xZAP1Gsuyfl+kYUuVA2kB2tWc5D/EBZ+7tlzr4G7l3iYsc81EhKVSY3
 FijoSPIznXIaDleHv1k1flY1f0MCYybWRTrUwwzPwDMjjqU3yLD737aAY0l+tMtH03SC22TtEg8
 aRtG5LhUDkS7v7uNctHYFB4Kk3McCTRuE3lU/YFR9eh61NHotDBJ6PQkagpZzqs4g2Xh19pO3Yq
 Aitr78d356Ja9bdaQ+z9ZKN6ClEyAP4AnubR0ge8=
X-Authority-Analysis: v=2.4 cv=Qe5rf8bv c=1 sm=1 tr=0 ts=697b6805 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=Mpv7J8D6AfeNBrESBwgA:9 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:12103
X-Proofpoint-GUID: c1AHGnHmKIbHByG64PcvawshATmGQD4V
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75859-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email,oracle.com:dkim,oracle.com:mid,oracle.onmicrosoft.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chuck.lever@oracle.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: F1FC1B0A7B
X-Rspamd-Action: no action

On 1/29/26 5:02 AM, Amir Goldstein wrote:
> Christian,
> 
> This v4 addresses Chuck and Jeff's review on v3.
> 
> The first doc patch is applicable to the doc update in vfs-7.0.misc.
> The 2nd fix patch is independent of the doc changes in vfs-7.0.misc,
> so it should be easier to backport.
> 
> Thanks,
> Amir.
> 
> Changes since v3:
> - Fix typo and doc comments from Chunk
> - Add RVB
> 
> Changes since v2:
> - Rebase over vfs-7.0.misc
> - Split to doc/fix patches
> - Remove RVBs
> 
> Amir Goldstein (2):
>   exportfs: clarify the documentation of open()/permission() expotrfs
>     ops
>   nfsd: do not allow exporting of special kernel filesystems
> 
>  fs/nfsd/export.c         |  8 +++++---
>  include/linux/exportfs.h | 21 +++++++++++++++++++--
>  2 files changed, 24 insertions(+), 5 deletions(-)
> 

Reviewed-by: Chuck Lever <chuck.lever@oracle.com>



-- 
Chuck Lever

