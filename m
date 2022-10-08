Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DBA85F849B
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Oct 2022 11:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbiJHJah (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 8 Oct 2022 05:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbiJHJaf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 8 Oct 2022 05:30:35 -0400
Received: from mail.nfschina.com (mail.nfschina.com [124.16.136.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1B1D39FEA;
        Sat,  8 Oct 2022 02:30:33 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id C39721E80D9B;
        Sat,  8 Oct 2022 17:24:45 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id SpyDjpNCVfDe; Sat,  8 Oct 2022 17:24:43 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: zeming@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id C98C21E80D72;
        Sat,  8 Oct 2022 17:24:42 +0800 (CST)
From:   Li zeming <zeming@nfschina.com>
To:     mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Li zeming <zeming@nfschina.com>
Subject: [PATCH] =?UTF-8?q?proc:=20Remove=20unnecessary=20=E2=80=98NULL?= =?UTF-8?q?=E2=80=99=20and=20'0'=20values?=
Date:   Sat,  8 Oct 2022 17:30:26 +0800
Message-Id: <20221008093026.4952-1-zeming@nfschina.com>
X-Mailer: git-send-email 2.18.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Remove unnecessary initialization assignments, which are used after the
assignment.

Signed-off-by: Li zeming <zeming@nfschina.com>
---
 fs/proc/proc_sysctl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 021e83fe831f..5fc367f0044a 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -694,7 +694,7 @@ static bool proc_sys_fill_cache(struct file *file,
 	struct dentry *child, *dir = file->f_path.dentry;
 	struct inode *inode;
 	struct qstr qname;
-	ino_t ino = 0;
+	ino_t ino;
 	unsigned type = DT_UNKNOWN;
 
 	qname.name = table->procname;
@@ -1246,7 +1246,7 @@ static bool get_links(struct ctl_dir *dir,
 static int insert_links(struct ctl_table_header *head)
 {
 	struct ctl_table_set *root_set = &sysctl_table_root.default_set;
-	struct ctl_dir *core_parent = NULL;
+	struct ctl_dir *core_parent;
 	struct ctl_table_header *links;
 	int err;
 
-- 
2.18.2

