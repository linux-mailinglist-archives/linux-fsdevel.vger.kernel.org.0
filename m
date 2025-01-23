Return-Path: <linux-fsdevel+bounces-39972-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A86E7A1A82C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 17:52:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 487AB188B927
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 16:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27639146D76;
	Thu, 23 Jan 2025 16:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YzQwIske";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IbDO0Rmw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF3B70817;
	Thu, 23 Jan 2025 16:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737651160; cv=fail; b=KAEb4sFC0G6xqrAb5q8r5qmng8DheEBBytvICpSlnU2AwxFpQaa8gQcw1jjRVbt4dYz2FGXfJd5VWB+fT9ccHBU4QaLVLD6alVox4oqWQWsQNL1bg7+aYro9yvsh6kRJU0ONV8vpU23yafKjzaiH12mPgYAg28Q5XTrXzFcvhpw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737651160; c=relaxed/simple;
	bh=B+E7eT9/dPA9jGLJ5mrnS/4WwvBVJjPMp3QhXleCfww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IbipmuZ/JABlWkfm+NcWqyFRb5wjLFVgDMZs3GwBHBnHR5ii4JZWVs8V0NBhIF9yYEmlvMJGQyyu9m0o+j2VMHW6QMBiqFccdJtWZGCynj/uGM9ozQOikYOeLcDxu011UwuOzoiYRi2j47ape1jc+MUKEfBdVAlD7NrOox/IpAk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YzQwIske; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=IbDO0Rmw; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50NDaOgt006796;
	Thu, 23 Jan 2025 16:52:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=3SFueloz8pPvaF0Yp2J3AE10DvoyXRC5lPJzTNyd/jI=; b=
	YzQwIskemBGtWiMraAzcaTeI6Fvzue9JQvPKCBUXYj9J3XYKGy+iCN3jDq3SQM7D
	QSBA5UD/RM9STThbL1cgz3Dxbea+ERmnKr9C0QOT9gwiG5WbDci3HuecIsJu4Av0
	+KLNjctInHGDvgvZv7GijqF/GfWS+FgRXxNGTS2PgvNH1WYyUhTxvrAjtl0ICQ9L
	xiLY3djUuMMmiDb2SRI+dWPltbQk5o/Gn7oWk6KplPNqunyN4nS8BUwxO2bCyNUp
	/DLf7JtRhHN5WiOg/c5qnhQYqH12y5UTQxqCNiqRCiwN1iSJ3u7R8r8YlJ5yBhMn
	LQNSmDt4CfWiLUYfLBOTOA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44awyh31f2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jan 2025 16:52:21 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50NG5wfx018866;
	Thu, 23 Jan 2025 16:52:20 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4491c571y1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jan 2025 16:52:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EjzL4oWmv3UdQzjBQpAyByvE9p5z0Jr0G8umw8kCQ377DGH+Yhq2i3SpnQOTH0pc4NzzxSVPKkfcxFM4/i3+GTg4N5lfVqXueaBDFgmm5gBPEPqG59FZMi/KjKIK5d80KhOJGI6buQa1PKZyysCcbGyE3/yQhdsz9bF+dF7XHS5DghTxxhNJGCRKeb11+V9Z6RytaklzBU5Apw/jMQ3GaWnOT4RItSgPUY/xakCWlUcHkHDSsn2C0eyQT8zubK4xVBCtscd5rGrjnLKqSVRmgM+eRH6KZUVcV91G/NzLs2q4dOcBblFp19GjMFCk/4elfHAOYLni/Fav+TO64WhYjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3SFueloz8pPvaF0Yp2J3AE10DvoyXRC5lPJzTNyd/jI=;
 b=AxBsEMCCOTWUKumbrmm9kKytyXvjDmwBG09zgK5EIdDpRvZdgZSVdz3NBLDNZJIJ9UEtstGv5CqweLzrtLEKh7FZhIyOydNKjXKSqKZt+KW98cX70XmcC0UQxxN6bXu/rsk1D0Dv1b3XvCnnlxElY9nLKk3dLxevVTNaXZrAm/70sMBMEgDdtm0jjoBRbfUjHGmVRp9TmJXEzQMc+dABRb1mp+sk3KIcB9+ZARmjqoyGhDfyARYphV3h/y8x+HnAa0axMPni2fOYh/4Mae5S423yefzXjtHSR0XF+HWOIalZYaWApVj/6y/wZYyieBkc+N3Lg1BN40Jtblg5OUvEBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3SFueloz8pPvaF0Yp2J3AE10DvoyXRC5lPJzTNyd/jI=;
 b=IbDO0Rmw/8c8Pvz+ySb8UGJfUJXK4ViceO1zyU1g5BQgnGa8Roy6qdTxbcWzaS+lBh98lh+6X4yWDgyDlJxtPip1YWxCmYmaeGOiPy4hgxDf455M/onBDP3SFk+x3/XE5V+nb/I2RQGHrKsIxuWrrICnax4BAW6xwDqfsU6woW0=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by CO6PR10MB5792.namprd10.prod.outlook.com (2603:10b6:303:14d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.22; Thu, 23 Jan
 2025 16:52:17 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%4]) with mapi id 15.20.8377.009; Thu, 23 Jan 2025
 16:52:17 +0000
Date: Thu, 23 Jan 2025 11:52:13 -0500
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Barry Song <21cnbao@gmail.com>
Cc: lokeshgidra@google.com, aarcange@redhat.com, akpm@linux-foundation.org,
        axelrasmussen@google.com, bgeffon@google.com, david@redhat.com,
        jannh@google.com, kaleshsingh@google.com, kernel-team@android.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, ngeoffray@google.com, peterx@redhat.com,
        rppt@kernel.org, ryan.roberts@arm.com, selinux@vger.kernel.org,
        surenb@google.com, timmurray@google.com, willy@infradead.org
Subject: Re: [PATCH v7 4/4] userfaultfd: use per-vma locks in userfaultfd
 operations
Message-ID: <rb7qajtpmmntvvqq2ckzjqs76mflxyuingixx3v7q63jd7xqfm@v7hm5aqhe23z>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Barry Song <21cnbao@gmail.com>, lokeshgidra@google.com, aarcange@redhat.com, 
	akpm@linux-foundation.org, axelrasmussen@google.com, bgeffon@google.com, david@redhat.com, 
	jannh@google.com, kaleshsingh@google.com, kernel-team@android.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	ngeoffray@google.com, peterx@redhat.com, rppt@kernel.org, ryan.roberts@arm.com, 
	selinux@vger.kernel.org, surenb@google.com, timmurray@google.com, willy@infradead.org
References: <20240215182756.3448972-5-lokeshgidra@google.com>
 <20250123041427.1987-1-21cnbao@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250123041427.1987-1-21cnbao@gmail.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0205.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ad::27) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|CO6PR10MB5792:EE_
X-MS-Office365-Filtering-Correlation-Id: d79fe8d9-bd3a-427e-c8d6-08dd3bce4b72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c0RXRWUxRFlUdzhUbkhHWUJuUEFzTURIc0tNL1RjcXprSnJuZHUrb1NPaVZ6?=
 =?utf-8?B?b3QvZHBUVG02dk50dGdtaWx0OG1LWEVRN0FOQ2hPQkxJSW1ta1EyaE5NTGd4?=
 =?utf-8?B?U1d6TXNiekNham1oS0Joa1BGRGhNVHppMkJzcjFoTXI3dmpsYXN1QmJSWGxE?=
 =?utf-8?B?TWp4L0Y0cXZ0cnNxOTZaSVU2UnpiZFdOcFZ3eU9NdVh4cnlCL1JRcXlRT2E0?=
 =?utf-8?B?TkZpMGxhMmVvM0l1WEJXTHFXajluaDcxWjdZSGJZVEt5b0dhS1JHaHdWbzNN?=
 =?utf-8?B?dHVkUGpTYnR3TXhGZDNYVlZvRTZBTExjeFN4S0R4VTlCQ0xXN1hyWXlMNmkv?=
 =?utf-8?B?VzUzazFzQ1djaEZ6RGYyUDd2Rll6WWl0MDZPUVRlYk5McmVIQkhlQ0VOcGJq?=
 =?utf-8?B?dUZ1bzhLcW5WRGdoblZoRFZQcWhkcWRhT2syRVF3eFBTTkltaGtrWCsrOEhM?=
 =?utf-8?B?bW04bERaL3U1Y1hVTTZUaitkYmU5OXNGSFYrWEJsVk11L1ZTOHJlQytvRWZF?=
 =?utf-8?B?eEVwc3l0a1RodlhKdUF4dGZCZlZ2SWZiVEs0VXpGQlpjL05MZ2JXNXFOdXU2?=
 =?utf-8?B?RTAxZkFNSFpwb3QrQ1UzWkJ5VVRLbHFWVkFUMTRRcnR2NzVVOU9uRVo3aTZJ?=
 =?utf-8?B?QVI1WWx3K29Lc2Z5d3FZUjc3K1RCbE5nTGRIc2xPbDdLZFplNmhxUHpDRE1B?=
 =?utf-8?B?cGNlQUNRdnNDM3h1VncxWmRvMUZGK2VRWmlmS0VpNnFoTk1TRVZMaEdDTFV2?=
 =?utf-8?B?WCthYzgyZlQrRjByR25vQm9halB5RnpYd2FiTjFOVXgyOU9vdEVVaG1EQzJ2?=
 =?utf-8?B?TmJ1OGRuQmFpR0hSay9TOUFIRW1LaFJUNmFRNVA1YkhMNHpCUkFxSnp2L1dR?=
 =?utf-8?B?aWc5MFZTczViQUt1YWdQUWNGYlFWcTdkRVhzbXorbUd0NHFYaitHbFY4KzlF?=
 =?utf-8?B?Smk5UTZSYW45cUxvOHJ3ZUxUdllkNGFVdEpJTHVqdmx0ODFabURKRmFrRjEz?=
 =?utf-8?B?VEpsNXpUV0VjY3pRWi80aGFVdHc5SW5aazNHSjZpRmRhZXNKbXI0Tjg5b0Z4?=
 =?utf-8?B?MVh2enhzajhta1g3YS9tSW9MeEFZL1o5SzBpUGpKWU1Jb2NEV1Q1SnZNajQ3?=
 =?utf-8?B?MWt2Wmg0cFhLWlU2VGRiRjR3TEdwQ0hDRlhBWjkrUGtCMzJ3V2JPUUl6K1dN?=
 =?utf-8?B?UnZVR1BPN29sSlBJTlFWYi8weFl2a2dQc3J2SUZBWkY4U3VBNEVXcG5HVEJU?=
 =?utf-8?B?aHFtWWo0RW9KM2dDN29SM3A0TnFDZ2tUTkpGd1cwNGlTbXVkNHd2dXpaLys1?=
 =?utf-8?B?YlVlMWl0OTkyTm0xUEFBblRQa3RoTWdLZ2lhVVVCTWtQSUVaNTlkWTZrd05x?=
 =?utf-8?B?WDlDQTFWSThCSWRtWUplYmxZeVFXTithMkRUMXdKUDBUTkxHR2VpTzBLbXhz?=
 =?utf-8?B?WXZlN0ZUMGJNYTltSUVMUVdZQUR3YithYkprQ09WRDNoc2lITlhQcm8xclZ1?=
 =?utf-8?B?VndBNHJpZ2pLaXFqY3hLNW9LQ0VYQzBKTTN2Sm9BZHUrUTdQcCtWVXBiOU1I?=
 =?utf-8?B?S0VzcVRxMDVrWFE4TlpOY05vdk90MkordEtVWWR6bEJXS0VQd2RreG9qWmFi?=
 =?utf-8?B?V1RtVHlTcStuckJyTjlPQU16MUJYTEFIZEh4WW4wT3NFWHhTM1FtSnpqZnVI?=
 =?utf-8?B?c2h4Z1JuWEV2bitOb0MyNENiU0tMR013ZTJCUVNNN1dORnhjekh1NnMwamxZ?=
 =?utf-8?B?SFhZS1NSWFpyRENqY0NObVExaU01RndXM2dSV0FHWlJCRGhWMXg3b0VPdzFp?=
 =?utf-8?B?ZitZYllsaTRQYWg3UmRTQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TjErUnVwb2NFRCtmUGhDQWhMMGtCbDcveFpFYTcrVlFtbThwSzFza0VRL2tU?=
 =?utf-8?B?MGhJVFMwNXhlR0FiS1BYZEYxVDFVOEUyTWV6NDcyUGtLVHJhZDNDUUlkaUhP?=
 =?utf-8?B?Q0Y2SW5aRjdUVFljbnBhVU1wRmRPbURzNXdlSHVwek5kRFpKeDBJMno3bk1y?=
 =?utf-8?B?a1ZnWHRuZ2NDaHlPT2d1ZHQrdmIyb2xqUXZ0bUVjRkJGVndqYmVQSFVkNnQw?=
 =?utf-8?B?VDk1Ump3empyOGRHTWQ1cmZpRjlIOGxsc05YSHZEU0NuUU5EcENDbXNDMm5n?=
 =?utf-8?B?ZnhPN2NHNTN5eWFHWlZSNmxRWXFjbWlZOUExNk11Rm9rUFU5WUFhU0YzZmNV?=
 =?utf-8?B?Z1c4Qy8zRGFSYXgzRXBkY2k2b0xOazZWenZsVzU4UWlJZTVoWTFlRVIzQTdR?=
 =?utf-8?B?MXlXZENqSHlGTU56bVFGNG1Uek92ZGJVYjVSbWtqcDdveEVMd3ZmRlpjVFlC?=
 =?utf-8?B?cmI0enVLRDFMVUFyZkswTytEMUUwV2g4T2x5Q2VFc3ZNMFg1b2VrR3BBMHQz?=
 =?utf-8?B?UWhFSk5tcTFzT0gwS1RydHk0eVNwaUhlZmdkcjY2QzFDZGtVNjhXWVZNdm1R?=
 =?utf-8?B?alNhTW52ZUcvRlJ6UStFc0lKR3JVVUxIWFY5VXBsNCtCYUlJalk4R2dHMisw?=
 =?utf-8?B?Nkc4VUNsTzRtWWNEL0t0bHNZUi9YdjZmb1NzODQ4U05SWStqQTJiMEpmd2pV?=
 =?utf-8?B?eVd3TWticXJIYlJxdmc2SjBzU0pETWV1T3UwbzFjUldjUWYyOW1sNFY5RUhP?=
 =?utf-8?B?ZElXVjRGM0JFK2llNGlKVXVzSk02bk9EckU0dHZwS2pqTnFnSE9BZkxUZnJY?=
 =?utf-8?B?V2J6UkQ5bk52TkFVM25RZk02dTZxMWRTNC9FS2UyZTBScHhIQ1J0K0VkaUpj?=
 =?utf-8?B?ZlJlMnVPTlVFTkV3TEsybkVDR01OR21NR2lERWptUE5vbmI0d0lOTnZkTUFL?=
 =?utf-8?B?ai9tSnY0NWNzcXd4aGk4QllzRktITTBUZTNxbjZOdUg4ZEIrUVUxeDh6V21y?=
 =?utf-8?B?N3k3OWhnK2lpNU93QS9kZHFDN1RoNE1iRzNyb3J3ZlE2WGovSGt3eHh6dzVM?=
 =?utf-8?B?eWprbnI2VVk4cDJuQ3ZOTStBeVFNS1FIRkw0amdVQmdkdURPWHduYmx5WUdS?=
 =?utf-8?B?azNueEl3LzFnVm1jS2dEaGR5ZzBLMWZFY21aQmpTNXRQOHlqeUo1UUFZSTRa?=
 =?utf-8?B?QSs4SEM5ZDFHNmltV2ZNVW9oUm9nMERvM1Y1MFF4M3hpZTh4SmcxYjh5Z3FC?=
 =?utf-8?B?QngwQ1R4WXdnT3FwM1pJQ1VaRFJEMmZXY2FyTFJEUmpkczNQYlNBb0xocnFI?=
 =?utf-8?B?ZVl2YTBiNExiSmJCVHFxekkxQ3Y5LzRtbGc5UnVyMDltVW1QM2EycndqcW1t?=
 =?utf-8?B?WWt0RE82akxTYXhhazkxNERxc2pqVTBTWFpVVlV4SSs2ZXhlem4zZXRTSTA5?=
 =?utf-8?B?aEdyT3VRb29iemQvZllXWU15emFNcjRRaFEwMzVmTy9uZlZkQUN6Z2U1em92?=
 =?utf-8?B?SFhOaTJEUUdUZ0xRb1lZb0E3MDRtNW5Jcm9WSU9tbUp3VFc2bHFkRXV4Zjhz?=
 =?utf-8?B?UG5zbElCQmQ1MXNGVm5Bb29pcVJEVHEvcE11WGt1MXo1WW9BSE82WnZESzhW?=
 =?utf-8?B?TWYvN1VpSDR4YWVxc0llR2Z1V2dzUVpWTVpVc0tHcitNcm4vMzlnWVdqTEh3?=
 =?utf-8?B?UVVNckgvck16MEozSWFJd2d1SHdvQlhIYVgzUktuVzZqN0hwbzQvcncyUHRW?=
 =?utf-8?B?VXN4SzJTeDZkbmFUS0w1SHhIalhLRlg3YjRjZ09tMmhZMFF1OE03VmJSRjl4?=
 =?utf-8?B?bkM5dnRhR1ZmTDZkS3VrRTd1eEZtSTNXMVdwcGhvdVZqQUF0V2FuOERoSlE5?=
 =?utf-8?B?WUllbHJaUkNGSGR4dmVrbGdna3BkNjFJTnBTMkcycisxV3E0ejdXWjVkQXNM?=
 =?utf-8?B?dUxSQlNJTlVJVkVHL25hNVdkcWZtMWdIUlR4Nkx4N3RKaXBIS0ZaUCtQVUV6?=
 =?utf-8?B?Z0REYUV6UjA2RnlWMjQvcDl1eVQ5UHFOYnNhRHpZcEJYQWlENy9tZTdRWm9y?=
 =?utf-8?B?WHJTekZrYTdtOFZJRGJ5MWdXOWZMM3Z1Uk9tUUl6a0hQUnZkK2F1aVk2aFVz?=
 =?utf-8?Q?4gRwij6t/patnM2+znf5nn8PP?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	WZARZqdqJdn+sQFpB8eszWLoPJIotKEG2F4eAx49FqztphiGyR8ND3TveAlrd6gLoGR7on+zP3scIeFTWK8DzrAOxKMjzkvbPogNzzhBw9fDIwMcSR8uBgh151ryyBkS1iR3yeVD0aFyrHCdej5/JXeeI35yVTUJC4phNcGZNwuvAGzBJJX4Anv61hODzBiykhzHqul7ebGnPPzCYk/ajKhVKZ1Yppfw+8KX7/4HVSQ1PT6DenHN90Z6xBFUciEOZEpdl2tJHSNa1l+3xvtLoeeX4j5BXBTA6iNInLecHL8qRgbkNM3td3e57EVNNYzXw2V13Ks6YncSB0GGl9ic1KrlO2YaVzpjjerHPdIGLxQx5N5tl5sRWfcNX2QhwEAdW4MEsLvY5sTLFHiiB6zOOf6g/oc3oRTAaBcZzzrS4YhC4XoiKtdgiofYNzuR324Gv83UAq1nd0Hvcljb7BuNXNitzkdN8FFz/FQ1uqYAjMnENueAcBbf0HynpofPcwhYEujpIdx1FF0AC41gZ/ia8dok4pN70QvxfZDfm5jvLG7PcwQXocw3JQrCSYfXnyiH8STo1Hk4hIUxeHAGx4CnhJJOUK5wbp4RYRbGtYmwEVE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d79fe8d9-bd3a-427e-c8d6-08dd3bce4b72
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 16:52:17.3463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JOPJ+2rWS8lu7YYxOzgSdjyQRs5IBXUx13f+nAz4tTvMlROnNK410rh5CJd8t0J0z7usHvsdlEUmqInbi1HKow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5792
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-23_07,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 phishscore=0
 adultscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501230124
X-Proofpoint-ORIG-GUID: 0Lg7Z5h8AXm7XjYUDB7Rsw3DLgKgMWSs
X-Proofpoint-GUID: 0Lg7Z5h8AXm7XjYUDB7Rsw3DLgKgMWSs

* Barry Song <21cnbao@gmail.com> [250122 23:14]:
> > All userfaultfd operations, except write-protect, opportunistically use
> > per-vma locks to lock vmas. On failure, attempt again inside mmap_lock
> > critical section.
> >=20
> > Write-protect operation requires mmap_lock as it iterates over multiple
> > vmas.
> h
> Hi Lokesh,
>=20
> Apologies for reviving this old thread. We truly appreciate the excellent=
 work
> you=E2=80=99ve done in transitioning many userfaultfd operations to per-V=
MA locks.
>=20
> However, we=E2=80=99ve noticed that userfaultfd still remains one of the =
largest users
> of mmap_lock for write operations, with the other=E2=80=94binder=E2=80=94=
having been recently
> addressed by Carlos Llamas's "binder: faster page installations" series:
>=20
> https://lore.kernel.org/lkml/20241203215452.2820071-1-cmllamas@google.com=
/
>=20
> The HeapTaskDaemon(Java GC) might frequently perform userfaultfd_register=
()
> and userfaultfd_unregister() operations, both of which require the mmap_l=
ock
> in write mode to either split or merge VMAs. Since HeapTaskDaemon is a
> lower-priority background task, there are cases where, after acquiring th=
e
> mmap_lock, it gets preempted by other tasks. As a result, even high-prior=
ity
> threads waiting for the mmap_lock =E2=80=94 whether in writer or reader m=
ode=E2=80=94can
> end up experiencing significant delays=EF=BC=88The delay can reach severa=
l hundred
> milliseconds in the worst case.=EF=BC=89

This needs an RFC or proposal or a discussion - certainly not a reply to
an old v7 patch set.  I'd want neon lights and stuff directing people to
this topic.

>=20
> We haven=E2=80=99t yet identified an ideal solution for this. However, th=
e Java heap
> appears to behave like a "volatile" vma in its usage. A somewhat simplist=
ic
> idea would be to designate a specific region of the user address space as
> "volatile" and restrict all "volatile" VMAs to this isolated region.

I'm going to assume the uffd changes are in the volatile area?  But
really, maybe you mean the opposite..  I'll just assume I guessed
correct here.  Because, both sides of this are competing for the write
lock.

>=20
> We may have a MAP_VOLATILE flag to mmap. VMA regions with this flag will =
be
> mapped to the volatile space, while those without it will be mapped to th=
e
> non-volatile space.
>=20
>          =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90TASK_SIZE   =
         =20
>          =E2=94=82            =E2=94=82                     =20
>          =E2=94=82            =E2=94=82                     =20
>          =E2=94=82            =E2=94=82mmap VOLATILE        =20
>          =E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=A4            =
         =20
>          =E2=94=82            =E2=94=82                     =20
>          =E2=94=82            =E2=94=82                     =20
>          =E2=94=82            =E2=94=82                     =20
>          =E2=94=82            =E2=94=82                     =20
>          =E2=94=82            =E2=94=82default mmap         =20
>          =E2=94=82            =E2=94=82                     =20
>          =E2=94=82            =E2=94=82                     =20
>          =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98  =20

No, this is way too complicated for what you are trying to work around.

You are proposing a segmented layout of the virtual memory area so that
an optional (userfaultfd) component can avoid a lock - which already has
another optional (vma locking) workaround.

I think we need to stand back and look at what we're doing here in
regards to userfaultfd and how it interacts with everything.  Things
have gotten complex and we're going in the wrong direction.

I suggest there is an easier way to avoid the contention, and maybe try
to rectify some of the uffd code to fit better with the evolved use
cases and vma locking.

>=20
> VMAs in the volatile region are assigned their own volatile_mmap_lock,
> which is independent of the mmap_lock for the non-volatile region.
> Additionally, we ensure that no single VMA spans the boundary between
> the volatile and non-volatile regions. This separation prevents the
> frequent modifications of a small number of volatile VMAs from blocking
> other operations on a large number of non-volatile VMAs.
>=20
> The implementation itself wouldn=E2=80=99t be overly complex, but the des=
ign
> might come across as somewhat hacky.
>=20
> Lastly, I have two questions:
>=20
> 1. Have you observed similar issues where userfaultfd continues to
> cause lock contention and priority inversion?
>=20
> 2. If so, do you have any ideas or suggestions on how to address this
> problem?

These are good questions.

I have a few of my own about what you described:

- What is causing your application to register/unregister so many uffds?

- Does the writes to the vmas overlap the register/unregsiter area
  today?  That is, do you have writes besides register/unregister going
  into your proposed volatile area or uffd modifications happening in
  the 'default mmap' area you specify above?

Barry, this is a good LSF topic - will you be there?  I hope to attend.

Something along the lines of "Userfualtfd contention, interactions, and
mitigations".

Thanks,
Liam


