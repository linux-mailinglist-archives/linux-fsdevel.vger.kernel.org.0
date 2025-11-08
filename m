Return-Path: <linux-fsdevel+bounces-67538-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C6F6C430AE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 08 Nov 2025 18:12:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C2B0C4E974B
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Nov 2025 17:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229B12475C8;
	Sat,  8 Nov 2025 17:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Aj3h4dct";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Fr3WKaQz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0A924166E;
	Sat,  8 Nov 2025 17:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762621868; cv=fail; b=qxxNTRZQKMWQn6A45MdEzwHk4YFPDUci631V9QQ0f+dsBdstle1KY1G8UcpKCDv1oCUHzzoG5dW2sNr17afe+2CZdef20iqYsIQWDVqS8+NZtDaldF/4Q5Pkl+z5AQeCPsR0D8zCpJZmrlzWKGLHBl8wL4rLJEuswuI00L/kYUU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762621868; c=relaxed/simple;
	bh=Jc7k15MXVqD+LodAv3sGe3ypLfG9f5hKPjGmdnE6+KA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AnlM20vLHYoz5glt4kpCRt1L1zFuXXeVdJxbnLoHzbqsV7zrS7D+1wtMd0ccmPJwW4tWzdy/9c6331hEBSkhFi6CT0vJgAB3YSnmpBS0qqTrDDu+pkEylp5E2g6wjwrLzc2FwEWxb9o6cCVjedACIJfSB9WzC42wLqi8/nwNfH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Aj3h4dct; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Fr3WKaQz; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A8GjT4w017275;
	Sat, 8 Nov 2025 17:09:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=8WOrh/xELmUWEKs0VQab4I3hnqf3OQgLiTzmuIkkR3k=; b=
	Aj3h4dctMZiDfW8t9I6vMNzn2/iMWc3JboxVnv1CtxM87XgWF2GjO8e6Np0jv7lT
	UIoCgP8iynGStItKbgRgOvQ5ugTIjlGOurK+foxAEmhfJdiQ5L1uMrQHcbsQVCQb
	GL6SRGzop7FO0KaOsd90AK0JbxlFPjSGyJSWFqjxXLOWvRoDpgWt3/u1qV/N7YF8
	fm41wWvQX+7A7IdlwJPpVhCB3BZMzopcUpMIS5/rgh7bhDIGwvzamwtg0h7kIR/l
	9pfomoLx/TI0gElLf0R1AgdgP4ThJAB6sesgVnf6L2M/i0LsoPEzwUW7EjpY7VvI
	dUSWXOoF6dv+k2amsbQVyw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aa8se01uk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 08 Nov 2025 17:09:09 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A8GJAIj009996;
	Sat, 8 Nov 2025 17:09:08 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010033.outbound.protection.outlook.com [52.101.85.33])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vagembr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 08 Nov 2025 17:09:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YvFjvc4lTs+sxVxr3kFu1cCEz0Wm37jbRSzc8a7nqj5wkrhllk+fWqdJFmAFanln5WeSNvYm43ZfvnVoxbg5t13Y4uIAogz1+3F7qqi+KvAOSo/fDZp9Tspb5uP94vKV+dVZoZL1W0BL9ewiQ3tLRM4Inc13pRb1CJnbvUGep9aPxY2IegSzdv8p+qSfxLAv/DGNTTdqqjulROAb4o00806plj6e6X0riZFMApXsyFc10RFuRVbMAJchRRZND4bz+P/Cmpfj+1D+pcXOroLxFV1rm14DhFwWvHfj8n0A2NGK/SBOMuHPFaIkpNlTjbE9xvmLX29dYkWacj7UWMNciw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8WOrh/xELmUWEKs0VQab4I3hnqf3OQgLiTzmuIkkR3k=;
 b=e8BP4i3pyKWdPb61uTccDhizT0+e6QfD9v8wm+GHVkASZKfgv3NKPmlNJaHWm3kSaLxBTygBUrspNZjkHUif7w/RZeNZHAC0TKpY6CLQCp1t3Pwjd76AWLx3wHO365QsOMRTN1MI+1LCQqwRZGRKmioGUGtAClsW267WGWXf+P31yy508BKGDR3IduhRF/2oGEI12NcIjHrL1rK43volvZZuKar6QkiqYxely/MJRfRWFwe/KkWk8mOteD+f98jwULk7eApifoWUn+iyCCt68d/J7fdFdvDWNGvCrarLy2+MMudjJjUvgsnYr/KfumWVGmEkKddN6ftQnsoOAuyF4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8WOrh/xELmUWEKs0VQab4I3hnqf3OQgLiTzmuIkkR3k=;
 b=Fr3WKaQzg9nb3pOIi89AsFWlhdZ6lhyOvzdktzzkN8USDIO2GQByGJHZiJldP9oiTReRKsVZVMRu6eBOXiWnsAannCO2rxOewNSmq/XP1o5ADGD8Qqhh1vlHTC71qobnBxmKdRhdlVo/rc90CEGWsd98Cctj94myCdxtT0Ol9zU=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ5PPF04D2D7FA7.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::785) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.15; Sat, 8 Nov
 2025 17:09:04 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9298.010; Sat, 8 Nov 2025
 17:09:03 +0000
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
Subject: [PATCH v2 05/16] mm: use leaf entries in debug pgtable + remove is_swap_pte()
Date: Sat,  8 Nov 2025 17:08:19 +0000
Message-ID: <cbde30aa646d972075319362be7c95afeea9d854.1762621568.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1762621567.git.lorenzo.stoakes@oracle.com>
References: <cover.1762621567.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO6P265CA0026.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ff::16) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ5PPF04D2D7FA7:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ca9aacd-8205-456b-4507-08de1ee984db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cc91QwHrufHWJo1l13EFwbJO1ip+M6a4jEw8ilngtQihk/y9P8tQYkabFifk?=
 =?us-ascii?Q?1cnZQjDc/gQwz3eha8wnsQ45cIQ8eC4+yy4zl9SM8uLyNsxdSuNPIb7up067?=
 =?us-ascii?Q?uPQSXQoYOOfWRqBKeeIx+QgiC8tczi//eh02Eool6fZE3Wo3OH1pGfq4HcSb?=
 =?us-ascii?Q?kLJcqpXtRHYbzu4Z+ijewhKb0GpJYg1RSL7u7q8FSDBb0lc2SVftF4gIslts?=
 =?us-ascii?Q?tqEnCiohjR1EOFMSbWjiBDU7RYhqdC4bWDc2QpcwDEYb7mf6t7muNC6TYMSi?=
 =?us-ascii?Q?uspAB4Ykz8gZNI6ZxA3qT2EFyfdGWFux5y/oQc7+eSifBYSk+E6qT1PQ6fls?=
 =?us-ascii?Q?dwrCC9UW7HMGBtEpt7W70EYGmIleCj76sOpRe6KfjIQI/pfaElytzPs98Rl6?=
 =?us-ascii?Q?DF4XAFmGSRy8v9Wte0W+ZEpy9LUi44vwCvWmToC/GS/2cPe+bd0iNQcWXuJw?=
 =?us-ascii?Q?X7W6sHlpqnSeB7qSgoz4blAiNowjqRCD9htV9sqPSsrk9gujLGs1OExNf4OR?=
 =?us-ascii?Q?gJpr5pF+pu4ZfZ60m/u3cH9LhRVEBwGnw/K2KPUywPOcDgVU5hqJOrhLXo5g?=
 =?us-ascii?Q?t5QsejxeolFotUairjY3AWitn5R7N+GTjcDpprjMndf8uOqYdinKyCbahjL2?=
 =?us-ascii?Q?WeetPpBhl6U/jVVIn6c1U9uLF/BeJ12gooqXi9dEOcoRjCBGgJ8G+xv2Dvo+?=
 =?us-ascii?Q?W2+Bkqwn6ov7QSAoQFpUXobg6yJjLqsyS9pOYDqpWRL2UUaqKIYZKoN1b22h?=
 =?us-ascii?Q?LwqzXpDhN10E+Z2w0keJ4lnSdX1n00Ev1FOnBIsKCcwuN5u3PFQAXrzn2KFY?=
 =?us-ascii?Q?XkkprKjLLdh8121yuRidcHhFMO+Dd0x/LOPyXmzfmehJX3lQdyHjywO3z3P0?=
 =?us-ascii?Q?crwP4ls01pN0foI1xvhUZzPLHbLzMgxmetDR2ZJwi+DvL7aOb2jef34wKRYi?=
 =?us-ascii?Q?FuZ0P34VWEqcNHLMr7+UqbSD6bOvJA3FkFxBhSs6inNgr+k21BkF+oGCeHVh?=
 =?us-ascii?Q?yUqo+UsM2pOT7kWO/TIBEFI7MyuNml57z7arQOMtF2aQzhYbXf2dVPjuEF6R?=
 =?us-ascii?Q?FjLiPcSZzGIt2QOxjRLQrL0Ssu6aA6jZR2/D9qYEdm0U6DWSBdtGv8YQNuJZ?=
 =?us-ascii?Q?2eJIuic+f4/tj8wkW4K/VKjEr0TeTVYYFppL0WGqEVSWiGaSVjyGi1XxNiWI?=
 =?us-ascii?Q?hj5ht58IgUl/jR3B1TH2ji0V2QDTtromGesWxYRkBm4qi9GVW8PrpSaBt8x5?=
 =?us-ascii?Q?u3gHt862fTvfZcWX1qni3lJEaVjMw+YYrjnA5k5/jLK4YcpWdoa071GZEbDC?=
 =?us-ascii?Q?K94/9joCuXJmvS3b4Y/B/WA8twxYN7wlJvLOyleHIzVQrvngaIX4BXzhBS6S?=
 =?us-ascii?Q?ozJeKGQTH2gT8gCA7xv2y+ODLEhmZuT8cdrOGbPFNED7XBRo48PRp0fHHWZy?=
 =?us-ascii?Q?lhlrdmgpwTCambKvzUj/c+WaW2up/prG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?z3nEX78a01Q9ZW80uv4f134q84dGlMfrHMi2pQqPOGFvHJrTJr5HkhiGKSpj?=
 =?us-ascii?Q?DAOYdoai2glsxeqHEd0eeP7IJdSxjXLyCt9YvvobKRorISPDYSRWGRSmElCW?=
 =?us-ascii?Q?jq/bAvBUhf2AMM+JF9RQQBk+0iPlFQg6l9M6Xsivce1S/SeracHKrRf1FMRq?=
 =?us-ascii?Q?Kcqpjbmfq0CDbfADsHWDu5NZeIQyFt7+lL8WXXjFbf8zcqCp1RdLy3ER7MVa?=
 =?us-ascii?Q?1C3jwD9caxpxlgCScuKwgLes/KEffDMWGu88Xp1L3jZTpe/7sChVfPNRqkS7?=
 =?us-ascii?Q?ab+gpbkjVQAAa5R64TUwqKUffbybaAX71UvN3GNNNRB1pK969bl+54yOhPZ6?=
 =?us-ascii?Q?DGdrdu5t9dV7pbmou6eVBm0D4VD/FCNYnMiMiiLrxakIQGl9HB/cVA7/MAdW?=
 =?us-ascii?Q?X7E7UVsOUNIH025rJiu5tJhfDNqqNLh5MAkw897oAPBy5mdpNN4pUlZslsUU?=
 =?us-ascii?Q?oodvb8qhZsQ6FhN1Qc0q1YCbJAv2A48zLbmN7IClxObvCDWvogEsVnk+zxXs?=
 =?us-ascii?Q?JxcmoebkW8faiV4i+hibnv3mFT9nNWDUQ66Gkfj+O1h467TBGSC58HpuyX12?=
 =?us-ascii?Q?/UuACBppQWUHWHISx6q8IVe07kywkgfKdCUSX3i/cYuuYKF9FAKaUTZtXrAr?=
 =?us-ascii?Q?AWgnsjUA2Lw6UZKyOsX/R8C2EFgNgWRVYPmZzSAprBan2w9nkmTmntvTiu4X?=
 =?us-ascii?Q?LrYFTG6+de1NWXoYivY24fD3bxmGmwGDBhcnC5ufTDxb5jl7lPK/L8kiX9fM?=
 =?us-ascii?Q?kO9HxSE2RxT7n2onPalZO08F5FGU5bxGw7p4h6Zd6a7NfRFPujUNOiAg9avI?=
 =?us-ascii?Q?7WSmy3V6g9S4y9nrKrK+fpgI+83HUpWISWDqpAzKPaaYwRc0lJbPjVIE1yfD?=
 =?us-ascii?Q?e6d+aKNg+lwOsbB/z5YpkDRQs9hT4IwFUWl2cIx1hacAFSXl0sIi7OA7d8vF?=
 =?us-ascii?Q?U5AwEcEp/xDmmaphwJGaqYznrD6EGCxH9JteHNztgt/1UVlYEFCXJ/WlPvAi?=
 =?us-ascii?Q?b7Pz1JbnD+PDP3hhgEu/TjQ8+/fIiK+STgKGWR4Uh2vCY7FcsRQTMsi+NKkW?=
 =?us-ascii?Q?gr6UxlnguTpCIxAvkERBmdex0hr5jtdGbOGSlX+dGWosNVukysf1Pe/J0yep?=
 =?us-ascii?Q?IV4wR94qIJMDfomlII0p3n1T+Mv1YjJimCS21wj40In0RlaQVmaiy/zPIxai?=
 =?us-ascii?Q?mX6YHG591pMPYJd9ejGhnZSuK5GMsuh177xiLjD+Afi9V1eeM2rju6y6VUu/?=
 =?us-ascii?Q?wnPU6EHeKmE5qSKousVj+KGbmKGbWWBAHfYc3fxoiMJYhZ4LFgLH2oD5OVkh?=
 =?us-ascii?Q?QMDLGnZdQixuvYFhPXCLhD812aKMlrYCLNWOBKWuHXsKlQksy0XVJ+ZrKwYP?=
 =?us-ascii?Q?MqwgC5TIiypn4RwDfJXCms9XDeRHR2cwcHzITkDrojpKa/1DVJPNulkgp1rl?=
 =?us-ascii?Q?IzvPd/+89Jd0LGg0MSRBD0f43Ag6sHE4i611pM+oHcrO/aNVXBQ8kNp006CM?=
 =?us-ascii?Q?OjwY/UdC5arswIS5O19AKtal+X7cDZdNCgb++M6TOp2qMzRAJmqi82/4LmM7?=
 =?us-ascii?Q?6hOEbV9FrPcIWetttJhhbiB/s6rKcc8TPYmbqYqyH1euY5X7YCWA9azy2IsA?=
 =?us-ascii?Q?EQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qA3+vqIhykcsVZYqNnm3GV5LO+/6aJme/p+72ChkDDgfHxmoCw2zjlpVeyaTRdDUud6SZrXfrP9846CPVj8FltVTAY1so97TqXoNyiHgNuhJbFApga2KMhwHGOeSfnOwiuAkPTvre3pxtWyjJj+Jtlgc2uBznsQ4uuKbwj4xvQn0T2X//nTJflUbcOMGdfk2vOoSKHi3P1lipvu8BPRtX0lL/dgitNsOkrUHVeRyBIwRPcooAGlYIJ3Uqaj0YDfxq3xpKqq09jlwhzmqsaIEXOzZO36VSWWW7hGqEc4lHViw3RPWj2/8Ab6J2ewuKe0Iyo/sfrdvQIVc1jSPacA/E9WIWXiHa9Jy7OHnQpfvw5IzgxBNF8ELcrTntX8cIJ1w+Fxn8mHYO8nV9IGKZZBZrxToTUOfGgqKrh/VRbfs4ZSIouljivoUL0haLk8allSoF98rz/qXAR03mwdQUMr/aZ0zog80nYIsUUZFe155YY36cHAwiPvKXeUPvsNGaP4qgyndiz8YAdgTkBZanKKX5BBepg4VvUcs3JGAQUV0Itaa2uQs9QlL6rfujV/X2vYwVx/vpmGSsAUREn2pkoPAlVVNR5HHZRlzFvqTDj5f8M0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ca9aacd-8205-456b-4507-08de1ee984db
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2025 17:09:03.9038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1JnKtIR8avMaNfqfalDIy3+JRl6KdTE8ADmE4zWsDennJnnIP2o1I+t2K9n7pUxG0SYXfiC/SsDO+pJLe5yyB5eFgccN9QmSAM4f8oiys5c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF04D2D7FA7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-08_04,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 mlxscore=0
 phishscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511080138
X-Proofpoint-GUID: Ppu5FyRV1xIBMRz-rFST-2xpuFs7Efdi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDEyNiBTYWx0ZWRfX5IvDZlE09dY9
 r/1xpOGBD+JCQf2U3UJov2DrGAVQrvVcp/SDAOnNKMyAs0OeWZPoVM2xtevtNAt5hBKUz+wSbw7
 KXaLcNO6f6yQkAQ9jvQMESG1BT4DC0hwmaiAghfNnt+2i34mROXVd5PP6MQAi/Nz72aVOo97b4K
 UOeJaR8vlPz5rFZCYSxhSMBGR6AmIJfzxehDjf+Sk7AqYkKBtGM2dEcwZzhpv3Up0EpX4GfSfHz
 NmU1j3pUuuM2IYT1qWJ6ptILpDFtOjlrml82Ol7Uw6yJkU13JZv27fp2HJwStp+jtPODzWfl1/6
 AwoCW0vb/leHlfEADLNEgUKKUgI6B42q7SbpnteuO8i1robhdT16FJJkC0ii2bIMUBYU/lIkq0g
 YrR2XXsMT8+nH08UoX7kIkjel7IjEmePlEpWiAHVe/ryHbjj6zk=
X-Authority-Analysis: v=2.4 cv=XuL3+FF9 c=1 sm=1 tr=0 ts=690f7935 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=JfhMdzgkenBfAv4L-EYA:9 cc=ntf awl=host:12097
X-Proofpoint-ORIG-GUID: Ppu5FyRV1xIBMRz-rFST-2xpuFs7Efdi

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


