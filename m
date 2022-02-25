Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88E564C4508
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Feb 2022 13:55:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240747AbiBYMzX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Feb 2022 07:55:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235676AbiBYMzW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Feb 2022 07:55:22 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A40D18E3EC;
        Fri, 25 Feb 2022 04:54:50 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 156101F383;
        Fri, 25 Feb 2022 12:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1645793689; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=K7v2cNhEfZttrym4TA/C4zAe3x6GtkUapRVJt+XXFK4=;
        b=CSrV+17MDK+t6ZvsPjS64C1wSAmbw4HwDvNdX8n74K+jS57XlGlfnn5pziXhONkAY17txA
        DHpFuzgyNxFnLDxTgPm3uvBUB9wPtyobeQvD4ihjnLr3J4d0gYINj5Y3OFmyqlsWq21Xhc
        K41m+1JRX0PuMztAXopKanOoARDHNHk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1645793689;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=K7v2cNhEfZttrym4TA/C4zAe3x6GtkUapRVJt+XXFK4=;
        b=WQMDDJUn9uMBHuB59gDJll6gI+tPddGlRGlt2pYHmJ6jLgZty6aTcgyYprqRh8AzJIdMNn
        +D+IEq+9Mu/rzvAA==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 92A0FA3B87;
        Fri, 25 Feb 2022 12:54:48 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 341FCA05D9; Fri, 25 Feb 2022 13:54:48 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     reiserfs-devel@vger.kernel.org
Cc:     <linux-fsdevel@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Edward Shishkin <edward.shishkin@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Byron Stanoszek <gandalf@winds.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH v2] reiserfs: Deprecate reiserfs
Date:   Fri, 25 Feb 2022 13:54:45 +0100
Message-Id: <20220225125445.29942-1-jack@suse.cz>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2010; h=from:subject; bh=Gdd2dSmEmqLtoBu6wjiQ4Z7A5UpuySTnjTAtDhIu8qY=; b=owGbwMvMwME4Z+4qdvsUh5uMp9WSGJIkLrYUfLKOuN1aMGdraNS6zdGqM9VU2JwU9knv2DDLiL/R I/VqJ6MxCwMjB4OsmCLL6siL2tfmGXVtDdWQgRnEygQyhYGLUwAmYm/IwfD60pO4GbxFP0uz2O9wKN QeTXxc8P6hnTvnmRsPE1/EuodoSgRa+Hzcas+oGJUze58+i1nK0WebRH6vOF/21iKQO050ccTJS+bd 06fueCN4J+P2zHA9w7VuB+ZtjZb79rZNQdmo5s3y0/8Zv2xzr34SL7KLQ2oR1w4F7vtN/jHS4k8Ybb YGaV31aFy39yVXboI/0yYrqdjlmi9Dsps362q+uOKac0C4v49xl/aCbR1+Ot+e928MXnYgfsrFrzLh Ap2OEalhWXl58zssb2mccJLJ3OChfeJUbLXmuzWtk+J9K6adZTgQJNTs/JKnbbeZ8tOL4U9V5pq97L IN/iJfV6Fl6MTjGVvVVNloKXkCAA==
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
schedule its removal to 2025.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/reiserfs/Kconfig | 10 +++++++---
 fs/reiserfs/super.c |  2 ++
 2 files changed, 9 insertions(+), 3 deletions(-)

Changes since v1:
* Changed target year to 2025

If nobody has reasons against this, I'll send the patch to Linus during the
next merge window.

diff --git a/fs/reiserfs/Kconfig b/fs/reiserfs/Kconfig
index 8fd54ed8f844..33c8b0dd07a2 100644
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
+	  in 2025. If you are still using it, please migrate to another
+	  filesystem or tell us your usecase for reiserfs.
+
+	  Reiserfs stores not just filenames but the files themselves in a
+	  balanced tree.  Uses journalling.
 
 	  Balanced trees are more efficient than traditional file system
 	  architectural foundations.
diff --git a/fs/reiserfs/super.c b/fs/reiserfs/super.c
index 82e09901462e..a18be1a18f84 100644
--- a/fs/reiserfs/super.c
+++ b/fs/reiserfs/super.c
@@ -1652,6 +1652,8 @@ static int read_super_block(struct super_block *s, int offset)
 		return 1;
 	}
 
+	reiserfs_warning(NULL, "", "reiserfs filesystem is deprecated and "
+		"scheduled to be removed from the kernel in 2025");
 	SB_BUFFER_WITH_SB(s) = bh;
 	SB_DISK_SUPER_BLOCK(s) = rs;
 
-- 
2.31.1

