Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A63A228594
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jul 2020 18:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730390AbgGUQ2h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jul 2020 12:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730281AbgGUQ2g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jul 2020 12:28:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B145C061794;
        Tue, 21 Jul 2020 09:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=iQczvU1h4n8lwFPvoHz8lRyAHOAAiiM628J1s5lpBsc=; b=vbaMRedgjN0WGkhWbwjDhW7QcR
        tzPbT2QAtISNMYUX0qKzFW+ihW/152ja56HD+AtMI1OVvFuOS1beyh78dvg+mfFnTynLVIa78CpVz
        /2AoJY3nFtDvYK8U334evCBOhs+1dRxhjImyVpmB1kDGwMWYICQGgxYiuq7q7HbQsADRWIB5kXez1
        bh7LYm7pmhuyoKXx8PGNoDdi1FsLsVUgbVpsGudGXiGXe7sQtJSolrH8VyvpzC8g6Xs0FhUknn1jm
        hwkfZvlPt7S11HI744D8NnIuuZsN55oqPDVjwTfwOxF6h8sI4nvkKI++LTszuE7i/sJi76FcLLgxA
        txXdDo/w==;
Received: from [2001:4bb8:18c:2acc:5b1c:6483:bd6d:e406] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxv84-0007Sx-Eh; Tue, 21 Jul 2020 16:28:33 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH 09/24] init: mark create_dev as __init
Date:   Tue, 21 Jul 2020 18:28:03 +0200
Message-Id: <20200721162818.197315-10-hch@lst.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200721162818.197315-1-hch@lst.de>
References: <20200721162818.197315-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The helper is only used for the early init code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 init/do_mounts.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/init/do_mounts.h b/init/do_mounts.h
index 853da3cc4a3586..15d256658a3093 100644
--- a/init/do_mounts.h
+++ b/init/do_mounts.h
@@ -14,7 +14,7 @@ void  mount_root(void);
 void prepare_namespace(void);
 extern int root_mountflags;
 
-static inline int create_dev(char *name, dev_t dev)
+static inline __init int create_dev(char *name, dev_t dev)
 {
 	ksys_unlink(name);
 	return ksys_mknod(name, S_IFBLK|0600, new_encode_dev(dev));
-- 
2.27.0

