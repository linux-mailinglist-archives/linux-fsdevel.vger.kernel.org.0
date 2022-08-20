Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1466D59AF61
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Aug 2022 20:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbiHTSNG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Aug 2022 14:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbiHTSNA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Aug 2022 14:13:00 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3FD840569
        for <linux-fsdevel@vger.kernel.org>; Sat, 20 Aug 2022 11:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:
        Cc:Content-Type:Content-ID:Content-Description;
        bh=+W0KS5ROUeLrBh/HkPoJVfJyzYvD8APwjVebUYBtlSs=; b=bXkUtWUej/PmYeEij9iJRrc6w7
        nFi4AKvEnRm3HhICSnelU3k3D71uqvbVlRrddLSjO5c2QLRxJcAgkWjwo4Tn6QN19BG2k8ehEhY0g
        SW9nSFt99f5Ty9QoUze8uqzTUhPlZP2O7rF0KPJHYCgRozk9xhrTCpy2THkxMdfzWJjTNlcz7VO4u
        GuiPy5chPlCQQqYLqOVKPlXhwISOs5Pcwh48V6tIOhPA+OVWlD3RoY/awgBFTK0FBFH2N4pv4e+t/
        K05JxGG25r3Whu1uXhHDBnKGdOndiPnh3pYbOZ855w/5ouqd78YT6TGqutSJ9BQdHVtx2HupXaJxQ
        ovHZahdQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oPSxt-006RVw-6p
        for linux-fsdevel@vger.kernel.org;
        Sat, 20 Aug 2022 18:12:57 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 07/11] __io_setxattr(): constify path
Date:   Sat, 20 Aug 2022 19:12:52 +0100
Message-Id: <20220820181256.1535714-6-viro@zeniv.linux.org.uk>
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
 io_uring/xattr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/io_uring/xattr.c b/io_uring/xattr.c
index 84180afd090b..99df641594d7 100644
--- a/io_uring/xattr.c
+++ b/io_uring/xattr.c
@@ -206,7 +206,7 @@ int io_fsetxattr_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 }
 
 static int __io_setxattr(struct io_kiocb *req, unsigned int issue_flags,
-			struct path *path)
+			const struct path *path)
 {
 	struct io_xattr *ix = io_kiocb_to_cmd(req, struct io_xattr);
 	int ret;
-- 
2.30.2

