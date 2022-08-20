Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A46AE59AF63
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Aug 2022 20:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbiHTSNJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Aug 2022 14:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbiHTSNA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Aug 2022 14:13:00 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D5840BC0
        for <linux-fsdevel@vger.kernel.org>; Sat, 20 Aug 2022 11:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:
        Cc:Content-Type:Content-ID:Content-Description;
        bh=MAve7KVmRdiKHmJf3UUFc8wn2WVQXszHunTAYCfUdlw=; b=Dz2vrz9WHm/UACWA60udqhiuXr
        MxzhXF/MuF7EqsKCc1YMDA/du5jkMdK6B238xv1eo5hEzSCsAmiKA6XVMpUHOOyEQYhG33traPgHc
        rD1sU/UI1iVSxbg78eyrcgIYyAaL6e4VTgOhu2J08wrVkggWuJQA0XgQlDz2l9PetgxcRK2QVXIbU
        dSe4eyQaQlp26NSissuGOS8lpl8ua5iVwmPdEr1gbLtJ582g1iJPrdcin8OK0kta9HbCB3QPxn+4R
        W5/qGVssBkUOEzrDe6v9WgBREjhodv6dmjd91/EhGNONWPPuMSdZJzhI6PjFq9tBvx47XH9geVjJb
        S9mEpkTA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oPSxt-006RW0-CS
        for linux-fsdevel@vger.kernel.org;
        Sat, 20 Aug 2022 18:12:57 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 08/11] audit_init_parent(): constify path
Date:   Sat, 20 Aug 2022 19:12:53 +0100
Message-Id: <20220820181256.1535714-7-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220820181256.1535714-1-viro@zeniv.linux.org.uk>
References: <YwEjnoTgi7K6iijN@ZenIV>
 <20220820181256.1535714-1-viro@zeniv.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 kernel/audit_watch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/audit_watch.c b/kernel/audit_watch.c
index 4b0957aa2cd4..65075f1e4ac8 100644
--- a/kernel/audit_watch.c
+++ b/kernel/audit_watch.c
@@ -133,7 +133,7 @@ int audit_watch_compare(struct audit_watch *watch, unsigned long ino, dev_t dev)
 }
 
 /* Initialize a parent watch entry. */
-static struct audit_parent *audit_init_parent(struct path *path)
+static struct audit_parent *audit_init_parent(const struct path *path)
 {
 	struct inode *inode = d_backing_inode(path->dentry);
 	struct audit_parent *parent;
-- 
2.30.2

