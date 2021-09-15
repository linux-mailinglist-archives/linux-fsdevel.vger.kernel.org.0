Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBB2F40CBA2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Sep 2021 19:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbhIORY3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Sep 2021 13:24:29 -0400
Received: from sandeen.net ([63.231.237.45]:33378 "EHLO sandeen.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230231AbhIORYY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Sep 2021 13:24:24 -0400
Received: by sandeen.net (Postfix, from userid 500)
        id AB44579F9; Wed, 15 Sep 2021 12:22:53 -0500 (CDT)
From:   Eric Sandeen <sandeen@redhat.com>
To:     linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     dan.j.williams@intel.com
Subject: [PATCH 3/3] ext2: remove dax EXPERIMENTAL warning
Date:   Wed, 15 Sep 2021 12:22:41 -0500
Message-Id: <1631726561-16358-4-git-send-email-sandeen@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1631726561-16358-1-git-send-email-sandeen@redhat.com>
References: <1631726561-16358-1-git-send-email-sandeen@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

As there seems to be no significant outstanding concern about
dax on ext2 at this point, remove the scary EXPERIMENTAL
warning when in use.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---
 fs/ext2/super.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/ext2/super.c b/fs/ext2/super.c
index d8d580b..1915733 100644
--- a/fs/ext2/super.c
+++ b/fs/ext2/super.c
@@ -587,8 +587,6 @@ static int parse_options(char *options, struct super_block *sb,
 			fallthrough;
 		case Opt_dax:
 #ifdef CONFIG_FS_DAX
-			ext2_msg(sb, KERN_WARNING,
-		"DAX enabled. Warning: EXPERIMENTAL, use at your own risk");
 			set_opt(opts->s_mount_opt, DAX);
 #else
 			ext2_msg(sb, KERN_INFO, "dax option not supported");
-- 
1.8.3.1

