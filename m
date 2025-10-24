Return-Path: <linux-fsdevel+bounces-65579-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BB101C08034
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 22:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 40C2135765B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 20:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6582EC08B;
	Fri, 24 Oct 2025 20:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qe087BXN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HKQjmN5W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93242D2493;
	Fri, 24 Oct 2025 20:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761337010; cv=fail; b=GYua6jXIZ61m/zS/5NRjHmAaPmq6Z/WDRiuk8zSUQpovLgs022xGBhEzgw/gdR7dMwAhjExU8qh0KIYNPb4JdMODmiGQ+C3Nxzons4ItOZF/Sl8qPhLy0c25ILOdhfpU6yYrr9IKpj0GPJI+IZmbuctFiFAJf0zoEYWhc1sdJyc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761337010; c=relaxed/simple;
	bh=5ZTijjcURSGMWmIeE5pRypLnRcYtIWzhn5/0BnGnZ5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=izYqQZ6ERZx83ooe0e+14pfH/IRzCaWkhMAiAyEMd3kBO8nMPEDJZKr29WpBuMHbdSNePt2oSE9LFJ/fDtezt0zhv0A3DKdW2Y1lRViFXh5F/8ofTeiiAQjtlGcgqCMR8OwbpDJCLe2oinvndg9/tKBWL0gYZPAk2Ez/c9wYb6Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=qe087BXN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HKQjmN5W; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59OIND5k024745;
	Fri, 24 Oct 2025 20:16:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=5ZTijjcURSGMWmIeE5
	pRypLnRcYtIWzhn5/0BnGnZ5Y=; b=qe087BXNF84/eW0O03ImUPFaiMeUb44x0L
	PMvmnHr9atoqsnJ2hIK5lBaikSYouBVtgfjeDmIUL2wu8LzDS0u2SAxh4FIIJzG0
	uESDuwr+rPtqGMuNHyPdVj3N1ZCqnH128574PfFNCj79qnFY4nKXwnV4BJEvN6r+
	/cwxsq5XLuGANViy6TFTTq4twigxJ0Qk0aMs1MiPjIU3GP9+VrxdO1dIV36KbpD4
	QPLAwvelzemTFck/yGqG1BWhcPVBRnukK5TQYx38mUWxYh5QkGEj3xrhsXhPM4jZ
	N2dKSTS6wIW7b98HhHVlez4hbHnd/KJ76LvX264eRM1cgBku5kcQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49xvcydk6b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Oct 2025 20:16:05 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59OK2f0j004427;
	Fri, 24 Oct 2025 20:16:05 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012002.outbound.protection.outlook.com [40.93.195.2])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49v1bgbg28-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Oct 2025 20:16:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=an0zu9x5RYiu9DRTEMBvN5NDOVL1jlX4apJPGuvXvULlVTNeeOohzVXDGGdoaQSZ0q2aHWZZxr73CuCsXaJoJr/F4VlMKeKrRab3g21tzaInSpr5qLlvJhJTDRTCi13+mNVt3JeTvOEGQqKhkm+lxbhL4iUpcJ+DRmCaAQHXr/iNP9hvb5Vpd8lkadgpsXJGg2q6rt5Za0IL0XUSBqaxu/MgdqZP5SWT6KkO+lfqMG2wBp57krPo60sQiSj19A9SBXnvHuQhgIhf0JtxyEsgv+p8I5MmJNyVuD747dCMHYOqCdxdEtubbB7CxI3XxlSO7dtF1juZ19/hTaxqrscT6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ZTijjcURSGMWmIeE5pRypLnRcYtIWzhn5/0BnGnZ5Y=;
 b=JWLLz5o8UBcSgvnMwitEuTi54qcfH3ssXqoqNUUw4xsU91AVnUvbQwNt0NM4XuQaJTDczdeCg8Wmyyzz9AA/w9fC085fPc1zX31UIodopKQJ2iciCKmG0A6KYk0trNytxMou2Ygx/jFYw2S0cYB4vAp4xPjwm3Gc2Jk+Dgk4Vkdd7BbcS73Ic1btc998ibAZq6TKqndRAYqvtDLb7bu4beLre348ZUYtG5yBD/V0YEksIV6Ad5HdWX9gh8ld91yy8e1e4mwy4G5oOimtxl7Ano+ZirxCzhy8O3SAjZHZg+FsmxgVvPMoa88py0zRvn5T1oRRsOwT1tL8++U306PLWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ZTijjcURSGMWmIeE5pRypLnRcYtIWzhn5/0BnGnZ5Y=;
 b=HKQjmN5WNZ232zR3Ng/yWlPKgFjo9mm/85bpzCIZs7PubrnbKnvB10DqXnUbV1o0Ig5InoAdVNd6yPHTqQ5QrqsnT79a0TgG6ZXm6FlUEPUrfaad7LsYZRR+iiY3tjGQjzdPpaYanJWDXLGj7SfjPxEnwxw++kkWWPVvuP+VFTs=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SN7PR10MB7102.namprd10.prod.outlook.com (2603:10b6:806:348::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Fri, 24 Oct
 2025 20:16:01 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 20:16:01 +0000
Date: Fri, 24 Oct 2025 21:15:59 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Gregory Price <gourry@gourry.net>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Zi Yan <ziy@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Lance Yang <lance.yang@linux.dev>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Kairui Song <kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>,
        Baoquan He <bhe@redhat.com>, Chris Li <chrisl@kernel.org>,
        Peter Xu <peterx@redhat.com>, Matthew Wilcox <willy@infradead.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Jann Horn <jannh@google.com>, Matthew Brost <matthew.brost@intel.com>,
        Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
        Byungchul Park <byungchul@sk.com>,
        Ying Huang <ying.huang@linux.alibaba.com>,
        Alistair Popple <apopple@nvidia.com>, Pedro Falcato <pfalcato@suse.de>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Rik van Riel <riel@surriel.com>, Harry Yoo <harry.yoo@oracle.com>,
        kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [RFC PATCH 05/12] fs/proc/task_mmu: refactor pagemap_pmd_range()
Message-ID: <3f3e5582-d707-41d0-99a7-4e9c25f1224d@lucifer.local>
References: <cover.1761288179.git.lorenzo.stoakes@oracle.com>
 <2ce1da8c64bf2f831938d711b047b2eba0fa9f32.1761288179.git.lorenzo.stoakes@oracle.com>
 <aPu4LWGdGSQR_xY0@gourry-fedora-PF4VCD3F>
 <76348b1f-2626-4010-8269-edd74a936982@lucifer.local>
 <aPvPiI4BxTIzasq1@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPvPiI4BxTIzasq1@gourry-fedora-PF4VCD3F>
X-ClientProxiedBy: LO4P123CA0482.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a8::19) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SN7PR10MB7102:EE_
X-MS-Office365-Filtering-Correlation-Id: e2d1c9d0-fa81-461c-4fa1-08de133a26b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ro//7T+OV5jo3dyJ1qj170rAYDOoVrWCG/IcwchykdMgvEr9+WmqIAp31irx?=
 =?us-ascii?Q?fM4Htflf/LhCh+dENYwMcOxsKFogqGBthqD2VB4TAjK7Demw/rs1FTkOwBwP?=
 =?us-ascii?Q?TFn1owUdzwnXQG9iYfv/eA9t9MIpI2bAfdEVZWohPv9Sze7pE4sFNqiquYHI?=
 =?us-ascii?Q?XRAHfTijhzzXfdHndkHmUe0RTBw+OdiE6QGwQ6V6adpU9yTq+aUJl6iswx8K?=
 =?us-ascii?Q?dPg1SUE164zvEaw0g7j1zuwqwMqesTKRtg+Rx4asHSWL1l9m3WGO4g5H7yzu?=
 =?us-ascii?Q?1pfVmXjFcLFKPT1DRoKfcgM313xvKvqhhnkiqCL/Oz8US6cU/jNldew5HF0s?=
 =?us-ascii?Q?GJUf90Tl+3R2ly5kk6AVa5ldtAK4AST8CIy8x7Xsmg9MN51ZhN6jxLnzFVb5?=
 =?us-ascii?Q?e4MTpDyogvE3uJbjdkjUg4iF10a4k42EVQVhfmJCLpNiLofNtm4YmdCPd5ou?=
 =?us-ascii?Q?ABLl3XjcMNJ+AFvznm1IJauMPwnQDW6G88iIoqeYfTylvKuE3K0AbCMsazrc?=
 =?us-ascii?Q?3H3acw4IpDPnj0VbXE8W6zTU8UPKkaw0f3fmGlqG76VOu30qwka2WLZ/bMe0?=
 =?us-ascii?Q?zavhOqSdNGGCSufeo4aXIOzaK6Tmz8IW9aIYZTl+ito2zpUwSCDS89uwVduH?=
 =?us-ascii?Q?jov2soDV4szWwjj+AHKWlVukDS3vDSPAtWI86VdF1BdZBXFQJbUmehNj0OPy?=
 =?us-ascii?Q?ZeqmNm5/ygahK3rFe6leukKcjCfjzunZ6CBaoWsbfvLlTtkEH+SOSVPOKryz?=
 =?us-ascii?Q?WGHfgejI88YgiobsZLwlLDZZY65lYME6253MOvzlMK8+LSh4JMeDn7DQAPHg?=
 =?us-ascii?Q?AX+JZTYp0ip0BUO9EtaSbPUdovnVDBxHmRaswch7D8TT/3Hsab5SbwrKbLKR?=
 =?us-ascii?Q?x7rKArIS0rZu5530BRkUKOkMji1gW9O+8fw/dcEnP10hJB2ZMTwbon8pMQEg?=
 =?us-ascii?Q?XT+r8iKLK90qd91gVWMSWpVAftYxfOSEEw0ttlxaJtPD80k5bRyXQQ/hW6VT?=
 =?us-ascii?Q?94TyW4FvMO8E/m7AotdoT3UhXvPZ4vCHp2b7fMJLxg91nX36U/WtKEIWQ4ce?=
 =?us-ascii?Q?5gkzFRLtfED0hnMM4ixIWE6ibL1lxLI4YgYsa9Qj/oiOSgYxJD42qIljA2Oe?=
 =?us-ascii?Q?Hbq++SjtRbUAWOh006tjBvHoCPPrKX+AvcCjrhxgk3hUeSo+3Oha615nMB/O?=
 =?us-ascii?Q?nf42SFhG1gaSHcr1UdAjz/zM3cIf//YSVRyxHAw5hi5tm9mbnajUEVHYOgAd?=
 =?us-ascii?Q?G/Rjy9fakNFFimKL/Y2Ey3cfTxMZ1/6dxt9MldYeE4wQZswl5SdILHu7lm2q?=
 =?us-ascii?Q?bXhrh8EXBLPM3FcJ+sP5LBW2VJ4EUUJZeQeM0PyPcHdqNyAEgPyMeV0ynffR?=
 =?us-ascii?Q?97v44bSdhUu+ig5kqWykjLW41l+xKvX3KaTfuGuhJ5Y1/UBWY7ztJOHVWIax?=
 =?us-ascii?Q?iXjgcaNv1Bbmjo+oSV1h+5qlXYcfW1Jg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xMZXGKNMEhBIht/1APZ1KulgEqvYDDEKjxSGKSpBUmWFfUvSbjktfMsSseWy?=
 =?us-ascii?Q?tNfhXu2nmleD7D8wpf9mkXtRnIEABihxWcpTkRT1UgyjI8Zp4hOZdSyJ6Et3?=
 =?us-ascii?Q?uCwHBqIMnSg6uVBNUW8hm/g+UL69GUfrJWNEZAYHU9sIfGj5oGC6kDpovLpr?=
 =?us-ascii?Q?8MMjcUhdxRRtaRKHmFe3nPJqE9QlMQqiM3dqHeEsWLzr6d1J/futejTdNe/0?=
 =?us-ascii?Q?iQluzgm1IjekmDIjoCLKKoCiF9g61S2DhHfbZ6U6b0nVUCnCHQt3RXb8fb4H?=
 =?us-ascii?Q?lWw3CdPf+jfDYeEWuUpVxRVedz8QH8zL6WsN/IjMBwbRLpj3JZJ12NvnCfoA?=
 =?us-ascii?Q?TEtUmiNJC/PqknJki5uPtKZUWAml8WF6Se+8frz46vgHcQjHtWw7IpjcjDgR?=
 =?us-ascii?Q?cgoSPcWo7MTyRyIAIp4fNx76BGYMepYzuKz8JAjFATBIneKJm5Zw+a29bT1d?=
 =?us-ascii?Q?FICOdgIjfYNjNrcTdywQm9a8jAc6aYzXazUGwzYpublyHgUf0jWXXdOcsgqJ?=
 =?us-ascii?Q?uHlH2scVFab4p22WLEQh7g+JgaNPSGljin3hyzo516UAhVCf92RzIiFlf7wV?=
 =?us-ascii?Q?GhqA2chfBUUsnVvNbIRJYdVhwzR+3gahw/7w782KwJ9Uc35eWMmAbdfm3lT1?=
 =?us-ascii?Q?TRy81Jz0+q2DzwtBRSwfdesMi7jTO3pZffNy+kLdRA/kNh3C0KMrLmaBrv0e?=
 =?us-ascii?Q?/LO6B6madbBi3bgGoIvw0fttWnLFK7Y9svhDJFo1xn8LFOMCzGDf8fZDi44c?=
 =?us-ascii?Q?k952Lc/P+apksPybCXUBExM07XDZpm6VVCU6xYV7IJEtKdWM3AhCK/jKrX+d?=
 =?us-ascii?Q?uPz3S9MnKJHZrg19swQrSyx3lUVSNqg4DAOWusbqLB6MH1spXQpMrwIPlnDu?=
 =?us-ascii?Q?YWpSRxiRFTJr+R95rmEq+QJBKVhvUq4pnZrum+nFN5hZxn0BhBCvYw3vRzwf?=
 =?us-ascii?Q?qRftP70VM8y1Mv5WhnCUXBgAfcbVwMBTkkg7UndqjbQwQTdOsn5o1EMYkNpz?=
 =?us-ascii?Q?NCDZaCLzWj3gsI09BVzECDGUIyM0HRylrApNnkQiyQpZU5ksjGftS8kxBjEQ?=
 =?us-ascii?Q?Aou9RlzSrw3qBmxAUUoZhmjZFpp+ZdCsLfheIqYikZawJJoX8doYAh+/aIdQ?=
 =?us-ascii?Q?G9RE5X6ql9TtkS7heYJGaaG1h76dTMxAPrHdfTP+3fqXKi9ZrZkAxSooNtNR?=
 =?us-ascii?Q?zfWokEGgHUSheAk2IbAJ3fPJT54Tq602CRpVVlINAs6oHM6mJZLn1LUsqYU0?=
 =?us-ascii?Q?C6qi2VqbsD7B8tt7/5Xeej7JajzOE5iMmh9MPOI5kuJr3F6+N4fuk7aLqEYp?=
 =?us-ascii?Q?HiR+IcnwYxu6WiU2FyEV8tSuzMLyleh5tA+uQVTK61jnG5ruKxucB9RXDpI6?=
 =?us-ascii?Q?6eCVaAf5NkkvUXASNnkYhBD+UlIH3qy6MP2viJmzEXEJ2g4XW8rnd7RAIXPx?=
 =?us-ascii?Q?MhTCflUyEvn6bHWQFXXlXUvobxgeZajeXycUr0H0k6WlnYhbkNRTCh1BVoHe?=
 =?us-ascii?Q?XpxY/Yt0KfCI/idWANgeLTEoz5W0sUSv+qIIMlnwQw3ygFmoe66CTZaaBTpM?=
 =?us-ascii?Q?3j1b9fRFKjSTkAJjUpBhVM/SxSvnUYRHrjMGO5KBrdZOQI1/ItTqTcDrQ934?=
 =?us-ascii?Q?Vg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0a+x0gVetRNfALKcqkcs0hmHeA/ZUjL1skUCsa4k+UqejTUEZX8BIYzW4ceoC79AiiedqNrnjaL7rtRNhNEktPPRpWmKPSeHfnUk/GD1q4jnwvUbI/huTiRIZb6JulNkqur6Pq5BcRBWSNsc+4NW5oZuW8+I8RHpi3KHhwrcM3F2XtGvr0KVjRR3GhnRLXKjBR3JGKlcozXR691MSVhSLcgJofrVnOjztnKU1jh1HozmmCDKkJFDTsURIVZ8ZUy6y5B0CsIQXl+ouCVTHvftJIlzz3EcLh6zGnsUUGgd0fWMRHi+TQ3FXTqkNKpAvV9hXPgZW4EMlqU84Ss0deLN6oMG1ccNwKBRoPB/zlTzwrIH4ZtgOzrLJlVS1NQ3G67eJtG7NYDS4oBqypNBprdsRoEBPdHVu5AgzFN7lvZtDbijl/fHSwMZXOtKA9XnJES67NHoVd4hNtaMXCbEmp5XMZ1CRZajL1TZbHyZIZInaLU57Tl0tMaVK7lkd9xHXXFJY0x7jEJ7bEO0Gu1oPc3iPmxSIZCUsrKhip+/mODN7UIgaB+WxBazuzPy2VnV4AsZSfuznxdg6vjGj3HPu9qRRCscD3YTuIbs5bBCp8M2Y4k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2d1c9d0-fa81-461c-4fa1-08de133a26b9
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 20:16:01.2555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EoOWi88DQ4ut/nhlxCNpiSgnVXF2ToFv85cqcghdU6Rk03eeenuGjbb+gvxHcbuOhAU0BOKuFzZLZ6EVl/Syg4yLa49C164tS3wXJdg3qDE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB7102
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-24_04,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510240183
X-Authority-Analysis: v=2.4 cv=GqlPO01C c=1 sm=1 tr=0 ts=68fbde85 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=tY4l3yYr-_iEL48g82sA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIyMDA3MyBTYWx0ZWRfX4tpSNxJvMY1b
 ibZo/uXRQci472DSx3vSSlylF4kysO5KsotLzuacdsOklMFVuvy7S1jcmIR+de7C2fr+/vc0FiT
 yVQrS0S+KqnpjC3AjFa4F8Fq1iqPSFJi3bXjUuq7Cv2pde+5isNkW0vVGORANREEoFSynMYW8vq
 PT5R4ki5UdwzLvzjxkv6tEqDtSw+BAL2pnCLRlzL3P7uev8nTc3JZKoiUUOGvRn3PYNNQ4r0Tvn
 JbBVJJffgD/pH29iTF9iNiIE7HdJupLLSpgmkvHjQtDSwTxQ/LqVyeeceHN1UfUk8ARYdwyQ914
 0UxBM6sg+MiJsYzwZevsNfK86TG9eZpRvl95hPWQ2id17/eQKRi3wHvOPwTazmn+NBg2yciq0BE
 rJgj69uHVRX6OnHK2D0goOaL3lWVPQ==
X-Proofpoint-GUID: XTgCPRFGzEDRsnwcClvjzWy8mXcJJUh6
X-Proofpoint-ORIG-GUID: XTgCPRFGzEDRsnwcClvjzWy8mXcJJUh6

On Fri, Oct 24, 2025 at 03:12:08PM -0400, Gregory Price wrote:
> On Fri, Oct 24, 2025 at 07:19:11PM +0100, Lorenzo Stoakes wrote:
> > On Fri, Oct 24, 2025 at 01:32:29PM -0400, Gregory Price wrote:
> >
> > A next step will be to at least rename swp_entry_t to something else, because
> > every last remnant of this 'swap entries but not really' needs to be dealt
> > with...
> >
>
> hah, was just complaining about this on the other patch.
>
> ptleaf_entry_t?

Well you kinda want to differentiate it from a normal present page table leaf,
but I really like 'non-present entry' as a description for (what were) non-swap
entries so that's out.

So maybe actually that isn't too bad of an idea...

Could also be

nonpresent_or_swap_t but that's kinda icky...

Naming is hard :)

>
> :shrug:
>
> keep fighting the good fight
> ~Gregory

Always sir! ;)

Cheers, Lorenzo

