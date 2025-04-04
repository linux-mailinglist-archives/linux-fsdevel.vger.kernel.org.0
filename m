Return-Path: <linux-fsdevel+bounces-45782-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8304CA7C196
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 18:34:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 340587A9080
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 16:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16EC720CCDB;
	Fri,  4 Apr 2025 16:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="e0EXyb0+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="o9SV8t/A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A611E1DE5;
	Fri,  4 Apr 2025 16:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743784432; cv=fail; b=IN9weKV4e3f88NYGo7jFKmPDdt5i3Mgb3SdTTDN2RhhVcG9srnqctdoXinstOEKiq3QGvZzehkO7mEg7XtNbK9/gJuffaonIscXQDtfLmq/Jy9J1J44E0Xt5n4LjFqC88xqelfvh4fK17/KfMLxOa5xtnS6RmPEY2hXM1OeuWIw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743784432; c=relaxed/simple;
	bh=POevaldR6+2h0/K/T9cSIKqDOZduEvzs62aBJxyC+OU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RouvAUFSkG9KyvmC9Nwt3P2f+wTuHoO27l8W9OArjjNGbLV4hVsVrK5YKlOIn2JFcOKTBAaWYYhAA57AOXno4vOmjMFSz8xk4MmVV1hDtZvzTpzlU1acyVzhof6+c7pumYMkGL4pkBEZbmSWvAU/Cg2U+a0K/PuDz9bgsM6LVeQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=e0EXyb0+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=o9SV8t/A; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 534Du6Wq031552;
	Fri, 4 Apr 2025 16:33:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=IzwoxIB6kiAOfS+kq5
	xdlkogOqcO9j48MWdneLUb/qs=; b=e0EXyb0+jJmXz/hTTWCO/cqkh2keWepeLR
	thQJ8NwiFiZ1JjFPdVti2eYFRbKAwXbt73IY4txeiJ4ENd+RHt3ytMVW+/CijCJ0
	WAsdpmhGjiqBpEThnv0lzCZk15MZpnwswivhwDVWD1HSQPyHldVzW2yPEJRwECUv
	c/BXdd0pbZ3teLd+UW5/92iTxqL0npdc+PcdVBHTKpqzDyXwPmNc6EysFxp5PlaF
	0X2avj03OBYaF8/otraaTE6/ZXv0r5MDPlpS5nJEmQzs5g3AWMOw3J0mCRPCt+dg
	vHpWPW1Ay6Hf+s8X9px9xCjy3QrxgCk141CQn6u2pLs/cG7jvfrQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45p8r9q3sd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Apr 2025 16:33:30 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 534GK1qo036197;
	Fri, 4 Apr 2025 16:33:29 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2044.outbound.protection.outlook.com [104.47.55.44])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45t2nu9d66-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Apr 2025 16:33:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GfN6uhzKOBNbnUx3rcE65DniTV96/UHEeW+nUhlQMLrgLWrC1GPMz7psWc0Zsx311HkfRkMjhKEaDyV1L2wc9r2P4y3eTqHfIO8je7R/fbw9tes5IKg+/RTTxoRA12ui9D3pU5o4veGeEihuGYVmINVmubWDJAonh2l4kf9l6UcU7SB4QozAc2K6Y7sF8iRsRiFUhQvwFg7AG+P+DfV3/Z28UnrY86p44QvcrNyuBIZTD1c+sUJrEevmTi7c7DVi86ZhERhHUK2KDeycTbmmGZ7U8Wh3WQO/eBDWGwZzqKIzzjAC5HTRsahEHRUNuHsn6qrVXYifN2II9WYOOGjlTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IzwoxIB6kiAOfS+kq5xdlkogOqcO9j48MWdneLUb/qs=;
 b=bbrwWmV9FI1XyBhrD7flI5z5v7PypmFWq1924MNjUM1kXBntqaLSMhe8IvnwccvkNrV0/lEQkWM4ICef8UZmfFAi1noA3itbO0XVfKl9uMaqfgGngp8mIbVQgJ/mlbDxPzbn+qkXQq20DUDNmE/bky32L59onT0hc38FYXRri/PIIs1Xx1M6GyVLDs7mzXcL3bjhUNUJ6Ya3mOBuH39wZlynkK6kT6+4cjrq1QwTv5i9FtbcyhfcP3oZ6OivlCneg2FGy2VHlYhFxnjd2RdF2aIoHD6vDt/TdBdkiNHfvuzshvW9h2LoWB8+ncQv1WmFpOEvaIk6s0w23NPahmaEFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IzwoxIB6kiAOfS+kq5xdlkogOqcO9j48MWdneLUb/qs=;
 b=o9SV8t/AD2ACWAtcKLyLhjG6IUTG5IJGfoYKa3bJthLgix7WAXX5OKuW2Qc+/TrkOP8GMT8n/LZQ1XlAWCZz1vI248tBf3+Kk9sH/e7j8rIyJPvDFg9xA5Cat6+fnc+GDhkyl1IrtLb9O2KEyAK3uN2Y5Dyq5K4mfRDwkqCv7Tg=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by PH7PR10MB5697.namprd10.prod.outlook.com (2603:10b6:510:130::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.27; Fri, 4 Apr
 2025 16:33:21 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%3]) with mapi id 15.20.8583.041; Fri, 4 Apr 2025
 16:33:21 +0000
Date: Fri, 4 Apr 2025 17:33:19 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Nikita Kalyazin <kalyazin@amazon.com>
Cc: akpm@linux-foundation.org, pbonzini@redhat.com, shuah@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org, muchun.song@linux.dev,
        hughd@google.com, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, jack@suse.cz, Liam.Howlett@oracle.com,
        jannh@google.com, ryan.roberts@arm.com, david@redhat.com,
        jthoughton@google.com, peterx@redhat.com, graf@amazon.de,
        jgowans@amazon.com, roypat@amazon.co.uk, derekmn@amazon.com,
        nsaenz@amazon.es, xmarcalx@amazon.com
Subject: Re: [PATCH v3 0/6] KVM: guest_memfd: support for uffd minor
Message-ID: <dc4c72a2-41c1-4548-a6ee-5a17895e4940@lucifer.local>
References: <20250404154352.23078-1-kalyazin@amazon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250404154352.23078-1-kalyazin@amazon.com>
X-ClientProxiedBy: LO6P123CA0003.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:338::8) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|PH7PR10MB5697:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cc8ee23-92b7-4591-a6ea-08dd739669f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CvnUC9iCMjU+kAr3FNTQlifAN/eYnSGEQW7pUDGujp9w1499bHmm+FRcE09P?=
 =?us-ascii?Q?Q/pMMCzDkt6iyNqY5ksGHrkzXobhqTi0oWLZMJ7Xw3Hfv22saKgQBZH5sKIy?=
 =?us-ascii?Q?kuSbsMmXqu98oUfyAfY4ib71WkKW6S6RmOo17as7pnMaksK5FuFEsPiT40NG?=
 =?us-ascii?Q?okF4BJ//vT74gzwRXL9VLM1LmKt3rHoLLjq3t0fsTGAS/aqbGodyJrCQmihA?=
 =?us-ascii?Q?OQ8iqgFDLFtAQmWU8fA+smLSdyCQ40jls4uUKG6lz4N4DyyW4sdRBPldJl80?=
 =?us-ascii?Q?9xN9invfMHgM3a0lH/NOXsD0NtdIPFKtR7NLwEg2qPtaASqcwTQHmZBQcAFF?=
 =?us-ascii?Q?L/SoEchJPlF3DrEcbWww7JyYEC9HQGclMik/MGPf0whCzkAYlUnS7O1nracf?=
 =?us-ascii?Q?h+xntbN2/nG3SiNyk8GgJDoWJEjfl07DLHNMEbUaKtY5jOnhevSr5em0fLzZ?=
 =?us-ascii?Q?QGcf+m71lIzkuGozgL819UpNsAq8BC1wd1df+1q2WgulFaAPtlEPP+++7/N0?=
 =?us-ascii?Q?qEDRzndc34lwhmPtOeWfw7qbfQYGUu9CVVeelibEl45f/Kemq1NEQLJqGkMQ?=
 =?us-ascii?Q?LMx6hEHb2xo/q5BnOEIIX9kF+VLruqYPwbc+dl8YlcSnHz1d1bLRtS1dlLlA?=
 =?us-ascii?Q?XobYPpstxV0O+CBZL/rAz7ig8DDNmzSka6c77B6599kr51KlSkmRhYYNH4Bw?=
 =?us-ascii?Q?T8MRACQ81dx46YbLM0hyclgIisEZqPj/7yxq6SjxtgJkgv2cyUtSMbJvcaj6?=
 =?us-ascii?Q?IXoBC3uxsFj65/BjHiMYncLeEw8VfsIdrD6mnd42UvPqbPQkwLDrgnfgu6VD?=
 =?us-ascii?Q?1R+1Wqh7JvjfcLrUb8Zicsc82KMRBhxer4nTwVZiKY3hUNyKlXo8xk0JTTYC?=
 =?us-ascii?Q?iukvlB25T6+Pn2iSV4SqkYSTGZuRFI3MOpwlp0a/o4VAHVFjYEVHzL0hpaFu?=
 =?us-ascii?Q?Wa52W1xFIooRme1czW1rrHKv5JlHh5H7SRM1GIYFuypu+6j6xPviSV2jZazl?=
 =?us-ascii?Q?rsnjGFbRL6l36o70y+A/XyL0yhQNtLX7Zgj7Iatxt9ewEqAHzs7BzhmNHae7?=
 =?us-ascii?Q?hCAUskUBupxzi00y29fuFdFOrD6G2U+KLBhhm2bdNImBNRU1Mb+IYcTNahQp?=
 =?us-ascii?Q?FvSwiXkWPdqUxCPpk4LQz+72IEBdIuM1Zu4k0eZ9EVnaLGY5skcB/EHby/5w?=
 =?us-ascii?Q?z6AC3XwaFLq/9ZFrZvYSj+geuRPJJfM8Qej2gnIsMvXPoNh1J8DrVfhG66H9?=
 =?us-ascii?Q?TuD3bt9txSWbN+kQdvqtjtofxrXWjsIg1Au9KKgjpy7SykQ8nTwrzoL5alX6?=
 =?us-ascii?Q?gNQ7a64gohD3A/jKgWI+tnbB69I1dnxDioE4PiZw8ID7Kw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JqsomAZH7/6YPwH6Xs1EkV6YWypPU3vnwblC88SNcB2U6OqLNFgkydmUo0ak?=
 =?us-ascii?Q?DuQW+l8mKf55IwjRrr0xLiU/erVAqm/nsQq1T5lzdCuKUd22wgZH/QPlYwn8?=
 =?us-ascii?Q?zRuHVKVvJcGJJhn98bh8cSvjCIYyqFU5UNVz4m+wpwwOedDfttmc4d+ySM7m?=
 =?us-ascii?Q?xNGi6J0FprVHJiyUgIcs2kHd5GjC7eiRo0sxrEAzoVztR+vy+xhweWrnVQ7z?=
 =?us-ascii?Q?Po+TqEJauVF9hZ/VAbz9hezw/woBnXr5YSlj3qj+Bol/tb4UHnZW5A3es30z?=
 =?us-ascii?Q?gP4DLILRt1hNrckABkmapMFTPFCeccRBiTIqmkEGenFD2mWMOONVaHijuEph?=
 =?us-ascii?Q?m6Vm+C2Ach0BRkiWLIc3I6X0kiNb2c/o/QtnyeUj38VfkfYHPDrBvgQyUhgd?=
 =?us-ascii?Q?8rS8NZfPukeoILagi9N8Kl2dk5hJMWa1UlQsWTj9geoAx3yqrpedvFW5Gohj?=
 =?us-ascii?Q?hGiF1SKcJAbnj67jTjNkJ81KnVPruJhvGSLIQTdKYxanDJBmjeAQeSmK0k7c?=
 =?us-ascii?Q?RcCAnXR6ZfbcbZSVh+6AXJN4Y7sp29UDulLVj4AUJYHRTNnx8syoNHJvNHJe?=
 =?us-ascii?Q?qibT9ymXalSJnTPVYzpRXrbLEKo2vG/5oRima6JbnzYOgz5ftq4vHpIuB6tt?=
 =?us-ascii?Q?rrS0MMvCk8kTTtztMSGov2an7CaVeMpdUNQ/H1lWaBF0uCnWoxAWhLAV4iwD?=
 =?us-ascii?Q?XxXYrpLlqhXauJuQuFxM6dJ5sTlL9I5NSTIW9+7DTrAYBF3AzgZUdD826qYx?=
 =?us-ascii?Q?SQRMSQyqUw28FPNkzek7hZAXCZ2D33IfUXNyj6VMzFXvFnWJgp5WVy0HsV4h?=
 =?us-ascii?Q?QVTtvkH/f9152eOlsP3lwYmsYrnQjNkLCrGdDhYWRu0+9sGWcv4d9Zsmmxea?=
 =?us-ascii?Q?H9OvUoXr8Lnfc0EPaoqJ6zr0gE3YD8A/UDxQpyKd1i/41CKB0EnsdiMRRSsb?=
 =?us-ascii?Q?sfqeqOPMKzz62ZAu/5+2Xx28qH0QlAXlWoK/TrBQAwcoZLG/qTb4pZiUiZ1Q?=
 =?us-ascii?Q?2qhOYK8a7p9gycsOhcUOwlAdH6ncgX1olyclYxrwPfscOK/TwaI6LmPOdCLs?=
 =?us-ascii?Q?PejbTeCQ3utpNeJJ4SVuGXFyI8nF9TxsPqSudYe5y2hvBXtvmxg4PgEzFYj/?=
 =?us-ascii?Q?yyypXaOxWQompgadiemfznAlOYCXUw0wXWzy/GC0IuXuPocdxZMF7ZHDMc7U?=
 =?us-ascii?Q?WGXpsShN5GetVbgYfupaMtSUm9OQ7Vvtyky+F8TyRo+FBQMwrgKEbuToSqfw?=
 =?us-ascii?Q?nrQeZ6scVIiuP33idbqW407GrzxjVIibQQzxwiuaV+BjcDOekABHa1TxNmPc?=
 =?us-ascii?Q?kYb+297ZkXfTaEORNOuI2Mjb83g7b16pk/FWSoBot6OBP0qsugHX04jFVHps?=
 =?us-ascii?Q?SMrW75cLsZudyGXWIhduLpP7TCWI9l/BStUdjEirqPE5hbRsit+S9KFKCQX0?=
 =?us-ascii?Q?uHgfArHsWs3Vw6QGkUJnUAgCQZDwkrmli7PlnaJiKh/9LGu/VG+lc3qt53WX?=
 =?us-ascii?Q?XXAAvtaOEP9iLsSAF10jTejBSk6MHCIKRqFh58wGbSEVNzgUBdu606/qUb7I?=
 =?us-ascii?Q?1JMTuNAgwB2OFxX1It2CRDNi2sjHkuGe28Jvv/lbsGXIc8172DYjJD4o6mn7?=
 =?us-ascii?Q?sA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mInQr7tLStLmUuDx2tEnJ9fKuviC8udnv2WtY0901jNLDWw4PJJMPKirSW+u2bJCZWWJEDP4gRuJTw/UD6oNNY2NFEfcxBd5sstONx/s8a4hmHiNFWDv1KaT+WmmwcjobgLDZuRyBcLGqZ+kdbkLpXX+v1j9h+HKPPtDQipgZ/7Jbe1dW4Nzod4RK9c4y1vtvdJ6vrq05IbOjhcTQ2qYgunb5zNOm2vHVdw9vh1l44CGfbEy98VzVBARDM4EQfXhZR/m6kgRnJWjODCFSfGPX589RCPsy/hoJPFejwvVlzZ2Vvm5UlfIJYxA0rZCj28xh81324WgKtUoAgEBdy9jjRHi9LegAGuT3Db0uF9BkZbEJsuASf2mOX3CHh4H1FjmNwSinieLe5mNqmhueoG3AxShP87Z8TBiO0jVgffjTCM9XJ/uuwf9d+UWuF5dsobrS8yGCw5ma1F+wYZqPeBryIA+qb7c9GXY2msz716DykaiOSceUMQXmfnYaoyYJRbq7m+JDGEdFt8VYf1BY7UALYgheI9bQfecjNnLfdfbLduMZ1nu+DVy9hSxb2UgPR5y3CWMkg+U0xCAiW6DfyMVO+1he61/aYesESuASvIr5Po=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cc8ee23-92b7-4591-a6ea-08dd739669f8
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2025 16:33:21.7557
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E6Nh+bkqYmzDfASbHVc7luj8HtP70uslNgqRaob1wNQhQK42Ty8U+IUvHBjAXSOhk6kp/fUochg9uaFqMc+VWb0m9vp4S3F2h4IiKH+IPF0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5697
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-04_07,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504040114
X-Proofpoint-GUID: ODwv6ZFnEZfxyHSDH1r8ZkI8wmgAPx9t
X-Proofpoint-ORIG-GUID: ODwv6ZFnEZfxyHSDH1r8ZkI8wmgAPx9t

On Fri, Apr 04, 2025 at 03:43:46PM +0000, Nikita Kalyazin wrote:
> This series is built on top of the Fuad's v7 "mapping guest_memfd backed
> memory at the host" [1].

Hm if this is based on an unmerged series this seems quite speculative and
should maybe be an RFC? I mean that series at least still seems quite under
discussion/experiencing issues?

Maybe worth RFC'ing until that one settles down first to avoid complexity
in review/application to tree?

Thanks!

>
> With James's KVM userfault [2], it is possible to handle stage-2 faults
> in guest_memfd in userspace.  However, KVM itself also triggers faults
> in guest_memfd in some cases, for example: PV interfaces like kvmclock,
> PV EOI and page table walking code when fetching the MMIO instruction on
> x86.  It was agreed in the guest_memfd upstream call on 23 Jan 2025 [3]
> that KVM would be accessing those pages via userspace page tables.  In
> order for such faults to be handled in userspace, guest_memfd needs to
> support userfaultfd.
>
> Changes since v2 [4]:
>  - James: Fix sgp type when calling shmem_get_folio_gfp
>  - James: Improved vm_ops->fault() error handling
>  - James: Add and make use of the can_userfault() VMA operation
>  - James: Add UFFD_FEATURE_MINOR_GUEST_MEMFD feature flag
>  - James: Fix typos and add more checks in the test
>
> Nikita
>
> [1] https://lore.kernel.org/kvm/20250318161823.4005529-1-tabba@google.com/T/
> [2] https://lore.kernel.org/kvm/20250109204929.1106563-1-jthoughton@google.com/T/
> [3] https://docs.google.com/document/d/1M6766BzdY1Lhk7LiR5IqVR8B8mG3cr-cxTxOrAosPOk/edit?tab=t.0#heading=h.w1126rgli5e3
> [4] https://lore.kernel.org/kvm/20250402160721.97596-1-kalyazin@amazon.com/T/
>
> Nikita Kalyazin (6):
>   mm: userfaultfd: generic continue for non hugetlbfs
>   mm: provide can_userfault vma operation
>   mm: userfaultfd: use can_userfault vma operation
>   KVM: guest_memfd: add support for userfaultfd minor
>   mm: userfaultfd: add UFFD_FEATURE_MINOR_GUEST_MEMFD
>   KVM: selftests: test userfaultfd minor for guest_memfd
>
>  fs/userfaultfd.c                              |  3 +-
>  include/linux/mm.h                            |  5 +
>  include/linux/mm_types.h                      |  4 +
>  include/linux/userfaultfd_k.h                 | 10 +-
>  include/uapi/linux/userfaultfd.h              |  8 +-
>  mm/hugetlb.c                                  |  9 +-
>  mm/shmem.c                                    | 17 +++-
>  mm/userfaultfd.c                              | 47 ++++++---
>  .../testing/selftests/kvm/guest_memfd_test.c  | 99 +++++++++++++++++++
>  virt/kvm/guest_memfd.c                        | 10 ++
>  10 files changed, 188 insertions(+), 24 deletions(-)
>
>
> base-commit: 3cc51efc17a2c41a480eed36b31c1773936717e0
> --
> 2.47.1
>

