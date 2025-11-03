Return-Path: <linux-fsdevel+bounces-66766-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D330C2BBBB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 13:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A6423B8E94
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 12:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E8C33126CC;
	Mon,  3 Nov 2025 12:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XaiyYj+3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xzSzCtTM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600F73126AD;
	Mon,  3 Nov 2025 12:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762173272; cv=fail; b=YW1Fy2CaEVZGmKRceu80c6jrCxcaki0z1xvAO6xgOoQrHdd6GV1/hPKrBtccTslXo/YHSfU0pio6QZ+G0OoKhLuUoK+xlub2HhEgncV/NET+e+CaKLmeqqVZNwIRbJ91B+MSRuUVWBobFWklP9Sp0lDMHfqwMAwGYj0zLdw7LoQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762173272; c=relaxed/simple;
	bh=bTGeoWEFRPBEOYbicw5Zn3NfHUd0VyZg0MJgxzSnhaI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oi7388ucDM7WUZ6OJ0wZgfQy7IHHv9PKNqiJvYtpzaoypfZbM4eu4euOl2XOP7moqhOmN24cqCo6oUb1xq/LgWmyRXe1EWGPjIp0Qiehhw+QfcIOJUbhqM3jqx/Q9p0oZA0dgXbxLnLDsphmyrgeniCoq4b8U3qJqxyoW6YE/3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XaiyYj+3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xzSzCtTM; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A3CP2eJ031542;
	Mon, 3 Nov 2025 12:32:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=oS6cqbGj7LwBiJddYfaMT+LmpgHZcgkQu6AukRJJYtg=; b=
	XaiyYj+3uzYomOSVjF+V8MOD7KVd/hAlSLAM3sgBBGiDV3VPwlmY8hxM7E90rfMQ
	WitX6uSD9/YpKKDUFUm7J4jPF1d1cjMMWMtYxUm4QjvNZyGmyp+QiGaFuvzhzyk3
	m2+sC00DzlLIWGeey3GfbCYDrKSk8xe8RSHLvvp7mB+08d+tA9+6zuMqEyxQaDvc
	Va0DKalWQtbeLDN9r/xSjYmNsrVSu914IP4W5bcTgvdx9N+FoiL1Y/vjPJaU4hO0
	fOx2hgONhEuwdkTx8V8fxPgS9HfzdXKoSFhbI/poEYx/HWz6kOp5S4Jhv+5+Zr7g
	/WlQ9B6oc6paVLxwceZoPQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a6vcb80fn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Nov 2025 12:32:30 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A3AfW3j039684;
	Mon, 3 Nov 2025 12:32:29 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012046.outbound.protection.outlook.com [52.101.43.46])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a58nhux5g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Nov 2025 12:32:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cInlqrQZY7OWAYy/hjOqK43XpSLGdHC6fcaUKD5MblEWGG0QHIxp8B2pAjd6c35IlbM3l2ErbeEyisEVtvUjqd+H1Umw415+BvyMjksAFofZeiyH6j/Wn8iYMbwBV+wAe2M4WzdL3Q08qVnYWhm9avbFPRyy+Jn0VQuwfgYSzQNWv0A87AV+EiRr3TK4gnl4Neap8cg8q1jHCZnrfq2f8dNrozdgkOeTVJW/g2KgVkpOPUbeBRV2gVT9TD+tDCEwdPNjwDXbU3WVqo+AkKDpBW2+uLOwgwtOgmrVUdSoW2iPrrabUhlCFRe+Bq+hUrbPslDZ36tJXlAVt97k3fMy2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oS6cqbGj7LwBiJddYfaMT+LmpgHZcgkQu6AukRJJYtg=;
 b=DU3PnknfxqVazjbnjGaO85Ud+Tj7i52VU4xXdccHKOS0crQvSjEwxYKfcbtE6AQ6qEQ1KdzcgLU+xSKKmE/jshZD3swdsJtfdMzHqQwbXhrjMmXv7N/bQQ0e7npRiw6x17DdEx58JYW2FK3dBTT+91DdjXeGdIJN8RnsjgV8KGreyEHsYQ6ebq5k6nIRnpk0PXYBCF7lHCtmNF1XLG/KAJ82emZ7aFw40ncxqo+ANk/La08pGsnDtBWRByBqa2rlKxRa5vkqUK8kJkWL5r/XpqseDtPHMq1EaRsFQzWUmEfjN8aSLyxr0yDYSbwZ7yOPPFYPx2EgLaHw7fVFzNPOHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oS6cqbGj7LwBiJddYfaMT+LmpgHZcgkQu6AukRJJYtg=;
 b=xzSzCtTMqVoT6N1CFaOIA9E5/TmOy5oqez6+roZd9/j4MJCeXNFws+3EYdnFlrNHSXVDmiY7sKvzJ7CWPcGJMyHSZ63jijXAQ6qV6ClnUa8ipgU7G4RBAPkZN7ccWHJjrZ5+O7Yo/J1wAWSk/dy/TVwggJh/Iz6yXdaPdBKt65o=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS4PR10MB997575.namprd10.prod.outlook.com (2603:10b6:8:31e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 12:32:25 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9253.018; Mon, 3 Nov 2025
 12:32:25 +0000
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
Subject: [PATCH 06/16] fs/proc/task_mmu: refactor pagemap_pmd_range()
Date: Mon,  3 Nov 2025 12:31:47 +0000
Message-ID: <15916960ea5479fd2adcf35044fde08bc50d464f.1762171281.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1762171281.git.lorenzo.stoakes@oracle.com>
References: <cover.1762171281.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0698.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:37b::11) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS4PR10MB997575:EE_
X-MS-Office365-Filtering-Correlation-Id: 428713ec-c928-4715-77f5-08de1ad50b75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8cuWqjzFi0ddvZdgS000T9YUp0bxn34tqcn2yQadbYqEziVF2NJpSqxj0PRu?=
 =?us-ascii?Q?agwNK6qC9qjudGIWs+XxL40Iea4spGWRmOHeatd1f83a8P28TncS6+WB+QJc?=
 =?us-ascii?Q?xIpYICEB7fIxdJjDpHAsbtzFOby/2592hLFTODt9LfSunxw8uN48rTdjv/lJ?=
 =?us-ascii?Q?k+pgDoNc1WrnQC0nNC1bChmu7RGj2sICHbniYJGsDfIbAu9XFyRy2C4ZSvJQ?=
 =?us-ascii?Q?i5AC2Nf1ygGd48ZFs6N8IFFYCbINPoggxyu7cED8P8+/uuSdXBZWQ6GFbI2x?=
 =?us-ascii?Q?pzL/UB+K4a5kNrQP87uGMKTbRX9VttWXF/R1PLRg2dM1I9pWuaqG6dPE7Lla?=
 =?us-ascii?Q?zzX9RretjGIHMlWfVfpwG9xZS1eBH6HEOSKZwV3xbBym9t1N3tVIgi3kmacv?=
 =?us-ascii?Q?jLmVeWON2D76Nk+NVVSEkcSQkjdaVUZErxvTWL6cnd0t3chQq+TeZAwa69b7?=
 =?us-ascii?Q?iXcSR7nwlETVGot3/Q9ZI/QWGiZc1wLrZDrDB0AzTWvbqkyR5yH0LocrfhUI?=
 =?us-ascii?Q?QTiTAZjisnAjS/YDOiozzYXS1NkuoAgI9NrFnDChZOI4SCxmSL+xt4el0lT1?=
 =?us-ascii?Q?71p8mfEPzHf0f5UAv7sfFD/q66MNgEnoaO46rGxd0XpsSeG2cC+TNyA39RDI?=
 =?us-ascii?Q?VHqQQmP7MfXx8e4xl3Wc+8qbEIKq0QEwBxLwtGGJdqIPAgrkFgfrEacPR81b?=
 =?us-ascii?Q?4vSakzsP6Z4BIKKDi3KdmVEMf9yyI3735pxYjxI8jKHGcCE8+ZzIYEqbnAH0?=
 =?us-ascii?Q?VHDQDkxuRZiuXIATl1W6cmoBTeg7bkALyGKBUGNZgnsNREFC+OxvFAI9jskA?=
 =?us-ascii?Q?kFztrjdhfqjNm0mt/BE006APC3fcndzK0FxMalgtEiO0VagUAXO5xcErah5N?=
 =?us-ascii?Q?wQxtD2c+EC/lX02p3WKfTBryMrdAbc9J+5B8DUVguPKtQ/MwwdQpbo1rsx4F?=
 =?us-ascii?Q?XrW/d8ckU1KXqwPOI67sg3vflLyMZJeTANxqzwbppmZGs7sI9Fa77Jth58nW?=
 =?us-ascii?Q?IHvkaaTRk4z4wSnIw7f7sP55/vHJgNrEArhdLKZZ9jM2bqFf81c/uJn0amT7?=
 =?us-ascii?Q?ZbyeE9zeHg3vEtFk/FIW33Cg/jWyTdlkOb/0QukcLpIyldaOUQJTwhKsWujb?=
 =?us-ascii?Q?34gfCKRiw5SMblGWB/SJnVKymATxllYaS1IQZAAsxMYtaU394X/8Abvky8D2?=
 =?us-ascii?Q?GJNHHkNkLKYtK8oQ+whWAGfdSbiWBwgBebY3abV/0dTadnxoaiF/aKfOkk7l?=
 =?us-ascii?Q?4ZUPNu8pz5vyHPXDTWL7XBlyR8EqtjIXdAKsf+DLCqfPSpT9fPQNnWwM5zs9?=
 =?us-ascii?Q?aeGjM2vbbUtwWAMph+ezWI/x610fv3bZ2MhPrKgYelVCz+ga3qqgN9YCvKyF?=
 =?us-ascii?Q?7nkmsElzid1gKG+rSmpF3qBCODRvNYk0tOukzjX/cSfIl6Oeh4D3tn/ISpTN?=
 =?us-ascii?Q?oVCuoBIWDuNHINbkrhNUekkGwL6LBBYc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0S7yms/LaH3Q/iFnk8d7YRv9+HqyiEIS5mRioA4RrcVvOJaNFJZ2caPLSt/f?=
 =?us-ascii?Q?TsxcyMQly/DyWM/P3lVKE+pU6kUHhWsvemnzxfBLNGWD9KFb083eKYBwrBhp?=
 =?us-ascii?Q?pwrzUovTo3jwy+jcc3dN9EUBNUj/dAmN9up+isaFBcfrUhYRMgZYsduewTog?=
 =?us-ascii?Q?bT4JDINlD6oZwZzyXDe5JWIdllqL2Ai5UWjf8jw44TotljXBCUXtBprXkl9i?=
 =?us-ascii?Q?YJUzpno5qTqjWZP89dvblGJEbT4UEyO8EfKBK9QCTZakaGQnB3COp/ivVSWe?=
 =?us-ascii?Q?9Pz8b545skJQ3reYdVIYtoD3rp7pyTw3KzajnalDdvrpIrN51eS6JCiUjmsC?=
 =?us-ascii?Q?XpUb7KMGXpOqhTJLKJFgY5Mia+/K181+ci77ONPPB2HCRc3TzzZozGHLQ3hM?=
 =?us-ascii?Q?EVgrWBA2B2jeUjznCCBC7DxE/FMXwh3N/bSp5aGc/BkyOQ0yLD5pM0lU/4Sq?=
 =?us-ascii?Q?YGNaeeYaqTww/+uM26+PWDGiej1rpx5figed25V8CuMfzziKoKhiUwxPJSub?=
 =?us-ascii?Q?tEeUdIUP7l/bvlVBKJ3OQNaM2wsqFkcNqxzmtLIqTVTHHvwI9bXeVTqj68Q/?=
 =?us-ascii?Q?h27eZDXrteK2qIpG9xbnq4MARR13JYbYgsB3Cue7mojOR7WnaUyk8mHCB17e?=
 =?us-ascii?Q?VVrZTqciE7CoaYJ8nMuQK7cTHC0QfK7AoaOxDSQdjAJ3fbZM742Bh8rJfjo9?=
 =?us-ascii?Q?Q+XPvdqZYRg61gsCbbPCFH/mY3NxVeC96QTt0CAagcitoYYIUfhoiJMlED3t?=
 =?us-ascii?Q?vP54LKek8pUPPEZTgswHgM16EhYzNWq2icTKB8CmMPA6mJz7gDjW/DgCWPRc?=
 =?us-ascii?Q?2EoJAJW5mLvC6t84NURn3KSY7VFTwyblZdu23GmeHuYuV0ykTV9FrUdzaksj?=
 =?us-ascii?Q?LnME1F9AR3z4r6LvCcLu4Ezgho6xrqB1niJHgePDv43nAbaRNpH0p2a2wNZ3?=
 =?us-ascii?Q?8sRCugQ6/4GbqaqFD0PUoWPGTJUQUX8Fg0nG6mZmYFXCPS8hoKDvW+F5TXS0?=
 =?us-ascii?Q?EgzPM3QUFS07w2/vxa2FE0OcT2ihlqSo2gtUEWC8AaF4CmCEm45a+/7/UaZa?=
 =?us-ascii?Q?3oTKWBCVypCPEDftX1epZ1BTKfJfxPexs/6cygUXGQQ3vsZ+WcHpahreqbwg?=
 =?us-ascii?Q?oRupO2lGy2FrFZGbmLM1MOhdsjs/iYzmoR5cptAnKw+u8XqCbUVZ67+dPAm3?=
 =?us-ascii?Q?+g2zM0ed78OiCnHio3I+4B6SOX6rHkgpjyf7PPpsZgAqoLgYugGQZ0l0mOYP?=
 =?us-ascii?Q?w0ERhPfCCzXb8YtioADpkVTX6HlfbRdf2IVXSlg1zNrmtje0OzhIe80w1CtW?=
 =?us-ascii?Q?MT0C8a7NKQpkGMwgaZ54+fcns/QqDPQWU7SvHQhZ1oHkKsihTjt5EjjHwcSn?=
 =?us-ascii?Q?JP4JUoqEF3y3nEN4MvtI2jXfZ0IlIn+PGYwxVqQDbMkuNQWEx3rDGrgdULYn?=
 =?us-ascii?Q?ZXNeULTQDCdBsV1IQhB+V2MvR8lVnDhtyQ9WXHpW59O89sgiT7LCxaUzNLaJ?=
 =?us-ascii?Q?ZGGvbsumTKDaMjHsEl378LO4XBk5ThEXKyDIom/1LplZYu8fcCwmjI7kjXtx?=
 =?us-ascii?Q?0MNLh104FkSUCo8bMTU54OaT+/gwxVfi/1/AoYrouMIGsvAGmamqOTCkYHP7?=
 =?us-ascii?Q?NA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	u7ceobia6ss9yznVwGqYiQdfl4xdHuV1g6PvRn1aW9tgTBoLzTdeL1IzlfFSz1TBN8y9SnIxKMhsF354T0o5TX8SE885/4AV+dqpOWaIHhcv+U72isBvVrnDuf6OgAtefQ1VacLFAo9yrLyJ318oNEpUdZOn9gAqaSnR1NtMM57Jeedfl9ZYE35tc1xS9KawfN/uZ2c/F1rD1pM3NvAi5NFb7HokKXP8MTJu25cZKkkmVa6wLJh1zyDwZ+/vUJuu8SLyAWX2O1v/7Ti7471HY48gCIm6FcV+cgonCZwDCTW5dtDSngLDLW/hpW7eXfWKaG4BExk/oqSyGf6bUxNqpigNSSV6C/hwt4J52qnVofJGqneZXSVNDCuDt0u6mEPGcJrj61sP6g975iFJcSiWL3hnEP8YisF/0N6mxKWxqexJPZdtFEvjS+c2KODLEW4O/BQTvPFPZSgrcgwbCJEu0SEEwQqhV19cqa9yHau774MoAtj233it5ytjnvB8iHvzFA27kkNlnjTrVrDXfGLt6tEUOPUZ7HsQ7mFwikwBTXMOMUoTt6gjRd5FJdPrFXGQxsx6Vdh2e4xZtGpTMNXm3UXt7a72YAvHnliMoX7V3Bo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 428713ec-c928-4715-77f5-08de1ad50b75
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 12:32:25.7752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hxphoep5zRVAm2QzGaaT9zaIOYKcFKRJdpKbUo//1Qbk/W7r92vY6ctSxHoTY/yOSk92friIfihgJXPer37INGWMeK3P40vWkceAmitsZnM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR10MB997575
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_01,2025-11-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 suspectscore=0 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511030113
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDExMyBTYWx0ZWRfX8T7eM2Go+2fZ
 zhDikK+Ep5RC+xD+ZlmUr5zumecGSJrSaW7P93JXdVCeEG5me9XjyZnItb/eMKbrkFMxNX5Ok93
 daZfI2qxPHA/63DzSsOL7ytY0TAy9cTpV9z03L4vRWEtjdaGzujaImMNYS3ezfdhtArSkMEEq2q
 2UFdVgkls2pVqnEgp9iL7TTaN8eLhvhwGem2LLPTH8osCk8k8m0inVpGzbg0E1RK4i1w7v8mSxB
 D7MXvbowkVZoBWmFJJSp/sJpxO1xpuCFWnzVemav3DwW6z8aFBS6WQe0E8/PTdMvM5dcW0HJPma
 K+p4iotJ5s4n67jQjuN1oiYvv6CKv0m4yv4IB7RJ3g7JlCVOGqxQ8/E9oQiFlrvTj7pHDFStIIQ
 rKIuZxQaQfizSPG6llJSphCzknKqB8wl6HUKZ6/ULHeI0r5sTRs=
X-Proofpoint-GUID: G3nVNhYdb54WnVbgv2mpQ0pfZ9iIFoRU
X-Proofpoint-ORIG-GUID: G3nVNhYdb54WnVbgv2mpQ0pfZ9iIFoRU
X-Authority-Analysis: v=2.4 cv=P7U3RyAu c=1 sm=1 tr=0 ts=6908a0de b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=r4PJAH3pRi85-HfG15IA:9 cc=ntf awl=host:12124

Separate out THP logic so we can drop an indentation level and reduce the
amount of noise in this function.

We add pagemap_pmd_range_thp() for this purpose.

While we're here, convert the VM_BUG_ON() to a VM_WARN_ON_ONCE() at the
same time.

No functional change intended.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 fs/proc/task_mmu.c | 146 ++++++++++++++++++++++++---------------------
 1 file changed, 77 insertions(+), 69 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 9914febdb60b..bd0042851ba7 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1984,90 +1984,98 @@ static pagemap_entry_t pte_to_pagemap_entry(struct pagemapread *pm,
 	return make_pme(frame, flags);
 }
 
-static int pagemap_pmd_range(pmd_t *pmdp, unsigned long addr, unsigned long end,
-			     struct mm_walk *walk)
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+static int pagemap_pmd_range_thp(pmd_t *pmdp, unsigned long addr,
+		unsigned long end, struct vm_area_struct *vma,
+		struct pagemapread *pm)
 {
-	struct vm_area_struct *vma = walk->vma;
-	struct pagemapread *pm = walk->private;
-	spinlock_t *ptl;
-	pte_t *pte, *orig_pte;
+	unsigned int idx = (addr & ~PMD_MASK) >> PAGE_SHIFT;
+	u64 flags = 0, frame = 0;
+	pmd_t pmd = *pmdp;
+	struct page *page = NULL;
+	struct folio *folio = NULL;
 	int err = 0;
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
 
-	ptl = pmd_trans_huge_lock(pmdp, vma);
-	if (ptl) {
-		unsigned int idx = (addr & ~PMD_MASK) >> PAGE_SHIFT;
-		u64 flags = 0, frame = 0;
-		pmd_t pmd = *pmdp;
-		struct page *page = NULL;
-		struct folio *folio = NULL;
+	if (vma->vm_flags & VM_SOFTDIRTY)
+		flags |= PM_SOFT_DIRTY;
 
-		if (vma->vm_flags & VM_SOFTDIRTY)
-			flags |= PM_SOFT_DIRTY;
+	if (pmd_present(pmd)) {
+		page = pmd_page(pmd);
 
-		if (pmd_present(pmd)) {
-			page = pmd_page(pmd);
+		flags |= PM_PRESENT;
+		if (pmd_soft_dirty(pmd))
+			flags |= PM_SOFT_DIRTY;
+		if (pmd_uffd_wp(pmd))
+			flags |= PM_UFFD_WP;
+		if (pm->show_pfn)
+			frame = pmd_pfn(pmd) + idx;
+	} else if (thp_migration_supported() && is_swap_pmd(pmd)) {
+		swp_entry_t entry = pmd_to_swp_entry(pmd);
+		unsigned long offset;
 
-			flags |= PM_PRESENT;
-			if (pmd_soft_dirty(pmd))
-				flags |= PM_SOFT_DIRTY;
-			if (pmd_uffd_wp(pmd))
-				flags |= PM_UFFD_WP;
-			if (pm->show_pfn)
-				frame = pmd_pfn(pmd) + idx;
-		}
-#ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
-		else if (is_swap_pmd(pmd)) {
-			swp_entry_t entry = pmd_to_swp_entry(pmd);
-			unsigned long offset;
-
-			if (pm->show_pfn) {
-				if (is_pfn_swap_entry(entry))
-					offset = swp_offset_pfn(entry) + idx;
-				else
-					offset = swp_offset(entry) + idx;
-				frame = swp_type(entry) |
-					(offset << MAX_SWAPFILES_SHIFT);
-			}
-			flags |= PM_SWAP;
-			if (pmd_swp_soft_dirty(pmd))
-				flags |= PM_SOFT_DIRTY;
-			if (pmd_swp_uffd_wp(pmd))
-				flags |= PM_UFFD_WP;
-			VM_BUG_ON(!is_pmd_migration_entry(pmd));
-			page = pfn_swap_entry_to_page(entry);
+		if (pm->show_pfn) {
+			if (is_pfn_swap_entry(entry))
+				offset = swp_offset_pfn(entry) + idx;
+			else
+				offset = swp_offset(entry) + idx;
+			frame = swp_type(entry) |
+				(offset << MAX_SWAPFILES_SHIFT);
 		}
-#endif
+		flags |= PM_SWAP;
+		if (pmd_swp_soft_dirty(pmd))
+			flags |= PM_SOFT_DIRTY;
+		if (pmd_swp_uffd_wp(pmd))
+			flags |= PM_UFFD_WP;
+		VM_WARN_ON_ONCE(!is_pmd_migration_entry(pmd));
+		page = pfn_swap_entry_to_page(entry);
+	}
 
-		if (page) {
-			folio = page_folio(page);
-			if (!folio_test_anon(folio))
-				flags |= PM_FILE;
-		}
+	if (page) {
+		folio = page_folio(page);
+		if (!folio_test_anon(folio))
+			flags |= PM_FILE;
+	}
 
-		for (; addr != end; addr += PAGE_SIZE, idx++) {
-			u64 cur_flags = flags;
-			pagemap_entry_t pme;
+	for (; addr != end; addr += PAGE_SIZE, idx++) {
+		u64 cur_flags = flags;
+		pagemap_entry_t pme;
 
-			if (folio && (flags & PM_PRESENT) &&
-			    __folio_page_mapped_exclusively(folio, page))
-				cur_flags |= PM_MMAP_EXCLUSIVE;
+		if (folio && (flags & PM_PRESENT) &&
+		    __folio_page_mapped_exclusively(folio, page))
+			cur_flags |= PM_MMAP_EXCLUSIVE;
 
-			pme = make_pme(frame, cur_flags);
-			err = add_to_pagemap(&pme, pm);
-			if (err)
-				break;
-			if (pm->show_pfn) {
-				if (flags & PM_PRESENT)
-					frame++;
-				else if (flags & PM_SWAP)
-					frame += (1 << MAX_SWAPFILES_SHIFT);
-			}
+		pme = make_pme(frame, cur_flags);
+		err = add_to_pagemap(&pme, pm);
+		if (err)
+			break;
+		if (pm->show_pfn) {
+			if (flags & PM_PRESENT)
+				frame++;
+			else if (flags & PM_SWAP)
+				frame += (1 << MAX_SWAPFILES_SHIFT);
 		}
+	}
+	return err;
+}
+#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
+
+static int pagemap_pmd_range(pmd_t *pmdp, unsigned long addr, unsigned long end,
+			     struct mm_walk *walk)
+{
+	struct vm_area_struct *vma = walk->vma;
+	struct pagemapread *pm = walk->private;
+	spinlock_t *ptl;
+	pte_t *pte, *orig_pte;
+	int err = 0;
+
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+	ptl = pmd_trans_huge_lock(pmdp, vma);
+	if (ptl) {
+		err = pagemap_pmd_range_thp(pmdp, addr, end, vma, pm);
 		spin_unlock(ptl);
 		return err;
 	}
-#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
+#endif
 
 	/*
 	 * We can assume that @vma always points to a valid one and @end never
-- 
2.51.0


