Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF867735EE9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jun 2023 23:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbjFSVTY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Jun 2023 17:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbjFSVTU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Jun 2023 17:19:20 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E2CE64;
        Mon, 19 Jun 2023 14:19:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1687209524; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=AaIvbocbXnLddTJMfkpJqlY+SicR25hAKIFhPjOIulppVG/MQ7mBiD+X9ZfeDzCT6G
    ZhmNMLMT9qWk5HQYS/tbm2VJnWArlDt5rybEIuiyaOV8QcSI3IS0yaY7gXmoj8TowWmm
    zoHLeIIr4JKp/O2mZILLcTlo4XBCvTt7tHIlX2k6Ygqm1xmoFV9tHoak5A6i1sdAkNYg
    emjOLMYe6V3cl15uLorq3YPtvqUUEWhR0AGo6cAZ2rsufFfqdLlBH4L2cPwfpXDKRSDy
    SGPqyqHI58TfX/YdfLaY/Ikv76gRJfujCD8UzuJKIIb6OglA9HvG7XdM4WO5xojWhGnB
    e2+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1687209524;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=e7SgMagTj0KzNfQID209UAiku5Vv3G7zNV+yggrUOg0=;
    b=Ew+b/YKs8kx7BkXCAj0i4MlXqoZ2AWq5VKfYj0Anc0b/qiUpfrwMux6D1Qyn40jisZ
    Rb4EmNjQiDzRlMPVzEgy3jC6MBfCiK70jA+b8dT/FKCMnl4zak4syhDOX4ih9k1z0LZN
    i+y6AjnMxEBac2WhLAAMrlxVOFqi/8wieGhhh3dPVj9OYxB+GN6dnRSfMo792BssGdYA
    o1rqqNeCVZ3UvFiMOKMwDuwGp82JmEWBrjPYroyfq9iRVVwLbpnSP3BflnhCXBXbA7cS
    ZzaQNRApre3d/pYSgSou04EXqBAN3MTx1TBOwgGSGrA0w5xZyDZqvHH1NGZGj7El04+k
    13IA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1687209524;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=e7SgMagTj0KzNfQID209UAiku5Vv3G7zNV+yggrUOg0=;
    b=tnMfLNKBqdAppzTDzen+nISXF+7zLhHNYWQb7OCNkxdOzGrSO2c35RA972mfouTBzA
    bFgCMbKzliAdxQM1PscO6XLaGolVQm1yNZ3uUXSVzFr+rR7hXLbbEE+chqY3mOo9wTYr
    aLYBALR5LOF9cbisSX1wvpPXKrRdlMoNSMvqdpxgDNoUVj/68dpo8A3JAKA1XVxB6PrU
    Brw0yaPJWcO0lggtGTLy6SYdWZzobHjda1UYvbRqKUNJVGR7THmodrnrP++iW+1hpzvg
    VXW9QAiFA5tkz1Q+q0Zh+UDjpdqAePj6TJ/jKMLz6VA/A9qxlg2o638P/BfnfhSo0V4h
    DQbA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1687209524;
    s=strato-dkim-0003; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=e7SgMagTj0KzNfQID209UAiku5Vv3G7zNV+yggrUOg0=;
    b=yvRWX6/xx1vRUETU4+aQN4AZUBe951mXyeNy1E+9TrEe/RAbSDFqU8p1dKwDt8G2aX
    7tZhIOxKcytpoqWrLYCQ==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSedrgBzPc9DUyubU4DD1EQ33bneoxgmq7ABeEwyjghc0WGLJ+05px4XK4px0+bSzE8qij5Q="
Received: from blinux.speedport.ip
    by smtp.strato.de (RZmta 49.6.0 AUTH)
    with ESMTPSA id zb0c8bz5JLIhDvi
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 19 Jun 2023 23:18:43 +0200 (CEST)
From:   Bean Huo <beanhuo@iokpp.de>
To:     viro@zeniv.linux.org.uk, brauner@kernel.org,
        akpm@linux-foundation.org, jack@suse.cz, jack@suse.com,
        tytso@mit.edu, adilger.kernel@dilger.ca, mark@fasheh.com,
        jlbec@evilplan.org, joseph.qi@linux.alibaba.com
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        beanhuo@micron.com
Subject: [PATCH v2 3/5] fs/ocfs2: No need to check return value of block_commit_write()
Date:   Mon, 19 Jun 2023 23:18:25 +0200
Message-Id: <20230619211827.707054-4-beanhuo@iokpp.de>
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

