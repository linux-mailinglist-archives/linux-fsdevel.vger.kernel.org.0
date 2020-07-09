Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC0D21A349
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jul 2020 17:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728288AbgGIPTH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jul 2020 11:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728117AbgGIPSe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jul 2020 11:18:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00B21C08C5CE;
        Thu,  9 Jul 2020 08:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=loyJfIjr6uG+JtT8Ae3i8+buKjp1+Mq9QHCSFksTz0I=; b=K0LBPbWi/Xr8DW4OgY7Ac/hL4a
        Jy5EevLYuoCtkhhqLlEe006QWoiJBnpK/RmcAqD6YCvSWOUN8cZ1musNMtT/4C4T2LFivaQlTeX6U
        sbr3OW3wp1OuHveZEryV3TIbdvgjwC4FAMPLl3LhcECISsz0otyX/JHdlrUjoNJvrG/zX4F/fisN/
        kdQFw2mQtsY4h30VIgq6TWq/sQnx6KJvQUYUpc18c1Wb83bA343vxH3ZCOf4KmndSLyZ/8wJJT2h2
        x9qJVV9Ss5ohLOfNYQN3Gx3p3CsCs3Sj3bZVqAIKdS2yjWJ7SQzCaVABphLmNciYkLJZpkuAXIwSG
        UTNDoYZQ==;
Received: from [2001:4bb8:188:5f50:7053:304b:bf82:82cf] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jtYJk-0005MY-77; Thu, 09 Jul 2020 15:18:32 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-kernel@vger.kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>, Song Liu <song@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-raid@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 11/17] initrd: mark init_linuxrc as __init
Date:   Thu,  9 Jul 2020 17:18:08 +0200
Message-Id: <20200709151814.110422-12-hch@lst.de>
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

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 init/do_mounts_initrd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/init/do_mounts_initrd.c b/init/do_mounts_initrd.c
index e4f88e9e1c0839..57ad5b2da8f5f5 100644
--- a/init/do_mounts_initrd.c
+++ b/init/do_mounts_initrd.c
@@ -56,7 +56,7 @@ static int __init early_initrd(char *p)
 }
 early_param("initrd", early_initrd);
 
-static int init_linuxrc(struct subprocess_info *info, struct cred *new)
+static int __init init_linuxrc(struct subprocess_info *info, struct cred *new)
 {
 	ksys_unshare(CLONE_FS | CLONE_FILES);
 	console_on_rootfs();
-- 
2.26.2

