Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65650279827
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Sep 2020 11:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728736AbgIZJVA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 26 Sep 2020 05:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbgIZJU7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 26 Sep 2020 05:20:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE55AC0613CE
        for <linux-fsdevel@vger.kernel.org>; Sat, 26 Sep 2020 02:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=3saE7l6HWDiZo45mWuSofEheDtd0Y321gzyatxFdI5Y=; b=XEqJqv/nbXwD4R84bWmYAJRZfj
        YAwQ7BZzhxKBcF1ah/DPabOxvcG4dYA1NRgYXTcEQIN2ItUNVibPV4XABgwn60jXRxqKmEqaRgsiB
        EeAQOyXx06nhLs+701j/ibPDmb4NhVTVG3y7ECIy6CfNeGOdlPbG3KKwD8jRJSP02ztfw8jzjgnvY
        06gYXoAYDSiaxMX8YVxy0mdz5lbfE+Mrz43glV9xSnARe2s6yI/3A2zeldsJmzV2kCduPCLcBGZGB
        Cea7htBQAej1VNyUdxRPB8++dZtnlrBfifz6ZMIcJmQfbYZaB3tf/Xq4d6WUtXCF7yPl8gd8DvnHX
        wmX0iWoQ==;
Received: from [46.189.67.162] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kM6O1-0002Fc-Du; Sat, 26 Sep 2020 09:20:57 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/4] fs: mark filename_lookup static
Date:   Sat, 26 Sep 2020 11:20:49 +0200
Message-Id: <20200926092051.115577-3-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200926092051.115577-1-hch@lst.de>
References: <20200926092051.115577-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/internal.h | 2 --
 fs/namei.c    | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/internal.h b/fs/internal.h
index 10517ece45167f..695e12bc285061 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -71,8 +71,6 @@ extern int finish_clean_context(struct fs_context *fc);
 /*
  * namei.c
  */
-extern int filename_lookup(int dfd, struct filename *name, unsigned flags,
-			   struct path *path, struct path *root);
 extern int vfs_path_lookup(struct dentry *, struct vfsmount *,
 			   const char *, unsigned int, struct path *);
 long do_rmdir(int dfd, struct filename *name);
diff --git a/fs/namei.c b/fs/namei.c
index e99e2a9da0f7de..7963f97a130442 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2351,7 +2351,7 @@ static int path_lookupat(struct nameidata *nd, unsigned flags, struct path *path
 	return err;
 }
 
-int filename_lookup(int dfd, struct filename *name, unsigned flags,
+static int filename_lookup(int dfd, struct filename *name, unsigned flags,
 		    struct path *path, struct path *root)
 {
 	int retval;
-- 
2.28.0

