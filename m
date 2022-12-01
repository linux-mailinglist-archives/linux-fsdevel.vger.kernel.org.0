Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D97A563F3D1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Dec 2022 16:29:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbiLAP3V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Dec 2022 10:29:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231707AbiLAP3U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Dec 2022 10:29:20 -0500
Received: from mail1.bemta37.messagelabs.com (mail1.bemta37.messagelabs.com [85.158.142.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD2D6AA8E8;
        Thu,  1 Dec 2022 07:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1669908556; i=@fujitsu.com;
        bh=M3V54yXNaDCv18NT2Zq41mSST490q6ZHooF3Zeq79mc=;
        h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=soDIyJMX9qTu0D8AqGhLxDxCQo9M0utzGxUnTRl318yvK/4EDRuuUImQvWbkd0APV
         3G/0LjfMIMtFYtC/dFwoPPyYUo1MQw5sHGxbFrBRqKGNUcsb39NGyITOJBI6/dGvwS
         JXh3aCiY5a6nDCp8kVVKx/BW7NYnz31N6/Yg53syPU+P5pc7z2+Lq239koSE9y6vZv
         Tnj4d4AgAVbuv3JmUWzcTvRU2cWO/+H4OPkbyciEiOmWyhq52lqqav0wFNmXHuG3Ei
         WuHYKxTKTxvZPG9E3jKkaUv3TTBSYQJ5aaSkchgidokrmsDNL1sXQHEdCqkeu7+fkj
         3KIH69Xx5kXZQ==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpileJIrShJLcpLzFFi42Kxs+FI1PU+0ZF
  scG+OtcWc9WvYLKZPvcBoseXYPUaLy0/4LPbsPclicXnXHDaLXX92sFus/PGH1YHD49QiCY/F
  e14yeWxa1cnmcWLGbxaPF5tnMnp83iQXwBbFmpmXlF+RwJpxcPse5oIHGhUtbR8YGxhfKXYxc
  nEICWxhlPjcsZsVwlnOJLGnZxeQwwnk7GGUePXXDsRmE9CRuLDgL1Ccg0NEoFri1lI2kDCzQI
  bE8St/mEFsYQFziUVfZ7CDlLAIqEgcnhMOEuYVcJE4deIRWImEgILElIfvmSHighInZz5hgRg
  jIXHwxQtmkFYJASWJmd3xEOUVErNmtTFB2GoSV89tYp7AyD8LSfcsJN0LGJlWMZoVpxaVpRbp
  muslFWWmZ5TkJmbm6CVW6SbqpZbq5uUXlWToGuollhfrpRYX6xVX5ibnpOjlpZZsYgQGfkpxw
  s8djBuX/dE7xCjJwaQkyqu9ryNZiC8pP6UyI7E4I76oNCe1+BCjDAeHkgRvyh6gnGBRanpqRV
  pmDjAKYdISHDxKIrx8x4DSvMUFibnFmekQqVOM9hxrGw7sZebY8ABETvpzDUhOnf1vP7MQS15
  +XqqUOO9FkDYBkLaM0jy4obCkcYlRVkqYl5GBgUGIpyC1KDezBFX+FaM4B6OSMO+2bUBTeDLz
  SuB2vwI6iwnorEixNpCzShIRUlINTD2nzj536Fm6/e6C30/uHHYs8X38oTFy/n155o1T/Favt
  b5X6eqqnror5gjT5e9rr5v8EWmuvpkvpbc7OomX38ZhuvZieec12nstOKvivu/b5ZAfGRls/l
  f91JeoeV+yJk449+ZFg5j00mSDYoPFk+3WRn/IPfLQY5Gml6P+/mdL8runbTsoOsFwecyxtFj
  2rSbcHHOnXUqWX8Cl/lT16GnFDP2dEhHam4R9Xuw+YDsxik/mW6/fq5MSFzRmau9K3FXIqSH8
  7NQL60kBjCnbtFXZjmlv37to88ODJ30OvdJi7FTTmXv+indt6YVfzBunqW15fnZP9kShXqvAx
  OPH9ZliRX7dDJqr0itg1TrDZZ4SS3FGoqEWc1FxIgBKSgzUlQMAAA==
X-Env-Sender: ruansy.fnst@fujitsu.com
X-Msg-Ref: server-21.tower-745.messagelabs.com!1669908555!279337!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.101.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 11053 invoked from network); 1 Dec 2022 15:29:15 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
  by server-21.tower-745.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 1 Dec 2022 15:29:15 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id 45FCE1001A4;
        Thu,  1 Dec 2022 15:29:15 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126 [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id 399611001A3;
        Thu,  1 Dec 2022 15:29:15 +0000 (GMT)
Received: from localhost.localdomain (10.167.225.141) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Thu, 1 Dec 2022 15:29:11 +0000
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>
CC:     <djwong@kernel.org>, <david@fromorbit.com>,
        <dan.j.williams@intel.com>, <akpm@linux-foundation.org>
Subject: [PATCH v2 0/8] fsdax,xfs: fix warning messages
Date:   Thu, 1 Dec 2022 15:28:50 +0000
Message-ID: <1669908538-55-1-git-send-email-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.225.141]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
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

Changes since v1:
 1. Added a snippet of the warning message and some of the failed cases
 2. Separated the patch for easily review
 3. Added page->share and its helper functions
 4. Included the patch[1] that removes the restrictions of fsdax and reflink
[1] https://lore.kernel.org/linux-xfs/1663234002-17-1-git-send-email-ruansy.fnst@fujitsu.com/

Many testcases failed in dax+reflink mode with warning message in dmesg.
Such as generic/051,075,127.  The warning message is like this:
[  775.509337] ------------[ cut here ]------------
[  775.509636] WARNING: CPU: 1 PID: 16815 at fs/dax.c:386 dax_insert_entry.cold+0x2e/0x69
[  775.510151] Modules linked in: auth_rpcgss oid_registry nfsv4 algif_hash af_alg af_packet nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set nf_tables nfnetlink ip6table_filter ip6_tables iptable_filter ip_tables x_tables dax_pmem nd_pmem nd_btt sch_fq_codel configfs xfs libcrc32c fuse
[  775.524288] CPU: 1 PID: 16815 Comm: fsx Kdump: loaded Tainted: G        W          6.1.0-rc4+ #164 eb34e4ee4200c7cbbb47de2b1892c5a3e027fd6d
[  775.524904] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS Arch Linux 1.16.0-3-3 04/01/2014
[  775.525460] RIP: 0010:dax_insert_entry.cold+0x2e/0x69
[  775.525797] Code: c7 c7 18 eb e0 81 48 89 4c 24 20 48 89 54 24 10 e8 73 6d ff ff 48 83 7d 18 00 48 8b 54 24 10 48 8b 4c 24 20 0f 84 e3 e9 b9 ff <0f> 0b e9 dc e9 b9 ff 48 c7 c6 a0 20 c3 81 48 c7 c7 f0 ea e0 81 48
[  775.526708] RSP: 0000:ffffc90001d57b30 EFLAGS: 00010082
[  775.527042] RAX: 000000000000002a RBX: 0000000000000000 RCX: 0000000000000042
[  775.527396] RDX: ffffea000a0f6c80 RSI: ffffffff81dfab1b RDI: 00000000ffffffff
[  775.527819] RBP: ffffea000a0f6c40 R08: 0000000000000000 R09: ffffffff820625e0
[  775.528241] R10: ffffc90001d579d8 R11: ffffffff820d2628 R12: ffff88815fc98320
[  775.528598] R13: ffffc90001d57c18 R14: 0000000000000000 R15: 0000000000000001
[  775.528997] FS:  00007f39fc75d740(0000) GS:ffff88817bc80000(0000) knlGS:0000000000000000
[  775.529474] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  775.529800] CR2: 00007f39fc772040 CR3: 0000000107eb6001 CR4: 00000000003706e0
[  775.530214] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  775.530592] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  775.531002] Call Trace:
[  775.531230]  <TASK>
[  775.531444]  dax_fault_iter+0x267/0x6c0
[  775.531719]  dax_iomap_pte_fault+0x198/0x3d0
[  775.532002]  __xfs_filemap_fault+0x24a/0x2d0 [xfs aa8d25411432b306d9554da38096f4ebb86bdfe7]
[  775.532603]  __do_fault+0x30/0x1e0
[  775.532903]  do_fault+0x314/0x6c0
[  775.533166]  __handle_mm_fault+0x646/0x1250
[  775.533480]  handle_mm_fault+0xc1/0x230
[  775.533810]  do_user_addr_fault+0x1ac/0x610
[  775.534110]  exc_page_fault+0x63/0x140
[  775.534389]  asm_exc_page_fault+0x22/0x30
[  775.534678] RIP: 0033:0x7f39fc55820a
[  775.534950] Code: 00 01 00 00 00 74 99 83 f9 c0 0f 87 7b fe ff ff c5 fe 6f 4e 20 48 29 fe 48 83 c7 3f 49 8d 0c 10 48 83 e7 c0 48 01 fe 48 29 f9 <f3> a4 c4 c1 7e 7f 00 c4 c1 7e 7f 48 20 c5 f8 77 c3 0f 1f 44 00 00
[  775.535839] RSP: 002b:00007ffc66a08118 EFLAGS: 00010202
[  775.536157] RAX: 00007f39fc772001 RBX: 0000000000042001 RCX: 00000000000063c1
[  775.536537] RDX: 0000000000006400 RSI: 00007f39fac42050 RDI: 00007f39fc772040
[  775.536919] RBP: 0000000000006400 R08: 00007f39fc772001 R09: 0000000000042000
[  775.537304] R10: 0000000000000001 R11: 0000000000000246 R12: 0000000000000001
[  775.537694] R13: 00007f39fc772000 R14: 0000000000006401 R15: 0000000000000003
[  775.538086]  </TASK>
[  775.538333] ---[ end trace 0000000000000000 ]---

This also effects dax+noreflink mode if we run the test after a
dax+reflink test.  So, the most urgent thing is solving the warning
messages.

With these fixes, most warning messages in dax_associate_entry() are
gone.  But honestly, generic/388 will randomly failed with the warning.
The case shutdown the xfs when fsstress is running, and do it for many
times.  I think the reason is that dax pages in use are not able to be
invalidated in time when fs is shutdown.  The next time dax page to be
associated, it still remains the mapping value set last time.  I'll keep
on solving it.

The warning message in dax_writeback_one() can also be fixed because of
the dax unshare.


Shiyang Ruan (8):
  fsdax: introduce page->share for fsdax in reflink mode
  fsdax: invalidate pages when CoW
  fsdax: zero the edges if source is HOLE or UNWRITTEN
  fsdax,xfs: set the shared flag when file extent is shared
  fsdax: dedupe: iter two files at the same time
  xfs: use dax ops for zero and truncate in fsdax mode
  fsdax,xfs: port unshare to fsdax
  xfs: remove restrictions for fsdax and reflink

 fs/dax.c                   | 220 +++++++++++++++++++++++++------------
 fs/xfs/xfs_ioctl.c         |   4 -
 fs/xfs/xfs_iomap.c         |   6 +-
 fs/xfs/xfs_iops.c          |   4 -
 fs/xfs/xfs_reflink.c       |   8 +-
 include/linux/dax.h        |   2 +
 include/linux/mm_types.h   |   5 +-
 include/linux/page-flags.h |   2 +-
 8 files changed, 166 insertions(+), 85 deletions(-)

-- 
2.38.1

