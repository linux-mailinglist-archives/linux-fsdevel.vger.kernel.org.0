Return-Path: <linux-fsdevel+bounces-61295-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC0DCB5755B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 11:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B76027A73E6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 09:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE5832FA0D4;
	Mon, 15 Sep 2025 09:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rMw7gspP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DCs9bAGE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CBCD2E5418;
	Mon, 15 Sep 2025 09:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757930272; cv=fail; b=dcdhq4Q5awBV6H3yj8YJ6Rm3tHcSdwZuUxC530gZBQqCGqmjYNl+Tm2twg1MreHlUYxl9OcrYghn/RH3Pi+CBFcX9DFh9kpVEPpPEAjKYvb6kUhTSNpMsfm0ruyrWxqQYT0YGXB+IEw3HiKIZcJ6lYTI6JwMW8c2bns7cRgEVWk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757930272; c=relaxed/simple;
	bh=v6Dbln36Zn0Lb5KH2xJbNVrn5XL+rbK9WVmHlOrlGO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CQNZmYfRXxzmEEp7OdxzZtBrPUbjVqOKxpS7/x9uo2nP0c9h+nxmwplWjiBSSrYa/A2Ee1loV6vhqXHs/XI7P+HTeg/a+w9oho/dMfHZHU3I6s6CGhp3HWQAcEsVZnJU0VnIPopUEIB3hNrBKnHeruUG93zBQHu2/4cydLhULY4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=rMw7gspP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DCs9bAGE; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58F6gQYm022638;
	Mon, 15 Sep 2025 09:57:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=/wkc669AO6jgM5yymR
	9qF0MafcU8/yUkP+TEYQAKZlE=; b=rMw7gspP0O0+O9mUDykifgrwOQFmnZoOCc
	TAyJaas6XvQDtk7RC3nOnm/AhsybgAuHVRC7o8xuV4fXaT11RzYo4JtB2JC4qqis
	u7eW9iM8kacTH68nwSW0cqDX+NMSQBQOxkkNkUhUXl4k95MgDAD7ecLFnIik8UEl
	Dz9Rxwwdf9PSFIO72rz0zLR3pcuAo3S1w/cJx6zFZIxiYYWZ6lcR3VdqhOVKhAoh
	ktffMZg6ANRmMiHpoYz09GKu1DzdYAkQ/UiRfiGQgfl+Au2UU8SuVV22jCqJuRig
	dYvIGJtGl8DFFvjj5gpckU8ajW48avKbRkjPUBWCfDk/4cLUv+Ow==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 494yhd21nk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Sep 2025 09:57:03 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58F8kkf6010551;
	Mon, 15 Sep 2025 09:57:03 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011041.outbound.protection.outlook.com [40.107.208.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 494y2aswh5-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Sep 2025 09:57:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oUxKtBrnLGVDjwB0zWPN0skHX3AtfKIZ3g+SWXmC9HfnXmbSocfwHhMslWpX563gTkaF3uPhqJYDZbxGc3JnjvRHEdNwQWwspOGiXGFgb1owP3HWqTlk4Bklkz0/kZr631Q0iLrkr/acg54bTsAPPE/SWT3bsn7vv2UYM10G8Y6kcLJh/q2ci9T+JX3/5WG2v0jeLeK8XAaFahvpfsdPkH0dUcomBPdVC4kvZvlQxwDFm8aatGZ68r7NYiUe70ZM6OUPdeTo7V+lJPGIsMf/xMgKEa8ebNTVkzHBw+L6kGILcBp5QAa8UPiw0JrA9wkQtnki+g1NP/Dn4N8we1Ilhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/wkc669AO6jgM5yymR9qF0MafcU8/yUkP+TEYQAKZlE=;
 b=x6egClJm/VSQNFDrM7/Dy7aPPmAkz9whIcMyvi1gqlSLNjXPrkGp+vz9dcaZvf3mkhZEO5X0555jtpBrK2K9PVhx6ll3Z5Vadbv5t3lWszvtspLX1TdOPb5+RanCZMKqP85dU9n9yzHgHNDUilttVlIOC32vnMxBdBzC//uBYrbJ7Jq0A/7S4f0pIeznKKEfSZGl+M+ImgHhpzLllbrE5oLgdVg2mFCn1kmvwEKB+w4hEnAqEixfjd86bEFuCHBjghUCDEfypcO7S72jr98lzg4tglHwvuzsh3YMP0cZrskctpf5zMdSVhAroEM1klAl6jomJ+v+Y1pI+mKnjI+c4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/wkc669AO6jgM5yymR9qF0MafcU8/yUkP+TEYQAKZlE=;
 b=DCs9bAGE07GrGz83PXpWb/m3gXhvfp2AbZ7wp0FfInU1IuDdINcX2u4eXBw1zdw+TjeseEXUUukbYs89rx3ccBzQFtBSHbXII2rO7IPp2Q6iAfr2reJ9wT/eo5ESz6fzmX/3HnZI8fYMJnyg6orU2I8PlSjVMU2cAMim4wWud6E=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CY8PR10MB6611.namprd10.prod.outlook.com (2603:10b6:930:55::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Mon, 15 Sep
 2025 09:56:59 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9115.020; Mon, 15 Sep 2025
 09:56:59 +0000
Date: Mon, 15 Sep 2025 10:56:57 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Chris Mason <clm@meta.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, Matthew Wilcox <willy@infradead.org>,
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
Subject: Re: [PATCH v2 08/16] mm: add ability to take further action in
 vm_area_desc
Message-ID: <29510ad8-a240-4ab8-8af8-75e3f377da78@lucifer.local>
References: <cover.1757534913.git.lorenzo.stoakes@oracle.com>
 <d85cc08dd7c5f0a4d5a3c5a5a1b75556461392a1.1757534913.git.lorenzo.stoakes@oracle.com>
 <829e914a-5413-4377-aeda-fe56a56dad0a@meta.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <829e914a-5413-4377-aeda-fe56a56dad0a@meta.com>
X-ClientProxiedBy: LO4P123CA0169.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18a::12) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CY8PR10MB6611:EE_
X-MS-Office365-Filtering-Correlation-Id: 27337ada-e38d-42ca-a2d6-08ddf43e366a
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?r+IEYh8bVGf3S++9EPuEUifp45wJumrN64GOsmTZhdnR+ULO+DZwNPzy1gLJ?=
 =?us-ascii?Q?/ZnLSLuxEFhHXzDDRR9EgV7/W/AOPotSyupHn/36zcBfNz9NOBG8Q3FdGdpq?=
 =?us-ascii?Q?i1KfY4Dzy+VAQnTOJLs5L+AGhhPWJ+katL7zH+eL0mrtvn53tAAdqPhjbLRl?=
 =?us-ascii?Q?RDsExcIMa1HxvnuEyloO8CCi1mPna0kurP2/lepE61dTlOKA8F83thZNciw0?=
 =?us-ascii?Q?dtlRmoINP7WyYHI4k0Hyqo31YyHyX8Ga6kqZ/pUKOU1om3Ey3xQG8jaYH4lC?=
 =?us-ascii?Q?LSphlQk5AUX6CNHxjF3b8F7U4tWXa+/eglLENVjZFZbKeiMYDHXOeToziGME?=
 =?us-ascii?Q?uj3JVA5Fj071wJ2o25UDD056GHQO46KwYt1kZe2KZ4Wi1bc4bvekqLQYb0VB?=
 =?us-ascii?Q?TSNNYtnpnrqBVj8Akegpe4BtUQnykd7jlWlTzznn8okrRx3TUAFAPueFSY43?=
 =?us-ascii?Q?dyHibRDa7Rkd5imp0hq2TXAMMv+1TlG1TJ9HdPrCwCKuYx6UoJpiaaoBcPhm?=
 =?us-ascii?Q?hHd2K7+hiJ0cWAHPkF2CRnjjJ3lolPlg/v7WOtngmIM319QcRiBosFoSBQOT?=
 =?us-ascii?Q?O7R4Hhw/tAsn7oKbiUexBxDOFI9NiIFksxql5zDSvrzMrPeiZ1B1fOWZYK1a?=
 =?us-ascii?Q?m3zhSQIXXBIQgHPy3KwESWL6AQZZM3Dbcrq9v7fO4VaOg9HGnevL9usp2C+P?=
 =?us-ascii?Q?oHqQw4vsNQ2A5l1QgMP6bd3QmhUzsk0CRF7o/YnY9SVKI70vlm9dN1pppw0r?=
 =?us-ascii?Q?BZ6x+5XmZDrBrZbg5Scug/3Hevgdm8XwTon61d2cizfTTtZ9kBS9ABrQdeMt?=
 =?us-ascii?Q?fJ4GnWIJqxi5K4qzoU8kTcfdlzLBREskGvDGGpZGKLGG09/qmXnyXbG70nnP?=
 =?us-ascii?Q?mcBJpEaK8V07iRgZy0Jv2sPz4Aui6URoLdFibpfUhWecQAz2akhaTpfQPH6X?=
 =?us-ascii?Q?ivlfbUKzkioptyn20qla11IbLsJMC+l/0kVNfVBSEd9b1U54crceNy1MgY93?=
 =?us-ascii?Q?kUbgTts7PlmKGOBIGKm2i0G68cYx2waJxCSrBE+zGidRqZF7ElxzaV/oeahU?=
 =?us-ascii?Q?9E5uMtsDId9eCji3KvKW5E+VtL6wLzX3b+0Aya7Zu4O45PzY2mbHUFhY82EJ?=
 =?us-ascii?Q?1Sg18ENFGC/4EScH0VGFCgmKzsv6/xSwGYf/hv+vvFAXieGctgbc5hpjLhAk?=
 =?us-ascii?Q?qAXEVcwuvSeTw4lG87j/mXoMYqwPQX4MtfoIQ7Sppr68ZK0hvysa6TnQRK+d?=
 =?us-ascii?Q?1g/qd3Iy0xSH4WkOLklypwVcAEEZ72dS2nexb6yr93UJZNSXXQ6g3tzGCs+K?=
 =?us-ascii?Q?m2/r5c8y+1pQlVcusIRXOEed4TtitOTrjK8AyUZJ6+roHTfO8xofAL+1f0V4?=
 =?us-ascii?Q?LLR6ffpStSfqMQw9GYeyST+tjqxxIQ/rRmJ6utEZ1P+dJCtMkEy/F4lD9Wa7?=
 =?us-ascii?Q?JVJ/yjW6FFU=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?6SKImSJlso8iFMYzTNogyxrXqK47nc1bEezs2sMRKd3HNAvuDzAZCAsws+ra?=
 =?us-ascii?Q?OAXKsBES7x+Fi2swq2w2Prr+UnsGg+QCG51LpwR/v400d2JP3OKd1UmYP4Hk?=
 =?us-ascii?Q?byuQuSIH6zxYllemHNfOxUB3QmWC1AMGogPWyZH7L68uCyQTks/cJ+eWa9Ri?=
 =?us-ascii?Q?46/ftMVImHqf3oTJ9B618wGKEDr6Ed/+zwGknlDJwMehl+9VpUSk6D4fMQFH?=
 =?us-ascii?Q?6pnd4adK9FSqaou3qZStauDUyAkTwhIFXEACDrHfSb/yFccOGCN+2Z8wxZ6c?=
 =?us-ascii?Q?XE4gycRqMYZ48aVXF96y/m23mWbmsKRNiiuCD8RzLW8wxPjYzk3E1k6VaPBR?=
 =?us-ascii?Q?7QjCMntwXWzoRi/KIqGURFwS7RhVLpEyp5exxbPg3opDRwv3OUsAeMc7nwyP?=
 =?us-ascii?Q?hAYDp10OAQe8tCPwTi4M4uQS2T5zto1/db2cQrwyP1lqFQvUZN1fFFXmAKS/?=
 =?us-ascii?Q?WmSs3O0RuWtNEhhlMbEl5MNfh0O6IvUCi5bmPrXidEF7ZGnNHNNJIfpPV8Og?=
 =?us-ascii?Q?z7E+NKBGzBQ3aT2irmPw1aC6BkqRBuk/GKwgaYp18QXyXvwRxq1hmjDgBG+j?=
 =?us-ascii?Q?0Hl83CEHRQLOPNG0FqpFpQUVt/1bu2uUaciORoLRdMtYvy7o+KnZAeJ6lUny?=
 =?us-ascii?Q?p1Npeas2aGZbA8xClcopODQgveNiD6AGHTIsyGjIMl+GwPCleqm1jMgAuOap?=
 =?us-ascii?Q?oW/BQu+l8c01cUqu1Qc7K2JxGg/yRlNbdYwHarEBi5eXb1oJEvMRIejXUI+s?=
 =?us-ascii?Q?bvCdQeMunpH2nL9XaPppRtAUo+quSlcY5wmnAk5vCCbhkaCok+ARihIgKeyn?=
 =?us-ascii?Q?nCkJ+iu9rcesOmpkL+Lb+DRyy6TAfy7MTpcenNykvviYYQWoZGlYUmIKjGJH?=
 =?us-ascii?Q?bsBRHNP4lkj6xMxhve60tK5W5JsSZD529mSrWNvZJOTLf0awjZCDHLygbEnc?=
 =?us-ascii?Q?VRWyEvDtIwdEGiqAmdnr2DsLQD7aE7TgKGS1i2CYN9ms6vKjK5rlh5jW/Wpg?=
 =?us-ascii?Q?s4A+w6w1pxUu2tNrBOzkXhTEYwf4m9NhLCfF8yDl2KCdZjK2ti4SHwzxRqTw?=
 =?us-ascii?Q?zexA53+4mk8mWpbLWckw5gs073G+yPA6DB6HCqlIXockXnhOjxNQ6YVG8lwn?=
 =?us-ascii?Q?uMf2d592obT717g5IiLjsKgf+LXjLliQ2hZS+7DwOUpfGSzqlTOo1fv6T0Gy?=
 =?us-ascii?Q?baTluZlYzmeRFPmOKtLo7rh9q/d7AuGFIQD2bYAh0EqrlEs8WT9Ln1Q/jEoc?=
 =?us-ascii?Q?DXib1kGj7uUsasZVSzNbDkpex2MmjCjZWE8X0ar2Y2WmvDFSdBdF78mf1zoc?=
 =?us-ascii?Q?n3mpaDc5TlbNEyLkLk2aTfHDKsve3MxDPnQRCDQcs+rTzQZTrdbdSeEka2Fj?=
 =?us-ascii?Q?YgCpcLwX0gWUE01I1+H3LUDilkdXdjtoMtqox+MecH4cSRMJTwBSPrKffvfL?=
 =?us-ascii?Q?LP/hk5M/7AgNbX9wgfEiuhw+ZFHrZvTaUKoPrzXgb3mItvDAjiQ2SCe3TGUQ?=
 =?us-ascii?Q?70ASL7F6rE5C8wAB/+zbA29AzdWZjiCN/BevXzKMj8g+zrVpijNItBnLmRCn?=
 =?us-ascii?Q?k2rFpDTWkw/z0HcOAJgEjP28HhQbaQKwwqCD4XKjWGYsEkaFuwc4Vd0jyhK6?=
 =?us-ascii?Q?Cg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QDI6R7/X2ja9diPCrbquGvu7LR/KXwwVNv4CCOOEk0i59R+3rebF0mqQEhGdgX+Z8Z+6b3KFLeXeJDM0039vHBDt3EMN6h9SgskMr3m26nF3urpS8VvMOeo3IakRbcALT/Etl1btOKmUiIH/tbCk+7BSKIP7Dorml+gEbgEk4lLkHkNN5YVhTDTt29R9M0SYOMBLinQwXAuzt8XN9uuQG7pTch19znMDjHpM9TrOTFqDKRO/672HCw1FHFls8fj8Z4AB59DnZcP+6A6jzynhJZH6BHHoyCBwQI27bUBPCiq2CcZKHd/7cIgwBPZP//RQmOHjIWvsGzg1BRITfvLXeeEPGNeJyFdsG+flHOa/LrRhnVVkYkLMRFiDpiFfBXMDHStbu/fvUQUGvfkBuDZj8eoZnckKtxFB3CwfHkABwmXlDU2Iu4NFI/pXVwbQ7TVFiucfNTgnv2PQAzPlPsApXmrsVrlHzemiv31tZsEewSXpFo1JtsfOaxDlsQQ8LHmW8aO6zlvCA65iIrBOx7+Szf9gcgMuB8z3i/4HT/3jngOzuV/VqgSCY6QPlYPxC4i0YfosLX986NfKx6aB8vuczdH8wYAEVDl2lm3EFp2v1V8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27337ada-e38d-42ca-a2d6-08ddf43e366a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 09:56:59.5425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bxQDVXKZuVX/d7uRvmqMKGCeN1qOVgy9LQSnBI/gGVUgSwQRoOnGojO/tnGxLbsUlih/l8vTla5L/sUdM14d2IExl/15Krz5ApaYTd82dxU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6611
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-15_04,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509150092
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAxOCBTYWx0ZWRfX0aKAm4Fh2hdb
 Ny0k/1dSzg8xVMjVMEjzIR4u98UwsHHhq9S5USYrTIYZ9S+J4w2KHNQtL/WpuYj3ciEPIP2G8M1
 O10g/iqQamKVVKU1Rw8WYlLErAB3z5MhjYlhk1h+lIJ+yeiLNKC6PkQc76YLBpzDNyT4PRly/Pf
 l9ps5kJyPee09DqbophzmeInErwvWsW390Bzrp7tBi6LZ9ElD1aFpyZzgGmsopmfFtiARrxWNpo
 BzOP3/boZ4BDM9xq8xN+qg2PyCg8iOEweuak5d9SdF7I37Qy/v6RLl4FOdtLJmjBEv7LkDuHCQf
 yvQbwCebRnZYzzafyJEQQu5O9aCxuy+dMLzK1fbkgBOo3lGveS3CSaxF6DOb8v+DRB8Bjr2J2Ma
 bgNvsACN
X-Proofpoint-ORIG-GUID: Pq_HJeDmazOX0Xw65rTnLEQ3zhV86mPz
X-Authority-Analysis: v=2.4 cv=YKafyQGx c=1 sm=1 tr=0 ts=68c7e2ef b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=cAFl7XHVMVwTK2yjw5YA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: Pq_HJeDmazOX0Xw65rTnLEQ3zhV86mPz

On Sat, Sep 13, 2025 at 06:54:06PM -0400, Chris Mason wrote:
> Hi Lorzeno,
>
> On 9/10/25 4:22 PM, Lorenzo Stoakes wrote:
> > Some drivers/filesystems need to perform additional tasks after the VMA is
> > set up. This is typically in the form of pre-population.
> >
> > The forms of pre-population most likely to be performed are a PFN remap or
> > insertion of a mixed map, so we provide this functionality, ensuring that
> > we perform the appropriate actions at the appropriate time - that is
> > setting flags at the point of .mmap_prepare, and performing the actual
> > remap at the point at which the VMA is fully established.
> >
> > This prevents the driver from doing anything too crazy with a VMA at any
> > stage, and we retain complete control over how the mm functionality is
> > applied.
> >
> > Unfortunately callers still do often require some kind of custom action, so
> > we add an optional success/error _hook to allow the caller to do something
> > after the action has succeeded or failed.
> >
> > This is done at the point when the VMA has already been established, so the
> > harm that can be done is limited.
> >
> > The error hook can be used to filter errors if necessary.
> >
> > We implement actions as abstracted from the vm_area_desc, so we provide the
> > ability for custom hooks to invoke actions distinct from the vma
> > descriptor.
> >
> > If any error arises on these final actions, we simply unmap the VMA
> > altogether.
> >
> > Also update the stacked filesystem compatibility layer to utilise the
> > action behaviour, and update the VMA tests accordingly.
> >
> > For drivers which perform truly custom logic, we provide a custom action
> > hook which is invoked at the point of action execution.
> >
> > This can then, in turn, update the desc object and perform other actions,
> > such as partially remapping ranges for instance. We export
> > vma_desc_action_prepare() and vma_desc_action_complete() for drivers to do
> > this.
> >
> > This is performed at a stage where the VMA is already established,
> > immediately prior to mapping completion, so it is considerably less
> > problematic than a general mmap hook.
> >
> > Note that at the point of the action being taken, the VMA is visible via
> > the rmap, only the VMA write lock is held, so if anything needs to access
> > the VMA, it is able to.
> >
> > Essentially the action is taken as if it were performed after the mapping,
> > but is kept atomic with VMA state.
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > ---
> >  include/linux/mm.h               |  30 ++++++
> >  include/linux/mm_types.h         |  61 ++++++++++++
> >  mm/util.c                        | 150 +++++++++++++++++++++++++++-
> >  mm/vma.c                         |  70 ++++++++-----
> >  tools/testing/vma/vma_internal.h | 164 ++++++++++++++++++++++++++++++-
> >  5 files changed, 447 insertions(+), 28 deletions(-)
> >
>
> [ ... ]
>
> > +/**
> > + * mmap_action_complete - Execute VMA descriptor action.
> > + * @action: The action to perform.
> > + * @vma: The VMA to perform the action upon.
> > + *
> > + * Similar to mmap_action_prepare(), other than internal mm usage this is
> > + * intended for mmap_prepare users who implement a custom hook - with this
> > + * function being called from the custom hook itself.
> > + *
> > + * Return: 0 on success, or error, at which point the VMA will be unmapped.
> > + */
> > +int mmap_action_complete(struct mmap_action *action,
> > +			     struct vm_area_struct *vma)
> > +{
> > +	int err = 0;
> > +
> > +	switch (action->type) {
> > +	case MMAP_NOTHING:
> > +		break;
> > +	case MMAP_REMAP_PFN:
> > +		VM_WARN_ON_ONCE((vma->vm_flags & VM_REMAP_FLAGS) !=
> > +				VM_REMAP_FLAGS);
> > +
> > +		err = remap_pfn_range_complete(vma, action->remap.addr,
> > +				action->remap.pfn, action->remap.size,
> > +				action->remap.pgprot);
> > +
> > +		break;
> > +	case MMAP_INSERT_MIXED:
> > +	{
> > +		unsigned long pgnum = 0;
> > +		unsigned long pfn = action->mixedmap.pfn;
> > +		unsigned long addr = action->mixedmap.addr;
> > +		unsigned long vaddr = vma->vm_start;
> > +
> > +		VM_WARN_ON_ONCE(!(vma->vm_flags & VM_MIXEDMAP));
> > +
> > +		for (; pgnum < action->mixedmap.num_pages;
> > +		     pgnum++, pfn++, addr += PAGE_SIZE, vaddr += PAGE_SIZE) {
> > +			vm_fault_t vmf;
> > +
> > +			vmf = vmf_insert_mixed(vma, vaddr, addr);
>                                                           ^^^^^
> Should this be pfn instead of addr?

Yeah, sigh, this is a direct product of cramfs seemingly having a bug where it
was passing PA's and not PFNs.

I thought I had fixed this but clearly I missed this here.

Let me send a fix-patch!

>
> -chris

Cheers, Lorenzo

