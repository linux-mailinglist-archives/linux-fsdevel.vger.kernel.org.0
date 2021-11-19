Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7593E457593
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Nov 2021 18:37:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236741AbhKSRks (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Nov 2021 12:40:48 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:38475 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236575AbhKSRkr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Nov 2021 12:40:47 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 3BABF3201D82;
        Fri, 19 Nov 2021 12:37:45 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 19 Nov 2021 12:37:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=h03ECZ894lLyR
        orXSJYYjkS8jeFWg5nLRJr7bns6ZSo=; b=gfeJfhhk2VwqSJbJ5b4QZoDvR9HjS
        /zVMuM1q0KqwkDgdhTjxrA4W7b584TpwaxrYDmv43++epc6NO8rjJ8yfH2GoJEIJ
        05YZFgR9A0n4Tfa2hqjOiAGnvHr+F51hwZjkG5yssZpcpkV+mUllIQ/o7/MTRhQO
        uSczMb+RwmdDgrSGnx4EvZBy6tfbJYZ99o59toEWxMy6HQXM8Eqdw+lmHFDi76IQ
        2BR2NEqmnfqqc5AEurdmrM8PQ9T3BEh7DWh149Z4/67iMmFcx4sudhsO0mYxgHpz
        fRXvdhYObgBmdxgkofpVOdF+VGETF68vzmPXtkBwnoZYwWrGC5os9VKZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=h03ECZ894lLyRorXSJYYjkS8jeFWg5nLRJr7bns6ZSo=; b=O+O+Iet0
        jgBZAED7D/OZZbLuWLNBtwYr4KXnr4js60Ht6HLFb0Zs+OjMhvfyX5UCG43i/gND
        91BiEcmyBSMx8Q4gH6Zpaapboj8Kd7v9xbHaDaZNEt0ywoOGkWwkrh9dxJKtGFEQ
        PBuk6mXtluYYQxZtzz+nAa398Cd58iwOLYe3pKn/DxvvY+Ty4xdZsKpZL5mFWo1u
        bYs5xdeSgIoJKjD5/TKPQkKQj62hS70phwMvXKYh7fYV6kM8Ga7hcP3odo1cqF1S
        2zWzc4r5Qr/51TnNDJNvhRH4MIVMp9uqu5oMDHz8A7GWgR5hgkgq4vQm/I346IIS
        Su4UYDlTrTPPcw==
X-ME-Sender: <xms:6OCXYdAdeT9Sl2YLg4NXWjwf_764hYYe1iniEWyInIsrKcYNreAs4g>
    <xme:6OCXYbitEPtjXuIlqM1Nf_pLBKbQaARVT_sKpk7qskUEMCl4VDND0WDYK-ukW1jHo
    bBb5DK0VNmWtN0jXw>
X-ME-Received: <xmr:6OCXYYmfLY89D9qR1VdrsUaCT8dI1vauXmtUGkacb_GG5b2QIYZ2dDZyeewH6ovaCj_cllrVRKAan7dsLVFX224it3ZtVFWM_46TGwPi>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrfeekgddutdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeevhhhrihhs
    thhophhhvgcugghuqdeurhhughhivghruceotghvuhgsrhhughhivghrsehfrghsthhmrg
    hilhdrfhhmqeenucggtffrrghtthgvrhhnpeekjeettefgieetvdekudevudduvddvueet
    lefhieevffehudfhveeutdevgfekffenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegtvhhusghruhhgihgvrhesfhgrshhtmhgrihhlrdhfmh
X-ME-Proxy: <xmx:6OCXYXxv8RhAsaE0FVOxTKCXVWaEUEWTeFlMo9eWmseaQG4SaavkUg>
    <xmx:6OCXYSSkiRPIRxsFqnVW0V8jX_Zf8TBHMFIU-klu0kSss4zXvb9Wug>
    <xmx:6OCXYabXKQVR8YJ2QLvAnW0AGbPq9KsevSlWucZskvCG6h7pd0NzlQ>
    <xmx:6OCXYQdM-9HjhzRK0yEycIiJTRipjtQtzQIbp8K5V9WHjFdUtKkSiA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Nov 2021 12:37:43 -0500 (EST)
From:   Christophe Vu-Brugier <cvubrugier@fastmail.fm>
To:     linux-fsdevel@vger.kernel.org
Cc:     Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christophe Vu-Brugier <christophe.vu-brugier@seagate.com>
Subject: [PATCH v2] exfat: fix i_blocks for files truncated over 4 GiB
Date:   Fri, 19 Nov 2021 18:37:34 +0100
Message-Id: <20211119173734.2545-1-cvubrugier@fastmail.fm>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <YZbKobiUUt6eG6zQ@casper.infradead.org>
References: <YZbKobiUUt6eG6zQ@casper.infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christophe Vu-Brugier <christophe.vu-brugier@seagate.com>

In exfat_truncate(), the computation of inode->i_blocks is wrong if
the file is larger than 4 GiB because a 32-bit variable is used as a
mask. This is fixed and simplified by using round_up().

Also fix the same buggy computation in exfat_read_root() and another
(correct) one in exfat_fill_inode(). The latter was fixed another way
last month but can be simplified by using round_up() as well. See:

  commit 0c336d6e33f4 ("exfat: fix incorrect loading of i_blocks for
                        large files")

Signed-off-by: Christophe Vu-Brugier <christophe.vu-brugier@seagate.com>
Suggested-by: Matthew Wilcox <willy@infradead.org>
---
 fs/exfat/file.c  | 4 ++--
 fs/exfat/inode.c | 4 ++--
 fs/exfat/super.c | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/exfat/file.c b/fs/exfat/file.c
index 6af0191b648f..3dafd3c013d7 100644
--- a/fs/exfat/file.c
+++ b/fs/exfat/file.c
@@ -251,8 +251,8 @@ void exfat_truncate(struct inode *inode, loff_t size)
 	else
 		mark_inode_dirty(inode);
 
-	inode->i_blocks = ((i_size_read(inode) + (sbi->cluster_size - 1)) &
-			~(sbi->cluster_size - 1)) >> inode->i_blkbits;
+	inode->i_blocks = round_up(i_size_read(inode), sbi->cluster_size) >>
+				inode->i_blkbits;
 write_size:
 	aligned_size = i_size_read(inode);
 	if (aligned_size & (blocksize - 1)) {
diff --git a/fs/exfat/inode.c b/fs/exfat/inode.c
index 1c7aa1ea4724..464282376483 100644
--- a/fs/exfat/inode.c
+++ b/fs/exfat/inode.c
@@ -603,8 +603,8 @@ static int exfat_fill_inode(struct inode *inode, struct exfat_dir_entry *info)
 
 	exfat_save_attr(inode, info->attr);
 
-	inode->i_blocks = ((i_size_read(inode) + (sbi->cluster_size - 1)) &
-		~((loff_t)sbi->cluster_size - 1)) >> inode->i_blkbits;
+	inode->i_blocks = round_up(i_size_read(inode), sbi->cluster_size) >>
+				inode->i_blkbits;
 	inode->i_mtime = info->mtime;
 	inode->i_ctime = info->mtime;
 	ei->i_crtime = info->crtime;
diff --git a/fs/exfat/super.c b/fs/exfat/super.c
index 5539ffc20d16..bd04c8b25b59 100644
--- a/fs/exfat/super.c
+++ b/fs/exfat/super.c
@@ -364,8 +364,8 @@ static int exfat_read_root(struct inode *inode)
 	inode->i_op = &exfat_dir_inode_operations;
 	inode->i_fop = &exfat_dir_operations;
 
-	inode->i_blocks = ((i_size_read(inode) + (sbi->cluster_size - 1))
-			& ~(sbi->cluster_size - 1)) >> inode->i_blkbits;
+	inode->i_blocks = round_up(i_size_read(inode), sbi->cluster_size) >>
+				inode->i_blkbits;
 	EXFAT_I(inode)->i_pos = ((loff_t)sbi->root_dir << 32) | 0xffffffff;
 	EXFAT_I(inode)->i_size_aligned = i_size_read(inode);
 	EXFAT_I(inode)->i_size_ondisk = i_size_read(inode);
-- 
2.33.0

