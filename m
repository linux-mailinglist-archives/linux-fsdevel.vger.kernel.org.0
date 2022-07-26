Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 895085814E9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jul 2022 16:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233721AbiGZOQ2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jul 2022 10:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbiGZOQ1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Jul 2022 10:16:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B22F613D47
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Jul 2022 07:16:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 666B7B81609
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Jul 2022 14:16:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDEA0C433D6;
        Tue, 26 Jul 2022 14:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658844984;
        bh=n2mSxlW/z68YbpTbcKBKIBbwWGIDMnhY65nKj6IEArc=;
        h=From:To:Cc:Subject:Date:From;
        b=rWtiiAnboiaJe6Mw2Ihizh9uhh8e8M+/4LhYgkmmKJRA2pqg1u/401j76VmBoAkO0
         iuPKDjbac8EQ1WxYrSnycSz+nKnznPHX8UqYITgTrYjrIKNZgHbQQvwwJswG879rLJ
         NgIF/NOd4Lq20zRKgm+F3mn0bWCLtSN8qsTS0Q5fOwr2Z6ioBz3jY4VeQqyQBR7We2
         FjLrb26ThvIoLrUjItL2U2BDglfCaJ7AQ36vi9PBhOvF/WgSvzHkCUVq6BVS2VvgPX
         3PwRWN07ZDssBmVb/fQagYMqpQimrBBVqwUgX5dWrWpFeyXMqPWEENKn6IjwM3TtGY
         95ApF0raVq5pw==
From:   Christian Brauner <brauner@kernel.org>
To:     Seth Forshee <sforshee@digitalocean.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org
Subject: [PATCH] Add Seth Forshee as co-maintainer for idmapped mounts
Date:   Tue, 26 Jul 2022 16:16:15 +0200
Message-Id: <20220726141615.1046027-1-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Seth has been integral in the design and implementation of idmapped
mounts and was the main architect behind the s_user_ns work which
ultimately made filesystems such as FUSE and overlayfs available in
containers. He continues to be active in both development and review.
I'm very happy he decided to maintain this feature. He has my full
trust.

Cc: Seth Forshee <sforshee@digitalocean.com>
Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3cf9842d9233..1dd6cf484ea8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9525,6 +9525,7 @@ F:	drivers/input/misc/ideapad_slidebar.c
 
 IDMAPPED MOUNTS
 M:	Christian Brauner <brauner@kernel.org>
+M:	Seth Forshee <sforshee@kernel.org>
 L:	linux-fsdevel@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git

base-commit: 77940f0d96cd2ec9fe2125f74f513a7254bcdd7f
-- 
2.34.1

