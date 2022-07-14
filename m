Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD092574073
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Jul 2022 02:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbiGNAWq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Jul 2022 20:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiGNAWp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Jul 2022 20:22:45 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D8515FD1;
        Wed, 13 Jul 2022 17:22:44 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26E05Y60017747;
        Thu, 14 Jul 2022 00:22:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=4rydmWb9dfU2kJcvM0eFRHYGsp9YXowoLkFRCeL9+dk=;
 b=dFPWlRN+T8DhHZjO8+FttdOPLFx+J1hhNYCqcLVvmuYF3cI2Qhr9Sy4wZel72qozjxlN
 3Deru5gg82l/GDuybqG3HUBAFoI84X+dCkMWjUhGB8Xa9ow20O9H1U0A6FZKqe8RyoZm
 ba5SR9+Yf9MGRCwR1GhRfCXJ6iO80bNGHHnQSxZAhoNKFUOOhUb4Yu59xcalDeSd8A5C
 VjOCRsP7pDQm07z9mFO/iJcIA7iQAVgiq/ab8jojAuqAbx/9cRG6iuHUDT50AWJ41fdZ
 1+Gc0/KTX+uTdFJJXFb790DCavccp1MWh1ZfpvCEaVtacJNt4WjOwnsjBpR0Cq7lRkub vw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71sgu3e7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Jul 2022 00:22:39 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26E0FcD6023320;
        Thu, 14 Jul 2022 00:22:39 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2174.outbound.protection.outlook.com [104.47.73.174])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3h7045pes3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Jul 2022 00:22:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OgyVd3qz5AlND7iUAg9qEpmcEU4lpe2o5hQxv85uyLR9YClWG6U/Uf/WekgoyoCO5eqgFEgC3z8ghNU/YRtERTDQdGfSr4dJZtTfmZWjd1DxK3BeLNwh9jro0/akX1om246+MTbjELAbMF+4Syeca6Wck1++UCwKtK5PXlqstpxRhNrFaacqpaaKJwsx6erkbpaZF32B+poIlzs1Zb/n3uqRErEsp4En5WA3kjFFGKdufq/7/uy+OGerG9bdXzS+f1+8T9zegutbxWbf0wHn/0aQwYwfo8xNpZAnwA4bL7uekXM/xJUgStNUeUPO0BkjMthCxvNxIYQaoTpJNtA/gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4rydmWb9dfU2kJcvM0eFRHYGsp9YXowoLkFRCeL9+dk=;
 b=ISdVwZ2S/49V+hwlxlCMPa9E+WA2sb1lat8xP9rtFMCBYhz6EBdi37ywUTitPhZ8LQ5mU6v9F9fMedr2Jr4fGzOD2/HtLw/ryNm/Of0sWqaGp3Cp4nhmV6c6s7ze3BVwZaO4xZfygxQdTxd6lBqBFRmB11phaSwUDnEFtcJb1I7rLn4KEiuS12d73WCChYh1dP4Hzkr8jU9/F8x5sOdGtj2aN4BR5cHBjDJijGbhZr/5r8lX3jn8Ne7SIubDEiw03B7g8AP9LPCX/D85F8rwjINM5UOOvhL+EA405ycJDzZIHrfbM5qYwtOEYef8zdBJGNXpXhlJv8KCijyt39DlRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4rydmWb9dfU2kJcvM0eFRHYGsp9YXowoLkFRCeL9+dk=;
 b=c9CQBwAKdvKhl51suuw8YcAYdjMF1wI5rzSS5gPwpgohqBu8P66hkT2V0sU5weAtFCb42rzvUJWtq38AEYaw2Qf5WT29UmZN2y6LkLkIgcpN6ImKUbi3zn95+Vr5540BbEBm4/5VzdLmUAwj5HIqqFrMqocr2n4FP9T1mq0Ps+Y=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by BY5PR10MB3986.namprd10.prod.outlook.com (2603:10b6:a03:1fb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Thu, 14 Jul
 2022 00:22:36 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::dd9d:e9dd:d864:524c]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::dd9d:e9dd:d864:524c%7]) with mapi id 15.20.5438.013; Thu, 14 Jul 2022
 00:22:36 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     tj@kernel.org, gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/5] kernfs: Use a per-fs rwsem to protect per-fs list of kernfs_super_info
Date:   Thu, 14 Jul 2022 10:22:19 +1000
Message-Id: <20220714002224.3641629-1-imran.f.khan@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SYCP282CA0011.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:80::23) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 36010445-9dab-4294-799b-08da652ef3c6
X-MS-TrafficTypeDiagnostic: BY5PR10MB3986:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yl9p0s6awYpkxftRD0bkA7ZEb8fKccwkrrHkasxorbJRcFH/SQLnerkSuvlGrRDdGO+LFjUj53EfkXwAs4pToYtsbA1QpIGYnjXg65xCm+pz8VqnF4rqZ0DOhL35MXMHK6nsicrw1mXJSCg3XgUDApe38kghxXx1bT+40QNq8ansjK0aIyt6NIQ+I/coo1/eAE8DW0TdJSez1B1+apx2r34iJ+Rg1rGVBlMkklisBL9QhzuyvjS4UunpGRjDU8vfx0twQrZztt682qtfqR8OtHzFa0VUs2ybRQJkJwec7HhALUSNTAgyy+iM+xKBWkIiObhtqgoFNjdOFefisuc9CPv4tx2UpK4tpOMPybx/bDCdUPzk7d5DhlqA2KvL2FtTJPNazrZQRfdYU9nXJ5hJBFd+k9pqtLlBMvOCcodBhxlLLTuAJNEXufrGXY6sNr1+U7bP+lC1qrPjd0bnV1Bc3iWH3OCGsPIuBqY6hqChYTaBSZwCYuKTnfh/MJ2ruzQ6chuBmWwWy8H3aXQN9/B/QPDrdVNm/nslJ5W91wx0SccHncW3lDfBXaslVGxWpK20zGs+Lpf6zMF4pasM/u+ykvQ4MYnv84SHlW/djPW9KikCD10t28AUUI36NuIdCtDHKPMjgKgQRlMtbgpYTxd4ZWEMHlyTr+HGrMW5ESl5xCeWqpXMXSFO28c6YTr4EcGZp0mW4Zltm+NB5awR9/oztU6uADgVq8EQ/4kvHhCBmQMWCmJgisFB0VhsahpelKPPcsFJJYKtKE1gXL/X44Qr94fbMRw8Ra/a4XEJFUQOnPs24qupm8eOAaIqrO60C8hJgqboRBps/54qSV4R6YFoZYq95DZttv7m+wMSmnQm8fWOHnbqej4a0Gk/SYtwni5w
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(346002)(39860400002)(136003)(396003)(376002)(26005)(478600001)(6666004)(966005)(52116002)(6506007)(6486002)(6512007)(66946007)(41300700001)(66476007)(8676002)(66556008)(86362001)(316002)(4326008)(83380400001)(38350700002)(1076003)(38100700002)(2616005)(186003)(36756003)(8936002)(5660300002)(103116003)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7Iib5DgOX4r+AKrrcjtXwcJTytP4vXbNJzBVD3D3fzoAwqH3mtDZwaBL4IXP?=
 =?us-ascii?Q?bTI7Bsbkf5fMFlrDOhVN/NPGnVABNl+HmkZ7TErJRf6RFW8xaEKiztviIIoY?=
 =?us-ascii?Q?DlwPkkP52zKYNo+z7PlEkw+tB92Xf505RcS5O/ubz7IOtucRo0oIdquMiwCz?=
 =?us-ascii?Q?1RvQlqc3ByjojzYdfb+U6ZHaqLMYx3LHgxHLML1jiekCkP4j45TC2f8kOLt3?=
 =?us-ascii?Q?NY8+iuOmPUP8Lw5Nho9UW7jgAHkZqU2uEWlJnbaet9S322864QSW/mERTZTB?=
 =?us-ascii?Q?CxJilVl3P0mkhgJ17vquGb+FwVAUDC1zCYrWLZ7LY+6jyHVKkAk+Sc4oZYU3?=
 =?us-ascii?Q?9ix6nEY//hS5j6bUELIb1YHSDrJOgFJQOHPpfqtTZLZc81RfCxcQ3tkMto7o?=
 =?us-ascii?Q?pAT9UKvWXm7FQ6SuBjE54NINLay9Q4/+EroSrkIxLQDm9gtfnAUm01nqwh1k?=
 =?us-ascii?Q?3VTSxEiPsRN8kCMHd39LxBo6SvH46v4wibNpcslsNqZ11A9fq5aHT04mgPg9?=
 =?us-ascii?Q?VC5BEJfVKtYFVHoN6AFlgCeC7zSbt2saB49guwsnfZIA3M0MNdBBf4P6CCLq?=
 =?us-ascii?Q?Ij54Vqzj0EbryJee+oN/3G7ytD+961hcEgYQMJz7S+6Na9Fm6V+OwvgTlOgL?=
 =?us-ascii?Q?2GUNRdP9nxrgYQ7VSf2L4jWqLPOnTSDUn/c6zMqFXma5vvGInnUt8GsACB6L?=
 =?us-ascii?Q?WOW6Gk0ragNTGiwVoVSEDWhWGPDJDg2X/dmPFdndz4eN6HEo8zdWZgqsJlXK?=
 =?us-ascii?Q?WNn6H41Xwo13ZJ6m2oL8ncqDcYkK+3pfy1A0RRKxo21FwwwzjPUUzgmeoDMb?=
 =?us-ascii?Q?zW58hJt58MSX2vILnSInFxsqS56XnhTZQwo6pNqjLnQ+rCeocYltkUEVdJyl?=
 =?us-ascii?Q?HPoBlHw6+KKSiKZWXAZBnnUmRoO5RHth6+mq1RY+gf9mvzF0Nkeho7shOb8n?=
 =?us-ascii?Q?8JGZkSfFG4Ls6xVz9p+821PU0emAE1CRqgKmkNEk7kXEGMti5awtI34OH6Ep?=
 =?us-ascii?Q?3v0dG5xI0w5jWuyme/tNy9sC47dhdjby9BQ537XwcDbJq/XZuFTPO0ibJx+y?=
 =?us-ascii?Q?eRYL6eBUSorXcoRJJrGdNY/kaR6Mc/JGscAv36z+qBTHtuopPY9MRxCkh6iU?=
 =?us-ascii?Q?/ivP/q+wbJvHWV4DWY0DmeGe8bgv8Tn5ybGEF3PZ/Rxq5IWPzDKmyiaa3szY?=
 =?us-ascii?Q?Fu1Z3tFsxQyb4tKfpcVDzNrhfiSzB85q++/grdnofFXMcnhmj2uR+SyQ1fiz?=
 =?us-ascii?Q?KCp1ZseFmk7QsfPN49YiPJZ1vs2VGZd1FwSsMWAfJR/r+0IMIrJfXDA+1bw4?=
 =?us-ascii?Q?JtW8EB02ZG9+i01tA36/epeWwfMReAQMtM7ilXjSu0ID0hDvuIIjNr6xRnTF?=
 =?us-ascii?Q?/6Pqf/cz99fCD5ok1iOZLbFu52nul5Lkk52tMrgDxV4cL7cNqBwaQej7JnPX?=
 =?us-ascii?Q?07OgNeBUSlOaLNcDG1ksV4L5/D3eqEYEM3IKujFOVgpjbm7ti1K7DgnhkSCW?=
 =?us-ascii?Q?lw8jW0n5FbyUj56ZvRNEpH3x/lt5QqQkw2Dl/ec4rzVEgdEV5+w2MHNuekjE?=
 =?us-ascii?Q?KX3NgeDGfMwd8qfIs/YX1w2ZCGP7/BeVrTLoCPcO4nn5kzi7uK3Af1poKfiI?=
 =?us-ascii?Q?Aw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36010445-9dab-4294-799b-08da652ef3c6
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2022 00:22:36.0211
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /7VXIe1Phh+n2WEhVLXSfaaBdEyeuLtlk9ZMsXsN3103Lml0A7rggFQVtI9Gv6BZz4qhRuzS1zZIYKu7Snurpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3986
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-13_13:2022-07-13,2022-07-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 spamscore=0
 adultscore=0 suspectscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207140000
X-Proofpoint-GUID: fI8wkOVnyRhoTdR6fRcs8JwMTYptD-6S
X-Proofpoint-ORIG-GUID: fI8wkOVnyRhoTdR6fRcs8JwMTYptD-6S
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


base-commit: 4112a8699ae2eac797415b9be1d7901b3f79e772

[1]: https://lore.kernel.org/lkml/20220410023719.1752460-1-imran.f.khan@oracle.com/
[2]: https://lore.kernel.org/lkml/20220428055431.3826852-1-imran.f.khan@oracle.com/
-- 
2.30.2

