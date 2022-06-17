Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABB0D54F09B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jun 2022 07:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380092AbiFQFf6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jun 2022 01:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380083AbiFQFf4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jun 2022 01:35:56 -0400
Received: from smtp03.aussiebb.com.au (smtp03.aussiebb.com.au [121.200.0.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96E5B66AEB;
        Thu, 16 Jun 2022 22:35:54 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by smtp03.aussiebb.com.au (Postfix) with ESMTP id AB3DA1A009C;
        Fri, 17 Jun 2022 15:35:52 +1000 (AEST)
X-Virus-Scanned: Debian amavisd-new at smtp03.aussiebb.com.au
Received: from smtp03.aussiebb.com.au ([127.0.0.1])
        by localhost (smtp03.aussiebb.com.au [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id pRJsQmS4rxnA; Fri, 17 Jun 2022 15:35:52 +1000 (AEST)
Received: by smtp03.aussiebb.com.au (Postfix, from userid 119)
        id A24F01A00A8; Fri, 17 Jun 2022 15:35:52 +1000 (AEST)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,
        RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
Received: from donald.themaw.net (180-150-90-198.b4965a.per.nbn.aussiebb.net [180.150.90.198])
        by smtp03.aussiebb.com.au (Postfix) with ESMTP id 20BF11A009C;
        Fri, 17 Jun 2022 15:35:52 +1000 (AEST)
Subject: [PATCH 5/6] autofs: remove unused ino field inode
From:   Ian Kent <raven@themaw.net>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Fri, 17 Jun 2022 13:35:51 +0800
Message-ID: <165544415191.250070.12106625168524302864.stgit@donald.themaw.net>
In-Reply-To: <165544393032.250070.3426550720222448062.stgit@donald.themaw.net>
References: <165544393032.250070.3426550720222448062.stgit@donald.themaw.net>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Remove the unused inode field of the autofs dentry info
structure.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/autofs/autofs_i.h |    2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/autofs/autofs_i.h b/fs/autofs/autofs_i.h
index 0117d6e06300..d5a44fa88acf 100644
--- a/fs/autofs/autofs_i.h
+++ b/fs/autofs/autofs_i.h
@@ -51,8 +51,6 @@ extern struct file_system_type autofs_fs_type;
  */
 struct autofs_info {
 	struct dentry	*dentry;
-	struct inode	*inode;
-
 	int		flags;
 
 	struct completion expire_complete;


