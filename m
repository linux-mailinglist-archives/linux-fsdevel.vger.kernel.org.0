Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16597230F9D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jul 2020 18:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731657AbgG1Qej (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jul 2020 12:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731639AbgG1Qee (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jul 2020 12:34:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51084C061794;
        Tue, 28 Jul 2020 09:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=5ausAPzJBw65SvXJtTUcDFc6/CyC0IVS3xPiH8Dsuds=; b=hBpIpczwjaISTmxsuvMLXTNxcS
        UUbp10kKnqd9lxwWwxQQ26OZzJ6b0D9nmdLlal0/WJBDRGK8/Tc2XQ48lyXyyZfeBWGmJgoq9z2UY
        CfY9vdB8UWs280ZtvyNIpezcxUTqfml422rg3mS/zQXTKjzDqM1zBc6Wzuwm/WGA3yRx09A9T8e/E
        snR1EClA7EHAqBbZDs6LyKb380Lzs1fISJ0WBOVPQcCnQyigYJ/KUDFA3F8oCiniC+2dkv6WjxYX9
        U6HDU3EDX1dsgG/zJ5P7ofGrIinTxuji1Q82nNMaePhn58dhGKFu8o4LVWxT+aI6Ld6z790kPewih
        Zgk+zxhg==;
Received: from [2001:4bb8:180:6102:fd04:50d8:4827:5508] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k0SYe-0006xi-Go; Tue, 28 Jul 2020 16:34:29 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH 07/23] init: mark create_dev as __init
Date:   Tue, 28 Jul 2020 18:34:00 +0200
Message-Id: <20200728163416.556521-8-hch@lst.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200728163416.556521-1-hch@lst.de>
References: <20200728163416.556521-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This helper is only used for the early init code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 init/do_mounts.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/init/do_mounts.h b/init/do_mounts.h
index c855b3f0e06d19..021e2f60223e25 100644
--- a/init/do_mounts.h
+++ b/init/do_mounts.h
@@ -13,7 +13,7 @@ void  mount_block_root(char *name, int flags);
 void  mount_root(void);
 extern int root_mountflags;
 
-static inline int create_dev(char *name, dev_t dev)
+static inline __init int create_dev(char *name, dev_t dev)
 {
 	ksys_unlink(name);
 	return ksys_mknod(name, S_IFBLK|0600, new_encode_dev(dev));
-- 
2.27.0

