Return-Path: <linux-fsdevel+bounces-61988-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AAC3B81790
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 21:13:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCDE846706F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 19:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD8032129F;
	Wed, 17 Sep 2025 19:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pfO6OLZD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zrfqA1Ma"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1433161A7;
	Wed, 17 Sep 2025 19:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758136341; cv=fail; b=aD67fxpght3/4hNlRVQbCxuSDaQ+jA7eFuMua4K3v2GAQD8QculPuxAKPQfZJZ9Hkt2Kv5eWy6B/vedX4XOP57t7FDXLN/vwuEVOWvaZfgHPvHjKYu1pvBNV1VXYcZS1CjM9GG1s/A7skNQkwrNaxhBUCMq0bZBEnSfsf9wYNa4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758136341; c=relaxed/simple;
	bh=WQQYKl7bMdMQdiTdEOkJWS98jLkTjQkQt/3SE1BQH8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=lae+kC/3XeXp8qbOxQLZRqxo4Ny7nO5SaBhiCy/iSh2pIpBTKpnQBiE6sjgRgq1vETkXKMq6rbtXdu3L5EHCkBvaJtpDoIzPbBiOww666Ge38PFmneaq5eVg4hjcpokTPrGBasZC6BX+9L+1PYcFp+wdjcJRZX8pU771R4NJjuw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=pfO6OLZD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zrfqA1Ma; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58HEIVwZ014271;
	Wed, 17 Sep 2025 19:11:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=04ZLkxkHhCodYQAh
	IC3JkoW8/kMpL+Uq7UOByGpvuw4=; b=pfO6OLZDlPqJmWY2ZFt9THHQBuB+Vbng
	rVpyBWcSE1oVh5bpZ67JzP4+ONdGSF3eSvjGzuIALD9ErX7TRYYGKipvFTljB3Mt
	ocsj+q6IGVPkxsUB9FDVZmhmK9U6BDRpW+LQBW574/hlFzbxtXSwuWuo6qdvCQGJ
	Ydt7rEytukoxppUdB158fDrnpjmWZcAJe796IwKYM2EiiaAO11FdPsN1TY5P6Dac
	4WoD9/WKE8++KHhjCZVDE0almyySqWiEH+MGry2mKjGFhmmeOANBL26D0S5387FL
	CFIxsnaXrM7Mm5RhnrhWRZLtPGeiSCprDer7gz1c4uwnN37fpeFt6g==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497g0ka2b7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Sep 2025 19:11:28 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58HIf5xr036751;
	Wed, 17 Sep 2025 19:11:26 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012014.outbound.protection.outlook.com [40.93.195.14])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 494y2e76fp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Sep 2025 19:11:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G+ef/s4MuB0OpSVNEXF2b+uchPjfLixJ1MS1VPw6FeDtN2yRgEAgEODxsnPdEOPJsoqSl/vrQg5L2CDooIF04IL7s/0o5pz2oLpNmBkS5aOjU4yoNCZU/1515t9t21ifQGustijlPAes1WCUjA5RAWEC1vb49Odrw3CTaKHSMaFfmcGT3LwZucG2eOqtvSNJ2yLCnmezzK+bJVQ3ywB70AsRvb7TFkW3wSJK2ElDtEFK9qzVBdhlmH6BpmBNmoTHK/rHiFRfhLXmpXFOS7cgPOKe7N6jBiNeWa86V1gRLhgKn9Xz/Yva0qYNzI//q+OXKNb0ri57uzTu5sBywNV53w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=04ZLkxkHhCodYQAhIC3JkoW8/kMpL+Uq7UOByGpvuw4=;
 b=pRt+6aoh9tvWc4CfhLLSA3COaD6cljzSTNFdz97pOGW0t/G+6t5LIQOScPOu/ChM0E/dp8iWmD4sQ3Onirktp6Rbnwktk1d5DG8xxkynxjqz9pHbeue3SK3Q6gBsbiaUHJkCvbn697NGg+6c4KcJXqTLv7uKo+pRCCtz2oV3sryAgbkxNlIzJEIkIaVFXBR13YuZH0uXtkfPSBvyvHzZDYOvh+LHv3BSyzTNap9D1Q1MIusSVkdPKiDI86xAYmXjq6BzAZEe9BPV6x6DDRLBVsbLO82reGUPAhg47rtE91n9OEf594ycOixE3RH0TaAm8j6YabG/8MtBcji4XtfmYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=04ZLkxkHhCodYQAhIC3JkoW8/kMpL+Uq7UOByGpvuw4=;
 b=zrfqA1MaEBr3QVh2z9jSTZupICNSDPFi3fuMx4aFsu0a0y7yh+gXW9+lwfS1tR/SiR2QgrR0JzUnBlrcIS9T9TMmhYlcJhal8NtMFBxsPLrhtx8X1kKhVAZ43vKTszvw5iso2O1EmkLhzjE2RTNNeyehacfkwbzwk4WZwfuPhBs=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by LV8PR10MB7774.namprd10.prod.outlook.com (2603:10b6:408:1e8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Wed, 17 Sep
 2025 19:11:22 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%3]) with mapi id 15.20.9115.022; Wed, 17 Sep 2025
 19:11:22 +0000
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
Subject: [PATCH v4 00/14] expand mmap_prepare functionality, port more users
Date: Wed, 17 Sep 2025 20:11:02 +0100
Message-ID: <cover.1758135681.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0324.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:390::8) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|LV8PR10MB7774:EE_
X-MS-Office365-Filtering-Correlation-Id: 81c9f065-7f67-4a93-7943-08ddf61dfd8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dcMM/GL0lN9Ayh1CWtx5zme6OS+HzSmoFjKaxZlrah68U+xNg4LP2VXzWFsL?=
 =?us-ascii?Q?3M4rxIYqYx3hE0EG3uLCmWa6N8vZ3K3Lz5FyGtdTC01p7QWcHZQjz+MA2xRm?=
 =?us-ascii?Q?2HCzb61+6X0wVcDb/r6a1qDq9XMSas6H7lQzmdHPj0av07ksjQvwtdecUNxP?=
 =?us-ascii?Q?1M+181aISllHAudLnLrePoslinqoJJ8Q3b8tsiosJr62Ow1En/8yJTnKb97q?=
 =?us-ascii?Q?hDFQWtcVZTtCzDUzu3iPYaheCeE9ajv67wHrFWGOeFb65zlDlML2nfPtd10O?=
 =?us-ascii?Q?C9JlwbNSQFAvnsUJaAmT7RBvzri/QI9Ura06aUzDUQWK9avla+AEvNoidZY7?=
 =?us-ascii?Q?BZZaX9gQrHO4CuNpXS43LnjPU61qkJhmSrg/HbPwG80ySl+c+fBgcPcd5+l+?=
 =?us-ascii?Q?3JdWQRnYfJ/QMB4Xx3ALGwMA7M6xoQDh9cY/ilEF/zusS99wFwAs/xwHRgEx?=
 =?us-ascii?Q?6EprNCaBEb8cUBTllqjlVyxS8hgmBuTfKsVJ79kJ7eeXMfEqjH94TuyMldtj?=
 =?us-ascii?Q?1rf7TjAmGbBcXIv4TrAY1qj4VWSndpF08BAlrNoxVU4SfnfidemjPh7dXO+f?=
 =?us-ascii?Q?Ppdt8aYYP+TGJrZnlZ0fhKqFusgZF9vAARUGCXR/RR0STCeSbCl0tgthar3S?=
 =?us-ascii?Q?1CinELwMpMWsE04yrVK2Iuo9lPcz4LGJF0pgY8O7P8MU+ECOY+WxuJ1suZNT?=
 =?us-ascii?Q?hZJ4CoYBVOYiqHe5ohmassje02x665GS474Z08RK+3mjWtRiefI/3Snyg53/?=
 =?us-ascii?Q?IHk6A55DYMxOBNDqsWpt4fdZd/LmwvMlt2WB4rHzizrdtQetzKmKbnMcXXqE?=
 =?us-ascii?Q?Rv7s5f5TjQjrRzHlue+NEYBXJO9HipdEfmEBus1E914AFWLfbeLF6eGuBnhc?=
 =?us-ascii?Q?INQOxk3RtBFX1RqTpptCs/S0+ENlqqbQnUYokL4xoWpglemS//oRFTXVseqT?=
 =?us-ascii?Q?dCzUpLCejeqRUx8WLiYziEElPAogmuXUzuTLVgIAq+mhHvowNEMOqgSuEHm0?=
 =?us-ascii?Q?iMDSkTdC147NNL9AFVN5OtxAc1KS6e6gR63BxBjw0R8H5cRIVzccMP+wxU09?=
 =?us-ascii?Q?hAS8IONIDfh3quEO6W4z/fKmYX0noj1EqZUdx3Ear4rLZgVCu41o5WHYNv3U?=
 =?us-ascii?Q?dhzdLJWcUxyEaBy3jEuyqaiVhgIUum44W/D+ifzC/cJ3o3ZFXZoBSkbfKPO1?=
 =?us-ascii?Q?vW3fmwg5n2wIyzqSl2V88p0GRhHaQny3vM4beXXfoasGvMOnEkPuCPROMW2S?=
 =?us-ascii?Q?27FenuzEvvAahISkLO7wbD99uWhArDsPJWKAWEaNX/n8XucFHgmb6m27rgai?=
 =?us-ascii?Q?KYBMxEEz/ZzXhlpPkvHA7LMj+7zi8RyZxSwPgRktkTq5iL8l8Cb3yLbUp6YJ?=
 =?us-ascii?Q?BmgynGd/UdsqtFg2NSsw7/Nnyf5R?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KwbiteC396uko9UN96VMZI9zp9NKVYhDye/uyPuqqIaYgZTNJ6xNCIUjzIHl?=
 =?us-ascii?Q?FyY2XWuXavVECwK5qR68tCQFVDnHdiMW6+v1pW4zGOZQMWQNWA6oH3H1ogRO?=
 =?us-ascii?Q?BVBap6kpClTiDH50I/oEnam0ON0V601yIl7Xb9N9xwBcswkzTb18W/OsArBw?=
 =?us-ascii?Q?FNzr4qvYYbHKFg4mvmI18caxXXzCxoer1QbM9VvBI4isKVLT3Ktokrm9v9sV?=
 =?us-ascii?Q?63J8j3iYjXw23mxg9OFi0WPIQU2PbW5/YcpFkQNLdwREWVo3d6LBijXVbbVF?=
 =?us-ascii?Q?ALcUqqbngZOViUi+v/dEgFfTGKcQdS3YcjCjIPDU1rW8kSdZBwI2oWl45zNc?=
 =?us-ascii?Q?yikyRt1Lj1MX0OW2ar0+D/CHQydR8GCHwUmNJi9LSpG/zR11njO9LkE1zG1W?=
 =?us-ascii?Q?TyNQzACYlIyZJ68w7vcsGY0x+Goa26PKHiq4AUWX+0oVEiUOgnt16I8rH388?=
 =?us-ascii?Q?2AhzN1m7AsVO3ynNABKGrhpQ2LPYJOXTtgOSP7G3tIc+S67NJVVAHXBTS6Qv?=
 =?us-ascii?Q?7KyYaEB5n+Zzyvjf14DPkjdemTiLuMsMUTzERBMaEyNKv5Y7FUOLw0gsPult?=
 =?us-ascii?Q?Gw6fgjpwThV58PnKcem9QiKwSBuTAFp+fDKrGKJvstHCQfAFbm6X5Zb4HflJ?=
 =?us-ascii?Q?gkwmSEa/lZdO+R6Eaaxqm8TGs2ItKapiJ50Ni+0XN/8EBaORfrrfjwuZe5Aq?=
 =?us-ascii?Q?1BOR82MkWlmL9SSZYeJAJi6SosR0+Tm3HGKoBbOmCG4Dp4fvGi0eDaofwA4v?=
 =?us-ascii?Q?RnjnTVXm1uwufs6uk7PyvVo9ffo6784prR+RBvDvTep+FXGgqLkSPp2L8ux4?=
 =?us-ascii?Q?f6V98HTBU3mPv4KdctBuJqDP88j8iy/xlJJfuNnrOx9/wG2Ns0Rk+c01Vhvw?=
 =?us-ascii?Q?iIi7po31X7gX0v2KVdAU1Njz6umOe0UekRp9T2DAfRU8YjNS5v/lrTWwWfOG?=
 =?us-ascii?Q?WSTSohNt+c2V7qB4LPlFBiUr9XgXSB0KNXpg94JPHrhhOscMRKabPc6IVCy3?=
 =?us-ascii?Q?+Ox2Ld60Qs+l2YvrxrUe7pUDQNoU3fIA9+Gs6wpMxMnQScDUhYQIw+stpF8D?=
 =?us-ascii?Q?WSomZiwhFl83JgYVpF/GGgZhb053Xre/J4plgfPHQvt/ISI2wZrVZSgHo4Hv?=
 =?us-ascii?Q?Yj7iQH5R7sXgzAp61Iwt07ecxqhvNGeFW7fyCjmd5bVvndgM3C/FtEXuzDuJ?=
 =?us-ascii?Q?TxxVn91oEkz9YOfhKpbs+mqAMT5bsErDdKAr8LmxwWoK7pYfn7qt2yQ4pXVf?=
 =?us-ascii?Q?/k+8KV6+v/Z15DcG50QU1/8QopZI/lyt6uM7BqEHndfaAaLPnlvUJcc2ZoXV?=
 =?us-ascii?Q?YwOOKXqB9YFpZ8VRgL+Rp4Qb8QCgGpx0jViOGMbQohb9jmKEDiU4zQnB+0HQ?=
 =?us-ascii?Q?8Zm8Q0xehQGiLEQNWHM5ocgtun0vd7VwrmPCjOEixcnxlztEernETwVOzSa0?=
 =?us-ascii?Q?2iBiensq52lrn8gUsXWhfyWOU79aIQs6nk3B5uYFT3DksdHdAHgkqk6yuG4p?=
 =?us-ascii?Q?13ylMMO7bQtPSlycOGc1uGz/m7gAOL/HH/KBi+zMD+FUNm6T0fAcjSgunQnr?=
 =?us-ascii?Q?s/gjfVTs082nGVelEMYKLY7AXRvQHv+UC5s6ODWz62UKUlf6IeRKluo7F2wd?=
 =?us-ascii?Q?SQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	OL9bPBElBFkbVR79FocwlQ4TGZAFUrpnwIs057qv5njiMVBXMocUQZzl8M7joHelhHBrLNPySOu93bB9ZhfjjIENDofX23HnzAJ26jyyIwFqBtUgq5rAe5qTWGYUKcsvuut1aepmDwaRXygI4ARrIv1Wx1WaeGYYtV7Pff+aNp8qQV4Mu/McJFHHO8CufruEQcAROekDSnEvndiyBPQGKefJILGlmjLcQhHwSB9/ft9m7U9oaMh9vsndeXo/MpH3WDDpT3egIq1sTTmftgucM2ECibfSWu+Sjia3c11OS0w4sj6rHoi5mK4kgig2By8QWRgaGS4x6ildTDr7O7FP+4kuk6UouOldCt7iT1FWn66WsH25XBSoPvomG2Ll5xSb7HBcGAi4cR+G23H7MCDbZnhfLM1bz91y7MQ2hKi/1tVMFO6pmG6a4jSCxatMVs4Njudn372MIY/TZEXOamsgKScm3fWZQ6HDWy5lO3SQ6rV1xN843PA8uJngU+CHULpj3GFE2yhQEs7u9G5Hzjb93hsL3O0jFuQRjvGMw3C9nz82Ug9GXTyUDdkXhSFcMaIHdVLavKq6LLCbJOb/Bt72jFnKtud2rfIJmKF975lVBOE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81c9f065-7f67-4a93-7943-08ddf61dfd8c
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 19:11:22.6112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DA5hJc5ItX83m/N+imESlWElv8WdmO5GbYcpS/jaUrBPow0BrkFQhabeKUaSSnUiE1m71x0jAd8iDWb61edqWPBnt+vYO6QM2weu0ksu7TQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7774
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 adultscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509170187
X-Authority-Analysis: v=2.4 cv=b9Oy4sGx c=1 sm=1 tr=0 ts=68cb07e0 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=Ikd4Dj_1AAAA:8
 a=KjnsR6uzOoiuVaV4c1wA:9 cc=ntf awl=host:12084
X-Proofpoint-GUID: OLsaZ1LAXqnbMw3FiN7fPHbs7bI9LZ9O
X-Proofpoint-ORIG-GUID: OLsaZ1LAXqnbMw3FiN7fPHbs7bI9LZ9O
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMyBTYWx0ZWRfX0Nqau0oc10oM
 cocCOqpmKLnMks31FzBqKxsRDvaYJ9OKQ02SDGU/4K/qh5qBD+gEjrj6pekOWwIu9zHqIoH/f9b
 dguzCiP+ppxf0mve9AuWZlngUfJlwaYbgPtkXNW6U0Cw5/4+RMH8g708EUjr/8Xva/4F/b80mdG
 gXmIWm8xY33jKeRejWqyTYpPr6xMNvr9jQWXfAa9EC0N9DhZ40CKR0BhOGkC5oiURFTB5E9RMxf
 uK/JVxnQIEiFZxstTCeiSZbQdWL5G50Lr7U6B4kZFpgaTnMnyeDu3CbLb8X6xeX/ZR9fCS6Z2hy
 /dIYQA2GpEnodYPlQDokJYq0nkaX5IKQeaxKBUPN8tU1TzTv9eLYX/x3IMg8mW15eeMo0jqcF+v
 7WmOWxc0OAvlgdPvQj+SVr2kLNo+hg==

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

Lorenzo Stoakes (14):
  mm/shmem: update shmem to use mmap_prepare
  device/dax: update devdax to use mmap_prepare
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
 arch/csky/include/asm/pgtable.h       |   3 +-
 arch/mips/alchemy/common/setup.c      |   9 +-
 arch/mips/include/asm/pgtable.h       |   5 +-
 arch/sparc/include/asm/pgtable_32.h   |  12 +--
 arch/sparc/include/asm/pgtable_64.h   |  12 +--
 drivers/char/mem.c                    |  84 +++++++++------
 drivers/dax/device.c                  |  32 ++++--
 fs/hugetlbfs/inode.c                  |  36 ++++---
 fs/ntfs3/file.c                       |   2 +-
 fs/resctrl/pseudo_lock.c              |  20 ++--
 include/linux/fs.h                    |   6 +-
 include/linux/hugetlb.h               |   9 +-
 include/linux/hugetlb_inline.h        |  15 ++-
 include/linux/mm.h                    | 136 ++++++++++++++++++++++--
 include/linux/mm_types.h              |  46 +++++++++
 include/linux/shmem_fs.h              |   3 +-
 kernel/relay.c                        |  33 +++---
 mm/hugetlb.c                          |  77 ++++++++------
 mm/internal.h                         |  22 ++++
 mm/memory.c                           | 133 ++++++++++++++++--------
 mm/secretmem.c                        |   2 +-
 mm/shmem.c                            |  50 ++++++---
 mm/util.c                             | 143 ++++++++++++++++++++++++--
 mm/vma.c                              |  74 ++++++++-----
 tools/testing/vma/vma_internal.h      |  90 ++++++++++++++--
 27 files changed, 799 insertions(+), 264 deletions(-)

--
2.51.0

