Return-Path: <linux-fsdevel+bounces-66475-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A3FC20538
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 14:49:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 948923B591B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 13:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CFD721B918;
	Thu, 30 Oct 2025 13:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RjElCyTS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ez8+KVP+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0E11EB9E1;
	Thu, 30 Oct 2025 13:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761831980; cv=fail; b=ciI33F3xhn1idmFZjzXUZp/9wHrvLUFynwWagoAqQtn90E74b0SMeQcI54/km6WLMInXjZy0vjR55vSEVB55ax3erzPyGtocKaNBK1eg+AZXusQttvZLeuScmL68n+0pWJAeE+k1f9kwZNbYD/tqdZpIZDboZv7rgHPGTPwh7mQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761831980; c=relaxed/simple;
	bh=sIO9QI5Q2ya2gdVjFDAg2AF3PENtWSo2If3f+W1IeSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MLNvl78xFTPUSzlELE/ymRweNiVe3zUa5xlMRko56oCHChPNVpp1exv/13X9vy5XRUbhIMSVo7JmbTrv27jDE5a70srmoHZ3RtrnnCkkJtVLHHpDVAoHBtsMDDbvJqy1VpSNxBtjNSVyiyl8gZsk/gQ+OdxDPAU8txVITNex3DM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RjElCyTS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ez8+KVP+; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59UDCKgI019850;
	Thu, 30 Oct 2025 13:45:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=ptEcnKcgIcNXw5i6ds
	bPopNXewUz2bu6bs8eNDGtQS4=; b=RjElCyTSFFxkJ7I2UOh4pGZCNp1p7ZDjKg
	brVAvvHJi/ZNJZbH0M2Kw+LN4BfeFp7ae/yVHcCJtvJ21ZYud53i1D0nY9q99NaR
	myhb0JIgZDczy8Q8RwlHf3vtWTFWT7d87eg+OHejZ4IzIwMrVhNru3Wchhnnvjd1
	yBRQsg7L5l3tlJX9UYhkpBcPizYj+SNbS3saTdrtA8JfhopdlYMZ/w8UuY9hFIla
	iy6KwIkNqkrBDC4v1frIRCPaJVdlVQUKLIil4NQ56mG+0RrH+fVnKWR3w6O5JocI
	tC7PUlxkqeCt8AvGA7EgXcfJ5caQVzW5x/Jvv5ohbXbyaIuuadtA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a48gs83kf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Oct 2025 13:45:13 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59UCtOgv034253;
	Thu, 30 Oct 2025 13:45:12 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011043.outbound.protection.outlook.com [40.107.208.43])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a34edcd0x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Oct 2025 13:45:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qbMSrtpvp/b+U6dJF5JZ+sOTZT3l2SXSiK5OLC2o+9pLKf6/P4VQAPIFf0GSCR1VD6xjuhpWHTOoqSZGf6huQgCbIEFXtMpxs5/ch39YL63fVG8SB28b+A1S1fZecpbemaJO0MqX1rzg4g0HkNmNxfGCZE3ZQ1tyGB0NcCkunEgOGH3kpyEjJOvVS46MyxcgXSOyzHKvOPWgQgy2BtV52tLETswPF4+EUdN3I9r2pJrTFF4TRR2ze54/xUBLza1aLVWv7wAhaV5m+d22VYEOFlw8xKcAGxezV2MJZmmstMUVEJalw1cNYktdvqscBTZxJTslp0IrPyG+t0YRm1f7KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ptEcnKcgIcNXw5i6dsbPopNXewUz2bu6bs8eNDGtQS4=;
 b=f1epafLl6EpW9K6cRzgOk18VBdLdDQHF/Lk8MQFBMHHMo4vIELAXkAVrYXbqKwVWBd7ybLlXq3WOm+v9atWLza321NQS0IaQ1PZggVSMmOhcftt++In0uzodxdz99aWnS67EwZhLjxGxU/bnAWxVyoiqMIEl//BKOmmgLt0kxxUdWt+N61HjUg/ZX1A3KUcqrPGf3F6MEZklAq5HTLTUXMxVb/pHJ6l/7S4aOCXOoR/pREI7ZDoiG5y3rGrHWipDS2jNyxl7Ig3Q/hI8hcKjLinl1p1UeC8WQQcYDYdnIhaxRv/JWwTrSPva64+aruQVI4oTPy9GFJyb0OHk0I5akA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ptEcnKcgIcNXw5i6dsbPopNXewUz2bu6bs8eNDGtQS4=;
 b=ez8+KVP+M4tQZcOADGiuoOrLoGiCtAQ3/Ii7xkU+jwYTK7WDGat2HZ7WF7XcUQaynQhMMly7bN0t78uGi3c98vaeI2BXAoTXMBPZPSMj+M0+SYDX+cjEV49WJqIvxwbrRm22kgN1tQf1Tj1X49C36uPgUzBsCW3WK24tQky/uj8=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS0PR10MB7089.namprd10.prod.outlook.com (2603:10b6:8:142::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Thu, 30 Oct
 2025 13:45:07 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9253.018; Thu, 30 Oct 2025
 13:45:07 +0000
Date: Thu, 30 Oct 2025 13:45:04 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
        Peter Xu <peterx@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
        Kees Cook <kees@kernel.org>, Matthew Wilcox <willy@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
        Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Lance Yang <lance.yang@linux.dev>, Xu Xin <xu.xin16@zte.com.cn>,
        Chengming Zhou <chengming.zhou@linux.dev>,
        Jann Horn <jannh@google.com>, Matthew Brost <matthew.brost@intel.com>,
        Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
        Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
        Ying Huang <ying.huang@linux.alibaba.com>,
        Alistair Popple <apopple@nvidia.com>, Pedro Falcato <pfalcato@suse.de>,
        Shakeel Butt <shakeel.butt@linux.dev>,
        David Rientjes <rientjes@google.com>, Rik van Riel <riel@surriel.com>,
        Harry Yoo <harry.yoo@oracle.com>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Kairui Song <kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>,
        Baoquan He <bhe@redhat.com>, Chris Li <chrisl@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/4] mm: declare VMA flags by bit
Message-ID: <4be39304-6719-4b95-9484-7936124bdb73@lucifer.local>
References: <cover.1761757731.git.lorenzo.stoakes@oracle.com>
 <a94b3842778068c408758686fbb5adcb91bdbc3c.1761757731.git.lorenzo.stoakes@oracle.com>
 <20251029190228.GS760669@ziepe.ca>
 <f1d67c7b-5e08-43b3-b98c-8a35a5095052@lucifer.local>
 <20251030125521.GB1204670@ziepe.ca>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251030125521.GB1204670@ziepe.ca>
X-ClientProxiedBy: LO3P265CA0015.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:bb::20) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS0PR10MB7089:EE_
X-MS-Office365-Filtering-Correlation-Id: 1491b9df-0108-4c86-84e3-08de17ba8952
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FqNTxjCHzBM2KAyw6q5M3GuYqchHrFwxBAsdIZpjJ3lQVTXUkPQluaG6e2Vr?=
 =?us-ascii?Q?ZPoW/AgqZWWuRPFZ8AYUP83pSHnexhqKDf/3vODG8HdoRv3gCM6nFrmUaL6c?=
 =?us-ascii?Q?oXP4xQaPbWr/U4dArGSYJqMRDaXgIBidIRnGmd87WsnjoiRUuA5EJrI04egK?=
 =?us-ascii?Q?iizLJC6sr5Grp/yrNS8RbVwsYRp9jFUzJjq0aeiKdQWrqeiveVtgjBHiA92g?=
 =?us-ascii?Q?nP1rmgL3dqDMpqRx3Ny0LIPfcAGz2yBLer/g4o+SXMB7HMNpcZaTMI4hhWXN?=
 =?us-ascii?Q?HwLrZ8SuMGIbu6vNfNWtsSrpGEIZtXaqo/6vT5fFotsxRtj8Trybw5FEUAJV?=
 =?us-ascii?Q?cBfLBcNWZ2pLHq4Oo37Ln42dwgrTb2pAI1fntUzJ82eMih03BXFOVAyICmCv?=
 =?us-ascii?Q?KhWKLdi3nmwFmXz8wxjNc7MxxE+TrkA1VOuuiZD865IUWFV+XbEINwnnimuB?=
 =?us-ascii?Q?Y6YyGBsD4QeRnDvmhfXdbFiKCrBDaeT5KDL8QVLCioVsu8ZVyZ7lS6gDnP9Q?=
 =?us-ascii?Q?HnoHv3ALelxaFUUJ33M9X44/188GtbVE4o6EKaG8Q/2gYUDbkROF4uSQ8K9t?=
 =?us-ascii?Q?pBqB0/jnwhiQTZe4E5jy4InSfaBggw9oME91Fplp4Tk5+LGKX1nicOCNAOMC?=
 =?us-ascii?Q?S8rU4NydxNguPu7XXbsE30ZQJz4Ua+mgm53R94kFnLzgid0DGfQOTd9QC+3d?=
 =?us-ascii?Q?ljgXBpQNv4A6DdxDduztrsVpj740CRX4AOZpZiMYZuNpy4nVeS7gZ/MZ2M8p?=
 =?us-ascii?Q?HGpbKfIAcfCVqQ+piaGG/xjsLEQQl7OFLzrYIW+JQmPtLH8ZU58siBHIUenL?=
 =?us-ascii?Q?P6rLG5z1Y3X3gK8pygf2hpF4UMkx21ddL2OPE1YdJEwG3vwxmGIwgrgo8Q81?=
 =?us-ascii?Q?T5eWFCoDGLC5H1CHwEpIOet3UWJF77d9vqBzACl30qIYNhjsWuovwftlb5Ea?=
 =?us-ascii?Q?d7DrVhdxN0eOsVn01IFpBYvdGBIsoCuNG6pDuRtYx0RVxJU4+gb6Ko7YKjRW?=
 =?us-ascii?Q?OUbCs4LJAm64QxS90Bg+OoDENYf+VRTSVK3FUCRxtmmD8smPHJcttqOocsKF?=
 =?us-ascii?Q?PfKKFmOPXDK5Ws2wOXuXlYRpU4G2l21ZFSLTuBjcSqIOraCVq5w7bMibUYYI?=
 =?us-ascii?Q?31Q7Ip/lFiYccM6IVywJllHUEYehOuGQ4uCGtPB68W9BD/JBnz1hlIKjle+s?=
 =?us-ascii?Q?HGhfsTHm8arusrUGxKd0QgThpE4dql/ow9oyAf/bQhChN1zzZyPqUsjuZfYq?=
 =?us-ascii?Q?ZwtcslCGxeAljy6Qd1OiMENF9fAHybvQ9GDXKT6ELJjGZxg5q9AcLQRNCHqV?=
 =?us-ascii?Q?H9iv4cdnxkBhJGy9W0RlojxE58u7aGS/mERnwoKd9qL24hLqy6g/8t5BjSiE?=
 =?us-ascii?Q?uPe314XNJSmgnmafD+yDpaWZV4ZpMjfJzyu49dkpHzTdebPRykwBt4M4XpxA?=
 =?us-ascii?Q?xAzwkVJDPF5zd+S7FW8w46e3RSIwmLme?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4E/Yk4oFYGeViC6FcLUvgOioeP7J1aJz3dhz7j4nHNHThWblWOJt9A+tvn04?=
 =?us-ascii?Q?Untjt/SmljzCG969pkHecKzURX5agKvD6FoTjycNZWxY4J9JABUO3xg2CxcD?=
 =?us-ascii?Q?D6FmvTfC2Lw3ryBq86fULZNfzK9LPtKrDm5VDs+FKuACIYReV0uLqV2LR2hv?=
 =?us-ascii?Q?cNB0gs7g2JgyHAp1HFJr6nuCmPWKyeR+D3cDCCNLXV651zpoP8U9+mXgYCbo?=
 =?us-ascii?Q?h9d/oMLGp4Pk068GC/FLfuJeelKufNgZhxTV7TaC1oh80hnZqCbbKlhN2oYK?=
 =?us-ascii?Q?CkmUo3e3Re7hWdb6CRaA0v+UD97lSJW9D7z/Ythl4wlvUsGvtWQaPvDaRgM7?=
 =?us-ascii?Q?CSu4IVBlemXEERiuj+AodW/ebRUXoYpU92XQ5/C+1FRpkBwaNFs+Q7aoOec4?=
 =?us-ascii?Q?hkFEsx0Ywnshb3kf8C9WCGGGd1zMkc2gbX8CmAb9OooTfNXfzhqaMSaiF6ba?=
 =?us-ascii?Q?WpVOlNH8vm3BG1DalkRASo44A1xW6eC0W/XDQv90oVKDyciF1TjezrV9NSRO?=
 =?us-ascii?Q?Mhzuo27nfW9yIzB8eazO5AoAUKR0D456dr+49Xyl+NodE4zsVMVzJdYQU7eX?=
 =?us-ascii?Q?+Kor4t9YNpqJkfxOcq5IrJIOsSpSlzUsi0+cXlXwaupBeYm5tq1egLW1TFK7?=
 =?us-ascii?Q?5wTLtMaYgpEkd+jjIVMKe4xQBRafgUXZR/Eytp23PGVxbUQjdZyRedpdaUli?=
 =?us-ascii?Q?uNt1+O3FfN9YRVyS6FYSmjsNUXB8cyOE2ZlVydnY/+tl/+S92DE4S3IclsZA?=
 =?us-ascii?Q?4xIh/fn3KScF0W7UKg5PJ5o0VibV4WYnLapxUV68BxMfcCCGnciJLeeQ4Z7s?=
 =?us-ascii?Q?zeEM52CCet5rVcGiYEdZQPb9WVHYRUKAFD28621H2qiDr+YLNJFTjnBlybKs?=
 =?us-ascii?Q?PRF0G6LsYIDil2b07D3JWJgtC4cD6pl7IrQyLccP6+iIHwYo5utA7WRwCGAx?=
 =?us-ascii?Q?ejBEHH+whtzzMSBEJfrkHaqnpY8D71OAwKkkATrKTtHWJ8k6jIuS80cyyAT/?=
 =?us-ascii?Q?Tte+4DFC8IWgT/nJLM4Abw+PFxSNGJYcyBObMEcejfZjR+ACloP1MUd2D4LT?=
 =?us-ascii?Q?JCKo3Lq7Ej378CDfJIs/nDbIaHfFH9UeeHheAzCxFN+1XYPwDjdNawSxMmuF?=
 =?us-ascii?Q?Abl8pPfP7aDhWXV6E7x/TZ9oWlM6OquqpSa2p343QJaM8whZ7yK9CuMZ262S?=
 =?us-ascii?Q?KcP0qmhMJ2qeMS56fjeNIgGUbM/fTAr+n70CJClySGZwA7s9V1HjWCr59Lil?=
 =?us-ascii?Q?vdTQWZGBqg0AKrhWgMupKXUl3e/FXEgwiCfXjqz/dqowI2Jg6tzlpq+VzxIZ?=
 =?us-ascii?Q?wwAygY8+2Jb/wMYpf3alHjYgmtGQmkddt4nM05aw7ryCMHaUcSkyr90wSZj3?=
 =?us-ascii?Q?+Nv/Czy3kq3PE4DXBW/PklsX3mCniW/T0C0VbYwygqowpG7T9FWKFbZbTqmY?=
 =?us-ascii?Q?JevVq2XjXLPJRob59m1bEAWrszpbrUeUi69AJzTu3D0V1sD+wZzJdi4BjxKV?=
 =?us-ascii?Q?Ib89Mdvl8XI9ibxPhh21+pbCfpe95uouwesCi8Z1ERWn0LMRTyXKaHBpT8LO?=
 =?us-ascii?Q?XSS3nOwDKPPFqaLGCFME90H2VgA4ZP9+iwUlbYqZACsWy/hmOStcyXOHNZ41?=
 =?us-ascii?Q?hA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	I1PfSbUeE1HY+sSz6CT9QqN1JRt8Dl+KA5/QpeXiT68F+nomq/9IbBy5BxZjqlmBFGkfmCh7GPkAoDy+vuUbb4mVC57FRzmsLZ5wXbTVD15G/ZUrFKSkrekKIec4q9H7Kb4GjMtmHUKlCGFhdILQ5URF5qlY0w4SCrvDfozkDMOYA9J7kIOHduTg3s3m2ZmdR8Xb6TJ514mX5xkE4HKXW8eEKVWAJE1jIJLsafYwFmQ1xbu8v2a/Y2uDzSjpLgsPBB8Vmt72rfAre480XVbaJ/m5zOpSwGI48Yjm9h+2pBrmOx7ABczMGSplSCznz/c6j8hCh2/j0zJtz8KS5M1jlUfL2g2S1hUEHa2XMVfCRIq1Z4M3Tf85OcrcJOCESZij7xlMUlhhLzIfv1OpO21tUFiJDRu5R8fZEuzX30lH33WYih4h+/rwfxhCkt6FWeuYgjQx/OXEgFejstN8lfaXXZRxc7sxxpeHE7QmYAFkLwmHWyNshMWWfqE0XnIQN1zUh1iGYUMZx32XwR8NdP+BZxTZszmhtuup16SDs7H2w9XpevXrnZPAKMGD5a6bdtVsZqNMir9GNpjPkhg7alMCdOQ4vKOzWb7G6CRfS6uAFNg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1491b9df-0108-4c86-84e3-08de17ba8952
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 13:45:07.0255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4lAXHsvHPbgNhHWjTah2sBEqshl0iLP9gRIaD2MjmidufrvA5XGXiwCc1Qw4/M/m1OubNDBomR1KZ9KDmmHUXQ+JAXIxyF1BzrtdJowzFjc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7089
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_04,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 malwarescore=0
 mlxscore=0 phishscore=0 mlxlogscore=915 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2510300112
X-Authority-Analysis: v=2.4 cv=c96mgB9l c=1 sm=1 tr=0 ts=69036be9 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KZyhuud8GAxWFf9lls8A:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13657
X-Proofpoint-GUID: 5-6WMY6xaD3xdE9_ZX_9J29wBajxrdWz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDEwNSBTYWx0ZWRfXyY2x/FzmQn55
 J4S9Y3dkLwYgOmZgx4xLzQpMOcF/e1BxHV1TPNg9p85r+/t0/cExE2LwQ/mt+4ldUm61IRxAdyB
 96PG6tvmTK2GdBWEq/Ea69YQXsNeB2zDPVezEHaoqfiCswRpkQUNcOE4KRzTYPEmUCGInS6cKrj
 rGeuVwBzE/4JAOFaMqUQyFjA/k8/wcHxfLa0xUv2ZKZ+txLiZvG77NcjAY+fDmzCXuDQlZg+tQq
 BNsP1DMilJmrsePZ/j2384xUkByrxYh0dD1O0TzREEvUAWQSqX2K22vSzDfJ5zjlc6/FN/mKSvL
 UyHMzT5nLnQQI2YGGl9Egg50GJXeyImoMnaPghgCKmfsRHavDhnhbYoEtBKeuVY8xNRjsQICqaL
 wQGpL5xVkb/+PG/63lkZCX/IbCs/GrucL6r6a8JGXFPhrnW80FI=
X-Proofpoint-ORIG-GUID: 5-6WMY6xaD3xdE9_ZX_9J29wBajxrdWz

On Thu, Oct 30, 2025 at 09:55:21AM -0300, Jason Gunthorpe wrote:
> On Thu, Oct 30, 2025 at 09:07:19AM +0000, Lorenzo Stoakes wrote:
> > > >  fs/proc/task_mmu.c               |   4 +-
> > > >  include/linux/mm.h               | 286 +++++++++++++++++---------
> > > >  tools/testing/vma/vma_internal.h | 341 +++++++++++++++++++++++++++----
> > >
> > > Maybe take the moment to put them in some vma_flags.h and then can
> > > that be included from tools/testing to avoid this copying??
> >
> > It sucks to have this copy/paste yeah. The problem is to make the VMA
> > userland testing work, we intentionally isolate vma.h/vma.c dependencies
> > into vma_internal.h in mm/ and also do the same in the userland component,
> > so we can #include vma.c/h in the userland code.
> >
> > So we'd have to have a strict requirement that vma_flags.h doesn't import
> > any other headers or at least none which aren't substituted somehow in the
> > tools/include directory.
>
> I think that's fine, much better than copying it like this..

Ack will give it a go!

>
> > The issue is people might quite reasonably update include/linux/vma_flags.h
> > to do more later and then break all of the VMA userland testing...
>
> If only the selftest build system wasn't such a PITA maybe more people
> would run it :(

This isn't a selftest thing :)

So it's literally:

$ cd tools/testing/vma
$ make && ./vma

>
> Jason

Cheers, Lorenzo

