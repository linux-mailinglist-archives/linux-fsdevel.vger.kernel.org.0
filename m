Return-Path: <linux-fsdevel+bounces-53605-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3552AF0E79
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 10:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8E234E1A8C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 08:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D539E23C8A8;
	Wed,  2 Jul 2025 08:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OX03WJQ0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="oXaXrmGA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AB023C4E5;
	Wed,  2 Jul 2025 08:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751446257; cv=fail; b=SRmHN8ZLavLgRTM1QHAyCtyVWa4m+vVkifkZwy0bVR2+SIEyjLO8aD7dqXHzeFo8EiF6wHarDeWi0bydBf9rK46WnzbLYw6K7/J6XSYccNjse6GrFd2Z+a3K2sJWZFeUFqZnYIgAbs+pvegaIynOUJUZYSxPpqReAqgWuWL6ie4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751446257; c=relaxed/simple;
	bh=ApU9aWbVu10c4vOZe8zQebuI/tMaT5ZZGrcwVIJNo1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Hi2kRWuhoo6I8P5JIj76bymHad6AjLlR3UcyCaOiblUchMPDpQFdwSa8QxFgzTVhNxYcGqhPCMC5yjlCAc781/ACU+Vdbf6QiQPP2FN9DLuv5gw/9sDMYDeXDT9BpMXbMeGmmr3O35QIXv6ANTaCrhijdv/CWP0KbQgSLg9+4/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OX03WJQ0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=oXaXrmGA; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5627MbjJ022033;
	Wed, 2 Jul 2025 08:49:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=ApU9aWbVu10c4vOZe8
	zQebuI/tMaT5ZZGrcwVIJNo1E=; b=OX03WJQ0v3UMt8WrZtfGFcbh0gLsMzzw36
	1Ro+OuYmStLgDTBdGlvXDNSCXP42HhoEO3sP/xOUMayG9mzw3uNBApQdC4++lw9V
	PbFZ+Ht8Pz99pH42vnyeO84AffaF1QkMhH2Bd05iVLwlsv8pzzM36wPYMR0C4/hB
	wyRPQa4DExjza2FSx/hudqyH0Nc1nVSey/fIEPdHXfRYK6jvjdeRiiZHODlPKT1C
	zzZcSLiGAx1byLziXkZrBZZpbeANeDAHtxgIywp1jJ5pAHEEIZok6xB9wW0UmLuJ
	3ZvIdMTUkzRhsa39gTSMb9zsAobp3bCSRU2Uyoj5k+4W0YRm1jDg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j8xx6dw0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Jul 2025 08:49:13 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56281X9v019322;
	Wed, 2 Jul 2025 08:49:12 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04on2040.outbound.protection.outlook.com [40.107.101.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47jy1fpkqh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Jul 2025 08:49:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CqI90U4sZfha1SuD8dlBa+2K4QDRvxu6PIrrZhcn+f6FDioHQvdknVNh5B2vDp9Z+DD1LwHJQ2A3/C7cqm9eTojK2CR6IwkuAX2QqsPu6TzAXDA0lfXTm2hsrlDByg00kVI7nP0uvCkgeFiNl/JGq/2vtaXu9jD4/fZfAT5MIxrA1mLHIdcfAkVYwLr4SOAom2PmkTIzt7OWWabui2eO1zylkXYjCw1m5JGPxx4Xtmxp3Nnlqv5axwvrXzsWokJexuwcYzGmkwl0HglGE7egw1kkNNImFy8BJLHhqwOz2qyQqrjM5cLH1hqn9sgR7wgBwe4h1hjZXlZ289ORo5cCjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ApU9aWbVu10c4vOZe8zQebuI/tMaT5ZZGrcwVIJNo1E=;
 b=Vl/quwPtXKGpXw+QXYBLEir/hRmZ69BA942fh32qNwDlfQsR79q6jLAQo+572A1nT6/piwqRJyt+rlbcIdzgmh8Bqo8NlfYCPhuUSvndZy/Jjxs8Jy53e9cE6iEkvHJIftqBm2Pyz2HHG4PDsA0LbSPrt/HDHqbtzRjt2h2DTMMsWOeNCm4pbUvWKF/Or7jHmdo0qAu4/JF6zANjGWMhZwVPvkAvRVVggrxfiYJEoUkIVyDlsDfUpsGXhPIe+n658X3a2CG9RdreJ2ohO/gSn4FGc5eSpm0yjyJCMkesS/MLBJUA+fn0AghKTNwHMXeCjgySdJ5QNn/XCduNoEH18A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ApU9aWbVu10c4vOZe8zQebuI/tMaT5ZZGrcwVIJNo1E=;
 b=oXaXrmGA2eOVfKlsi5UY0wt3QMi4vds5S1UZysJztof0VixD+x58PiKW6Q7ffSaSwOECNIg4v07nelKwwKl6ZzE4E3t2bXYCL673aKI+nytd8vM7Wp1Hq0gUDOXekD/egJggdQDr3EUJmYhQt9I61mfhK5B4xWl10uYmJIYhmp4=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ0PR10MB6327.namprd10.prod.outlook.com (2603:10b6:a03:44d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.17; Wed, 2 Jul
 2025 08:49:08 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8880.027; Wed, 2 Jul 2025
 08:49:08 +0000
Date: Wed, 2 Jul 2025 09:49:06 +0100
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
Subject: Re: [PATCH v1 23/29] mm/page-alloc: remove PageMappingFlags()
Message-ID: <d7e29c51-6826-49da-ab63-5d71a3db414f@lucifer.local>
References: <20250630130011.330477-1-david@redhat.com>
 <20250630130011.330477-24-david@redhat.com>
 <8ff24777-988a-4d1d-be97-e7184abfa998@lucifer.local>
 <ac8f80bb-3aec-491c-a39c-3aecb6e219b2@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac8f80bb-3aec-491c-a39c-3aecb6e219b2@redhat.com>
X-ClientProxiedBy: LO4P123CA0340.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18c::21) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ0PR10MB6327:EE_
X-MS-Office365-Filtering-Correlation-Id: 31a1273e-8a00-453d-456e-08ddb9454eb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8uQNNRPPsY4qIEKqPTqNd0X1Gm01CNi8P2q2rStTBIB8Ch9XdJy+hKzMt/tC?=
 =?us-ascii?Q?F+WDwR+TRneSBiM+f/VR4X2Q9Thx3PcvSVZcIt3yMU77/RyRil6e5Xeq5a6O?=
 =?us-ascii?Q?yCmK2r3wcv8XTErRKI3Lsd2ePLAh5hf0k/ZIM/DQgC6mKZUk+nB9R7TEDphe?=
 =?us-ascii?Q?HLRDkKAYXHu1BPCyutR1kmMYCc9CHn7Vbch+gMBDAmpzKsQRL90MPewxx8xS?=
 =?us-ascii?Q?WSVquLIw/PsK/0vf3qCiXIK2e/6bSRn/tQzHiDa8zet8Jty3fLfDFNysBKp+?=
 =?us-ascii?Q?mBbafcjJDuBVnT2gnBYuve/YgormVg0IEqoX5zboqpzgnaUXyny+7RGqQb6N?=
 =?us-ascii?Q?1cjeAf91W1bCFBJCwXs/xeOswIEtTIHlaM6lVRwPWb4CPGdRvNliu/LqtRmH?=
 =?us-ascii?Q?A/ufIFCu6VX10ZHASWGRw1rLy3/3t2wC1FfHPgZ2HU3WoUMDWVezexF4gbND?=
 =?us-ascii?Q?L4hNLrIbc4JYsgQoaaZTKKU0j1wTeIn3rMw2bDlaFMyJpzkMyjtkyuh9r3Qo?=
 =?us-ascii?Q?MM8ASQh3GwKhAMJkbzsdVy44LSwcZLmETke8SAKPSpW1KCaTBOSfCBewKLsu?=
 =?us-ascii?Q?/zToscC9kqi2y57sKXwmUUVqahuzPg5nVkd6d8/BFHQCR/xGRKsZMWffERCk?=
 =?us-ascii?Q?s2dnIyavPW784+QkCwD0dOzIduNPrddCCohIHjR9gTKMfqHU7DX4T/zJv02h?=
 =?us-ascii?Q?JtIXn16xSdXnDntXjHeUfBsAgdPI+KTJGpOINzsFnMkxF6/yw+InOP1y9dKY?=
 =?us-ascii?Q?Bi6YoknkpSHR5fjpCySk561NZPvlP2GIWI5x6MEdm8kP3Ob2SYJD1nBLsOWS?=
 =?us-ascii?Q?8Uzir13l8pN8RuKpcvkv0Lu6RNChAHG8STo+N16iZCUgP6pwdjkSZEBLb6rR?=
 =?us-ascii?Q?cKXH5TEmU3di3gRojAAjL0jY4a7QY3YjCr9CXcNhf8YEBcSJkdtVAzvFLfYE?=
 =?us-ascii?Q?Amfm6/XANM8olM0DNpHwRIYY5t3wPbfF94BwcspZO3YRBI3Sx2cIPSdBde9j?=
 =?us-ascii?Q?gDwsL6Mlj8wOJUPQbbtIOlw0rmkx9ljLadgosv/utX+YX9MNycHWod4yauW5?=
 =?us-ascii?Q?5/ncSrfrH7Hd1YA2ZI5lh2EBwiDADhPEcy+gfQUpjf70ZJ4dksrLN/0tOdRx?=
 =?us-ascii?Q?csPmNJhCr/KN5p3jKf2ZqK4TISEkC1b7bD0xNdJMgbXk0eaca//78GFNM2vZ?=
 =?us-ascii?Q?iD/dHSbzoWSsVvvvYuI487tqX4QxciFu+4MPJp7Pr+mP4cMeu/DsI68s4xCr?=
 =?us-ascii?Q?QCiVv4FIX45ZSvOO6h2YChAMthmUD55rE5ff+RWzRnHpSq9alZycZKgLDJYE?=
 =?us-ascii?Q?K2YLFuOCtJ+84KCk5LeoeFjyjlWhzoj8QXB8f7ZGJmsTKixMlkOi/ZNQpJgG?=
 =?us-ascii?Q?EzZuK8HmMoDbCvFzc1m6m/fb9ozkDoFW1PL5P6vUwfSL34JDEbVqu76uPtuB?=
 =?us-ascii?Q?swvznWslJFw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FRXx17ORESXYlXqRXgThvScAzkNkr3VANEZ8/YUFW6V+e/BHceHLZRvc0see?=
 =?us-ascii?Q?gvnVtnMghELOxHfHSpmyO4etmRhL4xTmRT+KQKx0CEX8JGEN8o3Hv+YnEk4z?=
 =?us-ascii?Q?JOYREDymrEgLD0Exy4Cm1sS7dUMqUONSn6oibh2zekwLMbovTxLEclNZcrAH?=
 =?us-ascii?Q?y9eVu5ZA83UMw8neUtdu7zIzfIFPIoesMjUBNqS5ojkjnvpG1QDFGdnbmsuY?=
 =?us-ascii?Q?iKDcaZIJ0CJ6txYSXik3gzz4gkUHEk9H3j6biHs1a16jSjIYP4q+8+e3gJB4?=
 =?us-ascii?Q?tk4Z1QVpFIZanMmqOhTi7BuCuQDmivAhbPn2CZKkCxcxVFfaZ86Q5b44GYxT?=
 =?us-ascii?Q?Fb8W+xUEAVlYPGVDF5mjT5Me5ET4VvQOdB//nSVh2Y3u1kM8PWq8CUKnY+dP?=
 =?us-ascii?Q?s7Bc9v893jkbYb+PGKUK0Ud/OIMnNI4rod8Tee9uzoebnH0+4v+PmV5kewPh?=
 =?us-ascii?Q?P1A5i1EuZqFIxguCXwvR3lBbuOi0IRDIXp1Eb9O0wLYTd5HdP7Wo7zsoYw1G?=
 =?us-ascii?Q?BITk6xE8jNFG4jAh47hLM8avmceS6NCElCEonOJaZqchEe1P136g1ntgjvfj?=
 =?us-ascii?Q?mx3EiQdRwfYSPdZMpawnlg0qjWWiAX/JLkrcejtDaqQcOPzIdtnGuChyuuas?=
 =?us-ascii?Q?YPzmgoizNY+HnweYUAeRP8r2mfT7WWjt1dP4DA/Bt4WGlkt0xkKCpdgY46yD?=
 =?us-ascii?Q?4CsCraWFdrVWnR8GfitwuuQIqX0hX1h23VY86l75eD+en2qi37vEmOOQf14X?=
 =?us-ascii?Q?na8gGgZUEqJApwWOPC7jWjBSMIZ269AL/ScWg3F3n+/uHwsp12G+mgIPxFTH?=
 =?us-ascii?Q?aX9qhcIefDIsNsckiyT97/G2FwKy37c7bXtuytklGwjcPlPTzLZ8qFJxJYS+?=
 =?us-ascii?Q?5ftS4fsSiilAcJfGmO52lLxpTYepTAtsFIpyHwEAs0kbViWsZeFbARKVoAyW?=
 =?us-ascii?Q?NHVY83ksPFmhRSVXZs1x9PES9hW4f66tIEo9emulbFuzUBajhHym6+vdhIqp?=
 =?us-ascii?Q?yNY5EDsX0ijmMENpSw/+Iu0hOUSKQ3W1Zk332xPQGmQURDHqAv7OtFdBW/2w?=
 =?us-ascii?Q?yiNARxBNXwx9NQt1+LaGi+4kv34d7Kr9C1kIpXLWwd8KbdUMDOzrxnAsufEV?=
 =?us-ascii?Q?sHstd0glZ84mGLGIjkj0gl50fl/i32xeEOUCqfSIHHIWHIQ5MIHKmi25t1s2?=
 =?us-ascii?Q?pMDvo6q3zcWqPApVn6wpO4J2xxe6iCVVJ/A/4mk9KBHtee5tyi3a8I5+OMDf?=
 =?us-ascii?Q?gRLqtNTxx1q/Eeh1LHpvWWpC8l7+H/SaReiA3G1YCS7iq7JzsslhFS7VKzR0?=
 =?us-ascii?Q?3pAOqFWDBZhLmTg6bNPFxIhGZqYOohR48oiJVM5K7mGQMdBvJYQELRkQouVO?=
 =?us-ascii?Q?AsPl/sQkHv3sOTmGFKvna4mbzRI7H6kTOwiy6cS+ATu0lcypoxiHr+RgegOY?=
 =?us-ascii?Q?pNhAFw/2QTSC5VoDNQjHXjgIlOubuSbccDMiKUsb1kd4cgRj/MBylnuFvKE+?=
 =?us-ascii?Q?zxaTlZ1eYG6bs0grzEAvDgYJVLzmmrrNiY6Yf6vU2kFOLUSfsUMN1r9coB+7?=
 =?us-ascii?Q?SvhrPKJW1alnUtwAevf2dAT+nKz+iFxXHSHH6y43xGuaVjNbe8r7MHIO9oc7?=
 =?us-ascii?Q?QA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	iW7MAR/TmFCMBNK22NPO78fQEuiwT7EVpP8/40urW5EYGzZEKikLL2YxIUuqw6QFaG4K87tl9DvG8QVwPT4q/ljatRJgTXxXFnT07eSArjv66zNtwLiRA4V6pMLKhog4LPkbfKjoxNmUmKsW7JoDw5JPjo0LtSGqGW6nOPpy8lDRXvzy4Uek3QhwaArvWK4VryVZJHH5bOzivz2y7V4c0atHxnV6oPkGgUh+NlH19SRJYekBoQ55x79/f6lxYGCzVK+kQaEolzCx9RdzoKhqfrYVT9WtwpjtjvR0q86b+WZSXyViwI4JOeWR/shw1Daw5pfStmwiOyAyT2EOiA1pxyN867eG784MNDA8cdkoryVGUBwgHEHnWJqqDu1KQXHzAZSInqitqccJgont04cmf3CSJP94evmtwHTNpDo//BfoR/JarhG1Q2AW8ILPAs91Tu+MqsPKJpgsIrhPy20fCnNdlVzUtrEmoct6O6M55os9cNS5Z7HOySF3wB/fXvnvIXzPqCS7w5VE+81Ln1EMyc/CMmCNmkxCBB+pbVEWP/1S2xllj0yh9W9lxAjPuaN0CB5ko2xWd0sSxmHKLJaASEHu3Lc1xymtXAvU1W544Qc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31a1273e-8a00-453d-456e-08ddb9454eb4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 08:49:08.1468
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2e6q3D9Vczxzb1HOlspZVi8LGPkG4V8B9qZi3olSY2COsux1bttjxpPu/3U6FxLlbZ6d3rkHJ4v8qgxDYkKtBkRwEdRkO6uy2k2/OG/bU8k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6327
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-02_01,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507020069
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAyMDA3MCBTYWx0ZWRfX/spXoPka5+1Q SLwN1pu/I7QnQC2yzzFPY6DE4XitUReJbLU7+98JdLRPsSVKXVfQM7Rwp7mpmD7ml2TewEer490 ZriTgfuVJ9Gucr69FOFKZTm8NsxalWVuNeCwPx0A3P9ocGf491cWM6Iv+0VRzg/uwWkeaCjm2d4
 tDheARUJl+APleexc+VM079yUonB8QIdKPUu+SerqC8J5/0ivfxPzZZiTCmEIf/K5fhpC1glGiG lDUqV129p152FxcWAWQXk8QRXwPHLRboZQqMgJNiaqEsV9GTdnsHXhyeCuBAZzcPUkqYnnHcDhz GJKw00nfIIWkkQFKIFM7Mel2BmbUeZTERxMLxeT5WzAQx6eEBk0vKZ7JyMmbM5YNjiFCvpqQQ4e
 2chFrVF20Hm6jOfKUT1fo6oZvpRVuYAv6yLAJxrntlaAG+Zut31ocgWCEZAKM6NY7lqnDxHz
X-Proofpoint-ORIG-GUID: O43XPb7ZNunFLI71qDMqxidzCfXGQUoO
X-Proofpoint-GUID: O43XPb7ZNunFLI71qDMqxidzCfXGQUoO
X-Authority-Analysis: v=2.4 cv=QfRmvtbv c=1 sm=1 tr=0 ts=6864f289 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=Ikd4Dj_1AAAA:8 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=t4HjgU3YqRTIp5Dt6lEA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13216

On Tue, Jul 01, 2025 at 09:34:41PM +0200, David Hildenbrand wrote:
> On 01.07.25 15:02, Lorenzo Stoakes wrote:
> > On Mon, Jun 30, 2025 at 03:00:04PM +0200, David Hildenbrand wrote:
> > > We can now simply check for PageAnon() and remove PageMappingFlags().
> > >
> > > ... and while at it, use the folio instead and operate on
> > > folio->mapping.
> >
> > Probably worth mentioning to be super crystal clear that this is because
> > now it's either an anon folio or a KSM folio, both of which set the
> > FOLIO_MAPPING_ANON flag.
>
> "As PageMappingFlags() now only indicates anon (incl. ksm) folios, we can
> now simply check for PageAnon() and remove PageMappingFlags()."

Sounds good! Though the extremely nitty part of me says 'capitalise KSM' :P

>
>
> >
> > I wonder if there's other places that could be fixed up similarly that do
> > folio_test_anon() || folio_test_ksm() or equivalent?
>
> I think you spotted the one in patch #25 :)

:)

>
> I looked for others while crafting this patch, but there might be more
> hiding that I didn't catch.

Yeah, one we can keep an eye out for.

>
> >
> > >
> > > Reviewed-by: Zi Yan <ziy@nvidia.com>
> > > Signed-off-by: David Hildenbrand <david@redhat.com>
> >
> > LGTM, so:
> >
> > Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> >
>
> Thanks!
>
> --
> Cheers,
>
> David / dhildenb
>

