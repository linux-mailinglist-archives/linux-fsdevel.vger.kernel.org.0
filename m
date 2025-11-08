Return-Path: <linux-fsdevel+bounces-67550-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B379C4314B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 08 Nov 2025 18:18:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4D3B34E8507
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Nov 2025 17:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E4924678E;
	Sat,  8 Nov 2025 17:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ltaDTdCN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Sn+nWGYp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C747E1448E0;
	Sat,  8 Nov 2025 17:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762622141; cv=fail; b=Q3RTlb1eaq8d8Mpr7zd1eKHtUfslEpmS5sv2RBthVrDwn8WnAy3BbMe7QtMu8QUyLoGAm42uxmzK03PoOhyu40L6GR+Stpt/8KL0flH8VgaGRZh3Wd1R9JWLXZf/xsFl8GoXEtRXWvibZpo3ayCVx29kNyol87Cd/7XL8osgz7E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762622141; c=relaxed/simple;
	bh=SGCSom7NQN4a5UuTz6cnQyKevdTqh7TJ1tPjPhx7f2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fqZJyY6z8Sv9mEG/Jm1/Tbv5tByCF8GzwjaJmvQhnaHbS3VXDGUbnRtVIoYp29RZ00fbxuUI/+Vo4lFuCDUgr91joFoetr7fvH2eyo4d+7AmDoQqwDse5EC+3Uru/rAFXS7D7TLk/fHgytZ+ZTYtbnxdQs9Yk8NxX6+MJilb1Yc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ltaDTdCN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Sn+nWGYp; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A8FpXSu008953;
	Sat, 8 Nov 2025 17:09:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=FrZyx+G0nFRqqG3Ukf0WKDJ2lnH9WlkIF2fwTUy9qzA=; b=
	ltaDTdCNB0SOBwpDtGmVIwAyDSPFxLYSI7I/0+PHMGh+MxT2ysbUZfgYqHnv/MYJ
	n8u0R1xHrG5PZxUW/5pyYY9OzVESZ6HhP0j3vKFU2kmr/u7TfkcOqtahvD7hrZ4b
	hgp+70rW8YngtLBC3Me3veI5WyZTQpsxGkbn/OxvQKkQ6Gv2rq/DNUSRDB3Ja8HN
	QIcVax0Pf5zBL7i+o5MY9mospjwOvUKqxurvKUvs2PeA2I4Q3kCW8vERFtJNgBno
	V6J7ycVaXhIfbmHYggqBPMb9ZWSeJkIqPigwPFmuKmysXChilHKc1g75lABnzOuM
	hUybIgNB4QdOAvgvSMzxBg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aa6vh84sx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 08 Nov 2025 17:09:40 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A8BijdP007604;
	Sat, 8 Nov 2025 17:09:40 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011002.outbound.protection.outlook.com [52.101.52.2])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9va76n3y-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 08 Nov 2025 17:09:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W7Icn/7ZMDwUYC0tzdkywBrUfmnsjao1Cmc80PWs7bH8XqKu/0C5SMgPE/G1tfnw/oo0F6rrwF2IaTKDgJ6bsacjGsyW3wTzEXpJXDfKc3qWAN60/gcBc7JvC3/6CEFqIUJYK7fLZ2R0qjnqMQHhKyRTzK2rSU+zHiHxwsDTtRX9YvjeqqLMlaOExQHqo4RcoEIvHlnCxMyDBmV7nsKv0zhEaYQkyaJCBpFrgBfqbwTVUk0gImQkFJWkSZUfPXbVV4j4mLFetU7F10sPbRAg/TDO3120kqFhqz20/C0WMn07sUUetOt1xxMRKFa6lW/RgjnN/gtgHd2b9yR0WbGI7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FrZyx+G0nFRqqG3Ukf0WKDJ2lnH9WlkIF2fwTUy9qzA=;
 b=XNgeIMAJ6EDwDj43whEruOIlOKYDZLGwdYcx5sfsWVNpACJOOMuI3xugNaDbR6WJjAotgx1gpZnlE0alJtOH+tP1MCmtgoNVTJAYMkD19NqQuBLEx/6ArQ2ifvfGvwXcUc0n3KBUkcMbNEG/3y8GjhXcCKOV8fr6MP/LqvV2XyNGWDJZFL3tIQSTMyoEYurGNgravYRYz4yEZ1pkOnGkcVh3yP8WT7nm4II8LwyY68g7VDith4MQaukUJrC5SIP5YNLAjRzOIRl60F+hptnb+vkDAl+RrX5FaYh0jphU5UG2G3sGXFoqmeIHWtXtJPzCI9SsCNydYaLdfkopE2vS9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FrZyx+G0nFRqqG3Ukf0WKDJ2lnH9WlkIF2fwTUy9qzA=;
 b=Sn+nWGYp7FEl8gbAdpFsSsmUixi7VLF6QhyUzpbGwXzt1MgKSRopw9p869jcUO2ZPLpkzaomE9a+OCUSbJYDMihSzplh5lLcl/NjpU7GHW7KsUxwWIIta9z780WK3Uv3iEZvAoEWC7IrLggSonS2bEPwuLu1D8vzGNgTwhJmf4s=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ5PPF04D2D7FA7.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::785) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.15; Sat, 8 Nov
 2025 17:09:36 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9298.010; Sat, 8 Nov 2025
 17:09:36 +0000
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
Subject: [PATCH v2 16/16] mm: replace remaining pte_to_swp_entry() with softleaf_from_pte()
Date: Sat,  8 Nov 2025 17:08:30 +0000
Message-ID: <d2f848c77530c073116b51092c5425d3619f7ecc.1762621568.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1762621567.git.lorenzo.stoakes@oracle.com>
References: <cover.1762621567.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO6P123CA0022.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:313::15) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ5PPF04D2D7FA7:EE_
X-MS-Office365-Filtering-Correlation-Id: 3390fe3f-cd74-4368-a37c-08de1ee9983e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bXMYWIH8W09RyWA5UlMUCEzqPEVW7AOcAvEttErrJzqoWmkMbp23cMnItpc2?=
 =?us-ascii?Q?tElmyFSt/6zVpUqBpBEW3XQTiyHXZg9tHN4RLJGn9yp+xrRcvmwo8qHg4neN?=
 =?us-ascii?Q?aILbA3EoATTTCYovE3lsdTc3GKQhFYjAXDggq1I5Vc8SBjiUgPPWyLMFPcPa?=
 =?us-ascii?Q?8huS6WEzf/y7lH1ubQUCOMCkMlMCNc0lksC2DKJ5H0+duJIW70Y7kWM7BJAn?=
 =?us-ascii?Q?0eSNvm06LkdmZknilE5Zs7JWAb5QSTQHIVcR1t34eH7kAduA33tfCS0VDRvT?=
 =?us-ascii?Q?1WFD3TvmJeAyOI0aA7rtsEPReDtdhVGGHQFE0fFaYomGaeCH70/muFNFyxt+?=
 =?us-ascii?Q?7Jc2CgNk1EiKFRjGRULCx40qfMUSSsVLKa6BIdqEHenTRBXHdHMxHCQgx00v?=
 =?us-ascii?Q?ePndOVJvB/Qc6kqi+An69QQRnTh6k2Zaui+i4y78CoJhMxtwb/uPTATPtWBi?=
 =?us-ascii?Q?wR4Cw9d8lSaccaXg+BqmHRIo1up14G8j/9bSgDEE7/C1xhuWYm0l1fhyKMVA?=
 =?us-ascii?Q?l9dg0SUhtQYVFvZKs1idD7ARZdRAOD/xcUiiFRzD7HJ42Cu/0NB0hZMrGLpM?=
 =?us-ascii?Q?jgw3Se3dg9ju+a75q2wXd4WF96KRFmpUzeCnZGdUOq5sGbfvg6o8iyep7hyg?=
 =?us-ascii?Q?q3+w4fC73caqA4HYCwWTLyhnNPY8YuAvFMRQXnOYVzQztzwpfvdA6+dwkvNW?=
 =?us-ascii?Q?+GchHirfR1y6dDQ7LFdXv6uT2Kiybw2gVsW6UBcNWkrRIvoqX7E+caUqP0Ol?=
 =?us-ascii?Q?zboZM0RwtGXlB77/x6wZdpfQ6AXzTVyhpqBACxGxYMKZrlzsaMOmmy8UFcbK?=
 =?us-ascii?Q?PVedDBNgh6e9pJAf4Kb2qFU4XFoanFXU6qggE9ZCCC9Uj4CXjGifltW/Lz8W?=
 =?us-ascii?Q?UzzMEd1FktCWgmBTDSuE+F5nz1cnkj3UO79KERLgVEXHelukXXz5LOswbVJv?=
 =?us-ascii?Q?QyJHECpa82IuNg8/8VkI7mfkgF47i+aDrBSY/58njAmJo86Co5EGtwGdg8Iu?=
 =?us-ascii?Q?bXTloI2AXawKZP/VzHhfC7y/8lMT9TaHf9UI9jtS6TrkdO2SipEFsSueVx//?=
 =?us-ascii?Q?rMaIIFQQb0RrDdEbauCMUdTl5oguiAaJPti0QInU0Pv6EaRfxkbwi0VCpZ3Y?=
 =?us-ascii?Q?y0jmSgaaYu3Q4xHhb59gKAArbOnu00z5JKZnzn350PD405SUzoghsTMIidJI?=
 =?us-ascii?Q?BsXYCiq25AVWFlcJTemYpFrcgdrKfYlz5+vPW18nBTyGQK5u4QZYgiGgVELv?=
 =?us-ascii?Q?pFbDJLC42a5ZDaeMNyHvWTtI416F87c2tRmvGTFoHkGtsiSYxJClUycZnR0a?=
 =?us-ascii?Q?4JckgaIqhTeO3Z6fGkPRHR1Ah6KecbtE/5Ddlp11J7Nqp9GTgvA+G8hEqau2?=
 =?us-ascii?Q?IVFNny5JApAtl4CsoU15/03WM8kwgs9Xx/l85wCxAoEiYqL2kUj3u+9gAOHe?=
 =?us-ascii?Q?uRpxEw0ZPqvmw0Yi245SFfwe7qjrWVmt?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0cB5fGeAudFamLkH+3asl93S+AWPK6FGMtdR04gh5wzZF8SCTT4M6waFZ9AS?=
 =?us-ascii?Q?ZQ5F5mg1q8qqUlGjgzOlzRvX2q9OqRNsYhaJejetLMLloLqAHwhNOBzJBq7H?=
 =?us-ascii?Q?iAMGo/dBPck1Xb0RNriaklQnS3UDstS2TZmy9mJANlPre1whicpcMm+AgSV8?=
 =?us-ascii?Q?yU4e+16EwcIfFwBFNbWk019VIDmvplT86ArlhCoCoJkkGciJsM14jYiq6NgL?=
 =?us-ascii?Q?AwLazdz+vhFwbLt7bborlzyArV//bNfwZenBzxFQBLHc3S69t8QWlCPrIM9Y?=
 =?us-ascii?Q?x9lH2THLzArhcx+ZNFjxJ05wm5/01tCG0DABaboezxD2Etjhr94yBhoEqAX3?=
 =?us-ascii?Q?2H/sv8I784xqTvsbgLMR2o0m9TTIT+4PUqfKtO9q/QtIZ4cQyxrkIfroG2zI?=
 =?us-ascii?Q?4TOKOiWKZN/6mOKhXXiGawqyPD38ast1Ct0b4gR1CJgjpXTudhyrM4VRz4/u?=
 =?us-ascii?Q?8aDc28D22/PW3cEBGHskocRxSaBAaijlspUKKanCyHkT8J6/3H5EdCGYPh7e?=
 =?us-ascii?Q?ThIB2z1Vf5lfRXq8+EPjeh0nDTcwpy/WKcs4SR+LcWQFA05EHtgmBft8awM1?=
 =?us-ascii?Q?47Pm9Nd0lzoEi5UNAuVI/IsRRh9tlYze7GzhGaOfH+zzy8o5QBE95jVuxI0f?=
 =?us-ascii?Q?xWa7BveTArXp+SYk8hKl6sqIU4VulBrK4rNoOp/JWXAnx26YKIia0D8gAi5e?=
 =?us-ascii?Q?+FXpGZEnb7Wi8aynbS3pXjxEgMykU5vdqaTXtMUDDJHOv3gAe+CzeyQdplOx?=
 =?us-ascii?Q?K1xjmqCaG6vUEdgaFCj3+T/ykUOzfa/W9H9qRgMDSAxQZwecZ37WpELRNHXu?=
 =?us-ascii?Q?kIbYFo3S+AfhAY/7uFSse+FlHCeoeEBB2G2QNdy8He8T9TR7UhAhQvVyDh82?=
 =?us-ascii?Q?FtmovccWAWqB6SkNQAzO5F4BiqaNXD/lCo1oQA3UGJk7jSbndR3++4CYKwbn?=
 =?us-ascii?Q?l7OXWGqUWlyHBtjPaiTw4u4ZRzw9RYflbV5oEj6xunwTDeeT9Gh2DCfSmDc2?=
 =?us-ascii?Q?AoRt/9SGYCWcHwqqnDTT5kQF6yZhy4VRaFUPh1UopPn0hjPYwHfI730oKBBl?=
 =?us-ascii?Q?61oYI+Y0YteghfiqmRtGDdUhCHSoEMmNJyD4JqihYlevaKJv5W91R6NJPoLZ?=
 =?us-ascii?Q?XcKnVfh2WWWr6ZkbT/5Ew73J79hrKfA25ImQOEGdxrlfMKvYwBNp6GqDZrSy?=
 =?us-ascii?Q?L8j+IEfTZDvkJIP9KKr90GM01fTDyQ817ehkrN6QeXtubCbYF+52u1lY+oUa?=
 =?us-ascii?Q?BvFDMxMSGp910w20cjOw2gcpckQqPRw8DT/jZcGqHZK7EliPxjdqAcxw72Id?=
 =?us-ascii?Q?U1y75mR7pUm3J7fe8oUmqPvM+KVCq+V9tuoDvu7WpyUsTdAU45nmPKRm8DfU?=
 =?us-ascii?Q?BO3qyQ9QTxCiF1wTT7luC2noeF8WA3M2dX+MSsDCgZKeZICEdLFp4j1COJ89?=
 =?us-ascii?Q?67+7mq50CntC3uBTNF5mg8/1r8vlPvdxMyVUZcJIHPRntx/qcTidGfMgcMwC?=
 =?us-ascii?Q?jNpwx9CuhB6zBImucQenWbXtyyJRPTe24ijrQMjL9y1lYfTZoh060A2hViIW?=
 =?us-ascii?Q?iKvcVSTg/vpky7n9Nc/U77V8shl/FKcUW1GhKipjxYNeoULxEk7f/y64QKxj?=
 =?us-ascii?Q?eA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gARDCpDLL0W3OEX5MTcIs82YZw+BooQ3qtbgpF0oQHALY+LyiAqS4aO4lyiPB/z5X4PD0Xd6g2e191+gBhkWl3AMPaiOfzE0Y6OUdamQRO0MQ+7eDWMMym4QzkfSAw0F5tZWpRrVPDyS+zU2IpBB/7sQC8yg1LKmUOffk9BzGPIZcpkqCUDLMRJGqDKq8FAa9upYzAvOdrwyd6QFDCph8vGRWkCwfcXJQE6j1fWMy5WV9cD6+Pehbz9GmdPx0gCmwmCNiwaJvJ0IYTEbJkDD4fkMhnVAWtmsvYlo7MGAPam4lPoAiE+OAPr4TP2cgnVM1xjFYoDqh908AWqitGgDWZ1RqmiAGpjJm7lgl6H/51hC0Vz+Du4ZbNtN18d5t7voEwdAQncWDgDRiSsdV0QhZzwpnWESYaM1AtMhyMUHdDAvFCzhehnZx6WLWpUdCT4Zg3EJkX0cyBV7MVE89E0WZogHssr+/8yDPtqmI4c+R3B/clq8b3YgWikkNWHcbkswbiQq50KmBZP8iQXTWtY03NOvAwK9sAzW7aHneu8GvMPUFT1sYxIl5LXCuNRSqzZAfNX8abqlI1Nf/iT3pO6L/ysTWZo6fEiE8VfQurPgE3s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3390fe3f-cd74-4368-a37c-08de1ee9983e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2025 17:09:36.4345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uPZ7oowgd6wCzvPHYX9m1zBW7tjeaipr4m+HQOQvnB6Sx8LYsaCE23KzFNsFcmM+BCTFng3U4gPINc435NkysH7j1H9Hym+zHS+VaS1d3oc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF04D2D7FA7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-08_04,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511080138
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDEwOSBTYWx0ZWRfXz+p3vkxt8l3v
 /eSGjeNr9D7wiMnuR2Pm2unoed0sy9JVcgS5LbdBKzVVqpk6LQsLVQvtHGkY6G0574DxtE1Vtej
 Wq6RvIjuRzwKHNJIm6e+yhUlwsCorO/7qtFx4J4riOU/tQWM3VVN5Kx2EZaIA7YxGcqkCDETmyQ
 auQVu06mUB7vcx5h4EnVD1zwAshLE1cWHYSCUQHB2SoFiEuj1xO4YYOSB2i16iGg3Z1HcFbjrOr
 cI5o1c4w/ELPdzio52L8KwSFZ4nMAgdp1mBnzJ0hmRVNJmPg3lR6quZ2QUgZWkmr4B9HF4eHfIU
 AKrVpnChaxtguHtdHBSxcJZypEtceqlzfpij6rTxM7EYJlYWjQFLNdcH2WDCj9Uv/sry1pF5lBk
 IOBYuki7qeXjnzd3aeh2up7COX/k2Q==
X-Authority-Analysis: v=2.4 cv=IKEPywvG c=1 sm=1 tr=0 ts=690f7954 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=ZBIxWEUt1cXBTM7wFXgA:9 a=UhEZJTgQB8St2RibIkdl:22 a=Z5ABNNGmrOfJ6cZ5bIyy:22
 a=QOGEsqRv6VhmHaoFNykA:22
X-Proofpoint-ORIG-GUID: dKqGnB-33fAtF3jkKw6ilcXfKxOljOCj
X-Proofpoint-GUID: dKqGnB-33fAtF3jkKw6ilcXfKxOljOCj

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
 mm/swapfile.c           |  5 +++--
 10 files changed, 34 insertions(+), 32 deletions(-)

diff --git a/include/linux/leafops.h b/include/linux/leafops.h
index d593093ba70c..a464a7e08c76 100644
--- a/include/linux/leafops.h
+++ b/include/linux/leafops.h
@@ -54,11 +54,16 @@ static inline softleaf_t softleaf_mk_none(void)
  */
 static inline softleaf_t softleaf_from_pte(pte_t pte)
 {
+	softleaf_t arch_entry;
+
 	if (pte_present(pte))
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
index e1d50f198c42..62c9603a5414 100644
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
index 684f78cd7dd1..1204fb0726d5 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -3201,8 +3201,9 @@ static int claim_swapfile(struct swap_info_struct *si, struct inode *inode)
  */
 unsigned long generic_max_swapfile_size(void)
 {
-	return swp_offset(pte_to_swp_entry(
-			swp_entry_to_pte(swp_entry(0, ~0UL)))) + 1;
+	const softleaf_t entry = swp_entry(0, ~0UL);
+
+	return swp_offset(softleaf_from_pte(softleaf_to_pte(entry))) + 1;
 }
 
 /* Can be overridden by an architecture for additional checks. */
-- 
2.51.0


