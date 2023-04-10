Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFC216DC316
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Apr 2023 06:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbjDJE0w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Apr 2023 00:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjDJE0v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Apr 2023 00:26:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58105358D;
        Sun,  9 Apr 2023 21:26:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F9E560C58;
        Mon, 10 Apr 2023 04:26:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59D65C433EF;
        Mon, 10 Apr 2023 04:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681100809;
        bh=PFTs0oq8nDaAGNB4674K1KYq60X4dMAg8eiKLD2TXMM=;
        h=From:To:Cc:Subject:Date:From;
        b=LDXsH0qPu1THx7nSLzxr+IntmT0GIKv6nawYUT4PgAsllybbDfUR1nkD0lBBqGv/D
         phZdm7Bk5n0W7Gy2U+st+BNo2QHVSo467cJjjtgzB7esTcQpEC9cxoX5DDIrzWgU6G
         EExD/HuxejDedf7XpsXwYQtNE4slPDugjueJB7rbqQ+rfSY+IXBZ7B44zj8AjaQfzq
         8DNb0gfyTPCX8wW8ke+bw/0FGIMw/FP5XV/j46eqC1tywKeRHxH8qa1drZEJ4tXqu+
         ipaxiAhAej7Ao1jVLU75KCl77pplV2nWLqApbO1EjskS71CQyey7bsbb8Pl0/AZp9l
         eqyCiVFX6hVkQ==
From:   dlemoal@kernel.org
To:     linux-ide@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [PATCH] ata: Change email addresses in MAINTAINERS
Date:   Mon, 10 Apr 2023 13:26:46 +0900
Message-Id: <20230410042646.124962-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Damien Le Moal <dlemoal@kernel.org>

Change my email addresses referenced in the MAINTAINERS file for the ata
subsystem to dlemoal@kernel.org. While at it, also change other
references (zonefs and k210 drivers) to the same address.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 MAINTAINERS | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index ec57c42ed544..8e156c754e20 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4461,14 +4461,14 @@ F:	Documentation/devicetree/bindings/net/ieee802154/ca8210.txt
 F:	drivers/net/ieee802154/ca8210.c
 
 CANAAN/KENDRYTE K210 SOC FPIOA DRIVER
-M:	Damien Le Moal <damien.lemoal@wdc.com>
+M:	Damien Le Moal <dlemoal@kernel.org>
 L:	linux-riscv@lists.infradead.org
 L:	linux-gpio@vger.kernel.org (pinctrl driver)
 F:	Documentation/devicetree/bindings/pinctrl/canaan,k210-fpioa.yaml
 F:	drivers/pinctrl/pinctrl-k210.c
 
 CANAAN/KENDRYTE K210 SOC RESET CONTROLLER DRIVER
-M:	Damien Le Moal <damien.lemoal@wdc.com>
+M:	Damien Le Moal <dlemoal@kernel.org>
 L:	linux-kernel@vger.kernel.org
 L:	linux-riscv@lists.infradead.org
 S:	Maintained
@@ -4476,7 +4476,7 @@ F:	Documentation/devicetree/bindings/reset/canaan,k210-rst.yaml
 F:	drivers/reset/reset-k210.c
 
 CANAAN/KENDRYTE K210 SOC SYSTEM CONTROLLER DRIVER
-M:	Damien Le Moal <damien.lemoal@wdc.com>
+M:	Damien Le Moal <dlemoal@kernel.org>
 L:	linux-riscv@lists.infradead.org
 S:	Maintained
 F:      Documentation/devicetree/bindings/mfd/canaan,k210-sysctl.yaml
@@ -11757,7 +11757,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
 F:	drivers/ata/sata_promise.*
 
 LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)
-M:	Damien Le Moal <damien.lemoal@opensource.wdc.com>
+M:	Damien Le Moal <dlemoal@kernel.org>
 L:	linux-ide@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata.git
@@ -23122,7 +23122,7 @@ S:	Maintained
 F:	arch/x86/kernel/cpu/zhaoxin.c
 
 ZONEFS FILESYSTEM
-M:	Damien Le Moal <damien.lemoal@opensource.wdc.com>
+M:	Damien Le Moal <dlemoal@kernel.org>
 M:	Naohiro Aota <naohiro.aota@wdc.com>
 R:	Johannes Thumshirn <jth@kernel.org>
 L:	linux-fsdevel@vger.kernel.org
-- 
2.39.2

