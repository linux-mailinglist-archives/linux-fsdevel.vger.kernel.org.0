Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8B4159FF6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 05:19:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728222AbgBLETR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Feb 2020 23:19:17 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:53914 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727972AbgBLESr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Feb 2020 23:18:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Ar2j50GYs9J9BaYFHSXaQwTgcbYxh2+e3nItv/JisDg=; b=q+ARYIkzqoV0EJate98vASh97q
        PAPLu29G/dVnmGW7ZtdxE3PfJDAhe+wPW54riDrYkchOXlSxW6L5OpWb1aUtWrmytruLUDQdZ+Ra9
        5fAeEVdmOr7W5O2E/UwdBPHneBERnjwgf+T0asiJA7QPtKN4mPH/kiXG6l50XLMNbo+cX84geZMps
        0OfMo8pMcPhDlZt+upvImJ5SXA27gBcxt1ozyfKx190UbW7DMVCXKAMM9fqm7zIIpCXgZYMCMABjW
        F/HmewLt4yINlc5w+FN8BzD4dEdCW08w3SGCR9ozhFdcOy4Mjp07JhxAu45NVvbeWFZ0hKV7tZX5D
        0e62MobA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j1jU6-0006nH-RF; Wed, 12 Feb 2020 04:18:46 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 09/25] fs: Add a filesystem flag for large pages
Date:   Tue, 11 Feb 2020 20:18:29 -0800
Message-Id: <20200212041845.25879-10-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200212041845.25879-1-willy@infradead.org>
References: <20200212041845.25879-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

The page cache needs to know whether the filesystem supports pages >
PAGE_SIZE.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/fs.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index d4e2d2964346..24e720723afb 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2235,6 +2235,7 @@ struct file_system_type {
 #define FS_HAS_SUBTYPE		4
 #define FS_USERNS_MOUNT		8	/* Can be mounted by userns root */
 #define FS_DISALLOW_NOTIFY_PERM	16	/* Disable fanotify permission events */
+#define FS_LARGE_PAGES		8192	/* Remove once all fs converted */
 #define FS_RENAME_DOES_D_MOVE	32768	/* FS will handle d_move() during rename() internally. */
 	int (*init_fs_context)(struct fs_context *);
 	const struct fs_parameter_spec *parameters;
-- 
2.25.0

