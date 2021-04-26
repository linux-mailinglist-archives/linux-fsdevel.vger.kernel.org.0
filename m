Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B59B36AF9B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Apr 2021 10:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232266AbhDZIRp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Apr 2021 04:17:45 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:57906 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232134AbhDZIRp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Apr 2021 04:17:45 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=haoxu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UWnOySz_1619425013;
Received: from e18g09479.et15sqa.tbsite.net(mailfrom:haoxu@linux.alibaba.com fp:SMTPD_---0UWnOySz_1619425013)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 26 Apr 2021 16:17:02 +0800
From:   Hao Xu <haoxu@linux.alibaba.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Anton Altaparmakov <anton@tuxera.com>
Cc:     linux-fsdevel@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net,
        Joseph Qi <joseph.qi@linux.alibaba.com>
Subject: [PATCH 0/2] remove redundant check buffer_uptodate()
Date:   Mon, 26 Apr 2021 16:16:51 +0800
Message-Id: <1619425013-130530-1-git-send-email-haoxu@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now set_buffer_uptodate() will test first and then set, so we don't have
to check buffer_uptodate() first, remove it to simplify code.

Hao Xu (2):
  fs: remove redundant check buffer_uptodate()
  ntfs: remove redundant check buffer_uptodate()

 fs/buffer.c       | 9 +++------
 fs/ntfs/file.c    | 9 +++------
 fs/ntfs/logfile.c | 3 +--
 3 files changed, 7 insertions(+), 14 deletions(-)

-- 
1.8.3.1

