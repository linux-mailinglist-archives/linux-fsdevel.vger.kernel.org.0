Return-Path: <linux-fsdevel+bounces-53475-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA43AEF697
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 13:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FE6E1BC8163
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 11:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0786257AF2;
	Tue,  1 Jul 2025 11:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Q8JA/YW7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="b4V/myMP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBF41DC994;
	Tue,  1 Jul 2025 11:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751369526; cv=fail; b=oCIh45H/zA50aEkuMMI2YvUrhivwSse7zDc6/3Im7ovzTChR5vBKQRY26R9JSZtiKxdkcUgY+HLskQUkpQnOiHwv4afb4pwTAR+OQohaZN7NKZI8w2MNSIy3NhEHULXRueSgna67TMiT2bDnbQlipsZRYtD3GbiwLq1VcfFXVJU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751369526; c=relaxed/simple;
	bh=HHmkQI5zlmAL2yo/LaoV4Y/4XSZs0zNkNVqXEfw/ut8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CgM+4TFBPTrAQcRNg/db/SMqxKqh2m8KVlxfKro7lKuWo0y/L/trbTJB1VOjGUs8d0TXLmjQG9LaDva+azSL2fK7+ndYpuSPtP3bS76g65wNjNB1VS0UULLa6HCx2+J43XJ9je7fWr+y7VY5a+KAV9Q5pDqdPvzrQrtucfSmEyQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Q8JA/YW7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=b4V/myMP; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5611Ocpa025895;
	Tue, 1 Jul 2025 11:30:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=2KeKLdoTkyE1FTzkDg
	Z+w04ddIDbUKQRuOZn+n61iNE=; b=Q8JA/YW7KZDlY+kPS5AxVV9RV0FfSGNFjK
	ksF8cbQf0x/GDQnfqMRY2t9Q4A0nWTuyQ3JnAprIK4ng0aqOft0bCEti4d3VFuzi
	AqW225rNqYv2lvHNwlnGIvPV3e7SQD3GyVYGT0cRWC+VRpJCptQPvEjHVsX8zund
	pXx/+6oBmt+W22RWjLlKeK6z2lkdneYviO3trw4eZrt5E3Hkm1xpow3bV/EdQ+UP
	SDk55sduB8csx+qLuInru45/hauHIjV48rvRS7WIr0kYXfjfHemfJIVhUl88lQ70
	9mm2DdlHlHY0jeGr9cB6xIVjbC2z1sbhVPfw71hPqBuo83g7Abpw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j8ef4k8m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Jul 2025 11:30:25 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5619ilY5025815;
	Tue, 1 Jul 2025 11:30:24 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47j6u9mjja-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Jul 2025 11:30:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JIepLrNr1T9uSsvTNnzx0DAMgVf4E4q4VHxUwtGJI5jtUGMVLa0FRJsOL03RYdE2phmurS9u2AOyGRHjRSsA0TkMmkhV/3/Vb88iQlAQQU4jOS7kmSv7b0RvpKgBgGUyE/qkkx5Fb7DmP2p9POHngt/A5XAWpKRkIgtvL0/g7813ed25lN1GJlcPa8pmMtLaShAuwRoODS23bjMdvvpc0ii2CT4G9sbF4pEf+R238weu8B+T8YI4evMXmi96q5ShCT7qNs3SSDKGp9XDMSTCw6n7896ItCmj9AtijmQuTgzB6oiEQYcprHnmmUlCk5IOuRrrlOthdCJvJtxHS4KzVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2KeKLdoTkyE1FTzkDgZ+w04ddIDbUKQRuOZn+n61iNE=;
 b=SWeBvVeHCixLks1ooSRq7XuubZl40fuJYaLkKVkmyzDoa9+aoxVICmZ3n8WuDB5/o919aFC3QZFunzeBGsUaHN0ba1YQiS5ewZ1Lr4AbUemLKWOpBGJzzAPgKdrI9liuamMcK6/+BSzJDrFu1Y0XGi9xtjBHCgtypLOARYwaH8TyoDgQl30LKSPxuCoGgBAKKF10RdMEXdiEm6/3/oB09mW/3Sn489Ssp/YfpvzTwZxyMveDodwXagQuDvtAWMDbGnTscPawaaZxz12S21i5Kf6vnZMPO6oDr+UlLaGLGIyQIt5100exBEj+zvQludx/fvVyQQPAnFpQobTDyVuc4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2KeKLdoTkyE1FTzkDgZ+w04ddIDbUKQRuOZn+n61iNE=;
 b=b4V/myMPMzE2l/wrYFH6uuT4pFWFPXG01+6IBYt/XPPBoWfopx5aHBhVpVDm1gU1vdr8Dq7wfwM77uSO6H515hTvBFOoqIRwIaJR7qSaNdwCMngyOdRf22LNFCywZFPing0AdSVIRXXTtpsm2wGzo3w8bbChZ1m9MLVqCDGPr/Y=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SA1PR10MB6493.namprd10.prod.outlook.com (2603:10b6:806:29c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.21; Tue, 1 Jul
 2025 11:30:20 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8880.027; Tue, 1 Jul 2025
 11:30:20 +0000
Date: Tue, 1 Jul 2025 12:30:17 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        virtualization@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Jerrin Shaji George <jerrin.shaji-george@broadcom.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>,
        Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
        Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
        Ying Huang <ying.huang@linux.alibaba.com>,
        Alistair Popple <apopple@nvidia.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Brendan Jackman <jackmanb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>,
        Xu Xin <xu.xin16@zte.com.cn>,
        Chengming Zhou <chengming.zhou@linux.dev>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Naoya Horiguchi <nao.horiguchi@gmail.com>,
        Oscar Salvador <osalvador@suse.de>, Rik van Riel <riel@surriel.com>,
        Harry Yoo <harry.yoo@oracle.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Shakeel Butt <shakeel.butt@linux.dev>
Subject: Re: [PATCH v1 18/29] mm: remove __folio_test_movable()
Message-ID: <6e067746-9d18-4d04-a60a-536d5fee6b87@lucifer.local>
References: <20250630130011.330477-1-david@redhat.com>
 <20250630130011.330477-19-david@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630130011.330477-19-david@redhat.com>
X-ClientProxiedBy: LO4P123CA0207.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a5::14) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SA1PR10MB6493:EE_
X-MS-Office365-Filtering-Correlation-Id: 35bd4f9a-34a0-4ed0-0d06-08ddb892a91a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Z7D5jKGzmlfqpFwDh9gzDrPezeo22+2HJQdX2rBSYxYyYa0mfwUush9uCbOu?=
 =?us-ascii?Q?J05Neat+6ydPrygz5fPiwvCNU/HAu1YGfEW3kQWzRs+UlUxoouXa7w8HY7QX?=
 =?us-ascii?Q?oqZ48RfTVrUB1yJ8JINjaXY/10zlA9locj3kKspuK/OP/hzyX8l+xIOcR9UP?=
 =?us-ascii?Q?GactIVywdnHrMse7V/06olmbjttES6FGdVIwyPU/sEiHymiqVqdgCJBmNg2G?=
 =?us-ascii?Q?cVx/ObADrPi8MdrUfuRVnHjtCQche3zUP6hn557U+hh9QirTi4XEakJF11sl?=
 =?us-ascii?Q?OugXXYsKob5aQlLemmQ63VeR8d6uGCK7wKCXU7uL5wh/Arrna+/pwUEw5SZB?=
 =?us-ascii?Q?c8knIOUPaRjiQKg4oUsDwAK0l3GbYMwJgUlAjr1r+9S31ynjfbXPk9BBtWen?=
 =?us-ascii?Q?3Xvk9OhwfyNEM+HbKVBmUk0fmYBoJgWdEfIxIux2wMlNhXdAwvpkB/qnshyr?=
 =?us-ascii?Q?39Y/MamHs0SEtXvMjJ7cIibMyhbj8WBfsqab81adfgCcQRR9fAD3f7v5ltzW?=
 =?us-ascii?Q?1123NUDcOiQujxZHsAJIX6zSS3ZX1RjZ5PuqtBuDL+zVEJ1HaWcrWdy5L3LU?=
 =?us-ascii?Q?Fsue8vHWd6OSGiTMQAR0wSJqdlYBI4xZ++c8pDbSLXo+Z6TZWO+S8yDby89V?=
 =?us-ascii?Q?4R8ti2w/Vu/9wCSA+G+cgnao/j/FEHBCsJn2jinxNSWULLQ1qSzkkxXVZViK?=
 =?us-ascii?Q?KdWM4cMxygN9lNgiJQ5dmAxlXgkV9b9VOaREC43nfK1VkHR6cOMNJJy/MwuG?=
 =?us-ascii?Q?x3lka8Ww8bco8cTHcGf+QPkCvyTys2lkg3Su7DxKjTGgPaSJPYiM4SbWZJ0T?=
 =?us-ascii?Q?PS43SHfMglMKo4LWBtOedpEKQTvzm9OBNB5rTAPvEe5cWliHjitnAgpwv68l?=
 =?us-ascii?Q?SQAWip9Z89HNx9flSH32Fp1XEzcWsaiw1bZzuwV49TxaBtzkFeHJJipN6xjJ?=
 =?us-ascii?Q?cvDAwYsABEabBEyFLNFWI6yq/RYfqWvLgkqfS9ZVupW33CZoczLPidW30Z+v?=
 =?us-ascii?Q?7TIeV7vbvVpMFTepN2hYoszZPOtXr9qKTTU1mlul6o1k9NJYiYVSBs/iLlvf?=
 =?us-ascii?Q?omBHQ/k3ipmzzPj5d+RSbNdR5X/mmAmPc8xKEQR8e7skwIHfdAfDd5dnAZOG?=
 =?us-ascii?Q?wp6TuQg6VTQQRIm6+gD1Ub5hWqSRgmyHQ7gzTLx+lDzRT84kwRbr4LdwT39C?=
 =?us-ascii?Q?67ReBOIG7CAgMNlPcSTPmAzfh3h6q+a35mNyCi0DsnnBYLMxZ/+CcZALnwFr?=
 =?us-ascii?Q?MPIcCLK2nCBMIzURvqL8IpH3Ff2vWDeM4edMSJ09vsKCgxAMtWBdSpYlF1GV?=
 =?us-ascii?Q?aWuQ2HUh/73IVI7Em78IkDyrGFhFDKchCqLcR/KeY/03N0pw2RFh+M09HXSQ?=
 =?us-ascii?Q?8+JLSEeDIfkVMnFHoUxMSqPKWcvozuHprLriZfXJbrdYVzoeaHHBcEL0bueq?=
 =?us-ascii?Q?IyYD0G0yXws=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lTrqhO4qFUwGJzZrowK4cgDyTl2CenpREOYwujR4I2i41fXsukX6Du4i5E3h?=
 =?us-ascii?Q?QnTEkf11VntQHFrHoO5TxQ/RKAjFH7GkIiNj1Tf4iUUWKko1NB/ebjr7caqD?=
 =?us-ascii?Q?KJHpJZJ0+8WHgElSHSLxs7R8MhjqAvPeT9PoOexU2onJ51J9J4FT7TY+0wSk?=
 =?us-ascii?Q?KFr1vShB3W5m+YX4Q1WgX08HJdgkLsMWrKocw6yynrarD1lrmAHI1fRocHp+?=
 =?us-ascii?Q?Y5uwMSNVZfLqtQUvw+fIAzkEWJl3pRDktjPXulUundTuLbZU537UC552sIcX?=
 =?us-ascii?Q?lt5MQNSoUNyiMMI8r5F9jx5V1U4IsHW6SFww+pEbS1FX13sriTJ0j1lynJcX?=
 =?us-ascii?Q?bc1SlLXB21MVT4HUy42xFud6Ff34aJBUUx3Es5uFMVzOAzJQXJm97nu4l4l3?=
 =?us-ascii?Q?jv0oYQ1KmOTaC3lsRubV2OoESSX9ERBsEodwalMSHnpobI/qxD/xaHsT4kam?=
 =?us-ascii?Q?ZuFDHeMsbPHfiYwQgrkCVZq7iNcE+soF1WySYh8rZTNgKaXjr79R1SWbsD/l?=
 =?us-ascii?Q?UGswBNOfT3lfP9M9Tn5zPUvFlyDh49JN/e8bpmumAHbRpiwgtALLf8eXWQAk?=
 =?us-ascii?Q?4OhcFEq5Xd9GHJZPAKn4XE2NSxVGILq7zXyl3NvnSS4zREuFFv0ce/fRlRjc?=
 =?us-ascii?Q?CSKY60qPXr6Pb2qYt5Ro2904hnMjJBE76CxdNqepooHXpqmZk7lCYmAzCI7W?=
 =?us-ascii?Q?N86upuqkRyWpzTaRzg89WP/9fHjM3eypOdoNtXP4DMjNddJKo3h/hxT4qaeb?=
 =?us-ascii?Q?QKWON+d8OzFz767+PLmF9jhUxiKyNtv5ZiokRpRNhtJ2p7B3R70dXPhCEpjd?=
 =?us-ascii?Q?XQHwqGaa/r1cvR8zv5S0WgE1Zq/4Tmsd3I1psBi7hFbMIADw9DNMWKwT5Xwc?=
 =?us-ascii?Q?zr/PEF+JdtuZSC02plLy3JHp5MF57SnDYO4K8YLMffAZF+Tk7IyFc3ThezF4?=
 =?us-ascii?Q?x7W9hCxrLZ8vQYDx/RXmw2hgOOgWLkyy7Ij0X4/i+Sg7VV0L7cWVdWkhiK/E?=
 =?us-ascii?Q?D1f/QygU2DINATOBCFimjZ0XP5g/EJvkmc3emdCzMGdiuTYw9oxHvSqgPtDB?=
 =?us-ascii?Q?PSQutIjqPD0ll+VU+dMYkmt3OSJRXPQgaxrXSu9CxwqIA8aQ+Gwqdxr6m4h3?=
 =?us-ascii?Q?WM4HUaBX0IhFM2zeov3HgpLYOZAaso2co76Agm8PmV9d4KLE76p5K6gkHm8a?=
 =?us-ascii?Q?RF1zAjxvC2zgtzybftC2ACXpX+kV8hon80kBob0cZka5bpnscQNNagObZUBy?=
 =?us-ascii?Q?B0liXYr1/J0ZGJeGO0npjDMtC8VGqNLGE6FFAre46MRAvXSwXvkICiQTNy2L?=
 =?us-ascii?Q?+A8RhmXub8qbYTzl6eEsNqTh9jDafutCYFqojkgDulmoQpYbEpiLWeC8a3Xa?=
 =?us-ascii?Q?/XWuk5I4NEgX9DnmDJ35h8qBR0DQzVcYItDX1MDC5iK8SfaKCQ8eQX3heg45?=
 =?us-ascii?Q?aGnkjdIlZ/030rJWuicpIiI4miWUR/PZI22nR7kMZBCI7qtzx5P1gKfYtuB3?=
 =?us-ascii?Q?qOQO8NvAAsldsjmmT11FnIlMif9YgaknS9pElFPsOxvCFbogwmxQfkMfjTAO?=
 =?us-ascii?Q?dcO1NRr3fqdVTcx1OUlEINiljhugtq7Etm+h/0/II+C2hcgeOSC+xrd+mGQj?=
 =?us-ascii?Q?8w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+zKCHL70iQz1KeHfrxe+9JsPRJ4lBU+dX2lDmCkbSKGL7+MT9uAZBAvNbiUBaJvC//FI8ZBLXXoS/62oeH3pCBSRKkglbWN4bggTt79KzwzV11T6Pt1EAiYC7JzXuIz+LX1CGiNL6xtxbdoHdUVMpaHX7gxj6t0t41I3rpEIlPLuu/mEYsISnPIcOW57PbP0SyzA1EJ6j6T0Ar3xRbco/+Fyz2dxApRhnPDon1PCI99Ji6uPsDGezN6wlCGJcrG8h9lQt58RppR5NAeKNaHb9E8t8j9Bn70rxAvPy62EPMNVttjaWKsjN9GNLP9ZzEF6mRL25mVmu3nJSc4WZ0ob9+bCrVvqCg83Uj4HDDSclYn1Ai5HlR0gqZJ09iGbYJdkvSjbR3z6Dy5/pYgI8BwdiOpAt89oH1icFiWL7vGaShC2sALFrumE1QZr5QANaFDzQlPT2LX4GT+vYX+yogB9p1fsjsOEmHIk/1h0N2vESEFjijCe+fS0G37r4a9JzAyM94ZJk4AYDDPyNCHXbnuvbGac84sD7badyrdQOYdfq7LFTJpbqbY7iTIFO1rrewGgVC3vzLU486aAG/JlqPgbz5z0eFiZEQNNBTBxutYXRtM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35bd4f9a-34a0-4ed0-0d06-08ddb892a91a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 11:30:19.9216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G7RaCbA/Wq5GzXPLpdZpldS50FPsM6xehIRGEcyuK7yl27ibRSdfLHptqvOde/V3Nfn/dd8IO4tCCcIqtLXXZLmLZUfrrCvXjnjDjrugC/8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6493
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-01_02,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507010070
X-Proofpoint-GUID: vaSYKjT_KlYwHbTZCbOKnIKUP2NqPBko
X-Proofpoint-ORIG-GUID: vaSYKjT_KlYwHbTZCbOKnIKUP2NqPBko
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAxMDA3MCBTYWx0ZWRfX/4Zie1Myv32j i69R5+y9RM9NoabikDM/r+Vf+2DfZLt5u95GxQKrOE2MvtjbcjuY5QEOvaICe9Fki3z4pv67rI9 3xSzb0kBEwzxEFl+AaxG0IeQNkcnaoRkWTBDL0XYYv1wCkVsDMcJ7kmTZM8Ih/SL83WEP8qY+Ar
 m7bEAbgFbyWA3DqKAxKgO8GIeV+Er4G+V7nShXYLYaPy500iIVzZUuGjCQeMhMmLQmj7n41DbH8 l12CoL9kysaZAju9P63ai1tmFXuUbnrr+008tO/3w6Cyl/VZqIZDavGr5V0AztJZefuUHbLPvE2 jG/z8TYVD03hN6Bb0AxvU3rKJCYrhXpsoerARWk7JB63NwzFq64XeFU8/t/9ft+NmMyGc+sQYak
 L+nfEzICagNUu3TMbxR309qu/WKCaWdZxPXCUtRKfY8XV/lQtm+6OgFCD2h+xoRJdjIOT2Ii
X-Authority-Analysis: v=2.4 cv=ONgn3TaB c=1 sm=1 tr=0 ts=6863c6d1 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=Ikd4Dj_1AAAA:8 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=AjJQfBrXANVKcb1F8xkA:9 a=CjuIK1q_8ugA:10

On Mon, Jun 30, 2025 at 02:59:59PM +0200, David Hildenbrand wrote:
> Convert to page_has_movable_ops(). While at it, cleanup relevant code
> a bit.
>
> The data_race() in migrate_folio_unmap() is questionable: we already
> hold a page reference, and concurrent modifications can no longer
> happen (iow: __ClearPageMovable() no longer exists). Drop it for now,
> we'll rework page_has_movable_ops() soon either way to no longer
> rely on page->mapping.
>
> Wherever we cast from folio to page now is a clear sign that this
> code has to be decoupled.
>
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

LGTM, so:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  include/linux/page-flags.h |  6 ------
>  mm/migrate.c               | 43 ++++++++++++--------------------------
>  mm/vmscan.c                |  6 ++++--
>  3 files changed, 17 insertions(+), 38 deletions(-)
>
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index c67163b73c5ec..4c27ebb689e3c 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -744,12 +744,6 @@ static __always_inline bool PageAnon(const struct page *page)
>  	return folio_test_anon(page_folio(page));
>  }
>
> -static __always_inline bool __folio_test_movable(const struct folio *folio)
> -{
> -	return ((unsigned long)folio->mapping & PAGE_MAPPING_FLAGS) ==
> -			PAGE_MAPPING_MOVABLE;
> -}
> -

Woah, wait, does this mean we can remove PAGE_MAPPING_MOVABLE??

Nice!

>  static __always_inline bool page_has_movable_ops(const struct page *page)
>  {
>  	return ((unsigned long)page->mapping & PAGE_MAPPING_FLAGS) ==
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 587af35b7390d..15d3c1031530c 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -219,12 +219,7 @@ void putback_movable_pages(struct list_head *l)
>  			continue;
>  		}
>  		list_del(&folio->lru);
> -		/*
> -		 * We isolated non-lru movable folio so here we can use
> -		 * __folio_test_movable because LRU folio's mapping cannot
> -		 * have PAGE_MAPPING_MOVABLE.
> -		 */

So hate these references to 'LRU' as in meaning 'pages that could be on the
LRU'.


> -		if (unlikely(__folio_test_movable(folio))) {
> +		if (unlikely(page_has_movable_ops(&folio->page))) {
>  			putback_movable_ops_page(&folio->page);
>  		} else {
>  			node_stat_mod_folio(folio, NR_ISOLATED_ANON +
> @@ -237,26 +232,20 @@ void putback_movable_pages(struct list_head *l)
>  /* Must be called with an elevated refcount on the non-hugetlb folio */
>  bool isolate_folio_to_list(struct folio *folio, struct list_head *list)
>  {
> -	bool isolated, lru;
> -
>  	if (folio_test_hugetlb(folio))
>  		return folio_isolate_hugetlb(folio, list);
>
> -	lru = !__folio_test_movable(folio);
> -	if (lru)
> -		isolated = folio_isolate_lru(folio);
> -	else
> -		isolated = isolate_movable_ops_page(&folio->page,
> -						    ISOLATE_UNEVICTABLE);
> -
> -	if (!isolated)
> -		return false;
> -
> -	list_add(&folio->lru, list);
> -	if (lru)
> +	if (page_has_movable_ops(&folio->page)) {
> +		if (!isolate_movable_ops_page(&folio->page,
> +					      ISOLATE_UNEVICTABLE))
> +			return false;
> +	} else {
> +		if (!folio_isolate_lru(folio))
> +			return false;
>  		node_stat_add_folio(folio, NR_ISOLATED_ANON +
>  				    folio_is_file_lru(folio));
> -
> +	}
> +	list_add(&folio->lru, list);
>  	return true;
>  }
>
> @@ -1140,12 +1129,7 @@ static void migrate_folio_undo_dst(struct folio *dst, bool locked,
>  static void migrate_folio_done(struct folio *src,
>  			       enum migrate_reason reason)
>  {
> -	/*
> -	 * Compaction can migrate also non-LRU pages which are
> -	 * not accounted to NR_ISOLATED_*. They can be recognized
> -	 * as __folio_test_movable
> -	 */
> -	if (likely(!__folio_test_movable(src)) && reason != MR_DEMOTION)
> +	if (likely(!page_has_movable_ops(&src->page)) && reason != MR_DEMOTION)
>  		mod_node_page_state(folio_pgdat(src), NR_ISOLATED_ANON +
>  				    folio_is_file_lru(src), -folio_nr_pages(src));
>
> @@ -1164,7 +1148,6 @@ static int migrate_folio_unmap(new_folio_t get_new_folio,
>  	int rc = -EAGAIN;
>  	int old_page_state = 0;
>  	struct anon_vma *anon_vma = NULL;
> -	bool is_lru = data_race(!__folio_test_movable(src));
>  	bool locked = false;
>  	bool dst_locked = false;
>
> @@ -1265,7 +1248,7 @@ static int migrate_folio_unmap(new_folio_t get_new_folio,
>  		goto out;
>  	dst_locked = true;
>
> -	if (unlikely(!is_lru)) {
> +	if (unlikely(page_has_movable_ops(&src->page))) {
>  		__migrate_folio_record(dst, old_page_state, anon_vma);
>  		return MIGRATEPAGE_UNMAP;
>  	}
> @@ -1330,7 +1313,7 @@ static int migrate_folio_move(free_folio_t put_new_folio, unsigned long private,
>  	prev = dst->lru.prev;
>  	list_del(&dst->lru);
>
> -	if (unlikely(__folio_test_movable(src))) {
> +	if (unlikely(page_has_movable_ops(&src->page))) {
>  		rc = migrate_movable_ops_page(&dst->page, &src->page, mode);
>  		if (rc)
>  			goto out;
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 098bcc821fc74..103dfc729a823 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1658,9 +1658,11 @@ unsigned int reclaim_clean_pages_from_list(struct zone *zone,
>  	unsigned int noreclaim_flag;
>
>  	list_for_each_entry_safe(folio, next, folio_list, lru) {
> +		/* TODO: these pages should not even appear in this list. */
> +		if (page_has_movable_ops(&folio->page))

VM_WARN_ON_ONCE()?

> +			continue;
>  		if (!folio_test_hugetlb(folio) && folio_is_file_lru(folio) &&
> -		    !folio_test_dirty(folio) && !__folio_test_movable(folio) &&
> -		    !folio_test_unevictable(folio)) {
> +		    !folio_test_dirty(folio) && !folio_test_unevictable(folio)) {
>  			folio_clear_active(folio);
>  			list_move(&folio->lru, &clean_folios);
>  		}
> --
> 2.49.0
>

