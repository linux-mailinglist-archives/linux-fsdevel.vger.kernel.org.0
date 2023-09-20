Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6FEB7A8FF7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Sep 2023 01:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjITXuo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Sep 2023 19:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjITXum (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Sep 2023 19:50:42 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D1EDE;
        Wed, 20 Sep 2023 16:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=tlgdA+9zRCeEqqQqdnsCAMTZo8+aT2RUqSoMURIS/L0=; b=gZWIxfyxxYZn8qx/ODs6UihV7w
        yCc0UiMKZgKV21JT2OoezTRYQ6ZGJcTL+LjYU5Kl/ydpycLgWmI0rN9OxmzJ0tDrNFETenW0qyjAZ
        jZcuflWPs1JomA/GzhSRDQjsMUOOk4z+gYkPVnUKU8pcav2geuBrihQwvqfcwFuJeC/FqrHCdIOGa
        RgflSoRRiawgM6syJ0tqe9jN/M961ZNwsACj5a4lzDKQPBdWfDf/FHcRqpKY6e5OEA2jBFyQFLQkO
        QUCkB3MRGO3k5nPhIwYDYBdShihgvRvYDf0SO0+mbkfbGdPh0ZXroFXiWk9OQFHuS2fEAoJtTecGO
        cWI7OljA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qj6xb-004UYT-1u;
        Wed, 20 Sep 2023 23:50:23 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     alx@kernel.org, linux-man@vger.kernel.org,
        linux-api@vger.kernel.org
Cc:     hughd@google.com, p.raghav@samsung.com, da.gomez@samsung.com,
        rohan.puri@samsung.com, rpuri.linux@gmail.com,
        a.manzanares@samsung.com, dave@stgolabs.net, yosryahmed@google.com,
        keescook@chromium.org, mcgrof@kernel.org, patches@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] tmpfs.5: extend with new noswap documentation
Date:   Wed, 20 Sep 2023 16:50:22 -0700
Message-Id: <20230920235022.1070752-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Linux commit 2c6efe9cf2d7 ("shmem: add support to ignore swap")
merged as of v6.4 added support to disable swap for tmpfs mounts.

This extends the man page to document that.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---

changes on v2:

 - Use semantic newlines

 man5/tmpfs.5 | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/man5/tmpfs.5 b/man5/tmpfs.5
index 5274e632d6fd..047a17a78ee0 100644
--- a/man5/tmpfs.5
+++ b/man5/tmpfs.5
@@ -103,6 +103,12 @@ suffixes like
 .BR size ,
 but not a % suffix.
 .TP
+.BR noswap "(since Linux 6.4)"
+.\" commit 2c6efe9cf2d7841b75fe38ed1adbd41a90f51ba0
+Disables swap.
+Remounts must respect the original settings.
+By default swap is enabled.
+.TP
 .BR mode "=\fImode\fP"
 Set initial permissions of the root directory.
 .TP
-- 
2.39.2

