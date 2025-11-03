Return-Path: <linux-fsdevel+bounces-66772-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5513EC2BBD0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 13:41:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEDF71882D98
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 12:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 224DB30C629;
	Mon,  3 Nov 2025 12:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AcpcuahU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tjS7+hcz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D59328EA56;
	Mon,  3 Nov 2025 12:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762173503; cv=fail; b=RrMxsVOHQOWORSxGtm6J6k9ynlLhkRrscEsbZ55CbVklIMVDJynDYSIJVorVWqMfM2ERh6jkwWF3t2gI3UWYz+mJuVFfK2ODOPyrMJ9sSKmR0aW0fU0le7G/kcSmMmxD4826FO3gOZBzp76UUn/3Yvui6AKOj6mjn7ohebwe+xc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762173503; c=relaxed/simple;
	bh=5gSGw5qMSaaZJEYbbFS50M+kyjoi5kiCXfiINcmbvv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rQQyBabyBiULgdakLlVRvwKQxWqcrUxiMWR438AbR5I2oQbGaN4AS72v+NaKR6IXVFF5oty+Ioak4dbxPTlPPjXjBPZZ29CkAPLVBEGFRDed2uXd3ZezIYhTF0rrFRKwvN2MRm10WCsakrqXTtbJT30eGCGshbKT4olkCCeFU0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AcpcuahU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tjS7+hcz; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A3CEfR7017288;
	Mon, 3 Nov 2025 12:32:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=iLrIYijzaZOaS2Eo+nw5Ch9zPYhpC9Fl/f+qqBMU9IM=; b=
	AcpcuahUznelIcURzuAjJZnzUOb9yle49mGCNtq6eQIDkgm2K/uYh0vY2XrvZxDx
	CWvH2BU0Kl4rAstcPymIGsBk8sRkb+i5C87mq5ty99+ivNesVOJozO2l1hNi4a0y
	zUP0Lk94+k841tPr6VwkhAiuvIZCcmDrGmpG2lvFo4gmiqZjHQ6omHolrCEMd3w1
	Li03NrWHybA5T1OGzKk60076d1JbxvyJogzbhAVW/91vZQ03dQaN8LkE8s1oJqq9
	FHS7Xt5cU858fafRbGnJ41AP77ekKSdqsiOpnGKjJ+2tFhyUXHuOefIVNOCKzN7K
	Dwxs+suuDebs/i+ldcgsHQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a6v7kg0x2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Nov 2025 12:32:26 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A3BVq3j039882;
	Mon, 3 Nov 2025 12:32:25 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010026.outbound.protection.outlook.com [52.101.46.26])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a58nhux3q-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Nov 2025 12:32:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FGbC4SbKb/y5dQ5ymRug58LgpnAkR3/52FnY8jbX/vZYKQnspvNH7NBuMATq78bSfSHbBV/8CyFKwDpE+b4bl+YIZ/S0uDH5/CKhpFariwCgapB+8FG1KQJsHQjS3VUt3CpcHk0aNmV+1/b4nigOLGL6vVKCRMLDIrosnkz8THIR2f2tqxJKmQ4C+0Y6sdUbbHxVwzR1NEC7s4GcGVBXd36jLslvlDf4G9IzDj65uMfRkk9k4S8yaxr5Ymrswi7dz6VXK/Guw9/8m1iQOLWgQsokbXDyJEC1Lghj7b4muiFZVqztYVjoETrfQX4FB9NiNcWAGcu4AuUEqewDHLrnuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iLrIYijzaZOaS2Eo+nw5Ch9zPYhpC9Fl/f+qqBMU9IM=;
 b=J0Of8FLoz0eEFUJDCoysoqYnwIbwzd07HaaM0rZtKvbZhXOAnCDbz7cCFrz6pyS8PRf4YWRjwSHXHNfwzRXfLnKFx5DKwMobXh8rbCr/kV98eZ6VAAWq8K+Tn0aimSqaLLATMc4vWfeKMh8El2rdgMOd97C311DY0HIyF8YFQrZOklHCvonkLJqAs1P1432PBAv/2oKx17G8x83utlaGLH6qq6X+4pr1ZVUivu81G9L/nLNd/wlYxplppoiJ2+AdJRrbYGZ3B+i7qGG88fK1Lydo5qBRJJ8v+dCTtJ5Z5VjYikU1AlrtFymuFJyHKn6YFG1sqYQtY8TZU3S48Mzkqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iLrIYijzaZOaS2Eo+nw5Ch9zPYhpC9Fl/f+qqBMU9IM=;
 b=tjS7+hczhpqUFdHJzu/510+/UwCk8QOnQ6c3C8SyWLY9FFIrM1tceYwB5EvjxEEt0Fg2fhdoTpCC4r9IP4dqvzzA57ItDN7NFEpm+CiAJ0dWLWDV3QFWLuRqLkYRhNPYAuU7atChPZfmpN5KolSeN19KrJPZeqMmMc61+XAh/iY=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS4PR10MB997575.namprd10.prod.outlook.com (2603:10b6:8:31e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 12:32:22 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9253.018; Mon, 3 Nov 2025
 12:32:22 +0000
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
Subject: [PATCH 05/16] mm: use leaf entries in debug pgtable + remove is_swap_pte()
Date: Mon,  3 Nov 2025 12:31:46 +0000
Message-ID: <55e0040009cbcd3bb4d4752d9e435ce9779751ba.1762171281.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1762171281.git.lorenzo.stoakes@oracle.com>
References: <cover.1762171281.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0037.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:152::6) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS4PR10MB997575:EE_
X-MS-Office365-Filtering-Correlation-Id: 126df1f6-9132-4c52-9cd1-08de1ad50951
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cSvrMfFDzAFCiL82fRHaWnlKjBMaa+xDZzTeE7cvXM8kDY2GJSiwdcLsUU6r?=
 =?us-ascii?Q?aaVriJKflaGLDHUdBLROjDx4jqeKYytixND0RhAXBVUNctuj93WoRLv6p/5N?=
 =?us-ascii?Q?atEps06MY+wqjn1Dk4loc4qDyaPAoLfpl4H7pQC0soAGxKgQPKCYoE1MGV5r?=
 =?us-ascii?Q?7nPLTzQMSGdDqYXxhoAfsotAlfOpOBWNW3uNxZOJqTR9cUSgcOKEEnwj7EYZ?=
 =?us-ascii?Q?JYMhDg7qZu5sjLnku7L9/LjgYcEyMCGhCgcVni+dpnE7G/sV6BHu/3dRxs1q?=
 =?us-ascii?Q?t/eOhKvi5GcIyOQQXZvP3z5hpowIgabj8RnYbukCeOF7dWvXuWdCwObvDan2?=
 =?us-ascii?Q?qV7qvbsBLCQmjhkapkRBega4cgl12VTGGWH2+bloMm0mW1p6QGR/JixW7yxL?=
 =?us-ascii?Q?TEfItV+l7pXm3MXCmlxM7Z3UVAD8DhMowchYT99bOFcmoeDRVr+Zpuw/6W27?=
 =?us-ascii?Q?xCZ1fJu6IL93fncHM6GjE+vLzBD0l4rQ6qipAmipMGdUTKYeW2w0PB7GxO/4?=
 =?us-ascii?Q?XmYXM95DOqeDonkNuASsjleM3bcGsx26mzOZHl6gt9Jrvqa3fKVK+ytQ7uF1?=
 =?us-ascii?Q?9CrftmE08KFn3SBs3+HpeKKiXk+RTG8ImrVuLy/oy9MMiXvpXJ+hMUrIGK3K?=
 =?us-ascii?Q?SItpeckZxm7V+mi5zwOULY73sZ7FEJwh4e7+Dcw1DOYTj3itKJuwzUj1Y1r5?=
 =?us-ascii?Q?RbtGx1EzxInOaRtcguE8WMYLAr02ypyfjOmucPKGmIp7o+/gE9Hd1+LDE5h/?=
 =?us-ascii?Q?jQ0l4G1NuVxWwYHx9IvnHIYZ+0/ckqFncbGuyueg8jFlloh84w9LWfyB1jYm?=
 =?us-ascii?Q?hTYEOXOliDS0J30mgchUNo4xBwuw1mSgd04080Nv4DS8hJjbxiXILjJPS0DN?=
 =?us-ascii?Q?N3y4f7haglTSy88JCwrU3GqzW3TzXLgVgCYHFw0Y4wYa9uMN21o9kO984jSy?=
 =?us-ascii?Q?MD5RNLMdKHI+UNJMmNabTwKvR/Bvlzv/nEM2nS5cXDV+vo54e1sQN9SN+v9G?=
 =?us-ascii?Q?qGl6DCweMJP6NMRAZ3d84SYQwlMiYB7KLVbu6f89esrtptaxpRVgRBEhRenN?=
 =?us-ascii?Q?SDglb+1GDh3Qqz3f0vltBj92NrBSlsEeSDtbDkhwJkmK1HoEgNJWpDbe/S2g?=
 =?us-ascii?Q?aNUGtyvjsm2HIy9rHdybhb9ZvqocWPQdvLTa1SGSuyJ+ZU4NaRRUwHg0Cp/e?=
 =?us-ascii?Q?3/bfwUkwwgn+pkdVkQ4lDJvO+BE6MZObzqwcK5chzuxaGe7Flj1TlyWLl9gB?=
 =?us-ascii?Q?lJ8vT9q6Q4yaUf+CAyn9SOEO9xXBYWL6MFKLduxKNpYyzv11Ojf2ItxJB1c1?=
 =?us-ascii?Q?qlERAOIZ/NQpBC/noNZ2lr5gV0qKhE2x11ZwZ4CHiVG2n4oohATi5tuvxFkx?=
 =?us-ascii?Q?61NmcaVymKG29FB9qUI/XjYZvHqpoQSgdnhktzKIkwPozA3l+c7pqpe0Xhyf?=
 =?us-ascii?Q?E/iiqBrpWS+5mHXxM7QoG+YZonQJIIQn?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?a5Qr4Qg/hXBHNg0BQGd6E+94gqNg04RL3EsbeXm44zed+Uo+1c0BZn6uRPN7?=
 =?us-ascii?Q?21UJeHB4VQ91UyjITIazXpTLt7XrJ+fGJXXUcuFwKtl5fWoJDvc90FL6cAhd?=
 =?us-ascii?Q?GAAlAWo/8YgdKhlbGB/BsBplYfU23+Hu3uaU7SdZjNnNJFMUFKdayWZYgXRh?=
 =?us-ascii?Q?03YgMN4xDd7g0wiO4vf6fTFAvVskcAM8uDHJUChiMP9Kj8kwwvu08XQPoUS8?=
 =?us-ascii?Q?w4C7c5oTQ0aCn+5V7ys8lcyoJn19U50TaQZxkmd5Qr3cE7PgpPXX1ry5p4ZJ?=
 =?us-ascii?Q?BzzvrqjR8YhLKJ/9kOl4m/gxpkwHXUC4z3TSKmyD8lC7preLaxR19bHgeWj+?=
 =?us-ascii?Q?aUwd1bIi7ltoBY5G36Gmhj39rvfmEE2xAXlG+C6d3UEpGmJxa4eX1yUeYR2w?=
 =?us-ascii?Q?8EWRjXPPf1AJ21lq1Px0Ki+e5jwMV2GWQv82ddLTcawHcfC+cu/r9j8VJPP2?=
 =?us-ascii?Q?A4zz+zDnsG3QdG/WtjNHrqspoP9JNdQpHggROorkC0ntn8PqnCJhuQpm1pHo?=
 =?us-ascii?Q?wbTMQmO9b4xlx7OWjjfpsGpxZsyOskTBCXO1ifnPybm4/6yh6XiJBdi3Yywh?=
 =?us-ascii?Q?Xw8n2juw490lh5i/upo8tBA0BIpiq1td00xkFxiacEndLZbA24tEbDeafgTQ?=
 =?us-ascii?Q?dJc5qQgoX3FxlvK6ztoisS9kHjN3rtJPD3+hGzuq1T5J1mqr7HY2PPja9ffJ?=
 =?us-ascii?Q?kNcdmZsnQ8PsBGzVD7iuiz3Bhd5LJw047RkRKKJWVLY8+l6cCr/mMyNkXuC1?=
 =?us-ascii?Q?5EBATobp9F2FOiYJ3yvbyUg4S+B7P7kWsTeQ/Et8jCmQ73S/fmYRSshNGPpc?=
 =?us-ascii?Q?AV6lsh4F0etlVUtIb/1QW5JVwfSY1I5PJxTB3zuFToCtPH4CGmQ2gxbUa3At?=
 =?us-ascii?Q?tY2f4fkkVhXuE3kYloAwvOu8a6dHFgCiEMI5C1wcVlfHibaXs+OXTzruVgqo?=
 =?us-ascii?Q?Y5zOLdlAVwCLHjcH6qbeoneBfauPZct1a+lyiAnYI8U2ZBe+g/8zww1jzFzQ?=
 =?us-ascii?Q?AYMz8tpW0O/eOxktZYJC8CEL+7XIqHLrR7wmXEsH2kfJI+G5eaKOpGlRzezv?=
 =?us-ascii?Q?TShnKx7os8OLs516/4KHWab0AiCPHyZx4WMUGRyU+OP5t/L9V5g/8l00k1Pl?=
 =?us-ascii?Q?EPjAkIxueSJKL0pPXK1a4CPYImyeIsUNNLnEpbn3GlPS8X6DKHd/o6E/5E82?=
 =?us-ascii?Q?rYGa0MVd/23x7oUO75+BYYmh5OaQHJ5tAxJXNlAuNzy9L96nryq1Hpz0fplH?=
 =?us-ascii?Q?+eoTdsgiEL5QvSM9T/+d9fzWVcjEwkQ8zKa4yG/P94iqz0nXA4VdLNXuAuG1?=
 =?us-ascii?Q?GJoJoWn/Gkf6tg13Pz6XePx3v7XV5fFGXYhpAKwE/PJZkKGs8DnKknL0putb?=
 =?us-ascii?Q?4UfgAhS3qONuVi32N6WS1IvnK97ZmAq6kWbQ5XgdCIfIpKsKTzPisiFOCNQs?=
 =?us-ascii?Q?mF9hcpjj2FuDUa7zt+VhxHRxtULhOcwV/zrNmVYmRyPo0kYdwkiCkPiHZ4l8?=
 =?us-ascii?Q?8mo71yyvFD91Darxi4sIgnteSEpbE7Dg8Tv1Tasb/pmJ/AZYt6eq7uO+IUuj?=
 =?us-ascii?Q?Xwrkck3QSgJ5wOUgFPvjMiYenBtMn8dnm9AerLGG97KUHggWjesPINSCiybr?=
 =?us-ascii?Q?aw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dcEyKGz1cOzINzk2b8WOcHHoFU+Sdt6UeL0ywZgfRdkK6DJPclqleNL2PKlf2HxuQ3DyzwWwzUKBSjwmrYwNQbK/u+DKz5h2WMs7KeP0A+YktcCwjdzxdzb68oNdjQDEabj0HSMXTYDiCf4IDyGMzSvrPMAbWSqeV10+1TSCBEI/EmBTI2bQ2N2TbQE0WhvOVcVMhYj1lBU3Qa/Z1PHlGGXdNyndBOikPFANgn/iZfyrTfe61wXPxgCCFOA4/Yao7NyKw7Dfoyg2vYjo/Wmb6L2N3lUjHeg0tiIotJFdwEQdC5ErF3gtbfACjDxYMom7mkugU+1D84Jrqk4byCMnI7oe1YL4BnpIY59TGO7w4Uf9bD+AbcQDf73kxWgDPQDXINlodeiQxFpBich8WjsXxytNRvd5KXVCdegLGQRytxftZiqCwUehREP1N5r3mIWIdTMe22V7o/TC9+77woouK7ZQDtW+wjR1Rpy84sS+MILbyiyMdw3xtKyRjCcV/LAgJyjQU52fwvLaiKAWzSIKHMtL3SDbHZMLS6VJxFcqFlV2ChxuqYtBEwHtbJ1/6bBOuBI3MQ/7h5NqeM08pdSq9an4NvUidy7LZcrjQKHq2Yk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 126df1f6-9132-4c52-9cd1-08de1ad50951
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 12:32:22.1681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jKKbNzViYlx+hhVSGOW34kCvT0x6JEC8HRxECv+0vXglrKufCW9OVGuWctKo99FUIlv6Xh1vL+mzKu2vWs+j7rF3YWVnORGlyQwtPiMrxnw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR10MB997575
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_01,2025-11-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 suspectscore=0 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511030113
X-Proofpoint-ORIG-GUID: hp4P3v8rnCaxwDKfCS7yowhymJMlEgck
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDExMSBTYWx0ZWRfX5YiGaT6lCXZL
 9F8WHx/u0rXHzsT4v9xCUXQGSdsDD1nuANEhbeCnJTuuoVmo/gPgXrO5b+llGVIt/TJHZ2yo4S5
 PeNNRCoe2/tcPoJKo05pG9vg/0+6I3xkLJMQTRtsSe5MCAGdtrqQHP3Cdi/4fKlui6gY/mtSkFu
 ZkHNWFZQK1al78L76hW8ML1TXG4PppgdEVkDbmMT0VIi4KST9/Dq+fiBh18cnjtSh+TWGUWlgWW
 GYFM/7HWxoKiy50ntUOlE1Ho4mwaqWCVypVqIyeOsN+80cjugTfyTWLefqwXrRDlCO13vBGF0X8
 UJWxBCXbGEyX0rOkrOk69ghihrM9nh7gKoeN1dUB8lIWEF4pupUB9b1OdwjwJlPqrQxCPpqHBbP
 yeIek0lzLykyizWwKOHrrM+wpN3aidDugcG6fRtuI5FEh4Ene88=
X-Authority-Analysis: v=2.4 cv=Fbs6BZ+6 c=1 sm=1 tr=0 ts=6908a0da b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=JfhMdzgkenBfAv4L-EYA:9 cc=ntf awl=host:12124
X-Proofpoint-GUID: hp4P3v8rnCaxwDKfCS7yowhymJMlEgck

Remove invocations of is_swap_pte() in mm/debug_vm_pgtable.c and use
leafent_from_pte() and leafent_is_swap() as necessary to replace this
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
index 055e0e025b42..f0f5fbc13784 100644
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
+	leaf_entry_t entry;
 
 	if (!IS_ENABLED(CONFIG_MEM_SOFT_DIRTY))
 		return;
 
 	pr_debug("Validating PTE swap soft dirty\n");
 	pte = swp_entry_to_pte(args->swp_entry);
-	WARN_ON(!is_swap_pte(pte));
+	entry = leafent_from_pte(pte);
 
+	WARN_ON(!leafent_is_swap(entry));
 	WARN_ON(!pte_swp_soft_dirty(pte_swp_mksoft_dirty(pte)));
 	WARN_ON(pte_swp_soft_dirty(pte_swp_clear_soft_dirty(pte)));
 }
@@ -768,40 +770,47 @@ static void __init pmd_swap_soft_dirty_tests(struct pgtable_debug_args *args) {
 
 static void __init pte_swap_exclusive_tests(struct pgtable_debug_args *args)
 {
-	swp_entry_t entry, entry2;
+	swp_entry_t entry;
+	leaf_entry_t leafent;
 	pte_t pte;
 
 	pr_debug("Validating PTE swap exclusive\n");
 	entry = args->swp_entry;
 
 	pte = swp_entry_to_pte(entry);
+	leafent = leafent_from_pte(pte);
+
 	WARN_ON(pte_swp_exclusive(pte));
-	WARN_ON(!is_swap_pte(pte));
-	entry2 = pte_to_swp_entry(pte);
-	WARN_ON(memcmp(&entry, &entry2, sizeof(entry)));
+	WARN_ON(!leafent_is_swap(leafent));
+	WARN_ON(memcmp(&entry, &leafent, sizeof(entry)));
 
 	pte = pte_swp_mkexclusive(pte);
+	leafent = leafent_from_pte(pte);
+
 	WARN_ON(!pte_swp_exclusive(pte));
-	WARN_ON(!is_swap_pte(pte));
+	WARN_ON(!leafent_is_swap(leafent));
 	WARN_ON(pte_swp_soft_dirty(pte));
-	entry2 = pte_to_swp_entry(pte);
-	WARN_ON(memcmp(&entry, &entry2, sizeof(entry)));
+	WARN_ON(memcmp(&entry, &leafent, sizeof(entry)));
 
 	pte = pte_swp_clear_exclusive(pte);
+	leafent = leafent_from_pte(pte);
+
 	WARN_ON(pte_swp_exclusive(pte));
-	WARN_ON(!is_swap_pte(pte));
-	entry2 = pte_to_swp_entry(pte);
-	WARN_ON(memcmp(&entry, &entry2, sizeof(entry)));
+	WARN_ON(!leafent_is_swap(leafent));
+	WARN_ON(memcmp(&entry, &leafent, sizeof(entry)));
 }
 
 static void __init pte_swap_tests(struct pgtable_debug_args *args)
 {
 	swp_entry_t arch_entry;
+	leaf_entry_t entry;
 	pte_t pte1, pte2;
 
 	pr_debug("Validating PTE swap\n");
 	pte1 = swp_entry_to_pte(args->swp_entry);
-	WARN_ON(!is_swap_pte(pte1));
+	entry = leafent_from_pte(pte1);
+
+	WARN_ON(!leafent_is_swap(entry));
 
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


