Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50877712EB1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 May 2023 23:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243945AbjEZVHK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 May 2023 17:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbjEZVHJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 May 2023 17:07:09 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 620D0BC;
        Fri, 26 May 2023 14:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=1ogg/PUbTxKmhWJC/1xhoXa1dzdnZDY8ZuRWFCmZ38s=; b=0CftGiEnPzro23zYDvjoLbTFuY
        rqII7GAY5PmjLXehFY5Msk61fmrmnxv/iFFbFHZG+DNz5DTQeMpTaBcuX0gWbyUeB5JB3fQfzA+kz
        fzptzQXE+XrWAbMiezOCIrxOV0IuwLfF7FCG2gyB0DE5gbz2L0KfgjW3Bk4V0j7UiSFI4ZSFIJJr4
        jyVf6puAi6HAZKAOHTNvCqL6Z1DEJtp2HYSBPi/zys75bwYb+23doVm93UdkVBX/T9iihvITcWI+r
        M4+rCBQwC3bY412UlfWIrjczePv/jpUHL6dzZQ+BiMpnm4Skwd1bjpxDdxWu/pR5RPP1xvasBu+gO
        zLzoa2FA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q2eeO-003vDt-0W;
        Fri, 26 May 2023 21:07:04 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     alx@kernel.org, linux-man@vger.kernel.org,
        linux-api@vger.kernel.org
Cc:     hughd@google.com, p.raghav@samsung.com, da.gomez@samsung.com,
        rohan.puri@samsung.com, rpuri.linux@gmail.com,
        a.manzanares@samsung.com, dave@stgolabs.net, yosryahmed@google.com,
        keescook@chromium.org, mcgrof@kernel.org, patches@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] tmpfs.5: extend with new noswap documentation
Date:   Fri, 26 May 2023 14:07:03 -0700
Message-Id: <20230526210703.934922-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
 man5/tmpfs.5 | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/man5/tmpfs.5 b/man5/tmpfs.5
index 09d9558985e9..f7f90f112103 100644
--- a/man5/tmpfs.5
+++ b/man5/tmpfs.5
@@ -99,6 +99,11 @@ suffixes like
 .BR size ,
 but not a % suffix.
 .TP
+.BR noswap "(since Linux 6.4)"
+.\" commit 2c6efe9cf2d7841b75fe38ed1adbd41a90f51ba0
+Disables swap. Remounts must respect the original settings.
+By default swap is enabled.
+.TP
 .BR mode "=\fImode\fP"
 Set initial permissions of the root directory.
 .TP
-- 
2.39.2

