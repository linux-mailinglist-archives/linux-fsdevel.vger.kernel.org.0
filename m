Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE755E9366
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Sep 2022 15:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbiIYNdw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 25 Sep 2022 09:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbiIYNdt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 25 Sep 2022 09:33:49 -0400
Received: from mail3.bemta32.messagelabs.com (mail3.bemta32.messagelabs.com [195.245.230.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF53819C24;
        Sun, 25 Sep 2022 06:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1664112820; i=@fujitsu.com;
        bh=c7NQe7G34LBYxg4hwkKE43l4MRiwdYV+swWpJc9rsu0=;
        h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=kOCp5+qIKuMCfaB1F3maSLnvw4Vbeqhwryw4DXluA+lsqVKmH08dPkmTnbLGu0FkD
         svMMtrP63Ec2M+svX1XdE7aRcdCxKgo2zpKMU3CebWpvVyIfg6E8IwmhwmupX6WbHC
         jAwHYADJ63TZ0SPndfBoZBzflam+oJ/OUNHIJTRjIPU+7BPVHhZnCkR6MV0qnr+cLU
         RFq6MpfzUoK2hXrR1qdYN9Qcqb4NEFHsV/7caCwZUMkvDk3dtoKMQ8QCLzdObhELOY
         8QRt/nsNpIY/m9T4H+orlJ1aMHkNhISSWFx0ggc1PTzPjqpgZalrzFMtfVag6t8R8m
         4yLI2d2C5B7nQ==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPIsWRWlGSWpSXmKPExsViZ8MxSXdThEG
  yQd8XI4vpUy8wWmw5do/R4vITPovTExYxWezZe5LF4vKuOWwW99b8Z7XY9WcHu8XKH39YHTg9
  Ti2S8Ni8Qstj8Z6XTB6bVnWyeWz6NInd48XmmYwenzfJBbBHsWbmJeVXJLBmLN/ynKXgB0fFn
  JP/2RsYZ7F3MXJxCAlsYZRoOPWFuYuRE8hZziQxbVM+RGIvo8TFDfsYQRJsAjoSFxb8ZQVJiA
  hMYpQ4duMmWAezQIJE+5drTCC2sICnxMfOBrAGFgFViSNXd7CC2LwCLhJ7V/0Cq5EQUJCY8vA
  9M0RcUOLkzCcsEHMkJA6+eAEU5wCqUZKY2R0PUV4h0Tj9EFSrmsTVc5uYJzDyz0LSPQtJ9wJG
  plWMlklFmekZJbmJmTm6hgYGuoaGprqGuqaWeolVuol6qaW65anFJbqGeonlxXqpxcV6xZW5y
  TkpenmpJZsYgXGRUsxovYOxo++n3iFGSQ4mJVHeo34GyUJ8SfkplRmJxRnxRaU5qcWHGGU4OJ
  QkeA+4AeUEi1LTUyvSMnOAMQqTluDgURLhLQRp5S0uSMwtzkyHSJ1i1OVY23BgL7MQS15+Xqq
  UOO/KcKAiAZCijNI8uBGwdHGJUVZKmJeRgYFBiKcgtSg3swRV/hWjOAejkjCvWzDQFJ7MvBK4
  Ta+AjmACOsKOTx/kiJJEhJRUA9Mck1BRWx0tR+dL3zRWHPaY2sKxrOK/+ZsdNv+f/wya7WzyN
  3OKSFva971rr1k1/eiJjIq7fGbjByNPj0DG1lpHlntXXwsqOufKzVBTtI5bcd3H4uGh398fTl
  6yuGDuwuvT1rve9y7yDxY9+WPm/edf2ffzMc1xOGH31cCcnzPusutx4amvRD3WGkz1m5C1Mn9
  BXF3kB78HqxKd2eRrnax04/1PT3uQOHnzuqw67icuIv0Bj2q2JrMsYNf597TS2slim+H7hQu/
  lEbpvPp2XpY/IF5zip5W6H/eB+1//+srd147rnGmpNRnr3l7Um2y/KtyljOzslQzhaZdmJSrs
  DCa5e6mR/+ePLq3/ZNR2WQlluKMREMt5qLiRABFCfzrkgMAAA==
X-Env-Sender: ruansy.fnst@fujitsu.com
X-Msg-Ref: server-5.tower-585.messagelabs.com!1664112818!187471!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.87.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 4290 invoked from network); 25 Sep 2022 13:33:38 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
  by server-5.tower-585.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 25 Sep 2022 13:33:38 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id 69FD41000CD;
        Sun, 25 Sep 2022 14:33:38 +0100 (BST)
Received: from R01UKEXCASM121.r01.fujitsu.local (R01UKEXCASM121 [10.183.43.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id 5CA071000C2;
        Sun, 25 Sep 2022 14:33:38 +0100 (BST)
Received: from localhost.localdomain (10.167.225.141) by
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Sun, 25 Sep 2022 14:33:34 +0100
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>
CC:     <djwong@kernel.org>, <david@fromorbit.com>,
        <dan.j.williams@intel.com>, <hch@infradead.org>
Subject: [PATCH v9 0/3] mm, pmem, xfs: Introduce MF_MEM_REMOVE for unbind
Date:   Sun, 25 Sep 2022 13:33:20 +0000
Message-ID: <1664112803-57-1-git-send-email-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.225.141]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173)
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Changes since v8:
  1. P2: rename drop_pagecache_sb() to super_drop_pagecache().
  2. P2: let super_drop_pagecache() accept invalidate method.
  3. P3: invalidate all dax mappings by invalidate_inode_pages2().
  4. P3: shutdown the filesystem when it is to be removed.
  5. Rebase on 6.0-rc6 + Darrick's patch[1] + Dan's patch[2].

[1]: https://lore.kernel.org/linux-xfs/Yv5wIa2crHioYeRr@magnolia/
[2]: https://lore.kernel.org/linux-xfs/166153426798.2758201.15108211981034512993.stgit@dwillia2-xfh.jf.intel.com/

Shiyang Ruan (3):
  xfs: fix the calculation of length and end
  fs: move drop_pagecache_sb() for others to use
  mm, pmem, xfs: Introduce MF_MEM_REMOVE for unbind

 drivers/dax/super.c         |  3 ++-
 fs/drop_caches.c            | 35 ++----------------------------
 fs/super.c                  | 43 +++++++++++++++++++++++++++++++++++++
 fs/xfs/xfs_notify_failure.c | 36 ++++++++++++++++++++++++++-----
 include/linux/fs.h          |  1 +
 include/linux/mm.h          |  1 +
 include/linux/pagemap.h     |  1 +
 mm/truncate.c               | 20 +++++++++++++++--
 8 files changed, 99 insertions(+), 41 deletions(-)

-- 
2.37.3

