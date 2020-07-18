Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E306224822
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jul 2020 04:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728127AbgGRCyT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jul 2020 22:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbgGRCyT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jul 2020 22:54:19 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0669CC0619D2;
        Fri, 17 Jul 2020 19:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:To:Subject:From:Sender:Reply-To:Cc:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=Fuh8EMBNZiN9cOq2YFJghBp1zuZaExWQbdGYTJj/bUc=; b=SM4/IitUYHHfhcuVLGS/u0AQY7
        9VWeLlkWQvNPdROl/xckHi3Ju3wEor7kYppMZxsJO3awvh7nNHYkjFJ7HHQSwyOSgx/0r4V0eHwTC
        BU/Agmp9CYB68EcConetRZ9g4Nmg7jufzrGZ75cwfsObJH/DFe2NLQx6XGnt7zXtIP/5xFnGua7cQ
        HTmvEefC14FOlQ0Raut8c59kAJemYrgoTvJ9TaWWsU8VNSuZ5+YEWwOFWwgpBg76poXogrvrhWO16
        hFKYpc/2xtTJzgPq3BHWhzgkL3bLsvk2/th9CchXFkHO2KMYf4x98Y7juThdA3Mb/pMoct5XmH4vI
        1tTJbbYw==;
Received: from [2601:1c0:6280:3f0::19c2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jwczQ-0006ml-FD; Sat, 18 Jul 2020 02:54:16 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] locking: fcntl.h: drop duplicated word in a comment
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>
Message-ID: <13c2a925-8522-64e2-4d30-97395901e296@infradead.org>
Date:   Fri, 17 Jul 2020 19:54:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Drop the doubled word "the" in a comment.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: "J. Bruce Fields" <bfields@fieldses.org>
Cc: linux-fsdevel@vger.kernel.org
---
 include/uapi/asm-generic/fcntl.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200714.orig/include/uapi/asm-generic/fcntl.h
+++ linux-next-20200714/include/uapi/asm-generic/fcntl.h
@@ -143,7 +143,7 @@
  * record  locks, but are "owned" by the open file description, not the
  * process. This means that they are inherited across fork() like BSD (flock)
  * locks, and they are only released automatically when the last reference to
- * the the open file against which they were acquired is put.
+ * the open file against which they were acquired is put.
  */
 #define F_OFD_GETLK	36
 #define F_OFD_SETLK	37

