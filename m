Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55E2366D340
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jan 2023 00:37:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235250AbjAPXhR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Jan 2023 18:37:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235270AbjAPXg5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Jan 2023 18:36:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 931E512F2F;
        Mon, 16 Jan 2023 15:36:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4C3C7B80FCD;
        Mon, 16 Jan 2023 23:36:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA94AC433D2;
        Mon, 16 Jan 2023 23:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673912214;
        bh=N8IFuauoFBlRBCPllH9x+bpTPBvYcnFCohv+H6rAcmg=;
        h=From:To:Cc:Subject:Date:From;
        b=i1lWyLdD4VO3VFps3DuBp+8Z/vTP0S0L8hquBQo1OzEKM5RiCVb03zyaa6uMzedTX
         iO+PY4M95I0DpX1uZh+drGIwSpqXeJyzFYra2/mnUauRT60MHI/Tl4IAw4Hq5d5spx
         /etztWrnI3tYB4Y8amWjhYreLBTGZShe8EpVt8Pt6UZuUZy2/40MiPl/Tl+sw3XBdD
         d6CD7VhJhG71U4IpdKuFFf7O7hFCCl/tzq3md/HZb2ddPMbmDav+jTk+AcqqDth0tG
         97Q+xSZxDmiC3jSQmCDCuO+RDDk2yRr3WSprBBoXlSGuvwo4hDGAgM4yxUmFrG5A0/
         yxaqOQjeS7BpQ==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-btrfs@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: update fscrypt git repo
Date:   Mon, 16 Jan 2023 15:34:24 -0800
Message-Id: <20230116233424.65657-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,SUSPICIOUS_RECIPS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

fscrypt.git is being renamed to linux.git, so update MAINTAINERS
accordingly.  (The reasons for the rename are to match what I'm doing
for the new fsverity repo, which also involves the branch names changing
to be clearer; and to avoid ambiguity with userspace tools.)

As long as I'm updating the fscrypt MAINTAINERS entry anyway, also:

- Move my name to the top, so that people bother me first if they just
  choose the first person.  (In practice I'm the primary maintainer, and
  Ted and Jaegeuk are backups.)

- Remove an unnecessary wildcard.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 MAINTAINERS | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 42fc47c6edfd7..8d0ee9f17b4d4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8468,16 +8468,16 @@ F:	fs/fscache/
 F:	include/linux/fscache*.h
 
 FSCRYPT: FILE SYSTEM LEVEL ENCRYPTION SUPPORT
+M:	Eric Biggers <ebiggers@kernel.org>
 M:	Theodore Y. Ts'o <tytso@mit.edu>
 M:	Jaegeuk Kim <jaegeuk@kernel.org>
-M:	Eric Biggers <ebiggers@kernel.org>
 L:	linux-fscrypt@vger.kernel.org
 S:	Supported
 Q:	https://patchwork.kernel.org/project/linux-fscrypt/list/
-T:	git git://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git
+T:	git https://git.kernel.org/pub/scm/fs/fscrypt/linux.git
 F:	Documentation/filesystems/fscrypt.rst
 F:	fs/crypto/
-F:	include/linux/fscrypt*.h
+F:	include/linux/fscrypt.h
 F:	include/uapi/linux/fscrypt.h
 
 FSI SUBSYSTEM

base-commit: 5dc4c995db9eb45f6373a956eb1f69460e69e6d4
-- 
2.39.0

