Return-Path: <linux-fsdevel+bounces-67262-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C0EC39777
	for <lists+linux-fsdevel@lfdr.de>; Thu, 06 Nov 2025 08:55:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 554333B73CD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Nov 2025 07:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C3C42FABFB;
	Thu,  6 Nov 2025 07:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TVkmQD8r";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ElkhceSq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44242F998D;
	Thu,  6 Nov 2025 07:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762415728; cv=fail; b=l3uVIJQUEGbV3GGYrzjl3gYe73ivK4VVWaxacBBJfWCDSNXp7wLGwx4mVLRG2vF+7hxeHx8mhuuz+LLrdIoIoJnfuOCksAmB1Jm5Pnkqf14XEpd4PvmDIyMcTVCuuPEIsF7wxd0yHm1muyLPSEbKxVJDC4at5D+yIpSbZXhw0i8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762415728; c=relaxed/simple;
	bh=xGWbg9EMdeDr57Tki1350vdsFLAX4WUjYpQJhpQ7HRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TVIQwEnzHTRGWvMkgFrWjP+Fg6pd7liAEbOSjCVBVmiADXC3IvYamuA0+k99D/CvoGJqEf+om5HL8RgHrT8VdME2Puu+w4WpGgFDEmf3YA98oxLsDdLEHze/8TZdebUst4+QBbdbC9zIV8ATMxM3k7IKNUm69dH+klAEYzKRN1k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TVkmQD8r; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ElkhceSq; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A61CEPo017034;
	Thu, 6 Nov 2025 07:54:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=NlSLYdK/byyDsgxsxY7bvtS7yk/YKIkfEUzx68m4wRw=; b=
	TVkmQD8r0ePqPI4jyZ94luDt6jTL3Lh8SXGYv+Vyd7NfWeb42+r4dnkpnyQ0ncQH
	IyGcAvMwnu5gLO86xueHQyzd+Iaeotb1lGgV7FF7eJq08YtmR54IOp9gxP+RJ5TM
	a6YoPz91vn/DJo5ZVQl7KX5Sd/jKGyza3/6HM38bVBBWKxWlQYpwnnqdlrYoVFZ7
	5PKdvoJRoI0UkQ7iaYtOXsroMl6FlvOqv+bwx/nCSlWjezIJxd756LpPrRlINjew
	YbiSXE3aHgEHlBFEbNXAORShQrTPilkRceq9qiIqT5LlI6aMdJfhgtMPLHQdLPMs
	bfzvSzsFQn3rlr4xlRqS8w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a8aejsfx6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Nov 2025 07:54:11 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A67KRbh015015;
	Thu, 6 Nov 2025 07:54:10 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010020.outbound.protection.outlook.com [52.101.56.20])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a58nbu2j7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Nov 2025 07:54:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bIn5vaVKgOtVdbpjRXl6O3kzYnTo2JAaF9oAQ9OKHdyxr7V6Bzjd3sYGqtfbzpWnOjZkyYAnkGE5pJgwv1N2DodNh3E6U2yxiESaStB1aPcSOW3YP9OBYfQTcnFpcAsyv/0usapB+pUUHBPbeXyhWEyk9EdPT71WmtGryK4DNqnnY5rZtCNnLyR+hGNuqrQOdhG2sHpGy5OjmHZSCQVo2b0GwfzeVc0DYd4d5n7S8El1KUsokzrFG2xPSEBMX6LjXCqmCJ9wT24kIdbVYYDU0mfuV/a5e0bpWhV7RKUV/fHuYpKiCtnK0Ua5Taj2LX/9pZURDnJm8wBmtYBl/xNorA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NlSLYdK/byyDsgxsxY7bvtS7yk/YKIkfEUzx68m4wRw=;
 b=HLdVAkPzkA9g+HM+gzGoLooZHqLllOFR+fQ9+tFUjbrUPkeocuoYMvGDuC5OZ35yl/38Kqxgk5dLeFLx96CaREEsEeXfEZc8fbv3hmX9hslaWv8lcvjLOo8kIH11waumXbIAmR3p2MX2c3mOoz2IBEc61odF4+KN6xJukJw/5w1B5zEFAxEKIyBkIQBKXtI8PN4O/DVjBHF5F2BpidJZZ6fSu7EwhWSWvLjyx8xFOxB8AhVLN5GUgmR2HAXi7hqURDQyxu4nnAeqcRslcTi45XWdQhjmCGNlZbw+DdERoaLTGFMBMCZu05769COIUEZjaf5fFKaBTBjYeIi7Nq1H+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NlSLYdK/byyDsgxsxY7bvtS7yk/YKIkfEUzx68m4wRw=;
 b=ElkhceSqMyQYzo/MrXLxJi0pn+OPuMScvPr+6xxR2pGUuVh5neCL5T/DMkx1xxHT25B3jacZuavzLBo9wu+Ry8KRYCylbsEh/64CBugGZ3dwOtC8PaTw28QZ5dh/nUcKBruyFnoL4QkbK9vRhCtJa38LFNB7A/IM3jyTfzVGIkQ=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by CY8PR10MB7291.namprd10.prod.outlook.com (2603:10b6:930:7e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.8; Thu, 6 Nov
 2025 07:54:00 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%5]) with mapi id 15.20.9298.007; Thu, 6 Nov 2025
 07:53:59 +0000
Date: Thu, 6 Nov 2025 16:53:30 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Jiaqi Yan <jiaqiyan@google.com>
Cc: Miaohe Lin <linmiaohe@huawei.com>,
        =?utf-8?Q?=E2=80=9CWilliam?= Roche <william.roche@oracle.com>,
        Ackerley Tng <ackerleytng@google.com>, jgg@nvidia.com,
        akpm@linux-foundation.org, ankita@nvidia.com,
        dave.hansen@linux.intel.com, david@redhat.com, duenwen@google.com,
        jane.chu@oracle.com, jthoughton@google.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, muchun.song@linux.dev, nao.horiguchi@gmail.com,
        osalvador@suse.de, peterx@redhat.com, rientjes@google.com,
        sidhartha.kumar@oracle.com, tony.luck@intel.com,
        wangkefeng.wang@huawei.com, willy@infradead.org, vbabka@suse.cz,
        surenb@google.com, mhocko@suse.com, jackmanb@google.com,
        hannes@cmpxchg.org, ziy@nvidia.com
Subject: Re: [RFC PATCH v1 0/3] Userspace MFR Policy via memfd
Message-ID: <aQxSSjyPsI0MT8mp@harry>
References: <20250919155832.1084091-1-william.roche@oracle.com>
 <CACw3F521fi5HWhCKi_KrkNLXkw668HO4h8+DjkP2+vBuK-=org@mail.gmail.com>
 <aPjXdP63T1yYtvkq@hyeyoo>
 <CACw3F50As2jPzy1rRjzpm3uKOALjX_9WmKxMPGnQcok96OfQkA@mail.gmail.com>
 <aQBqGupCN_v8ysMX@hyeyoo>
 <d3d35586-c63f-c1be-c95e-fbd7aafd43f3@huawei.com>
 <CACw3F51qaug5aWFNcjB54dVEc8yH+_A7zrkGcQyKXKJs6uVvgA@mail.gmail.com>
 <aQhk4WtDSaQmFFFo@harry>
 <aQhti7Dt_34Yx2jO@harry>
 <CACw3F503FG01yQyA53hHAo7q0yE3qQtMuT9kOjNHpp8Q9qHKPQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACw3F503FG01yQyA53hHAo7q0yE3qQtMuT9kOjNHpp8Q9qHKPQ@mail.gmail.com>
X-ClientProxiedBy: SEWP216CA0038.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2b5::6) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|CY8PR10MB7291:EE_
X-MS-Office365-Filtering-Correlation-Id: ccfcaffa-53a5-48d8-cf98-08de1d09a517
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RUpWZUlZNmNjWHZSUXNVM3VVNlBpdGQyM2R4YzhJRnBEZWpZVW0wSGpKRjlH?=
 =?utf-8?B?Myt4emlsSkZpMEZWZVpEZklsUjI1RHhqRkdEeUowNVFtdGxXdDNKdHZXd04v?=
 =?utf-8?B?NXZ2aUNqRnlFZEV0dktCdzZBUWRsUW91bUZ6dHgzRnlxWXdwMHBhaGVRV0FP?=
 =?utf-8?B?c1l5ZFMwR3I3NnhFeHN5aWExdlFJcjZSVVJYVE5GL3MyRy9QYWpRRVNBLzB2?=
 =?utf-8?B?ZWtSeEJZa1hVTHM2NEl4Y3M4ZzZIUWhjcllRZ2thK3RnUnVPQlFoeUlNYzVM?=
 =?utf-8?B?UzRJNkhTdFJmRzBWalBqOWx6aGYyWTBlVjEvMGNvaUQraGx3clAvNXJ6aHpW?=
 =?utf-8?B?cnVIc2xPQytXalhOZGlGcmZCeEpKNXRaZndnU1paNU9BQUMydHFzVHA4Smtu?=
 =?utf-8?B?emxOTjBkN0pWV01tbnVZVUQ2cjR2QVVlZXRZYitNajhxcHorNis5NVYvRHl0?=
 =?utf-8?B?RllmcnNpVzdvdFNNUTNTQ2I3bndhVUJxaUxmQVcrSHpZZDIwQ1hlL0lvWERV?=
 =?utf-8?B?dHVuazFWdDJxY2lueG9nZURja3ZWMWhtRVNZRFczTW82bk1wSjNtN0dyOUN2?=
 =?utf-8?B?bjdHNVRSNjc4WGU5WHF0QkNjOFhMM1c5dkdVYVVLbnJCT1VteVlSaWlsaWJP?=
 =?utf-8?B?OFl1VE5RK29CU1UzeFFlQjg1b0FwTkRpa1dsZ3JhclZvdXd6T1dOVkdKQmJj?=
 =?utf-8?B?U1VtU201Z1JBN2J1L3VTVGdDQjZwSGY1RnNydzl1b0hiTjh2RWU5OVd6T0Ft?=
 =?utf-8?B?TjJ1T2FuZVdKbWtBNmxCcUpoQTdjUjk0a1U4SFVZRHZVYzVLSUpVRE1HQXFE?=
 =?utf-8?B?ZDVKVWtwczlSUmRrWGxnOU1BVXVVM2pIMWdubTFYaWZiZ2Ftd0paQUt2UTJD?=
 =?utf-8?B?UmVqWVlsSlBac0ZxRWYvT05LTStWbUhmVTJycTZRUklPWE1DQzBFNlFxRUJi?=
 =?utf-8?B?SVFVWFVaZ0dTbWI4c0ROeUVQUGk2THZDZGN1UlE0NUI1RVViRllQS1BhYzdi?=
 =?utf-8?B?ZHk2aWNqcTRBbE55QUFnaTgwUnBhOUdpdjBNak1jS3c3ODZ0bWpwS3ZoNHlj?=
 =?utf-8?B?dzNiYkRYaGVka3ZoM1h5em5KSTJKODhkM0NEVllqOUFsK0pWK1N1TzBYdjNG?=
 =?utf-8?B?eUM2OUxmZytJckN4MkhNT3l4MDNZU1dKbmFLb2NiNEZhbmswUDhHMm40NDRK?=
 =?utf-8?B?N3NKVEVSMlZ2L1JwanNzTTVhOGFSV3pJcUs1TXdleVhRY0hlZzhXVmdUbTJk?=
 =?utf-8?B?MmxJdnF3NUZZcHZyQmhtOTg4UUMrN0VMOTlYR2ZsWDJBeThpbmhRU2t2SEVU?=
 =?utf-8?B?b0ZnWHNFZ0orQysvVXp3a0F1enNGUEJpWlhOalJ1SEM2ZDRlVGplSm9zVFlx?=
 =?utf-8?B?S0FnZ29TQnUzK0NDVERjL1h1cmxFZUNUZmczK2ozZDI0dFZGV1pZUmJYSzJE?=
 =?utf-8?B?aC9KY3VKcHJQc1Q1clNzRHo3cFNVSU9UcDgyMm13VEdEL0NEOHJRdGM1Smp5?=
 =?utf-8?B?SGx3VklSTGdqWkdNT2FlMUNVUkVnYjhQWWtGMzRPVCtnM2ZWdmdXb05DOTlL?=
 =?utf-8?B?cW5STzUzQXArYUhjZXVQTG1GN2ltV1VZcVV3d0Foc3F5a1R1YVpUMUFnd0hP?=
 =?utf-8?B?b1NVQXVHMUh4ZURKWTNDdTFZUnNxWjRWQUthSE8vQVYvYVpIL2dBR0dRUlNE?=
 =?utf-8?B?M1dHS2d4cDlkYmpDREVMYWFaZXF0TU5RNDlBbFkycVRKbytJK0szRkVXY05n?=
 =?utf-8?B?aDBXN1V5S3NGUEdGd0VKRGJHbGZZa0ZpMXlRb00xa0lrTXorK3E4Q0FqKzNn?=
 =?utf-8?B?b3YraFU5bEwrUUVaRUdnV2tHTm95TlZCZTRER2R5dm1FaXRVMHlLUFBZaUNV?=
 =?utf-8?B?MGtadTZVbDFCemJUc0hYdGVVSSs3ZVZEWTJaQkxiRzNnUmVocDFNMFU2dmJs?=
 =?utf-8?B?ZEszQ2pESXZNOUtkTU8zc2E4QXJvZHJURkVteGs4ZzFsY2Urcm1KazkvQjVw?=
 =?utf-8?B?dC9uRS9VdVF3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QjJReGR0Skg0UHRzeWxyaFFDUU96OVI5RWlMMmw2eXV4QnZ0eEI1UXF3OUhk?=
 =?utf-8?B?YVREb2ZTQkZWWVNpeXRYbXVLOVJzWEZvM09hNHZLY0hvQ3JIMUFyTGt6RFho?=
 =?utf-8?B?OEFzay93cGFNK0QyUFNvMjA2V2hHcXUwdzR3MmxSNjRzeEpTdDk3Ry9pYkI1?=
 =?utf-8?B?VkUzMTJZRC93eitxdERwRU5ib2tZL3ZCQWhRU0ZkY3NxUk04ejlVU0k0dkNM?=
 =?utf-8?B?ZDdrWXpDeWRkMS9MaC9hNnd1V3M3NDZ1RkZ2Ym54N01uUjR6VDJ3OVVTMXgx?=
 =?utf-8?B?blJ6NTdNZ2hoTC9yRWFCSnhSSXcvMXZqY2dnSDZROGJYaHhvZ05WVTMxT3lB?=
 =?utf-8?B?NElyU3dBR0dHWStRWXA2QkR5YkVpeHg5S3ZiZGdJVW8rR3ZhZlRVL04xck9J?=
 =?utf-8?B?R05ZeU9JL0M2MWdCRnRlN0x3cDF0M0dvTGVKNGFNdDhlMExjY3lLdlNOU1dV?=
 =?utf-8?B?K29JM1BjZS9zemlzVVVtcVRRalUwZndxdlo4LzNuYTlvNFpFKzZ3OHJCVkxN?=
 =?utf-8?B?QkcvSmpNMTlKdkZvOEF3VWtKd3NuVzNMOE0yekEwTVB6cTlZY25FZmNMOXla?=
 =?utf-8?B?dDQwZXk0MzM2YWJVTXdaeWkzVmFYNWdSVXBCU1hEV25MTlhGMmtpNVJlMVQ0?=
 =?utf-8?B?Q1VKMVNmaXN5eHVmclBIUXBMeGo3MzNBNFp4c01Ga0pRMExTYUtSWng4dTAz?=
 =?utf-8?B?SGNnQngxZXdiSHlxWnZFbzdEbXdsdW11c2VZVktZbFpWZXA0MEJONE9icC9n?=
 =?utf-8?B?WUZQYmc5SjVxUC9nckZ3Y1I4dktIU0tHZzJsS1pMK2NNSkNSOU53cXpsVzhi?=
 =?utf-8?B?UnBQY0Z2Y25tQS8yQlpKMXhPcVRWRmdHMXBKaDVMeTFpdWVkcWRBRmRxTlhw?=
 =?utf-8?B?WDJwLzNZZ2JiZnJtKzdWSEZjMmFHMk13T2lHZENHL1pHMTZ5V2EzcWs2bE1s?=
 =?utf-8?B?UC9ZSjRKd3pRQ0F0dkpRZjhRczRlYUdVRUdHWnZPa1VFTTErNGVuRm9ETVNK?=
 =?utf-8?B?ekNCMm1oTkE0RGFXaStaTng4WDNla01meERMbGxNNVcyVVhQRUp6aGRPSFVH?=
 =?utf-8?B?V2FDcFRmQlY2UVEzNnhtODdJTXNhSkUvU2JXb0UxSytpYXVKUFpQM1lVUmdY?=
 =?utf-8?B?OHdSeFBVQVQ2TUZuMlpmZHdnL3VaRUI0cHBHMytXSkk0YnQxb2FzUWk0alFF?=
 =?utf-8?B?MmJlcmtLS1hnVHpwQ2ZMYXEvbEpla01rTjh6Ylh1TlBtVS9Ea01sRVpjdHg2?=
 =?utf-8?B?cEFFYSswelpZNXdiQnppblVoNC8xV3V0REJoVEdyaFJqL2FsQ2xpTW5nY1Jv?=
 =?utf-8?B?RzBjcDRPNVpVVUVJTGpTSkpaSDFMNVJFSGZqUkRFUVhRZEVSQ3Q5aGdtTTFF?=
 =?utf-8?B?QWUrN0FNcm0rVjNVNm9OMTZjZHZWOERsRVZ2NUdqNXh3NENLTHZwY2MyRGYw?=
 =?utf-8?B?MjRNdVhZbURnVEQxTy9YWkkwcmV5Q3lTTFRsd0k1MTF1TWtidURZZ3EwT1RR?=
 =?utf-8?B?dGJBZHFjOGJRN3F3UUxUSzNYZmgwdTFGSjd1bWxLZWF1VlIxZkZhcFN5L29a?=
 =?utf-8?B?WG9VNnRBeXdzc1QzamRRNldDWGhrQnpHZGYxcjlPN2g0d1B2RWNtanM3M0JO?=
 =?utf-8?B?cnJ5ZGNXdkdQUWF5MEdqcHZlMXNaT2lLMG0vUE9Ocy9CaGJxM2FvK2hjYTZn?=
 =?utf-8?B?Mk1LbXZmQXRvcllUbWJOMldvSzFhZ2hzZUNuTGlpOGkrdjkwQkw3RVdoMWU4?=
 =?utf-8?B?TGJ0VWl3R25JSzkxeFg4blhDTTl3SEdSRW1SZUtWdW02VklNVjAyS0tpdzVy?=
 =?utf-8?B?Y3NOY3FuOTlPUS9BMHMzUDhReXBRWWRmR3lyOGZyOWNjQmRLR1lWalNZWlpr?=
 =?utf-8?B?WXM1QmlWYzk3bjBKVEI3U3N6Z3lKNlAvU2Y2RDNQbDdtTnhwcDhiODlDcWh0?=
 =?utf-8?B?Mk9yK0FkcmJFWG10RlgvNklnWkwveWVLQjJhQUVNbFNlekVKaEVNSzRGUExC?=
 =?utf-8?B?YXptSmRxVWZvbE1yWWpMZmxmbGMrYjZlTHVJWkwrSThWeC9abVFCSExQcjRy?=
 =?utf-8?B?NGRELzA4RmxSY09UYnhreGF6Z1g1NERnQVJOTmo4bk1VTzZxZnZrL1p1T0lD?=
 =?utf-8?Q?e7+2ITwubxCeqMnkMn0Odf8d4?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	O9v+YGvpSeQMpGJ6wWBOXU3booLB9Jdt2M2/TRocVW8Iqne2M9teDxvHVL/E3pjDY4B5BJKPDzSilsQZUMolcikiCeQ+WtRkxyvki25Zd9XO63u9Ze6YTxSW0x076bQzyb1LijkOMYkg7F5zdXeKdKlZsuVZsvD7mpHaW6keRV+0EMPW2GkZEhD5rPhGU0+9ZYbwrSPDB1sYJQeETomFArcNWPkoyFXzy1J1gA6QEYud/p/6/hJaS32zpw2EyGmXT6Vl1BI9BdG/WL0CZWYz9DSnLuPXOOq/z/x3JzuMGJtlcwZui3hlm1Dz/1OG+g1fP9NaZXFIBCj9eWGdnJW6Sp0OjrFDdUeTeFxbxgjhwqRBrGezwJPDsun8WMh6LsN6gbyWoL0ubEp1LjzhHz48dPdf5ihLaa7e/Rdsy0qrFSIkJpSfyCnzMBQmUEi93T4G2lN9TA4f749gYjkEclhcwRVxgK1/FTW5+c1SbP7UulR8rZQqNRPCp7y8hS6NN1kXS/ADFzrIVg9nsZJjT9ELmY1GamXs0cBen4/DjSU9WwqhY7LekHQW7VxilrTdnYKBYPIZpHVYpzkYc6NeTkcBl8EkhM7jaqK98x7W9QTsb+A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccfcaffa-53a5-48d8-cf98-08de1d09a517
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 07:53:59.7140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f4YZdLKQw4cpVspJk5XgBGumucRqu8qtxD2J1bLQWU2jX9hYsOEQRQZu0qRtlvJvK2z+9nNZb05Wo0cqeyPFAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7291
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_01,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 spamscore=0
 adultscore=0 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511060063
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDEzMCBTYWx0ZWRfX6r5zC2fymSb+
 SIszoTa1W/hP1YbwBj2ZuYsTb2OyRVuTlsUliJMnc5heR6y9JVUrylDS2WjYQVWKteGl77YYsTV
 GJ6T7ORPNSFtID/u9OZggZbkgarg7OEmaE/A1H7A0lryL5WatBuL08RhS1D5nfpBnvGhxrIO0wO
 1llMXC9AGZwgfQSA1JoOCPyT58ZCDgaBP4kKTcW26V5z4wDlE4bUJZqlFOIO0UlCjrOct9w1Lom
 9qINNyGJGyQ/Jy8xOJN7YaBFuGBdLXxqbFPfRo933B9feljgZ/3+k1CG+PEprlAyUfysIkbika8
 Jy5/uqE7iEcSqrRIzTtDI9dQkR4TaiXNOGNspcHbX8mQI2zsLzFEmWeWKkPhoYGDknbpxoqRGC6
 xzrm8yXnSpohuZBCgumAO+DNlvjq5g==
X-Authority-Analysis: v=2.4 cv=R8IO2NRX c=1 sm=1 tr=0 ts=690c5423 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=R_Myd5XaAAAA:8 a=yPCof4ZbAAAA:8 a=i0EeH86SAAAA:8
 a=LEMqVnNPEiT2kn9s4KIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=L2g4Dz8VuBQ37YGmWQah:22
X-Proofpoint-ORIG-GUID: Q0Sgv7mSz9KOjn6A2Mkzvzxn6QiiPZRE
X-Proofpoint-GUID: Q0Sgv7mSz9KOjn6A2Mkzvzxn6QiiPZRE

On Mon, Nov 03, 2025 at 08:57:08AM -0800, Jiaqi Yan wrote:
> On Mon, Nov 3, 2025 at 12:53 AM Harry Yoo <harry.yoo@oracle.com> wrote:
> >
> > On Mon, Nov 03, 2025 at 05:16:33PM +0900, Harry Yoo wrote:
> > > On Thu, Oct 30, 2025 at 10:28:48AM -0700, Jiaqi Yan wrote:
> > > > On Thu, Oct 30, 2025 at 4:51 AM Miaohe Lin <linmiaohe@huawei.com> wrote:
> > > > > On 2025/10/28 15:00, Harry Yoo wrote:
> > > > > > On Mon, Oct 27, 2025 at 09:17:31PM -0700, Jiaqi Yan wrote:
> > > > > >> On Wed, Oct 22, 2025 at 6:09 AM Harry Yoo <harry.yoo@oracle.com> wrote:
> > > > > >>> On Mon, Oct 13, 2025 at 03:14:32PM -0700, Jiaqi Yan wrote:
> > > > > >>>> On Fri, Sep 19, 2025 at 8:58 AM “William Roche <william.roche@oracle.com> wrote:
> > > > > >>> But even after fixing that we need to fix the race condition.
> > > > > >>
> > > > > >> What exactly is the race condition you are referring to?
> > > > > >
> > > > > > When you free a high-order page, the buddy allocator doesn't not check
> > > > > > PageHWPoison() on the page and its subpages. It checks PageHWPoison()
> > > > > > only when you free a base (order-0) page, see free_pages_prepare().
> > > > >
> > > > > I think we might could check PageHWPoison() for subpages as what free_page_is_bad()
> > > > > does. If any subpage has HWPoisoned flag set, simply drop the folio. Even we could
> > > >
> > > > Agree, I think as a starter I could try to, for example, let
> > > > free_pages_prepare scan HWPoison-ed subpages if the base page is high
> > > > order. In the optimal case, HugeTLB does move PageHWPoison flag from
> > > > head page to the raw error pages.
> > >
> > > [+Cc page allocator folks]
> > >
> > > AFAICT enabling page sanity check in page alloc/free path would be against
> > > past efforts to reduce sanity check overhead.
> > >
> > > [1] https://lore.kernel.org/linux-mm/1460711275-1130-15-git-send-email-mgorman@techsingularity.net/ 
> > > [2] https://lore.kernel.org/linux-mm/1460711275-1130-16-git-send-email-mgorman@techsingularity.net/ 
> > > [3] https://lore.kernel.org/all/20230216095131.17336-1-vbabka@suse.cz 
> > >
> > > I'd recommend to check hwpoison flag before freeing it to the buddy
> > > when we know a memory error has occurred (I guess that's also what Miaohe
> > > suggested).
> > >
> > > > > do it better -- Split the folio and let healthy subpages join the buddy while reject
> > > > > the hwpoisoned one.
> > > > >
> > > > > >
> > > > > > AFAICT there is nothing that prevents the poisoned page to be
> > > > > > allocated back to users because the buddy doesn't check PageHWPoison()
> > > > > > on allocation as well (by default).
> > > > > >
> > > > > > So rather than freeing the high-order page as-is in
> > > > > > dissolve_free_hugetlb_folio(), I think we have to split it to base pages
> > > > > > and then free them one by one.
> > > > >
> > > > > It might not be worth to do that as this would significantly increase the overhead
> > > > > of the function while memory failure event is really rare.
> > > >
> > > > IIUC, Harry's idea is to do the split in dissolve_free_hugetlb_folio
> > > > only if folio is HWPoison-ed, similar to what Miaohe suggested
> > > > earlier.
> > >
> > > Yes, and if we do the check before moving HWPoison flag to raw pages,
> > > it'll be just a single folio_test_hwpoison() call.
> > >
> > > > BTW, I believe this race condition already exists today when
> > > > memory_failure handles HWPoison-ed free hugetlb page; it is not
> > > > something introduced via this patchset. I will fix or improve this in
> > > > a separate patchset.
> > >
> > > That makes sense.
> >
> > Wait, without this patchset, do we even free the hugetlb folio when
> > its subpage is hwpoisoned? I don't think we do, but I'm not expert at MFR...
> 
> Based on my reading of try_memory_failure_hugetlb, me_huge_page, and
> __page_handle_poison, I think mainline kernel frees dissolved hugetlb
> folio to buddy allocator in two cases:
> 1. it was a free hugetlb page at the moment of try_memory_failure_hugetlb

Right.

> 2. it was an anonomous hugetlb page

Right.

Thanks. I think you're right that poisoned hugetlb folios can be freed
to the buddy even without this series (and poisoned pages allocated back to
users instead of being isolated due to missing PageHWPoison() checks on
alloc/free).

So the plan is to post RFC v2 of this series and the race condition fix
as a separate series, right? (that sounds good to me!)

I still think it'd be best to split the hugetlb folio to order-0 pages and
free them when we know the hugetlb folio is poisoned because:

- We don't have to implement a special version of __free_pages() that
  knows how to handle freeing of a high-order page where its one or more
  sub-pages are poisoned.

- We can avoid re-enabling page sanity checks (and introducing overhead)
  all the time.

-- 
Cheers,
Harry / Hyeonggon

