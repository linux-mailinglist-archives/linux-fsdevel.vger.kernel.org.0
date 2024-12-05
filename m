Return-Path: <linux-fsdevel+bounces-36521-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D265C9E5171
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2024 10:33:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D336018814B4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2024 09:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E56F01D5AA5;
	Thu,  5 Dec 2024 09:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="easfVCrl";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FBmC6/j4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C132391A4;
	Thu,  5 Dec 2024 09:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733391213; cv=fail; b=e0n8gyDMF3hoCwvm7+cuugiE1eOdNc2nSD8bdmaq2WXdyijkp8X6EIsGL8JnS6ElYqix0VdxL+ipVqORvQ9w5NsgdbmkAuR+PoHVvSJIo2kmSoPs1iraIPz/ouru9/db6Psnnc372i66hXxNcvuhhZ1k7DvnSWteLtwHnn1p2sM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733391213; c=relaxed/simple;
	bh=HZ7FGhRHrLFm8VD9bw0EDIqeV184kEmTq7KuCzylgaQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JI5LSdhbOka2Vc34Rd4eU3jfOh2LYwxf61bm1m4xRrDv5RYVCdvccDZJ2SNtvLH3DsJ6FELnUuAA652KAvInAxwM/HAtF3Nv+VHPr9Z5ipx28kYvrhZh3D3cVzJN19Wl/QAZHdJ260tw9a5iPasKsolvpgsueRZ+52HAo7jhxOM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=easfVCrl; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FBmC6/j4; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B57NElP028389;
	Thu, 5 Dec 2024 09:33:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=DTboDd75xx1Y+JijRJ+MJGWqE8Gw/b3S1VPMK1hphW0=; b=
	easfVCrlsiOM3vsx0Gm9oPxw8/ivtVJ3gXlKFfCiehfnyYTnoRePT0F61Q56bFIR
	wb95C4VhCqXhIcpuqof+4O0kWn7W3V6rpsI5mljexDItcZTw+d1Nkw5owCaWf2dE
	UA59N6Q15y1YOTmqa1SUhw/0h+MFQbe89U5J6kfb+esCvgutCm2D/XRHmPxfii1n
	gSr0PMD1P9Vp/EZuAt1pU1RbmR1VSwNOuOeHwDeMj2nG8M++/n0r5/vvnazspy6w
	2lI674luEgAIn0VnxaF8sXp/AHFQuAYH6C+KJeRxr6sd7b8kXlGqCruIAlo/IuNL
	ESa/Z1BTyZLUkcAjXDiCew==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 437sg2ag1d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Dec 2024 09:33:25 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B57a5mM011728;
	Thu, 5 Dec 2024 09:33:25 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 437s5ama6t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Dec 2024 09:33:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X8h/sOS+7dNro/lJOTLNZ91Wn0MslcX/0mAXyX/z6+pFM0RDDa5nFnKRHPirGKi+ZjVrGHf8MFQAXg2VYLe0jFXz+FqNuzwRm5TuE4yG/KXxiWm2BrWZeLkSBLFOZFf0tRtTPnfAoLfwnC9pO+kofbz21LUKw7ZcI3vA3rZMxFcpv0l2+/UJ1gfpckx0paofl/o/wUF4I6+GtIMQk49Q2NxcsLNG832+56GrsCVlA+kAmzNXOIaWltnuR+KlvGvxenrCBHSKTipzv7oKThPJ1jTasKIqt+Sa+MYUk7gM1e+KewioTBKXCE3hwrUbjgt7SzrqMcEjjNb5rkoVuBHO5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DTboDd75xx1Y+JijRJ+MJGWqE8Gw/b3S1VPMK1hphW0=;
 b=n08q++17DWFmRmPAjJxrg6s8XkYJa0g24UzaqMUoHrxgLs3OL5RbhX9B2K3ui93m8Oi0hlP6TLdxVjRllFNYQPKLXCy9kRVYcbIYQu69kRkQ43hJV0qyw4U8pL+tK9hddtRXRKM/POrgXMrDH/mQUhe6FCLT/eRrwn/G4eXt41XyHnKwwUKjcgRGoU98ycHvqhbwLlAQu9M4nT6Ehy9Prh7GmqqpIkh2xFZ699rdKN2milVRh7DDS29BzYj+UqhPJj2eHqaQj8zb0W98fRL7MBuzpSm24FU6ZKS/5p8klNqIBwLnGVrhVptLXKkBZEokxKFiPJPdmkw+0E1HB10HlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DTboDd75xx1Y+JijRJ+MJGWqE8Gw/b3S1VPMK1hphW0=;
 b=FBmC6/j4cATS9EcHmFfPcsMZg0VGW0ODPJJM/l3QjQLmxP5ExeWcf0uoOB+wRmL2pKrMwMOvg7/D6qsPJynY1c0nnV7DNPw4h9f/b3amMfJPNNgO4amT7bIOACImU1zy0X19GRUC20g7F83qMwpLVqNX7KqIfkcD9AhZnZHxWs4=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CO1PR10MB4593.namprd10.prod.outlook.com (2603:10b6:303:91::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Thu, 5 Dec
 2024 09:33:22 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8230.010; Thu, 5 Dec 2024
 09:33:22 +0000
Message-ID: <430694cf-9e34-41d4-9839-9d11db8515fb@oracle.com>
Date: Thu, 5 Dec 2024 09:33:18 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] statx.2: Update STATX_WRITE_ATOMIC filesystem support
To: Alejandro Colomar <alx@kernel.org>
Cc: linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        djwong@kernel.org, ritesh.list@gmail.com
References: <20241203145359.2691972-1-john.g.garry@oracle.com>
 <20241204204553.j7e3nzcbkqzeikou@devuan>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20241204204553.j7e3nzcbkqzeikou@devuan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0214.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:33a::9) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CO1PR10MB4593:EE_
X-MS-Office365-Filtering-Correlation-Id: e84e25f4-3796-4eac-9eb1-08dd150fdc5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K3FFbWxzQ3ZKaTR2N2huVExOYVZzM0oyMEJjc2wwWkRRdFUxeXl0c05iK2RT?=
 =?utf-8?B?U2hhRmZJZVk3Q0s0MTlDaHl3NkpwT1hncVRZYTN4TlVCQ3dueGQrWWppUDkx?=
 =?utf-8?B?dFY1RnlhaXpXQU83ejNvRVkxMTdweEloWHNDRng1YTFnNFkyMkUwZ1g0YXFz?=
 =?utf-8?B?SFdNMjFhN0ErMGh6Tyt5aFU5a2FnSHdoVzZrZi93N29lR04yK0ZwSFdoN2ZX?=
 =?utf-8?B?NmpDRm9zaWo0RUFNT0dnTkE1UFI5VWQ1U3lUYjVyN2dMN0tGZUVjYml0SmFO?=
 =?utf-8?B?N3VLMGsweGgxdDFObFNLRXFXb1pjRjhSdVBySC84RmxGTkxkd0ZKTllBZ2VT?=
 =?utf-8?B?NGNsRFV5L2Q1S0lCOUFVMVpPZ0xyZEliK21BUFg2ajllUUsrL0JPZlZDWXhV?=
 =?utf-8?B?V1ZuVXlqVUZVMFliTWNZMHNEVGphUDZFWWFBVkdKTUFNWWpqcG9OYTFjUUZW?=
 =?utf-8?B?VkJkdTFGemRHTlovVkl5ZUtwblkvRk9Oc09NbFNzS3lyWVRUQmRGYnBxNUFE?=
 =?utf-8?B?TmpJOTk0cnVZbU1QYm9xeXdGMDNHRlZ2TFBQU04veWR1WVh3d2ZtQ3hHMWVW?=
 =?utf-8?B?MFUrRm9kTGxSN3JjN2NaeExDSjU2clBJbk5JM0NtTU91QUkvSFVaSktjSEFU?=
 =?utf-8?B?UXpEMnVCdmhva2NubEdJK2tFc2ZnOGZpYUhvb0pTcnNxM3MyYVZka1JnZ1lz?=
 =?utf-8?B?ZlBpMUJ2STUxTUg1cjg1a3h3YjVpbW90Zmtjb0tOK3FURG9jdXNIelh0RXE2?=
 =?utf-8?B?c25rWmVOL2lUK3pRZ0dUc0NwV1lNeFdvQ05FZUZWU3QyWXZGV3IzVXF3VHNW?=
 =?utf-8?B?cldXSEhaRy9EbUZFQlI5L0FaTTdGcTUzRWZQL3pVZXZ6UUtQaisremoxU3I5?=
 =?utf-8?B?TUlGTHdSSFdhRXdVMDhVc2lySG5uTzlLVklvQi9SUitTbDZjVmZ0VG85UmdR?=
 =?utf-8?B?ZDZmRm1SWjVjejJUQldpYTJobkxOZ0JvNzRaa3hWckdKYURiTWYrNUVzODc3?=
 =?utf-8?B?OTk4eFE0aTBSQno1a0pVTVV0OU9CL0pVcmM5Qk5OdWlEYzIyMTJDenYxSDJW?=
 =?utf-8?B?NlhCK200aTlqWDRMUURYbUt3RWlhTHNHSHpyUFB3bFNWQkZuekI2NmdmNUZp?=
 =?utf-8?B?NlFVd2xyMi9KdFRUWHBpcmR3SktzN1ZyVFFtVTZ6aXRzVHp5MGJpelJKcGRk?=
 =?utf-8?B?Q1FITHhJUndhQTBKOS9yM0VyUm9mQU9JZ3lOWG00N2d4NnJ4aW1ObGxqV0xm?=
 =?utf-8?B?VGtXK0dWNXEzWFpDSU1ZZ1VVMkMzUnhiN0dDMVpoSTBDYnZxUW9NVDM1UjF6?=
 =?utf-8?B?R3FFaHRWK1hCcU96U2tmeE1hSUR2L3RLVVgyUDFoaVpYVVVJUXp1Z1F0Y0tm?=
 =?utf-8?B?d0F3QWNFZFNkOXpCdUo3SkJxNTFqay9XV1hMRlh3RWgyeVZIc2RIaEg2UVRi?=
 =?utf-8?B?Wm1SM0UrK1FzR0ovbXQveVF0amhISlZPeFo5NmZNWkJKUlFkZDUwWXRGMGlD?=
 =?utf-8?B?a1VJNGV2bk55aVp4TU1lbEdMbDNkZmprT1ZtSmRZbXF2RUsrTERTRUVsa293?=
 =?utf-8?B?RXZpOXpYRlBxYzd4dEltcTFRb253OGc5cE1wbVRUcWhHakM2bHc4akJEWXRz?=
 =?utf-8?B?QjBVYW1qdUhRZndGMnZ6NHVHYkg5Z2tQV1ZIRm5rcS9LUHVCUi83UWZRQkdJ?=
 =?utf-8?B?TWZhTlBYYWlaN2JOZ3MyUHdnR3BhL2ZkMFQzZTlVZG0xYXQxaWR1NEllS0VQ?=
 =?utf-8?B?QVZwdEZESURIcHZSZ0pjWXlFMFUzdFdOcGtjNTljR1p6N1NYbEowNjFHOUNa?=
 =?utf-8?B?MGE0d3o3b0hKYXJKbTNxZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K3FHU25hR09YeFJLN2NzUXZyMkJLTWFpVXJHLzNndEhpUWhib2ZHRFgwTmQ3?=
 =?utf-8?B?YkFQK2U2dVk5V1JRMnRKN0lOOFNnTXQxSk1RS1NvS2o4U0MwNmIxUmxHVHZJ?=
 =?utf-8?B?M0krdVpRK0dRRDIyOHkydFg1cWs2cXlxZVM0ekQ2WXNEK0xpdGZDWE5zZUQw?=
 =?utf-8?B?ZmNwOURlS0l3UmtTK0h2elZkZU8vTjJ0SlBKamYxYVN1SFBlZlhsak5HUnpl?=
 =?utf-8?B?UjR3VThvdEFDV1VWT0YraG9tUUswYkoyK0xicXI0ZktyZWpkWFgzWEZZTlRh?=
 =?utf-8?B?bXNDU0J3NldmRzZwdlIyZi95VFNxb081bVBKMnRZMTFWTVNuM2p0SWpMMVV5?=
 =?utf-8?B?S1B4Um9nR3l1Qmdkb2dEeHlRRmJDSEF5UVE5STFweVdtMXdiaEd0RDlxWnBD?=
 =?utf-8?B?eU5BMFU5VnU2UjVqcGF5THAxZ3E2UHBBeFJqd3JVN0dmTWFuRWhTK0lrVkRN?=
 =?utf-8?B?RExHMUFyQmhpdG9SbGVWSXVxWVc3d0tWYmJ5VzYyMUwwT3NrcWpvVTdaQ1pR?=
 =?utf-8?B?d2g2U3lLa2k5NXNSY2ZrbXNkK1N2K1BrakZkTDh5OTBmNSt0dzl0dFdBU2lO?=
 =?utf-8?B?VllYWnlSOUFjdjhYZ01kcXp2TUEvN2ZDZGl2T21lSDZNQW9ML0o1WXlOMnlL?=
 =?utf-8?B?MHNKUnlJNGV1Qzl4OHA2QXU1OExxUW9VS2dwWWZweTF1eDIwSDYybkp2TVEv?=
 =?utf-8?B?UmRDMzNNcnB0MkNramJVUjZZdU9YaklBLzdJNmd5dWNHdTJ5OTc0Zkg3L3JW?=
 =?utf-8?B?Uk80eG50NWgyc0pTaVlDd3d6ZGtIdTUyeUN1L1psUVdOQ2ZJV1VHdFdKN2lH?=
 =?utf-8?B?T2NvRnhPa1NKcmVUODBtU01WRkpQYlY2OWpQYjROVWlGQVVuZDNkMm1QcXJL?=
 =?utf-8?B?U0Qvby9TMkJ6SjRJQlR1QzNJTTlqNlVCWkQ2MHZ2Ukt1SVdvc1hneVVuVTlJ?=
 =?utf-8?B?b2RkMjlDaHg4MWNuR1ZxSGIraGFxYk9HamIrSDhWcTF3eUpUdDRIL1RENEg3?=
 =?utf-8?B?ZzdDd0k5QWRpaWhFeUlQbENCVGVJN041dmIvck9KMkVnRVI2M0poTHpGZUpS?=
 =?utf-8?B?S2ozQ21iKzkrbktYQjVTWnhIbUNURHBzbWhRdVRsQmpsL1U1Nll3VnlwTFRD?=
 =?utf-8?B?RHFKYXYra0s3RThXWG5ZTDF3STlqa0tPdDZHZzRKWTBuZ2hUYTZlRFpTV3Jw?=
 =?utf-8?B?WkxnNHMwTFlyTkVjY1BqdnZKQ2Y4d1NxL054MTEveXBqbk0rZ3J2b3A0WU9X?=
 =?utf-8?B?eXAzYnBEOWs3WldDcXRxNXl2dS9HQ2ZJNUVSVFBXS0xsRnYyZkFKTnVkVmtQ?=
 =?utf-8?B?OGNnakc4MkpXVTJCNkw3N1ZuRlJMR1BwZWFiRHg1YmxiYWFDaE41aGcrMm55?=
 =?utf-8?B?SW9XbnkxcDJaQ3dQK0xFOTYrRVFwUTNldkYxRkZ3N1o4bUNnWVNTaTFGaHk3?=
 =?utf-8?B?MEVrc214bDRrbkI4L29OWXgyYWdtNFBVazhOMURKQ0k1eVdRaGx1NFlEclE2?=
 =?utf-8?B?N0JyZU5jNDR4T1ZOZlQvSTBKcFVRV0VpU0o4djNoNkZrOGp1d013MlZuTWNr?=
 =?utf-8?B?MmVBcWNEV3U1bXJaMldDYVNuQmxVZDFoeUE5Zkx4V0l6TjUyTnE5QUJ5YWxK?=
 =?utf-8?B?Y21Fb3dHeVJSblZhUHBPSG5kNEkyTm5SZFBXR2d2OVdmUmhjQ2txamFpbzVx?=
 =?utf-8?B?RTRwdmwvMXc0dlRneHBubE1xbWtBcEFTTEdtWWJORm81VloxYm1obFR0NXpL?=
 =?utf-8?B?QVRvOFBTYnpVUjltTHdjUlk3Y1BzYUVrd09hQlRBS1JpM1dPUStLQ2xzTm1i?=
 =?utf-8?B?MFg3MmxSL3hIbVEyZnJFM1RRYThpZEdSWERTK2NnVXU1ZWh6UnhNcXNMcnRo?=
 =?utf-8?B?Tm8zVTRVeHhyR1Exako2b3NFb1JobG43Sk5qZjVvUlBKZmpSZHkyS2JUSGg1?=
 =?utf-8?B?Q04rNzE4dlZ1VlhCSGczL2lCTkp4eFdoYm1xWXBvUHdUaWZacjQ4ZVlUMmFU?=
 =?utf-8?B?MUkzMjRSTm9DTjVXNVhLUTlkQWJ5SVgvZXkzaWxoZjJIYzZBc3R1aUlFNkxX?=
 =?utf-8?B?U1ExUExUbCtxbDJuNW4vZWdJUlFLSlE3Y1VFdHFkUzdjbXNVbEtUSndnbzR6?=
 =?utf-8?B?NVhrTFRpZ29BWTBVTlVUTnU0cVRmc3VhVWw0a29VMUl6aDZhMXU2WFVZZG94?=
 =?utf-8?B?UkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2PIwMewQca9Td4MiSoB0vrSeBTbWCVmrXC4ay2Or681yDQapO6RMPYWK6xhDE/9KzE2VuNl0einBLqfKbVzkmmuTQT/LahBwk7JtJ0dHe9/oxd08EnGcXxSkxzJs3lhFTRD4JQe0wJZ8pUMpu48hfjuDIy0vhg72zLF3NvWcyghyZVVYBaRpR2lqfx79eBmYaZ8pg2K9CfAI+/AyxGwxxOZXkcLOS3VyUkPJcoS2IgfWctubjvbJFUzxFTcq7K6EZeNLoczAjot3HEtf5dt36N2xp5q6bhofhJWd+xfKVwsk7igdEHU4zLchOwT/RTNJq18hIU8Aj2sCyCfWim1sBqu2MVlmh91zjJcFXviGcWmkFsjhHYhtK4XxFjjIW+9cEIpQSd8DMisL3T9aUhn3RHX0LrBPWscIt1i4SaeGl6LUIDgQMIFhH64DFpd6t6jD1dnz6aHiHvu1OVfCvTC4IWRP4OSBDG0GpO0lUYFDlJK1zK4ftrTIfaoAjfngOyLXlTnh0HZbZIWKZ5AAgkIpE3x8liN9TLOLtIsbjT6ia5wlpH+pHdizxP6TpBZdeVKOZRLeEMoGg/Jsl9nD6Li7MuJ/bCYCpVF23nVWVvBN8s0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e84e25f4-3796-4eac-9eb1-08dd150fdc5b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 09:33:22.4850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e4ep8C30VelE0ZqfR6tY7lJG5goPz9EwvEFiYMvptiEdBdBWpWza3MdEK1irQujbVRO8x2vxYXR7XqEyFJvynQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4593
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-05_07,2024-12-04_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 spamscore=0 suspectscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412050066
X-Proofpoint-ORIG-GUID: QXgBCk4300MmCJRWAblsxVxVJ2aWIpMB
X-Proofpoint-GUID: QXgBCk4300MmCJRWAblsxVxVJ2aWIpMB

On 04/12/2024 20:45, Alejandro Colomar wrote:
> Hi John,
> 
> On Tue, Dec 03, 2024 at 02:53:59PM +0000, John Garry wrote:
>> Linux v6.13 will
> 
> Is this already in Linus's tree?

The code to support xfs and ext4 is in Linus' tree from v6.13-rc1, but 
v6.13 final is not released yet.

So maybe you want to hold off on this patch until v6.13 final is released.

> 
>> include atomic write support for xfs and ext4, so update
>> STATX_WRITE_ATOMIC commentary to mention that.
>>
>> Signed-off-by: John Garry <john.g.garry@oracle.com>
> 
> Thanks for the patch!  Please see some small comment below.
> 
> Have a lovely night!
> Alex
> 
>>
>> diff --git a/man/man2/statx.2 b/man/man2/statx.2
>> index c5b5a28ec..2d33998c5 100644
>> --- a/man/man2/statx.2
>> +++ b/man/man2/statx.2
>> @@ -482,6 +482,15 @@ The minimum and maximum sizes (in bytes) supported for direct I/O
>>   .RB ( O_DIRECT )
>>   on the file to be written with torn-write protection.
>>   These values are each guaranteed to be a power-of-2.
>> +.IP
>> +.B STATX_WRITE_ATOMIC
>> +.RI ( stx_atomic_write_unit_min,
>> +.RI stx_atomic_write_unit_max,
> 
> There should be a space before the ','.
> 
>> +and
>> +.IR stx_atomic_write_segments_max )

How about this:

.B STATX_WRITE_ATOMIC
.RI ( stx_atomic_write_unit_min,
.I stx_atomic_write_unit_max,
and
.IR stx_atomic_write_segments_max )

I think that this looks right.

Thanks,
John

