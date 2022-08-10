Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72BBE58EAFD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Aug 2022 13:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231867AbiHJLLG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Aug 2022 07:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231975AbiHJLKl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Aug 2022 07:10:41 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D28050726;
        Wed, 10 Aug 2022 04:10:38 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27A8i1XW018854;
        Wed, 10 Aug 2022 11:10:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=kXZ6sFV4H8WNpEPmraNZC6aexsaAH2f+y2+hZPIz9N4=;
 b=nbk31KrRR/6/S/vxSJoTmd71851hIPBwkXxP0gyX47KSAAsGpYb7Tec42jVnwv8m5bn5
 IVwhgZTZhdlK6mdPE942AH5LS4owyWsqJQKEVSGcsOSsHA2v7IaO8jReBUsH7rX4Le/z
 VABxMHh3leNxmvIsCeongeSF9HzSiU1QSBwoNXosUTQVGaFGiPNtv45h5CWLr4QasduF
 SqjfUXEkNFkDgVNCrs1Rgo+BtG472yxQ0ehfJhLZJfdzZ6kDy2mvKDP9gQS9LkgGhWf7
 48Hjiz8ASclC1/6Rsnq5qudBWq5Fypz3LO8bKzwo6HOwVjQEn5TP8c4OY56ZTjjiayXH yw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3huwqj1gxa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Aug 2022 11:10:33 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27A9Le9l037355;
        Wed, 10 Aug 2022 11:10:32 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3huwqj1w9a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Aug 2022 11:10:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lM5JJQVkU7FAJQ6osFweZ4ruuY0BJcoxbZpQIm/EqMlFHDIbMirNZNT0OroibkSv+8ewzsI7XwdIZPrhvryQeA71JMcb+tA16kg3NmimDBWNk7k7hayzuG9SGE3hNOZOC9CvnSpYixMsIFrwrsOpTkEM3Mql58YGE4MX10EBMFt3uzDFbyBcHJvjxNmGS+BPTBzJP2dsAYO10FQHgWWzVZawwMZ2feXLq9YkqGHk3mc4o3R9PpkjRCIcqohwIZskI3OHGf4UHbzJtJ5jAS2y42QsNOQhoeCLjeOEaPBa0JDT0kLZsCDzhqhhdKSLPIcLbVfbKy+Y/RDXT4fKpT4xLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kXZ6sFV4H8WNpEPmraNZC6aexsaAH2f+y2+hZPIz9N4=;
 b=hKua+q0zYE7MsgXP1zIBuOz3QXLpOZZ32J8lHlKB27yiZbFOmcASDLe36DIR5a1Rd5xgtn7SVyKcpSl1ua4FFWKW8T4JKCENN5vbNE9Fj2M1xkrwsR8itoBKPU4HSNd5vwHsdwvRVQ6v2rrgyFF61P6HXZWZaaUPPaT9HZrVLDa1d3JFfeqhxtfVhVLjuRdePA4yxoTtV4DXWmv8hlRJbf0CmgzFVKT0hXn7uWYvpJ0kqYaEZpugVfQWocAyHqlTRnCw/9hVERwNUHN6itipoC9MlbMQnhvviwIRVdtBJ7kTTyiY3F67rweIq6Gx8mj6zRP2zOxMMigvx/8Iiga5WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kXZ6sFV4H8WNpEPmraNZC6aexsaAH2f+y2+hZPIz9N4=;
 b=rHAsH/jjfUjvuACOH0dyNdh6yLavUTWrMJSJ+Ed2ZqPBexdKSeWpKP7aiaMavFnhy3yX/5YFFAXbgnz8KhwZiv+mtwMCQt/UT2e5dUe+X1UqW87bQHsiL2VB6QHcykCUpwhSrOaY2wY/nZlxyp1UOT0/+g0fH3N3SUgDVyh9oq8=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by BYAPR10MB3431.namprd10.prod.outlook.com (2603:10b6:a03:86::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Wed, 10 Aug
 2022 11:10:29 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::c504:bfd6:7940:544f]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::c504:bfd6:7940:544f%5]) with mapi id 15.20.5525.011; Wed, 10 Aug 2022
 11:10:29 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     tj@kernel.org, gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RESEND PATCH 0/5] kernfs: Use a per-fs rwsem to protect per-fs list of kernfs_super_info
Date:   Wed, 10 Aug 2022 21:10:12 +1000
Message-Id: <20220810111017.2267160-1-imran.f.khan@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY3PR01CA0134.ausprd01.prod.outlook.com
 (2603:10c6:0:1b::19) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 995d9ee6-9083-4d59-80dc-08da7ac0ef15
X-MS-TrafficTypeDiagnostic: BYAPR10MB3431:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c8yXEShxtxpDg9/4nI2UFv34l7dX/kUS5Lw2pTfc7SB4gfRCZaTuoDyAHFyACXUUNNQc02DGfXKdavIoKOwrSGTc7y15tACYSU+EsGyXfUPlkpwJ0GvhqeJqXeY42aV5OKUtDMGDnT636QSB/80h60fqRGfiZV8E8wGRXwYnVHCKMYkBcEGxrDXegNgRP/RWoFfc5qutsyc2qGjxtsuJKaAdUA3sY/uTGD0HrYkOkHCRfiOJjfNU6PHdQZmQJwPllzzOPclSypwgVTD/pdeTy+aP4sNY4cezmMcb71zcuGXKZxx+soVUI3FcSATsiuM6mK9mMVeddzFbnnqJTgdU/6k1EXv+SdAYbOXKKcaSDOtjYYKw3u8i40P6rYvgjsJeHN0Ye1Ftv8T8HolMQUlG7vZBGRpuOARmlpyefxTTgU8HWP2CLPPEXIny+tVnVnohzJyil084SVcZEsWiI5AzbT2YZfiuhyEQI29TEIRQoR8FhlSTW1TTHoqH+8KYhEaIGwEJJwCCZYtNzWiboAi7ffQlLj2ypMttJDZRChThQqLcK4VNlt6kU/JxtS4IRKbpbKhNLYuEpHz2yRd5y8g2aRZ3dPleoP9P3mPQwn3axXz5M58lO3aT4o/gghN56aSUDezY8gOPEepHLUUYu7U2dvxeyHmSVvLwZjqRj5KqIhMbcYEx75m3ed+SASwdi+xaPe1/lVIKn3ANznV8zBg0lOqGlRCQmPhTVw+GBa0TLmVagy70qNvmIiVc5TAmuyIecLBrtfpJeCcVjAiiOJq4lBntXSiopaYYvENXJN0aMmM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(346002)(396003)(136003)(376002)(39860400002)(8936002)(66556008)(4326008)(186003)(66476007)(36756003)(1076003)(103116003)(316002)(5660300002)(8676002)(6486002)(86362001)(66946007)(478600001)(2616005)(41300700001)(83380400001)(6512007)(26005)(6666004)(2906002)(6506007)(38350700002)(52116002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vJXTvsGzfTNlYZOQ3BFx6wscEdZYhNNWaoZ/iqL4icf7OfSuF8+UFoMj4uyf?=
 =?us-ascii?Q?7zs3R4BUYGVso6/0wCUTkHFzHyRBOmORpjEiPcC3yWhoFasZxFyWZMD3L1Wr?=
 =?us-ascii?Q?wwe9/laOFlNcnYgDQaTi96ZKslf0ttSV6DFjuNbithkM668PvImU3YIuogmK?=
 =?us-ascii?Q?wSWCjH5yyMVL9dU1BIaaCmIGRpVZZieHxIQTqdwf77myiGbpUgQLqrZlhQHQ?=
 =?us-ascii?Q?76Qz4kMvRtINImOEtHy03hM9Cjdl/GFMoFp+FFbPY7/1+CBYb5DkDYnVqA58?=
 =?us-ascii?Q?QZUOngoDbhZdTDSkYshVTbjjI5SvwtH0MiNMYZqYe1wDbvzH22tzzXVmXUsB?=
 =?us-ascii?Q?10eNgxxMeQwDJXcpFC97vSathK8JDe4HXLLluUOYRKLY5p/V0by6gSvaMNdE?=
 =?us-ascii?Q?4exXAr4QLNBa1rQX6389amUZVks+x9a++3A0RKhPygyOXxIZC05FBWYR2MdM?=
 =?us-ascii?Q?lAMRS8huvAo7JB5YLlkjt8SBB7c+JNTbp96II4Ky0ax2gWoNMQ+bMPe+ErTs?=
 =?us-ascii?Q?PtsLSlqskHenllQZceYtFHhRDcgGtklHOLeMxJtkJMfCKtn0HkMmdLu6jE83?=
 =?us-ascii?Q?K2Kiyl2Hi83NX1XgfVp42E8+mKDrE+FoVB0xasDMjsOO7Qa5XLRGaNw2nZAi?=
 =?us-ascii?Q?U7QGOGYrNKuIwY0hwQzq8ZkGY8Kbe/fFZHevPv5C7GaX+WBsN2NByhi5bWf6?=
 =?us-ascii?Q?hlQtu0ZNhH4KdP+f1399xDuhaLoGrYE0EdljsMN3f3kfBwSeTLALg9wO+TSn?=
 =?us-ascii?Q?MMycAN6Hmbcp47j3TNpyaZDJCEGd7nx5jIzz0sWsS4fDlX4BPZEq6mPZoOld?=
 =?us-ascii?Q?8/5oT1PGhQampzw4+7YhzLUvq9MEPpT3eUaViMsu9CR34xS/5NnuHSi3eUu1?=
 =?us-ascii?Q?TD+nPkW7N7gWXJRfsR/FIyf5vctXFV43N2DmFv8jZ1nNy8FFJkHrJ+aVzMSY?=
 =?us-ascii?Q?TQ+hHeIavQgCPJh6SM3RFroZdxCRDuzyigR515VeEEtlcF9+fBsw7uKPnuL8?=
 =?us-ascii?Q?wBKkRCWuUzggXSsOa4wyzoVQxUT+kJXWgiMasbgsh9tMeFeeeHPeGInfUMEd?=
 =?us-ascii?Q?A1qBwhDax+ozN4rTgC3bOOawW+y17MGEl/I04qauNEuetcmwiF6sMSHuOq/4?=
 =?us-ascii?Q?ioB+C/BxfO5OMuTZKvHal8Nm7NCzqBy6NIp/DVScJXJ9nUeAgKgqcSqA8wmY?=
 =?us-ascii?Q?5sBkYIRmK982O1P1HnqUD0WmrM95F8j5F3/7+iVwuBYTYwX2/g3RLGgZMFsr?=
 =?us-ascii?Q?QJmS1Ohgtnc5BhT0lTNHdLr8tDYWX4wS0uozQEXx9YiStFoDe5oME3pjnxMm?=
 =?us-ascii?Q?OQgwp4nTLkXC2QfCSjMZLfmt7sk0YmL/Q67Dq0bOxG+FmriXOKGv7Hh+wvFg?=
 =?us-ascii?Q?Hwvz9D127H7zFcM3QZAZAN2R9om0P9tZYv5ZEJoHYehRm52bgrHwp8ZBUww1?=
 =?us-ascii?Q?PHMEoJGeVb8ASoMGRvez5EExrGZDdxxp3r7GNG1j5l0oo8CGTsbcvG0RL47v?=
 =?us-ascii?Q?RzxU2GLq6A7DsMQGcKTLazw2AtB/WFELXTYeNYQLgPrAmn/5x4X06bdld3FA?=
 =?us-ascii?Q?xUJbb6hwwUoU0HJWwGqJ8eHhRaozuFTr/fHI/eoD?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 995d9ee6-9083-4d59-80dc-08da7ac0ef15
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2022 11:10:29.2319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r2wkD0UacTix+oBzkSgJ9ItQw9Z+gpF2d5mLUOIYbuWwTJxFIJlGifxx2+WrPhOsbDjd1bIQeLsatn8w2v1X8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3431
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-10_06,2022-08-10_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 mlxscore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208100034
X-Proofpoint-ORIG-GUID: GI4b07ZZ_u3O999_zO2dR3Sq5pvy4Ikr
X-Proofpoint-GUID: GI4b07ZZ_u3O999_zO2dR3Sq5pvy4Ikr
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patchset contains second subset of patches (after addressing review
comments) discussed at [1]. As per [2], the patches of [1] were divided
into 2 parts so that they can be reviewed feature by feature.
Patches of [2] are now in linux-next. So this patchset is for resuming
review (after addressing latest review comments) of rest of the patches
of [1].

The patches in this change set are as follows:

PATCH-1: Use a per-fs rwsem to protect per-fs list of kernfs_super_info.

PATCH-2: Change kernfs_rename_lock into a read-write lock.

PATCH-3: Introduce interface to access per-fs rwsem.

PATCH-4: Replace per-fs rwsem with hashed rwsems.

PATCH-5: Add a document to describe hashed locks used in kernfs.


    Original cover letter
---------------------------------------------------------------
Reduce contention around global locks used in kernfs.

The current kernfs design makes use of 3 global locks to synchronize
various operations. There are a few other global locks as well but
they are used for specific cases and hence don't cause severe contention.

The above mentioned 3 main global locks used in kernfs are:

1. A global mutex, kernfs_open_file_mutex, to protect the list of
kernfs_open_file instances correspondng to a sysfs attribute.

2. A global spinlock, kernfs_open_node_lock, to protect
kernfs_node->attr.open which points to kernfs_open_node instance
corresponding to a kernfs_node.

3. A global per-fs rw semaphore, root->kernfs_rwsem, to synchronize most
of the other operations like adding, removing, renaming etc. of a file
or directory.

Since these locks are global, they can cause contention when multiple
(for example few hundred) applications try to access sysfs (or other kernfs
based file system) files in parallel, even if the applications are
accessing different and unrelated files.

For example on a system with 384 cores, if I run 200 instances of an
application which is mostly executing the following loop:

  for (int loop = 0; loop <100 ; loop++)
  {
    for (int port_num = 1; port_num < 2; port_num++)
    {
      for (int gid_index = 0; gid_index < 254; gid_index++ )
      {
        char ret_buf[64], ret_buf_lo[64];
        char gid_file_path[1024];

        int      ret_len;
        int      ret_fd;
        ssize_t  ret_rd;

        ub4  i, saved_errno;

        memset(ret_buf, 0, sizeof(ret_buf));
        memset(gid_file_path, 0, sizeof(gid_file_path));

        ret_len = snprintf(gid_file_path, sizeof(gid_file_path),
                           "/sys/class/infiniband/%s/ports/%d/gids/%d",
                           dev_name,
                           port_num,
                           gid_index);

        ret_fd = open(gid_file_path, O_RDONLY | O_CLOEXEC);
        if (ret_fd < 0)
        {
          printf("Failed to open %s\n", gid_file_path);
          continue;
        }

        /* Read the GID */
        ret_rd = read(ret_fd, ret_buf, 40);

        if (ret_rd == -1)
        {
          printf("Failed to read from file %s, errno: %u\n",
                 gid_file_path, saved_errno);

          continue;
        }

        close(ret_fd);
      }
    }

I can see contention around above mentioned locks as follows:

-   54.07%    53.60%  showgids         [kernel.kallsyms]       [k] osq_lock
   - 53.60% __libc_start_main
      - 32.29% __GI___libc_open
           entry_SYSCALL_64_after_hwframe
           do_syscall_64
           sys_open
           do_sys_open
           do_filp_open
           path_openat
           vfs_open
           do_dentry_open
           kernfs_fop_open
           mutex_lock
         - __mutex_lock_slowpath
            - 32.23% __mutex_lock.isra.5
                 osq_lock
      - 21.31% __GI___libc_close
           entry_SYSCALL_64_after_hwframe
           do_syscall_64
           exit_to_usermode_loop
           task_work_run
           ____fput
           __fput
           kernfs_fop_release
           kernfs_put_open_node.isra.8
           mutex_lock
         - __mutex_lock_slowpath
            - 21.28% __mutex_lock.isra.5
                 osq_lock

-   10.49%    10.39%  showgids         [kernel.kallsyms]      [k] down_read
     10.39% __libc_start_main
        __GI___libc_open
        entry_SYSCALL_64_after_hwframe
        do_syscall_64
        sys_open
        do_sys_open
        do_filp_open
      - path_openat
         - 9.72% link_path_walk
            - 5.21% inode_permission
               - __inode_permission
                  - 5.21% kernfs_iop_permission
                       down_read
            - 4.08% walk_component
                 lookup_fast
               - d_revalidate.part.24
                  - 4.08% kernfs_dop_revalidate

-    7.48%     7.41%  showgids         [kernel.kallsyms]       [k] up_read
     7.41% __libc_start_main
        __GI___libc_open
        entry_SYSCALL_64_after_hwframe
        do_syscall_64
        sys_open
        do_sys_open
        do_filp_open
      - path_openat
         - 7.01% link_path_walk
            - 4.12% inode_permission
               - __inode_permission
                  - 4.12% kernfs_iop_permission
                       up_read
            - 2.61% walk_component
                 lookup_fast
               - d_revalidate.part.24
                  - 2.61% kernfs_dop_revalidate

Moreover this run of 200 application isntances takes 32-34 secs. to
complete.                                                     

This patch set is reducing the above mentioned contention by replacing
these global locks with hashed locks. 

For example with the patched kernel and on the same test setup, we no
longer see contention around osq_lock (i.e kernfs_open_file_mutex) and also
contention around per-fs kernfs_rwsem has reduced significantly as well.
This can be seen in the following perf snippet:

-    1.66%     1.65%  showgids         [kernel.kallsyms]      [k] down_read
     1.65% __libc_start_main
        __GI___libc_open
        entry_SYSCALL_64_after_hwframe
        do_syscall_64
        sys_open
        do_sys_open
        do_filp_open
      - path_openat
         - 1.62% link_path_walk
            - 0.98% inode_permission
               - __inode_permission
                  + 0.98% kernfs_iop_permission
            - 0.52% walk_component
                 lookup_fast
               - d_revalidate.part.24
                  - 0.52% kernfs_dop_revalidate

-    1.12%     1.11%  showgids         [kernel.kallsyms]      [k] up_read
     1.11% __libc_start_main
        __GI___libc_open
        entry_SYSCALL_64_after_hwframe
        do_syscall_64
        sys_open
        do_sys_open
        do_filp_open
      - path_openat
         - 1.11% link_path_walk
            - 0.69% inode_permission
               - __inode_permission
                  - 0.69% kernfs_iop_permission
                       up_read

Moreover the test execution time has reduced from 32-34 secs to 15-16 secs.

The patches of this patchset introduce following changes:

PATCH-1: Remove reference counting from kernfs_open_node.

PATCH-2: Make kernfs_open_node->attr.open RCU protected.

PATCH-3: Change kernfs_notify_list to llist.

PATCH-4: Introduce interface to access kernfs_open_file_mutex.

PATCH-5: Replace global kernfs_open_file_mutex with hashed mutexes.

PATCH-6: Use a per-fs rwsem to protect per-fs list of kernfs_super_info.

PATCH-7: Change kernfs_rename_lock into a read-write lock.

PATCH-8: Introduce interface to access per-fs rwsem.

PATCH-9: Replace per-fs rwsem with hashed rwsems.

PATCH-10: Add a document to describe hashed locks used in kernfs.

------------------------------------------------------------------

I did not receive any feedback earlier so resending
after rebasing on tag next-20220810 of linux-next.

Imran Khan (5):
  kernfs: Use a per-fs rwsem to protect per-fs list of
    kernfs_super_info.
  kernfs: Change kernfs_rename_lock into a read-write lock.
  kernfs: Introduce interface to access per-fs rwsem.
  kernfs: Replace per-fs rwsem with hashed rwsems.
  kernfs: Add a document to describe hashed locks used in kernfs.

 .../filesystems/kernfs-hashed-locks.rst       | 214 ++++++++++++++
 fs/kernfs/Makefile                            |   2 +-
 fs/kernfs/dir.c                               | 269 ++++++++++++------
 fs/kernfs/file.c                              |   7 +-
 fs/kernfs/inode.c                             |  48 +++-
 fs/kernfs/kernfs-internal.c                   | 259 +++++++++++++++++
 fs/kernfs/kernfs-internal.h                   | 122 +++++++-
 fs/kernfs/mount.c                             |  23 +-
 fs/kernfs/symlink.c                           |  13 +-
 include/linux/kernfs.h                        |   1 +
 10 files changed, 845 insertions(+), 113 deletions(-)
 create mode 100644 Documentation/filesystems/kernfs-hashed-locks.rst
 create mode 100644 fs/kernfs/kernfs-internal.c


base-commit: bc6c6584ffb27b62e19ea89553b22b4cad1abaca
-- 
2.30.2

