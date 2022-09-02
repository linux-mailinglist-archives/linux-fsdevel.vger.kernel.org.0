Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0675AAC91
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Sep 2022 12:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235752AbiIBKgp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Sep 2022 06:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235640AbiIBKgj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Sep 2022 06:36:39 -0400
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com [195.245.231.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC02BD2AE;
        Fri,  2 Sep 2022 03:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1662114996; i=@fujitsu.com;
        bh=5IDXemfHxETHCWqCLUiIKux1ffJ8/B2RvV4DalAoB1U=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=oXBgAJelAtuWWE+9v0Dulxr9fwsWZ+RComPS5JUXjWDfM65xoQlEbfiyisDR8VpnY
         37sTl4NhadrCRdjPzdjfkJ1yKLBXcpDmn7gLdjsoKsPAcoE2PxjQQ3Cae8DK8sXZEA
         7YxcFTHtWqIlTRX3J1+bvwkurUgsdvXddPkw0PpXVUfttpAIw3NS9MQEzOZ+ROZBmc
         Im9vB3WzfXP5MFBJHou/xKVMygn2cPSsCBq12FYdOrZjPthewikg+A+AqkpQZ5bpjQ
         M+hWHAvMK8EIT40I94/1H7GVw+XDJm151+UUTypfrmOPGLm44bMhu2q+6PibGmqHT5
         B+smEyLg4gqGQ==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEKsWRWlGSWpSXmKPExsViZ8ORqLvyjmC
  ywcWJehbTp15gtNhy7B6jxeUnfBanJyxistj9+iabxZ69J1ksLu+aw2Zxb81/Votdf3awW6z8
  8YfVgcvj1CIJj80rtDwW73nJ5LFpVSebx6ZPk9g9Xmyeyejx8ektFo/Pm+QCOKJYM/OS8isSW
  DNOrLAquMBRcW5fTAPjD7YuRi4OIYEtjBJ/urtYIJzlTBJLL5xlgnD2MEp8fd3A2MXIycEmoC
  NxYcFfVpCEiMAkRoljN24ygySYBcol9m+8wQZiCwt4SrT232UFsVkEVCQWPDvKAmLzCrhI3Pn
  4HywuIaAgMeXhe7BeTgF7iUXnfzOB2EICdhLfj81jgqgXlDg58wkLxHwJiYMvXgDVcwD1KknM
  7I6HGFMh0Tj9EBOErSZx9dwm5gmMgrOQdM9C0r2AkWkVo3VSUWZ6RkluYmaOrqGBga6hoamus
  ZGuoYWlXmKVbqJeaqlueWpxia6RXmJ5sV5qcbFecWVuck6KXl5qySZGYHSlFCvs3cF4eeVPvU
  OMkhxMSqK8ibcEk4X4kvJTKjMSizPii0pzUosPMcpwcChJ8PKD5ASLUtNTK9Iyc4CRDpOW4OB
  REuENA0nzFhck5hZnpkOkTjHqcqxtOLCXWYglLz8vVUqc9wVIkQBIUUZpHtwIWNK5xCgrJczL
  yMDAIMRTkFqUm1mCKv+KUZyDUUmY9xnIFJ7MvBK4Ta+AjmACOmL6TH6QI0oSEVJSDUxhmXF88
  6IMt6208/x64fYyT+mtJ0TmH4po9fy2aLIyr3bZ9ptn5+/pjqh+mNb1kLXK3uxVq3nC/meXON
  gOzjKa0BShu33F353cL7lLXYNPtqp9mDzxwflLUxbnVibXpt3VyA7m89zh93tp967f7iu/L/t
  bpaN51mfxhyObdRzdFx83bOx/X243QeSlyouLbEG7Ly6Y1Se8xCGlylfAjrP4Mfs8r+xTHztZ
  7nVeb7qQqP6n333DnF8W+yNXKXkujVkV+GChjLby37shwb/azuutunfdv4+9/AK/ocyXMNc9M
  jP7nmfMctAXtVF9od2xn6eFict05sw5j7Oy++eqantu/PJA3u/4e7/rxefPuUsqsRRnJBpqMR
  cVJwIAr4PfWrUDAAA=
X-Env-Sender: ruansy.fnst@fujitsu.com
X-Msg-Ref: server-20.tower-548.messagelabs.com!1662114985!2086!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.87.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 22685 invoked from network); 2 Sep 2022 10:36:25 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
  by server-20.tower-548.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 2 Sep 2022 10:36:25 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id 5D1FC1001A1;
        Fri,  2 Sep 2022 11:36:25 +0100 (BST)
Received: from R01UKEXCASM121.r01.fujitsu.local (R01UKEXCASM121 [10.183.43.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id 4DFA21001A0;
        Fri,  2 Sep 2022 11:36:25 +0100 (BST)
Received: from localhost.localdomain (10.167.225.141) by
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Fri, 2 Sep 2022 11:36:21 +0100
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>
CC:     <djwong@kernel.org>, <dan.j.williams@intel.com>,
        <david@fromorbit.com>, <hch@infradead.org>, <jane.chu@oracle.com>
Subject: [PATCH v8 0/3] mm, pmem, xfs: Introduce MF_MEM_REMOVE for unbind
Date:   Fri, 2 Sep 2022 10:35:58 +0000
Message-ID: <1662114961-66-1-git-send-email-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <9e9521a4-6e07-e226-2814-b78a2451656b@fujitsu.com>
References: <9e9521a4-6e07-e226-2814-b78a2451656b@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.225.141]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173)
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Changes since v7:
  1. Add P1 to fix calculation mistake
  2. Add P2 to move drop_pagecache_sb() to super.c for xfs to use
  3. P3: Add invalidate all mappings after sync.
  4. P3: Set offset&len to be start&length of device when it is to be removed.
  5. Rebase on 6.0-rc3 + Darrick's patch[1] + Dan's patch[2].

Changes since v6:
  1. Rebase on 6.0-rc2 and Darrick's patch[1].

[1]: https://lore.kernel.org/linux-xfs/Yv5wIa2crHioYeRr@magnolia/
[2]: https://lore.kernel.org/linux-xfs/166153426798.2758201.15108211981034512993.stgit@dwillia2-xfh.jf.intel.com/

Shiyang Ruan (3):
  xfs: fix the calculation of length and end
  fs: move drop_pagecache_sb() for others to use
  mm, pmem, xfs: Introduce MF_MEM_REMOVE for unbind

 drivers/dax/super.c         |  3 ++-
 fs/drop_caches.c            | 33 ---------------------------------
 fs/super.c                  | 34 ++++++++++++++++++++++++++++++++++
 fs/xfs/xfs_notify_failure.c | 31 +++++++++++++++++++++++++++----
 include/linux/fs.h          |  1 +
 include/linux/mm.h          |  1 +
 6 files changed, 65 insertions(+), 38 deletions(-)

-- 
2.37.2

