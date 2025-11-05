Return-Path: <linux-fsdevel+bounces-67203-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 922C4C37FD6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 22:25:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D35D423CB8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 21:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775AF34DCF9;
	Wed,  5 Nov 2025 21:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kG40tyw5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ohdROZKI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6FE2D6E53;
	Wed,  5 Nov 2025 21:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762376977; cv=fail; b=odwxi2kn0sY7Tq7i0L2p3+turh6/xjhtzisT/UE1LWGAnDdVqgerhwQUrFCckS/tQEZ0IAcTGpRsKmolyhhseyaw9OQ6flZkX14X2QAM4pN5eTHB/EZVd2uJMGNvOYaY/vKmZyNMQa+F/UtCtSani6htjevIFZUOjHNlcWrlxT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762376977; c=relaxed/simple;
	bh=PM5Z2Pcrb4j8qHv+xJTZthRlQ1hCSvWXIgNp3swr5T0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TRrut1utnHyqALBm9mxLjW2N7JlLBfvBnjmdQTUnl6VQhFseto9WYJ2pa/OgtMo3XTXihMutr0He0/GAwt5IzxBpulVbxXTCVT8WGa32F53nnj+lS3XqwBulrqpW1ftwfsxLOX09rk0QUoBcAYidE+TGIhqtDb2vJ+9KV20SLiE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kG40tyw5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ohdROZKI; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A5GnNxG007109;
	Wed, 5 Nov 2025 21:08:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=PM5Z2Pcrb4j8qHv+xJ
	TZthRlQ1hCSvWXIgNp3swr5T0=; b=kG40tyw5EXfw280rUyheVeIMuYK4EfwoJK
	+tx6RDjwZZI8SFzA+Rxs9JQ3xXACkgZ8D4S618+FBSdiBYIG6ezxQRnHOHGk5j/a
	VvXu5wbVtvuzGMsSC42WJjD5G7O/V0HMEy2Q4osOwLbGYmpH2lvuX+kUAt3t+yKL
	jzKgW4WvoOUQjVRbE8F6aN6elBzWkWHiM0/v3/NV9W9mySCZ3FHmXH+T2eMxZ903
	4k4iPW00/n8zjAaryTnRTZh8oMwYczuodCKyqLhh5xBdQ4tSzVX4S/vZ1AzMbW0Y
	6YCHb0QGZg+4KM0BUI6DgpsJ7fm1gm99lpNoslq62v7YT7lVtzGQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a8aejrhxm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Nov 2025 21:08:34 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A5JsLn2036162;
	Wed, 5 Nov 2025 21:08:32 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010014.outbound.protection.outlook.com [52.101.85.14])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a58nnbgyr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Nov 2025 21:08:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CyyDBuTPkCnIQjOvaBrwDzsk1Z8vSLrNWc+xj2EPJyNjnOwiEDs4aw3NOk03dr1vCnXtV4d1gLdYpmVdVE5RsgDvqntqPz+CVaLMfDTSt9c4fDVCvnajaQz2gMStH2PMtEIszc2Wy5+fNLl1CA4atM02ZHmIfJX1vYjnXJjDEMu81KkHH3jBI9lpAb1uujDzhM1ZQLu4UHTHgdWXhVF1hBoOIR2lfHdHX0+ajjWtWtcoaSucrHf1lcbUKoWeNZh586+p3cQ/SLT9gS4egJCsuMTeHUZ0Cv1QIszdzo6FHZwaCZLsLz0c4E3K9rNBP7tFmPy1vyt89FzPSeYQtuxCjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PM5Z2Pcrb4j8qHv+xJTZthRlQ1hCSvWXIgNp3swr5T0=;
 b=ESm54ug6Be0iuZ7fB9xm72/XG4k0W6RGGhiAg8imqM0vk6eyROezHp3n48wdBsnVaqEYlyQva/VfkbkZx26/Dvt+MqRABqaj/KaskIytPNkYpDY14mQXisuybN7ZWwSqjGU27imsoSzA75fL4zca57DG92bZcCnm6iqTnYJIMaZVxn1xj0lWbFrGEM2WBV0UOx9R/ygsLy/px0fXSbEYHtkG78BugcUeRAo9JOb0JlFx8byIFoo9XCXEtNsCRbEI6ufcfSc61ZSU+o1yXQ7pkhDA3IGau4/KSC13WP4dumSBLWb+SXGaSgMcz2xvcw0ZBKSC4WyF7KlsA9cF+MMSUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PM5Z2Pcrb4j8qHv+xJTZthRlQ1hCSvWXIgNp3swr5T0=;
 b=ohdROZKIIY4xb6CoegrOjnH9QQ2qid3iSRpDli1hdpdcZhSY84P8clI9VjcPFddxMH9G6LV3ytbOnym6A9dn+CZLtAbGPCpl6IcZTlM+4NJBtZrKS+oBtDjwpGWcjublfxdxRDN/TNmJXnR4onbLSqNe5RuEWq5lZr+Xcd9S9TM=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DM6PR10MB4281.namprd10.prod.outlook.com (2603:10b6:5:216::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Wed, 5 Nov
 2025 21:08:17 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.9275.015; Wed, 5 Nov 2025
 21:08:17 +0000
Date: Wed, 5 Nov 2025 21:08:14 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "David Hildenbrand (Red Hat)" <davidhildenbrandkernel@gmail.com>
Cc: Gregory Price <gourry@gourry.net>, Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
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
        Byungchul Park <byungchul@sk.com>,
        Ying Huang <ying.huang@linux.alibaba.com>,
        Alistair Popple <apopple@nvidia.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Kairui Song <kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>,
        Baoquan He <bhe@redhat.com>, Chris Li <chrisl@kernel.org>,
        SeongJae Park <sj@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>, Xu Xin <xu.xin16@zte.com.cn>,
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
Subject: Re: [PATCH 02/16] mm: introduce leaf entry type and use to simplify
 leaf entry logic
Message-ID: <2d1f420e-c391-487d-a3cc-536eb62f3518@lucifer.local>
References: <cover.1762171281.git.lorenzo.stoakes@oracle.com>
 <2c75a316f1b91a502fad718de9b1bb151aafe717.1762171281.git.lorenzo.stoakes@oracle.com>
 <aQugI-F_Jig41FR9@casper.infradead.org>
 <aQukruJP6CyG7UNx@gourry-fedora-PF4VCD3F>
 <373a0e43-c9bf-4b5b-8d39-4f71684ef883@lucifer.local>
 <aQus_MNi2gFyY_pL@gourry-fedora-PF4VCD3F>
 <fb718e69-8827-4226-8ab4-38d80ee07043@lucifer.local>
 <7f507cb7-f6aa-4f52-b0b5-8f0f27905122@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f507cb7-f6aa-4f52-b0b5-8f0f27905122@gmail.com>
X-ClientProxiedBy: LO4P123CA0191.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a4::16) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DM6PR10MB4281:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ce5abac-e42b-4277-72c0-08de1caf70e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?biYkO+z9kMdYvhNaLkcWD9nP4/r6mMH4orO9uPIpPigPDyPlsDL7mTJB3pTg?=
 =?us-ascii?Q?c6ZU7H5P63nErXjaXTd/vA2KVCMuIwzXy/mAQbZjZpK23kCNWn1Eay9Y7/MI?=
 =?us-ascii?Q?TU4fg/tRjKRWa3G0T8eI/E3C4qm4rmVWRsLhd4s7sq+n/NKwEQxyR+nLj5Qt?=
 =?us-ascii?Q?rg3p2+oxS2hJOJLwMJkJccEyXIZqoh4PfXPrASPVULmzLWzeIcVlhW0T/VWK?=
 =?us-ascii?Q?MpZXc6czotGeLamSv6GwMD7q83D5pX8kj0F+Gh7c3a3JxdcD3aWeDBezILjp?=
 =?us-ascii?Q?EiJ149B6LTaI9yEQ43zauJkXIcIiRDDuSJN0VBsSUPCg0MP3tul8icC2aWfI?=
 =?us-ascii?Q?WosxUIHkMcIuD+Le1w89kgkNIzh8QdurlM7cbKiGpGflc1D+aocF8a3M1L22?=
 =?us-ascii?Q?rC6GqMlu85xH+vK9kM0e2/PaGy2bAJw1/QmUL0Kz5rhkx5axjmV0EzCyWfzV?=
 =?us-ascii?Q?3SVpmdnvOZbZIvTGA1dryzBBxax7Y0rE8A1QB96yYUa9iahV+P9uSwm15mxo?=
 =?us-ascii?Q?ZPXpfUn4ILnkRY4ghsac/AQLMyyiZgxndg/EQ9pV4rWMW4F7uKX37XvWULGy?=
 =?us-ascii?Q?AC+VpsVtq3AVAAKcAdCkAFZ7uKZ0Y5tWebaajkH3MwrA/Pqk1wKUYaqcrYWC?=
 =?us-ascii?Q?6GI6foOzF+eb1zSs7esnEaFqNQP0rFMbRqbbdxS8/VTCcM/pFy2qckwlera5?=
 =?us-ascii?Q?6Hqrrr/qzUOEqae9brT3Jog8UYR4JJeWgg6EauZRUoeaK5PDf/xRQdjERpma?=
 =?us-ascii?Q?zf5nzYxyZ9t6czppYhh3hDOkSEGF4GN3CufENO4HUTH5qzvRBHMlYgpx3Add?=
 =?us-ascii?Q?swKOikX+tK5N2scdu+gxlUhVOyVg2lkDhdK8BWQPa7PW3dc7AhixV25yLdS+?=
 =?us-ascii?Q?CoUJvQmQlKY8c1qnKFvSKNt9HjqXHWDxEmBNKUE5N0DA9trXKlXS+erShD5m?=
 =?us-ascii?Q?4B1U0Co1TMsMMeCug+hCUn/+uD+dWlSzp10HmmEwcQJRmBK7ZpTiI429M5ol?=
 =?us-ascii?Q?la3adQm8xGIcAWcp27rHqjpjbgos9HnzoNdRJxti0StEcnQttZdK2uA267pC?=
 =?us-ascii?Q?7lLwUUs2BpknpIkY3JL4q1gz375xv+kTiX5cQKtq9vblnxZrhj+6kMYX++w0?=
 =?us-ascii?Q?0X+ubYcE1Pfva5Unaj8lGSyFW9RGVodzqOiCi31aXNTLaiFVClGCOvqPqVmP?=
 =?us-ascii?Q?8hLektoSD+8bJeY0iS2LDb/qbyR8YIXwR58lB7EPLaPqigdqVuBFGYa7Ba2X?=
 =?us-ascii?Q?X5A2DtzcoX8Y7mhwHwBPQiZFh1dAzvWITWw2y7xs7Fx0twkWTEuuqP3U07vr?=
 =?us-ascii?Q?zN/qUxTnQBxmhUdPgo/5JoHBRxQ/3q1dlV0v2TgaQXzp0pM63Lb23yhLBnWx?=
 =?us-ascii?Q?Cc2uTDv3iWp/lCtAw/yM2ald7ZONr30WW8yNmyjXwq9lA2uWJei24jW4dIqm?=
 =?us-ascii?Q?2R555ijDAWCdAIxxsuYDoFekbOoLFAcb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?elNWiLWTwovt/rTawk8N0uNNv+cYvWPvtEYo0ag4Yb5jLPkQVnXidj7ZWks2?=
 =?us-ascii?Q?T9sqEJ5RIdI/KWhMYDLptB1sX/tdLkCXC9AFy0abjpgWfEPo7hiJw6ppTaO6?=
 =?us-ascii?Q?OmZlnR7TXQfugyN74KvLbeQEc0ZOkA/WMPkD/Xe/6RWKPsFoGUVqn1MNLt7k?=
 =?us-ascii?Q?sgst7OXnqnm+tZCqHhDTHkm1Nf/JSX9VlT2rDzxG9tsT8y30/t+dyqk/e3gO?=
 =?us-ascii?Q?ySIwzz1+qCoC1QM73Bn5uklPG3L0mAz3vf+wcHfeilaFizeLTRpvNq0OpsiN?=
 =?us-ascii?Q?/F5OremgfPIIofhSUba5fIWkT+0a5IYqC828CFCRr7s5M/s2JzJf7hvID84s?=
 =?us-ascii?Q?i3DWHb3C210hl/zIlUNeVWxvqNdFit3KHATFNWBiyhbz/Z2l4tIcVp6i7/1s?=
 =?us-ascii?Q?4yX9CO2Eiq2C/y9uc3ZYHkX1PSvFaY8g/Di8/KJ9mrqMreCvzyqBPe2KJf6T?=
 =?us-ascii?Q?2kzjNWCmgmaqgPl7fmd7oCcodzH7908IHZ1yd3/UCZlcvO0FlGsoom5dLPKi?=
 =?us-ascii?Q?zXEc3xXku4ZEES6UMUoVb+vnK3zkSNzQ3dTAuWL11GyNZ6vC3gUpp9yyY5+c?=
 =?us-ascii?Q?NRDVwHFcjk04RxUZozFqY34rZVMtDVPfkpxtA98ggSgd2I3Qe9HbJDLNDqvW?=
 =?us-ascii?Q?2HIxkqPGnpOmtKiYfWIVIJexPUBsmR6IZ91g3Wy21XDZyXZ/FcqLAmgM7jwZ?=
 =?us-ascii?Q?iG81ewtC27EBDmX/6owWHmawAVvpqqxdfrXLTVtD8g87gcfUu1YXZRdKhADW?=
 =?us-ascii?Q?+H3S3zMN+0q/xyHpnxUBS4i1nV3z/uWt6aj2SQ645lVWzMyvhnhFBTOjMSmG?=
 =?us-ascii?Q?xGCvO0EKdYA5moloHxEj6VgGAmhQfwtv9HpFV2SW96k4gLWAsT4NpNleu56I?=
 =?us-ascii?Q?4fVFdXvL94m1O5sTSVzwJCMkZziGkle8npPfFpLF83lNY+B8emRfbjA/UTvS?=
 =?us-ascii?Q?ULnY2DkD4gEYKaWPRn8QNJBZTkff1pGi60I4s9J5P25BFPR/sNM7ADeVSGAd?=
 =?us-ascii?Q?oLzWOXULdr/9VEWH5hhe0J4+C+DvIpYtKBx5AvZ2LtlnxeBtpZo7f8Hw1k5r?=
 =?us-ascii?Q?VRS8PFr7G4Ua7Njnc0iogdQb4lJvR2td8yHTcK4WIz21bFTxOYLUFRY2Jjgi?=
 =?us-ascii?Q?ZpdQ+w32YRccgSa8EmP018NNyENBBsunFaizkuBI3c6QJC125YdcANVYCed9?=
 =?us-ascii?Q?YF7jMiAysJH4hCcXFNFpkdkGEFdsYVCEbBGT7VHwhxdv6tmCnMy3BHUD45w2?=
 =?us-ascii?Q?5yAIYYBMUaIZpK+S61HKV0TOapEfrNjlHVGuVKE0AHHLAvj7oIo35RpPKgsv?=
 =?us-ascii?Q?TOKG2zJWlbgpx358rOsRovF/rUK/mYq0tytWsBOX70tmqHNK3wJIGvJbeKuL?=
 =?us-ascii?Q?vDMyWeg59L5yVXwiW3d7fJ6aQ/glz+Fp+oph0dv+4GfHIcUSsP4fB/64yR3C?=
 =?us-ascii?Q?68vEJGQJ44bYfxDlqujBY8TeIGna81sSGz3N9ZRqim7E7MwY5Cuzy5P1Vpkt?=
 =?us-ascii?Q?Y0KmWwiI4lBVQz5M1FR/Y/SOIBwCIJA7WZnI/UQVuakqz4v29k35r9t1e4j3?=
 =?us-ascii?Q?FtZ5u842VtIILo+jQzq7MJ1sprFaH0lXWlMvi5jjYzEJMK82XdhpkQYfZ3mj?=
 =?us-ascii?Q?HQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	u/YfT+LVU/VMU15xzcMfVgmygibw2TpWvKcM/IvYm+aOut2jPW4SM4muGKLW+b0920SnMXXfPnPhZVrBUlU3oVKR/oKqb39GdCLo+Ku677rcvivaRZ/tPMEFtTXmju3jzW9axKzvtDtd2Ad8Nl23NSWBtQbRyyADW9l2lvjIf8MDcMnc/Lfee+Np7MNbexSAcwpCzvD4BbwcRoPccqsME1DQHecvHAXbvVJYR2jnnKE5xh8IDxmHzmJuI4wfWRTkD7GLQ0oEES07jgDlGX2wbmq7AkaUV+jVnE+BOGfLWWihCQYOzAqtrSHlDkqZegwT5n3xO9KJTzqyl0BMtNWsS7b/0KJZ+l3MvxlYhZWwIqIIgJ1EnTQ+4GO8w/2N+9Y5YUzVrGUaLBlFQ6KFWLEAxB5AG25P4+zlMj2ymd+f83jDt0OVjRP2L02PVJhf8hDhqrTvGOBtfxaP4EBYKWrXWHKNc3WLqwuLyPX/rGFMV5is40tdq7Ol75hayhAeVx0J1t9eyw3n8ndLJ+Fz0fjrgesFOc60xtIi1jTjg+1j4VzjtHtKszBXi30W7UMZqDTTOPnVLhoccbh6r5h641a80UBG0CSYEY25tMinADXKVaA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ce5abac-e42b-4277-72c0-08de1caf70e5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 21:08:17.3899
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7vHgwBzadkqgxRS2sypmbMd9/K6uUF4tFlMHluQTGQ9Bwv8w1RFVrse6BYZ7/3L9qD/ht+REQrtHUNIp1eKBMnbg0DTm5ofLP9n6ryLozok=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4281
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_08,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=831 bulkscore=0 spamscore=0
 suspectscore=0 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511050166
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDEzMCBTYWx0ZWRfX1SR0ABc76tnr
 0aisJHn32eZ0Xl5AAXiUPcFXV5zqrpfiypNPLaFjSS1rR0VWVOX41skt5wVt0o3y1y9q3wZt2ih
 e3ZpI5Gg2Iuvlzy91rrGFMn+8vteB/R+kufpIO/iph0wWZN+u8341h5wPlXob/ZA/HybymKsve5
 +BLi/y/iuJorBNN6h912GUmpVgxv4qZqz9PxDS0XF+yO3i/iDTieZJqFSo/KteGN+/eJiVezS80
 2c3Mq+HQtZY43fhL0tGqGptic0L3P5Poa6nEaKI1WtcQQ+T+bfAWHB4yXctngi+u5RrjwGKGeFP
 hmRDIoMkrjV4taMhLq33i147CbgL6hUjQoWsEIZVz3EYWTtKz0HVvlpL/+2nIH94ph3zMiTQUTp
 bUyWUoqBADDZstnWV0Y8uJCycYQfUeR7MftTB4Fxo66Kmob/rE4=
X-Authority-Analysis: v=2.4 cv=R8IO2NRX c=1 sm=1 tr=0 ts=690bbcd2 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=XzwxhD6rUGm4486-rggA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12124
X-Proofpoint-ORIG-GUID: L97tNTuRtMqK_qIhJ4Vxjz4MC2_j4BJa
X-Proofpoint-GUID: L97tNTuRtMqK_qIhJ4Vxjz4MC2_j4BJa

On Wed, Nov 05, 2025 at 09:11:45PM +0100, David Hildenbrand (Red Hat) wrote:
> On 05.11.25 21:05, Lorenzo Stoakes wrote:
> > On Wed, Nov 05, 2025 at 03:01:00PM -0500, Gregory Price wrote:
> > > On Wed, Nov 05, 2025 at 07:52:36PM +0000, Lorenzo Stoakes wrote:
> > > > On Wed, Nov 05, 2025 at 02:25:34PM -0500, Gregory Price wrote:
> > > > > On Wed, Nov 05, 2025 at 07:06:11PM +0000, Matthew Wilcox wrote:
> > > > I thought about doing this but it doesn't really work as the type is
> > > > _abstracted_ from the architecture-specific value, _and_ we use what is
> > > > currently the swp_type field to identify what this is.
> > > >
> > > > So we would lose the architecture-specific information that any 'hardware leaf'
> > > > entry would require and not be able to reliably identify it without losing bits.
> > > >
> > > > Trying to preserve the value _and_ correctly identify it as a present entry
> > > > would be difficult.
> > > >
> > > > And I _really_ didn't want to go on a deep dive through all the architectures to
> > > > see if we could encode it differently to allow for this.
> > > >
> > > > Rather I think it's better to differentiate between s/w + h/w leaf entries.
> > > >
> > >
> > > Reasonable - names are hard, but just about anything will be better than swp_entry.
> > >
> > > SWE / sw_entry seems perfectly reasonable.
> >
> > I'm not a lover of 'sw' in there it's just... eye-stabby. Is that a word?
> >
> > I am quite fond of my suggested soft_leaf_t, softleaf_xxx()
>
> We do have soft_dirty.
>
> It will get interesting with pte_swp_soft_dirty() :)

Hmm but that's literally a swap entry, and is used against an actual PTE entry
not an abstracted s/w leaf entry so I doubt that'd require renaming on any
level.

>
> ptw_softlead_soft_dirty() Well, at least I would understand it.

Yeah the naming would never be pte_softleaf_soft_dirty() anyway.

If it was to exist in softleaf terms it'd be softleaf_is_soft_dirty() which
would be a lot clearer.

The PTE-specific functions implemented in leafops.h are prefixed pte_xxx()
simply :)

(Other than e.g. softleaf_from_pte() or softleaf_from_pmd()).

I think you could find issues with any name, I maintain softleaf is a good
compromise while remaining readable. :)

Cheers, Lorenzo

