Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0DAB21FC70
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jul 2020 21:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731395AbgGNTJN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jul 2020 15:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731350AbgGNTJL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jul 2020 15:09:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BE44C061755;
        Tue, 14 Jul 2020 12:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=msP/oerZWqDMoBsujpLUb7YWzbnfB2HOPjogQBRZrOE=; b=RmaqwAgHm0qPtuTRZicpjG4Zsl
        lgTA7GgRIY5gRhbJUkCYKb6au6lLw51ICuW4rj9m3wRjOmYlSDuZdHYdkF3qwYhFvsnxcrS4sQIpe
        12lHMnhYSUZFzTYwUXddse2Aj2XC0e/UGWwICR+EdmMx18x1bRHBHcAf+R0bk52YrrRzwtaFBziqd
        TB9n/bqe1v83yBlPvdovDkF1efCd7GHLfHzZ0tFZmyHHBTPnYGrmSHdWPSlpZHPmP0nrDDZIsLh3e
        xejMlgd4tU+rwGdL3aPQgDm9V3q+9NWMjefko/xDMtZLfkvNJAQBDj/GK/4bTRPD+vk46y0EZZfIk
        L5qunhtg==;
Received: from [2001:4bb8:188:5f50:f037:8cfe:627e:7028] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jvQIf-0005sZ-36; Tue, 14 Jul 2020 19:09:09 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-kernel@vger.kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>, Song Liu <song@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-raid@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 14/23] initrd: mark initrd support as deprecated
Date:   Tue, 14 Jul 2020 21:04:18 +0200
Message-Id: <20200714190427.4332-15-hch@lst.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200714190427.4332-1-hch@lst.de>
References: <20200714190427.4332-1-hch@lst.de>
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
2.27.0

