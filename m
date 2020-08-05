Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9F0A23C3AC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Aug 2020 04:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbgHECtY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Aug 2020 22:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727817AbgHECtX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Aug 2020 22:49:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C130C06174A;
        Tue,  4 Aug 2020 19:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=U+uU3PRmVfCzzIUwZ9ypGKsWqt2bIIRQA22zMffRCbE=; b=WelewHSSGMGxLBjLqbgXDMXRbI
        2iStCBatsAfi1MVzBC/G6GOwsxFV+X1/0pJPJ43le/fGVdV3oIAn22FyhAsEksvQbmFeL1A7H27p7
        +VAb4Ts8feLgXJTK7a2W0RBawILH7X+Gj9ysIfdzzuuj7xGOW9CrIsLeo4Nvn6u0VrJLriMPhGJxO
        Wtpa2fY4BNgglJm1MUZzYZvRF36jqBiFl7PnAFam0PUWVDvuuafqOIxo1p2HKK7OOC3GFqOK11oTr
        Ve1thUgYrsVuAeF16g4dcFC8pYSqUUqs3DTsxKz/fgVZt5BgppANYhiy/lntiZJQ+nWlfaILPY1VS
        cH1M8Tqg==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k39UV-0007VO-1J; Wed, 05 Aug 2020 02:49:19 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] procfs: delete duplicated words + other fixes
Date:   Tue,  4 Aug 2020 19:49:15 -0700
Message-Id: <20200805024915.12231-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Delete repeated words in fs/proc/.
{the, which}
where "which which" was changed to "with which".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Cc: linux-kernel@vger.kernel.org
---
 fs/proc/base.c     |    2 +-
 fs/proc/proc_net.c |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

--- linux-next-20200804.orig/fs/proc/base.c
+++ linux-next-20200804/fs/proc/base.c
@@ -2016,7 +2016,7 @@ const struct dentry_operations pid_dentr
  * file type from dcache entry.
  *
  * Since all of the proc inode numbers are dynamically generated, the inode
- * numbers do not exist until the inode is cache.  This means creating the
+ * numbers do not exist until the inode is cache.  This means creating
  * the dcache entry in readdir is necessary to keep the inode numbers
  * reported by readdir in sync with the inode numbers reported
  * by stat.
--- linux-next-20200804.orig/fs/proc/proc_net.c
+++ linux-next-20200804/fs/proc/proc_net.c
@@ -140,7 +140,7 @@ EXPORT_SYMBOL_GPL(proc_create_net_data);
  * @mode: The file's access mode.
  * @parent: The parent directory in which to create.
  * @ops: The seq_file ops with which to read the file.
- * @write: The write method which which to 'modify' the file.
+ * @write: The write method with which to 'modify' the file.
  * @data: Data for retrieval by PDE_DATA().
  *
  * Create a network namespaced proc file in the @parent directory with the
@@ -232,7 +232,7 @@ EXPORT_SYMBOL_GPL(proc_create_net_single
  * @mode: The file's access mode.
  * @parent: The parent directory in which to create.
  * @show: The seqfile show method with which to read the file.
- * @write: The write method which which to 'modify' the file.
+ * @write: The write method with which to 'modify' the file.
  * @data: Data for retrieval by PDE_DATA().
  *
  * Create a network-namespaced proc file in the @parent directory with the
