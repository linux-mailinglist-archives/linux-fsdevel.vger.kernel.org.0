Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFE2C45650A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Nov 2021 22:28:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbhKRVbp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Nov 2021 16:31:45 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:54023 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229795AbhKRVbn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Nov 2021 16:31:43 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 9390C5C0167;
        Thu, 18 Nov 2021 16:28:42 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 18 Nov 2021 16:28:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=PBHcV6G2LVZWj
        VKQSp+vxvtETx1PYr29gjg4RHiS1Vk=; b=nNXN8mJt9p1Bn+bPDxiw0yfI2/NEG
        2GA3nn7gsHV2Z/e60RtWMPvxCxcnwJLdAim2iYsMVGm8+1c33GA8BF8KkXuJRoP+
        DpaNKOK0JwORMMHy6klTWGs19zyREcpw6cGE2uKEYguV+AdQgDiEiE+FBh4w7Exj
        671h+Bm/P+5EonsH9Q4WxBiLaC568tH7kvHt8oEx0VSJJMGnIqVPt+VCqYmw67AG
        GA1mLyeumLr2w5x0uqqp0rCjauIBppF3XPBALkthMjj84XQn8KrF7kXK31dm/tCo
        o848UHB5HnpHc+t/ruly8StrGrjSJf7hylooEF5hqUq3+7ch7Dd1FnZ1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=PBHcV6G2LVZWjVKQSp+vxvtETx1PYr29gjg4RHiS1Vk=; b=TEqxdgfN
        q1beuaA5KSApFPHjAvuE8fO8mt/M1l8ohcy6yNXFcAF0aCcZ3x9KTCMet/PR+MMW
        SwtvPS4WPm8zO+ZP+GcUy+XbL+K/WWrbfGNbf0k3PHX2Ny7lKliIXEhgm6sDobrf
        9Nh3347LfUdOANO5d9J+XVPk4MZIeaPR3Ery7AbYEk+XLxv0upc/GCnWHnnxwpd1
        z8RiIgQmDNu/nVF2ucmAeK4IAziE0+NUS5WpfxCQkdOGJ2AQSusEHGT/F0KaAV2O
        cSJZvZnL+RB543gYxJwcSZw2BoKtrxSApTVWvOiasHl2qujDODvya0X5AbhMJ4e5
        T41Qj0Fu0Z0wcQ==
X-ME-Sender: <xms:isWWYb9YjMHuMrSo_ojPdGnyP4WtASw8g-_eKEN1pIUJoLO2PpcH0w>
    <xme:isWWYXt_hzpDYSZcy6QEAgUFC5Qj3nw3DpjLCtmrPUh8kMhmD4KRVkQr-STWXuC2h
    vIo2z8srg550i8p5g>
X-ME-Received: <xmr:isWWYZAh_s5UvJ4fs6ZgPV1Nhpin9_B897h9qc43hpUkrdFoc9lQ09JzAGbfkgPPz9TaYNhD9hUrNueh0uZ8-7I2ZSjKGU0-XUyofih1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrfeeigddugeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeevhhhrihhs
    thhophhhvgcugghuqdeurhhughhivghruceotghvuhgsrhhughhivghrsehfrghsthhmrg
    hilhdrfhhmqeenucggtffrrghtthgvrhhnpeekjeettefgieetvdekudevudduvddvueet
    lefhieevffehudfhveeutdevgfekffenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegtvhhusghruhhgihgvrhesfhgrshhtmhgrihhlrdhfmh
X-ME-Proxy: <xmx:isWWYXcW_4kwpiLrO9LI4SVQmKZobS5ehUdg9K4e36OzxqFDfSO_og>
    <xmx:isWWYQM_wxMcJSuvHVhZKFyQVtsoQS4DCG2A9gzLxaLL47Ho2cKmkw>
    <xmx:isWWYZkiaQajVBp0yU6CdnFn0RQ9-B7Z9a6lIk6CKnbvCG8DGjTdTA>
    <xmx:isWWYZYJiIW71xCVMuuqOp_-yFASPSO6LGuLpOi0j9LhORMCCgR3pA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Nov 2021 16:28:41 -0500 (EST)
From:   Christophe Vu-Brugier <cvubrugier@fastmail.fm>
To:     linux-fsdevel@vger.kernel.org
Cc:     Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Christophe Vu-Brugier <christophe.vu-brugier@seagate.com>
Subject: [PATCH 1/1] exfat: fix i_blocks for files truncated over 4 GiB
Date:   Thu, 18 Nov 2021 22:28:28 +0100
Message-Id: <20211118212828.4360-2-cvubrugier@fastmail.fm>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211118212828.4360-1-cvubrugier@fastmail.fm>
References: <20211118212828.4360-1-cvubrugier@fastmail.fm>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christophe Vu-Brugier <christophe.vu-brugier@seagate.com>

In exfat_truncate(), the computation of inode->i_blocks is wrong if
the file is larger than 4 GiB because a 32-bit variable is used as a
mask. This is fixed by casting the variable to loff_t which is 64-bit.

Also fix the same computation in exfat_read_root().

This commit is similar to Sungjong Seo's fix in exfat_fill_inode()
last month:

  commit 0c336d6e33f4 ("exfat: fix incorrect loading of i_blocks for
                        large files")

Signed-off-by: Christophe Vu-Brugier <christophe.vu-brugier@seagate.com>
---
 fs/exfat/file.c  | 2 +-
 fs/exfat/super.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/exfat/file.c b/fs/exfat/file.c
index 6af0191b648f..109ade79da33 100644
--- a/fs/exfat/file.c
+++ b/fs/exfat/file.c
@@ -252,7 +252,7 @@ void exfat_truncate(struct inode *inode, loff_t size)
 		mark_inode_dirty(inode);
 
 	inode->i_blocks = ((i_size_read(inode) + (sbi->cluster_size - 1)) &
-			~(sbi->cluster_size - 1)) >> inode->i_blkbits;
+		~((loff_t)sbi->cluster_size - 1)) >> inode->i_blkbits;
 write_size:
 	aligned_size = i_size_read(inode);
 	if (aligned_size & (blocksize - 1)) {
diff --git a/fs/exfat/super.c b/fs/exfat/super.c
index 5539ffc20d16..ea16769380c6 100644
--- a/fs/exfat/super.c
+++ b/fs/exfat/super.c
@@ -364,8 +364,8 @@ static int exfat_read_root(struct inode *inode)
 	inode->i_op = &exfat_dir_inode_operations;
 	inode->i_fop = &exfat_dir_operations;
 
-	inode->i_blocks = ((i_size_read(inode) + (sbi->cluster_size - 1))
-			& ~(sbi->cluster_size - 1)) >> inode->i_blkbits;
+	inode->i_blocks = ((i_size_read(inode) + (sbi->cluster_size - 1)) &
+		~((loff_t)sbi->cluster_size - 1)) >> inode->i_blkbits;
 	EXFAT_I(inode)->i_pos = ((loff_t)sbi->root_dir << 32) | 0xffffffff;
 	EXFAT_I(inode)->i_size_aligned = i_size_read(inode);
 	EXFAT_I(inode)->i_size_ondisk = i_size_read(inode);
-- 
2.33.0

