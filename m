Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 408FA698CE5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Feb 2023 07:29:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbjBPG33 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Feb 2023 01:29:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjBPG32 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Feb 2023 01:29:28 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC9A73D098;
        Wed, 15 Feb 2023 22:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=N+CZxEF2RzuQyX1tmJ9FOoCISaX92qcBDgopCpfiRkg=; b=VGw2VRxsHCjsX6/zRp3U6hA64U
        AKamPcM6F3Tmd91ePePMb6YXfizisXz80llYxxq7f+m3d0+zGaVtuVT0lSoEJRY/LdSaYaISiqi61
        RhQMvOUnNRzKL15Ons+o6KNLp4TEfCxnet8Iwd96pLaMaFiBGGpWw2KuVVfUyxOfMejd9EdTuo9w5
        uKfk7lWn3xpGY4KjNk6DElsCVGP5Mvhk1R4WkGbPxlCywwPk65+x3TMFoFgqA+LI6kke52g7iiEvK
        K8R7gdiIqV4rALcWsjyT9LQbDT3ch1YJlibK8FsdEJZfsvzYwof2UDLDG3Gh6lqVg4OLegMYjzaJP
        Bys6ffzA==;
Received: from [2001:4bb8:181:6771:37af:42b9:3236:81df] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pSXlk-008gO2-Mt; Thu, 16 Feb 2023 06:29:25 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     torvalds@linux-foundation.org
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] orphan sysvfs
Date:   Thu, 16 Feb 2023 07:29:22 +0100
Message-Id: <20230216062922.2151960-1-hch@lst.de>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This code has been stale for years and I have no way to test it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 39ff1a71762527..225c3ce347a217 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20323,8 +20323,7 @@ S:	Maintained
 F:	drivers/platform/x86/system76_acpi.c
 
 SYSV FILESYSTEM
-M:	Christoph Hellwig <hch@infradead.org>
-S:	Maintained
+S:	Orphan
 F:	Documentation/filesystems/sysv-fs.rst
 F:	fs/sysv/
 F:	include/linux/sysv_fs.h
-- 
2.39.1

