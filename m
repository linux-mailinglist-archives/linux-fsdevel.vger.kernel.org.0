Return-Path: <linux-fsdevel+bounces-56771-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30762B1B6D5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 16:45:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 140BA62487D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 14:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36F9279791;
	Tue,  5 Aug 2025 14:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="I3Kd2ZhA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HqUcYdT6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95204278E53;
	Tue,  5 Aug 2025 14:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754405072; cv=fail; b=MyKgqEao/SomIs+P+jz2snzV6rSZIg/4tCKlRhevhr7aL53df57tQPgowMuqF+yUhNVbrR3xxrjp8mZCkSBqriZuRdBvOMBziSc50VqXGbPZStGCOLBT8QRmSOWN/cqgtpy83Rtj/Ehhiw+v6ObGxEYDeO6+V+DiPi2AtAwQKz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754405072; c=relaxed/simple;
	bh=qZ6SDpBZVFcos1bxW0L04ydeA9/CRhqo7tcskgbcsdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gFRZ02vlTWLEbbs8Dx+2xp18PqoBiNvz5BQeTFFSD4cEWNYm1mAWVCdQs+p3W+Ns5n3dqoWDvyWORrcRp9WjKvgJ/Oi1sZwvgTE4qEAloKV+ZoCpDO3/1CjmsXosAwGoq5oEpr1Qx5xsJrUhz3N6Bw/HYLRHSEEmQNqsTuPam2Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=I3Kd2ZhA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HqUcYdT6; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 575EY1U2026742;
	Tue, 5 Aug 2025 14:43:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=JGdR2XuclQnitEnZTx
	iGjz698kec7USfkN8momSlO/s=; b=I3Kd2ZhAoEFECKvjznjvFBbFK3LEf/ktpS
	GJTEtkmvRbdTloDLTIIt9ErKxYxEOhhMQdi6tciIEEunLQyK0fVpa02u60S+/5HV
	mNSZ9+e1OW77hJSR9M/ysUWpXauu4iOG5rasbgTMeDDekJU2yY09L/zfpHLgFIQx
	2CUaNzKKJJ4UBQuse3ID01D+EogqxyH+E7wOI83NK73iSoDYmZHWR8ptpc9kEjEP
	VVz+CEhi0qO4zDmcGhbqv2rHZ3x3n5vc3V5Vk0esJ5Qwrbgc5zg/LdoSTsUdE0JS
	po/3tNqwyBPfND2W6c7/8MvgG5661Ben72q2d+2Gee1xUhEK40PQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 489a9vvvsx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Aug 2025 14:43:33 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 575EVT59029763;
	Tue, 5 Aug 2025 14:43:32 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04on2048.outbound.protection.outlook.com [40.107.101.48])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48a7q22eph-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Aug 2025 14:43:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BI/4rF92Rp4kILcvmzwnxXyEZz3+IM859BPQa0WqFOBlI7AS/Y4vztsZiyJqyNkW2TZ0KW+RygWrnAoVv/C1CjfoqRo41Wk+1r1kFJuQlTrwF2jdHYntT2a+4j3dfU/H34frHHU2nZC9kGY2HNyQinQTBtChiYNczqNv4V3RsvWfRUBWk+u0/VsC406t6neL9+ckC2sy4qjjU4PixK7S/5/VBWoyh2uTtSf0SAQOYjrVblpNxuteP9DhBX2HBaw0gaSxPD3wpli+mzN9JnLGJDiH0EiWb7+KtQ3Qe9X5mrxfzOwjR7EhlZQAUgx5LIGUdBPiTbQ1ZyZfhMgkobXLwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JGdR2XuclQnitEnZTxiGjz698kec7USfkN8momSlO/s=;
 b=E6OPevUjZMcIYZEYq0d8hS73w/0rQbpBicBeG7N238E8QGS6h3yaxUwe0dxbD91hbUjNn/1zvTPuJA54LL07khuiPCdvWvCQmx3ZtKw1TX7gtZeGkD+6E+wbL7bkW5l6emzOmp3gEySPc3qjaoz3nayoPS+yottyVMfQBZlICgaq+veqAojOvVldwaAGhJXth1MuWadYANYBTkBGFR9/j5GBpWk/V5UBB1hj3ku9UAejZcZs6IoTjyc16aBvSsABdyA555qc363ZKQWpL0/DiUsv9sDA4gSs7hIdPXgf+E7aYoJ5mVC27VQnBNs+Clj+pTGsg2D+b4t1zApX37QL5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JGdR2XuclQnitEnZTxiGjz698kec7USfkN8momSlO/s=;
 b=HqUcYdT6h8TmctBPIewWsVA7oL4H/NUfS/XGtBd71kh9Oswl/C4o9uvvicFG4MfthylMLmm8qreoLrMp14w+2iUlDQN3lCMqnBYXJfdqEPIZl9U5FW4MZMF397r05isQ7SU1gkCN1yD8vuFrbKpDb6us476enHSNl0nU70K26QA=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by IA4PR10MB8280.namprd10.prod.outlook.com (2603:10b6:208:55e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.18; Tue, 5 Aug
 2025 14:43:28 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9009.013; Tue, 5 Aug 2025
 14:43:28 +0000
Date: Tue, 5 Aug 2025 15:43:26 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Usama Arif <usamaarif642@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, david@redhat.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, corbet@lwn.net,
        rppt@kernel.org, surenb@google.com, mhocko@suse.com,
        hannes@cmpxchg.org, baohua@kernel.org, shakeel.butt@linux.dev,
        riel@surriel.com, ziy@nvidia.com, laoar.shao@gmail.com,
        dev.jain@arm.com, baolin.wang@linux.alibaba.com, npache@redhat.com,
        Liam.Howlett@oracle.com, ryan.roberts@arm.com, vbabka@suse.cz,
        jannh@google.com, Arnd Bergmann <arnd@arndb.de>, sj@kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        kernel-team@meta.com
Subject: Re: [PATCH v3 3/6] mm/huge_memory: respect MADV_COLLAPSE with
 PR_THP_DISABLE_EXCEPT_ADVISED
Message-ID: <8bfed1e2-ec44-473b-b006-8cb2505220d4@lucifer.local>
References: <20250804154317.1648084-1-usamaarif642@gmail.com>
 <20250804154317.1648084-4-usamaarif642@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250804154317.1648084-4-usamaarif642@gmail.com>
X-ClientProxiedBy: LO4P123CA0396.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18f::23) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|IA4PR10MB8280:EE_
X-MS-Office365-Filtering-Correlation-Id: c788b11d-3aed-4384-7351-08ddd42e70b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0koLmiDYJpbaBwGUQlgNZ/SS3xjD8nmp8raF+PPGDAUfWWvNEwBqppEtG3bS?=
 =?us-ascii?Q?bdi4jQnExpcut9aKbl0zW1ZH+huU9m5a+kyTEbVQYmSRWC/xyO3dwQDxVPLo?=
 =?us-ascii?Q?pQNIulzG5saLvM22+xumpLTIiMgxhX6l2ufQuujCCBI6sOYnX9mUOwcmD/Ui?=
 =?us-ascii?Q?nv8ccWIT6CF6TOrzCfDteEoIcW0VDOc6QRFvkEnH++N+/aSiJTC+7SMSo11l?=
 =?us-ascii?Q?ow7vyN0DwnYThciYSZhQkB0MkatbgntxPIFXiIYI2UsYEc2FaWUlo/gETKLM?=
 =?us-ascii?Q?cXIdWmf3hUDp6TiX41woQ0u9KAeAnyTTX0NdxzEMrA+enwkzEaaihoGH8H6e?=
 =?us-ascii?Q?mMW0lc1EUYLUNbHdQCmGgXNYDxVfmuTEkec+eT0kFlAork2pBlKXhgcxQ0M2?=
 =?us-ascii?Q?boLpuEM6+iJZtzNCreIOfArLAxzF+eKCH1c/F5dEOA+xFfc78px9DYWB0k5C?=
 =?us-ascii?Q?mw1XcL9X1hUm+E28jAAStWLvNSCXtbeGlhxdHieSGuAmxRkEBW/9D6jvMq7d?=
 =?us-ascii?Q?QcXNc4Fz7FFqtY5pkVJtGFeBLv8SoHu6IwG/+fb0xJFOIELIS27af8+Bsd2+?=
 =?us-ascii?Q?maUc9uuYw2Je3r4UCGzMp7nWpAmVOI9FhPiiz60pAjgPbiAgU5b9RlC4ET3B?=
 =?us-ascii?Q?lP7OrbCTDQLkHh8S2iWzYaRsvMlQZ2yOdnaOjWZZTGfe3+Z0rlfM+myo9ffK?=
 =?us-ascii?Q?qJcdJljB8UY7mw7sLRh84oMmN/+jO7HplhjNSssSaTFaDbf0vmHwlA4SxBiT?=
 =?us-ascii?Q?GrhrmV/tURH67ERl1wGv8K50y6t8A4A4JuwOyfO5m7lE0pduweI0VB6Poe/J?=
 =?us-ascii?Q?B8wM7DrIvxrS07P5PhSG8CULvF8JxFXBpX7YMaeVSX/xmo62ihZXmRj0EkXx?=
 =?us-ascii?Q?NEywZH3a3RhCefpEFzjKrJCzOod98oamS15MLpMk/oewzt/aVoxaUvAQf1Go?=
 =?us-ascii?Q?yXJCNjS6jus5PQ0nXEfY7o5jyJhYM9cP7VNnX78i5F2L6TPX9uCGAD2Fq2ey?=
 =?us-ascii?Q?AV/8o2qQUy0CB47GKWo5strafOTUibqOcdHMc91cJyg0SpF/cFqSBXn/A8Sf?=
 =?us-ascii?Q?1hpAb/vhGHwcrlS9qqGRWcwhLZJx9HufXl4NTjIT1EieFhn/KcYObAE3+EIl?=
 =?us-ascii?Q?LmQgINsMrlI5LGojmSzC4xPYNT0sE148NBEicuvY2+9GEzQBb+wtyt5SS2wv?=
 =?us-ascii?Q?Sg/BrJWzJZ8es5NWc4zEYrdHmNCc7eDQx1/FW4VukrjNNXlZZRYM64r7S//p?=
 =?us-ascii?Q?ACpuxevVtM92U1Qh9whQP6uq8Mpz2fDc/MUC76p0zdaBS745KxbtouTIW8uA?=
 =?us-ascii?Q?9xvX2ix2Q/NaVzfCjQLPA7TCTKP9QTN/d3vc/zBuiuUowmRCB21Fj+AFxy1P?=
 =?us-ascii?Q?J0bEBFzA5faTcWE9vhojMyFf/RYka8NI+p1Ey4hzRYNdWHDxBtzbd1Xx6tzC?=
 =?us-ascii?Q?YgyQz680kVs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qFJPGHuiMlPzPPJPraP6HFWFiqgy2pSFgA4R6n0vEeNVri7Ry98jNd5/TmgG?=
 =?us-ascii?Q?u5OmrG/2Hqe9Zz44V3BnFKOpbSMVozZO4npEQAehRRzGdIGXRF2W3sRB6QAy?=
 =?us-ascii?Q?9QGdvb/9hDw0ru6yMm9nQSNTQjIDPI+s/Z7IjMzgFVOVc3eeeJAvrqRsSg33?=
 =?us-ascii?Q?FX+J/pnSf33uFTLU+LaX5+D8ZyvfsoxntWQivBVN2zLRINPC/y+C8U+Ajwcn?=
 =?us-ascii?Q?u/3r4D8wUkuw1zmJpildHNBVMcWgsRzebLS9iNO58bUE6gRL6iFvp0o2YQrC?=
 =?us-ascii?Q?u6G1SI61mrKhBHjAqe2C63flTUIoRsoxnO4xwzBZBpRG2DaL07fIkKeqGrmD?=
 =?us-ascii?Q?O9lylpeUrZZb+j2Nvi6bLopLgcdwa+SlgHgeeVoihdTVLdTGBh0xScB0SE77?=
 =?us-ascii?Q?EfU48aFIPbcma8ryOb2jFEEWgTTN4zX09DDIL/I4DCYlfXahG8H+/UR3U+VY?=
 =?us-ascii?Q?VEAVRE//dd/SEk74xBDMEUBZkNrBYqY1twriyTZ2mGxJ2/tLRr6IK0X1Qmhs?=
 =?us-ascii?Q?M2MFyWtuWTAvhYUrCNzgAYZR4qUHnBY6D02BCeLiyPpxdGhHTPs8OUzhB8I/?=
 =?us-ascii?Q?lEC7SUQk/s9F1eJmgURpLy+HgLb66WO9zGcavKMH1fD5gDsf1YdYVBCq4wx0?=
 =?us-ascii?Q?LET9eAotRLhHRHO3wcbnvWFSLy/8b1UZZ0Il2DQ/Am6wrodPD0BF4TRGSMsS?=
 =?us-ascii?Q?YOJarnYpJ/KVVEw5wsuXowf8D2scMTXwGMZzp0fa6db9eryxVkoxkpWFAmj9?=
 =?us-ascii?Q?oOYcb0FuvEoWEXmQ/5uMPZkvr3l2wImGpMPCy0QcqAMS2bN0SpXi8PuSHWFC?=
 =?us-ascii?Q?7PCahf39W6udw14OhQU4k0kYTbgYmW6xUiSe+0N/tesNGZWOy0s9TzMJaYO5?=
 =?us-ascii?Q?fCTov/ilZ/Qsv4XAUP0JpleeuVk1Juk+e957e4Y+tb0U8JStKq3QQ8x0Q9vF?=
 =?us-ascii?Q?lHEPWyZUbhS6s02KgMT5CuzArPI1EUD6zCESd6QGFwDzeEsdoq7MzLAKsoj/?=
 =?us-ascii?Q?STmTqWhwpsT1663XAt0MvRm90QplB1zr2c2/zTYM/QQppelO0Ale28u5uHqk?=
 =?us-ascii?Q?CBuWH7MyGxJZkvzCAFxFTC/v2r5zdY1oX7rq7CagIIC3s6g00vV4C0SJfbXK?=
 =?us-ascii?Q?m1OfItX8qvIwkBVoGUDclBpOyLfLrb6euw4TmF/pVbxIsWyDcx7L9j8dlTOk?=
 =?us-ascii?Q?WfTmIqFnlbHg1dth15mdAbZLhe0/zPqaxgoeGqJrOEJypdtQVw/2rby5EQMV?=
 =?us-ascii?Q?cJEsOKCyFU7rJZvxeVyjj+eKAvf+Ncq6J4QDFxlAmMT8yO5oPe5hLZpYZVYP?=
 =?us-ascii?Q?Dh0DZ3XJEBRJHpmhLCovMxfSQv2XiyGBPdKGVaWowCeDmI1KMeDMbbl4mASK?=
 =?us-ascii?Q?Tg/aj6d+oY24zqH4r663N5ViJN4PSP0XxcTk/kJk823Y/oD4zt59GurN+jnO?=
 =?us-ascii?Q?fTBthd7+XrawecAdN+PyqAfcmmbSeyQtdZ0KcvHUOMxkqa+M08Qjt9w0eeB4?=
 =?us-ascii?Q?QTPMeVvS1NIiYa989aDosVplCq1ErjKwDvhRmKfsMFouhzRPEpPbAwloWqc8?=
 =?us-ascii?Q?Qs4+mXXv8oBb6vOkGQ67DfFYifRYYojb2MU8rEXt/CNLtvvSbklpaJZJcKS9?=
 =?us-ascii?Q?gw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6YQo3y1aePEywsqUaNZ0rsmbVVfDFvTWrMTw8JAbW0aqPWTJIPyvrnP6T2mNM5o+/gA3xqVGdcEEr8ha7MyUnL8g9AGA56YS0Z97Dvrhx4Hd24ZTwSW0AsG4b9iWT6B9vG+fd5Xhlhz5qnWkHFqfNSCEI5E01SBglUqzSLbCQKDQvykm5DA3CaYiirTJLtd0fxgvcDHnL7Pji4gQfJvlt2XjMfAnjhwOP2CVH/Wm8+iMVbkfUBVd//2ycfM4ulhXolF8pOA3QmpaEVH5JgCBdZCJuDDemfldqC8MqhxnuHyeH0y/5ohzOIKtoV5vFWwu2iFvPYMsnxEJzLpXQy8pOpjl5k1IrR1wH842OTrGoyC8xLL1I8Rd/a2kYCx1e3Eq/qVcgjAT9Gm1ZrS7U+B/8cMitFqhDe8jqj3sZz6p3+9Ss3771529S6a8kT866gJBacstU/+rhCNO9Sa+N6QjgJp+LJX0fG++6OUqd74Ii12SZ520qLLeMAfCxuW2OXQhXbw6KJRPbCu266SvUxh2JRZ/LHbV/WX/nzgexdI4CUfv7KzknHbRyunvMMr0SValeIAwAP4QhUrqhClGpKt3Z2IDRtDT6bermUnCLyamwao=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c788b11d-3aed-4384-7351-08ddd42e70b2
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 14:43:28.1389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W/RkljKEFfxY1LT6DQ+JGAxp/KBZR89ncKfFpf/tLG1XKuqhz1KzM1ZeNLIfzWJkGuS92J+JBQtp9oSsMhiYq9dw6fRAdEriIUfwQURLoeg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8280
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_04,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 spamscore=0 phishscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2508050107
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDEwNyBTYWx0ZWRfX1E/V3NiJ23R1
 XwQFxc8r1o0MmKGkCs17nVa8EWUotXZUooBMFMmu0Z2UIbhYDvehfwWy5guEkwBgo+RRkUm0O1b
 xA5RnPjN09wQ4lFCEqzzczyOnLxpYiACH5KSsy5AEHuvL4R7NfP/fVwonPya4P8kjrvsl0wJttP
 2XX0ng3bAVJbUTPwjgi7+vDtoaZlYuZPGowWQX76crrH2QaTNagbY4mn4hEL1OALYAMIIH1LlkT
 ikop5iW1uw2w1PWC4H31ekqgtIeiotihT7MhA+SkMwd4BmXOyIZqO59ymBs3uRqpXqODgSLhoPH
 42fklPTaFh5L106fWsS+XyFQVzZ+u8wfqWc9vPxJawapCjJQF57LbpnGspof2Epg5C3c9vgJGr9
 BEAxwgIMdmDPYGydeXRZA3jmFvSrVkgfLR0ahsiratCvZjOVhGCjoguIwgGZGeuCejhBVlop
X-Authority-Analysis: v=2.4 cv=SIhCVPvH c=1 sm=1 tr=0 ts=68921895 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=20KFwNOVAAAA:8 a=pGLkceISAAAA:8
 a=yPCof4ZbAAAA:8 a=qLGAI_n--WmRx6p9FSUA:9 a=CjuIK1q_8ugA:10 cc=ntf
 awl=host:12066
X-Proofpoint-GUID: tiHEXxQaJHA8Qz0tblVrfiHRuAmeo3TP
X-Proofpoint-ORIG-GUID: tiHEXxQaJHA8Qz0tblVrfiHRuAmeo3TP

On Mon, Aug 04, 2025 at 04:40:46PM +0100, Usama Arif wrote:
> From: David Hildenbrand <david@redhat.com>
>
> Let's allow for making MADV_COLLAPSE succeed on areas that neither have
> VM_HUGEPAGE nor VM_NOHUGEPAGE when we have THP disabled
> unless explicitly advised (PR_THP_DISABLE_EXCEPT_ADVISED).
>
> MADV_COLLAPSE is a clear advice that we want to collapse.
>
> Note that we still respect the VM_NOHUGEPAGE flag, just like
> MADV_COLLAPSE always does. So consequently, MADV_COLLAPSE is now only
> refused on VM_NOHUGEPAGE with PR_THP_DISABLE_EXCEPT_ADVISED,
> including for shmem.

Hm feels like 'including for shmem' is a bit brief here :)

But fine probably ok.

>
> Co-developed-by: Usama Arif <usamaarif642@gmail.com>
> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

LGTM, so:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  include/linux/huge_mm.h    | 8 +++++++-
>  include/uapi/linux/prctl.h | 2 +-
>  mm/huge_memory.c           | 5 +++--
>  mm/memory.c                | 6 ++++--
>  mm/shmem.c                 | 2 +-
>  5 files changed, 16 insertions(+), 7 deletions(-)
>
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index bd4f9e6327e0..1fd06ecbde72 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -329,7 +329,7 @@ struct thpsize {
>   * through madvise or prctl.
>   */
>  static inline bool vma_thp_disabled(struct vm_area_struct *vma,
> -		vm_flags_t vm_flags)
> +		vm_flags_t vm_flags, bool forced_collapse)
>  {
>  	/* Are THPs disabled for this VMA? */
>  	if (vm_flags & VM_NOHUGEPAGE)
> @@ -343,6 +343,12 @@ static inline bool vma_thp_disabled(struct vm_area_struct *vma,
>  	 */
>  	if (vm_flags & VM_HUGEPAGE)
>  		return false;
> +	/*
> +	 * Forcing a collapse (e.g., madv_collapse), is a clear advice to
> +	 * use THPs.
> +	 */
> +	if (forced_collapse)
> +		return false;
>  	return test_bit(MMF_DISABLE_THP_EXCEPT_ADVISED, &vma->vm_mm->flags);
>  }
>
> diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
> index 9c1d6e49b8a9..cdda963a039a 100644
> --- a/include/uapi/linux/prctl.h
> +++ b/include/uapi/linux/prctl.h
> @@ -185,7 +185,7 @@ struct prctl_mm_map {
>  #define PR_SET_THP_DISABLE	41
>  /*
>   * Don't disable THPs when explicitly advised (e.g., MADV_HUGEPAGE /
> - * VM_HUGEPAGE).
> + * VM_HUGEPAGE, MADV_COLLAPSE).
>   */
>  # define PR_THP_DISABLE_EXCEPT_ADVISED	(1 << 1)
>  #define PR_GET_THP_DISABLE	42
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 85252b468f80..ef5ccb0ec5d5 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -104,7 +104,8 @@ unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
>  {
>  	const bool smaps = type == TVA_SMAPS;
>  	const bool in_pf = type == TVA_PAGEFAULT;
> -	const bool enforce_sysfs = type != TVA_FORCED_COLLAPSE;
> +	const bool forced_collapse = type == TVA_FORCED_COLLAPSE;
> +	const bool enforce_sysfs = !forced_collapse;

I guess as discussed we'll return to this.

>  	unsigned long supported_orders;
>
>  	/* Check the intersection of requested and supported orders. */
> @@ -122,7 +123,7 @@ unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
>  	if (!vma->vm_mm)		/* vdso */
>  		return 0;
>
> -	if (thp_disabled_by_hw() || vma_thp_disabled(vma, vm_flags))
> +	if (thp_disabled_by_hw() || vma_thp_disabled(vma, vm_flags, forced_collapse))
>  		return 0;
>
>  	/* khugepaged doesn't collapse DAX vma, but page fault is fine. */
> diff --git a/mm/memory.c b/mm/memory.c
> index be761753f240..bd04212d6f79 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -5186,9 +5186,11 @@ vm_fault_t do_set_pmd(struct vm_fault *vmf, struct folio *folio, struct page *pa
>  	 * It is too late to allocate a small folio, we already have a large
>  	 * folio in the pagecache: especially s390 KVM cannot tolerate any
>  	 * PMD mappings, but PTE-mapped THP are fine. So let's simply refuse any
> -	 * PMD mappings if THPs are disabled.
> +	 * PMD mappings if THPs are disabled. As we already have a THP ...
> +	 * behave as if we are forcing a collapse.
>  	 */
> -	if (thp_disabled_by_hw() || vma_thp_disabled(vma, vma->vm_flags))
> +	if (thp_disabled_by_hw() || vma_thp_disabled(vma, vma->vm_flags,
> +						     /* forced_collapse=*/ true))
>  		return ret;
>
>  	if (!thp_vma_suitable_order(vma, haddr, PMD_ORDER))
> diff --git a/mm/shmem.c b/mm/shmem.c
> index e6cdfda08aed..30609197a266 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1816,7 +1816,7 @@ unsigned long shmem_allowable_huge_orders(struct inode *inode,
>  	vm_flags_t vm_flags = vma ? vma->vm_flags : 0;
>  	unsigned int global_orders;
>
> -	if (thp_disabled_by_hw() || (vma && vma_thp_disabled(vma, vm_flags)))
> +	if (thp_disabled_by_hw() || (vma && vma_thp_disabled(vma, vm_flags, shmem_huge_force)))
>  		return 0;
>
>  	global_orders = shmem_huge_global_enabled(inode, index, write_end,
> --
> 2.47.3
>

