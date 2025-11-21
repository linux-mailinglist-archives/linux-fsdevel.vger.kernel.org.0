Return-Path: <linux-fsdevel+bounces-69459-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9359BC7B802
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 20:25:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CCE154E3D66
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 19:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 702852FD1D0;
	Fri, 21 Nov 2025 19:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="l+J2w9Sj";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="K9QTIgB3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6A223EAB8;
	Fri, 21 Nov 2025 19:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763753139; cv=fail; b=dp0k1UxUIpHrtduhqPOqQopbaPR0xzj8D91PwYFfVDtMR6REjz4MiB/h3ny53qHFeptIU1gE7ttcb0Zdsjr6o3Pet7AsZoY+CW1tAoUVdmDNRMpr4eFEUpUU1UeeYQO4tSivWYLVa1UE128PixbDy/Kk0BNHzfolDo9glfx3r18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763753139; c=relaxed/simple;
	bh=SPRn6FJOuX7p4iDNjLrccXCt5meyVe4+60XvDsSJr10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ndWpv9Wv5FKPfo5ErUsvOyS7lRx/tSDiW1Nk6EZ8dLzg/wiNQRkT7BnajMLIlTrLWJHTd2Lk8Qm8Ht202b+MaysIyzYvKUFC4QU3biknnPyGG/wcs0lL01I2IP+Edzg9ocUjnr2sRAXHp29bqypYdMf+BQ0qNMwf5kIGlNMsJhw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=l+J2w9Sj; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=K9QTIgB3; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ALEgnVv020594;
	Fri, 21 Nov 2025 19:24:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=dm8PmNQFcy5lflCIiV
	rrHgJVW42ybv2IIGuV1pgT2Jo=; b=l+J2w9SjEIfImKXUlpx3Xi4vmtllLq0ipz
	7TYTajOsSmrRj/qiJ3q9TMyXvuLixGB9ZGCi/rEz3xUZVExBylBSsJaan0fL3jIw
	wQnc4vbagU+OKNmjVNVonwuQ2BOXgISPWu000AwQ3ETOphJnQ1xXliAwS7ZfRZbq
	ypt6G/z62L2nvJOxMf/tkw/qUicqThBHbkGyTZyzBCyREy3bbhWzEPB++OGqchEV
	i9Z2N0Vt2+WPXYKM2mAV6DST8G4Ha0Tgl7VcSLB8+S8xR1aPwZKVZRRuRds0y7S8
	cEAT8PrUE7qQ6pKG2qwt9qadLSEL/l98gMn2v8DytkU1WuhzYEMQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aej90cejb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Nov 2025 19:24:03 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5ALJEIWD039893;
	Fri, 21 Nov 2025 19:24:02 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012061.outbound.protection.outlook.com [40.93.195.61])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4aefyrbxqw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Nov 2025 19:24:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=orgBFC6QXpFt7YeUjqH8U7F3lZ0mtWwCwt+PlC5WF06Hm12k/xd6TGRwL+yOJAszXQ9mku9VP3+SRSWmQ89YJH84+HtOVbfEpq/TWlIkF20trqPg8lFRiUC/6iDoofr/juCM0KWzkFsFQVzUVkrANbogRfHU+B1tMbCiQtWTuCQq8yzpns+LjE95YfRc2a0npOwLeu8BtEIHBEeR2OQ6g+DkD7wH3yi73a/RVXr9mUayktmlo7Bacfeu2SWlbfUqdKOiBh3frIO3oQkUn+Uy92ZkXLmqjC0bHTIHj8QzAATNoAymnPPMFWp2r//dNJqjNgcPwsV7BdzhRQOCoTrQDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dm8PmNQFcy5lflCIiVrrHgJVW42ybv2IIGuV1pgT2Jo=;
 b=V5CKFiXmd2hPM+zOzFapOHrdRU+C2s4owTiZEyDP0fYjdw0xlxu4uoF5jSUEPTm88KubuF1x20ddqSgmeZUlSLY7t1qMhstygMoG3YnOQa+hYHliH151KIOZOrE/QA7rN6PrVwGjr2WYy+h168kOhZ+8oprN3eNm55F7DPUGy+QHc3z7MAypYBLxw94V+0EZQ6kT4O4ZkssCHcq5v57DezsgYpklwTxzn9FOzjOry+vYElxYApk7KAEtKbJDt3k7IpPvKoqg3jrwizZWYsGwqArt8XcEXRVTOHJrqjFdLteLF9rQuwGSIXBIft8qgqQ9Po7jEJ6OwoYf0Vz3XIeoyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dm8PmNQFcy5lflCIiVrrHgJVW42ybv2IIGuV1pgT2Jo=;
 b=K9QTIgB3jW5hs9ZpuisnMhsxSDN+fGp6GSQvN66S7A1qL5Sh6U9yzaM3P3NmK/hJUSIgbDCcNIBYnCDiooqXH5PGhUiVSa3vt7ixk1DpKOusTSuG7PNl9AEqdBZfI1wcjGBblA0QQgJnPcFE9kLuUX0Vxz69uXISEavefB/iBbU=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ0PR10MB4541.namprd10.prod.outlook.com (2603:10b6:a03:2db::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.12; Fri, 21 Nov
 2025 19:23:57 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9343.011; Fri, 21 Nov 2025
 19:23:57 +0000
Date: Fri, 21 Nov 2025 19:23:54 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
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
        Oscar Salvador <osalvador@suse.de>, Mike Rapoport <rppt@kernel.org>,
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
Subject: Re: [PATCH v3 08/16] mm/huge_memory: refactor copy_huge_pmd()
 non-present logic
Message-ID: <3314282e-7b29-41ac-92f1-bdc9361bd207@lucifer.local>
References: <cover.1762812360.git.lorenzo.stoakes@oracle.com>
 <6eaadc23ed512d370ede65561e34e96241c54b9d.1762812360.git.lorenzo.stoakes@oracle.com>
 <06f1b371-971a-458c-a5c2-0c7c5d618e12@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06f1b371-971a-458c-a5c2-0c7c5d618e12@suse.cz>
X-ClientProxiedBy: LO4P123CA0152.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:188::13) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ0PR10MB4541:EE_
X-MS-Office365-Filtering-Correlation-Id: ae1925fc-784c-4a82-53e0-08de29338428
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?74QmEdZlR9iXRQgBHeYhs1BkIimnsaO3/SIs1efIY/9QmGMDgX1iIIwEbR2I?=
 =?us-ascii?Q?99MKLiwTBb+ZvCbjl8V289DIp0gW1adEggSfvKo7JEqniKckXT+IhZr883Ej?=
 =?us-ascii?Q?dDCEqvJVdLYtU2C/nVBgF07CH8i2DOQKXvT1igKx2U0EZEMpVdaWK881qvnw?=
 =?us-ascii?Q?j9L98gZDBLI3PRMR6DbGlh8wwGa+eX5SLYgsED2UOfLB4nDitWJ+e2Gw7IHC?=
 =?us-ascii?Q?wt1Lcf64rrR609aybf5yzWNrPGj6xMGTxU679vdZ5MtSWcrtk7eLNc7w5159?=
 =?us-ascii?Q?H3Nozc25POcKaJpSeokxv5DgUWJR8Ty8YFafADtvy/dWpnp94HvpAnOWXHQf?=
 =?us-ascii?Q?uqZ36ld4ouosyh9V/MoeOxwqP3UZ4Sj/zyflavdYZavz7zOu2+MV6hJ655ib?=
 =?us-ascii?Q?lPdtGv9K/6N99qFZtn4LtgCLaDofddRbcBbfCfEPkN75vMWNGhQBaBc1eBln?=
 =?us-ascii?Q?qQnRR9CLPRSQf4dhPH1o2v9/TByIPVCJTuMLs/8CN3WrJWfSPZaw25RXJ68x?=
 =?us-ascii?Q?B4Tt3LDURSUmy/d838ly35paMfPBsGskraIxQ9HRpx7wHavmTkKBtIfLHs/3?=
 =?us-ascii?Q?zgk1N0rlEXBnbIO+4wNnLJODzAfmICJc9794Vg7uHLIgAgQOhSKWJqE2vNwX?=
 =?us-ascii?Q?RkWA0yqS2Au8Bz9S35QWDD8lEneEiU6o3tEQFTF898i3RIipf/68iiGnNH/v?=
 =?us-ascii?Q?tVXC5QE3+aeqMPwC7EMxW2DlrwTUgV8rd1UkmJD9tQHESMQpI6mGBBH+wavV?=
 =?us-ascii?Q?b6ynOQIWQoXQ0abPggMIqOkTp4ZgM1nBWYNt6/AW7OItvDVdywYpL+aMWi7x?=
 =?us-ascii?Q?jvkiUEzW0DwOWktDwRnFLIHZ5edcIKLFJogE8dcwYAj7tgOuN26/4Q2pRdsm?=
 =?us-ascii?Q?OYSPqSHQ2k2nfa/koK+lBbcHyXm1PkMspwgknFXgF7xqgX4ysTZq/8HUQH+6?=
 =?us-ascii?Q?UfLfI+tLY39RYzQA2BJfjOZ4x9qHTG+d112XjSTAFRC/4lrIDLb7BYcgDSiq?=
 =?us-ascii?Q?1TeEawyonZ+wycDUDO5p1XmGJzrHbzJvQTeQJ3C6DgJKqLzyYJiXYeYf5xZl?=
 =?us-ascii?Q?LUhlknEiEMbXMDFgp+NxW8ahGb+b22/UF43HI8lLUpL2OdNHvURqe3dEwuxK?=
 =?us-ascii?Q?PR1l2jsFGzDJiBKvKDiU6/qiAXyiV88uALcME16l2fCaIwPzFJUZ3nYIN2RX?=
 =?us-ascii?Q?rSHM5nyw6nT1y21SZctxdF1LHtlXZn+1cf+9paAUAvoUqdl+FFRfJ+G1QUv+?=
 =?us-ascii?Q?rw7py5NKAHtNoJh0KGRbjrGw5F3QveuLTWvIrM2r0aDjSe1ub3A9Y2Wvzdd4?=
 =?us-ascii?Q?xn7V7J8lF6tg5m/VEzOS4S/gqQck5oOEYXhP1nr1ZUsVDagwcrcbvhARYlWy?=
 =?us-ascii?Q?SWUBcW6o/xb2N7OLvC/Lxw87gI0laMlHQ4s+tKJJquazehBB5E4NJA30kQxx?=
 =?us-ascii?Q?tRSJsGzGPh05mgjEFQyd1nR51poSKFda?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NyZ4RWhXj2rFpwGK2zHWhsAga+3GXInOrJH4dg5HSKXkHYmUoBFXgREhQkQA?=
 =?us-ascii?Q?ZpYbeRJQukimbfEvj2ZGpvidOGy3OwRBGRP69TzeQGJXAwaIUaTzSLIu6r3D?=
 =?us-ascii?Q?8phzJCExb994mMd42JsmVSBdsQabOsFZ+ztQc2AfEuCk9kA1d1crNS2B6R9o?=
 =?us-ascii?Q?vhf12513FvT0LbkWzDVpdLN4ku7Mjg3HLyIu/z8FqGzuIuFtP1vWGGH9iYPr?=
 =?us-ascii?Q?TlZtnCgXMHwjB5Bas33CrP9CIUGiqMNwYooOVzej/pRa1Ft/D7BY5mkRkohQ?=
 =?us-ascii?Q?XUE73kAWDa/t9ZErXqQt4WZ3tLbYIh6jb+ejmpB1xR77BwuYcokdoBSsA54u?=
 =?us-ascii?Q?4voviTXuUYHq61TahFZuLLA3l6id/TzzZH1socPpRnqVRcI9y3Mxayq6MuUP?=
 =?us-ascii?Q?0P90f5eS7/vzsSkAtFuZjHn6fDw/15BjC555NBGK+yFx7sjZ6TsEma0NY+Tm?=
 =?us-ascii?Q?1S4VRIFJyrl4grS1cKtX+H/v+GNOrKwui6mf5Ow3Din1NTg2M2F305ljb9zS?=
 =?us-ascii?Q?6f9x1PPk0jyhka0FXS1nL/0WJlijdvIy+V5Esc/2aqE4GmDvF0V/bRAjeV9u?=
 =?us-ascii?Q?qFUuTorHcTWEAI4wzcwjvj2Ge5YP7oSn2EiQ/mlfYRD1oh2S5zmE1biQ2XFl?=
 =?us-ascii?Q?V9qD9148Ih2BbRGWshaj5QQ9w+tZ4JxaVV5kQiDpwe87cNoim8QPUxcTPB4X?=
 =?us-ascii?Q?xfl11jD//WfbyIab+7Mb4OZObLSvKJGRGLzQE2UcyqId+QrpVzaYIwKqLnpw?=
 =?us-ascii?Q?MaR6Kgi3x6IjcTt9WVJuMT0DaGDG13kjxuu3X6Wx6UWiCrxD/PRmGEBaI/0d?=
 =?us-ascii?Q?STWIUUVvi3cmQOWsl11tH2qCXY1Dtwk6gE+3koFCsCOixKxUPIeBOprwRR2O?=
 =?us-ascii?Q?8v/fJpzEut3lXKyJ5OX6zvTGgnYJN4YR6GrvnTg0Hx1DoIv0IRM88fuxVDvH?=
 =?us-ascii?Q?bogel4owHZPJi8TIdHxvo0dGgvRJr2UstSoNFxGUfggM7zrDH3nO16vD/gJ9?=
 =?us-ascii?Q?oezlvonr+IhgRAGN8chqrcUntiZ+LfCyC2Tfjp5cnCt+5Gi/wNSmZzu5YaRB?=
 =?us-ascii?Q?eA9wlz1MKmlQQWMDzzDzUkEnD5v8ON1QpRIwtMyil5GD0Nr/lcLBAjyTHlBA?=
 =?us-ascii?Q?XfTh3M2/wKGYtmHePDxiyyYu8Peg9Qngzy4A7YEZ178NtZG5Dhh49OA+4Gvy?=
 =?us-ascii?Q?hMaTr6e1Ej0hje3w7KpHj2sxclQd8lOIHSiTzXy01BgGo0ZdF4my3EygsT4w?=
 =?us-ascii?Q?YTApgLSZahsgNhSUIJ99IaqJdnRQr0k6szqHw2+8KYxGwgnhyLS1sOAQrByG?=
 =?us-ascii?Q?tG0ZEcmi5rXhaauKTy4eM8Z33Y0cdH8crgn+4BEOPyn7KMvMLNNypEU+ZPRZ?=
 =?us-ascii?Q?/z/Hv2yZLnW1YGhlnfZHP0RXH0+XCMvoCdnNAVtKn06VSpnS6Gtk4fc7sZKV?=
 =?us-ascii?Q?drXegx4pyQiaa1ataBxvCVoUcfYiYyj2rKiBfmrbX2IK0AnA/S4n/dfaVHEZ?=
 =?us-ascii?Q?+P1G/Rmur0iqatH5R3QYgR0CTg4yNx1fnXUGAvI4uOPqBMTOGhy0NwWIALl0?=
 =?us-ascii?Q?nFESPSkWPx5OWVXMn65EIB2Va2ihlcUf+QW7O7H24GjZ8cM9BX6JZqHa/9rd?=
 =?us-ascii?Q?PQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Sd/9OHm0UFUXzRgcyfamhZR1CgLiVD7xc2xBYs9OhhGdOyaLVgMSsNwZlY/q7jWMmKQuLEX2NRbBRryhpGy+0inQTtlhXOeCPrGXWn8YSERjqg89m7YNC5excUAMX/cDI6/pk8CjRb6UL58gJML4KHsWd+h5DM9SkFLDuCYHeZ+FJ9np81or2Ry+U/5F86oJEQhhlYZg57EtcrhOa1xSC9SKzXcNg7uxEOQMZhGdFSoEKmI5e6wKmEgLw4+fMIJwPr6heR5Nxb4oaddD0bndgmT5JT4AVlxc9x3JGb6Yi9WsJdxVArj05D8zLwPPUXK7XK3I3PJVwz+daUqjryYR3AJaOXOv4bZxaytYpQAd79YNvILVv1XvPbS1bqoInDOH1Z07GFddkUxSGeAk0ph0DJVxA5UcGoOmQxUDppvEBSTPpBT3mmqgbP0KvQmzZ4pgnyGi8wMZmgATtPzOWtInHDo+lniZSpZ3ADLfT69VGNvFSaiEARjUwMRhSBr0Att32tUbrFBphRV69aIyFASfrvWOR4esEIxRTIqarvqHht5icVNPrTUGejgFx2rbkM1YJnjjXQ6MwD9iI9ddmpjEawO12Xta767pKz5mZmMqcfc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae1925fc-784c-4a82-53e0-08de29338428
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 19:23:57.1155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aQypnrtyoGi1qk+xuhc/MwjmAqFys7ITShbesxOhFbzP48EKizRPrRtVMIRylmEqMPqcZlWAoqmX9FQPjTAuA03zCbN7kG9OMqui3DpQNPg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4541
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-21_05,2025-11-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511210147
X-Authority-Analysis: v=2.4 cv=OMAqHCaB c=1 sm=1 tr=0 ts=6920bc53 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=Og50t94LeEWtT3LUEsYA:9 a=CjuIK1q_8ugA:10 cc=ntf
 awl=host:12099
X-Proofpoint-ORIG-GUID: Sv51kqfZr9b9HSf-TnnYE1u_QpLZVy21
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMSBTYWx0ZWRfXxbqxHdztFgMv
 lWihlFXTdNmLEYukJTeNeueGPm5LNka1wqJd9a8GK9c9ZYZrDw9u7HNobhkjZoU78hvP0lkaixb
 6F8C7/TS/0pGwbNyVhO7yg9TP6ZlRa6ClucraodjLIDcm0hS46wYTew5h2ge6r4n4JG4q2JhISs
 DE5GvYFqUFszBnsNG3YBLoX0JXbQhJxuIr1KzVoVkFiBr2gFPWuu6w7g7HlLC+fWIyQUl5JGmXt
 uc0oFF7O0KkCl3rT1VQUyHr05AQyjp0RvD2W8OxQxFsM67bxnFtENxLT0ba6OXaS8sFwin+z22H
 f9mkys9TLZFPMZIAHQDjb7rgiONPzrJ0lCW6MYu/nYX8uKfp7SQEpcBJzVKgDew+mGv2cX/fITU
 12XPgafosfjjg+4bS1tyY3gQa0AWehi3RMzwqNh/ut2hvJ+F6u8=
X-Proofpoint-GUID: Sv51kqfZr9b9HSf-TnnYE1u_QpLZVy21

On Fri, Nov 21, 2025 at 06:56:57PM +0100, Vlastimil Babka wrote:
> On 11/10/25 23:21, Lorenzo Stoakes wrote:
> > Right now we are inconsistent in our use of thp_migration_supported():
> >
> > static inline bool thp_migration_supported(void)
> > {
> > 	return IS_ENABLED(CONFIG_ARCH_ENABLE_THP_MIGRATION);
> > }
> >
> > And simply having arbitrary and ugly #ifdef
> > CONFIG_ARCH_ENABLE_THP_MIGRATION blocks in code.
> >
> > This is exhibited in copy_huge_pmd(), which inserts a large #ifdef
> > CONFIG_ARCH_ENABLE_THP_MIGRATION block and an if-branch which is difficult
> > to follow
> >
> > It's difficult to follow the logic of such a large function and the
> > non-present PMD logic is clearly separate as it sits in a giant if-branch.
> >
> > Therefore this patch both separates out the logic and utilises
> > thp_migration_supported().
> >
> > No functional change intended.
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>
> Yeah much better.

Thanks! :)

>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
>

Cheers! :)

