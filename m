Return-Path: <linux-fsdevel+bounces-64694-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A2882BF1110
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 14:15:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F371834A7E5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 12:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1610320CCA;
	Mon, 20 Oct 2025 12:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TRLmEulN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pBCu/Oml"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F043191AC;
	Mon, 20 Oct 2025 12:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760962394; cv=fail; b=igdzjSHGaKS7rWMRt/8QKS6Jpt7FSJekgkKNeEFJgwAenf+35fgnnPkkeyzNeuBjQz3wNyFdZYFPm1rqII9bcbxW3yhHfwc1dhQAoB/1yr/A+Exvzf2xxUJ3B+0L5Kna0vgsvBKNJRec204DyGyH4OmaBWHNEEM3hjFC0ZbIg7E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760962394; c=relaxed/simple;
	bh=p2FzIja8IMasX2OD2Y88XASyN4NdSerF2uLikK4oLCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KCWh+5tYURS8qso3Xavyhz9fjDGRZLaqDUQSSuNMxID0wj8ee4vXBTZAxsMuF8Au/jc5YmMVMKicm+mmMrVoq5XzX2gBbvBcK4t+8a6XxO9/lDweD6IIkO3fl1vNtxuA5OWU0Qn6Cu4bivM451cQY1ERMAa91aT7UC0xBBsyJO8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TRLmEulN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pBCu/Oml; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59K8Rmnf025514;
	Mon, 20 Oct 2025 12:12:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=3b+qaNOqkWTQbL96pGZBvJXmdmKHFQ7YqSoCfnjHVZQ=; b=
	TRLmEulNOgBzYTfT2OtYmXJ1VW0rYPF0anS6syjQ6/PhiGyXHFnGWfxbzkGP3Mbd
	y2dsx8p4fYzZmZHCFyJq+kp1Cw7SBKf/6i1bicNmHyS0U/V1lBaSjs9xK638j8Nt
	IkRlyWNd5V73hnvT9Waegw+B7VS8gJ+0H9ekdbU9Uece7iky9634t71ob4O8aey/
	yUPFrqgMuxiB0Zo6BEtGk8WoMnrg/su1D7ZyUDQK4q1tC9fKPX+1VjJje5pls2ms
	Oo6EjSpXfNZOhR/JTNQd3EhrToeEIc4O9Fek6anWinY4JRIloq1JDDB6y4oMZBXB
	Poqo83iSh/DMibKu1KeRUQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49v3esj3ga-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Oct 2025 12:12:06 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59KA1i6k032254;
	Mon, 20 Oct 2025 12:12:05 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011015.outbound.protection.outlook.com [40.107.208.15])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49v1bbmfc1-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Oct 2025 12:12:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M5UFqq+lr0TiYBgQ2bnaFN2QQn3g09LZZILn9BeU4yBlmEhZcKZFrQq9nzXerjsLz9/6vMWrRIyxzZnfMJ+t6oTy65jpV3JdH4d5dNOlUQYvsKyrk47xqwTPbWU+sNNXtmNOjMrvMPsbTsIvQg59hMu8ENq0BPT8oHdldXSchBFFiQVVyfHfONCcr1KLqTIynAYRviMux54QZQlGWYPnY678FTFhtjCtLWmhLbP/x7omggHEOtIaWkAPp7ymzLDVA9i3d8O0pb1Vb+NGWrstsMIwuxC/kuB5wT0FrWXTxBrlCNbR5eO8cwi1QWKypOQPVY3eYS6KusBGJxEfp/M65A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3b+qaNOqkWTQbL96pGZBvJXmdmKHFQ7YqSoCfnjHVZQ=;
 b=f8F2NiEmdeCeeO4mtUcus6NT379Sc4JnBFzDgZhn7E3A7ZnbibCOklKcrTloS2Ovodc69bVc/BQDaIyNXkPJfFVGirjvoEivxJEToFrJIJj3bbVYMLYu9Qj7wjjqJ4ENr26MAa3vtoTl9HM3PCEWwZA4rc9bxDW54IJne569kfBRhrmt9SqPNEnu/D0xnq98B7ywL8UwFTMRL67ywiLWQHPPpOGP9xBK51TNbDnJyz4VhlH2R437t4w4/szON4QonXDuehwwr8KtLA/XPy/KqLpzbuh8KIwzfWuuAX5YIlyZsR6DjZgHj7Qj20DtWtTHWPHNMN8oRxgWnt3rh+B+SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3b+qaNOqkWTQbL96pGZBvJXmdmKHFQ7YqSoCfnjHVZQ=;
 b=pBCu/OmlCHShYqzigT7EDDbGelfvFClvjszgPOMi3BPjct53qLYLWvI5on66amyRWFqwW/GLfJjRE9pX4+DXsdDA6F9dyTfqhOjFKD1vxS35179eLqifliqzLcQkWiFvrYdcmMS3fKrtbD+7QsU5kRPzUGC7pxdZTnyJBrFKk1I=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DM3PPF4A29B3BB2.namprd10.prod.outlook.com (2603:10b6:f:fc00::c25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Mon, 20 Oct
 2025 12:12:00 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9228.016; Mon, 20 Oct 2025
 12:12:00 +0000
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
Subject: [PATCH v5 10/15] mm: add ability to take further action in vm_area_desc
Date: Mon, 20 Oct 2025 13:11:27 +0100
Message-ID: <2601199a7b2eaeadfcd8ab6e199c6d1706650c94.1760959442.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1760959441.git.lorenzo.stoakes@oracle.com>
References: <cover.1760959441.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0267.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37c::7) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DM3PPF4A29B3BB2:EE_
X-MS-Office365-Filtering-Correlation-Id: 89e116ab-1494-46ad-a1df-08de0fd1df10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?i4AoqXUJYw8tzvlZlUttZMFba0gOIxemT47EZB+pPoyZ1tudGNVa4QnbUYbN?=
 =?us-ascii?Q?Jig95ITxuqYZ59KgDZmRfbl9BvmLiYPDeSPNFFDsfxDuREifOl9TLeR2PFXr?=
 =?us-ascii?Q?VS9ym8RglQSdF4+db48k7YGI8RlPZnrctXViAIgY9jNdkIiS7YoVSS6RGVo5?=
 =?us-ascii?Q?y61BmhaXnknteGoA2bwklZnROb1ylcwfwmOKJUb+vgu//92wFP4Gsb+ricEB?=
 =?us-ascii?Q?nrHvUxERW9fuMFjJwe/vVlAiGr9BFPn0svHOUBVMgtmT3K1Vewlg+QBq+R6c?=
 =?us-ascii?Q?KyLjTEr66hGu74yKN0lAskHZQF7uP3xI/4L+MfyjBRgIO2PxSXcTjL877Aj4?=
 =?us-ascii?Q?v9SZibNgVQE8DvCZYpctiGTyRRf9GO1cSQzXXuMAbrRrQO8x7pUzXBNuXBr6?=
 =?us-ascii?Q?5yhvE4iQJGgISjCRkaqO24f8kzis3Tji+54+5n1+58ZrW1/tPipuOH1Wkxii?=
 =?us-ascii?Q?NsAEJkDfxYbvPeG9O3h1ogFevXFuGpRzeLJiIWJqYvt+O0vv6pyY5JcdBntw?=
 =?us-ascii?Q?Dh+SPcCbfSYcNaDHE/tKCmwUVyYlyY8kqe/yPFf+2SvK5SuQ28eUXPhNs7CB?=
 =?us-ascii?Q?0zZTDU/3FV/PdDRFusspZIFEl9aaZwJnmOjDv0WdHe0E54MWn/m1okNtYNn5?=
 =?us-ascii?Q?iI9SxcXOz3OZ52ygJ/RZiyiIhrrvcE6EpqKCDq55T3vZMhDBrk+8e9BfvYir?=
 =?us-ascii?Q?QJz4Ul5kMgiIz1HcfcCBej8XDiTgW98XjVxoD0IhtqOjhr2PwvBe/2W7Duy9?=
 =?us-ascii?Q?tD/T+CQtk3fwBpKpdw2aEvZiV56mZxWOCcJt2u+8e5g/m0uybduu2Z4EXLo9?=
 =?us-ascii?Q?kpuCGTShsqCPhUga3O42/N9lh/ktyIa8QASUzkC8+ek3tuXZ3rJ7vmV7Lj3a?=
 =?us-ascii?Q?eP9ARj9toRK/JDdKn1MvQh+HnhWGnEOEs8WCpJkSwg4ApJa6S8yX6Nkud0tV?=
 =?us-ascii?Q?INgtH162jmmXzVPTmcogA+iF6NtvGL2AGLtoqyccRYeVxK6MkUN9Vt2SupM1?=
 =?us-ascii?Q?WS2clAFVm7XlvhBno++Xrem949EG594y0MqE7OXK7GgSu4Io3fBkqtIdOyRx?=
 =?us-ascii?Q?M6k6L4VrZDEzFFuNhODnkfgih/z9BKOP8gOnTHpy6xah210znEY0ZVmzD/Qq?=
 =?us-ascii?Q?ENsi05Oeoo/PFfX6Ej4D2+LkV1oxDiJMvCWxztjj9dHDbl4qF/hVT07LNlvC?=
 =?us-ascii?Q?ZC6/VRe+SleiiUBRfOc6KJSmz2guPqKzRqr0zCQOP1+w92CRdcQJR6jttya7?=
 =?us-ascii?Q?n+AJ0GNG0nUE59pMoyvd5++PABNya/K/jnBW5K3CiRv+tCWA5Wzbuwj3/Hjz?=
 =?us-ascii?Q?fT4tMKi5thZJvJO62ezeHNXoqV/m1uYsuQt8xrkCcaOi9QxkSPmOv9hu9T5Y?=
 =?us-ascii?Q?DyhLDllvloIwUh9Sprn1MaDvnUuYOa8HZSLZ9rbvoJYV6YW7bGJeGB5m97k7?=
 =?us-ascii?Q?DJMHvzO9ZK8uYsTsUkDvtS4Tbdpqc8Au?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pIajn1CU8b507XFUMaKKIFI839qLA7APXU2Z29OJeUK3//ILyra7KLY47t/F?=
 =?us-ascii?Q?ViD3BRXAzjUxD1XfswNbNnNKZy+bchYKYvIYP7TxcJRdspAhhpXRPKgsZp45?=
 =?us-ascii?Q?AkdSmNlrN65fEzqwOxM4Oo3GDdFEZPFP7fKEgkFDDSBJBPEp/oSCVscw4M04?=
 =?us-ascii?Q?3o3/F1A4vbXbwS4eqGsgs2XBTNi4hPXttKRlrH9h4tsnAffdnLMraKjDK9xc?=
 =?us-ascii?Q?HYsjNbE+/kdBYZvxMdh3j5ZO0CGPyLsl5MXCvq5aGs7jLFVAi3IInrP2y+7L?=
 =?us-ascii?Q?sud/RVeKhCFp4RajD8/h0YGNmMdmqRah/ax6HyJT9Bh4SE3nmWTBkIRT3n+I?=
 =?us-ascii?Q?heeypLOLXA2WJmo9vtczbYyoTHX4ZpHPpxgBzIT56BHEXHXktpRio3URQOAx?=
 =?us-ascii?Q?p5+ic9qhCeVsbb2pMEwYy5tBGb0ttNQg/7qF/W/gGiiJiAJb0aLJYyGGnBW0?=
 =?us-ascii?Q?yL+EOAwH4iYdLZ70Dyjr4Uc4qt31alTq0YGC11Q3ij6dwJ/lJCFmm6iK6lZ/?=
 =?us-ascii?Q?0+kpfm2fuQ92hHJCffMlkosTrhRqHP/zNAaMZQXlHfX183m1ipkdFimi/VtD?=
 =?us-ascii?Q?7Lrl4HkOJLYbT35r3Tl65mmcTguDWmOqtX1MuR7mX7o9WeXBltAJdPdkHzaS?=
 =?us-ascii?Q?ueMXIkTI64Sa3ggYaunDfl/wxBMnGn0ylbiAT9l/zC7dwRiGFbk7JyJEetru?=
 =?us-ascii?Q?Jz7P8KpNgth2LHhl8d0YcMRc5vR4ZwI/7GeRzc5GcmTErV32x6kvpaHJFirE?=
 =?us-ascii?Q?vr4p1+ekzJ0JhwFygNJ64iYarRgkRKfGRFoYgqAtRbIq5jXP3kUDyRf8XtpF?=
 =?us-ascii?Q?IirsTWO6F788Nl6G6cnsklK5qQ5yLuigQ5m+MLr31+7aunSmlJvvpk330zxl?=
 =?us-ascii?Q?yahEk+BVDHwxoariyHGce92qXUWX75MJco1/7qy1sNsWB0mOaRnYyrsdLcKR?=
 =?us-ascii?Q?mUPzNK803NuiRbUlxX9rW2xP1E+e505AUJSZT600lahhLYNPdxNwgR34WLxh?=
 =?us-ascii?Q?zvdy1NieXsGaZFOx6s0mnxM5zvM+lP+lwmKb1C++19dus6zU/O5JLVriByub?=
 =?us-ascii?Q?hJuigKBAqRK7b5irIxA4bQvzs8TGF3httg3TylYVRBfxdH3ZGIYMMoHuwVaK?=
 =?us-ascii?Q?XEpKNaCyNMO8HrqXTygFLNoUKC6+lXtgKIoD/lqKEe4hShc8183Xmf2DKoH6?=
 =?us-ascii?Q?d31UW6QPjt+1qV5xYI+wEPxlUr95jQCMue8VHgkK9Rc8ipK+VjaAkfOYtGOG?=
 =?us-ascii?Q?T61WIxBRlHWUQiNskC3huc5Dmns7jobMhxw7M198q3Aeu5lKvLV49MBy3bHh?=
 =?us-ascii?Q?kL4+soHzoM5IIJmu72dn/HFbbFHDHj/l+qdxACrlcnNzmQaZqPqJPWTM0ZGN?=
 =?us-ascii?Q?H8sWgHqMdDxqwnM9+J62WUvg/ZVtKVj8zlSu8rlB6RS+re9vlIh/1us6sfc8?=
 =?us-ascii?Q?DcpB5SbzK4mPbSdrXXLG8/kxrzy8igbzt2TRYzTJOnoC+nTzWpCtGymyPuK8?=
 =?us-ascii?Q?UFHEvCW5O5zURjc90HkKx11JgGkZ/twe6sEy6SizeiteOjQ7K94aALR9o7+W?=
 =?us-ascii?Q?Q3IIbHh0Cn3B03iU8MA3DEsn9ZTlUHKPXBwnuks7cIxjk9uUibbSD3FoMbZR?=
 =?us-ascii?Q?yQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	e7wMoNllrywknilqJQsd6yqFa0Nv2HQ6zOsZK0srFo3Q5vBmtzGTV6MT57X6UBUIjQlXXqZUQKKH85KBDcOWdIV4Np3M9Jl1di+hF2zCsI0BTBUtEWy2+GLxm4GibRdRqWqZJ8VUQnRRRubthYrLW8IN174jAwBIMdUbdPBIhuxkHvQgJT7cGbQ9KwhTVJ20DmicmZqaqNjhdl6d+zKq/yoMnd4o3W6+ZYYGreUvV9P3Mic0uN+6BdBCpMNBZ0p/gXK6o3vf8mZQVF+C1v1C6WuAHTh5/r9PNjeCenqnS2zbA1rm8msqwjD8R1SAxtsq2RxFbUQ6c/phUGOc82W72DbP45rKNAJAw9JTEPhXT1R/yUaYwjecWl2GcO3xJMaG7LgX8/ualMYDKgXio/S4EWi+uJ9IEEezdCpEeJa5nNRVnPrtQQd8YenoyjNtPHzD2u5gbfpx8fPqvLGMo0LHep08NavgbPMbm+jabcvhESlHxa1RtArrO3cbGoAtrY0yZrkqMTl6cASOAdfIWbka2ucFMWtQXILd3RRKYx69JmYZbEi4+VZfBfn6d3YHnywulqQDIK0QLXCGVhj6svJkdEAAtcV/uTO3yJJ7J2O6nxs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89e116ab-1494-46ad-a1df-08de0fd1df10
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 12:11:59.9869
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EeeDdfTseIpFa+iSyCRmQda8ts0GH2TbWNdNDgT6IA5Bnx9j2EykhZbkzeUYaBtjKdRW+is4VNs2IDvjh3Dh3rBptnyu/d3jaODyJzqe1Xc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF4A29B3BB2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 mlxscore=0 adultscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510200099
X-Authority-Analysis: v=2.4 cv=N8Mk1m9B c=1 sm=1 tr=0 ts=68f62717 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=RGuLG2NojRYl0i1ImacA:9 cc=ntf awl=host:13624
X-Proofpoint-ORIG-GUID: IaXNvJZ7qIzpij3iBghLyZtA_ZulUFtQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyNSBTYWx0ZWRfXyd15JEula3xP
 z8MVR4EfzqNVWy0DimtWo+5/Wwh5livnvr4/JVBvFbCG15IpOhg625cMNWqumDbXylQjTyzZOQz
 ULfJJKVRQeLTWXAB6mp6CnhBh6ljn8MBvkAeGbxiwt0OoA0DOe46D25gtEFY3j4UvR8iSvygSsl
 +nW8udqrFLKpiruu5C6QwEvp+z/a9c50ul7augWujzBlvDM1JehtQTNrAqRZvYBHsuGRkcEO5JJ
 tEOBGhscFdJxyw77Q+EJFUin8k5kYetHDwu9FETD4+2lTP/zOhNEowUH4Ammq8U4ZxML2PAisj/
 WF4KlFdLvmAcPFrfJIdSl5tCGzsWbxwM8g3VELdmf6zJCzmAIGC5/5QTlNkSfI35VOvr45MdDqw
 9HcU8lIB7SJMd0maePAP1JSo3oLo8gu3h0d0ic/RaUue9V9mTl0=
X-Proofpoint-GUID: IaXNvJZ7qIzpij3iBghLyZtA_ZulUFtQ

Some drivers/filesystems need to perform additional tasks after the VMA is
set up.  This is typically in the form of pre-population.

The forms of pre-population most likely to be performed are a PFN remap
or the insertion of normal folios and PFNs into a mixed map.

We start by implementing the PFN remap functionality, ensuring that we
perform the appropriate actions at the appropriate time - that is setting
flags at the point of .mmap_prepare, and performing the actual remap at the
point at which the VMA is fully established.

This prevents the driver from doing anything too crazy with a VMA at any
stage, and we retain complete control over how the mm functionality is
applied.

Unfortunately callers still do often require some kind of custom action,
so we add an optional success/error _hook to allow the caller to do
something after the action has succeeded or failed.

This is done at the point when the VMA has already been established, so
the harm that can be done is limited.

The error hook can be used to filter errors if necessary.

There may be cases in which the caller absolutely must hold the file rmap
lock until the operation is entirely complete. It is an edge case, but
certainly the hugetlbfs mmap hook requires it.

To accommodate this, we add the hide_from_rmap_until_complete flag to the
mmap_action type. In this case, if a new VMA is allocated, we will hold the
file rmap lock until the operation is entirely completed (including any
success/error hooks).

Note that we do not need to update __compat_vma_mmap() to accommodate this
flag, as this function will be invoked from an .mmap handler whose VMA is
not yet visible, so we implicitly hide it from the rmap.

If any error arises on these final actions, we simply unmap the VMA
altogether.

Also update the stacked filesystem compatibility layer to utilise the
action behaviour, and update the VMA tests accordingly.

While we're here, rename __compat_vma_mmap_prepare() to __compat_vma_mmap()
as we are now performing actions invoked by the mmap_prepare in addition to
just the mmap_prepare hook.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 include/linux/fs.h               |   6 +-
 include/linux/mm.h               |  74 ++++++++++++++++
 include/linux/mm_types.h         |  53 +++++++++++
 mm/util.c                        | 146 ++++++++++++++++++++++++++++---
 mm/vma.c                         | 113 ++++++++++++++++++------
 tools/testing/vma/vma_internal.h |  98 +++++++++++++++++++--
 6 files changed, 441 insertions(+), 49 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index c895146c1444..8cf9547a881c 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2393,14 +2393,14 @@ static inline bool can_mmap_file(struct file *file)
 	return true;
 }
 
-int __compat_vma_mmap_prepare(const struct file_operations *f_op,
+int __compat_vma_mmap(const struct file_operations *f_op,
 		struct file *file, struct vm_area_struct *vma);
-int compat_vma_mmap_prepare(struct file *file, struct vm_area_struct *vma);
+int compat_vma_mmap(struct file *file, struct vm_area_struct *vma);
 
 static inline int vfs_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	if (file->f_op->mmap_prepare)
-		return compat_vma_mmap_prepare(file, vma);
+		return compat_vma_mmap(file, vma);
 
 	return file->f_op->mmap(file, vma);
 }
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 89e77899a8ba..41e04c00891b 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3601,6 +3601,80 @@ static inline unsigned long vma_desc_pages(const struct vm_area_desc *desc)
 	return vma_desc_size(desc) >> PAGE_SHIFT;
 }
 
+/**
+ * mmap_action_remap - helper for mmap_prepare hook to specify that a pure PFN
+ * remap is required.
+ * @desc: The VMA descriptor for the VMA requiring remap.
+ * @start: The virtual address to start the remap from, must be within the VMA.
+ * @start_pfn: The first PFN in the range to remap.
+ * @size: The size of the range to remap, in bytes, at most spanning to the end
+ * of the VMA.
+ */
+static inline void mmap_action_remap(struct vm_area_desc *desc,
+				     unsigned long start,
+				     unsigned long start_pfn,
+				     unsigned long size)
+{
+	struct mmap_action *action = &desc->action;
+
+	/* [start, start + size) must be within the VMA. */
+	WARN_ON_ONCE(start < desc->start || start >= desc->end);
+	WARN_ON_ONCE(start + size > desc->end);
+
+	action->type = MMAP_REMAP_PFN;
+	action->remap.start = start;
+	action->remap.start_pfn = start_pfn;
+	action->remap.size = size;
+	action->remap.pgprot = desc->page_prot;
+}
+
+/**
+ * mmap_action_remap_full - helper for mmap_prepare hook to specify that the
+ * entirety of a VMA should be PFN remapped.
+ * @desc: The VMA descriptor for the VMA requiring remap.
+ * @start_pfn: The first PFN in the range to remap.
+ */
+static inline void mmap_action_remap_full(struct vm_area_desc *desc,
+					  unsigned long start_pfn)
+{
+	mmap_action_remap(desc, desc->start, start_pfn, vma_desc_size(desc));
+}
+
+/**
+ * mmap_action_ioremap - helper for mmap_prepare hook to specify that a pure PFN
+ * I/O remap is required.
+ * @desc: The VMA descriptor for the VMA requiring remap.
+ * @start: The virtual address to start the remap from, must be within the VMA.
+ * @start_pfn: The first PFN in the range to remap.
+ * @size: The size of the range to remap, in bytes, at most spanning to the end
+ * of the VMA.
+ */
+static inline void mmap_action_ioremap(struct vm_area_desc *desc,
+				       unsigned long start,
+				       unsigned long start_pfn,
+				       unsigned long size)
+{
+	mmap_action_remap(desc, start, start_pfn, size);
+	desc->action.type = MMAP_IO_REMAP_PFN;
+}
+
+/**
+ * mmap_action_ioremap_full - helper for mmap_prepare hook to specify that the
+ * entirety of a VMA should be PFN I/O remapped.
+ * @desc: The VMA descriptor for the VMA requiring remap.
+ * @start_pfn: The first PFN in the range to remap.
+ */
+static inline void mmap_action_ioremap_full(struct vm_area_desc *desc,
+					  unsigned long start_pfn)
+{
+	mmap_action_ioremap(desc, desc->start, start_pfn, vma_desc_size(desc));
+}
+
+void mmap_action_prepare(struct mmap_action *action,
+			 struct vm_area_desc *desc);
+int mmap_action_complete(struct mmap_action *action,
+			 struct vm_area_struct *vma);
+
 /* Look up the first VMA which exactly match the interval vm_start ... vm_end */
 static inline struct vm_area_struct *find_exact_vma(struct mm_struct *mm,
 				unsigned long vm_start, unsigned long vm_end)
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 90e5790c318f..5021047485a9 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -773,6 +773,56 @@ struct pfnmap_track_ctx {
 };
 #endif
 
+/* What action should be taken after an .mmap_prepare call is complete? */
+enum mmap_action_type {
+	MMAP_NOTHING,		/* Mapping is complete, no further action. */
+	MMAP_REMAP_PFN,		/* Remap PFN range. */
+	MMAP_IO_REMAP_PFN,	/* I/O remap PFN range. */
+};
+
+/*
+ * Describes an action an mmap_prepare hook can instruct to be taken to complete
+ * the mapping of a VMA. Specified in vm_area_desc.
+ */
+struct mmap_action {
+	union {
+		/* Remap range. */
+		struct {
+			unsigned long start;
+			unsigned long start_pfn;
+			unsigned long size;
+			pgprot_t pgprot;
+		} remap;
+	};
+	enum mmap_action_type type;
+
+	/*
+	 * If specified, this hook is invoked after the selected action has been
+	 * successfully completed. Note that the VMA write lock still held.
+	 *
+	 * The absolute minimum ought to be done here.
+	 *
+	 * Returns 0 on success, or an error code.
+	 */
+	int (*success_hook)(const struct vm_area_struct *vma);
+
+	/*
+	 * If specified, this hook is invoked when an error occurred when
+	 * attempting the selection action.
+	 *
+	 * The hook can return an error code in order to filter the error, but
+	 * it is not valid to clear the error here.
+	 */
+	int (*error_hook)(int err);
+
+	/*
+	 * This should be set in rare instances where the operation required
+	 * that the rmap should not be able to access the VMA until
+	 * completely set up.
+	 */
+	bool hide_from_rmap_until_complete :1;
+};
+
 /*
  * Describes a VMA that is about to be mmap()'ed. Drivers may choose to
  * manipulate mutable fields which will cause those fields to be updated in the
@@ -796,6 +846,9 @@ struct vm_area_desc {
 	/* Write-only fields. */
 	const struct vm_operations_struct *vm_ops;
 	void *private_data;
+
+	/* Take further action? */
+	struct mmap_action action;
 };
 
 /*
diff --git a/mm/util.c b/mm/util.c
index 8989d5767528..97cae40c0209 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -1135,7 +1135,7 @@ EXPORT_SYMBOL(flush_dcache_folio);
 #endif
 
 /**
- * __compat_vma_mmap_prepare() - See description for compat_vma_mmap_prepare()
+ * __compat_vma_mmap() - See description for compat_vma_mmap()
  * for details. This is the same operation, only with a specific file operations
  * struct which may or may not be the same as vma->vm_file->f_op.
  * @f_op: The file operations whose .mmap_prepare() hook is specified.
@@ -1143,7 +1143,7 @@ EXPORT_SYMBOL(flush_dcache_folio);
  * @vma: The VMA to apply the .mmap_prepare() hook to.
  * Returns: 0 on success or error.
  */
-int __compat_vma_mmap_prepare(const struct file_operations *f_op,
+int __compat_vma_mmap(const struct file_operations *f_op,
 		struct file *file, struct vm_area_struct *vma)
 {
 	struct vm_area_desc desc = {
@@ -1156,21 +1156,24 @@ int __compat_vma_mmap_prepare(const struct file_operations *f_op,
 		.vm_file = vma->vm_file,
 		.vm_flags = vma->vm_flags,
 		.page_prot = vma->vm_page_prot,
+
+		.action.type = MMAP_NOTHING, /* Default */
 	};
 	int err;
 
 	err = f_op->mmap_prepare(&desc);
 	if (err)
 		return err;
-	set_vma_from_desc(vma, &desc);
 
-	return 0;
+	mmap_action_prepare(&desc.action, &desc);
+	set_vma_from_desc(vma, &desc);
+	return mmap_action_complete(&desc.action, vma);
 }
-EXPORT_SYMBOL(__compat_vma_mmap_prepare);
+EXPORT_SYMBOL(__compat_vma_mmap);
 
 /**
- * compat_vma_mmap_prepare() - Apply the file's .mmap_prepare() hook to an
- * existing VMA.
+ * compat_vma_mmap() - Apply the file's .mmap_prepare() hook to an
+ * existing VMA and execute any requested actions.
  * @file: The file which possesss an f_op->mmap_prepare() hook.
  * @vma: The VMA to apply the .mmap_prepare() hook to.
  *
@@ -1185,7 +1188,7 @@ EXPORT_SYMBOL(__compat_vma_mmap_prepare);
  * .mmap_prepare() hook, as we are in a different context when we invoke the
  * .mmap() hook, already having a VMA to deal with.
  *
- * compat_vma_mmap_prepare() is a compatibility function that takes VMA state,
+ * compat_vma_mmap() is a compatibility function that takes VMA state,
  * establishes a struct vm_area_desc descriptor, passes to the underlying
  * .mmap_prepare() hook and applies any changes performed by it.
  *
@@ -1194,11 +1197,11 @@ EXPORT_SYMBOL(__compat_vma_mmap_prepare);
  *
  * Returns: 0 on success or error.
  */
-int compat_vma_mmap_prepare(struct file *file, struct vm_area_struct *vma)
+int compat_vma_mmap(struct file *file, struct vm_area_struct *vma)
 {
-	return __compat_vma_mmap_prepare(file->f_op, file, vma);
+	return __compat_vma_mmap(file->f_op, file, vma);
 }
-EXPORT_SYMBOL(compat_vma_mmap_prepare);
+EXPORT_SYMBOL(compat_vma_mmap);
 
 static void set_ps_flags(struct page_snapshot *ps, const struct folio *folio,
 			 const struct page *page)
@@ -1280,6 +1283,127 @@ void snapshot_page(struct page_snapshot *ps, const struct page *page)
 	}
 }
 
+static int mmap_action_finish(struct mmap_action *action,
+		const struct vm_area_struct *vma, int err)
+{
+	/*
+	 * If an error occurs, unmap the VMA altogether and return an error. We
+	 * only clear the newly allocated VMA, since this function is only
+	 * invoked if we do NOT merge, so we only clean up the VMA we created.
+	 */
+	if (err) {
+		const size_t len = vma_pages(vma) << PAGE_SHIFT;
+
+		do_munmap(current->mm, vma->vm_start, len, NULL);
+
+		if (action->error_hook) {
+			/* We may want to filter the error. */
+			err = action->error_hook(err);
+
+			/* The caller should not clear the error. */
+			VM_WARN_ON_ONCE(!err);
+		}
+		return err;
+	}
+
+	if (action->success_hook)
+		return action->success_hook(vma);
+
+	return 0;
+}
+
+#ifdef CONFIG_MMU
+/**
+ * mmap_action_prepare - Perform preparatory setup for an VMA descriptor
+ * action which need to be performed.
+ * @desc: The VMA descriptor to prepare for @action.
+ * @action: The action to perform.
+ */
+void mmap_action_prepare(struct mmap_action *action,
+			 struct vm_area_desc *desc)
+{
+	switch (action->type) {
+	case MMAP_NOTHING:
+		break;
+	case MMAP_REMAP_PFN:
+		remap_pfn_range_prepare(desc, action->remap.start_pfn);
+		break;
+	case MMAP_IO_REMAP_PFN:
+		io_remap_pfn_range_prepare(desc, action->remap.start_pfn,
+					   action->remap.size);
+		break;
+	}
+}
+EXPORT_SYMBOL(mmap_action_prepare);
+
+/**
+ * mmap_action_complete - Execute VMA descriptor action.
+ * @action: The action to perform.
+ * @vma: The VMA to perform the action upon.
+ *
+ * Similar to mmap_action_prepare().
+ *
+ * Return: 0 on success, or error, at which point the VMA will be unmapped.
+ */
+int mmap_action_complete(struct mmap_action *action,
+			 struct vm_area_struct *vma)
+{
+	int err = 0;
+
+	switch (action->type) {
+	case MMAP_NOTHING:
+		break;
+	case MMAP_REMAP_PFN:
+		err = remap_pfn_range_complete(vma, action->remap.start,
+				action->remap.start_pfn, action->remap.size,
+				action->remap.pgprot);
+		break;
+	case MMAP_IO_REMAP_PFN:
+		err = io_remap_pfn_range_complete(vma, action->remap.start,
+				action->remap.start_pfn, action->remap.size,
+				action->remap.pgprot);
+		break;
+	}
+
+	return mmap_action_finish(action, vma, err);
+}
+EXPORT_SYMBOL(mmap_action_complete);
+#else
+void mmap_action_prepare(struct mmap_action *action,
+			struct vm_area_desc *desc)
+{
+	switch (action->type) {
+	case MMAP_NOTHING:
+		break;
+	case MMAP_REMAP_PFN:
+	case MMAP_IO_REMAP_PFN:
+		WARN_ON_ONCE(1); /* nommu cannot handle these. */
+		break;
+	}
+}
+EXPORT_SYMBOL(mmap_action_prepare);
+
+int mmap_action_complete(struct mmap_action *action,
+			struct vm_area_struct *vma)
+{
+	int err = 0;
+
+	switch (action->type) {
+	case MMAP_NOTHING:
+		break;
+	case MMAP_REMAP_PFN:
+	case MMAP_IO_REMAP_PFN:
+		WARN_ON_ONCE(1); /* nommu cannot handle this. */
+
+		err = -EINVAL;
+		break;
+	}
+
+	return mmap_action_finish(action, vma, err);
+}
+EXPORT_SYMBOL(mmap_action_complete);
+#endif
+
 #ifdef CONFIG_MMU
 /**
  * folio_pte_batch - detect a PTE batch for a large folio
diff --git a/mm/vma.c b/mm/vma.c
index eb2f711c03a1..919d1fc63a52 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -34,7 +34,9 @@ struct mmap_state {
 	struct maple_tree mt_detach;
 
 	/* Determine if we can check KSM flags early in mmap() logic. */
-	bool check_ksm_early;
+	bool check_ksm_early :1;
+	/* If we map new, hold the file rmap lock on mapping. */
+	bool hold_file_rmap_lock :1;
 };
 
 #define MMAP_STATE(name, mm_, vmi_, addr_, len_, pgoff_, vm_flags_, file_) \
@@ -1754,7 +1756,7 @@ void unlink_file_vma_batch_final(struct unlink_vma_file_batch *vb)
 		unlink_file_vma_batch_process(vb);
 }
 
-static void vma_link_file(struct vm_area_struct *vma)
+static void vma_link_file(struct vm_area_struct *vma, bool hold_rmap_lock)
 {
 	struct file *file = vma->vm_file;
 	struct address_space *mapping;
@@ -1763,7 +1765,8 @@ static void vma_link_file(struct vm_area_struct *vma)
 		mapping = file->f_mapping;
 		i_mmap_lock_write(mapping);
 		__vma_link_file(vma, mapping);
-		i_mmap_unlock_write(mapping);
+		if (!hold_rmap_lock)
+			i_mmap_unlock_write(mapping);
 	}
 }
 
@@ -1777,7 +1780,7 @@ static int vma_link(struct mm_struct *mm, struct vm_area_struct *vma)
 
 	vma_start_write(vma);
 	vma_iter_store_new(&vmi, vma);
-	vma_link_file(vma);
+	vma_link_file(vma, /* hold_rmap_lock= */false);
 	mm->map_count++;
 	validate_mm(mm);
 	return 0;
@@ -2311,17 +2314,33 @@ static void update_ksm_flags(struct mmap_state *map)
 	map->vm_flags = ksm_vma_flags(map->mm, map->file, map->vm_flags);
 }
 
+static void set_desc_from_map(struct vm_area_desc *desc,
+		const struct mmap_state *map)
+{
+	desc->start = map->addr;
+	desc->end = map->end;
+
+	desc->pgoff = map->pgoff;
+	desc->vm_file = map->file;
+	desc->vm_flags = map->vm_flags;
+	desc->page_prot = map->page_prot;
+}
+
 /*
  * __mmap_setup() - Prepare to gather any overlapping VMAs that need to be
  * unmapped once the map operation is completed, check limits, account mapping
  * and clean up any pre-existing VMAs.
  *
+ * As a result it sets up the @map and @desc objects.
+ *
  * @map: Mapping state.
+ * @desc: VMA descriptor
  * @uf:  Userfaultfd context list.
  *
  * Returns: 0 on success, error code otherwise.
  */
-static int __mmap_setup(struct mmap_state *map, struct list_head *uf)
+static int __mmap_setup(struct mmap_state *map, struct vm_area_desc *desc,
+			struct list_head *uf)
 {
 	int error;
 	struct vma_iterator *vmi = map->vmi;
@@ -2378,6 +2397,7 @@ static int __mmap_setup(struct mmap_state *map, struct list_head *uf)
 	 */
 	vms_clean_up_area(vms, &map->mas_detach);
 
+	set_desc_from_map(desc, map);
 	return 0;
 }
 
@@ -2479,7 +2499,7 @@ static int __mmap_new_vma(struct mmap_state *map, struct vm_area_struct **vmap)
 	vma_start_write(vma);
 	vma_iter_store_new(vmi, vma);
 	map->mm->map_count++;
-	vma_link_file(vma);
+	vma_link_file(vma, map->hold_file_rmap_lock);
 
 	/*
 	 * vma_merge_new_range() calls khugepaged_enter_vma() too, the below
@@ -2539,6 +2559,17 @@ static void __mmap_complete(struct mmap_state *map, struct vm_area_struct *vma)
 	vma_set_page_prot(vma);
 }
 
+static void call_action_prepare(struct mmap_state *map,
+				struct vm_area_desc *desc)
+{
+	struct mmap_action *action = &desc->action;
+
+	mmap_action_prepare(action, desc);
+
+	if (action->hide_from_rmap_until_complete)
+		map->hold_file_rmap_lock = true;
+}
+
 /*
  * Invoke the f_op->mmap_prepare() callback for a file-backed mapping that
  * specifies it.
@@ -2550,34 +2581,26 @@ static void __mmap_complete(struct mmap_state *map, struct vm_area_struct *vma)
  *
  * Returns 0 on success, or an error code otherwise.
  */
-static int call_mmap_prepare(struct mmap_state *map)
+static int call_mmap_prepare(struct mmap_state *map,
+		struct vm_area_desc *desc)
 {
 	int err;
-	struct vm_area_desc desc = {
-		.mm = map->mm,
-		.file = map->file,
-		.start = map->addr,
-		.end = map->end,
-
-		.pgoff = map->pgoff,
-		.vm_file = map->file,
-		.vm_flags = map->vm_flags,
-		.page_prot = map->page_prot,
-	};
 
 	/* Invoke the hook. */
-	err = vfs_mmap_prepare(map->file, &desc);
+	err = vfs_mmap_prepare(map->file, desc);
 	if (err)
 		return err;
 
+	call_action_prepare(map, desc);
+
 	/* Update fields permitted to be changed. */
-	map->pgoff = desc.pgoff;
-	map->file = desc.vm_file;
-	map->vm_flags = desc.vm_flags;
-	map->page_prot = desc.page_prot;
+	map->pgoff = desc->pgoff;
+	map->file = desc->vm_file;
+	map->vm_flags = desc->vm_flags;
+	map->page_prot = desc->page_prot;
 	/* User-defined fields. */
-	map->vm_ops = desc.vm_ops;
-	map->vm_private_data = desc.private_data;
+	map->vm_ops = desc->vm_ops;
+	map->vm_private_data = desc->private_data;
 
 	return 0;
 }
@@ -2619,22 +2642,48 @@ static bool can_set_ksm_flags_early(struct mmap_state *map)
 	return false;
 }
 
+static int call_action_complete(struct mmap_state *map,
+				struct vm_area_desc *desc,
+				struct vm_area_struct *vma)
+{
+	struct mmap_action *action = &desc->action;
+	int ret;
+
+	ret = mmap_action_complete(action, vma);
+
+	/* If we held the file rmap we need to release it. */
+	if (map->hold_file_rmap_lock) {
+		struct file *file = vma->vm_file;
+
+		i_mmap_unlock_write(file->f_mapping);
+	}
+	return ret;
+}
+
 static unsigned long __mmap_region(struct file *file, unsigned long addr,
 		unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
 		struct list_head *uf)
 {
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma = NULL;
-	int error;
 	bool have_mmap_prepare = file && file->f_op->mmap_prepare;
 	VMA_ITERATOR(vmi, mm, addr);
 	MMAP_STATE(map, mm, &vmi, addr, len, pgoff, vm_flags, file);
+	struct vm_area_desc desc = {
+		.mm = mm,
+		.file = file,
+		.action = {
+			.type = MMAP_NOTHING, /* Default to no further action. */
+		},
+	};
+	bool allocated_new = false;
+	int error;
 
 	map.check_ksm_early = can_set_ksm_flags_early(&map);
 
-	error = __mmap_setup(&map, uf);
+	error = __mmap_setup(&map, &desc, uf);
 	if (!error && have_mmap_prepare)
-		error = call_mmap_prepare(&map);
+		error = call_mmap_prepare(&map, &desc);
 	if (error)
 		goto abort_munmap;
 
@@ -2653,6 +2702,7 @@ static unsigned long __mmap_region(struct file *file, unsigned long addr,
 		error = __mmap_new_vma(&map, &vma);
 		if (error)
 			goto unacct_error;
+		allocated_new = true;
 	}
 
 	if (have_mmap_prepare)
@@ -2660,6 +2710,13 @@ static unsigned long __mmap_region(struct file *file, unsigned long addr,
 
 	__mmap_complete(&map, vma);
 
+	if (have_mmap_prepare && allocated_new) {
+		error = call_action_complete(&map, &desc, vma);
+
+		if (error)
+			return error;
+	}
+
 	return addr;
 
 	/* Accounting was done by __mmap_setup(). */
diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
index dc976a285ad2..d873667704e8 100644
--- a/tools/testing/vma/vma_internal.h
+++ b/tools/testing/vma/vma_internal.h
@@ -275,6 +275,57 @@ struct mm_struct {
 
 struct vm_area_struct;
 
+
+/* What action should be taken after an .mmap_prepare call is complete? */
+enum mmap_action_type {
+	MMAP_NOTHING,		/* Mapping is complete, no further action. */
+	MMAP_REMAP_PFN,		/* Remap PFN range. */
+	MMAP_IO_REMAP_PFN,	/* I/O remap PFN range. */
+};
+
+/*
+ * Describes an action an mmap_prepare hook can instruct to be taken to complete
+ * the mapping of a VMA. Specified in vm_area_desc.
+ */
+struct mmap_action {
+	union {
+		/* Remap range. */
+		struct {
+			unsigned long start;
+			unsigned long start_pfn;
+			unsigned long size;
+			pgprot_t pgprot;
+		} remap;
+	};
+	enum mmap_action_type type;
+
+	/*
+	 * If specified, this hook is invoked after the selected action has been
+	 * successfully completed. Note that the VMA write lock still held.
+	 *
+	 * The absolute minimum ought to be done here.
+	 *
+	 * Returns 0 on success, or an error code.
+	 */
+	int (*success_hook)(const struct vm_area_struct *vma);
+
+	/*
+	 * If specified, this hook is invoked when an error occurred when
+	 * attempting the selection action.
+	 *
+	 * The hook can return an error code in order to filter the error, but
+	 * it is not valid to clear the error here.
+	 */
+	int (*error_hook)(int err);
+
+	/*
+	 * This should be set in rare instances where the operation required
+	 * that the rmap should not be able to access the VMA until
+	 * completely set up.
+	 */
+	bool hide_from_rmap_until_complete :1;
+};
+
 /*
  * Describes a VMA that is about to be mmap()'ed. Drivers may choose to
  * manipulate mutable fields which will cause those fields to be updated in the
@@ -298,6 +349,9 @@ struct vm_area_desc {
 	/* Write-only fields. */
 	const struct vm_operations_struct *vm_ops;
 	void *private_data;
+
+	/* Take further action? */
+	struct mmap_action action;
 };
 
 struct file_operations {
@@ -1326,12 +1380,23 @@ static inline void free_anon_vma_name(struct vm_area_struct *vma)
 static inline void set_vma_from_desc(struct vm_area_struct *vma,
 		struct vm_area_desc *desc);
 
-static inline int __compat_vma_mmap_prepare(const struct file_operations *f_op,
+static inline void mmap_action_prepare(struct mmap_action *action,
+					   struct vm_area_desc *desc)
+{
+}
+
+static inline int mmap_action_complete(struct mmap_action *action,
+					   struct vm_area_struct *vma)
+{
+	return 0;
+}
+
+static inline int __compat_vma_mmap(const struct file_operations *f_op,
 		struct file *file, struct vm_area_struct *vma)
 {
 	struct vm_area_desc desc = {
 		.mm = vma->vm_mm,
-		.file = vma->vm_file,
+		.file = file,
 		.start = vma->vm_start,
 		.end = vma->vm_end,
 
@@ -1339,21 +1404,24 @@ static inline int __compat_vma_mmap_prepare(const struct file_operations *f_op,
 		.vm_file = vma->vm_file,
 		.vm_flags = vma->vm_flags,
 		.page_prot = vma->vm_page_prot,
+
+		.action.type = MMAP_NOTHING, /* Default */
 	};
 	int err;
 
 	err = f_op->mmap_prepare(&desc);
 	if (err)
 		return err;
-	set_vma_from_desc(vma, &desc);
 
-	return 0;
+	mmap_action_prepare(&desc.action, &desc);
+	set_vma_from_desc(vma, &desc);
+	return mmap_action_complete(&desc.action, vma);
 }
 
-static inline int compat_vma_mmap_prepare(struct file *file,
+static inline int compat_vma_mmap(struct file *file,
 		struct vm_area_struct *vma)
 {
-	return __compat_vma_mmap_prepare(file->f_op, file, vma);
+	return __compat_vma_mmap(file->f_op, file, vma);
 }
 
 /* Did the driver provide valid mmap hook configuration? */
@@ -1374,7 +1442,7 @@ static inline bool can_mmap_file(struct file *file)
 static inline int vfs_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	if (file->f_op->mmap_prepare)
-		return compat_vma_mmap_prepare(file, vma);
+		return compat_vma_mmap(file, vma);
 
 	return file->f_op->mmap(file, vma);
 }
@@ -1407,4 +1475,20 @@ static inline vm_flags_t ksm_vma_flags(const struct mm_struct *mm,
 	return vm_flags;
 }
 
+static inline void remap_pfn_range_prepare(struct vm_area_desc *desc, unsigned long pfn)
+{
+}
+
+static inline int remap_pfn_range_complete(struct vm_area_struct *vma, unsigned long addr,
+		unsigned long pfn, unsigned long size, pgprot_t pgprot)
+{
+	return 0;
+}
+
+static inline int do_munmap(struct mm_struct *, unsigned long, size_t,
+		struct list_head *uf)
+{
+	return 0;
+}
+
 #endif	/* __MM_VMA_INTERNAL_H */
-- 
2.51.0


