Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF4D46CBB52
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Mar 2023 11:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232385AbjC1Jmy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Mar 2023 05:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232638AbjC1Jma (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Mar 2023 05:42:30 -0400
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com [195.245.231.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA93F618A;
        Tue, 28 Mar 2023 02:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1679996547; i=@fujitsu.com;
        bh=5ysgX3w4r/9z7wfbPe30efN793AZmmL/VAdTe4COUNg=;
        h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=u5LXODGK/FG2+ThkcCErIQ3XT6s7340iM4GN/KR0FYHUojfV8FFAHtjtrG5VomqMT
         wpb2RGvBRPqETpHk74WqXr7fUYWYY9mv6FbS+MqyawH0rhZJPw6LdaOEGeKZpPq/q2
         iwiAyHHSeMojTHfdkOkmXGkDuFv4awCP3XzWI4Q3A50Q7ep1cJecW9+WAaBBtUjBM6
         Xkhl4uwitQUwNqimwseHj+mjpwErO2vprAm5P3YS7jYv1szSfIr8Jj0K2r0PEb0QnP
         h5uLSL/eJHlvF5/w9FW/t3SPQQHAEwCjDaD9m36t2yFH/EiXdkmkcKxQzK8YdPEqY+
         T/CwPWuLf/F+Q==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpileJIrShJLcpLzFFi42Kxs+FI1K3ZppR
  isHC3gsWc9WvYLKZPvcBocfkJn8Xs6c1MFnv2nmSxuLfmP6vFrj872C1W/vjDavH7xxw2B06P
  zSu0PBbvecnksWlVJ5vHpk+T2D1OzPjN4vFi80xGjzMLjrB7fN4kF8ARxZqZl5RfkcCa0XlsA
  0vBee6K3nv/mBsYN3N2MXJxCAlsYZS4NmERI4SznEli4/leJgjnGKPEyeXTgRxODjYBHYkLC/
  6ygtgiAoUSe5a+YwGxmQUqJBoX/WPuYuTgEBbwkjh6sBwkzCKgKjH58kN2EJtXwFli//PtzCC
  2hICCxJSH75kh4oISJ2c+gRojIXHwxQuoGiWJi1/vsELYQOOnH2KCsNUkrp7bxDyBkX8WkvZZ
  SNoXMDKtYjQrTi0qSy3SNTTTSyrKTM8oyU3MzNFLrNJN1Est1S1PLS7RNdJLLC/WSy0u1iuuz
  E3OSdHLSy3ZxAiMjpRidfcdjEf6/uodYpTkYFIS5e3nVEwR4kvKT6nMSCzOiC8qzUktPsQow8
  GhJMGrskUpRUiwKDU9tSItMwcYqTBpCQ4eJRHea6uB0rzFBYm5xZnpEKlTjLocaxsO7GUWYsn
  Lz0uVEudN3wpUJABSlFGaBzcCljQuMcpKCfMyMjAwCPEUpBblZpagyr9iFOdgVBLmDdwMNIUn
  M68EbtMroCOYgI74VqAAckRJIkJKqoFpz6QVKTV+2brSj5Q6/kxzz2TOnirz9Zv4iqYz6d2hs
  09c+Wv842H/KUXDLd/Ltl8tP63DzSORKHHTyW9/5tNDl6uiDTiCW55Pt+Xrfio19d6tcMf3v6
  5UPbNS5hb4VmK4/v53/tzcCAvWzLk3lTW/7Io71Sz1q59P2U3Q0zZVMZ+ts18lwHDu6ar6W3b
  Py/U+h8sdc7Kynl74d6kp+7Sjz7tY4h4t29uf+kHQK9jiwIP9Wyuy15mL1h0ueXjq4KnC/soX
  /eVbNU77bBNyjvqw5+aXbXrTmjz0ay0T1yTrBdnVBF85Xzh9wrPYiMUmUwp60zlUb/Zqi90uv
  zahJtDubF24d9aX2jkHY7R4diixFGckGmoxFxUnAgBGx1palQMAAA==
X-Env-Sender: ruansy.fnst@fujitsu.com
X-Msg-Ref: server-3.tower-571.messagelabs.com!1679996540!574172!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.104.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 902 invoked from network); 28 Mar 2023 09:42:20 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
  by server-3.tower-571.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 28 Mar 2023 09:42:20 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id 29CE31001A5;
        Tue, 28 Mar 2023 10:42:20 +0100 (BST)
Received: from R01UKEXCASM121.r01.fujitsu.local (R01UKEXCASM121 [10.183.43.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id 1D68F10019D;
        Tue, 28 Mar 2023 10:42:20 +0100 (BST)
Received: from 692d629b0116.g08.fujitsu.local (10.167.234.230) by
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Tue, 28 Mar 2023 10:42:16 +0100
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <linux-fsdevel@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <linux-xfs@vger.kernel.org>, <linux-mm@kvack.org>
CC:     <dan.j.williams@intel.com>, <willy@infradead.org>, <jack@suse.cz>,
        <akpm@linux-foundation.org>, <djwong@kernel.org>
Subject: [PATCH v11 0/2] mm, pmem, xfs: Introduce MF_MEM_REMOVE for unbind
Date:   Tue, 28 Mar 2023 09:41:44 +0000
Message-ID: <1679996506-2-1-git-send-email-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.234.230]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173)
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patchset is to add gracefully unbind support for pmem.
Patch1 corrects the calculation of length and end of a given range.
Patch2 introduces a new flag call MF_MEM_REMOVE, to let dax holder know
it is a remove event.  With the help of notify_failure mechanism, we are
able to shutdown the filesystem on the pmem gracefully.

Changes since v10:
 Patch1:
  1. correct the count calculation in xfs_failure_pgcnt().
 Patch2:
  2. drop the patch which introduces super_drop_pagecache().
  3. in mf_dax_kill_procs(), don't SetPageHWPoison() and search for all
      tasks while mf_flags has MF_MEM_PRE_REMOVE.
  4. only do mf_dax_kill_procs() on dax mapping.
  5. do invalidate_inode_pages2_range() for each file found during rmap,
      to make sure the dax entry are disassociated before pmem is gone.
      Otherwise, umount filesystem after unbind will cause crash because
      the dax entries have to be disassociated but now the pmem is not
      exist.

  For detail analysis of this change, please refer this link[1].

[1] https://lore.kernel.org/linux-xfs/b1d9fc03-1a71-a75f-f87b-5819991e4eb2@fujitsu.com/

Shiyang Ruan (2):
  xfs: fix the calculation of length and end
  mm, pmem, xfs: Introduce MF_MEM_REMOVE for unbind

 drivers/dax/super.c         |  3 +-
 fs/xfs/xfs_notify_failure.c | 66 +++++++++++++++++++++++++++++++------
 include/linux/mm.h          |  1 +
 mm/memory-failure.c         | 17 +++++++---
 4 files changed, 72 insertions(+), 15 deletions(-)

-- 
2.39.2

