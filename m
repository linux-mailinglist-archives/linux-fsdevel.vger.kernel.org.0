Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 414A158EAFB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Aug 2022 13:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231853AbiHJLLF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Aug 2022 07:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232009AbiHJLKt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Aug 2022 07:10:49 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E9132D90;
        Wed, 10 Aug 2022 04:10:47 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27A8hvN7013153;
        Wed, 10 Aug 2022 11:10:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=/9D8AdJnrTHvzXVreoGR878YXxxmzPk67ApfqSf1wfw=;
 b=qNbZHlFJGRy5eDsJ9wzOh8hWc7EYadQ4lnPyj8z/nyjS3iVnv/Z0NrD8C+yrC0m75qZS
 pejw6FKxqjwLPqMVjr9gEXyqifRoKsq4zYsHCX+XkJAh2WvgGXzcJ2ChoQdAhreAis7k
 taZrYK+AUsgWUR0DMsgSoBchrIFyYdbuKnL7UjbaVemolSjpvD5slyHJp5kXqMCvaKDF
 lPDJ0TzaspyWgUTgwJ9hWOug61LieVChpXCAvCNZUI2u6adkMEn4pcQG0aVqwHllFzE6
 EoYiZ0qGSzfMxIedh1gI+YjnaN4iNqZ4ADXUfADOEnjZr8P7HVM6dNYF+xRQhLUsOH9A rw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3huwqghgs1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Aug 2022 11:10:41 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27A9L4G1036828;
        Wed, 10 Aug 2022 11:10:39 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3huwqhhwvj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Aug 2022 11:10:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ml1YMmJXKTFpqlQqgy20I0WkODtSnxwHWP+iqHFNgtml1aqn0tMynfKvZTyRf9VkFIMJGS5jHekryS0PhJmapNpB9OTibnxoOi/eOmMqm9pVeOHD1B0qkCXNqugLTGhmijPsaIdl7ZFH9wbYk40u3p1jrDd4LxCKN5xyKbJFN8ehn6o1daZBcuBmFK9BlxJRWTzqb4umoYaFgSL2vXLu0/fwbRkt2+DT9DAY29zqRwKxYT8UhEy1p8acP2wlNr2Qo2D0FAHj183QlGDFzyM8+KhLXsDAuYzclIRnuxjvv1FJhhQICvFgfS2/OZYwfty1otuA84XU9Kqwz5rPFDxRiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/9D8AdJnrTHvzXVreoGR878YXxxmzPk67ApfqSf1wfw=;
 b=dT9uKRGjOu9SikNyJGUp/Lpu6+Vjclw6Tr+MURs6DaOqFgdLS/lfS4iv3l46LGq1aXoiQpifxRTlJCK7QI/bJNC75S2Pf1gei39YAHsxrufdgLTi5szT4mx7AtMKCqRq1sdS6f8mBb1Cx8lhLZIbdLgamgmw4nmphT0wt5t94dx37bad/8Pial2xX4r9i+mkwZTZ6/nKzfQMgUcD6FYJdpDX8OEq/JpeyxqTgt+tsDlIEbAR5DeqkNRKp5tIVpTGEkK91sN+4BQWB8WtinXs0okae7RLHc8zLZ8C84HbJXIdhms6z6nHklhg7iS/a3/zPD9wBScNLdPkdueZA2rZ7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/9D8AdJnrTHvzXVreoGR878YXxxmzPk67ApfqSf1wfw=;
 b=rskYZXinjQrkPMpiv0XkXO6XGTHp2VR1m7OhUdBJCjOQyCXLvW9Y0WUSW5z+qhfpcWGLM7uHLG6vOfRzIz3i8p0VZ3FxKEyfsW+E215lkXNZzrX8cItSq5UPVKAQYe8FoXmPenjRX9HWqBdp8ONVb+T389OdpIxEHEe88gWDEXM=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by BYAPR10MB3431.namprd10.prod.outlook.com (2603:10b6:a03:86::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Wed, 10 Aug
 2022 11:10:36 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::c504:bfd6:7940:544f]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::c504:bfd6:7940:544f%5]) with mapi id 15.20.5525.011; Wed, 10 Aug 2022
 11:10:36 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     tj@kernel.org, gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RESEND PATCH 4/5] kernfs: Replace per-fs rwsem with hashed rwsems.
Date:   Wed, 10 Aug 2022 21:10:16 +1000
Message-Id: <20220810111017.2267160-5-imran.f.khan@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220810111017.2267160-1-imran.f.khan@oracle.com>
References: <20220810111017.2267160-1-imran.f.khan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY3PR01CA0134.ausprd01.prod.outlook.com
 (2603:10c6:0:1b::19) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 51dac534-56ec-434f-558a-08da7ac0f389
X-MS-TrafficTypeDiagnostic: BYAPR10MB3431:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n6GVRtOGcqqijBspdq79OojezSRtSDmTDNh2nTfnLNEUb5amAlN0/XdckrglO0feyN7CVM6FPnoK6hYnbfWNjxHggeg21IK1+PuUgZ/yvc0lx//rZ2Pcv4MdyZX7io0FAq/5flRleo+FLb9uXBkSqXmBuifGaYf/zRX5MdvYEoi2OSIFYm7bM7EhP/nk9fGj0E6EuS4n7HAOAwjsenF/1/fzEcqPAaklewK2Pj0Cz8uFbDocQkBF2gW12bb9C5RPCqrlTls2RaU5D2jE0dg5kXsaOKy8DQV1TMsPGT1AnqJ3vU9Xtb5TB/nWu8h1OIPzvsxQex/rfNxvrvtecMPLhKKochKI1Gy4J82Ot9BWwT/zg6jfDCyTBQn9GCMiD+2RTTKR9qH96U33IuhtugrMql0XBfHRvWZtJqsPCQ1BhqSvkncygRHAZsbr0e1OjOWM8Phaqhbg3nwdg2Ewxaovhe7hiQccScXnnErF+nhuwdX9HZ9i/zg94MkopbePoVl6QdT53sTBvsaAIxcSZ3egiX9SQD0kSI/xMx+LOFcsARzHDQnntIYI8LmBV/FAZ5CL4qOVY6Qxhpm1k2D3PkH7e6iLODjELZF7ZzsI0BD6srlUt42xqtnpYdNGBkTpR51Y9oP1pT3vIyHR1LEUkjgJFDpHPgRU7zAU1hmIWQLcRIrL0WRd6aSI5ge0lOR6ETzyiQAW6nld9eLH9uqnoQ4gGEdujlLZ9DjFlQfZvYfi3OUUt+yXijS1WsD2LAD4XhlSUQBA8ii5aZAisRUAOZv+ybnSVAzQLEUhDOLorj36YLA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(346002)(396003)(136003)(376002)(39860400002)(8936002)(66556008)(4326008)(186003)(66476007)(36756003)(1076003)(103116003)(316002)(5660300002)(8676002)(6486002)(86362001)(66946007)(478600001)(30864003)(2616005)(41300700001)(83380400001)(6512007)(26005)(6666004)(2906002)(6506007)(38350700002)(52116002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?l4b99hEwR1pVl3NucAW1a4aT0QcCibX76xyTtZmmjHDu9nr47B8BxmB7fGJR?=
 =?us-ascii?Q?9/GcGbFjhYjMulV+wx94JZwE+NauGNWjUMRaTkNiou2ovldwQZlidnPEf5EX?=
 =?us-ascii?Q?LYcNHvV7QI/5OjuujXNhwEnxnnxDolvGcwIWsmllPDGpGTOLm0M4DKtSIaiV?=
 =?us-ascii?Q?9mHx1qIby+ngjn6VNVOU5UvjC1TVJc307DhfplRBUWm+5AwQq6EkBALxBHMi?=
 =?us-ascii?Q?IZ7jlHyDNHaeT0Qj+SS6kpQ9+eDLEzT2paUOic8qUDzxCe6cbBsmBSYoxvga?=
 =?us-ascii?Q?MKuqC4A4bBffyq0Azdw+br7qLD/05UA9zV5hkc526aW/z2AZQytdsKlMCU3m?=
 =?us-ascii?Q?ze37cQj/bxoIHhBxxF0JUvHSqctA0KZ0paemaXLsswD8C7yVUKifK5YFVPO2?=
 =?us-ascii?Q?yE+tMpBfpmOmpHxIDKKVEAEFH1yQeh8+Fi0AG/yr0+uEqhEeilFBYUCh1UTO?=
 =?us-ascii?Q?hWQvV8fDmCZm95L47gwVAvk5RoezZMmyXhoNM4X+Lt6B4RghMdTB4bHTWfrS?=
 =?us-ascii?Q?MwuFCf/GPXu0CzsUC5vX9KHUvP1bz2ub5DQeVr+6B9aJ7XajJU0bx3vz5oyg?=
 =?us-ascii?Q?rKn2S7jP+9TRHqpWZD7BD2uXVNRez1+uL8Uv6y1OTVXXzTqRHbgHbNFK0XSR?=
 =?us-ascii?Q?J2EREusbj5bye5+7p8H9MQKuCIEGDwqa/RaaeW+qetkHC0EWSAoQKCoFjDst?=
 =?us-ascii?Q?0pd1FtxDT/jk6RmSBHGVg1/7yLLPpSfWlFgnDIpbiM89pWL6Ofg/hZcIPGyc?=
 =?us-ascii?Q?8aiuohEgpSRpZT/rz19LM0FiJIOpFnkHvIWRu3q3HU+iI1+8UI756hXdfpO9?=
 =?us-ascii?Q?r8+6OCSVkKw8SEYgNXT/ZQ833FePL+fKYKSRODuWD6dq9ZbZTuenD0pvLHwX?=
 =?us-ascii?Q?ohQ9DUcwk8cL61De3tJZ1tdo+mLQq1K639ySMEjAqwH12EfkkScgnQ7DUb7j?=
 =?us-ascii?Q?i24+llZYGc79wPV0J7ZgK9CS2m+NRx6Mp3hBxGuKIS6BDip16a+O7JIcmSpw?=
 =?us-ascii?Q?vimJatFw8ExcpgphCGBMiRlm70aQgXtu0o+sFu5zFNoqekr5vDQaP6JCtuPF?=
 =?us-ascii?Q?6VA56R2rX9sIotQm7/94G94vs+WzCVLTDvV0PsYtqQ/5lWEJ47/hrDjkGkZw?=
 =?us-ascii?Q?NzkZgV9VbUV5DEGtUhGqtowOEmBxKKHWmM82O6MWupBZNrIq9gTvQhvn9jf8?=
 =?us-ascii?Q?0pBTR4ShK3yXqXhaScLzdWS+0fKF8R5P00ZCvW7iIVEUtpPy2mwF7fn/5shH?=
 =?us-ascii?Q?3KUaphFFs5BpW+xtoJoRHZYeAnrl3lMoc1NoL1wdBnezcWRmG7AyWb0tqDz5?=
 =?us-ascii?Q?o/ie7YRgCd4tsw0cSQ6txzlKv/IDBxY1KTvOwepep6oUPWpW/9oIqFTgSciX?=
 =?us-ascii?Q?p79Nnby4/qQjTlUKx01TLPx7LBc0g5GS84n9qPR5fGFoUewzZCP45OfabPFJ?=
 =?us-ascii?Q?GBLmtTmKY/W092u6nymgALGygs30Gkg2THK5n2YUsBEAULfF17Ok69mNZD9y?=
 =?us-ascii?Q?hAbL+ngC9njoD2p9ksmc+5WTt8W9gLa+mMaoYOYEstsU9kkSsHvB+ZL5RIa4?=
 =?us-ascii?Q?Eek0cpHFyG0DglIwDy/TkOa43xzVdM1aLImr4qc+g56b+xojsqiGiskE+pdp?=
 =?us-ascii?Q?9A=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51dac534-56ec-434f-558a-08da7ac0f389
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2022 11:10:36.7812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YmyAgFplH9EGeywb1HSw1rY0kwj7vC76r+RiAbQIiXJzBaoYwjfBM2FLmTZb3vIxT/WckHH+8SK6L3ZQrNzdFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3431
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-10_06,2022-08-10_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 mlxscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208100034
X-Proofpoint-GUID: Bgyot8DoNHG_QSbBc_xKBP4VQIcTlRmL
X-Proofpoint-ORIG-GUID: Bgyot8DoNHG_QSbBc_xKBP4VQIcTlRmL
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Having a single rwsem to synchronize all operations across a kernfs
based file system (cgroup, sysfs etc.) does not scale well. The contention
around this single rwsem becomes more apparent in large scale systems with
few hundred CPUs where most of the CPUs have running tasks that are
opening, accessing or closing sysfs files at any point of time.

Using hashed rwsems in place of a per-fs rwsem, can significantly reduce
contention around per-fs rwsem and hence provide better scalability.
Moreover as these hashed rwsems are not part of kernfs_node objects we will
not see any singnificant change in memory utilization of kernfs based file
systems like sysfs, cgroupfs etc.

Modify interface introduced in previous patch to make use of hashed rwsems.
Just like earlier change use kernfs_node address as hashing key. Since we
are getting rid of per-fs lock, in certain cases we may need to acquire
locks corresponding to multiple nodes and in such cases of nested locking,
locks are taken in order of their addresses. Introduce helpers to acquire
rwsems corresponding to multiple nodes for such cases.

For operations that involve finding the node first and then operating on it
(for example operations involving find_and_get_ns), acquiring rwsem for the
node being searched is not possible. Such operations need to make sure that
a concurrent remove does not remove the found node. Introduce a per-fs
mutex (kernfs_topo_mutex) that can be used to synchronize these operations
against parallel removal/renaming of involved node.

Also replace usage of kernfs_pr_cont_buf with another global buffer in
kernfs_walk_ns. This is because kernfs_pr_cont_buf is protected by a
spinlock but now kernfs_walk_ns needs to acquire hashed rwsem corresponding
to nodes further down in the path and this can't be done under spinlock.
Having another buffer to piggyback the path in kernfs_walk_ns and protecting
this with kernfs_topo_mutex (mentioned earlier) would avoid need of spinlock
and also ensure that there is no topology change.

Replacing global mutex and spinlocks with hashed ones (as mentioned in
previous changes) and global rwsem with hashed rwsem (as done in this
change) reduces contention around kernfs and results in better performance
numbers.

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

With the patched kernel and on the same test setup, we no longer see
contention around osq_lock (i.e kernfs_open_file_mutex) and also
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

Moreover the test execution time has reduced from 32-34 secs to 18-19 secs.

Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
---
 fs/kernfs/Makefile          |   2 +-
 fs/kernfs/dir.c             | 161 +++++++++++++++++-----
 fs/kernfs/inode.c           |  20 +++
 fs/kernfs/kernfs-internal.c | 259 ++++++++++++++++++++++++++++++++++++
 fs/kernfs/kernfs-internal.h |  47 ++++++-
 fs/kernfs/mount.c           |   9 ++
 fs/kernfs/symlink.c         |  13 +-
 include/linux/kernfs.h      |   1 +
 8 files changed, 474 insertions(+), 38 deletions(-)
 create mode 100644 fs/kernfs/kernfs-internal.c

diff --git a/fs/kernfs/Makefile b/fs/kernfs/Makefile
index 4ca54ff54c98..778da6b118e9 100644
--- a/fs/kernfs/Makefile
+++ b/fs/kernfs/Makefile
@@ -3,4 +3,4 @@
 # Makefile for the kernfs pseudo filesystem
 #
 
-obj-y		:= mount.o inode.o dir.o file.o symlink.o
+obj-y		:= mount.o inode.o dir.o file.o symlink.o kernfs-internal.o
diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 73f4ebc1464e..7d02c3dd2c20 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -17,7 +17,7 @@
 
 #include "kernfs-internal.h"
 
-static DEFINE_RWLOCK(kernfs_rename_lock);	/* kn->parent and ->name */
+DEFINE_RWLOCK(kernfs_rename_lock);	/* kn->parent and ->name */
 /*
  * Don't use rename_lock to piggy back on pr_cont_buf. We don't want to
  * call pr_cont() while holding rename_lock. Because sometimes pr_cont()
@@ -27,13 +27,13 @@ static DEFINE_RWLOCK(kernfs_rename_lock);	/* kn->parent and ->name */
  */
 static DEFINE_SPINLOCK(kernfs_pr_cont_lock);
 static char kernfs_pr_cont_buf[PATH_MAX];	/* protected by pr_cont_lock */
+static char kernfs_path_buf[PATH_MAX];		/* protected by kernfs_topo_mutex */
 static DEFINE_SPINLOCK(kernfs_idr_lock);	/* root->ino_idr */
 
 #define rb_to_kn(X) rb_entry((X), struct kernfs_node, rb)
 
 static bool kernfs_active(struct kernfs_node *kn)
 {
-	kernfs_rwsem_assert_held(kn);
 	return atomic_read(&kn->active) >= 0;
 }
 
@@ -458,14 +458,15 @@ void kernfs_put_active(struct kernfs_node *kn)
 /**
  * kernfs_drain - drain kernfs_node
  * @kn: kernfs_node to drain
+ * @anc: ancestor of kernfs_node to drain
  *
  * Drain existing usages and nuke all existing mmaps of @kn.  Mutiple
  * removers may invoke this function concurrently on @kn and all will
  * return after draining is complete.
  */
-static void kernfs_drain(struct kernfs_node *kn)
-	__releases(&kernfs_root(kn)->kernfs_rwsem)
-	__acquires(&kernfs_root(kn)->kernfs_rwsem)
+static void kernfs_drain(struct kernfs_node *kn, struct kernfs_node *anc)
+	__releases(kernfs_rwsem_ptr(anc))
+	__acquires(kernfs_rwsem_ptr(anc))
 {
 	struct rw_semaphore *rwsem;
 	struct kernfs_root *root = kernfs_root(kn);
@@ -476,10 +477,11 @@ static void kernfs_drain(struct kernfs_node *kn)
 	 */
 	rwsem = kernfs_rwsem_ptr(kn);
 
-	kernfs_rwsem_assert_held_write(kn);
+	kernfs_rwsem_assert_held_write(anc);
 
 	WARN_ON_ONCE(kernfs_active(kn));
 
+	rwsem = kernfs_rwsem_ptr(anc);
 	kernfs_up_write(rwsem);
 
 	if (kernfs_lockdep(kn)) {
@@ -499,7 +501,7 @@ static void kernfs_drain(struct kernfs_node *kn)
 
 	kernfs_drain_open_files(kn);
 
-	kernfs_down_write(kn);
+	kernfs_down_write(anc);
 }
 
 /**
@@ -739,6 +741,11 @@ int kernfs_add_one(struct kernfs_node *kn)
 	bool has_ns;
 	int ret;
 
+	/**
+	 * The node being added is not active at this point of time and may
+	 * be activated later depending on CREATE_DEACTIVATED flag. So at
+	 * this point of time just locking the parent is enough.
+	 */
 	rwsem = kernfs_down_write(parent);
 
 	ret = -EINVAL;
@@ -836,28 +843,35 @@ static struct kernfs_node *kernfs_walk_ns(struct kernfs_node *parent,
 {
 	size_t len;
 	char *p, *name;
+	struct rw_semaphore *rwsem;
 
 	kernfs_rwsem_assert_held_read(parent);
 
-	spin_lock_irq(&kernfs_pr_cont_lock);
+	lockdep_assert_held(&kernfs_root(parent)->kernfs_topo_mutex);
 
-	len = strlcpy(kernfs_pr_cont_buf, path, sizeof(kernfs_pr_cont_buf));
+	/* Caller has kernfs_topo_mutex so topology will not change */
+	p = kernfs_path_buf;
+	len = strlcpy(p, path, PATH_MAX);
 
-	if (len >= sizeof(kernfs_pr_cont_buf)) {
-		spin_unlock_irq(&kernfs_pr_cont_lock);
+	if (len >= PATH_MAX) {
+		kfree(p);
 		return NULL;
 	}
 
-	p = kernfs_pr_cont_buf;
-
+	rwsem = kernfs_rwsem_ptr(parent);
 	while ((name = strsep(&p, "/")) && parent) {
 		if (*name == '\0')
 			continue;
 		parent = kernfs_find_ns(parent, name, ns);
+		/*
+		 * Release rwsem for node whose child RB tree has been
+		 * traversed.
+		 */
+		kernfs_up_read(rwsem);
+		if (parent) /* Acquire rwsem before traversing child RB tree */
+			rwsem = kernfs_down_read(parent);
 	}
 
-	spin_unlock_irq(&kernfs_pr_cont_lock);
-
 	return parent;
 }
 
@@ -876,11 +890,20 @@ struct kernfs_node *kernfs_find_and_get_ns(struct kernfs_node *parent,
 {
 	struct kernfs_node *kn;
 	struct rw_semaphore *rwsem;
+	struct kernfs_root *root = kernfs_root(parent);
 
+	/**
+	 * We don't have address of kernfs_node (that is being searched)
+	 * yet. Acquiring root->kernfs_topo_mutex and releasing it after
+	 * pinning the found kernfs_node, ensures that found kernfs_node
+	 * will not disappear due to a parallel remove operation.
+	 */
+	mutex_lock(&root->kernfs_topo_mutex);
 	rwsem = kernfs_down_read(parent);
 	kn = kernfs_find_ns(parent, name, ns);
 	kernfs_get(kn);
 	kernfs_up_read(rwsem);
+	mutex_unlock(&root->kernfs_topo_mutex);
 
 	return kn;
 }
@@ -901,11 +924,26 @@ struct kernfs_node *kernfs_walk_and_get_ns(struct kernfs_node *parent,
 {
 	struct kernfs_node *kn;
 	struct rw_semaphore *rwsem;
+	struct kernfs_root *root = kernfs_root(parent);
 
+	/**
+	 * We don't have address of kernfs_node (that is being searched)
+	 * yet. Acquiring root->kernfs_topo_mutex and releasing it after
+	 * pinning the found kernfs_node, ensures that found kernfs_node
+	 * will not disappear due to a parallel remove operation.
+	 */
+	mutex_lock(&root->kernfs_topo_mutex);
 	rwsem = kernfs_down_read(parent);
 	kn = kernfs_walk_ns(parent, path, ns);
 	kernfs_get(kn);
-	kernfs_up_read(rwsem);
+	if (kn)
+		/* Release lock taken under kernfs_walk_ns */
+		kernfs_up_read(kernfs_rwsem_ptr(kn));
+	else
+		/* Release parent lock because walk_ns bailed out early */
+		kernfs_up_read(rwsem);
+
+	mutex_unlock(&root->kernfs_topo_mutex);
 
 	return kn;
 }
@@ -930,9 +968,9 @@ struct kernfs_root *kernfs_create_root(struct kernfs_syscall_ops *scops,
 		return ERR_PTR(-ENOMEM);
 
 	idr_init(&root->ino_idr);
-	init_rwsem(&root->kernfs_rwsem);
 	INIT_LIST_HEAD(&root->supers);
 	init_rwsem(&root->supers_rwsem);
+	mutex_init(&root->kernfs_topo_mutex);
 
 	/*
 	 * On 64bit ino setups, id is ino.  On 32bit, low 32bits are ino.
@@ -1102,6 +1140,11 @@ static int kernfs_dop_revalidate(struct dentry *dentry, unsigned int flags)
 	}
 
 	kn = kernfs_dentry_node(dentry);
+	/**
+	 * For dentry revalidation just acquiring kernfs_node's rwsem for
+	 * reading should be enough. If a competing rename or remove wins
+	 * one of the checks below will fail.
+	 */
 	rwsem = kernfs_down_read(kn);
 
 	/* The kernfs node has been deactivated */
@@ -1141,24 +1184,35 @@ static struct dentry *kernfs_iop_lookup(struct inode *dir,
 	struct inode *inode = NULL;
 	const void *ns = NULL;
 	struct rw_semaphore *rwsem;
+	struct kernfs_root *root = kernfs_root(parent);
 
+	/**
+	 * We don't have address of kernfs_node (that is being searched)
+	 * yet. So take root->kernfs_topo_mutex to avoid parallel removal of
+	 * found kernfs_node.
+	 */
+	mutex_lock(&root->kernfs_topo_mutex);
 	rwsem = kernfs_down_read(parent);
 	if (kernfs_ns_enabled(parent))
 		ns = kernfs_info(dir->i_sb)->ns;
 
 	kn = kernfs_find_ns(parent, dentry->d_name.name, ns);
+	kernfs_up_read(rwsem);
 	/* attach dentry and inode */
 	if (kn) {
 		/* Inactive nodes are invisible to the VFS so don't
 		 * create a negative.
 		 */
+		rwsem = kernfs_down_read(kn);
 		if (!kernfs_active(kn)) {
 			kernfs_up_read(rwsem);
+			mutex_unlock(&root->kernfs_topo_mutex);
 			return NULL;
 		}
 		inode = kernfs_get_inode(dir->i_sb, kn);
 		if (!inode)
 			inode = ERR_PTR(-ENOMEM);
+		kernfs_up_read(rwsem);
 	}
 	/*
 	 * Needed for negative dentry validation.
@@ -1166,9 +1220,11 @@ static struct dentry *kernfs_iop_lookup(struct inode *dir,
 	 * or transforms from positive dentry in dentry_unlink_inode()
 	 * called from vfs_rmdir().
 	 */
+	rwsem = kernfs_down_read(parent);
 	if (!IS_ERR(inode))
 		kernfs_set_rev(parent, dentry);
 	kernfs_up_read(rwsem);
+	mutex_unlock(&root->kernfs_topo_mutex);
 
 	/* instantiate and hash (possibly negative) dentry */
 	return d_splice_alias(inode, dentry);
@@ -1348,19 +1404,26 @@ void kernfs_activate(struct kernfs_node *kn)
 static void __kernfs_remove(struct kernfs_node *kn)
 {
 	struct kernfs_node *pos;
+	struct rw_semaphore *rwsem;
+	struct kernfs_root *root;
 
 	/* Short-circuit if non-root @kn has already finished removal. */
 	if (!kn)
 		return;
 
-	kernfs_rwsem_assert_held_write(kn);
 
+	root = kernfs_root(kn);
 	/*
 	 * This is for kernfs_remove_self() which plays with active ref
 	 * after removal.
 	 */
-	if (kn->parent && RB_EMPTY_NODE(&kn->rb))
+	mutex_lock(&root->kernfs_topo_mutex);
+	rwsem = kernfs_down_write(kn);
+	if (kn->parent && RB_EMPTY_NODE(&kn->rb)) {
+		kernfs_up_write(rwsem);
+		mutex_unlock(&root->kernfs_topo_mutex);
 		return;
+	}
 
 	pr_debug("kernfs %s: removing\n", kn->name);
 
@@ -1370,8 +1433,11 @@ static void __kernfs_remove(struct kernfs_node *kn)
 		if (kernfs_active(pos))
 			atomic_add(KN_DEACTIVATED_BIAS, &pos->active);
 
+	kernfs_up_write(rwsem);
+
 	/* deactivate and unlink the subtree node-by-node */
 	do {
+		rwsem = kernfs_down_write(kn);
 		pos = kernfs_leftmost_descendant(kn);
 
 		/*
@@ -1389,10 +1455,25 @@ static void __kernfs_remove(struct kernfs_node *kn)
 		 * error paths without worrying about draining.
 		 */
 		if (kn->flags & KERNFS_ACTIVATED)
-			kernfs_drain(pos);
+			kernfs_drain(pos, kn);
 		else
 			WARN_ON_ONCE(atomic_read(&kn->active) != KN_DEACTIVATED_BIAS);
 
+		kernfs_up_write(rwsem);
+
+		/**
+		 * By now node and all of its descendants have been deactivated
+		 * Once a descendant has been drained, acquire its parent's lock
+		 * and unlink it from parent's children rb tree.
+		 * We drop kn's lock before acquiring pos->parent's lock to avoid
+		 * deadlock that will happen if pos->parent and kn hash to same lock.
+		 * Dropping kn's lock should be safe because it is in deactived state.
+		 * Further root->kernfs_topo_mutex ensures that we will not have
+		 * concurrent instances of __kernfs_remove
+		 */
+		if (pos->parent)
+			rwsem = kernfs_down_write(pos->parent);
+
 		/*
 		 * kernfs_unlink_sibling() succeeds once per node.  Use it
 		 * to decide who's responsible for cleanups.
@@ -1410,8 +1491,12 @@ static void __kernfs_remove(struct kernfs_node *kn)
 			kernfs_put(pos);
 		}
 
+		if (pos->parent)
+			kernfs_up_write(rwsem);
 		kernfs_put(pos);
 	} while (pos != kn);
+
+	mutex_unlock(&root->kernfs_topo_mutex);
 }
 
 /**
@@ -1422,14 +1507,10 @@ static void __kernfs_remove(struct kernfs_node *kn)
  */
 void kernfs_remove(struct kernfs_node *kn)
 {
-	struct rw_semaphore *rwsem;
-
 	if (!kn)
 		return;
 
-	rwsem = kernfs_down_write(kn);
 	__kernfs_remove(kn);
-	kernfs_up_write(rwsem);
 }
 
 /**
@@ -1531,9 +1612,11 @@ bool kernfs_remove_self(struct kernfs_node *kn)
 	 */
 	if (!(kn->flags & KERNFS_SUICIDAL)) {
 		kn->flags |= KERNFS_SUICIDAL;
+		kernfs_up_write(rwsem);
 		__kernfs_remove(kn);
 		kn->flags |= KERNFS_SUICIDED;
 		ret = true;
+		rwsem = kernfs_down_write(kn);
 	} else {
 		wait_queue_head_t *waitq = &kernfs_root(kn)->deactivate_waitq;
 		DEFINE_WAIT(wait);
@@ -1588,11 +1671,17 @@ int kernfs_remove_by_name_ns(struct kernfs_node *parent, const char *name,
 
 	rwsem = kernfs_down_write(parent);
 
+	/**
+	 * Since the node being searched will be removed eventually,
+	 * we don't need to take root->kernfs_topo_mutex.
+	 * Even if a parallel remove succeeds, the subsequent __kernfs_remove
+	 * will detect it and bail-out early.
+	 */
 	kn = kernfs_find_ns(parent, name, ns);
-	if (kn)
-		__kernfs_remove(kn);
 
 	kernfs_up_write(rwsem);
+	if (kn)
+		__kernfs_remove(kn);
 
 	if (kn)
 		return 0;
@@ -1612,14 +1701,26 @@ int kernfs_rename_ns(struct kernfs_node *kn, struct kernfs_node *new_parent,
 {
 	struct kernfs_node *old_parent;
 	const char *old_name = NULL;
-	struct rw_semaphore *rwsem;
+	struct kernfs_rwsem_token token;
 	int error;
+	struct kernfs_root *root = kernfs_root(kn);
 
 	/* can't move or rename root */
 	if (!kn->parent)
 		return -EINVAL;
 
-	rwsem = kernfs_down_write(kn);
+	mutex_lock(&root->kernfs_topo_mutex);
+	old_parent = kn->parent;
+	kernfs_get(old_parent);
+	kernfs_down_write_triple_nodes(kn, old_parent, new_parent, &token);
+	while (old_parent != kn->parent) {
+		kernfs_put(old_parent);
+		kernfs_up_write_triple_nodes(kn, old_parent, new_parent, &token);
+		old_parent = kn->parent;
+		kernfs_get(old_parent);
+		kernfs_down_write_triple_nodes(kn, old_parent, new_parent, &token);
+	}
+	kernfs_put(old_parent);
 
 	error = -ENOENT;
 	if (!kernfs_active(kn) || !kernfs_active(new_parent) ||
@@ -1654,7 +1755,6 @@ int kernfs_rename_ns(struct kernfs_node *kn, struct kernfs_node *new_parent,
 	/* rename_lock protects ->parent and ->name accessors */
 	write_lock_irq(&kernfs_rename_lock);
 
-	old_parent = kn->parent;
 	kn->parent = new_parent;
 
 	kn->ns = new_ns;
@@ -1673,7 +1773,8 @@ int kernfs_rename_ns(struct kernfs_node *kn, struct kernfs_node *new_parent,
 
 	error = 0;
  out:
-	kernfs_up_write(rwsem);
+	mutex_unlock(&root->kernfs_topo_mutex);
+	kernfs_up_write_triple_nodes(kn, new_parent, old_parent, &token);
 	return error;
 }
 
diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
index efe5ae98abf4..36a40b08b97f 100644
--- a/fs/kernfs/inode.c
+++ b/fs/kernfs/inode.c
@@ -101,6 +101,12 @@ int kernfs_setattr(struct kernfs_node *kn, const struct iattr *iattr)
 	int ret;
 	struct rw_semaphore *rwsem;
 
+	/**
+	 * Since we are only modifying the inode attribute, we just need
+	 * to lock involved node. Operations that add or remove a node
+	 * acquire parent's lock before changing the inode attributes, so
+	 * such operations are also in sync with this interface.
+	 */
 	rwsem = kernfs_down_write(kn);
 	ret = __kernfs_setattr(kn, iattr);
 	kernfs_up_write(rwsem);
@@ -118,6 +124,12 @@ int kernfs_iop_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 	if (!kn)
 		return -EINVAL;
 
+	/**
+	 * Since we are only modifying the inode attribute, we just need
+	 * to lock involved node. Operations that add or remove a node
+	 * acquire parent's lock before changing the inode attributes, so
+	 * such operations are also in sync with .setattr backend.
+	 */
 	rwsem = kernfs_down_write(kn);
 	error = setattr_prepare(&init_user_ns, dentry, iattr);
 	if (error)
@@ -188,6 +200,10 @@ int kernfs_iop_getattr(struct user_namespace *mnt_userns,
 	struct kernfs_node *kn = inode->i_private;
 	struct rw_semaphore *rwsem;
 
+	/**
+	 * As we are only reading ->iattr, acquiring kn's rwsem for
+	 * reading is enough.
+	 */
 	rwsem = kernfs_down_read(kn);
 	spin_lock(&inode->i_lock);
 	kernfs_refresh_inode(kn, inode);
@@ -285,6 +301,10 @@ int kernfs_iop_permission(struct user_namespace *mnt_userns,
 
 	kn = inode->i_private;
 
+	/**
+	 * As we are only reading ->iattr, acquiring kn's rwsem for
+	 * reading is enough.
+	 */
 	rwsem = kernfs_down_read(kn);
 	spin_lock(&inode->i_lock);
 	kernfs_refresh_inode(kn, inode);
diff --git a/fs/kernfs/kernfs-internal.c b/fs/kernfs/kernfs-internal.c
new file mode 100644
index 000000000000..80d7d64532fe
--- /dev/null
+++ b/fs/kernfs/kernfs-internal.c
@@ -0,0 +1,259 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * This file provides inernal helpers for kernfs.
+ */
+
+#include "kernfs-internal.h"
+
+static void kernfs_swap_rwsems(struct rw_semaphore **array, int i, int j)
+{
+	struct rw_semaphore *tmp;
+
+	tmp = array[i];
+	array[i] = array[j];
+	array[j] = tmp;
+}
+
+static void kernfs_sort_rwsems(struct kernfs_rwsem_token *token)
+{
+	struct rw_semaphore **array = &token->rwsems[0];
+
+	if (token->count == 2) {
+		if (array[0] == array[1])
+			token->count = 1;
+		else if (array[0] > array[1])
+			kernfs_swap_rwsems(array, 0, 1);
+	} else {
+		if (array[0] == array[1] && array[0] == array[2])
+			token->count = 1;
+		else {
+			if (array[0] > array[1])
+				kernfs_swap_rwsems(array, 0, 1);
+
+			if (array[0] > array[2])
+				kernfs_swap_rwsems(array, 0, 2);
+
+			if (array[1] > array[2])
+				kernfs_swap_rwsems(array, 1, 2);
+
+			if (array[0] == array[1] || array[1] == array[2])
+				token->count = 2;
+		}
+	}
+}
+
+/**
+ * kernfs_down_write_double_nodes() - take hashed rwsem for 2 nodes
+ *
+ * @kn1: first kernfs_node of interest
+ * @kn2: second kernfs_node of interest
+ * @token: token to pass unlocking information to caller
+ *
+ * Acquire hashed rwsem for 2 nodes. Some operation may need to acquire
+ * hashed rwsems for 2 nodes (for example for a node and its parent).
+ * This function can be used in such cases.
+ *
+ * Return: void
+ */
+void kernfs_down_write_double_nodes(struct kernfs_node *kn1,
+				    struct kernfs_node *kn2,
+				    struct kernfs_rwsem_token *token)
+{
+	struct rw_semaphore **array = &token->rwsems[0];
+
+	array[0] = kernfs_rwsem_ptr(kn1);
+	array[1] = kernfs_rwsem_ptr(kn2);
+	token->count = 2;
+
+	kernfs_sort_rwsems(token);
+
+	if (token->count == 1) {
+		/* Both nodes hash to same rwsem */
+		down_write_nested(array[0], 0);
+	} else {
+		/* Both nodes hash to different rwsems */
+		down_write_nested(array[0], 0);
+		down_write_nested(array[1], 1);
+	}
+}
+
+/**
+ * kernfs_up_write_double_nodes - release hashed rwsem for 2 nodes
+ *
+ * @kn1: first kernfs_node of interest
+ * @kn2: second kernfs_node of interest
+ * @token: token to indicate unlocking information
+ *		->rwsems is a sorted list of rwsem addresses
+ *		->count contains number of unique locks
+ *
+ * Release hashed rwsems for 2 nodes
+ *
+ * Return: void
+ */
+void kernfs_up_write_double_nodes(struct kernfs_node *kn1,
+				  struct kernfs_node *kn2,
+				  struct kernfs_rwsem_token *token)
+{
+	struct rw_semaphore **array = &token->rwsems[0];
+
+	if (token->count == 1) {
+		/* Both nodes hash to same rwsem */
+		up_write(array[0]);
+	} else {
+		/* Both nodes hashe to different rwsems */
+		up_write(array[0]);
+		up_write(array[1]);
+	}
+}
+
+/**
+ * kernfs_down_read_double_nodes() - take hashed rwsem for 2 nodes
+ *
+ * @kn1: first kernfs_node of interest
+ * @kn2: second kernfs_node of interest
+ * @token: token to pass unlocking information to caller
+ *
+ * Acquire hashed rwsem for 2 nodes. Some operation may need to acquire
+ * hashed rwsems for 2 nodes (for example for a node and its parent).
+ * This function can be used in such cases.
+ *
+ * Return: void
+ */
+void kernfs_down_read_double_nodes(struct kernfs_node *kn1,
+				    struct kernfs_node *kn2,
+				    struct kernfs_rwsem_token *token)
+{
+	struct rw_semaphore **array = &token->rwsems[0];
+
+	array[0] = kernfs_rwsem_ptr(kn1);
+	array[1] = kernfs_rwsem_ptr(kn2);
+	token->count = 2;
+
+	kernfs_sort_rwsems(token);
+
+	if (token->count == 1) {
+		/* Both nodes hash to same rwsem */
+		down_read_nested(array[0], 0);
+	} else {
+		/* Both nodes hash to different rwsems */
+		down_read_nested(array[0], 0);
+		down_read_nested(array[1], 1);
+	}
+}
+
+/**
+ * kernfs_up_read_double_nodes - release hashed rwsem for 2 nodes
+ *
+ * @kn1: first kernfs_node of interest
+ * @kn2: second kernfs_node of interest
+ * @token: token to indicate unlocking information
+ *		->rwsems is a sorted list of rwsem addresses
+ *		->count contains number of unique locks
+ *
+ * Release hashed rwsems for 2 nodes
+ *
+ * Return: void
+ */
+void kernfs_up_read_double_nodes(struct kernfs_node *kn1,
+				  struct kernfs_node *kn2,
+				  struct kernfs_rwsem_token *token)
+{
+	struct rw_semaphore **array = &token->rwsems[0];
+
+	if (token->count == 1) {
+		/* Both nodes hash to same rwsem */
+		up_read(array[0]);
+	} else {
+		/* Both nodes hashe to different rwsems */
+		up_read(array[0]);
+		up_read(array[1]);
+	}
+}
+
+/**
+ * kernfs_down_write_triple_nodes() - take hashed rwsem for 3 nodes
+ *
+ * @kn1: first kernfs_node of interest
+ * @kn2: second kernfs_node of interest
+ * @kn3: third kernfs_node of interest
+ * @token: token to pass unlocking information to caller
+ *
+ * Acquire hashed rwsem for 3 nodes. Some operation may need to acquire
+ * hashed rwsems for 3 nodes (for example rename operation needs to
+ * acquire rwsem corresponding to node, its current parent and its future
+ * parent). This function can be used in such cases.
+ *
+ * Return: void
+ */
+void kernfs_down_write_triple_nodes(struct kernfs_node *kn1,
+				    struct kernfs_node *kn2,
+				    struct kernfs_node *kn3,
+				    struct kernfs_rwsem_token *token)
+{
+	struct rw_semaphore **array = &token->rwsems[0];
+
+	array[0] = kernfs_rwsem_ptr(kn1);
+	array[1] = kernfs_rwsem_ptr(kn2);
+	array[2] = kernfs_rwsem_ptr(kn3);
+	token->count = 3;
+
+	kernfs_sort_rwsems(token);
+
+	if (token->count == 1) {
+		/* All 3 nodes hash to same rwsem */
+		down_write_nested(array[0], 0);
+	} else if (token->count == 2) {
+		/**
+		 * Two nodes hash to same rwsem, and these
+		 * will occupy consecutive places in array after
+		 * sorting.
+		 */
+		down_write_nested(array[0], 0);
+		down_write_nested(array[2], 1);
+	} else {
+		/* All 3 nodes hashe to different rwsems */
+		down_write_nested(array[0], 0);
+		down_write_nested(array[1], 1);
+		down_write_nested(array[2], 2);
+	}
+}
+
+/**
+ * kernfs_up_write_triple_nodes - release hashed rwsem for 3 nodes
+ *
+ * @kn1: first kernfs_node of interest
+ * @kn2: second kernfs_node of interest
+ * @kn3: third kernfs_node of interest
+ * @token: token to indicate unlocking information
+ *		->rwsems is a sorted list of rwsem addresses
+ *		->count contains number of unique locks
+ *
+ * Release hashed rwsems for 3 nodes
+ *
+ * Return: void
+ */
+void kernfs_up_write_triple_nodes(struct kernfs_node *kn1,
+				  struct kernfs_node *kn2,
+				  struct kernfs_node *kn3,
+				  struct kernfs_rwsem_token *token)
+{
+	struct rw_semaphore **array = &token->rwsems[0];
+
+	if (token->count == 1) {
+		/* All 3 nodes hash to same rwsem */
+		up_write(array[0]);
+	} else if (token->count == 2) {
+		/**
+		 * Two nodes hash to same rwsem, and these
+		 * will occupy consecutive places in array after
+		 * sorting.
+		 */
+		up_write(array[0]);
+		up_write(array[2]);
+	} else {
+		/* All 3 nodes hashe to different rwsems */
+		up_write(array[0]);
+		up_write(array[1]);
+		up_write(array[2]);
+	}
+}
diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-internal.h
index 0babc3dc4f4a..8dc99875da32 100644
--- a/fs/kernfs/kernfs-internal.h
+++ b/fs/kernfs/kernfs-internal.h
@@ -19,6 +19,20 @@
 #include <linux/kernfs.h>
 #include <linux/fs_context.h>
 
+/**
+ * Token for nested locking interfaces.
+ *
+ * rwsems: array of rwsems to acquire
+ * count: has 2 uses
+ *	  As input argument it specifies size of ->rwsems array
+ *	  As return argument it specifies number of unique rwsems
+ *	  present in ->rwsems array
+ */
+struct kernfs_rwsem_token {
+	struct rw_semaphore *rwsems[3];
+	int count;
+};
+
 struct kernfs_iattrs {
 	kuid_t			ia_uid;
 	kgid_t			ia_gid;
@@ -46,8 +60,8 @@ struct kernfs_root {
 	struct list_head	supers;
 
 	wait_queue_head_t	deactivate_waitq;
-	struct rw_semaphore	kernfs_rwsem;
 	struct rw_semaphore     supers_rwsem;
+	struct mutex            kernfs_topo_mutex;
 };
 
 /* +1 to avoid triggering overflow warning when negating it */
@@ -169,12 +183,13 @@ extern const struct inode_operations kernfs_symlink_iops;
  * kernfs locks
  */
 extern struct kernfs_global_locks *kernfs_locks;
+extern rwlock_t kernfs_rename_lock;
 
 static inline struct rw_semaphore *kernfs_rwsem_ptr(struct kernfs_node *kn)
 {
-	struct kernfs_root *root = kernfs_root(kn);
+	int idx = hash_ptr(kn, NR_KERNFS_LOCK_BITS);
 
-	return &root->kernfs_rwsem;
+	return &kernfs_locks->kernfs_rwsem[idx];
 }
 
 static inline void kernfs_rwsem_assert_held(struct kernfs_node *kn)
@@ -247,4 +262,30 @@ static inline void kernfs_up_read(struct rw_semaphore *rwsem)
 {
 	up_read(rwsem);
 }
+
+void kernfs_down_write_double_nodes(struct kernfs_node *kn1,
+				    struct kernfs_node *kn2,
+				    struct kernfs_rwsem_token *token);
+
+void kernfs_up_write_double_nodes(struct kernfs_node *kn1,
+				  struct kernfs_node *kn2,
+				  struct kernfs_rwsem_token *token);
+
+void kernfs_down_read_double_nodes(struct kernfs_node *kn1,
+				    struct kernfs_node *kn2,
+				    struct kernfs_rwsem_token *token);
+
+void kernfs_up_read_double_nodes(struct kernfs_node *kn1,
+				  struct kernfs_node *kn2,
+				  struct kernfs_rwsem_token *token);
+
+void kernfs_down_write_triple_nodes(struct kernfs_node *kn1,
+				    struct kernfs_node *kn2,
+				    struct kernfs_node *kn3,
+				    struct kernfs_rwsem_token *token);
+
+void kernfs_up_write_triple_nodes(struct kernfs_node *kn1,
+				  struct kernfs_node *kn2,
+				  struct kernfs_node *kn3,
+				  struct kernfs_rwsem_token *token);
 #endif	/* __KERNFS_INTERNAL_H */
diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
index 3c5334b74f36..b9b8cc2c16fd 100644
--- a/fs/kernfs/mount.c
+++ b/fs/kernfs/mount.c
@@ -388,6 +388,14 @@ void kernfs_kill_sb(struct super_block *sb)
 	kfree(info);
 }
 
+static void __init kernfs_rwsem_init(void)
+{
+	int count;
+
+	for (count = 0; count < NR_KERNFS_LOCKS; count++)
+		init_rwsem(&kernfs_locks->kernfs_rwsem[count]);
+}
+
 static void __init kernfs_mutex_init(void)
 {
 	int count;
@@ -402,6 +410,7 @@ static void __init kernfs_lock_init(void)
 	WARN_ON(!kernfs_locks);
 
 	kernfs_mutex_init();
+	kernfs_rwsem_init();
 }
 
 void __init kernfs_init(void)
diff --git a/fs/kernfs/symlink.c b/fs/kernfs/symlink.c
index 9d4103602554..d71aa73acec8 100644
--- a/fs/kernfs/symlink.c
+++ b/fs/kernfs/symlink.c
@@ -113,12 +113,17 @@ static int kernfs_getlink(struct inode *inode, char *path)
 	struct kernfs_node *kn = inode->i_private;
 	struct kernfs_node *parent = kn->parent;
 	struct kernfs_node *target = kn->symlink.target_kn;
-	struct rw_semaphore *rwsem;
 	int error;
-
-	rwsem = kernfs_down_read(parent);
+	unsigned long flags;
+
+	/**
+	 * kernfs_get_target_path needs that all nodes in the path don't
+	 * undergo a parent change in the middle of it. Since ->parent
+	 * change happens under kernfs_rename_lock, acquire the same.
+	 */
+	read_lock_irqsave(&kernfs_rename_lock, flags);
 	error = kernfs_get_target_path(parent, target, path);
-	kernfs_up_read(rwsem);
+	read_unlock_irqrestore(&kernfs_rename_lock, flags);
 
 	return error;
 }
diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
index 367044d7708c..7d9de9aee102 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -89,6 +89,7 @@ struct kernfs_iattrs;
  */
 struct kernfs_global_locks {
 	struct mutex open_file_mutex[NR_KERNFS_LOCKS];
+	struct rw_semaphore kernfs_rwsem[NR_KERNFS_LOCKS];
 };
 
 enum kernfs_node_type {
-- 
2.30.2

