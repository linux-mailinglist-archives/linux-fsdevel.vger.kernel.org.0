Return-Path: <linux-fsdevel+bounces-68791-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E9F2C6660F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 23:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 4021D2980D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 22:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D9732E6A2;
	Mon, 17 Nov 2025 22:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Fe9tMb8Z";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CrMn3H7R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDB720C00A;
	Mon, 17 Nov 2025 22:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763416845; cv=fail; b=F0jR6kUWPECKP7wbbhVQG3MvZ8SFiVCCw0QETUpNcWzqZ/kpydYHuwPfW4J0UCcwzGKr68qG1sUra1LzpHMpgfH7N16ftYEtVEiXSq166As+vsAdjStDywNwaieLQgS3wGxG5H0w0j6SxeiZ/1+bOJidOCe0m3Dwg5nJ//uGGIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763416845; c=relaxed/simple;
	bh=2iyn+PX7hRlYJ84059XkeT0Fs5ZAiHq0k7veEJ9XYpg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ew3CvxbNV23DP3MVAgIRoy15dCoxk7VvciCL4c+fBoV+3POJzWC5kuZTeye/X32LMP6HiKJLgX6XxKxBQNysVfRROj44oi78f/h/bPwZJ/rUafwexJAge8zedOOf/Y9YOc/AYzLls9rDBsRlguBPvvJ7aOxJWJVmTNgXwrEbxIE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Fe9tMb8Z; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CrMn3H7R; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AHKtvrS016925;
	Mon, 17 Nov 2025 22:00:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=K6g9fNrTH8J5rusb4MSBWJ3ZrhmeebWBX0ZJ2Orklg0=; b=
	Fe9tMb8ZNxK27FtwAKKp85jqEA5twLs9WcgItK4MDF/SzBkkmRh2OE5Sb6Wl0t8a
	GPMW+pZ3mFnsGSBwyuMGdsut0KgJ6vvvV7JAoLckOYZluDRklXNQa6LpqL4Bl/zn
	swg4U4zqisENL/AA5bI+Jx3t8VC5jqkrwOmTyz9MJrlh5U/5JB5wHk3wLK33G1Kk
	hlY7xLx3aIu/bUsNj8lAhSlbPxC3rFS9UjBq4+G+cXUtU/LaIyVyhOvm+rD6stKZ
	waCnCQPgyeQEBTsXKSdtFfdlVWgjmklduwwDzZSlQVOiMRDgvYEpmsrOWGSe8y+h
	KVwpBwXCL0rXqfUFTi4jDA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aejbbuhn2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Nov 2025 22:00:18 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AHL1Z91036120;
	Mon, 17 Nov 2025 22:00:17 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010033.outbound.protection.outlook.com [52.101.201.33])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4aefyjhg3a-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Nov 2025 22:00:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hhPDj87tvO9ctiPEmId21DrzdykYWvsLusq/8tMCOdlGJ33f+t0CRDahej3I7lQUSO3qJI7onOnKqMhukY/9Y2dQZ+vlTLs6RwcpKk2TmJn2G8UhEPIISepj8zqgk71OwWEUcsEI9V3X96aAai5w0pRLxOrSxx/E2kSd2/oFUrzpPmbdlku7DO3+YF1boEukg+8qwM/yezIOoRAeL2rxrBu8A8gNmZKUF0/5iqpUU3x5q+t8LbG/mbW1kN0tXVpDfyhXHSUlOY0qlXVKfpHiVJdkHiMrF/Syzc3EZO9tJvjqlnWLQqpBz/OmpJescjSAlQAh0REOSwq8NKMPkW+cJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K6g9fNrTH8J5rusb4MSBWJ3ZrhmeebWBX0ZJ2Orklg0=;
 b=JhPm+XVxJY1y37qzft+RpVNynqYH5RJsW3ccSmxg5Qaxw+OSEs+FREIIlA2JYmL4bzLUZcocwD673CQVjXSISRx/bCUYHhQnhB+pTN9Y4dROlIwnIF8w6eHquQOAQESm+flLpLBNQxU/UYMeX3oDjhWwRj8EiWBmzeRjEcJFkXq1M9BJyTB2k8vatyX7et2viywdiVUF4eXXeVycPu0+/HVIw7YsD0jaVqbkV3kRRW+uSTUVUv70NIdbqCRCLx1fY73Ov2/RykvXz7sKFu9xsXCO8oNhDZfnJC627/rQcp1nngEnkeTNY4fduHxjVC1WI/8i/SvlXUC8iiq2Jk2GTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K6g9fNrTH8J5rusb4MSBWJ3ZrhmeebWBX0ZJ2Orklg0=;
 b=CrMn3H7RncV+NObHlinpU/T/J2GWXAcnXdraCmWC7ugjwZTVGFxRzuaLZ0mY6gIi4/vVJqqbG/kSVWypDbmH/Fiy9QZhImi06j+blTSsPCvPjuiidhNyp/DHj/jMVlc2bpLIIMb2SYwhGL79PyJ9Lp12d2iPNFsccnqWkfxKgx8=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by SJ0PR10MB6399.namprd10.prod.outlook.com (2603:10b6:a03:44b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Mon, 17 Nov
 2025 22:00:13 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6%5]) with mapi id 15.20.9320.021; Mon, 17 Nov 2025
 22:00:13 +0000
Message-ID: <aeb05ba9-83c5-45a4-a75b-f76fc4686e7c@oracle.com>
Date: Mon, 17 Nov 2025 14:00:07 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] FSD: Fix NFS server hang when there are multiple
 layout conflicts
To: Benjamin Coddington <bcodding@hammerspace.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, jlayton@kernel.org,
        neilb@ownmail.net, okorniev@redhat.com, tom@talpey.com, hch@lst.de,
        alex.aring@gmail.com, viro@zeniv.linux.org.uk, brauner@kernel.org,
        jack@suse.cz, linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
References: <20251115191722.3739234-1-dai.ngo@oracle.com>
 <20251115191722.3739234-4-dai.ngo@oracle.com>
 <d7888dd6-c238-45e0-94c0-ac82fb90d6b6@oracle.com>
 <18135047-8695-4190-b7ca-b7575d9e4c6c@oracle.com>
 <09209CBD-6BEE-4BCE-8A13-D62F96A5BD87@hammerspace.com>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <09209CBD-6BEE-4BCE-8A13-D62F96A5BD87@hammerspace.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN0PR02CA0024.namprd02.prod.outlook.com
 (2603:10b6:208:530::28) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|SJ0PR10MB6399:EE_
X-MS-Office365-Filtering-Correlation-Id: f7054a6a-7b6a-4b70-2822-08de2624af0f
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?YXlvL29PNTNhYysrQVRKMGI1SmZzL0VBTXVkT0R5YytRQXNHSFYzTURxcUpO?=
 =?utf-8?B?cmhFaFdyZ01RNWVKSlNnZTlSOUlZZ1B5V1VnYUR5dCtWNEpVN1djeHRJR0ZV?=
 =?utf-8?B?TFV6SGhFcjBUQ0dmVHphdUNkSjkvRCtTSXVSeFFzSnBKakZ0NWdEM2dDT3RL?=
 =?utf-8?B?dm1iYi9uUzJTeHdUdWdjN0VPZE1uczhxUXNWT000b213T2pWd1lFQytHWjVH?=
 =?utf-8?B?cGxZcHVXaldteEozZGh3bS9LWmpNeENpTkRBVmV3SThmN0p1eW5LTXNDc2Rj?=
 =?utf-8?B?ZXkxNDg1OVMyaFNGekY3VVlnOTNQOVVmRCt5OEFnQnVCWGZoYkdBWXRQOGRS?=
 =?utf-8?B?WmVIUU9SdEJVZnVPYTJ1d0c2cnVMRFpoSkdGTzdnQVpXZEQxNEJTMDFPNmdW?=
 =?utf-8?B?SXlHVS9Mb1phdzVOOGwzUUFjekFYQWR6UXhqd2FNUmUyeXhTNGIwa0VzbzUx?=
 =?utf-8?B?RXZTSTVMWFZkdXBCOHk2ZTJoS014Z0dydzVvTkVHUSt1NGdmaWFJVGMxMHpT?=
 =?utf-8?B?TWpXTTlOclpGZTh4V21wTzhuS2txNDdmRHoxSG9kTlNZd2ZLdndmM0o4YUNH?=
 =?utf-8?B?L015K3VNR0VESEtJaFlncUhyT01qV1dCQmE3OGdYUVlkcHFVWllkSXNrQWJZ?=
 =?utf-8?B?dTYxeXk1bWZ2R0hlNmlUSE1iL2ZkZ1k5VDJzdE9HVFNDSVZyYzNMcVk1dmRu?=
 =?utf-8?B?VE9pTXpkNU85azhJVWlrVUtiaGlxVW1KWDNiUTZGMENmclZoVUxMVk9YOEw3?=
 =?utf-8?B?c3h3QXMwNERUSmJBSmdBOFdWYVM0cFNmK2NLNXk5cHA1Y3ZUbElrLzROOXgw?=
 =?utf-8?B?dTRaTHdkQmJwWkRMcHMrTWRPWjk4VVYxK0ZNVDRtamJkZXRsQUtVTUFZNE1h?=
 =?utf-8?B?Wm9wQjlaK0lNZWdPeDRHckZIR2xLZWFGcTRxM3BMaFVRUzgzdDg2RERoQlZ1?=
 =?utf-8?B?NEhhVytjeERUcC93cjFVdGJMc1Q4MUlmTTBDVkVhZmhNMUJIK2kxV2RKYU1u?=
 =?utf-8?B?WXJtUy9seXV3N1c1Ly9oVHgvaS91TGl4RVVnOTJQYlRUSWlvNzBGN3VwZHhr?=
 =?utf-8?B?YjNLOXVBQi9HYS9RODI4THhjUm1uNkcyQ1NPNjJLR0p0NVdvQ3NXbVl1RnJv?=
 =?utf-8?B?SjRJVlJIMDgvdXJqanRIQzVYWVE2U3lQNTlyVVlYSGVIOU9uWTVZS0prdExU?=
 =?utf-8?B?T3RGRThPMkFSbncxZk0xMWY1aWpsV0ZDU3JYNmRmckdMYS9Na3VQM2ROaGVo?=
 =?utf-8?B?TVI0Y0V3SkRqaEptRlh5YTRNZzBnQ0gxeHNPazBSK085VE9ZMDZxR1JiaGJt?=
 =?utf-8?B?UjZ1eFhSclUvVlRpYjhmVUdCai9EbGUvNzUxWWxXRW5QdmliTFlVelV0UlFs?=
 =?utf-8?B?a0twRE5aZzlJQnhvVnhJQ3AyaU82TjEycllYRHEzS1c3MW5UMEpqRVhnUnUr?=
 =?utf-8?B?UnM3VTM3dHp4aUlvOEdmakxMYm56L2tHaEhzVE1zaFBONUs3b255YmRockF3?=
 =?utf-8?B?UVRtNXpQRGlqUFRjUGY5cndMbFFQa3o2VTIrQ0xHZHVYVC9PcU5GTDIwR2VW?=
 =?utf-8?B?d2UxMjU2aVoxcXJJb003WkJTSldIRHRFbUU3aUx5YjlXRHpobVRHL2liTWpM?=
 =?utf-8?B?aWFHK0pscDJHdVNLWlhYYW5xZHpEd2hUaDZPVTNUQ2ZaVDlZcjl6Sm11MjNY?=
 =?utf-8?B?M29tQjllL1dyeTNaSWx0U2lWaUJ3V3ZCVzVDbVRlNmFneDFRZmRGUm5nSWFw?=
 =?utf-8?B?akg4OEdrUG1kcUltQS93emo5ZlRTNnJldUY1TlliSTFvTzMvVzRpRU5SRnk3?=
 =?utf-8?B?K0tNc0pBSXY1dzZCanp3RDNtSE1zdTYxVjBJbDduWHJJUGxXVFRmbDJQTVpQ?=
 =?utf-8?B?MmllbzdaWHFTSUlIdGhESk5GRDZENlZmNEE3eFFzci80cG5iWkYxZ0RXWGJw?=
 =?utf-8?Q?MjfN70UeXUcvZKHs/1grscY2ocJ/QlCy?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?Vmd1Zm50RjZMdVBlK0MwRXk1RDlPQS84M2YzNHJvNDIyN2s1Nmc4NllKVlB4?=
 =?utf-8?B?M2xXaWIvWHVJL21KeXZVQzdweHkzcHJNTjNtV2pvbE1NZkFXUSs0RU9aNVJx?=
 =?utf-8?B?MU1ZbGpnSlRhMDhxUTE0Q2NNd1FQLzN4OGJrT1YzdUJCcm13UkhKRFI1QWJB?=
 =?utf-8?B?R1V4VndKWHhBR0hpL21LOXJmL3NTVE9kbjhaM09GcVErTWJRRnZuMC84QmxH?=
 =?utf-8?B?ZU1tc1hpM29ya3d3QjNLYXBUQTBNL3ZuMHExSXpNTG4yWi9NRVZuQ2w1emxx?=
 =?utf-8?B?QmU0dmZLTDN1aUFqY25kMHdSbXg4UmcwUDdiOVZGZ2NlOTE4bkZrVTFFNzFt?=
 =?utf-8?B?eFRhbmhndm9MMXBjWTR5SWp5TlZaSFVjREFMbG8yOGV2M2NKb1RVclBqT2Qw?=
 =?utf-8?B?MitoRWxzbXpYbDhWMjBMelR1azVRTy9GdnV0M0VteFQzQ2tKSXJiWUIzR29I?=
 =?utf-8?B?MEx3VTh1KzhIa1g4a1FHMCttSEhKZk5LNjNVMDU3RFVYWTdkRnFBWWFXdTc3?=
 =?utf-8?B?OTRLMnArS0hOK21HWndMRXBmdGgwSHpDWE9nRnRKN0FOSi9VekF0MzZraHdO?=
 =?utf-8?B?MjJYQU5UNWJqWnEvdXFkSytORWdITHpLUklWd2EyRDh4QXQwUHd6K2kyNCtj?=
 =?utf-8?B?amJnWktiTkNhRCtHYWpleXBuaHdhTVpEYlFyMFdUOTJha0xLZkhpaVNBSHFr?=
 =?utf-8?B?bXF0ck9HOGZROGM4UVd5Yk9QMVIrNlloTWl6MURXeVh3RnRqeUIwMkdnVUI0?=
 =?utf-8?B?UHZQeHRNeC9QZnFRSEU2YjlhVjNRSTFscVczVVNwU2o4aDYzaTBmUmFJc3hV?=
 =?utf-8?B?UjFPYm1laWtaRUJtNi9UU3BtV2FrKzlMY1Qzd3VyMmRPQzIrRDRBTmdkN3Z1?=
 =?utf-8?B?clJGUi9mbkRYQytFODdUZFJBUkg0dElNanhVMUJwM3M4TjF0alhoYU44c09M?=
 =?utf-8?B?bnJLV3Fxc3hnNERrUXYwdWpCNVNJS3hoMWZXTG16TncvK1QrWHVtRHdZbndt?=
 =?utf-8?B?SkxVM3BFMWt3U1lkem13dmFIN2xCa0tNOG53Wi9vVnpzTnE2NksyNXFiQnp2?=
 =?utf-8?B?QU9zRGNCekFLY3FlMkpYb0N0WVdQZEVOYWtDaHhUTnphN2IzajAyM3BHODJk?=
 =?utf-8?B?Z3VlY0E4bVh1M211a3VUT3FnY0dTbjhCbXorbVE2MUtxOC8wL3AyWUpYV21J?=
 =?utf-8?B?T3piVFArSlBWejV5Tmp0SXBqU2p5R05uVGlYanlRYVRuemdVaWczUkNwajNz?=
 =?utf-8?B?SWJYT21iVDZrME9ONzhNVXpRa2tIUjdWNVRXLzFFbWYzdHNoUzBVWkZ6LzVi?=
 =?utf-8?B?SGxoNXhQcUVhNFNsNUgwQ2pSNnhUT3B2SmVkZzMyRTlLV0lQaDBMQTNVVTBQ?=
 =?utf-8?B?OUZZbERoOEJrSWhqeklVRUV0amQ3eE1JRGNSMmd5YzZSU0hYYWsvRWQ0M1BU?=
 =?utf-8?B?czB3M0d4d3hPY0F5aTBhZWhjY3UrSjBHWkpJcjdHbXU4N05sWm9tak43a3FI?=
 =?utf-8?B?Nk1OVk85bEErUHA0dG96RE9HLzRIL1BBSndMTlovTCtiWE5xQU15SjU3Zmxz?=
 =?utf-8?B?bWRxMVlzR0xvUWNaSlRldG82ZFd0VUNGRi92OFNkdFZBSy8yY3Q0bWozcitC?=
 =?utf-8?B?NitHV0lIWnNScmE3OTBBa1JjZjVLTzd4MnpRaFVYc1o4N3pIYW1Paml1SVRE?=
 =?utf-8?B?azNRQTFEazdFcUJHM2t4cUtkUzlVekJzVmtNb1pvWkJoR1dJMlZmMFFGT3lJ?=
 =?utf-8?B?Nld6c3N6K2JWOGcrU3cvWDhFOW5qUmNyRUJvMVVKMXJQN2c0NDJVS0VRV2ds?=
 =?utf-8?B?enlvek5OeW9JQUxQSGVhc3ZROGN6bUQ2RVFuRVR2SzlyL05LbCtjOU9kYWIx?=
 =?utf-8?B?VFk3V0lXeGFHb1dHTzgvYWVsbTZZaXlONWhkNFZjalpMOXA4djQ4bVQvRlR1?=
 =?utf-8?B?dytzTVFVdWU3UWUwblpTTjBHYkozWG9oZWs5Mk9INm9SQXVldmFVcDZ3eEJD?=
 =?utf-8?B?ZGVJVkg1L2pYVmI3U3gyK1dRbkJNWG41WHN2b3Zub0F6L3ZvNUgveHZQYWMv?=
 =?utf-8?B?KzVjMThENklxNmJmYkh5emVTclpibEtZRHRQUDYrNll1WVFhYW5XV05vQ3Rk?=
 =?utf-8?Q?Mt1zwKWZeu20I/OR+85ZI29qX?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Me19XD94Pc4cPp9mE3QV8HPW3JIFyWmvRj7qELnRH0NlF3i3m8r5CGVsg7SAMQjumLNjGl3t+RL3OG4r/NsO/DaqEXrfnfZGxXZB3DWsy1QMLLs2S3cQwK+ptUPcXb6jiSENKzXq+Z4WEYfYWwwttL6WQjV7UFiQ0WBAYY65nDoD6ExvZKk8aoXZU3ljh8Tnw5Klol4aGHueANTjGzcdszZdcdL22obzjLb8btZoSMZtxp8L2Zsby6q/c5YGbNBPiBEU6tyrIHoKr7ekafCgQ7DwWF5uRDh1rfH1pJh1ozGWZrkc5B3/Zty9bItL3ED5U53KzT0I2sIqLJ1sJW85j0uDojhHyBwiOIus4+wefqjc/1qq6ycIxlBzPiuM8SkrvD76cTqIi2Qye4dEPog7C47Bl8OgRxzWfmFzFuLr1hmw+fKMHjzAKL0s8e/zP7XnfpfkzaBClVXi6+qI0WW/sqdApCE1eKdQL/WsAd46PPwHPeLeIVsUvOjN6ofQLGc45n2PNYfMjWdPwQIDOFqNPLhZjhWErKET6P7yjGlts4QJWFeeubtuNJw4fOcUChed10MOgIpR9IUieZo3teq5luSSXjyU+KNJF2GSt5/POEs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7054a6a-7b6a-4b70-2822-08de2624af0f
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 22:00:13.3226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dm9KUY+n9PNFSuRgBZ1eT3UiCrUNz94iIKDtKrJT3Tfv4isv4Hw48ojB8GKmSoj409xd7xAqcXsWHLPx9Pq3gQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6399
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_04,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511170186
X-Proofpoint-GUID: ES-9JPcQkiZt-qpZDxuZM7MXzTOFqmqo
X-Authority-Analysis: v=2.4 cv=JZyxbEKV c=1 sm=1 tr=0 ts=691b9af2 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=a0suwfw9bGB2DUS5IkEA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12098
X-Proofpoint-ORIG-GUID: ES-9JPcQkiZt-qpZDxuZM7MXzTOFqmqo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfXwJq2suJBHhBe
 OGomRSbyU/DNM34dE1EyUkKo9svyGopYND70r9tgQgQPpoUXJCqW992NTWvrvrehPqL8oT+5fl7
 LK4KFSudoNC+aSiI++PTtc0c5JIK4e+FZMO+uthfD5RHTOQNaeSN4oqhfBdCH2EZ96a59zP5U+j
 b5F19etxCxbXqawhCHkDJx+C6sFywHQzR/5hP4FYmhcNz5dmv97wJUAyM5/pLRzxQaz0l+nGl+8
 8lmzU1TVdEh8rz1XryCuTJkjZR/lNKaSK4gmIVy8d5RUdTysRgMYMxxQ1vU254IEycGtgIUp7tO
 0Ny/nTPLfP4fhrj9PTbQ+K5Wep4Mjha6GY+Q7q6qlGIUtuYWoDmMgKxbtF+nBCRzclOHe/q+FCM
 opAEEOf0Tsh0LUDT9hrsQEiCyU2WssNgH2nhJeWOuKDHOjKmtTY=


On 11/17/25 1:13 PM, Benjamin Coddington wrote:
> On 17 Nov 2025, at 14:40, Dai Ngo wrote:
>> I will add comments to explain the changes better. My main goal for these
>> patches is to plug the hole where a malicious client can cause the server
>> to hang in a configuration where SCSI layout is used.
> This would be a mixed SCSI layout vs non-SCSI layout environment, I assume,
> since a malicious client with a SCSI layout could do far worse.
>
> The mixed environment is interesting, but not well-optimized.  I think if a
> non-SCSI layout client can break leases, then it would be impossible to it
> from just walking the filesystem constantly to open and redirect the IO back
> through the MDS -- another DOS risk.
>
> I'd go so far as to say that in a SCSI-layout architecture, we must really
> fully trust the clients.

Perhaps I overstated the severity of the risk. The real issue is, in the
current state, SCSI layout recall has no timeout and if there are enough
activities on the server that results in lots of layout conflicts then the
server can hang.

I think by requiring iSCSI authentication between the client and the DS, it
helps to establish trust in the client.

-Dai


>
> Ben

