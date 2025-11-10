Return-Path: <linux-fsdevel+bounces-67743-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BECEC48F27
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 20:17:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AADB42011B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 19:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A5033E362;
	Mon, 10 Nov 2025 19:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PFZGF3XW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KWNJLTG8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68C9334C36;
	Mon, 10 Nov 2025 19:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762801223; cv=fail; b=joKFPgSzz6fpv4zqPEss70NpKwkyJVyBbPbC54px87+rW1ZhecWjJQX0+ZQvKyLLz+ANVnBHxBT9P4fTJbeXqKJU8utl4/QEO1oSbab7R7J/g0qwplLLEUR9sxxBLyx1gS/fJI3m0d0/yHQhQMBF8D3UbQxyGZyCSCjbe+RQdPw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762801223; c=relaxed/simple;
	bh=qB7QUOqL0ofackarX2pqhNlzEbfg5j/0zk5KYLdUwPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oXEyF/C1d9VKs0oxIrAuDO3EnRYLhmEs/cBVXZTu6Oy3oYlVWSM3hgkY+4v89B91QcrHYZShofbPbr759JxYs7Mh3AXxnm0x98ATy/RMY64sR4bOhWr+xzALeYwMZYSDZ7pZubEJIdlJLe7P51eUt/4g5fDlZziUlaDXmUjeqZs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PFZGF3XW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KWNJLTG8; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AAIsvCJ021328;
	Mon, 10 Nov 2025 18:59:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=YtSyi/jCkakCJufFjR
	sp1BYUO6E2UXa1G7s4LcO10No=; b=PFZGF3XWuwBcMPk2J7svYV+yv+0EGDeHRa
	hcq2DAS8cFEIOqQQXAbAYkfTldu5cKXFJ+wZSsWbt4dXmrJeFHPW3u3vHZRJsAQ9
	TqwiK0ATxePb9Vixozryta3U30iFfnMgGWQ9h9yt8+h24bq6DPqasRT2QNp2vG4L
	tetv0hD84Z7cJfIaNdEUBipy1BcE/vLYkiQjIMyL75VtmQfoeaYm3jigqGicf+Un
	K4Opg2UvR1Ue3eXleRfa1G/Z0s/gVocB6GL52KwHPQLAY84MXS4xYHeO8yq4GIYr
	kRuQF41+JdVeMZo8TOYbLLMvi1Eq8T+1fk8H2KS7SS+HmOAapU0Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4abm9ng636-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Nov 2025 18:59:17 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AAHSPX0000922;
	Mon, 10 Nov 2025 18:48:59 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010037.outbound.protection.outlook.com [52.101.193.37])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vachwba-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Nov 2025 18:48:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rl99VBHSEe/NVHKRo2nAiBBm7L7j7fu3ApuTvDva0tbhZfnary+sdvVL70eIDmcf/RWzNnzMR4G+e4ucaylriJi1/X1A8EGWPXepu28ifIqvUb6/XYd4fw31K9EQfH1HY4MEvfNN+lgb8pdwFBBaesEBTOwzzMbT4Vr4CmAYK1DIZjg/sKUK/tEwXMrhBqhoBXtxPYInjAs7eotrQba4pXXD9WWSSvcsRktZLR6+cDVSroZWyf5liUpw+HXlCovUf38W5iFuWKTZci2ZoymBfswRJNwqZ/dn4MDZIV/+3ZyE3NqNqnK/WLKNKFS/udoblM3IYiey/0/HX8fqutZZag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YtSyi/jCkakCJufFjRsp1BYUO6E2UXa1G7s4LcO10No=;
 b=UYXBFCIpXHhzc68968ZUpUeoMcjkqvxMszme56JL39S6N0CmyFT66z7Ll/pC5IX2Qje/wHLZXgkdcajcvpuf2RhXQlPEVBgUNE0ptmbuU4ueToLnsBXnj+/vEFgeoyyvX02raXITSR34CBH1iZ2mVbPUiQzh2vOJoTQQ6qeFn8X8XFFXMlPSS9g1nm4x9jtgg3/TpEcKjYy8O0SWd+6MTXAbcQtHLxjW7GTLMn4L5xQhvsNIN65wwS6yz44f69n6CQLSd8WkFF7oyNsMypWDoCPYTBVfQ1v0B2lmJyU5NlJIUM32me9qdUvyHw725fo4JI3XwsDVSPa9/MDDiBLU7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YtSyi/jCkakCJufFjRsp1BYUO6E2UXa1G7s4LcO10No=;
 b=KWNJLTG8Q0xwcNeMNJ5/QZQY8YAbZet1ZPwfeqN6R5F9fgjJW62e+pYvXk3Kkg/i7uIjhFN7Ex3HmjKq+9VmhpMMBV4bpubkhSaquNODgj+g0rXYNfcCa3/6/jtBf6eZoWgDSY1X0qCkEivDTS6U/u3y4k0b9l0mpRs/jTvrLC8=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by IA3PR10MB8661.namprd10.prod.outlook.com (2603:10b6:208:581::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 18:48:50 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9298.010; Mon, 10 Nov 2025
 18:48:50 +0000
Date: Mon, 10 Nov 2025 18:48:48 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Lance Yang <lance.yang@linux.dev>
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
        Muchun Song <muchun.song@linux.dev>,
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
        linux-arch@vger.kernel.org, damon@lists.linux.dev,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 02/16] mm: introduce leaf entry type and use to
 simplify leaf entry logic
Message-ID: <69b95aab-de0f-4208-8c59-3cc1ceb4135e@lucifer.local>
References: <cover.1762621567.git.lorenzo.stoakes@oracle.com>
 <cd103d9bdc8c0dbb63a0361599b02081520191b4.1762621568.git.lorenzo.stoakes@oracle.com>
 <1d9acad5-c78d-46b6-91da-fde5acb7cb16@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d9acad5-c78d-46b6-91da-fde5acb7cb16@linux.dev>
X-ClientProxiedBy: LO2P265CA0204.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9e::24) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|IA3PR10MB8661:EE_
X-MS-Office365-Filtering-Correlation-Id: 064c4d87-290f-4887-2340-08de2089c9b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?puhKnYMXOgzFHqeyFtn2Zr/9msWnrbQxWaRZvmjdquKZywsorY95Ob8m0zok?=
 =?us-ascii?Q?U50ENGD09tVULJNXJZV8vYK2W8pokSCh+nN95/X2oHD+lX6lNp3Ta0EdFyAi?=
 =?us-ascii?Q?iPr9Y5yeEeu2QOeodODcs7+pbjeAkOwre2r4hXQjA8vrGrpJlAkISiXJaWAD?=
 =?us-ascii?Q?GmXMcbUGSQ+3at3BPWWLMCLFSmz+axn8c/KfCz7cUOcUwpntD/TgU/WJufyY?=
 =?us-ascii?Q?wkLsaDK4K6+hIVluAXMptWqwUsx9jqUaYH67soLSftfqzv0RAsLovwI7hazy?=
 =?us-ascii?Q?sRGNbMhq6hEOT1AXc2aZluzmUwr+DA3M67BA4Y1xnYqXmNJrWmPfahVCnctF?=
 =?us-ascii?Q?T4u63YAGWz+x6fwQSlS6LZKP55wr9rLleNJO/1L3MDQ992TGIGeUkgFrQF+b?=
 =?us-ascii?Q?4bVdZvtWZs2K3H9a9Ls/3LNCUkL0PbPRpiRtuvbm/UU91uLcWmcDy1B+jCQ9?=
 =?us-ascii?Q?SDDrCfPrAc+BNlkU6ckMxikPz9zAv6222+g/TQDxgXS81jmWCFQk6h//43Ux?=
 =?us-ascii?Q?2jQ+wqEsudfxcasYVZyMTLdUb1Gevflxr3Xk8uO/U10IwWg2AWFoEHYtTRjg?=
 =?us-ascii?Q?lKxXZg1jYvk4iAEA26heXSaD/WYN7uqS3OijVgUWhchjQs9YNs3nPo18HdQ6?=
 =?us-ascii?Q?oX3WI7IYO0QkANCOFLp5bxoXDmlPZPqorX9GkWoORXBz9tWoh4rfs5U1DO0Y?=
 =?us-ascii?Q?UTWC+bdGi3PgX2K0P4GWwH9fHuKbUNV9uQIVcCraKk541Wqk+SQ48mTD0UTX?=
 =?us-ascii?Q?gk43lvDbfehShnLFbXQlNtJkahkNf5DIRn7joS/mDMeac+VC0mnmHMk9xbmY?=
 =?us-ascii?Q?vzTqP2NAwlP55z+lnBI+0qyQiGpoZwPcmzzStig8jfCVMe9UB8YBZAsbR4WK?=
 =?us-ascii?Q?0EU7noqcq1JpuDoojVYJR/7XYG2bb6uEGCzdwt0+0Sma/jxEqSMAtEyQ2H9z?=
 =?us-ascii?Q?nYxaxJWDAvD6ksAHJGB3ywPPoCXEyYAygAtUDxTzEHTUekQ1oMMs9oNWeWnY?=
 =?us-ascii?Q?D59EE24PHGyuuPvg5PxHJG6iFnul4znpAPpSkIIpm6AuySdfS6cKsl1okFxJ?=
 =?us-ascii?Q?hUBy496LYUO9U86KLoR95uy5MqoXc5LUtazY8LelgLMr12UDdttzNPS49VtQ?=
 =?us-ascii?Q?safjlFzmw0GVbJzPpWPqNOUBeMBdsmCfo22MM1ukqOg6J6OIHLedE1WQpgab?=
 =?us-ascii?Q?5a+JbhknRnCeEftBmhmyCkH62rJ76whUZPRTuIMJQbYERSr+eQ2p3o3qwMHs?=
 =?us-ascii?Q?u86aW2ZxHNfJqozj2VhDutX/4HP6lFnQpGTtIy1rL7DubdzhKFi452FAoG1W?=
 =?us-ascii?Q?rHHc/+BDGsgBxxQEBbdC6wdrKykS60fT1ntDsGIFrndCYs6yNJtVz2+v6HoB?=
 =?us-ascii?Q?EiOuBN4Fl9ZCV6Kn+jtUkwCzx1BC0e6DwMD5s4bnS1b7+oBj7hV3kz3CpSPi?=
 =?us-ascii?Q?BjdxynD0zhq5LfbLvGnzbaO9acWSZjHW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vdBdAvZyQRHQq6zOkR4BWITWiGwJAc+JCAxnG1SQIUT/sEDrT5Kulc2MiRYO?=
 =?us-ascii?Q?EejGNo++khB9Dlno6EYR2XNJmxRUyXNrWuHa3pOhvhX5VpdTMG1HkYTlwCup?=
 =?us-ascii?Q?WJ5/B193KQenDQhFozRgMP1B6xcIG6rclHmPfPC/O+mcefmieI7vYzu5HIm7?=
 =?us-ascii?Q?Oy6RwGP3D5Yo3QdU7YtmjTv2gQ3V76c9vjFfD8OtEGRti/B6jJKQB5Dwgj3X?=
 =?us-ascii?Q?1gYXucqRV7oG9JDG72dAruYJxa4KBy/fNPOcYd8e39mB5DBx6ZYxZpzZt+8e?=
 =?us-ascii?Q?owpJNC2LsjRnOhAq9399vPl9/yKRTax+eMMpHHOQBOsquGUrtNj5TRwrn1XO?=
 =?us-ascii?Q?J0aSkSMMAMVAuHoH8zNXmSJyBvCZB4LCrxYhGyZ917tDSNrCSmYIUiNCJiZT?=
 =?us-ascii?Q?mzhSJwbwR9kZ7MXkat8DJwuxm5WK0S4Df8+DpDx1OL77E4Va8tPjXefibSc3?=
 =?us-ascii?Q?1maCS29uKhwuY8mEp81jOUOx03KXVAzyc08+Y6Fvgud6Q+A4mF9gw8NLRdbf?=
 =?us-ascii?Q?eHW0mVBS56iXJ0juQ39GFeahTVAp7Koqx017ymSYD7WdoHR0e5Nx1Oon8/ec?=
 =?us-ascii?Q?gMfFOO1pP8MkrQ4Z2IN9z7S6XykGGArbz3uptD3iOrUWRvfF1IwOZT3Cm0AU?=
 =?us-ascii?Q?5XXSAQiJbwwqVSZozhwE7FtMiNlz3HPb2zGIqR35AN/nFajRdij2phDCSM1A?=
 =?us-ascii?Q?cG5Y4SO1gZXsh+UTHSfOgU/EwZDtsZGE2JFnaneiT2cQ0bMZZ+ZM4dkl+9Vl?=
 =?us-ascii?Q?x7lzLbkAtF4VdQ9ChbhpqOrhA+VCwyH9QaKzrXTaXryIvWXxk3IxE1eW9+iJ?=
 =?us-ascii?Q?oLY1iQCdwVp0VSwlAvV+sc8xjt2mma3AcOaj+PFOFIzWuVNeaT9hwqNgub+S?=
 =?us-ascii?Q?2/PIe4O714sYFFPf58T7fgcRMM4aOmiD3aO+VN26UxAvh06B8hnjOC8hrUXu?=
 =?us-ascii?Q?XnO3UQaeYVzurbPJJkikEMroF9Rta/No+aGXQ2nVHIeJHAfGL5m8KfqMCFbu?=
 =?us-ascii?Q?EeKZerxs8QYaxZF9We4wEx2oHZS1dKQBGsGHdGGYdHxtTs/ja0BTt56bMWM4?=
 =?us-ascii?Q?P1eeadL3v1Q4qWSL98apbhqDRCcfj8GJUijRkMINC0DnV36eHoVW3mUfV1QG?=
 =?us-ascii?Q?DCOGgXh4Gz6BNDXVeE1oOjgu4fketqikT/KxFiL9ejJmFvOpQZloXU2puE9J?=
 =?us-ascii?Q?dwrwAZtNmkb7JsP6cif7if+SULlIQSk0TMwpD0bDmJ5TciXyUqLlulqO3bHz?=
 =?us-ascii?Q?liJdt5ATAKLp92zp+HRWNP9IMr+FxpIjm5s12BT7gNKH0Kb+OZlGKg3ig8cJ?=
 =?us-ascii?Q?fuGHbmcoJ+NEEO1dQgbQbXro8jUqQLLa2R5Hgw51a3A8EKNTsUtSVUUZ/xrr?=
 =?us-ascii?Q?t4CAkV3UfkDy30G5cfpx74jORpHxN/6y7QLJTVm90A51O5Yr88iqspX0/QTN?=
 =?us-ascii?Q?b6SXnh/d8wGg4EQ0BZ7464xxiSdn7mVEgJgsp3ltblpRtGGJ0wjbnpHP7CH5?=
 =?us-ascii?Q?jTPUJ2o6mxUUmKGgU+FYyddQkqgyC9MyjEENgSmnBonb0fcPOaGXAkd0sPoL?=
 =?us-ascii?Q?jWDR/z0IFySJggylB5P2Vm/+vdDfvU/sdHUKDmCXELTxMK2nm2EPT3nlitbd?=
 =?us-ascii?Q?hg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	n1Ba4dtYTnYiCFSejCGbkNdq91T+Fg7FMQF6/i8KgkZcEOEFeiisLYlm/TchaySryjbsDcmeW61GCPVsQBYTWCSovLijhtw9ky6KTIsdfVSpukg2BNZeCinj9vbUIsfwRUi2jAS5Cor6Md5jOVDD9MK7+z1fbkj5MNCrdF9a/KhoM5f/bwzCoSA33isVW5zGiDKSQBEmSTh7UKJMwsnQAzGnlwqJOhEyrAGC6f0dQ9Jx9m0cpTguiWcWfTCC90mYLQjqg5/1UCGd0x5SZxDXSMlKIfwm27tMDc+C0XxBXUBCSJyc0btC1AvSVYBK3Jp+o1SB8saS98hsCd4K6efv+BS4cUDqgEYv5RkuS5lN7RHXLgm4kOeAsJsohdmx635IZFpc+FhfEuU2VSfhNWR9+75BvElbS6c+UVkqdYOqH96QM9QrX3z/djvoHxACAjXJWE6Y9H7OO9zVFgnO+HpZa2YNEYlh9Va85DnbZW8ISk3Qrr0jOqoFQ51jlSCWRfaWJ3Td5u5ZCDfMgcBKqb4Z6J/8GuPov2o/vVTr7975fm+coQSviguio8xjZUjcR0Zs/tNyzHgHoyYD6vv38S9peioZBuGP2JH7Sfv/Yzl7a6E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 064c4d87-290f-4887-2340-08de2089c9b4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 18:48:50.0513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LRAoCeMK7lxxd+NqE3YBhcgCVqk70F8rrtX+nQW7VcN7bfnn1ZBT0rURCi/0AF8m++yDVAynpGKX4vtCoIf7CowRPw0t8NiNjnW12VLRIeY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8661
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_07,2025-11-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=965 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511100160
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDE0NiBTYWx0ZWRfX3GzYV4l+aUtq
 SN6gq8ucg9w7WXjkfSTiGSjN04BAJ0k2FGeRbWpCqHreOpJTiGJ1u+MXUmvnUvJ9KVXDWg5SDFY
 opHtGaq0zdy7u6RUGOqo2e8gaB1rv1f0R20lM0Gnpt/4aFywsenwcTPyFenDsI3O1tHexyHiMXw
 5ENiibTTG9khGSCBThKeyQZmQzOpMhPrfyQtk/YXdzfEu0+b34xN4Ww1o4DM7yOY87icRfZIlTK
 sp9pucpPhhxD3vZZP76Uh6XMHVrcnyWscdurzGSGNx+2C9rRH8SEBOIdUzpeWvWmvP3WZO95B6z
 OUzlS/QPAlDrn7gKxaF7d+2yc+eDmc9cUKA9CYqwrTInANyp1M84AGWj4d4RWXE1DpeGnNFn4NZ
 wbES+UtmobmVJu3d704UaA4LpTmWWZgPGUqc5QLEVdMe79196GE=
X-Authority-Analysis: v=2.4 cv=LIJrgZW9 c=1 sm=1 tr=0 ts=69123605 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0doqIRERZFkoVV_cxD8A:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13634
X-Proofpoint-ORIG-GUID: 0SpC5m-b5l6jxKmm1KmKvDpUBz_UhVh3
X-Proofpoint-GUID: 0SpC5m-b5l6jxKmm1KmKvDpUBz_UhVh3

On Sun, Nov 09, 2025 at 08:34:09PM +0800, Lance Yang wrote:
>
>
> On 2025/11/9 01:08, Lorenzo Stoakes wrote:
> > The kernel maintains leaf page table entries which contain either:
> >
> > - Nothing ('none' entries)
> > - Present entries (that is stuff the hardware can navigate without fault)
> > - Everything else that will cause a fault which the kernel handles
> >
> > In the 'everything else' group we include swap entries, but we also include
> > a number of other things such as migration entries, device private entries
> > and marker entries.
> >
> > Unfortunately this 'everything else' group expresses everything through
> > a swp_entry_t type, and these entries are referred to swap entries even
> > though they may well not contain a... swap entry.
> >
> > This is compounded by the rather mind-boggling concept of a non-swap swap
> > entry (checked via non_swap_entry()) and the means by which we twist and
> > turn to satisfy this.
> >
> > This patch lays the foundation for reducing this confusion.
> >
> > We refer to 'everything else' as a 'software-define leaf entry' or
> > 'softleaf'. for short And in fact we scoop up the 'none' entries into this
> > concept also so we are left with:
> >
> > - Present entries.
> > - Softleaf entries (which may be empty).
> >
> > This allows for radical simplification across the board - one can simply
> > convert any leaf page table entry to a leaf entry via softleaf_from_pte().
> >
> > If the entry is present, we return an empty leaf entry, so it is assumed
> > the caller is aware that they must differentiate between the two categories
> > of page table entries, checking for the former via pte_present().
> >
> > As a result, we can eliminate a number of places where we would otherwise
> > need to use predicates to see if we can proceed with leaf page table entry
> > conversion and instead just go ahead and do it unconditionally.
> >
> > We do so where we can, adjusting surrounding logic as necessary to
> > integrate the new softleaf_t logic as far as seems reasonable at this
> > stage.
> >
> > We typedef swp_entry_t to softleaf_t for the time being until the
> > conversion can be complete, meaning everything remains compatible
> > regardless of which type is used. We will eventually remove swp_entry_t
> > when the conversion is complete.
>
> Cool! The softleaf abstraction is way easier and clearer for me to follow ;)
>
> Just a couple of nits below.

Thanks!

Hm I only saw one :P

> > --- /dev/null
> > +++ b/include/linux/leafops.h
> > @@ -0,0 +1,382 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Describes operations that can be performed on software-defined page table
> > + * leaf entries. These are abstracted from the hardware page table entries
> > + * themselves by the softleaf_t type, see mm_types.h.
> > + */
> > +#ifndef _LINUX_LEAFOPS_H
> > +#define _LINUX_LEAFOPS_H

[snip]

> > +#endif  /* CONFIG_MMU */
> > +#endif  /* _LINUX_SWAPOPS_H */
>
> Small copy-paste error? Should be _LINUX_LEAFOPS_H.
>
> Thanks,
> Lance

Oops, copy/pasta error here :) will fix.

