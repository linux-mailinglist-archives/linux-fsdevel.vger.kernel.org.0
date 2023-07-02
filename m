Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0981474508B
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Jul 2023 21:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbjGBTjj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 2 Jul 2023 15:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbjGBTje (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 2 Jul 2023 15:39:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C8AE6D;
        Sun,  2 Jul 2023 12:39:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 309C560C94;
        Sun,  2 Jul 2023 19:38:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D62A7C433BA;
        Sun,  2 Jul 2023 19:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688326730;
        bh=SBqU5Znnx6nXYiL6xz9ozoONwo8Jt53kDHjYkVEo6aQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tur/Ocz6Kd3UCEJVVPzzXAqf/sZXKRaIrUM5heImZUYz31NALjL8Grss+TuMyqp4w
         uXogv20BNac/PToauaZgoTQe0HtVhdvnwW8RMokftYGY9WegGgBKeTTtCcJ72FD5xi
         I/EwAu3OBpW8sKdm6egW5rose7F936Qe2kE/OBDxfXdo4lu4FfC85CLRE75jlAJOgl
         3I5Yx8Pp58MMOyuu/OhQP+DUEamggGYDrKIbzOBfiMT5ewQ5048RHBf/2c6uchmD0X
         SKKya+3K8rfqim8X9fuQiGUMyvKGGIz/melNT6f0gJmIxEJ8LEBBZQh9/lXByH7KDq
         WK1mAb+NDtBNg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>,
        Christian Brauner <brauner@kernel.org>,
        Sasha Levin <sashal@kernel.org>, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.4 13/16] fs: unexport buffer_check_dirty_writeback
Date:   Sun,  2 Jul 2023 15:38:12 -0400
Message-Id: <20230702193815.1775684-13-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230702193815.1775684-1-sashal@kernel.org>
References: <20230702193815.1775684-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.1
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit 4bb218a65a43782b1e75f5510744cb44795a1105 ]

buffer_check_dirty_writeback is only used by the block device aops,
remove the export.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Message-Id: <20230608122958.276954-1-hch@lst.de>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/buffer.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index a7fc561758b1a..fe64356e89b8a 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -111,7 +111,6 @@ void buffer_check_dirty_writeback(struct folio *folio,
 		bh = bh->b_this_page;
 	} while (bh != head);
 }
-EXPORT_SYMBOL(buffer_check_dirty_writeback);
 
 /*
  * Block until a buffer comes unlocked.  This doesn't stop it
-- 
2.39.2

