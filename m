Return-Path: <linux-fsdevel+bounces-64695-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 695BDBF1194
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 14:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80CCF3A70C6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 12:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17940322C80;
	Mon, 20 Oct 2025 12:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="p6jthHOT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CQtZjuEr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6023126A7;
	Mon, 20 Oct 2025 12:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760962394; cv=fail; b=C9PEb2uq1m/SQO/9CTtVNvmaZ/EnL9bIMoASyk2H9CyOxKoYk2wzKJ/FwfrdcjogEpygzkXyQsRfUOc822igGjsoh5La+QujNGFkatB2p0UX2sRePQwlDggAxjwFzh2kaLvqwMmHXQIuNAXVKj12TGrP0K01pO1/dXTnRxxYN5I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760962394; c=relaxed/simple;
	bh=ATDstBNO0H/QQzdGkaVEJglbWt0Eil2XiMCuxf/dQUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gQc+t/B+sBbJG2nYPFRPklkT7z7sSMtYEkvViNBomIGchLwTXDcjBHIv+/KgEPSqrnlOTQOIHtRpB0MzNOWcUR+L0mZHrYd3RYPIT/jVHBiY/y7u8OfMLCTcArHOrwcG3HHvF4E9slGYvMugJf0Ryxx2Cxls+Z46pyQBG1snorM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=p6jthHOT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CQtZjuEr; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59K8SGFt027953;
	Mon, 20 Oct 2025 12:11:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=zQBd5J+bTyqnurPcPzG16hZ9knQTk1Dp+BRxC4fYcbc=; b=
	p6jthHOTCKctcSbznsCOI3YXHK0j6eT1hz5IDDPdgYvFbpenevkK3+fhCATqDniY
	0kOq6bfnsP5fV3in4DFILjp8z+n76Pu6tN+iWgeBxtBMbtgpxB/N3o/EQWqotph1
	tuD4q+FX9fQ1f/5kWg4FbSWhTKc16Hba81lV5/KbHNtVLAvSmn0JPJidchuNALtv
	V+yggDoX+AbTe2lZeM5b57K2pPelwZD+LRvVjQhNlXZnUyfsrFYO9fNDe2MNkb2z
	r75UJVp2zIG3aCWATByYAoWGL/9EZ//aHrhilWmapS4pSrv8YGC/wAw16ZlBtXlQ
	ic2sz8TjzgGZzfeeRFw6QA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49v2ypt5jb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Oct 2025 12:11:46 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59KApBJU013726;
	Mon, 20 Oct 2025 12:11:45 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011007.outbound.protection.outlook.com [40.107.208.7])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49v1bam2hu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Oct 2025 12:11:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MPrS++sZubDvIv+nsCZt97nQOPi6ZkFyNT6+Kr3Ueg+BQBxfryq9tR2hQWmJdC8y3FaJPUU+OkKa7X8b1Qbk8YtApHo13DTiWwK12UIKfU2FqoWWFqCbuBQSpcmC+f/YFlGuzi1fm13/zuo13g7jCG1NhKPH0wHv8B8v+Oz+hrYdMcbpy2/bKUX52m09ha/q+fcLsvPZ9yzSlRbXXUTETnFlwUdJa07/n5Abk2Y+hNc84knaSlndGIyi40ww/kcMI1txQTXgo0ejS/+vikkkznf6QaUxTRhgC3XIuUvrdzfkHGRe/jitJNeqYY8dYfDjbWKQ2fTf5X0jFyoB9WbpVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zQBd5J+bTyqnurPcPzG16hZ9knQTk1Dp+BRxC4fYcbc=;
 b=wgmYKRiDJL7/aaLqaPTFo6suR1E7eXX3/d2dMNSDX2FTiNP0Jqik+vLaInxbVkErx0X6Nutgv1SNkw/QOWVd8cU61sbRGgFvGuMLS8sIkHmgEVFj6GHTk5L07OR+kktYfWnqYfAfYqrD4cDMbfopdILH1eR1VIP7TBMFQNte5almRPvh2/oTOMfnYEov96ebbGJiaJ8rF+bHCYO7/1HfpGWIUQ+Ynl+9imEMuH8naIEttRtzrQmf09IwlLlWKG7XB95dxJP7uUb1fmSsjz6AQKDaqhDWRM09XQVDDhgsVZv8Ljx+gzHp+YpB6Jb7qlufSvBTtYuUSYOznRe92YXhCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zQBd5J+bTyqnurPcPzG16hZ9knQTk1Dp+BRxC4fYcbc=;
 b=CQtZjuErhsybVMECIweLp4nHlCmVGnKekwQxJHh3KaAjNuPRfNLbd83naKDuHNxHC2cmYdnJcdiiz0SQZiHvVU4EofOLSNoCZPudXb6ffvxpI0YCQattwGZhtdJDBxD+C9TI6DLHDMIW40OII6sZJnVePCiuAVPFSrgQO3727Wc=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DM3PPF4A29B3BB2.namprd10.prod.outlook.com (2603:10b6:f:fc00::c25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Mon, 20 Oct
 2025 12:11:42 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9228.016; Mon, 20 Oct 2025
 12:11:42 +0000
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
Subject: [PATCH v5 02/15] device/dax: update devdax to use mmap_prepare
Date: Mon, 20 Oct 2025 13:11:19 +0100
Message-ID: <1e8665d052ac8cf2f7ff92b6c7862614f7fd306c.1760959442.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1760959441.git.lorenzo.stoakes@oracle.com>
References: <cover.1760959441.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0075.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bd::16) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DM3PPF4A29B3BB2:EE_
X-MS-Office365-Filtering-Correlation-Id: ca26e281-6617-4f8d-6980-08de0fd1d4d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1I66Wg9R7uSaJNYg2xRDmIm2Fdb94uMg8Uid4+6JoF4JOzvWfDnf83gz3hOz?=
 =?us-ascii?Q?ZtA6dt97ezpz1oOEr2OY3KI7H52ma8LDHVtUEKEFPoyhVscpIx/4ctuRqbMi?=
 =?us-ascii?Q?ylrjdhi9mBHimutla4sGOo/ranzU166zpgudj9yd3ieaco34BUH+qNRbd7CX?=
 =?us-ascii?Q?ScC5kfvFtCDKtzUo9WIjnZGJBTDqAtx0sDbULN3CUFIELzX8AwoEkrOQKS+v?=
 =?us-ascii?Q?P/lxNYnAvY1Rhv/HHtDt/7tSh+D87xF2UBySQsG4hbI4FLlkQ2M1i9b8dgTO?=
 =?us-ascii?Q?VGsSutSr6PzCDDXBRpwJh5DW4mGgYTBFZqtFGqWk9EMFYJx9C+C4iPpkQ8g5?=
 =?us-ascii?Q?bQ1p7MOI/0vIKTVivg1jdYKFj58tTSc0SecmqfoUTKBVEr1Lg+Fl0IBlmQsJ?=
 =?us-ascii?Q?eOXTxoGG4T6L0x8+5kgZ11NFu2TXDRo0RJtyjwyGjSw3bSzklJzniE/zNdiI?=
 =?us-ascii?Q?oaPdsCko9Wd33h2e/yyQLgIR+tqULtR+F/rmQB3z+mJ4NKEy1JY3fI6xlulY?=
 =?us-ascii?Q?cH4y2xCqKDEdgp1R0lGuge6zTxWN0rk9LyJ2IL8B7vxBfXBdcF7GPA4Rl57e?=
 =?us-ascii?Q?LIqYVyN8jab/TMktEw8rsFeINR4poMDd+6tY33pA1tRyzrxJcIjo6xV/mSNc?=
 =?us-ascii?Q?1JsPjuj+z7Kifr/7cZxuaiTVIbATcwp0huFuJk+QcA/Zyc0aVevAFKSm1KKS?=
 =?us-ascii?Q?KEc99dwLeAIkG3X9vwSxrApTPkm6JUFPM0UY7Q+0f5Hb9GxFLyBKuxay5JWw?=
 =?us-ascii?Q?Oe+pMNJqA5RdQiz1bxLhRPwuUqaQ4kS7qCeag/i0P00VfPSb0fvUKqORxYuP?=
 =?us-ascii?Q?85kX7sWigIDSFjR6aPxqJiHkVQawojm45P0+ONC/53pkUMVLUIDCpx0EweOP?=
 =?us-ascii?Q?YpSpdnRmgR27Z1Ozsq7YoP1/eNm0m2Wb8H0N+Lfusb243zD7FLfV+4q3ONgO?=
 =?us-ascii?Q?xvvTYGa8ibmDuW/WU05sfx67jUy6w20CPaOjl9zpkO4w0Hs1X8Eg6LJTdoMG?=
 =?us-ascii?Q?oc1bJHZd95HVBN58wfxmm4VKQVISZEYf0REesPJM1eAq2IZOldwFEgg7SsOE?=
 =?us-ascii?Q?SafM1EHLTKfY0Rej01rTccIxlZGVRdtu5/dSIAxv/YPPCB6TeUUzrrHCTW0D?=
 =?us-ascii?Q?QxOvO+MdCb8EUkIokLUuGm9G7txCVkfhPlbtLQrjDpPF59RCXRzk3UrNLgm6?=
 =?us-ascii?Q?rI1VpbUuLqDsXcysLu5RJdlvNU0hdGEmRcqv0IYPxpdxmZac/5yUqOSb5OPU?=
 =?us-ascii?Q?QFYze1O6cPb00+k77SiCr7Ddsv43oM4iK4Yg8ppcBrpFUlzNtYdcWtHDVZKB?=
 =?us-ascii?Q?lMK45nBq2fKRIPP3SMpUpCliFJDQTrQB7FItliA28Wkba+WyV8bdwQdW1nZ7?=
 =?us-ascii?Q?VSZGqnzS0ax6qM5x44ToiJaSK1PI/IPWs57xZmfYAT23EHyTzlcdMGzK6WlI?=
 =?us-ascii?Q?C/oc2m1ULt4dNBHy5FDaU36Pc69M7+hw?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8sPaAQY3lbz3f5Xe/HKJyMMTW6jhDd1Xx26fjJ2NTf4ZILYaFR3mXfSF7N0g?=
 =?us-ascii?Q?7HGp4g2oQ0ZrtpWznWCztSCbgp64qYzUmzDiKKQDiDkndjXj8IaKYTnXoilG?=
 =?us-ascii?Q?RpTdbS4LvNna9AV1KRAN8GJ/9qxDmPQXb5TiE7UaUofviyK47yU4MZNHDTWL?=
 =?us-ascii?Q?cA7SDT4h2zRKQhMEvVMtqWCLt8/7F8+f/KXnA8CMAIysKdDADBI1W3c2Hw0c?=
 =?us-ascii?Q?3ZQn8XYoJyIFRJaX5bn/eEMFsvCt1t19oPGIDaC6GekSiAfhNpd5vPAefr8A?=
 =?us-ascii?Q?Peoh2UtFwVA92nUmLKPf++t12EPs9wTcRHpXf5U3eMZgGPalXluqPorCeoGE?=
 =?us-ascii?Q?dnOOVnKe3KfUNq+bpxEkrp6KnFdD8nDGoRFjwRgwRZiVrzgF/G8rK8FTRXBx?=
 =?us-ascii?Q?myQtXtlIzJZ1ykO1xVVEf+JRLVHZ0YIA0Fd46i0PVFu4Yex5UOZlGcOVur7C?=
 =?us-ascii?Q?8ciixANJqNgzd+qm6ggh31quBTR2cbihS3o3T1hZuNqZgL8iuUIfljn+DHh1?=
 =?us-ascii?Q?P6SFsUdFZTHWxJG8HTKx3JydxTCdK/YLROJfNqVk12y8soU9NzUezQAlKz1v?=
 =?us-ascii?Q?unX5saNKZR5cjFw6Ok0Hww904SVcmlDfn1m5gYKB3phniFgzVCdlJLVNgaJn?=
 =?us-ascii?Q?twFoG8hHOgyfHPisFI4vsh1eWtFoeT3LLkwmJVrE9FvwuS4f5CZ1ipO49sC5?=
 =?us-ascii?Q?CC5a3a8l70+BGLicFPrmZBwmbFgIUBvbXOv6HLiFnNEIkLVcSZOhC9WBvXxe?=
 =?us-ascii?Q?fmQEPGJH/FUWD5IAXO500xuBC/vAnpTn5b+AqLUHkQoC4BjKwuYi4UVu55lW?=
 =?us-ascii?Q?VgaEKpW8rYpY7OUJTLfvcakmYVO72Fu0XkPfYucVZQWQlHcpx1ME8nQjuoyb?=
 =?us-ascii?Q?IgkG5IFRr8W6X9odLhLOrLmbUQdZsJp2MsvwzJIfCnGf8P1c06m0kxPn8VUB?=
 =?us-ascii?Q?Rz+eFc08Gd1m13rva06ZZGyyeXW2dEWLkLs1AzesD7jlknG7J05oNfEexwF+?=
 =?us-ascii?Q?iCgSyr1VtQwdCcr4TknmD3Q7FVKcHj6eCU7/IA3VPrRlkXBJsTXhHi3Rj8Fb?=
 =?us-ascii?Q?fLS4b5fGRidBYwx4bbWoH92noPVYvJxmhf9Jw3/RmHC9McvUZ53+RmxNvX2x?=
 =?us-ascii?Q?UN7C4KWDktaExtTqXnie1WRi3lPH9BHJlSxgvCmRXgNOMrf2lgUpG+NVPKdP?=
 =?us-ascii?Q?R+RTolQy//qbdsuTkFhyVajFiEZxSLqDisEPfmMOMmSMXbMSwuIHiWcEKu8y?=
 =?us-ascii?Q?YqdVCHaErmzrbEd8ivHxbv7rl+yCsqgONTFdKXhJenHzkjlm+BUJqx9ctU/E?=
 =?us-ascii?Q?jvDSeWfQ8wF3luHzNqGg9YYA23bMJfiVA2Ii87raohM7coAFHzqPM4pgWwcw?=
 =?us-ascii?Q?fsNpU8iwfmwDfttRsg9QMvpsZdts16935Y5HMT68MN7osDPqKevNsv4Qx6Bi?=
 =?us-ascii?Q?ZXzVEv5PJemHsudRFjD8VRGNjKK8fCs0I8snHJj6gsvb1JrTD0dvNM9IgyYp?=
 =?us-ascii?Q?62aM0rX7X0AxPr1T7ynUOmu1iyT/8KOFHdiZoKiWljFkdc1TB3rEZeoJW+Mc?=
 =?us-ascii?Q?/RiLWPOcnwVAag8UK8nq3OUfx/D+fo/6sBoxZGi/cLalFaduQouj3+vLCagD?=
 =?us-ascii?Q?QA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	cAeKrVcMU0tHmNZYdEOutqfPSVE+HaPtGfVrel9OXl6Y7RvagZhZH2UWhJRjkGs2k8O1ObdHMW5mVhl5C3K4w5B9355HG/hBXgqcAodiXoy4HfcEwY6DngsDmymjoLCIrhllfL9irIfhhk8i+RWIsgCnxzu75tCGA5caRnWDKcA7XXdowxKkdxup+Rs4ZtcIYob1xbnybvn3jxdl3C2l8B8pKjJO3mEbWVTogq1aH63p1+8ptPNHTDzs1S0x8070kBac/QxqtATDA60mcdbNmszIC0et/X1Q3ygXzDnhWEhJ7IWNVhuoLBihHY8JfGBFelIeVwqRO1hhgm8KzRrBYueUjP5y3HiB28QAXxEt5w1L0rHJug41tS0YzAtnmQRg1KPzQY+zrPRc3E47CcsUQX913Ib412Tuwz4eSZ40i5vaTuC8gj6G8ZrEhkXQLfpBvf443sUjlPoPmKi3ZfojppNe4shzO4F27Wu4b40labxcno3mp1SezKQC2ZwDqSj6hBkFT6wxrd48OdDH8v3tU1gQziQAq5vzpSWRfmok0nRaVY9TLqp9p0D2MeZOHkStDSLbEZccIwBrQG3lhBmRhTcEH6NWe/63Jib5New5bWk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca26e281-6617-4f8d-6980-08de0fd1d4d1
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 12:11:42.6929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CnCHuPYGO/is8y4GHcdfdeZFdknqlwQrTXEfBHGoPuzfrDCAkw77xDuY85vRMcfG80FUfPzWCIcanNDcn3rvUxfziOP9e/chIYEGfpkL3Bs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF4A29B3BB2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510200099
X-Proofpoint-GUID: rgdLFWu9ctaBHhqVftN3jrDXI1S9JUAA
X-Proofpoint-ORIG-GUID: rgdLFWu9ctaBHhqVftN3jrDXI1S9JUAA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMyBTYWx0ZWRfX8TyWL4+Mgdsp
 s3Commw35POHu8NMKe+Z9j+VANrHCcYogEAaqPKwh2wxbEmp36CUVoEWwgFUUEtexRg5FuB+2MF
 W2BpaKsZE6/KR6MkIcR4WCQnbdnHloNiy5if2ApIv3IStlmeWcHeSp+KbYYIM4Zil6NV2RL6G/j
 p/z0h+DbkzvRrzn4ayZS3qI/nZimQ4MCLgKzDe2wr76IYIfa3zSQtS8LMAg9ckaeAS2fTUtEgvH
 +1fSGNcXs9nhIipqBhT69UquRwT7bQw7sDzP8NBJb4taEhWhc55LJTA9njXdYPJROh3QH3b2kg0
 7Qmtvbh27FOV0VXwUkgpf6cSpk5/QzeTD0AmnUedWXPMd+JWKt6EcVTADILfrzexR/eXIBLoJsX
 anp2hnm6pxO5DWLvAOF2wpYO7CKJLA==
X-Authority-Analysis: v=2.4 cv=Nu7cssdJ c=1 sm=1 tr=0 ts=68f62703 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8
 a=Ikd4Dj_1AAAA:8 a=miBipihQI5mFMOzj8b0A:9

The devdax driver does nothing special in its f_op->mmap hook, so
straightforwardly update it to use the mmap_prepare hook instead.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Acked-by: Pedro Falcato <pfalcato@suse.de>
---
 drivers/dax/device.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/drivers/dax/device.c b/drivers/dax/device.c
index 7f1ed0db8337..22999a402e02 100644
--- a/drivers/dax/device.c
+++ b/drivers/dax/device.c
@@ -13,8 +13,9 @@
 #include "dax-private.h"
 #include "bus.h"
 
-static int check_vma(struct dev_dax *dev_dax, struct vm_area_struct *vma,
-		const char *func)
+static int __check_vma(struct dev_dax *dev_dax, vm_flags_t vm_flags,
+		       unsigned long start, unsigned long end, struct file *file,
+		       const char *func)
 {
 	struct device *dev = &dev_dax->dev;
 	unsigned long mask;
@@ -23,7 +24,7 @@ static int check_vma(struct dev_dax *dev_dax, struct vm_area_struct *vma,
 		return -ENXIO;
 
 	/* prevent private mappings from being established */
-	if ((vma->vm_flags & VM_MAYSHARE) != VM_MAYSHARE) {
+	if ((vm_flags & VM_MAYSHARE) != VM_MAYSHARE) {
 		dev_info_ratelimited(dev,
 				"%s: %s: fail, attempted private mapping\n",
 				current->comm, func);
@@ -31,15 +32,15 @@ static int check_vma(struct dev_dax *dev_dax, struct vm_area_struct *vma,
 	}
 
 	mask = dev_dax->align - 1;
-	if (vma->vm_start & mask || vma->vm_end & mask) {
+	if (start & mask || end & mask) {
 		dev_info_ratelimited(dev,
 				"%s: %s: fail, unaligned vma (%#lx - %#lx, %#lx)\n",
-				current->comm, func, vma->vm_start, vma->vm_end,
+				current->comm, func, start, end,
 				mask);
 		return -EINVAL;
 	}
 
-	if (!vma_is_dax(vma)) {
+	if (!file_is_dax(file)) {
 		dev_info_ratelimited(dev,
 				"%s: %s: fail, vma is not DAX capable\n",
 				current->comm, func);
@@ -49,6 +50,13 @@ static int check_vma(struct dev_dax *dev_dax, struct vm_area_struct *vma,
 	return 0;
 }
 
+static int check_vma(struct dev_dax *dev_dax, struct vm_area_struct *vma,
+		     const char *func)
+{
+	return __check_vma(dev_dax, vma->vm_flags, vma->vm_start, vma->vm_end,
+			   vma->vm_file, func);
+}
+
 /* see "strong" declaration in tools/testing/nvdimm/dax-dev.c */
 __weak phys_addr_t dax_pgoff_to_phys(struct dev_dax *dev_dax, pgoff_t pgoff,
 		unsigned long size)
@@ -285,8 +293,9 @@ static const struct vm_operations_struct dax_vm_ops = {
 	.pagesize = dev_dax_pagesize,
 };
 
-static int dax_mmap(struct file *filp, struct vm_area_struct *vma)
+static int dax_mmap_prepare(struct vm_area_desc *desc)
 {
+	struct file *filp = desc->file;
 	struct dev_dax *dev_dax = filp->private_data;
 	int rc, id;
 
@@ -297,13 +306,14 @@ static int dax_mmap(struct file *filp, struct vm_area_struct *vma)
 	 * fault time.
 	 */
 	id = dax_read_lock();
-	rc = check_vma(dev_dax, vma, __func__);
+	rc = __check_vma(dev_dax, desc->vm_flags, desc->start, desc->end, filp,
+			 __func__);
 	dax_read_unlock(id);
 	if (rc)
 		return rc;
 
-	vma->vm_ops = &dax_vm_ops;
-	vm_flags_set(vma, VM_HUGEPAGE);
+	desc->vm_ops = &dax_vm_ops;
+	desc->vm_flags |= VM_HUGEPAGE;
 	return 0;
 }
 
@@ -376,7 +386,7 @@ static const struct file_operations dax_fops = {
 	.open = dax_open,
 	.release = dax_release,
 	.get_unmapped_area = dax_get_unmapped_area,
-	.mmap = dax_mmap,
+	.mmap_prepare = dax_mmap_prepare,
 	.fop_flags = FOP_MMAP_SYNC,
 };
 
-- 
2.51.0


