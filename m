Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8D4B3D83DC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jul 2021 01:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233328AbhG0XWO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jul 2021 19:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232706AbhG0XWO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jul 2021 19:22:14 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2536C061757;
        Tue, 27 Jul 2021 16:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=2HDi405ftQx4oxwU8i6bV8dNlvvWxLGeuu9TQjwiYKI=; b=u18mSDm1N3SnnMkJ9lzA3t/TNA
        6YxSK7S+XjpE/uG/89PHH4jMmO0BoGS2Gt4VyFYfdA4n0keJ4NniVK2po6aZ+4WLAm+JQANujmoiK
        E7av4jTWOhO3N+P9lbvbzy7NdKKgTMlh8Fc6NgSEQK6cBk+HesaF3XZC/9vKYMo4mxMkfRs38OWFw
        v5JV26KWM4m46tzHNniPkesQIx7sxxc1QedkEyv05Bl3d/cvYpTvb4LTEH4ounp5Vy8FkEv5r/aJR
        6WlZc7/7RJX+Pzv+4GeVvHJBiURWu/X24V79ckBzcjUUQyD14rOwZEkaRDXKeR/5eywL6aB/iW5V/
        a2iy1N1A==;
Received: from [2601:1c0:6280:3f0::aefb] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m8WOq-00GeGN-VD; Tue, 27 Jul 2021 23:22:13 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH -next] filesystems/locking: fix Malformed table warning
Date:   Tue, 27 Jul 2021 16:22:12 -0700
Message-Id: <20210727232212.12510-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Update the bottom border to be the same as the top border.

Documentation/filesystems/locking.rst:274: WARNING: Malformed table.
Bottom/header table border does not match top border.

Fixes: 730633f0b7f9 ("mm: Protect operations adding pages to page cache with invalidate_lock")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Darrick J. Wong <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org
---
 Documentation/filesystems/locking.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linext-20210727.orig/Documentation/filesystems/locking.rst
+++ linext-20210727/Documentation/filesystems/locking.rst
@@ -295,7 +295,7 @@ is_partially_uptodate:	yes
 error_remove_page:	yes
 swap_activate:		no
 swap_deactivate:	no
-======================	======================== =========
+======================	======================== =========	===============
 
 ->write_begin(), ->write_end() and ->readpage() may be called from
 the request handler (/dev/loop).
