Return-Path: <linux-fsdevel+bounces-56412-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52BA9B171E7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 15:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BE6D1AA582F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 13:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B762C1597;
	Thu, 31 Jul 2025 13:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GyRezrCL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CwR15ER0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4DAD235056;
	Thu, 31 Jul 2025 13:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753968011; cv=fail; b=Qw5TcsCzhVmYdcD/oSnRXoER5+9JTd5Y7NBH7h0GD3+w/+2DP2MGz9Gt38EsEVu3gEWhmds1LMqPOJrhmStRd6J8fRHE+FsBh84Re37GI0VtXCOYlsfj/Ogc4N+WZlg4MR3KlZv8iPypl6NfEm0deJhvOvGaXY2lUstfkciviBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753968011; c=relaxed/simple;
	bh=1nBxsFsN6FCBs/B9nOuehH5wuNqDHWqFE8vPYWmY7Mk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QbfpA4ntbkNu3JOTiG+asD5D18DfVeIDeYZohJNQmT9V+c8nC+dlMswd2lP9e59ZdrZTvjHBrr4w2MXNWoKwIuTpK4c8cpTN7fqrX+Ar4fBQ9X7VVbNyew03c0qm336wYeAYV5xBTTdF+Vrv6q2dykVu+rMukiizukZIv+ZQ4xQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GyRezrCL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CwR15ER0; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56VAskbc021994;
	Thu, 31 Jul 2025 13:19:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=1nBxsFsN6FCBs/B9nO
	uehH5wuNqDHWqFE8vPYWmY7Mk=; b=GyRezrCL2o52xzzn6TJDU4kcdvT57w/zDn
	XSe9GxZSWPgG7UNAQ7yD8goUStt8ZxSYqQasciaH2CBiyo9cZf+NUm7/IhtlC8RY
	Ajn3w0VyYON/d8PIGmmKd+fpathWhoclR2YXRSAlcyM5/frVUhr97yW3GC2AkhC2
	wX8aGqBSEEdruPBtJ+o4hL52FLs5Qynj42EfPNCGBgfW7SVKsWuXLv49v2+GXvaC
	q7r1gkrNNOB8m2PFnhwvJJwjHRinTr/1DrfmydzkP0RAkB17ak7YEECJrHRM5JM2
	2Nq1ZE59xzEkk5eDPhPSbDZ/yrT2i4KjGLsIj8gCAjQSh25BxHyA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 484q4ec7nu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 31 Jul 2025 13:19:08 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56VBf86q016740;
	Thu, 31 Jul 2025 13:19:06 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 484nfjtber-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 31 Jul 2025 13:19:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DckqCcmYUnM5DGeQMnSKIsd+VNdNzOiQV3qS8GDJRqkQy6QuuORc9pk3o+pNf+vQ6oiM/K+VtP7iRJ62+NBf7QjuMgYBpZ8yOknnW3ePXUUvYwBPSA0oW+T7vNcuQQ8sjN4UDi6bBgkSl1Nd6xzcQGg7Q/4el07rg9p/Z3UgXBsSueaBXQEOIjXuH2VxQAmRVi2XvJ0PgndoWobLSQT4+9vdNutr76/AOfBEI+eDzHrws6fIngFwMWAo9X7SvRXcrCHxOGVOzBTWyDD3i1sgK4kJbzUTUXJuu/gG8KW5uai6JoBfK49HzgT3hDmrIBfdHA9YPi7vRM79ND5s9QtU9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1nBxsFsN6FCBs/B9nOuehH5wuNqDHWqFE8vPYWmY7Mk=;
 b=YLygBaa7y4otkg7BQ1LS4VRxqnmI9qbq+7mcPQgS9VVtHSs8HfU2OlQKLKr1qgeAy4cwibSWBYDguerFZP1m5wVcetq1L4L2Y5OBPlKlrZbTL9t9Hxs6sJEfIkTjfcARj3NH+DFTiJmTSvdwgZXrohc4Cv9pSybDaD8+HU4MoVOWX1AI35wqHa1vCuewtdqDFNf/WvDJlb9OSWsbpUyWuB4dkqrBUcTl9455P2nXm7prp60aEuquOfKE5fnneEMA3R41eV4xpMquYMJe2Pz5e+6Qomq3H2e6k0W0ZZQUceR6yyREOhoV/0Z34Io0XJjBYy59TuCBtWzBagCEu/RXYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1nBxsFsN6FCBs/B9nOuehH5wuNqDHWqFE8vPYWmY7Mk=;
 b=CwR15ER0F5IhNscnbPnMqlken+0xedwoXdWDz4XPioLNq90N1a8m1vqZab7OLWWfSgoGkAcj6hfJ18y0TNc/pUn/p2WH9wnVrvaQH1icy9FquPNpbQ62qqy0Hj5XVDrN+0zC9oYRgvssDPbfX6bCkS9GbVRkZN4D8udiF6RuZxI=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH8PR10MB6646.namprd10.prod.outlook.com (2603:10b6:510:222::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.27; Thu, 31 Jul
 2025 13:19:04 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8989.013; Thu, 31 Jul 2025
 13:19:04 +0000
Date: Thu, 31 Jul 2025 14:18:59 +0100
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
        kernel-team@meta.com, Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2 1/5] prctl: extend PR_SET_THP_DISABLE to optionally
 exclude VM_HUGEPAGE
Message-ID: <f1b0ee33-fa64-4802-a575-c843ec459b7b@lucifer.local>
References: <20250731122825.2102184-1-usamaarif642@gmail.com>
 <20250731122825.2102184-2-usamaarif642@gmail.com>
 <dda2e42f-7c20-4530-93f9-d3a73bb1368b@lucifer.local>
 <c9896875-fb86-4b6c-8091-27c8152ba6d0@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9896875-fb86-4b6c-8091-27c8152ba6d0@gmail.com>
X-ClientProxiedBy: AM9P192CA0028.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:21d::33) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH8PR10MB6646:EE_
X-MS-Office365-Filtering-Correlation-Id: ac53375c-0695-4258-a826-08ddd034d25b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GCaEhiGHE6N6T0BfuFKWzwV32mUbwNiFkgQuU0ENA6BoDK1YqXsfztAzcAX+?=
 =?us-ascii?Q?PadD9gRCX8EYmpYP6j/GWLCj2MEmwca+LJU80Z8n7cwIy+ZEqKQqm1qVPeYh?=
 =?us-ascii?Q?wFDV/QyB8/BvJE0ndQcu0mRcv03E2ZUq8zRT3BuZgIojeN2D7UZcCWi56d1x?=
 =?us-ascii?Q?GYueT5d/21DfCC5VuhFS+QWZcuooBg3sx9Qhkj5nITvBGWIHqwZ559dpgRRh?=
 =?us-ascii?Q?FqMSnpqz5XnMxWyF/anYffUMZimAni/0dUN+hmDEgtdr3o81A3lhAiBmfH7U?=
 =?us-ascii?Q?cON9npigmVQEvFMFXOpJ9heHsQ0XMGiiBWA630dUqya9sWimxVdDHQNKN9Pn?=
 =?us-ascii?Q?oe9bWnm9atET3Yij6Kx2Ecte6aDvw5lXlQV8ncqGjOcojfRjOuqVvcZ1owxT?=
 =?us-ascii?Q?ee4ghgefZElElnv83vlb+33KMTyQ4EMXUNJIrbJoCMeDIQSGEXfqN0HxoNzi?=
 =?us-ascii?Q?dXg2in5lpMndVwdXdqDgZ/2easuOGRTZ4Jq4E21TuSqPSbV7N6nmosBrExai?=
 =?us-ascii?Q?RpBfZJG344bQM6p7/izRLJMZ6hK+mbUhe3n8yk1ewSjlKt30rJC7NLBkFIhN?=
 =?us-ascii?Q?FOFj2cdD/IFKBOUXODTRhEp95YYvtlX0JPCsWKgBtYWa8wfkAc7fAKZAYAJu?=
 =?us-ascii?Q?noTFh/nWQYHOo1uXrnkELIEQtkFeD+iXySSs+3fFGRIjEJJiimLOitc/JpTY?=
 =?us-ascii?Q?HMc1eJUj8uwdCgvMl3RS+b1Jxsxxft8VhrnwROVTAv45plVSCNh1o0pPOA5I?=
 =?us-ascii?Q?3R1MBnzrXMd3Cb60kvPMWAriQ6sMOn4h1siOaqNAvAoozNT0fwa4/D7Gxwi2?=
 =?us-ascii?Q?kS2nljf2H60Bxzh7cz70A8CZGIB3OymH5KndLWKm/BikewL/p5SD32djrhU5?=
 =?us-ascii?Q?VXurTRdma4sw7LkfFkzzIvBHqWp8ui6CtZ7XeRVUKk0/IJlN5Z+lBANuGX2s?=
 =?us-ascii?Q?D5RhM7tLcjzSAzQ+k285dLne3g6VS0XSs06dSvItEGIIwEVEoIUV9XaEcD7O?=
 =?us-ascii?Q?GLfB03YRse1HtbUXLBKZMy7AUKUY3X7Vo6KygiHEE0H/pHtBRZauRWRZlfMT?=
 =?us-ascii?Q?3IdQjSwAS4R6hAmQeFuBhrRM0yZr8KHVzrV95efRr60QOb1WAk3WMZVtrr88?=
 =?us-ascii?Q?13gg/ikrf53yMc5AEqCV1oIuHl91etstA7OVK9WUcU51BjvIBg9FBEPwSWr+?=
 =?us-ascii?Q?9t7e73UQQksv5t/vk4eFSTiLP94vxHNNDlaA0Tu5n6KWM2wJHnOpV5m32qSK?=
 =?us-ascii?Q?0S2AhwvbuukwOFU1jEhpe/rDwBNySf3gAoTdpRTe8oykY+FcHP/QPTS8BfsW?=
 =?us-ascii?Q?LKDzxomHRvxeN5VBp8RZlgfJba8Q1vtlZBA5BNi6submP5JACE8LwI2c0Na1?=
 =?us-ascii?Q?voudlnQuhYBikmvwMvG5jNyQvyis5g5/Roy7ngpWAr6N9QNXG51eXjGWagkm?=
 =?us-ascii?Q?UvdIGrI3qyQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vRdnoxmypXG2HOyiAXm8e/W7wopwkCG9W28asfN+nnxG5oJZVnV5Iw3Y98k2?=
 =?us-ascii?Q?+dvV8QALQ96YhLHXfgrX7+uBGD36qobQqe9i9sytnL5skBYo0r6jnkmO2mcO?=
 =?us-ascii?Q?lyIDhgFefTp48nvv339AX4Vep7HiEa9WaBQlSyHbEyapnWQorOY10oi0CtNr?=
 =?us-ascii?Q?4HQALXaTKhlQmsTdrbTQ4hnDr9sA0gsgGq1UyNNZ3IEigeDieN6g8qN1z0f0?=
 =?us-ascii?Q?8DvBszOg5kJuploENJx5PjehTSwLOvw6YQnvV0GT1oMhpV0Du72Tebh4r+fI?=
 =?us-ascii?Q?6F0IS/26I5OScsQQm4H3d1BLSiOo2oNIDROcB4sDO2KxBA0oA/G1zm3Fr+x3?=
 =?us-ascii?Q?66ZB5df8fU0mZxYv15lb2Q5UXbVaVQfFnR44QgBtpQh96Cvw/L/mYnD1TEej?=
 =?us-ascii?Q?MWVHUoXZ9K0gP0bgfyLVEBg9CUqBWw0Uk2fIHHu1nH/4v82ahvR89FTSJ8Uj?=
 =?us-ascii?Q?lDHIq+T7uC4cAVgRpVtL4uxgBi5+JS6EO4wjFOLm67+wkUP1FQK6T/Ss11Jx?=
 =?us-ascii?Q?8/kf8l4yIi5KY7mCvO0/gmRpOFco5Bhl7hNx9/HodbfVmK39pB7+jFU9GMI1?=
 =?us-ascii?Q?AQ862wqm2JP5rHFQqzWKeqw4kPigtMscw2rLDAdQ78MQXg4BOp6wA1imEFPm?=
 =?us-ascii?Q?JlYHShZg5WHxtJ797uW5y4yOe2GBcSRHkHb8Q7NMZC3KEum6gV4mALnfJZxO?=
 =?us-ascii?Q?Kj9cFhfYnlOXUNvhwTQ5UoJi5d41gjgwKCl9Kw3ER1Zne+kSQjQ3zbr4i4Kl?=
 =?us-ascii?Q?qPDCQUZFrp9adLkzCuU0Xt62QQA/HRWZuPB+ny12GcrE7tnEoo/QsdXoa+26?=
 =?us-ascii?Q?wr7nL3U9Y56DYseyCK2svuKPdgL+G9dwd8n1AYoIY73EJ04mJqvigWpkFb/M?=
 =?us-ascii?Q?KPO1W4loWUAZGfBrIeaIKV3tp8cZvxS2nss2fnxMIoZSl9fxmg9WyztU9U+J?=
 =?us-ascii?Q?V4j1aNEd2K/L4shT/zNaxtj6U0EGug+QGdAU9hvgJXuPmUNh+PpJmAFM4Ryn?=
 =?us-ascii?Q?IXbyQKDFOm4e5TcoC9ITE6FTf8sUwDv8ibAd4tSIqUopv0SxRZfkmxYaLLGt?=
 =?us-ascii?Q?CKxafTKWR1Gmc3xSBMPVRCivvVsb7KZNkGKilOsHEzrQN5eHxMxNb3LunvXT?=
 =?us-ascii?Q?oW4kwRRet8NvmNjrdoT41WPHcvLWSICJNQhn/RS3BT1xNpEwD3JpTljZrJyP?=
 =?us-ascii?Q?IambstJSeAhLzBt2o0rvTPoJ7WnfB18AMsJkPWMcDXMbRsIstVT/rkWF/+74?=
 =?us-ascii?Q?B30IhTHNNaTMs/6ol3v5SVgKcuIhUTgf2Cjnmz11MdjsohzjjF/DS/s9TOiZ?=
 =?us-ascii?Q?dIfp6Wx0RRy5zARcoZfz1D+p5QZVCsxNW3jRzb50I72VCTmU37P+Y3xc95ki?=
 =?us-ascii?Q?i4RctNlL4l67dS7JAZxSFrS6JFWw1R6WLe3wbk2FNxX5BLq50jqQqDtwds+k?=
 =?us-ascii?Q?RRPRdDLh7tcalLwP0UgHMWG2JM64JMGrbA4EaluffNbBGlgFjqhPYqsWf4xc?=
 =?us-ascii?Q?/HoT+vsaX+4YWkd2dX4c4GVr6Na7DhPPETMLkF4zfaruWylrOIJrHqw/sfqY?=
 =?us-ascii?Q?k5U5JaKFizY20g657X/UHB05Te4/aPgAz9TwF0KnaMNEajf8aLdDI6Z6Drvn?=
 =?us-ascii?Q?rA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jXBUb9I0GomsJ5lGL7xBEZ77CgyW+GuVHpHVDt9tA1P8VP6aGiao+/KWqq+fJ1angIeTtyAkUjicSnGj+wqlqqAHepG0mnM7PZeKWmAHE9U0dByyK/096Mh/LT5fJuAE02eV9k0DgJeYSkxAYobjJKacL2CNGBx6WGJDzx1IRhRd3xNlh+WAq0lOewlCNt8BNwQLmB0xfZ+ebtSCoSvGhuhCWRGGkGEPwXvdErU3wqjcbFN372ilegkwekD/6uUNI/THV5xCl5GphNWVkoiR2GrpjkWwVMEP2egpbEjL4Bfeca6/EHdGS3oQDfOuio4Ha7dQ1/JHqsfoLkc0rILvUxSXA1qkF87wZ8ZMdf6hr3i86Kw1WrZ9n5RSaXsJjFqJhAQvCSVkRyuDC4rvagxJD0Nuw/f8X9Dg16E+jaR56T5Y64U8m/jkFRP6bNuuWyMEd+q+ZNwTxgmREFsoBQBQjpGqcgfpeNzBiDC8mIE/EWK3Bl9wvpw+edBsZKBMD0C0hVGB0wfFW01S+QTmmatwFtoLLDnLIAcU0rccoXMExplzEt9a2+/3x4mZHSFdjBpoVI3dbc/2uC0did2t/Zgn4BOfYI9pM+3o7E+77Bjs53Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac53375c-0695-4258-a826-08ddd034d25b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2025 13:19:04.3423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p5lgFJIp0PSaOrVZV3IYEpLD1RNk8fH9mG0zNaiFglrPjyT0AcDcKCE68c5oPyPK7l62lmTN3w7ClZuzXVrz5KOHJUpq3ZSV9fc4ttaK4GE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6646
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-31_02,2025-07-31_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxscore=0
 phishscore=0 suspectscore=0 mlxlogscore=841 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507310092
X-Proofpoint-ORIG-GUID: Vs2D5Woop29wf3ByAo8th1Htw1wB-gsN
X-Proofpoint-GUID: Vs2D5Woop29wf3ByAo8th1Htw1wB-gsN
X-Authority-Analysis: v=2.4 cv=QZtmvtbv c=1 sm=1 tr=0 ts=688b6d4c b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=pGLkceISAAAA:8 a=07d9gI8wAAAA:8
 a=Z4Rwk6OoAAAA:8 a=yPCof4ZbAAAA:8 a=Ikd4Dj_1AAAA:8 a=SRrdq9N9AAAA:8
 a=20KFwNOVAAAA:8 a=7CQSdrXTAAAA:8 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8
 a=iox4zFpeAAAA:8 a=JfrnYn6hAAAA:8 a=gmp_2V53UkDn_K6tnJEA:9 a=CjuIK1q_8ugA:10
 a=e2CUPOnPG4QKp8I52DXD:22 a=HkZW87K1Qel5hWWM3VKY:22 a=a-qgeE7W1pNrGK8U0ZQC:22
 a=WzC6qhA0u3u7Ye7llzcV:22 a=1CNFftbPRP8L7MoqJWF3:22 cc=ntf awl=host:12070
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMxMDA5MiBTYWx0ZWRfXxGd4oAVQjWua
 7AKLOG0edP+2wfjasDXU12+AbhpOwRgPF8ZIf0j5Kt9ydI4GY6CKlKSUxuCuRW85cQYgMReIzCZ
 NmAUGHWRLPcFiZhccCNpbWdX8OvgFF/gbgaWt3jn6wFlKjGElIzcztj38r0Tu2DnhQjCSqZWq/S
 Cpk8AIJP4UfMg87n592ho/G19upJwqgWslJ9x/04ndu/TmtQzISucNa7a6hnNieh/AY94Eq3DEf
 XNH2ojE8ZZgXn9K92avjS+WTcDkstY70/jIW6uZr7knzHDBeS/snNJ/0iYcbe0OesWgl2WfbNHu
 6/sjXza2t7lxoJuEQPH8tKeKPcsYg4ZnYjtNxPr+bd9EgdS4ba41W6jWMUrHU0bxRikiOPAAI/E
 XX6fhn/42atJe1JfXIianTNw9Qh7a6iYAI72luHMmtZUS6HBBv9VleFq4HlEBp3welj9Qoaj

On Thu, Jul 31, 2025 at 02:12:44PM +0100, Usama Arif wrote:
>
>
> On 31/07/2025 13:40, Lorenzo Stoakes wrote:
> > On Thu, Jul 31, 2025 at 01:27:18PM +0100, Usama Arif wrote:
> > [snip]
> >> Acked-by: Usama Arif <usamaarif642@gmail.com>
> >> Tested-by: Usama Arif <usamaarif642@gmail.com>
> >> Cc: Jonathan Corbet <corbet@lwn.net>
> >> Cc: Andrew Morton <akpm@linux-foundation.org>
> >> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> >> Cc: Zi Yan <ziy@nvidia.com>
> >> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> >> Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
> >> Cc: Nico Pache <npache@redhat.com>
> >> Cc: Ryan Roberts <ryan.roberts@arm.com>
> >> Cc: Dev Jain <dev.jain@arm.com>
> >> Cc: Barry Song <baohua@kernel.org>
> >> Cc: Vlastimil Babka <vbabka@suse.cz>
> >> Cc: Mike Rapoport <rppt@kernel.org>
> >> Cc: Suren Baghdasaryan <surenb@google.com>
> >> Cc: Michal Hocko <mhocko@suse.com>
> >> Cc: Usama Arif <usamaarif642@gmail.com>
> >> Cc: SeongJae Park <sj@kernel.org>
> >> Cc: Jann Horn <jannh@google.com>
> >> Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
> >> Cc: Yafang Shao <laoar.shao@gmail.com>
> >> Cc: Matthew Wilcox <willy@infradead.org>
> >
> > You don't need to include these Cc's, Andrew will add them for you.
> >
> >> Signed-off-by: David Hildenbrand <david@redhat.com>
> >> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> >
> > Shouldn't this also be signed off by you? 2/5 and 3/5 has S-o-b for both
> > David and yourself?
> >
> > This is inconsistent at the very least.
> >
>
> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
>
> The Ccs were added by David, and I didn't want to remove them.

Let's not add this noise on respins please, it makes review harder. No
other patch in the series, including ones by David, do it.

>
> >>
> >> ---
> >>
> >
> > Nothing below the --- will be included in the patch, so we can drop the
> > below, it's just noise that people can find easily if needed.
> >
> >> At first, I thought of "why not simply relax PR_SET_THP_DISABLE", but I
> >> think there might be real use cases where we want to disable any THPs --
> >> in particular also around debugging THP-related problems, and
> >> "never" not meaning ... "never" anymore ever since we add MADV_COLLAPSE.
> >> PR_SET_THP_DISABLE will also block MADV_COLLAPSE, which can be very
> >> helpful for debugging purposes. Of course, I thought of having a
> >> system-wide config option to modify PR_SET_THP_DISABLE behavior, but
> >> I just don't like the semantics.
> >
> > [snip]
> >
> >>
> >> Signed-off-by: David Hildenbrand <david@redhat.com>
> >
> > This S-o-b is weird, it's in a comment essentially. Let's drop that too
> > please.
>
>
> Everything below --- was added by David I believe to provide further explanation that
> doesn't need to be included in the commit message, and I didn't want to remove it
> or his 2nd sign-off, as its discarded anyways. Its useful info that can just be
> ignored.

Yup I get that, you've posted this several times now, anybody who needs it can
find it. Please remove on future respins to save me having to page through
noise.

The S-o-b was actively confusing, and this whole block of noise hid the
fact you got the S-o-b wrong on this patch.

Thanks

