Return-Path: <linux-fsdevel+bounces-70535-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D1FC2C9DBCE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 03 Dec 2025 05:19:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8E6264E02FE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Dec 2025 04:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D871274B35;
	Wed,  3 Dec 2025 04:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="S3Azr5JA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xYVpVfBk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7ED25392D;
	Wed,  3 Dec 2025 04:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764735571; cv=fail; b=F+eEnBX5JF70UDRmJcYHugvP19Mq8goMvPd7MxmYGW3HFlOpyF0MDMGKLtVvQ5k3RFBbPQsbOuHf5O2Gvv3N4KFi+aQMT7Gozhzyq+t4lBFsZ79VMMheG5nO1YJRpZffQ0MlgZwFcnCJJT9h0pbKFO11/dJpbYIVEQtHBTFJl7g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764735571; c=relaxed/simple;
	bh=2QKKCaERHkeCtaDd3SrF1DgRBZ7fc90vfJyTMVloyf0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UTLHw0yQcVkc8nlONnSwEqx98qpFV4uuF+BC+Bksf91w7DkE/8fp40g6nhV8infuuGkkG5HbpH34jckP+stOuQi5dBb5V5kGwxKt1TmNvudUITmJ8Fczj9oj9fa8HyeDgmzCrKyoYk+m2Zd/WJ4idEivFItEnflRiGPVZ8giVMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=S3Azr5JA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xYVpVfBk; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B32vcjc1710249;
	Wed, 3 Dec 2025 04:18:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Xrf2eCiPyqDShlaLfYfCR9nt51ujVa9xtTpVnRMnvco=; b=
	S3Azr5JAzIjWNDwChp9dz1tJTNZh/dS6CTxtaiD4KDR7h5mKuqV4H738ndvTGvwj
	0yys7Bra5PZ0gU+3gGXbd+GmgpSMvsHPm9dM81GHXF7jnoGN8hATWptYKiFN+B1F
	TkyjTDpusJS2xvYw8M+NAkW7RdtQbJfLXmnJyU0eA6gUrDqpy0GraD7LAECE3KT4
	wVoJXgrONcfzlZ5Zo8zBzTOa9njSMl/Zr0Y+gMsdn41CbR0NfbY9e+DorYuLhjA9
	j7OElG+l/CaVj7lAubsnKa03uQEU3olA5rTe15oPMmY96VNYFVdWgWRZRrvn6G95
	ugvQJfIHXG22xhTV6oUTSw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4as7f24j6x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Dec 2025 04:18:49 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5B33iVC2011890;
	Wed, 3 Dec 2025 04:18:48 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013025.outbound.protection.outlook.com [40.93.201.25])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4aqq9m6v7y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Dec 2025 04:18:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h7kRsyTa5XoET3q5HfOAtHALyzH92VPkX5H937p6CN6U8kwX8Dxhxz70akTwPZGBaTD12Dh9+RflE73/zms5ghAMGtzhb73ioOrqPTq/XYINBfLLWNDttoNNLZpaNmx7xuASrdnJ4Drdi2oax8BfrJEhtmFTOcbY/bfWMEcZmZpt0YKllgjzARnBJj0LwlwnXTUGGoHoM/sVmzDcM3xujf5WQ7LAo5RgGKNqcZgtgN6eubkhcukMDOS+38+AAqHUDpXhCc5XjuZNnZWZRZ328FhSk+3cha13lKb7MztspbDtFK7ooYSIZFQbp80OXLBQPAImH4c2WEGxUJUMtEW25Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xrf2eCiPyqDShlaLfYfCR9nt51ujVa9xtTpVnRMnvco=;
 b=OPVzCB87UE8moQcH/XKispSUbhc6FX7LamnabPrIYqp7tV2JJqfytqf4z4MzEVMtoR1lKlBdrlQKP9lPOqsb3osbgmuNdU9RzZ8X1YW2FrpCgBm6wph4wMWditUAxRlBc2i1BOIPus1DlSQPqNEo2RZN+jZLCEnu84JgogPxxhkGPZHWtnyBDj943bpJsfLu/WlM2hFd4aEviXGa4cCpwbNMnuBaIzJdvuc1xhGO4yEDEVM/8mslXWFFpwg/BPRlgkNjemcPPNDagrFKdnTwe/deB4zTNNBJ2edgfLT+aJuQnRfFGg6vH48Sf+bdgUlF4h/qbuUrmhH0cH44mcbOOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xrf2eCiPyqDShlaLfYfCR9nt51ujVa9xtTpVnRMnvco=;
 b=xYVpVfBkiRDhPSiYPkC1lXQ9VBMSY1xcsISbt3IsVKI4Bh9R/+dJXCqgZoGhOx2GYfnFxVoPUY+R798itysjLKCr/1dDrbWVEO2eFptw4gvZR+4BTEFo3bOLt/OX9WwD7LN9AYR18QkcobF8VKEoleaWAoEkPx+6oAPjKAUjF3M=
Received: from DS0PR10MB7364.namprd10.prod.outlook.com (2603:10b6:8:fe::6) by
 DS7PR10MB5215.namprd10.prod.outlook.com (2603:10b6:5:3a3::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.17; Wed, 3 Dec 2025 04:18:21 +0000
Received: from DS0PR10MB7364.namprd10.prod.outlook.com
 ([fe80::b7d7:9d3f:5bcb:1358]) by DS0PR10MB7364.namprd10.prod.outlook.com
 ([fe80::b7d7:9d3f:5bcb:1358%6]) with mapi id 15.20.9366.012; Wed, 3 Dec 2025
 04:18:21 +0000
Message-ID: <693112ce-e6fe-4a72-beb3-d2b95f40cffc@oracle.com>
Date: Tue, 2 Dec 2025 20:18:16 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] Documentation: add documentation for
 MFD_MF_KEEP_UE_MAPPED
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
 <20251116013223.1557158-4-jiaqiyan@google.com>
Content-Language: en-US
From: jane.chu@oracle.com
In-Reply-To: <20251116013223.1557158-4-jiaqiyan@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1P221CA0031.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:5b5::10) To DS0PR10MB7364.namprd10.prod.outlook.com
 (2603:10b6:8:fe::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7364:EE_|DS7PR10MB5215:EE_
X-MS-Office365-Filtering-Correlation-Id: fbef693e-9f3e-40ca-ef4f-08de3222fea6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c2xKSXZDNkQzKzVjYVN2dFRCTTlFMFFBTy9ER0dyOTduOHFSS0pQOTRSVkc5?=
 =?utf-8?B?Qlc1OUErZjFEVnlIQWIrL1VVUXJmc0l4VnRvRFd5T0d1WVdtMHYzSzM0NVVX?=
 =?utf-8?B?dlJXUFVJQ21IOXBiakpxNEZobXFrbDgwQjhrYzgrc1kxV0M0TW44cmFNZ2Ja?=
 =?utf-8?B?a292OXFOa1FwWFpHZmxXQjZQRytzajEyUVE3YTVPQ0d0Z3pMcWI2ckMvMEhM?=
 =?utf-8?B?eDVrQS9iUFFhTnBNNlMwSy9GTk9Ja0RYOHhaUEtEQUVpbnpQT1k2MXhaaHRo?=
 =?utf-8?B?b09obkJUVmo2aStBWDA1MThxcUhFSExPejVDdU1RTGVnYjFCdHRvR3piQ1pT?=
 =?utf-8?B?VXNQNE1aUmlYTEViV0lQSXVQakNKcU8zakJFQS9YZ3JWb3hLZEtFV29LV0Z4?=
 =?utf-8?B?b2VJZHdTdTdWbE1GY2VnQS9zVC9td3gvN1MzSWR2bzJCRjNXbGZOYXFTaXJ6?=
 =?utf-8?B?VlRNUXJvZm9MZHFFMElpWldvNjhybE9uN05ycWJQRlNRYkNoclVYQmZ2UDZF?=
 =?utf-8?B?WGNsRWpWODFURHlXUXRIMUl1UnF6b2xjYXFYTGpkcExPL24wdVhod2w5SkRx?=
 =?utf-8?B?b2dnTUgrRlRSOFNFZldxQUc2QU8yUXhiVVBPMzcxZ2gzUnFkd3lvMUNIcFpH?=
 =?utf-8?B?a3dlWFh2c2N6WXo4Z0FZdlhRY2REaHBzVEd5b3VENVpQa3lSZFAxQXhnYk1J?=
 =?utf-8?B?WFkxUlNUVEVmbEYzUVk5QkpURWFwRnhqajVDZnVlcWZJU0VhUFVGa1BNdjdk?=
 =?utf-8?B?eURRUDhnZ2htOVR5MW9JRURIZE5Wa2NGY0t3dkc2dTJGQkIzbENkSlRxaWVU?=
 =?utf-8?B?eThLWWtycHNNcnZsTE5VcWI1SkMySHhCdC95NEdVaEhMYlFQcURnY1QvcnNT?=
 =?utf-8?B?UVByZkJCMVZQRG4weDhHVE1RYW5nb3Q3Z05UOUFEc2ttTFhXKzNxY3ZnQWt0?=
 =?utf-8?B?QlQrY3YxajM0WXAya2JBdEsxNjkxRkh5RlA2K2JMbHJyQmdyVGpPci9sV1cr?=
 =?utf-8?B?SlIwckYvTHJuZWNEa3FEQlFDZ2RJTXB0T2NHeDBUVStuWTR6dVNnYmxKdm43?=
 =?utf-8?B?RldBeWdnY2ZCcmVENHdtSW5oM3EwWnVVSFBKb1pYQkNibXgvcmRrRHZ2ZUFT?=
 =?utf-8?B?VXRMdHdCTEN1bG1pdGNuTkhKOHVGbkp6U1Vqdk0ySXQzNjM5WUZDeFJkSHhU?=
 =?utf-8?B?YWJXRk1sVDZwRk5Ld3hPZHZlcXBuMlFheExYb3JCOXN0M211azQybzM2TG9D?=
 =?utf-8?B?RjJvM3hPZlZtN0d4UXhPL1h1NWd2OGVEZjRBcnpQQ0liZXJtN3IvZ0J2VFI5?=
 =?utf-8?B?MkhPVGhIdk5rWDRUUnNhMTM1NW05LzBqc2daZUswQmpKQXJ2NGZmdytJRGtR?=
 =?utf-8?B?bGZVN01zK3hiVlU1Y2h3bFErQ2hxeUVvZW9JREZPeldkLzg3anovWmdCK1Yy?=
 =?utf-8?B?QURUNzc4VThzanYyZkhxNmkzeUpkRm00M2ErNncvaTg1SzJNSGRSZUFCZTEy?=
 =?utf-8?B?aFNZdXZkS0taK2t5YVR5TGFmUFFFR2dRRjNVNjBtS1FMZ0pGVnZJZHN2TnVP?=
 =?utf-8?B?S2FGVkpBRjJvcWp6QXRWL2svY2NpUGhZN1AvM0VUNUxXYS96SnpxYnFKenRw?=
 =?utf-8?B?K1paSW9aWkw1SjRDL25BTXBaVy9nRXRhaWkrRXBpNVdtRnhEb0hMNUcwbDVM?=
 =?utf-8?B?YzFkZklhT0dxVGhibGtJUXE0b0VkNnprRmw1Vkx3aTUwWTk3YTZlSUpIUDVX?=
 =?utf-8?B?R0I3QjlkWm0vYzEvTmxEK0lMbE1Bc0IrSlF0OElaZFNOa1Y1dTdyMksrT284?=
 =?utf-8?B?ZDJOWHNlZUtLcW9CVElVUDdzVlNkZnZ3WHJKa21aUm9iRzRYRk56OEdNZllL?=
 =?utf-8?B?Q1N4RTltWkVuNnZYVm8rdXU2dTg0VUwwc3ZGa1FyZjV4dFhDUGhqOS9JWFNt?=
 =?utf-8?Q?YXq3VyCfa8PResgdEWb7RioQ9mpOKUfc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7364.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R0RvdmlkSHdqMytrVU9PY2t4cWY3L28vZXVUVGt4YWVvQjdEWm43cUVyZ1lG?=
 =?utf-8?B?U212UCtUazlFdGZOdFZEOFUyemtJMUtUUUROb2dxUTRveE5oTU9UanJKM0Zs?=
 =?utf-8?B?MS9wNFErYWVmb0hwYnFCWGJCamJ4alYrYU1GZnB6VWNlOEQwLyttbUZlbjMv?=
 =?utf-8?B?NTVCZXJJbFV6V1NFUlNzNWl0ZWZsQnJiVEJpV1NCaU1YMTFCTUo3d2tmcFdL?=
 =?utf-8?B?K1VYR3hkN1VyZTMrR1ZzOVQ4NDNCQU9MbFRtNjViR3BVRHBybU1JNDBmV0U3?=
 =?utf-8?B?WE95Qy9LTEFrRXlYUGJUWTAwVU5HdUx2MEtybkhKYnZrdTZUS2hGSTBWV09Z?=
 =?utf-8?B?WGM1YmRxRTFwZXdwUnBZdExucU4xWEFUMXhGbm1wZTdsT0RsQnRqK2tzQ1hP?=
 =?utf-8?B?N0NwcTY5Uzd6Wjd0a1A2WG9wUGlQV2tWQUpBT3M3N3NUN2pFQUhoVUxwWksz?=
 =?utf-8?B?ZDlrOTZDMkhzUkVmOEN2ZXZRZExxMkIzV09UbENIOURYcDVULzdKQlhLbkda?=
 =?utf-8?B?S1JORkdaY3phNXBhRjVXeWk5dWRScnA3cVJBaERydExZN2JaQjJYSVNrSUFL?=
 =?utf-8?B?WGM1R1N2c1EyNjBDamQ3UmpCZWVPZ3ViWDZ5WWRpdXBybHNKazk5OFk5WTVN?=
 =?utf-8?B?QmZHL0hKQzZDNGM2aVFmOEVVVWJENFE4VkFKaTJZazhyRkJhbEZmMnIyZ2Iv?=
 =?utf-8?B?TDU4UE11L2lWdmpJMkJXYzhzOUF4ZmNZY3RYdlZ5dkNyUWZ5bVoxVkwyb1d0?=
 =?utf-8?B?cjI0c1RJU1FTY2lsN044M3EzMXQ4SnRkNEoyRmV2L2RQN0IzZG14UHRQZmhQ?=
 =?utf-8?B?ZGxvSU9uN0pGMXFMS2xqSWtoNzU0bzZLZWRwbWtiak1LaFdkN3RHRFpabVVE?=
 =?utf-8?B?cWdUMjRETUx5Q3pJeENRSmVIZmsycnNqbmRLNjVTV2w1aUVEeUpZcWVYaWZk?=
 =?utf-8?B?YytqZm9va0ZzZ1ZEdmtlM3NQNWt2Q1ZyYzJTMjFHRWxLTmFRdG9MTlNjNnlW?=
 =?utf-8?B?VGtBK0YxOXVpYzEwOEc4aDc4UjRZUW9takpIQUVYRHpYVFRaQ1RwdGFPOVdL?=
 =?utf-8?B?L3NtbGE0aG5DbDR1d0xGY0Q1d2JiTk9QdUx3MU9FVGhzTlpoaTlCOWorUTZT?=
 =?utf-8?B?NE5ubzhkM1ZtcUY2cXgxNE83NGNpclM1bFdOTlRZZXNYNUdyK2pubW9yeDg3?=
 =?utf-8?B?NUNYK1U1UzBFQ094V3BQRGlpaWZ6b0VkaVFRQVhra1dIYzB1K3BwckN2QUM5?=
 =?utf-8?B?bFRWSVpDSTZveFJEb2Q0QXNlSWZWczkvSDBnVDNxZjlKQVpyeFRBWk5hWmgv?=
 =?utf-8?B?SUtSc3M0aFl0WERzenkwdHA1alVCdVhZTjVSZVk3NFJFdnRyVC9VWXV4c3Z2?=
 =?utf-8?B?dnpTNmprV0JHNUJraFZ0YnNPM3FoTWxDZm5md2NCYzY4VElrOVcxekFlNmd6?=
 =?utf-8?B?bytKM2RzUlEwNVV2WDVkUmswRHd0UU1UWnRQS2owVHdacWdUbldjbm8rMnJo?=
 =?utf-8?B?N1JvKzUxOFlVMHBIb0UyOFJVc3NjRE9scnlZY21QcXdRMlJaVnVJVURYb2hF?=
 =?utf-8?B?cG9xTTJNT1NDMUZtRUNUa3B0elp0cS9WTVZHcGhhWGUyTFRNZ1dhRFBTbDZX?=
 =?utf-8?B?NS83UkphVGVqRkxncE1Mc3RBTlRwK29CK1hHSWYvVHRXYThBSTdkRHRvZkEx?=
 =?utf-8?B?ejBOUStFYmxaWFFjSUMwRlhicDZlQzhpclRnSnFxNGRnbW9SUlZQb1k4aFVl?=
 =?utf-8?B?dUVsZHRXQjZwRjNOWUFJQURaSkIxMHg0RGtQdzIwamZaeFByWCsrV1FTUmRI?=
 =?utf-8?B?VVRsMHl4bTVqVXNjMDRJWVBTSzJrdGJ0K3NVazNEUTM0b1hzbk1mdEJUbDJs?=
 =?utf-8?B?bURqOUNUWXlwNTdmRnZBbDNHT0IyTVBSTGNzajJlNHZlMG9WZ01yODJ3cnZw?=
 =?utf-8?B?YXhQVFlrYnBPQUJTb3F6akpOTE1yZXkzRjBZRG0yUDliOTZEQVA0T3NxQ1dS?=
 =?utf-8?B?czN3akZHblNaZVh5K0lRdG56c21UY0Y4RGlFMXhOYkZXVXJJc3NYYTUrN2px?=
 =?utf-8?B?RFRRLzdielhvOGNKZ0xWeU52RnltWnBFNWRaNlAxY2M0Q21TTFc5MFVSN2dw?=
 =?utf-8?Q?yGK5jhF8XO98rX6bB7ZaSs9vO?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Dln3m0EXaUrREwzolUI2gcNk3MQOEB+7UPnZUbj7CWBshKPdbCn0eyQUsBhBxlILN1Bl3q+Ym/2yUD6rsfLBhd8n7e5KkW2lypttdvUjKwXYsRHG2kjBujavWgLyI7WOKLyPcUm5EvOAgvVvZsVh2vnBBdOt7NTXpx6laM+hmhh7jNLZ2KoTIcMSLN7cM2e6PTMksP2ffmyt7iJ0HHi0T2RYnhOK1ZqcPfgfjqWouprDupQ6PkgXvTbYQ8KZkDiavzPN3WpAgD8J49xDQXbi0zLJ0GZzZtqttE1bRSyVNcywtb/0ZHiXqci/5UGPBRXYbU2LvJHuYs8M4XpthkAJwLfcbbjVrh6X58HzaGZAoN/fwh0EvpU115O6ariTHU0Rpjy5PghxEUeSz7Kx+EjVkSZPuxZzvK/DexngxrX23CLtg1vs8eo25d9UgkXgGZM7B4RvIL5GXDEngujup5n1Sh6LSOTO2ih/1Q23WCgb1ubq/S64zTjSGbVqx+EJUERxkMuNzfDMLUHDpV2Ksgms/zIT94HvF/l6hBBKbyz9P4/FAfLiiZ+mT2daGhk5uK/iXDauAxcCAGa8HRZRrR2y4CknZuGYiMgdIPu/wLnLYNc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbef693e-9f3e-40ca-ef4f-08de3222fea6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7364.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 04:18:21.7311
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TCQJJvB+WhC08dsLnVxg9auseKcbbMc8fBSD+4o18Hw5T+dEiNzqHVEFv2tJPpMp8/9G44+AJGHSG1yhcAgYHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5215
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-01_01,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 adultscore=0 suspectscore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2512030031
X-Authority-Analysis: v=2.4 cv=QMplhwLL c=1 sm=1 tr=0 ts=692fba29 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=1XWaLZrsAAAA:8 a=yPCof4ZbAAAA:8 a=3E4yJ9fSZk8sK3EbspsA:9 a=QEXdDO2ut3YA:10
 cc=ntf awl=host:12099
X-Proofpoint-ORIG-GUID: 96ofGPs2-hk_7r0lMCDmkaZIeX-WUjCT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAzMDAzMCBTYWx0ZWRfXzzwSoBW0x+lD
 nvpvLnMlCpd3GooXd0pIhutyBL8ADvwoCj7OhS4K+pHAW2D5nl1PtPILB9XiATp6gyY4WgEqFXi
 mBz8ahZ6dxWIxpDIdCLAol6+oRofaz3Dnh6RKZ5Qlv+7De1scluvXhkoBdt5lwsDvKqLsm+X3iu
 nrWKPTnshtaq5CarZh0ndL9598FAA0b+So07BfCJWX1zmwW8zLJW0v5L0LUZvWj+OXxswqkJwKh
 r+xMtR4vaRHLDCzY9bH7MjIlgScmj+0rmimM2iU5mEu7G3K0VyNFLCU7EviGCaQGNznmGYE2Cus
 9tDs/ECq9rYPhcOpghH7F0d9t0dnmt82qGPxYOWZYvdL5ya8zrQuSDFf0qhCikshYGDjyILt8G5
 ToXSEGPULqmzTNjJP5YOWqy46O0TaZbI0fof9LycIM+mn9ty54o=
X-Proofpoint-GUID: 96ofGPs2-hk_7r0lMCDmkaZIeX-WUjCT


On 11/15/2025 5:32 PM, Jiaqi Yan wrote:
> Document its motivation, userspace API, behaviors, and limitations.
> 
> Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
> ---
>   Documentation/userspace-api/index.rst         |  1 +
>   .../userspace-api/mfd_mfr_policy.rst          | 60 +++++++++++++++++++
>   2 files changed, 61 insertions(+)
>   create mode 100644 Documentation/userspace-api/mfd_mfr_policy.rst
> 
> diff --git a/Documentation/userspace-api/index.rst b/Documentation/userspace-api/index.rst
> index b8c73be4fb112..d8c6977d9e67a 100644
> --- a/Documentation/userspace-api/index.rst
> +++ b/Documentation/userspace-api/index.rst
> @@ -67,6 +67,7 @@ Everything else
>      futex2
>      perf_ring_buffer
>      ntsync
> +   mfd_mfr_policy
>   
>   .. only::  subproject and html
>   
> diff --git a/Documentation/userspace-api/mfd_mfr_policy.rst b/Documentation/userspace-api/mfd_mfr_policy.rst
> new file mode 100644
> index 0000000000000..c5a25df39791a
> --- /dev/null
> +++ b/Documentation/userspace-api/mfd_mfr_policy.rst
> @@ -0,0 +1,60 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +==================================================
> +Userspace Memory Failure Recovery Policy via memfd
> +==================================================
> +
> +:Author:
> +    Jiaqi Yan <jiaqiyan@google.com>
> +
> +
> +Motivation
> +==========
> +
> +When a userspace process is able to recover from memory failures (MF)
> +caused by uncorrected memory error (UE) in the DIMM, especially when it is
> +able to avoid consuming known UEs, keeping the memory page mapped and
> +accessible is benifical to the owning process for a couple of reasons:
> +
> +- The memory pages affected by UE have a large smallest granularity, for
> +  example 1G hugepage, but the actual corrupted amount of the page is only
> +  several cachlines. Losing the entire hugepage of data is unacceptable to
> +  the application.
> +
> +- In addition to keeping the data accessible, the application still wants
> +  to access with a large page size for the fastest virtual-to-physical
> +  translations.
> +
> +Memory failure recovery for 1G or larger HugeTLB is a good example. With
> +memfd userspace process can control whether the kernel hard offlines its
> +hugepages that backs the in-RAM file created by memfd.
> +
> +
> +User API
> +========
> +
> +``int memfd_create(const char *name, unsigned int flags)``
> +
> +``MFD_MF_KEEP_UE_MAPPED``
> +
> +	When ``MFD_MF_KEEP_UE_MAPPED`` bit is set in ``flags``, MF recovery
> +	in the kernel does not hard offline memory due to UE until the
> +	returned ``memfd`` is released. IOW, the HWPoison-ed memory remains
> +	accessible via the returned ``memfd`` or the memory mapping created
> +	with the returned ``memfd``. Note the affected memory will be
> +	immediately isolated and prevented from future use once the memfd
> +	is closed. By default ``MFD_MF_KEEP_UE_MAPPED`` is not set, and
> +	kernel hard offlines memory having UEs.
> +
> +Notes about the behavior and limitations
> +
> +- Even if the page affected by UE is kept, a portion of the (huge)page is
> +  already lost due to hardware corruption, and the size of the portion
> +  is the smallest page size that kernel uses to manages memory on the
> +  architecture, i.e. PAGESIZE. Accessing a virtual address within any of
> +  these parts results in a SIGBUS; accessing virtual address outside these
> +  parts are good until it is corrupted by new memory error.
> +
> +- ``MFD_MF_KEEP_UE_MAPPED`` currently only works for HugeTLB, so
> +  ``MFD_HUGETLB`` must also be set when setting ``MFD_MF_KEEP_UE_MAPPED``.
> +  Otherwise ``memfd_create`` returns EINVAL.

Looks okay.

Reviewed-by: Jane Chu <jane.chu@oracle.com>

thanks,
-jane

