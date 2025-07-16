Return-Path: <linux-fsdevel+bounces-55170-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09FE2B07787
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 16:01:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22C9F583231
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 14:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5131A219311;
	Wed, 16 Jul 2025 14:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XB8fgSWK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="O675aQEM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357C41EA7F4;
	Wed, 16 Jul 2025 14:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752674469; cv=fail; b=SxeOLpGEgTbVqvcJgnvYJ7n5uXvjc2E1vdFCUSnFtgSSZFYyGzIENpGcrX33C9tZceQCCHugxvcGu44fxVEJLe9rkwbY+UDzxuDd5CcB5ybOGGI9nndEhWItYtpp6F1HmS7Vez2RQwnRH7MuGj6jt6arCoD3mij5qqkTwxXP5oM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752674469; c=relaxed/simple;
	bh=zEK05BE4ldBRHvTh1e4jF2MwjuwTf1eOIVZAEmtjWjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CD+wNxkEG1QszfPniKU0EnILtCEbKm+HEbHMX04Dk226dfoslGyNc3C7vFcz3Y6G4bqARbzJ/GV3RhG929WKAGd3HDK4CraFNhmBBawgczDBT4Z9hBaW/pt9cmMsOXz3wSSxw6g0j70SfHTqwv2sTb7bnX5CQr9rcVpX6vXlUGY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XB8fgSWK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=O675aQEM; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56G7fnea018585;
	Wed, 16 Jul 2025 14:00:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=zEK05BE4ldBRHvTh1e
	4jF2MwjuwTf1eOIVZAEmtjWjs=; b=XB8fgSWKOofU3I8gMqtNBCOtgjRZBgc067
	znRK05CqGnPpPCIrPNEk821Z8uIL8IQ+RM5LDDf2hVAnN4spNurSLoefOCx5NFuj
	VxsKaU5/gI3LmX0cXgNPQfvcxqDX3MfbrXTpoD9YiulsItmUI4hHFqJWYEaIKZ80
	7/MJ7Yu9bzK/rJtmlyJevMZtb74eaccyYD7bkwfudbVaHwDgRQLgTEiZIj6IZ6UL
	MM+6rJ/zuUFygEfjZv9XfJojZZQE15BNdfa6z8Cp5kY3En3BDoQ4FaXEfeTaksWB
	UY62y0+z8sOdBzXoCubMSUrjAtLqjhZqCIYYx6rUmLlL0jgqqUJg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ufnqsrfb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Jul 2025 14:00:25 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56GCftGa010901;
	Wed, 16 Jul 2025 14:00:24 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2042.outbound.protection.outlook.com [40.107.236.42])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5bd0kh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Jul 2025 14:00:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R4Ep3yyx5jIB32obv5wOstpKBB8Vr8sUPGQChT3rmkpq8QEcJ365yNiPGPxWmbCRZfe6vSzh/qgoND8ssjylOUhQfGzo3l2neRskmffR6Y2puZZTSM9SodxNNtF9iSxt/wRwkj7jUvdNAbUCZAB9L5AZgzogiSbLnonXSjz4gaGjN6cGiN8kNGDv6o4LNn2Dj5xVfamSP34NiGr4mdbadsNj6R/0nu8Q000GVA3/40J1KdseUDLDzqSVEKWW8mvgvmMVPkCDfL5rMCOsJx7GzyQCuWSgW6PWuZUqMQHUBoVFFszyEoeXcIuDzlw78h4I7hKYIJSkh885nQ+gdEfJQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zEK05BE4ldBRHvTh1e4jF2MwjuwTf1eOIVZAEmtjWjs=;
 b=LnzBGx9yDXe0exODyT9gT0tBe9r2GHuBmETB8V+u4L16X+P496aei759ssx2uy0cKVQju/CPBFIba3syl6pOLUDvvRPmsOjI7g5i0kMPK0Rei0q51R4rWBNq+Icb1ZheBhuXNj+mAvuy4JN8Ypkv1r24Y/YqEJQxPyD86AJD72Z0xblDP05pHzbcUx86ZQ8+l3Ib88ondOJzzUEqEe4I/u+dAjjUMLfww5w06zm0KQEif1K8ZrT5OpeFJZ6Q/nxN5/5shH7Of2uvVl6D8mS5pAF9O9UGAA6Pb+mne14Xfg9MKPZP/c8W6koNmaM+poVfuiyqi8dNDhOc2vY2m3Kh/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zEK05BE4ldBRHvTh1e4jF2MwjuwTf1eOIVZAEmtjWjs=;
 b=O675aQEMyqr8p/Cp3AHNwD/lNwPvcKH60GkbmU85xCeGzZ5GBm1CfMc8+1grJF+MCh2RnBmh17mZnZLGSN+BTkyettvcIw0DvXKgfq+942BvIzzxmCMJDtwaMUWxSvWzmnCLaROt111WJdkQEKCszpFdIfex7I+9EQ+aLjd2pKc=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by MW4PR10MB5837.namprd10.prod.outlook.com (2603:10b6:303:18d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.27; Wed, 16 Jul
 2025 14:00:21 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8922.023; Wed, 16 Jul 2025
 14:00:21 +0000
Date: Wed, 16 Jul 2025 15:00:18 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Vlastimil Babka <vbabka@suse.cz>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>, akpm@linux-foundation.org,
        david@redhat.com, peterx@redhat.com, jannh@google.com,
        hannes@cmpxchg.org, mhocko@kernel.org, paulmck@kernel.org,
        shuah@kernel.org, adobriyan@gmail.com, brauner@kernel.org,
        josef@toxicpanda.com, yebin10@huawei.com, linux@weissschuh.net,
        willy@infradead.org, osalvador@suse.de, andrii@kernel.org,
        ryan.roberts@arm.com, christophe.leroy@csgroup.eu,
        tjmercier@google.com, kaleshsingh@google.com, aha310510@gmail.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v6 7/8] fs/proc/task_mmu: read proc/pid/maps under
 per-vma lock
Message-ID: <07de1e8c-9319-49b8-8e86-97ea0d18142b@lucifer.local>
References: <f60a932f-71c0-448f-9434-547caa630b72@suse.cz>
 <CAJuCfpE2H9-kRz6xSC43Ja0dmW+drcJa29hwQwQ53HRsuqRnwg@mail.gmail.com>
 <3b3521f6-30c8-419e-9615-9228f539251e@suse.cz>
 <CAJuCfpEgwdbEXKoMyMFiTHJMV15_g77-7N-m6ykReHLjD9rFLQ@mail.gmail.com>
 <bulkje7nsdfikukca4g6lqnwda6ll7eu2pcdn5bdhkqeyl7auh@yzzc6xkqqllm>
 <CAJuCfpFKNm6CEcfkuy+0o-Qu8xXppCFbOcYVXUFLeg10ztMFPw@mail.gmail.com>
 <CAJuCfpG_dRLVDv1DWveJWS5cQS0ADEVAeBxJ=5MaPQFNEvQ1+g@mail.gmail.com>
 <CAJuCfpH0HzM97exh92mpkuimxaen2Qh+tj_tZ=QBHQfi-3ejLQ@mail.gmail.com>
 <5ec10376-6a5f-4a94-9880-e59f1b6d425f@suse.cz>
 <CAJuCfpH8zsboafV1UWufYhbVXN-yKgMOKm=vr2vBYAPNmPtrvw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpH8zsboafV1UWufYhbVXN-yKgMOKm=vr2vBYAPNmPtrvw@mail.gmail.com>
X-ClientProxiedBy: LO0P265CA0004.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:355::14) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|MW4PR10MB5837:EE_
X-MS-Office365-Filtering-Correlation-Id: 18e5282a-67b4-4785-3e4d-08ddc4711a63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sMiBQ8EWTYyK2lI1rJUHCJMHI5s0DuUr1uuRngQzMsBM014epSX/95b4mul+?=
 =?us-ascii?Q?YLQqP4nPQQOxQM/+c2M4z/mrOWkyZXhUAqYtqNmTu0coLt90pPQh6YopzL3y?=
 =?us-ascii?Q?jzsGuulynVSeE9ib7vUzyzlR7HDWQWQBGMb32eFaiV0tgjau7gwgjZqPWdiw?=
 =?us-ascii?Q?w0JtoVoso24pFgR5I+dyFqnTlKkE123GEF2BXA86PjxJFNdAzR5neYTJtfQo?=
 =?us-ascii?Q?3LpzjgHauPOiSj7+ACYUDddddGOjX1JPLPVeEbQt3MYsUgK2JExY2YEJSBA9?=
 =?us-ascii?Q?N6ne2nM+++OBNBIR8636NpET01OjjmEx2sipmxEhMvUmrZ+w7sLflzLPNISD?=
 =?us-ascii?Q?Dw/JmnoNkHuomEcF7Y2TclvQYVJSd2ay/LCpy6oaSY308aFyr/sxNqQ2DHpO?=
 =?us-ascii?Q?1H2oSP4IFOvqbm/aJZaGzTxEdbrT8m8dPBQf7HdKu8ROx4K9QPCu7lhHTMt0?=
 =?us-ascii?Q?WZcKyTN9ODJnXQofS3BdK1GE2VBkQU/TNWTc+IkJfWAiqDv/t9gNy2SnIpaH?=
 =?us-ascii?Q?5OTWWGXz5bwTYR6hDrYQO7a9fXN8pW6yAWVU7P69ucoW/LghrceH1DPbNqnP?=
 =?us-ascii?Q?ERzMLKHC9DhZyKWmdDShMlB0aFQQ7Xkhg+wZ0yu44xxhs0yfQ0lVSejC3Ymk?=
 =?us-ascii?Q?ktCJJOSPykY9y2+IYUM6NAYlhI4EjLZ6YnL4de4Qs7xkaizkHPvqkCgOuiP0?=
 =?us-ascii?Q?lCgBpGRv54adny6E55lDG4bsk6cVvI1akXkuPgqXvyNJXKaeY0/sRqsDx9fW?=
 =?us-ascii?Q?h81AuicEs6t8paQtajxwVYwO1Nj8sT9mRNlUe5Sl5e8pLSmGnDJUHdlyd9vQ?=
 =?us-ascii?Q?pk7ByRsuryw+9NhIVw3LUyEPDaMsJW6l0unYqfTWD+xaWZmdRiug/QJKq5Qs?=
 =?us-ascii?Q?nUaYFLzwf/CeioJ254eTLHJ6q9SmwvfDqS+TFMITy+xI8GFl354HMFi/oxHq?=
 =?us-ascii?Q?XNDzdRacbrumZ1vGdCZRBvjzxuEBcFBQ6yGs9dq15cYPkZUaaUQpA7nRxKPa?=
 =?us-ascii?Q?Bv3J9Dt5EwUm3XNSuDGu5wNgF0ZRHk3KiII3djU5XeEZRZlcRZc1Cu7b+FIc?=
 =?us-ascii?Q?CuUI4+rVqQxfGmYtMtdmnzfEQUiy8kagxRXzIwenRK+6XS4u7QQHwOpSEkSh?=
 =?us-ascii?Q?FmsQVk0ZQbtSS8Vle1q0vstCATEnr1V0hl1uIxrcuYBSgnnZHoHBXprjPXu0?=
 =?us-ascii?Q?l+DsUP8n1+f2+wtmuBrY6bRD2B+kjlh5EQCNwIBHGRSSocV1iVDGrWA1iaM0?=
 =?us-ascii?Q?FSbVRfdaolvj35Di9lhE8L9UMeHZpONz9JOP3T7xciLce7oVihDTMXj+CM9S?=
 =?us-ascii?Q?H5WUEtTsrjwcafaY7X8LXpEiHY27yuiiTpdi909zEmZdxkIua1swqyyf9J8k?=
 =?us-ascii?Q?mH53AFjKmDZRlXWtfEfDwS/NtI8WJ835w7znL6XAeFWtZ2jWp8EBU15Z9/ph?=
 =?us-ascii?Q?GMXC8GQM2Mg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eT/M+ShWYNY1xCZFneKFJPckKEbWBHsKNdXoR3mtK2gx8Vs4cVqiZr2nwxNw?=
 =?us-ascii?Q?Tyooujqb4d+oUWVWzTiXASbCxwc1IfZTzYovOTfn8OhG3EMnKZ2C/f4fMlsJ?=
 =?us-ascii?Q?d8senUfUjB3LNGDzfd9l1vFjtWtA1k42xiHJzyUiVQklixpngQc6Jq4iwDO1?=
 =?us-ascii?Q?6+3xebZc5+IEMdPOdng677EvMFWNutJs4AucJtBOZhwUtEVQdHI+jdMceXfc?=
 =?us-ascii?Q?fzZFF5CkgvyioowmwrhNCKGaT2idZ7kTkER4k39ppmqP7ji9NNgTbvkH0036?=
 =?us-ascii?Q?NzJ7ti7mY8Iu/2m1GkIOnYv8bH5bvvdqPJzlO83PE8De2eJ83F1hetnfZIHV?=
 =?us-ascii?Q?IVm2qOCj+j56eNV0CB+FCOa8V21NydE7vTDIBHJ+esrpT/AORFxiNgzeAYeF?=
 =?us-ascii?Q?5g+HRpDt5sfeGcPI5uOtxQyGrkHL66wUHdz5gxHyYaU1LucjwpkW+9UklzkT?=
 =?us-ascii?Q?MuURXLzTv+JnIyLsjVL6YIWTXkebxnw1dmP8yPLH/Vft8h8j87SCrrRW5U4J?=
 =?us-ascii?Q?rRITpgscgFNvZ5bFEUgdNFByoEJoUKPwelbiULZDvu8VLN8lX+J0Bi3lfz46?=
 =?us-ascii?Q?apShYZ7dbjXaoCsr3nNjT5f8H4Ha6l/qPpr+qf0W9ASTvvYOI0MMoPaInaE8?=
 =?us-ascii?Q?wFA9mgf2h0Ggp61U4AzYPVz7QX3D1tzj4tW++aDmSJGU5dET/NmP+I0//V5n?=
 =?us-ascii?Q?PDy533VTg2lQwwUi/t8hM7ZZD7kttno+fw9uqVUOh/bZXnQKKwtlnDpUreOK?=
 =?us-ascii?Q?JZyPU5L/8s5cu2lek9geRYA2TW1DYKQiUThWcdVnIds0RbLWlq4soDEm0FiZ?=
 =?us-ascii?Q?bAvmYwYXyS1JFAu0FvhDZcLYW8RAiHuRMGzKyzJldMrjRvGJ1W2pFlZh+kHO?=
 =?us-ascii?Q?ccHStCSN904tSyvweW4GhVDiK2+2CErp37rRHKrMyQoYk2LF9czdABnWMVuG?=
 =?us-ascii?Q?ZRLp20RMAlVzyhMuUw1ug1fbLKHYwW5KZzdLhttJrVcdKmpEg+oqkp+tRqAq?=
 =?us-ascii?Q?GoMrgQfxo7skTg4sEyYSCB5XrICwpXImFuswTVP5ayS4u1hcNM4kxBmFzTmY?=
 =?us-ascii?Q?idj/qNB1EooDMCJmB0sS3xxgS6fOqDsRePqtY/h/zyn5J9xEk9jz+vmb9ZoC?=
 =?us-ascii?Q?vbGnyO7FCT/BOkrUfnqNPfioqGpvztoUCMEkXrDmBiNp+3jn864vBgSwgJkB?=
 =?us-ascii?Q?M2cJa5Ik0iRJ2C3kR9ryQz0P0ZxcicJRpM3cYqtjUoF+VOkL451xFjI9OXV9?=
 =?us-ascii?Q?17/iBfqDZtDBV8acXQZz8v3EmSuhKWkRO24DFuGZ7p2cnDaBP1rHjloOMm+z?=
 =?us-ascii?Q?92ctrYWcL4yxlDnegiiVjhe1clQBruqc9nxt1rd/EOpe0pHwENS7Dd9KyFar?=
 =?us-ascii?Q?gxYXuhMXCwzkWcNA1KrX8TRMkJySV4ppa10Q/GwnuzLby3uRiplG49a5C9/4?=
 =?us-ascii?Q?eKaUgbB4he5Ee65o3sokHQdu9iBOnkyZm7a+imOJe273AM37ntssr2YZ7Q3o?=
 =?us-ascii?Q?ec2kCkK7mP+/RKlsltcKV5sQUXifeM0IkWdz4BvZHn+frV/kTTwv0C/leIza?=
 =?us-ascii?Q?rWDaTb2XJS2DcQ6nZbCFSuLdFV/b/BfZus7yD5jrKPCGpB+VF3y09T2YnKwq?=
 =?us-ascii?Q?BQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	lNkRnAiOsv1HkoXr6jZ/nakxOD/jEbZhHULfzbKPxl7gPa7+skepYoJd72O/Btua2uhMW/FikkKKFIVm3NbOuos0F+TL2yc6IomBc4Xi6K+pSBmIOgC2W2YlIcYCbumkTuza5PgYOeOWIpfSMrpFc5qiXBx+H5UkeiabjQilOGhXvLeLAAYC8E5R0NkCrw53SgUaS6z4meUObOt5sJp/brdiEACSx5k2pJyOB+pW4LZjNatyJG6/pUpcv2X8w+aNokWuoR7XRHcl4WPExZNDNO/stFlkaz311QV4rO23wuwvNkFcO4AiFOk5PTHUCFNO7Lob4cgapB9U5bXQCLLRQDfFSK6jVhH4s+L6xUV3dguF1h72900bF+FXBoV7EjtVEcRzp6v8kO/wH8PMwqcOZPFjiF36Yd/omYptwKUen6DEIftRpwxcKlVRH2CTdfuAAEuPhQUqiajp33pQsuBymZ2xQ2C4EFc4WZHwe2dYgl2SqNKd/FduWpl4kltSHmI0fyCN7Hg3AJnvQczorxCFvsIaKaOSEgmznxkRAKbOZqynAmEB+q0KJBEeuFQ2wqPv5mna3dAAeQf5ypVNQS2pAlldsj+4ya9V4xb0YiJtrsY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18e5282a-67b4-4785-3e4d-08ddc4711a63
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 14:00:21.0792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kq0ue4R1/E43nAq69cE8qHOiUkv3osWfxvnLhJpueR/FTzlZXZ7CVbeCrKCNJ5rooLtt6M2bRzt3e7c4z5jFf4G3WFrF+vJshgWgG8qriyw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5837
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_02,2025-07-16_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=852 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507160126
X-Proofpoint-GUID: B5FqGr7dGL6fujx-s7O17CPTpFBD5Oz9
X-Proofpoint-ORIG-GUID: B5FqGr7dGL6fujx-s7O17CPTpFBD5Oz9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDEyNSBTYWx0ZWRfXwxf/aBImNt2r kPfJLSpb8+lUdvY646ivnmUrbtM8zvwWBXJoy4sjnbYB1BHyek3D3wOMJxL1K0YuGRNjdsRd/0o jngd+gp3/mipvhz3FHlJ82RSPFbxMkmBIuXwQ6jCcwBxB3zWa1zmLb03pBztzMfKSFa4c1IqI/F
 2y8zz9POcaVOO5gJAMwFSuS5NjMNaSvbDzbzWmiUO5mSr05Yds/gA8cHLOHLHBbWUKmV+nyCv2K 6oz/ZXFLsXaIjo+4vmZEAD8qbFDWQsZsX5HytNDAL95x9ZM9zct32Ve+Jsn6/AJRig+RIA86HCQ f51KSuDDgGy9lpfYZBhUl224zGtONw9+1CeuGaIBY1oeHQvAJKgiTQ3tWv+JudX59totnjTWWeh
 qj8ifnsfYB7PFp/R0U8cflrOLCqBArB37InZobVCs+cve4qlm4pjGTVrCTP9HPK7lIguwwQ/
X-Authority-Analysis: v=2.4 cv=U9ySDfru c=1 sm=1 tr=0 ts=6877b079 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=2fKEtNpLU8h2pLokBREA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12062

On Tue, Jul 15, 2025 at 01:13:36PM -0700, Suren Baghdasaryan wrote:
> Huh, I completely failed to consider this. In hindsight it is quite
> obvious... Thanks Vlastimil, I owe you a beer or two.

FYI - Vlasta prefers the 'starobrno' brand of beer, he says he can't get
enough :)

