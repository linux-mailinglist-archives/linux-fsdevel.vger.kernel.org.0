Return-Path: <linux-fsdevel+bounces-60499-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD89B48B59
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 13:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D2B0189BC61
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 11:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B422FB0BF;
	Mon,  8 Sep 2025 11:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pTWjqNgl";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="e1AzVsJt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7C42FAC09;
	Mon,  8 Sep 2025 11:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757329918; cv=fail; b=kAvAL3neR2W4+uOV8yc9vrUNyjq2/tKUKA+1yW7H9dF+LRqReB4T9AATZpgnPuqKbcrndTHp6r+sXZ1b05AZ2vxyl2Mxi1fMnuL6UGq6ComA7f1cXyZhNbJ1m7onIFsZAIPUKuAONxQ+IULG43Jc0mUhhfUISmsyNmRmpCE1QXg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757329918; c=relaxed/simple;
	bh=ZlUtdYAF+ZnmoqxPK7rGYj0njnwXbMri69ZNafrs6sM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S4Q1j+hL0NBhI9Rt0/69ZSJGF+yacr7T4pDJ0a+3+19/aewzvnZwlKSRn2UGmd2BJRED7TJVPxRecWETKWd+fbA9+hMmWMggyGrPAWWrlWbuyug7tHnuEm5N1ojqlAJslMfDJ6b8cofpbYCqjHkhusG7unRng26Vsu3ca8q8HV8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=pTWjqNgl; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=e1AzVsJt; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 588AnmpV003050;
	Mon, 8 Sep 2025 11:11:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=nxkWlLtokqabHXHmPgkp4TNnmeCCeD6Mtfl16z2oXcc=; b=
	pTWjqNglTCTy7j/M0BMReHiExAwTMq/BUjraeXmurBCCEFUfP2AD0A8kZ64AMoJj
	+SVHiW8aUqjQPyrCb73ohyiv5vla1RrnMOt1AqMhCmU5lkJB/fc6dMXQT4ao5lYr
	MRUbic3R709UBmn4h0Pz5l4A6jMfnQHBioSfOhoI+GyChp9qIGqKzmK//eyGuxkc
	58i++N6SflsCaYqEillTQiJvoYM4TePItB/SIgB3pk7K5dawdxUBxO9wkVeeL8Y7
	P6ZQRWjwAYZFTv0SsD7ieXeFRctUKNfZfIt3cZlIU3UHiFBzxrr4XJf19+j5fphd
	8TilnmD+aHdnX5YV0ZyE2g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 491wqug0y7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Sep 2025 11:11:05 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5889pgY1033216;
	Mon, 8 Sep 2025 11:11:04 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 490bd91qp6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Sep 2025 11:11:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cfgo9grdJ7Fl4noiOGY1Qf2JzdpQtR62DxvMOdHmLJGoRS+KWXmKUx7Vwgozg/WC/D7Qw3mijNCzBOy/15OUrSsrdnWyLVl3Qo3Re4Yb2s0772rSJyWJPE4mR9geigT8PX7zczt029hmkOoOXrbnbGg52x/QamrztZfgnyK53X2xKrHzI8h1g1nZ+HK4kIohu2webg6k37Zxhf4+RY+JtpG3wodejrmS3o1WuHVEEhlry6Hz/Pnekqk9NFMwb0EH0g1LkSxscZJhBiNzPOkBxOKrd0a4PRU5AGmyma04eyimR79CqZNYoQrschRWf11Oy+CZqCHkvZdGwbechy/mgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nxkWlLtokqabHXHmPgkp4TNnmeCCeD6Mtfl16z2oXcc=;
 b=iPSl/QtqFakGlWViy5y2iKrbmvimr86G51HOL8ow6ZAf7YzlQitGfLU8UsV9ue7nECbWuK1k2QEqomLT3Fn5e9qND0sJPyQ2E++S0J1lM0s62NLjSTQuLivzFKJGVDZxaTWhV7Z9RLN5Yo3fKX9BpN+/eSh+qFWe6Ly2np9rLTflMFMhTrE47BW2BiTls+UE4NubHLVMLTxak8ddYd+rfL2onltcDVahZEEbQIWTpj76zHX9+m7xvUqDCa0HvRTE9fEEsPh4gHTpvmjp9GVhCrmx0j32bV7qxlP9ftrTpDCwl2PlD3VtgS/WaFYiXK1TuXIGez/VKJeF8DmrMDk8Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nxkWlLtokqabHXHmPgkp4TNnmeCCeD6Mtfl16z2oXcc=;
 b=e1AzVsJt+0dOed4WAXOvEIVD09BY4AjbutrbLBAowineErab/VUawQW9NLY1cSZ7WRGYx8w5Jnn7YQwhjXjlR1JqO2fUae6YbTrbPYdoXhriCbY1RQqtoF7remh/JD3hw3zLTWIF71k08FR+yK1AwvjU7rmaEw3oCB9DXlgzGH8=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS7PR10MB7155.namprd10.prod.outlook.com (2603:10b6:8:e0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 11:11:00 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9094.018; Mon, 8 Sep 2025
 11:11:00 +0000
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
Subject: [PATCH 01/16] mm/shmem: update shmem to use mmap_prepare
Date: Mon,  8 Sep 2025 12:10:32 +0100
Message-ID: <2f84230f9087db1c62860c1a03a90416b8d7742e.1757329751.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1757329751.git.lorenzo.stoakes@oracle.com>
References: <cover.1757329751.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3PEPF00002E6C.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::3a) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS7PR10MB7155:EE_
X-MS-Office365-Filtering-Correlation-Id: ccf6c11b-ef4b-4c70-d1f0-08ddeec86458
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BR7ynvARSQMr1+FUu3jrob4/k1ne7Q5d1qYvOac3Zy45BbVlmfASMuLMULB6?=
 =?us-ascii?Q?jEPmF01wvkNyKCD2lCF5vGbsPgYfihivi+0+4LAFEQlZFslvpdhf/eAncS6N?=
 =?us-ascii?Q?JS6ydfJgIeulxaQfhaAFk2+miiBkEnY5y4ypGu02r1DBtPk/6+EhxvefhDdd?=
 =?us-ascii?Q?/gvfjkNpy73DQKGQKywtCPO4eqa0/jy1D8sMJE2wyQ0VuqrXo4reoXnejWY4?=
 =?us-ascii?Q?3bzBYf5eohKgLvliPOzeKQga962PQnfwJdf331PknEHyVu/ZL0vaElZ8ZWvJ?=
 =?us-ascii?Q?9NIr1JyBGSswAT8si9T2K13wuUJrWqFs8OeQle6BKnTGtkIM60I3Lus6eIoN?=
 =?us-ascii?Q?GAEcXLw/9Qi38ikImPvJcHowhkkQtaoMmf7SgKo/tq3pEO2MxPM9qoeqpCqh?=
 =?us-ascii?Q?evrw75YWwzQTMOutX/2cfJywvtF4cZ3N1twvMX+P4r/i3/zb4x6b0C/c+ONA?=
 =?us-ascii?Q?drhMGgFHZvJqrQd7J1GuDhhJLJmqqqq21pifDQDkOHmJqdnT5VvTLgRIcmAe?=
 =?us-ascii?Q?LyFWxhlfe38R+BbbepA6KQAE4Qm90Uml8XAy0ItxaT/HYk5+mPRwGIkthqds?=
 =?us-ascii?Q?Si7A9w+YDqyaykPHCVkLE6ZTmk++xnxDRWGJ9uHrnSBzhICLKvXNNPMWruav?=
 =?us-ascii?Q?irA9+4gmD0v9CiUEei231wzjao1xCpU/7o+jnEXIZpVRcEUE56mj+NupFiLv?=
 =?us-ascii?Q?yusI/hk0UTBwYxrJ5YY2lXftjiKKKU968VyNFw8N+r9uXE1yNmtgCAYEBMY3?=
 =?us-ascii?Q?fjUriEa3BwsMVy9tAGpLTX8mp7pQg7QWpTNnmbLUSVOjXz5jW5ki1y4+fklV?=
 =?us-ascii?Q?0rYUdYrtcRNH/RZvm3v1IFsR2E0vDDUrbbJAQJEyO77erpxUjx/Y2Te1Gtpj?=
 =?us-ascii?Q?qiv+t0qQ2a3aUQ5f0Y+X4KYbyb7RSOGK/2IEt23CM9uE+4jCF8VkYOUWFgsB?=
 =?us-ascii?Q?zhvDfkG2EsOZelaWaDNcIMsWtViG0UNf7AKX9DCuHSC3Uv83j8cDG94/E+WA?=
 =?us-ascii?Q?wp16JVjRykP5yJhMnzzC2V3uSd1lSLVboIqjdxXMDggTTZOJyrjPC5G8Vt0H?=
 =?us-ascii?Q?7E/Djan4bX+o8JGsO3kNuJ+RVYga3anj0BV6iZwjaigdw9RVyW94HLca8Mec?=
 =?us-ascii?Q?5hbyqa5YGvb2EztGNhesuH6gOhpnI+vvaWVNSR2nnNeB9hF1SiOISeBlJMnB?=
 =?us-ascii?Q?Qa+8EhCaCAbIVpScgMbH50U3ZTOUBOAWnSuiE/9icZ1ADEJvrJIsvVYRCfFl?=
 =?us-ascii?Q?op4BVXTZpZodiMaucc6PSlXU+BVh+8Xv8+FnikvFoLxOLsKAKxo5IppY14r1?=
 =?us-ascii?Q?aOGtvQoy1skP0iTJY0jtByu5g4W6yw2zdpN5LkoGvtk8tCSFCmoMOkHFEzlZ?=
 =?us-ascii?Q?LVdukttSxRGgkCgxcfpWz7tWand60cx+hcBtxqeF4ASbslCHgcJWMvIxgZiD?=
 =?us-ascii?Q?/SDgJ0ciqWo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Pja1TxKi7l6ZSWS4o7vPyxg5weYKmbz/b8u4IuWoOgBqlKzXB/qhD3tBWT4Y?=
 =?us-ascii?Q?lanQVFQABnTqh4rED3gT6z6xVIvkQjR1JPMmqT/06UllNvXrS458VkCQBwnp?=
 =?us-ascii?Q?Bb5N2TfuRxFi/CFmZbShC/IdHm8lPLSax9BAqJPkTelMcPsVJTefoNeBOaT2?=
 =?us-ascii?Q?5ab3E817FWfwXSxUduJYHIvb2CY0YBZMxAYM2kcHWrIPtq6Q++sK4nPquGNM?=
 =?us-ascii?Q?+2vH3Jm66pEKdRVYtIoVCNVekFD8jBea6Xe3CU1x7ya6rpKpVOzanj3ae0cp?=
 =?us-ascii?Q?iM2RtxSY/T4h+61kAwsXCqP7hz93KVE+wgDVmd3QkxRFtCEnmgrsFXuBquaN?=
 =?us-ascii?Q?ztZ92K9yDGIWBPafEUNizRDLmhaDpvI4EaYCKR4JnSUp6ObQMsCPSSb3OcR9?=
 =?us-ascii?Q?BRoaOUCeyZ/elQUvi5FQIlMTt22AEP5TWUUIJx06KR5QKQ5kqg/J6cB4VuVb?=
 =?us-ascii?Q?bcALeMwKLfekBb+w3fnOyYAB4AA4jwaJkoCpyAZ1EML5Wwk2ZSopUn+QSW7T?=
 =?us-ascii?Q?krwYyaXTwkxbzfC6PxMpo4RbP/NGDLtQKdo9VX8xG3oEv+6whzjWi7+9yK9/?=
 =?us-ascii?Q?kSdWoI8Q50a1nZ+VIlATMaPlWjqLqlHidf7ajeNUu84fUFZ+gymqPjCbZVoR?=
 =?us-ascii?Q?cXAwBATHusgDRWhsjVu+tL2ZESzCcxGuf04rhnmYlH4CeCEvffi24PQNfjxp?=
 =?us-ascii?Q?6JPLTJVRX6wD+6v8aq4cpYjOY4/dK7Mj5VU2kgp0FkKLWL/w1ZViQSmI7O1s?=
 =?us-ascii?Q?tpty5bS1JAZ+qp1Yv6uthCa9b3Xu/KVjTV64mOagTfIoNp52ud+YyovNGNxJ?=
 =?us-ascii?Q?LX+wdlvJsrfPBfx8jImXmSFEN0KALAtvX3bHyTDwdrW1lqU3ZMQKs+8YfPSe?=
 =?us-ascii?Q?jmCbiGCauCcEdFsXrQ5qBJK68VQIujd7YFN0rwO69iq2ArNczwKmJqsonylk?=
 =?us-ascii?Q?UIA3W1/gVWSBxAhx4ZRDFLTbWUCQ8A3yHOj34IOdNvgTM0rzs0lJR96CIj0p?=
 =?us-ascii?Q?IKpBiHOIyovhvl8FJ2uOT8GsKLb9b9EVd1HabkQAenZOYSNr3AvG7mXWB8xO?=
 =?us-ascii?Q?ulnRM+8ibj3GAX6hPa134qHhjvPfHwfnT837czi8f2BsdB5DldLyU+LmWLXq?=
 =?us-ascii?Q?QicgoUNcK+lVGtL1MVODCD/uY5i80oeYm7qJiA6bcBpPpNWrbKE267y3Xmas?=
 =?us-ascii?Q?j/YnPnBJM5HiR1zAxtDXqSrCHDrDjM8BjAlfKzKlCSz+l4Q4+Ve3ShzvPTCU?=
 =?us-ascii?Q?NJ0D3Em5VlRS6XkDJbiYYRbo+EZCnfyvoG0OnztrssoBfkzZHMiJUh/PhXWv?=
 =?us-ascii?Q?AJD4eJF1oeTIzUt1het1zaN8IXj8pvX0+MBMaGonuFnuozFXdnYZWJqM20OA?=
 =?us-ascii?Q?t1Rysf6VTRMKfbMSOoyzkM+XSiakvE9ojV/LvPI/bRBdQqu+Qpwhy23Lh4Qx?=
 =?us-ascii?Q?mwHnJ60YuzUYCCgZgZLFZvp+mHeJdblivWvIzd3jsVLiHvQq78L1iA/pt3Yf?=
 =?us-ascii?Q?pi7WblDNhaFssno1QkM6Wbtp0brapbdZ4JyDjy0U2uBf7hUkLvqOalALQf0N?=
 =?us-ascii?Q?TYVhZx3/v12+1EDGVjItiT2TrvOlAruCaXrvrAVs0cTIxtSFVOpyYKPyBHRs?=
 =?us-ascii?Q?Kw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	THxy0ycnOeEkIJeyRaJNGlYvg6iTHobA6f3is7vtimPZv6yt67XYizRB11Y0NfvFn4aQw7U2YWzKRSiNuUUvSt5w7ot+YjpE0TIPf9oZqtKdjfRDEPQr+F3n6pPs73w3CHPl9RRdpnD1/B6GjMs1mL/yFTB+nfEGlK0KAzE9DS8l4jV8PLncGwHAdd8H7tOutmD0rFiUCuQlLlCPZgqswzFQYY6lMkmUk1+c0v3qtlKuxBBRs38HBT1KN4thfo05dbuNdI+NQzgbSZaodvZkEpdfJ/rBC9ltwoe56YWYK/EoXekwDJVZse1hGtxMsYnhLBzQqOj3qqsvBIV7Ljo7ug4D7CXo62PRMN7H7rnriozWU3MPVpHiFxSm5TY/ScTz6hUfutSLo/2z1VcFzsIQw3MRwYqcYltG4al1oHHPv4fRWIseBWFKS4/WOg6dGdtfIpiFsMPCbnIPtBXPbVSPJPM2JZ8RffkY6qywWyiZSMSyUnNcteibv3mTdXH78eubqsTx75gGbLN2BadCm1SfZidTM4PPXtfkkEcqG0Epd1ZktmiZ+GuasggGzvAwIKDqfeh2IShcL8yjwinNzuBOc/hfnReidcOW/peDyV9qKS0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccf6c11b-ef4b-4c70-d1f0-08ddeec86458
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 11:11:00.1571
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F4AfiIVndAhCLSNE8/w2A5pKQ7FbsLnm+aYHKeILUUBLnfy8OBLkjsgVmjA6ihsz2GP7gAMlB11Ph+58xKuqhD7171iq9E66/OSqQuuPjgI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7155
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_04,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 phishscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509080113
X-Proofpoint-GUID: eMaQcRY5YrymYflPJmfuu1hOjJSP-law
X-Authority-Analysis: v=2.4 cv=Tu/mhCXh c=1 sm=1 tr=0 ts=68beb9c9 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=hKknKL_MvJZ0P6Ka4G4A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDExMCBTYWx0ZWRfXxcWBAqawFrf+
 IoNIcEcIcu0gNxFvVGSK5XpxK3s70oeoYSini7hPlswT93wzMKb5SHHHK1wkVhSaiTJ2Mb0I6Bt
 Xsf1tyQkbDyTerflPV6DKx6kdNJqAC0ZbVJ+Z5OtH8l89mWDDsMXOFDru0j+2TX0i3GPh2VPZEw
 Ua4Ou70U9SvgoqBLyNXv8xNBBggaXkk2zzLUod9ZA0ZJCHWByvlMb43HwpolVR7WZ7dl76T16A0
 gNRaPvi7+or5zAI6ED6GAFOiztKbmcdrZpR+PJleqUi8JjYidmxAwokwXrUFx1fvQObhrKn6G4n
 E8TnqD6p8j0noa6xk41S5FKNdIEU+6hw5UKYK/ApqN+S8pTzaHk0hjF60FMncQJHl9zupnVTxt1
 1uB70jas
X-Proofpoint-ORIG-GUID: eMaQcRY5YrymYflPJmfuu1hOjJSP-law

This simply assigns the vm_ops so is easily updated - do so.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/shmem.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 29e1eb690125..cfc33b99a23a 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2950,16 +2950,17 @@ int shmem_lock(struct file *file, int lock, struct ucounts *ucounts)
 	return retval;
 }
 
-static int shmem_mmap(struct file *file, struct vm_area_struct *vma)
+static int shmem_mmap_prepare(struct vm_area_desc *desc)
 {
+	struct file *file = desc->file;
 	struct inode *inode = file_inode(file);
 
 	file_accessed(file);
 	/* This is anonymous shared memory if it is unlinked at the time of mmap */
 	if (inode->i_nlink)
-		vma->vm_ops = &shmem_vm_ops;
+		desc->vm_ops = &shmem_vm_ops;
 	else
-		vma->vm_ops = &shmem_anon_vm_ops;
+		desc->vm_ops = &shmem_anon_vm_ops;
 	return 0;
 }
 
@@ -5229,7 +5230,7 @@ static const struct address_space_operations shmem_aops = {
 };
 
 static const struct file_operations shmem_file_operations = {
-	.mmap		= shmem_mmap,
+	.mmap_prepare	= shmem_mmap_prepare,
 	.open		= shmem_file_open,
 	.get_unmapped_area = shmem_get_unmapped_area,
 #ifdef CONFIG_TMPFS
-- 
2.51.0


