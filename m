Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED5E230F95
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jul 2020 18:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731631AbgG1Qed (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jul 2020 12:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731626AbgG1Qec (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jul 2020 12:34:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 323E0C061794;
        Tue, 28 Jul 2020 09:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=C9uygSCQ/rhfYPUOQwsS3gpepCXYbyGMeQJLdWnmoPA=; b=S99vk2en/1NgMc9UBq6uz1M0mu
        aB/vUiT81vmLZG4Xy/5tNzG+1kAzonFbPzbjD4W+QSbL8Sx4OapvUFfkwKk15ZDlNAOlioyqkhtZx
        9yvDZAztFmrw5ralKtj0nHEJpsopjZOwm4Zpnwlxf+G1rYyaBvznWPZf6YcFi4y4P+Ut8xHb4neF/
        U9Y5d7TVEzILtdbeH/OTefMFVXx/eWPLt/onUBMnnJvKlJ49SDoApdMDAreI6k8QjCo7uYONru67u
        TD5MuxPO4uI2ohXzLuigEBHe60MR6rITMI41oC+Or7bez2v92XznxKYLgAkdCz5fMjt9v3G04Ksv4
        ncqRibFw==;
Received: from [2001:4bb8:180:6102:fd04:50d8:4827:5508] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k0SYd-0006xW-75; Tue, 28 Jul 2020 16:34:27 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH 06/23] init: mark console_on_rootfs as __init
Date:   Tue, 28 Jul 2020 18:33:59 +0200
Message-Id: <20200728163416.556521-7-hch@lst.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200728163416.556521-1-hch@lst.de>
References: <20200728163416.556521-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This helper is only used for the early init code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 init/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/init/main.c b/init/main.c
index c2c9143db96795..47698427b15f62 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1458,7 +1458,7 @@ static int __ref kernel_init(void *unused)
 }
 
 /* Open /dev/console, for stdin/stdout/stderr, this should never fail */
-void console_on_rootfs(void)
+void __init console_on_rootfs(void)
 {
 	struct file *file = filp_open("/dev/console", O_RDWR, 0);
 
-- 
2.27.0

