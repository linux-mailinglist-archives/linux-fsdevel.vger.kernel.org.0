Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E691202245
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Jun 2020 09:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbgFTHRC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Jun 2020 03:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727030AbgFTHRA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Jun 2020 03:17:00 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9984DC06174E;
        Sat, 20 Jun 2020 00:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Hmdq74RZRFXfpfO9/RDPzhQUUxVgGOMLesCz3fORA5E=; b=BG9cLxkrEehmE2mHnPkXBWfH5Q
        pwPWhbSjz+QbTzfhQNXvUwRtKKuo1BrmKKETe9J4JdBv7TOmAPWbqIkQazQlWVEC0DGbHNLiQYP8o
        5/hk/SvZfyl02t/YpW9t1ZBuJTPhUYIEmtXH3sXQv+FEEFNw0SCrpyTUQEUKNkbejTFaL/7iV3Jms
        ELzo5LXE1jzLKBC/MXzKH3hUh5sxSsOqdCZ3DjJZ/Q30iWIktScCmBbYuHglHR5n6ZSZdEPM8ZvWx
        WX0QAy08qNNuq0sKdyWmbvfkXyEqh0Gu95rZVOZk0BC7Wqms83OL3Zctb79ODMimkpIEbp6TT7uw0
        oeKjD67w==;
Received: from 195-192-102-148.dyn.cablelink.at ([195.192.102.148] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jmXkI-0003rm-CS; Sat, 20 Jun 2020 07:16:58 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 04/10] fs: remove the HAVE_UNLOCKED_IOCTL and HAVE_COMPAT_IOCTL defines
Date:   Sat, 20 Jun 2020 09:16:38 +0200
Message-Id: <20200620071644.463185-5-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200620071644.463185-1-hch@lst.de>
References: <20200620071644.463185-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

These are not defined anywhere, and contrary to the comments we really
do not care about out of tree code at all.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/fs.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 0d282c853691a3..224edcc5b56e62 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1774,12 +1774,6 @@ struct dir_context {
 	loff_t pos;
 };
 
-/* These macros are for out of kernel modules to test that
- * the kernel supports the unlocked_ioctl and compat_ioctl
- * fields in struct file_operations. */
-#define HAVE_COMPAT_IOCTL 1
-#define HAVE_UNLOCKED_IOCTL 1
-
 /*
  * These flags let !MMU mmap() govern direct device mapping vs immediate
  * copying more easily for MAP_PRIVATE, especially for ROM filesystems.
-- 
2.26.2

