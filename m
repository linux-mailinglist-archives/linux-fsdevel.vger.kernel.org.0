Return-Path: <linux-fsdevel+bounces-68629-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D470AC623A8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 04:18:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B3A094E6956
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 03:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16152EB5AF;
	Mon, 17 Nov 2025 03:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="R84I0D+E";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JFToptE+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7082E7F21;
	Mon, 17 Nov 2025 03:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763349395; cv=fail; b=sRQnRcjQjo5Q5jFXzeG7YKQUjErVQvyeqbZ/AY45adGDwWaTRdXo78XS9I2ASFc4sFdP9IitExBZviP7T5YCTqMHaWu/jVeqP8JMz/4Wcotqc/4NZea1Pi6PL6FQSwsCinM9Taj8LFgC+/IoGFMsViX9GKbB5fW45EyFmcE9bbk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763349395; c=relaxed/simple;
	bh=ClyAyq8H6P1kgkxtvLAqrlgpYyj1Vvqtwxe/j0CSoNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Py/iL1QvjVP7SRkTKnToLvecW3P8ei3aFRovm0SWWke9L2L9YBV7Ok2TnTrwGtgu9Gn/RuTcXV+3AjpE2m+8yTQYyReg+xEbIFSwJ1rVo4PQH7+3IBBNBQeX+e2VnUJTSW0doRf//tJ/90swj3ENtOlLeCCXO9FGRc5Pls7sulU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=R84I0D+E; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JFToptE+; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AH1uX8W002230;
	Mon, 17 Nov 2025 03:15:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=IfoLE8W8B9x/ftVJSE
	PFXquBWyB2Y74yluKQ+cr7yC4=; b=R84I0D+ECOepBf1DJgGvvIzYpVBWeQEoW7
	JeRQRPl64euVTvmsp7ptt9IDlFpXrikODwcgDBuWhSwG/gO/11WhNhiL0yinlUGj
	UbzNe4g7cmHsLD/0vD86sfj13VpHJt81TfRXFBJaDxmWsSTLG+dUSRO5b78Ho0O0
	34fjLuSrSKFrqS3r9485+PXCjqkYRwcBz5e85wc+WGkosyrlZonkIDzasPKGaCoR
	KUBpVOPX0B5lVsjSpgdsdjnHXHmLO0qLafzS3xJnGs2GvJ52y+G7QIbzuY0LiC9h
	x7Ue+8Fo/j8Z08G/FhO+ogjmF/GvpWZu/whMhTdz0rt9vqSZyZPg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aej961j0v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Nov 2025 03:15:37 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AH2mGRe009766;
	Mon, 17 Nov 2025 03:15:35 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011051.outbound.protection.outlook.com [40.107.208.51])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4aefyb49kf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Nov 2025 03:15:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gzaTjMGQ2udcnqC0YUFJH3EjeDQz163Lcr6N6w9J9puXkbDGp+c1D5iND7CnOtZBh85JMHndNTuV8Hejc+SJFmWcps2AR0FMwxlCqv2OWDH4vJY0PbIyON9b5MchaQo/MfXLi/Dix7uos6vUs4OHkWx8KW773Dx4OxZP+oioSmj+sI+VFe0Ox9kP51CvU/+YpDe+404OAHcrp/J6PSK3FQfSxKezQBc/yJf4fJ8IuHAihQb3vxiS1hq/Q2tO3MMfflDjKsAPhZ2dz1RHFUaGrV+g3tu9PcC8oaKrgGiWFmJbOgZZyUP0KMo4t6VfPO/YNfK/6GsDxCK6EdQRLXIdLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IfoLE8W8B9x/ftVJSEPFXquBWyB2Y74yluKQ+cr7yC4=;
 b=ruglIYI2ckuHHOEK0yov7WDN9O+hO5qSadvC+z3Gdxf5jMSXj6daYq/l9fkpyg/LByRnbk6wOU3c0qeMkQV9Cc37VpIXWaxc3u9lYu4jthaAoWIOG8gCIqY6nqDOrlQuldWUbCLltbaEvhHxcoyMeokk6jzNnypUfQIb6q1z31Q71NDgnIltsCMoOTJwftpg3jMbl56eUWKcAUV7L4E66a/sw09meB875FI1qfW8+icFA+l7G3btNblQMeggcgQigdamQcQakhcQk3k+BDnU6uI9N3Iq7bWGMjj8XjP75zSRbyTGMJxFctcMyj/3anHy1M6IEGrL1FjaGPg5A+NBeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IfoLE8W8B9x/ftVJSEPFXquBWyB2Y74yluKQ+cr7yC4=;
 b=JFToptE+rIl3TEHzn37/r5ltS8yJcHk8CkkArjTcWEsNdqCinkb8nJW96i6v8qnoCwlR9yCr36pR/QosKJYUqRJz7jojz/a+7db1Q7ot8thwgSe72VWevCtZ6KIh2mrIUx4+5+hSfQccx0KaE4Zgue++Jlx3fR5k39AZYZDCKuA=
Received: from DS0PR10MB7341.namprd10.prod.outlook.com (2603:10b6:8:f8::22) by
 CO1PR10MB4802.namprd10.prod.outlook.com (2603:10b6:303:94::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.21; Mon, 17 Nov 2025 03:15:31 +0000
Received: from DS0PR10MB7341.namprd10.prod.outlook.com
 ([fe80::3d6b:a1ef:44c3:a935]) by DS0PR10MB7341.namprd10.prod.outlook.com
 ([fe80::3d6b:a1ef:44c3:a935%5]) with mapi id 15.20.9320.018; Mon, 17 Nov 2025
 03:15:31 +0000
Date: Mon, 17 Nov 2025 12:15:23 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Jiaqi Yan <jiaqiyan@google.com>, nao.horiguchi@gmail.com,
        linmiaohe@huawei.com, ziy@nvidia.com, david@redhat.com,
        lorenzo.stoakes@oracle.com, william.roche@oracle.com,
        tony.luck@intel.com, wangkefeng.wang@huawei.com, jane.chu@oracle.com,
        akpm@linux-foundation.org, osalvador@suse.de, muchun.song@linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Brendan Jackman <jackmanb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH v1 1/2] mm/huge_memory: introduce
 uniform_split_unmapped_folio_to_zero_order
Message-ID: <aRqTLmJBuvBcLYMx@hyeyoo>
References: <20251116014721.1561456-1-jiaqiyan@google.com>
 <20251116014721.1561456-2-jiaqiyan@google.com>
 <aRm6shtKizyrq_TA@casper.infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRm6shtKizyrq_TA@casper.infradead.org>
X-ClientProxiedBy: TYCP301CA0038.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:380::13) To DS0PR10MB7341.namprd10.prod.outlook.com
 (2603:10b6:8:f8::22)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7341:EE_|CO1PR10MB4802:EE_
X-MS-Office365-Filtering-Correlation-Id: a474061a-57c6-40ef-3bf4-08de25879078
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QQjoDMB7J4GW9LmzjptNVDzyvbykLJ5q9Jtk+6RAiqE6up6X6Ggm/Xt4oW9a?=
 =?us-ascii?Q?ieOD6A7FDZhPu3e1hEo0w4rtnBc6za1U/4ushqBVOf8+gv0x05dTXnpyLgLk?=
 =?us-ascii?Q?z3x6StJh0sFmYOvxTprtHeu3NwiZsmduZG1CsGNyHqOvl2Q0ziaBLVB0VCoC?=
 =?us-ascii?Q?gxzcw0ueRAAzLBrqyURZoBH0MyV0JJ0fq8crfnDkmCnTaAmiwfqhtSSfbIT5?=
 =?us-ascii?Q?zRVtIPUPXmP7JAgR9FtB3f/VfKacB2V4GxBYN1RJJ8E5U79AWtjS12HwytvO?=
 =?us-ascii?Q?oAzkcY+gnZnun4JlEZDaSQPzdI2DY9co1LRO+5BSfjxvLTZRQOJMjJdehvJo?=
 =?us-ascii?Q?uueIwbqHb8T9xBBPFO9Qa+QvoZc6Fp5A8PMBV7Mry1zuwrT6SNqw0XSr9gha?=
 =?us-ascii?Q?4Z6VOuRdQm/dqcrSoZtrVlA7/mBHa4RzIYqWXto32sP9RIB6zIwIM54L+m19?=
 =?us-ascii?Q?7FDWL+mFY8QTPeoyUXkAUSDb6Uism9SzxeAqx+L47gvHmH+vif16/llPYMX3?=
 =?us-ascii?Q?bY1O6HTN5+/lCIbstaBylouxZKLyBUFBIgJcueand+QhuHmF8bwKZe7z6URn?=
 =?us-ascii?Q?6UStEMvrs07YSJmxbwNn1wej6cDSkJPmoqNfkhVTaNGAC3rAs9B/L52G1FhO?=
 =?us-ascii?Q?vja/9mPEkpxXNKFMXtJ0aip5XG9pyJuOO/Pv6o2RlgB5p8zrk/EC7VJRzXXc?=
 =?us-ascii?Q?zzxSthZEc2ekaOiWn786iRJz6RKoEs+45s9OBMdwmapOT1FuaDTUx5aDvr+R?=
 =?us-ascii?Q?GsRunGuewOIm8DogR3MEJSnPb4+4wLt/pGG8hCA8r4hKhU/efZQ4s6Al5Yjl?=
 =?us-ascii?Q?aORbeZQRiniPK4bUJFaGWKnIYM9PgXzf0/hPMeko9neVzX7QKdkoNTZ2Ejcs?=
 =?us-ascii?Q?uY0jQC0E9X9RksrYus8SXd0EjBdbDzVcAeCFdF9BPEEjFs4Zr8RwR5TL8AME?=
 =?us-ascii?Q?ZdUx/PsmOHHtNVeTuR43MFtAxYTGFAvKK+0qZQu/tGJEt4EwV0GiidOEpEU2?=
 =?us-ascii?Q?TMnzR+6RlMTSfnuYiMVIx16oKgWo9Tgj99NjQ2tOvY0J8fcQkhArGrmKjksP?=
 =?us-ascii?Q?USK/JwsHsRm5NKXyeYnKW+GL95gwKmjMKquw7gebldydfVWs2C9OQMpEJN63?=
 =?us-ascii?Q?V0puvHd8SlZj29chWCbKw+YHGSxjXZHYqVtl0gHl8iant7hf5Lb5wzxzxWBa?=
 =?us-ascii?Q?Ym4PnN1LXrg9MueCKViXjLPzYzDMFEiD/aCxQmvtXfgUtwXI0T/gxFYbP0e8?=
 =?us-ascii?Q?EcI8z/8mLdrD1lfXhJA1KVOADxaJYgw5kil2v6WaZs9sJEzx6STAoJgo76NH?=
 =?us-ascii?Q?ogDMI5j1x6EtNnPilQf4QaDQZNlqWciRp+AN2VAvi0cI1HfAuFrvlgI1OQW9?=
 =?us-ascii?Q?PheX6D7K81vqhgNcLATwsACc9GAAPxuRfeBc3XuZIHlKErv981AgphTRpaRr?=
 =?us-ascii?Q?VAfImKuts9GXrn0htsYtlUtU6TUvKYiT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7341.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cxsXV99YPBZVWAeS6HOLqQ1gFe9PyhYzZT+irItaarqAmtp1PeGmCyVP/q2c?=
 =?us-ascii?Q?dc4RKJgElzDL8QlACKmEtVhEiNwgqLYWWBt5wqEZ5dSkiJHvRd8T3yyHN0OZ?=
 =?us-ascii?Q?2UIgjbiOcBMWi1mwdiXIFZSWjQYqVoPGh8m4PD/FVphSOhvxs0X4E2VgDTyv?=
 =?us-ascii?Q?d5ohW67K0Grw5IhAWgPRNLsdG45FrWVF/Gutj9tLvr4RInM1IjeUOjuY5ooh?=
 =?us-ascii?Q?+ErIJY9QRWI4Z/UI1+KTksqEcDSbcNMK2/V51qTlO3ZcyVPDG0+vsmmPU9LO?=
 =?us-ascii?Q?YU2CNy3Lc5I9NgwVYGOHU+0aUAqPV2wuVCPWFGj1ojNkBF8Xx8prPbgmF5F3?=
 =?us-ascii?Q?WcrJDIe8iBzLQ0Y8kosSSsXw8djQC/JOi061xx3dPHVGr6VKufvQK9K8M2+C?=
 =?us-ascii?Q?5UqsRGQ1cpd1QZTHTzef3MD/GDrjn+hYalZLbmLGM0AI89rt7Fk30sq+gPjg?=
 =?us-ascii?Q?CxAzW3W9ldQ8uYfszPaOeeJfd9OBE0lLOfRqjUENl3mRk1KP205qOMIZE1jI?=
 =?us-ascii?Q?AD2gvCdH2Fkbsu7ObzUX1rKsNeH1EP3y4zrPH6HqCtjAS02uR0xvviLUubHu?=
 =?us-ascii?Q?Drvm/gbLYVmgSYGVkPOTXF+bz1RI7yxF7zMxCa6avnDwzA0VSDcx8Mdv3Lo/?=
 =?us-ascii?Q?xGGyIjTVP1GZGaA24jv23nApY5QyyeosgHhJkZmNLBqrd1hJIghWjC3n6pJJ?=
 =?us-ascii?Q?ck3mEXXxMhji8e4zR2JoBm1ABvODdovchxXpqI7ep63lRaY6EddgbXf4OgdU?=
 =?us-ascii?Q?y9DJbyQAeDdfSmTgxsV+lFRxctQ/vVslHdnXwfKupuyLhn/nsL9dxav4arrm?=
 =?us-ascii?Q?JmKEivAuX8oyNY/VqBKrJ+yvSs82zgGONWrV2eIBGSJzqC528c4weHApaT8o?=
 =?us-ascii?Q?+hjqFQg1CE6zSx+PPWmo0XChXDpsIccAWjf2/snumAPu356LsKUbO9ujQeYk?=
 =?us-ascii?Q?ZkmR+GiE0+TDNOZZDYfmZCgNhriIGz5MVa1TKoi4/Itv8v3Ak0bRPAeYyuOn?=
 =?us-ascii?Q?1QcUAr58e/oKuE1OjUzfvI2/zlPlC5FMHzoxYq0CrcczWP859R5U4wig0Qfe?=
 =?us-ascii?Q?Hz+JReP9GUtmk6Ez/X2XOgUd0VFWYz3l2M8u9ASEnW5vUhl67wKGDRryT4Ov?=
 =?us-ascii?Q?rDWhDr6TH5/S1nE31q+f/hom4gyyKtuAVjU4kKE3/BYoJGszsCxhfbbuLd7Q?=
 =?us-ascii?Q?VermI2U4IR7g82EV6eRAwr0dQkrKDEBDx1Qq0YTtp3g0/ZKTdBe+fflcc5QM?=
 =?us-ascii?Q?CS+1UF0WQ6PL3Nf6I5HMdLP+2SpDQR2jTv+sp1X72R/bpJjZMyg5j0ZWC1kJ?=
 =?us-ascii?Q?9Uf50fjPq2Qo35XytVBh3XqsEnhSydOe1kWB6O/kwfBYnhEBVBtmmpV72JEb?=
 =?us-ascii?Q?QXme19t2eZ1GncLyF5t6BTCI2o+vQzHDJWjBr5Pv3zaXF7SZd5R2jx0aHVb2?=
 =?us-ascii?Q?Sb7Wd/wINRtzschAoXygUgGL0eaia9sExNGiqkY4bfbEJVkpppbvR7Pm/0IY?=
 =?us-ascii?Q?bM1bNFYsGJTyxan+i/xcqQ2FlwoC1taE9Si9pMm7H4BwOVhINAkljH4xBZ9o?=
 =?us-ascii?Q?1lLzBEA80Bl2Nu17QFOxSwHUiwsf0mer8rchml81?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	SXCxXU3fUskxV+SOgO8+jJpNDOZ38gWtixL1E3nvjY3S7sHZU03wDsyx58DglNo2L8vOdGXNZeOpyRqstOorJzYF+e5WfImJ+3xnkao2WSOwJwTz5vUOWZi1UNf0b2gpS0+nwIR9f6P3ySKflLGFSBN214RXZu72XUsaZ6lsvTIFpkTZZ86Szredg+PQO9hooZR7oGmBBmsKOEQBn837EFj2xxgDJpZrXx7BjfFZDzdDY8ATc6oPeTNND46iWTK26RIyPKLD2QhmbFBImXaBbJN1L3+7MxM3VeMYzs2Ds0t/r1vASTiGdpaGCpOsJ+N51D4OONH+9u77+MUFMsgoBt6QOSBcZsXdLXuGLOlDi8U2dCYopLO9PRO6uLfGwxcIIsgvnFgMmEvSbb4XID8+DNoabfS2h72w9l9sHBGDg1d1AH4qSE4CAqhxguSNLRbQirMrV76cLikkOVI3NxU8L3eQaRu0JPqSTZE+61ugPbRLMV5R2JqmaAL2PGPYoM/r5D9VGBxXmw+/VUFXs493Co7AXqsdoLgOhm2FeXFn4yuQMZiq2zkmmDaBRjD2julEJmxZfsn9VN3Icw8kRnKY4RStvbOkasllBCmFidptYfs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a474061a-57c6-40ef-3bf4-08de25879078
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7341.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 03:15:31.1565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 64AmEWzfm6mbEPDzmkoe8hCowGZELB0XeNpCesr9gvN1dg+oFZ67WC5QF1PecpdSAnR99B6rY1zRk6bEIrLXrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4802
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_01,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511170025
X-Authority-Analysis: v=2.4 cv=DYoaa/tW c=1 sm=1 tr=0 ts=691a9359 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=GyZhcXFIhQJMIaUcjn8A:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13643
X-Proofpoint-GUID: j3tX7X5gvoJq28vl2sBfrvbLoPGx9kjN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMSBTYWx0ZWRfXz5E5OIgiAg1H
 qj1lCQLVlUaaSEkh8Lco+PFDArC+h+WyjSwc15FERL515OpdjPRUmh59fb5yecZuQTmniJl8mke
 glaLRYBC1g/UgOOTjXxuXxr0yVenTFia/u433xMquFc37fsTkQQdJAB3ZsMelbp7JGUs1BZdu2w
 pCIlJQjm2JVyM3LhyVxu62ztpmrT9I1kpkPC7/6O0NKQLMIrWx58VHW6DGAhguHt90aIQN4bWhg
 bXE8G+KC3zOWv5bJUcp046YYRBYCt/QFcU1JcXAqU5cp1qDSE9SN2ytPzWD4eZHo8GkdUQArF6S
 ngXYxeQYssx01W/xzWnRWEj5FZ9mIUYSjatDhtYvSnnuF7cYvnitvAFof4HiZe4Hj3I3pg6MEjI
 HT6tSGJVa+zgBCJkeyVshcoEAv7chX6N0sWKKfCq7KN5b7VBJTs=
X-Proofpoint-ORIG-GUID: j3tX7X5gvoJq28vl2sBfrvbLoPGx9kjN

On Sun, Nov 16, 2025 at 11:51:14AM +0000, Matthew Wilcox wrote:
> On Sun, Nov 16, 2025 at 01:47:20AM +0000, Jiaqi Yan wrote:
> > Introduce uniform_split_unmapped_folio_to_zero_order, a wrapper
> > to the existing __split_unmapped_folio. Caller can use it to
> > uniformly split an unmapped high-order folio into 0-order folios.
> 
> Please don't make this function exist.  I appreciate what you're trying
> to do, but let's try to do it differently?
> 
> When we have struct folio separately allocated from struct page,
> splitting a folio will mean allocating new struct folios for every
> new folio created.  I anticipate an order-0 folio will be about 80 or
> 96 bytes.  So if we create 512 * 512 folios in a single go, that'll be
> an allocation of 20MB.
>
> This is why I asked Zi Yan to create the asymmetrical folio split, so we
> only end up creating log() of this.  In the case of a single hwpoison page
> in an order-18 hugetlb, that'd be 19 allocations totallying 1520 bytes.

Oh god, I completely overlooked this aspect when discussing this with Jiaqi.
Thanks for raising this concern.

> But since we're only doing this on free, we won't need to do folio
> allocations at all; we'll just be able to release the good pages to the
> page allocator and sequester the hwpoison pages.

[+Cc PAGE ALLOCATOR folks]

So we need an interface to free only healthy portion of a hwpoison folio.

I think a proper approach to this should be to "free a hwpoison folio
just like freeing a normal folio via folio_put() or free_frozen_pages(),
then the page allocator will add only healthy pages to the freelist and
isolate the hwpoison pages". Oherwise we'll end up open coding a lot,
which is too fragile.

In fact, that can be done by teaching free_pages_prepare() how to handle
the case where one or more subpages of a folio are hwpoison pages.

How this should be implemented in the page allocator in memdescs world?
Hmm, we'll want to do some kind of non-uniform split, without actually
splitting the folio but allocating struct buddy?

But... for now I think hiding this complexity inside the page allocator
is good enough. For now this would just mean splitting a frozen page
inside the page allocator (probably non-uniform?). We can later re-implement
this to provide better support for memdescs.

-- 
Cheers,
Harry / Hyeonggon

