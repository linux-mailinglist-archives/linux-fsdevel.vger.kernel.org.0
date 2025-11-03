Return-Path: <linux-fsdevel+bounces-66758-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 056F2C2BAE3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 13:34:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A19A3B71F8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 12:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3893F30C62E;
	Mon,  3 Nov 2025 12:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DpwSdIll";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="g/AbZyAO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D6330AD1A;
	Mon,  3 Nov 2025 12:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762173194; cv=fail; b=HbTRLkUly/7fPJCnVOBR9IAAp6wsxLCenf+GmttU4iYvJzI5zFDZ56k+kS8nXuOEVUuixAbWe6nyu3dV0flNW9ZMsHvYk986e+LnOZmnhkDQxOxQSO6PHIjLiAI91/VpNDWRoJI7L+VlKCLgpRjQV7qY468dmBMvNMSV+aUjSO0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762173194; c=relaxed/simple;
	bh=beD8qtw9fqIw3oh9YLoSGz8oeH+H49c7DmKIoDszgik=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=SQhcmiUzNqaXdXKXQE5el3V3OHBtQjiHIKB8RHi9mvMOUq+FZWtpmY8egZ37dAfRGo08felT/KKT91mSk7GgPa2cA4Y+2xlyT0LhLUFqluKPOQk7W16O+rW1RF2HcourFL8GvM5dYgTIpGOU1UziFDnBHMhJW1iV6vFkJASBOdM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DpwSdIll; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=g/AbZyAO; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A3COsXd010086;
	Mon, 3 Nov 2025 12:32:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=jTE4wdrkFTrF5j0l
	wZ9Gjm3ElickLBeJHVLiuH6lAAo=; b=DpwSdIllWyCSoOp8Bjizh55XEZ73SZ69
	lty90Cfk42/PrKL/AODGqX5twRLUAvVMDNxwozQjc6fxV6EyL6eWO24bqMCRSXPR
	5JvWvMupkjECL2rkn0EvborAq6GQ0zupctoci0Qg6G3m/q6AEvVGzIAegOsX7Mtl
	u0YfXs04+4kVWqLXHKOr+wNPBCmhRodVzSNkvZwRu/dft7dUWdsclHyeKArz9gSx
	2SCyglvlsq5ySVbKFxHjL38VMTlRsn2uiX6ccmEA4EoCojHrqkBmAc+90LQkTIiU
	6JGYx5UE6xecdxh6hitV2Lq7bG2zOOWPj5jH7HkAUGc2LslwhAysKQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a6vca00a5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Nov 2025 12:32:14 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A3BKtuY010909;
	Mon, 3 Nov 2025 12:32:14 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013025.outbound.protection.outlook.com [40.93.201.25])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a58nbkss3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Nov 2025 12:32:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IewCiBFX8KltKhV0RldpajQUABKPu0a56+ZsXxdz9jELmbnbluypSkHCNA1wMiEqaYwbBDgmH/pw/CQogf6+N35mAjLVMq94SN4bFl4jx8YWXP0ZpAu8JXXNcwEVn1AQG68j5DoWIgEhpDvV2X9jtSzSnJNecdtZZCd0Dt3IL8EYa40XLaduFoxbqKf9ztYMi9ILyhp1E7wGJjjnnz3ygUTwIri9owmxhCSwCZ4fK5ge4//ErtkzkXrMX0eRZhd9+sLENoe3+HjOiBy6e/0DjDSwR8pNMfHfYh47Lgf48Dl0re5YNzumyjLngDt8QgitKTrfHzdWK3sKtk83wtPBag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jTE4wdrkFTrF5j0lwZ9Gjm3ElickLBeJHVLiuH6lAAo=;
 b=bMyDy5kKixpCOmdztJuh7nCw1gp24REGiTm5Im1Yvuba3p3p7ZwboyaGIWnWH2iXctr3eo2ivWWtkXiUaraG4nPi+BTgHgjjlvpf6y8vmEbATL47ypxvhuYen/JMFmyv2eJj1dG7eFNQdekPwo3cQfhiuUQshvqP2JCbkd4yQjC1DBnaWbJUj2RxBeLn5yz8obO0tBfY1BtAHBv2nns3Xs3zuaROvYxyrw5TPu2fwIhUKvEp6Oq1kbzjI/lOIa6gCgQX8xrlWNKnwvFrGGz776c3ofbcXUWt1Z6oPbSuEKmWdV1sMuJYEiXp2KhPOgZY5gHgF9de+T9EGPhpygEMtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jTE4wdrkFTrF5j0lwZ9Gjm3ElickLBeJHVLiuH6lAAo=;
 b=g/AbZyAOSLqqsZIcCjt9a6PG/9PHvOQjsGXCoo8RdfpW1tNX9kfZwKL3J67tmbsuMRh0ibJrYTI0no4EzZxLeTGPUEqmEU7Rdom6xP+6FoPWeMYy5FSGPXI/kZtl2P1ow8rMFnLXPlSkIxA+lxDfmLqhT6q8LaEtzPwn+miY1LE=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS4PR10MB997575.namprd10.prod.outlook.com (2603:10b6:8:31e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 12:32:10 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9253.018; Mon, 3 Nov 2025
 12:32:10 +0000
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
Subject: [PATCH 00/16] mm: remove is_swap_[pte, pmd]() + non-swap entries, introduce leaf entries
Date: Mon,  3 Nov 2025 12:31:41 +0000
Message-ID: <cover.1762171281.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0117.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c3::20) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS4PR10MB997575:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f388512-38aa-4d7e-e5ec-08de1ad5024b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RVLaqZyXKvtpkY4089/9kH3Pm1bU143hUUCDPpnYD+DeZ5s/uwIQ9XEvBGyD?=
 =?us-ascii?Q?5RNwbIiuPfRLG9ZJEhKo75V7fDZyXggU7BvX09W/KuwoMZwAnk71bHdIyiSF?=
 =?us-ascii?Q?ebIn7QlzgKv5u28pyJ/zMA+UXxqm4GAorsOBpC6KHLca9AdbF5ddOgYKcFV8?=
 =?us-ascii?Q?mQThmsNqcWhzLcOJ3vVLxgzX6UTaf5nOwXFqo+XzlbJy2p+jC4QrZMODffN+?=
 =?us-ascii?Q?n/JI5jfFNQVUEoTvZqz1a0M9EbecI78Lf05AMJQQK6QUgFdkwqy9z+x7Z+52?=
 =?us-ascii?Q?kcG4iyPsIG2cUrFKwr2v00U3bwhxdA3RW/EPGeaEZQC3el6io+IEuCPC1R5B?=
 =?us-ascii?Q?aICySqI9w8Wl1u+ypmqm8F33ZVVB/X5Wi2x8+1BFiHCmNLJGT81UW06K7IbJ?=
 =?us-ascii?Q?ozu7iiP3HZh1C73gPomCevHsJVWCLrfdDhXW/g8RsNcoCiCWtofKY34aBrhm?=
 =?us-ascii?Q?2qwkmsxAyQgyAtnJJ6BUqnmwVhVD6wkoLlzzLEv6Uv4VQkZHPvc+MKc0dAEy?=
 =?us-ascii?Q?ZM9L+GIFDztgE7PCswW0S8M6yOYvPa4iIRjZAWWQJTpJzYVnTnSf4NDMnQDO?=
 =?us-ascii?Q?6iiDEOMQHkAM9ShlDtAsnHEH0iABH10rVgUy7yseCVfl3gdBJA00lojc5kqh?=
 =?us-ascii?Q?uLUAAHYTJk5osyufpnYWkjWjTsmYCUGrpC6DsTxCVTii4NxDXFu3ucSAEsK0?=
 =?us-ascii?Q?Dw1mTLPNS3tmgxrt/b6Xo23WiEecN6CW5SnDsFym+gxqqpA1i1lp/kIBzwf1?=
 =?us-ascii?Q?iXKeiASR06BSewi7wIdN1L3VDZfJgg9ggseTHKwmjDX2aTZtShCTVT2LV9o6?=
 =?us-ascii?Q?a2NI4O+zK8+uM/gPrY0Bk4wN9Fz1MuHCquHT1o+uH8tON0+muLAmnhClTa/S?=
 =?us-ascii?Q?hx/6YQqnbO9nNHvQj/wH22043l5rGAwNMnjhCIsyx7gvTvcPw/E+xpqhvunm?=
 =?us-ascii?Q?dIcjZvYTmYfldOYQfn1neG5/QFaicSsaGg6CRnvrjuFqcyj8AxbHB1iD6i5r?=
 =?us-ascii?Q?9vclQSmvDy3Pz6agKsQ0A0GigjxjxqLuZWezhEs45qARRgm+PaQ6UqEEiAWZ?=
 =?us-ascii?Q?GGBRxC1Td4ogydl6wAEVHf0sasm1ZLTmGKdCZPsj2ZxbEAdaS5Qt5VUPBJLx?=
 =?us-ascii?Q?3avygL7qGkamf1bur7GgR7TtbgivjRdnBEWz+C3UWo6lHr8iY4Hny02jqG9H?=
 =?us-ascii?Q?L+2HQZ9r7qUDsFL8wzDg7ecHTCtvnDRewh5bPuY3gvQ+ZWMLYwSD7dwqGJwZ?=
 =?us-ascii?Q?Oi8EaQkoeLM207tnkljgdEAr6RP8cfRH+RyM649ltrdt0AgVhuKv1jv+nQPi?=
 =?us-ascii?Q?b8r6g4DE3L0XHJ6qQmX7eZ5qwjhv6MXvtPxXrjVcLtzm1es1dU0yyQ/6QW99?=
 =?us-ascii?Q?oHezC5e2nBWsxcojQvTEh29jGd6EgnZTvXq22qYvFH8CF22eHsel/baztUwS?=
 =?us-ascii?Q?i9acnCD9IKSKG93yi9beQYiF+Ppu0jDhyEakOmz7cVtjudJQgQy7MA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9fsHHL4t5kmJBmqNWRxG7V8lW8F+UrfLaU317OeBlLru47vOVXz+kXuN/OfL?=
 =?us-ascii?Q?Y/I1n4KOoMy6jpiSh/808+VdL6a36pbQ6F5u/e5vQ5cBKGJA+PynZFNGxPbd?=
 =?us-ascii?Q?hbGM9jXLeTrKBztHuy6ZeoCRXPQSW5AbtNxEfrc/061a4qMsW5h0rPNQYdB5?=
 =?us-ascii?Q?blftbEP4B1TcHfaYib0yzI0tOw4X1UQa6amy5SQBz/DLwUZUyqH5X8Eyzcym?=
 =?us-ascii?Q?GLfCQgzsUZvAAMgqDFBuSTfrZbU26VuwL1SKzcR3cGfwK01nujwvK50fo4KX?=
 =?us-ascii?Q?8x4VKnTf8vjZP+ZSQC8thzCXZrHleB3Gv6bEB+u/bmK+DY+iEday8b7voUSe?=
 =?us-ascii?Q?sXN8655BlpckYMeqevIrVDtjLIV+tZoZvdjE/9+OWhm827ZL4+Y1hy42qOII?=
 =?us-ascii?Q?d03Pw5RpVunFohe3zC9tH1nCqYZdTIX8CZ5unWhavYJ/80XBhC338QMWwBj8?=
 =?us-ascii?Q?u7X1Pr0r2ZBfnBMCMv2cyJbW62hvzfTYSLNO7C1BJiah6K3DPQVRmyZKwESH?=
 =?us-ascii?Q?mhb2O3h0C9lbM5Am6NWYlbj0Z/ehzYHrpLr1CtHWNql2nfPwsLviu3honOx5?=
 =?us-ascii?Q?eXCA5k0+twYAnPS7fIugprWdyQ2KccgCYiCLo9ZKvjuQnLRi1+siim0GgOrz?=
 =?us-ascii?Q?O+BK1ORLEsOGouO36aXQ+Im5k2n4/0yVrwAE1+X6a7Q5gRsH6lZ+QrQu6gn6?=
 =?us-ascii?Q?rlTFi0aaWTvmDTtv8gl94NxGrL5vwdyxJ0ezciuoC560f7PQpZsew6ZmhuDO?=
 =?us-ascii?Q?6O1OkXBY8HJMdbwsXEuuhrBp1bcSK27R/sm1mbwWJ0QXFh3d91PrkflFa7BV?=
 =?us-ascii?Q?RvfAllYNRMsJ60qA14TAxe7gAmAAkhUMeX7gZn0r5OnP/Kz+VisWhibwq9AA?=
 =?us-ascii?Q?sleGrIqsoiprbgL6UHDM+6Xaq/d40zpOfd/6K+FbQXyANw3aJXrQbfvNQAPr?=
 =?us-ascii?Q?/Lf+WMwnmstk96yvU7bByYQb9MQADlqpSzJEIBCm1gPCVPED6gIwg+Ncy15w?=
 =?us-ascii?Q?YX8gkOkKDN+ruPMk3XyG6lFeI+Ac8n4/7XkaRBgEn4frU2n6vBYFPKkc5zP7?=
 =?us-ascii?Q?R6Sn8w2oxYQe25XtCBL1XrOdFouxr+il09nLGuownnTYxpr7tXLBMqXWIByR?=
 =?us-ascii?Q?31xyb5ccIu3WTNKR7eq4151k3wouPTwjNhNfeCW1f16J7qr6PMZwMkRsO4cG?=
 =?us-ascii?Q?sx1uMKZ5pwD9GzyQJ250qfwejfhDxJ1D9XUC/qenL9mBm2M6n907bN1YeFr9?=
 =?us-ascii?Q?xtOrxi3UKrFv4jogSs8qcdd3sNuUnuLZ+ciS0Uil1b30qg02JPqD4cOWu5Ci?=
 =?us-ascii?Q?2k1rYY5qLQmVwjnreV4YA9aGn850U8R777tMSbu4CQgeB2Cs+miQzLj1kumI?=
 =?us-ascii?Q?Ym0G1uCbcpekAx3BjVFPcippdUvhOPmF0MwCz6oaHTDTaalRJ9mhMMAIC+lT?=
 =?us-ascii?Q?my8tNSIBC1Or6VtDyIVYA3E+Ry1oBdtzaEGjmrIBu1/pmEsG0sdacnoMalyI?=
 =?us-ascii?Q?sMFFzBTC2YwILNib/DGTRoFGp9YzvvAYUV17LGilrpi0ggtyil7GBv9IvGe3?=
 =?us-ascii?Q?+8gGi2KrQW/7HC9MYuGqyMxOjSN+GKZQO7bgOzNz8svZaRtt0a51Nl2BnqDG?=
 =?us-ascii?Q?fw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NnzNEhtW4IruvInDt5qTsXeSvu8sUxJPobf8bnDddJP8H/3jrmzHejbsRM7xVP1mnoTIUclxWI7nzkomdK3RVW76uDU0MJfDEbOUZitSg2fuHLTq5QwFcxqv5NbvENHINIiUDVm9XY2Ce6vJ2H1IbuRj0ITZ65CxQZPb2xpaxDep+E0+5RHURzfCndlV/Xlem37wFIFK4O4eHS0g4t0/MsbbvWPwGLpIwhZw5U0KwtZ6H2ytvzaK4eBuiI2T07T6LieFqCyE1gym9vmMO3l71sMxnNmEpGh+Xs/u8Z86aH/sAOUw2OlbOuXi13Q86V+5BTiyxmEK/dWPpTHEreVQJ2lpqKbwMqGHZXjSUZOyYlIXwDDpA9YFkae4zZ1xVhgCyGwChQk2lmQc7GRD2oPrHCRuUMSHEWk9aDU8CAbBXpkR0ZdPAhulfVdJ7StFb+E7ihwoZHPmVk5zwr+7vEA0MS3PBd31topnxYb/OvZ/1zkhp/UekqzEpuSvNBl/hsB1D2EpjzlUeoY9+KSzbgidZHmfLASElY7n1d4S/f+e+7LVttIBPSpdxkjsuHImW5cqcZBKq+BW8V5Z5PxcZiVnZ0k+yFYpxD0lfgVFlLITLWY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f388512-38aa-4d7e-e5ec-08de1ad5024b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 12:32:10.3031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BCGVNiJaAuHYyOit64BrKyh44fTmT7SFvj7QeG3ObMfzyUglg1rS/zQpe99PFwmiIu9cncPAmCZMgAYaMDZ1blogj9POSXMSH1kz4BuELbI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR10MB997575
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_01,2025-11-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511030113
X-Proofpoint-GUID: TDgAg4DQ9_d7Uci0M8mmGukikabkpPnF
X-Authority-Analysis: v=2.4 cv=PPsCOPqC c=1 sm=1 tr=0 ts=6908a0ce b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=LvTsRCqgAKWwgvdAruYA:9 cc=ntf awl=host:13657
X-Proofpoint-ORIG-GUID: TDgAg4DQ9_d7Uci0M8mmGukikabkpPnF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDExMyBTYWx0ZWRfX0qHKPm5ITWfX
 NYQXVX0mc3datlSWmvNAC4s8d3DAp2XeKbK1uXDAytwdYLjEb8ql2Lcb/BVVil7Rs2U4dlkQqa2
 T1m6b9UmtvsQlqpqG39t1LH5T7clmSe20a9KbJfeBBtOzIt7+rdUMOJY8amuiS/7mk+GtFREYvV
 9X+X8ypUOrwHXoz+sSA6Srvl5Ksth3YVFGYFTXZPD8kXOFAlgo9ZqyfIp4RmA1a9w+MViZqT7W2
 WxzxAng6lUsCt4xwbzK1f9vMDNYHyUUp05i6XXmPPEKBwmMYyfQ5WeATEDwqRPIffTEF+AUf8Fw
 YLhtOIsoUKHyx2BPzxEA/RrSuJGF62L/yYmmU/bToE4NNEB3HOY/gHiqwpcKwxC1k89gvz8kjTb
 PDTcFRVw26d3EGwfjVwXsA1wA6OtgrzObOriWaHBlPUZc7N+i34=

There's an established convention in the kernel that we treat leaf page
tables (so far at the PTE, PMD level) as containing 'swap entries' should
they be neither empty (i.e. p**_none() evaluating true) nor present
(i.e. p**_present() evaluating true).

However, at the same time we also have helper predicates - is_swap_pte(),
is_swap_pmd() - which are inconsistently used.

This is problematic, as it is logical to assume that should somebody wish
to operate upon a page table swap entry they should first check to see if
it is in fact one.

It also implies that perhaps, in future, we might introduce a non-present,
none page table entry that is not a swap entry.

This series resolves this issue by systematically eliminating all use of
the is_swap_pte() and is swap_pmd() predicates so we retain only the
convention that should a leaf page table entry be neither none nor present
it is a swap entry.

We also have the further issue that 'swap entry' is unfortunately a really
rather overloaded term and in fact refers to both entries for swap and for
other information such as migration entries, page table markers, and device
private entries.

We therefore have the rather 'unique' concept of a 'non-swap' swap entry.

This series therefore introduces the concept of 'leaf entries' to eliminate
this confusion.

A leaf entry in this sense is any page table entry which is non-present,
and represented by the leaf_entry_t type.

This includes 'none' or empty entries, which are simply represented by an
zero leaf entry value.

In order to maintain compatibility as we transition the kernel to this new
type, we simply typedef swp_entry_t to leaf_entry_t.

We introduce a number of predicates and helpers to interact with leaf
entries in include/linux/leafops.h which, as it imports swapops.h, can be
treated as a drop-in replacement for swapops.h wherever leaf entry helpers
are used.

Since leafent_from_[pte, pmd]() treats present entries as they were
empty/none leaf entries, this allows for a great deal of simplification of
code throughout the code base, which this series utilises a great deal.

We additionally change from swap entry to leaf entry handling where it
makes sense to and eliminate functions from swapops.h where leaf entries
obviate the need for the functions.


non-RFC v1:
* As part of efforts to eliminate swp_entry_t usage, remove
  pte_none_mostly() and correct UFFD PTE marker handling.
* Introduce leaf_entry_t - credit to Gregory for naming, and to Jason for
  the concept of simply using a leafent_*() set of functions to interact
  with these entities.
* Replace pte_to_swp_entry_or_zero() with leafent_from_pte() and simply
  categorise pte_none() cases as an empty leaf entry, as per Jason.
* Eliminate get_pte_swap_entry() - as we can simply do this with
  leafent_from_pte() also, as discussed with Jason.
* Put pmd_trans_huge_lock() acquisition/release in pagemap_pmd_range()
  rather than pmd_trans_huge_lock_thp() as per Gregory.
* Eliminate pmd_to_swp_entry() and related and introduce leafent_from_pmd()
  to replace it and further propagate leaf entry usage.
* Remove the confusing and unnecessary is_hugetlb_entry_[migration,
  hwpoison]() functions.
* Replace is_pfn_swap_entry(), pfn_swap_entry_to_page(),
  is_writable_device_private_entry(), is_device_exclusive_entry(),
  is_migration_entry(), is_writable_migration_entry(),
  is_readable_migration_entry(), is_readable_exclusive_migration_entry()
  and pfn_swap_entry_folio() with leafent equivalents.
* Wrapped up the 'safe' behaviour discussed with Jason in
  leafent_from_[pte, pmd]() so these can be used unconditionally which
  simplifies things a lot.
* Further changes that are a consequence of the introduction of leaf
  entries.

RFC:
https://lore.kernel.org/all/cover.1761288179.git.lorenzo.stoakes@oracle.com/

Lorenzo Stoakes (16):
  mm: correctly handle UFFD PTE markers
  mm: introduce leaf entry type and use to simplify leaf entry logic
  mm: avoid unnecessary uses of is_swap_pte()
  mm: eliminate uses of is_swap_pte() when leafent_from_pte() suffices
  mm: use leaf entries in debug pgtable + remove is_swap_pte()
  fs/proc/task_mmu: refactor pagemap_pmd_range()
  mm: avoid unnecessary use of is_swap_pmd()
  mm/huge_memory: refactor copy_huge_pmd() non-present logic
  mm/huge_memory: refactor change_huge_pmd() non-present logic
  mm: replace pmd_to_swp_entry() with leafent_from_pmd()
  mm: introduce pmd_is_huge() and use where appropriate
  mm: remove remaining is_swap_pmd() users and is_swap_pmd()
  mm: remove non_swap_entry() and use leaf entry helpers instead
  mm: remove is_hugetlb_entry_[migration, hwpoisoned]()
  mm: eliminate further swapops predicates
  mm: replace remaining pte_to_swp_entry() with leafent_from_pte()

 MAINTAINERS                   |   1 +
 arch/s390/mm/gmap_helpers.c   |  18 +-
 arch/s390/mm/pgtable.c        |  12 +-
 fs/proc/task_mmu.c            | 294 +++++++++-------
 fs/userfaultfd.c              |  85 ++---
 include/asm-generic/hugetlb.h |   8 -
 include/linux/huge_mm.h       |  48 ++-
 include/linux/hugetlb.h       |   2 -
 include/linux/leafops.h       | 622 ++++++++++++++++++++++++++++++++++
 include/linux/migrate.h       |   3 +-
 include/linux/mm_inline.h     |   6 +-
 include/linux/swapops.h       | 273 +--------------
 include/linux/userfaultfd_k.h |  33 +-
 mm/damon/ops-common.c         |   6 +-
 mm/debug_vm_pgtable.c         |  86 +++--
 mm/filemap.c                  |   8 +-
 mm/hmm.c                      |  36 +-
 mm/huge_memory.c              | 263 +++++++-------
 mm/hugetlb.c                  | 165 ++++-----
 mm/internal.h                 |  20 +-
 mm/khugepaged.c               |  33 +-
 mm/ksm.c                      |   6 +-
 mm/madvise.c                  |  28 +-
 mm/memory-failure.c           |   8 +-
 mm/memory.c                   | 150 ++++----
 mm/mempolicy.c                |  25 +-
 mm/migrate.c                  |  45 +--
 mm/migrate_device.c           |  24 +-
 mm/mincore.c                  |  25 +-
 mm/mprotect.c                 |  59 ++--
 mm/mremap.c                   |  13 +-
 mm/page_table_check.c         |  33 +-
 mm/page_vma_mapped.c          |  65 ++--
 mm/pagewalk.c                 |  15 +-
 mm/rmap.c                     |  17 +-
 mm/shmem.c                    |   7 +-
 mm/swap_state.c               |  12 +-
 mm/swapfile.c                 |  14 +-
 mm/userfaultfd.c              |  53 +--
 39 files changed, 1537 insertions(+), 1084 deletions(-)
 create mode 100644 include/linux/leafops.h

--
2.51.0

