Return-Path: <linux-fsdevel+bounces-61031-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4096DB549A9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 12:24:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3801172D4B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 10:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E8A2472B5;
	Fri, 12 Sep 2025 10:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Tg0AmU4P";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Jr0UHzmI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F4D2E0B5A;
	Fri, 12 Sep 2025 10:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757672677; cv=fail; b=dfJJe+GkVcktz7QBOhtaNVe1KBf36e7BvgquXmG908Sp9EfnKDwvX9NdI3cS13XtJDemv/tAZYBP/tLDGzb4JzzqW3ZQz0sWzA8vmXhWRBURyUVrUY4ThoNCXyYByiRctuyzxgQdJLJhz3cBv01dxyCicRMk/Vf5yiI1LW/qCvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757672677; c=relaxed/simple;
	bh=TiReYxZgwpgUFhS+sQlNxyUO9/T8upLjdZEHyfMfJ/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VV7KKzmYAOt8AUfyu1o6QNyotHmz3AUXBhOfTI6ak96ndzsttOg74ReY9W0Mv5H+yF6dml/42lMb5bv+nJJLT3J6GBvK8pxjSFC91ExNOhc8QVISwM/ws69VnS2/zw46Qmf+Zw0Sbrru1dgpHlj2IuaJhFkrWoB2616PdxAaYQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Tg0AmU4P; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Jr0UHzmI; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58C1uAAV031031;
	Fri, 12 Sep 2025 10:23:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=5pdEF4Rrg2N0FbqzEd
	PJGkWtEq7yvpGIcEb4LRMzHFM=; b=Tg0AmU4PrNWy/uvSAZqCVh8YkMkmLEHX9h
	V26HtbvHJDcw+LCzCmneZeGbJ1Qkhr0mH6qThQGsXH7fSgZ+/E+o/RoRWiAnklWc
	nrGWPM296PRRFBM7j1XtklOr6fCm1k/yOWlnTcetOldqxMbOMn9ybPQqOzTsH9lp
	Yyr7Nqt8f+59fU/pnlkEPjYK4JkvQzkFN+BdBOyQhTaaPgQkjkvjnVxhtNroPuJd
	rD3YEeAUv5X4IdnmX41oKxxKx3lKQk7z7Y5REws1bxhdvwrgq2uHrvFm8j4mtrUZ
	gQWO+LpOkhPXfrJO3NktCqZ/EdW1de/q3c2U9e5Ug+LfQDL9vMew==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4922x97wyv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Sep 2025 10:23:45 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58C8SQPk038722;
	Fri, 12 Sep 2025 10:23:43 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010060.outbound.protection.outlook.com [52.101.56.60])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 490bddpv0s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Sep 2025 10:23:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MnUorX936gAeKEumKq8drXcUQxFqJNv9/w07NO2Lx1slrTFC5u5kneyFiiB6r82Ti5t91N0iXJEXJq6NOyqzSSbTucKxNud+lybqLM4j/+7/dCrq2eXz2mUuPDXm++owJEN1M83XwULwp5hhM+xXKNzc1Cnn9/TzzIkuvwi2rLrfIMnIdfqnlAjHdLi0NCQCibq1psQ1E5IhsbtrE/Tp6KH2oRjZ/UmQjuiJu+Nyx7YSk1eypcQ/EaMdJAkYNZGSIMzcjUfwBqILznBOQIQb8jh6Il+HipiM62/TzX2tQmgCXgpHSNkweziU6CcxEh4hgw//c3nCCj70qQGNZLEsYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5pdEF4Rrg2N0FbqzEdPJGkWtEq7yvpGIcEb4LRMzHFM=;
 b=cnKQje0PNnGZle79j8+aR70CdM95Ppb6TkYPHR62GQw2LMGBRsOBsFFpftWY67+bGI4hPwhhV2evUQ5rOHBe83lZ7kFEFIE6VCHi+f3VAvGG9eSSWLkx/LWPP303HuqjyMP7e/MUnhfq+ddSbh0mtnzwpJmxkneMxxAzxf6k8Tpd/fXnS2XIyaIb4bnU0qUmlnkWUTgDFQYKiu5s68jIKtKWQtzOVWoOD0etAs1Zk7XJFDHf4BprXZyhBVn5+2hD4sQkcoKgtJWO3i+BOajZtx4yo8aG6WuV+6NRCCgVKFc5IyipKGCpI6xYCk3G/6mN08mPKJAqk2qn7Jh9noeyOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5pdEF4Rrg2N0FbqzEdPJGkWtEq7yvpGIcEb4LRMzHFM=;
 b=Jr0UHzmI65IiqR+9mO0yAgF86V++yDDEtk3Rogo+1pxQ8H6KagdBWru0xKtas5bQCxJ+GdrrFoz7go31o0qQmYTYwc/I9yMLrcN3q+HgX4ZBq40V0QtYDSaJ5qqPFzNyeFDqnqQ+zBYhlvYyAQrrqvjHey+vKScgVDmjvrRQCAI=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ0PR10MB5566.namprd10.prod.outlook.com (2603:10b6:a03:3d0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 10:23:40 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9094.021; Fri, 12 Sep 2025
 10:23:40 +0000
Date: Fri, 12 Sep 2025 11:23:38 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Matthew Wilcox <willy@infradead.org>,
        Guo Ren <guoren@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, Nicolas Pitre <nico@fluxnic.net>,
        Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>, Tony Luck <tony.luck@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Dave Martin <Dave.Martin@arm.com>, James Morse <james.morse@arm.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Hugh Dickins <hughd@google.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org, linux-mm@kvack.org,
        ntfs3@lists.linux.dev, kexec@lists.infradead.org,
        kasan-dev@googlegroups.com, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v2 07/16] mm: introduce io_remap_pfn_range_[prepare,
 complete]()
Message-ID: <ce124bd3-ee49-498a-ae23-47a4797f03bd@lucifer.local>
References: <cover.1757534913.git.lorenzo.stoakes@oracle.com>
 <96a2837f25ad299e99e9aa1a76a85edb9a402bfa.1757534913.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96a2837f25ad299e99e9aa1a76a85edb9a402bfa.1757534913.git.lorenzo.stoakes@oracle.com>
X-ClientProxiedBy: LO4P265CA0087.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bd::18) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ0PR10MB5566:EE_
X-MS-Office365-Filtering-Correlation-Id: 594477ea-8ea0-4138-0d54-08ddf1e6714e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8Px+wo4ynimZjOEgqY03rvMdoan/EnGCMUdQw6+SjvlBM0hAhbbGwMdEl0JX?=
 =?us-ascii?Q?mqDl2sAGHNL/1YnHakLeu0EtjMGYuh7tXVCbuHRVu1ETM1Gy4LL/8L2pJ6zO?=
 =?us-ascii?Q?qtgTXj+mc9gXeYUZCyQvIwiOqZ60pWpp9mVu/LHuJ2oeV24iIo8py3jmLFCq?=
 =?us-ascii?Q?0HYZcW9IF6eYSs3djYj5MWuQGq81AZ5LeTeg8dq00dWZKf23wjJdVul//g/9?=
 =?us-ascii?Q?CG2vvBhJegJfT7fmVESz+ZX6tgbn5oS6q0Q01FxhmxbGY03e4l5Yk+XRr2f4?=
 =?us-ascii?Q?G48alvKDRfi4Rfl3ifHwZctV7EchOFZSwLo7zv4hyYTbUNcTe4M2BjWjCv/2?=
 =?us-ascii?Q?zwqZvw2h1bYjdzVNblVlH9inCQhOlTxtB8kkBVtHkknTeA6e0t3Z/pAaC4NO?=
 =?us-ascii?Q?O89l6lfbC5pfGQYGa/SIYigL7e24J6ASB/DgwKaDls5EzAYvIExeSBlHVX9r?=
 =?us-ascii?Q?weCV+vgbTAKDEp+Yig0GgnzMGjaLaSt1weRGDd4Bq/yaMC2nS9U/a3nyrn1u?=
 =?us-ascii?Q?t5v4tmoKLEeIUuQM5slQgZ6qLEy2kuZykTNThLlxuZiJ9dp3LVBtSfkD4B69?=
 =?us-ascii?Q?7jJicDQSOpyhKtnB+1egO+IASEh4v4ir97Yuccnl27jFpGbzKqHKgiIrASee?=
 =?us-ascii?Q?ZzOtnOan7OHNFSp0SMk5FS5C75b8puzrKpzZX2QrrGCQY7++2Kx6k5khheZt?=
 =?us-ascii?Q?xKzdbeGvRbeP+dX3ya3NKe5pz125UKBM3Vp+z20nxfMi00EqixxOQlx5zey6?=
 =?us-ascii?Q?PF91I0ZyNAGVHu9heBHJCR/Ig97TipBRaRrmiieNiePElzCLjkc5Ul+59hos?=
 =?us-ascii?Q?aFZFiqmO4OK7PAv3guBtPbAgIcozuX8FHQGvNBAIiUU7kpxdUr5mmtUc11W1?=
 =?us-ascii?Q?rKgoiSpec6YWhShvd0SqxXnhMe1B5hHJQuLeqgAH3PCjOJVDjiA5BjmfsOQa?=
 =?us-ascii?Q?u3va5GpA1gWFvBhc/YUzMEZj26wxAuLmU55m/4On1WJFSSqNpNzwfHufPbtI?=
 =?us-ascii?Q?iR5gM38YBy9JgE+asNLBN8VBJhtUzyeVlkSWEAmn0djNp0QmiKBERAKnKYmc?=
 =?us-ascii?Q?rOcDKNRfrNm52dmvj08v0Fnbt+8fAnPZWwVQnPGL+rr6zul/5JhkIUSEY7uF?=
 =?us-ascii?Q?qWDahSXeHhOS1MpEypQQC+qvD6UK3dEnurX14uGD99Jrfip1F58wH8rjFKjt?=
 =?us-ascii?Q?dQ/y6DoqvT91Tf7gft02dHQc6g/RYRfXqsKDTVQi7gkCFijOLOcXPnRtoqSS?=
 =?us-ascii?Q?X0xnTsSIIADTTYHvr1eX0Dp3430rItzMWqsDrHt0h5dWq/bvqbPpuiLvGUKq?=
 =?us-ascii?Q?Atmh3WNvUxus0HlylVs8w79yaGOL0W14pyt/YBaLi7Igj7L/kmWm+Fe5p4Xw?=
 =?us-ascii?Q?uqF3QWmKVP8cL4p9u5Spj6QA+1ZYKnzlMIpNX7/FQR6obMuzoHALRnnIf8JO?=
 =?us-ascii?Q?5JfT2XPXcNw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?35ffnHESixuTQWusbmKJx1hIqJHtBUw1rIXRgNMWxB0n9ORox4LpSw/eNK0S?=
 =?us-ascii?Q?kS3jA839KWv99+i5Pp9b5mnuF9XrWSaD+6NN9GQBE8qf5GPD0kfXBxxFW+7S?=
 =?us-ascii?Q?ZFjBJReomZvl2fAbJ9fM0jKETPWdmWLzT2c1xIBcB3ow9Kz4+KQhUjzdk49D?=
 =?us-ascii?Q?l63P9uArklxYQjU3dgy+4xFnZ/EVS2dT9pjivjh2ppUdcEM9Nlh3dlF4qWhM?=
 =?us-ascii?Q?FdUlbIGDdWhQV3P7RAXDjrX94lmMsczoRvQ5nVA9ZJfklqwUkp7Wh/k+0tn3?=
 =?us-ascii?Q?obcCuwmSiFXpHPsmXrBwFl7Qy94b9BjZ6+R48HIW8yqPCw0kVotrY+wXu0xE?=
 =?us-ascii?Q?7Vha45vrn6QY/DnDIuXe2cZeSQIv3ym+BKwrJurRslLKv0enHsBSIAZjX1nt?=
 =?us-ascii?Q?8o/WtOlardmHlysTjxJL0zwgTB2n782aa4Xw8+PIbNTICWTcomICqUBX7kja?=
 =?us-ascii?Q?Ma1K+D9pOrgW5y6pIF4HdkcXduckLsSMHIrXFxLgvfdkHb/uvy49ocD1hXpR?=
 =?us-ascii?Q?uPor3bDydNUt0V9oIS1nPEYmhB6VfjPyOKeDzJQfFBjcGaZ8LmrnTtzLBRWC?=
 =?us-ascii?Q?LYrdq30AYlBnI1s3esITYIBysG1kQ29eqSgDnIHCorO7u+RORLG9nqcwCWA9?=
 =?us-ascii?Q?7YdS6kUlZ1/D70+0ReTMA0lRtFjBPe+5wzy4ErMi5yqqd+F96NfyNFegSDdx?=
 =?us-ascii?Q?Y6spX8vcaLs3UQWaViqdwvTAbI1NL4bDE3EffCbwrPQtr5pdvFVf7jVLd8v3?=
 =?us-ascii?Q?92FULeAeH7HV4Xk6U6GawRsZfnEhj5XMsnjOmqpg5INFUlLFmQQIMxWT8A+4?=
 =?us-ascii?Q?lj1InwbO0aOOeYyOHr/8k+lpB5iqSH8mRh3xLADMtFDoauJpXeQGptXZNEoF?=
 =?us-ascii?Q?uEop61sETyixvan42yRQa19VM0pnJ6IAxBmXXXrssztjag2NbvCg8itD40+2?=
 =?us-ascii?Q?9x7g175ltSi67S1cdLs/5YOTofGqEzs1/7KBioONk8fLuwXc2XAagH7nItDQ?=
 =?us-ascii?Q?MXoydioWf5yR4RHqXAwLGvmtCwMglB9XGk1wZ2RB6XjwwwDy4//5+XcPAIXw?=
 =?us-ascii?Q?6dE+QuSU/VMpDe8bGJbdnKV4Cr2Je+wFJCMUuoUwWEuDM6RryJ7XIKv3IwSz?=
 =?us-ascii?Q?9XNqx4HGvNKvTyH6aAlIlV4ZpFqVekWr7BRnx465weXNGlGUf5GeVopT0A3A?=
 =?us-ascii?Q?WW5D84RAHGExT4U3ofrLilXQlCiwhpUDCmxniZWihXkSq+BTd4y51w1Em43f?=
 =?us-ascii?Q?4idxW1n5icxt2DhK7zj/Uo6KVNdZp6nIhTsttdcrt/GSQWuh3vAj/lwlviyi?=
 =?us-ascii?Q?lSb0LaGWZOU4/XLNzByCekfQ6nidN/gLpfxLjTUHBNPvDlaWIdoStMSCeznz?=
 =?us-ascii?Q?asij2A8UXioJkIi8lAXTgXQNo41IIEShY31LWUThqduSas41/Bxnn0EgJgl3?=
 =?us-ascii?Q?scFxm8Kz9R0Zv+C96OWpDG/l3/8UpcBIru0BntkB6BQ0r4T+kpVlVk/RuHMj?=
 =?us-ascii?Q?PUEGIXBwv3NH1YNA/sMU9CrMkRRMDLymmloMgINcd5a4XcCX8EgpXDkfQ+zX?=
 =?us-ascii?Q?mHVYIoiseDFwR8YphosnVhGep9KahL6gwS4QzZJHRdWaoizvgwouuLVlSg4S?=
 =?us-ascii?Q?jg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jWekm3PupVf5cVqrmqnttxTmmRH3dNHAuZgB7c1XfELn4cA2kQh8l8m9ivHXfJcHpSpSfHL4OPCn87+oclxh+3l6aPQS6QT2bzp9ePcShvqqExXdGou5E53usLuTzGRr21B3u5oROd+9D1TK9bsyDYGBZhM/qyFrqk/D4mq+eAwRwtsmxRSH4VLRafzYbJRy8T46WR6E1PqZ493v1XkHCCX1BH6VQYkSgCOz6eg1nIRk0kNX6iwE8GOEeuhCVh2Td7rbl5Hlf2KFQ87fBux4jCKx3Al/jAD0iKXWRjbL1mXpCmJUS2+gRiQ/HJlOqwRW/m6VJKyrLyRt5nQMydUEnZAJnvsVh4eSD1XwdWnhsoUqGVFhtpkL+wa0sBoFTjdElMOlQNDMapAXrRgLu1IAnSQSnWU8yZw4T/O6ayGSqBB/CKbz9RC3WSV/fQtIyBADvoKaYH8MoNR7tKw/jCI1jxjEoUfr30Q9HqfHqY3elfE41wy/oWeFj4A/hJvQOS3EFqzBGYTzg0ipOdOKk7yY1sjdhxYCp06MaupCUE13XbhU7BpoQDnh8iyJnnnNdn6XTqTJ+9RqvIk4unjMicpzuP8RyjNn9Eql7PqtwRQ0NKM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 594477ea-8ea0-4138-0d54-08ddf1e6714e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 10:23:40.2930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CNhkoC03fEY5nkn7DR1tkH0T7GlFCmy0WGBM4DcOO8tLfCai0Xsh1jVTybo49SlD8Mg1c/EPV7P6TUPOqHJP4NROQs4efEON3/z94dSA/UA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5566
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_03,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509120098
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE2NiBTYWx0ZWRfXyhP/CVaBRTwi
 fwqi4D8Yv/6pELjMYH3VE+YWXMb+T88UZbo7wDh5r9JQw9f3hFotMmyr82uKUUs/OBx4uAoIqJY
 tkZ0FOFWLWgb1VWnEYR45Cj72lE+TToF3Nr1EOcm0fFfOyTseKqyyW+33BFidF/99UExLuJeiTH
 qKYs3ZjdQrPzf4uvsVTkujLmRbMqiyoe4GPEzlxOCdh2lZenWW8ctApfbfdmlkB+UOtnIrrL1iH
 GbNCJAZe0ddFv+kGl7vPHqIsXwysXfYfIRSjqXWa5jTsbhChV2CASqThfaVaitYw5Cg5XHZUHPK
 O6A5H2nJxPES41cf4VWwcFmGLD/oDuHuLcslyk64tIA3gwfe3SBccbmRq4P7bAc/YHXionC1zfJ
 +yjxx20zdCrsvEb/E8AXIFmJDUWb4w==
X-Proofpoint-GUID: tCtBY4U9LVT-Y1ykAU_TaNUj0fyoN4CG
X-Proofpoint-ORIG-GUID: tCtBY4U9LVT-Y1ykAU_TaNUj0fyoN4CG
X-Authority-Analysis: v=2.4 cv=LYY86ifi c=1 sm=1 tr=0 ts=68c3f4b1 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=fYYJ4SnnAo5NHOqtqxoA:9
 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12083

Hi Andrew,

Could you apply the below fix-patch to address the delights and wonders of
arch-specific header stuff? :)

Cheers, Lorenzo

----8<----
From 1a8ddbbb3aab15104e7b7b5b7a5a286dd23d8325 Mon Sep 17 00:00:00 2001
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Date: Fri, 12 Sep 2025 10:58:23 +0100
Subject: [PATCH] sparc fix

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 arch/sparc/include/asm/pgtable_32.h | 3 +++
 arch/sparc/include/asm/pgtable_64.h | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/arch/sparc/include/asm/pgtable_32.h b/arch/sparc/include/asm/pgtable_32.h
index cfd764afc107..30749c5ffe95 100644
--- a/arch/sparc/include/asm/pgtable_32.h
+++ b/arch/sparc/include/asm/pgtable_32.h
@@ -397,6 +397,9 @@ __get_iospace (unsigned long addr)

 int remap_pfn_range(struct vm_area_struct *, unsigned long, unsigned long,
 		    unsigned long, pgprot_t);
+void remap_pfn_range_prepare(struct vm_area_desc *desc, unsigned long pfn);
+int remap_pfn_range_complete(struct vm_area_struct *vma, unsigned long addr,
+		unsigned long pfn, unsigned long size, pgprot_t pgprot);

 static inline unsigned long calc_io_remap_pfn(unsigned long pfn)
 {
diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
index b8000ce4b59f..b06f55915653 100644
--- a/arch/sparc/include/asm/pgtable_64.h
+++ b/arch/sparc/include/asm/pgtable_64.h
@@ -1050,6 +1050,9 @@ int page_in_phys_avail(unsigned long paddr);

 int remap_pfn_range(struct vm_area_struct *, unsigned long, unsigned long,
 		    unsigned long, pgprot_t);
+void remap_pfn_range_prepare(struct vm_area_desc *desc, unsigned long pfn);
+int remap_pfn_range_complete(struct vm_area_struct *vma, unsigned long addr,
+		unsigned long pfn, unsigned long size, pgprot_t pgprot);

 void adi_restore_tags(struct mm_struct *mm, struct vm_area_struct *vma,
 		      unsigned long addr, pte_t pte);
--
2.51.0

