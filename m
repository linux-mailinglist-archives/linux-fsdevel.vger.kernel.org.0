Return-Path: <linux-fsdevel+bounces-67754-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8121EC49815
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 23:23:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26EF8188C6A5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 22:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D966830216F;
	Mon, 10 Nov 2025 22:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OFPbnqOZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yZd9Ozkr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E272ED16D;
	Mon, 10 Nov 2025 22:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762813400; cv=fail; b=Y0epPGOHd7aH7c3K8TC2m4ZrY6RrdFIuXq5AM8wu+3riftXgp51i+HYQiFcY/qoSsBd5ttFktt9V1rVJOEu9LX/g/Jb/+1TN5j9BwW/Nukhmm2WMJUQergtmmzuuI4NWG0JU0gn1WxD3yoGW6SBK8wyGeda0b/OQu2Dh76p/qs0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762813400; c=relaxed/simple;
	bh=Jc7k15MXVqD+LodAv3sGe3ypLfG9f5hKPjGmdnE6+KA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TDNT/Yt0hB3X/yVMuDzPIL4IJDfTDJ61xsrinw0RGpKH0RJaXvktF4EIppQTThI7ChFqBTwVfExRmcGeObQ8l2xEvcfyq44zBu7inMF7XJWolKbBzTRKMtnLHyUkiMm2C2Ag6btgnRpS+hf1iF2KEMUpAy0ur8WXnowRACeztVQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OFPbnqOZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yZd9Ozkr; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AAM0dN4019647;
	Mon, 10 Nov 2025 22:21:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=8WOrh/xELmUWEKs0VQab4I3hnqf3OQgLiTzmuIkkR3k=; b=
	OFPbnqOZyE2j3zc4eG5Cvub3C1KpAD7c2ow6ojvnYpaWpkG9qQz8oLi+hb8Nn3OO
	KYu69x4TJyNTIVJZcEwGWc9DCMXmx+OKautBSIDy38no93QfnUB20bVOBtwxabSM
	0X96UiZW20rDQN4GI0hk2cihfM06zomSEFMR5J8ObWgAs5nOcLwhgh2e6D41hzsT
	SBDqBuN6OV/75D0hzm4gHTIKUKKu0nrIRnaHm24ItiQo2tSW2pH0ARowOStEx89I
	E3oBk629eyQN5r5ytKcQ514I6zI+ep1olky9ET/vRH80MXsb5gwHFFpFNdeBTxyM
	DHVOhxcXrhmuSY2jX9lYQw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4abqvfg4ac-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Nov 2025 22:21:54 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AALo2I6040096;
	Mon, 10 Nov 2025 22:21:53 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010061.outbound.protection.outlook.com [52.101.201.61])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9va8rypg-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Nov 2025 22:21:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IiwFLZePMaogNavHlN5GZDGAeOJALIzNTxI+X73+CpmsGya4rHtBr4b4IcwC1u7e6ayDTl/OaBRHvIBBvgAht/3mRaOaBYBAJqU36DzyxB+ns09Bf8EaR0pNZBjsJS7ImAG8UFDZjiqKvyWfWCGe7Uz2ffcCfL/De0b1wjN+XT0+eFgU7BTtfXXqom4yWmfey4AbOE2ro+4kKSMLgDFYGFxtiBVoYkcP9ufu+Ujgz18KPQcFSTb+k+5qK1/fnFvglLjh8fGqwqQfa6h5x+aTkLYtk2iCMzWH+XNZF7iDsY09LG1nNUXF6emy4C8HYWdAwvf204jHOTU+nk6+2wMADA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8WOrh/xELmUWEKs0VQab4I3hnqf3OQgLiTzmuIkkR3k=;
 b=DfmuLtim4P6jZSM88S8MocJkMcueduQ1coKN1YS81ZVCHxlmb1zSfHK7cAWQInja/M39nmQRdnkko0vES57tBsynvRVbGBK3krP/Pyr8qZ7emFdVdjbGY1NlKMqikFbnKCQlBrt60N+G6EcQQA8vTz4WjVVe1jZaSuLNAuVUBkOhVeq0yqptut8O9VQWqmRP40LQElQSNF8YSNvE/M4KCdUqqqtByq3EvItwHMNZNfI60W+hZ2PAbxRVciBnhru+mA9aEvKH16m+Smx7B1Gfe+lTr2VKYB/vOT9VkLoQnIEWBQRxY6DFxm3DWv5HkjhimYO+p61k+8adwZpxYivBDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8WOrh/xELmUWEKs0VQab4I3hnqf3OQgLiTzmuIkkR3k=;
 b=yZd9Ozkr22tb3gd8HpFpvml9tIzkWF2LAiGOaP2uWdg8Md0ky9+sAUIXOQXcuF+Gf+mirXdXHr4OUuwzpbQgPTBiBnrbF+Lm6fv84pQoBBZ2ZQzOOz11iHdu4pKpCX08STLrL2ZGhwbW0yq4rRRbqK50IRTHSAE+RabuZRi1haI=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by IA0PR10MB7622.namprd10.prod.outlook.com (2603:10b6:208:483::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 22:21:48 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9298.010; Mon, 10 Nov 2025
 22:21:48 +0000
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
Subject: [PATCH v3 05/16] mm: use leaf entries in debug pgtable + remove is_swap_pte()
Date: Mon, 10 Nov 2025 22:21:23 +0000
Message-ID: <222f352e7a99191b4bdfa77e835f2fc0dd83fa72.1762812360.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1762812360.git.lorenzo.stoakes@oracle.com>
References: <cover.1762812360.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0009.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:62::21) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|IA0PR10MB7622:EE_
X-MS-Office365-Filtering-Correlation-Id: a5cda8e4-a770-47c6-7492-08de20a78a24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bryGD8yEFNwvoM3Z+8m0FTs+qB1OEVSsUz0X6yMktJI9BKV/V923G6n/1hD8?=
 =?us-ascii?Q?ianZKd/5Mfi9T8oGwCL976/IdrTFmq7CY+hIbdOsF1fck0hPWTcLHrD2ZDPF?=
 =?us-ascii?Q?mDvGFa0qc6PWDpskH1//VTjQT1a85mhTV3qyuGXBN35DdBMsFycDAkUB1jXb?=
 =?us-ascii?Q?mT0QpfjO4uwxuW+hAyfRf+coEi3UdkehusFxGUJNIXaxLl3CenyncJW0tjOz?=
 =?us-ascii?Q?ZSg0PpfAuuHiZSYhx39NUXuCg5Sqha/7EUxRpmPQG9F8kdM0iebtZBJMrmOh?=
 =?us-ascii?Q?qOKolo12pzBZL1QsiWXKcFeDdFcBjo3f+mcmbH9kkvktGdiyI+N7NxsEKwjm?=
 =?us-ascii?Q?7d8wmrno2ab4X4pgK0GRiwpoq5HfOV4Bw7gUlYZBhik/hXhd26ckW34gZ3Un?=
 =?us-ascii?Q?9GmFzHwMX/SgJ//ADQy/+u6Bi9aSD+TDml/8vh1C+1fc+5Pm+oR5ybM29HlB?=
 =?us-ascii?Q?fBSHNEjr5dytPdENGrwYe8CX/48yGRjtcMdIGq+NUA9WvGVLh2tOmXEetj/l?=
 =?us-ascii?Q?zaqZR1veraM8CtNkjPg7oYo0MYlybR61KpfuJLi0rL3v37dp2g8DNcPvgnrj?=
 =?us-ascii?Q?F6XIHLIyG6wIkVRCINz0Q3Cmd3yWebFHkB8Lk/Lyv8+/TdMVNF8JbbtYbXMl?=
 =?us-ascii?Q?fG9fulzFLYD74kfDPnFn1HiwEe8brXhG1eR+bzgQG1MT7xPXPVudBxdIuNXP?=
 =?us-ascii?Q?HCVQram08KkAfb2Ks9r7dsLC7ooxKto5Z/Na5nDh9ryqc9CC7qkEiew8jE/n?=
 =?us-ascii?Q?j/fB9zmiqx1fxFooGfouL1Ys0S2iKxFnhRYzlhoe/JuyVgeGFmQ8M2Qavpj9?=
 =?us-ascii?Q?g+mhBu/rF+POSMqp0NXtaf1pZuQfbaqYbaqgjZhFhRltex4l8HVSwSWxwK9E?=
 =?us-ascii?Q?6O9YzyrQHzXoa5+GIi+bcKKJURYDo8rQFwr0YuC1BmmdUqMisePK5Hf98/nB?=
 =?us-ascii?Q?K8UikFMvdnL8/oRA0S57ONk/NiXlmlJNF6FiL7emeATmkD6ozmjcndRuK4fk?=
 =?us-ascii?Q?14eP+ZVOU7b1mCbBC9KhakJrwBGdfHu1ew3Zdyh/d5WwptXHehujUhnPK5ak?=
 =?us-ascii?Q?aN3QmSiLD+o/pc2r11+KZBn8D+ixDa6CwyLVeodenJNDbi8lBmuNwrvLlu7v?=
 =?us-ascii?Q?uktA2nuAAABUqpE7gbfD1bsiYLIexRp5ESX+R/LqQI+dCOfk8jVkQ4RuZ10R?=
 =?us-ascii?Q?fysylVeG+gtb03rxz/AKe5K1ePKnWxkWXq9LrDmgzKxcDn2sgO/KxurH1K5W?=
 =?us-ascii?Q?XpaUDwEBuQc99kxN4JPScpkOGTkazUvyF7rsC8kY4ixXAYJ3t43UC7TABdKF?=
 =?us-ascii?Q?1/qq1HsWeKH02ph+DgCfCVo2OJEeo1IEOvMpW2Z/6SBoCsmShby1Oa3AprhD?=
 =?us-ascii?Q?BDw0Qs4MP1IdKxh8AzxScTEhmyQyqCSp7PNPTxJU734uOe5HIIlp65XLGg4m?=
 =?us-ascii?Q?1Zf6XhAd/0IEDW+kKRhLVbrQdiC+zRn9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RZtgJLd3yXAgfwltltU3wbe3CnP6cgBU0eM/qE1mSsrALTy04YDSrDC/U/vb?=
 =?us-ascii?Q?Aj/PpVy+WnROgq2mcvBzoWtpoYyKeiUvAJvPxYspsQzwYr5iICM1tO/Q5Bqv?=
 =?us-ascii?Q?JI0yxXM47Ucz+0qfMiXjoBfQ+KGwMVxI9+sFahfsGCe97DPAjk4IFHBnUpiO?=
 =?us-ascii?Q?23MssIz04uYxO2q5CxN1JxX/ZZhIyK7mkqNLp73n1cuZRNH1JrbZu0KFtLbH?=
 =?us-ascii?Q?U/VH8x6uPIspIelvfio+WZSPedYWen8HKU0dxGMO0e30A6W0W9QkLZu1aUF2?=
 =?us-ascii?Q?5i8b3ApoPwvkh2h/49iUc207Hy6/ior+geconcZfrOkZ4l5w1DpyjjFyakOo?=
 =?us-ascii?Q?xlJzBlbBuz0b/zQ2KcuGy6frImgI2i6B0VObb1iAGEKFJzggde8NILUyHFKZ?=
 =?us-ascii?Q?a3eETrHXNREw6ANtg75lcY3rGwsPWgsKrpXKMfVbylZJ4ydfPjGfHhzryspR?=
 =?us-ascii?Q?3ikeXaSLVdFbMeZi2KcLX2K8oIGoUYy0/mbO2jbUjMMlgoCrhb34DHRHoK7M?=
 =?us-ascii?Q?p96ao1IQEw7yTINnwJMk80BAu3V3mBktc+lsTxVJVQFoXzpFg+Q6Hcf5PLpJ?=
 =?us-ascii?Q?SrOv0NB1o0q90hGUtNnSXG852Hydo/TmJfX6AOjPdm719FZOWzQTvdB+LmuX?=
 =?us-ascii?Q?9Y0OJSwTHlICybzUKxo/g8dEnvKuk0l54bFzK+G4la59zJ1Beo8ahuNWWs3t?=
 =?us-ascii?Q?nSXPIXTU9R6Mj9yHOoQhv/5EU/Xy4p2cp/6uf4aafXOwPHtVgvux7Tm9r/fC?=
 =?us-ascii?Q?QwEqXUAdcNRB8HTBpDiOjhvAIg4VuyYxDzcoexstkiI6+3waCU2RqnkclZR0?=
 =?us-ascii?Q?Ec7YQYx2KIaIyArrQoFp92VklSXORG64BxQw+EECNdv2xuqUWiRpSaos4O6+?=
 =?us-ascii?Q?dlUkFXdMUTv3boD+QmgI1lecfWoNb/UfVTph/3l816waAR6MyDFiA4f0C2wB?=
 =?us-ascii?Q?NRZ+xO6hZwcYqimnUCX8l8m4kyenZRNmS5i7opEi5jqIE89Tb2kQXWf/Jddm?=
 =?us-ascii?Q?tMWvKvWJXw2gal9ZygAgMDUTjeNMRLLe7dGnjc9k/FpLLL+5gDv7tnTmXJHv?=
 =?us-ascii?Q?lVSoXu9qD0Y/S8mO6ISqDXVcVIwJLlYp2SOnCaz8lxOqy3etAp59hX0saCO9?=
 =?us-ascii?Q?pWGlSXVsUIRmuU2SAyKdHjAb5kOLM4NJQAyoI2PHkVDDa9i/bEHr7RMn98Q/?=
 =?us-ascii?Q?Pk3SzYdPcfFN+EF/6U2nT7uH9gTWh/tcftjDKuK3uS+gBytDRTwBbvOjFGof?=
 =?us-ascii?Q?8wbdLJO6I1sHrm6TuakL9dT4Pr+BQrNGAXOUF7kpgxCQAvNWfjpykUC0pejS?=
 =?us-ascii?Q?SQEgeQAPN1wMC3XBKUa/ufouVAAJxg1Qk9QuLiNZe/EdwC/HlBsrZ3yNrgqd?=
 =?us-ascii?Q?C19FYTGf7XNsNqSA/35w2YRBeh6xb3y4Chb+uWeyNIRo+zEBbk8PK66xvTQM?=
 =?us-ascii?Q?Z5lklImKlcT2LyyJ4mB0D6OJjam0Xz7kqt0gB5ud9qRIFBR/Gpbjf3TTJJPd?=
 =?us-ascii?Q?6LCVz/HpretuphnzmdR5ui5bDeFZqsf3rwzcD9JmfOzj9+K5Eh13sc8EEuiJ?=
 =?us-ascii?Q?ot7+DKcvRH8AGi/TSmy1nuoysv85jFVowzOU+tbyxha7DC3GEF8njECTy8NL?=
 =?us-ascii?Q?5w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wKeta1OM0CZ3mLA8RigGHHwrZexLLFuMMeVowF63E3Q/VEYZgx1h5pyMuC1/GHIbUIad0EDUt9eQt9v2LZjrkEZ71QBGFvkZddQp9vQjrJMjhExFFEfW7j/ggT8p4/18263N62TMBuJgbeMNSu3/STfzXAUufZmhAojApG8uUR1SxhjpJXjtCXp+3TYHeVFkUxwBqe4suPcApaBefAyQXYvqNy8c0+rlTuuurrOwZguJrSbuBmwXwrlNQ4gjadjxvg6wTmjIs2fqKF0IfmtRoKnChE0aARoijtbxyFgmlDXuxKpLLtMEhGHxEMwUbYdF5RBc+0k6tTODqQyM8kLgozZE04xLVNjmjdZYzGe8rZOAKOEzwM6oJHThCmaPtMP6DX5r14gGbiKP5Ehh0ruAZzS/k4uMyaC7ARailAisb3PMiJIHIJfycvv9ypPDof0xmS7PghjVyCoIZNy6srgtEHfZrBe1CAvshcAhu766LCTw7SyruYkUT+DFaOrb1A4YtzEGNblV4mCl8DasPHddVtVhMGN82eWBEKMo8kcvWRhS5K0kEoK+Nf7bU+NXm+E4ugAtYTkOtbg4Ov9dpk7SZXZ2jog8QwIUOMF8jyLo8gM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5cda8e4-a770-47c6-7492-08de20a78a24
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 22:21:48.4038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IC6/3MiK+ygU5KpHP/7WlkS+aQ4jK5bQsqEEGl7xjoidQBLJm6yzjCd9MKSV24ShmggfzYyHMF9rRBu8S0l3zwz0WVPWGtJbwlrI/lFQpos=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7622
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_07,2025-11-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511100190
X-Proofpoint-GUID: V0ENqnUuisHv8T6Mx46qZqiSHkNZf-TI
X-Authority-Analysis: v=2.4 cv=FaY6BZ+6 c=1 sm=1 tr=0 ts=69126582 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=JfhMdzgkenBfAv4L-EYA:9
X-Proofpoint-ORIG-GUID: V0ENqnUuisHv8T6Mx46qZqiSHkNZf-TI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDE4MiBTYWx0ZWRfX2RxC8/wkmbD3
 5zRrvGYTsaK1CaWHOVcrmTDdM3X8nNlffmBdKaDZzIUDYHfZdlqIiHxK77E6DwKC7hvj+lrQLFe
 heXoK/FaKbFDaxdWq2yZphfa2cQlEdMcjxsa+P0LpprF6AUIxUZ4Pss4u/XtpT9BZ55kN+6VO8P
 IKTf1kplZG93G+780nbro2AGAqlhp328xmYvaPGL/y8zcipAZrzuyEu34u79NoU5XnH9aV2qUWC
 GiwevrGcU9lQHtl6rockmt8gHpDyI/U9jzMutULD8DyPSF8SyHNnLwcPssOQ6RZkFZevmkXSznF
 sYaUOqfZ4NczYK+QOqMg+j94LUqbGO0SdwBP+GvhOORFgioxu6cB1P+cKQaqhN/rcwbD4xJl6ym
 AhCqvePMSvYusA7UnN7o2q/PLkI78A==

Remove invocations of is_swap_pte() in mm/debug_vm_pgtable.c and use
softleaf_from_pte() and softleaf_is_swap() as necessary to replace this
usage.

We update the test code to use a 'true' swap entry throughout so we are
guaranteed this is not a non-swap entry, so all asserts continue to operate
correctly.

With this change in place, we no longer use is_swap_pte() anywhere, so
remove it.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 include/linux/swapops.h |  6 ------
 mm/debug_vm_pgtable.c   | 39 ++++++++++++++++++++++++---------------
 2 files changed, 24 insertions(+), 21 deletions(-)

diff --git a/include/linux/swapops.h b/include/linux/swapops.h
index 0a4b3f51ecf5..a66ac4f2105c 100644
--- a/include/linux/swapops.h
+++ b/include/linux/swapops.h
@@ -120,12 +120,6 @@ static inline unsigned long swp_offset_pfn(swp_entry_t entry)
 	return swp_offset(entry) & SWP_PFN_MASK;
 }
 
-/* check whether a pte points to a swap entry */
-static inline int is_swap_pte(pte_t pte)
-{
-	return !pte_none(pte) && !pte_present(pte);
-}
-
 /*
  * Convert the arch-dependent pte representation of a swp_entry_t into an
  * arch-independent swp_entry_t.
diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index 055e0e025b42..fff311830959 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -25,7 +25,7 @@
 #include <linux/random.h>
 #include <linux/spinlock.h>
 #include <linux/swap.h>
-#include <linux/swapops.h>
+#include <linux/leafops.h>
 #include <linux/start_kernel.h>
 #include <linux/sched/mm.h>
 #include <linux/io.h>
@@ -714,14 +714,16 @@ static void __init pte_soft_dirty_tests(struct pgtable_debug_args *args)
 static void __init pte_swap_soft_dirty_tests(struct pgtable_debug_args *args)
 {
 	pte_t pte;
+	softleaf_t entry;
 
 	if (!IS_ENABLED(CONFIG_MEM_SOFT_DIRTY))
 		return;
 
 	pr_debug("Validating PTE swap soft dirty\n");
 	pte = swp_entry_to_pte(args->swp_entry);
-	WARN_ON(!is_swap_pte(pte));
+	entry = softleaf_from_pte(pte);
 
+	WARN_ON(!softleaf_is_swap(entry));
 	WARN_ON(!pte_swp_soft_dirty(pte_swp_mksoft_dirty(pte)));
 	WARN_ON(pte_swp_soft_dirty(pte_swp_clear_soft_dirty(pte)));
 }
@@ -768,40 +770,47 @@ static void __init pmd_swap_soft_dirty_tests(struct pgtable_debug_args *args) {
 
 static void __init pte_swap_exclusive_tests(struct pgtable_debug_args *args)
 {
-	swp_entry_t entry, entry2;
+	swp_entry_t entry;
+	softleaf_t softleaf;
 	pte_t pte;
 
 	pr_debug("Validating PTE swap exclusive\n");
 	entry = args->swp_entry;
 
 	pte = swp_entry_to_pte(entry);
+	softleaf = softleaf_from_pte(pte);
+
 	WARN_ON(pte_swp_exclusive(pte));
-	WARN_ON(!is_swap_pte(pte));
-	entry2 = pte_to_swp_entry(pte);
-	WARN_ON(memcmp(&entry, &entry2, sizeof(entry)));
+	WARN_ON(!softleaf_is_swap(softleaf));
+	WARN_ON(memcmp(&entry, &softleaf, sizeof(entry)));
 
 	pte = pte_swp_mkexclusive(pte);
+	softleaf = softleaf_from_pte(pte);
+
 	WARN_ON(!pte_swp_exclusive(pte));
-	WARN_ON(!is_swap_pte(pte));
+	WARN_ON(!softleaf_is_swap(softleaf));
 	WARN_ON(pte_swp_soft_dirty(pte));
-	entry2 = pte_to_swp_entry(pte);
-	WARN_ON(memcmp(&entry, &entry2, sizeof(entry)));
+	WARN_ON(memcmp(&entry, &softleaf, sizeof(entry)));
 
 	pte = pte_swp_clear_exclusive(pte);
+	softleaf = softleaf_from_pte(pte);
+
 	WARN_ON(pte_swp_exclusive(pte));
-	WARN_ON(!is_swap_pte(pte));
-	entry2 = pte_to_swp_entry(pte);
-	WARN_ON(memcmp(&entry, &entry2, sizeof(entry)));
+	WARN_ON(!softleaf_is_swap(softleaf));
+	WARN_ON(memcmp(&entry, &softleaf, sizeof(entry)));
 }
 
 static void __init pte_swap_tests(struct pgtable_debug_args *args)
 {
 	swp_entry_t arch_entry;
+	softleaf_t entry;
 	pte_t pte1, pte2;
 
 	pr_debug("Validating PTE swap\n");
 	pte1 = swp_entry_to_pte(args->swp_entry);
-	WARN_ON(!is_swap_pte(pte1));
+	entry = softleaf_from_pte(pte1);
+
+	WARN_ON(!softleaf_is_swap(entry));
 
 	arch_entry = __pte_to_swp_entry(pte1);
 	pte2 = __swp_entry_to_pte(arch_entry);
@@ -1218,8 +1227,8 @@ static int __init init_args(struct pgtable_debug_args *args)
 
 	/* See generic_max_swapfile_size(): probe the maximum offset */
 	max_swap_offset = swp_offset(pte_to_swp_entry(swp_entry_to_pte(swp_entry(0, ~0UL))));
-	/* Create a swp entry with all possible bits set */
-	args->swp_entry = swp_entry((1 << MAX_SWAPFILES_SHIFT) - 1, max_swap_offset);
+	/* Create a swp entry with all possible bits set while still being swap. */
+	args->swp_entry = swp_entry(MAX_SWAPFILES - 1, max_swap_offset);
 
 	/*
 	 * Allocate (huge) pages because some of the tests need to access
-- 
2.51.0


