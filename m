Return-Path: <linux-fsdevel+bounces-66462-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8A1C1FEDC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 13:06:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B7B474EB1A7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 12:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F6E3128C5;
	Thu, 30 Oct 2025 12:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ETfRkCeL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zpxW27tx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BBE2FDC29;
	Thu, 30 Oct 2025 12:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761825884; cv=fail; b=GscCHu/Iw4gFiv+fpDiXXEdgthpEVVlXQNFxsiG1xO9jo/ewjBPxpfmO3FFGCgZmhDz7D30nS2P7xDIwol4seWIHE0zLqFCCskUCaFz2KM2Ff9oQ/OL7Ix0i8L7p9cQ1Kj6+n6+ESi/U2mZER1B4SBMH2Ps924MbGspIxKt0T2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761825884; c=relaxed/simple;
	bh=el+kk8dcdgdYlF8DvJlxGMtf8ehYVd56GwLgrUtCooA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Wob/pPTmLzvBgQGTujp3+fyHlpTXw2TG4ox/dIhfo++EYuJwx6LchbQ2q2uOAzh5q/k4F1Al+d7mwO/pUiLUHmSCqKtmmxnkDTSs0i45rbZ7LIbcmZMQjj1nHKXSgiqhFQ/a0LLlcr9Oymu9dj3RHVj5CVvLTcJ1xDyV8QiigBM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ETfRkCeL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zpxW27tx; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59U7gdeF019496;
	Thu, 30 Oct 2025 12:03:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=Oq6SzBdBlyCXEsMRJ+
	1p37pVau11izQS02isNQFCOsU=; b=ETfRkCeLSY5/6cQ9RK0PRVYEh9ybvGGrVS
	CZFdnG6Z6I7l/4P5D+F4XoJT5i9XqCxZIGS0bknCTFfSZIOYIYLHBuGWihUuiUdB
	s5z1UkY4fANQBlQW2wZw6YN0kufoDDH7MGSlhxrzgvEHN7BjaCpXcGJdx9jlry4N
	4mVWjoLbegmiMB/EpLz5F7s5eM1TVtem6GMkD2FUb8J2K1C/gxY6Unn8hdubflh8
	wUvbMVck0G5dCXUuFikbrwg795CvmS0Gd8oP/WErao30xSl4wBWGkOfWjYU1tPtX
	FbRx3NaSpJmlNHPA91ZZHIG0wMb42GaWdzACOp4vYcd+lKwo2Rew==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a429frr7x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Oct 2025 12:03:33 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59UB4olZ007615;
	Thu, 30 Oct 2025 12:03:32 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010030.outbound.protection.outlook.com [52.101.85.30])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a33wmhd1x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Oct 2025 12:03:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d7wAcdHyJZoB1Yrb1RtxxDqUWYLA/gktyV4EFtZoBBJAU9c6j85GFpBIxDN95059kviZ4tVQ5jpDS9q4kIDmniknSxz8Y2ut270aPjxFbssAYuYWOQWYZRvELzvyB7eGDQWlTUmEfdSeCnNiZkREnvAv96gcX+qN9ZmGJqTZhw5gWTeZ3EmqkwPMaKrqNT78ZO8Z+OLV3OFNgiCzHjZBb07/yAy0zsDrRTUN3u6dzzWU8jKTHLOLPx4oyezJrqeBV7F1YG7PN09SLIPlMd+LpYRG1v+6ZUNZR6Jikb1MyON0G5owIKCc+vE1kkoed5RYd4YUAGJmVMWhq4KDwVXxNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oq6SzBdBlyCXEsMRJ+1p37pVau11izQS02isNQFCOsU=;
 b=CglCzblKoTENDQtggPz680kqz4ugExOhqszK+rPtxVWX+zTN0l3KKrpfeNVerBA9j2US522n1NbRXYP5aQHXdHiyuQUK8B/H/qaU8eMBEjUi8ElcPoI44k6+g8eVnXhQbXgvaEbU2l3NGow1r5LwTPVhStG6EOQeReJt4z4E/JOcTSclKgt8aG4HDiWNcxefNYIXVwoSNMrsoaHKK3aVupXaUBwKcOHwvvHIMU/rTONRdPy7YshHgFKAWGKVWrKvZWksIkcRAjDr44zL1lh88d++/PIrrruRiqffOByp1gjmoQQmJTH/F/PSj2izpGrsOUO/eHWW7bTYAz5JZOq5Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oq6SzBdBlyCXEsMRJ+1p37pVau11izQS02isNQFCOsU=;
 b=zpxW27txEto4iK9iyD0QDfknJNT6s13F5mADoe2kU/5p8GbulR+ec4FLNnc3NOcJ16blMu8nhG14PUq0yD4qHYU5RXWod7VZeU6Jt2JOlghnJwlfJ4+CwV7YWJzD7k8jV/Xi9+Ru6pqn87fkTAOvmenZ/7USp5egfhp5V+07/6s=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CH3PR10MB7715.namprd10.prod.outlook.com (2603:10b6:610:1bd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Thu, 30 Oct
 2025 12:03:10 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9253.018; Thu, 30 Oct 2025
 12:03:10 +0000
Date: Thu, 30 Oct 2025 12:02:58 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Nico Pache <npache@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
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
        Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>, Zi Yan <ziy@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
        Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
        Xu Xin <xu.xin16@zte.com.cn>,
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
Subject: Re: [PATCH 0/4] initial work on making VMA flags a bitmap
Message-ID: <de187794-8a28-482d-802c-8e0fb6f89e5c@lucifer.local>
References: <cover.1761757731.git.lorenzo.stoakes@oracle.com>
 <CAA1CXcCiS37Kw78pam3=htBX5FvtbFOWvYNA0nPWLyE93HPtwA@mail.gmail.com>
 <4e6d3f7b-551f-4cbf-8c00-2b9bb1f54d68@lucifer.local>
 <aQNPXcxcxcX3Lwv0@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQNPXcxcxcX3Lwv0@google.com>
X-ClientProxiedBy: LO4P123CA0295.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:196::12) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CH3PR10MB7715:EE_
X-MS-Office365-Filtering-Correlation-Id: c222979e-2c19-419c-ffc2-08de17ac45dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+hqDLbNqzYCIntR612MpDBOgXgd1kfTQAOefMysedYdrav9g82UT7ux4/3en?=
 =?us-ascii?Q?/fkTw2YWxK9XjkXoRSrTXyOKklabc15B1DLBNRJCS/JaMy025TtQgjU+GTSF?=
 =?us-ascii?Q?LGnKnSXWtXlLZbvXqXxstlJIHxnxEEMU+1pNsIIlMJzgW6QfbXA2dkfgnst7?=
 =?us-ascii?Q?3VD1zIyZIbiaKpMdR3TEU1MrMCMNoWA4apfJL9Ll1kZCnKOZbi/k5LSuT1XG?=
 =?us-ascii?Q?KY4S6aQYGTg1UziUHCQzwU55uJ3LItY3W0XFyjaZAdkZnd5GvjqJb47uF+/W?=
 =?us-ascii?Q?/VuCBB1IN/2dcQ3s7Qk9LS7sUxVBAYkxmW5nJ98m1HAbHwgr7r+wiC8H8z8B?=
 =?us-ascii?Q?zGzaP6WKfwozTTV9Dk7TheUphhDAjLqsJepZtnoNXsYEuXbB3Vc2ZTe1/7aI?=
 =?us-ascii?Q?9VTu33BEBmZcO+JsdscqEaKYZ4h+uZQTbp+2s6khV4GmG80IFHr0iV4TFzow?=
 =?us-ascii?Q?VQd6x44Dw9dOitGvseYYOMKMQuNpEo7HfCDZ9yZ+hbB7UIc6WRbVDe95tWA0?=
 =?us-ascii?Q?GtmDBhs8xQ7+NTcAl5F4nzb0jlzTjyelFJH4YZJsX22D4XSAhEZJxaFgl08w?=
 =?us-ascii?Q?CKYEjfHjMRR7dguOeBq2As2RCwkozOTvEUlbAKZFJgwwm7nhnvNxQhkci0GX?=
 =?us-ascii?Q?BddmHAcZpeIKMGGH5F8Ox22oC261z9JrcTv0DS5VyaPBt0AJej/PGFQz8ygu?=
 =?us-ascii?Q?8+50KN+vUHsJJ5D5OHhIe1ZGAR7yq5Yqwfw7PIzOmBcT7iYrjFIAbt4ORe93?=
 =?us-ascii?Q?D+Opp7OCKxdJQ1y1R5rzcLN298MVUHnlGQ0kXh0I9BE3vJfrCsxHBwRUeGpJ?=
 =?us-ascii?Q?PDOs6QwmxjNctp0uUdOqnXlmYcZT/SfPo8vhlulBFKmhw+TsQmvMX4crQ2c1?=
 =?us-ascii?Q?JiDG0YANBqquODllNaWYyClYfIvSYOqmQPWmhFAWA/Dp/bXz0t5+Uio6MqEJ?=
 =?us-ascii?Q?/aKGvCFQKidG9Vwo4+NeTsq5LZUmZE0o9efJIC5ai8MzOZ0Xjbsq9ppDZtCx?=
 =?us-ascii?Q?296ZG11PA/1DQbFfScVyInGvpPdc3gvDXWpXYsgytfuPD5nbZWeysPEZOj6I?=
 =?us-ascii?Q?f9DI5H92PhCcZwMwg06FnWtxP+MRQvyMtklaikxXYrKMNAmDTte5J9K8nmBb?=
 =?us-ascii?Q?MIcPOKPWIuiarGv88zW1zTINNWG8nHTtfNYcljumFjRig7GZqXCmrMjXDnv5?=
 =?us-ascii?Q?xsv78LNc48i/z+12ShlxpVclbleZUaWsmOatZ6K1XkiSk/vXpw3arVMIAZtm?=
 =?us-ascii?Q?D2bgOkl9KskFduuAqUi3NLQnpq8jn4Mhf+ustyAQBOyQYhdSoAbSlHnDXtH/?=
 =?us-ascii?Q?EjUvcadmuy20qq+rzz4SMNSJjnPsBr+pck01PAfHYjQsycaKN+dX+BgVKtAX?=
 =?us-ascii?Q?qzrtJJCJ4Q9kTp6VuiF4bo9n2xZ0ZNQg/3ijpTrPRY4G6OBWTpO0+jCih6k5?=
 =?us-ascii?Q?DF22mKZbkhs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TdYx+oVtupxOCyrkR09RNbv12vMMWr/3pHzXpUTTKfwexo4eE9lH65evNxOK?=
 =?us-ascii?Q?hcNkbTEHVkB/Ssq263+EFpm+BcJ3yW6Y8Yp9qHEbnfQzAaMRP/xlwNNYhGQU?=
 =?us-ascii?Q?H8z5abeVP2TVSlzDK0HbYy9mxntgkHS6TZDPE4pisE+aBWmpyJ5/10B3L9Sh?=
 =?us-ascii?Q?W4LbWSJ8S6vW2DX9TibKsA4zBLo8t/dGKUk7yMKIkB1Qs2QSXqQhh1k0ac9Z?=
 =?us-ascii?Q?pOt4E6sMWi15LJRLbI2dYgw6tUsvzZ/QSsH+/ewl3oOgTHCgQK/9Fggodv0g?=
 =?us-ascii?Q?htuMvsQoSGUmD1tW2SAN3YV6PWIhAaQZRK7YPHQj6xi2L2Yo8Wl50gVe6+eD?=
 =?us-ascii?Q?jcxON9HSiMdpVDpFtthkMJ5IVGZa83ioEpPFqQjnl0X4dOgXJDrU8Wgygv3F?=
 =?us-ascii?Q?KA6FFQ76VIEZSz5+U7l+FxzEcPpacdSvANjeh4f+zIMXjUm95mvWxO5bvQAo?=
 =?us-ascii?Q?M0JxYLYz2u7QQT4txO3QwDW32jfmmlVniOa0HsBs1Eao2g8+1NIb+iTfrYfZ?=
 =?us-ascii?Q?I+O6DMy2KLXGZL1Ttv2fEa7vSdA49anmGKeEMNBFxe+hFXEoMjkLt6djd5UG?=
 =?us-ascii?Q?fGozGj2PgfPkxtn5UMBVleYz2zj3Bn25Y5jd2PRfeFwLlP76ltBJ1v2i+34E?=
 =?us-ascii?Q?FQFcncO521fakVW2jYwFXf0vlVGq3O/fe4VN1990O9ochxyZJ99mmKjv+Vjm?=
 =?us-ascii?Q?0Fx0GWRTG2GOTRZCnNlm774Zf0gpVXyJqD42g8G1TiofkBfDsCpadZCIM67J?=
 =?us-ascii?Q?ovQcXByTp0RmynaRrJSdp4J3+MOh3Q551sEC6e6H2wGG9uh7Z5uvy+5n+Veb?=
 =?us-ascii?Q?dEf+CeDNI6p6MygprS4muFo/nWZwlxQiQXIOf0E9pdjd6oJSf2UaLAfw00mC?=
 =?us-ascii?Q?Oq8wm/V8ADUaFN16TzKG8AaB26ITv6CBtZVh54ESVxym/dpgFSEwUwfn6beh?=
 =?us-ascii?Q?JU9KKplBXeTCWE6ysfHuWEpXBbnSKZ4FNw1DgZbr+T7pYWqK10fiP2CFmlk3?=
 =?us-ascii?Q?EfmpkmaLZkiksMrWtnsCedMntrE1Z0R4t/Uh8gRGwmt3DWDDft78BzTtAh12?=
 =?us-ascii?Q?L6BWoytzrXOYjrH+ZSuGmCVy3UJjnRmNMwwyoP9USGwHXLs+9uKVmk2pXYWo?=
 =?us-ascii?Q?eRvs7MeZypbgQ3cRM5dfqVxiNEgLpOPe5pvSGpj5/lVKIQz4IB3GMSYBmEOu?=
 =?us-ascii?Q?suBUZimQM7RJIGsVQYtYBh7/xl4ii/y4G3Kbg7tGx+fZHZeESyC/lrO367hw?=
 =?us-ascii?Q?rkc9YCTUN6y3+09xtf5wGdE+zDzV/82qQmY0iNDl/X2b+JcPGrYOQapBB0xa?=
 =?us-ascii?Q?ZKYWaQEE654tzVm6ZTdzrBSM51ALLiyhoEOvnHGxZ18eavZpflNqktoqS8LT?=
 =?us-ascii?Q?u4DlujtwpzvHjrHF38OcSTeWN0w6zTEsJXBqUtZid1/WD8YKbjH/NH+DhG7x?=
 =?us-ascii?Q?9r9ieB6UIS/O6DqQdC3YxfuxiUDe1LfRMga1AKt8u7aoUAN7EV2AvptbmpuK?=
 =?us-ascii?Q?qc1aHHJ7pBT4otXTAcrczG5l4z6W3YTjEnSQ0U4Mx+v4BbOmgiUZZwIoOWUR?=
 =?us-ascii?Q?fIvuB2jm0B1K61j28H4JpZGDEH3Kr+TF1e/Y1yecFwEmg0a0yOG4Bfq+aIOq?=
 =?us-ascii?Q?Ng=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8wVtCn7hSdM2Ri5l3DkooY+YqBBWOuuxKVF6krFvPgmyBLhRruKSsmZvqK2+LNEjS9mYs+pyev+ZBo8MZNhaLfGjGJ1mSJs6khp4pfDw/YZuxVCe6swPwkLDwp113P6NqFp7uK65zS6ax3PzvibgdRxfld+1+cNLLH2zdo7gzzhqa2wXqDhmomMqnTKOXafXesqNbOprGqnagYmmyEnUuyo24bEWUZNrnPeRpKMcDghg7HGei6BzpQZJGqQww8UdyERDAmWhSI3YVCbccRxRi7Y71I9RiOOdD9DDPZGaAYheI2mJhq2nCjoWQjMQ4rop8gHeDVuo1OjuIn0buDlU39jycvUDrNL+ctWEmSe1yAO4PgP/p6aUFnGbDDConNjmIjHbfZoxAT0nZgKxZAolNtqTbP38oeOitJyj2t2di6G99o1gN9zL3VXhbLuh3lo7qsIP7c7hiznnIjLI2/XL3I5b3JgMXfzvEi/A9JuJOTYcwKAWEZXs1g3m28Uf54N+jGs4txgG19aU+haWakJ6iCo3OrCCc0TYxo44Sapi2brPnoxb9KPvLqisn8q2JLa1Bqe5McFQ5sYPox1xHUORbsaf0WfvkmHR7N3vJX6FoAc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c222979e-2c19-419c-ffc2-08de17ac45dc
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 12:03:10.7814
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wJzE/S89KRww9QP6mPXzKtthaudFXarR4Fw+c7QbL0/jz8y5QL+UZpmSjYvmy5Y523H1+3ebKf7f15QBgIHGzJENVEJRRAH6ykFJuT+kesY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7715
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_03,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=949 adultscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2510300098
X-Proofpoint-GUID: cVVoWOTGUJAKS4lJMY13YtnxG0v-YPv5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDA0NiBTYWx0ZWRfXwoljQVhgzGdo
 V57GMqBXm7UDvU8Wqh7wvjuJ15SpBB9QvTCZj2A9BZA1kh/jZOd27tb6JZeL989HBNYI8X+yklH
 NOp9ZV1jxBcdgvhifOnPYnut0439V1dNzhH8L33ALg58jOHGwUA6ihCmYaOTcpB/OU/7zv5PHlT
 Uc86mqt7cjP6GEkC5JFfte5UgHhNWj7Ww8vHpx1gyZsdaUiDorPyKjNQJGducXKhBTYMIQ/lPG8
 3KSMVUUnIf7trEAq5aNie1hc9F+tJIsDMSUVFKVm3QcQBvb0CuugZrC6+DMuN/YabIAV+N06wa5
 UiC6EAiNzuLeL0EFw95AHC8tumaTeO9fkbg2iLaohN6Aas+tz/B4ZE6RnNc1t5rUQ6iEjzSNRte
 1i1slESF43eIE8l7p6BwYZAqsYYxig==
X-Authority-Analysis: v=2.4 cv=Xun3+FF9 c=1 sm=1 tr=0 ts=69035415 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=vTr9H3xdAAAA:8 a=NEAV23lmAAAA:8 a=yODyRsaVD6mdLI2ghuUA:9 a=CjuIK1q_8ugA:10
 a=UhEZJTgQB8St2RibIkdl:22 a=Z5ABNNGmrOfJ6cZ5bIyy:22 a=QOGEsqRv6VhmHaoFNykA:22
X-Proofpoint-ORIG-GUID: cVVoWOTGUJAKS4lJMY13YtnxG0v-YPv5

On Thu, Oct 30, 2025 at 11:43:25AM +0000, Alice Ryhl wrote:
> On Thu, Oct 30, 2025 at 08:33:10AM +0000, Lorenzo Stoakes wrote:
> > +cc Alice - could you help look at this? It seems I have broken the rust
> > bindings here :)
> >
> > Thanks!
> >
> > On Wed, Oct 29, 2025 at 09:07:07PM -0600, Nico Pache wrote:
> > > Hey Lorenzo,
> > >
> > > I put your patchset into the Fedora Koji system to run some CI on it for you.
> > >
> > > It failed to build due to what looks like some Rust bindings.
> > >
> > > Heres the build: https://koji.fedoraproject.org/koji/taskinfo?taskID=138547842
> > >
> > > And x86 build logs:
> > > https://kojipkgs.fedoraproject.org//work/tasks/7966/138547966/build.log
> > >
> > > The error is pretty large but here's a snippet if you want an idea
> > >
> > > error[E0425]: cannot find value `VM_READ` in crate `bindings`
> > >    --> rust/kernel/mm/virt.rs:399:44
> > >     |
> > > 399 |     pub const READ: vm_flags_t = bindings::VM_READ as vm_flags_t;
> > >     |                                            ^^^^^^^ not found in `bindings`
> > > error[E0425]: cannot find value `VM_WRITE` in crate `bindings`
> > >    --> rust/kernel/mm/virt.rs:402:45
> > >     |
> > > 402 |     pub const WRITE: vm_flags_t = bindings::VM_WRITE as vm_flags_t;
> > >     |                                             ^^^^^^^^ not found
> > > in `bindings`
> > > error[E0425]: cannot find value `VM_EXEC` in crate `bindings`
> > >      --> rust/kernel/mm/virt.rs:405:44
> > >       |
> > >   405 |     pub const EXEC: vm_flags_t = bindings::VM_EXEC as vm_flags_t;
> > >       |                                            ^^^^^^^ help: a
> > > constant with a similar name exists: `ET_EXEC`
> > >       |
> > >      ::: /builddir/build/BUILD/kernel-6.18.0-build/kernel-6.18-rc3-16-ge53642b87a4f/linux-6.18.0-0.rc3.e53642b87a4f.31.bitvma.fc44.x86_64/rust/bindings/bindings_generated.rs:13881:1
> > >       |
> > > 13881 | pub const ET_EXEC: u32 = 2;
> > >       | ---------------------- similarly named constant `ET_EXEC` defined here
> > > error[E0425]: cannot find value `VM_SHARED` in crate `bindings`
> > >    --> rust/kernel/mm/virt.rs:408:46
> > >     |
> > > 408 |     pub const SHARED: vm_flags_t = bindings::VM_SHARED as vm_flags_t;
> > >     |                                              ^^^^^^^^^ not found
> > > in `bindings`
> > >
> > > In the next version Ill do the same and continue with the CI testing for you!
> >
> > Thanks much appreciated :)
> >
> > It seems I broke the rust bindings (clearly), have pinged Alice to have a
> > look!
> >
> > May try and repro my side to see if there's something trivial that I could
> > take a look at.
> >
> > I ran this through mm self tests, allmodconfig + a bunch of other checks
> > but ofc enabling rust was not one, I should probably update my scripts [0]
> > to do that too :)
> >
> > Cheers, Lorenzo
> >
> > [0]:https://github.com/lorenzo-stoakes/review-scripts
>
> I can help convert the Rust bindings to work with this approach. I see
> there is a nice and simple vma_test() method for checking a flag, but I
> don't see any equivalent method for setting or unsetting a given bit.
> What would be the best function for Rust to call to set or unset a given
> bit in the vma flags?

Thanks much appreciated!

I was thinking of adding that in but have no C users currently, on respin
can add.

If you give me a rough idea of what needs to be changed I can always try
and wrap that into my respin?

>
> Alice

Thanks, Lorenzo

