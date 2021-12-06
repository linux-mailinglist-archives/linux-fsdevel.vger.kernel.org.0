Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5548469980
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Dec 2021 15:52:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344647AbhLFOzx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Dec 2021 09:55:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244700AbhLFOzw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Dec 2021 09:55:52 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41245C061746;
        Mon,  6 Dec 2021 06:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=bxlBhZdEsdzQnawK9uAmlD3xS+qM5ZDr6GgQWvwVttU=; b=hQiqBWNL8MsXecoA8QxlSn0Ptf
        Y5wlcBA2plTFM/9Kwu30iMHqB79GRw/O70IPCkLVREW90hS861sLfqAQ+zjh09edy2AR8gFauKGdi
        y6WUyhVqq5YfNtk3TdubMhyjRFbAWPN7VzfC+R+E/MjhEqLDUQV0q0xTBB/SQXTBufze1R+jdqdcc
        mkn8I+CUswgRO0QP7SGW3XIyLr0Mve5I2ZIcewh72WNXkc6GecdjO+D6evxKZUvC1SqtMopYJC75x
        bbyvwntHq0u4qn7ow5RhRGo3mt4csQY+I/nyuwGb4MIvUuYEsrBS37ak8lbyyvCJhKID+2poL/oZn
        CpilgHYA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1muFLp-004vkC-G5; Mon, 06 Dec 2021 14:52:21 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-doc@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/3] iov_iter documentation
Date:   Mon,  6 Dec 2021 14:52:17 +0000
Message-Id: <20211206145220.1175209-1-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I couldn't remember what the return value from copy_to_iter() was, so
I wrote some documentation and linked it into the kernel-doc tree.

Matthew Wilcox (Oracle) (3):
  iov_iter: Add skeleton documentation
  iov_iter: Add kernel-doc
  iov_iter: Move internal documentation

 Documentation/core-api/index.rst    |  1 +
 Documentation/core-api/iov_iter.rst | 21 ++++++++
 include/linux/uio.h                 | 74 +++++++++++++++++++++++++++++
 lib/iov_iter.c                      | 41 ----------------
 4 files changed, 96 insertions(+), 41 deletions(-)
 create mode 100644 Documentation/core-api/iov_iter.rst

-- 
2.33.0

