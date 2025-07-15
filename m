Return-Path: <linux-fsdevel+bounces-54995-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 20806B06320
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 17:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 041037B0A40
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 15:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B257277CA8;
	Tue, 15 Jul 2025 15:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qBmzyP1F";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WPxZhIfQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20897273D89;
	Tue, 15 Jul 2025 15:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752593771; cv=fail; b=qI3lo80RRb0xZIqSaJ6QQuxlRMQfhRDbDbZF+9+xBnQKIkRmvQudO6PhMhTXUdmAcLMq6faKQQDgttGubR+9qzLfcsmFQyXCKnY7LrUwCsTYk046C+CUfSqgrl5fRCd1WGXQZxIdPrncyoDuZgKhw558UzPS+Aatk7rfw8Gnrzw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752593771; c=relaxed/simple;
	bh=jtq5tiA7KsnuJtYjEZ9TvNfdAJA7RyTbUrdDsbmNQ0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ELHwrbRazI3Fv4y8FBEL3cTiAADeBeJI5+7lgHlIXL9qMFYLglk2n633njwa/DhOSlXm1QmIT9Uk+2FAMbU6pMo3o2R5ScmLkflD38drU/FgkUxc1scuulgjjyXews5+zsw/VLDTSqjAjGi5aiWI3mPPthyf4f/IbirFMfudulo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=qBmzyP1F; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WPxZhIfQ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56FDZEKp031230;
	Tue, 15 Jul 2025 15:34:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=6+ar0zIV3OVz88UGLD
	yak3LFEo1hgDr3CSaZttd2dCk=; b=qBmzyP1FGUxqn4SnKh4D+ZJ966DAIvW9Tf
	WK7ucJkw3A+G2J4AC9BuapP1lO54yOdOD9OyfrDYc6Pn4hNxyvnOjmffJ2DJkYMS
	dzCynFyhUJlxs9r9E8TEOExqVivEzonNEcswQrLwT2+T2zbH9f7bRn+1jGDKdFLv
	5TSQwkN9wJS51FUixOgfKqAmTRZ6STuHcTVmMm9AV62KbUo6yC/2EEjOCgdQEoTR
	oS98BBtr658vlO9MeuAxmF0Eor6gXvTOyECST89KNYNEaGrX9Lg9pG+Luidn/t/K
	gr3AGX0XOeqDBoINxu0XCRzk+zGkyWtgYxWjJTM5DL6mg8wojefQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uk8fy0em-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Jul 2025 15:34:53 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56FFMAck030351;
	Tue, 15 Jul 2025 15:34:52 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5a46th-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Jul 2025 15:34:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cRz6NRV5tndKU7EIVuQsnRELfROoUCTn9Dg0uoB6rNRQon1ipHvuigi8uVHIqd0nekiQb6L+iiJI1yQ2H1lHanshFvAY4qqBE0kgt1+TkacJL5p3EhG6gpKZ/48IgT9vDYbdvLmyEfbWE+XvUNnjM2j1UzZqrAO++EUiXP7OHMq3PLti2y4SzdF1LRYOnKDbSj0gRlcl8B4XZAQlVV6s9sklBeuMvOaSfIY1UqekJtn4wk/a2QY12FCvtSYDBvQp69YVvGIpLBgtPiYBhdpXsM8lbPNTwf7e3Tajdr/yKIy1vVfJGpxOm0kTvYKbvtW/qCCOo0DfyIe32UN4y/FzBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6+ar0zIV3OVz88UGLDyak3LFEo1hgDr3CSaZttd2dCk=;
 b=vipz4OGEdgfhptEKxyK8wz/1wCucb6/++COrsJtsyhHZnrkj9MowKFttGJv72UbTLYSL3HSCLP881MlrdVod6LB1fyQCLk6YlYSUpthq3DoNTQ+zWAj1U0t4/zCUpoeyxP0+p3+AW6O01GPwCx4tNLIWg3dGpTDdQuJSF2UBcTXLpp511lzrNXbyQNE3jf2wpyx4qR+bXb3kWOcStHUaGAst2HaSzk/Bz1pLSRaoG6Ojf/ZLlfbz4adgRPy02fDMnbjcBh5hwJhzwyecM0wWaZ8ieSYtwyWeDhSLB9fBJhv4L3b/sR3PEeRchpEx2ZQ4mD4FdXF5qHN9IUrhZR1otg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6+ar0zIV3OVz88UGLDyak3LFEo1hgDr3CSaZttd2dCk=;
 b=WPxZhIfQxJ7AZwzRv/78/YHeKmfI2BfJpiW19ENaesJq7Rq9MPdy/e/N2q1U0zZJSDFaltPqASu5LXMUoBZSIXBoAnxeIBsjHQFxyW6Tr0oyM8fBom3lBum0S5X01WpQLrJTQFZtBOSbs/rJDY73EcgGDmLUF2SaePLqap4NGlU=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by BLAPR10MB4994.namprd10.prod.outlook.com (2603:10b6:208:30d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Tue, 15 Jul
 2025 15:34:48 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8922.023; Tue, 15 Jul 2025
 15:34:48 +0000
Date: Tue, 15 Jul 2025 16:34:45 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: Suren Baghdasaryan <surenb@google.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Vlastimil Babka <vbabka@suse.cz>,
        Zi Yan <ziy@nvidia.com>, Mike Rapoport <rppt@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, Nico Pache <npache@redhat.com>,
        Dev Jain <dev.jain@arm.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        willy@infradead.org, linux-mm@kvack.org, x86@kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Darrick J . Wong" <djwong@kernel.org>, mcgrof@kernel.org,
        gost.dev@samsung.com, hch@lst.de, Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH v2 0/5] add static PMD zero page support
Message-ID: <cb177185-ba7e-4084-a832-7f525f5cc6eb@lucifer.local>
References: <20250707142319.319642-1-kernel@pankajraghav.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250707142319.319642-1-kernel@pankajraghav.com>
X-ClientProxiedBy: LO4P123CA0285.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:195::20) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|BLAPR10MB4994:EE_
X-MS-Office365-Filtering-Correlation-Id: e10b2898-b5e6-42ca-653b-08ddc3b52239
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aGRV4uwYAWJN4GtQ/6T0SjSMJIFAjBLhtZ5HtkQhyqggilIh2rh2LCN9ursJ?=
 =?us-ascii?Q?7c4Rnqm3L6euQuF3lxlh1nIa7+aVgsjVJ7V4sEvJJNAOw9bQoXYNfR31gj++?=
 =?us-ascii?Q?t+vLt6wqKstCIIdspsHNeCxoMyUgK1V/W1p5WBfjmtfUUhyA0xN7iC7phje2?=
 =?us-ascii?Q?A7nUSbZbm+ueHw/QgjumfeRfK5jidbPY4cPLjyORiLlPt5Sr2URegwKJhWrO?=
 =?us-ascii?Q?6imnGNBH9SHS2tA8zTW8UTKZ6BkQe25iqhr6cQqQCMHpCxJZt943Vxfmh8ql?=
 =?us-ascii?Q?7ZjMdE2yIzHNu69wog3o4TUQIYA59O/Jeosj/v7cO7J7fjtGMzHcxph7eJOP?=
 =?us-ascii?Q?LCwFBOyCvdeI+9tbi77HKJQPW6m2uqTvU5tsjMZ22sYxqgmkS0WK4qWuRUyv?=
 =?us-ascii?Q?kQg2XJQlZynN0n4V1rqcSAv8G410TyAUHYZNOWYhVevbrYa4IbrREX2l3k5/?=
 =?us-ascii?Q?9gnjrb/Gh67IwRGSPhSgLnq2cKm+f4meeBKXpKYL8TN34ZAcW0uOTXGBsjrH?=
 =?us-ascii?Q?q7tn88uoaH8ixGxSVk8dvY56SCx3dZCtOW8JONP9evgBptZQvF4blmxdeup9?=
 =?us-ascii?Q?gNm0zHoW905pvEdwl1lDQjPqVW282mk6E1xBS4y3z048uc2bgXLC3EVD8hRM?=
 =?us-ascii?Q?FuEcDtcoPdWCA6M93UOVoBNNrkfhXdLv/aOLkT9QFzxr0ZEBCh9sWh+me1Ob?=
 =?us-ascii?Q?helFsQEQJYjID03o8jjTXmu9KmttbexDHdV9bZcpdRhizeEcyJYm5z9BF4rz?=
 =?us-ascii?Q?MxcKZIwmkbrRV8dSI/YHacwfO6YchytupA42oz+ZmDDKBeWfIk6lK3JwfJRI?=
 =?us-ascii?Q?h50UM2aEwF27HqOm8eLLjuMHG6xc/e+OUmZtKFH6qgwIIJyilyxRwjMC3mK3?=
 =?us-ascii?Q?XZDoYo38L1yRLVa4GE117DmDDZyoxaIlJPdnPPzqVfr3YQdqZoAYMavx4Ni7?=
 =?us-ascii?Q?wvm7SXRPRK272MTmYjz1YreMyrsTEuQ1JseFM9QFiVr3N7sluW1MqPEc5YRV?=
 =?us-ascii?Q?qnvLBgyvXLY85Hp6HMNS+waiER7DeFd4NQ4yNmzFq12mIlzDLS/KBWytvFV7?=
 =?us-ascii?Q?tSKhZ0bjMzi7DeNtGYQypUHWezGs4wILVKRb/qujirwadeGTt5Oy7/fw7zaF?=
 =?us-ascii?Q?2Rhw3xQIkG7PU4AwbRv34pNl81fghX52hsTCRB6vsWaBFo6/kr1+BJERtukz?=
 =?us-ascii?Q?hmk9zdD/3JuYqnjDs1u3m7LLALVY1D4MxLDUJyoJNyeCJmCLCcTvN1EFZ/3U?=
 =?us-ascii?Q?OTzP1ZXunq0n5xXjD19kxEztO8gWpvFV9Pbt0nfX5WvJ2avoWF+Yh46fq9Dd?=
 =?us-ascii?Q?qLp5oVsPKRNwUh980enVIv5GtVSdGU6em59gU3meNjeBUuWXuZPbuoJv8wdC?=
 =?us-ascii?Q?JX/jVcFH7B1W60JzsKa77ee1lzu6/Lq/Uaq+/Kg6UblRsw2JsoRY9qwdKuLu?=
 =?us-ascii?Q?LTbDDQ5yJ04=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Y/6N4ujf9EmCNGB47EM3mIueamYrJLyPYkcTt5E55hELgMGtWmw56nETPazS?=
 =?us-ascii?Q?gIhVQ5dgpoYtsxBwbPU/MaSJKvNclUfB3PtoSr1kmgffQQ2OTfuHwbJoDCOo?=
 =?us-ascii?Q?/kApMSbbzMSzFeje2MhjdRubhe1jNRLHTp9hfYEv3Z8p4++xtuuVZtICbFey?=
 =?us-ascii?Q?6fSazyWKbx7J/1lO3UMOYckLXv29BJZeNpRkJM+32DZW9UPfdvvNVTAB31id?=
 =?us-ascii?Q?57pTgYODuqPRODXzLiOS4RTQKJnrHM3enHpWbMWGhnAhj0whHIqJb2WoAEo9?=
 =?us-ascii?Q?iZBezR5LRROtWibHX75HqvQtswu4wFvOOmZOykq9yTrAAThPJLm5y7qZSO3N?=
 =?us-ascii?Q?mWIItnB3Ri2IWxqD1zyZ+0bMSsuiEmLkRbtqMHRiEPEhechjCK3h4XKqkugU?=
 =?us-ascii?Q?7Tw04P3ieUn20jAEWf2tzW+CdtojXEHF+af6E3r82A1rGLimCI9i7oUvX6iW?=
 =?us-ascii?Q?1GdnLx59ymuk2dviq7FIrdcsJNGUmUrOt21u02dI6qeUj9mkz004nzarEwYI?=
 =?us-ascii?Q?nv/DPrD96sSZfz3VrEe7upjqiJfB6NL7YgtAUc8+o9L0tZgVQ8e+67Swk2+R?=
 =?us-ascii?Q?ZK+DzL3JPWU1T7CJYyhVABjSUx1ITLNmiWqUBvLOfmqBoGiu33G4LKX6AD8J?=
 =?us-ascii?Q?bEkkNaG1cAu1VEqyw3ZLDrjFKVaBZ04RNv5ZV0gfeA6WgexfyPjbz2xhsmny?=
 =?us-ascii?Q?XnQtROvXquVIYr71pXApQ9bvYnlGkEzKORIxUJgUDQk0kjyBFlg9Wy13lZsc?=
 =?us-ascii?Q?gFk0gT3IlypxElPMELrZqZZRdQN3diyqyvwjTPZrEQtTHgx2C0FUdY8WSiAl?=
 =?us-ascii?Q?kqDPzivVFBdDLrLDE2rovZFU46+R+J1mAvWIJQCm7shtHOhYL1vnhi5/Ua0n?=
 =?us-ascii?Q?j2kRBVt85X8/N9ltFyrdjTQLucAT2ueyfsgcXPenan38dqoWSfQlRPt0sy/h?=
 =?us-ascii?Q?5tJVzH3QpouNSRsOveXLA+PLPYsZ19t+Hj2kDQGfQh9yXlHdEp+Wlq0ZfC0f?=
 =?us-ascii?Q?F1i/YGqYY+xBAaFUcIoOds4EnJI+mdCl6nyXa6tx9u0tLCBKjAgBgHbs4Nxz?=
 =?us-ascii?Q?wLzqEC5AipymvShO12HGaQwDwjx2EKqhrfwlLVsLmBT1cXs/SV2cdJ0k+YKD?=
 =?us-ascii?Q?y/voiMXGSadmraIlsX1RlbKduLafAvpL4wkUmucHfAkWwfqMmtOSnXTRRkTN?=
 =?us-ascii?Q?wf7IvhZA2gBUmoy99SU0DHO+Zq4yrO8U9tlNN+war50FZcUj4kzY/+50BO4E?=
 =?us-ascii?Q?xaDsnLxxwZFps+tj27GZRqXS8JIRY5Q0O0wkIuf2UVZIpMLs6iVew/v8cmpI?=
 =?us-ascii?Q?Glg5Uhxq7/CY3NeylO4VZLS2xid1grCSeUqvVtQQOw1giRrdeD7FQu7qu7Nj?=
 =?us-ascii?Q?OU+BJscDVTCUHcOQRC7+uIY8m2UL3l4/Cvf5zwA2B1zvMzYr0oFQ1WvJu954?=
 =?us-ascii?Q?e+QN5LzCywpIV3VgEJl0AwS7fCFYGVvrUWa/iX+VAEYOqRmyLrJ9aPiT7e99?=
 =?us-ascii?Q?AKN6h2z9Eexq9vRfW4HTSMGMMBQilamEuZKAuWo+wH7QyV604ChP8MEqjGpy?=
 =?us-ascii?Q?PreK/sYZ8SduDqDNnVBpS6eCAdYdBNP5B+3PpTTxdDYAXGSS9FGIPy004Lvu?=
 =?us-ascii?Q?MQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2u12/aNhGh1amJ7OfKguWtjRppH6ysxg1dfz7LsPqhWMo5zc4chlniQuDOJJdkxks688j/sseDmwjw//8VfxWCovMJIuFnO5LXv/KX8m6GvVTUlWzy4AepG8N/aizq2Octr/OUvmKMlNXGsIdj+DmyVN7smmG0SACyC3gWKjLrVWMn3cbTnuJHJiCKB+bHQh8NDgQpMRcARiMttUMtLPicsCgp8i2in8pmIuP8eNLDjzTQ6VC0YwtcoZSfr043n5BQ7sjSKytSeJCDDABjYCUK2iNaRa8cT1n8wyeeivA+KqV0PbYqysqrv/VPr0vTcMgjSY/y1InIr22kADV3gCrfyoTuyEWxmzksZvdLKzP09h08at1jPbi1Pvt6r06LyLe6TSanNY5gn4zjhKxSA87KiVKj4+mXFaCYDJeZnTOFnFBQFIs7BvgQlt/iex2yuoRr7+XqYnyfTUt4ju9Vsjsv2z5Kbijo48aj2Bb+MyAb9P9u16Nx84e08UVYMeIAYsuKq0eAQWSWfQRj1j8UWomRhtIPmMFqovkJdraQqpww7gRvsTj9zn8+2JL8V4aG3SEm8ScLKYdPS1SVGRT1ApnIQm35kWYekZJt61bi8fSQ4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e10b2898-b5e6-42ca-653b-08ddc3b52239
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 15:34:48.7892
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oenxJxMvfjSmqWh26Yh2iDdu3Ed18Xl4KmFkAdeM6QURYMK4X1+njVHtgctJJQ1nb69MI++OAIZ4DqLFEHZsKBLDm0F9ZZjNPOJjxknb+SA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4994
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-15_04,2025-07-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507150143
X-Proofpoint-ORIG-GUID: VX-ALFkqOGuNzNVlI__crq07QkN9GZQO
X-Authority-Analysis: v=2.4 cv=Of+YDgTY c=1 sm=1 tr=0 ts=6876751d cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8 a=hD80L64hAAAA:8 a=Ur4JrWoBUPCs-x69RyEA:9 a=CjuIK1q_8ugA:10 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-GUID: VX-ALFkqOGuNzNVlI__crq07QkN9GZQO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDE0MyBTYWx0ZWRfX7L+UKgRfRop0 TKeH5NNlYW3gcmAIjKXPZNMR29nqSDHwo3PDYo+Vw7DHrPoGo9dPm91FbBPzdWTJ8vR6SDMOHJ9 l0OH6Ew/qiDHWzB262+E/FhkPh9rx5w+SgWmy/Sq4f6mXXLScEw6jIhgQ3ZgfMQaiOk5yeflAlO
 i1jmOvD/AxkdIovH5HVdeMLVR3YGfJIiZ3Hgy1q3NKle6XLQ8aR9aG+mbIyGP7qYUyBwEKrMzKr FDZwvy5kCFcKEu3NXB3lLCLj3hMOcJ0laSDKzAOydgL9hiz58S6vtnXrX2Riw9chdgXpGaKMuPk 8GU0lYTXR11KHIX9LPpQ8g2LS73altnSFqcKukwXH0GNe33rApGm0gJ8Dzm8FQSlc7ehqpRWvi4
 CEt7LiaX4vG5ELd4GCo7MSDHVFNzJEan/EhyTCQJ/YLQZe2hQJN84nQM9a31ubRj86KgAtUx

Pankaj,

There seems to be quite a lot to work on here, and it seems rather speculative,
so can we respin as an RFC please?

Thanks! :)

On Mon, Jul 07, 2025 at 04:23:14PM +0200, Pankaj Raghav (Samsung) wrote:
> From: Pankaj Raghav <p.raghav@samsung.com>
>
> There are many places in the kernel where we need to zeroout larger
> chunks but the maximum segment we can zeroout at a time by ZERO_PAGE
> is limited by PAGE_SIZE.
>
> This concern was raised during the review of adding Large Block Size support
> to XFS[1][2].
>
> This is especially annoying in block devices and filesystems where we
> attach multiple ZERO_PAGEs to the bio in different bvecs. With multipage
> bvec support in block layer, it is much more efficient to send out
> larger zero pages as a part of a single bvec.
>
> Some examples of places in the kernel where this could be useful:
> - blkdev_issue_zero_pages()
> - iomap_dio_zero()
> - vmalloc.c:zero_iter()
> - rxperf_process_call()
> - fscrypt_zeroout_range_inline_crypt()
> - bch2_checksum_update()
> ...
>
> We already have huge_zero_folio that is allocated on demand, and it will be
> deallocated by the shrinker if there are no users of it left.
>
> At moment, huge_zero_folio infrastructure refcount is tied to the process
> lifetime that created it. This might not work for bio layer as the completions
> can be async and the process that created the huge_zero_folio might no
> longer be alive.
>
> Add a config option STATIC_PMD_ZERO_PAGE that will always allocate
> the huge_zero_folio via memblock, and it will never be freed.
>
> I have converted blkdev_issue_zero_pages() as an example as a part of
> this series.
>
> I will send patches to individual subsystems using the huge_zero_folio
> once this gets upstreamed.
>
> Looking forward to some feedback.
>
> [1] https://lore.kernel.org/linux-xfs/20231027051847.GA7885@lst.de/
> [2] https://lore.kernel.org/linux-xfs/ZitIK5OnR7ZNY0IG@infradead.org/
>
> Changes since v1:
> - Move from .bss to allocating it through memblock(David)
>
> Changes since RFC:
> - Added the config option based on the feedback from David.
> - Encode more info in the header to avoid dead code (Dave hansen
>   feedback)
> - The static part of huge_zero_folio in memory.c and the dynamic part
>   stays in huge_memory.c
> - Split the patches to make it easy for review.
>
> Pankaj Raghav (5):
>   mm: move huge_zero_page declaration from huge_mm.h to mm.h
>   huge_memory: add huge_zero_page_shrinker_(init|exit) function
>   mm: add static PMD zero page
>   mm: add largest_zero_folio() routine
>   block: use largest_zero_folio in __blkdev_issue_zero_pages()
>
>  block/blk-lib.c         | 17 +++++----
>  include/linux/huge_mm.h | 31 ----------------
>  include/linux/mm.h      | 81 +++++++++++++++++++++++++++++++++++++++++
>  mm/Kconfig              |  9 +++++
>  mm/huge_memory.c        | 62 +++++++++++++++++++++++--------
>  mm/memory.c             | 25 +++++++++++++
>  mm/mm_init.c            |  1 +
>  7 files changed, 173 insertions(+), 53 deletions(-)
>
>
> base-commit: d7b8f8e20813f0179d8ef519541a3527e7661d3a
> --
> 2.49.0
>

