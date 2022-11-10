Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89652624BBC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Nov 2022 21:25:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbiKJUZn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Nov 2022 15:25:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiKJUZl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Nov 2022 15:25:41 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9572D62CE;
        Thu, 10 Nov 2022 12:25:40 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2AAKGbOr031700;
        Thu, 10 Nov 2022 20:25:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2022-7-12;
 bh=4eoowv03BqkL6iv1KoQXDgV5U/jev4KlQOJKxd1WV+E=;
 b=Epr8QUfm2WFiyIH2rceUgViDVyo/tIZB7mkTPE9zxpZevKLuy/Kc9DnvVd/X8NkU5ow+
 JgcFYaLtjXYjaJu2p10WirzTdGXF80sDbcMltrSrv1L4nCEDRBL3LGEkTCnDSuK8LHy4
 ASETA4XjnEJJC/sft2xnRAI7gA3+UcTsqjCcDfjJR294n+q/j2iC3PiwLzQPVd+NDtvp
 9D5n42GLjt80mWCxC3lF4JNTA2bK0WXpVha/Eg0iBtNW8J3dFiwz1Se89JYsaSPV1Fo1
 eUjnQvkr8t+rejqGK3zCM22syMcocSeBpyAHpAnmpaBxSg187bXyAuRSIWvw3LfhsYok Ug== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ks86hr19e-27
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Nov 2022 20:25:35 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AAJ9hq9009676;
        Thu, 10 Nov 2022 20:04:26 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2048.outbound.protection.outlook.com [104.47.73.48])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kpcq5em02-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Nov 2022 20:04:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ix4K7E/QNjd3McTWCWh+txAvW1fk5NQDfjX+O3EqPTcWtQg2u9U/f7ykEGY0miqK47bEbmeh5DPZ8YnG0+dWP2od8tMrlLWkHIxT6ns8AteqpKsclzhHaYRsXAv7FePOoEMaqlXV8QLGCclyZ4xZp9mkRqZQGRYmfInLcisc1bSgRNtXT1EbTneCIeZDMROswbD1+FLJcjxyYJdI990RJiQ8AbB38wGdIROZW1ZeMIms9CpDfdu3jUK44UgEdZfMQdAiB+iDM1EjYI2meyvLYO5cQ78mRfcsU1L7xzdjkThHhC/70EPYN+dnPWFm7e9NiQVHaoN8wWLvWEkCUc6owQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4eoowv03BqkL6iv1KoQXDgV5U/jev4KlQOJKxd1WV+E=;
 b=FNKBHug/noB6GWRHDhOaMk018f9ALWNMMhL+EyLXbjR3d2R/S/vM1FqIUm/1r3kyFa0SSQeKOxqrol3WtUSCf06YnaKSGq8SaDxK+omDuLIwWtE26JbF/Cp5ESv/YC+Qdfi4g6fIkBwv3oPzYV6+FW18htjW5XuW3tWLA7CIF5aMj1ZiiOSATiQOSUVXUckKhk99RLEcPK4NHO+qrjGPrm6e7V9SkwnFUAxtru1jyCRbdmw8naoIQXQ6cIiMawaOvghhknkbBlwSGD5SO9dfxm8TfNsu+93100s7PXAZY17R1UmdqJyE5+LuIEyzl5dnVd58t1W8yVFMHxIxJc9Bgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4eoowv03BqkL6iv1KoQXDgV5U/jev4KlQOJKxd1WV+E=;
 b=C1uTMASCQeu74KLpQt7bjFkOe2tGC0+13s26/5kFm4sMcbcbfECeb7HBdZTvd3Wm49ArUs4FubEuTG6jKz/FZUP4rrfqmc8o+ApPnes5n0oFNkP7EikWDN83kTHYtc2pFGo8YTAxd13KjrPlhIx3Ag5eTbZwXCTfocPC+GMLDtQ=
Received: from MN2PR10MB4173.namprd10.prod.outlook.com (2603:10b6:208:1d1::19)
 by DS7PR10MB5200.namprd10.prod.outlook.com (2603:10b6:5:3a6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Thu, 10 Nov
 2022 20:04:23 +0000
Received: from MN2PR10MB4173.namprd10.prod.outlook.com
 ([fe80::d9a5:dc39:935b:21bf]) by MN2PR10MB4173.namprd10.prod.outlook.com
 ([fe80::d9a5:dc39:935b:21bf%7]) with mapi id 15.20.5813.013; Thu, 10 Nov 2022
 20:04:23 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v3 0/3] fsnotify: fix softlockups iterating over d_subdirs
In-Reply-To: <CAOQ4uxgG=E+3CwpQAE__YGt7vdW77n0nTe6cExPTERBNUN0a0g@mail.gmail.com>
References: <20221021010310.29521-1-stephen.s.brennan@oracle.com>
 <20221028001016.332663-1-stephen.s.brennan@oracle.com>
 <20221101175144.yu3l5qo5gfwfpatt@quack3> <877d0eh03t.fsf@oracle.com>
 <CAOQ4uxgG=E+3CwpQAE__YGt7vdW77n0nTe6cExPTERBNUN0a0g@mail.gmail.com>
Date:   Thu, 10 Nov 2022 12:04:21 -0800
Message-ID: <87h6z6fuey.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SA0PR13CA0025.namprd13.prod.outlook.com
 (2603:10b6:806:130::30) To MN2PR10MB4173.namprd10.prod.outlook.com
 (2603:10b6:208:1d1::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4173:EE_|DS7PR10MB5200:EE_
X-MS-Office365-Filtering-Correlation-Id: 689339e2-c10a-4738-c632-08dac356c31b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: egZUmjIGp32oxJGcjiINFUmU4ch299oR25YB71XdLt4LDjgO4G5TjJTkTlyYNjri+eMpp1TmDqb7VBX7lVzYyHATv1zmzRDaPaOQwCRPKpnYWJ1aQJSzhh4K/sFyFhqG+0y/ukvojs93JrlyG13QkXgvIdc9fCr4TwY4zu2/7Gwl8WNOjpBaugWaHY5bvA46sc8ZSCe+3PYgjC56Q5Rg3HEppOzEJEe1RMHqC9MFvqtPybEIY+rfRIIsDBTTayYA/X1yOGtnQTljwjFNQX9pJW2mLF6jaoqq8T3sHHjOOz4eMv//AGsIpftN2jKNO7syy2mekK+lttMckeZrZrIbFJD6jj22zAlScBPIi3Kwt/1ubTT7nKYNZpUi+TCvTYp2HlztLwce6KACyafBO9zjueSyVxvOOhDQW4/wgtbBXXg9f97Hk+Fj6SocSCuqE2st1VruY0FBB7/TRVr92dKSPtdXZ1A4hlvIJL+rBGbKrVPsELXIny8DQVNel3z/hoVyuMl/rFj8uaz4lGgyxgApmlXoXo+BMwu0jkaqXA9cV9QDQe3i7rQQbUHtgaR6PETwtoc1xZff82w6kXCdPie7xzSjxFK5js9Jb8apUnsxRlPB+rvIz0ZWfUE2odd/FmUZ0GJodmxyboNq14fYEWNgViArpS4NJgTFnjmgmoR2jOzK/pIFOz7HHcXCz5TNNUvP9MYd5My0gFdzAKFisIHldg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4173.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(346002)(376002)(136003)(39860400002)(451199015)(41300700001)(2906002)(5660300002)(8936002)(6506007)(6916009)(66476007)(66946007)(54906003)(66556008)(316002)(36756003)(38100700002)(8676002)(4326008)(478600001)(83380400001)(6512007)(186003)(86362001)(26005)(53546011)(6486002)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lWXyb0uAm5qQGArr1Bdolqca0BHcGM1c4QQau9ADpNR0kkfXpR/9ZdxkroGw?=
 =?us-ascii?Q?u3wIXmw/x59tEFZFf/tz7PE0Gu6QNF+79XdmnnD6e0CQpYf40vBqwEGYiIBN?=
 =?us-ascii?Q?J07QaA9qd1ZhCtTMWGJX1eXUVqUewLlyaO8TSq6QG90F39o02W0ZQBCYUFDN?=
 =?us-ascii?Q?sNC+Kgl+Ciw5MurLSkiA7rS//rxhlA4o8V5udGcnyFy/3vN1ZFTj9b6WTpSq?=
 =?us-ascii?Q?Fp79Wu5oJkv3Ifw03eRS/pY9CBFhRnd3OxlJHI5gEO54zz1cCpf8kvSUflyA?=
 =?us-ascii?Q?E/FWazhLSn7ZeEO3K31JNnTz7ocxcMA2VixGc0+4H8sAgNeV+K5InKgQDK6l?=
 =?us-ascii?Q?fPl6P3g8wfHvK/QuQwM7gvhNchHdin4jOnbMQb3zEaD4hZkMiWN3iVSF1j/D?=
 =?us-ascii?Q?6/Rg1T7zXTtKonEZOfb7CExu7cSMzyEdqJkiUBTmYO9xDZ+s5MIq8/r52Vvk?=
 =?us-ascii?Q?MWrIW0pMRg0gOZqpCTFZIKonXw7JnL8OfMsPliV+Qs1tU1LF/xJTUz6B5lPD?=
 =?us-ascii?Q?tHqqXvpGYsYs4G/WULu/xUR8tWWKThynxocLndepNTxlTn5t8cHigusXo6xg?=
 =?us-ascii?Q?qhqQC+0YPql4sMgcEJU9arfGJaedlbt/jGSCBV2iD18E1piAQXpTwbdowBca?=
 =?us-ascii?Q?URSSV+n3l+pJRKau6MaR4DHy2HzLKjhLikighef1D2BwGGaiW9AsQuyrPsqE?=
 =?us-ascii?Q?e85ehWkLAxTLw2Sai3hp/cqd0hAASSUdvwh49enBmOnRVwy3ECTNBLwNXSW+?=
 =?us-ascii?Q?Uq4syox2WZgFokQqeXRKBlJoXTJrr/0glofRmlz7UXdIsJ69C/4SsDA9gFjN?=
 =?us-ascii?Q?z5O+B8VKF6Zzhhu9N+gU42VGBM5ppqHIaPmqmBMYtEtQBw1lhODy2y18q/uj?=
 =?us-ascii?Q?gXFkiv/UGPrW+wVJ3UvBON+JhKro+3kSto4WVVKJLx4YtkzSx7eV49oPSj4t?=
 =?us-ascii?Q?lwXc2kH2Opf5xG5//rUYIictExZoJ1312fL4Ski0lwzFVUA7tmLUIZd9+ehF?=
 =?us-ascii?Q?eSmWZUOTkm7WxTbScsFfvvtPozuEzHZx5+Ec97RgLp/wUo64hhwDfYkW26W/?=
 =?us-ascii?Q?aVLeNHsHiQma86FhyIfAaE6rRX6xOaFQkiyusyckn+ZXovqWbdb/641wtLds?=
 =?us-ascii?Q?cZdzzFYdawSf4XCsCFwR/85BSuVjiFzjwxS9gl9kkuH4R1sHb599TC2PnJ7c?=
 =?us-ascii?Q?cBodbnzUjrFBs/tN8Pmz/1OAqo6VSBhpT4qCbI37kLYZ42pJsSa/khKaBklK?=
 =?us-ascii?Q?JujwvrKJ7nKI4soSW/rE4AyxzWq96ddLdBTPuwYP1lWQWe7Pk4ni5Eg5KR4a?=
 =?us-ascii?Q?KWku5x8LZzqzNgENPIkerF0osteBA9aV919qsizICoYmGKn4Rze3WdeGWEmF?=
 =?us-ascii?Q?gD5jlrmRGjsgrwOoH9RQ5NZ1WyuqjaRAiH6slEYTiznQHP74K6+a6K9NX9eZ?=
 =?us-ascii?Q?PicgO9neJ/U7CrUYq62V3rg+TUs35fK2D5AXNBy7ZDCMXmR8IHHgjBYWypYS?=
 =?us-ascii?Q?+wSQazrPle3gH/Q6Xgeq3scPTXuehGXQYm03bS2nhS5HTKE/lXq/T6/niH7t?=
 =?us-ascii?Q?VZFrkC0uBLQYSAiVlatILE/+uIb2hhZPxuCaS/m9jSe7mcJUqEdkc1hbXZTA?=
 =?us-ascii?Q?Gw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 689339e2-c10a-4738-c632-08dac356c31b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4173.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2022 20:04:23.6514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BZz/AN7TUVTaagMwpgchlI6b/oyFyqx+XL4fIwvZ+fazNk6ztuYjfT+n5RpLtfpb6wyd7+dQBzTvsen8Xka9R+iXZn6tC7bIDS37mz+XuVs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5200
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-10_12,2022-11-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211100141
X-Proofpoint-GUID: _isaNY94h-ReeHXA_t_ljJFzjq53wzyi
X-Proofpoint-ORIG-GUID: _isaNY94h-ReeHXA_t_ljJFzjq53wzyi
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Amir Goldstein <amir73il@gmail.com> writes:
[...]
> IIUC, patches #1+#3 fix a reproducible softlock, so if Al approves them,
> I see no reason to withhold.
>
> With patches #1+#3 applied, the penalty is restricted to adding or
> removing/destroying multiple marks on very large dirs or dirs with
> many negative dentries.
>
> I think that fixing the synthetic test case of multiple added marks
> is rather easy even without DCACHE_FSNOTIFY_PARENT_WATCHED.
> Something like the attached patch is what Jan had suggested in the
> first place.
>
> The synthetic test case of concurrent add/remove watch on the same
> dir may still result in multiple children iterations, but that will usually
> not be avoided even with DCACHE_FSNOTIFY_PARENT_WATCHED
> and probably not worth optimizing for.
>
> Thoughts?

If I understand your train of thought, your below patch would take the
place of my patch #2, since #3 requires we not hold a spinlock during
fsnotify_update_children_dentry_flags().

And since you fully rely on dentry accessors to lazily clear flags, you
don't need to have the mutual exclusion provided by the inode lock.

I like that a lot.

However, the one thing I see here is that if we no longer hold the inode
lock, patch #3 needs to be re-examined: it assumes that dentries can't
be removed or moved around, and that assumption is only true with the
inode lock held.

I'll test things out with this patch replacing #2 and see how things
shake out. Maybe I can improve #3.

Thanks,
Stephen

>
> Thanks,
> Amir.
> From c8ea1d84397c26ce334bff9d9f721400cebb88dd Mon Sep 17 00:00:00 2001
> From: Amir Goldstein <amir73il@gmail.com>
> Date: Wed, 2 Nov 2022 10:28:01 +0200
> Subject: [PATCH] fsnotify: clear PARENT_WATCHED flags lazily
>
> Call fsnotify_update_children_dentry_flags() to set PARENT_WATCHED flags
> only when parent starts watching children.
>
> When parent stops watching children, clear false positive PARENT_WATCHED
> flags lazily in __fsnotify_parent() for each accessed child.
>
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  fs/notify/fsnotify.c             | 26 ++++++++++++++++++++------
>  fs/notify/fsnotify.h             |  3 ++-
>  fs/notify/mark.c                 | 32 +++++++++++++++++++++++++++++---
>  include/linux/fsnotify_backend.h |  8 +++++---
>  4 files changed, 56 insertions(+), 13 deletions(-)
>
> diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
> index 1e541a9bd12b..f60078d6bb97 100644
> --- a/fs/notify/fsnotify.c
> +++ b/fs/notify/fsnotify.c
> @@ -103,17 +103,13 @@ void fsnotify_sb_delete(struct super_block *sb)
>   * parent cares.  Thus when an event happens on a child it can quickly tell
>   * if there is a need to find a parent and send the event to the parent.
>   */
> -void __fsnotify_update_child_dentry_flags(struct inode *inode)
> +void fsnotify_update_children_dentry_flags(struct inode *inode, bool watched)
>  {
>  	struct dentry *alias;
> -	int watched;
>  
>  	if (!S_ISDIR(inode->i_mode))
>  		return;
>  
> -	/* determine if the children should tell inode about their events */
> -	watched = fsnotify_inode_watches_children(inode);
> -
>  	spin_lock(&inode->i_lock);
>  	/* run all of the dentries associated with this inode.  Since this is a
>  	 * directory, there damn well better only be one item on this list */
> @@ -140,6 +136,24 @@ void __fsnotify_update_child_dentry_flags(struct inode *inode)
>  	spin_unlock(&inode->i_lock);
>  }
>  
> +/*
> + * Lazily clear false positive PARENT_WATCHED flag for child whose parent had
> + * stopped wacthing children.
> + */
> +static void fsnotify_update_child_dentry_flags(struct inode *inode,
> +					       struct dentry *dentry)
> +{
> +	spin_lock(&dentry->d_lock);
> +	/*
> +	 * d_lock is a sufficient barrier to prevent observing a non-watched
> +	 * parent state from before the fsnotify_update_children_dentry_flags()
> +	 * or fsnotify_update_flags() call that had set PARENT_WATCHED.
> +	 */
> +	if (!fsnotify_inode_watches_children(inode))
> +		dentry->d_flags &= ~DCACHE_FSNOTIFY_PARENT_WATCHED;
> +	spin_unlock(&dentry->d_lock);
> +}
> +
>  /* Are inode/sb/mount interested in parent and name info with this event? */
>  static bool fsnotify_event_needs_parent(struct inode *inode, struct mount *mnt,
>  					__u32 mask)
> @@ -208,7 +222,7 @@ int __fsnotify_parent(struct dentry *dentry, __u32 mask, const void *data,
>  	p_inode = parent->d_inode;
>  	p_mask = fsnotify_inode_watches_children(p_inode);
>  	if (unlikely(parent_watched && !p_mask))
> -		__fsnotify_update_child_dentry_flags(p_inode);
> +		fsnotify_update_child_dentry_flags(p_inode, dentry);
>  
>  	/*
>  	 * Include parent/name in notification either if some notification
> diff --git a/fs/notify/fsnotify.h b/fs/notify/fsnotify.h
> index fde74eb333cc..bce9be36d06b 100644
> --- a/fs/notify/fsnotify.h
> +++ b/fs/notify/fsnotify.h
> @@ -74,7 +74,8 @@ static inline void fsnotify_clear_marks_by_sb(struct super_block *sb)
>   * update the dentry->d_flags of all of inode's children to indicate if inode cares
>   * about events that happen to its children.
>   */
> -extern void __fsnotify_update_child_dentry_flags(struct inode *inode);
> +extern void fsnotify_update_children_dentry_flags(struct inode *inode,
> +						  bool watched);
>  
>  extern struct kmem_cache *fsnotify_mark_connector_cachep;
>  
> diff --git a/fs/notify/mark.c b/fs/notify/mark.c
> index fcc68b8a40fd..614bce0e7261 100644
> --- a/fs/notify/mark.c
> +++ b/fs/notify/mark.c
> @@ -176,6 +176,24 @@ static void *__fsnotify_recalc_mask(struct fsnotify_mark_connector *conn)
>  	return fsnotify_update_iref(conn, want_iref);
>  }
>  
> +static bool fsnotify_conn_watches_children(
> +					struct fsnotify_mark_connector *conn)
> +{
> +	if (conn->type != FSNOTIFY_OBJ_TYPE_INODE)
> +		return false;
> +
> +	return fsnotify_inode_watches_children(fsnotify_conn_inode(conn));
> +}
> +
> +static void fsnotify_conn_set_children_dentry_flags(
> +					struct fsnotify_mark_connector *conn)
> +{
> +	if (conn->type != FSNOTIFY_OBJ_TYPE_INODE)
> +		return;
> +
> +	fsnotify_update_children_dentry_flags(fsnotify_conn_inode(conn), true);
> +}
> +
>  /*
>   * Calculate mask of events for a list of marks. The caller must make sure
>   * connector and connector->obj cannot disappear under us.  Callers achieve
> @@ -184,15 +202,23 @@ static void *__fsnotify_recalc_mask(struct fsnotify_mark_connector *conn)
>   */
>  void fsnotify_recalc_mask(struct fsnotify_mark_connector *conn)
>  {
> +	bool update_children;
> +
>  	if (!conn)
>  		return;
>  
>  	spin_lock(&conn->lock);
> +	update_children = !fsnotify_conn_watches_children(conn);
>  	__fsnotify_recalc_mask(conn);
> +	update_children &= fsnotify_conn_watches_children(conn);
>  	spin_unlock(&conn->lock);
> -	if (conn->type == FSNOTIFY_OBJ_TYPE_INODE)
> -		__fsnotify_update_child_dentry_flags(
> -					fsnotify_conn_inode(conn));
> +	/*
> +	 * Set children's PARENT_WATCHED flags only if parent started watching.
> +	 * When parent stops watching, we clear false positive PARENT_WATCHED
> +	 * flags lazily in __fsnotify_parent().
> +	 */
> +	if (update_children)
> +		fsnotify_conn_set_children_dentry_flags(conn);
>  }
>  
>  /* Free all connectors queued for freeing once SRCU period ends */
> diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
> index a31423c376a7..bd90bcf6c3b0 100644
> --- a/include/linux/fsnotify_backend.h
> +++ b/include/linux/fsnotify_backend.h
> @@ -586,12 +586,14 @@ static inline __u32 fsnotify_parent_needed_mask(__u32 mask)
>  
>  static inline int fsnotify_inode_watches_children(struct inode *inode)
>  {
> +	__u32 parent_mask = READ_ONCE(inode->i_fsnotify_mask);
> +
>  	/* FS_EVENT_ON_CHILD is set if the inode may care */
> -	if (!(inode->i_fsnotify_mask & FS_EVENT_ON_CHILD))
> +	if (!(parent_mask & FS_EVENT_ON_CHILD))
>  		return 0;
>  	/* this inode might care about child events, does it care about the
>  	 * specific set of events that can happen on a child? */
> -	return inode->i_fsnotify_mask & FS_EVENTS_POSS_ON_CHILD;
> +	return parent_mask & FS_EVENTS_POSS_ON_CHILD;
>  }
>  
>  /*
> @@ -605,7 +607,7 @@ static inline void fsnotify_update_flags(struct dentry *dentry)
>  	/*
>  	 * Serialisation of setting PARENT_WATCHED on the dentries is provided
>  	 * by d_lock. If inotify_inode_watched changes after we have taken
> -	 * d_lock, the following __fsnotify_update_child_dentry_flags call will
> +	 * d_lock, the following fsnotify_update_children_dentry_flags call will
>  	 * find our entry, so it will spin until we complete here, and update
>  	 * us with the new state.
>  	 */
> -- 
> 2.25.1
