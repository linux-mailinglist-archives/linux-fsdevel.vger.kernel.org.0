Return-Path: <linux-fsdevel+bounces-61765-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC7AAB599DE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 16:27:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF3B91897409
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 14:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FDF236CE02;
	Tue, 16 Sep 2025 14:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hO9+ovmh";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="SfI5bqa8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBCD313290;
	Tue, 16 Sep 2025 14:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758032085; cv=fail; b=kohCDQBXWY0oEb58jpbTgL7fahIHS56ThPEdz8O8ysDkcAicpprdHRf7jf3bV9d1dkPXnj9gsQ+tr8pU0qkaai/9TSAv0I0w529Z7geUFnriddm4szbmxsPAUvpN/UgxTnKGutjlmA1xXIQkvQ5UuJSYVFvCFMO+fm1JoVGN10c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758032085; c=relaxed/simple;
	bh=+0NAz6HeQdH9f8uPWA8ACclDvIrLdz1Mti59GSmiXqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s5YTVoOIHfLG1TFVX+8sVF6eD9Fl/rmCpA+CwBnd2XFZaMf1lc6SPjXm1euEkXViFK2rsKhRg148hu0QfW+9gnlp0qx2HhAujlKgQNh8Q/BM//uPrBrOlkavdcRzWgPjQKfXkzmsRYjg9oydVD1jb04INekR8wZIhU4Rn3xsPzk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hO9+ovmh; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=SfI5bqa8; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58GCi77o003469;
	Tue, 16 Sep 2025 14:13:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=m3jPXyy95fchAkbFHozdrgqko9a5m6N2gS6ET9KGh2E=; b=
	hO9+ovmhG9p+CBP2nQCLfwb9buaq+joEqj5dodSv8xIGABUCr6BYoG1ZW4LV90rG
	Omn5r+as2O5lhBeN1IV2WUlNf/KQvwE2M2ERigDzmSkMcwWYQIrQykoB8IvkVWJN
	0PtkdhnoM2+b09Yapo7F/vqzY4s1JIgO23vW++UYGQ03em4m66g+cKD5in9G8qlh
	Ltxa/PU+BF6y8THucdVxoM80xS/MNSVty/yHjBdN3rTBqEWIlTmWagxEWCGpnWl2
	NSMv7ZwWAd42A2ySmviJJiV8FhSs83yvXGTKxESBDV6RAXgjvOiuKiuFVSg1khb1
	gZKhtW5YJp8F1RYYbgEtTg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4950nf4tju-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Sep 2025 14:13:31 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58GDW8Y3033813;
	Tue, 16 Sep 2025 14:13:30 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013026.outbound.protection.outlook.com [40.107.201.26])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 494y2cede2-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Sep 2025 14:13:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tlJbOXOLGhbqwAlbQrRLxs+n+QVk0ucLvSCNHoEUwanQTT8JS09L5Rsh+UZQKYkufqDuhwUPTpKWJThkIHPn+pBdSLGxmrc3lK+JhRKDwIyty6bfaC1qNUlL54B7oNeRAWs4MfYG1o6JbDTudhdcK2AftHMcoO3xzdy7eCFJylpO974gcpQhQA+YYUOB7BxMtyhUqtL1TZ4FQgtnmB4QVHQ37Z5TfOopzH6B4U20cnzb4KbWcBShERqjixV7Ax1dy+/zKB+feSIO027RXrZ1BO9u1EampliYgWhk8I+8VC+wAUf9zeVwpwb8hsOpUhsuPWqXdctfnC02IGiWoGNh3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m3jPXyy95fchAkbFHozdrgqko9a5m6N2gS6ET9KGh2E=;
 b=oOUJysBT8f8nlwfQ1iaB1KdSX/3cGZOLSXUqT7hV5FnwCY5YA6UzVO6Ihm8DYmCAUT3rL4fiqWFkeUsaDtf+wGyrltglpX8gOvhp4ChxyE8UDPRaHKD52Z1hlfcqVIYR9RgIr5iC9q5hGwftNXA5SHUNpHuFpDcwKDzhegW1pdCRqvFeKmOUotdpN8idrmErr1hJPgNwhPZSfmpfRErLBk/5Y9IBsOSoJkF9GM0D0DwzgwbPl6Sln1O0S05/WEycLF2+WRDLCY01OsPuXnqPRpenEuA1f7NrGAZeOZgpFv5sfJe6BlyhIXoTpPxYh/XNje4dl/e0HvjICQC0aqM2DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m3jPXyy95fchAkbFHozdrgqko9a5m6N2gS6ET9KGh2E=;
 b=SfI5bqa8u1a74xnVFpNFaRJa7x3/poq90Xa8/+IrDmPrto8PHZDdcEXaPzlz8lSpT2a4g70PcAujoxYzeuaJ035mCAUuRUPoo3+f3YC529ezRQwpcYTGHpHVRcFd/ZeYGh91twR6WoSpOZ0SpG/H4DEYD/5EEcwsCnLPEWZlS1E=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SA1PR10MB6366.namprd10.prod.outlook.com (2603:10b6:806:256::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Tue, 16 Sep
 2025 14:13:06 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9115.022; Tue, 16 Sep 2025
 14:13:04 +0000
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
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v3 12/13] mm: update resctl to use mmap_prepare
Date: Tue, 16 Sep 2025 15:11:58 +0100
Message-ID: <381a62d6a76ce68c00b25c82805ec1e20ef8cf81.1758031792.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1758031792.git.lorenzo.stoakes@oracle.com>
References: <cover.1758031792.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0230.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:315::6) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SA1PR10MB6366:EE_
X-MS-Office365-Filtering-Correlation-Id: 810ac2d2-44d4-44aa-10ac-08ddf52b2703
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PTRyamV/XbUpasc/7409tnYv6lOH13ylCBLGyUdSiS/hyIjEQZNiiwyx0L5m?=
 =?us-ascii?Q?9EkgC9T2pxmsHq8edv6ww67arOKuq3ojT1b80z0v3DVAtA2EiWG7HyXuBLm4?=
 =?us-ascii?Q?rcmh1xVRj1rH2qJ8HibWkeE2AHYISJs+KAWWKs+ec7GAHqF6p47XEM5HYLld?=
 =?us-ascii?Q?xDJhXllDxnHcB881I6kIy79G0SknavM9BTySd3JwcToWJce7Mkg2trYbnNI+?=
 =?us-ascii?Q?4t5u0A0VzmcDQ0i93KA70ijjooOBIxMrqlcaizO3PwlZgpAxKAHKAGUNy68z?=
 =?us-ascii?Q?rL6F2dUcIn4qGfmW1OLpnFvdm4AHz8Q3YJrQBj7P7rKa7ja+nQNyqKm16j14?=
 =?us-ascii?Q?pTRgs9cjSPrv3N5Ezjf29eZdjOGejSk1sfF1RoMo4zxCuH1Df3SmRzypkvJ0?=
 =?us-ascii?Q?R8feGGn1F0Ppr1QLr162e93P21hKUhREKUvCNIvUSglIc3XOulriJfocVVAu?=
 =?us-ascii?Q?ZCSm7yPlxt4+wjZPTrWOVXKt/V/l3pyrOG5GwAim801ZWuVo39D4ImjJmXtI?=
 =?us-ascii?Q?kxGpeiuU08wBSntXC7ubkEwItvSzgQ5dqCiKH0Te1be2Az1/2Ld065CjiVr2?=
 =?us-ascii?Q?Zr9rtWxEGZ7anL3Mow32UereqUg1/OuC7MSnKQ3O610yzV2ocKqZNOXBhE3+?=
 =?us-ascii?Q?tGA52SSWtM38yNZNHdtIt8Kgzy8V86f4bQBjtcyevsVGxOXXW22bfR/Gm8jw?=
 =?us-ascii?Q?Zp6ul7k+ZIqXUYPdax/1E03jyf8a+EnX5bIOwO8n5m0gq3e7qIEfu9jbKKX4?=
 =?us-ascii?Q?g1/Ie8fSikR0OAuMqrrTzs5QtYMsPyqEOs/TUyx2Nayn9QkwUSFqZacYGZnd?=
 =?us-ascii?Q?edzbL0CMVT+e8wuPw8zOlsfM57Xwr53GY8sOJRgo3/oXDm2vcq5CxIj0Ohpk?=
 =?us-ascii?Q?JVN/WgTpN46rHbo3UyvGLP3r08IrvEtqzpPJQte41fbhUOc/28oTNNzZDvOM?=
 =?us-ascii?Q?Ca3CxYpqk+hxMi0hHk5qxVOYubp6GSgBiTNJTgJJESXiue6oVvUf9Z5P/tPk?=
 =?us-ascii?Q?qjmqCoYDzWSeTXdJdHq6ejzj6Qyr2++YO7NLHb26UC8M6mcPUVaAAnx8XQbF?=
 =?us-ascii?Q?Jrk/ODKELpQqPtc5Ylgg/Dc0mIjMkpRxrwIAsMhLg6PH++gNcMKR2XI1VpFI?=
 =?us-ascii?Q?igiBaTBGKehPxScU1yeGs2eNUDw6PG6BiKTtNYvr5z695qJViv7nCQWLhMV3?=
 =?us-ascii?Q?cXRQxNWMzeKI5EZMGtEE+/z2sAZnMGemENThaoMxFTxSUaG1FhFgTOmaaEbO?=
 =?us-ascii?Q?rq6N4tXz43iZb4LIyGo4Lj2UbhoHjcWrXOljA80Nm/GgoZ5Lm8OzWYBJolrx?=
 =?us-ascii?Q?ZCFbTkFUXB1IxHEXX2YbJyYw1KGtbv9tRcS67xMDp3q/lt5BdFzoy/OsCOEY?=
 =?us-ascii?Q?EOPrN7GQ43qLOKB6tZGzKqjJ0maKFgvAnJzzFxxpo6U7bgD1rFbxe09eJT8s?=
 =?us-ascii?Q?Thug7pBNB9c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZE2lL9WxT/yG+CWFuTFZV55NN8jJVbpA+sNBZ7kR9h4P1XLJeMzWSDvdVw/F?=
 =?us-ascii?Q?vWs6PitGvPzDhKU3ZjwloiWftLsbkYvWoVasl4BCfMlG1Dxkw2FvQA0S+40x?=
 =?us-ascii?Q?NHQyBIbDIq4MEUfLgs5lBKjobijXcvSQlqlrgIErZsG6IA8eo3SMucRRtEHY?=
 =?us-ascii?Q?hXoh6aOAUAkFOZm2+mTkG9rxji535M9wZ4yodN/Je94EltzE8ZiaO0odcsur?=
 =?us-ascii?Q?fz9gGaJQqcWOPQeDTrq+s/vKEgEyWl2ai8lJUileJUhdCPA0dy+DhCatI52K?=
 =?us-ascii?Q?bBuqD7eA6BPp3Zkv6WdaBD8bop7VrmPStD1mhoZONKMQ8Xp4G7ipY1a+BJ6H?=
 =?us-ascii?Q?TmQw2SnGgt46oWoqVsqdukToaWmWEoweKXnWxXYZNqs36Hm7rlPtFJz9yUrP?=
 =?us-ascii?Q?iRxlNR3xBulU+GAtLLhohIFd5jnk5tWSYhTpqrA85pDZsLY/JBbMsWbGFWDb?=
 =?us-ascii?Q?KTOMHGec/dRgTPJzk0nCXLGVZU4M7ERC8stCwNy0Ehc3mpzHxEV7xu/eBK8b?=
 =?us-ascii?Q?Bd7bMmR6tcQrMUVfnbyIK+puCIYkPWktHcRkrxGTNrHTFQCQWucFQg8SPE2e?=
 =?us-ascii?Q?GJoSmtIVBcczRIBtyE9YYS0WKx+50nBdZAS4fGSYLrRi0rsB1DLnrP8SA73l?=
 =?us-ascii?Q?lFCbcbOjw1ibVRcQ+e+Un+y46ZkAaVfn9KPTUIJi6wi99wnWuDAAyhViX9I0?=
 =?us-ascii?Q?VJun916keJUs80uLJQWHewv2eHhqTsWR8QCTmxAjyFV8SUs85tQ4XIEGF0AC?=
 =?us-ascii?Q?heEJL6Hf7mGTXFUZ5BBPkY07s0pdYkoWqtkEv0QeDJzge1p/1cOu89+Zhf2T?=
 =?us-ascii?Q?N8wBls9sq9bOMvOWdcfM7qRWC6ysgkfIhjhNPZQHhUk/4JcCm5dWsnRIHgUL?=
 =?us-ascii?Q?wHXox7ceiowJWtDV95hOncue40bZIteby//H8C+uv/ZcOAYwI6P/P9yKXRjw?=
 =?us-ascii?Q?/yDAwPjXjURaAiQ9IcZnFmrh1G3rRLdKcQLutFTWKY2SMnqTDm0joC5dL80S?=
 =?us-ascii?Q?Y7RPxXnqpDv1C55+tyVu7jF/PwXf99bXYbpr4GpWnZbRIERxl+dymts7r0pn?=
 =?us-ascii?Q?wokha5giJS5kl9pgXD2i+zZNafqLrihf1yB2MTX44iqxa0Ti8J5ooXtF01yK?=
 =?us-ascii?Q?H8P2KucaawCWzMy5u/YFR0R3/hasURGDnDfkWj3NM3rGPiKMA4ioejekyB3/?=
 =?us-ascii?Q?wMoH8noAdV1N8aoePhceU2Kt+Md+ETTjUoXvC88k54FHFj/YkkI6KJqOXzre?=
 =?us-ascii?Q?gRIqBtXTz2lM9Cgavx2SOtLfyhRsxwOlahesdFlDxWCs8UtgaVP1/uFMqOv1?=
 =?us-ascii?Q?HP6I7ULvM/NbyafEAjy7QidGBHL1X1ALzuLqGPOv6pUsxpu62PjISL9Won0v?=
 =?us-ascii?Q?tHqN5NO9oDY/dtOyz4923i2AregNLHuHMyShB0BmWzP4+DTKwEyVwuo/fnwL?=
 =?us-ascii?Q?gtyw1T4zAF2kx63v3SUNWDcfi+HlJTajGwDVOJSgez2ebzEApZ8cjEch/Eez?=
 =?us-ascii?Q?EZ6Diebo27pnNkEvU6mBaqyy58tJAxxYsSe1L3YSXTnBt0/PBEHKX3Z69hfT?=
 =?us-ascii?Q?EokNxxMdAvcrXFbvqPsY1LEKlP11/HsSq5rxVD3jcPNrWR5Q74z/+RiNqig5?=
 =?us-ascii?Q?bQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	fExszp2sEqHsnRdlOPu8upYHXL5Hga+hBp4/GaZjEsGcN01ye4C9ezzy9+PL0Jz3iQW7rGGoVu5W24cPiXve65VDU9/HjNcFGI1RdRlJVQWHgdYTyhrms4V3U5MudntCpOOYu76G0sENRIe8jCCAXoqyRsq4780JOCVrHn9svmjv3HLdPnHAFnq/oKBpF2UGlqjopa6PioEXyovwjUPehXaXOGM5OhAovItNiLQ6B84uj4c9zht/zxcKNpOmLdLS16Xagr83yQ4u6bCJNlZd34dTy4lJWzddiBx3CQfR69LeNra6keSNcKXEj8YUp9FqOeu7kYC6M1M4HpeEZZE0UrMKGXV1Iqf0WWS6Pc2HnSQEUxTPVu5/h+29LRpH+RSQz+uw/1+BnGtzxYwGPJd0hmreNhl4mqUgx1TSUzGRMCKzrOtTvviWWyVA2YileEEgwWMtr7ZrMOmMj+um0oegoZmXvr087+xoL/zMK1w5imFG1GkbBuxNYYIZB2zJeF/6XPSI6rmp0jSC3m0ZrsglFblQvkXRHEBsyxxXI51n/W2R0WNLo3PKfuDnv+hRtuq3s2ISKwoHke0n9zD+ccL5CKhOreWvxL1byBQ3EadzYyg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 810ac2d2-44d4-44aa-10ac-08ddf52b2703
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 14:13:04.4173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9YxX+ai2KvZVrd1KgsAVquzzLZLWRXjUgjlxVT214DX8FCPNnfwG4QFFedddMjEXqUYnOiNR7Yx+7SV7nOCzvYi/IJkYD6xRRggo03z9Cbc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6366
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509160132
X-Authority-Analysis: v=2.4 cv=S7vZwJsP c=1 sm=1 tr=0 ts=68c9708b b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=QyXUC8HyAAAA:8 a=XorjO2LDAUPeUTK5CBgA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAyOSBTYWx0ZWRfX5nz+Dvq5KhNd
 o/7t3bH5+yyAwPiTCPLfGU/q8AuCBBZsixIIcU6orj4lM3zdtwIQL4Wdvl5iBQpSAL4PXiy2lR4
 xIVDZ7nTgdOUuXqraFDWFGweKzd/xtQ8EIgbI+6+PCy9ay8Da8iZQgwt2Pq2iGHGhJkJPWdEnqZ
 aE+BDqWxSvmQFFoswLwg2deYYQ1AtasQijIyWj40zHAiUZ3nAeLaSCIvuVsp7wyOXOvN9613Uz5
 CbxoOpWYX2AEZvNnNBEBhtDCfqeTpXz4f3fof20lpgu2r2ns0CgmH2Nt2QsX4fxfKmqPi5OMm23
 c1awuLMUL8YLnvUjszOiC34UYr3aRUx/oClhimtCTJAeP6HXlkB2x3ZZjbM4YzdwkHn77EXLKiH
 Y8QpvGip
X-Proofpoint-ORIG-GUID: P1c1j4rbHoQUqK7hdyR39CcINVYXwWOK
X-Proofpoint-GUID: P1c1j4rbHoQUqK7hdyR39CcINVYXwWOK

Make use of the ability to specify a remap action within mmap_prepare to
update the resctl pseudo-lock to use mmap_prepare in favour of the
deprecated mmap hook.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Acked-by: Reinette Chatre <reinette.chatre@intel.com>
---
 fs/resctrl/pseudo_lock.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/fs/resctrl/pseudo_lock.c b/fs/resctrl/pseudo_lock.c
index 87bbc2605de1..0bfc13c5b96d 100644
--- a/fs/resctrl/pseudo_lock.c
+++ b/fs/resctrl/pseudo_lock.c
@@ -995,10 +995,11 @@ static const struct vm_operations_struct pseudo_mmap_ops = {
 	.mremap = pseudo_lock_dev_mremap,
 };
 
-static int pseudo_lock_dev_mmap(struct file *filp, struct vm_area_struct *vma)
+static int pseudo_lock_dev_mmap_prepare(struct vm_area_desc *desc)
 {
-	unsigned long vsize = vma->vm_end - vma->vm_start;
-	unsigned long off = vma->vm_pgoff << PAGE_SHIFT;
+	unsigned long off = desc->pgoff << PAGE_SHIFT;
+	unsigned long vsize = vma_desc_size(desc);
+	struct file *filp = desc->file;
 	struct pseudo_lock_region *plr;
 	struct rdtgroup *rdtgrp;
 	unsigned long physical;
@@ -1043,7 +1044,7 @@ static int pseudo_lock_dev_mmap(struct file *filp, struct vm_area_struct *vma)
 	 * Ensure changes are carried directly to the memory being mapped,
 	 * do not allow copy-on-write mapping.
 	 */
-	if (!(vma->vm_flags & VM_SHARED)) {
+	if (!(desc->vm_flags & VM_SHARED)) {
 		mutex_unlock(&rdtgroup_mutex);
 		return -EINVAL;
 	}
@@ -1055,12 +1056,9 @@ static int pseudo_lock_dev_mmap(struct file *filp, struct vm_area_struct *vma)
 
 	memset(plr->kmem + off, 0, vsize);
 
-	if (remap_pfn_range(vma, vma->vm_start, physical + vma->vm_pgoff,
-			    vsize, vma->vm_page_prot)) {
-		mutex_unlock(&rdtgroup_mutex);
-		return -EAGAIN;
-	}
-	vma->vm_ops = &pseudo_mmap_ops;
+	desc->vm_ops = &pseudo_mmap_ops;
+	mmap_action_remap_full(desc, physical + desc->pgoff);
+
 	mutex_unlock(&rdtgroup_mutex);
 	return 0;
 }
@@ -1071,7 +1069,7 @@ static const struct file_operations pseudo_lock_dev_fops = {
 	.write =	NULL,
 	.open =		pseudo_lock_dev_open,
 	.release =	pseudo_lock_dev_release,
-	.mmap =		pseudo_lock_dev_mmap,
+	.mmap_prepare =	pseudo_lock_dev_mmap_prepare,
 };
 
 int rdt_pseudo_lock_init(void)
-- 
2.51.0


