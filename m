Return-Path: <linux-fsdevel+bounces-64685-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D372BF1074
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 14:14:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4181C4F30F2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 12:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA92314D02;
	Mon, 20 Oct 2025 12:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KrkrRBvn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Mim6JYLl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96A43148B4;
	Mon, 20 Oct 2025 12:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760962387; cv=fail; b=rqg6TFkZGOniwSBdeLRtciRFw5eKk9gnm+6YHqaAUjKbc7Hfbmvke60SPdPCv6f1Zwv0Rw4yNOn4rdn3Wf/7j4zQrktQqqAmr1jYnUPpmxvYFtM/TNglRBmo+6csH1WuY+AZi/I2x4KK4nyhEm/rAxKXbjQi/0hCJbIYaHar/JE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760962387; c=relaxed/simple;
	bh=F8NBWxGVT6Wos9XRyBp4ORxrjAam4DDPSRRiWqY5/1k=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=tYh21XdxGT1qHyvgHTt1J2YNHGehDMdeyBjS66HBDkeJnwBlNALlCGZYAa7EPBnnuLYyZo8RKq19aG1nHvZ/BSWQO7RgDxKnGJZTpX8jCZ5IP1P/+H10hgOAENyvT03r9OONlDcu4Y8QvwNfvGCNWvvd//WOnM/LmwFTZKC62Y4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KrkrRBvn; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Mim6JYLl; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59K8SAAP018283;
	Mon, 20 Oct 2025 12:11:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=E+dEdgpdDKb9sLbn
	ujTwDDWyNdkHD7dVFQizFn4o9XI=; b=KrkrRBvnMAltcrQzzvCEDqEl1vvSbJy2
	QuMdkaDRLywtEsf7MLgnmg0CzQBd1wPTemF9+6mEd99iZcdjUPwg45D37l8qIy3g
	t/3hz010I8w1ZzIAgA2jaB8GSu11LRGxAPiyhomxWjvsZQfgnUEwQzzqRjbcuIJQ
	lbn8OFq+SknV98WAzCf5Bm/tCa1PqiVYrjVs2W9JAh22sEG5/k3xnYxXpKnl+eEN
	Dq6CasB8ALRErRN0ynxJTuh9gxvQtHk9kNVdplu3EPhIGrZoWn7qXXwLCUGsTzEY
	Sl6jRjkrTYcJBsEmFdSVtmyySYFzTvtMuv1BqVvSGOlr/OeFQqcMpg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49v2wat4gr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Oct 2025 12:11:42 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59KAANOa009365;
	Mon, 20 Oct 2025 12:11:42 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011039.outbound.protection.outlook.com [40.107.208.39])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49v1bbvayv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Oct 2025 12:11:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l58Ypl53vqIeepfdFnpp5JXEmWhO+/8/pgnhsKMETuhA2+dvngy7pfERxEXL5cZNicfOiLQWjjvOaNPv7sBBsLWD8dOylLJZQfj2zsTnvd/Fa4L4Glh9N8mOGSNwUZI3sSJnRC2KJWH5vfIMUyc1C1P4gGt3z0CA98L/ceroJZDC8/KSKOyWRO02W1cPCN8wva683vzxaSl5lqgipRm6ONuw2dxJPzzi/psly0xNmo9YFZp8dRu9xXwgIpgaOzdC80xfeagdWUEwJQFkWAG5bWpt+q+y/63y/YQH4jgjTb0lmFWixuzlE2sWs90T10OSgF27KwmYshrp1FrrxbkzrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E+dEdgpdDKb9sLbnujTwDDWyNdkHD7dVFQizFn4o9XI=;
 b=UIhb93pKN0She4MGzcTsGwKsTeXkOnV2X+6k+F5TMo4hKHSKjm9+oMvqODaTNjVkIalE64Ln/IBdY73pMFX2tpk8ZrenrqtFD/YZVSB+avVh7CD0HhsWxDXGqLrWn5orZjhRqHe0m1Tkqqv3xE1OjIEjxLOGdJD9cYbysBjzLkwoXK/cU/7H0BDlgrFX3iK/a8p+7cXQ6CwZMP/Isi3HgvjEuWZ9ZkvvENzFiMb85rZSOWafPMOtkhwSsT8zsbiYS5yz3NAs2CFr0ru0EJJk0qzpM+9+eK4bsx4ye69ZWR0BlF4AzzgZXuvI0EZzAkPqNQHpzdnZ8O6Q2+jDXHXo0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E+dEdgpdDKb9sLbnujTwDDWyNdkHD7dVFQizFn4o9XI=;
 b=Mim6JYLleGRxbyvPjWGYBtDCoOYmkdSKve4jcnbGiH4pKkP06DRaAqFKnqmAXs1iJAAWPXWViQgjFyYhXEzRr0a3s9I4agQ2BBr1iNfbjo7fO0LAJxS7K1+IjGceyONGzOCnBEf9HI1mEdJu7WWE/W0WmdSu9qGXyKdjD+73BB4=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DM3PPF4A29B3BB2.namprd10.prod.outlook.com (2603:10b6:f:fc00::c25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Mon, 20 Oct
 2025 12:11:37 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9228.016; Mon, 20 Oct 2025
 12:11:37 +0000
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
Subject: [PATCH v5 00/15] expand mmap_prepare functionality, port more users
Date: Mon, 20 Oct 2025 13:11:17 +0100
Message-ID: <cover.1760959441.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0115.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:c::31) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DM3PPF4A29B3BB2:EE_
X-MS-Office365-Filtering-Correlation-Id: 67da1e0d-2a3f-4d9d-4179-08de0fd1d1bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?K0UK4GhsyWJe1qvPvk+wIJu7qdFLkuRGanv5FHbjS7+gZj44rSwx5JiYVk2i?=
 =?us-ascii?Q?iQj1L4mVJRn1gXp87yJjq1eqDQl1zPiAhY7GZV1RtmUNCYs9fkkuYPgDUJ26?=
 =?us-ascii?Q?RY8BKGdMC6eYs+qqieKfGmOzhV3DthUW8l6Y3rmIJjj3D6WJlcmbbYDvGx08?=
 =?us-ascii?Q?ESm/7bhsNm0spHCL6JsKDgPPrYY1QqIhp3qLAUO8bQmGmTL/olVQmLqHZWgR?=
 =?us-ascii?Q?SsfWeSa8Cm1mNbhKmrsQtLGZUUjuHrQFd73ikRINbV1t80p9+VTbZ1GlsmyO?=
 =?us-ascii?Q?zzoVUGGsKeMG6KC6UbzgESFjteQHqGTqHIXbcXLQyBGlXuKekOmZ2OY+f/UB?=
 =?us-ascii?Q?lnb96QZsf1MiyDwjeUj/Uqf/KuiPf0vtmvd3b7vFeLeGFeauKx5h5zUIm7uv?=
 =?us-ascii?Q?GEv03Sp6Oaz6vFbUl0WJp7miaLZyqMMn4pCb/6grWEPr9f0IgtCoKRvASKaK?=
 =?us-ascii?Q?AJHVOelCRkbX9rXWu8/3hkvyAM26Sjnm0Xu136pOzKCjylbe1dTaTUTsq+Vf?=
 =?us-ascii?Q?7s9bCH9ofRnZDqVch6oJYQ5m04YK+Ry9pSnoVVoYiWdRqdNTtu6Ck95R5FoT?=
 =?us-ascii?Q?9LTJaruOt7CqEJJgubEC/giCwUXw7PRBfZVfBPnh0pIjixIZm0gC7oF7bY8N?=
 =?us-ascii?Q?KdmvRVUuFtMCEEY14Tbpq4sLtDCG+F+Y9Drh6bHPJUv7mjikXTgqyE4Nm5NS?=
 =?us-ascii?Q?nsXjWSH0I6K1l8z7PEHYEB1dbnHCx7LqN8yRtspnRVFzjr1j/Snr4HaFjGIt?=
 =?us-ascii?Q?FTkLdinTmN33/+duAqwXF99F9W/HRuvZcYfPh9pCr0D+MeMED2Y/tKd9sQtd?=
 =?us-ascii?Q?pWEGMMgcMYnDHEioJSb6hGJV201ndmwdx6PG6wYCStLo6fhUOdF14VLlOSLF?=
 =?us-ascii?Q?FpB2aCtCo8eA+pXzgDi6pvMiG/q/U4s+FieaGHV2cY0GiiqIowRZGDknKn8X?=
 =?us-ascii?Q?ZC58eoO7A7dXGYDo7Pz8zicuAUln6/CYiIOYjd9vQuq4CHqO3bkQaBnWzVfz?=
 =?us-ascii?Q?mzykb88Xz1YUKSSQ3PliEU3y98y5CCC+WXC05FohZyyTqRJveAjPgy0XsCpQ?=
 =?us-ascii?Q?Zff3+/S3zzucqSi6er5BDDXKiVpdso1cgiG3i4YG0sUwOo1rP55WsI0xdmlQ?=
 =?us-ascii?Q?fWsQCXfSnfxMehBOteDWIUZwlciSCVGaqn56G2ekrCLNyz+U11JG8numORsz?=
 =?us-ascii?Q?o0va8PqRD30OykrD2orFNB7d/bSlyUa7DFlDt1g4NbEj66KF4y6rPcpgm6WW?=
 =?us-ascii?Q?HpMHbaKU27vm5DuZfdwu+GDIbSrZW6n1LGQ7ddLgi08cnVW71H98FX/esfj7?=
 =?us-ascii?Q?kt1XolNfwWFNxuYtWz+7At4nIIKBOepdPfO7x26hzmKX5xb8VDT2hir1sUj1?=
 =?us-ascii?Q?NQZDbI0Uxhd8YOIr5yaZwr9Si2nkDczd6rGk8hvraKkYKWepVeoQ2J/eYAil?=
 =?us-ascii?Q?yDcOtmmCJfwNU69QTIn+1ccGhYyaDpaPrrzkuGoRgCdoXwHM9EP33g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?f97sgkIg4AP7PccCETpOUKvi1y3q2zkElAggQggAELXe6IDFJRaIXWzGG8xQ?=
 =?us-ascii?Q?RfikEW0cgVHbwX5zjsaNn4eMxMEfeLc3tlt/VzDSv/3943ekomBixkSlnj6P?=
 =?us-ascii?Q?5JxM9Z10xN4mUg7b9NVU6VwqkfTig/nvqSngq1TQZZWZUYO0+TS1weNraFJy?=
 =?us-ascii?Q?QfOEGercTnfVdXneKnmzbQOi1D/klNEoEYSdfiiuAcO5QM48Zkei0DoJsyE3?=
 =?us-ascii?Q?/ZKOSlCEZQ6l5SQoam07ROibo+f0QSPfK3ZKkQwjmJeeMyESQYAdPWxBMqj+?=
 =?us-ascii?Q?KYaTpvX+Q8xHNfjlFc/H/5PYvKxZupb6QPBk/JgTPLYd2O9r9uy7wJ2XU3rf?=
 =?us-ascii?Q?lrXWADTJrlqAEWbp57av1XCBKVYPrAOGXxMU0tiAJf/UPN71ktF+HW9QA0yf?=
 =?us-ascii?Q?hmMIxX6bxuW66BWkOT940LrZ5btobMM9dh01RgNUHndLDmZ3dw1VuwMp3V9L?=
 =?us-ascii?Q?OJzBVVXgxJxzhOf491jyy/KHWKhh//+EtJmFz/v7YEooeeTrKvGWv2kIM3LJ?=
 =?us-ascii?Q?2mkcyQJI0yrubbkxoyxWTfHbXKAwryL6UgCp5aF6FFF9R6dUAbbMzdp0eMLr?=
 =?us-ascii?Q?eoc7M6Hr0R7xefZibdFEfFpW6X4P2t4vDVE1iGHLAS6DRm+sVwwT6gJEZblf?=
 =?us-ascii?Q?+wGPHR51TS8SYsoidPsWByqWKLkbLIPN8JjP4b+VRcwKc7zDUIMISIHusTC8?=
 =?us-ascii?Q?6qsdc6HCo+dDc1iJKrInFj0nvj//mv0dxH79woaoNE7RDsPIHucvGtP+6cRd?=
 =?us-ascii?Q?G05SDPeduFzTHKfKH4i21ti3Cwi2hKj05vQyP85cEkB2NSSy19T1oJzr91nh?=
 =?us-ascii?Q?qOQK5O2ZqmLivt2nfWtaxJ5ePxVK+vNbLdrxL1YEcEjBjmCpYB08b5qM93Ku?=
 =?us-ascii?Q?RcYyeJ5l2O43WIWH9pmBFRcvYLec8W1c9faKks05MX9GedNTAq7Hjdl32yzP?=
 =?us-ascii?Q?GFMXy8oPBqRaoy9K6NoxH9R4QF2cQ04zHBb4gIal0nZRzE1IsBgvR318gHq2?=
 =?us-ascii?Q?LNEsVhkcTOUsODWnBdWiHi4HoeLu4n2dVSf5E9veNginXsLuwDEMbUaFNDMj?=
 =?us-ascii?Q?kObRvcQJQaM/cX2qDgznrTxdXgBOsGFESAb/N7XHm+60+RTiaiyKdMLlZLNP?=
 =?us-ascii?Q?Ps2k3WMSgRZdNMvoWhEiW2wYJimSHF7MtICgqnfe1rapik6SEMfjh5+ZTHUg?=
 =?us-ascii?Q?9ifpyhCuiJLA9HMHLbGlsYXXKfsE7NFM2ISYK9EFzgn4eUO8BhiIuE9n5Lnp?=
 =?us-ascii?Q?N0AR3U5dK8gnA0y5Wemr87Wj4oeKrceWeS5SPvANImQdCGlqPyQ+Lwz0dsUm?=
 =?us-ascii?Q?Pyrnq0AvNqYQqZcbZzFcXALzpEuNLTz5NJ/YjWjinMjMm1XvpHy02mUuKn8B?=
 =?us-ascii?Q?4ig5aOGrXMEQtiJYQE0I6YnbmZjLlNqHK+tUJgSYaRN2Bi8yeFSClYWG2to/?=
 =?us-ascii?Q?73SR1XJwwV9uiMeZFFeT2fd7pKZlTZWt5LMYKrR6KgtCkN0mVsxDR/YIqihN?=
 =?us-ascii?Q?i+iXKwe50TJZ7L0gM6GuIkieKw5sbnay9vCJejjCoe99rHPqvz69rGuDCGoQ?=
 =?us-ascii?Q?t2Rb4rIfSV01PAnssHB+ROCgdY6DfcNYzzimiHRsoJGhrQgyQGKZTEd4X33a?=
 =?us-ascii?Q?0A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xcxzIexV0gEH1Jh3JYUiQnQaGP/SxooeHtussuJ1jzvJbLhyRBOfG0MwLuLUsgEpwCo31KsFzc+bg/ODfTaQLMSJtgFuDWVNsKzb5so2J78kM5sLGXwPEdEL6RxPY1ciHShlZe8Ty0aPqHELwhOgxdEYw0t/MtX7Zb52oeVqa2jORvkcG0czmuIQv0Rr93kjLKYXz4dS/vVGCNj8x/kV/JIowO3HcV6cHG71ktKGIwbTCzN6BiGCH+YrEpwW0n89X8pEfZMVwJjD7CfiQJuu8MyLRSXF6xhCYNDq8Y/pdetrTExnYPEbMyP8Oy2GK4aO15dtisTfWcQ48OlTH5jS0YObM89hZBrbkRIjGr02zblzOeztsKag0kCcezgciH4FfqM1eEs5FqEcO2+RUiUVbH0DT51kKgG8WnEEZuz4JXH8kif7iOGlvhXBBMw49uWLjAENXO0fOi8MURNf8Q29YoL3XLwRot3jvdo3Dv2gO8cAJhsPI/KOWTFklU4M9/fMH8PyEMNMqwXjlukBqy+Jvx8+u6VnT8IlQjHFfDVqzJrpl28gY3a6fiQ8htxHNWxJ1NvPiVo4UagVunbhmcqwL2DF07nqfvCkHQHAaA5k+4A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67da1e0d-2a3f-4d9d-4179-08de0fd1d1bb
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 12:11:37.6140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hamfh2apjwkDpG+NuosXxsibrA9PUUuRmvzkiae0OzICTXw6wlGeOhjmvhORARrUdNAcYVpLApCLrxro16PsAv2BK6hNPRW7y5T4M5NjISU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF4A29B3BB2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 mlxscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510200099
X-Proofpoint-ORIG-GUID: j9DhrznxhZB4OTcv7AcGQQfnSJ8w2R9_
X-Authority-Analysis: v=2.4 cv=Pf3yRyhd c=1 sm=1 tr=0 ts=68f626fe b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=Ikd4Dj_1AAAA:8 a=7ij4V4Q3QzJRSYUO5qoA:9 cc=ntf awl=host:12092
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX/lcH4u2j+KT0
 fz9/zFedyil0dmbhTQGeIrNjsFZ/JN9Nstwuno5Y58fB+nins1I7EVqfgL8zT7n/Z8cHba3ZWUJ
 m5u17B8c8T+2xkmCkIt+7JhPR2SHjWM9n0lataddankYue09+vJjIfyWp+yBj+41hrwZtgZbNAf
 zfNbq9HaXRcz7OfYYWqnIE1JpVjRsClBvGrqv9Q31rqNgbiNnWAi/+A4qj34UwZFL7sVCp3XoVb
 JyPB44fky4AmLNtrhfeO3x2kongLE40lOkePZPxZ6xGm2iJj1B2xXNJxBcr2LfBW6v2zdqfPc2t
 CMcU5FlcgpfYLsN6PGD0zXPU+LJgqqulL/xVPGG+8gwFnQQpUs3X+BywMtCjyclBv4q3OcL39md
 G6tFJw0fQjFlKUA2x20GRkN2SzEC43/OccFENIQz++Kpi7D68lg=
X-Proofpoint-GUID: j9DhrznxhZB4OTcv7AcGQQfnSJ8w2R9_

Since commit c84bf6dd2b83 ("mm: introduce new .mmap_prepare() file
callback"), The f_op->mmap hook has been deprecated in favour of
f_op->mmap_prepare.

This was introduced in order to make it possible for us to eventually
eliminate the f_op->mmap hook which is highly problematic as it allows
drivers and filesystems raw access to a VMA which is not yet correctly
initialised.

This hook also introduced complexity for the memory mapping operation, as
we must correctly unwind what we do should an error arises.

Overall this interface being so open has caused significant problems for
us, including security issues, it is important for us to simply eliminate
this as a source of problems.

Therefore this series continues what was established by extending the
functionality further to permit more drivers and filesystems to use
mmap_prepare.

We start by udpating some existing users who can use the mmap_prepare
functionality as-is.

We then introduce the concept of an mmap 'action', which a user, on
mmap_prepare, can request to be performed upon the VMA:

* Nothing - default, we're done
* Remap PFN - perform PFN remap with specified parameters
* I/O remap PFN - perform I/O PFN remap with specified parameters

By setting the action in mmap_prepare, this allows us to dynamically decide
what to do next, so if a driver/filesystem needs to determine whether to
e.g. remap or use a mixed map, it can do so then change which is done.

This significantly expands the capabilities of the mmap_prepare hook, while
maintaining as much control as possible in the mm logic.

We split [io_]remap_pfn_range*() functions which allow for PFN remap (a
typical mapping prepopulation operation) split between a prepare/complete
step, as well as io_mremap_pfn_range_prepare, complete for a similar
purpose.

From there we update various mm-adjacent logic to use this functionality as
a first set of changes.

We also add success and error hooks for post-action processing for
e.g. output debug log on success and filtering error codes.


v5:
* Folded in fix-patches, propagated tags.
* Some trivial whitespace fixes.
* Made vma_link(), vma_link_file() static, remove unused unlink_file_vma().
* Added hold_rmap_lock_until_complete option to mmap_action specifically
  for hugetlbfs which unfortunately relies on rmap not being able to find
  VMAs until the hugetlbfs lock is correctly set up. The VMA cannot be
  faulted until the setup is complete so this is an edge case.
* Update VMA userland tests to account for changes.
* Updated hugetlbfs to use the hold_rmap_lock_until_complete flag.
* Reworded commit messages as necessary to reflect changes.

v4:
* Dropped accidentally still-included reference to mmap_abort() in the
  commit message for the patch in which remap_pfn_range_[prepare,
  complete]() are introduced as per Jason.
* Avoided set_vma boolean parameter in remap_pfn_range_internal() as per
  Jason.
* Further refactored remap_pfn_range() et al. as per Jason - couldn't make
  IS_ENABLED() work nicely, as have to declare remap_pfn_range_track()
  otherwise, so did least-nasty thing.
* Abstracted I/O remap on PFN calculation as suggested by Jason, however do
  this more generally across io_remap_pfn_range() as a whole, before
  introducing prepare/complete variants.
* Made [io_]remap_pfn_range_[prepare, complete]() internal-only as per
  Pedro.
* Renamed [__]compat_vma_prepare to [__]compat_vma as per Jason.
* Dropped duplicated debug check in mmap_action_complete() as per Jason.
* Added MMAP_IO_REMAP_PFN action type as per Jason.
* Various small refactorings as suggested by Jason.
* Shared code between mmu and nommu mmap_action_complete() as per Jason.
* Add missing return in kdoc for shmem_zero_setup().
* Separate out introduction of shmem_zero_setup_desc() into another patch
  as per Jason.
* Looked into Jason's request re: using shmem_zero_setup_desc() in vma.c -
  It isn't really worthwhile for now as we'd have to set VMA fields from
  the desc after the fields were already set from the map, though once we
  convert all callers to mmap_prepare we can look at this again.
* Fixed bug with char mem driver not correctly setting MAP_PRIVATE
  /dev/zero anonymous (with vma->vm_file still set), use success hook
  instead.
* Renamed mmap_prepare_zero to mmap_zero_prepare to be consistent with
  mmap_mem_prepare.
https://lore.kernel.org/all/cover.1758135681.git.lorenzo.stoakes@oracle.com

v3:
* Squashed fix patches.
* Propagated tags (thanks everyone!)
* Dropped kcov as per Jason.
* Dropped vmcore as per Jason.
* Dropped procfs patch as per Jason.
* Dropped cramfs patch as per Jason.
* Dropped mmap_action_mixedmap() as per Jason.
* Dropped mmap_action_mixedmap_pages() as per Jason.
* Dropped all remaining mixedmap logic as per Jason.
* Dropped custom action as per Jason.
* Parameterise helpers by vm_area_desc * rather than mmap_action * as per
  discussion with Jason.
* Renamed addr to start for remap action as per discussion with Jason.
* Added kernel documentation tags for mmap_action_remap() as per Jason.
* Added mmap_action_remap_full() as per Jason.
* Removed pgprot parameter from mmap_action_remap() to tighten up the
  interface as per discussion with Jason.
* Added a warning if the caller tries to remap past the end or before the
  start of a VMA.
* const-ified vma_desc_size() and vma_desc_pages() as per David.
* Added a comment describing mmap_action.
* Updated char mm driver patch to utilise mmap_action_remap_full().
* Updated resctl patch to utilise mmap_action_remap_full().
* Fixed typo in mmap_action->success_hook comment as per Reinette.
* Const-ify VMA in success_hook so drivers which do odd things with the VMA
  at this point stand out.
* Fixed mistake in mmap_action_complete() not returning error on success
  hook failure.
* Fixed up comments for mmap_action_type enum values.
* Added ability to invoke I/O remap.
* Added mmap_action_ioremap() and mmap_action_ioremap_full() helpers for
  this.
* Added iommufd I/O remap implementation.
https://lore.kernel.org/all/cover.1758031792.git.lorenzo.stoakes@oracle.com

v2:
* Propagated tags, thanks everyone! :)
* Refactored resctl patch to avoid assigned-but-not-used variable.
* Updated resctl change to not use .mmap_abort as discussed with Jason.
* Removed .mmap_abort as discussed with Jason.
* Removed references to .mmap_abort from documentation.
* Fixed silly VM_WARN_ON_ONCE() mistake (asserting opposite of what we mean
  to) as per report from Alexander.
* Fixed relay kerneldoc error.
* Renamed __mmap_prelude to __mmap_setup, keep __mmap_complete the same as
  per David.
* Fixed docs typo in mmap_complete description + formatted bold rather than
  capitalised as per Randy.
* Eliminated mmap_complete and rework into actions specified in
  mmap_prepare (via vm_area_desc) which therefore eliminates the driver's
  ability to do anything crazy and allows us to control generic logic.
* Added helper functions for these -  vma_desc_set_remap(),
  vma_desc_set_mixedmap().
* However unfortunately had to add post action hooks to vm_area_desc, as
  already hugetlbfs for instance needs to access the VMA to function
  correctly. It is at least the smallest possible means of doing this.
* Updated VMA test logic, the stacked filesystem compatibility layer and
  documentation to reflect this.
* Updated hugetlbfs implementation to use new approach, and refactored to
  accept desc where at all possible and to do as much as possible in
  .mmap_prepare, and the minimum required in the new post_hook callback.
* Updated /dev/mem and /dev/zero mmap logic to use the new mechanism.
* Updated cramfs, resctl to use the new mechanism.
* Updated proc_mmap hooks to only have proc_mmap_prepare.
* Updated the vmcore implementation to use the new hooks.
* Updated kcov to use the new hooks.
* Added hooks for success/failure for post-action handling.
* Added custom action hook for truly custom cases.
* Abstracted actions to separate type so we can use generic custom actions
  in custom handlers when necessary.
* Added callout re: lock issue raised in
  https://lore.kernel.org/linux-mm/20250801162930.GB184255@nvidia.com/ as
  per discussion with Jason.
https://lore.kernel.org/all/cover.1757534913.git.lorenzo.stoakes@oracle.com/

v1:
https://lore.kernel.org/all/cover.1757329751.git.lorenzo.stoakes@oracle.com/

Lorenzo Stoakes (15):
  mm/shmem: update shmem to use mmap_prepare
  device/dax: update devdax to use mmap_prepare
  mm/vma: remove unused function, make internal functions static
  mm: add vma_desc_size(), vma_desc_pages() helpers
  relay: update relay to use mmap_prepare
  mm/vma: rename __mmap_prepare() function to avoid confusion
  mm: add remap_pfn_range_prepare(), remap_pfn_range_complete()
  mm: abstract io_remap_pfn_range() based on PFN
  mm: introduce io_remap_pfn_range_[prepare, complete]()
  mm: add ability to take further action in vm_area_desc
  doc: update porting, vfs documentation for mmap_prepare actions
  mm/hugetlbfs: update hugetlbfs to use mmap_prepare
  mm: add shmem_zero_setup_desc()
  mm: update mem char driver to use mmap_prepare
  mm: update resctl to use mmap_prepare

 Documentation/filesystems/porting.rst |   5 +
 Documentation/filesystems/vfs.rst     |   4 +
 arch/csky/include/asm/pgtable.h       |   3 -
 arch/mips/alchemy/common/setup.c      |   9 +-
 arch/mips/include/asm/pgtable.h       |   5 +-
 arch/sparc/include/asm/pgtable_32.h   |  12 +--
 arch/sparc/include/asm/pgtable_64.h   |  12 +--
 drivers/char/mem.c                    |  84 +++++++++------
 drivers/dax/device.c                  |  32 ++++--
 fs/hugetlbfs/inode.c                  |  46 +++++---
 fs/ntfs3/file.c                       |   2 +-
 fs/resctrl/pseudo_lock.c              |  20 ++--
 include/linux/fs.h                    |   6 +-
 include/linux/hugetlb.h               |   9 +-
 include/linux/hugetlb_inline.h        |  15 ++-
 include/linux/mm.h                    | 125 ++++++++++++++++++++--
 include/linux/mm_types.h              |  53 ++++++++++
 include/linux/shmem_fs.h              |   3 +-
 kernel/relay.c                        |  33 +++---
 mm/hugetlb.c                          |  77 ++++++++------
 mm/internal.h                         |  22 ++++
 mm/memory.c                           | 132 +++++++++++++++--------
 mm/secretmem.c                        |   2 +-
 mm/shmem.c                            |  50 ++++++---
 mm/util.c                             | 146 ++++++++++++++++++++++++--
 mm/vma.c                              | 136 +++++++++++++++---------
 mm/vma.h                              |   6 --
 tools/testing/vma/vma_internal.h      |  98 +++++++++++++++--
 28 files changed, 854 insertions(+), 293 deletions(-)

--
2.51.0

