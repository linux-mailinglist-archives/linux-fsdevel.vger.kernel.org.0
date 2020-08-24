Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA3C2501F0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Aug 2020 18:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbgHXQ0l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Aug 2020 12:26:41 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:6844 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725780AbgHXQ0i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Aug 2020 12:26:38 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07OGE46L025482;
        Mon, 24 Aug 2020 09:19:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=lfSEnEBzAhVRh0b+ljkilNtl2SEkfLzNaJXp0eeDhQY=;
 b=btW4dmxdf2hk3CnnQ7PggPA+MsAl+emZ1YA9zdupSYUxXS9lX7gOLaZdDktrIFoxpRLb
 OHz69uTdcOYDCVjlTnEldVXMVPC0/cHEJUiZ3DGN/wDFNbzpeRuQyyhE9UcntSGo+hgn
 mPpKd0ggeJK5LA7lGdsy/V8GKo5uJvtVoN8= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 333k6jwjew-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 24 Aug 2020 09:19:08 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 24 Aug 2020 09:19:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A8+bfP1vVYt2eEF3vc+XjKIQFxwEklmmMdyp0dKmo36YKuf75LDkEbTQOvZFtVLuUeKXUV6jwV6p2Azw66ljlJaoMuPIYZvitQK2Oxc7EL09bTjg/uE72qGgNfUidZiT0MEHAFq1rkwMue3r/9hQHhafRhpkhjqaUao7NAe4cV268oCWhkOX1bqD1cVPJbgGFZlQ+0TCJDAQsbxplmO7RI/wzZYK7+dRIQo3bBN1O/sAtsBA5LPqpZMZh6ZXgeSDGrF4sxndVeCtMakqjAsf9aV7Um/Z4YxsRQwHqOsvwbiLH7rrq42Z56fv3x5pS+5eb5+3kRs4ItjTTEcwgGaC5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lfSEnEBzAhVRh0b+ljkilNtl2SEkfLzNaJXp0eeDhQY=;
 b=VoGYZFUc3cDztaA9MQMVc7+Op6XdwShdxpzKWYTdMZultB5JP8dEGU30p63J/R26hOjz5BxbcAEe+9Sbuixid7A2wd3eUFZawB8uOYxMvEdezjdpn1FK9I05aJ3nr2L6NB5tRMyVs2Bz3J+yl9HxmJLCW9RXYyJ+HFx1mGzLxmy0lzvKZgqlMdCgvcXMSSluRzyMCqbXtk8MLeyWG/HP5mJGhC1lXWzDWR5YUYlwjTVrWY/2TIqCRfcXcofGXb/+DIknJJH1m20wFG747M2cAoBvx4dKlchu6LVTU8kspVeRDjFfB5pJoGxHsf9H+XzV1xJ3Um88vY/xneqlBJlhbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lfSEnEBzAhVRh0b+ljkilNtl2SEkfLzNaJXp0eeDhQY=;
 b=DPZUx1ZbHEK1lC9/BCyy8evBKt38xXP2olFDdJ4TieDF5vrQAcSvweSugvQBGnQX3rHcTS4jGm35mxxZ4aczLr6DT6+s+B1VHGgQZmHln58tO9T7KEo1DBp5od4RMDbLmEvvvyf0wWJXGfZgUVXrhyTrK1r9Bm2tYTGvi3wYWRY=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2390.namprd15.prod.outlook.com (2603:10b6:a02:8f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Mon, 24 Aug
 2020 16:19:05 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::354d:5296:6a28:f55e]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::354d:5296:6a28:f55e%6]) with mapi id 15.20.3305.026; Mon, 24 Aug 2020
 16:19:05 +0000
Date:   Mon, 24 Aug 2020 09:19:01 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Dan Schatzberg <schatzberg.dan@gmail.com>
CC:     Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Chris Down <chris@chrisdown.name>,
        Yafang Shao <laoar.shao@gmail.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Michel Lespinasse <walken@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:FILESYSTEMS (VFS and infrastructure)" 
        <linux-fsdevel@vger.kernel.org>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        "open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" 
        <linux-mm@kvack.org>
Subject: Re: [PATCH 2/4] mm: support nesting memalloc_use_memcg()
Message-ID: <20200824161901.GA2401952@carbon.lan>
References: <20200824153607.6595-1-schatzberg.dan@gmail.com>
 <20200824153607.6595-3-schatzberg.dan@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200824153607.6595-3-schatzberg.dan@gmail.com>
X-ClientProxiedBy: BYAPR08CA0021.namprd08.prod.outlook.com
 (2603:10b6:a03:100::34) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by BYAPR08CA0021.namprd08.prod.outlook.com (2603:10b6:a03:100::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25 via Frontend Transport; Mon, 24 Aug 2020 16:19:04 +0000
X-Originating-IP: [2620:10d:c090:400::5:ca10]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3d671afe-4dd5-4eb6-8ee4-08d848496c02
X-MS-TrafficTypeDiagnostic: BYAPR15MB2390:
X-Microsoft-Antispam-PRVS: <BYAPR15MB23907A691D0B770D0A693E64BE560@BYAPR15MB2390.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gCc5hEd1I+t8E4njYekx6RYbXk1e9zc0IB4upti2YCdFo2dXUaqUCeuSWaF9rYXYVwKMKYJ3Q0eedMyeksGmM1Cv6WltNAZhNr/k1xS+pnhiRJkrPGqd3Hm9AxL6k2SWhTpCsX+6YxfmjjJBmSHgyLL4ccLQeL9WcwQMo8p2tmL4nu9W/xYciEpW1bb35I/+BXTQegfWq9uwkYWHttVP0FiJF7MYKjUNQyKxLMjM8kjwM+MwNx4/cb5pR36bvrBqopgGQrHWZ7wjvWHoin1X6vLo9lq6SKmH3bwhwC+iwG9a9z/FH1+9UcD5zgdNqcjCwh19LYPpSPGMZkRXl0mXkRsS2bg2I9eqYamulFS2f1iRTO25hWD2UiglqBu/UenFc5I1ujs9B7St86w5vOnfTg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(346002)(136003)(39860400002)(376002)(66556008)(9686003)(956004)(1076003)(5660300002)(66946007)(66476007)(7416002)(316002)(2906002)(186003)(6486002)(6666004)(16576012)(478600001)(36756003)(83380400001)(8676002)(54906003)(33656002)(4326008)(8936002)(52116002)(86362001)(6916009)(966005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: utIh8Ve99WZjjnf/lKFRp1GwpxL+jMSKyMaN6lcDKomwoVxA7FwDOnW0FDReVLcIpIhGvwJcFwIO12XY+N8pM2LFvyDZ1SEt/Spyn8AVKbyORTFcn4TobKr6Nc/xOa1jjMNeVCI/grfA6Rpi5hd86DweBqR8NaSxKPcffMZdR8iMeOJ8qF4pEWRh+JG0OGzUVY9a6bOthAJZFWuDq3ylsUuE1qm9mdWFytBi6YXOVJJmj2WivtskIDMviEXIwYNyFQHjv87g+IgrLJBiCR6J0CamdXa+d/cILvQNwkbUcGmY7glcnxS06omOY7sllGc51ZycpoVK8QZVQQ6n+/GoWPiZzhd5dJBzZr3v4B6MFXGkn4PmPYqP637xM1fX01tKIFsh3nWfj439ko5Sq3kODXtlLeOE9eVb8sk7pXgk3dRODoZ0k0IqIM0Ka13bJywZIX4tP1RFRZtJ9AaqxfH5gCvdsVvsKC17RysQRoCsEMpJT62ZnBVfwBWoUbVenEQHXKr1x00VqqbVLH6foIeA8vuJ0WJV22MJcgdPRnTyZTYIHa7UAWZKLn17PDZLXV2kQDvbaM0wRTQWXT9brAhu6eReqO2+9nRrhhbebBnpyQsZGcCcaxj6bWEpKc3uya0rjxRqpTb+YPtLdSxkSghUiMpU/SP9Sks/6LwwItou1d4=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d671afe-4dd5-4eb6-8ee4-08d848496c02
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2020 16:19:05.6523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +vPIoOFqwhBItsrVPdUZfVSmcVwLaqhG35g1kwwjEYafduko1MkjbYMMVTK/8H3y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2390
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-24_12:2020-08-24,2020-08-24 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 clxscore=1011 bulkscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 adultscore=0 mlxscore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008240131
X-FB-Internal: deliver
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 24, 2020 at 11:36:00AM -0400, Dan Schatzberg wrote:
> From: Johannes Weiner <hannes@cmpxchg.org>
> 
> The memalloc_use_memcg() function to override the default memcg
> accounting context currently doesn't nest. But the patches to make the
> loop driver cgroup-aware will end up nesting:
> 
> [   98.137605]  alloc_page_buffers+0x210/0x288
> [   98.141799]  __getblk_gfp+0x1d4/0x400
> [   98.145475]  ext4_read_block_bitmap_nowait+0x148/0xbc8
> [   98.150628]  ext4_mb_init_cache+0x25c/0x9b0
> [   98.154821]  ext4_mb_init_group+0x270/0x390
> [   98.159014]  ext4_mb_good_group+0x264/0x270
> [   98.163208]  ext4_mb_regular_allocator+0x480/0x798
> [   98.168011]  ext4_mb_new_blocks+0x958/0x10f8
> [   98.172294]  ext4_ext_map_blocks+0xec8/0x1618
> [   98.176660]  ext4_map_blocks+0x1b8/0x8a0
> [   98.180592]  ext4_writepages+0x830/0xf10
> [   98.184523]  do_writepages+0xb4/0x198
> [   98.188195]  __filemap_fdatawrite_range+0x170/0x1c8
> [   98.193086]  filemap_write_and_wait_range+0x40/0xb0
> [   98.197974]  ext4_punch_hole+0x4a4/0x660
> [   98.201907]  ext4_fallocate+0x294/0x1190
> [   98.205839]  loop_process_work+0x690/0x1100
> [   98.210032]  loop_workfn+0x2c/0x110
> [   98.213529]  process_one_work+0x3e0/0x648
> [   98.217546]  worker_thread+0x70/0x670
> [   98.221217]  kthread+0x1b8/0x1c0
> [   98.224452]  ret_from_fork+0x10/0x18
> 
> where loop_process_work() sets the memcg override to the memcg that
> submitted the IO request, and alloc_page_buffers() sets the override
> to the memcg that instantiated the cache page, which may differ.
> 
> Make memalloc_use_memcg() return the old memcg and convert existing
> users to a stacking model. Delete the unused memalloc_unuse_memcg().
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> Reviewed-by: Shakeel Butt <shakeelb@google.com>
> Acked-by: Roman Gushchin <guro@fb.com>
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>

Hi Dan,

JFYI: I need a similar patch for the bpf memory accounting rework,
so I ended up sending it separately (with some modifications including
different naming): https://lkml.org/lkml/2020/8/21/1464 .

Can you please, rebase your patchset using this patch?

I hope Andrew can pull this standalone patch into 5.9-rc*,
as Shakeel suggested. It will help us to avoid merge conflicts
during the 5.10 merge window.

Thanks!
