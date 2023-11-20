Return-Path: <linux-fsdevel+bounces-3178-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B12E7F0A29
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 01:46:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 241D1280C60
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 00:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0C8185E;
	Mon, 20 Nov 2023 00:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F319129
	for <linux-fsdevel@vger.kernel.org>; Sun, 19 Nov 2023 16:46:08 -0800 (PST)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-5c1b986082dso4151039a12.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 19 Nov 2023 16:46:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700441167; x=1701045967;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2txSm9UGUwpLgLdAOJ0OSwaBHLVEwFDxBDR6/HY/ML4=;
        b=DoI7FLyMnXvzHZ+k0lQx9LP2tEtGp9spwBDQBkNL8yh+AGMx+DA5lw/BYg1j9KYtZY
         rIvZcboaT7gxsGsjOGOZa2M72ZksfWLNpgpN+Ox+cHTWhnL/jbA7g4ypch2EzCjR6bQ6
         uWOJ38pgbFQwjEBzlV7G8CiYF522rjNhpW0PigpLwbbX59UxAzKMfLQjHtY3FhdqRLII
         p4LSA4xjwZnJ6DpAGKCw8MCdlxYI4jN4ucK3c4ZgEO6ExZjdLZL3UorKHBfu+AzrMyZF
         ycSpB5RB1nk9w6RoJOSOohUPEoFFkkYgDH7X2enXpDdYQ2QQ1E5thXYuhmMC3b9Xa41B
         l9tg==
X-Gm-Message-State: AOJu0YzISpHKsEZPkl4QqeROpZfVIJglQOW687SaAtrRbYusv/vHXDI5
	6vQPRYGFm68U8ho72Qa2Ea6lzuQ2eW99sL4tlAxzVq974ptt
X-Google-Smtp-Source: AGHT+IHYvIaqMCBB8Jfg4ekh+NG8JNofrsRjFclRyaEgn7EwGNfT1ENUkbiwoHBcAi9NPZcuWup9IQv6qu0HTxFbWlt4eeIz1fLE
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a65:689a:0:b0:5be:4f:8c34 with SMTP id e26-20020a65689a000000b005be004f8c34mr1288013pgt.6.1700441167626;
 Sun, 19 Nov 2023 16:46:07 -0800 (PST)
Date: Sun, 19 Nov 2023 16:46:07 -0800
In-Reply-To: <000000000000cf826706067d18fd@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c206db060a8acf37@google.com>
Subject: Re: [syzbot] [btrfs?] WARNING in btrfs_release_global_block_rsv
From: syzbot <syzbot+10e8dae9863cb83db623@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nborisov@suse.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit c18e3235646a8ba74d013067a6475c8d262d3776
Author: Josef Bacik <josef@toxicpanda.com>
Date:   Thu Dec 2 20:34:32 2021 +0000

    btrfs: reserve extra space for the free space tree

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10528fb7680000
start commit:   23dfa043f6d5 Merge tag 'i2c-for-6.7-rc2' of git://git.kern..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=12528fb7680000
console output: https://syzkaller.appspot.com/x/log.txt?x=14528fb7680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d05dd66e2eb2c872
dashboard link: https://syzkaller.appspot.com/bug?extid=10e8dae9863cb83db623
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17722e24e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11201350e80000

Reported-by: syzbot+10e8dae9863cb83db623@syzkaller.appspotmail.com
Fixes: c18e3235646a ("btrfs: reserve extra space for the free space tree")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

