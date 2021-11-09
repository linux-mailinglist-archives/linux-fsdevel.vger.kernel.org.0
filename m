Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DDAA44A368
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Nov 2021 02:25:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243155AbhKIB0y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Nov 2021 20:26:54 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:29812 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241517AbhKIBSP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Nov 2021 20:18:15 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A8LmwKm029546;
        Mon, 8 Nov 2021 17:15:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=p+05fbAkDH+oG9y4EgNquICD+QKs3DQ85ghtGkc0SII=;
 b=H8L5VDmrw/S5Z9rV6hJsdZgoW2+3UWJLVOJ9sfwgBgwRXn23NcO9mMxg2PkB047j/Q+c
 iQcY6Yl7pE3BiPxPLAuV/HdvAeQwAO2YA4Suc7O1K7pxOU6TcxV3rjIx4ByEyuiQtQde
 25fGhIMDk+t0BSP4hA8ryPCaj8so0zmlU4E= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3c7c4rs992-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 08 Nov 2021 17:15:16 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Mon, 8 Nov 2021 17:15:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jG2mMf1IDYCm8PsBDT8DrmFttotsj9PM7bRsy/FUG/5sZeZ+yIe/Q1wYevDugjaIu+ECMmFa/MzZbB1CVTx44XxFNXhD+R2nGhNp2LhgA4UG8yEOQ9ewE5sxOtW9BXbZxJND4y0FYjw7Gf7Yfnc62Y7bzFLnO1W3sJD9pFUFbwkEk5C0+vxp+R8FTFLFydsMdx6Yb9PqcwdRaEUNhb/QgAO5cxr61xqvYkcxzMT7XdeVGK5iOvvQp8UehenR9q77C8Ha+q1sKpKvQU8184DuPRMII9xib9/rAfXsCNnnCU5bgCDJvoY4n5jGNuufQvfYSpu1KifhlpQvTnF23M9WmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p+05fbAkDH+oG9y4EgNquICD+QKs3DQ85ghtGkc0SII=;
 b=fNiudRz8RK1l0Oy7jqMLUWJVX1w7T9LV0X99+F8XZKFtgWjl44+k3j09OzGbA4dRgqW5zvK/VvSXwpMnh1FWT6kn5Ob6YyPsWEhevEqI4eZm52TIrZOKri3P8la59Uc/jtTz+7drxwlgua68ss1wij+pLXSuh/wAXbGAxOLdq5azcJ4evpaGvtRrkO3HHi0BnDjHPIceVjq9sGdhGf67e7TT11Cgc5cKIc6zJlxluGgNlFSutBrjPG33jREe0Oba5W5bDM6HILRjf8inQ/VsRTOrgsSb0OG6YLe1LGTiJyHwdsYTixI0wyJYV4QvhCxS+/Jo8tC7qbMjbYFPrZjUjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BY5PR15MB3522.namprd15.prod.outlook.com (2603:10b6:a03:1b5::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10; Tue, 9 Nov
 2021 01:15:14 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::1052:c025:1e48:7f94]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::1052:c025:1e48:7f94%5]) with mapi id 15.20.4669.016; Tue, 9 Nov 2021
 01:15:14 +0000
Date:   Mon, 8 Nov 2021 17:15:09 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Mina Almasry <almasrymina@google.com>
CC:     Michal Hocko <mhocko@suse.com>, Theodore Ts'o <tytso@mit.edu>,
        Greg Thelen <gthelen@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Roman Gushchin <songmuchun@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, <riel@surriel.com>,
        <linux-mm@kvack.org>, <linux-fsdevel@vger.kernel.org>,
        <cgroups@vger.kernel.org>
Subject: Re: [PATCH v1 1/5] mm/shmem: support deterministic charging of tmpfs
Message-ID: <YYnLnciiQDRC/Xv7@carbon.dhcp.thefacebook.com>
References: <20211108211959.1750915-1-almasrymina@google.com>
 <20211108211959.1750915-2-almasrymina@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20211108211959.1750915-2-almasrymina@google.com>
X-ClientProxiedBy: MW4PR03CA0075.namprd03.prod.outlook.com
 (2603:10b6:303:b6::20) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:5806) by MW4PR03CA0075.namprd03.prod.outlook.com (2603:10b6:303:b6::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend Transport; Tue, 9 Nov 2021 01:15:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0fb3f31b-d85f-4362-f3a2-08d9a31e61fc
X-MS-TrafficTypeDiagnostic: BY5PR15MB3522:
X-Microsoft-Antispam-PRVS: <BY5PR15MB3522A0926CCE3B7FAD9FF6A3BE929@BY5PR15MB3522.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:935;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PNl6bkZljviMrAkgG/68p8RJ0wj5M/6Zlo8GSEZfFUulpCQjYrNRjktS6bK/ofEM7NQYte9LE5wM+XvrzhbMhg+EGn1GsyFWpdQoCX2RuqAsEe/jXh3RqiuPPSlooBqNMkncBmBcY79SJtrhTnajqk0Ob9r6HiCDvJFzwAztCbUY4hfBDBZpM7mM9r4q0KSqFSBQ8CJuQIiha+cDjC3A0JzxsWR/7X78i1obziGZR7D3d7kT9O4UMmdfapCh2qaIlrlIGss5XhFy4geDJGWCecI1GoRamsNU5MkAkdb+qhjaHXwqCE84w8Zf8ktNVR/6xgANLq2L6TxzQTueb1SS4oLFCRROIVv0MJTqNTUwvvidqle1Fp4JcxZe6iVfxsNQNjf1DFURcOCPXGYWpy2Kue4BmwGteIw/S2R9mKBabTi36RwMUeyzO9iEBANi/4vV1qyfBSLCJTeSbtXb4JQ2S6pob7PkfwwN0CwfohGZhxzo62IIWFYOap7l197O2+WYtqubUDL3zyshJVXSuGChLQ8jhej8B+jJlKI4Dpit1QXL0olzaJSMWImwqNn7dG5MKhjlRqTCte0XCKkuwD27KQMXyBfIVJw/c5qf6MNbpmLAY/M5bKff/PTqAf5YF7GzRZfay/JYSFzWV7mX/ET0AXO7ggPtqKBSmd+MSfGToxy5uDDZ+uLMyWMQkCDO7fgdOj0lKQchnvIME2Tv1APZ7w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(38100700002)(186003)(6506007)(6916009)(4326008)(6666004)(316002)(9686003)(54906003)(5660300002)(30864003)(66946007)(66556008)(55016002)(66476007)(86362001)(7696005)(83380400001)(8936002)(508600001)(52116002)(8676002)(7416002)(17423001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EV1T+TH4P7+na9PnUImB3ckzIyUidxvlUxpXdGYgU8u87hB04ZdpNXCnE/jw?=
 =?us-ascii?Q?IkLV+txKgh3Vt+j5pOPa1JQIS+VnKp3EQgQzV92Tm1y7sL1xzP7Wht8y1sb3?=
 =?us-ascii?Q?tXPxDYWL/3yrcccjxmZu+8I1VZCPZj2WIviuIHMToSgYHoPPgHf8Khgy+mJ8?=
 =?us-ascii?Q?2LWPtfPp83+rR7cW2MAzdlBtPGpppYnwuyTbfbsmlwokgmubtYfwvjGamfbz?=
 =?us-ascii?Q?1Sul2lXOt8cpCPCGNTY6SOXbAVVO+QGBlIp5GMgCVOiWI0e7eZud0FoI0sQ9?=
 =?us-ascii?Q?yiqnBBpSWesGm5CEN7IbJ+BTa4MMuoWtlYiyT53PCa/3qOwkEkuDKelLE8Fu?=
 =?us-ascii?Q?hxkJeX8XUvscfsOyFMiYwJFYgEFsrUu0QyjbzPEXnW8bz/eNffXUzn5XoIX+?=
 =?us-ascii?Q?pbjl9kAp5jq4cLyrISr4FdMWgSSVfYI8hNWSUvxNAOOpfKvxtqAKSTwfU+La?=
 =?us-ascii?Q?P1ltNjCYTOjRMJ5c9Q8jOhaQLwCAgztk0ovs3IA1jUtMGJA6qvKuwf2RDq6d?=
 =?us-ascii?Q?DOQaoF55TVcd8o08SCZAkZUQcV4zPNhz0NuQM+uPWV0lPPan3J4P5fdh39Lj?=
 =?us-ascii?Q?SW9SU/+M5Uc/MIG1QKOhXPs46MzLoLlz4YWIiSi3HrmKDYcB85WPbt8T8Bu/?=
 =?us-ascii?Q?JGWX609AdBNJDBElOsfya3dT1JHpQDaDbyflEPN2+S7h5wEGDPQ4P6FcQ3Pq?=
 =?us-ascii?Q?WOv20Jp58RMOlfti0w3Ale4uksCVtT5TAjw+k419rbfEDK9REOY75dFh6Sct?=
 =?us-ascii?Q?jgQY/gWH54K4fBOtRQuyLdAwPm0l89Bd9JjZ+umtPb+MzyEUovgKJArFwK//?=
 =?us-ascii?Q?DchxC1mhw9qJF12hTPYGqLO51oRuLu83cVGsCiG89/RUUkF1BwFyFUjbYqN9?=
 =?us-ascii?Q?gNgO7TgPlRYqHPMsCl4QnF2NzUicUva7senEQXqqqHXNKAuhQjECkNolHX+G?=
 =?us-ascii?Q?NOhyU++D8+ktxw0M9QbWJrDDw5uDBGdihW+9pgeDY+oKqf9EZiHhl3gXkKjr?=
 =?us-ascii?Q?JtzDYFjH6xKT51oANPFVyBBX7zP8SP+fYkQ1RUtXmAZR5o6+/p4G18kmqXrL?=
 =?us-ascii?Q?ipKonvgEyuN2bTc4Hs5+DBra9L9LDZrQODnU5JrCKway+zNEFhF7cjhG1g36?=
 =?us-ascii?Q?39DJKqO4Ww47t6RJQonZoXGnRLd3NBxNYTSHWpgNYPm4IMcacEvRaLWzQZOw?=
 =?us-ascii?Q?/P7aK0jkAVWMSVPB4FST1zk3gOTbloS/xZvbgf+rUueucQvSiEdQ+GtLh1Wu?=
 =?us-ascii?Q?eJ79Xd4ZiCN8rm/LKpDMEZH7N4bL2q2MdXZG3NJ2g5CEApCGETTQ9XcuLcNj?=
 =?us-ascii?Q?D16XWHxIsTBVtxOhHVDfGKWS1BLTRnrxoIO8m6OW2XkrYaIkFVVZDxg5946D?=
 =?us-ascii?Q?fr804shqSuzCmI3wHbTI89Y0+g1JVotMBpZROdGnahVb5OXKH9QD36ZdZteS?=
 =?us-ascii?Q?RfUEt6Uh7rSaf+Wj+lTQdww334T0DrWVGK6jhJO/FwFd2UQUfNDeku26FH1J?=
 =?us-ascii?Q?SR9D0lyHLEC6AaBgceXrcdrczjHuFUKV0XdjJzXqJGSNAsI+PJ4K1nAMY6Yw?=
 =?us-ascii?Q?g+gdHNZlH+sxSnRjLVmnlJ0+PjcfyMJhB1/0O0Zm?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fb3f31b-d85f-4362-f3a2-08d9a31e61fc
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2021 01:15:13.9928
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BqtkwphIi98S11rHmHKyuoPt56P8KOB0X3fJaAxrNbfMQR67T4EMoYGJEKfu6MxJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3522
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: BDrqSlXaM5hjPJQC5IHNQjyNRL914R6e
X-Proofpoint-ORIG-GUID: BDrqSlXaM5hjPJQC5IHNQjyNRL914R6e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-08_07,2021-11-08_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 lowpriorityscore=0 bulkscore=0 spamscore=0 clxscore=1011 malwarescore=0
 phishscore=0 impostorscore=0 priorityscore=1501 suspectscore=0
 adultscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111090004
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 08, 2021 at 01:19:55PM -0800, Mina Almasry wrote:
> Add memcg= option to shmem mount.
> 
> Users can specify this option at mount time and all data page charges
> will be charged to the memcg supplied.
> 
> Signed-off-by: Mina Almasry <almasrymina@google.com>

Hello, Mina!

Overall I think it's a useful option and I do see it being used outside
of tmpfs usecase. In certain cases a user might want to use memory
cgroups to limit the amount of pagecache and something like what you've
suggested might be useful. I agree with Michal that it opens some
hard questions about certain corner cases, but I don't think there any
show stoppers (at least as now).

> 
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Theodore Ts'o <tytso@mit.edu>
> Cc: Greg Thelen <gthelen@google.com>
> Cc: Shakeel Butt <shakeelb@google.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Roman Gushchin <songmuchun@bytedance.com>

This is clearly not my email.

> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
> Cc: Muchun Song <songmuchun@bytedance.com>
> Cc: riel@surriel.com
> Cc: linux-mm@kvack.org
> Cc: linux-fsdevel@vger.kernel.org
> Cc: cgroups@vger.kernel.org
> 
> ---
>  fs/super.c                 |   3 ++
>  include/linux/fs.h         |   5 ++
>  include/linux/memcontrol.h |  46 ++++++++++++++--
>  mm/filemap.c               |   2 +-
>  mm/memcontrol.c            | 104 ++++++++++++++++++++++++++++++++++++-
>  mm/shmem.c                 |  50 +++++++++++++++++-
>  6 files changed, 201 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/super.c b/fs/super.c
> index 3bfc0f8fbd5bc..8aafe5e4e6200 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -24,6 +24,7 @@
>  #include <linux/export.h>
>  #include <linux/slab.h>
>  #include <linux/blkdev.h>
> +#include <linux/memcontrol.h>
>  #include <linux/mount.h>
>  #include <linux/security.h>
>  #include <linux/writeback.h>		/* for the emergency remount stuff */
> @@ -180,6 +181,7 @@ static void destroy_unused_super(struct super_block *s)
>  	up_write(&s->s_umount);
>  	list_lru_destroy(&s->s_dentry_lru);
>  	list_lru_destroy(&s->s_inode_lru);
> +	mem_cgroup_set_charge_target(&s->s_memcg_to_charge, NULL);
>  	security_sb_free(s);
>  	put_user_ns(s->s_user_ns);
>  	kfree(s->s_subtype);
> @@ -292,6 +294,7 @@ static void __put_super(struct super_block *s)
>  		WARN_ON(s->s_dentry_lru.node);
>  		WARN_ON(s->s_inode_lru.node);
>  		WARN_ON(!list_empty(&s->s_mounts));
> +		mem_cgroup_set_charge_target(&s->s_memcg_to_charge, NULL);
>  		security_sb_free(s);
>  		fscrypt_sb_free(s);
>  		put_user_ns(s->s_user_ns);
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 3afca821df32e..59407b3e7aee3 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1567,6 +1567,11 @@ struct super_block {
>  	struct workqueue_struct *s_dio_done_wq;
>  	struct hlist_head s_pins;
> 
> +#ifdef CONFIG_MEMCG
> +	/* memcg to charge for pages allocated to this filesystem */
> +	struct mem_cgroup *s_memcg_to_charge;
> +#endif
> +
>  	/*
>  	 * Owning user namespace and default context in which to
>  	 * interpret filesystem uids, gids, quotas, device nodes,
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 0c5c403f4be6b..e9a64c1b8295b 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -27,6 +27,7 @@ struct obj_cgroup;
>  struct page;
>  struct mm_struct;
>  struct kmem_cache;
> +struct super_block;
> 
>  /* Cgroup-specific page state, on top of universal node page state */
>  enum memcg_stat_item {
> @@ -689,7 +690,8 @@ static inline bool mem_cgroup_below_min(struct mem_cgroup *memcg)
>  		page_counter_read(&memcg->memory);
>  }
> 
> -int __mem_cgroup_charge(struct folio *folio, struct mm_struct *mm, gfp_t gfp);
> +int __mem_cgroup_charge(struct folio *folio, struct mm_struct *mm, gfp_t gfp,
> +			struct address_space *mapping);
> 
>  /**
>   * mem_cgroup_charge - Charge a newly allocated folio to a cgroup.
> @@ -710,7 +712,7 @@ static inline int mem_cgroup_charge(struct folio *folio, struct mm_struct *mm,
>  {
>  	if (mem_cgroup_disabled())
>  		return 0;
> -	return __mem_cgroup_charge(folio, mm, gfp);
> +	return __mem_cgroup_charge(folio, mm, gfp, NULL);
>  }
> 
>  int mem_cgroup_swapin_charge_page(struct page *page, struct mm_struct *mm,
> @@ -923,6 +925,16 @@ static inline bool mem_cgroup_online(struct mem_cgroup *memcg)
>  	return !!(memcg->css.flags & CSS_ONLINE);
>  }
> 
> +bool is_remote_oom(struct mem_cgroup *memcg_under_oom);
> +void mem_cgroup_set_charge_target(struct mem_cgroup **target,
> +				  struct mem_cgroup *memcg);
> +struct mem_cgroup *mem_cgroup_get_from_path(const char *path);
> +/**
> + * User is responsible for providing a buffer @buf of length @len and freeing
> + * it.
> + */
> +int mem_cgroup_get_name_from_sb(struct super_block *sb, char *buf, size_t len);
> +
>  void mem_cgroup_update_lru_size(struct lruvec *lruvec, enum lru_list lru,
>  		int zid, int nr_pages);
> 
> @@ -1217,8 +1229,15 @@ static inline bool mem_cgroup_below_min(struct mem_cgroup *memcg)
>  	return false;
>  }
> 
> -static inline int mem_cgroup_charge(struct folio *folio,
> -		struct mm_struct *mm, gfp_t gfp)
> +static inline int __mem_cgroup_charge(struct folio *folio, struct mm_struct *mm,
> +				      gfp_t gfp_mask,
> +				      struct address_space *mapping)
> +{
> +	return 0;
> +}
> +
> +static inline int mem_cgroup_charge(struct folio *folio, struct mm_struct *mm,
> +				    gfp_t gfp_mask)
>  {
>  	return 0;
>  }
> @@ -1326,6 +1345,25 @@ static inline void mem_cgroup_iter_break(struct mem_cgroup *root,
>  {
>  }
> 
> +static inline bool is_remote_oom(struct mem_cgroup *memcg_under_oom)
> +{
> +	return false;
> +}
> +
> +static inline void mem_cgroup_set_charge_target(struct mem_cgroup **target,
> +						struct mem_cgroup *memcg)
> +{
> +}
> +
> +static inline int mem_cgroup_get_name_from_sb(struct super_block *sb, char *buf,
> +					      size_t len)
> +{
> +	if (len < 1)
> +		return -EINVAL;
> +	buf[0] = '\0';
> +	return 0;
> +}
> +
>  static inline int mem_cgroup_scan_tasks(struct mem_cgroup *memcg,
>  		int (*fn)(struct task_struct *, void *), void *arg)
>  {
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 6844c9816a864..75e81dfd2c580 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -903,7 +903,7 @@ noinline int __filemap_add_folio(struct address_space *mapping,
>  	folio->index = index;
> 
>  	if (!huge) {
> -		error = mem_cgroup_charge(folio, NULL, gfp);
> +		error = __mem_cgroup_charge(folio, NULL, gfp, mapping);
>  		VM_BUG_ON_FOLIO(index & (folio_nr_pages(folio) - 1), folio);
>  		if (error)
>  			goto error;
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 781605e920153..389d2f2be9674 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2580,6 +2580,103 @@ void mem_cgroup_handle_over_high(void)
>  	css_put(&memcg->css);
>  }
> 
> +/*
> + * Non error return value must eventually be released with css_put().
> + */
> +struct mem_cgroup *mem_cgroup_get_from_path(const char *path)
> +{
> +	struct file *file;
> +	struct cgroup_subsys_state *css;
> +	struct mem_cgroup *memcg;
> +
> +	file = filp_open(path, O_DIRECTORY | O_RDONLY, 0);
> +	if (IS_ERR(file))
> +		return (struct mem_cgroup *)file;
> +
> +	css = css_tryget_online_from_dir(file->f_path.dentry,
> +					 &memory_cgrp_subsys);
> +	if (IS_ERR(css))
> +		memcg = (struct mem_cgroup *)css;
> +	else
> +		memcg = container_of(css, struct mem_cgroup, css);
> +
> +	fput(file);
> +	return memcg;
> +}
> +
> +/*
> + * Get the name of the optional charge target memcg associated with @sb.  This
> + * is the cgroup name, not the cgroup path.
> + */
> +int mem_cgroup_get_name_from_sb(struct super_block *sb, char *buf, size_t len)
> +{
> +	struct mem_cgroup *memcg;
> +	int ret = 0;
> +
> +	buf[0] = '\0';
> +
> +	rcu_read_lock();
> +	memcg = rcu_dereference(sb->s_memcg_to_charge);
> +	if (memcg && !css_tryget_online(&memcg->css))
> +		memcg = NULL;
> +	rcu_read_unlock();
> +
> +	if (!memcg)
> +		return 0;
> +
> +	ret = cgroup_path(memcg->css.cgroup, buf + len / 2, len / 2);
> +	if (ret >= len / 2)
> +		strcpy(buf, "?");
> +	else {
> +		char *p = mangle_path(buf, buf + len / 2, " \t\n\\");
> +
> +		if (p)
> +			*p = '\0';
> +		else
> +			strcpy(buf, "?");
> +	}
> +
> +	css_put(&memcg->css);
> +	return ret < 0 ? ret : 0;
> +}
> +
> +/*
> + * Set or clear (if @memcg is NULL) charge association from file system to
> + * memcg.  If @memcg != NULL, then a css reference must be held by the caller to
> + * ensure that the cgroup is not deleted during this operation.
> + */
> +void mem_cgroup_set_charge_target(struct mem_cgroup **target,
> +				  struct mem_cgroup *memcg)
> +{
> +	if (memcg)
> +		css_get(&memcg->css);
> +	memcg = xchg(target, memcg);
> +	if (memcg)
> +		css_put(&memcg->css);
> +}
> +
> +/*
> + * Returns the memcg to charge for inode pages.  If non-NULL is returned, caller
> + * must drop reference with css_put().  NULL indicates that the inode does not
> + * have a memcg to charge, so the default process based policy should be used.
> + */
> +static struct mem_cgroup *
> +mem_cgroup_mapping_get_charge_target(struct address_space *mapping)
> +{
> +	struct mem_cgroup *memcg;
> +
> +	if (!mapping)
> +		return NULL;
> +
> +	rcu_read_lock();
> +	memcg = rcu_dereference(mapping->host->i_sb->s_memcg_to_charge);
> +	if (memcg && !css_tryget_online(&memcg->css))
> +		memcg = NULL;
> +	rcu_read_unlock();
> +
> +	return memcg;
> +}
> +
>  static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
>  			unsigned int nr_pages)
>  {
> @@ -6678,12 +6775,15 @@ static int charge_memcg(struct folio *folio, struct mem_cgroup *memcg,
>  	return ret;
>  }
> 
> -int __mem_cgroup_charge(struct folio *folio, struct mm_struct *mm, gfp_t gfp)
> +int __mem_cgroup_charge(struct folio *folio, struct mm_struct *mm, gfp_t gfp,
> +			struct address_space *mapping)
>  {
>  	struct mem_cgroup *memcg;
>  	int ret;
> 
> -	memcg = get_mem_cgroup_from_mm(mm);
> +	memcg = mem_cgroup_mapping_get_charge_target(mapping);
> +	if (!memcg)
> +		memcg = get_mem_cgroup_from_mm(mm);
>  	ret = charge_memcg(folio, memcg, gfp);
>  	css_put(&memcg->css);

This function becomes very non-obvious as it's taking a folio (ex-page),
mm and now mapping as arguments. I'd just add a new wrapper around
charge_memcg() instead.

I'd also merge the next patch into this one.

Thanks!
