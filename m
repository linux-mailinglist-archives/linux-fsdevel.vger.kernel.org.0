Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 345973E3B8D
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Aug 2021 18:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232564AbhHHQ0P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Aug 2021 12:26:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:47462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231855AbhHHQZg (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Aug 2021 12:25:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C35526108B;
        Sun,  8 Aug 2021 16:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628439916;
        bh=eQPs0LWQBuazOmvJGjLKlWpE+0zkH3dOJ2O1oXtwFzM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=rBnMdtsDqCiZ07/1G7BoaxjN9KW9K9BBqT4CeO2Jf4bRJ3o+HSXXEE/EU5Bok9tIx
         QsYTZG/e7lcYWC8p4IGZtSEuW2SyNi8HaNiv9qC0nhtB3m29MswTxgB1o7IQMepx7H
         claKQxNQrKzpLoHC5hA0Mfd60A5af//SEHJXwBfa0Rb3gd0BuhdNK6HNXXGWmhNqhy
         LM6o0H+o1weTWOlRI6iZCvyW4F5AY+xmD6EazJhHOeS5Q1N+xbHdu3jju/ycLftuTy
         XUZs6RgaRZr4mBNbUzcf2ufuuN2zKd4qy6JSnC0ll8wkEegoGKB7DkPSqrJuv/Iymn
         4zJcvXv2tH13Q==
Received: by pali.im (Postfix)
        id 841DD13DC; Sun,  8 Aug 2021 18:25:16 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     linux-fsdevel@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net, linux-cifs@vger.kernel.org,
        jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Luis de Bethencourt <luisbg@kernel.org>,
        Salah Triki <salah.triki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Kleikamp <shaggy@kernel.org>,
        Anton Altaparmakov <anton@tuxera.com>,
        Pavel Machek <pavel@ucw.cz>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>,
        Christoph Hellwig <hch@infradead.org>
Subject: [RFC PATCH 08/20] befs: Rename enum value Opt_charset to Opt_iocharset to match mount option
Date:   Sun,  8 Aug 2021 18:24:41 +0200
Message-Id: <20210808162453.1653-9-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210808162453.1653-1-pali@kernel.org>
References: <20210808162453.1653-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Mount option is named iocharset= and not charset=

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 fs/befs/linuxvfs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/befs/linuxvfs.c b/fs/befs/linuxvfs.c
index ed4d3afb8638..e071157bdaa3 100644
--- a/fs/befs/linuxvfs.c
+++ b/fs/befs/linuxvfs.c
@@ -678,13 +678,13 @@ static struct dentry *befs_get_parent(struct dentry *child)
 }
 
 enum {
-	Opt_uid, Opt_gid, Opt_charset, Opt_debug, Opt_err,
+	Opt_uid, Opt_gid, Opt_iocharset, Opt_debug, Opt_err,
 };
 
 static const match_table_t befs_tokens = {
 	{Opt_uid, "uid=%d"},
 	{Opt_gid, "gid=%d"},
-	{Opt_charset, "iocharset=%s"},
+	{Opt_iocharset, "iocharset=%s"},
 	{Opt_debug, "debug"},
 	{Opt_err, NULL}
 };
@@ -745,7 +745,7 @@ parse_options(char *options, struct befs_mount_options *opts)
 			opts->gid = gid;
 			opts->use_gid = 1;
 			break;
-		case Opt_charset:
+		case Opt_iocharset:
 			kfree(opts->iocharset);
 			opts->iocharset = match_strdup(&args[0]);
 			if (!opts->iocharset) {
-- 
2.20.1

