Return-Path: <linux-fsdevel+bounces-67537-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A1FC430A2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 08 Nov 2025 18:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F20F53B1B9B
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Nov 2025 17:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B8CC245006;
	Sat,  8 Nov 2025 17:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KzA61X95";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mwYu1H9a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAFE242D78;
	Sat,  8 Nov 2025 17:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762621851; cv=fail; b=ba+o4ifUiruHqNpZlT1IzJmd+bwlfvrnvh71SuoBeEkudkxXFqaJyAQN3jzSxcClA/RH88IbyKWytd2bTYZACcwX67Q9YDDnfUGgTE0QoIebY8DsOJrf8Go9daJROMskQHm0WLy/VTU5lZRmZ5VSRJFglHKmaGSfyVAw9BWR//0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762621851; c=relaxed/simple;
	bh=zmWrD5tfCxpjD0F6zVZO3h8VZ7lZUzeAIoSKwQbTv+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JvPBjrA04bj7gvprb0296zWJPaVx3KSv0peZ3NlLwH6ZIy7lachzADRB+lgIdRDopXdWfMJl7JhAro0y1HUhtQ5KHtUOOpvPnt3g/OssorLTHFRsiRImbyc1t60Et9KOecgEhGOSw4HZL6OQJzCO9Z8BGvrBuQ3MSWYGv9JKpDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KzA61X95; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mwYu1H9a; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A8Ft8Hf009413;
	Sat, 8 Nov 2025 17:09:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Lwvkms7GITNmCI+DeGWkYguhXaAQLuiGqXmPvm3p6YU=; b=
	KzA61X95mBhLV4YvM0/osNcXWS8m2Acg+uV5833zlyJTnQUk0WQ2Wbwl99Gn5ag0
	9QV0kcBFYGFLEO/hnl2JPuxqtBplZHnLI8qyhzLr9r6+Io0X8GOSpw8/L6RODHqa
	0vrbBw1n9HrgL/TkOL+9p88vT/eJQPqTIzBiU+6w575XVG15Cj9AD94lpzwOOhWE
	lZmbl6+27H09f3jAm7zGpuauiKi31nzDgn00aqLnaiclpbqrPIo28ta50ne4ujb4
	Z2AXQ0Otmpr2H/Pfwtj5IvOJudrm8M/OufDNSs10ev15I7YdFzE2Ib9i6t4eq0ri
	RKqyJu7uZcb8dXRebxLosA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a9vs8gnmk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 08 Nov 2025 17:09:24 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A8C03c7007618;
	Sat, 8 Nov 2025 17:09:23 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011047.outbound.protection.outlook.com [40.93.194.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9va76n25-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 08 Nov 2025 17:09:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YMtkn8PXsHw9For0ZQ1NkJf9j0GHK7wwZ57AzqWMazEiLIHhXsdxUByI2N87NF8SHSu0UjlMoCl1o0pzACZNJO9OG1CpZMhu76PU97CLnt6IMfUlNlfNZPDw1U/v2yQEahE0xn4aDUzFfdIbnjBjqeHtH771gtZSjGlqBNxKX2rj7aEloZzj/IzChe5QeGpdX2uoPRruyctDzoYWL6E56sDlArNxvohrZgCk58yMICU6OIn6bab+I8U5KX854RSXFaVyS0j9TwQKb+yKMmVSJUT/qvY6oTg5WUpkiKAg0SN2l+w0WhC71fMYW+9imkJE2Vpo182O0wz9Sco3zp/Yiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lwvkms7GITNmCI+DeGWkYguhXaAQLuiGqXmPvm3p6YU=;
 b=pxfvWuYhEDrnWgWh2nRsiPZt/I0R44d3Yoqf+MUVcwEZdw7gjFHXnxz81ysix2WiTZsvDF0Mku8NY2SaZ+061SycByHKLKP0f6vDiI32E1MxqcpyKYqbC6BMnzZCtgzpgTy7jHh4+t22/MbMhxspnI2m2GAea+uWBq6ae7mxpp4CXXmsCz/M3OJyLepI6oa+Ugao65/H1ey2ke0ng93zCpgoy4WRZ5bpcXKqNEi4THbfuduvajRYgnTjbDVNpBFWcIUvTF1nsIjiwQK1vNXy+OhwISSsk0GBjM590yOpEM7zd1CZUPh3MVS0Gren79BINE80+KXAqkNDxAGmwvYBjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lwvkms7GITNmCI+DeGWkYguhXaAQLuiGqXmPvm3p6YU=;
 b=mwYu1H9aSk9gcfNEqy1bbrIu429BLsU8ONQBu3zeIOgjRrayDyttxN7+N33+HPoTmdkFiuHZrKaWPodQY9BAmxVw9X8Lb7xZPqdrwUMHrDwF+QyHPSwmBZYFckYizJiJdVsSFlJgOTK7l5fNmd8XB6ymsJV/8VjKAG30JhUytk8=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ5PPF04D2D7FA7.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::785) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.15; Sat, 8 Nov
 2025 17:09:18 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9298.010; Sat, 8 Nov 2025
 17:09:18 +0000
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
Subject: [PATCH v2 10/16] mm: replace pmd_to_swp_entry() with softleaf_from_pmd()
Date: Sat,  8 Nov 2025 17:08:24 +0000
Message-ID: <093e438c240272d081548222900a5c3b205e9a5d.1762621568.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1762621567.git.lorenzo.stoakes@oracle.com>
References: <cover.1762621567.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0200.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9e::20) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ5PPF04D2D7FA7:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b007791-9e55-4fda-f5e8-08de1ee98d6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?f8siK3gdiR+Oo62iYx2X2fS3HmkT7454cC2H3slMCBLnWfuPzTd+bNy3A3RX?=
 =?us-ascii?Q?NfVEJlzimq/V1FRHPoeA27jNAtMTGb/kY7Ygv8TPSyg5pGAyPGmQYnLQjH6L?=
 =?us-ascii?Q?4y52uBnkoSOb1RqZusz3ystCujbw7IL4pCw88pmkhypVjxBRCy8dpKH6PDLr?=
 =?us-ascii?Q?RIljLxatrI5sGu3cby5i9iryGki2/eiq1p+6YTlRoG1Sq6+FPs5h1ZbenCB/?=
 =?us-ascii?Q?Ggn0kS8NwpBTf5BqZzLURa2coN0XBEdcQti5E6YfJiU3cD4htqFGWEtYbCcu?=
 =?us-ascii?Q?1nM8DpBwHpL4CUQ8W2nAE+P9K+bghVoEuVyNnKQf8JGsy+bGxPrvk4icsx56?=
 =?us-ascii?Q?zlrdyBchep7F6dfaEkZrgMpvAgsOeBSx3iSo3zYMcONkKXA/p8Ei8P6fk0S7?=
 =?us-ascii?Q?28VJcZPtiSGB5TjNK1g45V7jo2AiJFBbf9RVn/9LR2aCdh2MyQg3ANgBTjGM?=
 =?us-ascii?Q?xMQssPLyOlqsoRdRtbTSUg2QELWl6jo3mHXu/3tpHJ5WbjCDASSlf+URcmb7?=
 =?us-ascii?Q?ZiCibDZjnoDRtkvF6ww2Rnj14sp1/3hoYDhh8Hxecs2NICtPKfd2NBRFx6gG?=
 =?us-ascii?Q?3ewzWSLxuXhgmkcJrsYrQWSz79X6e+v3YlvOf7Llz689+llz7yJeJ77SGuUr?=
 =?us-ascii?Q?qqD0P5+eLfblFSqAWSsjzXCRJ33VxWjvz3SchZZkHlS+W9epkdTb0idI91Bd?=
 =?us-ascii?Q?crtxRQiFcYUmpg1/M0UP3lFw2L2awUkPcnuTFNIkPQ9zB8lCplTK7kUnrSvE?=
 =?us-ascii?Q?PjHyZ8Aq7gE5Da9pRQPFXBEjMb8siM27lm6hnfNwfqBM6xSDcYjrgxsY1cHT?=
 =?us-ascii?Q?xZaWSvaqc9UU001GBwHBjvv5vSYmYLwLUDVACVh+SwWBJc/wxEVY4oDXK5Ji?=
 =?us-ascii?Q?IYV4cMqFF4vpbYVAEPO9qje/muKPAEKc+3YA1CeIpblUpokIMuFDJ4hhrcmt?=
 =?us-ascii?Q?PXELPRci8fzHdD6q7jq3eXmEXwBhfzWLkPCJ/lomzqD2jrQD7t4osHzQS0YC?=
 =?us-ascii?Q?bHHkwbj0p+L2p6Dpp6bNYKS3nfL+LtuPFV8ZZWBYoUjUdpTeLQsswLjurn6v?=
 =?us-ascii?Q?0z2Nr0BIbOatn9IqoVN4FBqt6wMjPRUP3X6RHbZfIiWdLGzxwivGvpgGYHHb?=
 =?us-ascii?Q?lwa1JmQvQ6BlWUPsG9BTOPoxidaTo1enbWieAuGW3MORVe29lE/tUH930t2f?=
 =?us-ascii?Q?gasuFPT18LHbJeK9TAPGCGI3rAak3/eQwxp6DS8pbUv5JpAOXhaY/WzyQKC5?=
 =?us-ascii?Q?SsVgDs7JLMRntd6k+juuGjOxU7UhqVpXZW8AGO/qWEQ929+3JzxkYwM1ZcMD?=
 =?us-ascii?Q?oxBdlw8LMSZhfjQ488MSq/1HovoA0XWW5I3jS4rZIhW6bj1pSFvnIlyW863y?=
 =?us-ascii?Q?LnFSdDMJBhlmQsYGLy9NLhmJqjzWWL0BN8L/87bmOIIds86y8WXFuejrcnxP?=
 =?us-ascii?Q?xbjXCBB2PIMYF+e5RVJH3+zSu46mHrLt?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DE3C4phIydjamWASC/HPaSJJ87WTgZ4SVQzyXewNOWreGktJumN/29tmtCNn?=
 =?us-ascii?Q?STj6OBS9xcvndXTF5miCznpDTRH5AT8Mo0u1zW8K7Okv8FotXhzJOrLRF9Bq?=
 =?us-ascii?Q?R/5YL1FT9e/sKwV6JKEeg0mqq3SF0C5kBTgd0pZG82qSo6tiCgk5UR4JXOS7?=
 =?us-ascii?Q?QeMNdz4CZ8yjTnJhWb8CUBacTXeFzEzNscH+a7kCzZArDcEjcv/KfLIEF3Pf?=
 =?us-ascii?Q?RuO4XHM4WGE5EHQDuxki4O+1oepcPx/hknXZc8kbSTubDUiDWNTwNt62pOWc?=
 =?us-ascii?Q?mN6ThviUZGYeXq5fJhQ5Wv03PkZ1zDVz4R2KOKV/YHTV0HpCYkg4ndstMSn/?=
 =?us-ascii?Q?K2yPoxcPE4CVBjmjVhgH5K18gfnpMsR0jCV1CIiLiNxdUYcdPiOKBQDjLQB6?=
 =?us-ascii?Q?EABh5xAX2OCrZgKb8j18G1mcNLQginZJzJY22XjuopB847nSEalnBNbz17m6?=
 =?us-ascii?Q?6D18E8w77BqCZ0DBEho1RnOy7A1Tff+e4ie1QT1t1nolxzPGfTAjtZmH62Yv?=
 =?us-ascii?Q?td/Q9p69xx+juUtF5yCZoVPBYZrF0E/JDn7S+irfNrN0RzMnxDTC3461ju2g?=
 =?us-ascii?Q?Cz/U/X6OC9p/ajYMQZ9t/PWNH+yH1IhU5L7aglF1S8a8Usi//uBsyPDH+H7u?=
 =?us-ascii?Q?GqNL+pHyKr91RQJed9lRIgoe/FWo3T2XJ3nk2nRRTlfEb2TXEsynJBAEuYfv?=
 =?us-ascii?Q?SwGaH2RVJSVOxK1XJ/5fcRHSiglqY8gCxLmV7LvsPJ2g0PJ362zSoxC8kury?=
 =?us-ascii?Q?7pxxQwpp6DbqfqNzYMQ/typICvyCKo1xP3HTU9Y0Shcdlb1zV0Zk31gnrX+P?=
 =?us-ascii?Q?nTCi/YX4YitOPxNqDKauSLReuL5zCqbGRt9XiVQx43G6OtW0A+mpKsme8Tox?=
 =?us-ascii?Q?4FoSmhdzAPHUjfCqoRAQZM5rpy2DUIGB+ybOs8ltJ+sg7E0amOPuVfck/RKc?=
 =?us-ascii?Q?8p23CXkg233/7jlR4kE8/7DcF/O8JI6Ks/AwkjWiQr5AlJXeumSU41PsEcLq?=
 =?us-ascii?Q?oTPsobv5gMm42LCIpbobVj6G/ASJmRb1lBeAOUqVI8YYWg7stkGI4a++iXhP?=
 =?us-ascii?Q?1yv6X+5SNXkx4hAgvrCn6b5Xj72Y/FOymY54fkhw+7WiDfUuWeErKqAlp46x?=
 =?us-ascii?Q?o71Q/SIcs1m6Nk0npU+Ic5bW2QaPUJviGFA23eYwpXUxkLTDQpjtkLeX/X3O?=
 =?us-ascii?Q?u1GTSlLVwZZbi3GoFcR+WH5RRgtqIDSrYXdggWQ6XNg+MKqU9cOnXzrAN5KU?=
 =?us-ascii?Q?NDI/YAkw0lwo8n8lLe9EksCo4PLzy+tlUkHHrkKZr7nZcTdUEIbIl7ETSfRt?=
 =?us-ascii?Q?JV3BsMN/qqMsWgw2UXXcUT/qZrktxo7SSv3LoWGtNKY26GnZpn8JFS06lYBK?=
 =?us-ascii?Q?MYoj5Joa4gSQip9qh182GMXvQRKq8CBbhrmmJ7u6/Y2998hXUjWr3CTBykzS?=
 =?us-ascii?Q?U07TRGN9KP1zxQFVLpHvRNAcZXV7GFwdrnDEF1BE8Bk4eKyT0vHbuK610uoD?=
 =?us-ascii?Q?zuJkS/TtMsUv/kgsikRuuBpuWnbJCqFHKc5UB0mZfSS+7c05LCvlTuRrg+Dc?=
 =?us-ascii?Q?IIk+FP5Fy8hAn1+NNQMrVxi9/P7J+yR7TYxm/68NQ1av1GOp9643vdTLoFZ7?=
 =?us-ascii?Q?1w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	16g33gYAMmvfrTV36gSCr/IrbmOhOKBpH1kAhhGVPD04TRxwOymroHzBygaeZ8KEXXq/JpRABiuwlVztDI6an47u3WQE6LOIBRI5dM+KcZ0J+srHpnrgYfmp5Sxyl99xejQetq3Jdo98yV6LIXV0I4PxfLD0zqR211cmKVhtMkaWh6l+vxO75VB+c7w+V5uErfFOfaWh1o5e85l0BSi55iU2vqiQM3UXbnvcEbS4OD5vH79vrDyEkcyv2PoqKCP2ubt2vC2un0u3dpEv1nG9Z+HWkIf2iCjY1xjvLrHfEDmPWgccmqb6xFWehJ7irjspV0KxUemo3zLM0AV9meySaY4CX1hX0AgdyxFB+iMlS7wBfHifNpGfai+Bx0oqJXElaGe9gM/pKSKSJBc8RB7ME1Tsyo41PHYiuFjauBgnA1xP4p4zRXci9Bi9mT0s96/i0CVxlrKZCAT9a+7cH6exI9fHJVVfb6RNPYalA87n00qoID+buuDKO6+5cwb1ELRzuJM0Ko512HOC1trRAQfIXczPwIVd8O0j8UEG6ar4HocVWomuBPJJRzNPxqwhU1xeZU7E4NLRP12G2gQYfF2uQ5rPTt1FCrzQFGneZ3+WITc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b007791-9e55-4fda-f5e8-08de1ee98d6f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2025 17:09:18.4178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cXA98lfSoNst71BQcO6nf8Q/dAYZPzglEvLNNiqD4YxE2RAYkJ1CwznvU/pkCxaIB6bkkIjGqPW/7n18Lpynm0tOs6jgiC0V8/XVqvSCxPc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF04D2D7FA7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-08_04,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511080138
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDAxNiBTYWx0ZWRfXylQr04b6364K
 qGwnEeXv6kNj0EnnJwMLyxdwTkh4uu7Ggo+pGON0b5W+btykXDJiJKjgi19ZLf6IjEuDoCnRDmr
 rSJygRhdByshg9Us2AdGlYNy+SCGjueTTDcdoU3E2272pLmUiLdscJALFGCkOhguJ8dpaJagLO+
 AhKCCBD9BsLtZd4MaG535Clg28W3nwLXv2Zzqfnrc0EVhvWqkhkycCa5ihOCtCLOqPY2rGL2MFE
 avSQCldJ5CIsm7dy0/xCzgsxlkKZO/u+N3znDysR7AWYlBNW8aFoaljJILeqaf1nqpQ1KwfBG5h
 WaidaOrKxOPSwvJZIwDkAM95j87NljJQRFwJm797896Oa+srgk+FBiCRAy1UMYkWJVrVUm/W8D7
 nWwH/O//atrh71lm3yljVIhjfKTxMw==
X-Proofpoint-ORIG-GUID: t3BeLVaUEPjV95Z-AxSxuCIaWfjPhPX0
X-Proofpoint-GUID: t3BeLVaUEPjV95Z-AxSxuCIaWfjPhPX0
X-Authority-Analysis: v=2.4 cv=eYgwvrEH c=1 sm=1 tr=0 ts=690f7944 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=1B2o6Llj8-7n3TOjnuQA:9 a=UhEZJTgQB8St2RibIkdl:22 a=Z5ABNNGmrOfJ6cZ5bIyy:22
 a=QOGEsqRv6VhmHaoFNykA:22

Introduce softleaf_from_pmd() to do the equivalent operation for PMDs that
softleaf_from_pte() fulfils, and cascade changes through code base
accordingly, introducing helpers as necessary.

We are then able to eliminate pmd_to_swp_entry(), is_pmd_migration_entry(),
is_pmd_device_private_entry() and is_pmd_non_present_folio_entry().

This further establishes the use of leaf operations throughout the code
base and further establishes the foundations for eliminating is_swap_pmd().

No functional change intended.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 fs/proc/task_mmu.c      |  27 +++--
 include/linux/leafops.h | 220 ++++++++++++++++++++++++++++++++++++++++
 include/linux/migrate.h |   2 +-
 include/linux/swapops.h | 100 ------------------
 mm/damon/ops-common.c   |   6 +-
 mm/filemap.c            |   6 +-
 mm/hmm.c                |  16 +--
 mm/huge_memory.c        |  98 +++++++++---------
 mm/khugepaged.c         |   4 +-
 mm/madvise.c            |   2 +-
 mm/memory.c             |   4 +-
 mm/mempolicy.c          |   4 +-
 mm/migrate.c            |  20 ++--
 mm/migrate_device.c     |  14 +--
 mm/page_table_check.c   |  16 +--
 mm/page_vma_mapped.c    |  15 +--
 mm/pagewalk.c           |   8 +-
 mm/rmap.c               |   4 +-
 18 files changed, 343 insertions(+), 223 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index b68eabb26f29..d982fdfcf057 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1065,10 +1065,10 @@ static void smaps_pmd_entry(pmd_t *pmd, unsigned long addr,
 		page = vm_normal_page_pmd(vma, addr, *pmd);
 		present = true;
 	} else if (unlikely(thp_migration_supported())) {
-		swp_entry_t entry = pmd_to_swp_entry(*pmd);
+		const softleaf_t entry = softleaf_from_pmd(*pmd);
 
-		if (is_pfn_swap_entry(entry))
-			page = pfn_swap_entry_to_page(entry);
+		if (softleaf_has_pfn(entry))
+			page = softleaf_to_page(entry);
 	}
 	if (IS_ERR_OR_NULL(page))
 		return;
@@ -1654,7 +1654,7 @@ static inline void clear_soft_dirty_pmd(struct vm_area_struct *vma,
 		pmd = pmd_clear_soft_dirty(pmd);
 
 		set_pmd_at(vma->vm_mm, addr, pmdp, pmd);
-	} else if (is_migration_entry(pmd_to_swp_entry(pmd))) {
+	} else if (pmd_is_migration_entry(pmd)) {
 		pmd = pmd_swp_clear_soft_dirty(pmd);
 		set_pmd_at(vma->vm_mm, addr, pmdp, pmd);
 	}
@@ -2015,12 +2015,12 @@ static int pagemap_pmd_range_thp(pmd_t *pmdp, unsigned long addr,
 		if (pm->show_pfn)
 			frame = pmd_pfn(pmd) + idx;
 	} else if (thp_migration_supported()) {
-		swp_entry_t entry = pmd_to_swp_entry(pmd);
+		const softleaf_t entry = softleaf_from_pmd(pmd);
 		unsigned long offset;
 
 		if (pm->show_pfn) {
-			if (is_pfn_swap_entry(entry))
-				offset = swp_offset_pfn(entry) + idx;
+			if (softleaf_has_pfn(entry))
+				offset = softleaf_to_pfn(entry) + idx;
 			else
 				offset = swp_offset(entry) + idx;
 			frame = swp_type(entry) |
@@ -2031,7 +2031,7 @@ static int pagemap_pmd_range_thp(pmd_t *pmdp, unsigned long addr,
 			flags |= PM_SOFT_DIRTY;
 		if (pmd_swp_uffd_wp(pmd))
 			flags |= PM_UFFD_WP;
-		VM_WARN_ON_ONCE(!is_pmd_migration_entry(pmd));
+		VM_WARN_ON_ONCE(!pmd_is_migration_entry(pmd));
 		page = pfn_swap_entry_to_page(entry);
 	}
 
@@ -2425,8 +2425,6 @@ static unsigned long pagemap_thp_category(struct pagemap_scan_private *p,
 		if (pmd_soft_dirty(pmd))
 			categories |= PAGE_IS_SOFT_DIRTY;
 	} else {
-		swp_entry_t swp;
-
 		categories |= PAGE_IS_SWAPPED;
 		if (!pmd_swp_uffd_wp(pmd))
 			categories |= PAGE_IS_WRITTEN;
@@ -2434,9 +2432,10 @@ static unsigned long pagemap_thp_category(struct pagemap_scan_private *p,
 			categories |= PAGE_IS_SOFT_DIRTY;
 
 		if (p->masks_of_interest & PAGE_IS_FILE) {
-			swp = pmd_to_swp_entry(pmd);
-			if (is_pfn_swap_entry(swp) &&
-			    !folio_test_anon(pfn_swap_entry_folio(swp)))
+			const softleaf_t entry = softleaf_from_pmd(pmd);
+
+			if (softleaf_has_pfn(entry) &&
+			    !folio_test_anon(softleaf_to_folio(entry)))
 				categories |= PAGE_IS_FILE;
 		}
 	}
@@ -2453,7 +2452,7 @@ static void make_uffd_wp_pmd(struct vm_area_struct *vma,
 		old = pmdp_invalidate_ad(vma, addr, pmdp);
 		pmd = pmd_mkuffd_wp(old);
 		set_pmd_at(vma->vm_mm, addr, pmdp, pmd);
-	} else if (is_migration_entry(pmd_to_swp_entry(pmd))) {
+	} else if (pmd_is_migration_entry(pmd)) {
 		pmd = pmd_swp_mkuffd_wp(pmd);
 		set_pmd_at(vma->vm_mm, addr, pmdp, pmd);
 	}
diff --git a/include/linux/leafops.h b/include/linux/leafops.h
index 1376589d94b0..9be9a4e8ada4 100644
--- a/include/linux/leafops.h
+++ b/include/linux/leafops.h
@@ -61,6 +61,57 @@ static inline softleaf_t softleaf_from_pte(pte_t pte)
 	return pte_to_swp_entry(pte);
 }
 
+/**
+ * softleaf_to_pte() - Obtain a PTE entry from a leaf entry.
+ * @entry: Leaf entry.
+ *
+ * This generates an architecture-specific PTE entry that can be utilised to
+ * encode the metadata the leaf entry encodes.
+ *
+ * Returns: Architecture-specific PTE entry encoding leaf entry.
+ */
+static inline pte_t softleaf_to_pte(softleaf_t entry)
+{
+	/* Temporary until swp_entry_t eliminated. */
+	return swp_entry_to_pte(entry);
+}
+
+#ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
+/**
+ * softleaf_from_pmd() - Obtain a leaf entry from a PMD entry.
+ * @pmd: PMD entry.
+ *
+ * If @pmd is present (therefore not a leaf entry) the function returns an empty
+ * leaf entry. Otherwise, it returns a leaf entry.
+ *
+ * Returns: Leaf entry.
+ */
+static inline softleaf_t softleaf_from_pmd(pmd_t pmd)
+{
+	softleaf_t arch_entry;
+
+	if (pmd_present(pmd))
+		return softleaf_mk_none();
+
+	if (pmd_swp_soft_dirty(pmd))
+		pmd = pmd_swp_clear_soft_dirty(pmd);
+	if (pmd_swp_uffd_wp(pmd))
+		pmd = pmd_swp_clear_uffd_wp(pmd);
+	arch_entry = __pmd_to_swp_entry(pmd);
+
+	/* Temporary until swp_entry_t eliminated. */
+	return swp_entry(__swp_type(arch_entry), __swp_offset(arch_entry));
+}
+
+#else
+
+static inline softleaf_t softleaf_from_pmd(pmd_t pmd)
+{
+	return softleaf_mk_none();
+}
+
+#endif
+
 /**
  * softleaf_is_none() - Is the leaf entry empty?
  * @entry: Leaf entry.
@@ -134,6 +185,43 @@ static inline bool softleaf_is_swap(softleaf_t entry)
 	return softleaf_type(entry) == SOFTLEAF_SWAP;
 }
 
+/**
+ * softleaf_is_migration_write() - Is this leaf entry a writable migration entry?
+ * @entry: Leaf entry.
+ *
+ * Returns: true if the leaf entry is a writable migration entry, otherwise
+ * false.
+ */
+static inline bool softleaf_is_migration_write(softleaf_t entry)
+{
+	return softleaf_type(entry) == SOFTLEAF_MIGRATION_WRITE;
+}
+
+/**
+ * softleaf_is_migration_read() - Is this leaf entry a readable migration entry?
+ * @entry: Leaf entry.
+ *
+ * Returns: true if the leaf entry is a readable migration entry, otherwise
+ * false.
+ */
+static inline bool softleaf_is_migration_read(softleaf_t entry)
+{
+	return softleaf_type(entry) == SOFTLEAF_MIGRATION_READ;
+}
+
+/**
+ * softleaf_is_migration_read_exclusive() - Is this leaf entry an exclusive
+ * readable migration entry?
+ * @entry: Leaf entry.
+ *
+ * Returns: true if the leaf entry is an exclusive readable migration entry,
+ * otherwise false.
+ */
+static inline bool softleaf_is_migration_read_exclusive(softleaf_t entry)
+{
+	return softleaf_type(entry) == SOFTLEAF_MIGRATION_READ_EXCLUSIVE;
+}
+
 /**
  * softleaf_is_swap() - Is this leaf entry a migration entry?
  * @entry: Leaf entry.
@@ -152,6 +240,19 @@ static inline bool softleaf_is_migration(softleaf_t entry)
 	}
 }
 
+/**
+ * softleaf_is_device_private_write() - Is this leaf entry a device private
+ * writable entry?
+ * @entry: Leaf entry.
+ *
+ * Returns: true if the leaf entry is a device private writable entry, otherwise
+ * false.
+ */
+static inline bool softleaf_is_device_private_write(softleaf_t entry)
+{
+	return softleaf_type(entry) == SOFTLEAF_DEVICE_PRIVATE_WRITE;
+}
+
 /**
  * softleaf_is_device_private() - Is this leaf entry a device private entry?
  * @entry: Leaf entry.
@@ -169,6 +270,12 @@ static inline bool softleaf_is_device_private(softleaf_t entry)
 	}
 }
 
+/**
+ * softleaf_is_device_exclusive() - Is this leaf entry a device-exclusive entry?
+ * @entry: Leaf entry.
+ *
+ * Returns: true if the leaf entry is a device-exclusive entry, otherwise false.
+ */
 static inline bool softleaf_is_device_exclusive(softleaf_t entry)
 {
 	return softleaf_type(entry) == SOFTLEAF_DEVICE_EXCLUSIVE;
@@ -327,6 +434,61 @@ static inline bool softleaf_is_uffd_wp_marker(softleaf_t entry)
 	return softleaf_to_marker(entry) & PTE_MARKER_UFFD_WP;
 }
 
+#ifdef CONFIG_MIGRATION
+
+/**
+ * softleaf_is_migration_young() - Does this migration entry contain an accessed
+ * bit?
+ * @entry: Leaf entry.
+ *
+ * If the architecture can support storing A/D bits in migration entries, this
+ * determines whether the accessed (or 'young') bit was set on the migrated page
+ * table entry.
+ *
+ * Returns: true if the entry contains an accessed bit, otherwise false.
+ */
+static inline bool softleaf_is_migration_young(softleaf_t entry)
+{
+	VM_WARN_ON_ONCE(!softleaf_is_migration(entry));
+
+	if (migration_entry_supports_ad())
+		return swp_offset(entry) & SWP_MIG_YOUNG;
+	/* Keep the old behavior of aging page after migration */
+	return false;
+}
+
+/**
+ * softleaf_is_migration_dirty() - Does this migration entry contain a dirty bit?
+ * @entry: Leaf entry.
+ *
+ * If the architecture can support storing A/D bits in migration entries, this
+ * determines whether the dirty bit was set on the migrated page table entry.
+ *
+ * Returns: true if the entry contains a dirty bit, otherwise false.
+ */
+static inline bool softleaf_is_migration_dirty(softleaf_t entry)
+{
+	VM_WARN_ON_ONCE(!softleaf_is_migration(entry));
+
+	if (migration_entry_supports_ad())
+		return swp_offset(entry) & SWP_MIG_DIRTY;
+	/* Keep the old behavior of clean page after migration */
+	return false;
+}
+
+#else /* CONFIG_MIGRATION */
+
+static inline bool softleaf_is_migration_young(softleaf_t entry)
+{
+	return false;
+}
+
+static inline bool softleaf_is_migration_dirty(softleaf_t entry)
+{
+	return false;
+}
+#endif /* CONFIG_MIGRATION */
+
 /**
  * pte_is_marker() - Does the PTE entry encode a marker leaf entry?
  * @pte: PTE entry.
@@ -378,5 +540,63 @@ static inline bool pte_is_uffd_marker(pte_t pte)
 	return false;
 }
 
+#if defined(CONFIG_ZONE_DEVICE) && defined(CONFIG_ARCH_ENABLE_THP_MIGRATION)
+
+/**
+ * pmd_is_device_private_entry() - Check if PMD contains a device private swap
+ * entry.
+ * @pmd: The PMD to check.
+ *
+ * Returns true if the PMD contains a swap entry that represents a device private
+ * page mapping. This is used for zone device private pages that have been
+ * swapped out but still need special handling during various memory management
+ * operations.
+ *
+ * Return: true if PMD contains device private entry, false otherwise
+ */
+static inline bool pmd_is_device_private_entry(pmd_t pmd)
+{
+	return softleaf_is_device_private(softleaf_from_pmd(pmd));
+}
+
+#else  /* CONFIG_ZONE_DEVICE && CONFIG_ARCH_ENABLE_THP_MIGRATION */
+
+static inline bool pmd_is_device_private_entry(pmd_t pmd)
+{
+	return false;
+}
+
+#endif /* CONFIG_ZONE_DEVICE && CONFIG_ARCH_ENABLE_THP_MIGRATION */
+
+/**
+ * pmd_is_migration_entry() - Does this PMD entry encode a migration entry?
+ * @pmd: PMD entry.
+ *
+ * Returns: true if the PMD encodes a migration entry, otherwise false.
+ */
+static inline bool pmd_is_migration_entry(pmd_t pmd)
+{
+	return softleaf_is_migration(softleaf_from_pmd(pmd));
+}
+
+/**
+ * pmd_is_valid_softleaf() - Is this PMD entry a valid leaf entry?
+ * @pmd: PMD entry.
+ *
+ * PMD leaf entries are valid only if they are device private or migration
+ * entries. This function asserts that a PMD leaf entry is valid in this
+ * respect.
+ *
+ * Returns: true if the PMD entry is a valid leaf entry, otherwise false.
+ */
+static inline bool pmd_is_valid_softleaf(pmd_t pmd)
+{
+	const softleaf_t entry = softleaf_from_pmd(pmd);
+
+	/* Only device private, migration entries valid for PMD. */
+	return softleaf_is_device_private(entry) ||
+		softleaf_is_migration(entry);
+}
+
 #endif  /* CONFIG_MMU */
 #endif  /* _LINUX_SWAPOPS_H */
diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index 41b4cc05a450..26ca00c325d9 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -65,7 +65,7 @@ bool isolate_folio_to_list(struct folio *folio, struct list_head *list);
 
 int migrate_huge_page_move_mapping(struct address_space *mapping,
 		struct folio *dst, struct folio *src);
-void migration_entry_wait_on_locked(swp_entry_t entry, spinlock_t *ptl)
+void migration_entry_wait_on_locked(softleaf_t entry, spinlock_t *ptl)
 		__releases(ptl);
 void folio_migrate_flags(struct folio *newfolio, struct folio *folio);
 int folio_migrate_mapping(struct address_space *mapping,
diff --git a/include/linux/swapops.h b/include/linux/swapops.h
index 3e8dd6ea94dd..f1277647262d 100644
--- a/include/linux/swapops.h
+++ b/include/linux/swapops.h
@@ -283,14 +283,6 @@ static inline swp_entry_t make_migration_entry_young(swp_entry_t entry)
 	return entry;
 }
 
-static inline bool is_migration_entry_young(swp_entry_t entry)
-{
-	if (migration_entry_supports_ad())
-		return swp_offset(entry) & SWP_MIG_YOUNG;
-	/* Keep the old behavior of aging page after migration */
-	return false;
-}
-
 static inline swp_entry_t make_migration_entry_dirty(swp_entry_t entry)
 {
 	if (migration_entry_supports_ad())
@@ -299,14 +291,6 @@ static inline swp_entry_t make_migration_entry_dirty(swp_entry_t entry)
 	return entry;
 }
 
-static inline bool is_migration_entry_dirty(swp_entry_t entry)
-{
-	if (migration_entry_supports_ad())
-		return swp_offset(entry) & SWP_MIG_DIRTY;
-	/* Keep the old behavior of clean page after migration */
-	return false;
-}
-
 extern void migration_entry_wait(struct mm_struct *mm, pmd_t *pmd,
 					unsigned long address);
 extern void migration_entry_wait_huge(struct vm_area_struct *vma, unsigned long addr, pte_t *pte);
@@ -349,20 +333,11 @@ static inline swp_entry_t make_migration_entry_young(swp_entry_t entry)
 	return entry;
 }
 
-static inline bool is_migration_entry_young(swp_entry_t entry)
-{
-	return false;
-}
-
 static inline swp_entry_t make_migration_entry_dirty(swp_entry_t entry)
 {
 	return entry;
 }
 
-static inline bool is_migration_entry_dirty(swp_entry_t entry)
-{
-	return false;
-}
 #endif	/* CONFIG_MIGRATION */
 
 #ifdef CONFIG_MEMORY_FAILURE
@@ -487,18 +462,6 @@ extern void remove_migration_pmd(struct page_vma_mapped_walk *pvmw,
 
 extern void pmd_migration_entry_wait(struct mm_struct *mm, pmd_t *pmd);
 
-static inline swp_entry_t pmd_to_swp_entry(pmd_t pmd)
-{
-	swp_entry_t arch_entry;
-
-	if (pmd_swp_soft_dirty(pmd))
-		pmd = pmd_swp_clear_soft_dirty(pmd);
-	if (pmd_swp_uffd_wp(pmd))
-		pmd = pmd_swp_clear_uffd_wp(pmd);
-	arch_entry = __pmd_to_swp_entry(pmd);
-	return swp_entry(__swp_type(arch_entry), __swp_offset(arch_entry));
-}
-
 static inline pmd_t swp_entry_to_pmd(swp_entry_t entry)
 {
 	swp_entry_t arch_entry;
@@ -507,23 +470,7 @@ static inline pmd_t swp_entry_to_pmd(swp_entry_t entry)
 	return __swp_entry_to_pmd(arch_entry);
 }
 
-static inline int is_pmd_migration_entry(pmd_t pmd)
-{
-	swp_entry_t entry;
-
-	if (pmd_present(pmd))
-		return 0;
-
-	entry = pmd_to_swp_entry(pmd);
-	return is_migration_entry(entry);
-}
 #else  /* CONFIG_ARCH_ENABLE_THP_MIGRATION */
-static inline int set_pmd_migration_entry(struct page_vma_mapped_walk *pvmw,
-		struct page *page)
-{
-	BUILD_BUG();
-}
-
 static inline void remove_migration_pmd(struct page_vma_mapped_walk *pvmw,
 		struct page *new)
 {
@@ -532,64 +479,17 @@ static inline void remove_migration_pmd(struct page_vma_mapped_walk *pvmw,
 
 static inline void pmd_migration_entry_wait(struct mm_struct *m, pmd_t *p) { }
 
-static inline swp_entry_t pmd_to_swp_entry(pmd_t pmd)
-{
-	return swp_entry(0, 0);
-}
-
 static inline pmd_t swp_entry_to_pmd(swp_entry_t entry)
 {
 	return __pmd(0);
 }
 
-static inline int is_pmd_migration_entry(pmd_t pmd)
-{
-	return 0;
-}
 #endif  /* CONFIG_ARCH_ENABLE_THP_MIGRATION */
 
-#if defined(CONFIG_ZONE_DEVICE) && defined(CONFIG_ARCH_ENABLE_THP_MIGRATION)
-
-/**
- * is_pmd_device_private_entry() - Check if PMD contains a device private swap entry
- * @pmd: The PMD to check
- *
- * Returns true if the PMD contains a swap entry that represents a device private
- * page mapping. This is used for zone device private pages that have been
- * swapped out but still need special handling during various memory management
- * operations.
- *
- * Return: 1 if PMD contains device private entry, 0 otherwise
- */
-static inline int is_pmd_device_private_entry(pmd_t pmd)
-{
-	swp_entry_t entry;
-
-	if (pmd_present(pmd))
-		return 0;
-
-	entry = pmd_to_swp_entry(pmd);
-	return is_device_private_entry(entry);
-}
-
-#else /* CONFIG_ZONE_DEVICE && CONFIG_ARCH_ENABLE_THP_MIGRATION */
-
-static inline int is_pmd_device_private_entry(pmd_t pmd)
-{
-	return 0;
-}
-
-#endif /* CONFIG_ZONE_DEVICE && CONFIG_ARCH_ENABLE_THP_MIGRATION */
-
 static inline int non_swap_entry(swp_entry_t entry)
 {
 	return swp_type(entry) >= MAX_SWAPFILES;
 }
 
-static inline int is_pmd_non_present_folio_entry(pmd_t pmd)
-{
-	return is_pmd_migration_entry(pmd) || is_pmd_device_private_entry(pmd);
-}
-
 #endif /* CONFIG_MMU */
 #endif /* _LINUX_SWAPOPS_H */
diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
index 971df8a16ba4..a218d9922234 100644
--- a/mm/damon/ops-common.c
+++ b/mm/damon/ops-common.c
@@ -11,7 +11,7 @@
 #include <linux/pagemap.h>
 #include <linux/rmap.h>
 #include <linux/swap.h>
-#include <linux/swapops.h>
+#include <linux/leafops.h>
 
 #include "../internal.h"
 #include "ops-common.h"
@@ -51,7 +51,7 @@ void damon_ptep_mkold(pte_t *pte, struct vm_area_struct *vma, unsigned long addr
 	if (likely(pte_present(pteval)))
 		pfn = pte_pfn(pteval);
 	else
-		pfn = swp_offset_pfn(pte_to_swp_entry(pteval));
+		pfn = softleaf_to_pfn(softleaf_from_pte(pteval));
 
 	folio = damon_get_folio(pfn);
 	if (!folio)
@@ -83,7 +83,7 @@ void damon_pmdp_mkold(pmd_t *pmd, struct vm_area_struct *vma, unsigned long addr
 	if (likely(pmd_present(pmdval)))
 		pfn = pmd_pfn(pmdval);
 	else
-		pfn = swp_offset_pfn(pmd_to_swp_entry(pmdval));
+		pfn = softleaf_to_pfn(softleaf_from_pmd(pmdval));
 
 	folio = damon_get_folio(pfn);
 	if (!folio)
diff --git a/mm/filemap.c b/mm/filemap.c
index ff75bd89b68c..950d93885e38 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -21,7 +21,7 @@
 #include <linux/gfp.h>
 #include <linux/mm.h>
 #include <linux/swap.h>
-#include <linux/swapops.h>
+#include <linux/leafops.h>
 #include <linux/syscalls.h>
 #include <linux/mman.h>
 #include <linux/pagemap.h>
@@ -1402,7 +1402,7 @@ static inline int folio_wait_bit_common(struct folio *folio, int bit_nr,
  * This follows the same logic as folio_wait_bit_common() so see the comments
  * there.
  */
-void migration_entry_wait_on_locked(swp_entry_t entry, spinlock_t *ptl)
+void migration_entry_wait_on_locked(softleaf_t entry, spinlock_t *ptl)
 	__releases(ptl)
 {
 	struct wait_page_queue wait_page;
@@ -1411,7 +1411,7 @@ void migration_entry_wait_on_locked(swp_entry_t entry, spinlock_t *ptl)
 	unsigned long pflags;
 	bool in_thrashing;
 	wait_queue_head_t *q;
-	struct folio *folio = pfn_swap_entry_folio(entry);
+	struct folio *folio = softleaf_to_folio(entry);
 
 	q = folio_waitqueue(folio);
 	if (!folio_test_uptodate(folio) && folio_test_workingset(folio)) {
diff --git a/mm/hmm.c b/mm/hmm.c
index b11b4ebba945..bc3fa699a4c6 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -18,7 +18,7 @@
 #include <linux/sched.h>
 #include <linux/mmzone.h>
 #include <linux/pagemap.h>
-#include <linux/swapops.h>
+#include <linux/leafops.h>
 #include <linux/hugetlb.h>
 #include <linux/memremap.h>
 #include <linux/sched/mm.h>
@@ -334,19 +334,19 @@ static int hmm_vma_handle_absent_pmd(struct mm_walk *walk, unsigned long start,
 	struct hmm_vma_walk *hmm_vma_walk = walk->private;
 	struct hmm_range *range = hmm_vma_walk->range;
 	unsigned long npages = (end - start) >> PAGE_SHIFT;
+	const softleaf_t entry = softleaf_from_pmd(pmd);
 	unsigned long addr = start;
-	swp_entry_t entry = pmd_to_swp_entry(pmd);
 	unsigned int required_fault;
 
-	if (is_device_private_entry(entry) &&
-	    pfn_swap_entry_folio(entry)->pgmap->owner ==
+	if (softleaf_is_device_private(entry) &&
+	    softleaf_to_folio(entry)->pgmap->owner ==
 	    range->dev_private_owner) {
 		unsigned long cpu_flags = HMM_PFN_VALID |
 			hmm_pfn_flags_order(PMD_SHIFT - PAGE_SHIFT);
-		unsigned long pfn = swp_offset_pfn(entry);
+		unsigned long pfn = softleaf_to_pfn(entry);
 		unsigned long i;
 
-		if (is_writable_device_private_entry(entry))
+		if (softleaf_is_device_private_write(entry))
 			cpu_flags |= HMM_PFN_WRITE;
 
 		/*
@@ -365,7 +365,7 @@ static int hmm_vma_handle_absent_pmd(struct mm_walk *walk, unsigned long start,
 	required_fault = hmm_range_need_fault(hmm_vma_walk, hmm_pfns,
 					      npages, 0);
 	if (required_fault) {
-		if (is_device_private_entry(entry))
+		if (softleaf_is_device_private(entry))
 			return hmm_vma_fault(addr, end, required_fault, walk);
 		else
 			return -EFAULT;
@@ -407,7 +407,7 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
 	if (pmd_none(pmd))
 		return hmm_vma_walk_hole(start, end, -1, walk);
 
-	if (thp_migration_supported() && is_pmd_migration_entry(pmd)) {
+	if (thp_migration_supported() && pmd_is_migration_entry(pmd)) {
 		if (hmm_range_need_fault(hmm_vma_walk, hmm_pfns, npages, 0)) {
 			hmm_vma_walk->last = addr;
 			pmd_migration_entry_wait(walk->mm, pmdp);
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 40a8a2c1e080..5876595b00d5 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1374,7 +1374,7 @@ vm_fault_t do_huge_pmd_device_private(struct vm_fault *vmf)
 	struct vm_area_struct *vma = vmf->vma;
 	vm_fault_t ret = 0;
 	spinlock_t *ptl;
-	swp_entry_t swp_entry;
+	softleaf_t entry;
 	struct page *page;
 	struct folio *folio;
 
@@ -1389,8 +1389,8 @@ vm_fault_t do_huge_pmd_device_private(struct vm_fault *vmf)
 		return 0;
 	}
 
-	swp_entry = pmd_to_swp_entry(vmf->orig_pmd);
-	page = pfn_swap_entry_to_page(swp_entry);
+	entry = softleaf_from_pmd(vmf->orig_pmd);
+	page = softleaf_to_page(entry);
 	folio = page_folio(page);
 	vmf->page = page;
 	vmf->pte = NULL;
@@ -1780,13 +1780,13 @@ static void copy_huge_non_present_pmd(
 		struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 		pmd_t pmd, pgtable_t pgtable)
 {
-	swp_entry_t entry = pmd_to_swp_entry(pmd);
+	softleaf_t entry = softleaf_from_pmd(pmd);
 	struct folio *src_folio;
 
-	VM_WARN_ON(!is_pmd_non_present_folio_entry(pmd));
+	VM_WARN_ON_ONCE(!pmd_is_valid_softleaf(pmd));
 
-	if (is_writable_migration_entry(entry) ||
-	    is_readable_exclusive_migration_entry(entry)) {
+	if (softleaf_is_migration_write(entry) ||
+	    softleaf_is_migration_read_exclusive(entry)) {
 		entry = make_readable_migration_entry(swp_offset(entry));
 		pmd = swp_entry_to_pmd(entry);
 		if (pmd_swp_soft_dirty(*src_pmd))
@@ -1794,12 +1794,12 @@ static void copy_huge_non_present_pmd(
 		if (pmd_swp_uffd_wp(*src_pmd))
 			pmd = pmd_swp_mkuffd_wp(pmd);
 		set_pmd_at(src_mm, addr, src_pmd, pmd);
-	} else if (is_device_private_entry(entry)) {
+	} else if (softleaf_is_device_private(entry)) {
 		/*
 		 * For device private entries, since there are no
 		 * read exclusive entries, writable = !readable
 		 */
-		if (is_writable_device_private_entry(entry)) {
+		if (softleaf_is_device_private_write(entry)) {
 			entry = make_readable_device_private_entry(swp_offset(entry));
 			pmd = swp_entry_to_pmd(entry);
 
@@ -1810,7 +1810,7 @@ static void copy_huge_non_present_pmd(
 			set_pmd_at(src_mm, addr, src_pmd, pmd);
 		}
 
-		src_folio = pfn_swap_entry_folio(entry);
+		src_folio = softleaf_to_folio(entry);
 		VM_WARN_ON(!folio_test_large(src_folio));
 
 		folio_get(src_folio);
@@ -2270,7 +2270,7 @@ bool madvise_free_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 
 	if (unlikely(!pmd_present(orig_pmd))) {
 		VM_BUG_ON(thp_migration_supported() &&
-				  !is_pmd_migration_entry(orig_pmd));
+				  !pmd_is_migration_entry(orig_pmd));
 		goto out;
 	}
 
@@ -2368,11 +2368,10 @@ int zap_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 			folio_remove_rmap_pmd(folio, page, vma);
 			WARN_ON_ONCE(folio_mapcount(folio) < 0);
 			VM_BUG_ON_PAGE(!PageHead(page), page);
-		} else if (is_pmd_non_present_folio_entry(orig_pmd)) {
-			swp_entry_t entry;
+		} else if (pmd_is_valid_softleaf(orig_pmd)) {
+			const softleaf_t entry = softleaf_from_pmd(orig_pmd);
 
-			entry = pmd_to_swp_entry(orig_pmd);
-			folio = pfn_swap_entry_folio(entry);
+			folio = softleaf_to_folio(entry);
 			flush_needed = 0;
 
 			if (!thp_migration_supported())
@@ -2428,7 +2427,7 @@ static inline int pmd_move_must_withdraw(spinlock_t *new_pmd_ptl,
 static pmd_t move_soft_dirty_pmd(pmd_t pmd)
 {
 #ifdef CONFIG_MEM_SOFT_DIRTY
-	if (unlikely(is_pmd_migration_entry(pmd)))
+	if (unlikely(pmd_is_migration_entry(pmd)))
 		pmd = pmd_swp_mksoft_dirty(pmd);
 	else if (pmd_present(pmd))
 		pmd = pmd_mksoft_dirty(pmd);
@@ -2503,12 +2502,12 @@ static void change_non_present_huge_pmd(struct mm_struct *mm,
 		unsigned long addr, pmd_t *pmd, bool uffd_wp,
 		bool uffd_wp_resolve)
 {
-	swp_entry_t entry = pmd_to_swp_entry(*pmd);
-	struct folio *folio = pfn_swap_entry_folio(entry);
+	softleaf_t entry = softleaf_from_pmd(*pmd);
+	const struct folio *folio = softleaf_to_folio(entry);
 	pmd_t newpmd;
 
-	VM_WARN_ON(!is_pmd_non_present_folio_entry(*pmd));
-	if (is_writable_migration_entry(entry)) {
+	VM_WARN_ON(!pmd_is_valid_softleaf(*pmd));
+	if (softleaf_is_migration_write(entry)) {
 		/*
 		 * A protection check is difficult so
 		 * just be safe and disable write
@@ -2520,7 +2519,7 @@ static void change_non_present_huge_pmd(struct mm_struct *mm,
 		newpmd = swp_entry_to_pmd(entry);
 		if (pmd_swp_soft_dirty(*pmd))
 			newpmd = pmd_swp_mksoft_dirty(newpmd);
-	} else if (is_writable_device_private_entry(entry)) {
+	} else if (softleaf_is_device_private_write(entry)) {
 		entry = make_readable_device_private_entry(swp_offset(entry));
 		newpmd = swp_entry_to_pmd(entry);
 	} else {
@@ -2718,7 +2717,7 @@ int move_pages_huge_pmd(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd, pm
 
 	if (!pmd_trans_huge(src_pmdval)) {
 		spin_unlock(src_ptl);
-		if (is_pmd_migration_entry(src_pmdval)) {
+		if (pmd_is_migration_entry(src_pmdval)) {
 			pmd_migration_entry_wait(mm, &src_pmdval);
 			return -EAGAIN;
 		}
@@ -2983,13 +2982,12 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 	unsigned long addr;
 	pte_t *pte;
 	int i;
-	swp_entry_t entry;
 
 	VM_BUG_ON(haddr & ~HPAGE_PMD_MASK);
 	VM_BUG_ON_VMA(vma->vm_start > haddr, vma);
 	VM_BUG_ON_VMA(vma->vm_end < haddr + HPAGE_PMD_SIZE, vma);
 
-	VM_WARN_ON(!is_pmd_non_present_folio_entry(*pmd) && !pmd_trans_huge(*pmd));
+	VM_WARN_ON_ONCE(!pmd_is_valid_softleaf(*pmd) && !pmd_trans_huge(*pmd));
 
 	count_vm_event(THP_SPLIT_PMD);
 
@@ -3003,11 +3001,10 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 			zap_deposited_table(mm, pmd);
 		if (!vma_is_dax(vma) && vma_is_special_huge(vma))
 			return;
-		if (unlikely(is_pmd_migration_entry(old_pmd))) {
-			swp_entry_t entry;
+		if (unlikely(pmd_is_migration_entry(old_pmd))) {
+			const softleaf_t old_entry = softleaf_from_pmd(old_pmd);
 
-			entry = pmd_to_swp_entry(old_pmd);
-			folio = pfn_swap_entry_folio(entry);
+			folio = softleaf_to_folio(old_entry);
 		} else if (is_huge_zero_pmd(old_pmd)) {
 			return;
 		} else {
@@ -3037,31 +3034,34 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 		return __split_huge_zero_page_pmd(vma, haddr, pmd);
 	}
 
+	if (pmd_is_migration_entry(*pmd)) {
+		softleaf_t entry;
 
-	if (is_pmd_migration_entry(*pmd)) {
 		old_pmd = *pmd;
-		entry = pmd_to_swp_entry(old_pmd);
-		page = pfn_swap_entry_to_page(entry);
+		entry = softleaf_from_pmd(old_pmd);
+		page = softleaf_to_page(entry);
 		folio = page_folio(page);
 
 		soft_dirty = pmd_swp_soft_dirty(old_pmd);
 		uffd_wp = pmd_swp_uffd_wp(old_pmd);
 
-		write = is_writable_migration_entry(entry);
+		write = softleaf_is_migration_write(entry);
 		if (PageAnon(page))
-			anon_exclusive = is_readable_exclusive_migration_entry(entry);
-		young = is_migration_entry_young(entry);
-		dirty = is_migration_entry_dirty(entry);
-	} else if (is_pmd_device_private_entry(*pmd)) {
+			anon_exclusive = softleaf_is_migration_read_exclusive(entry);
+		young = softleaf_is_migration_young(entry);
+		dirty = softleaf_is_migration_dirty(entry);
+	} else if (pmd_is_device_private_entry(*pmd)) {
+		softleaf_t entry;
+
 		old_pmd = *pmd;
-		entry = pmd_to_swp_entry(old_pmd);
-		page = pfn_swap_entry_to_page(entry);
+		entry = softleaf_from_pmd(old_pmd);
+		page = softleaf_to_page(entry);
 		folio = page_folio(page);
 
 		soft_dirty = pmd_swp_soft_dirty(old_pmd);
 		uffd_wp = pmd_swp_uffd_wp(old_pmd);
 
-		write = is_writable_device_private_entry(entry);
+		write = softleaf_is_device_private_write(entry);
 		anon_exclusive = PageAnonExclusive(page);
 
 		/*
@@ -3165,7 +3165,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 	 * Note that NUMA hinting access restrictions are not transferred to
 	 * avoid any possibility of altering permissions across VMAs.
 	 */
-	if (freeze || is_pmd_migration_entry(old_pmd)) {
+	if (freeze || pmd_is_migration_entry(old_pmd)) {
 		pte_t entry;
 		swp_entry_t swp_entry;
 
@@ -3191,7 +3191,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 			VM_WARN_ON(!pte_none(ptep_get(pte + i)));
 			set_pte_at(mm, addr, pte + i, entry);
 		}
-	} else if (is_pmd_device_private_entry(old_pmd)) {
+	} else if (pmd_is_device_private_entry(old_pmd)) {
 		pte_t entry;
 		swp_entry_t swp_entry;
 
@@ -3241,7 +3241,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 	}
 	pte_unmap(pte);
 
-	if (!is_pmd_migration_entry(*pmd))
+	if (!pmd_is_migration_entry(*pmd))
 		folio_remove_rmap_pmd(folio, page, vma);
 	if (freeze)
 		put_page(page);
@@ -3254,7 +3254,7 @@ void split_huge_pmd_locked(struct vm_area_struct *vma, unsigned long address,
 			   pmd_t *pmd, bool freeze)
 {
 	VM_WARN_ON_ONCE(!IS_ALIGNED(address, HPAGE_PMD_SIZE));
-	if (pmd_trans_huge(*pmd) || is_pmd_non_present_folio_entry(*pmd))
+	if (pmd_trans_huge(*pmd) || pmd_is_valid_softleaf(*pmd))
 		__split_huge_pmd_locked(vma, pmd, address, freeze);
 }
 
@@ -4855,12 +4855,12 @@ void remove_migration_pmd(struct page_vma_mapped_walk *pvmw, struct page *new)
 	unsigned long address = pvmw->address;
 	unsigned long haddr = address & HPAGE_PMD_MASK;
 	pmd_t pmde;
-	swp_entry_t entry;
+	softleaf_t entry;
 
 	if (!(pvmw->pmd && !pvmw->pte))
 		return;
 
-	entry = pmd_to_swp_entry(*pvmw->pmd);
+	entry = softleaf_from_pmd(*pvmw->pmd);
 	folio_get(folio);
 	pmde = folio_mk_pmd(folio, READ_ONCE(vma->vm_page_prot));
 
@@ -4876,20 +4876,20 @@ void remove_migration_pmd(struct page_vma_mapped_walk *pvmw, struct page *new)
 
 	if (pmd_swp_soft_dirty(*pvmw->pmd))
 		pmde = pmd_mksoft_dirty(pmde);
-	if (is_writable_migration_entry(entry))
+	if (softleaf_is_migration_write(entry))
 		pmde = pmd_mkwrite(pmde, vma);
 	if (pmd_swp_uffd_wp(*pvmw->pmd))
 		pmde = pmd_mkuffd_wp(pmde);
-	if (!is_migration_entry_young(entry))
+	if (!softleaf_is_migration_young(entry))
 		pmde = pmd_mkold(pmde);
 	/* NOTE: this may contain setting soft-dirty on some archs */
-	if (folio_test_dirty(folio) && is_migration_entry_dirty(entry))
+	if (folio_test_dirty(folio) && softleaf_is_migration_dirty(entry))
 		pmde = pmd_mkdirty(pmde);
 
 	if (folio_test_anon(folio)) {
 		rmap_t rmap_flags = RMAP_NONE;
 
-		if (!is_readable_migration_entry(entry))
+		if (!softleaf_is_migration_read(entry))
 			rmap_flags |= RMAP_EXCLUSIVE;
 
 		folio_add_anon_rmap_pmd(folio, new, vma, haddr, rmap_flags);
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index a97ff7bcb232..1a08673b0d8b 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -17,7 +17,7 @@
 #include <linux/page_idle.h>
 #include <linux/page_table_check.h>
 #include <linux/rcupdate_wait.h>
-#include <linux/swapops.h>
+#include <linux/leafops.h>
 #include <linux/shmem_fs.h>
 #include <linux/dax.h>
 #include <linux/ksm.h>
@@ -941,7 +941,7 @@ static inline int check_pmd_state(pmd_t *pmd)
 	 * collapse it. Migration success or failure will eventually end
 	 * up with a present PMD mapping a folio again.
 	 */
-	if (is_pmd_migration_entry(pmde))
+	if (pmd_is_migration_entry(pmde))
 		return SCAN_PMD_MAPPED;
 	if (!pmd_present(pmde))
 		return SCAN_PMD_NULL;
diff --git a/mm/madvise.c b/mm/madvise.c
index 58d82495b6c6..ffae3b566dc1 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -390,7 +390,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 
 		if (unlikely(!pmd_present(orig_pmd))) {
 			VM_BUG_ON(thp_migration_supported() &&
-					!is_pmd_migration_entry(orig_pmd));
+					!pmd_is_migration_entry(orig_pmd));
 			goto huge_unlock;
 		}
 
diff --git a/mm/memory.c b/mm/memory.c
index fea079e5fb90..bf2bbd0dbc97 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -6362,10 +6362,10 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
 		goto fallback;
 
 	if (unlikely(!pmd_present(vmf.orig_pmd))) {
-		if (is_pmd_device_private_entry(vmf.orig_pmd))
+		if (pmd_is_device_private_entry(vmf.orig_pmd))
 			return do_huge_pmd_device_private(&vmf);
 
-		if (is_pmd_migration_entry(vmf.orig_pmd))
+		if (pmd_is_migration_entry(vmf.orig_pmd))
 			pmd_migration_entry_wait(mm, vmf.pmd);
 		return 0;
 	}
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 7ae3f5e2dee6..01c3b98f87a6 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -110,7 +110,7 @@
 #include <linux/mm_inline.h>
 #include <linux/mmu_notifier.h>
 #include <linux/printk.h>
-#include <linux/swapops.h>
+#include <linux/leafops.h>
 #include <linux/gcd.h>
 
 #include <asm/tlbflush.h>
@@ -647,7 +647,7 @@ static void queue_folios_pmd(pmd_t *pmd, struct mm_walk *walk)
 	struct folio *folio;
 	struct queue_pages *qp = walk->private;
 
-	if (unlikely(is_pmd_migration_entry(*pmd))) {
+	if (unlikely(pmd_is_migration_entry(*pmd))) {
 		qp->nr_failed++;
 		return;
 	}
diff --git a/mm/migrate.c b/mm/migrate.c
index 862b2e261cf9..3b6bd374157d 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -16,7 +16,7 @@
 #include <linux/migrate.h>
 #include <linux/export.h>
 #include <linux/swap.h>
-#include <linux/swapops.h>
+#include <linux/leafops.h>
 #include <linux/pagemap.h>
 #include <linux/buffer_head.h>
 #include <linux/mm_inline.h>
@@ -353,7 +353,7 @@ static bool remove_migration_pte(struct folio *folio,
 		rmap_t rmap_flags = RMAP_NONE;
 		pte_t old_pte;
 		pte_t pte;
-		swp_entry_t entry;
+		softleaf_t entry;
 		struct page *new;
 		unsigned long idx = 0;
 
@@ -379,22 +379,22 @@ static bool remove_migration_pte(struct folio *folio,
 		folio_get(folio);
 		pte = mk_pte(new, READ_ONCE(vma->vm_page_prot));
 
-		entry = pte_to_swp_entry(old_pte);
-		if (!is_migration_entry_young(entry))
+		entry = softleaf_from_pte(old_pte);
+		if (!softleaf_is_migration_young(entry))
 			pte = pte_mkold(pte);
-		if (folio_test_dirty(folio) && is_migration_entry_dirty(entry))
+		if (folio_test_dirty(folio) && softleaf_is_migration_dirty(entry))
 			pte = pte_mkdirty(pte);
 		if (pte_swp_soft_dirty(old_pte))
 			pte = pte_mksoft_dirty(pte);
 		else
 			pte = pte_clear_soft_dirty(pte);
 
-		if (is_writable_migration_entry(entry))
+		if (softleaf_is_migration_write(entry))
 			pte = pte_mkwrite(pte, vma);
 		else if (pte_swp_uffd_wp(old_pte))
 			pte = pte_mkuffd_wp(pte);
 
-		if (folio_test_anon(folio) && !is_readable_migration_entry(entry))
+		if (folio_test_anon(folio) && !softleaf_is_migration_read(entry))
 			rmap_flags |= RMAP_EXCLUSIVE;
 
 		if (unlikely(is_device_private_page(new))) {
@@ -404,7 +404,7 @@ static bool remove_migration_pte(struct folio *folio,
 			else
 				entry = make_readable_device_private_entry(
 							page_to_pfn(new));
-			pte = swp_entry_to_pte(entry);
+			pte = softleaf_to_pte(entry);
 			if (pte_swp_soft_dirty(old_pte))
 				pte = pte_swp_mksoft_dirty(pte);
 			if (pte_swp_uffd_wp(old_pte))
@@ -543,9 +543,9 @@ void pmd_migration_entry_wait(struct mm_struct *mm, pmd_t *pmd)
 	spinlock_t *ptl;
 
 	ptl = pmd_lock(mm, pmd);
-	if (!is_pmd_migration_entry(*pmd))
+	if (!pmd_is_migration_entry(*pmd))
 		goto unlock;
-	migration_entry_wait_on_locked(pmd_to_swp_entry(*pmd), ptl);
+	migration_entry_wait_on_locked(softleaf_from_pmd(*pmd), ptl);
 	return;
 unlock:
 	spin_unlock(ptl);
diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index c869b272e85a..880f26a316f8 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -13,7 +13,7 @@
 #include <linux/oom.h>
 #include <linux/pagewalk.h>
 #include <linux/rmap.h>
-#include <linux/swapops.h>
+#include <linux/leafops.h>
 #include <linux/pgalloc.h>
 #include <asm/tlbflush.h>
 #include "internal.h"
@@ -145,7 +145,6 @@ static int migrate_vma_collect_huge_pmd(pmd_t *pmdp, unsigned long start,
 	struct folio *folio;
 	struct migrate_vma *migrate = walk->private;
 	spinlock_t *ptl;
-	swp_entry_t entry;
 	int ret;
 	unsigned long write = 0;
 
@@ -169,23 +168,24 @@ static int migrate_vma_collect_huge_pmd(pmd_t *pmdp, unsigned long start,
 		if (pmd_write(*pmdp))
 			write = MIGRATE_PFN_WRITE;
 	} else if (!pmd_present(*pmdp)) {
-		entry = pmd_to_swp_entry(*pmdp);
-		folio = pfn_swap_entry_folio(entry);
+		const softleaf_t entry = softleaf_from_pmd(*pmdp);
 
-		if (!is_device_private_entry(entry) ||
+		folio = softleaf_to_folio(entry);
+
+		if (!softleaf_is_device_private(entry) ||
 			!(migrate->flags & MIGRATE_VMA_SELECT_DEVICE_PRIVATE) ||
 			(folio->pgmap->owner != migrate->pgmap_owner)) {
 			spin_unlock(ptl);
 			return migrate_vma_collect_skip(start, end, walk);
 		}
 
-		if (is_migration_entry(entry)) {
+		if (softleaf_is_migration(entry)) {
 			migration_entry_wait_on_locked(entry, ptl);
 			spin_unlock(ptl);
 			return -EAGAIN;
 		}
 
-		if (is_writable_device_private_entry(entry))
+		if (softleaf_is_device_private_write(entry))
 			write = MIGRATE_PFN_WRITE;
 	} else {
 		spin_unlock(ptl);
diff --git a/mm/page_table_check.c b/mm/page_table_check.c
index f5f25e120f69..9af1ecff5221 100644
--- a/mm/page_table_check.c
+++ b/mm/page_table_check.c
@@ -8,7 +8,7 @@
 #include <linux/mm.h>
 #include <linux/page_table_check.h>
 #include <linux/swap.h>
-#include <linux/swapops.h>
+#include <linux/leafops.h>
 
 #undef pr_fmt
 #define pr_fmt(fmt)	"page_table_check: " fmt
@@ -179,10 +179,10 @@ void __page_table_check_pud_clear(struct mm_struct *mm, pud_t pud)
 EXPORT_SYMBOL(__page_table_check_pud_clear);
 
 /* Whether the swap entry cached writable information */
-static inline bool swap_cached_writable(swp_entry_t entry)
+static inline bool softleaf_cached_writable(softleaf_t entry)
 {
-	return is_writable_device_private_entry(entry) ||
-	       is_writable_migration_entry(entry);
+	return softleaf_is_device_private(entry) ||
+		softleaf_is_migration_write(entry);
 }
 
 static void page_table_check_pte_flags(pte_t pte)
@@ -190,9 +190,9 @@ static void page_table_check_pte_flags(pte_t pte)
 	if (pte_present(pte)) {
 		WARN_ON_ONCE(pte_uffd_wp(pte) && pte_write(pte));
 	} else if (pte_swp_uffd_wp(pte)) {
-		const swp_entry_t entry = pte_to_swp_entry(pte);
+		const softleaf_t entry = softleaf_from_pte(pte);
 
-		WARN_ON_ONCE(swap_cached_writable(entry));
+		WARN_ON_ONCE(softleaf_cached_writable(entry));
 	}
 }
 
@@ -219,9 +219,9 @@ static inline void page_table_check_pmd_flags(pmd_t pmd)
 		if (pmd_uffd_wp(pmd))
 			WARN_ON_ONCE(pmd_write(pmd));
 	} else if (pmd_swp_uffd_wp(pmd)) {
-		swp_entry_t entry = pmd_to_swp_entry(pmd);
+		const softleaf_t entry = softleaf_from_pmd(pmd);
 
-		WARN_ON_ONCE(swap_cached_writable(entry));
+		WARN_ON_ONCE(softleaf_cached_writable(entry));
 	}
 }
 
diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index a4e23818f37f..8137d2366722 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -242,18 +242,19 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 		 */
 		pmde = pmdp_get_lockless(pvmw->pmd);
 
-		if (pmd_trans_huge(pmde) || is_pmd_migration_entry(pmde)) {
+		if (pmd_trans_huge(pmde) || pmd_is_migration_entry(pmde)) {
 			pvmw->ptl = pmd_lock(mm, pvmw->pmd);
 			pmde = *pvmw->pmd;
 			if (!pmd_present(pmde)) {
-				swp_entry_t entry;
+				softleaf_t entry;
 
 				if (!thp_migration_supported() ||
 				    !(pvmw->flags & PVMW_MIGRATION))
 					return not_found(pvmw);
-				entry = pmd_to_swp_entry(pmde);
-				if (!is_migration_entry(entry) ||
-				    !check_pmd(swp_offset_pfn(entry), pvmw))
+				entry = softleaf_from_pmd(pmde);
+
+				if (!softleaf_is_migration(entry) ||
+				    !check_pmd(softleaf_to_pfn(entry), pvmw))
 					return not_found(pvmw);
 				return true;
 			}
@@ -273,9 +274,9 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 			 * cannot return prematurely, while zap_huge_pmd() has
 			 * cleared *pmd but not decremented compound_mapcount().
 			 */
-			swp_entry_t entry = pmd_to_swp_entry(pmde);
+			const softleaf_t entry = softleaf_from_pmd(pmde);
 
-			if (is_device_private_entry(entry)) {
+			if (softleaf_is_device_private(entry)) {
 				pvmw->ptl = pmd_lock(mm, pvmw->pmd);
 				return true;
 			}
diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index 9f91cf85a5be..3067feb970d1 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -5,7 +5,7 @@
 #include <linux/hugetlb.h>
 #include <linux/mmu_context.h>
 #include <linux/swap.h>
-#include <linux/swapops.h>
+#include <linux/leafops.h>
 
 #include <asm/tlbflush.h>
 
@@ -966,10 +966,10 @@ struct folio *folio_walk_start(struct folio_walk *fw,
 				goto found;
 			}
 		} else if ((flags & FW_MIGRATION) &&
-			   is_pmd_migration_entry(pmd)) {
-			swp_entry_t entry = pmd_to_swp_entry(pmd);
+			   pmd_is_migration_entry(pmd)) {
+			const softleaf_t entry = softleaf_from_pmd(pmd);
 
-			page = pfn_swap_entry_to_page(entry);
+			page = softleaf_to_page(entry);
 			expose_page = false;
 			goto found;
 		}
diff --git a/mm/rmap.c b/mm/rmap.c
index 1954c538a991..775710115a41 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -57,7 +57,7 @@
 #include <linux/sched/task.h>
 #include <linux/pagemap.h>
 #include <linux/swap.h>
-#include <linux/swapops.h>
+#include <linux/leafops.h>
 #include <linux/slab.h>
 #include <linux/init.h>
 #include <linux/ksm.h>
@@ -2341,7 +2341,7 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 			if (likely(pmd_present(pmdval)))
 				pfn = pmd_pfn(pmdval);
 			else
-				pfn = swp_offset_pfn(pmd_to_swp_entry(pmdval));
+				pfn = softleaf_to_pfn(softleaf_from_pmd(pmdval));
 
 			subpage = folio_page(folio, pfn - folio_pfn(folio));
 
-- 
2.51.0


