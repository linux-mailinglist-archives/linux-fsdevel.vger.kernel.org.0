Return-Path: <linux-fsdevel+bounces-53617-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3750AF109C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 11:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC56F176E1A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 09:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7622247297;
	Wed,  2 Jul 2025 09:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="q/4CVHQg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NHxGP/R2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07672376F7;
	Wed,  2 Jul 2025 09:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751449815; cv=fail; b=lhPZGIVMmLGcTY5FGQe3Gh0waCeOWN5VH+KS8S80jSxFyef3kjwSP/ITR7a21iZNWdqjKRWnPWhWJpvVm8WZlFUghCffCSxtRgHzFG+qo6KWc7YLmZUySCEaianXFdxjF0CJiJMLuV2zIhqpaXEi1abrHUXpR3y3+UA2ZMEGG3Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751449815; c=relaxed/simple;
	bh=dBt6eo05JeekblKMWyD+41F1rNtcsr8Tvt+osgK37us=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=c7XZqeS2PLH/zjUJw0GXnBxEfMRblU588C/0jkAmm88hSqRuMhzXcdrF77Fe0HLY2PV7YZzKjkszEOM/X3nEpte8arAV8HbspanORS2rl38XwbeYQStrDvAGdFuOOABE6pr5s4HDZA1de2j7t+zsHb6vPR1Z15/lwl4ERA2wFnw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=q/4CVHQg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NHxGP/R2; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5627MaFv005750;
	Wed, 2 Jul 2025 09:48:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=IgyG6r7lk1U6OFtcPQ
	mHKx5iDflNCHAQ8VQmhec+5ZA=; b=q/4CVHQgwAvnAhARsmhNd7oT75XVRSxMb1
	gi1Pzg8dNlaTHAPSr8xpNKk7BdrvvkHPCFDY39uy4IBulMYx/5/Ja/kEBWYj1bym
	OUqeFyBjwTcvs0Q+v5NiZzX5/emS5DWI7G81JTS3MU5CcwTiG7uMRUXci/HxFE/V
	S09uzLKiTGbBbM73P/VULahKJtWAu8OaUWcAqfUffa8nGqEkjJsU3juWWnQA/zBB
	QsHRCr2wv0ta+rsUTB9jlmWz9Vd7QtccIGrk+biufsNpaFq2QfzcI9aaSrzNKGCM
	y74FgD3Jv6SD3v7gAmgwHAfWN40S5t0oMzXKbtz00uOlQvW55lMA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j7af6ja6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Jul 2025 09:48:38 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5628DA47024947;
	Wed, 2 Jul 2025 09:48:37 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04on2068.outbound.protection.outlook.com [40.107.101.68])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47j6uj89bf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Jul 2025 09:48:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ht6yPt60zejO5SAQLTKJnYJnvVizATEOfWJ0ItRt3/wDAq/6dY8FOgnCc1YSVvTb44T5ErnHxvfr3yYOIKuPcBWqSI9P9a4GsewfcPdbyeMpZ3s765qO6xW6f/q63E3RYHhwzvNz7YOn3S6JEjoozwkoyC1Cj1BAQEOWkIbeK/Ddda4haiTQNf13V/0yAvfxbD9AeaIglC+6rOw3q0WxRIVObmVx+8HXLsjPfI8k8NgVgl519MUx1kDdtjUI3UhUEnTznWiB/KbBgcJ8gYaOP7rJlKYUJftv9+IdgG67U+GjH5VbuOiYs5fM38Q8IOkKFrzdjpiTPSRsePQpcKkC5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IgyG6r7lk1U6OFtcPQmHKx5iDflNCHAQ8VQmhec+5ZA=;
 b=fyOqJlEgu2PRwCU6NEwbU4cO3Jvlnyc2rMfPLj9pk/XRic7h5deQILW/T/tuoFH7UZlVf7FnNCBvpczBBCSTzipRQtiFGMpjK+IyPfmEy3iokvlpFyISO1VXaa3NDd6AWBBwJ2zOgwKKiadCUNgjIF7/jq5v2+66f0owmVuFOlwTwFp+j3VjJtnEMI1aF+iwAt6vxQk4pV8+511Btz/MTQEShDIZY9v4hil9OwekY3XMbDfLGfgFBZN2ezL/YpABZ4Ha2J5Be/wxWIRl2tM1EpRNsgInouGY0w6JSyjmwE00kkzuuCuEbBTyst1wd/IPfzDcEOe+TT7jFVS63ZCedg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IgyG6r7lk1U6OFtcPQmHKx5iDflNCHAQ8VQmhec+5ZA=;
 b=NHxGP/R2h3DjHBUY/TddLP0+zUW7t4JIjgO5+90WHFNdSGdVdi1gW6/MLU9NMYURtgxGPH+gs7HIhZnv3El9DOdjqO4I4mo5aSrZrioWzVAvisVL5c/Vie89kpBD/H3DGCMc0j3vCv2v9MXKqRQYqkpL2xRjAeQsObUE257ImI4=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by SN7PR10MB7074.namprd10.prod.outlook.com (2603:10b6:806:34c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.19; Wed, 2 Jul
 2025 09:48:33 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%6]) with mapi id 15.20.8880.029; Wed, 2 Jul 2025
 09:48:33 +0000
Date: Wed, 2 Jul 2025 18:48:12 +0900
From: Harry Yoo <harry.yoo@oracle.com>
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
        Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>,
        Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
        Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
        Ying Huang <ying.huang@linux.alibaba.com>,
        Alistair Popple <apopple@nvidia.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
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
        Shakeel Butt <shakeel.butt@linux.dev>
Subject: Re: [PATCH v1 17/29] mm/page_isolation: drop __folio_test_movable()
 check for large folios
Message-ID: <aGUAPSiC4GIIgzEu@hyeyoo>
References: <20250630130011.330477-1-david@redhat.com>
 <20250630130011.330477-18-david@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630130011.330477-18-david@redhat.com>
X-ClientProxiedBy: SL2PR01CA0010.apcprd01.prod.exchangelabs.com
 (2603:1096:100:41::22) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|SN7PR10MB7074:EE_
X-MS-Office365-Filtering-Correlation-Id: 217d531c-d417-4bfb-6a2c-08ddb94d9ba6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?W+ofMdR8Tdqu5RF6Hh1dmoM2ff21UiAyEP5vrefUgAZJ3LU9+NdkgL5R9yhP?=
 =?us-ascii?Q?JewzScT6EuBj0Nkw3PN1uTHC6T6Cdaq1qLb/THaXH6JzGn+FH/rHfp8tbeO/?=
 =?us-ascii?Q?vyx0s/RWu052g/nTwtZ4Ds3iPOSIh8Qi0QkHjOnIoVltVvl3AMOEYJXV2u+8?=
 =?us-ascii?Q?Bbtp2nhPu1M7izIw1lDL4YzOC2HCzjlXX841KwAjiA8iHFbQqpk05/oj6Z0n?=
 =?us-ascii?Q?9etWCCyhLjlRk6FUxvygv0zD4VmPf7FRyC+Tt8yDwJRXj384pChPmIscGGMp?=
 =?us-ascii?Q?GY+k/oMRZkNn9cxvJsJ0qOX2CVfDy3uS5+uBxPxKdn1/ywEiCQfRTjWMCRQZ?=
 =?us-ascii?Q?oQAc90egBVYCv0l0c4zoc9YofUsyIgF3I1vtQl7I9ueJuvDd7Ot1oI16CUdZ?=
 =?us-ascii?Q?ixDWVNK0DmRHlUwx0H19r3F6QGVIpG7kx6XFGR6BpsDul31ITClbdf6xD3f6?=
 =?us-ascii?Q?2prfe3arNcMIgn3KMcxqgbf/ATkmHzp9d1SBf4ux01te5s4aFKNjUmzgJsKx?=
 =?us-ascii?Q?LP2gIuO+/nhTArSmCOtmUjCw2bUXAeI0i4DsJKZeJ0cJXOnoa3wmyZOH2EmU?=
 =?us-ascii?Q?u/LhiwUrM3d6xyZ9Zeem8LmCkyGvE8VffMBrIeucQtcouTF7Rix3UFqqAozU?=
 =?us-ascii?Q?iI2+flNdoigLw/HibJBbRPWhaSRhRA+/qdcKnqbG57m+X1kmRZROCpXbVNWP?=
 =?us-ascii?Q?7B6JfyIIFj8kCwWZy58kSi+0jc/ZbPhdhbrjG5Tg6xyUpI+D6pOqpwvXFLbL?=
 =?us-ascii?Q?RcnkKBfelCMr5hHq9EicQYU2eKX7Ae1oZjT+5PvB4aF5vokcwbnb4ZVTHnAc?=
 =?us-ascii?Q?B5FWzt9i99SqFCDPcZAoXAEYIguc1AUDkOO2/Wk9bNCWaZVqYAgG43hIlko3?=
 =?us-ascii?Q?1y8ww0V9k+oef2M5BCg1vS6JdOg0fo/xYH9TJzuBso7C/qtqXK6oQlMpGXyV?=
 =?us-ascii?Q?HEYMCk3Ibkpbwgs7SyXjq2AC36V+Pz/6Af3TgEaMFb20yTr+3VZ/GDTQI/Ku?=
 =?us-ascii?Q?QvidR7D+nzwSfaalAF2a+GBekC06npFyuTlBI+p91UTBhICUrHtgJ4BaIU/u?=
 =?us-ascii?Q?xW/kFTnU8VyM3RzzajYqQ7EpXPsXgAiqqymGHFdL3hcDo0I7rrvmuiJwZIsY?=
 =?us-ascii?Q?osnkbddPsGwGvW+uS32KOBTee+HbaTbAfmgz9wqEl9xtuqH5JrrZC8dSv6em?=
 =?us-ascii?Q?O+AkA5DQFujcCHcHwCuZqIlgmPmYmT5lgTlDIsEYDPOqMEQFmKvG4/XDDNq9?=
 =?us-ascii?Q?4kRj0Ue0nOw76GEq06wplcUxzIAk952chsG361TF/XjNbk7W5gwJ/0zhSAGS?=
 =?us-ascii?Q?bgVLaQ0Q3EWNcG3IktlxpxtO4gcoAUdUS9Xv031n3TtNjki0N6zOpXTHZ4t0?=
 =?us-ascii?Q?jbNqDTqjV6J0boH79xNWU8UurSN5N0cDd7QsA37iJ6mlhEg74Csz7uSlLIqw?=
 =?us-ascii?Q?mNgPwNrPnyI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?H4mqxSqzz+oWZ903OBNOvjXn2tNusoai3+9+uA/BppZl9WlDp0dnvvzSzOb9?=
 =?us-ascii?Q?2csKrc8/0VGuSHHZW11QwJLOSAv9huVKof/Zil1MWEZD5pUyV2WKzbLqCsSw?=
 =?us-ascii?Q?dl0g5FlwY6wY8fbqm2ehKu8f80FmpOLf1n3DLJJ+Pptahi/lW0h/i4Tko7wT?=
 =?us-ascii?Q?7T/noGJRIlR983JyZzHJFJl1z3SJ0JEKo05yrK6vm3JQAMT4xe7rPIAqzOvV?=
 =?us-ascii?Q?xO2vtZrbyDu5NXdmS1G9BIIzEuXpU9oykosrvtr9D3RXpB4EXbKGg159wGii?=
 =?us-ascii?Q?lpcrB9odKNy/WS/7iYS0Yhps+FMFX02q6Fzy/V/fR13JWgeoPaD4kQXBotbz?=
 =?us-ascii?Q?V4WkEyzLi/f/pZyA7K5TdCXN/k2aGNQ98QPE/82nQVNzk9SCx+JiEU4wLXHK?=
 =?us-ascii?Q?acH9CE81I1RW+svJZi3Q23d1dVYkBH71o4o8mHfJ9ftn9tm3763015ACB8L4?=
 =?us-ascii?Q?mOG6KynwdqzBtJtwSzRaK2CqhDVDoQ7TvzzUcIXGCGyd6CfRSaoTyvDxiUOC?=
 =?us-ascii?Q?YC1lUeMUgto0zjgc397SVh2dK91K6LdIw8T03QbGUbT6K5DUoPC07X95loiG?=
 =?us-ascii?Q?ivQlmExSJNfxhURxCwax+wj/zfpP3To4iRU7YPJlVFn3efDE+yXkHNh430BE?=
 =?us-ascii?Q?ltS0kiSvq3E/DKRs+HYmJ6JnXWL6jipBx+NuNFrBuINdYwCh6MnA+igw8ZBk?=
 =?us-ascii?Q?xPwl2HAyHTd8dimwg5Cdmkns247pExL5D0UBE5MCbbaxeWzCrFo8+A47V7Lh?=
 =?us-ascii?Q?BLUyAUCb/1Ikuw9nIdGKbUASMYRlCq8JNlnN8sx+n/HgNVRCfBtduqRbQeMW?=
 =?us-ascii?Q?JpVZIlDNcFvI5BVGGe9bNc8KCBzVNZMfNNdC6w0J5SfYlnaE9TMOBdrTDlBz?=
 =?us-ascii?Q?B+rXy9WVNcNEenYBt4YvUmBhYyI1744YZKmACAqzisPsk3yTnh/8l4VV+0VY?=
 =?us-ascii?Q?W/nWOAo5lgvdXHeW4Z/PHj3XJpKDCGVvrnmQWETKuz2Jkjmgq3RyK0wHcWM4?=
 =?us-ascii?Q?zLyQ6TIS65xFmFNPZxWb2OPutIxKlE8cElZJaCXupQcnaaaDXX9B2TJ8s9Pr?=
 =?us-ascii?Q?P+2+qK3Ejivn36O5BwKFEn7FePG/pGKncxiHJwZwz8k/rbd9uCmrUr+Nm4EX?=
 =?us-ascii?Q?Su8miMtzojyi1KX05hoIUVPdNSKR/iFFoEAsZzWzTOpVgOPN/hxS5hjoF2+d?=
 =?us-ascii?Q?gc2rU0tnfqIDqGqKGO+4Pr03fCQkMNw34hDuc/Z1iTWxQY1Ej/eup1O5ARcX?=
 =?us-ascii?Q?5x/kh2/cnQnJSAogR4uO4YTfCD16X8NrbfrjY/HZ+fvkuzSOCjwTvNcdt6HX?=
 =?us-ascii?Q?lyDfFg/etnPK6wWMWGOzUJBEY8ZztWKpZS3wlVSfStRIALJ4pWV5VfvZJnt5?=
 =?us-ascii?Q?XS3lHWxnzn/ENMYIYKZUKxyDA2JPIQJTZukNbF0En92bGh0Zgx/mAI7zIQT6?=
 =?us-ascii?Q?4NuL34aAd37mBn5EDIA+ESR3WRWqKQDYypvuWNNy3stasI9BgNs+KiooB9Kx?=
 =?us-ascii?Q?RoAEWldR/OsAGBQmL0Eg7SvVxHvbyfqvbUNhaIw++aXh9kLv6Ds9jTuDr/uh?=
 =?us-ascii?Q?4YHqqRbM6ynKWS5bBulidEoPhu4riVExsaH4eamD?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	CTqFRWWyTLX8Ura4p47ceqxxZXFGPH9YDUvyf0O+r84Rp/L13Jvc3AcS1KeMwcy+kBcLLHrozj4/0qZEDBDnl51LxF6AwnlCFe+4h67h+q/0xr4TKK70Z94X1DVR44lQh585xnJJ6sGM+wmDDpw0b+j2/i7e2yQlBhmMIFF647mqaxfBtn+1bzj5lzOHH5ryooKhJn9u9+33Ng6kf3feHw+zXD2sHQT1ZCck6l6+gVnjOK5c3FivOfmOQro5CkufBfXBJuYRUg8L1aJOosquNbymV5z3QfoX8e6RgMsqhNEUR+e6TK07ywlOGpNPzcXS8S20bm4Jrhk92622EAxUEHudtsavrrvM4LJsjh1bPiFHDq7yZpjOx9dBxPPv1F5pfCdccOHaRbbRLLaZKA5kyfRnxSPR5NSZXcJQol6X3wcJX7rHqnj5Jjj8JL9duDmO9XTkNNOFIS9sbt2q0spLi0rEkEN2LScldnkkh9TJp9SjeX3xEMJE8UXId5UUG+amW/gUfNjV8HGSEZn3iPVn1M0fER6yswHHCiBUwEtKzpdhB04L716u2wpWTYyVHbU/A/1msMnyNz6NWDONks9wrjs+Imblcg6O5R0vnyuiN70=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 217d531c-d417-4bfb-6a2c-08ddb94d9ba6
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 09:48:33.3228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZE4aIhP4zQITM8ityvqr0QHcku8vc8izmX76AalFzEKuwmHRgtZh16IcRXAhBEi9xb+KKh1EcdSPIwhs/8gOdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB7074
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-02_01,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507020078
X-Proofpoint-ORIG-GUID: tT6AxK-wki0m1JA1B_CRowlOmXorSWVU
X-Proofpoint-GUID: tT6AxK-wki0m1JA1B_CRowlOmXorSWVU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAyMDA3OSBTYWx0ZWRfXy/VxbQMNvRje 4m9zhfax+n0R1YKda803zbTOFxSGdLDJU+VF+VRT4xtDxIXbYB9VWR55NDc4kak7h1IP6Mm7PkB GSXmP5DiT8qs2v59uvKgvnR5dVbeQOWQZtncLNJBe/+tliu9R6mGLX+1TiWObVuoMTMSVw20xfG
 YqFFirNiwKKoB/siaNMUkduP8rFQ2w0H7/sOVuw/xoMNdBlOLuRq5CnOVo48Dj9OReDKROu46Ui RlDFSThVWumpyrkTF0L+oCvWKfhc5JJM5nvpSXqYBPpqP1iSEgwbTEC+5xM521hqcAZoXUGzd2r dasg53qz9aJN39i9ntjSM7PqzCOHtEmX5bHSrJsZaAlRnA0u5a11eSptK4RcIxc8luFEHkO7s4X
 L7MPegUX4HtYoqCdUxyyu0QRvmBiexUZ+KOdTMMj13X0wbM3DfPvlZm7TeV4Unk9i++0BBol
X-Authority-Analysis: v=2.4 cv=b5Cy4sGx c=1 sm=1 tr=0 ts=68650076 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=Ikd4Dj_1AAAA:8 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=ne0TGKrCGuJeJc5GE70A:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13215

On Mon, Jun 30, 2025 at 02:59:58PM +0200, David Hildenbrand wrote:
> Currently, we only support migration of individual movable_ops pages, so
> we can not run into that.
> 
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---

Looks correct to me.

Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

-- 
Cheers,
Harry / Hyeonggon

