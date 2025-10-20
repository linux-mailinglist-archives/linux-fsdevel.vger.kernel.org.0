Return-Path: <linux-fsdevel+bounces-64698-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 34394BF1163
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 14:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id ADC4C34A936
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 12:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2551328B56;
	Mon, 20 Oct 2025 12:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WqI79/tL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="M6tMZrvt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A493128B9;
	Mon, 20 Oct 2025 12:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760962397; cv=fail; b=bMvebosb4wg3ZwUaTzuKuYPbeL6sYmt0ZaFeoyzwSizovAZMD+aHGITSneLzMrCO3beuCihWw42FTejQ0PiiLc8FewY0PS5baWCJ3GZC4WLhD9nT6RkKz0XhR8nVeENa307lmE0QQrZw8fBuRvDp3PApF9MNLiS3/Ha8piwp3Xk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760962397; c=relaxed/simple;
	bh=aMiufjhoAxFhhjDrgtzoVZ0huIAWAgAavOwdcQ8af4U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NSWW0RVr0jwczjJ0e7GVD0VjbxXG4Du5xVi5lr94vNplW6932y+xYYxM2cGPUeYdWSGUOSdsPcBy3WnIvLZQqsAppIjONQQVjYZv8xsMrvOGbdkAomHqFceHU4PVNfhCBa7VGYmvqrdgnrhDmpL12dp0bNZZn2mpiQ38kdIDdOk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WqI79/tL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=M6tMZrvt; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59K8SDI3006212;
	Mon, 20 Oct 2025 12:12:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=ObEjgOxwHkwA9sx9fkBB5bLWzMG3WdVxAhvSdpXgsK4=; b=
	WqI79/tL2Ha9pTt5aHiNfRindKnOLcws45bb4VrlpL2D71uT9EzOCHeOBMyaWbrp
	0iQsY5pY9Cpmyjb3S+r0Lvj60/pBnsesNGFgK4ZDTngSgG7hz6Uo9q8o741ePvCP
	BC7zXF00/TZ52SMMdVNVC/5yB3TlHirrrlfEYHBjSCHpW8afXrtxfDOx9sHdRRHO
	6kDMKGuu3cIFhhlQ97pV/qvHY7E9t3Jx9cJGP05Lr2nryoOota7RI0Xt3wuLDkGb
	+OypfXja1dBW67KfvGG+VryI5P/Mq5rbZqs7YunKhCkYaTO0PcYGd3Ouo/kgW4Yb
	KOrTmxPKfOxUbSXI3hYv9g==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49v2vvt4b7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Oct 2025 12:12:09 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59KAgp80009470;
	Mon, 20 Oct 2025 12:12:09 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011044.outbound.protection.outlook.com [40.107.208.44])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49v1bbvbac-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Oct 2025 12:12:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=szvwhmStQHQVVeFBnQeJMtBKtMQ6JIPYRQeaR8hIn96hwqhmhT+WtQ1cN6Z4HRfPB97WkDCn3QahyRXl8+VW86Fm2IQCvaxHWwFtl1GfxPkjNtG85uWZHjUwMt/8Xwm9gEX0TD9OILCUUqCwcIj/6dj4z+fYGhzmJxnvP3+P37k1VgD2uP88IiepJ+TQpR/djubZPETQ6/H7QXCCtcYF8bNRVCf7qrShO3e7MuDkZajQPdz8rrXVRbNULpX2ou4SSOx9dJ6MYDFLZ/QUoXc6T9tRlsNk1kkPSrN2zUBIeXJE2+mWdwnJBudnuFj7Alpzk+ebjojtqO1cv5eH/kP3sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ObEjgOxwHkwA9sx9fkBB5bLWzMG3WdVxAhvSdpXgsK4=;
 b=RzHJ9LpLb68CmSYPtrPd67D1N+841XvwnB+OmvjhsqowEb+BCMHqPCnrG+0Ivl4WP4TrKYfIjKSCdUhM6TijzkBYe9BaxVTVe2h+RT9n2U/Rsz5mPpAaceXPD3rYsObwQzuC1ozftI8ix+mtTeeJ8HTFpdUibzCB6M1a4H+tUFtv8QRApy30WfQLM4nlhJEHx6npja3xY98iZdEIQKgZMR/CJcxj27vqD9laLqgHbl2I7iFk2frKALdBNAmdKWpvC4TwMYhFldCOwWfTyfyKyy5TrDTockaI41OmoRZ0Lez4DGyDliA7RrI7yHQ6drFDL5JCGsrqr5oHpF48TBbyqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ObEjgOxwHkwA9sx9fkBB5bLWzMG3WdVxAhvSdpXgsK4=;
 b=M6tMZrvthFSo9Ic0cym//FDYJXwCe/clS7Aimp55RjkCX+EHevz5DNGAGOZqJADl4bDLCJlNWn9cxp5rD+gstn1/SD4LiG/SZAMQvpovMtoR2OhiYK3NGsweJ0AZqTDSNrwGSkk8nWZAjTQjNvUB+ojlPlKP7AnTZKH37EOFVaI=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DM3PPF4A29B3BB2.namprd10.prod.outlook.com (2603:10b6:f:fc00::c25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Mon, 20 Oct
 2025 12:12:04 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9228.016; Mon, 20 Oct 2025
 12:12:04 +0000
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
        kasan-dev@googlegroups.com, Jason Gunthorpe <jgg@nvidia.com>,
        iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>
Subject: [PATCH v5 12/15] mm/hugetlbfs: update hugetlbfs to use mmap_prepare
Date: Mon, 20 Oct 2025 13:11:29 +0100
Message-ID: <b1afa16d3cfa585a03df9ae215ae9f905b3f0ed7.1760959442.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1760959441.git.lorenzo.stoakes@oracle.com>
References: <cover.1760959441.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0409.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:189::18) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DM3PPF4A29B3BB2:EE_
X-MS-Office365-Filtering-Correlation-Id: 58cfdd4a-c6ea-44c3-8ee8-08de0fd1e1d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oP+d3+g6dfoR4UhdkRmFVQwAwoitjNfexCk7xw4WS5z55StXmUjEY4Y0NqIe?=
 =?us-ascii?Q?3J638JpkgGyzCGNSpFw/LahGbCzw3cbtYhegk8dK/2hGMvHL9HtpsSas3IAL?=
 =?us-ascii?Q?nmwyATdTU2T183xlGKvh9akoQRQotCCK9uEom7tDfeoZpXiJ497ByYe3e8wy?=
 =?us-ascii?Q?OQ3ZtfPdx6Q6bby1pGxjJLtimWlKUZHYSoZQWrvUJkdUMQ+drtMHigetmpJU?=
 =?us-ascii?Q?W5rRWRwgKRcEu1e2E1K6PHSFKCXMzxPssFAsQ+Hb3+WTwDE4K/AqIGfKsXAV?=
 =?us-ascii?Q?ciEOxr9zUOTveO2gSQMIlDYBbN1ILSLHgJb4tRuyXEJpMQiBOqie2qMbiddv?=
 =?us-ascii?Q?tM3+i1YKwntXwnHpMYzoFYY0EKE4vN/nye3bzHppH6Jeah8N9G4fWLTWOJ6k?=
 =?us-ascii?Q?Q83ao2e3w+MPm+8Wc/yd8PjBo6uxbsZZFCd6CY/T7sTb9PjP7r3hzBKkX8Vn?=
 =?us-ascii?Q?6hRvYjt7a3UyHCkpItWUoM9hdNoutH/IJ/LaR6pORQzJ5/N7YcTYHvLZJVYY?=
 =?us-ascii?Q?rAb9TWQ8kzNRsHS3/BvV/jZZqDMAW4bJX3WNdz8HIJByeGRQ+J8K7sSQ44Xt?=
 =?us-ascii?Q?FNpQJieqKWB6H+e+VyTMKuXwIlmVNGCH4uHwp4aDdJVA6HEgkF4UHIGq2kY8?=
 =?us-ascii?Q?ReNG21Qwk15WI4J8Ewzlt5MUL73kk3s/WFQMpQwZ2Sjh8cGbueLwJSslI2iR?=
 =?us-ascii?Q?W6o3FKfxB/nOvQ7CHTQhHTykxx+r4wIRPJiqZxnATC4tbVDvATvUTxGoQTOz?=
 =?us-ascii?Q?PkwqB5Yfh2sSqXYkJJlcbS/2xygEkKdAEMn1CpJF8QZDhl43TfosNxaQeK/1?=
 =?us-ascii?Q?EqEM3uIPT45Wou+S3hknSpGyTSbkU3U/bcW7cMkfZh1wKwO4NMHDX+9d8coV?=
 =?us-ascii?Q?XCydXUcgmLnz7KqJ9fYHvzhQbiSNti8CDs5rC729hHq8/l+aOYhkN/EC+aNQ?=
 =?us-ascii?Q?hDnv7LCGA5NgJAxGfBU35AkY7YjpM8mBuJgMV2BYg9juy1dmq3z3TXA61wqd?=
 =?us-ascii?Q?V95FUajQiLZDTZ1d6OvmNtImncpUzhAMJLx/ybcJXSGU+5wSGkBgNDU/4SkX?=
 =?us-ascii?Q?R7JNEsM2Q/LxUo7IrHvCsgd6mJREyXrEsjW/rGRhD4HfV/rTtsrtQQKK0jul?=
 =?us-ascii?Q?CrgGmcrMFIfqn2hbu6NkOOjkJ3piVJUrHVuFr5ICubXEO8daAaNA3ks0pknC?=
 =?us-ascii?Q?o00TXq1d58XmoBeUSHcx5wIG8kb3ytS/OHMxQw8i4VdOBAbzNZRttGWBb9hy?=
 =?us-ascii?Q?4C7dEKT0+OSKajtr/R4fSIMm8VmtmXMN8cSU5vnxaCiD4NUIcNqPTgPnJk2B?=
 =?us-ascii?Q?HhkOrCxRNF0XTiPO6S+r/JazeibKeC1wSvG/Y/sIy0RpxXvkUmg8Ad0FZRM2?=
 =?us-ascii?Q?Q+GdO436VzezdhMuIa5xgVdnQ3XXdgeG7S6+Brhgr1ISTZ5wO9YkmFKnJ5CV?=
 =?us-ascii?Q?5+HsI1GOkfftWkl1h1ABn2yaeYTxUvzz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SHA6lV0l3KM4X05EBXIq0k7pzgG92m2r1LOhQXaKnqOKbgUhcI8HddtZ9MP+?=
 =?us-ascii?Q?g/+tIwnn+NQ8ZcuXgbQSCgu5s833CdixVfWzKNGiaPZU2vK7ej95dE13oJ/Q?=
 =?us-ascii?Q?ZQjeCTbF6yqBTmcVB9DBIrIJUhiI4KnGFiV3jjChkC+0EmQzdXFBL7uqmlNj?=
 =?us-ascii?Q?S5H0oP4a9BU0lomCUXXfhUnZLE2M3mdLzKSpnI7/T+64ohpW5my9ScPuBeH1?=
 =?us-ascii?Q?9X54oSIiGw6VcDiiJGEJOPjT7feOyQG3GKwvFUy8kb3gretdTUv+eFDe2JDw?=
 =?us-ascii?Q?aofSXRJ5a9aAxVOJMLSoqvK+oUl7NlYDmxLIlopDTOtgyi9WriUWR05RAhVQ?=
 =?us-ascii?Q?CPez/zMDl9uKxpfXlBBrB8BpL1VtDrKsDKgithRU5l6o/y4DS64OPqzvlI3w?=
 =?us-ascii?Q?8vzmimBTwqvGhsIibcAiV0uP8oc3WcHuAx4CO06wTuogj4WSyruJ2gI/cZCx?=
 =?us-ascii?Q?UZnv2SofQ+cFauMEqiJxeYGXYkSOHP7pdz3NKfrvk/PEkGVai6i7TB+HaaVY?=
 =?us-ascii?Q?jTsTYhdeuYw2AX7DBA99H7ZabsnHeGZ6IIf7w96O2nrgzfAkpluRWpvNCuoA?=
 =?us-ascii?Q?CIOeugGz45CSYCS49/D9C8ReCa/w2QQnL272TRmNhFqmDEHXEtPeu6b4mRev?=
 =?us-ascii?Q?1SLj2lRoLc2vful9FYeQIOAaVJWkWU2MD8zNXvarKL32AkS0zOjkk4CAwhAE?=
 =?us-ascii?Q?CLhQVBPOvx1Fe2JxTnloJAxveiVgFrLIkYjUQ2H3bjwpFmv62JiLhqROsVEK?=
 =?us-ascii?Q?zDsBSAIlSxAfgQ1x/LESbv7Dfch6n+HnViohU81R5cx0pIwPv9CydsxNt5Nv?=
 =?us-ascii?Q?ME5lWjU28g6ZACVsJJHELtCwCd1hl/kxTTg7PeotxrJAl3/ehpym8xwAYUFj?=
 =?us-ascii?Q?q1yiMRu3HohQ+Z6tO0Bd/sO25zJqU/3Ny+H48JqBKWS5W+aS+yZSct5QRxch?=
 =?us-ascii?Q?6lg3Bar3rNIKcabC6W4J3YAlMFNiT3nA/BJbFhJDFi0P1l/j20cl9LMI2Skt?=
 =?us-ascii?Q?/6WckLBmsu740bjJRrPdmRPu5wt6LOoO33LdqXPYMpviG8RxzmFfHvOZrl74?=
 =?us-ascii?Q?1S/Jyg6KLoIywVQVF7GUdNqzRnYB79aSDvaPusv374U4pa5BokVWes6e+/9+?=
 =?us-ascii?Q?JnsRUWe0F4WkElO1XOvaJbz+PRR2Tajn0pryfQ4YEmENwpQQBZMWQWWjqAg5?=
 =?us-ascii?Q?iUO8QNij/D4yJpu185vJ1IVR7YwjQfmav5UNHm60a9z0OWoj83tqtZNPeCjc?=
 =?us-ascii?Q?Fz8cUrB9+FjCK3JxCi80SeE+Gq2BhEbQ/SPz68Rov4Yfu6yD4d9L75yURcG/?=
 =?us-ascii?Q?ARnwLFS6JVMkzcqUDH9KkGBxI1ee7FxoU+GxTgnjzH40KDDGVxlLZJTGJyKc?=
 =?us-ascii?Q?ZcAFF8ImXrzZyhartBYRcd0q2eqvUsiHPgqYI/koechjTVcrbg6XL/e230Ct?=
 =?us-ascii?Q?KUWYGN84S0K1t9qzP/pj9uLizOAdsqNLHgK0BM+4SoeShYrnCPDvwwx8XaVM?=
 =?us-ascii?Q?pSaz2GVkI9G7OB/pMoJOpu7dqr9GeW+H3H5fjAZaO5hlEksmNmVOc1gDr+Ll?=
 =?us-ascii?Q?EKElsOyix57Fjv71NzlArFvJKzoL2HzpqiWDu9mbUMWA/g/PSzvJs+Wi8no6?=
 =?us-ascii?Q?cQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Pj+gh6aABjPkFw0KFr1Ms+4uyBCYJpSGoGjlKwjWUavgCRf9CLKEgWencWeutqhrCrUIsTl1GJzmv4LKEm3JkTksl/PdwNpVx3uGHJ+MHaxUVtHtBKPL0Z2VFvW6h9yBthPv1k1X3F3+yDx2ustF9AkjlKRcQUkmV+Q6Riga3VQzowcG5QjSPGHVrTu/ts0vfrTaaZ7wHbsEPaDAYZMg3ZH09YF7R05uAGqBRtvSi3oiCnJsrJ3iUnqiGB6rCTjn2wW3m8MeQRDGojAdoiNF6R4Dta2iyMI+MvZiYb7/WkCK7U0CieGJwuxNIe5A0BEQJkRZEH5S6wbeoG09iEmI9a2l8qmQ+bYaGl31bTzCfGXGz4S7NqIQqidvyevHSrvhe+5oM1IQaM8FAi8MUUqFVXU00JyIvsF9koLoeeP5bjaUo4qX0t4/BIA8k3wq15V8ApcgZDvvSajqHHN1J8jZB3L4nPH6PsvAu19eTapHw+RknCpAz1vD3N57AVP2EiWhRenf3KC0+urXoK1pL4HcUyqhOPjsQPMN6mS+oZpYFvjGtEo6sLAWl0YADSyqjW6t4JP+TqLZxrZxacxkrcv5oNA8cR4OluVRATwf+AopyyU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58cfdd4a-c6ea-44c3-8ee8-08de0fd1e1d5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 12:12:04.5475
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +pN9bX88+DA1n/OUOh0ymR+jgwp7k+0lisa1Rh1/2yIU1I0HJi0dgj6Kg3wRUP3ou9MEKU1U/n/vhXYgnQa0kFflnkee/ty8IvLv/d3Nqws=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF4A29B3BB2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 mlxscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510200099
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX+zPT+2P4Z53k
 7XU+OBvNEqD+k3s3fyFIUn9MP0eZ92w4QyBp+bBuqVgEJxUkJ19yByt6hazFYLW066FgIDvTLaK
 KO4alDZG65q0EkQOA6XSXXiTzMHd6ECPCwlw9tiz65VHBRhEziusTax18nxTqAiJga0c3wX8U+A
 MBH5XaM4GIDd+MWdUj47jqVEOj0zmQPTCMBDHn8si2yrBJKkSpZvffQjV9pNQprK+tNaxZzQbRZ
 odxykOefG3gusOxZ7CjsEIdqsXF3JM/zyvU1Vo7Jjk7R3OMkuhCxe6ClYHkWmOTZJo7UtebwkoR
 Z/IKK/cfTwduC9KJBYjo2nYad052ffbNfYafZ5Wl6mfB/A0XfUKvYHALQnkD4ibCE/ovovcwa+h
 +UuC2DxYo9c7j7XCzb9av6V+CF/5OQIKQuEPdyDivfzIQhIviUs=
X-Proofpoint-ORIG-GUID: Pr2o_x30c9Z3FWPZJY0Vl8qfTBr1P2iX
X-Proofpoint-GUID: Pr2o_x30c9Z3FWPZJY0Vl8qfTBr1P2iX
X-Authority-Analysis: v=2.4 cv=FuwIPmrq c=1 sm=1 tr=0 ts=68f62719 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8 a=Ikd4Dj_1AAAA:8
 a=9F4s-t-35SY1ER6Gz7wA:9 cc=ntf awl=host:12092

Since we can now perform actions after the VMA is established via
mmap_prepare, use desc->action_success_hook to set up the hugetlb lock
once the VMA is setup.

We also make changes throughout hugetlbfs to make this possible.

Note that we must hide newly established hugetlb VMAs from the rmap until
the operation is entirely complete as we establish a hugetlb lock during
VMA setup that can be raced by rmap users.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 fs/hugetlbfs/inode.c           | 46 ++++++++++++++------
 include/linux/hugetlb.h        |  9 +++-
 include/linux/hugetlb_inline.h | 15 ++++---
 mm/hugetlb.c                   | 77 ++++++++++++++++++++--------------
 4 files changed, 95 insertions(+), 52 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index ce8e40d35032..3919fca56553 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -96,8 +96,15 @@ static const struct fs_parameter_spec hugetlb_fs_parameters[] = {
 #define PGOFF_LOFFT_MAX \
 	(((1UL << (PAGE_SHIFT + 1)) - 1) <<  (BITS_PER_LONG - (PAGE_SHIFT + 1)))
 
-static int hugetlbfs_file_mmap(struct file *file, struct vm_area_struct *vma)
+static int hugetlb_file_mmap_prepare_success(const struct vm_area_struct *vma)
 {
+	/* Unfortunate we have to reassign vma->vm_private_data. */
+	return hugetlb_vma_lock_alloc((struct vm_area_struct *)vma);
+}
+
+static int hugetlbfs_file_mmap_prepare(struct vm_area_desc *desc)
+{
+	struct file *file = desc->file;
 	struct inode *inode = file_inode(file);
 	loff_t len, vma_len;
 	int ret;
@@ -112,8 +119,8 @@ static int hugetlbfs_file_mmap(struct file *file, struct vm_area_struct *vma)
 	 * way when do_mmap unwinds (may be important on powerpc
 	 * and ia64).
 	 */
-	vm_flags_set(vma, VM_HUGETLB | VM_DONTEXPAND);
-	vma->vm_ops = &hugetlb_vm_ops;
+	desc->vm_flags |= VM_HUGETLB | VM_DONTEXPAND;
+	desc->vm_ops = &hugetlb_vm_ops;
 
 	/*
 	 * page based offset in vm_pgoff could be sufficiently large to
@@ -122,16 +129,16 @@ static int hugetlbfs_file_mmap(struct file *file, struct vm_area_struct *vma)
 	 * sizeof(unsigned long).  So, only check in those instances.
 	 */
 	if (sizeof(unsigned long) == sizeof(loff_t)) {
-		if (vma->vm_pgoff & PGOFF_LOFFT_MAX)
+		if (desc->pgoff & PGOFF_LOFFT_MAX)
 			return -EINVAL;
 	}
 
 	/* must be huge page aligned */
-	if (vma->vm_pgoff & (~huge_page_mask(h) >> PAGE_SHIFT))
+	if (desc->pgoff & (~huge_page_mask(h) >> PAGE_SHIFT))
 		return -EINVAL;
 
-	vma_len = (loff_t)(vma->vm_end - vma->vm_start);
-	len = vma_len + ((loff_t)vma->vm_pgoff << PAGE_SHIFT);
+	vma_len = (loff_t)vma_desc_size(desc);
+	len = vma_len + ((loff_t)desc->pgoff << PAGE_SHIFT);
 	/* check for overflow */
 	if (len < vma_len)
 		return -EINVAL;
@@ -141,7 +148,7 @@ static int hugetlbfs_file_mmap(struct file *file, struct vm_area_struct *vma)
 
 	ret = -ENOMEM;
 
-	vm_flags = vma->vm_flags;
+	vm_flags = desc->vm_flags;
 	/*
 	 * for SHM_HUGETLB, the pages are reserved in the shmget() call so skip
 	 * reserving here. Note: only for SHM hugetlbfs file, the inode
@@ -151,17 +158,30 @@ static int hugetlbfs_file_mmap(struct file *file, struct vm_area_struct *vma)
 		vm_flags |= VM_NORESERVE;
 
 	if (hugetlb_reserve_pages(inode,
-				vma->vm_pgoff >> huge_page_order(h),
-				len >> huge_page_shift(h), vma,
-				vm_flags) < 0)
+			desc->pgoff >> huge_page_order(h),
+			len >> huge_page_shift(h), desc,
+			vm_flags) < 0)
 		goto out;
 
 	ret = 0;
-	if (vma->vm_flags & VM_WRITE && inode->i_size < len)
+	if ((desc->vm_flags & VM_WRITE) && inode->i_size < len)
 		i_size_write(inode, len);
 out:
 	inode_unlock(inode);
 
+	if (!ret) {
+		/* Allocate the VMA lock after we set it up. */
+		desc->action.success_hook = hugetlb_file_mmap_prepare_success;
+		/*
+		 * We cannot permit the rmap finding this VMA in the time
+		 * between the VMA being inserted into the VMA tree and the
+		 * completion/success hook being invoked.
+		 *
+		 * This is because we establish a per-VMA hugetlb lock which can
+		 * be raced by rmap.
+		 */
+		desc->action.hide_from_rmap_until_complete = true;
+	}
 	return ret;
 }
 
@@ -1220,7 +1240,7 @@ static void init_once(void *foo)
 
 static const struct file_operations hugetlbfs_file_operations = {
 	.read_iter		= hugetlbfs_read_iter,
-	.mmap			= hugetlbfs_file_mmap,
+	.mmap_prepare		= hugetlbfs_file_mmap_prepare,
 	.fsync			= noop_fsync,
 	.get_unmapped_area	= hugetlb_get_unmapped_area,
 	.llseek			= default_llseek,
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 8e63e46b8e1f..2387513d6ae5 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -150,8 +150,7 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
 			     struct folio **foliop);
 #endif /* CONFIG_USERFAULTFD */
 long hugetlb_reserve_pages(struct inode *inode, long from, long to,
-						struct vm_area_struct *vma,
-						vm_flags_t vm_flags);
+			   struct vm_area_desc *desc, vm_flags_t vm_flags);
 long hugetlb_unreserve_pages(struct inode *inode, long start, long end,
 						long freed);
 bool folio_isolate_hugetlb(struct folio *folio, struct list_head *list);
@@ -280,6 +279,7 @@ bool is_hugetlb_entry_hwpoisoned(pte_t pte);
 void hugetlb_unshare_all_pmds(struct vm_area_struct *vma);
 void fixup_hugetlb_reservations(struct vm_area_struct *vma);
 void hugetlb_split(struct vm_area_struct *vma, unsigned long addr);
+int hugetlb_vma_lock_alloc(struct vm_area_struct *vma);
 
 #else /* !CONFIG_HUGETLB_PAGE */
 
@@ -466,6 +466,11 @@ static inline void fixup_hugetlb_reservations(struct vm_area_struct *vma)
 
 static inline void hugetlb_split(struct vm_area_struct *vma, unsigned long addr) {}
 
+static inline int hugetlb_vma_lock_alloc(struct vm_area_struct *vma)
+{
+	return 0;
+}
+
 #endif /* !CONFIG_HUGETLB_PAGE */
 
 #ifndef pgd_write
diff --git a/include/linux/hugetlb_inline.h b/include/linux/hugetlb_inline.h
index 0660a03d37d9..a27aa0162918 100644
--- a/include/linux/hugetlb_inline.h
+++ b/include/linux/hugetlb_inline.h
@@ -2,22 +2,27 @@
 #ifndef _LINUX_HUGETLB_INLINE_H
 #define _LINUX_HUGETLB_INLINE_H
 
-#ifdef CONFIG_HUGETLB_PAGE
-
 #include <linux/mm.h>
 
-static inline bool is_vm_hugetlb_page(struct vm_area_struct *vma)
+#ifdef CONFIG_HUGETLB_PAGE
+
+static inline bool is_vm_hugetlb_flags(vm_flags_t vm_flags)
 {
-	return !!(vma->vm_flags & VM_HUGETLB);
+	return !!(vm_flags & VM_HUGETLB);
 }
 
 #else
 
-static inline bool is_vm_hugetlb_page(struct vm_area_struct *vma)
+static inline bool is_vm_hugetlb_flags(vm_flags_t vm_flags)
 {
 	return false;
 }
 
 #endif
 
+static inline bool is_vm_hugetlb_page(struct vm_area_struct *vma)
+{
+	return is_vm_hugetlb_flags(vma->vm_flags);
+}
+
 #endif
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 7774c286b3b7..86e672fcb305 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -119,7 +119,6 @@ struct mutex *hugetlb_fault_mutex_table __ro_after_init;
 /* Forward declaration */
 static int hugetlb_acct_memory(struct hstate *h, long delta);
 static void hugetlb_vma_lock_free(struct vm_area_struct *vma);
-static void hugetlb_vma_lock_alloc(struct vm_area_struct *vma);
 static void __hugetlb_vma_unlock_write_free(struct vm_area_struct *vma);
 static void hugetlb_unshare_pmds(struct vm_area_struct *vma,
 		unsigned long start, unsigned long end, bool take_locks);
@@ -438,17 +437,21 @@ static void hugetlb_vma_lock_free(struct vm_area_struct *vma)
 	}
 }
 
-static void hugetlb_vma_lock_alloc(struct vm_area_struct *vma)
+/*
+ * vma specific semaphore used for pmd sharing and fault/truncation
+ * synchronization
+ */
+int hugetlb_vma_lock_alloc(struct vm_area_struct *vma)
 {
 	struct hugetlb_vma_lock *vma_lock;
 
 	/* Only establish in (flags) sharable vmas */
 	if (!vma || !(vma->vm_flags & VM_MAYSHARE))
-		return;
+		return 0;
 
 	/* Should never get here with non-NULL vm_private_data */
 	if (vma->vm_private_data)
-		return;
+		return -EINVAL;
 
 	vma_lock = kmalloc(sizeof(*vma_lock), GFP_KERNEL);
 	if (!vma_lock) {
@@ -463,13 +466,15 @@ static void hugetlb_vma_lock_alloc(struct vm_area_struct *vma)
 		 * allocation failure.
 		 */
 		pr_warn_once("HugeTLB: unable to allocate vma specific lock\n");
-		return;
+		return -EINVAL;
 	}
 
 	kref_init(&vma_lock->refs);
 	init_rwsem(&vma_lock->rw_sema);
 	vma_lock->vma = vma;
 	vma->vm_private_data = vma_lock;
+
+	return 0;
 }
 
 /* Helper that removes a struct file_region from the resv_map cache and returns
@@ -1201,20 +1206,28 @@ static struct resv_map *vma_resv_map(struct vm_area_struct *vma)
 	}
 }
 
-static void set_vma_resv_map(struct vm_area_struct *vma, struct resv_map *map)
+static void set_vma_resv_flags(struct vm_area_struct *vma, unsigned long flags)
 {
-	VM_BUG_ON_VMA(!is_vm_hugetlb_page(vma), vma);
-	VM_BUG_ON_VMA(vma->vm_flags & VM_MAYSHARE, vma);
+	VM_WARN_ON_ONCE_VMA(!is_vm_hugetlb_page(vma), vma);
+	VM_WARN_ON_ONCE_VMA(vma->vm_flags & VM_MAYSHARE, vma);
 
-	set_vma_private_data(vma, (unsigned long)map);
+	set_vma_private_data(vma, get_vma_private_data(vma) | flags);
 }
 
-static void set_vma_resv_flags(struct vm_area_struct *vma, unsigned long flags)
+static void set_vma_desc_resv_map(struct vm_area_desc *desc, struct resv_map *map)
 {
-	VM_BUG_ON_VMA(!is_vm_hugetlb_page(vma), vma);
-	VM_BUG_ON_VMA(vma->vm_flags & VM_MAYSHARE, vma);
+	VM_WARN_ON_ONCE(!is_vm_hugetlb_flags(desc->vm_flags));
+	VM_WARN_ON_ONCE(desc->vm_flags & VM_MAYSHARE);
 
-	set_vma_private_data(vma, get_vma_private_data(vma) | flags);
+	desc->private_data = map;
+}
+
+static void set_vma_desc_resv_flags(struct vm_area_desc *desc, unsigned long flags)
+{
+	VM_WARN_ON_ONCE(!is_vm_hugetlb_flags(desc->vm_flags));
+	VM_WARN_ON_ONCE(desc->vm_flags & VM_MAYSHARE);
+
+	desc->private_data = (void *)((unsigned long)desc->private_data | flags);
 }
 
 static int is_vma_resv_set(struct vm_area_struct *vma, unsigned long flag)
@@ -1224,6 +1237,13 @@ static int is_vma_resv_set(struct vm_area_struct *vma, unsigned long flag)
 	return (get_vma_private_data(vma) & flag) != 0;
 }
 
+static bool is_vma_desc_resv_set(struct vm_area_desc *desc, unsigned long flag)
+{
+	VM_WARN_ON_ONCE(!is_vm_hugetlb_flags(desc->vm_flags));
+
+	return ((unsigned long)desc->private_data) & flag;
+}
+
 bool __vma_private_lock(struct vm_area_struct *vma)
 {
 	return !(vma->vm_flags & VM_MAYSHARE) &&
@@ -7270,9 +7290,9 @@ long hugetlb_change_protection(struct vm_area_struct *vma,
  */
 
 long hugetlb_reserve_pages(struct inode *inode,
-					long from, long to,
-					struct vm_area_struct *vma,
-					vm_flags_t vm_flags)
+		long from, long to,
+		struct vm_area_desc *desc,
+		vm_flags_t vm_flags)
 {
 	long chg = -1, add = -1, spool_resv, gbl_resv;
 	struct hstate *h = hstate_inode(inode);
@@ -7287,12 +7307,6 @@ long hugetlb_reserve_pages(struct inode *inode,
 		return -EINVAL;
 	}
 
-	/*
-	 * vma specific semaphore used for pmd sharing and fault/truncation
-	 * synchronization
-	 */
-	hugetlb_vma_lock_alloc(vma);
-
 	/*
 	 * Only apply hugepage reservation if asked. At fault time, an
 	 * attempt will be made for VM_NORESERVE to allocate a page
@@ -7305,9 +7319,9 @@ long hugetlb_reserve_pages(struct inode *inode,
 	 * Shared mappings base their reservation on the number of pages that
 	 * are already allocated on behalf of the file. Private mappings need
 	 * to reserve the full area even if read-only as mprotect() may be
-	 * called to make the mapping read-write. Assume !vma is a shm mapping
+	 * called to make the mapping read-write. Assume !desc is a shm mapping
 	 */
-	if (!vma || vma->vm_flags & VM_MAYSHARE) {
+	if (!desc || desc->vm_flags & VM_MAYSHARE) {
 		/*
 		 * resv_map can not be NULL as hugetlb_reserve_pages is only
 		 * called for inodes for which resv_maps were created (see
@@ -7324,8 +7338,8 @@ long hugetlb_reserve_pages(struct inode *inode,
 
 		chg = to - from;
 
-		set_vma_resv_map(vma, resv_map);
-		set_vma_resv_flags(vma, HPAGE_RESV_OWNER);
+		set_vma_desc_resv_map(desc, resv_map);
+		set_vma_desc_resv_flags(desc, HPAGE_RESV_OWNER);
 	}
 
 	if (chg < 0)
@@ -7335,7 +7349,7 @@ long hugetlb_reserve_pages(struct inode *inode,
 				chg * pages_per_huge_page(h), &h_cg) < 0)
 		goto out_err;
 
-	if (vma && !(vma->vm_flags & VM_MAYSHARE) && h_cg) {
+	if (desc && !(desc->vm_flags & VM_MAYSHARE) && h_cg) {
 		/* For private mappings, the hugetlb_cgroup uncharge info hangs
 		 * of the resv_map.
 		 */
@@ -7369,7 +7383,7 @@ long hugetlb_reserve_pages(struct inode *inode,
 	 * consumed reservations are stored in the map. Hence, nothing
 	 * else has to be done for private mappings here
 	 */
-	if (!vma || vma->vm_flags & VM_MAYSHARE) {
+	if (!desc || desc->vm_flags & VM_MAYSHARE) {
 		add = region_add(resv_map, from, to, regions_needed, h, h_cg);
 
 		if (unlikely(add < 0)) {
@@ -7423,16 +7437,15 @@ long hugetlb_reserve_pages(struct inode *inode,
 	hugetlb_cgroup_uncharge_cgroup_rsvd(hstate_index(h),
 					    chg * pages_per_huge_page(h), h_cg);
 out_err:
-	hugetlb_vma_lock_free(vma);
-	if (!vma || vma->vm_flags & VM_MAYSHARE)
+	if (!desc || desc->vm_flags & VM_MAYSHARE)
 		/* Only call region_abort if the region_chg succeeded but the
 		 * region_add failed or didn't run.
 		 */
 		if (chg >= 0 && add < 0)
 			region_abort(resv_map, from, to, regions_needed);
-	if (vma && is_vma_resv_set(vma, HPAGE_RESV_OWNER)) {
+	if (desc && is_vma_desc_resv_set(desc, HPAGE_RESV_OWNER)) {
 		kref_put(&resv_map->refs, resv_map_release);
-		set_vma_resv_map(vma, NULL);
+		set_vma_desc_resv_map(desc, NULL);
 	}
 	return chg < 0 ? chg : add < 0 ? add : -EINVAL;
 }
-- 
2.51.0


