Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 875AF116C09
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2019 12:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbfLILL1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Dec 2019 06:11:27 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:60218 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727836AbfLILL1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Dec 2019 06:11:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
        In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=SvWcoJ6BsbH9Ks+KtP204mvlCaHmmdCmH4UiqWnNv/E=; b=dFHUdWvNL4eXR7ivKPDBKDs9FU
        PFCOIZXS5Sn1YvZsowemF693DdOA+HN0ulWey83GcWWrcXtRolvtNJrVtd7u1O6hBS4lp1eRYIms5
        wZfD9FSLxmi9h2/AUzi+ADgDN9XYx4jsviv72PBYyd+AvZlGFbiVgFJcI3tTzvXwNumXYKim31Sa4
        2n2Pw8mh7w9MRMFrHlgf6C+LUhtSXvchHzFETcMCbR0917jyKhRXh0sCXZr5Nb6I+v/vFKsbyU45j
        7O7XhdOyjfZAF6obWZsEIX9rvBVd+ry0QunUiKrbVM2sLHPfyFcLLTZi2SbuwgBzJ2cn6ColRIHGO
        6yDCRQYg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:54114 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1ieGwl-0002Xn-Va; Mon, 09 Dec 2019 11:11:24 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1ieGwl-0004e4-EZ; Mon, 09 Dec 2019 11:11:23 +0000
In-Reply-To: <20191209110731.GD25745@shell.armlinux.org.uk>
References: <20191209110731.GD25745@shell.armlinux.org.uk>
From:   Russell King <rmk+kernel@armlinux.org.uk>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 37/41] fs/adfs: dir: remove debug in adfs_dir_update()
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1ieGwl-0004e4-EZ@rmk-PC.armlinux.org.uk>
Date:   Mon, 09 Dec 2019 11:11:23 +0000
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Remove the noisy debug in adfs_dir_update().

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 fs/adfs/dir.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/adfs/dir.c b/fs/adfs/dir.c
index 3d4bbe836fb5..dd940f17767d 100644
--- a/fs/adfs/dir.c
+++ b/fs/adfs/dir.c
@@ -278,9 +278,6 @@ adfs_dir_update(struct super_block *sb, struct object_info *obj, int wait)
 	struct adfs_dir dir;
 	int ret;
 
-	printk(KERN_INFO "adfs_dir_update: object %06x in dir %06x\n",
-		 obj->indaddr, obj->parent_id);
-
 	if (!IS_ENABLED(CONFIG_ADFS_FS_RW))
 		return -EINVAL;
 
-- 
2.20.1

