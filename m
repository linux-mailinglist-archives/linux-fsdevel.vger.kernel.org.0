Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 321B877498E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Aug 2023 21:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233982AbjHHT6k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Aug 2023 15:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234007AbjHHT61 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Aug 2023 15:58:27 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE681D3C4
        for <linux-fsdevel@vger.kernel.org>; Tue,  8 Aug 2023 11:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=z99vejQrYnh280BqLPf2fu2s8FYWFdpYIhVk1ySQv6Q=; b=CClPYNfQtS4oWveVFR3yBqGvxW
        wiWj7zgkcFINXOdVx5fO7vOjRn4ZMy1x/NOOn9KlkNe2WpDUQ/r7zr//ZVuldzlsRWyX8etEbN26o
        Q8GgaJGiIGNYmKyV8LC3L0hSCtNrTfIrDLsS/pZkkoV1r1RKZMYDgPAqICsdu5E2oFsYxqlFrHSqh
        D1f+30OMBZ4sou0ayOb86e6GvIs7C0iuG1a3Yn7W3WdliRKR9Q9exUQlZS+yKveb0OeQq150R4/vh
        yAJ8vvk2EVgIWrX9fmF+S5c4dzGipDtz9GqAcITI9k7sO+2A5/Ph9iEspUMZFRTRdtpe7XHmucYVh
        F3vgqUHw==;
Received: from [4.28.11.157] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qTPOK-002vuM-15;
        Tue, 08 Aug 2023 16:17:04 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     viro@zeniv.linux.org.uk, brauner@kernel.org
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH] fs: unexport d_genocide
Date:   Tue,  8 Aug 2023 09:17:04 -0700
Message-Id: <20230808161704.1099680-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

d_genocide is only used by built-in code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/dcache.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 52e6d5fdab6bdf..3aaf2c7ba110d9 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -3247,8 +3247,6 @@ void d_genocide(struct dentry *parent)
 	d_walk(parent, parent, d_genocide_kill);
 }
 
-EXPORT_SYMBOL(d_genocide);
-
 void d_tmpfile(struct file *file, struct inode *inode)
 {
 	struct dentry *dentry = file->f_path.dentry;
-- 
2.39.2

