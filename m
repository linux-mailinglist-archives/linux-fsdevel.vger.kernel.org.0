Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05940452C64
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Nov 2021 09:06:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231727AbhKPIJB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Nov 2021 03:09:01 -0500
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:1604 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231597AbhKPII5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Nov 2021 03:08:57 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UwqRIor_1637049948;
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0UwqRIor_1637049948)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 16 Nov 2021 16:05:49 +0800
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Subject: [PATCH] d_path: Eliminate compilation warnings
Date:   Tue, 16 Nov 2021 16:05:48 +0800
Message-Id: <20211116080548.30951-1-tianjia.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Eliminate the following clang compilation warnings by including
necessary header files:

  fs/d_path.c:318:7: warning: no previous prototype for function 'simple_dname' [-Wmissing-prototypes]
  char *simple_dname(struct dentry *dentry, char *buffer, int buflen)
        ^
  fs/d_path.c:318:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
  char *simple_dname(struct dentry *dentry, char *buffer, int buflen)
  ^
  static

Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
---
 fs/d_path.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/d_path.c b/fs/d_path.c
index e4e0ebad1f15..264f2b2aedd0 100644
--- a/fs/d_path.c
+++ b/fs/d_path.c
@@ -8,6 +8,8 @@
 #include <linux/prefetch.h>
 #include "mount.h"
 
+#include "internal.h"
+
 struct prepend_buffer {
 	char *buf;
 	int len;
-- 
2.32.0

