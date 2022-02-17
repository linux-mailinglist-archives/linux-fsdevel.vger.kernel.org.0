Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B09C04B9F8D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Feb 2022 13:02:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239970AbiBQMCO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Feb 2022 07:02:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbiBQMCN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Feb 2022 07:02:13 -0500
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D29686433;
        Thu, 17 Feb 2022 04:01:58 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R371e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0V4kJNJC_1645099314;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0V4kJNJC_1645099314)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 17 Feb 2022 20:01:55 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     dhowells@redhat.com, linux-cachefs@redhat.com
Cc:     xiang@kernel.org, torvalds@linux-foundation.org,
        gregkh@linuxfoundation.org, willy@infradead.org,
        linux-fsdevel@vger.kernel.org, joseph.qi@linux.alibaba.com,
        bo.liu@linux.alibaba.com, tao.peng@linux.alibaba.com,
        gerry@linux.alibaba.com, eguan@linux.alibaba.com,
        linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v3 0/4] fscache,erofs: fscache-based demand-read semantics (fscache part)
Date:   Thu, 17 Feb 2022 20:01:50 +0800
Message-Id: <20220217120154.16658-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi David,

This patchset is from [1], which is all fscache part related, in prep
for the newly introduced on-demand read semantics.

The previous patch 5 [2] from [1] is still under modification according
to the comments from Greg. Thus it is not included in this patchset
yet, and will be sent out later.

Whilst these four patches in this patchset are basically trivial cleanup
codes. I do appreciate if you coud give some hint on this work.

Thanks.

[1] https://lore.kernel.org/all/20220215111335.123528-1-jefflexu@linux.alibaba.com/T/
[2] https://lore.kernel.org/all/20220215111335.123528-1-jefflexu@linux.alibaba.com/T/#ma8898ba06bf66d815925a32d1d6689d71346e609



Jeffle Xu (4):
  fscache: export fscache_end_operation()
  fscache: add a method to support on-demand read semantics
  cachefiles: extract generic function for daemon methods
  cachefiles: detect backing file size in on-demand read mode

 Documentation/filesystems/netfs_library.rst | 17 +++++
 fs/cachefiles/Kconfig                       | 13 ++++
 fs/cachefiles/daemon.c                      | 70 +++++++++++++--------
 fs/cachefiles/internal.h                    |  1 +
 fs/cachefiles/namei.c                       | 60 +++++++++++++++++-
 fs/fscache/internal.h                       | 11 ----
 fs/nfs/fscache.c                            |  8 ---
 include/linux/fscache.h                     | 39 ++++++++++++
 include/linux/netfs.h                       |  4 ++
 9 files changed, 178 insertions(+), 45 deletions(-)

-- 
2.27.0

