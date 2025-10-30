Return-Path: <linux-fsdevel+bounces-66448-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 440D8C1F768
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 11:09:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D50474EB072
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 10:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23BE934EF1E;
	Thu, 30 Oct 2025 10:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pn07VE3G";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Zfkoap+i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D9F340D84;
	Thu, 30 Oct 2025 10:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761818794; cv=fail; b=FxB4wGOx0u1udD097h+9IXTP6mSQrxRPlef5dotLWvEuWA1EOhvaSmAPvF8qh6ODcjtBdQN5GO6em7aElqGYMMh6GeYwte0hSnVPhgqCNddjcvMLl32MoPJgbUQZHJaF5Xq37lOKm4U39rV72d2odkYKXxT/4tmOmmPgeyHCRLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761818794; c=relaxed/simple;
	bh=MOdmpsSAmBqx10CmD/Z73ccji2ao5btWv95Ehs7Ofzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=o8HrUT4+2dtyCFJiciEHkpf1WQJ35eUKmlibtMGTv+2W8Ag1mHSWz9+sEeUZm0n2lIle8JlTfOiLZd7ug6Jd+k0e6qyUqD9hAznsS/BJPe8GOb9V43xvXvFsr8BGQYNwtMU9n2vC6pUuuaZrUfj+nSkAHSeetz1KbvF/W2cxMJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=pn07VE3G; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Zfkoap+i; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59U9ifLk009586;
	Thu, 30 Oct 2025 10:04:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=scfktzyU3e0M1h/cGW
	Cd63YtUu8Vn57P2kg8v2YYawU=; b=pn07VE3GposEfHilHeSfJGh/zMpJXjVi7H
	IsEqkGvEeaX80AOxVpf5423NJ/APQB5jsoI4IFjhX4yLOwN9mKn+gJq3BfL45f7M
	BssfJNKRYzt29dfwmKqRwy8EaeBgfOYukQlzlHhJ/txr/pY2TARjfEfJwmucEcYL
	Zs5rgUWzqN9tEYKL8LBXqG2Wd83b1+wJOASYkrEGx5Io9gVfTOoyL71TomAxpg8p
	8BkmIrOTN8XYQBWpVBJPGbtUIVahDHxJpTgcj2hQMCCaI6V3qKtC3cacbKoV+Thk
	DyXS5qo3BUop1eZAaRIsYE/xJIx6xof8ocHdMgHT/aphVbKB5k1g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a45nar10v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Oct 2025 10:04:39 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59U94DHc031616;
	Thu, 30 Oct 2025 10:04:38 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012004.outbound.protection.outlook.com [52.101.48.4])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a34ed56yn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Oct 2025 10:04:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yw9/f+6IiMAeNElbS4McRE8GVWalxqKZdCaGuZMcenxEVB2PxgGPKn1ym2KFu2rioXl8XOadYiRNMAtyTXFNjZxjUDg77rM7nsQqz6nCZKftNnYQbVOXZ3g8OPDAxadcEx0OdexyI62K6kVVk0U4OqcfuilGhQjTZMxNgHSen/xyVbgoL2xImt+wssrTJNicaN6Ny5ohMtlcnUHSLFkaqkX+FAX3XPU70BYL7e38AS/l5aEiyVT1BMxoIDmjJI1u4Zakr0MfbO1vxyNwr5Bb5NHHO5YLDn6EfY8SnfVBDjQgzhdfuMR7zAxoAqmdRykcgUmNWxZgCCRI1Lr4n9mDQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=scfktzyU3e0M1h/cGWCd63YtUu8Vn57P2kg8v2YYawU=;
 b=qEZc9exiSGDisvcjTYjwkjhC0F0vQzrTngiL6McEAsP1DmhFK2tJfzexE+ZfrXtER6BDas/NKZRU0PYcgqnsAD6GtCOxsGr52bmtsvlXMWgE8As8jXafTQSPDgs96VIyzcsst4FLsG2JKbmMW7CaXv4we+kOp18/JRZKCqzwHBgYIrNy1nTC7+OXK/Ze97uGy+MYhfg+MQeuWMs/XbisgPaZLTHidFeLwKc0HeZh2wGDn/wSvxjnX1SfctSt0eSw0GhPSFZeGl27q+Gjf/FUVyVWLZhZ/1ytKLnoA5r63ClRQAhC61uxKwpuMjzaD/0F6SF0DW4UOjnXQRe88EQLsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=scfktzyU3e0M1h/cGWCd63YtUu8Vn57P2kg8v2YYawU=;
 b=Zfkoap+iMQKVhy21yGSOX5I79L48dk3W6FDSFHwykfLEu3Q3HeIbmgXZubn9YMEsRwc/u3A4H2ZngNSw4tmRqf1XSLL8ZJg+APGXEq+7Kt3d4R2Nl3+eVyg2s9+MCSh31FPRh+Q6jvijok0wZPVe/DJbuGMomdAcErd9D6gNAJ8=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by IA1PR10MB7471.namprd10.prod.outlook.com (2603:10b6:208:455::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Thu, 30 Oct
 2025 10:04:34 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9253.018; Thu, 30 Oct 2025
 10:04:34 +0000
Date: Thu, 30 Oct 2025 10:04:31 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
        Peter Xu <peterx@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
        Kees Cook <kees@kernel.org>, Matthew Wilcox <willy@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
        Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Lance Yang <lance.yang@linux.dev>, Xu Xin <xu.xin16@zte.com.cn>,
        Chengming Zhou <chengming.zhou@linux.dev>,
        Jann Horn <jannh@google.com>, Matthew Brost <matthew.brost@intel.com>,
        Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
        Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
        Ying Huang <ying.huang@linux.alibaba.com>,
        Alistair Popple <apopple@nvidia.com>, Pedro Falcato <pfalcato@suse.de>,
        Shakeel Butt <shakeel.butt@linux.dev>,
        David Rientjes <rientjes@google.com>, Rik van Riel <riel@surriel.com>,
        Harry Yoo <harry.yoo@oracle.com>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Kairui Song <kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>,
        Baoquan He <bhe@redhat.com>, Chris Li <chrisl@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 4/4] mm: introduce and use VMA flag test helpers
Message-ID: <0dd5029f-d464-4c59-aac9-4b3e9d0a3438@lucifer.local>
References: <cover.1761757731.git.lorenzo.stoakes@oracle.com>
 <c038237ee2796802f8c766e0f5c0d2c5b04f4490.1761757731.git.lorenzo.stoakes@oracle.com>
 <20251029192214.GT760669@ziepe.ca>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029192214.GT760669@ziepe.ca>
X-ClientProxiedBy: LO0P123CA0008.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:354::7) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|IA1PR10MB7471:EE_
X-MS-Office365-Filtering-Correlation-Id: e9032a1d-b552-4be2-a3cd-08de179bba19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FkdH7X1Wm4hzC3zIIV26tD1Tr5Hs2fYwYUprG//CHXJyg0cYBZdMlEn1bVdI?=
 =?us-ascii?Q?jYg20GuOS2rMPZr52YNFxs3sINgtJPeHW3GDUHkjSRMaqXzJwK49o0Tu7JJ8?=
 =?us-ascii?Q?3+ctLZp580cgpzf8dQbycyyUa1Vdq9E/HGbiNq0KAtvwsyMDjb5Lc3eEbtf1?=
 =?us-ascii?Q?UTs6f6x2MSWxHhjQZj3VlZw5CXIxJR8ylcT3+vaja48f88pUJM4+D0x8fhkE?=
 =?us-ascii?Q?xYPv2hb1at0QZ3WL97v068lYdyrI5tllUDZ6AHUjJoQIXwpFr/oN3h33jyKb?=
 =?us-ascii?Q?JNrcNi3JczN9OjG1qbbi5gOmjd31PfpYGi8cSGpzIr4ZQlS5SO7DNKA+u52j?=
 =?us-ascii?Q?PoUHlCa+0mmYikKCeNrX/o1i0b0F0hpsg3B3Ymta7jwVr7J2MI3hSro/Ox0B?=
 =?us-ascii?Q?q230GfKpiCdr6IiuEhP6eeub+/euHOGbZ3xQnB+rXYBrDMd4bJrVL1cCzLRC?=
 =?us-ascii?Q?ppZVVCeDGceDEnxj8CBuHY67vjXS8c/0T7ciC0BLHAg0Mwu729rmA9zjLZfw?=
 =?us-ascii?Q?hc2HASgz/S+wRASjBzqeXz8LBkMiUL8NtSINQsfeDKe1NB6L/OJZjK/6Vv+u?=
 =?us-ascii?Q?Zy4ghb/mBns7hzimV6+oVs8IpUK+SscTp3SjwBTBwPGjOm/4KIPDZrc26K7J?=
 =?us-ascii?Q?ISosmiIWZva+E4PjENlv+RjiP082k/TAVhFupRMiJT/MUocsbxEAdlynp/Ml?=
 =?us-ascii?Q?5uqPCdi0aCXahNwx4uhc+7F2ZIw8bpcDr7JfZz5Da4K7DVjmIkWe8iwQ2wFM?=
 =?us-ascii?Q?sj25S24/xTqdCfrbXcYqMLXShHbt1HI3YAuiqOGEdhjF4S2ohjzsNJYMa9dI?=
 =?us-ascii?Q?EteXb8VTvcm41KiW31nEH2okEzfJ36xLORvT/9b8onaNB0+rUe3l+P+TPy9y?=
 =?us-ascii?Q?6CK9yxGEWT1NIUZGlyUA+LknNdgYNaG3hv2JMcV6ga/KaZuXN7U9wZgE6Ows?=
 =?us-ascii?Q?VwSUSc4KaU3CZptA2qSR2Wk1Jh7kZUKqrZhS2ewQykHu4r1NcHC1FjAz3EV9?=
 =?us-ascii?Q?xZ1EpcROODQDP0QryG+CYhzGrgHjMH9U20obSlLIl4Th/umD+Dy+Mq9zoX3k?=
 =?us-ascii?Q?QI+aiv2Mz0qQGiUzEa1T2cOudrfOHmRVA6gMOfnN0xzefr2SLFHjnTMA9rKo?=
 =?us-ascii?Q?wyiR6WD+8W6K3pip24ZBJOwz1jJYGtidig5Aluq29+nQYY1HU/tuIyUD6OpT?=
 =?us-ascii?Q?/9ty7ffm4tPOQTsXdgX8i6BMdqn5OKITrMzp+W7w+caJ/I35z3eWfWqxA53z?=
 =?us-ascii?Q?Jn4dMKOSGXEG0J3XnXjdGHdkn+s0f5eZbiAJ58/caBzkCy3Y4+oyZeJJxU8E?=
 =?us-ascii?Q?W/MdBVMiEFGD5lJTTFaxLLUBAUN0NoP0lB+p/IrQ1XEcjlb8L8f6SUEQhnct?=
 =?us-ascii?Q?eig5/ixtHZaUvs/nGmaUJA0GOOs6qTNxbAf2b6vCkpqhvrUgU57+XsClNXUL?=
 =?us-ascii?Q?cujy7KZGKJy1S4+NDE/eQ1OgjIZq6TvLceOYOeFh08DhMcxDBhuUiQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2tREEoZKExPnyotdudZMR4T5cBPBGfR9En+iaaqG365Lm9J3OS/nkHkb0iDn?=
 =?us-ascii?Q?htZkeBECCBPK22IAFDvX9gJE2I42utCPxHKm3gRg5UvZjdDx8/rGSkYuocen?=
 =?us-ascii?Q?aVAYYfwfaEZBKXtipy6B2yjFvueSWLq2WPG1pxffUOmqADZPlMJA2PCX7/uA?=
 =?us-ascii?Q?eQAdmwZXzRDu9pqy+r2IiXil+Z1Y7YAFJNWBv4aub7xlPjacLXryPGXklTjV?=
 =?us-ascii?Q?ETimRwHvu0C7+lYi+qr327/zHiylBKIKXfRaygnqbOkUb6HR41b1M7D5A68w?=
 =?us-ascii?Q?FlJnIEjRTY/sv9aURP4DbFeHu3+ybhaZA4RSZQgNAU5P9FJTLOsLeSvEquka?=
 =?us-ascii?Q?JUS6+hkFuhRRKFh2cNoHBbuWoVMweNZEdP1X2bmOoJ5t8qj5mnWSHXGBCCdx?=
 =?us-ascii?Q?RDbjGQ1IXq84JTiJf9b+bjyuSWHOQ3N2jQCSeWGQXx1rCwZ9gY0IjGfHkewm?=
 =?us-ascii?Q?avWsTDT1qDlROHOxqryeWxa8Uk+CcG4Yy/3KEdv6E0H+PNeJqHFFNHETjzTP?=
 =?us-ascii?Q?7cxXY5mDqpGeRmzcffVnAJKDIevVsf3GFekng1kS4ALc/V1cPwg1yv8LIxCT?=
 =?us-ascii?Q?ZEXpb6pKc3n1msaoJ10ParvDVDDRyPeAbdemES5hixkzDCrlCwyA6rUG/Lgu?=
 =?us-ascii?Q?H4eEMJ700EudfkI9YAXoImK6xJfoDKYoLV8V2Zqav9qOGA+R5+IPCCvPp824?=
 =?us-ascii?Q?HTc0Ib4eHRjtuHHVOhM9DjeYKZOkMNzQU49FfpDuVyVBQyg6XsbaunPWemNF?=
 =?us-ascii?Q?380ed7NrLytDObwk6PtsDUCVrwj56zHqYpiYnKpT7zEvtTDKhAXygPhV2YqA?=
 =?us-ascii?Q?26DwTy+53DdFoCc8NFP0sr12tUKd4j1RtgHq7rDRRjALqIZTTllNMoydHXnv?=
 =?us-ascii?Q?QSnD/rNCAsG5nMnT+J0Da85hfAjis1NuajF2tdM2EPkm5VOLYIHUqAkFwTKP?=
 =?us-ascii?Q?24tQ4PjvmUlq6Wcq9oSL2VoNTBWno7Nmt6zYeXH4QIOZOnynnWHBvHNCp2uq?=
 =?us-ascii?Q?A+jvfp71tRNnSYccSNjbIPX8/nl9HkSiC7J6I6jMqtfULNRAN30frNmhtLI9?=
 =?us-ascii?Q?pQUH46KGCTmPK0a3QxIhXbWLbcpm6eAfdBH/NqSSczfu6byprZvNWpp8fIrx?=
 =?us-ascii?Q?kk0iuj/ka4s4fNebWIqq7av+zvVcqQK0vXp1o8kFmXPD1hQ6W7bz4FuaeEp8?=
 =?us-ascii?Q?Ptvr3ZfPDp999vK53IEFeE7ftm3JbtmItUrQ+0vgcYhvyokkI4hAo9HLdgnL?=
 =?us-ascii?Q?32ZLSA07QHxGMBYsRrothxJ4BCKzUcdVzMroKKWjarmtIYKTRR0nY8S8ZSCx?=
 =?us-ascii?Q?GbsNxBgR8NUhcSp4FwQPBlU793NbhM1dpjSV1wBrJSn7FC2PIWaS20ox5kR4?=
 =?us-ascii?Q?TNuEfTN5Lso+NJcqj2lbZCzDXzNv8wWC1jLhHqSZl7GuLT+YQGi2mp9KCqbM?=
 =?us-ascii?Q?aAczEizQn07cM9Vcde0nxhACYuLba3NtjtFGnYR1M6D1SAZgH15Pj1e7bb3f?=
 =?us-ascii?Q?nODgrOFS0UYS8hZeWrmmOU7fLHyIzHXoICMeUqvpLZJqi0+WgcBNjmPPHl3f?=
 =?us-ascii?Q?AjPNcr85BgAkLyXDGXrX91iJxnS5F6EDAHS7GDWCKExXN4JE8sbESKWADHmI?=
 =?us-ascii?Q?Fw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	lwuXO8+UN69ngALCy4VTR2tkw9faQTmN9eZRZEL4thim8RWK81TCaPR/U4Wpl5oCpWjBmH2GFr/zMca2DKRD5kp3NDPG/MZbtJCWe39Y5OaAi6/w18gj1GQars80WG75tD+uKgRI7Y8Mrzgz/2j8ksIgEFoJG96FVjNQInfkOFyi74hGzOvMTVeLcig+hcmd+9sASfrl/sMZjzxAlm5Az8bhqF9qua/eFRSWfBKtfJm06pN+kIb/dMufHKesrbBWT2aF8oGvBLzkoLzydH/+QLGEus0tzfR7cdEKb24YHGYXG0gg/cn/yR88hg3AQeZ/lTCT8TcwJHpsspP9K4Wc8hxPrU8HJcBa1ucqcd4wFyStAwCt+dGaAGz5t7/qgrsFIGoTecUIRjAJFm/M3WPlHHzGKC5E/u2KeYeehSKCQ2Duov+XdVS2xOiFK15P+LNaJ1TI2riAvnlQXLGQuOt8frYcv8wgD4TbqadHPg2jWt03jJ1N5dCfSf67UiS+RBI+AYjZkXNUzbBjorMQ+uY7OsUd1ui4eeS/nbP5TUQKoeXjlHmI7YjZe+Zpe75e//NdlbGhRykZWO3raNXZxaJiVFosHsInf44ZkjUeiE2ZWRM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9032a1d-b552-4be2-a3cd-08de179bba19
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 10:04:34.3640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: msDOPVg7RnfL1mXCeHU8GOOirG2GCO7hJKSuhwzWeOz8/HSXqgX/aGV4IdapkvSIwQn6N6wJp6/BmBRRocikH0kN1wnQCVFkh334c5pA7Ow=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7471
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_02,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 malwarescore=0
 mlxscore=0 phishscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2510300082
X-Authority-Analysis: v=2.4 cv=buJBxUai c=1 sm=1 tr=0 ts=69033837 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=uPZiAMpXAAAA:8 a=8X94OT72SHwVDGuZOkMA:9 a=CjuIK1q_8ugA:10 cc=ntf
 awl=host:13657
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDA3OSBTYWx0ZWRfX6AF8AMTtK71c
 7lLQjDqthgwYCE9c4ck0xjIqCu8Vbi48szl9fGRbuDQwBVjJjOymoTAnWNH0uKY62P4TlpAwq/Y
 n3eSTLu+OE08obRXHwLkQJdO4l3pXK/jnrE2yS/XPRiGjcKHEiNol5zo5mDb4eZkKW/WeWJpQsk
 6PJqxhdyV2A6+53g2ZQqwJe3YciszqrlK63AxGkzHpGUSBN3FBtcwzizK5+Xs/mminpyWkTKjjW
 PZlmwlkVOKDP0HOifTJ8X8KLJQ+CvqeUnUHetBN6n6XOq8Ewd1dTVSdjTE83D/bXxdShYV6EO9R
 MdrXBuqz46L0jqXdwxLXjJUBKcp4d7YXGQuc05Ma3WP4F4RzEOtf292bNrkKNYKXsauxr62UpGD
 pDicanLa38PGQEoPJwJHdKczona6+eajan8k2FBNP1QcmzlIcr4=
X-Proofpoint-GUID: psjV2Relso2p_ZLUGjTIda7ZAYjnFgv-
X-Proofpoint-ORIG-GUID: psjV2Relso2p_ZLUGjTIda7ZAYjnFgv-

On Wed, Oct 29, 2025 at 04:22:14PM -0300, Jason Gunthorpe wrote:
> On Wed, Oct 29, 2025 at 05:49:38PM +0000, Lorenzo Stoakes wrote:
> > We introduce vma_flags_test() and vma_test() (the latter operating on a
> > VMA, the former on a pointer to a vma_flags_t value).
> >
> > It's useful to have both, as many functions modify a local VMA flags
> > variable before setting the VMA flags to this value.
>
> Hmm, sure would be nice to not have this inconsistency though.

Yes!

>
> It is a bit wordy but with the C preprocessor we can make this work:
>
> struct vm_flags_t {DECLARE_BITMAP(..)};
>
> void func(..)
> {
>    struct vm_flags_t flags = OR_VMA_FLAGS(VMA_READ_BIT, VMA_WRITE_BIT);
>
>    flags = vm_flags_or(flags, OR_VMA_FLAGS(VMA_MAYREAD_BIT, VMA_MAYWRITE_BIT);
> }
>
> Where OR_VMA_FLAGS's OR's together its __VA_ARGS__ and returns a struct vm_flags_t.
>
> Would that be interesting? Eliminate the inconsistency?
>
> eg
>
> https://stackoverflow.com/questions/77244843/c-macro-to-bitwise-or-together-a-variable-number-of-arguments-lightweight-solut
>
> Or other similar solutions.

Well this would help things be more succinct rather than doing, e.g.:

vma_flags_set(&flags, VMA_READ_BIT);
vma_flags_set(&flags, VMA_WRITE_BIT);

But the reason for this separation is more so needing to also do other
operations like testing for bits against local flags.

It may also just be sensible to drop the vma_test() since I've named VMA flags
vma->flags which is kinda neat and not so painful to do:

	if (vma_flags_test(&vma->flags, VMA_READ_BIT)) {
	}

Another note - I do hope to drop the _BIT at some point. But it felt egregious
to do so _now_ since VM_READ, VMA_READ are so close it'd be _super_ easy to
mistake the two.

The sparse stuff will flag that up (no pun intended), but I didn't want to make
that kind of error _too_ easy to achieve.

Buuut I'm guessing actually you're thinking more of getting rid of
vm_flags_word_[and, any, all]() all of which take VM_xxx parameters.

>
> The compiler is pretty smart so this would all fold away to very
> few instructions.
>

Well I'm not sure, hopefully. Maybe I need to test this and see exactly what the
it comes up with.

I mean you could in theory have:

vma_flags_any(&vma->flags, OR_VMA_FLAGS(VMA_PFNMAP_BIT, VMA_SEALED_BIT))

Where OR_VMA_FLAGS() generates a vma_flags_t which can then be bitmap_or()'d.

It'd then have to be something like (say for 64 bit flags on a 32-bit system):

	unsigned long val[2] = {};

	__set_bit(VMA_PFNMAP_BIT, &val);
	__set_bit(VMA_SEALED_BIT, &val);
	/* ...assuming dst can be src also... */
	bitmap_or(&val, ACCESS_PRIVATE(&vma->flags, __vma_flags), &val);

	return !bitmap_empty(&val);

And... I can't really see the compiler finding a way to make that efficient,
esp. given e.g. bitmap_or() -> __bitmap_or() for the non-small number-of-bits
case.

I feel like we're going to need the 'special first word' stuff permanently for
performance reasons.

At the same time, can definitely look into what the compiler actually
generates/even look at improving the bitmap stuff if it's inefficient. But I
think that should be a future project :)

> Then everything only works with _BIT and we don't have the special
> first word situation.

In any case we still need to maintain the word stuff for legacy purposes at
least to handle the existing vm_flags_*() interfaces until the work is complete.

I think it's reasonable either way to treat this as iterative - if we can find
efficient ways to do this stuff with _BIT only then let's do that, but for now I
think it's reasonable to have the various compromises to make the initial
conversion easier.

Of course we need to try to get things as right as we can early on, but we also
don't want to get stuck in analysis paralysis either.

>
> Jason

Cheers, Lorenzo

