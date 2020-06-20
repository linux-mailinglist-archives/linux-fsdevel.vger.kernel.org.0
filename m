Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5619202242
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Jun 2020 09:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbgFTHQ6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Jun 2020 03:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727030AbgFTHQ5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Jun 2020 03:16:57 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB7DC06174E;
        Sat, 20 Jun 2020 00:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=zhvoFDrNEPTRg/DLpmvxsJtCKvss8juTVaijR5W3qtQ=; b=Pi93NCFVto03I9bA00cz7vR+YE
        pMi+888pLOM/Z5hd16t1SqQRioDyEU2qYIaW+ADIiH39CzfTGcU83RQrPE0vcoY0ZmAA0KxI/oLjO
        nbYtaVPxa9g8Tj0R5Q6ZqjSuvbYh20Ho2FbybWSCN2hgIQBXnJIck/y94ofDDaVHJ0VM5iJauRuPc
        9qs4Me2V5kaqZ1JgwloEbBa3IlVaiNRa6ez3k3Z2naM13qELdCbLWJfgFSCxr9TvGy4MoyPw/ByL5
        W4nZI4KBQFNggKrFoVJPjozPZN+8py2tgPOWNFEDPka1ObHM06lYa5ZgkKdO7/rMZIPfVakuoA8/O
        fpzb+XKw==;
Received: from 195-192-102-148.dyn.cablelink.at ([195.192.102.148] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jmXkF-0003rJ-Gl; Sat, 20 Jun 2020 07:16:55 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 03/10] fs: remove an unused block_device_operations forward declaration
Date:   Sat, 20 Jun 2020 09:16:37 +0200
Message-Id: <20200620071644.463185-4-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200620071644.463185-1-hch@lst.de>
References: <20200620071644.463185-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/fs.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index b1c960e9b84e3a..0d282c853691a3 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1774,8 +1774,6 @@ struct dir_context {
 	loff_t pos;
 };
 
-struct block_device_operations;
-
 /* These macros are for out of kernel modules to test that
  * the kernel supports the unlocked_ioctl and compat_ioctl
  * fields in struct file_operations. */
-- 
2.26.2

