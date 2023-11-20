Return-Path: <linux-fsdevel+bounces-3269-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62CF07F211E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Nov 2023 00:01:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D4A11C211C9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 23:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0035E3AC0A;
	Mon, 20 Nov 2023 23:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73CFBC1
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Nov 2023 15:01:06 -0800 (PST)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-6bd00edc63fso7680685b3a.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Nov 2023 15:01:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700521266; x=1701126066;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pUHvZqUtxIelqOkhWJ/rNyIb+FyfEgnajsCDcd1770s=;
        b=V9V28qC/PbyacIK+nQ5gT9+9fgd3rmuFpR283tnP1l6vydI6Bn1g6RpVnvf8dpqebG
         7q0pF2vrJQygjsl+FlDzbMMUNK8baEDnSQYvag9zwzzCKF/p8JDx7H2SRf7PybsDQPZv
         zkdWlgu+aBD8AXSOWvYTZnO7SYaJn0A3XxXsziobArdyHiKWmJ+UZLHRXrp3bmLb+/3A
         6UmfGL/7tSuiOlT1zvLVbRc3t54Pjhqrpo8E+c+4qLL5w1mmvWhFT0uVbGCufZh3ap8Q
         Ac+ja/mUKTJTjyjoRM9YRQFlGx39Sp7V8t7l1YaQUmMRukV3BzBjfGml81mZJ2pJjeMu
         oo4g==
X-Gm-Message-State: AOJu0YzIhL8XrL/XbtIslrS9tJHk8KlxmdjBLZ4uC8REnmdbd/GvXUI5
	ntsKkboUTCV0TDBy/P/qrUuf/opaf5IBk2S7u/bkU+gmcycv
X-Google-Smtp-Source: AGHT+IFsaThVJyrbPxGaoq/F9sa+Xu+ULx9VWg5KB5Glx02QEN86inWnAmqiO01cPY08/Uhz2336VuPkShrD6jBlKUSQfiVxsIQf
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:aa7:8115:0:b0:693:3851:bd82 with SMTP id
 b21-20020aa78115000000b006933851bd82mr2186063pfi.2.1700521266007; Mon, 20 Nov
 2023 15:01:06 -0800 (PST)
Date: Mon, 20 Nov 2023 15:01:05 -0800
In-Reply-To: <00000000000040e14205ffbf333f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fe54ea060a9d752c@google.com>
Subject: Re: [syzbot] [ntfs3?] WARNING in wnd_add_free_ext (2)
From: syzbot <syzbot+5b2f934f08ab03d473ff@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ntfs3@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 4ad5c924df6cd6d85708fa23f9d9a2b78a2e428e
Author: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Date:   Fri Sep 22 10:07:59 2023 +0000

    fs/ntfs3: Allow repeated call to ntfs3_put_sbi

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15283368e80000
start commit:   dd72f9c7e512 Merge tag 'spi-fix-v6-6-rc4' of git://git.ker..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=4471dbb58008c9f2
dashboard link: https://syzkaller.appspot.com/bug?extid=5b2f934f08ab03d473ff
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15665425680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1618cd9d680000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs/ntfs3: Allow repeated call to ntfs3_put_sbi

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

