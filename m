Return-Path: <linux-fsdevel+bounces-70534-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D579C9DBC1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 03 Dec 2025 05:14:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 59A2B4E063D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Dec 2025 04:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9F7272E7C;
	Wed,  3 Dec 2025 04:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aM1IHSKa";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BlsdvUPi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8F61EFFB4;
	Wed,  3 Dec 2025 04:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764735292; cv=fail; b=FA5iVFe1Mij63pb2qZyB11C5gY65zj76bxTisHYTIyakSVTRU284SHmZhWX5Evu65kjsN5fW5mQCk+MRYxd6atSwtiJqsQvhtYuUSiYs0cDVIvWfrWnupRjQZwq2jXW8riCq+XRIXyEIJJOCsv+O7TLwHH2fuhL0jjDrB0R01LA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764735292; c=relaxed/simple;
	bh=nd3vJgwjQbSMXvJ0UJI7+SoZsCaFiQ0JGyhUbn8psdQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Rq2fCB035Wr8x8sXz4msVjsdS6gIJwPcDUd1msSsY5yrBAN0B9lVd5StSxJg8yRMdjt6d8VDY5MaqlslT7caDAzSl8tyuNCROdNqFsgEz2XcHReGrToMzaw8FRtx58kifJa8zklyh9MsUV3/+fPt8OznWYUowcUMdHm+7Xadimg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aM1IHSKa; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BlsdvUPi; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B32ukSv1669979;
	Wed, 3 Dec 2025 04:14:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=57+BAcBRQR25SVG7qXe6rdnTrh6a81vDJ6xYmS3f8vk=; b=
	aM1IHSKanRxVKjy/E17po4C1V38NLopgbD/gwXssS+YW7AyV6iXvuf7wK7D/EYRY
	wJZzn7pKF5PJm7aY01dwjVK0vmjmvh+AL4ysZQjPRsuS2QBmmdgpQY7vwUGyRykV
	NEWMqmj9nGk/amrAgbtqtPR7bYb2qSGHw+GjEVNrolE/b8KYI5l9FpqYl1GhkcSY
	eZza5r4L9x2Ql+lxHmCrwH3frkJyGqEHdcZcDii5wxhDMKutakcuFGrSQRsvz1jZ
	wDPbASXwQ6Fu1KsQImOT4FLhuh97U1A4HQeWMaZeBT5VnfzgS4R97MfYHmT7AKUm
	P9V/Yub066x2JKtI3vDHFw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4as86ycdqr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Dec 2025 04:14:12 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5B32abOO035423;
	Wed, 3 Dec 2025 04:14:11 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010008.outbound.protection.outlook.com [40.93.198.8])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4aqq9m72qg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Dec 2025 04:14:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sapFC6UQ9+MC/5psdnHA4hAh0/WzXIpSoRLpn+lepTPw+WcOw8mXtoNy9vWeQEuafKLS40GsT9z0s3ETjsEAztOlJFJXbhY+ZIFXKgJv1ohfRVWXmMa4EZnwHoBVIgd6X9GAJG2aes+w+cj98Uma4U+snDfNWeFKi8a2lDfhC9BQC0MYFFxlrd0XTFoEtlCGcTicDFw4XxrSSmC5XHjvf0j0aHrYhJJasyelteOTfvRwwn4tfINoaeBfj6DUULTuxQ8vc4oMdervRB2aUrnKYXjioYtgBhAhtcA2CJ7qWJOjuig76lGKDgbdse2hsPbTKc1NCjz8YwTI6eho97Z2pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=57+BAcBRQR25SVG7qXe6rdnTrh6a81vDJ6xYmS3f8vk=;
 b=KxLXy6cBHhZV4bHuYarHi/EfwQIiPhPLW+EqmXwwkc/dwVlxG3dIK0qZctw++JLw6lNhCEPBPdzt5nievTQ+4im7Ld7dOXdQ7RchCqWM5Ck3E3nBUItjq6SbkGgjFMkBZVdELJk3OAMKGcW4hELAkEPERCIGnxKRbbNT5Uwnpzbua31PXFwJoAw2v2emaHcE5KclhG69u4fOFC2feZBz/HbmLk6d/cqi1gCIKinU7IzJGfP+hEE3LdeylPf2heW0yVU47Cg5FLcTTxdCj3JCEh586rrLmObdC+pUaXywOuimAjHNHlt5TWmj3h7xSDL/4XIelbL/Nl8mYQsDkPN5MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=57+BAcBRQR25SVG7qXe6rdnTrh6a81vDJ6xYmS3f8vk=;
 b=BlsdvUPi+zVZVrxsa3q2TkZAEy1sGTcQL/jh74PYAoeRZrqjShaO7JwArzrUEZ+5CQCS2EST7Prvnx6T5lQDMYXn8+HoBWrfTempl6AxZEXK2NiaObUO80/7QQ9b/SXS1ZNk1YA5OlC2YTtFb5f+/hL3b70pridMnaCVxgphr2c=
Received: from DS0PR10MB7364.namprd10.prod.outlook.com (2603:10b6:8:fe::6) by
 DS7PR10MB5215.namprd10.prod.outlook.com (2603:10b6:5:3a3::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.17; Wed, 3 Dec 2025 04:14:08 +0000
Received: from DS0PR10MB7364.namprd10.prod.outlook.com
 ([fe80::b7d7:9d3f:5bcb:1358]) by DS0PR10MB7364.namprd10.prod.outlook.com
 ([fe80::b7d7:9d3f:5bcb:1358%6]) with mapi id 15.20.9366.012; Wed, 3 Dec 2025
 04:14:08 +0000
Message-ID: <ae927280-fe30-4773-b40d-dbb90e98c74c@oracle.com>
Date: Tue, 2 Dec 2025 20:14:04 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] selftests/mm: test userspace MFR for HugeTLB
 hugepage
To: Jiaqi Yan <jiaqiyan@google.com>, nao.horiguchi@gmail.com,
        linmiaohe@huawei.com, william.roche@oracle.com, harry.yoo@oracle.com
Cc: tony.luck@intel.com, wangkefeng.wang@huawei.com, willy@infradead.org,
        akpm@linux-foundation.org, osalvador@suse.de, rientjes@google.com,
        duenwen@google.com, jthoughton@google.com, jgg@nvidia.com,
        ankita@nvidia.com, peterx@redhat.com, sidhartha.kumar@oracle.com,
        ziy@nvidia.com, david@redhat.com, dave.hansen@linux.intel.com,
        muchun.song@linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20251116013223.1557158-1-jiaqiyan@google.com>
 <20251116013223.1557158-3-jiaqiyan@google.com>
Content-Language: en-US
From: jane.chu@oracle.com
In-Reply-To: <20251116013223.1557158-3-jiaqiyan@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7PR13CA0020.namprd13.prod.outlook.com
 (2603:10b6:510:174::27) To DS0PR10MB7364.namprd10.prod.outlook.com
 (2603:10b6:8:fe::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7364:EE_|DS7PR10MB5215:EE_
X-MS-Office365-Filtering-Correlation-Id: 927c2f36-d900-43b5-cb90-08de322267b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OG9zRUk2Y3gzOGFhN21yUThaeFJDdG5XckEzcUR6eWYwVUdMY2VUSG1sVitN?=
 =?utf-8?B?WUtkK3BMRVI2VTBYM3MzZVB2amdUeUhVNHhUMlZmODMwSXFqZUhtTEVIeTYw?=
 =?utf-8?B?QVplVXFwME1yaW5JQlVJdDJFUmVySGtVSnA1Q1V2RExSQ0ZhREIrSkVMMHJv?=
 =?utf-8?B?ZHRMWXJSRUQ1R2pkcUtZdWZwTjZRbXMzaTl2QzZEY0VZZU9oL3QxU3c3eG56?=
 =?utf-8?B?bWo2U3FyOFV1b0dsZDNITTVoMVY4OFdIZ0kwZmEwblRBUUd5UTBXcFFiM09E?=
 =?utf-8?B?dHBCM1VKLzNubEZ1cnNxOTAzMXYzUEdJWWdRSmQvM3JLVzdyanVTMDJMbk1R?=
 =?utf-8?B?NzNPdW1oOHM3cFoxNU5zOS9JLzJ2ZHRUWGpBMUZWdXI3NE5XZzBuRmFBd29m?=
 =?utf-8?B?SG5nZEpxczNjTkFSKzJHRHhxVW9NUWFXSHpwSGtUSmpzNVBKVHNTaXNjOWlo?=
 =?utf-8?B?U3ZuSzcwelNQREpiVU15SkNZUHRHVEoyTmN1ZXZkcFNJV3hvd2Rkd0ZiUTlv?=
 =?utf-8?B?TUNPS2Rqa1dtWERvRHdtdklkY2hYTGJNL1pzNUduN1Ruc09kcGhDT1BhQnUx?=
 =?utf-8?B?L2xwcS9zTGl2MUY4amZ5RFcyQmtUcXVtZVRTNzU5bnU3V05sbEc3TG9NMlpz?=
 =?utf-8?B?WHRpYzJSSGs1NlBLaW5jSTd1UG9KNWQ4UDhQWDMydmpTMUFraDJTcUtBYWxK?=
 =?utf-8?B?UGJLOHljR0p3QTR1TzMxK0NXT25tQUMvZyt2R0ZDU0ViT1BaMSt5KzFzazhW?=
 =?utf-8?B?YStFNEtMRnlldnowMjg0OGxSaHAwYzE0a0ZwOEZOeXkxNFhCaVlySnV6cW9z?=
 =?utf-8?B?OHFQL2hrQmlXUTNKSnhoREd6LzlxSzBZTU5CenpUZE9WSXg5STlUV21uRDlD?=
 =?utf-8?B?SXdEcGJxdFdoUCtMNzdNa1R3VldSUkxUMHNiR3lsZXcycTNCU05ydlk0QUdj?=
 =?utf-8?B?Q3lmaktpZmpxQXJQRnppVXRsU2hTQ1g0RHN3V0tRMHhVcjUxVXlqY0prcHkx?=
 =?utf-8?B?bXIrMUhnWXFNNlVuU0diMzlLU2hhUmtQOWo2QzdvRlhkZ01BWm54dDRzMkda?=
 =?utf-8?B?U2l1SW4ycFZsc1RXbkVnaHFncUZpZVI0WTFPMG8rSlpESXROT3FSaTNvMFdS?=
 =?utf-8?B?aDE2Zy95QzRPbXJ2aUY1K0puSU1hNnQxVStBMGFYWDJjWDJ2ZGxLcjgwYWFm?=
 =?utf-8?B?NDcyYnJiRG1YN2c2c2xGeStIR3BsaDRBUGtVNThhaUVGZjBpNFhqMlp6YVhD?=
 =?utf-8?B?R3FxamdOa1VPcWFuc0Y5cytwdnhZeDlic29lU1VsR1dSZFNOdThWbUxzYzk1?=
 =?utf-8?B?WXFRdklMdFhtNEJ6Y0UxTjV5eVBENlgrKytwZjA3V2F2Q1ljb1NjSVU5M0pV?=
 =?utf-8?B?UVY0K21TemNtTVd6OGJXa2VTWHZLM3hqcURmT3U3U09HeUtQbWVBSWZpUERm?=
 =?utf-8?B?Z2FFUDVHZEVsSlFtaXpsL2RmVjV2bVNaMmZDMDJ4ekpUQ3ZCd2tmNS9tam1O?=
 =?utf-8?B?YmpMTXdxbkJ2NnYyZi9JcHA2T05oTUNDV2V3ajlyQ3Vpcks4TTR2bWN4V0Jl?=
 =?utf-8?B?aUZxWXZiZk5ueWZFejltRHpIV3dUdmtvRHlOVUdtMzV2U2dOazhBRUs1NGxL?=
 =?utf-8?B?dFpSV0ZCbC96NUplZGhmcjQrQWZnSGVzS0UvaTdwa0c4YWs5VTgyL2Q2WFc5?=
 =?utf-8?B?VFZubnExQU1RRkpMeHBQQTVqZE1GSEZudkhRK1pXNG9uY2NMdnRTSENTRGJ1?=
 =?utf-8?B?OUQxWjUxODFHS2NpK2VPa3pITkVrTXFaMitoNDU5ZGtBMk8ydWRoRVcvR0lk?=
 =?utf-8?B?R3Y2UURkTUdGQzBKTFNFb2s4RnRZaG1USHhsM2ZnRlU2Vlo3LytzaDAyVmFV?=
 =?utf-8?B?M0NNSTYvaXYrTzhjM0V1NFI4N21Fc1NWbFk1NW53eEhibkUrWmorMERDWWc1?=
 =?utf-8?Q?IbTiS8Fgn7P0qe/pRumpCfjeJt0tCxnQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7364.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a21SUGp6MXlYMHpHL25paXIzaXgvT1E3SXBIWElMZmdETFFkaXduVitPckJL?=
 =?utf-8?B?L3Y4Q2xhbjJlMzNxSlpGdDNuRjRGeno5aXdRbnVabzVNWG04UHhDWjZ2N0Y3?=
 =?utf-8?B?cURtakdRc3pvR1E0amNqQ1EvTUNKWmZGVWJSclN5SU8wRWZLTVh3KytVaUc5?=
 =?utf-8?B?dFVyWHBxVnJMaXJOV2VtMTFvMSt3TXJJRS9EdldlQjZyVE1ua1JodWhsQ2dU?=
 =?utf-8?B?TVdJZ1NDNUwzK2lDVERRYTUzOCtOOHlFMzhoR2hpN3YxMjc2cnRJK1NFaHBF?=
 =?utf-8?B?QmpKc3VEZnFkZW5yUm9tMTI3Tkhkd0ZYWlVSdGVSKzhxUWF3eDFRbXJ6am5N?=
 =?utf-8?B?VzloVW81M1JMY3NoMUZiWGx6alJtOERmZGhjTkpPUGZxd21qNlR1ejdCR2Zi?=
 =?utf-8?B?dUo0bm56UFhtZTJQREljQXRwdHh5V002NURrOGpqaEpldHMxSDJobkQxd3N1?=
 =?utf-8?B?REpJczRXR3p3TnV6YmNDZEtWYWNFcDhlTERCSnpVKy9GRVdwVU1OclZrM012?=
 =?utf-8?B?MlpZTnhjR0UxZktSRWxCM1oxVzZvb0tWWXJ2bUVrTWd6dXpRK2tqZC9xa29k?=
 =?utf-8?B?d3BPMmZGT2N5c1pqdG9wbFpBZWtDaklXanA5cStNSjBhbWpqNjRUY1VoLzVq?=
 =?utf-8?B?OUhuODQ4bGsxVmY5b3VXcXd5UlBlSXRGS0FPWEYzc0tVMjNQcE52NXAxY2VS?=
 =?utf-8?B?ejBPZXRHK1I4TTArVlF2aEZpSzc3Zlp2SDJvSE1WVmZWOTFKa3VtM2FzcHM3?=
 =?utf-8?B?Vkd0V3ZLaDJ0VVdadjZUanhpcGZ3S3IwM0dIeHc0eDNYazdXUUlDb0tOUURK?=
 =?utf-8?B?R0VRc3NCVHJCdmNFcW1DeXZQall6NDJuVUcxMHVJUnF5aURpR3laNERNc0Fv?=
 =?utf-8?B?dC9KU1ZmL3FVM3BuY0VLb0NTR2VHQW9JZGZxMnR0cTJNeEFaOW1WL3hxZ1FC?=
 =?utf-8?B?RFVIZWtwd3RaWFlPMWlYT3JNKzkreTAvQVFlek94ZDRzaThYbjVqSnNZb08w?=
 =?utf-8?B?aFh6b0Fuek9aMU54NVhXZjB6cERCOU1nRFFoRjNBNE4rUWZicnRNQmlBbzRo?=
 =?utf-8?B?U3FBcEhaOWtHOFd3RzN1YWZhK3Fod21JejhhQmhTTCszSjRCbkVBaTZJZlN5?=
 =?utf-8?B?ZTNieXVHa2dkYXkrT3lKYUc1NHNpamJ0ZnhEQ0xpa0dIaVBuNEZLcGRLYThJ?=
 =?utf-8?B?Q2dqRWJmcmk4YVNaNDN0TkdLRGtHSDlHaHZud0RNOHBRSVp0ZzIwYksxVnVH?=
 =?utf-8?B?UXZKclVvTk40REJUMmd6dW1sb2UvSG5DZTVDRXJVMnByRDh0ZFdzMndsbmJH?=
 =?utf-8?B?VE9ZTVU2STViZXJhOTNHYzdKQ1dwODNFcmJxcVFzSG5ZN0Y4SUZhSVdnMFNM?=
 =?utf-8?B?alA5UEJ1dVcyRTVFRnZJUFB2QjZndGR2MGt6VHB3TFpZTGZuUGRpN3JkVCtx?=
 =?utf-8?B?SURzMzJvY0NiMXJoRUlXQXEwS1NrUUw5UmpVMFBuUUdlSVg0c2dwakY0aXF1?=
 =?utf-8?B?VGZVU2g4UTg4QUFWT2ZaYjhvSWQzYldFZ2lIaVlGeE1vTCsrbitpaHp4RURu?=
 =?utf-8?B?anhta2RHc3hTcm5kbE52NEFUV25EdE1SZVpCcXBsVnJzTExTWFZxbDZEM1lM?=
 =?utf-8?B?eERqemFZNGNBbWtIYXJpOUpPWTdoL3Y1UXlGTGgwZDhMVGQrM3c1YkRkYXlS?=
 =?utf-8?B?eHRINDVWYlJIaU5UaUZYUml0N01HQlZqZmRVcExkYVM4ZzNPSFh3ZWQrU0tz?=
 =?utf-8?B?MEdhVVJyL1N3cmt1clM0SXRNSkVsdmJQME12OXFtSTlUTHE4akhRbFdTYnpx?=
 =?utf-8?B?NEIvSmYzc1NxRW1KazBCZyt0aDVlaEpxTkF5R3Y4eUNqay8vZGtSM21HYUhu?=
 =?utf-8?B?YXRwaGVKNHljbmxTbExaMk1zd1FiaFBDZEFYK1A5VjhidWNMTWhJWUNQcDhC?=
 =?utf-8?B?VHRtMjRXWGJuWEliVkVPV1gxNjByZFNqM0JnV0kxN0cvUENOdk9jTU81MDlR?=
 =?utf-8?B?UGxJcTVpbUs5VnpiaTlGUC90eFB2UFk4Vjd6dk9QaUdIcFQzaXJYUmsvbjFS?=
 =?utf-8?B?SGQrY2FYYkdSR3E0UTFQR0JjVnlpSDczMVNBVU94NXlMb1EyYUgwZWFVUWdn?=
 =?utf-8?Q?prdT6YnuqIZzQSmspRgOrSEbQ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Je+q5pG7X6sfQLa7Qcnj/C7u8kGzO4/Mbe6EWqEcTAmtfKpRFoqX8egGZA7xQRzRby4gWk+zgTwhHnyoozvfUeGakXuX3TWx92Jj+DxT5Hz7GRj9ydgPlJENH2XkVtuBNyS9iQCeF2FUqe2CcTg1rXJCHUtbpeuihGG08TK/aUhN4ER8B9znde6IVBikLpj951mUMnol5VwIwsOLsU8h7cRjEWpKX8T9Q6FBoKXMP7SKJe5cmqiggK9Ar2uJBdH3LEFeonDz7b6db274uCvnkMVzHu3CJ0hDpR2nLKSZQOATSXr3DChVBQF2/eP12ICbHAkKUuN2rGmFz7wSVJWWfjsaMq6ekKWYEjviUb/OLXZzdZFlfLZ7ZKqITXtLt6RjQq/fwoy2Vu+dxDBVsytK2RFDefTlpG+yVFVWylmTI/XLyA4ngxUcABlCxOSNbi6i/HyltMIn4mLaTmdQwv81Frm6NVOBxfjrp1DS1FCxwPdxdFdOMGUgfIxWacZfbqyAROYF5uvvDEH/lZx6P25exMm5ovdJ2VmxRFXFJ9nMfoXqADGrY9eoyPgB1K0o7w+YpPlVL+Jr4+lFrLsbVLzrrbhhOnXYckfr/7DZ0qL93Ng=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 927c2f36-d900-43b5-cb90-08de322267b8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7364.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 04:14:08.5104
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IjNPHB/BhNLBu/Xdh4lTEw42lyK7+KO7d51WrLpLRXTFe0UMUcUzJPesh6Jjhhs/8c6uK4yLgsnzrcLTUriO/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5215
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-01_01,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 mlxscore=0
 adultscore=0 bulkscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512030030
X-Proofpoint-GUID: pbGRJlEF4eOh_bFuH9nVInqKJo-Kj774
X-Authority-Analysis: v=2.4 cv=AaW83nXG c=1 sm=1 tr=0 ts=692fb914 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=1XWaLZrsAAAA:8 a=yPCof4ZbAAAA:8 a=8nQo8_QyJ-D4tJk0m-sA:9 a=QEXdDO2ut3YA:10
 cc=ntf awl=host:13642
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAzMDAzMCBTYWx0ZWRfX6+pcRaVn+z/g
 Nt7M2/tLdn0bh0Dp43ctfFEFqBfXxlK9xMQ+omPOCtrQlXjvfnUPHOiICzrrwVADcEotqor6hI4
 U24ucSiLRt+sqWui959l9EAEzvxmdoIHbwedUqKixW6tNgqcCHyo+EJkuLf1HFDyrlEjrPULW2Q
 oe3MeKwipGkZg2f88rM3z7SE9Z/5cqF47sisKqaS/7/uIfV31RupGk+vilczF1RLUNordKx46d9
 EhMr/D0osshyghcy9cmPNBSG+65cf9ywe41HI4uqc8R/mGxf06mCbG0T/4CwfV6roctIxcSqFmk
 TIQ1LgH/7zVM0E6e1fqdKh/rgprfgSum5kvVlR03Nt+lUsVXkriHCt0fvIC9blQekNPty5uYx8f
 rvtTOuB35EFubJqDCBoQcSdXPwMtR3Rh9YtTnmLLCHIW/AP4Pac=
X-Proofpoint-ORIG-GUID: pbGRJlEF4eOh_bFuH9nVInqKJo-Kj774


On 11/15/2025 5:32 PM, Jiaqi Yan wrote:
> Test the userspace memory failure recovery (MFR) policy for HugeTLB
> 1G or 2M hugepage case:
> 1. Create a memfd backed by HugeTLB and had MFD_MF_KEEP_UE_MAPPED set.
> 2. Allocate and map 4 hugepages to the process.
> 3. Create sub-threads to MADV_HWPOISON inner addresses of one hugepage.
> 4. Check if the process gets correct SIGBUS for each poisoned raw page.
> 5. Check if all memory are still accessible and content valid.
> 6. Check if the poisoned hugepage is dealt with after memfd released.
> 
> Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
> ---
>   tools/testing/selftests/mm/.gitignore    |   1 +
>   tools/testing/selftests/mm/Makefile      |   1 +
>   tools/testing/selftests/mm/hugetlb-mfr.c | 327 +++++++++++++++++++++++
>   3 files changed, 329 insertions(+)
>   create mode 100644 tools/testing/selftests/mm/hugetlb-mfr.c
> 

Test looks fine.
Reviewed-by: Jane Chu <jane.chu@oracle.com>


> diff --git a/tools/testing/selftests/mm/.gitignore b/tools/testing/selftests/mm/.gitignore
> index c2a8586e51a1f..11664d20935db 100644
> --- a/tools/testing/selftests/mm/.gitignore
> +++ b/tools/testing/selftests/mm/.gitignore
> @@ -5,6 +5,7 @@ hugepage-mremap
>   hugepage-shm
>   hugepage-vmemmap
>   hugetlb-madvise
> +hugetlb-mfr
>   hugetlb-read-hwpoison
>   hugetlb-soft-offline
>   khugepaged
> diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
> index eaf9312097f7b..de3bdcf7914cd 100644
> --- a/tools/testing/selftests/mm/Makefile
> +++ b/tools/testing/selftests/mm/Makefile
> @@ -63,6 +63,7 @@ TEST_GEN_FILES += hmm-tests
>   TEST_GEN_FILES += hugetlb-madvise
>   TEST_GEN_FILES += hugetlb-read-hwpoison
>   TEST_GEN_FILES += hugetlb-soft-offline
> +TEST_GEN_FILES += hugetlb-mfr
>   TEST_GEN_FILES += hugepage-mmap
>   TEST_GEN_FILES += hugepage-mremap
>   TEST_GEN_FILES += hugepage-shm
> diff --git a/tools/testing/selftests/mm/hugetlb-mfr.c b/tools/testing/selftests/mm/hugetlb-mfr.c
> new file mode 100644
> index 0000000000000..30939b2194188
> --- /dev/null
> +++ b/tools/testing/selftests/mm/hugetlb-mfr.c
> @@ -0,0 +1,327 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * Test the userspace memory failure recovery (MFR) policy for HugeTLB
> + * hugepage case:
> + * 1. Create a memfd backed by HugeTLB and MFD_MF_KEEP_UE_MAPPED bit set.
> + * 2. Allocate and map 4 hugepages.
> + * 3. Create sub-threads to MADV_HWPOISON inner addresses of one hugepage.
> + * 4. Check if each sub-thread get correct SIGBUS for the poisoned raw page.
> + * 5. Check if all memory are still accessible and content still valid.
> + * 6. Check if the poisoned hugepage is dealt with after memfd released.
> + *
> + * Two ways to run the test:
> + *   ./hugetlb-mfr 2M
> + * or
> + *   ./hugetlb-mfr 1G
> + * assuming /sys/kernel/mm/hugepages/hugepages-${xxx}kB/nr_hugepages > 4
> + */
> +
> +#define _GNU_SOURCE
> +#include <assert.h>
> +#include <errno.h>
> +#include <numaif.h>
> +#include <numa.h>
> +#include <pthread.h>
> +#include <signal.h>
> +#include <stdbool.h>
> +#include <stdlib.h>
> +#include <stdio.h>
> +#include <string.h>
> +#include <unistd.h>
> +
> +#include <linux/magic.h>
> +#include <linux/memfd.h>
> +#include <sys/mman.h>
> +#include <sys/prctl.h>
> +#include <sys/statfs.h>
> +#include <sys/types.h>
> +
> +#include "../kselftest.h"
> +#include "vm_util.h"
> +
> +#define EPREFIX			" !!! "
> +#define BYTE_LENTH_IN_1G	0x40000000UL
> +#define BYTE_LENTH_IN_2M	0x200000UL
> +#define HUGETLB_1GB_STR		"1G"
> +#define HUGETLB_2MB_STR		"2M"
> +#define HUGETLB_FILL		0xab
> +
> +static const unsigned long offsets_1g[] = {0x200000, 0x400000, 0x800000};
> +static const unsigned long offsets_2m[] = {0x020000, 0x040000, 0x080000};
> +
> +static void *sigbus_addr;
> +static int sigbus_addr_lsb;
> +static bool expecting_sigbus;
> +static bool got_sigbus;
> +static bool was_mceerr;
> +
> +static int create_hugetlbfs_file(struct statfs *file_stat,
> +				 unsigned long hugepage_size)
> +{
> +	int fd;
> +	int flags = MFD_HUGETLB | MFD_MF_KEEP_UE_MAPPED;
> +
> +	if (hugepage_size == BYTE_LENTH_IN_2M)
> +		flags |= MFD_HUGE_2MB;
> +	else
> +		flags |= MFD_HUGE_1GB;
> +
> +	fd = memfd_create("hugetlb_tmp", flags);
> +	if (fd < 0)
> +		ksft_exit_fail_perror("Failed to memfd_create");
> +
> +	memset(file_stat, 0, sizeof(*file_stat));
> +	if (fstatfs(fd, file_stat)) {
> +		close(fd);
> +		ksft_exit_fail_perror("Failed to fstatfs");
> +	}
> +	if (file_stat->f_type != HUGETLBFS_MAGIC) {
> +		close(fd);
> +		ksft_exit_fail_msg("Not hugetlbfs file");
> +	}
> +
> +	ksft_print_msg("Created hugetlb_tmp file\n");
> +	ksft_print_msg("hugepagesize=%#lx\n", file_stat->f_bsize);
> +	if (file_stat->f_bsize != hugepage_size)
> +		ksft_exit_fail_msg("Hugepage size is not %#lx", hugepage_size);
> +
> +	return fd;
> +}
> +
> +/*
> + * SIGBUS handler for "do_hwpoison" thread that mapped and MADV_HWPOISON
> + */
> +static void sigbus_handler(int signo, siginfo_t *info, void *context)
> +{
> +	if (!expecting_sigbus)
> +		ksft_exit_fail_msg("unexpected sigbus with addr=%p",
> +				   info->si_addr);
> +
> +	got_sigbus = true;
> +	was_mceerr = (info->si_code == BUS_MCEERR_AO ||
> +		      info->si_code == BUS_MCEERR_AR);
> +	sigbus_addr = info->si_addr;
> +	sigbus_addr_lsb = info->si_addr_lsb;
> +}
> +
> +static void *do_hwpoison(void *hwpoison_addr)
> +{
> +	int hwpoison_size = getpagesize();
> +
> +	ksft_print_msg("MADV_HWPOISON hwpoison_addr=%p, len=%d\n",
> +		       hwpoison_addr, hwpoison_size);
> +	if (madvise(hwpoison_addr, hwpoison_size, MADV_HWPOISON) < 0)
> +		ksft_exit_fail_perror("Failed to MADV_HWPOISON");
> +
> +	pthread_exit(NULL);
> +}
> +
> +static void test_hwpoison_multiple_pages(unsigned char *start_addr,
> +					 unsigned long hugepage_size)
> +{
> +	pthread_t pthread;
> +	int ret;
> +	unsigned char *hwpoison_addr;
> +	const unsigned long *offsets;
> +	size_t offsets_count;
> +	size_t i;
> +
> +	if (hugepage_size == BYTE_LENTH_IN_2M) {
> +		offsets = offsets_2m;
> +		offsets_count = ARRAY_SIZE(offsets_2m);
> +	} else {
> +		offsets = offsets_1g;
> +		offsets_count = ARRAY_SIZE(offsets_1g);
> +	}
> +
> +	for (i = 0; i < offsets_count; ++i) {
> +		sigbus_addr = (void *)0xBADBADBAD;
> +		sigbus_addr_lsb = 0;
> +		was_mceerr = false;
> +		got_sigbus = false;
> +		expecting_sigbus = true;
> +		hwpoison_addr = start_addr + offsets[i];
> +
> +		ret = pthread_create(&pthread, NULL, &do_hwpoison, hwpoison_addr);
> +		if (ret)
> +			ksft_exit_fail_perror("Failed to create hwpoison thread");
> +
> +		ksft_print_msg("Created thread to hwpoison and access hwpoison_addr=%p\n",
> +			       hwpoison_addr);
> +
> +		pthread_join(pthread, NULL);
> +
> +		if (!got_sigbus)
> +			ksft_test_result_fail("Didn't get a SIGBUS\n");
> +		if (!was_mceerr)
> +			ksft_test_result_fail("Didn't get a BUS_MCEERR_A(R|O)\n");
> +		if (sigbus_addr != hwpoison_addr)
> +			ksft_test_result_fail("Incorrect address: got=%p, expected=%p\n",
> +					      sigbus_addr, hwpoison_addr);
> +		if (sigbus_addr_lsb != pshift())
> +			ksft_test_result_fail("Incorrect address LSB: got=%d, expected=%d\n",
> +					      sigbus_addr_lsb, pshift());
> +
> +		ksft_print_msg("Received expected and correct SIGBUS\n");
> +	}
> +}
> +
> +static int read_nr_hugepages(unsigned long hugepage_size,
> +			     unsigned long *nr_hugepages)
> +{
> +	char buffer[256] = {0};
> +	char cmd[256] = {0};
> +
> +	sprintf(cmd, "cat /sys/kernel/mm/hugepages/hugepages-%ldkB/nr_hugepages",
> +		hugepage_size);
> +	FILE *cmdfile = popen(cmd, "r");
> +
> +	if (cmdfile == NULL) {
> +		ksft_perror(EPREFIX "failed to popen nr_hugepages");
> +		return -1;
> +	}
> +
> +	if (!fgets(buffer, sizeof(buffer), cmdfile)) {
> +		ksft_perror(EPREFIX "failed to read nr_hugepages");
> +		pclose(cmdfile);
> +		return -1;
> +	}
> +
> +	*nr_hugepages = atoll(buffer);
> +	pclose(cmdfile);
> +	return 0;
> +}
> +
> +/*
> + * Main thread that drives the test.
> + */
> +static void test_main(int fd, unsigned long hugepage_size)
> +{
> +	unsigned char *map, *iter;
> +	struct sigaction new, old;
> +	const unsigned long hugepagesize_kb = hugepage_size / 1024;
> +	unsigned long nr_hugepages_before = 0;
> +	unsigned long nr_hugepages_after = 0;
> +	unsigned long nodemask = 1UL << 0;
> +	unsigned long len = hugepage_size * 4;
> +	int ret;
> +
> +	if (read_nr_hugepages(hugepagesize_kb, &nr_hugepages_before) != 0) {
> +		close(fd);
> +		ksft_exit_fail_msg("Failed to read nr_hugepages\n");
> +	}
> +	ksft_print_msg("NR hugepages before MADV_HWPOISON is %ld\n", nr_hugepages_before);
> +
> +	if (ftruncate(fd, len) < 0)
> +		ksft_exit_fail_perror("Failed to ftruncate");
> +
> +	ksft_print_msg("Allocated %#lx bytes to HugeTLB file\n", len);
> +
> +	map = mmap(NULL, len, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
> +	if (map == MAP_FAILED)
> +		ksft_exit_fail_msg("Failed to mmap");
> +
> +	ksft_print_msg("Created HugeTLB mapping: %p\n", map);
> +
> +	ret = mbind(map, len, MPOL_BIND, &nodemask, sizeof(nodemask) * 8,
> +		    MPOL_MF_STRICT | MPOL_MF_MOVE);
> +	if (ret < 0) {
> +		perror("mbind");
> +		ksft_exit_fail_msg("Failed to bind to node\n");
> +	}
> +
> +	memset(map, HUGETLB_FILL, len);
> +	ksft_print_msg("Memset every byte to 0xab\n");
> +
> +	new.sa_sigaction = &sigbus_handler;
> +	new.sa_flags = SA_SIGINFO;
> +	if (sigaction(SIGBUS, &new, &old) < 0)
> +		ksft_exit_fail_msg("Failed to setup SIGBUS handler");
> +
> +	ksft_print_msg("Setup SIGBUS handler successfully\n");
> +
> +	test_hwpoison_multiple_pages(map, hugepage_size);
> +
> +	/*
> +	 * Since MADV_HWPOISON doesn't corrupt the memory in hardware, and
> +	 * MFD_MF_KEEP_UE_MAPPED keeps the hugepage mapped, every byte should
> +	 * remain accessible and hold original data.
> +	 */
> +	expecting_sigbus = false;
> +	for (iter = map; iter < map + len; ++iter) {
> +		if (*iter != HUGETLB_FILL) {
> +			ksft_print_msg("At addr=%p: got=%#x, expected=%#x\n",
> +				       iter, *iter, HUGETLB_FILL);
> +			ksft_test_result_fail("Memory content corrupted\n");
> +			break;
> +		}
> +	}
> +	ksft_print_msg("Memory content all valid\n");
> +
> +	if (read_nr_hugepages(hugepagesize_kb, &nr_hugepages_after) != 0) {
> +		close(fd);
> +		ksft_exit_fail_msg("Failed to read nr_hugepages\n");
> +	}
> +
> +	/*
> +	 * After MADV_HWPOISON, hugepage should still be in HugeTLB pool.
> +	 */
> +	ksft_print_msg("NR hugepages after MADV_HWPOISON is %ld\n", nr_hugepages_after);
> +	if (nr_hugepages_before != nr_hugepages_after)
> +		ksft_test_result_fail("NR hugepages reduced by %ld after MADV_HWPOISON\n",
> +				      nr_hugepages_before - nr_hugepages_after);
> +
> +	/* End of the lifetime of the created HugeTLB memfd. */
> +	if (ftruncate(fd, 0) < 0)
> +		ksft_exit_fail_perror("Failed to ftruncate to 0");
> +	munmap(map, len);
> +	close(fd);
> +
> +	/*
> +	 * After freed by userspace, MADV_HWPOISON-ed hugepage should be
> +	 * dissolved into raw pages and removed from HugeTLB pool.
> +	 */
> +	if (read_nr_hugepages(hugepagesize_kb, &nr_hugepages_after) != 0) {
> +		close(fd);
> +		ksft_exit_fail_msg("Failed to read nr_hugepages\n");
> +	}
> +	ksft_print_msg("NR hugepages after closure is %ld\n", nr_hugepages_after);
> +	if (nr_hugepages_before != nr_hugepages_after + 1)
> +		ksft_test_result_fail("NR hugepages is not reduced after memfd closure\n");
> +
> +	ksft_test_result_pass("All done\n");
> +}
> +
> +static unsigned long parse_hugepage_size(char *argv)
> +{
> +	if (strncasecmp(argv, HUGETLB_1GB_STR, strlen(HUGETLB_1GB_STR)) == 0)
> +		return BYTE_LENTH_IN_1G;
> +
> +	if (strncasecmp(argv, HUGETLB_2MB_STR, strlen(HUGETLB_2MB_STR)) == 0)
> +		return BYTE_LENTH_IN_2M;
> +
> +	ksft_print_msg("Please provide valid hugepage_size: 1G or 2M\n");
> +	assert(false);
> +}
> +
> +int main(int argc, char **argv)
> +{
> +	int fd;
> +	struct statfs file_stat;
> +	unsigned long hugepage_size;
> +
> +	if (argc != 2) {
> +		ksft_print_msg("Usage: %s <hugepage_size=1G|2M>\n", argv[0]);
> +		return -EINVAL;
> +	}
> +
> +	ksft_print_header();
> +	ksft_set_plan(1);
> +
> +	hugepage_size = parse_hugepage_size(argv[1]);
> +	fd = create_hugetlbfs_file(&file_stat, hugepage_size);
> +	test_main(fd, hugepage_size);
> +
> +	ksft_finished();
> +}


