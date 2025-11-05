Return-Path: <linux-fsdevel+bounces-67178-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D841C371DD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 18:36:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B16AF18926BE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 17:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 600623385A6;
	Wed,  5 Nov 2025 17:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="M/azPx3u";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qG5LYTHu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04ACC26E6F9;
	Wed,  5 Nov 2025 17:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762364175; cv=fail; b=Mc3xTZyqeeMvNWip1s164AM/YnfYsNuJ1E7CaCEKRmEIkWZJl1wRbN7d83o0KXEi41VrGTeT1SPsVxHfZ9Y6ZD5o5/pbYxmH+x5eU2LIBfUKAI8xbC2Uy4XTfkBlY2kY4IRe8gxP9hTH6SEc9PewcgfxIlDRSVs65ucDqHrIm5Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762364175; c=relaxed/simple;
	bh=2tSx0sRncqomLGMSr+UjsMx6IWmsJNYnMnioIQtQohg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CSFaBEOno8Yhb6nTCyyaNiKBOlPKc4QPD0cKttXS/oWr8qP+4va+BoubAehggMXD1ayuQ+9W+Xd27TUmP+wysaVuDs4CfXgCftHmujvsN89zb5KfQiIXM76LP1aT9ik0eUKMYRU94e6pJfO7ebRKrdxGVQpwgO/eUPdtXbPKc0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=M/azPx3u; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qG5LYTHu; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A5H9KhW017629;
	Wed, 5 Nov 2025 17:33:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=2tSx0sRncqomLGMSr+
	UjsMx6IWmsJNYnMnioIQtQohg=; b=M/azPx3usNYrYmSfWiRTirTS+hWGis4LTW
	OcN3Ueniv3mtQUls2Z658ZaKHhKVYwOvf8io4s/HK7VqYJc7Vbwq2LlJTUqSqhE1
	0N+t4zHwizfzY37WZKz05KN0VhNBzceLzbsjOuKfjcxVe9KW4e+NJ6evS9xJfPGu
	TdHWQ5JETU/XLDjcnuMWBVRone1NRyGAOYew5CcEQC8oEgJk83L3bk06XS4+5HJG
	uH3PIiQiVv/3JQ5b9wcqhJEAmBRIG8VkLfpxjZEjuG2qTvOTEGM/WULxv4V0fdJA
	6qktbTmirAd8bhXYcTsOUmpQJ9iqeRx4rPjIE716g1lFDEpTNkhA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a8aqw821c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Nov 2025 17:33:54 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A5GRJnr002723;
	Wed, 5 Nov 2025 17:33:54 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011034.outbound.protection.outlook.com [40.107.208.34])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a58neudyd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Nov 2025 17:33:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bPhUUDsH06QJXtzmRxOewFZ0JTyFhBuGGr1v33CF47MBnkIwdiLGfNLbADi+DJdLEZbACebtXuSAeVu0+Jd4i4XKQAMzDPWYrB2T00AiyqWrrzDGgrMVT0n6w211DdriL9wjwdoOt59PCrdTem1TNKo4W9mCCKD+Ry0QCf/kPPyZV7RcitXPZ6/XZOEZnqeUtGZz7BJXPYkKypkcsG9nlg3IsjG9cDVzRyq81UVkRuLptPARuOzLjpJZVmDNjth/ctM8yTCTXAb6fPMGj5fpg1p55mW5Oy1vBsvacR6CNyQ7n1r8U0AD5tgWB+z0nRJZi+v8AIs+vtTdHtYnLJwErw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2tSx0sRncqomLGMSr+UjsMx6IWmsJNYnMnioIQtQohg=;
 b=YZhoqIBc/r4f7/QsmVjn5qp9BlDydvnIr9SbC/oaMvp62K9s//tRgDXKqBW8crh2L/QYSWr1ianDBsfW3ZV2x75/+uVordF1cNuo1eEy5KuFybnIEQyOLWSJPas5ZPvS6vZuevBsCG+7WrJSpfgfi7YqjMtE3SV/hW/gp0RPsZ+AtbliSK4wEkKMdOltQiZpFnPdzEtbofuc+DhavqAAgPlLSHkURoEbMrDNKvdr/W7SGbOd8ct4ewWe1m3mheVi5K+VUWqnb5y1tqyMWdjgTigefZMPrCtUfIlqoiUC0q6Sd4r8b0XfLE4yVqd1wv0Nbig1D60D7UgADBlKD5Qu2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2tSx0sRncqomLGMSr+UjsMx6IWmsJNYnMnioIQtQohg=;
 b=qG5LYTHuA8ETDLC7zHxltM6qwHCeP9W6RIRmHGgNgrq0aTJsMRZwE2qMXU8+9dMIEA2vhQl5HlK7JhkOZ+xo53i0jC89KoGC9JPsUmYmDxVD+j0ykhscUBZxhKR/6c0nquRl+YL7J3bY/efgTlMfov67k58h+d4c4hJPZEYEagg=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ0PR10MB4495.namprd10.prod.outlook.com (2603:10b6:a03:2d6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Wed, 5 Nov
 2025 17:33:49 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.9275.015; Wed, 5 Nov 2025
 17:33:49 +0000
Date: Wed, 5 Nov 2025 17:33:47 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
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
Subject: Re: [PATCH 00/16] mm: remove is_swap_[pte, pmd]() + non-swap
 entries, introduce leaf entries
Message-ID: <7d4c26e9-2fc2-4a59-bd34-984bf7df4dd7@lucifer.local>
References: <cover.1762171281.git.lorenzo.stoakes@oracle.com>
 <20251105024140.kmxo4dltsl6toyil@master>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105024140.kmxo4dltsl6toyil@master>
X-ClientProxiedBy: LO2P265CA0381.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a3::33) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ0PR10MB4495:EE_
X-MS-Office365-Filtering-Correlation-Id: 1932f816-3983-442f-d968-08de1c917b39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yojytIC6AoHKMORQX6Sd4qJ+sOtaJhsf5CfiPLv+iHH5Dcm8wSY67Dp4v2tS?=
 =?us-ascii?Q?6V9/Ew4LPfWIRMDg0pIhcCir11VhIGaC1JxIOu0yNArFQ/RPgHHwTAHQ9CuU?=
 =?us-ascii?Q?JMwQYp5Mrt2ZDFB4MTqujjNsY6x4Mtl+dkJD9aNl/YPspKB6+alBvCIRs08B?=
 =?us-ascii?Q?XWBZMrMjzxIbX/xVFuP5wsf5uZ38t9azA5BsRrLe9VGutmKDKpIMgjTY3lAx?=
 =?us-ascii?Q?vtaBn1d9lvKAhIcEODU4jcTLZWMsZ1y2wgtYU6Xmu3REPa7tNQUEPiwhoNPP?=
 =?us-ascii?Q?5YMXUC2suXAo7OvFRD14XBW2ObcasPjrdSFsTL+hLjJqBdw0U5gw0wYKGg8R?=
 =?us-ascii?Q?l/TbN6EdKr6gVJM2qCpdDHooQkBKNxzHQnkZXDc7eZtNVQtdiJAGpEfanE5h?=
 =?us-ascii?Q?2kxTHTLEJQo3H4tEzxz17XvVpud7cFehOer2MQ2Q2bXxkmSZXBHvRJtn6msX?=
 =?us-ascii?Q?vvYbKLkZIQ8bKeq4QO/zYKtvfc55iq+Ypt9NzazbaERWBuDm7GyFIDSHbMQp?=
 =?us-ascii?Q?1jEX1mil1Rr/Z7CS/xB8hKjQIU8NslestcioGAPKllpe2CZzExA3sG446h+s?=
 =?us-ascii?Q?jnPaG3tXp90Xocp3C6sqSf4ta3Hxt74qOmg0xzwR5YVkmsNJG0zTCccKMN0z?=
 =?us-ascii?Q?j5eOuTA6pJYz+GRKQRMJzRuG/iQsSNUfEpaKxijr/SwGmG1nHn3KVH4n0NS1?=
 =?us-ascii?Q?49MQwS/++fXi0uiFQKGpYd07PYssFfZs/s145J+WMYIkwt0fHqAMIUB5e3kh?=
 =?us-ascii?Q?PBvs7KP9iUK2Od7PKd023JaFdJD+NMyT/utrcPvVKynjXLTiygDCmUT10XiF?=
 =?us-ascii?Q?GPn53jC7vlIJJHQcLfA6hSgsDpcoB/Z15N5nI0Xglmxs8I3nly36rLB+f64M?=
 =?us-ascii?Q?3xPaaOjfLRXW5WBxstsBglw315tfh58aLEqA3JwVuijY0jqZmoTvBeKJrRZJ?=
 =?us-ascii?Q?xGZZvv2jmjpOyDXJ6370EvULq7pyJZPTOgx0v8qB9rB2gxiz08/bV07iuaiu?=
 =?us-ascii?Q?bec282OEx25YMK2pF+nAKz2UOoTxrjNEDiHqNfFROweuQGykYeClX+9dL0Du?=
 =?us-ascii?Q?r7bH6SglpUpuA+w1JiKwnQ0nIhEehCoErjSBYv/5pFNdlttRUf2zgDYWvmMZ?=
 =?us-ascii?Q?357qfHYr6f1Iyn/4dWUaGdj94/oaGN4Bw9KmuX4bMAB/gaovdjN7P6a6Wp2k?=
 =?us-ascii?Q?zRPzyH9Y2zYEXCc3gNhUzBuX9ik20DgEV909KA7wB3iafe0BZvYDeJJLq1b+?=
 =?us-ascii?Q?/OuAmIcsc6zvImu3gpO6DMspd0tSGTuPa39ZhGWLDSeOfAFUQIfTgWyKcPzz?=
 =?us-ascii?Q?FLeP/17/2nEJOW6gUOThRYDs1IW5zTO7imqVBnbs9O/tfPMykx3tRt5nSVWO?=
 =?us-ascii?Q?+aJeRDX2pv16IfT23MkbbVcVwOm2glpRrLu030OBoAAsTzILYM5uKLGHhqlW?=
 =?us-ascii?Q?wVHlBWgKb7wwaAV9l0n9lwTBMI5Lr3IE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Roq4No+FQJ4BDxToMj4dxL9pYun24audyF7IoZFbeQuImDlcqIwpDC+l37dt?=
 =?us-ascii?Q?IhsQ6B1dzwzZjCC82lppif5zKI0dEcgNvpYjFAHDGtDfgiK6ESZF7pxCn/be?=
 =?us-ascii?Q?lEJRk8ktxPLEGKvPHKFfTD1y/GpkldihNmMBLOpmMKZT2sWXvj84uj4nkYTm?=
 =?us-ascii?Q?LobcTva3Lhqwpapf1Ky3o8+K4ie+g0yn1D0Ay3JEpxm6nEPIG9p1pQGouQwF?=
 =?us-ascii?Q?q2ZE2x8+Ue2R9PFikB/AMtRv4pDzqfslWCNdLHY0eOHL3MtGDY7Lg1GVisJR?=
 =?us-ascii?Q?61aIU+erCamDGDRaE5f4KReLAIWXP2JOoIGvPH21KQJc5O+UyHh1j7GT0C8I?=
 =?us-ascii?Q?QP2WzMBXqBW+yxPKcnvC13ygYzP3blZqOT+4OU+4XIYwW8ySqUAz1G2u1IDd?=
 =?us-ascii?Q?lbIS2XTBL6v3hAn0ZqBs/6wwLviUvSG52qn3ikvAx1ni4QXzzVrKyfryqBTn?=
 =?us-ascii?Q?JIihbS+aKXDmhDOOf6S7U2n+WAkYVF3h8IEpuZDMv8K4tsJKYPD+PzKbxf8i?=
 =?us-ascii?Q?SbG/81ZLDKsJb4YOfpZwv/4+R1EBU3DroGmPABsnzZaX92zGw3ulcfriVd4t?=
 =?us-ascii?Q?XKZN/qrbcXKdadFVYdOFcNcdS+AIVsg3m3VMwdRbDg58e7euzVGycEKy9Nc1?=
 =?us-ascii?Q?Gvux9A5yuWy3HukRdWtF7GBEHWzX+ULRrbh4mRUzLH/39VXTcfl6Fb25D+as?=
 =?us-ascii?Q?kDT43BVHn31eHUoGmp3PTMkzzgxG0HspWf3ksD8OTxCMgsuu8cLjia5Ow9D/?=
 =?us-ascii?Q?jkz6uqUwGl+Cwyr1JCRLfN0Qf8LRexsviKB22Qu5xK9FIe5OEX1TQ54I8DVQ?=
 =?us-ascii?Q?p9hrQwMHTKgRB9kBY2EsTe13JYk1n5VTFtuo2SA7LMSCievkuJiw4xB9ktvY?=
 =?us-ascii?Q?Np72sV78t3XELm4IA6ELzSHINV3S9oerpT2Yvda3mQp+IXPy8BA7E2J3jaRK?=
 =?us-ascii?Q?3SXq66YfK7bOLXijdUNsT+3hvuH1OHblaemjhFJ6ntbTOdk4Iy2ERS8SR/7c?=
 =?us-ascii?Q?mYg/t+b/cUH50i/4B1ctQlSqUEH6p65jTUiQno99nnzyEAKp2oMQpQHEZjKi?=
 =?us-ascii?Q?RpR78CdKJ9sHMfZ0+Dg9iEt2r/oZY1ecNzCFq5LUXMXJ3RuVaTVm3DOlQL8X?=
 =?us-ascii?Q?k9KrrOwnzytXM+cbDwbJ+xdlrcTaVU0gyf4Klh+/eojgeBOK+aEk2j7yVprn?=
 =?us-ascii?Q?uPmefrFjdoPFCuDDTJESlJrywC1PNm9ajz9wGzdPnJPpwN7sZWKVFWB2arUi?=
 =?us-ascii?Q?guZk5egNj/n+qBSe2qf/W4sfKL4KqXVUuhFMCiFIuS5+zMQa3myl9vGwRxkc?=
 =?us-ascii?Q?UqE1MD/HkMzVyu1Bms1MwRySh0d2a5E0b/BWoiOnnVBQOzKYS+Zo8OUpGiSY?=
 =?us-ascii?Q?J5GpYnSD0kgqkvxxCSktpP79vbgDzVscCmCxX8+uEJnMERi04xUORrc/cWn9?=
 =?us-ascii?Q?p/zoH3yqSjyAHeiflBDnJeQaJA7r+PrmoYBJO2ZxB0VdUgEgiw8MqLBkBehJ?=
 =?us-ascii?Q?quQsETEWEUX98tlPWKwA/RrEtUPt9pSldrvZG9s8VObbjIICmnPWFt7eh7bB?=
 =?us-ascii?Q?xU9+qJBZZH1YhRv2BXyC1P7EotIICXNaG2SOBSV5x13U5NYpK1x/rXOE0cUa?=
 =?us-ascii?Q?Dw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	W03DVIU0r3jlLzQyhYspn8odZnTEga7xxmHey8/cfhbByo41xethbKFahOiR91PD6SExVlUTtgbLdKXpYWX0igBro3l7dXoPsU4L7uVeztAYKjFi+JJcyTs1ZyZxZjv/q8Sg8mImYDq7hhAZJmnMyBwBgwagH7Vjeg4TSIiq5kUwz3+Yw7jXtA5oA3PZP/0Ts9rE0LALSbD5/ExeX9clu4n0b6CKDI9eTMpY2NDWl3aMrMJWGgp2AQqfLChgiSlUIzDu/bX9ap2fu5gOM5NdysH8gItelZRtaD3HkxJS5Hubaxng/5WQH/H8CSeMsIV9fb4L+7g5Yrz0bMgmdBPHCqB6OemWjgbBk3NRv4ZN30GYbs9WjY2Y9RLGCCfhhF7cAxuoRzzz3/YI+VZ9+D/C0PAwbrVaCT47nzWcXIBVklrW6YTVVafVD4+I2vy7HnbFk08AaJ3w8iBUX9PvEn40z4bUarRnSIvlmECsC5zYNqrHx7z19+lBKwTg/kIHFHOo+cnpA+G/RputYdibNMiYe9iswflgY9jJQYc3LRTzhHs3kt6uGOkdEK6/7pu+fodoP2SJS9BsVMBLu0TY81/5b1WJwNNcY8STHpYx3Fz3gAc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1932f816-3983-442f-d968-08de1c917b39
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 17:33:49.7141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h/eceNZRU0XooKjNlMgUwx+n4tAt3F7PcPf5vrkcclUGImTnrPtrrx0ZKzrM0eWYCQShtC9ufrDg8+gBYOFWUahwlDx5QCHZUPLoI3gwfiw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4495
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_06,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=915 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511050136
X-Authority-Analysis: v=2.4 cv=NajrFmD4 c=1 sm=1 tr=0 ts=690b8a83 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Qgk7mNKoAiYEN22WLxAA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13657
X-Proofpoint-ORIG-GUID: Uiz5UaTU_LJGBQNOPOF4IY953Phrpn71
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDEzMyBTYWx0ZWRfX6/pZNPB+BTEJ
 4xztDghRzzWkYQzKLCvQCJgQJvbL/B8guJNfFT3tcb1pDF0M2ev+ZvFVN4PrHnJP4c1LO8D77JD
 Gd2/vrx6fu5YOIOf/AfAeB2+nyyZee/O2/F515Uo039G8o9RR15q9qlm0Lfnrv+bfEGjW9PXXz4
 DZzI7+KRcmpeiRvNZQxXNGcsrrt7vOW1q3ONtSnYLrJyirU1jG8k807gFdIXo7IIzxedpYAG2bc
 i/xcZ89i6Exvva3nKH0riqz3tC0l99m+TShFMTSlzWprw7xDv+FDmdozeTD3U+Ap15B01eecGGe
 dbCi2ZCtT+HwkXWKprK8q4erhkDkUttO2zhGDng7IEmWGjbXJm3wILl171nEgLf4rvCfDMGQQfJ
 H90pPAgBc+brvEYEZyZ5z99kT9DtgG6CuhZiKT3RSNWX5HX5rZI=
X-Proofpoint-GUID: Uiz5UaTU_LJGBQNOPOF4IY953Phrpn71

On Wed, Nov 05, 2025 at 02:41:40AM +0000, Wei Yang wrote:
> On Mon, Nov 03, 2025 at 12:31:41PM +0000, Lorenzo Stoakes wrote:
> >There's an established convention in the kernel that we treat leaf page
> >tables (so far at the PTE, PMD level) as containing 'swap entries' should
> >they be neither empty (i.e. p**_none() evaluating true) nor present
> >(i.e. p**_present() evaluating true).
> >
> >However, at the same time we also have helper predicates - is_swap_pte(),
> >is_swap_pmd() - which are inconsistently used.
> >
> >This is problematic, as it is logical to assume that should somebody wish
> >to operate upon a page table swap entry they should first check to see if
> >it is in fact one.
> >
> >It also implies that perhaps, in future, we might introduce a non-present,
> >none page table entry that is not a swap entry.
> >
> >This series resolves this issue by systematically eliminating all use of
> >the is_swap_pte() and is swap_pmd() predicates so we retain only the
> >convention that should a leaf page table entry be neither none nor present
> >it is a swap entry.
> >
> >We also have the further issue that 'swap entry' is unfortunately a really
> >rather overloaded term and in fact refers to both entries for swap and for
> >other information such as migration entries, page table markers, and device
> >private entries.
> >
> >We therefore have the rather 'unique' concept of a 'non-swap' swap entry.
> >
> >This series therefore introduces the concept of 'leaf entries' to eliminate
> >this confusion.
> >
> >A leaf entry in this sense is any page table entry which is non-present,
> >and represented by the leaf_entry_t type.
> >
> >This includes 'none' or empty entries, which are simply represented by an
> >zero leaf entry value.
> >
> >In order to maintain compatibility as we transition the kernel to this new
> >type, we simply typedef swp_entry_t to leaf_entry_t.
> >
> >We introduce a number of predicates and helpers to interact with leaf
> >entries in include/linux/leafops.h which, as it imports swapops.h, can be
> >treated as a drop-in replacement for swapops.h wherever leaf entry helpers
> >are used.
> >
> >Since leafent_from_[pte, pmd]() treats present entries as they were
> >empty/none leaf entries, this allows for a great deal of simplification of
> >code throughout the code base, which this series utilises a great deal.
> >
> >We additionally change from swap entry to leaf entry handling where it
> >makes sense to and eliminate functions from swapops.h where leaf entries
> >obviate the need for the functions.
> >
>
> Hi, Lorenzo
>
> Thanks for the effort on cleanup this, which helps me clearing the confusing
> on checking swap entry.

Thank you :) much appreciated!

Hope it's useful, my ultimate initial aim was to address my own confusion and
frustration (stemming out of a debate about use of the is_swap_pte() predicate
on a review), I'm glad that via review and also thinking 'hmm we should address
this also' etc. this his developed into something that hopefully makes life
easier for everybody!

>
>
> --
> Wei Yang
> Help you, Help me

Cheers, Lorenzo

