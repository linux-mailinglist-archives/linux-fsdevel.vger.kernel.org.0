Return-Path: <linux-fsdevel+bounces-53618-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3123AAF10B9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 11:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA30D3AF9ED
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 09:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47C0247DEA;
	Wed,  2 Jul 2025 09:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SzBX0pJf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lWJgI+A8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF9B1DC9BB;
	Wed,  2 Jul 2025 09:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751450182; cv=fail; b=SR4kCA8LgKMz2OEiUkzVAGhUHxfrNWVCj4UPmBfh1TeZaiRZPhFAetBZ5yWuAUeU1bWDNP8QkodXrLblMFLCS+hX+YOhgC40AKHoFsvi7qglzoRRqG3eUUzNDvZ2hZawVbhnqBiOwty9rpW3lEm/2jAPo9Y3OIhhyMN3pPAV6t4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751450182; c=relaxed/simple;
	bh=/MC4Nfm+j5ds3vujJhc3Y4bXOvsFnVzN0wQbqyhLCJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PzamG8YU1Npd7HnCD60Noc6/YuEN1jGK4sJfauAvJBD0BxR9ARVVaBcOk4jd90P/11xoBiirLw1w+XrYkmYrV8OAEScc7zu86o0pejWCgojIZYzn2ESjEKICCgWYMpssJxR4lNv1EALivWaylDcDv/dtj5eOOO31LPxEzDPK/+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SzBX0pJf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lWJgI+A8; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5627Mbht022080;
	Wed, 2 Jul 2025 09:54:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=VQgaLQb4ydW5WhxRZx
	87oRCBZVVIj+WtbQ0ei+ErDBE=; b=SzBX0pJfXiD9dDD/IoQMs2/KI0+4XLcNZc
	8dI8j65/wN5c3d4H9iV7jZQo/DklaXkaZ7eHB3mNcSW0nSYkvc+CTNIW1FOl7OcG
	kGRtvwPDEt8QgTJ5Q0mFMyQUVGVxyT+JS8OgEzlMDX5Rk0S134//DTaeiLc+4IR6
	AIh/9dhhXzbIgPqn30zBie08zlEIDesv1BGvCaXc/6SPDmYTaxK0Dl2JbyTsILrt
	eGN9lDS1N4Y8trpMyv8M7NLpW5/Oh8TdPB3b7L7wcv+kXw6EYNUQxBL98p9dNZt/
	up/EcysWuXoaD98fpt0P1taLLb6UADjA9OmSTI62C7LI2rDajl7g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j8xx6huk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Jul 2025 09:54:35 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5629nMn2024950;
	Wed, 2 Jul 2025 09:54:33 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47j6uj8fqd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Jul 2025 09:54:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZOQAe5DEW5gCk/z8kAycfDwx7fv6XRIG4Ib4YtdCEn/Iw0sTCOp1hTGN1zLF3t+/f4wHm6OgdFdViylu84bQTY6YIvbSQZ0T8Hiib4RPcrg91TCzJ+xEYnuUMvGJh/JbL/HvNxbCOQ3MnTo9lgiukr9hlqaYFtbC4f14+Z2QGiOZXDBQ4vm+jrqb8KI1qVl3xxSXne2oRuXYgNQUZcH9mmOIPugTdU67R9L1J/XYE42/GNJrEfEatGy5sKy2kcy1uH2arS2A8WK4DIlgRsElcK0KCw0DBtUvRvzP4FsopZbxSIbrU9PoCMVQISkcZtDJK2Nx0WJke7JSuYxgiwyYDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VQgaLQb4ydW5WhxRZx87oRCBZVVIj+WtbQ0ei+ErDBE=;
 b=X+2yb8sNSlSnLD4olICdmB1jeA+3KlLq6HWJL3ct16+WSDPZgC2ifvpK6eGWw3YNmakYKnLHkBL2dDAoK5pyA+KVQBkhBx7HhHFQaCcAL1TaFlYgnYN+Dmt3yVVTr/Ki/D2iaqwGgr1r9XjMrUpKV2zzBwpZX7JIjxQg3XqqmfTkdFYJr8cFQpoVbhsaZsVPW3impKaM5Av6o7W4EdYM/yYeCj4FxJ54/M03L1Zmy3uUZT3NX1c6qlEm74v2rPx4tFsM3EN3bsCzHAkZgyZ4dCbqE0w/KuX7+v3o4w1HWGa9RIRt8uJ4YOpNgjGGDtML4w33kMCR6ioCuNfVFGo9vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VQgaLQb4ydW5WhxRZx87oRCBZVVIj+WtbQ0ei+ErDBE=;
 b=lWJgI+A8SyW/O0+6Ddyf2FxS17Ee4lDl3zQfToQnkyCu9/XNDY8sDMjRZ5K9GLz1vFMM4DzXRWLHEee0A9NhrzNKI1ZckqSyVlx2+3caI0J2TIvKnjVVXKurymyB9k0GtPnNvbjdYkC7q8Rw0/OEmcZHlqM8LXSz/X9fjOKOnIo=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by MN2PR10MB4240.namprd10.prod.outlook.com (2603:10b6:208:1d9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.23; Wed, 2 Jul
 2025 09:54:30 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%6]) with mapi id 15.20.8880.029; Wed, 2 Jul 2025
 09:54:29 +0000
Date: Wed, 2 Jul 2025 18:54:15 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, virtualization@lists.linux.dev,
        linux-fsdevel@vger.kernel.org,
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
        Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
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
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Shakeel Butt <shakeel.butt@linux.dev>,
        Tangquan Zheng <zhengtangquan@oppo.com>,
        Barry Song <v-songbaohua@oppo.com>, Barry Song <21cnbao@gmail.com>
Subject: Re: [PATCH v1 17/29] mm/page_isolation: drop __folio_test_movable()
 check for large folios
Message-ID: <aGUBx9PUkSMm3pTf@hyeyoo>
References: <20250630130011.330477-1-david@redhat.com>
 <20250630130011.330477-18-david@redhat.com>
 <58b36226-59ff-4d8b-a1f3-71170b42b795@lucifer.local>
 <d9761308-8a8d-438a-b4c7-7ca3295fa0a4@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9761308-8a8d-438a-b4c7-7ca3295fa0a4@redhat.com>
X-ClientProxiedBy: SL2P216CA0221.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:18::15) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|MN2PR10MB4240:EE_
X-MS-Office365-Filtering-Correlation-Id: c8b3fa1c-d64f-45c4-2b38-08ddb94e6ffc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HfSv8VCwMBPxCj1MwTRFIE/uULn87lkHSzyjNuxy1VVcZTmfmq/021mEaJ+Q?=
 =?us-ascii?Q?VLAh7GJB2mIOmnGV6uadzSFsB6qegYxHU962PR7XpVVVk6KKBIczwGgF/2VJ?=
 =?us-ascii?Q?qDnCUjrynDeIMjZ75c9dVV8wBvLmRCxijuW49J9uOyiYRYogQgWtxIuuiKjx?=
 =?us-ascii?Q?yLa7Z+PnL9x1NhYNFDOZaZ9Off6VovSQ8mUa62pP/NmoGUV8A/YrqOeK6N+4?=
 =?us-ascii?Q?kBl8qJUsiEGEbVNs3I6TLsIyQcEwepQZV8Gjc6n09WyXCkPREMEwaSgUqocc?=
 =?us-ascii?Q?4nqToAbIwriv9L8ulPE3vZ05wMMYJoCyoUPQ/ONUhYsXrWk6Kf0zWFr0luA+?=
 =?us-ascii?Q?TitvjyYRw08VDhnlx8JCK60jlxkZi6g8xFdopMUgJhQckIe6AD7KaGlfsUuX?=
 =?us-ascii?Q?yvVcocfzSZ9rlZNpwGN3yMgeY184pW7wectv+1o+zAR2ExgHTAlvlZDKM+Jn?=
 =?us-ascii?Q?UCav12f0mD7BfM6TSDCEZK6cuuIYVXVIHVvCBSrSL8OtrgyjJfcAU+BXQuGY?=
 =?us-ascii?Q?kkb/C9RzmaZUfrq3xGw9KZYLywAAq+wEWKkDZlj/AnTcjnbk5cZR+w6G+h9y?=
 =?us-ascii?Q?UeQ5o2cI+8L8D1dkuXu0FTeuBaN4FHbXzJOakqJgr/l06nzvf6US7m2kC1Gl?=
 =?us-ascii?Q?wPDzJctVVU0ob2rsyoyb/Smkb/2BJl7cuCrxsvGjO5LGBwwxT1s6RHSBUqHI?=
 =?us-ascii?Q?6YVhBGwqkybw14k93+ULO3F8zsvOYUDkMnAqrSvTmE16ZGg+zHPul4+7LHWJ?=
 =?us-ascii?Q?kSnyIsd+U33GYxZy3gaAvgvnjFnMKVzJNwlim8/Y52SI6nOc2nTguO3K+3gv?=
 =?us-ascii?Q?xMFhY5+nokuzulHhD6rov+qzwQhglQtfGsaWqVAPOgkRA9hZ5H9eD/e2vZfQ?=
 =?us-ascii?Q?A4chyf0+L+3K6+kVo8EnQ3ZlHd3jhefJelCqjHWf/a+cuwhqNcpIFyPFoVsg?=
 =?us-ascii?Q?HUp9ymSuuZ0j22Wm3xcgIR1/KyGtQ3+OCj2PyoGeXENQRnx0NJIO1z0kR35e?=
 =?us-ascii?Q?02uwJhY8Ts+PRYC2Ol/e6pCSpTJzKCz6N746g2uqbu9BzE5vB4X6b9fp/Ml7?=
 =?us-ascii?Q?4QPREuz56LrXLc67fthNRvHBDWJYIZIrUJp2Sms9gDg7Dt8xitbeV66rnXQN?=
 =?us-ascii?Q?guyOl3WUxJ6LfSZXFleRg64JS2/gYDnV9jd96/dRpBACJe/v60/VWhI3FLqh?=
 =?us-ascii?Q?y86XQkA0SxqzyAUsgvnfzfwa7ZMFOa6TQ/p4mtjeakl6YmVPl7aW/PiAS9fz?=
 =?us-ascii?Q?0HTBPgXfxtq9PatcSAYWSIuTvD0g8Q1DHGZkH/JSxoFbjcL+VKO38jPfZdRP?=
 =?us-ascii?Q?qbo/sjopkORu0byMElv7d4ywWxm6wvAKJ5zyzBWcS7qfmBgGK1XrP5JZhDrY?=
 =?us-ascii?Q?YR2cieYGkwb+qvqZ7FsCicsNvQm4y7R7ZduXwM6EwhWyMF40QKNRfaCeKdgK?=
 =?us-ascii?Q?Yh4Ahqp50CI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?StrODyI0wayeWqNflWeLgoc1eWnzpsfVfWpF00b2nFKFUY8Hlx3efhnbagFZ?=
 =?us-ascii?Q?y0i6qdoeuuQe9U/diCK9/MYAX1uorG8HV1DSlcbALSNImHHPzP/rdAe9g1l4?=
 =?us-ascii?Q?4hduZClea9rbfj1uzdEnKK1w193RMClEcMqhlAF8zC12R2yAOuIvv7SdqtKj?=
 =?us-ascii?Q?kU3puIsHzi4271MhHDaKddvXpyNleKWBTO0cmf9Zk+/y6EBp1z2QWzMoQUdM?=
 =?us-ascii?Q?fFzeQ+M3y8dMuDp8LhI+sbbTEt0p/do2OhmIcm0K1kBoANrRzTdrfT+K6B8d?=
 =?us-ascii?Q?E/NYxVEF6wetEHuFHb3vwTZt55HhT5ZtOGp6Vsfsgl5/ltDtG0EUF9nhqsNk?=
 =?us-ascii?Q?HPP5AxDD/3k9LVjJlZfi7sRHwn18Ksj7QsM+m8Wtoz0zWReY8PYeaIQMDt+6?=
 =?us-ascii?Q?4cuYVk7lj+bHTzeA3SgzABbnQ9yrV4n0zn/6x4IoqP6BvAAohC+JX4E1PHeP?=
 =?us-ascii?Q?vhILjBiEmuXF1AskVuIv0HcPyIN8SLebeUkl6CHPIexvGzd+N9lMYRET4oax?=
 =?us-ascii?Q?0XEzSFQqc+Ht8DQM0gMn0cW98LmIfOlk0zzzB0kRWWgWFPuGMU/mC3b8nRDs?=
 =?us-ascii?Q?D0cWpep95wh6y37je0Wz5ZqkWBDOjvLbK+tmAE6fOV0ppUaPFMnjVypAm85T?=
 =?us-ascii?Q?OG+TCxtjSRNthse43xKbhlUpaSsOmky2PlMUEwpzuzzfhsfyHVAcpq3U2I1l?=
 =?us-ascii?Q?N7baNjXh9mShEoQSqQaV/Mrye2x3BniQkk/HvfnWw4IujdZEe8EMfsd73/Cx?=
 =?us-ascii?Q?LEt6YOfQCJidB9W9TT9algZwR31bJdHOdVbmIsxDWcFhA58j89le6HgBfUJX?=
 =?us-ascii?Q?SFWQ8ONpBGi500loHJrtK8PXZ+nJtEyPfJoq3Mk2j3vkTnpDyvvzh6nvz8sW?=
 =?us-ascii?Q?bKNoAil6VpYO9Gm38eyftvvKE5dJvy8VKcJjz3C69OovabMJzfkn15uQZLkr?=
 =?us-ascii?Q?VPm3XVVqA9v8y/01EG1pgwXLBdwI9/TN19+vuIDyuKQJHB5CFH5MsfOP6bxU?=
 =?us-ascii?Q?QZl8X/LXNyWFtP7mdxViTyuuqmRzciM0IyhxvlKk2eoQ79jycBzuiqyepCW2?=
 =?us-ascii?Q?K6PBW7UDK1AE4t0WzQFew2Zv+aNCoe5EOzNas4PGilXQwqrrfxyGQtMX4do/?=
 =?us-ascii?Q?clf8Kb3qI2Owp17fkJDlpXDu/APHiUZKk4fkeVhgfYp/gpKRTKeHQglSkR30?=
 =?us-ascii?Q?qhoFU/r8k6/XUFmXP2phSHiwoz0ENrWy0GWgK7IruZeX3DGNUHGrg/yte0lw?=
 =?us-ascii?Q?OSMpYawxbROGhjL3AO9X+IC93+oq8YCDPtBiWesjdPGAcDbkTjX53+N8kvDh?=
 =?us-ascii?Q?lOKSGc76iVu/n52qUB7yDCnZtF5z7IdBMt1l2NIKw8r8LAhBL9R3wOMbtBG2?=
 =?us-ascii?Q?Pk22wz0zVc7Lcur2ZU6F0/a4wiCDymapPcruA5snkhQwQVvrgR7ZmQl94Ex5?=
 =?us-ascii?Q?03una6YfOQ5S06bmPe/NuyAOlHEFXwHKFJH4Pv+xDo5QpoTEYCQTPTLao3vl?=
 =?us-ascii?Q?Y+0ACJzV8BDDe6ITAafgTUErPIbEYxNSVVdIV265HMHVp10jx9v7UuMNy+la?=
 =?us-ascii?Q?ZB2U3tMAcVd2Y0P8Dw/DElFbZwAuUO1RLp4JOreY?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	eI49mZITpYA2nrtTEhf2xvHPTdcLzVOOmkmLQaZSNLrZX51aRyKDbMLuxJvfnG3eMnsSOCGngGyZwVLd87VdoGV/nEo/6r0TMkzjuAt+V4VANqvC9bhpydSwPbN/q8eoHDCnA27Jv2+T/NNIyq2bXoHJrV7o1PY3EO3YusxAOWUdstWapvJQYM5f0fICv9o4E3JENoE7YuA97ymQ67aCBRel2h/5InTz30Gm7ZbU8LK6n0BV0PcWFeU28dBhQxwFExo703DsJs+lDtwwTaXgg0ptx/pUjQZz0c3JxZRnr9L55tFKgzagBHULcjo0nrvPqsUUcqAYbu+dEe+SKzVuB1TEEwrydUBADRjoAyIy0J/kqTmxx11DjsJFSvwWrztnAe6iqT/FmRWCXamLMfHwv03vgwI5hktNOuYZRDMmMuYjmF6BN85ObqzNSM0S2YLxorhu9BQvwkUI/hPduSIGtPeRKuCPTmvavrHgJF62T0ixTBA7zofRV+dhUcNEOfusQ+ozVR95tNZ0RPM+ldqlkGy6mlNaXbkC7kkpKTxP6AVNHcnI+MImx0JMFxtgZejnX4J48dhg+kAKnMCSMum3W65qesV7iN9KbTM1x0W2+rU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8b3fa1c-d64f-45c4-2b38-08ddb94e6ffc
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 09:54:29.7283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q1jMRPVB1Woli8aTWiZsIvERLRYJWp1ycDihN8ZfxN2G2/jfFgul/1j7RnX/CTA7tCoQ/jg/JS4TF0xYa1YnTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4240
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-02_01,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507020080
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAyMDA4MCBTYWx0ZWRfX+QTtiFdOfu9Z B1U3mHCFYGqL6wClXYpVjpy8VWOItJ7FId54NN9t5ySnhq1ypR0gsI/z7R9RwafDRuJEwQawXT9 f6SClMNan2c3Hl1f5SyXq8fLYOyrFlHWHPVkyUCJ37d2qY/q4XEPiPSonspN/gGx5BKc85yz5PX
 U+e4CMqbOdzCNGXEtDvJeTGb+0FR6IfawTQuV0xqw7lttFY/7XvFCgHX3A2Udsgd1v4LIQQK3Tz d+IaidU4d4XZwISjvtHvtTD7KMlX4fQ98M5zyZJOum5kQBIMsHbc0DCjGw7c9SiyfyGRhbXF7cH ajuGSzVRiuWQVoiaUgimBGpoX+DKkL423E8Oa/vXnuKpkKDQ7PG6zWGM8asvtApUtwJKfVXNu1s
 aKeNn9gtooQA9aP0u5aE1VTfDkB8pY1yyAD/YOuxOT0oB85zQ8NXGIqQRDC7RcBLuMqtIjnt
X-Proofpoint-ORIG-GUID: kP10ferlss7Ac_3QNqE8b4euWEycmdtc
X-Proofpoint-GUID: kP10ferlss7Ac_3QNqE8b4euWEycmdtc
X-Authority-Analysis: v=2.4 cv=QfRmvtbv c=1 sm=1 tr=0 ts=686501db b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=Ikd4Dj_1AAAA:8 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=m7dAX-iqkMTnI9mmn_UA:9 a=CjuIK1q_8ugA:10 cc=ntf
 awl=host:13215

On Tue, Jul 01, 2025 at 02:32:54PM +0200, David Hildenbrand wrote:
> On 01.07.25 13:03, Lorenzo Stoakes wrote:
> > On Mon, Jun 30, 2025 at 02:59:58PM +0200, David Hildenbrand wrote:
> > > Currently, we only support migration of individual movable_ops pages, so
> > > we can not run into that.
> > > 
> > > Reviewed-by: Zi Yan <ziy@nvidia.com>
> > > Signed-off-by: David Hildenbrand <david@redhat.com>
> > 
> > Seems sensible, so:
> > 
> > Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > 
> > Maybe worth adding a VM_WARN_ON_ONCE() just in case? Or do you think not worth it?
> 
> Not for now I think. Whoever wants to support compound pages has to fixup a
> bunch of other stuff first, before running into that one here.
> 
> So a full audit of all paths that handle page_has_movable_ops() is required
> either way.

IIRC there was an RFC series last year [1] that adds support for
order > 0 pages in zsmalloc.

Cc'ing Barry and Tangquan in case it's still on their TODO list... 

[1] https://lore.kernel.org/linux-mm/20241121222521.83458-2-21cnbao@gmail.com

-- 
Cheers,
Harry / Hyeonggon

