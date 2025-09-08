Return-Path: <linux-fsdevel+bounces-60538-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE48B49128
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 16:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD6A6189F4D1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 14:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D541730CD8E;
	Mon,  8 Sep 2025 14:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ltaSWqr3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YPpEwOvk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D2030BF70;
	Mon,  8 Sep 2025 14:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757341202; cv=fail; b=nHLva7Po95vAouXksU1HQFH7pTGii8tGW0Kc71+ls5iQVnVld9ktwzIaLt/5YkY1KAQEpqNC0B18LbsMB49hTYNNn6imNJo9Lf1tYswh29Zttrq8YnoSBuQtgYAQAZruSPsDSqnERW63Tt9UGxF1lkKXNLUN/C57k7S+DFO3NKk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757341202; c=relaxed/simple;
	bh=JzGGdGnORNexLJdLhGK9qPErsDdmW+t9q5vnVSlXIRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rV7Q2Gft4qqLw2kgJnVbTDD+LMVzJbwcgaIh+2tg5/2e6zrNqwOMB3T5Hr8AwKyU7rLIeWtresf8IbOVjjKo7ilAXDPqKFgzNWwwn6uVFe0KQXzQQ05k0gl3UlCeLt1rmRb37JGC+0mZVoXmXFKLyxxLKWXHKjWfCdx1cfHHKm0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ltaSWqr3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YPpEwOvk; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 588EAMnJ018743;
	Mon, 8 Sep 2025 14:18:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=QWgOAKiyC3rZtqRANV
	8LkTOWNaZk8e07sDQ2jwhTbI4=; b=ltaSWqr3auqJAhOFj8V55wMTci6bBQEkQn
	U7PhRoa7C3rUIwHw2LUv9F1IIB0KGrdIa57f2PN0Khz2jjtrdUmoEgGHOfXa3Fyz
	77i/tBAiY72IEPxlmG1C+o6PlKH8aWSTlMTs1WxNNZsBJPkusUEm6HFxMDhwawU/
	zgGN7HHd0I0i32SF/tFP+7P7cIeWWc2dJm06+/Wk2UWM2TFxvV5KJ47s07NtRHrg
	SLC+kmx1+hgWyF9gN7d38Rd6vNV95Sou6w5jJRFkP/rAGEDWk1hhW2iOKqZ9Ew4S
	R6qBMe/+Grqukzw499BFXe+5bfylNTK91pnI0YgDa+KcEiNsxJvQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4920npr0qf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Sep 2025 14:18:53 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 588D2OBk038972;
	Mon, 8 Sep 2025 14:18:52 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 490bd88mfs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Sep 2025 14:18:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E7B1vW+zFBD8O7Dpn8Ex/PhW8wncf0vrXwvgvW5/JWneN1jbfqiwbl76SdlbCXueQgiFvAHPDoofo2VRJQiYrTWUpQ6/Y+pNffpjuOhcNnGNNADpvfdk68/kRaCihuB6/m1LqTPtlkWeQUGyKzX8F3kap77m9tUz3a3VR3moLG+8oO7A4Tzmk5SOTksRRW7b8UAYipvYWYiVHJgsreSKHlNKebUOqAhWugCmvZNGBb6HSwlNBsrEu0vy8iB8T5A+fR3sLvFbFVnr0rR+dS5wrRP2CjQV7Qj9Ptwf9dmQdLvC+4iaXa/jqf0Yp8gBCGJ5GZBGZQ0swxNmmbP3KXzFAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QWgOAKiyC3rZtqRANV8LkTOWNaZk8e07sDQ2jwhTbI4=;
 b=jdeezgqmLEY35k1SuJx0qpiegmoTV6L7QSsXn9IVaWj4YjdaZMgr8axVpSoiI1+DRen2ldCD3uLMIvm3xp7XUK1T3qB5tqJzXL+tSVVbIjR7ZM1v5MZn+NOpb+VlYyZBr5UY/d1l5w7Irc+MyeiyqwgZnqBajMmBbsGEzq39cuUWil1gChFbWz2amd/4Mia9U+h4HTJFpFx2jEloq46/XXfF+zkOngT+z3Dge0YKZbALI2fANf0Sv7+3RHbtzNsnsQrctYzZ6p1dC2YbAFFdiioC+uq/7Jz0q0hcsEqfCTamjJMtFM2aylDqoNTNXY8hWWZ30GXmiic32KY4uevTBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QWgOAKiyC3rZtqRANV8LkTOWNaZk8e07sDQ2jwhTbI4=;
 b=YPpEwOvklPs6xBL+48vYbCQSU2Wp/BDrHfjfCbmrqp6C5IbFSD/W2mUg31CHmCBUr+i+Lpecf1rFDs6mHR//uvxC8HlX3ieTdfEbL+/bPHWUNVWveTZtylbd8N1eNXhrPAhfBrR9mdxIHdDpNaIlZ4lIgPUx6z9Vr5ev21R+2g8=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by LV3PR10MB7963.namprd10.prod.outlook.com (2603:10b6:408:20e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 14:18:48 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%3]) with mapi id 15.20.9094.021; Mon, 8 Sep 2025
 14:18:48 +0000
Date: Mon, 8 Sep 2025 15:18:46 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jason Gunthorpe <jgg@nvidia.com>
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
        kasan-dev@googlegroups.com
Subject: Re: [PATCH 08/16] mm: add remap_pfn_range_prepare(),
 remap_pfn_range_complete()
Message-ID: <34d93f7f-8bb8-4ffc-a6b9-05b68e876766@lucifer.local>
References: <cover.1757329751.git.lorenzo.stoakes@oracle.com>
 <895d7744c693aa8744fd08e0098d16332dfb359c.1757329751.git.lorenzo.stoakes@oracle.com>
 <20250908130015.GZ616306@nvidia.com>
 <f819a3b8-7040-44fd-b1ae-f273d702eb5b@lucifer.local>
 <20250908133538.GF616306@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908133538.GF616306@nvidia.com>
X-ClientProxiedBy: LO4P265CA0077.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bd::8) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|LV3PR10MB7963:EE_
X-MS-Office365-Filtering-Correlation-Id: 5acd6cdd-9559-4e0d-0d2d-08ddeee2a0fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gEJOyFabsrQtDxJ8fDOQnmTzCZkBItcDpcxmi6M41ZmU7MS5hFQ1uCgSj1LE?=
 =?us-ascii?Q?na+k1NV2bxVK97gwHBU83WWEWDQwGa4dTw7pi6qn/vBRChp8lPOSaMPXqGip?=
 =?us-ascii?Q?nIohWBg8wDSRAfRUnW9YbbvlxpxgNC1PypC3LobtDwfrwQeuMkHFDPFsacOA?=
 =?us-ascii?Q?ZMLSqStjzMxJrpnTGwrvZEoZrNEPjuesd6BVF/Uftn/HJjEPmSmh5qpRDR5A?=
 =?us-ascii?Q?Ji+t9dOlp8kegZR9SvBN/JFMJy8bQFSQEojqx+xUGH5INGq9jG50Pwguxwf+?=
 =?us-ascii?Q?1Rg0VefCc0EG7IFOzXTBEa4WkcU0doX10hvDvMi1dqdecId0OqL8sSXfutiD?=
 =?us-ascii?Q?EuuCC2oGn/K/RD3PBsqoaWpdYMFMWm45HkUyHxD+15tiLBJLpydOQZ/Ay2QY?=
 =?us-ascii?Q?VJ83h/L2HckEf7QjfRf5YioU8tO1EaSOuZA9R1W2DHQCAS9E/mbGsfGeL2eO?=
 =?us-ascii?Q?nD8JalW2GDMevNp8uUcpKdtzyoy3bvfDDbN/OR/iUIMynRNc8MgE7N1A2p+U?=
 =?us-ascii?Q?xy1ie8HLOrnJi5lKp/bGp3gKLpKtH9dCmvTRDneqINMJXV0Uc6VQoIFhrL7V?=
 =?us-ascii?Q?gvhFXqJtsFCuWt4m4bRtjJBKdv3NKkYhvX+QjCvatnwoCIL9oMefOPwQvOTb?=
 =?us-ascii?Q?tav5ySTXlUZEwXO5/TnSXdZj5aocywMCKto3FRM9v9lfobna4nrOef8nFtZk?=
 =?us-ascii?Q?PnQyLoSKSsvfAoFbn6qOpckX+NIcFeYWbPi2AJCxnPKXAKkQbIsBCU8pRxzW?=
 =?us-ascii?Q?uq7Jq7IeUagxxSylwoRCqLrv4iB/x3dWhfDig25uS2QjIp50WaPfWcmAw8cU?=
 =?us-ascii?Q?nGTL8UCrzfUnK+PLfuOEOKc2A91FvOsA3REYdntDOPtNBtlCTYnav4l7Yvmd?=
 =?us-ascii?Q?as+rnG7kROmaINL5xzg0CXlo2OVwZkAPXuXagk8TqxPRnM4AszheS58ecQy5?=
 =?us-ascii?Q?vHXKCqk5iclLQYagzA5tfoXdvNaTfqapyrCY3lu71e0BhxeAw6ZTkJiJFNUn?=
 =?us-ascii?Q?fRNPax44NGgnTsCSj4kyY1ZTglTtFdoRKP7HoVC0K28Ky8FluCGIYcv1RVUO?=
 =?us-ascii?Q?wwDNeDfnQB6TS5OPJ44B/Z2QXAqViqE9V390BBkL0/48d+Mkdj+PLkogwBUD?=
 =?us-ascii?Q?m9SnHa1n70RJKMk3w/vvlyA3DNldrvG0x0a7MM1jI5y7TiGQ8MG41YT4fcgy?=
 =?us-ascii?Q?vCCTws3TnuPJ+ffFVyfbyrQ4E7+1wjmGZxNZ4JNikh9vsBAHTCWdaeyWQ7gN?=
 =?us-ascii?Q?Gud+Ixw8oFgVopJYdcqwD7CbLgU32HdwgJYxSRdCz4gTfbvVylNcVmkcMyYL?=
 =?us-ascii?Q?/nl7awiCllpJe2v8FP8TTrKS++iUKxv8LJCGZlYaHsvgRzJuKmc1fmHB91LK?=
 =?us-ascii?Q?vceBpJYuHUyxC2BQw9zvLaE+iNYkiwCLeBn5VArLBxfbGq4FTYum2ljY2Oqq?=
 =?us-ascii?Q?OMIB3IMm3LM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TNFt8bBs/k1/sP/V5N8Tp+5BmmxUbekYVkwrU+OziDP753Gx3uMXzLDvsRjX?=
 =?us-ascii?Q?0t3OsxT1whk24NRmVfRObxUqZbFV3twfa5UF+RdAgkLvH4V+wdcj8O3apyDx?=
 =?us-ascii?Q?E8hfM2OevKMFXiAdts7rdGVAuQrJ/Z4YNr/A020o1nvn+T82IGCtK5qyDnya?=
 =?us-ascii?Q?v2NX/4cIOVtNCK5TRbxFrb9JuNx8DBRd+xe7O5/q5aydo9yM4OJqXiZ5DjSr?=
 =?us-ascii?Q?wNVdsWFPR8dQB2PGO+gaOtgMr/i+oMgmi9u9wtXNIcmAYSKaWRYS/uMW4tf4?=
 =?us-ascii?Q?Ybz0Wxa09UoGt5C7Km13rgZLJJIWHy4s3str5OrXUD+jEj0LJsWl/jrbQKjR?=
 =?us-ascii?Q?Kj7cLFAdLte7hodPhkPsTFjePdhHtv8YYFSqL5IEQOzCx0SLHdJgpweUuNIj?=
 =?us-ascii?Q?YjO/l6Q8PHvBhAHd2QmvaaubZwaceY6JnsqX8ABymhEBDSONPiO4GtkO0fOR?=
 =?us-ascii?Q?Md1RzFBGfe8IdW6QY3kCs7jSiG3Gq116F2EPdsKRonj1NOKcsrWpvQ8XdNPT?=
 =?us-ascii?Q?q4dhUYo43JOmCxb09UBBb/SI78rBkIZeEV2chG3lO5cT4xGUvKXPCuYW6mEb?=
 =?us-ascii?Q?bmmJPPGZmZ8IvFwtYcpA8WSpvYV4skCcE4wUw4FiFow0Wln9+WbBqHShpbg/?=
 =?us-ascii?Q?emqdakJiw2BTKL4ZUBbAPtPU+zQi1ySf9DnWv8N6K4yU0C4HfvNTkRWDEVOv?=
 =?us-ascii?Q?lCXxBUy8MEGHOYsffEAVLWg8tb4/Ybj9L+jdc6ZmlxAj0BQe9UCXd509xWUd?=
 =?us-ascii?Q?/2avzh+kOpj4vsbwzATWwXacs6GFnvJL14DT50w0n4NYJzKrW/u1ivmerCzu?=
 =?us-ascii?Q?XUAMqeMhrlRItgVblJ/emnWIM18KTPnIuTYu9S6yPCSvIZ/tS+Wrt1kE4Eq2?=
 =?us-ascii?Q?o9xjpvdfIYIbekD1/MbeZtT7m7lVYS0YqSFreDHXwhuoIdxguEUmvDYmhjZF?=
 =?us-ascii?Q?JWOBtIH6ftV5/+fcGqyzAMVGtduZhz+matn2G0S6+v8wCQsX29g/ldIo4Ro/?=
 =?us-ascii?Q?Fe9w4YLHL16QKybKdJ1vp3ztjqJMPCeCz6sXFIZmMiAcyHu0JixD0gasSenH?=
 =?us-ascii?Q?AnfIN7fUcjjLjaswt8OrS07gMe2CqWGw7bAOzZzKxqO2CKOPCKVni5OGvCBs?=
 =?us-ascii?Q?wnlNE2MmHoTX4BsD2ppcDbXMteKy8FwrNWlQdXg09Ltrvhsj/mp2Py6woreG?=
 =?us-ascii?Q?Qy/2ohmBhVCi3NXsuUXuPbGFg9perqaiZjPmEHMGc2q0l5WoRoJ91m/fSsVv?=
 =?us-ascii?Q?SKmfoWquq/SdthpgjG+VUDSR+zm25rTSyyTTfEAfSFEO7D2aijeaJNIrwFei?=
 =?us-ascii?Q?0zZA1Zc7esv+q1MjzzK4I1bKcwXTanYG94WQ7/ql3TmUmwmLME36r+7jN7Yx?=
 =?us-ascii?Q?nMztuq9Rhn6y2wkhv0cymgmDM6jX7gCGLgAGaHDfz56SQdvBN1y0DgRCp+db?=
 =?us-ascii?Q?u3keSm5gg73xc8peS/q0d01SAHIf9HE8LBtHJBc8d81MEfvH3pRVDFT7uHDx?=
 =?us-ascii?Q?PESBnNGRYNgU/XesOT3qbFsm/OznYXWnpUpGguecONoYGRn0rJNraGztpY5u?=
 =?us-ascii?Q?tOsj5KScxmEj1FDA6w3kSUKpOT4n6zd6HtNFwYHTOpvKwdAK9WlZM0zd9Hfi?=
 =?us-ascii?Q?Sg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0TNzBNFTFg3KUGeQ/GxpIuQgrGoTv4cFs7uz5f8ajSXnZ/zVIycnji3A/y/3ZO+e+1c4aGRMYv27L6wpY48JrIw3XhU4I1j/j/scP5ivJi+mZJHrCdaPHsZlorEPGHSnIxMgbB+3Pr0X9SAoNHY7BK+59Qi0oyKVQe96XWQ2jnXx9p1HrNYmlj/WljcDYnG2a6DNLbDxKAfS3KMS6cK8I6DeL8cRrRMwB8UWaTomejcG4CpsA6DtmZa/oR6QPtT+Ia47euPm7yn9ZkKoPifHSL4yY+EEMHE55QGZ5Af2GtrUY1X6ZNgkIFP4h1GNwYAqgp/HVTgf1DmIqCIZ/zhr5e/y/UKvPYkMHWRv4j2RxBFK8oMYEMWk6+R1AVPYfxGlLCSvJN5FWXZSgHJQ2NZOapjOLG8QwDsD+vTtPfb1VLSrG1K55BMvbGtzEPHQEhBJhM2pR4UCZMGQoKJ64p1GgNN7ysDA7JAlJ9Cg6Qo0Lebskp2kR7019yHp3ujpHiiI8TZk1CvHl8eATMWc41RP+KjzhR1G+v/lP9leLeTyKGKwKwlYa1BUK7GzcTCro4dSSXeVom5UCefowmmGXWQrYnisUjAbcxLdO05p/uwFUqc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5acd6cdd-9559-4e0d-0d2d-08ddeee2a0fc
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 14:18:48.8437
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pnWmfxzgRTeQSJzdLmXNqOu4yMMosBdcV62bl4WHB/dqrEDVYWx5Ktg9kzDYTME+EIjKeudeoWFUpYPqoexljpK4DFgS70EiTcojkH0sOOw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7963
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_05,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509080143
X-Proofpoint-GUID: mk5PDsjX4yousiiha88R4j-hKIqmc9HZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE0MiBTYWx0ZWRfXyElbZRIB603j
 B0jHZ8Kwo3ld3iXIRUczOSHv44tVqJsxQyzbIRZPL/SkrLIBAzSNfKi7jmT+CXVLNIKNmTIgNRJ
 8kGEpGJAMBc8lA8qfC4bDQxSN2LOR00wzd/KOLBDBVIIY49j4+JwFU45hG5TW4vZIDKUGQ9onaq
 iagtYR4kIEIZKlQhQIMelG5h3HwOpKPVpUQ/9eYQRlkFpZw+9loIEpoA9wdCFdLlkZYOPllgh6a
 lQCDq4ezBAicPkrEAHakjyHJVFkV1262WL7DcnGkoJ32SzjIFMHPG8mt+VnsoNH3k67YmNCg5tn
 zaSAbGy0whrE2ZANi4jTYkvSxT7wybf8Svlobrb4lOtCN7pHZgt/kjOVimjTwuDSddiSGSybaWd
 vewLoEAeqzWuTwqsv8tSqxGmuFDyiw==
X-Authority-Analysis: v=2.4 cv=R9QDGcRX c=1 sm=1 tr=0 ts=68bee5cd b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=TOrzBhvuOCNZPJxzXqoA:9
 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12068
X-Proofpoint-ORIG-GUID: mk5PDsjX4yousiiha88R4j-hKIqmc9HZ

On Mon, Sep 08, 2025 at 10:35:38AM -0300, Jason Gunthorpe wrote:
> On Mon, Sep 08, 2025 at 02:27:12PM +0100, Lorenzo Stoakes wrote:
>
> > It's not only remap that is a concern here, people do all kinds of weird
> > and wonderful things in .mmap(), sometimes in combination with remap.
>
> So it should really not be split this way, complete is a badly name

I don't understand, you think we can avoid splitting this in two? If so, I
disagree.

We have two stages, _intentionally_ placed to avoid the issues the mmap_prepare
series in the first instance worked to avoid:

1. 'Hey, how do we configure this VMA we have _not yet set up_'
2. 'OK it's set up, now do you want to do something else?

I'm sorry but I'm not sure how we could otherwise do this.

Keep in mind re: point 1, we _need_ the VMA to be established enough to check
for merge etc.

Another key aim of this change was to eliminate the need for a merge re-check.

> prepopulate and it should only fill the PTEs, which shouldn't need
> more locking.
>
> The only example in this series didn't actually need to hold the lock.

There's ~250 more mmap callbacks to work through. Do you provide a guarantee
that:

- All 250 absolutely only need access to the VMAs to perform prepopulation of
  this nature.

- That absolutely none will set up state in the prepopulate step that might need
  to be unwound should an error arise?

Keeping in mind I must remain practical re: refactoring each caller.

I mean, let me go check what you say re: the resctl lock, if you're right I
could drop mmap_abort for now and add it later if needed.

But re: calling mmap_complete prepopulate, I don't really think that's sensible.

mmap_prepare is invoked at the point of the preparation of the mapping, and
mmap_complete is invoked once that preoparation is complete to allow further
actions.

I'm obviously open to naming suggestions, but I think it's safer to consistently
refer to where we are in the lifecycle rather than presuming what the caller
might do.

(I'd _prefer_ they always did just prepopulate, but I just don't think we
necessarily can).

>
> Jason

Cheers, Lorenzo

