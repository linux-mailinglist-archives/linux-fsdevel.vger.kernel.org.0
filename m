Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB5422DCD0
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Jul 2020 09:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbgGZHOU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Jul 2020 03:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726983AbgGZHOO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Jul 2020 03:14:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6B07C0619D2;
        Sun, 26 Jul 2020 00:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=ZuZ/SdZzB0ko5r0fSihAOxEKK6BOgCA9LTHvaexH0CA=; b=OjQHMDU/IkzMnz8G7WC1Ow2196
        16oNC020F5af4CIDIz03OStZQgB6nsVptDACuowF2SpdEWZQ7Me2TmCqNzYl8Dj2Zv6x8oiHjP9hV
        opYmXnGUtHv8ZvQL80V8rT9F7FTHYTbFzR0GEHp/lGOIc/xZDg+nqqXHnyAsmR0Ue8OEQ4qBb29qj
        iujSTBeSP0KRNMtZTUflhHvuNpjy2+SHouCnsg8rSf9BS8rS7JmDfJs5JcoQm1wNnApI6K2AIFlsx
        Owo+mqlVcqUz2XFdz2Rr6PMNtnprqgERPgXnwF7R0zBZuzbLK/Qk13eqGxsKJ/avOBK60POPvc6ZI
        4SzEzjfQ==;
Received: from [2001:4bb8:18c:2acc:5ff1:d0b0:8643:670e] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jzarJ-0002PQ-Jn; Sun, 26 Jul 2020 07:14:10 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH 06/21] init: mark create_dev as __init
Date:   Sun, 26 Jul 2020 09:13:41 +0200
Message-Id: <20200726071356.287160-7-hch@lst.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200726071356.287160-1-hch@lst.de>
References: <20200726071356.287160-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The helper is only used for the early init code.

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

