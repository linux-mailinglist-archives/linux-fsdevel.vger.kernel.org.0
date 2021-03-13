Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04581339B6F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Mar 2021 03:56:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232731AbhCMCzl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Mar 2021 21:55:41 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:13160 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232487AbhCMCzH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Mar 2021 21:55:07 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Dy6g31yjrzlTnk;
        Sat, 13 Mar 2021 10:52:47 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.498.0; Sat, 13 Mar 2021
 10:54:56 +0800
From:   "zhangyi (F)" <yi.zhang@huawei.com>
To:     <linux-fsdevel@vger.kernel.org>, <linux-ext4@vger.kernel.org>,
        <linux-block@vger.kernel.org>, <jack@suse.cz>
CC:     <tytso@mit.edu>, <viro@zeniv.linux.org.uk>, <hch@infradead.org>,
        <axboe@kernel.dk>, <mcgrof@kernel.org>, <keescook@chromium.org>,
        <yzaikin@google.com>, <yi.zhang@huawei.com>
Subject: [RFC PATCH 0/3] block_dump: remove block dump
Date:   Sat, 13 Mar 2021 11:01:43 +0800
Message-ID: <20210313030146.2882027-1-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

block_dump is an old debugging interface and can be replaced by
tracepoints, and we also found a deadlock issue relate to it[1]. As Jan
suggested, this patch set delete the whole block_dump feature, we can
use tracepoints to get the similar information. If someone still using
this feature cannot switch to use tracepoints or any other suggestions,
please let us know.

Thanks,
Yi.

[1]. https://lore.kernel.org/linux-fsdevel/20210305132442.GA2801131@infradead.org/T/#m385b0f84bc381d3089740e33d94f6e1b67dd06d2

zhangyi (F) (3):
  block_dump: remove block_dump feature in mark_inode_dirty()
  block_dump: remove block_dump feature
  block_dump: remove comments in docs

 .../admin-guide/laptops/laptop-mode.rst       | 11 --------
 Documentation/admin-guide/sysctl/vm.rst       |  8 ------
 block/blk-core.c                              |  9 -------
 fs/fs-writeback.c                             | 25 -------------------
 include/linux/writeback.h                     |  1 -
 kernel/sysctl.c                               |  8 ------
 mm/page-writeback.c                           |  5 ----
 7 files changed, 67 deletions(-)

-- 
2.25.4

