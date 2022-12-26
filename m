Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2352B656330
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Dec 2022 15:23:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbiLZOWs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Dec 2022 09:22:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231896AbiLZOWJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Dec 2022 09:22:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE8A2613;
        Mon, 26 Dec 2022 06:22:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 728FB60EB1;
        Mon, 26 Dec 2022 14:22:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B26BEC433F0;
        Mon, 26 Dec 2022 14:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672064527;
        bh=7z2lZ+Be7RkuOUgzW/6Khhu+Fp4b8cIx0oWTtjIwGLE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=pW2+TFrbcj9Y/de7k5L+kL7JaFTjxs8ZabMRJesm96TzLOlfKyD2ZU68GdwWD8OXT
         /MkTbPYx6x8/RdXTBHi3KPZQxXa8UGIALdcDx5R4UUCAIeGxc5H3qa0eefxO9C/Jd9
         p6VIQ9PDX11m451GS7nAbpjNoq02pEoNbs7obTnCtto51IJC/LsXKGSoIa/p3oigPD
         SLjqwoOadzlBmO6fGa6k6SBurFCHiz+fFOrARIv28c5D32lF8h6Tan2asFNhWWAZmq
         GN/kH9H2zR240mg+LXhnncrZFZ0qrN76B7p4mgr/FFafhpqv3pN5093qKOle7exmNL
         rLQ12nQGwmE7g==
Received: by pali.im (Postfix)
        id 6D4ED9D7; Mon, 26 Dec 2022 15:22:07 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     linux-fsdevel@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net, linux-cifs@vger.kernel.org,
        jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>, "Theodore Y . Ts'o" <tytso@mit.edu>,
        Anton Altaparmakov <anton@tuxera.com>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Luis de Bethencourt <luisbg@kernel.org>,
        Salah Triki <salah.triki@gmail.com>,
        Steve French <sfrench@samba.org>, Paulo Alcantara <pc@cjr.nz>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>, Dave Kleikamp <shaggy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pavel Machek <pavel@ucw.cz>,
        Christoph Hellwig <hch@infradead.org>,
        Kari Argillander <kari.argillander@gmail.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [RFC PATCH v2 06/18] befs: Rename enum value Opt_charset to Opt_iocharset to match mount option
Date:   Mon, 26 Dec 2022 15:21:38 +0100
Message-Id: <20221226142150.13324-7-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221226142150.13324-1-pali@kernel.org>
References: <20221226142150.13324-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Mount option is named iocharset= and not charset=

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 fs/befs/linuxvfs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/befs/linuxvfs.c b/fs/befs/linuxvfs.c
index f983852ba863..5c66550f7933 100644
--- a/fs/befs/linuxvfs.c
+++ b/fs/befs/linuxvfs.c
@@ -677,13 +677,13 @@ static struct dentry *befs_get_parent(struct dentry *child)
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
@@ -744,7 +744,7 @@ parse_options(char *options, struct befs_mount_options *opts)
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

