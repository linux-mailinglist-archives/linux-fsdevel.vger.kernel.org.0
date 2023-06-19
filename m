Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FFFD735EE4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jun 2023 23:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjFSVSw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Jun 2023 17:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjFSVSv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Jun 2023 17:18:51 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50275E4D;
        Mon, 19 Jun 2023 14:18:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1687209523; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=iXW+saF7kB84ux5Sh1GzvZJAKM5oOuBilsfWS6nJnsZqanSKwfNjFgvG+3uYC0At5T
    46+OSOvw14hhWN6sm7Q7fuSykcen5VPB9u+VR6Ks0MZDuDqDxJOH/1EQx+GI0Tt1V3wY
    V5b0WQQDknmTJSCBu1XqeLKozTUBqeIZO3aqTY8tZRz0en4UIAHlS0utuDXGJSqaRDrM
    yg3ZCSRoGdycEFF9T2xShKPKoHS8AswK+NKMBJiWfWoO99oGiS+4c9DJptA9zpLxX7Mf
    r8lguh0sBxgDMd83ERZopQUICpfj25TduZPOGqceozxeJfI1NEDsIX9MVJv7XaRmunfH
    t5ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1687209523;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=CKdAZMZFL1lysf+KGzAf1YfN52/k1jfBpqK7BEK4ECQ=;
    b=NdjepsXemP4zX5eP3+nASzm2MBNXIYeXB5ZOeZYL7NaB2qDBYchN58t2uXgJ7ajkPI
    kIeJVCh6dwRAtRDgPoCTb+wmqKQcQl1ETExCOA3GpIPBKAnvwGDeTRNsKf4rb1qurIHv
    mu9UlQhGvnN/octEhj8+IFkfNqEW0fYPt9qGbrMgbMlE+fP6RhTOFbMs1XXSiduTcI6w
    w0uWSS/XdOmXQaHWK4Imb0gLj77x7hLzS+QMkugDtzVYuMMWUvSXg64/GDBHPhZjAiN4
    xhju/kIw3MUXy5Aw+lbD91HWLDrEm+1USzWhnNRf3sMBxi4YY0XPrmJqHzesDqWRiAsA
    Q0yw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1687209523;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=CKdAZMZFL1lysf+KGzAf1YfN52/k1jfBpqK7BEK4ECQ=;
    b=EvvbgWM/eCMk0n1VSSbXT5rhdyml+1hWKggc7OV/TwNzf/lpxIRIiAsZ/IxitXniZY
    L3eFUQ1m/YIeeOrkAqyaWo8LAbRKm+8bwV1Ui+7s3nf22PWg+Ep5dWyWWSITcXZeWJJ4
    hNCb4IvvFumuArPd1HZDHAoXshSeoCVCIqwYdjknsaDDW2um3+K+lQVQfW9HgBGYulSV
    Yl4kFTUp3hEgo8eR0lJAKVP+IbW7eTh3i/7Cvp1kuwfhwAOxmWOSxrTMVyQ11S8+B3u9
    h7jBvR1GbtaYn9hKMeq26e56ajUUGopdYp2L9jBuKWQBDohJ1OecAzcdk8JaMPp6ixEp
    aShw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1687209523;
    s=strato-dkim-0003; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=CKdAZMZFL1lysf+KGzAf1YfN52/k1jfBpqK7BEK4ECQ=;
    b=QqgNxw3eGfr+h4MqDUBKk1EMddioMAgXV+MI/gO1qh6s+TOSnMStcOSBEOs8ATjUi0
    bWc3AC1Oo2rjqpMNwIDg==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSedrgBzPc9DUyubU4DD1EQ33bneoxgmq7ABeEwyjghc0WGLJ+05px4XK4px0+bSzE8qij5Q="
Received: from blinux.speedport.ip
    by smtp.strato.de (RZmta 49.6.0 AUTH)
    with ESMTPSA id zb0c8bz5JLIgDvh
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 19 Jun 2023 23:18:42 +0200 (CEST)
From:   Bean Huo <beanhuo@iokpp.de>
To:     viro@zeniv.linux.org.uk, brauner@kernel.org,
        akpm@linux-foundation.org, jack@suse.cz, jack@suse.com,
        tytso@mit.edu, adilger.kernel@dilger.ca, mark@fasheh.com,
        jlbec@evilplan.org, joseph.qi@linux.alibaba.com
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        beanhuo@micron.com
Subject: [PATCH v2 2/5] ext4: No need to check return value of block_commit_write()
Date:   Mon, 19 Jun 2023 23:18:24 +0200
Message-Id: <20230619211827.707054-3-beanhuo@iokpp.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230619211827.707054-1-beanhuo@iokpp.de>
References: <20230619211827.707054-1-beanhuo@iokpp.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Bean Huo <beanhuo@micron.com>

Remove unnecessary check on the return value of block_commit_write(),
because it always returns 0.

Signed-off-by: Bean Huo <beanhuo@micron.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/move_extent.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/move_extent.c b/fs/ext4/move_extent.c
index b5af2fc03b2f..f4b4861a74ee 100644
--- a/fs/ext4/move_extent.c
+++ b/fs/ext4/move_extent.c
@@ -392,14 +392,11 @@ move_extent_per_page(struct file *o_filp, struct inode *donor_inode,
 	for (i = 0; i < block_len_in_page; i++) {
 		*err = ext4_get_block(orig_inode, orig_blk_offset + i, bh, 0);
 		if (*err < 0)
-			break;
+			goto repair_branches;
 		bh = bh->b_this_page;
 	}
-	if (!*err)
-		*err = block_commit_write(&folio[0]->page, from, from + replaced_size);
 
-	if (unlikely(*err < 0))
-		goto repair_branches;
+	block_commit_write(&folio[0]->page, from, from + replaced_size);
 
 	/* Even in case of data=writeback it is reasonable to pin
 	 * inode to transaction, to prevent unexpected data loss */
-- 
2.34.1

