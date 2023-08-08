Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32E9C774989
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Aug 2023 21:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232539AbjHHT5v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Aug 2023 15:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234613AbjHHT5C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Aug 2023 15:57:02 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E681BAD0;
        Tue,  8 Aug 2023 11:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=rt0px8OIiQARO6GUL8fgA6BaKOKo7Z9Pdx2pSymnAUQ=; b=MQqMBYz676hItDqatL6JGvZ2jH
        km7sn+WQU/dd15wbNotX4+Vdyyk03qVbn0sBwLURbVvLQ+5TtaRsCgJvY0A+KsgwO9f3gNR9UNLXh
        W9/AZPYOWrmhkbWthGi/63qXFoPS0WZDG4nms7wlp6Csv9PEBZD7eM2NZnNnYsbr6RpELeXpkSyzj
        13OqYjLV1Ltdqie74m83jj7sK0fyqkzr1zHBzeh4nEzjhDhnmqB50dnHeribX85qSdgCPihieul1B
        AkjmkXs6Yi4nrf+iUSZ9yYDM/wfkuQIFLWSd6KpaqSCRhhHYRq1s2y8DYS95ZaELpo1Vxfqx1SbMj
        /o62BDDw==;
Received: from [4.28.11.157] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qTPNJ-002vbG-21;
        Tue, 08 Aug 2023 16:16:01 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        ntfs3@lists.linux.dev, linux-xfs@vger.kernel.org
Subject: [PATCH 01/13] xfs: reformat the xfs_fs_free prototype
Date:   Tue,  8 Aug 2023 09:15:48 -0700
Message-Id: <20230808161600.1099516-2-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230808161600.1099516-1-hch@lst.de>
References: <20230808161600.1099516-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The xfs_fs_free prototype formatting is a weird mix of the classic XFS
style and the Linux style.  Fix it up to be consistent.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/xfs_super.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index bf6e0a261a49e6..0a294659c18972 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -1933,7 +1933,8 @@ xfs_fs_reconfigure(
 	return 0;
 }
 
-static void xfs_fs_free(
+static void
+xfs_fs_free(
 	struct fs_context	*fc)
 {
 	struct xfs_mount	*mp = fc->s_fs_info;
-- 
2.39.2

