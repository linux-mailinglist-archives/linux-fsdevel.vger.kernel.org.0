Return-Path: <linux-fsdevel+bounces-4765-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2CCB8036E1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 15:35:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F419C1C20328
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 14:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD7328DD1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 14:35:28 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com [209.85.160.69])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ABE0FF
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Dec 2023 04:38:24 -0800 (PST)
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-1fb04956beeso2967520fac.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Dec 2023 04:38:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701693503; x=1702298303;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h3vC9DKCks31qlZTLEOBhiTQthQAnOeHRO8hvXnpMao=;
        b=VD3YXKkSm2w9K6Mp/71vNjIpDUECYXF6ZQCF5ftlVK67sBEL5cHI9cKSRO68zB5CZk
         teJQ98W0QQHyIRxNcjA6gOGfWGA4X56iagvPRkxTno9Hetftipv9p/QKyd0gI7PgFJth
         AymufAJlGS6DljtjWoVSob4FNfVdIeu7Sqr1LQlzATKyhraI1AWNbRFMxJ2SPBzLyBNe
         y8Ks9J82+/z8FR2SqX6rVWgwhX0JF1HtUjlBa30mx1vQ4DvYQRsQm0jnTt3qk4GS9DNn
         JiJwCuXWU0p7zQZLqqyl8iHlhAWOgGEeZpsVeWvgUCvb9oC8euYcP7qNeP7xrsZ2THII
         X5oA==
X-Gm-Message-State: AOJu0Yxvhm+D4EYhMfZzxk5oybPYk04UMVAGwTw1I+5fv685wwbpoAtl
	UA2uqlzEts1F21C06hUCtg7roMkksau5cJn9D07FfygU0+AC
X-Google-Smtp-Source: AGHT+IESeNWC3Bgx3X6azwZbL3Ppc+gmrsehq+ZGEfKcbxjlmKt1DBtS1guViyUXax/NYtTEmFF/thOINVngKT4GFkzVR9CWhWIs
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6870:d60c:b0:1fa:da34:99d9 with SMTP id
 a12-20020a056870d60c00b001fada3499d9mr2934304oaq.5.1701693503574; Mon, 04 Dec
 2023 04:38:23 -0800 (PST)
Date: Mon, 04 Dec 2023 04:38:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cc17fb060bae647b@google.com>
Subject: [syzbot] Monthly jfs report (Dec 2023)
From: syzbot <syzbot+list36f1468762da119bb5f8@syzkaller.appspotmail.com>
To: jfs-discussion@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, shaggy@kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello jfs maintainers/developers,

This is a 31-day syzbot report for the jfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/jfs

During the period, 0 new issues were detected and 0 were fixed.
In total, 41 issues are still open and 20 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  1436    Yes   general protection fault in lmLogSync (2)
                   https://syzkaller.appspot.com/bug?extid=e14b1036481911ae4d77
<2>  1187    Yes   UBSAN: array-index-out-of-bounds in xtInsert
                   https://syzkaller.appspot.com/bug?extid=55a7541cfd25df68109e
<3>  1102    Yes   kernel BUG in jfs_evict_inode
                   https://syzkaller.appspot.com/bug?extid=9c0c58ea2e4887ab502e
<4>  859     Yes   general protection fault in write_special_inodes
                   https://syzkaller.appspot.com/bug?extid=c732e285f8fc38d15916
<5>  441     Yes   kernel BUG in txUnlock
                   https://syzkaller.appspot.com/bug?extid=a63afa301d1258d09267
<6>  304     Yes   general protection fault in jfs_flush_journal
                   https://syzkaller.appspot.com/bug?extid=194bfe3476f96782c0b6
<7>  232     Yes   UBSAN: array-index-out-of-bounds in dbAllocBits
                   https://syzkaller.appspot.com/bug?extid=ae2f5a27a07ae44b0f17
<8>  219     Yes   KASAN: use-after-free Read in release_metapage
                   https://syzkaller.appspot.com/bug?extid=f1521383cec5f7baaa94
<9>  169     Yes   KASAN: null-ptr-deref Read in drop_buffers (2)
                   https://syzkaller.appspot.com/bug?extid=d285c6d0b23c6033d520
<10> 110     Yes   KASAN: use-after-free Read in diFree
                   https://syzkaller.appspot.com/bug?extid=1964c915c8c3913b3d7a

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

