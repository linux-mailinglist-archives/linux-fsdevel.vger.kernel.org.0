Return-Path: <linux-fsdevel+bounces-43786-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E52BA5D81E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 09:27:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FD4B7A3FDC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 08:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF03923535A;
	Wed, 12 Mar 2025 08:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="USrIN310";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="C7/36dlI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6A123496B;
	Wed, 12 Mar 2025 08:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741768040; cv=fail; b=IfbUQfdV/5f5nuHpRzYy7l0er5GV8EOZrF6UsvD8/Tq33peImblcPSTZ8axAk3dl0/8kxVPGA7I+bwUmKdNq9FB4WOGSOEMb7K2a9+7I/xyP69JO0mzxjslNgANVfZqpk3iMtO+TqTW2E+iKZJ4F6iaoCJqkjaWR25t12upfX68=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741768040; c=relaxed/simple;
	bh=NVkHk/yryqmXy/BhxAAyVveSKTqEtLO5JH0RRXF9Nr8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MA/+HkPQmG3SmI1sxb0FfrcVy7ziU3dBRBq6WcY04sSYowceJLLXWJ9uiILZbOc3Pz/ANO5lQhblL1OBGsD5BXpxOsAPzsAhTPHVkvnCU3Wno+snDeZTkubrg4WdnJE4TdMlHVlb0dmeede6ft/wawze1+9TmWJj4EeSTGw7Cr8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=USrIN310; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=C7/36dlI; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52C1gp4q018000;
	Wed, 12 Mar 2025 08:27:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=5bhwAwN2+i82pkmg/0a9ZYs+MmtZZ1BKAHTuO3A2gaU=; b=
	USrIN310L4F+1NWQnVEmaE0wjKSOS4xVvZoONjfN40gpytyf0CcghVzZ5tPRIDim
	aK1E6UuAeA79VZbAifxZqXLv7KDVf2c7zpPh1j70ric2C1cgATyU7n6o/NIjXCqT
	m+Oj+QlGYim+szFUoRgsk15ypwUxf31jZgyyNqLV/b0kk/QHOxaij7eAaM73OeFU
	wCVmZNJ4W2WSuGlI5ZhBX3HURPG5tXmxT/qOpyXnFql6Jjei/i6PpEwq8JjhXmdw
	sqARa+KbIeBsJOyyjAzLrqDSeDr0+stK/W6MjpMH6UW7Yc8qQTVuiSzDSaiBj2xp
	/3yavsPpVvOQFXzngw3DUQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45au4h95t4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Mar 2025 08:27:11 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52C7DUob022360;
	Wed, 12 Mar 2025 08:27:11 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45atmuxvv7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Mar 2025 08:27:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ayf+rkDRKUTHRP7PI/jVJLi/npmAl1ujwrt88BMhbezB09vDuWnjsF1quiZ5Ztk8YfDZccmq0DZW7bvH8E8j/ecYP0YZaiUqM/84uYiEMI+cOGbveuDeZpknVQv453ubzNR8l/5i6AqQwI/3E+YnbxJ+IR+YILSEpIXdvwxkH6evTlFjuRSaNoaFNEKZnIviAiVTEd7a3xVgM/itw2G25+dBTbL+8ki+QnzCYF/O6cl3bNQk9RUjW7k4YpFcT2s2yx7tBnwqoZib7XE6gybe7/y55/Vn/X4QuXb6LvaI9wIB+Oj3jPlfYXIl3JwA8fgZGi2WCI0jNZDFzdXJ+ntuJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5bhwAwN2+i82pkmg/0a9ZYs+MmtZZ1BKAHTuO3A2gaU=;
 b=smbPxDb77z8vPyZi6w3f+XPJyFArWw2bFfsm8GfB/sj7WSUgjkx7ftEfWtIPAiQRhWhoHpIX9jb1S/3PjaPbd0moavPsvEK29nvYZjGLyM6Ph+CaKxdLv+5V9QF1CNf+P5vgvbFTaZjNxA6YLwc+OKN0Ervrm7H1b8gqP8N8shZNHEEACDQtuSwZAH7oxF3RMEnYVExMxxmk9q9SUQobnM1gEjT/5XTTjnTXg6nCoQE5kO9tglRD9eBts+40q5sCDN75deR0Mf1q0jZ7PVCF+aWdHcw/qOeSUzSIITX/BAvyJAi6V5nxnU3Y28M3eMzpjtm9beLU8xz91KJrFx+/4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5bhwAwN2+i82pkmg/0a9ZYs+MmtZZ1BKAHTuO3A2gaU=;
 b=C7/36dlIMrwmTtq8++/zSfHUM6wyJ9V41gr8mHNaTG4zwWGiWPwKRnzhp4jt6Qy5p/u+S2CCn1e6gj03WcWOqM8z11i8OeK6xSHxpzI9D6WmzD9FMkmjEb9xZUnVBR0e9+Er+0yaExVl4BPHID3UBgjrA7VCYUU6pF6aSx+QnKw=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SJ0PR10MB5581.namprd10.prod.outlook.com (2603:10b6:a03:3d7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Wed, 12 Mar
 2025 08:27:08 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 08:27:08 +0000
Message-ID: <589f2ce0-2fd8-47f6-bbd3-28705e306b68@oracle.com>
Date: Wed, 12 Mar 2025 08:27:05 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 03/10] xfs: Refactor xfs_reflink_end_cow_extent()
To: Christoph Hellwig <hch@infradead.org>
Cc: brauner@kernel.org, djwong@kernel.org, cem@kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com
References: <20250310183946.932054-1-john.g.garry@oracle.com>
 <20250310183946.932054-4-john.g.garry@oracle.com>
 <Z9E2kSQs-wL2a074@infradead.org>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <Z9E2kSQs-wL2a074@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0161.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:188::22) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SJ0PR10MB5581:EE_
X-MS-Office365-Filtering-Correlation-Id: d834d998-004e-4d4b-84f7-08dd613fadc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Qlh6ck9JdDhFYmc1VCtPa0FqQVRoR3hRalp2d0k5YkUzSUd5ekdudkcyKy9z?=
 =?utf-8?B?ZTZPeEZ4SkhnZENnVTRqckpOUmtIajFmaHR0QnUra1g4OFNXSldRZ2V0YkZw?=
 =?utf-8?B?Z2VBUnVoRlJ0VFZKZGZsaE5EWFI1cDZGV0kwTkZVZVhxdW9vdjg4YTBRMmxJ?=
 =?utf-8?B?ZHJtNEtNQytwT1lpQldEMVRpa1Z2RjFaQjlqZHRRcC82NXloZUlOdEdyamR4?=
 =?utf-8?B?RlgrS0xFUW5zSjlHb2dKZnpjOXZOSit1enlybXNTYXdQTHQ0c3dyaFpXbndF?=
 =?utf-8?B?WEJqQWxZbGdHRVNkWUJwcXE0L0ZUR0VoVWlOamJ3aG1wMTQrRmJSSDFmMzFr?=
 =?utf-8?B?S0w4RTBJMjZOYVZia1pGTUtIaWJ6b1IvNEUvaWJqdVFjUzFFb1hHZEloTjR4?=
 =?utf-8?B?ZVBIN2lrV3JCam94M01iQy9Wd0hwZUxzZmFMcVF3T0Z5RXhMNlh5cXdpWDZE?=
 =?utf-8?B?NFVJaXptdUFGNHJKUkVOd2RveUlSSzdlSlNjdU1vektqV25YeWhLeDNnWTJv?=
 =?utf-8?B?RUpwUlJORkdtaE96Szk5VjY2cVpwSXNSMDdIRldXNFBGZFVHUkVpYW9KMFU3?=
 =?utf-8?B?Q014Z3RFdDJxS3k3Q1FrWlg0Uzk1OUt2d2ZUZlNmYjZKcTlza3NtblArZTNS?=
 =?utf-8?B?RGRPa1BoYjhDUWo1ZWFITVcwS0xZeFJrYk5lVjAvMXlKeWY1bjJzaWtBWHZH?=
 =?utf-8?B?c0FMNE5yWFQ4aEp4Qld1eXpqVGdkZi9SN2E5ajZ0Wm9vOC9raFB2Z2JsSTBn?=
 =?utf-8?B?K01SamVZMWVnNVVlYS95NW1Id1JteVpJcks4cVVyV0RCWWxTK05XR0NtVVVq?=
 =?utf-8?B?WU1WTVo3bjlUWUpMbS94b3ZNN3RCQytLTS90ZnE5M1NYQWZoQzhUQ3dqdDdU?=
 =?utf-8?B?eEVScE95eWg0UUVWNzBaUDBDMnJpVmRQNzBuYTlVOUhjbE4yVWVoeDFDYWdN?=
 =?utf-8?B?bWI1NEY3K3lQdG11OFFzS3VRSFBWN20xbXVLcU0xT1UwYzg3Ylh2Q1lmV2Za?=
 =?utf-8?B?ZXpleFJlYWQ0TWdkNzhEc2hXejl6RmdMbnN5UnZsMU81NWxRRXVBb213WUt6?=
 =?utf-8?B?MjlwV3g2aVhnaC9wakVxcVRBSmJRQ1hFQndHM2VZYXBTdlBQVUNlUWcvVFg5?=
 =?utf-8?B?TExMdzgvS3JQMEhFMUVrSmJxT1cyQ2ZqcXhOdy8rSTY3R0lzb2swbVVzamdU?=
 =?utf-8?B?QlV5ZjIxYWxDK1hyb21VVlpadEZCalhmdkEzcG1HU3JhL3M5S01GbWpReTAy?=
 =?utf-8?B?ZnRHcUNFUThJeFgvYnNyM1pqR0hkcWNOa3RKSDMrRkhabkh4QlJCMFh5L3dB?=
 =?utf-8?B?OGplMW1rV0NNM2JrWWJnNW9NQ2VMYUdqSjNyRFZUYS9zeitSUytZUzFockxy?=
 =?utf-8?B?WklVY3N5bExyamd1TlUyRGt2TGhvSXhRM2ZCcWpiUHJTNnlpT01rdVJ5VVFq?=
 =?utf-8?B?Sy9xUXg3d3g0cUx3c3JLRVJDcyt1SGZKejZqckZBMTZVQVR1b3VuOUJPQ3lq?=
 =?utf-8?B?K3hFYzhOa29sQk1oWmppMXRhOVBmN0E0cUl6VjVJMUV6YVF4Rk1udHNMVDZY?=
 =?utf-8?B?Mm5QSFJsWkhHR1h2Z2plMnJaaWsrS0c1eklQd2JLZ0NFRU9nd0pqVlRiM3pt?=
 =?utf-8?B?UzJDU3pFSk9YeUdQUjBjRVU0ckh5YjFrc3VnakpyU0lGVDdSOUNPTHF3ak9a?=
 =?utf-8?B?cHBXTndLSlZYM0VSUFBra0hSQVJDcDgzRllBNWJRMkNMY1JDN2IxQkRpQkdJ?=
 =?utf-8?B?L3JIbDI4cUF3Vml0QmJYOFVMSStCL1JtVTBPblR5UjJGUDROcUR4UDBseEd0?=
 =?utf-8?B?cTBXeUl0UktTRzJ2WFNISVlGTjZEc1lnY0ZnYnhlM0NDZHBFbVZ1REt2ckJI?=
 =?utf-8?Q?uMPa/XhiDWEFK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dzgvdFg1bk1COHlmclovTkFoSzdsemdoeWdhWW5QZm1EMkZyWk5pbTg1cEts?=
 =?utf-8?B?VmRuS3ZUZzljbmwxOU1YdDhJK3BDbFY2QnQ2UWIyZzlWbGN0c0VzdmZsd3VB?=
 =?utf-8?B?cXV2R1duUU5acDZ4M3NlMnduVEtydG81Zjc4RmdhVFA2Z04rNVBrSEhhcGVE?=
 =?utf-8?B?cnloMGY3WnNHTExvTGVUMDRiT05aUUdlMnAzV0RxYWtRbHViM2ZUN1Y2VVRK?=
 =?utf-8?B?c08wZWc5K2FtSU5mVitaUWNUU3RnUE9nRG9NS0lnRXBBRUJ5V0pQVGRrdnV2?=
 =?utf-8?B?VHJ5NHNaK1RRV0lhaXVKU3R6Z3hTaTZNYlAvblFCQ2NLcGdwRDhCcDVZd2xL?=
 =?utf-8?B?anVxeW5MdkFrakx1T0hjS2VIaTF5b1hBTERsYjU0U2NnRUhrS0UyZjl2NER1?=
 =?utf-8?B?SkdVQ0pEdGIxQ2VLQ1NDWVZJM0w1UHFzby81S0F2MnBSRGZRai9wNW9iUk4y?=
 =?utf-8?B?UHVLN0g0ZmxyN01JTFBzRnpJRVU2TlV0NFR0Y1l5YTNYTGhNRTlCalBQQUM5?=
 =?utf-8?B?Q0twWWhTSnhBamFzUW5JbEMwNGcyU3NIQzJiRUpreGVRM2xlUzlCSGRRWEFU?=
 =?utf-8?B?OUlMTTNtb1NVY3RqSzNleGZHK2NXUC8vNmZlTXVYUzY4T1RLamVHNXE2T05T?=
 =?utf-8?B?cytNZno0WVFwL0RkcEhxcFdUenEzYS9tSERCTEc3bEUrRERIVXVrMk80eUdo?=
 =?utf-8?B?clkycUhEZHZQNWtPMFZMaENzTUkxZVVXS2ZUNnE1d3dDTEZua0dCejByaTFL?=
 =?utf-8?B?NkVNZzlmQm5BQ01hbzNweUlUMjluMllMZk1NcE9sQWZ1MlpITGZBQmc1NVhS?=
 =?utf-8?B?ZWZoTDNjanhYSTQ4RUxBYjNuTjYzZmRvREZEc1BSZXQ1bFRnODRpUjd3Rk5Z?=
 =?utf-8?B?UU5Fc0RBVHJIZVdvZzMvZkhjNUtiTUEyNU1xQU4zczRpcVRqdlRmRFlkR1Ex?=
 =?utf-8?B?RG9QM1VQS2tOT0c4TU1jU05zemVVTi9XNlBoS2pkaGxRdHA0b3lsdUVMTGJz?=
 =?utf-8?B?aWI2dGtoT3BHSDh0Q3Z2V0VRQXhZSkZrTEF1VXc4ekNKOG9kbGozbmM4Tlpi?=
 =?utf-8?B?UTZJWTV6cEJ6M0hVcy8vbUZLelRHWVROcXIwcWxjV3dJdGdVRUZZV201WFRn?=
 =?utf-8?B?MURjanlxUTVtcVEvN0JqVEJTbCtnZG9rS29RN212WStTZ3N3UWJYQ2hyVU91?=
 =?utf-8?B?STFqRHptcVVIQWZnSXFvakZLd3VlV1pLMXdCWmhJR1BWL01sQzhwcE1wTHNX?=
 =?utf-8?B?VUhid0dyVnJYM3JkSHREUHY4d3VLRExDV0ZRSndTQXpTWEFXWHEzRlJGTEV5?=
 =?utf-8?B?aVZhd1JYUlJ0Z2U1dUhleGZ4S0RRRWo4RVIyQmFCZVdpRXlYRTIzMXdHZUxr?=
 =?utf-8?B?TFlRSk45R3V1Wll0WkRtMjBneEgzUHd4Vk5FYVFFUGtOSWlKRGZKZHlJOENv?=
 =?utf-8?B?STVZYzNaUXNQQzJxY1lTNHdRako1WlVwakZvdXVWMkVreHV6dmoxdmw5Z3Ra?=
 =?utf-8?B?ZWl4ZXVTN01zQmJXS2IrNGJ6RWx1OVFKQ2dSbTJLaTB5Kzlza2VzRzNDWDlq?=
 =?utf-8?B?Uk1hODN0R2NnQ21Xa050bjFrME1LZFVXa3B6K3JNaTRWUFJqQlg1UjltTXRq?=
 =?utf-8?B?N1RiQzBJNGFHbTJIeFFEUUxVUDZ2YWtKVy8weHFCNnBQK1Nmdm5aaEhBUDJI?=
 =?utf-8?B?engvZ1ZBOGtBaDZaK1VPOGdyWTFPYzNqKzdxcTlZaWtTS2grdnBBV3F4OFR6?=
 =?utf-8?B?dXpIQlRLSzZ2YkgzSGYzeG1mYUxRYlRZOStRVDR6a05MNEs5YnZPR0VNdC9q?=
 =?utf-8?B?TlRkQmpBV1VEZjNsV3MxU0VEMHltNm4yZU5mZXp0UDUyOXdZTGR1bVZWN2ox?=
 =?utf-8?B?VlJYRmIyNHJ1S1kyNi9PMHQrdFNaU0kvSTlCdm9SeDlhQmdiZ0hXdzQxWHY3?=
 =?utf-8?B?N0I4cm9ZSWVycDdxN1RVaUZyMmIwMGdlTUFFM0Y2ZjNJMXhsQmJnS2pOQkdt?=
 =?utf-8?B?SVlnR2h0NkV4K1NnYWFUMkJBSmZMRXJ6N094emtvWkdLZElzYzhHdXJlclhz?=
 =?utf-8?B?b3FjMzM0QUhzbHFlUTFEdVlUYzkveFUzMk5CSXVZUHFmL296ZG9INGEyY1pl?=
 =?utf-8?B?My80VTVyRFJ3YUlZMHc1TjZWY09CcEpQWFp4TjdFeTZSdGJGekZCOU93Vlc1?=
 =?utf-8?B?Y1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	EGsAxC7gZSkSY0GMmFNJNUBhRatm/TV/3a9SfGfh1nOrcKKRUXatb8DtiuFKIJbM+FbZuzdg1mkObvmnX4DIbps0RDcQ0yZJQp9pOb+JMsBD10pEjirBztFpkcRcBW/aQOiynfDyrD24PtSazuWxB6LsML+4AYgDXVG2uCAcO/yFDDxFuEGwNMdbRjPrfEq95PoUu5pEyQanH8nXcCbTij0qNXH26rKX2M5UYE7OEEDHM40ibrvrL6DtjymrsWBYvE029pSF5JKk40hRebP4RyktToRINJxiFCg2Eoju7Z5ePMSAINc4wikmIgQnVmSkczuUDPrUMyhsvKBtJuh4ZR8SN9ttyBOzXpx/S7EkzDhyZQWZIrluqnOKzLWnl7ITzcsYlLmJiXmLfu67oK/tybg4I3Lj3OMmE2yGRzCrPdtoZEtywPe+csycW9IisqCgQPpDygHPlSEcWyl7sGPdx7pI5ob6b/A2WPsor/pV2m8u9Z26eOJvMw3jY1S3kj7ZVtHxKFXaDaiyY9OPJdlo0FgnWLrNax1UsZiwjn5yjEMisXvqwzfr33nllhg/GXgUYi3uEYGYbthvGeWDbzqpRHd6QWEAW77jFIg3TM8DI/c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d834d998-004e-4d4b-84f7-08dd613fadc6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 08:27:08.5097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0SmVWRVVfjJFSfYZs/3ZuNEAL2Q+LqbiKsBDj9E+iPHaTnziCRGhlTTUNykaJfENvARRa2UTJbTFf2iOwJnreA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5581
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-12_03,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 mlxscore=0
 spamscore=0 mlxlogscore=898 bulkscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503120056
X-Proofpoint-GUID: iEpjiuGCRB9jzS1RTseKLkkHtqr_SWfC
X-Proofpoint-ORIG-GUID: iEpjiuGCRB9jzS1RTseKLkkHtqr_SWfC

On 12/03/2025 07:24, Christoph Hellwig wrote:
> On Mon, Mar 10, 2025 at 06:39:39PM +0000, John Garry wrote:
>> Refactor xfs_reflink_end_cow_extent() into separate parts which process
>> the CoW range and commit the transaction.
>>
>> This refactoring will be used in future for when it is required to commit
>> a range of extents as a single transaction, similar to how it was done
>> pre-commit d6f215f359637.
> 
> Darrick pointed out that if you do more than just a tiny number
> of extents per transactions you run out of log reservations very
> quickly here:
> 
> https://urldefense.com/v3/__https://lore.kernel.org/all/20240329162936.GI6390@frogsfrogsfrogs/__;!!ACWV5N9M2RV99hQ!PWLcBof1tKimKUObvCj4vOhljWjFmjtzVHLx9apcU5Rah1xZnmp_3PIq6eSwx6TdEXzMLYYyBfmZLgvj$
> 
> how does your scheme deal with that?
> 
The resblks calculation in xfs_reflink_end_atomic_cow() takes care of 
this, right? Or does the log reservation have a hard size limit, 
regardless of that calculation?

Thanks,
John

