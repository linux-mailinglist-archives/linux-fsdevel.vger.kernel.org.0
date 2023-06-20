Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74B2A73632A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jun 2023 07:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbjFTF3h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jun 2023 01:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbjFTF3g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jun 2023 01:29:36 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF35C185
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Jun 2023 22:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=Qygh/8/fUQClJM0pexjygQHCRK3rIYHBra1Vi7MGU8U=; b=kbro+asriMqo9XM72uM5XWICX2
        t7vLTzeDlmSqli1pyR7g+bmeME3nUHCeHCHPVy+WjaGnmTcDuSFg0UCDps0pjKTt1K+j6wQdKwxZq
        mTNXeqmYo7AtR4J1kbyeEZWMs1nYhoMmtCwE9/k9gFPpHAJV21fxqXfTeStEoop0PpGxPFT7o7yoG
        v2qLQmk9wvmdniYUtMaybuxBV3sJ8UBuE8JLFQgzQTDekZZdP4ji8RvrCmNqSm0AoRCkz4sP+0a3B
        Io5pkd4LHbCN3sOVh/motdLc+5NByCPkcCArBPS76OdFXmZjb5r+TeT11/oFJxRBcMJneSrpkQE+r
        lpY21ueg==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qBTvr-00ABze-0q;
        Tue, 20 Jun 2023 05:29:35 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     djwong@kernel.org
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH] drop me from MAINTAINERS for iomap
Date:   Tue, 20 Jun 2023 07:29:33 +0200
Message-Id: <20230620052933.711180-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

As Darrick prefers to micro-manage this without looking at my input
for code I wrote and then complain about getting burned out by that
I might as well drop myself from the maintainers file.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index f794002a192e24..9c4a5572ae3382 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10813,7 +10813,6 @@ S:	Maintained
 F:	drivers/net/ethernet/sgi/ioc3-eth.c
 
 IOMAP FILESYSTEM LIBRARY
-M:	Christoph Hellwig <hch@infradead.org>
 M:	Darrick J. Wong <djwong@kernel.org>
 L:	linux-xfs@vger.kernel.org
 L:	linux-fsdevel@vger.kernel.org
-- 
2.39.2

