Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 261BF5F97BB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Oct 2022 07:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbiJJFXd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Oct 2022 01:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbiJJFXa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Oct 2022 01:23:30 -0400
Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D624F1A6;
        Sun,  9 Oct 2022 22:23:28 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 483E9C01D; Mon, 10 Oct 2022 07:23:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1665379407; bh=h7iN0yHsOk2Yc2OCw7yoF/YgYNpNTDxAmdvaxJlSsfk=;
        h=Date:From:To:Cc:Subject:From;
        b=N+immcIgXzkcEhRiq+P5Nxe5JmASsUuYmIxw1qb+T6NWsWFi+zynj6jrlrvxlqTIV
         UkSVyCnXF1KF8sX2+4US9q5TdwPMqoN/uhgNuU8i5Irw6UygTygJG2v5SewKHCemOM
         fwCxNeI37F08Ntum86+lI0jMHn5wictURg+RIQzajIGgUpdhD8bRTaNUdavW+k5gDf
         HxHnaj5Iiy5wvZM1bHfipKvkfKGdI52cfGuArB9kc4MgCMZ4KojK3auPDl49AWU9ft
         wv7hCiFQyVEiy0b9K3zR9y2Sq40+739PL5ArHOHp0kaVQHAUz/it2mGQC6skNSiDZc
         xTbFQgsM5o/GQ==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 57F46C009;
        Mon, 10 Oct 2022 07:23:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1665379405; bh=h7iN0yHsOk2Yc2OCw7yoF/YgYNpNTDxAmdvaxJlSsfk=;
        h=Date:From:To:Cc:Subject:From;
        b=GqZBfNmbOjG22+M+cZzTCo4n8z9X7V67QyS/7n+alJFR/6IlDKczYTXM72lu3zcfP
         nItJqgINqgcDYC/gJP7nrwbsY2UicmslzaJqFR3fRCCzPUEiO3yefAVyuuNOZROJD4
         M2u9Xbgzqn79SR1FHAUGOhTs8DkGIxxs/eMVFDUVDHrPdhcyvyYLSxuxZl2kEoxLGf
         rWvdqdSq3C6w7Lc6+6s0T+ZXYoUkMLg5UyKcfitM4R/bSPEABRwzxw6zAvUR2nJhiC
         hivN63/v9blAuYFvl/Gp8vlIPJklEpgA5Ib62sh2APPPmTSnWMFD7/8/VI8VBDHVsL
         MhHlT5+DIGRiw==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id 0979a99b;
        Mon, 10 Oct 2022 05:23:20 +0000 (UTC)
Date:   Mon, 10 Oct 2022 14:23:05 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian Schoenebeck <linux_oss@crudebyte.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net
Subject: [GIT PULL] 9p fixes for 6.1
Message-ID: <Y0OsOYmG+PU2CgcH@codewreck.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


The following changes since commit b90cb1053190353cc30f0fef0ef1f378ccc063c5:

  Linux 6.0-rc3 (2022-08-28 15:05:29 -0700)

are available in the Git repository at:

  https://github.com/martinetd/linux tags/9p-for-6.1

for you to fetch changes up to a8e633c604476e24d26a636582c0f5bdb421e70d:

  net/9p: clarify trans_fd parse_opt failure handling (2022-10-07 21:23:09 +0900)

----------------------------------------------------------------
9p-for-6.1: smaller buffers for small messages and fixes

The highlight of this PR is Christian's patch to allocate smaller buffers
for most metadata requests: 9p with a big msize would try to allocate large
buffers when just 4 or 8k would be more than enough; this brings in nice
performance improvements.

There's also a few fixes for problems reported by syzkaller (thanks to
Schspa Shi, Tetsuo Handa for tests and feedback/patches) as well as some
minor cleanup

----------------------------------------------------------------
Christian Schoenebeck (5):
      net/9p: split message size argument into 't_size' and 'r_size' pair
      9p: add P9_ERRMAX for 9p2000 and 9p2000.u
      net/9p: add p9_msg_buf_size()
      net/9p: add 'pooled_rbuffers' flag to struct p9_trans_module
      net/9p: allocate appropriate reduced message buffers

Dominique Martinet (2):
      9p: trans_fd/p9_conn_cancel: drop client lock earlier
      net/9p: use a dedicated spinlock for trans_fd

Li Zhong (1):
      net/9p: clarify trans_fd parse_opt failure handling

Tetsuo Handa (1):
      9p/trans_fd: always use O_NONBLOCK read/write

Xiu Jianfeng (1):
      net/9p: add __init/__exit annotations to module init/exit funcs

 include/net/9p/9p.h        |   3 +++
 include/net/9p/transport.h |   5 ++++
 net/9p/client.c            |  48 +++++++++++++++++++++++++++++++--------
 net/9p/protocol.c          | 167 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 net/9p/protocol.h          |   2 ++
 net/9p/trans_fd.c          |  50 ++++++++++++++++++++++++++--------------
 net/9p/trans_rdma.c        |   1 +
 net/9p/trans_virtio.c      |   1 +
 net/9p/trans_xen.c         |   5 ++--
 9 files changed, 254 insertions(+), 28 deletions(-)
--
Dominique
