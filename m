Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2C064C1569
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Feb 2022 15:27:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241554AbiBWO1i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Feb 2022 09:27:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241562AbiBWO1e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Feb 2022 09:27:34 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FC8F4B436;
        Wed, 23 Feb 2022 06:26:59 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 825661F37D;
        Wed, 23 Feb 2022 14:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1645626418; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=pR07zPggnhMWs7XNN5OSmOsV4p9ufjmxXD7Z/qh4kZI=;
        b=rN2v4SgVCwDKqgM/XnW7NzZOfMm9JjlVY9dPHBlp4QpsuYZcYZp+7rFQxp8gkbWDlzUTuv
        1KcYGXAzb+lMVq9QUoCZzb/bK8Hgg1UXeLQ1AwaPuT8yxz6CierjQYFpgyhP+qe91Y6aJc
        VzFkAYF+QdpKmYU75p3G8TUDUlH+m+8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1645626418;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=pR07zPggnhMWs7XNN5OSmOsV4p9ufjmxXD7Z/qh4kZI=;
        b=v5vNwpkCJDIF2jIj75K2OQkEN3ebk8jbXjWlKR2xTITqqhqR/cWY5+BGIMCy2e1HhfD1ew
        5VI6YZOxogmhC8Bw==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 738AFA3B88;
        Wed, 23 Feb 2022 14:26:58 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 20BBEA0605; Wed, 23 Feb 2022 15:26:58 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     reiserfs-devel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>,
        Edward Shishkin <edward.shishkin@gmail.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH] reiserfs: Deprecate reiserfs
Date:   Wed, 23 Feb 2022 15:26:53 +0100
Message-Id: <20220223142653.22388-1-jack@suse.cz>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2005; h=from:subject; bh=FP0CgiLVUL8DHi7DJ11ofsrTMuHPGmOsdQMd1JKiYB4=; b=owGbwMvMwME4Z+4qdvsUh5uMp9WSGJLEXNT+nZ6oZKYdzGV5+oaBhVj+zMlc7fdCLrPfFU/6cs9r guuZTkZjFgZGDgZZMUWW1ZEXta/NM+raGqohAzOIlQlkCgMXpwBMpHMGB8NyhfnuRqaZ3WxXP4jycS b8CLNmbl5Xu/iWWwUXi0+fDO+0Cv110ifWzX20Z0qMzu6TB9PYD6jvb8pf4PfBp0dqcoVcT+L7namR yyJ1mpK96h+d976V2NDQ6i016YdmiedkiyPC/xu+9wVEf3XWObS+cynD3bs2mdJWKR0mpbfOO+q8tr hgfivl/JUPDr1PhbccsHbhSHx6e+YRviOxST/q9/VoLD6TlOLLdGtFiNsBx517566zamx/Fm27obSL WXCFzgSRPymd2+dOSrn4IWbOA0VWp1WPShprxIXKU6bIydi4dss7irisYGlh+zJ3rg9b9adZXhFKRk qeTBGb5UULjjw7LXn2c13r3xBJAA==
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Reiserfs is relatively old filesystem and its development has ceased
quite some years ago. Linux distributions moved away from it towards
other filesystems such as btrfs, xfs, or ext4. To reduce maintenance
burden on cross filesystem changes (such as new mount API, iomap, folios
...) let's add a deprecation notice when the filesystem is mounted and
schedule its removal to 2024.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/reiserfs/Kconfig | 10 +++++++---
 fs/reiserfs/super.c |  2 ++
 2 files changed, 9 insertions(+), 3 deletions(-)

Here's my suggestion for deprecating reiserfs. If nobody has reasons against
this, I'll send the patch to Linus during the next merge window.

diff --git a/fs/reiserfs/Kconfig b/fs/reiserfs/Kconfig
index 8fd54ed8f844..eafee53ddabc 100644
--- a/fs/reiserfs/Kconfig
+++ b/fs/reiserfs/Kconfig
@@ -1,10 +1,14 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config REISERFS_FS
-	tristate "Reiserfs support"
+	tristate "Reiserfs support (deprecated)"
 	select CRC32
 	help
-	  Stores not just filenames but the files themselves in a balanced
-	  tree.  Uses journalling.
+	  Reiserfs is deprecated and scheduled to be removed from the kernel
+	  in 2024. If you are still using it, please migrate to another
+	  filesystem or tell us your usecase for reiserfs.
+
+	  Reiserfs stores not just filenames but the files themselves in a
+	  balanced tree.  Uses journalling.
 
 	  Balanced trees are more efficient than traditional file system
 	  architectural foundations.
diff --git a/fs/reiserfs/super.c b/fs/reiserfs/super.c
index 82e09901462e..74c1cda3bc3e 100644
--- a/fs/reiserfs/super.c
+++ b/fs/reiserfs/super.c
@@ -1652,6 +1652,8 @@ static int read_super_block(struct super_block *s, int offset)
 		return 1;
 	}
 
+	reiserfs_warning(NULL, "", "reiserfs filesystem is deprecated and "
+		"scheduled to be removed from the kernel in 2024");
 	SB_BUFFER_WITH_SB(s) = bh;
 	SB_DISK_SUPER_BLOCK(s) = rs;
 
-- 
2.31.1

