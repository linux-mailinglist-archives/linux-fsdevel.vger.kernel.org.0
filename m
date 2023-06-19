Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED9C735EEF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jun 2023 23:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjFSVT4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Jun 2023 17:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbjFSVTe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Jun 2023 17:19:34 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A9610DE;
        Mon, 19 Jun 2023 14:19:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1687209525; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=bwDqLgqKnOIMa/KblGf7DCSOdomLj8qYLhRv9zU+ahqAVFoKEz5MFu0kXcY8KfhAXH
    tHC35vZ8b79c/wGpvuuwH2QAaTfqAoLCrBrZuHJJxWbHerBhq4PUi7Vxha3Lt8BBT++a
    OKVlUPZx2OqKhR369+AJkjCvIKU41m/VrYs2EeUKGffe4ZoycTYRomCfx4Cxb4nkBfob
    KFzO1JtbymOdSs9rmP9sHp/HzaLQpEkbXDikDDwi92tnabyBRhSnzBjy4mUV9h9H0BmU
    ZZEguartBN4n56Vgd2iftbjGb/E/g0Hu7r1bdkURzOMI+R21jP1xUByJNPN4IFLifAGU
    6Z4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1687209525;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=u8a2OuOvxT1/oVmGmWM7pshVQC/wQv12L8jJddp76/w=;
    b=gZvQrwnarG0oeqM2lTZmo1obElmXryHEiGl5rTaOMytcF5GV6qb10JQRUSTlk78ZBr
    my2uhiRb7tODlRKlJfZGIMoWNHPtrxmySJWu32wwNlOkOy/CgjyhF3rfjwRPYzKdUJyA
    Y9Jp/f6lEFTd98Lm3aTZ3eAiF2SAjfE6536aVxKU4p82uao+Cjm5vpmj4aiCg5/w4OAz
    vXyLTe5Cqi4B70Mwo6078rUhPgHS/Nw9w8zI6M49hVkhWreHqAwDLzEl5Z+N3kyK3Ewk
    YnnuTk4NqUi55Ri4legQKGcYEdb3sVl6poNHO7b+6p22wVKdoRjfzekB9cuh1zcYyOaA
    /vBQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1687209525;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=u8a2OuOvxT1/oVmGmWM7pshVQC/wQv12L8jJddp76/w=;
    b=NWHvLYHVBE3vESRJ/FKFx1BobgaCF60h+WBAXiODGLsXtceWhYn7PgNv3MV5MXctni
    FK/8gdXtnsHydylzQbFCYdTwzC4MZmRWSP6OYqsFThJ0kysIE4SDRaLDFxoaXFZLA1xC
    XckGwVvQhj63Lc9eVAzGHMasn7FQiEPnYraBh8/Ygwm7C3hujqBNPYoJp/F04jznI2Qz
    OnQixCQPT3StmDtCX5MrkWLj67MM9yggscCU3RdXslVV0bNEHGn/bYstka/MGSE5IKVe
    QK2OuVNkugRG7bF3ujpI8fK653bXfGgH3fyF2pfZIilyQ7l6tkBDYI3BaO8mzAzaxnGp
    vZQQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1687209525;
    s=strato-dkim-0003; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=u8a2OuOvxT1/oVmGmWM7pshVQC/wQv12L8jJddp76/w=;
    b=4rKvSZyKZJICpIQNJpD8yX06uHxBEBD8VbMS0AWhaOLUZImM7784EgsI2s7KDFBrz/
    ua48CzseU5n1lhgMvhAA==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSedrgBzPc9DUyubU4DD1EQ33bneoxgmq7ABeEwyjghc0WGLJ+05px4XK4px0+bSzE8qij5Q="
Received: from blinux.speedport.ip
    by smtp.strato.de (RZmta 49.6.0 AUTH)
    with ESMTPSA id zb0c8bz5JLIiDvj
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 19 Jun 2023 23:18:44 +0200 (CEST)
From:   Bean Huo <beanhuo@iokpp.de>
To:     viro@zeniv.linux.org.uk, brauner@kernel.org,
        akpm@linux-foundation.org, jack@suse.cz, jack@suse.com,
        tytso@mit.edu, adilger.kernel@dilger.ca, mark@fasheh.com,
        jlbec@evilplan.org, joseph.qi@linux.alibaba.com
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        beanhuo@micron.com
Subject: [PATCH v2 4/5] udf: No need to check return value of block_commit_write()
Date:   Mon, 19 Jun 2023 23:18:26 +0200
Message-Id: <20230619211827.707054-5-beanhuo@iokpp.de>
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
 fs/udf/file.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/udf/file.c b/fs/udf/file.c
index 8238f742377b..b1a062922a24 100644
--- a/fs/udf/file.c
+++ b/fs/udf/file.c
@@ -67,13 +67,13 @@ static vm_fault_t udf_page_mkwrite(struct vm_fault *vmf)
 	else
 		end = PAGE_SIZE;
 	err = __block_write_begin(page, 0, end, udf_get_block);
-	if (!err)
-		err = block_commit_write(page, 0, end);
-	if (err < 0) {
+	if (err) {
 		unlock_page(page);
 		ret = block_page_mkwrite_return(err);
 		goto out_unlock;
 	}
+
+	block_commit_write(page, 0, end);
 out_dirty:
 	set_page_dirty(page);
 	wait_for_stable_page(page);
-- 
2.34.1

