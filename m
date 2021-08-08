Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 873013E3B90
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Aug 2021 18:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232575AbhHHQ0Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Aug 2021 12:26:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:47362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231770AbhHHQZf (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Aug 2021 12:25:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5809961056;
        Sun,  8 Aug 2021 16:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628439916;
        bh=fanD9czqaaMtK9UnS9fAwgRyMrmAp6yCEcGnrD3HYPw=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=GYD12yRjt7qyYUXZLq+m/e9D92tBrj/8w73BA2j6sPM90gsrq3rYf8hz1+VhXmVn9
         ch3jqNRVSQMM8lfaUtjkLOWq30d85k4djVd010BCTj/7uJ0AjtLtID+sunAi711FcY
         XThtCU7Puq8LrJxst9ACp/2vbVwsMD0GREuFvfgevfk6JL8C3BSnRJlHE920rbeGFm
         RoxW6XixLunNu0CqeOFaUhRbd0Cw2hA3UsSplBBupo/wUvrnMAP4boSbDnthPn+Yn0
         7nY2VKqHWd1oLioL09vBAvkD2h2LE03NlXWTTzmgq/o784MC6DWlkdFyC5F7iipnm4
         UbCDQFx9OOMVA==
Received: by pali.im (Postfix)
        id 18AB11430; Sun,  8 Aug 2021 18:25:16 +0200 (CEST)
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
Subject: [RFC PATCH 07/20] befs: Fix printing iocharset= mount option
Date:   Sun,  8 Aug 2021 18:24:40 +0200
Message-Id: <20210808162453.1653-8-pali@kernel.org>
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
 fs/befs/linuxvfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/befs/linuxvfs.c b/fs/befs/linuxvfs.c
index c1ba13d19024..ed4d3afb8638 100644
--- a/fs/befs/linuxvfs.c
+++ b/fs/befs/linuxvfs.c
@@ -778,7 +778,7 @@ static int befs_show_options(struct seq_file *m, struct dentry *root)
 		seq_printf(m, ",gid=%u",
 			   from_kgid_munged(&init_user_ns, opts->gid));
 	if (opts->iocharset)
-		seq_printf(m, ",charset=%s", opts->iocharset);
+		seq_printf(m, ",iocharset=%s", opts->iocharset);
 	if (opts->debug)
 		seq_puts(m, ",debug");
 	return 0;
-- 
2.20.1

