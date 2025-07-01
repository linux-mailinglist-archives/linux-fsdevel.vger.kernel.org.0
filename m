Return-Path: <linux-fsdevel+bounces-53468-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78523AEF506
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 12:27:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF7DE3A73AE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 10:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 948F72701B3;
	Tue,  1 Jul 2025 10:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Nc9vP9/h";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OI+I6jYp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7883B34CF5;
	Tue,  1 Jul 2025 10:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751365630; cv=fail; b=CS3O2wU9O6Ted7W+rqnIXMqnhHkMAqtUJxR979gFHUU6gGJZkOUwQ7Dmx1IwdKiI6EeMAxCSm3zun016oGnhprZ4uuKzGw6DYx/sJqk4gS3hU1AstoYu9jOTQt1J6EIuR+RQIy580Cx0dmS4qws9vnlUVPKIa869Z1q19v0Cfvg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751365630; c=relaxed/simple;
	bh=NZ/NgXxjY5dD3WYWjb0plNMhJag5/kQ3lemlOxdI4tM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GdK5CYCO2U/nLGqMbpdLlhbDPnhPnZhwtbg5xDHkoeAK81ryjt2t4tOMbPvgCloZiamEnPOiOufRwR0Hvrfo19B8kX19kCnzdohRqlYHPmHRDT3b2MCOYwyQfJ8pckCqRSTSo4OfjW75mNnWkkLOd7BpZn5dQrXMlxAs+vhObis=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Nc9vP9/h; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OI+I6jYp; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5611MltS023852;
	Tue, 1 Jul 2025 10:25:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=NZ/NgXxjY5dD3WYWjb
	0plNMhJag5/kQ3lemlOxdI4tM=; b=Nc9vP9/hbhQKkgoOIup2d6hJdVkQddxPYw
	AQnrlfvcjIx2W2EbMC4OI/CvJ3B5KgFvShDe8MsCOqNMVKY8VOmbIfTO8kep9nZf
	gl6/gd5oBy/6Qgcl/eu3sbubc2I3PAfsmkOgQburbemlIXeSHtKlsrBqKwGdd2nL
	ftY1yjp4w4TX3VgCbslHKHJefdb84Ot5Nw8URgaV8JnFKWnpSlWpf3BvZAO6uQ4A
	yogaAEGwk78GGJlRZZpz78HK0JjXE8stbQK68KnZUKH9R7TCQ90BH0LP7Ygkp1LD
	4bVmcpP7Yc1X+4VDsjWKs4Vuxfy9O85fYtSq3VpzACoWiPfvpjeQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j8ef4ghg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Jul 2025 10:25:39 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5619gNWi029875;
	Tue, 1 Jul 2025 10:25:38 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47j6u9j682-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Jul 2025 10:25:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lvj2N1shh0CPCelQ3jPBbch4e8zigc27i+Rt1i9hczF17/ufxHNV/bd/mVAwtWLE9/h4Dls4/AOku9d/ILDZ3ZIQyHVzdn5BWvm3duhkfGyME1ifr77amnS93DNAjzKBkDFIAr80oZDwERA+B2EninrjAmHiz8QP5cAB05uLv7fYRUO1tKopYC74WqajNuv7mInI7uK7coK2mcM4SFOywe4O2Stm5h9PhghM6TaCe5W//VvWIzPRFkboUbGhNbnLwaNNiN+bL5BwOsjW2FMPo6Jgtzesu9H8Nt4oY3wAgxV1P9+J+iX01DnfqArrpY2qg8U5eKchYkiR3IIX5gQ4DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NZ/NgXxjY5dD3WYWjb0plNMhJag5/kQ3lemlOxdI4tM=;
 b=YtAKFM3LRH5i5aN4HhACh+W7tUY0Z+/3fLtLsZOdhM/ZAyN6Cz9HMrSaLoTRkjLI3DQrXIYha8LPhCyj60zZDBJyVBC/r+95G7c5YD9cOJD+1YEuEM7dNDAcLpvg02Qx2pwIE0bT94bCw7q5Dg5PxVpqusma2HmKrAu7s3mckGwzSoooe4zxWpcO6u85WZzLky12yXIMR5G2ODWMkPRmQk6Iv4tltJyOH4Jz0K108tsNB8zUwWnARRzjF1cBCVEXNye+eOfv9PrYu40hdKxVWUOXAt954u9iwhN6nCwMQlxY8drx8vMyWXaF+hFtwtIy90S+Ffbu4uAQEnW9XGfWdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NZ/NgXxjY5dD3WYWjb0plNMhJag5/kQ3lemlOxdI4tM=;
 b=OI+I6jYpiF51+p7PXiHjBxQ2Ant31GG7gWFb7TqKdyEbKfAd83xyhM2dMyiJDqhp2GFzpCnPul+Em4PrmYoNwECAfhvFlRNeBYv+ghgUdWA+9IkaxziEnUtFNu1h8XwDNPVX73MhrJY4Ry8/EtnvQPlU2J5DB6Q+STb59GtXRtE=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SN4PR10MB5607.namprd10.prod.outlook.com (2603:10b6:806:20a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Tue, 1 Jul
 2025 10:25:35 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8880.027; Tue, 1 Jul 2025
 10:25:35 +0000
Date: Tue, 1 Jul 2025 11:25:33 +0100
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
Subject: Re: [PATCH v1 10/29] mm/migrate: remove folio_test_movable() and
 folio_movable_ops()
Message-ID: <1de3e771-31cd-40d9-a33b-729be19dfae2@lucifer.local>
References: <20250630130011.330477-1-david@redhat.com>
 <20250630130011.330477-11-david@redhat.com>
 <100ed589-d3cf-4e31-b8d1-036a8bf77201@lucifer.local>
 <3887c07c-db95-41a2-a3c6-c1199005cdd0@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3887c07c-db95-41a2-a3c6-c1199005cdd0@redhat.com>
X-ClientProxiedBy: LO4P265CA0153.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c7::16) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SN4PR10MB5607:EE_
X-MS-Office365-Filtering-Correlation-Id: 378f9055-79f2-49fd-b198-08ddb8899db1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LBs2Rs4v61gDZTz+H6vY67hmD041goiB1dKntHw4vMG/dFSar07Zitfsz3Ke?=
 =?us-ascii?Q?YXW9Opr8vFNu2QAfnp6h3ON8rML55oGtcftKpX8gMLBzolcWzawKTEwrCW06?=
 =?us-ascii?Q?OONwkShBzv2waDh3+tCm+/P/zFtL9KF1mIyVvqhmDC9T3Wdi9TxlyP+pKXy0?=
 =?us-ascii?Q?fkteCD/G78uhAh2FxIx1slKxxcQci7s/P2W20cG+hJK4BncgMrP4OnqzThvw?=
 =?us-ascii?Q?x5FUNdsDCpO75ejDlmMU28HLPhQJTrkRqkt3WDmfjQJ9yVOZBDaDYYiRL3es?=
 =?us-ascii?Q?7Dl9LU+lX7vYz5ySt2QekoLAFF+VXMSOGRb18QkBbxKsV9wS0Uunt+gLPMnu?=
 =?us-ascii?Q?bPLLqZt3QRYhqHZER83T+A0DDH8YCstvxNKiqQ052oS8zCqUHDbAnhLt7i8D?=
 =?us-ascii?Q?uhjbkuSEWDdvS1BPnroUoHzmNGZdI9VjcJbibv6Ixq1fgoHrpcsP0NeBzuIf?=
 =?us-ascii?Q?l9Njoei+6KUuI5VZuVuM6f3878e46HnDX0F1HYZfYjeqGXx4nhIazFisF++Y?=
 =?us-ascii?Q?O/li0qN1td5GfNLcF5ruwGRh0hUJre+TRyuny2h8fIuPwBfw4D4GzEKPhisJ?=
 =?us-ascii?Q?0uFb638fLs6LY95Vxsh1YooE9hNXmrml/BHAdUrKNCXuf2zxubc2sQPixTc0?=
 =?us-ascii?Q?veOKkhqkq8wPfJMyJrVhyG6ypHOXJKZ20mRpm8663VC4DwrYHhDwgOdroVE3?=
 =?us-ascii?Q?ZrPo/top8OirDpfx42gd9QgK8lLv7pA2IwD1BHPDjJ5glO8KvGgyyx0YgmIJ?=
 =?us-ascii?Q?sgFHRf7ECtSP3bJG+pedlXCBpfyR1PTfw1OXugNQImqra5mIH0j/l/e+bJwJ?=
 =?us-ascii?Q?SBLGlqrPFB7coBgliCVk+gN2jZZaXis+JJkCLtvIfyPMQyHFAHB/Z1YjmW9o?=
 =?us-ascii?Q?8jN2n/iVcZ+wEI40tmeTFikdSE17ZQxpW2+kb/ThbXHNkncYKC/cQlVAID3i?=
 =?us-ascii?Q?KxBsnhkD/t+9lurkUYcs7GA1L4wtpWLFMBMQpl4kNracPgx55u2fdUNjDdQJ?=
 =?us-ascii?Q?CFS0L1E6UyH6Xw+XW/vkBUwjhJ62H6yh72xeXyydDF+ei31bbhTYlPDuPnXA?=
 =?us-ascii?Q?xAGiIm24XkC9ET7cPCqPNW0r+yxrL5lItL+plCnRs7x6oZnBz+Kue3mHPbSL?=
 =?us-ascii?Q?UAKzS63pIh7LBFmEiUqmS89CRsXmAAhHpJqjczS+GjLex+rIB6WN2vcTRTK0?=
 =?us-ascii?Q?lt/+JT2X0CBmZHNTHgcLp6XRQ4+nNSaFLLnNcuLdtL5qXzVJHLU92iktBfb1?=
 =?us-ascii?Q?6WPOhKIKtwHVXJvaTbb3BUfXQ5K22A58EdCAz2RzFcgOo5JnpzysAsNrKTFh?=
 =?us-ascii?Q?EIGMSC86b4th1L8/iTvmeIO6sdPVSl+7MoKXOQP5hHn4C11t4H+L7JvaWuc/?=
 =?us-ascii?Q?bNkgg8FkNLpglwtCaWKw0MAF6vycV1phY3nUkOt6XiHIRv79U3FuF+9wbxMp?=
 =?us-ascii?Q?7lUvmKOsDk0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+lVxVPMkvvh/LDu5c+Q3f2o0Fz5WsPlqBjFaC1Z2nNH+2/VTt64whDp34aNu?=
 =?us-ascii?Q?8vcyJos1PQqwkNLouCImQnTwVQs6uCd3sQSisj7HVQ1IvC+rG2OuWoWQXc+V?=
 =?us-ascii?Q?CB1HYY1LJh8wNpT5BQ83/gyW5iobuDI0VaY9ET5++paMIZWEc2+6qQm2LVgi?=
 =?us-ascii?Q?C9ScDrDjfwGDGi4UkqkdrMYerve4RlUsxQMPkuCbupqrbMyb2fI97xLLrvp6?=
 =?us-ascii?Q?i626K2d0++JjeDD3W+3m2r3rb1WidgoQGDovATKpYpLF1Rgiehm8CpaDvYTe?=
 =?us-ascii?Q?qhIQmzP6kYRNfF0RxTGL6YPvNUtAF8kGkafqnytfyrpaDwAQDpthPL98t8Mv?=
 =?us-ascii?Q?m472AixyUB+1P2/LHxpvpRl3J4VqIGyOCAktMm9jETxgoUM8LFhwyD2W6NWW?=
 =?us-ascii?Q?Vz1La6ZZQIb1LEBBq1EsRADOiNuI/lbKPYz/5hmH42HvdztofNj5sbhLKQDX?=
 =?us-ascii?Q?mRUqOp/W48Z7x+dJrFPnW9gowDxL0jl14Dw3lUz2rHV6iTc9uHSGRoGM0U/5?=
 =?us-ascii?Q?PgGpc78IYJ6qzJ7wFBp8D3QuPqtsDM6IUlBYMHTlN0tk6X3IsZvEkWtPYA2P?=
 =?us-ascii?Q?rg8x9yfjd12C4oroIXiUxLrL27CIrSIUboTSfbqCTT8KUkLXKo4XhRRC0P/L?=
 =?us-ascii?Q?SXsO/xjHjB/iXCNjZN9de97jPpYNgeFB+/o8OnizAZBkBqCCojyV0OSOdkw2?=
 =?us-ascii?Q?ArfalDs1mSAH2lQuFJa3O5zvPBzzNBIsjX3IlF/nNLTFyKu4t//xz0Nw5K7c?=
 =?us-ascii?Q?cJ2u9KLHnYVvfOnnKbfAMnR68x5OAkaNeU0LU6Tr+n9hJdxBnyDdOJUO/8tD?=
 =?us-ascii?Q?LEqSux6pK6tJjGE2MD/Zy9IC5eKiZhh3KyvlJ2yttN0az5mVfNmIYWAO2mgZ?=
 =?us-ascii?Q?ZglhoJ0p5okKgtQN83VjvpsFVzE0ACkzCiZXZpRXSmmJoyTun2uq85Fg2ANO?=
 =?us-ascii?Q?wASM7TzG37eUr3co0rjgC2SFZ5ZlezZ91QEViSvQ8fGrr30YM5tRKZmJT83O?=
 =?us-ascii?Q?IyV7o3JXoK0gBpAcx+ExvNWt/rHNXsB5EQFYQlcEgbqLzsACIhgwEbTWKNlC?=
 =?us-ascii?Q?39XipCnJ3GrkxaOwBmIodcbnJSUZbFwOp2M4sQ1W7XOzAJ3RvFdTfqDL4lFO?=
 =?us-ascii?Q?/TiaKcpQ3hucdU+VsWWaWwf7OS/DL4aDYysZDuqog6C6T8qQRXYsAOhiNivG?=
 =?us-ascii?Q?IE6NTNifILlxdyg9J8Bm5BajXSf1mg0o3frJXKXoaFNgMzGYbFzJBok75Cyt?=
 =?us-ascii?Q?Vz+PDpkIvYfXuxVJmeXYJQZmwTpJBPLKCD2Uy/rz3kOdA5fH8oswAZIz+zin?=
 =?us-ascii?Q?s6vkJIqLbKXCGxMpmVE9p01rSe/Zo/69H1okxVs8hC6GzSD6xmu0rS5mG9OE?=
 =?us-ascii?Q?QXV3kpuRB4wl4TvASLbRVlqk4BT6vsa4gEWmMwsEqt80fWX5IUefBJnTFnsY?=
 =?us-ascii?Q?fpolLGFWBESEPe+qzL01CF+5HMkhyc3lYKi1jc5ix82XEay7iRJ4epjQm6bE?=
 =?us-ascii?Q?7UJtimnE/uS/1PD5GXR0nsMJ9uvTz1T6L+tE55MTuakl6UerSDVW5GoVfnB+?=
 =?us-ascii?Q?/+9FKSTyOeUJ/2R0/b7x3tRHQ/eNspMrw2fkBM6+QyK4TL7DdNnM5dXNgSZO?=
 =?us-ascii?Q?5g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	p9fvgOULnO8Qp7Y3FXsX17iJj0k9jUpq9lWs/Y3Jimz9z7IoyZi5BlSfU/vTyXFdmzb/fDcBIzR9kCOLmnX1fUscyaLtdx9V0oZSKhCYcV8R5iJmte1oXyUnuNbnJ3e042PJIMmdLucbS9ipzYN5iysfRgroQaDsbFN/T0rzk2cRa4tZauLq3pSBBiwUL2jjNEx9+tGTUUC3gnR+iW8y4iUsbehvgT3mdTGPkkjN6QvWlXJ8vHUD9aQ4bujCErKP5r/x4FkMf2qvwzMAWK1TOIz//LJxbfnrRsEFmhiDoH6LAfTk/io37xJIrDsxFBQpet+bCe5MY0oCSpU7ThTd3ioJF4Hx+TO+eCjhnxKMJ23TESWRKLKlpxKkePGx2fZtERZCmWg3SERsn4I2koA43StYzsRY7kuG8zMoB5GitvvE247onEVsqaXIfAycjSEChvQuuy4zCk6bKBL2Mv+sON06biU/xKdf0f9h12xXzJ01vKLqROoZ05xdl2iyIf4q2dkrHDchHyZRXIN47VqNMrkplh+Adk0LAJ/rwOUwD1RZPi32dAU9k8RQNmNj/lAiggLB0+dR1qTa9PKYm4X0+dcUwq1Bhs6r1aFA2fEvs9A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 378f9055-79f2-49fd-b198-08ddb8899db1
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 10:25:35.2844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5V3TeowHrCnb6Ly67qb2WYDx0v59+yykZ4cr8zSzhknAYyMem4k9LNirwBn4reUaEuffadJbj9172kigg+RzoCqn1/Zob+fMRYNLRCFdyaU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5607
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-01_02,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507010062
X-Proofpoint-GUID: 5zmJVIyAF7LdjDUOCU6uKAN1zd-A4w0Q
X-Proofpoint-ORIG-GUID: 5zmJVIyAF7LdjDUOCU6uKAN1zd-A4w0Q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAxMDA2MiBTYWx0ZWRfX3a5ZzDUKXocN bWNHW+WW4XG7rStXCtWxidbipvHq13zRtoX5NV0cSNyLrQApw6tQpndSTJEbizOr8fCNgT1a2qj NwL5sX5hZv2dHm8OI0yFZnakndZ2MYe+27P/gDxHxIUJZVjocUC3OO0YQfTHyPbgpP6DmCxG1tr
 dEzfyBKlNzejrO8aieUD2YiRfWPfRuEucv3EL5TbEZap46iif3Cth+ln+7pSTSM2FlzYIFNzbhS jpJfxMUlrUEkF+hj+jGqz2Z0zBcm33Z3xovrZTPc5QXoDgt8zj87k3KmzHF08JDe7UKy79vYl7r NQ8hpR90bW7qgjuEurW91oB6V4TOELy8NX6Az9TSG/kIwvzZ7mu3KtMdNniscB3D0V+u4Vkg0Ik
 K2jCA6E3NBBKw4OvshA/d8rSLUCNRdLpvZQ8LMh/bygYqaw5iI4JMO+OUZ1QMySB03xdrn4Z
X-Authority-Analysis: v=2.4 cv=ONgn3TaB c=1 sm=1 tr=0 ts=6863b7a3 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=n1Fdo-wd605SlKVsAZUA:9 a=CjuIK1q_8ugA:10

On Tue, Jul 01, 2025 at 12:15:41PM +0200, David Hildenbrand wrote:
> On 30.06.25 19:07, Lorenzo Stoakes wrote:
> > On Mon, Jun 30, 2025 at 02:59:51PM +0200, David Hildenbrand wrote:
> > > Folios will have nothing to do with movable_ops page migration. These
> > > functions are now unused, so let's remove them.
> >
> > Maybe worth mentioning that __folio_test_movable() is still a thing (for now).
>
> "Note that __folio_test_movable() and friends will be removed separately
> next, after more rework."

Sounds good to me! :)

>
> Thanks!
>
> --
> Cheers,
>
> David / dhildenb
>

