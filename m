Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE4EC7A9B4D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Sep 2023 20:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbjIUS5W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Sep 2023 14:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbjIUS5B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Sep 2023 14:57:01 -0400
Received: from smtp01.aussiebb.com.au (smtp01.aussiebb.com.au [IPv6:2403:5800:3:25::1001])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F8938ED43;
        Thu, 21 Sep 2023 11:51:05 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by smtp01.aussiebb.com.au (Postfix) with ESMTP id 8F65910057C;
        Thu, 21 Sep 2023 17:03:52 +1000 (AEST)
X-Virus-Scanned: Debian amavisd-new at smtp01.aussiebb.com.au
Received: from smtp01.aussiebb.com.au ([127.0.0.1])
        by localhost (smtp01.aussiebb.com.au [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id eCRW0MMXS3Y8; Thu, 21 Sep 2023 17:03:52 +1000 (AEST)
Received: by smtp01.aussiebb.com.au (Postfix, from userid 116)
        id 8835810057F; Thu, 21 Sep 2023 17:03:52 +1000 (AEST)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
Received: from donald.themaw.net (180-150-90-198.b4965a.per.nbn.aussiebb.net [180.150.90.198])
        by smtp01.aussiebb.com.au (Postfix) with ESMTP id BC87F100265;
        Thu, 21 Sep 2023 17:03:51 +1000 (AEST)
Subject: [PATCH 4/8] autofs: reformat 0pt enum declaration
From:   Ian Kent <raven@themaw.net>
To:     Al Viro <viro@ZenIV.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     autofs mailing list <autofs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bill O'Donnell <billodo@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        David Howells <dhowells@redhat.com>
Date:   Thu, 21 Sep 2023 15:03:51 +0800
Message-ID: <169527983132.27328.10535655381168506781.stgit@donald.themaw.net>
In-Reply-To: <169527971702.27328.16272807830250040704.stgit@donald.themaw.net>
References: <169527971702.27328.16272807830250040704.stgit@donald.themaw.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The enum of options is only reformated in the patch to convert autofs
to use the mount API so do that now to simplify the conversion patch.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/autofs/inode.c |   17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/fs/autofs/inode.c b/fs/autofs/inode.c
index 992d6cb29707..d2b333c0682a 100644
--- a/fs/autofs/inode.c
+++ b/fs/autofs/inode.c
@@ -110,9 +110,20 @@ static const struct super_operations autofs_sops = {
 	.evict_inode	= autofs_evict_inode,
 };
 
-enum {Opt_err, Opt_fd, Opt_uid, Opt_gid, Opt_pgrp, Opt_minproto, Opt_maxproto,
-	Opt_indirect, Opt_direct, Opt_offset, Opt_strictexpire,
-	Opt_ignore};
+enum {
+	Opt_err,
+	Opt_direct,
+	Opt_fd,
+	Opt_gid,
+	Opt_ignore,
+	Opt_indirect,
+	Opt_maxproto,
+	Opt_minproto,
+	Opt_offset,
+	Opt_pgrp,
+	Opt_strictexpire,
+	Opt_uid,
+};
 
 static const match_table_t tokens = {
 	{Opt_fd, "fd=%u"},


