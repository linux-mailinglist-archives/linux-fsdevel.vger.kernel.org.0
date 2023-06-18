Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEE3F734895
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Jun 2023 23:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjFRVdW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 18 Jun 2023 17:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjFRVdV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 18 Jun 2023 17:33:21 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB9FCE1;
        Sun, 18 Jun 2023 14:33:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1687123987; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=pLEHJ/bKY0zR7WfVem2YJX11hI5zcyydSYNrxDhLqLUbG2eh5hktn73AF1yxlwqMpY
    g/ARQjKIM9Lry5xsVby9JTIq4HbhPhyyh2bBtLKJYbUt/CvLVCe7zNdGaWF/TSkISzOw
    HqDwsUuBXDn4ahcCZqQ576hepzZRQYD6feXBbkVO49mZBNZti/lxcGjBC9YPT/4v/D3B
    9GSsOc7VPjYQ7dgyWlukJCLLh++tza2j5IrxgDhrqq+7g86Av4rkvHpsko32TxJ3WclB
    4CSTeJw7QSK6fgZs6bh/rfV5idezwMvQ/semvtQtCs+dp0eAOHYbnMW1JSbpoAJmHA3f
    /9eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1687123987;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=ByE+GUzwLDG5usz6jIof8CLTzZ6sYXPxh+V91S3i84U=;
    b=W8l2heUn/qa9X6uxx9qZLX8bsfkjD1TyNpx7NIlB8Gnmr90fhd4c1Sl6boZCyjfeR5
    kAD8fr51l2ZvCr2g/uxT6XHmnbgB3TmwkHbzh3fgtHvp23vz23ySCVm7VIQYYVJKll36
    ZPKytI+0d0mwhlUcX9UOWBJGM+cTUiSOGAfoLprazJMlzQS3JwnpcFdrfC1R+Fxdsjsu
    gbjhn+oXinSlWJngIq2ITgzVZh+2VWPCdw/nPgnQOQ6fto20AuNtXnZmxtJ4cmFtULXH
    x9l+aryDOaA6fKejukojxwupuNGDUw/3dUQx4NC52LyQ8DmwwBSQjiLGrGjYGszvY32r
    naNg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1687123987;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=ByE+GUzwLDG5usz6jIof8CLTzZ6sYXPxh+V91S3i84U=;
    b=I/Sam9ubiVNWnsYHM4Uz6c4kDnTzvMysr+UiOj6HJZIkBo+wMoVNH5A/vTf9eYMLoM
    13Mqc3UasIbqYpxQ+iuJDkoHvWuKaCy0y765bFXo7cts4FPXEcLIDlATt/O8AVvvtm8+
    4xASk8jV2skvOTGJ2/FFH2MaYWmXGMEcFImuOAuyYx3jitdFoFSXc2V5sYsINEFltzg+
    yK3Y14rSsN27mg1HG9aL/iUKcsMD/mNqMY+hWDgz81uxsoxYA/m2FKrk2te4DzI+WWfg
    3wtLLUgMcIm1W8pxknPaTRJuaDh5P3T9liRplpwq5UN947Fi6Js8ewuAdNdXmYRPKUki
    GF7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1687123987;
    s=strato-dkim-0003; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=ByE+GUzwLDG5usz6jIof8CLTzZ6sYXPxh+V91S3i84U=;
    b=R2J1VAchfVBP7IiVOUW+S6F/wiHWLIMM2xxuk2gf6Ug7a0Z5LFWJyXUGOKBW+C16Xy
    pE9ZAu31RN7r+LTMBFCA==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSedrgBzPc9DUyubU4DD1EQ33bneoxgmq5ARfEwes1hW/CxwfjqKzP/cKnUXGNs35zouFQhI="
Received: from blinux.speedport.ip
    by smtp.strato.de (RZmta 49.6.0 AUTH)
    with ESMTPSA id zb0c8bz5ILX6AHM
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sun, 18 Jun 2023 23:33:06 +0200 (CEST)
From:   Bean Huo <beanhuo@iokpp.de>
To:     viro@zeniv.linux.org.uk, brauner@kernel.org,
        akpm@linux-foundation.org, jack@suse.cz, jack@suse.com,
        tytso@mit.edu, adilger.kernel@dilger.ca, mark@fasheh.com,
        jlbec@evilplan.org, joseph.qi@linux.alibaba.com
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        beanhuo@micron.com
Subject: [PATCH v1 4/5] fs/ocfs2: No need to check return value of block_commit_write()
Date:   Sun, 18 Jun 2023 23:32:49 +0200
Message-Id: <20230618213250.694110-5-beanhuo@iokpp.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230618213250.694110-1-beanhuo@iokpp.de>
References: <20230618213250.694110-1-beanhuo@iokpp.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_TEMPERROR autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Bean Huo <beanhuo@micron.com>

Remove unnecessary check on the return value of block_commit_write().

Signed-off-by: Bean Huo <beanhuo@micron.com>
---
 fs/ocfs2/file.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
index efb09de4343d..39d8dbb26bb3 100644
--- a/fs/ocfs2/file.c
+++ b/fs/ocfs2/file.c
@@ -808,12 +808,7 @@ static int ocfs2_write_zero_page(struct inode *inode, u64 abs_from,
 
 
 		/* must not update i_size! */
-		ret = block_commit_write(page, block_start + 1,
-					 block_start + 1);
-		if (ret < 0)
-			mlog_errno(ret);
-		else
-			ret = 0;
+		block_commit_write(page, block_start + 1, block_start + 1);
 	}
 
 	/*
-- 
2.34.1

