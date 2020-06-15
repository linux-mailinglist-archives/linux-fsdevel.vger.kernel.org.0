Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB79B1F9746
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jun 2020 14:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730268AbgFOMy7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Jun 2020 08:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730136AbgFOMxw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Jun 2020 08:53:52 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE37C061A0E;
        Mon, 15 Jun 2020 05:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=loyJfIjr6uG+JtT8Ae3i8+buKjp1+Mq9QHCSFksTz0I=; b=Ll1ZB3ezBG5HX+2+L4cbQx89gY
        S7s9OLwoFx7bIS2crWC1J0+aXP7IX61oJ/cZFlFT6XelwFpjzLp56uGlbXma3zwHKEZQXap6b8Uwh
        F3sdF9hd23oP+xkKs+kcxotgjlYhOYQ7TWJ+op260Y/WIXG73U2howHUK0DZH+/+ralE4LREQkQUS
        ipbtwOYSbGkEx8Zt6qGMqRoSLgx+QEsz6NGxsxq7R+0bAnXk24HU1XL9KK34tCGEBCTlAYxvZhlO9
        5jVOsIyX7cz9CyMVQrM6B+dIL61WB9aNIEmKm79j9aPjDhoq8WoSb6ZuB5n8qswEV4uNdSTBOGBMI
        6178qU8g==;
Received: from 195-192-102-148.dyn.cablelink.at ([195.192.102.148] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jkocZ-0000tz-Fo; Mon, 15 Jun 2020 12:53:51 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-kernel@vger.kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>, Song Liu <song@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-raid@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 11/16] initrd: mark init_linuxrc as __init
Date:   Mon, 15 Jun 2020 14:53:18 +0200
Message-Id: <20200615125323.930983-12-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200615125323.930983-1-hch@lst.de>
References: <20200615125323.930983-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
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

