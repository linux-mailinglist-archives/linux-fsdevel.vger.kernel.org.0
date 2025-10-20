Return-Path: <linux-fsdevel+bounces-64690-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD65BF10C4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 14:14:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5372E4F354D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 12:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 378DC31D736;
	Mon, 20 Oct 2025 12:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UuXd+N3K";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QwhPEC5P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2773164D0;
	Mon, 20 Oct 2025 12:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760962392; cv=fail; b=BNu4/kNoA6fev6igYW6js220F27JhCpVgOaThORW3n3U9MolqNdwxuz/C+qo/BZMaudQEX/MTRvOGQK70dEWZC6V0BI7oEGsdvYuELyrtGd9OCiHB0rAZtb5UiJn9NK1BI9o8GX4w2AkCGLLVqLwiJ5EsK4YGYzdihkQI3HZD4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760962392; c=relaxed/simple;
	bh=8bXF/OF2BZ0Lkm0sNDo7wQsg58PSMo1i/l7E/tFXxRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YvWBVkcwDwQhnGvwYLaws7e5duPyeqAt6RYSebBCggiT/ujAsxV70vYMyug+uy609LuXpbiS0gdV/G4hARKWEjaTyivUIiJJNsJ19ypr1vK2bpbSRkzarTT8rybXyeump1auED5PuN2ze8HRyify2RI3TZTX03udgTf0ORtTbdI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UuXd+N3K; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QwhPEC5P; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59K8SAAQ018283;
	Mon, 20 Oct 2025 12:11:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=M/9wbtcAKwdUG3UoUrgwJVk3X2gqCfZSwMplE3hnfU4=; b=
	UuXd+N3KjGnV3zno21vCWSE2sDXg1CgpzyzwvNpkQE9xpNxwPHkBSFMA2J2uqQ47
	wiOjTrwOldgZ2R06O9r018VSvi+/RvVq75BMhb2dIvCyGGjSBgM6JO/tbUdHNKi4
	16dDZIFE4/DdepL/MAqP2o43c4SQLIyuz+Q0IOswinu5L1QNEXYyT55YbmLzmUTx
	sbt1SsPXFg1Y+NtuYWMboAEGd6LuaF/vqFA3oQH5VcOkn3Q1iyIHokkbusZaXlR8
	+1tcQufuf6YKV5WohxTK/BeZs2iboj6FQDCaMuZOmJpDylqWoFq0g3r/oTGOj+Db
	5C2IoH8hq+WM+UbF7tTTmQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49v2wat4h1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Oct 2025 12:11:51 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59K95vYo032333;
	Mon, 20 Oct 2025 12:11:51 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010009.outbound.protection.outlook.com [52.101.193.9])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49v1bbmf8c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Oct 2025 12:11:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZMOHWdEBbtWQpvuSTpYNnR1LWT24LPeFIf0IqDWEm5MDaHctnQlVvEijTPg5Gr5mVtdUmaOc9+tSTG1iRh/0U+wgomHvS3aEKKjT23a+hND8pfKKshYaOYBIulhAKEYpVDHG0xYNgxO+BLsMStHLbrG+YRqvAvKB1+Wc6Ln6o2Bb/gNkLoa5U6Nl2MJowzq61FAnsE7uXBUdgZVxqPogTR2YH95p2puHYz3JBCUj5Dq3oy+zWhsR8b6J+tAxRPgElJeXjI/cbTmGtqNHmO7qXWf70rmQFdUKOwpp56nDgxSZMUmlXWAztYdMHK1kwMKDmbifUa1g7Kayyp9psb1Zww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M/9wbtcAKwdUG3UoUrgwJVk3X2gqCfZSwMplE3hnfU4=;
 b=bRmHAqReJsmriT/Zl5ya2/9mggHzP3h3lJd15aU4vOForyT1Mx+QQPJgHsXOwaBZzCm9xJDRLhiWWxZ5pkhm4yoLjfvAYuvbTrTSwZSaM6Gium9QHwGnrnqPW7j2bKBFNqu/DaSpAzbSWYTm/QlRaUgqKjmcHJzL1skvyTAKqHdugLsBH56pODDX04caaaIoN0pqJ6HOPEB7sa3nVh2NX7GotLfE8ATdKyav8CcgU6Sjq2usVU3XBbnVoevHUwVVl+sTn1EgN+D0X+fjWpcvwKHxHftJJMy7OPM0/mEG6fUZBz58BAmTTqZnnrmZjXYSOpE9FKudPeUhPZluioMevw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M/9wbtcAKwdUG3UoUrgwJVk3X2gqCfZSwMplE3hnfU4=;
 b=QwhPEC5P2fvzQcA698oLcNzXRFbPaRzuOmqeaoDwaGMowGQYp+Dl7PtiqU+MbGDNOfNKkmzdsukTsOpmTy780AjepoIxJc2AegqgKywgL/kWna6U/j2srqCwGPVUo/+g7Tv9JvDWRUn4wbOs1jzZP1V9ejDlfr8V8gOsRlz5kI4=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DM3PPF4A29B3BB2.namprd10.prod.outlook.com (2603:10b6:f:fc00::c25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Mon, 20 Oct
 2025 12:11:47 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9228.016; Mon, 20 Oct 2025
 12:11:46 +0000
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
Subject: [PATCH v5 04/15] mm: add vma_desc_size(), vma_desc_pages() helpers
Date: Mon, 20 Oct 2025 13:11:21 +0100
Message-ID: <74ef338203c9ff08a9ace73a8f1f6116a79112a0.1760959442.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1760959441.git.lorenzo.stoakes@oracle.com>
References: <cover.1760959441.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0073.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bd::6) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DM3PPF4A29B3BB2:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bf4dfb5-b51b-4f9e-9dc3-08de0fd1d740
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ORJsW8IYa/c02Tos52ngp3Zkgm4VFqInbq2PU5p3OFjmcLHLClHPW8CpZLtx?=
 =?us-ascii?Q?Qi/DIKb6NpR7BL951Jd6wdVbrUYXjTz8mprOACS5r2rIERmpFVTOQgZ+RBH8?=
 =?us-ascii?Q?3Gtt96E81E/QXjmpE1AHVABx1GMoVo4XLVyUt4E3foEWXni2tJ9nBObFycPe?=
 =?us-ascii?Q?cQfdb0KHZsV3CEomBSMBxt52f1Yx0Sur0X81FNJCt7F8sVcJ+ce/HIm6rvOv?=
 =?us-ascii?Q?pbfR/vwvDg/08izAkLNDnRq5ddLsd5ZKZTbflQysqvBFiksHfRKE1re0KXRV?=
 =?us-ascii?Q?9Y6oqr7pwxFfejKVQhrFB3j43qDjiXt+6YTokVbXAGjVT50qcGGIOTnz5O8t?=
 =?us-ascii?Q?j9MIAdz1vJExAYZEX/U394Awnf4i1xn5v5H9mmu+C9Gw1gKHmG1R4osPwbiU?=
 =?us-ascii?Q?3DMt5XrYLr0wtX2aXhwWwIUxh30zhqCrfXRpSQPaxVJCkKsuzAfgY5mLFfCS?=
 =?us-ascii?Q?65LPFBVuCTMWI96S/hMztOTYoavtqe17SE6masJf/A6rw1tq3L16V0bu6ZNg?=
 =?us-ascii?Q?hx8TICDnRjW3v0hMD815Z91IYVFUxkDMRLC3ll6cOAaZuBjx00ZWkTtTOzk9?=
 =?us-ascii?Q?B44TuuY6yQRsmnUNSWrHddHbSbKTXMpB23Uv+yBgZ4WT24jPxkki+VhoHpIt?=
 =?us-ascii?Q?DlZGWJGE4lMxtqzLBb/Xc5Pvc+LF7Exmpr5lJlC7uz/ll9OMULe7EyqK+bk4?=
 =?us-ascii?Q?GKRV5aRsEF5ClFxYW99b4XbwDg9qkwcHYGPzVe9iPYZpGdasG85kGOiob2o6?=
 =?us-ascii?Q?k8P0SlEAUd3k70tbxyyUNIc8eIuvQMzI7oZOePkz2QMWRZsRtxY/RvWD287/?=
 =?us-ascii?Q?1+1LfgMZFxsBXLavWv1vUKd+2lbqTP0sv73dolH09/VGVNaybZZNZ8u7c6Bh?=
 =?us-ascii?Q?v7a0h4Mket36JRBv/+Hu9BDJCLOuscLI+EQQXy5Ebhx5JEFUZTJjPC1aRHd0?=
 =?us-ascii?Q?parlsdCzdG3Wfo6KMCXozUih8eYLnptgpP2SrR+w3AGqqpowGydaaYqsXsdD?=
 =?us-ascii?Q?Ve7+pchgaNPNZcNuBtVygohKEfdE6qCz4gNe4ZGac4PXDSerPZPW6H5j7idJ?=
 =?us-ascii?Q?Tu6ILN6WPABVmLGoXim8YaL+ks8ShsnDPtDsHSpZh99RnpZEjrLKuv/7rnxH?=
 =?us-ascii?Q?ZnRZyRqi8QHfU7aDFw34OsBdkbi8Ljmc9cpi+se4Ny6/AglPsYPvdPKykecY?=
 =?us-ascii?Q?GsRJQZYDS96PpszWqagCxcF2cQudLIIVe6JYXlq+oR8epxLH8gEl2Qp6BRWZ?=
 =?us-ascii?Q?G6e4nxEo5cus1CUxITJGxUgpLLLLFQ1iImn/myiPUzzd4dN8XJ2bqHzlRnJT?=
 =?us-ascii?Q?cw1mhrdovh+h2q9S2Fw0jonPqsWMSxpV+XTwuj/mBcWJgBOzCm4xGPSyrUq8?=
 =?us-ascii?Q?GeFq/Ez9euJxB5sr0TiL/EpbZN7TxjAMQnsuGNMjzvMbXrYDshjE6G15C0RP?=
 =?us-ascii?Q?2gUXBvLUIdjImTkHRn1mZMOSU7Fd8/uJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?E9kWYy5w3HKYnDWAb2bLaHV+pDhsdN2boseDV/22crlT747sZIq+aTJAP+YA?=
 =?us-ascii?Q?YQqd3NPrICwl7AsHIaUS8cSFAofWi5dDwyFOk2FqcOhtl/JblTcP4WbdLr9l?=
 =?us-ascii?Q?j9OGye2vmoKEyt+Df0EcYLiF06YFFDd74BsSKcAL0hYyRIhk5AKtvjmngfmg?=
 =?us-ascii?Q?zSFNyOHXdVLu/jZseIVQ6pJ66jqRWP021MoBgiw0xgjfaXGNfCLJguv3dXRn?=
 =?us-ascii?Q?WFx1PegNnOXPhpto678X+EFDeTho1OtDlDaN9Rx2z5YVr8kqjBuJD5J5XoNA?=
 =?us-ascii?Q?x/Pjv8aMbYZXV+FQn28+7s9lrK8zaPcRLTnjjy2RtxLT0qqe/7lP/jeGb9el?=
 =?us-ascii?Q?ru4nGyJDnBk9kmoL2rjIjEW+PJwznNcQahjZCwcRRac53Ek/2GmlMzXAwTXc?=
 =?us-ascii?Q?AVsYlvTvYKc1hXydbMt87gM5SwlMLp9G9dCK5Apm5QcMINKayEVHE9M1TJJ0?=
 =?us-ascii?Q?Jw/825kglNAF/oGN+NcBkMxKhio0zkolEDuUMfeiWET8A0KMXA1vomiGTGCy?=
 =?us-ascii?Q?WmNmqgMRwMPNWf67zALgqbThbGSiQOrg6ZS/r23zcz5nBt89Do5hWz0stie1?=
 =?us-ascii?Q?ogv7vkaUH1cbd9rxQBMXQquqrnuzCGj2Ljq7PBTlkvEX2RDjN9LjSXJoJwu5?=
 =?us-ascii?Q?ZH0cm9ib4Uy5zrI/Cjm47YZPvKvKiWDcZDUqJ2kwtU6rTy/tOTuL4OrEb62/?=
 =?us-ascii?Q?u5IuMu3l5sWjq0dDKcO1TI2uv63/qgtHgSp/AWIWf44unecT1otNNsCPv40P?=
 =?us-ascii?Q?n/qlLuSYsXSM9F1nr8J0xXUzx5X2lpKdWxXTANgabV6UayJ3bWUcF1+rkbdV?=
 =?us-ascii?Q?4k8k7dKUcVgtIhLxQsWbDoaZei3hImvq553umeDOVPp9wvZJ1dAnbOxl/0Ue?=
 =?us-ascii?Q?mE94GmAY/5MRC2OiwPJFn7UN8ANJhE+zKAHogjvDepScUk1w5h9KPZBIjsAY?=
 =?us-ascii?Q?5gykdDvZphKrsTc9FwjPRr5vjS8R+X975kPweRdQOtsBVXS9tB8neqraDETv?=
 =?us-ascii?Q?P1g2e+1kiBmQqj9tWLCgYvvfhiCxje9yF5yFM7UtC89LI7p4wv3kLdnrBhkj?=
 =?us-ascii?Q?6YucllvaH4LN8zNuLiySD1MwcBHx9+5IlpPJBBWgcfo5JKXPq5H+mtW6szBt?=
 =?us-ascii?Q?VCekphwpnIXYHjgLHiXf2I9MbLqsATDz9Yn0AkM8r2VPItLs1USxKUMI6+0h?=
 =?us-ascii?Q?VL/fhmhBbnM4HsfQ0zzLxPYukjuUjm7F2JwbOd4lNJJTgeb6l5jLQk/gIijO?=
 =?us-ascii?Q?P57AoNYqsa9cQxJYK5Nk0GbAzL5/kXpq6jJ9FWcYzsbjpcZdPEbhd5RwYCyx?=
 =?us-ascii?Q?rqxk5oJMoqBQXEzEEVRF7xfPVGFXV+5dhXWYh5R/3fxM7dLhKYTifmnYOIdN?=
 =?us-ascii?Q?YuW4FfPvbU4G7hKhaupJIh68rNOjLxArfqDK2M6XDwqbV+azBMxngXkmXi2I?=
 =?us-ascii?Q?39O3I90aGMgcImWOeCs4lx4iDJLExO9NnEH/8VB9i8g8gzdvOePOe2sc6WWf?=
 =?us-ascii?Q?hMUIS0LygZTWyR4k8NDYvf8eFbTLSqgf16/CFgsnQX85Lvsig8ssszVX6zZL?=
 =?us-ascii?Q?C9dAHFOkFOzz1tYlY7L1zM2PGEGI7FTgqX6qiEnqg6lsyUpGEtAPCgmlIpoN?=
 =?us-ascii?Q?oQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Oupu5XsGdLOxCTB5omiRib176UtJ5S9Nn5ygSOwMRH66KFh8JUWMZ/d8DY8D9eEFdDRpRz1RyThVEeC/e5PoHXYTtpqWKMJCQpZoX0ZzwGpSbT0PcA0+pOTrPkZN0y2T7nfqbOMhXkaM+zTdpGXhQns3VVPPrgK0iyNPj8m60kovdM4HnOr95ZP08T0Uzl6M5cojosMjA2n/FBSF8L9o+n1Rwl1jzXH+VC5xb5kVLZ/7FGVHByEVaiODawyKDOjs+e/xuE6f0DYQJULaz0dLO7GDAfGEoOf9xd2eqyEC+Egkqh1D79sUL0K+dYXBkKEbEWto0Ddwm7uypW9OJkReD3SolFsDrV6M56EfnbUMfiitYJ4j24Qx61mZFlPdTDSdQM586FlFmHGUpTwUbTtj/IZIM3lMAPAXZozDTbIV9pr+ud6SjpcCG8jA9Cl36vxIHXb/K9eQF3fHnQu29PWHOYoKl5WVEs3BHd5RSGwdr0ticlLVFsz/Ee8eHRrbantUzbTEXLiZ/zG6u6d3CNvzkeIH+hW1wXi5asoPxPmWpiden7EZb4x+24q4PuJWv4Fc/KuYMZWMzOF9B9LOZG0z/mAD8Cln/FeeM36w25VMI9o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bf4dfb5-b51b-4f9e-9dc3-08de0fd1d740
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 12:11:46.7769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R5EDnR8vatlGmokQdC1vE1FdKkqtcX4uXtPT66TA0Y0oPQMjA9BTEwWDrvOd0pE6I3NkHr1mqSkTrzbROX3h6NuARvVc7DbaVEdq7pm+jcA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF4A29B3BB2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 mlxscore=0 adultscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510200099
X-Proofpoint-ORIG-GUID: SMdQI8oIORx4u9Gl_hb7JC9pj7Q5gO1Q
X-Authority-Analysis: v=2.4 cv=Pf3yRyhd c=1 sm=1 tr=0 ts=68f62708 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8
 a=Ikd4Dj_1AAAA:8 a=V8PVCHvh7cpLA54rH4kA:9 cc=ntf awl=host:13624
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX90ZicuiHr1au
 UIt3NRBj1lFwSEMJmfV1dqGpL22tPcQhw10Fwfo4nfEQKtxYqB+AuB9wwLzkAJNZO2pXRsD9Hg2
 ekbSZVgS31aSETL7Ocszhcmp/fZCvOV82ER7978XFQSnUEqosLElTMc9vn5Uwxwbh3/sp74HTnm
 7MszLwOJ1gvn9bSj5k453MnMb2uFGXRnnLvsmhw8bXDaDQtsR24LsFOp5Nds5YJQOXLfoERztl0
 0/KSU3irSL0C+JVmdd6LFz+ts7ciEwBqrP8WF3hEwoeWw1AlE8uKRBg4BNydQvtnxFBxsY8n7cK
 oXGowugItU2cD7VdoxkIzIAe2tR3aBCNR1ieoWWw4PY26bla4Pq3pWpc2rVGtm+8DZaaVgylGIT
 2QpaDYxXJG0P+HX1dDl39KWQRVS1pDiiA6KhpOsT9amS05NGRCs=
X-Proofpoint-GUID: SMdQI8oIORx4u9Gl_hb7JC9pj7Q5gO1Q

It's useful to be able to determine the size of a VMA descriptor range
used on f_op->mmap_prepare, expressed both in bytes and pages, so add
helpers for both and update code that could make use of it to do so.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Pedro Falcato <pfalcato@suse.de>
---
 fs/ntfs3/file.c    |  2 +-
 include/linux/mm.h | 10 ++++++++++
 mm/secretmem.c     |  2 +-
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index 4c90ec2fa2ea..2f344e1ed756 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -332,7 +332,7 @@ static int ntfs_file_mmap_prepare(struct vm_area_desc *desc)
 
 	if (rw) {
 		u64 to = min_t(loff_t, i_size_read(inode),
-			       from + desc->end - desc->start);
+			       from + vma_desc_size(desc));
 
 		if (is_sparsed(ni)) {
 			/* Allocate clusters for rw map. */
diff --git a/include/linux/mm.h b/include/linux/mm.h
index d16b33bacc32..b6ff6c640ba1 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3576,6 +3576,16 @@ static inline unsigned long vma_pages(const struct vm_area_struct *vma)
 	return (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
 }
 
+static inline unsigned long vma_desc_size(const struct vm_area_desc *desc)
+{
+	return desc->end - desc->start;
+}
+
+static inline unsigned long vma_desc_pages(const struct vm_area_desc *desc)
+{
+	return vma_desc_size(desc) >> PAGE_SHIFT;
+}
+
 /* Look up the first VMA which exactly match the interval vm_start ... vm_end */
 static inline struct vm_area_struct *find_exact_vma(struct mm_struct *mm,
 				unsigned long vm_start, unsigned long vm_end)
diff --git a/mm/secretmem.c b/mm/secretmem.c
index a350ca20ca56..c1bd9a4b663d 100644
--- a/mm/secretmem.c
+++ b/mm/secretmem.c
@@ -120,7 +120,7 @@ static int secretmem_release(struct inode *inode, struct file *file)
 
 static int secretmem_mmap_prepare(struct vm_area_desc *desc)
 {
-	const unsigned long len = desc->end - desc->start;
+	const unsigned long len = vma_desc_size(desc);
 
 	if ((desc->vm_flags & (VM_SHARED | VM_MAYSHARE)) == 0)
 		return -EINVAL;
-- 
2.51.0


