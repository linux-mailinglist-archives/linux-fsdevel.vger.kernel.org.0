Return-Path: <linux-fsdevel+bounces-60512-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41CE4B48BC3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 13:16:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AB5F1699EA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 11:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1182FF655;
	Mon,  8 Sep 2025 11:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PKD50LKh";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TQqsS+Qf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418A6306B09;
	Mon,  8 Sep 2025 11:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757329970; cv=fail; b=jULylylTiZw6o5W0Tv72i0aR2e79Mfuu2m2exnyd182uzQPguaNcXZkFHI/Tl0oLBk5iYm8eh64kMAdjR4DXOg+JInzLbm1eYpzlBWsRhNgdmh3h0/AGrvRnhitD7R8uMK7v/6YWgaAjQFpXGvluB4ilqihHvdAnibviKqDAKio=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757329970; c=relaxed/simple;
	bh=OGrzoRbDm/+E/1r3AqUf2P5DD7NwH/BfUV1Y9MSdcPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fUGYSiOzUoRUuXqHXB1/jotCAHd7IV8gpUVdMSaXVBMTs60OxQ5CtrZkO5y/BZEgNkDLchO+KwHmqcDaXwdzbBjc7fcJFYQNxKjJZMMSFFNtsjSRkSpRAOe+lGoYnZKPctPbUowMWV+mwPH4PGcyEpbl7b7jqoil/vbRXiC6qA4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PKD50LKh; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TQqsS+Qf; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5887cZV8006025;
	Mon, 8 Sep 2025 11:12:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=rrU7Gj0t4LKSDiZl7UfV3TRzFIOJd64sRRswb7EXhX0=; b=
	PKD50LKh1GJkUovMDWRaTUTWW5FwNdJ4PRcjXWqmyxhCSxdmn0/hlaDl1y8h8XVb
	ttu2ArFaX58Em8Mp0lL4lWwrxWqnHFrvo27Pgszlg33UVZlf7LHPf2uXvD7v+gT0
	qWl1B/+yxzhJHkyfS5Sa71Ho03AUfasN85jkHVgMr4H5gVEnx9XSwZTpBvSTL0xj
	CbhvNBCz0YvR5DGJfib9BlUmbiO92YH38ACg4+ifz0ekUIj2NMB/lNolP5zPt5QI
	1H3ZLsjCWreTC4T2R1r3bMUolnw2fkXUwxn1E5tqCazK6SHbIp7UGEIUvgSVzZ8U
	hOX2kvWZuJYLb/tIm0YjZQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 491txb8c9w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Sep 2025 11:12:05 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5889MPM9038804;
	Mon, 8 Sep 2025 11:12:04 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010010.outbound.protection.outlook.com [52.101.201.10])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 490bd81qh8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Sep 2025 11:12:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nl9BEUgb9L/tzha6fT+8dr/iLZYxxtFsnNS7+PbjwhjxAe1xpKdW4BTW6tv2/KxN2hAQ43GbYE3otQVdxhcAntMslv2Ubqxmr3Q9Gvw3conEiwcFYJ4zy0OHuKacumveatFWIudVFztYumxNOlF4q+QP80KDtePNrS9N5aGtrn76LBn4n+iCA9ECYR0EfedN0YU0rsNbJZ2aWoyyoSTBPJu1aj5Vg9HkY5uS18QDJk4hsNNTkfMzkZe9cH+fS9rwTd0osO18+VilVLGfyo4Vlyf+NT66aSBaP7Ki9Tth/kkYp+PYRWL1RNYMX1yPDZ823H1eVV3uBzGy/2IUYV5tog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rrU7Gj0t4LKSDiZl7UfV3TRzFIOJd64sRRswb7EXhX0=;
 b=oeDPNubkvaXE0TulTAmsuNMqpi5QNSrWG3iPw0Mzf+FUmq5pc6fG9q82tdw6X7zjXubVAny/MRZ8nhY3+4Frtwxid04i18kQuoihyebRqsgZodRtuomgHqFsKm72ODWuVnftJ6BPxefZrrk7OZKhkaoCJh5pALhg4favjnQIjCuPHEjFG+JZcmQ/Ukli768ywiMyQF+sjIRsK44JoSR7uYVwP1pjDZL7QDmW85ln0ZcJyevsOYU7ktuQeqnIIQUF2lnqHxCT5WqLyecQNdR1niZttg/Bs4QitZo2vLePSnLLzOYnx6a808OogLXe1mR8xAp3INJQMDmT0f09jEXzFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rrU7Gj0t4LKSDiZl7UfV3TRzFIOJd64sRRswb7EXhX0=;
 b=TQqsS+Qf+p0iceuYgMrIa9qeSMunulUjyydOn4qXMtiQbSTw5oMCjFbOeZ3HvHz42a5THSy6gX2lts+hPVHA21CHohsg18rm0xiL0f2L/5i7xUniGePJmvZYNtReybb51BDlxU9I1WRSECwWk0tRV0c5BHYsLoM4jD/791rLpJQ=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CH3PR10MB6833.namprd10.prod.outlook.com (2603:10b6:610:150::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Mon, 8 Sep
 2025 11:11:59 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9094.018; Mon, 8 Sep 2025
 11:11:59 +0000
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
Subject: [PATCH 16/16] kcov: update kcov to use mmap_prepare, mmap_complete
Date: Mon,  8 Sep 2025 12:10:47 +0100
Message-ID: <65136c2b1b3647c31bc123a7227263a99112fd44.1757329751.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1757329751.git.lorenzo.stoakes@oracle.com>
References: <cover.1757329751.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV2PEPF000045C8.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::43e) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CH3PR10MB6833:EE_
X-MS-Office365-Filtering-Correlation-Id: 1af812b6-463a-4d2e-e89e-08ddeec887e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OWqiUldvhKBL7HdIckIfZ29a05cGOTneZkUaPtLzRF4Irh4Rar+xgKgk7dNM?=
 =?us-ascii?Q?wxBjm4GOfQzJks0TQ8uZpkA5qGJRsON/h88XOQsnc2rXzRz9gnGLe5YLn3NW?=
 =?us-ascii?Q?Ou94NRITPo7Jto6yUuQD2zDMYhX9YqtKNLjcyZNlJtJ/W2Ss1MWBSRedWQLr?=
 =?us-ascii?Q?J62R2R4aSmXcJmH2FadIW2xZWV5UF9OVPPx6mjsN80ndeAxPoz4cmJ9ciSXj?=
 =?us-ascii?Q?iyewxkkuPIGSYq4K6CTMTa5nEmE5b3KhBjQ6Z/0wT2EtCRp7+MDMZs5VQ97I?=
 =?us-ascii?Q?N9IlxuRHu1ykmvDK4fuyDzbmTHsLB5/M/U/h4qTMPa203DGH0dZc3iw23Paj?=
 =?us-ascii?Q?5/8Dv7DRdFEPOPklSduDeudVKzram0xUPsH3A5Zo59CA5MORQbXkg1+QeKvQ?=
 =?us-ascii?Q?y6+eyDqmJq81WNt4+9VS3jMUW8DM5y6YrwOLh1BE7yJ6zei8biMvg1TQerZF?=
 =?us-ascii?Q?qJ5upNuqPZdspujeRjdt9kn674JPiY6VWS+TN1bvzh+87Ei4KioizO/3TJqt?=
 =?us-ascii?Q?sQDzzvVs7c09Gqfb4aoIU3qgWt2vVx6XRzuTF+7xW1rQXy8BheUYJfyB+3mS?=
 =?us-ascii?Q?H+UeAqHUqPvjxKodwMOZOV1sGgYSoNOl3gUnmqMMmmIeDwDwvktr4rAyxCOC?=
 =?us-ascii?Q?eAyCJQQlaR86znUHg4+C3aHzaaKX5GXwBXtYxQwWeGU/ekAJid75vN3BriDK?=
 =?us-ascii?Q?SccvHNC7AreGpXQAyApCEpCF+XkuCE8deDqMJLovGXBrSRv9YkKV17t5W7wq?=
 =?us-ascii?Q?fzpnxjj/yS23SsCL8inDIzw4t0YDTF7X5aq1PMgSlw8RVBdf793Oz/T2Mhac?=
 =?us-ascii?Q?J5HEHrE6zkBqAx5zyG2BRL5BdbaqobV7kNrQG7gJSAxWQS6A09jV8+0qLJdf?=
 =?us-ascii?Q?r3S6LlXWJB6Dyrko8FrtpDBQ8/jYV3Q+vOlnVTqYe5nmNDG5x7GTtuo9hMvB?=
 =?us-ascii?Q?RrWlMvPgtW0kNnjCmQB7hXFZonHsDEuA+1L1Pz+P62zrhPqPFjuNttiUGll5?=
 =?us-ascii?Q?gDGbkVdNtIOIbz9DIzLaYAtu3k9VBEUCsc9uB7wFpxxW0xuLPYvXW/cOABzX?=
 =?us-ascii?Q?RzLM0ndErJjlxCSBTXm9iXWGv5wIgSJcPIKMLbVJmJUDHsLqMPiHMTumls6r?=
 =?us-ascii?Q?0OwmGkcIkifhuF9ItkVtJKpcZWMA+uNQAnSLWr8j5QytCUYXtedFbecR1kU+?=
 =?us-ascii?Q?8N7DfKkbM7koiCwQ1IuUTb4FRPI2Outf5SCpo+x5Fh1jOWEyo4fWkepBIDEt?=
 =?us-ascii?Q?bPRcvw0zXG5N2RWxyhNruJYetchx1je/yDqUJtLShQYZ3A5YZmtbtwmUdEZP?=
 =?us-ascii?Q?Mjr3XJi5C5E9YioZygwNMkQyBAF8UmAOUV4GCHAeanOPeYcmeuOWrvqCiFlw?=
 =?us-ascii?Q?y/Ov4vI9rUeNuZSLwc9Shw6NUKI3I9k8LP7+CCL1FlGXtLhFvb2za1FUElAO?=
 =?us-ascii?Q?9c0gqe9lZYc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6EVMaKWGZ2TgKRZ5Z12+nrHzRCWQB8PXLowwr6GvfpZbhCD89/LCGpQxxm8A?=
 =?us-ascii?Q?dA/RG6gAxxAVbKy4MX46lEhGQw2P4iAbBsHYeBf6PPohqhz+wJudW1I05grU?=
 =?us-ascii?Q?oDbdvG8x6GRFNUetxUyVEQYZrq0dBoNMYpK40R6fEcMNf1wsN3Oe8vJMpucV?=
 =?us-ascii?Q?/rmDCtZ9rHD51EDocxX3u53pFbswLaBzV2mxWwj+0XGTCTQJejt2t7smhb81?=
 =?us-ascii?Q?cNEtp8astpPFFe5k7WW/86gURFVrSu7hzEIhMkTNiINWErhZn1iU92galDiO?=
 =?us-ascii?Q?XMUvPOKpN/wOfuGeQ1zHDm7D8QYz4nzYGX0RzYgPqQ+kSTVybeRqJKjVISbj?=
 =?us-ascii?Q?H8TLdVbYoTM4AcCtJM45nadc3GlpTMeJcbZ6byKRmeVc++iFcO6qyJZwUdz+?=
 =?us-ascii?Q?0ZDM1NBg/rmy54I5G03BzJu9YqUK7foEd2vOHlWFeXyGJfm8Mz8K1VPAFJvN?=
 =?us-ascii?Q?dBXUYVf6XbQu88EzJkN7CRJu+wJ6pNZ//jrwvbHxSinp9YYzu3l1QRhxMBB0?=
 =?us-ascii?Q?b+OHtO9p/c+fjyv1qIFdhrfUYY0DCCe+9dpy6NGzYd8h+cz7wLEBjEMqHip1?=
 =?us-ascii?Q?uO/2TUDGQPoUuvj0ST5xkvqAkXAxdKCpcIQVILu9DpjW/8YzAWQOPbxI6uz9?=
 =?us-ascii?Q?sT+DxQWp6tKazB9fkUxA1z6iZ0o0IpVjftvIOL/7ARBYk+BlN5GEZEENNET+?=
 =?us-ascii?Q?74kwY0AnCZeo+bXJkPZGRX051wlclR6XqoQWB0quyGraWyWJh2PH1HFff/1P?=
 =?us-ascii?Q?azPokFHWOoyO2t33R9bDvSmhCrcpL8qML0pQTS+HTRZt+dlPFkllpPqF2N4K?=
 =?us-ascii?Q?ML5moXdfQmgbgyIbSvYPH37SkP7qxTvpOb5wd+L+YLru9NjvzO/ywNwEQZhN?=
 =?us-ascii?Q?8V1dnJH6psAoOd4ExmfNRZ4L+iq0o2zbcOZC4tmxLGLP3I3ovciJGfxTAgQx?=
 =?us-ascii?Q?PhzZIDORXgcJ1XC5SQaD7iBTng2Q0+UYTJHJJ7MGgaXaWQG1w+e5tJfQpfh9?=
 =?us-ascii?Q?E34AZKbiJgHGw39NyffZ+io6MqR84+eyU/JA0Mxnk8l4Qaws/nrj0CgtUTEg?=
 =?us-ascii?Q?f7lZ5PwJn4DInRiWX2HvzenixV1Qkl2lcJMtO869hoOpDVZga/wS6JHuXgDe?=
 =?us-ascii?Q?YjebA/6ah+oKsmXjdETNu2JEVAK1VEghghVVFvEpNvLKU3HXNh3naG2As8pE?=
 =?us-ascii?Q?YTIrThkyOU1nJarhwLXJ/bm7XEMJ7PLjGpfcO608k74Qf8HqjT2bQ7rT5ztM?=
 =?us-ascii?Q?cwJTo1mVzmdr/Zu0ei3JHKRLKfoFFrYr75CA3vaZOF4076HN313+wpZN6UVk?=
 =?us-ascii?Q?8dbQvGNaA6HdI4Rd6xNUy51cnxYWWRGUic2rKppLFkzpfEJalrKWY9gX9rIn?=
 =?us-ascii?Q?Tlf18o3hMITBeUs5/GzjxKi3n1elCCb2sXup77Kf+r1/HY8xLzNNd0tJsTFP?=
 =?us-ascii?Q?85NMJsCVA2AEeqO6Jn/Hnr2ZgWAyfpSqzvQaGxaE6voScn1FqEexWuvCAdoZ?=
 =?us-ascii?Q?hyqcqWitift0VDpBj9BiEZldertHX7FYad6kjr/GHZ5BrStS2xJ4gwC78PKe?=
 =?us-ascii?Q?EOlHCsOuP6/5716vkW+UfviIx4X+MDc+/SEc/YOs38o3HyVc8xVbjrlGkcA3?=
 =?us-ascii?Q?tQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0cwjF6p6dcadMenFwCcZNrWBHPNOr95I145Qu84FUm5IN6lQFMe3GvS4WVVrHme/d7Jfno/mEQrqbn1dP8xt5k6sh4fd0rN6ymWW/Hmz124FUaz4p7MOZyRLM6CnsPs8fC2gVga+AZY9KREpIPSgsEDOtjjstJCYHaX/gPZjFjN8FNPBsS0PeS8fGoZkPOzYvgigEDxTwoN6c/zMc21xcKMYAFuswVphVoMXYQdd8NwL/QJHdB1wvSp+p8slL8bpVqrYjvU2evZslICEzJSd4skZGr2vC4XtAadV23G0CYudQxHJC4al5kKyDeLW77MeqQvuAe5ij0/X1Ki7cbO+/6P4owp2fo7IZ1hopmdpVqPAa0iMotIJVmS12BopQTImD43d2SjLZbiDQT3B47Jfi02FortfqAZuLTdm1w+A5I1Tu/rcYLiz+u88lcS52rgXPMqVpM0i3weud9ZBh68E09nrJHdRBeZ5ZkpWzvuwATAP/JPtI61WT7xfAYA8hbW5m6i1GIo6dOLW0YHgipUYtjt6qs3ps/Xux1iNf44bWV8bobmb6KW1WSag+VkUmZzwqco7UC83sX1wmxH16NjtPQXcysCsfKhAjoqcVIiqiRE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1af812b6-463a-4d2e-e89e-08ddeec887e6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 11:11:59.9192
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QhwY9Xg4eAtm7gFfhci8nMSmTyw+BcF2YJapov90EkODIVceFwND2lqdR6yjRt7KK/aiYYWvtnpHCyzCeImnTzK9REoPPcEpqAI+FxVxLKE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6833
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_04,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509080113
X-Proofpoint-GUID: 2GrThVDMJNCORHm69RF8CnnnXNhgTntd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDA3NCBTYWx0ZWRfXyWTJ0gANiQ3N
 XMIx6Hlc4hpj+PKzG8u0VmuX8PTumIjSYER++6tPxQA4zaAUUXi9PNxy52EvsiDu0juBbh3YsyK
 v3o5zjQXTCeqzCKFOmmW60ZH9H0J2vW/rQrCcwI4a+xCQXtm4QZltA3q3IxrXfCsKYLCEstCYgW
 SR+D/5CjTVnGUg7r31/Lgh/zjciqKEYpVSl0xpIbZWQr7oWwkRYhTynzE5RmkZnnDoyfTriQjDo
 yBA5i2/cBTzuDjpW1CMN21xtCqszrfeSdptTkHzfmIhNgARFZtEPrhK5LR4MqGZO+LYv+h7SI2O
 y9Ju/0iYqUT5OfydfnzA+tl2AzYV9yQS3wJCNuzj6uNFxX+xNCnG73MekwXId4ZZakjYQOOTMWD
 7XE5342getsChZLswMXrKMS9WxztJQ==
X-Authority-Analysis: v=2.4 cv=Z8HsHGRA c=1 sm=1 tr=0 ts=68beba05 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=SrMRxt1Jfw9yMncY4tEA:9 cc=ntf
 awl=host:12068
X-Proofpoint-ORIG-GUID: 2GrThVDMJNCORHm69RF8CnnnXNhgTntd

Now we have the capacity to set up the VMA in f_op->mmap_prepare and then
later, once the VMA is established, insert a mixed mapping in
f_op->mmap_complete, do so for kcov.

We utilise the context desc->mmap_context field to pass context between
mmap_prepare and mmap_complete to conveniently provide the size over which
the mapping is performed.

Also note that we intentionally set VM_MIXEDMAP ahead of time so upon
mmap_complete being invoked, vm_insert_page() does not adjust VMA flags.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 kernel/kcov.c | 40 ++++++++++++++++++++++++++++------------
 1 file changed, 28 insertions(+), 12 deletions(-)

diff --git a/kernel/kcov.c b/kernel/kcov.c
index 1d85597057e1..53c8bcae54d0 100644
--- a/kernel/kcov.c
+++ b/kernel/kcov.c
@@ -484,23 +484,40 @@ void kcov_task_exit(struct task_struct *t)
 	kcov_put(kcov);
 }
 
-static int kcov_mmap(struct file *filep, struct vm_area_struct *vma)
+static int kcov_mmap_prepare(struct vm_area_desc *desc)
 {
-	int res = 0;
-	struct kcov *kcov = vma->vm_file->private_data;
-	unsigned long size, off;
-	struct page *page;
+	struct kcov *kcov = desc->file->private_data;
+	unsigned long size;
 	unsigned long flags;
+	int res = 0;
 
 	spin_lock_irqsave(&kcov->lock, flags);
 	size = kcov->size * sizeof(unsigned long);
-	if (kcov->area == NULL || vma->vm_pgoff != 0 ||
-	    vma->vm_end - vma->vm_start != size) {
+	if (kcov->area == NULL || desc->pgoff != 0 ||
+	    vma_desc_size(desc) != size) {
 		res = -EINVAL;
 		goto exit;
 	}
 	spin_unlock_irqrestore(&kcov->lock, flags);
-	vm_flags_set(vma, VM_DONTEXPAND);
+
+	desc->vm_flags |= VM_DONTEXPAND | VM_MIXEDMAP;
+	desc->mmap_context = (void *)size;
+
+	return 0;
+exit:
+	spin_unlock_irqrestore(&kcov->lock, flags);
+	return res;
+}
+
+static int kcov_mmap_complete(struct file *file, struct vm_area_struct *vma,
+			       const void *context)
+{
+	struct kcov *kcov = file->private_data;
+	unsigned long size = (unsigned long)context;
+	struct page *page;
+	unsigned long off;
+	int res;
+
 	for (off = 0; off < size; off += PAGE_SIZE) {
 		page = vmalloc_to_page(kcov->area + off);
 		res = vm_insert_page(vma, vma->vm_start + off, page);
@@ -509,10 +526,8 @@ static int kcov_mmap(struct file *filep, struct vm_area_struct *vma)
 			return res;
 		}
 	}
+
 	return 0;
-exit:
-	spin_unlock_irqrestore(&kcov->lock, flags);
-	return res;
 }
 
 static int kcov_open(struct inode *inode, struct file *filep)
@@ -761,7 +776,8 @@ static const struct file_operations kcov_fops = {
 	.open		= kcov_open,
 	.unlocked_ioctl	= kcov_ioctl,
 	.compat_ioctl	= kcov_ioctl,
-	.mmap		= kcov_mmap,
+	.mmap_prepare	= kcov_mmap_prepare,
+	.mmap_complete	= kcov_mmap_complete,
 	.release        = kcov_close,
 };
 
-- 
2.51.0


