Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18F4E7348A3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Jun 2023 23:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjFRVgQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 18 Jun 2023 17:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbjFRVgI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 18 Jun 2023 17:36:08 -0400
Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [85.215.255.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD35DE49;
        Sun, 18 Jun 2023 14:36:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1687123988; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=tEdXkdk7eABTemTjAU3iVebaYm3Bzh3MWbiQBoyEfdn2aJ2yeIRsy40d61YZQMufmE
    gqAjOYupLuO2sQ7v0KLbNqbFBG78din/tYVrvJ224Tqx10k4g8WWbn3SbOs8CcopWs0l
    pbMHLb23pfZT9K9Xl9XQKoyrtlDWQfrOWmbdO6vpEpSalm6Kz3ZdlLDiJPW0/xzHHR6d
    fNZoZOEKvQ9ITPPJGvcVwYPS5jhXS/91xafwSu0K1IQbA/4ckyi1/iQndKROuK5P4R2j
    xga3ZGIHDKSyepMGAx+n9OWOfKttP8ye/ZHWu/MtADofar2WEFRTVILO3MTH/SFU7C87
    EUqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1687123988;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=f2kgEMuIUUrHM5gBc5Sm8qQWNSiMWwhC4tlGu4p/URc=;
    b=mf4ehWkiTNgGioBCJaewTZnI1CdsXpb+P0qZdNlZ5uExOHHr/sHp7Zxxr1HJHRMxsR
    UpyBn8CHIdbcr2GvduRetEJBlLVVz0kIMCoa3yrPnggf5pPtI3hkgw8c4B/zvB5cHH+p
    3WoLtOWkjrPjnvrG1yCS1r9oRveLq8owWXIgI26EuNa0sIrkh1a3X5qIPEcRuUAlWBiP
    PSy1ynNnPl/i5KD5612T3HyUkpOS/re+MtQXCMyHPtKawIs9ItiMovYSY75AjK8RKr1U
    LdIJpXk1G40ViTZsZ8YEqNjVMPSntbzT6nhbgB633z/Ve5LrDl34fhD8F0HQ0d/AexPL
    WtyQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1687123988;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=f2kgEMuIUUrHM5gBc5Sm8qQWNSiMWwhC4tlGu4p/URc=;
    b=bahHsnk+VQ49NmAqeLTyYIKH088rJ1bhhGqTig2deRUwdhreH04FLhPBSzPS8x+yfp
    uPB5yunDDa7hg9ZbQ4mb61q+tnqM851gEjy3lnlnRJUS424IqyqHMEiTXsdCxNksB8C+
    7PQ8fHHwSf/G7IvOFUB5x1BV8pz83J7MBKIr7W24WN3HedKW6h5GEcXW9Ex1CLJfMKA7
    XaLTi1mpIRR36fVGHm/DCtarnG2G6ohYongfl0I62htqcG+jwkOL2D0cZeZVM9aFruMI
    8b1zfnqRKjrul1Zw+r2MTm+s4VdW+cQat0njR4Xf8YG6RUmOrnxn8LzxLN/GWFJrT/ax
    X1TQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1687123988;
    s=strato-dkim-0003; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=f2kgEMuIUUrHM5gBc5Sm8qQWNSiMWwhC4tlGu4p/URc=;
    b=dBt5lKWS8dqmRtY3qC7MaiFJqdMJFpEDTtsjzVMd/Pp8QsibX0A12xfWvfoG/iAKeA
    R8g9/41dk9kwuat6UcAg==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSedrgBzPc9DUyubU4DD1EQ33bneoxgmq5ARfEwes1hW/CxwfjqKzP/cKnUXGNs35zouFQhI="
Received: from blinux.speedport.ip
    by smtp.strato.de (RZmta 49.6.0 AUTH)
    with ESMTPSA id zb0c8bz5ILX7AHN
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sun, 18 Jun 2023 23:33:07 +0200 (CEST)
From:   Bean Huo <beanhuo@iokpp.de>
To:     viro@zeniv.linux.org.uk, brauner@kernel.org,
        akpm@linux-foundation.org, jack@suse.cz, jack@suse.com,
        tytso@mit.edu, adilger.kernel@dilger.ca, mark@fasheh.com,
        jlbec@evilplan.org, joseph.qi@linux.alibaba.com
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        beanhuo@micron.com
Subject: [PATCH v1 5/5] udf: No need to check return value of block_commit_write()
Date:   Sun, 18 Jun 2023 23:32:50 +0200
Message-Id: <20230618213250.694110-6-beanhuo@iokpp.de>
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

