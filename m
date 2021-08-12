Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7E983EAD66
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Aug 2021 00:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238393AbhHLWwO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Aug 2021 18:52:14 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:33114 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237013AbhHLWwN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Aug 2021 18:52:13 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BF9161FF3A;
        Thu, 12 Aug 2021 22:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1628808704; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=yMjGWJMZOmKrtApgIYOF47KeiAV23NtZqDPvEm6p/Vg=;
        b=x1aZ2a2MNTYNKQqb3nVJURHIBmZz6ETb5i8qeZ918cksrKYzDU3+XBfGMJGnclztqgu5C9
        XrOY1E73GjXskk7mhzr2DVsPlbJ8KvIqz1onuDtFaDLvKR1R2HwP2uMKYYVqq1czVzjYW7
        B4v7zDn3kRNtgZ6UoNy4Yy6UX6bss1o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1628808704;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=yMjGWJMZOmKrtApgIYOF47KeiAV23NtZqDPvEm6p/Vg=;
        b=UvzNzAqGlEPHeyh94Ayh0+lzq3vP6L3LvSSN9Q7mT9g6AuNyQMNZEvTc9jfRIjQXCDLxoc
        Phq7zs08nW9vlhCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2EB6413C80;
        Thu, 12 Aug 2021 22:51:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +LdzN/6lFWFuewAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 12 Aug 2021 22:51:42 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   NeilBrown <neilb@suse.de>
Date:   Fri, 13 Aug 2021 08:46:47 +1000
Subject: [PATCH man-pages] statx.2: Add STATX_MNT_ID
To:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc:     linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Miklos Szeredi <mszeredi@redhat.com>,
        Josef Bacik <josef@toxicpanda.com>
Message-id: <162880868648.15074.7283929646453264436@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Linux 5.8 adds STATX_MNT_ID and stx_mnt_id.
Add description to statx.2

Signed-off-by: NeilBrown <neilb@suse.de>
---
 man2/statx.2 | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/man2/statx.2 b/man2/statx.2
index 9e3aeaa36fa3..c41ee45f9bc4 100644
--- a/man2/statx.2
+++ b/man2/statx.2
@@ -77,6 +77,7 @@ struct statx {
        containing the filesystem where the file resides */
     __u32 stx_dev_major;   /* Major ID */
     __u32 stx_dev_minor;   /* Minor ID */
+    __u64 stx_mnt_id;      /* Mount ID */
 };
 .EE
 .in
@@ -258,6 +259,7 @@ STATX_SIZE	Want stx_size
 STATX_BLOCKS	Want stx_blocks
 STATX_BASIC_STATS	[All of the above]
 STATX_BTIME	Want stx_btime
+STATX_MNT_ID	Want stx_mnt_id (since Linux 5.8)
 STATX_ALL	[All currently available fields]
 .TE
 .in
@@ -411,6 +413,13 @@ The device on which this file (inode) resides.
 .IR stx_rdev_major " and "  stx_rdev_minor
 The device that this file (inode) represents if the file is of block or
 character device type.
+.TP
+.I stx_mnt_id
+.\" commit fa2fcf4f1df1559a0a4ee0f46915b496cc2ebf60
+The mount ID of the mount containing the file.  This is the same number repo=
rted by
+.BR name_to_handle_at (2)
+and corresponds to the number in the first field in one of the records in
+.IR /proc/self/mountinfo .
 .PP
 For further information on the above fields, see
 .BR inode (7).
@@ -573,9 +582,11 @@ is Linux-specific.
 .BR access (2),
 .BR chmod (2),
 .BR chown (2),
+.BR name_to_handle_at (2),
 .BR readlink (2),
 .BR stat (2),
 .BR utime (2),
+.BR proc (5),
 .BR capabilities (7),
 .BR inode (7),
 .BR symlink (7)
--=20
2.32.0

