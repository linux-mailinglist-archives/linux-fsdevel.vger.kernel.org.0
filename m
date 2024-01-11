Return-Path: <linux-fsdevel+bounces-7804-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0CD82B30F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jan 2024 17:35:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 447241C24509
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jan 2024 16:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB6BA51C26;
	Thu, 11 Jan 2024 16:35:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B91C50278
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Jan 2024 16:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7bb454e1d63so600008439f.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Jan 2024 08:35:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704990905; x=1705595705;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dRdbg5bSi7lKyoJs10oddtkV1hHDIPE09w+ZHa9TK2o=;
        b=Jk61HTHkv5IzdpCKc0RbzcH3NfICo7oirhc9RcbWoFFOR/mrcRBkS8G+ddI/Mh4850
         lB9hIFEcP+t2oI0edn7no8uucq3ni1wnkebyrZdK1zvaxCMggLK27DUg8ZS0t0I80MGK
         bJri0xJ1MDJ7VzACLmtAUjfrPzQkm6xdVNrc2yO1KtuaFOhjaN06SKlyi0gKKWJabDUo
         1089K2s3k9oBpFWlgmXAFcZv0NDJux8Q89gAxk+ywdmL1oPV0H1xjZAoiiWDzjQoCmJH
         hQMPN9GaKyOD9RvpSYzDrANfNj42HNZ1fNT39CKjcr+PJRddPD8L0LApPOFhYhZ4m7kf
         XrhA==
X-Gm-Message-State: AOJu0YzyKJGzJnOpX+3ffjJv13mVnC0S9fleNCk6fO/SwM2Juk/vohGP
	D3lMdbUJbA46k1MmDbbol7LW7HbmbqmQcuhxU6hRtugj8p1Z
X-Google-Smtp-Source: AGHT+IGwHN3+9mhxqEczRA6+EUJO9zR3XYbmE69dyD0qqqrQxkSeSFNA5XswVXDEJOVLzjxw2f035QHlP7vp+LF1ntwpbkf1mErY
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4117:b0:46e:5d08:e499 with SMTP id
 ay23-20020a056638411700b0046e5d08e499mr3756jab.0.1704990904159; Thu, 11 Jan
 2024 08:35:04 -0800 (PST)
Date: Thu, 11 Jan 2024 08:35:04 -0800
In-Reply-To: <000000000000a4a46106002c5e42@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000301d7e060eae2133@google.com>
Subject: Re: [syzbot] [bpf?] [reiserfs?] WARNING: locking bug in corrupted (2)
From: syzbot <syzbot+3779764ddb7a3e19437f@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, axboe@kernel.dk, bpf@vger.kernel.org, 
	brauner@kernel.org, daniel@iogearbox.net, davem@davemloft.net, 
	haoluo@google.com, hawk@kernel.org, jack@suse.cz, john.fastabend@gmail.com, 
	jolsa@kernel.org, kpsingh@kernel.org, kuba@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, luto@kernel.org, 
	martin.lau@linux.dev, netdev@vger.kernel.org, peterz@infradead.org, 
	reiserfs-devel@vger.kernel.org, sdf@google.com, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de, tintinm2017@gmail.com, 
	yhs@fb.com, yukuai3@huawei.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=120430a5e80000
start commit:   c17414a273b8 Merge tag 'sh-for-v6.5-tag1' of git://git.ker..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=7ad417033279f15a
dashboard link: https://syzkaller.appspot.com/bug?extid=3779764ddb7a3e19437f
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12bbd544a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13fd50b0a80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

