Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D05C2597BC7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Aug 2022 05:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242912AbiHRDAI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Aug 2022 23:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242590AbiHRDAD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Aug 2022 23:00:03 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9171B7D1D7;
        Wed, 17 Aug 2022 20:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VMfn/3UTi+5xfs9vQsw6e6I9yGzn/hW4ZTjpTnY2k1M=; b=nhOpdEHaP/T/M+W1ck+7V24SmY
        YZAbw3frWl0JxwHqSAhez8AumyaJXk1r1rHtRvATkjvyXHjXPbPz8ehdW11ClRehKIfE8+mf72nv0
        VtBpXlL7mRAmHTCA4LesTy6ySSfFxDVEYv0XzP/tf/83eBEoiPLeEy+JiSqfbit5xg+CUcU8heXSX
        EaNXkzJX9VhTs0iQGBx9hXWMNCdGRKI0sEYFNd/H8sxtE/V1O8UxuqHYg1YNWhUl6ZWkQAYUm5b+o
        Fptw4VuQKl8dgk69wjUP1jgBPnYS4cde/xci0t/nvIsNybaX/2t51EfFQOH0xoj7NR4t5WhHKVBEq
        SipqjgCQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oOVlG-005acZ-O2;
        Thu, 18 Aug 2022 02:59:58 +0000
Date:   Thu, 18 Aug 2022 03:59:58 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] d_path.c: typo fix...
Message-ID: <Yv2rLgc9NruwfwR6@ZenIV>
References: <Yv2qoNQg48rtymGE@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yv2qoNQg48rtymGE@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/d_path.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/d_path.c b/fs/d_path.c
index ce8d9d49e1e7..56a6ee4c6331 100644
--- a/fs/d_path.c
+++ b/fs/d_path.c
@@ -34,7 +34,7 @@ static bool prepend_char(struct prepend_buffer *p, unsigned char c)
 }
 
 /*
- * The source of the prepend data can be an optimistoc load
+ * The source of the prepend data can be an optimistic load
  * of a dentry name and length. And because we don't hold any
  * locks, the length and the pointer to the name may not be
  * in sync if a concurrent rename happens, and the kernel
-- 
2.30.2

