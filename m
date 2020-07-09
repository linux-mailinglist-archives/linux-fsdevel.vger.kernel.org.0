Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C87421A334
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jul 2020 17:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbgGIPSh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jul 2020 11:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728099AbgGIPSg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jul 2020 11:18:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF870C08C5CE;
        Thu,  9 Jul 2020 08:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=dgOXqb0tVgx5Fx04LZETgODhOY33F5qja2AR6Zx6i+w=; b=t67TgaVQSMR2cIOYL/gwXwTD/2
        mimsq3JIYyI2bf/ecJU3KMpRyWwqBbgscbCDhEfg2idrAoGLF0SDtciRrqgLt9981spHCglvsqKbW
        FCDLpbjDFbeyiN5ZD+qPsz5sCFxEMW2Sg7frGrRXU9ludAQxbmO+ub8rhBr7UKbGYqBWgbElgKO+H
        o+WSq+3mg4mNmKGitbfk7LGsh4KR6roBdbCYhlsjwSc6tcQsqc3iME8tJS5FbMRbK0T3iivit/0/Q
        b8uMhAxhrfmeWci7sX8EOM0PLnyLpZeoBMmr6bEu5pqV+mHk11opxYxOrKr9/HoAmlf9EruUv6qAn
        37OyZzGQ==;
Received: from [2001:4bb8:188:5f50:7053:304b:bf82:82cf] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jtYJl-0005Mf-I8; Thu, 09 Jul 2020 15:18:33 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-kernel@vger.kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>, Song Liu <song@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-raid@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 12/17] initrd: mark initrd support as deprecated
Date:   Thu,  9 Jul 2020 17:18:09 +0200
Message-Id: <20200709151814.110422-13-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200709151814.110422-1-hch@lst.de>
References: <20200709151814.110422-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The classic initial ramdisk has been replaced by the much more
flexible and efficient initramfs a long time.  Warn about it being
removed soon.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 init/do_mounts_initrd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/init/do_mounts_initrd.c b/init/do_mounts_initrd.c
index 57ad5b2da8f5f5..e08669187d63be 100644
--- a/init/do_mounts_initrd.c
+++ b/init/do_mounts_initrd.c
@@ -75,6 +75,8 @@ static void __init handle_initrd(void)
 	extern char *envp_init[];
 	int error;
 
+	pr_warn("using deprecated initrd support, will be removed in 2021.\n");
+
 	real_root_dev = new_encode_dev(ROOT_DEV);
 	create_dev("/dev/root.old", Root_RAM0);
 	/* mount initrd on rootfs' /root */
-- 
2.26.2

