Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A23D9525531
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 May 2022 20:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357817AbiELSzo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 May 2022 14:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245570AbiELSzn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 May 2022 14:55:43 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA663BBB;
        Thu, 12 May 2022 11:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=uhZbEF8ozOsKVGCWXPJgo8a1DK922JL6Fkw0EnSmiAY=; b=YBLFkmhstJpOijk202TJ1qJfyz
        M+AnMiuYa0AgyP1rplhDejOWlq8r0lCKtOxkwOrmUB1Tf+6X/G1XgT7Sm14SeNb4Xdbdq0EpR1INK
        vIWm36oJ7OtuF287RHAF77emvW2/x4WCjen9lfsWVM04MVDXJgvk3F6hIVmlGwwyqBsQ9xa8awRYF
        vVRxXWYLVb5nGKfu1oWN/O/cJAaQs0L+m4VA9NkcpBtqthPL4DlBHqwUeR36f6o66xC9Of4KUhTun
        4xC5UKESo1TcL0QVv72PzQa6yV17NoYexM8yk88SikAqmg+mLLb5TCad7nu3qniyYFAqFIAjWqQd2
        EVqlXCGg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1npDyL-00DASd-7d; Thu, 12 May 2022 18:55:37 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     mcgrof@kernel.org, russell.h.weight@intel.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: add Russ Weight as a firmware loader maintainer
Date:   Thu, 12 May 2022 11:55:29 -0700
Message-Id: <20220512185529.3138310-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.35.1
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

Russ has done extensive rework on the usermode helper interface for
the firmware loader. He's also exressed recent interest with maintenance
and has kindly agreed to help review generic patches for the firmware
loader. So add him as a new maintainer!

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 452f3662e5ac..50e89928d399 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7664,6 +7664,7 @@ F:	include/linux/arm_ffa.h
 
 FIRMWARE LOADER (request_firmware)
 M:	Luis Chamberlain <mcgrof@kernel.org>
+M:	Russ Weight <russell.h.weight@intel.com>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 F:	Documentation/firmware_class/
-- 
2.35.1

