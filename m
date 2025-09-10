Return-Path: <linux-fsdevel+bounces-60837-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A50EDB521D8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 22:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31059582CE8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 20:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830A72FAC17;
	Wed, 10 Sep 2025 20:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LGv1E2t9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="o545mt3E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A142F0C6C;
	Wed, 10 Sep 2025 20:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757535800; cv=fail; b=oAULuhCvDdnR4KpeoFFieHJ2kTYE6TDJAl6FETziz/M5mkB0lISwftLxJ8uWQNGYRHf2IA9H7w343g1UXyXj5SW0rPOHzSFLO7rqm9Irq1/Bz2K2H3sezAsHIisEYq6PeEqITex3ZFa1Ox29Z39pVEaor5NxV+eZcI4pqp3wFE4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757535800; c=relaxed/simple;
	bh=OmBk45+xqox65yLOlKChKPb3T2sYjfHosl3O0JyXpDk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HV95IteTNt6/42ApglPSNWfbH2/8b2zhhRYvw6in6XxHfLJTPl2DqoCPaaav+r1aW+ArawkG2lPW/JwrRo8itl5W60uQ7jmzc8mm1qVpeiVpN1Zo4eS94QnCE5gjyQHE+p0niU4z1AwEVPRAhBnZ8q6FjxyX9aPDGCZUGJ/baNY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LGv1E2t9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=o545mt3E; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58AGfiCU009725;
	Wed, 10 Sep 2025 20:22:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=AmUcjNy47CjjgkAwV08cKlUqjlePUW7BN5yFydg4gC4=; b=
	LGv1E2t9XxJ78GktcU7luDJ8lMbhag9dCfTDKYCLbgb3me25kzVh2ZY1HVRTpWa8
	JGz+DbWV1RFoVUY2P1c8Fo3M28iHVH/Qt2f1dCsz8Atm0qQU1ejkIV1GoBJ1Qd3W
	R5zym60NaSdQGYEx90ATlln6Ovy36tbvVrKJAV7l0Hh6wZ7JT1dvPzMr4vNHNZb+
	flsQHVkpb6mRIpUpWBuDp5xxNrjsYQ0EmJ+oVePu0QgdCc0+I94A17PHOonlTyT5
	Je+OQdni8R/C+sCcBzoCzYyFXgsqrQZxqSdF2Fa4GHWOYM/9Y7tZWQXjISSplEv0
	HuqQnAp6RDdz4guPjjQCvg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4922shvv1h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Sep 2025 20:22:35 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58AK3dAp030716;
	Wed, 10 Sep 2025 20:22:34 GMT
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011034.outbound.protection.outlook.com [52.101.57.34])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 490bdbfhjs-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Sep 2025 20:22:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BOLownyJS118HOK7Q0fEk7IiEf2EvkkhFR1R8PFRQ311QY2w0ovTZ8b2+UDaSiG/JlGYnkBVONbuz80sJwnhpgQ2cA0WOS0F85Qlt0rkj8hWiX2LiAbaSeWcDo+gcABCPv36hMMHq1sSag+ahHd/whAwfqwCgLaeF/tNaNnrVl2hFtTMFMPOocZdZgu4TUX2m2a3UIU22+8+TB8ZGRPGw179j2h9lu1br2Z9d/hLQsT48/P54vgEG8n1gJkSPRlZokCR2arBalcJZ7PJlZpDv2BWfjpCC0sxx4QoRmBSwf+ndb6bGa88R9Hm68INRhMofGz16AmVIWCj8cLiLIVrcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AmUcjNy47CjjgkAwV08cKlUqjlePUW7BN5yFydg4gC4=;
 b=UnSKrnrpuCJL7Nz1S/vPYB9dMcAfV12RoIv6Fm8Q3K1go4vcftJMQgsqdzOatJvO6TMHA5PUiFcNt5Nbon6k4/znsUmQgu8fLTZ0sk1Fm1hVJSNgYDvmz7QZlR0wKgJq8gfUddjEe+qcukvnzt+exkwOp4Di1fAJg0Uajui7KWXw2sjtUsfYXryXNH2F3hpE90L9wjh7mlIrRZx95WqO6MLa0u2Aq6miVUgq4WB9wxcNXy9svOJgJ11q2aiNR5NAYQBF24yGr3hVRH0yp5AXE2eiYXeG2yAiMF/pQUSRqemk55LSeqwqeRgiFPjzpxkfj9zzlTfoIOqHmIDVlbeEng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AmUcjNy47CjjgkAwV08cKlUqjlePUW7BN5yFydg4gC4=;
 b=o545mt3ED0WQl20O7W2ieJOvHEoO85qbZf6KTRS2sXVT61p7gHT9gfzBuWOIWLI185MMWix+1LQ8V4bZ9bZ+D57qofVD14VdMt5QJ/JE4wkNFrB3N3VR0Z4/rbX1cFJX+Sj4604cVu6fiRQ3gKuQ2e2yn1IVPlCVzSb2EcLYOjQ=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CO6PR10MB5789.namprd10.prod.outlook.com (2603:10b6:303:140::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 20:22:30 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 20:22:30 +0000
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
Subject: [PATCH v2 01/16] mm/shmem: update shmem to use mmap_prepare
Date: Wed, 10 Sep 2025 21:21:56 +0100
Message-ID: <c328d14480808cb0e136db8090f2a203ade72233.1757534913.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1757534913.git.lorenzo.stoakes@oracle.com>
References: <cover.1757534913.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV2PEPF00004532.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::35d) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CO6PR10MB5789:EE_
X-MS-Office365-Filtering-Correlation-Id: ccf4f7ad-bebc-4e20-c43e-08ddf0a7c45d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?B11zIKsXFrIYiJr20PeoKdAPn+wWU6k5j0lGpTZCHL3/3dtqff5QjWqr8cqv?=
 =?us-ascii?Q?kQ+A2plbfPMpwIMlkSJSjVgtAwc0r2XV72GsV41FDA3PEXiOvpB+2V0tXIv6?=
 =?us-ascii?Q?Fx09Crlltsz6HwbVvlNcQ2QPN3gcIicPJqfBY5sQccedqUMIe0J6ZPo+Yy7f?=
 =?us-ascii?Q?bnnJhZ1rXuta6cgj6rO0yjvYaoCxXEn18z2lbN9JvMk4KC+MtYLrpzfPGL9P?=
 =?us-ascii?Q?EFz185uDiZHkXE1bczMN+is+zL2mUQOh0dVWFAlKMXQx/2A7hmo9kyZ77dGB?=
 =?us-ascii?Q?7NPGZmpmBi42kJTKv4wWlckXxSXvMgPp8bCZjTcRa3n5ZXp4rk9J0sL/iakE?=
 =?us-ascii?Q?uncXdo8C/KUQinawlNnggQUMexl7hNvegG4UYv0BYZ/1Fiy3j529HZmaoyKL?=
 =?us-ascii?Q?//XvOG0XxHKnIuAnN2XAjUT+6i5kSbFIqUQGilGfwylnf5cZ6NamV4ZoYfUa?=
 =?us-ascii?Q?wlNlQqGZz+6cIXqPrGpb7uG/7igfxm9RO5r1yPXd5ib4la4b1GhD3g4m9O1K?=
 =?us-ascii?Q?H8X9VLKMWZYom6PmQPB64HugoqU1yKV2o3qOblDOoQxhxoHF8GS3vrM219tp?=
 =?us-ascii?Q?eGEVs8CndqqWnjRAfkApXWJl1TmAkBR33cp1WZTgSDsI0ixtDkU4TVd3J/QI?=
 =?us-ascii?Q?tffFqhORylic/9iz2Q3Ju+uT6pefiTePWNwB8ih4zkgGgBohmsYD8kgk3J9Q?=
 =?us-ascii?Q?VYDewrdlxGgqPPRG80Vg4V+e81A7dYfLqZbDrrXXyc/V4Gnot0bT22AfidLO?=
 =?us-ascii?Q?l4qoxqgACVuQvUbWMSDM5r8vrHwuJlGx29Ll/0xTLskLGkoaPhwjVb2rb1k2?=
 =?us-ascii?Q?lUJ+9vSxekSwgCINCX74bq9ruBjof1Ctt7g1UP6JuALx5w3oMJtbJXpc7ZI7?=
 =?us-ascii?Q?Ze+CUfJZfvPZHBJJELdm6pvrWzDx+P+Csec9uqVjBeQWCgP7MsCW3V/RuqmC?=
 =?us-ascii?Q?2zukPnvh5fRpKGGbGSyJXIAN2KblU0hN7R95xofWYew7wN4SZYvTs1aK5D4L?=
 =?us-ascii?Q?RbwUnwNheklE255s0/XRgzDgqziQnxvfIVEg4azrm5E1XFYiMf/UTOV6J1HA?=
 =?us-ascii?Q?xgGMEy9Jp4e3EJdKqgrmoepZu+YOyTVn0ODd/NOLa05NEvCmB9aB6i9/UMLS?=
 =?us-ascii?Q?tjzqsiw8lAaZ1z6+mvtZub1ZFjCSTKnqGZICLKbYcJKVcYCLq+lZnGxuUwMq?=
 =?us-ascii?Q?0xtZYyKZOybHg3k6jKEykiEOq1Dyf00WhFwqKDsZW1Noqh41/nlD85LR79r1?=
 =?us-ascii?Q?U/1eCliWOZjAi4/T9GAzFMTQaTlez8rmyuUpmLMONVFjkBNLxupUOhqfyYJD?=
 =?us-ascii?Q?1bq48M2b6UPmwwXwGVMI5PGgK9fUYlkTSGXSyc7pzA0CdDLItKFpE1fxloJc?=
 =?us-ascii?Q?6u4ZeVOLyySZJWEy+nnp9G9FvYL56ylnw011dO04ZLjSrFU8QuQwlQajSIM+?=
 =?us-ascii?Q?vpTc6kpsNR8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VsiYuZCMKhXG0nioAlubhjlKmR1Dr8GaZnsOvXWypOzLkyOHS7/PMOQqNHRI?=
 =?us-ascii?Q?KTakZ2iKBcGjEfBIftIUtYnfC6LfUhOKaFeVdaM+2vwL+mP9mZDLpkS9Ggq1?=
 =?us-ascii?Q?jkMdjnzCT8DfnNGhqfAu1MXt3c6H9xSophHPPaALp4Csyv4CgA6rL5tblR9r?=
 =?us-ascii?Q?SB+7UdHUQEv//B6yiPOH8ktapruaJ97uPujmWheAI5Xkwr50jPtuU9EWzJ8w?=
 =?us-ascii?Q?9OIoGxSOOgmcydCr7D1lDc0MnPEt7xQF6pMt/hLtckOUVCFew1kiftSmMPao?=
 =?us-ascii?Q?pi04ST9aI8DIW+fH4dhAk6BCJZMD9511vNyYyaiNTh8xEioEir/4Z6RPLJNs?=
 =?us-ascii?Q?OX5O6jjtdW8d9Vnr3d8DmTkPgTq/l7prqbfd/oWSR+YAjqxnekgYgg4JFcDI?=
 =?us-ascii?Q?so9P3vpBalIv/77/u7PWe/vuV6FBk1TiMtXO+x2vHlO5mDWDtRvWDPngmjG2?=
 =?us-ascii?Q?cV1KpthEjXYlx87eHRzFRCuSP5z0kLHYkCZwog2WShAb+wWlg8DR/4HtoAdu?=
 =?us-ascii?Q?W2HxdgK2o4oQP3uAhfjqiCypQmpkZU0JVYcajmV691oML5zj5+uUEnuWMlC6?=
 =?us-ascii?Q?3o9EVbON5qOzYSq77LnXR+X0J1UWr4R7EXuRcJcBDm8zhtqXxV2pxwh6JSom?=
 =?us-ascii?Q?xH0iGmwtq8QdXoGR5EoAgDqT+GFJNj8nZZc12L/6rie4EopYOAjL2b6tKei4?=
 =?us-ascii?Q?kU0hZA28pTq6YhCiQ2Ps4jAgDuiTQ5M5O75k7sRbPPt5iXf4SaL7UTqq+ZEr?=
 =?us-ascii?Q?U4jojGr2rrQwHCUJACGMVIuTuMz0gef/cLQswoFU5K3ibSJBN/nDNRFT7ZD9?=
 =?us-ascii?Q?wz4ECdYfU8o9Lmv9dv5EiTMUs9IYbFq32OVHTsNANSuCCmahS7K1s8N5oky1?=
 =?us-ascii?Q?fWG5yFewQGhTFxlU/d/qq9n0Xx/Fphx5Kn3YHUF/GxqfbhgCht0fqfPGpk2n?=
 =?us-ascii?Q?fs8xwVZLAtyLjd2qcLLNWPDjrv8OnGG6NpaLbxTE6n20U1JBzYIQsZwzgbhI?=
 =?us-ascii?Q?5nD0MwNNUz9OzLVfNyLD2F3iD7m2peOp3HluNC9wSsXxv5vxCUmpK/eAmdYo?=
 =?us-ascii?Q?Eud115Z1/LXRUm3o0BRK2LOfeaZbFD0BVAFtAqSEnRE8bkSvS4V9DV4yWvyB?=
 =?us-ascii?Q?loCL9YFx3LbgAyHgJcAczPSqCPRFgUxv/xRSjujh9fRPc5GqtlLaBVPbj5yw?=
 =?us-ascii?Q?Pr/v3A25+jVF7ikboZoUW4PXbUXcI1EO2nTB6hmdd3OvGmSZUM7h/vAIVNOf?=
 =?us-ascii?Q?/0KxHkJpg7eTL+9UJLJN7baPwcsyuOWipGb9lIWXc0D76cBKTjQ41PxmXaF8?=
 =?us-ascii?Q?skBALQRZMB++Iy2qutIoUvf8325QKz2DBpbikBFb8H2oj7X0m0qRoQVS7j+9?=
 =?us-ascii?Q?7CVE04/UPtNfzVuu1vW6IVDkfPCHvzP9QI7S7EPgRb6yP8wwAM7q3VGwYE3v?=
 =?us-ascii?Q?IwN0xFWW9LoOqrPfS4ofOFzmUETygaez5wHy7AuzBJFdqGarOje8DPU/PFI+?=
 =?us-ascii?Q?tMvbUHDTv9tfrzsEAMt711OKUVBeal3BdXyNNzbsYtHXuSfxBnUHIHGdyMBa?=
 =?us-ascii?Q?9LDgon2cF5hWRh+XewIJcMqsKs9NmlhwoI04PzAwMeIvCGneefYskyo5cLpZ?=
 =?us-ascii?Q?hA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	djpwhirJCLPyoghPxLEuYTHGmqZdQ3/6QGJzQZnFNDLF8/9/l54VRyYLfVAP5QT/nFHidCV8YHu9LgXNPZpqsc1j8amL2HfBQ+ZMuHVukfR+S5tg5utPAK569WKAwgu/ESoA6+Hwyh5Vn0BS5p2w9no0OEQ3WOveTY012o2FbCP4rrcCHXIof+EdDuqTFaEvov0/sbgWgz+V3BOvMPi884erLLCmLx4+c32igrNqhbnygUipQ0kyNhd2oFLcVv8v8A6Y6XHNz2poyDH3LWwB16EoQwFPluVF06VHOqm6OJRcXotxcMCxSk3vpROMmXjCnnQAqf9RtZQSFrzQJQR+a3m37g9orFs5rnDB5Ds30G18WL+2oAHV5v43EtYqGqUOzwVjyHo/M8sM/VUb+DN9VBXpkfiDmDkWoVHRYY5Sw44e6bhB2Un331k54UfVnkbFD7VFjquVl1OJu6AvhrBjO0Y8Pn/L+kuktOdRKaNKZ6jrwV6NG+ooE4T12jnzMYm25wjj+l2rVaobOdbvVjbRP9rs4sI0nDMJ+zon7lexq5oWswIcLEiSSgkckMd2e1O7Ii+ZYgrUkFl+M6Td14Jbl+W/Hu3Wq4iwvKgWoj8ZOtQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccf4f7ad-bebc-4e20-c43e-08ddf0a7c45d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 20:22:30.1953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Y2NM5r+x2Z7jNgDR8EKm9RUQKSEHtSC4kdQ+eEHkedf3X/82lk3JAswZSN3XunBo39NOY5Igm3lZ8WYnklidhTlqHVigfIRdtOZZKMBm4o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5789
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_04,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509100189
X-Authority-Analysis: v=2.4 cv=esTfzppX c=1 sm=1 tr=0 ts=68c1de0b cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=SRrdq9N9AAAA:8 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8
 a=hKknKL_MvJZ0P6Ka4G4A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE2NSBTYWx0ZWRfXxt3OuHH2FB8T
 ZPJdgwiA40Gpu0E2RJ+rtQItnq4Lvj5qKzndFvmMZZA+sQedDy52kb07kccc+2iOGN4uE9Tev9T
 2OzOOcX+xfP0ccvprD3270624BIqSMzpzp5Gr9GwLTbxBS0aOyFHQa1azabVIWmPura2bsy8ZlX
 iJed+RUH4HKhXEhzrNka5inpYeYlsqaEgj3AVrTV0GCjeHBeNNu1KAnyXwCE7izMUojj8WAuJhp
 R78Vq3WW8fS2gwYg6EeJBy7fZhjf/S9JCHIqyWnYUFANgX0KNLuP6VstqbZk+QIVzrag6eymGZs
 6xm7NR5YNo1XwACatyMHlELA1U73VXE8/tvbDxYUG+St3OqqNyJAu0kGj+zpTQ8xkCoHC56+800
 bsQp02xu
X-Proofpoint-GUID: _SXzNTioQD4tmu8rWAwd4SW1mnVHkuSk
X-Proofpoint-ORIG-GUID: _SXzNTioQD4tmu8rWAwd4SW1mnVHkuSk

This simply assigns the vm_ops so is easily updated - do so.

Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/shmem.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 45e7733d6612..990e33c6a776 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2938,16 +2938,17 @@ int shmem_lock(struct file *file, int lock, struct ucounts *ucounts)
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
 
@@ -5217,7 +5218,7 @@ static const struct address_space_operations shmem_aops = {
 };
 
 static const struct file_operations shmem_file_operations = {
-	.mmap		= shmem_mmap,
+	.mmap_prepare	= shmem_mmap_prepare,
 	.open		= shmem_file_open,
 	.get_unmapped_area = shmem_get_unmapped_area,
 #ifdef CONFIG_TMPFS
-- 
2.51.0


