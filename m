Return-Path: <linux-fsdevel+bounces-67755-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80470C4982D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 23:24:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A66C7188CDA1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 22:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2AB9330338;
	Mon, 10 Nov 2025 22:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UYitXxCx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PGbtcf8U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4002E62C4;
	Mon, 10 Nov 2025 22:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762813413; cv=fail; b=rDwVPZASW8hgW3v5qjrjFdBSrsRkg+T6j8YelLCxV61gOu4c2Hm+ONa8MF6ZhDsnrvdrRlFMtomhTb2s5kk9uMRYjFwet1jAI81EohkFWxFiyc3HtYT+PMSlxwCNxPx3aUnLDo5ZZG//EESTqihpLkNsjt2MQWrJf8XuT+N1cjQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762813413; c=relaxed/simple;
	bh=BwtqsbOZ/zTXiFh3bRPTEI8r0LJSVuqNgZCQjdJzkIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hiHcVAxHuAzH0tIrktud0MXciaGdxOKOMapp1X4Eaoaz7tE8vYd1f/9wnZ/X+qQXjDGfMv1Afi2YhPgOXe/MA1O93vTK5ysIehtRRcd9vDQDa+m+rGXririoQ10VKkTFDB41naenW0n/nVieIb6YQMS2Umvq+nNWR4+KPIK9tXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UYitXxCx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PGbtcf8U; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AAKcAFO002920;
	Mon, 10 Nov 2025 22:22:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=IZbC4u1/g233rEO38PGwbP9yIpeb5PXNM3qTia8WOz0=; b=
	UYitXxCx6rCxQpu1kf6MpkYcDbP0Mtzq3Mqix6xKJ1a/Mf2usZ9Flpn6SBH/qGns
	IOy8p41oI8JQKAIWySh06oB3dKUi9EZzJn3i+9MQsg0jwBhjRIbsuQ+w7Dyd1B10
	cBjUunwScmL8cpkpvUYi2Wx8WcY4xjr2IeMTVuMO5z0HQxMXpUKfXPbNaCM/u9P2
	PvI8aCbEDKRcmfyMPoHnIWkocEkDb7PwK0CXxEwjd20+IxNg7gJgOyvxe7Vm0EMC
	GF+f8Y2e2mv/RX9sN+f1ixoSvny1eM3QEPWYSxZ0hLikBkeU218KdYpo0WJ4F2P0
	cMeBzJb7KFPPLm4z0bvDLw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4abpmn0b8n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Nov 2025 22:22:18 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AALsCKe000873;
	Mon, 10 Nov 2025 22:22:17 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010031.outbound.protection.outlook.com [52.101.46.31])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vacs4p9-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Nov 2025 22:22:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M9LaLXlRrSSsqCVmlMam8Z8KyCSncfGlnQ4+5hFZWw1aq4jI/Xt5yOCisLRp5Zpx/fnctCRlYq2pc/wpQjMp08yn84DITu6AAXH8yK9OYBM2fhas2LorRxnYPFYwVyWarhL1ozKOhSG0ASbempW5x9gmo7Qq+zqOnJNgP8LtIeLTwy+4xcEHLxsJW7v+klTTK1N65kcR8BKMTSNAlX7IXztIFUxj4q/4CjaESGfQAabP12muCetm4871pOeP2Uy+FNgCTA3XwDJxAsHOkXyK03TdG9s22xvy+mh6iYSxf4S0Rh7nUdTNBMt9zihxQgzxrtEaFuxdp8HSmuNVQyFezw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IZbC4u1/g233rEO38PGwbP9yIpeb5PXNM3qTia8WOz0=;
 b=vgVy3oqmePPT8ZKmc7g4hv12nsw4peXX82ATW1lBdiDniwUuxlT3osVNwWhZ7+PGVvRc7/4SJySBvZjmdyUGp6my5qNZGW3+Kn7ljN8AYeOEibkA3qSeJ1+nglQaVE3NNfbZzdUK662P7tlpAza7Yx28r6PAgWb4gAdXfDX7lvANQc0Dmx9b56YPv4SHb6YUDHQCMEo5aoCDUT5Jl9m3XWWgnD9vdlDtwRxRw6kEmARrWS5axUkh2dNEIg8/uUt08Jqktbg6yzgZlocnatIKOP7kZyq6GwT1U0yCNBoU/28ubi6sLYdbFjnHWlRrCRYXw5W7dxKSl4odKsEGkP/EbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IZbC4u1/g233rEO38PGwbP9yIpeb5PXNM3qTia8WOz0=;
 b=PGbtcf8UhL2ejNSgT6MJDo9X8erDGtDXTfdxTk7UoRYVCVuLe+FiTakpAlbKRCWxG8Mq70LZyaqo7CZfrREZxEymo12KKyKzL70aqAUwrBkwU3zg62c5vQOtOjYe11NJqhtg36JuXPuEjeRywMZGb00KWhSO5WJhdeIBgIwH3pY=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by IA0PR10MB7622.namprd10.prod.outlook.com (2603:10b6:208:483::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 22:22:12 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9298.010; Mon, 10 Nov 2025
 22:22:12 +0000
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
Subject: [PATCH v3 16/16] mm: replace remaining pte_to_swp_entry() with softleaf_from_pte()
Date: Mon, 10 Nov 2025 22:21:34 +0000
Message-ID: <d8ee5ccefe4c42d7c4fe1a2e46f285ac40421cd3.1762812360.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1762812360.git.lorenzo.stoakes@oracle.com>
References: <cover.1762812360.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0310.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a5::34) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|IA0PR10MB7622:EE_
X-MS-Office365-Filtering-Correlation-Id: 25aa71ee-38fa-4312-2a1c-08de20a7988a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?E37ctphzNvedEdhPq1SNKxdKYndnwxvbFk5Sb5HhFBukiOB3IiQ3KIwKf0B5?=
 =?us-ascii?Q?PbjuYOlCOxrUiOnYxSX9Y/Jp9m7Mb/hgrhFef02SWckL0pqpmgsFUjHD3E7C?=
 =?us-ascii?Q?GE3EkF/qPr1JOoATL4HNstjGkAuWRfFbTLSQplEPLoKI7ltej6k2hqGO2MVi?=
 =?us-ascii?Q?r8g3hR4j8AXDCzzaRy6sLs4kU8wi5M17nLGnQt44vEK4hnY+qDjUJR+BMSEm?=
 =?us-ascii?Q?yGWg+JbkKwPHGE3ij8BjXS2nYh6rde8HcpxvqZuNXYGoXewEqpQCpvXkJcY+?=
 =?us-ascii?Q?7YV3geK3tqN+44LplNZbZ7pn9U+IC2r21/6x5L+0KG/RJJ4UcZsHLrK2GSA+?=
 =?us-ascii?Q?4oSjIZAkewWy+Dw845QlUTtO6JQrEkaXUIwLXzFxWtEoeffxi/qKBk+7COFi?=
 =?us-ascii?Q?HkacMam0OBFxaNgFuUvOtLVnLBfvkxkl6HYBDeB5XNHVm0RiWm6CiSOnKXU8?=
 =?us-ascii?Q?3p+EbNck8YwhfK9Jm+3Qs+QcNSAEtftVwb0WLJkkvtZKb2Yn7+B8/NOJLyRo?=
 =?us-ascii?Q?za/QNzO+EOdIrSNjQbMYeTWFbFAAMMjtqHYmxJUqXfm/yQVZUezu8l/z0t1P?=
 =?us-ascii?Q?yO7Dl2/SLPYDFfVgXWSbp9AV9LQvJdYYOzsTvcgXzFnTqF3pqPn6jCNXPow/?=
 =?us-ascii?Q?1qfRa4hGf8C9fBpm6LMI6zwatrN5ArKCZkfwR4iO9WS7yeSavBGDTqT3lchB?=
 =?us-ascii?Q?IYuy+ufQKHo8sa9oLklAm/Gpfp8fvlTIxKlCKKlNDVrAJKgeTmW1hYPymuvO?=
 =?us-ascii?Q?x42GzHL3zYr/fKnjv5AYAk4i9mAH9p+bKJeuCrhfpu4UpamecElT78zS/cbv?=
 =?us-ascii?Q?eaFsULagvgZkEd+qbSHjpzghg2kA+k23/7dXwiNj9i6yy5Mh4CeIAdzLD7j7?=
 =?us-ascii?Q?/vOYCZglhNsybGlezHHQPlP1KBWS72qDyQZJu3xxIpvohdK4QUecNFXrNrzs?=
 =?us-ascii?Q?ZcYG9D2k71XI1+gRwdYPOMPoQZS4UWoycCSL9JJtMUIMcHD7rvbpHzwSmnuu?=
 =?us-ascii?Q?r00AQJctbUfpReDEMZA6q1y8+GkYW3WgwbdGS8npmnR8zHD/Dex/IzDDAoaU?=
 =?us-ascii?Q?kS3wTM3DfMtUdUZfRubaU0bc4FwDbbq86ifX8+PGu4PmfsvB7A3DpLRW76AM?=
 =?us-ascii?Q?thFXc+qdxR4Lz0BNMnp3qo5Rg7sDQgVs1F0e/mTqsszolmHfEZpbhjkH0MIb?=
 =?us-ascii?Q?NMmmHbIa5GLleJW6JfDiog+tB7YhLobM4g6pF5M/XI8AtkyiI2pMduJkNFyX?=
 =?us-ascii?Q?9vqRTkuIufoytGrkjio4Aczx2XlFU+sBA+4LQi7iqCvFlqToA2P3HK48ukRN?=
 =?us-ascii?Q?2WmmEuvV8613hKDRNUN2KF1x4zO5iS86v8wppVWi0BrlbTz2owY0fJxeodrh?=
 =?us-ascii?Q?9aZclfv7eyJEM6FhB27HwnbR1U2t4ti/8IxcUUDbEZKwRqzPSlAe8kdxOR58?=
 =?us-ascii?Q?PLGxmUgWdhAebTL9rIjhO9qKQoi0OzN5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VmqL8Rz1uDsGgqrASahg5QW/1MjG+KMrurFseiRkrQdl0B7wC+LVaddZpCiY?=
 =?us-ascii?Q?MLDRhvt/ErKuaw5fMY91NAnOo2Rb+ekosNRKcZtXz6kiqV4uKovIE3n1m7fz?=
 =?us-ascii?Q?OdcPysFcK9+OEJryKy5e7w8MhskzeRBWz+iiuGaIB0eSB3SpGUFUNPYKRHRa?=
 =?us-ascii?Q?rpf7sij9PPl0TyJhBzTeAZGy9kAlUDPt1jGKZBNfl6O/l8vzU6gxB9tJu0Z6?=
 =?us-ascii?Q?BM3vpVJJi1h7ULxLuJ6Xe2IfXDIUXTU6DDPQZ7WgP6NJeEACr4MgLqPP7F59?=
 =?us-ascii?Q?ZcDaugV8acAKIiDKJzcxquF/M7CjmYoIn9NxGK8NH0CFfo6fwLMxsDQZsaxx?=
 =?us-ascii?Q?eoJMCFjr9WuXG9tp6IUmZDG++RuwPmEHwcRyf+Y8yK4umOp5TsIOXBMBHRlO?=
 =?us-ascii?Q?pzQy6tBt/4i2JSIee3rXwRtJbC6wAB5oygUVjCBmmdK50U0skQRlU6dBj8Kj?=
 =?us-ascii?Q?ANlWeTFRdXQenp4bysbxOTjxsPkEjgsFdFjS7Y4H4u9KOlT2HlGIZjqxA35g?=
 =?us-ascii?Q?UlW5A23aIyHqsyYBkcBQMhzd3BQB/AkIQZ6tz/+0MyFfAvxKjBWMhvpi8ZtT?=
 =?us-ascii?Q?oSfwqR4EOCMoM1nKWHoC2+q/R8Lrd74AnpHChCFPdAPsi9fUJxgWQrL4Mie9?=
 =?us-ascii?Q?TNlRLFwdVGg9VQXTcpI5Y1+EbicN8rU7i7wRgvex3cPhNCgpgUb1gnBCcV5Q?=
 =?us-ascii?Q?gusj+39HyciDnjy6saTjgj6yvpR2Hx9fCKX/NEiUVpWbBMaY3Wa7N1T3wpM9?=
 =?us-ascii?Q?nYRr7ibgcjK9LFSp+Um4MbS0JCw0DplqOLZtTVwevFSmFW4w5yawoc3fc4jw?=
 =?us-ascii?Q?17/UrvsdzY8vsOg50i9iAYPuJgdtiQffDZwtDPnYphAx8Pt98csJ7ljuKR/b?=
 =?us-ascii?Q?6LW9TQUsc9P6l14V8YkqJ4EJL2SQkqKh9AIwv6+32w3BxpkejT8Y3jUUn0P5?=
 =?us-ascii?Q?OlESR4oHQ7XtDQzHQlxXF6Z8y1aEoWIXvIwCtM4KH86uUj5P/CbgolTq3fTT?=
 =?us-ascii?Q?/o8/S8zzMfgd7PoAy1kBzXhjiY0qn3us8cmRUOfnUSFBJx4W2BamIl0nsLOK?=
 =?us-ascii?Q?m4I7nYHExlnLhTyCKJu3IExQcqhbldqM0rCZe3HE8Gw5jSK/tu21Btt/W6U/?=
 =?us-ascii?Q?25wau6SP3s3i2VeU3QRYnPC48e0XbekEFDlOUeQPVivd8g2YoU+v2MvwRQA0?=
 =?us-ascii?Q?REY8gR5EJMjCXvFa2JS7BGTTy8yuHrNKei0c442K3ZtcDs97zz9Lv+oc/G4T?=
 =?us-ascii?Q?TmL+nagMoWTUC8JjBS6nAAJexr+vmcrDLNPDqPmaxhFt4bcsknv67tx0UjVR?=
 =?us-ascii?Q?lQlnWQPjKG+PLEH7rGYJ0quccfxR8iic9TjdHP7Lu0r7Adxvyiv2vVllfCHY?=
 =?us-ascii?Q?zqFROlQIdP7JKrMXIcqCvq6VLR/DlKSYNgsX86Y/oON/P694V7WkVXaITiXH?=
 =?us-ascii?Q?vviG7OGdUEH6Tt15mXSjU4+o3rmLuve2bX6qtOUfWzQjFIBae7Vwcgi5qQeV?=
 =?us-ascii?Q?0mHiotVSV69gUeamOM6dLKKPZXvtsOYm/U/PtJ2UxEVpVnvWpbbX1z16W9D/?=
 =?us-ascii?Q?Kv5eP3KPAUsYt8QnrdeGB+Yun+pgixVWc1D9+9lQxNSgYZKMBBc4hu/3s0V+?=
 =?us-ascii?Q?JA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	nfkXx3GZM2wQiT1hHV37Xi/IbWxCCni1RBSUy9XoLhdVcD249Umyf21Q9tKJYeFgpf3vuVw3C9oGJig4cQgG1BtNQC9tA0QPCEI5gfOvsGCJkt71TFTInnG8aAIvZ7j95zSy/nunKon2MCqKHItLMKlNr2yCvuczVON9i5tVfvYlbYPSuXPPSbpiHHto7ayBBBrPOgT/QzcOz3M5caW0B6s+Ah0O80rwu2uTYL7idlTNc4OeFJgxghq6SR9PZFLHKx6OCViXYe8wpt3eNg71D7ETv4m5Q/wWN+WXK4P821tAWJSjM8UJ+UdinX0BzbW8J0k6Wucaj1Ed59ZAMmR6FDl1cQ/U++SoymGC2NwBN0d+ouSj7VzbpdDpqZmVBXj7KFj7+bqCH4g6jvgzArDXa0erNuSFnpjhwjMf7+3SKsIUP4QcbL1DENYcyDrnihcrAVfVEvxVf70iOgg9vhkQ7gGB6gOpQPtVWPbXv6ue1JtlaBaR7FMbjzNMJLmODZG2iv/qsDasHXYPPVJd96Mkn/7Yovn8u99m5bK8YHklR/4CqZvrtBh0yvC/nXYHRxya0l7/NSebfPV3/iQd98LMNVjZCQveLx9VBmGenmmh/qQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25aa71ee-38fa-4312-2a1c-08de20a7988a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 22:22:12.5575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3LsFGTbK8iOJwZxQlzOOHyFhD59/p6LzkeZydDhnSXTfXE24LWza/Iv8C3Xl3ZyjoVwEw5v6bjLoAWWsaUj4E0tXrPlZ+qeuNCHxcSmURko=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7622
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_07,2025-11-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511100190
X-Authority-Analysis: v=2.4 cv=WP5yn3sR c=1 sm=1 tr=0 ts=6912659a b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=0t1AzniXCxXm8NuIC04A:9 cc=ntf awl=host:13634
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDE2OCBTYWx0ZWRfX5HjwD9LYsd1N
 gAPx02txgluoX9MuH3ztbHnHnqzbGP1/fYHForf9mof/+yVBqejnEbUjOejsVTBxjmC+zhUN+ma
 PYwKKbSPBk5sKDHWrbL6qqahswT7Pt3rlXpKbRA0DSaLH5KmZMtxdQVXpe2QuHs9OhFBBakpEd0
 LOWx3Aj6kZ7jRBRNZLr4dA3HMIRqgYFU8BG54AwhUeGqpjaNEIcXdWkUD4wKbYhrFPTj3PLkLBY
 5hT2pCjVwh1tuRsHpQtozTKp/vEcAv7N4ZvKK7bOsJAtVZDJ6RaJ+P3WLOMcKQ6QzzzQiCYM7Nv
 XRuhsY9b7uNDm+qFzy0kRYK2Impk1kybaHSUqJ45euvceXd1j9qEfKmUYn5gKEnlGGaFgyLrk74
 VgiUp0VNHoS509nB11YthjFIAG9a4G8LzUkbJEPAwTflc1aPaCg=
X-Proofpoint-GUID: e4aJF2VH7aYZEPurwjyDyH_BLue2Wlcl
X-Proofpoint-ORIG-GUID: e4aJF2VH7aYZEPurwjyDyH_BLue2Wlcl

There are straggler invocations of pte_to_swp_entry() lying around, replace
all of these with the software leaf entry equivalent - softleaf_from_pte().

With those removed, eliminate pte_to_swp_entry() altogether.

No functional change intended.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 include/linux/leafops.h |  7 ++++++-
 include/linux/swapops.h | 13 -------------
 mm/debug_vm_pgtable.c   |  2 +-
 mm/internal.h           |  7 +++++--
 mm/memory-failure.c     |  2 +-
 mm/memory.c             | 16 ++++++++--------
 mm/migrate.c            |  2 +-
 mm/mincore.c            |  4 +++-
 mm/rmap.c               |  8 ++++++--
 mm/swapfile.c           | 13 +++++++++++--
 10 files changed, 42 insertions(+), 32 deletions(-)

diff --git a/include/linux/leafops.h b/include/linux/leafops.h
index d282fab866a1..cfafe7a5e7b1 100644
--- a/include/linux/leafops.h
+++ b/include/linux/leafops.h
@@ -54,11 +54,16 @@ static inline softleaf_t softleaf_mk_none(void)
  */
 static inline softleaf_t softleaf_from_pte(pte_t pte)
 {
+	softleaf_t arch_entry;
+
 	if (pte_present(pte) || pte_none(pte))
 		return softleaf_mk_none();
 
+	pte = pte_swp_clear_flags(pte);
+	arch_entry = __pte_to_swp_entry(pte);
+
 	/* Temporary until swp_entry_t eliminated. */
-	return pte_to_swp_entry(pte);
+	return swp_entry(__swp_type(arch_entry), __swp_offset(arch_entry));
 }
 
 /**
diff --git a/include/linux/swapops.h b/include/linux/swapops.h
index 3d02b288c15e..8cfc966eae48 100644
--- a/include/linux/swapops.h
+++ b/include/linux/swapops.h
@@ -107,19 +107,6 @@ static inline pgoff_t swp_offset(swp_entry_t entry)
 	return entry.val & SWP_OFFSET_MASK;
 }
 
-/*
- * Convert the arch-dependent pte representation of a swp_entry_t into an
- * arch-independent swp_entry_t.
- */
-static inline swp_entry_t pte_to_swp_entry(pte_t pte)
-{
-	swp_entry_t arch_entry;
-
-	pte = pte_swp_clear_flags(pte);
-	arch_entry = __pte_to_swp_entry(pte);
-	return swp_entry(__swp_type(arch_entry), __swp_offset(arch_entry));
-}
-
 /*
  * Convert the arch-independent representation of a swp_entry_t into the
  * arch-dependent pte representation.
diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index 64db85a80558..1eae87dbef73 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -1229,7 +1229,7 @@ static int __init init_args(struct pgtable_debug_args *args)
 	init_fixed_pfns(args);
 
 	/* See generic_max_swapfile_size(): probe the maximum offset */
-	max_swap_offset = swp_offset(pte_to_swp_entry(swp_entry_to_pte(swp_entry(0, ~0UL))));
+	max_swap_offset = swp_offset(softleaf_from_pte(softleaf_to_pte(swp_entry(0, ~0UL))));
 	/* Create a swp entry with all possible bits set while still being swap. */
 	args->swp_entry = swp_entry(MAX_SWAPFILES - 1, max_swap_offset);
 	/* Create a non-present migration entry. */
diff --git a/mm/internal.h b/mm/internal.h
index f0c7461bb02c..985605ba3364 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -334,7 +334,7 @@ unsigned int folio_pte_batch(struct folio *folio, pte_t *ptep, pte_t pte,
  */
 static inline pte_t pte_move_swp_offset(pte_t pte, long delta)
 {
-	swp_entry_t entry = pte_to_swp_entry(pte);
+	const softleaf_t entry = softleaf_from_pte(pte);
 	pte_t new = __swp_entry_to_pte(__swp_entry(swp_type(entry),
 						   (swp_offset(entry) + delta)));
 
@@ -389,11 +389,14 @@ static inline int swap_pte_batch(pte_t *start_ptep, int max_nr, pte_t pte)
 
 	cgroup_id = lookup_swap_cgroup_id(entry);
 	while (ptep < end_ptep) {
+		softleaf_t entry;
+
 		pte = ptep_get(ptep);
 
 		if (!pte_same(pte, expected_pte))
 			break;
-		if (lookup_swap_cgroup_id(pte_to_swp_entry(pte)) != cgroup_id)
+		entry = softleaf_from_pte(pte);
+		if (lookup_swap_cgroup_id(entry) != cgroup_id)
 			break;
 		expected_pte = pte_next_swp_offset(expected_pte);
 		ptep++;
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 6e79da3de221..ca2204c4647e 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -50,7 +50,7 @@
 #include <linux/backing-dev.h>
 #include <linux/migrate.h>
 #include <linux/slab.h>
-#include <linux/swapops.h>
+#include <linux/leafops.h>
 #include <linux/hugetlb.h>
 #include <linux/memory_hotplug.h>
 #include <linux/mm_inline.h>
diff --git a/mm/memory.c b/mm/memory.c
index accd275cd651..f9a2c608aff9 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1218,7 +1218,7 @@ copy_pte_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 	spinlock_t *src_ptl, *dst_ptl;
 	int progress, max_nr, ret = 0;
 	int rss[NR_MM_COUNTERS];
-	swp_entry_t entry = (swp_entry_t){0};
+	softleaf_t entry = softleaf_mk_none();
 	struct folio *prealloc = NULL;
 	int nr;
 
@@ -1282,7 +1282,7 @@ copy_pte_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 						  dst_vma, src_vma,
 						  addr, rss);
 			if (ret == -EIO) {
-				entry = pte_to_swp_entry(ptep_get(src_pte));
+				entry = softleaf_from_pte(ptep_get(src_pte));
 				break;
 			} else if (ret == -EBUSY) {
 				break;
@@ -4456,13 +4456,13 @@ static struct folio *__alloc_swap_folio(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	struct folio *folio;
-	swp_entry_t entry;
+	softleaf_t entry;
 
 	folio = vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0, vma, vmf->address);
 	if (!folio)
 		return NULL;
 
-	entry = pte_to_swp_entry(vmf->orig_pte);
+	entry = softleaf_from_pte(vmf->orig_pte);
 	if (mem_cgroup_swapin_charge_folio(folio, vma->vm_mm,
 					   GFP_KERNEL, entry)) {
 		folio_put(folio);
@@ -4480,7 +4480,7 @@ static struct folio *__alloc_swap_folio(struct vm_fault *vmf)
 static bool can_swapin_thp(struct vm_fault *vmf, pte_t *ptep, int nr_pages)
 {
 	unsigned long addr;
-	swp_entry_t entry;
+	softleaf_t entry;
 	int idx;
 	pte_t pte;
 
@@ -4490,7 +4490,7 @@ static bool can_swapin_thp(struct vm_fault *vmf, pte_t *ptep, int nr_pages)
 
 	if (!pte_same(pte, pte_move_swp_offset(vmf->orig_pte, -idx)))
 		return false;
-	entry = pte_to_swp_entry(pte);
+	entry = softleaf_from_pte(pte);
 	if (swap_pte_batch(ptep, nr_pages, pte) != nr_pages)
 		return false;
 
@@ -4536,7 +4536,7 @@ static struct folio *alloc_swap_folio(struct vm_fault *vmf)
 	unsigned long orders;
 	struct folio *folio;
 	unsigned long addr;
-	swp_entry_t entry;
+	softleaf_t entry;
 	spinlock_t *ptl;
 	pte_t *pte;
 	gfp_t gfp;
@@ -4557,7 +4557,7 @@ static struct folio *alloc_swap_folio(struct vm_fault *vmf)
 	if (!zswap_never_enabled())
 		goto fallback;
 
-	entry = pte_to_swp_entry(vmf->orig_pte);
+	entry = softleaf_from_pte(vmf->orig_pte);
 	/*
 	 * Get a list of all the (large) orders below PMD_ORDER that are enabled
 	 * and suitable for swapping THP.
diff --git a/mm/migrate.c b/mm/migrate.c
index 182a5b7b2ead..c01bc0ddf819 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -534,7 +534,7 @@ void migration_entry_wait_huge(struct vm_area_struct *vma, unsigned long addr, p
 		 * lock release in migration_entry_wait_on_locked().
 		 */
 		hugetlb_vma_unlock_read(vma);
-		migration_entry_wait_on_locked(pte_to_swp_entry(pte), ptl);
+		migration_entry_wait_on_locked(entry, ptl);
 		return;
 	}
 
diff --git a/mm/mincore.c b/mm/mincore.c
index 9a908d8bb706..e5d13eea9234 100644
--- a/mm/mincore.c
+++ b/mm/mincore.c
@@ -202,7 +202,9 @@ static int mincore_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 			for (i = 0; i < step; i++)
 				vec[i] = 1;
 		} else { /* pte is a swap entry */
-			*vec = mincore_swap(pte_to_swp_entry(pte), false);
+			const softleaf_t entry = softleaf_from_pte(pte);
+
+			*vec = mincore_swap(entry, false);
 		}
 		vec += step;
 	}
diff --git a/mm/rmap.c b/mm/rmap.c
index 345466ad396b..d871f2eb821c 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1969,7 +1969,9 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 		if (likely(pte_present(pteval))) {
 			pfn = pte_pfn(pteval);
 		} else {
-			pfn = softleaf_to_pfn(pte_to_swp_entry(pteval));
+			const softleaf_t entry = softleaf_from_pte(pteval);
+
+			pfn = softleaf_to_pfn(entry);
 			VM_WARN_ON_FOLIO(folio_test_hugetlb(folio), folio);
 		}
 
@@ -2368,7 +2370,9 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 		if (likely(pte_present(pteval))) {
 			pfn = pte_pfn(pteval);
 		} else {
-			pfn = softleaf_to_pfn(pte_to_swp_entry(pteval));
+			const softleaf_t entry = softleaf_from_pte(pteval);
+
+			pfn = softleaf_to_pfn(entry);
 			VM_WARN_ON_FOLIO(folio_test_hugetlb(folio), folio);
 		}
 
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 684f78cd7dd1..e5667a31be9f 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -3201,8 +3201,17 @@ static int claim_swapfile(struct swap_info_struct *si, struct inode *inode)
  */
 unsigned long generic_max_swapfile_size(void)
 {
-	return swp_offset(pte_to_swp_entry(
-			swp_entry_to_pte(swp_entry(0, ~0UL)))) + 1;
+	swp_entry_t entry = swp_entry(0, ~0UL);
+	const pte_t pte = softleaf_to_pte(entry);
+
+	/*
+	 * Since the PTE can be an invalid softleaf entry (e.g. the none PTE),
+	 * we need to do this manually.
+	 */
+	entry = __pte_to_swp_entry(pte);
+	entry = swp_entry(__swp_type(entry), __swp_offset(entry));
+
+	return swp_offset(entry) + 1;
 }
 
 /* Can be overridden by an architecture for additional checks. */
-- 
2.51.0


