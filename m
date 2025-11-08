Return-Path: <linux-fsdevel+bounces-67542-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5166C430F6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 08 Nov 2025 18:14:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B1CD3B21C5
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Nov 2025 17:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345E2264F96;
	Sat,  8 Nov 2025 17:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pfhozLsY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="V/R4nPKW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F4E145329;
	Sat,  8 Nov 2025 17:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762621876; cv=fail; b=g8S3ztnWg+J8ELxY9iXle/z346TIuw1tlKdZcdOEso9qmYL57UKRCUMwV7t1Jkx0uLPZjaGGunAhpE2eLird+fDfNsmSb6HQU4bPCF4jVQ9Um/HG8vf9Sd5Eu0xM3RQaMClwB9/i5VthGvZNjox7tCikhX/U0GH2aPVz40wEHq8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762621876; c=relaxed/simple;
	bh=POgjLibdleyIT97aLcMp4rGu38r3SsMhgSVUA/LXdP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZG3Za343Yukw9sQqthHoojQhT4T4TFLojuuC5+syzbmQov2/5V9Sewqb3gVCnh+9hFu2d2pC0TmgSuOzSgZZQ93ar4lMr8ki9+xEoRrDr9kGaxm50xSrtji8xx+EVm7FS9G6hZ/9wBXKbMULL/ERT35mriLK1veQlG2UN6eitII=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=pfhozLsY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=V/R4nPKW; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A8GjT51017275;
	Sat, 8 Nov 2025 17:09:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=hnulhczD3XQkqRXiu7lNvxRJz88HMl5Uk5p8sHNK2Ms=; b=
	pfhozLsYLuo5vUIzEyhlrv/2tuKzgVI+sWy7TWDNIwMcj8FcFGwdBzC9FfdCMlAg
	Ghcnewisojj4R9RtgxT+0/VjMiIchW4pSoild2sqftMWCnDALKJOSzoSjgI7UkIN
	1umpU3hvjUbOm3lCOAfs7bXx8yYMDT76CALjKFiZVmqmvUyxm7XOO5kri2wLgkQI
	ZXN2KMGHuypkQnYk4VMbdNKyfoUllEGYPgKmPhYlUDLj5d3uflpO67kZVQD0nvYB
	coMydkb72+6pa98+bIEXVqDKUTvFUJSTtJDvX0+NnHw8FXY/sXrKGH8TIrA6GMVg
	0knC3gFh0n+64GXB3Jb59g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aa8se01uw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 08 Nov 2025 17:09:25 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A8C03c9007618;
	Sat, 8 Nov 2025 17:09:24 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011047.outbound.protection.outlook.com [40.93.194.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9va76n25-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 08 Nov 2025 17:09:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IYdhFT9QsanE2SrngLg//h1qLd/XQJjKb7rZfpmvvXHTolXMsrnQtXLmBsNmUgw2bTkmnijq08hPGTDJZePe+oGTv4EHjwpPJoocyTCPXi/XbmJHaQBfkhUwYKfnl2wmtxf46K6NlpLFfxPFqWpgbhf+xctzX9PC0U3F6u7+P9uR/MmC5pQBCQvTosY2NNrij5w4g/ZGVtLsSuw2jlDIybSB6S/FuJWCwDwzyGFyWXBdgfgTRP0XFkQWE2yz0bLUaTooieFCFJwk9Lsi9vApS5oQ+FQNQNbkBQlRZg/mM095nwxaGEnSLhMsuaF9PoHiFpCpT5Txn+55oCPDl6fMig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hnulhczD3XQkqRXiu7lNvxRJz88HMl5Uk5p8sHNK2Ms=;
 b=SNCl66Y9m5TGc6Uck/oosQ4UA79V84eLUKHsoS4apkI7/jyRt4IcAwlapvb4e/cEIojYrCWQzPOiXcHk8rpK6jc8/HPqukeIQ2jKmYUHeuabG9va/s/fTbCvp+e5pH3z4TbNFj8W29cU0FL+CyEAJ6s3ZxwO3lT9asyvqyGcxBKrcxaMVPwR2Vb4K5yrBGXnlqyJo9TL8oDG55EAd0+pLMbJkuTCyZuccCvakTCmjYScl/3B3G6fZRUg/2D1DZ8OSwzN3xDwTNy+HBRBtL3CAPBEVgvkhCfQm8GrAGuD4CdUmBI4rzDAMCdy4a02XHcuGFoULgnDKrTTQFIxw5HlkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hnulhczD3XQkqRXiu7lNvxRJz88HMl5Uk5p8sHNK2Ms=;
 b=V/R4nPKW9D0P92YB7zoJJ4mzcTvjU+kx0aH/iKmLv6f4rukkwi/YzHCoVv1ov5hkAFhT8/fS7y+VKfNrrcGyNrr6Q1UaJNkRf+Tv734Tbzlx/yNYGhKjCEOJXA6eMaYUuYFVXg1V7bYObL6HiRyZs6Z+G463O/+2vdEq0kB8PIs=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ5PPF04D2D7FA7.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::785) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.15; Sat, 8 Nov
 2025 17:09:21 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9298.010; Sat, 8 Nov 2025
 17:09:21 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Peter Xu <peterx@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Arnd Bergmann <arnd@arndb.de>, Zi Yan <ziy@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Lance Yang <lance.yang@linux.dev>, Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Matthew Brost <matthew.brost@intel.com>,
        Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
        Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
        Ying Huang <ying.huang@linux.alibaba.com>,
        Alistair Popple <apopple@nvidia.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Kairui Song <kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>,
        Baoquan He <bhe@redhat.com>, Chris Li <chrisl@kernel.org>,
        SeongJae Park <sj@kernel.org>, Matthew Wilcox <willy@infradead.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Xu Xin <xu.xin16@zte.com.cn>,
        Chengming Zhou <chengming.zhou@linux.dev>,
        Jann Horn <jannh@google.com>, Miaohe Lin <linmiaohe@huawei.com>,
        Naoya Horiguchi <nao.horiguchi@gmail.com>,
        Pedro Falcato <pfalcato@suse.de>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Rik van Riel <riel@surriel.com>, Harry Yoo <harry.yoo@oracle.com>,
        Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, damon@lists.linux.dev
Subject: [PATCH v2 11/16] mm: introduce pmd_is_huge() and use where appropriate
Date: Sat,  8 Nov 2025 17:08:25 +0000
Message-ID: <5a8bfdf0f2018c3fa3b10171df7cab469dd3f259.1762621568.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1762621567.git.lorenzo.stoakes@oracle.com>
References: <cover.1762621567.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0506.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13b::13) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ5PPF04D2D7FA7:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e03f98a-4654-42fe-dfc9-08de1ee98eff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rbf8wLMMMBW+My2lJwQVN70GNmFH1RP8V8OdLI4xet0fwIIU/ulg4nalQ3QL?=
 =?us-ascii?Q?/QdMnLvTl7/YaVdMmgm3P4Nl4hZn0RuVkNjx2t68KpYFG9sw54kJiGaiMLl1?=
 =?us-ascii?Q?dWVTrzy15yCg0sHH7JdHiEd1XDHji7K1fAPwOWyHVuKuDEpOOCY7+ERn5RA/?=
 =?us-ascii?Q?oeIMtSHXO5LeGRlKh+kEF+FB7N7vue/xFB6N69Oww8LsFluXhtVTwuu0ecwH?=
 =?us-ascii?Q?s/3o0Vo5oGJ95NkL81UhJFX0z9kcyizgkA+bAd/sSAp1NMJhLX7NUZH9+n8l?=
 =?us-ascii?Q?/uO/Y4Lws/gVpE79m3+2Hgv+/hZQ5R+ldTTyDzVKmkBi5uJM8AYUqt+BIFyP?=
 =?us-ascii?Q?EafSX6tsE2wnDk9F+ClNJAZmV4g36hvUoTcGrPFsAo+1WTbHxfflqJtL6O3Q?=
 =?us-ascii?Q?6JaT8FhBKLDIGTCSCV+MUwxRXPyvhlEUnwhI9LL7AQbDm+vK01HzvjtWPlzn?=
 =?us-ascii?Q?yHotZmVYmNDxZHoaDSpM5lG3OY5XuKOkKeSEeRbZfBHoeJcOQEL/gS+09B9d?=
 =?us-ascii?Q?NEbEP8waJCucqYLznKaOoV1daQOboGXg5XvgqOm222Z2xnr2qCmOYZI8t9d6?=
 =?us-ascii?Q?fgxWTa845k/sqIeGd3k8xfVyzjzD5T6gfutxlkTxn6CoPKL6S7McDPJwg+H7?=
 =?us-ascii?Q?ZS75bdc3SIqQWooEfoeEEkEARltWamqlTWhgSuvgnt1he9OvjR4Yyhay9rHV?=
 =?us-ascii?Q?l9jwnimwgAlmBDZxdsdK52rWPE0kS5vZZpwQFDjWEny1170Vc88ghr0UeA+D?=
 =?us-ascii?Q?L2vgfLFzchx3h2ZMtdYhNBcP4AqHeaDLfjxkE9HOc/fYBLHDLaZc72iyKZvg?=
 =?us-ascii?Q?MiCFxMv1E20xMb2Dm26gAK5CNiJLPtmdPCDDbuwXEh+VzvJQ1xKLXMp/wlaf?=
 =?us-ascii?Q?nmpnHSeHX22k7NPy/3XSZHSDycXINorqn+e1zJOwCuA0ti1xiC+1vcbCoLXm?=
 =?us-ascii?Q?MaREU82B0nRqvyTqbAKscr+g5amK2d8tU/6/ogjoaPdEOZYZpuZh6XFx4Pyg?=
 =?us-ascii?Q?S+R17h2exVs+caCvlBE9TVai+Eg0xbz4yS2c8iFv0sbkvSLWz1AHec5IKIK4?=
 =?us-ascii?Q?gEYkKvGwKgdYoBqnIsRGCXLw0Vnycuzc/CzVQPfyf04sqZgyCI0Y1BRUtIGe?=
 =?us-ascii?Q?S+1lXyPaldEwERjyi6mmmSererTtDxLAqX+kgFpNef+lGDwCTcg2r9Zr+V5w?=
 =?us-ascii?Q?Ddn+ucQD7qvkDdeR43z3pg/EHVPD/hsGtQZZ/ldYggbcZO6IxHbk+OCgJR+J?=
 =?us-ascii?Q?ophycb/FgqkHqr4mSvdRamO7avjs40erJjLxUhfl4p7bHT/54BiJZnjg1h3D?=
 =?us-ascii?Q?FjonTDaIl8SdjyASrvz9eTNZGm50JR8sDqSXUhCsuWJDMMjT/79vHnYeKxMX?=
 =?us-ascii?Q?MJjmGb3we2z9wbcn8dQGfbQVAh8cRUF8S4guY4CLnf277IuRKpQ7kCubWvOB?=
 =?us-ascii?Q?Xsbc5A3Ob0BMOVotcME8fVp9DXpArqIG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZU9sPq5jRt0GpqdJ48hcI0EgB1GqMQ8uhf/pY7DDn/zC6DnYHjRE63onyLZH?=
 =?us-ascii?Q?iYrcHZiiNsJ8zLwn5OQ8KJCQI0SVs+JHU2VwIBFyyzcgMZo+ZWjcrj/ZwvmG?=
 =?us-ascii?Q?D1Zve50VAuivRZfKf8mME/rzbf12MWEnjSoLDrTnFJou6/SBshqH3mBHStci?=
 =?us-ascii?Q?9ztF4uyQFvAl8NJLWWMQljTdQZcjtyugQskCwY/jUHJ02CvJi2GLOUyJuibq?=
 =?us-ascii?Q?O1nD2bDq/qZ32yiKg+WGA/fhbynJppLAvjOkhfdPg28eEymdL7NhwJxwovnv?=
 =?us-ascii?Q?tPC4tJKRTCTpDziCVhLdl52w4VvpII7yUptgTLg6U9uK4xc/jDVwDczm5Nub?=
 =?us-ascii?Q?uCsRjR5ApN1NwaKibnRpp0yKAmPdkS8Zn5VKNPE2dcPd9z2z7i7/kGo2hLSV?=
 =?us-ascii?Q?GiWI6auDf4r1Bwab+cgxv+edXSBg2PGKE5atULPJXroUVs1zJ+1qdGFEqjY1?=
 =?us-ascii?Q?8x8Em3Z7GPS0zVOWLJU5m1XXTr+5GN50Il8TIAwkbv2D0RQTgGYBg2x8ThAt?=
 =?us-ascii?Q?/piMStP2wlLBZ/jLHhDF/2UaZVZdoyzLCgKHzSzkR2MOsWH/kDo0A5kXyqmr?=
 =?us-ascii?Q?pKIFQMj8gFnaBAukF5W6BRW+NqdiX/YcXIt3UsIvu2eAO/mKTMzM5M43fpHy?=
 =?us-ascii?Q?X5ZxhPB3IR0uox2T+AR6ZSoVErU8YFfee0tTQgR0p4QBYk4k4XGQgZClumUo?=
 =?us-ascii?Q?uogvsIz3Dejlhd19P+QGnIqs2eo2V3Q5PUtjLLsLjSKyOPQD009NnhnEgrGt?=
 =?us-ascii?Q?r+VP8DoStyXb0H2RGkSchVkPsayuogZ0+yhPEuFD1bhNeS6ecLUDxiUN7420?=
 =?us-ascii?Q?5YFAIPUItx51uqK+DwptaQ8AyRH1WjpT7/9QW7Q+IiXk6gfLNE4HQdWbcYyF?=
 =?us-ascii?Q?kLLWWxTm//4Pgaaiih4etT2lLFy1JCDPxJn16hFEXgJ2GO2oxMfvjQiQVTCJ?=
 =?us-ascii?Q?YhjKE7hBlUpy6kpq/G8QQIBnEuB/2L54K4QLB6OcMG5zTsOW8g4AHeu19BNB?=
 =?us-ascii?Q?AqeOwztEI4q+8EQZNYpABzGPQ4nCaFAYlP4ktfuHF+sDNnmgEfi18tjHFY8q?=
 =?us-ascii?Q?qsPB0zc4muyHO0zA2ytBVuWjIRPBmQet4sF0xoJ9VujOTdEa2Sfh3modIPH6?=
 =?us-ascii?Q?v3SAgHNV7R88yXvxBBRQGDHdjtDq3ayptfVDfgchEjwKv8Ut6EoENjNuiOTN?=
 =?us-ascii?Q?pGmosR8+eC7vFjCabNdjaHwuMmVHuZT8VqEdU3fyhXBzFfDJLxWGFAVjFryE?=
 =?us-ascii?Q?YzIrbhHXjaHX/zQWt/QJN2tttlnJ361DFz1XTmOurXSz809O4M1Cyi3GYruK?=
 =?us-ascii?Q?wEKIo8U/GWHlKOR49HV8PMJdg9oS1NSGTUPYaCSfKQ6QfWhQ0IdRpV+fGt67?=
 =?us-ascii?Q?AxymEn1B195pV/RSndyK+iIx040ZGPqUzqreQl03j1LArw213kL6WbwV1y5u?=
 =?us-ascii?Q?c9Cbf0tQ5VgbTQ66U9YVFR/7YsMCuh3yUuaosuj0aGaYQupaYSIlGvVTGquu?=
 =?us-ascii?Q?AcVd+8/wtaZGREsfUTevcDv+pfs1Qjp8tTDJVqqeI0ORSTFmWd4NCpBGCDZs?=
 =?us-ascii?Q?S06/sNjwEa/LK/CQCGDtlfyhi4oLM3W9Q/8hmoAt5gJNd4hOqZCAnyglYup2?=
 =?us-ascii?Q?pg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6wcwAg+sKr1zxBqOtVcFFLd6U8fFaBDkOrtaveWb/BJ6jpTn9P6FC82PQWRr0yfck7tdkTqWTnd1d0Y4g0CxaAhsSbiT1A+m55yA0dGqGXZ5FKK7LTNoQTgCOiLsoXkrEyi96WH2bElJY5krByoYcxheP+ruSb5S8wl7YZQuAvXRzKtens5HoZamrYPIGUeuH+bAa2B67cPZUls50r37wX9wlxqvSFoiKJ3kq+qTNVm3jjEhkAehY/guLbvz27H7xK5696cPxKzNHijHUcItxqpcZptQnhbJz2fg5ZE22DESFOHWIJJyxqcVYFyC66YvtUA0T+K53b6/sFmfhDDg13enRmViVi8m46mvO6V/+ClLXEgsemnDal4LBvyG4KLyE8y8gjjK1FrK7W1oAfVxCZGgPuFj5TDxFd4kA6N8NANy8V2aVXmfn1y56+UgYzdAPuSQiqM7/iPruoLvb2XcP3Pg5i6/lvGFCuFSKNvImRPIawzZLqmPwApK3YqMBshvMLvILB+Nxzn1eSH3X5dWRiW0iNbkTBj395UptsNtdl9FRZITFSxYfrYANoEtukuUSF/IoUA7woswhT5JdLamANAeA7biMYLUmOc5ETX+4gY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e03f98a-4654-42fe-dfc9-08de1ee98eff
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2025 17:09:20.9921
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6V4QfnCfNAeNz94PsHDVTnjLrYGjkbFdYNnoEx2q1pSeSSTdA8jbJ0TmNUY1q7KRsd3kHifH/MGjp8Lx3DMNKGmjlLjF7epDHCm5iMOyJYM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF04D2D7FA7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-08_04,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511080138
X-Proofpoint-GUID: DrJQDBfU-FVNg-c1Usy-vIdkmo5-2bAl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDEyNiBTYWx0ZWRfX0ywOzvtA43nV
 YCT7PDqxPWFBIGoSJ/1igXzH78/w8G12xHJv0BDNERyntRhVxTVTF1hJOwQG3U0iEir4yL2Eubh
 eZvVekzStiz66dAXkHOvhK0LD+Tn8dgPBSB9KhdLabjJ95vL9iZsCMTD/8TngP9KaZiOYTARQTV
 IDZoLATOibbjYZX85VwlT7+kpeBIVTXkxjARFyMMcaVmsV4XGJiFoOtgYXVrQifhuHofVi4IsJU
 s782xcV2lOFrQUqeu1kS9+N/OQbcijtxWtNmON2BqF0zcPuFJOQDit2phSklTjCi1EsNEnkvtf0
 fjXM1A+440hlsFKfjUQrBQwiJmh8+sfhGsg76WFjdYhzaQMS1EvEtRGw13AE6iAdxVjgxUfeEaV
 FoIM0kSp4RH9yXiBy8/f+Rw6ZW9U7Q==
X-Authority-Analysis: v=2.4 cv=XuL3+FF9 c=1 sm=1 tr=0 ts=690f7945 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=Z_ABK6pF82JkGIUUY4QA:9 a=UhEZJTgQB8St2RibIkdl:22 a=Z5ABNNGmrOfJ6cZ5bIyy:22
 a=QOGEsqRv6VhmHaoFNykA:22
X-Proofpoint-ORIG-GUID: DrJQDBfU-FVNg-c1Usy-vIdkmo5-2bAl

The leaf entry PMD case is confusing as only migration entries and
device private entries are valid at PMD level, not true swap entries.

We repeatedly perform checks of the form is_swap_pmd() || pmd_trans_huge()
which is itself confusing - it implies that leaf entries at PMD level exist
and are different from huge entries.

Address this confusion by introduced pmd_is_huge() which checks for either
case. Sadly due to header dependency issues (huge_mm.h is included very
early on in headers and cannot really rely on much else) we cannot use
pmd_is_valid_softleaf() here.

However since these are the only valid, handled cases the function is still
achieving what it intends to do.

We then replace all instances of is_swap_pmd() || pmd_trans_huge() with
pmd_is_huge() invocations and adjust logic accordingly to accommodate
this.

No functional change intended.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 include/linux/huge_mm.h | 39 +++++++++++++++++++++++++++++++++++----
 include/linux/swapops.h |  6 ++++++
 mm/huge_memory.c        |  3 ++-
 mm/memory.c             |  4 ++--
 mm/mprotect.c           |  2 +-
 mm/mremap.c             |  2 +-
 6 files changed, 47 insertions(+), 9 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index cbb2243f8e56..403e13009631 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -419,10 +419,36 @@ void reparent_deferred_split_queue(struct mem_cgroup *memcg);
 void __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
 		unsigned long address, bool freeze);
 
+/**
+ * pmd_is_huge() - Is this PMD either a huge PMD entry or a software leaf entry?
+ * @pmd: The PMD to check.
+ *
+ * A huge PMD entry is a non-empty entry which is present and marked huge or a
+ * software leaf entry. This check be performed without the appropriate locks
+ * held, in which case the condition should be rechecked after they are
+ * acquired.
+ *
+ * Returns: true if this PMD is huge, false otherwise.
+ */
+static inline bool pmd_is_huge(pmd_t pmd)
+{
+	if (pmd_present(pmd)) {
+		return pmd_trans_huge(pmd);
+	} else if (!pmd_none(pmd)) {
+		/*
+		 * Non-present PMDs must be valid huge non-present entries. We
+		 * cannot assert that here due to header dependency issues.
+		 */
+		return true;
+	}
+
+	return false;
+}
+
 #define split_huge_pmd(__vma, __pmd, __address)				\
 	do {								\
 		pmd_t *____pmd = (__pmd);				\
-		if (is_swap_pmd(*____pmd) || pmd_trans_huge(*____pmd))	\
+		if (pmd_is_huge(*____pmd))				\
 			__split_huge_pmd(__vma, __pmd, __address,	\
 					 false);			\
 	}  while (0)
@@ -469,10 +495,10 @@ static inline int is_swap_pmd(pmd_t pmd)
 static inline spinlock_t *pmd_trans_huge_lock(pmd_t *pmd,
 		struct vm_area_struct *vma)
 {
-	if (is_swap_pmd(*pmd) || pmd_trans_huge(*pmd))
+	if (pmd_is_huge(*pmd))
 		return __pmd_trans_huge_lock(pmd, vma);
-	else
-		return NULL;
+
+	return NULL;
 }
 static inline spinlock_t *pud_trans_huge_lock(pud_t *pud,
 		struct vm_area_struct *vma)
@@ -744,6 +770,11 @@ static inline struct folio *get_persistent_huge_zero_folio(void)
 {
 	return NULL;
 }
+
+static inline bool pmd_is_huge(pmd_t pmd)
+{
+	return false;
+}
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
 static inline int split_folio_to_list_to_order(struct folio *folio,
diff --git a/include/linux/swapops.h b/include/linux/swapops.h
index f1277647262d..41cfc6d59054 100644
--- a/include/linux/swapops.h
+++ b/include/linux/swapops.h
@@ -471,6 +471,12 @@ static inline pmd_t swp_entry_to_pmd(swp_entry_t entry)
 }
 
 #else  /* CONFIG_ARCH_ENABLE_THP_MIGRATION */
+static inline int set_pmd_migration_entry(struct page_vma_mapped_walk *pvmw,
+		struct page *page)
+{
+	BUILD_BUG();
+}
+
 static inline void remove_migration_pmd(struct page_vma_mapped_walk *pvmw,
 		struct page *new)
 {
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 5876595b00d5..2f0bdc987596 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2810,8 +2810,9 @@ int move_pages_huge_pmd(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd, pm
 spinlock_t *__pmd_trans_huge_lock(pmd_t *pmd, struct vm_area_struct *vma)
 {
 	spinlock_t *ptl;
+
 	ptl = pmd_lock(vma->vm_mm, pmd);
-	if (likely(is_swap_pmd(*pmd) || pmd_trans_huge(*pmd)))
+	if (likely(pmd_is_huge(*pmd)))
 		return ptl;
 	spin_unlock(ptl);
 	return NULL;
diff --git a/mm/memory.c b/mm/memory.c
index bf2bbd0dbc97..087f31a291b4 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1374,7 +1374,7 @@ copy_pmd_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 	src_pmd = pmd_offset(src_pud, addr);
 	do {
 		next = pmd_addr_end(addr, end);
-		if (is_swap_pmd(*src_pmd) || pmd_trans_huge(*src_pmd)) {
+		if (pmd_is_huge(*src_pmd)) {
 			int err;
 
 			VM_BUG_ON_VMA(next-addr != HPAGE_PMD_SIZE, src_vma);
@@ -1923,7 +1923,7 @@ static inline unsigned long zap_pmd_range(struct mmu_gather *tlb,
 	pmd = pmd_offset(pud, addr);
 	do {
 		next = pmd_addr_end(addr, end);
-		if (is_swap_pmd(*pmd) || pmd_trans_huge(*pmd)) {
+		if (pmd_is_huge(*pmd)) {
 			if (next - addr != HPAGE_PMD_SIZE)
 				__split_huge_pmd(vma, pmd, addr, false);
 			else if (zap_huge_pmd(tlb, vma, pmd, addr)) {
diff --git a/mm/mprotect.c b/mm/mprotect.c
index a3e360a8cdec..ab014ce17f9c 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -474,7 +474,7 @@ static inline long change_pmd_range(struct mmu_gather *tlb,
 			goto next;
 
 		_pmd = pmdp_get_lockless(pmd);
-		if (is_swap_pmd(_pmd) || pmd_trans_huge(_pmd)) {
+		if (pmd_is_huge(_pmd)) {
 			if ((next - addr != HPAGE_PMD_SIZE) ||
 			    pgtable_split_needed(vma, cp_flags)) {
 				__split_huge_pmd(vma, pmd, addr, false);
diff --git a/mm/mremap.c b/mm/mremap.c
index 62b6827abacf..fdb0485ede74 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -850,7 +850,7 @@ unsigned long move_page_tables(struct pagetable_move_control *pmc)
 		if (!new_pmd)
 			break;
 again:
-		if (is_swap_pmd(*old_pmd) || pmd_trans_huge(*old_pmd)) {
+		if (pmd_is_huge(*old_pmd)) {
 			if (extent == HPAGE_PMD_SIZE &&
 			    move_pgt_entry(pmc, HPAGE_PMD, old_pmd, new_pmd))
 				continue;
-- 
2.51.0


