Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B37E36072DF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Oct 2022 10:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbiJUIuJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Oct 2022 04:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiJUIuE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Oct 2022 04:50:04 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C489357CD;
        Fri, 21 Oct 2022 01:49:49 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VSimdbh_1666342152;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VSimdbh_1666342152)
          by smtp.aliyun-inc.com;
          Fri, 21 Oct 2022 16:49:13 +0800
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
To:     dhowells@redhat.com, xiang@kernel.org, chao@kernel.org,
        linux-erofs@lists.ozlabs.org
Cc:     jlayton@kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/2] netfs,erofs: reuse netfs_put_subrequest() and
Date:   Fri, 21 Oct 2022 16:49:10 +0800
Message-Id: <20221021084912.61468-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The data routine of erofs in fscache mode also relies on
netfs_io_request and netfs_io_subrequest.  erofs itself maintains a
copy of some helpers on netfs_io_request and netfs_io_subrequest.

To clean up the code, export netfs_put_subrequest() and
netfs_rreq_completed().


Jingbo Xu (2):
  netfs: export helpers for request and subrequest
  erofs: use netfs helpers manipulating request and subrequest

 fs/erofs/fscache.c    | 47 +++++++++----------------------------------
 fs/netfs/io.c         |  3 ++-
 fs/netfs/objects.c    |  1 +
 include/linux/netfs.h |  2 ++
 4 files changed, 15 insertions(+), 38 deletions(-)

-- 
2.19.1.6.gb485710b

