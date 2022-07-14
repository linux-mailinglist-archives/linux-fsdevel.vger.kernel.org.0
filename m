Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8D4B57407B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Jul 2022 02:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbiGNAXK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Jul 2022 20:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231342AbiGNAXH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Jul 2022 20:23:07 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8F1D17062;
        Wed, 13 Jul 2022 17:22:49 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26DNfw2c023362;
        Thu, 14 Jul 2022 00:22:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=fA77Qcm8rRzG9dbv7FNVc6h8ApUU3OW+4w8rD4YBgIg=;
 b=qvIHurcB8LuYWiiotIut/PqT0+rQeUlwHNwQhHuEQPm8kqkC5RpRdTVmRERFSReqBbeU
 OH13kilwDp3g4laIYn4ksJYaXVO+77/IS23L10V61OvnYx/YZWlM16YwhxVO84YCC6Og
 +QtDOb/sWtwmD0RkGf5jIyyRnVH9pvJYwchpMvZ3rchbWm3b0YpwTXhtT1ofMjSCE1te
 wnOk/zYBCifNJ71XKMb3nHyR4P13EIuUpL/aSIJx5I6Jm8uXuIPmfzA7g+x0ON8eHgz9
 OsRTQCGRZeYFmRoT4NQnuuurBgd0Q5ox4ITyt1lnDDSNbbn7j5JbbxmSYBIqF/m3oyqd Ew== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71scbsnf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Jul 2022 00:22:45 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26E0FO0f024677;
        Thu, 14 Jul 2022 00:22:44 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2177.outbound.protection.outlook.com [104.47.73.177])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h7045nsv4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Jul 2022 00:22:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BUb4P58xceqLx5B9jOm8nnUdC8+P04EclQx08OEcDYFsXONOMVhrUPKhU87xMB+MF85/ooONASm4HmzX/wS6fQI7HwDIJ31ThKu+a2pyAfh/XQWDM5AaqompeR6dBdeR97lErlQHwpvnRoZMksocXAt0BMZgbQseKjU9+C+NrRTy0pvFEysOm4ODfIs29BLHykF2Cp10xBwQFFtNvii7Y7rkK2hB7gpXFkycMLxgFzULL0ga64dVeDj6V+3bbRow9M7OE8LgJW+yB7WKdzUGl/Lbgs3LQONAzjpSFfFb31giJHuVFqZxUDb29N/fVFqNcPtj/+KSMNOBnr0CmbQZmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fA77Qcm8rRzG9dbv7FNVc6h8ApUU3OW+4w8rD4YBgIg=;
 b=irZZLIvlWeyv1kSIPDaahNOV/kDCJXV2IZfmd+p5JxdqpguXgyJAYD6Xd+gmLgSbfsLrqcLues0ae87ZJcOi3859o2lxrHfVg2pz1ePmtp4u7EFYLkWwTZSPbaMynZznQZPuhixCa9hlMIQ7+MZmFrk6Wf4DMiWPWt4oZGrVdosAfp3A9OWuODpLwrhJ40FtgJzAZ0nbKFAzrr9O/oNHHejfmMJ/ya/7N3odciLvLIzscSBzcBejYDT1cLn6UbDrD6SpX9zTviAVzcoYf82YCzxGVSPiYIKAkGqni78KQi5u0M7HtxGUIA2aZrzjZwrez1gC2jdnya2pGDgLQ2kRHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fA77Qcm8rRzG9dbv7FNVc6h8ApUU3OW+4w8rD4YBgIg=;
 b=rkLZMfkXF9JieF/ipqPToZt1YZ9q5JhMtCeWiiasBjJI2/GxSV8JpuMpDgVHZ6JfLBcNAOmJXzsFR12jI0yzBDUnL4FYO5lrUw5EGNqBiNyBQMbgGUz56YOvED+Vs5rsRtNCPJeiyd9ANRdia8YGfE2uLg5409AMWftR441trnQ=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by BY5PR10MB3986.namprd10.prod.outlook.com (2603:10b6:a03:1fb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Thu, 14 Jul
 2022 00:22:41 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::dd9d:e9dd:d864:524c]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::dd9d:e9dd:d864:524c%7]) with mapi id 15.20.5438.013; Thu, 14 Jul 2022
 00:22:41 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     tj@kernel.org, gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 3/5] kernfs: Introduce interface to access per-fs rwsem.
Date:   Thu, 14 Jul 2022 10:22:22 +1000
Message-Id: <20220714002224.3641629-4-imran.f.khan@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220714002224.3641629-1-imran.f.khan@oracle.com>
References: <20220714002224.3641629-1-imran.f.khan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SYCP282CA0011.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:80::23) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d181f560-3852-4b6e-b470-08da652ef731
X-MS-TrafficTypeDiagnostic: BY5PR10MB3986:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: meHSPJsYyftWv0nLWdXj38xViaIg0idmQQmTfjfGcn1ZDAh9BAMMRhTEfNYbi+NJParFmouat9OkiFG7s3wMjw8onhXnt9h7MkOW4uTIlN2Z1gTVlQ3lsxQZURKsZnfxnVYQeLEmsuVQVzm7+okQZfXNhegBUgqhpBv3njfGJQ9b9MK9iAxpKjiiuWsNI+B2FeWHwuT5CTlkqKoJRW44kTmGC5CZB/sxrIbnLjJ/Zm736uILvk0t+3EDCUff0GXkVE/RwkWUz8DY9Eg6MroUNV5jTBzybUPpSCz/d/03my1Bd9fPE6O1ALCWtlKCYFih0SrbdIzA9TwQnDuGyd5YsnHH6pzMoIgtmuhMlQ/Sbd8FcLvJg3tbHyvJdlofGZHOzusm6Rjjdlx+AsABED3GIvEhFxEZLkKoBVrkdo7fgyTagjUOuv5X3375RNfeFFDhzYT8AwNuFq7Qc7x+InDvGs8UBK0Nj503kNgeR+rk9VdlwMdfQh+MqAclG8hWKegMnf3KlcTz5SXnmcBc5M8vvmD2L5TU4nJTP4b4pVVg3twmmgQA7lWYhk4GAoE/H/LCMUUgwyZmnA65B/Kg0jXfXsxoYjRMPxGb4Yrcj9DYhYEDF/9xIvs5Iau75MbQ3xtGtXzlTcR277e0EKZlUCFhoJ0dsgwgL68RATV6RUfsVVjHeYdec/1cKWZVhqZENMb9iIIsjHxoLXVkefOOvrRsajphoYRADpiSobglGRJ6QQOndE/76BOLBq+MzLW31bhTGVc5VE5dDEfVs31bUXiol3WDY9ehkShAgaB6x4BxuX98rGqOCGhlkFIs6SfrDrOt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(346002)(39860400002)(136003)(396003)(376002)(26005)(478600001)(6666004)(52116002)(6506007)(6486002)(6512007)(66946007)(41300700001)(66476007)(8676002)(66556008)(86362001)(316002)(4326008)(83380400001)(38350700002)(1076003)(38100700002)(2616005)(30864003)(186003)(36756003)(8936002)(5660300002)(103116003)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?45KjFioyWwxJh59IyFFF1pVnR0nBvB/c5Q3IR3GQWqyC/FZ8YGZSKX1wP91H?=
 =?us-ascii?Q?3nuij2xjTNjocxsXnVlLn6kMnmbdvImEbl256c80WcNu3i5YeEOG/DAPA+Bj?=
 =?us-ascii?Q?/wyKXcFvrs49YeOVULhoQDm3eDY866J1n1fNhxDYEfsNYHbh6wLXunsSiDc0?=
 =?us-ascii?Q?WoXtSxRnOf5diZ8usVh+FwvPZtudb2phCSE98KTRf3wzbrWalYhLqgNJai1/?=
 =?us-ascii?Q?XxVyuQn/ET+rJMx1A+9LS/Pc+3dQbc7m+6UaoBjByWE6FxOZvzsUkQi4vv9s?=
 =?us-ascii?Q?GQ/7KozFEdKZCfn6oktDZ+S6cd3Jfi350OEy074EtaQ8qqaz25ncxoY1ni6e?=
 =?us-ascii?Q?oarM853iEH+F25/UXe5PcD0Q+I+l1cuwQzv+say5LS7xP4DLY0TRvRINfujl?=
 =?us-ascii?Q?onhDvWPJNDdTwAKcKgnOsVoj98NcLY+KXDKSATp3vJTt0zToJgFNXB5ZRI7D?=
 =?us-ascii?Q?6zb7hCp8tW3HSFIDWJyJoorJ5JBara+HKAd9xxhtkGYUXeLell52OASY4tIX?=
 =?us-ascii?Q?kTIv8KAnPvDeVGD7Gc/oBrbl3qmsUH3nDHUyYAD2Dp9L8n8I8icJe27O4tfe?=
 =?us-ascii?Q?br3BDBh1YzkyW1BWbWFdq3nYaF9Cj3g9fKpdIukmwnp69rRke/J0Q0xRdVgY?=
 =?us-ascii?Q?BNHkv7hxF8ejQxz9dwtlbcfke+BXAH0ktik3OZSMlpWrWD4vydyYzD4wkTrd?=
 =?us-ascii?Q?vPozt7lZGzNk5QkWvtjH7x3N/uw7kK3LayN4/nFhfB/IiZD8FFcHgulPKPbc?=
 =?us-ascii?Q?eRlLbOdjOxA/6BbWcN3gWP/BKHhTuAkIdZK7VEtYajSb8Ww2TY3/+YGszAdu?=
 =?us-ascii?Q?6SZzB0FMPjQQgrkHHh9CK4NUNHvmtPv0/47jfFsDhIkSZ1nGb1O+ADsGNNcn?=
 =?us-ascii?Q?6o3K8lM/At5dfTOkF1dSEiqloG1ykv4hdTBnCH+Hk87PlrZrv3za9S+7X8rQ?=
 =?us-ascii?Q?S2SvjsO9pN5sEI+F824E8/Nhwzvs1lOCzvSnTXpHZTxqXncV1tecntuHB015?=
 =?us-ascii?Q?g1+kIJ816LxP3ZFfqkCup4va9V9riKnASX0rGcsmK18t4KL8CrfQOSmxqj3+?=
 =?us-ascii?Q?RnbWkdBvuMP4djUL+ywr8jA60y8Tqz4p13EgdVMhIN/29OUEok0q4jfzYsi/?=
 =?us-ascii?Q?nCi2l4nd5iCY7VXF2j/QqFYVK4mNZQd01aw0E5eyBjut4KaU2Zyd8WTDRT6h?=
 =?us-ascii?Q?C3f8TANxntST3Dgk3HGeJd6r9UR410uAUoMTSQQwtt/mh3mk8AMqfYZabejF?=
 =?us-ascii?Q?cYcu8lYAfFNGGlqQqvfzyYLs/ssktbWcwPp+0eBoMDKAsDLxSz/4ycZbpSIi?=
 =?us-ascii?Q?WaDu6zYXXhoz6N7R+MCDkpqeY0tuhQxj8vKnrU0CACpVERNXATtzf8rpWtW8?=
 =?us-ascii?Q?GNVDGjoMb8oxwyFCeKU7RWxR48b4wghSuTlL/zSuWfDDZRBBTG12Y6vXn8Ja?=
 =?us-ascii?Q?xo+jk+YJ8kj8gHBea1RxMqd8cIuYRbVLrE+IOoMpecSpJeEoy+40PzOrNho4?=
 =?us-ascii?Q?iE5QYRQqNrws6LrmpBpc3QKz8fJlu9Lkh2E5rCUJ8sKq0FuahGI6+aautfor?=
 =?us-ascii?Q?J07c+LnXysqgATsFEiZeQyLSA//TggNP1TYAGFq4LduDZr4wP9lS9a9gpzo+?=
 =?us-ascii?Q?VQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d181f560-3852-4b6e-b470-08da652ef731
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2022 00:22:41.7727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d+bSV84qsbsmux8bxwkwxIDRCy7rQP52njbcFSbu/mulZ2nyP+8HYAZrkA1gExuBINx3tcCoeLaYoY2GmKe5lQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3986
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-13_13:2022-07-13,2022-07-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 mlxscore=0
 suspectscore=0 adultscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207140000
X-Proofpoint-GUID: pDdsCtU8x4TMlW1FsNxnc7Avl5GJmBWv
X-Proofpoint-ORIG-GUID: pDdsCtU8x4TMlW1FsNxnc7Avl5GJmBWv
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

per-fs rwsem is used across kernfs for synchronization purposes.
Having an interface to access it not only avoids code duplication, it
can also help in changing the underlying locking mechanism without needing
to change the lock users. For example next patch modifies this interface
to make use of hashed rwsems in place of per-fs rwsem.

Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
---
 fs/kernfs/dir.c             | 119 ++++++++++++++++++------------------
 fs/kernfs/file.c            |   5 +-
 fs/kernfs/inode.c           |  26 ++++----
 fs/kernfs/kernfs-internal.h |  78 +++++++++++++++++++++++
 fs/kernfs/mount.c           |   6 +-
 fs/kernfs/symlink.c         |   6 +-
 6 files changed, 159 insertions(+), 81 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index d2a0b4acd0733..73f4ebc1464e2 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -33,7 +33,7 @@ static DEFINE_SPINLOCK(kernfs_idr_lock);	/* root->ino_idr */
 
 static bool kernfs_active(struct kernfs_node *kn)
 {
-	lockdep_assert_held(&kernfs_root(kn)->kernfs_rwsem);
+	kernfs_rwsem_assert_held(kn);
 	return atomic_read(&kn->active) >= 0;
 }
 
@@ -467,12 +467,20 @@ static void kernfs_drain(struct kernfs_node *kn)
 	__releases(&kernfs_root(kn)->kernfs_rwsem)
 	__acquires(&kernfs_root(kn)->kernfs_rwsem)
 {
+	struct rw_semaphore *rwsem;
 	struct kernfs_root *root = kernfs_root(kn);
 
-	lockdep_assert_held_write(&root->kernfs_rwsem);
+	/**
+	 * kn has the same root as its ancestor, so it can be used to get
+	 * per-fs rwsem.
+	 */
+	rwsem = kernfs_rwsem_ptr(kn);
+
+	kernfs_rwsem_assert_held_write(kn);
+
 	WARN_ON_ONCE(kernfs_active(kn));
 
-	up_write(&root->kernfs_rwsem);
+	kernfs_up_write(rwsem);
 
 	if (kernfs_lockdep(kn)) {
 		rwsem_acquire(&kn->dep_map, 0, 0, _RET_IP_);
@@ -491,7 +499,7 @@ static void kernfs_drain(struct kernfs_node *kn)
 
 	kernfs_drain_open_files(kn);
 
-	down_write(&root->kernfs_rwsem);
+	kernfs_down_write(kn);
 }
 
 /**
@@ -726,12 +734,12 @@ struct kernfs_node *kernfs_find_and_get_node_by_id(struct kernfs_root *root,
 int kernfs_add_one(struct kernfs_node *kn)
 {
 	struct kernfs_node *parent = kn->parent;
-	struct kernfs_root *root = kernfs_root(parent);
 	struct kernfs_iattrs *ps_iattr;
+	struct rw_semaphore *rwsem;
 	bool has_ns;
 	int ret;
 
-	down_write(&root->kernfs_rwsem);
+	rwsem = kernfs_down_write(parent);
 
 	ret = -EINVAL;
 	has_ns = kernfs_ns_enabled(parent);
@@ -762,7 +770,7 @@ int kernfs_add_one(struct kernfs_node *kn)
 		ps_iattr->ia_mtime = ps_iattr->ia_ctime;
 	}
 
-	up_write(&root->kernfs_rwsem);
+	kernfs_up_write(rwsem);
 
 	/*
 	 * Activate the new node unless CREATE_DEACTIVATED is requested.
@@ -776,7 +784,7 @@ int kernfs_add_one(struct kernfs_node *kn)
 	return 0;
 
 out_unlock:
-	up_write(&root->kernfs_rwsem);
+	kernfs_up_write(rwsem);
 	return ret;
 }
 
@@ -797,7 +805,7 @@ static struct kernfs_node *kernfs_find_ns(struct kernfs_node *parent,
 	bool has_ns = kernfs_ns_enabled(parent);
 	unsigned int hash;
 
-	lockdep_assert_held(&kernfs_root(parent)->kernfs_rwsem);
+	kernfs_rwsem_assert_held(parent);
 
 	if (has_ns != (bool)ns) {
 		WARN(1, KERN_WARNING "kernfs: ns %s in '%s' for '%s'\n",
@@ -829,7 +837,7 @@ static struct kernfs_node *kernfs_walk_ns(struct kernfs_node *parent,
 	size_t len;
 	char *p, *name;
 
-	lockdep_assert_held_read(&kernfs_root(parent)->kernfs_rwsem);
+	kernfs_rwsem_assert_held_read(parent);
 
 	spin_lock_irq(&kernfs_pr_cont_lock);
 
@@ -867,12 +875,12 @@ struct kernfs_node *kernfs_find_and_get_ns(struct kernfs_node *parent,
 					   const char *name, const void *ns)
 {
 	struct kernfs_node *kn;
-	struct kernfs_root *root = kernfs_root(parent);
+	struct rw_semaphore *rwsem;
 
-	down_read(&root->kernfs_rwsem);
+	rwsem = kernfs_down_read(parent);
 	kn = kernfs_find_ns(parent, name, ns);
 	kernfs_get(kn);
-	up_read(&root->kernfs_rwsem);
+	kernfs_up_read(rwsem);
 
 	return kn;
 }
@@ -892,12 +900,12 @@ struct kernfs_node *kernfs_walk_and_get_ns(struct kernfs_node *parent,
 					   const char *path, const void *ns)
 {
 	struct kernfs_node *kn;
-	struct kernfs_root *root = kernfs_root(parent);
+	struct rw_semaphore *rwsem;
 
-	down_read(&root->kernfs_rwsem);
+	rwsem = kernfs_down_read(parent);
 	kn = kernfs_walk_ns(parent, path, ns);
 	kernfs_get(kn);
-	up_read(&root->kernfs_rwsem);
+	kernfs_up_read(rwsem);
 
 	return kn;
 }
@@ -1062,7 +1070,7 @@ struct kernfs_node *kernfs_create_empty_dir(struct kernfs_node *parent,
 static int kernfs_dop_revalidate(struct dentry *dentry, unsigned int flags)
 {
 	struct kernfs_node *kn;
-	struct kernfs_root *root;
+	struct rw_semaphore *rwsem;
 
 	if (flags & LOOKUP_RCU)
 		return -ECHILD;
@@ -1078,13 +1086,12 @@ static int kernfs_dop_revalidate(struct dentry *dentry, unsigned int flags)
 		parent = kernfs_dentry_node(dentry->d_parent);
 		if (parent) {
 			spin_unlock(&dentry->d_lock);
-			root = kernfs_root(parent);
-			down_read(&root->kernfs_rwsem);
+			rwsem = kernfs_down_read(parent);
 			if (kernfs_dir_changed(parent, dentry)) {
-				up_read(&root->kernfs_rwsem);
+				kernfs_up_read(rwsem);
 				return 0;
 			}
-			up_read(&root->kernfs_rwsem);
+			kernfs_up_read(rwsem);
 		} else
 			spin_unlock(&dentry->d_lock);
 
@@ -1095,8 +1102,7 @@ static int kernfs_dop_revalidate(struct dentry *dentry, unsigned int flags)
 	}
 
 	kn = kernfs_dentry_node(dentry);
-	root = kernfs_root(kn);
-	down_read(&root->kernfs_rwsem);
+	rwsem = kernfs_down_read(kn);
 
 	/* The kernfs node has been deactivated */
 	if (!kernfs_active(kn))
@@ -1115,10 +1121,10 @@ static int kernfs_dop_revalidate(struct dentry *dentry, unsigned int flags)
 	    kernfs_info(dentry->d_sb)->ns != kn->ns)
 		goto out_bad;
 
-	up_read(&root->kernfs_rwsem);
+	kernfs_up_read(rwsem);
 	return 1;
 out_bad:
-	up_read(&root->kernfs_rwsem);
+	kernfs_up_read(rwsem);
 	return 0;
 }
 
@@ -1132,12 +1138,11 @@ static struct dentry *kernfs_iop_lookup(struct inode *dir,
 {
 	struct kernfs_node *parent = dir->i_private;
 	struct kernfs_node *kn;
-	struct kernfs_root *root;
 	struct inode *inode = NULL;
 	const void *ns = NULL;
+	struct rw_semaphore *rwsem;
 
-	root = kernfs_root(parent);
-	down_read(&root->kernfs_rwsem);
+	rwsem = kernfs_down_read(parent);
 	if (kernfs_ns_enabled(parent))
 		ns = kernfs_info(dir->i_sb)->ns;
 
@@ -1148,7 +1153,7 @@ static struct dentry *kernfs_iop_lookup(struct inode *dir,
 		 * create a negative.
 		 */
 		if (!kernfs_active(kn)) {
-			up_read(&root->kernfs_rwsem);
+			kernfs_up_read(rwsem);
 			return NULL;
 		}
 		inode = kernfs_get_inode(dir->i_sb, kn);
@@ -1163,7 +1168,7 @@ static struct dentry *kernfs_iop_lookup(struct inode *dir,
 	 */
 	if (!IS_ERR(inode))
 		kernfs_set_rev(parent, dentry);
-	up_read(&root->kernfs_rwsem);
+	kernfs_up_read(rwsem);
 
 	/* instantiate and hash (possibly negative) dentry */
 	return d_splice_alias(inode, dentry);
@@ -1286,7 +1291,7 @@ static struct kernfs_node *kernfs_next_descendant_post(struct kernfs_node *pos,
 {
 	struct rb_node *rbn;
 
-	lockdep_assert_held_write(&kernfs_root(root)->kernfs_rwsem);
+	kernfs_rwsem_assert_held_write(root);
 
 	/* if first iteration, visit leftmost descendant which may be root */
 	if (!pos)
@@ -1321,9 +1326,9 @@ static struct kernfs_node *kernfs_next_descendant_post(struct kernfs_node *pos,
 void kernfs_activate(struct kernfs_node *kn)
 {
 	struct kernfs_node *pos;
-	struct kernfs_root *root = kernfs_root(kn);
+	struct rw_semaphore *rwsem;
 
-	down_write(&root->kernfs_rwsem);
+	rwsem = kernfs_down_write(kn);
 
 	pos = NULL;
 	while ((pos = kernfs_next_descendant_post(pos, kn))) {
@@ -1337,7 +1342,7 @@ void kernfs_activate(struct kernfs_node *kn)
 		pos->flags |= KERNFS_ACTIVATED;
 	}
 
-	up_write(&root->kernfs_rwsem);
+	kernfs_up_write(rwsem);
 }
 
 static void __kernfs_remove(struct kernfs_node *kn)
@@ -1348,7 +1353,7 @@ static void __kernfs_remove(struct kernfs_node *kn)
 	if (!kn)
 		return;
 
-	lockdep_assert_held_write(&kernfs_root(kn)->kernfs_rwsem);
+	kernfs_rwsem_assert_held_write(kn);
 
 	/*
 	 * This is for kernfs_remove_self() which plays with active ref
@@ -1417,16 +1422,14 @@ static void __kernfs_remove(struct kernfs_node *kn)
  */
 void kernfs_remove(struct kernfs_node *kn)
 {
-	struct kernfs_root *root;
+	struct rw_semaphore *rwsem;
 
 	if (!kn)
 		return;
 
-	root = kernfs_root(kn);
-
-	down_write(&root->kernfs_rwsem);
+	rwsem = kernfs_down_write(kn);
 	__kernfs_remove(kn);
-	up_write(&root->kernfs_rwsem);
+	kernfs_up_write(rwsem);
 }
 
 /**
@@ -1512,9 +1515,9 @@ void kernfs_unbreak_active_protection(struct kernfs_node *kn)
 bool kernfs_remove_self(struct kernfs_node *kn)
 {
 	bool ret;
-	struct kernfs_root *root = kernfs_root(kn);
+	struct rw_semaphore *rwsem;
 
-	down_write(&root->kernfs_rwsem);
+	rwsem = kernfs_down_write(kn);
 	kernfs_break_active_protection(kn);
 
 	/*
@@ -1542,9 +1545,9 @@ bool kernfs_remove_self(struct kernfs_node *kn)
 			    atomic_read(&kn->active) == KN_DEACTIVATED_BIAS)
 				break;
 
-			up_write(&root->kernfs_rwsem);
+			kernfs_up_write(rwsem);
 			schedule();
-			down_write(&root->kernfs_rwsem);
+			rwsem = kernfs_down_write(kn);
 		}
 		finish_wait(waitq, &wait);
 		WARN_ON_ONCE(!RB_EMPTY_NODE(&kn->rb));
@@ -1557,7 +1560,7 @@ bool kernfs_remove_self(struct kernfs_node *kn)
 	 */
 	kernfs_unbreak_active_protection(kn);
 
-	up_write(&root->kernfs_rwsem);
+	kernfs_up_write(rwsem);
 	return ret;
 }
 
@@ -1574,7 +1577,7 @@ int kernfs_remove_by_name_ns(struct kernfs_node *parent, const char *name,
 			     const void *ns)
 {
 	struct kernfs_node *kn;
-	struct kernfs_root *root;
+	struct rw_semaphore *rwsem;
 
 	if (!parent) {
 		WARN(1, KERN_WARNING "kernfs: can not remove '%s', no directory\n",
@@ -1582,14 +1585,14 @@ int kernfs_remove_by_name_ns(struct kernfs_node *parent, const char *name,
 		return -ENOENT;
 	}
 
-	root = kernfs_root(parent);
-	down_write(&root->kernfs_rwsem);
+
+	rwsem = kernfs_down_write(parent);
 
 	kn = kernfs_find_ns(parent, name, ns);
 	if (kn)
 		__kernfs_remove(kn);
 
-	up_write(&root->kernfs_rwsem);
+	kernfs_up_write(rwsem);
 
 	if (kn)
 		return 0;
@@ -1608,16 +1611,15 @@ int kernfs_rename_ns(struct kernfs_node *kn, struct kernfs_node *new_parent,
 		     const char *new_name, const void *new_ns)
 {
 	struct kernfs_node *old_parent;
-	struct kernfs_root *root;
 	const char *old_name = NULL;
+	struct rw_semaphore *rwsem;
 	int error;
 
 	/* can't move or rename root */
 	if (!kn->parent)
 		return -EINVAL;
 
-	root = kernfs_root(kn);
-	down_write(&root->kernfs_rwsem);
+	rwsem = kernfs_down_write(kn);
 
 	error = -ENOENT;
 	if (!kernfs_active(kn) || !kernfs_active(new_parent) ||
@@ -1671,7 +1673,7 @@ int kernfs_rename_ns(struct kernfs_node *kn, struct kernfs_node *new_parent,
 
 	error = 0;
  out:
-	up_write(&root->kernfs_rwsem);
+	kernfs_up_write(rwsem);
 	return error;
 }
 
@@ -1742,14 +1744,13 @@ static int kernfs_fop_readdir(struct file *file, struct dir_context *ctx)
 	struct dentry *dentry = file->f_path.dentry;
 	struct kernfs_node *parent = kernfs_dentry_node(dentry);
 	struct kernfs_node *pos = file->private_data;
-	struct kernfs_root *root;
 	const void *ns = NULL;
+	struct rw_semaphore *rwsem;
 
 	if (!dir_emit_dots(file, ctx))
 		return 0;
 
-	root = kernfs_root(parent);
-	down_read(&root->kernfs_rwsem);
+	rwsem = kernfs_down_read(parent);
 
 	if (kernfs_ns_enabled(parent))
 		ns = kernfs_info(dentry->d_sb)->ns;
@@ -1766,12 +1767,12 @@ static int kernfs_fop_readdir(struct file *file, struct dir_context *ctx)
 		file->private_data = pos;
 		kernfs_get(pos);
 
-		up_read(&root->kernfs_rwsem);
+		kernfs_up_read(rwsem);
 		if (!dir_emit(ctx, name, len, ino, type))
 			return 0;
-		down_read(&root->kernfs_rwsem);
+		rwsem = kernfs_down_read(parent);
 	}
-	up_read(&root->kernfs_rwsem);
+	kernfs_up_read(rwsem);
 	file->private_data = NULL;
 	ctx->pos = INT_MAX;
 	return 0;
diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index 77c3e34a6c7da..7c8bdf4ce31f4 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -911,6 +911,7 @@ static void kernfs_notify_workfn(struct work_struct *work)
 	struct kernfs_node *kn;
 	struct kernfs_super_info *info;
 	struct kernfs_root *root;
+	struct rw_semaphore *rwsem;
 repeat:
 	/* pop one off the notify_list */
 	spin_lock_irq(&kernfs_notify_lock);
@@ -925,7 +926,7 @@ static void kernfs_notify_workfn(struct work_struct *work)
 
 	root = kernfs_root(kn);
 	/* kick fsnotify */
-	down_write(&root->kernfs_rwsem);
+	rwsem = kernfs_down_write(kn);
 
 	down_write(&root->supers_rwsem);
 	list_for_each_entry(info, &kernfs_root(kn)->supers, node) {
@@ -965,7 +966,7 @@ static void kernfs_notify_workfn(struct work_struct *work)
 	}
 	up_write(&root->supers_rwsem);
 
-	up_write(&root->kernfs_rwsem);
+	kernfs_up_write(rwsem);
 	kernfs_put(kn);
 	goto repeat;
 }
diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
index 3d783d80f5daa..efe5ae98abf46 100644
--- a/fs/kernfs/inode.c
+++ b/fs/kernfs/inode.c
@@ -99,11 +99,11 @@ int __kernfs_setattr(struct kernfs_node *kn, const struct iattr *iattr)
 int kernfs_setattr(struct kernfs_node *kn, const struct iattr *iattr)
 {
 	int ret;
-	struct kernfs_root *root = kernfs_root(kn);
+	struct rw_semaphore *rwsem;
 
-	down_write(&root->kernfs_rwsem);
+	rwsem = kernfs_down_write(kn);
 	ret = __kernfs_setattr(kn, iattr);
-	up_write(&root->kernfs_rwsem);
+	kernfs_up_write(rwsem);
 	return ret;
 }
 
@@ -112,14 +112,13 @@ int kernfs_iop_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 {
 	struct inode *inode = d_inode(dentry);
 	struct kernfs_node *kn = inode->i_private;
-	struct kernfs_root *root;
+	struct rw_semaphore *rwsem;
 	int error;
 
 	if (!kn)
 		return -EINVAL;
 
-	root = kernfs_root(kn);
-	down_write(&root->kernfs_rwsem);
+	rwsem = kernfs_down_write(kn);
 	error = setattr_prepare(&init_user_ns, dentry, iattr);
 	if (error)
 		goto out;
@@ -132,7 +131,7 @@ int kernfs_iop_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 	setattr_copy(&init_user_ns, inode, iattr);
 
 out:
-	up_write(&root->kernfs_rwsem);
+	kernfs_up_write(rwsem);
 	return error;
 }
 
@@ -187,14 +186,14 @@ int kernfs_iop_getattr(struct user_namespace *mnt_userns,
 {
 	struct inode *inode = d_inode(path->dentry);
 	struct kernfs_node *kn = inode->i_private;
-	struct kernfs_root *root = kernfs_root(kn);
+	struct rw_semaphore *rwsem;
 
-	down_read(&root->kernfs_rwsem);
+	rwsem = kernfs_down_read(kn);
 	spin_lock(&inode->i_lock);
 	kernfs_refresh_inode(kn, inode);
 	generic_fillattr(&init_user_ns, inode, stat);
 	spin_unlock(&inode->i_lock);
-	up_read(&root->kernfs_rwsem);
+	kernfs_up_read(rwsem);
 
 	return 0;
 }
@@ -277,22 +276,21 @@ void kernfs_evict_inode(struct inode *inode)
 int kernfs_iop_permission(struct user_namespace *mnt_userns,
 			  struct inode *inode, int mask)
 {
+	struct rw_semaphore *rwsem;
 	struct kernfs_node *kn;
-	struct kernfs_root *root;
 	int ret;
 
 	if (mask & MAY_NOT_BLOCK)
 		return -ECHILD;
 
 	kn = inode->i_private;
-	root = kernfs_root(kn);
 
-	down_read(&root->kernfs_rwsem);
+	rwsem = kernfs_down_read(kn);
 	spin_lock(&inode->i_lock);
 	kernfs_refresh_inode(kn, inode);
 	ret = generic_permission(&init_user_ns, inode, mask);
 	spin_unlock(&inode->i_lock);
-	up_read(&root->kernfs_rwsem);
+	kernfs_up_read(rwsem);
 
 	return ret;
 }
diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-internal.h
index 3cd17c100d10e..0babc3dc4f4a3 100644
--- a/fs/kernfs/kernfs-internal.h
+++ b/fs/kernfs/kernfs-internal.h
@@ -169,4 +169,82 @@ extern const struct inode_operations kernfs_symlink_iops;
  * kernfs locks
  */
 extern struct kernfs_global_locks *kernfs_locks;
+
+static inline struct rw_semaphore *kernfs_rwsem_ptr(struct kernfs_node *kn)
+{
+	struct kernfs_root *root = kernfs_root(kn);
+
+	return &root->kernfs_rwsem;
+}
+
+static inline void kernfs_rwsem_assert_held(struct kernfs_node *kn)
+{
+	lockdep_assert_held(kernfs_rwsem_ptr(kn));
+}
+
+static inline void kernfs_rwsem_assert_held_write(struct kernfs_node *kn)
+{
+	lockdep_assert_held_write(kernfs_rwsem_ptr(kn));
+}
+
+static inline void kernfs_rwsem_assert_held_read(struct kernfs_node *kn)
+{
+	lockdep_assert_held_read(kernfs_rwsem_ptr(kn));
+}
+
+/**
+ * kernfs_down_write() - Acquire kernfs rwsem
+ *
+ * @kn: kernfs_node for which rwsem needs to be taken
+ *
+ * Return: pointer to acquired rwsem
+ */
+static inline struct rw_semaphore *kernfs_down_write(struct kernfs_node *kn)
+{
+	struct rw_semaphore *rwsem = kernfs_rwsem_ptr(kn);
+
+	down_write(rwsem);
+
+	return rwsem;
+}
+
+/**
+ * kernfs_up_write - Release kernfs rwsem
+ *
+ * @rwsem: address of rwsem to release
+ *
+ * Return: void
+ */
+static inline void kernfs_up_write(struct rw_semaphore *rwsem)
+{
+	up_write(rwsem);
+}
+
+/**
+ * kernfs_down_read() - Acquire kernfs rwsem
+ *
+ * @kn: kernfs_node for which rwsem needs to be taken
+ *
+ * Return: pointer to acquired rwsem
+ */
+static inline struct rw_semaphore *kernfs_down_read(struct kernfs_node *kn)
+{
+	struct rw_semaphore *rwsem = kernfs_rwsem_ptr(kn);
+
+	down_read(rwsem);
+
+	return rwsem;
+}
+
+/**
+ * kernfs_up_read - Release kernfs rwsem
+ *
+ * @rwsem: address of rwsem to release
+ *
+ * Return: void
+ */
+static inline void kernfs_up_read(struct rw_semaphore *rwsem)
+{
+	up_read(rwsem);
+}
 #endif	/* __KERNFS_INTERNAL_H */
diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
index d2be1c3047157..3c5334b74f369 100644
--- a/fs/kernfs/mount.c
+++ b/fs/kernfs/mount.c
@@ -237,9 +237,9 @@ struct dentry *kernfs_node_dentry(struct kernfs_node *kn,
 static int kernfs_fill_super(struct super_block *sb, struct kernfs_fs_context *kfc)
 {
 	struct kernfs_super_info *info = kernfs_info(sb);
-	struct kernfs_root *kf_root = kfc->root;
 	struct inode *inode;
 	struct dentry *root;
+	struct rw_semaphore *rwsem;
 
 	info->sb = sb;
 	/* Userspace would break if executables or devices appear on sysfs */
@@ -257,9 +257,9 @@ static int kernfs_fill_super(struct super_block *sb, struct kernfs_fs_context *k
 	sb->s_shrink.seeks = 0;
 
 	/* get root inode, initialize and unlock it */
-	down_read(&kf_root->kernfs_rwsem);
+	rwsem = kernfs_down_read(info->root->kn);
 	inode = kernfs_get_inode(sb, info->root->kn);
-	up_read(&kf_root->kernfs_rwsem);
+	kernfs_up_read(rwsem);
 	if (!inode) {
 		pr_debug("kernfs: could not get root inode\n");
 		return -ENOMEM;
diff --git a/fs/kernfs/symlink.c b/fs/kernfs/symlink.c
index 0ab13824822f7..9d41036025547 100644
--- a/fs/kernfs/symlink.c
+++ b/fs/kernfs/symlink.c
@@ -113,12 +113,12 @@ static int kernfs_getlink(struct inode *inode, char *path)
 	struct kernfs_node *kn = inode->i_private;
 	struct kernfs_node *parent = kn->parent;
 	struct kernfs_node *target = kn->symlink.target_kn;
-	struct kernfs_root *root = kernfs_root(parent);
+	struct rw_semaphore *rwsem;
 	int error;
 
-	down_read(&root->kernfs_rwsem);
+	rwsem = kernfs_down_read(parent);
 	error = kernfs_get_target_path(parent, target, path);
-	up_read(&root->kernfs_rwsem);
+	kernfs_up_read(rwsem);
 
 	return error;
 }
-- 
2.30.2

