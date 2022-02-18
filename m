Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0134B4BBF71
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Feb 2022 19:27:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239181AbiBRS2D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Feb 2022 13:28:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237795AbiBRS2D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Feb 2022 13:28:03 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C155D67D;
        Fri, 18 Feb 2022 10:27:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=AZEADM8IK5yfcItVy/AZkXq/eoM28jmc3QuPDjTirFs=; b=c/fDBc+IA9+hJZoEuvwfGV6ayi
        pFDxUjS9AwOKG838mbwpoH2WbU2fVNP8VVol1MpU14G8Yz2nXyXJ3+cqloYaQVhLQClmiw3zr6jh1
        SkUMFFH5B1Qx5IrncjAAyuUhCCuRqwDBsjD9y3aVRfEcb3RDxqLp1CDaPlGLE3KHYDcEKBPTUX4+8
        +nKixIV5BNil5rb94olbpD0NcG+/32LvG7Z6xunWv6Aym6KE7I755Oid/WxVKmAqSRvuL+y523IHw
        KBYgimqSVKtodZAMDGkrlZzS5J3hWRGfHhobn8We0YgvoCYYGR8W70svYRx6uzRvdX+QerrTA/m8N
        p0fFTT/w==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nL7yn-00FV82-1z; Fri, 18 Feb 2022 18:27:41 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     akpm@linux-foundation.org, keescook@chromium.org,
        yzaikin@google.com, sfr@canb.auug.org.au
Cc:     patches@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH] MAINTAINERS: add sysctl-next git tree
Date:   Fri, 18 Feb 2022 10:27:36 -0800
Message-Id: <20220218182736.3694508-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a git tree for sysctls as there's been quite a bit of
work lately to remove all the syctls out of kernel/sysctl.c
and move to their respective places, so coordination has been
needed to avoid conflicts. This tree will also help soak
these changes on linux-next prior to getting to Linus.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---

Collecting Reviews/Acks, I can throw this into the sysctl-next tree.

 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index bd86ed9fbc79..08bce45710e6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15564,6 +15564,7 @@ M:	Iurii Zaikin <yzaikin@google.com>
 L:	linux-kernel@vger.kernel.org
 L:	linux-fsdevel@vger.kernel.org
 S:	Maintained
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git sysctl-next
 F:	fs/proc/proc_sysctl.c
 F:	include/linux/sysctl.h
 F:	kernel/sysctl-test.c
-- 
2.34.1

