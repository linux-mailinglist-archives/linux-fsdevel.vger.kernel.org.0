Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2E72E6DAA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Dec 2020 04:50:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbgL2Drx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Dec 2020 22:47:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbgL2Drx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Dec 2020 22:47:53 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C92C0613D6;
        Mon, 28 Dec 2020 19:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=RedTUtIjGhG4AmJd2GEF4MWnXynmfasXBBr+DXe3kuA=; b=b4trqZvnXArxzRmmmJWgM+sHps
        r2CZewrX4R1XFWkVycsEoek+Xm4vHmuo0VMsbDOuZkA/iP/PQxfd2KCY9kLWqUHX+rE36ikRjeipB
        ulLSx/8MXJezLuT4qeEPQi1iX2kuBMbJlVIEEtPuoztchXOoRWjxwdTz5hRgPyIAVTVXEM/9lIzM5
        bExrVV9VbsFGCtCAuaL+BEQXV6ivMSNsjcwi0p1j/ZU5M70+sFx5QksZnPEiry3l7+gXwJplh8MrX
        wPIAXwPeFspFJTUMPV3s8bnk7eiuLx17ryrsaDmwpMqb3Elt4mogkrHowXLakZ6qSB7wZ0Z6A16S0
        3gw8g0LA==;
Received: from [2601:1c0:6280:3f0::2c43] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ku5yY-0000CP-Ez; Tue, 29 Dec 2020 03:47:11 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH] fs: block_dev.c: fix kernel-doc warnings from struct block_device changes
Date:   Mon, 28 Dec 2020 19:47:06 -0800
Message-Id: <20201229034706.30399-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix new kernel-doc warnings in fs/block_dev.c:

../fs/block_dev.c:1066: warning: Excess function parameter 'whole' description in 'bd_abort_claiming'
../fs/block_dev.c:1837: warning: Function parameter or member 'dev' not described in 'lookup_bdev'

Fixes: 4e7b5671c6a8 ("block: remove i_bdev")
Fixes: 37c3fc9abb25 ("block: simplify the block device claiming interface")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>
Cc: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
---
 fs/block_dev.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- lnx-511-rc1.orig/fs/block_dev.c
+++ lnx-511-rc1/fs/block_dev.c
@@ -1055,7 +1055,6 @@ static void bd_finish_claiming(struct bl
 /**
  * bd_abort_claiming - abort claiming of a block device
  * @bdev: block device of interest
- * @whole: whole block device
  * @holder: holder that has claimed @bdev
  *
  * Abort claiming of a block device when the exclusive open failed. This can be
@@ -1828,6 +1827,7 @@ const struct file_operations def_blk_fop
 /**
  * lookup_bdev  - lookup a struct block_device by name
  * @pathname:	special file representing the block device
+ * @dev:	return value of the block device's dev_t
  *
  * Get a reference to the blockdevice at @pathname in the current
  * namespace if possible and return it.  Return ERR_PTR(error)
