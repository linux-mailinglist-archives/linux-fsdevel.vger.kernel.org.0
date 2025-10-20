Return-Path: <linux-fsdevel+bounces-64689-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 345E6BF10C1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 14:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E81D64F368C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 12:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C799331BC82;
	Mon, 20 Oct 2025 12:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JnvxmEKd";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="m3KS06Tc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CF53164B0;
	Mon, 20 Oct 2025 12:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760962391; cv=fail; b=BkwulgWrWh4igbxFm0pWq5r2oSpaUcbothLj9orJzGhJAQh9Jy7bY3GA9NJD46y3QjmmnQNffGRukxMG42qVLAiFfX4VGaKDUr9FRFH1sKF0/xkR8SHhHHrqONiDla9VZfZkmIV3nLdLQej0kYfcNPwiOAIOJRrxgp/S0uUnBQ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760962391; c=relaxed/simple;
	bh=+YXbU+V+3RsOzkxrjcID3+UxB0edH6sjaNSe56/JePs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=De+TYdCqbeN/fvC0rGwPhTCRzTDrOAdLFXBstjJzblASshFbUFtu9nosm9ao1mDWWUR7eRhFldidm4Q9NgkZONnHBE1kOrHbuJmOUlA6oCsuhiuyyB0ZPXGrEoS3sOUILAjfSXPhaK3823IUSqQZ/HpHVAccuN+DA93a6Y5dplY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JnvxmEKd; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=m3KS06Tc; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59K8RniX008282;
	Mon, 20 Oct 2025 12:11:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=t74fB1rLq63mz3sL6A47wt/uIDjXLjx7Gbd52PfTYGk=; b=
	JnvxmEKdQEqpW6Hndp+YeAoPtLwyfgNga7swfN+Q+fGpOZngNIhV1b0PTuGf7M9R
	x30sttgBbV0hcLtCX5/g56FvxB4xv7Z3WGEyINSEG3YfqQMCVmEsvDtm11Hb6U/8
	83z29KyvI9k/F3csFZ+duXZEIJm45GZLfBPCY19tDVbFAmqjhnrGk07TQOhUCi7Q
	0KL/8twte8LYkyokxro+CY7gPxauImVOTV7/YDYH6liE0aQl4wdO29hb1CjmRJxd
	sh7WcmCk3v6tDjd7Ww9ULO66Q5aufgHEgn0RPhBSERInxIluqVCsqqm3BVWhfjah
	v1sH7xXISv5tyDoi1bS0Ug==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49v31d24em-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Oct 2025 12:11:54 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59K95vYr032333;
	Mon, 20 Oct 2025 12:11:52 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010009.outbound.protection.outlook.com [52.101.193.9])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49v1bbmf8c-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Oct 2025 12:11:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iuW8RNpGcUmQPhz4pbYJtqeSTxkLhq6VM+jgf///afP837EgZpRITW6gljTJJ46di/aJwtYyf4KvNlEtzohGdpx3uVaRgtLW7Qz/5TlkVTG7Vz7fG2Y8iG2zfv9EZZRUOw59zgQ+0qOhYNQAMFwhpBYan68Xk1yoVMai3Fa0ULjAzG9I37i22S8Wx0g2bijitRj/CZkmbQ/Ef89sy05dd5BEO7gIUEPBnGeLK/v40kIR8UAh6GmsaXU7kvb3Coqf7WJZxF8UjkDLorhuoshxyXd0Fpc5OQ57v0PrL8d8+0bva1kiIeLb0Dri89W+6QECfVw9NJM6py90ZThPsBPl3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t74fB1rLq63mz3sL6A47wt/uIDjXLjx7Gbd52PfTYGk=;
 b=veJLU0FxYcxwca9qotThtYpaT5kzS83NiiKaiR6wDlqpU3+vxAuQLmHr2YGbteI7N5qDwSn9obdz15OeBZ3trYZnFpNIFPyZ8whGSqQhLCyR3Aw5e25RnXDGv/WU/oCWPRJAVrmQXMeAcpqWaI0wrWHMJfu26gQtOC0ZGZmC+O3ymm6/gDbqzEBHnrvp6MyK/k8Ae17mWcjiFFgzZh3gtRT9fTqAHdP66J75oaLoLC4jvORSrqXNzliDryVi2efdVLWixQhBL8bQOXvgbVdkkx1I8Q9pnBu0ZnywdNIj7p5MHercrqHgSBcHSY+EnLFZts7KbvzFto0qqBeoOG6JdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t74fB1rLq63mz3sL6A47wt/uIDjXLjx7Gbd52PfTYGk=;
 b=m3KS06TcOg4F+iFGqdUhZYup4GDDohphksYmWCumYt78qq2Y6m+0Vy1ZDB9UkfqtCDl5sr8wTmKrRcPYIXsg/9bNiw+9a036lhWun88Q71CfYWNzz/eNW6WjRTGOBJEFTF4H0dqGUr1h5yGXlfQbsJDTlK8eItXRHZ/12Myhlo8=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DM3PPF4A29B3BB2.namprd10.prod.outlook.com (2603:10b6:f:fc00::c25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Mon, 20 Oct
 2025 12:11:49 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9228.016; Mon, 20 Oct 2025
 12:11:49 +0000
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
Subject: [PATCH v5 05/15] relay: update relay to use mmap_prepare
Date: Mon, 20 Oct 2025 13:11:22 +0100
Message-ID: <7c9e82cdddf8b573ea3edb8cdb697363e3ccb5d7.1760959442.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1760959441.git.lorenzo.stoakes@oracle.com>
References: <cover.1760959441.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0144.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9f::36) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DM3PPF4A29B3BB2:EE_
X-MS-Office365-Filtering-Correlation-Id: 37d96410-d7d4-4133-e190-08de0fd1d887
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kafMuMk73mJJw/zC3+RiNSe2+A1wxsu1b3NmS43eBVD2jnWjs7b6aOUvrpfJ?=
 =?us-ascii?Q?m5DMbDi72HnNzBmGJpLAw7nHnJ+wk/GtW30gi0sSCP19+WRGBrAd25by9EQb?=
 =?us-ascii?Q?hJtGDmiLMMR/dssgYOCoPNxxbwz4SQMb2jIP8TUoGGqYDXy+MIY/zN5gonZh?=
 =?us-ascii?Q?uegNWRWPC07k/3M8Nyj2hHn3pUb9HsJ4P4Yj4en6xlXE2p4KwRtNyc4LQXUC?=
 =?us-ascii?Q?KLcgBT4RIHvDgwNKyL+UuwUzOA4eudQ7iRx+/rfprhuT35hLhqg9joy7+6By?=
 =?us-ascii?Q?bsBt7DEMat/qGZp+HADDZ6mdzFCrgP04xYVTVutowkmyWkkxhSC6egaEKiwC?=
 =?us-ascii?Q?1a7rLywmP0+GTM0mXap2h3SPsUPa8xxSdo91q/jOf+/8EoNcqG++IX/XXKGH?=
 =?us-ascii?Q?TfOtpZmvvYlNffbebxHddWTFBXxvZjAzdEj419txsQrtk5q6Nll6G7AFQPuG?=
 =?us-ascii?Q?bYLJhZX4M3Nrx6XTHfRAuQptv4VB6NjoC0gZQ+hJnvwojpvm4oHlBRbDxggg?=
 =?us-ascii?Q?IqX/DVLLA95bZXidAaF4R7sPqmPs/NNyX8888jisO+HKFbuzWRzg57qFwP4L?=
 =?us-ascii?Q?rmELF/K2uPuDW1FY36jBiRHfIScTuUXypdy0ybK33/a1SNf2Km7CP9yWmDSb?=
 =?us-ascii?Q?VVrEd0g/DytGrKTmGG4INGZ1EUiQvSfL5akB3sb+bisRbFEk6dv+GO842+U1?=
 =?us-ascii?Q?Qx5boP8xzeYC5FNLYR6mQMzfuHIXpMp1Iy1c46rh15MThIBIas857IRGCBo/?=
 =?us-ascii?Q?3h7fOl+th4kQKtOMz1kXqhVPkgd296Xp9Ro1wpEAf12OSnkttAOo+E6KiJ+7?=
 =?us-ascii?Q?2efB2P79co7G3CwwXMJvTvaODL1wVl2eagxGEiPrK3OSv9zAK2y9IgURsF34?=
 =?us-ascii?Q?Cq3V/owpbjmULstheA/swz8hcqct+5MYoILP93uDwP/EpoyBXgCd606WL6MT?=
 =?us-ascii?Q?TR8b7uQe7Hq3qbM5Sy8J6HFI0UcY/61IoE+SBqVuPwSQ8HLl+ARJ+3ogXG15?=
 =?us-ascii?Q?mR3IIx9mBK46rQ3iMsI6bMVYvAOCA/TB32ae9ESGIBeO2KsPmaIciMd/rAQW?=
 =?us-ascii?Q?44e8JHxHC6lDnbfNs/wEHNg60n1lnQhCZzHW+bIu0OapoZW89+x/wSQ8cNty?=
 =?us-ascii?Q?/IHc6/8saDVeqWanZHYrRk2ZgJrWl+oy9zmPtToxhqafudEo1cDYdvJgRPuA?=
 =?us-ascii?Q?cpfBXJeEIC4QnGhORuOIxWZqcQiNpGVgjuaH7jVYU6kXZD/dmPdC7PSIoKry?=
 =?us-ascii?Q?jbglOskITvc3HqxG8Ii1e5hxJJwq+s/WQg/axnf4Iycnxk6avRNvGyDW8ng+?=
 =?us-ascii?Q?UDQSWiYVZrnnyEDrREML9iD05sl7WBLB8XuCpwuGCq3r6XWwpkNKsMzDRQrM?=
 =?us-ascii?Q?c69sd0128cYsqp/eA2RKaklW/mZ4DwEo3O0tahlfv/dRiX8PAv+2q8ph2Lbx?=
 =?us-ascii?Q?d1wg2/FO2NtU/HX4upPPXZUNM3q81+1J?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?G3cDzu3/FM7Lo9NfSWCEY5/4d9f7t57a29A3HouOUihs8FYR1SWNPvEoId1K?=
 =?us-ascii?Q?w4Lytyx84nkYYDFUf0C+TEoxJ+PvQvWMqP4AECpFeIQSG9/4L29jys/vPSHy?=
 =?us-ascii?Q?OpSTs8/J7d2coP5k8CKqlcnY1EJ9LzJapfHiahNOpOl8m5TsGS+kKn3fsxNu?=
 =?us-ascii?Q?Z5qhILeaOtBZmTmizlrBL/mVOo0J6+VOZVDFTqgTvAmT+18BUb+uK36/MPnv?=
 =?us-ascii?Q?OecGxEuFOMGYSZJEnqjD2rxD6nccoysQN2IcHINld6Iy3reCMRsouglsEhoC?=
 =?us-ascii?Q?h7DKSuuc1qyLH3oz9Ap2GbaV/Ye0adXK/2jB9Q6hJ04bwygzIi9//IRs5sKO?=
 =?us-ascii?Q?pSbic6AvQg1OXI3j1YVX/Y2V30MM0So8ooEoa3Jf3kGaIU6jeQws5M2m6PFx?=
 =?us-ascii?Q?vX8IUQ8uIvekrk/skLJnb2XcMEP8YKKMKnMnhYx7JA3e/snB9kPV/zHI+U8r?=
 =?us-ascii?Q?w/xil1gLpcAVDPewEoftnLjdiKo5HfoG8IbARvvLsaVmNUMJYE5T6C978HS7?=
 =?us-ascii?Q?DM2DrUWGz20qJEl/61N8Ypld6lL5UWNavYmLASlJH8Br4AmhLYxSN72HlXOT?=
 =?us-ascii?Q?6fa5daYRoTY5Gu5ZajdMR096tovdWWBczM2I1ohQ/Pqy8qJdmT/ue8TYGfbU?=
 =?us-ascii?Q?s2juVvNG7SyKjce9MxGdeqDclEnhwkwyIs+xvG4TiJK1CVOLabrvHM5sf0Z3?=
 =?us-ascii?Q?1F72IMjH6QIZESlnalfGSwS02LNjVQffW3t46I7coYUo+JSas5V0Lb4MN+nl?=
 =?us-ascii?Q?KWZYoHzktChiIb+y0NGWJa+VTnbsZQ6BfCyPdZ4Ob47lm5hTMkif1CRKF0SB?=
 =?us-ascii?Q?0uJpgksWjqg4kBZ9iTlYGsPrq5mHSSA8Z+jVys3Fzhi6YicX6+rKf5wxb+H4?=
 =?us-ascii?Q?7r3pzgbvIT5ytl8w4//LgTyhBMX7KJlKm5kVgaABk1fZl2l+qzR3/Rr+NeAn?=
 =?us-ascii?Q?ZxOT+PEiuXoi8TWRm2UTcip5PVZOhllyFP3pgmSJeAg8pYqS4D+YLYxSRXcU?=
 =?us-ascii?Q?tyFi0XRB4u5O/Muw+dbTz4VnDH3XfCM2ptZwqLcWRC3UNNJC8bC1yh8k7wiY?=
 =?us-ascii?Q?Nyc5X2JdViEQBVSKRG+rDflGkWRvEfi6p0rsxiBBrZSgiafIkscEsNxFBbLP?=
 =?us-ascii?Q?INWtzo2JaFtaUgctWVYqI6iYk+SxwgbOX5AaHxPnPPhPoVHu/B5RDjiT5YOL?=
 =?us-ascii?Q?zUxgGobteb3UaKgcALSykiiNmbBkYvH5J3tvKnFdqpMdA97FzTP+Y5EUM2Ls?=
 =?us-ascii?Q?2Tb/X3UDyp2QiNyuGxzOEGePgfQfPAPxJr3zbPg4/i4TU4RL637jsKYZ6UsN?=
 =?us-ascii?Q?urDzcq0R7aUsEk+qtNghBKggQxCJqtq10mqTROKyDcDJF2/ryxYsQ98GINNH?=
 =?us-ascii?Q?Xua5Gm8QSfyq8KBGOxhvMSKUfRgj/AaEQAuO8zuIFlPJMGz8AUdgsOh55BHa?=
 =?us-ascii?Q?1I8JkjNpdwBoh24SmV+KbpnXMq9ZElz0vRMFxyy/1Fyg8EN3ukpSOlRE2eoC?=
 =?us-ascii?Q?kIE3v72eZji9incj9PMCIxxRpB4BA9TZjHdquoJYH/IgB78hiHH3U8MATVru?=
 =?us-ascii?Q?+cRzfP3TGCtbXwkXsNtgCOZL7Z02KjertN4sPCNGRecLhe72tDU8U2TP9ZzN?=
 =?us-ascii?Q?kA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6/WQb1HsLAcQ5u9LvJK5kNV2WEqmyw6hgNk9ifPM9Xpm0k3vltLMfrlk2hc2/nw/MhzYyTWTSgAy6rmVuwRxQzLy1u9rR0XbDcVQ5KfX8aZ6l3ShxOi6d+7E/tI+nqtkOrXBs9/KUQMCDFpmroIRAQyAiseJg4FkrMuiOB+DgyV5SUvCoLA+VEsME93sr3pkKSmJrbufnKZmzGFMj0Ve5qu8eJ7hCap4TmLicn9hT8nClAK7R5nOaDuytXu/RCk8nORDRFSrAleMkhFpaqVty/eXCqJVedtX7cwJhvzMlEgzch265AS2d+uaw+irqq2W9bduTLbaTdncgE1qq9ULXaqu/yS8N+LH2BdL2H5X8+5krJFadFNAQ32DiiygHk2sa46NvYDFU4kWr8zBXvOmhf9FqS8tQhVTEyJ+zn7fyZXppwZ5NWHqCOFh/KawEj7TKat+T0VGZCJimJzgJ3r4vJ1XnjrW5yq1I+sW7ieWux8jkyWE7/pPTQu4lWtTYXn2F1fZktoiYrlz495MFozJvwikuRXr0nnjiprSXdbgai+be4S60mt5JFV7GIpDX88plx7gPAQ12Z92VaCVgA/S71nX7DYHvSijydl+uf56HfM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37d96410-d7d4-4133-e190-08de0fd1d887
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 12:11:48.9201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BTRI5Xln7wnyfuqlUQkuiBdBarY0/68mvks3HB5z1yzF9aISlpDG7WxC49OjhZrS9DTJA+c5D+kbUYuNaEY3GRT5ZX4ng2HNllKDbkYGTDM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF4A29B3BB2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 mlxscore=0 adultscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510200099
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMyBTYWx0ZWRfX6yi8QIpH/Fha
 ZM7FlxkVEYTxltAEweQt2JzJd0GRF96iqS/j3qIzhOKcvt5Q41rvi17pFUE5jlJmbjeXvlceYwL
 mLaofHzdod9JQPJH+1+SQeN5JKpLh07gyUEFpCWPQxbg8Zq2/gYuT7Dj180ifVYlXS09XGFW1v0
 wZsvC5YZ1ajYsXqaFAEQbZ4rTtSK8uXoOBdbRQCpllivcr1xFgyvQSe0U109bSxTCkTRXeBQ34w
 FtPjfToWmX7wbb2OQxtWcV748ByKOIy0u7xYp3nhQ21aroq5knVMNZ3lipVR+RSVg4/I2AgGvZt
 23pvCNeZmmao4scr4yHqpJx+95JZlMoupBgqWCG3ewizyPDasCE9lBMPlb5Aqt6bhSttmxmd1TW
 1EqMPl8kTLq3HoO1zkbRQJbF3VKPvRIQ2M8UPvOLhEa30+TY85c=
X-Proofpoint-GUID: za3lK1AYrWhC2lIkKwQhch-rg92pwCG3
X-Authority-Analysis: v=2.4 cv=KoZAGGWN c=1 sm=1 tr=0 ts=68f6270a b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8
 a=Ikd4Dj_1AAAA:8 a=kVp6y68UWkg0hX7IE8kA:9 cc=ntf awl=host:13624
X-Proofpoint-ORIG-GUID: za3lK1AYrWhC2lIkKwQhch-rg92pwCG3

It is relatively trivial to update this code to use the f_op->mmap_prepare
hook in favour of the deprecated f_op->mmap hook, so do so.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Pedro Falcato <pfalcato@suse.de>
---
 kernel/relay.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/kernel/relay.c b/kernel/relay.c
index 8d915fe98198..e36f6b926f7f 100644
--- a/kernel/relay.c
+++ b/kernel/relay.c
@@ -72,17 +72,18 @@ static void relay_free_page_array(struct page **array)
 }
 
 /**
- *	relay_mmap_buf: - mmap channel buffer to process address space
- *	@buf: relay channel buffer
- *	@vma: vm_area_struct describing memory to be mapped
+ *	relay_mmap_prepare_buf: - mmap channel buffer to process address space
+ *	@buf: the relay channel buffer
+ *	@desc: describing what to map
  *
  *	Returns 0 if ok, negative on error
  *
  *	Caller should already have grabbed mmap_lock.
  */
-static int relay_mmap_buf(struct rchan_buf *buf, struct vm_area_struct *vma)
+static int relay_mmap_prepare_buf(struct rchan_buf *buf,
+				  struct vm_area_desc *desc)
 {
-	unsigned long length = vma->vm_end - vma->vm_start;
+	unsigned long length = vma_desc_size(desc);
 
 	if (!buf)
 		return -EBADF;
@@ -90,9 +91,9 @@ static int relay_mmap_buf(struct rchan_buf *buf, struct vm_area_struct *vma)
 	if (length != (unsigned long)buf->chan->alloc_size)
 		return -EINVAL;
 
-	vma->vm_ops = &relay_file_mmap_ops;
-	vm_flags_set(vma, VM_DONTEXPAND);
-	vma->vm_private_data = buf;
+	desc->vm_ops = &relay_file_mmap_ops;
+	desc->vm_flags |= VM_DONTEXPAND;
+	desc->private_data = buf;
 
 	return 0;
 }
@@ -749,16 +750,16 @@ static int relay_file_open(struct inode *inode, struct file *filp)
 }
 
 /**
- *	relay_file_mmap - mmap file op for relay files
- *	@filp: the file
- *	@vma: the vma describing what to map
+ *	relay_file_mmap_prepare - mmap file op for relay files
+ *	@desc: describing what to map
  *
- *	Calls upon relay_mmap_buf() to map the file into user space.
+ *	Calls upon relay_mmap_prepare_buf() to map the file into user space.
  */
-static int relay_file_mmap(struct file *filp, struct vm_area_struct *vma)
+static int relay_file_mmap_prepare(struct vm_area_desc *desc)
 {
-	struct rchan_buf *buf = filp->private_data;
-	return relay_mmap_buf(buf, vma);
+	struct rchan_buf *buf = desc->file->private_data;
+
+	return relay_mmap_prepare_buf(buf, desc);
 }
 
 /**
@@ -1006,7 +1007,7 @@ static ssize_t relay_file_read(struct file *filp,
 const struct file_operations relay_file_operations = {
 	.open		= relay_file_open,
 	.poll		= relay_file_poll,
-	.mmap		= relay_file_mmap,
+	.mmap_prepare	= relay_file_mmap_prepare,
 	.read		= relay_file_read,
 	.release	= relay_file_release,
 };
-- 
2.51.0


