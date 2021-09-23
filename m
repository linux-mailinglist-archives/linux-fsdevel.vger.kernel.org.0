Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5CC415B0C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Sep 2021 11:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240196AbhIWJhU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Sep 2021 05:37:20 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:49755 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240195AbhIWJhS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Sep 2021 05:37:18 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R221e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UpK4oIe_1632389745;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0UpK4oIe_1632389745)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 23 Sep 2021 17:35:45 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     vgoyal@redhat.com, stefanha@redhat.com, miklos@szeredi.hu
Cc:     linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com,
        bo.liu@linux.alibaba.com, joseph.qi@linux.alibaba.com
Subject: [virtiofsd PATCH v5 0/2] virtiofsd: support per-file DAX
Date:   Thu, 23 Sep 2021 17:35:43 +0800
Message-Id: <20210923093545.81512-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210923092526.72341-1-jefflexu@linux.alibaba.com>
References: <20210923092526.72341-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

changes since v4:
- decide whether DAX shall be enabled or not solely depending on file
  size (DAX is disabled for files smaller than 32KB)
- negotiation during FUSE_INIT is droped
- drop support for .ioctl() for passthrough

changes since v2/v3:
Patch 4 in v2 is incomplete by mistake and it will fail to be compiled.
I had ever sent a seperate patch 4 of v3. Now I send the whole complete
set in v4. Except for this, there's no other diferrence.


Jeffle Xu (2):
  virtiofsd: add FUSE_ATTR_DAX to fuse protocol
  virtiofsd: support per-file DAX

 include/standard-headers/linux/fuse.h |  1 +
 tools/virtiofsd/passthrough_ll.c      | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+)

-- 
2.27.0

