Return-Path: <linux-fsdevel+bounces-67546-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1F3C430E7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 08 Nov 2025 18:13:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E417A188C86A
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Nov 2025 17:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA13A27B32B;
	Sat,  8 Nov 2025 17:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PEkUjeLm";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UuVMCwVG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8004F274FF5;
	Sat,  8 Nov 2025 17:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762621885; cv=fail; b=ZZ5Ueuv2/EYRwfWCTWK9kYX6K6IOKmEp5uNcN55Kg/OnN1eoXLN25zZ3IaIYelZKUG3SrYkCw6Z9ITUl99Z+lpJiJcvAnCII3pHnyL9KAVmQZ4KaQCX+PVohQu+PLYwoG0sGoyHROfASweRNlx43ZI1xr8BLs0+q5BjIVN8Sb1I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762621885; c=relaxed/simple;
	bh=Ywwk8BgU1vvgEYMYYm12WFq+m5B/cdbVU9dI9FbCrwo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=vGqYkJo47TYfTJDC+t5qK91K4urXie558t9fjwfP1Tv9wQwOXvNp+X95TRV6y8sSyYhBZDKspYA5wTmDmjx5a56QqkSy0SuFfytvCKxi096zcaF7PFLb3TZKZntt/1K/nl17H5tJraxS4hIuys4+mELoUN2ke1s5EwLG3qyN0bA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PEkUjeLm; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UuVMCwVG; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A8GfxDP009610;
	Sat, 8 Nov 2025 17:09:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=8Mj4dZ2xkCZUyYXA/0EAZ/Vac+RE+RRWNsVC2E5wqGE=; b=
	PEkUjeLmPb9+kY8XGRtNR8PWx0nwQYN5vTnGUrrlSb3JOAiaqgdzM59IswnsNYNZ
	r+fnY67bawA00rdLFIEeULUp/subDLOm3OEm/wbn/KXAzGrMRtwOl1MpfIv0NGaT
	604jNwXvq8ghJoRaZRemxHNBiu+BGqKJTDIAAdH/94jHhqOs2zTFqCY05HYFlnot
	Zt/dztHuPclA+oHX3fnFbmeCKizktx+qQChT0zvMECFT2D6aDKxqksk01oAWUH/1
	5Sjc+X1a7GQyLwhdz1SDJYrsZigAtr2Mgm8t8JiPFvisUrWB6vqXOg7xnm+7F/lr
	bg+/fWtvRbxAegNN1fdA2g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aa9k8g0jc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 08 Nov 2025 17:09:37 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A8BijdL007604;
	Sat, 8 Nov 2025 17:09:36 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011002.outbound.protection.outlook.com [52.101.52.2])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9va76n3y-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 08 Nov 2025 17:09:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rgc+RWYMEnRKEVjDlIkfO4/C+KnuUPtAACyUTjocdq5oM6WaF2HBU3waMMpj3lm4yLjL3dDOtueIqDr2tyNZe2vSyWGqaXM7oT2wL2eA93X2jN6o4uGV+I/lOEBw2yhUql1qjQpL1aL0aa8FmIDZZgv+7AHcQBp0bktjBtggsM8ConMtHLj43/G2kt928JIiOXxVthTFgfJ0eH19H8H/eKBAqeXxub7EsCQKckudJFR6ItXmn7DT7rN2j1u9geGvl+oqa/LVyRctv+hufSynk0vGobAdfGAHsKTm+QTxSwiaH9+oda+s7mP7cT+pDlVXRFU2J+fNMmzK9jwc5aOuZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Mj4dZ2xkCZUyYXA/0EAZ/Vac+RE+RRWNsVC2E5wqGE=;
 b=kX/O980FsRV4DXg80F9OSAF1K34r5X9k4K+4+RPmAtGwa6pMVk2xKjPntOcjurlnTLBKYe2IgvBLzNNJJwq/nQyIlKQWZG0xJO4EI1nQadPGjtUHW7eQ+QjTtn0tdavmJx60NQkb3r5QFcwsCgym2IfUfbZBCUKPw8WtPSa886O1FFfyYnEoyDbg/eT/vgDOVXaX7chP0xse9SGj0L484l2hO/YP5MEtNTS0qZphJjuoC/OAe0MDKzIgn4vYXcWVt6v+M5sNYaPJt05XeADbsM43lp72kdRUXC/CrIde6w59cfPdWkw9xSayNuU0q4cl7OshHwLTKL+iYZsW+kc57w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Mj4dZ2xkCZUyYXA/0EAZ/Vac+RE+RRWNsVC2E5wqGE=;
 b=UuVMCwVGA4L/p7SG6AIkurGKzO3sAZ9oyenyDoF6xhkYcUN8RMINxYtHxFVMTb52Gto7d7SV1s3cF/85YI4VSRU6FVH6eYfFYCGQUP0inUDJlg67sKgUM/s8rR9CccH1VD1rSb5AlVMzD5xJvJqszT96flvPp+N2dPEQA7avHAI=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ5PPF04D2D7FA7.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::785) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.15; Sat, 8 Nov
 2025 17:09:30 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9298.010; Sat, 8 Nov 2025
 17:09:30 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Peter Xu <peterx@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Arnd Bergmann <arnd@arndb.de>, Zi Yan <ziy@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Lance Yang <lance.yang@linux.dev>, Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Matthew Brost <matthew.brost@intel.com>,
        Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
        Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
        Ying Huang <ying.huang@linux.alibaba.com>,
        Alistair Popple <apopple@nvidia.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Kairui Song <kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>,
        Baoquan He <bhe@redhat.com>, Chris Li <chrisl@kernel.org>,
        SeongJae Park <sj@kernel.org>, Matthew Wilcox <willy@infradead.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Xu Xin <xu.xin16@zte.com.cn>,
        Chengming Zhou <chengming.zhou@linux.dev>,
        Jann Horn <jannh@google.com>, Miaohe Lin <linmiaohe@huawei.com>,
        Naoya Horiguchi <nao.horiguchi@gmail.com>,
        Pedro Falcato <pfalcato@suse.de>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Rik van Riel <riel@surriel.com>, Harry Yoo <harry.yoo@oracle.com>,
        Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, damon@lists.linux.dev
Subject: [PATCH v2 14/16] mm: remove is_hugetlb_entry_[migration, hwpoisoned]()
Date: Sat,  8 Nov 2025 17:08:28 +0000
Message-ID: <3ee4f29bf3b5acccbc7933f0ed8e8cc1b9ca0fa7.1762621568.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1762621567.git.lorenzo.stoakes@oracle.com>
References: <cover.1762621567.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0190.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a4::15) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ5PPF04D2D7FA7:EE_
X-MS-Office365-Filtering-Correlation-Id: a8c0cff1-3120-4ff1-8d15-08de1ee99486
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MjzoLYR5Tu7x61mj5+tnYY6c8s30haLDVFc+l8FsywFAge0LgoWuq8S9UO0V?=
 =?us-ascii?Q?JRHYiG21iwWCQSA3jEkUh0vOKeuLLYaOIv0VHIgEBbJxh9podzLiTH7OB90d?=
 =?us-ascii?Q?EVpQp7STEAcyfd3k2aAVOH8jtwuyZwSqW98hBsSUcxjAP2HGRaxRYoPXxLQc?=
 =?us-ascii?Q?PB3gMEI5Y98iu/B/8eAuPfHA2PfiYsQ09zTknmBhZDorGa/n6byrwNG+43SL?=
 =?us-ascii?Q?TyD2cRcbBnOHtWOaGWODAbKiJTcC1hl8cuW9KRwwXhfkGUibiHx7byMSdhMU?=
 =?us-ascii?Q?yLdX+HREXMtcPiUORRfNWY6jHnf6CYasz4B6Ydy1y/BOV+PuLTONcMnzJNK1?=
 =?us-ascii?Q?AdMLTnuGI9gl7VJ0I+Xor1HcXNVcaOrcPW9lwQW/g3xqggmBgUUF/nx57nJ2?=
 =?us-ascii?Q?pEx4RJM7IpWEvZkV3h0mZkP2pfNOWj5+syg+e4+3Lxt1QNdnFgbeB7qFWG9N?=
 =?us-ascii?Q?kkdqEU/A4L1k72npwP0/N8vow8eLzNgTs+99LHuozOedO3t8r6BJinQT2nDL?=
 =?us-ascii?Q?wCi272BdiZ6hGP+FD1/m7KOrTkk0oLiuTDqdISAku7rkSu+CrH9Exd7TI8PS?=
 =?us-ascii?Q?yJHj1ioral7d77IamGZnYNZaOGDga6XEFIkbJ1Ea9ylR7KVPR8m2dm+ZbpOo?=
 =?us-ascii?Q?o4Wy8Xbv4MB0JFwAJuPBsdhPdWfiRrq/+AaK1C1qqHo7QJ6EAH9M2ltZM/Je?=
 =?us-ascii?Q?uG0vmbPcCMCA/qJjziefp6ZuYkj80kctTdrxf39814aibbczOrbJuUB0OoSg?=
 =?us-ascii?Q?RfX6yh6Tsabg0ytEiB1+VcJ0xY9v8NZ1Liz5WUNNCo0pym81CVqkvxc3utL2?=
 =?us-ascii?Q?OyWp7X6SJVH6WqhXHg18YhjbRJp5pt5yWTV2daGzjshKydtc8I+cVnvh5mAW?=
 =?us-ascii?Q?HWtPfZIFcCnE6cAoH2Nq33zS23qVKgv2dKGZPiOZl7T2UzZlRdOZodsyrlG7?=
 =?us-ascii?Q?fUW91BgLcQ+pQpwSM8cGwa/kWCVCz0IgTkmSpBfIQaxrSNvRmBEpUsFm33rd?=
 =?us-ascii?Q?nu5V9UKp//SDkDUrEStiWHlprqnOcShHWlITRFKsn+njQAYi6jLv8YkO07QY?=
 =?us-ascii?Q?kLYfhb4/UJoIwxx0uJ2Fw6ZoJJ8lJS5VtkryO7qjZEozVXOgEJA920JMsdoG?=
 =?us-ascii?Q?OAdQ758b4lVSFXQP4HC2N/U/TR1k6YfxOnibgIhgTrTwZ6nlYCWZCdv8JaeG?=
 =?us-ascii?Q?6zS8bOSy/jirTzbSIsU1POhg9DAiloSzXyaNbAGjBvWV1hXDlubsy8qefxOn?=
 =?us-ascii?Q?pOLv16ZDWgdKIg7gROC562W5SMCZG7LW/eVHdWZEVb5fKs+Pe9jqWwkyB9Lv?=
 =?us-ascii?Q?8KYGxfmiWv57b6RrLIrJP+88EK4cZ1e6JIne+nkKL/lspPiEskseDH7iuJGd?=
 =?us-ascii?Q?5xb6Surm5OuYs9Axuj+Oz1yT09SON6e5YsptrzqPAyi9t6sPKpPlNed+zpgi?=
 =?us-ascii?Q?53DsZz0QXl0P10N18GBedJi6oAVykw5T?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?L3xUl8PebdlsBhHtVqmWQT09HD8/0hRhf1DIBPDbEL4/OdmKesnIA380xiGH?=
 =?us-ascii?Q?YNd+htligFWsjabkAdUYWZMHpH9ohOFq0XzOBXnZUk7UjoIzsjTca0baTKhI?=
 =?us-ascii?Q?VIa6U/DRZ2bYkY0TUuvNEg4RUZVqGnf6XZ7Ae4LmcLRn2ngNEoW0KTljxkaN?=
 =?us-ascii?Q?xT37jkToW1+5x5gF7eOBxM+GijS7OqJjSmNm8PbIAmWWqYP6K0ggwqCyU6Ws?=
 =?us-ascii?Q?CUGSMsG5jvkKKUFcpfTE6EOv3oC3EfRRuXtFKRkj4ji5VU3iGJclWviryt3W?=
 =?us-ascii?Q?Y1XURxBWEwWVB7pJNBNLItm6n4wCy/TPwVHC+ib2ZOPWJatqHJDxJQWuFBqV?=
 =?us-ascii?Q?NHtFgGHhe40+8Gg1fNfLFi5WxVNaSqpE/cGWGz7pWlXxBMKjwq6VFTrKXra6?=
 =?us-ascii?Q?4nwTpYilif5VzNumIfCNMqlq9VvyGuBNtaFYP+twc8jwj9tg1ZzUkOMqFxNA?=
 =?us-ascii?Q?Z4Z5sRLaOO8V3DGb/NBt2pES/KYg4sjuXyQj44yQ9/yPmUopFqpG0/y49Erd?=
 =?us-ascii?Q?BChyrX0+IWAHGHvo83HaYLD1Hx00PN+gYMiokpkjlDeSg3JJmBNP0Gji0iG/?=
 =?us-ascii?Q?OiqeBiGQ+nh3lWJE35NGALaNA4qhD6FWI+Tir3qWF4KU273B88cmgaKTM76j?=
 =?us-ascii?Q?KHGxqidqRxCT2pZMlXQpxs63WWxLIjQ93gvMvfLWgleUSE9MXbov1fLq5UsW?=
 =?us-ascii?Q?ZEwa7RKyUXt4zF1ZHDTGJOMpdHeEgC7a/Ng6uP79MPMf53lptfbTaxRdiZ7W?=
 =?us-ascii?Q?3NEQ0m4p322kxTJHtJhCr1HXC3joJe9BtMsQ76SQXhiq6Vce1bn30AcaZDFQ?=
 =?us-ascii?Q?VgjYqla4WoPKcusaGSUl2yHODbT7EA1t75TkhcIBDOabUQuXCrELjiLcIGoN?=
 =?us-ascii?Q?0FrdhzudLuuDX993as3VhflnmMlFZBS5zftUlBXMvTTWxEhZvwCSzzndr1oO?=
 =?us-ascii?Q?mcKyYHP78VyUcQwzLrrE69zmdOUOquo268NKbc8av74czVCfYFeCjEoHunCP?=
 =?us-ascii?Q?YqhlYT69kcIZEgxOg1D5cbc4rPobEvJpoCI9DyqddTmqV4B+Vwy38I6NSogv?=
 =?us-ascii?Q?RuAsvDNemBNdCuOvaPHiC3HtfiJGmTAEmX9Do3knliDcC2htRfl4xTTm7nCu?=
 =?us-ascii?Q?NFzNovkbcJS3Q2NxpOCaU/hQfDCbXjFuUILbVKLYMd0v8AB2GaoR8XR4+2nx?=
 =?us-ascii?Q?93We1wFSuwHDEduaEQuazdNwoWbC2jkl6m06byXbKABQYO5AIGhVJwFhOWQI?=
 =?us-ascii?Q?rsYb4j3GWDHAWQJLbzkbzlCBWkjf25vvEIW5fsfRr6pcGOhZRnB2I224UqTs?=
 =?us-ascii?Q?EHRTyC04+zswefJpgQD06iepT8GCjTTqZx4DLeeqXu0tXtng9W0U2MQApIkK?=
 =?us-ascii?Q?DqRzNOLPAuwI9Qqy/7KsB69lBXjWbCyBjb7wRspUyNCJhVWstm5FHgGdba8s?=
 =?us-ascii?Q?/bDxm+NOWmcNW4KWBfveGKVcCesOpBKNa2TA625SOGH8sb+uXXxOS2Rt9uVa?=
 =?us-ascii?Q?4XimLYzdFaqKAbv3/diJM7/fVGc5phDeoYJEe3OcwGlP6y/h9qZ7fUs9IZ9I?=
 =?us-ascii?Q?HMDovvuZllemAyuliLsXCEew5Sq3fZaDf2lir33nwHCJe4hupO8LvoX66wf1?=
 =?us-ascii?Q?gQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	B+iyiUSP+tIbWyue4OaZTX/8a8K8coQJi9t4r3bbs/cCRX3cw0P1fvVeHLqOs9+nPFIPbfpEiDRmxuf9p/tFYjQsB8nAGc0zlegikUkiLxZlrRlD90JsH79le+chnkF3iEAl88ziWw2vi6qU57xgeqIXDXGzL+EYB5XnqHosqrEEYIH4LvC7m9o56T1cpqzTnec5yQLZrOwVfvT59HtdsZ4NPreE7CevCLnUWv//NykI3z2HoFM4cqkUhmiKiUdQkeduwxeLaC3kDFLBtWIYgWdAYb2As3bVNjBuCgqxIgK2C+xdWlcBJ9retkaC/Vkkdruj930sigjyzgJhlHTbndiYPfcnOAhemhbs/VySKIPNWy6bIEDfIaOvE+ALcXT5xMgOWUXcJljavKRHxZUB0QcEhZJK37gjsIiGpFGeoLrsLCl5ob7w1D9p/vMLQDogNaf8eEihqnER2b2b19RlI69+NwNtI5MOYQ9+P1rWQZdTn+c3sXAijAGIR/Pz+gnLTvD9OzVjqR83UG4DJguh61p64rQt2s6LNTkRj5rCvktPIBT06WvppscxfA6ipzzQHy/VMbcbwComyhVunlbC66OAh8ler9D/FP6RVg8zbv8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8c0cff1-3120-4ff1-8d15-08de1ee99486
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2025 17:09:30.3061
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QcP+huCDNpWAVbdPvhXNAjsIpG3CSgFyyywQRkdwYDJPfiK9XM/3na4l9rmuRmwz3vU8N1vsRUTxAETdht2LygvpqYQYiCEv8fRr1HgdQlM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF04D2D7FA7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-08_04,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511080138
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDEzNCBTYWx0ZWRfX4kQt5gqNkoRs
 /XxHG3AXFt2w6S+LEYh11WU0eW1zrsa1nr2F1YcZwq44DPkDE7NR/NDh3LkbkADkP43Xg7a/beR
 uJk5jXD8/mmq1oLAMoAMfM6PMOkZBFzkMV8E6kVj7Sa2zQxrnqFAixK5d5IMIKDEs7j4CFVv+wb
 y10tmwzD5RLQdA2cvt/fTn3DV2UBZJBA9XQOmyHEs2TgtUUfLss2tb+50+DX/QfiPul3U40VsLr
 3JW6x5RzMfK2zCqS4S4E1XA2H/CE+dj7xYfECsPBxTK9a+jGtC2Kf436iTTrKcrCfwF0ETTgFjH
 n54nWDBr10lRUZVSQoLyC+2336gk4mlUbqCeSGH2D9adREG+0D5Cs58KAH+w3hgbBnE6T++ggpQ
 zegP4uhjoLjORfL9JfrJRICeSruZpA==
X-Proofpoint-ORIG-GUID: 64lNaFGdsw4FcKQtvyJueusz5VZ3ZkB7
X-Authority-Analysis: v=2.4 cv=U4ufzOru c=1 sm=1 tr=0 ts=690f7951 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=gaN7zjf0O2erDMybN6AA:9 a=UhEZJTgQB8St2RibIkdl:22 a=Z5ABNNGmrOfJ6cZ5bIyy:22
 a=QOGEsqRv6VhmHaoFNykA:22
X-Proofpoint-GUID: 64lNaFGdsw4FcKQtvyJueusz5VZ3ZkB7

We do not need to have explicit helper functions for these, it adds a level
of confusion and indirection when we can simply use software leaf entry
logic here instead and spell out the special huge_pte_none() case we must
consider.

No functional change intended.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 fs/proc/task_mmu.c      | 19 +++++----
 include/linux/hugetlb.h |  2 -
 mm/hugetlb.c            | 91 +++++++++++++++++------------------------
 mm/mempolicy.c          | 17 +++++---
 mm/migrate.c            | 15 +++++--
 5 files changed, 69 insertions(+), 75 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 6cb9e1691e18..3cdefa7546db 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -2499,22 +2499,23 @@ static void make_uffd_wp_huge_pte(struct vm_area_struct *vma,
 				  unsigned long addr, pte_t *ptep,
 				  pte_t ptent)
 {
-	unsigned long psize;
+	const unsigned long psize = huge_page_size(hstate_vma(vma));
+	softleaf_t entry;
 
-	if (is_hugetlb_entry_hwpoisoned(ptent) || pte_is_marker(ptent))
-		return;
+	if (huge_pte_none(ptent))
+		set_huge_pte_at(vma->vm_mm, addr, ptep,
+				make_pte_marker(PTE_MARKER_UFFD_WP), psize);
 
-	psize = huge_page_size(hstate_vma(vma));
+	entry = softleaf_from_pte(ptent);
+	if (softleaf_is_hwpoison(entry) || softleaf_is_marker(entry))
+		return;
 
-	if (is_hugetlb_entry_migration(ptent))
+	if (softleaf_is_migration(entry))
 		set_huge_pte_at(vma->vm_mm, addr, ptep,
 				pte_swp_mkuffd_wp(ptent), psize);
-	else if (!huge_pte_none(ptent))
+	else
 		huge_ptep_modify_prot_commit(vma, addr, ptep, ptent,
 					     huge_pte_mkuffd_wp(ptent));
-	else
-		set_huge_pte_at(vma->vm_mm, addr, ptep,
-				make_pte_marker(PTE_MARKER_UFFD_WP), psize);
 }
 #endif /* CONFIG_HUGETLB_PAGE */
 
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 2387513d6ae5..457d48ac7bcd 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -274,8 +274,6 @@ void hugetlb_vma_lock_release(struct kref *kref);
 long hugetlb_change_protection(struct vm_area_struct *vma,
 		unsigned long address, unsigned long end, pgprot_t newprot,
 		unsigned long cp_flags);
-bool is_hugetlb_entry_migration(pte_t pte);
-bool is_hugetlb_entry_hwpoisoned(pte_t pte);
 void hugetlb_unshare_all_pmds(struct vm_area_struct *vma);
 void fixup_hugetlb_reservations(struct vm_area_struct *vma);
 void hugetlb_split(struct vm_area_struct *vma, unsigned long addr);
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index a74cde267c2a..b702b161ab35 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5552,32 +5552,6 @@ static void set_huge_ptep_maybe_writable(struct vm_area_struct *vma,
 		set_huge_ptep_writable(vma, address, ptep);
 }
 
-bool is_hugetlb_entry_migration(pte_t pte)
-{
-	swp_entry_t swp;
-
-	if (huge_pte_none(pte) || pte_present(pte))
-		return false;
-	swp = pte_to_swp_entry(pte);
-	if (is_migration_entry(swp))
-		return true;
-	else
-		return false;
-}
-
-bool is_hugetlb_entry_hwpoisoned(pte_t pte)
-{
-	swp_entry_t swp;
-
-	if (huge_pte_none(pte) || pte_present(pte))
-		return false;
-	swp = pte_to_swp_entry(pte);
-	if (is_hwpoison_entry(swp))
-		return true;
-	else
-		return false;
-}
-
 static void
 hugetlb_install_folio(struct vm_area_struct *vma, pte_t *ptep, unsigned long addr,
 		      struct folio *new_folio, pte_t old, unsigned long sz)
@@ -5606,6 +5580,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 	unsigned long npages = pages_per_huge_page(h);
 	struct mmu_notifier_range range;
 	unsigned long last_addr_mask;
+	softleaf_t softleaf;
 	int ret = 0;
 
 	if (cow) {
@@ -5653,16 +5628,16 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 		entry = huge_ptep_get(src_vma->vm_mm, addr, src_pte);
 again:
 		if (huge_pte_none(entry)) {
-			/*
-			 * Skip if src entry none.
-			 */
-			;
-		} else if (unlikely(is_hugetlb_entry_hwpoisoned(entry))) {
+			/* Skip if src entry none. */
+			goto next;
+		}
+
+		softleaf = softleaf_from_pte(entry);
+		if (unlikely(softleaf_is_hwpoison(softleaf))) {
 			if (!userfaultfd_wp(dst_vma))
 				entry = huge_pte_clear_uffd_wp(entry);
 			set_huge_pte_at(dst, addr, dst_pte, entry, sz);
-		} else if (unlikely(is_hugetlb_entry_migration(entry))) {
-			softleaf_t softleaf = softleaf_from_pte(entry);
+		} else if (unlikely(softleaf_is_migration(softleaf))) {
 			bool uffd_wp = pte_swp_uffd_wp(entry);
 
 			if (!is_readable_migration_entry(softleaf) && cow) {
@@ -5681,7 +5656,6 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 				entry = huge_pte_clear_uffd_wp(entry);
 			set_huge_pte_at(dst, addr, dst_pte, entry, sz);
 		} else if (unlikely(pte_is_marker(entry))) {
-			const softleaf_t softleaf = softleaf_from_pte(entry);
 			const pte_marker marker = copy_pte_marker(softleaf, dst_vma);
 
 			if (marker)
@@ -5739,9 +5713,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 				}
 				hugetlb_install_folio(dst_vma, dst_pte, addr,
 						      new_folio, src_pte_old, sz);
-				spin_unlock(src_ptl);
-				spin_unlock(dst_ptl);
-				continue;
+				goto next;
 			}
 
 			if (cow) {
@@ -5762,6 +5734,8 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 			set_huge_pte_at(dst, addr, dst_pte, entry, sz);
 			hugetlb_count_add(npages, dst);
 		}
+
+next:
 		spin_unlock(src_ptl);
 		spin_unlock(dst_ptl);
 	}
@@ -6770,8 +6744,10 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 	ret = 0;
 
 	/* Not present, either a migration or a hwpoisoned entry */
-	if (!pte_present(vmf.orig_pte)) {
-		if (is_hugetlb_entry_migration(vmf.orig_pte)) {
+	if (!pte_present(vmf.orig_pte) && !huge_pte_none(vmf.orig_pte)) {
+		const softleaf_t softleaf = softleaf_from_pte(vmf.orig_pte);
+
+		if (softleaf_is_migration(softleaf)) {
 			/*
 			 * Release the hugetlb fault lock now, but retain
 			 * the vma lock, because it is needed to guard the
@@ -6782,9 +6758,12 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 			migration_entry_wait_huge(vma, vmf.address, vmf.pte);
 			return 0;
-		} else if (is_hugetlb_entry_hwpoisoned(vmf.orig_pte))
+		}
+		if (softleaf_is_hwpoison(softleaf)) {
 			ret = VM_FAULT_HWPOISON_LARGE |
 			    VM_FAULT_SET_HINDEX(hstate_index(h));
+		}
+
 		goto out_mutex;
 	}
 
@@ -7166,7 +7145,9 @@ long hugetlb_change_protection(struct vm_area_struct *vma,
 	i_mmap_lock_write(vma->vm_file->f_mapping);
 	last_addr_mask = hugetlb_mask_last_page(h);
 	for (; address < end; address += psize) {
+		softleaf_t entry;
 		spinlock_t *ptl;
+
 		ptep = hugetlb_walk(vma, address, psize);
 		if (!ptep) {
 			if (!uffd_wp) {
@@ -7198,15 +7179,23 @@ long hugetlb_change_protection(struct vm_area_struct *vma,
 			continue;
 		}
 		pte = huge_ptep_get(mm, address, ptep);
-		if (unlikely(is_hugetlb_entry_hwpoisoned(pte))) {
-			/* Nothing to do. */
-		} else if (unlikely(is_hugetlb_entry_migration(pte))) {
-			softleaf_t entry = softleaf_from_pte(pte);
+		if (huge_pte_none(pte)) {
+			if (unlikely(uffd_wp))
+				/* Safe to modify directly (none->non-present). */
+				set_huge_pte_at(mm, address, ptep,
+						make_pte_marker(PTE_MARKER_UFFD_WP),
+						psize);
+			goto next;
+		}
 
+		entry = softleaf_from_pte(pte);
+		if (unlikely(softleaf_is_hwpoison(entry))) {
+			/* Nothing to do. */
+		} else if (unlikely(softleaf_is_migration(entry))) {
 			struct folio *folio = softleaf_to_folio(entry);
 			pte_t newpte = pte;
 
-			if (is_writable_migration_entry(entry)) {
+			if (softleaf_is_migration_write(entry)) {
 				if (folio_test_anon(folio))
 					entry = make_readable_exclusive_migration_entry(
 								swp_offset(entry));
@@ -7233,7 +7222,7 @@ long hugetlb_change_protection(struct vm_area_struct *vma,
 			if (pte_is_uffd_wp_marker(pte) && uffd_wp_resolve)
 				/* Safe to modify directly (non-present->none). */
 				huge_pte_clear(mm, address, ptep, psize);
-		} else if (!huge_pte_none(pte)) {
+		} else {
 			pte_t old_pte;
 			unsigned int shift = huge_page_shift(hstate_vma(vma));
 
@@ -7246,16 +7235,10 @@ long hugetlb_change_protection(struct vm_area_struct *vma,
 				pte = huge_pte_clear_uffd_wp(pte);
 			huge_ptep_modify_prot_commit(vma, address, ptep, old_pte, pte);
 			pages++;
-		} else {
-			/* None pte */
-			if (unlikely(uffd_wp))
-				/* Safe to modify directly (none->non-present). */
-				set_huge_pte_at(mm, address, ptep,
-						make_pte_marker(PTE_MARKER_UFFD_WP),
-						psize);
 		}
-		spin_unlock(ptl);
 
+next:
+		spin_unlock(ptl);
 		cond_resched();
 	}
 	/*
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 01c3b98f87a6..dee95d5ecfd4 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -768,16 +768,21 @@ static int queue_folios_hugetlb(pte_t *pte, unsigned long hmask,
 	unsigned long flags = qp->flags;
 	struct folio *folio;
 	spinlock_t *ptl;
-	pte_t entry;
+	pte_t ptep;
 
 	ptl = huge_pte_lock(hstate_vma(walk->vma), walk->mm, pte);
-	entry = huge_ptep_get(walk->mm, addr, pte);
-	if (!pte_present(entry)) {
-		if (unlikely(is_hugetlb_entry_migration(entry)))
-			qp->nr_failed++;
+	ptep = huge_ptep_get(walk->mm, addr, pte);
+	if (!pte_present(ptep)) {
+		if (!huge_pte_none(ptep)) {
+			const softleaf_t entry = softleaf_from_pte(ptep);
+
+			if (unlikely(softleaf_is_migration(entry)))
+				qp->nr_failed++;
+		}
+
 		goto unlock;
 	}
-	folio = pfn_folio(pte_pfn(entry));
+	folio = pfn_folio(pte_pfn(ptep));
 	if (!queue_folio_required(folio, qp))
 		goto unlock;
 	if (!(flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL)) ||
diff --git a/mm/migrate.c b/mm/migrate.c
index 3b6bd374157d..48f98a6c1ad2 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -515,16 +515,18 @@ void migration_entry_wait(struct mm_struct *mm, pmd_t *pmd,
 void migration_entry_wait_huge(struct vm_area_struct *vma, unsigned long addr, pte_t *ptep)
 {
 	spinlock_t *ptl = huge_pte_lockptr(hstate_vma(vma), vma->vm_mm, ptep);
+	softleaf_t entry;
 	pte_t pte;
 
 	hugetlb_vma_assert_locked(vma);
 	spin_lock(ptl);
 	pte = huge_ptep_get(vma->vm_mm, addr, ptep);
 
-	if (unlikely(!is_hugetlb_entry_migration(pte))) {
-		spin_unlock(ptl);
-		hugetlb_vma_unlock_read(vma);
-	} else {
+	if (huge_pte_none(pte))
+		goto fail;
+
+	entry = softleaf_from_pte(pte);
+	if (softleaf_is_migration(entry)) {
 		/*
 		 * If migration entry existed, safe to release vma lock
 		 * here because the pgtable page won't be freed without the
@@ -533,7 +535,12 @@ void migration_entry_wait_huge(struct vm_area_struct *vma, unsigned long addr, p
 		 */
 		hugetlb_vma_unlock_read(vma);
 		migration_entry_wait_on_locked(pte_to_swp_entry(pte), ptl);
+		return;
 	}
+
+fail:
+	spin_unlock(ptl);
+	hugetlb_vma_unlock_read(vma);
 }
 #endif
 
-- 
2.51.0


