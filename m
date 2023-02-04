Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9C1B68AABC
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Feb 2023 15:59:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232792AbjBDO7M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 Feb 2023 09:59:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231654AbjBDO7L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 Feb 2023 09:59:11 -0500
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com [195.245.231.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3442235244;
        Sat,  4 Feb 2023 06:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1675522742; i=@fujitsu.com;
        bh=Y6556VUSt0g6C9g9VUOGSPdcCC4oR7BzWPz7nW90/xI=;
        h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=vuB9Dkq/CcCu6kUL9IGhoRjSHTuDyqt/LgQw4M3XYGQeXGNDdQTHT5rvZF+9aCLQG
         O8Agu3z8w6ml0kJNoKNzepUVnlqbwYWPqMeskN7XoFmZb93wDlnZUGxhphfwWVRqvH
         cnQu6wK9ZRbWtZcQAgVaz9bIMy8MnvrHTUj/4/i/8cD+JJPuRYWEVgSibh/BHO84mq
         CItCZIj09wI7ejzDVYsgTuUkJTgQYKjU6Cs+peVOSXrm3XMTEv9UArs+NCBz/fpYSk
         IOEJ9uyLPAhNYKyPXFkaJE4jfnxlGsrk8y8dvh2VeGI7myquRMBhAUsXyjXXgpa6hv
         kf9K4jxeKseuA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphleJIrShJLcpLzFFi42Kxs+HYrLup6F6
  ywdfpfBbTp15gtNhy7B6jxeUnfBanJyxistj9+iabxZ69J1ksLu+aw2Zxb81/Votdf3awW6z8
  8YfVgcvj1CIJj80rtDwW73nJ5LFpVSebx6ZPk9g9Xmyeyejx8ektFo/Pm+QCOKJYM/OS8isSW
  DNmv33CWrCIs2Jr00rWBsZd7F2MXBxCAhsZJdrblrNCOEuYJO7Om8TcxcgJ5OxllGiaVAFisw
  noSFxY8BesSERgEqPEsRs3wYqYBcol9m+8wQZiCwsESBzfe4UFxGYRUJHoaPrM1MXIwcEr4CI
  xf68USFhCQEFiysP3YK28AoISJ2c+YYEYIyFx8MULZpByCQEliZnd8RDllRKtH36xQNhqElfP
  bWKewMg/C0n3LCTdCxiZVjGaFqcWlaUW6RrrJRVlpmeU5CZm5uglVukm6qWW6panFpfoGukll
  hfrpRYX6xVX5ibnpOjlpZZsYgRGSEqxmvAOxi+9f/UOMUpyMCmJ8vb7300W4kvKT6nMSCzOiC
  8qzUktPsQow8GhJMF7veBespBgUWp6akVaZg4wWmHSEhw8SiK8v0HSvMUFibnFmekQqVOMuhx
  rGw7sZRZiycvPS5US520tBCoSACnKKM2DGwFLHJcYZaWEeRkZGBiEeApSi3IzS1DlXzGKczAq
  CfPeAlnFk5lXArfpFdARTEBHdBvcBTmiJBEhJdXAlOvF0z2nYL5DxTfNReqf6yM4Zqw8qjqrp
  qtfPPnoU2nztu53e19cTk2bdDRt/Qahjpsz+bxzLz6PrPjEfJFxma1qiUPPV79G/9O/NbjXMi
  z//kz48fL9edWmuQfatKQ3iDAo7WhRbXqx1ou3mffJy2UP1n468/zi7VbzOKNPzz47JF3dciX
  I7/vB/Fky4rmRIgEKkmt3/Vu8us/g9EeztKJXD+XdRM9kOWz6mKlSm67cv1DXxtIyz3XNNuMk
  r0LDjPU/Ix45PduTUHbY/yCXe6xOXvAmm849Sc6Zhzg2Lmgy36/FVXDz2Fzx20WLLTcrP29p5
  7yuefzFefXE4guSDCtjXm/wCLNY8+bFO48wJZbijERDLeai4kQAxJmK9JcDAAA=
X-Env-Sender: ruansy.fnst@fujitsu.com
X-Msg-Ref: server-15.tower-548.messagelabs.com!1675522738!73849!1
X-Originating-IP: [62.60.8.179]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.102.2; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 28624 invoked from network); 4 Feb 2023 14:58:58 -0000
Received: from unknown (HELO n03ukasimr04.n03.fujitsu.local) (62.60.8.179)
  by server-15.tower-548.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 4 Feb 2023 14:58:58 -0000
Received: from n03ukasimr04.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTP id DB0FD150;
        Sat,  4 Feb 2023 14:58:57 +0000 (GMT)
Received: from R01UKEXCASM223.r01.fujitsu.local (R01UKEXCASM223 [10.182.185.121])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTPS id CEB6E7B;
        Sat,  4 Feb 2023 14:58:57 +0000 (GMT)
Received: from localhost.localdomain (10.167.225.141) by
 R01UKEXCASM223.r01.fujitsu.local (10.182.185.121) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Sat, 4 Feb 2023 14:58:53 +0000
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>
CC:     <djwong@kernel.org>, <dan.j.williams@intel.com>,
        <david@fromorbit.com>, <hch@infradead.org>, <jane.chu@oracle.com>
Subject: [RESEND PATCH v9 0/3] mm, pmem, xfs: Introduce MF_MEM_REMOVE for unbind
Date:   Sat, 4 Feb 2023 14:58:35 +0000
Message-ID: <1675522718-88-1-git-send-email-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.225.141]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM223.r01.fujitsu.local (10.182.185.121)
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

Changes since v9:
  1. Rebase on 6.2-rc6

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
2.39.1

