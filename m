Return-Path: <linux-fsdevel+bounces-29992-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E269B984B53
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 20:49:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 106BE1C22F60
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 18:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34CBD1AC892;
	Tue, 24 Sep 2024 18:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="htBhhrz1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YR0zyTp5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93AA1E49B;
	Tue, 24 Sep 2024 18:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727203733; cv=fail; b=AdERyQ7XkclACzrYMpOHZyqVNYa6KWLt8tFM89/hOatboXX0ey03ZXe0xKwKOTAWpj4Cfye9g33lbF2pqMCJnMHDv5JEhIUNk6TMQIGKKQzDvRvg1jxLcj+b4Z+UZl4w9XuQ1zXyknmDhoMn54d1GCXw8D5Ly6PhSOKwcitC6rQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727203733; c=relaxed/simple;
	bh=o0Ux4cEjsJ12k9M0lEvrKZwts0ZRMsY3SrypZJwDZN0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dZNuVGIRCtGTC48VmMss2GreskHByM1v7cSG7KThu2IhALYq7HP/zPIRCB9M+clq+mKPaX+VKE/VAx93uvR/7OTHCYRJhVcy7o0DPF3NvM2zyd+Al7Tai6R4/w/B0hLgDWT7aO32TOnIufIIq+fXvnj0J7qn7m1MNO5OkNFGzMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=htBhhrz1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YR0zyTp5; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48OHMXuO020475;
	Tue, 24 Sep 2024 18:48:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=fxAByew24QRQ8R7hbudPN0zJmqyDx06uMrZsvRJJL2I=; b=
	htBhhrz1uVyfpkrFVMPGc6tZAf1ouOv6uMOKQB2YCkRVDJm7uQdrm4JyM+7ecGLG
	UgZDEq8OHzab0gGJOXxn4/hJUqFLjR/UH6nmUaQDFbCM3wZmpF8/1Zt/bdbkgPtZ
	Gz+hSdCeOZMG8ZQTrdVUxN4FInrdbhNGR6MLEv13JGA1Cov8stQMVkm7WKnaMIXy
	MVve8Qzwm932xO8RxmDgNdfR+jf6cdLIDbZUoh6H6ObN6/jw3cpFjPd+NYjyXcFZ
	biiLYU6oV3hzwbaTxZX6wBV1yOCoSQPrzBvpN7wFpeCjcJ9+9lcAKxRYcx3l51F7
	EdsqP5szwaGOTg9/Fi0eiw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41snrt5t7r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Sep 2024 18:48:38 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48OIQi3q025153;
	Tue, 24 Sep 2024 18:48:37 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41smk9pb0m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Sep 2024 18:48:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qKhXiA9FTlKi3un7J0up7oEdPp49fVZpWPCDhJ7/3xkC3a/hz40gJv3Az/LgBx42i41onRC2suT5ITbrJ8g+E/Wj09zWNoOF19AXrww3katACVLzCVrbqtFVwRUuPEHCuRCYImid1hEjCvhyTbEej8xGnYtdOobp3UNBX7VI7uwMPBcrRCNOHMlCEuzdJylUNMOyS1EKkl5EltYsRJf98ls2tKDmLLi8Db3tWLO3aVhcpcOthGgeRFE40DCDtHRjolY7TubZdx6LSbMSy0+iBzUfY6H/h0urAxtfEsv4d5GFhp0qKh6OmWo2bKnk5z76hG++RHRcKcvHAg/4VCVy0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fxAByew24QRQ8R7hbudPN0zJmqyDx06uMrZsvRJJL2I=;
 b=rOVChP9jE7x3NnLC/M0Ry/5K5F8Aoz+Snx/2QnklzDucCoLVl2hjmDUO4nx4U0Eq4HXdcm6KwqVvopUHfPAWj2+1cgAsY1QGsUCbHzehBkJKQQ/xbH4v9QqPxt5T34LygG2mN+CsSIgLpQ/J07aTv7F0vhA5V2Q+fvdWkazBLbxVy6RmZWAp11iGyt/KXdU7KM2CRQKJ7Nw6BHa+hEsjGOTXsXRCRPclZDzMcXv0Rp7trA6khcTpCtQxNTQjiHl0pouBQD6ygY5ofKUe8n31Nu9yv0/5PJM2xr5vy6f5WQ+yYzhN96EgbxYNnF+kLhpzCbr+Qpr/DLSKlM0x4INuzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fxAByew24QRQ8R7hbudPN0zJmqyDx06uMrZsvRJJL2I=;
 b=YR0zyTp5GASqblwpqphp9o6HpQEkb298WcyqYizIhkSCv6dBUknnOnFfMytADtz/hTNztYbW4JEj05gClCIxuspeg6VjzGY9Ql8QHorWPHQvpp2ekdbF40H7opTGDS0Dm7WA1CFJoG/t/vgI6hthXC1INHwBSiklyd+GwTgDcaI=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by SJ0PR10MB4718.namprd10.prod.outlook.com (2603:10b6:a03:2dd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.13; Tue, 24 Sep
 2024 18:48:31 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2%6]) with mapi id 15.20.8005.010; Tue, 24 Sep 2024
 18:48:31 +0000
Message-ID: <8a46bebd-46bb-4d82-b4c7-870fee0195b5@oracle.com>
Date: Tue, 24 Sep 2024 13:48:27 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools: fix shared radix-tree build
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org
References: <20240924180724.112169-1-lorenzo.stoakes@oracle.com>
Content-Language: en-US
From: Sid Kumar <sidhartha.kumar@oracle.com>
In-Reply-To: <20240924180724.112169-1-lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0114.namprd05.prod.outlook.com
 (2603:10b6:a03:334::29) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|SJ0PR10MB4718:EE_
X-MS-Office365-Filtering-Correlation-Id: ccff7c0e-3d32-42af-1bb7-08dcdcc97c54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V0twVHcwcUlzNzhGMlVSRzNObm9WMks3bk5mTUJtWjNPM2FJcVJ2T3l0d0kz?=
 =?utf-8?B?akh5YlpHdDRMelRCczFUcDBFN2tkUGhqdkxod25CZnpWcnZqMi9RTE9vNm8y?=
 =?utf-8?B?Y2ZPcU1HRm9pbDZjYTVnOVlwdnhXOWRvckV3OENpL3BIdWphMnd5QkN0S0NL?=
 =?utf-8?B?cjJhQVA1TDhxczc5bjU4S21QMm53QysrRTBHMFc4N1NFRytZU2R3V2tRcUtn?=
 =?utf-8?B?S3VmSUhRaEV2dXM5a2w1em16d3FOaW5uMjhUN25ITHliZ2NkQ3hHMndxTnM3?=
 =?utf-8?B?NmRXYUM3cjA3S1JnbEZTOHlFVGVGcldkQ3V3RVV3dnEwYnlQWm9MZnR5MnJp?=
 =?utf-8?B?MEN6dWJMSnl1cWYyNE5JYk15QTlxNndKd2c5aXZVV1VhUHVOZGtsMjlVTVUr?=
 =?utf-8?B?OWJTZktpNGRVNlU5anY0aFNjSy9VV29HT2lyL1lmNGxuYTNGTVJrU0JQd0FD?=
 =?utf-8?B?K2VSTC9PT2hydXR3WExFTHBpMDdTM2tORFhMSXlsa0wyd2hQSHl1UWNyUmp4?=
 =?utf-8?B?WEwwcWJSbk03WW85cnRrcllvZFdGWHYwdUQ2TXU3RHZCS3l0TUszTzFITHB0?=
 =?utf-8?B?RGRWYzI4akREazVQS1lCQ20zYmFqb3JyUmY2VG5FVUpnaWNQZW9iSm1Qb2Vt?=
 =?utf-8?B?aFBra1dQVzJaOWpLV0kzc3NIVG9iSUY2TTE5SjVQT3MwR0k3alZXdi83MFMw?=
 =?utf-8?B?UC9RQU9yM1ZHSCs1SndyZ2xJUFp5a283RGZYOTNtVk0rdVRHYmtYQ0tpazBw?=
 =?utf-8?B?bzYrM1ZMMDArL3lYcHRycnMxMDZsdXE5Z2ZIUXVDVjZZR2JKNFNxVEhpM0Ja?=
 =?utf-8?B?UFFMY3BhL0ZUYUg4cWE2Q01jWEhic3o0eFVlZzdFZWp4TDB1Y1hXd3JKbG1B?=
 =?utf-8?B?RnFGUit6aUE1OVh1dnVkTzlxY3p5V2ZXd2kzVytMUGdCeG9aNVdXVWpDcEI5?=
 =?utf-8?B?dGs3R3lJRUd2TDFOdHMydlh2Zzhsd2dTRkJ4cHM0M3JzS0w5aGI5a1J2bGlH?=
 =?utf-8?B?ME8rbXBmanZMNEJoUDlwL0FhSkdqR1UvQmhQaUdyUjE0dXFBWDhsNGpUS202?=
 =?utf-8?B?U1MzdjdtbCsyL1NyVUNLS3pJeEIvZmNiVEV4eEFSRkNPNEMvYTQxV0hPY2Ri?=
 =?utf-8?B?WEpGQ0xvUHBlMUlkK0IzK1lzZE1oeVM4OFMyb1UyblpMUE5pQXpGcUxHOUUz?=
 =?utf-8?B?dXNYeGYyd1JkRjd1Wk5yeEpvdzQrZ0tiMGRqVTlSWlN6TEcwZ1hkQ2o2Ukpm?=
 =?utf-8?B?cXZqNUxZNFZXUFA3cVcyRG9ac1VOVzd5RkM2K0JtdmJROFk1aEVGbDlxUkpI?=
 =?utf-8?B?blJ6RGlIRUw4WWdjelJaNk1PTUY5ZjRmRHhzMFZxQ0lEMnRTMGhtUnR6WWxB?=
 =?utf-8?B?d0xIYVd4U3plZUgvUHVpaUZxR1Bma0NKaWpmNE1PL29raTNvMWFxZ2xRSzMr?=
 =?utf-8?B?TXdPd0d0ZzVXOW52SnFubkowc2Y5elBFRHdvSWRYMlJwNFlybDZPdHMzNU1Y?=
 =?utf-8?B?Qk01WE1ESUdmV25HSndqMUVwMUkvYStLU1d6QlZuSWFvSXlVWDhEQXphUXly?=
 =?utf-8?B?RVEzK3l0NURZK0h0SWYxY1dob1BsTmF6VFUvZG9qNmlpMUNqckNsYXZqNi9H?=
 =?utf-8?B?a3VKNjhIUmNhTVZpNUIvNkhmUEJQbFZENHR2eGF3VW5OdVdEM2l3d1lRYzky?=
 =?utf-8?B?U1FwN2lwM3UyTnJkNnhxOEpzUmZOZXpkQ1dyK3dEU2xqNjR0aHV0d0V3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MVpFYzN6cHh1NmM0VXRwL2RvYVRKWmtuS083MG9RT2FpRjE5aHRPV250MER2?=
 =?utf-8?B?Vm5CWkJlQkFCR3JqVTg2T3hMS0MweWlwN1lHNmIzcVVGaGMwTnBaVThrR1NK?=
 =?utf-8?B?dmFRdHZLeVdvUDVqd0Zkbmh2NU94eUFUNGkwSkc1bzFzckdrZkZ6R3hsaDZE?=
 =?utf-8?B?UkZqaExudDZsZmN3ekxNeCsxTzMvMU9FVzdhbXpoZmszUlB3Umpnc1NRdW14?=
 =?utf-8?B?Qk9YK1o2djV2aGhBaXhOc2Q5TUI1TGlkemx5bVVKR2VYS2svOVR2a3BlOEl4?=
 =?utf-8?B?RWwwS2VSMjJlRnVjOGd6YXRoZE9aUU9IcVBYcVdWZXlyUXhpcW1YWkh2N3JX?=
 =?utf-8?B?WFdSNnIxZnZuWjY0VDkwOVZpRVpMbENhREtMbmdLY2JlM2hnbi9aL0xwaHEv?=
 =?utf-8?B?WW9LRmQ1b0JIWDlXZFc4NWdJb2M3VVBVQnB0VU1qSk53U1hEK2pCNnl5Lzd6?=
 =?utf-8?B?R1B1Y1lDNy8zWEQ3ZWZsZXNmdTY4ZnV3S3BHbTZTNy9kWW9LYVBHcE9FYmRZ?=
 =?utf-8?B?alhoRDVNYjdVU3U2NHBJUDJTb2liUVhZOU5oZ2drMFpYUEc3Vm54TjV5ODJp?=
 =?utf-8?B?djFFYXNLRVBGaDVQL1ZZZWRpYUV1WTdHcmxybU0rVVBVU2tsRG1JTUtPMCtu?=
 =?utf-8?B?U3NQYnlFc3N6SUJodWNSYkVjVUhYUklCUEhrcitPRlVCUlVqbENOWVZwc0VF?=
 =?utf-8?B?OG0vazlKZzBHNndwREtoSmQvdWVQK3QzNUM2QTVmUkdOa3U2Q0xXRWNHTFF1?=
 =?utf-8?B?VmFwUVZTRUhjT3cwZC8zOFlsRE1MSlp1NysvNHhxTGllUkxQUnhaNi8xUWJt?=
 =?utf-8?B?YS95Ykdud2JtNHhGcUNBSGdnVENwUkNLSzNPWXlneXRGMjJaeDJraVc2Q3E2?=
 =?utf-8?B?R0I5bjAvdWhBUlcrTnRnNUpkTGEyMTFuMExxM0Zydi9YbHdBMHpabCtWYXZX?=
 =?utf-8?B?NzFEcVl5ZTQzNG9xS2lvRnN6ZldLY2Jya1NUYlg4K2puTlNEMmhyR21pZkdy?=
 =?utf-8?B?K3plRWF4U0xJQ1pFRTdMUlIzWDN2Wmp1VmJMczhLalRJckx6cDhwQW9nb1hr?=
 =?utf-8?B?dTZ4d3lMUVhTNlpxc0M0N1pmT3hYdkkxazFiQ0JMNzY5d3o0ZllhQ0J4Uk5s?=
 =?utf-8?B?dE04d1VOazVuUm4vK2llckhOWVR0aVRpMk5RYlJwTXpUWlNNejRqanFNMnB3?=
 =?utf-8?B?VkowS0xVSUJFSHpPWnJNcmxFYzE3SGIyU0c3R2RKME5xZWloZ3VVVlN6a3Ji?=
 =?utf-8?B?dFU0emNMWmNEVnBHVmxvc2hML3I1dXR4WXFPdUJjTTZoQUxpbVJQM09aVytp?=
 =?utf-8?B?MHpkU05MTE5Cd2dUeGtxY0dMUmcveDF3QWVEczlkM1pOUGREbTZkTzJMRWdR?=
 =?utf-8?B?SjY0L3ZEWWNDODNnL1IrQXI0MkNkZGIrR1BwejVuUEJRR3FtQXY1OVRTQ09a?=
 =?utf-8?B?d2M5enNrRkozT1hiTUdGdFNOMzEzSUJ1ZDdyUVEvUGdSUnBUMkxEUXpxVERn?=
 =?utf-8?B?ZnZTNU1uYldiR29XUk8wT2hpOUUveURZZ3VQZU1yemx0dDRuSzhqOFYxVmla?=
 =?utf-8?B?NHRwZ1JjSEx2aHpoWEdOdUVZVEtMVG5qZlVyZlBndWxwVWtMamJuMldpMzFx?=
 =?utf-8?B?NE5JcU1iYUIzOFJ4b2p0SVFFcGhHLzJHaUNpZlB1dTFSOUlJTjgxb1MyZEti?=
 =?utf-8?B?aVhvcUswWTk3WmZBRjBGWmpGNUp4RGVVTVN6RWFVY1BZWDJoMlRPQUdqeUxu?=
 =?utf-8?B?dFNSeFVzOWtpOElaTWZ6RU81WEZWQWloeXVrNk5DZXdTejhyNnVyWndVNnln?=
 =?utf-8?B?YWFKaUc3bEF0eStWU1FVcmp4Vjcxbys0NDRSMnBBUC9nSm5oT3EyQmR6SWx2?=
 =?utf-8?B?STJQMmtxb2JVRU0wTlAvVmNHc2s5UGdFcVNWMWdCRXNVZDBWU1kvT0w2OXVP?=
 =?utf-8?B?d2xSbEp3UWEyQjhSMlpiazN1QVZKTXV3ZXA4bEkxZElzUm8wNkR4NFgyQ2w3?=
 =?utf-8?B?UEpac0VEOHFOOTU3VXlNb05vMmpjTUFPaXVXY1pFMWpKZlpEaEt0bkJ5Y1U2?=
 =?utf-8?B?UlF4WjZBSUZqZlhNRlNMaXJpY0d0MDFHWVYzM29wQloxb3JBSDhhaFFlSGFO?=
 =?utf-8?B?OWRGWElQek9JU0FPT0VmOVI2U0M3WW85Mkhna3pxRFBZUWd5R3A1SDV5K3hU?=
 =?utf-8?B?aFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	DQpCKt+MbJhGGdrHeiQia4r5iJ6jZAMiJz7Bj8bYk16vVIy/t9Dn4wGdVI6e7IqAiV8Tr4S6CwsMM0OCQvPf6Ax0RbUHW8YvKB+4pQYn0TmtPCqkkboIghSO3/oWFTlMeCnULdb+0shTHPdg1Sf8eZqcUEtGYrHQuCLJjFstsutFivxc3lven0WdOuYqfS06Nw0y8yPEkxLfH4BJu5bqxpbDfehIMxqlhD2c+4MabNkZYfi+AfkKj+Qaj0xarKLtPXTG+6Sa3619biS5yzYM1Cj9jsTUQ79QBpd7KQdvjlA0CRzPEcdkzwR6P/bppbaqVYRj4KQhzQ1VQaL6L7FE97uagwKZcVv9AdGD1YdUSwb6LBDSHoA6hW98M9eN+/OKstVU4E/b7Ggon3zfNV8P7RS92CTVwphT1QX3fTLT8+7QJGGWfcHMvsO6KF9k2ipziwh9Dx5FZjXG/UabgyKdwgMFoNLqwEmdVndrBdA+ONhCD2W5ETZ63pnAq5CSMQ/E2N1aBPP89vq/D00rmmtbFs3F6uTRrZJgEB4k1Tzt1T0jVuZJ1SWwv/z9JyLNcEk7y9Jqs88Un1dsopyFS6pexZTT07YNNo//nVRAtl1pCfE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccff7c0e-3d32-42af-1bb7-08dcdcc97c54
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 18:48:31.4451
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fSzSggJ4zgoN6WO1bEaMX6cjv7xZoaby0fFr75gEkXP8IZMYj/zuw7DQ0Bj4pqdtZ0UP0vHjUYbMN5OlzQHiep2n/3sReIC2Kzk5ue25RMg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4718
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-24_02,2024-09-24_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 mlxscore=0 bulkscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409240133
X-Proofpoint-GUID: JIaB3N_cirIBR0ykrX36s9EblLSN5jMS
X-Proofpoint-ORIG-GUID: JIaB3N_cirIBR0ykrX36s9EblLSN5jMS


On 9/24/24 1:07 PM, Lorenzo Stoakes wrote:
> The shared radix-tree build is not correctly recompiling when
> lib/maple_tree.c and lib/test_maple_tree.c are modified - fix this by
> adding these core components to the SHARED_DEPS list.
>
> Additionally, add missing header guards to shared header files.
>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Tested-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>

> ---
>   tools/testing/shared/maple-shared.h  | 4 ++++
>   tools/testing/shared/shared.h        | 4 ++++
>   tools/testing/shared/shared.mk       | 4 +++-
>   tools/testing/shared/xarray-shared.h | 4 ++++
>   4 files changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/shared/maple-shared.h b/tools/testing/shared/maple-shared.h
> index 3d847edd149d..dc4d30f3860b 100644
> --- a/tools/testing/shared/maple-shared.h
> +++ b/tools/testing/shared/maple-shared.h
> @@ -1,4 +1,6 @@
>   /* SPDX-License-Identifier: GPL-2.0+ */
> +#ifndef __MAPLE_SHARED_H__
> +#define __MAPLE_SHARED_H__
>   
>   #define CONFIG_DEBUG_MAPLE_TREE
>   #define CONFIG_MAPLE_SEARCH
> @@ -7,3 +9,5 @@
>   #include <stdlib.h>
>   #include <time.h>
>   #include "linux/init.h"
> +
> +#endif /* __MAPLE_SHARED_H__ */
> diff --git a/tools/testing/shared/shared.h b/tools/testing/shared/shared.h
> index f08f683812ad..13fb4d39966b 100644
> --- a/tools/testing/shared/shared.h
> +++ b/tools/testing/shared/shared.h
> @@ -1,4 +1,6 @@
>   /* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __SHARED_H__
> +#define __SHARED_H__
>   
>   #include <linux/types.h>
>   #include <linux/bug.h>
> @@ -31,3 +33,5 @@
>   #ifndef dump_stack
>   #define dump_stack()	assert(0)
>   #endif
> +
> +#endif /* __SHARED_H__ */
> diff --git a/tools/testing/shared/shared.mk b/tools/testing/shared/shared.mk
> index a05f0588513a..a6bc51d0b0bf 100644
> --- a/tools/testing/shared/shared.mk
> +++ b/tools/testing/shared/shared.mk
> @@ -15,7 +15,9 @@ SHARED_DEPS = Makefile ../shared/shared.mk ../shared/*.h generated/map-shift.h \
>   	../../../include/linux/maple_tree.h \
>   	../../../include/linux/radix-tree.h \
>   	../../../lib/radix-tree.h \
> -	../../../include/linux/idr.h
> +	../../../include/linux/idr.h \
> +	../../../lib/maple_tree.c \
> +	../../../lib/test_maple_tree.c
>   
>   ifndef SHIFT
>   	SHIFT=3
> diff --git a/tools/testing/shared/xarray-shared.h b/tools/testing/shared/xarray-shared.h
> index ac2d16ff53ae..d50de7884803 100644
> --- a/tools/testing/shared/xarray-shared.h
> +++ b/tools/testing/shared/xarray-shared.h
> @@ -1,4 +1,8 @@
>   /* SPDX-License-Identifier: GPL-2.0+ */
> +#ifndef __XARRAY_SHARED_H__
> +#define __XARRAY_SHARED_H__
>   
>   #define XA_DEBUG
>   #include "shared.h"
> +
> +#endif /* __XARRAY_SHARED_H__ */

