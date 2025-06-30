Return-Path: <linux-fsdevel+bounces-53370-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61981AEE22F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 17:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96DD617821A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 15:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD13E28CF43;
	Mon, 30 Jun 2025 15:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Xp2j/MNX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bwXq+24x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73F1286434;
	Mon, 30 Jun 2025 15:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751296636; cv=fail; b=BsvK3EG2KbyuhwfTQMWy2ihK0NVcVrHvWdFaDKe5Jmk49gwth7R49BkMmquCIM3/vxm5UWEfoOLvMytdF5MWxsMzBJiye9XA8c56tnHXNrl2uImInEEM+NIaH8Y7Q1fhdQvutNJSk90U6PJdMMPJqiUy9+XikfpaXNF2Uhgt52E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751296636; c=relaxed/simple;
	bh=Z62d6NMM2LNDiy32USNE7PEr+liFFRStU26EE92iFWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=L97rn9S/qDrhTcoGL/dh24oWWvkhDbl7Axzeb+4VvdeoSGtY8r8wIBEZE/XOq13VnzDjVmxMn0elcwZT+VAjHJWrqujLG18TECeRhlwp4aYO5ZTVr5LW4W4wdz85Pht6IezXOR+R3Y0ay8QSUKv9HN8q1EEzrbSTOMutg7LnMVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Xp2j/MNX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bwXq+24x; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55UElApZ020137;
	Mon, 30 Jun 2025 15:15:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=VORK/ctiKFZgx89CHt
	AtzEKP0vhL8/Ry2gEw3ZYYJ94=; b=Xp2j/MNX/1mg2Jad6NAXujQ5T13XrWklwd
	OqIBmADzD/Emt0+bZmLU8HoK+5zofK/aQcwPvJT0AGQiPQl3E/uSI4oSo62GMuyl
	CPD1aZcypo3A9h8kab3yIOBBRoZ6WF4hK7RMlxmxTjk1ZLqpxdoa1vMDQ7Z6a6Wv
	kf3Lq3DONFUOVWyD4ejqD//d3Ko0tWrMqF/gbGrza219qE28lgXu+GeNQEC91GGN
	CfLRkcpk2JosrT2hbjWGUvQ3etLrfkBmxOfmHyJuT2m7uEryeWHLWqE+qYq5E7gx
	WHohlhlDoBTdpOPJRAC4rqgGGzVyl/C1I3IgbpYCDd/UY94fnMfw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47jum7t2ke-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Jun 2025 15:15:35 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55UE0D01029901;
	Mon, 30 Jun 2025 15:15:35 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47j6u8fdfp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Jun 2025 15:15:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JHjxkpwDSpW6rA2FDNYX5C3kH5Qyd2mRlME0XdNl9FfAYLCGUOVnBxntI/xNfTMJgpKSrIkpFdiLv7Ml6ZNQ6BamwlJgM03jj+VM26MowHvPFbRTqV9Uq4AA0+lcw6s6TbT9yLWyzaw3xnJaLxuTSwu+0xCFhnbsEIIZi3ZtGNmvV+2VJiBWOqOkCpV+2WymxXJ20VxMj0ejKd//G1stfxHdTKqPftOYWWECo3QvycoeoDL9VpdlQZqVXbQpJ965u2ssttTFf9ByE6g/3nSckgJdKHync911bmefwKUZlqI0HAlNPpUSA0QQ/BNhTmJrQIVsD+pOCxivzYU6uUI2ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VORK/ctiKFZgx89CHtAtzEKP0vhL8/Ry2gEw3ZYYJ94=;
 b=asbw4ykJmPlY+9fKWamZ0YYKBGr5LTi5/STuj/dBShALwm579p9gBhgMdHmDTg4NX9bzkgrTeJCtDSA+N8aiQaM8tAMQOd5//4QA0dfkKKIAmc/TJ2SPSgFpEFV0hVjl5cahdPpY1qNFc1wCBGWYjcvrqwrqn4GbEgF69IQX813F2zleYF1WVm7d+lNFzKmDAbgDbm/TMPr7grO/oTDmstg7jD2pjD+UgtCSoifgNhjhUHkF2QNcaaDs60WpqAb6HZiH9tY3bnG7KJor+jhWLcWf6qCz3V+KxWdPsEkdpnDdkVAHzNsO9mMKdlm33V/71QQsC4S5WwW0VIF2YMKLVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VORK/ctiKFZgx89CHtAtzEKP0vhL8/Ry2gEw3ZYYJ94=;
 b=bwXq+24xctjhW72WvGTTvPtO9k8BDpuctDuDMRu+RHA5tJnwnC1bdntxet1woj993dccLZLUnAAo2ABZOJhA2G7VRrpbjPji0kLfT4Ey0Po17qJaooMjokMBT7Y3hkPaZ2eE7CsxWBK5cs609AxeBUR/AEdW0QT1HdM5FRcGjoA=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ0PR10MB5860.namprd10.prod.outlook.com (2603:10b6:a03:3ee::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.21; Mon, 30 Jun
 2025 15:15:31 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8880.027; Mon, 30 Jun 2025
 15:15:31 +0000
Date: Mon, 30 Jun 2025 16:15:28 +0100
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
Subject: Re: [PATCH v1 02/29] mm/balloon_compaction: convert
 balloon_page_delete() to balloon_page_finalize()
Message-ID: <f9cb1865-aa9d-409f-bce5-7051480c1a71@lucifer.local>
References: <20250630130011.330477-1-david@redhat.com>
 <20250630130011.330477-3-david@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630130011.330477-3-david@redhat.com>
X-ClientProxiedBy: LO4P265CA0047.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ac::14) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ0PR10MB5860:EE_
X-MS-Office365-Filtering-Correlation-Id: b3cf222c-a628-4b46-3833-08ddb7e8f3ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ltdropxgy9TF3OW3eKgaeIzi1EFboggk3NfRINB6WODQUaRRmZRdSvlvY53o?=
 =?us-ascii?Q?lASw1yKi1Es88nDbK0UCvfBD+c5JbSiP7r5dO2FXSz+m8Os+cflMkXxWP4l+?=
 =?us-ascii?Q?Kqhabu9Q18l/F5y/U1bWbA9587ZRL+Cm6N2N13/3M8UugVUS124fl2QIPr7s?=
 =?us-ascii?Q?NbYX69Ryaz6alljVxGaWkJm2J0LrNXTLC85Fz0yudnupBVUx7TT4B1crr81k?=
 =?us-ascii?Q?I9CBwKTzpWFYZwoImVJONF/YcTj7+5RLh3Q0pBx+MHiiPNMc74GppM3UshoS?=
 =?us-ascii?Q?TztLIeBigLu9AshBuw0dqBZVk6BkuSQepocwmxQKqRd3cPO100h298LTA0aR?=
 =?us-ascii?Q?0Pi7sU9BBGuXkcpbfMfDButiqP2Y6iYLzRU7kkF/I6095JRMgQ2tV1iI6Pxn?=
 =?us-ascii?Q?TbnxIcXFZnSbP7zJT/BSUDP7fPlqGVK2AZsH7hIu0YaJUA2YWllAOiZAD/Iy?=
 =?us-ascii?Q?9Tx9M790UfqQwuCQf8h5PQWYaatNHb/L8zVWGdPaf6V357Qb/gtoaewjBrEr?=
 =?us-ascii?Q?OK04YHxScHazcESa4Omy73SQpbFBkGs5YYRAsvyaZbONLxLGcvuY0a1VJCQ1?=
 =?us-ascii?Q?YA5oZQEKUPNBV53YdaATHnXPa+3OSTP7kPKn6HspxhfH4Mf9JDrQKe5aLKs7?=
 =?us-ascii?Q?kqRf8EJ3WNF7wKMZBqRWHRW/rpDM4+Rq5VACYUNmiaxYW6R8makI/YBlKPBS?=
 =?us-ascii?Q?NBjVznJFSf29uGh27/5VDJx+UFVatDb9GBpxvNY3a+au/uoFoqR1/ppveIZI?=
 =?us-ascii?Q?Hd9ADIaAmrUxAqy7jyPIJ1PRKO5HIcAEtbeztsp0WGEAOAcaydZ26Qjfov26?=
 =?us-ascii?Q?MFVXXKVQ8avVnMxD0FzPnyY+ZDpQNkDOY6tDhAn8IlkWbz8+a2m0NWMlumk3?=
 =?us-ascii?Q?kR7KpgeoZWREJqgR2vFgZvnBsA23eDTvPHbDF5XiFDM+h8x051bzYHqtxEvG?=
 =?us-ascii?Q?dkIPbNFRH87Ld9LblODplzG4PUY6Zh8JXvpf28f5PIBC8+EpjN6hE226WJii?=
 =?us-ascii?Q?TaGWK+DN4uFmgFJr/gYbkPJoM4U8SNDjyC72mkt1V5w8D6GTkov9ogdo+qBi?=
 =?us-ascii?Q?zn483RThl0HsqdY+DWW1PKb0baq1983Gfgg/jwLsbgmKkRnjwOVsD8jaTdAO?=
 =?us-ascii?Q?zysjrGWCQ9IHUNqUjOVHGFVfL1rrrMvDT1Ier/p5VbUwQ41curd+2RpnXNE4?=
 =?us-ascii?Q?g2OQTyAegHtGtRUG/bDtb78B/URPbTcunN6yzMDeiySwmH7th5DsSYtaCvvi?=
 =?us-ascii?Q?eP451xyCqIn65M8hZTziJ89Ucdyc5fgdav9ZYhbNOqiTQZSPVjUEXa0Eiaws?=
 =?us-ascii?Q?XTt2mnzlVtCxTsLf9vc8+DfXdPsdXXgGRbnAicIg/DlUYh3OYQm3HOfN+YUL?=
 =?us-ascii?Q?dgnCdb5+/7kYUQu5teBN0QQAvEfuyf9lvXbbWRBDd2Kat7GLE0T8YhcmIA4i?=
 =?us-ascii?Q?BM6JkKqvC8M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1yyQxJabljinSDPdXdvh/QFKWY24QbhoTzbWZ8PETnv3FN5VbrzvDVDUUMpG?=
 =?us-ascii?Q?3LJwphOXHE2P1Ypo+zBFbRvSqTkRumrWEWLRfDd93jWy9WO0U8KmHT4ImaEd?=
 =?us-ascii?Q?kJAEOCecA7KSK+Wl72tnna30ts7LueISkzeOExv3CR1DdDgKkSdZ9hRvFz2O?=
 =?us-ascii?Q?PfVK5WcpyCvLnlozB90gtytXXKFqmNvpjuB1PxSwWI2qRUMnmS8FfY3Vy5dh?=
 =?us-ascii?Q?qog/ipXaQOYWqCTLzXS1+r5tq0bMuf9gqkkxEjToopT8IA5qpsW5M4EkvmJe?=
 =?us-ascii?Q?lfIPgotmwbqoqkpYlcw0nqCxu6d22KNRGXFHwbKkaS+SXL31sI9wd2eE9vZh?=
 =?us-ascii?Q?CxKmS5MaM9Xhh9UbgueD/4c75F+ijsRTeEwgIjzGCrhv0LJ25mYoKsjZ0gh6?=
 =?us-ascii?Q?GLiCrqiLWUldGQRRurbSVyCv/9xX0Y7iY4Cd2bKe4JUeQuTq+zLo/0eU0xTt?=
 =?us-ascii?Q?/0+/0YD+I88zYfIMn3QV18efeMysA6oaG723O5PnggwXQ2W8od/ExkMl+Mpo?=
 =?us-ascii?Q?Id3+qmc+CbDBfmUwm/qLinBHRS5xuMvqe4Zqj4rCSgPUYftxsTsXd97DYG+B?=
 =?us-ascii?Q?hQMSMxwXkOa0Ivaml8sLxFZNPI2QjxiskrkWKxhZ7sB5mMHxs79azFRxDM/V?=
 =?us-ascii?Q?0svA+qORqu7uWY4b3EYm4jfbrEWjoGQXHloiFDZetQjvR9SNh5Pc23DsvYyM?=
 =?us-ascii?Q?hztt1n4TmHuewbrNT6rOT3hNkA2JwHs2WKQ4DwGIsEQM0pKiHwlvKoXZXua9?=
 =?us-ascii?Q?n2QMr9FkjYti9GFPCoXnDAXZNKbC2JNDt4lOQkCDePS3oyqbWigRarq4bOEE?=
 =?us-ascii?Q?rxhkCCS2Af4x9BUCVkSg7+woKlA3mwIrzMO4CbfOv/iyVhOgXpJgdp6GGYVf?=
 =?us-ascii?Q?I30eMQRIH0AgdJAFN+aSOYr5QaW6Zf3jdn2FlfqTxsEXyCAZVwpZ/XI+FXQV?=
 =?us-ascii?Q?41e8r1Lg32wPi1jA2GNFESc+cIC9F/g5Vo1eorxr/P7kGi/ta9zUkAgyHIBy?=
 =?us-ascii?Q?1wlHNQ8lgClDPc24Pmaj50btJLWwtzSWD6i/YrBN0z0TG+4dIwxjBtsU4p2/?=
 =?us-ascii?Q?4PExdyfMP8IeLpFMV9nwpJl0j2vDBzKXUvXTmT9aNI8lHbdgYBHTAB5TDNGr?=
 =?us-ascii?Q?GJDI/IA60Q3L7ziKdUvNKARn2yAojWpR8SQqtBwkZzkY4K6TsUGK2WBVtgbf?=
 =?us-ascii?Q?eJuRZZxSQ93RTlygsgALmxfggl6yyr52hv+uZz2xP93gigviOU8VrN8ln6xa?=
 =?us-ascii?Q?gELJKLB7UBTOzluNvNWEBOkZAIgcvHrKbRxV49NDC2bYeMzqzwwhVbmTkr48?=
 =?us-ascii?Q?l4Nv3ngXA6n+iys4JEyAnJ9+G3g/d4bXgTprkzkl+AbiYWJnaMxS/Yc2z9sw?=
 =?us-ascii?Q?ZScUX7a1HG9c7Xttaih3GYbU8hilSeYsuijA+/zL1K+512xaWGk2n6tw152R?=
 =?us-ascii?Q?w7xp04xfmtbOYgztx1EdobzbQSgr2MSArptsHFvDhgk34pwXlNAj9la0d6eR?=
 =?us-ascii?Q?Zo0m1SGmBKOKCS0iY+19EKgCFtkKYKz6iZ8qsgmzT3Bb1bRBNT8yRTxoVkSA?=
 =?us-ascii?Q?vRLbUHy484IwWgSjSlICjE1ZMI/WvBs43f2sQ+V1fEi1+E0Bv6kLkupIVefM?=
 =?us-ascii?Q?mA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ljtiMg7pjRFguhZE0aNF9Pg6nmgLoUGeqTKdUDsK3Zk6u8LC9dKQMO02G1RHFlpEZMmWKK8QEXyMLyyf5n95O48ckNJf979zXHtxZ2cjAeHzQz7VFSTpf3HAHWDafA2e02O+we48Fp/wlxjPH0mf8mivYtKWS+v4F9FdRa5W5we7JU9szo8bFJbs+gnfSf7cafSMU16mciKwj/MzNafiLULGuBg61EdSUUCrPVk7WIGXmjSm2s7m6f9lFTe40i985Mc0p0a3rergxYeqLz6fzcQwufhch1gNu8Wm83o7e5yk+O0WzCv6MrpnK8TZHtPzfRLGQv96bvjlfM4MQfUzO5AeVRv9npfWaCM7IXOEfmC+uoqPvGXyc8T4xsyCZJt2A464Ci9DpYpa6piQ4yeb0AyhX7JG72VduNhwX1dO6K5R9NUFfR1tSg2cedpb8QO6XmX0ueD5B6IDrHg7xtVTG6FssCWgIIxjKgglmzhGGu9vqzy2HyZ0SoJGQ1QXnX1ZAY36JkVvDK0rIol4DJjxv2HPCKZCoLb+B+wC/nbvmK6GLqyH1Q4dOrDM9HIdIip56rcpYIzaXLHIF1TkoxNi4wMn6QmY7ZI7MipmP0LJwLw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3cf222c-a628-4b46-3833-08ddb7e8f3ed
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 15:15:31.1250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6c391HcWH6Qu8EVLRzqXNVHmITe14Pkvot1PmLR8Y7uGmqlNs+sZMH8N09R8w5+X2dl4QYCvJdQbRAt8rgHSvAqZYfrvaopCZK+T8QhTg3U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5860
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-30_04,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506300125
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjMwMDEyNSBTYWx0ZWRfX9y/koEqgWPje jD0spo+LefqgQVl6a/Vl435GzoSspgscAm/L6KtGciJztkG6VqProyrrtrayR6nG1IrEc99S/8A zQdPl/qrcxX+ouk9MZLwvkv/d7QrhVcJlshDBkimYpO8xcJRo5VVU20NgtW39R02KEP/wMoIN9X
 LdQPozJOpYsW8JXDWub4gWCN0jCjYOyuNRjjRsAfgmskmJsqIkIAYlConw/t3oE2ZxyKYS2Yget m2iW3JzUo0N/28BZ8BP+DFjZTRTECYANvQsRcQ8cTkHKUmZbI3Cs3AUAcS/HP4CZXKsyy+fvdfS 0IxDBOZ+s/wtBJpIQ0lflR9oqyuVXtf7PxuxjLaKMrtpq2eY14IwRSoahWtmBajzDGJl1ijHl/r
 6eVZMk9zsEwkGFsqJvRNK7bLc8FtUCcqivWqUvW5g2moUXxHgPDqcWwQegVYUqQyVqNgwvso
X-Authority-Analysis: v=2.4 cv=MvBS63ae c=1 sm=1 tr=0 ts=6862aa17 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=20KFwNOVAAAA:8 a=HCx2lp6-I0hu0RK4RhIA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: 8e3KoimdHLO7daNmZheObAO3jh1JdUZl
X-Proofpoint-GUID: 8e3KoimdHLO7daNmZheObAO3jh1JdUZl

On Mon, Jun 30, 2025 at 02:59:43PM +0200, David Hildenbrand wrote:
> Let's move the removal of the page from the balloon list into the single
> caller, to remove the dependency on the PG_isolated flag and clarify
> locking requirements.
>
> We'll shuffle the operations a bit such that they logically make more sense
> (e.g., remove from the list before clearing flags).
>
> In balloon migration functions we can now move the balloon_page_finalize()
> out of the balloon lock and perform the finalization just before dropping
> the balloon reference.
>
> Document that the page lock is currently required when modifying the
> movability aspects of a page; hopefully we can soon decouple this from the
> page lock.
>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  arch/powerpc/platforms/pseries/cmm.c |  2 +-
>  drivers/misc/vmw_balloon.c           |  3 +-
>  drivers/virtio/virtio_balloon.c      |  4 +--
>  include/linux/balloon_compaction.h   | 43 +++++++++++-----------------
>  mm/balloon_compaction.c              |  3 +-
>  5 files changed, 21 insertions(+), 34 deletions(-)
>
> diff --git a/arch/powerpc/platforms/pseries/cmm.c b/arch/powerpc/platforms/pseries/cmm.c
> index 5f4037c1d7fe8..5e0a718d1be7b 100644
> --- a/arch/powerpc/platforms/pseries/cmm.c
> +++ b/arch/powerpc/platforms/pseries/cmm.c
> @@ -532,7 +532,6 @@ static int cmm_migratepage(struct balloon_dev_info *b_dev_info,
>
>  	spin_lock_irqsave(&b_dev_info->pages_lock, flags);
>  	balloon_page_insert(b_dev_info, newpage);
> -	balloon_page_delete(page);

We seem to just be removing this and not replacing with finalize, is this right?

>  	b_dev_info->isolated_pages--;
>  	spin_unlock_irqrestore(&b_dev_info->pages_lock, flags);
>
> @@ -542,6 +541,7 @@ static int cmm_migratepage(struct balloon_dev_info *b_dev_info,
>  	 */
>  	plpar_page_set_active(page);
>
> +	balloon_page_finalize(page);
>  	/* balloon page list reference */
>  	put_page(page);
>
> diff --git a/drivers/misc/vmw_balloon.c b/drivers/misc/vmw_balloon.c
> index c817d8c216413..6653fc53c951c 100644
> --- a/drivers/misc/vmw_balloon.c
> +++ b/drivers/misc/vmw_balloon.c
> @@ -1778,8 +1778,7 @@ static int vmballoon_migratepage(struct balloon_dev_info *b_dev_info,
>  	 * @pages_lock . We keep holding @comm_lock since we will need it in a
>  	 * second.
>  	 */
> -	balloon_page_delete(page);
> -
> +	balloon_page_finalize(page);
>  	put_page(page);
>
>  	/* Inflate */
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index 89da052f4f687..e299e18346a30 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -866,15 +866,13 @@ static int virtballoon_migratepage(struct balloon_dev_info *vb_dev_info,
>  	tell_host(vb, vb->inflate_vq);
>
>  	/* balloon's page migration 2nd step -- deflate "page" */
> -	spin_lock_irqsave(&vb_dev_info->pages_lock, flags);
> -	balloon_page_delete(page);
> -	spin_unlock_irqrestore(&vb_dev_info->pages_lock, flags);
>  	vb->num_pfns = VIRTIO_BALLOON_PAGES_PER_PAGE;
>  	set_page_pfns(vb, vb->pfns, page);
>  	tell_host(vb, vb->deflate_vq);
>
>  	mutex_unlock(&vb->balloon_lock);
>
> +	balloon_page_finalize(page);
>  	put_page(page); /* balloon reference */
>
>  	return MIGRATEPAGE_SUCCESS;
> diff --git a/include/linux/balloon_compaction.h b/include/linux/balloon_compaction.h
> index 5ca2d56996201..b9f19da37b089 100644
> --- a/include/linux/balloon_compaction.h
> +++ b/include/linux/balloon_compaction.h
> @@ -97,27 +97,6 @@ static inline void balloon_page_insert(struct balloon_dev_info *balloon,
>  	list_add(&page->lru, &balloon->pages);
>  }
>
> -/*
> - * balloon_page_delete - delete a page from balloon's page list and clear
> - *			 the page->private assignement accordingly.
> - * @page    : page to be released from balloon's page list
> - *
> - * Caller must ensure the page is locked and the spin_lock protecting balloon
> - * pages list is held before deleting a page from the balloon device.
> - */
> -static inline void balloon_page_delete(struct page *page)
> -{
> -	__ClearPageOffline(page);
> -	__ClearPageMovable(page);
> -	set_page_private(page, 0);
> -	/*
> -	 * No touch page.lru field once @page has been isolated
> -	 * because VM is using the field.
> -	 */
> -	if (!PageIsolated(page))
> -		list_del(&page->lru);

I don't see this check elsewhere, is it because, as per the 1/xx of this series,
because by the time we do the finalize

> -}
> -
>  /*
>   * balloon_page_device - get the b_dev_info descriptor for the balloon device
>   *			 that enqueues the given page.
> @@ -141,12 +120,6 @@ static inline void balloon_page_insert(struct balloon_dev_info *balloon,
>  	list_add(&page->lru, &balloon->pages);
>  }
>
> -static inline void balloon_page_delete(struct page *page)
> -{
> -	__ClearPageOffline(page);
> -	list_del(&page->lru);
> -}
> -
>  static inline gfp_t balloon_mapping_gfp_mask(void)
>  {
>  	return GFP_HIGHUSER;
> @@ -154,6 +127,22 @@ static inline gfp_t balloon_mapping_gfp_mask(void)
>
>  #endif /* CONFIG_BALLOON_COMPACTION */
>
> +/*
> + * balloon_page_finalize - prepare a balloon page that was removed from the
> + *			   balloon list for release to the page allocator
> + * @page: page to be released to the page allocator
> + *
> + * Caller must ensure that the page is locked.

Can we assert this? Maybe mention that the balloon lock should not be held?

> + */
> +static inline void balloon_page_finalize(struct page *page)
> +{
> +	if (IS_ENABLED(CONFIG_BALLOON_COMPACTION)) {
> +		__ClearPageMovable(page);
> +		set_page_private(page, 0);
> +	}

Why do we check this? Is this function called from anywhere where that config won't be set?

> +	__ClearPageOffline(page);
> +}
> +
>  /*
>   * balloon_page_push - insert a page into a page list.
>   * @head : pointer to list
> diff --git a/mm/balloon_compaction.c b/mm/balloon_compaction.c
> index fcb60233aa35d..ec176bdb8a78b 100644
> --- a/mm/balloon_compaction.c
> +++ b/mm/balloon_compaction.c
> @@ -94,7 +94,8 @@ size_t balloon_page_list_dequeue(struct balloon_dev_info *b_dev_info,
>  		if (!trylock_page(page))
>  			continue;
>
> -		balloon_page_delete(page);
> +		list_del(&page->lru);
> +		balloon_page_finalize(page);
>  		__count_vm_event(BALLOON_DEFLATE);
>  		list_add(&page->lru, pages);
>  		unlock_page(page);
> --
> 2.49.0
>

