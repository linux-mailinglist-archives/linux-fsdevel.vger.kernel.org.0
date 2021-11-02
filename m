Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 036C64437C5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Nov 2021 22:24:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbhKBV1c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Nov 2021 17:27:32 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:40533 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231240AbhKBV1b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Nov 2021 17:27:31 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 19BF13202026;
        Tue,  2 Nov 2021 17:24:56 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 02 Nov 2021 17:24:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=ygRcoHW2+9lUg
        kqJTnZh667/CKkm3ovyI7690S36gmk=; b=M7fcbJh53o0J7hn5Zo0K3X3YvUx0/
        dXQuzRCThXrHs4cdMbS5s57Dm/vM393MiEZG42ou8E5jyHK8cGRcOZSOpjKiVLUI
        I980gcwf/RAPXl4hNrfZJUF8aZ38N9MITgm0Yq98aBaZhk/daH+PvS0Wnl+LDnAd
        LoLbHkbYQjO1DkXcnykdIH4WNFuB9pw7jJbGS8JKHX6eGHkzWUtRcO5M1ciUoR7p
        q/m1yRxb6r8R7QtWGaDbuHtxVAFBeSEDeIe19aIJQ3FvpXmvXAeX99c3RDLvkgeI
        pa/m0OU+nk85Dx5h7n8raWySxik7mnr1U0hjeqfnn6Ku4fD7TChUH0qpg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=ygRcoHW2+9lUgkqJTnZh667/CKkm3ovyI7690S36gmk=; b=c4JMLzy5
        x6Aecg2gnkeCCXZQthZbLVDV66KZNwGBdEwy+JMdztG4NWpMvEl4teC2yYv23u7v
        LYry8osu78IeKd4CIDrHfqDB/SUp2WPrTUATYjsV5U5a91a/IP6oAJiUbvudwLQR
        xtn+ibV+4cb8rOBPZKazcSLK2jXfxZpEiLegJBhJlHIXjuNVPLBcSAoqg6gk1au7
        EBmTfenGeMt/4/zE+WYvjtbkxEFXr6tiIN5zLTn3OTdW9i/RluemxK34aRLg78TZ
        vc6HlnAz1EyWLuC7TVkeRzyS5mY3WqgxfqH+mOdAckeI9SBsHJy2gmVMVf5XW0Mn
        +NUdRW4A8q/Qjg==
X-ME-Sender: <xms:p6yBYSBHIW3WGJuZyKyzfb5jpLKlv6ZL6rJt9ADCjTqRriHJLh4OGA>
    <xme:p6yBYcgkiPZK7mwP3c6hMUQpugwWZvG3G2ha1BQd-0Nfmd-kE5AhGcpN6Sgd-X2pH
    8cZBIeY3qPr_oTpKQ>
X-ME-Received: <xmr:p6yBYVmxw5gxjdfL0x9OB1UWJ-4cTbtibRrVwtPUULre3L71XuNvYCS4rOv3pGuuekhK1tfO_dMm9rOVckOOpwF7Zw9nGPxjd_tAtiGn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrtddtgdduvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeevhhhrihhs
    thhophhhvgcugghuqdeurhhughhivghruceotghvuhgsrhhughhivghrsehfrghsthhmrg
    hilhdrfhhmqeenucggtffrrghtthgvrhhnpeekjeettefgieetvdekudevudduvddvueet
    lefhieevffehudfhveeutdevgfekffenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegtvhhusghruhhgihgvrhesfhgrshhtmhgrihhlrdhfmh
X-ME-Proxy: <xmx:p6yBYQzll82-1lrqeyZ9QfYhqUYPyiDwO7Vk75g_59Mo8vJOHkSMmQ>
    <xmx:p6yBYXQSyczPkH7hgNTK7KvR95VBkmDch5lHOttxRaMKiOJDuAIqAw>
    <xmx:p6yBYbavB_QJfX5KJ9SWPeryMKHQhk8az7A_GY7aPoY2cpkJny1nWw>
    <xmx:p6yBYSd68LsoVePcijvielxfNk4ps_jXbiSQoChnPqy3hMSrxCvIeQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Nov 2021 17:24:54 -0400 (EDT)
From:   Christophe Vu-Brugier <cvubrugier@fastmail.fm>
To:     linux-fsdevel@vger.kernel.org
Cc:     Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Christophe Vu-Brugier <christophe.vu-brugier@seagate.com>
Subject: [PATCH 3/4] exfat: make exfat_find_location() static
Date:   Tue,  2 Nov 2021 22:23:57 +0100
Message-Id: <20211102212358.3849-4-cvubrugier@fastmail.fm>
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
 fs/exfat/dir.c      | 4 ++--
 fs/exfat/exfat_fs.h | 2 --
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
index ac14055bf38a..68ad54113d8b 100644
--- a/fs/exfat/dir.c
+++ b/fs/exfat/dir.c
@@ -656,8 +656,8 @@ static int exfat_walk_fat_chain(struct super_block *sb,
 	return 0;
 }
 
-int exfat_find_location(struct super_block *sb, struct exfat_chain *p_dir,
-		int entry, sector_t *sector, int *offset)
+static int exfat_find_location(struct super_block *sb, struct exfat_chain *p_dir,
+			       int entry, sector_t *sector, int *offset)
 {
 	int ret;
 	unsigned int off, clu = 0;
diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index 1d6da61157c9..a8f5bc536dcf 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -459,8 +459,6 @@ int exfat_find_dir_entry(struct super_block *sb, struct exfat_inode_info *ei,
 		struct exfat_chain *p_dir, struct exfat_uni_name *p_uniname,
 		int num_entries, unsigned int type, struct exfat_hint *hint_opt);
 int exfat_alloc_new_dir(struct inode *inode, struct exfat_chain *clu);
-int exfat_find_location(struct super_block *sb, struct exfat_chain *p_dir,
-		int entry, sector_t *sector, int *offset);
 struct exfat_dentry *exfat_get_dentry(struct super_block *sb,
 		struct exfat_chain *p_dir, int entry, struct buffer_head **bh,
 		sector_t *sector);
-- 
2.20.1

