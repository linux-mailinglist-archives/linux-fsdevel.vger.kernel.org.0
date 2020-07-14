Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78F6021FC6E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jul 2020 21:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731375AbgGNTJL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jul 2020 15:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731336AbgGNTJJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jul 2020 15:09:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A21C08C5DB;
        Tue, 14 Jul 2020 12:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=yJQCyMU4QC5CM8QEcB7EPBUPjYJdK3zPx0qGOqwbmg8=; b=X5kDtG7t0cVUXd3x+ntU2rSZaQ
        nRa8O3DwFc0O1+fz/SUO41onJfg43Fj19YkdOtYRdFPV1uaLLoSmJwQzemuooBpOMFNf7nJUpHg5Q
        GxVKJthb5kcEW/ScCD4aHS05dpTrkIPoqe4Qk4Z73VbgLD+V0il0Sa9R0h2Inx/0y0ETD4LyEkiqV
        MYDEm9yhHgA+Ons2x8A2D4jt2467P4MO5mf77u/0kbQ0EhMn8UOxtNTPKmqdiFlem4CcPpvklpjct
        AEQnGc24snjitsGVl1ERiAxKQ/4x/gwZhCxSZGun0bMw1Eu+5f507p7h1RH4emYoMcVHXfAkatwmU
        VqLgrocw==;
Received: from [2001:4bb8:188:5f50:f037:8cfe:627e:7028] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jvQId-0005sM-Hf; Tue, 14 Jul 2020 19:09:08 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-kernel@vger.kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>, Song Liu <song@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-raid@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 13/23] initrd: mark init_linuxrc as __init
Date:   Tue, 14 Jul 2020 21:04:17 +0200
Message-Id: <20200714190427.4332-14-hch@lst.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200714190427.4332-1-hch@lst.de>
References: <20200714190427.4332-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 init/do_mounts_initrd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/init/do_mounts_initrd.c b/init/do_mounts_initrd.c
index e4f88e9e1c0839..57ad5b2da8f5f5 100644
--- a/init/do_mounts_initrd.c
+++ b/init/do_mounts_initrd.c
@@ -56,7 +56,7 @@ static int __init early_initrd(char *p)
 }
 early_param("initrd", early_initrd);
 
-static int init_linuxrc(struct subprocess_info *info, struct cred *new)
+static int __init init_linuxrc(struct subprocess_info *info, struct cred *new)
 {
 	ksys_unshare(CLONE_FS | CLONE_FILES);
 	console_on_rootfs();
-- 
2.27.0

