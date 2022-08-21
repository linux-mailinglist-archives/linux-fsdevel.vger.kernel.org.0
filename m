Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4013459B3AE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Aug 2022 14:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbiHUMLq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 21 Aug 2022 08:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiHUMLo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 21 Aug 2022 08:11:44 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE1151F2DA;
        Sun, 21 Aug 2022 05:11:43 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id g18so8529386pju.0;
        Sun, 21 Aug 2022 05:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=cgzLCp3a55Ep+0cEyKvv7krA21NYDyPYbH2CBGQzucg=;
        b=poXDkZKa0JzQnuD+BhY6e3Qpe4nDrJkPgdPTBRYH/OlRSm6eZmzE2txYKd5dKC+HBw
         DUmgcJYiQ0EZsxDNfyEKWV08OCsb882SCL7aFwQWpsotT9lwnQ5lwBu9UVBP4NiRNdDA
         Xb0HRelNBBr1KPlvYmPANAncDMlD+fmI4txdHDw/Idhg/gPI4VkQ76Bu9cVYjGvAm2Xa
         M1JRyU39Ppwq5Aowd7VMC6y3cAF+URXviAXKRbpasvcpPznqQPLu3fb+gvmQ4tRTv59r
         50yrjR//InHFuuwQlfZ5sRlEibsHohmhZxLVw5W5AMy6XjOnW70YbOnT+/n2AEbbs4L8
         wx4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=cgzLCp3a55Ep+0cEyKvv7krA21NYDyPYbH2CBGQzucg=;
        b=g8qAnPLMPhBP9M9hPPi/Ucz4RF45W/CMNN4YocMgo53jOyc//i5W3NFDmz3Gxhgg8z
         6B/qLCc8Ri4rYbGgOuV/DfoojdlmezWIiDijFa/CjmiQlG9U9/3solh46YV9a/TZF+1h
         RCw5W+uCW8FKelRqQMDKnZIS2XIhPJ4CzlCErR710KtSGzuPxeqg5xy7v7aQgQy0+r8y
         7SdJmkPD1LE1aXCAVGmPfR+SqFoVPVFtMV6ecH8ks/yr8Di8TgR5QqXC4mSfA2pIdImC
         XJ65/uTDmDU6WXHm9V+UfB1fiZtVskML58l3j7ouM6l5kb2LyWmi06Hefj9gNgbQ21+2
         0TFw==
X-Gm-Message-State: ACgBeo2Q+sJZjdbm5J6/O4y/EjUfNBUwCDiy8ETdO2U275y/IeS4zq+U
        i+soH0qul8FUcHFdehjlBzM=
X-Google-Smtp-Source: AA6agR7pAMSWL1n/638qdO1lxqloqjisDk1HkpPCyJeZIn35O3Uvx1FjH0BRNAugQBk352snoSZZ1Q==
X-Received: by 2002:a17:902:8d95:b0:172:e11e:65da with SMTP id v21-20020a1709028d9500b00172e11e65damr2698288plo.4.1661083903320;
        Sun, 21 Aug 2022 05:11:43 -0700 (PDT)
Received: from localhost ([36.112.204.208])
        by smtp.gmail.com with ESMTPSA id g2-20020a632002000000b0042988a04bfdsm5602411pgg.9.2022.08.21.05.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 05:11:42 -0700 (PDT)
From:   Hawkins Jiawei <yin31149@gmail.com>
To:     dvyukov@google.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot+2af3bc9585be7f23f290@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com, syzkaller@googlegroups.com,
        viro@zeniv.linux.org.uk, willy@infradead.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        paskripkin@gmail.com, skhan@linuxfoundation.org,
        18801353760@163.com, Hawkins Jiawei <yin31149@gmail.com>
Subject: [PATCH] fs: fix WARNING in mark_buffer_dirty (4)
Date:   Sun, 21 Aug 2022 20:10:39 +0800
Message-Id: <20220821121038.3527-1-yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CACT4Y+bUtBuhD7_BAN+NavEfhBNOavqF0CJkrZ+Gc4pYeLiy+g@mail.gmail.com>
References: <CACT4Y+bUtBuhD7_BAN+NavEfhBNOavqF0CJkrZ+Gc4pYeLiy+g@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Syzkaller reports bug as follows:
------------[ cut here ]------------
WARNING: CPU: 0 PID: 3684 at fs/buffer.c:1081 mark_buffer_dirty+0x59d/0xa20 fs/buffer.c:1081
[...]
Call Trace:
 <TASK>
 minix_put_super+0x199/0x500 fs/minix/inode.c:49
 generic_shutdown_super+0x14c/0x400 fs/super.c:462
 kill_block_super+0x97/0xf0 fs/super.c:1394
 deactivate_locked_super+0x94/0x160 fs/super.c:332
 deactivate_super+0xad/0xd0 fs/super.c:363
 cleanup_mnt+0x3a2/0x540 fs/namespace.c:1186
 task_work_run+0xdd/0x1a0 kernel/task_work.c:177
 ptrace_notify+0x114/0x140 kernel/signal.c:2353
 ptrace_report_syscall include/linux/ptrace.h:420 [inline]
 ptrace_report_syscall_exit include/linux/ptrace.h:482 [inline]
 syscall_exit_work kernel/entry/common.c:249 [inline]
 syscall_exit_to_user_mode_prepare+0x129/0x280 kernel/entry/common.c:276
 __syscall_exit_to_user_mode_work kernel/entry/common.c:281 [inline]
 syscall_exit_to_user_mode+0x9/0x50 kernel/entry/common.c:294
 do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
 [...]
 </TASK>
------------------------------------

During VFS releasing the minix's superblock, kernel will calls
sync_filesystem() to write out and wait upon all dirty data
associated with this superblock.

Yet the problem is that this write may fail, then kernel will
clear BH_Uptodate flag in superblock's struct buffer_head
in end_buffer_async_write(). When kernel returns from
sync_filesystem() and calls sop->put_super()
(which is minix_put_super()), it will triggers the warning
for struct buffer_head is not uptodate in mark_buffer_dirty().

This patch solves it by handling sync_filesystem() write error
in minix_put_super(), before calling mark_buffer_dirty()

Reported-and-tested-by: syzbot+2af3bc9585be7f23f290@syzkaller.appspotmail.com
Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
---
 fs/minix/inode.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/fs/minix/inode.c b/fs/minix/inode.c
index da8bdd1712a7..8e9a8057dcfe 100644
--- a/fs/minix/inode.c
+++ b/fs/minix/inode.c
@@ -42,17 +42,27 @@ static void minix_put_super(struct super_block *sb)
 {
 	int i;
 	struct minix_sb_info *sbi = minix_sb(sb);
+	struct buffer_head *sbh = sbi->s_sbh;
 
 	if (!sb_rdonly(sb)) {
 		if (sbi->s_version != MINIX_V3)	 /* s_state is now out from V3 sb */
 			sbi->s_ms->s_state = sbi->s_mount_state;
-		mark_buffer_dirty(sbi->s_sbh);
+
+		lock_buffer(sbh);
+		if (buffer_write_io_error(sbh)) {
+			clear_buffer_write_io_error(sbh);
+			set_buffer_uptodate(sbh);
+			printk("MINIX-fs warning: superblock detected "
+			       "previous I/O error\n");
+		}
+		mark_buffer_dirty(sbh);
+		unlock_buffer(sbh);
 	}
 	for (i = 0; i < sbi->s_imap_blocks; i++)
 		brelse(sbi->s_imap[i]);
 	for (i = 0; i < sbi->s_zmap_blocks; i++)
 		brelse(sbi->s_zmap[i]);
-	brelse (sbi->s_sbh);
+	brelse (sbh);
 	kfree(sbi->s_imap);
 	sb->s_fs_info = NULL;
 	kfree(sbi);
-- 
2.25.1

