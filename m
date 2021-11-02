Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6914437C4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Nov 2021 22:24:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbhKBV1a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Nov 2021 17:27:30 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:45577 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229981AbhKBV13 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Nov 2021 17:27:29 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 148EB3201FBE;
        Tue,  2 Nov 2021 17:24:53 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 02 Nov 2021 17:24:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=4pvxkxrTUGgD+
        6CbV5TEOBVWpUydrDvhH4Xqb61xeuM=; b=D1L4YI8Treao4xTOTNgiSl4DGuyVo
        9jgRSdcugSFeSpKygOkunbMTkhw00gZGO1WhSXaPhaVSoD0pXmqNVOG+Vz6yUPii
        DNYdP9yrVmeVWMbXknWsXJDfdN1OHTSZW/lmjVOBCNlb/3gTnQCKPxDZ9Jy1UkPR
        G3Weo6TAojzzLJIHubxQESIwElHZ17AN95ruyYmlP6BAdavUICcAwOSReQciMX+g
        RRfrQ7iLLVfISpLksZINQzryQHUIKcdc3+1lCFD3gOtku7Rz6TOOwiYgmpnRFVs1
        r6rhfYV9gHGUlPEi6xC8wkKV84Ji9cEhe9r+H75Ln/5NW3nnbJBfcJ4BQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=4pvxkxrTUGgD+6CbV5TEOBVWpUydrDvhH4Xqb61xeuM=; b=U1T6rwxi
        8llkp1vb7YhYwT/FnlgceOK89HH0RAQs5ThL9q5tlsioPGSWZwtJivZ8LbjRtN9S
        9X6vnat1O9xYuRP0nOK3JbtsgS66fdZHI3Qqblhrv+bxQs5RfCa2Kx2TNx0JmJod
        CN4TxkFHlIuv+83eLRTrt/SCOTHwu/xqFEiG5909x9pPLFTn7CGyRpL0RGtTEtsy
        SfkwIO2zOHxLoTE8r6odt8M7wp07hy5YB2R0fJu6lX+i1FhsHYuuq8dH+I6TW0EP
        tmNq8b6SF21IZ1d52jrnza18KJwmPDhbdV1/PWh8UH6vnoqOUamyUcC6LxbIy+cc
        lYTA80EY5N9YdQ==
X-ME-Sender: <xms:payBYTaL_sCw3Q-2CvyymJRQA5YK_vtZIn29o0de4HyVKpHwnbEg1g>
    <xme:payBYSbmMU8pctTr2NcHi_iLeBvtFqvGJipJiju5Bz61Cc3XKOtjGPe1H7S5HT4R5
    Bq8hjFBqfRlKMN4Mw>
X-ME-Received: <xmr:payBYV96baO6wJO56aqcTG8yDyjo6MyF6AVgWzDmRIEC5Jets10qVSZqKrtUSkJ1vfW9uHJUVIKoW7O1Xjtmovv_i_fNFPALo4EBUzh->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrtddtgdduvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeevhhhrihhs
    thhophhhvgcugghuqdeurhhughhivghruceotghvuhgsrhhughhivghrsehfrghsthhmrg
    hilhdrfhhmqeenucggtffrrghtthgvrhhnpeekjeettefgieetvdekudevudduvddvueet
    lefhieevffehudfhveeutdevgfekffenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegtvhhusghruhhgihgvrhesfhgrshhtmhgrihhlrdhfmh
X-ME-Proxy: <xmx:payBYZrgBWh8BN8SeTs9XS8ojYaemWzdl3Wj9MQ5UxnCDLIlzFImgA>
    <xmx:payBYerBhmgfvEb3sev32UE72ZrUUaOk0nswNl1EDhkVECz3NNZ54Q>
    <xmx:payBYfRoN8RRm_gTdqfukqAzE_7zp1UQKOKa8Ysfzr7Qla82vJeR6w>
    <xmx:payBYV1ibEVdbCfQlswdLzjrlQg4KWwV1mfxMgt2WS9VNKd180nT3Q>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Nov 2021 17:24:52 -0400 (EDT)
From:   Christophe Vu-Brugier <cvubrugier@fastmail.fm>
To:     linux-fsdevel@vger.kernel.org
Cc:     Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Christophe Vu-Brugier <christophe.vu-brugier@seagate.com>
Subject: [PATCH 2/4] exfat: fix typos in comments
Date:   Tue,  2 Nov 2021 22:23:56 +0100
Message-Id: <20211102212358.3849-3-cvubrugier@fastmail.fm>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211102212358.3849-1-cvubrugier@fastmail.fm>
References: <20211102212358.3849-1-cvubrugier@fastmail.fm>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christophe Vu-Brugier <christophe.vu-brugier@seagate.com>

Signed-off-by: Christophe Vu-Brugier <christophe.vu-brugier@seagate.com>
---
 fs/exfat/dir.c   | 2 +-
 fs/exfat/inode.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
index cb1c0d8c1714..ac14055bf38a 100644
--- a/fs/exfat/dir.c
+++ b/fs/exfat/dir.c
@@ -892,7 +892,7 @@ struct exfat_entry_set_cache *exfat_get_dentry_set(struct super_block *sb,
 		es->bh[es->num_bh++] = bh;
 	}
 
-	/* validiate cached dentries */
+	/* validate cached dentries */
 	for (i = 1; i < num_entries; i++) {
 		ep = exfat_get_dentry_cached(es, i);
 		if (!exfat_validate_entry(exfat_get_entry_type(ep), &mode))
diff --git a/fs/exfat/inode.c b/fs/exfat/inode.c
index 1c7aa1ea4724..98292b38c6e2 100644
--- a/fs/exfat/inode.c
+++ b/fs/exfat/inode.c
@@ -31,7 +31,7 @@ static int __exfat_write_inode(struct inode *inode, int sync)
 		return 0;
 
 	/*
-	 * If the indode is already unlinked, there is no need for updating it.
+	 * If the inode is already unlinked, there is no need for updating it.
 	 */
 	if (ei->dir.dir == DIR_DELETED)
 		return 0;
-- 
2.20.1

