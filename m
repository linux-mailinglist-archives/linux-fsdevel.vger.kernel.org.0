Return-Path: <linux-fsdevel+bounces-77837-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4MD5Cn32mGlKOgMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77837-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Feb 2026 01:04:13 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 93FB716B7EA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Feb 2026 01:04:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B508F30466A3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Feb 2026 00:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 030C48F4A;
	Sat, 21 Feb 2026 00:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YXNKEkE3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="G40qZOnc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04AD5256D
	for <linux-fsdevel@vger.kernel.org>; Sat, 21 Feb 2026 00:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771632220; cv=fail; b=UoqS0xTMli9IqH07EDCBdsX9edV242iSQH1xJkcr1Lutv1dO9WYvmf2cZ3ViA7TD1O1vF/pvtf3aC4/RWcU6mhExVRU9yAIsxLvbBSxCmLUT6VH13+BYvmLOsviC6uTN6YvvlC0aPjN/AEezhh3AzgiAD49YVAq1kesiGux8N8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771632220; c=relaxed/simple;
	bh=gxipCL8fGdxa/LdwZq4Eu2K/43QOjbCrgB+mc+FymaU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PNNMEdPveIUXAhT6SzEhwaWdEUF6xR1NRrXqDGD8TSKdVVcgT+hAkjpljkMNhQrJ0shSfZzuAsTHNh6YlSedp8Q6HA+Hsn+SmLxyj+6RL7Pk82yRq8O5gTTa6Q2C0m7qTmq0ezlM6t7JWFPa+GxH5kSSdkryVuO87zWKsGxjT3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YXNKEkE3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=G40qZOnc; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61KDVhMN1058908;
	Sat, 21 Feb 2026 00:03:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=ASgeIk2k541hJ20KLjB1qt4DyHfIrx7JHooj2UWlgyQ=; b=
	YXNKEkE3gFFODqIn5OjzpjghAKTtefcctGoF9VBS7I6iZMif13uXZVTIGZDV1VuG
	nRM+qYw08M0e6fZcGmKsmLHvaRt47G97oAbrPgoBc7lyMFk/tadAXKOi1nVXL1Lb
	lJrrN9izPDx1SHs6qycWiTr2XW6x/SgiL67fDenSHAxNCRQ7+4gwIPa4RQO6YksW
	Di9BAfy6XEmQa7dNISQzmY1cmcAgWeSAfWmqgSPprqSxIf/rdeSyHOQUR/MvHnha
	y/pnS+LZ4cBMnlGEE3rwqsTwDDHwIcnUK/ATaXYxJtIx4WAi4XNPBpBGQ8ok9nC8
	iaCwChU9ggL7M6YZ9YzA9A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4caj5ra8q8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 21 Feb 2026 00:03:20 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61KMPTms015015;
	Sat, 21 Feb 2026 00:03:19 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012027.outbound.protection.outlook.com [52.101.48.27])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ccb26nq9x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 21 Feb 2026 00:03:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s0+zTOZw2djpVYPwVct+k4wtlicpqJspOOl7CBg+GvFiIyF2NfU93E7GqGW+23ryMCC179lNDZ5XHtxP+htBG471C+GT4dWjENPFlidkj/cm3YMqDFcJSYSYJiEVP2GoLhwwOGTCROaT1vx0hGDGihQmUmEBvwizWzAVc1Td31kyxVqpXkglSINEmwYSyIIp+zUdxHBQMHIBhXiKJZ0M5ZuVa2adt8asI18Pg99f7Bj4TC9nfquWabdoTrdNgP9Rfz3JRMjbZHUmhIOc954iL6nhZn74NPjXY/MUVsAYgGYzCd7+96bc5FmK9gLdVIAdUoCTVlNQgA0z2WkOeSBfug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ASgeIk2k541hJ20KLjB1qt4DyHfIrx7JHooj2UWlgyQ=;
 b=jiwox0gcXB6pZ5nNzrN1St+zrjQDw/f8D5gqYUZPDoZ12b69h2ohU/JQdgSUVgzV81ta+tcz30gUY9yAgS4jQfuNScABY5/KJXRq1ZLBmqMYCCvjt0Hug4DcF13nEKPG/ONIEC9tl+cV0Q1Z7TGiE0dcU6y+JFZuCwtERqxQBqafsgJmdVfLr19xzl424TZySk1Xize4vg92E8PfhZqJRGZ8W1uD6GS7Q3ARyyRNDaoNxcQtavvrHp6MmrlC5vw5oPZl2qiHAJ7OsUV7qsS+MnX8KTrqtLXewQuHP6KJDlG8jxusi8hEP0YxmoM/uL5F8IWsnzkIbYrBKIMn8jkagg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ASgeIk2k541hJ20KLjB1qt4DyHfIrx7JHooj2UWlgyQ=;
 b=G40qZOnctPjsSzaIeGqDanD6DI1ydYMUnYFX23ze3+iVuFOM7cNmc8uq/fA9j5qYJDvq9Xv4cf+OLeYlt6jClMsWJB39JGkz3dVuB2Nooh2HpVgYL+M8RuXajBmwu6W249k8S4os3/OeQOO4LRuJLPQgWLTI2xUyxpA0IRQbRho=
Received: from IA0PR10MB7369.namprd10.prod.outlook.com (2603:10b6:208:40e::14)
 by CY5PR10MB6239.namprd10.prod.outlook.com (2603:10b6:930:41::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.15; Sat, 21 Feb
 2026 00:03:16 +0000
Received: from IA0PR10MB7369.namprd10.prod.outlook.com
 ([fe80::bef9:7d0a:4382:978e]) by IA0PR10MB7369.namprd10.prod.outlook.com
 ([fe80::bef9:7d0a:4382:978e%2]) with mapi id 15.20.9632.015; Sat, 21 Feb 2026
 00:03:16 +0000
Message-ID: <5b1a9670-1b07-4a61-8623-dcbf116be762@oracle.com>
Date: Fri, 20 Feb 2026 16:03:14 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] smaps: Report correct page sizes with THP
To: Andi Kleen <ak@linux.intel.com>, linux-mm@kvack.org
Cc: linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org,
        willy@infradead.org
References: <20260209201731.231667-1-ak@linux.intel.com>
Content-Language: en-US
From: jane.chu@oracle.com
In-Reply-To: <20260209201731.231667-1-ak@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR20CA0012.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::25) To IA0PR10MB7369.namprd10.prod.outlook.com
 (2603:10b6:208:40e::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR10MB7369:EE_|CY5PR10MB6239:EE_
X-MS-Office365-Filtering-Correlation-Id: b9401ccb-1612-4981-fa40-08de70dc9d0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SzVYeHp1UVVFMi8yQWJFRGZjakFXMTU2OGl4RStjTzVheUdhaW1oRXpJb0VK?=
 =?utf-8?B?MkFNOHZ4bk1VaFlTWktRRGdxR202b05memtzellCdytZTUFBRU5FVlBhL2lW?=
 =?utf-8?B?bGhwT3JUYjg1bkh6UXhud1Q4Q09tUXdyaEN6L1EwTnZDclpOUEQxM2svWVh2?=
 =?utf-8?B?VUxZTEEzcXVkS0ZndFA0RzhKWi9Ua0o4bTlmcVBod1k1YklqTUVkYXZseXRt?=
 =?utf-8?B?Y2lmMENrT3lNYkxJdzZOL1dsSGc5SmhEMDc3VkYwTUtGVzhNUThtTldySnpj?=
 =?utf-8?B?S3RDS1RsbGhvS3pzVmZmQjIvMnNwd3crdXFBL1VlUG5TemFELzUxT09aMFJr?=
 =?utf-8?B?b3pleDVsTC9GcEZxbVVNNTZVNW84dnJybklBSjdEeHMzQ3VFakNza2hWSi9J?=
 =?utf-8?B?dktCeGtUYXN6ZzhmVG9NdyttSjJTeUlEclJBbXhPdHZNKy9TTXl5UzFFNjVB?=
 =?utf-8?B?NEI5Y0tNY1dKU3JqNmZlOEk0dGlnaXJkRTFvUUtsQU9xZENWbjdqQlZLOWQ1?=
 =?utf-8?B?VDluaUVMdEFxLzdacWo5YkIyT0dzN1RaZlF3L2dSRUxIVlhHYU9rMHgxZlVC?=
 =?utf-8?B?akQ2OFpqWW0rQW5kNlNrTWVBd0R1Q3RtL1lmVldGVGJCZnVUOXhjcXJaaDds?=
 =?utf-8?B?WEp2TmhZOVNDZXgwTjFsc3ZvSmhSb211eTBFakdOdTZqekxLeTd6SVJ1NlBa?=
 =?utf-8?B?L2w4VXd1WUpIbWw0M2txcFVlNUhJM2kzMWJaTUJMallQQ3YrVU9zNDRkMTdM?=
 =?utf-8?B?OFNjWnJRUUMwQWlJQ24vSWpKOTVEd2lSN0Z1S1ZzK04vK0xWUzBBY21UOXdU?=
 =?utf-8?B?RWR2ZkNWZWl1UkJQVzlwVzBOeTlXNzRuL1lYREd1REdQKytCY1JLeldJeG9r?=
 =?utf-8?B?VUhxNjE5QW1FbUtXWWNaODQ3MmJBeDVkZkxZVFpxT0F2Tkozb09OV3B1UlJl?=
 =?utf-8?B?anc5MTJOZGUvZ1NEbmZod2kzbk8yZXJGTzdaQXIzN1I3R0E4N0luZFZYbWpz?=
 =?utf-8?B?ekErRGtLV3FxcENvNlpMRWwyL1E1U3FPVGphdU13VjJCK3hCZytSWjJnL2g5?=
 =?utf-8?B?QXZiTW1iUmlSOU5iSnE2b2lFbi9pUHkzazI5c2p2RWU1VTJWUy9QWHFqN0FP?=
 =?utf-8?B?NUtXS3VtaFVSSVdwM0xBVVlTbUdMdWtMZG1jRlpGalV3MVluZU1ESTd2bTR6?=
 =?utf-8?B?cjN4TmpDMzdtL0lUVjVQQ1RzRVIxUkt6VVM5d05CNXNoNHBqSFJyenhQRDhI?=
 =?utf-8?B?dmFCMFVtTElocWZIbEFoa0tNbnRIcHFuSndVbFd5UVRLeFErd0l3NjhvaXpG?=
 =?utf-8?B?Y2pNSmx0NjFIUGNKalBLQXR1ZWczYzMvendzUGcvUXlXRlZSaVVBd0N2ay92?=
 =?utf-8?B?KzRjSC85eFBUb0ZVODk5R1dsSUtMZlVkV1Jmb3VCUmJYWjczZGFYSWRTNVVL?=
 =?utf-8?B?ODBDQzZHZjVrZUlEL2pNZnc2NkRQL1FBMDJvc1VBR0pHb09NRm1vcW5xOExW?=
 =?utf-8?B?NWpqUWxrRC9BSmFQcWl0Z3JVTzdSU0lNK1RQekVGbXJVWWdBbFFXUFlMMXR6?=
 =?utf-8?B?KzRKbzlCckQyTlNkS2h3TC9UcFdyaVgyTlpBRTZVZnpxenNqditpd3N3TVUz?=
 =?utf-8?B?K2FzMkpzbThZcWxYS2FkR0M0UDFVUUp3c1dueFZwVzVuMGpUTHdUS20yTTFw?=
 =?utf-8?B?eE9vY0xkSkRyL3ZKVTQ2dzFpNWViWk5LKzhydzlBblRpUnVtMUlsenJIUk03?=
 =?utf-8?B?WDAyclNmVXNOUFN0NGFHeEczZUVIa0Y1WEE5UG1HaWRBQmlwYm9yVVJqNGNM?=
 =?utf-8?B?bDV1cGs3UjlEaUtteGU0SkpYVEEyZ0F2dy82RUJ6UGQ5T1hwUVlqcG1lZVNw?=
 =?utf-8?B?R1ZhelFHaVdUUTBLcCsxQkdHelFwc1JqUWh0NVVpMGdvTGNtUng5OTRGbVJq?=
 =?utf-8?B?VVUzbE9tcml6OGUrRXU4c3BnVThSUUx4ME04cUEzckgrYTh1dVpxZVdBcFBt?=
 =?utf-8?B?WndLUnJMYzFmZWpEMkMvb1NPRkFtdHJlcStJUkdoalhBaHJwMm1WZGkxVW8x?=
 =?utf-8?B?cmlJcVUrNHovK0xNL21wd3VOME9PUzlMZ3hGRFgrQkJFV3BFc1BZZHR4UmdQ?=
 =?utf-8?Q?KX9s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR10MB7369.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NUVpa1JveTgrMVhDSkZVWWJmUzRBek9FdnhsQ3FQcUVQOVdYcnlFb2lIOXJo?=
 =?utf-8?B?RGxWZm9LVm40cGZGeElOWHROVzMzK000UUl2UTNLVDJsbXdRQ052N3BjNnVi?=
 =?utf-8?B?U1kxMDhIVnYyQzZzZ25melZ1TlBEdDdKN2JGTlc2MzJiMkg3SVYzSVVTV1h4?=
 =?utf-8?B?bXlyTTY1djJ0VmpyS1ZUV2s2KzZtN04wb3pmeCt0eHFwNE56QWV3ZUJ6VnZv?=
 =?utf-8?B?Z2ZSanE1ZFc0V3htZHR4Ti9HMlZkazVqN1dzOXhjOGtCTE9hZkVnR3FWczN6?=
 =?utf-8?B?OURBajRjZEYwTHJ2RVZKbnRHamY5c2c4SnVLOENWSTdaNnptdm9HeGZLc0NR?=
 =?utf-8?B?V2wwbHZ5YzY2WmxqSUJGOFNKMFFEcCtpOW5NQmFzSjBnY3M2YTAvMi9vYXh2?=
 =?utf-8?B?UGJoWEZqUTVuZE1abGtYcmVuQWZpc3k2N3ZoZ2VJTDVoVU1RWFQ5YnNONkRE?=
 =?utf-8?B?aDJrUjMwRVVpbmx0alZLcFV1aStPMUxNQUUvREdCc2NvM1Q0eWg3dFU2Nm5J?=
 =?utf-8?B?bjQ0QzlEZnlURG02R2g0MXBHWUdRM0diaWVPYXZMSmJwblZpaHBXRUhXRS91?=
 =?utf-8?B?K2JlL3lDMHNWVERSQ3dodFZwL3lVV0h0U2ZjS1IzeXE2c1Zpb3NDbjdRUWF0?=
 =?utf-8?B?WUVuK1F4ZEhxeE8wVkFQbWswZzN2OEVib3JlWUhxVzc1cW9IY0NUcjU2YjY5?=
 =?utf-8?B?S25lYWM2VzZudlA5MnIzUUVpNitmQVViRFJnMjZxYWVrUTBJcXRPWTc3UnVC?=
 =?utf-8?B?UGZKOVFRRUprbWxrK1UvWjVZQTM1Qm1ZUUZNZXB1c3dlUVV0cFZKYzRRT2hH?=
 =?utf-8?B?Tk9aNlhvV2h4Ky9tZ1NtWjA4ZE14NlF3a1V3Z2F3RmNrNGdoVGNTOHRPdlBp?=
 =?utf-8?B?em5EczFjUnYwVnEwUm1wZ1lzVWtuVTV2dEIvd3IyTEVXVnVuZi9MOGltbEww?=
 =?utf-8?B?eWw0Skh5bGxHbnFMOFZzanhWSWVTS0tXQ0hLalU0VFdzUU5IcjdxY3pVOGli?=
 =?utf-8?B?cVJCZnZLRVNaK0lqWk9zK0Y3TkQ1R2pveVFjMGhUUW5PeWFiZkdBYnkvUzJl?=
 =?utf-8?B?bFFkdHM1V2N6ZUtlRk53MzBIVTBrclZUUDdqUGp6UFQ0N1ByREJUWmkvVTNK?=
 =?utf-8?B?ZUdmd3htd05Ja0lkU05aSklYSWZqTEtjRzdrbkt1NkswUUFkRnVTQTM1OEph?=
 =?utf-8?B?MlAyVGE3ay9QRW1nVXI3aDhuRXVrb0E4dW1SRGVtTk4xN0dSSkxsUEZhRDNB?=
 =?utf-8?B?Q3RiUXJadTNKUVZvajIrd0p3VWZDejRpSnI0clRpU2NwZm40bUNpM3V4L2sr?=
 =?utf-8?B?RERkZUJHTnk0TlprZ1BEZHFpN1FVRGU5bTlLSE1MbnVSR1grek9NcXdPNGxN?=
 =?utf-8?B?dUkvTEVFUWh3cWZ0RjdoM1IyRldEM3B4WGIyRjRiTGttcG5KdU9qMjg5Q0dr?=
 =?utf-8?B?YzgrdXhJWmhXcVJxZG5FMnJTeTg1WXIrbWt0dVN6dnpWdUZ6eTdRMkVQOFI2?=
 =?utf-8?B?OEt6WUpzOEpUZ2w0Y1ArVkM0dWNvY1VTL2tHZ2EvQnFVNFRKWDRkakdYUGhS?=
 =?utf-8?B?Y2ppQjZvSFlHWm9Cd0gySnZqa1ltWG93VFNzZzRoZWNsSG1rU2ZhdENlVkpX?=
 =?utf-8?B?WnFXc2tvWUFXaTVnWWdwRG84Z1c0cDI1SlBxamNCaGVrU04zbVpMMHVRdHVK?=
 =?utf-8?B?cWtYOTh1c0xpQzJiYmJPNDJSRHhmYkwrNWRwTTYxV3dsb0pKZVlTUHQ5SEN0?=
 =?utf-8?B?SWYxdFN2M1ZLcy9lelFCUVROSjV6aFp5czBnM09ScDVrZEphOUxuclRPYVc3?=
 =?utf-8?B?S3pkT0lEdTBFV2txWVZSaEh1eUtIOHhSNGFpU2R4YjhaRSt0cXR6MEVGdVRY?=
 =?utf-8?B?WmJJRmRYOUVUZmYxSVNCbEtzRGxVUDZlMHpsTjNHd3g3ZUR1WVZvS0R3WUg4?=
 =?utf-8?B?blFzcC9xc200Sm10NzlZRWpzRkpMdkhlRno0Q2NpeTlqcmZDd0xIV2xqaTU4?=
 =?utf-8?B?RmtDcFlFakI2Q2E0NWpVeGs2UkRNRVR3K0doeVpIR28wbkhCYXREWnhEdEd4?=
 =?utf-8?B?bXdGVk1DMnNpcS96ZDlpZmRqNGROS2pFbFZLU2tic01obnpJUEE4bFZyOEdI?=
 =?utf-8?B?QU1jWnNwM0F5cHVPeTVpQ1dWeDdoSk9FTWJNWUtHaVQyLzl1R052RHF6TDRN?=
 =?utf-8?B?RjAvMWhOcW0zS1BWd29HcWFWalA1YTRwNjNZZmdrQkJNYWM1WHUya2o1Ykh6?=
 =?utf-8?B?dmZ6N2dJT1BweHpaYzFRNXhTMmU2M3ZHdGJnRGZoVkJYMlR2R3FGQmlXdFJS?=
 =?utf-8?B?WWNPZjNsQVBnT043andMbVNNRWxWWDVBUHF2TGR4dmR1Ui96M1ZpZz09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Ixd9nFQ3IDjLUKLXg7C7JCbkVFCymfn5t+OgOpzox8PA6+nk5URJZNHCUYH2yxQj0xeyGTmRPrjEpcBvp3KoU+re2UY3twMd8lJcxuC0nvdKLeTEGD/6KMzKhOYUcns/FXXK8yvwvBMDSBAEdJGsQgXkRQNdZ/3X44xsyzVyZpL0Pt7J4+hzTjhr6v6LI5oX46Io6hXBxnvBMLh1eB0jpw6WbDf7+rRtjpY6KDGwiYqtBjNYaTSEQAUVYflCXkYgeFuruK/9af0D8XweJfV1vThARHCx5hSf4/9RiqzFqbPP0yc97GzA7s4hzblcX6/S6AuC2jwNkYDHf52oARkYI8djWgoRw5CzPh9vmjhG90ApEj4skClfuW0akEwvJm8IIumOq7a9c0WXt6/cM2U3qmWtOxGri7iPWDigv/WXB/Up7FeA5JY1SVrRO6iBIsmUU1dEOeP21VLq5v+nMnuQkiOpaduToa4GFZStE3csAHz9QZO3iv0G3G1h6tHfCveNr7HK9duhfyH8n6SQ41SnghwrDwDVuK3JyGX7kdejpI90OqTKsGrD/fwNbFhkIpmoG+Og33gcCZnSJgl0lDEMG/EteljfjONA6xQgroGcz7E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9401ccb-1612-4981-fa40-08de70dc9d0d
X-MS-Exchange-CrossTenant-AuthSource: IA0PR10MB7369.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2026 00:03:16.6941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WZzkeBE2rxcTwkVkjGI9hGZhMfcPfZaXl70fUhzoUW037LSBX17eWbD6cgZ9iqtbyGpCdHntGyYRxHxhvpve2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6239
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-20_04,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2602130000 definitions=main-2602200200
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIwMDIwMCBTYWx0ZWRfX82EUK9+4l0C6
 qH9HBH+nom/TPa0L2sp/gMHD6YGYCrj0zhjZ5WighEzc+Eo/V5QUnzrJLf7PIZqiWdl6JHsgZ4m
 SB404qsXJLErHghT0rbk+pJEeC0xd5ceeuvPz8TRoKK3L4MB9G7eNOdRzY5e+8koZKa0Aoe+47r
 Moc4XvLauTVrJeXlDq23eq9WF5r1H7G7vhDfDmDu/oZO8awDH+OcQjn3wYzaZJ9sN36dwwSpOLs
 W2njJmNvPtw1tth4Aj8/yui1eioYYRJ04+Pi0skcLyREfjVsv0ev+o4OoQ0VXrfIpP2ejYjDER7
 B2Gy50YEjC3C99yeUjvdwktvxAfpJwIWIlg2eypDxs1Ju1kZiubN+T57/nUa9tKDMw906JDwb8p
 7sEoMhZQWzDkBsdiWlKf67t1ru1VlILdicHenh3KkOM4e3IKEvpMzuS8mOc7lKeJpCcQrCz/xlf
 RdL5/xeJH47hx2KinCQ==
X-Authority-Analysis: v=2.4 cv=Saz6t/Ru c=1 sm=1 tr=0 ts=6998f648 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=QyXUC8HyAAAA:8
 a=yPCof4ZbAAAA:8 a=aHKGLPUKp-hsq4sqgwUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: kxVZNCFS_1sEpyKVMffvDiIxtTss7iSi
X-Proofpoint-ORIG-GUID: kxVZNCFS_1sEpyKVMffvDiIxtTss7iSi
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77837-lists,linux-fsdevel=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oracle.com:mid,oracle.com:dkim,oracle.com:email,oracle.onmicrosoft.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jane.chu@oracle.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 93FB716B7EA
X-Rspamd-Action: no action


On 2/9/2026 12:17 PM, Andi Kleen wrote:
> Recently I wasted quite some time debugging why THP didn't work, when it
> was just smaps always reporting the base page size. It has separate
> counts for (non m) THP, but using them is not always obvious. For
> standard THP the page sizes can be actually derived from the existing
> counts, so do just do that. I left KernelPageSize alone.
> The mixed page size case is reported with a new MMUPageSize2 item.
> This doesn't do anything about mTHP reporting, but even the basic
> smaps is not aware of it so far.
> 
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> ---
>   Documentation/filesystems/proc.rst |  2 +-
>   fs/proc/task_mmu.c                 | 14 +++++++++++++-
>   2 files changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
> index 8256e857e2d7..7c776046d15a 100644
> --- a/Documentation/filesystems/proc.rst
> +++ b/Documentation/filesystems/proc.rst
> @@ -483,7 +483,7 @@ entries; the page size used by the MMU when backing a VMA (in most cases,
>   the same as KernelPageSize); the amount of the mapping that is currently
>   resident in RAM (RSS); the process's proportional share of this mapping
>   (PSS); and the number of clean and dirty shared and private pages in the
> -mapping.
> +mapping. If the mapping has multiple page size there might be a MMUPageSize2.
>   
>   The "proportional set size" (PSS) of a process is the count of pages it has
>   in memory, where each page is divided by the number of processes sharing it.
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 26188a4ad1ab..9123e59dcf4c 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -1377,7 +1377,19 @@ static int show_smap(struct seq_file *m, void *v)
>   
>   	SEQ_PUT_DEC("Size:           ", vma->vm_end - vma->vm_start);
>   	SEQ_PUT_DEC(" kB\nKernelPageSize: ", vma_kernel_pagesize(vma));
> -	SEQ_PUT_DEC(" kB\nMMUPageSize:    ", vma_mmu_pagesize(vma));
> +
> +	/* Only THP? */
> +	if (mss.shmem_thp + mss.file_thp + mss.anonymous_thp == mss.resident &&
> +	    mss.resident > 0) {
> +		SEQ_PUT_DEC(" kB\nMMUPageSize:    ", HPAGE_PMD_SIZE);
> +	} else {
> +		unsigned ps = vma_mmu_pagesize(vma);
> +		/* Will need adjustments when more THP page sizes are added. */
> +		SEQ_PUT_DEC(" kB\nMMUPageSize:    ", ps);
> +		if (mss.shmem_thp + mss.file_thp + mss.anonymous_thp > 0 &&
> +		    ps != HPAGE_PMD_SIZE)
> +			SEQ_PUT_DEC(" kB\nMMUPageSize2:   ", HPAGE_PMD_SIZE);
> +	}
>   	seq_puts(m, " kB\n");
>   
>   	__show_smap(m, &mss, false);

Looks good to me.
While you're at this, maybe you could remove the redundant entries in 
the documentation?
     452     Size:               1084 kB
     453     KernelPageSize:        4 kB
     454     MMUPageSize:           4 kB
     455     Rss:                 892 kB
     456     Pss:                 374 kB
[..]
     472     KernelPageSize:        4 kB	<--
     473     MMUPageSize:           4 kB	<--

Reviewed-by: Jane Chu <jane.chu@oracle.com>

thanks,
-jane




