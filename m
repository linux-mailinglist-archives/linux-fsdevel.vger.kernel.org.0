Return-Path: <linux-fsdevel+bounces-67765-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CDC8C498E7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 23:29:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 131694EDD76
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 22:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 422C2346784;
	Mon, 10 Nov 2025 22:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nTjQ4+NP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fl7EL6/7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC573446A6;
	Mon, 10 Nov 2025 22:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762813466; cv=fail; b=HViEHrVwMyTEYIP8ffqLlqxCpaUaY6vlGDaCs+VljsFE6A/0oPJnePYFFYmFuu/A/CRU400dYZxMQLypdf19gXtvTTjWVdbflZk9YD1uslbhe9lJF7NQ0n98freJzUd+aaFMhezzQI26UHe2/zjCrJn82cHXJRjkEtDHkig2DQA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762813466; c=relaxed/simple;
	bh=gJ8zRazqzQ9hDxhtbg0qAlApDfcn449VuQ4f4oPaLcc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Fg79oaQKxq+iTnElp6TvM3ng0jKPAjgQ+1IimoBOtAGY/Cvfwe+dQGHEMa0tBpq17wi8soTZFCTWZXbWV48SYSvHfxTlfvI85TbXlldN4XZpnF4iiGKox403GITQG6QaKcmo3j2mfnhro7EPxb0yzU68s1vn0z2rhmiTyuWxcSM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nTjQ4+NP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fl7EL6/7; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AAMINsW025996;
	Mon, 10 Nov 2025 22:21:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=0JzEYXLZhk+XPgEC4WpeH2fagEy4AWaKQdESXVSnsms=; b=
	nTjQ4+NPSG4FKJmkSoPAiLvYB59zj/DTIOe3O4rbQSW3HO203zSRFiVTkfOK3XtI
	Wvmy702pTkoLwE1s72fE6SSuRbRDWnjEtEwa1yJp97Po3esismy4HsXEd4fbr/DE
	1pgWB1l4tDu/liSTEmlqV97IuslXSgc3m+GmP1l160WnWNYpJ7/S8z3+6zBmjg8s
	ZNTIelO9r+46K3MfFRCc/rNzJX3bAQ+tEqPdJ3s3ZsvacScKtFdz5A5b2Uu6jv7F
	mPLcMb2bvBqWQzpyqeE+H5cRO59CvfU80e34gFfoCNXuLcxAWSadLUf2YeGN7OFP
	FS81UA3eNTAdAeXO6H2mPw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4abr5vr2b1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Nov 2025 22:21:57 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AALo2IA040096;
	Mon, 10 Nov 2025 22:21:56 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010061.outbound.protection.outlook.com [52.101.201.61])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9va8rypg-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Nov 2025 22:21:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fGXyEQvgcjlpneja9tZkWei1iGykF+SqSpAcLv6BQhughEBf5reKUVsAAX1+CXE/s7nQqD9K+FH7rSWkO5kkRxIoynNkmymnvDb75Pus6xCXDTObHdCDeZk7apORNscICWkfB6OQ2BlNWB8B5+uoxShIQP6I4zgeOLlX7DFjXVrxwh2orbTO3zdzSQ+e6nDILOyYw6otPzJ4/G3EKg+kOEtz6CEm19tTTEq56FQ34xLHanrtuxAZsGf45voQyN1Bk1q+fobpTuI9Orpnq+mNio6hH7E/Wg7D3V575K9s/a55i71eOTf76U29GTXw0WyDmXxnQOx1derr2ujRVhMfug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0JzEYXLZhk+XPgEC4WpeH2fagEy4AWaKQdESXVSnsms=;
 b=sm9RxcmpmbfpdOYzDXGNVr4m1K21egRlNzGorb3tqs987lHUzjivB1WgSt2vY4ECJ+fPOVIOHRUjOv6bKDnfAPHRpUHuxhY9aKk2G2ov7r2WkJ7uMKT0Im8LjjP4sM50Dq+xXQVVWghUhfvo+FbjHPzERD6BzM6pO8OInwMfpCY8MFSbml36WiqF1SC9zG9ipOCKP9psa22GghU145JXBNIGZ56GE/10i3WAGrBNcmMrFdUj8GO/IfcNoTtDS4/z32nqaSYbaQ1Vz16sJdSuw4VUKxzj1pcGrH9BgXB6L4Lbh3fD9RGkYznCtatoc5FYA+TsdwTN+Ml8K0mUuMR+WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0JzEYXLZhk+XPgEC4WpeH2fagEy4AWaKQdESXVSnsms=;
 b=fl7EL6/7z+lhm9oTUH6kVdYzUsWgia2sox8RKUok5boDWMea4LBvtmHbmAhqZxV7MsV/9z/+SXhi8aX3lcixOBJVbL0j1wg+s4UCYHafYF4K43ugLkJHtDlVQp+nuhmy/GyRmNlnEF/gz9Ms1N2FZjnT1ibLGVPU7qZxlL1IZ3Y=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by IA0PR10MB7622.namprd10.prod.outlook.com (2603:10b6:208:483::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 22:21:52 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9298.010; Mon, 10 Nov 2025
 22:21:52 +0000
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
Subject: [PATCH v3 07/16] mm: avoid unnecessary use of is_swap_pmd()
Date: Mon, 10 Nov 2025 22:21:25 +0000
Message-ID: <8a1704b36a009c18032d5bea4cb68e71448fbbe5.1762812360.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1762812360.git.lorenzo.stoakes@oracle.com>
References: <cover.1762812360.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0100.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bc::12) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|IA0PR10MB7622:EE_
X-MS-Office365-Filtering-Correlation-Id: 1249e555-dc60-46be-801f-08de20a78c97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Q2aVa2f19MTK2T5KBmtVoeDLOYTKxanPoS5Md5EIXTcdsrEspf+WQxwM3uLl?=
 =?us-ascii?Q?VL16kfgtPxRYtPCoJUP9w5riu94xDEGeL2VhFZYY09PKnFJ645FaBXU+5gg/?=
 =?us-ascii?Q?ODXjvR1Zdi4AYc+PoQ9S3OEs7oueh12quF2PkNFhzhggyeEg2r/U+Co26zys?=
 =?us-ascii?Q?2ItzE13wuy4YYTSPtZjF0e3ztYetYG/ACwP6Wc2aasDpsp//fI4iGGCuG2gy?=
 =?us-ascii?Q?sVNdO6U5eRqHrKaVoRbMOJp561ziuHZlMzz77fNOWQ8F14cozUPV5JpVryNb?=
 =?us-ascii?Q?rS+omEo9fzn+mCJlFLYZc33zzLWwL4K7pRZea8b8eiuxSLx31606R4HdP4DS?=
 =?us-ascii?Q?baqOdwJHpwUiCdLH7xDeJ1aq9vnIEZMIKK4n4OstKGamgJQg/uyg2tvPVg3n?=
 =?us-ascii?Q?bTjw1J1KQ8WwdzO22VVPskpUOe5aM0oY2GYu1BM5KkZyDDKku9lBjuyb6Ej3?=
 =?us-ascii?Q?FVgVl6xrnY6CBzLAcsowMWHTocbEOTIzi4dzHt6kpEtL/vZEgubhzbsrBAsC?=
 =?us-ascii?Q?tKspO8qw4wsJvRdpJknYQDylIsfSpR5028TBEE3vHJlm77GALmWRs0RSwep/?=
 =?us-ascii?Q?o6VDjW9oFgNRlljanJ0m399srk3wAUDkrzhn5ldW+bQmVUMrWo1L8m/PvEj7?=
 =?us-ascii?Q?yfcAxETnHk2a40yg78ICT6VJMUbRx2iNiRsnH8FGTueTYo0t20T29Gn3aNir?=
 =?us-ascii?Q?JFixp1/jpKYOnfcrbkbE+k3gNpCuQYH1nIcjVVTU+BfUFWxStrfKaXu2x19J?=
 =?us-ascii?Q?Qr+voQXk8n0tqp1ObAllJXNjMisKMbVo7VDypuHfS/RMU0ShjazJBRSux4er?=
 =?us-ascii?Q?8y0e5d22P+2X3gyeWgQkFJenS6wnujZeDWouCVhePMkn6lYUgfIXMTgOgJOQ?=
 =?us-ascii?Q?4pyZHUotbbr7n9qJKXZOEvwriKNjYY57X7W9+r2c9nXRWmfegHUv3yq6KeW/?=
 =?us-ascii?Q?ZHm1Arr7l2l9SMFf7fCdXG+ADijDmeygT7tyiOXldNG72K5/fciMiHLIeC8W?=
 =?us-ascii?Q?GLguLFRcXrE5ztN+yp+qlBh3IYtz2NLHbSFozmeGMWs+3GDW9osIE0ki12wk?=
 =?us-ascii?Q?w3i0g35g82JBapLZCMt1PKfYPTuaUDnoy17GxDKmuxLm3S8OqDro5ibUzH3W?=
 =?us-ascii?Q?GGXQylTexTYLBkEWZO+mmWp70K19M0ZghleEfDPIrN8Ab3Zx5K4q7S1UDGX7?=
 =?us-ascii?Q?uN7TEy1j7r3Pv0qduPrxzhdDJZoNsmcVnLVQnv3aA9krJ0iv2w/b1fOHgdp5?=
 =?us-ascii?Q?IIN8KuWKJeqK1FJyWnu2t7Ci7Fu+pnCV6gmFnPnbKt9SCBIfHUuR/Hi8Zx+E?=
 =?us-ascii?Q?udskwWGgT5GqeNUjr43lsC4oymv855NyMLlcM3605rdLssTN8qUSKAFKjDM0?=
 =?us-ascii?Q?4XzM6uZ0nDmmtzPlqv7urttQfNxg7j+GL1F/xj+4sveuc5dp8HKrSILkfXwK?=
 =?us-ascii?Q?MbqkI6qUvrKQ1WdMsMWOJSNdvYKnXyAx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9AKIXyBxKjFnva7hFW832AzOupn4so/6ZbGNfjh46JazzGP3w+z5o98J/cKN?=
 =?us-ascii?Q?NKn4hV8CurBbcFRmqcGR+/ikbTMkW7ERRO1zGvDEk03fYOrsBfgOxgRVa/S9?=
 =?us-ascii?Q?Bi6juJW/hnDnIy62WRCFKlH+13FnhRx455v/d3IoPVbxC6jygoEniOhvHYCO?=
 =?us-ascii?Q?mJ0tAyyLCD/BrMypcUr6CPfCypD76TxrxG4styEAscUo2Tqq40GbK7kzbwrZ?=
 =?us-ascii?Q?/HL/sPu11+THBVgY+FFnFUl7JtPIq1w5FzFe949yH2D1wXs7L3vu7IwhefAC?=
 =?us-ascii?Q?iLYjSvfVTsmkNGC6+tPKUrlyIX5TwrSmEE78bc+hC5SZWMnH6C/vJBZf3b79?=
 =?us-ascii?Q?RJJK7IO21IIDpkL0XJ0U+njXefmWKeIF+bDXa2edsItzlFLYMN5Mr5rCkyej?=
 =?us-ascii?Q?aYvYtPuyS6ueNNL6PtY7QvcFJhZUxNCySfEgZZoMj2a6iu+/ul50ohWymvgz?=
 =?us-ascii?Q?hV8YVy3d8eRqxd2A6ujAhx6Bwd9891ppApoPW+V0m3U4o677xnyPYHMpoTCZ?=
 =?us-ascii?Q?d6125NF87O0hdKZ3bDm6f/wnyZ9sIBwANYXGeUNXUAxcg8Qx/QQWZyHmpb17?=
 =?us-ascii?Q?i++QQEbIZr/GpN5brDId/CpWwkIA2OJ7wpvd1IaOa6V01uNA2wYRntrMnMgK?=
 =?us-ascii?Q?xDb6JXsgPzeKI7FLA9kj5q5Y1+e2Q2janKUXhrKWXICNdG5fu9qlBWUmhA7v?=
 =?us-ascii?Q?3EOtrHSEJ7y1jLguRKoUu4s3OA3yRzpa5z84y5exsZfF18ZwD90s60VkrpEt?=
 =?us-ascii?Q?/eZXQZ8+O58+45XO1HHeWynQAjDaZFbvcMslPGlhjGYYWWgl2S/zV9kR12SL?=
 =?us-ascii?Q?IdYOWm10ZJXuK+IZq+jVb4XELGD5UWWklRxwvJtOPIMuaE7xJFYRcS4R5GJM?=
 =?us-ascii?Q?bAcHlZ1WiIYyc+QdEH7Wky5JDDDJ5kFuAaj/F5/8MPErTjWK7NO95+QjDKdL?=
 =?us-ascii?Q?4fjfqjwC7rR7zF9ANdxesU5Z/OWPeQUy10fkUEQYJUVnEdtV++ICiC9moMrQ?=
 =?us-ascii?Q?rYVg5ZXR6JKjmcM7FbYr6zYGezi73/lMIhZ+efE9YIAzkmBT4t3uP03Fcdzy?=
 =?us-ascii?Q?RQ1/0ZtMrfSKfvVQj54zI6p2kYr/BDV64AyOn+BjdKBUWO1fQvxqYtc3yJY9?=
 =?us-ascii?Q?nHzr+//zfwMOyX6CTpeBUly+E5cmu2z5nFVaJEWRW1SzggO13qjwbECKzz4a?=
 =?us-ascii?Q?Z+zNwQAB8FDqyRbmZNjHLuBPyGFiWrVz80CQLHz1Gf3kpP6CgzSH11+UOOwp?=
 =?us-ascii?Q?+Us8nckpQlZhWYef1GxFqU+Xi6Wg1ArQZm8XDOfdfQjD1t/OmnhtkE3iAkxP?=
 =?us-ascii?Q?C+L2xr+LKo9wyqF2CDw8GFISucvsBFZSklGWf5DOhEmXXnTq6EKJvXCtzD7Z?=
 =?us-ascii?Q?qvJBEdU/IEK7dJu2dZ6wB8mDAzfi18tr/xY5kiASdiJo6Ny3wQUH13QD0ykM?=
 =?us-ascii?Q?nMWiNlOKTDJtoEGe6M1kPFakmda0LPxog91X/sHVqcwsOFrLbeY3Zg//zRK0?=
 =?us-ascii?Q?z0ndTMQ5YsPeTs3dD2lyWnh33i9loUfIZksW97HWE46StLdKsk8lBluO2riP?=
 =?us-ascii?Q?+u7o9+bgkVpFf6CJpeojH/zcobXyaVz4mzkuyA34XpUA/oLxcM2b2qsZTWlL?=
 =?us-ascii?Q?bA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bMTjKeP1uxsQq7y7exb/GvRleSVqvq9xQQR7ZEy/02aCc8Qg/5eVv4QpQ93ZaoZ2tF6EiMHg3/F3AkwtChyEt82TjZgaVj1cnvywGC+lFaULg2dBVDsHybWnwYsK7wZEvXS4ktuf+99WLhNgcB5Gr8w3Z52CJ4k1V7pNhWjfI4tdTLec7vEoKn/f58bzfU1x1mrCqsTOYoZa8zoGEjFYd3S2ACvEkbgja/0O+qGDHXFeIZRicgpLIwP/zPM3w1JuFzkxJhzgEVe9G2mvFHhbZpoC7UK5Kdve/IxdSaDIevQhQjGc4w+PyVoLaaA4+pNbd5Cl9ngpm9ylyx/rhka5FWd3j6rkCpHpw8l32LgvvyFnm4JNAfjtY3jnx4PX++OljtMpIneI9TV5iSS1AGb/RqrLglGtZoOrWjAQoh/y/K18PXNy048paFjIebA8vnIKFIztP6x/6aKf6E/q0VSL3zWwD9F46q6o9RAwk6W3b7BtzjOfMW6pCSHKdYMHQ6IrHJRUApEJaTf3zQj6s/2AcVGlsS8vWV5jEKa1GHiXMRtK9ouDrE2lHEUTr1StPmCKm/yEESu9zDTSPjwLmVnOq2WVRhMmljhcIMY0Q5riOQE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1249e555-dc60-46be-801f-08de20a78c97
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 22:21:52.5096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OLcDEvyKUzvykc3IiIDLzqTATS3/+FGIEmc3vMVbmzQ0tRESghbM+XsP5wsOBbu1Gz2vHTaYkI1+nvHkvMyHCqUcvQKUOU9ExoAyGLT3/a8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7622
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_07,2025-11-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511100190
X-Proofpoint-GUID: -of_CjyfhY9ReBR_qkHI1eLsRWcfXJKy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDE4NCBTYWx0ZWRfX5fIXtJ9DfdVW
 OjNQvMfIjzxzA/13zv594RBTWTDowtbxV6uwBTx3vq/vEqtYjJXocUnGsx57aAK5oONsAWzQiV2
 LGmypprLcEmZif/I0ecNdxG8K8OqGy9kMI51b5E+Yek8Yv6mhWqCJXiNG/RDch41xlQXuAYGkvA
 kqJVqwQpjzM9fE4SZSGGTaaRzOqub1N2TVLkk16UxDcWrxj+rNT3yqw0xXZYnRSXTI9lF9NM/jz
 0jjGL/fLEvWUcy/n3RCCI5PPfHeWanzj2v+2/MHSMP/jfsB9qIFYoobyCSW5RKawd1RuoIB02eQ
 qCX98SNaWHN/VK6Z9aH+kwa+oej/CsjtyplJ8B49Js3cObkRDpYN1dtu6j2YvmoXGLqldaBC+tP
 gnPJSc/F44F9RuQ/cm7lsWXZu2o8Zw==
X-Proofpoint-ORIG-GUID: -of_CjyfhY9ReBR_qkHI1eLsRWcfXJKy
X-Authority-Analysis: v=2.4 cv=YN+SCBGx c=1 sm=1 tr=0 ts=69126585 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=96_WKPqrBKIKR3zHGkMA:9

PMD 'non-swap' swap entries are currently used for PMD-level migration
entries and device private entries.

To add to the confusion in this terminology we use is_swap_pmd() in an
inconsistent way similar to how is_swap_pte() was being used - sometimes
adopting the convention that pmd_none(), !pmd_present() implies PMD 'swap'
entry, sometimes not.

This patch handles the low-hanging fruit of cases where we can simply
substitute other predicates for is_swap_pmd().

No functional change intended.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 fs/proc/task_mmu.c      | 15 ++++++++++---
 include/linux/swapops.h | 16 +++++++++++--
 mm/huge_memory.c        |  4 +++-
 mm/memory.c             | 50 +++++++++++++++++++++++------------------
 mm/page_table_check.c   | 12 ++++++----
 5 files changed, 65 insertions(+), 32 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 5ca18bd3b2d0..b68eabb26f29 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1059,10 +1059,12 @@ static void smaps_pmd_entry(pmd_t *pmd, unsigned long addr,
 	bool present = false;
 	struct folio *folio;
 
+	if (pmd_none(*pmd))
+		return;
 	if (pmd_present(*pmd)) {
 		page = vm_normal_page_pmd(vma, addr, *pmd);
 		present = true;
-	} else if (unlikely(thp_migration_supported() && is_swap_pmd(*pmd))) {
+	} else if (unlikely(thp_migration_supported())) {
 		swp_entry_t entry = pmd_to_swp_entry(*pmd);
 
 		if (is_pfn_swap_entry(entry))
@@ -1999,6 +2001,9 @@ static int pagemap_pmd_range_thp(pmd_t *pmdp, unsigned long addr,
 	if (vma->vm_flags & VM_SOFTDIRTY)
 		flags |= PM_SOFT_DIRTY;
 
+	if (pmd_none(pmd))
+		goto populate_pagemap;
+
 	if (pmd_present(pmd)) {
 		page = pmd_page(pmd);
 
@@ -2009,7 +2014,7 @@ static int pagemap_pmd_range_thp(pmd_t *pmdp, unsigned long addr,
 			flags |= PM_UFFD_WP;
 		if (pm->show_pfn)
 			frame = pmd_pfn(pmd) + idx;
-	} else if (thp_migration_supported() && is_swap_pmd(pmd)) {
+	} else if (thp_migration_supported()) {
 		swp_entry_t entry = pmd_to_swp_entry(pmd);
 		unsigned long offset;
 
@@ -2036,6 +2041,7 @@ static int pagemap_pmd_range_thp(pmd_t *pmdp, unsigned long addr,
 			flags |= PM_FILE;
 	}
 
+populate_pagemap:
 	for (; addr != end; addr += PAGE_SIZE, idx++) {
 		u64 cur_flags = flags;
 		pagemap_entry_t pme;
@@ -2398,6 +2404,9 @@ static unsigned long pagemap_thp_category(struct pagemap_scan_private *p,
 {
 	unsigned long categories = PAGE_IS_HUGE;
 
+	if (pmd_none(pmd))
+		return categories;
+
 	if (pmd_present(pmd)) {
 		struct page *page;
 
@@ -2415,7 +2424,7 @@ static unsigned long pagemap_thp_category(struct pagemap_scan_private *p,
 			categories |= PAGE_IS_PFNZERO;
 		if (pmd_soft_dirty(pmd))
 			categories |= PAGE_IS_SOFT_DIRTY;
-	} else if (is_swap_pmd(pmd)) {
+	} else {
 		swp_entry_t swp;
 
 		categories |= PAGE_IS_SWAPPED;
diff --git a/include/linux/swapops.h b/include/linux/swapops.h
index a66ac4f2105c..3e8dd6ea94dd 100644
--- a/include/linux/swapops.h
+++ b/include/linux/swapops.h
@@ -509,7 +509,13 @@ static inline pmd_t swp_entry_to_pmd(swp_entry_t entry)
 
 static inline int is_pmd_migration_entry(pmd_t pmd)
 {
-	return is_swap_pmd(pmd) && is_migration_entry(pmd_to_swp_entry(pmd));
+	swp_entry_t entry;
+
+	if (pmd_present(pmd))
+		return 0;
+
+	entry = pmd_to_swp_entry(pmd);
+	return is_migration_entry(entry);
 }
 #else  /* CONFIG_ARCH_ENABLE_THP_MIGRATION */
 static inline int set_pmd_migration_entry(struct page_vma_mapped_walk *pvmw,
@@ -557,7 +563,13 @@ static inline int is_pmd_migration_entry(pmd_t pmd)
  */
 static inline int is_pmd_device_private_entry(pmd_t pmd)
 {
-	return is_swap_pmd(pmd) && is_device_private_entry(pmd_to_swp_entry(pmd));
+	swp_entry_t entry;
+
+	if (pmd_present(pmd))
+		return 0;
+
+	entry = pmd_to_swp_entry(pmd);
+	return is_device_private_entry(entry);
 }
 
 #else /* CONFIG_ZONE_DEVICE && CONFIG_ARCH_ENABLE_THP_MIGRATION */
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index f6c353a8d7bd..2e5196a68f14 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2429,9 +2429,11 @@ static pmd_t move_soft_dirty_pmd(pmd_t pmd)
 
 static pmd_t clear_uffd_wp_pmd(pmd_t pmd)
 {
+	if (pmd_none(pmd))
+		return pmd;
 	if (pmd_present(pmd))
 		pmd = pmd_clear_uffd_wp(pmd);
-	else if (is_swap_pmd(pmd))
+	else
 		pmd = pmd_swp_clear_uffd_wp(pmd);
 
 	return pmd;
diff --git a/mm/memory.c b/mm/memory.c
index 7493ed084b99..fea079e5fb90 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1376,6 +1376,7 @@ copy_pmd_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 		next = pmd_addr_end(addr, end);
 		if (is_swap_pmd(*src_pmd) || pmd_trans_huge(*src_pmd)) {
 			int err;
+
 			VM_BUG_ON_VMA(next-addr != HPAGE_PMD_SIZE, src_vma);
 			err = copy_huge_pmd(dst_mm, src_mm, dst_pmd, src_pmd,
 					    addr, dst_vma, src_vma);
@@ -6350,35 +6351,40 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
 	if (pmd_none(*vmf.pmd) &&
 	    thp_vma_allowable_order(vma, vm_flags, TVA_PAGEFAULT, PMD_ORDER)) {
 		ret = create_huge_pmd(&vmf);
-		if (!(ret & VM_FAULT_FALLBACK))
+		if (ret & VM_FAULT_FALLBACK)
+			goto fallback;
+		else
 			return ret;
-	} else {
-		vmf.orig_pmd = pmdp_get_lockless(vmf.pmd);
+	}
 
-		if (unlikely(is_swap_pmd(vmf.orig_pmd))) {
-			if (is_pmd_device_private_entry(vmf.orig_pmd))
-				return do_huge_pmd_device_private(&vmf);
+	vmf.orig_pmd = pmdp_get_lockless(vmf.pmd);
+	if (pmd_none(vmf.orig_pmd))
+		goto fallback;
 
-			if (is_pmd_migration_entry(vmf.orig_pmd))
-				pmd_migration_entry_wait(mm, vmf.pmd);
-			return 0;
-		}
-		if (pmd_trans_huge(vmf.orig_pmd)) {
-			if (pmd_protnone(vmf.orig_pmd) && vma_is_accessible(vma))
-				return do_huge_pmd_numa_page(&vmf);
+	if (unlikely(!pmd_present(vmf.orig_pmd))) {
+		if (is_pmd_device_private_entry(vmf.orig_pmd))
+			return do_huge_pmd_device_private(&vmf);
 
-			if ((flags & (FAULT_FLAG_WRITE|FAULT_FLAG_UNSHARE)) &&
-			    !pmd_write(vmf.orig_pmd)) {
-				ret = wp_huge_pmd(&vmf);
-				if (!(ret & VM_FAULT_FALLBACK))
-					return ret;
-			} else {
-				huge_pmd_set_accessed(&vmf);
-				return 0;
-			}
+		if (is_pmd_migration_entry(vmf.orig_pmd))
+			pmd_migration_entry_wait(mm, vmf.pmd);
+		return 0;
+	}
+	if (pmd_trans_huge(vmf.orig_pmd)) {
+		if (pmd_protnone(vmf.orig_pmd) && vma_is_accessible(vma))
+			return do_huge_pmd_numa_page(&vmf);
+
+		if ((flags & (FAULT_FLAG_WRITE|FAULT_FLAG_UNSHARE)) &&
+		    !pmd_write(vmf.orig_pmd)) {
+			ret = wp_huge_pmd(&vmf);
+			if (!(ret & VM_FAULT_FALLBACK))
+				return ret;
+		} else {
+			huge_pmd_set_accessed(&vmf);
+			return 0;
 		}
 	}
 
+fallback:
 	return handle_pte_fault(&vmf);
 }
 
diff --git a/mm/page_table_check.c b/mm/page_table_check.c
index 43f75d2f7c36..f5f25e120f69 100644
--- a/mm/page_table_check.c
+++ b/mm/page_table_check.c
@@ -215,10 +215,14 @@ EXPORT_SYMBOL(__page_table_check_ptes_set);
 
 static inline void page_table_check_pmd_flags(pmd_t pmd)
 {
-	if (pmd_present(pmd) && pmd_uffd_wp(pmd))
-		WARN_ON_ONCE(pmd_write(pmd));
-	else if (is_swap_pmd(pmd) && pmd_swp_uffd_wp(pmd))
-		WARN_ON_ONCE(swap_cached_writable(pmd_to_swp_entry(pmd)));
+	if (pmd_present(pmd)) {
+		if (pmd_uffd_wp(pmd))
+			WARN_ON_ONCE(pmd_write(pmd));
+	} else if (pmd_swp_uffd_wp(pmd)) {
+		swp_entry_t entry = pmd_to_swp_entry(pmd);
+
+		WARN_ON_ONCE(swap_cached_writable(entry));
+	}
 }
 
 void __page_table_check_pmds_set(struct mm_struct *mm, pmd_t *pmdp, pmd_t pmd,
-- 
2.51.0


