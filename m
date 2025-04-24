Return-Path: <linux-fsdevel+bounces-47171-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBEEFA9A23D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 08:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 946BD5A3BC4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 06:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB0EB1EB5D6;
	Thu, 24 Apr 2025 06:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NDnCLUDW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kr78tJGa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB5F1DE2BF;
	Thu, 24 Apr 2025 06:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745476040; cv=fail; b=jX8K/AOEB+0H5harz4/MlIE1ve3cVE5FwOfg9XxYKk/3AhHUmJYb6egMNnqviNkGUPLUshtuyha5sMrAUXcgE5Do/FLIZEkwCh4aeawb3X5qjymS/VjtTtqa4FwNYQUgnHOKR20pJFK5oqengfoaAvQvQb0X/EWTPYXOMwqe2NM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745476040; c=relaxed/simple;
	bh=YmLDh9BUqVtv8CMohXcG2PVUcYa0//ZW7ThTkCiuIe0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=brAxkSZVazChtq+e0f5Ap6scjjxMzIWTjVqkcF84BHLv6hKFx6WyKH66w+kRy9VhNZ7W10q2GUnsMJ827GXQ4HBIvCTndtMQ6h00Qsm/Bd3jf0LJzOfPse3s+96jmeHLf4s3tzJq7l2zxisSWJmcNKfR6tjsRrPbyp8CZP98bGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NDnCLUDW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kr78tJGa; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53O6R1IK022233;
	Thu, 24 Apr 2025 06:27:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=eueu8qy/xkCJNe2gXbFc2tcbW4XTjQ9ZI3xMqXvm5Sc=; b=
	NDnCLUDWHxYaFHnVH4wWzb6IwRmNEm9DViC2nt02IE5HeQtwEUjNy6EwK79du9Cd
	0wb2k5ripsqFL91jth7MQ89Ke2vzB1xYIsm6BubeF8TFQgDE6589xSsVWOtAMMcU
	IzKDB8fSPCqPWhMmSZFcPiYvfSBzD0R1zFS2NE34fOd2Hq/05LyaggbCxUMZahER
	79+b/vzCtfoo13qwxLsa+M0e5d57ByGqTLb+iU8oJImapQBygClFszHU7itfkQ/N
	eeiLgUgbKO+1+BSarh9FohVcfgTMbn6CoJr2/3XGdRY2f0T6VZ4ROzOPQDSL1t4g
	PfAOahV0Fyz8zXwHzVUT/A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 467fmk819j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Apr 2025 06:27:01 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53O4UOUY039215;
	Thu, 24 Apr 2025 06:27:00 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazlp17012039.outbound.protection.outlook.com [40.93.1.39])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 466jkgmpcy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Apr 2025 06:27:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WTPIlrZoNmAhR5T3QCMPjZZypHPvQEckR3tfKvNN4qL49IfaYO4dZLWSt0vw2fY4O80KvKCul1tg3v65DiGqZV/8eu+r66l7allSrqd+NPh3hLdGCtKzM6uRyMyHglYSQzPs8BUaNECf2CopPCGd4id5Cx2TzDDPtIoT9iPeBy9P+nl6HsxQehlMXIklP1jTfvA6tmE2zPoJKindKQOiwATI6Axb9zq5HrtyeAe+SrmdPG2Quk3qW1w67438hMxgRFvJLGJObGOuKa5GWX2QNBZBn0Tx8SpMY+4+hXjb2ihlXsdFFVZnpmIngs7EJ1zbjLHJSAFBmeHQPxUB/2QGLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eueu8qy/xkCJNe2gXbFc2tcbW4XTjQ9ZI3xMqXvm5Sc=;
 b=WR6heTbYAdmblpC2PxIM9CPnIGRfZ9svmKCB+MU9KHJBXE7CLTSxZrxMWgXAW/bx6dXhVMb4ZVFwyY2I13xuDBN5AOGqc4cBfP9Z6r/r6gR0WuANeOqqsVu5Zxvs7wAIcsGnurkJFOFXqGmWai6zac4dLDkVBZQadhvxXlYBK0l7giGwFc3At6iRp5Uaguii8QY6l7GtAdra5nVKBZEotQc8+6NoTRt8seBN44/qvHJAR3XhbgpyxVk97kSaaA5DPUQIik5KXKf018wPVc0subg2ljMqnvt47wzwB/3DzzFN3RQH0sXqJcfskZKNFufYnWGkc8Rt6DkwNXJnMepZ1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eueu8qy/xkCJNe2gXbFc2tcbW4XTjQ9ZI3xMqXvm5Sc=;
 b=kr78tJGae8pii6uYtKhB1uNnUjA36SKCxEnBqiRb0243FcoxNLF7T9xunuvjQbLLbXyKJzLSVFna3Jnx4gsIGAjaLmD6oDyXEBqauGks4aL7Fo3DEGaudqJFywQYJ/jq01lgbbqoSS1KPxukFObqXjFXHt0WjzM9LC90IgEZg5A=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DM3PR10MB7969.namprd10.prod.outlook.com (2603:10b6:0:45::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Thu, 24 Apr
 2025 06:26:57 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8678.021; Thu, 24 Apr 2025
 06:26:57 +0000
Message-ID: <583bae06-9a0c-4480-ad9c-64c763e83f90@oracle.com>
Date: Thu, 24 Apr 2025 07:26:49 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/17] block: add a bdev_rw_virt helper
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Jack Wang <jinpu.wang@ionos.com>, Coly Li <colyli@kernel.org>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        Mike Snitzer <snitzer@kernel.org>,
        Mikulas Patocka <mpatocka@redhat.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Carlos Maiolino <cem@kernel.org>, Damien Le Moal <dlemoal@kernel.org>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@kernel.org>, linux-bcache@vger.kernel.org,
        dm-devel@lists.linux.dev, linux-btrfs@vger.kernel.org,
        gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-pm@vger.kernel.org
References: <20250422142628.1553523-1-hch@lst.de>
 <20250422142628.1553523-3-hch@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250422142628.1553523-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0269.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:194::22) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DM3PR10MB7969:EE_
X-MS-Office365-Filtering-Correlation-Id: f645090e-294c-422d-77cc-08dd82f90364
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RW52cUUzTEpwMmFEUG9KZ25nUXdBM3NvVUk5bE5nZGFxdCttaEQ5NUVGbWRk?=
 =?utf-8?B?OVkwS2xvTzJ3VWdrWnNNdDV4TGN6SEgvZ0VJQkNCVU5LNFMyMjYydkdBL09I?=
 =?utf-8?B?T0EzMGh5MkdrWmhoeDVBcDNnSFAzeFk5L3JqcjRxT1NSZzZDOHU2czhUTCtJ?=
 =?utf-8?B?T3NvTXdkbG01RHg5UDNRK0x3MmJYa2U2dS9lUXZiZmVabk9Zbk9TcHJYa1BP?=
 =?utf-8?B?NDZmd2xtODNEaGEwT0paZ1JzYmN3T2lUbmpLK0FlUVlrT2NVU0RxZmJVdXdS?=
 =?utf-8?B?UEFEQjdlc3A0dUttZEptYVN1SysxN3RUZHpXTTZ2Z3l5SjR3NFNlaG1TUHM5?=
 =?utf-8?B?VkJubXc4MzBEUnRXNHlZUnZGZ1pjU2JCK3AvVlkzaVZORjhQc2EvT1lYVG9O?=
 =?utf-8?B?SEFMeGpOM293R0hKaGo2SUhIQUwvODFNVnN2b2JKUlNNNUc3cUFIVkc4NFR5?=
 =?utf-8?B?U25vcFZiUUxPcTd4L3J3OVFTWG9GRW9rNS9yU3VuVzljM3lNWi84N0JqZlNY?=
 =?utf-8?B?ZWlVbmRmRUQyaEVxYnpiZk1JTGJsZkcraHVLd0JDclF4UDIrSFdOODlVVXRn?=
 =?utf-8?B?UDdxMU0ya1luRmlLS3pQN0VMZjRId0svNGtGVVdXaTJlWmxrS1U5M1B2ZDAx?=
 =?utf-8?B?LzBhdkRUQzJ3WTRKcUxVTHVHUGpidmFSYkRYMWdUbzdRbE5heU1VOG4rSjFG?=
 =?utf-8?B?ajVNQ1NUSWpsd0c2TXloVllqaDJrT25BK3RjZnpKZW1oTjJGcU52UmJWRXhm?=
 =?utf-8?B?VlpDRUFyVUZSemNuMXFmaW5zQ0N5MmVQUHBLdmdvOWRrZy9uMDRpajltdC9l?=
 =?utf-8?B?Wi8zSmpyTjJCOGFXaUZacWNDaXY1N2JoT094aTEzTS9oaTVrSUV3YW5TOGZH?=
 =?utf-8?B?aWt0TlJpcDdXcFdBcDg5eUFGLzZrWWR6VFhOOVVHS1orN1gwTmtjTmFwTFRG?=
 =?utf-8?B?YUJ5NTA0U095dlYvNExabERyQ2RkWDhRaG83UHRlZ3RwZXNGUnBNakIzb3lq?=
 =?utf-8?B?em9LRS9oMTM0SGVSenBuTlcra2VwbitLR0VXR1VkWmU4UllScWkxamVKejN3?=
 =?utf-8?B?Q0VJTFZObzE1S0wwMnhHTjlHL1lrZCtJaXRraFBjMkRDMWJ4bmtvYWRvRDJk?=
 =?utf-8?B?WW9UZE9la3Q1WkRiNlFXWDMzVFM5dGJSajNGckRhREpMUHJyd29IZFZGcHJV?=
 =?utf-8?B?VzBsbnBZQ0ZUS251NXJZeFMwdEVuVElXaUMxbWJyRzduZlpUcmhHZEc0cWRq?=
 =?utf-8?B?S2FVTjh2L1pIRUE5L2xnT3RHVFd2THcrSjgrOG1mY1U3clJiY1RrcjJ0Y29r?=
 =?utf-8?B?TGtUTnRVcVNLbjJEVzdWZmZ3VmtsMm9pQU9hSEkzaUhvbVd0ZnZVN0hlS0pj?=
 =?utf-8?B?OHhrWndNbk1ibWtGaEVZVnhaelZabWptMU1yYmcwQ01kREsvemtHRDRFajho?=
 =?utf-8?B?MHhBc0dEb2ZKNTVYbXNMZ1F6ckpCT01vdkhiK0JrMDBHVE01dmJwYlhvYXJy?=
 =?utf-8?B?RWxVdEI5ekEwTTIrTFlZb2ZHbmphcmU4cE1KUGpNVGw2Vy9hMlcyVGQwWjll?=
 =?utf-8?B?ay84Q215QTI5UUp2eENNYXIwVGJrc2dWZWhPc0tsblBTKzBndlZhVGVvRms0?=
 =?utf-8?B?aE1XSW1mc2h0RldjdzNXMW4wbXd0SDlCdXp2Z3BuN2VyRmU5SFVKeitmbjJy?=
 =?utf-8?B?QXhSR25sS2E5NFRTQVBKSWhhNTJ1UnQzQTlsTlpYVFJaaGVRcVYrSFY4Nm5w?=
 =?utf-8?B?Nnp2QjlrblhFT1JCaGpKbG5xQmc5MUVjVHNNcjFyWXo4Q3RsVFJnellzYkxV?=
 =?utf-8?B?aXk2UnlmNlFOTUdXQzZ3aU51SjNKSGlQUjIySkdjektYWWNFOGMzTk0wZDRW?=
 =?utf-8?B?andGbHpHVTRqWEI0S0ZyNUlPV3Q2aElTM05UM2ZjS09KT1Mrc3Y3SExoYjNI?=
 =?utf-8?Q?p+mNpoHYmI0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?clJORW4wTWJhOGk4K1JGSGVjbVRlTzlENlhlOFpXVENDMExkL2txWC9KSzl5?=
 =?utf-8?B?RGFNdUxEWUs5cWNEYk9Xa05rWjNidGQ4aEJ1Q3pIQk42bkU4YlJMWE9SdzNs?=
 =?utf-8?B?SVh3dVVUT3laempTdEM2Nlg5ZVpaTno3MHhzZm1aV0RCd1Raa00wUGwrWEtN?=
 =?utf-8?B?d2ZNV2w1STZHSG5aT2dqT0wwM3JEQ1J4Q1gyZEVyVWNjUnpGaDhTSzIrajcz?=
 =?utf-8?B?NnRIUmE2cEtGcUxhS3I3enYvQnVZNjZqRzNDK081bUVmcTlyeHJpY2xMTW1W?=
 =?utf-8?B?Q1JrN0pHaktLZGtjVlZnU3l5aDBPaC9uTkRxK2FoTGlLN2FvUVZVKzNCcXJO?=
 =?utf-8?B?akJWTjRqaDJCS1RVNExMMFE2NHAzcFFXRzYzNDRUSjM2Wm5UMG8xRUd1aW9I?=
 =?utf-8?B?ZXpRV2EvS1RyR3JTdnJFQmRiSm91ZlkrMFZ0aHdDUVNROWkwMXZ5UWxpdDdJ?=
 =?utf-8?B?SEV3R3FYQ3haWFNxdUdCNlZmWmMwa0dXMlcwbm5oSDlGT2liNFdPNWZrUzF6?=
 =?utf-8?B?RTVCOG5kenEzbmZmZjlJTWR1aFZNNmc2bU53N3RlSHB1ek5JTlZFMGk5bHpZ?=
 =?utf-8?B?WThqejgzVVh0TjFDZHpNb1FnMVJqTWI0Z1NUdXpDcUhzd0VBVEpINm02U2dX?=
 =?utf-8?B?U1ZSQlBiWS85M0JYb0FlV3FFQUg0cHIxUjY2aTNtY3QwRVcyYU9CQ2x5RFF6?=
 =?utf-8?B?eFIzS0NhMy9mRlFTYWxRRDFDRG1MakFhLzlUazgzT1pOdSs0OGV0Uk5lclJh?=
 =?utf-8?B?Y1NUZWp2SU5MYlRNc1lKL20xQVFqSEhHVXZ5QitkYmliOVpwVWk3b3VuK3BV?=
 =?utf-8?B?c29GZm5pUEcxaVNyRGREY0U4YjJOUUUrSWRCR2VqajVjOFFLYjVNQTI3amNH?=
 =?utf-8?B?bkR5RjVqekh4NndvMENlY0pYTllmdmxZOHJYRzVzbWMrY1NCcWFLaW4wYjJm?=
 =?utf-8?B?ZUwyWi80cDFiTlNJRGhlbmRSbjN2UlR5OE5HdVl3NnZwRlhjL0ZPNVR2R1VZ?=
 =?utf-8?B?a3FveXJrc28yWWJxUlRNd1Mya2xWNitiUzc5UzFyWDAwVG1MYitGSjAvb1ll?=
 =?utf-8?B?aU9hd1plSFBpYmtneTBuRmxlN1puZzJibHVEWTdQTHkxemp5cVo1SW03Z25i?=
 =?utf-8?B?cmxUYTArRExxR2R2VjlMK20ybnB3SjFQSkk5R1FFR0hBdXRML25Vd3hGTDFN?=
 =?utf-8?B?TjhYRlo4eDQyY3BKQTVoc2VLTzliY0plNmVDMko0MjQ5allkalExWHFlaldE?=
 =?utf-8?B?cGZnS3FwMS83aE4wRnRobUFwQXNkUDYxT2FsajUzLzE3RElZUzFXQi8rYjYz?=
 =?utf-8?B?ZU85cHVwWGZVSllQNXo3NHBrckRVek4vZE0vREhNQnZKVUlsSlNKcTB5MWJ6?=
 =?utf-8?B?NlQ3ZnJuQ3NBbkZycllsMVZRMTUvaDd2SUQvaWlZZXAzRlZBNUV3aTVHZzVT?=
 =?utf-8?B?Sm1BL1o4Sk52c0JiT0Joczhrb0l0Zkg4UE5EQlBwNVJRSUZ4OFVqUU1IQ0Jo?=
 =?utf-8?B?OHBYZkd6a3ZTN0VLN0ZmNElJK3FvMklvM09kQlRNdElhUzFsMlVNVkVnV2ZI?=
 =?utf-8?B?eFZiUjUxcCtnTE9MTE9RSk9UZkl1RFV5U21wYkFoRGtjTGhhZUs5b3V3d1VR?=
 =?utf-8?B?M2toVWpwWTRhV3dsWXJsNjNEVFJxRzJ2NUxsTjMyRWVQZ1FYYmF5SjJDQVpE?=
 =?utf-8?B?VHpSZ3RCT3RtVE54TFJlbW9mZUZBQWNqdmVQS25XUGNyRTYzbHU3T3Y0U1RE?=
 =?utf-8?B?OXhaMW82cmJEbWZ6N2xaUEdVS01BUXFablRaVHR2Y2RweW1kWFlteWUvVjQ1?=
 =?utf-8?B?OGtJYWp3TUJQckpOc1VoNjVRTnVxaTlzYWJ5dkxiNDVGVGFDQUNFNU55aFJW?=
 =?utf-8?B?Z0ZxM1RCRnNNQ2EyZVpQaGtSU2o2cjN4M0NZRWZ5T3hRK2Zlb3VaTlJxcFVZ?=
 =?utf-8?B?UWxCMUMwTmFqaUZyT2ErYzdQTkk4YmlScmJycjIydktpcjNOZ01FWHE0WkJC?=
 =?utf-8?B?dWExTFArN250RlJybGNqT0plN2FRUTN1YUh0OEFZbE1QRjJVYTJNQmRGOTlY?=
 =?utf-8?B?aFBFbWRLYTF5MnYvZEdKak5pdEN3Y1BROE0xRTBBazF5TUxnbXlTVm1KaWh6?=
 =?utf-8?B?blY1U1RrNFIrN0M4NWUrMHZCa09yZDVwdVFpMFhnOTFPRGxOSVJKSldIellp?=
 =?utf-8?B?YXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dniDM5d3DX/4TZ5XoVpGD3BKoRZwB1PWfi9Ilr9UGc+5l+laBikmv8YJchqPmvNpijHYt0YhEHkrlbza0uinWXgUYLpxeUTCbOJQ+0jHynwlhFeU9T9haZSee0IJaiej2cepQxRK55n7nwovhVPfQx3Xo+atinNccIlsC6f6WiS0IGZ7GafELWTHbqW22RaELF2AgRzlGeL2WdwwcNtcPF8hsxqnLWVnZXX5dhidZEzFS1ZNzUJsGqtxNm9PFFGQalePMwLV1egNGYe8SzlRv+cVlbOAJ+MC3eKGj0VQDqD+uFtNSvR9vdYFD4wpiJ5kHpzPe2upLKUywh5fkxFWXSkPwgcJMoxThc1YHUWVVzrS1t8plXpvW8dtvdeRea+uqh8FiyKUUtbMhMydSYYMyq3wyXJstRtzOVLuvJ0pTkMgEGYRi1ZCwz0vO2KD5Is4hbC8zNs+I6Kz1tFfDwKqeqgblgY4/I7hUjKnqlxcY6KYt+lAwR0voqBgZn+LSeKVFoiFS3bQ8tE27v2+Oft0zk5YMNXt6zNgCEIaVC2EZCFBc8DUCHxDIAyifFlpxYCPEiEled87GWTRFzdg4NVDq7apikcL+lnT8/hOPRXDROc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f645090e-294c-422d-77cc-08dd82f90364
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 06:26:57.3935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mt0Kheede5EvrjhtFPg5qRfEDJAvi4LTHTQIFBg8oxT3hYF02atOt6tuM85EK2f7F094zu9+BMMvxOLDXi5LVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR10MB7969
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-24_02,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 spamscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2504240040
X-Proofpoint-GUID: Pzhbqckh8kPuuBEg6kM5xJVnQyVBsq76
X-Proofpoint-ORIG-GUID: Pzhbqckh8kPuuBEg6kM5xJVnQyVBsq76
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDA0MSBTYWx0ZWRfX6vZ1t8vjF6Dz XHfSV6DvKNDmj91cD4kmcX6eEHDqw1S0muMTBS+Vos+ayqaSsOsHBWLitenJuVyCxDPYZEPwyw+ HKc0dDonQM83hI5/bO61h9TyLn3rolRRrk9aXkEOVL0oF9OZpAUi8dRSSX3NjwF+0gO8azww5MO
 574e/p9t9qRMA808IfvuVv6n+HC8rmyff/YiKQQ4tKgAFD5R8fj+Z885VV799RrAgbaBxxfYFUR v29NT2EVd68k3jlxvFK8UhcvIKRQNbtAiyxOwrmn4ChdkvbIyg/3H6vDfXRm1X/xIm94Hq8D0X6 mayuur4iFenSgmUDWhKBtT821shDWFmnzb+Z9U542K3p43TSGzIuEjtiauC22PPzvsDYopmDjr1 qy3LCUO9

On 22/04/2025 15:26, Christoph Hellwig wrote:
> + * @sector:	sector to accasse

nit: typo in accasse

> + * @data:	data to read/write
> + * @len:	length to read/write
> + * @op:		operation (e.g. REQ_OP_READ/REQ_OP_WRITE)
> + *
> + * Performs synchronous I/O to @bdev for @data/@len.  @data must be in
> + * the kernel direct mapping and not a vmalloc address.
> + */
> +int bdev_rw_virt(struct block_device *bdev, sector_t sector, void *data,
> +		size_t len, enum req_op op)


