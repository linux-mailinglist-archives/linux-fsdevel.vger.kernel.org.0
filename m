Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44894411263
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Sep 2021 11:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232938AbhITJ7B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Sep 2021 05:59:01 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:50207 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231929AbhITJ7A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Sep 2021 05:59:00 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 20DA43202562;
        Mon, 20 Sep 2021 05:57:33 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 20 Sep 2021 05:57:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canishe.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm3; bh=fzxVNUji38DpJbP6LjRwH3G943
        FyfuC6dm8NxaQ7CXA=; b=KpbGNuGooDlzxeMYo2QgK+Ds6KK5thKZRPtuRYXxtM
        q2cJZIflym5vw1DFtN588N+EzO7aBbcrtbH6eWO7DpE59YQNkw+AKRiZUFak6HuA
        FMfJs0gdVfYKuUoGhf3jeEiWxqQFhQ6/G3ojcd4CYWruWFvv5OkbJapBxkbEqPR5
        5DiUHp/2tLX7dnr8yFCNWmmKC0P/ki/ZwhKsyEw0VB/uBsqjk5yAJ43c+l9kh66F
        I5k51PNJ9iFlMwX8GT+L4OW0cSrrOl26cBgNjD89UkEY7/CBlfiChpn7r/lnWPGD
        8l+GBTh3b1r1oa6AaQOrkv3PqPy0xGKfr6qUIytbn1iw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=fzxVNUji38DpJbP6L
        jRwH3G943FyfuC6dm8NxaQ7CXA=; b=dicaiQtZZqj5Vcyazw643YzGUPFIynh0w
        Jp/mczHJURDKpmbwzuBKFkRmlANCfWa8cpnTCWi7KDO0JsNy6eHB8gPo0bSXL1EN
        HEy3jTL52LNps6bISoNdYhhds4h+uaJKgrMm6tdygQVawu22HyxI88snSc6iNKd4
        mlspv1vmCyMtmM/FKzQgpuCY8ii0v2IuNRPA4fkQ248yGa6zYIung0Paf8XHEweJ
        60my4ZK8rJJnXu0GBZFk++GHtvMaWlGSHgpoEW5jwbd0yUI+6e9q82FogIHF6noj
        B3LISFfgwvkJjN3L39SpSuaIOV0jSUbTOQrum8CwNyEMaq93lJ6og==
X-ME-Sender: <xms:DFtIYYfCo8zVoidJkO_c4yDftGi68IMH6WI7G6RpihKhjxnPinQQ-w>
    <xme:DFtIYaM56fCg1dutIGMl3vHn75aljoc66UFbTwi5SoB4NiN4769W9_yLOCpQx2ks3
    gfNi4YYVBW77YrZ0g>
X-ME-Received: <xmr:DFtIYZhUupAA29C0GOUkkn5TUwLEx9fSjU1DBMifLhY-ydStGDfOA1ge87XuYx--GqlzmlJapx0Kadin7dadkbToa_4S_oBgRAz2wUQtOTegRkUx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudeivddgvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefirggvlhgrnhcu
    ufhtvggvlhgvuceoghgsshestggrnhhishhhvgdrtghomheqnecuggftrfgrthhtvghrnh
    epkedujefgkedtvddttdfgvdejteelheethedukeevheefveefgedthfdtfeetgfeunecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghgsshestg
    grnhhishhhvgdrtghomh
X-ME-Proxy: <xmx:DFtIYd8AWhgbkjmSG79tGAv3diaTbQpAlTLEPTIK--mYvm-loNWDpg>
    <xmx:DFtIYUt98qYqaWyE8Daa9pZ37yAWCVp5fk_o4OC7B5EgkyeNtyqjEw>
    <xmx:DFtIYUFX2_3I-P4Ums-wd68pnwTqWHht7DyfeSyJvDwn_HnwXmh-qw>
    <xmx:DFtIYWIgqLEfu87iSkRfrt9vKd9NG_xagN_y5_yD6721MI9G0TuSNQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Sep 2021 05:57:31 -0400 (EDT)
From:   Gaelan Steele <gbs@canishe.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-man@vger.kernel.org,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, Gaelan Steele <gbs@canishe.com>
Subject: [PATCH 1/2] fs: move struct linux_dirent into headers
Date:   Mon, 20 Sep 2021 10:56:48 +0100
Message-Id: <20210920095649.28600-1-gbs@canishe.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Move the definition of linux_dirent to include/linux/dirent.h,
where the newer linux_dirent64 already lives. This is done in
preparation for moving both of these struct definitions into uapi/
so userspace code doesn't need to duplicate them.

Signed-off-by: Gaelan Steele <gbs@canishe.com>
---
 fs/readdir.c           | 8 +-------
 include/linux/dirent.h | 7 +++++++
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/fs/readdir.c b/fs/readdir.c
index 09e8ed7d4161..51890aeafc53 100644
--- a/fs/readdir.c
+++ b/fs/readdir.c
@@ -202,14 +202,8 @@ SYSCALL_DEFINE3(old_readdir, unsigned int, fd,
 
 /*
  * New, all-improved, singing, dancing, iBCS2-compliant getdents()
- * interface. 
+ * interface.
  */
-struct linux_dirent {
-	unsigned long	d_ino;
-	unsigned long	d_off;
-	unsigned short	d_reclen;
-	char		d_name[1];
-};
 
 struct getdents_callback {
 	struct dir_context ctx;
diff --git a/include/linux/dirent.h b/include/linux/dirent.h
index 99002220cd45..48e119dd3694 100644
--- a/include/linux/dirent.h
+++ b/include/linux/dirent.h
@@ -2,6 +2,13 @@
 #ifndef _LINUX_DIRENT_H
 #define _LINUX_DIRENT_H
 
+struct linux_dirent {
+	unsigned long	d_ino;
+	unsigned long	d_off;
+	unsigned short	d_reclen;
+	char		d_name[1];
+};
+
 struct linux_dirent64 {
 	u64		d_ino;
 	s64		d_off;
-- 
2.30.1 (Apple Git-130)

