Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A18486C2774
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Mar 2023 02:27:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbjCUB05 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Mar 2023 21:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjCUB0y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Mar 2023 21:26:54 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on20613.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eb2::613])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD402136C1
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Mar 2023 18:26:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jBI8Kfe6vGtLjBU4oWTWJiR3orpv6R6Wu8QRgXGKVq7dbfwlcLZKSpoGjRoYMtERMl5Zk6PCnSSr5j0fpCdwqgbYnHivs/U+LSDCoa5uBzQCwIa3hRI8kq40g89g178F6AAGBdt2rQ/B0CJIyCNcjyP5q4x/maTmMsBrlH2K75km9/SVSlvKFWw3+v+Dc1hiO6Xd3lS5BFJm31H6SSdy4Htr8rVViJkw9JHl1RfUxBCTp+DqGaV/3HpqBYh0yTYQoBx2ajBNEqs975l9Z6YxCi8XYpTwzCxDDU4gM13BI3G33MzuQqAg597FZpxcnvF7DT908bYZX07fBfe2ZithTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dfFfMuoJn7WHqfurid2KspBTEayuro8/Jsx9d5cTMtQ=;
 b=JLYSQljabjgGCneXVNQZtNk7f8ntdO3dq4H1A3Hq6CpcJZDxiH7xjvdhJIC0qJwq/N9u2Ib3K/aEuLVGYGOoac7Jb9LWAtoekI8AG8wi8v0UNYCppCYaHgiphfh/+REZQ45q7W2qKq6cJNTeXKJARIPl/G8TaqjLv+3lBBGMrJqoK4NapP94P3AWCwif9O42gC9XKCu0uaW9uCQmsyUc4tbDPV1YkH5m4MYmY7iCCytZ5yC7j2YLP5lwOHSJA7vasJTCnoOyKa63TI5qEDuwt7hBOzgX6K0OajpnkBNC6/24cStsd0B/D6PItY3+QAiJDayPJS2y+Zpw7lMm6RXjiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dfFfMuoJn7WHqfurid2KspBTEayuro8/Jsx9d5cTMtQ=;
 b=lPu+u7jmbB8Kqvovx9Gj0/y9XNwIPYzJNZuZy2mWvLciYluyaZaUzVgO0a4kzFM7CzWOC69obH9SUD2q+N9LbB4L4fvl38TfavOZa4Dv2lJyr7ByYJBwrURufW4GaV7CTIy8e147g8q8TH5kX1ZkzV5l+n6N0V4a4FKutC1QOt4=
Received: from MW4PR03CA0283.namprd03.prod.outlook.com (2603:10b6:303:b5::18)
 by DS0PR19MB7444.namprd19.prod.outlook.com (2603:10b6:8:148::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 01:11:15 +0000
Received: from MW2NAM04FT039.eop-NAM04.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::a6) by MW4PR03CA0283.outlook.office365.com
 (2603:10b6:303:b5::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Tue, 21 Mar 2023 01:11:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mx01.datadirectnet.com; pr=C
Received: from uww-mx01.datadirectnet.com (50.222.100.11) by
 MW2NAM04FT039.mail.protection.outlook.com (10.13.30.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.16 via Frontend Transport; Tue, 21 Mar 2023 01:11:15 +0000
Received: from localhost (unknown [10.68.0.8])
        by uww-mx01.datadirectnet.com (Postfix) with ESMTP id A6C7120C6862;
        Mon, 20 Mar 2023 19:12:22 -0600 (MDT)
From:   Bernd Schubert <bschubert@ddn.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Dharmendra Singh <dsingh@ddn.com>,
        Bernd Schubert <bschubert@ddn.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Amir Goldstein <amir73il@gmail.com>,
        fuse-devel@lists.sourceforge.net
Subject: [RFC PATCH 00/13] fuse uring communication
Date:   Tue, 21 Mar 2023 02:10:34 +0100
Message-Id: <20230321011047.3425786-1-bschubert@ddn.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2NAM04FT039:EE_|DS0PR19MB7444:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 8a9ad5d4-7db1-40d2-8a19-08db29a92b1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5VnYe5r+4d1Ar5YTrtYxHnUVBz1k9Np4uuMLnwR5HIJ1BYY8DX2jmnJghKUdFcnz9polS3ERLy05jhwuvthFXPTdzw/56+7zGnKAqlnBftzalcvG3eV8S1ZBnebU1hXUiq3sHlRdKOw/BRsbe0G5FmJ8WpnIlqkuiOB8145Ay70RSWZww79yjtp/OlvBRjW80GMKrQNeBSflBvHoXML59fiStVI2rAya7LsWoryA4Jx9pWmgyk+NsWxO0tObCqjbNIKAjZDMXalem2WHGUKwBlXjUL7j1Q8BSzkFGv5wt7md5iXD+BqXkNY2GARKixM4saKWXQb2rZPafkbq9wsatltPlCAFsoss+9oKMMryuNFqehtwNTKkdIYZmAzUBkTXK2bzoA5Ck9SxjGGpO2Bo5gA7LcDYjDFZrsaJxPLUBzOuTS+MvBRLSY2Wqaoe2fNyw6QdFF3nZNVGn1IyOGFZYu2RxC0obxi+u9AsMV/5t50rXm1w9gBATDoXJAHgWmTZAqUXxa01+nxkZlyLMf7e9yTaqbtFBiezW889RqbmPBjAz6WPXH8aCdBwMFkFQuV/WWkffwYKXg1SgVFFGSdE0ayi4zP4JeukSQ/mA3xJgGJOnGEb/q2TBSXB1YtT14pDyf+PWDETSJjtcI1yewZEVKqbYVwBIZ9a+hWS8J3e28u+aY/NJxcFfMipLK3/L/JatVl5vRDVf9sEJZ7xcpzIMqky8XDnqpC+TWcqMFwCEUNat6p5qutyDTRrq6rIvgQi
X-Forefront-Antispam-Report: CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mx01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(39850400004)(396003)(376002)(451199018)(36840700001)(46966006)(54906003)(8676002)(4326008)(966005)(70586007)(6916009)(316002)(6666004)(70206006)(478600001)(41300700001)(26005)(1076003)(8936002)(6266002)(186003)(5660300002)(2616005)(2906002)(47076005)(336012)(83380400001)(36756003)(356005)(82740400003)(36860700001)(40480700001)(81166007)(82310400005)(86362001)(21314003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 01:11:15.1687
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a9ad5d4-7db1-40d2-8a19-08db29a92b1d
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mx01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM04FT039.eop-NAM04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR19MB7444
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This adds support for uring communication between kernel and
userspace daemon using opcode the IORING_OP_URING_CMD. The basic
appraoch was taken from ublk.  The patches are in RFC state -
I'm not sure about all decisions and some questions are marked
with XXX.

Userspace side has to send IOCTL(s) to configure ring queue(s)
and it has the choice to configure exactly one ring or one
ring per core. If there are use case we can also consider
to allow a different number of rings - the ioctl configuration
option is rather generic (number of queues).

Right now a queue lock is taken for any ring entry state change,
mostly to correctly handle unmount/daemon-stop. In fact,
correctly stopping the ring took most of the development
time - always new corner cases came up.
I had run dozens of xfstest cycles, 
versions I had once seen a warning about the ring start_stop
mutex being the wrong state - probably another stop issue,
but I have not been able to track it down yet. 
Regarding the queue lock - I still need to do profiling, but
my assumption is that it should not matter for the 
one-ring-per-core configuration. For the single ring config
option lock contention might come up, but I see this
configuration mostly for development only.
Adding more complexity and protecting ring entries with
their own locks can be done later.

Current code also keep the fuse request allocation, initially
I only had that for background requests when the ring queue
didn't have free entries anymore. The allocation is done
to reduce initial complexity, especially also for ring stop.
The allocation free mode can be added back later.

Right now always the ring queue of the submitting core
is used, especially for page cached background requests
we might consider later to also enqueue on other core queues
(when these are not busy, of course).

Splice/zero-copy is not supported yet, all requests go
through the shared memory queue entry buffer. I also
following splice and ublk/zc copy discussions, I will
look into these options in the next days/weeks.
To have that buffer allocated on the right numa node,
a vmalloc is done per ring queue and on the numa node
userspace daemon side asks for.
My assumption is that the mmap offset parameter will be
part of a debate and I'm curious what other think about
that appraoch. 

Benchmarking and tuning is on my agenda for the next
days. For now I only have xfstest results - most longer
running tests were running at about 2x, but somehow when
I cleaned up the patches for submission I lost that.
My development VM/kernel has all sanitizers enabled -
hard to profile what happened. Performance
results with profiling will be submitted in a few days.

The patches include a design document, which has a few more
details.

The corresponding libfuse patches are on my uring branch,
but need cleanup for submission - will happen during the next
days.
https://github.com/bsbernd/libfuse/tree/uring

If it should make review easier, patches posted here are on
this branch
https://github.com/bsbernd/linux/tree/fuse-uring-for-6.2


Bernd Schubert (13):
  fuse: Add uring data structures and documentation
  fuse: rename to fuse_dev_end_requests and make non-static
  fuse: Move fuse_get_dev to header file
  Add a vmalloc_node_user function
  fuse: Add a uring config ioctl and ring destruction
  fuse: Add an interval ring stop worker/monitor
  fuse: Add uring mmap method
  fuse: Move request bits
  fuse: Add wait stop ioctl support to the ring
  fuse: Handle SQEs - register commands
  fuse: Add support to copy from/to the ring buffer
  fuse: Add uring sqe commit and fetch support
  fuse: Allow to queue to the ring

 Documentation/filesystems/fuse-uring.rst |  179 +++
 fs/fuse/Makefile                         |    2 +-
 fs/fuse/dev.c                            |  193 +++-
 fs/fuse/dev_uring.c                      | 1292 ++++++++++++++++++++++
 fs/fuse/dev_uring_i.h                    |   23 +
 fs/fuse/fuse_dev_i.h                     |   62 ++
 fs/fuse/fuse_i.h                         |  178 +++
 fs/fuse/inode.c                          |   10 +
 include/linux/vmalloc.h                  |    1 +
 include/uapi/linux/fuse.h                |  131 +++
 mm/nommu.c                               |    6 +
 mm/vmalloc.c                             |   41 +-
 12 files changed, 2064 insertions(+), 54 deletions(-)
 create mode 100644 Documentation/filesystems/fuse-uring.rst
 create mode 100644 fs/fuse/dev_uring.c
 create mode 100644 fs/fuse/dev_uring_i.h
 create mode 100644 fs/fuse/fuse_dev_i.h

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
cc: Miklos Szeredi <miklos@szeredi.hu>
cc: linux-fsdevel@vger.kernel.org
cc: Amir Goldstein <amir73il@gmail.com>
cc: fuse-devel@lists.sourceforge.net

-- 
2.37.2

