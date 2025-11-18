Return-Path: <linux-fsdevel+bounces-68907-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A07C6800B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 08:39:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id A831A2A29F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 07:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65321303A10;
	Tue, 18 Nov 2025 07:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fHHdsmcG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="J7PeZkXS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036332FFF91;
	Tue, 18 Nov 2025 07:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763451427; cv=fail; b=W7bt3DaKV0d7sboIUkq0svSMbkskRNXav33VUqWg4ac0cFq68Cxzh5cAj1CG27G8tXLuuiehsV7ifIjzqNXxRCC+wnEk1iKxeNPp/PwkWxcMUxpXeXVkcooij0mWBtXhKMNjjY/2SCPsWB8+1ZW9U9YzEEs5jZNw70PG+gg8O+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763451427; c=relaxed/simple;
	bh=hqELTbik36RsKyhaV+TJj4p20eblzEmc+ZxNAO22g4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TO6CdN+eFF3U/BPQ6J1KMcmFMLylWZ5eVsO5R7WNAdszPci/YuACaQ+v9BLFO4voHeWq5rwgc4NDK+skif31SOJjMrS/CM8+lFIRFJSo1k1karX/wobBMIhOtrh2wkD/x9BbiVEnVgcWsrHRD2sW9qmtJ3lGrKvgKslYtDgwrGU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fHHdsmcG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=J7PeZkXS; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AI6NpTf018931;
	Tue, 18 Nov 2025 07:36:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=/CVs+YWpNgehULzU/b
	L+Mf68vJ/VVNSjgl3VNYmgs6U=; b=fHHdsmcGqK1KMc8emNiYYyFXfYpUaRAIYV
	TlLL7VOoRksAfilIu6ZEQSl8I2Dmu1iWinHI4WkzxC45LifAlFdn66o1hPTZTSbL
	rtmGB92KCWuV6ZOtFWrNdWXf61BImq4C0xMEnAzeTXTWMw0GkKUgZoX0vuaaAQBz
	YfV1N/G+ryfSED3BReMKfLd2Y8WcNp9cFKImG88++viSDra131kiaLku4S624P5+
	fdnXYqVlEGBJ1LJ4JAZKwe95/eS/FFH0/PWfsJ0PbP1OouGSsoXk9YW89A8MJIdn
	3/Jy9WTM3oilgMJoB/YxT25jmHl3VbpaNp/h11n7na9PXZKTRSmA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aejbbv8fh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Nov 2025 07:36:07 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AI60p6a002483;
	Tue, 18 Nov 2025 07:36:07 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010018.outbound.protection.outlook.com [52.101.85.18])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4aefy8swvd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Nov 2025 07:36:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SYNV3rkYgB5f1aq8mPgSQS0sdu+7rFGwXsBzU5MKrUiEtMSCzkECOW1rDMpjhiNcgT9x01kNxtT3SoLEBDmSHKyReIU5UrJktVhQ/JndGEoa54BgK0d8hQW0T9jGdame655dx0pzO0Wde3sAjAMC7+einEf5DOz0hgWILhpGbtQ2CE675JWAYVWUTOJlBpksyNDh50h9aDnBp4ZAwIjpXsZY4MDbz6QmEr6hM5rZO3ZFydkuQDWakdyoH7av6u7RV8orT0wAyPBSgTN4DOUczGwSv1w97Rpup9bWd9IxrUXQnFaD30hZ/S9Q7yHLjXgqfAaiLMKpunEktqSE4lxrIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/CVs+YWpNgehULzU/bL+Mf68vJ/VVNSjgl3VNYmgs6U=;
 b=O3T8ajFyWIzpMdebf+zfe2EIbC+IxteGXungY8rLMZ+wosmRYVqVL/WjY1cV9OCQGYv+62bXOrUqmw/OjzOgkrh89zu5P7ikVbPu4Ez5ii2Haly/tnxwyqk8wNCS9NocnVrpfazlqXdI2/1v04xLgISLHtnPQ0mENrr49q4XQAqM4VPicf20xTZjTq3cH4r7rMA6OimJchfCgFxGmoEhrAqU4FYPRPH1AVdh4gsR2Lw27wLQ6hYR0ePmWVuJ8l8bTGWKJ37CLqKgy6KOzu0wIaDWyrIVeiWP/qLggITabwhIn22lNnYRc/0IKK8heyAmoF+P5wA58a6uDTaNgHQsLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/CVs+YWpNgehULzU/bL+Mf68vJ/VVNSjgl3VNYmgs6U=;
 b=J7PeZkXSzcjY7dfzHGu8oGPxWG6I0uHhZXPbdnrz0rhr/Zu7MJ40ptxdazurYzUMOSSH+GO5dr18bgbFdHlugi2GeUZt0bAFPbA8dk3ADSwPpiZddW4tRAnDx32Q1tI00THvSQRsjs5lKhGOpqxqIHOJTdZNsJGH9n5x8UOeZPw=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by CH3PR10MB6883.namprd10.prod.outlook.com (2603:10b6:610:151::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Tue, 18 Nov
 2025 07:36:03 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%6]) with mapi id 15.20.9343.009; Tue, 18 Nov 2025
 07:36:03 +0000
Date: Tue, 18 Nov 2025 07:36:02 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Lance Yang <lance.yang@linux.dev>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Andrei Vagin <avagin@gmail.com>
Subject: Re: [PATCH v3 1/8] mm: introduce VM_MAYBE_GUARD and make visible in
 /proc/$pid/smaps
Message-ID: <057b6f29-2655-440f-9db5-9340012a7f35@lucifer.local>
References: <cover.1762531708.git.lorenzo.stoakes@oracle.com>
 <94d1e9c6c6dd8a4de1f2a8022ca92e2e320730ff.1762531708.git.lorenzo.stoakes@oracle.com>
 <9e617d7b-afd7-465b-b075-32b02257b90b@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e617d7b-afd7-465b-b075-32b02257b90b@kernel.org>
X-ClientProxiedBy: LO6P123CA0017.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:313::7) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|CH3PR10MB6883:EE_
X-MS-Office365-Filtering-Correlation-Id: 8db45ba6-03f3-48d2-4918-08de267520e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OmXkrxGT0P9Pj46KwI3MmdUMjJt5Ih0Dy/JhCBf0YlUnUyW4ZZJC4ZqupIqD?=
 =?us-ascii?Q?wSmK5RFL1xRubt8bDroyYuPsorm62Xtd3+IVyEwANjsDytWnXuX7gFP8ubGT?=
 =?us-ascii?Q?wTtjoT/4oSu5A+ifLYUVI3yUpIdwpAmm7K0smNXFCS5mdXLJezOXLKITX1Wb?=
 =?us-ascii?Q?IozCD5//lcbaIjytHXOl6MkCYvWRF12wVPAI8aGAWyxhgNuH6hAFo1pmIFAu?=
 =?us-ascii?Q?NCl9od4KGS5in5eseYFt1jo1nEpC2BnNmzta+r3arEBJcenrn1Myd3rEfoBi?=
 =?us-ascii?Q?5TCfRvwtCjcPKLeMk6VeGaNLknmfqcUy9Qdzpm67K42fGjEZ11mInKwhKHV6?=
 =?us-ascii?Q?lcfDmfnBRH5iy8+TEudx/aHJvY0MphoglHdLDTHK7+ER9u+bJujo/02IQnhj?=
 =?us-ascii?Q?u9RNgH5EdrpkL7UmTBJfz+MVaEHefzTCap0EjB5EwTOKQIRl0mCvj6rGgebY?=
 =?us-ascii?Q?lThckSMdabkBdrJGD2uvqT9LJERwXzVRQPrDnKNCn/YLGo8Ph3DZs/OPowHz?=
 =?us-ascii?Q?t0fMwIZWoFjz2Kw056M+qBh3jzNFzOTXyObpNR3oQvpRCL/toN4aBBlHvThj?=
 =?us-ascii?Q?/qyccCvLzjCj7gWvGymo2uKrAOTtSb7QdJfx97UMx0WhktrpSeIOSOX9GI7U?=
 =?us-ascii?Q?RT/tqdJTO9heannURLKAueHHF9yEOBroKjUWXZMzj2ventnTFyGsAb6Za2x4?=
 =?us-ascii?Q?YNg6FRa1M1mlUwUoPCqkmgC+0AwrqReS2JyQyIj8c+UtpbYNe60lWwAAaxty?=
 =?us-ascii?Q?egdh35gc9X052pJ4IKsJcPwH8d71zyZeIx/QHPyvS8qmCpBJ+tUxNiFgZXiz?=
 =?us-ascii?Q?ZgskW9Ucl4FcjbqEpDBBOtrdjPJj25+fdn5c8sUhCf49okOTR7CCzMwl1HPD?=
 =?us-ascii?Q?o/dCqGmIeCSMSBMBFRda+OLnMEW/pTcU5dryzb4TG4mKjAZq3AwTR4dplMH7?=
 =?us-ascii?Q?GrotvCqWX1X6D/4Un2dzoeDqyuuIFbnjQDWPqFqGDJUMtRe1xY0w4QCBgTG2?=
 =?us-ascii?Q?2OivOkyFumK/LTWPFVEzulNQ216cehLL5MjTa/lOlaMdi1DsaydOiOxM0Pjp?=
 =?us-ascii?Q?2Kw41C6FEs2rwmv8kG3ZHc9E7WPIJZPFClPJrngrf76dtZSIFb3QUAk8uYnI?=
 =?us-ascii?Q?kCMj8KIdnNqHwYN/c2On/YEOcKXi2jKEf4daDezuTg5TO8oG9RpWEQcTLvr9?=
 =?us-ascii?Q?zcIgC68VqiEkKdb//buB+maCnIcJpshxeP34pQKtfdtgphngXk6pnWp74iYA?=
 =?us-ascii?Q?Pe/Oww2cjZ5QXZ8afuQo4Ysgs9eTEKP9pota/SUeOoFqqoPaH4KE29ZHRxMX?=
 =?us-ascii?Q?gEQX9g1ot+lsq/AUOLhQofQ1F8QClLX9PRl4gDFkmT5osyoSqsKVYNms8dsY?=
 =?us-ascii?Q?Zt0Oy9oF+2sn1RNdMsF0JlGPGyjQ27jafr07bpLKUdm2pD+/iJ8e99hVJOyx?=
 =?us-ascii?Q?YE2MWNFmFdON83jHrD49gswk4EZq8EyW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7SWuvYfyfWAGjByoCWP7E0ZciswvBWfoQmKmjRIlrbhmXbo8pBVrXmMliR7K?=
 =?us-ascii?Q?CW9sv59Kpcq5BJTVlXbZKRkXuQqDtjvmY+GAwh1O4fOILyfsow74nGyu76XL?=
 =?us-ascii?Q?mq5ayqUUY43g6lUs4Olnk023bNeKq1iECINj+dkevqoZW4WdKXPdTDe5IuDZ?=
 =?us-ascii?Q?5x73pjanhVVY8HRzUmDbYH/hI5Ybj2jvkgzeaDRs2oCYKW/6pwiWOArItAU9?=
 =?us-ascii?Q?Xl7zPUBegukeVthA9Qm272J8s6VQPBnP3HTaOqOskHhwpnRL6Wl1sCqSrBCL?=
 =?us-ascii?Q?ba7lIgtna3ZvSBSPjP9gKmgssrUlDobOHzlfbZzXDW8sj73iaY0cL7Mbos4L?=
 =?us-ascii?Q?mAOOGlk40mc/e/AKfebXx9qaYyUq3FTE5P7Bn39IEsJSYavDbzAD+Drvtkw5?=
 =?us-ascii?Q?irvD63WEjRyz4KqoRNGDKEDEIBDR7pLlcxO/PmbCFO7sjvH8r2hsY1fOjyPg?=
 =?us-ascii?Q?/amPOWzKDSGkOnGEIjpLBEt1RUcGBtnXYSuJ4moX74maaeHLHU+e5UddV0V5?=
 =?us-ascii?Q?/FgjOcjEnGRReyVSsRVb1U00vbXEo+qyYlFFjcpH8tEjMIszr1j4CzhN0JgZ?=
 =?us-ascii?Q?qESjBB04zYeO8227jq1vQaF4Jhpgyp49EVwtt3k749qe/gpjjBxeZDagyCEM?=
 =?us-ascii?Q?0Y4W+71j38Wuq0PD+OgqUwNWWUxL/1+vhAb8B14H8wDjRhT4/Qts2nXAW5PZ?=
 =?us-ascii?Q?iutVndY7BmiMC+xW1Mo4qiYD1t+oDQNpi1p7XeO68VdgwUDn+wE2a6JTlHgh?=
 =?us-ascii?Q?3BQeUCQVayJOo8vzldfs7VfIxghun5dbKB41cboeIH9Q5A+qSb+Hl2OBkTSU?=
 =?us-ascii?Q?QiL+Reu+I59QsRjvyavQWofgZcfNC8bvXvR+inY+srrK5aGVz3mzSu92wH6g?=
 =?us-ascii?Q?iLX9xpdnhwC1JU8q7Ko8WHxV7omhyOSP6eWHmmBSA6L9JTpih54Y2sF7AAEP?=
 =?us-ascii?Q?PNQK5vBz4OzQHnyZ/APMPKRFD0Mkbwv0WMU5iW+eMnpUBO+ffwwTDOXs4MNn?=
 =?us-ascii?Q?KHDPofU3XDQUNwtVNHPwk2+uycz7EsRbE0ggHEw9NNBHIC8Fu8kIF+6j5xGq?=
 =?us-ascii?Q?EKd28imZjtHaCB21yv1NJL6/su/12Hg6rSoje3VaBKAkLTGrclrGv0ztnPX8?=
 =?us-ascii?Q?HTKjIuv//Zsa2qB+xZdvVtjkAq0DD9VeBW4eISHfBz2DsRBcydbbGhlfN6QX?=
 =?us-ascii?Q?oJGvJlB+Qf4RZMecnN+hTw6/J1CtDgzpsTaIFwJbuCJlQFQt69QcxFRqgdWH?=
 =?us-ascii?Q?J2ZR4uHX/SxRt2Edfar0uNOp0IhwzbQpYGEOm6CAqJzTOTJYvVV2MZuWldbe?=
 =?us-ascii?Q?KOWeZkWOlbPFm0kPshNfLASKxidccuwQND210dE1JbZszybCGolGjNa5I/pe?=
 =?us-ascii?Q?ULr1gLzU/dCFWU8L9FJ3gdlTK+wu5rpZVXcUgcmOtfs8wOqb4I1DCzAtTRTu?=
 =?us-ascii?Q?+mJZIdakzmjn9rghzRfeL/MhBts1Jxzys46LXsYVcZfkazSRbVtz+eSEYoJH?=
 =?us-ascii?Q?Qq//jTWBR7H840T+BX+Bio/rN2yT+5bDLJmd7SJ3iqvH69FrnPIMo5peRlz9?=
 =?us-ascii?Q?Sya87sLlqIjh3O7y77F9XwW9E4L1JaDLv4OXBQKIIZPnyAKBzUhM/KWITY2Z?=
 =?us-ascii?Q?1w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ivKs6napEFmrge9iYiP/DlHStPMHVefO+wVKDwPSZxNKbgHyFErVzzIpMaZPAYzPaS2SHT52OU5b7tgbsJYwrLH0AilTNlE1NjzuoWNZq/9BW10X53HRAmma7V79oYGtDMQfLwSArUHMVQkgt4FIs5VUiSCs3czakeaTB6vGDn87ZT7hEE/uxNT80cuGeDQcY+XWkCrA0ygdDjqubZPc/ykd2CeGeuJ6SMY4GsB2vHkio4pHt494/Gr7Y/a9gGHC3bCncrl4caZ77pLMb19FrDHGKncgOp6F1toyqTMx8I/1dI5crxIOWWOJIcrMihNo1n1qBm5/7wb70tKObNuVX4271MOWUmwnlY18KLitPYAmJhU9+F7LPw0gui8PwYQ0YzvejxqcesCUrHeX+qELVrjSlHqWHppHtEciDqs6p6IgysRY0FijYizChlzP2Nunqn6BBAFn6UgSpXcBCN9DuDhXwwuCHTVJRB0aqKjxfBPOA0LAtZLbuIEXFnbf44LZTSQAxVkwTNwAsgfRZ6wMLptUghmqXO6uBaiVxyftRmPRZxL6BJS7aZQED+Xptd2/ok+69Nfu/nm+T++lb6uNJ/kMYR29O43fcsCPnKSYK9Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8db45ba6-03f3-48d2-4918-08de267520e0
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 07:36:03.8440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gPTtBN/4EuOiXKFCEcCveU+/hhRL1sstSvx3da82QE4WLbm8ad/Abqqi9ltLOdWBQmbGMCdCRz8uiDt5o66FWKXwOZURXitR9uIcnjtINaM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6883
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_04,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511180059
X-Proofpoint-GUID: oRrUKbIQEZ0EA_eaIOvoSZscAEcdokxP
X-Authority-Analysis: v=2.4 cv=JZyxbEKV c=1 sm=1 tr=0 ts=691c21e8 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=GDoLJOjFvT-abBd5_6wA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: oRrUKbIQEZ0EA_eaIOvoSZscAEcdokxP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfXzxYdvfD3Okgs
 6c3+zBj5/AcRwkHmAAejb9AUVY71jrjWfnv3ubCWORDVoGIvQTeQ9Mmtm62tJ+xGvL6vDEWNRc2
 P1MJOSExmmAzRluR2vVSh1/u/uuinc8+ApzjKf/0A9xUSdbpP30rFT4UyD2o9VPhWakULCXG6NV
 KM5X8oPI+1j4sS00cMlf4mtO0uhUWfSOGYRwq/nmdtdXlRrWyPhy77P//rjB2RqFE0NI16O3xZf
 q9hJl3W1YgjjsfVTY9okWUS2Zptv6mdPfDZ4Yr8rpaUhj5PPjnPvmHLqVLlXuc3KUfUSoNBzDes
 cy3g1MChNn5SXqPQHtO3P94tkshjxjAK88cG2U+RKDuBfdkqv0Oz3FvspRBMsRLiGFmj2HppZhm
 YLmQ6+fejDBHrNv7yP3ykOInWDyAxQ==

On Mon, Nov 17, 2025 at 04:11:47PM +0100, David Hildenbrand (Red Hat) wrote:
> On 07.11.25 17:11, Lorenzo Stoakes wrote:
> > Currently, if a user needs to determine if guard regions are present in a
> > range, they have to scan all VMAs (or have knowledge of which ones might
> > have guard regions).
> >
> > Since commit 8e2f2aeb8b48 ("fs/proc/task_mmu: add guard region bit to
> > pagemap") and the related commit a516403787e0 ("fs/proc: extend the
> > PAGEMAP_SCAN ioctl to report guard regions"), users can use either
> > /proc/$pid/pagemap or the PAGEMAP_SCAN functionality to perform this
> > operation at a virtual address level.
> >
> > This is not ideal, and it gives no visibility at a /proc/$pid/smaps level
> > that guard regions exist in ranges.
> >
> > This patch remedies the situation by establishing a new VMA flag,
> > VM_MAYBE_GUARD, to indicate that a VMA may contain guard regions (it is
> > uncertain because we cannot reasonably determine whether a
> > MADV_GUARD_REMOVE call has removed all of the guard regions in a VMA, and
> > additionally VMAs may change across merge/split).
> >
> > We utilise 0x800 for this flag which makes it available to 32-bit
> > architectures also, a flag that was previously used by VM_DENYWRITE, which
> > was removed in commit 8d0920bde5eb ("mm: remove VM_DENYWRITE") and hasn't
> > bee reused yet.
> >
> > We also update the smaps logic and documentation to identify these VMAs.
> >
> > Another major use of this functionality is that we can use it to identify
> > that we ought to copy page tables on fork.
> >
> > We do not actually implement usage of this flag in mm/madvise.c yet as we
> > need to allow some VMA flags to be applied atomically under mmap/VMA read
> > lock in order to avoid the need to acquire a write lock for this purpose.
> >
> > Reviewed-by: Pedro Falcato <pfalcato@suse.de>
> > Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > ---
> >   Documentation/filesystems/proc.rst | 5 +++--
> >   fs/proc/task_mmu.c                 | 1 +
> >   include/linux/mm.h                 | 3 +++
> >   include/trace/events/mmflags.h     | 1 +
> >   mm/memory.c                        | 4 ++++
> >   tools/testing/vma/vma_internal.h   | 1 +
> >   6 files changed, 13 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
> > index 0b86a8022fa1..8256e857e2d7 100644
> > --- a/Documentation/filesystems/proc.rst
> > +++ b/Documentation/filesystems/proc.rst
> > @@ -553,7 +553,7 @@ otherwise.
> >   kernel flags associated with the particular virtual memory area in two letter
> >   encoded manner. The codes are the following:
> > -    ==    =======================================
> > +    ==    =============================================================
> >       rd    readable
> >       wr    writeable
> >       ex    executable
> > @@ -591,7 +591,8 @@ encoded manner. The codes are the following:
> >       sl    sealed
> >       lf    lock on fault pages
> >       dp    always lazily freeable mapping
> > -    ==    =======================================
> > +    gu    maybe contains guard regions (if not set, definitely doesn't)
> > +    ==    =============================================================
>
>
> In general LGTM, BUT in the context of this patch where the flag is never
> set, that's not entirely correct ;) It made sense after staring at patch #5.

Yeah I realise that's a bit of compromise but I think relatively benign
in order to split up the series sensibly :)

>
> Acked-by: David Hildenbrand (Red Hat) <david@kernel.org>

Thanks!

>
> --
> Cheers
>
> David

Cheers, Lorenzo

