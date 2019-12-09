Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BBD21165D3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2019 05:31:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbfLIEbg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Dec 2019 23:31:36 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:43760 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbfLIEbg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Dec 2019 23:31:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7JtStz51Gr+rZZ82hfvvq2BfQOzhimbE4jfRchOPwQo=; b=XGGDe5M8XjzbxFK+h0fjsI6+o
        qUIz62uT9k+rDpHVL4gX3JZe0EB5mYsqbcLOVveID27nSgPuU71qQWhCzN0InbyisOwknAVLUmMlm
        wmjiy7qD6k3JpG0K7YVKBfvgNvyS1aJJuDFBvm2pqrLz9j5Yu3AI1c+nRHeuSvuTY8lVqZRY6gROg
        veOBaLGwKR/hbliKzGjZLFMTTGc9Oj4+ImwhPYhH1ogvtq9CWcWilHlAXkcruT4nPhEG40mtFEbW5
        FlT+7KWOsxfUmGrpW6lx4ud5d4JdNUUPviwmFcBrEmPYZI1yE5hdIjnaIndXe0h534lZRPebG4yxC
        HWXjpCuCg==;
Received: from [2601:1c0:6280:3f0::3deb]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ieAhp-0002JF-KC; Mon, 09 Dec 2019 04:31:33 +0000
To:     Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
Cc:     Jan Kara <jack@suse.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] jbd2: fix kernel-doc notation warning
Message-ID: <53e3ce27-ceae-560d-0fd4-f95728a33e12@infradead.org>
Date:   Sun, 8 Dec 2019 20:31:32 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix kernel-doc warning by inserting a beginning '*' character
for the kernel-doc line.

../include/linux/jbd2.h:461: warning: bad line:         journal. These are dirty buffers and revoke descriptor blocks.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: "Theodore Ts'o" <tytso@mit.edu>
Cc: Jan Kara <jack@suse.com>
Cc: linux-ext4@vger.kernel.org
---
 include/linux/jbd2.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20191209.orig/include/linux/jbd2.h
+++ linux-next-20191209/include/linux/jbd2.h
@@ -457,7 +457,7 @@ struct jbd2_revoke_table_s;
  * @h_journal: Which journal handle belongs to - used iff h_reserved set.
  * @h_rsv_handle: Handle reserved for finishing the logical operation.
  * @h_total_credits: Number of remaining buffers we are allowed to add to
-	journal. These are dirty buffers and revoke descriptor blocks.
+ *	journal. These are dirty buffers and revoke descriptor blocks.
  * @h_revoke_credits: Number of remaining revoke records available for handle
  * @h_ref: Reference count on this handle.
  * @h_err: Field for caller's use to track errors through large fs operations.

