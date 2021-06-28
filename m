Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94AD23B56E4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jun 2021 03:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231815AbhF1Bsj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 27 Jun 2021 21:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbhF1Bsj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 27 Jun 2021 21:48:39 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD1B2C061574;
        Sun, 27 Jun 2021 18:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=T1V4LnCOqt86npWtAgDZzgAvOt8LGMICP/X3psZ1yV4=; b=wJwdpQgfutAX0oOIJ1JPRYMm9x
        k73cHl/qMFlhimtuyw/gQ0jwaOhKEmHBLe9i7goni3d5WtG2YOxRMuc+xG625bAPCPQ13d0bVscME
        viJCj3JFJ91z9nJgghFytNIgpKOhP0DMW1Bo2ro8Csob9dCMmETBjhaolMQYf37ce8LZ+5Wj3gA3U
        3LqBPSXdcL3WZvyDxXppQMS/sUCl9UW8fBLjQWaYLD0aN3NTVF6DrKJYSVbiU20/d+/ACYetA63ya
        IMhJdd/EICM2elh1xsBbiCAVgK5UkwVx4QQ/IOVL5vjFYPNUUled5qVSsvug22CdH/QgwmEhhYKPy
        hhG9btAg==;
Received: from [2601:1c0:6280:3f0::aefb] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lxgLm-006Tjs-0u; Mon, 28 Jun 2021 01:46:14 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH -next] fs: d_path.c: fix prepend_buffer kernel-doc warnings
Date:   Sun, 27 Jun 2021 18:46:13 -0700
Message-Id: <20210628014613.11296-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix new kernel-doc warnings related to struct prepend_buffer:

../fs/d_path.c:52: warning: Excess function parameter 'buffer' description in 'prepend_name'
../fs/d_path.c:52: warning: Excess function parameter 'buflen' description in 'prepend_name'
../fs/d_path.c:127: warning: Excess function parameter 'buffer' description in 'prepend_path'
../fs/d_path.c:127: warning: Excess function parameter 'buflen' description in 'prepend_path'

Fixes: ad08ae586586e ("d_path: introduce struct prepend_buffer")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
---
 fs/d_path.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

--- linux-next-20210625.orig/fs/d_path.c
+++ linux-next-20210625/fs/d_path.c
@@ -33,8 +33,7 @@ static void prepend(struct prepend_buffe
 
 /**
  * prepend_name - prepend a pathname in front of current buffer pointer
- * @buffer: buffer pointer
- * @buflen: allocated length of the buffer
+ * @p: &struct prepend_buffer parameters
  * @name:   name string and length qstr structure
  *
  * With RCU path tracing, it may race with d_move(). Use READ_ONCE() to
@@ -108,8 +107,7 @@ static int __prepend_path(const struct d
  * prepend_path - Prepend path string to a buffer
  * @path: the dentry/vfsmount to report
  * @root: root vfsmnt/dentry
- * @buffer: pointer to the end of the buffer
- * @buflen: pointer to buffer length
+ * @p: &struct prepend_buffer parameters
  *
  * The function will first try to write out the pathname without taking any
  * lock other than the RCU read lock to make sure that dentries won't go away.
