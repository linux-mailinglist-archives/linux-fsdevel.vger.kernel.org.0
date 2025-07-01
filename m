Return-Path: <linux-fsdevel+bounces-53516-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8CFFAEFA4B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 15:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6BA31C04DBF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 13:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84DF027817F;
	Tue,  1 Jul 2025 13:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="n5oOW4i+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RCy+f0jg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89208275874;
	Tue,  1 Jul 2025 13:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751376065; cv=fail; b=UCJlrNVXsTaVaHUGZzg2asxtz8Gfb1NbLl4HAB1LIWt/e8d1Ym2U8HYsUnHR/VyVUY+PH4dGNmw4q0JYIP6PdjE2FJG+U/yp9duESMnFsl+ObYEU2Pmx+G2BvlQhWjqDb/+Z46P3c6isXwYczoH6HInqPfQeUygwYgN2eTme+t4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751376065; c=relaxed/simple;
	bh=eP5NyZQqJoXsHrWMute3x/X3hPgguF7RGleFC0tEmss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LYI6P4hcPWSJujxYRtFRphj5ecWe/MXF95ksrBvM+1FVvP0LRjHcE0eD9NWpnteEqbZq4PQhZLA+wduTjDKwz7/zbc+oJJsSf6AtGno1pSWoDjXeDUJLX2IrjReBYMMGWHbxxpQrI6pK/m++jVxx3e+AfJGOmcLSfnVyzOHFxYs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=n5oOW4i+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RCy+f0jg; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 561D9CAx028037;
	Tue, 1 Jul 2025 13:18:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=3jpjQPVi8sDgMPp+/n
	Js9BM0Ph0TH3nvq2B0/gUcEuE=; b=n5oOW4i+DVhXC4yVe4ET2v/oSCxa2TsjYP
	H3/oFA9B9GfVGMy0KpMSptqcotf1Za1fKWOyzQOe4ESl/a7+qvWCbwYWSzkPmuIv
	pKrxD/7GXUscmmAhfpYAeVh3yC6RO7qnMAn9oLNnDN/LRGTT6qZhLxm1KT2R7lDZ
	S17jWA6P7o6V4OzlwseSsZput3nYB1KPKKQwA54zBdOblLPhp41+Z3wjKm0f1LeV
	Py78+I/IlpS1C++mrF2DZ5OalnyjJYiuNnvDDTD69Hze/tVMFjBLmFAY26W8xM7Q
	aJwosgADjIOmdm1KCQj5/gkMWHD2A4yDiAF7z191e315JnKtCErw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j766crxt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Jul 2025 13:18:26 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 561BZZMj011683;
	Tue, 1 Jul 2025 13:18:25 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010046.outbound.protection.outlook.com [52.101.61.46])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47j6u9gqdb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Jul 2025 13:18:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ge0DSc1uJ3Wyccqcd2Jy5NkuD7lyOEHk0lIpprTKRNc0x4TUsTdSWXvMTNFPiDuvWiInjkwsKMQrDHY8L9beGMmH0uGv+59uKxFojjbf+1McByk6rFM/X4Krh7U9sWNH8c9a2UYT1/39PYSg3kwPFP7yv+AekJxmSBA5dUw5k+LF2fRPD1Z2Kh4lVOCHaJvx/6oasd2v4JXj/FC0nQoo68iw+cY+Fe+Y51sllL2JkEg+Y2xL+YH1wNe9GtmIzIXXbQQdGj4ODu7il/Uu04pze4J38eyhSS8s6PHeIGPad3Q9dio9euQFf5yUlaLnjRKvJ6xhZ841nS6DT2fexfgSBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3jpjQPVi8sDgMPp+/nJs9BM0Ph0TH3nvq2B0/gUcEuE=;
 b=JHSfJAh6O9tcgSjBhLTLpUT0hqTC3JNcYJSZd17rabxUA1QZc4njM6fZmH7UIacmMIsmuGGFAlYPGtTHG1eV0bGGDhm0RI8UDK9vW+qjO/kuKGJ8l1m/bFrTsc5tNmtjfjiEi3gfEpnG0Vj0ct/Yqi5AZ8c5SWO2OfsXttKfsr9LrsGmETXOtbQjcWBr2Zd7vPYuGpQ+NRC4gDPcXacXyX+bjQ9fBzHMRurtRW5awlTJZgh1oiLewo9LqEAnnFNwCTKOELBaIGXw1IqWN6MMKMNmwqBBF5h2I/5N3WVoVWHICHj0o7nQZ/2/Cw0PqU6Er3zdLLNVAP+nROKNo6cq+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3jpjQPVi8sDgMPp+/nJs9BM0Ph0TH3nvq2B0/gUcEuE=;
 b=RCy+f0jgvsbDI6Z6wjWYjd1Y45WDn1MkJlDckjFM4P8lprQKybPgG/id+G4eCzfxWHVJcC8Nke9fERU6x3uOJGKQ2VyhZGZ1n1v6ZCJPW1tSXc+WnPXW/2NwwpkMNOTBc+kJzSU/rXe7OytAk8IITFdfNve6lNd4a+2VSNlJ+mY=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH0PR10MB4503.namprd10.prod.outlook.com (2603:10b6:510:3a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.19; Tue, 1 Jul
 2025 13:17:59 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8880.027; Tue, 1 Jul 2025
 13:17:59 +0000
Date: Tue, 1 Jul 2025 14:17:57 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        virtualization@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Jerrin Shaji George <jerrin.shaji-george@broadcom.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>,
        Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
        Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
        Ying Huang <ying.huang@linux.alibaba.com>,
        Alistair Popple <apopple@nvidia.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Brendan Jackman <jackmanb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>,
        Xu Xin <xu.xin16@zte.com.cn>,
        Chengming Zhou <chengming.zhou@linux.dev>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Naoya Horiguchi <nao.horiguchi@gmail.com>,
        Oscar Salvador <osalvador@suse.de>, Rik van Riel <riel@surriel.com>,
        Harry Yoo <harry.yoo@oracle.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Shakeel Butt <shakeel.butt@linux.dev>
Subject: Re: [PATCH v1 26/29] mm: rename PAGE_MAPPING_* to FOLIO_MAPPING_*
Message-ID: <97d60461-9f7e-4bb3-aa4f-deb983cd3be0@lucifer.local>
References: <20250630130011.330477-1-david@redhat.com>
 <20250630130011.330477-27-david@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630130011.330477-27-david@redhat.com>
X-ClientProxiedBy: LO2P265CA0304.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a5::28) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH0PR10MB4503:EE_
X-MS-Office365-Filtering-Correlation-Id: 143631db-6c1b-4176-fc80-08ddb8a1b336
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+zpU0McbZeYPBzSOxzDREHppp8NhFoOG36O+01hCle+JqmQyu97EFc45IT4o?=
 =?us-ascii?Q?y0nEJ+yO8EC1HiMrIlBwVYZvgSwY/3Cas4pUYq8k/UJFxBFJy97RZRlgqDu9?=
 =?us-ascii?Q?L5cFIV8moVshMLihWjUNQQpuKo5Wzo6WR8jsqBw4Hv+4Lbl1zlHmE8wz4ptJ?=
 =?us-ascii?Q?WoSpHhjdxecGNU3m8BlXrOebLyctgcxRnVmeaSOMAlkkwryNRvqhUUwizRTz?=
 =?us-ascii?Q?wDeYRHW7Fhcv0gNKTH13DbtQnvQbWl9IyvTVQ+ez8TGC583raxAkJJGgdHal?=
 =?us-ascii?Q?nW2LHwbeJs4MAQDFaxoZoORMAwovvvvyq+2k6iTIBG13Z8wIFed/oMGeRIJb?=
 =?us-ascii?Q?C85gpqC/P4AZBjPJePtEk6SarhjVpI1MFQipszMnQR8ylkfI8uHeHoY6ioXM?=
 =?us-ascii?Q?p3pXWzhZRMeEXc8Y2zzwSGi4wfN0xem6OYtVVb0TCM0dPDLS4YqArneFB4+5?=
 =?us-ascii?Q?RlhQddmG5J/afib8gaAeQlmEj6IkyfwMnPzHdCJZMvJesGmQ0G7zl5RRB4QU?=
 =?us-ascii?Q?Wt2BTMvIbZSbcJygjih/3iwbIdgll4E4feCUlTTXyxYDNrUBCZs7A8PQL4y3?=
 =?us-ascii?Q?T/LI2w2ORh2HsOceKTb+zdFz2VJTLoNYL4CF9aeoXrHRYsZ+cVWybdnCw4oD?=
 =?us-ascii?Q?r+GH2rKyHhek1dmxB0e5CLY5ppUuAE7jTtXHhfbN7zyZSEWg3Nky6BJKp1MF?=
 =?us-ascii?Q?r0K6VxGBEoP8FCTOEufr28/tTOzIbHVVfH3NKTeNvvQ3fFu5juOksw4WOOna?=
 =?us-ascii?Q?xMUAeirjx8jofisbrvKDvByjP0BD5E4LbhvU7hMa2ikCFQ8/aDYJy0+LRkkd?=
 =?us-ascii?Q?/xTrP5qhGdECDXEmGkvvp0viEU0zIIJ41d7TYvKPV+mXvhRCY6ciW4ThYVed?=
 =?us-ascii?Q?Xy+flVvcfw8PKNQVHkIL5570LNiwe5PTeSPkk9DmslYO00LBhZLIfuR1amNO?=
 =?us-ascii?Q?lCRfZqnywS285f3rG+Am61n1gXooNmlhNGymEAPt6GCVRKW4EkHlmdXqaZoy?=
 =?us-ascii?Q?kab4+U4DujyR78GaszLcic6Icevj3vpDA5IVl6h5mJaFuj+P9NG5wudFug0J?=
 =?us-ascii?Q?7ec/aAEKLqcY5PgcntlEOh+AaIU8sJsOpVzzEKkvsNTg5sQA3obLFY4yOhFG?=
 =?us-ascii?Q?PzMvXmXod3ohyNqzoHRDL4rUmi2gYJIRr1T5Q4Dzqc6k99a68JrC+62xFXeN?=
 =?us-ascii?Q?gCyzjdhH1/Y4fMBAVLPDg0uauarxqEpk5E6fV8bgr0gUYXqenMxlhuvQSIqq?=
 =?us-ascii?Q?rEhCAttMmsxXZaWPJHgIDWr0kOWijy1w7jnQt39QRjTetPo1zee8M3BGkeHC?=
 =?us-ascii?Q?bwFNkyowr/eIQpmRW9qF1OycaljtPKjvhWjucaEnBt1FTN7/cQj20qGEThsZ?=
 =?us-ascii?Q?GAhUttQjToIsswgo9+dOIqRvnk5AbUARF8pHeVb3Q9TCBMyS/Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JtigytWEV0oO3xMb/2cRyCv6Po2ITSO+wKAMRSdfOGLYYjgW2LwazRABnyoF?=
 =?us-ascii?Q?cR8Aqt4hIC+GrPQNN96jJj3T3IrMwf08zJpNWFhUyXs0oWAa0Mc9cJOg5L4g?=
 =?us-ascii?Q?M4XrqQIP+K/qg5dt+vRZUpoYHG1uC593XbsSwIv7BJmun6+1l2vCqz9i92Xv?=
 =?us-ascii?Q?pGBqMHmaMhNu26BuMBzJjMuS4+kSVek/4cwAQ6VW3iQXDZ1xSDjmi24TmhBq?=
 =?us-ascii?Q?nxfdo9PoSYFeZW0upti+cWrwdw/kr7Wnw71eT6KXfiR/yN6hG2R0pHafwQo+?=
 =?us-ascii?Q?xxEpzLs5hSrIlUhJSLMMUePjMc33vqV5siI+n74iZhQo464mTDBH0PVnGjTN?=
 =?us-ascii?Q?zuqGG/YDNTvxYL9HHb5o5fk40CrGz74QB6XiBsUfAOdzKrWeJOMsjdPlk7P+?=
 =?us-ascii?Q?GwreJ0L2sE+YLaHYsJdMXwomUhjwIoSx3pIeuOkuw/0l99IlUy75/EEq1NC8?=
 =?us-ascii?Q?gvtV6t34qVIdYtT2cz3NT8vADIzeTXDAAia54HV4gve4zgHD1s5DAXN2ZbtG?=
 =?us-ascii?Q?LEMWLc4D6LaS1YDCp2eO9ZnYH/CVJrPnkBKYj5iaKsX6ukonJz1SHYsOrUUp?=
 =?us-ascii?Q?5zQTbSru+KimbSkQL8f8SxrSRpjywlcnYYtV+BHVu3X7suySju58zCe0YhGQ?=
 =?us-ascii?Q?DGPNpHLhkvCf9i/OfyfaR7ji79S2efAyEBABrRKBc4JWA0AkR7pAgSj/7bbA?=
 =?us-ascii?Q?zLDuGQ+o4Q8zmxULZkz8HBhDZPHUM82iAf+XrkqlZI9GOZtaAEOrA4YuhqHr?=
 =?us-ascii?Q?dFzsHb6emSYTGYASYrifwFK+Q0U+tPGYUpCTwiJswhIYUHsgxlmLK68CQ2y0?=
 =?us-ascii?Q?imlPEhbdD8zSki7/Ctq5DOJVwhCYpBQR3LPY7D2Z14i5yPwGIUnV5ucO5tPZ?=
 =?us-ascii?Q?xLbesl+AvdIcsEYQunifsJWTZrVCaZMXtMsMZQFRLaJvRDnbnU58BoSwry6F?=
 =?us-ascii?Q?rIi9b3kks+C7ZXDH5VN08o8LtxGkEkj5A5Q+ALJ/ow5sxtU15XLTYMmuPHjm?=
 =?us-ascii?Q?ltHfVnSp6fhUbSH0TeA0lQnLprcigrhumKk4Xuy9WUn4e2IWx3iyKsH3KnV1?=
 =?us-ascii?Q?CoGeTuuqpiIvQuoChYf2QlbffFCbW4dvd9bqrRTwihSHkFYC0oknyKkjHAKR?=
 =?us-ascii?Q?N/GCcLrIfgILCwhs3V1c/kTn+YFUaHDmrcDAebSS1pNfu1DH6HbxfxWs++dg?=
 =?us-ascii?Q?dlAF5DsGgLzzUIq+8Fz3XO/gq0uQ0J/4faRams1WlTtKSmt1hiDKwSA3MtOl?=
 =?us-ascii?Q?/DNZlRYTJFtVryRhnwurx0X+K/VGhQKSOWxJ6IBFzPLpEB0wgeUBGDAZ2kOq?=
 =?us-ascii?Q?ELo9/PSUMrCq2Bh1czKlg6I2WCsHRfc8dtx6Y61u/P9ueyt0wJ8l/67Su++o?=
 =?us-ascii?Q?UDV48A05YETPdSE8b+yvI7/SYfYGLSKSTA8iF+L9eY78nw5iobzIaOh8AISN?=
 =?us-ascii?Q?izwIhmYMb298fI6U7q+TDUtJgLjm34RM468ZVoENOoVvz28MwO9b0KZKXMpc?=
 =?us-ascii?Q?jJoYHS3M1Lgq75DSLF3ZWVYlXLGQBTJ4gACDj7o0j+V6nQSx+fxq1gIPvfBV?=
 =?us-ascii?Q?h9qLNQRHNv+XIa3jDUCsn53aobijpiuooCUj+W3OHZzBEuOyazM7ZORYSkY3?=
 =?us-ascii?Q?FQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zeSqwK8uzuffz9l98tVGV9u3LYDEK0GBkhyzMtX4TnlXLPwAV+sRFsjd08IOnX9eG7PhrRQlDVBGNyUTfnydrsslef/Icu7W1wK3b97E+RQw1Oh3N1k1prEpC1KUbWSls7O3RqOr7GH7PQZK/Sur7nhTpY/UYg1K1S0nxJURY2DMa9k+UbUhH//upI944RVHEF/PN8RVit1a0LMQkzaHSk4TdsRIgE/w/dKnMa6qZ17eRSmV1kmZcb7LHARdGWvvM9YBjCLKqQI3hxG6g6DTh6v/R/zdIKnKr0xm10Bf+4eWKSqSXBOlC+tE0CaobSBn8floB1XqZp0jUqtC3Q+pF93P6JQfNSgOJHmIbwag7+10Pia2eMKQWdZXVt7VU2BreTuSjOcGrEgZIBMQWCmwjZVH5ByahnKLpXqmOBGA1LOJ/902QVYVeAA56kqZH5+3JxORwDFTBHJDBEqXjNkVIhZfxhWs6hAcjtmocRqTuogGUlmTn14d2h4gMAsNo/f1/zBRJ3rdfGnwEgri0dCYIE8j9awdVFPsZWEaGC+2hSQYVk/I3/5PT0xiaHGHedqRh/jh+E3vggktXygl9slgvej6B+jkiaZa3gLqRqcNjTg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 143631db-6c1b-4176-fc80-08ddb8a1b336
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 13:17:59.4416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cC5t3E35tDdTx9W5MAes+b6TsiUxPWiFxNBY83gC/aRNthHM3UUAZdpnrKrmhev7ZB4G9tNDMUesz0TRul3YY+s+RmssQSxu00wrEOxMuh0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4503
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-01_02,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507010085
X-Proofpoint-GUID: Fyynx_z3WvTbOPtdrB4oUK2lVwx0E0CP
X-Proofpoint-ORIG-GUID: Fyynx_z3WvTbOPtdrB4oUK2lVwx0E0CP
X-Authority-Analysis: v=2.4 cv=b82y4sGx c=1 sm=1 tr=0 ts=6863e022 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=Ikd4Dj_1AAAA:8 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=06rAPj43xWyHfbEPM0wA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAxMDA4NSBTYWx0ZWRfX+0+UeOzHvuEC YbZbn2Wr/6JmvzfcMU+YYE0m5IJDYgEh+Z22aFUQRuc9dubzIhIIKM6jINW+cWdmJ/iAm6QZvqv bxruwoWvKcdhe2sx/0aQ3Bxgs96u3IN0l82p8qi//GSHna0fEAQStMesK8VoiNd2qyCwKnpWGXc
 WiVeOol49NnNszwmQRKx9znASWX9V+fYM+SKs7rG3EeGnFTFhajiO7rzw0xBlpjMBFikiISTZhT llp8VaykDuMciuwdG93+KetCGkumWgMUzURSi++QKqqOl94EpJjuHo5RLVO2c7ILfGX9+vUCyja ss2h9IONwEDm2BW5CObRFdc+GLNscyG9dGaKDV49yZtktgfi+kZPiw8xzziJPR2iIxN18GK1RKv
 u0J/Rg6pObR7mtZvYAF7HNxdB+QKxEpQDAykrqJWMphBjDC0lMvsL0/KV+pyedGXf9dC0mqi

On Mon, Jun 30, 2025 at 03:00:07PM +0200, David Hildenbrand wrote:
> Now that the mapping flags are only used for folios, let's rename the
> defines.
>
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

As the official King of Churn (TM) I approve of this :)

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  fs/proc/page.c             |  4 ++--
>  include/linux/fs.h         |  2 +-
>  include/linux/mm_types.h   |  1 -
>  include/linux/page-flags.h | 20 ++++++++++----------
>  include/linux/pagemap.h    |  2 +-
>  mm/gup.c                   |  4 ++--
>  mm/internal.h              |  2 +-
>  mm/ksm.c                   |  4 ++--
>  mm/rmap.c                  | 16 ++++++++--------
>  mm/util.c                  |  6 +++---
>  10 files changed, 30 insertions(+), 31 deletions(-)
>
> diff --git a/fs/proc/page.c b/fs/proc/page.c
> index 999af26c72985..0cdc78c0d23fa 100644
> --- a/fs/proc/page.c
> +++ b/fs/proc/page.c
> @@ -149,7 +149,7 @@ u64 stable_page_flags(const struct page *page)
>
>  	k = folio->flags;
>  	mapping = (unsigned long)folio->mapping;
> -	is_anon = mapping & PAGE_MAPPING_ANON;
> +	is_anon = mapping & FOLIO_MAPPING_ANON;
>
>  	/*
>  	 * pseudo flags for the well known (anonymous) memory mapped pages
> @@ -158,7 +158,7 @@ u64 stable_page_flags(const struct page *page)
>  		u |= 1 << KPF_MMAP;
>  	if (is_anon) {
>  		u |= 1 << KPF_ANON;
> -		if (mapping & PAGE_MAPPING_KSM)
> +		if (mapping & FOLIO_MAPPING_KSM)
>  			u |= 1 << KPF_KSM;
>  	}
>
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index c68c9a07cda33..9b0de18746815 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -526,7 +526,7 @@ struct address_space {
>  	/*
>  	 * On most architectures that alignment is already the case; but
>  	 * must be enforced here for CRIS, to let the least significant bit
> -	 * of struct page's "mapping" pointer be used for PAGE_MAPPING_ANON.
> +	 * of struct folio's "mapping" pointer be used for FOLIO_MAPPING_ANON.
>  	 */
>
>  /* XArray tags, for tagging dirty and writeback pages in the pagecache. */
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 804d269a4f5e8..1ec273b066915 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -105,7 +105,6 @@ struct page {
>  					unsigned int order;
>  				};
>  			};
> -			/* See page-flags.h for PAGE_MAPPING_FLAGS */
>  			struct address_space *mapping;
>  			union {
>  				pgoff_t __folio_index;		/* Our offset within mapping. */
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index b42986a578b71..23b1e458dfeda 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -695,10 +695,10 @@ PAGEFLAG_FALSE(VmemmapSelfHosted, vmemmap_self_hosted)
>  /*
>   * On an anonymous folio mapped into a user virtual memory area,
>   * folio->mapping points to its anon_vma, not to a struct address_space;
> - * with the PAGE_MAPPING_ANON bit set to distinguish it.  See rmap.h.
> + * with the FOLIO_MAPPING_ANON bit set to distinguish it.  See rmap.h.
>   *
>   * On an anonymous folio in a VM_MERGEABLE area, if CONFIG_KSM is enabled,
> - * the PAGE_MAPPING_ANON_KSM bit may be set along with the PAGE_MAPPING_ANON
> + * the FOLIO_MAPPING_ANON_KSM bit may be set along with the FOLIO_MAPPING_ANON
>   * bit; and then folio->mapping points, not to an anon_vma, but to a private
>   * structure which KSM associates with that merged folio.  See ksm.h.
>   *
> @@ -713,21 +713,21 @@ PAGEFLAG_FALSE(VmemmapSelfHosted, vmemmap_self_hosted)
>   * false before calling the following functions (e.g., folio_test_anon).
>   * See mm/slab.h.
>   */
> -#define PAGE_MAPPING_ANON	0x1
> -#define PAGE_MAPPING_ANON_KSM	0x2
> -#define PAGE_MAPPING_KSM	(PAGE_MAPPING_ANON | PAGE_MAPPING_ANON_KSM)
> -#define PAGE_MAPPING_FLAGS	(PAGE_MAPPING_ANON | PAGE_MAPPING_ANON_KSM)
> +#define FOLIO_MAPPING_ANON	0x1
> +#define FOLIO_MAPPING_ANON_KSM	0x2
> +#define FOLIO_MAPPING_KSM	(FOLIO_MAPPING_ANON | FOLIO_MAPPING_ANON_KSM)
> +#define FOLIO_MAPPING_FLAGS	(FOLIO_MAPPING_ANON | FOLIO_MAPPING_ANON_KSM)
>
>  static __always_inline bool folio_test_anon(const struct folio *folio)
>  {
> -	return ((unsigned long)folio->mapping & PAGE_MAPPING_ANON) != 0;
> +	return ((unsigned long)folio->mapping & FOLIO_MAPPING_ANON) != 0;
>  }
>
>  static __always_inline bool PageAnonNotKsm(const struct page *page)
>  {
>  	unsigned long flags = (unsigned long)page_folio(page)->mapping;
>
> -	return (flags & PAGE_MAPPING_FLAGS) == PAGE_MAPPING_ANON;
> +	return (flags & FOLIO_MAPPING_FLAGS) == FOLIO_MAPPING_ANON;
>  }
>
>  static __always_inline bool PageAnon(const struct page *page)
> @@ -743,8 +743,8 @@ static __always_inline bool PageAnon(const struct page *page)
>   */
>  static __always_inline bool folio_test_ksm(const struct folio *folio)
>  {
> -	return ((unsigned long)folio->mapping & PAGE_MAPPING_FLAGS) ==
> -				PAGE_MAPPING_KSM;
> +	return ((unsigned long)folio->mapping & FOLIO_MAPPING_FLAGS) ==
> +				FOLIO_MAPPING_KSM;
>  }
>  #else
>  FOLIO_TEST_FLAG_FALSE(ksm)
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index e63fbfbd5b0f3..10a222e68b851 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -502,7 +502,7 @@ static inline pgoff_t mapping_align_index(struct address_space *mapping,
>  static inline bool mapping_large_folio_support(struct address_space *mapping)
>  {
>  	/* AS_FOLIO_ORDER is only reasonable for pagecache folios */
> -	VM_WARN_ONCE((unsigned long)mapping & PAGE_MAPPING_ANON,
> +	VM_WARN_ONCE((unsigned long)mapping & FOLIO_MAPPING_ANON,
>  			"Anonymous mapping always supports large folio");
>
>  	return mapping_max_folio_order(mapping) > 0;
> diff --git a/mm/gup.c b/mm/gup.c
> index 30d320719fa23..adffe663594dc 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -2804,9 +2804,9 @@ static bool gup_fast_folio_allowed(struct folio *folio, unsigned int flags)
>  		return false;
>
>  	/* Anonymous folios pose no problem. */
> -	mapping_flags = (unsigned long)mapping & PAGE_MAPPING_FLAGS;
> +	mapping_flags = (unsigned long)mapping & FOLIO_MAPPING_FLAGS;
>  	if (mapping_flags)
> -		return mapping_flags & PAGE_MAPPING_ANON;
> +		return mapping_flags & FOLIO_MAPPING_ANON;
>
>  	/*
>  	 * At this point, we know the mapping is non-null and points to an
> diff --git a/mm/internal.h b/mm/internal.h
> index e84217e27778d..c29ddec7ade3d 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -149,7 +149,7 @@ static inline void *folio_raw_mapping(const struct folio *folio)
>  {
>  	unsigned long mapping = (unsigned long)folio->mapping;
>
> -	return (void *)(mapping & ~PAGE_MAPPING_FLAGS);
> +	return (void *)(mapping & ~FOLIO_MAPPING_FLAGS);
>  }
>
>  /*
> diff --git a/mm/ksm.c b/mm/ksm.c
> index ef73b25fd65a6..2b0210d41c553 100644
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -893,7 +893,7 @@ static struct folio *ksm_get_folio(struct ksm_stable_node *stable_node,
>  	unsigned long kpfn;
>
>  	expected_mapping = (void *)((unsigned long)stable_node |
> -					PAGE_MAPPING_KSM);
> +					FOLIO_MAPPING_KSM);
>  again:
>  	kpfn = READ_ONCE(stable_node->kpfn); /* Address dependency. */
>  	folio = pfn_folio(kpfn);
> @@ -1070,7 +1070,7 @@ static inline void folio_set_stable_node(struct folio *folio,
>  					 struct ksm_stable_node *stable_node)
>  {
>  	VM_WARN_ON_FOLIO(folio_test_anon(folio) && PageAnonExclusive(&folio->page), folio);
> -	folio->mapping = (void *)((unsigned long)stable_node | PAGE_MAPPING_KSM);
> +	folio->mapping = (void *)((unsigned long)stable_node | FOLIO_MAPPING_KSM);
>  }
>
>  #ifdef CONFIG_SYSFS
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 34311f654d0c2..de14fb6963c24 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -503,12 +503,12 @@ struct anon_vma *folio_get_anon_vma(const struct folio *folio)
>
>  	rcu_read_lock();
>  	anon_mapping = (unsigned long)READ_ONCE(folio->mapping);
> -	if ((anon_mapping & PAGE_MAPPING_FLAGS) != PAGE_MAPPING_ANON)
> +	if ((anon_mapping & FOLIO_MAPPING_FLAGS) != FOLIO_MAPPING_ANON)
>  		goto out;
>  	if (!folio_mapped(folio))
>  		goto out;
>
> -	anon_vma = (struct anon_vma *) (anon_mapping - PAGE_MAPPING_ANON);
> +	anon_vma = (struct anon_vma *) (anon_mapping - FOLIO_MAPPING_ANON);
>  	if (!atomic_inc_not_zero(&anon_vma->refcount)) {
>  		anon_vma = NULL;
>  		goto out;
> @@ -550,12 +550,12 @@ struct anon_vma *folio_lock_anon_vma_read(const struct folio *folio,
>  retry:
>  	rcu_read_lock();
>  	anon_mapping = (unsigned long)READ_ONCE(folio->mapping);
> -	if ((anon_mapping & PAGE_MAPPING_FLAGS) != PAGE_MAPPING_ANON)
> +	if ((anon_mapping & FOLIO_MAPPING_FLAGS) != FOLIO_MAPPING_ANON)
>  		goto out;
>  	if (!folio_mapped(folio))
>  		goto out;
>
> -	anon_vma = (struct anon_vma *) (anon_mapping - PAGE_MAPPING_ANON);
> +	anon_vma = (struct anon_vma *) (anon_mapping - FOLIO_MAPPING_ANON);
>  	root_anon_vma = READ_ONCE(anon_vma->root);
>  	if (down_read_trylock(&root_anon_vma->rwsem)) {
>  		/*
> @@ -1334,9 +1334,9 @@ void folio_move_anon_rmap(struct folio *folio, struct vm_area_struct *vma)
>  	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
>  	VM_BUG_ON_VMA(!anon_vma, vma);
>
> -	anon_vma += PAGE_MAPPING_ANON;
> +	anon_vma += FOLIO_MAPPING_ANON;
>  	/*
> -	 * Ensure that anon_vma and the PAGE_MAPPING_ANON bit are written
> +	 * Ensure that anon_vma and the FOLIO_MAPPING_ANON bit are written
>  	 * simultaneously, so a concurrent reader (eg folio_referenced()'s
>  	 * folio_test_anon()) will not see one without the other.
>  	 */
> @@ -1367,10 +1367,10 @@ static void __folio_set_anon(struct folio *folio, struct vm_area_struct *vma,
>  	/*
>  	 * page_idle does a lockless/optimistic rmap scan on folio->mapping.
>  	 * Make sure the compiler doesn't split the stores of anon_vma and
> -	 * the PAGE_MAPPING_ANON type identifier, otherwise the rmap code
> +	 * the FOLIO_MAPPING_ANON type identifier, otherwise the rmap code
>  	 * could mistake the mapping for a struct address_space and crash.
>  	 */
> -	anon_vma = (void *) anon_vma + PAGE_MAPPING_ANON;
> +	anon_vma = (void *) anon_vma + FOLIO_MAPPING_ANON;
>  	WRITE_ONCE(folio->mapping, (struct address_space *) anon_vma);
>  	folio->index = linear_page_index(vma, address);
>  }
> diff --git a/mm/util.c b/mm/util.c
> index 0b270c43d7d12..20bbfe4ce1b8b 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -670,9 +670,9 @@ struct anon_vma *folio_anon_vma(const struct folio *folio)
>  {
>  	unsigned long mapping = (unsigned long)folio->mapping;
>
> -	if ((mapping & PAGE_MAPPING_FLAGS) != PAGE_MAPPING_ANON)
> +	if ((mapping & FOLIO_MAPPING_FLAGS) != FOLIO_MAPPING_ANON)
>  		return NULL;
> -	return (void *)(mapping - PAGE_MAPPING_ANON);
> +	return (void *)(mapping - FOLIO_MAPPING_ANON);
>  }
>
>  /**
> @@ -699,7 +699,7 @@ struct address_space *folio_mapping(struct folio *folio)
>  		return swap_address_space(folio->swap);
>
>  	mapping = folio->mapping;
> -	if ((unsigned long)mapping & PAGE_MAPPING_FLAGS)
> +	if ((unsigned long)mapping & FOLIO_MAPPING_FLAGS)
>  		return NULL;
>
>  	return mapping;
> --
> 2.49.0
>

