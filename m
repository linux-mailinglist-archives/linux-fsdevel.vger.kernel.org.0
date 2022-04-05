Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36A944F4D39
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Apr 2022 03:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1581754AbiDEXks (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Apr 2022 19:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573709AbiDETur (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Apr 2022 15:50:47 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A231AF29;
        Tue,  5 Apr 2022 12:48:46 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 235JJVfN006418;
        Tue, 5 Apr 2022 19:48:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=lbeq6mCg7xbF271eHyMh7v4yRNaJ0Z53JedlegHL2O4=;
 b=ylMo7lKG4U5ejJnNet6/FWaAzT44zbRqaqhYYOt99NiwG8S2EhdQEcHNTSCai8P+TtYi
 NohKaltfsyV4HLXxi7l8FeMbhoTksDy4blm/s+Lm810apOxyjR2amhjf5Fb6MqpMmx0U
 L5zU64R1PsVV0LfeKuMRoHyZoBAZDjGl96PG2R9sgEhPm+SMJPudop0Lcf783U608zfB
 PknaMNmXgxgnPFuqalWXVaectQE1+JM82H9i0AFKfels4yTrVWxhvjmdhUWcONXsWFGT
 FQKHLZ4Ry1Qrd9Xo50cbbM5C+az5aaGcuDyzMqwaDqAbFsps0G8okuh1mEvZG4jyeivw QQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6d31f34k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Apr 2022 19:48:13 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 235JapIr029836;
        Tue, 5 Apr 2022 19:48:12 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f6cx3vpud-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Apr 2022 19:48:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EPmY5NDWcSDP4/xvaw2AbfkKu9Xvq5ivCKhadHtMgvmhX18g/vnzdFuyZgI/mXEP9qc5ULoMpjlydbY2TgC44E0Mn/05whVLvNz34YpWAE07q0j1rQGWrMea6SpB8TNVzUD+dNAHzggDvWUVQ9Filv51C3nomTCUojc7mjn8UAbjGggfUy68b2h1IS9Q/IiXearg5gKsa8fwRlyC3oP37JCbwchwjgBH0GRY10pOyB4XKbcEUKlm0h2CxjrOBIg74Kyq+yzxlhOXJGstPu7PxCCodtT3PcCWcSpFosYmlIVux3h/kunFvr5r8p9DCL+nejnT8Rrj1HWdZEZeAGYZ/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lbeq6mCg7xbF271eHyMh7v4yRNaJ0Z53JedlegHL2O4=;
 b=FkHbnuqtya3u5L7VaJW6Pi6bL2G3/uHNmpx92HVll07Ef0XoEHL+95Q91fuyYLe3dypAWGWDxyVUIlzSuFteCmT6hLODU+MSH0/6wDPcjxMXR0LugBOQBNCo7EXaTGSJ4Wy3jcW+ni+tkdDy01qiVJ+NstPXgWFo/hUeuacbGJlQiDCuQNWXrCwWmCBFfxynLzaAed9lBe7/mWBEbG7knz5Ds4HPuS4WwEYxo6NaD7Bj7gqi5CJu0u67KJL1LFnLwV/MAv+Dq91iV2aSO8Cqw62+SqGfU2v9WnWPy4jH9oyF8jvQ9N3NbqWIG0euswDOHC6Skz1MB/mXCIOdwtBbKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lbeq6mCg7xbF271eHyMh7v4yRNaJ0Z53JedlegHL2O4=;
 b=gQ4z5h3DeJi175eQuty3uBZbLzwxWOwB9MqUNKYVo7N2S9H9F6B3TiGhpZe6nQSLdUVs3dMuFP0KfVc60hClwR+AMhKXCRHSCKIv0jR52SE0BRC7LgV4JkdDnKanQMLmakwoH14qn7+PhQ8grJuIGXiyCnifnDYpk+NdOtC9Z3s=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by CO6PR10MB5475.namprd10.prod.outlook.com (2603:10b6:303:13e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Tue, 5 Apr
 2022 19:48:10 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::1c44:15ca:b5c2:603e]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::1c44:15ca:b5c2:603e%7]) with mapi id 15.20.5123.030; Tue, 5 Apr 2022
 19:48:09 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     david@fromorbit.com, djwong@kernel.org, dan.j.williams@intel.com,
        hch@infradead.org, vishal.l.verma@intel.com, dave.jiang@intel.com,
        agk@redhat.com, snitzer@redhat.com, dm-devel@redhat.com,
        ira.weiny@intel.com, willy@infradead.org, vgoyal@redhat.com,
        linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        x86@kernel.org
Subject: [PATCH v7 0/6] DAX poison recovery
Date:   Tue,  5 Apr 2022 13:47:41 -0600
Message-Id: <20220405194747.2386619-1-jane.chu@oracle.com>
X-Mailer: git-send-email 2.18.4
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0054.namprd13.prod.outlook.com
 (2603:10b6:806:22::29) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3f68b033-1382-4494-ce8f-08da173d3646
X-MS-TrafficTypeDiagnostic: CO6PR10MB5475:EE_
X-Microsoft-Antispam-PRVS: <CO6PR10MB54752AEE3D1F93ADA142BFE3F3E49@CO6PR10MB5475.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5CQxApyeGkPA5GfNKjerl7dFkKIOW6z6NS9nq5dlPFy389+isTublyh/X1TXueOs1p4zNkMOpmLQy0IhXOfig0WLdMZ/3fq4mCMfdEui/et8xekDHBViJKrjGp1j9Jgv85d95fpPqY/m6i76gVATT3wJ+P8kJbXeR2vmXlNzNzsYTsxrwCk83cFq4F8Sj8UAsCWR2qUY2ey9dH+L6O5CsaI8bndiZjT1xm0kjpDPacuq7TxNZe7wHKOFY8GLEzw+W+8RhpftnttECNFXvDmxqOe4hq3qto/RNlH0etbldKalY01rVJn5B6wUuB/TpTSA9KR6fkCUI3cTI3bTRAA9jn63yrIXF3Ye0nA8IGvUsCYnXg8E1dYMjsXMjPyr59WdJc4/UdSx0wguGC63sMEWW4HwgsbPoi55PFUkGw/Hs7ftEspiRTt2pTUM7haT1Lih+XbQJWFV8YKkGBpX9OFNHr39RA4kN+L1oDgF68iOdUOsdutyvdVQ6e1JHbD466AdOZHc46+JGzaMRsw+1WN2Le2Pywxo+wU7Tpm1cgceDTPiXksqpV60vlXPp7oUBxhxe9v6kinHNtUBCys0+oa2Uctxq8sGAMWf9pT9/KfzKZuM+y0FxnX9MLkhnZlfeSrawut/HOAvUatxdsf8bhqAHBFwaSW1tm1qaC5+ODYR2Ecl+gzZ7p7nTZ/k5DkFgEVt8a/Gc1+AHAF9XKdGjUec+ekHUSMBeacCf4o1otvvW93UCH1oVPBN1Xg3HI1MvkuS/Y5viqbrWQyh1iPQzL/CMZhGylELVxTl6EpHJD5xhQ6deEHrlItQ5q8ISIXFAoIY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(1076003)(186003)(2616005)(5660300002)(966005)(2906002)(316002)(6512007)(921005)(6486002)(8676002)(36756003)(6666004)(52116002)(6506007)(7416002)(508600001)(66946007)(8936002)(44832011)(83380400001)(66476007)(86362001)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PCmukRxu47iVWcGbBqd6e1XpF4QapXqzlDwwDzG/+FVqln3b4zvprl+OuJjO?=
 =?us-ascii?Q?eg/L8OtmuVDVdNgYtrrELOJ7ZQxkH4MAh9OYqU2/sbSpGn2/nlmatIZrxFjK?=
 =?us-ascii?Q?Z9tiaXysoBo0e41MiC9JxO0f9BJYIcCIeDi/rjcsZOBYIwq07NxL/tM7+QOS?=
 =?us-ascii?Q?Bn87EaEVNIJeh7z5TrpxTMz8tcCMV7GWKZsBOEBhKuLhsd35IyyIDF6Oh0WU?=
 =?us-ascii?Q?MPzb+leUzukSpSixgo6aNuMj/uyqnvdlVMVd6L70KBZcfJzLH3JoUpWDCnGN?=
 =?us-ascii?Q?LXCMOYn7YgUiItLcD6CHh2VkVRqA0GRs9p3NFAfaU3Osk50HCCCKVccD7/4K?=
 =?us-ascii?Q?Ku0pM0ODl5nIN04YysEcuAF+Th5+G3bpFQ0FT++PYyN9PqzCf2an2vYfssKL?=
 =?us-ascii?Q?yH0NPh53KSJ5MJmmfTlbwT2eVN5XJcCb8tzWBFiFyn842fqtN3vCp26hBLnn?=
 =?us-ascii?Q?ziA6a3u6+q47Jhol5CssHbffaCkuE2X3t2z0Kz0R6Auf6ez4smiKpE/cZcjM?=
 =?us-ascii?Q?YbRarT39AlbYWgQvWzIISyBpaT8Z3dfSzPAIM4i3AT+22wEuSntVUo7xiHXB?=
 =?us-ascii?Q?8h7llIMHgnD4ajO1LD5S1G604K0DaHjnkdf4oLO79WFFULjqx1o0aO5BHbW+?=
 =?us-ascii?Q?xXh9XMYZxQ4WYCCZhYShEVcDZkncbrqpB9GbxZz04yAX2IjKJpckcHypfTPQ?=
 =?us-ascii?Q?VIVeEHs4QB0IT99TiEE01pilqI2Ydd0Bh4V77MYR3dDvo4dax9GIFk5zoCHF?=
 =?us-ascii?Q?zoV3fRD92S+4MrX6wRd39eCKjVKyNxz3DHawXw3Ew8WapLZ8lca4mTqoH897?=
 =?us-ascii?Q?AM1Cb7h6nmdFGNqQkLE1XFlje32PdBfpsxD2aURoHAy8PUyZigFPMzXVEPji?=
 =?us-ascii?Q?ygvrRKL3V7mkOEmu9aucAftego6LBVBQCuKSmoBHcqgIlXWD1rIIIpGjTwE7?=
 =?us-ascii?Q?Jc5DozUpC/ZF6SleShX50HcM857sPxFsZbtG6JIbHo6bSgjUYppkzVvMlJ5i?=
 =?us-ascii?Q?9yPAFt/vjQ+hYKSra0SJy23X1/6GClN8shlLxpeG7n/v9Mw60Z7XWTwYKvg8?=
 =?us-ascii?Q?PN9CKWrKxjH0pYLS6/mYJRJ8qZzxs6adsDVVuaDSD0duq1UccIQD0kpr2Ibu?=
 =?us-ascii?Q?NeXudZCHu5EuI26AB9M4dPBijY5TnXZUfbtQ5uWGeJGGqC05juOgVBVRFg8l?=
 =?us-ascii?Q?oMyf7+a2UvSXNqRbOLL4g7hPLi1srTtJl427f/JAJ5Q6CwV/Xrks/hPLiJmx?=
 =?us-ascii?Q?6QztdgCgDn0gvnktOzOz4Jf2meDbYFi2GGzZJYmPUBAyhHn3XD0xh/U9NTfw?=
 =?us-ascii?Q?ZXPj8Sj51csHWOeY3YkqAi9bfR/Ds5lgp0w1JD1uLf5o73KgXl7vEyHbmHhO?=
 =?us-ascii?Q?mjXUac/0vkttB67y+cvt581x8BLpElvlMfnASNcto8JSylPJMuFNA1W+DRfU?=
 =?us-ascii?Q?AjqC8AKOWlY0mBP9uIKWJ8+JZmwofN5xTIonpp3ypa88LsyM+O9z9u0N6a3q?=
 =?us-ascii?Q?lTN/fmc4qOXNHrDLZ5XlJ8pHd/tFKAleRvNNgpbMFm6xMl8W0rgg/wS3yqIM?=
 =?us-ascii?Q?qe3s/KFmlQoDzAd7QdmEAAx7nfatQW+SZIJQM5SfQ/WhywlOj+GwStacsFYL?=
 =?us-ascii?Q?i+FZTTKFUFBO4iLuJ+nDYzXNMYmIpGSvmcAKomjgKze7CZRC3+tZHB09op6E?=
 =?us-ascii?Q?1/OxV5MPcRy0V/UX7OZagVeyT0F0EEOfSo2AhzPPTThx+rAAfy1sNJkjKGFO?=
 =?us-ascii?Q?kg/5LfgYMT10q32uHoBECN/Ti7O6iEI=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f68b033-1382-4494-ce8f-08da173d3646
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2022 19:48:09.9445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3QqPLAxT5BSCUMOxVnzIzbG7qLGzsEE4wCsCt8tNK/N5LkygugM4dlgDt5pIcSivCX5Ym/TpGAY2RtBw8NyY/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5475
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-05_06:2022-04-04,2022-04-05 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204050110
X-Proofpoint-GUID: hHg6cJzhgk-qeylf-mdBDyUZMKlvPFiT
X-Proofpoint-ORIG-GUID: hHg6cJzhgk-qeylf-mdBDyUZMKlvPFiT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In this series, dax recovery code path is independent of that of
normal write. Competing dax recovery threads are serialized,
racing read threads are guaranteed not overlapping with the
recovery process.

In this phase, the recovery granularity is page, future patch
will explore recovery in finer granularity.

Changelog:
v6 -> v7:
 . incorporated comments from Christoph, and picked up a reviewed-by
 . add x86@kernel.org per Boris
 . discovered pmem firmware doesn't reliably handle a request to clear
   poison over a large range (such as 2M), hence worked around the
   the feature by limiting the size of the requested range to kernel
   page size. 

v5->v6:
  . per Christoph, move set{clear}_mce_nospec() inline functions out
    of include/linux/set_memory.h and into arch/x86/mm/pat/set_memory.c
    file, so that no need to export _set_memory_present().
  . per Christoph, ratelimit warning message in pmem_do_write()
  . per both Christoph and Dan, switch back to adding a flag to
    dax_direct_access() instead of embedding the flag in kvaddr
  . suggestions from Christoph for improving code structure and
    readability
  . per Dan, add .recovery_write to dev_pagemap.ops instead of adding
    it to dax_operations, such that, the DM layer doesn't need to be
    involved explicitly in dax recoovery write
  . per Dan, is_bad_pmem() takes a seqlock, so no need to place it
    under recovery_lock.
  Many thanks for both reviewers!

v4->v5:
  Fixed build errors reported by kernel test robot

v3->v4:
  Rebased to v5.17-rc1-81-g0280e3c58f92

References:
v4 https://lore.kernel.org/lkml/20220126211116.860012-1-jane.chu@oracle.com/T/
v3 https://lkml.org/lkml/2022/1/11/900
v2 https://lore.kernel.org/all/20211106011638.2613039-1-jane.chu@oracle.com/
Disussions about marking poisoned page as 'np'
https://lore.kernel.org/all/CAPcyv4hrXPb1tASBZUg-GgdVs0OOFKXMXLiHmktg_kFi7YBMyQ@mail.gmail.com/

Jane Chu (6):
  x86/mm: fix comment
  x86/mce: relocate set{clear}_mce_nospec() functions
  mce: fix set_mce_nospec to always unmap the whole page
  dax: add DAX_RECOVERY flag and .recovery_write dev_pgmap_ops
  pmem: refactor pmem_clear_poison()
  pmem: implement pmem_recovery_write()

 arch/x86/include/asm/set_memory.h |  52 -------
 arch/x86/kernel/cpu/mce/core.c    |   6 +-
 arch/x86/mm/pat/set_memory.c      |  43 +++++-
 drivers/dax/super.c               |  17 ++-
 drivers/md/dm-linear.c            |   4 +-
 drivers/md/dm-log-writes.c        |   5 +-
 drivers/md/dm-stripe.c            |   4 +-
 drivers/md/dm-target.c            |   2 +-
 drivers/md/dm-writecache.c        |   5 +-
 drivers/md/dm.c                   |   5 +-
 drivers/nvdimm/pmem.c             | 224 ++++++++++++++++++++++--------
 drivers/nvdimm/pmem.h             |   3 +-
 drivers/s390/block/dcssblk.c      |   4 +-
 fs/dax.c                          |  24 +++-
 fs/fuse/dax.c                     |   4 +-
 include/linux/dax.h               |  11 +-
 include/linux/device-mapper.h     |   2 +-
 include/linux/memremap.h          |   7 +
 include/linux/set_memory.h        |  11 +-
 tools/testing/nvdimm/pmem-dax.c   |   2 +-
 20 files changed, 285 insertions(+), 150 deletions(-)


base-commit: ae085d7f9365de7da27ab5c0d16b12d51ea7fca9
-- 
2.18.4

