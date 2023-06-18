Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4447B73489B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Jun 2023 23:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjFRVgG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 18 Jun 2023 17:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjFRVgF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 18 Jun 2023 17:36:05 -0400
X-Greylist: delayed 174 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 18 Jun 2023 14:36:04 PDT
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD67E1;
        Sun, 18 Jun 2023 14:36:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1687123986; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=VM4BVadLBxSmWrHdO2AnIMFg3ThohSaWQHyt8CN0gGgrgT5Efki2XHTvsdgrx1ulnu
    gi1cVRMSfGGBnxqq3Up+SVlG+6HLgZhTJ+pEKilpmwR2A4+BFS9DoFhf3z0sgA8O+SmS
    +nEEpKuMAaL+L7rzmqyg8GpEFroyX8gqjmMCjftc6+gE0I4cP5FKwRB/GIUme3aNGAjQ
    Mu9f5JPR+wgaBVmKO0LuS1DA5hLKntZTsVoTvEhI9tQ7B/+gmj9Fq7j6CU+xz3RdGfm7
    x01gQu+hPEqCr5fg+ETD82JFu/XYJAIf2k3ebb2hjNJqje57KvmfnK9wwbX2M7wYVRLR
    fReg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1687123986;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=6ppbOx/Qif038c3YguD4sRfoT+KAp+bNCu/5t81cezc=;
    b=Ne0eZfHTFUALLrUFdk+Mulsr50qZ7017Hu6VyizDLMjGT45FpEu8baz/jcu33NlyhR
    kNT0gTjYuWT5l7lxhTATOY+4uQnJqU4xPyKBmq3d8g895uLh1PuSwXlXH59hZB6Hj/kV
    /RPpksFyRS9tHYP7tQb2F2wWF39Kay4SpNY2QYV+2SvbGyFx49NKr2KTpco9f5R2erVZ
    tA38sJhLXJaNmQYypvIRVUgg58TFeSyG3qelpcWjbSpGHLxYWDo1JDk4GopqXW6KvaaJ
    dJXTHLmnMQCbKYsgWTwtcW9nND/cnQ4Jm8zr6ihU8EY8iQUacB3nzWzq6twRa4qNiZdG
    7NnA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1687123986;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=6ppbOx/Qif038c3YguD4sRfoT+KAp+bNCu/5t81cezc=;
    b=rm1C4aDn5s8p0jiPCSQS5e33N+QMhMYX/pDLrHunRRLY82ZzC79ofe7ts6o6S9db1m
    Lv7Y5hzySS8uRR66xnJLkU2Sjeyuj8Adcq48IFxbNoq03zd70IyYvmu0Pkd/JfsZhHio
    2JMb7GZaAA3fGeds4hxUJieADdqHEeB3ehdTQinwcA3J82eiAGQUgpWU/6speQS27RgD
    wCMRuwmubaVUc159E62Bm6I9RmJUR5MoHjQLTv2f9hqsvHVNCaKLw8e8ro+CLkRSir1+
    Pt6a1MhtQExsqm+6T6TVUNbTmw+FqRMdzeJfiN6csLCKWsVaGLvAEJJwvy097UnGynCk
    cfIg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1687123986;
    s=strato-dkim-0003; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=6ppbOx/Qif038c3YguD4sRfoT+KAp+bNCu/5t81cezc=;
    b=NvePtc2m2+fdgfTJNzrxCVuc1a5tkuX9Juc9ovSF6j+el0TNLXge5NTjT7AAYUd0kv
    N5FeFsHWiyo5iEgg0QDg==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSedrgBzPc9DUyubU4DD1EQ33bneoxgmq5ARfEwes1hW/CxwfjqKzP/cKnUXGNs35zouFQhI="
Received: from blinux.speedport.ip
    by smtp.strato.de (RZmta 49.6.0 AUTH)
    with ESMTPSA id zb0c8bz5ILX5AHL
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sun, 18 Jun 2023 23:33:05 +0200 (CEST)
From:   Bean Huo <beanhuo@iokpp.de>
To:     viro@zeniv.linux.org.uk, brauner@kernel.org,
        akpm@linux-foundation.org, jack@suse.cz, jack@suse.com,
        tytso@mit.edu, adilger.kernel@dilger.ca, mark@fasheh.com,
        jlbec@evilplan.org, joseph.qi@linux.alibaba.com
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        beanhuo@micron.com
Subject: [PATCH v1 3/5] ext4: No need to check return value of block_commit_write()
Date:   Sun, 18 Jun 2023 23:32:48 +0200
Message-Id: <20230618213250.694110-4-beanhuo@iokpp.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230618213250.694110-1-beanhuo@iokpp.de>
References: <20230618213250.694110-1-beanhuo@iokpp.de>
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

Remove unnecessary check on the return value of block_commit_write().

Signed-off-by: Bean Huo <beanhuo@micron.com>
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

